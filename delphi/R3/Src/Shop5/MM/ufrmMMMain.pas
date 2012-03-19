unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, uMMUtil, uMMServer ,ShellApi,
  ZBase, RzTray, StdCtrls, Mask, RzEdit, RzBmpBtn, RzLabel, jpeg, RzPanel,
  ImgList, RzBckgnd, RzForms, ToolWin, Buttons, RzButton, ufrmBasic, ZdbFactory,
  ZDataSet, DB, ZAbstractRODataset, ZAbstractDataset, ufrmMMBrowser,ummFactory,
  ufrmHintMsg, RzStatus, ufrmInstall;

const
  MSC_POPUP=WM_USER+1;                                                                           
type
  TfrmMMMain = class(TfrmMain)
    RzTrayIcon1: TRzTrayIcon;
    RzPanel2: TRzPanel;
    split: TImage;
    Panel11: TPanel;
    ImageList1: TImageList;
    bkg_bb: TRzPanel;
    RzPanel10: TRzPanel;
    bkg_03: TImage;
    RzPanel11: TRzPanel;
    bkg_04: TImage;
    bkg_bottom: TRzPanel;
    RzSeparator3: TRzSeparator;
    bkg_f2: TRzBackground;
    bgk_tt: TRzPanel;
    bkg_01: TImage;
    bkg_top: TRzPanel;
    RzSeparator2: TRzSeparator;
    bkg_f1: TRzBackground;
    logo: TImage;
    A1: TMenuItem;
    C1: TMenuItem;
    C2: TMenuItem;
    ADSFADSF1: TMenuItem;
    DAFADSFDSA1: TMenuItem;
    ADSFDSAFDSA1: TMenuItem;
    ASDFASDFADS1: TMenuItem;
    ADSFADSFDS1: TMenuItem;
    bkgMenu: TRzPanel;
    toolMenu: TPopupMenu;
    toolDesk: TRzBmpButton;
    toolClose: TRzBmpButton;


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
    actfrmCustomer: TAction;
    actfrmSysDefine: TAction;
    actfrmDaysClose: TAction;
    actfrmMonthClose: TAction;
    actfrmCloseForDay: TAction;
    actfrmPriceOrderList: TAction;
    actfrmCheckOrderList: TAction;
    actfrmTransOrderList: TAction;
    actfrmDbOrderList: TAction;
    actfrmShopInfoList: TAction;
    actfrmAccount: TAction;
    actfrmIoroOrderList1: TAction;
    actfrmIoroOrderList2: TAction;
    actfrmDevFactory: TAction;
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
    actfrmPayDayReport: TAction;
    actfrmPayAbleReport: TAction;
    actfrmRecvAbleReport: TAction;
    actfrmDbDayReport: TAction;
    actfrmGodsRunningReport: TAction;
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
    actfrmSaleMonthTotalReport: TAction;
    actfrmXsmNet: TAction;
    actfrmRimNet: TAction;
    actfrmDefineStateInfo: TAction;
    actfrmSyncAll: TAction;
    actfrmGoodsMonth: TAction;
    actfrmInitGuide: TAction;
    toolButton: TRzBmpButton;
    RzPanel7: TRzPanel;
    RzPanel3: TRzPanel;
    RzBmpButton2: TRzBmpButton;
    softname: TRzLabel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    MenuSpilt: TRzBmpButton;
    sysHelp: TRzBmpButton;
    sysMinimized: TRzBmpButton;
    sysMaximized: TRzBmpButton;
    sysClose: TRzBmpButton;
    bkg_02: TImage;
    N4: TMenuItem;
    N5: TMenuItem;
    copyRight: TRzLabel;
    r3offline: TRzLabel;
    UsersStatus: TRzBmpButton;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    rzLeftTool: TRzPanel;
    rzPage1: TRzBmpButton;
    rzPage6: TRzBmpButton;
    rzPage2: TRzBmpButton;
    rzPage3: TRzBmpButton;
    rzPage4: TRzBmpButton;
    rzPage7: TRzBmpButton;
    rzPage8: TRzBmpButton;
    menuButton: TRzBmpButton;
    pageLine: TRzSeparator;
    rzPage5: TRzBmpButton;
    actfrmSimpleSaleDayReport: TAction;
    RzFormShape1: TRzFormShape;
    rzVersion: TRzLabel;
    CA_MODULE: TZQuery;
    RzVersionInfo: TRzVersionInfo;
    Image5: TImage;
    lbM1: TLabel;
    actfrmNothing: TAction;
    actfrmDemandOrderList1: TAction;
    actfrmDemandOrderList2: TAction;
    actfrmWelcome: TAction;
    actfrmSaleDaySingleReport: TAction;
    actfrmDeskPage: TAction;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miCloseClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure sysCloseClick(Sender: TObject);
    procedure sysMaximizedClick(Sender: TObject);
    procedure sysMinimizedClick(Sender: TObject);
    procedure RzTrayIcon1LButtonDown(Sender: TObject);
    procedure RzTrayIcon1LButtonDblClick(Sender: TObject);
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
    procedure actfrmCustomerExecute(Sender: TObject);
    procedure actfrmSysDefineExecute(Sender: TObject);
    procedure actfrmDaysCloseExecute(Sender: TObject);
    procedure actfrmMonthCloseExecute(Sender: TObject);
    procedure actfrmCloseForDayExecute(Sender: TObject);
    procedure actfrmPriceOrderListExecute(Sender: TObject);
    procedure actfrmCheckOrderListExecute(Sender: TObject);
    procedure actfrmDbOrderListExecute(Sender: TObject);
    procedure actfrmTransOrderListExecute(Sender: TObject);
    procedure actfrmShopInfoListExecute(Sender: TObject);
    procedure actfrmAccountExecute(Sender: TObject);
    procedure actfrmIoroOrderList1Execute(Sender: TObject);
    procedure actfrmIoroOrderList2Execute(Sender: TObject);
    procedure actfrmDevFactoryExecute(Sender: TObject);
    procedure actfrmStorageTrackingExecute(Sender: TObject);
    procedure actfrmRckMngExecute(Sender: TObject);
    procedure actfrmCheckTablePrintExecute(Sender: TObject);
    procedure actfrmJxcTotalReportExecute(Sender: TObject);
    procedure actfrmStockDayReportExecute(Sender: TObject);
    procedure actfrmSaleDayReportExecute(Sender: TObject);
    procedure actfrmChange1DayReportExecute(Sender: TObject);
    procedure actfrmChange2DayReportExecute(Sender: TObject);
    procedure actfrmLockScreenExecute(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure sysHelpClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure actfrmStorageDayReportExecute(Sender: TObject);
    procedure actfrmRecvDayReportExecute(Sender: TObject);
    procedure actfrmRckDayReportExecute(Sender: TObject);
    procedure actfrmRelationExecute(Sender: TObject);
    procedure actfrmPayDayReportExecute(Sender: TObject);
    procedure actfrmPayAbleReportExecute(Sender: TObject);
    procedure actfrmRecvAbleReportExecute(Sender: TObject);
    procedure actfrmDbDayReportExecute(Sender: TObject);
    procedure actfrmGodsRunningReportExecute(Sender: TObject);
    procedure actfrmIoroDayReportExecute(Sender: TObject);
    procedure actfrmMessageExecute(Sender: TObject);
    procedure actfrmNewPaperReaderExecute(Sender: TObject);
    procedure actfrmQuestionnaireExecute(Sender: TObject);
    procedure actfrmInLocusOrderListExecute(Sender: TObject);
    procedure actfrmOutLocusOrderListExecute(Sender: TObject);
    procedure actfrmDownIndeOrderExecute(Sender: TObject);
    procedure actfrmRecvForDayExecute(Sender: TObject);
    procedure actfrmImpeachExecute(Sender: TObject);
    procedure actfrmClearDataExecute(Sender: TObject);
    procedure actfrmSaleAnalyExecute(Sender: TObject);
    procedure actfrmNetForOrderExecute(Sender: TObject);
    procedure actfrmSaleManSaleReportExecute(Sender: TObject);
    procedure actfrmClientSaleReportExecute(Sender: TObject);
    procedure actfrmSaleTotalReportExecute(Sender: TObject);
    procedure actfrmStgTotalReportExecute(Sender: TObject);
    procedure actfrmStockTotalReportExecute(Sender: TObject);
    procedure actfrmSaleMonthTotalReportExecute(Sender: TObject);
    procedure actfrmSyncAllExecute(Sender: TObject);
    procedure actfrmGoodsMonthExecute(Sender: TObject);
    procedure actfrmInitGuideExecute(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure toolCloseClick(Sender: TObject);
    procedure toolDeskClick(Sender: TObject);
    procedure rzPage2Click(Sender: TObject);
    procedure rzPage3Click(Sender: TObject);
    procedure rzPage4Click(Sender: TObject);
    procedure actfrmXsmNetExecute(Sender: TObject);
    procedure actfrmRimNetExecute(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure MenuSpiltClick(Sender: TObject);
    procedure UsersStatusClick(Sender: TObject);
    procedure RzFormShape1DblClick(Sender: TObject);
    procedure rzPage8Click(Sender: TObject);
    procedure rzPage0Click(Sender: TObject);
    procedure rzPage1Click(Sender: TObject);
    procedure rzPage6Click(Sender: TObject);
    procedure rzPage7Click(Sender: TObject);
    procedure rzPage5Click(Sender: TObject);
    procedure actfrmSimpleSaleDayReportExecute(Sender: TObject);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure lbM1Click(Sender: TObject);
    procedure actfrmNothingExecute(Sender: TObject);
    procedure actfrmWelcomeExecute(Sender: TObject);
    procedure actfrmSaleDaySingleReportExecute(Sender: TObject);
    procedure actfrmDeskPageExecute(Sender: TObject);
  private
    { Private declarations }
    FList:TList; {导航菜单}
    FMenu:TList; {主菜单}
    rc:int64;
    
    frmXsmIEBrowser:TfrmMMBrowser;
    frmRimIEBrowser:TfrmMMBrowser;
    FLogined: boolean;
    FWindowState: TWindowState;
    procedure wm_Login(var Message: TMessage); message MM_LOGIN;
    procedure wm_Sign(var Message: TMessage); message MM_SIGN;
    procedure wm_SessionFail(var Message: TMessage); message MM_SESSION_FAIL;
    procedure wm_Params(var Message: TMessage); message MM_PARAMS;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure wm_lcControl(var Message: TMessage); message WM_LCCONTROL;
    procedure wm_mmcError(var Message: TMessage); message WM_MMC_ERROR;
    procedure wm_message(var Message: TMessage); message MSC_MESSAGE;
    procedure WMNCHITTEST(var Msg: TWMNCHITTEST);  message WM_NCHITTEST;

    function  CheckVersion:boolean;
    //导航工具栏
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure AddFrom(form:TForm);
    function  SortToolButton:boolean;

    procedure SortLeftButton;

    //菜单管理
    procedure CreateMenu;
    procedure DoOpenMenu(Sender:TObject);
    procedure wm_popup(var Message: TMessage); message MSC_POPUP;
    procedure DropMenu(mid:integer;btn:TrzBmpButton);
    procedure PupupToolBox(Sender:TObject;s:string);
    procedure SetLogined(const Value: boolean);
    procedure SetWindowState(const Value: TWindowState);
    procedure InitTenant;
    procedure DoLoadMsg(Sender:TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure LoadPic32;
    function ConnectToSQLite:boolean;
    function CreateMMLogin: TftParamList;
    procedure LoadParams;
    procedure CheckEnabled;
    procedure Init;
    function  Login: boolean;
    procedure OpenMc(pid: string; mid:integer=0);
    procedure ShowMMList;
    procedure ShowMsgDialog;
    procedure HideMMList;
    procedure Show;
    //软是否登录
    property Logined:boolean read FLogined write SetLogined;
    property WindowState:TWindowState read FWindowState write SetWindowState;
  end;

var
  frmMMMain: TfrmMMMain;

implementation
uses
  ufrmMMLogin, ufrmMMList,uMsgBox, uRcFactory, uN26Factory,uTimerFactory,
  uDsUtil,uFnUtil,ufrmLogo,ufrmTenant, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogin,
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
  ufrmOptionDefine,ufrmInitialRights,uAdvFactory,ufrmXsmLogin,ufrmNetLogin,ufrmInitGuide,ufrmWelcome,
  uLoginFactory,ufrmGoodsMonth,uSyncThread,uCommand, ummGlobal, ufrmMMDesk, ufrmMMToolBox;
var
  frmMMToolBox:TfrmMMToolBox;
{$R *.dfm}

function TfrmMMMain.Login: boolean;
begin
  result := ConnectToSQLite;
  if not result then Exit;
  if TimerFactory<>nil then TimerFactory.free;
  LoginFactory.Logout;
  try
    with TfrmMMLogin.Create(self) do
      begin
        try
          result := (ShowModal=MROK);
          Logined := result;
        finally
          free;
        end;
      end;
  finally
     if Logined then LoginFactory.Login(Global.UserID,Global.SHOP_ID);
     if Logined and (mmGlobal.module[2]='1') then TimerFactory := TTimerFactory.Create(DoLoadMsg,StrtoIntDef(ShopGlobal.GetParameter('INTERVALTIME'),10)*60000);
  end;
end;

procedure TfrmMMMain.DropMenu(mid:integer;btn:TrzBmpButton);
procedure AddLine;
var
  Item:TMenuItem;
begin
  if rc=0 then Exit;
  Item := TMenuItem.Create(toolMenu);
  Item.Caption := '-';
  toolMenu.Items.Add(Item);
  rc := 0;
end;
procedure AddPopupMenu(Action:TAction);
var
  Item:TMenuItem;
begin
  if Action=nil then Exit;
  if not Action.Enabled then Exit;
  Item := TMenuItem.Create(toolMenu);
  Item.Action := Action;
  toolMenu.Items.Add(Item);
  inc(rc);
end;
var
  HostP:TPoint;
  lvid:string;
  Action:TAction;
begin
  rc := 0;
  toolMenu.Items.Clear;
  if not CA_MODULE.Locate('MODU_ID',inttostr(mid),[]) then Exit;
  lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (copy(CA_MODULE.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid)
          and
         (length(CA_MODULE.FieldbyName('LEVEL_ID').AsString)>length(lvid))
      then
         begin
           if (CA_MODULE.FieldByName('ACTION_NAME').AsString='') or (CA_MODULE.FieldByName('ACTION_NAME').AsString='#') then
              begin
                if (rc>0) and (CA_MODULE.FieldByName('MODU_TYPE').AsString='1') then AddLine;
              end
           else
              begin
                Action := FindAction(CA_MODULE.FieldByName('ACTION_NAME').AsString);
                if Action.Enabled then AddPopupMenu(Action);
              end;
         end;
      CA_MODULE.Next;
    end;
  HostP := btn.ClientToScreen(Point(0,btn.Height));
  toolMenu.Popup(HostP.X,HostP.Y);
end;
procedure TfrmMMMain.InitTenant;
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

procedure TfrmMMMain.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  for i:=FList.Count -1 downto 0 do TObject(FList[i]).Free;
  FList.Free;
  if Assigned(frmWelcome) then freeandnil(frmWelcome);
  freeandnil(frmPrgBar);
  inherited;

end;

procedure TfrmMMMain.FormCreate(Sender: TObject);
begin
  inherited;
//  BorderStyle := bsNone;
//  WindowState := wsMaximized;
  LoadPic32;
//  SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
  RzVersionInfo.FilePath := ParamStr(0);
  rzVersion.Caption := '版本:' + RzVersionInfo.FileVersion;
  bkg_01.Picture.Bitmap.TransparentColor := clFuchsia;
  bkg_01.Picture.Bitmap.TransparentMode := tmFixed;
  bkg_01.Picture.Bitmap.Transparent := true;
  bkg_02.Picture.Bitmap.TransparentColor := clFuchsia;
  bkg_02.Picture.Bitmap.TransparentMode := tmFixed;
  bkg_02.Picture.Bitmap.Transparent := true;
  bkg_03.Picture.Bitmap.TransparentColor := clFuchsia;
  bkg_03.Picture.Bitmap.TransparentMode := tmFixed;
  bkg_03.Picture.Bitmap.Transparent := true;
  bkg_04.Picture.Bitmap.TransparentColor := clFuchsia;
  bkg_04.Picture.Bitmap.TransparentMode := tmFixed;
  bkg_04.Picture.Bitmap.Transparent := true;
  bkg_f1.Anchors := [akTop,akRight];
  bkg_f1.Top := 2;
  bkg_f1.Left := bkg_top.Width - bkg_f1.Width;
  bkg_f1.Height := BKG_top.Height;
  sysMaximized.Top := 0;
  sysMinimized.Top := 0;
  sysClose.Top := 0;
  sysHelp.Top := 0;

  sysClose.Left := bgk_tt.Width - sysClose.Width-0 ;
  if biMaximize in BorderIcons then
     begin
       sysMaximized.Left := sysClose.Left - sysMaximized.Width -1 ;
       sysMinimized.Left := sysMaximized.Left - sysMinimized.Width -1 ;
       sysHelp.Left := sysMinimized.Left - sysHelp.Width -1 ;
     end
  else
     begin
       sysMaximized.Visible := false;
       sysMinimized.Left := sysClose.Left - sysMinimized.Width -1 ;
       sysHelp.Left := sysMaximized.Left - sysHelp.Width -1 ;
     end;
  sysMinimized.Visible := (biMinimize in BorderIcons);
  FList := TList.Create;
  frmPrgBar := TfrmPrgBar.create(self);

  Screen.OnActiveFormChange := DoActiveChange;

end;

function TfrmMMMain.ConnectToSQLite:boolean;
begin
  result := LoginFactory.ConnectTo();
end;
procedure TfrmMMMain.wm_Login(var Message: TMessage);
var
  uid:string;
begin
  uid := mmGlobal.UserID;
  if Message.LParam = 1 then
     Logined := Login
  else
     Logined := Login and CheckVersion;
  if Logined then
     begin
       try
         Init;
         if (ParamStr(1)='-mmPing') and (Message.LParam = 0) then
            begin
              MMServer.Params := StrPas(GetCommandLine);
              PostMessage(Handle,MM_Params,0,0);
            end;
       except
         on E:Exception do
            begin
              ShowMsgBox(pchar('准备基础数据失败了，请重新登录试试吧.'+#13+'错误原因:'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
              Application.Terminate;
            end;
       end;
     end
  else
     begin
       if (Message.LParam =1) and (uid = mmGlobal.UserID) then Exit;
       Application.Terminate;
     end;
end;
procedure TfrmMMMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
function CheckUpdateStatus:boolean;
begin
  result := (Factor.ExecProc('TGetLastUpdateStatus')='1');
end;
begin
  if (mmGlobal.module[2]='1') then
     begin
        if (ShowMsgBox('为保障您的数据安全，退出时系统将为您的数据进行备份整理，是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
           begin
             CanClose := false;
             Exit;
           end;
        if TimerFactory<>nil then TimerFactory.free;
        HideMMList;
        Visible := false;
        try
          LoginFactory.Logout;
          StopSyncTask;
          if TimerFactory<>nil then TimerFactory.Free;
          if Global.UserID='system' then exit;
          if CaFactory.CheckDebugSync then Exit;
        except
          on E:Exception do
             begin
               ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
               Exit;
             end;
        end;
        if not ShopGlobal.ONLVersion then
           begin
              try
                Global.TryRemateConnect;
              except
                Exit;
              end;
              try
                if not SyncFactory.CheckDBVersion then Raise Exception.Create('你本机使用的软件版本过旧，请升级程序后再使用。');
                if not SyncFactory.SyncLockCheck then Exit;
                if TfrmCostCalc.CheckSyncReck(self) then TfrmCostCalc.TryCalcMthGods(self);
                SyncFactory.SyncAll;
              except
                on E:Exception do
                   ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
              end;
           end
        else
           begin
              try
                if TfrmCostCalc.CheckSyncReck(self) then TfrmCostCalc.TryCalcMthGods(self);
                SyncFactory.SyncRim;
              except
                on E:Exception do
                   ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
              end;
           end;
     end
  else
     begin
        if (ShowMsgBox('是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
           begin
             CanClose := false;
             Exit;
           end;
     end;
end;

procedure TfrmMMMain.Init;
begin
  if frmXsmIEBrowser=nil then frmXsmIEBrowser := TfrmMMBrowser.Create(self);
  if frmRimIEBrowser=nil then frmRimIEBrowser := TfrmMMBrowser.Create(self);
  //读取配置文件
  LoadParams;

  frmLogo.Show;
  rzLeftTool.Enabled := false;
  try
   try
     frmLogo.ShowTitle := '读取我的好友信息';
     if mmGlobal.Logined and (mmGlobal.module[1]='1') then mmGlobal.getAllfriends;
     frmMMList.LoadFriends;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;

   try
     frmLogo.ShowTitle := '连接聊天服务器';
     if mmGlobal.Logined and CaFactory.Audited and (mmGlobal.module[1]='1') then
        begin
          if mmGlobal.chat_addr<>'' then
             begin
               mmGlobal.ConnectToMsc;
               RzTrayIcon1.IconIndex := 1;
             end;
        end;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;

   //准备数据
   //if CaFactory.Audited and (mmGlobal.module[2]='1') then CommandPush.ExecuteCommand;
   
   if CaFactory.Audited and not mmGlobal.ONLVersion then
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync and (mmGlobal.module[2]='1') then
           begin
             CaFactory.SyncAll(1);
           end;
        if SyncFactory.CheckDBVersion and (mmGlobal.module[2]='1') then
           begin
             if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
           end;
      end
   else
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync and (mmGlobal.module[2]='1') then CaFactory.SyncAll(1);
        if CaFactory.Audited and (mmGlobal.module[2]='1') then //管理什么版本，有连接到服务器时，必须先同步数据
           begin
             if mmGlobal.ONLVersion then //在线版只需同步注册数据
                begin
                  frmLogo.ShowTitle := '同步基本信息...';
                  SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                  SyncFactory.SyncComm := SyncFactory.CheckRemeteData;
                  SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSysDefine',0);
                  SyncFactory.SyncSingleTable('CA_SHOP_INFO','TENANT_ID;SHOP_ID','TSyncSingleTable',0);
                  SyncFactory.SyncSingleTable('ACC_ACCOUNT_INFO','TENANT_ID;ACCOUNT_ID','TSyncAccountInfo',0);
                end
             else
                begin
                  if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
                end;
           end;
     end;

   if ( ( (mmGlobal.ONLVersion or mmGlobal.NetVersion) and not mmGlobal.offline ) //网络版，并在线状态
      or
      not (mmGlobal.ONLVersion or mmGlobal.NetVersion) ) //脱机版
      and (mmGlobal.module[2]='1') //有开通销售管理功能
   then InitTenant;

   try
     frmLogo.ShowTitle := '登录RIM后台服务';
     if mmGlobal.Logined and CaFactory.Audited and (mmGlobal.module[4]='1') then
        begin
          frmRimIEBrowser.RimLogin(true);
        end;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;

  finally
    rzLeftTool.Enabled := true;
    frmLogo.Close;
  end;
  
   frmLogo.Show;
   try
     frmLogo.ShowTitle := '正在初始化基础数据...';
     if (mmGlobal.module[2]='1') then mmGlobal.LoadBasic();

     frmLogo.ShowTitle := '正在初始化权限数据...';
     mmGlobal.LoadRight;
     CheckEnabled;
     frmLogo.ShowTitle := '正在初始化系统菜单...';
     if (mmGlobal.module[2]='1') then CreateMenu;

     frmLogo.ShowTitle := '正在初始化同步数据...';
     if (mmGlobal.module[2]='1') then mmGlobal.SyncTimeStamp;
     frmLogo.ShowTitle := '正在初始化广告数据...';
     if (mmGlobal.module[4]='1') then AdvFactory.LoadAdv;
     N26Factory.coPlayList;
     frmMMDesk.LoadDesk;

     UpdateTimer.Enabled := true;

   finally
     frmLogo.Close;
   end;

   if (mmGlobal.module[2]='1') or (mmGlobal.module[3]='1') or (mmGlobal.module[4]='1') then
      begin
        Show;
        if (mmGlobal.module[2]='1') then TfrmWelcome.Popup;
      end
   else
      ShowMMList;

end;

procedure TfrmMMMain.OpenMc(pid: string;mid:integer=0);
var
  Params:TftParamList;
  MMLogin:TMMLogin;
  w:Integer;
begin
   Params := CreateMMLogin;
   try
      if not MMServer.MCExists then
       begin
         ShellExecute(Handle,'open',pchar(ExtractFilePath(ParamStr(0))+pid),'-mmc',pchar(ExtractFilePath(ParamStr(0))),0);
       end;
      w := 0;
      while not MMServer.MCExists do
       begin
         sleep(500);
         inc(w);
         if w>4 then Raise Exception.Create('打开目标应用超时...');
       end;
     Params.ParamByName('fn').AsInteger := mid;
     MMServer.coLogin(Params);
   finally
     Params.free;
   end;
end;

function TfrmMMMain.CreateMMLogin: TftParamList;
var
   Params:TftParamList;
begin
   Params := TftParamList.Create(nil);
   result := Params;
   Params.ParambyName('TENANT_ID').AsInteger := mmGlobal.TENANT_ID;
   Params.ParambyName('TENANT_NAME').AsString := mmGlobal.TENANT_NAME ;
   Params.ParambyName('SHORT_TENANT_NAME').AsString := mmGlobal.SHORT_TENANT_NAME;
   Params.ParambyName('SHOP_ID').AsString := mmGlobal.SHOP_ID;
   Params.ParambyName('SHOP_NAME').AsString := mmGlobal.SHOP_NAME;
   Params.ParambyName('USER_ID').AsString := mmGlobal.UserID;
   Params.ParambyName('USER_NAME').AsString := mmGlobal.UserName;
   if CaFactory.Audited then
      Params.ParambyName('LOGIN_STATUS').AsInteger := 1
   else
      Params.ParambyName('LOGIN_STATUS').AsInteger := 2;
   Params.ParambyName('XSM_USERNAME').AsString := mmGlobal.xsm_username;
   Params.ParambyName('XSM_PASSWORD').AsString := mmGlobal.xsm_password;
   Params.ParambyName('XSM_SIGNATURE').AsString := mmGlobal.xsm_signature;
   Params.ParambyName('XSM_CHALLENGE').AsString := mmGlobal.xsm_challenge;
   Params.ParambyName('XSM_LOGINED').asBoolean := mmGlobal.Logined;
   Params.ParambyName('fn').asInteger := 0;
end;

procedure TfrmMMMain.wm_Sign(var Message: TMessage);
var Params:TftParamList;
begin
  if not mmGlobal.Logined then
     begin
      if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
     end
  else
     begin
      if not mmGlobal.getSignature then Exit;
     end;
  Params := CreateMMLogin;
  try
    MMServer.coSign(Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmMMMain.wm_SessionFail(var Message: TMessage);
var Params:TftParamList;
begin
  if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
  Params := CreateMMLogin;
  try
    MMServer.coSessionFail(Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmMMMain.HideMMList;
begin
  frmMMList.Close;
end;

procedure TfrmMMMain.ShowMMList;
begin
  frmMMList.WindowState := wsNormal;
  frmMMList.ReadInfo;
  frmMMList.Show;
  frmMMList.BringToFront;
end;

procedure TfrmMMMain.miCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMMMain.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmMMMain.AddFrom(form: TForm);
function Find:TrzBmpButton;
var
  i:integer;
begin
  result := nil;
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).Tag = Integer(Pointer(form)) then
         begin
           result := TrzBmpButton(FList[i]);
           break;
         end;
    end;
end;
var
  button:TrzBmpButton;
begin
  button := Find;
  if button=nil then
     begin
       button := TrzBmpButton.Create(bkg_top);
       button.GroupIndex := 999;
       button.Bitmaps.Up.Assign(toolButton.Bitmaps.Up);
       button.Bitmaps.Down.Assign(toolButton.Bitmaps.Down);
       button.Font.Assign(toolButton.Font);
       FList.Add(button);
     end;
  button.Caption := form.Caption;
  button.Tag := Integer(Pointer(form));
  button.OnClick := DoActiveForm;
  button.Visible := true;
  button.Parent := bkg_top;
  button.Down := true;
  TfrmBasic(Form).OnFreeForm := DoFreeForm;
  SortToolButton;
end;

function TfrmMMMain.SortToolButton: boolean;
var
  i:Integer;
  button:TrzBmpButton;
  HasForm:boolean;
begin
  toolClose.Visible := false;
  toolDesk.Top := 42;
  HasForm := false;
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Top := 42;
      button.Visible := (i<5);
      if i=0 then
         button.Left := 139
      else
         button.Left := TrzBmpButton(FList[i-1]).Left+TrzBmpButton(FList[i-1]).width+2;
      if button.Down then
         begin
           toolClose.Top := 42+2;
           toolClose.Left := button.Left + button.Width - 20;
           toolClose.Visible := button.Visible;
           toolClose.BringToFront;
           button.Top := 42;
           HasForm := true;
         end;
    end;
  toolDesk.Down := not HasForm;
  if toolDesk.Down then
     begin
       toolDesk.Top := 42;
     end;
end;

procedure TfrmMMMain.DoActiveChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(screen.ActiveForm)) then
         begin
           TrzBmpButton(FList[i]).Caption :=  screen.ActiveForm.Caption;
           TrzBmpButton(FList[i]).Down := true;
           break;
         end;
      if TrzBmpButton(FList[i]).tag=integer(Pointer(Sender)) then
         begin
           TrzBmpButton(FList[i]).Caption :=  TForm(Sender).Caption;
           TrzBmpButton(FList[i]).Down := true;
           break;
         end;
    end;
  SortToolButton;
end;

procedure TfrmMMMain.DoActiveForm(Sender: TObject);
begin
  TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
  TForm(TrzBmpButton(Sender).tag).BringToFront;
  TrzBmpButton(Sender).Down := true;
  SortToolButton;
end;

procedure TfrmMMMain.DoFreeForm(Sender: TObject);
var
  i:integer;
begin
  for i:=FList.Count -1 downto 0 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(Sender)) then
         begin
           TrzBmpButton(FList[i]).Tag := 0;
           TObject(FList[i]).Free;
           FList.Delete(i);
           if Sender=frmXsmIEBrowser then
              begin
                TForm(Sender).WindowState := wsMinimized;
                TForm(Sender).Left := -9000;
              end;
           if Sender=frmRimIEBrowser then
              begin
                TForm(Sender).WindowState := wsMinimized;
                TForm(Sender).Left := -9000;
              end;
           break;
         end;
    end;
  SortToolButton;
  PostMessage(Handle,WM_DESKTOP_REQUEST,0,0);
end;

procedure TfrmMMMain.sysCloseClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmMMMain.sysMaximizedClick(Sender: TObject);
begin
  inherited;
  if not Visible then Visible := true;
  if WindowState = wsMaximized then
     WindowState := wsNormal
  else
     WindowState := wsMaximized;
end;

procedure TfrmMMMain.sysMinimizedClick(Sender: TObject);
begin
  inherited;
  Hide;
  ShowWindow( Application.Handle, sw_Hide );
end;

procedure TfrmMMMain.RzTrayIcon1LButtonDown(Sender: TObject);
begin
  inherited;
  if not mmFactory.logined then Exit;
  ShowMMList;
end;

procedure TfrmMMMain.ShowMsgDialog;
var
  mmUserInfo:PmmUserInfo;
begin
  mmUserInfo := mmFactory.FindFirst;
  if mmUserInfo<>nil then
     frmMMList.OpenDialog(mmUserInfo.uid);
end;

procedure TfrmMMMain.RzTrayIcon1LButtonDblClick(Sender: TObject);
begin
  inherited;
  if not mmFactory.logined then Exit;
  ShowMsgDialog;
end;

procedure TfrmMMMain.wm_popup(var Message: TMessage);
begin
  DropMenu(Message.WParam,TrzBmpButton(Message.LParam));
end;

procedure TfrmMMMain.actfrmMeaUnitsExecute(Sender: TObject);
begin
  inherited;
  with TfrmMeaUnits.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmMMMain.actfrmDutyInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmDutyInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDutyInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRoleInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRoleInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmRoleInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmDeptInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmDeptInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmDeptInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmUsersExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmUsers);
  if not Assigned(Form) then
     begin
       Form := TfrmUsers.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmBrandInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmGoodsSort.ShowDialog(self,4);

end;

procedure TfrmMMMain.actfrmStockOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStockOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStockOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSalesOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSalesOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalesOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmChangeOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmChangeOrderList1');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '1';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList1';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmChangeOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmChangeOrderList2');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeOrderList.Create(self);
       TfrmChangeOrderList(Form).CodeId := '2';
       TfrmChangeOrderList(Form).Name := 'frmChangeOrderList2';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmGoodsInfoListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmGoodsInfoList);
  if not Assigned(Form) then
     begin
       Form := TfrmGoodsInfoList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmGoodsSortExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  if TfrmGoodsSortTree.ShowDialog(self,1) then
  begin
    Form:=FindChildForm(TfrmGoodsInfoList);
    if Form<>nil then
      TfrmGoodsInfoList(Form).LoadTree;
  end;
end;

procedure TfrmMMMain.actfrmCodeInfo3Execute(Sender: TObject);
begin
  inherited;
  TfrmCodeInfo.ShowDialog(self,3);

end;

procedure TfrmMMMain.actfrmSortInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmGoodsSort.ShowDialog(self,2);

end;

procedure TfrmMMMain.actfrmImplInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmGoodsSort.ShowDialog(self,5);

end;

procedure TfrmMMMain.actfrmAreaInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmGoodsSort.ShowDialog(self,6);

end;

procedure TfrmMMMain.actfrmSaleStyleExecute(Sender: TObject);
begin
  inherited;
  TfrmCodeInfo.ShowDialog(self,2);

end;

procedure TfrmMMMain.actfrmSettleCodeExecute(Sender: TObject);
begin
  inherited;
  TfrmCodeInfo.ShowDialog(self,6);

end;

procedure TfrmMMMain.actfrmShopGroupExecute(Sender: TObject);
begin
  inherited;
  TfrmCodeInfo.ShowDialog(self,12);

end;

procedure TfrmMMMain.actfrmRecvOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRecvOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmRecvOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmPayOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmPayOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPayOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmClientExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmClient);
  if not Assigned(Form) then
     begin
       Form := TfrmClient.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSupplierExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSupplier);
  if not Assigned(Form) then
     begin
       Form := TfrmSupplier.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSalRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSalRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmStkRetuOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStkRetuOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkRetuOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmPosMainExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
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

procedure TfrmMMMain.actfrmPriceGradeInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmPriceGradeInfo.ShowDialog(self);

end;

procedure TfrmMMMain.actfrmSalIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSalIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmSalIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmStkIndentOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStkIndentOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmStkIndentOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmCustomerExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmCustomer);
  if not Assigned(Form) then
     begin
       Form := TfrmCustomer.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSysDefineExecute(Sender: TObject);
begin
  inherited;
  with TfrmSysDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;

end;

procedure TfrmMMMain.actfrmDaysCloseExecute(Sender: TObject);
begin
  inherited;
  TfrmCostCalc.StartDayReck(self);

end;

procedure TfrmMMMain.actfrmMonthCloseExecute(Sender: TObject);
begin
  inherited;
  TfrmCostCalc.StartMonthReck(self);

end;

procedure TfrmMMMain.actfrmCloseForDayExecute(Sender: TObject);
begin
  inherited;
  if TfrmCloseForDay.ShowClDy(self)=2 then ;//ShowMsgBox('当天没有营业数据，不需要结账','友情提示...',MB_OK+MB_ICONINFORMATION);

end;

procedure TfrmMMMain.actfrmPriceOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmPriceOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmPriceOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmCheckOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmCheckOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmCheckOrderList.Create(self);
       AddFrom(Form);
     end;
  TfrmCheckOrderList(Form).DoCheckPrint:=actfrmChecktablePrintExecute;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmDbOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmDbOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmDbOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmTransOrderListExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmTransOrderList);
  if not Assigned(Form) then
     begin
       Form := TfrmTransOrderList.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmShopInfoListExecute(Sender: TObject);
var
  Form:TfrmBasic;
  AObj:TRecord_;
begin
  inherited;
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
        Form.WindowState := wsMaximized;
        Form.Show;
        Form.BringToFront;
     end;
end;

procedure TfrmMMMain.actfrmAccountExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmAccount);
  if not Assigned(Form) then
     begin
       Form := TfrmAccount.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmIoroOrderList1Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmIoroOrderList1');
  if not Assigned(Form) then
     begin
       Form := TfrmIoroOrderList.Create(self);
       TfrmIoroOrderList(Form).IoroType := 1;
       TfrmIoroOrderList(Form).Name := 'frmIoroOrderList1';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmIoroOrderList2Execute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmIoroOrderList2');
  if not Assigned(Form) then
     begin
       Form := TfrmIoroOrderList.Create(self);
       TfrmIoroOrderList(Form).IoroType := 2;
       TfrmIoroOrderList(Form).Name := 'frmIoroOrderList2';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmDevFactoryExecute(Sender: TObject);
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

procedure TfrmMMMain.actfrmStorageTrackingExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStorageTracking);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageTracking.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRckMngExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRckMng);
  if not Assigned(Form) then
  begin
    Form := TfrmRckMng.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmCheckTablePrintExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmCheckTablePrint);
  if not Assigned(Form) then
  begin
    Form := TfrmCheckTablePrint.Create(self);
    AddFrom(Form);
  end;
  if Sender is TRecord_ then
    TfrmCheckTablePrint(Form).DoOpenDefaultData(TRecord_(Sender));
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmJxcTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmJxcTotalReport);
  if not Assigned(Form) then
  begin
    Form := TfrmJxcTotalReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmStockDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStockDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStockDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSaleDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmChange1DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmChange1DayReport');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeDayReport.Create(self);
       TfrmChangeDayReport(Form).CodeId := '1';
       TfrmChangeDayReport(Form).Name := 'frmChange1DayReport';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmChange2DayReportExecute(Sender: TObject);
var Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm('frmChange2DayReport');
  if not Assigned(Form) then
     begin
       Form := TfrmChangeDayReport.Create(self);
       TfrmChangeDayReport(Form).CodeId := '2';
       TfrmChangeDayReport(Form).Name := 'frmChange2DayReport';
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmLockScreenExecute(Sender: TObject);
begin
  inherited;
  frmMMDesk.HookLocked := true;
  try
    TfrmMMLogin.LockScreen(self);
  finally
    frmMMDesk.HookLocked := false;
  end;

end;

procedure TfrmMMMain.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  PostMessage(frmMMMain.Handle,MM_LOGIN,0,1);
end;

procedure TfrmMMMain.sysHelpClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0,'open',pchar(ExtractFilePath(ParamStr(0))+'简易操作手册.chm'),nil,pchar(ExtractFileDir(ParamStr(0))),1);
end;

procedure TfrmMMMain.N2Click(Sender: TObject);
begin
  inherited;
  if not Logined then Exit;
  try
    if CaFactory.Audited then
       begin
         frmLogo.Show;
         try
           if not mmGlobal.Logined then
              begin
                frmLogo.ShowTitle := '正在登录新商盟...';
                if not mmGlobal.xsmLogin then Exit;
              end;
           if mmGlobal.chat_addr='' then Raise Exception.Create('当前用户没有开通聊天服务功能');
           frmLogo.ShowTitle := '正在登录聊天服务器...';
           mmGlobal.ConnectToMsc;
           RzTrayIcon1.Animate := false;
           RzTrayIcon1.IconIndex := 1;
         finally
           frmLogo.Close;
         end;
       end
    else
       Raise Exception.Create('脱机登录状态不能使用即时通讯功能。');
  except
    on E:Exception do
       ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
  end;

