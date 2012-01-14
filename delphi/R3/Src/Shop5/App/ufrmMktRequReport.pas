unit ufrmMktRequReport;

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
  TfrmMktRequReport = class(TframeBaseReport)
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
    RzLabel6: TRzLabel;
    Label17: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label18: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    fndP1_CUST_VALUE: TzrComboBoxList;
    Label44: TLabel;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Label3: TLabel;
    Label4: TLabel;
    fndP2_CUST_TYPE: TcxComboBox;
    fndP2_KPI_ID: TzrComboBoxList;
    fndP2_CUST_VALUE: TzrComboBoxList;
    Label5: TLabel;
    Label6: TLabel;
    fndP2_CLIENT_ID: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    Label8: TLabel;
    Label10: TLabel;
    fndP3_CUST_TYPE: TcxComboBox;
    fndP3_KPI_ID: TzrComboBoxList;
    fndP3_CUST_VALUE: TzrComboBoxList;
    Label13: TLabel;
    Label14: TLabel;
    fndP3_CLIENT_ID: TzrComboBoxList;
    fndP3_DEPT_ID: TzrComboBoxList;
    Label9: TLabel;
    Label11: TLabel;
    fndP4_CUST_TYPE: TcxComboBox;
    fndP4_KPI_ID: TzrComboBoxList;
    fndP4_CUST_VALUE: TzrComboBoxList;
    Label12: TLabel;
    Label15: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    Label16: TLabel;
    Label19: TLabel;
    fndP5_CUST_TYPE: TcxComboBox;
    fndP5_KPI_ID: TzrComboBoxList;
    fndP5_CUST_VALUE: TzrComboBoxList;
    Label20: TLabel;
    Label21: TLabel;
    fndP5_CLIENT_ID: TzrComboBoxList;
    fndP5_DEPT_ID: TzrComboBoxList;
    Label22: TLabel;
    fndP5_GUIDE_USER: TzrComboBoxList;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    RzLabel1: TRzLabel;
    RzLabel8: TRzLabel;
    P4_D2: TcxDateEdit;
    RzLabel4: TRzLabel;
    P4_D1: TcxDateEdit;
    RzLabel5: TRzLabel;
    P5_D1: TcxDateEdit;
    P5_D2: TcxDateEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    P5_DateControl: TfrmDateControl;
    Label23: TLabel;
    fndP1_REQU_TYPE: TcxComboBox;
    Label24: TLabel;
    fndP2_REQU_TYPE: TcxComboBox;
    Label25: TLabel;
    fndP3_REQU_TYPE: TcxComboBox;
    Label26: TLabel;
    fndP4_REQU_TYPE: TcxComboBox;
    Label28: TLabel;
    fndP5_REQU_TYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
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
    AObj: TRecord_;
    vBegDate,vEndDate: string;
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
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

