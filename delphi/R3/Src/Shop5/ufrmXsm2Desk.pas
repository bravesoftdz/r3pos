unit ufrmXsm2Desk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, ImgList, ExtCtrls, StdCtrls, Buttons, jpeg, RzPanel,
  RzBmpBtn, RzLine, RzLabel, Menus,ShlObj,ComObj,ShellApi,ActiveX,
  RzGroupBar, RzTabs, OleCtrls, SHDocVw, ActnList, ZDataSet, MSHTML,
  ComCtrls, ToolWin, ufrmBasic;

const
  MSC_POPUP=WM_USER+1;
type
  TfrmXsm2Desk = class(TfrmDesk)
    RzPanel1: TRzPanel;
    ImageList1: TImageList;
    bgPanel: TRzPanel;
    bgReport: TRzPanel;
    report3: TRzPanel;
    RzPanel6: TRzPanel;
    Image1: TImage;
    RzGroup3: TRzGroupBar;
    rzG3: TRzGroup;
    report2: TRzPanel;
    RzPanel7: TRzPanel;
    Image2: TImage;
    RzGroupBar2: TRzGroupBar;
    RzG2: TRzGroup;
    report1: TRzPanel;
    RzPanel9: TRzPanel;
    Image3: TImage;
    RzGroupBar3: TRzGroupBar;
    RzG1: TRzGroup;
    RzPanel2: TRzPanel;
    bgBase: TRzPanel;
    bgFunc: TRzPanel;
    btnDownOrder: TRzBmpButton;
    btnStockOrder: TRzBmpButton;
    btnSalesOrder: TRzBmpButton;
    btnStorage: TRzBmpButton;
    PopupMenu: TPopupMenu;
    IEDesktop: TWebBrowser;
    RzPanel3: TRzPanel;
    Image6: TImage;
    Panel1: TPanel;
    mnuOut: TRzBmpButton;
    mnuSk: TRzBmpButton;
    mnuBase: TRzBmpButton;
    mnuSys: TRzBmpButton;
    mnuIn: TRzBmpButton;
    Image11: TImage;
    btnSaleDayReport: TRzBmpButton;
    btnSaleMonthReport: TRzBmpButton;
    mnuAcct: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure RzBmpButton16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDownOrderClick(Sender: TObject);
    procedure btnStockOrderClick(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure btnStorageClick(Sender: TObject);
    procedure btnfrmSupplierClick(Sender: TObject);
    procedure bgReportResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IEDesktopDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormActivate(Sender: TObject);
    procedure IEDesktopBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure mnuInClick(Sender: TObject);
    procedure mnuOutClick(Sender: TObject);
    procedure mnuSkClick(Sender: TObject);
    procedure mnuBaseClick(Sender: TObject);
    procedure mnuSysClick(Sender: TObject);
    procedure bgFuncClick(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure btnSaleDayReportClick(Sender: TObject);
    procedure btnSaleMonthReportClick(Sender: TObject);
    procedure mnuAcctClick(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
  private
    FHookLocked: boolean;
    FCA_MODULE: TZQuery;
    procedure SetHookLocked(const Value: boolean);
    procedure wm_popup(var Message: TMessage); message MSC_POPUP;
    function FindAction(id: string): TAction;
    { Private declarations }
  protected
    rc:int64;
    Wait:boolean;
    myBtn,SecBtn:TRzBmpButton;
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);override;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);override;
    { Public declarations }

    procedure Open(url:string);
    procedure SetCA_MODULE(const Value: TZQuery);
    { Private declarations }
  public
    { Public declarations }
    procedure LoadDesk;
    procedure SaveDesk;
    procedure InitMenu(s:string;rzG:TRzGroup);
    procedure DropMenu(btn:TRzBmpButton);
    property HookLocked:boolean read FHookLocked write SetHookLocked;
    property CA_MODULE:TZQuery read FCA_MODULE write SetCA_MODULE;
  end;

var
  frmXsm2Desk: TfrmXsm2Desk;

implementation
uses ufrmXsm2Main,uShopGlobal,uDevFactory,uCaFactory,Registry, ufrmMain, uAdvFactory, ufrmRimIEBrowser,
  ufrmXsmIEBrowser,ufrmSaleDayReport, uGlobal;
{$R *.dfm}

procedure TfrmXsm2Desk.RzBmpButton16Click(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmXsm2Desk.FormCreate(Sender: TObject);
begin
  inherited;
  myBtn := nil;
  Locked := false;
end;

procedure TfrmXsm2Desk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not HookLocked then
     DevFactory.OpenCashBox;
end;

procedure TfrmXsm2Desk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmXsm2Desk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

function TfrmXsm2Desk.FindAction(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmXsm2Main.actList.ActionCount - 1 do
    begin
      if lowercase(frmXsm2Main.actList.Actions[i].name) = lowercase(id) then
         begin
           result := TAction(frmXsm2Main.actList.Actions[i]);
           Exit;
         end;
    end;
end;
procedure TfrmXsm2Desk.Open(url:string);
function FindActionId(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmXsm2Main.actList.ActionCount - 1 do
    begin
      if frmXsm2Main.actList.Actions[i].Tag = strtoint(id) then
         begin
           result := TAction(frmXsm2Main.actList.Actions[i]);
           Exit;
         end;
    end;
end;
var
  act:TAction;
begin
  act := FindActionId(copy(url,pos('#=',url)+2,255));
  if act=nil then Raise Exception.Create('没找到对应的模块,id='+url);
  act.OnExecute(act); 
end;

procedure TfrmXsm2Desk.LoadDesk;
var url:string;
    Doc:IHTMLDocument2;
    Ec:IHTMLElementCollection;
    iframe:DispHTMLIFrame;
    _Start:int64;
begin
  Wait := true;
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
  
{  iframe := Doc.all.item('mht1',EmptyParam) as DispHTMLIFrame;
  if iframe<>nil then
     begin
       if CaFactory.Audited and frmRimIEBrowser.Logined then
       begin
         iframe.src := rim_url+'indexActivityInfo.action?comId='+rim_comid+'&custId='+rim_custid;
         AdvFactory.WBSaveAsMht(rim_url+'indexActivityInfo.action?comId='+rim_comid+'&custId='+rim_custid,'mht1');
       end else
         iframe.src := ExtractFilePath(ParamStr(0))+'adv\mht1.mht';
       if CaFactory.Audited and frmRimIEBrowser.Logined then
          AdvFactory.GetAllFile(IEDesktop)
       else
          AdvFactory.LoadAllFile(IEDesktop);
     end;
}
  if FileExists(ExtractFilePath(ParamStr(0))+'adv\adv1.html') then
     begin
       url := ExtractFilePath(ParamStr(0))+'adv\adv1.html';
       iframe := Doc.all.item('Adv1',EmptyParam) as DispHTMLIFrame;
       if iframe<>nil then iframe.src := url;
     end;
end;

procedure TfrmXsm2Desk.btnDownOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmDownIndeOrder');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.btnStockOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStockOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.btnSalesOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPosMain');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.btnStorageClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStorageTracking');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.btnfrmSupplierClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSupplier');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.DropMenu(btn: TRzBmpButton);
procedure AddLine;
var
  Item:TMenuItem;
begin
  if rc=0 then Exit;
  Item := TMenuItem.Create(PopupMenu);
  Item.Caption := '-';
  PopupMenu.Items.Add(Item);
  rc := 0;
end;
procedure AddPopupMenu(Action:TAction);
var
  Item:TMenuItem;
begin
  if Action=nil then Exit;
  if not Action.Enabled then Exit;
  Item := TMenuItem.Create(PopupMenu);
  Item.Action := Action;
  PopupMenu.Items.Add(Item);
  inc(rc);
end;
var HostP:TPoint;
begin
  rc := 0;
  PopupMenu.Items.Clear;
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
  PopupMenu.Popup(HostP.X,HostP.Y);
  myBtn := Btn;
end;

procedure TfrmXsm2Desk.InitMenu(s: string; rzG: TRzGroup);
var
  lvid:string;
  Action:TAction;
  item:TRzGroupItem;
begin
  rzG.Items.Clear;
  if not CA_MODULE.Locate('MODU_NAME',s,[]) then Exit;
  lvid := CA_MODULE.FieldbyName('LEVEL_ID').AsString;
  CA_MODULE.First;
  while not CA_MODULE.Eof do
    begin
      if (copy(CA_MODULE.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid) and (length(CA_MODULE.FieldbyName('LEVEL_ID').AsString)=length(lvid)+3) then
         begin
           Action := FindAction(CA_MODULE.FieldbyName('ACTION_NAME').AsString);
           if Action<>nil then
              begin
                item := rzG.Items.Add;
                Item.Action := Action;
              end;
         end;
      CA_MODULE.Next;
    end;
end;

procedure TfrmXsm2Desk.SetCA_MODULE(const Value: TZQuery);
begin
  FCA_MODULE := Value;
  InitMenu('业务报表',rzG1);
  InitMenu('综合报表',rzG2);
  InitMenu('经营分析',rzG3);
end;

procedure TfrmXsm2Desk.wm_popup(var Message: TMessage);
begin
  SecBtn := TrzBmpButton(Message.WParam);
  DropMenu(TrzBmpButton(Message.WParam));
end;

procedure TfrmXsm2Desk.bgReportResize(Sender: TObject);
var
  rh:integer;
begin
  inherited;
  rh := bgReport.ClientHeight div 3;
  report1.Height := rh;
  report2.Height := rh;
  report3.Height := rh;
end;

procedure TfrmXsm2Desk.SaveDesk;
begin
end;

procedure TfrmXsm2Desk.FormDestroy(Sender: TObject);
begin
  IEDesktop.Free;
  inherited;
end;

procedure TfrmXsm2Desk.IEDesktopDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  Wait := false;
end;

procedure TfrmXsm2Desk.FormActivate(Sender: TObject);
begin
  inherited;
  //PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);//  tbDesktopClick(tbDesktop);
end;

procedure TfrmXsm2Desk.IEDesktopBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var w:integer;  
begin
  inherited;
  w := pos('xsm=',url);
  if (w>0) and Assigned(frmRimIEBrowser) then
     begin
       Cancel := true;
       frmRimIEBrowser.OpenXsm(copy(url,w+4,length(url)));
       Exit;
     end;
  w := pos('rim=',url);
  if (w>0) and Assigned(frmRimIEBrowser) then
     begin
       Cancel := true;
       frmRimIEBrowser.OpenUrl(copy(url,w+4,length(url)),0,true);
       Exit;
     end;
end;

procedure TfrmXsm2Desk.mnuInClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuIn),0);

end;

procedure TfrmXsm2Desk.mnuOutClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuOut),0);

