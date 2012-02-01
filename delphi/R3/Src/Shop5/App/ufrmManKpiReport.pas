unit ufrmManKpiReport;

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
  TfrmManKpiReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel2: TRzLabel;
    btnOk: TRzBitBtn;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    dsadoReport4: TDataSource;
    Label7: TLabel;
    fndP1_KPI_ID: TzrComboBoxList;
    fndP3_KPI_ID: TzrComboBoxList;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzBitBtn2: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel9: TRzPanel;
    BtnSort: TRzBitBtn;
    RzPanel10: TRzPanel;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    BtnSaleSum: TRzBitBtn;
    RzPanel21: TRzPanel;
    DBGridEh4: TDBGridEh;
    fndP1_YEAR1: TcxComboBox;
    RzLabel6: TRzLabel;
    fndP1_YEAR2: TcxComboBox;
    Label17: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label44: TLabel;
    RzLabel1: TRzLabel;
    Label8: TLabel;
    fndP2_YEAR1: TcxComboBox;
    RzLabel8: TRzLabel;
    fndP2_KPI_ID: TzrComboBoxList;
    fndP2_YEAR2: TcxComboBox;
    Label13: TLabel;
    fndP2_DEPT_ID: TzrComboBoxList;
    RzLabel4: TRzLabel;
    Label9: TLabel;
    fndP3_YEAR1: TcxComboBox;
    RzLabel5: TRzLabel;
    fndP3_YEAR2: TcxComboBox;
    fndP4_YEAR1: TcxComboBox;
    fndP4_KPI_ID: TzrComboBoxList;
    fndP4_YEAR2: TcxComboBox;
    Label12: TLabel;
    fndP4_DEPT_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    Label16: TLabel;
    RzLabel10: TRzLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    fndP3_DEPT_ID:TzrComboBoxList;
    Label23: TLabel;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    Label3: TLabel;
    Label4: TLabel;
    fndP3_SHOP_TYPE: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    Label6: TLabel;
    fndP1_GUIDE_USER: TzrComboBoxList;
    fndP2_GUIDE_USER: TzrComboBoxList;
    fndP3_GUIDE_USER: TzrComboBoxList;
    fndP4_GUIDE_USER: TzrComboBoxList;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    Label10: TLabel;
    DBGridEh2: TDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
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
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    FLog: TStringList;
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    //按部门考核汇总表
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //按考核汇总表
    function GetKPISQL(chk:boolean=true): string;    //3333
    //按客户考核汇总表
    function GetManSQL(chk:boolean=true): string;  //4444
    //按客户考核明细流水表
    function GetGlideSQL(chk:boolean=true): string;   //5555
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    //设置Page分页显示:（IsGroupReport是否分组[区域、门店]）
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function  GetDataRight: string;
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property DataRight: string read GetDataRight; //返回查看数据权限
  end;

   
implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmManKpiReport.FormCreate(Sender: TObject);
begin
  //必须放在继承之前取数:
  DoCreateKPIDataSet('3');
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

  TDbGridEhSort.InitForm(self,false);
  SetRzPageActivePage; //设置PzPage.Activepage

  RefreshColumn;                                           
  //2011.09.21 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.JT_MNY','DBGridEh2.JT_MNY','DBGridEh3.JT_MNY','DBGridEh4.JT_MNY','DBGridEh5.JT_MNY']);
  //创建计算对象：
  CalcFooter:=TCalcFooter.Create;
end;

function TfrmManKpiReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd,U_Tab: string;
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
  if fndP1_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP1_GUIDE_USER.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP1_SHOP_VALUE.AsString<>'') then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strCnd:=strCnd+' and D.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strCnd:=strCnd+' and D.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
       end;
      1: strCnd:=strCnd+' and D.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
    U_Tab:='(select E.* from VIW_USERS E,Ca_SHOP_INFO D where E.TENANT_ID=D.TENANT_ID and E.SHOP_ID=D.SHOP_ID '+strCnd+')';
  end else
    U_Tab:='VIW_USERS';

  strSql:=
    'select '+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' sum(C.KPI_MNY) as JT_MNY  '+     //考核结果(元)[计提金额]
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,'+U_Tab+' U '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
    ' and A.TENANT_ID=U.TENANT_ID and A.PLAN_USER=U.USER_ID '+ //关联员工
    ' and A.PLAN_TYPE=''2'' '+strWhere+' '+
    ' group by C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     '(case when PLAN_AMT<>0 then cast(KPI_AMT/PLAN_AMT as decimal(18,6)) else 0.00 end) as KPI_RATE,'+     //完成率
     ' MKT.UNIT_NAME as UNIT_NAME,'+
     ' DEPT.DEPT_NAME as DEPT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.KPI_ID=MKT.KPI_ID '+
     ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+')DEPT '+
     ' on K.DEPT_ID=DEPT.DEPT_ID '+
     ' order by K.DEPT_ID '
     );
end;

function TfrmManKpiReport.GetRowType: integer;
begin
  result :=0;
end;

procedure TfrmManKpiReport.actFindExecute(Sender: TObject);
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
        strSql := self.GetKPISQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text:= strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按KPI汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := self.GetManSQL;   
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3:begin //按流水表
        if adoReport4.Active then adoReport4.Close;
        adoReport4.SortedFields:='';
        strSql := GetGlideSQL;  
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4); 
      end;
  end;
end;

function TfrmManKpiReport.GetKPISQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,U_Tab: string;
begin
  if  fndP2_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
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
    strWhere:=strWhere+' and C.KPI_ID='''+fndP2_KPI_ID.AsString+''' ';
  //员工:
  if fndP2_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP2_GUIDE_USER.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP2_SHOP_VALUE.AsString<>'') then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strCnd:=strCnd+' and D.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
         else
           strCnd:=strCnd+' and D.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
       end;
      1: strCnd:=strCnd+' and D.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
    U_Tab:='(select E.* from VIW_USERS E,Ca_SHOP_INFO D where E.TENANT_ID=D.TENANT_ID and E.SHOP_ID=D.SHOP_ID '+strCnd+')';
  end else
    U_Tab:='VIW_USERS';

  strSql:=
    'select '+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' sum(C.KPI_MNY) as JT_MNY  '+     //考核结果(元)[计提金额]
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,'+U_Tab+' U '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
    ' and A.TENANT_ID=U.TENANT_ID and A.PLAN_USER=U.USER_ID '+ //关联员工
    ' and A.PLAN_TYPE=''2'' '+strWhere+' '+
    ' group by C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' (case when PLAN_AMT<>0 then cast(KPI_AMT/PLAN_AMT as decimal(18,6)) else 0.00 end) as KPI_RATE,'+     //完成率
     ' MKT.KPI_NAME as KPI_NAME,'+
     ' MKT.UNIT_NAME as UNIT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.KPI_ID=MKT.KPI_ID '+
     ' order by K.KPI_ID '
     );
end;

function TfrmManKpiReport.GetManSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,U_Tab: string;
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
  //员工名称:
  if fndP3_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP3_GUIDE_USER.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP3_SHOP_VALUE.AsString<>'') then
  begin
    case fndP3_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP3_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strCnd:=strCnd+' and D.REGION_ID like '''+GetRegionId(fndP3_SHOP_VALUE.AsString)+'%'' '
         else
           strCnd:=strCnd+' and D.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
       end;
      1: strCnd:=strCnd+' and D.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
    U_Tab:='(select E.* from VIW_USERS E,Ca_SHOP_INFO D where E.TENANT_ID=D.TENANT_ID and E.SHOP_ID=D.SHOP_ID '+strCnd+')';
  end else
    U_Tab:='VIW_USERS';

  strSql:=
    'select '+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' A.PLAN_USER as PLAN_USER,'+
    ' U.USER_NAME as GUIDE_NAME,'+
    ' sum(case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' sum(case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' sum(C.KPI_MNY) as JT_MNY  '+     //考核结果(元)[计提金额]
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,'+U_Tab+' U '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
    ' and A.TENANT_ID=U.TENANT_ID and A.PLAN_USER=U.USER_ID '+ //关联员工
    ' and A.PLAN_TYPE=''2'' '+strWhere+' '+
    ' group by C.KPI_ID,A.KPI_YEAR,A.DEPT_ID,A.PLAN_USER,U.USER_NAME';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' (case when PLAN_AMT<>0 then cast(KPI_AMT/PLAN_AMT as decimal(18,6)) else 0.00 end) as KPI_RATE,'+     //完成率
     ' MKT.KPI_NAME as KPI_NAME,'+
     ' MKT.UNIT_NAME as UNIT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.KPI_ID=MKT.KPI_ID '+
     ' order by K.KPI_ID '
     );
