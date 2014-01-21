unit uPlayerFactory;

interface

uses Windows,SysUtils,Dialogs,ShellAPI,IniFiles,Classes,ZDataSet;

const
  dllname = 'DViewControlDll.dll';
  success = 0;
type

TPlayerOpen = function:integer;stdcall;
TPlayerClose = function:integer;stdcall;
TPlayerIsOpen = function:integer;stdcall;
TPlayerRefresh = function:integer;stdcall;
TPlayerShow = function(text:pchar):integer;stdcall;
TPlayerEncode = function(filename:pchar):integer;stdcall;
TPlayerJsCall = function(webBrowserId:integer;src:pchar):integer;stdcall;
TPlayerSetFocusHwnd = function(hwndFocus:integer):integer;stdcall;

TPlayerFactory=class
  private
    dllLoaded: boolean;
    dllValid: boolean;
    DownPicUrl:string;
  protected
    PlayerHandle: THandle;
    PlayerOpen: TPlayerOpen;
    PlayerClose: TPlayerClose;
    PlayerIsOpen: TPlayerIsOpen;
    PlayerRefresh: TPlayerRefresh;
    PlayerShow: TPlayerShow;
    PlayerEncode: TPlayerEncode;
    PlayerJsCall: TPlayerJsCall;
    PlayerSetFocusHwnd: TPlayerSetFocusHwnd;
    procedure LoadPlayerFactory;
    procedure FreePlayerFactory;
  public
    constructor Create;
    destructor Destroy;override;
    function OpenPlayer: boolean;
    function ClosePlayer: boolean;
    //--山东接口
    function ShowText(text: string): boolean;
    function HideText: boolean;
    function EncodeFile(filename: string): boolean;
    //--贵州接口
    function AddCgtPic(path:string): boolean;
    function ShowCgtPic(barcode:string): boolean;
    function CallJs(webBrowserId:integer;src:string): boolean;
    function ShowGodsInfo(godsName,aprice,totalFee:string): boolean;
    function ShowOddChange(totalFee,realPay,oddChange:string): boolean;
    function ResetScreen: boolean;
    function TimerResetScreen: boolean;
    function SetCustomerInfo(cardNo,name,priceName,inte:string): boolean;
    function ResetCustomer: boolean;
    function ResetCgtPic: boolean;
    function SetFocusHwnd(hwndFocus:HWND): boolean;
  end;

var PlayerFactory: TPlayerFactory;

implementation

uses udllGlobal,uTokenFactory,udataFactory,dllApi;

constructor TPlayerFactory.Create;
begin
  LoadPlayerFactory;
end;

destructor TPlayerFactory.Destroy;
begin
  FreePlayerFactory;
  inherited;
end;

procedure TPlayerFactory.LoadPlayerFactory;
begin
  dllLoaded := false;
  dllValid := false;

  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  PlayerHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if PlayerHandle = 0 then Exit;
  dllLoaded := true;
  
  @PlayerIsOpen := GetProcAddress(PlayerHandle, 'DV_IsOpen');
  if @PlayerIsOpen = nil then Exit;

  @PlayerOpen := GetProcAddress(PlayerHandle, 'DV_Open');
  if @PlayerOpen = nil then Exit;

  @PlayerClose := GetProcAddress(PlayerHandle, 'DV_Close');
  if @PlayerClose = nil then Exit;

  @PlayerRefresh := GetProcAddress(PlayerHandle, 'DV_LoadConfig');

  @PlayerShow := GetProcAddress(PlayerHandle, 'DV_ShowText');

  @PlayerEncode := GetProcAddress(PlayerHandle, 'DV_Encode');

  @PlayerJsCall := GetProcAddress(PlayerHandle, 'DV_JSCall');

  @PlayerSetFocusHwnd := GetProcAddress(PlayerHandle, 'DV_SetFocusHwnd');

  dllValid := true;
end;

procedure TPlayerFactory.FreePlayerFactory;
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  if not dllLoaded then Exit;
  dllLoaded := false;
  dllValid := false;
  FreeLibrary(PlayerHandle);
end;

function TPlayerFactory.OpenPlayer: boolean;
var
  rs:TZQuery;
  rimUrl,comId,custId:string;
