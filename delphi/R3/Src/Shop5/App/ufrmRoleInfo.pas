unit ufrmRoleInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxMemo, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls,DB,ZDataset,zBase,
  ZAbstractRODataset, ZAbstractDataset;

type
  TfrmRoleInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label1: TLabel;
    edtROLE_ID: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtROLE_NAME: TcxTextEdit;
    Label4: TLabel;
    Label7: TLabel;
    edtROLE_SPELL: TcxTextEdit;
    Label6: TLabel;
    edtREMARK: TcxMemo;
    Label26: TLabel;
    Label5: TLabel;
    cdsTable: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtDUTY_NAMEPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function  IsEdit(Aobj:TRecord_; cdsTable: TZQuery):Boolean; virtual; //�ж���Aobj�����������ݼ�Value�Ƿ�ı�
  public
    AObj:TRecord_;
    Saved:Boolean;
    procedure Open(code:string);
    procedure WriteTo(Aobj:TRecord_);
    procedure Append;
    procedure Edit(code:string);
    procedure CheckRoleNameExists;  //�жϣ�Ȩ�ޣ���ɫ�����Ƿ����?
    procedure Save;
    procedure SetdbState(const Value: TDataSetState); override;
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
  end;
 

implementation
uses uShopUtil,uDsUtil,uFnUtil, uGlobal,uXDictFactory, uShopGlobal;
{$R *.dfm}

{ TfrmDeptDutyInfo }

procedure TfrmRoleInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtROLE_ID.Text :=TSequence.GetMaxID(InttoStr(ShopGlobal.TENANT_ID),Factor,'ROLE_ID','CA_ROLE_INFO','000');
end;

procedure TfrmRoleInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

procedure TfrmRoleInfo.Open(code: string);
var
  Params: TftParamList;
