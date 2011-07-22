unit ufrmR3Desk;

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
  TfrmR3Desk = class(TfrmDesk)
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
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    btnSaleDayReport: TRzBmpButton;
    btnSaleMonthReport: TRzBmpButton;
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
  frmR3Desk: TfrmR3Desk;

implementation
uses ufrmR3Main,uShopGlobal,uDevFactory,uCaFactory,Registry, ufrmMain, uAdvFactory, MultInst, ufrmRimIEBrowser,
  ufrmXsmIEBrowser,ufrmSaleDayReport;
{$R *.dfm}

procedure TfrmR3Desk.RzBmpButton16Click(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmR3Desk.FormCreate(Sender: TObject);
begin
  inherited;
  myBtn := nil;
  Locked := false;
end;

procedure TfrmR3Desk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not Locked then
     DevFactory.OpenCashBox;
end;

procedure TfrmR3Desk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmR3Desk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

function TfrmR3Desk.FindAction(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmR3Main.actList.ActionCount - 1 do
    begin
      if lowercase(frmR3Main.actList.Actions[i].name) = lowercase(id) then
         begin
           result := TAction(frmR3Main.actList.Actions[i]);
           Exit;
         end;
    end;
end;
procedure TfrmR3Desk.Open(url:string);
function FindActionId(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmR3Main.actList.ActionCount - 1 do
    begin
      if frmR3Main.actList.Actions[i].Tag = strtoint(id) then
         begin
           result := TAction(frmR3Main.actList.Actions[i]);
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

procedure TfrmR3Desk.LoadDesk;
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
  iframe := Doc.all.item('mht1',EmptyParam) as DispHTMLIFrame;
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
  if FileExists(ExtractFilePath(ParamStr(0))+'adv\adv1.html') then
     begin
       url := ExtractFilePath(ParamStr(0))+'adv\adv1.html';
       iframe := Doc.all.item('Adv1',EmptyParam) as DispHTMLIFrame;
       if iframe<>nil then iframe.src := url;
     end;
end;

procedure TfrmR3Desk.btnDownOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmDownIndeOrder');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmR3Desk.btnStockOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStockOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmR3Desk.btnSalesOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPosMain');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmR3Desk.btnStorageClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStorageTracking');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmR3Desk.btnfrmSupplierClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSupplier');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmR3Desk.DropMenu(btn: TRzBmpButton);
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
  if btn=mnuBase then
     begin
       AddPopupMenu(FindAction('actfrmGoodsSort'));
       AddPopupMenu(FindAction('actfrmMeaUnits'));
//       AddPopupMenu(FindAction('actfrmDefineStateInfo'));
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
       AddPopupMenu(FindAction('actfrmMonthClose'));
       AddPopupMenu(FindAction('actfrmRckMng'));
       if rc>0 then AddLine;
       AddPopupMenu(FindAction('actfrmMessage'));
       AddPopupMenu(FindAction('actfrmLockScreen'));
     end;
  HostP := btn.ClientToScreen(Point(0,btn.Height));
  PopupMenu.Popup(HostP.X,HostP.Y);
  myBtn := Btn;
end;

procedure TfrmR3Desk.InitMenu(s: string; rzG: TRzGroup);
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

procedure TfrmR3Desk.SetCA_MODULE(const Value: TZQuery);
begin
  FCA_MODULE := Value;
  InitMenu('业务报表',rzG1);
  InitMenu('综合报表',rzG2);
  InitMenu('经营分析',rzG3);
end;

procedure TfrmR3Desk.wm_popup(var Message: TMessage);
begin
  SecBtn := TrzBmpButton(Message.WParam);
  DropMenu(TrzBmpButton(Message.WParam));
end;

procedure TfrmR3Desk.bgReportResize(Sender: TObject);
var
  rh:integer;
begin
  inherited;
  rh := bgReport.ClientHeight div 3;
  report1.Height := rh;
  report2.Height := rh;
  report3.Height := rh;
end;

procedure TfrmR3Desk.SaveDesk;
begin
end;

procedure TfrmR3Desk.FormDestroy(Sender: TObject);
begin
  IEDesktop.Free;
  inherited;
end;

procedure TfrmR3Desk.IEDesktopDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  Wait := false;
end;

procedure TfrmR3Desk.FormActivate(Sender: TObject);
begin
  inherited;
  PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);//  tbDesktopClick(tbDesktop);
end;

procedure TfrmR3Desk.IEDesktopBeforeNavigate2(Sender: TObject;
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

procedure TfrmR3Desk.mnuInClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuIn),0);

end;

procedure TfrmR3Desk.mnuOutClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuOut),0);

end;

procedure TfrmR3Desk.mnuSkClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSk),0);

end;

procedure TfrmR3Desk.mnuBaseClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuBase),0);

end;

procedure TfrmR3Desk.mnuSysClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(mnuSys),0);

end;

procedure TfrmR3Desk.bgFuncClick(Sender: TObject);
begin
  inherited;
  bgFunc.SetFocus;
end;

procedure TfrmR3Desk.Image10Click(Sender: TObject);
begin
  inherited;
  bgFunc.SetFocus;

end;

procedure TfrmR3Desk.btnSaleDayReportClick(Sender: TObject);
var
  Action:TAction;
  Form:TfrmBasic;
begin
  inherited;
  Action := FindAction('actfrmSaleDayReport');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Application.Restore;
  frmR3Desk.SaveToFront;
  Form := frmR3Main.FindChildForm('TfrmSimpleSaleDayReport');
  if not Assigned(Form) then
  begin
    Form := TfrmSaleDayReport.Create(self);
    TfrmSaleDayReport(Form).SingleReportParams; 
    frmR3Main.AddFrom(Form);
  end;
  Form.Name := 'TfrmSimpleSaleDayReport';
  Form.WindowState := wsMaximized;
  Form.BringToFront;
end;

procedure TfrmR3Desk.btnSaleMonthReportClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSaleMonthTotalReport');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

end.
