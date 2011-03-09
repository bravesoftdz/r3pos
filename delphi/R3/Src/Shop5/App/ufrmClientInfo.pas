unit ufrmClientInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, DB,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  zBase, uShopUtil, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit,
  cxMemo, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmClientInfo = class(TframeDialogForm)
    labHOMEPAGE: TRzLabel;
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzPanel1: TRzPanel;
    labCLIENT_NAME: TRzLabel;
    edtCLIENT_NAME: TcxTextEdit;
    labCLIENT_SPELL: TRzLabel;
    RzLabel4: TRzLabel;
    edtCLIENT_SPELL: TcxTextEdit;
    RzLabel3: TRzLabel;
    edtINVOICE_FLAG: TcxComboBox;
    RzLabel6: TRzLabel;
    edtSORT_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    edtREMARK: TcxMemo;
    RzLabel13: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel14: TRzLabel;
    edtREGION_ID: TzrComboBoxList;
    RzLabel1: TRzLabel;
    edtCLIENT_CODE: TcxTextEdit;
    RzLabel11: TRzLabel;
    cdsTable: TZQuery;
    RzLabel18: TRzLabel;
    edtBALANCE: TcxTextEdit;
    RzLabel19: TRzLabel;
    edtACCU_INTEGRAL: TcxTextEdit;
    RzLabel20: TRzLabel;
    edtRULE_INTEGRAL: TcxTextEdit;
    RzLabel21: TRzLabel;
    edtINTEGRAL: TcxTextEdit;
    TabSheet2: TRzTabSheet;
    RzPanel3: TRzPanel;
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
    RzLabel8: TRzLabel;
    RzLabel16: TRzLabel;
    RzLabel22: TRzLabel;
    RzLabel23: TRzLabel;
    edtLICENSE_CODE: TcxTextEdit;
    edtBANK_ID: TcxComboBox;
    edtPRICE_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    labSHOP_ID: TRzLabel;
    edtSETTLE_CODE: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtCLIENT_NAMEPropertiesChange(Sender: TObject);
    procedure edtSORT_IDAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtCLIENT_TYPEPropertiesChange(Sender: TObject);
    procedure edtREGION_IDAddClick(Sender: TObject);
    procedure edtPRICE_IDAddClick(Sender: TObject);
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
uses uDsUtil, ufrmBasic, Math, uGlobal, uFnUtil,ufrmCodeInfo,uShopGlobal,ufrmPriceGradeInfo;//,ufrmREGION
{$R *.dfm}

procedure TfrmClientInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtCLIENT_CODE.Text:='自动编号..';
  edtCLIENT_CODE.SelectAll;
  if edtINVOICE_FLAG.ItemIndex<0 then edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',inttostr(DefInvFlag));
  edtBANK_ID.ItemIndex := 0;
  edtSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Global.SHOP_ID);
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtPRICE_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PRICEGRADE'),'PRICE_ID','PRICE_NAME',Global.GetZQueryFromName('PUB_PRICEGRADE').fieldbyname('PRICE_ID').AsString);
  edtPRICE_ID.KeyValue := Global.GetZQueryFromName('PUB_PRICEGRADE').fieldbyname('PRICE_ID').AsString;
  edtSORT_ID.KeyValue:='#';
  edtSORT_ID.Text:='无';
  edtREGION_ID.KeyValue:='#';
  edtREGION_ID.Text:='无';
  edtSETTLE_CODE.KeyValue:='#';
  edtSETTLE_CODE.Text:='无';
end;

procedure TfrmClientInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

procedure TfrmClientInfo.Open(code: string);
var
  Params:TftParamList;
begin
  locked:=True;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CLIENT_ID').asString := code;
    Params.ParamByName('UNION_ID').AsString := '#';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TClient',Params);
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    edtSORT_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTSORT'),'CODE_ID','CODE_NAME',Aobj.FieldByName('SORT_ID').AsString);
    edtSORT_ID.KeyValue := Aobj.FieldByName('SORT_ID').AsString;
    if Aobj.FieldByName('REGION_ID').AsString = '#' then
      begin
        edtREGION_ID.Text:='无';
        edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
      end
    else
      begin
        edtREGION_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_REGION_INFO'),'CODE_ID','CODE_NAME',Aobj.FieldByName('REGION_ID').AsString);
        edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
      end;
    edtSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Aobj.FieldByName('SHOP_ID').AsString);
    edtSHOP_ID.KeyValue := Aobj.FieldByName('SHOP_ID').AsString;
    edtPRICE_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PRICEGRADE'),'PRICE_ID','PRICE_NAME',Aobj.FieldByName('PRICE_ID').AsString);
    edtPRICE_ID.KeyValue := Aobj.FieldByName('PRICE_ID').AsString;
    dbState := dsBrowse;
  finally
    Params.Free;
    locked:=False;
  end;
