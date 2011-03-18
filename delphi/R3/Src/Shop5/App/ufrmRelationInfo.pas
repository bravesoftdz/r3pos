unit ufrmRelationInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, DB, zBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Mask, RzEdit, RzButton,
  cxMemo;

type
  TfrmRelationInfo = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    edtRELATION_ID: TcxTextEdit;
    labRELATION_ID: TLabel;
    edtRELATION_NAME: TcxTextEdit;
    labRELATION_NAME: TLabel;
    Relation_Data: TZQuery;
    edtTENANT_NUM: TcxTextEdit;
    Label1: TLabel;
    edtGOODS_NUM: TcxTextEdit;
    Label2: TLabel;
    edtRELATION_SPELL: TcxTextEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    edtREMARK: TcxMemo;
    btnDelete: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtRELATION_NAMEPropertiesChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IsExist:Boolean;
    Aobj:TRecord_;
    procedure RefreshTable;
    procedure GetParam;
    procedure Open(CODE_ID:String);
    procedure Append;
    procedure Edit(CODE_ID:String);
    procedure Save;
    function IsEdit(AObj_:TRecord_;Data:TZQuery):Boolean;
    class function AddDialog(Owner:TForm;var _Aobj:TRecord_):Boolean;
    class function EditDialog(Owner:TForm;Code_id:String;var _Aobj:TRecord_):Boolean;
    class function DeleteDialog(Owner:TForm;Code_id:String):Boolean;
    class function ShowDialog(Owner:TForm;Code_id:String):Boolean;
  end;

implementation
uses uShopUtil,uDsUtil,uFnUtil,uGlobal,uShopGlobal, ufrmBasic;
{$R *.dfm}

{ TfrmRelationInfo }

procedure TfrmRelationInfo.Append;
begin
  Open('');
  edtRELATION_ID.Text := IntToStr(Global.TENANT_ID);
  dbState := dsInsert;
end;

procedure TfrmRelationInfo.Edit(CODE_ID: String);
begin
  Open(CODE_ID);
  dbState := dsEdit;
  GetParam;
end;

procedure TfrmRelationInfo.Open(CODE_ID: String);
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    if CODE_ID <> '' then
      Params.ParamByName('RELATION_ID').AsInteger := StrToInt(CODE_ID)
    else
      Params.ParamByName('RELATION_ID').AsInteger := Global.TENANT_ID;
//    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(Relation_Data,'TRelation',Params);
    if Relation_Data.FieldByName('RELATION_NAME').AsString <> '' then IsExist := True;
    Aobj.ReadFromDataSet(Relation_Data);
    ReadFromObject(Aobj,Self);
    GetParam;
    IsExist := not Relation_Data.IsEmpty;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmRelationInfo.Save;
begin
  WriteToObject(Aobj,Self);
  if not IsEdit(Aobj,Relation_Data) then Exit;

  if dbState = dsInsert then
    begin
      Aobj.FieldByName('RELATION_ID').AsInteger := Global.TENANT_ID;
      Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    end;
  Relation_Data.Edit;
  Aobj.WriteToDataSet(Relation_Data);
  Relation_Data.Post;
  Factor.UpdateBatch(Relation_Data,'TRelation');
  dbState := dsBrowse;
end;

procedure TfrmRelationInfo.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
end;

procedure TfrmRelationInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

function TfrmRelationInfo.IsEdit(AObj_: TRecord_; Data: TZQuery): Boolean;
var i:Integer;
begin
  Result := False;
  for i := 0 to Data.FieldCount - 1 do
    begin
      if AObj_.Fields[i].AsString <> Data.Fields[i].AsString then
        begin
          Result := True;
          Exit;
        end;
    end;
end;

class function TfrmRelationInfo.AddDialog(Owner: TForm;
  var _Aobj: TRecord_): Boolean;
begin
  with TfrmRelationInfo.Create(Owner) do
    begin
      try
        Append;
        if not IsExist then
          begin
            if ShowModal = mrOk then
              begin
                Aobj.CopyTo(_Aobj);
                Result := True;
              end
            else
              Result := False;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;
end;

