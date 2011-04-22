unit uPrainpowerJudge;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ZDataSet, DB, ZBase, Variants, ZLogFile;

type
  TPrainpowerJudge=class
  private
  public
    function EncodeSql:String;
    function GetQustionList:String;
    function GetQustionNum:Integer;
  end;

var PrainpowerJudge:TPrainpowerJudge;
  
implementation
uses ufrmLogo,uShopGlobal,EncDec,ZLibExGZ,uGlobal,IniFiles;


{ TPrainpowerJudge }

function TPrainpowerJudge.EncodeSql: String;
var Sql,Str_Sql:String;
begin
  if ShopGlobal.GetChkRight('11100001',5) then                //�������������Ȩ��     actfrmStkIndentOrderList  ��  STK_INDENTORDER
    Sql := ' select ''actfrmStkIndentOrderList'' as MSG_ID,''����������'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,1 as ORDER_NO '+
    ' from STK_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'') ';

  if ShopGlobal.GetChkRight('11200001',5) then                //�����������Ȩ��       actfrmStockOrderList    ��   STK_STOCKORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + ' select ''actfrmStockOrderList'' as MSG_ID,''��������''  as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,2 as ORDER_NO '+
      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=1 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'')';
    end;

  if ShopGlobal.GetChkRight('11300001',5) then                //�ɹ��˻��������Ȩ��   actfrmStkRetuOrderList   ��   STK_STOCKORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmStkRetuOrderList'' as MSG_ID,''���ɹ��˻���'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,3 as ORDER_NO '+
      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12300001',7) then                //���۶��������Ȩ��     actfrmSalIndentOrderList   ��   SAL_INDENTORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + ' select ''actfrmSalIndentOrderList'' as MSG_ID,''�����۶���''  as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,4 as ORDER_NO '+
      'from SAL_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12400001',7) then                //���۵������Ȩ��       actfrmSalesOrderList    ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmSalesOrderList'' as MSG_ID,''�����۵�'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,5 as ORDER_NO '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=1 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12500001',7) then                //�����˻��������Ȩ��   actfrmSalRetuOrderList    ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmSalRetuOrderList'' as MSG_ID,''�������˻���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,7 as ORDER_NO '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=3 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('14100001',6) then                //������ε������Ȩ��   actfrmDbOrderList   ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmDbOrderList'' as MSG_ID,''��������'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,6 as ORDER_NO '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=2 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and COMM not in (''02'',''12'')';
    end;

  Str_Sql := 'select MSG_ID,MSG_TITLE,SUM_ORDER from( '+Sql+' ) as j order by ORDER_NO ';

  if Trim(Sql) <> '' then
    Result := Str_Sql
  else
    Result := '';

end;

function TPrainpowerJudge.GetQustionList: String;
var Str_Sql:String;
begin
  Str_Sql :=
  ' select a.QUESTION_ID,b.QUESTION_TITLE,b.QUESTION_CLASS,b.QUESTION_ITEM_AMT,b.ISSUE_DATE '+
  ' from MSC_INVEST_LIST a left join MSC_QUESTION b on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
  ' where a.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and a.SHOP_ID='+Global.SHOP_ID+' and a.QUESTION_ANSWER_STATUS=2';
  Result := Str_Sql;
end;

function TPrainpowerJudge.GetQustionNum: Integer;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := ' select count(a.QUESTION_ID) as QUESTION_NUM '+
    ' from MSC_INVEST_LIST a left join MSC_QUESTION b on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
    ' where a.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and a.SHOP_ID='+Global.SHOP_ID+' and a.QUESTION_ANSWER_STATUS=2';
    Factor.Open(rs);
    Result := rs.FieldByName('QUESTION_NUM').AsInteger;
  finally
    rs.Free;
  end;
end;

end.
