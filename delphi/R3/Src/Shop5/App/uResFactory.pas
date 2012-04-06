unit uResFactory;

interface

uses  XMLIntf, XMLDoc, msXml, classes, ComObj, IdBaseComponent, IdComponent, Forms,
      IdTCPConnection, IdTCPClient, IdHTTP, SysUtils, Windows, ActiveX;

type
  TResFactory = class
  private
    zipFileSize : Integer;
    idHttp : TidHttp;
    procedure IdHTTPWork(Sender : TObject; AWorkMode : TWorkMode; const AWorkCount : Integer);
    function checkResVersion(remoteVersion : string; localVersion : string) : boolean;
    function downloadFile(src : string; filename : string) : boolean;
    function unZipFiles(filename : string; path : string) : boolean;
  public
    function checkAndDownRes() : boolean;
 end;

var resFactory : TResFactory;

implementation

uses  ufrmLogo, udbUtil, ZipUtils, IniFiles, uCaFactory;

// ��ȡ�ļ���
function getFileNameFromURL(url: string): string;
  var ts : TStrings;
begin
  ts := TStringList.create;
  try
    ts.Delimiter := '/';
    ts.DelimitedText := url;
  if ts.Count > 0 then
    Result := ts[ts.Count - 1];
  finally
    ts.Free;
  end;
end;

// ���汾������
function TResFactory.checkAndDownRes() : boolean;
  var filename, remoteVersion, localVersion, src, path : string;
  var cfgFile : TIniFile;
begin
  result := false;
  remoteVersion := CaFactory.resVersion; // ������Դ���汾��
  src := CaFactory.resDesktop; // ������Դ�����ص�ַ
  filename := ExtractFilePath(ParamStr(0)) + 'install\' + getFileNameFromURL(src); // ����zip·��
  path := ExtractFilePath(ParamStr(0)); // ��ѹ·��
  frmLogo.Show;
  frmLogo.ProgressBar1.Max := 100;
  cfgFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'r3.cfg');
  try
    localVersion := cfgFile.ReadString(cfgFile.ReadString('soft', 'ProductID', 'default'), 'resVersion', ''); // ��ȡ���ذ汾
    if checkResVersion(remoteVersion, localVersion) then
      begin
        if downloadFile(src, filename) and unZipFiles(filename, path) then // ������Դ������ѹ
          begin
            cfgFile.WriteString(cfgFile.ReadString('soft', 'ProductID', 'default'), 'resVersion', remoteVersion);// д��Դ���汾��
            result := true;
          end
      end
  else
    result := false;
  finally
    cfgFile.Free;
  end;
  frmLogo.Close;
end;

// �����Դ���汾������true : ��Ҫ����
function TResFactory.checkResVersion(remoteVersion : string; localVersion : string) : boolean;
  var dbFactory : TCreateDbFactory;
begin
  frmLogo.ShowTitle := '���ڼ����Դ���汾...';
  result := false;
  dbFactory := TCreateDbFactory.Create;
  try
    result := (remoteVersion <> '') and (dbFactory.CompareVersion(remoteVersion, localVersion));
  finally
    dbFactory.Free;
  end;
end;

// ������Դ��
function TResFactory.downloadFile(src : string; filename : string) : boolean;
  var fFile : TFileStream;
begin
  frmLogo.ShowTitle := '����������Դ��...';
  result := false;
  ForceDirectories(ExtractFileDir(filename));
  fFile := TFileStream.Create(filename, fmCreate);
  idHttp := TidHTTP.Create(application);
  try
    idHTTP.OnWork := IdHTTPWork;
    idHttp.HandleRedirects := true;
    idHTTP.Head(src);
    zipFileSize := idHTTP.Response.ContentLength;
    idHTTP.Get(src, fFile);
    result := true;
  finally
    fFile.Free;
    idHttp.Free;
  end;
end;

// ������
procedure TResFactory.IdHTTPWork(Sender : TObject; AWorkMode : TWorkMode; const AWorkCount : Integer);
begin
  if zipFileSize <> 0 then
    frmLogo.Position := Round(AWorkCount/zipFileSize * 100);
end;

// ��ѹ
function TResFactory.unZipFiles(filename : string; path : string) : boolean;
  var fileList : string;
begin
  frmLogo.ShowTitle := '���ڽ�ѹ��Դ��...';
  result := false;
  fileList := '';
  ZipUtils.UnZipFiles(filename, path, '', fileList);
  result := true;
end;

initialization
  resFactory := TResFactory.Create;
finalization
  resFactory.Free;
 
end.
