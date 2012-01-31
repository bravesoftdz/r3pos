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

//是否输出日志
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
	// 返回整形
	int ReadInt29(byte* pBuff, int& numLen);
	bool WriteInt29(byte* pBuff, unsigned int intVal, int& numLen);
	int WriteString(byte* pBuff, CString szInfo, int& len);
};

//保存每个LC对应的HWND
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
	//输出运行日志
	//

	void OpenLogFile(void);
	void CloseLogFile(void);
	void OutputLog2File(const char* info);
	// 输出指定缓冲区数据的16进制表示
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


//要发送的数据
class CSendData
{
public:
	CString		m_szLcName;
	CString		m_szMethodName;
	list<CString>m_lstParas;
};

//用于忠实记录amf的数据
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

//接收到的数据
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
	//只支持指针类型的参数
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
				//所有数据都复制一份

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
					//前4位为int,后面紧跟着数据
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
//出错信息
enum ErrorCode
{
	ec_ok=1,			//没有错误
	ec_fc_moreparas,	//函数调用参数个数太多,
	ec_fc_int_para,		//函数调用传递了整形参数
	ec_fc_float_para,	//函数调用传递了浮点型参数
	ec_fc_unknown_type_param,	//未处理类型的参数类型
	ec_fm_create_failed,		//创建FM失败了.
	ec_fm_create_alreay_exist,	//创建FM时发现FM已经存在了
	ec_mutex_abandon,		//发现其他程序在使用mutex时崩溃了,导致mutex没有释放.重启所有使用该mutex的应用吧
	ec_wt_fm_null,				//工作线程发现FM为null
	ec_wt_unknown_error_pos1,	//工作线程位置1捕获未知异常
	ec_wt_unknown_error_pos2,	//工作线程位置2捕获未知异常
	ec_mutex_create_failed		//创建mutex失败了,返回null
};


//创建对象,并自动释放
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

//自动是否Mutex
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

//用于循环里面在FileMap自动释放
class CFMAutoPtr
{
public:
	CFMAutoPtr(HANDLE lpvoid)
	{
		m_lpHandle = lpvoid;
	}
	~CFMAutoPtr()
	{
		//2011-09-05 这个句柄暂时不释放.
		//如果FM不是由我创建的,则只不过是少释放了一个句柄,不会有大的问题
		//如果FM是由我创建的,则释放之后会导致新创建的FM释放掉,新写的数据就丢了
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

//记录发送消息时的内存
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

//记录注册的接口方法
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

//这个类是单例存在的.
class CLocalConnection:public CLogModule
{
private:
	CLocalConnection(void);
	static CLocalConnection *m_stLocalConnection;
public:
	
	static CLocalConnection *getInstance();

	~CLocalConnection(void);
	//初始化过程
	void FinalConstruct();
	//最终销毁过程
	void FinalRelease();

	void SetConfigInfo(int callMsgId,int errMsgId,void *errMsgHwnd);
private:
	//工作线程
	HANDLE m_hWorkThread;

	//LC调用消息ID
	int	m_msgIdCall;
	//出错消息ID
	int	m_msgIdErr;
	//接收出错消息的窗体
	HWND m_hwndErrMsg;
	
	// 在创建工作线程之前检查是否已有同名的LocalConnection存在

	//同时用作注销,反注册 某个名称 .regType ==0 :检测 1:注册 :2 反注册
	//返回值:0:没有找到(注册成功) 1:找到(取消注册成功) ;  其他为异常或失败
	int ICheckLCName(CString szLocConnName,int regType=0);
	
	// 查看是否存在这个名字的LocName
	bool ICheckRegistedName(byte* pBuff, CString szLocName);
	int IRegisterThis(byte* pBuff,const CString szLocConnName,bool isRegist=true);
	CComAutoCriticalSection m_csTw;
	bool	m_blThreadWork;
	
	//列表及控制列表访问的CriticalSection
	CComAutoCriticalSection m_csListLc;
	list<LCINFO>m_lstLC;
public:
	HANDLE ICreateFileMap(void);
	//创建监听
	int Connect(char* szName, void* hWnd);
	//关闭监听
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
	//0:表示有效的数据
	int IParseData(byte* pBuff);

	//向列表插入一条记录
	inline void ListLC_Add(char *pszName,HWND hwnd)
	{
		m_csListLc.Lock();
		LCINFO lc(pszName,hwnd);
		m_lstLC.push_back(lc);
		m_csListLc.Unlock();
	}
	//删除一条记录
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
	//是否存在这个名字
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
	//获取名字对应的hwnd
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

	// 注册一个LC方法的回调函数
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
				//找到了
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
