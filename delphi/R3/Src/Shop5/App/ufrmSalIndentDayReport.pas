unit ufrmSalIndentDayReport;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup,
  ufrmDateControl, Buttons;

type
  TfrmSalIndentDayReport = class(TframeBaseReport)
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    dsadoReport4: TDataSource;
    dsadoReport5: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    adoReport5: TZQuery;
    TabSheet6: TRzTabSheet;
    RzPanel16: TRzPanel;
    Panel7: TPanel;
    RzPanel17: TRzPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    P6_D1: TcxDateEdit;
    BtnDetail: TRzBitBtn;
    P6_D2: TcxDateEdit;
    fndP6_TYPE_ID: TcxComboBox;
    fndP6_STAT_ID: TzrComboBoxList;
    fndP6_SORT_ID: TcxButtonEdit;
    fndP6_SHOP_VALUE: TzrComboBoxList;
    fndP6_SHOP_TYPE: TcxComboBox;
    fndP6_SHOP_ID: TzrComboBoxList;
    RzPanel18: TRzPanel;
    DBGridEh6: TDBGridEh;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP4_REPORT_FLAG: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    RzPanel12: TRzPanel;
    DBGridEh4: TDBGridEh;
    RzPanel9: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    BtnSort: TRzBitBtn;
    fndP3_TYPE_ID: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    fndP3_STAT_ID: TzrComboBoxList;
    fndP3_SORT_ID: TcxButtonEdit;
    fndP3_SHOP_TYPE: TcxComboBox;
    RzPanel10: TRzPanel;
    DBGridEh3: TDBGridEh;
    TabSheet2: TRzTabSheet;
    adoReport6: TZQuery;
    dsadoReport6: TDataSource;
    Label31: TLabel;
    fndP1_GODS_ID: TzrComboBoxList;
    Label34: TLabel;
    fndP3_DEPT_ID: TzrComboBoxList;
    Label35: TLabel;
    fndP4_DEPT_ID: TzrComboBoxList;
    Label37: TLabel;
    fndP6_DEPT_ID: TzrComboBoxList;
    Label30: TLabel;
    fndP3_GODS_ID: TzrComboBoxList;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label23: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    fndP2_GODS_ID: TzrComboBoxList;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    Label36: TLabel;
    P5_D1: TcxDateEdit;
    P5_D2: TcxDateEdit;
    BtnSaleSum: TRzBitBtn;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_UNIT_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_DEPT_ID: TzrComboBoxList;
    RzPanel21: TRzPanel;
    DBGridEh5: TDBGridEh;
    Label38: TLabel;
    fndP5_RPTTYPE: TcxComboBox;
    Label39: TLabel;
    fndP1_SALES_STYLE: TcxComboBox;
    Label40: TLabel;
    fndP2_SALES_STYLE: TcxComboBox;
    Label41: TLabel;
    fndP3_SALES_STYLE: TcxComboBox;
    Label42: TLabel;
    fndP4_SALES_STYLE: TcxComboBox;
    Label43: TLabel;
    fndP5_SALES_STYLE: TcxComboBox;
    Label44: TLabel;
    fndP6_SALES_STYLE: TcxComboBox;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    P5_DateControl: TfrmDateControl;
    P6_DateControl: TfrmDateControl;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP2_TYPE_IDPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure DBGridEh5DblClick(Sender: TObject);
    procedure fndP4_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP3_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP6_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP3_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP6_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure DBGridEh6GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
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
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh5DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh5TitleClick(Column: TColumnEh);
  private
    vBegDate: integer;  //查询开始日期
    vEndDate: integer;  //查询结束日期
    RckMaxDate: integer;
    GodsID: string;   //商品编码ID;
    SortName: string; //临时变量
    sid1,sid2,sid3,sid5,sid6:string;
    srid1,srid2,srid3,srid5,srid6:string;
    procedure SetUnitIDList(DBGrid: TDBGridEh; ColName: string); //设置ColList
    //按部门销售汇总表
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;  //2222
    //按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;   //3333
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;   //4444
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;   //5555
    //按商品销售流水表
    function GetGlideSQL(chk:boolean=true): string;  //6666
    function GetUnitIDIdx: integer;
    function GetGodsSortIdx: string;  //
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    //设置Page分页显示:（IsGroupReport是否分组[区域、门店]）
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function GetDataRight: string;
  public
    procedure SingleReportParams(ParameStr: string='');override; //简单报表调用参数
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property UnitIDIdx: integer read GetUnitIDIdx; //当前统计计量方式
    property GodsSortIdx: string read GetGodsSortIdx; //统计类型
    property DataRight: string read GetDataRight; //返回查看数据权限
  end;

