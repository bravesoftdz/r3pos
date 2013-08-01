unit ufrmStocksCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls, ZDataSet,ZBase,
  RzButton, RzPrgres, StdCtrls, RzLabel, RzBorder;

const
  WM_START=WM_USER+10485;

type
  TfrmStocksCalc = class(TfrmWebDialog)
    RzProgressBar1: TRzProgressBar;
    RzBorder1: TRzBorder;
    lblInfo: TRzLabel;
    btnCalc: TRzBmpButton;
    Timer1: TTimer;
    RzLabel26: TRzLabel;
    procedure btnCalcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    tmpTable,seqTable,prcTable:string;
    rw:integer;
    procedure CreateSQLTable(sql:string;tb:string);
    procedure DropSQLTable(tb:string);
    //本月负库存销售清理结账记录
    procedure ClearDays;
    //清除数据
    procedure ClearRck;
    //准备临时表
    procedure Init;
    //计算期初数据
    procedure calcLast;
    //初始本期数据
    procedure InitData;
    //计算排序号
    procedure Prepare;
    //计算期未数量
    procedure calcBalAmt;
    //容差补差
    procedure deficit;
    //计算成本单价
    procedure calcPrice;
    //计算金额
    procedure calcMoney;
    //数据复制
    procedure copyToRck;
    //检测r3、r6版本
    procedure CheckAppVersion;
  protected
    procedure WMStart(var Message: TMessage); message WM_START;
  public
    _beginDate:TDate;
    _endDate:TDate;
    usingDate:TDate;
    eDate:TDate;
    lastDate:integer;
    navDate:integer;
    bal_amt,bal_prc,bal_mny:real;
    function getLastDate:integer;
    function getUsingDate:TDate;
    function creaStocks:boolean;
    class function Calc(AOwner:TForm;endDate:TDate=0):boolean;overload;
    class function Calc(PHWnd:THandle;endDate:TDate=0):boolean;overload;
  end;

implementation

uses udataFactory,utokenFactory,uFnUtil,objCommon,udllGlobal;

{$R *.dfm}

class function TfrmStocksCalc.Calc(AOwner:TForm;endDate:TDate=0): boolean;
begin
  with TfrmStocksCalc.Create(AOwner) do
    begin
      try
        if endDate=0 then
           eDate := dllGlobal.SysDate
        else
           eDate := endDate;
        PostMessage(handle,WM_START,0,0);
        result := (ShowModal=MROK);
      finally
        Free;
      end;
    end;
end;

