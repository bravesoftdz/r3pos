//***********************************************************//
//        ���:��ɭ��     ���룺��ɭ��
//        �汾:5.0        �޸�����:2011-01-10
//        R3��Ŀ��
//***********************************************************//
unit ZConst;

interface
uses Windows,Messages;
resourcestring
  SIdInvalidToken = '������Ч��Token:%d';
  SIdInvalidConnectionString = '��Ч�����ַ���:%s';
  SIdInvalidSocketConnection = ' ��Ч�� Socket ����';
  SIdInvalidConnectID = '��Ч����ID��:%d';
  SIdInvalidServerGuid = 'û��ע���COM��� CLSID:%s';
  SIdInvalidFlags = '��Ч�� Flags:%d';

  SIdInvalidDataSet = '��֧�����ݼ�����';

  SIdInvalidDataBaseType = '��֧�ֵ����ݿ�����';
  SIdInvalidDataBlock = '��Ч��DataBlock����nil';
  SIdInitADOError = '��ʼ�� ADO ���Դ���';
  SIdNotSupportFunction = '%s ��֧�ַ���';
  SIdNotSupportObjectClassType = '%s ��֧�ֵ�ObjectFactoryClassType';
  SIdParameterNotNull = '%s ����������null';
  SIdInvalidParameterType = '%s ��֧�ֵĲ�����ֵ����';
  SIdParameterNotfound = '%s ����û�б��ҵ�';

  SIdDataSetNotNull = '%s�����DataSet���Բ���Ϊnil';
  SIdNotSupportCombinationType = '%s ��֧�ֵ�DataSet�������';

  SIdObjectNotRegistry = '%s ����û�б�ע��';
  SIdQuarrelWith = '�������ܾ�����%s����';
  SIdVssCheckedInvalid = '�޷�ͨ������˵�VSS��ȫ��֤.';

  SIdUndefinedError= 'δ����Ĵ�������';
  SIdDisconnection = '�����Ѿ��Ͽ�������������,���������Ƿ���������Ϊ�ж�';

  SIdNotAffectRecord = '���¼�¼��Ϊ��,�Ƿ���һ�û�����';
  SIdCheckValidityError = 'ִ��%s������Ϸ��Դ���';
  SIdObjectTypeDiffer = '�ͻ��˸������������Ͳ�һ��';
  SIdNotAccessCloseDataSet = '���ܲ����رյ����ݼ���';
  SIdParamterParseError = '������Ϥ����';

  SIdSessionNotFound = 'û�ҵ�����Session';
  SIdSessionMaxCount = '�������û���Ϊ%d,��������û�����͹�Ӧ����ϵ';

const
  //������־�䶯��Ϣ
  WM_LOGFILE_UPDATE=WM_USER+20;
  //�����̱߳䶯��Ϣ
  WM_WORK_THREAD_UPDATE=WM_USER+21;
  //�ͻ��˶Ի��䶯��Ϣ
  WM_SESSION_UPDATE=WM_USER+22;
  //���ӳر䶯��Ϣ
  WM_DB_CACHE_UPDATE=WM_USER+23;
  //������
var
  MainFormHandle:THandle;
  StartServiceTickCount:int64;
implementation

initialization
  StartServiceTickCount := GetTickCount;
  MainFormHandle := 0;
end.
