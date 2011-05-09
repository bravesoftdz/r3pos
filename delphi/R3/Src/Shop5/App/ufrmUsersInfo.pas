unit ufrmUsersInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, RzLabel, RzButton, cxMemo, cxControls, cxContainer, cxEdit,
  cxTextEdit, ZBase, cxRadioGroup, DB, cxDropDownEdit,
  cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmUsersInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    lab_WORK_DATE: TRzLabel;
    lab_REMARK: TRzLabel;
    lab_DIMI_DATE: TRzLabel;
    edtWORK_DATE: TcxDateEdit;
    edtDIMI_DATE: TcxDateEdit;
    labIDN_TYPE: TRzLabel;
    RzLabel1: TRzLabel;
    lab_ACCOUNT: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    lab_USER_NAME: TRzLabel;
    edtUSER_NAME: TcxTextEdit;
    lab_USER_SPELL: TRzLabel;
    edtUSER_SPELL: TcxTextEdit;
    edtSHOP_ID: TzrComboBoxList;
    lab_DUTY_IDS: TRzLabel;
    RzLabel4: TRzLabel;
    edtDUTY_IDS: TzrComboBoxList;
    LabID_NUMBER: TRzLabel;
    edtID_NUMBER: TcxTextEdit;
    RzLabel13: TRzLabel;
    edtREMARK: TcxMemo;
    RzLabel2: TRzLabel;
    edtSEX: TRadioGroup;
    ADODataSet1: TZQuery;
    cdsTable: TZQuery;
    lab_SHOP_ID: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    edtDEPT_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    edtIDN_TYPE: TcxComboBox;
    labBIRTHDAY: TRzLabel;
    edtBIRTHDAY: TcxDateEdit;
    labDEGREES: TRzLabel;
    edtDEGREES: TcxComboBox;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    lab_POSTALCODE: TRzLabel;
    lab_OFFI_TELE: TRzLabel;
    lab_MOBILE: TRzLabel;
    lab_FAMI_TELE: TRzLabel;
    lab_FAMI_ADDR: TRzLabel;
    lab_EMAIL: TRzLabel;
    RzLabel8: TRzLabel;
    Lab_MSN: TRzLabel;
    lab_MM: TRzLabel;
    edtPOSTALCODE: TcxTextEdit;
    edtOFFI_TELE: TcxTextEdit;
    edtMOBILE: TcxTextEdit;
    edtFAMI_TELE: TcxTextEdit;
    edtFAMI_ADDR: TcxTextEdit;
    edtEMAIL: TcxTextEdit;
    edtQQ: TcxTextEdit;
    edtMSN: TcxTextEdit;
    edtMM: TcxTextEdit;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_USER_NAMEPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtDUTY_IDSAddClick(Sender: TObject);
    procedure edtDEPT_IDAddClick(Sender: TObject);
    procedure edtSHOP_IDAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //ccid:string;
    Aobj:TRecord_;
    Saved:Boolean;
    procedure IniDegrees;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure Writeto(Aobj:TRecord_);
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断会员档案是否有修改
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:string):boolean;
  end;

implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,ufrmshopinfo,ufrmDeptInfo,EncDec,ufrmDutyInfo,uShopGlobal;//
{$R *.dfm}

procedure TfrmUsersInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtSEX.Enabled := True;
  edtWORK_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  
  edtDEGREES.ItemIndex :=2;  
  if (edtDUTY_IDS.DataSet.Active) and (not edtDUTY_IDS.DataSet.IsEmpty) then
    begin
      edtDUTY_IDS.DataSet.First;
      edtDUTY_IDS.KeyValue:= edtDUTY_IDS.DataSet.FieldByName(edtDUTY_IDS.KeyField).AsString;
      edtDUTY_IDS.Text:= edtDUTY_IDS.DataSet.FieldByName(edtDUTY_IDS.ListField).AsString;
    end;
  if (edtDEPT_ID.DataSet.Active) and (not edtDEPT_ID.DataSet.IsEmpty) then
    begin
      edtDEPT_ID.DataSet.First;
      edtDEPT_ID.KeyValue:= edtDEPT_ID.DataSet.FieldByName(edtDEPT_ID.KeyField).AsString;
      edtDEPT_ID.Text:= edtDEPT_ID.DataSet.FieldByName(edtDEPT_ID.ListField).AsString;
    end;
  edtIDN_TYPE.ItemIndex := 0;
end;

procedure TfrmUsersInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUsersInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  edtSEX.Enabled := True;
  if AObj.FieldByName('SEX').AsString='' then edtSEX.ItemIndex:=-1;
end;

