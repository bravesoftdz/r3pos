unit ufrmMessageInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, zBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxMemo, cxMaskEdit,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  cxButtonEdit, zrComboBoxList, cxCalendar, RzButton;

type
  TfrmMessageInfo = class(TframeDialogForm)
    cdsMessage: TZQuery;
    Label9: TLabel;
    Label1: TLabel;
    Label26: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    edtMSG_TITLE: TcxTextEdit;
    edtMSG_CLASS: TcxComboBox;
    edtMSG_CONTENT: TcxMemo;
    Label2: TLabel;
    Label3: TLabel;
    edtISSUE_DATE: TcxDateEdit;
    edtMSG_SOURCE: TcxTextEdit;
    Label4: TLabel;
    edtISSUE_USER_TEXT: TcxTextEdit;
    Label6: TLabel;
    edtEND_DATE: TcxDateEdit;
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Aobj:TRecord_;
    Saved:Boolean;
    FMSG_CLASS_TYPE: integer;
    procedure SetMSG_CLASS_TYPE(const Value: integer);
  public
    { Public declarations }
    procedure Init;
    procedure Open(ID:String);
    procedure Edit(ID:String);
    procedure Save;
    procedure Append;
    procedure SetDBState(const Value:TDataSetState);override;
    function IsEdit(_Aobj:TRecord_;Data:TZQuery):Boolean;
    property MSG_CLASS_TYPE: integer read FMSG_CLASS_TYPE write SetMSG_CLASS_TYPE;
    class function ShowDailog(Owner:TForm;ID:String):Boolean;
    class function EditDailog(Owner:TForm;ID:String;_Aobj:TRecord_):Boolean;
    class function AddDailog(Owner:TForm;_Aobj:TRecord_):Boolean;
  end;

implementation

uses ufrmBasic, uShopUtil, uShopGlobal, uGlobal, uDsUtil;
{$R *.dfm}

{ TfrmMessageInfo }

class function TfrmMessageInfo.AddDailog(Owner: TForm;
  _Aobj: TRecord_): Boolean;
begin
  with TfrmMessageInfo.Create(Owner) do
    begin
      try
        MSG_CLASS_TYPE := 0;
        Append;
        if ShowModal = mrOk then
          begin
            Aobj.CopyTo(_Aobj);
            Result := True;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;
end;

procedure TfrmMessageInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  edtMSG_CLASS.ItemIndex := MSG_CLASS_TYPE;
  edtISSUE_DATE.Date := Global.SysDate;
  edtEND_DATE.Date := Global.SysDate;
  edtMSG_SOURCE.Text := Global.SHOP_NAME;
  edtISSUE_USER_TEXT.Text := Global.UserName;

end;

procedure TfrmMessageInfo.Edit(ID: String);
begin
  Open(ID);
  dbState := dsEdit;
end;

class function TfrmMessageInfo.EditDailog(Owner: TForm; ID: String;
  _Aobj: TRecord_): Boolean;
begin
  with TfrmMessageInfo.Create(Owner) do
    begin
      try
        Edit(ID);
        if ShowModal = mrOk then
          begin
            Aobj.CopyTo(_Aobj);
            Result := True;
          end
        else
          Result := False;
      finally
        Free;
      end;
    end;
end;

procedure TfrmMessageInfo.Init;
var rs:TZQuery;
    Aobj1:TRecord_;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := ' select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''MSG_CLASS'' and COMM not in (''12'',''02'') ';
    Factor.Open(rs);
    if not rs.IsEmpty then ClearCbxPickList(edtMSG_CLASS);
    rs.First;
    while not rs.Eof do
      begin
        Aobj1 := TRecord_.Create;
        Aobj1.ReadFromDataSet(rs);
        edtMSG_CLASS.Properties.Items.AddObject(rs.FieldbyName('CODE_NAME').AsString,Aobj1);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TfrmMessageInfo.IsEdit(_Aobj: TRecord_; Data: TZQuery): Boolean;
var i:Integer;
begin
  Result := False;
  for i := 0 to Data.FieldCount - 1 do
    begin
      if _Aobj.Fields[i].AsString <> Data.Fields[i].AsString then
        begin
          Result := True;
          Break;
        end;
    end;
end;

procedure TfrmMessageInfo.Open(ID: String);
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('MSG_ID').AsString := ID;
    Factor.Open(cdsMessage,'TMessage',Params);
    Aobj.ReadFromDataSet(cdsMessage);
    ReadFromObject(Aobj,Self);
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmMessageInfo.Save;
begin
  if dbState=dsBrowse then exit;
  if trim(edtMSG_CLASS.Text)='' then
  begin
    if edtMSG_CLASS.CanFocus then edtMSG_CLASS.SetFocus;
    raise Exception.Create('信息类型不能为空！');
  end;
  if trim(edtMSG_TITLE.Text)='' then
  begin
    if edtMSG_TITLE.CanFocus then edtMSG_TITLE.SetFocus;
    raise Exception.Create('信息标题不能为空！');
  end;
  if trim(edtMSG_CONTENT.Text)='' then
  begin
    if edtMSG_CONTENT.CanFocus then edtMSG_CONTENT.SetFocus;
    raise Exception.Create('信息内容不能为空！');
  end;
  if edtEND_DATE.Text < edtISSUE_DATE.Text then
  begin
    raise Exception.Create('有效期限不能小于发布日期！');
  end;
  if Length(edtMSG_CONTENT.Text) > 500 then
  begin
    raise Exception.Create('信息内容超出预计长度,请相对精减！');
  end;

  if dbState = dsInsert then
  begin
    AObj.FieldbyName('MSG_ID').AsString := TSequence.NewId;
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    AObj.FieldbyName('ISSUE_USER').AsString := Global.UserID;
    AObj.FieldbyName('ISSUE_TENANT_ID').AsInteger := Global.TENANT_ID;
    //AObj.FieldbyName('MSG_SOURCE').AsString := Global.SHOP_NAME;
  end;
  WriteToObject(Aobj,self);
  MSG_CLASS_TYPE := edtMSG_CLASS.ItemIndex;
  cdsMessage.Edit;
  Aobj.WriteToDataSet(cdsMessage);
  cdsMessage.Post;
  Factor.UpdateBatch(cdsMessage,'TMessage',nil);
  dbState := dsBrowse;
  Saved := True;
end;

procedure TfrmMessageInfo.SetDBState(const Value: TDataSetState);
begin
  inherited;
  if dbState = dsBrowse then
    Btn_Save.Visible := False
  else
    Btn_Save.Visible := True;

end;

class function TfrmMessageInfo.ShowDailog(Owner: TForm;
  ID: String): Boolean;
begin
  with TfrmMessageInfo.Create(Owner) do
    begin
      try
        Open(ID);
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmMessageInfo.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
  Init;
end;

procedure TfrmMessageInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmMessageInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMessageInfo.Btn_SaveClick(Sender: TObject);
var bl:boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增发布信息?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;

end;

procedure TfrmMessageInfo.SetMSG_CLASS_TYPE(const Value: integer);
begin
  FMSG_CLASS_TYPE := Value;
end;

procedure TfrmMessageInfo.FormShow(Sender: TObject);
begin
  inherited;
  edtMSG_TITLE.SetFocus;
end;

end.
