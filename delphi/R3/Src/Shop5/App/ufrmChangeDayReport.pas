unit ufrmChangeDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

type
  TfrmChangeDayReport = class(TframeBaseReport)
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
    RzBitBtn2: TRzBitBtn;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    adoReport5: TZQuery;
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
    procedure actPriorExecute(Sender: TObject);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
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
    procedure DBGridEh5DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    vBegDate,          //查询开始日期
    vEndDate: integer; //查询结束日期
    RckMaxDate: integer;  //台帐最大日期

    GodsID: string;       //双点击DBGridEh的传递变量
    FCodeId: string;      //调整单的类型ID
    FCodeName: string;    //调整单的类型名称
    SortName: string;     //商品分类名称: 
    sid1,sid2,sid4,sid5:string;      //商品分类ID
    srid1,srid2,srid4,srid5:string;  //商品分类REGLATION_ID

    //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
    //按商品销售流水表
    function GetGlideSQL(chk:boolean=true): string;

    procedure SetCodeId(const Value: string); //设置调整单的单据类型ID
    function  GetRCKFields: string;  //根据CodeId返回台账表的查询字段:
    function  GetVIWFields: string;  //根据CodeId返回Change视图的查询字段:
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property CodeId:string read FCodeId write SetCodeId;
    property CodeName: string read FCodeName;     //调整单: 类型名称
    property RCKFields: string read GetRCKFields;  //根据CodeId返回台账表的查询字段:
    property VIWFields: string read GetVIWFields;  //根据CodeId返回Change视图的查询字段:
  end;


implementation
  uses
    uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;

  {$R *.dfm}

procedure TfrmChangeDayReport.FormCreate(Sender: TObject);
var
  rs: TZQuery;
begin
  inherited;
  TDbGridEhSort.InitForm(self);

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


  SetRzPageActivePage;  //设置默认RzPage
  RefreshColumn;

  //添加DeptID
  rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if (rs<>nil) and (rs.Active) and (not rs.IsEmpty) then
    AddDBGridEhColumnItems(DBGridEh5, rs, 'DEPT_ID','DEPT_ID','DEPT_NAME');

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP3_SHOP_ID.Properties.ReadOnly := False;
    fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP3_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
    fndP3_SHOP_ID.Properties.ReadOnly := True;

    fndP4_SHOP_ID.Properties.ReadOnly := False;
    fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP4_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP4_SHOP_ID.Style);
    fndP4_SHOP_ID.Properties.ReadOnly := True;

    fndP5_SHOP_ID.Properties.ReadOnly := False;
    fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP5_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP5_SHOP_ID.Style);
    fndP5_SHOP_ID.Properties.ReadOnly := True;
  end;
  //2011.04.22 Add 设置查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh2, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh3, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh4, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh5, ['COST_PRICE','COST_MONEY','PROFIT_MONEY']);      
  end; 
end;

function TfrmChangeDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  if P1_D1.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+'  ';

  //查询主数据:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate);
    strWhere:=strWhere+' and A.CREA_DATE='+inttoStr(vBegDate)+' ';
  end else if vBegDate<vEndDate then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
    strWhere:=strWhere+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';  
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
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData:='RCK_GOODS_DAYS'
    // SQLData:='(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+'  and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');  
  //备注: MNY: 当时进货的金额; RTL: 零售金额; CST: 成本价
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID '+
    ',B.REGION_ID as REGION_ID '+
    ',sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+   //数量
    ',case when sum(CHANGE'+CodeId+'_AMT)<>0 then cast(sum(CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--均价
    ',sum(CHANGE'+CodeId+'_RTL) as AMONEY '+      //--可销售额
    ',sum(CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--进货成本
    ',sum(CHANGE'+CodeId+'_RTL)-sum(CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //差额毛利
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  //关联行政区域
  strSql:=
    'select j.* '+
    ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';
  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmChangeDayReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmChangeDayReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //按地区汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
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
  GodsID:='';  
end;

function TfrmChangeDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,strWhere,StrCnd,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  if P2_D1.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P2_D1.Date>P2_D2.Date  then  Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

  //查询主数据:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate);
    strWhere:=strWhere+' and A.CREA_DATE='+inttoStr(vBegDate)+' ';
  end else if vBegDate<vEndDate then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
    strWhere:=strWhere+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';  
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
  if (trim(fndP2_SORT_ID.Text)<>'')  and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid2+' ';
     else
       strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';    

  //取日结帐最大日期:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[全部查询视图]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData:='RCK_GOODS_DAYS'
    // SQLData:='(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');  
  //备注: MNY: 当时进货的金额; RTL: 零售金额; CST: 成本价
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID'+
    ',B.SHOP_ID as SHOP_ID '+
    ',sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //数量
    ',case when sum(CHANGE'+CodeId+'_AMT)<>0 then cast(sum(CHANGE'+CodeId+'_RTL) as decimal(10,3))*1.00/cast(sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--均价
    ',sum(CHANGE'+CodeId+'_RTL) as AMONEY '+      //--可销售额
    ',sum(CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--进货成本
    ',sum(CHANGE'+CodeId+'_RTL)-sum(CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //差额毛利
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.SHOP_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
    );  
