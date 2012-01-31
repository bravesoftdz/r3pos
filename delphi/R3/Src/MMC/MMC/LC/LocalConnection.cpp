#include "StdAfx.h"
#include ".\localconnection.h"

DWORD WINAPI WorkingThread(LPVOID para);

CAMFStream::CAMFStream(void)
{
}

CAMFStream::~CAMFStream(void)
{
}

unsigned short CAMFStream::ReadU16(byte* pBuff)
{
	return pBuff[0]<<8 | pBuff[1];
}

LPTSTR CAMFStream::ReadString(byte* pBuff, short len)
{
	//在这里把UTF8转换成多字节字符.
	TCHAR *utf8 = new TCHAR[len+1];
	::CopyMemory(utf8,pBuff,len);
	utf8[len]='\0';

	int wlen = ::MultiByteToWideChar(CP_UTF8,0,utf8,-1,0,0);
	wchar_t* wbuf = new wchar_t[wlen+1];
	::MultiByteToWideChar(CP_UTF8,0,utf8,-1,wbuf,wlen);
	wbuf[wlen] = L'0';

	int clen = ::WideCharToMultiByte(CP_OEMCP,0,wbuf,-1,0,0,0,0);
	char* cbuf = new char[clen+1];
	::WideCharToMultiByte(CP_OEMCP,0,wbuf,-1,cbuf,clen,0,0);
	cbuf[clen] = '\0';	
	

	delete []wbuf;
	delete []utf8;

	return cbuf;
}

double CAMFStream::ReadNumber64(byte*pBuff)
{
	BYTE buf[8];
	::memcpy(buf,pBuff,8);

	unsigned __int64 retvalue = 0;
	unsigned __int64 tmp;

	tmp = buf[0];
	retvalue = tmp<<56;

	tmp = buf[1];
	retvalue |= tmp<<48;

	tmp = buf[2];
	retvalue |= tmp<<40;

	tmp = buf[3];
	retvalue |= tmp<<32;

	tmp = buf[4];
	retvalue |= tmp<<24;

	tmp = buf[5];
	retvalue |= tmp<<16;

	tmp = buf[6];
	retvalue |= tmp<<8;

	tmp = buf[7];
	retvalue |= tmp;
	
	double d;
	memcpy(&d,&retvalue,8);
	return d;
}

int CAMFStream::WriteStringH(byte* pBuff, CString szInfo, int& len)
{
	short wlen = ::MultiByteToWideChar(CP_OEMCP,0,szInfo,-1,0,0);
	wchar_t* wbuf = new wchar_t[wlen+1];
	::MultiByteToWideChar(CP_OEMCP,0,szInfo,-1,wbuf,wlen);
	wbuf[wlen] = L'0';

	short clen = ::WideCharToMultiByte(CP_UTF8,0,wbuf,-1,0,0,0,0);
	char* cbuf = new char[clen+1];
	::WideCharToMultiByte(CP_UTF8,0,wbuf,-1,cbuf,clen,0,0);
	cbuf[clen] = '\0';
	
	//拷贝是不包含最末的空格,所以长度减去1
	clen-=1;

	BYTE bt[1]={0x02};
	BYTE bl[2]={0x00,0x00};
	bl[0]=clen>>8;
	bl[1]=clen & 0x00FF;

	::CopyMemory(pBuff,bt,1);
	::CopyMemory(pBuff+1,bl,2);
	::CopyMemory(pBuff+3,cbuf,clen);

	delete []wbuf;
	delete []cbuf;

	len = clen+3;
	return 0;
}

// 返回整形
int CAMFStream::ReadInt29(byte* pBuff, int& numLen)
{
	int idx = 0;
	unsigned char byte = pBuff[idx];
	int readnum = 0;
	int value = 0;
	numLen = 1;
	while(((byte & 0x80)!=0) && (readnum<3))
	{
		value = (value<<7) | (byte & 0x7F);
		++readnum;
		byte = pBuff[++idx];
		numLen++;
	}

	//最后一字节
	if(readnum<3)
		value = (value<<7) | (byte & 0x7F);
	else
		value = (value<<8) | (byte & 0xFF);

	//第29位的符号位
	if((value&0x10000000)!=0)
		value = (value&0x10000000) | 0x80000000;

	return value;
}

bool CAMFStream::WriteInt29(byte* pBuff, unsigned int intVal, int& numLen)
{
	if(intVal <= 0x7F)
	{
		pBuff[0] = (BYTE)intVal;
		numLen = 1;
		return true;
	}
	

	unsigned int tmp;
	BYTE buf[4];
	if(intVal <= 0x3FFF)
	{
		tmp = intVal>>7 | 0x80;
		buf[0] = tmp;

		buf[1] = intVal & 0x7F;

		::CopyMemory(pBuff,buf,2);
		//write(ctx,buf,2);
		numLen = 2;
		return true;
	}

	if(intVal <= 0x001FFFFF)
	{
		tmp = intVal>>14 | 0x80;
		buf[0] = tmp;

		tmp = ((intVal>>7) & 0x7F) | 0x80;
		buf[1] = tmp;

		buf[2] = intVal & 0x7F;

		::CopyMemory(pBuff,buf,3);
		numLen = 3;
		return true;
	}

	if(intVal <= 0x0FFFFFFF)
	{
		tmp = intVal>>22 | 0x80;
		buf[0] = tmp;

		tmp = ((intVal>>15) & 0x7F) | 0x80;
		buf[1] = tmp;

		tmp = ((intVal>>8) & 0x7F) | 0x80;
		buf[2] = tmp;

		buf[3] = intVal & 0xFF;

		::CopyMemory(pBuff,buf,4);
		numLen = 4;
		return true;
	}

	return false;
}