end;

procedure TfrmClientInfo.Save;
  procedure UpdateToGlobal(AObj:TRecord_);
  var Tmp:TZQuery;
  begin
    Tmp := Global.GetZQueryFromName('PUB_CUSTOMER');
    if (not Tmp.Locate('CLIENT_ID',AObj.FieldByName('CLIENT_ID').AsString,[])) then
       Tmp.Append
    else
       Tmp.Edit;
    AObj.WriteToDataSet(Tmp,false);
    Tmp.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('CLIENT_CODE').AsString;
    Tmp.FieldByName('TAX_RATE').AsString := '0';
    Tmp.Post;
  end;
var tmp:TZQuery;
j:integer;
begin
  if trim(edtCLIENT_NAME.Text)='' then
  begin
    if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
    raise Exception.Create('客户名称不能为空！');
  end;

  if trim(edtREGION_ID.AsString)='' then
  begin
     if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
     raise Exception.Create('地区不能为空！');
  end;

  if trim(edtPRICE_ID.AsString) = '' then
  begin
    if edtPRICE_ID.CanFocus then edtPRICE_ID.SetFocus;
    Raise Exception.Create('客户等级不能为空！');
  end;

  if trim(edtSETTLE_CODE.AsString) = '' then
    begin
      if edtSETTLE_CODE.CanFocus then edtSETTLE_CODE.SetFocus;
      Raise Exception.Create('结算方式不能为空！');
    end;

  if Trim(edtSORT_ID.Text) = '' then
    begin
      if edtSORT_ID.CanFocus then edtSORT_ID.SetFocus;
      Raise Exception.Create('客户分类不能为空！');
    end;

  if edtCLIENT_NAME.Text<>cdsTable.FieldByName('CLIENT_NAME').AsString  then
    begin
      tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
      if tmp.Locate('CLIENT_NAME',Trim(edtCLIENT_NAME.Text),[]) then
        begin
          if tmp.FieldByName('CLIENT_ID').AsString<>cdsTable.FieldByName('CLIENT_ID').AsString then
            begin
              if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
              MessageBox(handle,Pchar('提示:客户名称已经存在!'),Pchar(Caption),MB_OK);
            end;
        end;
    end;

  if dbState=dsEdit then
  begin
    tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    if tmp.Locate('CLIENT_CODE',Trim(edtCLIENT_CODE.Text),[]) and (tmp.FieldByName('CLIENT_ID').AsString<>AObj.FieldByName('CLIENT_ID').AsString) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('客户编号已经存在，不能重复！');
    end;
  end;
  if dbState=dsInsert then
  begin
    tmp:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    if tmp.Locate('CLIENT_CODE',Trim(edtCLIENT_CODE.Text),[]) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('客户编号已经存在，不能重复！');
    end;
  end;
  if dbState = dsInsert then
  begin
    AObj.FieldbyName('CLIENT_ID').AsString := TSequence.NewId;
    Aobj.FieldByName('CREA_USER').AsString := Global.UserID;
    Aobj.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Global.SysDate);
    Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Aobj.FieldByName('CLIENT_TYPE').AsString  := '2';
    Aobj.FieldByName('IC_INFO').AsString := '企业卡';
    Aobj.FieldByName('UNION_ID').AsString := '#';
    Aobj.FieldByName('IC_STATUS').AsString := '0';
    Aobj.FieldByName('IC_TYPE').AsString := '0';
  end;
  WriteTo(Aobj);

  if (AObj.FieldbyName('CLIENT_CODE').AsString='') or (AObj.FieldbyName('CLIENT_CODE').AsString='自动编号..') then
    AObj.FieldbyName('CLIENT_CODE').AsString :=FnString.GetCodeFlag(inttostr(strtoint(copy(Global.SHOP_ID,8,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));
  Aobj.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('CLIENT_CODE').AsString;
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then Exit;
  cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  if Factor.UpdateBatch(cdsTable,'TClient',nil) then
      UpdateToGlobal(Aobj);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmClientInfo.FormCreate(Sender: TObject);
begin
  inherited;
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);
  Aobj := TRecord_.Create;
  edtSORT_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTSORT');
  edtREGION_ID.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtPRICE_ID.DataSet := Global.GetZQueryFromName('PUB_PRICEGRADE');
  edtSETTLE_CODE.DataSet := Global.GetZQueryFromName('PUB_SETTLE_CODE');

  AddCbxPickList(edtBANK_ID,'',Global.GetZQueryFromName('PUB_BANK_INFO'));
end;

procedure TfrmClientInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmClientInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClientInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  {RzLabel2.Visible:=true;
  RzLabel4.Visible:=true;
  RzLabel13.Visible:=true;
  RzLabel14.Visible:=true;}
  Btn_Save.Visible := (value<>dsBrowse);
  case Value of
  dsInsert:Caption := '客户档案--(新增)';
  dsEdit:Caption := '客户档案--(修改)';
  else
      begin
        Caption := '客户档案';
        {RzLabel2.Visible:=False;
        RzLabel4.Visible:=False;
        RzLabel13.Visible:=False;
        RzLabel14.Visible:=False;}
      end;
  end;
end;

procedure TfrmClientInfo.FormShow(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := TabSheet1.TabIndex;
  if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
end;

procedure TfrmClientInfo.Btn_SaveClick(Sender: TObject);
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
    if MessageBox(Handle,'是否继续新增客户?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
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

procedure TfrmClientInfo.edtCLIENT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  if dbState<>dsBrowse then
  edtCLIENT_SPELL.Text := fnString.GetWordSpell(edtCLIENT_NAME.Text,3);
end;

function TfrmClientInfo.IsEdit(Aobj: TRecord_;
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
  result := result or TZQuery(cdsTable).Changed;
end;

class function TfrmClientInfo.AddDialog(Owner: TForm;
  var AObj1: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('你没有新增客户的权限,请和管理员联系.');
   with TfrmClientInfo.Create(Owner) do
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

procedure TfrmClientInfo.edtSORT_IDAddClick(Sender: TObject);
var Aobj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  try
    if TfrmCodeInfo.AddDialog(Self,Aobj,5) then
       begin
         edtSORT_ID.KeyValue := AObj.FieldbyName('CODE_ID').asString;
         edtSORT_ID.Text := AObj.FieldbyName('CODE_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmClientInfo.FormCloseQuery(Sender: TObject;
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
    i:=MessageBox(Handle,'客户档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmClientInfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
  //Aobj.FieldByName('COMP_ID').AsString:=ccid;
  Aobj.FieldByName('SORT_ID').AsString:=edtSORT_ID.AsString;
  Aobj.FieldByName('REGION_ID').AsString:=edtREGION_ID.AsString;
  Aobj.FieldByName('SHOP_ID').AsString:=edtSHOP_ID.AsString;
  Aobj.FieldByName('PRICE_ID').AsString := edtPRICE_ID.AsString;
  if Trim(edtINTEGRAL.Text)='' then AObj.FieldByName('INTEGRAL').AsString:='0';
  if Trim(edtACCU_INTEGRAL.Text)='' then AObj.FieldByName('ACCU_INTEGRAL').AsString:='0';
  if Trim(edtRULE_INTEGRAL.Text)='' then AObj.FieldByName('RULE_INTEGRAL').AsString:='0';
  if Trim(edtBALANCE.Text)='' then AObj.FieldByName('BALANCE').AsString := '0';
end;

class function TfrmClientInfo.EditDialog(Owner: TForm; id: string;
  var AObj1: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33300001',3) then Raise Exception.Create('你没有修改客户的权限,请和管理员联系.');
   with TfrmClientInfo.Create(Owner) do
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

procedure TfrmClientInfo.edtCLIENT_TYPEPropertiesChange(Sender: TObject);
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

procedure TfrmClientInfo.edtREGION_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
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


procedure TfrmClientInfo.edtPRICE_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  try
    if TfrmPriceGradeInfo.AddDialog(self,AObj) then
       begin
         edtPRICE_ID.KeyValue := AObj.FieldbyName('PRICE_ID').asString;
         edtPRICE_ID.Text := AObj.FieldbyName('PRICE_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmClientInfo.edtSETTLE_CODEAddClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
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
