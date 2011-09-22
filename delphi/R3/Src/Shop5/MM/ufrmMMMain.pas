unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, uMMUtil, uMMServer ,ShellApi,
  ZBase, RzTray, StdCtrls, Mask, RzEdit, RzBmpBtn, RzLabel, jpeg, RzPanel,
  ImgList, RzBckgnd, RzForms, ToolWin, Buttons, RzButton;

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
    RzFormShape1: TRzFormShape;
    mnuSys: TRzBmpButton;
    mnuAcct: TRzBmpButton;
    mnuSk: TRzBmpButton;
    mnuOut: TRzBmpButton;
    mnuIn: TRzBmpButton;
    mnuBase: TRzBmpButton;
    A1: TMenuItem;
    C1: TMenuItem;
    C2: TMenuItem;
    ADSFADSF1: TMenuItem;
    DAFADSFDSA1: TMenuItem;
    ADSFDSAFDSA1: TMenuItem;
    ASDFASDFADS1: TMenuItem;
    ADSFADSFDS1: TMenuItem;
    sysMinimized: TRzBmpButton;
    sysMaximized: TRzBmpButton;
    sysClose: TRzBmpButton;
    bkg_02: TImage;
    bkg: TRzPanel;
    toolMenu: TPopupMenu;
    toolDesk: TRzBmpButton;
    mnuReport: TRzBmpButton;
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
    actfrmOpenDesk: TAction;
    actfrmSyncAll: TAction;
    actfrmGoodsMonth: TAction;
    actfrmInitGuide: TAction;
    RzPanel1: TRzPanel;
    RzBmpButton7: TRzBmpButton;
    toolButton: TRzBmpButton;
    RzBackground1: TRzBackground;
    RzPanel7: TRzPanel;
    RzPanel3: TRzPanel;
    RzBmpButton2: TRzBmpButton;
    softname: TRzLabel;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miCloseClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure sysCloseClick(Sender: TObject);
    procedure sysMaximizedClick(Sender: TObject);
    procedure sysMinimizedClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RzTrayIcon1LButtonDown(Sender: TObject);
    procedure RzTrayIcon1LButtonDblClick(Sender: TObject);
    procedure mnuInClick(Sender: TObject);
    procedure mnuOutClick(Sender: TObject);
    procedure mnuSkClick(Sender: TObject);
    procedure mnuAcctClick(Sender: TObject);
    procedure mnuBaseClick(Sender: TObject);
    procedure mnuSysClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  private
    { Private declarations }
    FList:TList; {导航菜单}
    rc:int64;

    procedure wm_Login(var Message: TMessage); message MM_LOGIN;
    procedure wm_Sign(var Message: TMessage); message MM_SIGN;
    procedure wm_SessionFail(var Message: TMessage); message MM_SESSION_FAIL;

    //导航工具栏
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    function SortToolButton:boolean;
    procedure AddFrom(form:TForm);
    procedure RemoveFrom(form:TForm);
    //菜单管理
    procedure wm_popup(var Message: TMessage); message MSC_POPUP;
    procedure DropMenu(btn: TRzBmpButton);
  public
    { Public declarations }
    procedure ConnectToSQLite;
    function CreateMMLogin: TftParamList;
    procedure Init;
    function Login: boolean;
    procedure OpenMc(pid: string; mid:integer=0);
    procedure ShowMMList;
    procedure ShowMsgDialog;
    procedure HideMMList;
  end;

var
  frmMMMain: TfrmMMMain;

implementation
uses
  ufrmMMLogin, ufrmMMList, ummFactory,
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
  uLoginFactory,ufrmGoodsMonth,uSyncThread,uCommand, ummGlobal;

{$R *.dfm}