end;

procedure TfrmMMMain.N3Click(Sender: TObject);
begin
  inherited;
  if not Logined then Exit;
  PostMessage(frmMMList.Handle,WM_MMCLOSE,1,1);
end;

procedure TfrmMMMain.actfrmStorageDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStorageDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmStorageDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRecvDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRecvDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRckDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRckDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRckDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRelationExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRelation);
  if not Assigned(Form) then
  begin
    Form := TfrmRelation.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmPayDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmPayDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmPayAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmPayAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmPayAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmRecvAbleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRecvAbleReport);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvAbleReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmDbDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmDbDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmDbDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmGodsRunningReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmGodsRunningReport);
  if not Assigned(Form) then
  begin
    Form := TfrmGodsRunningReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmIoroDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmIoroDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmIoroDayReport.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmMessageExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmMessage);
  if not Assigned(Form) then
  begin
    Form := TfrmMessage.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmNewPaperReaderExecute(Sender: TObject);
begin
  inherited;
  TfrmNewPaperReader.ShowNewsPaper('');
end;

procedure TfrmMMMain.actfrmQuestionnaireExecute(Sender: TObject);
begin
  inherited;
  TfrmQuestionnaire.ShowForm(self);
end;

procedure TfrmMMMain.actfrmInLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmInLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmInLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmOutLocusOrderListExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmOutLocusOrderList);
  if not Assigned(Form) then
  begin
    Form := TfrmOutLocusOrderList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmDownIndeOrderExecute(Sender: TObject);
