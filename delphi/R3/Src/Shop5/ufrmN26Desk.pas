unit ufrmN26Desk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, ImgList, ExtCtrls, StdCtrls, Buttons, jpeg, RzPanel,
  RzBmpBtn, RzLine, RzLabel, Menus,ShlObj,ComObj,ShellApi,ActiveX,
  RzGroupBar, RzTabs, OleCtrls, SHDocVw, ActnList, MSHTML;

type
  TfrmN26Desk = class(TfrmDesk)
    RzPanel1: TRzPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ImageList1: TImageList;
    bgFunc: TRzPanel;
    btnDownOrder: TRzBmpButton;
    btnStockOrder: TRzBmpButton;
    btnStorage: TRzBmpButton;
    bgBase: TRzPanel;
    IEDesktop: TWebBrowser;
    btnSalesOrder: TRzBmpButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    RzBmpButton2: TRzBmpButton;
    Image5: TImage;
    Image6: TImage;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure RzBmpButton16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDownOrderClick(Sender: TObject);
    procedure btnStockOrderClick(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure btnStorageClick(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure IEDesktopNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure IEDesktopBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
  private
    FHookLocked: boolean;
    Wait:boolean;
    procedure SetHookLocked(const Value: boolean);
    function FindAction(id: string): TAction;
    { Private declarations }
  protected
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);override;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);override;
  public
    { Public declarations }
    procedure LoadDesk;
    property HookLocked:boolean read FHookLocked write SetHookLocked;
  end;

var
  frmN26Desk: TfrmN26Desk;

implementation
uses ufrmMain,udmIcon,uRcFactory,uShopGlobal,uDevFactory,Registry,IniFiles,
  ufrmN26Main,uMsgBox;
{$R *.dfm}

function TfrmN26Desk.FindAction(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmMain.actList.ActionCount - 1 do
    begin
      if lowercase(frmMain.actList.Actions[i].name) = lowercase(id) then
         begin
           result := TAction(frmMain.actList.Actions[i]);
           Exit;
         end;
    end;
end;
procedure TfrmN26Desk.RzBmpButton16Click(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmN26Desk.FormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  Locked := false;
end;

procedure TfrmN26Desk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not HookLocked then
     DevFactory.OpenCashBox;
end;

procedure TfrmN26Desk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmN26Desk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

procedure TfrmN26Desk.btnDownOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmDownIndeOrder');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.btnStockOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStockOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.btnSalesOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPosMain');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.btnStorageClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStorageTracking');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.LoadDesk;
var url:string;
    Doc:IHTMLDocument2;
    Ec:IHTMLElementCollection;
    iframe:DispHTMLIFrame;
    _Start:int64;
    F:TIniFile;
begin
  Wait := true;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    case F.ReadInteger('soft','deskFlag',0) of
    0:begin //默认界面
        if not FileExists(ExtractFilePath(ParamStr(0))+'desk.html') then Exit;
        IEDesktop.Navigate(ExtractFilePath(ParamStr(0))+'desk.html');
        _Start := GetTickCount;
        while Wait do
          begin
            if (GetTickCount - _Start) > 20000 then break;
            Application.ProcessMessages;
          end;
        Doc := IEDesktop.Document as IHTMLDocument2;
        if Doc=nil then Exit;
        iframe := Doc.all.item('mht1',EmptyParam) as DispHTMLIFrame;
        if iframe<>nil then
           begin
             iframe.src := ExtractFilePath(ParamStr(0))+'adv\mht1.mht';
           end;
        if FileExists(ExtractFilePath(ParamStr(0))+'adv\adv1.html') then
           begin
             url := ExtractFilePath(ParamStr(0))+'adv\adv1.html';
             iframe := Doc.all.item('Adv1',EmptyParam) as DispHTMLIFrame;
             if iframe<>nil then iframe.src := url;
           end;
      end;
    1:begin //只有HTML在线页面
        bgFunc.Visible := false;
        IEDesktop.Navigate(ExtractFilePath(ParamStr(0))+'desk.html');
      end;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmN26Desk.RzBmpButton1Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmRecvForDay');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.RzBmpButton3Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPriceOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.RzBmpButton2Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmCheckOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmN26Desk.IEDesktopNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  Wait := false;
end;

procedure TfrmN26Desk.IEDesktopBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  s:string;
  w:integer;
  vList:TStringList;
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
  try
    vList.CommaText := s;
    Action := frmN26Main.FindAction(vList.Values['action']);
    if Assigned(Action) and Action.Enabled then
       begin
         Action.OnExecute(Action);
       end
    else ShowMsgBox('你没有操作此模块的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
  finally
    vList.Free;
  end;
end;

end.
