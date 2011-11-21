unit uPrainpowerJudge;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ObjCommon, ZDataSet, DB, ZBase, Variants, ZLogFile;
type
  TPrainpowerJudge=class
  private
    IsHint,IsBirthday,IsCustContinu,IsPlanDate,IsStorage,IsAudit,IsAccount:Boolean;
    Birthday_Num,CustContinu_Num:Integer;
    FNumeration: Integer;
    procedure GetIsHint;
    function EncodeRemindSql(SEQ:Integer):String;
    procedure SetNumeration(const Value: Integer);
    procedure DataAnalysis(SEQ:Integer;rs:TZQuery);
  public
    List:TZQuery;
    Locked:integer;
    constructor Create;
    destructor  Destroy;override;
    procedure SyncMsgc;
    procedure Load(flag:Integer=0);
    property Numeration:Integer read FNumeration write SetNumeration;
  end;

var PrainpowerJudge:TPrainpowerJudge;

implementation
uses uGlobal,uCaFactory,uTimerFactory,uShopGlobal,uSyncFactory,ufrmHintMsg, DateUtils;


{ TPrainpowerJudge }

constructor TPrainpowerJudge.Create;
begin
  Locked := 0;
  Numeration := 1;
  List := TZQuery.Create(nil);
  with List.FieldDefs do
    begin
      Add('ID',ftString,50,False);
      Add('MSG_CLASS',ftInteger,0,False);
      Add('MSG_TITLE',ftString,50,False);
      Add('SUM_ORDER',ftInteger,0,False);
      Add('MIN_DATE',ftInteger,0,False);
      Add('sFlag',ftInteger,0,False);
    end;
  List.CreateDataSet;
end;

procedure TPrainpowerJudge.DataAnalysis(SEQ: Integer;rs:TZQuery);
var Temp:TZQuery;
    i:Integer;
