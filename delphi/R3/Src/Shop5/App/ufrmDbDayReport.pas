unit ufrmDbDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup, ObjCommon;

type
  TfrmDbDayReport = class(TframeBaseReport)
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
    Label10: TLabel;
    Label13: TLabel;
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
    Label24: TLabel;
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
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label28: TLabel;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_UNIT_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    adoReport2: TZQuery;
    adoReport5: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh5DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title    
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;

{$R *.dfm}

procedure TfrmDbDayReport.FormCreate(Sender: TObject);
begin
  inherited;     
  TDbGridEhSort.InitForm(self,false);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  SetRzPageActivePage; //设置活动RzPage.Acitve
  RefreshColumn;
end;

function TfrmDbDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)
  end else
  if vBegDate<vEndDate then
  begin
    strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if (fndP1_SHOP_VALUE.AsString<>'') then
    begin
      case fndP1_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //商品指标:
  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP1_TYPE_ID.Properties.Items.Objects[fndP1_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP1_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP1_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP1_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP1_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP1_STAT_ID.AsString+''' ';
      end;
     end;
  //商品分类:
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';   

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
    //SQLData:='(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  strSql :=
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmDbDayReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmDbDayReport.actFindExecute(Sender: TObject);
var strSql: widestring;
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
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
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

function TfrmDbDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string; //统计单位换算计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: widestring;
begin
  StrCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)
  end else
  if vBegDate<vEndDate then
  begin
    strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if (fndP2_SHOP_VALUE.AsString<>'') then
    begin
      case fndP2_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //商品指标:

  if (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP2_TYPE_ID.Properties.Items.Objects[fndP2_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP2_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP2_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP2_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP2_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP2_STAT_ID.AsString+''' ';
      end;
     end;
  //商品分类:
  if (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  strSql :=    
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result :=  ParseSQL(Factor.iDbType, StrSql);
end;

function TfrmDbDayReport.GetSortSQL(chk:boolean=true): string;
var
  UnitCalc,JoinCnd: string;  //单位计算关系
  strSql,strCnd,strWhere,GoodTab,SQLData,lv: widestring;
begin
  result:='';
  strWhere:='';
  if P3_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)
  end else
  if vBegDate<vEndDate then
  begin
    strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if (fndP3_SHOP_VALUE.AsString<>'') then
    begin
      case fndP3_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
      end;
    end;

  //门店条件
  if (fndP3_SHOP_ID.AsString<>'') then
    begin
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
    end;

  //商品指标:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('请选择报表类型...');
  //商品分类:
  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:begin
      GoodTab:='VIW_GOODSINFO_SORTEXT';
      lv := ',C.LEVEL_ID';
    end;
  else
    GoodTab:='VIW_GOODSINFO';
  end;

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID';

  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
       case Factor.iDbType of
        4: JoinCnd:=' and r.LEVEL_ID=substr(j.LEVEL_ID,1,length(r.LEVEL_ID)) '
        else
          JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;    
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(DBIN_AMT) as DBIN_AMT '+
          ',sum(DBIN_CST) as DBIN_CST '+
          ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(DBIN_RTL) as DBIN_RTL '+
          ',sum(DBOUT_AMT) as DBOUT_AMT '+
          ',sum(DBOUT_CST) as DBOUT_CST '+
          ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT) as decimal(18,3)) else 0 end as DBOUT_PRC '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 '+
          'union all '+             
          'select distinct RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 ) j '+
          'left outer join ('+strSql+') r '+
          ' on j.RELATION_ID=r.RELATION_ID '+JoinCnd+' '+
          ' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(DBIN_AMT) as DBIN_AMT '+
          ',sum(DBIN_CST) as DBIN_CST '+
          ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(DBIN_RTL) as DBIN_RTL '+
          ',sum(DBOUT_AMT) as DBOUT_AMT '+
          ',sum(DBOUT_CST) as DBOUT_CST '+
          ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))/cast(sum(DBOUT_AMT) as decimal(18,3)) else 0 end as DBOUT_CST '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(DBIN_AMT) as DBIN_AMT '+
          ',sum(DBIN_CST) as DBIN_CST '+
          ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))/cast(sum(DBIN_AMT) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(DBIN_RTL) as DBIn_RTL '+
          ',sum(DBOUT_AMT) as DBOUT_AMT '+
          ',sum(DBOUT_CST) as DBOUT_CST '+
          ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))/cast(sum(DBOUT_AMT) as decimal(18,3)) else 0 end as DBOUT_PRC '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j '+
          'left outer join '+
          ' (select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='''+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+''') r '+
          ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmDbDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc: string; //统计单位换算计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)
  end else
  if vBegDate<vEndDate then
  begin
    strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';
    StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if (fndP4_SHOP_VALUE.AsString<>'') then
    begin
      case fndP4_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //商品指标:

  if (fndP4_STAT_ID.AsString <> '') and (fndP4_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[fndP4_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP4_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP4_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP4_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP4_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP4_STAT_ID.AsString+''' ';
      end;
     end;
  //商品分类:
  if (trim(fndP4_SORT_ID.Text)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid4+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid4+''' ';
    end;
    if trim(sid4)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData :='RCK_GOODS_DAYS'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;
  
  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID';
    
  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  strSql :=
    'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
    'left outer join VIW_BARCODE b '+
    'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' order by j.GODS_CODE ';

  result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmDbDayReport.GetGlideSQL(chk:boolean=true): string;
var
  JoinChar: string;
  strSql,StrCnd,strWhere,GoodTab: string;
begin
  JoinChar:=GetStrJoin(Factor.iDbType);
  if P5_D1.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('调拨日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+'';

  //GodsID不为空：
  if trim(GodsID)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  //月份日期:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';

  //门店所属行政区域|门店类型:
  if (fndP5_SHOP_VALUE.AsString<>'') then
    begin
      case fndP5_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //商品指标:
  if (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP5_TYPE_ID.Properties.Items.Objects[fndP5_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP5_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP5_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP5_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP5_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP5_STAT_ID.AsString+''' ';
      end;
     end;
  //商品分类:
  if (trim(fndP5_SORT_ID.Text)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.SALES_ID '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.SALES_DATE as MOVE_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+        //调出门店
    ',A.CLIENT_ID '+      //调入门店
    ',A.GUIDE_USER '+     //导购员
    ',A.AMOUNT as DB_AMT '+      //数量
    ',A.APRICE as DB_PRC '+      //单价
    ',A.RTL_MONEY as DB_RTL '+   //零售金额
    ',A.COST_MONEY as DB_CST '+  //成本
    ',B.SHOP_NAME '+             //调出门店
    ',D.STOCK_DATE as PLAN_DATE '+   //到货日期
    ',D.GUIDE_USER as SEND_USER '+   //发货人
    ',C.BARCODE as BARCODE '+
    ',C.GODS_CODE as GODS_CODE '+
    ',C.GODS_NAME as GODS_NAME '+   //关联商品表
    'from VIW_MOVEOUTDATA A,CA_SHOP_INFO B,'+GoodTab+' C,STK_STOCKORDER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
    ' and A.TENANT_ID=D.TENANT_ID and A.SALES_ID=D.STOCK_ID  '+
    ' '+ strWhere + ' ';

  strSql :=
    'select j.* '+
    ',isnull(B.BARCODE,j.BARCODE) as BARCODE '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',c.SHOP_NAME as OUTSHOP_NAME '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',f.USER_NAME as SEND_USER_TEXT '+
    'from ('+strSql+') j '+
    'left outer join VIW_BARCODE b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    'left outer join CA_SHOP_INFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.SHOP_ID '+
    'left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    'left outer join VIW_USERS f on j.TENANT_ID=f.TENANT_ID and j.SEND_USER=f.USER_ID '+
    ' order by j.MOVE_DATE,j.GODS_CODE';
    
  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmDbDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date := P1_D1.Date;
  P2_D2.Date := P1_D2.Date;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_TYPE_ID.ItemIndex := fndP1_TYPE_ID.ItemIndex;
  fndP2_STAT_ID.KeyValue := fndP1_STAT_ID.KeyValue;
  fndP2_STAT_ID.Text := fndP1_STAT_ID.Text;
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex;
  fndP2_SHOP_TYPE.ItemIndex := 0;
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;

  fndP3_SHOP_TYPE.ItemIndex := fndP2_SHOP_TYPE.ItemIndex;
  fndP3_SHOP_VALUE.KeyValue := fndP2_SHOP_VALUE.KeyValue;
  fndP3_SHOP_VALUE.Text := fndP2_SHOP_VALUE.Text;

  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('SHOP_ID').AsString;
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('SHOP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.DBGridEh3DblClick(Sender: TObject);
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
   3: if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create('分类名称不能为空！');
   else
      if trim(adoReport3.FieldByName('SORT_ID').AsString)='' then Raise Exception.Create('分类名称不能为空！');
  end;
  
  case CodeID of
   1:  //商品分类[带供应链接]
    begin
      sid4:=trim(adoReport3.fieldbyName('LEVEL_ID').AsString);
      srid4:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_SORT_ID.Text:=trim(adoReport3.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP4_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP4_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          break;
        end;
      end;
      if fndP4_TYPE_ID.ItemIndex<>-1 then
      begin
        if CodeID=3 then fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString)
        else fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
        fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
      end;
    end;
  end;

  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;

  fndP4_SHOP_TYPE.ItemIndex := fndP3_SHOP_TYPE.ItemIndex;
  fndP4_SHOP_VALUE.KeyValue := fndP3_SHOP_VALUE.KeyValue;
  fndP4_SHOP_VALUE.Text := fndP3_SHOP_VALUE.Text;

  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_SHOP_ID.KeyValue := fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text := fndP3_SHOP_ID.Text;
  
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmDbDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  fndP5_TYPE_ID.ItemIndex:=fndP4_TYPE_ID.ItemIndex;
  fndP5_STAT_ID.KeyValue:=fndP4_STAT_ID.KeyValue;
  fndP5_STAT_ID.Text:=fndP4_STAT_ID.Text;
  fndP5_SORT_ID.Text:=fndP4_SORT_ID.Text;
  sid5:=sid4;
  srid5:=srid4;
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmDbDayReport.PrintBefore;
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

procedure TfrmDbDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 :='';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 :='';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 :='';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmDbDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  //继承基类:
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmDbDayReport.fndP5_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 :='';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.DBGridEh5DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  DBGridDrawColumn(Sender,Rect,DataCol,Column,State,'GLIDE_NO');
end;

procedure TfrmDbDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmDbDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmDbDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmDbDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmDbDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'MOVE_DATE' then Text := '合计:'+Text+'笔';
end;

end.

