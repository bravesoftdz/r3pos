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
  RzPanel, Messages, MSHTML, IEConst, RzPrgres,rspcn_TLB,EncDec, msxml, ComObj, urlParser;
const
  WM_BROWSER_INIT =WM_USER+1000;
  
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
  end;

type
  TfrmBrowerForm = class(TForm)
    pnlAddressBar: TPanel;
    m_bStatusBar: TStatusBar;
    btnBack: TRzBmpButton;
    btnForward: TRzBmpButton;
    btnGo: TRzBmpButton;
    btnStop: TRzBmpButton;
    RzPanel1: TRzPanel;
    IEAddress1: TIEAddress;
    RzPanel2: TRzPanel;
    serachText: TEdit;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    ImageList1: TImageList;
    RzPanel3: TRzPanel;
    PageControl1: TRzPageControl;
    RzProgressBar1: TRzProgressBar;
    RzPanel4: TRzPanel;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadCompleteEvent(Sender: TObject);
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
  protected
    m_Rect: TRect;
    m_bCreatedManually: Boolean;
    m_bResizable: Boolean;
    m_bFullScreen: Boolean;
    procedure UpdateControls;
    procedure LoadUrl(_url:string;TimeOut:integer=15000);
    function CreateNewTabBrowser(UrlToken: TurlToken):TTabSheetEx;
    procedure destroyTabBrowser;
    procedure RzInit(var Message: TMessage); message WM_BROWSER_INIT;
    procedure WMDisplayChange(var Message: TMessage); message WM_DISPLAYCHANGE;
    procedure FullScreen;
    procedure OpenHome;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmBrowerForm: TfrmBrowerForm;

implementation
uses  javaScriptExt,NSHandler,uUCFactory,uDLLFactory;
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

procedure TfrmBrowerForm.UpdateControls;
var
  TabEx: TTabSheetEx;
  w:widestring;
begin
  TabEx := (PageControl1.ActivePage as TTabSheetEx);
  if TabEx=nil then Exit;
  if not IEAddress1.Focused then
     begin
       case TabEx.url.appFlag of
       0:begin
           IEAddress1.Text := TabEx.EWB.LocationURL;
         end;
       1:begin
           IEAddress1.Text := encodeUrl(TabEx.url);
         end;
       end;
     end;
  case TabEx.url.appFlag of
  0:begin
      w := TabEx.EWB.LocationName;
      Caption := TabEx.EWB.LocationName+' -- rspcn';
      PageControl1.ActivePage.Caption := copy(w,1,10);
      BtnForward.Enabled := TabEx.CanForward;
      btnBack.Enabled := TabEx.CanBack;
      btnStop.Enabled := TabEx.CanStop;
    end;
  1:begin
      Caption := TabEx.LocationName+' -- rspcn';
      PageControl1.ActivePage.Caption := TabEx.LocationName;
      BtnForward.Enabled := false;
      btnBack.Enabled := false;
      btnStop.Enabled := false;
    end;
  end;
end;

procedure TfrmBrowerForm.DownloadCompleteEvent(Sender: TObject);
begin
  TEmbeddedWB(Sender).SetFocusToDoc;
  UpdateControls;
end;

function TfrmBrowerForm.CreateNewTabBrowser(UrlToken: TurlToken):TTabSheetEx;
var
  TabSheetEx:TTabSheetEx;
begin
  result := nil;
  TabSheetEx := TTabSheetEx.Create(PageControl1);
  TabSheetEx.Caption := '新建页';
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
end;

procedure TfrmBrowerForm.btnStopClick(Sender: TObject);
begin
  btnStop.Enabled := False;
  (PageControl1.ActivePage as TTabSheetEx).EWB.Stop;
end;

procedure TfrmBrowerForm.btnGoClick(Sender: TObject);
begin
  LoadUrl(IEAddress1.Text);
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
  //Cancel := true;
end;

