{
  Create Date: 2011.04.11 Pm
  ˵��:
    1�����ID: �Ƕ���ʵ��ĳ�����ܲ�����;
 }


library RimOrderDownPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase;

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

   
{$R *.res}
var
  GPlugIn:IPlugIn;
  GLastError:string;


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

function OpenData(PlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;
var
  vData: OleVariant;
begin
  result:=False;
  PlugIn.Open(Pchar(SQL),vData);
  if VarIsArray(vData) then
  begin
    Qry.Close;
    Qry.Data:=vData;
    Result:=Qry.Active;
  end;
end;

procedure SetRimCom_CustID(PlugIn: IPlugIn; ParamStr: string; var ComID: string; var CustID: string);
var
  vParam: TftParamList;
begin
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,ParamStr); 
    

  finally
    vParam.Free;
  end;
end;

function DownOrderToINF_StockOrder(PlugIn: IPlugIn; ParamStr: string): Boolean;
var
  iRet: integer;
  Str,NearDate,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //��ȡ���30��Ķ�������
  SetRimCom_CustID(PlugIn,ParamStr,ComID,CustID); //��ȡRimϵͳ�Ĺ�Ӧ�̣��̲ݹ�˾Com_ID�������ۻ���Cust_Id
  {== �м������Ϊ�ӿڣ���Ӧϵͳ���ã��˴�����: ������Ϊ��ѯ��ʾ�����б���ʾʹ�� ==}
  PlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where '+Cnd),iRet);
  Str:='insert into INF_INDEORDER (INDE_ID,CLIENT_ID,CUST_ID,INDE_DATE,INDE_AMT,INDE_MNY) '+
       ' select CO_NUM,COM_ID,CUST_ID,CRT_DATE,QTY_SUM,AMT_SUM from RIM_SD_CO '+
       ' where CRT_DATE>='''+NearDate+''' and COM_ID='''+vParam.ParamByName('COM_ID').AsString+''' and '+
       ' CUST_ID='''+vParam.ParamByName('CUST_ID').AsString+''' ';;
  PlugIn.ExecSQL(Pchar(Str),iRet);
  {== ����������ֱ�Ӹ��µ����� ������ ==}
  str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.CO_NUM=B.CO_NUM) '+
       ' where exists(select 1 from RIM_SD_CO_LINE C where A.CO_NUM=B.CO_NUM) ';
  PlugIn.ExecSQL(Pchar(Str),iRet);
end;
       
//RSPװ�ز��ʱ���ã�������ɷ��ʵķ���ӿ�
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//�����ִ�е����в���������� try except end �������ʱ���ɴ˷������ش���Ϣ
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//���ص�ǰ���˵��
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSPƽ̨����RIMϵͳ����';
end;

//����RIM���ض���������ȷ�ϣ��Ĳ��
function GetPlugInId:Integer; stdcall;
begin
  result := 1002;
end;

//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar):Integer; stdcall;
begin
  try
    //���ض���
     
    
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2001;
      end;
  end;
end;

//RSP���ò���Զ���Ĺ������,û��ʱֱ�ӷ���0
function ShowPlugin:Integer; stdcall;
begin
  try
    //��ʼ��ʾ�����洰��
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.
