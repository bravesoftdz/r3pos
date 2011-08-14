unit uPrainpowerJudge;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ObjCommon, ZDataSet, DB, ZBase, Variants, ZLogFile;
type
  TPrainpowerJudge=class
  private
  public
    List:TZQuery;
    Locked:integer;
    constructor Create;
    destructor  Destroy;override;
    procedure SyncMsgc;
    function EncodeSql:String;
    function EncodeSql1:String;
    procedure Load(flag:Integer=0);
  end;

var PrainpowerJudge:TPrainpowerJudge;
  
implementation
uses uGlobal,uCaFactory,uTimerFactory,uShopGlobal,uSyncFactory,ufrmHintMsg, DateUtils;


{ TPrainpowerJudge }

constructor TPrainpowerJudge.Create;
begin
  Locked := 0;
  List := TZQuery.Create(nil);
end;

destructor TPrainpowerJudge.Destroy;
begin
  List.Free;
  inherited;
end;

function TPrainpowerJudge.EncodeSql: String;
var Sql,Str_Sql,Str_Bir:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''12'',''02'') ';
    Factor.Open(rs);
    rs.Filtered := False;
    rs.Filter := ' DEFINE=''AUDIT_HINT'' ';
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      begin
        if ShopGlobal.GetChkRight('11100001',5) then                //进货订单的审核权限     actfrmStkIndentOrderList  表  STK_INDENTORDER
          Sql := ' select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''进货订单'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,1 as sFlag '+
          ' from STK_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';

        if ShopGlobal.GetChkRight('11200001',5) then                //进货单的审核权限       actfrmStockOrderList    表   STK_STOCKORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmStockOrderList'' as ID,4 as MSG_CLASS,''进货入库'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,2 as sFlag '+
            'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and LOCUS_STATUS=''3'' ';
          end;

        if ShopGlobal.GetChkRight('11300001',5) then                //采购退货单的审核权限   actfrmStkRetuOrderList   表   STK_STOCKORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmStkRetuOrderList'' as ID,4 as MSG_CLASS,''采购退货单'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,3 as sFlag '+
            'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('12300001',7) then                //销售订单的审核权限     actfrmSalIndentOrderList   表   SAL_INDENTORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''销售订单'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,4 as sFlag '+
            'from SAL_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('12400001',7) then                //销售单的审核权限       actfrmSalesOrderList    表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmSalesOrderList'' as ID,4 as MSG_CLASS,''销售出库'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,5 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''1'' or LOCUS_STATUS is null)';
          end;

        if ShopGlobal.GetChkRight('12500001',7) then                //销售退货单的审核权限   actfrmSalRetuOrderList    表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmSalRetuOrderList'' as ID,4 as MSG_CLASS,''销售退货单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,6 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('14100001',6) then                //出库调拔单的审核权限   actfrmDbOrderList   表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmDbOrderList'' as ID,4 as MSG_CLASS,''调拨单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,7 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'')';
          end;
      end;

    if ShopGlobal.GetChkRight('33400001',1) then                //会员生日提醒     actfrmCustomer  表  PUB_CUSTOMER
      begin
        rs.Filtered := False;
        rs.Filter := ' DEFINE=''BIRTHDAY'' ';
        rs.Filtered := True;
        if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
          begin
            case Factor.iDbType of
              0:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(isnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''+substring(isnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(BIRTHDAY,''          ''),5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              1,
              4:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(nvl(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(nvl(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              5:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
            end;
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''会员生日'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,'''+rs.FieldByName('VALUE').AsString+''' as MIN_DATE,9 as sFlag '+
            ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and BIRTHDAY is not null and ' + Str_Bir;
          end;

        rs.Filtered := False;
        rs.Filter := ' DEFINE=''CUSTCONTINU'' ';
        rs.Filtered := True;
        if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
          begin
            case Factor.iDbType of
              0:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(isnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''+substring(isnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              1,
              4:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(nvl(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(nvl(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              5:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                           ' ('''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
            end;
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''会员续会'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,'''+rs.FieldByName('VALUE').AsString+''' as MIN_DATE,10 as sFlag '+
            ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and CON_DATE is not null and '+ Str_Bir;
          end;
      end;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''PLANDATE_HINT'' ';
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      begin
        if ShopGlobal.GetChkRight('12400001',2) then                //销售订单未生成销售出货单   actfrmSalIndentOrderList    表   SAL_INDENTORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''销售订单'' as MSG_TITLE,sum(case when SALBILL_STATUS=0 then 100000 else 1 end) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,11 as sFlag '+
            'from SAL_INDENTORDER where CHK_USER is not null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and SALBILL_STATUS in (0,1) ';
          end;

        if ShopGlobal.GetChkRight('11200001',2) then                //进货订单未生成进货入库单   actfrmStkIndentOrderList   表   STK_INDENTORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''进货订单'' as MSG_TITLE,sum(case when STKBILL_STATUS=0 then 100000 else 1 end) as SUM_ORDER,min(CREA_DATE) as MIN_DATE,12 as sFlag '+
            'from STK_INDENTORDER where CHK_USER is not null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and STKBILL_STATUS in (0,1)';
          end;
      end;

    if Trim(Sql) <> '' then Sql := Sql + ' union all ';
    Sql := Sql + ' select a.QUESTION_ID as ID,1 as MSG_CLASS,b.QUESTION_TITLE as MSG_TITLE,1 SUM_ORDER,'''' as MIN_DATE,8 as sFlag '+
    ' from MSC_INVEST_LIST a,MSC_QUESTION b where a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
    ' and a.TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and a.SHOP_ID='''+ShopGlobal.SHOP_ID+''' and a.QUESTION_ANSWER_STATUS=2';

    Str_Sql := 'select * from( '+ParseSQL(Factor.iDbType,Sql)+' ) j order by sFlag ';

  finally
    rs.Free;
  end;
  Result := Str_Sql;
end;

function TPrainpowerJudge.EncodeSql1: String;
var Sql,Str_Sql:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''12'',''02'') ';
    Factor.Open(rs);
    rs.Filtered := False;
    rs.Filter := ' DEFINE=''AUDIT_HINT'' ';
    rs.Filtered := True;

    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      begin
        if ShopGlobal.GetChkRight('14700001',2) then                //出库发货单的新增权限   actfrmOutLocusOrderList   表  ,
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //销售单出库  SAL_SALESORDER
            Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''销售出库发货单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,13 as sFlag '+
            'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''1'' or LOCUS_STATUS is null)';

            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //调拔单出库  SAL_SALESORDER
            Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''调拔出库发货单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,14 as sFlag '+
            'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''1'' or LOCUS_STATUS is null)';

            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //调整单出库  STO_CHANGEORDER
            Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''进货入库发货单'' as MSG_TITLE,count(CHANGE_ID) as SUM_ORDER,min(CHANGE_DATE) as MIN_DATE,15 as sFlag '+
            'from STO_CHANGEORDER where CHK_DATE is not null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''1'' or LOCUS_STATUS is null)';

            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //采购退货单出库  SAL_SALESORDER
            Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''采购退货发货单'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,16 as sFlag '+
            'from STK_STOCKORDER where CHK_DATE is not null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''1'' or LOCUS_STATUS is null)';
          end;

        if ShopGlobal.GetChkRight('14600001',2) then                //入库收货单的新增权限   actfrmInLocusOrderList   表
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //进货单入库  STK_STOCKORDER
            Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''进货入库收货单'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,17 as sFlag '+
            'from STK_STOCKORDER where STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''2'' or LOCUS_STATUS is null)';

            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //销售退货单入库  SAL_SALESORDER
            Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''销售退货收货单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,18 as sFlag '+
            'from SAL_SALESORDER where SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS=''2'' or LOCUS_STATUS is null)';
          end;

        if ShopGlobal.GetChkRight('21300001',2) then                //应收款新增权限   actfrmRecvOrderList   表   ACC_RECVABLE_INFO
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //预收款单RECV_TYPE = '3'\应收款单RECV_TYPE = '1'   ACC_RECVABLE_INFO
            Sql := Sql + 'select ''actfrmRecvOrderList'' as ID,4 as MSG_CLASS,''预收/应收款单'' as MSG_TITLE,count(case when RECV_TYPE = ''3'' then 100000 when RECV_TYPE = ''1'' then 1 end) as SUM_ORDER,min(ABLE_DATE) as MIN_DATE,19 as sFlag '+
            'from ACC_RECVABLE_INFO where isnull(RECK_MNY,0)<>0  and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('21400001',2) then                //应付款新增权限   actfrmPayOrderList   表   ACC_PAYABLE_INFO
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //预付款单ABLE_TYPE = '6'\应付款单ABLE_TYPE = '4'   ACC_PAYABLE_INFO
            Sql := Sql + 'select ''actfrmPayOrderList'' as ID,4 as MSG_CLASS,''预付/应付款单'' as MSG_TITLE,count(case when ABLE_TYPE = ''6'' then 100000 when ABLE_TYPE = ''4'' then 1 end) as SUM_ORDER,min(ABLE_DATE) as MIN_DATE,20 as sFlag '+
            'from ACC_PAYABLE_INFO where isnull(RECK_MNY,0)<>0  and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('21300001',5) then                //应收款审核权限   actfrmRecvOrderList   表   ACC_RECVORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //收款单   ACC_RECVORDER
            Sql := Sql + 'select ''actfrmRecvOrderList'' as ID,4 as MSG_CLASS,''收款单'' as MSG_TITLE,count(RECV_FLAG) as SUM_ORDER,min(RECV_DATE) as MIN_DATE,21 as sFlag '+
            'from ACC_RECVORDER where RECV_FLAG=''0'' and CHK_DATE is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('21400001',5) then                //应付款审核权限   actfrmPayOrderList   表   ACC_PAYORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //付款单   ACC_PAYORDER
            Sql := Sql + 'select ''actfrmPayOrderList'' as ID,4 as MSG_CLASS,''付款单'' as MSG_TITLE,count(PAY_ID) as SUM_ORDER,min(PAY_DATE) as MIN_DATE,22 as sFlag '+
            'from ACC_PAYORDER where CHK_DATE is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;
      end;
  finally
    rs.Free;
  end;

  if Trim(Sql) <> '' then Str_Sql := 'select * from( '+ParseSQL(Factor.iDbType,Sql)+' ) j order by sFlag ';
  
  Result := Str_Sql;

end;

procedure TPrainpowerJudge.Load(flag:Integer=0);
var Msg:PMsgInfo;
    rs:TZQuery;
    Sql_Str:String;
begin
  MsgFactory.ClearType(4);
  if flag<>0 then Exit;
  List.Close;
  List.SQL.Text := EncodeSQL;
  uGlobal.Factor.Open(List);
  List.First;
  while not List.Eof do
    begin
      if List.FieldByName('SUM_ORDER').AsInteger = 0 then
        begin
          List.Next;
          Continue;
        end;
      new(Msg);
      Msg^.ID := List.FieldbyName('ID').AsString;
      msg^.Title := List.FieldbyName('MSG_TITLE').AsString;
      if List.FieldbyName('sFlag').AsInteger = 8 then
        Msg^.Contents := '"'+List.FieldbyName('MSG_TITLE').AsString+'" 待您答复！'
      else if List.FieldbyName('sFlag').AsInteger = 9 then
        Msg^.Contents := '您有 '+List.FieldbyName('SUM_ORDER').AsString+' 位客户近期过生日！'
      else if List.FieldbyName('sFlag').AsInteger = 10 then
        Msg^.Contents := '您有 '+List.FieldbyName('SUM_ORDER').AsString+' 位客户近期要继会！'
      else if List.FieldbyName('sFlag').AsInteger = 11 then
        Msg^.Contents := '您有 ('+IntToStr(List.FieldbyName('SUM_ORDER').AsInteger div 100000)+')单待发货、('+IntToStr(List.FieldbyName('SUM_ORDER').AsInteger mod 100000)+')单发货中'
      else if List.FieldbyName('sFlag').AsInteger = 12 then
        Msg^.Contents := '您有 ('+IntToStr(List.FieldbyName('SUM_ORDER').AsInteger div 100000)+')单待入库、('+IntToStr(List.FieldbyName('SUM_ORDER').AsInteger mod 100000)+')单入库中'
      else
        Msg^.Contents := ' 您有('+List.FieldbyName('SUM_ORDER').AsString+')张 "'+List.FieldbyName('MSG_TITLE').AsString+'" 没有审核！';
      Msg^.sFlag := List.FieldbyName('sFlag').AsInteger;
      Msg^.Msg_Class := List.FieldbyName('MSG_CLASS').AsInteger;
      MsgFactory.Add(Msg);
      MsgFactory.MsgRead[Msg] := False;
      List.Next;
    end;

  Sql_Str := EncodeSql1;
  if Sql_Str <> '' then
    begin
      try
      rs := TZQuery.Create(nil);
      rs.Close;
      rs.SQL.Text := Sql_Str;

      uGlobal.Factor.Open(rs);

      rs.First;
      while not rs.Eof do
        begin
          if rs.FieldByName('SUM_ORDER').AsInteger = 0 then
            begin
              rs.Next;
              Continue;
            end;
          new(Msg);
          Msg^.ID := rs.FieldbyName('ID').AsString;
          msg^.Title := rs.FieldbyName('MSG_TITLE').AsString;
          if rs.FieldbyName('sFlag').AsInteger = 13 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码发货！'
          else if rs.FieldbyName('sFlag').AsInteger = 14 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码发货！'
          else if rs.FieldbyName('sFlag').AsInteger = 15 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码发货！'
          else if rs.FieldbyName('sFlag').AsInteger = 16 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码发货！'
          else if rs.FieldbyName('sFlag').AsInteger = 17 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码收货！'
          else if rs.FieldbyName('sFlag').AsInteger = 18 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待扫码收货！'
          else if rs.FieldbyName('sFlag').AsInteger = 19 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待收款！'
          else if rs.FieldbyName('sFlag').AsInteger = 20 then
            Msg^.Contents := '您有 ('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 待付款！'
          else
            Msg^.Contents := ' 您有('+rs.FieldbyName('SUM_ORDER').AsString+')张 "'+rs.FieldbyName('MSG_TITLE').AsString+'" 没有审核！';

          Msg^.sFlag := rs.FieldbyName('sFlag').AsInteger;
          Msg^.Msg_Class := rs.FieldbyName('MSG_CLASS').AsInteger;
          MsgFactory.Add(Msg);
          MsgFactory.MsgRead[Msg] := False;
          List.Append;
          List.FieldByName('ID').AsString := rs.FieldByName('ID').AsString;
          List.FieldByName('MSG_CLASS').AsInteger := rs.FieldByName('MSG_CLASS').AsInteger;
          List.FieldByName('MSG_TITLE').AsString := rs.FieldByName('MSG_TITLE').AsString;
          List.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger;
          List.FieldByName('MIN_DATE').AsInteger := rs.FieldByName('MIN_DATE').AsInteger;
          List.FieldByName('sFlag').AsInteger := rs.FieldByName('sFlag').AsInteger;
          List.Post;

          rs.Next;
        end;
      finally
        rs.Free;
      end;
    end;
end;

procedure TPrainpowerJudge.SyncMsgc;
var
  Params:TftParamList;
begin
  InterlockedIncrement(Locked);
  try
  //本地连接时不需同步
  if Global.RemoteFactory.ConnMode = 1 then Exit;
  if not CaFactory.Audited then Exit;
  if not Global.RemoteFactory.Connected then
     begin
      try
        Global.RemoteFactory.Connect;
      except
        Exit;
      end;
     end;
  if TimerFactory.Terminated then Exit;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Params.ParamByName('flag').AsInteger := 2;
    try
      Global.RemoteFactory.ExecProc('TSyncMessage',Params);
    except
      Exit;
    end;
    //同步到本地
    if not ShopGlobal.ONLVersion and ShopGlobal.offline then
    begin
      sleep(1000);
      if TimerFactory.Terminated then Exit;
      SyncFactory.SyncTimeStamp := CaFactory.RspTimeStamp;
      SyncFactory.SyncSingleTable('MSC_MESSAGE','TENANT_ID;MSG_ID','TSyncSingleTable',0,true);
      if TimerFactory.Terminated then Exit;
      SyncFactory.SyncSingleTable('MSC_MESSAGE_LIST','TENANT_ID;MSG_ID;SHOP_ID','TSyncSingleTable',0,true);
    end;
  finally
    Params.Free;
  end;
  finally
    InterlockedDecrement(Locked);
  end;
end;

initialization
  PrainpowerJudge := TPrainpowerJudge.Create;
finalization
  PrainpowerJudge.Free;
end.
