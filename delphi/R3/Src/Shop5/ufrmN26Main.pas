unit ufrmN26Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, StdCtrls, jpeg,
  RzBmpBtn, RzLabel,MultInst, RzBckgnd, Buttons, RzPanel, ufrmBasic, ToolWin,
  RzButton, ZBase, ufrmInstall, RzStatus, RzTray, ShellApi, ZdbFactory,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalc, ObjCommon,RzGroupBar,ZDataSet, ImgList, RzTabs, OleCtrls, SHDocVw,
  DB, ZAbstractRODataset, ZAbstractDataset,ufrmHintMsg;
const
  WM_LOGIN_REQUEST=WM_USER+10;
  WM_CHECK_MSG=WM_USER+2565;
type
  TfrmN26Main = class(TfrmMain)
    mnuWindow: TMenuItem;
    Panel5: TPanel;
    Image3: TImage;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    fdsfds1: TMenuItem;
    rzLeft: TRzPanel;
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
    Panel7: TPanel;
    Panel8: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Image15: TImage;
    ImageList1: TImageList;
    Image19: TImage;
    RzGroupBar1: TRzGroupBar;
    actfrmMeaUnits: TAction;
    actfrmDutyInfoList: TAction;
    actfrmRoleInfoList: TAction;
    actfrmDeptInfoList: TAction;
    actfrmUsers: TAction;
    actfrmBrandInfo: TAction;
    actfrmFactoryInfo: TAction;
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
    Label2: TLabel;
    Panel21: TPanel;
    Image2: TImage;
    Panel22: TPanel;
    Image13: TImage;
    Image22: TImage;
    Panel23: TPanel;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    toolButton: TRzBmpButton;
    Panel24: TPanel;
    Image26: TImage;
    Panel26: TPanel;
    Image28: TImage;
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
    RzLabel1: TRzLabel;
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
    CA_MODULE: TZQuery;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel4: TPanel;
    Image5: TImage;
    Image6: TImage;
    Panel2: TPanel;
    Image4: TImage;
    Label1: TLabel;
    Panel6: TPanel;
    Panel19: TPanel;
    Image20: TImage;
    lblUserInfo: TRzLabel;
    Panel18: TPanel;
    Image17: TImage;
    Panel17: TPanel;
    Image7: TImage;
    Image8: TImage;
    RzBmpButton10: TRzBmpButton;
    RzBmpButton9: TRzBmpButton;
    RzBmpButton8: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    rzTool: TPanel;
    Image21: TImage;
    Panel12: TPanel;
    Image14: TImage;
    Panel14: TPanel;
    Image9: TImage;
    Panel13: TPanel;
    Image1: TImage;
    Panel15: TPanel;
    Image10: TImage;
    Image11: TImage;
    rzChildTitle: TRzLabel;
    RzBmpButton3: TRzBmpButton;
    Panel3: TPanel;
    Panel16: TPanel;
    Image16: TImage;
    rzToolButton: TPanel;
    Image27: TImage;
    Panel20: TPanel;
    Image12: TImage;
    Panel9: TPanel;
    ImageList4: TImageList;
    RzPanel2: TRzPanel;
    rzPage: TRzTabControl;
    Panel25: TPanel;
    actfrmN26Net: TAction;
    procedure FormActivate(Sender: TObject);
    procedure fdsfds1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N68Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N90Click(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure RzBmpButton10Click(Sender: TObject);
    procedure RzBmpButton8Click(Sender: TObject);
    procedure RzTabChange(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure RzBmpButton9Click(Sender: TObject);
    procedure toolButtonClick(Sender: TObject);
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
    procedure RzBmpButton3Click(Sender: TObject);
    procedure actfrmRecvDayReportExecute(Sender: TObject);
    procedure actfrmPayDayReportExecute(Sender: TObject);
    procedure actfrmRecvAbleReportExecute(Sender: TObject);
    procedure actfrmPayAbleReportExecute(Sender: TObject);
    procedure actfrmStorageTrackingExecute(Sender: TObject);
    procedure actfrmDbDayReportExecute(Sender: TObject);
    procedure actfrmGodsRunningReportExecute(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure tlbCloseClick(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure actfrmIoroDayReportExecute(Sender: TObject);
    procedure actfrmMessageExecute(Sender: TObject);
    procedure actfrmNewPaperReaderExecute(Sender: TObject);
    procedure actfrmQuestionnaireExecute(Sender: TObject);
    procedure RzBmpButton11Click(Sender: TObject);
    procedure RzBmpButton12Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure RzBmpButton13Click(Sender: TObject);
    procedure RzBmpButton14Click(Sender: TObject);
    procedure RzBmpButton15Click(Sender: TObject);
    procedure sDeskPageClick(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
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
    procedure rzPageChange(Sender: TObject);
    procedure actfrmN26NetExecute(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzTrayIcon1MinimizeApp(Sender: TObject);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
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
    procedure DoLoadMsg(Sender:TObject);
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure SortToolButton;
    procedure SortPageButton;
    procedure WMQUERYENDSESSION(var msg:Tmessage);Message  WM_QUERYENDSESSION;
    procedure wm_Login(var Message: TMessage); message WM_LOGIN_REQUEST;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure wm_message(var Message: TMessage); message MSC_MESSAGE;
    procedure wm_check(var Message: TMessage); message WM_CHECK_MSG;
    procedure SetLogined(const Value: boolean);
    function  CheckVersion:boolean;
    function  ConnectToDb:boolean;
    //p1 -rsp
    //p2 ���Ӵ�
    //p3 ��ҵ��
    //p4 ��Ʒ��
    //p5 ��ҵ��
    function  ConnectToRsp:boolean;
    function  ConnectToXsm:boolean;
    function  UpdateDbVersion:boolean;
    procedure SetLoging(const Value: boolean);
    procedure SetSystemShutdown(const Value: boolean);
    procedure InitTenant;
    procedure DoPageClick(Sender:TObject);
  public
    { Publicdeclarations }
    destructor Destroy; override;
    procedure LoadPic32;
    procedure LoadMenu(Sender:TObject);
    procedure LoadFrame;
    procedure InitVersioin;
    function GetDeskFlag:string;
    procedure CheckEnabled;
    procedure DoConnectError(Sender:TObject);
    function Login(Locked:boolean=false;Exited:boolean=true):boolean;
    procedure WriteAction(s:string;flag:integer);
    procedure AddFrom(form:TForm);
    procedure RemoveFrom(form:TForm);
    property Logined:boolean read FLogined write SetLogined;
    property Loging:boolean read FLoging write SetLoging;
    property SystemShutdown:boolean read FSystemShutdown write SetSystemShutdown;
  end;

var
  frmN26Main: TfrmN26Main;

implementation
uses
  uDsUtil,uFnUtil,ufrmLogo,uTimerFactory,ufrmTenant,ufrmN26Desk, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogin,
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
  ufrmInitialRights,ufrmN26Browser;
{$R *.dfm}

procedure TfrmN26Main.FormActivate(Sender: TObject);
begin
  inherited;
  //if not systemShutdown and not Application.Terminated then WindowState := wsMaximized;
end;

procedure TfrmN26Main.fdsfds1Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;


procedure TfrmN26Main.FormCreate(Sender: TObject);
var
  F:TextFile;
  i:integer;
begin
  inherited;
  IsXsm := false;
  LoadPic32;
  FList := TList.Create;
//  PagePanel.Visible := (sflag='s1_');
  PageList := TList.Create;
  frmLogo := TfrmLogo.Create(nil);
  frmPrgBar := TfrmPrgBar.Create(nil);
  ForceDirectories(ExtractFilePath(ParamStr(0))+'temp');
  ForceDirectories(ExtractFilePath(ParamStr(0))+'debug');
  SystemShutdown := false;
  Loging :=false;
  frmInstall := TfrmInstall.Create(self);
  screen.OnActiveFormChange := DoActiveChange;
  RzVersionInfo.FilePath := ParamStr(0);
  LoadFrame;
  TimerFactory := nil;

end;

procedure TfrmN26Main.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  if TimerFactory<>nil then FreeAndNil(TimerFactory);
  frmLogo.Free;
  frmPrgBar.Free;
  if frmInstall<>nil then frmInstall.free;
  screen.OnActiveFormChange := nil;
  for i:=0 to FList.Count - 1 do TObject(FList[i]).Free;
  inherited;
  FList.Free;
  PageList.Free;
end;

procedure TfrmN26Main.AddFrom(form: TForm);
var
  button:TrzBmpButton;
begin
//  if FList.Count > 5 then Exit;
  button := TrzBmpButton.Create(rzToolButton);
  button.GroupIndex := 999;
  button.Bitmaps.Up.Assign(toolButton.Bitmaps.Up);
  button.Bitmaps.Down.Assign(toolButton.Bitmaps.Down);
  button.Font.Assign(toolButton.Font);
  button.Caption := form.Caption;
  button.Tag := Integer(Pointer(form));
  button.OnClick := DoActiveForm;
  button.Visible := true;
  button.Parent := rzToolButton;
  button.PopupMenu := tlbPage;
  FList.Add(button);
  SortToolButton;
  button.Down := true;
  TfrmBasic(Form).OnFreeForm := DoFreeForm;
  TfrmBasic(Form).PageHandle := Integer(Button);
  rzChildTitle.Caption := '��ǰλ��->'+form.Caption;
end;

procedure TfrmN26Main.RemoveFrom(form: TForm);
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

procedure TfrmN26Main.DoActiveForm(Sender: TObject);
begin
  TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
  TForm(TrzBmpButton(Sender).tag).BringToFront;
  TrzBmpButton(Sender).Down := true;
end;

procedure TfrmN26Main.SortToolButton;
var
  i:Integer;
  button:TrzBmpButton;
begin
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Top := 0;
      if i=0 then
         button.Left := 0
      else
         button.Left := TrzBmpButton(FList[i-1]).Left+TrzBmpButton(FList[i-1]).width+5;
    end;
end;

procedure TfrmN26Main.DoActiveChange(Sender: TObject);
var
  i:integer;
  SOn:TNotifyEvent;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(screen.ActiveForm)) then
         begin
           TrzBmpButton(FList[i]).Caption :=  screen.ActiveForm.Caption;
           TrzBmpButton(FList[i]).Down := true;
           rzChildTitle.Caption := '��ǰλ��->'+Screen.ActiveForm.Caption;
           break;
         end;
    end;
end;

procedure TfrmN26Main.DoFreeForm(Sender: TObject);
var
  i:integer;
begin
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
  SortToolButton;
end;

function TfrmN26Main.CheckVersion:boolean;
function GetFileNameFromURL(url: string): string;
var ts : TStrings;
begin
  //��urlȡ���ļ���
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
     if (MessageBox(Application.Handle,pchar('ϵͳ�����°汾'+CaUpgrade.Version+'���Ƿ�����������'),'������ʾ...',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       if (CaUpgrade.UpGrade=1) then
          begin
            MessageBox(Application.Handle,pchar('��ʹ�õ������汾���ɣ�û�������޷�����ʹ��.'),'������ʾ...',MB_OK+MB_ICONQUESTION);
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
           Raise Exception.Create('���������ļ�ʧ�ܣ�ϵͳ�޷��������');
      finally
        frmInstall.free;
      end;
     end;
     result := true;
  except
    on E:Exception do
       begin
         MessageBox(application.Handle,pchar('����ʧ��,����:'+E.Message),'������ʾ...',MB_OK+MB_ICONQUESTION);
         result := false;
       end;
  end;
end;
function TfrmN26Main.Login(Locked:boolean=false;Exited:boolean=true):boolean;
var
  Params:ufrmLogin.TLoginParam;
  lDate:TDate;
  AObj:TRecord_;
begin
  if TimerFactory<>nil then FreeAndNil(TimerFactory);
  try
  if not Logined or Locked then
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
     result := true;
  if Locked then Exit;
  if Logined then
     begin
       Loging := false;
       frmLogo.Show;
       try
         if CaFactory.Audited then
            begin
              if not FindCmdLineSwitch('DEBUG',['-','+'],false) then //ͬ���ŵ�ר������
                 begin
                   if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then SyncFactory.SyncBasic(false);
                 end;
            end;
         frmLogo.Show;
         frmLogo.BringToFront;
         Global.LoadBasic();
         frmLogo.ShowTitle := '��ʼ��Ȩ��,���Ժ�...';
         ShopGlobal.LoadRight;
         CheckEnabled;
         CA_MODULE.Close;
         frmLogo.ShowTitle := '��ʼ���˵�,���Ժ�...';
         LoadMenu(nil);
         ShopGlobal.SyncTimeStamp;
         frmLogo.ShowTitle := '��ʼ�����,���Ժ�...';
         frmN26Desk.loadDesk;
         if not Locked and (DevFactory.ReadDefine('AUTORUNPOS','0')='1') and (ParamStr(1)<>'-xsm') and ShopGlobal.GetChkRight('500028') then
         begin
            PostMessage(Handle,WM_DESKTOP_REQUEST,13100001,0);
         end;
         PostMessage(Handle,WM_CHECK_MSG,0,0);
       finally
         frmLogo.Close;
       end;
     end
  else
     begin
       Logined := false;
       result := Logined;
       if Global.TENANT_ID = 0 then
          begin
            PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,1,1);
            Exit;
          end
       else
          begin
            if Exited then Application.Terminate;
          end;
     end;
  finally
     LoadFrame;
     if Logined then TimerFactory := TTimerFactory.Create(DoLoadMsg,120000);
     Timer1.Enabled := true;
  end;
end;

procedure TfrmN26Main.wm_Login(var Message: TMessage);
var prm:string;
begin
  if Logined then Exit;
  CaFactory.DownModule := true;
  try
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
         if not ConnectToDb then
           begin
             Application.Terminate;
             Exit;
           end
         else
           Logined := false;
       end;
    Logined := Login(false);
    if not frmN26Main.Visible and Logined and not IsXsm then
    begin
      Application.Minimize;
      frmN26Main.Show;
      frmN26Main.WindowState := wsMaximized;
      Application.Restore;
    end;
  except
    on E:Exception do
       begin
         MessageBox(Handle,pchar(E.Message),'������ʾ...',MB_OK+MB_ICONWARNING);
         Application.Terminate;
         Exit;
       end;
  end;
end;

procedure TfrmN26Main.SetLogined(const Value: boolean);
var s:string;
begin
  FLogined := Value;
  if not Value then Timer1.Enabled := Value;
  if Value then
     lblUserInfo.Caption := '�û���:'+Global.UserName
  else
     lblUserInfo.Caption := 'δ��¼...';
end;

procedure TfrmN26Main.miCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmN26Main.FormShow(Sender: TObject);
begin
  inherited;
  UpdateTimer.Enabled := true;
end;

procedure TfrmN26Main.CheckEnabled;
var
  i:integer;
  rs:TZQuery;
begin
  for i:=0 to actList.ActionCount -1 do
    begin
      TAction(actList.Actions[i]).Enabled := (TAction(actList.Actions[i]).Tag=0);
      if TAction(actList.Actions[i]).Tag > 0 then
         TAction(actList.Actions[i]).Enabled := ShopGlobal.GetChkRight(inttostr(TAction(actList.Actions[i]).tag),1);
    end;
  actfrmDbOrderList.Enabled := actfrmDbOrderList.Enabled and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion);
  actfrmDbDayReport.Enabled := actfrmDbDayReport.Enabled and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion);
  rs := Global.GetZQueryFromName('CA_TENANT');
  if rs.Locate('TENANT_ID',Global.TENANT_ID,[]) then
     actfrmRelation.Enabled := actfrmRelation.Enabled and (rs.FieldbyName('TENANT_TYPE').asInteger<>3)
  else
     actfrmRelation.Enabled := false;
end;

procedure TfrmN26Main.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
function CheckUpdateStatus:boolean;
begin
  result := (Factor.ExecProc('TGetLastUpdateStatus')='1'); 
end;
begin
  inherited;
  if CaFactory.Audited and not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion and Global.RemoteFactory.Connected and CheckUpdateStatus and SyncFactory.CheckDBVersion then
     begin
       if MessageBox(Handle,'Ϊ������ݰ�ȫ�������˳�ǰ�ϱ�ҵ�����ݣ��Ƿ�����ִ�У�','������ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
          begin
            if TimerFactory<>nil then FreeAndNil(TimerFactory);
            SyncFactory.SyncAll;
          end;
     end;
  if not SystemShutdown and (MessageBox(Handle,'�Ƿ��˳�ϵͳ��','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       CanClose := false;
       //Application.Minimize;
     end;
end;

procedure TfrmN26Main.N68Click(Sender: TObject);
begin
  inherited;
  if Logined then
  begin
    frmN26Main.Show;
    frmN26Main.WindowState := wsMaximized;
    Application.Restore;
  end;
end;

procedure TfrmN26Main.wm_desktop(var Message: TMessage);
var
  i:integer;
  Form:TfrmBasic;
begin
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMinimized;
  if Message.WParam=0 then
     begin
       RzBmpButton3Click(nil);
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

procedure TfrmN26Main.WMQUERYENDSESSION(var msg: Tmessage);
begin
  SystemShutdown := true;
  if frmInstall<>nil then FreeAndNil(frmInstall);
  Factor.DisConnect;
  inherited;
end;

function TfrmN26Main.UpdateDbVersion: boolean;
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

procedure TfrmN26Main.Timer1Timer(Sender: TObject);
var
  P:PMsgInfo;
begin
  inherited;
  if PrainpowerJudge.Locked>0 then Exit;
  if SystemShutdown then Exit;
  if not Logined then Exit;
  if not Visible then Exit;
  if not Factor.Connected then Exit;

  if (not MsgFactory.Loaded and (Timer1.Tag>5)) or (MsgFactory.Loaded and (Timer1.Tag>0) and
     (MsgFactory.UnRead=0) and ((Timer1.Tag mod 120)=0)
     )
  then
   MsgFactory.Load;

  if Timer1.Tag >= 120 then Timer1.Tag := 0 else Timer1.Tag := Timer1.Tag + 1;
  if MsgFactory.Count > 0 then
     begin
       lblUserInfo.Caption := ShopGlobal.UserName + ' ����('+inttostr(MsgFactory.UnRead)+')����Ϣ';
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
       lblUserInfo.Caption := ShopGlobal.UserName + ' ��û����Ϣ';
     end;
  if (MsgFactory.Loaded and ((Timer1.Tag mod 120)=0)) then
     begin
       P := MsgFactory.ReadMsg;
       if P<>nil then MsgFactory.HintMsg(P);
     end;
end;

procedure TfrmN26Main.LoadFrame;
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    Caption :=  F.ReadString('soft','name','��������R3')+' �汾:'+RzVersionInfo.FileVersion;
    if ShopGlobal.offline then
       Caption := Caption +'���ѻ�ʹ�á��ŵ꣺'+ Global.SHOP_NAME
    else
       Caption := Caption +'������ʹ�á��ŵ꣺'+ Global.SHOP_NAME;
    Application.Title :=  F.ReadString('soft','name','��������R3');
    RzLabel1.Caption := F.ReadString('soft','copyright','')+' | ʹ�õ�λ:'+Global.TENANT_NAME;
    if not FindCmdLineSwitch('rsp',['-','+'],false) then
       begin
          SFVersion := F.ReadString('soft','SFVersion','.NET');
          CLVersion := F.ReadString('soft','CLVersion','.MKT');
          ProductID := F.ReadString('soft','ProductID','R3_RYC');
       end;
  finally
    F.Free;
  end;
  if FileExists(ExtractFilePath(ParamStr(0))+'logo_lt.jpg') then
    Image5.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'logo_lt.jpg');
end;

procedure TfrmN26Main.SetLoging(const Value: boolean);
begin
  FLoging := Value;
end;

procedure TfrmN26Main.SetSystemShutdown(const Value: boolean);
begin
  FSystemShutdown := Value;
end;

procedure TfrmN26Main.InitVersioin;
begin

end;

procedure TfrmN26Main.N90Click(Sender: TObject);
var
  HWndCalculator : HWnd;
begin
  // �����Ѵ��ڵļ���������
  HWndCalculator :=FindWindow(nil, '������');
  if HWndCalculator <> 0 then SendMessage(HWndCalculator, WM_CLOSE, 0, 0);// close the exist Calculator
  ShellExecute(Handle,'open','calc.exe',nil,nil,SW_SHOW);

end;

procedure TfrmN26Main.UpdateTimerTimer(Sender: TObject);
begin
  inherited;
  Label2.Caption := '��ǰʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
end;

procedure TfrmN26Main.RzBmpButton10Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmN26Main.LoadMenu(Sender:TObject);
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
function CheckRight(btn:TRzTabCollectionItem):boolean;
var
  rs:TZQuery;
  lvid:string;
begin
  result := false;
  rs := CA_MODULE;
  if not rs.Locate('MODU_ID',inttostr(btn.Tag),[]) then Exit;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  rs.First;
  while not rs.Eof do
    begin
      if (copy(rs.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid) and (rs.FieldbyName('LEVEL_NUM').AsInteger =3) then
         begin
           if FindAction(rs.FieldbyName('ACTION_NAME').AsString)<>nil then
           begin
             result := true;
             Exit;
           end;
         end;
      rs.Next;
    end;
end;
procedure CreatePageButton(Id,Title:string);
var
  btn:TRzTabCollectionItem;
  w:widestring;
  i:integer;
begin
  btn := rzPage.Tabs.Add;
  btn.ImageIndex := 0;
  btn.Tag := StrtoInt(Id);
  btn.Caption := ' '+Title;
end;
procedure CreatePageMenu;
var
  i:integer;
begin
  rzPage.Tabs.Clear;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if CA_MODULE.FieldbyName('LEVEL_NUM').AsInteger =1 then
      begin
        CreatePageButton(CA_MODULE.FieldbyName('MODU_ID').AsString,CA_MODULE.FieldbyName('MODU_NAME').AsString);
      end;
      CA_MODULE.Next;
    end;
  for i:=0 to rzPage.Tabs.Count -1 do
     begin
       CheckRight(rzPage.Tabs.Items[i]);
     end;
  if rzPage.Tabs.Count >0 then
     begin
       rzPage.TabIndex := 0;
       rzPage.OnChange(rzPage);
     end;
end;
var
  rs:TZQuery;
  g:TrzGroup;
  b:TrzGroupItem;
  i,r:integer;
  lvid:string;
begin
  for i:=RzGroupBar1.GroupCount -1 downto 0 do
    begin
      RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
    end;
  if not CA_MODULE.Active then
     begin
       CA_MODULE.Filtered := false;
       CA_MODULE.Close;
       CA_MODULE.SQL.Text := ParseSQL(Factor.iDbType,'select MODU_ID,MODU_NAME,ACTION_NAME,len(LEVEL_ID)/3 as LEVEL_NUM,LEVEL_ID,ACTION_URL from CA_MODULE where PROD_ID='''+ProductID+''' and MODU_TYPE in (1,3) and COMM not in (''02'',''12'') order by LEVEL_ID');
       Factor.Open(CA_MODULE);
       CreatePageMenu;
     end;
  if Sender=nil then Exit;
  rs := CA_MODULE;
  try
  if not rs.Locate('MODU_ID',inttostr(TRzTabCollectionItem(Sender).Tag),[]) then Exit;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  rs.First;
  while not rs.Eof do
    begin
      if (copy(rs.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid) and (rs.FieldbyName('LEVEL_NUM').AsInteger =2) then
         begin
           g := TrzGroup.Create(RzGroupBar1);
           g.Caption := rs.FieldbyName('MODU_NAME').AsString;
           g.CaptionColor := clWhite;
           g.Color := clWhite;
//           g.CaptionColor := $00E4D2AD;
           g.CaptionHeight := 35;
           g.DividerVisible := true;
           g.CaptionImageIndex := 0;
           RzGroupBar1.AddGroup(g);
           inc(r);
           // if r>3 then g.Close;
         end
      else
      if (copy(rs.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid) and (rs.FieldbyName('LEVEL_NUM').AsInteger =3) then
         begin
           if FindAction(rs.FieldbyName('ACTION_NAME').AsString)<>nil then
           begin
             b := g.Items.Add;
             b.OnClick := FindAction(rs.FieldbyName('ACTION_NAME').AsString).OnExecute;
             b.tag := strtoint(rs.FieldbyName('MODU_ID').asString);
             b.Caption := rs.FieldbyName('MODU_NAME').AsString;
             b.ImageIndex := 1;
           end;
         end;
      rs.Next;
    end;
  finally
  end;
  for i:=RzGroupBar1.GroupCount -1 downto 0 do
    begin
      if RzGroupBar1.Groups[i].Items.Count =0 then
         RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
    end;
end;

procedure TfrmN26Main.RzBmpButton8Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmN26Main.RzTabChange(Sender: TObject);
begin
  inherited;
//  if rzLeft.Width = 33 then rzLeft.Width := 172;
//  if Logined then LoadMenu;
end;

procedure TfrmN26Main.Image19Click(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 29 then
     begin
       rzLeft.Width := 172;
       Panel12.Width := 174;
       Panel24.Width := 166;
     end
  else
     begin
       rzLeft.Width := 29;
       Panel12.Width := 31;
       Panel24.Width := 23;
     end;

  frmMain.OnResize(nil);
end;

procedure TfrmN26Main.RzBmpButton9Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if FindChildForm(TfrmPosMain)<>nil then Raise Exception.Create('�տ��ģ��û���˳������л��û�...');
  if FList.Count > 0 then
     begin
       if MessageBox(Handle,'�Ƿ�رյ�ǰ�򿪵�����ģ�飿','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       for i:= FList.Count -1 downto 0 do
         TForm(TrzBmpButton(FList[i]).tag).free;
     end;
  if PrainpowerJudge.Locked>0 then
     begin
       MessageBox(Handle,'����ִ����Ϣͬ�������Ե��л��û�..','������ʾ..',MB_OK+MB_ICONINFORMATION);
     end;
  if FList.Count=0 then
     begin
       Logined := false;
       Logined := Login(false,false);
     end;
end;

procedure TfrmN26Main.toolButtonClick(Sender: TObject);
begin
  inherited;
  frmDesk.ForeBringtoFront;
  rzLeft.Width := 147;
  frmDesk.OnResize(nil);
end;

procedure TfrmN26Main.DoConnectError(Sender: TObject);
begin

end;

function TfrmN26Main.GetDeskFlag: string;
begin

end;

procedure TfrmN26Main.InitTenant;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    frmLogo.Label1.Caption := '���ڳ�ʼ��Ĭ������...';
    frmLogo.Label1.Update;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.ExecProc('TTenantInit',Params);
    TfrmInitialRights.Rights(self);
  finally
    Params.Free;
  end;
end;
function TfrmN26Main.ConnectToDb:boolean;
var RspComVersion:string;
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
  result := TfrmTenant.coRegister(self);
  if result then LoadFrame;
  if result and CaFactory.Audited then result := CheckVersion;
  if not result then Exit;
  if result then
     begin
      if ShopGlobal.NetVersion or ShopGlobal.ONLVersion then
         begin
           frmLogo.Show;
           try
             frmLogo.ShowTitle := '���Զ��Ӧ�÷�����...';
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
                           MessageBox(Handle,'�������İ汾���ɣ�����ϵ����Ա������̨������..','������ʾ...',MB_OK+MB_ICONINFORMATION);
                           result := false;
                           Exit;
                         end;
                      result := (MessageBox(Handle,'�������İ汾���ɣ�����ϵ����Ա������̨���������Ƿ�ת�ѻ�ʹ�ã�','������ʾ..',MB_YESNO+MB_ICONQUESTION)=6);
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
                    if MessageBox(Handle,'�������ݿ������ʧ��,���������Ƿ�����,�Ƿ�����ѡ������������','������ʾ...',MB_YESNO+MB_ICONQUESTION)=6 then
                       TfrmHostDialog.HostDialog(self);
                    result := false;
                    Exit;
                  end;
               result := (MessageBox(Handle,'����Զ�����ݿ�ʧ��,�Ƿ�ת�ѻ�����?','������ʾ...',MB_YESNO+MB_ICONQUESTION)=6);
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
               frmLogo.Label1.Caption := '��������Զ�̷���...';
               frmLogo.Label1.Update;
               Global.MoveToRemate;
               try
                 try
                   Global.Connect;
                 except
                   MessageBox(Handle,'����Զ�̷�����ʧ�ܣ�ϵͳ�޷�ͬ������������..','������ʾ...',MB_OK+MB_ICONWARNING);
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
          if CaFactory.Audited and Global.RemoteFactory.Connected then //����ʲô�汾�������ӵ�������ʱ��������ͬ������
             begin
               if ShopGlobal.ONLVersion then //���߰�ֻ��ͬ��ע������
                  begin
                    if Global.RemoteFactory.ConnString<>Global.LocalFactory.ConnString then //����ģʽʱ����ͬ��
                    begin
                      SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                      SyncFactory.SyncComm := SyncFactory.CheckRemeteData;
                      SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSingleTable',0);
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
        MessageBox(Handle,pchar(E.Message),'������ʾ...',MB_OK+MB_ICONERROR);
        result := false;
      end;
  end;
end;

procedure TfrmN26Main.actfrmMeaUnitsExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  Application.Restore;
  frmN26Desk.SaveToFront;
  with TfrmMeaUnits.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;

end;

procedure TfrmN26Main.actfrmDutyInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
//  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmDutyInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDutyInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmRoleInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
//  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRoleInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmRoleInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmDeptInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
//  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmDeptInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDeptInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmUsersExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
//  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmUsers);
  if not Assigned(Form) then
     begin
       Form := TfrmUsers.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmBrandInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,4);
end;

procedure TfrmN26Main.actfrmStockOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
//  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStockOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStockOrderList.Create(self);
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('400020') then TfrmStockOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmSalesOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSalesOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalesOrderList.Create(self);
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('400020') then TfrmSalesOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmChangeOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm('frmChangeOrderList1');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '1';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList1';
       AddFrom(Form);
//       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmChangeOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm('frmChangeOrderList2');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '2';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList2';
       AddFrom(Form);
       if ShopGlobal.GetChkRight('600029') then TfrmChangeOrderList(Form).actNew.OnExecute(nil);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmGoodsInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmGoodsInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmGoodsInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmGoodsSortExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  if TfrmGoodsSortTree.ShowDialog(self,1) then
  begin
    Form:=FindChildForm(TfrmGoodsInfoList);
    if Form<>nil then
      TfrmGoodsInfoList(Form).LoadTree;
  end;
end;

procedure TfrmN26Main.actfrmCodeInfo3Execute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,3);
end;

procedure TfrmN26Main.actfrmSortInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,2);
end;

procedure TfrmN26Main.actfrmImplInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,5);
end;

procedure TfrmN26Main.actfrmAreaInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,6);
end;

procedure TfrmN26Main.actfrmSaleStyleExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,2);
end;

procedure TfrmN26Main.actfrmSettleCodeExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,6);
end;

procedure TfrmN26Main.actfrmShopGroupExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,12);
end;

procedure TfrmN26Main.actfrmRecvOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmRecvOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmPayOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmPayOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPayOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmClientExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
// Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmClient);
  if not Assigned(Form) then
     begin
       Form := TfrmClient.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmSupplierExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSupplier);
  if not Assigned(Form) then
     begin
       Form := TfrmSupplier.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmSalRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSalRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStkRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('�ݲ�֧������ʹ��,������,����ע...');
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStkRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmPosMainExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmPriceGradeInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmPriceGradeInfo.ShowDialog(self);

end;

procedure TfrmN26Main.actfrmSalIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSalIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStkIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStkIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmInvoiceExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmInvoice);
  if not Assigned(Form) then
     begin
       Form := TfrmInvoice.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmCustomerExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmCostCalcExecute(Sender: TObject);
begin
  inherited;
{  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCostCalc.StartCalc(self); }
end;

procedure TfrmN26Main.actfrmSysDefineExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  with TfrmSysDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmN26Main.actfrmDaysCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCostCalc.StartDayReck(self);
end;

procedure TfrmN26Main.actfrmMonthCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmCostCalc.StartMonthReck(self);

end;

procedure TfrmN26Main.actfrmCloseForDayExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  if TfrmCloseForDay.ShowClDy(self)=2 then ;// MessageBox(Handle,'����û��Ӫҵ���ݣ�����Ҫ����','������ʾ...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmN26Main.actfrmPriceOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmPriceOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPriceOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;

end;

procedure TfrmN26Main.actfrmCheckOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmDbOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmDbOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmDbOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmShopInfoListExecute(Sender: TObject);
var
  Form:TfrmBasic;
  AObj:TRecord_;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmAccountExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmAccount);
  if not Assigned(Form) then
     begin
       Form := TfrmAccount.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmTransOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmTransOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmTransOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmDevFactoryExecute(Sender: TObject);
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

procedure TfrmN26Main.actfrmIoroOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmIoroOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmCheckTablePrintExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmRckMngExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRckMng);
  if not Assigned(Form) then
  begin
    Form := TfrmRckMng.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmJxcTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmJxcTotalReport);
  if not Assigned(Form) then
  begin
    Form := TfrmJxcTotalReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStockDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStockDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStockDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmSaleDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmChange1DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmChange2DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmLockScreenExecute(Sender: TObject);
begin
  inherited;
  frmN26Desk.HookLocked := true;
  try
    Login(true);
  finally
    frmN26Desk.HookLocked := false;
  end;

end;

procedure TfrmN26Main.actfrmStorageDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStorageDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmRckDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRckDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRckDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmRelationExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRelation);
  if not Assigned(Form) then
  begin
    Form := TfrmRelation.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 29 then rzLeft.Width := 172;
  if Panel12.Width = 31 then Panel12.Width := 174;
  if Panel24.Width = 23 then Panel24.Width := 166;
  frmMain.OnResize(nil);
  frmN26Desk.Locked := true;
  frmN26Desk.BringToFront;
end;

procedure TfrmN26Main.actfrmRecvDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmPayDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmPayDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmRecvAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmPayAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmPayAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStorageTrackingExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmDbDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmDbDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmDbDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmGodsRunningReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmGodsRunningReport);
  if not Assigned(Form) then
  begin
    Form := TfrmGodsRunningReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  if CaFactory.Audited then
     begin
       CaFactory.SyncAll(1);
       if ShopGlobal.ONLVersion then Exit;
     end
  else
     begin
       if ShopGlobal.ONLVersion then Raise Exception.Create('����治��Ҫִ������ͬ��...');
     end;
  if PrainpowerJudge.Locked>0 then
     begin
       MessageBox(Handle,'����ִ����Ϣͬ�������Ե������ϱ�..','������ʾ..',MB_OK+MB_ICONINFORMATION);
     end;
  if ShopGlobal.offline and not Global.RemoteFactory.Connected then
     begin
       Global.MoveToRemate;
       try
         try
           Global.Connect;
         except
           Raise Exception.Create('����Զ�����ݿ�ʧ��,�޷��������ͬ��...');
         end;
       finally
         Global.MoveToLocal;
       end;
     end;
  if not SyncFactory.CheckDBVersion then Raise Exception.Create('��ǰ���ݿ�汾����������һ�£����������������ͬ��...');
  SyncFactory.SyncAll;
  frmLogo.Show;
  try
    Global.LoadBasic;
    ShopGlobal.LoadRight;
  finally
    frmLogo.Close;
  end;
end;

procedure TfrmN26Main.RzBmpButton13Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',5) then Raise Exception.Create('��û�е���ȷ��Ȩ��,��͹���Ա��ϵ.');
  actfrmDownIndeOrder.Execute;
end;

procedure TfrmN26Main.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('11200001',2) then Raise Exception.Create('��û�е���ȷ��Ȩ��,��͹���Ա��ϵ.');
  actfrmDownIndeOrder.OnExecute(actfrmDownIndeOrder);
end;

procedure TfrmN26Main.tlbCloseClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).Down and (TrzBmpButton(FList[i]).Tag>0) then
         begin
           TfrmBasic(TrzBmpButton(FList[i]).Tag).Close;
           break;
         end;
    end;
end;

procedure TfrmN26Main.N103Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;

procedure TfrmN26Main.actfrmIoroDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmIoroDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmIoroDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmMessageExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmMessage);
  if not Assigned(Form) then
  begin
    Form := TfrmMessage.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmNewPaperReaderExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmNewPaperReader.ShowNewsPaper('');
end;

procedure TfrmN26Main.WriteAction(s: string;flag:integer);
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
    F.Free;
  end;
end;

procedure TfrmN26Main.actfrmQuestionnaireExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  TfrmQuestionnaire.ShowForm(self);
end;

procedure TfrmN26Main.LoadPic32;
var
  DllHandle: THandle;
function GetBitmap(ResName:string):TBITMAP;
var
  Stream: TStream;
begin
  result := nil;
  //װ��Logo
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
  //װ��Logo
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
  sflag := 's'+GetResString(1)+'_';
  if DllHandle > 0 then 
  try
    //logo
    Image5.Picture.Graphic  := GetJpeg(sflag+'logo_lt');
    Image6.Picture.Graphic  := GetJpeg(sflag+'logo_bg');
    Image20.Picture.Graphic  := GetJpeg(sflag+'logo_r1');
    Image17.Picture.Graphic  := GetJpeg(sflag+'logo_r2');
    Image8.Picture.Graphic  := GetJpeg(sflag+'logo_r3');
    Image7.Picture.Graphic  := GetJpeg(sflag+'logo_r4');
    
    Image14.Picture.Graphic  := GetJpeg(sflag+'menu_title');

    Image11.Picture.Graphic  := GetJpeg(sflag+'tool_01');
    Image10.Picture.Graphic  := GetJpeg(sflag+'tool_02');
    Image16.Picture.Graphic  := GetJpeg(sflag+'tool_03');
    Image27.Picture.Graphic  := GetJpeg(sflag+'tool_04');
    Image21.Picture.Graphic  := GetJpeg(sflag+'tool_05');

//    Image18.Picture.Graphic  := GetJpeg(sflag+'page_bg');
    Image19.Picture.Graphic  := GetJpeg(sflag+'split');

    Image22.Picture.Graphic  := GetJpeg(sflag+'foot_1');
    Image15.Picture.Graphic  := GetJpeg(sflag+'foot_2');
    Image23.Picture.Graphic  := GetJpeg(sflag+'foot_3');
    Image24.Picture.Graphic  := GetJpeg(sflag+'foot_4');
    Image25.Picture.Graphic  := GetJpeg(sflag+'foot_bg');


    toolButton.Bitmaps.Up := GetBitmap(sflag+'toolbutton');
    toolButton.Bitmaps.Down := GetBitmap(sflag+'toolbutton_hot');
    RzBmpButton3.Bitmaps.Up := GetBitmap(sflag+'desktop');
    RzBmpButton3.Bitmaps.Hot := GetBitmap(sflag+'desktop_hot');

    RzBmpButton10.Bitmaps.Up := GetBitmap(sflag+'password');
    RzBmpButton10.Bitmaps.Hot := GetBitmap(sflag+'password_hot');
    RzBmpButton9.Bitmaps.Up := GetBitmap(sflag+'logout');
    RzBmpButton9.Bitmaps.Hot := GetBitmap(sflag+'logout_hot');
    RzBmpButton8.Bitmaps.Up := GetBitmap(sflag+'exit');
    RzBmpButton8.Bitmaps.Hot := GetBitmap(sflag+'exit_hot');

    RzBmpButton6.Bitmaps.Up := GetBitmap(sflag+'home');
    RzBmpButton6.Bitmaps.Hot := GetBitmap(sflag+'home_hot');
//    RzBmpButton1.Bitmaps.Up := GetBitmap(sflag+'xsm');
//    RzBmpButton1.Bitmaps.Hot := GetBitmap(sflag+'xsm_hot');
    RzBmpButton2.Bitmaps.Up := GetBitmap(sflag+'down');
    RzBmpButton2.Bitmaps.Hot := GetBitmap(sflag+'down_hot');
    RzBmpButton4.Bitmaps.Up := GetBitmap(sflag+'upload');
    RzBmpButton4.Bitmaps.Hot := GetBitmap(sflag+'upload_hot');
    RzBmpButton5.Bitmaps.Up := GetBitmap(sflag+'help');
    RzBmpButton5.Bitmaps.Hot := GetBitmap(sflag+'help_hot');

  finally
    if DllHandle > 0 then FreeLibrary(DllHandle);
  end;
end;

procedure TfrmN26Main.RzBmpButton11Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmN26Main.RzBmpButton12Click(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmN26Main.RzBmpButton7Click(Sender: TObject);
begin
  inherited;
  if ShopGlobal.offline and not Global.RemoteFactory.Connected then
     begin
       Global.MoveToRemate;
       try
         try
           Global.Connect;
         except
           Raise Exception.Create('����Զ�����ݿ�ʧ��,�޷��������ͬ��...'); 
         end;
       finally
         Global.MoveToLocal;
       end;
     end;
  if not SyncFactory.CheckDBVersion then Raise Exception.Create('��ǰ���ݿ�汾����������һ�£����������������ͬ��...');
  SyncFactory.SyncAll;
  Global.LoadBasic;
end;

procedure TfrmN26Main.RzBmpButton14Click(Sender: TObject);
begin
  inherited;
  actfrmQuestionnaire.OnExecute(actfrmQuestionnaire);
end;

procedure TfrmN26Main.RzBmpButton15Click(Sender: TObject);
begin
  inherited;
  actfrmMessage.OnExecute(actfrmMessage);
end;

procedure TfrmN26Main.sDeskPageClick(Sender: TObject);
begin
  inherited;
  RzBmpButton3Click(nil);
end;

procedure TfrmN26Main.RzBmpButton6Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'лл��Ĺ�ע����վ���ڸ�����...','������ʾ..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmN26Main.actfrmInLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmInLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmInLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmOutLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
 // Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmOutLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmOutLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.SortPageButton;
var
  i,n:integer;
begin
  n := 0;
  for i:=PageList.Count -1 downto 0 do
    begin
      if not TRzBmpButton(PageList[i]).Visible then
         PageList.Delete(i); 
    end;
  for i:=0 to PageList.Count -1 do
    begin
      if i=0 then
         TRzBmpButton(PageList[i]).Top := 1
      else
         TRzBmpButton(PageList[i]).Top := TRzBmpButton(PageList[i-1]).top + TRzBmpButton(PageList[i-1]).height + 1;
      inc(n);
    end;
end;

procedure TfrmN26Main.lblUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmN26Main.actfrmDownIndeOrderExecute(Sender: TObject);
var
  vData: OleVariant;
  Aobj: TRecord_;
  Form: TfrmBasic;
  SaveFactor:TdbFactory;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  if not Global.RemoteFactory.Connected then 
     begin
       if MessageBox(Handle,'��ǰ�����Ѿ��Ͽ����Ƿ�������Զ�̷�������','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       SaveFactor := uGlobal.Factor;
       try
         Global.MoveToRemate;
         try
           Global.Connect;
         except
           MessageBox(Handle,'�޷����ӵ�Զ�̷����������������Ƿ�����','������ʾ...',MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
       finally
         uGlobal.Factor := SaveFactor;
       end;
     end;

  Application.Restore;
  frmN26Desk.SaveToFront;
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
        //Application.Restore;
        frmN26Desk.SaveToFront;
        Form := FindChildForm(TfrmStockOrderList);
        if not Assigned(Form) then
        begin
          Form := TfrmStockOrderList.Create(self);
          AddFrom(Form);
        end;
        TfrmStockOrderList(Form).DoIndeOrderWriteToStock(Aobj,vData);
        Form.WindowState := wsMaximized;
        Form.BringToFront;
      end;
    end;
  finally
    Aobj.Free;
  end;
  
end;

procedure TfrmN26Main.actfrmRecvForDayExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmRecvPosList);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvPosList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmN26Main.rzUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmN26Main.actfrmImpeachExecute(Sender: TObject);
begin
  inherited;
  TfrmImpeach.ShowImpeach(self); 
end;

procedure TfrmN26Main.actfrmClearDataExecute(Sender: TObject);
begin
  inherited;
  TfrmClearData.DeleteDB(self);

end;

function TfrmN26Main.ConnectToRsp: boolean;
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
  if pos(';',ParamStr(2))>0 then //������ֺţ�����û�������
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
           MessageBox(Handle,'�������İ汾���ɣ�����ϵ����Ա������̨������..','������ʾ...',MB_OK+MB_ICONINFORMATION);
           result := false;
           Exit;
        end;
     finally
        free;
     end;
   end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TENANT_ID,TENANT_NAME,SHORT_TENANT_NAME from CA_TENANT where TENANT_ID='+ParamStr(3);
    Factor.Open(rs);
    if rs.IsEmpty then
       begin
         MessageBox(Handle,'�����������ҵ����Ч..','������ʾ...',MB_OK+MB_ICONINFORMATION);
         result := false;
       end;
    Global.TENANT_ID := rs.Fields[0].AsInteger;
    Global.TENANT_NAME := rs.Fields[1].AsString;
    Global.SHOP_ID := rs.Fields[0].AsString+'0001';
    Global.SHOP_NAME := rs.Fields[2].AsString;
    Global.UserID := 'system';
    Global.UserName := 'ϵͳ�û�';
  finally
    rs.Free;
  end;
  LoadFrame;
  ProductId := ParamStr(4);
  SFVersion := '.ONL';
  CLVersion := ParamStr(5);
  result := true;
end;

procedure TfrmN26Main.actfrmSaleAnalyExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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
     end;
end;

procedure TfrmN26Main.wm_message(var Message: TMessage);
begin
  if Message.WParam = 99 then //ִ���Զ�����ȷ��
  begin
     if Global.UserID='system' then Exit;
     TfrmDownStockOrder.AutoDownStockOrder(inttostr(Message.LParam));
  end;
end;

procedure TfrmN26Main.actfrmNetForOrderExecute(Sender: TObject);
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
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
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
    if rimurl='' then Raise Exception.Create('�޷����ӵ������ն˷������������ʵʩ��Ա��ϵ.'); 
    if rimuid='' then Raise Exception.Create('��ǰ��¼�ŵ������֤����Ч���������޸���ȷ������֤��.'); 
  finally
    Params.Free;
  end;
  Application.Restore;
  frmN26Desk.SaveToFront;
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

procedure TfrmN26Main.actfrmSaleManSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleManSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleManSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmClientSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmClientSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmClientSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.DoLoadMsg(Sender: TObject);
begin
  if not Visible then Exit;
  if SyncFactory.Locked > 0 then Exit;
  PrainpowerJudge.SyncMsgc;
end;

procedure TfrmN26Main.actfrmSaleTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStgTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStgTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStgTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.actfrmStockTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmStockTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStockTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

function TfrmN26Main.ConnectToXsm: boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
var
  mm,chk,tid,fn:string;
function  CheckParams:boolean;
begin
 try
  mm := ParamStr(2);
  if (copy(mm,1,3)<>'-mm') then Raise Exception.Create('���Ĳ�����Ч���������Ķ�ͨѶЭ���ĵ�');
  mm := copy(mm,5,255);

  chk := ParamStr(3);
  if (copy(chk,1,4)<>'-chk') then Raise Exception.Create('���Ĳ�����Ч���������Ķ�ͨѶЭ���ĵ�');
  chk := copy(chk,6,255);
  if chk<>md5Encode(mm+dec) then Raise Exception.Create('ϵͳ�����У������Ч..');

  tid := ParamStr(5);
  if copy(tid,1,3)<>'-id' then Raise Exception.Create('���Ĳ�����Ч���������Ķ�ͨѶЭ���ĵ�');
  tid := copy(tid,5,255);

  fn := ParamStr(4);
  if copy(fn,1,3)<>'-fn' then Raise Exception.Create('���Ĳ�����Ч���������Ķ�ͨѶЭ���ĵ�');
  fn := copy(fn,5,255);
  result := true;

 except
   on E:Exception do
      begin
        MessageBox(Handle,Pchar(E.Message),'������ʾ...',MB_OK+MB_ICONINFORMATION);
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
    if rs.Fields[0].asString<>tid then //����ͬҪ�Զ�ע��
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
                           MessageBox(Handle,'�������İ汾���ɣ�����ϵ����Ա������̨������..','������ʾ...',MB_OK+MB_ICONINFORMATION);
                           result := false;
                           Exit;
                         end;
                      result := (MessageBox(Handle,'�������İ汾���ɣ�����ϵ����Ա������̨���������Ƿ�ת�ѻ�ʹ�ã�','������ʾ..',MB_YESNO+MB_ICONQUESTION)=6);
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
                    if MessageBox(Handle,'�������ݿ������ʧ��,���������Ƿ�����,�Ƿ�����ѡ������������','������ʾ...',MB_YESNO+MB_ICONQUESTION)=6 then
                       TfrmHostDialog.HostDialog(self);
                    result := false;
                    Exit;
                  end;
               result := (MessageBox(Handle,'����Զ�����ݿ�ʧ��,�Ƿ�ת�ѻ�����?','������ʾ...',MB_YESNO+MB_ICONQUESTION)=6);
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
               frmLogo.Label1.Caption := '��������Զ�̷���...';
               frmLogo.Label1.Update;
               Global.MoveToRemate;
               try
                 try
                   Global.Connect;
                 except
                   MessageBox(Handle,'����Զ�̷�����ʧ�ܣ�ϵͳ�޷�ͬ������������..','������ʾ...',MB_OK+MB_ICONWARNING);
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
          if CaFactory.Audited and Global.RemoteFactory.Connected then //����ʲô�汾�������ӵ�������ʱ��������ͬ������
             begin
               if CaFactory.CheckInitSync then CaFactory.SyncAll(1);
               if ShopGlobal.ONLVersion then //���߰�ֻ��ͬ��ע������
                  begin
                    SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                    SyncFactory.SyncComm := not SyncFactory.CheckRemeteData;
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
        MessageBox(Handle,pchar(E.Message),'������ʾ...',MB_OK+MB_ICONERROR);
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
      Global.UserName := '����Ա';
      result := true;
    end;
  IsXsm := true;
  PostMessage(Handle,WM_DESKTOP_REQUEST,StrtoIntDef(fn,0),1);
end;

procedure TfrmN26Main.RzTrayIcon1LButtonDblClick(Sender: TObject);
begin
  inherited;
  if Logined then
  begin
    frmN26Main.Show;
    frmN26Main.WindowState := wsMaximized;
  end;
end;

procedure TfrmN26Main.actfrmSaleMonthTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmN26Main.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmSaleMonthTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleMonthTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmN26Main.DoPageClick(Sender: TObject);
begin
  LoadMenu(Sender);
end;

procedure TfrmN26Main.rzPageChange(Sender: TObject);
var i:integer;
begin
  inherited;
  if rzPage.TabIndex<0 then Exit;
  for i:=0 to rzPage.Tabs.Count -1 do rzPage.Tabs[i].ImageIndex := 0;
  LoadMenu(rzPage.Tabs[rzPage.TabIndex]);
  rzPage.Tabs[rzPage.TabIndex].ImageIndex := 1;
end;

procedure TfrmN26Main.wm_check(var Message: TMessage);
begin
  if (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) then Exit;
  if SyncFactory.firsted and CaFactory.Audited then
     begin
       if not Global.RemoteFactory.Connected then Exit;
       if MessageBox(Handle,'ϵͳ��һ�γ�ʼ�������ӷ������ָ�ҵ�����ݣ��Ƿ�����ִ�У�','������ʾ...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       SyncFactory.SyncAll;
     end;
  TfrmCostCalc.CheckMonthReck(self);
end;

procedure TfrmN26Main.actfrmN26NetExecute(Sender: TObject);
var
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
begin
  inherited;
  if not CA_MODULE.Locate('MODU_ID',inttostr(TRzGroupItem(Sender).Tag),[]) then Raise Exception.Create('û�ҵ���Ӧ��ģ��ID='+inttostr(TrzBmpButton(Sender).Tag));
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not Logined then
     begin
       PostMessage(frmMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmN26Desk.SaveToFront;
  Form := FindChildForm(TfrmN26Browser);
  if not Assigned(Form) then
     begin
       Form := TfrmN26Browser.Create(self);
       Form.Caption := CA_MODULE.FieldbyName('MODU_NAME').asString;
       AddFrom(Form);
       if not TfrmN26Browser(Form).DoLogin then Exit;
     end;
  sl := TStringList.Create;
  try
    Form.Caption := CA_MODULE.FieldbyName('MODU_NAME').asString;
    sl.CommaText := s;
    TfrmN26Browser(Form).OpenUrl(ExtractFilePath(ParamStr(0))+sl.values['url']);
    DoActiveChange(Form);
  except
    sl.free;
    Raise;
  end;
end;

procedure TfrmN26Main.RzBmpButton1Click(Sender: TObject);
var
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
  Action:TAction;
begin
  inherited;
  if not CA_MODULE.Locate('MODU_NAME','���϶���',[]) then Raise Exception.Create('��û�п�ͨ���϶���ҵ��');
  if CA_MODULE.FieldByName('ACTION_NAME').AsString='actfrmN26Net' then
     begin
        s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
        delete(s,1,4);
        delete(s,length(s),1);
        if not Logined then
           begin
             PostMessage(frmMain.Handle,WM_LOGIN_REQUEST,0,0);
             Exit;
           end;
        Application.Restore;
        frmN26Desk.SaveToFront;
        Form := FindChildForm(TfrmN26Browser);
        if not Assigned(Form) then
           begin
             Form := TfrmN26Browser.Create(self);
             Form.Caption := CA_MODULE.FieldbyName('MODU_NAME').asString;
             AddFrom(Form);
             if not TfrmN26Browser(Form).DoLogin then Exit;
           end;
        sl := TStringList.Create;
        try
          Form.Caption := CA_MODULE.FieldbyName('MODU_NAME').asString;
          sl.CommaText := s;
          TfrmN26Browser(Form).OpenUrl(ExtractFilePath(ParamStr(0))+sl.values['url']);
          DoActiveChange(Form);
        except
          sl.free;
          Raise;
        end;
    end
  else
    begin
       Action := FindAction(CA_MODULE.FieldByName('ACTION_NAME').AsString);
       if Action=nil then Exit;
       if not Action.Enabled then Raise Exception.Create('��û�в�����ģ���Ȩ��');
       Action.OnExecute(Action); 
    end;
end;

destructor TfrmN26Main.Destroy;
var Form:TForm;
begin
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.free;
  inherited;
end;

procedure TfrmN26Main.RzTrayIcon1MinimizeApp(Sender: TObject);
var Form:TForm;
begin
  inherited;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMinimized;
end;

procedure TfrmN26Main.RzTrayIcon1RestoreApp(Sender: TObject);
var Form:TForm;
begin
  inherited;
  Form := FindChildForm(TfrmPosMain);
  if Form<>nil then Form.WindowState := wsMaximized;
end;

end.






