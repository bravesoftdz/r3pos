unit ufrmUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, StdCtrls, RzLabel,
  ExtCtrls, AppWebUpdater, ComCtrls, RzEdit, uRspFactory,ZdbFactory,udbUtil,
  RzStatus;

type
  TfrmUpdate = class(TfrmWebDialog)
    ProgressBar1: TProgressBar;
    Memo1: TRzMemo;
    RzLabel2: TRzLabel;
    RzPanel1: TRzPanel;
    btn24hsc: TRzBmpButton;
    RzVersionInfo1: TRzVersionInfo;
    procedure WebUpdater1Success(Sender: TObject;
      SuccessCode: TSuccessMessage; Parameter, SuccessMessage: String);
    procedure WebUpdater1Error(Sender: TObject; ErrorCode: TErrorMessage;
      Parameter, ErrMessage: String);
    procedure FormCreate(Sender: TObject);
    procedure WebUpdater1ChangeText(Sender: TObject; Text: String);
    procedure FormShow(Sender: TObject);
    procedure btn24hscClick(Sender: TObject);
  private
    CaUpgrade:TCaUpgrade;
    CreateDbFactroy:TCreateDbFactory;
    FUpgrade: integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CallBack(Title, SQL: string; Percent: Integer);
    procedure SetUpgrade(const Value: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckUpgrade:boolean;
    function CheckDBVersion:boolean;
    procedure UpgradeDBVersion;
    procedure UpgradeApplication;
    property Upgrade:integer read FUpgrade write SetUpgrade;
  end;

implementation

uses ufrmBrowerForm,uTokenFactory,IniFiles,udataFactory,uUcFactory;

{$R *.dfm}

procedure TfrmUpdate.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
       WndParent:=frmBrowerForm.Handle; //关键一行，用SetParent都不行！！
    end;
end;

procedure TfrmUpdate.WebUpdater1Success(Sender: TObject;
  SuccessCode: TSuccessMessage; Parameter, SuccessMessage: String);
begin
  inherited;
  btn24hsc.Caption := '关闭窗口';
end;

procedure TfrmUpdate.WebUpdater1Error(Sender: TObject;
  ErrorCode: TErrorMessage; Parameter, ErrMessage: String);
begin
  inherited;
  btn24hsc.Caption := '关闭窗口';
end;

procedure TfrmUpdate.FormCreate(Sender: TObject);
begin
  inherited;
  WebUpdater1.Form := self;
end;

procedure TfrmUpdate.WebUpdater1ChangeText(Sender: TObject; Text: String);
begin
  inherited;
  Memo1.Lines.Add(Text); 
end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  inherited;
  ProgressBar1.Position := 0;
end;

procedure TfrmUpdate.UpgradeApplication;
begin
  Memo1.SetFocus;
  WebUpdater1.Start;
  Upgrade := 3;
  btn24hsc.caption := '关闭窗口';
  Close;
end;

function TfrmUpdate.CheckDBVersion: boolean;
begin
  result := false;
  if not fileExists(ExtractFilePath(Application.ExeName)+'dbfile.dat') then Exit;
  CreateDbFactroy.Load(ExtractFilePath(Application.ExeName)+'dbfile.dat');
  CreateDbFactroy.getMaxVersion;
  result := CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion,dataFactory.sqlite);
  if result then
     begin
       Memo1.Clear;
       Memo1.Lines.Add('最新数据库版本:'+CreateDbFactroy.getMaxVersion);
       Memo1.Lines.Add('当前数据库版本:'+CreateDbFactroy.DbVersion);
       Memo1.Lines.Add('');
       Memo1.Lines.Add('点击立即升级开始执行...');
     end;
  if result then Upgrade := 2;
end;

procedure TfrmUpdate.CallBack(Title, SQL: string; Percent: Integer);
begin
 ProgressBar1.Position := Percent;
 Memo1.Lines.Add(Title+ ' '+ SQL);
end;

function TfrmUpdate.CheckUpgrade: boolean;
var
  F:TIniFile;
  ProductId:string;
  myVersion:string;
  url:TStringList;
