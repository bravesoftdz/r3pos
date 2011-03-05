unit ufrmShopInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, ZBase, DB, cxMemo,
  ZAbstractDataset, ZDataset, RzButton, cxMaskEdit, cxButtonEdit, zrComboBoxList,
  RzCmboBx, Mask, RzEdit, cxDropDownEdit,cxCalendar,ZAbstractRODataset;

type
  TfrmShopInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label18: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label16: TLabel;
    edtFAXES: TcxTextEdit;
    Label17: TLabel;
    edtTELEPHONE: TcxTextEdit;
    Label22: TLabel;
    edtADDRESS: TcxTextEdit;
    Label26: TLabel;
    edtREMARK: TcxMemo;
    Label20: TLabel;
    edtPOSTALCODE: TcxTextEdit;
    RzPanel1: TRzPanel;
    Label1: TLabel;
    edtSHOP_ID: TcxTextEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtSHOP_NAME: TcxTextEdit;
    Label5: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    edtSHOP_SPELL: TcxTextEdit;
    Label25: TLabel;
    edtREGION_ID: TzrComboBoxList;
    cdsTable: TZQuery;
    edtLICENSE_CODE: TcxTextEdit;
    Label2: TLabel;
    Label9: TLabel;
    edtSHOP_TYPE: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtSHOP_NAMEPropertiesChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtSHOP_TYPEAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AObj:TRecord_;
    Saved:boolean;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure WriteTo(AObj:TRecord_);
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:string):boolean;
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断门店资料是否有修改
  end;
implementation
uses uShopUtil,uDsUtil,uFnUtil,uGlobal,uXDictFactory, uShopGlobal,ufrmShopMain,ufrmCodeInfo,
  ufrmBasic;
{$R *.dfm}

{ TfrmCompanyInfo }

procedure TfrmShopInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtSHOP_ID.Text := TSequence.GetMaxID(inttostr(Global.TENANT_ID),Factor,'SHOP_ID','CA_SHOP_INFO','0000','TENANT_ID='+inttostr(Global.TENANT_ID));
  AObj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  edtREGION_ID.KeyValue:='#';
  edtREGION_ID.Text:='无区域';
  edtSHOP_TYPE.KeyValue := '#';
  edtSHOP_TYPE.Text := '无';
  if Visible and edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

procedure TfrmShopInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  if Visible and edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

procedure TfrmShopInfo.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_TYPE.DataSet:=Global.GetZQueryFromName('PUB_SHOP_TYPE');
  edtREGION_ID.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
  AObj := TRecord_.Create;
end;

