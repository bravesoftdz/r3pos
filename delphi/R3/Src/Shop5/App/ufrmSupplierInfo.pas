unit ufrmSupplierInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, DB,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  zBase, uShopUtil, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit,
  cxMemo, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmSupplierInfo = class(TframeDialogForm)
    labHOMEPAGE: TRzLabel;
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzPanel1: TRzPanel;
    labCLIENT_NAME: TRzLabel;
    edtCLIENT_NAME: TcxTextEdit;
    labCLIENT_SPELL: TRzLabel;
    edtCLIENT_SPELL: TcxTextEdit;
    RzLabel6: TRzLabel;
    edtSORT_ID: TzrComboBoxList;
    edtREMARK: TcxMemo;
    RzLabel13: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel14: TRzLabel;
    edtREGION_ID: TzrComboBoxList;
    RzLabel1: TRzLabel;
    edtCLIENT_CODE: TcxTextEdit;
    RzLabel15: TRzLabel;
    edtTAX_RATE: TcxTextEdit;
    RzLabel11: TRzLabel;
    cdsTable: TZQuery;
    labSHOP_ID: TRzLabel;
    TabSheet2: TRzTabSheet;
    RzPanel3: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel22: TRzLabel;
    edtSHOP_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    RzLabel3: TRzLabel;
    edtINVOICE_FLAG: TcxComboBox;
    labLINKMAN: TRzLabel;
    labTELEPHONE1: TRzLabel;
    labPOSTALCODE: TRzLabel;
    labFAXES: TRzLabel;
    labEMAIL: TRzLabel;
    labTELEPHONE2: TRzLabel;
    RzLabel5: TRzLabel;
    labADDRESS: TRzLabel;
    labMSN: TRzLabel;
    RzLabel12: TRzLabel;
    edtLINKMAN: TcxTextEdit;
    edtTELEPHONE1: TcxTextEdit;
    edtPOSTALCODE: TcxTextEdit;
    edtFAXES: TcxTextEdit;
    edtEMAIL: TcxTextEdit;
    edtQQ: TcxTextEdit;
    edtTELEPHONE2: TcxTextEdit;
    edtADDRESS: TcxTextEdit;
    edtMSN: TcxTextEdit;
    edtHOMEPAGE: TcxTextEdit;
    RzLabel23: TRzLabel;
    edtLICENSE_CODE: TcxTextEdit;
    edtBANK_ID: TcxComboBox;
    edtSETTLE_CODE: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtCLIENT_NAMEPropertiesChange(Sender: TObject);
    procedure edtSORT_IDAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtSORT_IDSaveValue(Sender: TObject);
    procedure edtCLIENT_TYPEPropertiesChange(Sender: TObject);
    procedure edtREGION_IDAddClick(Sender: TObject);
    procedure edtSETTLE_CODEAddClick(Sender: TObject);
  private
    ccid:string;
    { Private declarations }
  public
    { Public declarations }
    Saved,locked:boolean;
    Aobj:TRecord_;
    DefInvFlag:integer;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure WriteTo(AObj:TRecord_);
    function  IsEdit(Aobj:TRecord_;cdsTable:TDataSet):Boolean;//判断单位资料是否有修改
    class function AddDialog(Owner:TForm;var AObj1:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var AObj1:TRecord_):boolean;
  end;


implementation
uses uDsUtil, ufrmBasic, Math, uGlobal, uFnUtil,ufrmCodeInfo,uShopGlobal;//,ufrmREGION
{$R *.dfm}

procedure TfrmSupplierInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtCLIENT_CODE.Text:='自动编号..';
  edtCLIENT_CODE.SelectAll;
  if edtINVOICE_FLAG.ItemIndex<0 then edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',inttostr(DefInvFlag));
  edtSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Global.SHOP_ID);
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSORT_ID.KeyValue:='#';
  edtSORT_ID.Text:='无';
  edtREGION_ID.KeyValue:='#';
  edtREGION_ID.Text:='无';
  edtSETTLE_CODE.KeyValue:='#';
  edtSETTLE_CODE.Text:='无';
end;

procedure TfrmSupplierInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

procedure TfrmSupplierInfo.Open(code: string);
var
  Params:TftParamList;
