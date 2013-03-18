unit ufrmSyncData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzForms, ComCtrls,
  StdCtrls, Buttons;

const
  MSC_SET_MAX=WM_USER+1;
  MSC_SET_POSITION=WM_USER+2;
  MSC_SET_CAPTION=WM_USER+3;
  MSC_SET_CLOSE=WM_USER+4;

type
  TfrmSyncData = class(TfrmWebDialogForm)
    RzPanel1: TRzPanel;
    Image1: TImage;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    RzFormShape1: TRzFormShape;
    procedure FormCreate(Sender: TObject);
  private
    FShowTitle: string;
    FPosition: integer;
    procedure SetShowTitle(const Value: string);
    procedure SetPosition(const Value: integer);
    procedure WM_SetMax(var Message: TMessage); message MSC_SET_MAX;
    procedure WM_SetCaption(var Message: TMessage); message MSC_SET_CAPTION;
    procedure WM_SetPosition(var Message: TMessage); message MSC_SET_POSITION;
    procedure WM_SetClose(var Message: TMessage); message MSC_SET_CLOSE;
  public
    procedure ajustPostion;override;
    procedure ShowPostion(Postion:Integer;Caption:String);
    property ShowTitle:string read FShowTitle write SetShowTitle;
    property Position:integer read FPosition write SetPosition;
  end;

implementation

uses uSyncFactory,uRspSyncFactory;

{$R *.dfm}

procedure TfrmSyncData.ajustPostion;
begin
  inherited;
  RzPanel1.Top := (self.ClientHeight - RzPanel1.Height) div 2 - 1;
  RzPanel1.Left := (self.ClientWidth - RzPanel1.Width) div 2 - 1;
end;

procedure TfrmSyncData.SetPosition(const Value: integer);
begin
  if not Visible then Exit;
  FPosition := Value;
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Value;
  Update;
end;

procedure TfrmSyncData.SetShowTitle(const Value: string);
begin
  if not Visible then Exit;
  FShowTitle := Value;
  Label1.Caption := Value;
  Update;
end;

procedure TfrmSyncData.ShowPostion(Postion: Integer; Caption: String);
begin
  BringToFront;
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Postion;
  Label1.Caption := Caption;
  Label1.Update;
end;

procedure TfrmSyncData.FormCreate(Sender: TObject);
begin
  inherited;
  SyncFactory.ProHandle := self.Handle;
  RspSyncFactory.ProHandle := self.Handle;
  if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\flash.jpg') then
     Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\flash.jpg');
end;

procedure TfrmSyncData.WM_SetCaption(var Message: TMessage);
begin
  if Message.LParam = 0 then
    SetShowTitle('正在同步<'+SyncFactory.GetTableName(Message.WParam)+'>...')
  else
    SetShowTitle('正在同步<'+RspSyncFactory.GetTableName(Message.WParam)+'>...');
end;

procedure TfrmSyncData.WM_SetMax(var Message: TMessage);
begin
  ProgressBar1.Max := Message.WParam;
end;

procedure TfrmSyncData.WM_SetPosition(var Message: TMessage);
begin
  SetPosition(Message.WParam);
end;

procedure TfrmSyncData.WM_SetClose(var Message: TMessage);
begin
  Close;
end;

initialization
  RegisterClass(TfrmSyncData);
finalization
  UnRegisterClass(TfrmSyncData);
end.
