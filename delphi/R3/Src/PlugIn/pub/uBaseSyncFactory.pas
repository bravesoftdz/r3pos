{------------------------------------------------------------------------------
  ������ϵͳ���ݣ������������Ԫ
    1�����ú�����
    2�����ݽṹ����
    3������
    
 ------------------------------------------------------------------------------}

unit uBaseSyncFactory;

interface

uses
  SysUtils, Windows, Variants, Classes, Forms, Dialogs, DB, zDataSet, zBase;

const
  //�����̲ݹ�Ӧ��ID:1000006
  NT_RELATION_ID=1000006;

type
  TConParam= Record
    DbType: integer;    //���ݿ�����
    RmServerIP: string; //Զ�̷�����IP
    PortNum: string;    //�˿ں�
    LogName: string;    //��½��
    LogPwd:  string;    //��½����
  end;

type
  TRunInfo=Record  
    BegTime: string;      //��ʼ�ϱ�ʱ���
    BegTick: integer;     //��ʼ�ϱ�GetTickCount
    AllCount: integer;    //�ϱ����ŵ���
    RunCount: integer;    //�ϱ��ɹ��ŵ���
    NotCount: integer;    //��Ӧ����[R3�ŵ�  �Բ���  Rim���ۻ�]
    ErrorCount: integer;  //�ϱ����ڴ����ŵ���
    ErrorStr: string;     //���д���Str
  end;


type
  TRimParams=Record
    ComID: string;      //RIM�̲ݹ�˾ID
    CustID: string;     //RIM���ۻ�ID
    TenID: string;      //R3�ϱ���ҵID
    TenName: string;    //R3�ϱ���ҵName
    ShopID: string;     //R3�ϱ��ŵ�ID
    ShopName: string;   //R3�ϱ��ŵ�����;
    LICENSE_CODE: string;  //���ۻ����֤��
    SHORT_ShopID: string;  //R3�ϱ��ŵ�ID��4λ
  end;

//������ϵͳ���ݶԽӵĽӿ�
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;
    //��ʼ����, ��ʱ���� ��λ��
    function BeginTrans(TimeOut:integer=-1;dbResoler:integer=0):integer; stdcall;
    //�ύ����
    function CommitTrans(dbResoler:integer=0):integer; stdcall;
    //�ع�����
    function RollbackTrans(dbResoler:integer=0):integer; stdcall;
    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer;dbResoler:integer=0):integer; stdcall;
    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;var Data:OleVariant;dbResoler:integer=0):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar;dbResoler:integer=0):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer;dbResoler:integer=0):integer;stdcall;
    //��������
    function DbLock(Locked:boolean;dbResoler:integer=0):integer;stdcall;
    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;
  end;

//�ŵ��ϱ���־
type
  TLogShopInfo=class
  private
    FRuniRet: integer;  //���ϱ���¼��
    FBegTickCount: integer; //��ʼ�ϱ�ʱ���
    FBegTime: string;   //��ʼ�ϱ�ʱ���
    FShopName: string;  //��ǰ�ϱ��ŵ�
    FErrorState: Boolean;  //ȫ��ִ�гɹ�״̬
    FBillList: TStringList;
    FLogKind: integer;
    FSyncType: integer; //�ϱ������б�
    function  GetTickTime: string;
    procedure SetLogKind(const Value: integer);
    procedure SetSyncType(const Value: integer);
  public
    constructor Create;
    destructor Destroy;override;
    procedure BeginLog(const ShopName: string); //��ʼ������
    //vType: 1:��ʾ�ɹ�; 0:��ʾ����;
    function AddBillMsg(BillName: string;iRect: integer=-1): Boolean;
    function SetLogMsg(SetList: TStringList; vNum: integer=0): Boolean; //������־����
    property RuniRet: integer read FRuniRet; //���и��ļ�¼��
    property ErrorState: Boolean read FErrorState; //����״̬[Ĭ��ΪFalse]
    property BillList: TStringList read FBillList;
    property LogKind: integer read FLogKind write SetLogKind;  //��־����[0:�򵥣�1:��ϸ]
    property SyncType: integer read FSyncType write SetSyncType;          //�ϱ���ʽ:��0: ����ִ�У� 3��ǰ̨����ִ��)    
  end;

