#include "stdafx.h"


#include "ClientSocket.h"


#include "Mstcpip.h"





CClientSocket::CClientSocket(void)

{
	/////////////////////
	/////////////////////////////////////
	pRecvOriginal=new BYTE[65536];
	memset(pRecvOriginal,0x00,65536);
	pDataEnd=pRecvOriginal;

}

CClientSocket::~CClientSocket(void)
{
	

	   // Close();
	memset(pRecvOriginal,0x00,65536);
	pDataEnd=pRecvOriginal;
	pHead=pRecvOriginal;
	pRightEnd=pRecvOriginal;
	int i=0;
	for (i=0;i<ListInPacket.size();i++)
	{
		delete ListInPacket.front();
		ListInPacket.pop();
	}

	



		delete[] pRecvOriginal;
		
}
//返回值 1  找到正确包 2 找到结束符不过偏移量和长度不适合 返回最后结束符,部分清理 3//超限，错误 全清 4;//到有效数据结尾还没有发现结束符，数据保留
int CClientSocket::CheckWheaverHaveRightData(BYTE ** pRightEnd)
{
	int iHead=0;
	memcpy(&iHead,pRecvOriginal,4);

	iHead=ntohl(iHead);


    int j=0;

	pHead= &(pRecvOriginal[0]);
	for(j=0;;j++)
	{
		if ((*(pHead+j)==0xff)&&(*(pHead+j+1)==0xff))
		{//找到结束符了
			if(j==(iHead-2))
			{//找到个结束符，偏移量和包长度 适应 //正确包
                *pRightEnd=pHead+j+1;
				return 1;
			}
			else
			{
				*pRightEnd=pHead+j+1;
                return 2;//找到结束符不过偏移量和长度不适合

			}
		}
		if(j==65535)
		{
           break;
		}
		if (pDataEnd==pHead+j+1)
		{
			return 4;//到有效数据结尾还没有发现结束符，数据保留
		}
	}
		//if (j>=65535)
		//{
		//	return 3//超限，错误 全清
		//}
	return 3;//超限，错误 全清


}
 int CClientSocket::OperateRecvData()
{
return 0;
}
 //不要忘记这是新数据的开始
 int CClientSocket::ClearOneDataZone(BYTE * pNextStart)
{

TRACE("start");
BYTE temp[65536];
memset(temp,0x00,65536);
memcpy(temp,pNextStart,pDataEnd-pNextStart+1);
memset(pRecvOriginal,0x00,65536);
memcpy(pRecvOriginal,temp,65536);

pHead=&(pRecvOriginal[0]);
pDataEnd=pDataEnd-(pNextStart-pHead);

TRACE("end");
return 0;
}