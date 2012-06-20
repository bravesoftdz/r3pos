unit ufrmVhLeadOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  cxTextEdit, cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList;

type
  TfrmVhLeadOrder = class(TframeContractForm)
    Label3: TLabel;
    Label40: TLabel;
    lblSTOCK_DATE: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtLEAD_DATE: TcxDateEdit;
    edtLEAD_USER: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    edtVOUCHER_ID: TzrComboBoxList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    actNewVoucher: TAction;
    actDeleteVoucher: TAction;
    edtVOUCHER_AMOUNT: TcxTextEdit;
    Label8: TLabel;
    cdsVoucher: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtVOUCHER_IDEnter(Sender: TObject);
    procedure edtVOUCHER_IDExit(Sender: TObject);
    procedure edtVOUCHER_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtVOUCHER_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtVOUCHER_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure actNewVoucherExecute(Sender: TObject);
    procedure actDeleteVoucherExecute(Sender: TObject);
    procedure edtSHOP_IDPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState);override;
    procedure FocusNextColumn;
    procedure ShowInfo;
  public
    { Public declarations }
    Locked:Boolean;
    procedure ClearInvaid;override;
    procedure CheckInvaid;
    procedure InitRecord;override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;
  end;

implementation
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, ufrmBasic, ufrmMain, uDsUtil,
  uXDictFactory, DateUtils;
{$R *.dfm}

procedure TfrmVhLeadOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmVhLeadOrder.ClearInvaid;
var
  Field:TField;
  Controls:boolean;
  r:integer;
begin
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  Field := cdsDetail.FindField('AMOUNT');
  Controls := cdsDetail.ControlsDisabled;
  r := cdsDetail.RecNo;
  if not Controls then cdsDetail.DisableControls;
  Locked := True;
  try
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      if (cdsDetail.FieldByName('VOUCHER_ID').AsString = '')
         or
         ((Field<>nil) and (Field.AsFloat=0))
      then
         cdsDetail.Delete
      else
         cdsDetail.Next;
    end;
  finally
    if r>0 then cdsDetail.RecNo := r;
    Locked := False;
    if not Controls then cdsDetail.EnableControls;
  end;
end;

