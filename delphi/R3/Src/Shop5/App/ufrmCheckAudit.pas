unit ufrmCheckAudit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, RzLabel, RzButton, zDataSet,
  cxRadioGroup;

type
  TfrmCheckAudit = class(TfrmBasic)
    RzBitBtn5: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    rdb1: TcxRadioButton;
    rdb2: TcxRadioButton;
    procedure RzBitBtn5Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Prepare(InShop_ID, InPrint_Date: string);
    class function GetCheckAudit(Owner:TForm; InShop_ID, InPrint_Date: string):integer;
  end;

implementation

uses uGlobal, uShopGlobal;

{$R *.dfm}

{ TfrmCheckAudit }

procedure TfrmCheckAudit.Prepare(InShop_ID, InPrint_Date: string);
var
  s:string;
  rs: TZQuery;
begin
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE and CHECK_STATUS<3 ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=InShop_ID;
    if rs.Params.FindParam('PRINT_DATE')<>nil then rs.ParamByName('PRINT_DATE').AsString:=InPrint_Date;
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
    begin
      RzLabel1.Caption := format('盘点日期:%s',[rs.Fields[0].asString]);
    end else
    begin
      RzBitBtn5.Enabled := false;
      RzBitBtn5.Caption := '无任务...';
      RzLabel1.Caption := format('盘点日期:%s',['没有未完成的任务']);
    end;
  finally
    rs.free;
  end;
end;

procedure TfrmCheckAudit.RzBitBtn5Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14400001',5) then Raise Exception.Create('你没有盘点审核的权限,请和管理员联系.');
  ModalResult := MROK;
end;

procedure TfrmCheckAudit.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmCheckAudit.GetCheckAudit(Owner: TForm; InShop_ID,InPrint_Date: string): integer;
begin
  with TfrmCheckAudit.Create(Owner) do
    begin
      try
        Prepare(InShop_ID,InPrint_Date);
        if (ShowModal=MROK) then
           begin
             if rdb1.Checked then
                result := 0
             else
             if rdb2.Checked then
                result := 1
             else
                result := -1;
           end
        else
           result := -1;
      finally
        free;
      end;
    end;
end;

end.
 