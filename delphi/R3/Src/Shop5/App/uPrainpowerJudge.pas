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
    constructor Create;
    destructor  Destroy;override;
    function EncodeSql:String;
    procedure Load(flag:Integer=0);
  end;

var PrainpowerJudge:TPrainpowerJudge;
  
implementation
uses uGlobal,uShopGlobal,ufrmHintMsg;


{ TPrainpowerJudge }

constructor TPrainpowerJudge.Create;
begin
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
          Sql := ' select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''进货订单'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,1 as sFlag '+
          ' from STK_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';

        if ShopGlobal.GetChkRight('11200001',5) then                //进货单的审核权限       actfrmStockOrderList    表   STK_STOCKORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmStockOrderList'' as ID,4 as MSG_CLASS,''进货单'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,2 as sFlag '+
            'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'')';
          end;

        if ShopGlobal.GetChkRight('11300001',5) then                //采购退货单的审核权限   actfrmStkRetuOrderList   表   STK_STOCKORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmStkRetuOrderList'' as ID,4 as MSG_CLASS,''采购退货单'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,3 as sFlag '+
            'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('12300001',7) then                //销售订单的审核权限     actfrmSalIndentOrderList   表   SAL_INDENTORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''销售订单'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,4 as sFlag '+
            'from SAL_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('12400001',7) then                //销售单的审核权限       actfrmSalesOrderList    表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmSalesOrderList'' as ID,4 as MSG_CLASS,''销售单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,5 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('12500001',7) then                //销售退货单的审核权限   actfrmSalRetuOrderList    表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmSalRetuOrderList'' as ID,4 as MSG_CLASS,''销售退货单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,6 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;

        if ShopGlobal.GetChkRight('14100001',6) then                //出库调拔单的审核权限   actfrmDbOrderList   表   SAL_SALESORDER
          begin
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + 'select ''actfrmDbOrderList'' as ID,4 as MSG_CLASS,''调拨单'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,7 as sFlag '+
            'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'')';
          end;
      end;

    {rs.Close;
    rs.SQL.Text := 'select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and DEFINE=''BIRTHDAY'' and COMM not in (''12'',''02'') ';
    Factor.Open(rs);
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger > 1) then
      begin
        if ShopGlobal.GetChkRight('33400001',1) then                //会员生日提醒     actfrmCustomer  表  PUB_CUSTOMER
          begin
            case Factor.iDbType of
              0:Str_Bir := ' DateDiff(Day,DateAdd(year,DateDiff(year,Birthday,GetDate()),Birthday),GetDate()) between  -'+rs.FieldByName('VALUE').AsString+' and 0 ';
              4:Str_Bir := ' julianday('''+copy(FormatDateTime('YYYY-MM-DD',Date),1,4)+'''||substr(BIRTHDAY,5,10))-julianday('''+FormatDateTime('YYYY-MM-DD',Date)+''') >= '+rs.FieldByName('VALUE').AsString;
              5:Str_Bir := '';
            end;
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''会员生日'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,9 as sFlag '+
            ' from PUB_CUSTOMER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
          end;
      end; }

    if ShopGlobal.GetChkRight('33400001',1) then                //会员生日提醒     actfrmCustomer  表  PUB_CUSTOMER
      begin
        rs.Filtered := False;
        rs.Filter := ' DEFINE=''BIRTHDAY'' ';
        rs.Filtered := True;
        if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
          begin
            case Factor.iDbType of
              0:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(BIRTHDAY,5,10) and '''+FormatDateTime('YYYY',Date())+'''+substring(BIRTHDAY,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
              4:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(BIRTHDAY,5,10) and '''+FormatDateTime('YYYY',Date())+'''||substr(BIRTHDAY,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
              5:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(BIRTHDAY,5,10) and '''+FormatDateTime('YYYY',Date())+'''||substr(BIRTHDAY,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
            end;
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''会员生日'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,9 as sFlag '+
            ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and ' + Str_Bir;
          end;

        rs.Filtered := False;
        rs.Filter := ' DEFINE=''CUSTCONTINU'' ';
        rs.Filtered := True;
        if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
          begin
            case Factor.iDbType of
              0:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(CON_DATE,5,10) and '''+FormatDateTime('YYYY',Date())+'''+substring(CON_DATE,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
              4:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(CON_DATE,5,10) and '''+FormatDateTime('YYYY',Date())+'''||substr(CON_DATE,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
              5:Str_Bir := ''''+FormatDateTime('YYYY-MM-DD',Date()+rs.FieldByName('VALUE').AsInteger)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(CON_DATE,5,10) and '''+FormatDateTime('YYYY',Date())+'''||substr(CON_DATE,5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''';
            end;
            if Trim(Sql) <> '' then Sql := Sql + ' union all ';
            Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''会员续会'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,10 as sFlag '+
            ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') and '+ Str_Bir;
          end;
      end;

    if Trim(Sql) <> '' then Sql := Sql + ' union all ';
    Sql := Sql + ' select a.QUESTION_ID as ID,1 as MSG_CLASS,b.QUESTION_TITLE as MSG_TITLE,1 SUM_ORDER,8 as sFlag '+
    ' from MSC_INVEST_LIST a left join MSC_QUESTION b on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
    ' where a.TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and a.SHOP_ID='''+ShopGlobal.SHOP_ID+''' and a.QUESTION_ANSWER_STATUS=2';

    Str_Sql := 'select * from( '+Sql+' ) as j order by sFlag ';
  finally
    rs.Free;
  end;
  Result := Str_Sql
end;

procedure TPrainpowerJudge.Load(flag:Integer=0);
var Msg:PMsgInfo;
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
      Msg^.Contents := ' 你有('+List.FieldbyName('SUM_ORDER').AsString+')张 "'+List.FieldbyName('MSG_TITLE').AsString+'" 没有审核！';
      Msg^.sFlag := List.FieldbyName('sFlag').AsInteger;
      Msg^.Msg_Class := List.FieldbyName('MSG_CLASS').AsInteger;
      MsgFactory.Add(Msg);
      MsgFactory.MsgRead[Msg] := False;
      List.Next;
    end;
end;

initialization
  PrainpowerJudge := TPrainpowerJudge.Create;
finalization
  PrainpowerJudge.Free;
end.
