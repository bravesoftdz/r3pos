unit ufrmMktBudgOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase, ObjCommon,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, RzLabel;

type
  TfrmMktBudgOrder = class(TframeContractForm)
    lblBUDG_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label40: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtBUDG_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtSHOP_ID: TzrComboBoxList;
    edtDEPT_ID: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    cdsKPI_ID: TZQuery;
    edtKPI_ID: TzrComboBoxList;
    edtACTIVE_ID: TzrComboBoxList;
    CdsActive: TZQuery;
    edtREQU_ID_TEXT: TcxButtonEdit;
    Label21: TLabel;
    Label6: TLabel;
    edtBUDG_USER: TzrComboBoxList;
    RzLabel3: TRzLabel;
    edtBUDG_VRF: TcxTextEdit;
    cdsBudgShare: TZQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure edtKPI_IDEnter(Sender: TObject);
    procedure edtKPI_IDExit(Sender: TObject);
    procedure edtACTIVE_IDEnter(Sender: TObject);
    procedure edtACTIVE_IDExit(Sender: TObject);
    procedure edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_IDSaveValue(Sender: TObject);
    procedure edtACTIVE_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtREQU_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtBUDG_USERAddClick(Sender: TObject);
    procedure edtACTIVE_IDSaveValue(Sender: TObject);
    procedure edtACTIVE_IDKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns2BeforeShowControl(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
  private
    { Private declarations }
    FromId:String;
    procedure FocusNextColumn;
    procedure SetdbState(const Value: TDataSetState);override;
    function Changed:Boolean;
    procedure ShareCost; //分摊核销费用
    function IsNull:Boolean;
  public
    { Public declarations }
    RowID:Integer;
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
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, ufrmBasic, ufrmMain, uDsUtil,
  uXDictFactory, ufrmKpiIndexInfo, ufrmFindRequOrder, ufrmUsersInfo, DateUtils;
{$R *.dfm}

procedure TfrmMktBudgOrder.AuditOrder;
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
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前市场活动费核销单执行弃审');
       if MessageBox(Handle,'确认弃审当前市场活动费核销单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前市场活动费核销单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('BUDG_ID').asString := cdsHeader.FieldbyName('BUDG_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TMktBudgOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TMktBudgOrderUnAudit',Params);
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    //IsAudit := not IsAudit;
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
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
end;

procedure TfrmMktBudgOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmMktBudgOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前核销单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TMktBudgOrder');
    Factor.AddBatch(cdsDetail,'TMktBudgData');
    Factor.AddBatch(cdsBudgShare,'TMktBudgShare');
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
    oid := AObj.FieldbyName('BUDG_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
end;

procedure TfrmMktBudgOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  if AObj.FieldByName('REQU_ID').AsString <> '' then
  begin
    cdsKPI_ID.Close;
    cdsKPI_ID.SQL.Text := ' select C.KPI_ID,C.KPI_NAME,C.KPI_SPELL from MKT_REQUORDER A left join MKT_REQUDATA B on A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID '+
    ' left join MKT_KPI_INDEX C on B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
    ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.REQU_ID='+QuotedStr(AObj.FieldByName('REQU_ID').AsString)+' and A.COMM not in (''02'',''12'') ';
    Factor.Open(cdsKPI_ID);
  end;
  dbState := dsEdit;
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmMktBudgOrder.FocusNextColumn;
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

procedure TfrmMktBudgOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '核销仓库';
    end;

  CdsActive.Close;
  CdsActive.SQL.Text := ' select ACTIVE_ID,ACTIVE_NAME,ACTIVE_SPELL from MKT_ACTIVE_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''02'',''12'') ';
  Factor.Open(CdsActive);

  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //edtDEPT_ID.RangeField := 'DEPT_TYPE';
  //edtDEPT_ID.RangeValue := '1';
  edtBUDG_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
end;

procedure TfrmMktBudgOrder.InitRecord;
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
      cdsDetail.FieldByName('BUDG_ID').Value := null;
      if cdsDetail.FindField('SEQNO')<> nil then
         cdsDetail.FindField('SEQNO').asInteger := RowID;
      cdsDetail.Post;
    end;
  DbGridEh1.Col := 1 ;
  finally
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmMktBudgOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtBUDG_DATE.Date := Global.SysDate;

  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  AObj.FieldbyName('BUDG_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('BUDG_ID').asString;
  gid := '..新增..';

  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmMktBudgOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('BUDG_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TMktBudgOrder',Params);
      Factor.AddBatch(cdsDetail,'TMktBudgData',Params);
      Factor.AddBatch(cdsBudgShare,'TMktBudgShare',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('BUDG_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    FromId := AObj.FieldByName('REQU_ID').AsString;
    RowID := cdsDetail.RecordCount;
  finally
    Params.Free;
  end;
end;

procedure TfrmMktBudgOrder.SaveOrder;
var mny:real;
    R:Integer;
    ParamsClint:TftParamList;
begin
  inherited;
  Saved := false;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  cdsDetail.DisableControls;
  try
    if edtBUDG_DATE.EditValue = null then Raise Exception.Create('签约日期不能为空');
    if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
    if edtDEPT_ID.AsString = '' then Raise Exception.Create('部门不能为空');
    if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
    ClearInvaid;
    if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空核销单据...');

    WriteToObject(AObj,self);
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cid := edtSHOP_ID.asString;
    AObj.FieldByName('REQU_ID').AsString := FromId;
    AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    AObj.FieldByName('CREA_USER').AsString := Global.UserID;

    Factor.BeginBatch;
    try
      cdsHeader.Edit;
      AObj.WriteToDataSet(cdsHeader);
      cdsHeader.Post;
      mny := 0;
      R := 0;
      cdsDetail.First;
      while not cdsDetail.Eof do
         begin
           Inc(R);
           cdsDetail.Edit;
           cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
           cdsDetail.FieldByName('BUDG_ID').AsString := cdsHeader.FieldbyName('BUDG_ID').AsString;
           cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
           cdsDetail.FieldByName('SEQNO').AsInteger := R;
           mny := mny + cdsDetail.FieldbyName('BUDG_VRF').asFloat;
           cdsDetail.Post;
           cdsDetail.Next;
         end;
      cdsHeader.Edit;
      cdsHeader.FieldbyName('BUDG_VRF').asFloat := mny;
      cdsHeader.Post;
      ShareCost;
      ParamsClint := TftParamList.Create;
      try
        ParamsClint.ParamByName('CLIENT_ID').AsString := cdsHeader.FieldbyName('CLIENT_ID').AsString;
        Factor.AddBatch(cdsHeader,'TMktBudgOrder');
        Factor.AddBatch(cdsDetail,'TMktBudgData');
        Factor.AddBatch(cdsBudgShare,'TMktBudgShare',ParamsClint);
        Factor.CommitBatch;
      finally
        ParamsClint.Free;
      end;
      Saved := true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      cdsDetail.CancelUpdates;
      cdsBudgShare.CancelUpdates;
      Raise;
    end;
  finally
    cdsDetail.EnableControls;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmMktBudgOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;

end;

procedure TfrmMktBudgOrder.edtKPI_IDEnter(Sender: TObject);
begin
  inherited;
  edtKPI_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktBudgOrder.edtKPI_IDExit(Sender: TObject);
begin
  inherited;
  if not edtKPI_ID.DropListed then edtKPI_ID.Visible := False;
end;

procedure TfrmMktBudgOrder.edtACTIVE_IDEnter(Sender: TObject);
begin
  inherited;
  edtACTIVE_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktBudgOrder.edtACTIVE_IDExit(Sender: TObject);
begin
  inherited;
  if not edtACTIVE_ID.DropListed then edtACTIVE_ID.Visible := False;
end;

procedure TfrmMktBudgOrder.edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
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
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('KPI_ID').AsString='') then
         edtKPI_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtKPI_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('KPI_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;
end;

procedure TfrmMktBudgOrder.edtKPI_IDKeyPress(Sender: TObject;
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

procedure TfrmMktBudgOrder.edtKPI_IDSaveValue(Sender: TObject);
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
       MessageBox(Handle,'请先选择经销商后再录单。','友情提示...',MB_OK+MB_ICONINFORMATION);
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
       cdsDetail.Edit;
       cdsDetail.FieldByName('KPI_ID').AsString := edtKPI_ID.AsString;
       cdsDetail.FieldByName('KPI_ID_TEXT').AsString := edtKPI_ID.Text;
       cdsDetail.Post;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmMktBudgOrder.edtACTIVE_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtACTIVE_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       edtACTIVE_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtACTIVE_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtACTIVE_ID.Visible := false;
       cdsDetail.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtACTIVE_ID.DropListed then
     begin
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('ACTIVE_ID').AsString='') then
         edtACTIVE_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtACTIVE_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('ACTIVE_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;
end;

procedure TfrmMktBudgOrder.edtREQU_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var g,uid,utext:string;
begin
  if edtCLIENT_ID.AsString = '' then
     begin
       MessageBox(Handle,'请先选择经销商后再录单.','友情提示...',MB_OK+MB_ICONINFORMATION);
       edtCLIENT_ID.SetFocus;
       Exit;
     end;
  inherited;
  //if not IsNull then Raise Exception.Create('已经输入指标,不能导入申领单号.');
  if dbState <> dsInsert then Raise Exception.Create('只有不是新增状态的单据不能导入申领单号.');
  FromId := TfrmFindRequOrder.FindDialog(self,edtCLIENT_ID.asString,g,uid,utext);
  if FromId<>'' then
     begin
       edtREQU_ID_TEXT.Text := g;
       edtBUDG_USER.KeyValue := uid;
       edtBUDG_USER.Text := utext;

       cdsKPI_ID.Close;
       cdsKPI_ID.SQL.Text := ' select C.KPI_ID,C.KPI_NAME,C.KPI_SPELL from MKT_REQUORDER A '+
                             ' left join MKT_REQUDATA B on A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID '+
                             ' left join MKT_KPI_INDEX C on B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID '+
                             ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.REQU_ID='+QuotedStr(FromId)+
                             ' and A.COMM not in (''02'',''12'') ';
       Factor.Open(cdsKPI_ID);
     end;
end;

function TfrmMktBudgOrder.IsNull: Boolean;
begin
  Result := cdsDetail.IsEmpty;
end;

procedure TfrmMktBudgOrder.edtBUDG_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtBUDG_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtBUDG_USER.Text := r.FieldbyName('USER_NAME').AsString;;
       end;
  finally
    r.Free;
  end;
end;

procedure TfrmMktBudgOrder.ClearInvaid;
var
  Field:TField;
  Controls:boolean;
  r:integer;
begin
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  Field := cdsDetail.FindField('BUDG_VRF');
  Controls := cdsDetail.ControlsDisabled;
  r := cdsDetail.RecNo;
  cdsDetail.DisableControls;
  try
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      if (cdsDetail.FieldByName('KPI_ID').AsString = '')
         or
         (cdsDetail.FieldByName('ACTIVE_ID').AsString = '')
         or
         ((Field<>nil) and (Field.AsFloat=0))
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

procedure TfrmMktBudgOrder.edtACTIVE_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  edtACTIVE_ID.Text := '';
  edtACTIVE_ID.KeyValue := null;
end;
begin
  if cdsDetail.FieldbyName('KPI_ID').AsString = '' then
     begin
       MessageBox(Handle,'请先选择指标名称。','友情提示...',MB_OK+MB_ICONINFORMATION);
       DBGridEh1.Col := 1;
       Exit;
     end;
  inherited;
  if not cdsDetail.Active then Exit;
  if cdsDetail.FieldbyName('ACTIVE_ID').AsString=edtACTIVE_ID.AsString then exit;

  if (edtACTIVE_ID.AsString='') and edtACTIVE_ID.Focused then   //and ShopGlobal.GetChkRight('32600001',2)
     Raise Exception.Create('没找到你想查找的活动名称？');

  cdsDetail.DisableControls;
  try
    if VarIsNull(edtACTIVE_ID.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      if cdsDetail.Locate('KPI_ID,ACTIVE_ID',VarArrayOf([edtKPI_ID.AsString,edtACTIVE_ID.AsString]),[]) then
         begin
           Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.GoodsRepeat','"%s"同一指标中活动名称重复录入,请核对输入是否正确.',[edtACTIVE_ID.Text]));
         end
      else
         begin
           cdsDetail.Edit;
           cdsDetail.FieldByName('ACTIVE_ID').AsString := edtACTIVE_ID.AsString;
           cdsDetail.FieldByName('ACTIVE_ID_TEXT').AsString := edtACTIVE_ID.Text;
           cdsDetail.Post;
         end;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmMktBudgOrder.edtACTIVE_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if cdsDetail.FieldbyName('ACTIVE_ID').AsString = '' then
          begin
            edtACTIVE_ID.DropList;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmMktBudgOrder.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmMktBudgOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;
end;

procedure TfrmMktBudgOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail.FieldbyName('KPI_ID_TEXT').AsString;
  edtKPI_ID.KeyValue := cdsDetail.FieldbyName('KPI_ID').AsString;
  edtKPI_ID.SaveStatus;
end;

procedure TfrmMktBudgOrder.DBGridEh1Columns2BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtACTIVE_ID.Text := cdsDetail.FieldbyName('ACTIVE_ID_TEXT').AsString;
  edtACTIVE_ID.KeyValue := cdsDetail.FieldbyName('ACTIVE_ID').AsString;
  edtACTIVE_ID.SaveStatus;
end;

procedure TfrmMktBudgOrder.N1Click(Sender: TObject);
var r:Integer;
begin
  inherited;
  if not cdsDetail.Active then Exit;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  if cdsDetail.FieldByName('KPI_ID').AsString = '' then Exit;
  r := cdsDetail.FieldByName('SEQNO').AsInteger;
  cdsDetail.DisableControls;
  try
    cdsDetail.SortedFields := 'KPI_ID';
    cdsDetail.Filtered := False;
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      if cdsDetail.FieldByName('SEQNO').AsInteger >= r then
      begin
         cdsDetail.Edit;
         cdsDetail.FieldByName('SEQNO').AsInteger := cdsDetail.FieldByName('SEQNO').AsInteger + 1;
         cdsDetail.Post;
      end;
      cdsDetail.Next;
    end;
    inc(RowID);
    cdsDetail.Append;
    cdsDetail.FieldByName('BUDG_ID').Value := null;
    if cdsDetail.FindField('SEQNO')<> nil then
       cdsDetail.FindField('SEQNO').asInteger := RowID;
    cdsDetail.Post;
    cdsDetail.SortedFields := 'SEQNO';
    cdsDetail.Locate('SEQNO',r,[]);
    cdsDetail.Edit;
    edtKPI_ID.KeyValue := Null;
    edtKPI_ID.Text := '';
    DBGridEh1.Col := 1;
  finally
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktBudgOrder.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsDetail.IsEmpty then Exit;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if MessageBox(Handle,pchar('确认删除"'+cdsDetail.FieldbyName('KPI_ID_TEXT').AsString+'"指标吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
  begin
     edtKPI_ID.Visible := Visible;
     cdsDetail.Delete;
     DBGridEh1.SetFocus;
  end;
end;

procedure TfrmMktBudgOrder.ShareCost;
var ds:TZQuery;
    i:Integer;
    BudgMny,LastMny:Real;
    Text_Sql:String;
begin
  if not Changed then Exit; 
  ds := TZQuery.Create(nil);
  i := 0;
  try
    cdsBudgShare.First;
    while not cdsBudgShare.Eof do cdsBudgShare.Delete;

    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      BudgMny := cdsDetail.FieldByName('BUDG_VRF').AsFloat;
      ds.Close;
      Text_Sql := ' select A.REQU_ID,A.KPI_ID,A.KPI_YEAR,A.BUDG_MNY,A.BUDG_MNY+isnull(B.BUDG_VRF,0)-isnull(A.BUDG_VRF,0) as BLA_MNY '+
      ' from MKT_REQUDATA A left join MKT_BUDGSHARE B on A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and A.KPI_ID=B.KPI_ID and A.KPI_YEAR=B.KPI_YEAR '+
      ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.REQU_ID='+QuotedStr(FromId)+' and A.BUDG_MNY<>isnull(A.BUDG_VRF,0) order by A.KPI_YEAR ';
      ds.SQL.Text := ParseSQL(Factor.iDbType,Text_Sql);
      Factor.Open(ds);
      ds.First;
      while not ds.Eof do
      begin
        if BudgMny > 0 then
        begin
           if cdsBudgShare.Locate('KPI_ID,KPI_YEAR',VarArrayOf([ds.FieldByName('KPI_ID').AsString,ds.FieldByName('KPI_YEAR').AsInteger]),[]) then
           begin
             LastMny := cdsBudgShare.FieldByName('BUDG_VRF').AsFloat;
             cdsBudgShare.Edit;
             if BudgMny >= ds.FieldByName('BLA_MNY').AsFloat then
                cdsBudgShare.FieldByName('BUDG_VRF').AsFloat := cdsBudgShare.FieldByName('BUDG_VRF').AsFloat+ds.FieldByName('BLA_MNY').AsFloat
             else
                cdsBudgShare.FieldByName('BUDG_VRF').AsFloat := cdsBudgShare.FieldByName('BUDG_VRF').AsFloat+BudgMny;
             cdsBudgShare.Post;
             BudgMny := BudgMny - ds.FieldByName('BLA_MNY').AsFloat+LastMny;
           end
           else
           begin
             inc(i);
             cdsBudgShare.Append;
             cdsBudgShare.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldByName('TENANT_ID').AsInteger;
             cdsBudgShare.FieldByName('KPI_YEAR').AsInteger := ds.FieldByName('KPI_YEAR').AsInteger;
             cdsBudgShare.FieldByName('SEQNO').AsInteger := i;
             cdsBudgShare.FieldByName('BUDG_ID').AsString := cdsHeader.FieldByName('BUDG_ID').AsString;
             cdsBudgShare.FieldByName('REQU_ID').AsString := ds.FieldByName('REQU_ID').AsString;
             cdsBudgShare.FieldByName('KPI_ID').AsString := ds.FieldByName('KPI_ID').AsString;
             if BudgMny >= ds.FieldByName('BLA_MNY').AsFloat then
                cdsBudgShare.FieldByName('BUDG_VRF').AsFloat := ds.FieldByName('BLA_MNY').AsFloat
             else
                cdsBudgShare.FieldByName('BUDG_VRF').AsFloat := BudgMny;
             cdsBudgShare.Post;
             BudgMny := BudgMny - ds.FieldByName('BLA_MNY').AsFloat;
           end;
        end;
        ds.Next;
      end;
      cdsDetail.Next;
    end;
  finally
    ds.Free;
  end;
end;

function TfrmMktBudgOrder.Changed: Boolean;
var CurMny,SumMny:Real;
begin
  Result := False;
  CurMny := 0;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    SumMny := 0;
    CurMny := cdsDetail.FieldbyName('BUDG_VRF').AsFloat;
    if CurMny <> 0 then
    begin
      cdsBudgShare.Filtered := False;
      cdsBudgShare.Filter := 'KPI_ID='+QuotedStr(cdsDetail.FieldbyName('KPI_ID').AsString);
      cdsBudgShare.Filtered := True;
      cdsBudgShare.First;
      while not cdsBudgShare.Eof do
      begin
        SumMny := SumMny + cdsBudgShare.FieldbyName('BUDG_VRF').AsFloat;
        cdsBudgShare.Next;
      end;
      if CurMny <> SumMny then
      begin
         Result := True;
         Exit;
      end;
    end;
    cdsDetail.Next;
  end;
end;

procedure TfrmMktBudgOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  if FromId <> '' then Raise Exception.Create('申领单号已选择,不能再改换"经销商"!');
end;

end.
