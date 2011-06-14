unit uGlobal;

interface
  //***************˵��****************************************//
  //  �����ݼ���Tag >0 ʱ��ϵͳΪ���軯COMMANDTEXT             //
  //                       ���������ݼ�                      //
  //  ��ȡ�������ݼ�ʱ������ݼ����ڹر�״̬��ϵͳ�Զ�OPEN     //
  //***********************************************************//
uses
  Windows,SysUtils, Classes,DB,ZdbFactory,ActnList,Controls,Graphics,jpeg,ZBase,ZDataSet;

type
  TGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FInstallDir: string;
    FDataDir: string;
    FSysDate: TDate;
    FRoles: string;
    FAccountName: string;
    FUserID:string;
    FUserName:string;
    FIsAxCall: Boolean;
    Fupgrade: boolean;
    FTENANT_ID: integer;
    FTENANT_NAME: string;
    FSHOP_ID: string;
    FSHOP_NAME: string;
    FSHORT_TENANT_NAME: string;
    FrspConnected: boolean;
    FRemoteFactory: TdbFactory;
    FLocalFactory: TdbFactory;
    { Private declarations }
    function  GetUserID: string;
    function  GetUserName: string;
    procedure SetUserID(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetDataDir(const Value: string);
    procedure SetInstallDir(const Value: string);
    //�ٹ��İ����ݼ����·��
    property  DataDir:string read FDataDir write SetDataDir;
    procedure SetSysDate(const Value: TDate);
    procedure SetRoles(const Value: string);
    procedure SetAccountName(const Value: string);
    procedure SetIsAxCall(const Value: Boolean);
    procedure Setupgrade(const Value: boolean);
    procedure SetTENANT_ID(const Value: integer);
    procedure SetSHORT_TENANT_NAME(const Value: string);
    procedure SetrspConnected(const Value: boolean);
    procedure SetLocalFactory(const Value: TdbFactory);
    procedure SetRemoteFactory(const Value: TdbFactory);
    function Getdebug: boolean;
  protected
    function GetSysDate: TDate;virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegSvr32(FileName:string);

    procedure GlobalAtteProc(ClassName:string;pTag:Integer;Var IsTrue:Boolean);virtual;
    function  GlobalAtteExts(AtteID:string):String;virtual;

    //���ڴ򿪻������ϡ�
    procedure LoadBasic(Saveed:Boolean=false;Opened:Boolean=true);virtual;

    function GetSrvDateTime:TDatetime;

    Function  RefreshTable(Name:String):Boolean;
    procedure CloseAll;

    function DataSetByName(Name:string):TDataSet;

    function GetZQueryFromName(Name:string):TZQuery;

    procedure Connect;

    //���������
    procedure MoveToLocal;
    procedure MoveToRemate;

    //�û�Acount
    property UserID:string read GetUserID write SetUserID;
    //�û���user_name
    property UserName:string read GetUserName write SetUserName;
    //��ҵ���    
    property TENANT_ID:integer read FTENANT_ID write SetTENANT_ID;
    //��ҵ����
    property TENANT_NAME:string read FTENANT_NAME write FTENANT_NAME;
    //��ҵ���
    property SHORT_TENANT_NAME:string read FSHORT_TENANT_NAME write SetSHORT_TENANT_NAME;
    //�ŵ����
    property SHOP_ID:string read FSHOP_ID write FSHOP_ID;
    //�ŵ�����
    property SHOP_NAME:string read FSHOP_NAME write FSHOP_NAME;
    //ְ����� �����","�ŷָ�
    property Roles:string read FRoles write SetRoles;

    //ϵͳEXE�ļ���װ·����ע·������Ǵ� '\'��;
    property InstallPath:string read FInstallDir write SetInstallDir;
    property SysDate:TDate read GetSysDate write SetSysDate;
    //��ǰ��¼������
    property AccountName:string read FAccountName write SetAccountName;
    property IsAxCall:Boolean read FIsAxCall write SetIsAxCall;
    property upgrade:boolean read Fupgrade write Setupgrade;
    //�Ƿ�������RSP��������
    property rspConnected:boolean read FrspConnected write SetrspConnected;
    //��������
    property LocalFactory:TdbFactory read FLocalFactory write SetLocalFactory;
    //Զ������
    property RemoteFactory:TdbFactory read FRemoteFactory write SetRemoteFactory;
    //�Ƿ����ģʽ
    property debug:boolean read Getdebug;
  end;
  
function CopyScreen(SaveAndFree:Boolean=True): TBitmap;
Var
  Global:TGlobal;//ȫ�ֹ�����������ģ��
  Factor:TdbFactory;//���ݿ����Ӵ������
  sysLogFile:Boolean;
  lckStr:string;
  //���ݿ�汾 DB5.0.0.3
  DBVersion:string;
  //����汾 .NET ���߰� .LCL ������ 
  SFVersion:string;
  //��ҵ�汾 1.FIG ��װ�� 2.MKT ���а�  3.OHR ��׼��  4.DLI ʳƷҵ
  CLVersion:string;
  //��Ʒ����
  ProductID:string;
implementation
uses Forms,IniFiles,ufrmLogo;
{$R *.dfm}
var
  whKeyboard: HHook;
  MsgString:string;

procedure SetPath;
var
  cur_path:string;
  lib_path:string;
begin
  cur_path:=GetEnvironmentVariable('path');
  Lib_path := ExtractFilePath(Application.ExeName);
  cur_path := cur_path +';'+ Lib_path;
  SetEnvironmentVariable('path',pchar(cur_path));
end;
function GetModuleHandleFromInstance: THandle;
var
  s: array[0..512] of char;
begin
  GetModuleFileName(hInstance, s, sizeof(s) - 1);
  Result := GetModuleHandle(s);
end;
function CopyScreen(SaveAndFree:Boolean=True): TBitmap;
var
   winHWND, hCur:integer;
   winDC:integer;
   rect:TRect;
   pt:TPoint;
   fBitmap:TBitmap;
   FileName:string;
   jpg:TJpegImage;
//   sm:TMemoryStream;
begin
   if MsgString<>'' then Exit;
   Result := nil;
   hCur := GetCursor(); // �� �� �� �� �� ��
   GetCursorPos(pt); // �� ¼ �� �� λ ��
   winHWND := GetDesktopWindow();
   winDC := GetDC(winHWND);
   GetWindowRect(winHWND, rect);
   fBitmap := TBitmap.create;
   fBitmap.width := rect.right-rect.left;
   fBitmap.height := rect.bottom-rect.top;
   BitBlt(fBitmap.canvas.handle, 0, 0, fBitmap.width, fBitmap.height, winDC, 0, 0, SRCCOPY);
   DrawIcon(fBitmap.canvas.handle, pt.x, pt.y, hCur); // �� �� ��
   ReleaseDC(winHWND, winDC);
   Result := fBitmap;
   if SaveAndFree then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName)+'Error');
        FileName := ExtractFilePath(Application.ExeName)+'Error\E'+FormatDatetime('YYYYMMDD_HHNNSS',Now())+'.jpg';
        try
          jpg := TJpegImage.Create;
          //sm  := TMemoryStream.Create;
          try
            //sm.Position := 0;
            //Result.SaveToStream(sm);
            //sm.Position := 0;
            jpg.CompressionQuality := 80;
            jpg.Assign(Result);
            //jpg.LoadFromStream(sm);
            jpg.SaveToFile(FileName);
          finally
            //sm.Free;
            jpg.Free;
          end;
        except
          Result.Free;
          MsgString := '������Ļ��'+FileName+'ʧ�ܣ�����������ļ������ԡ�';
          Application.MessageBox(Pchar(MsgString),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
          MsgString := '';
          Exit;
        end;
        Result.Free;
        MsgString := '������Ļ��'+FileName+'�ɹ���';
        Application.MessageBox(Pchar(MsgString),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
        MsgString := '';
      end;
end;

{$IFDEF WIN32}

function KeyboardHookCallBack(Code: integer; Msg: WPARAM;
  KeyboardHook: LPARAM): LRESULT; stdcall;
{$ELSE}

function KeyboardHookCallBack(Code: integer; Msg: word;
  KeyboardHook: longint): longint; export;
{$ENDIF}
const LLKHF_ALTDOWN = $20;
begin
  Result := 0;
  if Code<0 then
  begin
    Result:=CallNextHookEx(0, Code, Msg, KeyboardHook);
    Exit;
  end;

  if ((GetKeyState(VK_CONTROL) and $8000) <> 0) and ((GetKeyState(VK_SHIFT) and $8000) <> 0) and ((Msg = ORD('P')) or (Msg = ORD('p'))) then
     begin
       Result := 1;
       CopyScreen(True);
       Exit;
     end;
  
  if Code >= 0 then
     Result := CallNextHookEx(whKeyboard, Code, Msg, KeyboardHook);
end;

constructor TGlobal.Create(AOwner: TComponent);
begin
  inherited;
  upgrade := false;
  FSysDate := 0;
  whKeyboard := SetWindowsHookEx(WH_KEYBOARD, KeyboardHookCallBack,
    GetModuleHandleFromInstance,
  GetCurrentThreadID);
  SetPath;
  IsAxCall := false;
  LocalFactory := TdbFactory.Create;
  RemoteFactory := TdbFactory.Create;
  Factor := LocalFactory;
end;

destructor TGlobal.Destroy;
begin
  UnhookWindowsHookEx(whKeyboard);
  LocalFactory.free;
  RemoteFactory.free;
  inherited;
end;

procedure TGlobal.LoadBasic(Saveed:Boolean=false;Opened:Boolean=true);
var i:Integer;
begin
  frmLogo.Label1.Caption := '��ʼ������,���Ժ�...';
  frmLogo.Label1.Update;
  frmLogo.ProgressBar1.Max := ComponentCount;
  for i:=0 to ComponentCount -1 do
    begin
      frmLogo.ProgressBar1.Position := i;
      if Components[i] Is TZQuery then
         begin
           Sleep(0);
           TZQuery(Components[i]).Close;
           TZQuery(Components[i]).Filtered := false;
           if TZQuery(Components[i]).Params.FindParam('SHOP_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('SHOP_ID').AsString := SHOP_ID;
           if TZQuery(Components[i]).Params.FindParam('SHOP_ID_ROOT')<>nil then
              TZQuery(Components[i]).Params.FindParam('SHOP_ID_ROOT').AsString := inttostr(TENANT_ID)+'0001';
           if TZQuery(Components[i]).Params.FindParam('TENANT_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('TENANT_ID').AsInteger := TENANT_ID;
           if TZQuery(Components[i]).Params.FindParam('USER_ID')<>nil then
              TZQuery(Components[i]).Params.FindParam('USER_ID').AsString := UserId;
           if Components[i].Tag >0 then Continue;
           if Factor.Connected then
              begin
                if Opened then
                   begin
                     Factor.Open(TZQuery(Components[i]));
                   end;
              end
           else
              Raise Exception.Create('û�д����ݿ����ӡ�');
         end;
    end;
end;

function TGlobal.RefreshTable(Name: String): Boolean;
var
  i:Integer;
  SQL:string;
begin
  Result := False;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
         begin
          if  (Components[i] Is TZQuery) and TZQuery(Components[i]).Active then
             begin
               Sleep(0);
               if TZQuery(Components[i]).SQL.Text ='' then
                  Raise Exception.CreateFmt('%s��SQL����Ϊ�ա�',[TZQuery(Components[i]).Name]);
               TZQuery(Components[i]).Close;
               TZQuery(Components[i]).Filtered := false;
               if Factor.Connected then
                  begin
                    Factor.Open(TZQuery(Components[i]));
                  end;
             end;
          exit;
         end;
    end;
  Raise Exception.CreateFmt('%s���ݱ�û�ҵ���',[Name]);
end;

procedure TGlobal.DataModuleCreate(Sender: TObject);
begin
  InstallPath := ExtractShortPathName(ExtractFilePath(Application.ExeName));
  DataDir    := 'temp';
  if not DirectoryExists(InstallPath+DataDir) then
     CreateDir(InstallPath+DataDir);
  Global := Self;
  SysDate := Date();
end;

{ TAtteCenter }

function TGlobal.GetUserID: string;
begin
 Result:= FUserID;

end;

function TGlobal.GetUserName: string;
begin
 Result:= FUserName;
end;

procedure TGlobal.SetUserID(const Value: string);
begin
  FUserID := Value;
end;

procedure TGlobal.SetUserName(const Value: string);
begin
  FUserName := Value;

end;

function TGlobal.DataSetByName(Name: string): TDataSet;
var i:Integer;
begin
  Result := nil;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
          begin
            Result := TDataSet(Components[i]);
            Exit;
          end;
    end;
end;

procedure TGlobal.SetDataDir(const Value: string);
begin
  FDataDir := Value;
end;

procedure TGlobal.SetInstallDir(const Value: string);
begin
  FInstallDir := Value;
end;

procedure TGlobal.SetSysDate(const Value: TDate);
begin
  FSysDate := Value;
end;


procedure TGlobal.SetRoles(const Value: string);
begin
  FRoles := Value;
end;

procedure TGlobal.SetAccountName(const Value: string);
begin
  FAccountName := Value;
end;


procedure TGlobal.GlobalAtteProc(ClassName: string; pTag: Integer;
  var IsTrue: Boolean);
begin
  IsTrue := True;
end;

function TGlobal.GlobalAtteExts(AtteID: string): String;
begin
  Result := '';
end;

procedure TGlobal.CloseAll;
var i:Integer;
begin
  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] Is TDataSet then
         TDataSet(Components[i]).Close;
    end;
end;
function TGlobal.GetSrvDateTime: TDatetime;
var Temp:TZQuery;
  s:string;
begin
  Temp := TZQuery.Create(nil);
  try
    case Factor.iDbType of
    0:Temp.SQL.Text :='select GetDate() ';
    1:Temp.SQL.Text := 'select SysDate from Dual';
    3:Temp.SQL.Text :='select Date() ';
    5:Temp.SQL.Text :='select Date() ';
    end;
    Factor.Open(Temp);
    s := formatDatetime('YYYYMMDD',Temp.Fields[0].AsDateTime);

    result := EncodeDate(StrtoInt(copy(s,1,4)),StrtoInt(copy(s,5,2)),StrtoInt(copy(s,7,2)));
  finally
    Temp.Free;
  end;
end;

function TGlobal.GetSysDate: TDate;
begin
  if FSysDate = 0 then
     result := Date()
  else
     result := FSysDate;
end;

procedure TGlobal.RegSvr32(FileName: string);
var
  dllHandle:THandle;
  RegisterServer:function(): HResult; stdcall;
begin
  if not FileExists(FileName) then Exit;
  dllHandle := LoadLibrary(Pchar(FileName));
  try
  if dllHandle>0 then
     begin
       @RegisterServer := GetProcAddress(dllHandle, 'DllRegisterServer');
       if @RegisterServer<>nil then
          if RegisterServer<>S_OK then
             begin
               MessageBox(Application.Handle,Pchar('ע��'+FileName+'ʧע������:'+Inttostr(GetLastError)+';�����в��ݹ����޷�ʹ��'),'������ʾ...',MB_OK+MB_ICONINFORMATION);
             end;
     end;
  finally
     FreeLibrary(dllHandle);
  end;
end;

procedure TGlobal.SetIsAxCall(const Value: Boolean);
begin
  FIsAxCall := Value;
end;

procedure TGlobal.Setupgrade(const Value: boolean);
begin
  Fupgrade := Value;
end;

function TGlobal.GetZQueryFromName(Name: string): TZQuery;
begin
  Result := TZQuery(DataSetByName(Name));
  if Result = nil then
     Raise Exception.CreateFmt('%s���ݱ�û�ҵ���',[Name]);
  if not Result.Active then
     begin
       if TZQuery(Result).Params.FindParam('SHOP_ID')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID').AsString := SHOP_ID;
       if TZQuery(Result).Params.FindParam('SHOP_ID_ROOT')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID_ROOT').AsString := inttostr(TENANT_ID)+'0001';
       if TZQuery(Result).Params.FindParam('TENANT_ID')<>nil then
          TZQuery(Result).Params.FindParam('TENANT_ID').AsInteger := TENANT_ID;
       if TZQuery(Result).Params.FindParam('USER_ID')<>nil then
          TZQuery(Result).Params.FindParam('USER_ID').AsString := UserId;
       Factor.Open(Result);
     end;
  if Result.Filtered then Result.Filtered := false;
  Result.CommitUpdates;
end;

procedure TGlobal.SetTENANT_ID(const Value: integer);
begin
  FTENANT_ID := Value;
end;

procedure TGlobal.SetSHORT_TENANT_NAME(const Value: string);
begin
  FSHORT_TENANT_NAME := Value;
end;

procedure TGlobal.SetrspConnected(const Value: boolean);
begin
  FrspConnected := Value;
end;

procedure TGlobal.SetLocalFactory(const Value: TdbFactory);
begin
  FLocalFactory := Value;
end;

procedure TGlobal.SetRemoteFactory(const Value: TdbFactory);
begin
  FRemoteFactory := Value;
end;

procedure TGlobal.Connect;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  try
    if Factor=LocalFactory then
       begin
         if not FileExists(Global.InstallPath+'data\r3.db') then CopyFile(pchar(Global.InstallPath+'\sqlite.db'),pchar(Global.InstallPath+'data\r3.db'),false);
         Factor.Initialize('provider=sqlite-3;databasename='+Global.InstallPath+'data\r3.db');
       end
    else
       Factor.Initialize(F.ReadString('db','Connstr',''));
    Factor.Connect;
  finally
    F.Free;
  end;
end;

procedure TGlobal.MoveToLocal;
begin
  Factor := LocalFactory;
end;

procedure TGlobal.MoveToRemate;
begin
  Factor := RemoteFactory;
end;

function TGlobal.Getdebug: boolean;
begin
  result := FindCmdLineSwitch('DEBUG',['-','+'],false);
end;

initialization
  Global := nil;
  sysLogFile := true;
finalization
end.