class function TfrmRelationInfo.EditDialog(Owner: TForm; Code_id: String;
  var _Aobj: TRecord_): Boolean;
begin
  with TfrmRelationInfo.Create(Owner) do
    begin
      try
        Edit(Code_id);      
        if IsExist then
          begin
            if ShowModal = mrOk then
              begin
                Aobj.CopyTo(_Aobj);
                Result := True;
              end
            else
              Result := False;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;

end;

class function TfrmRelationInfo.ShowDialog(Owner: TForm;
  Code_id: String): Boolean;
begin
  with TfrmRelationInfo.Create(Owner) do
    begin
      try
        Open(Code_id);
        if IsExist then
          begin
            btnOk.Visible := False;
            ShowModal;
            Result := True;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;
end;

procedure TfrmRelationInfo.edtRELATION_NAMEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if dbState <> dsBrowse then
    edtRELATION_SPELL.Text := FnString.GetWordSpell(edtRELATION_NAME.Text);
end;

procedure TfrmRelationInfo.btnOkClick(Sender: TObject);
begin
  inherited;
  if Trim(edtRELATION_NAME.Text) = '' then
    begin
      if edtRELATION_NAME.CanFocus then edtRELATION_NAME.SetFocus;
      Raise Exception.Create('供应链名称不能为空,请输入名称.');
    end;
  if Trim(edtRELATION_SPELL.Text) = '' then
    begin
      if edtRELATION_SPELL.CanFocus then edtRELATION_SPELL.SetFocus;
      Raise Exception.Create('拼音码不能为空.');
    end;

  Save;
  ModalResult := mrOk;
end;

procedure TfrmRelationInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtRELATION_NAME.Text)='')) then
   begin
      if not IsEdit(Aobj,Relation_Data) then Exit;
      i:=MessageBox(Handle,'供应链档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
      if i=6 then
         begin
           Save;
           //if Saved and Assigned(OnSave) then OnSave(AObj);
         end;
      if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

class function TfrmRelationInfo.DeleteDialog(Owner: TForm;
  Code_id: String): Boolean;
begin
  with TfrmRelationInfo.Create(Owner) do
    begin
      try
        Open(Code_id);
        if IsExist then
          begin
            btnDelete.Left := 289;
            btnDelete.Visible := true;
            btnOk.Visible := False;
            if ShowModal = mrOk then
              Result := True
            else
              Result := False;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;
end;

procedure TfrmRelationInfo.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if  not Relation_Data.Active then Exit;
  if Relation_Data.RecordCount = 0 then Exit;
  if MessageBox(Handle,pchar('确定要删除吗!'),pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION) = 6 then
    begin
      try
        Relation_Data.Delete;
        Factor.UpdateBatch(Relation_Data,'TRelation');
        ModalResult := mrOk;
      except
        Relation_Data.CancelUpdates;
        Raise;
      end;
    end;
end;

procedure TfrmRelationInfo.GetParam;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from  CA_RELATIONS where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Aobj.Fieldbyname('TENANT_ID').AsInteger;;
    rs.ParamByName('RELATION_ID').AsInteger := Aobj.Fieldbyname('RELATION_ID').AsInteger;
    Factor.Open(rs);
    edtTENANT_NUM.Text := rs.Fields[0].AsString;

    rs.Close;
    rs.SQL.Text := ' select count(*) from  PUB_GOODS_RELATION where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := Aobj.Fieldbyname('TENANT_ID').AsInteger;;
    rs.ParamByName('RELATION_ID').AsInteger := Aobj.Fieldbyname('RELATION_ID').AsInteger;
    Factor.Open(rs);
    edtGOODS_NUM.Text := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmRelationInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelationInfo.RefreshTable;
begin
  Global.RefreshTable('PUB_GOODSSORT');
  Global.RefreshTable('PUB_GOODSINFO');
  Global.RefreshTable('PUB_MEAUNITS');
  Global.RefreshTable('PUB_CLIENTINFO');
  Global.RefreshTable('PUB_CUSTOMER');
  Global.RefreshTable('PUB_BARCODE');
end;

end.
