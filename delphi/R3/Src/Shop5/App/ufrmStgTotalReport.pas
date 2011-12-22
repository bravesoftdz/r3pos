unit ufrmStgTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar, ufrmDateControl;

type
  TfrmStgTotalReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    actTemplate: TAction;
    btnDelete: TRzBitBtn;
    RzLabel8: TRzLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    P1_D1: TcxDateEdit;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_ReckType: TcxComboBox;
    Label4: TLabel;
    fndP1_STOR_AMT: TcxComboBox;
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
    BAL_Date: integer;   //查询结束日期
    RckMaxDate: integer; //台帐最大日期
    sid1,srid1,SortName:string;
    procedure DoReckTypeOnChange(Sender: TObject); //
    function AddReportReport(TitleList: TStringList; PageNo: string): string;override; //添加Title
  public
    { Public declarations }
    Factory:TReportFactory;
    Lock:boolean;
    procedure CheckCalc(endDate:integer); //开始月份| 结束月份
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;   //5555
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
  end;

implementation

uses ufrmDefineReport,uShopUtil,ufrmCostCalc,ufnUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar;

  {$R *.dfm}

procedure TfrmStgTotalReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE3,'3','3') then
     begin
       load;
     end;
end;

procedure TfrmStgTotalReport.load;
var
  rs:TZQuery;
  list:TStringList;
  w,CurRole:string;
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
    rs.SQL.Text := 'select REPORT_ID,REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''3'' '+w;
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmStgTotalReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmStgTotalReport.FormCreate(Sender: TObject);
var
  i:integer;
  CmpName:string;
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  fndP1_STOR_AMT.ItemIndex := 0;
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  for i:=0 to ComponentCount-1 do
  begin
    CmpName:=trim(LowerCase(TcxComboBox(Components[i]).Name));
    if Components[i] is TcxComboBox then
    begin
      if (Copy(CmpName,1,4)='fndp') and (RightStr(CmpName,9)='_recktype') then
        TcxComboBox(Components[i]).Properties.OnChange:=DoReckTypeOnChange; 
      TcxComboBox(Components[i]).ItemIndex:=0;
    end;
  end;
  Factory := nil;
  load;
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label12.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;
  //2011.12.22 重开启[若非总店默认当前门店]  
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP1_SHOP_ID.Properties.ReadOnly := False;
    fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP1_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    //fndP1_SHOP_ID.Properties.ReadOnly := True;
  end;
  btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
end;

procedure TfrmStgTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  if Factory<>nil then Factory.Free;
  inherited;

end;

procedure TfrmStgTotalReport.actFindExecute(Sender: TObject);
var strSql:string;
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  adoReport1.Close;
  if Factory<>nil then Factory.Free;
  Factory := TReportFactory.Create('3');
  try
    if Factory.DataSet.Active then Factory.DataSet.Close;
    strSql := GetGodsSQL;
    if strSql='' then Exit;
    TZQuery(Factory.DataSet).SQL.Text:= strSql;
    frmPrgBar.Show;
    frmPrgBar.Update;
    frmPrgBar.WaitHint := '准备数据源...';
    frmPrgBar.Precent := 0;
    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;

end;

procedure TfrmStgTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';

end;

procedure TfrmStgTotalReport.fndP1_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;

end;

procedure TfrmStgTotalReport.btnEditClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.EditReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE3) then
     begin
       load;
     end;

end;

function TfrmStgTotalReport.GetGodsSQL(chk: boolean): string;
var
  UnitCalc: string;
  strSql,strWhere,GoodTab: string;
