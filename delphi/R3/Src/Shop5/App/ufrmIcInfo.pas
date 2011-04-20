unit ufrmIcInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  StdCtrls, RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmIcInfo = class(TframeDialogForm)
    Label1: TLabel;
    Label2: TLabel;
    cmbUNION_ID: TcxComboBox;
    edtIC_CARDNO: TcxTextEdit;
    Label4: TLabel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    labCUST_NAME: TLabel;
    cdsCard: TZQuery;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFormName: Integer;
    FCID: String;
    procedure SetFormName(const Value: Integer);
    procedure SetCID(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    procedure InitUnion;
    procedure GetCustomerInfo;
    procedure SaveCard;
    property FormName:Integer read FFormName write SetFormName;
    property CID:String read FCID write SetCID;
    class function SendCardDialog(Ower:TForm;Client_Id:String):String;
    class function MendCardDialog(Ower:TForm;Client_Id:String):Boolean;
  end;

implementation

uses ufrmBasic,zBase,uGlobal,uShopGlobal;

{$R *.dfm}

{ TfrmIcInfo }

procedure TfrmIcInfo.GetCustomerInfo;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
    'select a.UNION_ID,a.IC_CARDNO,b.CLIENT_NAME from PUB_IC_INFO a left join VIW_CUSTOMER b on a.CLIENT_ID=b.CLIENT_ID '+
    'and a.TENANT_ID=b.TENANT_ID where b.CLIENT_ID='+QuotedStr(CID);
    Factor.Open(rs);
    labCUST_NAME.Caption := rs.FieldByName('CLIENT_NAME').AsString;
    edtIC_CARDNO.Text := rs.FieldByName('IC_CARDNO').AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmIcInfo.InitUnion;
var rs:TZQuery;
    Aobj:TRecord_;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
    'select  '''+CID+''' as CLIENT_ID,''企业会员'' as UNION_NAME from CA_TENANT where TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+
    'union all '+
    'select '''+CID+''' as CLIENT_ID,PRICE_NAME as UNION_NAME from PUB_PRICEGRADE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and PRICE_TYPE=''2'' ';

    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        Aobj := TRecord_.Create;
        Aobj.ReadFromDataSet(rs);
        cmbUNION_ID.Properties.Items.AddObject(rs.FieldByName('UNION_NAME').AsString,Aobj);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmIcInfo.SetFormName(const Value: Integer);
begin
  FFormName := Value;
  case value of
    1:begin
      btnOk.Tag := 1;
      btnOk.Caption := '发卡(&S)';
      Self.Caption := '发卡';
    end;
    2:begin
      btnOk.Tag := 2;
      btnOk.Caption := '补卡(&S)';
      Self.Caption := '补卡';
    end;
  end;
end;

class function TfrmIcInfo.SendCardDialog(Ower: TForm;Client_Id:String): String;
begin
  with TfrmIcInfo.Create(Ower) do
    begin
      try
        FormName := 1;
        CID := Client_Id;
        if ShowModal = mrOk then
          Result := edtIC_CARDNO.Text;
      finally
        Free;
      end;
    end;
end;

class function TfrmIcInfo.MendCardDialog(Ower: TForm;Client_Id:String): Boolean;
begin
  with TfrmIcInfo.Create(Ower) do
    begin
      try
        FormName := 2;
        CID := Client_Id;
        if ShowModal = mrOk then
          Result := True;
      finally
        Free;
      end;
    end;
end;

procedure TfrmIcInfo.btnOkClick(Sender: TObject);
begin
  inherited;
  case btnOk.Tag of
    1:ModalResult := mrOk;
    2:SaveCard;
  end;
end;

procedure TfrmIcInfo.SaveCard;
begin

end;

procedure TfrmIcInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmIcInfo.SetCID(const Value: String);
begin
  FCID := Value;
end;

procedure TfrmIcInfo.FormShow(Sender: TObject);
begin
  inherited;
  GetCustomerInfo;
end;

procedure TfrmIcInfo.FormCreate(Sender: TObject);
begin
  inherited;
  InitUnion;
end;

end.
