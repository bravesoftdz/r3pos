unit ufrmPassWord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel, RzButton,
  DB, ZAbstractRODataset, ZAbstractDataset, cxMaskEdit, ZBase,
  cxDropDownEdit, ZDataset;

type
  TfrmPassWord = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzLabel12: TRzLabel;
    edtOLD_PASSWRD: TcxTextEdit;
    edt: TRzLabel;
    edtPASSWRD: TcxTextEdit;
    RzLabel1: TRzLabel;
    edtPASSWRD1: TcxTextEdit;
    cdsTable: TZQuery;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    edtIC_CARDNO: TcxTextEdit;
    edtCLIENT_NAME: TcxTextEdit;
    edtUNION_ID: TcxComboBox;
    RzLabel7: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtUNION_IDPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Card:string;
    FCust_Id: String;
    //procedure EditPassword(IcCard: string);
    procedure SetCust_Id(const Value: String);
  public
    procedure InitControl;
    procedure Open(CUST_ID,UNION_ID:String);
    procedure Save;
    property Cust_Id:String read FCust_Id write SetCust_Id;
    class function SelectCard(Owner:TForm;CUSTID,UNION_ID:string):boolean;
  end;

implementation
uses EncDec,uGlobal,uShopUtil,uDsUtil;
{$R *.dfm}
{ TfrmPassWord }

procedure TfrmPassWord.btnOkClick(Sender: TObject);
begin
  inherited;
  if EncStr(Trim(edtOLD_PASSWRD.Text),ENC_KEY) <> cdsTable.FieldByName('PASSWRD').AsString then
    begin
      if edtOLD_PASSWRD.CanFocus then edtOLD_PASSWRD.SetFocus;
      Raise Exception.Create('旧密码输入错误！');
    end;
  if Trim(edtPASSWRD.Text) = '' then
    begin
      if edtPASSWRD.CanFocus then edtPASSWRD.SetFocus;
      raise Exception.Create('新密码不能为空！');
    end;
  if Trim(edtPASSWRD1.Text) = '' then
    begin
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('密码确认不能为空！');
    end;
  if Trim(edtPASSWRD.Text) <> Trim(edtPASSWRD1.Text) then
    begin
      edtPASSWRD1.Text := '';
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('两次密码输入不一致！');
    end;

  Save;
  ModalResult := mrOk;

end;

procedure TfrmPassWord.FormShow(Sender: TObject);
begin
  inherited;
  //if edtOLD_PASSWORD.CanFocus then edtOLD_PASSWORD.SetFocus;
end;

procedure TfrmPassWord.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmPassWord.InitControl;
var Str_Sql:String;
    rs:TZQuery;
    AObj_:TRecord_;
begin
  Str_Sql :=
  'select UNION_ID,UNION_NAME,1 as CODE_ID from PUB_UNION_INFO where COMM not in (''12'',''02'') '+
  'union all '+
  'select '''+IntToStr(Global.TENANT_ID)+''' as UNION_ID,''企业卡'' as UNION_NAME,0 as CODE_ID from CA_TENANT where TENANT_ID='+IntToStr(Global.TENANT_ID);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := Str_Sql;
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        AObj_ := TRecord_.Create;
        AObj_.ReadFromDataSet(rs);
        edtUNION_ID.Properties.Items.AddObject(rs.FieldByName('UNION_NAME').AsString,AObj_);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmPassWord.Open(CUST_ID, UNION_ID: String);
var Param:TftParamList;
    rs:TZQuery;
begin
  Param := TftParamList.Create;
  rs := TZQuery.Create(nil);
  try
    Param.ParamByName('CLIENT_ID').AsString := CUST_ID;
    if Length(UNION_ID) > 20 then
      Param.ParamByName('UNION_ID').AsString := UNION_ID
    else
      Param.ParamByName('UNION_ID').AsString := '#';
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsTable,'TNewCard',Param);
    //Aobj.ReadFromDataSet(cdsTable);
    //ReadFromObject(Aobj,Self);
    {if cdsTable.IsEmpty then
      begin
        rs.SQL.Text := 'select CUST_NAME,CUST_CODE from PUB_CUSTOMER where CUST_ID='+QuotedStr(CUST_ID)+' and TENANT_ID='+IntToStr(Global.TENANT_ID);
        Factor.Open(rs);
        edtCLIENT_NAME.Text := rs.FieldbyName('CUST_NAME').AsString;
        edtIC_CARDNO.Text := rs.FieldbyName('CUST_CODE').AsString;
        edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
      end
    else
      begin}
    edtCLIENT_NAME.Text := cdsTable.FieldbyName('CLIENT_NAME').AsString;
    edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
    edtIC_CARDNO.Text := cdsTable.FieldbyName('IC_CARDNO').AsString;
      //end;

    edtCLIENT_NAME.Enabled := False;
    edtIC_CARDNO.Enabled := False;
  finally
    Param.Free;
    rs.Free;
  end;
  
end;

procedure TfrmPassWord.Save;
begin
  cdsTable.Edit;
  cdsTable.FieldByName('PASSWRD').AsString := EncStr(Trim(edtPASSWRD.Text),ENC_KEY);
  cdsTable.Post;

  if not Factor.UpdateBatch(cdsTable,'TNewCard') then
    Raise Exception.Create('密码修改失败!');
end;

procedure TfrmPassWord.SetCust_Id(const Value: String);
begin
  FCust_Id := Value;
end;

class function TfrmPassWord.SelectCard(Owner: TForm; CUSTID,
  UNION_ID: string): boolean;
begin
  with TfrmPassWord.Create(Owner) do
    begin
      try
        Cust_Id := CUSTID;
        Open(Cust_Id,UNION_ID);
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

procedure TfrmPassWord.edtUNION_IDPropertiesChange(Sender: TObject);
var UnionId:String;
begin
  inherited;
  UnionId := TRecord_(edtUNION_ID.Properties.Items.Objects[edtUNION_ID.ItemIndex]).FieldbyName('UNION_ID').AsString;
  Open(Cust_Id,UnionId);
end;

procedure TfrmPassWord.FormCreate(Sender: TObject);
begin
  inherited;
  InitControl;
end;

end.
