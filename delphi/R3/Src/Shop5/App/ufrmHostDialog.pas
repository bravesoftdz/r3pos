unit ufrmHostDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzBckgnd, StdCtrls, ComCtrls,
  RzListVw, RzButton, ImgList;

type
  TfrmHostDialog = class(TfrmBasic)
    RzBackground1: TRzBackground;
    Label1: TLabel;
    rzDbList: TRzListView;
    cxbtnCancel: TRzBitBtn;
    btnInstall: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    ImageList1: TImageList;
    procedure cxbtnCancelClick(Sender: TObject);
    procedure btnInstallClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadHost;
    class function HostDialog(Owner:TForm):TModalResult;
  end;

implementation
uses IniFiles,ufrmTenant;
{$R *.dfm}

{ TfrmHostDialog }

class function TfrmHostDialog.HostDialog(Owner: TForm): TModalResult;
begin
  with TfrmHostDialog.Create(Owner) do
    begin
      try
        ReadHost;
        result := (ShowModal);
      finally
        free;
      end;
    end;
end;

procedure TfrmHostDialog.ReadHost;
var
  f:TIniFile;
  i:integer;
  Host:TStringList;
  Item:TListItem;
begin
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  rzDbList.Items.Clear;
  Host := TStringList.Create;
  try
    f.ReadSections(Host);
    for i:=0 to Host.Count-1 do
      begin
        if copy(Host[i],1,2)='H_' then
           begin
            Item := rzDbList.Items.Add;
            Item.Caption := copy(Host[i],3,255);
            Item.SubItems.Add(f.ReadString(Host[i],'srvrName',''));
            Item.SubItems.Add(f.ReadString(Host[i],'srvrStatus',''));
            Item.SubItems.Add(f.ReadString(Host[i],'hostName',''));
            Item.SubItems.Add(f.ReadString(Host[i],'srvrPort',''));
           end;
      end;
  finally
    Host.Free;
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmHostDialog.cxbtnCancelClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmHostDialog.btnInstallClick(Sender: TObject);
var
  f:TIniFile;
begin
  inherited;
  if rzDbList.Selected = nil then Raise Exception.Create('请在列表中选择服务主机...');
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  try
    f.WriteString('db','Connstr','connmode=2;hostname='+rzDbList.Selected.SubItems[2]+';port='+rzDbList.Selected.SubItems[3]+';dbid='+f.ReadString('db','dbid','0'));
    f.WriteString('db','srvrId',rzDbList.Selected.Caption);
  finally
    try
      F.Free;
    except
    end;
  end;
  self.ModalResult := MROK;
end;

procedure TfrmHostDialog.RzBitBtn1Click(Sender: TObject);
begin
  if TfrmTenant.coNewRegister(self) then
     begin
       ModalResult := mrRetry;
     end;

end;

end.