class function TfrmStocksCalc.Calc(PHWnd:THandle;endDate:TDate): boolean;
begin
  with TfrmStocksCalc.CreateParented(PHWnd) do
    begin
      try
        if endDate=0 then
           eDate := dllGlobal.SysDate
        else
           eDate := endDate;
        PostMessage(handle,WM_START,0,0);
        result := (ShowModal=MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmStocksCalc.calcBalAmt;
var
  sql:string;
begin
  case dataFactory.iDbType of
  5:sql :=
      'update '+tmpTable+' set '+
      'BAL_AMOUNT=(select ifnull(max(B.BAL_AMOUNT),0) '+
      'from '+tmpTable+' B '+
      'where '+
      '  B.SHOP_ID='+tmpTable+'.SHOP_ID and '+
      '  B.GODS_ID='+tmpTable+'.GODS_ID and '+
      '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
      '  B.SEQNO='+tmpTable+'.SEQNO-2 '+
      ') + IN_AMOUNT - OUT_AMOUNT where BILL_TYPE>1 ';
  else
    sql :=
      'update '+tmpTable+' set '+
      'BAL_AMOUNT=(select sum(case when B.BILL_TYPE in (0,1) then B.BAL_AMOUNT else B.IN_AMOUNT-B.OUT_AMOUNT end) '+
      'from '+tmpTable+' B '+
      'where '+
      '  B.SHOP_ID='+tmpTable+'.SHOP_ID and '+
      '  B.GODS_ID='+tmpTable+'.GODS_ID and '+
      '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
      '  B.SEQNO<='+tmpTable+'.SEQNO '+
      ') where BILL_TYPE>1 ';
  end;
  sql := parseSQL(dataFactory.iDbType,sql);
  dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.calcLast;
var
  sql:string;
  id,tmpIdValue:string;
  n:integer;
begin
  if dataFactory.iDbType=1 then
     begin
       id := 'id,';
       tmpIdValue := 'rownum,';
     end;
  sql :=
      'insert into '+tmpTable+' '+
      '('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
      ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
      ' BAL_AMOUNT,BAL_PRICE,BAL_MONEY) '+
      'select '+tmpIdValue+'j.TENANT_ID,''#'' as SHOP_ID,''#'' as BILL_ID,0 as BILL_TYPE,''期初'',19700101,1,'+
      ' j.GODS_ID,''#'' as CLIENT_ID,''#'' as UNIT_ID,1 as CONV_RATE,''#'' as BATCH_NO,''#'' as PROPERTY_01,''#'' as PROPERTY_02, '+
      ' 0,j.NEW_INPRICE,0 from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,NEW_INPRICE',true)+') j '+
      'left outer join PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID ';
  n := dataFactory.ExecSQL(sql);
  if dataFactory.iDbType=1 then
     begin
       id := 'id,';
       tmpIdValue := 'rownum+'+inttostr(n)+',';
     end;
  if formatDatetime('DD',_beginDate)<>'01' then
    sql:=
      'insert into '+tmpTable+' '+
      ' ('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
      ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
      ' BAL_AMOUNT,BAL_PRICE,BAL_MONEY) '+
      'select '+
      '  '+tmpIdValue+'A.TENANT_ID,A.SHOP_ID,''#'' as BILL_ID,0 as BILL_TYPE,''期初'',A.BILL_DATE,A.SEQNO,A.GODS_ID,''#'' as CLIENT_ID,A.UNIT_ID,A.CONV_RATE,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02, '+
      '  A.BAL_AMOUNT,A.BAL_PRICE,A.BAL_MONEY '+
      'from RCK_STOCKS_DATA A, '+
      '  (select max(SEQNO) as SEQNO,SHOP_ID,GODS_ID,BATCH_NO '+
      '   from RCK_STOCKS_DATA where TENANT_ID='+token.tenantId+' and BILL_DATE>='+inttostr(navDate)+' and BILL_DATE<='+inttostr(lastDate)+' '+
      '   group by SHOP_ID,GODS_ID,BATCH_NO '+
      '  ) B '+
      'where '+
      '  A.SHOP_ID=B.SHOP_ID and '+
      '  A.GODS_ID=B.GODS_ID and '+
      '  A.BATCH_NO=B.BATCH_NO and '+
      '  A.SEQNO=B.SEQNO and '+
      '  A.TENANT_ID='+token.tenantId+' and A.BILL_DATE>='+inttostr(navDate)+' and A.BILL_DATE<='+inttostr(lastDate)+''
  else
    sql:=
      'insert into '+tmpTable+' '+
      '('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
      ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
      ' BAL_AMOUNT,BAL_PRICE,BAL_MONEY) '+
      'select '+
      '  '+tmpIdValue+'A.TENANT_ID,A.SHOP_ID,''#'' as BILL_ID,1 as BILL_TYPE,''期初'','+formatDatetime('YYYYMMDD',_beginDate)+' as BILL_DATE,A.SEQNO+2,A.GODS_ID,''#'' as CLIENT_ID,A.UNIT_ID,A.CONV_RATE,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02, '+
      '  A.BAL_AMOUNT,A.BAL_PRICE,A.BAL_MONEY '+
      'from RCK_STOCKS_DATA A, '+
      '  (select max(SEQNO) as SEQNO,SHOP_ID,GODS_ID,BATCH_NO '+
      '   from RCK_STOCKS_DATA where TENANT_ID='+token.tenantId+' and BILL_DATE>='+inttostr(navDate)+' and BILL_DATE<='+inttostr(lastDate)+' '+
      '   group by SHOP_ID,GODS_ID,BATCH_NO '+
      '  ) B '+
      'where '+
      '  A.SHOP_ID=B.SHOP_ID and '+
      '  A.GODS_ID=B.GODS_ID and '+
      '  A.BATCH_NO=B.BATCH_NO and '+
      '  A.SEQNO=B.SEQNO and '+
      '  A.TENANT_ID='+token.tenantId+' and A.BILL_DATE>='+inttostr(navDate)+' and A.BILL_DATE<='+inttostr(lastDate)+'';
  rw := n+dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.calcMoney;
var
  sql:string;
begin
  case dataFactory.iDbType of
  5:sql:= 'update '+tmpTable+' set OUT_PRICE=case when BILL_TYPE=22 then OUT_PRICE else BAL_PRICE and,OUT_MONEY=case when BILL_TYPE=22 then OUT_MONEY else round(OUT_AMOUNT*BAL_PRICE,2) end,BAL_MONEY=round(BAL_AMOUNT*BAL_PRICE,2) where SEQNO % 2 <>0 and BILL_TYPE>1';
  4,1:sql:= 'update '+tmpTable+' a set (OUT_PRICE,OUT_MONEY,BAL_MONEY,BAL_PRICE)=(select case when a.BILL_TYPE=22 then b.BAL_PRICE else a.OUT_PRICE end,case when a.BILL_TYPE=22 then a.OUT_MONEY else round(a.OUT_AMOUNT*b.BAL_PRICE,2) end,round(a.BAL_AMOUNT*b.BAL_PRICE,2),b.BAL_PRICE '+
  'from '+prcTable+' b where a.ID=b.ID) where round(SEQNO / 2.0,0)<>round(SEQNO / 2.0,2) and BILL_TYPE>1';
  end;
  dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.calcPrice;
var
  sql:string;
