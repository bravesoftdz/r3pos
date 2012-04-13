unit ufrmMktRequOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset, Menus, ActnList, cxDropDownEdit, cxTextEdit, cxControls, RzTabs,
  RzButton, cxCalendar, cxContainer, cxEdit, cxMaskEdit, ObjCommon, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel;

type
  TfrmMktRequOrder = class(TframeOrderForm)
    DBGridEh2: TDBGridEh;
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
    cdsHeader: TZQuery;
    RzTab: TRzTabControl;
    edtKPI_ID: TzrComboBoxList;
    edtKPI_YEAR: TzrComboBoxList;
    cdsKPI_ID: TZQuery;
    cdsKPI_YEAR: TZQuery;
    cdsDetail: TZQuery;
    dsDetail2: TDataSource;
    cdsDetail2: TZQuery;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
    Label1: TLabel;
    edtKPI_MNY: TcxTextEdit;
    edtBUDG_MNY: TcxTextEdit;
    Label4: TLabel;
    edtAGIO_MNY: TcxTextEdit;
    Label7: TLabel;
    edtOTHR_MNY: TcxTextEdit;
    Label10: TLabel;
    N3: TMenuItem;
    N4: TMenuItem;
    lblFeeOption: TLabel;
    procedure FormShow(Sender: TObject);
    procedure RzTabChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtKPI_IDEnter(Sender: TObject);
    procedure edtKPI_IDExit(Sender: TObject);
    procedure edtKPI_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_IDSaveValue(Sender: TObject);
    procedure edtKPI_YEAREnter(Sender: TObject);
    procedure edtKPI_YEARExit(Sender: TObject);
    procedure edtKPI_YEARKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKPI_YEARKeyPress(Sender: TObject; var Key: Char);
    procedure edtKPI_YEARSaveValue(Sender: TObject);
    procedure DBGridEh2DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2Columns2BeforeShowControl(Sender: TObject);
    procedure DBGridEh2Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtREQU_TYPEPropertiesChange(Sender: TObject);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure cdsDetail2AfterPost(DataSet: TDataSet);
    procedure DBGridEh2Columns1BeforeShowControl(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
  private
    { Private declarations }
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;    
    AddRow:Boolean;
    SKpiMny,SBudgMny,SAgioMny,SOthrMny:Real;
    DKpiMny,DBudgMny,DAgioMny,DOthrMny:Real;
    procedure FocusNextColumn2;
    function  FindColumn2(FieldName:string):TColumnEh;
    procedure InitRecord2;
    procedure SetdbState(const Value: TDataSetState);override;
    function GetIsNull: boolean;
    procedure Calc;
    procedure ClearInvaid;override;
  protected
    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
  public
    { Public declarations }
    RowID:Integer;
    locked:boolean;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
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
  uDsUtil, uXDictFactory, ufrmKpiIndexInfo, ufrmGoodsInfo,ufrmSalIndentOrderList,
  ufrmSalIndentOrder;

{$R *.dfm}

{ TfrmMktRequOrder1 }

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
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前订货单执行弃审');
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
    IsAudit := not IsAudit;
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
  cdsDetail2.First;
  while not cdsDetail2.Eof do cdsDetail2.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TMktRequOrder');
    Factor.AddBatch(cdsDetail,'TMktRequData');
    Factor.AddBatch(cdsDetail2,'TMktRequShare');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    cdsDetail2.CancelUpdates;
    Raise;
  end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    //ReadHeader;

    ReadFrom(cdsDetail);
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
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;  
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

function TfrmMktRequOrder.GetIsNull: boolean;
begin
  
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
  InitRecord2;
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
      Factor.AddBatch(cdsDetail,'TMktRequShare',Params);
      Factor.AddBatch(cdsDetail2,'TMktRequData',Params);
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
    RowID := cdsDetail2.RecordCount;

    locked := false;
    //edtSHOP_ID.Properties.ReadOnly := False;
    ReadFrom(cdsDetail);
  finally
    Params.Free;
  end;
end;

procedure TfrmMktRequOrder.SaveOrder;
var i:integer;
begin
  inherited;
  Saved := false;
  if edtREQU_DATE.EditValue = null then Raise Exception.Create('填报日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
  if edtREQU_TYPE.ItemIndex = -1 then Raise Exception.Create('返还类型不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('所属部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  Calc;
  if (TRecord_(edtREQU_TYPE.Properties.Items.Objects[edtREQU_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsInteger=1) and
     not ((SKpiMny=DKpiMny) and (SBudgMny=DBudgMny) and (SAgioMny=DAgioMny) and (SOthrMny=DOthrMny)) then
     Raise Exception.Create('费用分摊不平,请正确填写各项费用金额');
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.asString;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  {if (ShopGlobal.GetParameter('STK_AUTO_CHK')<>'0') and ShopGlobal.GetChkRight('11100001',5) then
     begin
       AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
       AObj.FieldbyName('CHK_USER').AsString := Global.UserID;
     end;}
  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    cdsHeader.Edit;
    cdsHeader.FieldbyName('KPI_MNY').asFloat := DKpiMny;
    cdsHeader.FieldbyName('BUDG_MNY').asFloat := DBudgMny;
    cdsHeader.FieldbyName('AGIO_MNY').asFloat := DAgioMny;
    cdsHeader.FieldbyName('OTHR_MNY').asFloat := DOthrMny;
    cdsHeader.Post;
    cdsDetail.DisableControls;
    cdsDetail2.DisableControls;
    try
      cdsDetail.First;
      while not cdsDetail.Eof do
        begin
          cdsDetail.Edit;
          cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
          cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
          cdsDetail.FieldByName('REQU_ID').AsString := cdsHeader.FieldbyName('REQU_ID').AsString;
          cdsDetail.Post;
          cdsDetail.Next;
        end;
      i := 0;
      cdsDetail2.First;
      while not cdsDetail2.Eof do
        begin
          cdsDetail2.Edit;
          cdsDetail2.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
          cdsDetail2.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
          cdsDetail2.FieldByName('REQU_ID').AsString := cdsHeader.FieldbyName('REQU_ID').AsString;
          inc(i);
          cdsDetail2.FieldByName('SEQNO').AsInteger := i;
          cdsDetail2.Post;
          cdsDetail2.Next;
        end;
    finally
      cdsDetail.EnableControls;
      cdsDetail2.EnableControls;
    end;
    Factor.AddBatch(cdsHeader,'TMktRequOrder');
    Factor.AddBatch(cdsDetail,'TMktRequShare');
    Factor.AddBatch(cdsDetail2,'TMktRequData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    //cdsDetail2.CancelUpdates;
    Raise;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmMktRequOrder.SetdbState(const Value: TDataSetState);
//var Column:TColumnEh;
begin
//  Column := FindColumn2('KPI_ID_TEXT');
//  if Column<>nil then Column.ReadOnly := true;
  inherited;
  DBGridEh1.ReadOnly := (dbState=dsBrowse);
  DBGridEh2.ReadOnly := (dbState=dsBrowse);
end;

procedure TfrmMktRequOrder.FormShow(Sender: TObject);
begin
  inherited;
  SKpiMny := 0;
  SBudgMny := 0;
  SAgioMny := 0;
  SOthrMny := 0;
  DKpiMny := 0;
  DBudgMny := 0;
  DAgioMny := 0;
  DOthrMny := 0;
  RzTab.TabIndex := 0;
  DBGridEh2.Align := alClient;
  DBGridEh1.BringToFront;
end;

procedure TfrmMktRequOrder.RzTabChange(Sender: TObject);
begin
  inherited;
  if RzTab.TabIndex = 0 then
  begin
     fndGODS_ID.CloseList;
     edtKPI_ID.CloseList;
     DBGridEh1.BringToFront;
  end
  else
  begin
     fndGODS_ID.CloseList;
     edtKPI_ID.CloseList;
     DBGridEh2.BringToFront;
  end;
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
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);  
  AddRow := True;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL from MKT_KPI_INDEX where TENANT_ID=:TENANT_ID and IDX_TYPE=''1'' and COMM not in (''02'',''12'') ';
  cdsKPI_ID.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(cdsKPI_ID);
end;

procedure TfrmMktRequOrder.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(edtREQU_TYPE);
  inherited;
end;

procedure TfrmMktRequOrder.edtKPI_IDEnter(Sender: TObject);
begin
  inherited;
  edtKPI_ID.Properties.ReadOnly := DBGridEh2.ReadOnly;
end;

procedure TfrmMktRequOrder.edtKPI_IDExit(Sender: TObject);
begin
  inherited;
  if not edtKPI_ID.DropListed then edtKPI_ID.Visible := False;
end;

procedure TfrmMktRequOrder.FocusNextColumn2;
var i:Integer;
begin
  i:=DBGridEh2.Col;
  Inc(i);
  while True do
    begin
      if i>=DBGridEh2.Columns.Count then i:= 1;
      if (DBGridEh2.Columns[i].ReadOnly or not DBGridEh2.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsDetail2.FieldbyName('KPI_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsDetail2.FieldbyName('KPI_ID').asString)<>'') then
              begin
                 cdsDetail2.Next ;
                 if cdsDetail2.Eof then
                    begin
                      InitRecord2;
                    end;
                 DBGridEh2.SetFocus;
                 DBGridEh2.Col := 1 ;
              end
           else
              DBGridEh2.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmMktRequOrder.edtKPI_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtKPI_ID.Edited then
     begin
       DBGridEh2.SetFocus;
       edtKPI_ID.Visible := false;
       FocusNextColumn2;
     end;
  if (Key=VK_UP) and not edtKPI_ID.DropListed then
     begin
       DBGridEh2.SetFocus;
       edtKPI_ID.Visible := false;
       cdsDetail2.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtKPI_ID.DropListed then
     begin
       if (cdsDetail2.FieldByName('SEQNO').AsString<>'') and (cdsDetail2.FieldByName('REQU_ID').AsString='') then
         edtKPI_ID.DropList
       else
       begin
         DBGridEh2.SetFocus;
         edtKPI_ID.Visible := false;
         cdsDetail2.Next;
         if cdsDetail2.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail2.FieldByName('REQU_ID').AsString <> '') then
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
       if cdsDetail2.FieldbyName('KPI_ID').AsString = '' then
          begin
            edtKPI_ID.DropList;
            Exit;
          end;
       FocusNextColumn2;
       DBGridEh2.SetFocus;
     end;
end;

procedure TfrmMktRequOrder.edtKPI_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail2.State = dsBrowse then cdsDetail2.Edit;
  for i:=1 to cdsDetail2.Fields.Count -1 do cdsDetail2.Fields[i].Value := null;
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
  if not cdsDetail2.Active then Exit;
  if cdsDetail2.FieldbyName('KPI_ID').AsString=edtKPI_ID.AsString then exit;

  if (edtKPI_ID.AsString='') and edtKPI_ID.Focused then   //and ShopGlobal.GetChkRight('32600001',2)
     Raise Exception.Create('没找到你想查找的指标？');

  cdsDetail2.DisableControls;
  try
    if VarIsNull(edtKPI_ID.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      if cdsDetail2.Locate('KPI_ID',edtKPI_ID.AsString,[]) then
         begin
           Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.KpiIdxRepeat','"%s"指标重复录入,请核对输入是否正确.',[edtKPI_ID.Text]));
         end
      else
         begin
           cdsDetail2.Edit;
           cdsDetail2.FieldByName('KPI_ID').AsString := edtKPI_ID.AsString;
           cdsDetail2.FieldByName('KPI_ID_TEXT').AsString := edtKPI_ID.Text;
           cdsDetail2.FieldByName('KPI_YEAR').AsString := '';
           edtKPI_YEAR.Text := '';
         end;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail2.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.edtKPI_YEAREnter(Sender: TObject);
begin
  inherited;
  edtKPI_YEAR.Properties.ReadOnly := DBGridEh2.ReadOnly;
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
       DBGridEh2.SetFocus;
       edtKPI_ID.Visible := false;
       FocusNextColumn2;
     end;
  if (Key=VK_UP) and not edtKPI_ID.DropListed then
     begin
       DBGridEh2.SetFocus;
       edtKPI_ID.Visible := false;
       cdsDetail2.Prior;
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
       if cdsDetail2.FieldbyName('KPI_YEAR').AsString = '' then
          begin
            edtKPI_YEAR.DropList;
            Exit;
          end;
       FocusNextColumn2;
       DBGridEh2.SetFocus;
     end;
end;

procedure TfrmMktRequOrder.edtKPI_YEARSaveValue(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  if not cdsDetail2.Active then Exit;
//  if cdsDetail2.FieldbyName('KPI_YEAR').AsString=edtKPI_YEAR.AsString then exit;
  if edtKPI_YEAR.asString='' then Exit;
  rs := TZQuery.Create(nil);
  cdsDetail2.DisableControls;
  try
    cdsDetail2.Edit;
    cdsDetail2.FieldByName('KPI_YEAR').AsInteger := StrToInt(edtKPI_YEAR.AsString);
    rs.SQL.Text := 'select KPI_MNY,BUDG_KPI,PLAN_ID from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and KPI_ID=:KPI_ID and KPI_YEAR=:KPI_YEAR';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.asString;
    rs.ParamByName('KPI_ID').asString := cdsDetail2.FieldByName('KPI_ID').asString ;
    rs.ParamByName('KPI_YEAR').AsInteger := cdsDetail2.FieldByName('KPI_YEAR').AsInteger ;
    Factor.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('你所选择的年度无效。'); 
    cdsDetail2.FieldByName('PLAN_ID').asString := rs.FieldByName('PLAN_ID').asString ;
    cdsDetail2.FieldByName('KPI_MNY').AsFloat := rs.FieldByName('KPI_MNY').AsFloat ;
    cdsDetail2.FieldByName('BUDG_MNY').AsFloat := rs.FieldByName('BUDG_KPI').AsFloat ;
    cdsDetail2.Post;
  finally
    rs.Free;
    cdsDetail2.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.DBGridEh2DrawFooterCell(Sender: TObject;
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

       DBGridEh2.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个指标',[Inttostr(cdsDetail2.RecordCount)]);
       DBGridEh2.Canvas.Font.Style := [fsBold];
       DBGridEh2.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh2.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktRequOrder.DBGridEh2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn2;
       Key := #0;
     end;
end;

procedure TfrmMktRequOrder.DBGridEh2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
begin
  inherited;
  Cell := DBGridEh2.MouseCoord(X,Y);
  if Cell.Y > DBGridEh2.VisibleRowCount -2 then
     InitRecord2;
end;

procedure TfrmMktRequOrder.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh2.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh2.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := $0000F2F2;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsDetail2.RecNo)),length(Inttostr(cdsDetail2.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
    
  if ((gdSelected in State) or (gdFocused in State)) then
    begin
      ARect := Rect;
      DBGridEh2.Canvas.Pen.Color := clRed;
      DBGridEh2.Canvas.Pen.Width := 1;
      DBGridEh2.Canvas.Brush.Style := bsClear;
      DBGridEh2.canvas.Rectangle(ARect);
      stbHint.Caption := Column.Title.Hint;
    end;
  finally
    DBGridEh2.Canvas.Brush.Assign(br);
    DBGridEh2.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmMktRequOrder.DBGridEh2Columns2BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_YEAR.Text := cdsDetail2.FieldbyName('KPI_YEAR').asString;
  cdsKPI_YEAR.Close;
  cdsKPI_YEAR.SQL.Text := 'select KPI_YEAR from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') ';
  cdsKPI_YEAR.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsKPI_YEAR.ParamByName('KPI_ID').AsString := cdsDetail2.FieldByName('KPI_ID').AsString;
  cdsKPI_YEAR.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  Factor.Open(cdsKPI_YEAR);
end;

procedure TfrmMktRequOrder.DBGridEh2Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail2.FieldbyName('KPI_ID_TEXT').AsString;
  edtKPI_ID.KeyValue := cdsDetail2.FieldbyName('KPI_ID').AsString;
  edtKPI_ID.SaveStatus;
end;

function TfrmMktRequOrder.FindColumn2(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh2.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh2.Columns[i];
           Exit;
         end;
    end;
end;

procedure TfrmMktRequOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;
end;

procedure TfrmMktRequOrder.fndGODS_IDSaveValue(Sender: TObject);
begin
  if edtCLIENT_ID.AsString = '' then
     begin
       MessageBox(Handle,'请先选择客户后再录单。','友情提示...',MB_OK+MB_ICONINFORMATION);
       edtCLIENT_ID.SetFocus;
       Exit;
     end;
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('32600001',2) then
     begin
       if MessageBox(Handle,'没找到你想查找的商品是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       fndStr := fndGODS_ID.Text;
       fndGODS_ID.OnAddClick(nil);
       Exit;
     end;
  inherited;
end;

procedure TfrmMktRequOrder.N1Click(Sender: TObject);
begin
  inherited;
  if cdsDetail2.IsEmpty then Exit;
  if cdsDetail2.FieldByName('KPI_ID').AsString = '' then Exit;
  cdsDetail2.Delete;
end;

procedure TfrmMktRequOrder.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsDetail2.Active then Exit;
  if cdsDetail2.IsEmpty then Exit;
  //if not ShopGlobal.GetChkRight('100002143',1) then Raise Exception.Create('你没有查看指标的权限,请和管理员联系.');
  with TfrmKpiIndexInfo.Create(self) do
    begin
      try
        Open(cdsDetail2.FieldByName('KPI_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmMktRequOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
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
end;

procedure TfrmMktRequOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
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
end;

procedure TfrmMktRequOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
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
end;

procedure TfrmMktRequOrder.DBGridEh1Columns9UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
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
end;

procedure TfrmMktRequOrder.DBGridEh2Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail2.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn2;
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

procedure TfrmMktRequOrder.DBGridEh2Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail2.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn2;
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

procedure TfrmMktRequOrder.DBGridEh2Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail2.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn2;
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

procedure TfrmMktRequOrder.DBGridEh2Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if cdsDetail2.FieldbyName('KPI_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn2;
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

procedure TfrmMktRequOrder.InitRecord2;
var tmp:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail2.State in [dsEdit,dsInsert] then cdsDetail2.Post;
  edtKPI_ID.Visible := false;
  cdsDetail2.DisableControls;
  try
  cdsDetail2.Last;
  if cdsDetail2.IsEmpty or (cdsDetail2.FieldbyName('KPI_ID').AsString <>'') then
    begin
      inc(RowID);
      cdsDetail2.Append;
      cdsDetail2.FieldByName('REQU_ID').Value := null;
      if cdsDetail2.FindField('SEQNO') <> nil then
         cdsDetail2.FindField('SEQNO').asInteger := RowID;

      cdsDetail2.Post;
      cdsDetail2.Edit;
    end;
    DBGridEh2.Col := 1 ;
    if DBGridEh2.CanFocus and Visible and (dbState <> dsBrowse) and (RzTab.TabIndex=0) then DBGridEh2.SetFocus;
  finally
    cdsDetail2.EnableControls;
    cdsDetail2.Edit;
  end;
end;

procedure TfrmMktRequOrder.edtREQU_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtREQU_TYPE.ItemIndex >=0 then
     begin
       RzTab.TabIndex := TRecord_(edtREQU_TYPE.Properties.Items.Objects[edtREQU_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsInteger-1;
       pnlBarCode.Visible := (TRecord_(edtREQU_TYPE.Properties.Items.Objects[edtREQU_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsInteger=1);
       RzPanel3.Visible := (TRecord_(edtREQU_TYPE.Properties.Items.Objects[edtREQU_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsInteger=1);
     end
  else
     RzTab.TabIndex := 0;
end;

procedure TfrmMktRequOrder.Calc;
var
  r:integer;
  mny:real;
  ps:TZQuery;
begin
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    SKpiMny := 0;
    SBudgMny := 0;
    SAgioMny := 0;
    SOthrMny := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        SKpiMny := SKpiMny + edtTable.FieldbyName('KPI_MNY').AsFloat;
        SBudgMny := SBudgMny + edtTable.FieldbyName('BUDG_MNY').AsFloat;
        SAgioMny := SAgioMny + edtTable.FieldbyName('AGIO_MNY').AsFloat;
        SOthrMny := SOthrMny + edtTable.FieldbyName('OTHR_MNY').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
  cdsDetail2.DisableControls;
  try
    r := cdsDetail2.FieldbyName('SEQNO').AsInteger;
    DKpiMny := 0;
    DBudgMny := 0;
    DAgioMny := 0;
    DOthrMny := 0;
    cdsDetail2.First;
    while not cdsDetail2.Eof do
      begin
        DKpiMny := DKpiMny + cdsDetail2.FieldbyName('KPI_MNY').AsFloat;
        DBudgMny := DBudgMny + cdsDetail2.FieldbyName('BUDG_MNY').AsFloat;
        DAgioMny := DAgioMny + cdsDetail2.FieldbyName('AGIO_MNY').AsFloat;
        DOthrMny := DOthrMny + cdsDetail2.FieldbyName('OTHR_MNY').AsFloat;
        cdsDetail2.Next;
      end;
  finally
    cdsDetail2.Locate('SEQNO',r,[]);
    cdsDetail2.EnableControls;
  end;
  edtOTHR_MNY.Text := formatFloat('#0.0#',SOthrMny-DOthrMny);
  edtAGIO_MNY.Text := formatFloat('#0.0#',SAgioMny-DAgioMny);
  edtBUDG_MNY.Text := formatFloat('#0.0#',SBudgMny-DBudgMny);
  edtKPI_MNY.Text := formatFloat('#0.0#',SKpiMny-DKpiMny);
end;

procedure TfrmMktRequOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;

end;

procedure TfrmMktRequOrder.cdsDetail2AfterPost(DataSet: TDataSet);
begin
  inherited;
  if not cdsDetail2.ControlsDisabled then Calc;

end;

procedure TfrmMktRequOrder.ClearInvaid;
var
  r:integer;
begin
  inherited;
  if cdsDetail2.State in [dsEdit,dsInsert] then cdsDetail2.Post;
  r := cdsDetail2.RecNo;
  cdsDetail2.DisableControls;
  try
  cdsDetail2.First;
  while not cdsDetail2.Eof do
    begin
      if (cdsDetail2.FieldByName('KPI_ID').AsString = '')
         or
         (cdsDetail2.FieldByName('KPI_YEAR').AsString = '')
      then
         cdsDetail2.Delete
      else
         cdsDetail2.Next;
    end;
  finally
    if r>0 then cdsDetail2.RecNo := r;
    cdsDetail2.EnableControls;
  end;
end;

procedure TfrmMktRequOrder.DBGridEh2Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtKPI_ID.Text := cdsDetail2.FieldbyName('KPI_ID_TEXT').asString;
  edtKPI_ID.KeyValue := cdsDetail2.FieldbyName('KPI_ID').asString;
end;

procedure TfrmMktRequOrder.N4Click(Sender: TObject);
 function CheckRequOrderID: Boolean;
 var Rs: TZQuery;
 begin
   result:=False;
   try
     Rs:=TZQuery.Create(nil);
     Rs.SQL.Text:='select count(*) as ReSum from SAL_INDENTORDER where ATTH_ID='''+'REQ'+AObj.FieldByName('REQU_ID').AsString+''' ';
     Factor.Open(Rs);
     if Rs.Active and (Rs.FieldByName('ReSum').AsInteger>0) then
       Result:=True;
   finally
     Rs.Free;
   end;
 end;
var
  frmSalIndentOrderList: TfrmSalIndentOrderList;
begin
  if dbState <> dsBrowse then Raise Exception.Create('   请保存单据后再操作。   ');
  if not IsAudit then Raise Exception.Create('  没有审核的单据不能生成销售订单...  ');
  if CheckRequOrderID then Raise Exception.Create('  本单据已经生成，不能重复生成...  ');
  if not frmMain.FindAction('actfrmSalIndentOrderList').Enabled then Exit;
  frmMain.FindAction('actfrmSalIndentOrderList').OnExecute(nil);
  frmSalIndentOrderList := TfrmSalIndentOrderList(frmMain.FindChildForm(TfrmSalIndentOrderList));
  SendMessage(frmSalIndentOrderList.Handle,WM_EXEC_ORDER,0,2);
  PostMessage(frmSalIndentOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),0);
end;

procedure TfrmMktRequOrder.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  N4.Enabled:=(dbState=dsBrowse);
end;

procedure TfrmMktRequOrder.WMFillData(var Message: TMessage);
var frmSalIndetOrder:TfrmSalIndentOrder;
begin
  //if dbState <> dsBrowse then Raise Exception.Create('不是在浏览状态不能完成操作');
  frmSalIndetOrder := TfrmSalIndentOrder(Message.WParam);

  Open(copy(frmSalIndetOrder.AObj.FieldByName('ATTH_ID').AsString,4,36));

end;

procedure TfrmMktRequOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
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
        AMountToCalc(r);
     end;
end;

procedure TfrmMktRequOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs,bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');  
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CarryRule').asInteger := CarryRule;
    Params.ParamByName('Deci').asInteger := Deci;
    Params.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.AsString;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
    Params.ParamByName('GODS_ID').asString := GODS_ID;
    if AObj.FieldbyName('PRICE_ID').AsString='' then
    Params.ParamByName('PRICE_ID').asString := '#' else
    Params.ParamByName('PRICE_ID').asString := AObj.FieldbyName('PRICE_ID').AsString;
    Params.ParamByName('UNIT_ID').asString := UNIT_ID;
    Factor.Open(rs,'TGetSalesPrice',Params);
    if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
    edtTable.FieldByName('APRICE').AsFloat := rs.FieldbyName('V_APRICE').AsFloat;
    //edtTable.FieldbyName('ORG_PRICE').AsFloat := rs.FieldbyName('V_ORG_PRICE').AsFloat;
    //edtTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,GODS_ID,edtTable.FieldbyName('BATCH_NO').AsString);
    //edtTable.FieldByName('POLICY_TYPE').AsInteger := rs.FieldbyName('V_POLICY_TYPE').AsInteger;
    //edtTable.FieldByName('HAS_INTEGRAL').AsInteger := rs.FieldbyName('V_HAS_INTEGRAL').AsInteger;
    //看是否换购商品
    if bs.FieldByName('USING_BARTER').AsInteger=3 then
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 2;
         //edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
       end
    else
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 0;
         //edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := 0;
       end;
  finally
    Params.Free;
    rs.Free;
  end;
end;

end.
