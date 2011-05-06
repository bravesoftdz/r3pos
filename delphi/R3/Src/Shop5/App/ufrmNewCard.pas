unit ufrmNewCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  DB, cxMemo, ZAbstractRODataset, ZAbstractDataset, ZBase, ZDataset, cxMaskEdit,
  cxDropDownEdit;

type
  TfrmNewCard = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzLabel12: TRzLabel;
    edtIC_CARDNO: TcxTextEdit;
    edt: TRzLabel;
    edtCLIENT_NAME: TcxTextEdit;
    cdsTable: TZQuery;
    RzLabel2: TRzLabel;
    edtUNION_ID: TcxComboBox;
    RzLabel1: TRzLabel;
    edtPASSWRD: TcxTextEdit;
    RzLabel3: TRzLabel;
    edtPASSWRD1: TcxTextEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtUNION_IDPropertiesChange(Sender: TObject);
  private
    cid:string;
    bl:boolean;
    Aobj:TRecord_;
    FCust_Id: String;
    FShowModel: Integer;
    procedure SetCust_Id(const Value: String);
    procedure SetShowModel(const Value: Integer);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState);override;
  public
    procedure InitControl;
    procedure Open(CUST_ID,UNION_ID:String);
    procedure Save;
    property Cust_Id:String read FCust_Id write SetCust_Id;
    property ShowModel:Integer read FShowModel write SetShowModel;
    class function SelectSendCard(Owner:TForm;CUSTID,UNION_ID,CUSTNAME:string;Model:integer):boolean;
    { Public declarations }
  end;

implementation

uses uGlobal,uDsUtil,uFnUtil,IniFiles,uShopUtil,EncDec, uShopGlobal, ufrmBasic;
{$R *.dfm}


procedure TfrmNewCard.btnOkClick(Sender: TObject);
begin
  inherited;
  if Trim(edtIC_CARDNO.Text) = '' then
    begin
      if edtIC_CARDNO.CanFocus then edtIC_CARDNO.SetFocus;
      Raise Exception.Create('会员卡号不能为空！');
    end;
  if Trim(edtPASSWRD.Text) = '' then
    begin
      if edtPASSWRD.CanFocus then edtPASSWRD.SetFocus;
      raise Exception.Create('密码不能为空！');
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

procedure TfrmNewCard.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmNewCard.FormShow(Sender: TObject);
begin
  inherited;
  //if cmbIC_CARDNO.CanFocus  then  cmbIC_CARDNO.SetFocus;
end;

procedure TfrmNewCard.InitControl;
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

procedure TfrmNewCard.Open(CUST_ID,UNION_ID: String);
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
   { if cdsTable.IsEmpty then
      begin
        rs.SQL.Text := 'select A.CUST_NAME,A.CUST_CODE,B.PASSWRD from PUB_CUSTOMER A left join PUB_IC_INFO B on A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID and A.CUST_CODE=B.IC_CARDNO '+
        ' where A.CUST_ID='+QuotedStr(CUST_ID)+' and A.TENANT_ID='+IntToStr(Global.TENANT_ID);
        Factor.Open(rs);
        edtCLIENT_NAME.Text := rs.FieldbyName('CUST_NAME').AsString;
        edtIC_CARDNO.Text := rs.FieldbyName('CUST_CODE').AsString;
        edtPASSWRD.Text := DecStr(rs.FieldbyName('PASSWRD').AsString,ENC_KEY);
        edtPASSWRD1.Text := edtPASSWRD.Text;
        edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
      end
    else
      begin }
        //edtCLIENT_NAME.Text := cdsTable.FieldbyName('CLIENT_NAME').AsString;
        edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
        edtIC_CARDNO.Text := cdsTable.FieldbyName('IC_CARDNO').AsString;
        edtPASSWRD.Text := DecStr(cdsTable.FieldbyName('PASSWRD').AsString,ENC_KEY);
        edtPASSWRD1.Text := edtPASSWRD.Text;
      //end;
    if Trim(edtPASSWRD.Text) = '' then
      begin
        edtPASSWRD.Text := '1234';
        edtPASSWRD1.Text := '1234';
      end;
    edtCLIENT_NAME.Enabled := False;
    if ShowModel = 0 then
      edtUNION_ID.Enabled := False;

    if cdsTable.FieldByName('IC_STATUS').AsInteger = 1 then
      btnOk.Enabled := False
    else
      btnOk.Enabled := True;
  finally
    Param.Free;
    rs.Free;
  end;

