unit ufrmClientKpiReport;

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
  TfrmClientKpiReport = class(TframeBaseReport)
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzLabel2: TRzLabel;
    btnOk: TRzBitBtn;
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
    RzBitBtn2: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh4: TDBGridEh;
    RzPanel9: TRzPanel;
    BtnSort: TRzBitBtn;
    RzPanel10: TRzPanel;
    DBGridEh3: TDBGridEh;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    BtnDept: TRzBitBtn;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    BtnSaleSum: TRzBitBtn;
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
    fndP3_CUST_TYPE: TcxComboBox;
    fndP3_YEAR1: TcxComboBox;
    RzLabel8: TRzLabel;
    fndP3_KPI_ID: TzrComboBoxList;
    fndP3_CUST_VALUE: TzrComboBoxList;
    fndP3_YEAR2: TcxComboBox;
    Label13: TLabel;
    Label14: TLabel;
    fndP3_CLIENT_ID: TzrComboBoxList;
    fndP3_DEPT_ID: TzrComboBoxList;
    RzLabel4: TRzLabel;
    Label9: TLabel;
    Label11: TLabel;
    fndP4_CUST_TYPE: TcxComboBox;
    fndP4_YEAR1: TcxComboBox;
    RzLabel5: TRzLabel;
    fndP4_KPI_ID: TzrComboBoxList;
    fndP4_CUST_VALUE: TzrComboBoxList;
    fndP4_YEAR2: TcxComboBox;
    Label12: TLabel;
    Label15: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
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
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    //返回考核基础表
    function GetKPIBaseTab(strWhere,ClientCnd: string; IsTable: Boolean=True): string;
    //按部门考核汇总表
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //按管理考核汇总表
    function GetGroupSQL(chk:boolean=true): string;  //2222
    //按门店考核汇总表
    function GetKPISQL(chk:boolean=true): string;    //3333
    //按客户考核汇总表
    function GetClientSQL(chk:boolean=true): string;  //4444
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

procedure TfrmClientKpiReport.FormCreate(Sender: TObject);
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
  SetGridColumnDisplayFormat(['DBGridEh1.JT_MNY','DBGridEh1.REQU_MNY','DBGridEh1.JY_MNY','DBGridEh1.BOND_MNY',
                              'DBGridEh2.JT_MNY','DBGridEh2.REQU_MNY','DBGridEh2.JY_MNY','DBGridEh2.BOND_MNY',
                              'DBGridEh3.JT_MNY','DBGridEh3.REQU_MNY','DBGridEh3.JY_MNY','DBGridEh3.BOND_MNY',
                              'DBGridEh4.JT_MNY','DBGridEh4.REQU_MNY','DBGridEh4.JY_MNY','DBGridEh4.BOND_MNY',
                              'DBGridEh5.JT_MNY']);
  //创建计算对象：
  CalcFooter:=TCalcFooter.Create;                            
end;

