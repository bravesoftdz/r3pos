unit ufrmSaleTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar;

type
  TfrmSaleTotalReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label23: TLabel;
    Label32: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label43: TLabel;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Label39: TLabel;
    fndP1_GUIDE_USER: TzrComboBoxList;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    actTemplate: TAction;
    Label21: TLabel;
    fndP1_SHOP_ID: TzrComboBoxList;
    btnDelete: TRzBitBtn;
    Label40: TLabel;
    fndP1_SALES_TYPE: TcxComboBox;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnEditClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    vBegDate,            //查询开始日期
    vEndDate: integer;   //查询结束日期
    RckMaxDate: integer; //台帐最大日期
    sid1,srid1,SortName:string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    { Public declarations }
    Factory:TReportFactory;
    Lock:boolean;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;   //5555
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
  end;
implementation
uses ufrmDefineReport,ufnUtil,uShopUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar;
{$R *.dfm}

procedure TfrmSaleTotalReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE1,'3','1') then
     begin
       load;
     end;
end;

procedure TfrmSaleTotalReport.load;
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
        w := w+''',''+ROLES+'','' like ''%,'+list[i]+',%''';
      end;
    if w <> '' then w := ' and ('+w+')';
    end;
    rs.Close;
    rs.SQL.Text := 'select REPORT_ID,REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''1'' '+w;
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmSaleTotalReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmSaleTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP1_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  Factory := TReportFactory.Create('1');
  Factory.DataSet := TZQuery.Create(nil);
  load;
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label23.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;
  {2011.08.25 加了DataRight后关闭
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP1_SHOP_ID.Properties.ReadOnly := False;
    fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP1_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    fndP1_SHOP_ID.Properties.ReadOnly := True;
  end; }
  btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
end;

procedure TfrmSaleTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  Factory.DataSet.Free;
  Factory.Free;
  inherited;

end;

procedure TfrmSaleTotalReport.actFindExecute(Sender: TObject);
var strSql:string;
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if Factory.DataSet.Active then Factory.DataSet.Close;
  strSql := GetGodsSQL;
  if strSql='' then Exit;
  TZQuery(Factory.DataSet).SQL.Text:= strSql;
  frmPrgBar.Show;
  frmPrgBar.Update;
  frmPrgBar.WaitHint := '准备数据源...';
  frmPrgBar.Precent := 0;
  try
    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;
end;

procedure TfrmSaleTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';

end;

procedure TfrmSaleTotalReport.fndP1_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;

end;

procedure TfrmSaleTotalReport.btnEditClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.EditReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE1) then
     begin
       load;
     end;

end;