var
  vData: OleVariant;
  Aobj: TRecord_;
  Form: TfrmBasic;
  SaveFactor:TdbFactory;
begin
  inherited;
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
          Form.Show;
          Form.BringToFront;
        end;
      end;
    finally
      Aobj.Free;
    end;
end;

procedure TfrmMMMain.actfrmRecvForDayExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmRecvPosList);
  if not Assigned(Form) then
  begin
    Form := TfrmRecvPosList.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmImpeachExecute(Sender: TObject);
begin
  inherited;
  TfrmImpeach.ShowImpeach(self);
end;

procedure TfrmMMMain.actfrmClearDataExecute(Sender: TObject);
begin
  inherited;
  TfrmClearData.DeleteDB(self);

end;

procedure TfrmMMMain.actfrmSaleAnalyExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleAnaly);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleAnaly.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmNetForOrderExecute(Sender: TObject);
var
  Form:TfrmBasic;
  rimurl:string;
  rimuid:string;
  rimpwd:string;
  Msg:string;
  Params:TftParamList;
begin
  inherited;
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
    Form.WindowState := wsMaximized;
    Form.Show;
    Form.BringToFront;
  except
    Form.Free;
    Raise;
  end;
end;

procedure TfrmMMMain.actfrmSaleManSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleManSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleManSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmClientSaleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmClientSaleReport);
  if not Assigned(Form) then
     begin
       Form := TfrmClientSaleReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSaleTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmStgTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStgTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStgTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmStockTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmStockTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmStockTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSaleMonthTotalReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleMonthTotalReport);
  if not Assigned(Form) then
     begin
       Form := TfrmSaleMonthTotalReport.Create(self);
       AddFrom(Form);
     end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSyncAllExecute(Sender: TObject);
