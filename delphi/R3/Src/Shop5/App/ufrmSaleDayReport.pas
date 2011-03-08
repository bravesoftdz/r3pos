unit ufrmSaleDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, objbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

type
  TfrmSaleTotalReport = class(TframeBaseReport)
    drpStatInfo: TADODataSet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
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
    adoReport2: TADODataSet;
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
    adoReport3: TADODataSet;
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
    adoReport4: TADODataSet;
    RzPanel16: TRzPanel;
    Panel7: TPanel;
    RzPanel17: TRzPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    P5_D1: TcxDateEdit;
    RzBitBtn4: TRzBitBtn;
    RzPanel18: TRzPanel;
    dsadoReport4: TDataSource;
    P5_D2: TcxDateEdit;
    adoReport5: TADODataSet;
    dsadoReport5: TDataSource;
    Label41: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    cxComboBox1: TcxComboBox;
    zrComboBoxList3: TzrComboBoxList;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    cxRadioButton3: TcxRadioButton;
    cxRadioButton4: TcxRadioButton;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    fndP2_REGION_ID: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label3: TLabel;
    cxRadioButton5: TcxRadioButton;
    cxRadioButton6: TcxRadioButton;
    cxRadioButton7: TcxRadioButton;
    cxRadioButton8: TcxRadioButton;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    fndP3_COMP_ID: TzrComboBoxList;
    fndP3_TYPE_ID: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    zrComboBoxList4: TzrComboBoxList;
    cxComboBox2: TcxComboBox;
    Label4: TLabel;
    cxRadioButton9: TcxRadioButton;
    cxRadioButton10: TcxRadioButton;
    cxRadioButton11: TcxRadioButton;
    cxRadioButton12: TcxRadioButton;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    fndP4_COMP_ID: TzrComboBoxList;
    zrComboBoxList1: TzrComboBoxList;
    cxComboBox3: TcxComboBox;
    Label16: TLabel;
    cxRadioButton13: TcxRadioButton;
    cxRadioButton14: TcxRadioButton;
    cxRadioButton15: TcxRadioButton;
    cxRadioButton16: TcxRadioButton;
    DBGridEh5: TDBGridEh;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label28: TLabel;
    cxComboBox4: TcxComboBox;
    cxComboBox5: TcxComboBox;
    zrComboBoxList2: TzrComboBoxList;
    cxButtonEdit1: TcxButtonEdit;
    zrComboBoxList5: TzrComboBoxList;
    zrComboBoxList6: TzrComboBoxList;
    cxComboBox6: TcxComboBox;
    Label29: TLabel;
    cxRadioButton17: TcxRadioButton;
    cxRadioButton18: TcxRadioButton;
    cxRadioButton19: TcxRadioButton;
    cxRadioButton20: TcxRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP1_STAT_IDBeforeDropList(Sender: TObject);
    procedure fndP2_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP2_STAT_IDBeforeDropList(Sender: TObject);
    procedure P3_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP3_STAT_IDBeforeDropList(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure actPriorExecute(Sender: TObject);
    procedure fndP4_STAT_IDBeforeDropList(Sender: TObject);
    procedure fndP4_TYPE_IDPropertiesChange(Sender: TObject);
  private
    sid1,sid2,sid4:string;
    //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店销售汇总表
    function GetCompanySQL(chk:boolean=true): string;
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
    //按商品销售流水表
    function GetGlideSQL(chk:boolean=true): string;
  public
    { Public declarations }
    HasChild:boolean;
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ufrmShowReckInfo, uframeTreeFindDialog;
{$R *.dfm}

procedure TfrmSaleTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false,'grp0 DESC,');
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_GROUP_ID.DataSet := Global.GetADODataSetFromName('PUB_REGION_INFO');
  fndP1_CUST_ID.DataSet := Global.GetADODataSetFromName('BAS_CUSTOMER');
  fndP1_COMP_TYPE.ItemIndex := 0;
  fndP1_UNIT_ID.ItemIndex := ShopGlobal.DefUnit;
  fndP1_TYPE_ID.ItemIndex := 0;
  AddCbxPickList(fndP1_INVOICE_FLAG,'INVOICE_FLAG');
  fndP1_INVOICE_FLAG.Properties.Items.Insert(0,'全部');
  fndP1_INVOICE_FLAG.ItemIndex := 0;
  fndP1_SALES_TYPE.ItemIndex := 0;


  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP2_GROUP_ID.DataSet := Global.GetADODataSetFromName('PUB_REGION_INFO');
  fndP2_CUST_ID.DataSet := Global.GetADODataSetFromName('BAS_CUSTOMER');
  fndP2_COMP_TYPE.ItemIndex := 0;
  fndP2_UNIT_ID.ItemIndex := ShopGlobal.DefUnit;
  fndP2_TYPE_ID.ItemIndex := 0;
  AddCbxPickList(fndP2_INVOICE_FLAG,'INVOICE_FLAG');
  fndP2_INVOICE_FLAG.Properties.Items.Insert(0,'全部');
  fndP2_INVOICE_FLAG.ItemIndex := 0;
  fndP2_SALES_TYPE.ItemIndex := 0;

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP3_COMP_ID.KeyValue := Global.CompanyID;
  fndP3_COMP_ID.Text := Global.CompanyName;
  fndP3_COMP_ID.DataSet := Global.GetADODataSetFromName('CA_COMPANY');
  fndP3_CUST_ID.DataSet := Global.GetADODataSetFromName('BAS_CUSTOMER');
  fndP3_COMP_TYPE.ItemIndex := 0;
  fndP3_UNIT_ID.ItemIndex := ShopGlobal.DefUnit;
  fndP3_SORT_ID.ItemIndex := 2;
  fndP3_TYPE_ID.ItemIndex := 0;
  AddCbxPickList(fndP3_INVOICE_FLAG,'INVOICE_FLAG');
  fndP3_INVOICE_FLAG.Properties.Items.Insert(0,'全部');
  fndP3_INVOICE_FLAG.ItemIndex := 0;
  fndP3_SALES_TYPE.ItemIndex := 0;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP4_COMP_ID.KeyValue := Global.CompanyID;
  fndP4_COMP_ID.Text := Global.CompanyName;
  fndP4_COMP_ID.DataSet := Global.GetADODataSetFromName('CA_COMPANY');
  fndP4_CUST_ID.DataSet := Global.GetADODataSetFromName('BAS_CUSTOMER');
  fndP4_COMP_TYPE.ItemIndex := 0;
  fndP4_UNIT_ID.ItemIndex := ShopGlobal.DefUnit;
  fndP4_TYPE_ID.ItemIndex := 0;
  AddCbxPickList(fndP4_INVOICE_FLAG,'INVOICE_FLAG');
  fndP4_INVOICE_FLAG.Properties.Items.Insert(0,'全部');
  fndP4_INVOICE_FLAG.ItemIndex := 0;
  fndP4_SALES_TYPE.ItemIndex := 0;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP5_GODS_ID.DataSet := Global.GetADODataSetFromName('BAS_GOODSINFO');
  fndP5_CUST_ID.DataSet := Global.GetADODataSetFromName('BAS_CUSTOMER');
  fndP5_COMP_TYPE.ItemIndex := 0;
  fndP5_UNIT_ID.ItemIndex := ShopGlobal.DefUnit;
  AddCbxPickList(fndP5_INVOICE_FLAG,'INVOICE_FLAG');
  fndP5_INVOICE_FLAG.Properties.Items.Insert(0,'全部');
  fndP5_INVOICE_FLAG.ItemIndex := 0;
  fndP5_SALES_TYPE.ItemIndex := 0;

  HasChild := (ShopGlobal.GetADODataSetFromName('CA_COMPANY').RecordCount>1);
  rzPage.Pages[0].TabVisible := HasChild;
  rzPage.Pages[1].TabVisible := HasChild;
  if not HasChild then
     rzPage.ActivePageIndex := 2
  else
     rzPage.ActivePageIndex := 0;
  RefreshColumn;

  
