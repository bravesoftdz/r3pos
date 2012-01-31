#pragma once

#include <atlbase.h>
#include <atlstr.h>
#include <comutil.h>
#include <atlfile.h>
#include <atltime.h>
#include <list>
#include <vector>
using namespace std;


#ifndef NO_TRACE_FUNC
#define NO_TRACE_FUNC
void notrace(...);
#endif //NO_TRACE_FUNC

#define MYTRACE	ATLTRACE
//#define MYTRACE notrace

#define LC_FILEMAP_NAME _T("MacromediaFMOmega")
#define LC_MUTEXT_NAME  _T("MacromediaMutexOmega")
#define LC_DOMAIN_NAME  _T("localhost")

#define LC_LEN_HEADER 16
#define LC_LEN_MESSAGE 40960
#define LC_POS_LISTENERS LC_LEN_HEADER+LC_LEN_MESSAGE


#define SINGLE_WAIT_TIMEOUT 10
#define SLEEP_TIME			40

//�Ƿ������־
//#define WRITE_LOG

class CAMFStream
{
public:
	CAMFStream(void);
	~CAMFStream(void);
	unsigned short ReadU16(byte* pBuff);
	LPTSTR ReadString(byte* pBuff, short len);
	double ReadNumber64(byte*pBuff);
	int WriteStringH(byte* pBuff, CString szInfo, int& len);
	// ��������
	int ReadInt29(byte* pBuff, int& numLen);
	bool WriteInt29(byte* pBuff, unsigned int intVal, int& numLen);
	int WriteString(byte* pBuff, CString szInfo, int& len);
};

//����ÿ��LC��Ӧ��HWND
class LCINFO
{
public:
	LCINFO(char *pszName,HWND hWnd)
	{
		m_szName.Format("%s",pszName);
		m_hWnd = hWnd;
	}
	HWND	m_hWnd;
	CString	m_szName;
};

class CRegistedLC
{
public:
	CRegistedLC()
	{
		m_szVal1.Format("%s","::4");
		m_szVal2.Format("%s","::6");
	}
	CString	m_szName;
	CString m_szVal1;
	CString m_szVal2;
};

struct Header
{
	DWORD a;
	DWORD b;
	DWORD tickCount;
	DWORD msgLen;
};

class CLogModule
{
public:
	CLogModule();
	~CLogModule();
	void OutputLog(char* info,...);
	//���������־
	//

	void OpenLogFile(void);
	void CloseLogFile(void);
	void OutputLog2File(const char* info);
	// ���ָ�����������ݵ�16���Ʊ�ʾ
	void OutputLogHex(byte* pBuff, int len);
	CString trans2String(BYTE bval);
	inline void SetBoolWriteLog(bool blWriteLog)
	{
		m_cs.Lock();
		m_blWriteLog = blWriteLog;
		m_cs.Unlock();
	}

private:
	CComAutoCriticalSection m_cs;
	CAtlFile glbLogFile;
	bool m_blWriteLog;
	bool m_blLogFileOpened;	
};


//Ҫ���͵�����
class CSendData
{
public:
	CString		m_szLcName;
	CString		m_szMethodName;
	list<CString>m_lstParas;
};

//������ʵ��¼amf������
enum enum_vt
{
	vt_int,
	vt_double,
	vt_string,
	vt_buffer
};

struct vt_struct
{
	enum_vt vt;
	
	union
	{
		int	m_int;
		double m_double;
		char*	m_string;	
		
		struct _BUFFER_
		{
			int	m_buffLen;
			void	*m_buff;
		}m_buff;

	}data;
};