//������ϵͳ���ݶԽӵĻ���
type
  TBaseSyncFactory=class
  private
    FPlugIntf: IPlugIn;
    FParams: TftParamList;
    FDbType: Integer;
    FLogList: TStringList;
    FHasError: boolean;
    FErrorMsg: string;
    FTWO_PHASE_COMMIT: Boolean;
    FKeepLogDay: integer;
    FLogKind: integer;
    FPlugInID: string;
    FdbResoler: Integer;
    procedure SetPlugIntf(const Value: IPlugIn);
    procedure SetParams(const Value: TftParamList);
    procedure SetDbType(const Value: Integer);
    procedure SetHasError(const Value: boolean);
    procedure SetErrorMsg(const Value: string);
    procedure SetTWO_PHASE_COMMIT(const Value: Boolean);
    function  GetUpdateTime: string;
    procedure SetKeepLogDay(const Value: integer);
    procedure SetLogKind(const Value: integer);
    procedure SetPlugInID(const Value: string);
    procedure SetdbResoler(const Value: Integer);
  public
    FRunInfo: TRunInfo; //��־��Ϣ
    constructor Create; virtual;
    destructor Destroy;override;
    function  CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; virtual; {==���أ�0ִ�гɹ�==}
    //�������ݿ�
    function  DBLock(Locked: Boolean):Boolean; //�������ݿ�����
    //�������ݿ�����
    function  GetDBType: integer;

    //�������
    function  BeginTrans(TimeOut:integer=-1): Boolean; //��ʼ����
    function  CommitTrans: Boolean;   //�ύ����
    function  RollbackTrans: Boolean; //�ع�����
    function  Open(DataSet: TDataSet):Boolean;  //ȡ����
    function  ExecSQL(SQL:Pchar;var iRet:integer):integer; overload;
    function  ExecSQL(SQLList: TStringList;var iRet:integer):integer; overload;
    function  GetLastError:string;  //����PlugIntf.GetLastError
    function  WriteLogFile(ErrMsg: string):Boolean; //д��PlugIntf.WriteLogFile
    function  GetLogHead: string; //��־ͷ��
    function  GetMsg(Msg: string): string; //������־���ͷ����ַ�����

    //�����ຯ��
    class function newId(id:string=''): string; //��ȡGUID
    class function newRandomId: string;        //����ʱ��+������ID
    class function GetTickTime: string;   //���ص�ǰʱ��
    class function OpenData(GPlugIn: IPlugIn; Qry: TZQuery;dbResoler:integer):Boolean;  //ȡ���ݣ���ʱ������ǰʹ�ã�
    class function GetCommStr(iDbType:integer;alias:string=''):string;
    class function GetUpCommStr(iDbType:integer;alias:string=''):string;
    class function GetTimeStamp(iDbType:Integer):string;   //����ʱ���
    class function GetDefaultUnitCalc(AliasTable: string=''): string;  //����ת����λID
    class function ParseSQL(iDbType:integer;SQL:string):string;    //ͨ�ú���ת��
    class function ReadConfig(Header,Ident,DefValue:string; IniFile: string=''):string;  //�������ļ�
    class function WriteConfig(Header,Ident,Value:string; IniFile: string=''):Boolean; //д�����ļ�

    //���Լ���������ʹ��
    property PlugInID: string read FPlugInID write SetPlugInID; //���ID��
    property KeepLogDay: integer read FKeepLogDay write SetKeepLogDay;  //��������ϱ���־����Ĭ�ϣ�30
    property LogKind: integer read FLogKind write SetLogKind;    //��־����[0:�򵥣�1:��ϸ]
    property LogHead: string read GetLogHead; //��־ͷ��
    
    //���ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase 3: access  4: db2
    property DbType:Integer read FDbType write SetDbType;
    property Params:TftParamList read FParams write SetParams;
    property PlugIntf: IPlugIn read FPlugIntf write SetPlugIntf;
    property LogList: TStringList read FLogList;
    property UpdateTime: string read GetUpdateTime; //���¸���ʱ��[YYYY-MM-DD_HH:MM:SS]
    property HasError: boolean read FHasError write SetHasError;   //��������Ƿ����
    property ErrorMsg: string read FErrorMsg write SetErrorMsg;    //������е�һ������Ϣ
    property TWO_PHASE_COMMIT: Boolean read FTWO_PHASE_COMMIT write SetTWO_PHASE_COMMIT; //�Ƿ����÷ֲ�ʽ����[Ĭ����������] [0:������]
    property dbResoler:Integer read FdbResoler write SetdbResoler;
  end;


