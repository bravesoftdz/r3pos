unit ufrmShopDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, ImgList, ExtCtrls, StdCtrls, Buttons, jpeg, RzPanel,
  RzBmpBtn, RzLine, RzLabel, Menus,ShlObj,ComObj,ShellApi,ActiveX,
  RzGroupBar;

type
  TfrmShopDesk = class(TfrmDesk)
    RzPanel1: TRzPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    rzTaskBar: TRzGroupBar;
    RzGroup1: TRzGroup;
    ImageList1: TImageList;
    RzGroup2: TRzGroup;
    dgdesk: TPanel;
    Image1: TImage;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton7: TRzBmpButton;
    RzBmpButton8: TRzBmpButton;
    procedure RzBmpButton16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RzBmpButton8Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
  private
    FHookLocked: boolean;
    procedure SetHookLocked(const Value: boolean);
    { Private declarations }
  protected
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);override;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);override;
  public
    { Public declarations }
    procedure LoadRes;
    property HookLocked:boolean read FHookLocked write SetHookLocked;
  end;

var
  frmShopDesk: TfrmShopDesk;

implementation
uses ufrmShopMain,udmIcon,uShopGlobal,uDevFactory,Registry;
{$R *.dfm}

procedure TfrmShopDesk.LoadRes;
var
  i:integer;
  id:integer;
  sDllName:string;
  bmp:TBitmap;
begin
  sDllName := 'Icon64.dll';
  if FileExists(ExtractFilePath(ParamStr(0))+sDllName) then
  for i:= 0 to ComponentCount -1 do
    begin
      if Components[i] is TRzBmpButton then
         begin
           TRzBmpButton(Components[i]).PopupMenu := PopupMenu1;
           if TRzBmpButton(Components[i]).Action=nil then continue;
           id := TRzBmpButton(Components[i]).Action.Tag;
           bmp := TBitmap.Create;
           dmIcon.HsResOpr.GetDllBmpRes(bmp,'u'+inttostr(id),sDllName);
           TRzBmpButton(Components[i]).Bitmaps.Up := bmp;

           bmp := TBitmap.Create;
           dmIcon.HsResOpr.GetDllBmpRes(bmp,'d'+inttostr(id),sDllName);
           TRzBmpButton(Components[i]).Bitmaps.Disabled := bmp;
         end;
    end;
end;

procedure TfrmShopDesk.RzBmpButton16Click(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmShopDesk.FormCreate(Sender: TObject);
begin
  inherited;
  LoadRes;
  Locked := false;
end;

procedure TfrmShopDesk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not Locked then
     DevFactory.OpenCashBox;
end;

procedure TfrmShopDesk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmShopDesk.N1Click(Sender: TObject);
var
  i:integer;
  Reg: TRegIniFile;
  WFileName: WideString;
  AnObj: IUnKnown;
  Shlink: IShellLink;
  PFile: IPersistFile;
  IconIndex:integer;
begin
  for i:= 0 to ComponentCount -1 do
    begin
      if Components[i] is TRzBmpButton then
         begin
           if (TRzBmpButton(Components[i]).Focused) and (TRzBmpButton(Components[i]).Action<>nil) then
              begin
                AnObj := CreateComObject(CLSID_ShellLink);
                shLink := AnObj as IShellLink;
                PFile := AnObj as IPersistFile;
                shLink.SetWorkingDirectory('');
                shLink.SetPath(pchar(ParamStr(0)));
                shLink.SetArguments(pchar('id='+inttostr(TRzBmpButton(Components[i]).Action.Tag)));
                IconIndex := 0;
                shLink.SetIconLocation(Pchar(ParamStr(0)),IconIndex);
                shLink.SetDescription(Pchar('"亿佳软件"'+TRzBmpButton(Components[i]).Caption));
                Reg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
                try
                  WFileName := Reg.ReadString('Shell Folders', 'Desktop', '') + '\"亿佳软件"'+TRzBmpButton(Components[i]).Caption+'.lnk';
                  PFile.Save(PWChar(WFileName), True);
                finally
                  Reg.Free;
                end;
              end;
              //  MessageBox(Handle,Pchar('暂不支持此功能,模块名：'+TRzBmpButton(Components[i]).Caption),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
         end;
    end;
end;

procedure TfrmShopDesk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

procedure TfrmShopDesk.FormResize(Sender: TObject);
begin
  inherited;
  dgDesk.Top := (Height-dgDesk.Height) div 2-50;
  dgDesk.Left := (Width-dgDesk.Width-rzTaskBar.Width) div 2-50;
end;

procedure TfrmShopDesk.RzBmpButton8Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmPosMain.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmPosMain.OnExecute(nil);
end;

procedure TfrmShopDesk.RzBmpButton7Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmSalesOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmSalesOrderList.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton6Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmStockOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmStockOrderList.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmDbOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmDbOrderList.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmChangeOrderList2.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmChangeOrderList2.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmChangeOrderList1.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmChangeOrderList1.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmCheckOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmCheckOrderList.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmStorageTracking.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmStorageTracking.OnExecute(nil);

end;

end.