begin
  //过滤企业ID和查询日期:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);

  //门店所属行政区域|门店类型:
  if (fndP1_SHOP_VALUE.AsString<>'') then
    begin
      case fndP1_SHOP_TYPE.ItemIndex of
      0:begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
    end;

  //门店条件
  if (fndP1_SHOP_ID.AsString<>'') then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';

  if fndP1_ReckType.ItemIndex=0 then
  begin
    case fndP1_STOR_AMT.ItemIndex of
     1: StrWhere := StrWhere + ' and A.AMOUNT<>0';
     2: StrWhere := StrWhere + ' and A.AMOUNT>0';
     3: StrWhere := StrWhere + ' and A.AMOUNT=0';
     4: StrWhere := StrWhere + ' and A.AMOUNT<0';
    end
  end else
  begin
    case fndP1_STOR_AMT.ItemIndex of
     1: StrWhere := StrWhere + ' and A.BAL_AMT<>0';
     2: StrWhere := StrWhere + ' and A.BAL_AMT>0';
     3: StrWhere := StrWhere + ' and A.BAL_AMT=0';
     4: StrWhere := StrWhere + ' and A.BAL_AMT<0';
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
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  //日期条件
  if fndP1_ReckType.ItemIndex=0 then //直接查询库存表:
  begin
    strSql :=
      'select '+
      ' TENANT_ID,GODS_ID,SHOP_ID,SHOP_NAME as SHOP_ID_TEXT,SHOP_TYPE,isnull(REGION_ID,''#'') as SREGION_ID,CALC_BARCODE,GODS_CODE,GODS_NAME as GODS_ID_TEXT,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,UNIT_ID  '+
      ',RELATION_ID as SORT_ID24,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10 '+
      ',SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20 '+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE,B.REGION_ID,c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME,'+
       ' ''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'C')+' as UNIT_ID '+
      ',C.RELATION_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6,C.SORT_ID7,C.SORT_ID8,C.SORT_ID9,C.SORT_ID10 '+
      ',C.SORT_ID11,C.SORT_ID12,C.SORT_ID13,C.SORT_ID14,C.SORT_ID15,C.SORT_ID16,C.SORT_ID17,C.SORT_ID18,C.SORT_ID19,C.SORT_ID20 '+
       ',AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //库存数量
       ',AMONEY as BAL_CST '+     //库存金额
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //零售金额
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,SHOP_ID,SHOP_NAME,SHOP_TYPE,REGION_ID,GODS_ID,CALC_BARCODE,GODS_CODE,GODS_NAME,UNIT_ID '+
      ',RELATION_ID,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10 '+
      ',SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20 ';

    strSql :=
        'select j.*,j.SORT_ID1 as SORT_ID21,j.SORT_ID1 as SORT_ID22,j.SORT_ID1 as SORT_ID23,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME '+
        ',j.SREGION_ID as SREGION_ID1,j.SREGION_ID as SREGION_ID2 '+
        'from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' ';

    result:=ParseSQL(Factor.iDbType, strSql);
  end else
  if fndP1_ReckType.ItemIndex=1 then //直接查询库存表:  
  begin
    if P1_D1.EditValue = null then Raise Exception.Create(' 库存日期不能为空！  ');      
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));
    //检测是否计算
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and A.CREA_DATE in (select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where A.TENANT_ID=DD.TENANT_ID and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GODS_ID,B.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE,isnull(B.REGION_ID,''#'') as SREGION_ID '+
      ',c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME as GODS_ID_TEXT,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'C')+' as UNIT_ID  '+
      ',C.RELATION_ID as SORT_ID24,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6,C.SORT_ID7,C.SORT_ID8,C.SORT_ID9,C.SORT_ID10 '+
      ',C.SORT_ID11,C.SORT_ID12,C.SORT_ID13,C.SORT_ID14,C.SORT_ID15,C.SORT_ID16,C.SORT_ID17,C.SORT_ID18,C.SORT_ID19,C.SORT_ID20 '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,A.GODS_ID,B.SHOP_ID,B.SHOP_NAME,B.SHOP_TYPE,B.REGION_ID,c.BARCODE,c.GODS_CODE,c.GODS_NAME,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'C')+' '+
      ',C.RELATION_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6,C.SORT_ID7,C.SORT_ID8,C.SORT_ID9,C.SORT_ID10 '+
      ',C.SORT_ID11,C.SORT_ID12,C.SORT_ID13,C.SORT_ID14,C.SORT_ID15,C.SORT_ID16,C.SORT_ID17,C.SORT_ID18,C.SORT_ID19,C.SORT_ID20 ';

    strSql :=
      'select j.*,j.SORT_ID1 as SORT_ID21,j.SORT_ID1 as SORT_ID22,j.SORT_ID1 as SORT_ID23,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME '+
      ',j.SREGION_ID as SREGION_ID1,j.SREGION_ID as SREGION_ID2 '+
      ' from ('+strSql+') j '+
      ' left outer join '+
      ' (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
      '   on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
      ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
      '  ';
     
     result:=ParseSQL(Factor.iDbType, strSql);
  end;
end;

procedure TfrmStgTotalReport.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if adoReport1.Fields[2].AsInteger = 1 then
     Background := $00E7E2E3;
end;

procedure TfrmStgTotalReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if (Column.Field.Index>2) and not VarIsNull(Factory.Footer[Column.Field.Index-3].Value) and not VarIsClear(Factory.Footer[Column.Field.Index-3].Value) and VarIsNumeric(Factory.Footer[Column.Field.Index-3].Value) then
     Text := formatFloat('#0.00',Factory.Footer[Column.Field.Index-3].Value)
  else
     Text := '';
end;

procedure TfrmStgTotalReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE3) then
     begin
       load;
     end;