begin
  locked:=True;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CLIENT_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TSupplier',Params);
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    edtSORT_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTSORT'),'CODE_ID','CODE_NAME',Aobj.FieldByName('SORT_ID').AsString);
    edtSORT_ID.KeyValue := Aobj.FieldByName('SORT_ID').AsString;
    edtREGION_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_REGION_INFO'),'CODE_ID','CODE_NAME',Aobj.FieldByName('REGION_ID').AsString);
    edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
    edtSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Aobj.FieldByName('SHOP_ID').AsString);
    edtSHOP_ID.KeyValue := Aobj.FieldByName('SHOP_ID').AsString;
    dbState := dsBrowse;
  finally
    Params.Free;
    locked:=False;
  end;
end;

procedure TfrmSupplierInfo.Save;
  procedure UpdateToGlobal(AObj:TRecord_);
  var Tmp:TZQuery;
  begin
    Tmp := Global.GetZQueryFromName('PUB_CLIENTINFO');
    Tmp.Filtered := false;
    if (not Tmp.Locate('CLIENT_ID',AObj.FieldByName('CLIENT_ID').AsString,[])) then
       Tmp.Append
    else
       Tmp.Edit;
    AObj.WriteToDataSet(Tmp,false);
    Tmp.Post;
  end;
var tmp:TZQuery;
j:integer;
begin
  if trim(edtCLIENT_NAME.Text)='' then
  begin
    if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
    raise Exception.Create('供应商名称不能为空！');
  end;

  if trim(edtREGION_ID.AsString)='' then
  begin
     if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
     raise Exception.Create('地区不能为空！');
  end;

  if trim(edtSETTLE_CODE.Text) = '' then
    begin
      if edtSETTLE_CODE.CanFocus then edtSETTLE_CODE.SetFocus;
      Raise Exception.Create('结算方式不能为空！');
    end;

  if Trim(edtSORT_ID.Text) = '' then
    begin
      if edtSORT_ID.CanFocus then edtSORT_ID.SetFocus;
      Raise Exception.Create('供应商分类不能为空！');
    end;

  if edtCLIENT_NAME.Text<>cdsTable.FieldByName('CLIENT_NAME').AsString  then
  begin
    if dbState in [dsEdit,dsInsert] then
    begin
      tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
      if tmp.Locate('CLIENT_NAME',Trim(edtCLIENT_NAME.Text),[]) and (tmp.FieldByName('CLIENT_ID').AsString<>cdsTable.FieldByName('CLIENT_ID').AsString) then
        begin
          if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:供应商名称已经存在!'),Pchar(Caption),MB_OK);
        end;
    end;
  end;
  
  if dbState=dsEdit then
  begin
    tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    if tmp.Locate('CLIENT_CODE',Trim(edtCLIENT_CODE.Text),[]) and (tmp.FieldByName('CLIENT_ID').AsString<>AObj.FieldByName('CLIENT_ID').AsString) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('供应商代号已经存在，不能重复！');
    end;
  end;
  if dbState=dsInsert then
  begin
    tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    if tmp.Locate('CLIENT_CODE',Trim(edtCLIENT_CODE.Text),[]) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('供应商代号已经存在，不能重复！');
    end;
  end;
  if dbState = dsInsert then
  begin
    AObj.FieldbyName('CLIENT_ID').AsString := TSequence.NewId;
  end;
  WriteToObject(Aobj,self);
  Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Aobj.FieldByName('CLIENT_TYPE').AsInteger := 1;
  Aobj.FieldByName('SHOP_ID').AsString:=edtSHOP_ID.AsString;
  Aobj.FieldByName('SORT_ID').AsString:=edtSORT_ID.AsString;
  Aobj.FieldByName('REGION_ID').AsString:=edtREGION_ID.AsString;
  if (AObj.FieldbyName('CLIENT_CODE').AsString='') or (AObj.FieldbyName('CLIENT_CODE').AsString='自动编号..') then
    AObj.FieldbyName('CLIENT_CODE').AsString :=FnString.GetCodeFlag(inttostr(strtoint(copy(Global.SHOP_ID,8,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then Exit;
  cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  if Factor.UpdateBatch(cdsTable,'TSupplier',nil) then
      UpdateToGlobal(Aobj);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmSupplierInfo.FormCreate(Sender: TObject);
begin
  inherited;
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);
  Aobj := TRecord_.Create;
  edtSORT_ID.DataSet:=Global.GetZQueryFromName('PUB_SUPPERSORT');
  edtREGION_ID.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtSETTLE_CODE.DataSet := Global.GetZQueryFromName('PUB_SETTLE_CODE');

  AddCbxPickList(edtBANK_ID,'',Global.GetZQueryFromName('PUB_BANK_INFO'));
end;

procedure TfrmSupplierInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmSupplierInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSupplierInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  {RzLabel2.Visible:=true;
  RzLabel4.Visible:=true;
  RzLabel13.Visible:=true;
  RzLabel14.Visible:=true;}
  Btn_Save.Visible := (value<>dsBrowse);
  case Value of
  dsInsert:Caption := '供应商档案--(新增)';
  dsEdit:Caption := '供应商档案--(修改)';
  else
      begin
        Caption := '供应商档案';
        {RzLabel2.Visible:=False;
        RzLabel4.Visible:=False;
        RzLabel13.Visible:=False;
        RzLabel14.Visible:=False;}
      end;
  end;
end;

procedure TfrmSupplierInfo.FormShow(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := TabSheet1.TabIndex;
  if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
end;

procedure TfrmSupplierInfo.Btn_SaveClick(Sender: TObject);
var i:integer;
    SORT_id,REGION_ID,SORT_NAME,REGION_NAME:string;
    bl:Boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bl then //继续新增
  begin
    if MessageBox(Handle,'是否继续新增单位?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
    begin
      //保存继续新增前的单位类别、地区等等
      i:=edtINVOICE_Flag.ItemIndex;
      SORT_ID:=edtSORT_ID.KeyValue;
      SORT_NAME:=edtSORT_ID.Text;
      REGION_ID:=edtREGION_ID.KeyValue;
      REGION_NAME:=edtREGION_ID.Text;

      Append;
      //继续新增后,把保存的单位类别、地区等赋值
      edtINVOICE_Flag.ItemIndex:=i;
      edtSORT_ID.KeyValue:=SORT_ID;
      edtSORT_ID.Text:=SORT_NAME;
      edtREGION_ID.KeyValue:=REGION_ID;
      edtREGION_ID.Text:=REGION_NAME;
      if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
    end
    else ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmSupplierInfo.edtCLIENT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  if dbState<>dsBrowse then
  edtCLIENT_SPELL.Text := fnString.GetWordSpell(edtCLIENT_NAME.Text,3);
end;

function TfrmSupplierInfo.IsEdit(Aobj: TRecord_;
  cdsTable: TDataSet): Boolean;
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

class function TfrmSupplierInfo.AddDialog(Owner: TForm;
  var AObj1: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33100001',2) then Raise Exception.Create('你没有新增供应商的权限,请和管理员联系.');
   with TfrmSupplierInfo.Create(Owner) do
   begin
      try
        Append;
        if ShowModal=MROK then
        begin
          AObj.CopyTo(AObj1);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
   end;
end;

procedure TfrmSupplierInfo.edtSORT_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,AObj,9) then
       begin
         edtREGION_ID.KeyValue := AObj.FieldbyName('CODE_ID').asString;
         edtREGION_ID.Text := AObj.FieldbyName('CODE_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmSupplierInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtCLIENT_NAME.Text)='')) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'供应商档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmSupplierInfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
  Aobj.FieldByName('SORT_ID').AsString:=edtSORT_ID.AsString;
  Aobj.FieldByName('REGION_ID').AsString:=edtREGION_ID.AsString;
end;

class function TfrmSupplierInfo.EditDialog(Owner: TForm; id: string;
  var AObj1: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33100001',3) then Raise Exception.Create('你没有修改供应商的权限,请和管理员联系.');
   with TfrmSupplierInfo.Create(Owner) do
    begin
      try
        Edit(id);
        if ShowModal=MROK then
        begin
          AObj.CopyTo(AObj1);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmSupplierInfo.edtSORT_IDSaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的单位类别是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmSupplierInfo.edtCLIENT_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  {if edtCLIENT_FLAG.ItemIndex=1 then
  begin
    RzLabel16.Visible:=False;
    edtPRICE_LEVEL.Visible:=False;
  end
  else
  begin
    RzLabel16.Visible:=True;
    edtPRICE_LEVEL.Visible:=True;
  end; }
end;

procedure TfrmSupplierInfo.edtREGION_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,AObj,8) then
       begin
         edtREGION_ID.KeyValue := AObj.FieldbyName('CODE_ID').asString;
         edtREGION_ID.Text := AObj.FieldbyName('CODE_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmSupplierInfo.edtSETTLE_CODEAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,AObj,6) then
       begin
         edtREGION_ID.KeyValue := AObj.FieldbyName('CODE_ID').asString;
         edtREGION_ID.Text := AObj.FieldbyName('CODE_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

end.
