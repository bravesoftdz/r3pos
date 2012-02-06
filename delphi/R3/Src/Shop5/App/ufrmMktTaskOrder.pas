unit ufrmMktTaskOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, cxControls, cxContainer, cxEdit, ZBase,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, RzLabel, zrYearEdit,
  cxMemo, cxSpinEdit;

type
  TfrmMktTaskOrder = class(TframeContractForm)
    RzLabel2: TRzLabel;
    Label3: TLabel;
    edtPLAN_DATE: TcxDateEdit;
    edtDEPT_ID: TzrComboBoxList;
    edtPLAN_USER: TzrComboBoxList;
    Label2: TLabel;
    labBEGIN_DATE: TRzLabel;
    edtBEGIN_DATE: TcxDateEdit;
    RzLabel1: TRzLabel;
    edtEND_DATE: TcxDateEdit;
    RzLabel7: TRzLabel;
    Label4: TLabel;
    RzLabel10: TRzLabel;
    edtREMARK: TcxMemo;
    PopupMenu1: TPopupMenu;
    edtKPI_ID: TzrComboBoxList;
    cdsKPI_ID: TZQuery;
    RzLabel9: TRzLabel;
    Label5: TLabel;
    Delete: TMenuItem;
    edtCHK_USER: TcxTextEdit;
    edtCHK_DATE: TcxTextEdit;
    edtKPI_YEAR: TcxSpinEdit;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure edtKPI_IDEnter(Sender: TObject);
    procedure edtKPI_IDExit(Sender: TObject);
    procedure edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_IDSaveValue(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtKPI_YEARPropertiesChange(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure edtPLAN_USERPropertiesChange(Sender: TObject);
    procedure edtPLAN_USERSaveValue(Sender: TObject);
  private
    { Private declarations }
    procedure FocusNextColumn;
    procedure SetdbState(const Value: TDataSetState);override;
    function GetIsNull: boolean;override;
  public
    { Public declarations }
    RowID:Integer;

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
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, uDsUtil, ufrmBasic, uXDictFactory,
     ufrmKpiIndexInfo;
{$R *.dfm}

procedure TfrmMktTaskOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售计划单执行弃审');
       if MessageBox(Handle,'确认弃审当前销售计划单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前销售计划单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('PLAN_ID').asString := cdsHeader.FieldbyName('PLAN_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TMktTaskOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TMktTaskOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
{    IsAudit := not IsAudit;
    if IsAudit then
       begin
         edtCHK_DATE.Text := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         edtCHK_USER_TEXT.Text := Global.UserName;
         AObj.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         AObj.FieldByName('CHK_USER').AsString := Global.UserID;
       end
    else
       begin
         edtCHK_DATE.Text := '';
         edtCHK_USER_TEXT.Text := '';
         AObj.FieldByName('CHK_DATE').AsString := '';
         AObj.FieldByName('CHK_USER').AsString := '';
       end;
    cdsHeader.Edit;
    cdsHeader.FieldByName('CHK_DATE').AsString := AObj.FieldByName('CHK_DATE').AsString;
    cdsHeader.FieldByName('CHK_USER').AsString := AObj.FieldByName('CHK_USER').AsString;
    cdsHeader.Post;
    cdsHeader.CommitUpdates;
}
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
end;

procedure TfrmMktTaskOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmMktTaskOrder.DeleteOrder;
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
    Factor.AddBatch(cdsHeader,'TMktTaskOrder');
    Factor.AddBatch(cdsDetail,'TMktTaskData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('PLAN_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
end;

procedure TfrmMktTaskOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;

  if edtPLAN_USER.CanFocus then edtPLAN_USER.SetFocus;
end;

procedure TfrmMktTaskOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '所属仓库';
    end;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL,UNIT_NAME from MKT_KPI_INDEX where IDX_TYPE in (''3'') and COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID);
  Factor.Open(cdsKPI_ID);

  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
  edtPLAN_USER.DataSet := Global.GetZQueryFromName('CA_USERS');

end;

procedure TfrmMktTaskOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));

  rs := ShopGlobal.GetDeptInfo;
  edtPLAN_USERSaveValue(nil);
  {edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;}
  edtBEGIN_DATE.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-01-01', date()));
  edtEND_DATE.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-12-31', date()));  
  AObj.FieldbyName('PLAN_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('PLAN_ID').asString;
  gid := '..新增..';
  edtPLAN_DATE.Date := Global.SysDate;
  edtPLAN_USER.KeyValue := Global.UserID;
  edtPLAN_USER.Text := Global.UserName;

  InitRecord;
  if edtPLAN_USER.CanFocus and Visible then edtPLAN_USER.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmMktTaskOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('PLAN_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TMktTaskOrder',Params);
      Factor.AddBatch(cdsDetail,'TMktTaskData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    edtKPI_YEAR.Value := AObj.FieldByName('KPI_YEAR').AsInteger; 
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('PLAN_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    RowID := cdsDetail.RecordCount;
  finally
    Params.Free;
  end;
end;

procedure TfrmMktTaskOrder.SaveOrder;
var mny,bny,amt:real;
    R:Integer;
    Params:TftParamList;
begin
  inherited;
  Saved := false;
  cdsDetail.DisableControls;
  try
    if edtPLAN_DATE.EditValue = null then Raise Exception.Create('签约日期不能为空');
    if edtPLAN_USER.AsString = '' then Raise Exception.Create('业务员不能为空');
    if edtDEPT_ID.AsString = '' then Raise Exception.Create('部门不能为空');
    if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
       if cdsDetail.FieldByName('KPI_ID').AsString = '' then
          cdsDetail.Delete
       else
          cdsDetail.Next;
    end;
    if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空销售计划单据...');
    WriteToObject(AObj,self);
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cid := edtSHOP_ID.asString;
    AObj.FieldByName('KPI_YEAR').AsInteger := edtKPI_YEAR.Value;
    AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    AObj.FieldByName('CLIENT_ID').AsString := inttostr(Global.TENANT_ID);
    AObj.FieldByName('CREA_USER').AsString := Global.UserID;
    AObj.FieldByName('PLAN_TYPE').AsString := '2';

    Factor.BeginBatch;
    try
      cdsHeader.Edit;
      AObj.WriteToDataSet(cdsHeader);
      cdsHeader.Post;
      mny := 0;
      bny := 0;
      amt := 0;
      R := 0;
      cdsDetail.First;
      while not cdsDetail.Eof do
      begin
        Inc(R);
        cdsDetail.Edit;
        cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
        cdsDetail.FieldByName('PLAN_ID').AsString := cdsHeader.FieldbyName('PLAN_ID').AsString;
        cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
        cdsDetail.FieldByName('SEQNO').AsInteger := R;
        mny := mny + cdsDetail.FieldbyName('AMONEY').asFloat;
        bny := bny + cdsDetail.FieldbyName('BOND_MNY').asFloat;
        amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;
        cdsDetail.Post;
        cdsDetail.Next;
      end;
      cdsHeader.Edit;
      cdsHeader.FieldbyName('PLAN_MNY').asFloat := mny;
      cdsHeader.FieldbyName('BOND_MNY').asFloat := bny;
      cdsHeader.FieldbyName('PLAN_AMT').asFloat := amt;
      cdsHeader.Post;
      Params := TftParamList.Create(nil);
      try
        Factor.AddBatch(cdsHeader,'TMktTaskOrder',Params);
        Factor.AddBatch(cdsDetail,'TMktTaskData',Params);
        Factor.CommitBatch;
      finally
        Params.Free;
      end;
      Saved := true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      //cdsDetail.CancelUpdates;
      Raise;
    end;
  finally
    cdsDetail.EnableControls;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmMktTaskOrder.edtKPI_IDEnter(Sender: TObject);
begin
  inherited;
  edtKPI_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktTaskOrder.edtKPI_IDExit(Sender: TObject);
begin
  inherited;
  if not edtKPI_ID.DropListed then edtKPI_ID.Visible := False;
end;

procedure TfrmMktTaskOrder.edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
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
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('PLAN_ID').AsString='') then
         edtKPI_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtKPI_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('PLAN_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;

end;

procedure TfrmMktTaskOrder.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
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
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmMktTaskOrder.InitRecord;
var tmp:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  edtKPI_ID.Visible := false;
  if DBGridEh1.CanFocus and Visible then DBGridEh1.SetFocus;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('KPI_ID').AsString <>'') then
    begin
      inc(RowID);
      cdsDetail.Append;
      cdsDetail.FieldByName('PLAN_ID').Value := null;
      if cdsDetail.FindField('SEQNO')<> nil then
         cdsDetail.FindField('SEQNO').asInteger := RowID;

      cdsDetail.Post;
      cdsDetail.Edit;
    end;
  DbGridEh1.Col := 1 ;

  finally
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktTaskOrder.edtKPI_IDKeyPress(Sender: TObject;
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

procedure TfrmMktTaskOrder.edtKPI_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  edtKPI_ID.Text := '';
  edtKPI_ID.KeyValue := null;
end;
begin
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
           Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.GoodsRepeat','"%s"指标重复录入,请核对输入是否正确.',[edtKPI_ID.Text]));
         end
      else
         begin
           cdsDetail.Edit;
           cdsDetail.FieldByName('KPI_ID').AsString := edtKPI_ID.AsString;
           cdsDetail.FieldByName('KPI_ID_TEXT').AsString := edtKPI_ID.Text;
           cdsDetail.FieldByName('UNIT_NAME').AsString := edtKPI_ID.DataSet.FieldByName('UNIT_NAME').AsString;
         end;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktTaskOrder.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmMktTaskOrder.SetdbState(const Value: TDataSetState);
var Column:TColumnEh;
begin
  Column := FindColumn('KPI_ID_TEXT');
  if Column<>nil then Column.ReadOnly := true;
  inherited;
end;

procedure TfrmMktTaskOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail.FieldbyName('KPI_ID_TEXT').AsString;
  edtKPI_ID.KeyValue := cdsDetail.FieldbyName('KPI_ID').AsString;
  edtKPI_ID.SaveStatus;
end;

function TfrmMktTaskOrder.GetIsNull: boolean;
begin
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      if cdsDetail.FieldByName('KPI_ID').AsString = '' then
         cdsDetail.Delete
      else
         cdsDetail.Next;
    end;
  inherited GetIsNull;
end;

procedure TfrmMktTaskOrder.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmMktTaskOrder.edtKPI_YEARPropertiesChange(Sender: TObject);
begin
  inherited;
  if (edtKPI_YEAR.Value < 2000) or (edtKPI_YEAR.Value > 2111) then Exit;
  if edtBEGIN_DATE.EditValue = null then
     edtBEGIN_DATE.Date := fnTime.fnStrtoDate(FormatDateTime(IntToStr(edtKPI_YEAR.Value)+'-01-01', date()))
  else
     edtBEGIN_DATE.Date := fnTime.fnStrtoDate(IntToStr(edtKPI_YEAR.Value)+copy(FormatDateTime('YYYY-MM-DD',edtBEGIN_DATE.Date),5,6));

  if edtEND_DATE.EditValue = null then
     edtEND_DATE.Date := fnTime.fnStrtoDate(FormatDateTime(IntToStr(edtKPI_YEAR.Value)+'-12-31', date()))
  else
     edtEND_DATE.Date := fnTime.fnStrtoDate(IntToStr(edtKPI_YEAR.Value)+copy(FormatDateTime('YYYY-MM-DD',edtEND_DATE.Date),5,6));
end;

procedure TfrmMktTaskOrder.DeleteClick(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not cdsDetail.IsEmpty and (MessageBox(Handle,pchar('确认删除"'+cdsDetail.FieldbyName('KPI_ID_TEXT').AsString+'"指标吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       edtKPI_ID.Visible := Visible;
       cdsDetail.Delete;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmMktTaskOrder.DBGridEh1DrawFooterCell(Sender: TObject;
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
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s笔',[Inttostr(cdsDetail.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh1.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktTaskOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtSHOP_ID.Text)<>'' then TabSheet.Caption := edtSHOP_ID.Text;
end;

procedure TfrmMktTaskOrder.N1Click(Sender: TObject);
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

procedure TfrmMktTaskOrder.edtPLAN_USERPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtPLAN_USER.Text)<>'' then TabSheet.Caption := edtPLAN_USER.Text;
end;

procedure TfrmMktTaskOrder.edtPLAN_USERSaveValue(Sender: TObject);
var ds:TZQuery;
begin
  inherited;
  ds := ShopGlobal.GetZQueryFromName('CA_DEPT_INFO');
  if ds.Locate('DEPT_ID',edtPLAN_USER.DataSet.FieldByName('DEPT_ID').AsString,[]) then
  begin
     edtDEPT_ID.KeyValue := ds.FieldByName('DEPT_ID').AsString;
     edtDEPT_ID.Text := ds.FieldByName('DEPT_NAME').AsString;
  end;
  ds := ShopGlobal.GetZQueryFromName('CA_SHOP_INFO');
  if ds.Locate('SHOP_ID',edtPLAN_USER.DataSet.FieldByName('SHOP_ID').AsString,[]) then
  begin
     edtSHOP_ID.KeyValue := ds.FieldByName('SHOP_ID').AsString;
     edtSHOP_ID.Text := ds.FieldByName('SHOP_NAME').AsString;
  end;
end;

end.