function TfrmClientKpiReport.GetKPIBaseTab(strWhere, ClientCnd: string; IsTable: Boolean): string;
begin
  if trim(ClientCnd)='' then
  begin
    result:=
      'select A.*,'+
      ' B.KPI_ID as KPI_ID,'+      //计划明细表考核ID
      ' B.AMOUNT as AMOUNT,'+      //计划明细表数量
      ' B.AMONEY as AMONEY,'+      //计划明细表金额
      ' B.BOND_MNY as BOND_MNY,'+  //计划明细表保证金
      ' B.REMARK as REMARK,'+      //计划明细表备注
      ' C.IDX_TYPE as IDX_TYPE,'+  //指标类型
      ' C.KPI_CALC as KPI_CALC,'+  //指标计算标准
      ' C.BEGIN_DATE as KPI_BEGIN_DATE,'+ //考核开始日期
      ' C.END_DATE as KPI_END_DATE,'+     //考核结束日期
      ' C.CHK_DATE as KPI_CHK_DATE,'+     //考核审核日期
      ' C.CHK_USER as KPI_CHK_USER,'+     //考核审核人
      ' C.FISH_AMT as KPI_FISH_AMT,'+     //考核完成数量
      ' C.FISH_MNY as KPI_FISH_MNY,'+     //考核完成金额
      ' C.KPI_MNY as KPI_MNY,'+           //考核结果(元)
      ' C.WDW_MNY as WDW_MNY  '+          //考核提取反利
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.KPI_ID=C.KPI_ID and A.PLAN_TYPE=''1'' '+
      '  '+strWhere;
  end else
  begin
    result:=
      'select A.*,'+
      ' B.KPI_ID as KPI_ID,'+      //计划明细表考核ID
      ' B.AMOUNT as AMOUNT,'+      //计划明细表数量
      ' B.AMONEY as AMONEY,'+      //计划明细表金额
      ' B.BOND_MNY as BOND_MNY,'+  //计划明细表保证金
      ' B.REMARK as REMARK,'+      //计划明细表备注
      ' C.IDX_TYPE as IDX_TYPE,'+  //指标类型
      ' C.KPI_CALC as KPI_CALC,'+  //指标计算标准
      ' C.BEGIN_DATE as KPI_BEGIN_DATE,'+ //考核开始日期
      ' C.END_DATE as KPI_END_DATE,'+     //考核结束日期
      ' C.CHK_DATE as KPI_CHK_DATE,'+     //考核审核日期
      ' C.CHK_USER as KPI_CHK_USER,'+     //考核审核人
      ' C.FISH_AMT as KPI_FISH_AMT,'+     //考核完成数量
      ' C.FISH_MNY as KPI_FISH_MNY,'+     //考核完成金额
      ' C.KPI_MNY as KPI_MNY,'+           //考核结果(元)
      ' C.WDW_MNY as WDW_MNY  '+          //考核提取反利
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+ClientCnd;
  end;
end;

function TfrmClientKpiReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
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

  if trim(StrCnd)='' then
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
      ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
      ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
      ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and A.PLAN_TYPE=''1'' '+strWhere+' '+
      ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
      ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
      ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
      ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
      ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
      '(case when K.PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //完成率
      '(JT_MNY - REQU_MNY) as JY_MNY,'+   //结余金额
     ' MKT.UNIT_NAME as UNIT_NAME,'+
     ' DEPT.DEPT_NAME as DEPT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+')DEPT '+
     ' on K.DEPT_ID=DEPT.DEPT_ID '+
     ' order by K.DEPT_ID '
     );
end;

function TfrmClientKpiReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if fndP2_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP2_YEAR1.ItemIndex<>-1) and (fndP2_YEAR2.ItemIndex<>-1) and (fndP2_YEAR1.Text>fndP2_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

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
    strWhere:=strWhere+' and C.KPI_ID='''+fndP2_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP2_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP2_CLIENT_ID.AsString+''' ';
    
  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP2_CUST_VALUE.AsString<>'') then
  begin
    case fndP2_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP2_CUST_VALUE.AsString),2)='00' then  //非末级区域
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP2_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP2_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP2_CUST_VALUE.AsString+''' ';   //等级
     2: strCnd:=' and D.SORT_ID='''+fndP2_CUST_VALUE.AsString+''' ';    //分类
     3: strCnd:=' and D.FLAG='+fndP2_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' D.REGION_ID as REGION_ID,'+
    ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
    ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
    ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
    ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,D.REGION_ID';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+                                 
     ' (case when K.PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //完成率
     ' (JT_MNY - REQU_MNY) as JY_MNY,'+   //结余金额
     '  MKT.UNIT_NAME as UNIT_NAME,'+
     '  isnull(Area.CODE_NAME,''无'') as CODE_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0)Area '+
     ' on K.REGION_ID=Area.CODE_ID '+
     ' order by K.REGION_ID '
   );
end;

function TfrmClientKpiReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmClientKpiReport.actFindExecute(Sender: TObject);
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
        strSql := GetKPISQL;

        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按客户汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetClientSQL;

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

function TfrmClientKpiReport.GetKPISQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if  fndP3_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
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
    strWhere:=strWhere+' and C.KPI_ID='''+fndP3_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP3_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP3_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP3_CUST_VALUE.AsString<>'') then
  begin
    case fndP3_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP3_CUST_VALUE.AsString),2)='00' then  //非末级区域
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP3_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP3_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP3_CUST_VALUE.AsString+''' ';   //等级
     2: strCnd:=' and D.SORT_ID='''+fndP3_CUST_VALUE.AsString+''' ';    //分类
     3: strCnd:=' and D.FLAG='+fndP3_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  if trim(StrCnd)='' then
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
      ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
      ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
      ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and A.PLAN_TYPE=''1'' '+strWhere+' '+
      ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
      ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
      ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
      ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
      ' and A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
      ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' (case when K.PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //完成率
     ' (JT_MNY - REQU_MNY) as JY_MNY,'+   //结余金额
     ' MKT.KPI_NAME as KPI_NAME,'+
     ' MKT.UNIT_NAME as UNIT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' order by K.KPI_ID '
     );
end;

function TfrmClientKpiReport.GetCLIENTSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if  fndP4_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP4_YEAR1.ItemIndex<>-1)and(fndP4_YEAR2.ItemIndex<>-1)and(fndP4_YEAR1.Text>fndP4_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP4_YEAR2.ItemIndex<>-1) and (fndP4_YEAR1.Text<fndP4_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP4_YEAR1.Text+' and A.KPI_YEAR<='+fndP4_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP4_YEAR1.Text+' ';
  //部门条件:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);
  //考核指标:
  if fndP4_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP4_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP4_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP4_CLIENT_ID.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP4_CUST_VALUE.AsString<>'') then
  begin
    case fndP4_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP4_CUST_VALUE.AsString),2)='00' then  //非末级区域
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP4_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP4_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP4_CUST_VALUE.AsString+''' ';   //等级
     2: strCnd:=' and D.SORT_ID='''+fndP4_CUST_VALUE.AsString+''' ';    //分类
     3: strCnd:=' and D.FLAG='+fndP4_CUST_VALUE.AsString+' ';           //客户群体
    end;
  end;

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.CLIENT_ID as CLIENT_ID,'+
    ' D.CLIENT_NAME as CLIENT_NAME,'+
    ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' sum(C.KPI_MNY) as JT_MNY,'+     //考核结果(元)[计提金额]
    ' sum(C.WDW_MNY) as REQU_MNY,'+   //考核提取反利[申领金额]
    ' sum(B.BOND_MNY) as BOND_MNY '+  //保证金额
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
    ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.CLIENT_ID,D.CLIENT_NAME ';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' (case when K.PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //完成率
     ' (JT_MNY - REQU_MNY) as JY_MNY,'+   //结余金额
     ' MKT.UNIT_NAME as UNIT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' left outer join (select KPI_ID,KPI_LV from MKT_KPI_OPTION where TENANT_ID='+InttoStr(Global.TENANT_ID)+') OP on K.KPI_ID=OP.KPI_ID '+
     ' order by K.CLIENT_ID '
     );
end;

function TfrmClientKpiReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if  fndP5_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP5_YEAR1.ItemIndex<>-1) and (fndP5_YEAR2.ItemIndex<>-1)and(fndP5_YEAR1.Text>fndP5_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //考核年度条件
  if (fndP5_YEAR2.ItemIndex<>-1) and (fndP5_YEAR1.Text<fndP5_YEAR2.Text) then //查询年度段
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP5_YEAR1.Text+' and A.KPI_YEAR<='+fndP5_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP5_YEAR1.Text+' ';
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
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP5_GUIDE_USER.AsString+''' ';

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

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' A.GLIDE_NO as GLIDE_NO,'+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' C.BEGIN_DATE as BEGIN_DATE,'+ //考核开始日期
    ' C.END_DATE as END_DATE,'+     //考核结束日期
    ' (case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' (case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' C.KPI_MNY as JT_MNY,'+      //考核结果(元)[计提金额]
    ' C.WDW_MNY as REQU_MNY,'+    //考核提取反利[申领金额]
    ' B.BOND_MNY as BOND_MNY,'+   //保证金额
    ' C.REMARK as REMARK,'+
    ' C.CREA_DATE as CREA_DATE,'+
    ' C.CREA_USER as CREA_USER,'+
    ' D.CLIENT_NAME as CLIENT_NAME '+
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    '(case when PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //完成率
    '(case when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''1'') then ''上半年'' '+
         ' when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''2'') then ''下半年'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''1'') then ''第一季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''2'') then ''第二季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''3'') then ''第三季度'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''4'') then ''第四季度'' '+
         ' else '' '' end)as KPI_LV,'+  //考核周期
    ' MKT.KPI_NAME as KPI_NAME,'+
    ' MKT.UNIT_NAME as UNIT_NAME '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' left outer join (select KPI_ID,KPI_LV from MKT_KPI_OPTION where TENANT_ID='+InttoStr(Global.TENANT_ID)+') OP on K.KPI_ID=OP.KPI_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmClientKpiReport.DBGridEh4DblClick(Sender: TObject);
