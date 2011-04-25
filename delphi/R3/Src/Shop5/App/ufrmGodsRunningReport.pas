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
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
       var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
  private
    function  GetGoodDetailSQL(chk:boolean=true): widestring;
    procedure AddBillTypeItems; //添加帐单类型Items

    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
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
end;

function TfrmGodsRunningReport.GetGoodDetailSQL(chk:boolean=true): widestring;
var
  mx: string;
  strSql,strWhere,CLIENT_Tab: widestring;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  查询开始日期不能大于结束日期条件不能为空！ ');
  if trim(fndP1_GODS_ID.AsString)='' then Raise Exception.Create('  请选择要查询商品！  '); 

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';
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
     0: strWhere:=strWhere+' and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''' ';
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
   0,5: CLIENT_Tab:=' select TENANT_ID,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   4:   CLIENT_Tab:=' select TENANT_ID,trim(char(TENANT_ID))as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
  end;
  CLIENT_Tab:=
     ' select TENANT_ID,CLIENT_ID,CLIENT_NAME from PUB_CLIENTINFO '+  //供应商表
     ' union all select TENANT_ID,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME from PUB_CUSTOMER '+  //客户表
     ' union all '+CLIENT_Tab+' ';  //企业表

  strSql :=
    'select A.TENANT_ID'+
     ',A.SHOP_ID'+
     ',B.SHOP_NAME'+
     ',A.CREA_DATE'+
     ',GLIDE_NO'+
     ',ORDER_TYPE'+
     ',A.GODS_ID'+
     ',C.GODS_CODE as GODS_CODE'+
     ',C.GODS_NAME as GODS_NAME'+
     ',C.BARCODE as BARCODE'+
     ',A.CLIENT_ID'+
     ',A.CREA_USER'+
     ',A.UNIT_ID'+
     ',A.PROPERTY_01'+
     ',A.PROPERTY_02'+
     ',BATCH_NO'+
     ',LOCUS_NO'+
     ',APRICE'+
     ',(case when ORDER_TYPE in (11,12,21,22,24) then AMOUNT else -AMOUNT end) as AMOUNT'+
     ',(case when ORDER_TYPE in (11,12,21,22,24) then CALC_MONEY else -CALC_MONEY end) as AMONEY '+
    'from VIW_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSINFO C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
    ' '+ strWhere + ' ';
    
  //关联商品表：
  strSql :=
    'select j.*'+
    ',h.CLIENT_NAME as CLIENT_NAME'+
    ',isnull(i.BARCODE,j.BARCODE) as BARCODE'+
    ',u.UNIT_NAME as UNIT_NAME'+
    ',e.USER_NAME as CREA_USER_TXT from '+
    ' ('+strSql+') j '+
    ' left outer join ('+CLIENT_Tab+') h on j.TENANT_ID=h.TENANT_ID and j.CLIENT_ID=h.CLIENT_ID '+                         //供应商  //j.BATCH_NO=bar.BATCH_NO and
    ' left outer join VIW_BARCODE i on i.BARCODE_TYPE in (''0'',''1'',''2'') and j.TENANT_ID=i.TENANT_ID and j.GODS_ID=i.GODS_ID and j.PROPERTY_01=i.PROPERTY_01 and j.PROPERTY_02=i.PROPERTY_02 and j.UNIT_ID=i.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';

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
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
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

end.

