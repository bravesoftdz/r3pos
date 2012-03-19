unit ufrmAllRckReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar, zrMonthEdit, ufrmDateControl,uframeOrderForm, FR_Class;

type
  TfrmAllRckReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    LblUnit: TLabel;
    fndP1_UNIT_ID: TcxComboBox;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    actTemplate: TAction;
    btnDelete: TRzBitBtn;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    P1_DateControl: TfrmDateControl;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure rptTemplatePropertiesChange(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure rzShowColumnsChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure actColumnVisibleExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    PrintTimes:Integer;
    idx: integer;
    FrptIndex: integer;  //报表索引
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    function  GetMaxDate(E:integer):string;
    function  GetrptType: integer;
    procedure CheckCalc(b, e:integer); //开始月份| 结束月份
    //打开明细窗口
    procedure OpenDetailForm(id:string; cid:string='');
    function  GetCurOrder: TframeOrderForm;
    function  GetFormClass: TFormClass;
    procedure Clear;
    procedure InitColumnEhPickList(Column: TColumnEh);
    function  GetBillType: integer;
    procedure LoadFormat; override;
    procedure SaveFormat; override;
    procedure RefreshColumn; override;
  public
    Factory: TReportFactory;
    Lock:boolean;
    //按商品销售汇总表
    function  GetGodsSQL(chk:boolean=true): string;   //5555
    function  GetSQL: string;
    procedure CreateGridColumn; //创建报表列
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
    property  rptType: integer read GetrptType;
    property  BillType: integer Read GetBillType;
    property CurOrder:TframeOrderForm read GetCurOrder;    
  end;


implementation

uses
  ufrmDefineReport,ufnUtil,uShopUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar, ufrmCostCalc,ufrmStockOrder,ufrmSalesOrder,
  ufrmFastReport,uMsgBox;

{$R *.dfm}

procedure TfrmAllRckReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE4,'3','4') then
     begin
       load;
     end;
end;

procedure TfrmAllRckReport.load;
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
    rs.SQL.Text := 'select REPORT_ID,''全部商品台账'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''卷烟商品台账'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''非卷烟商品台帐'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''进货台账'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''销售台账'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' ';
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmAllRckReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmAllRckReport.FormCreate(Sender: TObject);
begin
  FrptIndex:=-1;
  //默认创建列
  CreateGridColumn;
  inherited;
  idx:=0;
  TDbGridEhSort.InitForm(self,false);
  P1_D1.date := date; //默认当月
  P1_D2.date := date; //默认当月
  P1_DateControl.StartDateControl := P1_D1;
  P1_DateControl.EndDateControl := P1_D2;

  Factory := nil;
  // load;
  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  //btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  //btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  //btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  if rptTemplate.Properties.Items.Count>0 then
    rptTemplate.ItemIndex:=0;
end;

procedure TfrmAllRckReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  if Factory<>nil then Factory.Free;
  Clear; //清除分页
  inherited;
end;

procedure TfrmAllRckReport.actFindExecute(Sender: TObject);
var
  strSql:string;
