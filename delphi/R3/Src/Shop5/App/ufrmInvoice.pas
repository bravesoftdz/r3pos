unit ufrmInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzLabel, ComCtrls, ToolWin, DB, ZBase,
  FR_Class, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxDropDownEdit, cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList,
  PrnDbgeh;

type
  TfrmInvoice = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Panel2: TPanel;
    edtKey: TcxTextEdit;
    Ds_Invoice: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    But_Edit: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    actRights: TAction;
    btnOk: TRzBitBtn;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Cds_Invoice: TZQuery;
    edtSHOP_ID: TzrComboBoxList;
    lab_SHOP_ID: TRzLabel;
    RzLabel6: TRzLabel;
    edtCREA_USER: TzrComboBoxList;
    edtCREA_DATE1: TcxDateEdit;
    labCREA_DATE: TRzLabel;
    Label3: TLabel;
    edtCREA_DATE2: TcxDateEdit;
    RzLabel1: TRzLabel;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure actFindExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure Cds_InvoiceAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
  end;


implementation
uses ufrmUsersInfo,ufrmInvoiceInfo,ufrmBasic, uframeDialogForm, uGlobal,
  ufrmEhLibReport,uShopGlobal,uCtrlUtil;//ufrmUserRights,ufrmFastReport,
{$R *.dfm}

procedure TfrmInvoice.actFindExecute(Sender: TObject);
var str:string;
begin
  inherited;
  //查询门店门店发票领用情况
  if edtSHOP_ID.Text <> '' then
    str := ' and SHOP_ID='+QuotedStr(edtSHOP_ID.AsString);
  if edtCREA_USER.Text <> '' then
    str :=str + ' and CREA_USER='+QuotedStr(edtCREA_USER.AsString);

  if (edtCREA_DATE1.EditValue=NULL) and (edtCREA_DATE2.EditValue<>NULL) then
     str:=str+' and CREA_DATE='+QuotedStr(FormatDateTime('YYYYMMDD',edtCREA_DATE2.Date));
  if (edtCREA_DATE1.EditValue<>NULL) and (edtCREA_DATE2.EditValue=NULL) then
     str:=str+' and CREA_DATE='+QuotedStr(FormatDateTime('YYYYMMDD',edtCREA_DATE1.Date));
  if (edtCREA_DATE1.EditValue<>NULL) and (edtCREA_DATE2.EditValue<>NULL) then
  begin
    if edtCREA_DATE1.Date=edtCREA_DATE2.Date then
      str:=str+' and CREA_DATE='+QuotedStr(FormatDateTime('YYYYMMDD',edtCREA_DATE1.Date))+' '
    else
      str:=str+' and CREA_DATE>='+QuotedStr(FormatDateTime('YYYYMMDD',edtCREA_DATE1.Date))+' and CREA_DATE<='+QuotedStr(FormatDateTime('YYYYMMDD',edtCREA_DATE2.Date));
  end;
  if edtKey.Text<>'' then
     str:= str + ' and INVH_NO LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%');
  Cds_Invoice.Close;
  Cds_Invoice.SQL.Text:='select TENANT_ID,INVH_ID,SHOP_ID,CREA_USER,CREA_DATE,INVH_NO,BEGIN_NO,ENDED_NO,TOTAL_AMT,USING_AMT,CANCEL_AMT,'+
  'BALANCE,REMARK,COMM,TIME_STAMP from SAL_INVOICE_BOOK Where COMM not in (''02'',''12'') and TENANT_ID='+ IntToStr(Global.TENANT_ID) + str;
  Factor.Open(Cds_Invoice);
end;

procedure TfrmInvoice.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(Str:string);
  var Tmp:TZQuery;
  begin
   { Tmp := Global.GetZQueryFromName('CA_USERS');
    Tmp.Filtered := false;
    if Tmp.Locate('USER_ID',Str,[]) then
    begin
      Tmp.Delete;
      Tmp.CommitUpdates;
    end; }
  end;
