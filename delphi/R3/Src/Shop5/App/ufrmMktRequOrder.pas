unit ufrmMktRequOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList;

type
  TfrmMktRequOrder = class(TframeContractForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label40: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtREQU_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtREQU_USER: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtDEPT_ID: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    edtKPI_YEAR: TzrComboBoxList;
    edtKPI_ID: TzrComboBoxList;
    cdsKPI_YEAR: TZQuery;
    cdsKPI_ID: TZQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label5: TLabel;
    edtREQU_TYPE: TcxComboBox;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1Columns2BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtKPI_YEAREnter(Sender: TObject);
    procedure edtKPI_YEARExit(Sender: TObject);
    procedure edtKPI_YEARKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_YEARKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_YEARSaveValue(Sender: TObject);
    procedure edtKPI_IDEnter(Sender: TObject);
    procedure edtKPI_IDExit(Sender: TObject);
    procedure edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_IDSaveValue(Sender: TObject);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState);override;
    procedure FocusNextColumn;
  public
    { Public declarations }
    RowID:Integer;
    locked:boolean;
    procedure ClearInvaid;override;
    procedure InitRecord;override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
  end;

implementation
uses
  uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, ufrmBasic, ufrmMain,
  uDsUtil, uXDictFactory, ufrmKpiIndexInfo, ufrmSalIndentOrderList,
  ufrmSalIndentOrder;
{$R *.dfm}

procedure TfrmMktRequOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
    
  if ((gdSelected in State) or (gdFocused in State)) then
    begin
      ARect := Rect;
      DBGridEh1.Canvas.Pen.Color := clRed;
      DBGridEh1.Canvas.Pen.Width := 1;
      DBGridEh1.Canvas.Brush.Style := bsClear;
      DBGridEh1.canvas.Rectangle(ARect);
      stbHint.Caption := Column.Title.Hint;
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmMktRequOrder.DBGridEh1DrawFooterCell(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'KPI_ID_TEXT' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;

       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个指标',[Inttostr(cdsDetail.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh1.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktRequOrder.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns2BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_YEAR.Text := cdsDetail.FieldbyName('KPI_YEAR').asString;
  cdsKPI_YEAR.Close;
  cdsKPI_YEAR.SQL.Text := 'select KPI_YEAR from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') ';
  cdsKPI_YEAR.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsKPI_YEAR.ParamByName('KPI_ID').AsString := cdsDetail.FieldByName('KPI_ID').AsString;
  cdsKPI_YEAR.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  Factor.Open(cdsKPI_YEAR);
end;

procedure TfrmMktRequOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail.FieldbyName('KPI_ID_TEXT').asString;
  edtKPI_ID.KeyValue := cdsDetail.FieldbyName('KPI_ID').asString;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail.FieldbyName('KPI_ID_TEXT').AsString;
  edtKPI_ID.KeyValue := cdsDetail.FieldbyName('KPI_ID').AsString;
  edtKPI_ID.SaveStatus;
end;

procedure TfrmMktRequOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  //edtCLIENT_ID.RangeField := 'FLAG';
  //edtCLIENT_ID.RangeValue := '3';
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
  edtREQU_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  AddCbxPickList(edtREQU_TYPE);
  {cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL from MKT_KPI_INDEX where TENANT_ID=:TENANT_ID and IDX_TYPE=''1'' and COMM not in (''02'',''12'') ';
  cdsKPI_ID.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(cdsKPI_ID);}
end;

procedure TfrmMktRequOrder.edtKPI_YEAREnter(Sender: TObject);
begin
  inherited;
  edtKPI_YEAR.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktRequOrder.edtKPI_YEARExit(Sender: TObject);
begin
  inherited;
  if not edtKPI_YEAR.DropListed then edtKPI_YEAR.Visible := False;
end;

procedure TfrmMktRequOrder.edtKPI_YEARKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtKPI_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       edtKPI_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtKPI_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtKPI_ID.Visible := false;
       cdsDetail.Prior;
     end;
  inherited;
end;

