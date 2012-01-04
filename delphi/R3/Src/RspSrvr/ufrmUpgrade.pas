unit ufrmUpgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmTenant, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ActnList, Menus, cxMaskEdit, cxButtonEdit, zrComboBoxList, ExtCtrls,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, RzLabel, StdCtrls,
  RzTabs, RzRadChk, ComCtrls, RzStatus, uDownByHttp, TlHelp32,ShellApi,
  jpeg, cxSpinEdit, cxDropDownEdit, RzPanel, ZdbFactory,ZBase, cxCheckBox;

type
  TfrmUpgrade = class(TfrmTenant)
    TabSheet3: TRzTabSheet;
    Panel1: TPanel;
    Image1: TImage;
    Label25: TLabel;
    Bevel3: TBevel;
    Label26: TLabel;
    btnInstall: TRzBitBtn;
    stp1: TRzLabel;
    stp2: TRzLabel;
    stp3: TRzLabel;
    RzVersionInfo: TRzVersionInfo;
    TabSheet4: TRzTabSheet;
    rzGroupBox: TRzGroupBox;
    NbMode: TNotebook;
    lblDbType: TLabel;
    lbDBName: TLabel;
    lbDBBaseName: TLabel;
    lblUser: TLabel;
    lblUserPW: TLabel;
    lblAccountName: TLabel;
    Label28: TLabel;
    edtDbDir: TcxButtonEdit;
    cbDbType: TcxComboBox;
    edtDbName: TcxTextEdit;
    edtDatabase: TcxTextEdit;
    edtUser: TcxTextEdit;
    edtUserPw: TcxTextEdit;
    edtDBID: TcxSpinEdit;
    Panel3: TPanel;
    Image2: TImage;
    Label29: TLabel;
    Bevel4: TBevel;
    Label30: TLabel;
    TabSheet5: TRzTabSheet;
    RzBitBtn2: TRzBitBtn;
    Panel4: TPanel;
    Image3: TImage;
    Label31: TLabel;
    Bevel5: TBevel;
    Label32: TLabel;
    RzCheckBox1: TRzCheckBox;
    Label27: TLabel;
    PrsBar: TProgressBar;
    RzBitBtn3: TRzBitBtn;
    Label33: TLabel;
    ProgressBar1: TProgressBar;
    Label34: TLabel;
    cxButtonEdit1: TcxButtonEdit;
    Label35: TLabel;
    Region: TZQuery;
    dbcRegion: TcxComboBox;
    chkPartition: TcxCheckBox;
    procedure RzCheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnInstallClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    Aborted:boolean;
    procedure CallBack(Title:string;SQL:string;Percent:Integer);
    function CheckLogin(NetWork:boolean=true): Boolean;
    function WinExecAndWait32V2(FileName: string; Visibility: integer): DWORD;
    function CheckExeFile(filename: string): boolean;
    function GetConnStr: string;
    procedure TestConnect;
    function GetIniParams(Section, Key: String): String;
    procedure LoadParams;
    procedure SaveParams;
    function GetPartitionSQL:string;
    procedure SetIniParams(Section, Key, Value: String);
  public
    { Public declarations }
    url,path,dbid:string;
    procedure dbUpgrade(id:string);
    function DownFile(FileName:string):boolean;
  end;

var
  frmUpgrade: TfrmUpgrade;

implementation
uses uCaFactory, uGlobal,uDsUtil,WinSvc,udbUtil,IniFiles,EncDec;
var IsStop:boolean;
{$R *.dfm}
function StopService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  SvcStatus: TServiceStatus;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if Result then
    try  //停止并卸载服务;
      Result := ControlService(hService, SERVICE_CONTROL_STOP, SvcStatus);
      //删除服务，这一句可以不要;
      //DeleteService(hService);
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;
function StartService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  lpServiceArgVectors: PChar;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if (hService = 0) and (GetLastError = ERROR_SERVICE_DOES_NOT_EXIST) then
      Exception.Create('The specified service does not exist');
    if hService <> 0 then
    try
      lpServiceArgVectors := nil;
      Result := WinSvc.StartService(hService, 0, PChar(lpServiceArgVectors));
      if not Result and (GetLastError = ERROR_SERVICE_ALREADY_RUNNING) then
        Result := True;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;
