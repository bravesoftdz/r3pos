unit ufrmlocationinfo;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, ZBase, DB, cxMemo,
  ZAbstractDataset, ZDataset, RzButton, cxMaskEdit, cxButtonEdit, zrComboBoxList,
  RzCmboBx, Mask, RzEdit, cxDropDownEdit,cxCalendar,ZAbstractRODataset,
  RzLabel;

type
  Tfrmlocationinfo = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    edtLOCATION_NAME: TcxTextEdit;
    edtLOCATION_SPELL: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    cdsTable: TZQuery;
    edtREMARK: TcxMemo;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtLOCATION_NAMEPropertiesChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);


  private
    { Private declarations }
    FIsRelation: Boolean;
    procedure SetIsRelation(const Value: Boolean);
    procedure SetdbState(const Value: TDataSetState); override;
  public
    { Public declarations }
    AObj:TRecord_;
    Saved:boolean;
    procedure Open(code:string);
    procedure Append;
    procedure Save;
    property IsRelation:Boolean read FIsRelation write SetIsRelation;
    procedure WriteTo(AObj:TRecord_);
    procedure Edit(code:string);
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;
  end;


implementation
uses uShopUtil,uDsUtil,uFnUtil,uGlobal,uXDictFactory, uShopGlobal,ufrmCodeInfo,EncDec,
  ufrmBasic;
{$R *.dfm}



{ Tfrmlocationinfo }

procedure Tfrmlocationinfo.Append;
begin
  Open('');
  dbState := dsInsert;
  AObj.FieldByName('TENANT_ID').AsInteger:= Global.TENANT_ID;
  AObj.FieldByName('LOCATION_ID').AsString:= TSequence.NewId();
  edtSHOP_ID.KeyValue := Global.SHOP_ID ;
  edtSHOP_ID.Text :=global.SHOP_NAME ;
  if Visible and edtLOCATION_NAME.CanFocus then edtLOCATION_NAME.SetFocus;
end;

procedure Tfrmlocationinfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('LOCATION_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TLocation',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure Tfrmlocationinfo.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');

  AObj := TRecord_.Create;
  //IsRelation := CheckRelation;
  if ShopGlobal.GetProdFlag = 'E' then
    begin
     // Label1.Caption := '仓库代码';
      Label3.Caption := '仓库名称';
    end;
end;
procedure Tfrmlocationinfo.edtLOCATION_NAMEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtLOCATION_SPELL.Text := fnString.GetWordSpell(edtLOCATION_NAME.Text,3);
end;

procedure Tfrmlocationinfo.btnOkClick(Sender: TObject);
var bl:Boolean;
begin
  inherited;
  if trim(edtSHOP_ID.Text)='' then
     begin
       if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
       Raise Exception.Create('门店名不能为空，请正确输入门店名称');
     end;
  bl:=(dbState<>dsEdit);
  Save;
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bl then //继续新增
  begin
    if MessageBox(Handle,'是否继续新增储位?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
       Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure Tfrmlocationinfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
  var Temp:TZQuery;
   begin
    Temp := Global.GetZQueryFromName('PUB_LOCATION_INFO');
    if Temp.Locate('location_name',AObj.FieldbyName('location_name').AsString,[]) then
        begin
        if (Temp.FieldByName('location_id').AsString<>AObj.FieldbyName('location_id').AsString) then
         begin
           if Visible and edtLOCATION_NAME.CanFocus  then edtLOCATION_NAME.SetFocus;
           Raise Exception.Create('此储位名已经存在，不能重名！') ;
         end
        else
         begin
         temp.Edit;
         AObj.WriteToDataSet(Temp);
         Temp.Post;
         end;
        end
     else
         begin
         temp.Append ;
         AObj.WriteToDataSet(Temp);
         Temp.Post;
         end;
   end;
begin
  if trim(edtSHOP_ID.Text)='' then
  begin
    if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
    raise Exception.Create('门店名称不能为空!');
  end;
  if trim(edtLOCATION_SPELL.Text)='' then
  begin
    if edtLOCATION_SPELL.CanFocus then edtLOCATION_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空!');
  end;

  WriteTo(AObj);
  UpdateToGlobal(AObj);
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then Exit;
  cdsTable.Edit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  Factor.UpdateBatch(cdsTable,'TLocation',nil);
  dbState := dsBrowse;
  Saved := true;
end;

procedure Tfrmlocationinfo.SetdbState(const Value: TDataSetState);
var
  Name_S:String;
begin
  inherited;
  if ShopGlobal.GetProdFlag = 'E' then
    Name_S := '仓库'
  else
    Name_S := '门店';
  btnOk.Visible := (Value<>dsBrowse);
  case Value of
    dsInsert:Caption := Name_S+'档案--(新增)';
    dsEdit:Caption := Name_S+'档案--(修改)';
  else
    Caption := Name_S+'档案';
  end;
end;


procedure Tfrmlocationinfo.SetIsRelation(const Value: Boolean);
begin
  FIsRelation := Value;
end;

procedure Tfrmlocationinfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
end;

procedure Tfrmlocationinfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  if Visible and edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
end;


function Tfrmlocationinfo.IsEdit(Aobj: TRecord_;
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

procedure Tfrmlocationinfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

end.
