unit ufrmMktBudgReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup,
  ufrmDateControl, Buttons, DBGrids;

type
  TfrmMktBudgReport = class(TframeBaseReport)
    TabSheet4: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzLabel2: TRzLabel;
    btnDept: TRzBitBtn;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    dsadoReport4: TDataSource;
    dsadoReport5: TDataSource;
    Label7: TLabel;
    fndP1_KPI_ID: TzrComboBoxList;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    adoReport5: TZQuery;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    BtnClient: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel9: TRzPanel;
    BtnKpi: TRzBitBtn;
    RzPanel10: TRzPanel;
    DBGridEh4: TDBGridEh;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    BtnRegion: TRzBitBtn;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    BtnSaleDetail: TRzBitBtn;
    RzPanel21: TRzPanel;
    DBGridEh5: TDBGridEh;
    fndP1_YEAR1: TcxComboBox;
    RzLabel6: TRzLabel;
    fndP1_YEAR2: TcxComboBox;
    Label17: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label18: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    fndP1_CUST_VALUE: TzrComboBoxList;
    Label44: TLabel;
    fndP1_CLIENT_ID: TzrComboBoxList;
    RzLabel3: TRzLabel;
    Label3: TLabel;
    Label4: TLabel;
    fndP2_CUST_TYPE: TcxComboBox;
    fndP2_YEAR1: TcxComboBox;
    RzLabel7: TRzLabel;
    fndP2_KPI_ID: TzrComboBoxList;
    fndP2_CUST_VALUE: TzrComboBoxList;
    fndP2_YEAR2: TcxComboBox;
    Label5: TLabel;
    Label6: TLabel;
    fndP2_CLIENT_ID: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    RzLabel1: TRzLabel;
    Label8: TLabel;
    Label10: TLabel;
    fndP4_CUST_TYPE: TcxComboBox;
    fndP4_YEAR1: TcxComboBox;
    RzLabel8: TRzLabel;
    fndP4_KPI_ID: TzrComboBoxList;
    fndP4_CUST_VALUE: TzrComboBoxList;
    fndP4_YEAR2: TcxComboBox;
    Label13: TLabel;
    Label14: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    RzLabel4: TRzLabel;
    Label9: TLabel;
    Label11: TLabel;
    fndP3_CUST_TYPE: TcxComboBox;
    fndP3_YEAR1: TcxComboBox;
    RzLabel5: TRzLabel;
    fndP3_KPI_ID: TzrComboBoxList;
    fndP3_CUST_VALUE: TzrComboBoxList;
    fndP3_YEAR2: TcxComboBox;
    Label12: TLabel;
    Label15: TLabel;
    fndP3_CLIENT_ID: TzrComboBoxList;
    fndP3_DEPT_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    Label16: TLabel;
    Label19: TLabel;
    fndP5_CUST_TYPE: TcxComboBox;
    fndP5_YEAR1: TcxComboBox;
    RzLabel10: TRzLabel;
    fndP5_KPI_ID: TzrComboBoxList;
    fndP5_CUST_VALUE: TzrComboBoxList;
    fndP5_YEAR2: TcxComboBox;
    Label20: TLabel;
    Label21: TLabel;
    fndP5_CLIENT_ID: TzrComboBoxList;
    fndP5_DEPT_ID: TzrComboBoxList;
    Label22: TLabel;
    fndP5_GUIDE_USER: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    //查询SQL:
    KpiSumFields: string;
    //创建KpiSumGrid列
    procedure CreateKpiSumGrid;
  
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    //按部门考核汇总表
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //按管理考核汇总表
    function GetGroupSQL(chk:boolean=true): string;  //2222
    //按客户考核汇总表
    function GetClientSQL(chk:boolean=true): string; //3333
    //按考核指标汇总表
    function GetKPISQL(chk:boolean=true): string;    //4444
    //按客户考核明细流水表
    function GetGlideSQL(chk:boolean=true): string;   //5555
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    //设置Page分页显示:（IsGroupReport是否分组[区域、门店]）
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function GetDataRight: string;
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property DataRight: string read GetDataRight; //返回查看数据权限
  end;

 
implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmMktBudgReport.FormCreate(Sender: TObject);
begin
  //必须放在继承之前取数
  DoCreateKPIDataSet('1');
  inherited;
  //初始化年度下拉
  AddYearCBxItemsList(fndP1_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP1_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP2_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP2_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP3_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP3_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP4_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP4_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP5_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP5_YEAR2);

  fndP1_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP2_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP3_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP4_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP5_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');

  TDbGridEhSort.InitForm(self,false);
  SetRzPageActivePage; //设置PzPage.Activepage

  RefreshColumn;
 
  //2011.09.21 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.BUDG_KPI','DBGridEh1.BUDG_MNY','DBGridEh1.BUDG_WDW','DBGridEh1.BUDG_BAL','DBGridEh1.BUDG_VRF',
                              'DBGridEh2.BUDG_KPI','DBGridEh2.BUDG_MNY','DBGridEh2.BUDG_WDW','DBGridEh2.BUDG_BAL','DBGridEh1.BUDG_VRF',
                              'DBGridEh3.BUDG_KPI','DBGridEh3.BUDG_MNY','DBGridEh3.BUDG_WDW','DBGridEh3.BUDG_BAL','DBGridEh1.BUDG_VRF',
                              'DBGridEh4.BUDG_KPI','DBGridEh4.BUDG_MNY','DBGridEh4.BUDG_WDW','DBGridEh4.BUDG_BAL','DBGridEh1.BUDG_VRF',
                              'DBGridEh5.BUDG_VRF']);
  //创建计算对象：
  CalcFooter:=TCalcFooter.Create;
  //创建列
  CreateKpiSumGrid;                           
end;



function TfrmMktBudgReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,CustCnd,BudgTab: string;
begin
  if fndP1_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP1_YEAR1.ItemIndex<>-1)and(fndP1_YEAR2.ItemIndex<>-1)and(fndP1_YEAR1.Text>fndP1_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP1_YEAR2.ItemIndex<>-1) and (fndP1_YEAR1.Text<fndP1_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP1_YEAR1.Text+' and A.KPI_YEAR<='+fndP1_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP1_YEAR1.Text+' ';
  //部门条件:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP1_DEPT_ID.AsString);
  //考核指标:
  if fndP1_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and A.KPI_ID='''+fndP1_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP1_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  CustCnd:='';
  if (fndP1_CUST_VALUE.AsString<>'') then
  begin
    case fndP1_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP1_CUST_VALUE.AsString),2)='00' then  //非末级区域
           CustCnd:=' and D.REGION_ID like '''+GetRegionId(fndP1_CUST_VALUE.AsString)+'%'' '
         else
           CustCnd:=' and D.REGION_ID='''+fndP1_CUST_VALUE.AsString+''' ';
       end;
     1: CustCnd:=' and D.PRICE_ID='''+fndP1_CUST_VALUE.AsString+''' ';   //等级
     2: CustCnd:=' and D.SORT_ID='''+fndP1_CUST_VALUE.AsString+''' ';    //分类
     3: CustCnd:=' and D.FLAG='+fndP1_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  if trim(CustCnd)='' then
  begin
    strSql:=
      'select A.KPI_YEAR,A.DEPT_ID,Dept.DEPT_NAME,'+
      ' sum(A.BUDG_KPI) as BUDG_KPI,'+
      ' sum(A.BUDG_MNY) as BUDG_MNY,'+
      ' sum(A.BUDG_WDW) as BUDG_WDW,'+
      ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
      ' sum(A.BUDG_VRF) as BUDG_VRF '+
      ' from MKT_KPI_RESULT A '+
      //' left outer join ('+BudgTab+')B on A.TENANT_ID=B.TENANT_ID and A.KPI_YEAR=B.KPI_YEAR and A.KPI_ID=B.KPI_ID '+
      ' left outer join CA_DEPT_INFO DEPT '+
      ' on A.TENANT_ID=DEPT.TENANT_ID and A.DEPT_ID=DEPT.DEPT_ID '+
      ' group by A.KPI_YEAR,A.DEPT_ID,Dept.DEPT_NAME';
  end else
  begin
    strSql:=
      'select A.KPI_YEAR,A.DEPT_ID,Dept.DEPT_NAME,'+
      ' sum(A.BUDG_KPI) as BUDG_KPI,'+
      ' sum(A.BUDG_MNY) as BUDG_MNY,'+
      ' sum(A.BUDG_WDW) as BUDG_WDW,'+
      ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
      ' sum(A.BUDG_VRF) as BUDG_VRF '+
      ' from MKT_KPI_RESULT A '+
      ' inner join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
      //' left outer join ('+BudgTab+')B on A.TENANT_ID=B.TENANT_ID and A.KPI_YEAR=B.KPI_YEAR and A.KPI_ID=B.KPI_ID '+
      ' left outer join CA_DEPT_INFO DEPT '+
      ' on A.TENANT_ID=DEPT.TENANT_ID and A.DEPT_ID=DEPT.DEPT_ID '+
      ' where 1=1 '+strWhere+CustCnd+
      ' group by A.KPI_YEAR,A.DEPT_ID,Dept.DEPT_NAME';
  end;
  Result :=ParseSQL(Factor.iDbType, strSql);
end;

function TfrmMktBudgReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,CustCnd,BudgTab: string;
begin
  if fndP2_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP2_YEAR1.ItemIndex<>-1)and(fndP2_YEAR2.ItemIndex<>-1)and(fndP2_YEAR1.Text>fndP2_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP2_YEAR2.ItemIndex<>-1) and (fndP2_YEAR1.Text<fndP2_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP2_YEAR1.Text+' and A.KPI_YEAR<='+fndP2_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP2_YEAR1.Text+' ';
  //部门条件:
  if trim(fndP2_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP2_DEPT_ID.AsString);
  //考核指标:
  if fndP2_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and A.KPI_ID='''+fndP2_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP2_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP2_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  CustCnd:='';
  if (fndP2_CUST_VALUE.AsString<>'') then
  begin
    case fndP2_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP2_CUST_VALUE.AsString),2)='00' then  //非末级区域
           CustCnd:=' and D.REGION_ID like '''+GetRegionId(fndP2_CUST_VALUE.AsString)+'%'' '
         else
           CustCnd:=' and D.REGION_ID='''+fndP2_CUST_VALUE.AsString+''' ';
       end;
     1: CustCnd:=' and D.PRICE_ID='''+fndP2_CUST_VALUE.AsString+''' ';   //等级
     2: CustCnd:=' and D.SORT_ID='''+fndP2_CUST_VALUE.AsString+''' ';    //分类
     3: CustCnd:=' and D.FLAG='+fndP2_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;
  
  strSql:=
    'select A.KPI_YEAR,D.REGION_ID as REGION_ID,'+
    ' sum(A.BUDG_KPI) as BUDG_KPI,'+
    ' sum(A.BUDG_MNY) as BUDG_MNY,'+
    ' sum(A.BUDG_WDW) as BUDG_WDW,'+
    ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
    ' sum(A.BUDG_VRF) as BUDG_VRF '+
    ' from MKT_KPI_RESULT A '+
    ' inner join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
    //' left outer join ('+BudgTab+')B on A.TENANT_ID=B.TENANT_ID and A.KPI_YEAR=B.KPI_YEAR and A.KPI_ID=B.KPI_ID '+
    ' where 1=1 '+strWhere+CustCnd+
    ' group by A.KPI_YEAR,D.REGION_ID';

  //关联区域表
  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    ' isnull(Area.CODE_NAME,''无'') as CODE_NAME '+
    ' from ('+strSql+')K '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0)Area '+
    ' on K.REGION_ID=Area.CODE_ID '+
    ' order by K.REGION_ID '
    );
end;

function TfrmMktBudgReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmMktBudgReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //按部门汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetDeptSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按地区汇总表
        if adoReport2.Active then adoReport2.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text:= strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按KPI汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetClientSQL;

        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按客户汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetKPISQL;

        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
    4: begin //按商品汇总表
        if adoReport5.Active then adoReport5.Close;
        adoReport5.SortedFields:='';
        strSql := GetGlideSQL;

        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmMktBudgReport.GetCLIENTSQL(chk:boolean=true): string;
var
  strSql,strWhere,CustCnd,BudgTab: string;
begin
  if fndP3_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP3_YEAR1.ItemIndex<>-1)and(fndP3_YEAR2.ItemIndex<>-1)and(fndP3_YEAR1.Text>fndP3_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP3_YEAR2.ItemIndex<>-1) and (fndP3_YEAR1.Text<fndP3_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP3_YEAR1.Text+' and A.KPI_YEAR<='+fndP3_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP3_YEAR1.Text+' ';
  //部门条件:
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP3_DEPT_ID.AsString);
  //考核指标:
  if fndP3_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and A.KPI_ID='''+fndP3_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP3_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP3_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  CustCnd:='';
  if (fndP3_CUST_VALUE.AsString<>'') then
  begin
    case fndP3_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP3_CUST_VALUE.AsString),2)='00' then  //非末级区域
           CustCnd:=' and D.REGION_ID like '''+GetRegionId(fndP3_CUST_VALUE.AsString)+'%'' '
         else
           CustCnd:=' and D.REGION_ID='''+fndP3_CUST_VALUE.AsString+''' ';
       end;
     1: CustCnd:=' and D.PRICE_ID='''+fndP3_CUST_VALUE.AsString+''' ';   //等级
     2: CustCnd:=' and D.SORT_ID='''+fndP3_CUST_VALUE.AsString+''' ';    //分类
     3: CustCnd:=' and D.FLAG='+fndP3_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;
  
  strSql:=
    'select A.KPI_YEAR,A.CLIENT_ID,D.CLIENT_NAME,'+
    ' sum(A.BUDG_KPI) as BUDG_KPI,'+
    ' sum(A.BUDG_MNY) as BUDG_MNY,'+
    ' sum(A.BUDG_WDW) as BUDG_WDW,'+
    ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
    ' sum(A.BUDG_VRF) as BUDG_VRF '+
    ' from MKT_KPI_RESULT A,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+CustCnd+
    ' group by A.KPI_YEAR,A.CLIENT_ID,D.CLIENT_NAME';

  Result :=ParseSQL(Factor.iDbType, strSql);
end;

function TfrmMktBudgReport.GetKPISQL(chk:boolean=true): string;
var
  strSql,strWhere,SubCnd,CustCnd,BudgTab,SumFields: string;
begin
  SubCnd:='';
  if fndP4_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP4_YEAR1.ItemIndex<>-1)and(fndP4_YEAR2.ItemIndex<>-1)and(fndP4_YEAR1.Text>fndP4_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP4_YEAR2.ItemIndex<>-1) and (fndP4_YEAR1.Text<fndP4_YEAR2.Text) then //查询年度段
  begin
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP4_YEAR1.Text+' and A.KPI_YEAR<='+fndP4_YEAR2.Text+')';
    SubCnd:=' and (A.KPI_YEAR>='+fndP4_YEAR1.Text+' and A.KPI_YEAR<='+fndP4_YEAR2.Text+')';
  end else
  begin
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP4_YEAR1.Text+' ';
    SubCnd:=' and A.KPI_YEAR='+fndP4_YEAR1.Text+' ';
  end;
  //部门条件:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);
  //考核指标:
  if fndP4_KPI_ID.AsString<>'' then
  begin
    strWhere:=strWhere+' and A.KPI_ID='''+fndP4_KPI_ID.AsString+''' ';
    SubCnd:=SubCnd+' and A.KPI_ID='''+fndP4_KPI_ID.AsString+''' ';
  end;
  //客户名称:
  if fndP4_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP4_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  CustCnd:='';
  if (fndP4_CUST_VALUE.AsString<>'') then
  begin
    case fndP4_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP4_CUST_VALUE.AsString),2)='00' then  //非末级区域
           CustCnd:=' and D.REGION_ID like '''+GetRegionId(fndP4_CUST_VALUE.AsString)+'%'' '
         else
           CustCnd:=' and D.REGION_ID='''+fndP4_CUST_VALUE.AsString+''' ';
       end;
     1: CustCnd:=' and D.PRICE_ID='''+fndP4_CUST_VALUE.AsString+''' ';   //等级
     2: CustCnd:=' and D.SORT_ID='''+fndP4_CUST_VALUE.AsString+''' ';    //分类
     3: CustCnd:=' and D.FLAG='+fndP4_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  BudgTab:=
    'select '+
     'a.TENANT_ID as TENANT_ID,'+
     'a.REQU_ID as REQU_ID,'+
     'a.KPI_YEAR as KPI_YEAR,'+
     'a.KPI_ID as KPI_ID,'+
     'a.BUDG_VRF as BUDG_VRF_MNY,'+  //本次核销申领金额
     'b.BUDG_VRF as BUDG_VRF_SUB,'+      //本次核销金额
     'c.ACTIVE_GROUP as ACTIVE_GROUP '+
    ' from MKT_BUDGSHARE a,MKT_BUDGDATA b,MKT_ACTIVE_INFO c'+
    ' where a.TENANT_ID=b.TENANT_ID and a.KPI_ID=b.KPI_ID and a.BUDG_ID=b.BUDG_ID and '+
    ' b.TENANT_ID=c.TENANT_ID and b.ACTIVE_ID=c.ACTIVE_ID and a.TENANT_ID='+IntToStr(Global.TENANT_ID);

  SumFields:=' ';
  if trim(KpiSumFields)<>'' then SumFields:=','+KpiSumFields+' ';

  if trim(CustCnd)='' then
  begin
    strSql:=
      'select A.TENANT_ID,A.KPI_YEAR,A.KPI_ID,'+
      ' sum(A.BUDG_KPI) as BUDG_KPI,'+
      ' sum(A.BUDG_MNY) as BUDG_MNY,'+
      ' sum(A.BUDG_WDW) as BUDG_WDW,'+
      ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
      ' sum(A.BUDG_VRF) as BUDG_VRF'+SumFields+
      ' from MKT_KPI_RESULT A '+
      ' left outer join ('+BudgTab+')B '+
      ' on A.TENANT_ID=B.TENANT_ID and A.KPI_YEAR=B.KPI_YEAR and A.KPI_ID=B.KPI_ID '+
      ' where 1=1 '+strWhere+
      ' group by A.TENANT_ID,A.KPI_YEAR,A.KPI_ID';
  end else
  begin
    strSql:=
      'select A.TENANT_ID,A.KPI_YEAR,A.KPI_ID,'+
      ' sum(A.BUDG_KPI) as BUDG_KPI,'+
      ' sum(A.BUDG_MNY) as BUDG_MNY,'+
      ' sum(A.BUDG_WDW) as BUDG_WDW,'+
      ' sum(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_WDW,0))as BUDG_BAL,'+
      ' sum(A.BUDG_VRF) as BUDG_VRF'+SumFields+
      ' from MKT_KPI_RESULT A '+
      ' inner join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
      ' left outer join ('+BudgTab+')B '+
      ' on A.TENANT_ID=B.TENANT_ID and A.KPI_YEAR=B.KPI_YEAR and A.KPI_ID=B.KPI_ID '+
      ' where 1=1 '+strWhere+CustCnd+
      ' group by A.TENANT_ID,A.KPI_YEAR,A.KPI_ID';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' MKT.KPI_NAME as KPI_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' order by K.KPI_ID '
     );
end;

function TfrmMktBudgReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,BudgTab,ActiveTab: string;
begin
  if  fndP5_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP5_YEAR1.ItemIndex<>-1) and (fndP5_YEAR2.ItemIndex<>-1)and(fndP5_YEAR1.Text>fndP5_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP5_YEAR2.ItemIndex<>-1) and (fndP5_YEAR1.Text<fndP5_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (B.KPI_YEAR>='+fndP5_YEAR1.Text+' and B.KPI_YEAR<='+fndP5_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and B.KPI_YEAR='+fndP5_YEAR1.Text+' ';
  //部门条件:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP5_DEPT_ID.AsString);
  //考核指标:
  if fndP5_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP5_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP5_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP5_CLIENT_ID.AsString+''' ';
  //导购员:
  if fndP5_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.BUDG_USER='''+fndP5_GUIDE_USER.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP5_CUST_VALUE.AsString<>'') then
  begin
    case fndP5_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP5_CUST_VALUE.AsString),2)='00' then  //非末级区域
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP5_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP5_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP5_CUST_VALUE.AsString+''' ';   //等级
     2: strCnd:=' and D.SORT_ID='''+fndP5_CUST_VALUE.AsString+''' ';    //分类
     3: strCnd:=' and D.FLAG='+fndP5_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  ActiveTab:=
    'select a.TENANT_ID as TENANT_ID,'+
     'a.ACTIVE_ID as ACTIVE_ID,'+
     'a.ACTIVE_NAME as ACTIVE_NAME,'+
     'b.CODE_NAME as ACTIVE_GROUP_TXT '+
    ' from MKT_ACTIVE_INFO a,PUB_CODE_INFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.ACTIVE_GROUP=b.CODE_ID and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+
    ' and b.CODE_TYPE=''18'' and b.COMM not in (''02'',''12'')';

  strSql:=
    'select '+
     'A.TENANT_ID as TENANT_ID,'+
     'A.GLIDE_NO as GLIDE_NO,'+
     'C.ACTIVE_ID,'+
     'B.KPI_YEAR,'+
     'B.KPI_ID,'+
     'A.BUDG_DATE,'+
     'D.CLIENT_NAME,'+
     'B.BUDG_VRF as BUDG_WDW,'+
     'C.BUDG_VRF as BUDG_VRF,'+
     'C.REMARK as REMARK,'+
     'A.CREA_DATE as CREA_DATE,'+
     'A.CREA_USER as CREA_USER '+
    ' from MKT_BUDGORDER A,MKT_BUDGSHARE B,MKT_BUDGDATA C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.BUDG_ID=B.BUDG_ID and '+
    ' A.TENANT_ID=C.TENANT_ID and A.BUDG_ID=C.BUDG_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    ' MKT.KPI_NAME as KPI_NAME,'+
    ' AC.ACTIVE_NAME as ACTIVE_NAME,'+
    ' AC.ACTIVE_GROUP_TXT as ACTIVE_GROUP_TXT'+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' left outer join ('+ActiveTab+') AC on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=AC.ACTIVE_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmMktBudgReport.DBGridEh3DblClick(Sender: TObject);
begin
  if adoReport3.IsEmpty then Exit;
  fndP4_YEAR1.ItemIndex:=fndP3_YEAR1.ItemIndex;    //1.所属年份
  fndP4_YEAR2.ItemIndex:=fndP3_YEAR2.ItemIndex;
  fndP4_CUST_TYPE.ItemIndex:=fndP3_CUST_TYPE.ItemIndex;   //2.客户群组类型
  Copy_ParamsValue(fndP3_CUST_VALUE,fndP4_CUST_VALUE);    //  客户群组
  Copy_ParamsValue(fndP3_DEPT_ID,fndP4_DEPT_ID);          //3.客户
  Copy_ParamsValue(fndP3_CLIENT_ID,fndP4_CLIENT_ID);      //4.客户
  fndP4_CLIENT_ID.KeyValue:=adoReport3.fieldbyName('CLIENT_ID').AsString;  //5.客户名称
  fndP4_CLIENT_ID.Text:=adoReport3.fieldbyName('CLIENT_NAME').AsString;
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmMktBudgReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmMktBudgReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  try
    Title:=TStringList.Create;
    case rzPage.ActivePageIndex of
     0: AddReportReport(Title,'1');
     1: AddReportReport(Title,'2');
     2: AddReportReport(Title,'3');
     3: AddReportReport(Title,'4');
     4: AddReportReport(Title,'5');
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmMktBudgReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmMktBudgReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmMktBudgReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmMktBudgReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;  
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText 
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmMktBudgReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  fndP2_YEAR1.ItemIndex:=fndP1_YEAR1.ItemIndex;     //1.所属年份
  fndP2_YEAR2.ItemIndex:=fndP1_YEAR2.ItemIndex;
  fndP2_CUST_TYPE.ItemIndex:=fndP1_CUST_TYPE.ItemIndex;  //2.客户群组类型
  Copy_ParamsValue(fndP1_CUST_VALUE,fndP2_CUST_VALUE);   //  客户群组
  Copy_ParamsValue(fndP1_KPI_ID,fndP2_KPI_ID);           //3.考核指标
  Copy_ParamsValue(fndP1_CLIENT_ID,fndP2_CLIENT_ID);     //4.客户
  fndP2_DEPT_ID.KeyValue:=adoReport1.fieldbyName('DEPT_ID').AsString; //5.部门名称 
  fndP2_DEPT_ID.Text:=adoReport1.fieldbyName('DEPT_NAME').AsString; 
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmMktBudgReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  fndP3_YEAR1.ItemIndex:=fndP2_YEAR1.ItemIndex;  //1.所属年份
  fndP3_YEAR2.ItemIndex:=fndP2_YEAR2.ItemIndex;
  Copy_ParamsValue(fndP2_KPI_ID,fndP3_KPI_ID);   //2.考核指标
  Copy_ParamsValue(fndP2_CLIENT_ID,fndP3_CLIENT_ID);  //3.客户
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID);      //4.部门
  fndP3_CUST_TYPE.ItemIndex:=0;                       //5.客户群组
  fndP3_CUST_VALUE.KeyValue:=adoReport2.fieldbyName('REGION_ID').AsString;
  fndP3_CUST_VALUE.Text:=adoReport2.fieldbyName('CODE_NAME').AsString;
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmMktBudgReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  fndP5_YEAR1.ItemIndex:=fndP4_YEAR1.ItemIndex;          //1.所属年度
  fndP5_YEAR2.ItemIndex:=fndP4_YEAR2.ItemIndex;
  fndP5_CUST_TYPE.ItemIndex:=fndP4_CUST_TYPE.ItemIndex;  //2.客户群组类型
  Copy_ParamsValue(fndP4_CUST_VALUE,fndP5_CUST_VALUE);   //  客户群组
  Copy_ParamsValue(fndP4_KPI_ID,fndP5_KPI_ID);           //3.考核指标
  Copy_ParamsValue(fndP4_DEPT_ID,fndP5_DEPT_ID);           //4.考核指标
  fndP5_KPI_ID.KeyValue:=adoReport4.fieldbyName('KPI_ID').AsString;  //5.考核指标
  fndP5_KPI_ID.Text:=adoReport4.fieldbyName('KPI_NAME').AsString;
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmMktBudgReport.SetRzPageActivePage(IsGroupReport: Boolean);
var
  i: integer;
  IsVisble: Boolean;
  Rs: TZQuery;
begin
  Rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if Rs<>nil then
  begin
    try
      Rs.Filtered:=false;
      Rs.Filter:='DEPT_TYPE=1';
      Rs.Filtered:=true;
      rzPage.Pages[0].TabVisible:=(Rs.RecordCount>1);  //多个营销部时显示
    finally
      Rs.Filtered:=false;
      Rs.Filter:='';
    end;
  end;

  IsVisble:=HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
  rzPage.Pages[1].TabVisible := IsVisble;
  rzPage.Pages[2].TabVisible := IsVisble;
  for i:=0 to rzPage.PageCount-1 do
  begin
    if rzPage.Pages[i].TabVisible then
    begin
      rzPage.ActivePageIndex:=i;
      break;
    end;
  end; 
end;

procedure TfrmMktBudgReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'KPI_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmMktBudgReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

function TfrmMktBudgReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;


procedure TfrmMktBudgReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
var
  Str,CurYear: string;
  Rs: TZQuery;
begin
  ClearCbxPickList(SetCbx);
  CurYear:=FormatDatetime('YYYY',Date());
  Rs:=TZQuery.Create(nil);
  try
    Rs.SQL.Text:='select distinct KPI_YEAR from MKT_KPI_RESULT order by KPI_YEAR Desc';
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

procedure TfrmMktBudgReport.CreateKpiSumGrid;
var
  CodeID: string;
  rs: TZQuery;
  SetCol: TColumnEh;
begin
  KpiSumFields:='';
  //市场活动分组:
  rs:=Global.GetZQueryFromName('MKT_ACTIVE_GROUP');
  if (rs<>nil)and (not rs.IsEmpty) then
  begin
    DBGridEh4.Columns.BeginUpdate;
    try
      rs.First;
      while not rs.Eof do
      begin
        CodeID:=trim(rs.FieldByName('CODE_ID').AsString);
        if KpiSumFields='' then
          KpiSumFields:='sum(case when ACTIVE_GROUP='''+CodeID+''' then BUDG_VRF_SUB else 0 end) as VRF_'+FormatFloat('0000',rs.RecNo)+'_MNY'
        else
          KpiSumFields:=KpiSumFields+',sum(case when ACTIVE_GROUP='''+CodeID+''' then BUDG_VRF_SUB else 0 end) as VRF_'+FormatFloat('0000',rs.RecNo)+'_MNY';
        SetCol := DBGridEh4.Columns.Add;
        SetCol.FieldName := 'VRF_'+FormatFloat('0000',rs.RecNo)+'_MNY';
        SetCol.Title.Caption := '核销|'+trim(rs.FieldByName('CODE_NAME').AsString);
        SetCol.Width := 80;
        SetCol.Index := DBGridEh4.Columns.Count-2;//
        SetCol.DisplayFormat:='#0.00';
        SetCol.Footer.ValueType:=fvtSum;
        SetCol.Footer.DisplayFormat:='#0.00';
        rs.Next;
      end;
    finally
      DBGridEh4.Columns.EndUpdate;
    end;
    SetCol:=FindColumn(DBGridEh4,'BUDG_VRF');
    if SetCol<>nil then SetCol.Title.Caption:='核销|合计';
  end;
end;

end.
