 // MMC.cpp : ���� DLL �ĳ�ʼ�����̡�
//

#include "stdafx.h"
//#include <iostream>

#include "MMC.h"
#include "LocalConnection.h"

#include <Winsock2.h>   
#include <malloc.h>   

#include "Mstcpip.h"


//#include "ErrorMessage.h"

#pragma comment(lib,"Ws2_32.lib")  
CComAutoCriticalSection g_objectCComAutoCriticalSection;

//#include "DataStruct.h"
//#include "ClientSocket.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define CONNECTTIMEOUT 10000
#define THREADQUITTIME 30000
#define RECVTIMEOUT 60000
#define MAXMESSAGELENGTH 1000


struct ST_THREAD_PARAM   
{   
	SOCKET socket;   
	WSAEVENT wsaEvent;   
}; 
SOCKET g_socketServer = INVALID_SOCKET;   
WSAEVENT g_wsaEvent = WSA_INVALID_EVENT;   
ST_THREAD_PARAM* pThreadParam;
HANDLE hThread;
//CWinThread* pCWinThread;
int SendPackge(SOCKET s);
int Receive(SOCKET s);

CEvent EventConnectOper;

int iError;

CEvent EventConnectFava;
//int iErrorConnectFava;
CEvent EventPlayerFava1012;
CEvent EventPlayerFava1013;
CEvent EventPlayerFava1014;
CEvent EventExitBack;




CEvent EventSend;
CEvent EventExit;
CEvent EventSendFromFlex;


//static int g_iClosesignal=0;
static int g_LCStatusFlag=0;

//char* g_ObjectLCConnection;

CErrorMessage g_CErrorMessage;
extern "C" _declspec(dllexport) int __stdcall MMLCConnect(int flag ,void * Pin);
void WINAPI ReceiveFromLC( int flag,char *lcName,char *methodName,void *ptrPara1,void *ptrPara2,void *ptrPara3);

typedef int (WINAPI *PFCALLBACK)(int flag,void * Pin) ;
typedef int (WINAPI *ECallBack)(int Event,int EFlag,void * Pin) ;

PFCALLBACK  DataCallBackFunc;
ECallBack  EventCallBackFunc;

CClientSocket* global_socket;





//////////////////////////////////////////////////
///////////////////////////////////////////////////////

int NameAddressConvert(const char* in_host_name,CString* out_IPAddress)
{
	int WSA_return;
	WSADATA WSAData;

	int ret=0;
	/*******************************************************************
	ʹ��Socket�ĳ�����ʹ��Socket֮ǰ�������WSAStartup������
	�ú����ĵ�һ������ָ����������ʹ�õ�Socket�汾��
	���и�λ�ֽ�ָ�����汾����λ�ֽ�ָ�����汾��
	����ϵͳ���õڶ����������������Socket�İ汾��Ϣ��
	��һ��Ӧ�ó������WSAStartup����ʱ������ϵͳ���������Socket�汾��������Ӧ��Socket�⣬
	Ȼ����ҵ���Socket�⵽��Ӧ�ó����С�
	�Ժ�Ӧ�ó���Ϳ��Ե����������Socket���е�����Socket�����ˡ�
	�ú���ִ�гɹ��󷵻�0��
	*****************************************************************/
	WSA_return=WSAStartup(0x0101,&WSAData);

	/* �ṹָ�� */ 
	HOSTENT *host_entry;

	/* ��ַ: http://www.google.cn/ */
	//char host_name[256] ="www.google.com";

	if(WSA_return==0)
	{
		/* ��Ҫ������������������ */
		host_entry=gethostbyname(in_host_name);
		ret=WSAGetLastError();
		//printf("%s\n", host_name);
		if(host_entry!=0)
		{
			//printf("����IP��ַ: ");
			(*out_IPAddress).Format("%d.%d.%d.%d",
				(host_entry->h_addr_list[0][0]&0x00ff),
				(host_entry->h_addr_list[0][1]&0x00ff),
				(host_entry->h_addr_list[0][2]&0x00ff),
				(host_entry->h_addr_list[0][3]&0x00ff));

			WSACleanup();
			return 0;

		}
		else
		{
			WSACleanup();
			return ret;
		}
	}
	//WSACleanup();



}


///////////////////////////////////////////////////
BOOL SetNetWorkKeepAlive(SOCKET s)
{


	BOOL bKeepAlive = TRUE;


	int nRet = ::setsockopt(s, SOL_SOCKET, SO_KEEPALIVE, (char*)&bKeepAlive, sizeof(bKeepAlive));


	if (nRet == SOCKET_ERROR)


	{


		return FALSE;


	}


	// ����KeepAlive����


	tcp_keepalive alive_in                = {0};


	tcp_keepalive alive_out                = {0};


	alive_in.keepalivetime                = 3000;                // ��ʼ�״�KeepAlive̽��ǰ��TCP�ձ�ʱ��//̽��ʱ����


	alive_in.keepaliveinterval        = 3000;                // ����KeepAlive̽����ʱ����


	alive_in.onoff                                = TRUE;


	unsigned long ulBytesReturn = 0;


	nRet = WSAIoctl(s, SIO_KEEPALIVE_VALS, &alive_in, sizeof(alive_in),


		&alive_out, sizeof(alive_out), &ulBytesReturn, NULL, NULL);


	if (nRet == SOCKET_ERROR)


	{


		return FALSE;


	}
	return TRUE;




}

