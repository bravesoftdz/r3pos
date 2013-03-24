//*************************************************************
//                    EmbeddedWB - Tabs Demo                  *
//                                                            *
//                            by                              *
//                     Eran Bodankin (bsalsa)                 *
//                     bsalsa@bsalsa.com                      *
//                                                            *
//     Documentation and updated versions:                    *
//               http://www.bsalsa.com                        *
//*************************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. BSALSA PRODUCTIONS DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. BSALSA PRODUCTIONS SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the demo under 4 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. Please,  consider donation in our web site!
{*******************************************************************************}

unit ufrmBrowerForm;

interface

uses
  Classes, Windows, Controls, Forms, ComCtrls, ExtCtrls, StdCtrls, OleCtrls, SysUtils,
  IEAddress, EwbCore,ImgList,urlMon, ActiveX, EmbeddedWB, ShDocVw_Ewb, MSHTML_EWB, EWBAcc, RzTabs, RzBmpBtn,
  RzPanel, Messages, MSHTML, IEConst, RzPrgres,rspcn_TLB,EncDec, msxml, ComObj, urlParser,
  Graphics, jpeg, RzForms, RzTray, RzLabel, Menus, RzBckgnd,IniFiles;
const
  WM_BROWSER_INIT =WM_USER+1000;
  WM_SEND_BARCODE =WM_USER+9001;
type
  TTabSheetEx = class(TRZTabSheet)
  private
    EWB: TEmbeddedWB;
    WebForm:TScrollBox;
    CanBack: Boolean;
    CanForward: Boolean;
    CanStop: Boolean;
    url:TurlToken;
    LocationName:string;        {应用显示名称模块名}
    button:TrzBmpButton;
    xsmLogined:boolean;
  end;