//���ñ�������
var
  GPlugIn: IPlugIn;
  GLastError:string;

implementation

uses
  IniFiles;


{ TLogShopInfo }
constructor TLogShopInfo.Create;
begin
  FBillList:=TStringList.Create;
end;

destructor TLogShopInfo.Destroy;
begin
  FBillList.Free;
  inherited;
end;

//vType: 1:��ʾ�ɹ�; 0:��ʾ����;
function TLogShopInfo.AddBillMsg(BillName: string; iRect: integer): Boolean;
begin
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־

  if not FErrorState then
  begin
    FErrorState:=(iRect=-1);
  end;
  if iRect=-1 then
    FBillList.Add(BillName+'�ϱ�����')
  else
  begin
    if LogKind=1 then //��ϸ��־��д
      FBillList.Add(BillName+'�ϱ���'+inttoStr(iRect)+'��');
    FRuniRet:=FRuniRet+iRect;
  end;
end;

procedure TLogShopInfo.BeginLog(const ShopName: string);
begin
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־
  
  FShopName:=ShopName;
  FBegTime:=GetTickTime;
  FBegTickCount:=GetTickCount;
  FRuniRet:=0;
  FErrorState:=False;
  FBillList.Clear;
end;

function TLogShopInfo.SetLogMsg(SetList: TStringList; vNum: integer): Boolean;
var
  i: integer;
  isFirst: Boolean;
  Str,NumStr,TitleStr,ResutMsg: string;
begin
  result:=False;
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־
  
  isFirst:=False;
  if vNum=0 then NumStr:='    ' else  NumStr:='  ('+InttoStr(vNum)+')';
  if LogKind=1 then NumStr:=Copy(GetTickTime,4,8)+NumStr;  
  FBegTickCount:=GetTickCount-FBegTickCount;
  Str:='';
  TitleStr:=NumStr+'�ŵ�<'+FShopName+'>';
  if FErrorState then //û��ȫ���ϱ��ɹ�
    TitleStr:=TitleStr+'�����쳣����ͬ��<'+inttoStr(FRuniRet)+'>��;'
  else
    TitleStr:=TitleStr+'����������ͬ��<'+inttoStr(FRuniRet)+'>��;';

  if LogKind=1 then
    TitleStr:=TitleStr+' ���У�'+FormatFloat('#0.00',FBegTickCount/1000)+'��';

  case LogKind of
   1:
    begin
      if FBillList.Count=1 then
      begin
        TitleStr:=TitleStr+'    ��ϸ:'+trim(FBillList.Strings[0]);
        SetList.Add(TitleStr); 
      end else
      begin
        SetList.Add(TitleStr);  //��ӱ���
        for i:=0 to FBillList.Count-1 do
        begin
          if Str='' then
            Str:='('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]) 
          else
            Str:=Str+'; ('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]);
          if (i+1) mod 5 =0 then
          begin
            if not isFirst then
            begin
              Str:='    ��ϸ:'+Str;
              isFirst:=true;
            end else
              Str:='         '+Str;
            SetList.Add(Str);
            Str:='';
          end;
        end;
        if Str<>'' then
        begin
          if not isFirst then
            Str:='    ��ϸ:'+Str
          else
            Str:='         '+Str;
          SetList.Add(Str);
        end;
      end;
    end;
   else //��ģʽ
    begin
      for i:=0 to FBillList.Count-1 do
      begin
        if Str='' then
          Str:='('+InttoStr(i+1)+')'+trim(FBillList.Strings[i])
        else
          Str:=Str+'; ('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]);
      end;
      TitleStr:=TitleStr+Str;
      SetList.Add(TitleStr); 
    end;
  end;
  result:=true;
end;

function TLogShopInfo.GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(time(), Hour, Min, Sec, MSec);
  result:=FormatFloat('00',Hour)+':'+FormatFloat('00',Min)+':'+FormatFloat('00',Sec)+':'+FormatFloat('00',MSec);
end;

procedure TLogShopInfo.SetLogKind(const Value: integer);
begin
  FLogKind := Value;
end;

procedure TLogShopInfo.SetSyncType(const Value: integer);
begin
  FSyncType := Value;