void InitSock()   
{   
	WORD wVersionRequested;   
	WSADATA wsaData;   
	int err;   
	wVersionRequested = MAKEWORD( 2, 2 );   
	err = WSAStartup( wVersionRequested, &wsaData );   
	if ( err != 0 ) {   
		/* Tell the user that we could not find a usable */  
		/* WinSock DLL.                                  */  
		return;   
	}   

	/* Confirm that the WinSock DLL supports 2.2.        */  
	/* Note that if the DLL supports versions greater    */  
	/* than 2.2 in addition to 2.2, it will still return */  
	/* 2.2 in wVersion since that is the version we      */  
	/* requested.                                        */  
	if ( LOBYTE( wsaData.wVersion ) != 2 ||   
		HIBYTE( wsaData.wVersion ) != 2 ) {   
			/* Tell the user that we could not find a usable */  
			/* WinSock DLL.                                  */  
			WSACleanup( );   
			return;    
	}   
}   

void UnInitSock()   
{   
	if (g_wsaEvent != WSA_INVALID_EVENT)   
	{   
		WSACloseEvent(g_wsaEvent);   
	}   
	if (g_socketServer != INVALID_SOCKET)   
	{   
		closesocket(g_socketServer);   
		g_socketServer = INVALID_SOCKET; 
	}   
	WSACleanup();   


}   


///////////////////////////////////////////
DWORD WINAPI ServiceThread(LPVOID lpThreadParameter)  
//UINT ServiceThread( LPVOID lpThreadParameter )
//unsigned int WINAPI ServiceThread(void* lpThreadParameter)  
////////////////////////////////////////////////
{   

	::CoInitialize(NULL);
	

	ST_THREAD_PARAM* pThread = (ST_THREAD_PARAM*)lpThreadParameter;   
	SOCKET socketServer = pThread->socket;   
	WSAEVENT wsaEvent = pThread->wsaEvent;   
////////////////////////////
	HANDLE hmultihandle[4];
	hmultihandle[0]=wsaEvent;
	hmultihandle[1]=EventExit.m_hObject;
	hmultihandle[2]=EventSend.m_hObject;
	hmultihandle[3]=EventSendFromFlex.m_hObject;


	TRACE("���߳�%d��/n",GetCurrentThreadId());   

	try
	{

		while(true)   
		{   
			int nRet=::WSAWaitForMultipleEvents(4,hmultihandle,FALSE,10000,FALSE);  
			TRACE("WSAWaitForMultipleEvents %d",nRet);
			if(nRet==WAIT_FAILED) // ʧ��   
			{   
				 ///////////////////////////////
				TRACE("failed WSAWaitForMultipleEvents/n");   
				THROW(1); 
				break;   
			}   
			else if(nRet==WSA_WAIT_TIMEOUT) // ��ʱ   
			{   
				TRACE(" WSA_WAIT_TIMEOUT ... /n");
				//////////////////////////////////
				/*		int i=0;
				THROW(i);*/
				///////////////////////////////////////////
				continue;   
			}   
			else if (nRet==WSA_WAIT_EVENT_0)

				// �ɹ� -- �����¼�����   
			{   
				WSANETWORKEVENTS wsaNetEvent;   
				::WSAEnumNetworkEvents(socketServer,wsaEvent,&wsaNetEvent);   
				TRACE("WSAEnumNetworkEvents",nRet);
				if(wsaNetEvent.lNetworkEvents&FD_READ)   
				{      
					g_objectCComAutoCriticalSection.Lock();
					Receive(g_socketServer);
					g_objectCComAutoCriticalSection.Unlock();
					

				}   
				else if(wsaNetEvent.lNetworkEvents&FD_WRITE)   
				{   

					g_objectCComAutoCriticalSection.Lock();
					SendPackge(g_socketServer);
					g_objectCComAutoCriticalSection.Unlock();
					EventSend.ResetEvent();
					  
				}   
				if(wsaNetEvent.lNetworkEvents&FD_CLOSE)   
				{   
					TRACE("FD_CLOSE event occurs.../n");   
					int nErrorCode = WSAGetLastError();   
					TRACE("Error code is %d/n",nErrorCode);   
					if (nErrorCode == WSAECONNRESET)   
					{   
						TRACE("WSAECONNRESET error./n");   
					}   
					else if (nErrorCode == WSAENETDOWN)   
					{   
						TRACE("WSAENETDOWN error./n");   
					}   
					else if (nErrorCode == WSAENETRESET)   
					{   
						TRACE("WSAENETRESET error./n");   
					}   
					THROW(1);


					



					TRACE("�߳�%d�˳�/n",GetCurrentThreadId()); 
					TRACE("�߳�%d�˳�/n",GetCurrentThreadId()); 


					return 0; 
					TRACE("�޷�ִ�еĴ���");
				}   
			}  
			else if (nRet==WSA_WAIT_EVENT_0+1)
			{

				THROW(2);
				
				return 0; 
				TRACE("�޷�ִ�еĴ���");
			}

			else if (nRet==WSA_WAIT_EVENT_0+2)
			{
				EventSend.ResetEvent();
				g_objectCComAutoCriticalSection.Lock();
				int i=SendPackge(g_socketServer);
				g_objectCComAutoCriticalSection.Unlock();
				//send ����
			}
			else if (nRet==WSA_WAIT_EVENT_0+3)
			{
				EventSendFromFlex.ResetEvent();
				g_objectCComAutoCriticalSection.Lock();
				int i=SendPackge(g_socketServer);
				g_objectCComAutoCriticalSection.Unlock();
				//send ����
			}
		}  



	}
	catch(int& j)
	{


		TRACE("�߳�%d�˳�/n",GetCurrentThreadId()); 
		TRACE("�߳�%d�˳�/n",GetCurrentThreadId());

		if (j==1)
		{
			(*EventCallBackFunc)(2,0,NULL);
			UnInitSock();
			delete global_socket;
		}
		 
		if (j==2)
		{

			UnInitSock();
			delete global_socket;
			EventExit.ResetEvent();
           EventExitBack.SetEvent();
		}
		return 0;


	}
	catch (CMemoryException* e)
	{
		
	}
	catch (CFileException* e)
	{
	}
	catch (CException* e)
	{
	}
	 



	TRACE("�߳�1%d�˳�/n",GetCurrentThreadId());   

	EventExit.SetEvent();
	return 0;   
}  




