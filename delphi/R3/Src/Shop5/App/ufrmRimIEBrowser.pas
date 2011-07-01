unit ufrmRimIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, RzTabs, OleCtrls,
  SHDocVw, ExtCtrls, RzPanel,ZBase;

type
  TfrmRimIEBrowser = class(TfrmIEWebForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IEBrowserDownloadComplete(Sender: TObject);
  private
    FCurUrl: string;
    SaveHandle:integer;
    FLogined: boolean;
    procedure SetCurUrl(const Value: string);
    procedure SetLogined(const Value: boolean);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure ReadParam;
    procedure DoLogin;
    function EncodeChk:string;

    function OpenUrl(url:string;hHandle:integer):boolean;
    property CurUrl:string read FCurUrl write SetCurUrl;
    property Logined:boolean read FLogined write SetLogined;
  end;
var
  frmRimIEBrowser:TfrmRimIEBrowser;
implementation
uses IniFiles,ufrmLogo,uShopGlobal,uCaFactory,EncDec,uAdvFactory, uGlobal;
{$R *.dfm}

{ TfrmRimIEBrowser }

function TfrmRimIEBrowser.EncodeChk: string;
begin
  result := 'comId='+Rim_ComId+'&custId='+Rim_CustId;
end;

function TfrmRimIEBrowser.OpenUrl(url: string;hHandle:integer):boolean;
var
  p:string;
  e:string;
begin
  SaveHandle := PageHandle;
  try
    PageHandle := hHandle;
    WindowState := wsMaximized;
    BringToFront;
    frmLogo.Show;
    frmLogo.ShowTitle := '正在打开网页...';
    ReadParam;
    if pos('?',url)=0 then p := '?' else p := '&';
    e := EncStr(url,ENC_KEY);
    result := inherited Open(Rim_Url+url+p+EncodeChk);
  finally
    if not result then PageHandle := SaveHandle;
    frmLogo.Close;
  end;
end;

procedure TfrmRimIEBrowser.ReadParam;
var
  F:TIniFile;
  List:TStringList;
begin
  if Rim_Url<>'' then Exit;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    Rim_Url := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if Rim_Url='' then Rim_Url := 'http://220.173.61.110:9080/rimweb/'
       else
       begin
         List.CommaText := Rim_Url;
         Rim_Url := List.Values['rim'];
         if Rim_Url<>'' then
           begin
             if Rim_Url[Length(Rim_Url)]<>'/' then Rim_Url := Rim_Url+'/';
           end;
       end;
  finally
    List.free;
    F.Free;
  end;
end;

procedure TfrmRimIEBrowser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

constructor TfrmRimIEBrowser.Create(AOwner: TComponent);
begin
  inherited;
  FormStyle := fsMDIChild;
  frmRimIEBrowser := self;
  Logined := false;
  left := -9000;
end;

destructor TfrmRimIEBrowser.Destroy;
begin

  inherited;
  frmRimIEBrowser := nil;
end;

procedure TfrmRimIEBrowser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

procedure TfrmRimIEBrowser.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;

end;

procedure TfrmRimIEBrowser.SetCurUrl(const Value: string);
begin
  FCurUrl := Value;
end;

procedure TfrmRimIEBrowser.IEBrowserDownloadComplete(Sender: TObject);
begin
  inherited;
//  AdvFactory.GetAllFile(IEBrowser,CurUrl); 
end;

procedure TfrmRimIEBrowser.DoLogin;
var
  Params:TftParamList;
  Msg:string;
begin
  Logined := false;
  if not CaFactory.Audited or (Factor.ConnMode=1) then
     begin
       if Global.debug then Logined := true;
       Exit;
     end;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Msg := Global.RemoteFactory.ExecProc('TRimWsdlService',Params);
    Params.Decode(Params,Msg);
    Rim_ComId := Params.ParambyName('rimcid').AsString;
    Rim_CustId := Params.ParambyName('rimuid').AsString;
    if Rim_CustId='' then Raise Exception.Create('当前登录门店的许可证号无效，请输入修改正确的许可证号.');
    Logined := true;
  finally
    Params.Free;
  end;
end;

procedure TfrmRimIEBrowser.SetLogined(const Value: boolean);
begin
  FLogined := Value;
end;

end.