end;

function TfrmSaleTotalReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('门店资料没找到...');
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserID+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //地区名称
  if fndP1_GROUP_ID.AsString <> '' then
  strWhere := strWhere + ' and isnull(C.GROUP_NAME,''#'') in (select CODE_ID from PUB_CODE_INFO where CODE_TYPE=8 and CODE_ID like '+QuotedStr(fndP1_GROUP_ID.AsString + '%')+')';
  //门店类型
  case fndP1_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''未结帐'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P1_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P1_D2.Date))+' or PRINT_DATE=''未结帐''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //销售日期
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D2.Date));
  //商品分类
  if trim(fndP1_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid1 + '%')+')';
  //商品指标
  if (fndP1_TYPE_ID.ItemIndex = 0) and (fndP1_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP1_STAT_ID.AsString);
  //商品指标
  if (fndP1_TYPE_ID.ItemIndex = 1) and (fndP1_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP1_STAT_ID.AsString);
  //单据类型
  case fndP1_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //会员名称
  if fndP1_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP1_CUST_ID.AsString);
  //票据类型
  if fndP1_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP1_INVOICE_FLAG.Properties.Items.Objects[fndP1_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.GROUP_NAME as GROUP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP1_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.GROUP_NAME) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by C.GROUP_NAME with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.CODE_NAME,''未分组'') else ''合   计'' end as GROUP_NAME from ('+strSQL+') j '+
          'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8) g on j.GROUP_ID=g.CODE_ID order by j.grp0 desc,j.GROUP_ID';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmSaleTotalReport.GetRowType: integer;