//���յ�������
class CReceiveData
{
public:
	CReceiveData(){}
	~CReceiveData()
	{
		list<vt_struct>::iterator itr;
		for(itr=m_lstParas.begin();itr!=m_lstParas.end();itr++)
		{
			if(itr->vt == vt_string)
			{
				delete []itr->data.m_string;
			}
			else if(itr->vt == vt_buffer)
			{
				delete []itr->data.m_buff.m_buff;
			}
		}
		m_lstParas.clear();
	}
	CString		m_szMethodName;
	list<vt_struct>m_lstParas;

public:
	//ֻ֧��ָ�����͵Ĳ���
	char *getParam(int i)
	{
		if(i>=m_lstParas.size()||i<0)
			return NULL;
		int idx = 0;
		list<vt_struct>::iterator itr;
		for(itr=m_lstParas.begin();itr!=m_lstParas.end();itr++)
		{
			if(idx++ == i)
			{
				//�������ݶ�����һ��

				if(itr->vt == vt_string)
				{
					int len = strlen(itr->data.m_string)+1;
					char *buff = new char[len];
					::ZeroMemory(buff,len);
					sprintf(buff,"%s",itr->data.m_string);
					return buff;
				}
				else if(itr->vt == vt_buffer)
				{
					//ǰ4λΪint,�������������
					int len = itr->data.m_buff.m_buffLen + 4;
					char *buff = new char[len];
					::ZeroMemory(buff,len);
					::memcpy(buff,&itr->data.m_buff.m_buffLen,4);
					::memcpy(buff+4,itr->data.m_buff.m_buff,itr->data.m_buff.m_buffLen);
					return buff;
				}
				else if(itr->vt == vt_int)
				{
					char *buff = new char[32];
					::ZeroMemory(buff,32);
					sprintf(buff,"%d",itr->data.m_int);
					return buff;
				}
				else if(itr->vt == vt_double)
				{
					char *buff = new char[32];
					::ZeroMemory(buff,32);
					sprintf(buff,"%f",itr->data.m_double);
					return buff;
				}
			}
			
		}
		return NULL;
	}
};
//������Ϣ
enum ErrorCode
{
	ec_ok=1,			//û�д���
	ec_fc_moreparas,	//�������ò�������̫��,
	ec_fc_int_para,		//�������ô��������β���
	ec_fc_float_para,	//�������ô����˸����Ͳ���
	ec_fc_unknown_type_param,	//δ�������͵Ĳ�������
	ec_fm_create_failed,		//����FMʧ����.
	ec_fm_create_alreay_exist,	//����FMʱ����FM�Ѿ�������
	ec_mutex_abandon,		//��������������ʹ��mutexʱ������,����mutexû���ͷ�.��������ʹ�ø�mutex��Ӧ�ð�
	ec_wt_fm_null,				//�����̷߳���FMΪnull
	ec_wt_unknown_error_pos1,	//�����߳�λ��1����δ֪�쳣
	ec_wt_unknown_error_pos2,	//�����߳�λ��2����δ֪�쳣
	ec_mutex_create_failed		//����mutexʧ����,����null
};


//��������,���Զ��ͷ�
class CAutoLCMutex
{
public:
	CAutoLCMutex(CLogModule *pObj)
	{
		m_pObj = pObj;
		//MYTRACE("CAutoLCMutex(Mutex).this=%d",this);
		m_hMutex = NULL;
	}
	~CAutoLCMutex()
	{
		//MYTRACE("CloseHandle(Mutex).this=%d",this);
		::CloseHandle(m_hMutex);
	}
	
	HANDLE createMutex()
	{
		//MYTRACE("CreateMutex");
		HANDLE hMutex = ::CreateMutex(NULL,FALSE,LC_MUTEXT_NAME);
		if(hMutex == NULL)
		{
			MYTRACE("CreateMutex Fail.");
		}
		else
		{
			//MYTRACE("CreateMutex Succ.");

			DWORD dwErr = ::GetLastError();
			if(dwErr == ERROR_ALREADY_EXISTS)
			{
				//MYTRACE("Mutex Already Exists");
			}
			else if(dwErr == ERROR_ACCESS_DENIED )
			{
				MYTRACE("Mutex Access Denied.OpenMutex now");
				/*
				hMutex = ::OpenMutex(NULL,FALSE,LC_MUTEXT_NAME);
				if(hMutex == NULL)
				{
					m_pObj->OutputLog("OpenMutex Fail.");
					dwErr = ::GetLastError();
					m_pObj->OutputLog("OpenMutex GetLastError %d",dwErr);
					if(dwErr == ERROR_FILE_NOT_FOUND)
					{
						m_pObj->OutputLog("OpenMutex Error_File_Not_Found");
					}
					
				}
				else
				{
					m_pObj->OutputLog("OpenMutex Succ.");
				}
				*/
			}
			else
			{
				
			}
		}
		//MYTRACE("HMutex=%08x",hMutex);
		m_hMutex = hMutex;
		ATLASSERT(m_hMutex!=NULL);
		return m_hMutex;
	}
private:
	HANDLE m_hMutex;
	CLogModule *m_pObj;
	BOOL	m_blNeedClose;
};

