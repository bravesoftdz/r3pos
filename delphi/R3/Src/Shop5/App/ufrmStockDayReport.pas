unit ufrmStockDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup, ObjCommon,
  ufrmDateControl;

type
  TfrmStockDayReport = class(TframeBaseReport)
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
    dsadoReport5: TDataSource;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    fndP3_SHOP_ID: TzrComboBoxList;
    fndP3_REPORT_FLAG: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label21: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    DBGridEh5: TDBGridEh;
    Label17: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    Label29: TLabel;
    adoReport2: TZQuery;
    adoReport5: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    Label3: TLabel;
    fndP1_GODS_ID: TzrComboBoxList;
    Label4: TLabel;
    fndP2_GODS_ID: TzrComboBoxList;
    RzGB: TRzGroupBox;
    fndP5_ALL: TcxRadioButton;
    fndP5_InStock: TcxRadioButton;
    fndP5_ReturnStock: TcxRadioButton;
    Label38: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    P5_DateControl: TfrmDateControl;
    Label6: TLabel;
    fndP5_GODS_ID: TzrComboBoxList;
    Label13: TLabel;
    fndP4_GODS_ID: TzrComboBoxList;
    Label16: TLabel;
    fndP3_GODS_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
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
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh4TitleClick(Column: TColumnEh);
  private
    vBegDate,          //查询开始日期
    vEndDate: integer; //查询结束日期
    RckMaxDate: integer;  //台帐最大日期

    GodsID: string;      //当前双击明细的GODS_IDs
    SortName: string;
    sid1,sid2,sid4,sid5: string;
    srid1,srid2,srid4,srid5: string;

    //1、按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //2、按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;
    //3、按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //4、按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
    //5、按商品销售流水表
    function GetGlideSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
    function GetGodsSortIdx: string; //添加Title
    function GetDataRight: string; //返回查看数据权限
  public
    procedure PrintBefore;override;
    function  DoBeforeExport:boolean;override;
    function  GetRowType:integer;override;
    property  GodsSortIdx: string read GetGodsSortIdx; //统计类型
    property  DataRight: string read GetDataRight; //返回查看数据权限     
  end;

const
  ArySumField: Array[0..5] of string=('STOCK_AMT','STOCK_TTL','STOCK_TAX','STOCK_MNY','STOCK_RTL','STOCK_AGO');  

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;

{$R *.dfm}

procedure TfrmStockDayReport.FormCreate(Sender: TObject);
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


  SetRzPageActivePage; //设置活动RzPage.Acitve

  RefreshColumn;
  //门店默认值:
  fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP3_SHOP_ID.Text := Global.SHOP_NAME;
  fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP4_SHOP_ID.Text := Global.SHOP_NAME;
  fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP5_SHOP_ID.Text := Global.SHOP_NAME;

  //2011.12.22 重开启[若非总店默认当前门店]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP3_SHOP_ID.Properties.ReadOnly := False;
    fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP3_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
    //fndP3_SHOP_ID.Properties.ReadOnly := True;

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
  end;
  
  //2011.04.22 Add 判断成本价权限:
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['STOCK_PRC','STOCK_TTL','STOCK_RATE','STOCK_TAX','STOCK_MNY','STOCK_AGO','AVG_AGIO']);
    SetNotShowCostPrice(DBGridEh2, ['STOCK_PRC','STOCK_TTL','STOCK_RATE','STOCK_TAX','STOCK_MNY','STOCK_AGO','AVG_AGIO']);
    SetNotShowCostPrice(DBGridEh3, ['STOCK_PRC','STOCK_TTL','STOCK_RATE','STOCK_TAX','STOCK_MNY','STOCK_AGO','AVG_AGIO']);
    SetNotShowCostPrice(DBGridEh4, ['STOCK_PRC','STOCK_TTL','STOCK_RATE','STOCK_TAX','STOCK_MNY','STOCK_AGO','AVG_AGIO']);
    SetNotShowCostPrice(DBGridEh5, ['APRICE','CALC_MONEY','TAX_MONEY','NOTAX_MONEY','AGIO_RATE','AGIO_MONEY']);
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
    end;

  //2011.09.22 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.STOCK_TTL','DBGridEh1.STOCK_TAX','DBGridEh1.STOCK_MNY','DBGridEh1.STOCK_RTL','DBGridEh1.STOCK_AGO','DBGridEh1.AVG_AGIO',
                              'DBGridEh2.STOCK_TTL','DBGridEh2.STOCK_TAX','DBGridEh2.STOCK_MNY','DBGridEh2.STOCK_RTL','DBGridEh2.STOCK_AGO','DBGridEh2.AVG_AGIO',
                              'DBGridEh3.STOCK_TTL','DBGridEh3.STOCK_TAX','DBGridEh3.STOCK_MNY','DBGridEh3.STOCK_RTL','DBGridEh3.STOCK_AGO','DBGridEh3.AVG_AGIO',
                              'DBGridEh4.STOCK_TTL','DBGridEh4.STOCK_TAX','DBGridEh4.STOCK_MNY','DBGridEh4.STOCK_RTL','DBGridEh4.STOCK_AGO','DBGridEh4.AVG_AGIO',
                              'DBGridEh5.CALC_MONEY','DBGridEh5.TAX_MONEY','DBGridEh5.NOTAX_MONEY','DBGridEh5.RTL_MONEY','DBGridEh5.AGIO_MONEY']);
  //2012.08.15创建尺码、颜色
  if ShopGlobal.GetVersionFlag=1 then
    CreateGridColForFIG(DBGridEh5,7);
