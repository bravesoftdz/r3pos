unit ufrmAccountInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton,
  cxMaskEdit, cxDropDownEdit,zBase, DB, cxButtonEdit,
  zrComboBoxList, RzLabel, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmAccountInfo = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    Label2: TLabel;
    edtACCT_NAME: TcxTextEdit;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtORG_MNY: TcxTextEdit;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label10: TLabel;
    edtOUT_MNY: TcxTextEdit;
    Label11: TLabel;
    edtIN_MNY: TcxTextEdit;
    Label12: TLabel;
    edtBALANCE: TcxTextEdit;
    Label13: TLabel;
    edtACCT_SPELL: TcxTextEdit;
    Label7: TLabel;
    cdsTable: TZQuery;
    edtPAYM_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtACCT_NAMEPropertiesChange(Sender: TObject);
    procedure edtORG_MNYPropertiesChange(Sender: TObject);
    procedure edtORG_MNYExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtOUT_MNYPropertiesChange(Sender: TObject);
    procedure edtIN_MNYPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    Saved:Boolean;
    AObj:TRecord_;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code: string);
    procedure Save;
    procedure WriteTo(AObj:TRecord_);
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断账户资料是否有修改
    procedure SetdbState(const Value: TDataSetState); override;    
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    { Public declarations }
  end;

implementation
uses uShopUtil,uDsUtil,uFnUtil,uGlobal,uShopGlobal;
{$R *.dfm}

{ TfrmAccountInfo }

procedure TfrmAccountInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtORG_MNY.Text := '0';
  edtOUT_MNY.Text := '0';
  edtIN_MNY.Text := '0';
  edtBALANCE.Text := '0';
  if Visible then
    edtACCT_NAME.SetFocus;
end;

