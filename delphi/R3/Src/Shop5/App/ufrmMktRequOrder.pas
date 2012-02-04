unit ufrmMktRequOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  RzButton, cxSpinEdit, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, RzLabel,
  ObjCommon;

type
  TfrmMktRequOrder = class(TframeContractForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label40: TLabel;
    Label3: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtREQU_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtREQU_TYPE: TcxComboBox;
    edtREQU_USER: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtDEPT_ID: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    RzLabel9: TRzLabel;
    Label1: TLabel;
    edtCHK_USER: TcxTextEdit;
    edtCHK_DATE: TcxTextEdit;
    edtKPI_ID: TzrComboBoxList;
    cdsKPI_ID: TZQuery;
    Label4: TLabel;
    edtREQU_MNY: TcxTextEdit;
    PopupMenu1: TPopupMenu;
    DeleteRecord: TMenuItem;
    N1: TMenuItem;
    edtKPI_YEAR: TzrComboBoxList;
    cdsKPI_YEAR: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtKPI_IDEnter(Sender: TObject);
    procedure edtKPI_IDExit(Sender: TObject);
    procedure edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh1Enter(Sender: TObject);
    procedure DeleteRecordClick(Sender: TObject);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure edtREQU_TYPEPropertiesChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure DBGridEh1Columns2BeforeShowControl(Sender: TObject);
    procedure edtKPI_YEAREnter(Sender: TObject);
    procedure edtKPI_YEARExit(Sender: TObject);
    procedure edtKPI_YEARKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_YEARKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_YEARSaveValue(Sender: TObject);
  private
    { Private declarations }
    AddRow:Boolean;
    procedure FocusNextColumn;
    procedure KpiMnyToCalc;
    procedure SetdbState(const Value: TDataSetState);override;
    function GetIsNull: boolean;override;    
  public
    { Public declarations }
    RowID:Integer;
    locked:boolean;
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

{ TfrmMktRequOrder }

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
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售计划单执行弃审');
       if MessageBox(Handle,'确认弃审当前费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('REQU_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
end;

procedure TfrmMktRequOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改');
  SetEditStyle(dsBrowse,edtREQU_TYPE.Style);
  edtREQU_TYPE.Properties.ReadOnly := true;
  edtREQU_TYPEPropertiesChange(nil);
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;

  //if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmMktRequOrder.FocusNextColumn;
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

function TfrmMktRequOrder.GetIsNull: boolean;
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

procedure TfrmMktRequOrder.InitRecord;
var tmp:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  //edtKPI_ID.Visible := false;
  if DBGridEh1.CanFocus and Visible then DBGridEh1.SetFocus;
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
  DbGridEh1.Col := 1 ;

  finally
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  //edtKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));

  rs := ShopGlobal.GetDeptInfo;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  AObj.FieldbyName('REQU_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('REQU_ID').asString;
  gid := '..新增..';
  edtREQU_DATE.Date := Global.SysDate;
  edtREQU_USER.KeyValue := Global.UserID;
  edtREQU_USER.Text := Global.UserName;
  edtREQU_TYPE.ItemIndex := 0;

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
    //edtKPI_YEAR.Value := AObj.FieldByName('KPI_YEAR').AsInteger; 
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('REQU_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    RowID := cdsDetail.RecordCount;
  finally
    locked := false;
    Params.Free;
  end;
end;

procedure TfrmMktRequOrder.SaveOrder;
var rny:real;
    R:Integer;
begin
  inherited;
  Saved := false;
  if edtREQU_DATE.EditValue = null then Raise Exception.Create('填报日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('部门不能为空');
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
     if cdsDetail.FieldByName('KPI_ID').AsString = '' then
        cdsDetail.Delete
     else
        cdsDetail.Next;
  end;
  if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空销售计划单据...');
  if not AddRow then Raise Exception.Create('不能保存一张有问题的销售计划单据...');
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cid := edtCLIENT_ID.asString;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;

  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    rny := 0;
    R := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
       begin
         Inc(R);
         cdsDetail.Edit;
         cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
         cdsDetail.FieldByName('REQU_ID').AsString := cdsHeader.FieldbyName('REQU_ID').AsString;
         //cdsDetail.FieldByName('PLAN_ID').AsString := 'Test_Data';
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsDetail.FieldByName('SEQNO').AsInteger := R;
         rny := rny + cdsDetail.FieldbyName('REQU_MNY').asFloat;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    cdsHeader.Edit;
    cdsHeader.FieldbyName('REQU_MNY').asFloat := rny;

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

procedure TfrmMktRequOrder.SetdbState(const Value: TDataSetState);
var Column:TColumnEh;
begin
  Column := FindColumn('KPI_ID_TEXT');
  if Column<>nil then Column.ReadOnly := true;
  inherited;
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
  AddRow := True;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL from MKT_KPI_INDEX where IDX_TYPE in (''1'') and COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID);

  //' select A.KPI_ID,A.KPI_NAME,B.CLIENT_ID from MKT_KPI_INDEX A,MKT_KPI_RESULT B where '+
  //' A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+IntToStr(Global.TENANT_ID);
  Factor.Open(cdsKPI_ID);
end;

procedure TfrmMktRequOrder.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(edtREQU_TYPE);
  inherited;

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

procedure TfrmMktRequOrder.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not AddRow then Exit;
  inherited;

end;

procedure TfrmMktRequOrder.edtKPI_IDEnter(Sender: TObject);
begin
  inherited;
  edtKPI_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
  {if edtCLIENT_ID.AsString <> '' then
  begin
     edtKPI_ID.RangeField := 'CLIENT_ID';
     edtKPI_ID.RangeValue := edtCLIENT_ID.AsString;
  end;}
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
           KpiMnyToCalc;
         end;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail.FieldbyName('KPI_ID_TEXT').AsString;
  edtKPI_ID.KeyValue := cdsDetail.FieldbyName('KPI_ID').AsString;
  edtKPI_ID.SaveStatus;
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

procedure TfrmMktRequOrder.DBGridEh1Enter(Sender: TObject);
begin
  inherited;
  if edtCLIENT_ID.AsString = '' then
     begin
       //MessageBox(Handle,'经销商不能为空！',pchar(Application.Title),MB_OK+MB_ICONQUESTION);
       edtCLIENT_ID.SetFocus;
     end;
end;

procedure TfrmMktRequOrder.KpiMnyToCalc;
var rs:TZQuery;
begin
  if (cdsDetail.FieldByName('KPI_ID').AsString <> '') and (cdsDetail.FieldByName('KPI_YEAR').AsString <> '') then
  begin
    cdsDetail.DisableControls;
    try
      rs := TZQuery.Create(nil);
      rs.SQL.Text := ParseSQL(Factor.iDbType,' select PLAN_ID,isnull(KPI_MNY,0) as KPI_MNY,isnull(WDW_MNY,0) as WDW_MNY,isnull(KPI_MNY,0)-isnull(WDW_MNY,0) as REQU_MNY from MKT_KPI_RESULT where CLIENT_ID='+QuotedStr(edtCLIENT_ID.AsString)+
      ' and KPI_ID='+QuotedStr(cdsDetail.FieldByName('KPI_ID').AsString)+' and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and KPI_YEAR='+cdsDetail.FieldByName('KPI_YEAR').AsString);
      Factor.Open(rs);

      if not rs.IsEmpty then
      begin
        if not (cdsDetail.State in [dsEdit,dsInsert]) then cdsDetail.Edit;
        cdsDetail.FieldByName('PLAN_ID').AsString := rs.FieldByName('PLAN_ID').AsString;
        cdsDetail.FieldByName('KPI_MNY').AsInteger := rs.FieldByName('KPI_MNY').AsInteger;
        cdsDetail.FieldByName('WDW_MNY').AsInteger := rs.FieldByName('WDW_MNY').AsInteger;
        cdsDetail.FieldByName('REQU_MNY').AsInteger := rs.FieldByName('REQU_MNY').AsInteger;
        cdsDetail.Post;
        AddRow := True;
      end
      else
      begin
        DBGridEh1.Col := 2;
        AddRow := False;
        Raise Exception.Create('在"'+cdsDetail.FieldByName('KPI_YEAR').AsString+'"年度没有相关考核指标!');
      end;
    finally
      rs.Free;
      cdsDetail.EnableControls;
    end;
  end;
end;

procedure TfrmMktRequOrder.DeleteRecordClick(Sender: TObject);
begin
  inherited;
  if cdsDetail.IsEmpty then Exit;
  if cdsDetail.FieldByName('KPI_ID').AsString = '' then Exit;
  cdsDetail.Delete;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var Year:Integer;
begin
  try
  if Text = '' then
     Year := StrToInt(FormatDateTime('YYYY',Date()))
  else
     Year := StrToInt(Text);
  if not((Year >= 2011) and (Year <= 2111)) then
     Raise Exception.Create('输入年度范围"2011-2111"');
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入年度范围"2011-2111"');
  end;
  TColumnEh(Sender).Field.AsInteger := Year;
  KpiMnyToCalc;
  cdsDetail.Edit;
end;

procedure TfrmMktRequOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;
end;

procedure TfrmMktRequOrder.edtREQU_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtREQU_TYPE.ItemIndex < 0 then Exit;
  if dbState = dsBrowse then Exit;
  if locked then Exit;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME from MKT_KPI_INDEX where IDX_TYPE in ('''+TRecord_(edtREQU_TYPE.Properties.Items.Objects[edtREQU_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+''') and COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID);
  Factor.Open(cdsKPI_ID);
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  InitRecord;
end;

procedure TfrmMktRequOrder.N1Click(Sender: TObject);
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

procedure TfrmMktRequOrder.DBGridEh1Columns2BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  cdsKPI_YEAR.SQL.Text := 'select KPI_YEAR from MKT_KPI_RESULT where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and CLIENT_ID='+QuotedStr(edtCLIENT_ID.AsString)+
  ' and KPI_ID='+QuotedStr(cdsDetail.FieldByName('KPI_ID').AsString)+' and COMM not in (''02'',''12'') ';
  Factor.Open(cdsKPI_YEAR);
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
begin
  inherited;
  if not cdsDetail.Active then Exit;
  if cdsDetail.FieldbyName('KPI_YEAR').AsString=edtKPI_YEAR.AsString then exit;

  cdsDetail.DisableControls;
  try
    cdsDetail.Edit;
    cdsDetail.FieldByName('KPI_YEAR').AsInteger := StrToInt(edtKPI_YEAR.AsString);
    KpiMnyToCalc;
  finally
    cdsDetail.EnableControls;
  end;
end;

end.
