unit ufrmMMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,ZBase,
  RzBckgnd, RzPanel, RzBmpBtn, StdCtrls, uMMUtil, uMMServer ,ShellApi,
  RzButton, ummFactory, RzGroupBar, RzTabs, ComCtrls, RzTreeVw, ZDataSet,
  RzLabel, jpeg, MPlayer;
  
type
  TfrmMMList = class(TfrmMMBasic)
    FlagImage: TImageList;
    PopupMenu1: TPopupMenu;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    rzUsers: TRzTreeView;
    StateImage: TImageList;
    Image2: TImage;
    RzLabel1: TRzLabel;
    MediaPlayer: TMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure rzUsersDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure wmMsgHint(var Message: TMessage); message WM_MsgHint;
  public
    { Public declarations }
    procedure LoadFriends;
    procedure OpenDialog(uid:string);
    procedure PlaySend(filename:string);
  end;

var
  frmMMList: TfrmMMList;
implementation
{$R *.dfm}
uses ufrmMMMain,ummGlobal,uTreeUtil,ufrmMMDialog;

{ TfrmMMList }


procedure TfrmMMList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      if not (csDesigning in frmMMMain.ComponentState) then
         WndParent:=frmMMMain.Handle; //关键一行，用SetParent都不行！！
    end;
end;

procedure TfrmMMList.FormCreate(Sender: TObject);
begin
  inherited;
  left := Screen.Width-width-1;
  top := (Screen.Height - Height) div 2 -1;
end;

procedure TfrmMMList.LoadFriends;
var
  g,b:TTreeNode;
  i:integer;
  rs:TZQuery;
  us:TZQuery;
  Params:TftParamList;
  mmUserInfo:PmmUserInfo;
begin
  rzUsers.Items.Clear;
  rs := TZQuery.Create(nil);
  us := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParambyName('TENANT_ID').asInteger := mmGlobal.TENANT_ID;
    mmGlobal.LocalFactory.Open(rs,'TmqqGrouping',Params);
    mmGlobal.LocalFactory.Open(us,'TmqqFriends',Params);
    rs.first;
    while not rs.eof do
      begin
         g := rzUsers.Items.Add(nil,rs.FieldbyName('I_SHOW_NAME').AsString);
         g.StateIndex := 0;
         us.Filtered := false;
         us.Filter := 'S_GROUP_ID='''+rs.FieldbyName('S_GROUP_ID').AsString+'''';
         us.Filtered := true;
         us.First;
         while not us.Eof do
           begin
             new(mmUserInfo);
             mmUserInfo^.uid := us.FieldbyName('FRIEND_ID').AsString;
             mmUserInfo^.line := false;
             mmUserInfo^.PlayerFava := TmmPlayerFava.Create;
             mmUserInfo^.PlayerFava.messagetype := 1003;
             mmUserInfo^.PlayerFava.routetype := 1;
             mmUserInfo^.PlayerFava.playerId := us.FieldbyName('FRIEND_ID').AsString;
             mmUserInfo^.PlayerFava.nickName := us.FieldbyName('FRIEND_NAME').AsString;
             mmUserInfo^.PlayerFava.userType := us.FieldbyName('USER_TYPE').AsString;
             //其他信息暂缺
             mmUserInfo^.IsBeBlack := (us.FieldbyName('IS_BE_BLACK').asString='1');
             mmFactory.Add(mmUserInfo);
             b := rzUsers.Items.AddChildObject(g,us.FieldbyName('U_SHOW_NAME').AsString,mmUserInfo);
             b.ImageIndex := 1;
             us.Next;
           end;
         rs.Next;
      end;
  finally
    Params.Free;
    us.Free;
    rs.Free;
  end;    
end;

procedure TfrmMMList.OpenDialog(uid: string);
var
  UserInfo:PmmUserInfo;
  i:integer;
begin
  UserInfo := mmFactory.Find(uid);
  for i:=0 to Screen.FormCount -1 do
    begin
      if UserInfo^.Handle = Screen.Forms[i].Handle then
         begin
           Screen.Forms[i].Show;
           Exit;
         end;
    end;
  with TfrmMMDialog.Create(Application) do
    begin
      Show;
      if UserInfo<>nil then
         begin
           mmUserInfo := UserInfo;
           mmUserInfo^.Handle := Handle;
           if mmUserInfo^.Msgs.Count > 0 then PostMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
         end;
    end;
end;

procedure TfrmMMList.PlaySend(filename: string);
begin
  MediaPlayer.Close;
  MediaPlayer.FileName := filename;
  MediaPlayer.Open;
  MediaPlayer.Play;
end;

procedure TfrmMMList.RzButton1Click(Sender: TObject);
begin
  inherited;
  frmMMMain.WindowState := wsMaximized;
  frmMMMain.Show;
end;

procedure TfrmMMList.RzGroup1Items0Click(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmMMList.RzGroup1Items1Click(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmMMList.rzUsersDblClick(Sender: TObject);
begin
  inherited;
  if rzUsers.Selected = nil then Exit;
  if rzUsers.Selected.Data = nil then Exit;
  OpenDialog(PmmUserInfo(rzUsers.Selected.Data)^.uid);

end;

procedure TfrmMMList.wmMsgHint(var Message: TMessage);
begin
  PlaySend(ExtractFilePath(ParamStr(0))+'res\msg.mp3');
end;

end.