function QueryService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  SvcStatus: TServiceStatus;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_QUERY_STATUS);
    Result := hService <> 0;
    if Result then
    try  //停止并卸载服务;
      Result := QueryServiceStatus(hService,SvcStatus);
      case SvcStatus.dwCurrentState of
      SERVICE_STOPPED:
        begin
          IsStop := true;
        end;
      SERVICE_RUNNING:
        begin
          IsStop := false;
        end;
      end;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

{文件是否在使用中}
function IsFileInUse(fName:string):boolean;
var
  HFileRes : HFILE;
begin
  Result := false;
  if not FileExists(fName) then
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,0, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

function TfrmUpgrade.GetConnStr: string;
var ConnStr:String;
    vList:TStringList;
begin
    case cbDbType.ItemIndex of
      0:begin
        if Trim(edtDbName.Text) = '' then Raise Exception.Create('');
        if Trim(edtDatabase.Text) = '' then Raise Exception.Create('');
        if Trim(edtUser.Text) = '' then Raise Exception.Create('');
        if Trim(edtUserPw.Text) = '' then Raise Exception.Create('');
        ConnStr := 'provider=mssql';
        ConnStr := ConnStr + ';hostname=' + Trim(edtDbName.Text);
        ConnStr := ConnStr + ';databasename=' + Trim(edtDatabase.Text);
        ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
        ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
       end;
      1:begin
        ConnStr := 'provider=oracle-9i';
        ConnStr := ConnStr + ';hostname=' + Trim(edtDbName.Text);
        ConnStr := ConnStr + ';databasename=' + Trim(edtDatabase.Text);
        ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
        ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
       end;
      2:begin
        ConnStr := 'provider=sqlite-3';
        ConnStr := ConnStr + ';databasename=' + Trim(edtDbDir.Text);
        if Trim(edtUser.Text) <> '' then ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
        if Trim(edtUserPw.Text) <> '' then ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
       end;
      3:begin
        ConnStr := 'provider=ado';
        ConnStr := ConnStr + ';"databasename=Provider=IBMDADB2;Persist Security Info=True;Data Source='+Trim(edtDatabase.Text)+';Location='+Trim(edtDbName.Text)+'"';
        ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
        ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
       end;
    end;
    Result := ConnStr;
end;

procedure TfrmUpgrade.SetIniParams(Section, Key, Value: String);
var F:TIniFile;
    Path:String;
begin
  Path := ExtractFilePath(Application.ExeName)+'db.cfg';
  try
    F := TIniFile.Create(Path);
    F.WriteString(Section,Key,Value);
  finally
    F.Free;
  end;
end;

procedure TfrmUpgrade.LoadParams;
var Pro:String;
  DBID:integer;
begin
  cxButtonEdit1.Text := GetIniParams('db','dataPath');
  chkPartition.Checked := (GetIniParams('db','partition')='1');
  DBID := StrtoIntDef(GetIniParams('db','dbid'),10000001);
  edtDBID.Value := DBID;
  Pro := GetIniParams('db'+IntToStr(DBID),'provider');
  if Pro='mssql' then cbDbType.ItemIndex := 0;
  if Pro='oracle' then cbDbType.ItemIndex := 1;
  if Pro='sqlite' then cbDbType.ItemIndex := 2;
  if Pro='db2' then cbDbType.ItemIndex := 3;
  if cbDbType.ItemIndex = 0 then
    begin
      edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
      edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
      edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
      edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
    end
  else if cbDbType.ItemIndex = 1 then
    begin
      edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
      edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
      edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
      edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
    end
  else if cbDbType.ItemIndex = 2 then
    begin
      edtDbDir.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
      edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
      edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
      edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
    end
  else if cbDbType.ItemIndex = 3 then
    begin
      edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
      edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
      edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
      edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
    end;
end;


procedure TfrmUpgrade.SaveParams;
var Pro:String;
    DBID:integer;
