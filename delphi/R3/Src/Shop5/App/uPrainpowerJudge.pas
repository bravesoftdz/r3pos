unit uPrainpowerJudge;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ZDataSet, DB, ZBase, Variants, ZLogFile;

type
  TPrainpowerJudge=class
  private
  public
    List:TZQuery;
    constructor Create;
    destructor  Destroy;override;
    function EncodeSql:String;
    procedure Load;
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
var Sql,Str_Sql:String;
begin
  if ShopGlobal.GetChkRight('11100001',5) then                //�������������Ȩ��     actfrmStkIndentOrderList  ��  STK_INDENTORDER
    Sql := ' select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''��������'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,1 as sFlag '+
    ' from STK_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';

  if ShopGlobal.GetChkRight('11200001',5) then                //�����������Ȩ��       actfrmStockOrderList    ��   STK_STOCKORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + ' select ''actfrmStockOrderList'' as ID,4 as MSG_CLASS,''������'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,2 as sFlag '+
      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'')';
    end;

  if ShopGlobal.GetChkRight('11300001',5) then                //�ɹ��˻��������Ȩ��   actfrmStkRetuOrderList   ��   STK_STOCKORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmStkRetuOrderList'' as ID,4 as MSG_CLASS,''�ɹ��˻���'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,3 as sFlag '+
      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12300001',7) then                //���۶��������Ȩ��     actfrmSalIndentOrderList   ��   SAL_INDENTORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + ' select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''���۶���'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,4 as sFlag '+
      'from SAL_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12400001',7) then                //���۵������Ȩ��       actfrmSalesOrderList    ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmSalesOrderList'' as ID,4 as MSG_CLASS,''���۵�'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,5 as sFlag '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('12500001',7) then                //�����˻��������Ȩ��   actfrmSalRetuOrderList    ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmSalRetuOrderList'' as ID,4 as MSG_CLASS,''�����˻���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,6 as sFlag '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'') ';
    end;

  if ShopGlobal.GetChkRight('14100001',6) then                //������ε������Ȩ��   actfrmDbOrderList   ��   SAL_SALESORDER
    begin
      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
      Sql := Sql + 'select ''actfrmDbOrderList'' as ID,4 as MSG_CLASS,''������'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,7 as sFlag '+
      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID)+' and COMM not in (''02'',''12'')';
    end;

  if Trim(Sql) <> '' then Sql := Sql + ' union all ';
  Sql := Sql + ' select a.QUESTION_ID as ID,1 as MSG_CLASS,b.QUESTION_TITLE as MSG_TITLE,1 SUM_ORDER,8 as sFlag '+
  ' from MSC_INVEST_LIST a left join MSC_QUESTION b on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
  ' where a.TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and a.SHOP_ID='''+ShopGlobal.SHOP_ID+''' and a.QUESTION_ANSWER_STATUS=2';

  Str_Sql := 'select * from( '+Sql+' ) as j order by sFlag ';

  Result := Str_Sql
end;

procedure TPrainpowerJudge.Load;
var Msg:PMsgInfo;
begin
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
      Msg^.Contents := ' ����('+List.FieldbyName('SUM_ORDER').AsString+')�� "'+List.FieldbyName('MSG_TITLE').AsString+'" û����ˣ�';
      Msg^.sFlag := List.FieldbyName('sFlag').AsInteger;
      Msg^.Msg_Class := List.FieldbyName('MSG_CLASS').AsInteger;
      MsgFactory.Add(Msg);
      List.Next;
    end;
end;

initialization
  PrainpowerJudge := TPrainpowerJudge.Create;
finalization
  PrainpowerJudge.Free;
end.
