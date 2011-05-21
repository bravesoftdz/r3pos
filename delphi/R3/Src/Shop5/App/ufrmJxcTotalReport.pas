unit ufrmJxcTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList,ObjCommon,
  zrMonthEdit, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmJxcTotalReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    Label6: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnOk: TRzBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel9: TRzPanel;
    Label10: TLabel;
    Label13: TLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label14: TLabel;
    Label15: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    Label9: TLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    Label19: TLabel;
    Label20: TLabel;
    fndP3_SHOP_ID: TzrComboBoxList;
    RzBitBtn2: TRzBitBtn;
    fndP3_REPORT_FLAG: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    Label21: TLabel;
    Label24: TLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    Label25: TLabel;
    Label26: TLabel;
    RzBitBtn3: TRzBitBtn;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    RzPanel15: TRzPanel;
    DBGridEh4: TDBGridEh;
    fndP4_SHOP_ID: TzrComboBoxList;
    dsadoReport4: TDataSource;
    P1_D1: TzrMonthEdit;
    P1_D2: TzrMonthEdit;
    P2_D2: TzrMonthEdit;
    P2_D1: TzrMonthEdit;
    P3_D2: TzrMonthEdit;
    P3_D1: TzrMonthEdit;
    P4_D2: TzrMonthEdit;
    P4_D1: TzrMonthEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label11: TLabel;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label3: TLabel;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
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
  private
    IsOnDblClick: Boolean;  //是双击DBGridEh标记位  
    sid1,sid2,sid4:string;
    srid1,srid2,srid4:string;

    function GetMaxMonth(E:integer):string;
    procedure CheckCalc(b, e:integer); //开始月份| 结束月份

     //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): widestring;
    //按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    procedure CreateGrid;
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation
uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, ufrmSelectGoodSort, ufrmCostCalc, uShopUtil;
{$R *.dfm}

procedure TfrmJxcTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  IsOnDblClick:=False;
  TDbGridEhSort.InitForm(self,false);

  //初始化Items下拉参数:
  //P1:地区进销存统计:
  P1_D1.asString := FormatDateTime('YYYYMM', date); //默认当月
  P1_D2.asString := FormatDateTime('YYYYMM', date); //默认当月

  //P2:门店进销存统计
  P2_D1.asString := FormatDateTime('YYYYMM', date); //默认当月
  P2_D2.asString := FormatDateTime('YYYYMM', date); //默认当月

  //P3:分类进销存统计
  P3_D1.asString := FormatDateTime('YYYYMM', date); //默认当月
  P3_D2.asString := FormatDateTime('YYYYMM', date); //默认当月
  fndP3_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO'); 

  //P4:商品进销存统计
  P4_D1.asString := FormatDateTime('YYYYMM', date); //默认当月
  P4_D2.asString := FormatDateTime('YYYYMM', date); //默认当月
  fndP4_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');

  SetRzPageActivePage; //设置默认分页
  //2011.04.22 Add 判断成本价权限:
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh2, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh3, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh4, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
  end;
  CreateGrid;
  RefreshColumn;

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      fndP3_SHOP_ID.Properties.ReadOnly := False;
      fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP3_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
      fndP3_SHOP_ID.Properties.ReadOnly := True;

      fndP4_SORT_ID.Properties.ReadOnly := False;
      fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP4_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP4_TYPE_ID.Style);
      fndP4_SHOP_ID.Properties.ReadOnly := True;
    end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label3.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;
end;

