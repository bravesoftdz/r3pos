unit ufrmShopMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, StdCtrls, jpeg,
  RzBmpBtn, RzLabel, RzBckgnd, Buttons, RzPanel, ufrmBasic, ToolWin,
  RzButton, ZBase, MultInst, ufrmInstall, RzStatus, RzTray, ShellApi, ZdbFactory,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalc, ObjCommon,RzGroupBar,ZDataSet, ImgList, RzTabs, OleCtrls, SHDocVw,
  DB, ZAbstractRODataset, ZAbstractDataset;
const
  WM_LOGIN_REQUEST=WM_USER+10;
type
  TfrmShopMain = class(TfrmMain)
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
    ImageList2: TImageList;
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
    CA_MODULE: TZQuery;
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
    ImageList3: TImageList;
    Panel25: TPanel;
    Image18: TImage;
    toolButton: TRzBmpButton;
    Page1: TRzBmpButton;
    Page2: TRzBmpButton;
    Page3: TRzBmpButton;
    Page4: TRzBmpButton;
    Page5: TRzBmpButton;
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
    rzLogo: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
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
    RzPanel2: TRzPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Image29: TImage;
    Image30: TImage;
    Panel29: TPanel;
    Image31: TImage;
    Label3: TLabel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Image33: TImage;
    Panel33: TPanel;
    Image34: TImage;
    Image35: TImage;
    RzBmpButton7: TRzBmpButton;
    RzBmpButton11: TRzBmpButton;
    RzBmpButton12: TRzBmpButton;
    s2_Page1: TRzBmpButton;
    s2_Page2: TRzBmpButton;
    s2_Page4: TRzBmpButton;
    sDeskPage: TRzBmpButton;
    s2_Page3: TRzBmpButton;
    Panel34: TPanel;
    Image36: TImage;
    Panel35: TPanel;
    Image37: TImage;
    Panel36: TPanel;
    Image38: TImage;
    Panel37: TPanel;
    Image39: TImage;
    Panel38: TPanel;
    Image40: TImage;
    Image41: TImage;
    RzLabel3: TRzLabel;
    Panel39: TPanel;
    Panel40: TPanel;
    rzs2ToolButton: TPanel;
    Panel42: TPanel;
    Image44: TImage;
    Panel43: TPanel;
    s2_Page5: TRzBmpButton;
    Image32: TImage;
    Image45: TImage;
    Image42: TImage;
    Image43: TImage;
    RzBmpButton13: TRzBmpButton;
    RzBmpButton14: TRzBmpButton;
    RzBmpButton15: TRzBmpButton;
    rzUserInfo: TRzLabel;
    RzLabel1: TRzLabel;
    actfrmInLocusOrderList: TAction;
    actfrmOutLocusOrderList: TAction;
    actfrmDownIndeOrder: TAction;
    actfrmRecvForDay: TAction;
    actfrmImpeach: TAction;
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
    procedure actfrmXsmBrowserExecute(Sender: TObject);
    procedure actfrmAccountExecute(Sender: TObject);
    procedure actfrmTransOrderListExecute(Sender: TObject);
    procedure actfrmDevFactoryExecute(Sender: TObject);
    procedure CA_MODULEFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
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
    procedure Page1Click(Sender: TObject);
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
    procedure s2_Page1Click(Sender: TObject);
    procedure sDeskPageClick(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure actfrmInLocusOrderListExecute(Sender: TObject);
    procedure actfrmOutLocusOrderListExecute(Sender: TObject);
    procedure lblUserInfoClick(Sender: TObject);
    procedure actfrmDownIndeOrderExecute(Sender: TObject);
    procedure actfrmRecvForDayExecute(Sender: TObject);
    procedure rzUserInfoClick(Sender: TObject);
    procedure actfrmImpeachExecute(Sender: TObject);
  private
    { Private declarations }
    FList:TList;
    PageList:TList;
    FLogined: boolean;
    frmInstall:TfrmInstall;
    FLoging: boolean;
    FSystemShutdown: boolean;
    sflag:string;
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure SortToolButton;
    procedure SortPageButton;
    procedure WMQUERYENDSESSION(var msg:Tmessage);Message  WM_QUERYENDSESSION;
    procedure wm_Login(var Message: TMessage); message WM_LOGIN_REQUEST;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure SetLogined(const Value: boolean);
    function  CheckVersion:boolean;
    function  ConnectToDb:boolean;
    function  UpdateDbVersion:boolean;
    procedure SetLoging(const Value: boolean);
    procedure SetSystemShutdown(const Value: boolean);
  public
    { Publicdeclarations }
    procedure LoadPic32;
    procedure LoadMenu;
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
  frmShopMain: TfrmShopMain;

implementation
uses
  uFnUtil,ufrmLogo,ufrmTenant,ufrmShopDesk, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogin,
  ufrmDesk,ufrmPswModify,ufrmDutyInfoList,ufrmRoleInfoList,ufrmMeaUnits,ufrmDeptInfo,ufrmUsers,ufrmStockOrderList,
  ufrmSalesOrderList,ufrmChangeOrderList,ufrmGoodsSortTree,ufrmGoodsSort,ufrmGoodsInfoList,ufrmCodeInfo,ufrmRecvOrderList,
  ufrmPayOrderList,ufrmClient,ufrmSupplier,ufrmSalRetuOrderList,ufrmStkRetuOrderList,ufrmPosMain,uDevFactory,ufrmPriceGradeInfo,
  ufrmSalIndentOrderList,ufrmStkIndentOrderList,ufrmInvoice,ufrmCustomer,ufrmCostCalc,ufrmSysDefine,ufrmPriceOrderList,
  ufrmCheckOrderList,ufrmCloseForDay,ufrmDbOrderList,ufrmShopInfoList,ufrmIEWebForm,ufrmAccount,ufrmTransOrderList,ufrmDevFactory,
  ufrmIoroOrderList,ufrmCheckTablePrint,ufrmRckMng,ufrmJxcTotalReport,ufrmStockDayReport,ufrmDeptInfoList,ufrmSaleDayReport,
  ufrmChangeDayReport,ufrmStorageDayReport,ufrmRckDayReport,ufrmRelation,uSyncFactory,ufrmRecvDayReport,ufrmPayDayReport,
  ufrmRecvAbleReport,ufrmPayAbleReport,ufrmStorageTracking,ufrmDbDayReport,ufrmGodsRunningReport,uCaFactory,ufrmIoroDayReport,
  ufrmHintMsg,ufrmMessage,ufrmNewsPaperReader,ufrmShopInfo,ufrmQuestionnaire,ufrmInLocusOrderList,ufrmOutLocusOrderList,
  ufrmDownStockOrder,ufrmRecvPosList,ufrmHostDialog,ufrmImpeach;
{$R *.dfm}

procedure TfrmShopMain.FormActivate(Sender: TObject);
begin
  inherited;
//if not systemShutdown and not Application.Terminated then WindowState := wsMaximized;
end;

procedure TfrmShopMain.fdsfds1Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;


procedure TfrmShopMain.FormCreate(Sender: TObject);
var
  F:TextFile;
  i:integer;
begin
  inherited;
  for i:=0 to rzLogo.PageCount -1 do rzLogo.Pages[i].TabVisible := false;
  LoadPic32;
  Panel25.Visible := (sflag='s1_');
  PageList := TList.Create;
  frmLogo := TfrmLogo.Create(nil);
  ForceDirectories(ExtractFilePath(ParamStr(0))+'temp');
  ForceDirectories(ExtractFilePath(ParamStr(0))+'debug');
  SystemShutdown := false;
  Loging :=false;
  frmInstall := TfrmInstall.Create(self);
  FList := TList.Create;
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
end;

procedure TfrmShopMain.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  frmLogo.Free;
  if frmInstall<>nil then frmInstall.free;
  screen.OnActiveFormChange := nil;
  for i:=0 to FList.Count - 1 do TObject(FList[i]).Free;
  inherited;
  FList.Free;
  PageList.Free;
end;

procedure TfrmShopMain.AddFrom(form: TForm);
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
  if sflag='s1_' then
    button.Parent := rzToolButton
  else
    button.Parent := rzs2ToolButton;
  button.PopupMenu := tlbPage;
  FList.Add(button);
  SortToolButton;
  button.Down := true;
  TfrmBasic(Form).OnFreeForm := DoFreeForm;
  rzChildTitle.Caption := '当前位置->'+form.Caption;
end;

procedure TfrmShopMain.RemoveFrom(form: TForm);
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

procedure TfrmShopMain.DoActiveForm(Sender: TObject);
begin
  TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
  TForm(TrzBmpButton(Sender).tag).BringToFront;
  TrzBmpButton(Sender).Down := true;
end;

procedure TfrmShopMain.SortToolButton;
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

procedure TfrmShopMain.DoActiveChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(screen.ActiveForm)) then
         begin
           TrzBmpButton(FList[i]).Down := true;
           rzChildTitle.Caption := '当前位置->'+Screen.ActiveForm.Caption;
           break;
         end;
    end;