procedure TfrmVhLeadOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空领用礼券单!');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前领用礼券单?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;

  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TVhLeadOrder');
    Factor.AddBatch(cdsDetail,'TVhLeadData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  oid := '';
  gid := '';
  cid := AObj.FieldbyName('SHOP_ID').AsString;
  dbState := dsBrowse;
end;

procedure TfrmVhLeadOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');

  dbState := dsEdit;
  if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
end;

procedure TfrmVhLeadOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '入库仓库';
    end;
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //edtDEPT_ID.RangeField := 'DEPT_TYPE';
  //edtDEPT_ID.RangeValue := '1';
  edtLEAD_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  cdsVoucher.Close;
  cdsVoucher.SQL.Text :=
  'select A.VOUCHER_ID,C.CODE_NAME as VOUCHER_TYPE_TEXT,A.INTO_DATE,A.VAILD_DATE,A.VUCH_NAME,A.VOUCHER_PRC '+  //,count(B.VOUCHER_ID) as AMOUNT
  ' from SAL_VOUCHERORDER A inner join SAL_VOUCHERDATA B on A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
  ' left join PUB_PARAMS C on A.VOUCHER_TYPE=C.CODE_ID '+
  ' where A.TENANT_ID=:TENANT_ID and B.VOUCHER_STATUS=''1'' and C.TYPE_CODE=''VOUCHER_TYPE'' '+
  ' group by A.VOUCHER_ID,C.CODE_NAME,A.INTO_DATE,A.VAILD_DATE,A.VUCH_NAME,A.VOUCHER_PRC ';
  cdsVoucher.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(cdsVoucher);
end;

procedure TfrmVhLeadOrder.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  edtVOUCHER_ID.Visible := false;
  if DBGridEh1.CanFocus and Visible then DBGridEh1.SetFocus;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('VOUCHER_ID').AsString <>'') then
    begin
      cdsDetail.Append;
      cdsDetail.FieldByName('VOUCHER_ID').AsString := '';
      cdsDetail.Post;
    end;
  DbGridEh1.Col := 1 ;
  finally
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmVhLeadOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  edtLEAD_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  edtLEAD_USER.KeyValue := Global.UserID;
  edtLEAD_USER.Text := Global.UserName;
  AObj.FieldbyName('VHLEAD_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('VHLEAD_ID').asString;
  gid := '..新增..';

  InitRecord;
  if edtSHOP_ID.CanFocus and Visible then edtSHOP_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmVhLeadOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('VHLEAD_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TVhLeadOrder',Params);
      Factor.AddBatch(cdsDetail,'TVhLeadData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    dbState := dsBrowse;
    ReadFromObject(AObj,self);
    oid := AObj.FieldbyName('VHLEAD_ID').asString;
    gid := '';
    cid := AObj.FieldbyName('SHOP_ID').AsString;
  finally
    Params.Free;
  end;
end;

procedure TfrmVhLeadOrder.SaveOrder;
begin
  inherited;
  Saved := false;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  if edtLEAD_DATE.EditValue = null then Raise Exception.Create('领用日期不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('领用部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  ClearInvaid;
  if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空领用礼券单...');
  CheckInvaid;
  cdsDetail.DisableControls;
  try
    WriteToObject(AObj,self);
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cid := edtSHOP_ID.asString;
    AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    AObj.FieldByName('CREA_USER').AsString := Global.UserID;

    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      cdsDetail.Edit;
      cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
      cdsDetail.FieldByName('VHLEAD_ID').AsString := cdsHeader.FieldbyName('VHLEAD_ID').AsString;
      cdsDetail.Post;
      cdsDetail.Next;
    end;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TVhLeadOrder');
      Factor.AddBatch(cdsDetail,'TVhLeadData');
      Factor.CommitBatch;
      Saved := true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      Raise;
    end;
  finally
    cdsDetail.EnableControls;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmVhLeadOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;

end;

procedure TfrmVhLeadOrder.DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'VOUCHER_ID_TEXT' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       R.Right := Rect.Right;

       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个',[Inttostr(cdsDetail.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh1.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmVhLeadOrder.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Locked := True;
       FocusNextColumn;
       Key := #0;
       Locked := False;
     end;
end;

procedure TfrmVhLeadOrder.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  {if cdsDetail.RecordCount > cdsDetail.RecNo then
  begin
     cdsDetail.Next;
     Exit;
  end;}
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsDetail.FieldbyName('VOUCHER_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsDetail.FieldbyName('VOUCHER_ID').asString)<>'') then
              begin
                 cdsDetail.Next ;
                 if cdsDetail.Eof then
                    begin
                      InitRecord;
                    end;
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmVhLeadOrder.edtVOUCHER_IDEnter(Sender: TObject);
begin
  inherited;
  edtVOUCHER_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmVhLeadOrder.edtVOUCHER_IDExit(Sender: TObject);
begin
  inherited;
  if not edtVOUCHER_ID.DropListed then edtVOUCHER_ID.Visible := False;
end;

procedure TfrmVhLeadOrder.edtVOUCHER_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Locked := True;
  if (Key=VK_RIGHT) and not edtVOUCHER_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       edtVOUCHER_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtVOUCHER_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtVOUCHER_ID.Visible := false;
       cdsDetail.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtVOUCHER_ID.DropListed then
     begin
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('VOUCHER_ID').AsString='') then
         edtVOUCHER_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtVOUCHER_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('VOUCHER_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  Locked := False;
  inherited;
end;

procedure TfrmVhLeadOrder.edtVOUCHER_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       Locked := True;
       if cdsDetail.FieldbyName('VOUCHER_ID').AsString = '' then
          begin
            edtVOUCHER_ID.DropList;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
       Locked := False;
     end;
end;

procedure TfrmVhLeadOrder.edtVOUCHER_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  edtVOUCHER_ID.Text := '';
  edtVOUCHER_ID.KeyValue := null;
end;
begin

  inherited;
  if not cdsDetail.Active then Exit;
  if cdsDetail.FieldbyName('VOUCHER_ID').AsString = edtVOUCHER_ID.AsString then exit;

  if (edtVOUCHER_ID.AsString='') and edtVOUCHER_ID.Focused then   //and ShopGlobal.GetChkRight('32600001',2)
     Raise Exception.Create('没找到你想查找的礼券本？');

  cdsDetail.DisableControls;
  try
    if VarIsNull(edtVOUCHER_ID.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      if cdsDetail.Locate('VOUCHER_ID',edtVOUCHER_ID.AsString,[]) then
         begin
           Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.GoodsRepeat','"%s"同一礼券名称重复录入,请核对输入是否正确.',[edtVOUCHER_ID.Text]));
         end
      else
         begin
            cdsDetail.Edit;
            cdsDetail.FieldByName('VOUCHER_ID').AsString := edtVOUCHER_ID.AsString;
            cdsDetail.FieldByName('VOUCHER_ID_TEXT').AsString := edtVOUCHER_ID.Text;
            cdsDetail.FieldByName('AMOUNT').AsFloat := 1;
            cdsDetail.FieldByName('VOUCHER_PRC').AsInteger := edtVOUCHER_ID.DataSet.FieldByName('VOUCHER_PRC').AsInteger;
            cdsDetail.FieldByName('VOUCHER_TTL').AsFloat := edtVOUCHER_ID.DataSet.FieldByName('VOUCHER_PRC').AsInteger;
            cdsDetail.Post;
         end;
      //ShowInfo;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmVhLeadOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtVOUCHER_ID.Text := cdsDetail.FieldbyName('VOUCHER_ID_TEXT').AsString;
  edtVOUCHER_ID.KeyValue := cdsDetail.FieldbyName('VOUCHER_ID').AsString;
  edtVOUCHER_ID.SaveStatus;
end;

procedure TfrmVhLeadOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;  
begin
  inherited;
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
  {if r > edtVOUCHER_AMOUNT.EditValue then
  begin
     TColumnEh(Sender).Field.asFloat := edtVOUCHER_AMOUNT.EditValue;
     Text := TColumnEh(Sender).Field.AsString;
     Value := TColumnEh(Sender).Field.asFloat;
     cdsDetail.FieldByName('VOUCHER_TTL').AsFloat := r * cdsDetail.FieldByName('VOUCHER_PRC').AsFloat;
     if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
     cdsDetail.Edit;
     Raise Exception.Create('输入数值大于当前礼券数!');
  end; }
  cdsDetail.FieldByName('VOUCHER_TTL').AsFloat := r * cdsDetail.FieldByName('VOUCHER_PRC').AsFloat;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  cdsDetail.Edit;
end;

procedure TfrmVhLeadOrder.actNewVoucherExecute(Sender: TObject);
begin
  inherited;
  InitRecord;
end;

procedure TfrmVhLeadOrder.actDeleteVoucherExecute(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if MessageBox(Handle,pchar('确认删除"'+cdsDetail.FieldbyName('VOUCHER_ID_TEXT').AsString+'"礼券吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
  begin
     edtVOUCHER_ID.Visible := Visible;
     cdsDetail.Delete;
     DBGridEh1.SetFocus;
  end;
end;

procedure TfrmVhLeadOrder.ShowInfo;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
    ' select count(B.VOUCHER_ID) as AMOUNT from SAL_VOUCHERORDER A, SAL_VOUCHERDATA B where A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
    ' and A.TENANT_ID=:TENANT_ID and A.VOUCHER_ID=:VOUCHER_ID and B.VOUCHER_STATUS=''1'' group by B.VOUCHER_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('VOUCHER_ID').AsString := cdsDetail.FieldByName('VOUCHER_ID').AsString;
    Factor.Open(rs);
    edtVOUCHER_AMOUNT.EditValue := rs.FieldByName('AMOUNT').AsFloat;
  finally
    rs.Free;
  end;
end;

procedure TfrmVhLeadOrder.edtSHOP_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  TabSheet.Caption := edtSHOP_ID.Text;
end;

procedure TfrmVhLeadOrder.CheckInvaid;
var
  Field:TField;
  Controls:boolean;
  r:integer;
begin
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  Controls := cdsDetail.ControlsDisabled;
  r := cdsDetail.RecNo;
  if not Controls then cdsDetail.DisableControls;
  Locked := True;
  try
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      if (cdsDetail.FieldByName('SUMMARY').AsString = '') then Raise Exception.Create('"摘要"不能为空!');
      cdsDetail.Next;
    end;
  finally
    if r>0 then cdsDetail.RecNo := r;
    Locked := False;
    if not Controls then cdsDetail.EnableControls;
  end;
end;

end.
