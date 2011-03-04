unit uDevFactory;

interface
uses Windows,Classes,spComm,SysUtils;
type
TDevFactory=class
  private
    FPrepared: Boolean;
    FDisplayComm: Integer;
    FScanComm: Integer;
    FComm:TComm;
    FScanBaudRate: Integer;
    FDisplayBaudRate: Integer;
    FCashBox: Integer;
    FCashComm: TComm;
    FCashBoxRate: Integer;
    FLPT: integer;
    FLPTType: integer;
    FSavePrint: Boolean;
    FFooter: string;
    FTicketPrintName: integer;
    FTitle: string;
    procedure SetPrepared(const Value: Boolean);
    procedure SetDisplayComm(const Value: Integer);
    procedure SetScanComm(const Value: Integer);


    procedure OpenDisplayComm;
    procedure CloseComm;
    procedure OpenCashBoxComm;
    procedure SetDisplayBaudRate(const Value: Integer);
    procedure SetScanBaudRate(const Value: Integer);
    procedure SetCashBox(const Value: Integer);
    procedure SetLPT(const Value: integer);
    procedure SetLPTType(const Value: integer);
    procedure SetSavePrint(const Value: Boolean);
    procedure SetFooter(const Value: string);
    procedure SetTicketPrintName(const Value: integer);
    procedure SetTitle(const Value: string);
  protected
  public
    F:TextFile;

    constructor Create;
    destructor Destroy; override;
    procedure InitComm;

    Class procedure OpenCashBox;
    Class procedure ShowAPrice(Value:Real); //单价
    Class procedure ShowAMoney(Value:Real); //收款
    Class procedure ShowATotal(Value:Real); //总计
    Class procedure ShowDibs(Value:Real);   //找零
    //打印函数
    procedure BeginPrint;
    procedure WritePrint(s:string);
    procedure EndPrint;

    function ReadDefine(Define:string;Def:string=''):string;

    procedure Clear;
    procedure SetLEDType(Value:Integer);
    procedure SetLEDNumber(Value:Real);
    property Prepared:Boolean read FPrepared write SetPrepared;
    property DisplayComm:Integer read FDisplayComm write SetDisplayComm;
    property ScanComm:Integer read FScanComm write SetScanComm;
    property DisplayBaudRate:Integer read FDisplayBaudRate write SetDisplayBaudRate;
    property CashBoxRate:Integer read FCashBoxRate write FCashBoxRate;
    property ScanBaudRate:Integer read FScanBaudRate write SetScanBaudRate;

    property CashBox:Integer read FCashBox write SetCashBox;

    property Comm:TComm read FComm;
    property CashComm:TComm read FCashComm;
    property LPT:integer read FLPT write SetLPT;
    //打印类型 1 LPT打印，2 Windows驱动打印
    property LPTType:integer read FLPTType write SetLPTType;
    // 保存时是否打印小票
    property SavePrint:Boolean read FSavePrint write SetSavePrint;
    property TicketPrintName:integer read FTicketPrintName write SetTicketPrintName;
    // 不票打印说明
    property Footer:string read FFooter write SetFooter;
    // 小票票题
    property Title:string read FTitle write SetTitle;

end;
var
  DevFactory:TDevFactory;
implementation
uses IniFiles,EncDec,Forms;
{ TDevFactory }

procedure TDevFactory.BeginPrint;
begin
//  if LPT<1 then Raise Exception.Create('没有安装小票打印机不能打小票');
//  AssignFile(DevFactory.F,'LPT'+inttostr(DevFactory.LPT));
  AssignFile(F,ExtractFilePath(ParamStr(0))+'debug\prt.txt');
  rewrite(F);
end;

procedure TDevFactory.Clear;
var S:string;
begin
  if not DevFactory.Prepared then Exit;
  S:=Chr(12);
  FComm.WriteCommData(Pchar(S),Length(Pchar(S))) ;
end;

procedure TDevFactory.CloseComm;
begin
  FComm.StopComm;
end;

constructor TDevFactory.Create;
begin
  inherited;
  FComm := TComm.Create(nil);
end;

destructor TDevFactory.Destroy;
begin
  FComm.StopComm;
  FComm.Free;
  inherited;
end;

procedure TDevFactory.EndPrint;
begin
  CloseFile(F);
end;

procedure TDevFactory.InitComm;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
  try
     footer := DecStr(F.ReadString('SYS_DEFINE','FOOTER',EncStr('敬请保留小票,以作售后依据',ENC_KEY)),ENC_KEY);
     title := DecStr(F.ReadString('SYS_DEFINE','TITLE',EncStr('[门店名称]',ENC_KEY)),ENC_KEY);
     SavePrint := F.ReadString('SYS_DEFINE','SAVEPRINT','0')='1';
     ScanComm := F.ReadInteger('SYS_DEFINE','ScanCOMM',0);
     DisplayComm := F.ReadInteger('SYS_DEFINE','BUYERDISPLAY',0);
     ScanBaudRate := F.ReadInteger('SYS_DEFINE','ScanBaudRate',9600);
     DisplayBaudRate := F.ReadInteger('SYS_DEFINE','DISPLAYBAUDRATE',9600);
     CashBox := F.ReadInteger('SYS_DEFINE','CashBox',0);
     CashBoxRate := F.ReadInteger('SYS_DEFINE','CASHBOXRATE',9600);
     Lpt := F.ReadInteger('SYS_DEFINE','PRINTERCOMM',1);
     LPTType := F.ReadInteger('SYS_DEFINE','PRINT_TYPE',1);
     TicketPrintName := F.ReadInteger('SYS_DEFINE','TICKET_PRINT_NAME',0);
