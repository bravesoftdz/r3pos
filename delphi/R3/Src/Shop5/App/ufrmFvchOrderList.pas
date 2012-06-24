{  100002407	0	查询 1 新增|生成	2	修改	3	修改	4	删除	5	过账	6	打印	7	导出   }


unit ufrmFvchOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,zBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmFvchOrderList = class(TframeToolForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    frfRecvOrder: TfrReport;
    actfrmBatchReck: TAction;
    fndP1_SHOP_ID: TzrComboBoxList;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label2: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    CdsList: TZQuery;
    ListDs: TDataSource;
    Label8: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_BILL_NAME: TcxComboBox;
    actFvch: TAction;
    ToolButton9: TToolButton;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure frfRecvOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
    procedure actDeleteExecute(Sender: TObject);
    procedure frfRecvOrderGetValue(const ParName: String; var ParValue: Variant);
    procedure CdsListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actFvchExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    procedure ChangeButton;
    function  CheckCanExport: boolean; override;
  public
    IsEnd: boolean;
    MaxId:string;
    pid:string;
    locked:boolean;
    procedure AddRecord(AObj:TRecord_);    
    function EncodeSQL(id:string;var w:string):string;
    procedure Open(Id:string);
  end;

implementation

uses
  uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, 
  uShopGlobal, uCtrlUtil, ufrmFvchOrder, ufrmBasic, ObjCommon,
  ufrmFvchCalc;
  
{$R *.dfm}

procedure TfrmFvchOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  fndP1_DEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //第一分页应收账款:
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    fndP1_SHOP_ID.Properties.ReadOnly := True;
  end;
  //2011.11.10 引入门店权限及部门权限，把原有的控制注释
  RzPage.ActivePageIndex := 0;

  if ShopGlobal.GetProdFlag = 'E' then
    Label3.Caption := '仓库名称';
  ChangeButton;
  AddCbxPickList(fndP1_BILL_NAME,'BILL_NAME');
  fndP1_BILL_NAME.Properties.Items.Insert(0,'全部');
end;

procedure TfrmFvchOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmFvchOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  with TfrmFvchOrder.Create(self) do
  begin
    try
      cid := cdsList.FieldbyName('SHOP_ID').AsString;
      Open(cdsList.FieldByName('FVCH_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmFvchOrderList.ChangeButton;
begin
  if cdsList.Active and (cdsList.FieldByName('FVCH_FLAG').AsString = '2') then
    actAudit.Caption := '已过账'
  else
    actAudit.Caption := '过账';
end;
procedure TfrmFvchOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  if cdsList.IsEmpty then Raise Exception.Create('     请选择待过账的凭证单...    ');
  if not ShopGlobal.GetChkRight('100002407',5) then Raise Exception.Create('  您没有过账凭证单的权限,请和管理员联系.   ');
  if (cdsList.FieldByName('FVCH_FLAG').AsString='2') and (cdsList.FieldByName('FVCH_IMPORT_ID').AsString<>'') then
  begin
    Raise Exception.Create('   已过账的凭证单不能操作...   ');  
  end else
  begin
    if MessageBox(Handle,'   确认过账当前凭证单？  ',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  end;
  
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsList.FieldbyName('TENANT_ID').AsInteger;
      Params.ParamByName('FVCH_ID').asString := cdsList.FieldbyName('FVCH_ID').AsString;
      Msg := Factor.ExecProc('TFvchPostForInspur',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  except
    on E:Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TfrmFvchOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
end;

function TfrmFvchOrderList.EncodeSQL(id:string;var w:string): string;
var
  strSql,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('凭证日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('凭证日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('凭证查询开始日期不能大于结束日期');
  strWhere := strWhere + ' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' ';
  //分批取数据的条件:
  if trim(id)<>'' then
    strWhere:=strWhere+' A.FVCH_ID > '+QuotedStr(id);
  //帐款日期:
  if P1_D1.Date=P1_D2.Date then
    strWhere := strWhere + ' and A.FVCH_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' '
  else
    strWhere := strWhere + ' and A.FVCH_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.FVCH_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+'';
  //门店条件:
  if fndP1_SHOP_ID.AsString <> '' then
    strWhere := strWhere + ' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+'''';
  //部门条件:
  if fndP1_DEPT_ID.AsString <> '' then
    strWhere := strWhere + ' and A.DEPT_ID='''+fndP1_DEPT_ID.AsString+'''';

  //引入状态
  case fndSTATUS.ItemIndex of
   1: strWhere := strWhere + ' and isnull(A.FVCH_FLAG,'''')=''0'' ';  //新增状态
   2: strWhere := strWhere + ' and isnull(A.FVCH_FLAG,'''')=''2'' ';  //过账状态
  end;

  //单据类型
  if fndP1_BILL_NAME.ItemIndex>0 then
    strWhere := strWhere + ' and B.FVCH_GTYPE='''+TRecord_(fndP1_BILL_NAME.Properties.Items.Objects[fndP1_BILL_NAME.ItemIndex]).FieldByName('CODE_ID').AsString+''' ';

  strSql:=
    'select distinct '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID'+
    ',A.FVCH_ID'+
    ',A.FVCH_CODE'+   //凭证内码
    ',A.DEPT_ID'+
    ',A.FVCH_DATE'+
    ',A.FVCH_ATTACH '+
    ',A.CREA_USER'+
    ',A.FVCH_FLAG'+
    ',A.FVCH_IMPORT_ID '+
    ',B.FVCH_GTYPE as BILL_NAME '+
    ' from ACC_FVCHORDER A,ACC_FVCHGLIDE B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.FVCH_ID=B.FVCH_ID '+
    ' '+strWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';

  //关联门店表
  strSql:=
    'select jc.*'+
    ' ,c.DEPT_NAME'+
    ' ,d.SHOP_NAME as SHOP_ID_TEXT'+
    ' ,e.USER_NAME as CREA_USER_TEXT '+
    '  from ('+strSql+') jc '+
    ' left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID '+
    ' left outer join CA_SHOP_INFO d on jc.TENANT_ID=d.TENANT_ID and jc.SHOP_ID=d.SHOP_ID '+
    ' left outer join VIW_USERS e on jc.TENANT_ID=e.TENANT_ID and jc.CREA_USER=e.USER_ID ';

  case Factor.iDbType of
   0: result := 'select top 600 * from ('+strSql+') jp order by FVCH_ID';
   1: result := 'select * from ('+strSql+' order by FVCH_ID) where ROWNUM<=600';
   4: result :=
       'select * from ('+
       'select * from ('+strSql+') j order by FVCH_ID) tp fetch first 600  rows only';
   5: result := 'select * from ('+strSql+') j order by FVCH_ID limit 600';
   else
     result := 'select * from ('+strSql+') j order by FVCH_ID';
  end;
end;

procedure TfrmFvchOrderList.Open(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then CdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsList.DisableControls;
  try
    rs.SQL.Text :=ParseSQL(Factor.iDbType, EncodeSQL(Id,Str));
    Factor.Open(rs);
    rs.SortedFields :='FVCH_ID';
    rs.IndexFieldNames :='FVCH_ID';
    if Id='' then
    begin
      rs.SaveToStream(sm);
      CdsList.LoadFromStream(sm);
      CdsList.SortedFields := 'FVCH_ID';
      CdsList.IndexFieldNames := 'FVCH_ID';
    end else
    begin
      rs.SaveToStream(sm);
      CdsList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    CdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmFvchOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

procedure TfrmFvchOrderList.frfRecvOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
var
  small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
  begin
    small := frParser.Calc(p1);
    Val := FnNumber.SmallTOBig(small);
  end;
end;

procedure TfrmFvchOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
   if cdsList.IsEmpty then Exit;  
   if not ShopGlobal.GetChkRight('100002407',4) then Raise Exception.Create('你没有删除凭证的权限,请和管理员联系.');
   if cdsList.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002407',5) then
        Raise Exception.Create('你没有删除"'+cdsList.FieldByName('RECV_USER_TEXT').AsString+'"录入凭证的权限!');
    end;
   if (cdsList.FieldByName('FVCH_FLAG').AsString='2') and (cdsList.FieldByName('FVCH_IMPORT_ID').AsString<>'') then
     Raise Exception.Create('此凭证已过账财务系统,不能执行删除操作.');
   if MessageBox(Handle,'确认删除当前选中的凭证？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmFvchOrder.Create(self) do
   begin
     try
       Open(cdsList.FieldByName('FVCH_ID').AsString);
       DeleteOrder;
       cdsList.Delete;
       if cdsList.IsEmpty then CdsFvchData.Close;
       MessageBox(Handle,'删除凭证单成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
     finally
       free;
     end;
   end;
end;

procedure TfrmFvchOrderList.AddRecord(AObj: TRecord_);
begin
 
end;

procedure TfrmFvchOrderList.frfRecvOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
end;

function TfrmFvchOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('100002407',7);
end;


procedure TfrmFvchOrderList.CdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if CdsList.ControlsDisabled then Exit;  
  Open(MaxId);
end;

procedure TfrmFvchOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsList.RecNo)),length(Inttostr(CdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmFvchOrderList.actFvchExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002407',2) then Raise Exception.Create('  您生成凭证单的权限,请和管理员联系.   ');
  with TfrmFvchCalc.Create(nil) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmFvchOrderList.actPrintExecute(Sender: TObject);
var
  ReStr: string;
begin
  if not ShopGlobal.GetChkRight('100002407',6) then Raise Exception.Create('  您没有打印凭证的权限,请和管理员联系.   ');
  if not DBGridEh1.DataSource.DataSet.Active then Exit;
  //日期条件
  ReStr:='凭证日期:'+FormatDatetime('YYYY-MM-DD',P1_D1.Date)+' 至 '+FormatDatetime('YYYY-MM-DD',P1_D2.Date);
  if fndP1_SHOP_ID.AsString<>'' then
    ReStr:=ReStr+'  门店名称:'+fndP1_SHOP_ID.Text;
  if fndP1_DEPT_ID.AsString<>'' then
    ReStr:=ReStr+'  部门名称:'+fndP1_DEPT_ID.Text;
  if trim(fndP1_BILL_NAME.Text)<>'' then
    ReStr:=ReStr+'  业务单据:'+fndP1_BILL_NAME.Text;
  case fndSTATUS.ItemIndex of
   1: ReStr:=ReStr+'  状态:新增';
   2: ReStr:=ReStr+'  状态:过账';
  end;
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  PrintDBGridEh1.PageHeader.CenterText.Text:=Global.TENANT_NAME+trim(PrintDBGridEh1.PageHeader.CenterText.Text);
  DBGridEh1.DataSource.DataSet.Filtered := false;
  PrintDBGridEh1.Print;
end;

procedure TfrmFvchOrderList.actPreviewExecute(Sender: TObject);
var
  ReStr: string;
begin
  if not ShopGlobal.GetChkRight('100002407',6) then Raise Exception.Create('  您没有打印凭证的权限,请和管理员联系.   ');
  if not DBGridEh1.DataSource.DataSet.Active then Exit;
  //日期条件
  ReStr:='凭证日期:'+FormatDatetime('YYYY-MM-DD',P1_D1.Date)+' 至 '+FormatDatetime('YYYY-MM-DD',P1_D2.Date);
  if fndP1_SHOP_ID.AsString<>'' then
    ReStr:=ReStr+'  门店名称:'+fndP1_SHOP_ID.Text;
  if fndP1_DEPT_ID.AsString<>'' then
    ReStr:=ReStr+'  部门名称:'+fndP1_DEPT_ID.Text;
  if trim(fndP1_BILL_NAME.Text)<>'' then
    ReStr:=ReStr+'  业务单据:'+fndP1_BILL_NAME.Text;
  case fndSTATUS.ItemIndex of
   1: ReStr:=ReStr+'  状态:新增';
   2: ReStr:=ReStr+'  状态:过账';
  end;
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  PrintDBGridEh1.PageHeader.CenterText.Text:=Global.TENANT_NAME+trim(PrintDBGridEh1.PageHeader.CenterText.Text);
  DBGridEh1.DataSource.DataSet.Filtered := false;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
end;

procedure TfrmFvchOrderList.actNewExecute(Sender: TObject);
begin
  //新增凭证
 

end;

procedure TfrmFvchOrderList.actEditExecute(Sender: TObject);
begin
  //编辑

  
end;

procedure TfrmFvchOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(Sender);   
end;

procedure TfrmFvchOrderList.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  if Column.FieldName = 'FVCH_DATE' then Text := '合计:'+Text+'笔';
end;

end.