function TfrmJxcTotalReport.GetGroupSQL(chk:boolean=true): widestring;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

  //月份日期:
  if (P1_D1.asString<>'') and (P1_D1.asString=P1_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P1_D1.asString
  else if P1_D1.asString<P1_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P1_D1.asString+' and A.MONTH<='+P1_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

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
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then   //and (trim(sid1)<>'') 
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if  trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //检测是否计算
  CheckCalc(strtoInt(P1_D1.asString),StrtoInt(P1_D2.asString));
  mx := GetMaxMonth(StrtoInt(P1_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_CST) as decimal(18,3)) else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    ' group by A.TENANT_ID,B.REGION_ID';

  strSql :=
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmJxcTotalReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmJxcTotalReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
    0:begin //按地区汇总表
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
  end;
end;

function TfrmJxcTotalReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  if P2_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

  //月份日期:
  if (P2_D1.asString<>'') and (P2_D1.asString=P2_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P2_D1.asString
  else if P2_D1.asString<P2_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P2_D1.asString+' and A.MONTH<='+P2_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

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

  //检测是否计算
  CheckCalc(strtoInt(P2_D1.asString),StrtoInt(P2_D2.asString));
  mx := GetMaxMonth(StrtoInt(P2_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_CST) as decimal(18,3))*100 else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  strSql :=
    'select j.* '+
    ' ,r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmJxcTotalReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab,lv:widestring;
  JoinCnd,mx:string;
begin
  result:='';
  if P3_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';
  
  //月份日期:
  if (P3_D1.asString<>'') and (P3_D1.asString=P3_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P3_D1.asString
  else if P3_D1.asString<P3_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P3_D1.asString+' and A.MONTH<='+P3_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

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
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',C.LEVEL_ID';
    end;
  else
  GoodTab:='VIW_GOODSPRICE';
  end;
  //检测是否计算
  CheckCalc(strtoInt(P3_D1.asString),StrtoInt(P3_D2.asString));
  mx := GetMaxMonth(StrtoInt(P3_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
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
          'sum(nvl(ORG_AMT,0)) as ORG_AMT '+
          ',sum(nvl(ORG_RTL,0)) as ORG_RTL '+
          ',sum(nvl(ORG_CST,0)) as ORG_CST '+
          ',sum(nvl(STOCK_AMT,0)) as STOCK_AMT '+
          ',sum(nvl(STOCK_MNY,0)) as STOCK_MNY '+
          ',sum(nvl(STOCK_TAX,0)) as STOCK_TAX '+
          ',sum(nvl(STOCK_RTL,0)) as STOCK_RTL '+
          ',sum(nvl(STOCK_TTL,0)) as STOCK_TTL '+
          ',sum(nvl(SALE_AMT,0)) as SALE_AMT '+
          ',sum(nvl(SALE_RTL,0)) as SALE_RTL '+
          ',sum(nvl(SALE_MNY,0)) as SALE_MNY '+
          ',sum(nvl(SALE_TAX,0)) as SALE_TAX '+
          ',sum(nvl(SALE_TTL,0)) as SALE_TTL '+
          ',sum(nvl(SALE_CST,0)) as SALE_CST '+
          ',sum(nvl(SALE_PRF,0)) as SALE_PRF '+
          ',case when sum(nvl(SALE_CST,0))<>0 then cast(sum(nvl(SALE_PRF,0)) as decimal(18,3))*100.00/cast(sum(nvl(SALE_CST,0)) as decimal(18,3)) else 0 end SALE_RATE '+
          ',sum(nvl(DBIN_AMT,0)) as DBIN_AMT '+
          ',sum(nvl(DBIN_CST,0)) as DBIN_CST '+
          ',sum(nvl(DBOUT_AMT,0)) as DBOUT_AMT '+
          ',sum(nvl(DBOUT_CST,0)) as DBOUT_CST '+
          ',sum(nvl(CHANGE1_AMT,0)) as CHANGE1_AMT '+
          ',sum(nvl(CHANGE1_CST,0)) as CHANGE1_CST '+
          ',sum(nvl(CHANGE2_AMT,0)) as CHANGE2_AMT '+
          ',sum(nvl(CHANGE2_CST,0)) as CHANGE2_CST '+
          ',sum(nvl(CHANGE3_AMT,0)) as CHANGE3_AMT '+
          ',sum(nvl(CHANGE3_CST,0)) as CHANGE3_CST '+
          ',sum(nvl(CHANGE4_AMT,0)) as CHANGE4_AMT '+
          ',sum(nvl(CHANGE4_CST,0)) as CHANGE4_CST '+
          ',sum(nvl(CHANGE5_AMT,0)) as CHANGE5_AMT '+
          ',sum(nvl(CHANGE5_CST,0)) as CHANGE5_CST '+
          ',sum(nvl(BAL_AMT,0)) as BAL_AMT '+
          ',sum(nvl(BAL_MNY,0)) as BAL_MNY '+
          ',sum(nvl(BAL_RTL,0)) as BAL_RTL '+
          ',sum(nvl(BAL_CST,0)) as BAL_CST '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'') '+
          'union all '+
          'select distinct RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
        'sum(ORG_AMT) as ORG_AMT '+
        ',sum(ORG_RTL) as ORG_RTL '+
        ',sum(ORG_CST) as ORG_CST '+
        ',sum(STOCK_AMT) as STOCK_AMT '+
        ',sum(STOCK_MNY) as STOCK_MNY '+
        ',sum(STOCK_TAX) as STOCK_TAX '+
        ',sum(STOCK_RTL) as STOCK_RTL '+
        ',sum(STOCK_TTL) as STOCK_TTL '+
        ',sum(SALE_AMT) as SALE_AMT '+
        ',sum(SALE_RTL) as SALE_RTL '+
        ',sum(SALE_MNY) as SALE_MNY '+
        ',sum(SALE_TAX) as SALE_TAX '+
        ',sum(SALE_TTL) as SALE_TTL '+
        ',sum(SALE_CST) as SALE_CST '+
        ',sum(SALE_PRF) as SALE_PRF '+
        ',case when sum(SALE_CST)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_CST)as decimal(18,3))*100.00 else 0 end SALE_RATE '+
        ',sum(DBIN_AMT) as DBIN_AMT '+
        ',sum(DBIN_CST) as DBIN_CST '+
        ',sum(DBOUT_AMT) as DBOUT_AMT '+
        ',sum(DBOUT_CST) as DBOUT_CST '+
        ',sum(CHANGE1_AMT) as CHANGE1_AMT '+
        ',sum(CHANGE1_CST) as CHANGE1_CST '+
        ',sum(CHANGE2_AMT) as CHANGE2_AMT '+
        ',sum(CHANGE2_CST) as CHANGE2_CST '+
        ',sum(CHANGE3_AMT) as CHANGE3_AMT '+
        ',sum(CHANGE3_CST) as CHANGE3_CST '+
        ',sum(CHANGE4_AMT) as CHANGE4_AMT '+
        ',sum(CHANGE4_CST) as CHANGE4_CST '+
        ',sum(CHANGE5_AMT) as CHANGE5_AMT '+
        ',sum(CHANGE5_CST) as CHANGE5_CST '+
        ',sum(BAL_AMT) as BAL_AMT '+
        ',sum(BAL_MNY) as BAL_MNY '+
        ',sum(BAL_RTL) as BAL_RTL '+
        ',sum(BAL_CST) as BAL_CST '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME '+
        ' from ('+strSql+') j left outer join VIW_CLIENTINFO r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
        'sum(ORG_AMT) as ORG_AMT '+
        ',sum(ORG_RTL) as ORG_RTL '+
        ',sum(ORG_CST) as ORG_CST '+
        ',sum(STOCK_AMT) as STOCK_AMT '+
        ',sum(STOCK_MNY) as STOCK_MNY '+
        ',sum(STOCK_TAX) as STOCK_TAX '+
        ',sum(STOCK_RTL) as STOCK_RTL '+
        ',sum(STOCK_TTL) as STOCK_TTL '+
        ',sum(SALE_AMT) as SALE_AMT '+
        ',sum(SALE_RTL) as SALE_RTL '+
        ',sum(SALE_MNY) as SALE_MNY '+
        ',sum(SALE_TAX) as SALE_TAX '+
        ',sum(SALE_TTL) as SALE_TTL '+
        ',sum(SALE_CST) as SALE_CST '+
        ',sum(SALE_PRF) as SALE_PRF '+
        ',case when sum(SALE_CST)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_CST) as decimal(18,3))*100.00 else 0 end SALE_RATE '+
        ',sum(DBIN_AMT) as DBIN_AMT '+
        ',sum(DBIN_CST) as DBIN_CST '+
        ',sum(DBOUT_AMT) as DBOUT_AMT '+
        ',sum(DBOUT_CST) as DBOUT_CST '+
        ',sum(CHANGE1_AMT) as CHANGE1_AMT '+
        ',sum(CHANGE1_CST) as CHANGE1_CST '+
        ',sum(CHANGE2_AMT) as CHANGE2_AMT '+
        ',sum(CHANGE2_CST) as CHANGE2_CST '+
        ',sum(CHANGE3_AMT) as CHANGE3_AMT '+
        ',sum(CHANGE3_CST) as CHANGE3_CST '+
        ',sum(CHANGE4_AMT) as CHANGE4_AMT '+
        ',sum(CHANGE4_CST) as CHANGE4_CST '+
        ',sum(CHANGE5_AMT) as CHANGE5_AMT '+
        ',sum(CHANGE5_CST) as CHANGE5_CST '+
        ',sum(BAL_AMT) as BAL_AMT '+
        ',sum(BAL_MNY) as BAL_MNY '+
        ',sum(BAL_RTL) as BAL_RTL '+
        ',sum(BAL_CST) as BAL_CST '+
        ',isnull(r.SORT_ID,''#'') as SID '+
        ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j '+
        ' left outer join (select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+') r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID '+
        ' group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmJxcTotalReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  if P4_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

  //月份日期:
  if (P4_D1.asString<>'') and (P4_D1.asString=P4_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P4_D1.asString
  else if P4_D1.asString<P4_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P4_D1.asString+' and A.MONTH<='+P4_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

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
    
  //门店条件
  if (fndP4_SHOP_ID.AsString<>'') then
    begin
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    end;

  //检测是否计算
  CheckCalc(strtoInt(P4_D1.asString),StrtoInt(P4_D2.asString));
  mx := GetMaxMonth(StrtoInt(P4_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_CST) as decimal(18,3)) else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-isnull(sum(CHANGE1_CST),0)+isnull(sum(ADJ_CST),0) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID';

  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  strSql :=
    'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' order by j.GODS_CODE ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

procedure TfrmJxcTotalReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true;
  P2_D1.asString := P1_D1.asString;
  P2_D2.asString := P1_D2.asString;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  Copy_ParamsValue('TYPE_ID',1,2);  //商品指标
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex; //显示单位
  fndP2_SHOP_TYPE.ItemIndex := 0;
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmJxcTotalReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true;  
  P3_D1.asString := P2_D1.asString;
  P3_D2.asString := P2_D2.asString;
  Copy_ParamsValue('SHOP_TYPE',2,3); //管理群组
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex; //显示单位
  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('SHOP_ID').AsString;
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('SHOP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil); 
end;

procedure TfrmJxcTotalReport.DBGridEh3DblClick(Sender: TObject);
var
  i,CodeID: integer;
  SortID: string;
  Aobj: TRecord_;
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true;
  //肯定有报表类型:
  CodeID:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   1,3:
     if trim(adoReport3.FieldByName('SORT_NAME').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
   else
     if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
  end;

  sid4:='';
  srid4:='';
  fndP4_SORT_ID.Text:='';
  fndP4_TYPE_ID.ItemIndex:=-1;
  fndP4_STAT_ID.KeyValue:='';
  fndP4_STAT_ID.Text:='';

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
        Aobj:=TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[fndP4_TYPE_ID.ItemIndex]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          case CodeID of
            3: fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
            else fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
          end;
          fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
          break;
        end;
      end;
    end;
  end;

  P4_D1.asString := P3_D1.asString;
  P4_D2.asString := P3_D2.asString;
  Copy_ParamsValue('SHOP_TYPE',3,4); //管理群组
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID); //门店名称
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex; //显示单位

  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmJxcTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmJxcTotalReport.PrintBefore;
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

procedure TfrmJxcTotalReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.actPriorExecute(Sender: TObject);
begin
  if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;
  
end;

procedure TfrmJxcTotalReport.CreateGrid;
var
  rs: TZQuery;
  Column: TColumnEh;
  CostPriceRight: Boolean;  //查看成本价权限
begin
  CostPriceRight:=ShopGlobal.GetChkRight('14500001',2);
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  rs.First;
  while not rs.Eof do
  begin
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
    Column.Title.Caption := rs.Fields[1].AsString+'|数量';
    Column.Width := 61;
    Column.Index := DBGridEh1.Columns.Count -4;
    Column.DisplayFormat:='#0.00';
    Column.Footer.ValueType:=fvtSum;
    Column.Footer.DisplayFormat:='#0.00';

    if CostPriceRight then  //判断只有查看成本才可以创建列
    begin
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
      Column.Title.Caption := rs.Fields[1].AsString+'|金额';
      Column.Width := 74;
      Column.Index := DBGridEh1.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';
    end;

    Column := DBGridEh2.Columns.Add;
    Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
    Column.Title.Caption := rs.Fields[1].AsString+'|数量';
    Column.Width := 61;
    Column.Index := DBGridEh2.Columns.Count -4;
    Column.DisplayFormat:='#0.00';
    Column.Footer.ValueType:=fvtSum;
    Column.Footer.DisplayFormat:='#0.00';        

    if CostPriceRight then  //判断只有查看成本才可以创建列
    begin        
      Column := DBGridEh2.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
      Column.Title.Caption := rs.Fields[1].AsString+'|金额';
      Column.Width := 74;
      Column.Index := DBGridEh2.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';
    end;

    Column := DBGridEh3.Columns.Add;
    Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
    Column.Title.Caption := rs.Fields[1].AsString+'|数量';
    Column.Width := 61;
    Column.Index := DBGridEh3.Columns.Count -4;
    Column.DisplayFormat:='#0.00';
    Column.Footer.ValueType:=fvtSum;
    Column.Footer.DisplayFormat:='#0.00';

    if CostPriceRight then  //判断只有查看成本才可以创建列
    begin
      Column := DBGridEh3.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
      Column.Title.Caption := rs.Fields[1].AsString+'|金额';
      Column.Width := 74;
      Column.Index := DBGridEh3.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';
    end;
        
    Column := DBGridEh4.Columns.Add;
    Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
    Column.Title.Caption := rs.Fields[1].AsString+'|数量';
    Column.Width := 61;
    Column.Index := DBGridEh4.Columns.Count -4;
    Column.DisplayFormat:='#0.00';
    Column.Footer.ValueType:=fvtSum;
    Column.Footer.DisplayFormat:='#0.00';

    if CostPriceRight then  //判断只有查看成本才可以创建列
    begin
      Column := DBGridEh4.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
      Column.Title.Caption := rs.Fields[1].AsString+'|金额';
      Column.Width := 74;
      Column.Index := DBGridEh4.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';
    end;
    rs.Next;
  end;     
end;

procedure TfrmJxcTotalReport.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  if IsOnDblClick then
  begin
    IsOnDblClick:=False; //重置标记位
    Exit; //若是双点击[DBGridEh连带查询则不在试算台帐]
  end;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH>=:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
      TfrmCostCalc.TryCalcMthGods(self);
  finally
    rs.Free;
  end;
end;

function TfrmJxcTotalReport.GetMaxMonth(E:integer): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(MONTH) from RCK_GOODS_MONTH where TENANT_ID=:TENANT_ID and MONTH<=:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
       result := inttostr(e)
    else
       result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmJxcTotalReport.fndP3_REPORT_FLAGPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmJxcTotalReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //1、月份
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TzrMonthEdit) and (FindCmp2 is TzrMonthEdit) and
     (TzrMonthEdit(FindCmp1).Visible) and (TzrMonthEdit(FindCmp2).Visible)  then
    TitleList.add('月份：'+TzrMonthEdit(FindCmp1).asString+' 至 '+TzrMonthEdit(FindCmp2).asString);

  //继承基类
  inherited AddReportReport(TitleList,PageNo);
end;
                              
procedure TfrmJxcTotalReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmJxcTotalReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmJxcTotalReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmJxcTotalReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then Text := '合计:'+Text+'笔';
end;

end.