begin
  if rptTempLate.ItemIndex<0 then Exit;
  if adoReport1.Active then
  begin
    //删除前先保存上次
    self.SaveFormat;
    adoReport1.Close;
  end;
  adoReport1.SortedFields:='';
  if P1_D1.EditValue = null then Raise Exception.Create('  开始日期条件不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create('  结束日期条件不能为空！ ');
  if P1_D1.Date>P1_D2.Date then  Raise Exception.Create('  结束日期不能小于开始日期...');
  if rptTemplate.ItemIndex=-1 then Raise Exception.Create('     请选择台账分类！    ');
  CreateGridColumn; //创建列
  strSql := self.GetSQL;
  if strSql='' then Exit;
  adoReport1.SQL.Text := strSql;
  Factor.Open(adoReport1);
  if rptType<3 then
  begin
    dsadoReport1.DataSet:=nil;
    DoGodsGroupBySort(adoReport1,'2','SORT_ID','GODS_ID_TEXT','ORDER_ID',
                      ['ORG_AMT','STOCK_AMT','STOCK_TTL','SALE_AMT','SALE_TTL','SALE_PRF','SALE_RATE','BAL_AMT'],
                      ['SALE_RATE=SALE_PRF/SALE_MNY*100.0']);
    dsadoReport1.DataSet:=adoReport1;
  end;
  {if Factory<>nil then Factory.Free;
  Factory := TReportFactory.Create('4');
  try
    if Factory.DataSet.Active then Factory.DataSet.Close;
    strSql := GetGodsSQL;
    if strSql='' then Exit;
    TZQuery(Factory.DataSet).SQL.Text:= strSql;
    {frmPrgBar.Show;
    frmPrgBar.Update;
    frmPrgBar.WaitHint := '准备数据源...';
    frmPrgBar.Precent := 0;
    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;}
end;

procedure TfrmAllRckReport.btnEditClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.EditReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

function TfrmAllRckReport.GetGodsSQL(chk: boolean): string;
var
  mx, UnitCalc: string;  //单位计算关系
  strSql,strWhere,strWhere_y,strWhere_m,GoodTab: widestring;
  Day:integer;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D1.Date>P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);

  Day := round(P1_D2.Date - P1_D1.Date) + 1;

  //计量单位换算:
  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  //检测是否计算
  CheckCalc(strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date)),strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
  
  mx := GetMaxDate(StrtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));

  //日期:
  if (P1_D1.EditValue<>null) and (FormatDatetime('YYYYMMDD',P1_D1.Date)=FormatDatetime('YYYYMMDD',P1_D2.Date)) then
    strWhere:=strWhere+' and A.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
  else if P1_D1.Date<P1_D2.Date then
    strWhere:=strWhere+' and A.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+' ';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_AMT*1.00/'+UnitCalc+' else 0 end) as ORG_AMT '+ //期初数量
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_MNY else 0 end) as ORG_MNY '+   //进项金额<按当时进价>
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_RTL else 0 end) as ORG_RTL '+   //可销售额<按零售价>
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_CST else 0 end) as ORG_CST '+   //结存成本<移动加权成本>

    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as STOCK_AMT '+   //进货数量
    ',sum(STOCK_MNY) as STOCK_MNY '+   //进货金额<末税>
    ',sum(STOCK_TAX) as STOCK_TAX '+   //进项税额
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+  //进货金额


    ',0 as YEAR_STOCK_AMT '+   //进货数量
    ',0 as YEAR_STOCK_MNY '+   //进货金额<末税>
    ',0 as YEAR_STOCK_TAX '+   //进项税额
    ',0 as YEAR_STOCK_TTL '+   //进货金额


    ',0 as PRIOR_STOCK_AMT '+   //进货数量
    ',0 as PRIOR_STOCK_MNY '+   //进货金额<末税>
    ',0 as PRIOR_STOCK_TAX '+   //进项税额
    ',0 as PRIOR_STOCK_TTL '+  //进货金额

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as SALE_AMT '+   //销售数量
    ',sum(SALE_MNY) as SALE_MNY '+   //销售金额<末税>
    ',sum(SALE_TAX) as SALE_TAX '+   //销项税额
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+  //销售金额
    ',sum(SALE_CST) as SALE_CST '+   //销售成本
    ',sum(SALE_PRF) as SALE_PRF '+   //销售毛利

    ',0 as PRIOR_YEAR_AMT '+   //去年同期销售数量
    ',0 as PRIOR_YEAR_MNY '+   //去年同期销售金额<末税>
    ',0 as PRIOR_YEAR_TAX '+   //去年同期销项税额
    ',0 as PRIOR_YEAR_TTL '+   //去年同期销售金额
    ',0 as PRIOR_YEAR_CST '+   //去年同期销售成本
    ',0 as PRIOR_YEAR_PRF '+   //去年同期销售毛利

    ',0 as PRIOR_MONTH_AMT '+   //上月销售数量
    ',0 as PRIOR_MONTH_MNY '+   //上月销售金额<末税>
    ',0 as PRIOR_MONTH_TAX '+   //上月销项税额
    ',0 as PRIOR_MONTH_TTL '+   //上月销售金额
    ',0 as PRIOR_MONTH_CST '+   //上月销售成本
    ',0 as PRIOR_MONTH_PRF '+   //上月销售毛利

    ',sum(case when A.CREA_DATE='+mx+' then BAL_AMT*1.00/'+UnitCalc+' else 0 end) as BAL_AMT '+ //结存数量
    ',sum(case when A.CREA_DATE='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+   //进项金额<按当时进价>
    ',sum(case when A.CREA_DATE='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+   //可销售额<按零售价>
    ',sum(case when A.CREA_DATE='+mx+' then BAL_CST else 0 end) as BAL_CST '+   //结存成本<移动加权成本>
    ','+inttostr(Day)+' as DAYS_AMT '+  //销售天数
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql := strSql + ' union all '+
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+

    ',0 as ORG_AMT '+ //期初数量
    ',0 as ORG_MNY '+   //进项金额<按当时进价>
    ',0 as ORG_RTL '+   //可销售额<按零售价>
    ',0 as ORG_CST '+   //结存成本<移动加权成本>

    ',0 as STOCK_AMT '+   //进货数量
    ',0 as STOCK_MNY '+   //进货金额<末税>
    ',0 as STOCK_TAX '+   //进项税额
    ',0 as STOCK_TTL '+  //进货金额


    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as YEAR_STOCK_AMT '+   //进货数量
    ',sum(STOCK_MNY) as YEAR_STOCK_MNY '+   //进货金额<末税>
    ',sum(STOCK_TAX) as YEAR_STOCK_TAX '+   //进项税额
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as YEAR_STOCK_TTL '+  //进货金额


    ',0 as PRIOR_STOCK_AMT '+   //进货数量
    ',0 as PRIOR_STOCK_MNY '+   //进货金额<末税>
    ',0 as PRIOR_STOCK_TAX '+   //进项税额
    ',0 as PRIOR_STOCK_TTL '+  //进货金额

    ',0 as SALE_AMT '+   //销售数量
    ',0 as SALE_MNY '+   //销售金额<末税>
    ',0 as SALE_TAX '+   //销项税额
    ',0 as SALE_TTL '+  //销售金额
    ',0 as SALE_CST '+   //销售成本
    ',0 as SALE_PRF '+   //销售毛利

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as PRIOR_YEAR_AMT '+   //去年同期销售数量
    ',sum(SALE_MNY) as PRIOR_YEAR_MNY '+   //去年同期销售金额<末税>
    ',sum(SALE_TAX) as PRIOR_YEAR_TAX '+   //去年同期销项税额
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as PRIOR_YEAR_TTL '+  //去年同期销售金额
    ',sum(SALE_CST) as PRIOR_YEAR_CST '+   //去年同期销售成本
    ',sum(SALE_PRF) as PRIOR_YEAR_PRF '+   //去年同期销售毛利

    ',0 as PRIOR_MONTH_AMT '+   //上月销售数量
    ',0 as PRIOR_MONTH_MNY '+   //上月销售金额<末税>
    ',0 as PRIOR_MONTH_TAX '+   //上月销项税额
    ',0 as PRIOR_MONTH_TTL '+  //上月销售金额
    ',0 as PRIOR_MONTH_CST '+   //上月销售成本
    ',0 as PRIOR_MONTH_PRF '+   //上月销售毛利

    ',0 as BAL_AMT '+ //结存数量
    ',0 as BAL_MNY '+   //进项金额<按当时进价>
    ',0 as BAL_RTL '+   //可销售额<按零售价>
    ',0 as BAL_CST '+   //结存成本<移动加权成本>
    ','+inttostr(Day)+' as DAYS_AMT '+  //销售天数
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere_y + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql := strSql + ' union all '+
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+

    ',0 as ORG_AMT '+ //期初数量
    ',0 as ORG_MNY '+   //进项金额<按当时进价>
    ',0 as ORG_RTL '+   //可销售额<按零售价>
    ',0 as ORG_CST '+   //结存成本<移动加权成本>

    ',0 as STOCK_AMT '+   //进货数量
    ',0 as STOCK_MNY '+   //进货金额<末税>
    ',0 as STOCK_TAX '+   //进项税额
    ',0 as STOCK_TTL '+  //进货金额


    ',0 as YEAR_STOCK_AMT '+   //进货数量
    ',0 as YEAR_STOCK_MNY '+   //进货金额<末税>
    ',0 as YEAR_STOCK_TAX '+   //进项税额
    ',0 as YEAR_STOCK_TTL '+  //进货金额


    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as PRIOR_STOCK_AMT '+   //进货数量
    ',sum(STOCK_MNY) as PRIOR_STOCK_MNY '+   //进货金额<末税>
    ',sum(STOCK_TAX) as PRIOR_STOCK_TAX '+   //进项税额
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as PRIOR_STOCK_TTL '+  //进货金额

    ',0 as SALE_AMT '+   //销售数量
    ',0 as SALE_MNY '+   //销售金额<末税>
    ',0 as SALE_TAX '+   //销项税额
    ',0 as SALE_TTL '+  //销售金额
    ',0 as SALE_CST '+   //销售成本
    ',0 as SALE_PRF '+   //销售毛利

    ',0 as PRIOR_YEAR_AMT '+   //去年同期销售数量
    ',0 as PRIOR_YEAR_MNY '+   //去年同期销售金额<末税>
    ',0 as PRIOR_YEAR_TAX '+   //去年同期销项税额
    ',0 as PRIOR_YEAR_TTL '+  //去年同期销售金额
    ',0 as PRIOR_YEAR_CST '+   //去年同期销售成本
    ',0 as PRIOR_YEAR_PRF '+   //去年同期销售毛利

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as PRIOR_MONTH_AMT '+   //上月销售数量
    ',sum(SALE_MNY) as PRIOR_MONTH_MNY '+   //上月销售金额<末税>
    ',sum(SALE_TAX) as PRIOR_MONTH_TAX '+   //上月销项税额
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as PRIOR_MONTH_TTL '+  //上月销售金额
    ',sum(SALE_CST) as PRIOR_MONTH_CST '+   //上月销售成本
    ',sum(SALE_PRF) as PRIOR_MONTH_PRF '+   //上月销售毛利

    ',0 as BAL_AMT '+ //结存数量
    ',0 as BAL_MNY '+   //进项金额<按当时进价>
    ',0 as BAL_RTL '+   //可销售额<按零售价>
    ',0 as BAL_CST '+   //结存成本<移动加权成本>
    ','+inttostr(Day)+' as DAYS_AMT '+  //销售天数
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere_m + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql :=
    'select j.*,'+
    'r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME as GODS_ID_TEXT,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'r')+' as UNIT_ID,'+
    'r.SORT_ID1,r.RELATION_ID as SORT_ID24,r.SORT_ID1 as SORT_ID21,r.SORT_ID1 as SORT_ID22,r.SORT_ID1 as SORT_ID23,r.SORT_ID2,r.SORT_ID3,r.SORT_ID4,r.SORT_ID5,r.SORT_ID6,r.SORT_ID7,r.SORT_ID8,r.SORT_ID9,r.SORT_ID10,'+
    'r.SORT_ID11,r.SORT_ID12,r.SORT_ID13,r.SORT_ID14,r.SORT_ID15,r.SORT_ID16,r.SORT_ID17,r.SORT_ID18,r.SORT_ID19,r.SORT_ID20 '+
    ' from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  strSql :=
    'select ja.*,isnull(b.BARCODE,ja.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') ja '+
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    'on ja.TENANT_ID=b.TENANT_ID and ja.GODS_ID=b.GODS_ID and ja.BATCH_NO=b.BATCH_NO and ja.PROPERTY_01=b.PROPERTY_01 and ja.PROPERTY_02=b.PROPERTY_02 and ja.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on ja.TENANT_ID=u.TENANT_ID and ja.UNIT_ID=u.UNIT_ID '+
    ' order by ja.GODS_CODE ';

  result:=ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmAllRckReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

