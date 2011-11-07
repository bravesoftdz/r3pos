unit ufrmMMDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, RzBmpBtn, RzForms, StdCtrls, ExtCtrls, RzBckgnd,
  RzPanel, ComCtrls, RzEdit, RzLabel, jpeg, ummFactory, RzButton, RzSplit;

type
  TfrmMMDialog = class(TfrmMMBasic)
    RzPanel5: TRzPanel;
    showRTF: TRzRichEdit;
    RzPanel4: TRzPanel;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    inputRTF: TRzRichEdit;
    Image2: TImage;
    rzUserInfo: TRzLabel;
    cxBtnOk: TRzBmpButton;
    RzLabel1: TRzLabel;
    toolDesk: TRzBmpButton;
    FontDialog1: TFontDialog;
    cxBtnClose: TRzBmpButton;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    procedure RzButton1Click(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure toolDeskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxBtnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure inputRTFKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FmmUserInfo: PmmUserInfo;
    procedure SetmmUserInfo(const Value: PmmUserInfo);
    { Private declarations }
    procedure wmMsgRecv(var Message: TMessage); message WM_MsgRecv;
    procedure wmMsgEvent(var Message: TMessage); message WM_MsgEvent;

    procedure GotoLastLine;
    procedure ShowMsg(Msg:TmmMsgFava;sFlag:integer=0);
    procedure ShowError(Msg:TmmMsgFava);
    function  EncodeMsg:TmmMsgFava;
    procedure CreateParams(var Params: TCreateParams); override;

    function Send(Msg:TmmMsgFava):boolean;
    function ConvertBitmapToRTF(pict: TBitmap): string;
  public
    { Public declarations }
    procedure LoadPic32;
    procedure SendMsg;
    procedure RecvMsg;
    property mmUserInfo:PmmUserInfo read FmmUserInfo write SetmmUserInfo;
  end;
var
  DefFont:TFont;
implementation

uses ufrmMMMain,ummGlobal,uRcFactory;

{$R *.dfm}
var
  sTest:string;

{ TfrmMMBasic1 }

function TfrmMMDialog.ConvertBitmapToRTF(pict: TBitmap): string;
var
   bi, bb, rtf: string;
   bis, bbs: Cardinal;
   achar: ShortString;
   hexpict: string;
   I: Integer;
begin
   GetDIBSizes(pict.Handle, bis, bbs);
   SetLength(bi, bis);
   SetLength(bb, bbs);
   GetDIB(pict.Handle, pict.Palette, PChar(bi)^, PChar(bb)^);
   rtf := '{\rtf1 {\pict\dibitmap ';
   SetLength(hexpict, (Length(bb) + Length(bi)) * 2);
   I := 2;
   for bis := 1 to Length(bi) do
      begin
         achar := Format('%x', [Integer(bi[bis])]);
         if Length(achar) = 1 then
            achar := '0' + achar;
         hexpict[I - 1] := achar[1];
         hexpict[I] := achar[2];
         Inc(I, 2);
      end;
   for bbs := 1 to Length(bb) do
      begin
         achar := Format('%x', [Integer(bb[bbs])]);
         if Length(achar) = 1 then
            achar := '0' + achar;
         hexpict[I - 1] := achar[1];
         hexpict[I] := achar[2];
         Inc(I, 2);
      end;
   rtf := rtf + hexpict + ' }}';
   Result := rtf;
end;
procedure TfrmMMDialog.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      if not (csDesigning in frmMMMain.ComponentState) then
         WndParent:=frmMMMain.Handle; //关键一行，用SetParent都不行！！
    end;
end;

function TfrmMMDialog.EncodeMsg: TmmMsgFava;
begin

end;

function TfrmMMDialog.Send(Msg: TmmMsgFava): boolean;
begin
  mmFactory.mmcSingleFava(TmmSingleFava(Msg));
end;

procedure TfrmMMDialog.SetmmUserInfo(const Value: PmmUserInfo);
begin
  FmmUserInfo := Value;
  if Value=nil then Exit;
  if Value^.PlayerFava=nil then Exit;
  rzUserInfo.Caption := Value^.PlayerFava.nickName +' ('+Value^.PlayerFava.playerId+') ' ;
end;

procedure TfrmMMDialog.ShowError(Msg: TmmMsgFava);
var
  s:string;
  TextAttributes:TTextAttributes;
begin
  gotoLastLine;
  try
    TextAttributes := showRTF.SelAttributes;
    case Msg.mmFlag of
    1003:begin
           TextAttributes.Color := clred;
           TextAttributes.Size := 9;
           TextAttributes.Color := clred;
           TextAttributes.Size := 9;
           s := '   <发送失败了> '+ TmmSingleFava(Msg).nickName+' '+formatDatetime('HH:NN:SS',now())+#13;
           showRTF.Lines.Add(S);
           TextAttributes.Color := clred;
           TextAttributes.Size := 11;
           s := TmmSingleFava(Msg).chatTxt+#13;
           showRTF.Lines.Add(s);
         end;
    1002:begin
           TextAttributes.Color := clred;
           TextAttributes.Size := 9;
           s := '   <发送失败了> '+ TmmGroupFava(Msg).nickName+' '+formatDatetime('HH:NN:SS',now())+#13;
           showRTF.Lines.Add(S);
           TextAttributes.Color := clred;
           TextAttributes.Size := 11;
           s := TmmGroupFava(Msg).chatTxt+#13;
           showRTF.Lines.Add(s);
         end;
    end;
  finally
    inputRTF.SetFocus;
  end;
end;

procedure TfrmMMDialog.ShowMsg(Msg: TmmMsgFava;sFlag:integer=0);
var
  s:string;
  TextAttributes:TTextAttributes;
begin
  gotoLastLine;
  try
    TextAttributes := showRTF.SelAttributes;
    case Msg.mmFlag of
    1003:begin
           if sFlag=0 then
              TextAttributes.Color := clGreen
           else
              TextAttributes.Color := $00FDA04C;
           TextAttributes.Size := 9;
           s := TmmSingleFava(Msg).nickName+' ('+TmmSingleFava(Msg).playerId+') '+formatDatetime('HH:NN:SS',now())+#13;
           showRTF.Lines.Add(S);
           TextAttributes.Name := DefFont.Name;
           TextAttributes.Style := DefFont.Style;
           TextAttributes.Size := DefFont.Size;
           TextAttributes.Charset := DefFont.Charset;
           TextAttributes.Color := DefFont.Color;
           s := TmmSingleFava(Msg).chatTxt+#13;
           showRTF.Lines.Add(s);
         end;
    1002:begin
           if sFlag=0 then
              TextAttributes.Color := clGreen
           else
              TextAttributes.Color := $00FDA04C;
           TextAttributes.Size := 9;
           s := TmmGroupFava(Msg).nickName+' ('+TmmSingleFava(Msg).playerId+') '+formatDatetime('HH:NN:SS',now())+#13;
           showRTF.Lines.Add(S);
           TextAttributes.Name := DefFont.Name;
           TextAttributes.Style := DefFont.Style;
           TextAttributes.Size := DefFont.Size;
           TextAttributes.Charset := DefFont.Charset;
           TextAttributes.Color := DefFont.Color;
           s := TmmGroupFava(Msg).chatTxt+#13;
           showRTF.Lines.Add(s);
         end;
    end;
  finally
    inputRTF.SetFocus;
  end;
end;

procedure TfrmMMDialog.wmMsgEvent(var Message: TMessage);
begin
  RecvMsg;
end;

procedure TfrmMMDialog.wmMsgRecv(var Message: TMessage);
begin
  RecvMsg;
end;

procedure TfrmMMDialog.RzButton1Click(Sender: TObject);
var
  SingleFava:TmmSingleFava;
begin
  inherited;
  SingleFava := TmmSingleFava.Create;
  try
    SingleFava.nickName := '张三';
    SingleFava.mmFlag  := 1003;
    SingleFava.chatTxt := 'skdjfskdjfakdsjfkadjfkdsajfkadjfkdajfkdsjfklajdflkdsjfakdsjfakdjr';
    ShowMsg(SingleFava);
  finally
    SingleFava.Free;
  end;
end;

procedure TfrmMMDialog.GotoLastLine;
begin
 showRTF.SetFocus;
 showRTF.SelStart := length(showRTF.Text);
end;
procedure TfrmMMDialog.SendMsg;
var
  Msg:TmmSingleFava;
begin
  if trim(inputRTF.Text)='' then Raise Exception.Create('请输入发送内容。');
  if not mmFactory.logined then Raise Exception.Create('你已经断线了，请重新上线。'); 
  if not mmUserInfo^.line then Raise Exception.Create('目前不支持发送离线消息。');
  Msg := TmmSingleFava.Create;
  try
    Msg.mmFlag := 1003;
    Msg.messagetype := 1003;
    Msg.routetype := 1;
    Msg.playerId := mmGlobal.xsm_username;
    //消息接收者id，字符串，16位
    Msg.refId :=  mmUserInfo^.PlayerFava.playerId;
    Msg.chatTxt := inputRTF.Text;
    Msg.comId := mmGlobal.xsm_comId;
    //接收者公司ID，字符串，30位
    Msg.refPlayerComId :=  mmUserInfo^.PlayerFava.comId;
    Msg.nickName := mmGlobal.xsm_nickname;
    Msg.refPlayerName :=  mmUserInfo^.PlayerFava.nickName;
    Msg.playerType := mmGlobal.xsm_userType;
    Msg.refPlayerType := mmUserInfo^.PlayerFava.userType;
    Msg.playerSkill := 0;
    Send(Msg);
    inputRTF.Text := '';
  finally
    Msg.Free;
  end;
end;

procedure TfrmMMDialog.cxBtnOkClick(Sender: TObject);
begin
  inherited;
  SendMsg;
end;

procedure TfrmMMDialog.RecvMsg;
var
  i:integer;
  mmMsgFava:TmmMsgFava;
begin
  while mmUserInfo^.Msgs.Count>0 do
    begin
      mmMsgFava := TmmMsgFava(mmUserInfo^.Msgs[0]);
      try
        if mmMsgFava.mmEvent then
           ShowError(mmMsgFava)
        else
           ShowMsg(mmMsgFava);
        mmUserInfo^.Msgs.Delete(0);
      finally
        mmMsgFava.Free;
      end;
    end;
end;

procedure TfrmMMDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmMMDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;

end;

procedure TfrmMMDialog.toolDeskClick(Sender: TObject);
begin
  inherited;
  if FontDialog1.Execute then
     begin
       DefFont.Assign(FontDialog1.Font);
      {
       showRTF.DefAttributes.Name := FontDialog1.Font.Name;
       showRTF.DefAttributes.Style := FontDialog1.Font.Style;
       showRTF.DefAttributes.Charset := FontDialog1.Font.Charset;
       showRTF.DefAttributes.Color := FontDialog1.Font.Color;
       showRTF.DefAttributes.Size := FontDialog1.Font.Size;
       }
     end;
end;

procedure TfrmMMDialog.FormCreate(Sender: TObject);
begin
  inherited;
  showRTF.DefAttributes.Name := DefFont.Name;
  showRTF.DefAttributes.Style := DefFont.Style;
  showRTF.DefAttributes.Charset := DefFont.Charset;
  showRTF.DefAttributes.Color := DefFont.Color;
  showRTF.DefAttributes.Size := DefFont.Size;
  LoadPic32;
end;

procedure TfrmMMDialog.cxBtnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMMDialog.Button1Click(Sender: TObject);
begin
  inherited;
  sTest := inputRTF.Text;
  Timer1.Tag := 0;
  Timer1.Enabled := true;

end;

procedure TfrmMMDialog.Button2Click(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;

end;

procedure TfrmMMDialog.Timer1Timer(Sender: TObject);
begin
  inherited;
  if Timer1.Tag>100 then Exit;
  inputRTF.Text := inttostr(Timer1.Tag)+'->'+sTest;
  SendMsg;
  Timer1.Tag := Timer1.Tag + 1;
end;

procedure TfrmMMDialog.inputRTFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if ((Key=#13) or (Key=#10)) and (trim(inputRTF.Text)='') then
     begin
       Key := #0;
     end;
end;

procedure TfrmMMDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and (Key=VK_RETURN) then
     begin
       SendMsg;
       Shift := [];
       Key := 0;
     end;

end;

procedure TfrmMMDialog.LoadPic32;
var
  sflag:String;
begin
  sflag := 'm'+rcFactory.GetResString(1)+'_';
  //top
  bkg_01.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_top_bkg_01');
  bkg_02.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_top_bkg_02');
  formLogo.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_top_formLogo');
  Image2.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_top_Image2');
  sysClose.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_top_sysClose_Up');
  sysClose.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_top_sysClose_Hot');
  sysMinimized.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_top_sysMinimized_Up');
  sysMinimized.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_top_sysMinimized_Hot');
  sysMaximized.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_top_sysMaximized_Up');
  sysMaximized.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_top_sysMaximized_Hot');
  //middle
  toolDesk.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_mid_toolDesk_Up');
  toolDesk.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_mid_toolDesk_Hot');
  //bottom
  bkg_03.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_bottom_bkg_03');
  bkg_04.Picture.Graphic := rcFactory.GetBitmap(sflag + 'dialog_bottom_bkg_04');
  cxBtnOk.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Up');
  cxBtnOk.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Hot');
  cxBtnClose.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Up');
  cxBtnClose.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Hot');

end;

initialization
  DefFont := TFont.Create;
  DefFont.Size := 13;
finalization
  DefFont.Free;
end.