#pragma comment(lib, "json_vc71_libmtd.lib");
LPSTR ConvertErrorCodeToString(DWORD ErrorCode)
{
	HLOCAL LocalAddress=NULL;
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_IGNORE_INSERTS|FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,ErrorCode,0,(PTSTR)&LocalAddress,0,NULL);
	return (LPSTR)LocalAddress;
}







extern "C" _declspec(dllexport) int __stdcall GetSockStatus()

{


	if (g_socketServer != INVALID_SOCKET)   
	{
		return 0;
	}
	else
	{
		return 30020;
	}


}

extern "C" _declspec(dllexport) int __stdcall Connect(const char* ipAddr,int nPort)

{
	try
	{



		TRACE("����Connect");

		if (GetSockStatus()==0)
		{
			return 30003;
		}


		///////////////////////////////////////////////

		CString cstr_ipaddr;
		int ret=0;
		ret=NameAddressConvert(ipAddr,&cstr_ipaddr);
		if (ret==0)
		{
           TRACE("NameAddressConvert ת���ɹ� ��ַ %s",cstr_ipaddr);
		}
		else
		{
              return ret;
		}


		///////////////////////////////////////////////

		InitSock();   
		g_socketServer=socket(AF_INET,SOCK_STREAM,0);   
		if (g_socketServer == INVALID_SOCKET)   
		{   
			UnInitSock();   
			return GetLastError();   
		}   
		sockaddr_in sin;   
		sin.sin_addr.S_un.S_addr=inet_addr((const char*)cstr_ipaddr);   
		sin.sin_family=AF_INET;   
		sin.sin_port=htons(nPort);     
		int iret;


		while(true)
		{  

			iret=connect(g_socketServer,(sockaddr*)&sin,sizeof(sockaddr));
			if (iret == SOCKET_ERROR)   
			{   iret=WSAGetLastError();

			if (iret==WSAEISCONN)
			{
				break;
			}


			if ((iret !=  WSAEWOULDBLOCK)&&(iret!=WSAEALREADY))
			{
				UnInitSock();   
				return iret;  
			}


			}
			else
			{
				break;
			}
		}

		BOOL iKeepAlive=SetNetWorkKeepAlive(g_socketServer);
		if (iKeepAlive==TRUE)
		{
			TRACE("SetNetWorkKeepAlive TRUE");
			TRACE("SetNetWorkKeepAlive TRUE");
		}
		else
		{
			TRACE("SetNetWorkKeepAlive FALSE");
			TRACE("SetNetWorkKeepAlive FALSE");

		}




		g_wsaEvent=::WSACreateEvent();   
		::WSAEventSelect(g_socketServer,g_wsaEvent,FD_READ|FD_WRITE|FD_CLOSE);   

		pThreadParam = new ST_THREAD_PARAM();   
		pThreadParam->socket = g_socketServer;   
		pThreadParam->wsaEvent = g_wsaEvent;   

		global_socket=new CClientSocket();
		////////////////////////////////////////////////////////////
		//pCWinThread= AfxBeginThread(ServiceThread, pThreadParam);
		hThread = ::CreateThread(NULL,0,ServiceThread,(LPVOID)pThreadParam,0,NULL);  
		//hThread =(HANDLE) _beginthreadex(NULL,0,ServiceThread,(LPVOID)pThreadParam,0,NULL);  
		///////////////////////////////////////////////////////
		if (hThread == INVALID_HANDLE_VALUE)   
		{   
			TRACE("Failed to create new thread...\n");   
			UnInitSock();   
			return GetLastError();   
		} 

		//CloseHandle(hThread);
		TRACE("threadid---- %d",hThread);
		return 0;



	}
	catch (CMemoryException* e)
	{
		return 30050;
	}
	catch (CFileException* e)
	{
		return 30051;

	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
        return 30053;
	}
	

}