end;

function TfrmChangeDayReport.GetSortSQL(chk:boolean=true): string;
var
  UnitCalc,JoinCnd: string;  //单位计算关系
  strSql,strCnd,strWhere,lv,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;

  if P3_D1.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P3_D1.Date>P3_D2.Date  then  Raise Exception.Create('结束日期不能小于开始日期...');
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('请选择报表类型...'); //商品指标:

  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';
  //门店条件
  if (fndP3_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
  end;

  //查询主数据:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate);
    strWhere:=strWhere+' and A.CREA_DATE='+inttoStr(vBegDate)+' ';
  end else if vBegDate<vEndDate then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
    strWhere:=strWhere+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';  
  end;
  
  //门店所属行政区域|门店类型:
  if (fndP3_SHOP_VALUE.AsString<>'') then
    begin
      case fndP3_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
      end;
    end;

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
  if RckMaxDate < vBegDate then      //--[全部查询视图]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData:='RCK_GOODS_DAYS'
    // SQLData:='(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');  
  //备注: MNY: 当时进货的金额; RTL: 零售金额; CST: 成本价
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
    ',sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //数量
    ',case when sum(CHANGE'+CodeId+'_AMT)<>0 then cast(sum(CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--均价
    ',sum(CHANGE'+CodeId+'_RTL) as AMONEY '+      //--可销售额
    ',sum(CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--进货成本
    ',sum(CHANGE'+CodeId+'_RTL)-sum(CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //差额毛利
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
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
          ' sum(AMOUNT) as AMOUNT '+      //数量
          ',case when sum(AMOUNT)<>0 then sum(AMONEY)/sum(AMOUNT) else 0 end as APRICE '+  //--均价
          ',sum(AMONEY) as AMONEY '+      //--可销售额
          ',sum(COST_MONEY) as COST_MONEY '+  //--进货成本
          ',sum(AMONEY)-sum(COST_MONEY) as PROFIT_MONEY '+  //差额毛利
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID  '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+
          'select distinct RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'') ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(AMOUNT) as AMOUNT '+      //数量
          ',case when sum(AMOUNT)<>0 then sum(AMONEY)/sum(AMOUNT) else 0 end as APRICE '+  //--均价
          ',sum(AMONEY) as AMONEY '+      //--可销售额
          ',sum(COST_MONEY) as COST_MONEY '+  //--进货成本
          ',sum(AMONEY)-sum(COST_MONEY) as PROFIT_MONEY '+  //差额毛利
          ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME '+
        ' from ('+strSql+') j left outer join VIW_CLIENTINFO r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(AMOUNT) as AMOUNT '+      //数量
          ',case when sum(AMOUNT)<>0 then sum(AMONEY)/sum(AMOUNT) else 0 end as APRICE '+  //--均价
          ',sum(AMONEY) as AMONEY '+      //--可销售额
          ',sum(COST_MONEY) as COST_MONEY '+    //--进货成本
          ',sum(AMONEY)-sum(COST_MONEY) as PROFIT_MONEY '+  //差额毛利
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j '+
          ' left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+') r '+
          ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID '+
          ' group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmChangeDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,strWhere,strCnd,ShopCnd,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  ShopCnd:='';
  if P4_D1.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';
  //门店条件
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;

  //查询主数据:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //结束日期
  if (vBegDate>0) and (vBegDate=vEndDate) then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate);
    strWhere:=strWhere+' and A.CREA_DATE='+inttoStr(vBegDate)+' ';
  end else if vBegDate<vEndDate then
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
    strWhere:=strWhere+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';  
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
  if RckMaxDate < vBegDate then      //--[全部查询视图]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[全部查询台帐表]
    SQLData:='RCK_GOODS_DAYS'
    // SQLData:='(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[开始日期到 台账最大日期 查询台账表]  Union  [台帐最大日期  到 结束日期]
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');  
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID '+
    ',A.GODS_ID as GODS_ID '+
    ',sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //数量
    ',case when sum(CHANGE'+CodeId+'_AMT)<>0 then cast(sum(CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--均价
    ',sum(CHANGE'+CodeId+'_RTL) as AMONEY '+      //--可销售额
    ',sum(CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--进货成本
    ',sum(CHANGE'+CodeId+'_RTL)-sum(CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //差额毛利
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
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

  Result :=  ParseSQL(Factor.iDbType,strSql);