const
  ArySumField: Array[0..4] of string=('INDE_AMT','INDE_TTL','INDE_TAX','INDE_MNY','FNSH_AMT');

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmSalIndentDayReport.FormCreate(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_DateControl.StartDateControl := P1_D1;
  P1_DateControl.EndDateControl := P1_D2;

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_DateControl.StartDateControl := P2_D1;
  P2_DateControl.EndDateControl := P2_D2;

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_DateControl.StartDateControl := P3_D1;
  P3_DateControl.EndDateControl := P3_D2;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P4_DateControl.StartDateControl := P4_D1;
  P4_DateControl.EndDateControl := P4_D2;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P5_DateControl.StartDateControl := P5_D1;
  P5_DateControl.EndDateControl := P5_D2;

  P6_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P6_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));  
  P6_DateControl.StartDateControl := P6_D1;
  P6_DateControl.EndDateControl := P6_D2;
  SetRzPageActivePage; //设置PzPage.Activepage

  RefreshColumn;

  //2011.12.22 重开启[若非总店默认当前门店]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP4_SHOP_ID.Properties.ReadOnly := False;
    fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP4_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP4_SHOP_ID.Style);
    //fndP4_SHOP_ID.Properties.ReadOnly := True;

    fndP5_SHOP_ID.Properties.ReadOnly := False;
    fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP5_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP5_SHOP_ID.Style);
    //fndP5_SHOP_ID.Properties.ReadOnly := True;

    fndP6_SHOP_ID.Properties.ReadOnly := False;
    fndP6_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP6_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP6_SHOP_ID.Style);
    //fndP6_SHOP_ID.Properties.ReadOnly := True;
  end; 

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label21.Caption := '仓库名称';

      Label28.Caption := '仓库群组';
      Label17.Caption := '仓库名称';

      Label23.Caption := '仓库群组';

      SetCol:=self.FindColumn(DBGridEh6,'SHOP_NAME');
      if setCol<>nil then
        SetCol.Title.Caption:='仓库名称';
    end;

  //增加单位显示：
  SetUnitIDList(DBGridEh5,'UNIT_ID');
  SetUnitIDList(DBGridEh6,'UNIT_ID');
  
  //2011.09.21 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.INDE_TTL','DBGridEh1.INDE_TAX','DBGridEh1.INDE_MNY',
                              'DBGridEh2.INDE_TTL','DBGridEh2.INDE_TAX','DBGridEh2.INDE_MNY',
                              'DBGridEh3.INDE_TTL','DBGridEh3.INDE_TAX','DBGridEh3.INDE_MNY',
                              'DBGridEh4.INDE_TTL','DBGridEh4.INDE_TAX','DBGridEh4.INDE_MNY',
                              'DBGridEh5.INDE_TTL','DBGridEh5.INDE_TAX','DBGridEh5.INDE_MNY',
                              'DBGridEh6.AMONEY','DBGridEh6.NOTAX_MONEY','DBGridEh6.TAX_MONEY','DBGridEh6.AGIO_MONEY','DBGridEh7.COST_MONEY','DBGridEh6.PROFIT_MONEY','DBGridEh6.AVG_PROFIT']);

  //2012.08.15创建尺码、颜色
  if ShopGlobal.GetVersionFlag=1 then
    CreateGridColForFIG(DBGridEh6,7);
end;