begin
  result := DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmSaleTotalReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //按地区汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.CommandText := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按门店汇总表
        if adoReport2.Active then adoReport2.Close;
        strSql := GetCompanySQL;
        if strSql='' then Exit;
        adoReport2.CommandText := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按分类汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.CommandText := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.CommandText := strSql;
        Factor.Open(adoReport4);
      end;
    4: begin //按商品流水帐
        if adoReport5.Active then adoReport5.Close;
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.CommandText := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

procedure TfrmSaleTotalReport.fndP1_TYPE_IDPropertiesChange(
  Sender: TObject);
begin
  inherited;
  fndP1_STAT_ID.KeyValue := null;
  fndP1_STAT_ID.Text := '';
end;

procedure TfrmSaleTotalReport.fndP1_STAT_IDBeforeDropList(Sender: TObject);
begin
  inherited;
  drpStatInfo.Close;
  if fndP1_TYPE_ID.ItemIndex = 0 then
    drpStatInfo.CommandText := 'select CLIENT_ID as CODE_ID, CLIENT_NAME as CODE_NAME,CLIENT_SPELL as CODE_SPELL from BAS_CLIENTINFO where CLIENT_ID in (select distinct PROVIDE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''')'
  else
    drpStatInfo.CommandText := 'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=6 order by CODE_ID';
  Factor.Open(drpStatInfo);
end;

function TfrmSaleTotalReport.GetCompanySQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('门店资料没找到...');
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserID+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //地区名称
  if fndP2_GROUP_ID.AsString <> '' then
  strWhere := strWhere + ' and isnull(C.GROUP_NAME,''#'') in (select CODE_ID from PUB_CODE_INFO where CODE_TYPE=8 and CODE_ID like '+QuotedStr(fndP2_GROUP_ID.AsString + '%')+')';
  //门店类型
  case fndP2_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''未结帐'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P2_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P2_D2.Date))+' or PRINT_DATE=''未结帐''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //销售日期
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P2_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P2_D2.Date));
  //商品分类
  if trim(fndP2_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid2 + '%')+')';
  //商品指标
  if (fndP2_TYPE_ID.ItemIndex = 0) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP2_STAT_ID.AsString);
  //单据类型
  case fndP2_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //商品指标
  if (fndP2_TYPE_ID.ItemIndex = 1) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP2_STAT_ID.AsString);
  //会员名称
  if fndP2_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP2_CUST_ID.AsString);
  //票据类型
  if fndP2_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP2_INVOICE_FLAG.Properties.Items.Objects[fndP2_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.COMP_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''未分组'') else ''合   计'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

procedure TfrmSaleTotalReport.fndP2_TYPE_IDPropertiesChange(
  Sender: TObject);
begin
  inherited;
  fndP2_STAT_ID.KeyValue := null;
  fndP2_STAT_ID.Text := '';

end;