type
  TfrmBrowerForm = class(TForm)
    pnlAddressBar: TPanel;
    btnBack: TRzBmpButton;
    btnGo: TRzBmpButton;
    RzPanel1: TRzPanel;
    IEAddress1: TIEAddress;
    RzPanel2: TRzPanel;
    serachText: TEdit;
    ImageList1: TImageList;
    RzProgressBar1: TRzProgressBar;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    pageTab: TRzPanel;
    RzFormShape1: TRzFormShape;
    RzBmpButton2: TRzBmpButton;
    btnWindow: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzTrayIcon1: TRzTrayIcon;
    lblUserName: TRzLabel;
    Image9: TImage;
    btnPageClose: TRzBmpButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Timer1: TTimer;
    tool_left: TImage;
    RzPanel3: TRzPanel;
    PageControl1: TRzPageControl;
    toolleft: TRzPanel;
    Image12: TImage;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton7: TRzBmpButton;
    RzBmpButton8: TRzBmpButton;
    RzBmpButton9: TRzBmpButton;
    RzBmpButton10: TRzBmpButton;
    Image6: TImage;
    button_close: TImage;
    home_down: TImage;
    button_active: TImage;
    Image7: TImage;
    RzBmpButton1: TRzBmpButton;
    RzBackground1: TRzBackground;
    RzBackground2: TRzBackground;
    procedure PageControl1Change(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure PageControl1Close(Sender: TObject; var AllowClose: Boolean);
    procedure serachTextEnter(Sender: TObject);
    procedure PageControl1DblClick(Sender: TObject);
    procedure IEAddress1KeyPress(Sender: TObject; var Key: Char);
    procedure IEAddress1UrlSelected(Sender: TObject; Url: WideString;
      var Cancel: Boolean);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure btnWindowClick(Sender: TObject);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
    procedure btnPageCloseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure RzBmpButton8Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RzBmpButton5Click(Sender: TObject);
  private
    FWindowState: TWindowState;
    FInitialized: boolean;
    { Private declarations }
    procedure DownloadCompleteEvent(Sender: TObject);
    procedure NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure CommandStateChangeEvent(Sender: TObject; Command: Integer; Enable: WordBool);
    procedure GetHostInfoEvent(Sender: TCustomEmbeddedWB;
      var pInfo: TDOCHOSTUIINFO);
    procedure GetExternalEvent(Sender: TCustomEmbeddedWB;
      var ppDispatch: IDispatch);
    procedure WindowClosingEvent(ASender: TObject;
      IsChildWindow: WordBool; var Cancel: WordBool);
    procedure WindowSetHeightEvent(ASender: TObject;
      Height: Integer);
    procedure WindowSetLeftEvent(ASender: TObject; Left: Integer);
    procedure WindowSetTopEvent(ASender: TObject; Top: Integer);
    procedure WindowSetWidthEvent(ASender: TObject; Width: Integer);
    procedure MoveEvent(Sender: TCustomEmbeddedWB; cx, cy: Integer);
    procedure MoveByEvent(Sender: TCustomEmbeddedWB; cx, cy: Integer);
    procedure WindowSetResizableEvent(ASender: TObject;
      Resizable: WordBool);
    procedure VisibleEvent(ASender: TObject; Visible: WordBool);
    procedure ResizeEvent(Sender: TCustomEmbeddedWB; cx,
      cy: Integer);
    procedure ResizeBorderEvent(Sender: TCustomEmbeddedWB;
      const prcBorder: PRect; const pUIWindow: IOleInPlaceUIWindow;
      const fRameWindow: LongBool);
    procedure ResizeByEvent(Sender: TCustomEmbeddedWB; cx,
      cy: Integer);
    procedure BusyWaitEvent(Sender: TEmbeddedWB;
      AStartTime: Cardinal; var TimeOut: Cardinal; var Cancel: Boolean);
    procedure NewWindow2Event(Sender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
    procedure NewWindow3Event(ASender: TObject;
      var ppDisp: IDispatch; var Cancel: WordBool; dwFlags: Cardinal;
      const bstrUrlContext, bstrUrl: WideString);
    procedure ScriptErrorEvent(Sender: TObject; ErrorLine,
      ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
      var ScriptErrorAction: TScriptErrorAction);
    procedure StatusTextChangeEvent(Sender: TObject; const Text: WideString);
    procedure ProgressChangeEvent(ASender: TObject; Progress,
      ProgressMax: Integer);
    procedure TitleChange(ASender: TObject;
      const Text: WideString);
    procedure SetWindowState(const Value: TWindowState);
    procedure SetInitialized(const Value: boolean);
  protected
    m_Rect: TRect;
    m_bCreatedManually: Boolean;
    m_bResizable: Boolean;
    m_bFullScreen: Boolean;
    BufList:TStringList;
    procedure UpdateControls(_EWB:TEmbeddedWB=nil);
    procedure LoadXsm(_url:string;appId:string;TimeOut:integer=15000);
    procedure LoadUrl(_url:string;appId:string;TimeOut:integer=15000);
    function CheckUrlExists(_url:TurlToken):boolean;
    function CheckNewTabBrowser(_url:TurlToken):boolean;
    function CreateNewTabBrowser(UrlToken: TurlToken):TTabSheetEx;
    procedure destroyTabBrowser;
    procedure pageButtonSort;
    procedure PageButtonClick(Sender:TObject);
    procedure RzInit(var Message: TMessage); message WM_BROWSER_INIT;
    procedure WMDisplayChange(var Message: TMessage); message WM_DISPLAYCHANGE;
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure FullScreen;
    procedure OpenHome;
    //扫描监控
    procedure StartListener;
    procedure StopListener;
    procedure WMCopyData(var Message: TMessage); message WM_COPYDATA;
    procedure WMSendBarcode(var Msg:TMessage); message WM_SEND_BARCODE;

  public
    { Public declarations }
    hotKeyid:integer;


    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  Install:boolean;
    
    property Initialized:boolean read FInitialized write SetInitialized;
  end;

var
  frmBrowerForm: TfrmBrowerForm;

implementation
uses  javaScriptExt,NSHandler,uUCFactory,uDLLFactory,uTokenFactory,WinSvc;
{$R *.dfm}
const
  SZ_BOOL: array[boolean] of string = ('False', 'True');
var
  Factory: IClassFactory;
  InternetSession: IInternetSession;
  jsExt: IjavaScriptExt;

  iBorderThick,
  iBorderSize,
  iCaptSize: Integer;

procedure TfrmBrowerForm.UpdateControls(_EWB:TEmbeddedWB=nil);
var
  TabEx: TTabSheetEx;
  w:widestring;
  i:integer;
begin
  if _EWB=nil then
     TabEx := (PageControl1.ActivePage as TTabSheetEx)
  else
     begin
       for i:=0 to PageControl1.PageCount-1 do
         begin
           if TTabSheetEx(PageControl1.Pages[i]).EWB=_EWB then
              begin
                TabEx := TTabSheetEx(PageControl1.Pages[i]);
                break;
              end;
         end;
     end;
  if TabEx=nil then Exit;
  if not IEAddress1.Focused then
     begin
       case TabEx.url.appFlag of
       0:begin
           if isRspcn(TabEx.url.url) then
              IEAddress1.Text := TabEx.url.showUrl
           else
              IEAddress1.Text := TabEx.EWB.LocationURL;
         end;
       1:begin
           IEAddress1.Text := TabEx.url.showUrl;
         end;
       end;
     end;
  case TabEx.url.appFlag of
  0:begin
      w := TabEx.LocationName;
      Caption := w+' -- rspcn';
      TabEx.url.url := TabEx.EWB.LocationURL;
      TabEx.Caption := copy(w,1,10);
      TabEx.button.Caption := TabEx.Caption;
     // BtnForward.Enabled := TabEx.CanForward;
      btnBack.Enabled := TabEx.CanBack;
      btnGo.Enabled := true;
     // btnStop.Enabled := TabEx.CanStop;
    end;
  1:begin
      Caption := TabEx.LocationName+' -- rspcn';
      TabEx.Caption := TabEx.LocationName;
      TabEx.button.Caption := TabEx.Caption;
     // BtnForward.Enabled := false;
      btnBack.Enabled := false;
      btnGo.Enabled := false;
     // btnStop.Enabled := false;
    end;
  end;
end;

procedure TfrmBrowerForm.DownloadCompleteEvent(Sender: TObject);
begin
//  TEmbeddedWB(Sender).SetFocusToDoc;
  UpdateControls(TEmbeddedWB(Sender));
end;

function TfrmBrowerForm.CreateNewTabBrowser(UrlToken: TurlToken):TTabSheetEx;
var
  TabSheetEx:TTabSheetEx;
begin
  result := nil;
  TabSheetEx := TTabSheetEx.Create(PageControl1);
  TabSheetEx.Caption := '新建页';
  TabSheetEx.button := TrzBmpButton.Create(pageTab);
  TabSheetEx.button.Parent := pageTab;
  TabSheetEx.button.Top := 0;
  TabSheetEx.button.AllowAllUp := true;
  TabSheetEx.button.Bitmaps.Up.Assign(button_close.Picture);
  TabSheetEx.button.Bitmaps.Down.Assign(button_active.Picture);
  TabSheetEx.button.GroupIndex := 1;
  TabSheetEx.button.OnClick := PageButtonClick;
  TabSheetEx.TabVisible := false;
  TabSheetEx.xsmLogined := false;
  with TabSheetEx do
  begin
    PageControl := PageControl1;
    Caption := 'Loading...';
    TabSheetEx.url := UrlToken;
    case UrlToken.appFlag of
    0:begin
        EWB := TEmbeddedWB.Create(TabSheetEx);
        TOleControl(TabSheetEx.EWB).Parent := TabSheetEx;
        PageControl1.ActivePage := TabSheetEx;
        result := TabSheetEx;
        with EWB do
        begin
          EnableMessageHandler := True;
          RegisterAsBrowser := True;
          LoadSettings;
          Align := alClient;
          Visible := True;
          OnStatusTextChange := StatusTextChangeEvent;
          OnNewWindow2 := NewWindow2Event;
          OnNewWindow3 := NewWindow3Event;
          OnDownloadComplete := DownloadCompleteEvent;
          OnScriptError := ScriptErrorEvent;
          OnGetHostInfo := GetHostInfoEvent;
          OnCommandStateChange := CommandStateChangeEvent;
          OnGetExternal := GetExternalEvent;
          OnProgressChange := ProgressChangeEvent;
          OnWindowClosing := WindowClosingEvent;
          OnWindowSetHeight := WindowSetHeightEvent;
          OnWindowSetLeft := WindowSetLeftEvent;
          OnWindowSetTop := WindowSetTopEvent;
          OnWindowSetWidth := WindowSetWidthEvent;
          OnNavigateComplete2 := NavigateComplete2;
          OnTitleChange := TitleChange;
          OnMove := MoveEvent;
          OnMoveBy := MoveByEvent;
          OnWindowSetResizable := WindowSetResizableEvent;
          OnVisible := VisibleEvent;
          OnResize := ResizeEvent;
          OnResizeBorder := ResizeBorderEvent;
          OnResizeBy := ResizeByEvent;
          OnBusyWait := BusyWaitEvent;
        end;
      end;
    1:begin
        EWB := nil;
        result := TabSheetEx;
        //WebForm := TScrollBox.Create(TabSheetEx);
        //WebForm.Parent := TabSheetEx;
        //WebForm.BorderStyle := bsNone;
        //WebForm.Align := alClient;
        PageControl1.ActivePage := TabSheetEx;
      end;
    end;
  end;
  pagebuttonSort;
end;

procedure TfrmBrowerForm.btnStopClick(Sender: TObject);
begin
//  btnStop.Enabled := False;
//  (PageControl1.ActivePage as TTabSheetEx).EWB.Stop;
end;

procedure TfrmBrowerForm.btnGoClick(Sender: TObject);
var
  tabEx:TTabSheetEx;
begin
  inherited;
  if PageControl1=nil then Exit;
  tabEx := PageControl1.ActivePage as TTabSheetEx;
  tabEx.EWB.Refresh;
end;

procedure TfrmBrowerForm.CommandStateChangeEvent(Sender: TObject; Command: Integer; Enable: WordBool);
const
  CSC_UPDATECOMMANDS = $FFFFFFFF;
begin
  case TOleEnum(Command) of
    CSC_NAVIGATEBACK:
      ((Sender as TEmbeddedWB).Owner as TTabSheetEx).CanBack := Enable;
    CSC_NAVIGATEFORWARD:
      ((Sender as TEmbeddedWB).Owner as TTabSheetEx).CanForward := Enable;
    CSC_UPDATECOMMANDS:
      ((Sender as TEmbeddedWB).Owner as TTabSheetEx).CanStop := (Sender as TEmbeddedWB).Busy;
  end;
end;

procedure TfrmBrowerForm.NewWindow2Event(Sender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
begin
  Cancel := true;
end;

procedure TfrmBrowerForm.PageControl1Change(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmBrowerForm.StatusTextChangeEvent(Sender: TObject;
  const Text: WideString);
begin
//  m_bStatusBar.SimpleText := Text;
end;

// http://mp3.baidu.com/m?tn=baidump3&ct=134217728&lm=-1&li=500&word=%CE%D2%C3%C7%CB%B5%BA%C3%B5%C4+%D5%C5%F6%A6%D3%B1


procedure TfrmBrowerForm.btnForwardClick(Sender: TObject);
begin
//  btnForward.Enabled := False;
//  (PageControl1.ActivePage as TTabSheetEx).EWB.GoForward;


end;

procedure TfrmBrowerForm.btnBackClick(Sender: TObject);
begin
  btnBack.Enabled := False;
  (PageControl1.ActivePage as TTabSheetEx).EWB.GoBack;

end;

procedure TfrmBrowerForm.PageControl1Close(Sender: TObject;
  var AllowClose: Boolean);
begin
  destroyTabBrowser;
end;

procedure TfrmBrowerForm.serachTextEnter(Sender: TObject);
begin
  serachText.SelectAll;
end;

procedure TfrmBrowerForm.RzInit(var Message: TMessage);
begin
  jsExt :=  TjavaScriptExt.Create;
  CoGetClassObject(Class_NSHandler, CLSCTX_SERVER, nil, IClassFactory, Factory);
  CoInternetGetSession(0, InternetSession, 0);
  InternetSession.RegisterNameSpace(Factory, Class_NSHandler, 'rspcn', 0, nil, 0);
  m_Rect := Rect(0, 0, 0, 0);
  m_bResizable := True;
  m_bFullScreen := true;
  dllFactory := TDLLFactory.Create;
  hotKeyid:=GlobalAddAtom('rspcn');//'Hotkey'名字可以随便取
  RegisterHotKey(Handle,hotKeyid,0,VK_PAUSE);
  StartListener;
  Initialized := true;
  Timer1.Enabled := true;
  case Message.LParam of
  1:begin
      ParentWindow := FindWindow('Progman',nil);
      m_bFullScreen := true;
      FullScreen;
      Show;
      LoadUrl('about:blank','');
    end;
  0:begin
      m_bFullScreen := false;
      setWindowState(wsMaximized);
      Show;
      OpenHome
    end;
  end;
  UpdateControls;
end;

procedure TfrmBrowerForm.destroyTabBrowser;
var
  tabEx:TTabSheetEx;
begin
  if PageControl1.PageCount<=1 then Exit;
  case tabEx.url.appFlag of
  0:tabEx.EWB.Free;
  1:begin
      if not dllFactory.close(tabEx.url) then Exit;
    end;
  end;

  tabEx := (PageControl1.ActivePage as TTabSheetEx);
  if PageControl1.ActivePageIndex>0 then
  PageControl1.ActivePageIndex := PageControl1.ActivePageIndex -1 else
  PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;

  tabEx.button.Free;
  tabEx.Free;
  pagebuttonSort;
  UpdateControls;
end;

procedure TfrmBrowerForm.PageControl1DblClick(Sender: TObject);
begin
//  destroyTabBrowser;
end;

procedure TfrmBrowerForm.LoadUrl(_url: string;appId:string;TimeOut:integer=15000);
var
  urlToken:TurlToken;
begin
  _url := trim(_url);
  IEAddress1.Text := _url;
  RzProgressBar1.Percent := 1;
  RzProgressBar1.Visible := true;
  IEAddress1.Visible := false;
  try
    if isRspcn(_url) then
       begin
         urlToken := decodeUrl(_url);
       end
    else
       begin
         urlToken.appFlag := 0;
         urlToken.url := _url;
       end;
    if urlToken.appFlag=0 then
       urlToken.appId := appId;
    if (urlToken.appFlag>0) and not token.logined then
        begin
           OpenHome;
           Exit;
        end;
    if CheckUrlExists(urlToken) then Exit;
    if PageControl1.ActivePage=nil then
       CreateNewTabBrowser(urlToken)
    else
       begin
         if (urlToken.appFlag<>0) or CheckNewTabBrowser(urlToken) then
            begin
              CreateNewTabBrowser(urlToken);
            end
       end;
    with (PageControl1.ActivePage as TTabSheetEx) do
    case url.appFlag of
    0:begin
        EWB.Go(urlToken.url,TimeOut);
        if EWB.CanFocus then EWB.SetFocusToDoc;
      end;
    1:begin
        if dllFactory.open(url,(PageControl1.ActivePage as TTabSheetEx).Handle) then
           LocationName := dllFactory.getTitle(urlToken)
        else
           destroyTabBrowser;
        UpdateControls;
      end;
    end;
    ActiveControl := nil;
  finally
     RzProgressBar1.Percent := 100;
     RzProgressBar1.Visible := false;
     IEAddress1.Visible := true;
  end;
end;

procedure TfrmBrowerForm.IEAddress1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then LoadUrl(IEAddress1.Text,'');
end;

procedure TfrmBrowerForm.IEAddress1UrlSelected(Sender: TObject;
  Url: WideString; var Cancel: Boolean);
begin
  LoadUrl(Url,'');
end;

procedure TfrmBrowerForm.ScriptErrorEvent(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ScriptErrorAction: TScriptErrorAction);
begin
  //MessageBox(Handle,Pchar(ErrorMessage),'kdjfd',MB_OK);
  //m_bStatusBar.SimpleText := '出错了->>'+ErrorMessage;
end;

procedure TfrmBrowerForm.RzBmpButton4Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmBrowerForm.GetHostInfoEvent(Sender: TCustomEmbeddedWB;
  var pInfo: TDOCHOSTUIINFO);
begin
    pInfo.cbSize   :=   sizeof(TDOCHOSTUIINFO); 
    pInfo.dwFlags   :=   DOCHOSTUIFLAG_DIALOG   or   DOCHOSTUIFLAG_DISABLE_HELP_MENU 
                                     or   DOCHOSTUIFLAG_NO3DBORDER; 

    pInfo.dwDoubleClick   :=   DOCHOSTUIDBLCLK_DEFAULT; 
end;

constructor TfrmBrowerForm.Create(AOwner: TComponent);
begin
  inherited;
  BufList := TStringList.Create;
end;

destructor TfrmBrowerForm.Destroy;
begin
  if Initialized then
     begin
        StopListener;
        Timer1.Enabled := false;
        Initialized := false;
        UnRegisterHotKey(handle,hotKeyid);
        GlobalDeleteAtom(hotKeyid);
        jsExt := nil;
        if assigned(InternetSession) then InternetSession.UnregisterNameSpace(Factory, 'rspcn');
        dllFactory.Free;
     end;
  BufList.Free;
  inherited;
end;

procedure TfrmBrowerForm.GetExternalEvent(Sender: TCustomEmbeddedWB;
  var ppDispatch: IDispatch);
begin
  ppDispatch := jsExt;
end;


procedure TfrmBrowerForm.ResizeEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
//  SetBounds(Left, Top, Width, Height);
end;

procedure TfrmBrowerForm.ResizeBorderEvent(Sender: TCustomEmbeddedWB;
  const prcBorder: PRect; const pUIWindow: IOleInPlaceUIWindow;
  const fRameWindow: LongBool);
begin

end;

procedure TfrmBrowerForm.ResizeByEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
end;

procedure TfrmBrowerForm.VisibleEvent(ASender: TObject; Visible: WordBool);
var
  dwClHeight: Integer;
begin
  if not m_bFullScreen then begin
    if m_bResizable then begin
      BorderStyle := bsSizeable;
      BorderIcons := BorderIcons + [biMaximize];
    end
    else begin
      BorderStyle := bsSingle;
      BorderIcons := BorderIcons - [biMaximize];
    end;
    HandleNeeded;

    if (m_Rect.Right > 0) and (m_Rect.Bottom > 0) then begin
      dwClHeight := 0;

      if pnlAddressBar.Visible then
        dwClHeight := pnlAddressBar.Height;

        //if m_bStatusBar.Visible then
        //  dwClHeight := dwClHeight + m_bStatusBar.Height;

      m_Rect.Bottom := (iBorderSize + iBorderThick) * 2 + iCaptSize + dwClHeight + m_Rect.Bottom;
      m_Rect.Right := (iBorderSize + iBorderThick) * 2 + m_Rect.Right;

      if m_bResizable then begin
        inc(m_Rect.Bottom, 2);
        inc(m_Rect.Right, 2);
      end;

      SetBounds(m_Rect.Left, m_Rect.Top, m_Rect.Right, m_Rect.Bottom);
    end;

  end
  else
  begin
    FullScreen;
  end;

  Self.Visible := Visible;
end;

procedure TfrmBrowerForm.WindowClosingEvent(ASender: TObject;
  IsChildWindow: WordBool; var Cancel: WordBool);
var
  i:integer;
  tabEx:TTabSheetEx;
begin
  if PageControl1.PageCount=1 then
     begin
       Close;
       Exit;
     end;
  for i:=0 to PageControl1.PageCount-1 do
     begin
       tabEx := (PageControl1.Pages[i] as TTabSheetEx);
       if tabEx.EWB=ASender then
          begin
            destroyTabBrowser;
            break;
          end;
     end;
end;

procedure TfrmBrowerForm.WindowSetHeightEvent(ASender: TObject;
  Height: Integer);
begin
//  m_Rect.Bottom := Height;

end;

procedure TfrmBrowerForm.WindowSetLeftEvent(ASender: TObject;
  Left: Integer);
begin
//  m_Rect.Left := Left;

end;

procedure TfrmBrowerForm.WindowSetTopEvent(ASender: TObject; Top: Integer);
begin
//  m_Rect.Top := Top;

end;

procedure TfrmBrowerForm.WindowSetWidthEvent(ASender: TObject;
  Width: Integer);
begin
//  m_Rect.Right := Width;

end;

procedure TfrmBrowerForm.WindowSetResizableEvent(ASender: TObject;
  Resizable: WordBool);
begin
//  m_bResizable := Resizable;

end;

procedure TfrmBrowerForm.MoveByEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
//  SetBounds(Left + cx, Top + cy, Width, Height);

end;

procedure TfrmBrowerForm.MoveEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
//  SetBounds(cX, cY, Width, Height);
  
end;

procedure TfrmBrowerForm.FullScreen;
var i:integer;
begin
  if m_bFullScreen then
     begin
        BorderStyle := bsNone;
        //WindowState := wsNormal;
        pnlAddressBar.Visible := false;
        //m_bStatusBar.Visible := false;
        PageControl1.ShowFullFrame := false;
        //for i:=0 to PageControl1.PageCount-1 do  PageControl1.Pages[i].TabVisible := false;
        BoundsRect := Screen.WorkAreaRect;
     end
  else
     begin
        if m_bResizable then begin
          BorderStyle := bsSizeable;
          BorderIcons := BorderIcons + [biMaximize];
          //WindowState := wsMaximized;
        end
        else begin
          BorderStyle := bsSingle;
          BorderIcons := BorderIcons - [biMaximize];
        end;
        pnlAddressBar.Visible := true;
        //m_bStatusBar.Visible := true;
        //PageControl1.ShowFullFrame := true;
        for i:=0 to PageControl1.PageCount-1 do  PageControl1.Pages[i].TabVisible := true;
     end
end;

procedure TfrmBrowerForm.WMDisplayChange(var Message: TMessage);
begin
  if m_bFullScreen then FullScreen;
end;

procedure TfrmBrowerForm.ProgressChangeEvent(ASender: TObject; Progress,
  ProgressMax: Integer);
begin
end;

procedure TfrmBrowerForm.BusyWaitEvent(Sender: TEmbeddedWB;
  AStartTime: Cardinal; var TimeOut: Cardinal; var Cancel: Boolean);
begin
  RzProgressBar1.Percent := (GetTickCount-AStartTime)*100 div TimeOut;
end;

procedure TfrmBrowerForm.NewWindow3Event(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool; dwFlags: Cardinal;
  const bstrUrlContext, bstrUrl: WideString);
var
  urlToken:TurlToken;
  curSheet:TTabSheetEx;
begin
  curSheet := (PageControl1.ActivePage as TTabSheetEx);
  if assigned(curSheet) and assigned(curSheet.EWB) and ((dwFlags=6) or (dwFlags=262150)) then
     begin
        if IsRspcn(bstrUrl) then
           begin
             urlToken := decodeUrl(bstrUrl);
             if CheckUrlExists(urlToken) then Exit;
             curSheet := CreateNewTabBrowser(urlToken);
             if Assigned(curSheet) then
                begin
                  case urlToken.appFlag of
                  0:begin
                      Cancel := true;
                      curSheet.EWB.Go(urlToken.url,15);
                      ppdisp := curSheet.EWB.Application;
                      if curSheet.EWB.CanFocus then curSheet.EWB.SetFocusToDoc;
                    end
                  else
                    begin
                      Cancel := true;
                      if dllFactory.open(curSheet.url,curSheet.Handle) then
                         begin
                           curSheet.LocationName := dllFactory.getTitle(urlToken);
                         end
                      else
                         destroyTabBrowser;
                      UpdateControls;
                    end;
                  end;
                end;
           end
        else
           begin
              urlToken.appFlag := 0;
              urlToken.url := curSheet.EWB.LocationURL;
              urlToken.showUrl := curSheet.EWB.LocationURL;
              curSheet := CreateNewTabBrowser(urlToken);
              if Assigned(curSheet) then
                 begin
                    curSheet.EWB.Go(urlToken.url,15);
                    ppdisp := curSheet.EWB.Application;
                 end;
           end;
     end
  else
     Cancel := true;
end;

procedure TfrmBrowerForm.OpenHome;
var
  tabEx:TtabSheetEx;
  url:TurlToken;
begin
  if PageControl1.PageCount=0 then
     begin
       if token.logined then
          LoadUrl('rspcn://local-in/index.html','home')
       else
          LoadUrl('rspcn://local-in/login.html','home');
     end
  else
     begin
       tabEx := PageControl1.Pages[0] as TtabSheetEx;
       PageControl1.ActivePageIndex := 0;
       pageButtonSort;
       if token.logined then
          begin
            url := decodeUrl('rspcn://built-in/index.html');
            tabEx.EWB.Go(url.url,15000);
          end
       else
          begin
            url := decodeUrl('rspcn://built-in/login.html');
            tabEx.EWB.Go(url.url,15000);
          end;
     end;
end;

procedure TfrmBrowerForm.Button2Click(Sender: TObject);
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml:string;
  url:string;
begin
 IEAddress1.Text := UCFactory.xsmUC+'users/dologin/up?j_username=620902102160&j_password='+md5(md5('1')+serachText.Text);
end;

procedure TfrmBrowerForm.SetWindowState(const Value: TWindowState);
begin
  FWindowState := Value;
  case Value of
  wsMaximized:begin
     inherited WindowState := wsNormal;
     SetBounds(Screen.WorkAreaLeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
  end;
  wsNormal:begin
     inherited WindowState := wsNormal;
     SetBounds(Screen.WorkAreaLeft,Screen.WorkAreaTop,1024,700);
  end
  else
     inherited WindowState := wsMinimized;
  end;
end;

procedure TfrmBrowerForm.RzBmpButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBrowerForm.btnWindowClick(Sender: TObject);
begin
  case FWindowState of
  wsMaximized:begin
     SetWindowState(wsNormal);
  end;
  wsNormal:begin
     SetWindowState(wsMaximized);
  end
  end;

end;

procedure TfrmBrowerForm.RzTrayIcon1RestoreApp(Sender: TObject);
begin
  SetWindowState(wsMaximized);
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TfrmBrowerForm.pageButtonSort;
var
  i,w:integer;
begin
  if token.logined then w := tool_left.Width+1 else w := 0;
  btnPageClose.Visible := false;
  for i:=0 to pageControl1.PageCount-1 do
    begin
      TTabSheetEx(pageControl1.Pages[i]).button.Left := w;
      w := w + TTabSheetEx(pageControl1.Pages[i]).button.Width;
      TTabSheetEx(pageControl1.Pages[i]).button.Down := (pageControl1.ActivePageIndex = i);
      if TTabSheetEx(pageControl1.Pages[i]).button.Down then
         TTabSheetEx(pageControl1.Pages[i]).button.Font.Color := clBlack
      else
         TTabSheetEx(pageControl1.Pages[i]).button.Font.Color := clWhite;
      if (pageControl1.ActivePageIndex = i) and (i>0) then
         begin
           btnPageClose.Visible := true;
           btnPageClose.Top := 5;
           btnPageClose.Left := w - 20;
           btnPageClose.BringToFront;
         end;
    end;
  pageTab.Repaint;
end;

procedure TfrmBrowerForm.PageButtonClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to pageControl1.PageCount-1 do
    begin
      if TtabSheetEx(PageControl1.Pages[i]).button=Sender then
         begin
            pageControl1.ActivePageIndex := i;
            TtabSheetEx(PageControl1.Pages[i]).button.Down := true;
         end;
    end;
  pageButtonSort;
  UpdateControls;
end;

procedure TfrmBrowerForm.btnPageCloseClick(Sender: TObject);
begin
  destroyTabBrowser;
end;

function TfrmBrowerForm.CheckUrlExists(_url: TurlToken): boolean;
var
  i:integer;
begin
  result := false;
  if _url.appId = '' then Exit;
  for i:=0 to PageControl1.PageCount -1 do
    begin
      if lowercase(TTabSheetEx(PageControl1.Pages[i]).url.appId)=lowercase(_url.appId) then
         begin
           if (_url.appFlag>0) and (_url.moduname<>TTabSheetEx(PageControl1.Pages[i]).url.moduname) then continue;
           result := true;
           PageControl1.ActivePageIndex := i;
           pageButtonSort;
           break;
         end;
    end;
end;

procedure TfrmBrowerForm.Timer1Timer(Sender: TObject);
begin
  if token.logined and not toolleft.Visible and (pageControl1.PageCount>0) then
     begin
       TTabSheetEx(pageControl1.Pages[0]).button.Bitmaps.Down.Assign(home_down.Picture);
       pageButtonSort;
     end
  else
  if not token.logined and toolleft.Visible and (pageControl1.PageCount>0) then
     begin
       TTabSheetEx(pageControl1.Pages[0]).button.Bitmaps.Down.Assign(button_active.Picture);
       pageButtonSort;
     end;
  toolleft.Visible := token.logined;
  if token.logined then
     begin
       if token.tenantName<>'' then
          lblUserName.Caption := token.tenantName
       else
          lblUserName.Caption := token.username;
       if token.online then
          lblUserName.Caption := lblUserName.Caption+'(联机)'
       else
          lblUserName.Caption := lblUserName.Caption+'(脱机)';
     end
  else
     lblUserName.Caption := '现代卷烟零售终端';
end;

procedure TfrmBrowerForm.LoadXsm(_url: string;appId:string; TimeOut: integer);
var
  urlToken:TurlToken;
  w:integer;
begin
  _url := trim(_url);
  IEAddress1.Text := _url;
  RzProgressBar1.Percent := 1;
  RzProgressBar1.Visible := true;
  IEAddress1.Visible := false;
  try
    urlToken.appFlag := 0;
    urlToken.url := _url;
    urlToken.appId := appId;
    if CheckUrlExists(urlToken) then Exit;
    if not UcFactory.xsmLogined then
        begin
           OpenHome;
           Exit;
        end;
    if PageControl1.ActivePage=nil then
       CreateNewTabBrowser(urlToken)
    else
       begin
         if (PageControl1.ActivePageIndex=0) or CheckNewTabBrowser(urlToken) then
            begin
              CreateNewTabBrowser(urlToken);
            end;
       end;

    with (PageControl1.ActivePage as TTabSheetEx) do
    case url.appFlag of
    0:begin
        if not xsmLogined then
           begin
              if not UcFactory.xsmLogined then UcFactory.xsmLogin(token.xsmCode,token.xsmPWD);
              w := 0;
              while w<3 do
              begin
                inc(w);
                EWB.Go(UcFactory.xsmUC+'tokenconsumer?xmlStr='+UcFactory.xsmSignature,15000);
                xsmLogined := UcFactory.chkLogin(EWB);
                if xsmLogined then break;
              end;
              if not xsmLogined then
                 begin
                   UcFactory.xsmLogined := false;
                   Raise Exception.Create('新商盟认证失败，请点击重试！');
                 end;
           end;
        EWB.Go(_url,TimeOut);
        if EWB.CanFocus then EWB.SetFocusToDoc;
      end;
    end;
    ActiveControl := nil;
  finally
     RzProgressBar1.Percent := 100;
     RzProgressBar1.Visible := false;
     IEAddress1.Visible := true;
  end;
end;

procedure TfrmBrowerForm.RzBmpButton6Click(Sender: TObject);
begin
  LoadXsm('http://sntest.xinshangmeng.com/ecweb/order/cgtHome.htm','xsmorder',15000);
end;

procedure TfrmBrowerForm.RzBmpButton7Click(Sender: TObject);
begin
  LoadXsm('http://txzpt.xinshangmeng.com/t/index.php?app=home&mod=User&act=index','chart',15000);
end;

procedure TfrmBrowerForm.RzBmpButton8Click(Sender: TObject);
begin
  LoadXsm('http://sntest.xinshangmeng.com/ecweb/order/cgtHome.htm','xsmorder',15000);
end;

procedure TfrmBrowerForm.RzBmpButton3Click(Sender: TObject);
begin
  OpenHome;
end;

procedure TfrmBrowerForm.FormResize(Sender: TObject);
begin
  dllFactory.resize;
end;

procedure TfrmBrowerForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tabEx:TTabSheetEx;
  childWnd:THandle;
  Message: TWMKeyDown;
begin
  inherited;
  if PageControl1=nil then Exit;
  tabEx := PageControl1.ActivePage as TTabSheetEx;
  if tabEx=nil then Exit;
  if tabEx.url.appFlag=0 then Exit;
  childWnd := GetWindow(tabEx.Handle,GW_CHILD);
  while childWnd>0 do
    begin
      Message.Msg := WM_KEYDOWN;
      Message.KeyData := 0;
      Message.CharCode := Key;
      Message.Unused := 0;
      SendMessage(childWnd,Message.Msg,TMessage(Message).WParam,Message.KeyData);
      childWnd := GetWindow(childWnd,GW_HWNDNEXT);
    end;
end;


procedure TfrmBrowerForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tabEx:TTabSheetEx;
  childWnd:THandle;
  Message: TWMKeyDown;
begin
  inherited;
  if PageControl1=nil then Exit;
  tabEx := PageControl1.ActivePage as TTabSheetEx;
  if tabEx=nil then Exit;
  if tabEx.url.appFlag=0 then Exit;
  childWnd := GetWindow(tabEx.Handle,GW_CHILD);
  while childWnd>0 do
    begin
      Message.Msg := WM_KEYUP;
      Message.KeyData := 0;
      Message.CharCode := Key;
      Message.Unused := 0;
      SendMessage(childWnd,Message.Msg,TMessage(Message).WParam,Message.KeyData);
      childWnd := GetWindow(childWnd,GW_HWNDNEXT);
    end;
end;

procedure TfrmBrowerForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  tabEx:TTabSheetEx;
  childWnd:THandle;
  Message: TWMKeyDown;
begin
  inherited;
  if PageControl1=nil then Exit;
  tabEx := PageControl1.ActivePage as TTabSheetEx;
  if tabEx=nil then Exit;
  if tabEx.url.appFlag=0 then Exit;
  childWnd := GetWindow(tabEx.Handle,GW_CHILD);
  while childWnd>0 do
    begin
      Message.Msg := WM_CHAR;
      Message.KeyData := 0;
      Message.CharCode := word(Key);
      Message.Unused := 0;
      SendMessage(childWnd,Message.Msg,TMessage(Message).WParam,Message.KeyData);
      childWnd := GetWindow(childWnd,GW_HWNDNEXT);
    end;
end;

procedure TfrmBrowerForm.WMHotKey(var Msg: TWMHotKey);
var
  tabEx:TTabSheetEx;
  childWnd:THandle;
  Message: TWMKeyDown;
begin
  if (Msg.HotKey=hotKeyId) and not (fsModal in Screen.ActiveForm.FormState) then
     begin
        if IsIconic(Application.Handle) then
           begin
             Application.Restore;
             SetForegroundWindow(application.Handle);
           end;
        SetWindowState(wsMaximized);
        SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
        SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
        if PageControl1=nil then Exit;
        tabEx := PageControl1.ActivePage as TTabSheetEx;
        if tabEx=nil then Exit;
        if tabEx.url.appFlag=0 then
           begin
             tabEx.EWB.SetFocusToDoc;
             Exit;
           end;
        childWnd := GetWindow(tabEx.Handle,GW_CHILD);
        while childWnd>0 do
          begin
            windows.SetFocus(childWnd); 
            Message.Msg := WM_KEYDOWN;
            Message.KeyData := 0;
            Message.CharCode := VK_PAUSE;
            Message.Unused := 0;
            SendMessage(childWnd,Message.Msg,TMessage(Message).WParam,Message.KeyData);
            childWnd := GetWindow(childWnd,GW_HWNDNEXT);
          end;
     end;
end;

procedure TfrmBrowerForm.SetInitialized(const Value: boolean);
begin
  FInitialized := Value;
end;

function TfrmBrowerForm.CheckNewTabBrowser(_url: TurlToken): boolean;
begin
  result := true;
  if lowercase(TTabSheetEx(PageControl1.ActivePage).url.appId)=lowercase(_url.appId) then
     begin
       if (_url.appFlag>0) and (_url.moduname<>TTabSheetEx(PageControl1.ActivePage).url.moduname) then Exit;
       result := false;
     end;
end;

function TfrmBrowerForm.Install: boolean;
begin
  jsExt :=  TjavaScriptExt.Create;
  CoGetClassObject(Class_NSHandler, CLSCTX_SERVER, nil, IClassFactory, Factory);
  CoInternetGetSession(0, InternetSession, 0);
  InternetSession.RegisterNameSpace(Factory, Class_NSHandler, 'rspcn', 0, nil, 0);

  jsExt := nil;
  if assigned(InternetSession) then InternetSession.UnregisterNameSpace(Factory, 'rspcn');
end;

procedure TfrmBrowerForm.NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  UpdateControls(TEmbeddedWB(ASender));
end;

procedure TfrmBrowerForm.RzBmpButton5Click(Sender: TObject);
begin
  LoadUrl('rspcn://shop.dll/TfrmSysDefine','shop.dll');
end;

procedure TfrmBrowerForm.TitleChange(ASender: TObject;
  const Text: WideString);
var
  i:integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
   begin
     if TTabSheetEx(PageControl1.Pages[i]).EWB=ASender then
        begin
          TTabSheetEx(PageControl1.Pages[i]).LocationName := Text;
          break;
        end;
   end;
  UpdateControls;
end;

function StartService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  lpServiceArgVectors: PChar;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if (hService = 0) and (GetLastError = ERROR_SERVICE_DOES_NOT_EXIST) then
      Exception.Create('The specified service does not exist');
    if hService <> 0 then
    try
      lpServiceArgVectors := nil;
      Result := WinSvc.StartService(hService, 0, PChar(lpServiceArgVectors));
      if not Result and (GetLastError = ERROR_SERVICE_ALREADY_RUNNING) then
        Result := True;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

function StopService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  SvcStatus: TServiceStatus;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if Result then
    try  //停止并卸载服务;
      Result := ControlService(hService, SERVICE_CONTROL_STOP, SvcStatus);
      //删除服务，这一句可以不要;
      //DeleteService(hService);
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

procedure TfrmBrowerForm.StartListener;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'hook.cfg');
  try
    F.WriteInteger('rspcn','hWnd',handle);
    F.WriteInteger('rspcn','flag',9001);
  finally
    F.Free;
  end;
end;

procedure TfrmBrowerForm.WMCopyData(var Message: TMessage);
var
  buf:PCopyDataStruct;
  s:string;
begin
  buf := PCopyDataStruct(Message.lParam);
  case buf^.dwData of
  9001:begin
      setLength(s,buf^.cbData);
      move(Pchar(buf.lpData)^,s[1],buf^.cbData);
      BufList.Add(s);
      PostMessage(handle,WM_SEND_BARCODE,0,0); 
    end;
  end;
end;

procedure TfrmBrowerForm.StopListener;
begin
end;

procedure TfrmBrowerForm.WMSendBarcode(var Msg: TMessage);
begin
  if IsIconic(Application.Handle) then
     begin
       Application.Restore;
       SetForegroundWindow(application.Handle);
     end;
  SetWindowState(wsMaximized);
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

initialization
  iCaptSize := GetSystemMetrics(SM_CYCAPTION);
  iBorderSize := GetSystemMetrics(SM_CXBORDER);
  iBorderThick := GetSystemMetrics(SM_CXSIZEFRAME);
end.