int CAMFStream::WriteString(byte* pBuff, CString szInfo, int& len)
{
	//数据类型,长度u29,字符串
	byte*pt = pBuff;
	pt[0] = 0x06;
	pt++;

	if(szInfo.GetLength() > 0)
	{
		//计算字符串长度
		short wlen = ::MultiByteToWideChar(CP_OEMCP,0,szInfo,-1,0,0);
		wchar_t* wbuf = new wchar_t[wlen+1];
		::MultiByteToWideChar(CP_OEMCP,0,szInfo,-1,wbuf,wlen);
		wbuf[wlen] = L'0';

		short clen = ::WideCharToMultiByte(CP_UTF8,0,wbuf,-1,0,0,0,0);
		char* cbuf = new char[clen+1];
		::WideCharToMultiByte(CP_UTF8,0,wbuf,-1,cbuf,clen,0,0);
		cbuf[clen] = '\0';

		//拷贝是不包含最末的空格,所以长度减去1
		clen-=1;

		CAutoPtr<wchar_t>wc(wbuf);
		CAutoPtr<char>c(cbuf);

		int numLen = 0;
		WriteInt29(pBuff+1,(clen*2+1),numLen);
		pt += numLen;

		::CopyMemory(pt,cbuf,clen);

		len = 1 + numLen + clen;
	}
	else
	{
		len = 1 + 1;
		pt[0] = 0x01;
	}
	return 0;
}

CLogModule::CLogModule()
{
#ifdef WRITE_LOG
	MYTRACE("CLogModule.Construct.%08XH,源文件:%s,编译日期:%s",this,__FILE__,__DATE__);
	m_blWriteLog = true;
	m_blLogFileOpened = false;
#endif //WRITE_LOG
}
CLogModule::~CLogModule()
{
#ifdef WRITE_LOG
	CloseLogFile();
#endif //WRITE_LOG
}

void CLogModule::OutputLog(char* info,...)
{
#ifdef WRITE_LOG
	int len;
	char *buffer;
	va_list args;

	m_cs.Lock();
	try
	{
		va_start(args,info);
		len = _vscprintf(info,args)+1;
		buffer = (char*)malloc(len*sizeof(char));
		vsprintf(buffer,info,args);
		OutputDebugString(buffer);
		OutputLog2File(buffer);
		free(buffer);
	}
	catch(...)
	{

	}

	m_cs.Unlock();
#endif //WRITE_LOG
}

void CLogModule::OpenLogFile(void)
{
#ifdef WRITE_LOG
	MYTRACE("OpenLogFile");
	m_cs.Lock();
	try
	{
		char szTempName[MAX_PATH];
		GetTempPath(MAX_PATH-1,szTempName);

		CString szPath;

		//打开日志文件
		char fileName[MAX_PATH];
		memset(fileName,0x00,sizeof(fileName));

		ATL::CTime tm = CTime::GetCurrentTime();	
		static int idx = 0;
		sprintf(fileName,"%s\\MM_LocConn_%s_%d_%d.log",szTempName,tm.Format("%Y%m%d-%H%M%S"),::GetCurrentProcessId(),idx++);
		HRESULT hr = glbLogFile.Create(fileName,GENERIC_WRITE|GENERIC_READ,FILE_SHARE_READ,OPEN_ALWAYS);
		if(hr == S_OK)
		{
			m_blLogFileOpened = true;	
			glbLogFile.Seek(0,FILE_END);
		}
		else
		{
			m_blLogFileOpened = false;			
		}
	}
	catch(...)
	{
		OutputDebugString("创建日志文件出错");
	}
	m_cs.Unlock();
#endif //WRITE_LOG
}

void CLogModule::CloseLogFile(void)
{
#ifdef WRITE_LOG
	MYTRACE("CloseLogFile");
	m_cs.Lock();
	try
	{
		if(this->m_blLogFileOpened)
		{
			glbLogFile.Flush();
			glbLogFile.Close();
			m_blLogFileOpened=false;
		}
	}
	catch(...)
	{
		OutputDebugString("关闭日志文件出错");
	}
	m_cs.Unlock();
	MYTRACE("CloseLogFile.End");
#endif //WRITE_LOG
}

void CLogModule::OutputLog2File(const char* info)
{
#ifdef WRITE_LOG
	if(!m_blWriteLog)
		return;
	if(strlen(info)>4000)
		return;
	//在第一次写日志到文件的时候再创建日志文件
	if(!m_blLogFileOpened)
	{
		OpenLogFile();
	}
	if(!m_blLogFileOpened)
	{
		return;
	}
	
	char buff[4096];
	::ZeroMemory(buff,sizeof(buff));

	CTime now = CTime::GetCurrentTime();
	char rt[3]={0x0D,0x0A,0x00};
	sprintf(buff,"[[%08d]%02d:%02d:%02d][%s]%s",::GetCurrentThreadId(),now.GetHour(),now.GetMinute(),now.GetSecond(),info,rt);
	try
	{
		glbLogFile.Write(buff,(DWORD)strlen(buff));
	}
	catch(...)
	{
		OutputDebugString("输出日志到文件出错");
	}
#endif //WRITE_LOG
}

CString CLogModule::trans2String(BYTE bval)
{
	//if((bval>='A' && bval<='Z')||(bval>='a' && bval <='z')||(bval>='))
	if(bval>=32 && bval<127)
	{
		CString sz1;
		sz1.Format("%c",bval);
		return sz1;
	}
	return " ";
}

void CLogModule::OutputLogHex(byte* pBuff, int len)
{
#ifdef WRITE_LOG
	//每行 16个字符
	int cols = 16;
	int rows = (len / cols) + ((len %cols)>0?1:0);	

	for(int i=0;i<rows;i++)
	{
		//输出行号
		CString sz1,sz2;
		sz1.Format("%08XH: ",i*cols);
		for(int j=0;j<cols;j++)
		{
			if(i*cols+j<len)
			{
				//输出内容
				sz2.Format("%02X(%s) ",(BYTE)pBuff[i*cols+j],trans2String((BYTE)pBuff[i*cols+j]));
				sz1+=sz2;
			}
		}
		//输出并换行
		OutputLog("%s",sz1);
	}
#endif //WRITE_LOG
}