procedure TfrmAllRckReport.PrintBefore;
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

function TfrmAllRckReport.AddReportReport(TitleList: TStringList;
  PageNo: string): string;
var
  rptTitle: string;
begin
  //日期:
  rptTitle:='  日期：'+P1_D1.Text+' 至 '+P1_D2.Text;
  //台账类型:
  rptTitle:=rptTitle+'       台账类型:'+rptTemplate.Text;
  //显示单位:
  if fndP1_UNIT_ID.Visible then
    rptTitle:=rptTitle+'       显示单位:'+fndP1_UNIT_ID.Text;
  TitleList.Add(rptTitle);
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmAllRckReport.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
      TfrmCostCalc.TryCalcMthGods(self);
  finally
    rs.Free;
  end;
end;

function TfrmAllRckReport.GetMaxDate(E: integer): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_GOODS_DAYS where TENANT_ID=:TENANT_ID and CREA_DATE<=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
       result := inttostr(e)
    else
       result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmAllRckReport.CreateGridColumn;
var
  vType: integer;
  Column: TColumnEh;
begin
  //判断是否需要重新创建表格
  if FrptIndex<>-1 then
  begin
    FrptIndex:=rptType;
    if (rptType<3) and (FrptIndex<3) then Exit;
    if (rptType>2) and (FrptIndex=rptType) then Exit;
  end;
  //删除明细窗口
  Clear;  
  //清除控件列
  DBGridEh1.Columns.Clear;
  DBGridEh1.Columns.BeginUpdate;
  try
    case rptType of
     0,1,2: //进销存类台账:
      begin
        //商品名称
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GODS_ID_TEXT';
        Column.Title.Caption:='商品名称';
        Column.Width :=130;        
        //商品货号
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GODS_CODE';
        Column.Title.Caption:='货号';
        Column.Width :=80;
        //条码
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'BARCODE';
        Column.Title.Caption:='条码';
        Column.Width :=90;
        //单位
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'UNIT_NAME';
        Column.Title.Caption:='单位';
        Column.Width :=40;        
        //进价
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'NEW_INPRICE';
        Column.Title.Caption:='进价';
        Column.DisplayFormat:='#0.00#';
        Column.Width :=66;
        //售价
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'NEW_OUTPRICE';
        Column.Title.Caption:='售价';
        Column.DisplayFormat:='#0.00#';
        Column.Width :=66;
        //期初
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'ORG_AMT';
        Column.Title.Caption:='期初';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        //进货
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_AMT';
        Column.Title.Caption:='进货|数量';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_TTL';
        Column.Title.Caption:='进货|金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=75;
        //销售
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_AMT';
        Column.Title.Caption:='销售|数量';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_TTL';
        Column.Title.Caption:='销售|金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=75;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_PRF';
        Column.Title.Caption:='销售|毛利';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_RATE';
        Column.Title.Caption:='销售|毛利率';
        Column.DisplayFormat:='#0.00%';
        Column.Footer.DisplayFormat:='#0.00%';
        Column.Width :=66;
        //库存
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'BAL_AMT';
        Column.Title.Caption:='库存';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=75;
        vType:=1;
      end;
     3: //进货类台账:
      begin
        //序号
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEQNO';
        Column.Title.Caption := '序号';
        Column.Width :=30;
        //单据类型
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_TYPE';
        Column.Title.Caption := '单据类型';
        Column.Width :=56;
        Column.KeyList.Add('1');
        Column.PickList.Add('入库单');
        Column.KeyList.Add('3');
        Column.PickList.Add('退货单');
        //流水号
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GLIDE_NO';
        Column.Title.Caption := '流水号';
        Column.Footer.ValueType:=fvtCount;
        Column.Width :=94;
        //进货日期
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_DATE';
        Column.DisplayFormat := '0000-00-00';
        Column.Title.Caption := '流水号';
        Column.Width :=68;
        //供应商
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '供应商';
        Column.Width :=160;
        //门店名称
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SHOP_ID_TEXT';
        Column.Title.Caption := '门店名称';
        Column.Width :=120;
        //验货员
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GUIDE_USER_TEXT';
        Column.Title.Caption := '验货员';
        Column.Width :=53;
        //票据类型
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'INVOICE_FLAG';
        Column.Title.Caption := '验货员';
        Column.Width :=54;
        InitColumnEhPickList(Column);
        //数量
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMOUNT';
        Column.Title.Caption := '数量';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=54;
        //合计金额
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMONEY';
        Column.Title.Caption := '合计金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=58;
        //已结算
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PAYM_MNY';
        Column.Title.Caption := '已结算';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=56;
        //未结算
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECK_MNY';
        Column.Title.Caption := '未结算';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=58;
        //备注
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'REMARK';
        Column.Title.Caption := '备注';
        Column.Width :=142;
        //制单员
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_USER_TEXT';
        Column.Title.Caption := '制单员';
        Column.Width :=62;
        //录入时间
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_DATE';
        Column.Title.Caption := '录入时间';
        Column.Width :=130;
        vType:=2;
      end;
     4: //销售类台账:
      begin
        //序号
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEQNO';
        Column.Title.Caption := '序号';
        Column.Width :=30;
        //单句类型
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALES_TYPE';
        Column.Title.Caption := '单据类型';
        Column.Width :=56;
        Column.KeyList.Add('1');
        Column.PickList.Add('销售单');
        Column.KeyList.Add('3');
        Column.PickList.Add('退货单');
        Column.KeyList.Add('4');
        Column.PickList.Add('零售单');
        //流水号
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GLIDE_NO';
        Column.Title.Caption := '流水号';
        Column.Footer.ValueType:=fvtCount;
        Column.Width :=94;
        //销售日期
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALES_DATE';
        Column.DisplayFormat := '0000-00-00';
        Column.Title.Caption := '销售日期';
        Column.Width :=68;
        //客户名称
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '客户名称';
        Column.Width :=150;
        //门店名称
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SHOP_ID_TEXT';
        Column.Title.Caption := '门店名称';
        Column.Width :=120;
        //数量
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMOUNT';
        Column.Title.Caption := '数量';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=56;
        //合计金额
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMONEY';
        Column.Title.Caption := '合计金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=62;
        //实收金额
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECV_MNY';
        Column.Title.Caption := '实收金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=60;
        //欠收金额
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECK_MNY';
        Column.Title.Caption := '欠收金额';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=60;
        //导购员
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GUIDE_USER_TEXT';
        Column.Title.Caption := '导购员';
        Column.Width :=50;
        //票据类型
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'INVOICE_FLAG';
        Column.Title.Caption := '票据类型';
        Column.Width :=54;
        InitColumnEhPickList(Column);
        //制单员
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_USER_TEXT';
        Column.Title.Caption := '制单员';
        Column.Width :=60;
        //录入时间
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_DATE';
        Column.Title.Caption := '录入时间';
        Column.Width :=120;
        //备注
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'REMARK';
        Column.Title.Caption := '备注';
        Column.Width :=100;
        //送货日期
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PLAN_DATE';
        Column.Title.Caption := '送货日期';
        Column.Width :=62;
        //联系人
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'LINKMAN';
        Column.Title.Caption := '联系人';
        Column.Width :=54;
        //送货地址
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEND_ADDR';
        Column.Title.Caption := '送货地址';
        Column.Width :=142;
        vType:=3;        
      end;
    end;
    //刷新控制列:
    LoadGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
    //刷新列
    if rzShowColumns.Visible then RefreshColumn;
  finally
    DBGridEh1.Columns.EndUpdate;
  end;
