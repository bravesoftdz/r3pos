unit ufrmRecvDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

type
  TfrmRecvDayReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel9: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    RzBitBtn3: TRzBitBtn;
    RzPanel15: TRzPanel;
    DBGridEh4: TDBGridEh;
    dsadoReport4: TDataSource;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label10: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label11: TLabel;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label12: TLabel;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    Label9: TLabel;
    Label3: TLabel;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP3_SHOP_ID: TzrComboBoxList;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    //���������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //���ŵ����ۻ��ܱ�
    function GetCompanySQL(chk:boolean=true): string;
    //���������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //����Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;
{$R *.dfm}

procedure TfrmRecvDayReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false,'grp0 DESC,');
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  RefreshColumn;
end;

function TfrmRecvDayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
{
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserID+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //��������
  if fndP1_GROUP_ID.AsString <> '' then
  strWhere := strWhere + ' and isnull(C.GROUP_NAME,''#'') in (select CODE_ID from PUB_CODE_INFO where CODE_TYPE=8 and CODE_ID like '+QuotedStr(fndP1_GROUP_ID.AsString + '%')+')';
  //�ŵ�����
  case fndP1_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P1_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P1_D2.Date))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //��������
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D2.Date));
  //��Ʒ����
  if trim(fndP1_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid1 + '%')+')';
  //��Ʒָ��
  if (fndP1_TYPE_ID.ItemIndex = 0) and (fndP1_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP1_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP1_TYPE_ID.ItemIndex = 1) and (fndP1_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP1_STAT_ID.AsString);
  //��������
  case fndP1_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //��Ա����
  if fndP1_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP1_CUST_ID.AsString);
  //Ʊ������
  if fndP1_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP1_INVOICE_FLAG.Properties.Items.Objects[fndP1_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.GROUP_NAME as GROUP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP1_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--����
          ',sum(SAL_AMONEY) as AMONEY' + //--���۶�
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--����˰���,
          ',sum(SAL_TAX) as TAX_MONEY' + //--����˰��
          ',sum(SAL_COST) as COST_MONEY' + //--�ɱ�
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--ë��
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--���۳ɱ�
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--����ë��
          ',grouping(C.GROUP_NAME) as grp0 '+  //�б�ʶ
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by C.GROUP_NAME with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //����
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //��λë��
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //ë����
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //����ë����
          'case when J.grp0<>1 then IsNull(G.CODE_NAME,''δ����'') else ''��   ��'' end as GROUP_NAME from ('+strSQL+') j '+
          'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8) g on j.GROUP_ID=g.CODE_ID order by j.grp0 desc,j.GROUP_ID';
      end;
    3: begin //Access

      end;
  end;
  }
  Result := strSql;
end;

function TfrmRecvDayReport.GetRowType: integer;
begin
  result := DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmRecvDayReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //���������ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���ŵ���ܱ�
        if adoReport2.Active then adoReport2.Close;
        strSql := GetCompanySQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //��������ܱ�
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //����Ʒ���ܱ�
        if adoReport4.Active then adoReport4.Close;
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
  end;
end;

function TfrmRecvDayReport.GetCompanySQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
{
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserID+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //��������
  if fndP2_GROUP_ID.AsString <> '' then
  strWhere := strWhere + ' and isnull(C.GROUP_NAME,''#'') in (select CODE_ID from PUB_CODE_INFO where CODE_TYPE=8 and CODE_ID like '+QuotedStr(fndP2_GROUP_ID.AsString + '%')+')';
  //�ŵ�����
  case fndP2_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P2_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P2_D2.Date))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //��������
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P2_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P2_D2.Date));
  //��Ʒ����
  if trim(fndP2_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid2 + '%')+')';
  //��Ʒָ��
  if (fndP2_TYPE_ID.ItemIndex = 0) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP2_STAT_ID.AsString);
  //��������
  case fndP2_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //��Ʒָ��
  if (fndP2_TYPE_ID.ItemIndex = 1) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP2_STAT_ID.AsString);
  //��Ա����
  if fndP2_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP2_CUST_ID.AsString);
  //Ʊ������
  if fndP2_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP2_INVOICE_FLAG.Properties.Items.Objects[fndP2_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--����
          ',sum(SAL_AMONEY) as AMONEY' + //--���۶�
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--����˰���,
          ',sum(SAL_TAX) as TAX_MONEY' + //--����˰��
          ',sum(SAL_COST) as COST_MONEY' + //--�ɱ�
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--ë��
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--���۳ɱ�
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--����ë��
          ',grouping(C.COMP_ID) as grp0 '+  //�б�ʶ
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //����
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //��λë��
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //ë����
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //����ë����
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''δ����'') else ''��   ��'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  }
  Result := strSql;