CLocalConnection::CLocalConnection(void)
{
	m_hWorkThread = NULL;
}

CLocalConnection::~CLocalConnection(void)
{
}

//最终销毁过程
void CLocalConnection::FinalRelease()
{
	OutputLog("CLocalConnection.FinalRelease");
	//在这里关闭工作线程和LocalConnection
	m_csListLc.Lock();
	while(m_lstLC.size()>0)
	{
		list<LCINFO>::iterator itr;
		itr = m_lstLC.begin();
		int rtv = ICheckLCName(itr->m_szName,2);
		if(1 == rtv || 0 == rtv)
		{
			m_lstLC.erase(itr);
		}
	}
	m_csListLc.Unlock();

	//等待工作线程结束

	if(NULL != m_hWorkThread)
	{
		setThreadWorkState(false);		

		DWORD dwCode = 0;
		MYTRACE("检测线程是否退出了");
		if(::GetExitCodeThread(m_hWorkThread,&dwCode))
		{
			MYTRACE("GetExitCodeThread:=TRUE,dwCode=%d",dwCode);
			if(dwCode == STILL_ACTIVE)
			{
				OutputLog("线程仍存活.等待");				

				if(WAIT_OBJECT_0 != ::WaitForSingleObject(m_hWorkThread,1000))
				{
					//之前的工作线程未正常退出.
					OutputLog("工作线程未正常退出.Close.强制退出");
					::TerminateThread(m_hWorkThread,0);

				}
				else
				{
					MYTRACE("WAIT_OBJECT_0 == 线程wait code");
				}/**/
			}
			else
			{
				MYTRACE("线程已经退出了.");
			}
			//检测成功了
		}
		else
		{
			OutputLog("工作线程未正常退出.Close.强制退出.22");
			::TerminateThread(m_hWorkThread,1);
		}
	}
	MR_FreeAll();
	m_hWorkThread = NULL;
}
//
void CLocalConnection::SetConfigInfo(int callMsgId,int errMsgId,void *errMsgHwnd)
{
	OutputLog("SetConfigInfo.callMsgId=%d,errMsgId=%d,errMsgHwnd=%d",callMsgId,errMsgId,errMsgHwnd);

	this->m_msgIdCall = callMsgId;
	this->m_msgIdErr = errMsgId;
	this->m_hwndErrMsg = (HWND)errMsgHwnd;
}
//
DWORD WINAPI WorkingThread(LPVOID para)
{
	CLocalConnection *pObj = (CLocalConnection*)para;
	pObj->setThreadWorkState(true);

	static int idx = 0;
	while(pObj->isThreadWorking())
	{
		//idx++是整形,在正常情况下足够使用,不需要判断超过界限
		idx++;
		/*
		Sleep(0)和Sleep(1)有在表现上有非常大的区别.如果sleep(0)会疯狂循环,貌似waitforsingleobject直接返回了;
		而sleep(1)的时候是有等待的
		*/
		::Sleep(SLEEP_TIME);
		if(true)
		{
			//创建mutex和循环
			CAutoLCMutex	lcMutex(static_cast<CLogModule*>(pObj));

			HANDLE hMutex = lcMutex.createMutex();
			ATLASSERT(hMutex != NULL);
			switch(::WaitForSingleObject(hMutex,SINGLE_WAIT_TIMEOUT))
			{
			case WAIT_TIMEOUT:
				if(idx%200 == 0)
				{
					pObj->OutputLog("WAIT_TIMEOUT - Thread. %d",idx);
				}
				break;
			case WAIT_ABANDONED:
				pObj->OutputLog("WAIT_ABANDONED - Thread .%d",idx);
				//pObj->PostErrorMsg(ec_mutex_abandon);
			case WAIT_OBJECT_0:
				//获取到信号了
				CAutoReleaseMutex arMutex(hMutex);
				
				try
				{
					if(idx%500 == 0)
						MYTRACE("WAIT_OBJECT_0 - Thread. %d",idx);
					if(idx%2000 == 0)
						pObj->OutputLog("WAIT_OBJECT_0 - Thread. %d",idx);

					HANDLE hMf = pObj->ICreateFileMap();
					CFMAutoPtr  fm(hMf);					
					if(hMf != NULL)
					{
						LPVOID lpvoid = ::MapViewOfFile(hMf,FILE_MAP_ALL_ACCESS,0,0,0);
						CUnMapAutoPtr umap(lpvoid);
						
						if(lpvoid !=NULL)
						{
							try
							{								
								if(0 == pObj->IParseData((byte*)lpvoid))
								{
									//0:表示有效的数据.下面清空message
									::ZeroMemory((((byte*)lpvoid)+8),8+LC_LEN_MESSAGE);
									::FlushViewOfFile((((byte*)lpvoid)+8),8+LC_LEN_MESSAGE);					
								}
							}
							catch(...)
							{
								MYTRACE("ec_wt_unknown_error_pos1");
								pObj->PostErrorMsg(ec_wt_unknown_error_pos1);
								pObj->OutputLog("捕获异常1.");
							}
						}
					}
					else
					{
						MYTRACE("ec_wt_fm_null");
						pObj->PostErrorMsg(ec_wt_fm_null);
						pObj->OutputLog("FM==null");
					}
				}
				catch(...)
				{
					MYTRACE("ec_wt_unknown_error_pos2");
					pObj->PostErrorMsg(ec_wt_unknown_error_pos2);
					pObj->OutputLog("捕获异常2.");
				}
				break;
			}
		}
	}

	pObj->OutputLog("工作线程退出了!!");
	return 0;
}
//创建监听
//参数:创建的监听名称,接收调用消息的窗体
//返回值:0:成功  1:创建工作线程失败 2:这个名字已被使用. 3:异常
int CLocalConnection::Connect(char* szName, void* hWnd)
{
	OutputLog("Connect.Name=%s,hwnd=%d",szName,hWnd);

	if(this->m_hWorkThread == NULL)
	{
		//创建工作线程
		DWORD dwThreadId;
		m_hWorkThread = ::CreateThread(NULL,0,&WorkingThread,this,0,&dwThreadId);
		if(m_hWorkThread == NULL)
		{
			OutputLog("创建工作线程失败;ErrCode=%d",::GetLastError());
			return 1;
		}
	}

	//判断是否有同名的链接存在
	int rtv = ICheckLCName(CString(szName),1);
	OutputLog("CheckName.%s,regType=%d,RTV=%d",szName,1,rtv);
	if(rtv == 0)
	{
		//没有找到这个名字,注册成功了
		//把这个名字加入 LC名称列表
		ListLC_Add(szName,(HWND)hWnd);
		return 0;
	}
	else if(rtv == 1)
	{
		return 2;
	}
	else
	{
		return 3;
	}
}
//关闭监听.实际是取消注册
int CLocalConnection::Close(char* szName)
{
	CString sz1;
	sz1.Format("%s",szName);
	int rtv =  this->ICheckLCName(sz1,2);
	if(rtv == 1)
	{
		ListLC_Delete(szName);
	}
	return rtv;
}