begin
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger :=ShopGlobal.TENANT_ID;
    Params.ParamByName('ROLE_ID').AsString := code;
    cdsTable.Close;
    Factor.Open(cdsTable,'TRoleInfo',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    dbState := dsBrowse;
  finally
    Params.Free;
  end;  
end;

procedure TfrmRoleInfo.CheckRoleNameExists;
var
  tmp: TZQuery;
begin
  if edtROLE_NAME.Text<>cdsTable.FieldByName('ROLE_NAME').AsString  then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('CA_ROLE_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if (trim(tmp.FieldByName('ROLE_NAME').AsString)=trim(edtRole_NAME.Text)) and
           (trim(tmp.FieldByName('ROLE_ID').AsString)<>trim(cdsTable.FieldByName('DUTY_ID').AsString)) then
        begin
          if edtROLE_NAME.CanFocus then  edtROLE_NAME.SetFocus;
          MessageBox(handle,Pchar('��ʾ:��Ȩ�ޣ���ɫ�����Ѿ�����!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
    
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('CA_ROLE_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if trim(tmp.FieldByName('ROLE_NAME').AsString)=trim(edtROLE_NAME.Text) then
        begin
          if edtROLE_NAME.CanFocus then edtROLE_NAME.SetFocus;
          MessageBox(handle,Pchar('��ʾ:��Ȩ�ޣ���ɫ�����Ѿ�����!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
  end;
end;

procedure TfrmRoleInfo.Save;
  procedure UpdateToGlobal(AObj:TRecord_);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('CA_ROLE_INFO');
    Temp.Filtered :=false;
    if not Temp.Locate('ROLE_ID',edtROLE_ID.Text,[]) then
      Temp.Append
    else
      Temp.Edit;
    AObj.WriteToDataSet(Temp,False);
    Temp.Post;
  end;
var
  j:integer;
  tmp:TZQuery;
begin
  if trim(edtROLE_NAME.Text)='' then
  begin
    if not edtROLE_NAME.CanFocus then edtROLE_NAME.SetFocus;
    Raise Exception.Create('��ɫ���Ʋ���Ϊ�գ�');
  end;
  if trim(edtROLE_SPELL.Text)='' then
  begin
    if not edtROLE_SPELL.CanFocus then edtROLE_SPELL.SetFocus;
    Raise Exception.Create('ƴ���벻��Ϊ�գ�');
  end;
  if trim(edtREMARK.Text)='' then
  begin
    if not edtREMARK.CanFocus then edtREMARK.SetFocus;
    Raise Exception.Create('��ɫ��������Ϊ�գ�');
  end;

  //�жϽ�ɫ�����Ƿ����
  CheckRoleNameExists;
  //д��AObj��¼���� 
  WriteTo(AObj);

  //�жϵ����Ƿ����޸�
  if not IsEdit(Aobj, cdsTable) then Exit;
  
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;

  if Factor.UpdateBatch(cdsTable,'TRoleInfo',nil) then
    UpdateToGlobal(Aobj);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmRoleInfo.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmRoleInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmRoleInfo.btnOkClick(Sender: TObject);
begin
  inherited;
  Save;
  if Saved and Assigned(OnSave) then
  begin
    OnSave(AObj);
    if MessageBox(Handle,'�Ƿ����������ɫ?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end else
    ModalResult := MROK;
end;

procedure TfrmRoleInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmRoleInfo.edtDUTY_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
    edtROLE_SPELL.Text := fnString.GetWordSpell(edtROLE_NAME.Text,3);
end;

procedure TfrmRoleInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtROLE_NAME.CanFocus then edtROLE_NAME.SetFocus;
end;

procedure TfrmRoleInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label2.Visible:=True;
  Label4.Visible:=True;
  Label5.Visible:=True;
  Label6.Visible:=True;
  btnOk.Visible := (Value<>dsBrowse);
  case dbState of
   dsInsert:Caption:='��ɫ����--(����)';
   dsEdit:  Caption:='��ɫ����--(�޸�)';
   else
   begin
      Caption:='ְ�񵵰�';
      Label2.Visible:=False;
      Label4.Visible:=False;
      Label5.Visible:=False;
      Label6.Visible:=False;
    end;
  end;
end;

procedure TfrmRoleInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
    if not((dbState = dsInsert) and (trim(edtROLE_NAME.Text)='')) then
    begin
      WriteTo(AObj);
      if not IsEdit(Aobj,cdsTable) then Exit;
      i:=MessageBox(Handle,'��ɫ�������޸ģ��Ƿ񱣴��޸���Ϣ��',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
      if i=6 then
      begin
        Save;
        if Saved and Assigned(OnSave) then
          OnSave(AObj);
      end;
      if i=2 then abort;
    end;
  except
    CanClose := false;
    Raise;
  end;
end;

procedure TfrmRoleInfo.WriteTo(Aobj: TRecord_);
begin
  WriteToObject(AObj,self);
  Aobj.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
  if dbState=dsInsert then
    Aobj.FieldByName('ROLE_ID').AsString:=edtROLE_ID.Text;
end;

class function TfrmRoleInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
  //��R3��ShopGlobalû�д˷���:
  //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('�����ܵ꣬�����޸�ְ��!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('��û���޸Ľ�ɫ��Ȩ��,��͹���Ա��ϵ.');
  with TfrmRoleInfo.Create(Owner) do
  begin
    try
      Edit(id);
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end else
        result :=False;
    finally
      free;
    end;
  end;
end;

class function TfrmRoleInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   //��R3��ShopGlobalû�д˷���:
   //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('�����ܵ꣬��������ְ��!');
   //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('��û��������ɫ��Ȩ��,��͹���Ա��ϵ.');
  with TfrmRoleInfo.Create(Owner) do
  begin
    try
      Append;
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end else
        result :=False;
    finally
      free;
    end;
  end;
end;

function TfrmRoleInfo.IsEdit(Aobj: TRecord_; cdsTable: TZQuery): Boolean;
var
  i:integer;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if trim(AObj.Fields[i].AsString)<>trim(cdsTable.Fields[i].AsString) then
    begin
      Result:=True;
      break;
    end;
  end;
end;

end.
