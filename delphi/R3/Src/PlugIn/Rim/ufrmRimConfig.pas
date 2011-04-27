unit ufrmRimConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmRimConfig = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
implementation
uses IniFiles;
{$R *.dfm}

procedure TfrmRimConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRimConfig.Button1Click(Sender: TObject);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
  try
    F.WriteString('rim','url',Edit1.Text);
  finally
    F.free;
  end;
  close;
end;

end.