begin
  result := false;
  CaUpgrade.UpGrade := 3;
  F:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    ProductId := F.ReadString('soft','ProductID','');
  finally
    F.Free;
  end;
  myVersion := '0.0.0.0';// inttostr(WebUpdater1.ApplicationVersion.MajorVersion)+'.'+inttostr(WebUpdater1.ApplicationVersion.MinorVersion)+'.'+inttostr(WebUpdater1.ApplicationVersion.ReleaseVersion)+'.'+inttostr(WebUpdater1.ApplicationVersion.BuildVersion);
  if UcFactory.AuthMode = 2 then
     CaUpgrade := UcFactory.CheckUpgrade(token.tenantId,ProductId,myVersion)
  else
     CaUpgrade := rspFactory.CheckUpgrade(token.tenantId,ProductId,myVersion);
{
  if CaUpgrade.UpGrade in [1,2] then
     begin
       if (MessageBox(handle,pchar('系统检测的新版本'+CaUpgrade.Version+'，是否立即升级？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then
          begin
            if (CaUpgrade.UpGrade=1) then
               begin
                 MessageBox(handle,pchar('你使用的软件版本过旧，没有升级无法继续使用.'),'友情提示...',MB_OK+MB_ICONQUESTION);
                 Application.Terminate;
               end else CaUpgrade.UpGrade := 3;
          end;
     end
  else
     CaUpgrade.UpGrade := 3;
}
  if CaUpgrade.URL='' then Exit;
  RzVersionInfo1.FilePath := ExtractFilePath(ParamStr(0))+'shop.dll';
  url := TStringList.Create;
  try
    url.Delimiter := '/';
    url.DelimitedText := CaUpgrade.URL;
    if lowercase(copy(url[url.Count-1],length(url[url.Count-1])-3,4))='.exe' then url.Delete(url.Count-1);
    WebUpdater1.WebUrl := url.DelimitedText;
    url.Delimiter := '.';
    url.DelimitedText := RzVersionInfo1.FileVersion;
    WebUpdater1.ApplicationVersion.MajorVersion := StrtoInt(url[0]);
    WebUpdater1.ApplicationVersion.MinorVersion := StrtoInt(url[1]);
    WebUpdater1.ApplicationVersion.ReleaseVersion := StrtoInt(url[2]);
    WebUpdater1.ApplicationVersion.BuildVersion := StrtoInt(url[3]);
  finally
    url.Free;
  end;
  memo1.Clear;
  result := WebUpdater1.Check;
  if result then Upgrade := 1;
end;

constructor TfrmUpdate.Create(AOwner: TComponent);
begin
  inherited;
  CreateDbFactroy := TCreateDbFactory.Create;
  CreateDbFactroy.CaptureError := true;
  CreateDbFactroy.onCreateDbCallBack := CallBack;
  CreateDbFactroy.dbFactor := dataFactory.sqlite;
end;

destructor TfrmUpdate.Destroy;
begin
  CreateDbFactroy.Free;
  inherited;
end;

procedure TfrmUpdate.UpgradeDBVersion;
var
   ext:string;
begin
   ext := CreateDbFactroy.PrgVersion;
   //备份数据库
   if not fileExists(pchar(ExtractFilePath(ParamStr(0))+'data\r3.'+ext)) then
      begin
        if fileExists(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db')) and not Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),pchar(ExtractFilePath(ParamStr(0))+'data\r3.'+ext),false) then Raise Exception.Create('升级时备份数据库失败');
      end
   else
      begin
        if MessageBox(handle,'系统检测到升级异常文件，是否恢复原文件？','友情提示...',MB_YESNO+MB_ICONINFORMATION)=6 then
           begin
             dataFactory.sqlite.DisConnect;
             if not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db')) then Raise Exception.Create('r3.db文件被其他程序占用，不能完成升级恢复');
             if not Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.'+ext),pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),false) then Raise Exception.Create('r3.db文件被其他程序占用，不能完成升级恢复');
           end;
      end;
   try
     CreateDbFactroy.Run;
     deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.'+ext)); //升级成功，删除备份文件
     upgrade := 3;
     btn24hsc.caption := '关闭窗口';
   except
     on E:Exception do
        begin
           dataFactory.sqlite.DisConnect;
           if not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db')) then Raise Exception.Create('r3.db文件被其他程序占用，不能完成升级恢复');
           if not Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.'+ext),pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),false) then Raise Exception.Create('r3.db文件被其他程序占用，不能完成升级恢复');
           Raise Exception.Create('升级数据库出错了,错误:'+E.Message);
        end;
   end;
end;

procedure TfrmUpdate.SetUpgrade(const Value: integer);
begin
  FUpgrade := Value;
end;

procedure TfrmUpdate.btn24hscClick(Sender: TObject);
begin
  inherited;
  btn24hsc.caption := '请稍候..';
  try
    case upgrade of
    1:UpgradeApplication;
    2:UpgradeDBVersion;
    3:Close;
    end;
  except
    btn24hsc.caption := '立即升级';
    Raise;
  end;
end;

end.