procedure TfrmShopInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmShopInfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('SHOP_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TShop',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    
    if Aobj.FieldByName('REGION_ID').AsString = '#' then
      begin
        edtREGION_ID.Text:='无区域';
        edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
      end
    else
      begin
        edtREGION_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_REGION_INFO'),'CODE_ID','CODE_NAME',Aobj.FieldByName('REGION_ID').AsString);
        edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
      end;
    if Aobj.FieldByName('SHOP_TYPE').AsString = '#' then
      begin
        edtSHOP_TYPE.Text:='无';
        edtSHOP_TYPE.KeyValue := Aobj.FieldByName('SHOP_TYPE').AsString;
      end
    else
      begin
        edtSHOP_TYPE.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_SHOP_TYPE'),'SORT_ID','SORT_NAME',Aobj.FieldByName('SHOP_TYPE').AsString);
        edtSHOP_TYPE.KeyValue := Aobj.FieldByName('SHOP_TYPE').AsString;
      end;

    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmShopInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
  var Temp:TZQuery;
   begin
    Temp := Global.GetZQueryFromName('CA_SHOP_INFO');
    if Temp.Locate('SHOP_ID',AObj.FieldbyName('SHOP_ID').AsString,[]) then
      Temp.Edit
    else
      Temp.Append;
    AObj.WriteToDataSet(Temp);
    Temp.Post;
   end;
var tmp:TZQuery;
    i,j:integer;
begin
  if trim(edtSHOP_NAME.Text)='' then
  begin
    if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
    raise Exception.Create('门店名称不能为空!');
  end;
  if trim(edtSHOP_SPELL.Text)='' then
  begin
    if edtSHOP_SPELL.CanFocus then edtSHOP_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空!');
  end;
  if trim(edtSHOP_TYPE.Text)='' then
  begin
    if edtSHOP_TYPE.CanFocus then edtSHOP_TYPE.SetFocus;
    raise Exception.Create('管理群组不能为空!');
  end;
  if trim(edtLICENSE_CODE.Text)='' then
  begin
    if edtLICENSE_CODE.CanFocus then edtLICENSE_CODE.SetFocus;
    raise Exception.Create('经营许可证不能为空!');
  end;

  try
    tmp := TZQuery.Create(nil);
    tmp.SQL.Text := 'select SHOP_ID,SHOP_NAME,SHOP_SPELL,SEQ_NO from CA_SHOP_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+
    ' and COMM not in (''02'',''12'') ';
    Factor.Open(tmp);
    if dbState=dsInsert then
    begin
        if tmp.Locate('SHOP_NAME',trim(edtSHOP_NAME.Text),[]) then
        begin
          if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
          raise  Exception.Create('门店名称已经存在，不能重复！');
        end;
    end;
    if dbState=dsEdit then
      begin
        if tmp.Locate('SHOP_NAME',AObj.FieldByName('SHOP_NAME').AsString,[]) then
            if tmp.FieldByName('SHOP_ID').AsString <> AObj.FieldByName('SHOP_ID').AsString then
              Raise  Exception.Create('门店名称已经存在,不能重复!');
      end;
  finally
    tmp.Free;
  end;
  WriteTo(AObj);
  if Trim(edtREGION_ID.Text) = '' then
    AObj.FieldByName('REGION_ID').AsString := '#'; 
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then Exit;
  cdsTable.Edit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;

  if Factor.UpdateBatch(cdsTable,'TSHOP',nil) then
  begin
     UpdateToGlobal(Aobj);
  end;
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmShopInfo.btnOkClick(Sender: TObject);
var bl:Boolean;
begin
  inherited;
  if trim(edtSHOP_NAME.Text)='初始登录' then
     begin
       if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
       Raise Exception.Create('请正确输入门店名称');
     end;
  bl:=(dbState<>dsEdit);
  Save;
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bl then //继续新增
  begin
    if MessageBox(Handle,'是否继续新增门店?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
       Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmShopInfo.edtSHOP_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtSHOP_SPELL.Text := fnString.GetWordSpell(edtSHOP_NAME.Text,3);
end;

procedure TfrmShopInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible := (Value<>dsBrowse);
  case Value of
    dsInsert:Caption := '门店档案--(新增)';
    dsEdit:Caption := '门店档案--(修改)';
  else
    Caption := '门店档案';
  end;
end;

class function TfrmShopInfo.AddDialog(Owner: TForm;var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100004') then Raise Exception.Create('你没有新增门店的权限,请和管理员联系.');
   with TfrmShopInfo.Create(Owner) do
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

procedure TfrmShopInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmShopInfo.IsEdit(Aobj: TRecord_;
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

class function TfrmShopInfo.EditDialog(Owner:TForm;id:string;var _AObj:TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100005') then Raise Exception.Create('你没有修改门店的权限,请和管理员联系.');
   with TfrmShopInfo.Create(Owner) do
    begin
      try
        Edit(id);
        if ShowModal=MROK then
          result :=True
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtSHOP_NAME.Text)='')) then
   begin
      WriteTo(AObj);
      if not IsEdit(Aobj,cdsTable) then Exit;
      i:=MessageBox(Handle,'门店档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmShopInfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
  Aobj.FieldByName('SHOP_ID').AsString:=edtSHOP_ID.Text;
  Aobj.FieldByName('SEQ_NO').AsInteger:=StrToInt(copy(AObj.FieldByName('SHOP_ID').AsString,8,4));
end;

procedure TfrmShopInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

class function TfrmShopInfo.ShowDialog(Owner: TForm;
  id: string): boolean;
begin
   with TfrmShopInfo.Create(Owner) do
    begin
      try
        Open(id);
        if ShowModal=MROK then
          result :=True
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfo.edtSHOP_TYPEAddClick(Sender: TObject);
var Aobj_:TRecord_;
begin
  inherited;
  Try
    Aobj_ := TRecord_.Create;
    if TfrmCodeInfo.AddDialog(Self,Aobj_,12) then
      begin
        edtSHOP_TYPE.KeyValue := Aobj_.FieldbyName('CODE_ID').AsString;
        edtSHOP_TYPE.Text := Aobj_.FieldbyName('CODE_NAME').AsString;
      end;
  finally
    Aobj_.Free;
  end;
end;

end.
