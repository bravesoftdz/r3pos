unit ufrmStockDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

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
    Label41: TLabel;
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
    fndP1_RB_ALL: TcxRadioButton;
    fndP1_InStock: TcxRadioButton;
    fndP1_ReturnStock: TcxRadioButton;
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
    Label3: TLabel;
    fndP2_RB_ALL: TcxRadioButton;
    fndP2_InStock: TcxRadioButton;
    fndP2_ReturnStock: TcxRadioButton;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    fndP3_SHOP_ID: TzrComboBoxList;
    fndP3_REPORT_FLAG: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label4: TLabel;
    fndP3_RB_ALL: TcxRadioButton;
    fndP3_InStock: TcxRadioButton;
    fndP3_ReturnStock: TcxRadioButton;
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
    Label16: TLabel;
    fndP4_RB_ALL: TcxRadioButton;
    fndP4_InStock: TcxRadioButton;
    fndP4_ReturnStock: TcxRadioButton;
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
    Label29: TLabel;
    fndP5_ALL: TcxRadioButton;
    fndP5_InStock: TcxRadioButton;
    fndP5_ReturnStock: TcxRadioButton;
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
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    SortName: string;
    sid1,sid2,sid4,sid5: string;
    srid1,srid2,srid4,srid5: string;
    groupid1,groupid2,groupid3,groupid4,groupid5: string;  //管理群组ID
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
    function GetUnitIDIdx: integer;
  public
    { Public declarations }
    HasChild:boolean;
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property  UnitIDIdx: integer read GetUnitIDIdx; //当前统计计量方式    
  end;

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

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  RefreshColumn;
end;

function TfrmStockDayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid,GoodTab: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  
  //月份日期:
  if (P1_D1.Text<>'') and (P1_D1.Date=P1_D2.Date) then
     strWhere:=' and A.MONTH='+FormatDatetime('YYYYMMDD',P1_D1.Date)   
  else if P1_D1.Date<P1_D2.Date then
    strWhere:=' and A.MONTH>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and A.MONTH<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+' '
  else
    Raise Exception.Create('结束月结不能小于开始月份...');//strWhere:=' and A.MONTH>='+P1_D2.asString+' and A.MONTH<='+P1_D1.asString+' ';

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

  //单据类型:
  if fndP1_InStock.Checked then //进货单
    strWhere:=strWhere+''
  else if fndP1_ReturnStock.Checked then //退货单
    strWhere:=strWhere+'';


  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.GROUP_NAME as GROUP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP1_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.GROUP_NAME) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          // 'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by C.GROUP_NAME with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.CODE_NAME,''未分组'') else ''合   计'' end as GROUP_NAME from ('+strSQL+') j '+
          'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8) g on j.GROUP_ID=g.CODE_ID order by j.grp0 desc,j.GROUP_ID';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmStockDayReport.GetRowType: integer;
begin
  result := DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
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
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmStockDayReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  
  //月份日期:
  if (P2_D1.Text<>'') and (P2_D1.Date=P2_D2.Date) then
    strWhere:=' and A.MONTH='+FormatDatetime('YYYYMMDD',P2_D1.Date)
  else if P2_D1.Date<P2_D2.Date then
    strWhere:=' and A.MONTH>='+FormatDatetime('YYYYMMDD',P2_D1.Date)+' and A.MONTH<='+FormatDatetime('YYYYMMDD',P2_D2.Date)+' '
  else
    Raise Exception.Create('结束月结不能小于开始月份...'); 

  //门店所属行政区域|门店类型:
  if (fndP2_SHOP_VALUE.AsString<>'') then
    begin
      case fndP2_TYPE_ID.ItemIndex of
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

  //单据类型:
  if fndP2_InStock.Checked then //进货单
    strWhere:=strWhere+''
  else if fndP2_ReturnStock.Checked then //退货单
    strWhere:=strWhere+'';
        
  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.COMP_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
          // 'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''未分组'') else ''合   计'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmStockDayReport.GetSortSQL(chk:boolean=true): string;