end;

procedure TfrmXsm2Desk.mnuSkClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSk),0);

end;

procedure TfrmXsm2Desk.mnuBaseClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuBase),0);

end;

procedure TfrmXsm2Desk.mnuSysClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSys),0);

end;

procedure TfrmXsm2Desk.bgFuncClick(Sender: TObject);
begin
  inherited;
  bgFunc.SetFocus;
end;

procedure TfrmXsm2Desk.Image10Click(Sender: TObject);
begin
  inherited;
  bgFunc.SetFocus;

end;

procedure TfrmXsm2Desk.btnSaleDayReportClick(Sender: TObject);
var
  Action:TAction;
  Form:TfrmBasic;
begin
  inherited;
  Action := FindAction('actfrmSaleDayReport');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Application.Restore;
  frmXsm2Desk.SaveToFront;
  Form := frmXsm2Main.FindChildForm('TfrmSimpleSaleDayReport');
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    TfrmSaleDayReport(Form).SingleReportParams;
    frmXsm2Main.AddFrom(Form);
  end;
  Form.Name := 'TfrmSimpleSaleDayReport';
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmXsm2Desk.btnSaleMonthReportClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSaleMonthTotalReport');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmXsm2Desk.mnuAcctClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuAcct),0);

end;

procedure TfrmXsm2Desk.RzBmpButton1Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmCustomer');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

end.