end;

function TfrmStockDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and STOCK_DATE='+InttoStr(vBegDate)+' '  //子条件
    else
      StrCnd:=StrCnd+' and STOCK_DATE>='+InttoStr(vBegDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //总条件
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  begin
    StrCnd:=StrCnd+' and STOCK_DATE>'+InttoStr(RckMaxDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if (fndP1_SHOP_VALUE.AsString<>'') then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
       end;
     1:
       strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP1_STAT_ID.Visible) and (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;
  //商品分类:
  if (fndP1_SORT_ID.Visible) and (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 商品名称:
  if trim(fndP1_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP1_GODS_ID.AsString,'A.GODS_ID');

  if RckMaxDate < vBegDate then   //--[全部查询视图]  
    SQLData:='(select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then  //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
  else                                
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                              //CALC_MONEY+AGIO_MONEY
      ' select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA  where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+                      
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(STOCK_AMT*1.000/'+UnitCalc+') as STOCK_AMT '+
    ',case when cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX) as decimal(18,3))*1.000/cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when cast((sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO)) as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+isnull(sum(STOCK_TAX),0) as decimal(18,3))*100.00/cast((sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO)) as decimal(18,3)) else 0 end as STOCK_RATE '+
    ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  strSql :=
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID';
  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmStockDayReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmStockDayReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //按地区汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按门店汇总表
        if adoReport2.Active then adoReport2.Close;
        strSql := GetShopSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按分类汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
        Do_REPORT_FLAGFooterSum(fndP3_REPORT_FLAG, adoReport3, ArySumField);
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        adoReport4.SortedFields:='';
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
        dsadoReport4.DataSet:=nil;
        DoGodsGroupBySort(adoReport4,GodsSortIdx,'SORT_ID','GODS_NAME','ORDER_ID',
                          ['STOCK_AMT','STOCK_PRC','STOCK_TTL','STOCK_TAX','STOCK_MNY','STOCK_RTL','STOCK_RATE','STOCK_AGO','AVG_AGIO','STOCK_MNY_TAX_AGO'],
                          ['STOCK_PRC=STOCK_TTL/STOCK_AMT','STOCK_RATE=STOCK_TTL/STOCK_MNY_TAX_AGO*100','AVG_AGIO=STOCK_AGO/STOCK_AMT']);
        dsadoReport4.DataSet:=adoReport4;
      end;
    4: begin //按商品流水帐
        if adoReport5.Active then adoReport5.Close;
        if Sender<>nil then self.GodsID:='';        
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmStockDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string; //统计单位换算计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: widestring;
begin
  StrCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and STOCK_DATE='+InttoStr(vBegDate)+' '  //子条件
    else
      StrCnd:=StrCnd+' and STOCK_DATE>='+InttoStr(vBegDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //总条件
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  begin
    StrCnd:=StrCnd+' and STOCK_DATE>'+InttoStr(RckMaxDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';
  end;

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
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP2_STAT_ID.Visible) and (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;

  //商品分类:
  if (fndP2_SORT_ID.Visible) and (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid2+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 商品名称:
  if trim(fndP2_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP2_GODS_ID.AsString,'A.GODS_ID');

  if RckMaxDate < vBegDate then      //--[全部查询视图]
    SQLData:='(select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
  else
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                              //CALC_MONEY+AGIO_MONEY
      ' select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA  where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(STOCK_AMT*1.000/'+UnitCalc+') as STOCK_AMT '+
    ',case when cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX) as decimal(18,3))*1.000/cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX) as decimal(18,3))*100.00/cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3)) else 0 end as STOCK_RATE '+
    ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  strSql :=
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmStockDayReport.GetSortSQL(chk:boolean=true): string;
var
  GodsStateIdx: integer; //表表统计指标Idx
  UnitCalc, JoinCnd,lv,LvField: string;  //单位计算关系
  strSql,strCnd,strWhere,GoodTab,SQLData: widestring;
begin
  Lv:='';
  LvField:='';
  result:='';
  strWhere:='';
  if P3_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //商品指标:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('请选择报表类型...');
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and STOCK_DATE='+InttoStr(vBegDate)+' '  //子条件
    else
      StrCnd:=StrCnd+' and STOCK_DATE>='+InttoStr(vBegDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //总条件
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  begin
    StrCnd:=StrCnd+' and STOCK_DATE>'+InttoStr(RckMaxDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';
  end;

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
     1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //门店条件
  if (fndP3_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
  end;

  //商品分类:
  case GodsStateIdx of
   1:
    begin
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
      LvField:=lv+' as LEVEL_ID ';
    end;
   else
     GoodTab:='VIW_GOODSPRICE';
  end;
  //2012.09.24增商品查询条件
  if trim(fndP3_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP3_GODS_ID.AsString,'A.GODS_ID');

  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          //CALC_MONEY+AGIO_MONEY
    SQLData:='(select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS' 
  else
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                              //CALC_MONEY+AGIO_MONEY
      ' select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA  where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+LvField+',C.RELATION_ID '+
    ',sum(STOCK_AMT*1.000/'+UnitCalc+') as STOCK_AMT '+
    ',sum(STOCK_MNY)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX)as decimal(18,3))*100.00/cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3)) else 0 end as STOCK_RATE '+
    ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
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
          ' sum(nvl(STOCK_AMT,0)) as STOCK_AMT '+
          ',case when cast(sum(nvl(STOCK_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(STOCK_TTL,0)) as decimal(18,3))*1.000/cast(sum(nvl(STOCK_AMT,0)) as decimal(18,3)) else 0 end as STOCK_PRC '+
          ',sum(nvl(STOCK_TTL,0)) as STOCK_TTL '+
          ',sum(nvl(STOCK_MNY,0)) as STOCK_MNY '+
          ',sum(nvl(STOCK_TAX,0)) as STOCK_TAX '+
          ',sum(nvl(STOCK_RTL,0)) as STOCK_RTL '+
          ',case when cast(sum(nvl(STOCK_TTL,0)) as decimal(18,3))<>0 then cast(sum(nvl(STOCK_TTL,0))-sum(nvl(STOCK_AGO,0)) as decimal(18,3))*100.00/cast(sum(nvl(STOCK_TTL,0)) as decimal(18,3)) else 0 end as STOCK_RATE '+
          ',case when cast(sum(nvl(STOCK_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(STOCK_AGO,0)) as decimal(18,3))*1.000/cast(sum(nvl(STOCK_AMT,0)) as decimal(18,3)) else 0 end as AVG_AGIO '+
          ',sum(nvl(STOCK_AGO,0)) as STOCK_AGO '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID  from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'') '+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'')) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(STOCK_AMT) as STOCK_AMT '+
          ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_TTL) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as STOCK_PRC '+
          ',sum(STOCK_TTL) as STOCK_TTL '+
          ',sum(STOCK_MNY) as STOCK_MNY '+
          ',sum(STOCK_TAX) as STOCK_TAX '+
          ',sum(STOCK_RTL) as STOCK_RTL '+
          ',case when cast(sum(STOCK_TTL) as decimal(18,3))<>0 then cast(sum(STOCK_TTL)-sum(STOCK_AGO) as decimal(18,3))*100.00/cast(sum(STOCK_TTL) as decimal(18,3)) else 0 end as STOCK_RATE '+
          ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as AVG_AGIO '+
          ',sum(STOCK_AGO) as STOCK_AGO '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME from ('+strSql+') j '+
        ' left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID '+
        ' group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(STOCK_AMT) as STOCK_AMT '+
          ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_TTL) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as STOCK_PRC '+
          ',sum(STOCK_TTL) as STOCK_TTL '+
          ',sum(STOCK_MNY) as STOCK_MNY '+
          ',sum(STOCK_TAX) as STOCK_TAX '+
          ',sum(STOCK_RTL) as STOCK_RTL '+
          ',case when cast(sum(STOCK_TTL) as decimal(18,3))<>0 then cast(sum(STOCK_TTL)-sum(STOCK_AGO) as decimal(18,3))*100.00/cast(sum(STOCK_TTL) as decimal(18,3)) else 0 end as STOCK_RATE '+
          ',case when cast(sum(STOCK_AMT) as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT) as decimal(18,3)) else 0 end as AVG_AGIO '+    //DB2此字段计算报错
          ',sum(STOCK_AGO) as STOCK_AGO '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+InttoStr(GodsStateIdx)+' '+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+InttoStr(GodsStateIdx)+'=r.SORT_ID '+
        ' group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmStockDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc,SORT_ID_Fields,SORT_ID_Group: string; //统计单位换算计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and STOCK_DATE='+InttoStr(vBegDate)+' '  //子条件
    else
      StrCnd:=StrCnd+' and STOCK_DATE>='+InttoStr(vBegDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //总条件
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  begin
    StrCnd:=StrCnd+' and STOCK_DATE>'+InttoStr(RckMaxDate)+' and STOCK_DATE<='+InttoStr(vEndDate)+' ';
  end;
 
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
  //门店条件
  if trim(fndP4_SHOP_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+trim(fndP4_SHOP_ID.AsString)+''' and B.SHOP_ID='''+trim(fndP4_SHOP_ID.AsString)+''' ';

  //商品指标:
  if (fndP4_STAT_ID.Visible) and (fndP4_STAT_ID.AsString <> '') and (fndP4_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP4_TYPE_ID)+'='''+fndP4_STAT_ID.AsString+''' ';
  end;
  
  //商品分类:
  if (trim(fndP4_SORT_ID.Text)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid4+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid4+''' ';
    end;
    if trim(sid4)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';
  //2012.09.24 Add 商品名称:
  if trim(fndP4_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP4_GODS_ID.AsString,'A.GODS_ID');

  //分组字段
  case StrToInt(GodsSortIdx) of
   -1:
     begin
       SORT_ID_Fields:=',''-1'' as SORT_ID';
       SORT_ID_Group:='';
     end;
    0:
     begin
       SORT_ID_Fields:=',C.RELATION_ID as SORT_ID';
       SORT_ID_Group:=',C.RELATION_ID';
     end
    else
     begin
       SORT_ID_Fields:=',(case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end) as SORT_ID';
       SORT_ID_Group:=',(case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end)';
     end;
  end;

  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          //CALC_MONEY+AGIO_MONEY
    SQLData:='(select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[全部查询台帐表]
  begin
    SQLData :='RCK_GOODS_DAYS';
    strWhere:=strWhere+' and (A.STOCK_AMT<>0 or A.STOCK_MNY<>0) ';
  end else
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' and (STOCK_AMT<>0 or STOCK_MNY<>0) '+
      ' union all '+                                                                                              //CALC_MONEY+AGIO_MONEY
      ' select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID'+SORT_ID_Fields+
    ',A.GODS_ID '+
    ',sum(STOCK_AMT*1.000/'+UnitCalc+') as STOCK_AMT '+
    ',case when cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX) as decimal(18,3))*1.000/cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO)) as STOCK_MNY_TAX_AGO '+
    ',case when cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3))<>0 then cast(sum(STOCK_MNY)+sum(STOCK_TAX)as decimal(18,3))*100.00/cast(sum(STOCK_MNY)+sum(STOCK_TAX)+sum(STOCK_AGO) as decimal(18,3)) else 0 end as STOCK_RATE '+
    ',case when cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(STOCK_AGO) as decimal(18,3))*1.000/cast(sum(STOCK_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID'+SORT_ID_Group+',A.GODS_ID';

  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  case StrtoInt(GodsSortIdx) of
   0: //供应链
    begin
      strSql :=
        'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE ';
    end;
   else
    begin
      strSql :=
        'select j.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        '(select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
        ' on  j.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,j.GODS_CODE';
    end;
  end;
  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmStockDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('进货日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //GodsID不为空：
  //if trim(GodsID)<>'' then strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';
  //2012.09.24 Add 商品名称:
  if trim(fndP5_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP5_GODS_ID.AsString,'A.GODS_ID');

  //月份日期:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.STOCK_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.STOCK_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.STOCK_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';

  //门店所属行政区域|门店类型:
  if (fndP5_SHOP_VALUE.AsString<>'') then
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
  //门店条件
  if trim(fndP5_SHOP_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+trim(fndP5_SHOP_ID.AsString)+''' and B.SHOP_ID='''+trim(fndP5_SHOP_ID.AsString)+''' ';

  //商品指标:
  if (fndP5_STAT_ID.Visible) and (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP5_TYPE_ID)+'='''+fndP5_STAT_ID.AsString+''' ';
  end;
  
  //商品分类:
  if (fndP5_SORT_ID.Visible) and (trim(fndP5_SORT_ID.Text)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //单据类型[入库单|退货单]
  if fndP5_InStock.Checked then
    strWhere:=strWhere+' and STOCK_TYPE=1 '
  else if fndP5_ReturnStock.Checked then
    strWhere:=strWhere+' and STOCK_TYPE=3 ';

  SQLData := 'VIW_STOCKDATA';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.STOCK_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.CLIENT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+
    ',A.GUIDE_USER '+
    ',A.STOCK_TYPE '+
    ',A.AMOUNT '+
    ',A.APRICE '+
    ',A.CALC_MONEY '+
    ',A.NOTAX_MONEY '+
    ',A.TAX_MONEY '+
    ',A.AGIO_MONEY '+
    ',A.AGIO_RATE '+
    ',A.CALC_MONEY+isnull(A.AGIO_MONEY,0) as RTL_MONEY '+
    ',B.SHOP_NAME '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';
    
  strSql := 
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',c.CLIENT_NAME as CLIENT_NAME '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    '  on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_CLIENTINFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    ' left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by j.STOCK_DATE,r.GODS_CODE';
    
  result := ParseSQL(Factor.iDbType,strSql)
end;

procedure TfrmStockDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date := P1_D1.Date;
  P2_D2.Date := P1_D2.Date;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text; //分类
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex; //显示单位
  Copy_ParamsValue('TYPE_ID',1,2);    //商品指标
  Copy_ParamsValue(fndP1_GODS_ID,fndP2_GODS_ID); //商品名称
  fndP2_SHOP_TYPE.ItemIndex := 0;
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;
  Copy_ParamsValue(fndP1_GODS_ID,fndP2_GODS_ID); //商品名称

  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;
  Copy_ParamsValue('SHOP_TYPE',2,3); //管理群组
  Copy_ParamsValue(fndP2_GODS_ID,fndP3_GODS_ID); //商品名称

  fndP3_SHOP_ID.KeyValue:=adoReport2.fieldbyName('SHOP_ID').AsString; //门店ID
  fndP3_SHOP_ID.Text:=adoReport2.fieldbyName('SHOP_NAME').AsString;   //门店名称

  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.DBGridEh3DblClick(Sender: TObject);
var
  i,CodeID: integer;
  SortID: string;
  Aobj: TRecord_;
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  //肯定有报表类型:
  CodeID:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   1,3:
     if trim(adoReport3.FieldByName('SORT_NAME').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
   else
     if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
  end;
  
  case CodeID of
   1:  //商品分类[带供应链接]
    begin
      sid4:=Copy(trim(adoReport3.fieldbyName('LEVEL_ID').AsString),8,100);
      srid4:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_SORT_ID.Text:=trim(adoReport3.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP4_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP4_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[i]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          case CodeID of
           3: fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
           else
              fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
          end;
          fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
          break;
        end;
      end;
    end;
  end;

  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID); //门店名称 
  Copy_ParamsValue('SHOP_TYPE',3,4); //管理群组 
  Copy_ParamsValue(fndP3_GODS_ID,fndP4_GODS_ID); //商品名称
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex; //显示单位
  
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  SetGodsIDValue(fndP5_GODS_ID,GodsID);
  sid5:=sid4;
  srid5:=srid4;
  fndP5_SORT_ID.Text:=fndP4_SORT_ID.Text;
  fndP5_ALL.Checked:=true;
  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5); //管理群组
  Copy_ParamsValue('TYPE_ID',4,5); //商品指标
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID); //门店名称
  
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);  
end;

procedure TfrmStockDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmStockDayReport.PrintBefore;
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
     5: AddReportReport(Title,'6');
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

procedure TfrmStockDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 :='';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 :='';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 :='';
  fndP4_SORT_ID.Text := '';
end;


procedure TfrmStockDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmStockDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
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

procedure TfrmStockDayReport.fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 :='';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmStockDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmStockDayReport.DBGridEh3GetFooterParams(Sender: TObject;
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

procedure TfrmStockDayReport.DBGridEh4GetFooterParams(Sender: TObject;
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
    if AllRecord.FindField(ColName)<>nil then
    begin
      if (Copy(ColName,1,6)='STOCK_') or (Copy(ColName,1,4)='AVG_') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end;
    end;
  end;
end;

procedure TfrmStockDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
end;

function TfrmStockDayReport.DoBeforeExport: boolean;
begin

end;

function TfrmStockDayReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';   
end;

procedure TfrmStockDayReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

procedure TfrmStockDayReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  DBGridTitleClick(adoReport4,Column,'ORDER_ID');
end;

function TfrmStockDayReport.GetDataRight: string;
begin
  // RCK_GOODS_DAYS、VIW_STOCKDATA A
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