extern "C" _declspec(dllexport) int __stdcall SetSockClose()

{

	try
	{



		TRACE("����SetSockClose1");

		if (GetSockStatus()!=0)
		{
			return 0;
		}




		if (g_socketServer != INVALID_SOCKET)   
		{
			//g_iClosesignal=1;////��������

			EventExitBack.ResetEvent();
			EventExit.SetEvent();


			//shutdown(g_socketServer,SD_SEND);
			TRACE("��ʼ�ȴ�");
			TRACE("threadid %d",hThread);



			WaitForSingleObject(EventExitBack,THREADQUITTIME);//hThread

			CloseHandle(hThread);
			///////////////////////
			//Sleep(500);

			//_endthreadex((unsigned int)hThread);

			TRACE("�ȴ�����");
			//Sleep(500);
			TRACE("WaitForSingleObject(hThread,INFINITE) return ...\n");   
			TRACE("���߳��˳�");
			delete pThreadParam;
			return 0;
		}



		return 0;



	}
	catch (CMemoryException* e)
	{
		return 30050;
		
	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
		return 30053;

	}




}



//extern "C" _declspec(dllexport) int __stdcall SetSockCloseNei()
//
//{
//	TRACE("����SetSockCloseNei");
//
//	if (GetSockStatus()!=0)
//	{
//		return 0;
//	}
//
//
//
//
//	if (g_socketServer != INVALID_SOCKET)   
//	{
//		//g_iClosesignal=2;////��������
//
//		EventExit.ResetEvent();
//
//		shutdown(g_socketServer,SD_SEND);
//		TRACE("��ʼ�ȴ�");
//		TRACE("threadid %d",hThread);
//		
//
//		
//
//		WaitForSingleObject(EventExit,THREADQUITTIME);//hThread
//
//		
//		CloseHandle(hThread);
//		///////////////////////
//		//Sleep(500);
//
//		//_endthreadex((unsigned int)hThread);
//
//		TRACE("�ȴ�����");
//		//Sleep(500);
//		TRACE("WaitForSingleObject(hThread,INFINITE) return ...\n");   
//		TRACE("���߳��˳�");
//		delete pThreadParam;
//		return 0;
//	}
//
//
//
//	return 0;
//
//}



//����ΪDelphi�������ݰ�
extern "C" _declspec(dllexport) int __stdcall Send(int flag,void * Pin)

{

	try
	{


		if (flag==1||flag==2||flag==3)
		{

		
		if (g_LCStatusFlag<=1 )
		{	
			
			return MMLCConnect(flag,Pin);
			

		}
		else
		{
			return 30040;
		}

		}




		if (flag==1003)
		{
			if (strlen(((SingleFava*)Pin)->chatTxt)>1000)
			{
				return 30030;
			}

		}

		TRACE("����Send flag:%d",flag);

		if (GetSockStatus()!=0)
		{
			return GetSockStatus();
		}

		g_objectCComAutoCriticalSection.Lock();
		CDataClass * pCDataClass=new CDataClass(flag,Pin);	
		global_socket->ListInPacket_Push(pCDataClass);
		/*int i=SendPackge(g_socketServer);*/

		g_objectCComAutoCriticalSection.Unlock();
		EventSend.SetEvent();
		//global_socket.AsyncSelect(FD_WRITE);
		return 0;



	}
	catch (CMemoryException* e)
	{
		return 30050;
		
	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
       return 30053;
	}

	// return 0;

	
}


//1������

extern "C" _declspec(dllexport) int __stdcall MMLCConnect(int flag ,void * Pin)
{


	switch(((PLCControlFava*)Pin)->szFlag)
	{
	case 1:
		return LC_Send("_R3_XSM",((PLCControlFava*)Pin)->szMethodName,((PLCControlFava*)Pin)->szPara1);
		break;
	case 2:
		return LC_Send2("_R3_XSM",((PLCControlFava*)Pin)->szMethodName,((PLCControlFava*)Pin)->szPara1,((PLCControlFava*)Pin)->szPara2);
		break;
	case 3:
		return LC_Send3("_R3_XSM",((PLCControlFava*)Pin)->szMethodName,((PLCControlFava*)Pin)->szPara1,((PLCControlFava*)Pin)->szPara2,((PLCControlFava*)Pin)->szPara3);
		break;
	default:
		return 0;
		break;
	}


}