procedure TfrmAccountInfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('ACCOUNT_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    //Params.ParamByName('SHOP_ID').asString := IntToStr(Global.TENANT_ID)+'0001';
    cdsTable.Close;
    Factor.Open(cdsTable,'TAccount',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmAccountInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
      Temp.Filtered := false;
      if Temp.Locate('ACCOUNT_ID',AObj.FieldByName('ACCOUNT_ID').AsString,[]) then
         Temp.Edit
      else
         Temp.Append;
      AObj.WriteToDataSet(Temp,false);
      Temp.Post;
   end;
begin
  if trim(edtACCT_NAME.Text)='' then
  begin
    edtACCT_NAME.SetFocus;
    raise Exception.Create('账户名称不能为空！');
  end;
  if edtPAYM_ID.Text = '' then
  begin
    edtPAYM_ID.SetFocus;
    raise Exception.Create('支付方式不能为空！');
  end;
  
  WriteTo(AObj);
  if not IsEdit(Aobj,cdsTable) then Exit;

  cdsTable.Edit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  if Factor.UpdateBatch(cdsTable,'TAccount',nil) then
    UpdateToGlobal(AObj);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmAccountInfo.FormCreate(Sender: TObject);
begin
  inherited;
  //edtCOMP_ID.DataSet:=Global.GetADODataSetFromName('CA_COMPANY');
  edtPAYM_ID.DataSet := Global.GetZQueryFromName('PUB_PAYMENT');
  edtPAYM_ID.DataSet.Filtered := False;
  edtPAYM_ID.DataSet.Filter := 'CODE_ID <> ''A''';
  edtPAYM_ID.DataSet.Filtered := True;
  AObj := TRecord_.Create;
end;

procedure TfrmAccountInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmAccountInfo.FormShow(Sender: TObject);
begin
  inherited;
  edtACCT_NAME.SetFocus;
end;

procedure TfrmAccountInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAccountInfo.btnOkClick(Sender: TObject);
var bl:Boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bl then //继续新增
  begin
    if MessageBox(Handle,'是否继续新增帐户?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
       Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmAccountInfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
  if dbState = dsInsert then
    begin
      AObj.FieldByName('SHOP_ID').AsString := IntToStr(Global.TENANT_ID)+'0001';
      AObj.FieldbyName('ACCOUNT_ID').AsString:=TSequence.NewId;
      AObj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    end;
  Aobj.FieldByName('OUT_MNY').AsString := Trim(edtOUT_MNY.Text);
  Aobj.FieldByName('IN_MNY').AsString := Trim(edtIN_MNY.Text);
  Aobj.FieldByName('BALANCE').AsString := Trim(edtBALANCE.Text);
end;

function TfrmAccountInfo.IsEdit(Aobj: TRecord_;
  cdsTable: TZQuery): Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if AObj.Fields[i].AsString<>cdsTable.Fields[i].AsString then
    begin
      Result:=True;
      break;
    end;
  end;
end;

procedure TfrmAccountInfo.edtACCT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtACCT_SPELL.Text := fnString.GetWordSpell(edtACCT_NAME.Text,3);
end;

procedure TfrmAccountInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  if Visible and edtACCT_NAME.CanFocus then
  edtACCT_NAME.SetFocus;
end;

procedure TfrmAccountInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible := (Value<>dsBrowse);
  case Value of
    dsInsert:Caption := '账户档案--(新增)';
    dsEdit:Caption := '账户档案--(修改)';
    else
      Caption := '账户档案';
  end;
end;

procedure TfrmAccountInfo.edtORG_MNYPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState in [dsInsert,dsEdit] then
    begin
      StrToFloatDef(Trim(edtORG_MNY.Text),0);
      edtBALANCE.Text := floattostr(StrtoFloatDef(edtORG_MNY.Text,0)+StrtoFloatDef(edtIN_MNY.Text,0)-StrtoFloatDef(edtOUT_MNY.Text,0));
    end;
end;

procedure TfrmAccountInfo.edtORG_MNYExit(Sender: TObject);
var str,str1:string;
begin
  inherited;
  if AObj.FieldByName('ORG_MNY').AsString='' then
    str:='0'
  else
    str:=AObj.FieldByName('ORG_MNY').AsString;
  if AObj.FieldByName('BALANCE').AsString='' then
    str1:='0'
  else
    str1:=AObj.FieldByName('BALANCE').AsString;
  if edtORG_MNY.Text='' then
    edtORG_MNY.Text:='0';
  edtBALANCE.Text:=FloatToStr(StrToFloatDef(edtORG_MNY.Text,0)+StrToFloat(str1)-StrToFloat(str));
end;

procedure TfrmAccountInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtACCT_NAME.Text)='')) then
   begin
      WriteTo(AObj);
      if not IsEdit(Aobj,cdsTable) then Exit;
      i:=MessageBox(Handle,'帐户档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
      if i=6 then
         begin
           Save;
           if Saved and Assigned(OnSave) then OnSave(AObj);
         end;
      if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

class function TfrmAccountInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
  with TfrmAccountInfo.Create(Owner) do
    begin
      try
        Append;
        result := (ShowModal=MROK);
        if result then
           AObj.CopyTo(_AObj);
      finally
        free;
      end;
    end;
end;

procedure TfrmAccountInfo.edtOUT_MNYPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState in [dsInsert,dsEdit] then
    begin
      StrToFloatDef(Trim(edtORG_MNY.Text),0);
      edtBALANCE.Text := floattostr(StrtoFloatDef(edtORG_MNY.Text,0)+StrtoFloatDef(edtIN_MNY.Text,0)-StrtoFloatDef(edtOUT_MNY.Text,0));
    end;
end;

procedure TfrmAccountInfo.edtIN_MNYPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState in [dsInsert,dsEdit] then
    begin
      StrToFloatDef(Trim(edtORG_MNY.Text),0);
      edtBALANCE.Text := floattostr(StrtoFloatDef(edtORG_MNY.Text,0)+StrtoFloatDef(edtIN_MNY.Text,0)-StrtoFloatDef(edtOUT_MNY.Text,0));
    end;
end;

end.