var i:integer;
    Params:TftParamList;
begin
  inherited;
  if (Not Cds_Invoice.Active) or (Cds_Invoice.RecordCount = 0) then Exit;
  {if not ShopGlobal.GetChkRight('100019') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');}
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('INVH_ID').asString:=Cds_Invoice.FieldByName('INVH_ID').AsString;
      Params.ParamByName('TENANT_ID').asString:=Cds_Invoice.FieldByName('TENANT_ID').AsString;
      //Params.ParamByName('COMM').AsString := '02';
      Cds_Invoice.Delete;
      Factor.UpdateBatch(Cds_Invoice,'TInvoice',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(Cds_Invoice.FieldByName('INVH_ID').AsString);
  end;
end;

procedure TfrmInvoice.actNewExecute(Sender: TObject);
begin
  inherited;
  {if not ShopGlobal.GetChkRight('100017') then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');}
  with TfrmInvoiceInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmInvoice.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Invoice.Active) or (Cds_Invoice.IsEmpty) then exit;
  {if not ShopGlobal.GetChkRight('100018') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');}
  with TfrmInvoiceInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(Cds_Invoice.FieldByName('INVH_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmInvoice.AddRecord(AObj: TRecord_);
begin
  if not Cds_Invoice.Active  then exit;
  if Cds_Invoice.Locate('INVH_ID',AObj.FieldByName('INVH_ID').AsString,[]) then
  begin
     Cds_Invoice.Edit;
     AObj.WriteToDataSet(Cds_Invoice,false);
     Cds_Invoice.Post;
  end
  else
  begin
     Cds_Invoice.Append;
     AObj.WriteToDataSet(Cds_Invoice,false);
     Cds_Invoice.Post;
  end;
  InitGrid;
  if Cds_Invoice.Locate('INVH_ID',AObj.FieldByName('INVH_ID').AsString,[]) then exit;
end;

procedure TfrmInvoice.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  InitGrid;
  TDbGridEhSort.InitForm(self);
end;

procedure TfrmInvoice.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Invoice.Active) and (Cds_Invoice.IsEmpty) then exit;
  with TfrmInvoiceInfo.Create(self) do
    begin
      try
        Open(Cds_Invoice.FieldByName('INVH_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmInvoice.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_Invoice.RecNo)),length(Inttostr(Cds_Invoice.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmInvoice.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
    Background := clBtnFace;
end;

procedure TfrmInvoice.InitGrid;
var tmp:TZQuery;
begin
  DBGridEh1.FieldColumns['SHOP_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('CA_SHOP_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Add(tmp.Fields[0].asstring);
    DBGridEh1.FieldColumns['SHOP_ID'].PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;

  DBGridEh1.FieldColumns['CREA_USER'].PickList.Clear;
  DBGridEh1.FieldColumns['CREA_USER'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('CA_USERS');
  tmp.First;
  while not tmp.Eof do
    begin
      DBGridEh1.FieldColumns['CREA_USER'].KeyList.Add(tmp.Fields[0].asstring);
      DBGridEh1.FieldColumns['CREA_USER'].PickList.Add(tmp.Fields[1].asstring);
      tmp.Next;
    end;
end;

procedure TfrmInvoice.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
  edtKey.SetFocus;
end;

procedure TfrmInvoice.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     Cds_Invoice.Next;
  if Key=VK_UP then
     Cds_Invoice.Prior;
end;

procedure TfrmInvoice.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  Cds_Invoice.Filtered:=False;
  Cds_Invoice.Filter:=' INVH_NO LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%');
  Cds_Invoice.Filtered:=(edtKey.Text<>'');
end;

procedure TfrmInvoice.Cds_InvoiceAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Invoice.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Invoice.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(Cds_Invoice.RecordCount)+'条';
end;

procedure TfrmInvoice.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

procedure TfrmInvoice.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100014') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');

  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmInvoice.actPreviewExecute(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
end;

end.
