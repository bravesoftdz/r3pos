unit uDevFactory;

interface

uses Windows,Classes,spComm,SysUtils,zPrinters,ZDataSet,DB;

type

  TDevFactory=class
  private
    FComm:TComm;

    CashBoxStart:Int64;
    FCashBox: integer;
    FCashComm: TComm;
    FCashBoxRate: integer;

    FTicket_PrintComm:integer;
    FTicket_Width: integer;
    FTicket_Title: string;
    FTicket_Footer: string;
    FTicket_NullRow: integer;
    FTicket_Copy: integer;    
    FTicket_PrintName: integer;

    procedure SetTicket_PrintComm(const Value: integer);
    procedure SetTicket_Width(const Value: integer);
    procedure SetTicket_Title(const Value: string);
    procedure SetTicket_Footer(const Value: string);
    procedure SetTicket_NullRow(const Value: integer);
    procedure SetTicket_Copy(const Value: integer);
    procedure SetTicket_PrintName(const Value: integer);

    procedure SetCashBox(const Value: integer);
    procedure SetCashBoxRate(const Value: integer);

    function  GetTitle: string;
  private
    procedure BeginPrint;
    procedure WritePrint(s:string);
    procedure WritePrintNoEnter(s:string);
    procedure EndPrint;
    function  EncodeDivStr:string;
    function  PrintSaleTicketSQL(tenantId,id:string):string;

    procedure OpenCashBoxComm;
  public
    F:TextFile;

    constructor Create;
    destructor  Destroy; override;
    procedure   InitComm;

    class procedure OpenCashBox;
    procedure PrintSaleTicket(tid, sid: string; iFlag: integer; cash, dibs: Currency);

    property Ticket_PrintComm:integer read FTicket_PrintComm write SetTicket_PrintComm;
    property Ticket_Width:integer read FTicket_Width write SetTicket_Width;
    property Ticket_Title:string read FTicket_Title write SetTicket_Title;
    property Ticket_Footer:string read FTicket_Footer write SetTicket_Footer;
    property Ticket_NullRow:integer read FTicket_NullRow write SetTicket_NullRow;
    property Ticket_Copy:integer read FTicket_Copy write SetTicket_Copy;
    property Ticket_PrintName:integer read FTicket_PrintName write SetTicket_PrintName;

    property CashComm:TComm read FCashComm;
    property CashBox:integer read FCashBox write SetCashBox;
    property CashBoxRate:integer read FCashBoxRate write SetCashBoxRate;

    property Comm:TComm read FComm;
end;

var DevFactory:TDevFactory;

implementation

uses IniFiles,EncDec,Forms,uTokenFactory,udllGlobal,udataFactory;

constructor TDevFactory.Create;
begin
  FComm := TComm.Create(nil);
end;

destructor TDevFactory.Destroy;
begin
  inherited;
  FComm.StopComm;
  FComm.Free;
end;

procedure TDevFactory.InitComm;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'dev.fty');
  try
     CashBox := F.ReadInteger('SYS_DEFINE','CashBox',0);
     CashBoxRate := F.ReadInteger('SYS_DEFINE','CASHBOXRATE',9600);

     Ticket_PrintName := F.ReadInteger('SYS_DEFINE','TICKET_PRINT_NAME',0);
     Ticket_PrintComm := F.ReadInteger('SYS_DEFINE','PRINTERCOMM',1);
     Ticket_Width := F.ReadInteger('SYS_DEFINE','PRINTERWIDTH',33)-3;
     Ticket_Footer := DecStr(F.ReadString('SYS_DEFINE','FOOTER',EncStr('敬请保留小票,以作售后依据',ENC_KEY)),ENC_KEY);
     Ticket_Title := DecStr(F.ReadString('SYS_DEFINE','TITLE',EncStr('[门店名称]',ENC_KEY)),ENC_KEY);
     Ticket_NullRow :=  F.ReadInteger('SYS_DEFINE','PRINTNULL',0);
     Ticket_Copy := F.ReadInteger('SYS_DEFINE','TICKETCOPY',1);
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TDevFactory.SetCashBox(const Value: integer);
begin
  FCashBox := Value;