end;

function TfrmManKpiReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,U_Tab: string;
begin
  if  fndP4_YEAR1.ItemIndex=-1 then Raise Exception.Create('所属年份不能为空...');
  if (fndP4_YEAR1.ItemIndex<>-1) and (fndP4_YEAR2.ItemIndex<>-1)and(fndP4_YEAR1.Text>fndP4_YEAR2.Text) then Raise Exception.Create('开始年份不能大于结束年份...');

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
  //人员名称:
  if fndP4_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP4_GUIDE_USER.AsString+''' ';

  //客户群体所属行政区域|客户等级\客户分类:
  strCnd:='';
  if (fndP4_SHOP_VALUE.AsString<>'') then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP4_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strCnd:=strCnd+' and D.REGION_ID like '''+GetRegionId(fndP4_SHOP_VALUE.AsString)+'%'' '
         else
           strCnd:=strCnd+' and D.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
       end;
      1: strCnd:=strCnd+' and D.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
    end;
    U_Tab:='(select E.* from VIW_USERS E,Ca_SHOP_INFO D where E.TENANT_ID=D.TENANT_ID and E.SHOP_ID=D.SHOP_ID '+strCnd+')';
  end else
    U_Tab:='VIW_USERS';

  strSql:=
    'select '+
    ' A.GLIDE_NO as GLIDE_NO,'+
    ' C.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' U.USER_NAME as GUIDE_NAME,'+  
    ' C.BEGIN_DATE as BEGIN_DATE,'+ //考核开始日期
    ' C.END_DATE as END_DATE,'+     //考核结束日期
    ' (case when C.KPI_CALC in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //计划量
    ' (case when C.KPI_CALC in (''1'',''4'') then C.FISH_AMT else C.FISH_MNY end) as KPI_AMT,'+  //完成量
    ' C.KPI_MNY as JT_MNY,'+      //考核结果(元)[计提金额]
    ' C.REMARK as REMARK,'+
    ' C.CHK_DATE as CHK_DATE,'+
    ' C.CHK_USER as CHK_USER '+
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,'+U_Tab+' U '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
    ' and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
    ' and A.TENANT_ID=U.TENANT_ID and A.PLAN_USER=U.USER_ID '+ //关联员工    
    ' and A.PLAN_TYPE=''2'' '+strWhere+' ';

  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    '(case when PLAN_AMT<>0 then cast(K.KPI_AMT/K.PLAN_AMT as decimal(18,6)) else 0.00 end) as KPI_RATE,'+     //完成率
    ' OP.KPI_LV as KPI_LV,'+
    ' MKT.KPI_NAME as KPI_NAME,'+
    ' MKT.UNIT_NAME as UNIT_NAME '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.KPI_ID=MKT.KPI_ID '+
    ' left outer join MKT_KPI_OPTION OP on K.KPI_ID=OP.KPI_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmManKpiReport.DBGridEh3DblClick(Sender: TObject);