end;

function TfrmAllRckReport.GetrptType: integer;
begin
  result:=0;
  if rptTemplate.ItemIndex<>-1 then
    result:=rptTemplate.ItemIndex;
end;

function TfrmAllRckReport.GetSQL: string;
var
  w,w1:string;
  strWhere,UnitCalc,mx,strSql,BarTab: string;
  BegDate,EndDate: string;
begin
  BegDate:=Formatdatetime('YYYYMMDD',P1_D1.Date);
  EndDate:=Formatdatetime('YYYYMMDD',P1_D2.Date);
  case rptType of
   0, //全部商品台账
   1, //卷烟类商品台账
   2: //非烟类商品台账
    begin
      //检测是否计算:
      CheckCalc(strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date)),strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
      //取日台账日期内最大日期:
      mx := GetMaxDate(StrtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
      //计量单位换算:
      UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
      //过滤企业ID:
      strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if rptType=1 then
        strWhere:=strWhere+' and C.RELATION_ID=1000006 '
      else if rptType=2 then
        strWhere:=strWhere+' and C.RELATION_ID<>1000006 ';
      //日期:
      if (P1_D1.EditValue<>null) and (formatDatetime('YYYYMMDD',P1_D1.Date)=formatDatetime('YYYYMMDD',P1_D2.Date)) then
        strWhere:=strWhere+' and A.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
      else if P1_D1.Date<P1_D2.Date then
        strWhere:=strWhere+' and A.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+' ';
      strSql :=
        'SELECT '+
        ' A.TENANT_ID '+
        ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
        ',(C.NEW_INPRICE*'+UnitCalc+') as NEW_INPRICE,(C.NEW_OUTPRICE*'+UnitCalc+') as NEW_OUTPRICE '+
        ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_AMT*1.00/'+UnitCalc+' else 0 end) as ORG_AMT '+ //期初数量
        ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_MNY else 0 end) as ORG_MNY '+   //进项金额<按当时进价>

        ',sum(STOCK_AMT*1.00/'+UnitCalc+') as STOCK_AMT '+   //进货数量
        ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+   //进货金额<末税>

        ',sum(SALE_AMT*1.00/'+UnitCalc+') as SALE_AMT '+   //销售数量
        ',sum(SALE_MNY) as SALE_MNY '+    //销售金额<末税>
        ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+  //销售金额
        ',sum(SALE_PRF) as SALE_PRF '+    //销售毛利

        ',sum(case when A.CREA_DATE='+mx+' then BAL_AMT*1.00/'+UnitCalc+' else 0 end) as BAL_AMT '+ //结存数量
        ',sum(case when A.CREA_DATE='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+   //进项金额<按当时进价>
        ' from RCK_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSPRICE C '+
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere+' '+
        ' group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE,(C.NEW_INPRICE*'+UnitCalc+'),(C.NEW_OUTPRICE*'+UnitCalc+')';
      strSql :=
        'select j.* '+
        ' ,(case when SALE_MNY<>0 then (SALE_PRF*100.00/SALE_MNY) else 0.00 end) as SALE_RATE '+    //销售毛利率
        ' ,r.BARCODE as CALC_BARCODE '+
        ' ,r.GODS_CODE '+
        ' ,r.GODS_NAME as GODS_ID_TEXT'+
        ' ,''#'' as PROPERTY_01 '+
        ' ,''#'' as BATCH_NO '+
        ' ,''#'' as PROPERTY_02 '+
        ' ,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
        ' ,isnull(r.SORT_ID2,''#'') as SORT_ID '+
        ' from ('+strSql+') j '+
        ' inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';
      strSql :=
        'select ja.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,ja.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME '+
        ' from ('+strSql+') ja '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on ja.TENANT_ID=b.TENANT_ID and ja.GODS_ID=b.GODS_ID and ja.BATCH_NO=b.BATCH_NO and ja.PROPERTY_01=b.PROPERTY_01 and '+
           ' ja.PROPERTY_02=b.PROPERTY_02 and ja.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on ja.TENANT_ID=u.TENANT_ID and ja.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        ' (select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE=2 and COMM not in (''02'',''12'')) s '+
        ' on ja.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,ja.GODS_CODE';
      result:=ParseSQL(Factor.iDbType,strSql);
    end;
   3: //进货台账
    begin
      if BegDate=EndDate then
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.STOCK_TYPE=1 and A.STOCK_DATE>='+BegDate+' ' 
      else
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.STOCK_DATE>='+BegDate+' and A.STOCK_DATE<='+EndDate+' and A.STOCK_TYPE=1';
      w := ' select A.TENANT_ID,A.STOCK_TYPE,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CREA_DATE,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.GUIDE_USER,A.CREA_USER,A.SHOP_ID,'+
           ' A.STOCK_AMT as AMOUNT,A.STOCK_MNY as AMONEY,''4'' as ABLE_TYPE,case when LOCUS_STATUS = ''3'' then 3 else 1 end as LOCUS_STATUS_NAME '+
           ' from STK_STOCKORDER A '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
      w := ' select ja.*,a.CLIENT_NAME from ('+w+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
      w := 'select jc.*,c.PAYM_MNY,c.RECK_MNY from ('+w+') jc '+
           ' left join ACC_PAYABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.STOCK_ID=c.STOCK_ID and jc.ABLE_TYPE=c.ABLE_TYPE';
      w := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+w+') jd '+
           ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
      w := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+w+') je '+
           ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
      result :=
           'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+w+') jf '+
           ' left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ';
    end;
   4: //销售台账
    begin
      if BegDate=EndDate then
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SALES_TYPE in (1,4) and A.SALES_DATE='+BegDate+' '
      else
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SALES_TYPE in (1,4) and A.SALES_DATE>='+BegDate+' and A.SALES_DATE<='+EndDate+' ';
        
      w := ' select A.TENANT_ID,A.SALES_TYPE,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.SEND_ADDR,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,'+
           ' A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,A.SALE_AMT as AMOUNT,A.SALE_MNY as AMONEY,''1'' as RECV_TYPE, '+
           ' case when LOCUS_STATUS = ''3'' then 3 else 1 end as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
      w := 'select ja.*,a.CLIENT_NAME from ('+w+') ja '+
           ' left outer join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
      w := 'select jc.*,(case when jc.SALES_TYPE=4 then jc.AMONEY else c.RECV_MNY end)as RECV_MNY,c.RECK_MNY from ('+w+') jc '+
           ' left outer join ACC_RECVABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SALES_ID=c.SALES_ID and jc.RECV_TYPE=c.RECV_TYPE';
      w := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+w+') jd '+
           ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
      w := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+w+') je '+
           ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
      result :=
           'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+w+') jf '+
           ' left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ';
    end;
  end;