begin
  case dataFactory.iDbType of
  5:
    sql:=
      'update '+tmpTable+' set BAL_PRICE=( '+
      'select ifnull(case when sum(A.BAL_AMOUNT)<>0 then round(sum(A.BAL_AMOUNT*A.BAL_PRICE)/sum(A.BAL_AMOUNT),6) else max(BAL_PRICE) end,0) '+
      'from '+tmpTable+' A '+
      'where '+
      ' (A.SHOP_ID='+tmpTable+'.SHOP_ID and '+
      '  A.GODS_ID='+tmpTable+'.GODS_ID and '+
      '  A.BATCH_NO='+tmpTable+'.BATCH_NO and '+
      '  A.SEQNO in ('+tmpTable+'.SEQNO-2,'+tmpTable+'.SEQNO-1)'+
      ' ) or (A.SHOP_ID=''#'' and A.GODS_ID='+tmpTable+'.GODS_ID and A.BATCH_NO=''#'' and A.SEQNO=1 and A.BILL_DATE=19700101) '+
      ') where (SEQNO % 2)<>0 and BILL_TYPE>1';
  4:
    sql:=
      'insert into '+prcTable+' '+
      'with report(id,shop_id,gods_id,batch_no,seqno,bal_amount,bal_price) as '+
      '( '+
      'select c.id,c.shop_id,c.gods_id,c.batch_no,c.seqno,bal_amount,case when bal_amount<>0 and bal_price=0 then ('+
      'select coalesce(max(bal_price),0) from '+tmpTable+' where gods_id=c.gods_id and shop_id=''#'' and BILL_DATE=19700101'+
      ') else bal_price end as bal_price from '+tmpTable+' c,'+
      '(select min(seqno) as seqno,gods_id,batch_no,shop_id from '+tmpTable+' where shop_id<>''#'' and round(SEQNO / 2.0,0)<>round(SEQNO / 2.0,2) '+
      'group by gods_id,batch_no,shop_id) c1 '+
      'where c.seqno=c1.seqno and c.shop_id=c1.shop_id and c.gods_id=c1.gods_id and c.batch_no=c1.batch_no and c.shop_id<>''#'' and round(c.SEQNO / 2.0,0)<>round(c.SEQNO / 2.0,2) '+
      'union all '+
      'select a.id,a.shop_id,a.gods_id,a.batch_no,a.seqno,a.bal_amount, '+
      'case when (b.bal_amount + a.var1)=0 then b.bal_price else (b.bal_amount*b.bal_price+var2) / (b.bal_amount + var1) end as bal_price '+
      'from '+tmpTable+' a,report b '+
      'where a.seqno=b.seqno+2 and a.shop_id=b.shop_id and a.gods_id=b.gods_id and a.batch_no=b.batch_no '+
      ') '+
      'select id,bal_price from report';
  1:
    sql:=
      'insert into '+prcTable+' '+
      'with report(id,shop_id,gods_id,batch_no,seqno,bal_amount,bal_price) as '+
      '( '+
      'select c.id,c.shop_id,c.gods_id,c.batch_no,c.seqno,bal_amount,case when bal_amount<>0 and bal_price=0 then ('+
      'select coalesce(max(bal_price),0) from '+tmpTable+' where gods_id=c.gods_id and shop_id=''#'' and BILL_DATE=19700101'+
      ') else bal_price end as bal_price from '+tmpTable+' c,'+
      '(select min(seqno) as seqno,gods_id,batch_no,shop_id from '+tmpTable+' where shop_id<>''#'' and round(SEQNO / 2.0,0)<>round(SEQNO / 2.0,2) '+
      'group by gods_id,batch_no,shop_id) c1 '+
      'where c.seqno=c1.seqno and c.shop_id=c1.shop_id and c.gods_id=c1.gods_id and c.batch_no=c1.batch_no and c.shop_id<>''#'' and round(c.SEQNO / 2.0,0)<>round(c.SEQNO / 2.0,2) '+
      'union all '+
      'select a.id,a.shop_id,a.gods_id,a.batch_no,a.seqno,a.bal_amount, '+
      'case when (b.bal_amount + a.var1)=0 then b.bal_price else (b.bal_amount*b.bal_price+var2) / (b.bal_amount + var1) end as bal_price '+
      'from '+tmpTable+' a,report b '+
      'where a.seqno=b.seqno+2 and a.shop_id=b.shop_id and a.gods_id=b.gods_id and a.batch_no=b.batch_no '+
      ') '+
      'select id,bal_price from report';
  end;
  sql := parseSQL(dataFactory.iDbType,sql);
  dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.copyToRck;
var
  sql,sql1:string;
begin
  //奇数行为有效数据
  sql:=
    'insert into RCK_STOCKS_DATA'+
    '(TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO,'+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02,'+
    ' IN_AMOUNT,IN_PRICE,IN_MONEY,IN_TAX,OUT_AMOUNT,OUT_PRICE,OUT_MONEY,SALE_PRICE,SALE_MONEY,SALE_TAX,BAL_AMOUNT,BAL_PRICE,BAL_MONEY,'+
    ' GUIDE_USER,CREA_USER,RELATION_ID,GODS_NAME,GODS_CODE,BARCODE,SORT_ID,SORT_NAME,CLIENT_CODE,CLIENT_NAME,UNIT_NAME,GUIDE_NAME,CREA_NAME,COMM,TIME_STAMP) '+
    'select A.TENANT_ID,A.SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO,'+
    ' A.GODS_ID,ifnull(A.CLIENT_ID,''#''),A.UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02,'+
    ' IN_AMOUNT,IN_PRICE,IN_MONEY,IN_TAX,OUT_AMOUNT,OUT_PRICE,OUT_MONEY,SALE_PRICE,SALE_MONEY,SALE_TAX,BAL_AMOUNT,BAL_PRICE,BAL_MONEY,'+
    ' GUIDE_USER,CREA_USER,B.RELATION_ID,B.GODS_NAME,B.GODS_CODE,B.BARCODE,B.SORT_ID1,C.SORT_NAME,D.CLIENT_CODE,D.CLIENT_NAME,E.UNIT_NAME,F.USER_NAME,G.USER_NAME,''00'','+GetTimeStamp(dataFactory.iDbType)+'  '+
    'from '+tmpTable+' A '+
    ' left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,RELATION_ID,SORT_ID1',true)+') B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    ' left outer join (select SORT_ID,SORT_NAME from PUB_GOODSSORT where TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+')) C on B.SORT_ID1=C.SORT_ID '+
    ' left outer join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
    ' left outer join (select UNIT_ID,UNIT_NAME from PUB_MEAUNITS where TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+') ) E on A.UNIT_ID=E.UNIT_ID '+
    ' left outer join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.GUIDE_USER=F.USER_ID '+
    ' left outer join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CREA_USER=G.USER_ID '+
    'where round(SEQNO / 2.0,0)<>round(SEQNO / 2.0,2) and BILL_TYPE>0 ';
