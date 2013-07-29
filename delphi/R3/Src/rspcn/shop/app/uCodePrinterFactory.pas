unit uCodePrinterFactory;

interface

uses Windows,SysUtils,math,ZDataSet;

const
  dllname = 'TSCLIB.dll';
  success = 1;

type

TCodePrinterOpenPort = function(CodePrinterName: pchar):integer;stdcall;
TCodePrinterClosePort = function():integer;stdcall;
TCodePrinterSendCommand = function(Command: pchar):integer;stdcall;
TCodePrinterSetup = function(LabelWidth,LabelHeight,Speed,Density,Sensor,Vertical,Offset: pchar):integer;stdcall;
TCodePrinterClearBuffer = function():integer;stdcall;
TCodePrinterPrintLabel = function(NumberOfSet,NumberOfCopoy: pchar):integer;stdcall;
TCodePrinterWindowsFont = function(X,Y,FontHeight,Rotation,FontStyle,FontUnderline: integer;FaceName,TextContect: pchar):integer;stdcall;

TCodePrinterFactory=class
  private
    Loaded: boolean;
  protected
    CodePrinterHandle: THandle;
    CodePrinterOpenPort: TCodePrinterOpenPort;
    CodePrinterClosePort: TCodePrinterClosePort;
    CodePrinterSendCommand: TCodePrinterSendCommand;
    CodePrinterSetup: TCodePrinterSetup;
    CodePrinterClearBuffer: TCodePrinterClearBuffer;
    CodePrinterPrintLabel: TCodePrinterPrintLabel;
    CodePrinterWindowsFont: TCodePrinterWindowsFont;
    procedure LoadCodePrinterFactory;
    procedure FreeCodePrinterFactory;
  public
    constructor Create;
    destructor Destroy;override;
    function OpenPort(CodePrinterName: string): boolean;
    function ClosePort: boolean;
    function Setup(LabelWidth,LabelHeight,Speed,Density,Sensor,Vertical,Offset: string): boolean;
    function ClearBuffer: boolean;
    function WindowsFont(X,Y,FontHeight,Rotation,FontStyle,FontUnderline: integer;FaceName,TextContect: string): boolean;
    function SendCommand(Command: string): boolean;
    function PrintLabel(NumberOfSet,NumberOfCopoy: string): boolean;
    function PrintCode(data: OleVariant; FHandle:HWnd): boolean;
    function GetUnitRate(GodsId,UnitId: string):Currency;
  end;

var CodePrinterFactory: TCodePrinterFactory;

implementation

uses udllGlobal,udataFactory,uTokenFactory,ObjCommon,EncDec;

constructor TCodePrinterFactory.Create;
begin
  LoadCodePrinterFactory;
end;

destructor TCodePrinterFactory.Destroy;
begin
  FreeCodePrinterFactory;
  inherited;
end;

procedure TCodePrinterFactory.LoadCodePrinterFactory;
begin
  Loaded := false;
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  CodePrinterHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if CodePrinterHandle = 0 then Exit;
  Loaded := true;
  
  @CodePrinterOpenPort := GetProcAddress(CodePrinterHandle, 'openport');
  if @CodePrinterOpenPort = nil then Raise Exception.Create('无效打印机插件，没有实现openport方法');

  @CodePrinterClosePort := GetProcAddress(CodePrinterHandle, 'closeport');
  if @CodePrinterClosePort = nil then Raise Exception.Create('无效打印机插件，没有实现closeport方法');

  @CodePrinterSendCommand := GetProcAddress(CodePrinterHandle, 'sendcommand');
  if @CodePrinterSendCommand = nil then Raise Exception.Create('无效打印机插件，没有实现sendcommand方法');

  @CodePrinterSetup := GetProcAddress(CodePrinterHandle, 'setup');
  if @CodePrinterSetup = nil then Raise Exception.Create('无效打印机插件，没有实现setup方法');

  @CodePrinterClearBuffer := GetProcAddress(CodePrinterHandle, 'clearbuffer');
  if @CodePrinterClearBuffer = nil then Raise Exception.Create('无效打印机插件，没有实现clearbuffer方法');

  @CodePrinterPrintLabel := GetProcAddress(CodePrinterHandle, 'printlabel');
  if @CodePrinterPrintLabel = nil then Raise Exception.Create('无效打印机插件，没有实现printlabel方法');

  @CodePrinterWindowsFont := GetProcAddress(CodePrinterHandle, 'windowsfont');
  if @CodePrinterWindowsFont = nil then Raise Exception.Create('无效打印机插件，没有实现windowsfont方法');
end;

procedure TCodePrinterFactory.FreeCodePrinterFactory;
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  FreeLibrary(CodePrinterHandle);
end;

function TCodePrinterFactory.OpenPort(CodePrinterName: string):boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterOpenPort(pchar(CodePrinterName));
  result := (code = success);
end;

function TCodePrinterFactory.ClosePort: boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterClosePort;
  result := (code = success);
end;

function TCodePrinterFactory.Setup(LabelWidth,LabelHeight,Speed,Density,Sensor,Vertical,Offset: string):boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterSetup(pchar(LabelWidth),pchar(LabelHeight),pchar(Speed),pchar(Density),pchar(Sensor),pchar(Vertical),pchar(Offset));
  result := (code = success);
end;

function TCodePrinterFactory.ClearBuffer:boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterClearBuffer;
  result := (code = success);
end;

function TCodePrinterFactory.WindowsFont(X,Y,FontHeight,Rotation,FontStyle,FontUnderline: integer;FaceName,TextContect: string):boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterWindowsFont(X,Y,FontHeight,Rotation,FontStyle,FontUnderline,pchar(FaceName),pchar(TextContect));
  result := (code = success);
end;

