#include "stdafx.h"
#include "LCHEAD.h"
#include "LocalConnection.h"


//创建LocalConnection.连接名称.窗体.
LCCONTROLDLL_API int __stdcall LC_Create(char*szName)
{
	int rtv = CLocalConnection::getInstance()->Connect(szName);
	MYTRACE("Connection_Create.RTV=%d",rtv);
	return rtv;
}

//关闭LocalConnection
LCCONTROLDLL_API int __stdcall LC_Close(char* szName)
{
	int rtv = CLocalConnection::getInstance()->Close(szName);
	MYTRACE("Connection_Close.RTV=%d",rtv);
	return rtv;
}

//发送1个参数
LCCONTROLDLL_API int __stdcall LC_Send(char *szName,char *szMethod,char *para1)
{
	CSendData sd;
	sd.m_szLcName.Format("%s",szName);
	sd.m_szMethodName.Format("%s",szMethod);

	vt_struct vs;
	vs.vt= vt_string;
	vs.data.m_string = new char[strlen(para1)+1];
	::ZeroMemory(vs.data.m_string,strlen(para1)+1);
	strcpy(vs.data.m_string,para1);
	sd.m_lstParas.push_back(vs);

	return CLocalConnection::getInstance()->ICheckAndSendData(sd);
}

//发送2个参数
LCCONTROLDLL_API int __stdcall LC_Send2(char *szName,char *szMethod,char *para1,char *para2)
{
	CSendData sd;
	sd.m_szLcName.Format("%s",szName);
	sd.m_szMethodName.Format("%s",szMethod);

	vt_struct vs1,vs2;
	vs1.vt = vt_string;
	vs2.vt = vt_string;

	vs1.data.m_string = new char[strlen(para1)+1];
	::ZeroMemory(vs1.data.m_string,strlen(para1)+1);
	strcpy(vs1.data.m_string,para1);

	vs2.data.m_string = new char[strlen(para2)+1];
	::ZeroMemory(vs2.data.m_string,strlen(para2)+1);
	strcpy(vs2.data.m_string,para2);

	sd.m_lstParas.push_back(vs1);
	sd.m_lstParas.push_back(vs2);

	return CLocalConnection::getInstance()->ICheckAndSendData(sd);
}

//发送3个参数
LCCONTROLDLL_API int __stdcall LC_Send3(char *szName,char *szMethod,char *para1,char *para2,char *para3)
{
	CSendData sd;
	sd.m_szLcName.Format("%s",szName);
	sd.m_szMethodName.Format("%s",szMethod);

	vt_struct vs1,vs2,vs3;
	vs1.vt = vt_string;
	vs2.vt = vt_string;
	vs3.vt = vt_string;

	vs1.data.m_string = new char[strlen(para1)+1];
	::ZeroMemory(vs1.data.m_string,strlen(para1)+1);
	strcpy(vs1.data.m_string,para1);

	vs2.data.m_string = new char[strlen(para2)+1];
	::ZeroMemory(vs2.data.m_string,strlen(para2)+1);
	strcpy(vs2.data.m_string,para2);

	vs3.data.m_string = new char[strlen(para3)+1];
	::ZeroMemory(vs3.data.m_string,strlen(para3)+1);
	strcpy(vs3.data.m_string,para3);

	sd.m_lstParas.push_back(vs1);
	sd.m_lstParas.push_back(vs2);
	sd.m_lstParas.push_back(vs3);

	return CLocalConnection::getInstance()->ICheckAndSendData(sd);
}

//关闭工作线程
LCCONTROLDLL_API void __stdcall LC_FreeLibrary()
{
	CLocalConnection::getInstance()->FinalRelease();
}

LCCONTROLDLL_API int __stdcall LC_MethodRegister(char *szLcName,char*szMethodName,int funcCallBack)
{
	CLocalConnection::getInstance()->MethodRegister(szLcName,szMethodName,funcCallBack);
	return 0;
}

//支持string和bytearray等数据的接口
LCCONTROLDLL_API int __stdcall LC_NSend(char *szName,char *szMethod,int vt,void *pData,int len)
{
	CSendData sd;
	sd.m_szLcName.Format("%s",szName);
	sd.m_szMethodName.Format("%s",szMethod);

	vt_struct vs;
	switch(vt)
	{
	case vt_string:
		vs.vt = vt_string;
		vs.data.m_string = new char[strlen((char*)pData)+1];
		::ZeroMemory(vs.data.m_string,strlen((char*)pData)+1);
		strcpy(vs.data.m_string,(char*)pData);
		break;
	case vt_buffer:
		vs.vt = vt_buffer;
		vs.data.m_buff.m_buffLen = len ;
		vs.data.m_buff.m_buff = new char[len+1];
		memset(vs.data.m_buff.m_buff,0x00,len+1);
		memcpy(vs.data.m_buff.m_buff,pData,len);
		break;
	case vt_int:
		vs.vt = vt_int;
		int i;
		::memcpy(&i,pData,4);
		vs.data.m_int = i;
		break;
	case vt_double:
		vs.vt = vt_double;
		double d;
		::memcpy(&d,pData,sizeof(double));
		vs.data.m_double = d;
		break;
	}
	
	sd.m_lstParas.push_back(vs);

	return CLocalConnection::getInstance()->ICheckAndSendData(sd);
}