//  dataFactory.BeginTrans;
  try
    dataFactory.ExecSQL(ParseSQL(dataFactory.iDbType,sql));
    sql:='insert into RCK_DAYS_CLOSE(TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) ';
    sql1 := '';
    while _beginDate<=_endDate do
      begin
        if sql1<>'' then sql1 := sql1 + ' union all ';
        sql1:=sql1+
        'select TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',_beginDate)+','''+token.userId+''',''00'','+GetTimeStamp(dataFactory.iDbType)+' from CA_SHOP_INFO where TENANT_ID='+token.tenantId;
        _beginDate := _beginDate+1;
      end;
    if sql1<>'' then
    begin
      sql := sql + ' '+sql1+'';
      dataFactory.ExecSQL(ParseSQL(dataFactory.iDbType,sql));
    end;
//    dataFactory.CommitTrans;
  except
//    dataFactory.RollbackTrans;
    Raise;
  end;
end;

function TfrmStocksCalc.creaStocks: boolean;
var rs:TZQuery;
begin
   lastDate := getLastDate;
   usingDate := getUsingDate;
   if lastDate>0 then
      begin
        _beginDate := FnTime.fnStrtoDate(inttostr(lastDate))+1;
        if formatDatetime('DD',_beginDate)='01' then
           begin
             navDate := strtoint(formatDatetime('YYYYMM01',incMonth(_beginDate,-1)));
           end
        else
           navDate := strtoint(formatDatetime('YYYYMM01',_beginDate));
      end
   else
      begin
        _beginDate := usingDate;
        navDate := 19700101;
        rs := TZQuery.Create(nil);
        try
          rs.Close;
          rs.SQL.Text := 'select min(CREA_DATE) from VIW_GOODS_DAYS where TENANT_ID='+token.tenantId+' and CREA_DATE<'+formatDatetime('YYYYMMDD',usingDate);
          dataFactory.Open(rs);
          if rs.Fields[0].AsString <> '' then Raise Exception.Create('系统参数的启用日期错了，请设置到['+rs.Fields[0].AsString+']之前日期');
        finally
          rs.Free;
        end;
      end;
   _endDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',incMonth(_beginDate,1)))-1;
   if _endDate>eDate then _endDate := edate;
   lblInfo.Caption := '计算区间:'+formatDatetime('YYYY-MM-DD',_beginDate)+'至'+formatDatetime('YYYY-MM-DD',_endDate);
   //创建临时表
   Init;
   try
     if dataFactory.iDbType=5 then dataFactory.BeginTrans;
     try
       RzProgressBar1.Percent := 5;
       ClearRck;
       RzProgressBar1.Percent := 15;
       calcLast;
       RzProgressBar1.Percent := 20;
       InitData;
       RzProgressBar1.Percent := 50;
       prepare;
       RzProgressBar1.Percent := 55;
       calcBalAmt;
       RzProgressBar1.Percent := 60;
       deficit;
       RzProgressBar1.Percent := 70;
       calcPrice;
       RzProgressBar1.Percent := 80;
       calcMoney;
       RzProgressBar1.Percent := 90;
       if dataFactory.iDbType=5 then dataFactory.CommitTrans;
     except
       if dataFactory.iDbType=5 then dataFactory.RollbackTrans;
       Raise;
     end;
     copyToRck;
     RzProgressBar1.Percent := 100;
   finally
//     dropSQLTable(tmpTable);
//     dropSQLTable(seqTable);
//     dropSQLTable(prcTable);
   end;
end;

procedure TfrmStocksCalc.CreateSQLTable(sql: string;tb:string);
begin
  dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.deficit;
var
  sql:string;
  id,seqIdValue,tmpIdValue:string;
begin
  if dataFactory.iDbType = 1 then
     begin
       id := 'id,';
       tmpIdValue := 'rownum+'+inttostr(rw)+',';
     end;
  sql :=
    'insert into '+tmpTable+' '+
    '('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
    ' BAL_AMOUNT,BAL_PRICE,BAL_MONEY) '+
    'select '+tmpIdValue+'TENANT_ID,SHOP_ID,BILL_ID,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO-1, '+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
    ' case when BILL_TYPE=22 then OUT_AMOUNT else IN_AMOUNT end,'+
    ' case when BILL_TYPE=22 then OUT_PRICE else IN_PRICE end,'+
    ' case when BILL_TYPE=22 then OUT_MONEY else IN_MONEY end '+
    'from '+tmpTable+' where BILL_TYPE in (11,12,13,22) ';
  dataFactory.ExecSQL(sql);
  RzProgressBar1.Percent := 65;
  case dataFactory.iDbType of
  5:
    sql :=
      'update '+tmpTable+' set SEQNO= '+
      '( '+
      ' select ifnull(max(SEQNO),1)+1 from '+tmpTable+' B where '+
      '  B.SHOP_ID='+tmpTable+'.SHOP_ID and '+
      '  B.GODS_ID='+tmpTable+'.GODS_ID and '+
      '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
      '  B.BAL_AMOUNT>0 and (B.SEQNO % 2)<>0 and B.SEQNO<'+tmpTable+'.SEQNO '+
      ') where (SEQNO % 2)=0 and BILL_TYPE in (11,12) ';
  else
    sql :=
      'update '+tmpTable+' set SEQNO= '+
      '( '+
      ' select ifnull(max(SEQNO),1)+1 from '+tmpTable+' B where '+
      '  B.SHOP_ID='+tmpTable+'.SHOP_ID and '+
      '  B.GODS_ID='+tmpTable+'.GODS_ID and '+
      '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
      '  B.BAL_AMOUNT>0 and (round(B.SEQNO / 2.0,0)<>round(B.SEQNO / 2.0,2)) and B.SEQNO<'+tmpTable+'.SEQNO '+
      ') where round(SEQNO / 2.0,0)=round(SEQNO / 2.0,2) and BILL_TYPE in (11,12) ';
  end;
  sql := parseSQL(dataFactory.iDbType,sql);
  dataFactory.ExecSQL(sql);
  case dataFactory.iDbType of //不是
  4,1:begin
      sql := 'update '+tmpTable+' a set (VAR1,VAR2)=(select coalesce(sum(BAL_AMOUNT),0),coalesce(sum(BAL_MONEY),0) from '+tmpTable+' where SHOP_ID=a.SHOP_ID and GODS_ID=a.GODS_ID and BATCH_NO=a.BATCH_NO and SEQNO=a.SEQNO-1) where round(SEQNO / 2.0,0)<>round(SEQNO / 2.0,2)';
      sql := parseSQL(dataFactory.iDbType,sql);
      dataFactory.ExecSQL(sql);
    end;
  end;
end;

function TfrmStocksCalc.getLastDate: integer;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger :=  strtoInt(token.tenantId);
    dataFactory.Open(rs);
    result := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

function TfrmStocksCalc.getUsingDate: TDate;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=''USING_DATE''';
    rs.ParamByName('TENANT_ID').AsInteger :=  strtoInt(token.tenantId);
    dataFactory.Open(rs);
    result := FnTime.fnStrtoDate(rs.Fields[0].asString);
    if result < FnTime.fnStrtoDate('19700101')  then result := FnTime.fnStrtoDate('19700101');
  finally
    rs.Free;
  end;
