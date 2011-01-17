unit ufrmUsersInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, RzLabel, RzButton, cxMemo, cxControls, cxContainer, cxEdit,
  cxTextEdit, ZBase, cxRadioGroup, DB, DBClient, cxDropDownEdit, ADODB,
  cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmUsersInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    lab_WORK_DATE: TRzLabel;
    lab_REMARK: TRzLabel;
    lab_POSTALCODE: TRzLabel;
    lab_OFFI_TELE: TRzLabel;
    lab_MOBILE: TRzLabel;
    lab_FAMI_TELE: TRzLabel;
    lab_FAMI_ADDR: TRzLabel;
    lab_EMAIL: TRzLabel;
    lab_DIMI_DATE: TRzLabel;
    edtPOSTALCODE: TcxTextEdit;
    edtOFFI_TELE: TcxTextEdit;
    edtMOBILE: TcxTextEdit;
    edtFAMI_TELE: TcxTextEdit;
    edtFAMI_ADDR: TcxTextEdit;
    edtEMAIL: TcxTextEdit;
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
    RzLabel7: TRzLabel;
    edtSHOP_ID: TzrComboBoxList;
    lab_DUTY_IDS: TRzLabel;
    RzLabel4: TRzLabel;
    edtDUTY_IDS: TzrComboBoxList;
    LabID_NUMBER: TRzLabel;
    edtID_NUMBER: TcxTextEdit;
    RzLabel8: TRzLabel;
    edtQQ: TcxTextEdit;
    RzLabel13: TRzLabel;
    edtREMARK: TcxMemo;
    RzLabel2: TRzLabel;
    edtSEX: TRadioGroup;
    ADODataSet1: TZQuery;
    cdsTable: TZQuery;
    Lab_MSN: TRzLabel;
    edtMSN: TcxTextEdit;
    lab_SHOP_ID: TRzLabel;
    edtIDN_TYPE: TcxComboBox;
    RzLabel3: TRzLabel;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_USER_NAMEPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtDUTY_IDSAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //ccid:string;
    Aobj:TRecord_;
    Saved:Boolean;
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
uses uShopUtil,uDsUtil, ufrmBasic, Math, uGlobal, uFnUtil, uShopGlobal;//,ufrmDeptDutyInfo
{$R *.dfm}

procedure TfrmUsersInfo.Append;
//var tmp:TADODataSet;
begin
  Open('');
  dbState := dsInsert;
  edtACCOUNT.Text:='自动编号..';
  edtSEX.ItemIndex := 0;
  {edtWORK_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.CompanyID;
  edtSHOP_ID.Text := Global.CompanyName;}
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
  if AObj.FieldByName('SEX').AsString='' then edtSEX.ItemIndex:=-1;
end;

procedure TfrmUsersInfo.FormCreate(Sender: TObject);
begin
  inherited;
  {ccid:=ShopGlobal.GetSHOP_ID(Global.UserID);
  if (ShopGlobal.GetIsCompany(Global.UserID)) and  (ccid<>Global.CompanyID) then
    ccid:=ccid
  else
    ccid:=Global.CompanyID;}

  edtSHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
  Aobj := TRecord_.Create;
end;

procedure TfrmUsersInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmUsersInfo.Open(code: string);
var
  Params:TftParamList;
  rs:TZQuery;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('USER_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TUsers',Params);
    cdsTable.Active;
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    edtUSER_SPELL.Text:=AObj.FieldByName('USER_SPELL').AsString;
    edtSHOP_ID.Text:=Aobj.FieldByName('SHOP_ID').AsString;
    edtDUTY_IDS.Text:=AObj.FieldByName('DUTY_NAMES').AsString;
    edtSEX.ItemIndex:=AObj.FieldByName('SEX').AsInteger;
    dbState := dsBrowse;
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
        raise Exception.Create('该用户账号，不能重复！');
  end;

  if dbState = dsEdit then
  begin
      temp:=Global.GetZQueryFromName('CA_USERS');
      temp.First;
      while not temp.Eof do
      begin
        if (temp.FieldByname('ACCOUNT').AsString=edtACCOUNT.Text)  and (temp.FieldByName('USER_ID').AsString<>AObj.FieldByName('USER_ID').AsString)then
          raise  Exception.Create('该用户账号已经存在，不能重复！');
        temp.Next;
      end;
  end;

  if edtUSER_NAME.Text<>cdsTable.FieldByName('USER_NAME').AsString  then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('CA_USERS');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if (tmp.FieldByName('USER_NAME').AsString=edtUSER_NAME.Text) and (tmp.FieldByName('USER_ID').AsString<>cdsTable.FieldByName('USER_ID').AsString) then
        begin
          if edtUSER_NAME.CanFocus then edtUSER_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:用户名称已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('CA_USERS');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if tmp.FieldByName('USER_NAME').AsString=edtUSER_NAME.Text then
        begin
          if edtUSER_NAME.CanFocus then edtUSER_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:用户姓名已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
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
    //AObj.FieldbyName('DEPT_ID').AsString := '111';
    //AObj.FieldbyName('DUTY_IDS').AsString := '111';
    //AObj.FieldbyName('DUTY_NAMES').AsString := '111';

    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  end;
  if (AObj.FieldbyName('ACCOUNT').AsString='') or (AObj.FieldbyName('ACCOUNT').AsString='自动编号..') then
     AObj.FieldbyName('ACCOUNT').AsString := AObj.FieldbyName('USER_ID').AsString;
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
  edtDUTY_IDS.DataSet:=Global.GetZQueryFromName('CA_DUTY_INFO');
  if edtACCOUNT.CanFocus then edtACCOUNT.SetFocus;
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
  RzLabel7.Visible:=True;
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
      RzLabel7.Visible:=False;
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
{   if not ShopGlobal.GetChkRight('100017') then Raise Exception.Create('你没有新增用户的权限,请和管理员联系.'); }
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
{   if not ShopGlobal.GetChkRight('100018') then Raise Exception.Create('你没有修改用户的权限,请和管理员联系.'); }
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
var AObj:TRecord_;
begin
  inherited;
 {AObj := TRecord_.Create;
  try
    if TfrmDeptDutyInfo.AddDialog(self,AObj) then
       begin
         edtDUTY_IDS.KeyValue := AObj.FieldbyName('DUTY_ID').asString;
         edtDUTY_IDS.Text := AObj.FieldbyName('DUTY_NAME').asString;
       end;
  finally
    AObj.Free;
  end;}
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

end.
