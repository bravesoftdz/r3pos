{------------------------------------------------------------------------------
  ������ú�����Ԫ

  
 ------------------------------------------------------------------------------}
unit uPlugInUtil;

interface

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase;

const
  //�����̲ݹ�Ӧ��ID:1000006
  NT_RELATION_ID=1000006;
  
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;

    //��ʼ����, ��ʱ���� ��λ��
    function BeginTrans(TimeOut:integer=-1):integer; stdcall;
    //�ύ����
    function CommitTrans:integer; stdcall;
    //�ع�����
    function RollbackTrans:integer; stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer):integer; stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;var Data:OleVariant):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer):integer;stdcall;

    //��������
    function DbLock(Locked:boolean):integer;stdcall;
    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;
   end;

type
  TLogRunInfo=class
  public
    class procedure LogWrite(LogText: string; LogType: string='');
  end;


//���ñ�������
var
  GPlugIn:IPlugIn;
  GLastError:string;
 

//������ú���
function NewId(id:string=''): string; //��ȡGUID
function OpenData(GPlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;    //��ѯ����
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string; //����ĳ���ֶ�ֵ
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);  //������������
function GetTickTime: string;  //ȡ��ǰ��ȷʱ��

implementation

function NewId(id:string=''): string;
var
  g:TGuid;
begin
  if CreateGUID(g)=S_OK then
  begin
     result :=trim(GuidToString(g));
     result :=Copy(result,2,length(result)-2);  //ȥ��"{}"
  end else
     result :=id+'_'+formatDatetime('YYYYMMDDHHNNSS',now());
end;

function OpenData(GPlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    ReRun:=GPlugIn.Open(Pchar(SQL),vData);
    if (ReRun=0) and (VarIsArray(vData)) then
    begin
      Qry.Close;
      Qry.Data:=vData;
      Result:=Qry.Active;
    end else
    if ReRun<>0 then
      Exception.Create(SQL+'ִ���쳣��');
  except
    on E:Exception do
    begin
      Raise Exception.Create(Pchar('PlugIntf.Open:('+Qry.Name+') ����'+E.Message));
    end;
  end;
end;

//����ĳ���ֶ�ֵ
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string;
var
  FName: string;
  Rs: TZQuery;
begin
  result:='';
  try
    FName:=trim(FieldName);
    Rs:=TZQuery.Create(nil);
    OpenData(GPlugIn, Rs, SQL);
    if Rs.Active then
    begin
      if FName<>'' then
        result:=trim(Rs.FieldByName(FName).AsString)
      else
        result:=trim(Rs.Fields[0].AsString);
    end;
  finally
    Rs.Free;
  end;
end;

//���������������ݿ�����
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);
begin
  try
    GPlugIn.DbLock(Locked); //��������
  except
    on E:Exception do
    begin
      if Locked then
        Raise Exception.Create('�����������Ӵ���'+E.Message)
      else
        Raise Exception.Create('�����������Ӵ���'+E.Message);
    end;
  end;
end;

//ȡ��ǰ��ȷʱ��
function GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Now(), Hour, Min, Sec, MSec);
  result:=InttoStr(Hour)+':'+InttoStr(Min)+':'+InttoStr(Sec)+' '+inttoStr(MSec);
end;

{ TLogRunInfo }

{ �����ļ���[�ж���д��־�������־�ļ������: C:\Rsp\Log�� E:�̵�Rsp\Log  }
class procedure TLogRunInfo.LogWrite(LogText: string; LogType: string='');
const {==������˳�����������Ҳ�������־==}
  FilePathC='C:\Rsp\Log\debug.log';
  FilePathD='D:\Rsp\Log\debug.log';
  FilePathE='E:\Rsp\Log\debug.log';
var
  i: integer;
  FilePath, LogStr: string;
  StrList: TStringList;
begin
  FilePath:='';
  if FileExists(FilePathC) then FilePath:=FilePathC;
  if (FilePath='') and (FileExists(FilePathD)) then FilePath:=FilePathD;
  if (FilePath='') and (FileExists(FilePathE)) then FilePath:=FilePathE;
  if FilePath<>'' then
  begin
    try
      StrList:=TStringList.Create;
      StrList.LoadFromFile(FilePath);
      if StrList.Count>1000 then  //����1000�����������ɾ��
      begin
        for i:=400 to 1 do
          StrList.Delete(i);  
      end;
      LogStr:='���'+LogType+'  ����ʱ�䣺'+GetTickTime+'  '+LogText;
      StrList.Add(LogStr);
      StrList.SaveToFile(FilePath);
    finally
      StrList.Free;
    end;
  end;
end;

end.