end;

function TfrmChangeDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create(CodeName+'日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('调整日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CHANGE_CODE='''+CodeId+''' ';
  //GodsID不为空(DBGridEh4双击查看明细数据显示)
  if trim(GodsID)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  if fndP5_SHOP_ID.AsString<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

  //月份日期:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
    strWhere:=strWhere+' and A.CHANGE_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
    strWhere:=strWhere+' and A.CHANGE_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.CHANGE_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';

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
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.CHANGE_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.DEPT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+
    ',A.CHANGE_TYPE '+
    ',-A.AMOUNT as AMOUNT'+               //--数量
    ',A.APRICE '+               //--零售价
    ',-A.RTL_MONEY as AMONEY '+  //--零售金额
    ',A.COST_PRICE '+           //--成本价
    ',-A.COST_MONEY as COST_MONEY '+           //--成本金额
    ',-(A.RTL_MONEY-A.COST_MONEY) as PROFIT_MONEY '+                   //--差额毛利
    ',B.SHOP_NAME '+
    'from VIW_CHANGEDATA A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';

  strSql :=
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by j.CHANGE_DATE,r.GODS_CODE ';

  Result:= ParseSQL(Factor.iDbType, strSql);
end;

procedure TfrmChangeDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  sid2:=sid1;
  srid2:=srid1;
  DoAssignParamsValue(w1,RzPanel9);
end;

procedure TfrmChangeDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  DoAssignParamsValue(RzPanel9,RzPanel11);
end;

procedure TfrmChangeDayReport.DBGridEh3DblClick(Sender: TObject);
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

  DoAssignParamsValue(RzPanel11,RzPanel14);  
end;

procedure TfrmChangeDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmChangeDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('请选择查询流水帐的商品...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  DoAssignParamsValue(RzPanel14,RzPanel17);
end;

procedure TfrmChangeDayReport.PrintBefore;
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

procedure TfrmChangeDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.actPriorExecute(Sender: TObject);
begin
  if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;

end;

procedure TfrmChangeDayReport.SetCodeId(const Value: string);
var
  i:integer;
  rs:TZQuery;
begin
  FCodeId := Value;
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  if rs.locate('CHANGE_CODE',Value,[]) then
  begin
    FCodeName:=trim(rs.FieldbyName('CHANGE_NAME').asString);
    Caption := '商品'+rs.FieldbyName('CHANGE_NAME').asString + '报表';
    lblToolCaption.Caption := '商品'+rs.FieldbyName('CHANGE_NAME').asString + '报表';
    for i:=0 to RzPage.PageCount-1 do
     RzPage.Pages[i].Caption := StringReplace(RzPage.Pages[i].Caption,'调整',rs.FieldbyName('CHANGE_NAME').asString,[rfReplaceAll]);
  end else
    Raise Exception.Create('传入的单据类型错误');
end;

procedure TfrmChangeDayReport.fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  sid5 := '';
  srid5 := '';
  fndP5_SORT_ID.Text := '';
end;

function TfrmChangeDayReport.GetRCKFields: string;
begin
  //备注: MNY: 当时进货的金额; RTL: 零售金额; CST: 成本价
  result:=' TENANT_ID,SHOP_ID,GODS_ID,CREA_DATE,-CHANGE'+CodeId+'_AMT,-CHANGE'+CodeId+'_RTL,-CHANGE'+CodeId+'_CST ';
end;

function TfrmChangeDayReport.GetVIWFields: string;
begin
  result:=' TENANT_ID,SHOP_ID,GODS_ID,CHANGE_DATE as CREA_DATE,-PARM'+CodeId+'_AMOUNT as CHANGE'+CodeId+'_AMT,-PARM'+CodeId+'_RTL as CHANGE'+CodeId+'_RTL,-PARM'+CodeId+'_MONEY as CHANGE'+CodeId+'_CST ';
end;

procedure TfrmChangeDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmChangeDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
  begin
    TitleList.add(CodeName+'日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
  end;
  
  //继承基类:
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmChangeDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_ID' then Text := '合计:'+Text+'笔';
end;

procedure TfrmChangeDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmChangeDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmChangeDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmChangeDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmChangeDayReport.DBGridEh5DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  DBGridDrawColumn(Sender,Rect,DataCol,Column,State,'GLIDE_NO');
end;

end.