end;

{ TBaseSyncFactory }

constructor TBaseSyncFactory.Create;
begin
  inherited;
  FHasError:=False;
  FErrorMsg:=''; 
  FParams := TftParamList.Create(nil);
  FLogList:= TStringList.Create;
  //��ȡ���ò���
  TWO_PHASE_COMMIT:=trim(ReadConfig('PARAMS','TWO_PHASE_COMMIT','1'))<>'0';
  KeepLogDay:=StrToInt(ReadConfig('PARAMS','KEEP_LOG_DAY','30'));
  LogKind:=StrToInt(ReadConfig('PARAMS','LOG_KIND','0'));
end;

function TBaseSyncFactory.DBLock(Locked: Boolean): Boolean;
var
  ErrMsg: string;
begin
  if Locked then
    ErrMsg:='�������ݿ����Ӵ���:'
  else
    ErrMsg:='�������ݿ����Ӵ���:'; 
  if PlugIntf.DbLock(Locked,dbResoler)<>0 then
    Raise Exception.Create(ErrMsg+GetLastError);
end;

function TBaseSyncFactory.GetDBType: Integer;
begin
  Result:=PlugIntf.iDbType(FDbType,dbResoler);
  if Result<>0 then
    Raise Exception.Create('�������ݿ����ʹ���'+GetLastError);
end;

destructor TBaseSyncFactory.Destroy;
begin
  FParams.Free;
  FLogList.Free;
  inherited;
end;

class function TBaseSyncFactory.newId(id: string): string;
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

class function TBaseSyncFactory.newRandomId: string;
var
  vRandvalue: integer;
  vHour, vMin, vSec, vMSec: Word;
begin
  DecodeTime(time(), vHour, vMin, vSec, vMSec);
  result:=FormatDatetime('YYYYMMDD',Date())+FormatFloat('00',vHour)+FormatFloat('00',vMin)+FormatFloat('00',vSec)+FormatFloat('000',vMSec);
  //��ȡ8λ�����
  vRandvalue:=0;
  while vRandvalue<9999999 do
  begin
    vRandvalue:=Random(99999999); //8λ
  end;
  result:=result+InttoStr(vRandvalue);

  //��ȡ7λ�����
  vRandvalue:=0;
  while vRandvalue<999999 do
  begin
    vRandvalue:=Random(8888888); //8λ
  end;
  result:=result+InttoStr(vRandvalue);
end;

class function TBaseSyncFactory.GetTimeStamp(iDbType: Integer): string;
begin
  case iDbType of
   0:Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
   1:Result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
   4:result := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
   //5:result := 'strftime(''%s'',''now'',''localtime'')-1293840000'; //û���޸�[��ʱδ�ҵ���Ӧ��������]
   else Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;


class function TBaseSyncFactory.GetDefaultUnitCalc(AliasTable: string): string;
var
  AliasTab: string;
begin
  if trim(AliasTable)<>'' then
    AliasTab:=trim(AliasTable)+'.';
  result:=
    'case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.00 '+             //Ĭ�ϵ�λΪ ������λ
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC*1.00 '+  //Ĭ�ϵ�λΪ С��λ
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC*1.00 '+      //Ĭ�ϵ�λΪ ��λ
        ' else 1.00 end ';                                                        //��������Ĭ��Ϊ����Ϊ1;
end;

class function TBaseSyncFactory.ParseSQL(iDbType: integer; SQL: string): string;
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

function TBaseSyncFactory.Open(DataSet: TDataSet): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  if DataSet.ClassNameIs('TZQuery') then //TZQuery
  begin
    try
      TZQuery(DataSet).Close;
      ReRun:=PlugIntf.Open(Pchar(TZQuery(DataSet).SQL.Text),vData,dbResoler);
      if ReRun<>0 then Raise Exception.Create(PlugIntf.GetLastError);
      TZQuery(DataSet).Data:=vData;
      Result:=TZQuery(DataSet).Active;
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('<Open>['+GetMsg(TZQuery(DataSet).SQL.Text)+'] Error��'+E.Message));
      end;
    end;
  end
end;

procedure TBaseSyncFactory.SetDbType(const Value: Integer);
begin
  FDbType := Value;
end;

procedure TBaseSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TBaseSyncFactory.SetPlugIntf(const Value: IPlugIn);
begin
   FPlugIntf := Value;