end;

procedure TfrmAllRckReport.rptTemplatePropertiesChange(Sender: TObject);
begin
  //控制单位是否显示与隐藏:
  fndP1_UNIT_ID.Visible:=(rptType<3);
  LblUnit.Visible:=(rptType<3);
end;

procedure TfrmAllRckReport.DBGridEh1DblClick(Sender: TObject);
var
  BillID: string;
begin
  if CurOrder=nil then
  begin
    BillID:='';
    if adoReport1.IsEmpty then Exit;
    if adoReport1.FindField('STOCK_ID')<>nil then
      BillID:=trim(adoReport1.FieldByName('STOCK_ID').AsString)
    else if adoReport1.FindField('SALES_ID')<>nil then
      BillID:=trim(adoReport1.FieldByName('SALES_ID').AsString);  
    if BillID='' then Exit;
    OpenDetailForm(BillID, adoReport1.FieldbyName('SHOP_ID').AsString);
  end;
end;

procedure TfrmAllRckReport.OpenDetailForm(id, cid: string);
function CheckExists:integer;
var
  i:integer;
  FrmObj: TframeOrderForm;
begin
  result := -1;
  for i:=0 to rzPage.PageCount -1 do
    begin
      if rzPage.Pages[i].Data = nil then continue;
      FrmObj:=TframeOrderForm(rzPage.Pages[i].Data);
      if (FrmObj.oid = id) and (FrmObj.cid=cid) then
      begin
        result := i;
        exit;
      end;
      //进行刷新数据
      if cid='' then
        FrmObj.cid := Global.SHOP_ID
      else
        FrmObj.cid := cid;
      FrmObj.Open(id);
      result:=i;
    end;
