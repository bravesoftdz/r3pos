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
    dllLoaded: boolean;
    dllValid: boolean;
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
  dllLoaded := false;
  dllValid := false;

  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  CodePrinterHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if CodePrinterHandle = 0 then Exit;
  dllLoaded := true;
  
  @CodePrinterOpenPort := GetProcAddress(CodePrinterHandle, 'openport');
  if @CodePrinterOpenPort = nil then Exit;

  @CodePrinterClosePort := GetProcAddress(CodePrinterHandle, 'closeport');
  if @CodePrinterClosePort = nil then Exit;

  @CodePrinterSendCommand := GetProcAddress(CodePrinterHandle, 'sendcommand');
  if @CodePrinterSendCommand = nil then Exit;

  @CodePrinterSetup := GetProcAddress(CodePrinterHandle, 'setup');
  if @CodePrinterSetup = nil then Exit;

  @CodePrinterClearBuffer := GetProcAddress(CodePrinterHandle, 'clearbuffer');
  if @CodePrinterClearBuffer = nil then Exit;

  @CodePrinterPrintLabel := GetProcAddress(CodePrinterHandle, 'printlabel');
  if @CodePrinterPrintLabel = nil then Exit;

  @CodePrinterWindowsFont := GetProcAddress(CodePrinterHandle, 'windowsfont');
  if @CodePrinterWindowsFont = nil then Exit;

  dllValid := true;
end;

procedure TCodePrinterFactory.FreeCodePrinterFactory;
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  if not dllLoaded then Exit;
  dllLoaded := false;
  dllValid := false;
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

  if not dllValid then Exit;

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
     LinkMan := 'δ֪';

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

          if gs.Locate('GODS_ID',GodsId,[]) then // ֻ��ӡ������Ʒ
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

          for i:=1 to Trunc(Amt) do //������������
            begin
              ClearBuffer;
              WindowsFont(85,  4, 14, 0, 0, 0, 'Arial', '����:'+ShopName);
              WindowsFont(85, 24, 14, 0, 0, 0, 'Arial', '����:'+GodsName);
              WindowsFont(85, 44, 14, 0, 0, 0, 'Arial', '�۸�:'+FormatFloat('#0.00',Aprice)+'Ԫ');
              WindowsFont(85, 64, 14, 0, 0, 0, 'Arial', 'ʱ��:'+FormatDateTime('YYYY��MM��DD��HH��NN��',printTime));
              SendCommand('DMATRIX 27,13,40,40,x2.5,26,26,"'+EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'"');
              PrintLabel('1', '1');
            end;

          if (Amt - Trunc(Amt)) <> 0 then //����С������
            begin
              if unitId = gs.FieldByName('CALC_UNITS').AsString then
                begin
                  MessageBox(FHandle,pchar('��'+IntToStr(SeqNo)+'����Ʒ��'+GodsName+'������������Ч������'),'������ʾ..',MB_OK);
                end
              else
                begin
                  Amt := (Amt - Trunc(Amt)) * UnitRate;
                  for i:=1 to Trunc(Amt) do
                    begin
                      ClearBuffer;
                      WindowsFont(85,  4, 14, 0, 0, 0, 'Arial', '����:'+ShopName);
                      WindowsFont(85, 24, 14, 0, 0, 0, 'Arial', '����:'+GodsName);
                      WindowsFont(85, 44, 14, 0, 0, 0, 'Arial', '�۸�:'+FormatFloat('#0.00',Aprice/UnitRate)+'Ԫ');
                      WindowsFont(85, 64, 14, 0, 0, 0, 'Arial', 'ʱ��:'+FormatDateTime('YYYY��MM��DD��HH��NN��',printTime));
                      SendCommand('DMATRIX 27,13,40,40,x2.5,26,26,"'+EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice/UnitRate)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'"');
                      PrintLabel('1', '1');
                    end;
                  if (Amt - Trunc(Amt)) <> 0 then MessageBox(FHandle,pchar('��'+IntToStr(SeqNo)+'����Ʒ��'+GodsName+'������������Ч������'),'������ʾ..',MB_OK);
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