end;

function TfrmRecvDayReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
{
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if fndP3_COMP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP3_COMP_ID.AsString,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //�ŵ�����
  case fndP3_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID='''+fndP3_COMP_ID.AsString+'''';
  1:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+fndP3_COMP_ID.AsString+''' and COMP_TYPE=2) or COMP_ID='''+fndP3_COMP_ID.AsString+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P3_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P3_D2.Date))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //��������
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P3_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P3_D2.Date));
  //��Ʒ���༶��
  strSQL := 'select SORT_ID,LEVEL_ID from PUB_GOODSSORT where COMM not in (''02'',''12'') and SORT_TYPE<='+inttostr(fndP3_SORT_ID.ItemIndex+1)+
            ' union all '+
            'select null as SORT_ID,'''' as LEVEL_ID ';
  //��Ʒָ��
  if (fndP3_TYPE_ID.ItemIndex = 0) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP3_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP3_TYPE_ID.ItemIndex = 1) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP3_STAT_ID.AsString);
  //��������
  case fndP3_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //��Ա����
  if fndP3_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP3_CUST_ID.AsString);
  //Ʊ������
  if fndP3_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP3_INVOICE_FLAG.Properties.Items.Objects[fndP3_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select s.SORT_ID,case when isnull(s.SORT_ID,'''')='''' then 1 else 0 end as grp0,sum(AMOUNT) as AMOUNT,sum(AMONEY) as AMONEY,sum(NOTAX_MONEY) as NOTAX_MONEY,sum(COST_MONEY) as COST_MONEY,sum(PROFIT_MONEY) as PROFIT_MONEY,'+
          'sum(NEW_COST_MONEY) as NEW_COST_MONEY,sum(NEW_PROFIT_MONEY) as NEW_PROFIT_MONEY from ('+strSQL+') s left outer join ('+
          'select D.LEVEL_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--����
          ',sum(SAL_AMONEY) as AMONEY' + //--���۶�
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--����˰���,
          ',sum(SAL_TAX) as TAX_MONEY' + //--����˰��
          ',sum(SAL_COST) as COST_MONEY' + //--�ɱ�
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY ' + //--ë��
          ',sum(SAL_AMOUNT*isnull(E.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--���۳ɱ�
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(E.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--����ë��
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,PUB_GOODSSORT D,VIW_PRICE_INFO E ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.SORT_ID=D.SORT_ID and A.GODS_ID=E.GODS_ID and A.COMP_ID=E.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +' group by D.LEVEL_ID) js on s.LEVEL_ID=substring(js.LEVEL_ID,1,len(s.LEVEL_ID)) '+
          ' group by s.SORT_ID';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //����
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //��λë��
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //ë����
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //����ë����
          'case when J.grp0<>1 then space((g.SORT_TYPE-1)*2)+IsNull(G.SORT_NAME,''δ����'') else ''��   ��'' end as SORT_NAME,g.LEVEL_ID from ('+strSQL+') j '+
          'left outer join PUB_GOODSSORT g on j.SORT_ID=g.SORT_ID order by j.grp0 desc,g.LEVEL_ID';
      end;
    3: begin //Access

      end;
  end;
  }
  Result := strSql;
end;

function TfrmRecvDayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
{
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if fndP4_COMP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP4_COMP_ID.AsString,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //�ŵ�����
  case fndP4_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID='''+fndP4_COMP_ID.AsString+'''';
  1:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+fndP4_COMP_ID.AsString+''' and COMP_TYPE=2) or COMP_ID='''+fndP4_COMP_ID.AsString+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P4_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P4_D2.Date))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //��������
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P4_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P4_D2.Date));
  //��Ʒ����
  if trim(fndP4_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid4 + '%')+')';
  //��Ʒָ��
  if (fndP4_TYPE_ID.ItemIndex = 0) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP4_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP4_TYPE_ID.ItemIndex = 1) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP4_STAT_ID.AsString);
  //��������
  case fndP4_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //��Ա����
  if fndP4_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP4_CUST_ID.AsString);
  //Ʊ������
  if fndP4_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP4_INVOICE_FLAG.Properties.Items.Objects[fndP4_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select A.GODS_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          ' when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--����
          ',sum(SAL_AMONEY) as AMONEY' + //--���۶�
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--����˰���,
          ',sum(SAL_TAX) as TAX_MONEY' + //--����˰��
          ',sum(SAL_COST) as COST_MONEY' + //--�ɱ�
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--ë��
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--���۳ɱ�
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--����ë��
          ',grouping(A.GODS_ID) as grp0 '+  //�б�ʶ
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by A.GODS_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //����
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //��λë��
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //ë����
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //����ë����
          'case when J.grp0<>1 then IsNull(G.GODS_NAME,''δ����'') else ''��   ��'' end as GODS_NAME,G.GODS_CODE,G.BARCODE from ('+strSQL+') j '+
          'left outer join (select GODS_ID,GODS_NAME,GODS_CODE,BARCODE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyId+''') g on j.GODS_ID=g.GODS_ID order by j.grp0 desc,g.BARCODE';
      end;
    3: begin //Access

      end;
  end;
  }
  Result := strSql;