int LC_ConnectionOper(int Eflag)
{
	if (Eflag==1)//��ʼ��
	{
		g_LCStatusFlag=CLocalConnection::getInstance()->Close("_R3_XSM");
		if (g_LCStatusFlag<=1 )
		{
			CLocalConnection::getInstance()->Close("_XSM_R3");
			CLocalConnection::getInstance()->Close("xinshangmeng.com:xsmapp");

				CLocalConnection::getInstance()->Close("10.13.25.73:xsmapp");

			CLocalConnection::getInstance()->Connect("_XSM_R3");
			CLocalConnection::getInstance()->Connect("_webToAir");
			CLocalConnection::getInstance()->FunConfig((int)ReceiveFromLC,0);
			return 0;

			//CLocalConnection::getInstance()->MethodRegister("_XSM_R3","ReceiveFromLC",(int)ReceiveFromLC);
		}
		return 30040;
	}
	if (Eflag==2)//����
	{
		if (g_LCStatusFlag<=1 )
		{

			CLocalConnection::getInstance()->Close("_XSM_R3");
			CLocalConnection::getInstance()->FinalRelease();
		}

		delete CLocalConnection::getInstance();
	}
	if (Eflag==3)//������������
	{

	}
	if (Eflag==4)//Delphi������`
	{

	}
	

return 0;
}

void WINAPI ReceiveFromLC( int flag,char *lcName,char *methodName,void *ptrPara1,void *ptrPara2,void *ptrPara3)
{



	try
	{



		TRACE("ReceiveFromLC flag:%d,%s,%s",flag,lcName,methodName );

		if (strcmp(lcName,"_XSM_R3")==0)
		{

			if (DataCallBackFunc==NULL)
			{

				TRACE("DataCallBackFunc,NULL");
			}
			else
			{

				PLCControlFava* pPLCControlFava=new PLCControlFava();

				pPLCControlFava->szFlag=flag;
				pPLCControlFava->szMethodName=methodName;
				pPLCControlFava->szPara1=(char*)ptrPara1;
				pPLCControlFava->szPara2=(char*)ptrPara2;
				pPLCControlFava->szPara3=(char*)ptrPara3;

				TRACE("��������XSMtoR3 �ص�����");
				g_objectCComAutoCriticalSection.Lock();
				(*DataCallBackFunc)(flag,(void*)pPLCControlFava);
				g_objectCComAutoCriticalSection.Unlock();
				TRACE(" �ص���������");

				delete pPLCControlFava;
			}


			return ;
		}

		if (strcmp(lcName,"_webToAir")==0)
		{
			TRACE("���� _webToAir");

			if (strcmp(methodName,"webToAirHandler")==0)
			{

				TRACE("���� webToAirHandler");
				TRACE("webToAirHandler");



				if (GetSockStatus()!=0)
				{
					TRACE("���� ������");
					return;
				}

				TRACE("���� ����");
				g_objectCComAutoCriticalSection.Lock();

				CDataClass * pCDataClass=new CDataClass((BYTE*)ptrPara1);


				global_socket->ListInPacket.push(pCDataClass);
				g_objectCComAutoCriticalSection.Unlock();

				EventSendFromFlex.SetEvent();

				/*int i=SendPackge(g_socketServer);*/

				//global_socket.AsyncSelect(FD_WRITE);
				//return i;
				return;


			}




		}

		return;






	}
	catch (CMemoryException* e)
	{
			return;
	}
	catch (CFileException* e)
	{
			return;
	}
	catch (CException* e)
	{
			return;
	}
	catch(...)
	{
			return;

	}


}

extern "C" _declspec(dllexport) int __stdcall LoadLC()
{
	try
	{
			return LC_ConnectionOper(1);
	}
	catch (CMemoryException* e)
	{
		return 30050;
	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
		return 30053;

	}


}

///////////////////////////////////////////