//0:没有找到(注册成功) 1:找到(取消注册成功) ;  其他为异常或失败
int CLocalConnection::ICheckLCName(CString szLocConnName,int regType)
{
	OutputLog("ICheckLCName:%s,regType=%d",szLocConnName,regType);



	HANDLE hMf = NULL;
	CTime tmBgn = CTime::GetCurrentTime();	

	int rtv = 0;
	while(true)
	{
		::Sleep(SLEEP_TIME);

		if(true)
		{
			//获取CriticalSection并赋值
			CAutoLCMutex lcMutex(static_cast<CLogModule*>(this));
			HANDLE hMutex = lcMutex.createMutex();
			if(hMutex == NULL)
			{
				PostErrorMsg(ec_mutex_create_failed);
				return 2;
			}
			DWORD dw = ::WaitForSingleObject(hMutex,SINGLE_WAIT_TIMEOUT);
			if(dw == WAIT_TIMEOUT)
			{
				OutputLog("WAIT_TIMEOUT.ICheckLCName");
				//如果等待4秒还是没有获得信号,则不再检测,退出等待
				CTimeSpan ts = CTime::GetCurrentTime() - tmBgn;
				if(ts.GetTotalSeconds()<=4)
				{
					continue;
				}
				else
				{
					rtv = 2;
					break;
				}
			}
			else if(dw == WAIT_OBJECT_0||dw == WAIT_ABANDONED)
			{
				if(dw == WAIT_ABANDONED)
				{
					OutputLog("WAIT_ABANDONED . 出现异常了.在获取了Mutex后出现异常导致Mutex没有释放.");
					PostErrorMsg(ec_mutex_abandon);
				}
				//检查是否时间戳为0
				CAutoReleaseMutex mp(hMutex);
				try
				{
					OutputLog("获取到信号了.");
					hMf = ICreateFileMap();
					if(hMf != NULL)
					{
						//自动是否hMf
						CFMAutoPtr fap(hMf);
						OutputLog("获取到信号了.  1111");
						LPVOID lpvoid = ::MapViewOfFile(hMf,FILE_MAP_ALL_ACCESS,0,0,0);
						if(lpvoid !=NULL)
						{
							CUnMapAutoPtr umap(lpvoid);
							OutputLog("获取到信号了.  2222");
							try
							{
								OutputLog("在这里做操作");
								DWORD *dwTick = (DWORD*)((byte*)lpvoid+8);
								if(*dwTick == 0)
								{
									if(ICheckRegistedName((byte*)lpvoid,szLocConnName))
									{
										//找到了这个名字的LC.
										rtv = 1;
										if(regType == 2)
										{
											this->IRegisterThis((byte*)lpvoid,szLocConnName,false);
										}

									}
									else
									{
										//没有找到这个名字的LC.
										if(regType == 1)
										{
											this->IRegisterThis((byte*)lpvoid,szLocConnName,true);
										}
										rtv = 0;
									}								
									break;
								}
								else
								{
									//如果等待4秒还是没有获得信号,则不再检测,退出等待
									CTimeSpan ts = CTime::GetCurrentTime() - tmBgn;
									if(ts.GetTotalSeconds()<=4)
									{
										continue;
									}
									else
									{
										OutputLog("超过了4秒还是没有权限写;强制操作");
										::ZeroMemory((((byte*)lpvoid)+8),8+LC_LEN_MESSAGE);
										//清除数据
										if(ICheckRegistedName((byte*)lpvoid,szLocConnName))
										{
											//找到了这个名字的LC.
											rtv = 1;
											if(regType == 2)
											{
												this->IRegisterThis((byte*)lpvoid,szLocConnName,false);
											}

										}
										else
										{
											//没有找到这个名字的LC.
											if(regType == 1)
											{
												this->IRegisterThis((byte*)lpvoid,szLocConnName,true);
											}
											rtv = 0;
										}							
										break;
									}
									break;
								}
							}
							catch(...)
							{
								OutputLog("捕获未知异常11");
								rtv = 5;
								break;
							}						
						}
					}
					else
					{
						OutputLog("尚未创建FM,当然也不存在LocName");
						rtv = 1;
						break;
					}
				}
				catch(...)
				{
					OutputLog("捕获未知异常22");
					rtv = 7;
					break;
				}
			}
		}
	}

	return rtv;
}

