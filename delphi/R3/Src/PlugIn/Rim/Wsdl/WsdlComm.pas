unit WsdlComm;

interface
uses
  windows, SysUtils, Variants, Classes, EncdDecd,ZLib,ZDataSet;
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

   TRimCaTenant=record
     CustId:string;
     ComId:string;
     P_TENANT_NAME:string;
     P_TENANT_ID:string;
   end;

function decodeZipBase64(inXml:string):string;
function EncodeZipBase64(inXml:string):string;
function NewId(id:string): string;

//ͨ�����֤��ȡ��˾����
function GetRimInfo(tid,lsCode:string):TRimCaTenant;

var
  GPlugIn:IPlugIn;
  GLastError:string;
  url:string;

implementation

uses
  ZipUtils;

function NewId(id:string): string;
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


function GetRimInfo(tid,lsCode:string):TRimCaTenant;
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
var
  SQL: string;
  rs:TZQuery;
  vData: OleVariant;
  RimCaTen: TRimCaTenant;
begin
  RimCaTen.P_TENANT_ID:=tid;
  rs := TZQuery.Create(nil);
  try
    //ȡR3����ҵ����:
    SQL:='select TENANT_NAME from Ca_TENANT from TENANT_ID='+tid+' ';
    if OpenData(GPlugIn,Rs, SQL) then
      RimCaTen.P_TENANT_NAME:=Rs.Fields[0].AsString
    else
      Raise Exception.Create('ȡR3����ҵ���Ƴ���');

    //ȡRIM�̲ݹ�˾ID:
    SQL:= 'select A.ORGAN_ID from PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+tid+' ';
    if OpenData(GPlugIn,Rs, SQL) then
      RimCaTen.ComId:=Rs.Fields[0].AsString
    else
      Raise Exception.Create('ȡRim����ҵID����');

     SQL:= 'select CUST_ID from RM_CUST where COM_ID='''+RimCaTen.ComId+''' and LICENSE_CODE='''+lsCode+'''';
     if OpenData(GPlugIn,Rs, SQL) then
       RimCaTen.ComId:=Rs.Fields[0].AsString
     else
       Raise Exception.Create('ȡRim�����ۻ�ID����');
  finally
    rs.free;
  end;
end;
end.
