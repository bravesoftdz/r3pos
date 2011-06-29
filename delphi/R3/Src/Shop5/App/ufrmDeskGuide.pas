unit ufrmDeskGuide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeMDForm, ActnList, Menus, ExtCtrls, RzPanel, jpeg,
  RzGroupBar, ZDataSet, RzBmpBtn;
const
  MSC_POPUP=WM_USER+1;
type
  TfrmDeskGuide = class(TframeMDForm)
    bgReport: TRzPanel;
    RzPanel2: TRzPanel;
    bgBase: TRzPanel;
    bgFunc: TRzPanel;
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
    page_01: TRzBmpButton;
    btnStockOrder: TRzBmpButton;
    btnSalesOrder: TRzBmpButton;
    Image4: TImage;
    btnReckOning: TRzBmpButton;
    btnRecvPost: TRzBmpButton;
    btnStorage: TRzBmpButton;
    btnfrmSupplier: TRzBmpButton;
    btnBaseInfo: TRzBmpButton;
    btnSysDefine: TRzBmpButton;
    RzBmpButton12: TRzBmpButton;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    btnGoodsInfo: TRzBmpButton;
    btnfrmCustomer: TRzBmpButton;
    Timer1: TTimer;
    PopupMenu: TPopupMenu;
    procedure bgReportResize(Sender: TObject);
    procedure page_01Click(Sender: TObject);
    procedure btnStockOrderClick(Sender: TObject);
    procedure RzBmpButton12Click(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure btnStorageClick(Sender: TObject);
    procedure btnReckOningClick(Sender: TObject);
    procedure btnRecvPostClick(Sender: TObject);
    procedure btnGoodsInfoClick(Sender: TObject);
    procedure btnfrmSupplierClick(Sender: TObject);
    procedure btnfrmCustomerClick(Sender: TObject);
    procedure btnSysDefineClick(Sender: TObject);
    procedure btnRecvPostMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalesOrderMouseEnter(Sender: TObject);
    procedure btnStockOrderMouseEnter(Sender: TObject);
    procedure btnStorageMouseEnter(Sender: TObject);
    procedure btnReckOningMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGoodsInfoMouseEnter(Sender: TObject);
    procedure btnfrmSupplierMouseEnter(Sender: TObject);
    procedure btnfrmCustomerMouseEnter(Sender: TObject);
    procedure btnBaseInfoMouseEnter(Sender: TObject);
    procedure btnSysDefineMouseEnter(Sender: TObject);
  private
    FCA_MODULE: TZQuery;
    rc:int64;
    myBtn,SecBtn:TRzBmpButton;
    procedure SetCA_MODULE(const Value: TZQuery);
    { Private declarations }
    procedure wm_popup(var Message: TMessage); message MSC_POPUP;
  public
    { Public declarations }
    procedure InitMenu(s:string;rzG:TRzGroup);
    procedure DropMenu(btn:TRzBmpButton);
    property CA_MODULE:TZQuery read FCA_MODULE write SetCA_MODULE;
  end;

implementation
uses ufrmMain;
{$R *.dfm}
function FindAction(cName:string):TAction;
var i:integer;
begin
  result := nil;
  for i:=0 to frmMain.actList.ActionCount-1 do
    begin
      if (lowercase(frmMain.actList.Actions[i].Name)=lowercase(cName)) and TAction(frmMain.actList.Actions[i]).Enabled then
         begin
           result := TAction(frmMain.actList.Actions[i]);
           break;
         end;
    end;
end;
procedure TfrmDeskGuide.bgReportResize(Sender: TObject);
var
  rh:integer;
begin
  inherited;
  rh := bgReport.ClientHeight div 3;
  report1.Height := rh;
  report2.Height := rh;
  report3.Height := rh;
  bgBase.Height :=  rh ;
end;

procedure TfrmDeskGuide.InitMenu(s:string;rzG:TRzGroup);
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

procedure TfrmDeskGuide.SetCA_MODULE(const Value: TZQuery);
begin
  FCA_MODULE := Value;
  InitMenu('业务报表',rzG1);
  InitMenu('综合报表',rzG2);
  InitMenu('经营分析',rzG3);
end;

procedure TfrmDeskGuide.DropMenu(btn:TRzBmpButton);
procedure AddPopupMenu(Action:TAction);
var
  Item:TMenuItem;
begin
  if Action=nil then Exit;
  if not Action.Enabled then Exit;
  Item := TMenuItem.Create(PopupMenu);
  Item.Action := Action;
  PopupMenu.Items.Add(Item);
end;
var HostP:TPoint;
begin
  Timer1.Enabled := true;
  rc := 0;
//  if myBtn<>nil then Exit;
  PopupMenu.Items.Clear;
  if btn=btnStockOrder then
     begin
       AddPopupMenu(FindAction('actfrmStkIndentOrderList'));
       AddPopupMenu(FindAction('actfrmStockOrderList'));
       AddPopupMenu(FindAction('actfrmStkRetuOrderList'));
       AddPopupMenu(FindAction('actfrmPayOrderList'));
     end;
  if btn=btnSalesOrder then
     begin
       AddPopupMenu(FindAction('actfrmPriceOrderList'));
       AddPopupMenu(FindAction('actfrmPosMain'));
       AddPopupMenu(FindAction('actfrmSalIndentOrderList'));
       AddPopupMenu(FindAction('actfrmSalesOrderList'));
       AddPopupMenu(FindAction('actfrmSalRetuOrderList'));
       AddPopupMenu(FindAction('actfrmRecvOrderList'));
     end;
  if btn=btnStorage then
     begin
       AddPopupMenu(FindAction('actfrmStorageTracking'));
       AddPopupMenu(FindAction('actfrmCheckOrderList'));
       AddPopupMenu(FindAction('actfrmChangeOrderList1'));
       AddPopupMenu(FindAction('actfrmChangeOrderList2'));
       AddPopupMenu(FindAction('actfrmDbOrderList'));
     end;
  if btn=btnReckOning then
     begin
       AddPopupMenu(FindAction('actfrmCloseForDay'));
       AddPopupMenu(FindAction('actfrmMonthClose'));
       AddPopupMenu(FindAction('actfrmRckMng'));
     end;
  if btn=btnGoodsInfo then
     begin
       AddPopupMenu(FindAction('actfrmGoodsSort'));
       AddPopupMenu(FindAction('actfrmMeaUnits'));
       AddPopupMenu(FindAction('actfrmDefineStateInfo'));
       AddPopupMenu(FindAction('actfrmGoodsInfoList'));
       AddPopupMenu(FindAction('actfrmRelation'));
     end;
  if btn=btnfrmCustomer then
     begin
       AddPopupMenu(FindAction('actfrmPriceGradeInfo'));
       AddPopupMenu(FindAction('actfrmClient'));
       AddPopupMenu(FindAction('actfrmCustomer'));
     end;
  if btn=btnBaseInfo then
     begin
       AddPopupMenu(FindAction('actfrmShopInfoList'));
       AddPopupMenu(FindAction('actfrmDeptInfoList'));
       AddPopupMenu(FindAction('actfrmDutyInfoList'));
       AddPopupMenu(FindAction('actfrmRoleInfoList'));
       AddPopupMenu(FindAction('actfrmUsers'));
     end;
  if btn=btnSysDefine then
     begin
       AddPopupMenu(FindAction('actfrmSysDefine'));
       AddPopupMenu(FindAction('actfrmDevFactory'));
       AddPopupMenu(FindAction('actfrmIntfSetup'));
       AddPopupMenu(FindAction('actfrmMessage'));
     end;
  HostP := btn.ClientToScreen(Point(0,btn.Height));
  PopupMenu.Popup(HostP.X,HostP.Y);
  myBtn := Btn;
end;

procedure TfrmDeskGuide.page_01Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmDownIndeOrder');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnStockOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStockOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.RzBmpButton12Click(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPriceOrderList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnSalesOrderClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmPosMain');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');  
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnStorageClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmStorageTracking');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnReckOningClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmCloseForDay');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnRecvPostClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmRecvForDay');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnGoodsInfoClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmGoodsInfoList');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnfrmSupplierClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSupplier');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnfrmCustomerClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmCustomer');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.btnSysDefineClick(Sender: TObject);
var
  Action:TAction;
