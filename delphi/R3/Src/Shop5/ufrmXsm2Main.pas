unit ufrmXsm2Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, StdCtrls, jpeg,
  RzBmpBtn, RzLabel, RzBckgnd, Buttons, RzPanel, ufrmBasic, ToolWin,
  RzButton, ZBase, ufrmInstall, RzStatus, RzTray, ShellApi, ZdbFactory,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalc, ObjCommon,RzGroupBar,ZDataSet, ImgList, RzTabs, OleCtrls, SHDocVw,
  DB, ZAbstractRODataset, ZAbstractDataset,ufrmHintMsg, RzSplit, Mask,
  RzEdit, RzListVw, uMMClient, uMMUtil, ZLogFile;
const
  WM_LOGIN_REQUEST=WM_USER+10;
  WM_DESKTOP_REQUEST=WM_USER+11;
  WM_CHECK_MSG=WM_USER+2565;
type
  TfrmXsm2Main = class(TfrmMain)
    mnuWindow: TMenuItem;
    Panel5: TPanel;
    Image3: TImage;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    fdsfds1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N49: TMenuItem;
    N51: TMenuItem;
    N48: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N55: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N78: TMenuItem;
    RzVersionInfo: TRzVersionInfo;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    Timer1: TTimer;
    N83: TMenuItem;
    N84: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N91: TMenuItem;
    N92: TMenuItem;
    N50: TMenuItem;
    N93: TMenuItem;
    N23: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N73: TMenuItem;
    N85: TMenuItem;
    N94: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    N99: TMenuItem;
    N90: TMenuItem;
    N22: TMenuItem;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    Panel8: TPanel;
    ImageList2: TImageList;
    actfrmMeaUnits: TAction;
    actfrmDutyInfoList: TAction;
    actfrmRoleInfoList: TAction;
    actfrmDeptInfoList: TAction;
    actfrmUsers: TAction;
    actfrmBrandInfo: TAction;
    actfrmStockOrderList: TAction;
    actfrmSalesOrderList: TAction;
    actfrmChangeOrderList1: TAction;
    actfrmChangeOrderList2: TAction;
    actfrmGoodsSort: TAction;
    actfrmGoodsInfoList: TAction;
    actfrmCodeInfo3: TAction;
    actfrmSortInfo: TAction;
    actfrmImplInfo: TAction;
    actfrmAreaInfo: TAction;
    actfrmSaleStyle: TAction;
    actfrmSettleCode: TAction;
    actfrmShopGroup: TAction;
    actfrmRecvOrderList: TAction;
    actfrmPayOrderList: TAction;
    actfrmClient: TAction;
    actfrmSupplier: TAction;
    actfrmSalRetuOrderList: TAction;
    actfrmStkRetuOrderList: TAction;
    actfrmPosMain: TAction;
    actfrmPriceGradeInfo: TAction;
    actfrmSalIndentOrderList: TAction;
    actfrmStkIndentOrderList: TAction;
    actfrmInvoice: TAction;
    actfrmCustomer: TAction;
    actfrmCostCalc: TAction;
    actfrmSysDefine: TAction;
    actfrmDaysClose: TAction;
    actfrmMonthClose: TAction;
    actfrmCloseForDay: TAction;
    actfrmPriceOrderList: TAction;
    actfrmCheckOrderList: TAction;
    actfrmTransOrderList: TAction;
    actfrmDbOrderList: TAction;
    actfrmShopInfoList: TAction;
    actfrmXsmBrowser: TAction;
    actfrmAccount: TAction;
    actfrmIoroOrderList1: TAction;
    actfrmIoroOrderList2: TAction;
    actfrmDevFactory: TAction;
    actfrmIntfSetup: TAction;
    actfrmStorageTracking: TAction;
    actfrmRckMng: TAction;
    actfrmCheckTablePrint: TAction;
    actfrmJxcTotalReport: TAction;
    actfrmStockDayReport: TAction;
    actfrmSaleDayReport: TAction;
    actfrmChange1DayReport: TAction;
    actfrmChange2DayReport: TAction;
    actfrmLockScreen: TAction;
    actfrmStorageDayReport: TAction;
    actfrmRecvDayReport: TAction;
    actfrmRckDayReport: TAction;
    actfrmRelation: TAction;
    ImageList3: TImageList;
    toolButton: TRzBmpButton;
    actfrmPayDayReport: TAction;
    actfrmPayAbleReport: TAction;
    actfrmRecvAbleReport: TAction;
    actfrmDbDayReport: TAction;
    actfrmGodsRunningReport: TAction;
    tlbPage: TPopupMenu;
    tlbClose: TMenuItem;
    N33: TMenuItem;
    N103: TMenuItem;
    actfrmIoroDayReport: TAction;
    actfrmMessage: TAction;
    actfrmNewPaperReader: TAction;
    actfrmQuestionnaire: TAction;
    actfrmInLocusOrderList: TAction;
    actfrmOutLocusOrderList: TAction;
    actfrmDownIndeOrder: TAction;
    actfrmRecvForDay: TAction;
    actfrmImpeach: TAction;
    actfrmClearData: TAction;
    actfrmSaleAnaly: TAction;
    actfrmNetForOrder: TAction;
    actfrmSaleManSaleReport: TAction;
    actfrmClientSaleReport: TAction;
    actfrmSaleTotalReport: TAction;
    actfrmStgTotalReport: TAction;
    actfrmStockTotalReport: TAction;
    RzTrayIcon1: TRzTrayIcon;
    actfrmSaleMonthTotalReport: TAction;
    RzPanel1: TRzPanel;
    Panel4: TPanel;
    Image5: TImage;
    Image6: TImage;
    Panel2: TPanel;
    Image4: TImage;
    Image2: TImage;
    RzBmpButton9: TRzBmpButton;
    RzBmpButton10: TRzBmpButton;
    RzEdit1: TRzEdit;
    lblDayInfo: TRzLabel;
    Image9: TImage;
    lblNetStatus: TRzLabel;
    RzPanel9: TRzPanel;
    Panel9: TPanel;
    rzTool: TPanel;
    Image21: TImage;
    Panel12: TPanel;
    Image14: TImage;
    Panel3: TPanel;
    rzToolButton: TPanel;
    actfrmXsmNet: TAction;
    Panel1: TPanel;
    Image12: TImage;
    rzLeft: TRzPanel;
    rzLeft_1: TRzPanel;
    Bar1: TRzPanel;
    RzPanel5: TRzPanel;
    page_01: TRzBmpButton;
    page_02: TRzBmpButton;
    page_03: TRzBmpButton;
    page_04: TRzBmpButton;
    Bar2: TRzPanel;
    RzPanel10: TRzPanel;
    page_11: TRzBmpButton;
    page_12: TRzBmpButton;
    page_13: TRzBmpButton;
    page_14: TRzBmpButton;
    RzPanel2: TRzPanel;
    Panel11: TPanel;
    split: TImage;
    CA_MODULE: TZQuery;
    actfrmRimNet: TAction;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Panel10: TPanel;
    tbDesktop: TRzBmpButton;
    Image10: TImage;
    actfrmDefineStateInfo: TAction;
    actfrmOpenDesk: TAction;
    actfrmSyncAll: TAction;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    lblUserInfo: TLabel;
    imgOffline: TImage;
    actfrmGoodsMonth: TAction;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    actfrmInitGuide: TAction;
    RzBmpButton6: TRzBmpButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N68Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N90Click(Sender: TObject);
    procedure RzBmpButton10Click(Sender: TObject);
    procedure RzBmpButton9Click(Sender: TObject);
    procedure actfrmMeaUnitsExecute(Sender: TObject);
    procedure actfrmDutyInfoListExecute(Sender: TObject);
    procedure actfrmRoleInfoListExecute(Sender: TObject);
    procedure actfrmDeptInfoListExecute(Sender: TObject);
    procedure actfrmUsersExecute(Sender: TObject);
    procedure actfrmBrandInfoExecute(Sender: TObject);
    procedure actfrmStockOrderListExecute(Sender: TObject);
    procedure actfrmSalesOrderListExecute(Sender: TObject);
    procedure actfrmChangeOrderList1Execute(Sender: TObject);
    procedure actfrmChangeOrderList2Execute(Sender: TObject);
    procedure actfrmGoodsInfoListExecute(Sender: TObject);
    procedure actfrmGoodsSortExecute(Sender: TObject);
    procedure actfrmCodeInfo3Execute(Sender: TObject);
    procedure actfrmSortInfoExecute(Sender: TObject);
    procedure actfrmImplInfoExecute(Sender: TObject);
    procedure actfrmAreaInfoExecute(Sender: TObject);
    procedure actfrmSaleStyleExecute(Sender: TObject);
    procedure actfrmSettleCodeExecute(Sender: TObject);
    procedure actfrmShopGroupExecute(Sender: TObject);
    procedure actfrmRecvOrderListExecute(Sender: TObject);
    procedure actfrmPayOrderListExecute(Sender: TObject);
    procedure actfrmClientExecute(Sender: TObject);
    procedure actfrmSupplierExecute(Sender: TObject);
    procedure actfrmSalRetuOrderListExecute(Sender: TObject);
    procedure actfrmStkRetuOrderListExecute(Sender: TObject);
    procedure actfrmPosMainExecute(Sender: TObject);
    procedure actfrmPriceGradeInfoExecute(Sender: TObject);
    procedure actfrmSalIndentOrderListExecute(Sender: TObject);
    procedure actfrmStkIndentOrderListExecute(Sender: TObject);
    procedure actfrmInvoiceExecute(Sender: TObject);
    procedure actfrmCustomerExecute(Sender: TObject);
    procedure actfrmCostCalcExecute(Sender: TObject);
    procedure actfrmSysDefineExecute(Sender: TObject);
    procedure actfrmDaysCloseExecute(Sender: TObject);
    procedure actfrmMonthCloseExecute(Sender: TObject);
    procedure actfrmCloseForDayExecute(Sender: TObject);
    procedure actfrmPriceOrderListExecute(Sender: TObject);
    procedure actfrmCheckOrderListExecute(Sender: TObject);
    procedure actfrmDbOrderListExecute(Sender: TObject);
    procedure actfrmShopInfoListExecute(Sender: TObject);
    procedure actfrmXsmBrowserExecute(Sender: TObject);
    procedure actfrmAccountExecute(Sender: TObject);
    procedure actfrmTransOrderListExecute(Sender: TObject);
    procedure actfrmDevFactoryExecute(Sender: TObject);
    procedure actfrmIoroOrderList1Execute(Sender: TObject);
    procedure actfrmIoroOrderList2Execute(Sender: TObject);
    procedure actfrmCheckTablePrintExecute(Sender: TObject);
    procedure actfrmRckMngExecute(Sender: TObject);
    procedure actfrmJxcTotalReportExecute(Sender: TObject);
    procedure actfrmStockDayReportExecute(Sender: TObject);
    procedure actfrmSaleDayReportExecute(Sender: TObject);
    procedure actfrmChange1DayReportExecute(Sender: TObject);
    procedure actfrmChange2DayReportExecute(Sender: TObject);
    procedure actfrmLockScreenExecute(Sender: TObject);
    procedure actfrmStorageDayReportExecute(Sender: TObject);
    procedure actfrmRckDayReportExecute(Sender: TObject);
    procedure actfrmRelationExecute(Sender: TObject);
    procedure actfrmRecvDayReportExecute(Sender: TObject);
    procedure actfrmPayDayReportExecute(Sender: TObject);
    procedure actfrmRecvAbleReportExecute(Sender: TObject);
    procedure actfrmPayAbleReportExecute(Sender: TObject);
    procedure actfrmStorageTrackingExecute(Sender: TObject);
    procedure actfrmDbDayReportExecute(Sender: TObject);
    procedure actfrmGodsRunningReportExecute(Sender: TObject);
    procedure tlbCloseClick(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure actfrmIoroDayReportExecute(Sender: TObject);
    procedure actfrmMessageExecute(Sender: TObject);
    procedure actfrmNewPaperReaderExecute(Sender: TObject);
    procedure actfrmQuestionnaireExecute(Sender: TObject);
    procedure RzBmpButton11Click(Sender: TObject);
    procedure RzBmpButton12Click(Sender: TObject);
    procedure RzBmpButton13Click(Sender: TObject);
    procedure RzBmpButton14Click(Sender: TObject);
    procedure RzBmpButton15Click(Sender: TObject);
    procedure actfrmInLocusOrderListExecute(Sender: TObject);
    procedure actfrmOutLocusOrderListExecute(Sender: TObject);
    procedure lblUserInfoClick(Sender: TObject);
    procedure actfrmDownIndeOrderExecute(Sender: TObject);
    procedure actfrmRecvForDayExecute(Sender: TObject);
    procedure rzUserInfoClick(Sender: TObject);
    procedure actfrmImpeachExecute(Sender: TObject);
    procedure actfrmClearDataExecute(Sender: TObject);
    procedure actfrmSaleAnalyExecute(Sender: TObject);
    procedure actfrmNetForOrderExecute(Sender: TObject);
    procedure actfrmSaleManSaleReportExecute(Sender: TObject);
    procedure actfrmClientSaleReportExecute(Sender: TObject);
    procedure actfrmSaleTotalReportExecute(Sender: TObject);
    procedure actfrmStgTotalReportExecute(Sender: TObject);
    procedure actfrmStockTotalReportExecute(Sender: TObject);
    procedure RzTrayIcon1LButtonDblClick(Sender: TObject);
    procedure actfrmSaleMonthTotalReportExecute(Sender: TObject);
    procedure rzSizeLeft_1Resize(Sender: TObject);
    procedure actfrmXsmNetExecute(Sender: TObject);
    procedure splitClick(Sender: TObject);
    procedure page_03Click(Sender: TObject);
    procedure page_04Click(Sender: TObject);
    procedure page_02Click(Sender: TObject);
    procedure page_12Click(Sender: TObject);
    procedure page_13Click(Sender: TObject);
    procedure page_14Click(Sender: TObject);
    procedure tbDesktopClick(Sender: TObject);
    procedure page_11Click(Sender: TObject);
    procedure page_01Click(Sender: TObject);
    procedure actfrmRimNetExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure actfrmCalcStorageExecute(Sender: TObject);
    procedure actfrmStorageOptionDefineExecute(Sender: TObject);
    procedure actfrmOpenDeskExecute(Sender: TObject);
    procedure actfrmSyncAllExecute(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure RzTrayIcon1MinimizeApp(Sender: TObject);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
    procedure actfrmGoodsMonthExecute(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
    procedure actfrmInitGuideExecute(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
  private
    { Private declarations }
    FList:TList;
    PageList:TList;
    FLogined: boolean;
    frmInstall:TfrmInstall;
    FLoging: boolean;
    FSystemShutdown: boolean;
    sflag:string;
    IsXsm:Boolean;
    FCA_MODULE: TZQuery;
    procedure DoLoadMsg(Sender:TObject);
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure WMQUERYENDSESSION(var msg:Tmessage);Message  WM_QUERYENDSESSION;
    procedure wm_Login(var Message: TMessage); message WM_LOGIN_REQUEST;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure wm_message(var Message: TMessage); message MSC_MESSAGE;
    procedure wm_check(var Message: TMessage); message WM_CHECK_MSG;
    procedure mc_login(var Message: TMessage); message MM_LOGIN;
    procedure mc_quit(var Message: TMessage); message MM_QUIT;
    procedure SetLogined(const Value: boolean);
    function  CheckVersion:boolean;
    function  XsmRegister:boolean;
    function  ConnectToDb:boolean;
    function  mmcInit:boolean;
    //p1 -rsp
    //p2 连接串
    //p3 企业号
    //p4 产品号
    //p5 行业号
    procedure InitXsm;
    procedure InitRim;
    function  ConnectToRsp:boolean;
    function  ConnectToXsm:boolean;
    function  UpdateDbVersion:boolean;
    procedure SetLoging(const Value: boolean);
    procedure SetSystemShutdown(const Value: boolean);
    procedure InitTenant;
    function SortToolButton:boolean;
    procedure UnSelect;
  public
    { Publicdeclarations }
    destructor Destroy; override;
    procedure LoadMenu(subname:string='');
    procedure LoadPic32;
    procedure LoadFrame;
    procedure InitVersioin;
    function GetDeskFlag:string;
    procedure CheckEnabled;
    procedure DoConnectError(Sender:TObject);
    function Login(Locked:boolean=false;Exited:boolean=true):boolean;
    procedure WriteAction(s:string;flag:integer);
    procedure AddFrom(form:TForm);
    procedure AddModule(mid:string;Action:TAction);
    procedure RemoveFrom(form:TForm);
    procedure Clear;
    property Logined:boolean read FLogined write SetLogined;
    property Loging:boolean read FLoging write SetLoging;
    property SystemShutdown:boolean read FSystemShutdown write SetSystemShutdown;
  end;

var
  frmXsm2Main: TfrmXsm2Main;
implementation
uses
  uDsUtil,uFnUtil,ufrmLogo,uTimerFactory,ufrmTenant,ufrmXsm2Desk, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogin,
  ufrmDesk,ufrmPswModify,ufrmDutyInfoList,ufrmRoleInfoList,ufrmMeaUnits,ufrmDeptInfo,ufrmUsers,ufrmStockOrderList,
  ufrmSalesOrderList,ufrmChangeOrderList,ufrmGoodsSortTree,ufrmGoodsSort,ufrmGoodsInfoList,ufrmCodeInfo,ufrmRecvOrderList,
  ufrmPayOrderList,ufrmClient,ufrmSupplier,ufrmSalRetuOrderList,ufrmStkRetuOrderList,ufrmPosMain,uDevFactory,ufrmPriceGradeInfo,
  ufrmSalIndentOrderList,ufrmStkIndentOrderList,ufrmInvoice,ufrmCustomer,ufrmCostCalc,ufrmSysDefine,ufrmPriceOrderList,
  ufrmCheckOrderList,ufrmCloseForDay,ufrmDbOrderList,ufrmShopInfoList,ufrmIEWebForm,ufrmAccount,ufrmTransOrderList,ufrmDevFactory,
  ufrmIoroOrderList,ufrmCheckTablePrint,ufrmRckMng,ufrmJxcTotalReport,ufrmStockDayReport,ufrmDeptInfoList,ufrmSaleDayReport,
  ufrmChangeDayReport,ufrmStorageDayReport,ufrmRckDayReport,ufrmRelation,uSyncFactory,ufrmRecvDayReport,ufrmPayDayReport,
  ufrmRecvAbleReport,ufrmPayAbleReport,ufrmStorageTracking,ufrmDbDayReport,ufrmGodsRunningReport,uCaFactory,ufrmIoroDayReport,
  ufrmMessage,ufrmNewsPaperReader,ufrmShopInfo,ufrmQuestionnaire,ufrmInLocusOrderList,ufrmOutLocusOrderList,uPrainpowerJudge,
  ufrmDownStockOrder,ufrmRecvPosList,ufrmHostDialog,ufrmImpeach,ufrmClearData,EncDec,ufrmSaleAnaly,ufrmClientSaleReport,
  ufrmSaleManSaleReport,ufrmSaleTotalReport,ufrmStgTotalReport,ufrmStockTotalReport,ufrmPrgBar,ufrmSaleMonthTotalReport,
  ufrmXsmIEBrowser,ufrmRimIEBrowser,ufrmOptionDefine,ufrmInitialRights,uAdvFactory,ufrmXsmLogin,ufrmNetLogin,ufrmInitGuide,
  uLoginFactory,ufrmGoodsMonth,uSyncThread,uCommand,uMsgBox,ufrmSaleAnalyMessage;
  
{$R *.dfm}

function CheckXsmPassWord(uid, pwd: string): boolean;
begin
  xsm_username := uid;
  xsm_password := pwd;
  result := frmXsmIEBrowser.XsmLogin(true);
end;

procedure TfrmXsm2Main.FormActivate(Sender: TObject);
begin
  inherited;
  //if not systemShutdown and not Application.Terminated then WindowState := wsMaximized;
end;

procedure TfrmXsm2Main.FormCreate(Sender: TObject);
var
  F:TextFile;
  i:integer;
begin
  inherited;
  frmXsmIEBrowser := nil;
  frmRimIEBrowser := nil;
  XsmCheckPassWord := CheckXsmPassWord;
  IsXsm := false;
  FormBgk := true;
  LoadPic32;
  PageList := TList.Create;
  frmLogo := TfrmLogo.Create(nil);
  frmPrgBar := TfrmPrgBar.Create(nil);
  FList := TList.Create;
  ForceDirectories(ExtractFilePath(ParamStr(0))+'temp');
  ForceDirectories(ExtractFilePath(ParamStr(0))+'debug');
  SystemShutdown := false;
  Loging :=false;
  frmInstall := TfrmInstall.Create(self);
  screen.OnActiveFormChange := DoActiveChange;
  AssignFile(F,ExtractFilePath(ParamStr(0))+'hook.cfg');
  rewrite(f);
  try
    writeln(f,handle);
    writeln(f,WM_DESKTOP_REQUEST);
  finally
    closefile(f);
  end;
  RzVersionInfo.FilePath := ParamStr(0);
  LoadFrame;
  TimerFactory := nil;
end;

procedure TfrmXsm2Main.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  LoginFactory.Logout;
  Timer1.Enabled := false;
  UpdateTimer.Enabled := false;
  if frmXsmIEBrowser<>nil then frmXsmIEBrowser.free;
  if frmRimIEBrowser<>nil then frmRimIEBrowser.free;
  if TimerFactory<>nil then TimerFactory.Free;
  frmLogo.Free;
  frmPrgBar.Free;
  if frmInstall<>nil then frmInstall.free;
  screen.OnActiveFormChange := nil;
  for i:=0 to FList.Count -1 do
    begin
      TRzBmpButton(FList[i]).OnClick := nil;
      TObject(FList[i]).Free;
    end;
  inherited;
  FList.Free;
  PageList.Free;
end;

procedure TfrmXsm2Main.AddFrom(form: TForm);
var
  button:TrzBmpButton;
begin
  button := TrzBmpButton.Create(rzToolButton);
  button.GroupIndex := 999;
  button.AllowAllUp := true;
  button.Bitmaps.Up.Assign(toolButton.Bitmaps.Up);
  button.Bitmaps.Down.Assign(toolButton.Bitmaps.Down);
  button.Font.Assign(toolButton.Font);
  button.Tag := Integer(Pointer(form));
  button.OnClick := DoActiveForm;
  button.Visible := false;
  button.Parent := rzToolButton;
//  button.PopupMenu := tlbPage;
  button.Top := 3;
  FList.Add(button);
  Clear;
  page_11.down := true;
  SortToolButton;
  button.Caption := form.Caption;
  TfrmBasic(Form).OnFreeForm := DoFreeForm;
  TfrmBasic(Form).PageHandle := Integer(button);
  button.Down := true;
end;

procedure TfrmXsm2Main.RemoveFrom(form: TForm);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if integer(FList[i])=integer(pointer(form)) then
         begin
           TObject(FList[i]).Free;
           FList.Delete(i);
           break;
         end;
    end;
  SortToolButton;
end;

procedure TfrmXsm2Main.DoActiveForm(Sender: TObject);
begin
  if TrzBmpButton(Sender).tag=0 then Exit;
  try
    TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
    TForm(TrzBmpButton(Sender).tag).BringToFront;
    TrzBmpButton(Sender).Down := true;
  except
    on E:Exception do
       LogFile.AddLogFile(0,'<DoActiveForm>:'+E.Message);
  end;
end;
function ToolSort(Item1, Item2: Pointer): Integer;
begin
  if TrzBmpButton(Item1).Tag > TrzBmpButton(Item2).Tag then
     result := 1
  else
  if TrzBmpButton(Item1).Tag < TrzBmpButton(Item2).Tag then
     result := -1
  else
     result := 0;
end;
function TfrmXsm2Main.SortToolButton:boolean;
var
  i,w,wl:Integer;
  button,DefButton:TrzBmpButton;
begin
  w := 0;
  wl:= 0;
  DefButton := nil;
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Visible := false;
    end;
//  FList.Sort(@ToolSort);
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      if page_11.Down and (button.GroupIndex <> 999) then continue;
      if not page_11.Down and (button.GroupIndex <> 888) then continue;
      button.Visible := false;
      button.Top := 3;
      if w=0 then
         button.Left := 0
      else
         button.Left := TrzBmpButton(FList[wl]).Left+TrzBmpButton(FList[wl]).width+5;
      button.Visible := true;
      if w=0 then DefButton := button;
      wl := i;
      inc(w);
    end;
  if DefButton=nil then
    begin
      PostMessage(Handle,WM_DESKTOP_REQUEST,0,0);//  tbDesktopClick(tbDesktop);
      result := false;
    end
  else
    begin
      if page_11.Down then Exit;
      if DefButton<>nil then DefButton.Down := true;
      if DefButton<>nil then DefButton.onClick(DefButton);
      result := true;
    end;
end;

procedure TfrmXsm2Main.DoActiveChange(Sender: TObject);
var
  i:integer;
  SOn:TNotifyEvent;
begin
  try
    if not Logined then Exit;
    if screen.ActiveForm = nil then Exit;
    if screen.ActiveForm = frmMain then
       Exit;
    if screen.ActiveForm = frmDesk then
       Exit;
    if (screen.ActiveForm.FormStyle=fsMDIChild) then
    begin
    for i:=0 to FList.Count -1 do
      begin
        if (Integer(FList[i])=TfrmBasic(screen.ActiveForm).PageHandle) then
           begin
             TrzBmpButton(FList[i]).Down := true;
             Exit;
           end;
      end;
    end;
  except
    on E:Exception do
       LogFile.AddLogFile(0,'<DoActiveChange>:'+E.Message);
  end;
end;

procedure TfrmXsm2Main.DoFreeForm(Sender: TObject);
function SortR3Button:boolean;
var
  i,w,wl:Integer;
  button:TrzBmpButton;
begin
  if not page_11.Down then Exit;
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Visible := false;
    end;
  w := 0;
  wl:= 0;
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      if page_11.Down and (button.GroupIndex <> 999) then continue;
      if not page_11.Down and (button.GroupIndex <> 888) then continue;
      button.Visible := false;
      button.Top := 3;
      if w=0 then
         button.Left := 0
      else
         button.Left := TrzBmpButton(FList[wl]).Left+TrzBmpButton(FList[wl]).width+5;
      button.Visible := true;
      wl := i;
      inc(w);
    end;
end;
var
  i:integer;
begin
  try
    for i:=0 to FList.Count -1 do
      begin
        if TrzBmpButton(FList[i]).tag=integer(pointer(Sender)) then
           begin
             TrzBmpButton(FList[i]).Tag := 0;
             TObject(FList[i]).Free;
             FList.Delete(i);
             break;
           end;
      end;
    SortR3Button;
    if not Closeing then PostMessage(Handle,WM_DESKTOP_REQUEST,0,0);
  except
    on E:Exception do
       LogFile.AddLogFile(0,'<DoFreeForm>:'+E.Message);
  end;
end;

function TfrmXsm2Main.CheckVersion:boolean;
function GetFileNameFromURL(url: string): string;
var ts : TStrings;
begin
  //从url取得文件名
  ts := TStringList.create;
  try
    ts.Delimiter :='/';
    ts.DelimitedText := url;
    if ts.Count > 0 then
       Result := ts[ts.Count - 1];
  finally
    ts.Free;
  end;
end;
var
  filename:string;
  r:integer;
  frmInstall:TfrmInstall;
  CaUpgrade:TCaUpgrade;
begin
  result := false;
  try
  CaUpgrade := CaFactory.CheckUpgrade(inttostr(Global.TENANT_ID),ProductId,RzVersionInfo.FileVersion);
  if CaUpgrade.UpGrade in [1,2] then
  begin
     if (ShowMsgBox(pchar('系统检测的新版本'+CaUpgrade.Version+'，是否立即升级？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       if (CaUpgrade.UpGrade=1) then
          begin
            ShowMsgBox(pchar('你使用的软件版本过旧，没有升级无法继续使用.'),'友情提示...',MB_OK+MB_ICONQUESTION);
            Exit
          end else CaUpgrade.UpGrade := 3;
     end;
  end
  else
     CaUpgrade.UpGrade := 3;
  if CaUpgrade.UpGrade<>3 then
    begin
      frmInstall := TfrmInstall.Create(Application);
      try
        frmInstall.Show;
        frmInstall.CurVersion := RzVersionInfo.FileVersion;
        frmInstall.NewVersion := CaUpgrade.Version;
        frmInstall.Update;
        filename := GetFileNameFromURL(CaUpgrade.URL);
        frmInstall.Url := copy(CaUpgrade.URL,1,length(CaUpgrade.URL)-length(filename));
        frmInstall.Path := ExtractFilePath(ParamStr(0));
        if frmInstall.DownFile(filename) then
           begin
             result := false;
             ShellExecute(application.handle,'open',pchar(ExtractFilePath(ParamStr(0))+'install\'+filename),pchar(ExtractFilePath(ParamStr(0))+'install\'),nil,SW_SHOWNORMAL);
             Exit;
           end
        else
           Raise Exception.Create('下载升级文件失败，系统无法完成升级');
      finally
        frmInstall.free;
      end;
     end;
     result := true;
  except
    on E:Exception do
       begin
         ShowMsgBox(pchar('升级失败,错误:'+E.Message),'友情提示...',MB_OK+MB_ICONQUESTION);
         result := false;
       end;
  end;
end;
function TfrmXsm2Main.Login(Locked:boolean=false;Exited:boolean=true):boolean;
var
  Params:ufrmLogin.TLoginParam;
  lDate:TDate;
  AObj:TRecord_;
begin
  if TimerFactory<>nil then TimerFactory.Free;
  try
  if (not Logined or frmXsmIEBrowser.SessionFail) or Locked then
     begin
       Logined := TfrmLogin.doLogin(SysId,Locked,Params,lDate);
       if Logined then
       begin
         Global.SHOP_ID := Params.ShopId;
         Global.SHOP_NAME := Params.ShopName;
         Global.UserID := Params.UserID;
         Global.UserName := Params.UserName;
         Global.Roles := Params.Roles;
         Global.CloseAll;
         Global.SysDate := lDate;
         result := true;
       end;
     end
  else
     begin
       Logined := true;
       result := true;
     end;
  if Locked then Exit;
  if Logined then
     begin
       CommandPush.ExecuteCommand;
       Loging := false;
       frmLogo.Show;
       try
         if CaFactory.Audited then
            begin
              if not FindCmdLineSwitch('DEBUG',['-','+'],false) then //同步门店专用资料
                 begin
                   if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then SyncFactory.SyncBasic(false);
                 end;
            end;
         frmLogo.ShowTitle := '正在初始化基础数据...';
         Global.LoadBasic();
         frmLogo.ShowTitle := '正在初始化权限数据...';
         ShopGlobal.LoadRight;
         CheckEnabled;
         frmXsm2Desk.CA_MODULE := CA_MODULE;
         frmLogo.ShowTitle := '正在初始化同步数据...';
         ShopGlobal.SyncTimeStamp;
         if CaFactory.Audited and frmXsmIEBrowser.SessionFail then
            begin
              frmLogo.ShowTitle := '正在登录新商盟...';
              frmXsmIEBrowser.XsmLogin(false);
            end;
         if CaFactory.Audited and Global.RemoteFactory.Connected and not frmXsmIEBrowser.SessionFail then
            begin
              frmLogo.ShowTitle := '正在登录零售终端管理平台...';
              frmLogo.Show;
              frmLogo.BringToFront;
              frmRimIEBrowser.ReadParam;
              frmRimIEBrowser.DoLogin(false,true);
            end;
         frmLogo.ShowTitle := '正在初始化广告数据...';
         frmLogo.Show;
         frmLogo.BringToFront;
         if frmRimIEBrowser.Logined then AdvFactory.LoadAdv;
         frmLogo.ShowTitle := '正在初始化桌面数据...';
         frmXsm2Desk.loadDesk;
         if not Locked and (DevFactory.ReadDefine('AUTORUNPOS','0')='1') and (ParamStr(1)<>'-xsm') and ShopGlobal.GetChkRight('500028') then
         begin
            PostMessage(Handle,WM_DESKTOP_REQUEST,13100001,0);
         end;
       finally
         frmLogo.Close;
       end;
       PostMessage(Handle,WM_CHECK_MSG,0,0);
     end
  else
     begin
       Logined := false;
       result := Logined;
       if Global.TENANT_ID = 0 then
          begin
            PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,1,1);
            Exit;
          end
       else
          begin
            if Exited then Application.Terminate;
          end;
     end;
  finally
     LoadFrame;
     if Logined then TimerFactory := TTimerFactory.Create(DoLoadMsg,StrtoIntDef(ShopGlobal.GetParameter('INTERVALTIME'),10)*60000);
     if Logined then StartSyncTask;
     Timer1.Enabled := Logined;
  end;
end;

procedure TfrmXsm2Main.wm_Login(var Message: TMessage);
var
  prm:string;
  Params:TftParamList;
begin
  if Logined then Exit;
  try
     if (ParamStr(1)='-mmc') then {已经安装盟盟的}
     begin
       Exit;
     end;
    if (ParamStr(1)='-rsp') then
       begin
         if not ConnectToRsp then
           begin
             Application.Terminate;
             Exit;
           end
         else
           Logined := true;
       end
    else
    if (ParamStr(1)='-xsm') then
       begin
         if not ConnectToXsm then
           begin
             Application.Terminate;
             Exit;
           end
         else
           Logined := true;
       end
    else
       begin
         Logined := false;
         if not ConnectToDb then
           begin
             Application.Terminate;
             Exit;
           end
         else
           Logined := not frmXsmIEBrowser.SessionFail;
       end;
    Logined := Login(false);
    if not frmXsm2Main.Visible and Logined then
    begin
//      Application.Minimize;
      frmXsm2Main.Show;
      frmXsm2Main.WindowState := wsMaximized;
      frmXsm2Main.BringToFront;
//      Application.Restore;
    end;
  except
    on E:Exception do
       begin
         ShowMsgBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONWARNING);
         Application.Terminate;
         Exit;
       end;
  end;
end;

procedure TfrmXsm2Main.SetLogined(const Value: boolean);
var
  s:string;
begin
  FLogined := Value;
  if not Value then Timer1.Enabled := Value;
//  if Value then
//     lblUserInfo.Caption := '用户名:'+Global.UserName
//  else
//     lblUserInfo.Caption := '未登录...';
end;

procedure TfrmXsm2Main.miCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmXsm2Main.FormShow(Sender: TObject);
begin
  inherited;
  UpdateTimer.Enabled := true;
end;

procedure TfrmXsm2Main.CheckEnabled;
var
  i:integer;
  rs:TZQuery;
begin
  CA_MODULE.Close;
  CA_MODULE.SQL.Text := 'select * from CA_MODULE where PROD_ID='''+ProductID+''' order by LEVEL_ID';
  Factor.Open(CA_MODULE);
  rs := CA_MODULE;
  for i:=0 to actList.ActionCount -1 do
    begin
      TAction(actList.Actions[i]).Enabled := (TAction(actList.Actions[i]).Tag=0);
      if TAction(actList.Actions[i]).Tag > 0 then
         begin
           TAction(actList.Actions[i]).Enabled := ShopGlobal.GetChkRight(inttostr(TAction(actList.Actions[i]).tag),1);
           if rs.Locate('MODU_ID',inttostr(TAction(actList.Actions[i]).tag),[]) then
              TAction(actList.Actions[i]).Caption := rs.FieldbyName('MODU_NAME').AsString;
         end;
    end;
  actfrmDbOrderList.Enabled := actfrmDbOrderList.Enabled and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion);
  actfrmDbDayReport.Enabled := actfrmDbDayReport.Enabled and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion);
  rs := Global.GetZQueryFromName('CA_TENANT');
  if rs.Locate('TENANT_ID',Global.TENANT_ID,[]) then
     actfrmRelation.Enabled := actfrmRelation.Enabled and (rs.FieldbyName('TENANT_TYPE').asInteger<>3)
  else
     actfrmRelation.Enabled := false;
end;

procedure TfrmXsm2Main.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
function CheckUpdateStatus:boolean;
begin
  result := (Factor.ExecProc('TGetLastUpdateStatus')='1'); 
end;
begin
  if not SystemShutdown and (ShowMsgBox('为保障您的数据安全，退出时系统将为您的数据进行备份整理，是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       CanClose := false;
       Exit;
       //Application.Minimize;
     end;
  Timer1.Enabled := false;
  StopSyncTask;
  if TimerFactory<>nil then TimerFactory.Free;
  if Global.UserID='system' then exit;
  if not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion and not CaFactory.CheckDebugSync then
     begin
        try
          Global.TryRemateConnect;
        except
          Exit;
        end;
        try
          if not SyncFactory.SyncLockCheck then Exit;
          if not SyncFactory.CheckDBVersion then Raise Exception.Create('你本机使用的软件版本过旧，请升级程序后再使用。');
          if TfrmCostCalc.CheckSyncReck(self) and not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion then TfrmCostCalc.TryCalcMthGods(self); 
          SyncFactory.SyncAll;
        except
          on E:Exception do
             ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
        end;
     end;
end;

procedure TfrmXsm2Main.N68Click(Sender: TObject);
begin
  inherited;
  if Logined then
  begin
    frmXsm2Main.Show;
    frmXsm2Main.WindowState := wsMaximized;
    Application.Restore;
  end;
end;

procedure TfrmXsm2Main.wm_desktop(var Message: TMessage);
var
  i:integer;
  Form:TfrmBasic;
begin
  if not Logined then Exit;
//     begin
//       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
//       Exit;
//     end;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMinimized;
  if Message.WParam=0 then
     begin
       actfrmOpenDesk.OnExecute(actfrmOpenDesk);
       Exit;
     end;
  IsXsm := (Message.LParam=1);
  if IsXsm then
     begin
       Application.MainForm.Visible := false;
       Application.Minimize;
     end;
  for i:=0 to actList.ActionCount -1 do
    begin
      if actList.Actions[i].Tag = Message.WParam then
         begin
           actList.Actions[i].OnExecute(nil);
           Exit;
         end;
    end;   
end;

procedure TfrmXsm2Main.WMQUERYENDSESSION(var msg: Tmessage);
begin
  SystemShutdown := true;
  if frmInstall<>nil then FreeAndNil(frmInstall);
  Factor.DisConnect;
  inherited;
end;

function TfrmXsm2Main.UpdateDbVersion: boolean;
var
  Factory:TCreateDbFactory;
begin
  result := true;
  Factory := TCreateDbFactory.Create;
  try
    if Factory.CheckVersion(DBVersion,Global.LocalFactory) then
       result := TfrmDbUpgrade.DbUpgrade(Factory,Global.LocalFactory);
  finally
    Factory.Free;
  end;
end;

procedure TfrmXsm2Main.Timer1Timer(Sender: TObject);
var
  P:PMsgInfo;
  w:integer;
  IsFirst:boolean;
begin
  inherited;
  try
  w := StrtoIntDef(ShopGlobal.GetParameter('INTERVALTIME'),10)*60;
  if PrainpowerJudge.Locked>0 then Exit;
  if SystemShutdown then Exit;
  if not Logined then Exit;
  if not Visible then Exit;
  if not Factor.Connected then Exit;
  
  IsFirst := false;
  if (not MsgFactory.Loaded and (Timer1.Tag>5)) or (MsgFactory.Loaded and (Timer1.Tag>0) and
     (MsgFactory.UnRead=0) and ((Timer1.Tag mod w)=0)
     )
  then
     begin
       MsgFactory.Load;
       IsFirst := true;
     end;

  if Timer1.Tag >= w then Timer1.Tag := 0 else Timer1.Tag := Timer1.Tag + 1;
  if MsgFactory.Count > 0 then
     begin
       if MsgFactory.UnRead>0 then
       begin
         lblUserInfo.Caption := '尊敬的<'+Global.TENANT_NAME+'>客户,您有('+inttostr(MsgFactory.UnRead)+')条消息';
         case Timer1.Tag mod 2 of
         0:begin
             lblUserInfo.Font.Color := clRed;
             lblUserInfo.Font.Style := [fsBold];
           end;
         1:begin
             lblUserInfo.Font.Color := clWhite;
             lblUserInfo.Font.Style := [];
           end;
         end;
       end
       else
       begin
         lblUserInfo.Caption := '尊敬的<'+Global.TENANT_NAME+'>客户,您有('+inttostr(MsgFactory.UnRead)+')条消息';
       end
     end
  else
     begin
         lblUserInfo.Caption := '尊敬的<'+Global.TENANT_NAME+'>客户,您有('+inttostr(MsgFactory.UnRead)+')条消息';
     end;
  if (MsgFactory.Loaded and ((Timer1.Tag mod w)=0)) or IsFirst or MsgFactory.Opened then
     begin
       P := MsgFactory.ReadMsg;
       if P<>nil then MsgFactory.HintMsg(P);
     end;
  except
     on E:Exception do
        LogFile.AddLogFile(0,E.Message);
  end;
end;

procedure TfrmXsm2Main.LoadFrame;
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    {
    Caption :=  F.ReadString('soft','name','rspcn.com')+' 版本:'+RzVersionInfo.FileVersion;
    if ShopGlobal.offline then
       begin
          Caption := Caption +'【脱机使用】门店：'+ Global.SHOP_NAME;
          lblNetStatus.Caption := '我在线下';
       end
    else
       begin
          Caption := Caption +'【联机使用】门店：'+ Global.SHOP_NAME;
          lblNetStatus.Caption := '我在线上';
       end;
    }
    if CaFactory.Audited then lblNetStatus.Caption := '我在线上' else lblNetStatus.Caption := '我在线下';
    imgOffline.Visible := not CaFactory.Audited;
    Application.Title :=  F.ReadString('soft','name','rspcn.com');
    lblDayInfo.Caption := '当前日期:'+formatDatetime('YYYY-MM-DD',date());
    if not FindCmdLineSwitch('rsp',['-','+'],false) then
       begin
          SFVersion := F.ReadString('soft','SFVersion','.NET');
          CLVersion := F.ReadString('soft','CLVersion','.MKT');
          ProductID := F.ReadString('soft','ProductID','R3_RYC');
       end;
  finally
    try
      F.Free;
    except
    end;
  end;
  if FileExists(ExtractFilePath(ParamStr(0))+'logo_lt.jpg') then
     Image5.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'logo_lt.jpg');
end;

procedure TfrmXsm2Main.SetLoging(const Value: boolean);
begin
  FLoging := Value;
end;

procedure TfrmXsm2Main.SetSystemShutdown(const Value: boolean);
begin
  FSystemShutdown := Value;
end;

procedure TfrmXsm2Main.InitVersioin;
begin

end;

procedure TfrmXsm2Main.N90Click(Sender: TObject);
var
  HWndCalculator : HWnd;
begin
  // 查找已存在的计算器窗口
  HWndCalculator :=FindWindow(nil, '计算器');
  if HWndCalculator <> 0 then SendMessage(HWndCalculator, WM_CLOSE, 0, 0);// close the exist Calculator
  ShellExecute(Handle,'open','calc.exe',nil,nil,SW_SHOW);

end;

procedure TfrmXsm2Main.RzBmpButton10Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmXsm2Main.LoadMenu(subname:string='');
function FindAction(cName:string):TAction;
var i:integer;
begin
  result := nil;
  for i:=0 to actList.ActionCount-1 do
    begin
      if (lowercase(actList.Actions[i].Name)=lowercase(cName)) and TAction(actList.Actions[i]).Enabled then
         begin
           result := TAction(actList.Actions[i]);
           break;
         end;
    end;
end;
var
  lvid,doStr:string;
  Action:TAction;
  isRight:boolean;
begin
  Clear;
  CA_MODULE.Filtered := false;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (CA_MODULE.FieldByName('MODU_NAME').AsString=subname) and (length(CA_MODULE.FieldByName('MODU_ID').AsString)=9) then
         begin
           lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString;
           break;
         end;
      CA_MODULE.Next;
    end;
  isRight := false;
  CA_MODULE.SortedFields := 'LEVEL_ID';
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (copy(CA_MODULE.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid) and (length(CA_MODULE.FieldbyName('LEVEL_ID').AsString)=(length(lvid)+3)) then
         begin
           Action := FindAction(CA_MODULE.FieldbyName('ACTION_NAME').AsString);
           if Assigned(Action) and ShopGlobal.GetChkRight(CA_MODULE.FieldbyName('MODU_ID').AsString,1) then
              begin
                AddModule(CA_MODULE.FieldbyName('MODU_ID').AsString,Action);
                isRight := true;
              end;
         end;
      CA_MODULE.Next;
    end;
  if not isRight then ShowMsgBox('你没有操作此模块的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmXsm2Main.RzBmpButton9Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if FList.Count > 0 then
     begin
       if ShowMsgBox('是否关闭当前打开的所有模块？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       for i:= FList.Count -1 downto 0 do
         TForm(TrzBmpButton(FList[i]).tag).free;
     end;
  if PrainpowerJudge.Locked>0 then
     begin
       ShowMsgBox('正在执行消息同步，请稍等切换用户..','友情提示..',MB_OK+MB_ICONINFORMATION);
     end;
  if FList.Count=0 then
     begin
       Logined := false;
       Logined := Login(false,false);
     end;
end;

procedure TfrmXsm2Main.DoConnectError(Sender: TObject);
begin

end;

function TfrmXsm2Main.GetDeskFlag: string;
begin

end;

procedure TfrmXsm2Main.InitTenant;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    frmLogo.Label1.Caption := '正在初始化默认数据...';
    frmLogo.Label1.Update;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.ExecProc('TTenantInit',Params);
    
    frmLogo.Label1.Caption := '正在初始化权限数据...';
    frmLogo.Label1.Update;
    TfrmInitialRights.Rights(self);
  finally
    Params.Free;
  end;
end;
function TfrmXsm2Main.ConnectToDb:boolean;
var
  RspComVersion:string;
begin
  frmLogo.Show;
  try
    result := false;
    Global.MoveToLocal;
    Global.Connect;
  finally
    frmLogo.Close;
  end;
  if not UpdateDbVersion then
     begin
       result := false;
       Exit;
     end;
  result := XsmRegister;// TfrmTenant.coRegister(self);
  if result then LoadFrame;
  if result and CaFactory.Audited then result := CheckVersion;
  if not result then Exit;
  if result then
     begin
      if ShopGlobal.NetVersion or ShopGlobal.ONLVersion then
         begin
           frmLogo.Show;
           try
             frmLogo.ShowTitle := '检测远程应用服务器...';
             Global.MoveToRemate;
             try
               Global.Connect;
               with TCreateDbFactory.Create do
               begin
                 try
                    RspComVersion := Factor.ExecProc('TGetComVersion');
                    if CheckVersion(DBVersion,Global.RemoteFactory) or CompareVersion(ComVersion,RspComVersion) then
                    begin
                      if ShopGlobal.ONLVersion then
                         begin
                           ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器..','友情提示...',MB_OK+MB_ICONINFORMATION);
                           result := false;
                           Exit;
                         end;
                      result := (ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器，是否转脱机使用？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6);
                      if result then
                        begin
                          Global.MoveToLocal;
                          Global.Connect;
                        end;
                    end;   
                 finally
                    free;
                 end;
               end;
             except
               if ShopGlobal.ONLVersion then
                  begin
                    if ShowMsgBox('连接数据库服务器失败,请检查网络是否正常,是否重新选择连接主机？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
                       TfrmHostDialog.HostDialog(self);
                    result := false;
                    Exit;
                  end;
               result := (ShowMsgBox('连接远程数据库失败,是否转脱机操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);
               if result then
                  begin
                    Global.MoveToLocal;
                    Global.Connect;
                  end;
             end;
           finally
             frmLogo.Close;
           end;
         end;
     end;
  try
    frmLogo.Show;
    try
     if CaFactory.Audited and not ShopGlobal.ONLVersion then
        begin
          if not Global.RemoteFactory.Connected and not ShopGlobal.NetVersion then
             begin
               frmLogo.Label1.Caption := '正在连接远程服务...';
               frmLogo.Label1.Update;
               Global.MoveToRemate;
               try
                 try
                   Global.Connect;
                 except
                   ShowMsgBox('连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
                 end;
               finally
                 Global.MoveToLocal;
               end;
             end;
          if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
          if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
             begin
               if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
               InitTenant;
             end;
        end
     else
        begin
          if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
          if CaFactory.Audited and Global.RemoteFactory.Connected then //管理什么版本，有连接到服务器时，必须先同步数据
             begin
               if ShopGlobal.ONLVersion then //在线版只需同步注册数据
                  begin
                    if Global.RemoteFactory.ConnString<>Global.LocalFactory.ConnString then //调试模式时，不同步
                    begin
                      SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                      SyncFactory.SyncComm := SyncFactory.CheckRemeteData;
                      SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSysDefine',0);
                      SyncFactory.SyncSingleTable('CA_SHOP_INFO','TENANT_ID;SHOP_ID','TSyncSingleTable',0);
                      SyncFactory.SyncSingleTable('ACC_ACCOUNT_INFO','TENANT_ID;ACCOUNT_ID','TSyncAccountInfo',0);
                    end;
                  end
               else
                  begin
                    if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
                  end;
             end;
          InitTenant;
        end;
    finally
      frmLogo.Close;
    end;
  except
    on E:Exception do
      begin
        ShowMsgBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONERROR);
        result := false;
      end;
  end;
end;

procedure TfrmXsm2Main.actfrmMeaUnitsExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  with TfrmMeaUnits.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;

end;

procedure TfrmXsm2Main.actfrmDutyInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmDutyInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDutyInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRoleInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRoleInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmRoleInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmDeptInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmDeptInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDeptInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmUsersExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmUsers);
  if not Assigned(Form) then
     begin
       Form := TfrmUsers.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmBrandInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,4);
end;

procedure TfrmXsm2Main.actfrmStockOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStockOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStockOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmSalesOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSalesOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalesOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmChangeOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmChangeOrderList1');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '1';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList1';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmChangeOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmChangeOrderList2');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '2';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList2';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmGoodsInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmGoodsInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmGoodsInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmGoodsSortExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  if TfrmGoodsSortTree.ShowDialog(self,1) then
  begin
    Form:=FindChildForm(TfrmGoodsInfoList);
    if Form<>nil then
      TfrmGoodsInfoList(Form).LoadTree;
  end;
end;

procedure TfrmXsm2Main.actfrmCodeInfo3Execute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,3);
end;

procedure TfrmXsm2Main.actfrmSortInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,2);
end;

procedure TfrmXsm2Main.actfrmImplInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,5);
end;

procedure TfrmXsm2Main.actfrmAreaInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,6);
end;

procedure TfrmXsm2Main.actfrmSaleStyleExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,2);
end;

procedure TfrmXsm2Main.actfrmSettleCodeExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,6);
end;

procedure TfrmXsm2Main.actfrmShopGroupExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,12);
end;

procedure TfrmXsm2Main.actfrmRecvOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmRecvOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmPayOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmPayOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPayOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmClientExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
// Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmClient);
  if not Assigned(Form) then
     begin
       Form := TfrmClient.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmSupplierExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSupplier);
  if not Assigned(Form) then
     begin
       Form := TfrmSupplier.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmSalRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSalRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStkRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStkRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmPosMainExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmPosMain);
  if not Assigned(Form) then
     begin
       Form := TfrmPosMain.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsNormal;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmPriceGradeInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmPriceGradeInfo.ShowDialog(self);

end;

procedure TfrmXsm2Main.actfrmSalIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSalIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStkIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStkIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmInvoiceExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmInvoice);
  if not Assigned(Form) then
     begin
       Form := TfrmInvoice.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmCustomerExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmCustomer);
  if not Assigned(Form) then
     begin
       Form := TfrmCustomer.Create(self);
       AddFrom(Form);
     end;
  if not Application.MainForm.Visible then
     begin
       Form.FormStyle :=  fsNormal;
       Form.Width := 800;
       Form.Height := 575;
       Form.WindowState := wsNormal;
     end
  else
  if Application.MainForm.Visible and (Form.FormStyle = fsNormal) then
     begin
       Form.FormStyle :=  fsMDIChild;
       Form.WindowState := wsMaximized;
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmCostCalcExecute(Sender: TObject);
begin
  inherited;
{  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCostCalc.StartCalc(self); }
end;

procedure TfrmXsm2Main.actfrmSysDefineExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  with TfrmSysDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmXsm2Main.actfrmDaysCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCostCalc.StartDayReck(self);
end;

procedure TfrmXsm2Main.actfrmMonthCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmCostCalc.StartMonthReck(self);

end;

procedure TfrmXsm2Main.actfrmCloseForDayExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  if TfrmCloseForDay.ShowClDy(self)=2 then ;//ShowMsgBox('当天没有营业数据，不需要结账','友情提示...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmXsm2Main.actfrmPriceOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmPriceOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPriceOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;

end;

procedure TfrmXsm2Main.actfrmCheckOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmCheckOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmCheckOrderList.Create(self);
       AddFrom(Form);
     end;
  // Add 
  TfrmCheckOrderList(Form).DoCheckPrint:=actfrmChecktablePrintExecute;     
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmDbOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmDbOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmDbOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmShopInfoListExecute(Sender: TObject);
var
  Form:TfrmBasic;
  AObj:TRecord_;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  if SFVersion='.LCL' then
     begin
       AObj := TRecord_.Create;
       try
         TfrmShopInfo.EditDialog(self,Global.SHOP_ID,Aobj);
       finally
         AObj.Free;
       end;
     end
  else
     begin
        Form := FindChildForm(TfrmShopInfoList);
        if not Assigned(Form) then
           begin
             Form := TfrmShopInfoList.Create(self);
             AddFrom(Form);
           end;
        Form.Show;
        Form.BringToFront;
     end;
end;

procedure TfrmXsm2Main.actfrmXsmBrowserExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmXsmWebForm');
  if not Assigned(Form) then
     begin
       Form := TfrmIEWebForm.Create(self);
       Form.Caption := actfrmXsmBrowser.Caption;
       AddFrom(Form);
     end;
  try
    Form.Name := 'frmXsmWebForm';
    xsm_url := 'http://test.xinshangmeng.com/';
    if copy(ParamStr(3),1,8)='-xsmurl=' then
       TfrmIEWebForm(Form).Open(copy(ParamStr(3),9,255))
    else
       begin
//         if ShowMsgBox('你没有新商盟账号无法完成登录,是否进入新商盟演示账套?','友情提示..',MB_YESNO+MB_ICONINFORMATION)<>6 then
//            begin
//              Form.Free;
//              Exit;
//            end;
         if not TfrmIEWebForm(Form).Open(TfrmIEWebForm(Form).GetDoLogin(xsm_url)) then
            begin
              Form.Free;
              Exit;
            end;
       end;
    Form.Show;
    Form.BringToFront;
  except
    Form.Free;
    Raise;
  end;
end;

procedure TfrmXsm2Main.actfrmAccountExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmAccount);
  if not Assigned(Form) then
     begin
       Form := TfrmAccount.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmTransOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmTransOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmTransOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmDevFactoryExecute(Sender: TObject);
begin
  inherited;
  with TfrmDevFactory.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmXsm2Main.actfrmIoroOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmIoroOrderList1');
  if not Assigned(Form) then
     begin
       Form := TfrmIoroOrderList.Create(self);
       TfrmIoroOrderList(Form).IoroType := 1;
       TfrmIoroOrderList(Form).Name := 'frmIoroOrderList1';
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmIoroOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmIoroOrderList2');
  if not Assigned(Form) then
     begin
       Form := TfrmIoroOrderList.Create(self);
       TfrmIoroOrderList(Form).IoroType := 2;
       TfrmIoroOrderList(Form).Name := 'frmIoroOrderList2';
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmCheckTablePrintExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmCheckTablePrint);
  if not Assigned(Form) then
  begin
    Form := TfrmCheckTablePrint.Create(self);
    AddFrom(Form);
  end;
  if Sender is TRecord_ then
    TfrmCheckTablePrint(Form).DoOpenDefaultData(TRecord_(Sender));
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRckMngExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRckMng);
  if not Assigned(Form) then
  begin
    Form := TfrmRckMng.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmJxcTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmJxcTotalReport);
  if not Assigned(Form) then
  begin
    Form := TfrmJxcTotalReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStockDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStockDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStockDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmSaleDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmChange1DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmChange1DayReport');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeDayReport.Create(self);
       TfrmChangeDayReport(Form).CodeId := '1';
       TfrmChangeDayReport(Form).Name := 'frmChange1DayReport';
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmChange2DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmChange2DayReport');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeDayReport.Create(self);
       TfrmChangeDayReport(Form).CodeId := '2';
       TfrmChangeDayReport(Form).Name := 'frmChange2DayReport';
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmLockScreenExecute(Sender: TObject);
begin
  inherited;
  frmXsm2Desk.HookLocked := true;
  try
    Login(true);
  finally
    frmXsm2Desk.HookLocked := false;
  end;

end;

procedure TfrmXsm2Main.actfrmStorageDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStorageDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRckDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRckDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRckDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRelationExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRelation);
  if not Assigned(Form) then
  begin
    Form := TfrmRelation.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRecvDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmPayDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmPayDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmRecvAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmPayAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmPayAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStorageTrackingExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStorageTracking);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageTracking.Create(self);
    AddFrom(Form);
  end;
  if not Application.MainForm.Visible then
     begin
       Form.FormStyle :=  fsNormal;
       Form.Width := 934;
       Form.Height := 575;
       Form.WindowState := wsNormal;
     end
  else
  if Application.MainForm.Visible and (Form.FormStyle = fsNormal) then
     begin
       Form.FormStyle :=  fsMDIChild;
       Form.WindowState := wsMaximized;
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmDbDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmDbDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmDbDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmGodsRunningReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmGodsRunningReport);
  if not Assigned(Form) then
  begin
    Form := TfrmGodsRunningReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.RzBmpButton13Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',5) then Raise Exception.Create('你没有到货确认权限,请和管理员联系.');
  actfrmDownIndeOrder.Execute;
end;

procedure TfrmXsm2Main.tlbCloseClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).Down and (TrzBmpButton(FList[i]).Tag>0) and (TrzBmpButton(FList[i]).GroupIndex=999) then
         begin
           TfrmBasic(TrzBmpButton(FList[i]).Tag).Close;
           break;
         end;
    end;
end;

procedure TfrmXsm2Main.N103Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;

procedure TfrmXsm2Main.actfrmIoroDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmIoroDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmIoroDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmMessageExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmMessage);
  if not Assigned(Form) then
  begin
    Form := TfrmMessage.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmNewPaperReaderExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmNewPaperReader.ShowNewsPaper('');
end;

procedure TfrmXsm2Main.WriteAction(s: string;flag:integer);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sft.'+Global.UserID);
  try
    if flag=0 then
       F.WriteInteger('MenuMoudle',s,F.ReadInteger('Menu',s,0)+1)
    else
       F.WriteInteger('MenuReport',s,F.ReadInteger('Menu',s,0)+1);
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmXsm2Main.actfrmQuestionnaireExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  TfrmQuestionnaire.ShowForm(self);
end;

procedure TfrmXsm2Main.RzBmpButton11Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmXsm2Main.RzBmpButton12Click(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmXsm2Main.RzBmpButton14Click(Sender: TObject);
begin
  inherited;
  actfrmQuestionnaire.OnExecute(actfrmQuestionnaire);
end;

procedure TfrmXsm2Main.RzBmpButton15Click(Sender: TObject);
begin
  inherited;
  actfrmMessage.OnExecute(actfrmMessage);
end;

procedure TfrmXsm2Main.actfrmInLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmInLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmInLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmOutLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
 // Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmOutLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmOutLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.lblUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmXsm2Main.actfrmDownIndeOrderExecute(Sender: TObject);
var
  vData: OleVariant;
  Aobj: TRecord_;
  Form: TfrmBasic;
  SaveFactor:TdbFactory;
  Desk:boolean;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.ForeBringtoFront;
  Desk := true;
  frmXsm2Desk.SaveToFront;
  try
     if not Global.RemoteFactory.Connected then 
     begin
       if ShowMsgBox('当前连接已经断开，是否尝试连接远程服务器？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       SaveFactor := uGlobal.Factor;
       try
         Global.MoveToRemate;
         try
           Global.Connect;
         except
           ShowMsgBox('无法连接到远程服务器，请检查网络是否正常','友情提示...',MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
       finally
         uGlobal.Factor := SaveFactor;
       end;
     end;
    Form := FindChildForm(TfrmDownStockOrder);
    if (Form<>nil) and TfrmDownStockOrder(Form).Xsm and not Application.MainForm.Visible then
       begin
         Form.Show;
         Form.WindowState := wsNormal;
         Form.BringToFront;
         Exit;
       end;
    if (Form<>nil) then Form.Free;
    if not Application.MainForm.Visible then
       begin
         TfrmDownStockOrder.XsmShow;
         Exit;
       end;
    try
      Aobj:=TRecord_.Create;
      if TfrmDownStockOrder.DownStockOrder(AObj,vData) then
      begin
        if trim(AObj.fieldbyName('INDE_ID').AsString)<>'' then
        begin
          Form := FindChildForm(TfrmStockOrderList);
          if not Assigned(Form) then
          begin
            Form := TfrmStockOrderList.Create(self);
            AddFrom(Form);
          end;
          TfrmStockOrderList(Form).DoIndeOrderWriteToStock(Aobj,vData);
          Form.WindowState := wsMaximized;
          Form.BringToFront;
          Desk := false;
        end;
      end;
    finally
      Aobj.Free;
    end;
  finally
    if Desk then  SendMessage(Handle,WM_DESKTOP_REQUEST,0,0);//  tbDesktopClick(tbDesktop);
  end;
end;

procedure TfrmXsm2Main.actfrmRecvForDayExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvPosList);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvPosList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.rzUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmXsm2Main.actfrmImpeachExecute(Sender: TObject);
begin
  inherited;
  TfrmImpeach.ShowImpeach(self); 
end;

procedure TfrmXsm2Main.actfrmClearDataExecute(Sender: TObject);
begin
  inherited;
  TfrmClearData.DeleteDB(self);

end;

function TfrmXsm2Main.ConnectToRsp: boolean;
var
  rs:TZQuery;
  rspComVersion:string;
begin
  frmLogo.Show;
  try
    result := false;
    Global.MoveToLocal;
    Global.Connect;
  finally
    frmLogo.Close;
  end;
  if not UpdateDbVersion then
     begin
       result := false;
       Exit;
     end;
  Global.MoveToRemate;
  if pos(';',ParamStr(2))>0 then //如果带分号，代表没加密码的
     Global.RemoteFactory.Initialize(ParamStr(2))
  else
     Global.RemoteFactory.Initialize(DecStr(ParamStr(2),ENC_KEY));
  Global.Connect;
   with TCreateDbFactory.Create do
   begin
     try
        RspComVersion := Factor.ExecProc('TGetComVersion');
        if CheckVersion(DBVersion,Global.RemoteFactory) or CompareVersion(ComVersion,RspComVersion) then
        begin
           ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器..','友情提示...',MB_OK+MB_ICONINFORMATION);
           result := false;
           Exit;
        end;
     finally
        free;
     end;
   end;
  if CaFactory.Audited then
     begin
       InitXsm;
       InitRim;
     end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TENANT_ID,TENANT_NAME,SHORT_TENANT_NAME from CA_TENANT where TENANT_ID='+ParamStr(3);
    Factor.Open(rs);
    if rs.IsEmpty then
       begin
         ShowMsgBox('参数传入的企业号无效..','友情提示...',MB_OK+MB_ICONINFORMATION);
         result := false;
       end;
    Global.TENANT_ID := rs.Fields[0].AsInteger;
    Global.TENANT_NAME := rs.Fields[1].AsString;
    Global.SHOP_ID := rs.Fields[0].AsString+'0001';
    Global.SHOP_NAME := rs.Fields[2].AsString;
    Global.UserID := 'system';
    Global.UserName := '系统用户';
  finally
    rs.Free;
  end;
  LoadFrame;
  ProductId := ParamStr(4);
  SFVersion := '.ONL';
  CLVersion := ParamStr(5);
  result := true;
end;

procedure TfrmXsm2Main.actfrmSaleAnalyExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleAnaly);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleAnaly.Create(self);
       AddFrom(Form);
     end;
  if not Application.MainForm.Visible and (Form.FormStyle = fsMDIChild) then
     begin
       Form.FormStyle :=  fsNormal;
       Form.WindowState := wsNormal;
       Form.Width := 800;
       Form.Height := 575;
     end
  else
  if Application.MainForm.Visible and (Form.FormStyle = fsNormal) then
     begin
       Form.FormStyle :=  fsMDIChild;
       Form.WindowState := wsMaximized;
     end
  else
     begin
       Form.WindowState := wsMaximized;
       Form.BringToFront;
     end;
end;

procedure TfrmXsm2Main.wm_message(var Message: TMessage);
begin
  if Message.WParam = 99 then //执行自动到货确认
  begin
     if Global.UserID='system' then Exit;
     if not SyncFactory.SyncLockCheck then Exit;
     TfrmDownStockOrder.AutoDownStockOrder(inttostr(Message.LParam));
  end;
  if Message.WParam = 100 then //新商盟消息
  begin
     if frmXsmIEBrowser=nil then Exit;
     frmXsmIEBrowser.Open(PMsgInfo(Message.LParam)^.SenceId,PMsgInfo(Message.LParam)^.Action,0);
  end;
end;

procedure TfrmXsm2Main.actfrmNetForOrderExecute(Sender: TObject);
var
  Form:TfrmBasic;
  rimurl:string;
  rimuid:string;
  rimpwd:string;
  Msg:string;
  Params:TftParamList;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Msg := Global.RemoteFactory.ExecProc('TRimWsdlService',Params);
    Params.Decode(Params,Msg);
    rimurl := trim(Params.ParambyName('rimurl').AsString);
    rimuid := Params.ParambyName('rimuid').AsString;
    rimpwd := Params.ParambyName('rimpwd').AsString;
    if rimurl='' then Raise Exception.Create('无法连接到零售终端服务主机，请和实施人员联系.');
    if rimuid='' then Raise Exception.Create('当前登录门店的许可证号无效，请输入修改正确的许可证号.');
  finally
    Params.Free;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmNetForOrder');
  if not Assigned(Form) then
     begin
       Form := TfrmIEWebForm.Create(self);
       Form.Caption := actfrmNetForOrder.Caption;
       AddFrom(Form);
     end;
  try
    Form.Name := 'frmNetForOrder';
    if rimurl[length(rimurl)]<>'/' then rimurl := rimurl + '/';
    TfrmIEWebForm(Form).Open(rimurl+'rim_check/up?j_username='+rimuid+'&j_password='+rimpwd+'&MAIN_PAGE=rim');
    Form.Show;
    Form.BringToFront;
  except
    Form.Free;
    Raise;
  end;
end;

procedure TfrmXsm2Main.actfrmSaleManSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleManSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleManSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmClientSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmClientSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmClientSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.DoLoadMsg(Sender: TObject);
begin
  if not Visible then Exit;
  if SyncFactory.Locked > 0 then Exit;
  PrainpowerJudge.SyncMsgc;
end;

procedure TfrmXsm2Main.actfrmSaleTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStgTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStgTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStgTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.actfrmStockTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmStockTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStockTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

function TfrmXsm2Main.ConnectToXsm: boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
var
  mm,chk,tid,fn:string;
function  CheckParams:boolean;
begin
 try
  mm := ParamStr(2);
  if (copy(mm,1,3)<>'-mm') then Raise Exception.Create('传的参数无效，请认真阅读通讯协议文档');
  mm := copy(mm,5,255);

  chk := ParamStr(3);
  if (copy(chk,1,4)<>'-chk') then Raise Exception.Create('传的参数无效，请认真阅读通讯协议文档');
  chk := copy(chk,6,255);
  if chk<>md5Encode(mm+dec) then Raise Exception.Create('系统传入的校验码无效..');

  tid := ParamStr(5);
  if copy(tid,1,3)<>'-id' then Raise Exception.Create('传的参数无效，请认真阅读通讯协议文档');
  tid := copy(tid,5,255);

  fn := ParamStr(4);
  if copy(fn,1,3)<>'-fn' then Raise Exception.Create('传的参数无效，请认真阅读通讯协议文档');
  fn := copy(fn,5,255);
  result := true;

 except
   on E:Exception do
      begin
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
        result := false;
      end;
 end;
end;
function CheckTenant:boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select Value from SYS_DEFINE Where Define = ''TENANT_ID'' and TENANT_ID=0 ';
    Factor.Open(rs);
    if rs.Fields[0].asString<>tid then //不相同要自动注册
       begin
         Global.TENANT_ID := 0;
         result := TfrmTenant.coAutoRegister(tid);
       end
    else
       result := TfrmTenant.coRegister(self);
  finally
    rs.Free;
  end;
end;
var
  rs:TZQuery;
  RspComVersion:string;
begin
  RzTrayIcon1.HideOnMinimize := true;
  result := false;
  frmLogo.Show;
  try
    result := false;
    Global.MoveToLocal;
    Global.Connect;
  finally
    frmLogo.Close;
  end;
  if not UpdateDbVersion then
     begin
       result := false;
       Exit;
     end;
  result := CheckParams;
  result := CheckTenant;
  if result then LoadFrame;
  if result and CaFactory.Audited then result := CheckVersion;
  if not result then Exit;
  if result then
     begin
      if CaFactory.Audited then
         begin
           InitXsm;
           InitRim;
         end;
      if ShopGlobal.NetVersion or ShopGlobal.ONLVersion then
         begin
           frmLogo.Show;
           try
             Global.MoveToRemate;
             try
               Global.Connect;
               with TCreateDbFactory.Create do
               begin
                 try
                    RspComVersion := Factor.ExecProc('TGetComVersion');
                    if CheckVersion(DBVersion,Global.RemoteFactory) or CompareVersion(ComVersion,RspComVersion) then
                    begin
                      if ShopGlobal.ONLVersion then
                         begin
                           ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器..','友情提示...',MB_OK+MB_ICONINFORMATION);
                           result := false;
                           Exit;
                         end;
                      result := (ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器，是否转脱机使用？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6);
                      if result then
                        begin
                          Global.MoveToLocal;
                          Global.Connect;
                        end;
                    end;   
                 finally
                    free;
                 end;
               end;
             except
               if ShopGlobal.ONLVersion then
                  begin
                    if ShowMsgBox('连接数据库服务器失败,请检查网络是否正常,是否重新选择连接主机？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
                       TfrmHostDialog.HostDialog(self);
                    result := false;
                    Exit;
                  end;
               result := (ShowMsgBox('连接远程数据库失败,是否转脱机操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);
               if result then
                  begin
                    Global.MoveToLocal;
                    Global.Connect;
                  end;
             end;
           finally
             frmLogo.Close;
           end;
         end;
     end;
  try
    frmLogo.Show;
    try
     if CaFactory.Audited and not ShopGlobal.ONLVersion then
        begin
          if not Global.RemoteFactory.Connected and not ShopGlobal.NetVersion then
             begin
               frmLogo.Label1.Caption := '正在连接远程服务...';
               frmLogo.Label1.Update;
               Global.MoveToRemate;
               try
                 try
                   Global.Connect;
                 except
                   ShowMsgBox('连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
                 end;
               finally
                 Global.MoveToLocal;
               end;
             end;
          if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
             begin
               if CaFactory.CheckInitSync then CaFactory.SyncAll(1);
               if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
               InitTenant;
             end;
        end
     else
        begin
          if CaFactory.Audited and Global.RemoteFactory.Connected then //管理什么版本，有连接到服务器时，必须先同步数据
             begin
               if CaFactory.CheckInitSync then CaFactory.SyncAll(1);
               if ShopGlobal.ONLVersion then //在线版只需同步注册数据
                  begin
                    SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                    SyncFactory.SyncComm := SyncFactory.CheckRemeteData;
                    SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('CA_SHOP_INFO','TENANT_ID;SHOP_ID','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('ACC_ACCOUNT_INFO','TENANT_ID;ACCOUNT_ID','TSyncAccountInfo',0);
                  end
               else
                  begin
                    if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
                  end;
             end;
          InitTenant;
        end;
    finally
      frmLogo.Close;
    end;
  except
    on E:Exception do
      begin
        ShowMsgBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONERROR);
        result := false;
        Exit;
      end;
  end;
  rs := Global.GetZQueryFromName('CA_USERS');
  if rs.Locate('MM',lowercase(mm),[]) or rs.Locate('MM',uppercase(mm),[]) then
    begin
      Global.SysDate := Date();
      Global.UserID := rs.FieldbyName('USER_ID').AsString;
      Global.SHOP_ID := rs.FieldbyName('SHOP_ID').AsString;
      Global.Roles  := rs.FieldbyName('ROLE_IDS').AsString;
      Global.SHOP_NAME := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',rs.FieldbyName('SHOP_ID').AsString);
      Global.UserName := rs.FieldbyName('USER_NAME').AsString;
      result := true;
    end
  else
    begin
      Global.SysDate := Date();
      Global.UserID := 'admin';
      Global.SHOP_ID := inttostr(Global.TENANT_ID)+'0001';
      Global.Roles  := '';
      Global.SHOP_NAME := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Global.SHOP_ID);
      Global.UserName := '管理员';
      result := true;
    end;
  IsXsm := true;
  PostMessage(Handle,WM_DESKTOP_REQUEST,StrtoIntDef(fn,0),1);
end;

procedure TfrmXsm2Main.RzTrayIcon1LButtonDblClick(Sender: TObject);
begin
  inherited;
  if Logined then
  begin
    frmXsm2Main.Show;
    frmXsm2Main.WindowState := wsMaximized;
  end;
end;

procedure TfrmXsm2Main.actfrmSaleMonthTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleMonthTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleMonthTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmXsm2Main.rzSizeLeft_1Resize(Sender: TObject);
begin
  inherited;
  frmMain.OnResize(nil);
end;

procedure TfrmXsm2Main.LoadPic32;
var
  DllHandle: THandle;
function GetBitmap(ResName:string):TBITMAP;
var
  Stream: TStream;
begin
  result := nil;
  //装载Logo
  if FindResource(DllHandle, PChar(ResName), 'BMP') <> 0 then
  begin
    Stream := TResourceStream.Create(DllHandle, ResName, 'BMP');
    try
      result := TBITMAP.Create;
      try
        Stream.Position := 0;
        result.LoadFromStream(Stream);
      except
        freeandnil(result);
      end;
    finally
      Stream.Free;
    end;
  end;
end;
function GetJpeg(ResName:string):TJPEGImage;
var
  Stream: TStream;
begin
  result := nil;
  //装载Logo
  if FindResource(DllHandle, PChar(ResName), 'JPG') <> 0 then
  begin
    Stream := TResourceStream.Create(DllHandle, ResName, 'JPG');
    try
      result := TJPEGImage.Create;
      try
        Stream.Position := 0;
        result.LoadFromStream(Stream);
      except
        freeandnil(result);
      end;
    finally
      Stream.Free;
    end;
  end;
end;
function GetResString(ResName:integer):string;
var
  iRet:array[0..254] of char;
begin
  result := '';
  LoadString(DllHandle, ResName, iRet, 254);
  result := StrPas(iRet);
end;

var
  pic:TGraphic;
begin
  DllHandle := LoadLibrary('Pic32.dll');
  if DllHandle > 0 then
  try

  finally
    if DllHandle > 0 then FreeLibrary(DllHandle);
  end;
end;

procedure TfrmXsm2Main.actfrmXsmNetExecute(Sender: TObject);
var
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
begin
  inherited;
  if not CA_MODULE.Locate('MODU_ID',inttostr(TrzBmpButton(Sender).Tag),[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.Locked := false;
//  frmXsm2Desk.SaveToFront;
  Form := FindChildForm('frmXsmIEBrowser');
  if Form=nil then Raise Exception.Create('脱机状态不能打开新商盟相关模块...'); 
  if TfrmBasic(Form).PageHandle = Integer(Sender) then
     begin
       Form.WindowState := wsMaximized;
       Form.BringToFront;
       Exit;
     end;
  Form.Caption := TrzBmpButton(Sender).Caption;
  Form.Name := 'frmXsmIEBrowser';
  sl := TStringList.Create;
  try
    sl.CommaText := s;
//    if Screen.Width <= 1024 then
//       begin
//         rzLeft.Width := 35;
//         lblUserInfo.Visible := (rzLeft.Width <> 35);
//         frmMain.OnResize(frmMain);
//       end;
    if TfrmXsmIEBrowser(Form).open(sl.Values['sceneId'],sl.Values['objectId'],Integer(Sender)) then
       begin
         TfrmBasic(Form).PageHandle := Integer(Sender);
       end
    else
       DoActiveChange(nil);
  finally
    sl.free;
  end;
end;

procedure TfrmXsm2Main.splitClick(Sender: TObject);
begin
  inherited;
  Exit;
  if rzLeft.Width = 35 then
     rzLeft.Width := 171
  else
     rzLeft.Width := 35;
  lblUserInfo.Visible := (rzLeft.Width <> 35);
  frmMain.OnResize(frmMain);
end;

procedure TfrmXsm2Main.Clear;
var
  i:integer;
  Form:TForm;
begin
  UnSelect;
  for i:=FList.Count -1 downto 0 do
    begin
      if TRzBmpButton(FList[i]).GroupIndex=888 then
         begin
           TRzBmpButton(FList[i]).OnClick := nil;
           TObject(FList[i]).Free;
           FList.Delete(i);
         end;
    end;
  Form := FindChildForm('frmRimIEBrowser');
  if Assigned(Form) then
     TfrmBasic(Form).PageHandle := 0;
  Form := FindChildForm('frmXsmIEBrowser');
  if Assigned(Form) then
     TfrmBasic(Form).PageHandle := 0;
end;

procedure TfrmXsm2Main.page_03Click(Sender: TObject);
begin
  inherited;
  LoadMenu('网上配货');
  page_03.Down  := SortToolButton;
//  Button2Click(page_03);
end;

procedure TfrmXsm2Main.page_04Click(Sender: TObject);
begin
  inherited;
  LoadMenu('网上结算');
  page_04.Down := SortToolButton;
end;

procedure TfrmXsm2Main.page_02Click(Sender: TObject);
begin
  inherited;
  LoadMenu('网上订货');
  page_02.Down := SortToolButton;
end;

procedure TfrmXsm2Main.page_12Click(Sender: TObject);
begin
  inherited;
  LoadMenu('品牌培育');
  page_12.Down := SortToolButton;
end;

procedure TfrmXsm2Main.page_13Click(Sender: TObject);
begin
  inherited;
  LoadMenu('信息互通');
  page_13.Down := SortToolButton;
end;

procedure TfrmXsm2Main.page_14Click(Sender: TObject);
begin
  inherited;
  LoadMenu('我的社区');
  page_14.Down := SortToolButton;
end;

procedure TfrmXsm2Main.tbDesktopClick(Sender: TObject);
begin
  inherited;
  actfrmOpenDeskExecute(nil);
end;

procedure TfrmXsm2Main.page_11Click(Sender: TObject);
begin
  inherited;
  Clear;
  tbDesktopClick(nil);
  page_11.Down := true;
  SortToolButton;
end;

procedure TfrmXsm2Main.AddModule(mid: string;Action:TAction);
var
  button:TrzBmpButton;
begin
  button := TrzBmpButton.Create(rzToolButton);
  button.AllowAllUp := true;
  button.GroupIndex := 888;
  button.Bitmaps.Up.Assign(toolButton.Bitmaps.Up);
  button.Bitmaps.Down.Assign(toolButton.Bitmaps.Down);
  button.Font.Assign(toolButton.Font);
  button.Tag := StrtoInt(mid);
  button.OnClick := Action.OnExecute;
  button.Visible := true;
  button.Parent := rzToolButton;
//  button.PopupMenu := tlbPage;
  button.Top := 3;
  button.Down := false;
  FList.Add(button);
  if CA_MODULE.Locate('MODU_ID',mid,[]) then
    begin
      button.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
    end;
end;

procedure TfrmXsm2Main.page_01Click(Sender: TObject);
begin
  inherited;
  LoadMenu('网上营销');
  page_01.Down := SortToolButton;
end;

procedure TfrmXsm2Main.UnSelect;
var i:integer;
begin
  page_01.Down := false;
  page_02.Down := false;
  page_03.Down := false;
  page_04.Down := false;
  page_11.Down := false;
  page_12.Down := false;
  page_13.Down := false;
  page_14.Down := false;
  tbDesktop.Down := false;
  for i:= FList.Count-1 downto 0 do TRzBmpButton(FList[i]).Down := false;
end;

procedure TfrmXsm2Main.actfrmRimNetExecute(Sender: TObject);
var
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
begin
  inherited;
  if not CA_MODULE.Locate('MODU_ID',inttostr(TrzBmpButton(Sender).Tag),[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.Locked := false;
  Form := FindChildForm('frmRimIEBrowser');
  if not Assigned(Form) then
     Form := TfrmRimIEBrowser.Create(self);
  sl := TStringList.Create;
  try
    if TfrmBasic(Form).PageHandle = Integer(Sender) then
       begin
         Form.WindowState := wsMaximized;
         Form.BringToFront;
         Exit;
       end;
    Form.Caption := TrzBmpButton(Sender).Caption;
    Form.Name := 'frmRimIEBrowser';
    sl.CommaText := s;
    if TfrmRimIEBrowser(Form).OpenUrl(sl.values['url'],Integer(Sender),(sl.values['xsm']='true')) then
       begin
         TfrmBasic(Form).PageHandle := Integer(Sender);
       end
    else
       DoActiveChange(nil);
  finally
    sl.free;
  end;
end;

procedure TfrmXsm2Main.InitXsm;
begin
  frmLogo.ShowTitle := '正在初始化新商盟...';
  frmLogo.Show;
  if frmXsmIEBrowser=nil then Application.CreateForm(TfrmXsmIEBrowser, frmXsmIEBrowser);
  frmXsmIEBrowser.mmc := false;
  frmXsmIEBrowser.DoInit;
end;

procedure TfrmXsm2Main.FormResize(Sender: TObject);
var
  bh:integer;
  br:integer;
begin
  inherited;
  bh := (ClientHeight- 46- 31) div 2;//- (66*8);
  Bar1.Height := bh;
  Bar2.Height := bh;
  br := bh - (66*4);
  br := br div 5;

  page_01.Top := br;
  page_02.Top := page_01.Top + page_01.Height + br;
  page_03.Top := page_02.Top + page_02.Height + br;
  page_04.Top := page_03.Top + page_03.Height + br;

  page_11.Top := br;
  page_12.Top := page_11.Top + page_11.Height + br;
  page_13.Top := page_12.Top + page_12.Height + br;
  page_14.Top := page_13.Top + page_13.Height + br;
  
end;

procedure TfrmXsm2Main.actfrmCalcStorageExecute(Sender: TObject);
begin
  inherited;
  TfrmCostCalc.CalcAnalyLister(self);
  ShowMsgBox('动销测算完毕','友情提示...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmXsm2Main.actfrmStorageOptionDefineExecute(Sender: TObject);
begin
  inherited;
  with TfrmOptionDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;

end;

procedure TfrmXsm2Main.actfrmOpenDeskExecute(Sender: TObject);
begin
  inherited;
  if frmXsmIEBrowser<>nil then
     begin
       frmXsmIEBrowser.WindowState := wsNormal;
       frmXsmIEBrowser.Left := - 9000;
     end;
  if frmRimIEBrowser<>nil then
     begin
       frmRimIEBrowser.WindowState := wsNormal;
       frmRimIEBrowser.Left := - 9000;
     end;
  frmXsm2Desk.Locked := true;
  frmXsm2Desk.BringToFront;
//  rzLeft.Width := 171;
//  lblUserInfo.Visible := (rzLeft.Width <> 35);
//  frmMain.OnResize(frmMain);
  UnSelect;
  frmRimIEBrowser.PageHandle := 0;
  frmXsmIEBrowser.PageHandle := 0;
  page_11.Down := true;
end;

procedure TfrmXsm2Main.InitRim;
begin
  if frmRimIEBrowser=nil then Application.CreateForm(TfrmRimIEBrowser,frmRimIEBrowser);
end;

function TfrmXsm2Main.XsmRegister: boolean;
var
  rs:TZQuery;
  Logined,Network:boolean;
  Chk,tid:string;
begin
  result := false;
  CaFactory.DownModule := true;
  CaFactory.Auto := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=0 and DEFINE=''TENANT_ID''';
    Global.LocalFactory.Open(rs);
    if rs.Fields[0].AsString='' then
       begin
         Logined := false;
       end
    else
       begin
         tid := rs.Fields[0].AsString;
         Global.TENANT_ID := strtoint(tid);
         Global.SHOP_ID := tid+'0001';
         rs.Close;
         rs.SQL.Text := 'select A.XSM_CODE,A.XSM_PSWD,B.TENANT_NAME,B.SHORT_TENANT_NAME,A.SHOP_ID from CA_SHOP_INFO A,CA_TENANT B where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SHOP_ID='''+Global.SHOP_ID+'''';
         Global.LocalFactory.Open(rs); 
         xsm_username := rs.Fields[0].AsString;
         xsm_password := DecStr(rs.Fields[1].AsString,ENC_KEY);
         Global.TENANT_NAME := rs.Fields[2].AsString;
         Global.SHORT_TENANT_NAME := rs.Fields[3].AsString;
         Global.UserID := rs.Fields[4].AsString;
         Global.UserName := rs.Fields[3].AsString;
         Global.Roles := 'xsm';
         Logined := (xsm_username<>'');
       end;
  finally
    rs.Free;
  end;
  Network := CAFactory.CheckNetwork;
  if not Logined and not Network then
     begin
       ShowMsgBox('初始登录必须在线状态，请检查网络是否正常','友情提示...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end
  else
     begin
       if Network and (Global.TENANT_ID>0) then
          begin
            case TfrmNetLogin.NetLogin(true) of
            1:;
            2:Network := false;
             else
              Exit;
            end;
           end;
     end;
  try
  if not Logined and Network then //没有注册过，登录新商盟检测注册
     begin
       while true do
       begin
         frmLogo.Close;
         if TfrmXsmLogin.XsmRegister then
            begin
              frmLogo.ShowTitle := '正在初始化新商盟...';
              frmLogo.Show;
              Chk := CaFactory.DesEncode(xsm_username,CaFactory.pubpwd);
              CaFactory.coLogin(xsm_username,chk,3);
              InitXsm;
              if frmXsmIEBrowser.XsmLogin(true) then break;
            end
         else
            Exit;
       end;
       try
         frmLogo.ShowTitle := '正在初始化新商盟...';
         frmLogo.Show;
         if not TfrmTenant.coAutoRegister(xsm_username,true) then
         begin
            ShowMsgBox(pchar('R3平台没有检测到'+xsm_username+'用户，请联系实施人员'),'友情提示...',MB_OK+MB_ICONINFORMATION);
            Exit;
         end;
       except
         on E:Exception do
         begin
            ShowMsgBox(pchar('R3用户认证失败,错误:'+E.Message+'，请联系实施人员'),'友情提示...',MB_OK+MB_ICONINFORMATION);
            Exit;
         end;
       end;
     end
  else
     begin
       if not Logined then Raise Exception.Create('首次注册必须使用在线模式...'); 
       if Network then
       begin
         frmLogo.ShowTitle := '正在初始化新商盟...';
         frmLogo.Show;
         try
           if not TfrmTenant.coAutoRegister(xsm_username,false) then
           begin
              ShowMsgBox(pchar('R3平台没有检测到'+xsm_username+'用户，请联系实施人员'),'友情提示...',MB_OK+MB_ICONINFORMATION);
              Exit;
           end;
         except
           on E:Exception do
           begin
             if ShowMsgBox(pchar('RSP服务认证失败，是否转脱网操作？'+#13+'原因：'+E.Message),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then
                Exit;
           end;
         end;
         InitXsm;
       end
     else
       begin
         InitXsm;
       end;
     end;
 InitRim;
 result := true;
 except
   on E:Exception do
     begin
       result := false;
       ShowMsgBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
     end;
 end;
end;

procedure TfrmXsm2Main.actfrmSyncAllExecute(Sender: TObject);
begin
  inherited;
  if CaFactory.Audited then
     begin
       CaFactory.SyncAll(1);
       if ShopGlobal.ONLVersion then Exit;
     end
  else
     begin
       if ShopGlobal.ONLVersion then Raise Exception.Create('网络版不需要执行数据同步...');
     end;
  if PrainpowerJudge.Locked>0 then
     begin
       ShowMsgBox('正在执行消息同步，请稍等数据上报..','友情提示..',MB_OK+MB_ICONINFORMATION);
     end;
  frmLogo.Show;
  frmLogo.ShowTitle := '正在连接远程服务器，请稍候...';
  try
    if ShopGlobal.offline and not Global.RemoteFactory.Connected then
     begin
       Global.MoveToRemate;
       try
         try
           Global.Connect;
         except
           Raise Exception.Create('连接远程数据库失败,无法完成数据同步...');
         end;
       finally
         Global.MoveToLocal;
       end;
     end;
    if not SyncFactory.CheckDBVersion then Raise Exception.Create('当前数据库版本跟服务器不一致，请先升级程序后再同步...');
    frmLogo.ShowTitle := '正在检测数据库锁，请稍候...';
    SyncFactory.SyncLockDb;
    if not SyncFactory.SyncLockCheck then
       begin
         if Global.UserID='system' then
            begin
              if ShowMsgBox('当前门店已经锁定电脑了不能执行数据同步，是否对远程数据库进行解锁？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
              SyncFactory.SyncUnLockDb;
              Exit;
            end
         else
         Raise Exception.Create('你当前使用的电脑不是门店指定的专用电脑，不能执行数据同步操作。');
       end;
    if TfrmCostCalc.CheckSyncReck(self) and not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion then TfrmCostCalc.TryCalcMthGods(self); 
    SyncFactory.SyncAll;
    Global.LoadBasic;
    ShopGlobal.LoadRight;
  finally
    frmLogo.Close;
  end;
end;

procedure TfrmXsm2Main.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmXsm2Main.RzBmpButton1Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if FindChildForm(TfrmPosMain)<>nil then Raise Exception.Create('收款机模块没有退出不能切换用户...');
  if FList.Count > 0 then
     begin
       if ShowMsgBox('是否关闭当前打开的所有模块？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       for i:= FList.Count -1 downto 0 do
         begin
           if TrzBmpButton(FList[i]).GroupIndex=999 then
              TForm(TrzBmpButton(FList[i]).tag).free;
         end;
     end;
  Clear;
  actfrmOpenDesk.OnExecute(actfrmOpenDesk); 
  if PrainpowerJudge.Locked>0 then
     begin
       ShowMsgBox('正在执行消息同步，请稍等切换用户..','友情提示..',MB_OK+MB_ICONINFORMATION);
     end;
  Logined := false;
  Login(false,false);
  Logined := true;
end;

procedure TfrmXsm2Main.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  actfrmSyncAll.OnExecute(actfrmSyncAll);
end;

procedure TfrmXsm2Main.Image9Click(Sender: TObject);
begin
  inherited;
  if CaFactory.Audited then Exit;
  ConnectToDb;  
end;

procedure TfrmXsm2Main.wm_check(var Message: TMessage);
begin
  try
  if (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) then Exit;
  if SyncFactory.firsted and CaFactory.Audited then
     begin
       if not Global.RemoteFactory.Connected then Exit;
       if ShowMsgBox('系统第一次初始化，将从服务器恢复业务数据，是否立即执行？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       SyncFactory.SyncLockDb;
       if not SyncFactory.SyncLockCheck then Raise Exception.Create('你当前使用的电脑不是门店指定的专用电脑，不能执行数据同步操作。'); 
       SyncFactory.SyncAll;
     end;
    TfrmCostCalc.CheckMonthReck(self);
  finally
    frmLogo.Close;
    if not TfrmInitGuide.InitGuide(self) then
       TfrmSaleAnalyMessage.ShowSaleAnalyMsg(self);
  end;
end;

destructor TfrmXsm2Main.Destroy;
var Form:TForm;
begin
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.free;
  inherited;
end;

procedure TfrmXsm2Main.RzTrayIcon1MinimizeApp(Sender: TObject);
var Form:TForm;
begin
  inherited;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMinimized;
end;

procedure TfrmXsm2Main.RzTrayIcon1RestoreApp(Sender: TObject);
var Form:TForm;
begin
  inherited;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMaximized;
end;

procedure TfrmXsm2Main.actfrmGoodsMonthExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := FindChildForm(TfrmGoodsMonth);
  if not Assigned(Form) then
  begin
    Form := TfrmGoodsMonth.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

function TfrmXsm2Main.mmcInit: boolean;
var
  RspComVersion:string;
begin
  frmLogo.Show;
  try
    result := false;
    Global.MoveToLocal;
    Global.Connect;
  if not UpdateDbVersion then Exit;
  LoadFrame;
  if CaFactory.Audited then
     begin
      if not CheckVersion then Exit;
     end;
  finally
    frmLogo.Close;
  end;
  if ShopGlobal.NetVersion or ShopGlobal.ONLVersion then
     begin
       frmLogo.Show;
       try
         frmLogo.ShowTitle := '检测远程应用服务器...';
         Global.MoveToRemate;
         try
           Global.Connect;
           with TCreateDbFactory.Create do
           begin
             try
                RspComVersion := Factor.ExecProc('TGetComVersion');
                if CheckVersion(DBVersion,Global.RemoteFactory) or CompareVersion(ComVersion,RspComVersion) then
                begin
                  if ShopGlobal.ONLVersion then
                     begin
                       ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器..','友情提示...',MB_OK+MB_ICONINFORMATION);
                       result := false;
                       Exit;
                     end;
                  result := (ShowMsgBox('服务器的版本过旧，请联系管理员升级后台服务器，是否转脱机使用？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6);
                  if result then
                    begin
                      Global.MoveToLocal;
                      Global.Connect;
                    end;
                end;
             finally
                free;
             end;
           end;
         except
           if ShopGlobal.ONLVersion then
              begin
                ShowMsgBox('连接数据库服务器失败,请检查网络是否正常?','友情提示...',MB_OK+MB_ICONQUESTION);
                result := false;
                Exit;
              end;
           result := (ShowMsgBox('连接远程数据库失败,是否转脱机操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);
           if result then
              begin
                Global.MoveToLocal;
                Global.Connect;
              end;
         end;
       finally
         frmLogo.Close;
       end;
     end;
  try
    frmLogo.Show;
    try
     if CaFactory.Audited and not ShopGlobal.ONLVersion then
        begin
          if not Global.RemoteFactory.Connected and not ShopGlobal.NetVersion then
             begin
               frmLogo.Label1.Caption := '正在连接远程服务...';
               frmLogo.Label1.Update;
               Global.MoveToRemate;
               try
                 try
                   Global.Connect;
                 except
                   ShowMsgBox('连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
                 end;
               finally
                 Global.MoveToLocal;
               end;
             end;
          if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
             begin
               InitTenant;
             end;
        end
     else
        begin
          InitTenant;
        end;
    finally
      frmLogo.Close;
    end;
   Logined := true;
   InitXsm;
   InitRim;
   frmXsmIEBrowser.mmc := true;
   frmXsmIEBrowser.SessionFail := (xsm_signature='');
   frmLogo.Show;
   try
     frmLogo.ShowTitle := '正在初始化基础数据...';
     Global.LoadBasic();
     frmLogo.ShowTitle := '正在初始化权限数据...';
     ShopGlobal.LoadRight;
     CheckEnabled;
     frmXsm2Desk.CA_MODULE := CA_MODULE;
     frmLogo.ShowTitle := '正在初始化同步数据...';
     ShopGlobal.SyncTimeStamp;
     if CaFactory.Audited and Global.RemoteFactory.Connected and not frmXsmIEBrowser.SessionFail then
        begin
          frmLogo.ShowTitle := '正在登录零售终端管理平台...';
          frmLogo.Show;
          frmLogo.BringToFront;
          frmRimIEBrowser.ReadParam;
          frmRimIEBrowser.DoLogin(false,true);
        end;
     frmLogo.ShowTitle := '正在初始化广告数据...';
     if frmRimIEBrowser.Logined then AdvFactory.LoadAdv;
     frmLogo.ShowTitle := '正在初始化桌面数据...';
     frmXsm2Desk.loadDesk;
   finally
     frmLogo.Close;
   end;
   PostMessage(Handle,WM_CHECK_MSG,0,0);
   Application.Minimize;
   frmXsm2Main.Show;
   frmXsm2Main.WindowState := wsMaximized;
   Application.Restore;
   BringToFront;
   LoadFrame;
   result := true;
  except
    on E:Exception do
      begin
        ShowMsgBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONERROR);
        result := false;
      end;
  end;
end;

procedure TfrmXsm2Main.mc_login(var Message: TMessage);
begin
   Global.TENANT_ID := MMClient.MMLogin.tenantId;
   Global.TENANT_NAME := MMClient.MMLogin.tenantName;
   Global.SHORT_TENANT_NAME := MMClient.MMLogin.shortTenantName;
   Global.SHOP_ID := MMClient.MMLogin.shopId;
   Global.SHOP_NAME := MMClient.MMLogin.shopName;
   Global.UserID := MMClient.MMLogin.userId;
   Global.UserName := MMClient.MMLogin.userName;
   CaFactory.Audited := (MMClient.MMLogin.loginStatus=1);
   xsm_username := MMClient.MMLogin.xsmUserName;
   xsm_password := MMClient.MMLogin.xsmPassword;
   xsm_signature := MMClient.MMLogin.xsmSignature;
   xsm_challenge := MMClient.MMLogin.xsmSignature;
   if MMClient.MMLogin.xsmStatus = 2 then
      xsm_challenge := '';
   CaFactory.auto := true;
   if not mmcInit then Application.Terminate;
end;

procedure TfrmXsm2Main.mc_quit(var Message: TMessage);
begin
  if frmXsmIEBrowser<>nil then
     begin
       frmXsmIEBrowser.mmc := false;
       frmXsmIEBrowser.SessionFail := true;
     end;
  if not Logined then Application.Terminate;
end;

procedure TfrmXsm2Main.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  ShellExecute(0,'open',pchar(ExtractFilePath(ParamStr(0))+'简易操作手册.chm'),nil,pchar(ExtractFileDir(ParamStr(0))),1);
end;

procedure TfrmXsm2Main.RzBmpButton5Click(Sender: TObject);
var
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
  Action:TAction;
begin
  inherited;
  if not CA_MODULE.Locate('MODU_NAME','在线客服',[]) then Raise Exception.Create('你没有开通在线客服业务');
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not Logined then
     begin
       PostMessage(frmXsm2Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmXsm2Desk.Locked := false;
  Form := FindChildForm('frmRimIEBrowser');
  if not Assigned(Form) then
     Form := TfrmRimIEBrowser.Create(self);
  sl := TStringList.Create;
  try
    if TfrmBasic(Form).PageHandle = Integer(Sender) then
       begin
         Form.WindowState := wsMaximized;
         Form.BringToFront;
         Exit;
       end;
    Form.Caption := TrzBmpButton(Sender).Caption;
    Form.Name := 'frmRimIEBrowser';
    sl.CommaText := s;
    if TfrmRimIEBrowser(Form).OpenUrl(sl.values['url'],Integer(Sender),(sl.values['xsm']='true')) then
       begin
         TfrmBasic(Form).PageHandle := Integer(Sender);
       end
    else
       DoActiveChange(nil);
  finally
    sl.free;
  end;
end;

procedure TfrmXsm2Main.actfrmInitGuideExecute(Sender: TObject);
begin
  inherited;
  TfrmInitGuide.StartGuide(self);
end;

procedure TfrmXsm2Main.RzBmpButton6Click(Sender: TObject);
begin
  inherited;
  TfrmSaleAnalyMessage.ShowSaleAnalyMsg(self);
end;

end.