end;

procedure TfrmStocksCalc.Init;
var
  sql:string;
  varchar,int,null,priKey,default:string;
  id:string;
begin
  case dataFactory.iDbType of
  1:varchar := ' varchar2';
  else
    varchar := ' varchar';
  end;
  case dataFactory.iDbType of
  0,5:null := ' null ';
   else
    null := ' ';
  end;
  case dataFactory.iDbType of
  1:default := 'DEFAULT 0 NOT NULL';
  else
    default := 'NOT NULL DEFAULT 0 ';
  end;
  case dataFactory.iDbType of
  1:int := ' number(22,0) ';
  4:int := ' integer ';
  else
    int := ' int ';
  end;
  dropSQLTable(tmpTable);
  case dataFactory.iDbType of
  0:id := 'ID bigint PRIMARY KEY identity(1,1),';
  1:id := 'ID number(22,0) NOT NULL,';
  4:id := 'ID bigint NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1 ),';
  5:id := 'ID INTEGER PRIMARY KEY autoincrement,';
  end;
  if dataFactory.iDbType in [1,4] then priKey := ',CONSTRAINT PK_'+tmpTable+' PRIMARY KEY (ID)';
  sql :=
    'CREATE TABLE '+tmpTable+' '+
    '('+
    id+
    'TENANT_ID'+int+'NOT NULL , '+
    'SHOP_ID'+varchar+'(13) NOT NULL , '+
    'BILL_ID char (36) NOT NULL , '+
    'BILL_CODE'+varchar+'(20) '+null+' , '+
    'BILL_TYPE'+int+'NOT NULL , '+
    'BILL_NAME'+varchar+'(10) '+null+' , '+
    'BILL_DATE'+int+'NOT NULL , '+
    'SEQNO'+int+'NOT NULL , '+
    'GODS_ID char (36) NOT NULL , '+
    'CLIENT_ID'+varchar+'(36) '+null+' , '+
    'UNIT_ID'+varchar+'(36) NOT NULL , '+
    'CONV_RATE decimal(18, 3) NOT NULL , '+
    'BATCH_NO'+varchar+'(36) NOT NULL , '+
    'PROPERTY_01'+varchar+'(36) NOT NULL , '+
    'PROPERTY_02'+varchar+'(36) NOT NULL , '+
    'IN_AMOUNT decimal(18, 3) '+default+', '+
    'IN_PRICE  decimal(18, 6) '+default+', '+
    'IN_MONEY  decimal(18, 3) '+default+', '+
    'IN_TAX  decimal(18, 3) '+default+', '+
    'OUT_AMOUNT decimal(18, 3) '+default+', '+
    'OUT_PRICE decimal(18, 6) '+default+', '+
    'OUT_MONEY decimal(18, 3) '+default+', '+
    'SALE_PRICE decimal(18, 6) '+default+', '+
    'SALE_MONEY decimal(18, 3) '+default+', '+
    'SALE_TAX decimal(18, 3) '+default+', '+
    'BAL_AMOUNT decimal(18, 3) '+default+', '+
    'BAL_PRICE decimal(18, 6) '+default+', '+
    'BAL_MONEY decimal(18, 3) '+default+', '+
    'VAR1 decimal(18, 3) '+default+', '+
    'VAR2 decimal(18, 3) '+default+', '+
    'GUIDE_USER'+varchar+'(36) '+null+', '+
    'CREA_USER'+varchar+'(36) '+null+' '+  priKey +
    ')';
  createSQLTable(sql,tmpTable);
  if dataFactory.iDbType in [1,4] then priKey := ',CONSTRAINT PK_'+seqTable+' PRIMARY KEY (ID)';
  dropSQLTable(seqTable);
  sql :=
    'CREATE TABLE '+seqTable+' '+
    '( '+
    id+
    '	TENANT_ID'+int+'NOT NULL , '+
    '	SHOP_ID'+varchar+'(13) NOT NULL , '+
    '	BILL_ID char (36) NOT NULL , '+
    '	BILL_CODE'+varchar+'(20) '+null+' , '+
    '	BILL_TYPE'+int+'NOT NULL , '+
    '	BILL_NAME'+varchar+'(10) '+null+' , '+
    '	BILL_DATE'+int+'NOT NULL , '+
    '	SEQNO'+int+'NOT NULL , '+
    '	GODS_ID char (36) NOT NULL , '+
    '	CLIENT_ID'+varchar+'(36) '+null+' , '+
    '	UNIT_ID'+varchar+'(36) NOT NULL , '+
    '	CONV_RATE decimal(18, 3) NOT NULL , '+
    ' BATCH_NO'+varchar+'(36) NOT NULL , '+
    ' PROPERTY_01'+varchar+'(36) NOT NULL , '+
    ' PROPERTY_02'+varchar+'(36) NOT NULL , '+
    '	IN_AMOUNT decimal(18, 3) '+default+', '+
    '	IN_PRICE  decimal(18, 6) '+default+', '+
    '	IN_MONEY  decimal(18, 3) '+default+', '+
    '	IN_TAX  decimal(18, 3) '+default+', '+
    ' OUT_AMOUNT decimal(18, 3) '+default+', '+
    ' OUT_PRICE decimal(18, 6) '+default+', '+
    ' OUT_MONEY decimal(18, 3) '+default+', '+
    ' SALE_PRICE decimal(18, 6) '+default+', '+
    ' SALE_MONEY decimal(18, 3) '+default+', '+
    ' SALE_TAX decimal(18, 3) '+default+', '+
    ' BAL_AMOUNT decimal(18, 3) '+default+', '+
    ' BAL_PRICE decimal(18, 6) '+default+', '+
    ' BAL_MONEY decimal(18, 3) '+default+', '+
    '	GUIDE_USER'+varchar+'(36) '+null+', '+
    '	CREA_USER'+varchar+'(36) '+null+' '+  priKey +
    ')';
  createSQLTable(sql,seqTable);
  if dataFactory.iDbType <> 5 then
  begin
    if dataFactory.iDbType in [1,4] then priKey := ' ,CONSTRAINT PK_'+prcTable+' PRIMARY KEY (ID)';
    dropSQLTable(prcTable);
    sql :=
      'CREATE TABLE '+prcTable+' '+
      '( '+
      '	ID'+int+'NOT NULL , '+
      ' BAL_PRICE decimal(18, 6) '+default+' '+  priKey +
      ')';
    createSQLTable(sql,prcTable);
  end;
