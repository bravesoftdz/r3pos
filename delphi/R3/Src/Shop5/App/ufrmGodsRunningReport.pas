unit ufrmGodsRunningReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList,ObjCommon,
  zrMonthEdit, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxRadioGroup, Buttons;

type
  TfrmGodsRunningReport = class(TframeBaseReport)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnOk: TRzBitBtn;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    fndP1_GODS_ID: TzrComboBoxList;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    fndP1_BarType_ID: TcxComboBox;
    fndP1_BarCode: TcxTextEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
  private
    FReckAmt: Real;  //期初数量
    FReckMny: Real;  //期初金额
    procedure AddBillTypeItems; //添加帐单类型Items

    function  GetGoodStorageORG: Boolean; //返回当前查询期初数量
    function  GetGoodDetailSQL(chk:boolean=true): widestring;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation

uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, uShopUtil, ufrmSelectGoodSort, ufrmCostCalc;

{$R *.dfm}

procedure TfrmGodsRunningReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  AddBillTypeItems; //添加单据类型
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_BarType_ID.ItemIndex:=0;

  SetRzPageActivePage(false); //设置默认分页
  RefreshColumn;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      fndP1_SHOP_ID.Properties.ReadOnly := False;
      fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP1_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
      fndP1_SHOP_ID.Properties.ReadOnly := True;
    end;
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label4.Caption := '仓库名称';
    end;

  //2011.04.22 Add 设置查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['APRICE','AMONEY']);
  end;
end;