function TfrmMMMain.Login: boolean;
begin
  with TfrmMMLogin.Create(self) do
    begin
      try
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmMMMain.DropMenu(btn: TRzBmpButton);
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
var HostP:TPoint;
begin
  rc := 0;
  toolMenu.Items.Clear;
  if btn=mnuIn then
     begin
       AddPopupMenu(FindAction('actfrmDownIndeOrder'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmStkIndentOrderList'));
       AddPopupMenu(FindAction('actfrmStockOrderList'));
       AddPopupMenu(FindAction('actfrmStkRetuOrderList'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmPayOrderList'));
     end;
  if btn=mnuOut then
     begin
       AddPopupMenu(FindAction('actfrmPriceOrderList'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmSalIndentOrderList'));
       AddPopupMenu(FindAction('actfrmSalesOrderList'));
       AddPopupMenu(FindAction('actfrmSalRetuOrderList'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmRecvOrderList'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmPosMain'));
       AddPopupMenu(FindAction('actfrmCloseForDay'));
       AddPopupMenu(FindAction('actfrmRecvForDay'));
     end;
  if btn=mnuSk then
     begin
       AddPopupMenu(FindAction('actfrmStorageTracking'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmCheckOrderList'));
       AddPopupMenu(FindAction('actfrmChangeOrderList1'));
       AddPopupMenu(FindAction('actfrmChangeOrderList2'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmDbOrderList'));
     end;
  if btn=mnuAcct then
     begin
       AddPopupMenu(FindAction('actfrmAccount'));
       AddPopupMenu(FindAction('actfrmCodeInfo3'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmPayOrderList'));
       AddPopupMenu(FindAction('actfrmRecvOrderList'));
       AddPopupMenu(FindAction('actfrmRecvForDay'));
       AddPopupMenu(FindAction('actfrmTransOrderList'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmMonthClose'));
       AddPopupMenu(FindAction('actfrmRckMng'));
       AddPopupMenu(FindAction('actfrmGoodsMonth'));
     end;
  if btn=mnuBase then
     begin
       AddPopupMenu(FindAction('actfrmGoodsSort'));
       AddPopupMenu(FindAction('actfrmMeaUnits'));
       AddPopupMenu(FindAction('actfrmGoodsInfoList'));
       AddPopupMenu(FindAction('actfrmRelation'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmSupplier'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmPriceGradeInfo'));
       AddPopupMenu(FindAction('actfrmClient'));
       AddPopupMenu(FindAction('actfrmCustomer'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmShopInfoList'));
       AddPopupMenu(FindAction('actfrmDeptInfoList'));
       AddPopupMenu(FindAction('actfrmDutyInfoList'));
       AddPopupMenu(FindAction('actfrmRoleInfoList'));
       AddPopupMenu(FindAction('actfrmUsers'));
     end;
  if btn=mnuSys then
     begin
       AddPopupMenu(FindAction('actfrmSysDefine'));
       AddPopupMenu(FindAction('actfrmDevFactory'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmMessage'));
       AddPopupMenu(FindAction('actfrmLockScreen'));
       if Global.UserId='admin' then 
          AddPopupMenu(FindAction('actfrmInitGuide'));
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

  sysClose.Left := bkg_top.Width - sysClose.Width-0 ;
  if biMaximize in BorderIcons then
     begin
       sysMaximized.Left := sysClose.Left - sysMaximized.Width -1 ;
       sysMinimized.Left := sysMaximized.Left - sysMinimized.Width -1 ;
     end
  else
     begin
       sysMaximized.Visible := false;
       sysMinimized.Left := sysClose.Left - sysMinimized.Width -1 ;
     end;
  sysMinimized.Visible := (biMinimize in BorderIcons);
  FList := TList.Create;
  frmLogo := TfrmLogo.create(self);
  ConnectToSQLite;

end;

procedure TfrmMMMain.ConnectToSQLite;
begin
  Global.MoveToLocal;
  Global.Connect;
end;
procedure TfrmMMMain.wm_Login(var Message: TMessage);
begin
  if Login then
     begin
        Init;
     end
  else
     Application.Terminate;
end;
procedure TfrmMMMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := (MessageBox(Handle,'是否退出盟盟？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);

end;

procedure TfrmMMMain.Init;
begin
  frmLogo.Show;
  try
   try
     frmLogo.ShowTitle := '读取我的好友信息';
     if mmGlobal.Logined then mmGlobal.getAllfriends;
     frmMMList.LoadFriends;
   except
     on E:Exception do
        MessageBox(Handle,Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;
   
   try
     frmLogo.ShowTitle := '连接聊天服务器';
     if mmGlobal.Logined then
        begin
          mmGlobal.ConnectToMsc;
          RzTrayIcon1.IconIndex := 1;
        end;
   except
     on E:Exception do
        MessageBox(Handle,Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;


   if CaFactory.Audited and not mmGlobal.ONLVersion then
      begin
        if not Global.RemoteFactory.Connected and not mmGlobal.NetVersion then
           begin
             frmLogo.ShowTitle := '正在连接远程服务...';
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
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
           begin
             if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
           end;
      end
   else
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if CaFactory.Audited and Global.RemoteFactory.Connected then //管理什么版本，有连接到服务器时，必须先同步数据
           begin
             if mmGlobal.ONLVersion then //在线版只需同步注册数据
                begin
                  if Global.RemoteFactory.ConnString<>Global.LocalFactory.ConnString then //调试模式时，不同步
                  begin
                    frmLogo.ShowTitle := '同步基本信息...';
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
     end;

  finally
    ShowMMList;
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

procedure TfrmMMMain.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  Init;
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
     end;
  button.Caption := form.Caption;
  button.Tag := Integer(Pointer(form));
  button.OnClick := DoActiveForm;
  button.Visible := true;
  button.Parent := bkg_top;
  FList.Add(button);
  SortToolButton;
  button.Down := true;
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

procedure TfrmMMMain.DoActiveChange(Sender: TObject);
begin
  TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
  TForm(TrzBmpButton(Sender).tag).BringToFront;
  TrzBmpButton(Sender).Down := true;
end;

procedure TfrmMMMain.DoActiveForm(Sender: TObject);
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
           break;
         end;
      if TrzBmpButton(FList[i]).tag=integer(Pointer(Sender)) then
         begin
           TrzBmpButton(FList[i]).Caption :=  TForm(Sender).Caption;
           TrzBmpButton(FList[i]).Down := true;
           break;
         end;
    end;
end;

procedure TfrmMMMain.DoFreeForm(Sender: TObject);
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
  DropMenu(TrzBmpButton(Message.WParam));
end;

procedure TfrmMMMain.mnuInClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuIn),0);

end;

procedure TfrmMMMain.mnuOutClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuOut),0);

end;

procedure TfrmMMMain.mnuSkClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSk),0);

end;

procedure TfrmMMMain.mnuAcctClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuAcct),0);

end;

procedure TfrmMMMain.mnuBaseClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuBase),0);

end;

procedure TfrmMMMain.mnuSysClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSys),0);

end;

procedure TfrmMMMain.FormShow(Sender: TObject);
begin
  if WindowState = wsMaximized then
     SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
  inherited;

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
  if TfrmCloseForDay.ShowClDy(self)=2 then ;//MessageBox(Handle,'当天没有营业数据，不需要结账','友情提示...',MB_OK+MB_ICONINFORMATION);

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
    Login(true);
  finally
    frmMMDesk.HookLocked := false;
  end;

end;

end.