end;

procedure TfrmStgTotalReport.CheckCalc(endDate: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := endDate;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       TfrmCostCalc.TryCalcDayGods(self);
  finally
    rs.Free;
  end;
end;

procedure TfrmStgTotalReport.DoReckTypeOnChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //返回控件Num
  if CmpName<>'' then
  begin
    CmpName:='P'+CmpName+'_D1';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TcxDateEdit) then
    begin
      TcxDateEdit(FindCmp).Visible:=(TcxComboBox(Sender).ItemIndex<>0);
      if (TcxDateEdit(FindCmp).Visible) and (trim(TcxDateEdit(FindCmp).Text)='') then
        TcxDateEdit(FindCmp).Date:=Date();
    end;
  end;
end;

procedure TfrmStgTotalReport.PrintBefore;
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

function TfrmStgTotalReport.AddReportReport(TitleList: TStringList;
  PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  if (FindCmp1<>nil) and (FindCmp1 is TcxDateEdit) and (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp1).EditValue<>null) then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date));
 //门店名称：
 FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_ID');
 if (FindCmp1<>nil) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
   TitleList.Add('门店名称：'+TzrComboBoxList(FindCmp1).Text);
  //管理群组：
  FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_TYPE');  
  FindCmp2:=FindComponent('fndP'+PageNo+'_SHOP_VALUE');   
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList)  and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'')  then
    TitleList.add(TcxComboBox(FindCmp1).Text+'：'+TzrComboBoxList(FindCmp2).Text);
  //商品指标：
  FindCmp1:=FindComponent('fndP'+PageNo+'_TYPE_ID');   
  FindCmp2:=FindComponent('fndP'+PageNo+'_STAT_ID');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList) and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'') then
    TitleList.add(TcxComboBox(FindCmp1).Text+'：'+TzrComboBoxList(FindCmp2).Text);
  //商品分类
  FindCmp1:=FindComponent('fndP'+PageNo+'_SORT_ID');
  if (FindCmp1<>nil) and (FindCmp1 is TcxButtonEdit) and (TcxButtonEdit(FindCmp1).Visible) and (TcxButtonEdit(FindCmp1).Text<>'') then
    TitleList.Add('商品分类：'+TcxButtonEdit(FindCmp1).Text);   
  //计量单位
  FindCmp1:=FindComponent('fndP'+PageNo+'_UNIT_ID'); 
  if (FindCmp1<>nil) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex<>-1) then
    TitleList.Add('统计单位：'+TcxComboBox(FindCmp1).Text);
end;

end.
