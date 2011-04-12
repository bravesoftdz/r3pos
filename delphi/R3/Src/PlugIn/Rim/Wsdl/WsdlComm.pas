unit WsdlComm;

interface
uses windows,SysUtils,Classes,EncdDecd,ZLib,ZDataSet;
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;

    //��ʼ����  ��ʱ���� ��λ��
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

function decodeZipBase64(inXml:string):string;
function EncodeZipBase64(inXml:string):string;

//ͨ�����֤��ȡ��˾����
function GetOrgId(lsCode:string):string;
function GetComId(lsCode:string):string;

var
  GPlugIn:IPlugIn;
  GLastError:string;
  url:string;
implementation
uses ZipUtils;
function EncodeZipBase64(inXml:string):string;
var
  ism:TStringStream;
  zsm:TMemoryStream;
  osm:TStringStream;
begin
  ism := TStringStream.Create(inXml);
  osm := TStringStream.Create('');
  zsm := TMemoryStream.Create;
  try
    ism.Position := 0;
    if not ZipStream(ism,zsm) then Raise Exception.Create('ѹ��������ʧ��...');
    zsm.Position := 0;
    EncodeStream(zsm,osm);
    osm.Position := 0;
    result := '#zip#'+osm.DataString;
  finally
    osm.Free;
    zsm.Free;
    ism.Free;
  end;
end;
function decodeZipBase64(inXml:string):string;
var
  ism:TStringStream;
  zsm:TMemoryStream;
  osm:TStringStream;
begin
  if copy(inXml,1,5)='#zip#' then
  begin
    delete(inxml,1,5);
    ism := TStringStream.Create(inXml);
    osm := TStringStream.Create('');
    zsm := TMemoryStream.Create;
    try
      DecodeStream(ism,zsm);
      zsm.Position := 0;
      if not UnZipStream(zsm,osm) then Raise Exception.Create('��ѹ������ʧ��...');
      osm.Position := 0;
      result := osm.DataString;
    finally
      osm.Free;
      zsm.Free;
      ism.Free;
    end;
  end
  else
     result := inXml;
end;
function GetOrgId(lsCode:string):string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
  finally
    rs.free;
  end;
end;
function GetComId(lsCode:string):string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
  finally
    rs.free;
  end;
end;
end.
