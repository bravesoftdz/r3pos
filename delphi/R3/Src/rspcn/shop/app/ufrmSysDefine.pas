unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzTabs,
  RzBmpBtn, jpeg;

type
  TfrmSysDefine = class(TfrmWebToolForm)
    lblCaption: TRzLabel;
    RzPanel1: TRzPanel;
    PageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSysDefine: TfrmSysDefine;

implementation

{$R *.dfm}

procedure TfrmSysDefine.FormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
end;

initialization
  RegisterClass(TfrmSysDefine);
finalization
  UnRegisterClass(TfrmSysDefine);
end.