end;

procedure TfrmStocksCalc.InitData;
var
  sql:string;
  id,seqIdValue,tmpIdValue:string;
  n:integer;
begin
  if dataFactory.iDbType=1 then
     begin
       id := 'id,';
       seqIdValue := 'rownum,';
     end;
  sql :=
    'insert into '+seqTable+' '+
    '('+ID+'TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
    ' IN_AMOUNT,IN_PRICE,IN_MONEY,IN_TAX,GUIDE_USER,CREA_USER) '+
    'select '+seqIdValue+'A.TENANT_ID,A.SHOP_ID,A.STOCK_ID,B.GLIDE_NO,B.STOCK_TYPE+10, '+
    ' case when B.STOCK_TYPE=1 then ''进货'' when B.STOCK_TYPE=2 then ''调入'' when B.STOCK_TYPE=3 then ''退出'' else ''入库'' end as BILL_NAME,B.STOCK_DATE,1 as SEQNO, '+
    ' A.GODS_ID,B.CLIENT_ID,A.UNIT_ID,cast(A.CALC_AMOUNT as decimal(18,3)) / cast(A.AMOUNT as decimal(18,3)) as CONV_RATE,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02, '+
    ' A.CALC_AMOUNT as IN_AMOUNT,'+
    ' round((A.CALC_MONEY-round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end,2)) / cast(A.CALC_AMOUNT as decimal(18,3)),6) as IN_PRICE, '+
    ' A.CALC_MONEY-round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end,2) as IN_MONEY,'+
    ' round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end,2) as IN_TAX, '+
    ' B.GUIDE_USER,B.CREA_USER '+
    'from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and '+
    ' B.TENANT_ID='+token.tenantId+' and B.STOCK_DATE>='+formatDatetime('YYYYMMDD',_beginDate)+' and B.STOCK_DATE<='+formatDatetime('YYYYMMDD',_endDate)+' '+
    'order by A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,B.STOCK_DATE,B.CREA_DATE ';
  n := dataFactory.ExecSQL(sql);
  if dataFactory.iDbType=1 then
     begin
       seqIdValue := 'rownum+'+inttostr(n)+',';
     end;
  RzProgressBar1.Percent := 30;
  sql :=
    'insert into '+seqTable+' '+
    '('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
    ' OUT_AMOUNT,OUT_PRICE,OUT_MONEY,SALE_PRICE,SALE_MONEY,SALE_TAX, '+
    ' GUIDE_USER,CREA_USER) '+
    'select '+seqIdValue+'A.TENANT_ID,A.SHOP_ID,A.SALES_ID,B.GLIDE_NO,B.SALES_TYPE+20, '+
    ' case when B.SALES_TYPE in (1,4) then ''销售'' when B.SALES_TYPE=2 then ''调出'' when B.SALES_TYPE=3 then ''退入'' else ''出库'' end as BILL_NAME,B.SALES_DATE,1 as SEQNO, '+
    ' A.GODS_ID,B.CLIENT_ID,A.UNIT_ID,cast(A.CALC_AMOUNT as decimal(18,3)) / cast(A.AMOUNT as decimal(18,3)) as CONV_RATE,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02, '+
    ' A.CALC_AMOUNT as OUT_AMOUNT,A.COST_PRICE,round(A.CALC_AMOUNT*A.COST_PRICE,2),'+
    ' round((A.CALC_MONEY-round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2)) / cast(A.CALC_AMOUNT as decimal(18,3))'+
    ' ,6) as SALE_PRICE,'+
    ' A.CALC_MONEY-round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2) as SALE_MONEY, '+
    ' round(cast(A.CALC_MONEY as decimal(18,3))/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2) as SALE_TAX, '+
    ' B.GUIDE_USER,B.CREA_USER '+
    'from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and '+
    ' B.TENANT_ID='+token.tenantId+' and B.SALES_DATE>='+formatDatetime('YYYYMMDD',_beginDate)+' and B.SALES_DATE<='+formatDatetime('YYYYMMDD',_endDate)+' '+
    'order by A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,B.SALES_DATE,B.CREA_DATE ';
  n := n + dataFactory.ExecSQL(sql);
  RzProgressBar1.Percent := 40;
  if dataFactory.iDbType=1 then
     begin
       seqIdValue := 'rownum+'+inttostr(n)+',';
     end;
  sql :=
    'insert into '+seqTable+' '+
    '('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO, '+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02, '+
    ' OUT_AMOUNT,GUIDE_USER,CREA_USER) '+
    'select '+seqIdValue+'A.TENANT_ID,A.SHOP_ID,A.CHANGE_ID,B.GLIDE_NO,cast(B.CHANGE_CODE as int)+30, '+
    ' case when B.CHANGE_CODE=''1'' then ''损益'' when B.CHANGE_CODE=''2'' then ''领用'' else ''出库'' end as BILL_NAME,B.CHANGE_DATE,1 as SEQNO, '+
    ' A.GODS_ID,''#'',A.UNIT_ID,cast(A.CALC_AMOUNT as decimal(18,3)) / cast(A.AMOUNT as decimal(18,3)) as CONV_RATE,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02, '+
    ' A.CALC_AMOUNT as OUT_AMOUNT,B.DUTY_USER,B.CREA_USER '+
    'from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and '+
    ' B.TENANT_ID='+token.tenantId+' and B.CHANGE_DATE>='+formatDatetime('YYYYMMDD',_beginDate)+' and B.CHANGE_DATE<='+formatDatetime('YYYYMMDD',_endDate)+' '+
    ' and A.AMOUNT <> 0 '+
    'order by A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,B.CHANGE_DATE,B.CREA_DATE ';
  dataFactory.ExecSQL(sql);
  RzProgressBar1.Percent := 45;
  if dataFactory.iDbType=1 then
     begin
       tmpIdValue := 'rownum+'+inttostr(rw)+',';
     end;
  sql :=
    'insert into '+tmpTable+' '+
    ' ('+id+'TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO,'+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02,'+
    ' IN_AMOUNT,IN_PRICE,IN_MONEY,IN_TAX,OUT_AMOUNT,OUT_PRICE,OUT_MONEY,SALE_PRICE,SALE_MONEY,SALE_TAX,BAL_AMOUNT,BAL_PRICE,BAL_MONEY,'+
    ' GUIDE_USER,CREA_USER) '+
    'select '+
    ' '+tmpIdValue+'TENANT_ID,SHOP_ID,BILL_ID,BILL_CODE,BILL_TYPE,BILL_NAME,BILL_DATE,SEQNO,'+
    ' GODS_ID,CLIENT_ID,UNIT_ID,CONV_RATE,BATCH_NO,PROPERTY_01,PROPERTY_02,'+
    ' IN_AMOUNT,IN_PRICE,IN_MONEY,IN_TAX,OUT_AMOUNT,OUT_PRICE,OUT_MONEY,SALE_PRICE,SALE_MONEY,SALE_TAX,BAL_AMOUNT,BAL_PRICE,BAL_MONEY,'+
    ' GUIDE_USER,CREA_USER '+
    'from '+seqTable+' order by GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,BILL_DATE,ID';
  rw := rw + dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.Prepare;