//打开一个FM,如果没有的话就创建
HANDLE CLocalConnection::ICreateFileMap(void)
{
	HANDLE hMf = ::OpenFileMapping(FILE_MAP_ALL_ACCESS,FALSE,LC_FILEMAP_NAME);
	//已有了FileMapping,直接返回
	if(hMf != NULL)
	{
		return hMf;
	}

	//如果没有FileMapping,则创建一个.
	DWORD dwError = ::GetLastError();
	OutputLog("MF==NULL.ErrorCode=%d",dwError);


	SYSTEM_INFO si;
	DWORD dwPs,dwSize = 0;
	DWORD errCode;

	::GetSystemInfo(&si);
	dwPs = si.dwPageSize;
	//64k空间
	DWORD mySize = 1024*64;
	dwSize = (mySize)/dwPs;
	if(mySize % dwPs != 0)
		dwSize = dwSize + 1;

	dwSize = dwSize *dwPs;
	hMf = ::CreateFileMapping(INVALID_HANDLE_VALUE,NULL,PAGE_READWRITE,0,dwSize,LC_FILEMAP_NAME);
	if(hMf != NULL)
	{
		//创建成功了.
	}
	else
	{
		errCode = ::GetLastError();
		OutputLog("创建文件映射对象失败:ErrCode:[%d]",errCode);
		//创建失败了.
		PostErrorMsg(ec_fm_create_failed);
	}

	if(hMf != NULL)
	{
		LPVOID lpvoid = ::MapViewOfFile(hMf,FILE_MAP_ALL_ACCESS,0,0,0);
		if(lpvoid !=NULL)
		{
			CUnMapAutoPtr ap(lpvoid);
			//格式化文件内容
			byte *pBuff = (byte*)lpvoid;
			::ZeroMemory(pBuff,64*1024);
			pBuff[0] = pBuff[4] = 0x01;
		}
	}
	return HANDLE(hMf);
}

// 查看是否存在这个名字的LocName
bool CLocalConnection::ICheckRegistedName(byte* pBuff, CString szLocName)
{
	OutputLog("ICheckRegistedName.LocName=%s",szLocName);
	char * szBuffer = (char*)pBuff;

	szBuffer += LC_POS_LISTENERS;

	OutputLogHex((byte*)szBuffer,256);
	bool blFind = false;
	DWORD len = strlen(szBuffer);
	while(len > 0)
	{
		if(!szLocName.CompareNoCase(szBuffer))
		{
			blFind = true;
			break;
		}

		szBuffer += (len + 1);
		len = strlen(szBuffer);
	}
	if(blFind)
	{
		OutputLog("ICheckRegistedName.找到了:%s",szLocName);
	}
	else
	{
		OutputLog("ICheckRegistedName.没有找到:%s",szLocName);
	}

	return blFind;
}

int CLocalConnection::IRegisterThis(byte* pBuff,const CString szLocConnName,bool isRegist)
{
	if(isRegist)
	{
		OutputLog("注册LCName:%s",szLocConnName);
	}
	else
	{
		OutputLog("反注册LCName:%s",szLocConnName);
	}
	OutputLog("LCName处理之前:");
	OutputLogHex((byte*)pBuff+LC_POS_LISTENERS,256);

	char * szBuffer = (char*)pBuff;
	szBuffer = (char*)pBuff+LC_POS_LISTENERS;

	if(isRegist)
	{
		//将lc写入最后的位置
		DWORD len = strlen(szBuffer);
		while(len>0)
		{
			OutputLog("中间内容:%s",szBuffer);
			szBuffer+=(len+1);
			len = strlen(szBuffer);
		}

		CRegistedLC rlc;
		rlc.m_szName.Format("%s",szLocConnName);

		CopyMemory(szBuffer,rlc.m_szName.GetBuffer(),rlc.m_szName.GetLength());
		szBuffer+=rlc.m_szName.GetLength();
		szBuffer[0] = '\0';
		szBuffer++;

		CopyMemory(szBuffer,rlc.m_szVal1.GetBuffer(),rlc.m_szVal1.GetLength());
		szBuffer+=rlc.m_szVal1.GetLength();
		szBuffer[0] = '\0';
		szBuffer++;

		CopyMemory(szBuffer,rlc.m_szVal2.GetBuffer(),rlc.m_szVal2.GetLength());
		szBuffer+=rlc.m_szVal2.GetLength();
		szBuffer[0] = '\0';
		szBuffer++;
		//使得lcname的最后为两个0
		szBuffer[0] = '\0';

	}
	else
	{
		//从内存读取LC到数组
		std::vector<CRegistedLC>vecName;
		DWORD len = strlen(szBuffer);
		while(len>0)
		{
			CRegistedLC rlc;
			rlc.m_szName.Format("%s",szBuffer);
			OutputLog("中间内容:%s",szBuffer);

			szBuffer+=(len+1);
			len = strlen(szBuffer);
			if(len == 0)
			{
				break;
			}
			rlc.m_szVal1.Format("%s",szBuffer);
			OutputLog("中间内容:%s",szBuffer);

			szBuffer+=(len+1);
			len = strlen(szBuffer);
			if(len == 0)
			{
				break;
			}
			rlc.m_szVal2.Format("%s",szBuffer);
			OutputLog("中间内容:%s",szBuffer);

			szBuffer+=(len+1);
			len = strlen(szBuffer);

			MYTRACE("1111 Name:%s",rlc.m_szName);
			MYTRACE("%s",rlc.m_szVal1);
			MYTRACE("%s",rlc.m_szVal2);

			//如果
			if(rlc.m_szName.CompareNoCase(szLocConnName))
			{
				vecName.push_back(rlc);
			}
		}
		MYTRACE("LEN = %d",vecName.size());
		//将数据写入内存
		szBuffer = (char*)pBuff+LC_POS_LISTENERS;

		std::vector<CRegistedLC>::const_iterator citr;
		for(citr = vecName.begin();citr!=vecName.end();citr++)
		{
			CRegistedLC rlc = (*citr);
			MYTRACE("Name:%s",rlc.m_szName);
			MYTRACE("%s",rlc.m_szVal1);
			MYTRACE("%s",rlc.m_szVal2);
			CopyMemory(szBuffer,rlc.m_szName.GetBuffer(),rlc.m_szName.GetLength());
			szBuffer+=rlc.m_szName.GetLength();
			szBuffer[0] = '\0';
			szBuffer++;

			CopyMemory(szBuffer,rlc.m_szVal1.GetBuffer(),rlc.m_szVal1.GetLength());
			szBuffer+=rlc.m_szVal1.GetLength();
			szBuffer[0] = '\0';
			szBuffer++;

			CopyMemory(szBuffer,rlc.m_szVal2.GetBuffer(),rlc.m_szVal2.GetLength());
			szBuffer+=rlc.m_szVal2.GetLength();
			szBuffer[0] = '\0';
			szBuffer++;
		}
		//使得lcname的最后为两个0
		szBuffer[0] = '\0';
		szBuffer++;
		szBuffer[0] = '\0';	

		vecName.clear();
	}

	OutputLog("LCName处理之后:");
	OutputLogHex((byte*)pBuff+LC_POS_LISTENERS,256);

	return 0;
}
void CLocalConnection::PostErrorMsg(int errId)
{
	MYTRACE("PostErrMsg.ErrorId=%d",errId);
}

