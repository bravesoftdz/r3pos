unit ufrmMMDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, StdCtrls, SHDocVw, MSHTML, ActnList, OleCtrls;

type
  TfrmMMDesk = class(TfrmDesk)
    IEDesktop: TWebBrowser;
    NewWindow: TWebBrowser;
    procedure ufr(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure Button1Click(Sender: TObject);
    procedure IEDesktopNewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
  private
    FHookLocked: boolean;
    procedure SetHookLocked(const Value: boolean);
    { Private declarations }
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);override;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);override;
  public
    { Public declarations }
    procedure LoadDesk;
    procedure OpenPage(script:string);
    property HookLocked:boolean read FHookLocked write SetHookLocked;
  end;

var
  frmMMDesk: TfrmMMDesk;

implementation
uses uDevFactory,uMsgBox,ufrmMMMain,ufrmMMToolBox;
{$R *.dfm}

{ TfrmMMDesk }

procedure TfrmMMDesk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not HookLocked then
     DevFactory.OpenCashBox;

end;

procedure TfrmMMDesk.LoadDesk;
var
    url:string;
    Doc:IHTMLDocument2;
    Ec:IHTMLElementCollection;
    iframe:DispHTMLIFrame;
    _Start:int64;
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+'desk.html') then Exit;
  IEDesktop.Navigate(ExtractFilePath(ParamStr(0))+'desk.html');
  Application.ProcessMessages;
  _Start := GetTickCount;
  while IEDesktop.ReadyState <> READYSTATE_COMPLETE do
    begin
      if (GetTickCount-_Start) > 20000 then break;
      Application.ProcessMessages;
    end;
  Doc := IEDesktop.Document as IHTMLDocument2;
  if Doc=nil then Exit;
  if FileExists(ExtractFilePath(ParamStr(0))+'res\desk.html') then
     begin
       url := ExtractFilePath(ParamStr(0))+'res\desk.html';
       iframe := Doc.all.item('mht1',EmptyParam) as DispHTMLIFrame;
       if iframe<>nil then iframe.src := url;
     end
  else
  if FileExists(ExtractFilePath(ParamStr(0))+'res\desk.mht') then
     begin
       url := ExtractFilePath(ParamStr(0))+'res\desk.mht';
       iframe := Doc.all.item('mht1',EmptyParam) as DispHTMLIFrame;
       if iframe<>nil then iframe.src := url;
     end;
  if FileExists(ExtractFilePath(ParamStr(0))+'adv\adv1.html') then
     begin
       url := ExtractFilePath(ParamStr(0))+'adv\adv1.html';
       iframe := Doc.all.item('Adv1',EmptyParam) as DispHTMLIFrame;
       if iframe<>nil then iframe.src := url;
     end;
end;

procedure TfrmMMDesk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmMMDesk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

procedure TfrmMMDesk.ufr(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  s:string;
  w:integer;
  vList:TStringList;
  Node:PMMToolBox;
  Action:TAction;
begin
  inherited;
  Cancel := false;
  s := url;
  w := pos('dsk=',s);
  if w=0 then Exit;
  delete(s,1,w+4);
  if (s<>'') and (s[length(s)]=')') then delete(s,length(s),1);
  Cancel := true;
  vList := TStringList.Create;
  new(Node);
  try
    vList.CommaText := s;
    Action := frmMMMain.FindAction(vList.Values['action']);
    if Assigned(Action) and Action.Enabled then
       begin
         Node^.Action := Action;
         Node^.mid := vList.Values['moduId'];
         if (Action.Name = 'actfrmXsmNet')
            or
            (Action.Name = 'actfrmRimNet')
         then
            Action.OnExecute(TObject(Node))
         else
            Action.OnExecute(Action);
       end
    else ShowMsgBox('你没有操作此模块的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
  finally
    dispose(Node);
    vList.Free;
  end;
end;

procedure TfrmMMDesk.Button1Click(Sender: TObject);
begin
  inherited;
  LoadDesk;
end;

procedure TfrmMMDesk.IEDesktopNewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
  inherited;
  ppDisp := NewWindow.Application;
end;

procedure TfrmMMDesk.OpenPage(script: string);
var
  Doc:IHTMLDocument2;
  win: IHTMLWindow2;
  Olelanguage: Olevariant;
begin
  Doc := IEDesktop.document as IHTMLDocument2;
  if Doc=nil then Raise Exception.Create('桌面HTML打开失败'); 
  win := Doc.parentWindow;
  try
    win.execScript(script,Olelanguage);
  finally
    win := nil;
    Doc := nil;
  end;
end;

end.