var
  sql:string;
begin
  case dataFactory.iDbType of
  5:begin
      sql :=
        'update '+tmpTable+' set '+
        'SEQNO=(select ifnull(max(SEQNO),1) from '+tmpTable+' B '+
        'where '+
        '  B.SHOP_ID='+tmpTable+'.SHOP_ID and  '+
        '  B.GODS_ID='+tmpTable+'.GODS_ID and  '+
        '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
        '  B.ID<'+tmpTable+'.ID '+
        ')+2 '+
        'where BILL_TYPE>1 ';
    end;
  else
    begin
      sql :=
        'update '+tmpTable+' set '+
        'SEQNO=(select ifnull(max(SEQNO),1)+count(*)*2 from '+tmpTable+' B '+
        'where '+
        '  B.SHOP_ID='+tmpTable+'.SHOP_ID and  '+
        '  B.GODS_ID='+tmpTable+'.GODS_ID and  '+
        '  B.BATCH_NO='+tmpTable+'.BATCH_NO and '+
        '  B.ID<'+tmpTable+'.ID '+
        ') '+
        'where BILL_TYPE>1 ';
    end;
  end;
  sql := parseSQL(dataFactory.iDbType,sql);
  dataFactory.ExecSQL(sql);
end;

procedure TfrmStocksCalc.ClearRck;
begin
  dataFactory.ExecSQL('delete from RCK_STOCKS_DATA where TENANT_ID='+token.tenantId+' and BILL_DATE>'+inttostr(lastDate));