begin
  if CaFactory.Audited then
     begin
       CaFactory.SyncAll(1);
       //if ShopGlobal.ONLVersion then Exit;
     end
  else
     begin
       //if ShopGlobal.ONLVersion then Raise Exception.Create('网络版不需要执行数据同步...');
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
    if not ShopGlobal.ONLVersion and not ShopGlobal.NetVersion and TfrmCostCalc.CheckSyncReck(self) then TfrmCostCalc.TryCalcMthGods(self);
    if ShopGlobal.ONLVersion then SyncFactory.SyncRim else
       begin
         SyncFactory.SyncAll;
         frmLogo.Show;
         Global.LoadBasic;
         ShopGlobal.LoadRight;
       end;
  finally
    frmLogo.Close;
  end;
end;

procedure TfrmMMMain.actfrmGoodsMonthExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmGoodsMonth);
  if not Assigned(Form) then
  begin
    Form := TfrmGoodsMonth.Create(self);
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmInitGuideExecute(Sender: TObject);
begin
  inherited;
  TfrmInitGuide.InitGuide(self);

end;

procedure TfrmMMMain.CheckEnabled;
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

  SortLeftButton;
end;

procedure TfrmMMMain.LoadParams;
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    Application.Title :=  F.ReadString('soft','name','rspcn.com');
    if not FindCmdLineSwitch('rsp',['-','+'],false) then
       begin
          SFVersion := F.ReadString('soft','SFVersion','.NET');
          CLVersion := F.ReadString('soft','CLVersion','.MKT');
          ProductID := F.ReadString('soft','ProductID','R3_RYC');
       end;
    softname.Caption := Application.Title;
  finally
    try
      F.Free;
    except
    end;
  end;