end;

procedure TfrmRecvDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  DoAssignParamsValue(w1,RzPanel9);
end;

procedure TfrmRecvDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  DoAssignParamsValue(RzPanel9,RzPanel11);
end;

procedure TfrmRecvDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  DoAssignParamsValue(RzPanel11, RzPanel14);
end;

procedure TfrmRecvDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmRecvDayReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;
  {
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P1_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P1_D2.Date);
      if fndP1_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP1_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP1_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP1_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP1_SORT_ID.Text;
           inc(c);
         end;
      if fndP1_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP1_TYPE_ID.Text+'��'+fndP1_STAT_ID.Text;
           inc(c);
         end;
      if fndP1_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP1_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP1_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP1_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  1:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P2_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P2_D2.Date);
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP2_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP2_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP2_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP2_SORT_ID.Text;
           inc(c);
         end;
      if fndP2_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP2_TYPE_ID.Text+'��'+fndP2_STAT_ID.Text;
           inc(c);
         end;
      if fndP2_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP2_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP2_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP2_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  2:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P3_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P3_D2.Date);
      if fndP3_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP3_COMP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP3_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP3_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP3_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ����'+fndP3_SORT_ID.Text;
           inc(c);
         end;
      if fndP3_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP3_TYPE_ID.Text+'��'+fndP3_STAT_ID.Text;
           inc(c);
         end;
      if fndP3_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP3_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP3_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP3_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  3:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P4_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P4_D2.Date);
      if fndP4_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP4_COMP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP4_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP4_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP4_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP4_SORT_ID.Text;
           inc(c);
         end;
      if fndP4_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP4_TYPE_ID.Text+'��'+fndP4_STAT_ID.Text;
           inc(c);
         end;
      if fndP4_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP4_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP4_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP4_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  4:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P5_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P5_D2.Date);
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ͣ�'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP5_CUST_ID.Text;
           inc(c);
         end;
      if fndP5_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP5_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP5_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP5_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
      if fndP5_GODS_ID.asString<>'' then
         PrintDBGridEh1.Title.Text := '��Ʒ���ƣ�'+ fndP5_GODS_ID.Text;
    end;
  end;
  }
end;

end.