end;

procedure TfrmShopMain.DoFreeForm(Sender: TObject);
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

function TfrmShopMain.CheckVersion:boolean;
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
     if (MessageBox(Application.Handle,pchar('系统检测的新版本'+CaUpgrade.Version+'，是否立即升级？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       if (CaUpgrade.UpGrade=1) then
          begin
            MessageBox(Application.Handle,pchar('你使用的软件版本过旧，没有升级无法继续使用.'),'友情提示...',MB_OK+MB_ICONQUESTION);
            Exit
          end else CaUpgrade.UpGrade := 0;
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
         MessageBox(application.Handle,pchar('升级失败,错误:'+E.Message),'友情提示...',MB_OK+MB_ICONQUESTION);
         result := false;
       end;
  end;
end;
function TfrmShopMain.Login(Locked:boolean=false;Exited:boolean=true):boolean;
var
  Params:ufrmLogin.TLoginParam;
  lDate:TDate;
  AObj:TRecord_;
begin
  Logined := false;
  Logined := TfrmLogin.doLogin(SysId,Locked,Params,lDate);
  result := Logined;
  if Locked then Exit;
  if Logined then
     begin
       Loging := false;
       frmLogo.Show;
       try
         Global.SHOP_ID := Params.ShopId;
         Global.SHOP_NAME := Params.ShopName;
         Global.UserID := Params.UserID;
         Global.UserName := Params.UserName;
         Global.Roles := Params.Roles;
         Global.CloseAll;
         Global.SysDate := lDate;

         if CaFactory.Audited then
            begin
              //if not Global.RemoteFactory.Connected and not ShopGlobal.NetVersion then
              //   begin
              //     Global.MoveToRemate;
              //     try
              //       try
              //         Global.Connect;
              //       except
              //         MessageBox(Handle,'连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
              //       end;
              //     finally
              //       Global.MoveToLocal;
              //     end;
              //   end;
              if not FindCmdLineSwitch('DEBUG',['-','+'],false) then //同步门店专用资料
                 begin
                   if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then SyncFactory.SyncBasic(false);
                 end;
            end;

         Global.LoadBasic();
         ShopGlobal.LoadRight;
         CheckEnabled;
         CA_MODULE.Close;
         LoadMenu;
       finally
         frmLogo.Close;
       end;
       ShopGlobal.SyncTimeStamp;
//       Factor.ExecProc('TGetXDictInfo');
//       MsgFactory.Load;
//       Timer1.OnTimer(nil);
       if not Locked and (DevFactory.ReadDefine('AUTORUNPOS','0')='1') and ShopGlobal.GetChkRight('500028')
       then
       begin
          PostMessage(Handle,WM_DESKTOP_REQUEST,500054,0);
       end;   
     end
  else
     begin
       Logined := false;
       result := Logined;
       if Global.TENANT_ID = 0 then
          begin
            PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,1,1);
            Exit;
          end
       else
          begin
            if Exited then Application.Terminate;
          end;
     end;
  LoadFrame;
end;

procedure TfrmShopMain.wm_Login(var Message: TMessage);
var prm:string;
begin
  if Logined then Exit;
  try
    if not ConnectToDb then
       begin
         Application.Terminate;
         Exit;
       end;
    Logined := Login(false);
    if not frmShopMain.Visible and Logined then
    begin
      frmShopMain.Show;
      frmShopMain.WindowState := wsMaximized;
    end;    
  except
    on E:Exception do
       begin
         MessageBox(Handle,pchar(E.Message),'友情提示...',MB_OK+MB_ICONWARNING);
         Application.Terminate;
         Exit;
       end;
  end;
end;

procedure TfrmShopMain.SetLogined(const Value: boolean);
var s:string;
begin
  FLogined := Value;
  Timer1.Enabled := Value;
//  if ShopGlobal.offline then s := '【脱机使用】' else s := '【联机使用】';
  if Value then
     lblUserInfo.Caption := '用户名:'+Global.UserName
  else
     lblUserInfo.Caption := '未登录...';
  rzUserInfo.Caption := lblUserInfo.Caption;
end;

procedure TfrmShopMain.miCloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmShopMain.FormShow(Sender: TObject);
begin
  inherited;
  UpdateTimer.Enabled := true;
end;

procedure TfrmShopMain.CheckEnabled;
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

procedure TfrmShopMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
function CheckUpdateStatus:boolean;
begin
  result := (Factor.ExecProc('TGetLastUpdateStatus')='1'); 
end;
begin
  inherited;
  if CaFactory.Audited and not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion and Global.RemoteFactory.Connected and CheckUpdateStatus and SyncFactory.CheckDBVersion then
     begin
       if MessageBox(Handle,'为你的数据安全，请在退出前上报业务数据，是否立即执行？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6 then
          begin
            SyncFactory.SyncAll;
          end;
     end;
  if not SystemShutdown and (MessageBox(Handle,'是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       CanClose := false;
       //Application.Minimize;
     end;
end;

procedure TfrmShopMain.N68Click(Sender: TObject);
begin
  inherited;
  Application.Restore;
end;

procedure TfrmShopMain.wm_desktop(var Message: TMessage);
var
  i:integer;
begin
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
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

procedure TfrmShopMain.WMQUERYENDSESSION(var msg: Tmessage);
begin
  SystemShutdown := true;
  if frmInstall<>nil then FreeAndNil(frmInstall);
  Factor.DisConnect;
  inherited;
end;

function TfrmShopMain.UpdateDbVersion: boolean;
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

procedure TfrmShopMain.Timer1Timer(Sender: TObject);
var
  P:PMsgInfo;
begin
  inherited;
  if SystemShutdown then Exit;
  if not Logined then Exit;
  if not Visible then Exit;
  if not Factor.Connected then Exit;
  if not MsgFactory.Loaded or (MsgFactory.Loaded and (Timer1.Tag>0) and
     (MsgFactory.UnRead=0) and ((Timer1.Tag mod 120)=0)
     )
  then
     MsgFactory.Load;
  if Timer1.Tag >= 120 then Timer1.Tag := 0 else Timer1.Tag := Timer1.Tag + 1;
  if MsgFactory.Count > 0 then
     begin
       lblUserInfo.Caption := ShopGlobal.UserName + ' 您有('+inttostr(MsgFactory.UnRead)+')条消息';
       rzUserInfo.Caption := lblUserInfo.Caption;
       case Timer1.Tag mod 2 of
       0:begin
           lblUserInfo.Font.Color := clRed;
           lblUserInfo.Font.Style := [fsBold];
           rzUserInfo.Font.Color := clRed;
           rzUserInfo.Font.Style := [fsBold];
         end;
       1:begin
           lblUserInfo.Font.Color := clWhite;
           lblUserInfo.Font.Style := [];
           rzUserInfo.Font.Color := clWhite;
           rzUserInfo.Font.Style := [];
         end;
       end;
     end
  else
     begin
       lblUserInfo.Caption := ShopGlobal.UserName + ' 您没有消息';
       rzUserInfo.Caption := lblUserInfo.Caption;
     end;
  if (MsgFactory.Loaded and ((Timer1.Tag mod 120)=0)) then
     begin
       P := MsgFactory.ReadMsg;
       if P<>nil then MsgFactory.HintMsg(P);
     end;
end;

procedure TfrmShopMain.LoadFrame;
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    Caption :=  F.ReadString('soft','name','云盟软件R3')+' 版本:'+RzVersionInfo.FileVersion;
    if ShopGlobal.offline then
       Caption := Caption +'【脱机使用】门店：'+ Global.SHOP_NAME
    else
       Caption := Caption +'【联机使用】门店：'+ Global.SHOP_NAME;
    Application.Title :=  F.ReadString('soft','name','云盟软件R3');
    SFVersion := F.ReadString('soft','SFVersion','.NET');
    CLVersion := F.ReadString('soft','CLVersion','.MKT');
    ProductID := F.ReadString('soft','ProductID','R3_RYC');
    RzLabel1.Caption := F.ReadString('soft','copyright','')+' | 使用单位:'+Global.TENANT_NAME;
  finally
    F.Free;
  end;
  if FileExists(ExtractFilePath(ParamStr(0))+'logo_lt.jpg') then
    Image5.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'logo_lt.jpg');
end;

procedure TfrmShopMain.SetLoging(const Value: boolean);
begin
  FLoging := Value;
end;

procedure TfrmShopMain.SetSystemShutdown(const Value: boolean);
begin
  FSystemShutdown := Value;
end;

procedure TfrmShopMain.InitVersioin;
begin

end;

procedure TfrmShopMain.N90Click(Sender: TObject);
var
  HWndCalculator : HWnd;
begin
  // 查找已存在的计算器窗口
  HWndCalculator :=FindWindow(nil, '计算器');
  if HWndCalculator <> 0 then SendMessage(HWndCalculator, WM_CLOSE, 0, 0);// close the exist Calculator
  ShellExecute(Handle,'open','calc.exe',nil,nil,SW_SHOW);

end;

procedure TfrmShopMain.UpdateTimerTimer(Sender: TObject);
begin
  inherited;
  Label2.Caption := '当前时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
end;

procedure TfrmShopMain.RzBmpButton10Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmShopMain.LoadMenu;
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
function CheckRight:boolean;
var
  rs:TZQuery;
begin
  result := false;
  rs := CA_MODULE;
  rs.Filtered := false;
  rs.Filtered := true;
  rs.First;
  while not rs.Eof do
    begin
      if rs.FieldbyName('LEVEL').AsInteger =3 then
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
procedure CreatePageMenu;
var i:integer;
begin
  Page1.Visible := false;
  Page2.Visible := false;
  Page3.Visible := false;
  Page4.Visible := false;
  Page5.Visible := false;
  s2_Page1.Visible := false;
  s2_Page2.Visible := false;
  s2_Page3.Visible := false;
  s2_Page4.Visible := false;
  s2_Page5.Visible := false;
  PageList.Clear;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if CA_MODULE.FieldbyName('LEVEL').AsInteger =1 then
      begin
        case strtoint(copy(CA_MODULE.Fields[0].asString,1,1)) of
        1:begin
            if sflag='s1_' then
               PageList.Add(Page1)
            else
               PageList.Add(s2_Page1);
          end;
        2:begin
            if sflag='s1_' then
               PageList.Add(Page2)
            else
               PageList.Add(s2_Page2);
          end;
        3:begin
            if sflag='s1_' then
               PageList.Add(Page3)
            else
               PageList.Add(s2_Page3);
          end;
        4:begin
            if sflag='s1_' then
               PageList.Add(Page4)
            else
               PageList.Add(s2_Page4);
          end;
        9:begin
            if sflag='s1_' then
               PageList.Add(Page5)
            else
               PageList.Add(s2_Page5);
          end;
        end;
      end;
      CA_MODULE.Next;
    end;
  for i:=0 to PageList.Count -1 do
     begin
       TrzBmpButton(PageList[i]).OnClick := nil;
       try
         TrzBmpButton(PageList[i]).Down := true;
         TrzBmpButton(PageList[i]).Visible := CheckRight;
       finally
         if sflag='s1_' then
            TrzBmpButton(PageList[i]).OnClick := Page1Click
         else
            TrzBmpButton(PageList[i]).OnClick := s2_Page1Click;
       end;
     end;
  if PageList.Count >0 then TrzBmpButton(PageList[0]).down := true;
  SortPageButton;
end;
var
  rs:TZQuery;
  g:TrzGroup;
  b:TrzGroupItem;
  i,r:integer;
begin
  if not CA_MODULE.Active then
     begin
       CA_MODULE.Filtered := false;
       CA_MODULE.Close;
       CA_MODULE.SQL.Text := ParseSQL(Factor.iDbType,'select MODU_ID,MODU_NAME,ACTION_NAME,len(LEVEL_ID)/3 as LEVEL from CA_MODULE where PROD_ID='''+ProductID+''' and MODU_TYPE in (1,3) and COMM not in (''02'',''12'') order by LEVEL_ID');
       Factor.Open(CA_MODULE);
       CreatePageMenu;
     end;
  for i:=RzGroupBar1.GroupCount -1 downto 0 do
    begin
      RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
    end;
  rs := CA_MODULE;
  rs.Filtered := false;
  rs.Filtered := true;
  rs.First;
  while not rs.Eof do
    begin
      if rs.FieldbyName('LEVEL').AsInteger =2 then
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
      if rs.FieldbyName('LEVEL').AsInteger =3 then
         begin
           if FindAction(rs.FieldbyName('ACTION_NAME').AsString)<>nil then
           begin
             b := g.Items.Add;
             b.Caption := rs.FieldbyName('MODU_NAME').AsString;
             b.Action := FindAction(rs.FieldbyName('ACTION_NAME').AsString);
             TAction(b.Action).Caption := rs.FieldbyName('MODU_NAME').AsString;
             b.ImageIndex := 1;
           end;
         end;
      rs.Next;
    end;
  for i:=RzGroupBar1.GroupCount -1 downto 0 do
    begin
      if RzGroupBar1.Groups[i].Items.Count =0 then
         RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
    end;
end;

procedure TfrmShopMain.RzBmpButton8Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmShopMain.RzTabChange(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 33 then rzLeft.Width := 172;
  if Logined then LoadMenu;
end;

procedure TfrmShopMain.Image19Click(Sender: TObject);
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

procedure TfrmShopMain.RzBmpButton9Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if FList.Count > 0 then
     begin
       if MessageBox(Handle,'是否关闭当前打开的所有模块？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       for i:= FList.Count -1 downto 0 do
         TForm(TrzBmpButton(FList[i]).tag).free;
     end;
  if FList.Count=0 then
     begin
       Logined := Login(false,false);
     end;
end;

procedure TfrmShopMain.toolButtonClick(Sender: TObject);
begin
  inherited;
  frmDesk.ForeBringtoFront;
  rzLeft.Width := 147;
  frmDesk.OnResize(nil);
end;

procedure TfrmShopMain.DoConnectError(Sender: TObject);
begin

end;

function TfrmShopMain.GetDeskFlag: string;
begin

end;

function TfrmShopMain.ConnectToDb:boolean;
procedure InitTenant;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.ExecProc('TTenantInit',Params);   
  finally
    Params.Free;
  end;
end;
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
                    if CheckVersion(DBVersion,Global.RemoteFactory) then
                    begin
                      if ShopGlobal.ONLVersion then
                         begin
                           MessageBox(Handle,'服务器的版本过旧，请联系管理员升级后台服务器..','友情提示...',MB_OK+MB_ICONINFORMATION);
                           result := false;
                           Exit;
                         end;
                      result := (MessageBox(Handle,'服务器的版本过旧，请联系管理员升级后台服务器，是否转脱机使用？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6);
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
                    if MessageBox(Handle,'连接数据库服务器失败,请检查网络是否正常,是否重新选择连接主机？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
                       TfrmHostDialog.HostDialog(self);
                    result := false;
                    Exit;
                  end;
               result := (MessageBox(Handle,'连接远程数据库失败,是否转脱机操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);
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
                   MessageBox(Handle,'连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
                 end;
               finally
                 Global.MoveToLocal;
               end;
             end;
          if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
             begin
               CaFactory.SyncAll(1);
               SyncFactory.SyncBasic(true);
               InitTenant;
             end;
        end
     else
        begin
          if CaFactory.Audited and Global.RemoteFactory.Connected then //管理什么版本，有连接到服务器时，必须先同步数据
             begin
               if ShopGlobal.ONLVersion then //在线版只需同步注册数据
                  begin
                    SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('CA_SHOP_INFO','TENANT_ID;SHOP_ID','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('ACC_ACCOUNT_INFO','TENANT_ID;ACCOUNT_ID','TSyncAccountInfo',0);
                  end
               else
                  SyncFactory.SyncBasic(true);
             end;
          InitTenant;
        end;
    finally
      frmLogo.Close;
    end;
  except
    on E:Exception do
      begin
        MessageBox(Handle,pchar(E.Message),'友情提示...',MB_OK+MB_ICONERROR);
        result := false;
      end;
  end;
end;

procedure TfrmShopMain.actfrmMeaUnitsExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  with TfrmMeaUnits.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;

end;

procedure TfrmShopMain.actfrmDutyInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmDutyInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDutyInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmRoleInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRoleInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmRoleInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmDeptInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmDeptInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDeptInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmUsersExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmUsers);
  if not Assigned(Form) then
     begin
       Form := TfrmUsers.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmBrandInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,4);
end;

procedure TfrmShopMain.actfrmStockOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmSalesOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmChangeOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmChangeOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmGoodsInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmGoodsInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmGoodsInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmGoodsSortExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  if TfrmGoodsSortTree.ShowDialog(self,1) then
  begin
    Form:=FindChildForm(TfrmGoodsInfoList);
    if Form<>nil then
      TfrmGoodsInfoList(Form).LoadTree;
  end;
end;

procedure TfrmShopMain.actfrmCodeInfo3Execute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,3);
end;

procedure TfrmShopMain.actfrmSortInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,2);
end;

procedure TfrmShopMain.actfrmImplInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,5);
end;

procedure TfrmShopMain.actfrmAreaInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmGoodsSort.ShowDialog(self,6);
end;

procedure TfrmShopMain.actfrmSaleStyleExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,2);
end;

procedure TfrmShopMain.actfrmSettleCodeExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,6);
end;

procedure TfrmShopMain.actfrmShopGroupExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCodeInfo.ShowDialog(self,12);
end;

procedure TfrmShopMain.actfrmRecvOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRecvOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmRecvOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmPayOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmPayOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPayOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmClientExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmClient);
  if not Assigned(Form) then
     begin
       Form := TfrmClient.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmSupplierExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmSupplier);
  if not Assigned(Form) then
     begin
       Form := TfrmSupplier.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmSalRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmSalRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmStkRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
//  if ShopGlobal.offline then Raise Exception.Create('暂不支持离线使用,开发中,请多关注...');
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmStkRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmPosMainExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmPriceGradeInfoExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmPriceGradeInfo.ShowDialog(self);

end;

procedure TfrmShopMain.actfrmSalIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmSalIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmStkIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmStkIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmInvoiceExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmInvoice);
  if not Assigned(Form) then
     begin
       Form := TfrmInvoice.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmCustomerExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmCustomer);
  if not Assigned(Form) then
     begin
       Form := TfrmCustomer.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmCostCalcExecute(Sender: TObject);
begin
  inherited;
{  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCostCalc.StartCalc(self); }
end;

procedure TfrmShopMain.actfrmSysDefineExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  with TfrmSysDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopMain.actfrmDaysCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCostCalc.StartDayReck(self);
end;

procedure TfrmShopMain.actfrmMonthCloseExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCostCalc.StartMonthReck(self);

end;

procedure TfrmShopMain.actfrmCloseForDayExecute(Sender: TObject);
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmCloseForDay.ShowClDy(self);
end;

procedure TfrmShopMain.actfrmPriceOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmPriceOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPriceOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;

end;

procedure TfrmShopMain.actfrmCheckOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmDbOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmDbOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmDbOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmShopInfoListExecute(Sender: TObject);
var
  Form:TfrmBasic;
  AObj:TRecord_;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmXsmBrowserExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmIEWebForm);
  if not Assigned(Form) then
     begin
       Form := TfrmIEWebForm.Create(self);
       AddFrom(Form);
     end;
  try
    if copy(ParamStr(3),1,8)='-xsmurl=' then
       TfrmIEWebForm(Form).Open(copy(ParamStr(3),9,255))
    else
       begin
         if MessageBox(Handle,'你没有新商盟账号无法完成登录,是否进入新商盟演示账套?','友情提示..',MB_YESNO+MB_ICONINFORMATION)<>6 then
            begin
              Form.Free;
              Exit;
            end;
         TfrmIEWebForm(Form).Open(TfrmIEWebForm(Form).GetDoLogin(xsm_url));
       end;
    Form.Show;
    Form.BringToFront;
  except
    Form.Free;
    Raise;
  end;
end;

procedure TfrmShopMain.actfrmAccountExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmAccount);
  if not Assigned(Form) then
     begin
       Form := TfrmAccount.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmTransOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmTransOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmTransOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmDevFactoryExecute(Sender: TObject);
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

procedure TfrmShopMain.CA_MODULEFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
function GetFlag:integer;
begin
  if sflag = 's1_' then
  begin
  result := 0;
  if Page1.Down then
     result := 1
  else
  if Page2.Down then
     result := 2
  else
  if Page3.Down then
     result := 3
  else
  if Page4.Down then
     result := 4
  else
  if Page5.Down then
     result := 9;
  end;
  if sflag = 's2_' then
  begin
  result := 0;
  if s2_Page1.Down then
     result := 1
  else
  if s2_Page2.Down then
     result := 2
  else
  if s2_Page3.Down then
     result := 3
  else
  if s2_Page4.Down then
     result := 4
  else
  if s2_Page5.Down then
     result := 9;
  end;
end;
begin
  inherited;
  Accept := copy(CA_MODULE.Fields[0].AsString,1,1)=inttostr(GetFlag);
end;

procedure TfrmShopMain.actfrmIoroOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmIoroOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmCheckTablePrintExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmRckMngExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRckMng);
  if not Assigned(Form) then
  begin
    Form := TfrmRckMng.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmJxcTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmJxcTotalReport);
  if not Assigned(Form) then
  begin
    Form := TfrmJxcTotalReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmStockDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmStockDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStockDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmSaleDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmChange1DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmChange2DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  Application.Restore;
  frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmLockScreenExecute(Sender: TObject);
begin
  inherited;
  frmShopDesk.HookLocked := true;
  try
    Login(true);
  finally
    frmShopDesk.HookLocked := false;
  end;

end;

procedure TfrmShopMain.actfrmStorageDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmStorageDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmRckDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRckDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRckDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmRelationExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRelation);
  if not Assigned(Form) then
  begin
    Form := TfrmRelation.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 29 then rzLeft.Width := 172;
  if Panel12.Width = 31 then Panel12.Width := 174;
  if Panel24.Width = 23 then Panel24.Width := 166;
  frmMain.OnResize(nil);
  frmShopDesk.Locked := true;
  frmShopDesk.BringToFront;
end;

procedure TfrmShopMain.Page1Click(Sender: TObject);
begin
  inherited;
  LoadMenu;
end;

procedure TfrmShopMain.actfrmRecvDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRecvDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmPayDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmPayDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmRecvAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRecvAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmPayAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmPayAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmStorageTrackingExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmStorageTracking);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageTracking.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmDbDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmDbDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmDbDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmGodsRunningReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmGodsRunningReport);
  if not Assigned(Form) then
  begin
    Form := TfrmGodsRunningReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
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
  SyncFactory.SyncAll;
  Global.LoadBasic;
  ShopGlobal.LoadRight;
end;

procedure TfrmShopMain.RzBmpButton13Click(Sender: TObject); 
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',5) then Raise Exception.Create('你没有到货确认权限,请和管理员联系.');
  actfrmDownIndeOrder.Execute;
end;

procedure TfrmShopMain.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',5) then Raise Exception.Create('你没有到货确认权限,请和管理员联系.');
  actfrmDownIndeOrder.Execute;
end;

procedure TfrmShopMain.tlbCloseClick(Sender: TObject);
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

procedure TfrmShopMain.N103Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;

procedure TfrmShopMain.actfrmIoroDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmIoroDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmIoroDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmMessageExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmMessage);
  if not Assigned(Form) then
  begin
    Form := TfrmMessage.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmNewPaperReaderExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmNewPaperReader.ShowNewsPaper('');
end;

procedure TfrmShopMain.WriteAction(s: string;flag:integer);
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

procedure TfrmShopMain.actfrmQuestionnaireExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  TfrmQuestionnaire.ShowForm(self);
end;

procedure TfrmShopMain.LoadPic32;
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
  sflag := 's'+GetResString(1)+'_';
  if DllHandle > 0 then 
  try
    rzUserInfo.Visible := (sflag='s2_');
    //logo
    if sflag='s1_' then
    begin
    rzLogo.ActivePageIndex := 0;
    rzLogo.Height := 105;
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

    Image18.Picture.Graphic  := GetJpeg(sflag+'page_bg');
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
    RzBmpButton1.Bitmaps.Up := GetBitmap(sflag+'xsm');
    RzBmpButton1.Bitmaps.Hot := GetBitmap(sflag+'xsm_hot');
    RzBmpButton2.Bitmaps.Up := GetBitmap(sflag+'down');
    RzBmpButton2.Bitmaps.Hot := GetBitmap(sflag+'down_hot');
    RzBmpButton4.Bitmaps.Up := GetBitmap(sflag+'upload');
    RzBmpButton4.Bitmaps.Hot := GetBitmap(sflag+'upload_hot');
    RzBmpButton5.Bitmaps.Up := GetBitmap(sflag+'help');
    RzBmpButton5.Bitmaps.Hot := GetBitmap(sflag+'help_hot');

    Page1.Bitmaps.Up := GetBitmap(sflag+'page1');
    Page1.Bitmaps.Down := GetBitmap(sflag+'page1_hot');
    Page2.Bitmaps.Up := GetBitmap(sflag+'page2');
    Page2.Bitmaps.Down := GetBitmap(sflag+'page2_hot');
    Page3.Bitmaps.Up := GetBitmap(sflag+'page3');
    Page3.Bitmaps.Down := GetBitmap(sflag+'page3_hot');
    Page4.Bitmaps.Up := GetBitmap(sflag+'page4');
    Page4.Bitmaps.Down := GetBitmap(sflag+'page4_hot');
    Page5.Bitmaps.Up := GetBitmap(sflag+'page9');
    Page5.Bitmaps.Down := GetBitmap(sflag+'page9_hot');
    end
    else
    begin
    rzLogo.ActivePageIndex := 1;
    rzLogo.Height := 105;
    Image29.Picture.Graphic  := GetJpeg(sflag+'logo_lt');
    Image30.Picture.Graphic  := GetJpeg(sflag+'logo_bg');
    Image32.Picture.Graphic  := GetJpeg(sflag+'logo_r1');
    Image33.Picture.Graphic  := GetJpeg(sflag+'logo_r2');
    Image35.Picture.Graphic  := GetJpeg(sflag+'logo_r3');
    Image34.Picture.Graphic  := GetJpeg(sflag+'logo_r4');

    Image37.Picture.Graphic  := GetJpeg(sflag+'menu_title');

    Image41.Picture.Graphic  := GetJpeg(sflag+'tool_01');
    Image40.Picture.Graphic  := GetJpeg(sflag+'tool_02');
    Image42.Picture.Graphic  := GetJpeg(sflag+'tool_03');
    Image43.Picture.Graphic  := GetJpeg(sflag+'tool_04');
    Image36.Picture.Graphic  := GetJpeg(sflag+'tool_05');

    Image45.Picture.Graphic  := GetJpeg(sflag+'page_bg');
    Image19.Picture.Graphic  := GetJpeg(sflag+'split');

    Image22.Picture.Graphic  := GetJpeg(sflag+'foot_1');
    Image15.Picture.Graphic  := GetJpeg(sflag+'foot_2');
    Image23.Picture.Graphic  := GetJpeg(sflag+'foot_3');
    Image24.Picture.Graphic  := GetJpeg(sflag+'foot_4');
    Image25.Picture.Graphic  := GetJpeg(sflag+'foot_bg');


    toolButton.Bitmaps.Up := GetBitmap(sflag+'toolbutton');
    toolButton.Bitmaps.Down := GetBitmap(sflag+'toolbutton_hot');
    sDeskPage.Bitmaps.Up := GetBitmap(sflag+'desktop');
    sDeskPage.Bitmaps.Hot := GetBitmap(sflag+'desktop_hot');

    RzBmpButton11.Bitmaps.Up := GetBitmap(sflag+'password');
    RzBmpButton11.Bitmaps.Hot := GetBitmap(sflag+'password_hot');
//    RzBmpButton9.Bitmaps.Up := GetBitmap(sflag+'logout');
//    RzBmpButton9.Bitmaps.Hot := GetBitmap(sflag+'logout_hot');
    RzBmpButton12.Bitmaps.Up := GetBitmap(sflag+'exit');
    RzBmpButton12.Bitmaps.Hot := GetBitmap(sflag+'exit_hot');

//    RzBmpButton6.Bitmaps.Up := GetBitmap(sflag+'home');
//    RzBmpButton6.Bitmaps.Hot := GetBitmap(sflag+'home_hot');
//    RzBmpButton1.Bitmaps.Up := GetBitmap(sflag+'xsm');
//    RzBmpButton1.Bitmaps.Hot := GetBitmap(sflag+'xsm_hot');
    RzBmpButton13.Bitmaps.Up := GetBitmap(sflag+'down');
    RzBmpButton13.Bitmaps.Hot := GetBitmap(sflag+'down_hot');
    RzBmpButton7.Bitmaps.Up := GetBitmap(sflag+'upload');
    RzBmpButton7.Bitmaps.Hot := GetBitmap(sflag+'upload_hot');
//    RzBmpButton5.Bitmaps.Up := GetBitmap(sflag+'help');
//    RzBmpButton5.Bitmaps.Hot := GetBitmap(sflag+'help_hot');
    RzBmpButton14.Bitmaps.Up := GetBitmap(sflag+'question');
    RzBmpButton14.Bitmaps.Hot := GetBitmap(sflag+'question_hot');
    RzBmpButton15.Bitmaps.Up := GetBitmap(sflag+'message');
    RzBmpButton15.Bitmaps.Hot := GetBitmap(sflag+'message_hot');

    s2_Page1.Bitmaps.Up := GetBitmap(sflag+'page1');
    s2_Page1.Bitmaps.Down := GetBitmap(sflag+'page1_hot');
    s2_Page2.Bitmaps.Up := GetBitmap(sflag+'page2');
    s2_Page2.Bitmaps.Down := GetBitmap(sflag+'page2_hot');
    s2_Page3.Bitmaps.Up := GetBitmap(sflag+'page3');
    s2_Page3.Bitmaps.Down := GetBitmap(sflag+'page3_hot');
    s2_Page4.Bitmaps.Up := GetBitmap(sflag+'page4');
    s2_Page4.Bitmaps.Down := GetBitmap(sflag+'page4_hot');
    s2_Page5.Bitmaps.Up := GetBitmap(sflag+'page9');
    s2_Page5.Bitmaps.Down := GetBitmap(sflag+'page9_hot');
    end;
  finally
    if DllHandle > 0 then FreeLibrary(DllHandle);
  end;
end;

procedure TfrmShopMain.RzBmpButton11Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmShopMain.RzBmpButton12Click(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmShopMain.RzBmpButton7Click(Sender: TObject);
begin
  inherited;
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
  SyncFactory.SyncAll;
  Global.LoadBasic;
end;

procedure TfrmShopMain.RzBmpButton14Click(Sender: TObject);
begin
  inherited;
  actfrmQuestionnaire.OnExecute(actfrmQuestionnaire);
end;

procedure TfrmShopMain.RzBmpButton15Click(Sender: TObject);
begin
  inherited;
  actfrmMessage.OnExecute(actfrmMessage);
end;

procedure TfrmShopMain.s2_Page1Click(Sender: TObject);
begin
  inherited;
  LoadMenu;

end;

procedure TfrmShopMain.sDeskPageClick(Sender: TObject);
begin
  inherited;
  RzBmpButton3Click(nil);
end;

procedure TfrmShopMain.RzBmpButton6Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'谢谢你的关注，网站正在更新中...','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmShopMain.actfrmInLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmInLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmInLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.actfrmOutLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmOutLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmOutLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.SortPageButton;
var
  i,n:integer;
begin
  n := 0;
  if sflag='s2_' then PageList.Insert(0,sDeskPage); 
  for i:=PageList.Count -1 downto 0 do
    begin
      if not TRzBmpButton(PageList[i]).Visible then
         PageList.Delete(i); 
    end;
  for i:=0 to PageList.Count -1 do
    begin
      if sflag='s1_' then
         begin
           if i=0 then
              TRzBmpButton(PageList[i]).Top := 1
           else
              TRzBmpButton(PageList[i]).Top := TRzBmpButton(PageList[i-1]).top + TRzBmpButton(PageList[i-1]).height + 1;
         end
      else
         TRzBmpButton(PageList[i]).Left := Panel30.Width -((PageList.Count-n)*TRzBmpButton(PageList[i]).Width + 1)-10;
      inc(n);
    end;
end;

procedure TfrmShopMain.lblUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmShopMain.actfrmDownIndeOrderExecute(Sender: TObject);
var
  vData: OleVariant;
  Aobj: TRecord_;
  Form: TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;

  try
    Aobj:=TRecord_.Create;
    if TfrmDownStockOrder.DownStockOrder(AObj,vData) then
    begin
      if trim(AObj.fieldbyName('INDE_ID').AsString)<>'' then
      begin
        Application.Restore;
        frmShopDesk.SaveToFront;
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

procedure TfrmShopMain.actfrmRecvForDayExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  if not Logined then
  begin
    PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
    Exit;
  end;
  Application.Restore;
  frmShopDesk.SaveToFront;
  Form := FindChildForm(TfrmRecvPosList);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvPosList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmShopMain.rzUserInfoClick(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(nil);
end;

procedure TfrmShopMain.actfrmImpeachExecute(Sender: TObject);
begin
  inherited;
  TfrmImpeach.ShowImpeach(self); 
end;

end.

