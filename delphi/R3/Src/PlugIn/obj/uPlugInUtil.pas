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

type
  TConParam= Record
    DbType: integer;    //���ݿ�����
    RmServerIP: string; //Զ�̷�����IP
    PortNum: string;    //�˿ں�
    LogName: string;    //��½��
    LogPwd:  string;    //��½����
  end;



//������ú���
function NewId(id:string=''): string; //��ȡGUID
function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;    //��ѯ����
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string; //����ĳ���ֶ�ֵ
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);  //������������
function ParseSQL(iDbType:integer;SQL:string):string;

{== ������ ==}
function GetTickTime: string;  //ȡ��ǰ��ȷʱ��[��ʱ]

//���ñ�������
var
  GPlugIn: IPlugIn;
  GLastError:string;

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

function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    Qry.Close;
    ReRun:=GPlugIn.Open(Pchar(Qry.SQL.Text),vData);
    if ReRun<>0 then Raise Exception.Create(Qry.SQL.Text+'ִ���쳣��');
    Qry.Data:=vData;
    Result:=Qry.Active;
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
    Rs.SQL.Text:=SQL;
    OpenData(GPlugIn, Rs);
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

function ParseSQL(iDbType:integer;SQL:string):string;
begin
  {==�ж�null�����滻����==}
  case iDbType of
  0:begin
     result := stringreplace(SQL,'ifnull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','isnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','isnull',[rfReplaceAll]);
    end;
  1:begin
     result := stringreplace(SQL,'ifnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'isnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','nvl',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','nvl',[rfReplaceAll]);
    end;
  4:begin
     result := stringreplace(SQL,'ifnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'isnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'nvl','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','coalesce',[rfReplaceAll]);
    end;
  5:begin
     result := stringreplace(SQL,'nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'isnull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','ifnull',[rfReplaceAll]);
    end;
  end;
  {== 2011.02.25 Add�ַ�����substring��substr�����滻���� [substring |substr| mid] ==}
  case iDbType of
   0,2: //Ms SQL Server | SYSBASE  [substring]
    begin
      result := stringreplace(result,'substr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substring(',[rfReplaceAll]);
    end;
   3:  //ACCESS
    begin
      result := stringreplace(result,'substr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'substring(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','mid(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE
    begin
      result := stringreplace(result,'substring(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substr(',[rfReplaceAll]);
    end;
  end;
  {==2011.02.25 Add�ַ����Ⱥ���len()��length�����滻���� [len |length|char_length] ==}
  case iDbType of
   0,3: //Ms SQL Server | Access [substring]
    begin
      result := stringreplace(result,'length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','len(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','len(',[rfReplaceAll]);
    end;
   2:  //SYSBASE [char_length] �ַ����ȣ��ֽڳ����ã�data_length��
    begin
      result := stringreplace(result,'length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','data_length(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE [length]  [Oracle�ֽڳ���:lengthb]
    begin
      result := stringreplace(result,'len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'LEN(','length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','length(',[rfReplaceAll]);
    end;
  end;    
end;

end.