begin
    DBID := edtDBID.Value;
    SetIniParams('db','dbid',IntToStr(DBID));
    if cbDbType.ItemIndex = 2 then
      SetIniParams('db'+IntToStr(DBID),'hostname',Trim(edtDbDir.Text))
    else
      SetIniParams('db'+IntToStr(DBID),'hostname',Trim(edtDbName.Text));

    SetIniParams('db'+IntToStr(DBID),'databasename',Trim(edtDatabase.Text));
    SetIniParams('db'+IntToStr(DBID),'uid',Trim(edtUser.Text));
    SetIniParams('db'+IntToStr(DBID),'password',EncStr(Trim(edtUserPw.Text),ENC_KEY));
    case cbDbType.ItemIndex of
      0: Pro := 'mssql';
      1: Pro := 'oracle';
      2: Pro := 'sqlite';
      3: Pro := 'db2';
    end;
    SetIniParams('db'+IntToStr(DBID),'provider',Pro);
    SetIniParams('db'+IntToStr(DBID),'dbid',IntToStr(edtDBID.Value));

    SetIniParams('db'+IntToStr(DBID),'connstr',EncStr(GetConnStr,ENC_KEY));
end;

function TfrmUpgrade.GetIniParams(Section, Key: String): String;
var F: TIniFile;
    Path:String;
begin
  Path := ExtractFilePath(Application.ExeName)+'db.cfg';
  try
    F := TIniFile.Create(Path);
    Result := F.ReadString(Section,Key,'');
  finally
    F.Free;
  end;

end;
procedure TfrmUpgrade.TestConnect;
var Conn:TdbFactory;
    ConString:String;
begin
  try
    ConString := GetConnStr;
    Conn := TdbFactory.Create;
    Conn.ConnMode := 2;
    Conn.Initialize(ConString);
    if not Conn.Connect then
      Raise Exception.Create('测试连接未通过,请检查各连接参数是否正确!');
  finally
    Conn.Free;
  end;
end;

procedure TfrmUpgrade.RzCheckBox1Click(Sender: TObject);
begin
  inherited;
  RzBitBtn3.Enabled := RzCheckBox1.Checked;
end;

procedure TfrmUpgrade.FormShow(Sender: TObject);
begin
  inherited;
  if ParamStr(1)='-MT' then
     begin
       LoadParams;
       RzPage.ActivePageIndex := 3;
     end
  else
     if Check then  RzPage.ActivePageIndex := 2 else RzPage.ActivePageIndex := 0;
end;

procedure TfrmUpgrade.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  if ModalResult=MROK then rzPage.ActivePageIndex := 2;
end;

procedure TfrmUpgrade.btnOkClick(Sender: TObject);
begin
  inherited;
  if ModalResult=MROK then rzPage.ActivePageIndex := 2;

end;

function TfrmUpgrade.CheckLogin(NetWork:boolean=true):Boolean;
var
  Temp: TZQuery;
  login:TCaLogin;