end;

procedure TfrmStocksCalc.btnCalcClick(Sender: TObject);
begin
  inherited;
  CheckAppVersion;
  ClearDays;
  _endDate := 0;
  while _endDate<eDate do creaStocks;
  ModalResult := MROK;
end;

procedure TfrmStocksCalc.WMStart(var Message: TMessage);
begin
  Update;
  btnCalc.OnClick(nil);
end;

procedure TfrmStocksCalc.ClearDays;
var
  rs:TZQuery;
begin
  lastDate := getLastDate;
  if lastDate=0 then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select min(BILL_DATE) from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:LAST_DATE and BAL_AMOUNT<0 and BILL_TYPE>1';
    rs.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId); 
    rs.ParamByName('D1').AsInteger := lastDate div 100 *100 +1; 
    rs.ParamByName('LAST_DATE').AsInteger := lastDate;
    dataFactory.Open(rs);
    if rs.Fields[0].AsInteger>0 then
       begin
         dataFactory.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID='+token.tenantId+' and CREA_DATE>='+rs.Fields[0].asString);
       end;
  finally
    rs.Free;
  end;
end;

procedure TfrmStocksCalc.CheckAppVersion;
var
  rs:TZQuery;
  appVersion:string;
  params:TftParamList;
begin
  rs := TZQuery.Create(nil);
  params := TftParamList.Create;
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('DEFINE').AsString := 'APPVERSION';
    dataFactory.Open(rs);
    AppVersion := rs.Fields[0].AsString;
    if AppVersion = '' then AppVersion := 'V3';
    if AppVersion <> 'V6' then
       begin
         dataFactory.ExecProc('TCheckAppVersion',params);
       end;
  finally
    params.Free;
    rs.Free;
  end;
end;

procedure TfrmStocksCalc.FormCreate(Sender: TObject);
begin
  inherited;
  tmpTable := 'TMP_SC_'+token.tenantId;
  seqTable := 'SEQ_SC_'+token.tenantId;
  prcTable := 'PRC_SC_'+token.tenantId;
end;

procedure TfrmStocksCalc.DropSQLTable(tb:string);
var
  rs:TZQuery;
begin
  case dataFactory.iDbType of
   0:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select OBJECT_ID(N''tempdb..'+tb+''')';
        dataFactory.Open(rs);
        if rs.Fields[0].AsString <> '' then dataFactory.ExecSQL('drop table '+tb);
      finally
        rs.Free;
      end;
    end;
  1:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select count(*) from user_tables where table_name='''+tb+'''';
        dataFactory.Open(rs);
        if rs.Fields[0].asInteger <> 0 then dataFactory.ExecSQL('drop table '+tb);
      finally
        rs.Free;
      end;
    end;
  4:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select count(*) from syscat.tables where tabname='''+tb+'''';
        dataFactory.Open(rs);
        if rs.Fields[0].asInteger <> 0 then dataFactory.ExecSQL('drop table '+tb);
      finally
        rs.Free;
      end;
    end;
  5:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select count(*) from sqlite_master where type=''table'' and name='''+tb+'''';
        dataFactory.Open(rs);
        if rs.Fields[0].asInteger > 0 then dataFactory.ExecSQL('drop table '+tb);
      finally
        rs.Free;
      end;
    end;
  end;
end;

end.
