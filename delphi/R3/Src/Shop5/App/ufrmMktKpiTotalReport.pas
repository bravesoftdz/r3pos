unit ufrmMktKpiTotalReport;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar, zrMonthEdit, ufrmDateControl;

type
  TfrmMktKpiTotalReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    actTemplate: TAction;
    btnDelete: TRzBitBtn;
    fndP1_YEAR1: TcxComboBox;
    fndP1_YEAR2: TcxComboBox;
    Label13: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Label14: TLabel;
    fndP1_CUST_VALUE: TzrComboBoxList;
    fndP1_KPI_ID: TzrComboBoxList;
    Label8: TLabel;
    Label10: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    Label28: TLabel;
    fndP1_KPI_TYPE: TcxComboBox;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure fndP1_KPI_TYPEPropertiesChange(Sender: TObject);
  private
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    function GetDataRight: string;
  public
    { Public declarations }
    Factory: TReportFactory;
    Lock:boolean;
    LCK_Index:integer;
    function  GetKpiSQL(chk:boolean=true): string; 
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
    property DataRight: string read GetDataRight;    
  end;


implementation

uses
  ufrmDefineReport,ufnUtil,uShopUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar;

{$R *.dfm}

procedure TfrmMktKpiTotalReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE5,'3','5') then
  begin
    load;
  end;
end;

procedure TfrmMktKpiTotalReport.load;
var
  rs:TZQuery;
  list:TStringList;
  w:string;
  i:integer;