int SendPackge(SOCKET s)
{
	
	
	TRACE("����SendPackge");
	TRACE("����SendPackge");
	int nError;
	while (global_socket->ListInPacket_GetSize()>0)
	{
		CDataClass *pDataClass = global_socket->ListInPacket_GetFront();

		int dwBytes;
		dwBytes = send(s,(const char*)(pDataClass)->data_AfterOper.BP, (pDataClass)->data_AfterOper.iDataInArrayLen,0);
		TRACE("����send ���� �ֽ�%d",dwBytes);
		if (dwBytes == SOCKET_ERROR)
		{
			TRACE("����send ���� �ֽ�%d",dwBytes);

			nError=WSAGetLastError();
			if (nError == WSAEWOULDBLOCK) 
			{
				return nError;
			}
			else
			{
				//shutdown(g_socketServer,SD_SEND);;
				//UnInitSock();

				THROW(1);

				return nError;

			}
		}
		else// ���η��ͳɹ���
		{
			TRACE("���ͳɹ�");
			if (dwBytes==(pDataClass)->data_AfterOper.iDataInArrayLen)
			{//���ڵ㷢����
				TRACE("�ڵ㷢�����");
				TRACE("���η����ֽ��� %d",dwBytes);
				//AsyncSelect(FD_READ);
				//delete  (global_socket->ListInPacket.front());
				//global_socket->ListInPacket.pop();
				global_socket->ListInPacket_DeleteFront();


			}
			else
			{//��û����
				TRACE(" ���ڵ�û����");
				BYTE temp[65536];
				memset(temp,0x00,65536);
				memcpy(temp,&((pDataClass)->data_AfterOper.BP[0])+dwBytes,(pDataClass)->data_AfterOper.iDataInArrayLen-dwBytes);
				memset((pDataClass)->data_AfterOper.BP,0x00,65536);
				memcpy((pDataClass)->data_AfterOper.BP,temp,65536);
				(pDataClass)->data_AfterOper.iDataInArrayLen=(pDataClass)->data_AfterOper.iDataInArrayLen-dwBytes;


			}
			//m_nBytesSent += dwBytes;
		}
	}
}
int Receive(SOCKET s)
{
	////////////////////////////////////
	//static int i=0;

	TRACE("���һ��OnReceive�¼�");
	//i++;
	/*BYTE * pRightEndTemp;*/

	BYTE buff[65536];
	memset(buff,0x00,65536);
	int nRead;
	nRead = recv(s,(char*)buff, 65536,0); 
	TRACE("�Ѿ��������� ����%d",nRead);
	switch (nRead)
	{
	case 0:
		//SetSockClose();
		//closesocket(g_socketServer);
		//UnInitSock();   

		TRACE("��ʼ�ر�����");
		//shutdown(g_socketServer,SD_SEND);
		/*EventExit.SetEvent();*/
		THROW(1);

		return WSAGetLastError();
		//case -1:
		//	Close();
		//	break;
	case SOCKET_ERROR:
		if (GetLastError() != WSAEWOULDBLOCK) 
		{
			TRACE("�յ�WSAEWOULDBLOCK");
			//AfxMessageBox ("Error occurred");
			//SetSockClose();
			//UnInitSock();  
			//shutdown(g_socketServer,SD_SEND);
			/*EventExit.SetEvent();*/
			THROW(1);
			return WSAGetLastError();
		}
		else
		{
			return WSAEWOULDBLOCK;
		}

	default://���յ�������
		TRACE("���յ�������");

		if (global_socket->pDataEnd==&(global_socket->pRecvOriginal[0]))//������Ϊ��
		{

			memcpy(global_socket->pDataEnd,buff,nRead);
			global_socket->pDataEnd=global_socket->pDataEnd+nRead-1;
		}
		else
		{//������������
			memcpy(global_socket->pDataEnd+1,buff,nRead);
			global_socket->pDataEnd=global_socket->pDataEnd+1+nRead-1;//    +nRead-1;


		}

	    while(global_socket->pDataEnd-&(global_socket->pRecvOriginal[0]) > 21)
	    
		
	  {
			BYTE * pRightEndTemp;
		
		int i=global_socket->CheckWheaverHaveRightData(&pRightEndTemp);


		TRACE("����CheckWheaverHaveRightData %d",i);
		if (i==1)//��ȷ��

		{
			TRACE("��ȷ���ݰ�");

			DataReved * pDataReved=new DataReved(global_socket->pHead,pRightEndTemp);
			TRACE("��װ���ն��� %d",pDataReved->routeType);
			if (pDataReved->routeType==0||pDataReved->routeType==1)//flex
			{

				/*LC_NSend("LCFlexClient","LCFlexRecvFromNetWork",4,pDataReved->byteDataRecvOrigianl,pDataReved->lengthofbyteDataRecvOrigianl);*/
				
				if (g_LCStatusFlag<=1 )
				{
					LC_NSend("_airToWeb","airToWebHandler",4,pDataReved->byteDataRecvOrigianl,pDataReved->lengthofbyteDataRecvOrigianl);
				}
				//to lC control
			}
			if (pDataReved->routeType==0||pDataReved->routeType==1)//flex
			{
				TRACE("to mm flag %d",pDataReved->flag);
				if (pDataReved->flag==1000)
				{
					TRACE("����EventConnectFava");
					//::SetEvent(hEvent);
					if (strcmp("yes",((ConnectFava*)pDataReved->p_ToDelphiData)->status)==0)
					{ iError=0;
					TRACE("yes");

					Sleep(500);
					EventConnectFava.SetEvent();

					}
					else
					{
						TRACE("no");
						iError=30011;
						Sleep(500);

						EventConnectFava.SetEvent();

					}

				}
				if (pDataReved->flag==1012)
				{

					TRACE("����EventConnectFava");
					//::SetEvent(hEvent);
					if (((PlayerFava*)pDataReved->p_ToDelphiData)->playerStatus==0||((PlayerFava*)pDataReved->p_ToDelphiData)->playerStatus==1)
					{ 
						//iError=((PlayerFava*)pDataReved->p_ToDelphiData)->playerStatus;
						iError=0;
						TRACE("yes");

						Sleep(500);
						EventPlayerFava1012.SetEvent();

					}
					else
					{
						TRACE("no");
						iError=30012;
						Sleep(500);

						EventPlayerFava1012.SetEvent();

					}
					//EventPlayerFava1012.SetEvent();

				}
				if (pDataReved->flag==1013)
				{

					TRACE("����EventConnectFava");
					//::SetEvent(hEvent);
					if (((PlayerFava*)pDataReved->p_ToDelphiData)->playerSkill==0)
					{ 
						iError=((PlayerFava*)pDataReved->p_ToDelphiData)->playerSkill;
						TRACE("yes");

						Sleep(500);
						EventPlayerFava1013.SetEvent();

					}
					else
					{
						TRACE("no");
						iError=30013;
						Sleep(500);

						EventPlayerFava1013.SetEvent();

					}
					//EventPlayerFava1013.SetEvent();

				}
				if (pDataReved->flag==1014)
				{
					EventPlayerFava1014.SetEvent();

				}
				if ((pDataReved->flag!=1000)&&(pDataReved->flag!=1012)&&(pDataReved->flag!=1013)&&(pDataReved->flag!=1014))
				{//�ص�����

					    TRACE("���ûص�������%d",pDataReved->flag);
						TRACE("����SetDataCallBack��%d",DataCallBackFunc);
						TRACE(",pDataReved->p_ToDelphiData ,%d",pDataReved->p_ToDelphiData);
					(*DataCallBackFunc)(pDataReved->flag,pDataReved->p_ToDelphiData);
					TRACE(",������� pDataReved->p_ToDelphiData ,%d",pDataReved->p_ToDelphiData);


				}


			}
			delete pDataReved;

			TRACE("���� pDataReved");
			TRACE("����ClearOneDataZone");
			global_socket->ClearOneDataZone(pRightEndTemp+1);

		}
		if (i==2)//�ҵ�����������ƫ�����ͳ��Ȳ��ʺ� ������������,�������� 
		{
			global_socket->ClearOneDataZone(pRightEndTemp+1);
		}
		if (i==3)//3//���ޣ����� ȫ��
		{
			//memset(pRecvOriginal,0x00,65536);
			memset(global_socket->pRecvOriginal,0x00,65536);
			global_socket->pDataEnd=global_socket->pRecvOriginal;
			global_socket->pHead=global_socket->pRecvOriginal;
			global_socket->pRightEnd=global_socket->pRecvOriginal;
		}
		if (i==4)//4;//����Ч���ݽ�β��û�з��ֽ����������ݱ���
		{
           break;
		}
	  }

		
	}
}
extern "C" _declspec(dllexport) int __stdcall SendSync(int flag,void * Pin)