function TfrmSaleTotalReport.GetGodsSQL(chk: boolean): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,strCnd,ShopCnd,strWhere,GoodTab,SQLData: string;
begin
  strCnd:='';
  ShopCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
  //销售类型：
  if fndP1_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP1_SALES_TYPE.Properties.Items.Objects[fndP1_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //门店条件
  if (fndP1_CLIENT_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';
    StrCnd:=' and CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';
  end;
  //门店条件
  if (fndP1_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
  end;
  //部门条件
  if (fndP1_DEPT_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
    StrCnd:=' and DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
  end;
  //业务条件
  if (fndP1_GUIDE_USER.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.GUIDE_USER='''+fndP1_GUIDE_USER.AsString+''' ';
    StrCnd:=' and GUIDE_USER='''+fndP1_GUIDE_USER.AsString+''' ';
  end;

  //查询主数据: 过滤企业ID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and SALES_DATE='+InttoStr(vBegDate)+' '  //子条件
    else
      StrCnd:=StrCnd+' and SALES_DATE>='+InttoStr(vBegDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //总条件
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //总条件
  end else
  begin
    StrCnd:=StrCnd+' and SALES_DATE>'+InttoStr(RckMaxDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //门店所属行政区域|门店类型:
  if trim(fndP1_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
       end;
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;

  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;

  //商品分类:
  if (trim(fndP1_SORT_ID.Text)<>'')  and (trim(srid1)<>'') then
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

  if RckMaxDate < vBegDate then      //--[全部查询视图]
  begin
    SQLData:='(select TENANT_ID,SHOP_ID,DEPT_ID,IS_PRESENT,CLIENT_ID,GUIDE_USER,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,'+
             'TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF '+
             ' from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  end else
  if RckMaxDate >= vEndDate then //--[全部查询台帐表]
    SQLData:='RCK_C_GOODS_DAYS'
  else
  begin
    SQLData :=
      '(select TENANT_ID,SHOP_ID,DEPT_ID,IS_PRESENT,CLIENT_ID,GUIDE_USER,CREA_DATE,GODS_ID,SALE_AMT,SALE_MNY,SALE_TAX,SALE_RTL,SALE_CST,SALE_AGO,SALE_PRF from RCK_C_GOODS_DAYS '+
      ' where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,DEPT_ID,IS_PRESENT,CLIENT_ID,GUIDE_USER,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,'+
      ' TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF '+
      ' from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,isnull(A.DEPT_ID,''#'') as DEPT_ID,isnull(A.GUIDE_USER,''#'') as GUIDE_USER,isnull(A.CLIENT_ID,''#'') as CLIENT_ID,isnull(B.REGION_ID,''#'') as SREGION_ID,A.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',sum(SALE_AMT*1.00/'+UnitCalc+') as SALE_AMT '+    //销售数量
    ',case when sum(SALE_AMT)<>0 then cast(isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as decimal(18,3))*1.00/cast(sum(SALE_AMT*1.00/'+UnitCalc+')as decimal(18,3)) else 0 end as SALE_PRC '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+   //价税合计
    ',sum(SALE_MNY) as SALE_MNY '+  //未税金额
    ',sum(SALE_TAX) as SALE_TAX '+  //税额
    ',sum(SALE_RTL) as SALE_RTL '+  //零售金额，暂时没使用
    ',sum(SALE_PRF) as SALE_ALLPRF '+  //毛利    
    ',case when sum(SALE_AMT)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRF '+ //单位毛利
    ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_AGO) as SALE_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,isnull(A.DEPT_ID,''#''),isnull(A.GUIDE_USER,''#''),isnull(A.CLIENT_ID,''#''),A.SHOP_ID,isnull(B.REGION_ID,''#''),B.SHOP_NAME,B.SHOP_TYPE';

  strSql :=
    'select j.*,a.CLIENT_CODE,'+
    'r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME as GODS_ID_TEXT,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'r')+' as UNIT_ID,'+
    'r.SORT_ID1,r.RELATION_ID as SORT_ID24,r.SORT_ID1 as SORT_ID21,r.SORT_ID1 as SORT_ID22,r.SORT_ID1 as SORT_ID23,r.SORT_ID2,r.SORT_ID3,r.SORT_ID4,r.SORT_ID5,r.SORT_ID6,r.SORT_ID7,r.SORT_ID8,r.SORT_ID9,r.SORT_ID10,'+
    'r.SORT_ID11,r.SORT_ID12,r.SORT_ID13,r.SORT_ID14,r.SORT_ID15,r.SORT_ID16,r.SORT_ID17,r.SORT_ID18,r.SORT_ID19,r.SORT_ID20,isnull(a.CLIENT_NAME,''不记名客户'') as CLIENT_ID_TEXT,'+
    'isnull(a.REGION_ID,''#'') as CREGION_ID1,isnull(a.REGION_ID,''#'') as CREGION_ID2,'+
    'isnull(a.REGION_ID,''#'') as CREGION_ID,'+
    'j.SREGION_ID as SREGION_ID1,j.SREGION_ID as SREGION_ID2 '+
    'from ('+strSql+') j '+
    'inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    'left outer join VIW_CUSTOMER a on j.TENANT_ID=a.TENANT_ID and j.CLIENT_ID=a.CLIENT_ID ';

  strSql :=
    'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
    ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' ';
    
  result:=ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmSaleTotalReport.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if adoReport1.Fields[2].AsInteger = 1 then
     Background := $00E7E2E3;
end;

procedure TfrmSaleTotalReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if (Column.Field.Index>2) and not VarIsNull(Factory.Footer[Column.Field.Index-3].Value) and not VarIsClear(Factory.Footer[Column.Field.Index-3].Value) then
     Text := formatFloat('#0.00',Factory.Footer[Column.Field.Index-3].Value);
end;

procedure TfrmSaleTotalReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE1) then
     begin
       load;
     end;

end;

procedure TfrmSaleTotalReport.PrintBefore;
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

function TfrmSaleTotalReport.AddReportReport(TitleList: TStringList;
  PageNo: string): string;
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

end.