begin
  rs := TZQuery.Create(nil);
  list := TStringList.Create;
  lock := true;
  try
    w := '';
    if not ((Global.UserID = 'admin') or (Global.UserID = 'system') or (Global.Roles = 'xsm')) then
    begin
      list.CommaText := Global.Roles;
      for i:=0 to list.Count - 1 do
      begin
        if w<>'' then w := w + ' or ';
        w:=w+''','''+GetStrJoin(Factor.iDbType)+' ROLES '+GetStrJoin(Factor.iDbType)+''','' like ''%,'+list[i]+',%'' ';
      end;
      if w <> '' then w := ' and ('+w+')';
    end;
    rs.Close;
    rs.SQL.Text := 'select REPORT_ID,REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''5'' '+w;
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmMktKpiTotalReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmMktKpiTotalReport.FormCreate(Sender: TObject);
begin
  fndP1_KPI_TYPE.ItemIndex:=0;
  DoCreateKPIDataSet;
  inherited;
  //初始化年度
  AddYearCBxItemsList(fndP1_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP1_YEAR2);
  fndP1_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');

  TDbGridEhSort.InitForm(self,false);

  Factory := nil;
  load;
  btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
end;

procedure TfrmMktKpiTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  if Factory<>nil then Factory.Free;
  inherited;
end;

procedure TfrmMktKpiTotalReport.actFindExecute(Sender: TObject);
var strSql:string;
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  adoReport1.Close;
  if Factory<>nil then Factory.Free;
  Factory := TReportFactory.Create('5');
  try
    if Factory.DataSet.Active then Factory.DataSet.Close;
    strSql := GetKpiSQL;
    if strSql='' then Exit;
    TZQuery(Factory.DataSet).SQL.Text:= strSql;
    frmPrgBar.Show;
    frmPrgBar.Update;
    frmPrgBar.WaitHint := '准备数据源...';
    frmPrgBar.Precent := 0;

    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;
end;

procedure TfrmMktKpiTotalReport.btnEditClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.EditReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE5) then
  begin
    load;
  end;
end;

function TfrmMktKpiTotalReport.GetKpiSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd: widestring;
begin
  result:='';
  if fndP1_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP1_YEAR1.ItemIndex<>-1)and(fndP1_YEAR2.ItemIndex<>-1)and(fndP1_YEAR1.Text>fndP1_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+DataRight;
  //考核年度条件
  if (fndP1_YEAR2.ItemIndex<>-1) and (fndP1_YEAR1.Text<fndP1_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP1_YEAR1.Text+' and A.KPI_YEAR<='+fndP1_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP1_YEAR1.Text+' ';
  //考核类型:客户考核和人员考核:
  if fndP1_KPI_TYPE.ItemIndex > -1 then
    strWhere:=strWhere+' and A.PLAN_TYPE='''+IntToStr(fndP1_KPI_TYPE.ItemIndex+1)+''' ';

  //部门条件:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP1_DEPT_ID.AsString);
  //考核指标:
  if fndP1_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP1_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP1_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP1_CUST_VALUE.AsString<>'') then
  begin
    case fndP1_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP1_CUST_VALUE.AsString),2)='00' then  //非末级区域
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP1_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP1_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP1_CUST_VALUE.AsString+''' ';   //等级
     2: strCnd:=' and D.SORT_ID='''+fndP1_CUST_VALUE.AsString+''' ';    //分类
     3: strCnd:=' and D.FLAG='+fndP1_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  strSql:=
    'select '+
    ' A.TENANT_ID as TENANT_ID,'+
    ' A.SHOP_ID as SHOP_ID,'+
    ' A.CLIENT_ID as CLIENT_ID,'+
    ' isnull(D.CLIENT_NAME,''不记名客户'')as CLIENT_ID_TEXT,'+  //客户名称
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.PLAN_USER as GUIDE_USER,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' D.CLIENT_CODE as CLIENT_CODE,'+
    ' D.REGION_ID as CREGION_ID,'+  //客户所属区域
    ' D.REGION_ID as CREGION_ID1,'+  //客户所属区域
    ' D.REGION_ID as CREGION_ID2,'+  //客户所属区域
    ' (case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' (case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' C.KPI_MNY as JT_MNY,'+     //考核结果(元)[计提金额]
    ' C.WDW_MNY as REQU_MNY,'+   //考核提取反利[申领金额]
    ' B.BOND_MNY as BOND_MNY '+  //保证金额
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';

  strSql:=
    'select '+
    ' K.*, '+
    ' MKT.KPI_NAME as KPI_ID_TEXT,'+    
    '(case when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''1'') then ''上半年'' '+
         ' when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''2'') then ''下半年'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''1'') then ''第一季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''2'') then ''第二季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''3'') then ''第三季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''4'') then ''第四季度'' '+
         ' else '' '' end)as KPI_LV,'+  //考核周期
    ' SHOP.SHOP_NAME as SHOP_ID_TEXT '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' left outer join (select KPI_ID,KPI_LV from MKT_KPI_OPTION where TENANT_ID='+InttoStr(Global.TENANT_ID)+') OP on K.KPI_ID=OP.KPI_ID '+
    ' left outer join CA_SHOP_INFO SHOP on K.TENANT_ID=SHOP.TENANT_ID and K.SHOP_ID=SHOP.SHOP_ID ';
  result:=ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmMktKpiTotalReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

procedure TfrmMktKpiTotalReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rptTemplate.Text;
  try
    Title:=TStringList.Create;
    AddReportReport(Title,'1');
    ReStr:=FormatReportHead(Title,1);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmMktKpiTotalReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TcxComboBox) and
     (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp2).Visible)  then
    TitleList.add('考核年度：'+TcxComboBox(FindCmp1).Text+' 至 '+TcxComboBox(FindCmp2).Text);

  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmMktKpiTotalReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
var
  Str,CurYear: string;
  Rs: TZQuery;
begin
  ClearCbxPickList(SetCbx);
  CurYear:=FormatDatetime('YYYY',Date());
  Rs:=TZQuery.Create(nil);
  try
    Rs.SQL.Text:='select distinct KPI_YEAR from MKT_PLANORDER order by KPI_YEAR Desc';
    Factor.Open(Rs);
    if Rs.Active then
    begin
      if not Rs.Locate('KPI_YEAR',CurYear,[]) then
        SetCbx.Properties.Items.Add(CurYear);
      Rs.First;
      while Not Rs.Eof do
      begin
        SetCbx.Properties.Items.Add(Rs.FieldByName('KPI_YEAR').AsString);
        Rs.Next;
      end;
    end;
    if SetCbx.Properties.Items.Count>0 then SetCbx.ItemIndex:=0;
  finally
    Rs.Free;
  end;
end;

procedure TfrmMktKpiTotalReport.fndP1_KPI_TYPEPropertiesChange(Sender: TObject);
begin
  case fndP1_KPI_TYPE.ItemIndex of
   0: fndP1_KPI_ID.RangeValue:='1';
   1: fndP1_KPI_ID.RangeValue:='3';
  end;
end;

function TfrmMktKpiTotalReport.GetDataRight: string;
begin
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.