{

	try
	{


		if (flag==1003)
		{
			if (strlen(((SingleFava*)Pin)->chatTxt)>MAXMESSAGELENGTH)
			{
				return 30030;
			}

		}

		if (GetSockStatus()!=0)
		{
			return GetSockStatus();
		}

		TRACE("����SendSync flag:%d",flag);
		TRACE("����SendSync flag:%d",flag);


		DWORD iErrorNo;
		DWORD iRetWait;



		g_objectCComAutoCriticalSection.Lock();
		TRACE("��ʼ��֯����\n");
		CDataClass * pCDataClass=new CDataClass(flag,Pin);
		//global_socket->ListInPacket.push(pCDataClass);
		global_socket->ListInPacket_Push(pCDataClass);
		g_objectCComAutoCriticalSection.Unlock();
		EventSend.SetEvent();

		//global_socket.AsyncSelect(FD_WRITE);
		TRACE("������ȫ����");
		TRACE("������ȫ���� ��ʼ���÷���");
		//int i=SendPackge(g_socketServer);
		//	g_objectCComAutoCriticalSection.Unlock();
		if (flag==1000)
		{

			TRACE("1000�ڵ� ��ʼ�ȴ�");
			TRACE("��ʼ�ȴ�1000");
			BOOL i=EventConnectFava.ResetEvent();

			int dRet=WaitForSingleObject(EventConnectFava,RECVTIMEOUT);


			TRACE("WaitForSingleObject�˳�");

			if(dRet == WAIT_TIMEOUT)
			{
				TRACE("WaitForSingleObject��ʱ");
				EventExit.SetEvent();
				return 1460;

			}
			else if(dRet == WAIT_OBJECT_0)
			{
				TRACE("WaitForSingleObject�����˳�1000________________ iError: %d",iError);
				TRACE("�����˳�1000________________");
				return iError;
			}






		}
		if (flag==1012)
		{

			EventPlayerFava1012.ResetEvent();

			int dRet=WaitForSingleObject(EventPlayerFava1012,RECVTIMEOUT);

			if(dRet == WAIT_TIMEOUT)
			{
				EventExit.SetEvent();
				return 1460;

			}
			else if(dRet == WAIT_OBJECT_0)
			{
				TRACE("�����˳�1000________________");
				return iError;
			}



			/////////////////////////////////////////////////////////////


		}

		if (flag==1013)
		{

			EventPlayerFava1013.ResetEvent();

			int dRet=WaitForSingleObject(EventPlayerFava1013,RECVTIMEOUT);

			if(dRet == WAIT_TIMEOUT)
			{
				EventExit.SetEvent();
				return 1460;

			}
			else if(dRet == WAIT_OBJECT_0)
			{
				TRACE("�����˳�1000________________");
				return iError;
			}



			/////////////////////////////////////////////////////////////


		}

		if (flag==1014)
		{
			EventPlayerFava1014.ResetEvent();

			int dRet=WaitForSingleObject(EventPlayerFava1014,RECVTIMEOUT);

			if(dRet == WAIT_TIMEOUT)
			{
				EventExit.SetEvent();
				return 1460;

			}
			else if(dRet == WAIT_OBJECT_0)
			{
				TRACE("�����˳�1000________________");
				return iError;
			}



			/////////////////////////////////////////////////////////////

		}

		return 0;






	}
	catch (CMemoryException* e)
	{
		return 30050;
	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
		return 30053;

	}

}



