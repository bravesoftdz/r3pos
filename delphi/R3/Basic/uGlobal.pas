unit uGlobal;

interface
  //***************说明****************************************//
  //  当数据集的Tag >0 时，系统为初妈化COMMANDTEXT             //
  //                       但不打开数据集                      //
  //  读取访问数据集时如果数据集处于关闭状态，系统自动OPEN     //
  //***********************************************************//
uses
  Windows,SysUtils, Classes,DB,ZdbFactory,ActnList,Controls,Graphics,jpeg,ZBase,ZDataSet;

type
  TGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FInstallDir: string;
    FDataDir: string;
    FSysDate: TDate;
    FRoles: string;
    FAccountName: string;
    FUserID:string;
    FUserName:string;
    FIsAxCall: Boolean;
    Fupgrade: boolean;
    FTENANT_ID: integer;
    FTENANT_NAME: string;
    FSHOP_ID: string;
    FSHOP_NAME: string;
    FSHORT_TENANT_NAME: string;
    { Private declarations }
    function  GetUserID: string;
    function  GetUserName: string;
    procedure SetUserID(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetDataDir(const Value: string);
    procedure SetInstallDir(const Value: string);
    //临公文包数据集存放路径
    property  DataDir:string read FDataDir write SetDataDir;
    procedure SetSysDate(const Value: TDate);
    procedure SetRoles(const Value: string);
    procedure SetAccountName(const Value: string);
    procedure SetIsAxCall(const Value: Boolean);
    procedure Setupgrade(const Value: boolean);
    procedure SetTENANT_ID(const Value: integer);
    procedure SetSHORT_TENANT_NAME(const Value: string);
  protected
    function GetSysDate: TDate;virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegSvr32(FileName:string);

    procedure GlobalAtteProc(ClassName:string;pTag:Integer;Var IsTrue:Boolean);virtual;
    function  GlobalAtteExts(AtteID:string):String;virtual;

    //用于打开基础资料。
    procedure LoadBasic(Saveed:Boolean=false;Opened:Boolean=true;Logoed:boolean=true);virtual;

    function GetSrvDateTime:TDatetime;

    Function  RefreshTable(Name:String):Boolean;
    procedure CloseAll;

    function DataSetByName(Name:string):TDataSet;

    function GetZQueryFromName(Name:string):TZQuery;

    //用户Acount
    property UserID:string read GetUserID write SetUserID;
    //用户名user_name
    property UserName:string read GetUserName write SetUserName;
    //企业编号    
    property TENANT_ID:integer read FTENANT_ID write SetTENANT_ID;
    //企业名称
    property TENANT_NAME:string read FTENANT_NAME write FTENANT_NAME;
    //企业简称
    property SHORT_TENANT_NAME:string read FSHORT_TENANT_NAME write SetSHORT_TENANT_NAME;
    //门店代码
    property SHOP_ID:string read FSHOP_ID write FSHOP_ID;
    //门店名称
    property SHOP_NAME:string read FSHOP_NAME write FSHOP_NAME;
    //职务代码 多个由","号分隔
    property Roles:string read FRoles write SetRoles;

    //系统EXE文件安装路径，注路径最后是带 '\'的;
    property InstallPath:string read FInstallDir write SetInstallDir;
    property SysDate:TDate read GetSysDate write SetSysDate;
    //当前登录帐套名
    property AccountName:string read FAccountName write SetAccountName;
    property IsAxCall:Boolean read FIsAxCall write SetIsAxCall;
    property upgrade:boolean read Fupgrade write Setupgrade;
    { Public declarations }
  end;
  
function CopyScreen(SaveAndFree:Boolean=True): TBitmap;
Var Global:TGlobal;//全局公共基础数据模块
    Factor:TdbFactory;//数据库连接代理对象
    sysLogFile:Boolean;
    lckStr:string;
implementation
uses ufrmLogo,Forms;
{$R *.dfm}
var
  whKeyboard: HHook;
  MsgString:string;

procedure SetPath;
var
  cur_path:string;
  lib_path:string;
begin
  cur_path:=GetEnvironmentVariable('path');
  Lib_path := ExtractFilePath(Application.ExeName);
  cur_path := cur_path +';'+ Lib_path;
  SetEnvironmentVariable('path',pchar(cur_path));
end;
function GetModuleHandleFromInstance: THandle;
var
  s: array[0..512] of char;
begin
  GetModuleFileName(hInstance, s, sizeof(s) - 1);
  Result := GetModuleHandle(s);
end;
function CopyScreen(SaveAndFree:Boolean=True): TBitmap;
var
   winHWND, hCur:integer;
   winDC:integer;
   rect:TRect;
   pt:TPoint;
   fBitmap:TBitmap;
   FileName:string;
   jpg:TJpegImage;
//   sm:TMemoryStream;
begin
   if MsgString<>'' then Exit;
   Result := nil;
   hCur := GetCursor(); // 获 得 光 标 句 柄
   GetCursorPos(pt); // 记 录 光 标 位 置
   winHWND := GetDesktopWindow();
   winDC := GetDC(winHWND);
   GetWindowRect(winHWND, rect);
   fBitmap := TBitmap.create;
   fBitmap.width := rect.right-rect.left;
   fBitmap.height := rect.bottom-rect.top;
   BitBlt(fBitmap.canvas.handle, 0, 0, fBitmap.width, fBitmap.height, winDC, 0, 0, SRCCOPY);
   DrawIcon(fBitmap.canvas.handle, pt.x, pt.y, hCur); // 画 光 标
   ReleaseDC(winHWND, winDC);
   Result := fBitmap;
   if SaveAndFree then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName)+'Error');
        FileName := ExtractFilePath(Application.ExeName)+'Error\E'+FormatDatetime('YYYYMMDD_HHNNSS',Now())+'.jpg';
        try
          jpg := TJpegImage.Create;
          //sm  := TMemoryStream.Create;
          try
            //sm.Position := 0;
            //Result.SaveToStream(sm);
            //sm.Position := 0;
            jpg.CompressionQuality := 80;
            jpg.Assign(Result);
            //jpg.LoadFromStream(sm);
            jpg.SaveToFile(FileName);
          finally
            //sm.Free;
            jpg.Free;
          end;
        except
          Result.Free;
          MsgString := '保存屏幕到'+FileName+'失败，请清理磁盘文件后再试。';
          Application.MessageBox(Pchar(MsgString),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
          MsgString := '';
          Exit;
        end;
        Result.Free;
        MsgString := '保存屏幕到'+FileName+'成功。';
        Application.MessageBox(Pchar(MsgString),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
        MsgString := '';
      end;
end;

{$IFDEF WIN32}

function KeyboardHookCallBack(Code: integer; Msg: WPARAM;
  KeyboardHook: LPARAM): LRESULT; stdcall;
{$ELSE}

function KeyboardHookCallBack(Code: integer; Msg: word;
  KeyboardHook: longint): longint; export;
{$ENDIF}
const LLKHF_ALTDOWN = $20;
begin
  Result := 0;
  if Code<0 then
  begin
    Result:=CallNextHookEx(0, Code, Msg, KeyboardHook);
    Exit;
  end;

  if ((GetKeyState(VK_CONTROL) and $8000) <> 0) and ((GetKeyState(VK_SHIFT) and $8000) <> 0) and ((Msg = ORD('P')) or (Msg = ORD('p'))) then
     begin
       Result := 1;
       CopyScreen(True);
       Exit;
     end;
  
  if Code >= 0 then
     Result := CallNextHookEx(whKeyboard, Code, Msg, KeyboardHook);
end;

constructor TGlobal.Create(AOwner: TComponent);
begin
  inherited;
  upgrade := false;
  FSysDate := 0;
  whKeyboard := SetWindowsHookEx(WH_KEYBOARD, KeyboardHookCallBack,
    GetModuleHandleFromInstance,
  GetCurrentThreadID);
  SetPath;
  IsAxCall := false;
end;

destructor TGlobal.Destroy;
begin
  UnhookWindowsHookEx(whKeyboard);


  inherited;
end;

procedure TGlobal.LoadBasic(Saveed:Boolean=false;Opened:Boolean=true;Logoed:boolean=true);
var i:Integer;
    S,SQL:String;
    Logo:TfrmLogo;
begin
  Logo := TfrmLogo.Create(Self);
  try
  if Logoed then
    begin
     Logo.Show;
     Logo.Update;
    end;
  S := '正在初始化基础资料....';
  for i:=0 to ComponentCount -1 do
    begin
      Logo.ShowPostion(i*100 DIV ComponentCount,S);
      if Components[i] Is TZQuery then
         begin
           Sleep(0);
           TZQuery(Components[i]).Close;
           if TZQuery(Components[i]).Params.FindParam('SHOP_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('SHOP_ID').AsString := SHOP_ID;
           if TZQuery(Components[i]).Params.FindParam('SHOP_ID_ROOT')<>nil then
              TZQuery(Components[i]).Params.FindParam('SHOP_ID_ROOT').AsString := inttostr(TENANT_ID)+'0001';
           if TZQuery(Components[i]).Params.FindParam('TENANT_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('TENANT_ID').AsInteger := TENANT_ID;
           if TZQuery(Components[i]).Params.FindParam('USER_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('USER_ID').AsString := UserId;
           if Components[i].Tag >0 then Continue;
           if Factor.Connected then
              begin
                if Opened then
                   begin
                     Factor.Open(TZQuery(Components[i]));
                   end;
              end
           else
              Raise Exception.Create('没有打开数据库连接。');
         end;
    end;
  finally
    Logo.Free;
  end;
end;

function TGlobal.RefreshTable(Name: String): Boolean;
var
  i:Integer;
  SQL:string;
begin
  Result := False;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
         begin
          if  (Components[i] Is TZQuery) and TZQuery(Components[i]).Active then
             begin
               Sleep(0);
               if TZQuery(Components[i]).SQL.Text ='' then
                  Raise Exception.CreateFmt('%s的SQL不能为空。',[TZQuery(Components[i]).Name]);
               TZQuery(Components[i]).Close;
               if Factor.Connected then
                  begin
                    Factor.Open(TZQuery(Components[i]));
                  end;
             end;
          exit;
         end;
    end;
  Raise Exception.CreateFmt('%s数据表没找到。',[Name]);
end;

procedure TGlobal.DataModuleCreate(Sender: TObject);
begin
  InstallPath := ExtractFilePath(Application.ExeName);
  DataDir    := 'temp';
  if not DirectoryExists(InstallPath+DataDir) then
     CreateDir(InstallPath+DataDir);
  Global := Self;
  SysDate := Date();
end;

{ TAtteCenter }

function TGlobal.GetUserID: string;
begin
 Result:= FUserID;

end;

function TGlobal.GetUserName: string;
begin
 Result:= FUserName;
end;

procedure TGlobal.SetUserID(const Value: string);
begin
  FUserID := Value;
end;

procedure TGlobal.SetUserName(const Value: string);
begin
  FUserName := Value;

end;

function TGlobal.DataSetByName(Name: string): TDataSet;
var i:Integer;
begin
  Result := nil;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
          begin
            Result := TDataSet(Components[i]);
            Exit;
          end;
    end;
end;

procedure TGlobal.SetDataDir(const Value: string);
begin
  FDataDir := Value;
end;

procedure TGlobal.SetInstallDir(const Value: string);
begin
  FInstallDir := Value;
end;

procedure TGlobal.SetSysDate(const Value: TDate);
begin
  FSysDate := Value;
end;


procedure TGlobal.SetRoles(const Value: string);
begin
  FRoles := Value;
end;

procedure TGlobal.SetAccountName(const Value: string);
begin
  FAccountName := Value;
end;


procedure TGlobal.GlobalAtteProc(ClassName: string; pTag: Integer;
  var IsTrue: Boolean);
begin
  IsTrue := True;
end;

function TGlobal.GlobalAtteExts(AtteID: string): String;
begin
  Result := '';
end;

procedure TGlobal.CloseAll;
var i:Integer;
begin
  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] Is TDataSet then
         TDataSet(Components[i]).Close;
    end;
end;
function TGlobal.GetSrvDateTime: TDatetime;
var Temp:TZQuery;
  s:string;
begin
  Temp := TZQuery.Create(nil);
  try
    case Factor.iDbType of
    0:Temp.SQL.Text :='select GetDate() ';
    1:Temp.SQL.Text := 'select SysDate from Dual';
    3:Temp.SQL.Text :='select Date() ';
    5:Temp.SQL.Text :='select Date() ';
    end;
    Factor.Open(Temp);
    s := formatDatetime('YYYYMMDD',Temp.Fields[0].AsDateTime);

    result := EncodeDate(StrtoInt(copy(s,1,4)),StrtoInt(copy(s,5,2)),StrtoInt(copy(s,7,2)));
  finally
    Temp.Free;
  end;
end;

function TGlobal.GetSysDate: TDate;
begin
  if FSysDate = 0 then
     result := Date()
  else
     result := FSysDate;
end;

procedure TGlobal.RegSvr32(FileName: string);
var
  dllHandle:THandle;
  RegisterServer:function(): HResult; stdcall;
begin
  if not FileExists(FileName) then Exit;
  dllHandle := LoadLibrary(Pchar(FileName));
  try
  if dllHandle>0 then
     begin
       @RegisterServer := GetProcAddress(dllHandle, 'DllRegisterServer');
       if @RegisterServer<>nil then
          if RegisterServer<>S_OK then
             begin
               MessageBox(Application.Handle,Pchar('注册'+FileName+'失注，错误:'+Inttostr(GetLastError)+';可能有部份功能无法使用'),'友情提示...',MB_OK+MB_ICONINFORMATION);
             end;
     end;
  finally
     FreeLibrary(dllHandle);
  end;
end;

procedure TGlobal.SetIsAxCall(const Value: Boolean);
begin
  FIsAxCall := Value;
end;

procedure TGlobal.Setupgrade(const Value: boolean);
begin
  Fupgrade := Value;
end;

function TGlobal.GetZQueryFromName(Name: string): TZQuery;
begin
  Result := TZQuery(DataSetByName(Name));
  if Result = nil then
     Raise Exception.CreateFmt('%s数据表没找到。',[Name]);
  if not Result.Active then
     begin
       if TZQuery(Result).Params.FindParam('SHOP_ID')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID').AsString := SHOP_ID;
       if TZQuery(Result).Params.FindParam('SHOP_ID_ROOT')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID_ROOT').AsString := inttostr(TENANT_ID)+'0001';
       if TZQuery(Result).Params.FindParam('TENANT_ID')<>nil then
          TZQuery(Result).Params.FindParam('TENANT_ID').AsInteger := TENANT_ID;
       if TZQuery(Result).Params.FindParam('USER_ID')<>nil then
          TZQuery(Result).Params.FindParam('USER_ID').AsString := UserId;
       Factor.Open(Result);
     end;
  if Result.Filtered then Result.Filtered := false;
end;

procedure TGlobal.SetTENANT_ID(const Value: integer);
begin
  FTENANT_ID := Value;
end;

procedure TGlobal.SetSHORT_TENANT_NAME(const Value: string);
begin
  FSHORT_TENANT_NAME := Value;
end;

initialization
  Factor := TdbFactory.Create;
  Global := nil;
  sysLogFile := true;
finalization
  if Factor<>nil then Factor.Free;
end.
