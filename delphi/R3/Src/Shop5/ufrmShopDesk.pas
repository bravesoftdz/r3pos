unit ufrmShopDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, ImgList, ExtCtrls, StdCtrls, Buttons, jpeg, RzPanel,
  RzBmpBtn, RzLine, RzLabel, Menus,ShlObj,ComObj,ShellApi,ActiveX;

type
  TfrmShopDesk = class(TfrmDesk)
    RzPanel1: TRzPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Panel1: TPanel;
    Image14: TImage;
    Image1: TImage;
    Image2: TImage;
    lblToolCaption: TRzLabel;
    RzLine54: TRzLine;
    RzBmpButton15: TRzBmpButton;
    RzBmpButton17: TRzBmpButton;
    RzBmpButton18: TRzBmpButton;
    RzBmpButton24: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzLine2: TRzLine;
    Shape1: TShape;
    RzBmpButton3: TRzBmpButton;
    procedure RzBmpButton16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
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

end.
