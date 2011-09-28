unit ufrmMMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,ZBase,
  RzBckgnd, RzPanel, RzBmpBtn, StdCtrls, uMMUtil, uMMServer ,ShellApi,
  RzButton, ummFactory, RzGroupBar, RzTabs, ComCtrls, RzTreeVw, ZDataSet,
  RzLabel, jpeg, MPlayer, Mask, RzEdit,ufrmHintMsg,ufrmMMFindBox;
  
type
  TfrmMMList = class(TfrmMMBasic)
    FlagImage: TImageList;
    PopupMenu1: TPopupMenu;
    bkg_tl: TRzPanel;
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
    Image1: TImage;
    Image7: TImage;
    bkg_f3: TRzBackground;
    Image6: TImage;
    Image5: TImage;
    lbM0: TLabel;
    lbM4: TLabel;
    lbM1: TLabel;
    Image3: TImage;
    Image4: TImage;
    rzFilter: TRzEdit;
    RzBmpButton2: TRzBmpButton;
    UsersStatus: TRzBmpButton;
    rzUserNote: TRzLabel;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure rzUsersDblClick(Sender: TObject);
    procedure rzUsersExpanded(Sender: TObject; Node: TTreeNode);
    procedure rzUsersCollapsed(Sender: TObject; Node: TTreeNode);
    procedure Timer1Timer(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure rzUsersClick(Sender: TObject);
    procedure UsersStatusClick(Sender: TObject);
    procedure rzFilterChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rzFilterExit(Sender: TObject);
    procedure rzUsersCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure Image5Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
    frmMMFindBox:TfrmMMFindBox;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure wmMsgHint(var Message: TMessage); message WM_MsgHint;
    procedure wmMsgLine(var Message: TMessage); message WM_LINE;
    procedure wmMsgClose(var Message: TMessage); message WM_MMCLOSE;
    procedure wmMsgStatus(var Message: TMessage); message WM_STATUS;
    procedure wmMscShow(var Message: TMessage); message MSC_SHOW_UPDATE;
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
             b.ImageIndex := 2;
             b.SelectedIndex := 2;
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
           Screen.Forms[i].WindowState := wsNormal;
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
  rzUserNote.Caption := mmGlobal.xsm_note;
  if rzUserNote.Caption = '' then rzUserNote.Caption := '无';
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
  if not Assigned(mmGlobal) then Exit;
  frmMMMain.RzTrayIcon1.Animate := false;
  frmMMMain.RzTrayIcon1.IconIndex := 0;

  mmGlobal.CloseMsc;
  PostMessage(frmMMList.Handle,WM_LINE,0,0);
  if Message.LParam = 0 then
     MessageBox(Handle,'当前账号在另一地方登录了.','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmMMList.wmMsgHint(var Message: TMessage);
begin
  if not Assigned(mmGlobal) then Exit;
  case Message.WParam of
  0:PlaySend(ExtractFilePath(ParamStr(0))+'res\msg.wav');
  1:PlaySend(ExtractFilePath(ParamStr(0))+'res\system.wav');
  end;
  check;
end;

procedure TfrmMMList.wmMsgLine(var Message: TMessage);
var
  i:integer;
begin
  if not Assigned(mmGlobal) then Exit;
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
var
  i:integer;
begin
  frmMMMain.RzTrayIcon1.Animate := mmFactory.HasMsg;
  Timer1.Enabled := frmMMMain.RzTrayIcon1.Animate;
  if not mmFactory.logined then
     frmMMMain.RzTrayIcon1.IconIndex := 0
  else
     frmMMMain.RzTrayIcon1.IconIndex := 1;
  if not Timer1.Enabled then
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
           if rzUsers.Items[i].ImageIndex = 3 then
              rzUsers.Items[i].ImageIndex := 4
           else
              rzUsers.Items[i].ImageIndex := 3;
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
  frmMMFindBox.Free;
  rzUsers.Items.Clear;
  inherited;
  frmMMList := nil;
end;

constructor TfrmMMList.Create(AOwner: TComponent);
begin
  inherited;
  frmMMFindBox := TfrmMMFindBox.Create(self); 
  self.Position := poDesigned;
  left := Screen.Width-width-1;
  top := (Screen.Height - Height) div 2 -1;
  bkg_f3.Anchors := [akTop,akRight];
  bkg_f3.Width  := bkg_f1.Width;
  bkg_f3.Top := 0;
  bkg_f3.Left := bkg_tl.Width - bkg_f3.Width;
  bkg_f3.Height := bkg_tl.Height;
end;

procedure TfrmMMList.wmMsgStatus(var Message: TMessage);
begin
  if not Assigned(mmGlobal) then Exit;
  UsersStatus.Down := not mmFactory.Logined;
end;

procedure TfrmMMList.rzUsersClick(Sender: TObject);
begin
  inherited;
  if rzUsers.Selected<>nil then
     begin
       rzUsers.Selected.Expanded := not rzUsers.Selected.Expanded;
     end;
end;

procedure TfrmMMList.wmMscShow(var Message: TMessage);
var
  i:integer;
  m0:integer;
  m1:integer;
  m4:integer;
begin
  m0 := 0;
  m1 := 0;
  m4 := 0;
  for i:= MsgFactory.Count - 1 downto 0 do
    begin
      if not MsgFactory.MsgInfo[i].Rdd then
         begin
           case MsgFactory.MsgInfo[i].Msg_Class of
           0:inc(m0);
           1:inc(m1);
           4:inc(m4);
           end;
         end; 
    end;
  lbM0.Caption := '('+inttostr(m0)+')';
  lbM1.Caption := '('+inttostr(m1)+')';
  lbM4.Caption := '('+inttostr(m4)+')';
end;

procedure TfrmMMList.UsersStatusClick(Sender: TObject);
begin
  inherited;
  UsersStatus.Down := not mmFactory.Logined;
end;

procedure TfrmMMList.rzFilterChange(Sender: TObject);
begin
  inherited;
  if rzFilter.Text='' then
     begin
       frmMMFindBox.Close;
       Exit;
     end;
  frmMMFindBox.Locked := true;
  try
    frmMMFindBox.Popup(rzFilter,rzFilter.Text);
    rzFilter.SetFocus;
  finally
    frmMMFindBox.Locked := false;
  end;
end;

procedure TfrmMMList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmMMFindBox.Close;
end;

procedure TfrmMMList.rzFilterExit(Sender: TObject);
begin
  inherited;
  if not frmMMFindBox.Focused then
     frmMMFindBox.Close;

end;

procedure TfrmMMList.rzUsersCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
  inherited;
  if assigned(Node1.Data) and assigned(Node2.Data) then
     begin
       if Node1.ImageIndex>Node2.ImageIndex then
          Compare := 1
       else
       if Node1.ImageIndex<Node2.ImageIndex then
          Compare := -1
       else
          Compare := 0;
     end
  else
     Compare := 0;
end;

procedure TfrmMMList.Image5Click(Sender: TObject);
begin
  inherited;
  frmMMMain.actfrmNewPaperReader.OnExecute(frmMMMain.actfrmNewPaperReader);
end;

procedure TfrmMMList.Image3Click(Sender: TObject);
begin
  inherited;
  frmMMMain.actfrmNewPaperReader.OnExecute(frmMMMain.actfrmNewPaperReader);

end;

procedure TfrmMMList.Image4Click(Sender: TObject);
begin
  inherited;
  frmMMMain.actfrmNewPaperReader.OnExecute(frmMMMain.actfrmNewPaperReader);

end;

end.