extern "C" _declspec(dllexport) const char* __stdcall GetDescriptionFromErrorID(int nError)

{

	/*try
	{*/


		TRACE("����GetDescriptionFromErrorID nError:%d",nError);

		if(nError<30000)
		{
			return (const char*)ConvertErrorCodeToString(nError);

		}
		if (nError>=30000)
		{
			//return "NULL";
			return g_CErrorMessage.GetErrorMessage(nError);
		}

	/*}
	catch (CMemoryException* e)
	{
		return 30050;
		
	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch()
	{
		return 30053;

	}*/



}






int WINAPI SetDataCallBack(PFCALLBACK Func)

{

	try
	{

		TRACE("����SetDataCallBack");
		if(Func==NULL)
			return 1;

		g_objectCComAutoCriticalSection.Lock();
		DataCallBackFunc=Func;
		g_objectCComAutoCriticalSection.Unlock();
		TRACE("����SetDataCallBack��%d",DataCallBackFunc);



		return 0;

	}
	catch (CMemoryException* e)
	{
		return 30050;

	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
		return 30053;

	}

	

}



int WINAPI SetEventCallBack(ECallBack Func)

{

	try
	{



		TRACE("����SetEventCallBack");

		if(Func==NULL)
			return 1;

		g_objectCComAutoCriticalSection.Lock();
		EventCallBackFunc=Func;
		g_objectCComAutoCriticalSection.Unlock();



		return 0;


	}
	catch (CMemoryException* e)
	{
		return 30050;

	}
	catch (CFileException* e)
	{
		return 30051;
	}
	catch (CException* e)
	{
		return 30052;
	}
	catch(...)
	{
		return 30053;

	}



}





BEGIN_MESSAGE_MAP(CMMCApp, CWinApp)
END_MESSAGE_MAP()


// CMMCApp ����

CMMCApp::CMMCApp()
{
	// TODO: �ڴ˴���ӹ�����룬
	// ��������Ҫ�ĳ�ʼ�������� InitInstance ��
}


// Ψһ��һ�� CMMCApp ����

CMMCApp theApp;

const GUID CDECL BASED_CODE _tlid =
{ 0x9EACB853, 0x125B, 0x4ADC, { 0xB8, 0x9C, 0x8, 0x5D, 0x57, 0x8C, 0xE5, 0x8E } };
const WORD _wVerMajor = 1;
const WORD _wVerMinor = 0;


// CMMCApp ��ʼ��

BOOL CMMCApp::InitInstance()
{
	CWinApp::InitInstance();

	if (!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
		return FALSE;
	}

	// ������ OLE ������(����)ע��Ϊ���С��⽫ʹ
	//  OLE ����Դ�����Ӧ�ó��򴴽�����
	COleObjectFactory::RegisterAll();


	
	//LC_ConnectionOper(1);






	return TRUE;
}




// DllGetClassObject - �����๤��

STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, LPVOID* ppv)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	return AfxDllGetClassObject(rclsid, riid, ppv);
}


// DllCanUnloadNow - ���� COM ж�� DLL

STDAPI DllCanUnloadNow(void)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	return AfxDllCanUnloadNow();
}


// DllRegisterServer - ������ӵ�ϵͳע���

STDAPI DllRegisterServer(void)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	if (!AfxOleRegisterTypeLib(AfxGetInstanceHandle(), _tlid))
		return SELFREG_E_TYPELIB;

	if (!COleObjectFactory::UpdateRegistryAll())
		return SELFREG_E_CLASS;

	return S_OK;
}


// DllUnregisterServer - �����ϵͳע������Ƴ�

STDAPI DllUnregisterServer(void)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	if (!AfxOleUnregisterTypeLib(_tlid, _wVerMajor, _wVerMinor))
		return SELFREG_E_TYPELIB;

	if (!COleObjectFactory::UpdateRegistryAll(FALSE))
		return SELFREG_E_CLASS;

	return S_OK;
}

int CMMCApp::ExitInstance()
{
	

	try
	{

		if (GetSockStatus()==0)
		{
			TRACE("�ر�");
			//SetSockCloseNei();
			EventExit.SetEvent();
		}


		//delete global_socket;

		TRACE("���̼����˳�");
		LC_ConnectionOper(2);

	}
	catch (CMemoryException* e)
	{
		
	}
	catch (CFileException* e)
	{
	}
	catch (CException* e)
	{
	}
	catch(...)
	{

	}
	
	

	return CWinApp::ExitInstance();
}
