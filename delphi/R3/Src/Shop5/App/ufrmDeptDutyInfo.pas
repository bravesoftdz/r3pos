unit ufrmDeptDutyInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxMemo, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls,DB,ZDataset,zBase, DBClient,
  ZAbstractRODataset, ZAbstractDataset;

type
  TfrmDutyInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label1: TLabel;
    edtDUTY_ID: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtDUTY_NAME: TcxTextEdit;
    Label4: TLabel;
    Label7: TLabel;
    edtDUTY_SPELL: TcxTextEdit;
    Label6: TLabel;
    Label9: TLabel;
    edtUPDUTY_ID: TzrComboBoxList;
    edtREMARK: TcxMemo;
    Label26: TLabel;
    Label5: TLabel;
    drpDeptDuty: TZQuery;
    cdsTable: TZQuery;
    procedure Open(code:string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtDUTY_NAMEPropertiesChange(Sender: TObject);
    procedure edtUPDUTY_IDBeforeDropList(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    AObj:TRecord_;
    Saved:Boolean;
    procedure WriteTo(Aobj:TRecord_);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure SetdbState(const Value: TDataSetState); override;
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
  end;
 

implementation
uses uShopUtil,uDsUtil,uFnUtil, uGlobal,uXDictFactory, uShopGlobal;
{$R *.dfm}

{ TfrmDeptDutyInfo }

procedure TfrmDutyInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtDUTY_ID.Text := TSequence.GetMaxID('',Factor,'DUTY_ID','CA_DUTY_INFO','000');
end;

procedure TfrmDutyInfo.Edit(code: string);
begin
  Open(code);
  edtUPDUTY_ID.Enabled:=(AObj.FieldByName('DUTY_ID').AsString<>'000');
  dbState := dsEdit;
end;

procedure TfrmDutyInfo.Open(code: string);
var
  CurID: string;
  zQry: TZQuery;
  Params: TftParamList;
begin
  Params:=TftParamList.Create(nil);
  try
    //Params.ParamByName('DUTY_ID',True).asString := code;
    Params.ParamByName('DUTY_ID').AsString := code;
    cdsTable.Close;                  
    Factor.Open(cdsTable,'TDuty',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    CurID:=trim(Aobj.FieldByName('LEVEL_ID').AsString);
    CurID:=Copy(CurID,1,Length(CurID)-3);
    zQry:=Global.GetZQueryFromName('CA_DUTY_INFO');
    if (zQry<>nil) and (zQry.Active) then
      edtUPDUTY_ID.Text:=TdsFind.GetNameByID(zQry,'LEVEL_ID','DUTY_NAME',CurID)
    else
      edtUPDUTY_ID.Text:='';
    dbState := dsBrowse;
  finally
    Params.Free;
  end;  
end;

procedure TfrmDutyInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('CA_DUTY_INFO');
      Temp.Filtered :=false;
      if not Temp.Locate('Duty_ID',edtDuty_ID.Text,[]) then
        Temp.Append
      else
        Temp.Edit;
      AObj.WriteToDataSet(Temp,False);
      Temp.Post;
   end;
var tmp:TZQuery;
    UPDUTY_ID:string;
    j:integer;
begin
  if Trim(edtDUTY_NAME.Text)='' then
  begin
    if edtDUTY_NAME.CanFocus then edtDUTY_NAME.SetFocus;
    raise Exception.Create('职务名称不能为空!');
  end;
  if Trim(edtDUTY_SPELL.Text)='' then
  begin
    if edtDUTY_SPELL.CanFocus then  edtDUTY_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空!');
  end;
  if Trim(edtREMARK.Text)='' then
  begin
    if edtREMARK.CanFocus then  edtREMARK.SetFocus;
    raise Exception.Create('描述不能为空!');
  end;

  if edtDUTY_NAME.Text<>cdsTable.FieldByName('DUTY_NAME').AsString  then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('CA_DUTY_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if (tmp.FieldByName('DUTY_NAME').AsString=edtDUTY_NAME.Text) and (tmp.FieldByName('DUTY_ID').AsString<>cdsTable.FieldByName('DUTY_ID').AsString) then
        begin
          if edtDUTY_NAME.CanFocus then  edtDUTY_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:职务名称已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('CA_DUTY_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if tmp.FieldByName('DUTY_NAME').AsString=edtDUTY_NAME.Text then
        begin
          if edtDUTY_NAME.CanFocus then edtDUTY_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:职务名称已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
  end;

  WriteToObject(AObj,self);
  Aobj.FieldByName('COMP_ID').AsString:='----';
  Aobj.FieldByName('DUTY_ID').AsString:=edtDUTY_ID.Text;
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then  Exit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;

  //闭合算法判断上级职务不能是自己
  if dbState=dsInsert then
  begin
    UpdateToGlobal(Aobj);    
  end;
  if dbState=dsEdit then
  begin
    tmp:=Global.GetZQueryFromName('CA_DUTY_INFO');
    if tmp.Locate('DUTY_ID',edtDUTY_ID.Text,[]) then
    begin
      UPDUTY_ID:=tmp.FieldbyName('UPDUTY_ID').asString;
      tmp.Edit;
      tmp.FieldbyName('UPDUTY_ID').asString:=edtUPDUTY_ID.AsString;
      tmp.Post;
    end;
  end;
  if  Factor.UpdateBatch(cdsTable,'TDuty',nil) then
    UpdateToGlobal(Aobj);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmDutyInfo.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmDutyInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmDutyInfo.btnOkClick(Sender: TObject);
begin
  inherited;
  Save;
  if Saved and Assigned(OnSave) then
  begin
    OnSave(AObj);
    if MessageBox(Handle,'是否继续新增职务?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end else
    ModalResult := MROK;
end;

procedure TfrmDutyInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDutyInfo.edtDUTY_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtDUTY_SPELL.Text := fnString.GetWordSpell(edtDUTY_NAME.Text,3);
end;

procedure TfrmDutyInfo.edtUPDUTY_IDBeforeDropList(Sender: TObject);
var
  Cnd: string;
begin
  inherited;
  Cnd:=' and TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID);
  drpDeptDuty.Close;
  drpDeptDuty.SQL.Text:='select * from CA_DUTY_INFO where COMM not in (''02'',''12'') '+Cnd;
  Factor.Open(drpDeptDuty);
end;

procedure TfrmDutyInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtDUTY_NAME.CanFocus then edtDUTY_NAME.SetFocus;
end;
procedure TfrmDutyInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label2.Visible:=True;
  Label4.Visible:=True;
  Label5.Visible:=True;
  Label6.Visible:=True;
  btnOk.Visible := (Value<>dsBrowse);
  case dbState of
  dsInsert:Caption:='职务档案--(新增)';
  dsEdit:Caption:='职务档案--(修改)';
  else
    begin
      Caption:='职务档案';
      Label2.Visible:=False;
      Label4.Visible:=False;
      Label5.Visible:=False;
      Label6.Visible:=False;
    end;
  end;
end;

procedure TfrmDutyInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtDUTY_NAME.Text)='')) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'职务档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmDutyInfo.WriteTo(Aobj: TRecord_);
begin
  WriteToObject(AObj,self);
  Aobj.FieldByName('COMP_ID').AsString:='----';
  Aobj.FieldByName('DUTY_ID').AsString:=edtDUTY_ID.Text;  
end;

class function TfrmDutyInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
   //新R3内ShopGlobal没有此方法:
   //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能修改职务!');
   if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改职务的权限,请和管理员联系.');
   with TfrmDeptDutyInfo.Create(Owner) do
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

class function TfrmDutyInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   //新R3内ShopGlobal没有此方法:
   //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能新增职务!');
   if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增职务的权限,请和管理员联系.');
   with TfrmDeptDutyInfo.Create(Owner) do
    begin
      try
        Append;
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

end.