function TCodePrinterFactory.SendCommand(Command: string):boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterSendCommand(pchar(Command));
  result := (code = success);
end;

function TCodePrinterFactory.PrintLabel(NumberOfSet,NumberOfCopoy: string):boolean;
var code: integer;
begin
  result := false;
  code := CodePrinterPrintLabel(pchar(NumberOfSet),pchar(NumberOfCopoy));
  result := (code = success);
end;

function TCodePrinterFactory.PrintCode(data: OleVariant; FHandle:HWnd): boolean;
var
  printTime: TDateTime;
  rs,cs,ss,gs: TZQuery;
  LinkMan,ShopName,LicenseCode,GodsId,GodsName,BarCode,UnitId: string;
  Aprice,Amt,UnitRate: Currency;
  i,SeqNo: integer;
begin
  result := false;

  if not Loaded then Exit;

  cs := dllGlobal.GetZQueryFromName('CA_TENANT');
  ss := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  gs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

  if ss.RecordCount > 1 then
     ShopName := token.shopName
  else
     ShopName := cs.FieldByName('SHORT_TENANT_NAME').AsString;

  if ss.Locate('SHOP_ID',token.shopId,[]) then
     LinkMan := ss.FieldByName('LINKMAN').AsString
  else
     LinkMan := '未知';

  LicenseCode := ss.FieldByName('LICENSE_CODE').AsString;

  rs := TZQuery.Create(nil);
  try
    rs.Data := data;
    printTime := now();
    if OpenPort('USB') then
    if Setup('40', '10', '1', '15', '0', '2', '0') then
    begin
      rs.First;
      while not rs.Eof do
        begin
          SeqNo := rs.FieldByName('SEQNO').AsInteger;
          GodsId := rs.FieldByName('GODS_ID').AsString;
          GodsName := rs.FieldByName('GODS_NAME').AsString;
          UnitId := rs.FieldByName('UNIT_ID').AsString;
          Aprice := rs.FieldByName('APRICE').AsFloat;
          BarCode := rs.FieldByName('BARCODE').AsString;
          Amt := rs.FieldByName('AMOUNT').AsFloat;
          UnitRate := GetUnitRate(GodsId,UnitId);

          if gs.Locate('GODS_ID',GodsId,[]) then // 只打印卷烟商品
            begin
              if gs.FieldByName('RELATION_ID').AsInteger <> 1000006 then
                begin
                  rs.Next;
                  continue;
                end;
            end
          else
            begin
              rs.Next;
              continue;
            end;

          for i:=1 to Trunc(Amt) do //处理整数部分
            begin
              ClearBuffer;
              WindowsFont(75,  8, 14, 0, 0, 0, 'Arial', '店名:'+ShopName);
              WindowsFont(75, 28, 14, 0, 0, 0, 'Arial', '卷烟:'+GodsName);
              WindowsFont(75, 48, 14, 0, 0, 0, 'Arial', '价格:'+FormatFloat('#0.00',Aprice)+'元');
              WindowsFont(75, 68, 14, 0, 0, 0, 'Arial', '时间:'+FormatDateTime('YYYY年MM月DD日HH点NN分',printTime));
              SendCommand('DMATRIX 17,17,40,40,x2.5,26,26,"'+EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'"');
              PrintLabel('1', '1');
            end;

          if (Amt - Trunc(Amt)) <> 0 then //处理小数部分
            begin
              if unitId = gs.FieldByName('CALC_UNITS').AsString then
                begin
                  MessageBox(FHandle,pchar('第'+IntToStr(SeqNo)+'行商品【'+GodsName+'】数量不是有效数量！'),'友情提示..',MB_OK);
                end
              else
                begin
                  Amt := (Amt - Trunc(Amt)) * UnitRate;
                  for i:=1 to Trunc(Amt) do
                    begin
                      ClearBuffer;
                      WindowsFont(75,  8, 14, 0, 0, 0, 'Arial', '店名:'+ShopName);
                      WindowsFont(75, 28, 14, 0, 0, 0, 'Arial', '卷烟:'+GodsName);
                      WindowsFont(75, 48, 14, 0, 0, 0, 'Arial', '价格:'+FormatFloat('#0.00',Aprice/UnitRate)+'元');
                      WindowsFont(75, 68, 14, 0, 0, 0, 'Arial', '时间:'+FormatDateTime('YYYY年MM月DD日HH点NN分',printTime));
                      SendCommand('DMATRIX 17,17,40,40,x2.5,26,26,"'+EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice/UnitRate)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'"');
                      PrintLabel('1', '1');
                    end;
                  if (Amt - Trunc(Amt)) <> 0 then MessageBox(FHandle,pchar('第'+IntToStr(SeqNo)+'行商品【'+GodsName+'】数量不是有效数量！'),'友情提示..',MB_OK);
                end;
            end;
          rs.Next;
        end;
      ClosePort;
      result := true;
    end;
  finally
    rs.Free;
  end;
end;

function TCodePrinterFactory.GetUnitRate(GodsId,UnitId: string):Currency;
var
  rs: TZQuery;
  SourceScale: Currency;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  SourceScale := 1;
  if rs.Locate('GODS_ID',GodsId,[]) then
    begin
      if unitId = rs.FieldByName('CALC_UNITS').AsString then
        begin
          SourceScale := 1;
        end
      else
      if unitId = rs.FieldByName('BIG_UNITS').AsString then
        begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
        end
      else
      if unitId = rs.FieldByName('SMALL_UNITS').AsString then
        begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
        end
      else
        begin
          SourceScale := 1;
        end;
    end;
  result := SourceScale;
end;

initialization
  CodePrinterFactory := TCodePrinterFactory.Create;
finalization
  if Assigned(CodePrinterFactory) then FreeAndNil(CodePrinterFactory);
end.