var
  GoodTab, strSql,strWhere: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  //月份日期:
  if (P3_D1.Text<>'') and (P3_D1.Date=P3_D2.Date) then
     strWhere:=' and A.MONTH='+FormatDatetime('YYYYMMDD',P3_D1.Date)
  else if P3_D1.Date<P3_D2.Date then
    strWhere:=' and A.MONTH>='+FormatDatetime('YYYYMMDD',P3_D1.Date)+' and A.MONTH<='+FormatDatetime('YYYYMMDD',P3_D2.Date)+' '
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

  //单据类型:
  if fndP3_InStock.Checked then //进货单
    strWhere:=strWhere+''
  else if fndP3_ReturnStock.Checked then //退货单
    strWhere:=strWhere+'';    

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select s.SORT_ID,case when isnull(s.SORT_ID,'''')='''' then 1 else 0 end as grp0,sum(AMOUNT) as AMOUNT,sum(AMONEY) as AMONEY,sum(NOTAX_MONEY) as NOTAX_MONEY,sum(COST_MONEY) as COST_MONEY,sum(PROFIT_MONEY) as PROFIT_MONEY,'+
          'sum(NEW_COST_MONEY) as NEW_COST_MONEY,sum(NEW_PROFIT_MONEY) as NEW_PROFIT_MONEY from ('+strSQL+') s left outer join ('+
          'select D.LEVEL_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY ' + //--毛利
          ',sum(SAL_AMOUNT*isnull(E.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(E.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,PUB_GOODSSORT D,VIW_PRICE_INFO E ' +
          // 'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.SORT_ID=D.SORT_ID and A.GODS_ID=E.GODS_ID and A.COMP_ID=E.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +' group by D.LEVEL_ID) js on s.LEVEL_ID=substring(js.LEVEL_ID,1,len(s.LEVEL_ID)) '+
          ' group by s.SORT_ID';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then space((g.SORT_TYPE-1)*2)+IsNull(G.SORT_NAME,''未分类'') else ''合   计'' end as SORT_NAME,g.LEVEL_ID from ('+strSQL+') j '+
          'left outer join PUB_GOODSSORT g on j.SORT_ID=g.SORT_ID order by j.grp0 desc,g.LEVEL_ID';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmStockDayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  //月份日期:
  if (P4_D1.Text<>'') and (P4_D1.Date=P4_D2.Date) then
     strWhere:=' and A.MONTH='+FormatDatetime('YYYYMMDD',P4_D1.Date)
  else if P4_D1.Date<P4_D2.Date then
    strWhere:=' and A.MONTH>='+FormatDatetime('YYYYMMDD',P4_D1.Date)+' and A.MONTH<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+' '
  else
    Raise Exception.Create('结束月结不能小于开始月份...');//strWhere:=' and A.MONTH>='+P1_D2.asString+' and A.MONTH<='+P1_D1.asString+' ';

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
  if (trim(fndP4_SORT_ID.Text)<>'')  and (trim(sid4)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' and C.RELATION_ID='''+srid4+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //单据类型:
  if fndP4_InStock.Checked then //进货单
    strWhere:=strWhere+''
  else if fndP4_ReturnStock.Checked then //退货单
    strWhere:=strWhere+'';

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select A.GODS_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          ' when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(A.GODS_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
        //  'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by A.GODS_ID with rollup';
       end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmStockDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  //月份日期:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=' and A.MONTH='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then 
    strWhere:=' and A.MONTH>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.MONTH<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' '
  else
    Raise Exception.Create('结束月结不能小于开始月份...');
    
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
  if (trim(fndP5_SORT_ID.Text)<>'')  and (trim(sid5)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' and C.RELATION_ID='''+srid5+''' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //单据类型:
  if fndP5_InStock.Checked then //进货单
    strWhere:=strWhere+''
  else if fndP5_ReturnStock.Checked then //退货单
    strWhere:=strWhere+'';

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          ' when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as AMOUNT ' + //--数量
          ',sum(SAL_AMONEY) as AMONEY' + //--销售额
          ',sum(SAL_NOTAX) as NOTAX_MONEY ' + //--不含税金额,
          ',sum(SAL_TAX) as TAX_MONEY' + //--销项税额
          ',sum(SAL_COST) as COST_MONEY' + //--成本
          ',sum(SAL_NOTAX)-sum(SAL_COST) as PROFIT_MONEY' + //--毛利
          ',sum(SAL_AMOUNT*isnull(D.NEW_INPRICE,0)) as NEW_COST_MONEY' + //--进价成本
          ',sum(SAL_AMONEY)-sum(isnull(SAL_AMOUNT,0)*isnull(D.NEW_INPRICE,0)) as NEW_PROFIT_MONEY ' + //--进价毛利
          ',grouping(C.COMP_ID) as grp0 '+  //行标识
          'from VIW_SALESDATA A,VIW_GOODSINFO B,CA_COMPANY C,VIW_PRICE_INFO D ' +
      //    'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and A.GODS_ID=D.GODS_ID and A.COMP_ID=D.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(AMOUNT,0)=0 then null else AMONEY/AMOUNT end as APRICE,'+ //均价
          'case when IsNull(AMOUNT,0)=0 then null else PROFIT_MONEY/AMOUNT end as AVG_PROFIT,'+ //单位毛利
          'case when IsNull(NOTAX_MONEY,0)=0 then null else PROFIT_MONEY/NOTAX_MONEY*100 end as PROFIT_RATE,'+ //毛利率
          'case when IsNull(AMONEY,0)=0 then null else NEW_PROFIT_MONEY/AMONEY*100 end as NEW_PROFIT_RATE,'+ //进价毛利率
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''未分组'') else ''合   计'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

procedure TfrmStockDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  //分门店在汇总：
  DoAssignParamsValue(W1,RzPanel9);
  //actFind.OnExecute(nil); 
end;

procedure TfrmStockDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
{  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  fndP3_TYPE_ID.ItemIndex := 0;
  fndP3_STAT_ID.KeyValue := fndP2_STAT_ID.KeyValue;
  fndP3_STAT_ID.Text := fndP2_STAT_ID.Text;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;
  fndP3_CUST_ID.KeyValue := fndP2_CUST_ID.KeyValue;
  fndP3_CUST_ID.Text := fndP2_CUST_ID.Text;
  fndP3_INVOICE_FLAG.ItemIndex := fndP2_INVOICE_FLAG.ItemIndex;

  fndP3_COMP_TYPE.ItemIndex := fndP2_COMP_TYPE.ItemIndex;
  if adoReport2.FieldbyName('grp0').AsInteger = 1 then
     begin
       fndP3_COMP_ID.KeyValue := Global.CompanyID;
       fndP3_COMP_ID.Text := Global.CompanyName;
     end else
  begin
    fndP3_COMP_ID.Text := adoReport2.FieldbyName('COMP_NAME').AsString;
    fndP3_COMP_ID.KeyValue := adoReport2.FieldbyName('COMP_ID').AsString;
  end;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
  }
end;

procedure TfrmStockDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
{
  if adoReport3.IsEmpty then Exit;
  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;
  fndP4_COMP_TYPE.ItemIndex := fndP3_COMP_TYPE.ItemIndex;
  fndP4_TYPE_ID.ItemIndex := fndP3_TYPE_ID.ItemIndex;
  fndP4_STAT_ID.KeyValue := fndP3_STAT_ID.KeyValue;
  fndP4_STAT_ID.Text := fndP4_STAT_ID.Text;
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_INVOICE_FLAG.ItemIndex := fndP3_INVOICE_FLAG.ItemIndex;
  fndP4_CUST_ID.KeyValue := fndP3_CUST_ID.KeyValue;
  fndP4_CUST_ID.Text := fndP3_CUST_ID.Text;
  fndP4_COMP_ID.KeyValue := fndP3_COMP_ID.KeyValue;
  fndP4_COMP_ID.Text := fndP3_COMP_ID.Text;
  sid4 := adoReport3.FieldbyName('LEVEL_ID').AsString;
  if adoReport3.FieldbyName('grp0').AsInteger = 1 then
  fndP4_SORT_ID.Text := '' else
  fndP4_SORT_ID.Text := adoReport3.FieldbyName('SORT_NAME').AsString;
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
  }
end;

procedure TfrmStockDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmStockDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
{
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  P5_D1.Date := P4_D1.Date;
  P5_D2.Date := P4_D2.Date;
  if fndP4_COMP_TYPE.ItemIndex in [0,1] then
     fndP5_COMP_TYPE.ItemIndex := 0
  else
     fndP5_COMP_TYPE.ItemIndex := 1;
  fndP5_UNIT_ID.ItemIndex := fndP4_UNIT_ID.ItemIndex;
  fndP5_INVOICE_FLAG.ItemIndex := fndP4_INVOICE_FLAG.ItemIndex;
  fndP5_CUST_ID.KeyValue := fndP4_CUST_ID.KeyValue;
  fndP5_CUST_ID.Text := fndP4_CUST_ID.Text;
  fndP5_GODS_ID.KeyValue := adoReport4.FieldbyName('GODS_ID').AsString;
  fndP5_GODS_ID.Text := adoReport4.FieldbyName('GODS_NAME').AsString;
  rzPage.ActivePageIndex := 4;
  actFind.OnExecute(nil);

  }
end;

procedure TfrmStockDayReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;
{
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P1_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P1_D2.Date);
      if fndP1_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP1_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP1_CUST_ID.Text;
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
      if fndP1_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP1_INVOICE_FLAG.Text;
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
      s := '日期：'+formatDatetime('YYYY-MM-DD',P2_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P2_D2.Date);
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP2_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP2_CUST_ID.Text;
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
      if fndP2_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP2_INVOICE_FLAG.Text;
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
      s := '日期：'+formatDatetime('YYYY-MM-DD',P3_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P3_D2.Date);
      if fndP3_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP3_COMP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP3_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP3_CUST_ID.Text;
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
      if fndP3_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP3_INVOICE_FLAG.Text;
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
      s := '日期：'+formatDatetime('YYYY-MM-DD',P4_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P4_D2.Date);
      if fndP4_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP4_COMP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP4_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP4_CUST_ID.Text;
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
      if fndP4_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP4_INVOICE_FLAG.Text;
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
      s := '日期：'+formatDatetime('YYYY-MM-DD',P5_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P5_D2.Date);
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店类型：'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP5_CUST_ID.Text;
           inc(c);
         end;
      if fndP5_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP5_INVOICE_FLAG.Text;
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

procedure TfrmStockDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
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

procedure TfrmStockDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

function TfrmStockDayReport.GetUnitIDIdx: integer;
begin
  result:=0;
  if (RzPage.ActivePage=TabSheet1) and (fndP1_UNIT_ID.ItemIndex<>-1) then       //地区进销存统计表
    result:=fndP1_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet2) and (fndP2_UNIT_ID.ItemIndex<>-1) then  //门店进销存统计表
    result:=fndP2_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet3) and (fndP3_UNIT_ID.ItemIndex<>-1) then  //分类进销存统计表
    result:=fndP3_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet4) and (fndP4_UNIT_ID.ItemIndex<>-1) then  //商品进销存统计表
    result:=fndP4_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet5) and (fndP5_UNIT_ID.ItemIndex<>-1) then  //进货商品明细统计表
    result:=fndP5_UNIT_ID.ItemIndex;
end;

end.