function TfrmSalIndentDayReport.GetDeptSQL(chk: boolean): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('订货日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('订货日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //订货方式:    
  if fndP1_SALES_STYLE.ItemIndex>0 then
    StrCnd:=' and SALES_STYLE='''+TRecord_(fndP1_SALES_STYLE.Properties.Items.Objects[fndP1_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //日期条件
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //结束日期
  if vBegDate = vEndDate then
    StrCnd:=StrCnd+' and INDE_DATE='+InttoStr(vBegDate)+' '
  else
    StrCnd:=StrCnd+' and INDE_DATE>='+InttoStr(vBegDate)+' and INDE_DATE<='+InttoStr(vEndDate)+' ';

  //门店所属行政区域|门店类型:
  if fndP1_SHOP_VALUE.AsString<>'' then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
     0:
      begin
        if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
          strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
        else
          strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
     1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;

  //商品分类:
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 商品名称:
  if trim(fndP1_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+fndP1_GODS_ID.AsString+''' ';
    
  //取数SQL:
  SQLData:=
     '(select M.TENANT_ID,M.SHOP_ID,M.DEPT_ID,INDE_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as INDE_AMT,(CALC_MONEY+AGIO_MONEY) as INDE_RTL,FNSH_AMOUNT as FNSH_AMT '+
     ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as INDE_TAX '+
     ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as INDE_MNY '+
     ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
     ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.DEPT_ID '+
    ',sum(INDE_AMT*1.00/'+UnitCalc+') as INDE_AMT '+
    ',case when sum(INDE_AMT)<>0 then cast(sum(INDE_MNY)+sum(INDE_TAX) as decimal(18,3))*1.00/cast(sum(INDE_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as INDE_PRC '+
    ',sum(INDE_MNY)+sum(INDE_TAX) as INDE_TTL '+ //价税合计
    ',sum(INDE_MNY) as INDE_MNY '+  //未税金额
    ',sum(INDE_TAX) as INDE_TAX '+  //税额
    ',sum(FNSH_AMT) as FNSH_AMT '+  //暂时没使用
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.DEPT_ID';

  Result := ParseSQL(Factor.iDbType,
    'select j.* '+
    ',isnull(r.DEPT_NAME,''无'') as DEPT_NAME from ('+strSql+') j '+
    ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+') r on j.DEPT_ID=r.DEPT_ID order by j.DEPT_ID'
    );
end;

function TfrmSalIndentDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //订货方式:
  if fndP2_SALES_STYLE.ItemIndex>0 then
    StrCnd:=' and SALES_STYLE='''+TRecord_(fndP2_SALES_STYLE.Properties.Items.Objects[fndP2_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //结束日期
  if vBegDate = vEndDate then
    StrCnd:=StrCnd+' and INDE_DATE='+InttoStr(vBegDate)+' '
  else
    StrCnd:=StrCnd+' and INDE_DATE>='+InttoStr(vBegDate)+' and INDE_DATE<='+InttoStr(vEndDate)+' ';

  //门店所属行政区域|门店类型:
  if (fndP2_SHOP_VALUE.AsString<>'') then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;

  //商品分类:
  if (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid2+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 商品名称:
  if trim(fndP2_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+fndP2_GODS_ID.AsString+''' ';
  //2011.05.11 Add 部门名称: [2012.01.16修改:可以按树上下级查询]
  if trim(fndP2_DEPT_ID.AsString)<>'' then   
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP2_DEPT_ID.AsString);

  //取数SQL:
  SQLData:=
     '(select M.TENANT_ID,M.SHOP_ID,M.DEPT_ID,INDE_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as INDE_AMT,(CALC_MONEY+AGIO_MONEY) as INDE_RTL,FNSH_AMOUNT as FNSH_AMT '+
     ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as INDE_TAX '+
     ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as INDE_MNY '+
     ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
     ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(INDE_AMT*1.00/'+UnitCalc+') as INDE_AMT '+
    ',case when sum(INDE_AMT)<>0 then cast(sum(INDE_MNY)+sum(INDE_TAX) as decimal(18,3))*1.00/cast(sum(INDE_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as INDE_PRC '+
    ',sum(INDE_MNY)+sum(INDE_TAX) as INDE_TTL '+ //价税合计
    ',sum(INDE_MNY) as INDE_MNY '+  //未税金额
    ',sum(INDE_TAX) as INDE_TAX '+  //税额
    ',sum(FNSH_AMT) as FNSH_AMT '+  //已发货数量
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID'
    );
end;

function TfrmSalIndentDayReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmSalIndentDayReport.actFindExecute(Sender: TObject);
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
    2: begin //按门店汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetShopSQL;

        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按分类汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetSortSQL;

        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
        Do_REPORT_FLAGFooterSum(fndP4_REPORT_FLAG, adoReport4, ArySumField);
      end;
    4: begin //按商品汇总表
        if adoReport5.Active then adoReport5.Close;
        adoReport5.SortedFields:='';
        strSql := GetGodsSQL;

        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
        dsadoReport5.DataSet:=nil;
        DoGodsGroupBySort(adoReport5,GodsSortIdx,'SORT_ID','GODS_NAME','ORDER_ID',
                          ['INDE_AMT','INDE_TTL','INDE_TAX','INDE_MNY','FNSH_AMT'],
                          ['INDE_PRC=INDE_TTL/INDE_AMT']);
        dsadoReport5.DataSet:=adoReport5;
      end;
    5: begin //按商品流水帐
        if adoReport6.Active then adoReport6.Close;
        if Sender<>nil then self.GodsID:='';
        strSql := GetGlideSQL;

        if strSql='' then Exit;
        adoReport6.SQL.Text := strSql;
        Factor.Open(adoReport6);
      end;
  end;
end;

procedure TfrmSalIndentDayReport.fndP1_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  fndP1_STAT_ID.KeyValue := null;
  fndP1_STAT_ID.Text := '';
end;

function TfrmSalIndentDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,ShopCnd,GoodTab,SQLData: string;
begin
  StrCnd:='';
  ShopCnd:='';
  if P3_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //订货方式:
  if fndP3_SALES_STYLE.ItemIndex>0 then
    StrCnd:=' and SALES_STYLE='''+TRecord_(fndP3_SALES_STYLE.Properties.Items.Objects[fndP3_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //结束日期
  if vBegDate = vEndDate then
    StrCnd:=StrCnd+' and INDE_DATE='+InttoStr(vBegDate)+' '
  else
    StrCnd:=StrCnd+' and INDE_DATE>='+InttoStr(vBegDate)+' and INDE_DATE<='+InttoStr(vEndDate)+' ';

  //门店所属行政区域|门店类型:
  if (fndP3_SHOP_VALUE.AsString<>'') then
  begin
    case fndP3_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP3_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP3_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP3_STAT_ID.AsString <> '') and (fndP3_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP3_TYPE_ID)+'='''+fndP3_STAT_ID.AsString+''' ';
  end;

  //商品分类:
  if (trim(fndP3_SORT_ID.Text)<>'') and (trim(srid3)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid3+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid3+''' ';
    end;
    if trim(sid3)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid3+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 部门名称: [2012.01.16修改:可以按树上下级查询]
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP3_DEPT_ID.AsString);

  //2011.05.11 Add 商品名称:
  if trim(fndP3_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+fndP3_GODS_ID.AsString+''' ';

  //取数SQL:
  SQLData:=
     '(select M.TENANT_ID,M.SHOP_ID,M.DEPT_ID,INDE_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as INDE_AMT,(CALC_MONEY+AGIO_MONEY) as INDE_RTL,FNSH_AMOUNT as FNSH_AMT '+
     ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as INDE_TAX '+
     ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as INDE_MNY '+
     ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
     ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(INDE_AMT*1.00/'+UnitCalc+') as INDE_AMT '+
    ',case when sum(INDE_AMT)<>0 then cast(sum(INDE_MNY)+sum(INDE_TAX) as decimal(18,3))*1.00/cast(sum(INDE_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as INDE_PRC '+
    ',sum(INDE_MNY)+sum(INDE_TAX) as INDE_TTL '+ //价税合计
    ',sum(INDE_MNY) as INDE_MNY '+  //未税金额
    ',sum(INDE_TAX) as INDE_TAX '+  //税额
    ',sum(FNSH_AMT) as FNSH_AMT '+  //已发货数量
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
    );
end;

procedure TfrmSalIndentDayReport.fndP2_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  fndP2_STAT_ID.KeyValue := null;
  fndP2_STAT_ID.Text := '';  
end;

function TfrmSalIndentDayReport.GetSortSQL(chk:boolean=true): string;
var
  GodsStateIdx: integer; //表表统计指标Idx
  UnitCalc, JoinCnd: string;  //单位计算关系
  strSql,strCnd,strWhere,lv,LvField,GoodTab,SQLData: string;
begin
  lv :='';
  LvField:='';
  StrCnd:='';
  if P4_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //商品指标:
  if fndP4_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('请选择报表类型...');
  GodsStateIdx:=TRecord_(fndP4_REPORT_FLAG.Properties.Items.Objects[fndP4_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+DataRight;
  //订货方式:
  if fndP4_SALES_STYLE.ItemIndex>0 then
    StrCnd:=' and SALES_STYLE='''+TRecord_(fndP4_SALES_STYLE.Properties.Items.Objects[fndP4_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //门店条件
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    StrCnd:=' and M.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;

  //查询日期条件:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //结束日期
  if vBegDate = vEndDate then
    StrCnd:=StrCnd+' and INDE_DATE='+InttoStr(vBegDate)+' '
  else
    StrCnd:=StrCnd+' and INDE_DATE>='+InttoStr(vBegDate)+' and INDE_DATE<='+InttoStr(vEndDate)+' ';

  //门店所属行政区域|门店类型:
  if (fndP4_SHOP_VALUE.AsString<>'') then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP4_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP4_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品分类:
  case GodsStateIdx of
   1:begin
       GoodTab:='VIW_GOODSPRICE_SORTEXT';
       lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
       LvField:=lv+' as LEVEL_ID';
     end;
   else
    GoodTab:='VIW_GOODSPRICE';
   end;

  //2011.05.11 Add 部门名称: [2012.01.16修改:可以按树上下级查询]
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);

  //取数SQL:
  SQLData:=
     '(select M.TENANT_ID,M.SHOP_ID,M.DEPT_ID,INDE_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as INDE_AMT,(CALC_MONEY+AGIO_MONEY) as INDE_RTL,FNSH_AMOUNT as FNSH_AMT '+
     ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as INDE_TAX '+
     ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as INDE_MNY '+
     ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
     ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+LvField+',C.RELATION_ID '+
    ',sum(INDE_AMT*1.00/'+UnitCalc+') as INDE_AMT '+  //销售数量
    ',sum(INDE_MNY)+sum(INDE_TAX) as INDE_TTL '+ //价税金额
    ',sum(INDE_MNY) as INDE_MNY '+   //未税金额
    ',sum(INDE_TAX) as INDE_TAX '+   //税额
    ',sum(INDE_RTL) as INDE_RTL '+   //暂时没使用
    ',sum(FNSH_AMT) as FNSH_AMT '+  //已发货数量
    ' from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lv+',C.RELATION_ID';

  case GodsStateIdx of
    1:begin
       case Factor.iDbType of
        4: JoinCnd:=' and j.LEVEL_ID=substr(r.LEVEL_ID,1,length(j.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(nvl(INDE_AMT,0)) as INDE_AMT '+
          ',case when sum(nvl(INDE_AMT,0))<>0 then cast(sum(nvl(INDE_TTL,0)) as decimal(18,3))*1.00/cast(sum(nvl(INDE_AMT,0)) as decimal(18,3)) else 0 end as INDE_PRC '+
          ',sum(nvl(INDE_TTL,0)) as INDE_TTL '+
          ',sum(nvl(INDE_MNY,0)) as INDE_MNY '+
          ',sum(nvl(INDE_TAX,0)) as INDE_TAX '+
          ',sum(nvl(FNSH_AMT,0)) as FNSH_AMT '+   //已发货数量
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID') +' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'') ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'      //' order by j.RELATION_ID,j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(INDE_AMT) as INDE_AMT '+
          ',case when sum(INDE_AMT)<>0 then cast(sum(INDE_TTL) as decimal(18,3))*1.00/cast(sum(INDE_AMT) as decimal(18,3)) else 0 end as INDE_PRC '+
          ',sum(INDE_TTL) as INDE_TTL '+
          ',sum(INDE_MNY) as INDE_MNY '+
          ',sum(INDE_TAX) as INDE_TAX '+
          ',sum(nvl(FNSH_AMT,0)) as FNSH_AMT '+   //已发货数量
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(INDE_AMT) as INDE_AMT '+
          ',case when sum(INDE_AMT)<>0 then cast(sum(INDE_TTL) as decimal(18,3))*1.00/cast(sum(INDE_AMT) as decimal(18,3)) else 0 end as INDE_PRC '+
          ',sum(INDE_TTL) as INDE_TTL '+
          ',sum(INDE_MNY) as INDE_MNY '+
          ',sum(INDE_TAX) as INDE_TAX '+
          ',sum(nvl(FNSH_AMT,0)) as FNSH_AMT '+   //已发货数量
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME '+
        ' from ('+strSql+') j '+
        ' left outer join ('+
        ' select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+InttoStr(GodsStateIdx)+' '+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+InttoStr(GodsStateIdx)+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmSalIndentDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc,SORT_ID: string;  //单位计算关系
  strSql,strCnd,strWhere,GoodTab,SQLData: string;
begin
  strCnd:='';
  if P5_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //订货方式:
  if fndP5_SALES_STYLE.ItemIndex>0 then
    strCnd:=' and SALES_STYLE='''+TRecord_(fndP5_SALES_STYLE.Properties.Items.Objects[fndP5_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //门店条件
  if (fndP5_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';
    StrCnd:=' and M.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';
  end;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P5_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P5_D2.Date));  //结束日期
  if vBegDate = vEndDate then
    StrCnd:=StrCnd+' and INDE_DATE='+InttoStr(vBegDate)+' '
  else
    StrCnd:=StrCnd+' and INDE_DATE>='+InttoStr(vBegDate)+' and INDE_DATE<='+InttoStr(vEndDate)+' ';

  //门店所属行政区域|门店类型:
  if trim(fndP5_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP5_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP5_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP5_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //2011.05.11 Add 部门名称: [2012.01.16修改:可以按树上下级查询]
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP5_DEPT_ID.AsString);

  //商品指标:
  if (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
  begin
     strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP5_TYPE_ID)+'='''+fndP5_STAT_ID.AsString+''' ';
  end;
  //商品分类:
  if (trim(fndP5_SORT_ID.Text)<>'')  and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //取数SQL:
  SQLData:=
    '(select M.TENANT_ID,M.SHOP_ID,M.DEPT_ID,INDE_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as INDE_AMT,(CALC_MONEY+AGIO_MONEY) as INDE_RTL,FNSH_AMOUNT as FNSH_AMT '+
    ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as INDE_TAX '+
    ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as INDE_MNY '+
    ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
    ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  //分组字段
  case StrToInt(GodsSortIdx) of
   0: SORT_ID:='C.RELATION_ID';
   else
      SORT_ID:='case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end';
      //SORT_ID:='isnull(C.SORT_ID'+GodsSortIdx+',''#'')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP5_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ','+SORT_ID+' as SORT_ID '+
    ',A.GODS_ID '+
    ',sum(INDE_AMT*1.00/'+UnitCalc+') as INDE_AMT '+    //销售数量
    ',case when sum(INDE_AMT)<>0 then cast(isnull(sum(INDE_MNY),0)+isnull(sum(INDE_TAX),0) as decimal(18,3))*1.00/cast(sum(INDE_AMT*1.00/'+UnitCalc+')as decimal(18,3)) else 0 end as INDE_PRC '+
    ',sum(INDE_MNY)+sum(INDE_TAX) as INDE_TTL '+  //价税合计
    ',sum(INDE_MNY) as INDE_MNY '+  //未税金额
    ',sum(INDE_TAX) as INDE_TAX '+  //税额
    ',sum(FNSH_AMT) as FNSH_AMT '+  //已发货数量
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,'+SORT_ID+',A.GODS_ID';

  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP5_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  case StrtoInt(GodsSortIdx) of
   0: //供应链
    begin
      strSql :=
        'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        '  on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE';
    end;
   else
    begin
      strSql :=
        'select j.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        '(select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
        ' on  j.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,j.GODS_CODE';
    end;
  end;
  result:=ParseSQL(Factor.iDbType,strSql);
end;

function TfrmSalIndentDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab,SQLData: string;
  StrCnd: string; 
begin
  StrCnd:='';
  if P6_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P6_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+GetDataRight;
  //订货方式:    
  if fndP6_SALES_STYLE.ItemIndex>0 then
    StrCnd:=' and M.SALES_STYLE='''+TRecord_(fndP6_SALES_STYLE.Properties.Items.Objects[fndP6_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //门店条件
  if fndP6_SHOP_ID.AsString<>'' then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP6_SHOP_ID.AsString+''' ';
    StrCnd:=StrCnd+' and M.SHOP_ID='''+fndP6_SHOP_ID.AsString+''' ';
  end;

  //GodsID不为空：
  if trim(GodsID)<>'' then
    StrCnd:=StrCnd+' and S.GODS_ID='''+GodsID+''' ';

  //月份日期:
  if (P6_D1.Text<>'') and (P6_D1.Date=P6_D2.Date) then
    StrCnd:=StrCnd+' and M.INDE_DATE='+FormatDatetime('YYYYMMDD',P6_D1.Date)
  else if P6_D1.Date<P6_D2.Date then
    StrCnd:=StrCnd+' and (M.INDE_DATE>='+FormatDatetime('YYYYMMDD',P6_D1.Date)+' and M.INDE_DATE<='+FormatDatetime('YYYYMMDD',P6_D2.Date)+') '
  else
    Raise Exception.Create('结束日期不能小于开始日期...');

  //门店所属行政区域|门店类型:
  if (fndP6_SHOP_VALUE.AsString<>'') then
  begin
    case fndP6_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP6_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP6_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP6_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP6_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP6_STAT_ID.AsString <> '') and (fndP6_TYPE_ID.ItemIndex>=0) then
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP6_TYPE_ID)+'='''+fndP6_STAT_ID.AsString+''' ';

  //商品分类:
  if (trim(fndP6_SORT_ID.Text)<>'') and (trim(srid6)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid6+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid6+''' ';
    end;
    if trim(sid6)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid6+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 部门名称: [2012.01.16修改:可以按树上下级查询]
  if trim(fndP6_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP6_DEPT_ID.AsString);

  SQLData:=
    '(select M.TENANT_ID'+
      ',M.SHOP_ID'+
      ',M.DEPT_ID'+
      ',M.GLIDE_NO'+
      ',M.INDE_DATE'+
      ',M.GUIDE_USER'+
      ',M.CLIENT_ID'+
      ',M.CREA_DATE'+
      ',M.CREA_USER'+
      ',M.SALES_STYLE'+
      ',S.GODS_ID'+
      ',S.UNIT_ID'+
      ',S.PROPERTY_01'+
      ',S.PROPERTY_02'+
      ',S.BATCH_NO'+
      ',S.LOCUS_NO'+
      ',S.IS_PRESENT'+
      ',ORG_PRICE'+
      ',APRICE'+
      ',CALC_AMOUNT'+
      ',CALC_MONEY'+
      ',FNSH_AMOUNT as FNSH_AMT'+
      ',round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2) as TAX_MONEY '+
      ',(S.CALC_MONEY-round(S.CALC_MONEY/(1+case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end)*case when M.INVOICE_FLAG in (''2'',''3'') then M.TAX_RATE else 0 end,2)) as NOTAX_MONEY '+
    ' from SAL_INDENTDATA S,SAL_INDENTORDER M '+
    ' where S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=M.SHOP_ID and S.INDE_ID=M.INDE_ID and M.TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID'+
    ',A.GLIDE_NO'+
    ',A.GODS_ID'+
    ',A.BATCH_NO'+
    ',A.LOCUS_NO'+
    ',A.UNIT_ID'+
    ',A.INDE_DATE'+
    ',A.PROPERTY_01'+
    ',A.PROPERTY_02'+
    ',A.IS_PRESENT'+
    ',A.CLIENT_ID'+
    ',A.CREA_DATE'+
    ',A.CREA_USER'+
    ',A.SALES_STYLE'+
    ',A.SHOP_ID'+
    ',A.GUIDE_USER'+
    ',A.ORG_PRICE'+   //原售价
    ',A.CALC_AMOUNT as AMOUNT'+
    ',A.APRICE'+      //零售价
    ',A.CALC_MONEY as AMONEY'+ //含税销售额
    ',A.NOTAX_MONEY'+  //不含税销售额
    ',A.TAX_MONEY'+    //税额
    ',A.FNSH_AMT'+    //已发货数量
    ',B.SHOP_NAME '+
    ' from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';

  Result := ParseSQL(Factor.iDbType,
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',c.CLIENT_NAME as CLIENT_NAME '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',f.CODE_NAME as SALES_STYLE_TEXT '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j '+
    ' inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    '  on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_CUSTOMER c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    ' left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CODE_TYPE=''2'')f on j.SALES_STYLE=f.CODE_ID '
    );
  result := result +  ' order by j.INDE_DATE,r.GODS_CODE';
end;

procedure TfrmSalIndentDayReport.DBGridEh4DblClick(Sender: TObject);
var
  i,CodeID: integer;
  SortID: string;
  Aobj: TRecord_;
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  //肯定有报表类型:
  CodeID:=TRecord_(fndP4_REPORT_FLAG.Properties.Items.Objects[fndP4_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   3: if trim(adoReport4.FieldByName('SID').AsString)='' then Raise Exception.Create('分类名称不能为空！');
   else
      if trim(adoReport4.FieldByName('SORT_ID').AsString)='' then Raise Exception.Create('分类名称不能为空！');
  end;
  
  case CodeID of
   1:  //商品分类[带供应链接]
    begin
      sid5:=Copy(trim(adoReport4.fieldbyName('LEVEL_ID').AsString),8,200);
      srid5:=trim(adoReport4.fieldbyName('SORT_ID').AsString);
      fndP5_SORT_ID.Text:=trim(adoReport4.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP5_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP5_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP5_TYPE_ID.Properties.Items.Objects[i]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP5_TYPE_ID.ItemIndex:=i;
          case CodeID of
           3: fndP5_STAT_ID.KeyValue:=trim(adoReport4.fieldbyName('SORT_ID').AsString)
           else
              fndP5_STAT_ID.KeyValue:=trim(adoReport4.fieldbyName('SID').AsString);
          end;
          fndP5_STAT_ID.Text:=trim(adoReport4.fieldbyName('SORT_NAME').AsString);
          break;
        end;
      end;
    end;
  end;  

  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5);  //门店群组
  Copy_ParamsValue(fndP4_SHOP_ID, fndP5_SHOP_ID);  //门店名称
  Copy_ParamsValue(fndP4_DEPT_ID, fndP5_DEPT_ID);  //部门名称
  fndP5_UNIT_ID.ItemIndex:=fndP4_UNIT_ID.ItemIndex; //显示单位
  fndP5_SALES_STYLE.ItemIndex:=fndP4_SALES_STYLE.ItemIndex;

  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmSalIndentDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmSalIndentDayReport.DBGridEh5DblClick(Sender: TObject);
begin
  inherited;
  if adoReport5.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  GodsID:=trim(adoReport5.FieldbyName('GODS_ID').AsString);
  P6_D1.Date:=P5_D1.Date;
  P6_D2.Date:=P5_D2.Date;
  sid6:=sid5;
  srid6:=srid5;
  fndP6_SORT_ID.Text:=fndP5_SORT_ID.Text;
  Copy_ParamsValue(fndP5_DEPT_ID,fndP6_DEPT_ID);  //部门名称
  Copy_ParamsValue(fndP5_SHOP_ID,fndP6_SHOP_ID);  //门店名称
  Copy_ParamsValue('SHOP_TYPE',5,6); //管理群组
  Copy_ParamsValue('TYPE_ID',5,6);   //商品指标
  fndP6_SALES_STYLE.ItemIndex:=fndP5_SALES_STYLE.ItemIndex;

  
  RzPage.ActivePageIndex:=5;
  actFindExecute(nil);
end;

procedure TfrmSalIndentDayReport.PrintBefore;
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

procedure TfrmSalIndentDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmSalIndentDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmSalIndentDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmSalIndentDayReport.fndP6_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid6 := '';
  srid6 := '';
  fndP6_SORT_ID.Text := '';
end;

procedure TfrmSalIndentDayReport.fndP1_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmSalIndentDayReport.fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

function TfrmSalIndentDayReport.GetUnitIDIdx: integer;
begin
  result:=0;
  if (RzPage.ActivePage=TabSheet1) and (fndP1_UNIT_ID.ItemIndex<>-1) then       //按部门统计表
    result:=fndP1_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet2) and (fndP2_UNIT_ID.ItemIndex<>-1) then  //地区销售存统计表
    result:=fndP2_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet3) and (fndP3_UNIT_ID.ItemIndex<>-1) then  //门店销售统计表
    result:=fndP3_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet4) and (fndP4_UNIT_ID.ItemIndex<>-1) then  //分类销售统计表
    result:=fndP4_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet5) and (fndP5_UNIT_ID.ItemIndex<>-1) then  //商品销售统计表
    result:=fndP5_UNIT_ID.ItemIndex;
end;

function TfrmSalIndentDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  FindCmp1:=FindComponent('fndP'+PageNo+'_SALES_STYLE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
  begin
    TitleList.add('订货方式：'+TcxComboBox(FindCmp1).Text);
  end;
    
  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmSalIndentDayReport.DBGridEh6GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmSalIndentDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  i: integer;
  FName: string;
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔'
  else
  begin
    if (SumRecord.Count>0) and (SumRecord.FindField(Column.FieldName)<>nil) then //字段数大于0 自己累计
    begin
      for i:=Low(ArySumField) to High(ArySumField) do
      begin
        FName:=trim(ArySumField[i]);
        if UpperCase(Column.FieldName)=UpperCase(FName) then
        begin
          Text:=FormatFloat(Column.DisplayFormat,SumRecord.fieldbyName(FName).AsFloat);
        end;
      end;
    end;
  end;
end;

procedure TfrmSalIndentDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmSalIndentDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmSalIndentDayReport.SetUnitIDList(DBGrid: TDBGridEh; ColName: string);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(DBGrid,ColName); 
  if (Rs<>nil) and (Rs.Active) and (SetCol<>nil) then
  begin
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(Rs.fieldByName('UNIT_ID').AsString);
      SetCol.PickList.Add(Rs.fieldByName('UNIT_NAME').AsString);
      Rs.Next;
    end;
  end;
end;

procedure TfrmSalIndentDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  if not RzPage.Pages[1].TabVisible then Exit;
  sid2:=sid1;
  srid2:=srid1;
  fndP2_SORT_ID.Text:=fndP1_SORT_ID.Text;
  fndP2_DEPT_ID.KeyValue:=trim(adoReport1.fieldbyName('DEPT_ID').AsString);
  fndP2_DEPT_ID.Text:=trim(adoReport1.fieldbyName('DEPT_NAME').AsString);

  P2_D1.Date:=P1_D1.Date;
  P2_D2.Date:=P1_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',1,2); //管理群组
  Copy_ParamsValue('TYPE_ID',1,2);   //商品指标
  Copy_ParamsValue(fndP1_GODS_ID,fndP2_GODS_ID); //商品名称
  fndP2_UNIT_ID.ItemIndex:=fndP1_UNIT_ID.ItemIndex;
  fndP2_SALES_STYLE.ItemIndex:=fndP1_SALES_STYLE.ItemIndex; 
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmSalIndentDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  sid3:=sid2;
  srid3:=srid2;
  fndP3_SORT_ID.Text:=fndP2_SORT_ID.Text;   //分类
  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID);  //部门
  Copy_ParamsValue('TYPE_ID',2,3);          //指标
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex; //显示单位

  fndP3_SHOP_TYPE.ItemIndex:=0;  //管理群组
  fndP3_SHOP_VALUE.KeyValue:=adoReport2.fieldbyName('REGION_ID').AsString;
  fndP3_SHOP_VALUE.Text:=adoReport2.fieldbyName('CODE_NAME').AsString;
  fndP3_SALES_STYLE.ItemIndex:=fndP2_SALES_STYLE.ItemIndex;

  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmSalIndentDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  if adoReport3.IsEmpty then Exit;

  P4_D1.Date:=P3_D1.Date;
  P4_D2.Date:=P3_D2.Date;
  Copy_ParamsValue(fndP3_DEPT_ID,fndP4_DEPT_ID); //部门名称
  Copy_ParamsValue('SHOP_TYPE',3,4);   //管理群组
  fndP4_UNIT_ID.ItemIndex:=fndP3_UNIT_ID.ItemIndex; //显示单位
  fndP4_SALES_STYLE.ItemIndex:=fndP3_SALES_STYLE.ItemIndex;

  fndP4_SHOP_ID.KeyValue:=trim(adoReport3.fieldbyName('SHOP_ID').AsString);
  fndP4_SHOP_ID.Text:=trim(adoReport3.fieldbyName('SHOP_NAME').AsString);

  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmSalIndentDayReport.fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 := '';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmSalIndentDayReport.fndP3_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid3,srid3,SortName) then
    fndP3_SORT_ID.Text:=SortName;
end;

procedure TfrmSalIndentDayReport.fndP3_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid3 := '';
  srid3 := '';
  fndP3_SORT_ID.Text := '';
end;

procedure TfrmSalIndentDayReport.fndP4_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh4);
end;

procedure TfrmSalIndentDayReport.SetRzPageActivePage(IsGroupReport: Boolean);
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

procedure TfrmSalIndentDayReport.fndP6_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid6,srid6,SortName) then
    fndP6_SORT_ID.Text:=SortName;
end;

procedure TfrmSalIndentDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmSalIndentDayReport.SingleReportParams(ParameStr: string);
begin
  inherited;
 
end;

function TfrmSalIndentDayReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP5_RPTTYPE.Properties.Items.Objects[fndP5_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';
end;

procedure TfrmSalIndentDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GODS_NAME' then Text := '合计:'+Text+'笔';
  if AllRecord.Count<=0 then Exit;
  ColName:=trim(UpperCase(Column.FieldName));
  if ColName = 'GODS_NAME' then
    Text := '合计:'+AllRecord.fieldbyName('GODS_NAME').AsString+'笔'
  else
  begin
    if (Copy(ColName,1,5)='SALE_') and (AllRecord.FindField(ColName)<>nil) then
    begin
      Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
    end;
  end;
end;

procedure TfrmSalIndentDayReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;  
begin
  inherited;
end;

procedure TfrmSalIndentDayReport.DBGridEh5DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

function TfrmSalIndentDayReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

procedure TfrmSalIndentDayReport.DBGridEh5TitleClick(Column: TColumnEh);
begin
  DBGridTitleClick(adoReport5,Column,'ORDER_ID');
end;

end.