end;
var
  p:integer;
  form: TframeOrderForm;
  Page: TrzTabSheet;
begin
  p := CheckExists;
  if p>=0 then
  begin
    rzPage.ActivePageIndex := p;
    exit;
  end;
  //新创建窗口
   Page := TrzTabSheet.Create(rzPage);
   form := TframeOrderForm(GetFormClass.Create(self));
   try
     inc(idx);
     Page.Caption := '新建'+inttostr(idx);
     Page.PageControl := rzPage;
     Page.Data := form;
     Page.Align := alClient;
     form.TabSheet := Page;
     form.ContainerHanle := Page.Handle;
     rzPage.ActivePage := Page;
     form.SetParantDisplay(rzPage.ActivePage);
     if cid='' then
        form.cid := Global.SHOP_ID
     else
        form.cid := cid;
     form.Open(id);
     RzPage.OnChange(nil);
   except
     Page.Data := nil;
     form.TabSheet := nil;
     form.Free;
     Page.Free;
     rzPage.ActivePageIndex := 0;
   end;
end;

function TfrmAllRckReport.GetCurOrder: TframeOrderForm;
begin
  if not Assigned(RzPage.ActivePage.Data) then
     result := nil
  else
     result := TframeOrderForm(RzPage.ActivePage.Data);