//     if Lpt=0 then Lpt := 1;
  finally
     F.Free;
  end;
end;

class procedure TDevFactory.OpenCashBox;
var F:TextFile;
    S:string;
begin
  if DevFactory.CashBox=0 then Exit;
  if DevFactory.LPT<=0 then Exit;
  if DevFactory.CashBox=1 then
     begin
        AssignFile(F,'LPT'+inttostr(DevFactory.LPT));
        Rewrite(F);
        try
          Write(F,CHR(27)+'p'+CHR(0)+CHR(60)+CHR(255));
        finally
          CloseFile(F);
        end;
     end;
  if DevFactory.CashBox>=2 then
     begin
        DevFactory.OpenCashBoxComm;
     end;
end;

procedure TDevFactory.OpenCashBoxComm;
var S:string;
begin
  try
     if CashBox<=1 then Exit;
     FComm.StopComm;
     FComm.CommName := 'COM'+Inttostr(CashBox-1);
     FComm.BaudRate := CashBoxRate;
     FComm.StartComm;
     S:=CHR(27)+'p'+CHR(0)+CHR(60)+CHR(255);
     FComm.WriteCommData(Pchar(S),Length(S)) ;
  except
     MessageBox(Application.Handle,Pchar('打开钱箱'+FComm.CommName+'端口出错,是否正确设置参数？'),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

procedure TDevFactory.OpenDisplayComm;
var S:string;
begin
  try
    if DisplayComm<=0 then Exit;
    FComm.StopComm;
    FComm.CommName := 'COM'+Inttostr(DisplayComm);
    FComm.BaudRate := DisplayBaudRate;
    FComm.StartComm;
    S:=Chr(27)+Chr(64);
    FComm.WriteCommData(Pchar(S),Length(S)) ;
  except
    MessageBox(Application.Handle,Pchar('打开顾客显示屏'+FComm.CommName+'端口出错,是否正确设置参数？'),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

function TDevFactory.ReadDefine(Define: string;Def:string=''): string;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
  try
    result := F.ReadString('SYS_DEFINE',Define,Def);
  finally
    F.Free;
  end;
end;

procedure TDevFactory.SetCashBox(const Value: Integer);
begin
  FCashBox := Value;
end;

procedure TDevFactory.SetDisplayBaudRate(const Value: Integer);
begin
  FDisplayBaudRate := Value;
end;

procedure TDevFactory.SetDisplayComm(const Value: Integer);
begin
  FDisplayComm := Value;
end;

procedure TDevFactory.SetFooter(const Value: string);
begin
  FFooter := Value;
end;

procedure TDevFactory.SetLEDNumber(Value: Real);
var S:string;
begin
  if DisplayComm<=0 then Exit;
  FComm.StopComm;
  FComm.CommName := 'COM'+Inttostr(DisplayComm);
  FComm.BaudRate := DisplayBaudRate;
  FComm.StartComm;
  S:=Chr(27)+Chr(81)+Chr(65)+FloatToStr(Value)+Chr(13);
  FComm.WriteCommData(Pchar(S),Length(S)) ;
end;

procedure TDevFactory.SetLEDType(Value: Integer);
var S:string;
begin
  if DisplayComm<=0 then Exit;
  FComm.StopComm;
  FComm.CommName := 'COM'+Inttostr(DisplayComm);
  FComm.BaudRate := DisplayBaudRate;
  FComm.StartComm;
  S:=Chr(27)+Chr(115)+Inttostr(Value);
  FComm.WriteCommData(Pchar(S),Length(S)) ;
end;

procedure TDevFactory.SetLPT(const Value: integer);
begin
  FLPT := Value;
end;

procedure TDevFactory.SetLPTType(const Value: integer);
begin
  FLPTType := Value;
end;

procedure TDevFactory.SetPrepared(const Value: Boolean);
begin
  FPrepared := Value;
end;

procedure TDevFactory.SetSavePrint(const Value: Boolean);
begin
  FSavePrint := Value;
end;

procedure TDevFactory.SetScanBaudRate(const Value: Integer);
begin
  FScanBaudRate := Value;
end;

procedure TDevFactory.SetScanComm(const Value: Integer);
begin
  FScanComm := Value;
end;

procedure TDevFactory.SetTicketPrintName(const Value: integer);
begin
  FTicketPrintName := Value;
end;

procedure TDevFactory.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

class procedure TDevFactory.ShowAMoney(Value: Real);
begin
  DevFactory.SetLEDType(3);
  DevFactory.SetLEDNumber(Value);
end;

class procedure TDevFactory.ShowAPrice(Value: Real);
begin
  DevFactory.SetLEDType(1);
  DevFactory.SetLEDNumber(Value);
end;

class procedure TDevFactory.ShowATotal(Value: Real);
begin
  DevFactory.SetLEDType(2);
  DevFactory.SetLEDNumber(Value);
end;

class procedure TDevFactory.ShowDibs(Value: Real);
begin
  DevFactory.SetLEDType(4);
  DevFactory.SetLEDNumber(Value);
end;

procedure TDevFactory.WritePrint(s: string);
begin
  Writeln(F,s);
end;

initialization
  DevFactory := TDevFactory.Create;
  DevFactory.InitComm;
finalization
  DevFactory.Free;
end.