//  if FileExists(ExtractFilePath(ParamStr(0))+'logo_lt.jpg') then
//     logo.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'logo_lt.jpg');
end;

procedure TfrmMMMain.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  if actfrmSyncAll.Enabled then
     actfrmSyncAll.OnExecute(actfrmSyncAll)
  else
     ShowMsgBox('你没有执行数据同步的权限，请跟管理员联系','友情提示...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmMMMain.toolCloseClick(Sender: TObject);
var
  i:Integer;
  button:TrzBmpButton;
begin
  for i:=FList.Count -1 downto 0 do
    begin
      button := TrzBmpButton(FList[i]);
      if button.Down then
         begin
           TForm(button.Tag).Close;
           break;
         end;
    end;
  PostMessage(Handle,WM_DESKTOP_REQUEST,0,0);
end;

constructor TfrmMMMain.Create(AOwner: TComponent);
begin
  inherited;
  TimerFactory := nil;
  FMenu := TList.Create;
  FormStyle := fsMDIForm;
  frmMMToolBox := TfrmMMToolBox.Create(self);
  frmXsmIEBrowser := nil;
  frmRimIEBrowser := nil;
  pageLine.Top := bkg_top.Height  - 1;
  pageLine.Left := toolDesk.Left;
  pageLine.Width := bkg_top.Width - toolDesk.Left + 16;
  r3offline.Left := bkg_bottom.Width - r3offline.width - 10;
  UsersStatus.Left := r3offline.Left - usersStatus.Width - 5;
  MMServer.MMHandle := Handle;
end;

destructor TfrmMMMain.Destroy;
var
  i:integer;
begin
  Logined := false;
  Screen.OnActiveFormChange := nil;
  for i:=0 to FMenu.Count -1 do TObject(FMenu[i]).Free;
  FMenu.Free;
  if frmXsmIEBrowser<>nil then freeAndNil(frmXsmIEBrowser);
  if frmRimIEBrowser<>nil then freeAndNil(frmRimIEBrowser);
  freeAndNil(frmMMToolBox);
  inherited;
end;

procedure TfrmMMMain.PupupToolBox(Sender: TObject;s:string);
begin
  if not CA_MODULE.Locate('MODU_NAME',s,[]) then Exit;
  frmMMToolBox.Popup(TWinControl(Sender),CA_MODULE.FieldbyName('MODU_ID').AsString);
end;

procedure TfrmMMMain.toolDeskClick(Sender: TObject);
begin
  inherited;
  frmMMDesk.Locked := true;
  frmMMDesk.BringToFront;
  SortToolButton;
end;

procedure TfrmMMMain.rzPage2Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上订货');

end;

procedure TfrmMMMain.rzPage3Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上配货');

end;

procedure TfrmMMMain.rzPage4Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上结算');

end;

procedure TfrmMMMain.actfrmXsmNetExecute(Sender: TObject);
var
  s:string;
  sl:TStringList;
begin
  inherited;
  if not CaFactory.Audited then Raise Exception.Create('脱网登录不能使用此模块。');
  if not CA_MODULE.Active then CheckEnabled;
  if not CA_MODULE.Locate('MODU_ID',PMMToolBox(Sender)^.mid,[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  if not ShopGlobal.GetChkRight(PMMToolBox(Sender)^.mid) then Raise Exception.Create('您没有操作此模块的权限.');
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not mmGlobal.Logined then
     begin
       if ShowMsgBox('连接已经断开了，是否重连新商盟服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       frmLogo.Show;
       try
         frmLogo.ShowTitle := '正在进行身份认证读取令牌';
         if not mmGlobal.xsmLogin then Exit;
       finally
         frmLogo.Close;
       end;
     end;

  frmXsmIEBrowser.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
  AddFrom(frmXsmIEBrowser);
  frmXsmIEBrowser.WindowState := wsMaximized;
  frmXsmIEBrowser.BringToFront;
  if not frmXsmIEBrowser.xsmLogined then
     begin
       if not frmXsmIEBrowser.XsmLogin(true) then Exit;
     end;
  sl := TStringList.Create;
  frmLogo.Show;
  try
    sl.CommaText := s;
    if not frmXsmIEBrowser.LCSend(frmXsmIEBrowser.CreateOpenFava(sl.Values['sceneId'],sl.Values['objectId'])) then
       begin
         if frmXsmIEBrowser.xsmLCStatus = lcTimeOut then
            begin
              if ShowMsgBox('打开模块超时了，是否继续？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6 then Exit;
            end;
         if frmXsmIEBrowser.xsmLCStatus = lcError then
            begin
              if ShowMsgBox('打开模块出错了，是否继续？','友情提示..',MB_YESNO+MB_ICONQUESTION)=6 then Exit;
            end;
         if frmXsmIEBrowser.xsmLCStatus = lcStoped then
            begin
              ShowMsgBox('当前模块正在业务中，不能切换模块','友情提示..',MB_OK+MB_ICONQUESTION);
              Exit;
            end;
         if frmXsmIEBrowser.xsmSessionFail then
            begin
              ShowMsgBox('新商盟会话失效了，请重点试吧。','友情提示..',MB_OK+MB_ICONQUESTION);
              Exit;
            end;
         PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
       end;
  finally
    frmLogo.Close;
    sl.free;
  end;
end;

procedure TfrmMMMain.wm_desktop(var Message: TMessage);
begin
  toolDesk.down := true;
  toolDesk.OnClick(toolDesk);
end;

procedure TfrmMMMain.actfrmRimNetExecute(Sender: TObject);
var
  s,p:string;
  Form:TfrmBasic;
  sl:TStringList;
begin
  inherited;
  if not CaFactory.Audited then Raise Exception.Create('脱网登录不能使用此模块。');
  if not CA_MODULE.Active then CheckEnabled;
  if not CA_MODULE.Locate('MODU_ID',PMMToolBox(Sender)^.mid,[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  if not ShopGlobal.GetChkRight(PMMToolBox(Sender)^.mid) then Raise Exception.Create('您没有操作此模块的权限.'); 
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  sl := TStringList.Create;
  try
    sl.CommaText := s;
    if (sl.values['xsm']='true') then
     begin
        if not mmGlobal.Logined then
           begin
             if ShowMsgBox('连接已经断开了，是否重连新商盟服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
             frmLogo.Show;
             try
               frmLogo.ShowTitle := '正在进行身份认证读取令牌';
               if not mmGlobal.xsmLogin then Exit;
             finally
               frmLogo.Close;
             end;
             frmRimIEBrowser.rimLogined := false;
           end;
     end;

    if not frmRimIEBrowser.rimLogined then
     begin
       if ShowMsgBox('连接已经断开了，是否重连RIM服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       if not frmRimIEBrowser.RimLogin(true) then Exit;
     end;
    frmLogo.Show;
    sl.CommaText := s;
    frmRimIEBrowser.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
    AddFrom(frmRimIEBrowser);
    frmRimIEBrowser.WindowState := wsMaximized;
    frmRimIEBrowser.BringToFront;
    if pos('?',sl.values['url'])=0 then p := '?' else p := '&';
    frmRimIEBrowser.IEOpen(frmRimIEBrowser.rimUrl+sl.values['url']+p+'comId='+frmRimIEBrowser.rimcomId+'&custId='+frmRimIEBrowser.rimcustId);
  finally
    frmLogo.Close;
    sl.free;
  end;
end;

procedure TfrmMMMain.N5Click(Sender: TObject);
begin
  inherited;
  if not Logined then Exit;
  TfrmPswModify.ShowExecute(Global.UserID,Global.UserName);
end;

procedure TfrmMMMain.SetLogined(const Value: boolean);
begin
  FLogined := Value;
  copyRight.Caption := '版权所属：山东浪潮齐鲁软件产业股份有限公司  ｜  '+mmGlobal.TENANT_NAME + '('+mmGlobal.UserName+')';
  UsersStatus.Down := not CaFactory.Audited;
  if CaFactory.Audited then
     r3offline.Caption := '在线登录'
  else
     r3offline.Caption := '离线登录';
end;

procedure TfrmMMMain.UpdateTimerTimer(Sender: TObject);
var
  P:PMsgInfo;
  w:integer;
  IsFirst:boolean;
begin
  inherited;
  w := StrtoIntDef(ShopGlobal.GetParameter('INTERVALTIME'),10)*60;
  if PrainpowerJudge.Locked>0 then Exit;
  if not Logined then Exit;
  if not Visible then Exit;
  if not Factor.Connected then Exit;

  IsFirst := false;
  if (not MsgFactory.Loaded and (UpdateTimer.Tag>5)) or (MsgFactory.Loaded and (UpdateTimer.Tag>0) and
     (MsgFactory.UnRead=0) and ((UpdateTimer.Tag mod w)=0)
     )
  then
     begin
       MsgFactory.Load;
       IsFirst := true;
     end;

  if UpdateTimer.Tag >= w then UpdateTimer.Tag := 0 else UpdateTimer.Tag := UpdateTimer.Tag + 1;
  if MsgFactory.Count > 0 then
     begin
       lbM1.Caption := '('+inttostr(MsgFactory.UnRead)+')条';
       case UpdateTimer.Tag mod 2 of
       0:begin
           lbM1.Font.Color := clRed;
           lbM1.Font.Style := [fsBold];
         end;
       1:begin
           lbM1.Font.Color := clWhite;
           lbM1.Font.Style := [];
         end;
       end;
     end
  else
     begin
       lbM1.Caption := '(0)条';
     end;

  if (MsgFactory.Loaded and ((UpdateTimer.Tag mod w)=0)) or IsFirst or MsgFactory.Opened then
     begin
       P := MsgFactory.ReadMsg;
       if P<>nil then MsgFactory.HintMsg(P);
     end;
end;

procedure TfrmMMMain.MenuSpiltClick(Sender: TObject);
begin
  inherited;
  bkgMenu.Visible := not bkgMenu.Visible;
  MenuSpilt.Down := not bkgMenu.Visible;
  OnResize(self);
end;

procedure TfrmMMMain.UsersStatusClick(Sender: TObject);
begin
  inherited;
  UsersStatus.Down := not CaFactory.Audited;

end;

procedure TfrmMMMain.CreateMenu;
function CheckRight(mid:integer):boolean;
var
  lvid:string;
  Action:TAction;
begin
  result := false;
  if not CA_MODULE.Locate('MODU_ID',inttostr(mid),[]) then Exit;
  lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (copy(CA_MODULE.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid)
          and
         (length(CA_MODULE.FieldbyName('LEVEL_ID').AsString)>length(lvid))
      then
         begin
           if (CA_MODULE.FieldByName('ACTION_NAME').AsString='') or (CA_MODULE.FieldByName('ACTION_NAME').AsString='#') then
              begin
              end
           else
              begin
                Action := FindAction(CA_MODULE.FieldByName('ACTION_NAME').AsString);
                if Assigned(Action) and Action.Enabled then
                   begin
                     result := true;
                     Exit;
                   end;
              end;
         end;
      CA_MODULE.Next;
    end;
end;
var
  i:integer;
  lvid:string;
  button:TrzBmpButton;
  l:integer;
begin
  for i:=0 to FMenu.Count -1 do
     begin
       TObject(FMenu[i]).Free;
     end;
  FMenu.Clear;
  if CA_MODULE.Locate('MODU_NAME,','零售终端',[]) then
     lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString
  else
     lvid := '';
  l := 0;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (copy(CA_MODULE.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid)
          and
         (length(CA_MODULE.FieldbyName('LEVEL_ID').AsString)=length(lvid)+3)
      then
         begin
           button := TrzBmpButton.Create(bkg_top);
           button.Parent := bkg_top;
           button.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
           button.Tag := CA_MODULE.FieldbyName('MODU_ID').AsInteger;
           button.OnClick := DoOpenMenu;
           button.Font.Color := clWhite;
           button.Font.Style := [fsBold];
           button.Bitmaps.Hot.Assign(menuButton.Bitmaps.Hot);
           button.Bitmaps.Up.Assign(menuButton.Bitmaps.Up);
           button.Font.Assign(menuButton.Font);
           button.Anchors := [akTop,akRight];
           button.width := 70;
           FMenu.Add(button);
           button.Top := 3;
         end;
      CA_MODULE.Next;
    end;
  l := 0;
  for i:=FMenu.Count -1 downto 0 do
    begin
      if not CheckRight(TrzBmpButton(FMenu[i]).Tag) then
         begin
           TrzBmpButton(FMenu[i]).Free;
           FMenu.Delete(i);
         end
      else
         begin
           inc(l);
           button := TrzBmpButton(FMenu[i]);
           button.Left := bkg_top.Width - ((button.Width)*l)- 160;
         end;
    end;
end;

procedure TfrmMMMain.DoOpenMenu(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FMenu.Count-1 do
     begin
       if TrzBmpButton(Sender)<>TrzBmpButton(FMenu[i]) then
          PostMessage(TrzBmpButton(FMenu[i]).handle,CM_MOUSELEAVE,0,0);
     end;
  PostMessage(handle,MSC_POPUP,TrzBmpButton(Sender).tag,integer(Sender));
end;

procedure TfrmMMMain.wm_lcControl(var Message: TMessage);
begin
  if frmXsmIEBrowser=nil then
     begin
       TObject(Message.WParam).Free;
       Exit;
     end;
  frmXsmIEBrowser.LCRecv(TmmLCControlFava(Message.WParam));
end;

procedure TfrmMMMain.RzFormShape1DblClick(Sender: TObject);
begin
  inherited;
  sysMaximized.onClick(sysMaximized);
end;

procedure TfrmMMMain.rzPage8Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'我的社区');
end;

procedure TfrmMMMain.rzPage0Click(Sender: TObject);
begin
  inherited;
  if (mmGlobal.module[1]<>'1') then
     begin
       ShowMsgBox('您没有开通即时通讯功能！','友情提示..',MB_OK);
       Exit;
     end;
  ShowMMList;
end;

procedure TfrmMMMain.rzPage1Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上营销');

end;

procedure TfrmMMMain.rzPage6Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'品牌培育');
end;

procedure TfrmMMMain.rzPage7Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'信息互通');

end;

procedure TfrmMMMain.rzPage5Click(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,WM_DESKTOP_REQUEST,0,0);
end;

procedure TfrmMMMain.wm_mmcError(var Message: TMessage);
begin
  ShowMsgBox(pchar(mmFactory.LastError),'mmc',MB_OK+MB_ICONERROR);
end;

procedure TfrmMMMain.wm_message(var Message: TMessage);
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
     if not frmXsmIEBrowser.xsmLogined then Exit;
     frmXsmIEBrowser.LCSend(frmXsmIEBrowser.CreateOpenFava(PMsgInfo(Message.LParam)^.SenceId,PMsgInfo(Message.LParam)^.Action),1);
  end;
end;

procedure TfrmMMMain.actfrmSimpleSaleDayReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    TfrmSaleDayReport(Form).SingleReportParams;
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.LoadPic32;
var
  DllHandle: THandle;
  sflag:String;
begin
  sflag := 'm'+rcFactory.GetResString(1)+'_';
  //Left
  //rzPage0.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left0_hot');
  //rzPage0.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left0');
  rzPage1.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left1_hot');
  rzPage1.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left1');
  rzPage2.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left2_hot');
  rzPage2.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left2');
  rzPage3.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left3_hot');
  rzPage3.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left3');
  rzPage4.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left4_hot');
  rzPage4.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left4');
  rzPage5.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left5_hot');
  rzPage5.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left5');
  rzPage6.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left6_hot');
  rzPage6.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left6');
  rzPage7.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left7_hot');
  rzPage7.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left7');
  rzPage8.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'left8_hot');
  rzPage8.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'left8');
  //bottom
  UsersStatus.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'bottom_Status_Down');
  UsersStatus.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'bottom_Status');
  bkg_03.Picture.Graphic := rcFactory.GetBitmap(sflag + 'bottom_bkg_03');
  bkg_04.Picture.Graphic := rcFactory.GetBitmap(sflag + 'bottom_bkg_04');
  //top
  bkg_01.Picture.Graphic := rcFactory.GetBitmap(sflag + 'top_bkg_01');
  bkg_02.Picture.Graphic := rcFactory.GetBitmap(sflag + 'top_bkg_02');
  logo.Picture.Graphic := rcFactory.GetJpeg(sflag + 'top_logo');
  toolDesk.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_toolDesk_Up');
  toolDesk.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_toolDesk_Hot');
  toolDesk.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'top_toolDesk_Down');
  toolClose.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_toolClose_Up');
  toolClose.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_toolClose_Hot');
  RzBmpButton1.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_RzBmpButton1_Up');
  RzBmpButton1.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_RzBmpButton1_Hot');
  RzBmpButton3.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_RzBmpButton3_Up');
  RzBmpButton3.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_RzBmpButton3_Hot');
  RzBmpButton4.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_RzBmpButton4_Up');
  RzBmpButton4.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_RzBmpButton4_Hot');
  MenuSpilt.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_MenuSpilt_Up');
  MenuSpilt.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'top_MenuSpilt_Down');
  sysHelp.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_sysHelp_Up');
  sysHelp.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_sysHelp_Hot');
  sysMinimized.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_sysMinimized_Up');
  sysMinimized.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_sysMinimized_Hot');
  sysMaximized.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_sysMaximized_Up');
  sysMaximized.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_sysMaximized_Hot');
  sysClose.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'top_sysClose_Up');
  sysClose.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'top_sysClose_Hot');
  Image5.Picture.Graphic := rcFactory.GetBitmap(sflag + 'list_mid_bkg_03');

end;

procedure TfrmMMMain.WMNCHITTEST(var Msg: TWMNCHITTEST);
const
  cOffset = 10;
var
  vPoint: TPoint;
begin
  inherited;
  vPoint := ScreenToClient(Point(Msg.XPos, Msg.YPos));
  if PtInRect(Rect(0, 0, cOffset, cOffset), vPoint) then
    Msg.Result := HTTOPLEFT
  else if PtInRect(Rect(Width - cOffset, Height - cOffset, Width, Height), vPoint) then
    Msg.Result := HTBOTTOMRIGHT
  else if PtInRect(Rect(Width - cOffset, 0, Width, cOffset), vPoint) then
    Msg.Result := HTTOPRIGHT
  else if PtInRect(Rect(0, Height - cOffset, cOffset, Height), vPoint) then
    Msg.Result := HTBOTTOMLEFT
  else if PtInRect(Rect(cOffset, 0, Width - cOffset, cOffset), vPoint) then
    Msg.Result := HTTOP
  else if PtInRect(Rect(0, cOffset, cOffset, Height - cOffset), vPoint) then
    Msg.Result := HTLEFT
  else if PtInRect(Rect(Width - cOffset, cOffset, Width, Height - cOffset), vPoint) then
    Msg.Result := HTRIGHT
  else if PtInRect(Rect(cOffset, Height - cOffset, Width - cOffset, Height), vPoint) then
    Msg.Result := HTBOTTOM;
end;

procedure TfrmMMMain.RzTrayIcon1RestoreApp(Sender: TObject);
begin
  inherited;
  if not Logined then Exit;
  if (mmGlobal.module[2]='1') or (mmGlobal.module[3]='1') or (mmGlobal.module[4]='1') then
     begin
       Show;
       WindowState := wsMaximized;
     end
  else
     ShowMMList;

end;

procedure TfrmMMMain.wm_Params(var Message: TMessage);
begin
  //添加对-mmPing的解悉
  if MMServer.ParamStr(1)='-mmPing' then
     begin
       frmMMList.addStranger(MMServer.ParamStr(2),MMServer.ParamStr(3));
       if mmFactory.Logined then frmMMList.OpenDialog(MMServer.ParamStr(2));
     end;
end;

function TfrmMMMain.CheckVersion: boolean;
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
  if not CaFactory.Audited then
     begin
       result := true;
       Exit;
     end;
  try
  try
    frmLogo.Show;
    frmLogo.ShowTitle := '检测版本信息...';
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
  finally
    frmLogo.Close;
  end;
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

procedure TfrmMMMain.RzBmpButton4Click(Sender: TObject);
//var
//  MMToolBox:PMMToolBox;
begin
  inherited;
  if (mmGlobal.module[1]<>'1') then
     begin
       ShowMsgBox('您没有开通即时通讯功能！','友情提示..',MB_OK);
       Exit;
     end;
  ShowMMList;
{  if not CA_MODULE.Locate('MODU_NAME','在线客服',[]) then Raise Exception.Create('你没有开通在线客服业务');
  new(MMToolBox);
  try
    MMToolBox^.mid := CA_MODULE.FieldbyName('MODU_ID').AsString;
    MMToolBox^.Action := actfrmRimNet;
    actfrmRimNet.OnExecute(TObject(MMToolBox));
  finally
    Dispose(MMToolBox);
  end;}
end;

procedure TfrmMMMain.lbM1Click(Sender: TObject);
begin
  inherited;
  actfrmNewPaperReader.OnExecute(actfrmNewPaperReader);

end;

procedure TfrmMMMain.Show;
begin
  inherited Show;
  WindowState := wsMaximized;
end;

procedure TfrmMMMain.SortLeftButton;
var
  w:integer;
begin
//  rzPage0.Visible := mmGlobal.module[1]='1';
  rzPage1.Visible := CA_MODULE.Locate('MODU_NAME','网上营销',[]);
  rzPage2.Visible := CA_MODULE.Locate('MODU_NAME','网上订货',[]);
  rzPage3.Visible := CA_MODULE.Locate('MODU_NAME','网上配货',[]);
  rzPage4.Visible := CA_MODULE.Locate('MODU_NAME','网上结算',[]);
  rzPage6.Visible := CA_MODULE.Locate('MODU_NAME','品牌培育',[]);
  rzPage7.Visible := CA_MODULE.Locate('MODU_NAME','信息互通',[]);
  rzPage8.Visible := CA_MODULE.Locate('MODU_NAME','我的社区',[]);

  w := -1;
//  if rzPage0.Visible then inc(w);
//  rzPage0.Top := 0+w*rzPage0.Height;
  if rzPage1.Visible then inc(w);
  rzPage1.Top := 0+w*rzPage1.Height;
  if rzPage2.Visible then inc(w);
  rzPage2.Top := 0+w*rzPage2.Height;
  if rzPage3.Visible then inc(w);
  rzPage3.Top := 0+w*rzPage3.Height;
  if rzPage4.Visible then inc(w);
  rzPage4.Top := 0+w*rzPage4.Height;
  if rzPage5.Visible then inc(w);
  rzPage5.Top := 0+w*rzPage5.Height;
  if rzPage6.Visible then inc(w);
  rzPage6.Top := 0+w*rzPage6.Height;
  if rzPage7.Visible then inc(w);
  rzPage7.Top := 0+w*rzPage7.Height;
  if rzPage8.Visible then inc(w);
  rzPage8.Top := 0+w*rzPage8.Height;

end;

procedure TfrmMMMain.actfrmNothingExecute(Sender: TObject);
begin
  inherited;
  ShowMsgBox('暂时没有开通此功能，感谢您的关注！','友情提示...',MB_OK);
end;

procedure TfrmMMMain.SetWindowState(const Value: TWindowState);
begin
  if Value = wsMaximized then
     begin
       inherited WindowState := wsNormal;
       SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
     end;
  if Value = wsNormal then
     begin
       inherited WindowState := wsNormal;
       SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,800,590);
     end;
  if Value = wsMinimized then
     begin
       inherited WindowState := wsMinimized;
       SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,800,590);
     end;
  RzFormShape1.Enabled := not (Value = wsMaximized);
  FWindowState := Value;