end;

procedure TDevFactory.SetCashBoxRate(const Value: integer);
begin
  FCashBoxRate := Value;
end;

procedure TDevFactory.SetTicket_Copy(const Value: integer);
begin
  FTicket_Copy := Value;
end;

procedure TDevFactory.SetTicket_Footer(const Value: string);
begin
  FTicket_Footer := Value;
end;

procedure TDevFactory.SetTicket_NullRow(const Value: integer);
begin
  FTicket_NullRow := Value;
end;

procedure TDevFactory.SetTicket_PrintComm(const Value: integer);
begin
  FTicket_PrintComm := Value;
end;

procedure TDevFactory.SetTicket_PrintName(const Value: integer);
begin
  FTicket_PrintName := Value;
end;

procedure TDevFactory.SetTicket_Title(const Value: string);
begin
  FTicket_Title := Value;
end;

procedure TDevFactory.SetTicket_Width(const Value: integer);
begin
  FTicket_Width := Value;
end;

function TDevFactory.GetTitle: string;
var s:string;
begin
  s := StringReplace(DevFactory.FTicket_Title,'[门店名称]',token.shopName,[rfReplaceAll]);
  s := StringReplace(DevFactory.FTicket_Title,'[企业名称]',token.tenantName,[rfReplaceAll]);
  s := StringReplace(DevFactory.FTicket_Title,'[企业简称]',token.shopName,[rfReplaceAll]);
  if s='' then s := token.tenantName;
  result := s;
end;

procedure TDevFactory.PrintSaleTicket(tid, sid: string; iFlag: integer; cash, dibs: Currency);
var PWidth:integer;
  procedure WriteAndEnter(s:string;Len:Integer=0);
  begin
    DevFactory.WritePrint(s);
  end;

  function FormatString(s:string;pWidth:Integer):string;
  var i:Integer;
  begin
    result := '';
    for i:=1 to (pWidth - Length(s)) do result := ' '+result;
    result := result + s;
  end;

  function FormatText(s:string;pWidth:Integer):string;
  var i:Integer;
  begin
    result := '';
    for i:=1 to (pWidth - Length(s)) do result := result +' ';
    result := s+ result ;
  end;

  procedure WirteGodsAndEnter(mc:string;sl,dj,je,org:string);
  var s,vmc:string;
      n,l:integer;
  begin
    s := '';
    if strtofloat(org)<>strtofloat(dj) then
       begin
         if length(org)>=5 then s :=s + ' '+FormatString(org,5)
         else s :=s + FormatString(Org,5);
       end;
    if length(dj)>=5 then
       s := s+' '+dj
    else
       s := s+FormatString(dj,5);
    if length(sl)>=5 then
       s := s+' '+sl
    else
       s := s+FormatString(sl,5);
    if length(je)>=6 then s :=s + ' '+FormatString(je,6)
    else s := s+FormatString(je,6);
    vmc := StringReplace(mc,'（','(',[rfReplaceAll]);
    vmc := StringReplace(vmc,'）',')',[rfReplaceAll]);
    vmc := StringReplace(vmc,'，',',',[rfReplaceAll]);
    vmc := StringReplace(vmc,'。','.',[rfReplaceAll]);
    vmc := StringReplace(vmc,'：',':',[rfReplaceAll]);
    vmc := StringReplace(vmc,'；',';',[rfReplaceAll]);
    vmc := StringReplace(vmc,'！','!',[rfReplaceAll]);

    n := Length(s); //数字长度
    l := Length(vmc);//品名称长度
    if (n+l+1)>PWidth then
       begin
         WriteAndEnter(vmc);
         WriteAndEnter(FormatString('',PWidth-n-1)+s);
       end
    else
       begin
         WriteAndEnter(FormatText(vmc,PWidth-n-1)+s);
       end;
  end;

  function FormatTitle(s:string):string;
  var i:Integer;
      n:integer;
  begin
    n := (PWidth - length(s)) div 2;
    result := '';
    for i:=1 to n do result := result + ' ';
        result := result + s;
    end;

  function GetPayText(id:string):string;
  var rs:TZQuery;
  begin
    rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
    if rs.Locate('CODE_ID',id,[]) then
       result := rs.FieldbyName('CODE_NAME').AsString
    else
       result := 'id';
    if length(result)<5 then result := result + '支付';
  end;

  function GetTicketGodsName(DataSet:TDataSet):string;
  begin
    case DevFactory.Ticket_PrintName of
      0:result := DataSet.FieldbyName('GODS_NAME').AsString;
      1:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString;
      2:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString;
      3:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
      4:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
      5:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
      else result := DataSet.FieldbyName('GODS_NAME').AsString;
    end;
  end;