procedure TfrmSaleTotalReport.fndP2_STAT_IDBeforeDropList(Sender: TObject);
begin
  inherited;
  drpStatInfo.Close;
  if fndP2_TYPE_ID.ItemIndex = 0 then
    drpStatInfo.CommandText := 'select CLIENT_ID as CODE_ID, CLIENT_NAME as CODE_NAME,CLIENT_SPELL as CODE_SPELL from BAS_CLIENTINFO where CLIENT_ID in (select distinct PROVIDE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''')'
  else
    drpStatInfo.CommandText := 'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=6 order by CODE_ID';
  Factor.Open(drpStatInfo);

end;

procedure TfrmSaleTotalReport.P3_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  fndP3_STAT_ID.KeyValue := null;
  fndP3_STAT_ID.Text := '';

end;

procedure TfrmSaleTotalReport.fndP3_STAT_IDBeforeDropList(Sender: TObject);
begin
  inherited;
  drpStatInfo.Close;
  if fndP3_TYPE_ID.ItemIndex = 0 then
    drpStatInfo.CommandText := 'select CLIENT_ID as CODE_ID, CLIENT_NAME as CODE_NAME,CLIENT_SPELL as CODE_SPELL from BAS_CLIENTINFO where CLIENT_ID in (select distinct PROVIDE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''')'
  else
    drpStatInfo.CommandText := 'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=6 order by CODE_ID';
  Factor.Open(drpStatInfo);

end;

function TfrmSaleTotalReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if fndP3_COMP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('门店资料没找到...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP3_COMP_ID.AsString,[]) then Raise Exception.Create('门店资料没找到...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //门店类型
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
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''未结帐'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P3_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P3_D2.Date))+' or PRINT_DATE=''未结帐''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //销售日期
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P3_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P3_D2.Date));
  //商品分类级数
  strSQL := 'select SORT_ID,LEVEL_ID from PUB_GOODSSORT where COMM not in (''02'',''12'') and SORT_TYPE<='+inttostr(fndP3_SORT_ID.ItemIndex+1)+
            ' union all '+
            'select null as SORT_ID,'''' as LEVEL_ID ';
  //商品指标
  if (fndP3_TYPE_ID.ItemIndex = 0) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP3_STAT_ID.AsString);
  //商品指标
  if (fndP3_TYPE_ID.ItemIndex = 1) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP3_STAT_ID.AsString);
  //单据类型
  case fndP3_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //会员名称
  if fndP3_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP3_CUST_ID.AsString);
  //票据类型
  if fndP3_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP3_INVOICE_FLAG.Properties.Items.Objects[fndP3_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select s.SORT_ID,case when isnull(s.SORT_ID,'''')='''' then 1 else 0 end as grp0,sum(AMOUNT) as AMOUNT,sum(AMONEY) as AMONEY,sum(NOTAX_MONEY) as NOTAX_MONEY,sum(COST_MONEY) as COST_MONEY,sum(PROFIT_MONEY) as PROFIT_MONEY,'+
          'sum(NEW_COST_MONEY) as NEW_COST_MONEY,sum(NEW_PROFIT_MONEY) as NEW_PROFIT_MONEY from ('+strSQL+') s left outer join ('+
          'select D.LEVEL_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY ' + //--毛利
          ',sum(SAL_AMOUNT*isnull(E.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(E.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,PUB_GOODSSORT D,VIW_PRICE_INFO E ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.SORT_ID=D.SORT_ID and A.GODS_ID=E.GODS_ID and A.COMP_ID=E.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +' group by D.LEVEL_ID) js on s.LEVEL_ID=substring(js.LEVEL_ID,1,len(s.LEVEL_ID)) '+
          ' group by s.SORT_ID';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then space((g.SORT_TYPE-1)*2)+IsNull(G.SORT_NAME,''未分类'') else ''合   计'' end as SORT_NAME,g.LEVEL_ID from ('+strSQL+') j '+
          'left outer join PUB_GOODSSORT g on j.SORT_ID=g.SORT_ID order by j.grp0 desc,g.LEVEL_ID';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmSaleTotalReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if fndP4_COMP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('门店资料没找到...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP4_COMP_ID.AsString,[]) then Raise Exception.Create('门店资料没找到...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //门店类型
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
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''未结帐'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P4_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P4_D2.Date))+' or PRINT_DATE=''未结帐''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //销售日期
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P4_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P4_D2.Date));
  //商品分类
  if trim(fndP4_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid4 + '%')+')';
  //商品指标
  if (fndP4_TYPE_ID.ItemIndex = 0) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP4_STAT_ID.AsString);
  //商品指标
  if (fndP4_TYPE_ID.ItemIndex = 1) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP4_STAT_ID.AsString);
  //单据类型
  case fndP4_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //会员名称
  if fndP4_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP4_CUST_ID.AsString);
  //票据类型
  if fndP4_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP4_INVOICE_FLAG.Properties.Items.Objects[fndP4_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select A.GODS_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          ' when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(A.GODS_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by A.GODS_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.GODS_NAME,''未分组'') else ''合   计'' end as GODS_NAME,G.GODS_CODE,G.BARCODE from ('+strSQL+') j '+
          'left outer join (select GODS_ID,GODS_NAME,GODS_CODE,BARCODE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyId+''') g on j.GODS_ID=g.GODS_ID order by j.grp0 desc,g.BARCODE';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmSaleTotalReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if fndP5_GODS_ID.AsString = '' then Raise Exception.Create('请选择要查询的商品名称');
  rs := Global.GetADODataSetFromName('CA_COMPANY');
  if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('门店资料没找到...');
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserID+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //门店类型
  case fndP5_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''未结帐'') as PRINT_DATE from (select * from CA_COMPANY C  where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',P5_D2.Date))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER) b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where PRINT_DATE<'+QuotedStr(formatDatetime('YYYY-MM-DD',P5_D2.Date))+' or PRINT_DATE=''未结帐''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //销售日期
  strWhere := strWhere + ' and A.SALES_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P5_D1.Date))+ ' and A.SALES_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P5_D2.Date));
  //商品名称
  if fndP5_GODS_ID.AsString <> '' then
     strWhere := strWhere + ' and A.GODS_ID = '+QuotedStr(fndP5_GODS_ID.AsString);
  //单据类型
  case fndP5_SALES_TYPE.ItemIndex of
  1:strWhere := strWhere + ' and A.SALES_TYPE in (3,4)';
  2:strWhere := strWhere + ' and A.SALES_TYPE in (1)';
  end;
  //会员名称
  if fndP5_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CUST_ID = '+QuotedStr(fndP5_CUST_ID.AsString);
  //票据类型
  if fndP5_INVOICE_FLAG.ItemIndex>0 then
     strWhere := strWhere + ' and A.INVOICE_FLAG = '+QuotedStr(TRecord_(fndP5_INVOICE_FLAG.Properties.Items.Objects[fndP5_INVOICE_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString);

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          ' when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.COMP_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''未分组'') else ''合   计'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

procedure TfrmSaleTotalReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date := P1_D1.Date;
  P2_D2.Date := P1_D2.Date;
  fndP2_COMP_TYPE.ItemIndex := fndP1_COMP_TYPE.ItemIndex;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  sid2 := sid1;
  fndP2_TYPE_ID.ItemIndex := fndP1_TYPE_ID.ItemIndex;
  fndP2_STAT_ID.KeyValue := fndP1_STAT_ID.KeyValue;
  fndP2_STAT_ID.Text := fndP1_STAT_ID.Text;
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex;
  fndP2_INVOICE_FLAG.ItemIndex := fndP1_INVOICE_FLAG.ItemIndex;
  fndP2_CUST_ID.KeyValue := fndP1_CUST_ID.KeyValue;
  fndP2_CUST_ID.Text := fndP1_CUST_ID.Text;
  fndP2_GROUP_ID.KeyValue := adoReport1.FieldbyName('GROUP_ID').AsString;
  if adoReport1.FieldbyName('grp0').AsInteger = 1 then
  fndP2_GROUP_ID.Text := '' else
  fndP2_GROUP_ID.Text := adoReport1.FieldbyName('GROUP_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmSaleTotalReport.DBGridEh2DblClick(Sender: TObject);
//var rs:TADODataSet;
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
//  rs := Global.GetADODataSetFromName('CA_COMPANY');
//  if not rs.Locate('COMP_ID',adoReport2.FieldbyName('COMP_ID').AsString,[]) then Raise Exception.Create('你没有查看此门店数据的权限');
  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  fndP3_TYPE_ID.ItemIndex := 0;
  fndP3_STAT_ID.KeyValue := fndP2_STAT_ID.KeyValue;
  fndP3_STAT_ID.Text := fndP2_STAT_ID.Text;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;
  fndP3_CUST_ID.KeyValue := fndP2_CUST_ID.KeyValue;
  fndP3_CUST_ID.Text := fndP2_CUST_ID.Text;
  fndP3_INVOICE_FLAG.ItemIndex := fndP2_INVOICE_FLAG.ItemIndex;

  fndP3_COMP_TYPE.ItemIndex := fndP2_COMP_TYPE.ItemIndex;
  if adoReport2.FieldbyName('grp0').AsInteger = 1 then
     begin
       fndP3_COMP_ID.KeyValue := Global.CompanyID;
       fndP3_COMP_ID.Text := Global.CompanyName;
     end else
  begin
    fndP3_COMP_ID.Text := adoReport2.FieldbyName('COMP_NAME').AsString;
    fndP3_COMP_ID.KeyValue := adoReport2.FieldbyName('COMP_ID').AsString;
  end;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);

end;

procedure TfrmSaleTotalReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;
  fndP4_COMP_TYPE.ItemIndex := fndP3_COMP_TYPE.ItemIndex;
  fndP4_TYPE_ID.ItemIndex := fndP3_TYPE_ID.ItemIndex;
  fndP4_STAT_ID.KeyValue := fndP3_STAT_ID.KeyValue;
  fndP4_STAT_ID.Text := fndP4_STAT_ID.Text;
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_INVOICE_FLAG.ItemIndex := fndP3_INVOICE_FLAG.ItemIndex;
  fndP4_CUST_ID.KeyValue := fndP3_CUST_ID.KeyValue;
  fndP4_CUST_ID.Text := fndP3_CUST_ID.Text;
  fndP4_COMP_ID.KeyValue := fndP3_COMP_ID.KeyValue;
  fndP4_COMP_ID.Text := fndP3_COMP_ID.Text;
  sid4 := adoReport3.FieldbyName('LEVEL_ID').AsString;
  if adoReport3.FieldbyName('grp0').AsInteger = 1 then
  fndP4_SORT_ID.Text := '' else
  fndP4_SORT_ID.Text := adoReport3.FieldbyName('SORT_NAME').AsString;
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);

end;

procedure TfrmSaleTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmSaleTotalReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  P5_D1.Date := P4_D1.Date;
  P5_D2.Date := P4_D2.Date;
  if fndP4_COMP_TYPE.ItemIndex in [0,1] then
     fndP5_COMP_TYPE.ItemIndex := 0
  else
     fndP5_COMP_TYPE.ItemIndex := 1;
  fndP5_UNIT_ID.ItemIndex := fndP4_UNIT_ID.ItemIndex;
  fndP5_INVOICE_FLAG.ItemIndex := fndP4_INVOICE_FLAG.ItemIndex;
  fndP5_CUST_ID.KeyValue := fndP4_CUST_ID.KeyValue;
  fndP5_CUST_ID.Text := fndP4_CUST_ID.Text;
  fndP5_GODS_ID.KeyValue := adoReport4.FieldbyName('GODS_ID').AsString;
  fndP5_GODS_ID.Text := adoReport4.FieldbyName('GODS_NAME').AsString;
  rzPage.ActivePageIndex := 4;
  actFind.OnExecute(nil);

end;

procedure TfrmSaleTotalReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P1_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P1_D2.Date);
      if fndP1_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP1_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP1_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP1_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP1_SORT_ID.Text;
           inc(c);
         end;
      if fndP1_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP1_TYPE_ID.Text+'：'+fndP1_STAT_ID.Text;
           inc(c);
         end;
      if fndP1_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP1_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP1_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP1_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  1:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P2_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P2_D2.Date);
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP2_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP2_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP2_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP2_SORT_ID.Text;
           inc(c);
         end;
      if fndP2_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP2_TYPE_ID.Text+'：'+fndP2_STAT_ID.Text;
           inc(c);
         end;
      if fndP2_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP2_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP2_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP2_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  2:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P3_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P3_D2.Date);
      if fndP3_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP3_COMP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP3_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP3_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP3_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示级别：'+fndP3_SORT_ID.Text;
           inc(c);
         end;
      if fndP3_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP3_TYPE_ID.Text+'：'+fndP3_STAT_ID.Text;
           inc(c);
         end;
      if fndP3_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP3_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP3_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP3_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  3:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P4_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P4_D2.Date);
      if fndP4_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP4_COMP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP4_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP4_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP4_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP4_SORT_ID.Text;
           inc(c);
         end;
      if fndP4_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP4_TYPE_ID.Text+'：'+fndP4_STAT_ID.Text;
           inc(c);
         end;
      if fndP4_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP4_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP4_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP4_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  4:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P5_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P5_D2.Date);
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店类型：'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP5_CUST_ID.Text;
           inc(c);
         end;
      if fndP5_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP5_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP5_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP5_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
      if fndP5_GODS_ID.asString<>'' then
         PrintDBGridEh1.Title.Text := '商品名称：'+ fndP5_GODS_ID.Text;
    end;
  end;