end;

procedure TfrmMMMain.actfrmWelcomeExecute(Sender: TObject);
begin
  inherited;
  TfrmWelcome.Popup;
end;

procedure TfrmMMMain.actfrmSaleDaySingleReportExecute(Sender: TObject);
var
  Form:TfrmBasic;
begin
  inherited;
  Form := FindChildForm(TfrmSaleDayReport);
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    TfrmSaleDayReport(Form).SingleReportParams;
    AddFrom(Form);
  end;
  Form.WindowState := wsMaximized;
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.DoLoadMsg(Sender: TObject);
begin
  if not Visible then Exit;
  if not Logined then Exit;
  if mmGlobal.module[2]<>'1' then Exit;
  if SyncFactory.Locked > 0 then Exit;
  PrainpowerJudge.SyncMsgc;
end;

procedure TfrmMMMain.actfrmDeskPageExecute(Sender: TObject);
var
  s:string;
  sl:TStringList;
begin
  inherited;
  if not CA_MODULE.Active then CheckEnabled;
  if not CA_MODULE.Locate('MODU_ID',PMMToolBox(Sender)^.mid,[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  if not ShopGlobal.GetChkRight(PMMToolBox(Sender)^.mid) then Raise Exception.Create('您没有操作此模块的权限.');
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  frmMMDesk.OpenPage(s); 
end;

end.
