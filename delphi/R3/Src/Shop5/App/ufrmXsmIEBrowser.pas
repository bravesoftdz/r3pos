unit ufrmXsmIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ActnList, Menus, OleCtrls, SHDocVw, ExtCtrls,
  RzPanel, RzTabs, ImgList, LCContrllerLib, ZDataSet, StdCtrls;

type
  TfrmXsmIEBrowser = class(TfrmIEWebForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    FLogined: boolean;
    { Private declarations }
    procedure DoAction(Act:PIEAction);override;
    procedure DoFuncCall(ASender: TObject; const szMethodName: WideString;
                                                   const szPara: WideString);
    procedure DoFuncCall2(ASender: TObject; const szMethodName: WideString;
                                                   const szPara1: WideString; 
                                                   const szPara2: WideString);
    procedure DoFuncCall3(ASender: TObject; const szMethodName: WideString;
                                                   const szPara1: WideString; 
                                                   const szPara2: WideString; 
                                                   const szPara3: WideString);
    procedure SetLogined(const Value: boolean);
  public
    { Public declarations }
    LCObject:TLCObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure Connect;
    procedure Send(const szMethodName: WideString;const szPara: WideString);
    procedure Send2(const szMethodName: WideString;const szPara: WideString);
    procedure Send3(const szMethodName: WideString;const szPara: WideString);
    procedure DoLogin;
    property Logined:boolean read FLogined write SetLogined;
  end;

implementation
uses uGlobal,uIdLogFile;
{$R *.dfm}

{ TfrmXsmIEBrowser }

constructor TfrmXsmIEBrowser.Create(AOwner: TComponent);
begin
  inherited;
  LCObject := TLCObject.Create(AOwner);
  LCObject.OnFuncCall := DoFuncCall;
  LCObject.OnFuncCall2 := DoFuncCall2;
  LCObject.OnFuncCall3 := DoFuncCall3;
  Connect;
end;

destructor TfrmXsmIEBrowser.Destroy;
begin
  LCObject.Free;
  inherited;
end;

procedure TfrmXsmIEBrowser.DoAction(Act: PIEAction);
begin
  inherited;
  
end;

procedure TfrmXsmIEBrowser.DoFuncCall3(ASender: TObject;
  const szMethodName, szPara1, szPara2, szPara3: WideString);
begin
  ShowMessage(szMethodName);
end;

procedure TfrmXsmIEBrowser.DoLogin;
begin

end;

procedure TfrmXsmIEBrowser.SetLogined(const Value: boolean);
begin
  FLogined := Value;
end;

procedure TfrmXsmIEBrowser.DoFuncCall(ASender: TObject; const szMethodName,
  szPara: WideString);
begin
  ShowMessage(szMethodName);
end;

procedure TfrmXsmIEBrowser.DoFuncCall2(ASender: TObject;
  const szMethodName, szPara1, szPara2: WideString);
begin
  ShowMessage(szMethodName);
end;

procedure TfrmXsmIEBrowser.Connect;
var r:integer;
begin
  r := LCObject.Connect('_r3');
  if r<>0 then idLogFile.AddLogFile(0,'¡¨Ω”–¬…Ã√À ß∞‹£¨ ß∞‹¥˙¬Î:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Button1Click(Sender: TObject);
begin
  inherited;
  Send('kdjfkd','kdjfkd');
end;

procedure TfrmXsmIEBrowser.Send(const szMethodName, szPara: WideString);
var r:integer;
begin
  r := LCObject.Send('_xsm',szMethodName,szPara);
  if r<>0 then idLogFile.AddLogFile(0,'∑¢ÀÕ<'+szMethodName+'>p1='+szPara+' ß∞‹£¨ ß∞‹¥˙¬Î:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send2(const szMethodName, szPara: WideString);
begin

end;

procedure TfrmXsmIEBrowser.Send3(const szMethodName, szPara: WideString);
begin

end;

end.
