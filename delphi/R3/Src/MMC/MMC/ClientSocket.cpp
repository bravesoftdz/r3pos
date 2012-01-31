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
//����ֵ 1  �ҵ���ȷ�� 2 �ҵ�����������ƫ�����ͳ��Ȳ��ʺ� ������������,�������� 3//���ޣ����� ȫ�� 4;//����Ч���ݽ�β��û�з��ֽ����������ݱ���
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
		{//�ҵ���������
			if(j==(iHead-2))
			{//�ҵ�����������ƫ�����Ͱ����� ��Ӧ //��ȷ��
                *pRightEnd=pHead+j+1;
				return 1;
			}
			else
			{
				*pRightEnd=pHead+j+1;
                return 2;//�ҵ�����������ƫ�����ͳ��Ȳ��ʺ�

			}
		}
		if(j==65535)
		{
           break;
		}
		if (pDataEnd==pHead+j+1)
		{
			return 4;//����Ч���ݽ�β��û�з��ֽ����������ݱ���
		}
	}
		//if (j>=65535)
		//{
		//	return 3//���ޣ����� ȫ��
		//}
	return 3;//���ޣ����� ȫ��


}
 int CClientSocket::OperateRecvData()
{
return 0;
}
 //��Ҫ�������������ݵĿ�ʼ
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