//0:表示有效的数据
int CLocalConnection::IParseData(byte* pBuff)
{
	byte *pc = (byte *)pBuff;
	byte *pt = pc;
	int cpt = 0;
	//判断头

	Header *pHeader = (Header*)pc;
	if(pHeader->a != 0x01 || pHeader->b!=0x01)
		return 1;
	if(pHeader->tickCount == 0)
		return 2;
	//消息长度
	int msgLen = pHeader->msgLen;

	CAMFStream stream;

	MYTRACE("有LocalConnection数据,现在解析它");
	MYTRACE("输出数据的前512字节");
	OutputLogHex(pBuff,512);
	MYTRACE("输出Listener信息");
	OutputLogHex(pBuff+LC_POS_LISTENERS,256);

	

	//第一个字段:类型:字符串 获取并判断LocalConnection Name.
	pt+=17;
	int lenName = stream.ReadU16(pt);
	pt+=2;
	TCHAR*  szName = stream.ReadString(pt,lenName);
	CAutoPtr<TCHAR>AA(szName);

	

	pt+=lenName;
	//新加的判断.如果数据中的lc,在listener中不存在.则数据清空
	if(true)
	{
		CString sz1;
		sz1.Format("%s",szName);
		if(!ICheckRegistedName(pBuff,sz1))
		{
			return 0;
		}
	}
	
	if(!ListLC_Select(szName))
	{
		return 3;
	}

	CReceiveData *pRd = new CReceiveData();
	//第二个字段:内存看写的localhost,string类型.
	pt++;
	lenName = stream.ReadU16(pt);
	pt+=2;
	TCHAR*szName2 = stream.ReadString(pt,lenName);
	CAutoPtr<TCHAR>AA2(szName2);
	MYTRACE("字段2:len=%d,name=%s",lenName,szName2);
	pt+=lenName;

	//有可能这里有个31个字节的可选字段.
	if(pt[0] == 0x01)
	{
		pt+=31;
	}
	else
	{
		MYTRACE("没有31字节的可选字段??");
		OutputLogHex(pBuff,256);
	}
	//第三个字段:方法名.字符串类型
	pt++;
	lenName = stream.ReadU16(pt);
	pt+=2;
	TCHAR *szName3 = stream.ReadString(pt,lenName);
	CAutoPtr<TCHAR>AA3(szName3);
	MYTRACE("字段3:方法名:len=%d,name=%s",lenName,szName3);
	pt+=lenName;

	pRd->m_szMethodName.Format("%s",szName3);

	int numLen = 0;
	CString sz1;
	//枚举每个参数
	while((pt-pBuff - 16) < msgLen)
	{
		/*
		Number = 0,Boolean = 1,String = 2,UntypedObject = 3,MovieClip = 4,Null = 5,Undefined = 6,ReferencedObject = 7,
		MixedArray = 8,End = 9,Array = 10,//0x0A Date = 11,//0x0B  LongString = 12,//0x0C   TypeAsObject = 13,//0x0D
		Recordset = 14,//0x0E     Xml = 15,//0x0F     TypedObject = 16,//0x10     AMF3data=17//0x11

		enum DataType
		{
		DT_UNDEFINED = 0x00,	//unsupport
		DT_NULL = 0x01,
		DT_FALSE = 0x02,
		DT_TRUE = 0x03,
		DT_INTEGER = 0x04,
		DT_DOUBLE = 0x05,
		DT_STRING = 0x06,
		DT_XMLDOC = 0x07,		//unsupport
		DT_DATE = 0x08,
		DT_ARRAY = 0x09,
		DT_OBJECT = 0x0A,
		DT_XML = 0x0B,			//unsupport
		DT_BYTEARRAY = 0x0C		
		};
		*/

		MYTRACE("参数类型:%d",pt[0]);
		if(pt[0] == 0x04)
		{
			pt++;

			lenName = stream.ReadInt29(pt,numLen);
			pt += numLen;
			MYTRACE("整形 参数:len=%d,value=%d",numLen,lenName);

			vt_struct vs;
			vs.vt = vt_int;
			vs.data.m_int = lenName;
			pRd->m_lstParas.push_back(vs);

		}
		else if(pt[0] == 0x05)
		{
			pt++;

			double d = stream.ReadNumber64(pt);
			MYTRACE("浮点型 参数,value=%f",d);
			pt+=8;

			vt_struct vs;
			vs.vt = vt_double;
			vs.data.m_double = d;

			pRd->m_lstParas.push_back(vs);
		}
		else if(pt[0] == 0x06)
		{
			//string
			pt++;
			lenName = stream.ReadInt29(pt,numLen);

			lenName=lenName>>1;

			pt += numLen;
			TCHAR*szt = stream.ReadString(pt,lenName);

			pt+=lenName;
			MYTRACE("字符串 参数:len=%d,name=%s",lenName,szt);

			sz1.Format("%s",szt);
			

			vt_struct vs;
			vs.vt = vt_string;
			vs.data.m_string = szt;
			pRd->m_lstParas.push_back(vs);
		}
		else if(pt[0] == 0x0C)
		{
			//bytearray
			pt++;
			lenName = stream.ReadInt29(pt,numLen);
			lenName = lenName>>1;

			pt += numLen;
			//后面是numLen长度的array
			char *pc = new char[lenName+1];
			memcpy(pc,pt,lenName);

			pt += lenName;
			MYTRACE("ByteArray 参数:长度=%d",lenName);

			vt_struct vs;
			vs.vt = vt_buffer;
			vs.data.m_buff.m_buffLen = lenName;
			vs.data.m_buff.m_buff = pc;
			pRd->m_lstParas.push_back(vs);
		}
		else
		{
			PostErrorMsg(ec_fc_unknown_type_param);
			MYTRACE("未处理的参数类型:%d",pt[0]);
			break;
		}
	}
	//发送到主线程处理
	OnFuncCallMsg(szName,pRd);
	return 0;
}
LRESULT CLocalConnection::OnFuncCallMsg(char *szName,CReceiveData *pd)
{
	MYTRACE("OnFuncCallMsg.LcName=%s,MethodName=%s",szName,pd->m_szMethodName);
	list<vt_struct>::iterator itr;
	CString szPara;
	for(itr=pd->m_lstParas.begin();itr!=pd->m_lstParas.end();itr++)
	{
		switch((*itr).vt)
		{
		case vt_int:
			MYTRACE("接收到的参数:%d",(*itr).data.m_int);
			break;
		case vt_double:
			MYTRACE("接收到的参数:%f",(*itr).data.m_double);
			break;
		case vt_string:
			MYTRACE("接收到的参数:%s",(*itr).data.m_string);
			break;
		case vt_buffer:
			MYTRACE("接收到的参数:ByteArray:长度为 %d",(*itr).data.m_buff.m_buffLen);
			break;
		default:
			MYTRACE("未写出的参数类型");
			break;
		}
		
	}

	//增加对回调的支持
	int ptr = this->MR_Get(szName,pd->m_szMethodName.GetBuffer());
	if(ptr == 0)
	{
		MYTRACE("没有对应的注册函数");
	}
	else
	{
		try
		{
			int size = pd->m_lstParas.size();
			if(size == 1)
			{
				typedef void (__stdcall *FUNC)(char*ptrPara);
				FUNC func = (FUNC)ptr;

				CAutoPtr<char>p1(pd->getParam(0));
				
				(*func)(p1);
			}
			else if(size == 2)
			{
				typedef void (__stdcall *FUNC)(char*ptrPara1,char*ptrPara2);
				FUNC func = (FUNC)ptr;

				CAutoPtr<char>p1(pd->getParam(0));
				CAutoPtr<char>p2(pd->getParam(1));

				(*func)(p1,p2);
			}
			else if(size == 3)
			{
				typedef void (__stdcall *FUNC)(char*ptrPara1,char*ptrPara2,char*ptrPara3);
				FUNC func = (FUNC)ptr;

				CAutoPtr<char>p1(pd->getParam(0));
				CAutoPtr<char>p2(pd->getParam(1));
				CAutoPtr<char>p3(pd->getParam(2));

				(*func)(p1,p2,p3);
			}
			else
			{
			}
			
		}
		catch(...)
		{
			MYTRACE("执行注册的回调函数出错!!!!!!!!!!!!!!!!!");
		}
	}

	//清空pd的内容	
	delete pd;

	return 0;

	/*
	CString *szBuff=new CString[pd->m_lstParas.size()];
	std::list<vt_struct>::const_iterator citr;

	int i = 0;
	for(citr=pd->m_lstParas.begin();citr!=pd->m_lstParas.end();citr++)
	{
		szBuff[i++].Format("%s",*citr);
	}

	//wparam:为参数个数
	//lparam:第一个参数为LocName,第二个参数为方法名,其后顺序为参数
	int num = 2+pd->m_lstParas.size();
	char **ary = new char*[num];
	int len = strlen(szName)+1;
	ary[0] = new char[len];
	::ZeroMemory(ary[0],len);
	strcpy(ary[0],szName);

	len = pd->m_szMethodName.GetLength()+1;
	ary[1] = new char[len];
	::ZeroMemory(ary[1],len);
	sprintf(ary[1],"%s",pd->m_szMethodName);

	for(int i=0;i<pd->m_lstParas.size();i++)
	{
		len = szBuff[i].GetLength()+1;
		ary[2+i] = new char[len];
		::ZeroMemory(ary[2+i],len);
		sprintf(ary[2+i],"%s",szBuff[i]);
	}

	HWND hWnd = ListLC_GetHWNDByName(szName);
	MYTRACE("HWND=%d,MsgId=%d,num=%d",hWnd,this->m_msgIdCall,num);
	::PostMessage(hWnd,this->m_msgIdCall,num,(LPARAM)ary);

	delete pd;
	delete []szBuff;

	*/
	
}