end;

function TfrmAllRckReport.GetFormClass: TFormClass;
begin
  if adoReport1.Active then
  begin
    if adoReport1.FindField('STOCK_ID')<>nil then
      result:=TfrmStockOrder
    else if adoReport1.FindField('SALES_ID')<>nil then
      result:=TfrmSalesOrder;
  end;
end;

procedure TfrmAllRckReport.Clear;
var
  i:integer;
begin
  for i:=rzPage.PageCount -1 downto 1 do
  begin
    if rzPage.Pages[i].Data <> nil then
      TframeOrderForm(rzPage.Pages[i].Data).Free;
  end;
end;

procedure TfrmAllRckReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
  GridDs: TDataSet;
begin
  ColName:=trim(UpperCase(Column.FieldName));
  GridDs:=TDataSet(DBGridEh1.DataSource.DataSet);
  if (GridDs.FindField('ORG_AMT')<>nil) and (GridDs.FindField('BAL_AMT')<>nil) and (AllRecord.Count>0) then
  begin
    if ColName='GODS_ID_TEXT' then
      Text := '合计:'+AllRecord.fieldbyName('GODS_ID_TEXT').AsString+'笔';
    if AllRecord.FindField(ColName)<>nil then
    begin
      if (Copy(ColName,1,4)='ORG_') or (Copy(ColName,1,6)='STOCK_') or (Copy(ColName,1,5)='SALE_') or (Copy(ColName,1,4)='BAL_') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end
    end;    
  end else
  begin
    if ColName='GLIDE_NO' then 
      Text := '合计:'+Text+'笔';
  end;