begin
  if SEQ = 1 then
    begin
      List.EmptyDataSet;
      List.CreateDataSet;
    end;
  GetIsHint;

  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text := EncodeRemindSql(SEQ);
    if Trim(Temp.SQL.Text) = '' then Exit;
    Factor.Open(Temp);

    case SEQ of
      1:begin   //  STK_INDENTORDER   �ɹ�������
        if (Temp.FieldByName('CHK_NO').AsInteger > 0) and ShopGlobal.GetChkRight('11100001',5) and IsAudit then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmStkIndentOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '��������';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldbyName('CHK_NO').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('MIN_DATE_1').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 1;
          rs.Post;
          {if IsAudit then
            begin
              if ShopGlobal.GetChkRight('11100001',5) then                //�ɹ����������Ȩ��     actfrmStkIndentOrderList  ��  STK_INDENTORDER
                Sql := ' select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''��������'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,min(INDE_DATE) as MIN_DATE,1 as sFlag '+
                ' from STK_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
            end;}
        end;

        if (Temp.FieldByName('STATUS').AsInteger > 0) and ShopGlobal.GetChkRight('11200001',2) and IsPlanDate then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmStkIndentOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '��������';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('STATUS').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('MIN_DATE_2').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 12;
          rs.Post;
          {if IsPlanDate then
            begin
              if ShopGlobal.GetChkRight('11200001',2) then                //�ɹ�����δ���ɽ�����ⵥ   actfrmStkIndentOrderList   ��   STK_INDENTORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                  Sql := Sql + 'select ''actfrmStkIndentOrderList'' as ID,4 as MSG_CLASS,''��������'' as MSG_TITLE,sum(case when STKBILL_STATUS=0 then 100000 else 1 end) as SUM_ORDER,min(INDE_DATE) as MIN_DATE,12 as sFlag '+
                  'from STK_INDENTORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and STKBILL_STATUS in (0,1)';
                end;
            end;}
        end;

      end;
      2:begin   //  STK_STOCKORDER   ����(��)��ⵥ��
        Temp.First;
        while not Temp.Eof do
        begin
          if Temp.FieldByName('STOCK_TYPE').AsInteger = 1 then
          begin
            if (Temp.FieldByName('CHK_NO').AsInteger > 0) and ShopGlobal.GetChkRight('11200001',5) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmStockOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�������';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_NO').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CHK_NO_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 2;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('11200001',5) then                //�ɹ������������Ȩ��   actfrmStockOrderList    ��   STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                      Sql := Sql + ' select ''actfrmStockOrderList'' as ID,4 as MSG_CLASS,''�������'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,2 as sFlag '+
                      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') '; //and LOCUS_STATUS=''3'' and LOCUS_CHK_USER is not null
                    end;
                end;}
            end;

            if (Temp.FieldByName('IN_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14600001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmInLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '��������ջ���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('IN_CHK').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('IN_CHK_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 17;
              rs.Post;
              {if IsPlanDate then
                begin
                  if ShopGlobal.GetChkRight('14600001',2) then                //����ջ���������Ȩ��   actfrmInLocusOrderList   ��    STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���������  STK_STOCKORDER
                      Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''��������ջ���'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,17 as sFlag '+
                      'from STK_STOCKORDER where STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
                    end;
                end;}
            end;

            if (Temp.FieldByName('IN_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14600001',4) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmInLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '��������ջ���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('IN_NEW').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('IN_NEW_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 27;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14600001',4) then                //����ջ��������Ȩ��   actfrmInLocusOrderList   ��   STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���������  STK_STOCKORDER
                      Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''��������ջ���'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,27 as sFlag '+
                      'from STK_STOCKORDER where STOCK_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and LOCUS_STATUS=''3''
                    end;
                end;}
            end;
          end else if Temp.FieldByName('STOCK_TYPE').AsInteger = 2 then
          begin
          end else if Temp.FieldByName('STOCK_TYPE').AsInteger = 3 then
          begin
            if (Temp.FieldByName('CHK_NO').AsInteger > 0) and ShopGlobal.GetChkRight('11300001',5) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmStkRetuOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�ɹ��˻���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_NO').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CHK_NO_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 3;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('11300001',5) then                //�ɹ��˻��������Ȩ��   actfrmStkRetuOrderList   ��   STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                      Sql := Sql + 'select ''actfrmStkRetuOrderList'' as ID,4 as MSG_CLASS,''�ɹ��˻���'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,3 as sFlag '+
                      'from STK_STOCKORDER where CHK_USER is null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') '; // and LOCUS_STATUS=''3'' and LOCUS_CHK_USER is not null
                    end;
                end;}
            end;

            if (Temp.FieldByName('OUT_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�ɹ��˻�������';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_NEW').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_NEW_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 16;
              rs.Post;
              {if IsPlanDate then
                begin
                  if ShopGlobal.GetChkRight('14700001',2) then                //�ɹ��˻���������Ȩ��   actfrmOutLocusOrderList   ��   STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //�ɹ��˻�������  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''�ɹ��˻�������'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,16 as sFlag '+
                      'from STK_STOCKORDER where CHK_DATE is not null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
                    end;
                end;}
            end;
            if (Temp.FieldByName('OUT_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�ɹ��˻�������';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_CHK').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_CHK_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 26;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14700001',4) then                //�ɹ��˻��������Ȩ��   actfrmOutLocusOrderList   ��   STK_STOCKORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //�ɹ��˻�������  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''�ɹ��˻�������'' as MSG_TITLE,count(STOCK_TYPE) as SUM_ORDER,min(STOCK_DATE) as MIN_DATE,26 as sFlag '+
                      'from STK_STOCKORDER where CHK_DATE is not null and STOCK_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and (LOCUS_STATUS=''3'')
                    end;
                end;}
            end;
          end;
          Temp.Next;
        end;

      end;
      3:begin   //SAL_INDENTORDER  ���۶�����
        if (Temp.FieldByName('CHK_USER_NO').AsInteger > 0) and ShopGlobal.GetChkRight('12300001',7) and IsAudit then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmSalIndentOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '���۶���';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_USER_NO').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('INDE_DATE_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 4;
          rs.Post;
          {if IsAudit then
            begin
              if ShopGlobal.GetChkRight('12300001',7) then                //���۶��������Ȩ��     actfrmSalIndentOrderList   ��   SAL_INDENTORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                  Sql := Sql + ' select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''���۶���'' as MSG_TITLE,count(SHOP_ID) as SUM_ORDER,min(INDE_DATE) as MIN_DATE,4 as sFlag '+
                  'from SAL_INDENTORDER where CHK_USER is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
                end;
            end;}
        end;
        if (Temp.FieldByName('SALBILL_STATUS').AsInteger > 0) and ShopGlobal.GetChkRight('12400001',2) and IsPlanDate then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmSalIndentOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '���۶���';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SALBILL_STATUS').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SALBILL_STATUS_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 11;
          rs.Post;
          {if IsPlanDate then
            begin
              if ShopGlobal.GetChkRight('12400001',2) then            //���۶���δ�������۳�����   actfrmSalIndentOrderList    ��   SAL_INDENTORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                  Sql := Sql + 'select ''actfrmSalIndentOrderList'' as ID,4 as MSG_CLASS,''���۶���'' as MSG_TITLE,sum(case when SALBILL_STATUS=0 then 100000 else 1 end) as SUM_ORDER,min(INDE_DATE) as MIN_DATE,11 as sFlag '+
                  'from SAL_INDENTORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and SALBILL_STATUS in (0,1) ';
                end;
            end;}
        end;

      end;
      4:begin   // SAL_SALESORDER   ���۳�����
        Temp.First;
        while not Temp.Eof do
        begin
          if Temp.FieldByName('SALES_TYPE').AsInteger = 1 then
          begin
            if (Temp.FieldByName('CHK_USER_NO').AsInteger > 0) and ShopGlobal.GetChkRight('12400001',7) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmSalesOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '���۳���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_USER_NO').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CHK_USER_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 5;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('12400001',7) then                //���۵������Ȩ��       actfrmSalesOrderList    ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                      Sql := Sql + 'select ''actfrmSalesOrderList'' as ID,4 as MSG_CLASS,''���۳���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,5 as sFlag '+
                      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') '; //and LOCUS_STATUS=''3'' and LOCUS_CHK_USER is not null
                    end;
                end;}
            end;
            if (Temp.FieldByName('OUT_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '���۳��ⷢ����';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_NEW').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_NEW_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 13;
              rs.Post;
              {if IsPlanDate then
                begin
                  if ShopGlobal.GetChkRight('14700001',2) then                //���ⷢ����������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���۵�����  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''���۳��ⷢ����'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,13 as sFlag '+
                      'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
                    end;
                end;}
            end;
            if (Temp.FieldByName('OUT_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',4) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '���۳��ⷢ����';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_CHK').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_CHK_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 23;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14700001',4) then                //���ⷢ���������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���۵�����  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''���۳��ⷢ����'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,23 as sFlag '+
                      'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=1 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and (LOCUS_STATUS=''3'')
                    end;
                end;}
            end;
          end else if Temp.FieldByName('SALES_TYPE').AsInteger = 2 then
          begin
            if (Temp.FieldByName('CHK_USER_NO').AsInteger > 0) and ShopGlobal.GetChkRight('14100001',6) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmDbOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '������';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_USER_NO').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CHK_USER_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 7;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14100001',6) then                //������ε������Ȩ��   actfrmDbOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                      Sql := Sql + 'select ''actfrmDbOrderList'' as ID,4 as MSG_CLASS,''������'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,7 as sFlag '+
                      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') '; //and LOCUS_STATUS=''3'' and LOCUS_CHK_USER is not null
                    end;
                end;}
            end;

            if (Temp.FieldByName('OUT_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '���γ��ⷢ����';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_NEW').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_NEW_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 14;
              rs.Post;
              {if IsPlanDate then
                begin
                  if ShopGlobal.GetChkRight('14700001',2) then                //���ⷢ����������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���ε�����  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''���γ��ⷢ����'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,14 as sFlag '+
                      'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
                    end;
                end;}
            end;

            if (Temp.FieldByName('OUT_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',4) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '���γ��ⷢ����';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_CHK').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_CHK_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 24;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14700001',4) then                //���ⷢ���������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���ε�����  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''���γ��ⷢ����'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,24 as sFlag '+
                      'from SAL_SALESORDER where CHK_DATE is not null and SALES_TYPE=2 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and (LOCUS_STATUS=''3'')
                    end;
                end;}
            end;
            
          end else if Temp.FieldByName('SALES_TYPE').AsInteger = 3 then
          begin
            if (Temp.FieldByName('CHK_USER_NO').AsInteger > 0) and ShopGlobal.GetChkRight('12500001',7) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmSalRetuOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�����˻���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('CHK_USER_NO').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CHK_USER_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 6;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('12500001',7) then                //�����˻��������Ȩ��   actfrmSalRetuOrderList    ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';
                      Sql := Sql + 'select ''actfrmSalRetuOrderList'' as ID,4 as MSG_CLASS,''�����˻���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,6 as sFlag '+
                      'from SAL_SALESORDER where CHK_USER is null and SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') '; //and LOCUS_STATUS=''3'' and LOCUS_CHK_USER is not null
                    end;
                end;}
            end;
            
            if (Temp.FieldByName('IN_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14600001',2) and IsPlanDate then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmInLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�����˻��ջ���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('IN_NEW').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('IN_NEW_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 18;
              rs.Post;
              {if IsPlanDate then
                begin
                  if ShopGlobal.GetChkRight('14600001',2) then                //�����˻�����������Ȩ��   actfrmInLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //�����˻������  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''�����˻��ջ���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,18 as sFlag '+
                      'from SAL_SALESORDER where SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
                    end;
                end;}
            end;

            if (Temp.FieldByName('IN_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14600001',4) and IsAudit then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmInLocusOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�����˻��ջ���';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('IN_CHK').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('IN_CHK_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 28;
              rs.Post;
              {if IsAudit then
                begin
                  if ShopGlobal.GetChkRight('14600001',4) then                //�����˻����������Ȩ��   actfrmInLocusOrderList   ��   SAL_SALESORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //�����˻������  SAL_SALESORDER
                      Sql := Sql + 'select ''actfrmInLocusOrderList'' as ID,4 as MSG_CLASS,''�����˻��ջ���'' as MSG_TITLE,count(SALES_TYPE) as SUM_ORDER,min(SALES_DATE) as MIN_DATE,28 as sFlag '+
                      'from SAL_SALESORDER where SALES_TYPE=3 and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and (LOCUS_STATUS=''3'')
                    end;
                end;}
            end;

          end;
          Temp.Next;
        end;

      end;
      5:begin    //STO_CHANGEORDER  ������
        if (Temp.FieldByName('OUT_NEW').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',2) and IsPlanDate then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '����������';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_NEW').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_NEW_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 15;
          rs.Post;
          {if IsPlanDate then
            begin
              if ShopGlobal.GetChkRight('14700001',2) then                //���������������Ȩ��   actfrmOutLocusOrderList   ��   STO_CHANGEORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //����������  STO_CHANGEORDER
                  Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''����������'' as MSG_TITLE,count(CHANGE_ID) as SUM_ORDER,min(CHANGE_DATE) as MIN_DATE,15 as sFlag '+
                  'from STO_CHANGEORDER where CHK_DATE is not null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) ';
                end;
            end;}
        end;
        if (Temp.FieldByName('OUT_CHK').AsInteger > 0) and ShopGlobal.GetChkRight('14700001',4) and IsAudit then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmOutLocusOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '����������';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('OUT_CHK').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('OUT_CHK_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 25;
          rs.Post;
          {if IsAudit then
            begin
              if ShopGlobal.GetChkRight('14700001',4) then                //��������������Ȩ��   actfrmOutLocusOrderList   ��   STO_CHANGEORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //����������  STO_CHANGEORDER
                  Sql := Sql + 'select ''actfrmOutLocusOrderList'' as ID,4 as MSG_CLASS,''����������'' as MSG_TITLE,count(CHANGE_ID) as SUM_ORDER,min(CHANGE_DATE) as MIN_DATE,25 as sFlag '+
                  'from STO_CHANGEORDER where CHK_DATE is not null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and LOCUS_CHK_USER is null '; //and LOCUS_STATUS=''3''
                end;
            end;}
        end;

      end;
      6:begin    //  ACC_RECVABLE_INFO  Ӧ�տ�
        Temp.First;
        while not Temp.Eof do
        begin
          if (Temp.FieldByName('SUM_ORDER').AsInteger > 0) and ShopGlobal.GetChkRight('21300001',2) and IsAccount then
          begin
            if rs.Locate('sFlag',19,[]) then
            begin
              rs.Edit;
              if Temp.FieldByName('RECV_TYPE').AsInteger = 1 then
                rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + Temp.FieldByName('SUM_ORDER').AsInteger * 1000000
              else if Temp.FieldByName('RECV_TYPE').AsInteger = 2 then
                rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + Temp.FieldByName('SUM_ORDER').AsInteger * 1000
              else if Temp.FieldByName('RECV_TYPE').AsInteger = 3 then
                rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + Temp.FieldByName('SUM_ORDER').AsInteger * 1;
                
              if rs.FieldByName('MIN_DATE').AsInteger > Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger then
                rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
              rs.Post;
            end
            else
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmRecvOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := 'Ԥ��/Ӧ�տ';
              if Temp.FieldByName('RECV_TYPE').AsInteger = 1 then
                rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger * 1000000
              else if Temp.FieldByName('RECV_TYPE').AsInteger = 2 then
                rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger * 1000
              else if Temp.FieldByName('RECV_TYPE').AsInteger = 3 then
                rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger * 1;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 19;
              rs.Post;
              {if IsAccount then
                begin
                  if ShopGlobal.GetChkRight('21300001',2) then                //Ӧ�տ�����Ȩ��   actfrmRecvOrderList   ��   ACC_RECVABLE_INFO
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //Ԥ�տRECV_TYPE = '3'\Ӧ�տRECV_TYPE = '1'\Ӧ�˿RECV_TYPE = '2'   ACC_RECVABLE_INFO
                      Sql := Sql + 'select ''actfrmRecvOrderList'' as ID,4 as MSG_CLASS,''Ԥ��/Ӧ�տ'' as MSG_TITLE,count(RECV_TYPE) as SUM_ORDER,min(ABLE_DATE) as MIN_DATE,19 as sFlag '+
                      'from ACC_RECVABLE_INFO where isnull(RECK_MNY,0)<>0  and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
                    end;
                end;}
            end;
          end;
          Temp.Next;
        end;

      end;
      7:begin    //  ACC_PAYABLE_INFO  Ӧ����
        Temp.First;
        while not Temp.Eof do
        begin
          if (Temp.FieldByName('SUM_ORDER').AsInteger > 0) and ShopGlobal.GetChkRight('21400001',2) and IsAccount then
          begin
            if rs.Locate('sFlag',20,[]) then
              begin
                rs.Edit;
                if Temp.FieldByName('ABLE_TYPE').AsInteger = 6 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + rs.FieldByName('SUM_ORDER').AsInteger * 1000000
                else if Temp.FieldByName('ABLE_TYPE').AsInteger = 4 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + rs.FieldByName('SUM_ORDER').AsInteger * 1000
                else if Temp.FieldByName('ABLE_TYPE').AsInteger = 5 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger + rs.FieldByName('SUM_ORDER').AsInteger * 1;
                if rs.FieldByName('MIN_DATE').AsInteger > Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger then
                   rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
                rs.Post;
              end
            else
              begin
                rs.Append;
                rs.FieldByName('ID').AsString := 'actfrmPayOrderList';
                rs.FieldByName('MSG_CLASS').AsInteger := 4;
                rs.FieldByName('MSG_TITLE').AsString := 'Ԥ��/Ӧ���';
                if Temp.FieldByName('ABLE_TYPE').AsInteger = 6 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger * 1000000
                else if Temp.FieldByName('ABLE_TYPE').AsInteger = 4 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger * 1000
                else if Temp.FieldByName('ABLE_TYPE').AsInteger = 5 then
                   rs.FieldByName('SUM_ORDER').AsInteger := rs.FieldByName('SUM_ORDER').AsInteger * 1;
                rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
                rs.FieldByName('sFlag').AsInteger := 20;
                rs.Post;
              end;
              {if IsAccount then
                begin
                  if ShopGlobal.GetChkRight('21400001',2) then                //Ӧ��������Ȩ��   actfrmPayOrderList   ��   ACC_PAYABLE_INFO
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //Ԥ���ABLE_TYPE = '6'\Ӧ���ABLE_TYPE = '4'\Ӧ�˿ABLE_TYPE = '5'   ACC_PAYABLE_INFO
                      Sql := Sql + 'select ''actfrmPayOrderList'' as ID,4 as MSG_CLASS,''Ԥ��/Ӧ���'' as MSG_TITLE,count(ABLE_TYPE) as SUM_ORDER,min(ABLE_DATE) as MIN_DATE,20 as sFlag '+
                      'from ACC_PAYABLE_INFO where isnull(RECK_MNY,0)<>0  and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
                    end;
                end;}
          end;
          Temp.Next;
        end;

      end;
      8:begin
        Temp.First;
        while not Temp.Eof do
        begin
          if Temp.FieldByName('RECV_FLAG').AsInteger = 0 then
          begin
            if (Temp.FieldByName('SUM_ORDER').AsInteger > 0) and ShopGlobal.GetChkRight('21300001',5) and IsAccount then
            begin
              rs.Append;
              rs.FieldByName('ID').AsString := 'actfrmRecvOrderList';
              rs.FieldByName('MSG_CLASS').AsInteger := 4;
              rs.FieldByName('MSG_TITLE').AsString := '�տ';
              rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger;
              rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
              rs.FieldByName('sFlag').AsInteger := 21;
              rs.Post;
              {if IsAccount then
                begin
                  if ShopGlobal.GetChkRight('21300001',5) then                //Ӧ�տ����Ȩ��   actfrmRecvOrderList   ��   ACC_RECVORDER
                    begin
                      if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //�տ   ACC_RECVORDER
                      Sql := Sql + 'select ''actfrmRecvOrderList'' as ID,4 as MSG_CLASS,''�տ'' as MSG_TITLE,count(RECV_FLAG) as SUM_ORDER,min(RECV_DATE) as MIN_DATE,21 as sFlag '+
                      'from ACC_RECVORDER where RECV_FLAG=''0'' and CHK_DATE is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
                    end;
                end;}
            end;
          end
          else if Temp.FieldByName('RECV_FLAG').AsInteger = 1 then
          begin
          end;
          Temp.Next;
        end;

      end;
      9:begin
        if (Temp.FieldByName('SUM_ORDER').AsInteger > 0) and ShopGlobal.GetChkRight('21300001',5) and IsAccount then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmPayOrderList';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '���';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('SUM_ORDER_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 22;
          rs.Post;
          {if IsAccount then
            begin
              if ShopGlobal.GetChkRight('21400001',5) then                //Ӧ�������Ȩ��   actfrmPayOrderList   ��   ACC_PAYORDER
                begin
                  if Trim(Sql) <> '' then Sql := Sql + ' union all ';     //���   ACC_PAYORDER
                  Sql := Sql + 'select ''actfrmPayOrderList'' as ID,4 as MSG_CLASS,''���'' as MSG_TITLE,count(PAY_ID) as SUM_ORDER,min(PAY_DATE) as MIN_DATE,22 as sFlag '+
                  'from ACC_PAYORDER where CHK_DATE is null and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') ';
                end;
            end;}
        end;

      end;
      10:begin
        // ����֯SQL��亯���У��жԱ�ģ���漰����Ȩ�����жϣ������ڴ˴���ʡ��
        if (Temp.FieldByName('SUM_Birthday').AsInteger > 0) then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmCustomer';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '��Ա����';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_Birthday').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('Birthday_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 9;
          rs.Post;
          {Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''��Ա����'' as MSG_TITLE,count(CUST_ID) as SUM_ORDER,'+IntToStr(Birthday_Num)+' as MIN_DATE,9 as sFlag '+
              ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and BIRTHDAY is not null and ' + Str_Bir;
          }
        end;
        if (Temp.FieldByName('SUM_CustContinu').AsInteger > 0) then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := 'actfrmCustomer';
          rs.FieldByName('MSG_CLASS').AsInteger := 4;
          rs.FieldByName('MSG_TITLE').AsString := '��Ա����';
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_CustContinu').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('CustContinu_MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 10;
          rs.Post;
          {              Sql := Sql + ' select ''actfrmCustomer'' as ID,4 as MSG_CLASS,''��Ա����'' as MSG_TITLE,count(CUST_ID) as SUM_ORDER,'+IntToStr(CustContinu_Num)+' as MIN_DATE,10 as sFlag '+
              ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'') and CON_DATE is not null and '+ Str_Bir;}
        end;

      end;
      11:begin
        if (Temp.FieldByName('SUM_ORDER').AsInteger > 0) then
        begin
          rs.Append;
          rs.FieldByName('ID').AsString := Temp.FieldByName('ID').AsString;
          rs.FieldByName('MSG_CLASS').AsInteger := Temp.FieldByName('MSG_CLASS').AsInteger;
          rs.FieldByName('MSG_TITLE').AsString := Temp.FieldByName('MSG_TITLE').AsString;
          rs.FieldByName('SUM_ORDER').AsInteger := Temp.FieldByName('SUM_ORDER').AsInteger;
          rs.FieldByName('MIN_DATE').AsInteger := Temp.FieldByName('MIN_DATE').AsInteger;
          rs.FieldByName('sFlag').AsInteger := 8;
          rs.Post;
          {Sql := Sql + ' select a.QUESTION_ID as ID,1 as MSG_CLASS,b.QUESTION_TITLE as MSG_TITLE,count(a.QUESTION_ID) as SUM_ORDER,0 as MIN_DATE,8 as sFlag '+
        ' from MSC_INVEST_LIST a,MSC_QUESTION b where a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
        ' and a.TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and a.QUESTION_ANSWER_STATUS=2 group by a.QUESTION_ID,b.QUESTION_TITLE';}
        end;

      end;
    end;
  finally
    Temp.Free;
  end;
end;

destructor TPrainpowerJudge.Destroy;
begin
  List.Free;
  inherited;
end;

function TPrainpowerJudge.EncodeRemindSql(SEQ: Integer): String;
var Sql,Str_Bir:String;
begin
  case SEQ of
    1:begin   //  STK_INDENTORDER   ����������
      Sql := 'select  sum(case when STKBILL_STATUS=0 then 100000 when STKBILL_STATUS=1 then 1 else 0 end) as STATUS,'+
             'sum(case when CHK_DATE is null then 1 else 0 end) as CHK_NO,'+
        		 'min(case when CHK_DATE is null then INDE_DATE else 99999999 end) as MIN_DATE_1,'+
        		 'min(case when STKBILL_STATUS in (0,1) then INDE_DATE else 99999999 end) as MIN_DATE_2 '+
             ' from STK_INDENTORDER  where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+ShopGlobal.GetDataRight('DEPT_ID',2)+
             ' and COMM not in (''02'',''12'') and INDE_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2));
      Inc(FNumeration);
    end;
    2:begin   //  STK_STOCKORDER   ����(��)��ⵥ��
      Sql := 'select STOCK_TYPE,'+    
	           'sum(case when CHK_DATE is null then 1 else 0 end) as CHK_NO,'+    //�ɹ�����(�˻�)�����Ȩ��
             'min(case when CHK_DATE is null then STOCK_DATE else 99999999 end) as CHK_NO_MIN_DATE,'+  //�ɹ�����(�˻�)�����Ȩ�޵���������

             'sum(case when LOCUS_CHK_USER is null then 1 else 0 end) as IN_NEW,'+  //��������ջ��������Ȩ��
             'min(case when LOCUS_CHK_USER is null then STOCK_DATE else 99999999 end) as IN_NEW_MIN_DATE,'+  //��������ջ��������Ȩ�޵���������

	           'sum(case when (LOCUS_STATUS <> ''3'' or LOCUS_STATUS is null) then 1 else 0 end) as IN_CHK,'+	  //��������ջ�������Ȩ��
             'min(case when (LOCUS_STATUS <> ''3'' or LOCUS_STATUS is null) then STOCK_DATE else 99999999 end) as IN_CHK_MIN_DATE,'+	//��������ջ�������Ȩ�޵���������

	           'sum(case when (CHK_DATE is not null) and (LOCUS_STATUS <> ''3'' or LOCUS_STATUS is null) then 1 else 0 end) as OUT_NEW,'+ 	//�˻������ջ�������Ȩ��
             'min(case when (CHK_DATE is not null) and (LOCUS_STATUS <> ''3'' or LOCUS_STATUS is null) then STOCK_DATE else 99999999 end) as OUT_NEW_MIN_DATE,'+ 	//�˻������ջ�������Ȩ�޵���������

	           'sum(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then 1 else 0 end) as OUT_CHK,'+ 	//�˻������ջ������Ȩ��
             'min(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then STOCK_DATE else 99999999 end) as OUT_CHK_MIN_DATE '+	//�˻������ջ������Ȩ�޵���������

             ' from STK_STOCKORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+ShopGlobal.GetDataRight('DEPT_ID',2)+
             ' and COMM not in (''02'',''12'') and STOCK_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2))+' group by STOCK_TYPE ';
      Inc(FNumeration);
    end;
    3:begin   //SAL_INDENTORDER  ���۶�����
      Sql := 'select sum(case when CHK_DATE is null then 1 else 0 end) as CHK_USER_NO,'+    //���۶��������Ȩ��
             'min(case when CHK_DATE is null then INDE_DATE else 99999999 end) as INDE_DATE_MIN_DATE,'+    //���۶��������Ȩ�޵���������

	           'sum(case when SALBILL_STATUS=0 then 100000 when SALBILL_STATUS=1 then 1 else 0 end) as SALBILL_STATUS,'+    //���۶���δ�������۳�����
	           'min(case when SALBILL_STATUS in (0,1) then INDE_DATE else 99999999 end ) as SALBILL_STATUS_MIN_DATE '+    //���۶���δ�������۳���������������
             'from SAL_INDENTORDER  where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+ShopGlobal.GetDataRight('DEPT_ID',2)+
             ' and COMM not in (''02'',''12'') and INDE_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2));
      Inc(FNumeration);
    end;
    4:begin   // SAL_SALESORDER   ���۳�����
      Sql := 'select SALES_TYPE,'+
	           'sum(case when CHK_USER is null then 1 else 0 end) as CHK_USER_NO,'+    //����(�����˻�\�������)�������Ȩ��
	           'min(case when CHK_USER is null then SALES_DATE else 99999999 end) as CHK_USER_MIN_DATE,'+   //����(�����˻�\�������)�������Ȩ�޵���������

    	       'sum(case when (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then 1 else 0 end) as IN_NEW,'+   //�����˻�����������Ȩ��
	           'min(case when (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then SALES_DATE else 99999999 end) as IN_NEW_MIN_DATE,'+   //�����˻�����������Ȩ�޵���������

	           'sum(case when LOCUS_CHK_USER is null then 1 else 0 end) as IN_CHK,'+   //�����˻����������Ȩ��
	           'min(case when LOCUS_CHK_USER is null then SALES_DATE else 99999999 end) as IN_CHK_MIN_DATE,'+   //�����˻����������Ȩ�޵���������

	           'sum(case when (CHK_DATE is not null) and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then 1 else 0 end) as OUT_NEW,'+   //����(����)���ⷢ����������Ȩ��
	           'min(case when (CHK_DATE is not null) and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then SALES_DATE else 99999999 end) as OUT_NEW_MIN_DATE,'+   //����(����)���ⷢ����������Ȩ�޵���������

	           'sum(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then 1 else 0 end) as OUT_CHK,'+   //����(����)���ⷢ���������Ȩ��
	           'min(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then SALES_DATE else 99999999 end) as OUT_CHK_MIN_DATE '+  //����(����)���ⷢ���������Ȩ�޵���������

             'from SAL_SALESORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+ShopGlobal.GetDataRight('DEPT_ID',2)+
             ' and COMM not in (''02'',''12'') and SALES_DATE >'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2))+' group by SALES_TYPE ';
      Inc(FNumeration);
    end;
    5:begin    //STO_CHANGEORDER  ������
      Sql := 'select sum(case when (CHK_DATE is not null) and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then 1 else 0 end) as OUT_NEW,'+    //���������������Ȩ��
	           'min(case when (CHK_DATE is not null) and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null) then CHANGE_DATE else 99999999 end) as OUT_NEW_MIN_DATE,'+    //���������������Ȩ�޵���������

	           'sum(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then 1 else 0 end) as OUT_CHK,'+    //��������������Ȩ��
             'min(case when (CHK_DATE is not null) and (LOCUS_CHK_USER is null) then CHANGE_DATE else 99999999 end) as OUT_CHK_MIN_DATE '+   //��������������Ȩ�޵���������

             'from STO_CHANGEORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+ShopGlobal.GetDataRight('DEPT_ID',2)+
             ' and COMM not in (''02'',''12'') and CHANGE_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2));
      Inc(FNumeration);
    end;
    6:begin    //  ACC_RECVABLE_INFO  Ӧ�տ�
      Sql := 'select RECV_TYPE,'+          //Ԥ�տRECV_TYPE = '3'\Ӧ�˿RECV_TYPE = '2'\Ӧ�տRECV_TYPE = '1'   ACC_RECVABLE_INFO
    	       'sum(case when isnull(RECK_MNY,0)<>0 then 1 else 0 end) as SUM_ORDER,'+
     	       'min(case when isnull(RECK_MNY,0)<>0 then ABLE_DATE else 99999999 end) as SUM_ORDER_MIN_DATE '+
             'from ACC_RECVABLE_INFO where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+
             ' and COMM not in (''02'',''12'') and ABLE_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2))+' group by RECV_TYPE ';
      Inc(FNumeration);
    end;
    7:begin    //  ACC_PAYABLE_INFO  Ӧ����
      Sql := 'select ABLE_TYPE,'+         //Ԥ���ABLE_TYPE = '6'\Ӧ�˿RECV_TYPE = '5'\Ӧ���ABLE_TYPE = '4'   ACC_PAYABLE_INFO
        	   'sum(case when isnull(RECK_MNY,0)<>0 then 1 else 0 end) as SUM_ORDER,'+
      	     'min(case when isnull(RECK_MNY,0)<>0 then ABLE_DATE else 99999999 end) as SUM_ORDER_MIN_DATE '+

             ' from ACC_PAYABLE_INFO where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+
             ' and COMM not in (''02'',''12'') and ABLE_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2))+' group by ABLE_TYPE';
      Inc(FNumeration);
    end;
    8:begin    //Ӧ�տ����Ȩ��   actfrmRecvOrderList   ��   ACC_RECVORDER
      Sql := 'select RECV_FLAG,'+          //�տ   ACC_RECVORDER   �տ RECV_FLAG='0'/�ɿ RECV_FLAG='1'
	           'sum(case when CHK_DATE is null then 1 else 0 end) as SUM_ORDER,'+
    	       'min(case when CHK_DATE is null then RECV_DATE else 99999999 end) as SUM_ORDER_MIN_DATE '+

             ' from ACC_RECVORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+
             ' and COMM not in (''02'',''12'') and RECV_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2))+' group by RECV_FLAG ';
      Inc(FNumeration);
    end;
    9:begin    //Ӧ�������Ȩ��   actfrmPayOrderList   ��   ACC_PAYORDER
      Sql := 'select sum(case when CHK_DATE is null then 1 else 0 end) as SUM_ORDER,'+     //���   ACC_PAYORDER
	           'min(case when CHK_DATE is null then PAY_DATE else 99999999 end) as SUM_ORDER_MIN_DATE '+

             ' from ACC_PAYORDER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+ShopGlobal.GetDataRight('SHOP_ID',1)+
             ' and COMM not in (''02'',''12'') and PAY_DATE>'+FormatDateTime('YYYYMMDD',IncMonth(Date,-2));
      Inc(FNumeration);
    end;
    10:begin
      if ShopGlobal.GetChkRight('33400001',1) then
        begin
          if IsBirthday then
            begin
              case Factor.iDbType of
                0:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(isnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''+substring(isnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(BIRTHDAY,''          ''),5,10)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
                1,
                4:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(nvl(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(nvl(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
                5:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+Birthday_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(BIRTHDAY,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(BIRTHDAY,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              end;

              Sql := ' sum(case when ('+Str_Bir+') and (BIRTHDAY is not null) then 1 else 0 end) as SUM_Birthday,'+IntToStr(Birthday_Num)+' as Birthday_MIN_DATE ';    //��Ա����
            end;

          if IsCustContinu then
            begin
              case Factor.iDbType of
                0:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''+substring(isnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''+substring(isnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''+substring(isnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
                1,
                4:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(nvl(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(nvl(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(nvl(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
                5:Str_Bir := ' (('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',Date())+'''||substr(ifnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+''') or '+
                             ' ('''+FormatDateTime('YYYY-MM-DD',Date()+CustContinu_Num)+'''>='''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(CON_DATE,''          ''),5,6) and '''+FormatDateTime('YYYY',IncYear(Date()))+'''||substr(ifnull(CON_DATE,''          ''),5,6)>='''+FormatDateTime('YYYY-MM-DD',Date())+'''))';
              end;

              if Trim(Sql) <> '' then
                 Sql := Sql + ',sum(case when ('+Str_Bir+') and (CON_DATE is not null) then 1 else 0 end) as SUM_CustContinu,'+IntToStr(CustContinu_Num)+' as CustContinu_MIN_DATE '   //��Ա����
              else
                 Sql := ' sum(case when ('+Str_Bir+') and (CON_DATE is not null) then 1 else 0 end) as SUM_CustContinu,'+IntToStr(CustContinu_Num)+' as CustContinu_MIN_DATE ';   //��Ա����

            end;
        end;
        if Trim(Sql) <> '' then
          Sql := 'select '+ Sql + ' from PUB_CUSTOMER where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and COMM not in (''02'',''12'')';
      
      Inc(FNumeration);
    end;
    11:begin
      Sql := Sql + ' select a.QUESTION_ID as ID,1 as MSG_CLASS,b.QUESTION_TITLE as MSG_TITLE,count(a.QUESTION_ID) as SUM_ORDER,0 as MIN_DATE,8 as sFlag '+
      ' from MSC_INVEST_LIST a,MSC_QUESTION b where a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
      ' and a.TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and a.QUESTION_ANSWER_STATUS=2 group by a.QUESTION_ID,b.QUESTION_TITLE';

      FNumeration := 1;
    end;
  end;

  Result := ParseSQL(Factor.iDbType,Sql);
{
1  //�ɹ����������Ȩ��     actfrmStkIndentOrderList  ��  STK_INDENTORDER
2  //�ɹ������������Ȩ��   actfrmStockOrderList    ��   STK_STOCKORDER
3  //�ɹ��˻��������Ȩ��   actfrmStkRetuOrderList   ��   STK_STOCKORDER
4  //���۶��������Ȩ��     actfrmSalIndentOrderList   ��   SAL_INDENTORDER
5  //���۵������Ȩ��       actfrmSalesOrderList    ��   SAL_SALESORDER
6  //�����˻��������Ȩ��   actfrmSalRetuOrderList    ��   SAL_SALESORDER
7  //������ε������Ȩ��   actfrmDbOrderList   ��   SAL_SALESORDER
8  //�����ʾ�
9  //��Ա����
10 //��Ա����
11 //���۶���δ�������۳�����   actfrmSalIndentOrderList    ��   SAL_INDENTORDER
12 //�ɹ�����δ���ɽ�����ⵥ   actfrmStkIndentOrderList   ��   STK_INDENTORDER
13 //���۵�����  SAL_SALESORDER
14 //���ε�����  SAL_SALESORDER
15 //����������  STO_CHANGEORDER
16 //�ɹ��˻���������Ȩ��   actfrmOutLocusOrderList   ��   STK_STOCKORDER
17 //����ջ���������Ȩ��   actfrmInLocusOrderList   ��    STK_STOCKORDER
18 //�����˻�����������Ȩ��   actfrmInLocusOrderList   ��   SAL_SALESORDER
19 //Ӧ�տ�����Ȩ��   actfrmRecvOrderList   ��   ACC_RECVABLE_INFO
29   Ӧ�˿�
30   Ԥ�տ�
20 //Ӧ��������Ȩ��   actfrmPayOrderList   ��   ACC_PAYABLE_INFO
31   Ӧ�˿�
32   Ԥ����
21 //Ӧ�տ����Ȩ��   actfrmRecvOrderList   ��   ACC_RECVORDER
22 //Ӧ�������Ȩ��   actfrmPayOrderList   ��   ACC_PAYORDER
23 //���۵���������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
24 //���ε���������Ȩ��   actfrmOutLocusOrderList   ��   SAL_SALESORDER
25 //��������������Ȩ��   actfrmOutLocusOrderList   ��   STO_CHANGEORDER
26 //�ɹ��˻��������Ȩ��   actfrmOutLocusOrderList   ��   STK_STOCKORDER
27 //����ջ��������Ȩ��   actfrmInLocusOrderList   ��   STK_STOCKORDER
28 //�����˻����������Ȩ��   actfrmInLocusOrderList   ��   SAL_SALESORDER
}
end;

procedure TPrainpowerJudge.GetIsHint;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''12'',''02'') ';
    Factor.Open(rs);
    rs.Filtered := False;
    rs.Filter := ' DEFINE=''AUDIT_HINT'' ';     //��״̬����
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      IsAudit := True
    else
      IsAudit := False;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''BIRTHDAY'' ';       //��Ա��������
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
      IsBirthday := True
    else
      IsBirthday := False;
    Birthday_Num := rs.FieldByName('VALUE').AsInteger;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''CUSTCONTINU'' ';    //��Ա��������
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger >= 0) then
      IsCustContinu := True
    else
      IsCustContinu := False;
    CustContinu_Num := rs.FieldByName('VALUE').AsInteger;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''PLANDATE_HINT'' ';   //����״̬����
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      IsPlanDate := True
    else
      IsPlanDate := False;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''ACCOUNT_HINT'' ';   //�ո��˿�����
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      IsAccount := True
    else
      IsAccount := False;

    rs.Filtered := False;
    rs.Filter := ' DEFINE=''STORAGE'' ';       //�ֿ�Ԥ������
    rs.Filtered := True;
    if (not rs.IsEmpty) and (rs.FieldByName('VALUE').AsInteger = 1) then
      IsStorage := True
    else
      IsStorage := False;
  finally
    rs.Free;
  end;
end;

procedure TPrainpowerJudge.Load(flag:Integer=0);
var Msg:PMsgInfo;
    rs:TZQuery;
    Sql_Str:String;
begin
  if not Factor.Connected then Exit;
  MsgFactory.ClearType(4);
  if flag<>0 then Exit;

  rs := TZQuery.Create(nil);
  with rs.FieldDefs do
    begin
      Add('ID',ftString,50,False);
      Add('MSG_CLASS',ftInteger,0,False);
      Add('MSG_TITLE',ftString,50,False);
      Add('SUM_ORDER',ftInteger,0,False);
      Add('MIN_DATE',ftInteger,0,False);
      Add('sFlag',ftInteger,0,False);
    end;
  rs.CreateDataSet;
  try
    DataAnalysis(Numeration,rs);
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
          if rs.FieldbyName('sFlag').AsInteger = 8 then
            Msg^.Contents := '"'+rs.FieldbyName('MSG_TITLE').AsString+'" �����𸴣�'
          else if rs.FieldbyName('sFlag').AsInteger = 9 then
            Msg^.Contents := '���� '+rs.FieldbyName('SUM_ORDER').AsString+' λ�ͻ����ڹ����գ�'
          else if rs.FieldbyName('sFlag').AsInteger = 10 then
            Msg^.Contents := '���� '+rs.FieldbyName('SUM_ORDER').AsString+' λ�ͻ�����Ҫ�̻ᣡ'
          else if rs.FieldbyName('sFlag').AsInteger = 11 then
            Msg^.Contents := '���� ('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger div 100000)+')����������('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger mod 100000)+')��������'
          else if rs.FieldbyName('sFlag').AsInteger = 12 then
            Msg^.Contents := '���� ('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger div 100000)+')������⡢('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger mod 100000)+')�������'
          else if rs.FieldbyName('sFlag').AsInteger in [13,14,15,16] then
            Msg^.Contents := '���� ('+rs.FieldbyName('SUM_ORDER').AsString+')�� "'+rs.FieldbyName('MSG_TITLE').AsString+'" ��ɨ�뷢����'
          else if rs.FieldbyName('sFlag').AsInteger in [17,18] then
            Msg^.Contents := '���� ('+rs.FieldbyName('SUM_ORDER').AsString+')�� "'+rs.FieldbyName('MSG_TITLE').AsString+'" ��ɨ���ջ���'
          else if rs.FieldbyName('sFlag').AsInteger = 19 then
            Msg^.Contents := '���� ('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger mod 1000)+')�� Ԥ�ա�('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger div 1000000)+
                             ')�� Ӧ�ա�('+IntToStr((rs.FieldbyName('SUM_ORDER').AsInteger div 1000) mod 1000)+')�� Ӧ�˿��'
          else if rs.FieldbyName('sFlag').AsInteger = 20 then
            Msg^.Contents := '���� ('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger div 1000000)+')�� Ԥ����('+IntToStr((rs.FieldbyName('SUM_ORDER').AsInteger div 1000) mod 1000)+
                             ')�� Ӧ����('+IntToStr(rs.FieldbyName('SUM_ORDER').AsInteger mod 1000)+')�� Ӧ�˿��'
          else
            Msg^.Contents := ' ���� ('+rs.FieldbyName('SUM_ORDER').AsString+')�� "'+rs.FieldbyName('MSG_TITLE').AsString+'" û����ˣ�';


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
      FreeAndNil(rs);
    end;

end;

procedure TPrainpowerJudge.SetNumeration(const Value: Integer);
begin
  FNumeration := Value;
end;

procedure TPrainpowerJudge.SyncMsgc;
var
  Params:TftParamList;
begin
  InterlockedIncrement(Locked);
  try
  //��������ʱ����ͬ��
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
    //ͬ��������
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
