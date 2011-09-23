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
    RzPanel6: TRzPanel;
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    rzUsers: TRzTreeView;
    MediaPlayer: TMediaPlayer;
    Timer1: TTimer;
    RzPanel1: TRzPanel;
    toolDesk: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    rzUserInfo: TRzLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure rzUsersDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rzUsersExpanded(Sender: TObject; Node: TTreeNode);
    procedure rzUsersCollapsed(Sender: TObject; Node: TTreeNode);
    procedure Timer1Timer(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure wmMsgHint(var Message: TMessage); message WM_MsgHint;
    procedure wmMsgLine(var Message: TMessage); message WM_LINE;
    procedure wmMsgClose(var Message: TMessage); message WM_CLOSE;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    function check:boolean;
    procedure LoadFriends;
    procedure ReadInfo;
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
  Exit;
  with Params do
    begin
      if not (csDesigning in frmMMMain.ComponentState) then
         WndParent:=frmMMMain.Handle; //关键一行，用SetParent都不行！！
    end;
end;

procedure TfrmMMList.FormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  for i:=0 to RzPage.PageCount-1 do RzPage.Pages[i].TabVisible := false;
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
         g.ImageIndex := 0;
         g.SelectedIndex := 0;
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
             b.SelectedIndex := 1;
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
           if mmUserInfo^.Msgs.Count > 0 then SendMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
         end;
    end;
  check;
end;

procedure TfrmMMList.PlaySend(filename: string);
begin
  MediaPlayer.Close;
  MediaPlayer.FileName := filename;
  MediaPlayer.Open;
  MediaPlayer.Play;
end;

procedure TfrmMMList.ReadInfo;
begin
  rzUserInfo.Caption := mmGlobal.xsm_nickname +' ('+mmGlobal.xsm_username+')';
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

procedure TfrmMMList.wmMsgClose(var Message: TMessage);
begin
  if Message.LParam = 0 then
     MessageBox(Handle,'当前账号在另一地方登录了.','友情提示..',MB_OK+MB_ICONINFORMATION);
  frmMMMain.RzTrayIcon1.Animate := false;
  frmMMMain.RzTrayIcon1.IconIndex := 0;
  
  mmFactory.mmcClose;
  PostMessage(frmMMList.Handle,WM_LINE,0,0);
end;

procedure TfrmMMList.wmMsgHint(var Message: TMessage);
begin
  PlaySend(ExtractFilePath(ParamStr(0))+'res\msg.mp3');
  check;
end;

procedure TfrmMMList.wmMsgLine(var Message: TMessage);
var
  i:integer;
begin
  for i:=0 to rzUsers.Items.Count -1 do
    begin
      if rzUsers.Items[i].Data <> nil then
         begin
           if PmmUserInfo(rzUsers.Items[i].Data)^.line and mmFactory.Logined then
              rzUsers.Items[i].ImageIndex := 3 {在线}
           else
              rzUsers.Items[i].ImageIndex := 2 {下线};
           rzUsers.Items[i].SelectedIndex := rzUsers.Items[i].ImageIndex;
         end;
    end;
end;

procedure TfrmMMList.FormShow(Sender: TObject);
begin
  inherited;
  ReadInfo;
end;

procedure TfrmMMList.rzUsersExpanded(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Node.SelectedIndex := 1;
  Node.ImageIndex := 1;
end;

procedure TfrmMMList.rzUsersCollapsed(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;

end;

function TfrmMMList.check: boolean;
begin
  frmMMMain.RzTrayIcon1.Animate := mmFactory.HasMsg;
  Timer1.Enabled := frmMMMain.RzTrayIcon1.Animate;
  if not Timer1.Enabled then frmMMMain.RzTrayIcon1.IconIndex := 1;
end;

procedure TfrmMMList.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  inherited;
  for i:=rzUsers.Items.Count -1 downto 0 do
    begin
      if rzUsers.Items[i].Data = nil then continue;
      if PmmUserInfo(rzUsers.Items[i].Data).Msgs.Count > 0 then
         begin
           if rzUsers.Items[i].ImageIndex = 2 then
              rzUsers.Items[i].ImageIndex := 3
           else
              rzUsers.Items[i].ImageIndex := 2;
           rzUsers.Items[i].SelectedIndex := rzUsers.Items[i].ImageIndex;
         end;
    end;
end;

procedure TfrmMMList.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  frmMMMain.WindowState := wsMaximized;
  frmMMMain.Show;
end;

destructor TfrmMMList.Destroy;
begin
  rzUsers.Items.Clear;
  inherited;
end;

constructor TfrmMMList.Create(AOwner: TComponent);
begin
  inherited;
  self.Position := poDesigned;
  left := Screen.Width-width-1;
  top := (Screen.Height - Height) div 2 -1;
end;

end.
