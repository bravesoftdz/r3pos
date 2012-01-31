#pragma once
#include "afxsock.h"
#include "stdafx.h"


/////////////////////////
#include "./json/json.h"
#include <iostream>
#include <queue>

#include <afxmt.h>
using namespace std ;
using namespace Json ;
//typedef queue<CDataClass*> COutQueue;
//typedef queue<CDataClass*> CInQueue;

//typedef int (WINAPI *PFCALLBACK)(int flag,void * Pin) ;
//typedef int (WINAPI *ECallBack)(int EFlag,int Event,void * Pin) ;
///////////////////////////////////
////extern COutQueue ListInPacket;
////extern CInQueue ListOutPacket;
// PFCALLBACK  DataCallBackFunc;
// ECallBack  EventCallBackFunc;
//extern HANDLE hEvent;
//extern int iErrorConnectFava;
extern int iError;
extern CEvent EventConnectOper;
extern CEvent EventConnectFava;
extern CEvent EventPlayerFava1012;
extern CEvent EventPlayerFava1013;
extern CEvent EventPlayerFava1014;

class CClientSocket
{
public:

int iErrorNum;
typedef queue<CDataClass*> COutQueue;
typedef queue<CDataClass*> CInQueue;


	COutQueue ListInPacket;////用了
    CInQueue ListOutPacket;

	BYTE * pHead;//临时使用头部指针
	BYTE * pRightEnd;//正确数据的结束最后一位
	BYTE * pDataEnd;//数据区中结束数据的最后一位
	BYTE * pRecvOriginal;//存储接收数据流
    int CheckWheaverHaveRightData(BYTE ** pRightEnd);
	int OperateRecvData();
	int ClearOneDataZone(BYTE * pNextStart);


typedef int (WINAPI *PFCALLBACK)(int flag,void * Pin) ;
typedef int (WINAPI *ECallBack)(int EFlag,int Event,void * Pin) ;




	CClientSocket(void);
	~CClientSocket(void);

	BOOL bKeepAlive;


	//CComAutoCriticalSection m_cs;
	CCriticalSection m_cs;
	void ListInPacket_Push(CDataClass *pDataClass)
	{
		CSingleLock singleLock(&m_cs);
		singleLock.Lock();
		this->ListInPacket.push(pDataClass);
	}
	size_t ListInPacket_GetSize()
	{
		int size = 0;
		CSingleLock singleLock(&m_cs);
		singleLock.Lock();
		size = this->ListInPacket.size();
		
		return size;
	}
	CDataClass * ListInPacket_GetFront()
	{
		CDataClass *pdc = NULL;
		CSingleLock singleLock(&m_cs);
		singleLock.Lock();
		pdc = this->ListInPacket.front();
		
		return pdc;
	}

	void ListInPacket_DeleteFront()
	{
		CSingleLock singleLock(&m_cs);
		singleLock.Lock();
		delete ListInPacket.front();
		ListInPacket.pop();
		
		//delete  (global_socket->ListInPacket.front());
		//global_socket->ListInPacket.pop();
	}
};