end;

procedure TfrmSaleTotalReport.fndP1_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  rs:TRecord_;
begin
  inherited;
  rs := TRecord_.Create;
  try
  if TframeTreeFindDialog.FindDialog1(self,Global.GetADODataSetFromName('PUB_GOODSSORT'),
      'SORT_ID','LEVEL_ID','SORT_NAME','333333',rs)
  then
     begin
       sid1 := rs.FieldbyName('LEVEL_ID').AsString;
       fndP1_SORT_ID.Text := rs.FieldbyName('SORT_NAME').AsString;
     end;
  finally
     rs.Free;
  end;
end;

procedure TfrmSaleTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmSaleTotalReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmSaleTotalReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmSaleTotalReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  rs:TRecord_;
begin
  inherited;
  rs := TRecord_.Create;
  try
  if TframeTreeFindDialog.FindDialog1(self,Global.GetADODataSetFromName('PUB_GOODSSORT'),
      'SORT_ID','LEVEL_ID','SORT_NAME','333333',rs)
  then
     begin
       sid2 := rs.FieldbyName('LEVEL_ID').AsString;
       fndP2_SORT_ID.Text := rs.FieldbyName('SORT_NAME').AsString;
     end;
  finally
     rs.Free;
  end;
end;

procedure TfrmSaleTotalReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  rs:TRecord_;
begin
  inherited;
  rs := TRecord_.Create;
  try
  if TframeTreeFindDialog.FindDialog1(self,Global.GetADODataSetFromName('PUB_GOODSSORT'),
      'SORT_ID','LEVEL_ID','SORT_NAME','333333',rs)
  then
     begin
       sid4 := rs.FieldbyName('LEVEL_ID').AsString;
       fndP4_SORT_ID.Text := rs.FieldbyName('SORT_NAME').AsString;
     end;
  finally
     rs.Free;
  end;
end;

procedure TfrmSaleTotalReport.actPriorExecute(Sender: TObject);
begin
  if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;

end;

procedure TfrmSaleTotalReport.fndP4_STAT_IDBeforeDropList(Sender: TObject);
begin
  inherited;
  drpStatInfo.Close;
  if fndP4_TYPE_ID.ItemIndex = 0 then
    drpStatInfo.CommandText := 'select CLIENT_ID as CODE_ID, CLIENT_NAME as CODE_NAME,CLIENT_SPELL as CODE_SPELL from BAS_CLIENTINFO where CLIENT_ID in (select distinct PROVIDE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''')'
  else
    drpStatInfo.CommandText := 'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=6 order by CODE_ID';
  Factor.Open(drpStatInfo);


end;

procedure TfrmSaleTotalReport.fndP4_TYPE_IDPropertiesChange(
  Sender: TObject);
begin
  inherited;
  fndP4_STAT_ID.KeyValue := null;
  fndP4_STAT_ID.Text := '';

end;

end.