begin
  if adoReport4.IsEmpty then Exit;
  fndP5_YEAR1.ItemIndex:=fndP4_YEAR1.ItemIndex;          //1.所属年度
  fndP5_YEAR2.ItemIndex:=fndP4_YEAR2.ItemIndex;
  fndP5_CUST_TYPE.ItemIndex:=fndP4_CUST_TYPE.ItemIndex;  //2.客户群组类型
  Copy_ParamsValue(fndP4_CUST_VALUE,fndP5_CUST_VALUE);   //  客户群组
  Copy_ParamsValue(fndP4_KPI_ID,fndP5_KPI_ID);           //3.考核指标
  Copy_ParamsValue(fndP4_DEPT_ID,fndP5_DEPT_ID);           //4.考核指标
  fndP5_CLIENT_ID.KeyValue:=adoReport4.fieldbyName('CLIENT_ID').AsString;  //5.客户名称
  fndP5_CLIENT_ID.Text:=adoReport4.fieldbyName('CLIENT_NAME').AsString;
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmClientKpiReport.PrintBefore;
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

function TfrmClientKpiReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
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


procedure TfrmClientKpiReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text
    else if Column.FieldName = 'KPI_RATE' then
      Text:=CalcFooter.CalcValue(1);
  end;
end;

procedure TfrmClientKpiReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text
    else if Column.FieldName = 'KPI_RATE' then
      Text:=CalcFooter.CalcValue(1);
  end;
end;

procedure TfrmClientKpiReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text
    else if Column.FieldName = 'KPI_RATE' then
      Text:=CalcFooter.CalcValue(1);
  end;
end;

procedure TfrmClientKpiReport.DBGridEh1DblClick(Sender: TObject);
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

procedure TfrmClientKpiReport.DBGridEh2DblClick(Sender: TObject);
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

procedure TfrmClientKpiReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  fndP4_YEAR1.ItemIndex:=fndP3_YEAR1.ItemIndex;    //1.所属年份
  fndP4_YEAR2.ItemIndex:=fndP3_YEAR2.ItemIndex;
  fndP4_CUST_TYPE.ItemIndex:=fndP3_CUST_TYPE.ItemIndex;   //2.客户群组类型
  Copy_ParamsValue(fndP3_CUST_VALUE,fndP4_CUST_VALUE);    //  客户群组
  Copy_ParamsValue(fndP3_DEPT_ID,fndP4_DEPT_ID);          //3.客户
  Copy_ParamsValue(fndP3_CLIENT_ID,fndP4_CLIENT_ID);      //4.客户
  fndP4_KPI_ID.KeyValue:=adoReport3.fieldbyName('KPI_ID').AsString;  //5.考核指标
  fndP4_KPI_ID.Text:=adoReport3.fieldbyName('KPI_NAME').AsString;
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.SetRzPageActivePage(IsGroupReport: Boolean);
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
      //rzPage.Pages[0].TabVisible:=(Rs.RecordCount>1);  //多个营销部时显示
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

procedure TfrmClientKpiReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'KPI_NAME' then Text := '合计:'+Text+'笔';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text
    else if Column.FieldName = 'KPI_RATE' then
      Text:=CalcFooter.CalcValue(1);
  end;
end;

procedure TfrmClientKpiReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
  if Column.FieldName = 'KPI_RATE' then
    GridGetFooterParamsValue(Sender,Text);  
end;

function TfrmClientKpiReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;


procedure TfrmClientKpiReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
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

end.