end;

procedure TfrmNewCard.SetCust_Id(const Value: String);
begin
  FCust_Id := Value;
end;

class function TfrmNewCard.SelectSendCard(Owner:TForm;CUSTID,UNION_ID,CUSTNAME: string;
  Model:integer): boolean;
begin
  with TfrmNewCard.Create(Owner) do
    begin
      try
        ShowModel := Model;
        Cust_Id := CUSTID;
        edtCLIENT_NAME.Text := CUSTNAME;
        edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
        //Open(Cust_Id,UNION_ID);
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

procedure TfrmNewCard.Save;
var UNIONID:String;
begin
  if cdsTable.Locate('CLIENT_ID',Cust_Id,[]) then
    begin
      cdsTable.Edit;
      cdsTable.FieldByName('IC_CARDNO').AsString := edtIC_CARDNO.Text;
      cdsTable.FieldByName('IC_STATUS').AsString := '1';
      cdsTable.FieldByName('PASSWRD').AsString := EncStr(Trim(edtPASSWRD.Text),ENC_KEY);
      cdsTable.Post;
    end
  else
    begin
      cdsTable.Append;
      cdsTable.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      cdsTable.FieldByName('CLIENT_ID').AsString := Cust_Id;

      UNIONID := TRecord_(edtUNION_ID.Properties.Items.Objects[edtUNION_ID.ItemIndex]).FieldbyName('UNION_ID').AsString;
      if Length(UNIONID) > 20 then
        cdsTable.FieldByName('UNION_ID').AsString := UNIONID
      else
        cdsTable.FieldByName('UNION_ID').AsString := '#';

      cdsTable.FieldByName('IC_CARDNO').AsString := edtIC_CARDNO.Text;
      cdsTable.FieldByName('PASSWRD').AsString := EncStr(Trim(edtPASSWRD.Text),ENC_KEY);
      cdsTable.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
      cdsTable.FieldByName('CREA_USER').AsString := Global.UserID;;
      cdsTable.FieldByName('IC_INFO').AsString := edtUNION_ID.Text;
      cdsTable.FieldByName('IC_STATUS').AsString := '1';
      cdsTable.FieldByName('IC_TYPE').AsString := TRecord_(edtUNION_ID.Properties.Items.Objects[edtUNION_ID.ItemIndex]).FieldbyName('CODE_ID').AsString;
      cdsTable.Post;
    end;
  if not Factor.UpdateBatch(cdsTable,'TNewCard') then
    Raise Exception.Create('发卡失败!');
end;

procedure TfrmNewCard.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
  InitControl;
end;

procedure TfrmNewCard.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmNewCard.SetdbState(const Value: TDataSetState);
begin
  inherited;
  {case Value of
    dsInsert:begin
      edtCLIENT_NAME.Properties.ReadOnly := True;
      edtUNION_ID.Properties.ReadOnly := True;
    end;
    dsEdit:begin
      edtCLIENT_NAME.Properties.ReadOnly := True;
    end;
  end;}
end;

procedure TfrmNewCard.SetShowModel(const Value: Integer);
begin
  FShowModel := Value;
end;

procedure TfrmNewCard.edtUNION_IDPropertiesChange(Sender: TObject);
var UnionId:String;
begin
  inherited;
  UnionId := TRecord_(edtUNION_ID.Properties.Items.Objects[edtUNION_ID.ItemIndex]).FieldbyName('UNION_ID').AsString;
  Open(Cust_Id,UnionId);
end;

end.
