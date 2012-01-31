
//#define LCCONTROLDLL_API __declspec(dllexport)
#define LCCONTROLDLL_API extern "C" _declspec(dllexport)


//����LocalConnection.
//����:��������.
//����ֵ:0:�ɹ� 1:���������߳�ʧ�� 2:�Ѵ���ͬ����LC  3:����Ϊδ֪�쳣
LCCONTROLDLL_API int __stdcall LC_Create(char*szName);

//�ر�LocalConnection
//����:��������
//����ֵ:0:û���ҵ� 1:�ҵ��˲�ȡ��ע��ɹ� ;  ����Ϊ�쳣��ʧ��
LCCONTROLDLL_API int __stdcall LC_Close(char* szName);

//��ĳ��LC����1�������ķ�������
//����:��������,������,����1
//����ֵ:0:���ͳɹ� 1:��ȡMutexʧ�� 2:�ȴ�4����û�ȵ������� 3:û���ҵ����LC  4:��������û��ʹ�õ�����,ǿ��д������ ����Ϊ�����쳣
LCCONTROLDLL_API int __stdcall LC_Send(char *szName,char *szMethod,char *para1);

//��ĳ��LC����2�������ķ�������
//����:��������,������,����1,����2
//����ֵ:0:���ͳɹ� 1:��ȡMutexʧ�� 2:�ȴ�4����û�ȵ������� 3:û���ҵ����LC  4:��������û��ʹ�õ�����,ǿ��д������ ����Ϊ�����쳣
LCCONTROLDLL_API int __stdcall LC_Send2(char *szName,char *szMethod,char *para1,char *para2);

//��ĳ��LC����3�������ķ�������
//����:��������,������,����1,����2,����3:
//����ֵ:0:���ͳɹ� 1:��ȡMutexʧ�� 2:�ȴ�4����û�ȵ������� 3:û���ҵ����LC  4:��������û��ʹ�õ�����,ǿ��д������ ����Ϊ�����쳣
LCCONTROLDLL_API int __stdcall LC_Send3(char *szName,char *szMethod,char *para1,char *para2,char *para3);

//�رչ����߳�
LCCONTROLDLL_API void __stdcall LC_FreeLibrary();

//ע��һ����������ص�����
LCCONTROLDLL_API int __stdcall LC_MethodRegister(char *szLcName,char*szMethodName,int funcCallBack);

//֧��string��bytearray�����ݵĽӿ�
LCCONTROLDLL_API int __stdcall LC_NSend(char *szName,char *szMethod,int vt,void *pData,int len);