// 发送数据成功返回0;出错则返回1
int CLocalConnection::ISendData(byte *pBuff,CSendData &sd)
{
	::ZeroMemory(pBuff,16);
	//清空下内容
	::ZeroMemory((pBuff+16),LC_LEN_MESSAGE);
	DWORD dwTick = ::GetTickCount();

	BYTE bh[8]={0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00};
	::CopyMemory(pBuff,bh,8);
	::CopyMemory(pBuff+8,&dwTick,4);

	DWORD dwMsgLen = 0;

	CAMFStream stream;
	byte *pt = pBuff;
	int len = 0;
	pt+=16;
	stream.WriteStringH(pt,sd.m_szLcName,len);		pt+=len;	dwMsgLen+=len;
	stream.WriteStringH(pt,LC_DOMAIN_NAME,len);		pt+=len;	dwMsgLen+=len;

	//测试写两种方式都是可以的.可是区别在哪里呢?不知道这段的具体含义.
	//swf send的数据是这样的.
	BYTE ss[31]={0x01,0x01,0x01,0x00,0x00,0x40,0x08,0x00,0x00,0x00,
		0x00,0x00,0x00,0x00,0x40,0x22,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x40,0x08,0x00,0x00,0x00,0x00,0x00,
		0x00};
	//air send的数据是这样的.
	BYTE ss2[31]={0x01,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x00,0x40,0x24,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x40,0x08,0x00,0x00,0x00,0x00,0x00,
		0x00};
	::CopyMemory(pt,ss2,31);						pt+=31;		dwMsgLen+=31;
	stream.WriteStringH(pt,sd.m_szMethodName,len);	pt+=len;	dwMsgLen+=len;

	list<CString>::iterator itr;
	CString szPara;
	for(itr=sd.m_lstParas.begin();itr!=sd.m_lstParas.end();itr++)
	{
		OutputLog("要传送的参数:%s",(*itr));
		stream.WriteString(pt,(*itr),len);		pt+=len;	dwMsgLen+=len;
	}

	//写消息长度的头
	dwTick = dwMsgLen;
	::CopyMemory(pBuff+12,&dwMsgLen,4);	
	return 0;
}