procedure TfrmMktRequReport.FormCreate(Sender: TObject);
begin
  //必须放在继承之前取数
  DoCreateKPIDataSet('1');
  inherited;
  //初始化年度下拉
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_DateControl.StartDateControl:=P1_D1;
  P1_DateControl.EndDateControl:=P1_D2;

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_DateControl.StartDateControl:=P2_D1;
  P2_DateControl.EndDateControl:=P2_D2;

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_DateControl.StartDateControl:=P3_D1;
  P3_DateControl.EndDateControl:=P3_D2;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P4_DateControl.StartDateControl:=P4_D1;
  P4_DateControl.EndDateControl:=P4_D2;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P5_DateControl.StartDateControl:=P5_D1;
  P5_DateControl.EndDateControl:=P5_D2;

  fndP1_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP2_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP3_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP4_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP5_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');

  //初始化费用类型:全部，
  AddCBxItemsList(fndP1_REQU_TYPE,'REQU_TYPE',true);
  AddCBxItemsList(fndP2_REQU_TYPE,'REQU_TYPE',true);
  AddCBxItemsList(fndP3_REQU_TYPE,'REQU_TYPE',true);
  AddCBxItemsList(fndP4_REQU_TYPE,'REQU_TYPE',true);
  AddCBxItemsList(fndP5_REQU_TYPE,'REQU_TYPE',true);
  if fndP1_REQU_TYPE.Properties.Items.Count>0 then fndP1_REQU_TYPE.ItemIndex:=0;
  if fndP2_REQU_TYPE.Properties.Items.Count>0 then fndP2_REQU_TYPE.ItemIndex:=0;
  if fndP3_REQU_TYPE.Properties.Items.Count>0 then fndP3_REQU_TYPE.ItemIndex:=0;
  if fndP4_REQU_TYPE.Properties.Items.Count>0 then fndP4_REQU_TYPE.ItemIndex:=0;
  if fndP5_REQU_TYPE.Properties.Items.Count>0 then fndP5_REQU_TYPE.ItemIndex:=0;

  TDbGridEhSort.InitForm(self,false);
  SetRzPageActivePage; //设置PzPage.Activepage

  RefreshColumn;
 
  //2011.09.21 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.JT_MNY','DBGridEh1.REQU_MNY','DBGridEh1.NEW_REQU_MNY','DBGridEh1.ORG_REQU_MNY','DBGridEh1.JY_MNY',
                              'DBGridEh2.JT_MNY','DBGridEh2.REQU_MNY','DBGridEh2.NEW_REQU_MNY','DBGridEh2.ORG_REQU_MNY','DBGridEh2.JY_MNY',
                              'DBGridEh3.JT_MNY','DBGridEh3.REQU_MNY','DBGridEh3.NEW_REQU_MNY','DBGridEh3.ORG_REQU_MNY','DBGridEh3.JY_MNY',
                              'DBGridEh4.JT_MNY','DBGridEh4.REQU_MNY','DBGridEh4.NEW_REQU_MNY','DBGridEh4.ORG_REQU_MNY','DBGridEh4.JY_MNY',
                              'DBGridEh5.JT_MNY']);

end;

function TfrmMktRequReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('申领的结束日期不能小于开始日期...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //日期
  vBegDate:=FormatDatetime('YYYYMMDD',P1_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P1_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';

  //部门条件:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
  //考核指标:
  if fndP1_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP1_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP1_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';
  //费用类型:
  if fndP1_REQU_TYPE.ItemIndex>0 then
  begin
    AObj:=TRecord_(fndP1_REQU_TYPE.Properties.Items.Objects[fndP1_REQU_TYPE.ItemIndex]);
    if (AObj<>nil) and (AObj.FieldByName('CODE_ID').AsString<>'') then
      strWhere:=strWhere+' and A.REQU_TYPE='''+AObj.FieldByName('CODE_ID').AsString+''' ';
  end;

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
      ' A.DEPT_ID as DEPT_ID,'+
      ' B.REQU_MNY as REQU_MNY,'+
      ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
      ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
      ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
      ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+strWhere+' ';
  end else
  begin
    strSql:=
      'select '+
      ' A.DEPT_ID as DEPT_ID,'+
      ' B.REQU_MNY as REQU_MNY,'+
      ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
      ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
      ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
      ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';
  end;
  
  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.DEPT_ID as DEPT_ID,'+
     ' DEPT.DEPT_NAME as DEPT_NAME,'+
     ' sum(JT_MNY) as JT_MNY,'+
     ' sum(REQU_MNY) as REQU_MNY,'+
     ' sum(ORG_REQU_MNY) as ORG_REQU_MNY,'+
     ' sum(NEW_REQU_MNY) as NEW_REQU_MNY, '+
     ' sum(JT_MNY-REQU_MNY) as JY_MNY '+
     ' from ('+strSql+')K '+
     ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+')DEPT '+
     ' on K.DEPT_ID=DEPT.DEPT_ID '+
     ' Group by K.DEPT_ID '
     );
end;

function TfrmMktRequReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('申领的结束日期不能小于开始日期...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //申领日期
  vBegDate:=FormatDatetime('YYYYMMDD',P2_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P2_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
   //部门条件:
  if trim(fndP2_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP2_DEPT_ID.AsString+''' ';
  //考核指标:
  if fndP2_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP2_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP2_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP2_CLIENT_ID.AsString+''' ';
  //费用类型:
  if fndP2_REQU_TYPE.ItemIndex>0 then
  begin
    AObj:=TRecord_(fndP2_REQU_TYPE.Properties.Items.Objects[fndP2_REQU_TYPE.ItemIndex]);
    if (AObj<>nil) and (AObj.FieldByName('CODE_ID').AsString<>'') then
      strWhere:=strWhere+' and A.REQU_TYPE='''+AObj.FieldByName('CODE_ID').AsString+''' ';
  end;

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
    ' D.REGION_ID as REGION_ID,'+
    ' B.REQU_MNY as REQU_MNY,'+
    ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
    ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
    ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
    ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.REGION_ID as REGION_ID,'+
     ' isnull(Area.CODE_NAME,''无'') as CODE_NAME,'+
     ' sum(JT_MNY) as JT_MNY,'+
     ' sum(REQU_MNY) as REQU_MNY,'+
     ' sum(ORG_REQU_MNY) as ORG_REQU_MNY,'+
     ' sum(NEW_REQU_MNY) as NEW_REQU_MNY,'+
     ' sum(JT_MNY-REQU_MNY) as JY_MNY '+     
     ' from ('+strSql+')K '+
     ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0)Area '+
     ' on K.REGION_ID=Area.CODE_ID '+
     ' Group by K.REGION_ID '
     );

     
end;

function TfrmMktRequReport.GetRowType: integer;
begin
  result :=0;
end;

procedure TfrmMktRequReport.actFindExecute(Sender: TObject);
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

procedure TfrmMktRequReport.fndP1_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  fndP1_KPI_ID.KeyValue := null;
  fndP1_KPI_ID.Text := '';
end;

function TfrmMktRequReport.GetKPISQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('申领的结束日期不能小于开始日期...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //申领日期
  vBegDate:=FormatDatetime('YYYYMMDD',P3_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P3_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';

   //部门条件:
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP3_DEPT_ID.AsString+''' ';
  //考核指标:
  if fndP3_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP3_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP3_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP3_CLIENT_ID.AsString+''' ';
  //费用类型:
  if fndP3_REQU_TYPE.ItemIndex>0 then
  begin
    AObj:=TRecord_(fndP3_REQU_TYPE.Properties.Items.Objects[fndP3_REQU_TYPE.ItemIndex]);
    if (AObj<>nil) and (AObj.FieldByName('CODE_ID').AsString<>'') then
      strWhere:=strWhere+' and A.REQU_TYPE='''+AObj.FieldByName('CODE_ID').AsString+''' ';
  end;

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
      ' A.TENANT_ID as TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' B.REQU_MNY as REQU_MNY,'+
      ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
      ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
      ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
      ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+strWhere+' ';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' C.KPI_ID as KPI_ID,'+
      ' B.REQU_MNY as REQU_MNY,'+
      ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
      ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
      ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
      ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where  A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';
  end;

  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.KPI_ID as KPI_ID,'+
     ' MKT.KPI_NAME as KPI_NAME,'+
     ' sum(JT_MNY) as JT_MNY,'+
     ' sum(REQU_MNY) as REQU_MNY,'+
     ' sum(ORG_REQU_MNY) as ORG_REQU_MNY,'+
     ' sum(NEW_REQU_MNY) as NEW_REQU_MNY,'+
     ' sum(JT_MNY-REQU_MNY) as JY_MNY '+     
     ' from ('+strSql+')K left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' Group by K.KPI_ID '
     );
end;

function TfrmMktRequReport.GetCLIENTSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('申领的结束日期不能小于开始日期...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //申领日期
  vBegDate:=FormatDatetime('YYYYMMDD',P4_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P4_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
  //部门条件:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP4_DEPT_ID.AsString+''' ';
  //考核指标:
  if fndP4_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP4_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP4_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP4_CLIENT_ID.AsString+''' ';
  //费用类型:
  if fndP4_REQU_TYPE.ItemIndex>0 then
  begin
    AObj:=TRecord_(fndP4_REQU_TYPE.Properties.Items.Objects[fndP4_REQU_TYPE.ItemIndex]);
    if (AObj<>nil) and (AObj.FieldByName('CODE_ID').AsString<>'') then
      strWhere:=strWhere+' and A.REQU_TYPE='''+AObj.FieldByName('CODE_ID').AsString+''' ';
  end;

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
    ' A.CLIENT_ID as CLIENT_ID,'+
    ' D.CLIENT_NAME as CLIENT_NAME,'+
    ' B.REQU_MNY as REQU_MNY,'+
    ' (case when A.REQU_DATE<'+vBegDate+' and A.REQU_DATE>'+vEndDate+' then B.REQU_MNY else 0 end) as ORG_REQU_MNY,'+
    ' (case when A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' then B.REQU_MNY else 0 end) as NEW_REQU_MNY,'+
    ' C.KPI_MNY as JT_MNY '+     //考核结果(元)[计提金额]
    ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.CLIENT_ID as CLIENT_ID,'+
     ' K.CLIENT_NAME as CLIENT_NAME,'+
     ' sum(JT_MNY) as JT_MNY,'+
     ' sum(REQU_MNY) as REQU_MNY,'+
     ' sum(ORG_REQU_MNY) as ORG_REQU_MNY,'+
     ' sum(NEW_REQU_MNY) as NEW_REQU_MNY,'+
     ' sum(JT_MNY-REQU_MNY) as JY_MNY '+     
     ' from ('+strSql+')K '+
     ' Group by K.CLIENT_ID,K.CLIENT_NAME '
     );
end;

function TfrmMktRequReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('申领的结束日期不能小于开始日期...');

  //过滤企业ID和数据权限:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //申领日期
  vBegDate:=FormatDatetime('YYYYMMDD',P4_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P4_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
  //部门条件:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP5_DEPT_ID.AsString+''' ';
  //考核指标:
  if fndP5_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP5_KPI_ID.AsString+''' ';
  //客户名称:
  if fndP5_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP5_CLIENT_ID.AsString+''' ';
  //费用类型:
  if fndP5_REQU_TYPE.ItemIndex>0 then
  begin
    AObj:=TRecord_(fndP5_REQU_TYPE.Properties.Items.Objects[fndP5_REQU_TYPE.ItemIndex]);
    if (AObj<>nil) and (AObj.FieldByName('CODE_ID').AsString<>'') then
      strWhere:=strWhere+' and A.REQU_TYPE='''+AObj.FieldByName('CODE_ID').AsString+''' ';
  end;

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
    ' A.TENANT_ID as TENANT_ID,'+
    ' A.GLIDE_NO as GLIDE_NO,'+        //申领单号
    ' A.REQU_DATE as REQU_DATE,'+       //申领日期
    ' D.CLIENT_NAME as CLIENT_NAME,'+  //客户名称
    ' A.DEPT_ID as DEPT_ID,'+          //部门ID
    ' C.KPI_ID as KPI_ID,'+            //考核ID
    ' A.REQU_USER as REQU_USER,'+      //填报人ID
    ' B.KPI_YEAR as REQU_YEAR,'+       //申领年份
    ' A.REQU_TYPE as REQU_TYPE,'+      //申领类型
    ' A.REQU_MNY as REQU_MNY,'+        //申领金额
    ' B.REMARK as REMARK,'+            //备注
    ' A.CREA_DATE as CREA_DATE,'+      //创建日期
    ' A.CREA_USER as CREA_USER,'+      //创建人
    ' A.CHK_DATE as CHK_DATE,'+        //审核日期
    ' A.CHK_USER as CHK_USER '+        //审核人
    ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID  '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    ' MKT.KPI_NAME as KPI_NAME,'+
    ' DEPT.DEPT_NAME as DEPT_NAME,'+
    ' D.USER_NAME as REQU_USER_TEXT,'+
    ' E.USER_NAME as CREA_USER_TEXT,'+
    ' F.USER_NAME as CHK_USER_TEXT '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' left outer join CA_DEPT_INFO DEPT on K.TENANT_ID=DEPT.TENANT_ID and K.DEPT_ID=DEPT.DEPT_ID '+
    ' left outer join VIW_USERS D on K.TENANT_ID=D.TENANT_ID and K.REQU_USER=D.USER_ID '+
    ' left outer join VIW_USERS E on K.TENANT_ID=E.TENANT_ID and K.CREA_USER=E.USER_ID '+
    ' left outer join VIW_USERS F on K.TENANT_ID=F.TENANT_ID and K.CHK_USER=F.USER_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmMktRequReport.DBGridEh4DblClick(Sender: TObject);
begin
  if adoReport4.IsEmpty then Exit;
  fndP5_CUST_TYPE.ItemIndex:=fndP4_CUST_TYPE.ItemIndex;  //客户群组类型
  fndP5_REQU_TYPE.ItemIndex:=fndP4_REQU_TYPE.ItemIndex; //费用类型
  Copy_ParamsValue(fndP4_CUST_VALUE,fndP5_CUST_VALUE);  //客户群组
  Copy_ParamsValue(fndP4_KPI_ID,fndP5_KPI_ID);  //考核指标
  fndP5_CLIENT_ID.KeyValue:=adoReport4.fieldbyName('CLIENT_ID').AsString;
  fndP5_CLIENT_ID.Text:=adoReport4.fieldbyName('CLIENT_NAME').AsString;
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmMktRequReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmMktRequReport.PrintBefore;
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

function TfrmMktRequReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
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


procedure TfrmMktRequReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmMktRequReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmMktRequReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmMktRequReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;

  fndP2_CUST_TYPE.ItemIndex:=fndP1_CUST_TYPE.ItemIndex;  //客户群组类型
  Copy_ParamsValue(fndP1_CUST_VALUE,fndP2_CUST_VALUE);  //客户群组
  Copy_ParamsValue(fndP1_KPI_ID,fndP2_KPI_ID);  //考核指标        
  Copy_ParamsValue(fndP1_CLIENT_ID,fndP2_CLIENT_ID);  //客户
  fndP2_REQU_TYPE.ItemIndex:=fndP1_REQU_TYPE.ItemIndex; //费用类型
  fndP2_DEPT_ID.KeyValue:=adoReport1.fieldbyName('DEPT_ID').AsString;
  fndP2_DEPT_ID.Text:=adoReport1.fieldbyName('DEPT_NAME').AsString;
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmMktRequReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  Copy_ParamsValue(fndP2_KPI_ID,fndP3_KPI_ID);  //考核指标
  Copy_ParamsValue(fndP2_CLIENT_ID,fndP3_CLIENT_ID);  //客户
  fndP3_REQU_TYPE.ItemIndex:=fndP2_REQU_TYPE.ItemIndex; //费用类型
  fndP3_CUST_TYPE.ItemIndex:=0;
  fndP3_CUST_VALUE.KeyValue:=adoReport2.fieldbyName('REGION_ID').AsString;
  fndP3_CUST_VALUE.Text:=adoReport2.fieldbyName('CODE_NAME').AsString;
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmMktRequReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  fndP4_CUST_TYPE.ItemIndex:=fndP3_CUST_TYPE.ItemIndex;  //客户群组类型
  fndP4_REQU_TYPE.ItemIndex:=fndP3_REQU_TYPE.ItemIndex; //费用类型
  Copy_ParamsValue(fndP3_CUST_VALUE,fndP4_CUST_VALUE);  //客户群组
  Copy_ParamsValue(fndP3_CLIENT_ID,fndP4_CLIENT_ID);  //客户
  fndP4_KPI_ID.KeyValue:=adoReport3.fieldbyName('KPI_ID').AsString;
  fndP4_KPI_ID.Text:=adoReport3.fieldbyName('KPI_NAME').AsString;
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmMktRequReport.SetRzPageActivePage(IsGroupReport: Boolean);
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

procedure TfrmMktRequReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'KPI_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmMktRequReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GLIDE_NO' then Text := '合计:'+Text+'笔';
end;

function TfrmMktRequReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;


procedure TfrmMktRequReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
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