begin
  Global.MoveToLocal;
  dbid := '';
  Result := False;
  try
    Temp := TZQuery.Create(nil);
    Temp.Close;
    Temp.SQL.Text := 'select LOGIN_NAME,PASSWRD,TENANT_ID,TENANT_NAME,SHORT_TENANT_NAME from CA_TENANT where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(TENANT_ID);
    Factor.Open(Temp);
    if NetWork then
       begin
         try
            login := CaFactory.coLogin(Temp.FieldByName('LOGIN_NAME').AsString,DecStr(Temp.FieldByName('PASSWRD').AsString,ENC_KEY));
            dbid := inttostr(login.DB_ID);
         except
           on E:Exception do
              begin
                if StrtoIntDef(login.RET,0) in [2,3] then
                   begin
                     MessageBox(Handle,pchar('企业认证失败？错误原因:'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
                     result := false;
                     Exit;
                   end
                else
                   begin
                     Raise;
                   end;
              end;
         end;
       end;
    Global.TENANT_ID := Temp.FieldByName('TENANT_ID').AsInteger;
    Global.TENANT_NAME := Temp.FieldByName('TENANT_NAME').AsString;
    Global.SHORT_TENANT_NAME := Temp.FieldByName('SHORT_TENANT_NAME').AsString;
    Result := True;
  finally
    Temp.Free;
  end;
end;
function TfrmUpgrade.CheckExeFile(filename: string): boolean;
var
  ProcessSnapShotHandle: THandle;
  ProcessEntry: TProcessEntry32;
  Ret: BOOL;
  s: string;
  Position: Integer;
begin
  result := false;
  ProcessSnapShotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if ProcessSnapShotHandle>0 then
  begin
    try
      ProcessEntry.dwSize:=SizeOf(TProcessEntry32);
      Ret:=Process32First(ProcessSnapShotHandle, ProcessEntry);
      while Ret do
      begin
        s:=LowerCase(ExtractFileName(ProcessEntry.szExeFile));
        if s=LowerCase(filename)
        then
          begin
            result := true;
            Break;
          end;
        //比较s的值就行了.
        Ret:=Process32Next(ProcessSnapShotHandle, ProcessEntry)
      end;
    finally
      CloseHandle(ProcessSnapShotHandle)
    end;
  end
end;
procedure TfrmUpgrade.btnInstallClick(Sender: TObject);
function GetFileNameFromURL(url: string): string;
var ts : TStrings;
begin
  //从url取得文件名
  ts := TStringList.create;
  try
    ts.Delimiter :='/';
    ts.DelimitedText := url;
    if ts.Count > 0 then
      Result := ts[ts.Count - 1];
  finally
    ts.Free;
  end;
end;
var
  CaUpgrade:TCaUpgrade;
  filename:string;
begin
  inherited;

  StopService('RSPScktSrvr');
  isStop := false;
  while not isStop and QueryService('RSPScktSrvr') do Application.ProcessMessages;

  sleep(1000);

  if CheckExeFile('RSPScktSrvr.exe') then Raise Exception.Create('服务程序正在运行,请先关闭应用后再升级..');

  CaFactory.RspFlag := 1;
  btnInstall.Enabled := false;
  try
    stp1.Font.Style := [];
    stp2.Font.Style := [];
    stp3.Font.Style := [];
    try
    stp1.Font.Style := [fsBold];
    if CheckLogin(true) then
       begin
         RzVersionInfo.FilePath := ExtractFilePath(ParamStr(0))+'RSPScktSrvr.exe';
         CaUpgrade := CaFactory.CheckUpgrade(inttostr(Global.TENANT_ID),'R3_RSP',RzVersionInfo.FileVersion);
       end
    else Raise Exception.Create('企业认证失败，无法完成安装升级..');

    stp2.Font.Style := [fsBold];
    if CaUpgrade.UpGrade in [1,2] then
    begin
      filename := GetFileNameFromURL(CaUpgrade.URL);
      Url := copy(CaUpgrade.URL,1,length(CaUpgrade.URL)-length(filename));
      Path := ExtractFilePath(ParamStr(0));
      Label27.Caption := '正在下载'+filename;
      Label27.Update;
      if DownFile(filename) then
         begin
         end
      else
         Raise Exception.Create('下载升级包失败，无法完成安装升级..');
    end;
    stp3.Font.Style := [fsBold];
    if CaUpgrade.UpGrade in [1,2] then
       WinExecAndWait32V2(Pchar(ExtractFilePath(ParamStr(0))+'install\'+filename),0);

    except
      on E:Exception do
         begin
           if MessageBox(Handle,pchar('检测版本升级文件失败，是否继续执行？错误原因:'+E.Message),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
         end;
    end;

    LoadParams;
    if ParamStr(1)='-MT' then
       begin
         RzPage.ActivePageIndex := RzPage.ActivePageIndex + 1;
       end
    else
       RzPage.ActivePageIndex := RzPage.ActivePageIndex + 2;
    TdsItems.ClearItems(dbcRegion.Properties.Items);
    Region.Close;
    Region.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and CODE_ID like ''%0000'' order by CODE_ID';
    Factor.Open(Region);
    TdsItems.AddDataSetToItems(Region,dbcRegion.Properties.Items,'CODE_NAME');
    dbcRegion.Properties.Items.Insert(0,'全国');
    dbcRegion.ItemIndex := 0;
  finally
    btnInstall.Enabled := true;
  end;
end;

function TfrmUpgrade.DownFile(FileName: string): boolean;
var HTTPGetFile: TDownByHttp;
  DstFile:string;
  SurFile:string;
  i:integer;
begin
  result := false;
  HTTPGetFile := TDownByHttp.Create(nil);
  try
    if Url[Length(Url)]='/' then
       SurFile := Url + FileName
    else
       SurFile := Url + '/'+FileName;
    DstFile := Path+'install\'+FileName;
    HTTPGetFile.FileName := DstFile;
    HTTPGetFile.FileURL := SurFile;
    HTTPGetFile.InitPosHandle(PrsBar.Handle);
    HTTPGetFile.DelayTime := 0;
    ForceDirectories(Path+'install\');//目录不存在时自动建目录
    Aborted := false;
    PrsBar.Max := 100;
    HTTPGetFile.LoadBreakFile;
    HTTPGetFile.DownFile;
    while not HTTPGetFile.Ended do
      begin
        if Aborted then HTTPGetFile.CancelDownLoad;
        Application.ProcessMessages;
      end;
    if Aborted then
      begin
        {文件可能还在使用中，做延时处理}
        i := 0;
        while (i < 500) and IsFileInUse(DstFile) do
        begin
          Application.ProcessMessages;
          inc(i);
        end;
        DeleteFile(DstFile);
      end;
    if FileExists(DstFile) and HTTPGetFile.Done then
      begin
        result := true;
      end
    else
      if not Aborted and HTTPGetFile.HasFile then
         result := DownFile(FileName);
  finally
    HTTPGetFile.free;
  end;
end;

procedure TfrmUpgrade.dbUpgrade(id:string);
var
  dbFactory:TCreateDbFactory;
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  dbFactory := TCreateDbFactory.Create;
  try
    dbFactory.CaptureError := not FindCmdLineSwitch('DEBUG',['-','+'],false);
    dbFactory.onCreateDbCallBack := CallBack;
    try
      Global.MoveToLocal;
      Global.Connect;
      if dbFactory.CheckVersion('9.9.9.9') then
       begin
         dbFactory.Load(ExtractFilePath(ParamStr(0))+'dbFile.dat');
         dbFactory.Run;
       end;
    except
      on E:Exception do
         Raise;//if MessageBox(Handle,Pchar('升级数据库<r3.db>出错了，是否继续执行?'+#13+'错误原因:'+E.Message),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end;
    try
       if trim(cxButtonEdit1.Text)='' then Raise Exception.Create('默认路径不能为空'); 
       Global.MoveToRemate;
       Factor.DisConnect;
       if id='' then id := F.ReadString('db','dbid',''); 
       Factor.Initialize(DecStr(F.ReadString('db'+id,'connstr',''),ENC_KEY));
       Factor.Connect;
       if dbFactory.CheckVersion('9.9.9.9') then
          begin
            dbFactory.Load(ExtractFilePath(ParamStr(0))+'dbFile.dat');
            dbFactory.TBSPPATH := trim(cxButtonEdit1.Text);
            dbFactory.PARTITION := GetPartitionSQL;
            if pos('\',dbFactory.TBSPPATH)>0 then
               begin
                 if dbFactory.TBSPPATH[length(dbFactory.TBSPPATH)]<>'\' then dbFactory.TBSPPATH := dbFactory.TBSPPATH+'\';
               end
            else
               begin
                 if dbFactory.TBSPPATH[length(dbFactory.TBSPPATH)]<>'/' then dbFactory.TBSPPATH := dbFactory.TBSPPATH+'/';
               end;
            dbFactory.dbInit;
            SetIniParams('db','dataPath',dbFactory.TBSPPATH);
            if chkPartition.Checked then
               SetIniParams('db','partition','1')
            else
               SetIniParams('db','partition','0');
            dbFactory.Run;
          end;
     except
       on E:Exception do
         begin
           Raise;//if MessageBox(Handle,Pchar('升级数据库<'+dbid+'>出错了，是否继续执行?'+#13+'错误原因:'+E.Message),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
         end;
     end;
  finally
    F.Free;
    dbFactory.free;
  end;
end;

procedure TfrmUpgrade.CallBack(Title, SQL: string; Percent: Integer);
begin
 Label33.Caption := Title;
 Label33.Update;
 ProgressBar1.Max := 100;
 ProgressBar1.Position := Percent;
end;

function TfrmUpgrade.WinExecAndWait32V2(FileName: string;
  Visibility: integer): DWORD;
  procedure WaitFor(processHandle: THandle);
  var
    msg: TMsg;
    ret: DWORD;
  begin
    repeat
      ret := MsgWaitForMultipleObjects(
        1, { 1 handle to wait on }
        processHandle, { the handle }
        False, { wake on any event }
        INFINITE, { wait without timeout }
        QS_PAINT or { wake on paint messages }
        QS_SENDMESSAGE { or messages from other threads }
        );
      if ret = WAIT_FAILED then
        Exit; { can do little here }
      if ret = (WAIT_OBJECT_0 + 1) then
      begin
        { Woke on a message, process paint messages only. Calling
          PeekMessage gets messages send from other threads processed. }
        while PeekMessage(msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
          DispatchMessage(msg);
      end;
    until ret = WAIT_OBJECT_0;
  end; { Waitfor }
var { V1 by Pat Ritchey, V2 by P.Below }
  zAppName: array[0..512] of char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin { WinExecAndWait32V2 }
  StrPCopy(zAppName, FileName);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, { pointer to command line string }
    nil, { pointer to process security attributes }
    nil, { pointer to thread security attributes }
    false, { handle inheritance flag }
    CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil, { pointer to new environment block }
    nil, { pointer to current directory name }
    StartupInfo, { pointer to STARTUPINFO }
    ProcessInfo) { pointer to PROCESS_INF } then
    Result := DWORD(-1) { failed, GetLastError has error code }
  else
  begin
    Waitfor(ProcessInfo.hProcess);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end; { Else }
end;

procedure TfrmUpgrade.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  TestConnect;
  SaveParams;
  TdsItems.ClearItems(dbcRegion.Properties.Items);
  Region.Close;
  Region.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and CODE_ID like ''%0000'' order by CODE_ID';
  Factor.Open(Region);
  TdsItems.AddDataSetToItems(Region,dbcRegion.Properties.Items,'CODE_NAME');
  dbcRegion.Properties.Items.Insert(0,'全国');
  dbcRegion.ItemIndex := 0;
  RzPage.ActivePageIndex := RzPage.ActivePageIndex + 1;
end;

procedure TfrmUpgrade.RzBitBtn3Click(Sender: TObject);
begin
  inherited;
  Label27.Caption := '正在升级数据..';
  Label27.Update;
  dbUpgrade('');
  if MessageBox(Handle,'安装升级执行完毕，是否立即运行服务程序？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
  begin
     if not StartService('RSPScktSrvr') then ShellExecute(0,'open',pchar(ExtractFilePath(ParamStr(0))+'RSPScktSrvr.exe'),nil,nil,0);
  end;

end;

function TfrmUpgrade.GetPartitionSQL: string;
var rs:TZQuery;
begin
  result := '';
  if not chkPartition.Checked then Exit;
  rs := TZQuery.Create(nil);
  try
    if dbcRegion.ItemIndex=0 then
       rs.SQL.Text := 'select CODE_ID from PUB_CODE_INFO where CODE_TYPE=''8'' and CODE_ID like ''%00'' order by CODE_ID'
    else
       rs.SQL.Text := 'select CODE_ID from PUB_CODE_INFO where CODE_TYPE=''8'' and CODE_ID like '''+copy(TRecord_(dbcREGION.Properties.Items.Objects[dbcREGION.ItemIndex]).FieldbyName('CODE_ID').asString,1,2)+'%00'' order by CODE_ID';
    Global.LocalFactory.Open(rs);
    case Factor.iDbType of
    1:result := 'PARTITION BY RANGE(TENANT_ID) (';
    4:result := 'PARTITION BY RANGE(TENANT_ID) ( STARTING MINVALUE';
    else
      Exit;
    end;
    rs.First;
    while not rs.Eof do
      begin
        case Factor.iDbType of
        1:result := result + 'PARTITION C'+copy(rs.Fields[0].AsString,1,4)+' VALUES LESS THAN ('+copy(rs.Fields[0].AsString,1,4)+'99999),';
        4:result := result + ',PARTITION C'+copy(rs.Fields[0].AsString,1,4)+' STARTING '+copy(rs.Fields[0].AsString,1,4)+'00000 ENDING '+copy(rs.Fields[0].AsString,1,4)+'99999';
        end;
        rs.Next;
      end;
    case Factor.iDbType of
    1:result := result + 'PARTITION C9999 VALUES LESS THAN(MAXVALUE) )';
    4:result := result + ',ENDING MAXVALUE )';
    else
      Exit;
    end;
  finally
    rs.Free;
  end;
end;

end.