var
  allAmt:real;
  i:Integer;
  s:string;
  total:Currency;
  rs:TZQuery;
  ls:TStringList;
  printOrgPrice:boolean;
begin
  if DevFactory.Ticket_PrintComm <= 0 then Exit;

  PWidth := DevFactory.Ticket_Width;

  allAmt:=0;
  DevFactory.BeginPrint;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := PrintSaleTicketSql(tid,sid);
    dataFactory.Open(rs);
    if iFlag < 0 then WriteAndEnter(FormatTitle('--整单删除--'));
    WriteAndEnter(FormatTitle(DevFactory.GetTitle));
    WriteAndEnter('日期:'+FormatFloat('0000-00-00',rs.FieldbyName('SALES_DATE').AsFloat)+' '+Copy(rs.FieldbyName('CREA_DATE').AsString,12,5));
    WriteAndEnter('门店:'+rs.FieldbyName('SHOP_NAME').AsString);
    WriteAndEnter('单号:'+rs.FieldbyName('GLIDE_NO').AsString);
    if rs.FieldbyName('CLIENT_CODE').AsString <>'' then
       WriteAndEnter('客户:'+rs.FieldbyName('CLIENT_CODE').AsString+'('+rs.FieldbyName('CLIENT_NAME').AsString+')');
    WriteAndEnter('收银员:'+rs.FieldbyName('CREA_USER_TEXT').AsString+'  导购员:'+rs.FieldbyName('GUIDE_USER_TEXT').AsString);
    WriteAndEnter(DevFactory.EncodeDivStr);
    printOrgPrice := false;
    rs.First;
    while not rs.Eof do
      begin
        if rs.FieldbyName('APRICE').AsFloat <> rs.FieldbyName('ORG_PRICE').AsFloat then
           begin
             printOrgPrice := true;
             break;
           end;
        rs.Next;
      end;
    if PWidth=30 then
       begin
         if printOrgPrice then
            WriteAndEnter('商品     原价 单价 数量  金额')
         else
            WriteAndEnter('商品          单价 数量  金额');
         WriteAndEnter('-----------------------------');
       end
    else
       begin
         if printOrgPrice then
            WriteAndEnter('商品          原价 现价 数量  金额')
         else
            WriteAndEnter('商品               现价 数量  金额');
         WriteAndEnter('----------------------------------');
       end;
     total := 0;
     rs.First;
     while not rs.Eof do
       begin
         if rs.FieldbyName('CALC_MONEY').AsFloat=0 then
            s := '赠'
         else
            s := rs.FieldbyName('CALC_MONEY').AsString;
         total := total + rs.FieldbyName('CALC_MONEY').AsFloat;
         allAmt:=allAmt+rs.FieldbyName('AMOUNT').AsFloat; //累计总件数
         if rs.FieldbyName('AMOUNT').AsFloat < 0 then
            WirteGodsAndEnter(GetTicketGodsName(rs)+'(退货)',rs.FieldbyName('AMOUNT').AsString+rs.FieldbyName('UNIT_NAME').AsString,rs.FieldbyName('APRICE').asString,s,rs.FieldbyName('ORG_PRICE').asString)
         else
            WirteGodsAndEnter(GetTicketGodsName(rs),rs.FieldbyName('AMOUNT').AsString+rs.FieldbyName('UNIT_NAME').AsString,rs.FieldbyName('APRICE').asString,s,rs.FieldbyName('ORG_PRICE').asString);
         rs.Next;
       end;
     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('PAY_DIBS').AsFloat<>0 then
     begin
       WriteAndEnter('件数:'+FormatFloat('#0.##',allAmt));
       WriteAndEnter('合计:'+FormatFloat('#0.0##',rs.FieldbyName('SALE_MNY').AsFloat-rs.FieldbyName('PAY_DIBS').AsFloat)+' 抹零:'+FormatFloat('#0.000',rs.FieldbyName('PAY_DIBS').AsFloat))
     end else
     begin
       WriteAndEnter('合计:'+FormatFloat('#0.0##',rs.FieldbyName('SALE_MNY').AsFloat-rs.FieldbyName('PAY_DIBS').AsFloat)+'  件数:'+FormatFloat('#0.##',allAmt));
     end;
     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('PAY_A').AsFloat <> 0 then
        WriteAndEnter(GetPayText('A')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_A').AsFloat));
     if rs.FieldbyName('PAY_B').AsFloat <> 0 then
        WriteAndEnter(GetPayText('B')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_B').AsFloat));
     if rs.FieldbyName('PAY_C').AsFloat <> 0 then
        WriteAndEnter(GetPayText('C')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_C').AsFloat));
     if rs.FieldbyName('PAY_D').AsFloat <> 0 then
        WriteAndEnter(GetPayText('D')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_D').AsFloat));
     if rs.FieldbyName('PAY_E').AsFloat <> 0 then
        WriteAndEnter(GetPayText('E')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_E').AsFloat));
     if rs.FieldbyName('PAY_F').AsFloat <> 0 then
        WriteAndEnter(GetPayText('F')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_F').AsFloat));
     if rs.FieldbyName('PAY_G').AsFloat <> 0 then
        WriteAndEnter(GetPayText('G')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_G').AsFloat));
     if rs.FieldbyName('INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('本单积分:'+rs.FieldbyName('INTEGRAL').AsString);
     if rs.FieldbyName('BARTER_INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('兑换积分:'+rs.FieldbyName('BARTER_INTEGRAL').AsString);
     if rs.FieldbyName('ACCU_INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('累计积分:'+rs.FieldbyName('ACCU_INTEGRAL').AsString);
     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('CASH_MNY').AsFloat <> 0 then
        begin
          WriteAndEnter('实收:'+FormatFloat('#0.0##',rs.FieldbyName('CASH_MNY').AsFloat)+'  找零:'+FormatFloat('#0.0##',rs.FieldbyName('PAY_ZERO').AsFloat));
          WriteAndEnter(DevFactory.EncodeDivStr);
        end;
     if DevFactory.Ticket_Footer <> '' then
        begin
          ls := TStringList.Create;
          try
            ls.Text := DevFactory.Ticket_Footer;
            for i:=0 to ls.Count -1 do
                WriteAndEnter(ls[i]);
          finally
            ls.Free;
          end;
        end;
     for i:=1 to Ticket_NullRow do
         WriteAndEnter('  ',PWidth);
  finally
    EndPrint;
    rs.Free;
  end;
end;

procedure TDevFactory.BeginPrint;
begin
  if Ticket_PrintComm < 1 then Raise Exception.Create('没有安装小票打印机不能打小票');
  if DevFactory.Ticket_PrintComm < 5 then
     AssignFile(F,'LPT'+inttostr(DevFactory.Ticket_PrintComm))
  else if DevFactory.Ticket_PrintComm in [5..29] then
     AssignFile(F,'COM'+inttostr(DevFactory.Ticket_PrintComm-4))
  else if DevFactory.Ticket_PrintComm in [30] then
     begin
       AssignPrn(F);
       Printer.Canvas.Font := Application.MainForm.Font;
     end
  else
     AssignFile(F,ExtractFilePath(ParamStr(0))+'debug\prt.txt');
  rewrite(F);
end;

procedure TDevFactory.WritePrint(s: string);
begin
  Writeln(F,s);
end;

procedure TDevFactory.WritePrintNoEnter(s: string);
begin
  Write(F,s);
end;

procedure TDevFactory.EndPrint;
begin
  CloseFile(F);
end;

function TDevFactory.EncodeDivStr: string;
var i:integer;
begin
  for i:=1 to Ticket_Width-1 do result := result + '-';
end;

function TDevFactory.PrintSaleTicketSQL(tenantId, id: string): string;
var TopCnd: string;
begin
  case dataFactory.iDbType of
   0: TopCnd:=' top 20000 ';
   else
      TopCnd:='';
  end;
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT ,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+') as TOTAL_OWE_MNY,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+' and SALES_ID='''+id+''') as ORDER_OWE_MNY,'+
   'case when j.INVOICE_FLAG=''1'' then ''收款收据'' when j.INVOICE_FLAG=''2'' then ''普通发票'' else ''增值税票'' end as INVOICE_FLAG_TEXT '+
   'from ('+
   'select jn.*,n.DEPT_NAME as DEPT_ID_TEXT from ('+
   'select jm.*,m.CODE_NAME as SETTLE_CODE_TEXT from ( '+
   'select jl.*,l.CODE_NAME as SALES_STYLE_TEXT from ( '+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.GLIDE_NO as GLIDE_NO_FROM from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
   'select jb.*,b.CLIENT_NAME,b.CLIENT_CODE,b.SETTLE_CODE,b.ADDRESS,b.POSTALCODE,b.TELEPHONE2 as MOVE_TELE,b.INTEGRAL as ACCU_INTEGRAL,b.FAXES as CLIENT_FAXES from ('+
   'select '+TopCnd+' A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.SALE_AMT,A.SALE_MNY,A.CASH_MNY,A.PAY_ZERO,A.PAY_DIBS,A.PAY_A,A.PAY_B,A.PAY_C,A.PAY_D,'+
   'A.PAY_E,A.PAY_F,A.PAY_G,A.PAY_H,A.PAY_I,A.PAY_J,A.INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_STYLE,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,B.CALC_MONEY,A.BARTER_INTEGRAL,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from SAL_SALESORDER A,SAL_SALESDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+tenantid+' and A.SALES_ID='''+id+''' order by SEQNO) jb '+
   'left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join SAL_INDENTORDER e on je.TENANT_ID=e.TENANT_ID and je.FROM_ID=e.INDE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
   'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE')+') h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and  jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl  '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''2'' and TENANT_ID='+tenantid+') l on jl.SALES_STYLE=l.CODE_ID) jm '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tenantid+') m on jm.SETTLE_CODE=m.CODE_ID) jn '+
   'left outer join CA_DEPT_INFO n on jn.TENANT_ID=n.TENANT_ID and jn.DEPT_ID=n.DEPT_ID ) j '+
   ' order by SEQNO ';
end;

class procedure TDevFactory.OpenCashBox;
begin
  if DevFactory.CashBox = 0 then Exit;
  if (GetTickCount-DevFactory.CashBoxStart) < 5000 then Exit;
  DevFactory.CashBoxStart := GetTickCount;
  if DevFactory.CashBox=1 then
     begin
        DevFactory.BeginPrint;
        try
          if not (DevFactory.Ticket_PrintComm in [30]) then
             DevFactory.WritePrintNoEnter(CHR(27)+'p'+CHR(0)+CHR(60)+CHR(255))
          else
             DevFactory.WritePrintNoEnter(' ');
        finally
          DevFactory.EndPrint;
        end;
     end;
  if DevFactory.CashBox>1 then
     DevFactory.OpenCashBoxComm;
end;

procedure TDevFactory.OpenCashBoxComm;
var s:string;
begin
  try
    if CashBox <= 1 then Exit;
    FComm.StopComm;
    FComm.CommName := 'COM'+Inttostr(CashBox-1);
    FComm.BaudRate := CashBoxRate;
    FComm.StartComm;
    s:=CHR(27)+'p'+CHR(0)+CHR(60)+CHR(255);
    FComm.WriteCommData(Pchar(s),Length(s)) ;
  except
    Raise Exception.Create('打开钱箱'+FComm.CommName+'端口出错,是否正确设置参数？');
  end;
end;

initialization
  DevFactory := TDevFactory.Create;
  DevFactory.InitComm;
finalization
  DevFactory.Free;
end.
