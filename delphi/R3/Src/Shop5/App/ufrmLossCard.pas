unit ufrmLossCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel, RzButton,
  DB, ZBase, cxMemo, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxMaskEdit, cxDropDownEdit;

type
  TfrmLossCard = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzLabel1: TRzLabel;
    edtCREA_DATE: TcxTextEdit;
    RzLabel2: TRzLabel;
    edtBALANCE: TcxTextEdit;
    RzLabel3: TRzLabel;
    edtIC_INFO: TcxMemo;
    cdsTable: TZQuery;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    edtIC_CARDNO: TcxTextEdit;
    edtCLIENT_NAME: TcxTextEdit;
    edtUNION_ID: TcxComboBox;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtIC_INFOKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtUNION_IDPropertiesChange(Sender: TObject);
  private
    FCust_Id: String;
    procedure SetCust_Id(const Value: String);
    { Private declarations }
  public
    procedure InitControl;
    procedure Open(CUST_ID,UNION_ID:String);
    property Cust_Id:String read FCust_Id write SetCust_Id;
    class function SelectCard(Owner:TForm;CUSTID,UNION_ID:string;var C_N0,C_Name:String):boolean;
    { Public declarations }
  end;

implementation

uses uGlobal, ufrmBasic, uDsUtil;

{$R *.dfm}

procedure TfrmLossCard.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmLossCard.FormShow(Sender: TObject);
begin
  inherited;
  //if edtIC_INFO.CanFocus then edtIC_INFO.SetFocus;
end;

procedure TfrmLossCard.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  cdsTable.Edit;
  cdsTable.FieldByName('IC_STATUS').AsString := '2';
  cdsTable.Post;
  Factor.UpdateBatch(cdsTable,'TNewCard');
  ModalResult:=MROK;
end;

procedure TfrmLossCard.edtIC_INFOKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then  Btn_Save.SetFocus;
end;

procedure TfrmLossCard.InitControl;
var Str_Sql:String;
    rs:TZQuery;
    AObj_:TRecord_;
begin
  Str_Sql :=
  'select UNION_ID,UNION_NAME,1 as CODE_ID from PUB_UNION_INFO where COMM not in (''12'',''02'') '+
  'union all '+
  'select ''#'' as UNION_ID,''ÆóÒµ¿¨'' as UNION_NAME,0 as CODE_ID from CA_TENANT where TENANT_ID='+IntToStr(Global.TENANT_ID);
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

procedure TfrmLossCard.Open(CUST_ID, UNION_ID: String);
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

    edtCLIENT_NAME.Text := cdsTable.FieldbyName('CLIENT_NAME').AsString;
    edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
    edtIC_CARDNO.Text := cdsTable.FieldbyName('IC_CARDNO').AsString;
    edtCREA_DATE.Text := cdsTable.FieldbyName('CREA_DATE').AsString;
    edtBALANCE.Text := cdsTable.FieldbyName('BALANCE').AsString;
    edtIC_INFO.Text := cdsTable.FieldbyName('IC_INFO').AsString;

    edtCLIENT_NAME.Enabled := False;
    edtIC_CARDNO.Enabled := False;
    if (cdsTable.FieldByName('IC_STATUS').AsInteger in [0,1]) and (cdsTable.FieldByName('IC_CARDNO').AsString <> '') then
      Btn_Save.Enabled := True
    else
      Btn_Save.Enabled := False;
  finally
    Param.Free;
    rs.Free;
  end;
end;

procedure TfrmLossCard.SetCust_Id(const Value: String);
begin
  FCust_Id := Value;
end;

procedure TfrmLossCard.FormCreate(Sender: TObject);
begin
  inherited;
  InitControl;
end;

class function TfrmLossCard.SelectCard(Owner: TForm; CUSTID,
  UNION_ID: string;var C_N0,C_Name:String): boolean;
begin
  with TfrmLossCard.Create(Owner) do
    begin
      try
        Cust_Id := CUSTID;
        edtUNION_ID.ItemIndex := TdsItems.FindItems(edtUNION_ID.Properties.Items,'UNION_ID',UNION_ID);
        //Open(CUSTID,UNION_ID);
        Result := ShowModal = mrOk;
        if Result then
          begin
            C_N0 := Trim(edtIC_CARDNO.Text);
            C_Name := Trim(edtUNION_ID.Text);
          end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmLossCard.edtUNION_IDPropertiesChange(Sender: TObject);
var UnionId:String;
begin
  inherited;
  UnionId := TRecord_(edtUNION_ID.Properties.Items.Objects[edtUNION_ID.ItemIndex]).FieldbyName('UNION_ID').AsString;
  Open(Cust_Id,UnionId);
end;

end.
