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
    apply: TRzBmpButton;
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
    procedure sysCloseClick(Sender: TObject);
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
    procedure LoadPic32;
    function  check:boolean;
    procedure LoadFriends;
    procedure addStranger(userid,username:string);
    procedure ReadInfo;
    procedure OpenDialog(uid:string);
    procedure PlaySend(filename:string);
  end;

var
  frmMMList: TfrmMMList;
implementation
{$R *.dfm}
uses ufrmMMMain,ummGlobal,uTreeUtil,ufrmMMDialog,uRcFactory;

{ TfrmMMList }


procedure TfrmMMList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  with Params do
//    begin
//      if not (csDesigning in frmMMMain.ComponentState) and ((mmGlobal.module[2]='1') or (mmGlobal.module[3]='1') or (mmGlobal.module[4]='1')) then
//         WndParent:=frmMMMain.Handle; //关键一行，用SetParent都不行！！
//    end;
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
    if not rs.Locate('S_GROUP_ID','STRANGER',[]) then
       begin
         rs.Append;
         rs.FieldByName('S_GROUP_ID').AsString := 'STRANGER';
         rs.FieldByName('I_SHOW_NAME').AsString := '陌生人';
         rs.Post;
       end;
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
             if us.FieldbyName('FRIEND_ID').AsString<>mmGlobal.xsm_username then
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
                end;
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
  if (mmGlobal.module[2]='1') or (mmGlobal.module[3]='1') or (mmGlobal.module[4]='1') then
     begin
       frmMMMain.WindowState := wsMaximized;
       frmMMMain.Show;
     end
  else
     MessageBox(Handle,'您没有开通其他应用,请联系客服开通此服务','友情提示...',MB_OK+MB_ICONINFORMATION);
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
  LoadPic32;
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

procedure TfrmMMList.LoadPic32;
var
  sflag:String;
begin
  sflag := 'm'+rcFactory.GetResString(1)+'_';
  //bottom
  RzBmpButton2.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'list_bottom_RzBmpButton2_Up');
  Image1.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_bottom_bkg_01');
  Image7.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_bottom_bkg_02');

  //middle
  Image3.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_mid_bkg_03');
  Image4.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_mid_bkg_04');
  Image5.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_mid_bkg_05');
  Image6.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_mid_bkg_06');
  toolDesk.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'list_mid_toolDesk_Up');
  toolDesk.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'list_mid_toolDesk_Down');
  apply.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'list_mid_RzBmpButton1_Up');
  apply.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'list_mid_RzBmpButton1_Down');
  
  //top
  Image2.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_top_Image2');
  UsersStatus.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'list_top_UsersStatus_Up');
  UsersStatus.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'list_top_UsersStatus_Down');

end;

procedure TfrmMMList.sysCloseClick(Sender: TObject);
begin
  if (mmGlobal.module[2]='1') or (mmGlobal.module[3]='1') or (mmGlobal.module[4]='1') then
     inherited
  else
     frmMMMain.Close;

end;

procedure TfrmMMList.addStranger(userid, username: string);
var
  mmUserInfo:PmmUserInfo;
  b,g:TTreeNode;
  i:integer;
begin
  mmUserInfo := mmFactory.Find(userid);
  if mmUserInfo=nil then
     begin
       mmGlobal.addStranger(userid,username);
       new(mmUserInfo);
       mmUserInfo^.uid := userid;
       mmUserInfo^.line := true;
       mmUserInfo^.IsBeBlack := false;
       mmUserInfo^.PlayerFava := TmmPlayerFava.Create;
       mmUserInfo^.PlayerFava.messagetype := 1003;
       mmUserInfo^.PlayerFava.routetype := 1;
       mmUserInfo^.PlayerFava.playerId := userid;
       mmUserInfo^.PlayerFava.nickName := username;
       mmUserInfo^.PlayerFava.userType := '1000';
       mmFactory.Add(mmUserInfo);
       g := nil;
       for i:=0 to rzUsers.Items.Count -1 do
         begin
           if rzUsers.Items[i].Text='陌生人' then
              begin
                g := rzUsers.Items[i];
                break;
              end;
         end;
       b := rzUsers.Items.AddChildObject(g,username,mmUserInfo);
       b.ImageIndex := 3;
       b.SelectedIndex := 3;
     end;
end;

end.
