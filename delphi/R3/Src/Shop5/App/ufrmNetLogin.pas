unit ufrmNetLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzBmpBtn, cxControls, cxContainer,
  cxEdit, cxCheckBox, RzButton, ExtCtrls, jpeg, StdCtrls, RzLabel, RzBckgnd;

type
  TfrmNetLogin = class(TfrmBasic)
    chkOnline: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    btnReg: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    btnOk: TRzBmpButton;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    Image1: TImage;
    procedure Image2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FIsXsm: boolean;
    procedure SetIsXsm(const Value: boolean);
  public
    { Public declarations }
    //1在线 2脱机 0退出
    class function NetLogin(xsm:boolean=false):integer;
    property IsXsm:boolean read FIsXsm write SetIsXsm;
  end;

implementation
uses ufrmHostDialog,ufrmTenant;
{$R *.dfm}

{ TfrmNetLogin }

class function TfrmNetLogin.NetLogin(xsm:boolean=false): integer;
begin
  with TfrmNetLogin.Create(Application) do
    begin
      try
        IsXsm := xsm;
        case ShowModal of
        MROK:result := 1;
        mrIgnore:result := 2;
        else
          result := 0;
        end;
      finally
        free;
      end;
    end;
end;

procedure TfrmNetLogin.Image2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmNetLogin.btnOkClick(Sender: TObject);
begin
  inherited;
  if chkOnline.Down then
     ModalResult := MROK
  else
     ModalResult := mrIgnore

end;

procedure TfrmNetLogin.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  TfrmHostDialog.HostDialog(self);
end;

procedure TfrmNetLogin.btnRegClick(Sender: TObject);
begin
  inherited;
  TfrmTenant.coNewRegister(self);
end;

procedure TfrmNetLogin.SetIsXsm(const Value: boolean);
begin
  FIsXsm := Value;
  btnReg.Visible := not Value;
end;

procedure TfrmNetLogin.FormCreate(Sender: TObject);
begin
  inherited;
//  if FileExists(ExtractFilePath(ParamStr(0))+'login.jpg') then
//     imgLogin.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'login.jpg');

end;

end.