procedure TfrmUsersInfo.FormCreate(Sender: TObject);
begin
  inherited;
  AddCbxPickList(edtIDN_TYPE,'',Global.GetZQueryFromName('PUB_IDNTYPE_INFO')); 
  edtSHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDUTY_IDS.DataSet := Global.GetZQueryFromName('CA_DUTY_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  IniDegrees;
  Aobj := TRecord_.Create;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      lab_SHOP_ID.Visible := False;
      edtSHOP_ID.KeyValue:=IntToStr(Global.TENANT_ID)+'0001';
      edtSHOP_ID.Text := edtSHOP_ID.DataSet.FieldByName(edtSHOP_ID.ListField).AsString;
      edtSHOP_ID.Visible := False;
      RzLabel3.Visible := False;
    end;
end;

procedure TfrmUsersInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
  Freeform(Self);
end;

procedure TfrmUsersInfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('USER_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TUsers',Params);
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    {//edtUSER_SPELL.Text:=AObj.FieldByName('USER_SPELL').AsString;
    edtSHOP_ID.KeyValue:=Aobj.FieldByName('SHOP_ID').AsString;
    edtSHOP_ID.Text := edtSHOP_ID.DataSet.FieldByName(edtSHOP_ID.ListField).AsString;
    edtDUTY_IDS.Text:=AObj.FieldByName('DUTY_IDS_TEXT').AsString;}
    edtSEX.ItemIndex:=AObj.FieldByName('SEX').AsInteger;
    dbState := dsBrowse;
    edtSEX.Enabled := False;
  finally
  Params.Free;
  end;
end;

procedure TfrmUsersInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('CA_USERS');
      Temp.Filtered := false;
      if Temp.Locate('USER_ID',AObj.FieldByName('USER_ID').AsString,[]) then
         Temp.Edit
      else
         Temp.Append;
      AObj.WriteToDataSet(Temp,false);
      Temp.Post;
   end;
var temp,tmp,tmp1:TZQuery;
    j:integer;
begin
  if dbState=dsBrowse then exit;
  if trim(edtACCOUNT.Text)='' then
  begin
    if edtACCOUNT.CanFocus then edtACCOUNT.SetFocus;
    raise Exception.Create('用户账号不能为空！');
  end;
  if trim(edtUSER_NAME.Text)='' then
  begin
    if edtUSER_NAME.CanFocus then edtUSER_NAME.SetFocus;
    raise Exception.Create('用户姓名不能为空！');
  end;
  if trim(edtUSER_SPELL.Text)='' then
  begin
    if edtUSER_SPELL.CanFocus then edtUSER_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空！');
  end;
  if trim(edtDUTY_IDS.AsString)='' then
  begin
    if edtDUTY_IDS.CanFocus then edtDUTY_IDS.SetFocus;
    raise Exception.Create('职务不能为空！');
  end;
  if trim(edtDEPT_ID.AsString)='' then
  begin
    if edtDEPT_ID.CanFocus then edtDEPT_ID.SetFocus;
    raise Exception.Create('部门不能为空！');
  end;
  if trim(edtSHOP_ID.AsString)='' then
  begin
    if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
    raise Exception.Create('所属门店不能为空！');
  end;

  //此检测，现已经不能只对前台检测，要OBJ中对整个数据库检测
  if dbState = dsInsert then
  begin
     temp := Global.GetZQueryFromName('CA_USERS');
     if temp.Locate('ACCOUNT',Trim(edtACCOUNT.Text),[]) then
        raise Exception.Create('该用户账号已经存在，不能重复！');
  end;

  if dbState = dsEdit then
  begin
    temp:=Global.GetZQueryFromName('CA_USERS');
    if temp.Locate('ACCOUNT',Trim(edtACCOUNT.Text),[]) then
      if temp.FieldByName('USER_ID').AsString<>AObj.FieldByName('USER_ID').AsString then
        raise  Exception.Create('该用户账号已经存在，不能重复！');
  end;

  if edtUSER_NAME.Text<>cdsTable.FieldByName('USER_NAME').AsString  then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('CA_USERS');
      if temp.Locate('USER_NAME',Trim(edtUSER_NAME.Text),[]) then
        if tmp.FieldByName('USER_ID').AsString<>cdsTable.FieldByName('USER_ID').AsString then
          MessageBox(handle,Pchar('提示:用户名称已经存在!'),Pchar(Caption),MB_OK);
    end;
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('CA_USERS');
      if temp.Locate('USER_NAME',Trim(edtUSER_NAME.Text),[]) then
        begin
          if edtUSER_NAME.CanFocus then edtUSER_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:用户姓名已经存在!'),Pchar(Caption),MB_OK);
        end;
    end;
  end;
  //检测结束
  WriteToObject(Aobj,self);

  if edtSEX.ItemIndex=-1 then
    AObj.FieldByName('SEX').AsString:=''
  else
    AObj.FieldByName('SEX').AsInteger:=edtSEX.ItemIndex;
  if not IsEdit(Aobj,cdsTable) then exit;
  if dbState = dsInsert then
  begin
    AObj.FieldbyName('USER_ID').AsString := TSequence.NewId;
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Aobj.FieldByName('ROLE_IDS').AsString := '#';
    Aobj.FieldByName('ROLE_IDS_TEXT').AsString := '#';
    Aobj.FieldByName('PASS_WRD').AsString := EncStr('1234',ENC_KEY);
  end;
  if dbState=dsInsert then
    cdsTable.Append
  else if dbState=dsEdit then
    cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  if Factor.UpdateBatch(cdsTable,'TUsers',nil) then
     UpdateToGlobal(AObj);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmUsersInfo.Btn_SaveClick(Sender: TObject);
var bl:boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增用户?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmUsersInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtACCOUNT.CanFocus then edtACCOUNT.SetFocus;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmUsersInfo.edt_USER_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  If dbState <> dsBrowse Then
     edtUSER_SPELL.Text := FnString.GetWordSpell(edtUSER_NAME.Text);
end;

procedure TfrmUsersInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  RzLabel1.Visible:=True;
  RzLabel2.Visible:=True;
  RzLabel4.Visible:=True;
  //RzLabel7.Visible:=True;
  Btn_Save.Visible := (value<>dsBrowse);
  case dbState of
  dsInsert:Caption:='用户档案--(新增)';
  dsEdit:Caption:='用户档案--(修改)';
  else
    begin
      Caption:='用户档案';
      RzLabel1.Visible:=False;
      RzLabel2.Visible:=False;
      RzLabel4.Visible:=False;
      
      //RzLabel7.Visible:=False;
    end;
  end;
end;

function TfrmUsersInfo.IsEdit(Aobj: TRecord_;
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

procedure TfrmUsersInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtUSER_NAME.Text)='')) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'用户档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmUsersInfo.Writeto(Aobj: TRecord_);
begin
  WriteToObject(Aobj,self);
  if edtSEX.ItemIndex=-1 then
    AObj.FieldByName('SEX').AsString:=''
  else
    AObj.FieldByName('SEX').AsInteger:=edtSEX.ItemIndex;
