//***********************************************************//
//        ���:��ɭ��     ���룺��ɭ��
//        �汾:5.0        �޸�����:2011-01-10
//        R3��Ŀ��
//***********************************************************//
unit ZIntf;           

interface
uses Classes,SysUtils,Windows,DB,Variants,ZSqlStrings;
type
IZFactory = Interface;
IdbHelp = Interface(IUnknown)
    ['{E66321DF-7462-4FAF-B612-2D4A3B0E103F}']
    //�������Ӳ���
    function  Initialize(Const ConnStr:WideString):boolean;stdcall;
    //��ȡ���Ӵ�
    function  GetConnectionString:WideString;stdcall;
    //�������ݿ�
    function  Connect:boolean;stdcall;
    //���ͨѶ����״̬
    function  Connected:boolean;stdcall;
    //�ر����ݿ�
    function  DisConnect:boolean;stdcall;
    
    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //�ύ����
    procedure CommitTrans;stdcall;
    //�ع�����
    procedure RollbackTrans;stdcall;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;stdcall;

    //���ݼ�ִ��Query ����ִ��Ӱ���¼��
    function ExecQuery(DataSet:TDataSet):Integer;stdcall;
    //�ͻ����ж�����
    function KillDBConnect:Integer;stdcall;
   end;

IdbDllHelp = Interface(IUnknown)
    ['{E66321DF-7462-4FAF-B612-2D4A3B0E103F}']
    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //�ύ����
    procedure CommitTrans;stdcall;
    //�ع�����
    procedure RollbackTrans;stdcall;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function OpenSQL(SQL:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    function OpenNS(NS:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(ds:OleVariant;NS:WideString;Params:WideString):boolean;OverLoad;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString):Integer;stdcall;
    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(NS:String;Params:WideString):pchar;stdcall;

    procedure BeginBatch; stdcall;
    procedure AddBatch(ds:OleVariant;const ns: WideString; const Params: WideString); stdcall;
    function OpenBatch: OleVariant; stdcall;
    procedure CommitBatch; stdcall;
    procedure CancelBatch; stdcall;
   end;

IZFactory= interface(IUnknown)
  ['{CC9E0F51-22D6-46DD-A3D9-D8B1D0A0A13A}']
    //��ʼ������
    procedure PSInitialize;stdcall;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function PSBeforeOpenRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //��¼�м�������⺯��������ֵ˵�� =0��ʾִ�гɹ� ����Ϊ������� �����������ǰ��¼
    function PSBeforeInsertRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //��¼�м��޸ļ�⺯��������ֵ˵�� =0��ʾִ�гɹ� ����Ϊ������� ������޸ĵ�ǰ��¼
    function PSBeforeModifyRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //��¼�м�ɾ����⺯��������ֵ˵�� =0��ʾִ�гɹ� ����Ϊ������� �����ɾ����ǰ��¼
    function PSBeforeDeleteRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //��ʹ�ô��¼�,Applied ����true ʱ������������⺯����Ч�����и����ݿ��߼����ɴ˺�����ɡ�����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function PSBeforeUpdateRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //���м�¼������Ϻ�,�����ύ��ǰִ�С�����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function PSBeforeCommitRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;

  end;

IzProcFactory= interface(IUnknown)
  ['{368F6663-5E4F-41B5-A620-16A07C5DDD22}']
    function PSExecute(AGlobal:IdbHelp;HasResult:Boolean):Boolean;stdcall;
    function PSGetOutMessage:WideString;stdcall;
    function PSGetOutData:OleVariant;stdcall;
  end;
  
implementation
end.