begin
  if dllGlobal.GetDoubleScreen = '2' then
     begin
       rimUrl := dllGlobal.GetRimUrl;
       if FileExists(ExtractFilePath(ParamStr(0)) + 'down.exe') then
          begin
            rs := TZQuery.Create(nil);
            try
              try
                rs.SQL.Text := 'select COM_ID,CUST_ID from RM_CUST a,CA_SHOP_INFO b where a.LICENSE_CODE = b.LICENSE_CODE and b.SHOP_ID = :SHOP_ID';
                rs.ParamByName('SHOP_ID').AsString := token.shopId;
                dataFactory.MoveToRemote;
                try
                  dataFactory.Open(rs);
                finally
                  dataFactory.MoveToDefault;
                end;
                if not rs.IsEmpty then
                   begin
                     comId := rs.FieldByName('COM_ID').AsString;
                     custId := rs.FieldByName('CUST_ID').AsString;
                   end;
              except
              end;
            finally
              rs.Free;
            end;
            ShellExecute(dllApplication.handle,'open',pchar('down.exe'),
                         pchar(rimUrl + ' ' +
                               rimUrl + 'attchRequest.action?comId='+comId+'&custId='+custId+'&date='+formatDatetime('YYYYMMDD', now()) + ' ' +
                               '0'),
                         nil,SW_SHOWNORMAL);
          end;
     end;
end;

function TPlayerFactory.ClosePlayer: boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  if dllGlobal.GetDoubleScreen = '0' then Exit; 
  if PlayerIsOpen <> success then //未打开
    result := true
  else
    begin
      code := PlayerClose;
      result := (code = success);
    end;
end;

function TPlayerFactory.ShowText(text: string): boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  if PlayerIsOpen <> success then //未打开
    result := false
  else
    begin
      code := PlayerShow(pchar(text));
      result := (code = success);
    end
end;

function TPlayerFactory.HideText: boolean;
var
  code:integer;
begin
  result := ShowText('');
end;

function TPlayerFactory.EncodeFile(filename: string): boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  code := PlayerEncode(pchar(filename));
  result := (code = success);
end;

function TPlayerFactory.CallJs(webBrowserId: integer; src: string): boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  code := PlayerJsCall(webBrowserId,pchar(src));
  result := (code = success);
end;

function TPlayerFactory.AddCgtPic(path: string): boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  result := CallJs(3, pchar('showCgtPic('''+path+''')'));
end;

function TPlayerFactory.ShowCgtPic(barcode: string): boolean;
var
  w:integer;
  F:TIniFile;
  List:TStringList;
begin
  if trim(DownPicUrl) = '' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
       List := TStringList.Create;
       try
         DownPicUrl := F.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
         if DownPicUrl = '' then Exit;
         List.CommaText := DownPicUrl;
         DownPicUrl := List.Values['xsm'];
         w := pos('xsm_r3', DownPicUrl);
         if w > 0 then
            begin
              delete(DownPicUrl, w, 255);
            end;
       finally
         List.free;
         try
           F.Free;
         except
         end;
       end;
     end;
  result := AddCgtPic(DownPicUrl + 'resource/ec/cgtpic/' + barcode + '_middle_face.png');
end;

function TPlayerFactory.ShowGodsInfo(godsName, aprice, totalFee: string): boolean;
var
  s:string;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  godsName := ''''+godsName+'''';
  aprice := ''''+aprice+'''';
  totalFee := ''''+totalFee+'''';
  s := godsName + ',' + aprice + ',' + totalFee;
  result := CallJs(2, pchar('showCgtInfo('+s+')'));
end;

function TPlayerFactory.ResetScreen: boolean;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  result := CallJs(2, pchar('loadDefault()')) and CallJs(3, pchar('loadDefault()'));
end;

function TPlayerFactory.TimerResetScreen: boolean;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  result := CallJs(2, pchar('timerDefault()')) and CallJs(3, pchar('loadDefault()'));
end;

function TPlayerFactory.ShowOddChange(totalFee, realPay, oddChange: string): boolean;
var
  s:string;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  totalFee := ''''+totalFee+'''';
  realPay := ''''+realPay+'''';
  oddChange := ''''+oddChange+'''';
  s := totalFee + ',' + realPay + ',' + oddChange;
  result := CallJs(2, pchar('showOddChange('+s+')'));
end;

function TPlayerFactory.SetCustomerInfo(cardNo, name, priceName, inte: string): boolean;
var
  s:string;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  cardNo := ''''+cardNo+'''';
  name := ''''+name+'''';
  priceName := ''''+priceName+'''';
  inte := ''''+inte+'''';
  s := cardNo + ',' + name + ',' + priceName + ',' + inte;
  result := CallJs(1, pchar('setCustomerInfo('+s+')'));
end;

function TPlayerFactory.ResetCustomer: boolean;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  result := CallJs(1, pchar('loadDefault()'));
end;

function TPlayerFactory.SetFocusHwnd(hwndFocus: HWND): boolean;
var
  code:integer;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  code := PlayerSetFocusHwnd(hwndFocus);
  result := (code = success);
end;

function TPlayerFactory.ResetCgtPic: boolean;
begin
  if not dllValid then
    begin
      result := false;
      Exit;
    end;
  result := CallJs(3, pchar('loadDefault()'));
end;

initialization
  PlayerFactory := TPlayerFactory.Create;
finalization
  if Assigned(PlayerFactory) then FreeAndNil(PlayerFactory);
end.