procedure TfrmMktRequOrder.FocusNextColumn;
var i:Integer;
begin
  i:=DBGridEh1.Col;
  Inc(i);
  while True do
    begin
      if i>=DBGridEh1.Columns.Count then i:= 1;
      if (DBGridEh1.Columns[i].ReadOnly or not DBGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsDetail.FieldbyName('KPI_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsDetail.FieldbyName('KPI_ID').asString)<>'') then
              begin
                 cdsDetail.Next ;
                 if cdsDetail.Eof then
                    begin
                      InitRecord;
                    end;
                 DBGridEh1.SetFocus;
                 DBGridEh1.Col := 1 ;
              end
           else
              DBGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmMktRequOrder.InitRecord;
var tmp:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  edtKPI_ID.Visible := false;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('KPI_ID').AsString <>'') then
    begin
      inc(RowID);
      cdsDetail.Append;
      cdsDetail.FieldByName('REQU_ID').Value := null;
      if cdsDetail.FindField('SEQNO') <> nil then
         cdsDetail.FindField('SEQNO').asInteger := RowID;

      cdsDetail.Post;
      cdsDetail.Edit;
    end;
    DBGridEh1.Col := 1 ;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmMktRequOrder.edtKPI_YEARKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if cdsDetail.FieldbyName('KPI_YEAR').AsString = '' then
          begin
            edtKPI_YEAR.DropList;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmMktRequOrder.edtKPI_YEARSaveValue(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  if not cdsDetail.Active then Exit;
//  if cdsDetail2.FieldbyName('KPI_YEAR').AsString=edtKPI_YEAR.AsString then exit;
  if edtKPI_YEAR.asString='' then Exit;
  rs := TZQuery.Create(nil);
  cdsDetail.DisableControls;
  try
    cdsDetail.Edit;
    cdsDetail.FieldByName('KPI_YEAR').AsInteger := StrToInt(edtKPI_YEAR.AsString);
    rs.SQL.Text := 'select KPI_MNY,BUDG_KPI,PLAN_ID from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and KPI_ID=:KPI_ID and KPI_YEAR=:KPI_YEAR';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.asString;
    rs.ParamByName('KPI_ID').asString := cdsDetail.FieldByName('KPI_ID').asString ;
    rs.ParamByName('KPI_YEAR').AsInteger := cdsDetail.FieldByName('KPI_YEAR').AsInteger ;
    Factor.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('你所选择的年度无效。');
    cdsDetail.FieldByName('PLAN_ID').asString := rs.FieldByName('PLAN_ID').asString ;
    cdsDetail.FieldByName('KPI_MNY').AsFloat := rs.FieldByName('KPI_MNY').AsFloat ;
    cdsDetail.FieldByName('BUDG_MNY').AsFloat := rs.FieldByName('BUDG_KPI').AsFloat ;
    cdsDetail.Post;
  finally
    rs.Free;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.edtKPI_IDEnter(Sender: TObject);
begin
  inherited;
  edtKPI_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktRequOrder.edtKPI_IDExit(Sender: TObject);
begin
  inherited;
  if not edtKPI_ID.DropListed then edtKPI_ID.Visible := False;
end;

procedure TfrmMktRequOrder.edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtKPI_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       edtKPI_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtKPI_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtKPI_ID.Visible := false;
       cdsDetail.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtKPI_ID.DropListed then
     begin
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('REQU_ID').AsString='') then
         edtKPI_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtKPI_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('REQU_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;
end;

procedure TfrmMktRequOrder.edtKPI_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
          begin
            edtKPI_ID.DropList;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmMktRequOrder.edtKPI_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  edtKPI_ID.Text := '';
  edtKPI_ID.KeyValue := null;
end;
begin
  if edtCLIENT_ID.AsString = '' then
     begin
       MessageBox(Handle,'请先选择客户后再录单。','友情提示...',MB_OK+MB_ICONINFORMATION);
       edtCLIENT_ID.SetFocus;
       Exit;
     end;
  inherited;
  if not cdsDetail.Active then Exit;
  if cdsDetail.FieldbyName('KPI_ID').AsString=edtKPI_ID.AsString then exit;

  if (edtKPI_ID.AsString='') and edtKPI_ID.Focused then   //and ShopGlobal.GetChkRight('32600001',2)
     Raise Exception.Create('没找到你想查找的指标？');

  cdsDetail.DisableControls;
  try
    if VarIsNull(edtKPI_ID.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      if cdsDetail.Locate('KPI_ID',edtKPI_ID.AsString,[]) then
         begin
           Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.KpiIdxRepeat','"%s"指标重复录入,请核对输入是否正确.',[edtKPI_ID.Text]));
         end
      else
         begin
           cdsDetail.Edit;
           cdsDetail.FieldByName('KPI_ID').AsString := edtKPI_ID.AsString;
           cdsDetail.FieldByName('KPI_ID_TEXT').AsString := edtKPI_ID.Text;
           cdsDetail.FieldByName('KPI_YEAR').AsString := '';
           edtKPI_YEAR.Text := '';
         end;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;
end;

procedure TfrmMktRequOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;

end;

procedure TfrmMktRequOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前申请单执行弃审');
       if MessageBox(Handle,'确认弃审当前费用申请单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if MessageBox(Handle,'确认审核当前费用申请单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('REQU_ID').asString := cdsHeader.FieldbyName('REQU_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TMktRequOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TMktRequOrderUnAudit',Params) ;
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
  Open(oid);
end;

procedure TfrmMktRequOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmMktRequOrder.ClearInvaid;
var
  Controls:boolean;
  r:integer;
begin
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  Controls := cdsDetail.ControlsDisabled;
  r := cdsDetail.RecNo;
  if not Controls then cdsDetail.DisableControls;
  try
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      if (cdsDetail.FieldByName('KPI_ID').AsString = '')
         or
         (cdsDetail.FieldByName('KPI_YEAR').AsString = '')
      then
         cdsDetail.Delete
      else
         cdsDetail.Next;
    end;
  finally
    if r>0 then cdsDetail.RecNo := r;
    if not Controls then  cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;

  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TMktRequOrder');
    Factor.AddBatch(cdsDetail,'TMktRequData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
    {AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    //ReadHeader;
    ReadFrom(cdsDetail);}
    Open(oid);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := '';
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
end;

procedure TfrmMktRequOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;  
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmMktRequOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtSHOP_ID.Properties.ReadOnly := False;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;
  cid := edtSHOP_ID.KeyValue;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  AObj.FieldbyName('REQU_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('REQU_ID').asString;
  gid := '..新增..';
  edtREQU_DATE.Date := Global.SysDate;
  edtREQU_USER.KeyValue := Global.UserID;
  edtREQU_USER.Text := Global.UserName;
  if edtREQU_TYPE.Properties.Items.Count>0 then edtREQU_TYPE.ItemIndex := 0;
  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmMktRequOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  locked := true;
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('REQU_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TMktRequOrder',Params);
      Factor.AddBatch(cdsDetail,'TMktRequData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('REQU_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    RowID := cdsDetail.RecordCount;

    locked := false;
  finally
    Params.Free;
  end;
end;

procedure TfrmMktRequOrder.SaveOrder;
var i:integer;
    DKpiMny,DBudgMny,DAgioMny,DOthrMny:Real;
begin
  inherited;
  Saved := false;
  if edtREQU_DATE.EditValue = null then Raise Exception.Create('填报日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('所属部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  ClearInvaid;
  if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  //CheckInvaid;

  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.asString;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;

  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;

    cdsDetail.DisableControls;
    try
      DKpiMny := 0;
      DBudgMny := 0;
      DAgioMny := 0;
      DOthrMny := 0;
      i := 0;
      cdsDetail.First;
      while not cdsDetail.Eof do
        begin
          Inc(i);
          cdsDetail.Edit;
          cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
          cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
          cdsDetail.FieldByName('REQU_ID').AsString := cdsHeader.FieldbyName('REQU_ID').AsString;
          cdsDetail.FieldByName('SEQNO').AsInteger := i;
          DKpiMny := DKpiMny + cdsDetail.FieldbyName('KPI_MNY').asFloat;
          DBudgMny := DBudgMny + cdsDetail.FieldbyName('BUDG_MNY').asFloat;
          DAgioMny := DAgioMny + cdsDetail.FieldbyName('AGIO_MNY').asFloat;
          DOthrMny := DOthrMny + cdsDetail.FieldbyName('OTHR_MNY').asFloat;
          cdsDetail.Post;
          cdsDetail.Next;
        end;

    finally
      cdsDetail.EnableControls;
    end;
    cdsHeader.Edit;
    cdsHeader.FieldbyName('KPI_MNY').asFloat := DKpiMny;
    cdsHeader.FieldbyName('BUDG_MNY').asFloat := DBudgMny;
    cdsHeader.FieldbyName('AGIO_MNY').asFloat := DAgioMny;
    cdsHeader.FieldbyName('OTHR_MNY').asFloat := DOthrMny;
    cdsHeader.Post;

    Factor.AddBatch(cdsHeader,'TMktRequOrder');
    Factor.AddBatch(cdsDetail,'TMktRequData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    //cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmMktRequOrder.N1Click(Sender: TObject);
begin
  inherited;
  if cdsDetail.IsEmpty then Exit;
  if cdsDetail.FieldByName('KPI_ID').AsString = '' then Exit;
  cdsDetail.Delete;
end;

procedure TfrmMktRequOrder.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsDetail.Active then Exit;
  if cdsDetail.IsEmpty then Exit;
  //if not ShopGlobal.GetChkRight('100002143',1) then Raise Exception.Create('你没有查看指标的权限,请和管理员联系.');
  with TfrmKpiIndexInfo.Create(self) do
    begin
      try
        Open(cdsDetail.FieldByName('KPI_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
end;

procedure TfrmMktRequOrder.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(edtREQU_TYPE);
  inherited;
end;

end.
