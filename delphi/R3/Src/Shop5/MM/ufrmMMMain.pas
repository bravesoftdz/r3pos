unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, uMMUtil, uMMServer ,ShellApi,
  ZBase, RzTray, StdCtrls, Mask, RzEdit, RzBmpBtn, RzLabel, jpeg, RzPanel,
  ImgList, RzBckgnd, RzForms, ToolWin, Buttons, RzButton, ufrmBasic, ZdbFactory,
  ZDataSet, DB, ZAbstractRODataset, ZAbstractDataset, ufrmMMBrowser,ummFactory;

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
    CA_MODULE: TZQuery;
    sysHelp: TRzBmpButton;
    sysMinimized: TRzBmpButton;
    sysMaximized: TRzBmpButton;
    sysClose: TRzBmpButton;
    bkg_02: TImage;
    RzFormShape1: TRzFormShape;
    N4: TMenuItem;
    N5: TMenuItem;
    copyRight: TRzLabel;
    r3offline: TRzLabel;
    UsersStatus: TRzBmpButton;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel1: TRzPanel;
    RzBmpButton7: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzBmpButton8: TRzBmpButton;
    RzBmpButton9: TRzBmpButton;
    RzBmpButton10: TRzBmpButton;
    RzBmpButton11: TRzBmpButton;
    RzBmpButton12: TRzBmpButton;
    menuButton: TRzBmpButton;
    pageLine: TRzSeparator;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miCloseClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure sysCloseClick(Sender: TObject);
    procedure sysMaximizedClick(Sender: TObject);
    procedure sysMinimizedClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
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
    procedure RzBmpButton5Click(Sender: TObject);
    procedure toolDeskClick(Sender: TObject);
    procedure RzBmpButton8Click(Sender: TObject);
    procedure RzBmpButton9Click(Sender: TObject);
    procedure RzBmpButton10Click(Sender: TObject);
    procedure actfrmXsmNetExecute(Sender: TObject);
    procedure actfrmRimNetExecute(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure MenuSpiltClick(Sender: TObject);
    procedure UsersStatusClick(Sender: TObject);
    procedure RzFormShape1DblClick(Sender: TObject);
  private
    { Private declarations }
    FList:TList; {导航菜单}
    FMenu:TList; {主菜单}
    rc:int64;
    
    frmXsmIEBrowser:TfrmMMBrowser;
    frmRimIEBrowser:TfrmMMBrowser;
    FLogined: boolean;

    procedure wm_Login(var Message: TMessage); message MM_LOGIN;
    procedure wm_Sign(var Message: TMessage); message MM_SIGN;
    procedure wm_SessionFail(var Message: TMessage); message MM_SESSION_FAIL;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure wm_lcControl(var Message: TMessage); message WM_LCCONTROL;

    //导航工具栏
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure AddFrom(form:TForm);
    procedure RemoveFrom(form:TForm);
    function  SortToolButton:boolean;

    //菜单管理
    procedure CreateMenu;
    procedure DoOpenMenu(Sender:TObject);
    procedure wm_popup(var Message: TMessage); message MSC_POPUP;
    procedure DropMenu(mid:integer;btn:TrzBmpButton);
    procedure PupupToolBox(Sender:TObject;s:string);
    procedure SetLogined(const Value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

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
    //软是否登录
    property Logined:boolean read FLogined write SetLogined;
  end;

var
  frmMMMain: TfrmMMMain;

implementation
uses
  ufrmMMLogin, ufrmMMList,ufrmHintMsg,uMsgBox,
  uDsUtil,uFnUtil,ufrmLogo,uTimerFactory,ufrmTenant, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogin,
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
  ufrmOptionDefine,ufrmInitialRights,uAdvFactory,ufrmXsmLogin,ufrmNetLogin,ufrmInitGuide,
  uLoginFactory,ufrmGoodsMonth,uSyncThread,uCommand, ummGlobal, ufrmMMDesk, ufrmMMToolBox;
var
  frmMMToolBox:TfrmMMToolBox;
{$R *.dfm}

function TfrmMMMain.Login: boolean;
begin
  result := ConnectToSQLite;
  if not result then Exit;
  with TfrmMMLogin.Create(self) do
    begin
      try
        result := (ShowModal=MROK);
        Logined := result;
      finally
        free;
      end;
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

procedure TfrmMMMain.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  freeandnil(frmLogo);
  inherited;

end;

procedure TfrmMMMain.FormCreate(Sender: TObject);
begin
  inherited;
  BorderStyle := bsNone;
  WindowState := wsMaximized;
  SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
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
  RzFormShape1.Enabled := not (WindowState = wsMaximized);
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
  frmLogo := TfrmLogo.create(self);
  ConnectToSQLite;

  Screen.OnActiveFormChange := DoActiveChange;

end;

function TfrmMMMain.ConnectToSQLite:boolean;
var
  Factory:TCreateDbFactory;
begin
  result := true;
  Global.MoveToLocal;
  Global.Connect;
  Factory := TCreateDbFactory.Create;
  try
    if Factory.CheckVersion(DBVersion,Global.LocalFactory) then
       result := TfrmDbUpgrade.DbUpgrade(Factory,Global.LocalFactory);
  finally
    Factory.Free;
  end;
end;
procedure TfrmMMMain.wm_Login(var Message: TMessage);
var uid:string;
begin
  uid := mmGlobal.UserID;
  Logined := Login;
  if Logined then
     begin
       try
         Init;
       except
         on E:Exception do
            begin
              ShowMsgBox('准备基础数据失败了，请重新登录试试吧.','友情提示...',MB_OK+MB_ICONINFORMATION);
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
  if (ShowMsgBox('为保障您的数据安全，退出时系统将为您的数据进行备份整理，是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       CanClose := false;
       Exit;
       //Application.Minimize;
     end;
  StopSyncTask;
  if TimerFactory<>nil then TimerFactory.Free;
  if Global.UserID='system' then exit;
  if CaFactory.Audited and not ShopGlobal.NetVersion and not ShopGlobal.ONLVersion and Global.RemoteFactory.Connected and CheckUpdateStatus and SyncFactory.CheckDBVersion and SyncFactory.SyncLockCheck then
     begin
        try
          SyncFactory.SyncAll;
        except
          on E:Exception do
             ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
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
  try
   try
     frmLogo.ShowTitle := '读取我的好友信息';
     if mmGlobal.Logined then mmGlobal.getAllfriends;
     frmMMList.LoadFriends;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;
   
   try
     frmLogo.ShowTitle := '连接聊天服务器';
     if mmGlobal.Logined and CaFactory.Audited then
        begin
          mmGlobal.ConnectToMsc;
          RzTrayIcon1.IconIndex := 1;
        end;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;

   if CaFactory.Audited and not mmGlobal.ONLVersion then
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if SyncFactory.CheckDBVersion then
           begin
             if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
           end;
      end
   else
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if CaFactory.Audited then //管理什么版本，有连接到服务器时，必须先同步数据
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

   try
     frmLogo.ShowTitle := '登录RIM后台服务';
     if mmGlobal.Logined and CaFactory.Audited then
        begin
          frmRimIEBrowser.RimLogin(true);
          RzTrayIcon1.IconIndex := 1;
        end;
   except
     on E:Exception do
        ShowMsgBox(Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;

  finally
    ShowMMList;
    frmLogo.Close;
  end;
  
   //准备数据
   CommandPush.ExecuteCommand;
   frmLogo.Show;
   try
     frmLogo.ShowTitle := '正在初始化权限数据...';
     mmGlobal.LoadRight;
     CheckEnabled;
     frmLogo.ShowTitle := '正在初始化系统菜单...';
     CreateMenu;

     frmLogo.ShowTitle := '正在初始化基础数据...';
     mmGlobal.LoadBasic();
     frmLogo.ShowTitle := '正在初始化同步数据...';
     mmGlobal.SyncTimeStamp;
     frmLogo.ShowTitle := '正在初始化广告数据...';
     AdvFactory.LoadAdv;
     frmMMDesk.LoadDesk;
   finally
     frmLogo.Close;
   end;
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

procedure TfrmMMMain.RemoveFrom(form: TForm);
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

function TfrmMMMain.SortToolButton: boolean;
var
  i:Integer;
  button:TrzBmpButton;
begin
  toolClose.Visible := false;
  toolDesk.Top := 45;
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Top := 45;
      if i=0 then
         button.Left := 126
      else
         button.Left := TrzBmpButton(FList[i-1]).Left+TrzBmpButton(FList[i-1]).width+2;
      if button.Down then
         begin
           toolClose.Top := 41+3;
           toolClose.Left := button.Left + button.Width - 20;
           toolClose.Visible := true;
           toolClose.BringToFront;
           button.Top := 43;
         end;
    end;
  if toolDesk.Down then
     begin
       toolDesk.Top := 43;
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
           break;
         end;
    end;
  SortToolButton;
end;

procedure TfrmMMMain.sysCloseClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmMMMain.sysMaximizedClick(Sender: TObject);
begin
  inherited;
  if WindowState = wsMaximized then
     WindowState := wsNormal
  else
     WindowState := wsMaximized;

end;

procedure TfrmMMMain.sysMinimizedClick(Sender: TObject);
begin
  inherited;
  WindowState := wsMinimized;

end;

procedure TfrmMMMain.FormResize(Sender: TObject);
begin
  inherited;
  if WindowState = wsMaximized then
     SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
  RzFormShape1.Enabled := not (WindowState = wsMaximized);
end;

procedure TfrmMMMain.RzTrayIcon1LButtonDown(Sender: TObject);
begin
  inherited;
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
         mmGlobal.ConnectToMsc;
         RzTrayIcon1.Animate := false;
         RzTrayIcon1.IconIndex := 1;
       end;
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
  Form.Show;
  Form.BringToFront;
end;

procedure TfrmMMMain.actfrmSyncAllExecute(Sender: TObject);
begin
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
    SyncFactory.SyncAll;
    Global.LoadBasic;
    CheckEnabled;
    mmGlobal.LoadRight;
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
end;

constructor TfrmMMMain.Create(AOwner: TComponent);
begin
  inherited;
  FMenu := TList.Create;
  FormStyle := fsMDIForm;
  frmMMToolBox := TfrmMMToolBox.Create(self);
  frmXsmIEBrowser := nil; //TfrmMMBrowser.Create(self);
  frmRimIEBrowser := nil; //TfrmMMBrowser.Create(self);
  pageLine.Top := bkg_top.Height  - 1;
  pageLine.Left := toolDesk.Left;
  pageLine.Width := bkg_top.Width - toolDesk.Left + 10;
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

procedure TfrmMMMain.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'营销活动');
end;

procedure TfrmMMMain.toolDeskClick(Sender: TObject);
begin
  inherited;
  frmMMDesk.Locked := true;
  frmMMDesk.BringToFront;
  SortToolButton;
end;

procedure TfrmMMMain.RzBmpButton8Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上订货');

end;

procedure TfrmMMMain.RzBmpButton9Click(Sender: TObject);
begin
  inherited;
  PupupToolBox(Sender,'网上配货');

end;

procedure TfrmMMMain.RzBmpButton10Click(Sender: TObject);
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
  if not CA_MODULE.Locate('MODU_ID',PMMToolBox(Sender)^.mid,[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  if not mmGlobal.Logined then
     begin
       if ShowMsgBox('连接已经断开了，是否重连新商盟服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       if not mmGlobal.xsmLogin then Exit;
     end;

  frmXsmIEBrowser.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
  AddFrom(frmXsmIEBrowser);
  frmXsmIEBrowser.WindowState := wsMaximized;
  frmXsmIEBrowser.BringToFront;
  if not frmXsmIEBrowser.XsmLogin(true) then Exit;
  sl := TStringList.Create;
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
         PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
       end;
  finally
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
  s:string;
  Form:TfrmBasic;
  sl:TStringList;
begin
  inherited;
  if not CaFactory.Audited then Raise Exception.Create('脱网登录不能使用此模块。');
  if not CA_MODULE.Locate('MODU_ID',PMMToolBox(Sender)^.mid,[]) then Raise Exception.Create('没找到对应的模块ID='+inttostr(TrzBmpButton(Sender).Tag));
  s := CA_MODULE.FieldbyName('ACTION_URL').AsString;
  delete(s,1,4);
  delete(s,length(s),1);
  sl := TStringList.Create;
  try
    if (sl.values['xsm']='true') then
       begin
          if not mmGlobal.Logined then
             begin
               if ShowMsgBox('连接已经断开了，是否重连新商盟服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
               if not mmGlobal.xsmLogin then Exit;
               frmRimIEBrowser.rimLogined := false;
             end;
       end;
       
    if not frmRimIEBrowser.rimLogined then
       begin
         if ShowMsgBox('连接已经断开了，是否重连RIM服务器？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
         if not frmRimIEBrowser.RimLogin(true) then Exit;
       end;

    sl.CommaText := s;
    frmRimIEBrowser.Caption := CA_MODULE.FieldbyName('MODU_NAME').AsString;
    AddFrom(frmRimIEBrowser);
    frmRimIEBrowser.WindowState := wsMaximized;
    frmRimIEBrowser.BringToFront;

    frmRimIEBrowser.IEOpen(frmRimIEBrowser.rimUrl+sl.values['url']+'?comId='+frmRimIEBrowser.rimcomId+'&custId='+frmRimIEBrowser.rimcustId);
  except
    sl.free;
    Raise;
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
  UpdateTimer.Enabled := true;
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
  if not CA_MODULE.Locate('MODU_NAME,','零售终端',[]) then Exit;
  lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString;
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
           button.Anchors := [akTop,akRight];
           button.width := 70;
           FMenu.Add(button);
           button.Top := 0;
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
           button.Left := bkg_top.Width - ((button.Width)*l)- 120;
         end;
    end;
end;

procedure TfrmMMMain.DoOpenMenu(Sender: TObject);
begin
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

end.
