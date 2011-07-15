unit ufrmShopDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, ImgList, ExtCtrls, StdCtrls, Buttons, jpeg, RzPanel,
  RzBmpBtn, RzLine, RzLabel, Menus,ShlObj,ComObj,ShellApi,ActiveX,
  RzGroupBar, RzTabs;

type
  TfrmShopDesk = class(TfrmDesk)
    RzPanel1: TRzPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ImageList1: TImageList;
    dgdesk: TPanel;
    Image1: TImage;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton7: TRzBmpButton;
    RzBmpButton8: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton9: TRzBmpButton;
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
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure RzBmpButton9Click(Sender: TObject);
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
  sflag:string;
  pic:TGraphic;
begin
  DllHandle := LoadLibrary('Pic32.dll');
  sflag := 's'+GetResString(1)+'_';
  if DllHandle > 0 then
  try
    Image1.Picture.Graphic  := GetJpeg(sflag+'desk_bg');

    RzBmpButton1.Bitmaps.Up := GetBitmap(sflag+'db_btn');
    RzBmpButton1.Bitmaps.Hot := GetBitmap(sflag+'db_btn_hot');
    RzBmpButton2.Bitmaps.Up := GetBitmap(sflag+'c1_btn');
    RzBmpButton2.Bitmaps.Hot := GetBitmap(sflag+'c1_btn_hot');
    RzBmpButton7.Bitmaps.Up := GetBitmap(sflag+'sale_btn');
    RzBmpButton7.Bitmaps.Hot := GetBitmap(sflag+'sale_btn_hot');
    RzBmpButton9.Bitmaps.Up := GetBitmap(sflag+'slr_btn');
    RzBmpButton9.Bitmaps.Hot := GetBitmap(sflag+'slr_btn_hot');
    RzBmpButton3.Bitmaps.Up := GetBitmap(sflag+'c2_btn');
    RzBmpButton3.Bitmaps.Hot := GetBitmap(sflag+'c2_btn_hot');
    RzBmpButton5.Bitmaps.Up := GetBitmap(sflag+'sfd_btn');
    RzBmpButton5.Bitmaps.Hot := GetBitmap(sflag+'sfd_btn_hot');
    RzBmpButton4.Bitmaps.Up := GetBitmap(sflag+'str_btn');
    RzBmpButton4.Bitmaps.Hot := GetBitmap(sflag+'str_btn_hot');
    RzBmpButton6.Bitmaps.Up := GetBitmap(sflag+'stk_btn');
    RzBmpButton6.Bitmaps.Hot := GetBitmap(sflag+'stk_btn_hot');
    RzBmpButton8.Bitmaps.Up := GetBitmap(sflag+'pos_btn');
    RzBmpButton8.Bitmaps.Hot := GetBitmap(sflag+'pos_btn_hot');
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure TfrmShopDesk.RzBmpButton16Click(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmShopDesk.FormCreate(Sender: TObject);
var
  i:integer;
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
  dgDesk.Top := (Height-dgDesk.Height) div 2;
  if dgDesk.Top > 60 then dgDesk.Top := dgDesk.Top -50;
  dgDesk.Left := (Width-dgDesk.Width) div 2;
  if dgDesk.Top > 100 then dgDesk.Top := dgDesk.Top -50;
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
  if not frmShopMain.actfrmStkRetuOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmStkRetuOrderList.OnExecute(nil);

end;

procedure TfrmShopDesk.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmStorageTracking.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmStorageTracking.OnExecute(nil);

end;

procedure TfrmShopDesk.RzGroup3Items0Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'没有找到公告.','友情提示...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmShopDesk.RzBmpButton9Click(Sender: TObject);
begin
  inherited;
  if not frmShopMain.actfrmSalRetuOrderList.Enabled then Raise Exception.Create('您没有操作此模块的权限，请和管理员联系...');
  frmShopMain.actfrmSalRetuOrderList.OnExecute(nil);

end;

end.
