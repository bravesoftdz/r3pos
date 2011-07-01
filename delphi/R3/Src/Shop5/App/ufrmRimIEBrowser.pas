unit ufrmRimIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, RzTabs, OleCtrls,
  SHDocVw, ExtCtrls, RzPanel;

type
  TfrmRimIEBrowser = class(TfrmIEWebForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IEBrowserDownloadComplete(Sender: TObject);
  private
    FCurUrl: string;
    procedure SetCurUrl(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure ReadParam;
    function EncodeChk:string;

    function OpenUrl(url:string):boolean;
    property CurUrl:string read FCurUrl write SetCurUrl;
  end;
var
  Rim_Url:string;
  Rim_ComId:string;
  Rim_CustId:string;
  frmRimIEBrowser:TfrmRimIEBrowser;
implementation
uses IniFiles,EncDec,uAdvFactory;
{$R *.dfm}

{ TfrmRimIEBrowser }

function TfrmRimIEBrowser.EncodeChk: string;
begin
  result := 'comId='+Rim_ComId+'&custId='+Rim_CustId;
end;

function TfrmRimIEBrowser.OpenUrl(url: string):boolean;
var
  p:string;
  e:string;
begin
  WindowState := wsMaximized;
  BringToFront;
  ReadParam;
  if pos('?',url)=0 then p := '?' else p := '&';
  e := EncStr(url,ENC_KEY);
  result := inherited Open(Rim_Url+url+p+EncodeChk);
  if result then
     begin
       url := e;
       AdvFactory.GetAllFile(IEBrowser,e);
     end
  else
     begin
       AdvFactory.LoadAllFile(IEBrowser,e); 
     end;
end;

procedure TfrmRimIEBrowser.ReadParam;
var
  F:TIniFile;
  List:TStringList;
begin
  if Rim_ComId<>'' then Exit;
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
  Rim_ComId := 'LZ0000000000001';
  Rim_CustId := 'GX00000004392';
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

end.