function TfrmGodsRunningReport.GetGoodDetailSQL(chk:boolean=true): widestring;
var
  mx: string;
  strSql,strWhere,CLIENT_Tab,ORG_Tab: widestring;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  查询开始日期不能大于结束日期条件不能为空！ ');
  if trim(fndP1_GODS_ID.AsString)='' then Raise Exception.Create('  请选择要查询商品！  '); 

  //读取台账的期初数量:
  FReckAmt:=0;
  FReckMny:=0;
  if not GetGoodStorageORG then Raise Exception.Create('  读取期初错误！  ');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+' ';
  //门店条件:
  if fndP1_SHOP_ID.AsString <>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
  //商品名称
  if fndP1_GODS_ID.AsString <>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+fndP1_GODS_ID.AsString+''' ';

  //条形码（ 物流跟踪号|批号）:
  if trim(fndP1_BarCode.Text)<>'' then
  begin
    case fndP1_BarType_ID.ItemIndex of
     0: begin
          strWhere:=strWhere+' and (Exists(select * from STK_LOCUS_FORSTCK where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and STOCK_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''') ';
          strWhere:=strWhere+' or Exists(select * from SAL_LOCUS_FORSALE where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and SALES_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''') ';
          strWhere:=strWhere+' or Exists(select * from STO_LOCUS_FORCHAG where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and CHANGE_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''')) ';
        end;
     1: strWhere:=strWhere+' and BATCH_NO='''+trim(fndP1_BarCode.Text)+''' '
    end;
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

  //供应商+客户+企业资料
  case Factor.iDbType of
   0,1,5:
      CLIENT_Tab:=' select TENANT_ID,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   3: CLIENT_Tab:=' select TENANT_ID,str(TENANT_ID) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   4: CLIENT_Tab:=' select TENANT_ID,ltrim(rtrim(char(TENANT_ID)))as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
  end;
  CLIENT_Tab:=
     ' select TENANT_ID,CLIENT_ID,CLIENT_NAME from PUB_CLIENTINFO '+  //供应商表
     ' union all select TENANT_ID,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME from PUB_CUSTOMER '+  //客户表
     ' union all '+CLIENT_Tab+' ';  //企业表

  strSql :=
    ' select A.TENANT_ID'+
     ',A.SHOP_ID'+
     ',A.ORDER_ID'+
     ',B.SHOP_NAME'+
     ',A.CREA_DATE'+
     ',GLIDE_NO'+
     ',ORDER_TYPE'+
     ',A.GODS_ID'+
     ',C.GODS_CODE as GODS_CODE'+
     ',C.GODS_NAME as GODS_NAME'+
     ',C.BARCODE as DefBARCODE'+
     ',A.CLIENT_ID'+
     ',A.CREA_USER'+
     ',A.UNIT_ID'+
     ',A.PROPERTY_01'+
     ',A.PROPERTY_02'+
     ',BATCH_NO'+
     ',LOCUS_NO'+
     ',APRICE'+
     ',(case when ORDER_TYPE in (21,22,23,24) then -AMOUNT else AMOUNT end) as AMOUNT'+  //销售的转成负数
     ',(case when ORDER_TYPE in (21,22,23,24) then -CALC_MONEY else CALC_MONEY end) as AMONEY '+
     ' from VIW_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSINFO C '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
     ' '+ strWhere + '  ';

  //关联商品表：
  strSql :=
    'select '+
    'isnull(i.BARCODE,j.DefBARCODE) as BARCODE'+
    ',j.*'+
    ',h.CLIENT_NAME as CLIENT_NAME'+
    ',u.UNIT_NAME as UNIT_NAME'+
    ',e.USER_NAME as CREA_USER_TXT from '+
    ' ('+strSql+') j '+
    ' left outer join ('+CLIENT_Tab+') h on j.CLIENT_ID=h.CLIENT_ID '+ //j.TENANT_ID=h.TENANT_ID and  //供应商  //j.BATCH_NO=bar.BATCH_NO and
    ' inner join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) i '+
    '  on j.TENANT_ID=i.TENANT_ID and j.GODS_ID=i.GODS_ID and j.PROPERTY_01=i.PROPERTY_01 and j.PROPERTY_02=i.PROPERTY_02 and j.UNIT_ID=i.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';

  //关联期初：
  ORG_Tab:=
    ' select BARCODE '+
     ',TENANT_ID'+
     ','''+fndP1_SHOP_ID.AsString+''' as SHOP_ID'+
     ',''00'' as ORDER_ID'+
     ','''+fndP1_SHOP_ID.Text+''' as SHOP_NAME'+
     ','+FormatDatetime('YYYYMMDD',P1_D1.Date-1)+' as CREA_DATE'+
     ',''  '' as GLIDE_NO'+
     ',''00'' as ORDER_TYPE'+
     ',GODS_ID'+
     ',GODS_CODE'+
     ',GODS_NAME'+
     ',BARCODE as DefBARCODE'+
     ',''  '' as CLIENT_ID'+
     ',''  '' as CREA_USER'+
     ',CALC_UNITS as UNIT_ID'+
     ',''  '' as PROPERTY_01'+
     ',''  '' as PROPERTY_02'+
     ',''  '' as BATCH_NO'+
     ',''  '' as LOCUS_NO'+
     ',(case when '+FloattoStr(FReckAmt)+'<>0 then cast('+FloattoStr(FReckMny)+' as decimal(18,3))/cast('+FloattoStr(FReckAmt)+' as decimal(18,3)) else '+FloattoStr(FReckMny)+' end) as  APRICE'+
     ','+FloattoStr(FReckAmt)+' as AMOUNT '+
     ','+FloattoStr(FReckMny)+' as AMONEY '+
     ',''  '' as CLIENT_NAME'+
     ',''  '' as UNIT_NAME'+
     ',''  '' as CREA_USER_TXT'+     
     ' from VIW_GOODSINFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and GODS_ID='''+trim(fndP1_GODS_ID.AsString)+'''  ';

  strSql :='select * from ('+ORG_Tab+' union all '+strSql+')tmp order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmGodsRunningReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmGodsRunningReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
    0:begin //商品出入库流水
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGoodDetailSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按门店汇总表
 
      end;
    2: begin //按分类汇总表

      end;
    3: begin //按商品汇总表

      end;
  end;
end;

procedure TfrmGodsRunningReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
{  if adoReport1.IsEmpty then Exit;
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
  actFind.OnExecute(nil); }
end;

procedure TfrmGodsRunningReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;   
end;

procedure TfrmGodsRunningReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption+#13+#13+trim(fndP1_GODS_ID.Text);
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

procedure TfrmGodsRunningReport.actPriorExecute(Sender: TObject);
begin
  Exit;
  inherited;
  
end;

function TfrmGodsRunningReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //1、日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  //继承基类
  inherited AddReportReport(TitleList,PageNo);
end;
                              
procedure TfrmGodsRunningReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'ORDER_TYPE' then Text :='期末结存';//'合计:'+Text+'笔';
end;

procedure TfrmGodsRunningReport.AddBillTypeItems;
  procedure AddSingeItems(SetCol: TColumnEh; KeyValue,PickValue: string);
  begin
    SetCol.KeyList.Add(KeyValue);
    SetCol.PickList.Add(PickValue);
  end;
var
  rs: TZQuery;
  CurName: string;
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(DBGridEh1,'ORDER_TYPE');
  if SetCol=nil then Exit;
  SetCol.KeyList.Clear;
  SetCol.PickList.Clear;
  AddSingeItems(SetCol,'00','期  初');
  //入库单据:
  AddSingeItems(SetCol,'11','入库单');
  AddSingeItems(SetCol,'12','调入单');
  AddSingeItems(SetCol,'13','退货单');
  //销售单据:
  AddSingeItems(SetCol,'21','销售单');
  AddSingeItems(SetCol,'22','调出单');
  AddSingeItems(SetCol,'23','退货单');
  AddSingeItems(SetCol,'24','零售单');
  //调整单据:
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  if (rs<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add('3'+trim(rs.fieldbyName('CHANGE_CODE').AsString));
      CurName:=trim(rs.fieldbyName('CHANGE_NAME').AsString);
      if not (pos('单',CurName)>0) then CurName:=CurName+'单'; 
      SetCol.PickList.Add(CurName);
      rs.Next;
    end;
  end;
end;                                                      

function TfrmGodsRunningReport.GetGoodStorageORG: Boolean;
var
  rs:TZQuery;
  Str,GodsID,ReckDate,MaxReckDate,Shop_Cnd: string;
  Rck_SQL1,Rck_SQL2,RCK_DAYS_CLOSE: string;
begin
  result:=False;
  GodsID:=trim(fndP1_GODS_ID.AsString);
  ReckDate:=FormatDatetime('YYYYMMDD',P1_D1.Date-1);
  RCK_DAYS_CLOSE:='select Max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+InttoStr(Global.TENANT_ID);
  if trim(fndP1_SHOP_ID.AsString)<>'' then
  begin
    Shop_Cnd:=' and A.SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
    RCK_DAYS_CLOSE:=RCK_DAYS_CLOSE+' and SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
  end;
  Rck_SQL1:='select A.CREA_DATE,sum(A.BAL_AMT) as BAL_AMT,sum(A.BAL_RTL) as BAL_RTL from RCK_GOODS_DAYS A,RCK_DAYS_CLOSE C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and '+
            ' A.CREA_DATE=C.CREA_DATE and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+Shop_Cnd+' and A.GODS_ID='''+GodsID+''' and C.CREA_DATE='+ReckDate+' '+
            ' group by A.CREA_DATE ';
  
  Rck_SQL2:='select A.CREA_DATE,sum(A.BAL_AMT) as BAL_AMT,sum(A.BAL_RTL) as BAL_RTL from RCK_GOODS_DAYS A,('+RCK_DAYS_CLOSE+') C '+
            ' where A.CREA_DATE=C.CREA_DATE and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+Shop_Cnd+' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' and A.GODS_ID='''+GodsID+''' ';
  
  //判断开始时间点是否已日结账：
  Str:='select CREA_DATE,BAL_AMT,BAL_RTL from ('+Rck_SQL1+'  union all  '+Rck_SQL2+')tmp where CREA_DATE>0 ';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=Str;
    Factor.Open(rs);
    if rs.Locate('CREA_DATE',ReckDate,[]) then  //定位到已日结账
    begin
      FReckAmt:=rs.fieldbyName('BAL_AMT').AsFloat;
      FReckMny:=rs.fieldbyName('BAL_RTL').AsFloat;
    end else
    begin
      if rs.RecordCount>0 then
      begin
        rs.First;
        MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);
        while not rs.Eof do
        begin
          if MaxReckDate<trim(rs.fieldbyName('CREA_DATE').AsString) then
            MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);
          rs.Next;
        end;
        if rs.Locate('CREA_DATE',MaxReckDate,[]) then  //定位最大结帐日
        begin
          FReckAmt:=rs.fieldbyName('BAL_AMT').AsFloat;
          FReckMny:=rs.fieldbyName('BAL_RTL').AsFloat;
        end;
      end else
        MaxReckDate:='00000000';
      //查询台账视图: 大于最大结账日期  小于查询日期
      Str:='select sum(case when ORDER_TYPE in (21,22,23,24) then -AMOUNT else AMOUNT end) as BAL_AMT,sum((case when ORDER_TYPE in (21,22,23,24) then -CALC_MONEY else CALC_MONEY end)) as BAL_RTL '+
           'from VIW_GOODS_DAYS where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CREA_DATE>'+MaxReckDate+' and CREA_DATE<='+ReckDate+' and GODS_ID='''+GodsID+''' ';
      if trim(fndP1_SHOP_ID.AsString)<>'' then
        Str:=Str+' and SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
      rs.Close;
      rs.SQL.Text:=Str;
      Factor.Open(rs);
      if Rs.RecordCount=1 then
      begin
        FReckAmt:=FReckAmt+rs.fieldbyName('BAL_AMT').AsFloat;
        FReckMny:=FReckMny+rs.fieldbyName('BAL_RTL').AsFloat; 
      end;
    end;
    result:=true;
  finally
    rs.Free;
  end;
end;


end.