procedure TfrmBrowerForm.PageControl1Change(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmBrowerForm.StatusTextChangeEvent(Sender: TObject;
  const Text: WideString);
begin
  m_bStatusBar.SimpleText := Text;
end;

// http://mp3.baidu.com/m?tn=baidump3&ct=134217728&lm=-1&li=500&word=%CE%D2%C3%C7%CB%B5%BA%C3%B5%C4+%D5%C5%F6%A6%D3%B1


procedure TfrmBrowerForm.btnForwardClick(Sender: TObject);
begin
  btnForward.Enabled := False;
  (PageControl1.ActivePage as TTabSheetEx).EWB.GoForward;


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
  case Message.LParam of
  1:begin
      ParentWindow := FindWindow('Progman',nil);
      m_bFullScreen := true;
      FullScreen;
      Show;
      LoadUrl('about:blank');
    end;
  0:begin
      m_bFullScreen := false;
      WindowState := wsMaximized;
      Show;
      LoadUrl('rspcn://built-in/index.htm');
    end;
  end;
  UpdateControls;
end;

procedure TfrmBrowerForm.destroyTabBrowser;
var
  tabEx:TTabSheetEx;
begin
  if PageControl1.PageCount<=1 then Exit;
  tabEx := (PageControl1.ActivePage as TTabSheetEx);
  if PageControl1.ActivePageIndex>0 then
  PageControl1.ActivePageIndex := PageControl1.ActivePageIndex -1 else
  PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;

  case tabEx.url.appFlag of
  0:tabEx.EWB.Free;
  1:begin
      dllFactory.close(tabEx.url);
    end;
  end;
  
  tabEx.Free;
  UpdateControls;
end;

procedure TfrmBrowerForm.PageControl1DblClick(Sender: TObject);
begin
//  destroyTabBrowser;
end;

procedure TfrmBrowerForm.LoadUrl(_url: string;TimeOut:integer=15000);
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
       urlToken := decodeUrl(_url)
    else
       urlToken.appFlag := 0;
    if PageControl1.ActivePage=nil then
       CreateNewTabBrowser(urlToken)
    else
       begin
         if urlToken.appFlag<>0 then
            begin
              CreateNewTabBrowser(urlToken);
            end;
       end;
    with (PageControl1.ActivePage as TTabSheetEx) do
    case url.appFlag of
    0:EWB.Go(_url,TimeOut);
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
  if Key = #13 then LoadUrl(IEAddress1.Text);
end;

procedure TfrmBrowerForm.IEAddress1UrlSelected(Sender: TObject;
  Url: WideString; var Cancel: Boolean);
begin
  LoadUrl(Url);
end;

procedure TfrmBrowerForm.ScriptErrorEvent(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ScriptErrorAction: TScriptErrorAction);
begin
  m_bStatusBar.SimpleText := '出错了->>'+ErrorMessage;
end;

procedure TfrmBrowerForm.RzBmpButton4Click(Sender: TObject);
begin
  LoadUrl('www.19e.cn');
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
  jsExt :=  TjavaScriptExt.Create;
  CoGetClassObject(Class_NSHandler, CLSCTX_SERVER, nil, IClassFactory, Factory);
  CoInternetGetSession(0, InternetSession, 0);
  InternetSession.RegisterNameSpace(Factory, Class_NSHandler, 'rspcn', 0, nil, 0);
  m_Rect := Rect(0, 0, 0, 0);
  m_bResizable := True;
  m_bFullScreen := true;
  dllFactory := TDLLFactory.Create;
end;

destructor TfrmBrowerForm.Destroy;
begin
  jsExt := nil;
  if assigned(InternetSession) then
     InternetSession.UnregisterNameSpace(Factory, 'rspcn');
  dllFactory.Free;
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
  SetBounds(Left, Top, Width, Height);
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

        if m_bStatusBar.Visible then
          dwClHeight := dwClHeight + m_bStatusBar.Height;

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
            tabEx.EWB.Free;
            tabEx.Free;
            if PageControl1.Pages[i]= tabEx then
               begin
                  if PageControl1.ActivePageIndex>0 then
                     PageControl1.ActivePageIndex := PageControl1.ActivePageIndex -1 else
                     PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
                  UpdateControls;
               end;
            break;
          end;
     end;
end;

procedure TfrmBrowerForm.WindowSetHeightEvent(ASender: TObject;
  Height: Integer);
begin
  m_Rect.Bottom := Height;

end;

procedure TfrmBrowerForm.WindowSetLeftEvent(ASender: TObject;
  Left: Integer);
begin
  m_Rect.Left := Left;

end;

procedure TfrmBrowerForm.WindowSetTopEvent(ASender: TObject; Top: Integer);
begin
  m_Rect.Top := Top;

end;

procedure TfrmBrowerForm.WindowSetWidthEvent(ASender: TObject;
  Width: Integer);
begin
  m_Rect.Right := Width;

end;

procedure TfrmBrowerForm.WindowSetResizableEvent(ASender: TObject;
  Resizable: WordBool);
begin
  m_bResizable := Resizable;

end;

procedure TfrmBrowerForm.MoveByEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
  SetBounds(Left + cx, Top + cy, Width, Height);

end;

procedure TfrmBrowerForm.MoveEvent(Sender: TCustomEmbeddedWB; cx,
  cy: Integer);
begin
  SetBounds(cX, cY, Width, Height);
  
end;

procedure TfrmBrowerForm.FullScreen;
var i:integer;
begin
  if m_bFullScreen then
     begin
        BorderStyle := bsNone;
        WindowState := wsNormal;
        pnlAddressBar.Visible := false;
        m_bStatusBar.Visible := false;
        PageControl1.ShowFullFrame := false;
        for i:=0 to PageControl1.PageCount-1 do  PageControl1.Pages[i].TabVisible := false;
        BoundsRect := Screen.WorkAreaRect;
     end
  else
     begin
        if m_bResizable then begin
          BorderStyle := bsSizeable;
          BorderIcons := BorderIcons + [biMaximize];
          WindowState := wsMaximized;
        end
        else begin
          BorderStyle := bsSingle;
          BorderIcons := BorderIcons - [biMaximize];
        end;
        pnlAddressBar.Visible := true;
        m_bStatusBar.Visible := true;
        PageControl1.ShowFullFrame := true;
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
  if assigned(curSheet) and assigned(curSheet.EWB) and (dwFlags in [6]) then
     begin
        if IsRspcn(bstrUrl) then
           begin
             urlToken := decodeUrl(bstrUrl);
             curSheet := CreateNewTabBrowser(urlToken);
             if Assigned(curSheet) then
                begin
                  case urlToken.appFlag of
                  0:begin
                      curSheet.EWB.Go(urlToken.url,15);
                      ppdisp := curSheet.EWB.Application;
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

procedure TfrmBrowerForm.Button1Click(Sender: TObject);
begin
  UCFactory.xsmLogin('620902102291','1');
end;

procedure TfrmBrowerForm.OpenHome;
begin

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

initialization
  iCaptSize := GetSystemMetrics(SM_CYCAPTION);
  iBorderSize := GetSystemMetrics(SM_CXBORDER);
  iBorderThick := GetSystemMetrics(SM_CXSIZEFRAME);
end.

