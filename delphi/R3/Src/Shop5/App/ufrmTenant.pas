unit ufrmTenant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzTabs, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, RzButton, RzLabel;

type
  TfrmTenant = class(TfrmBasic)
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    lblName: TLabel;
    cxedtPasswrd: TcxTextEdit;
    lblPass: TLabel;
    cxTextEdit1: TcxTextEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtLOGIN_NAME: TcxTextEdit;
    edtTENANT_NAME: TcxTextEdit;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtTENANT_SHORT_NAME: TcxTextEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtLEGAL_REPR: TcxTextEdit;
    Label9: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label10: TLabel;
    edtTELEPHONE: TcxTextEdit;
    Label11: TLabel;
    edtFAXES: TcxTextEdit;
    Label12: TLabel;
    edtHOMEPAGE: TcxTextEdit;
    Label13: TLabel;
    edtADDRESS: TcxTextEdit;
    Label14: TLabel;
    edtPOSTALCODE: TcxTextEdit;
    Label15: TLabel;
    cxTextEdit2: TcxTextEdit;
    Label16: TLabel;
    Label17: TLabel;
    cxTextEdit3: TcxTextEdit;
    Label18: TLabel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzLabel1: TRzLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function coRegister(Owner:TForm):boolean;
  end;

implementation

{$R *.dfm}

class function TfrmTenant.coRegister(Owner: TForm): boolean;
begin
  with TfrmTenant.Create(Owner) do
    begin
      try
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmTenant.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  for i:=0 to RzPage.PageCount -1 do RzPage.Pages[i].TabVisible := false;
  RzPage.ActivePageIndex := 0;
end;

end.