begin
  inherited;
  Action := FindAction('actfrmSysDefine');
  if Action=nil then Raise Exception.Create('你没有操作此模块的权限...');
  if not Action.Enabled then Raise Exception.Create('你没有操作此模块的权限...');
  Action.OnExecute(Action);
end;

procedure TfrmDeskGuide.wm_popup(var Message: TMessage);
begin
  SecBtn := TrzBmpButton(Message.WParam);
  DropMenu(TrzBmpButton(Message.WParam));
end;

procedure TfrmDeskGuide.btnRecvPostMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnRecvPost),0);

end;

procedure TfrmDeskGuide.Timer1Timer(Sender: TObject);
begin
  inherited;
  if (rc>30) then
     begin
       Timer1.Enabled := false;
       PostMessage(PopupMenu.WindowHandle,WM_KEYDOWN,VK_ESCAPE,0);
       //if (SecBtn<>myBtn) and (SecBtn<>nil) then
       //begin
       //  myBtn := nil;
       //  DropMenu(SecBtn)
       //end else
       //begin
       //  myBtn := nil;
       //  SecBtn := nil;
       //end;
       Exit;
     end;
  inc(rc);
end;

procedure TfrmDeskGuide.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

procedure TfrmDeskGuide.btnSalesOrderMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnSalesOrder),0);

end;

procedure TfrmDeskGuide.btnStockOrderMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnStockOrder),0);

end;

procedure TfrmDeskGuide.btnStorageMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnStorage),0);

end;

procedure TfrmDeskGuide.btnReckOningMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnReckOning),0);

end;

procedure TfrmDeskGuide.FormCreate(Sender: TObject);
begin
  inherited;
  myBtn := nil;
end;

procedure TfrmDeskGuide.btnGoodsInfoMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnGoodsInfo),0);

end;

procedure TfrmDeskGuide.btnfrmSupplierMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnfrmSupplier),0);

end;

procedure TfrmDeskGuide.btnfrmCustomerMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnfrmCustomer),0);

end;

procedure TfrmDeskGuide.btnBaseInfoMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnBaseInfo),0);

end;

procedure TfrmDeskGuide.btnSysDefineMouseEnter(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,MSC_POPUP,integer(btnSysDefine),0);

end;

end.