//�Զ��Ƿ�Mutex
class CAutoReleaseMutex
{
public:
	CAutoReleaseMutex(HANDLE hMutex)
	{
		//MYTRACE("CAutoReleaseMutex.%08x",hMutex);
		m_hMutex = hMutex;
	}
	~CAutoReleaseMutex()
	{
		//MYTRACE("~CAutoReleaseMutex.%08x",m_hMutex);
		::ReleaseMutex(m_hMutex);
	}
private:
	HANDLE m_hMutex;
};

//����ѭ��������FileMap�Զ��ͷ�
class CFMAutoPtr
{
public:
	CFMAutoPtr(HANDLE lpvoid)
	{
		m_lpHandle = lpvoid;
	}
	~CFMAutoPtr()
	{
		//2011-09-05 ��������ʱ���ͷ�.
		//���FM�������Ҵ�����,��ֻ���������ͷ���һ�����,�����д������
		//���FM�����Ҵ�����,���ͷ�֮��ᵼ���´�����FM�ͷŵ�,��д�����ݾͶ���
		static bool blFirst=true;
		if(blFirst)
		{
			blFirst=false;
		}
		else
		{
			::CloseHandle(m_lpHandle);
		}
	}
	HANDLE m_lpHandle;
};

class CUnMapAutoPtr
{
public:
	CUnMapAutoPtr(LPVOID lpvoid)
	{
		m_lpvoid = lpvoid;
	}
	~CUnMapAutoPtr()
	{
		//MYTRACE("UnmapViewOfFile");
		if(::UnmapViewOfFile(m_lpvoid) == 0)
		{
			DWORD dw = ::GetLastError();
			MYTRACE("UnmapViewOfFile.errCode=%d",dw);
		}
	}
private:
	LPVOID m_lpvoid;

};

//��¼������Ϣʱ���ڴ�
class CMsgMem
{
public:
	CMsgMem(char **ppChar,int cnt)
	{
		m_ppChar = ppChar;
		m_cnt = cnt;
	}
	char	**m_ppChar;
	int		m_cnt;

	void Free()
	{
		for(int i=0;i<m_cnt;i++)
		{
			delete []m_ppChar[i];
		}
		delete []m_ppChar;
	}
};

//��¼ע��Ľӿڷ���
class CLCRegistedMethod
{
public:
	CLCRegistedMethod(CString lcName,CString methodName,int	funPtr)
	{
		m_szLCName.Format("%s",lcName);
		m_szMethodName.Format("%s",methodName);
		m_funPtr = funPtr;
	}
	CLCRegistedMethod(char* lcName,char* methodName,int	funPtr)
	{
		m_szLCName.Format("%s",lcName);
		m_szMethodName.Format("%s",methodName);
		m_funPtr = funPtr;
	}
	CString	m_szLCName;
	CString	m_szMethodName;
	int		m_funPtr;
};

//������ǵ������ڵ�.
class CLocalConnection:public CLogModule
{
private:
	CLocalConnection(void);
	static CLocalConnection *m_stLocalConnection;
public:
	
	static CLocalConnection *getInstance();

	~CLocalConnection(void);
	//��ʼ������
	void FinalConstruct();
	//�������ٹ���
	void FinalRelease();

	void SetConfigInfo(int callMsgId,int errMsgId,void *errMsgHwnd);
private:
	//�����߳�
	HANDLE m_hWorkThread;

	//LC������ϢID
	int	m_msgIdCall;
	//������ϢID
	int	m_msgIdErr;
	//���ճ�����Ϣ�Ĵ���
	HWND m_hwndErrMsg;
	
	// �ڴ��������߳�֮ǰ����Ƿ�����ͬ����LocalConnection����

	//ͬʱ����ע��,��ע�� ĳ������ .regType ==0 :��� 1:ע�� :2 ��ע��
	//����ֵ:0:û���ҵ�(ע��ɹ�) 1:�ҵ�(ȡ��ע��ɹ�) ;  ����Ϊ�쳣��ʧ��
	int ICheckLCName(CString szLocConnName,int regType=0);
	