end;

class function TfrmUsersInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增用户的权限,请和管理员联系.');
   with TfrmUsersInfo.Create(Owner) do
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

class function TfrmUsersInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('31500001',3) then Raise Exception.Create('你没有修改用户的权限,请和管理员联系.');
   with TfrmUsersInfo.Create(Owner) do
    begin
      try
        Edit(id);
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

procedure TfrmUsersInfo.edtDUTY_IDSAddClick(Sender: TObject);
var AObj_5:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');  
  AObj_5 := TRecord_.Create;
  try
    if TfrmDutyInfo.AddDialog(self,AObj_5) then
       begin
         edtDUTY_IDS.KeyValue := AObj_5.FieldbyName('DUTY_ID').asString;
         edtDUTY_IDS.Text := AObj_5.FieldbyName('DUTY_NAME').asString;
       end;
  finally
    AObj_5.Free;
  end;
end;

class function TfrmUsersInfo.ShowDialog(Owner: TForm; id: string): boolean;
begin
   with TfrmUsersInfo.Create(Owner) do
    begin
      try
        Open(id);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmUsersInfo.IniDegrees;
var Tem:TZQuery;
    Aobj_3:TRecord_;
begin
  try
    Tem := TZQuery.Create(nil);
    Tem.Close;
    Tem.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''14'' and TENANT_ID=0 order by SEQ_NO';
    Factor.Open(Tem);
    if not Tem.IsEmpty then ClearCbxPickList(edtDEGREES);
    Tem.First;
    while not Tem.Eof do
      begin
        Aobj_3 := TRecord_.Create;
        Aobj_3.ReadFromDataSet(Tem);
        edtDEGREES.Properties.Items.AddObject(Tem.FieldbyName('CODE_NAME').AsString,Aobj_3);
        Tem.Next;
      end;
  finally
    Tem.Free;
  end;
end;

procedure TfrmUsersInfo.edtDEPT_IDAddClick(Sender: TObject);
var AObj_1:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj_1 := TRecord_.Create;
  try
    if TfrmDeptInfo.AddDialog(self,AObj_1) then
       begin
         edtDEPT_ID.KeyValue := AObj_1.FieldbyName('DEPT_ID').asString;
         edtDEPT_ID.Text := AObj_1.FieldbyName('DEPT_NAME').asString;
       end;
  finally
    AObj_1.Free;
  end;
end;

procedure TfrmUsersInfo.edtSHOP_IDAddClick(Sender: TObject);
var AObj_2:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj_2 := TRecord_.Create;
  try
    if TfrmShopInfo.AddDialog(self,AObj_2) then
       begin
         edtSHOP_ID.KeyValue := AObj_2.FieldbyName('SHOP_ID').asString;
         edtSHOP_ID.Text := AObj_2.FieldbyName('SHOP_NAME').asString;
       end;
  finally
    AObj_2.Free;
  end;
end;

end.
