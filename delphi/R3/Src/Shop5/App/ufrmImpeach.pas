unit ufrmImpeach;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ExtCtrls, RzPanel, ActnList, Menus, StdCtrls, RzTabs,
  RzBmpBtn, RzBckgnd, cxTextEdit, cxControls, cxContainer, cxEdit, ZBase,
  cxMaskEdit, cxDropDownEdit, RzButton, cxMemo, cxButtonEdit, ObjCommon,
  zrComboBoxList, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmImpeach = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    RzBackground1: TRzBackground;
    Image1: TImage;
    RzPanel7: TRzPanel;
    btn_Save: TRzBmpButton;
    RzPage: TRzPageControl;
    TabImpeach: TRzTabSheet;
    RzPanel2: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    edtIMPEACH_CLASS: TcxComboBox;
    edtIMPH_TENANT_ID: TzrComboBoxList;
    edtIMPEACH_USER: TcxTextEdit;
    edtIS_REPEAT: TcxComboBox;
    edtIS_URGENCY: TcxComboBox;
    edtCONTENT: TcxMemo;
    Label5: TLabel;
    Label8: TLabel;
    cdsImpeach: TZQuery;
    cdsTENANT: TZQuery;
    Label9: TLabel;
    btn_Close: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIMPEACH_CLASSPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
  private
    { Private declarations }
    AObj:TRecord_;
  public
    { Public declarations }
    procedure Save;
    procedure InitParams;
    procedure WriteToData;
    procedure Append;
    procedure Open;
    class function ShowImpeach(Owner:TForm):Boolean;
  end;

implementation
uses uShopUtil,uDsUtil,uFnUtil,uGlobal,uShopGlobal;
{$R *.dfm}

procedure TfrmImpeach.InitParams;
var Temp:TZQuery;
    Aobj_1:TRecord_;
begin
  Temp := Global.GetZQueryFromName('PUB_PARAMS');
  Aobj_1 := TRecord_.Create;
  Aobj_1.ReadField(Temp);
  Aobj_1.FieldByName('CODE_ID').AsString := '0';
  Aobj_1.FieldByName('CODE_NAME').AsString := '一般';
  edtIS_URGENCY.Properties.Items.AddObject(Aobj_1.FieldByName('CODE_NAME').AsString,Aobj_1);

  Aobj_1 := TRecord_.Create;
  Aobj_1.ReadField(Temp);
  Aobj_1.FieldByName('CODE_ID').AsString := '1';
  Aobj_1.FieldByName('CODE_NAME').AsString := '紧急';
  edtIS_URGENCY.Properties.Items.AddObject(Aobj_1.FieldByName('CODE_NAME').AsString,Aobj_1);

  Aobj_1 := TRecord_.Create;
  Aobj_1.ReadField(Temp);
  Aobj_1.FieldByName('CODE_ID').AsString := '0';
  Aobj_1.FieldByName('CODE_NAME').AsString := '否';
  edtIS_REPEAT.Properties.Items.AddObject(Aobj_1.FieldByName('CODE_NAME').AsString,Aobj_1);

  Aobj_1 := TRecord_.Create;
  Aobj_1.ReadField(Temp);
  Aobj_1.FieldByName('CODE_ID').AsString := '1';
  Aobj_1.FieldByName('CODE_NAME').AsString := '是';
  edtIS_REPEAT.Properties.Items.AddObject(Aobj_1.FieldByName('CODE_NAME').AsString,Aobj_1);


  cdsTENANT.Close;
  cdsTENANT.SQL.Text := 'select CLIENT_CODE,CLIENT_NAME from VIW_CLIENTINFO where FLAG in (1,3)';
  Factor.Open(cdsTENANT);
  edtIMPH_TENANT_ID.DataSet := cdsTENANT;

end;

procedure TfrmImpeach.Open;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('ROWS_ID').asString := '';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsImpeach.Close;
    Factor.Open(cdsImpeach,'TImpeach',Params);
    AObj.ReadFromDataSet(cdsImpeach);
  finally
    Params.Free;
  end;
end;

procedure TfrmImpeach.Save;
var Name:String;
begin
  if Label4.Tag = 1 then
    Name := '建议'
  else
    Name := '投诉';
  if trim(edtIMPH_TENANT_ID.Text)='' then
  begin
    if edtIMPH_TENANT_ID.CanFocus then edtIMPH_TENANT_ID.SetFocus;
    raise Exception.Create('被'+Name+'企业不能为空！');
  end;
  if trim(edtIMPEACH_USER.Text)='' then
  begin
    if edtIMPEACH_USER.CanFocus then edtIMPEACH_USER.SetFocus;
    raise Exception.Create(Name+'对象不能为空！');
  end;
  if trim(edtCONTENT.Text)='' then
  begin
    if edtCONTENT.CanFocus then edtCONTENT.SetFocus;
    raise Exception.Create(Name+'内容不能为空！');
  end;

  WriteToData;
  try
    Factor.UpdateBatch(cdsImpeach,'TImpeach',nil);
  Except
    Raise;
  end;
end;

procedure TfrmImpeach.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i := 0 to RzPage.PageCount - 1 do
    RzPage.Pages[i].TabVisible := False;
  Initform(Self);
  InitParams;
  AObj := TRecord_.Create;
end;

procedure TfrmImpeach.WriteToData;
begin

  AObj.FieldByName('ROWS_ID').AsString := TSequence.NewId;
  AObj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldByName('SHOP_ID').AsString := Global.SHOP_ID;
  AObj.FieldByName('IMPH_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',Date()));
  AObj.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD HH:MM:SS',Now);
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('IMPEACH_FEEDBACK_STATUS').AsString := '1';
  AObj.FieldByName('IMPEACH_PROC_STATUS').AsString := '1';
  AObj.FieldByName('IS_REPLY').AsString := '0';

  WriteToObject(AObj,Self);
  
  cdsImpeach.Append;
  AObj.WriteToDataSet(cdsImpeach);
  cdsImpeach.Post;

end;

class function TfrmImpeach.ShowImpeach(Owner: TForm): Boolean;
begin
  with TfrmImpeach.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmImpeach.FormShow(Sender: TObject);
begin
  inherited;
  edtIMPEACH_CLASS.ItemIndex := 0;
  Append;
end;

procedure TfrmImpeach.edtIMPEACH_CLASSPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtIMPEACH_CLASS.ItemIndex = 1 then
    begin
      Label4.Tag := 1;
      Label4.Caption := '建议内容：';
      Label6.Caption := '建议到：';
      Label7.Caption := '建议对象：';
    end
  else
    begin
      Label4.Tag := 0;
      Label4.Caption := '投诉内容：';
      Label6.Caption := '投诉到：';
      Label7.Caption := '投诉对象：';
    end;
end;

procedure TfrmImpeach.Append;
begin
  Open;
  edtIS_REPEAT.ItemIndex := 0;
  edtIS_URGENCY.ItemIndex := 0;
end;

procedure TfrmImpeach.FormDestroy(Sender: TObject);
begin
  inherited;
  Freeform(Self);
  AObj.Free;
end;

procedure TfrmImpeach.btn_SaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmImpeach.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