begin
  if adoReport3.IsEmpty then Exit;
  fndP4_YEAR1.ItemIndex:=fndP3_YEAR1.ItemIndex;          //1.所属年份
  fndP4_YEAR2.ItemIndex:=fndP3_YEAR2.ItemIndex;
  fndP4_SHOP_TYPE.ItemIndex:=fndP3_SHOP_TYPE.ItemIndex;  //2.门店群组分类
  Copy_ParamsValue(fndP3_SHOP_VALUE,fndP4_SHOP_VALUE);   //  门店群组值
  Copy_ParamsValue(fndP3_KPI_ID,fndP4_KPI_ID);           //3.考核指标
  Copy_ParamsValue(fndP3_GUIDE_USER,fndP4_GUIDE_USER);   //4.客户
  fndP4_GUIDE_USER.KeyValue:=trim(adoReport3.fieldbyName('PLAN_USER').AsString);  //5.员工
  fndP4_GUIDE_USER.Text:=trim(adoReport3.fieldbyName('GUIDE_NAME').AsString);
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmManKpiReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmManKpiReport.PrintBefore;
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

function TfrmManKpiReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
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


procedure TfrmManKpiReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
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

procedure TfrmManKpiReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
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

procedure TfrmManKpiReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'GUIDE_NAME' then Text := '合计:'+Text+'笔';
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

procedure TfrmManKpiReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'GUIDE_NAME' then Text := '合计:'+Text+'笔';
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

procedure TfrmManKpiReport.DBGridEh1DblClick(Sender: TObject);
begin
  if adoReport1.IsEmpty then Exit;
  fndP2_YEAR1.ItemIndex:=fndP1_YEAR1.ItemIndex;   //1.所属年份
  fndP2_YEAR2.ItemIndex:=fndP1_YEAR2.ItemIndex;
  fndP2_SHOP_TYPE.ItemIndex:=fndP1_SHOP_TYPE.ItemIndex;  //2.门店群组分类
  Copy_ParamsValue(fndP1_SHOP_VALUE,fndP2_SHOP_VALUE);   //  门店群组值
  Copy_ParamsValue(fndP1_KPI_ID,fndP2_KPI_ID);           //3.考核指标
  Copy_ParamsValue(fndP1_GUIDE_USER,fndP2_GUIDE_USER);   //4.客户
  fndP2_DEPT_ID.KeyValue:=trim(adoReport1.FieldByName('DEPT_ID').AsString); //5.部门名称
  fndP2_DEPT_ID.Text:=trim(adoReport1.FieldByName('DEPT_NAME').AsString);
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmManKpiReport.DBGridEh2DblClick(Sender: TObject);
begin
  if adoReport2.IsEmpty then Exit;
  fndP3_YEAR1.ItemIndex:=fndP2_YEAR1.ItemIndex;    //1.所属年份
  fndP3_YEAR2.ItemIndex:=fndP2_YEAR2.ItemIndex;
  fndP3_SHOP_TYPE.ItemIndex:=fndP2_SHOP_TYPE.ItemIndex; //2.门店群组分类
  Copy_ParamsValue(fndP2_SHOP_VALUE,fndP3_SHOP_VALUE);  //  门店群组值
  Copy_ParamsValue(fndP2_GUIDE_USER,fndP3_GUIDE_USER);  //3.客户
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID);        //4.部门
  fndP3_KPI_ID.KeyValue:=trim(adoReport2.FieldByName('KPI_ID').AsString);  //5.考核指标
  fndP3_KPI_ID.Text:=trim(adoReport2.FieldByName('KPI_NAME').AsString);
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmManKpiReport.SetRzPageActivePage(IsGroupReport: Boolean);
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

procedure TfrmManKpiReport.DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

function TfrmManKpiReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;   

procedure TfrmManKpiReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
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