int CLocalConnection::ICheckAndSendData(CSendData& sd)
{
	OutputLog("ICheckAndSendData.Bgn");
	OutputLog("ICheckAndSendData.LcName=%s,MethodName=%s",sd.m_szLcName,sd.m_szMethodName);
	list<CString>::iterator itr;
	CString szPara;
	for(itr=sd.m_lstParas.begin();itr!=sd.m_lstParas.end();itr++)
	{
		OutputLog("要传送的参数:%s",(*itr));
	}

	int rtv = 0;



	
	CTime tmBgn = CTime::GetCurrentTime();	

	while(true)
	{
		::Sleep(SLEEP_TIME);

		if(true)
		{
			//获取CriticalSection并赋值
			CAutoLCMutex lcMutex(static_cast<CLogModule*>(this));
			HANDLE hMutex = lcMutex.createMutex();
			if(hMutex == NULL)
			{
				PostErrorMsg(ec_mutex_create_failed);
				return 1;
			}

			DWORD dw = ::WaitForSingleObject(hMutex,SINGLE_WAIT_TIMEOUT);
			if(dw == WAIT_TIMEOUT)
			{
				OutputLog("WAIT_TIMEOUT.CheckAndSendData");
				//如果等待4秒还是没有获得信号,则不再检测,退出等待
				CTimeSpan ts = CTime::GetCurrentTime() - tmBgn;
				if(ts.GetTotalSeconds()<=4)
				{
					continue;
				}
				else
				{
					rtv = 2;
					break;
				}
			}
			else if(dw == WAIT_OBJECT_0|| dw ==WAIT_ABANDONED)
			{
				if(dw == WAIT_ABANDONED)
				{
					OutputLog("WAIT_ABANDONED.出现异常了.在获取了Mutex后出现异常导致Mutex没有释放.");
				}
				//检查是否时间戳为0
				CAutoReleaseMutex arMutex(hMutex);
				try
				{
					OutputLog("获取到信号了.");
					HANDLE hMf = ICreateFileMap();
					if(hMf != NULL)
					{
						//自动是否hMf
						CFMAutoPtr fap(hMf);

						OutputLog("获取到信号了.  1111");
						LPVOID lpvoid = ::MapViewOfFile(hMf,FILE_MAP_ALL_ACCESS,0,0,0);
						if(lpvoid !=NULL)
						{
							CUnMapAutoPtr umap(lpvoid);
							OutputLog("获取到信号了.  2222");
							try
							{
								OutputLog("在这里做操作");
								DWORD *dwTick = (DWORD*)((byte*)lpvoid+8);
								if(*dwTick == 0)
								{
									if(ICheckRegistedName((byte*)lpvoid,sd.m_szLcName))
									{
										//可以写数据了								
										ISendData((byte*)lpvoid,sd);
									}
									else
									{
										rtv = 3;
									}								
									break;
								}
								else
								{
									CTime tmEnd = CTime::GetCurrentTime();
									CTimeSpan ts = tmEnd - tmBgn;
									if(ts.GetTotalSeconds() >= 4)
									{
										//强制写数据
										OutputLog("等待超过4秒,强制写数据");
										if(ICheckRegistedName((byte*)lpvoid,sd.m_szLcName))
										{
											//可以写数据了								
											ISendData((byte*)lpvoid,sd);
											rtv = 4;
										}
										else
										{
											rtv = 3;
										}
										break;
									}
								}
							}
							catch(...)
							{
								OutputLog("捕获未知异常11");
								rtv = 5;
								break;
							}						
						}
					}
					else
					{
						DWORD dwCode = ::GetLastError();
						OutputLog("GetLastError().=%d ",dwCode);
						rtv = 6;
						break;
					}
				}
				catch(...)
				{
					OutputLog("捕获未知异常22");
					rtv = 7;
					break;
				}
			}
		}
	}
	OutputLog("ICheckAndSendData.End");
	return rtv;
}

CLocalConnection *CLocalConnection::m_stLocalConnection = NULL;

CLocalConnection *CLocalConnection::getInstance()
{
	if(	m_stLocalConnection == NULL)
	{
		m_stLocalConnection = new CLocalConnection();
	}
	return m_stLocalConnection;
}
// 注册一个LC方法的回调函数
int CLocalConnection::MethodRegister(char* szLcName, char* szMethodName, int funCallBackPtr)
{
	//加入一个列表.多线程控制
	//如果已存在同名的函数注册,则修改.否则添加
	m_csMR.Lock();	
	
	list<CLCRegistedMethod>::iterator itr;
	for(itr=m_lstMethod.begin();itr!=m_lstMethod.end();itr++)
	{
		if((!strcmp(szLcName,(*itr).m_szLCName)) && (!strcmp(szMethodName,(*itr).m_szMethodName)))
		{
			//找到了
			(*itr).m_funPtr=funCallBackPtr;
		}
	}
	if(itr == m_lstMethod.end())
	{
		//说明没找到
		CLCRegistedMethod method(szLcName,szMethodName,funCallBackPtr);
		m_lstMethod.push_back(method);
	}
	m_csMR.Unlock();
	return 0;
}
