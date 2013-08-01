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

uses  ufrmLogo,ZipUtils, IniFiles, uRspFactory;

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
  remoteVersion := rspFactory.resVersion; // ������Դ���汾��
  src := rspFactory.resDesktop; // ������Դ�����ص�ַ
  filename := ExtractFilePath(ParamStr(0)) + 'install\' + getFileNameFromURL(src); // ����zip·��
  path := ExtractFilePath(ParamStr(0)); // ��ѹ·��
  cfgFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'r3.cfg');
  try
    localVersion := cfgFile.ReadString(cfgFile.ReadString('soft', 'ProductID', 'default'), 'resVersion', ''); // ��ȡ���ذ汾
    if (remoteVersion<>'') and checkResVersion(remoteVersion, localVersion) then
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
end;

// �����Դ���汾������true : ��Ҫ����
function TResFactory.checkResVersion(remoteVersion : string; localVersion : string) : boolean;
function CompareVersion(v1, v2: string): Boolean;
var L1,L2:TStringList;
  v11,v12,v13,v14:Integer;
  v21,v22,v23,v24:Integer;
begin
  L1 := TStringList.Create;
  L2 := TStringList.Create;
  try
    L1.Delimiter := '.';
    L1.DelimitedText := v1;
    L2.Delimiter := '.';
    L2.DelimitedText := v2;

    if L1.Count >= 1 then v11 := StrtoIntDef(L1[0],0) else v11 := 0;
    if L1.Count >= 2 then v12 := StrtoIntDef(L1[1],0) else v12 := 0;
    if L1.Count >= 3 then v13 := StrtoIntDef(L1[2],0) else v13 := 0;
    if L1.Count >= 4 then v14 := StrtoIntDef(L1[3],0) else v14 := 0;

    if L2.Count >= 1 then v21 := StrtoIntDef(L2[0],0) else v21 := 0;
    if L2.Count >= 2 then v22 := StrtoIntDef(L2[1],0) else v22 := 0;
    if L2.Count >= 3 then v23 := StrtoIntDef(L2[2],0) else v23 := 0;
    if L2.Count >= 4 then v24 := StrtoIntDef(L2[3],0) else v24 := 0;

    if v11>v21 then
       result := true
    else
    if v11<v21 then
       result := false
    else
    if v12>v22 then
       result := true
    else
    if v12<v22 then
       result := false
    else
    if v13>v23 then
       result := true
    else
    if v13<v23 then
       result := false
    else
    if v14>v24 then
       result := true
    else
       result := false;
  finally
    L1.Free;
    L2.Free;
  end;
end;
begin
  result := (remoteVersion <> '') and CompareVersion(remoteVersion, localVersion);
end;

// ������Դ��
function TResFactory.downloadFile(src : string; filename : string) : boolean;
  var fFile : TFileStream;
begin
  frmLogo.showCaption := '����������Դ��...';
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
end;

// ��ѹ
function TResFactory.unZipFiles(filename : string; path : string) : boolean;
  var fileList : string;
begin
  frmLogo.showCaption := '���ڽ�ѹ��Դ��...';
  result := false;
  fileList := '';
  if ZipUtils.UnZipFiles(filename, path, '', fileList) then
    result := true;
end;

initialization
  resFactory := TResFactory.Create;
finalization
  resFactory.Free;
 
end.