end;

function TBaseSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  
end;

function TBaseSyncFactory.BeginTrans(TimeOut: integer): Boolean;
begin
  result:=false;
  if PlugIntf.BeginTrans(TimeOut,dbResoler)<>0 then Raise Exception.Create('<��������> ����:'+GetLastError);
  result:=true;
end;

function TBaseSyncFactory.CommitTrans: Boolean;
begin
  result:=false;
  if PlugIntf.CommitTrans(dbResoler)<>0 then Raise Exception.Create('<�ύ����> ����:'+GetLastError);
  result:=true;
end;

function TBaseSyncFactory.RollbackTrans: Boolean;
begin
  result:=false;
  if PlugIntf.RollbackTrans(dbResoler)<>0 then Raise Exception.Create('<�ع�����> ����:'+GetLastError);
  result:=true;
end;

class function TBaseSyncFactory.GetCommStr(iDbType: integer; alias: string): string;
begin
  case iDbType of
   0: result := 'case when substring('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   3: result := 'case when mid('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   1,5:result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   4: result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  else
    result := '''00''';
  end;
end;


class function TBaseSyncFactory.GetUpCommStr(iDbType: integer; alias: string): string;
begin
  case iDbType of
   0: result := ' ''1''+substring('+alias+'COMM,2,1) ';
   3: result := ' ''1''+mid('+alias+'COMM,2,1) ';
   1,4,5:
      result := ' ''1'' || substr('+alias+'COMM,2,1) ';
  end;
end;

class function TBaseSyncFactory.GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(time(), Hour, Min, Sec, MSec);
  result:=FormatFloat('00',Hour)+':'+FormatFloat('00',Min)+':'+FormatFloat('00',Sec)+':'+FormatFloat('00',MSec);
end;

class function TBaseSyncFactory.OpenData(GPlugIn: IPlugIn; Qry: TZQuery;dbResoler:integer): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    Qry.Close;
    ReRun:=GPlugIn.Open(Pchar(Qry.SQL.Text),vData,dbResoler);
    if ReRun<>0 then Raise Exception.Create(GPlugIn.GetLastError);
    Qry.Data:=vData;
    Result:=Qry.Active;
  except
    on E:Exception do
    begin
      Raise Exception.Create(Pchar('PlugIntf.Open:('+Qry.SQL.Text+') ����'+E.Message));
    end;
  end;
end;


function TBaseSyncFactory.GetUpdateTime: string;
var
  vYear,vMonth,vDay,vHour,vMin, vSec,vMSec: Word;
begin
  DecodeDate(Date(), vYear, vMonth,vDay);
  result:=FormatFloat('0000',vYear)+'-'+FormatFloat('00',vMonth)+'-'+FormatFloat('00',vDay);  //10λ
  DecodeTime(Time(), vHour, vMin, vSec, vMSec);
  result:=result+' '+FormatFloat('00',vHour)+':'+FormatFloat('00',vMin)+':'+FormatFloat('00',vSec);
end;

procedure TBaseSyncFactory.SetHasError(const Value: boolean);
begin
  FHasError := Value;
end;

procedure TBaseSyncFactory.SetErrorMsg(const Value: string);
begin
  FErrorMsg := Value;
end;

procedure TBaseSyncFactory.SetTWO_PHASE_COMMIT(const Value: Boolean);
begin
  FTWO_PHASE_COMMIT := Value;
end;

class function TBaseSyncFactory.ReadConfig(Header,Ident,DefValue:string; IniFile: string=''): string;
var F: TIniFile; FileName: string; 
begin
  result:='';
  if trim(IniFile)='' then
    FileName:=ExtractFilePath(Application.ExeName)+'PlugIn.cfg';
  F:=TIniFile.Create(FileName);
  try
    result:=trim(F.ReadString(Header,Ident,DefValue));
  finally
    F.Free;
  end;
end;

class function TBaseSyncFactory.WriteConfig(Header,Ident,Value:string; IniFile: string=''): Boolean;
var F: TIniFile; FileName: string; 
begin
  result:=False;
  if trim(IniFile)='' then
    FileName:=ExtractFilePath(Application.ExeName)+'PlugIn.cfg';
  F:=TIniFile.Create(FileName);
  try
    F.WriteString(Header,Ident,Value);
    result:=true;
  finally
    F.Free;
  end;