end;

procedure TfrmAllRckReport.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if (adoReport1.Active) and (adoReport1.FindField('ORG_AMT')<>nil) and (adoReport1.FindField('BAL_AMT')<>nil) then
    DBGridTitleClick(adoReport1,Column,'ORDER_ID')
  else
    DBGridTitleClick(adoReport1,Column);
end;

procedure TfrmAllRckReport.InitColumnEhPickList(Column: TColumnEh);
var
  rs: TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_PARAMS');
  rs.Filtered := false;
  rs.Filter := 'TYPE_CODE='''+Column.FieldName+'''';
  rs.Filtered := true;
  if rs.IsEmpty then Exit;
  try
    Column.KeyList.Clear;
    Column.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
      rs.Next;
    end;
  finally
    rs.Filtered := false;
    rs.Filter := '';
  end;
end;

function TfrmAllRckReport.GetBillType: integer;
begin
  result:=1;
  if adoReport1.IsEmpty then Exit;
  if (adoReport1.FindField('ORG_AMT')<>nil) and (adoReport1.FindField('BAL_AMT')<>nil) then
    result:=1
  else if adoReport1.FindField('STOCK_ID')<>nil then
    result:=2
  else if adoReport1.FindField('SALES_ID')<>nil then
    result:=3;
end;

procedure TfrmAllRckReport.rzShowColumnsChange(Sender: TObject;
  Index: Integer; NewState: TCheckBoxState);
begin
  if rzShowColumns.Tag = 1 then Exit;
  try
    if rzShowColumns.Items[Index]='' then Exit;
    TColumnEh(rzShowColumns.Items.Objects[Index]).Visible := (NewState = cbChecked);
    SaveFormat;
  except
  end;
end;

procedure TfrmAllRckReport.LoadFormat;
var
  vType: integer;
begin
  vType:=BillType;
  if vType=-1 then Exit;
  LoadGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
end;

procedure TfrmAllRckReport.SaveFormat;
var
  vType: integer;
begin
  vType:=BillType;
  if vType=-1 then Exit;
  SaveGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
end;

procedure TfrmAllRckReport.actColumnVisibleExecute(Sender: TObject);
begin
  if not rzShowColumns.Visible then RefreshColumn;
  inherited;
end;

procedure TfrmAllRckReport.RefreshColumn;
var i,n:Integer;
begin
  inherited;
  if DBGridEh=nil then Exit;
  rzShowColumns.Tag := 1;
  try
  rzShowColumns.Items.Clear;
  for i:=0 to DBGridEh.Columns.Count -1 do
    begin
      n := rzShowColumns.Items.AddObject(DBGridEh.Columns[i].Title.Caption,DBGridEh.Columns[i]);
      if DBGridEh.Columns[i].Visible then
         rzShowColumns.ItemState[n] := cbChecked
      else
         rzShowColumns.ItemState[n] := cbUnchecked;
      rzShowColumns.ItemEnabled[n] := (i>DBGridEh.FrozenCols-1);
    end;
  finally
    rzShowColumns.Tag := 0;
  end;
end;

procedure TfrmAllRckReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

end.
