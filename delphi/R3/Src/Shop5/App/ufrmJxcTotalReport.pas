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
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);  
  private
    sid1,sid2,sid4:string;
    srid1,srid2,srid4:string;

    function GetMaxMonth(E:integer):string;
    procedure CheckCalc(b, e:integer); //开始月份| 结束月份

     //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): widestring;
    //按门店销售汇总表
    function GetCompanySQL(chk:boolean=true): string;
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;

  public
    { Public declarations }
    HasChild:boolean;
    procedure CreateGrid;
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation
uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, ufrmSelectGoodSort, ufrmCostCalc;
{$R *.dfm}

procedure TfrmJxcTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
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

  HasChild := (ShopGlobal.GetZQueryFromName('CA_SHOP_INFO').RecordCount>1);
  rzPage.Pages[0].TabVisible := HasChild;
  rzPage.Pages[1].TabVisible := HasChild;
  if not HasChild then
    rzPage.ActivePageIndex := 2
  else
    rzPage.ActivePageIndex := 0;
  CreateGrid;
  RefreshColumn;
end;

function TfrmJxcTotalReport.GetGroupSQL(chk:boolean=true): widestring;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  strWhere:='';
  if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  
  //月份日期:
  if (P1_D1.asString<>'') and (P1_D1.asString=P1_D2.asString) then
     strWhere:=' and A.MONTH='+P1_D1.asString
  else if P1_D1.asString<P1_D2.asString then
     strWhere:=' and A.MONTH>='+P1_D1.asString+' and A.MONTH<='+P1_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

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
  if (trim(fndP1_SORT_ID.Text)<>'')  and (trim(sid1)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' and C.RELATION_ID='''+srid1+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //检测是否计算
  CheckCalc(strtoInt(P1_D1.asString),StrtoInt(P1_D2.asString));
  mx := GetMaxMonth(StrtoInt(P1_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
    ',sum(DBIN_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8 and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID'
    );
end;

function TfrmJxcTotalReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmJxcTotalReport.actFindExecute(Sender: TObject);
var
  strSql: string;
  rs:TADODataSet;
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
        strSql := GetCompanySQL;
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

function TfrmJxcTotalReport.GetCompanySQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  strWhere:='';
  if P2_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  
  //月份日期:
  if (P2_D1.asString<>'') and (P2_D1.asString=P2_D2.asString) then
     strWhere:=' and A.MONTH='+P2_D1.asString
  else if P2_D1.asString<P2_D2.asString then
     strWhere:=' and A.MONTH>='+P2_D1.asString+' and A.MONTH<='+P2_D2.asString+' '
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
  if (trim(fndP2_SORT_ID.Text)<>'')  and (trim(sid2)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' and C.RELATION_ID='''+srid2+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //检测是否计算
  CheckCalc(strtoInt(P2_D1.asString),StrtoInt(P2_D2.asString));
  mx := GetMaxMonth(StrtoInt(P2_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
    ',sum(DBIN_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
    );
end;

function TfrmJxcTotalReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab,lv:widestring;
  mx:string;
begin
  result:='';
  strWhere:='';
  if P3_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  
  //月份日期:
  if (P3_D1.asString<>'') and (P3_D1.asString=P3_D2.asString) then
     strWhere:=' and A.MONTH='+P3_D1.asString
  else if P3_D1.asString<P3_D2.asString then
     strWhere:=' and A.MONTH>='+P3_D1.asString+' and A.MONTH<='+P3_D2.asString+' '
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
      GoodTab:='VIW_GOODSINFO_SORTEXT';
      lv := ',C.LEVEL_ID';
    end;
  else
  GoodTab:='VIW_GOODSINFO';
  end;
  //检测是否计算
  CheckCalc(strtoInt(P3_D1.asString),StrtoInt(P3_D2.asString));
  mx := GetMaxMonth(StrtoInt(P3_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',sum(DBIN_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID';

  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
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
          ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
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
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 '+
          'union all '+
          'select distinct RELATION_ID,cast(RELATION_ID as varchar) as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID and r.LEVEL_ID like j.LEVEL_ID'+GetStrJoin(Factor.iDbType)+'''%'' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
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
        ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
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
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
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
        ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
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
        ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j left outer join ('+
        'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='''+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+''''+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
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
  strWhere:='';
  if P4_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  
  //月份日期:
  if (P4_D1.asString<>'') and (P4_D1.asString=P4_D2.asString) then
     strWhere:=' and A.MONTH='+P4_D1.asString
  else if P4_D1.asString<P4_D2.asString then
     strWhere:=' and A.MONTH>='+P4_D1.asString+' and A.MONTH<='+P4_D2.asString+' '
  else
     Raise Exception.Create('结束月结不能小于开始月份...');

  //商品分类:
  if (trim(fndP4_SORT_ID.Text)<>'')  and (trim(sid4)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' and C.RELATION_ID='''+srid4+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

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
  if (trim(fndP4_SORT_ID.Text)<>'')  and (trim(sid1)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' and C.RELATION_ID='''+srid1+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

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
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_CST)<>0 then sum(SALE_PRF)/sum(SALE_CST)*100 else 0 end SALE_RATE '+
    ',sum(DBIN_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID';

  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '
    );
  result := 'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+result+') j '+
            'left outer join VIW_BARCODE b '+
            'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
            'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID ';
  result := result +  ' order by j.GODS_CODE';
end;

procedure TfrmJxcTotalReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.asString := P1_D1.asString;
  P2_D2.asString := P1_D2.asString;
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

procedure TfrmJxcTotalReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.asString := P2_D1.asString;
  P3_D2.asString := P2_D2.asString;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;

  fndP3_SHOP_TYPE.ItemIndex := fndP2_SHOP_TYPE.ItemIndex;
  fndP3_SHOP_VALUE.KeyValue := fndP2_SHOP_VALUE.KeyValue;
  fndP3_SHOP_VALUE.Text := fndP2_SHOP_VALUE.Text;

  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('SHOP_ID').AsString;
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('SHOP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);

end;

procedure TfrmJxcTotalReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  P4_D1.asString := P3_D1.asString;
  P4_D2.asString := P3_D2.asString;

//  fndP4_TYPE_ID.ItemIndex := fndP3_TYPE_ID.ItemIndex;

  fndP4_SHOP_TYPE.ItemIndex := fndP3_SHOP_TYPE.ItemIndex;
  fndP4_SHOP_VALUE.KeyValue := fndP3_SHOP_VALUE.KeyValue;
  fndP4_SHOP_VALUE.Text := fndP3_SHOP_VALUE.Text;

  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_SHOP_ID.KeyValue := fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text := fndP3_SHOP_ID.Text;
  
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
  s:string;
  c:integer;
begin
  inherited;
{  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '月份：'+P1_D1.asString+' 至 '+P1_D2.asString;
      if fndP1_GROUP_ID <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP1_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '库存选项：不显示不管理库存的商品';
           inc(c);
         end;
      if trim(fndP1_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP1_SORT_ID.Text;
           inc(c);
         end;
      if fndP1_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP1_TYPE_ID.Text+'：'+fndP1_STAT_ID.Text;
           inc(c);
         end;
      if fndP1_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP1_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  1:begin
      c := 0;
      inc(c);
      s := '月份：'+P2_D1.asString+' 至 '+P2_D2.asString;
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP2_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '库存选项：不显示不管理库存的商品';
           inc(c);
         end;
      if trim(fndP2_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP2_SORT_ID.Text;
           inc(c);
         end;
      if fndP2_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP2_TYPE_ID.Text+'：'+fndP2_STAT_ID.Text;
           inc(c);
         end;
      if fndP2_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP2_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  2:begin
      c := 0;
      inc(c);
      s := '月份：'+P3_D1.asString+' 至 '+P3_D2.asString;
      if fndP3_SHOP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP3_SHOP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP3_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '库存选项：不显示不管理库存的商品';
           inc(c);
         end;
      if trim(fndP3_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示级别：'+fndP3_SORT_ID.Text;
           inc(c);
         end;
      if fndP3_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP3_TYPE_ID.Text+'：'+fndP3_STAT_ID.Text;
           inc(c);
         end;
      if fndP3_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP3_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  3:begin
      c := 0;
      inc(c);
      s := '月份：'+P4_D1.asString+' 至 '+P4_D2.asString;
      if fndP4_SHOP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP4_SHOP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP4_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '库存选项：不显示不管理库存的商品';
           inc(c);
         end;
      if trim(fndP4_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP4_SORT_ID.Text;
           inc(c);
         end;
      if fndP4_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP4_TYPE_ID.Text+'：'+fndP4_STAT_ID.Text;
           inc(c);
         end;
      if fndP4_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP4_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  4:begin
      c := 0;
      inc(c);
      s := '月份：'+P5_D1.asString+' 至 '+P5_D2.asString;
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店类型：'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP5_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
      if fndP5_GODS_ID.asString<>'' then
         PrintDBGridEh1.Title.Text := '商品名称：'+ fndP5_GODS_ID.Text;
    end;
  end;
  }
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
  Column:TColumnEh;
  rs:TZQuery;
begin
    rs := Global.GetZQueryFromName('STO_CHANGECODE'); 
    rs.First;
    while not rs.Eof do
      begin
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
        Column.Title.Caption := rs.Fields[1].AsString+'|数量';
        Column.Width := 61;
        Column.Index := DBGridEh1.Columns.Count -4;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|金额';
        Column.Width := 74;
        Column.Index := DBGridEh1.Columns.Count -4;

        Column := DBGridEh2.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
        Column.Title.Caption := rs.Fields[1].AsString+'|数量';
        Column.Width := 61;
        Column.Index := DBGridEh2.Columns.Count -4;
        Column := DBGridEh2.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|金额';
        Column.Width := 74;
        Column.Index := DBGridEh2.Columns.Count -4;

        Column := DBGridEh3.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
        Column.Title.Caption := rs.Fields[1].AsString+'|数量';
        Column.Width := 61;
        Column.Index := DBGridEh3.Columns.Count -4;
        Column := DBGridEh3.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|金额';
        Column.Width := 74;
        Column.Index := DBGridEh3.Columns.Count -4;

        Column := DBGridEh4.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
        Column.Title.Caption := rs.Fields[1].AsString+'|数量';
        Column.Width := 61;
        Column.Index := DBGridEh4.Columns.Count -4;
        Column := DBGridEh4.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|金额';
        Column.Width := 74;
        Column.Index := DBGridEh4.Columns.Count -4;

        rs.Next;
      end;
end;

procedure TfrmJxcTotalReport.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH>=:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       TfrmCostCalc.StartCalc(self);
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

end.