end;

procedure TBaseSyncFactory.SetKeepLogDay(const Value: integer);
begin
  FKeepLogDay := Value;
end;

procedure TBaseSyncFactory.SetLogKind(const Value: integer);
begin
  FLogKind := Value;
end;

procedure TBaseSyncFactory.SetPlugInID(const Value: string);
begin
  FPlugInID := Value;
end;

procedure TBaseSyncFactory.SetdbResoler(const Value: Integer);
begin
  FdbResoler := Value;
end;

function TBaseSyncFactory.ExecSQL(SQL: Pchar; var iRet: integer): integer;
begin
  result := PlugIntf.ExecSQL(SQL,iRet,dbResoler);
  if result<>0 then
    Raise Exception.Create('<ExecSQL>['+GetMsg(StrPas(SQL))+']Error:'+GetLastError);
end;

function TBaseSyncFactory.ExecSQL(SQLList: TStringList;var iRet:integer):integer;
var
  SQLStr: string;
  i,ReRun,RunCount,vCount: integer;
begin
  result:=-1;
  vCount:=0;
  RunCount:=0;
  for i:=0 to SQLList.Count-1 do
  begin
    SQLStr:=trim(SQlList.Strings[i]);
    if SQlStr<>'' then
    begin
      iRet:=0;
      ReRun:=PlugIntf.ExecSQL(Pchar(SQLStr),vCount,dbResoler);
      if ReRun=0 then //����
      begin
        iRet:=iRet+vCount; //Ӱ������
        Inc(RunCount);  //�ۼ�������
      end else
      begin
        Raise Exception.Create('<ExecSQL>['+GetMsg(SQLStr)+']Error:'+GetLastError);  
      end;
    end;
  end;
  if RunCount=SQLList.Count then
    Result:=0;
end;

function TBaseSyncFactory.GetLastError: string;
begin
  result := StrPas(PlugIntf.GetLastError);
  if not HasError then //��Զֻ��¼��һ��������Ϣ
  begin
    HasError:=true;
    ErrorMsg:='[��]'+LogHead+'['+result+']';
  end;
end;


function TBaseSyncFactory.WriteLogFile(ErrMsg: string): Boolean;
begin
  if not HasError then //��Զֻ��¼��һ��������Ϣ
  begin
    HasError:=true;
    ErrorMsg:='[��]'+LogHead+'['+ErrMsg+']';
  end;  
  if PlugIntf.WriteLogFile(Pchar(LogHead+'['+ErrMsg+']'))<>0 then Raise Exception.Create(GetLastError);
end;

function TBaseSyncFactory.GetLogHead: string;
begin
  result:='';
  if PlugInID<>'' then
    result:='<'+PlugInID+'>';
  //�ж���ҵID�Ƿ�
  if Params.FindParam('TENANT_ID')<>nil then
    result:=result+'<'+Params.FindParam('TENANT_ID').AsString+'>';  
end;

function TBaseSyncFactory.GetMsg(Msg: string): string;
 function GetTempTableName(SQLMsg: string): string; //���Ǵ�����ʱ������ʱ����
 var i,j: integer; Str: string;
 begin
   Str:=UpperCase(SQLMsg);
   result:='';
   i:=Pos('TEMPORARY TABLE',Str);
   j:=Pos(UpperCase('session.'),Str);
   if (i>0) and (j>i) then
   begin
     i:=Pos('(',Str);
     result:='DECLARE GLOBAL TEMPORARY TABLE session.'+Copy(Str,j+8,i-1);
   end;
 end;
var
  vLen: integer; ReStr,SQLMsg: string;
begin
  result:=trim(SQLMsg);
  ReStr:='';
  SQLMsg:=trim(Msg);
  if LogKind=0 then  //����־����ǰ20���ַ�...
  begin
    vLen:=length(SQLMsg);
    if vLen<=120 then  //С��100���ַ�ȫ����־
      ReStr:=SQLMsg;
    if ReStr='' then
      ReStr:=GetTempTableName(SQLMsg);  //�ж��Ǵ�����ʱ��
    if ReStr='' then
      ReStr:=Copy(trim(SQLMsg),1,50)+' ... '+Copy(trim(SQLMsg),vLen-19,20);
    result:=ReStr;
  end;
end;


end.