	// �鿴�Ƿ����������ֵ�LocName
	bool ICheckRegistedName(byte* pBuff, CString szLocName);
	int IRegisterThis(byte* pBuff,const CString szLocConnName,bool isRegist=true);
	CComAutoCriticalSection m_csTw;
	bool	m_blThreadWork;
	
	//�б������б���ʵ�CriticalSection
	CComAutoCriticalSection m_csListLc;
	list<LCINFO>m_lstLC;
public:
	HANDLE ICreateFileMap(void);
	//��������
	int Connect(char* szName, void* hWnd);
	//�رռ���
	int Close(char* szName);
	void PostErrorMsg(int errId);
	inline bool isThreadWorking()
	{
		bool blVal = false;
		m_csTw.Lock();
		blVal = m_blThreadWork;
		m_csTw.Unlock();
		return blVal;
	}
	inline void setThreadWorkState(bool blTw)
	{
		m_csTw.Lock();
		m_blThreadWork = blTw;
		m_csTw.Unlock();
	}
	//0:��ʾ��Ч������
	int IParseData(byte* pBuff);

	//���б����һ����¼
	inline void ListLC_Add(char *pszName,HWND hwnd)
	{
		m_csListLc.Lock();
		LCINFO lc(pszName,hwnd);
		m_lstLC.push_back(lc);
		m_csListLc.Unlock();
	}
	//ɾ��һ����¼
	inline void ListLC_Delete(char *pszName)
	{
		m_csListLc.Lock();
		list<LCINFO>::iterator itr;
		for(itr=m_lstLC.begin();itr!=m_lstLC.end();itr++)
		{
			if(!itr->m_szName.CollateNoCase(pszName))
			{
				m_lstLC.erase(itr);
				break;
			}
		}
		m_csListLc.Unlock();
	}
	//�Ƿ�����������
	bool ListLC_Select(char* pszName)
	{
		
		bool blFind=false;

		m_csListLc.Lock();
		MYTRACE("ListLC_Select.%s",pszName);

		list<LCINFO>::iterator itr;
		for(itr=m_lstLC.begin();itr!=m_lstLC.end();itr++)
		{
			MYTRACE("ListLC_Select.FOR:Name=[%s],itrName=[%s]",pszName,itr->m_szName);
			if(!itr->m_szName.CollateNoCase(pszName))
			{
				blFind=true;
				break;
			}
		}
		m_csListLc.Unlock();
		return blFind;
	}
	//��ȡ���ֶ�Ӧ��hwnd
	inline HWND ListLC_GetHWNDByName(char *pszName)
	{
		HWND hWnd = NULL;

		m_csListLc.Lock();
		list<LCINFO>::iterator itr;
		for(itr=m_lstLC.begin();itr!=m_lstLC.end();itr++)
		{
			if(!itr->m_szName.CollateNoCase(pszName))
			{
				hWnd = (*itr).m_hWnd;
				break;
			}
		}
		m_csListLc.Unlock();
		return hWnd;
	}
	LRESULT OnFuncCallMsg(char *szName,CReceiveData *pRd);
	int ICheckAndSendData(CSendData& sd);
	int ISendData(byte *pBuff,CSendData &sd);

	// ע��һ��LC�����Ļص�����
	int MethodRegister(char* szLcName, char* szMethodName, int funCallBackPtr);

	list<CLCRegistedMethod>m_lstMethod;
	CComAutoCriticalSection m_csMR;

	int MR_Get(char* szLcName, char* szMethodName)
	{
		int ptr = 0;

		m_csMR.Lock();

		list<CLCRegistedMethod>::const_iterator itr;
		for(itr=m_lstMethod.begin();itr!=m_lstMethod.end();itr++)
		{
			if((!strcmp(szLcName,(*itr).m_szLCName)) && (!strcmp(szMethodName,(*itr).m_szMethodName)))
			{
				//�ҵ���
				ptr = (*itr).m_funPtr;
			}
		}
		m_csMR.Unlock();
		return ptr;
	}
	void MR_FreeAll()
	{
		m_csMR.Lock();
		m_lstMethod.clear();
		m_csMR.Unlock();
	}
};
