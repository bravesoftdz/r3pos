#include "stdafx.h"
#include "DataStruct.h"






void ConvertUtf8ToGBK(CString& strUtf8) 
{
	int len=MultiByteToWideChar(CP_UTF8, 0, strUtf8, -1, NULL,0);
	unsigned short * wszGBK = new unsigned short[len+1];
	memset(wszGBK, 0, len * 2 + 2);
	MultiByteToWideChar(CP_UTF8, 0, (LPCTSTR)strUtf8, -1, (LPWSTR)wszGBK, len);

	len = WideCharToMultiByte(CP_ACP, 0, (LPCWSTR)wszGBK, -1, NULL, 0, NULL, NULL);
	char *szGBK=new char[len + 1];
	memset(szGBK, 0, len + 1);
	WideCharToMultiByte (CP_ACP, 0,(LPCWSTR) wszGBK, -1, szGBK, len, NULL,NULL);

	strUtf8 = szGBK;
	delete[] szGBK;
	delete[] wszGBK;
}


void ConvertGBKToUtf8(CString& strGBK)
{
	int len=MultiByteToWideChar(CP_ACP, 0, (LPCSTR)strGBK, -1, NULL,0);
	unsigned short * wszUtf8 = new unsigned short[len+1];
	memset(wszUtf8, 0, len * 2 + 2);
	MultiByteToWideChar(CP_ACP, 0, (LPCSTR)strGBK, -1, (LPWSTR)wszUtf8, len);

	len = WideCharToMultiByte(CP_UTF8, 0, (LPCWSTR)wszUtf8, -1, NULL, 0, NULL, NULL);
	char *szUtf8=new char[len + 1];
	memset(szUtf8, 0, len + 1);
	WideCharToMultiByte (CP_UTF8, 0, (LPCWSTR)wszUtf8, -1, szUtf8, len, NULL,NULL);

	strGBK = szUtf8;
	delete[] szUtf8;
	delete[] wszUtf8;
}



CDataClass::CDataClass(BYTE* pLCByte)
{

	

	if (flag==1000)
	{
		this->p_originaldata=new ConnectFava();
		


	}

	if (flag==1001||flag==1005||flag==1012||flag==1013||flag==1014)
	{
		
		this->p_originaldata=new PlayerFava();
		


	}
	if (flag==1002)
	{


		

		this->p_originaldata=new GroupFava();
		

	}

	if (flag==1006)
	{


		this->p_originaldata=new CommandFava();


	}
	if (flag==1010)
	{

	

		this->p_originaldata=new PlayerIdListFava();
	}

	if (flag==1011)
	{
	
		this->p_originaldata=new ChangeFava();


	}

	if (flag==1003||flag==1007||flag==1008||flag==1009)
	{

		this->p_originaldata=new SingleFava();


	}

	int iLen=0;
	memcpy(&iLen,pLCByte,4);

    data_AfterOper.iDataInArrayLen=iLen;
	memcpy(data_AfterOper.BP,pLCByte+4,iLen);
	
}





CDataClass::CDataClass(int flagin,void* Pin)

{
	flag=flagin;
	if(flagin==1000||flagin==1016)
	{


		this->p_originaldata=new ConnectFava();
		((ConnectFava*)p_originaldata)->messageType=((ConnectFava*)Pin)->messageType;
		((ConnectFava*)p_originaldata)->routeType=((ConnectFava*)Pin)->routeType;
		strcpy(((ConnectFava*)p_originaldata)->planText,((ConnectFava*)Pin)->planText);
		strcpy(((ConnectFava*)p_originaldata)->encodingData,((ConnectFava*)Pin)->encodingData);
		strcpy(((ConnectFava*)p_originaldata)->status,((ConnectFava*)Pin)->status);
		strcpy(((ConnectFava*)p_originaldata)->playerId,((ConnectFava*)Pin)->playerId);

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((ConnectFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((ConnectFava*)p_originaldata)->routeType); 
		root["planText"] = Json::Value(((ConnectFava*)p_originaldata)->planText); 
		root["encodingData"] = Json::Value(((ConnectFava*)p_originaldata)->encodingData); 
		root["status"] = Json::Value(((ConnectFava*)p_originaldata)->status); 
		root["playerId"] = Json::Value(((ConnectFava*)p_originaldata)->playerId); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());

		TRACE("%s",fast_writer.write(root).data());
		TRACE("数据 %s\n",fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=(CString)data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


	
		TRACE("有效字节长度 %d\n",temp);
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;
		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		

	}

	if(flagin==1001)
	{

		this->p_originaldata=new PlayerFava();
		((PlayerFava*)p_originaldata)->messageType=((PlayerFava*)Pin)->messageType;
		((PlayerFava*)p_originaldata)->routeType=((PlayerFava*)Pin)->routeType;

		strcpy(((PlayerFava*)p_originaldata)->playerId,((PlayerFava*)Pin)->playerId);
		strcpy(((PlayerFava*)p_originaldata)->nickName,((PlayerFava*)Pin)->nickName);
		strcpy(((PlayerFava*)p_originaldata)->userType,((PlayerFava*)Pin)->userType);
		strcpy(((PlayerFava*)p_originaldata)->comId,((PlayerFava*)Pin)->comId);

		strcpy(((PlayerFava*)p_originaldata)->comType,((PlayerFava*)Pin)->comType);

		strcpy(((PlayerFava*)p_originaldata)->provinceId,((PlayerFava*)Pin)->provinceId);
		strcpy(((PlayerFava*)p_originaldata)->refId,((PlayerFava*)Pin)->refId);
		strcpy(((PlayerFava*)p_originaldata)->saledptId,((PlayerFava*)Pin)->saledptId);
		strcpy(((PlayerFava*)p_originaldata)->saleManId,((PlayerFava*)Pin)->saleManId);
		strcpy(((PlayerFava*)p_originaldata)->serviceId,((PlayerFava*)Pin)->serviceId);
		strcpy(((PlayerFava*)p_originaldata)->saleCenterId,((PlayerFava*)Pin)->saleCenterId);
		strcpy(((PlayerFava*)p_originaldata)->sceneId,((PlayerFava*)Pin)->sceneId);
		strcpy(((PlayerFava*)p_originaldata)->instanceId,((PlayerFava*)Pin)->instanceId);

		((PlayerFava*)p_originaldata)->diaPlayerNum=((PlayerFava*)Pin)->diaPlayerNum;
		((PlayerFava*)p_originaldata)->playerStatus=((PlayerFava*)Pin)->playerStatus;
		((PlayerFava*)p_originaldata)->playerSkill=((PlayerFava*)Pin)->playerSkill;
		((PlayerFava*)p_originaldata)->clientType=((PlayerFava*)Pin)->clientType;


		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((PlayerFava*)p_originaldata)->playerId); 
		root["nickName"] = Json::Value(((PlayerFava*)p_originaldata)->nickName); 
		root["userType"] = Json::Value(((PlayerFava*)p_originaldata)->userType); 
		root["comId"] = Json::Value(((PlayerFava*)p_originaldata)->comId); 

		root["comType"] = Json::Value(((PlayerFava*)p_originaldata)->comType); 


		root["provinceId"] = Json::Value(((PlayerFava*)p_originaldata)->provinceId); 
		root["refId"] = Json::Value(((PlayerFava*)p_originaldata)->refId); 
		root["saledptId"] = Json::Value(((PlayerFava*)p_originaldata)->saledptId); 
		root["saleManId"] = Json::Value(((PlayerFava*)p_originaldata)->saleManId); 
		root["serviceId"] = Json::Value(((PlayerFava*)p_originaldata)->serviceId); 
		root["saleCenterId"] = Json::Value(((PlayerFava*)p_originaldata)->saleCenterId); 

		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());

		



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,(const char*)ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////

		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////

	}
	if(flagin==1002)
	{


		this->p_originaldata=new GroupFava();
		((GroupFava*)p_originaldata)->messageType=((GroupFava*)Pin)->messageType;
		((GroupFava*)p_originaldata)->routeType=((GroupFava*)Pin)->routeType;

		strcpy(((GroupFava*)p_originaldata)->playerId,((GroupFava*)Pin)->playerId);
		strcpy(((GroupFava*)p_originaldata)->refId,((GroupFava*)Pin)->refId);
		strcpy(((GroupFava*)p_originaldata)->comId,((GroupFava*)Pin)->comId);
		strcpy(((GroupFava*)p_originaldata)->chatTxt,((GroupFava*)Pin)->chatTxt);
		strcpy(((GroupFava*)p_originaldata)->nickName,((GroupFava*)Pin)->nickName);
		strcpy(((GroupFava*)p_originaldata)->showChatTxt,((GroupFava*)Pin)->showChatTxt);

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((GroupFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((GroupFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((GroupFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((GroupFava*)p_originaldata)->refId); 
		root["comId"] = Json::Value(((GroupFava*)p_originaldata)->comId); 
		root["chatTxt"] = Json::Value(((GroupFava*)p_originaldata)->chatTxt); 

		root["nickName"] = Json::Value(((GroupFava*)p_originaldata)->nickName); 
		root["showChatTxt"] = Json::Value(((GroupFava*)p_originaldata)->showChatTxt); 


		

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		

		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////




		



	}
	if(flagin==1003 )
	{

		this->p_originaldata=new SingleFava();
		((SingleFava*)p_originaldata)->messageType=((SingleFava*)Pin)->messageType;
		((SingleFava*)p_originaldata)->routeType=((SingleFava*)Pin)->routeType;

		strcpy(((SingleFava*)p_originaldata)->playerId,((SingleFava*)Pin)->playerId);
		strcpy(((SingleFava*)p_originaldata)->refId,((SingleFava*)Pin)->refId);
		strcpy(((SingleFava*)p_originaldata)->comId,((SingleFava*)Pin)->comId);
		strcpy(((SingleFava*)p_originaldata)->chatTxt,((SingleFava*)Pin)->chatTxt);
		strcpy(((SingleFava*)p_originaldata)->refPlayerComId,((SingleFava*)Pin)->refPlayerComId);
		strcpy(((SingleFava*)p_originaldata)->nickName,((SingleFava*)Pin)->nickName);


		strcpy(((SingleFava*)p_originaldata)->refPlayerName,((SingleFava*)Pin)->refPlayerName);
		strcpy(((SingleFava*)p_originaldata)->playerType,((SingleFava*)Pin)->playerType);
		strcpy(((SingleFava*)p_originaldata)->refPlayerType,((SingleFava*)Pin)->refPlayerType);

		((SingleFava*)p_originaldata)->playerSkill=((SingleFava*)Pin)->playerSkill;




		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((SingleFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((SingleFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((SingleFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((SingleFava*)p_originaldata)->refId); 
		root["comId"] = Json::Value(((SingleFava*)p_originaldata)->comId); 
		root["chatTxt"] = Json::Value(((SingleFava*)p_originaldata)->chatTxt); 

		root["refPlayerComId"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerComId); 
		root["nickName"] = Json::Value(((SingleFava*)p_originaldata)->nickName); 


		root["refPlayerName"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerName); 
		root["playerType"] = Json::Value(((SingleFava*)p_originaldata)->playerType); 
		root["refPlayerType"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerType); 
		root["playerSkill"] = Json::Value(((SingleFava*)p_originaldata)->playerSkill); 



		

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		
		int temp=strlen(data_AfterOper.pByte)+21;
		TRACE("小端模式 长度 %d", temp) ;

		temp=htonl(temp);
		TRACE("大端模式 长度 %d", temp) ;
		TRACE("大端模式 向小端模式解析 长度 %d", ntohl(temp)) ;

		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);

		
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////



		//strcpy(((GroupFava*)p_originaldata)->saleCenterId,((GroupFava*)Pin)->saleCenterId);
		//strcpy(((GroupFava*)p_originaldata)->sceneId,((GroupFava*)Pin)->sceneId);
		//strcpy(((GroupFava*)p_originaldata)->instanceId,((GroupFava*)Pin)->instanceId);
	}
	if(flagin==1004 )
	{

		


	}
	if(flagin==1005)
	{

		this->p_originaldata=new PlayerFava();
		((PlayerFava*)p_originaldata)->messageType=((PlayerFava*)Pin)->messageType;
		((PlayerFava*)p_originaldata)->routeType=((PlayerFava*)Pin)->routeType;

		strcpy(((PlayerFava*)p_originaldata)->playerId,((PlayerFava*)Pin)->playerId);
		strcpy(((PlayerFava*)p_originaldata)->nickName,((PlayerFava*)Pin)->nickName);
		strcpy(((PlayerFava*)p_originaldata)->userType,((PlayerFava*)Pin)->userType);
		strcpy(((PlayerFava*)p_originaldata)->comId,((PlayerFava*)Pin)->comId);

		strcpy(((PlayerFava*)p_originaldata)->comType,((PlayerFava*)Pin)->comType);

		strcpy(((PlayerFava*)p_originaldata)->provinceId,((PlayerFava*)Pin)->provinceId);
		strcpy(((PlayerFava*)p_originaldata)->refId,((PlayerFava*)Pin)->refId);
		strcpy(((PlayerFava*)p_originaldata)->saledptId,((PlayerFava*)Pin)->saledptId);
		strcpy(((PlayerFava*)p_originaldata)->saleManId,((PlayerFava*)Pin)->saleManId);
		strcpy(((PlayerFava*)p_originaldata)->serviceId,((PlayerFava*)Pin)->serviceId);
		strcpy(((PlayerFava*)p_originaldata)->saleCenterId,((PlayerFava*)Pin)->saleCenterId);
		strcpy(((PlayerFava*)p_originaldata)->sceneId,((PlayerFava*)Pin)->sceneId);
		strcpy(((PlayerFava*)p_originaldata)->instanceId,((PlayerFava*)Pin)->instanceId);

		((PlayerFava*)p_originaldata)->diaPlayerNum=((PlayerFava*)Pin)->diaPlayerNum;
		((PlayerFava*)p_originaldata)->playerStatus=((PlayerFava*)Pin)->playerStatus;
		((PlayerFava*)p_originaldata)->playerSkill=((PlayerFava*)Pin)->playerSkill;
		((PlayerFava*)p_originaldata)->clientType=((PlayerFava*)Pin)->clientType;


		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((PlayerFava*)p_originaldata)->playerId); 
		root["nickName"] = Json::Value(((PlayerFava*)p_originaldata)->nickName); 
		root["userType"] = Json::Value(((PlayerFava*)p_originaldata)->userType); 
		root["comId"] = Json::Value(((PlayerFava*)p_originaldata)->comId); 

		root["comType"] = Json::Value(((PlayerFava*)p_originaldata)->comType); 


		root["provinceId"] = Json::Value(((PlayerFava*)p_originaldata)->provinceId); 
		root["refId"] = Json::Value(((PlayerFava*)p_originaldata)->refId); 
		root["saledptId"] = Json::Value(((PlayerFava*)p_originaldata)->saledptId); 
		root["saleManId"] = Json::Value(((PlayerFava*)p_originaldata)->saleManId); 
		root["serviceId"] = Json::Value(((PlayerFava*)p_originaldata)->serviceId); 
		root["saleCenterId"] = Json::Value(((PlayerFava*)p_originaldata)->saleCenterId); 

		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////






	}
	if(flagin==1006)
	{
		this->p_originaldata=new CommandFava();
		((CommandFava*)p_originaldata)->messageType=((CommandFava*)Pin)->messageType;
		((CommandFava*)p_originaldata)->routeType=((CommandFava*)Pin)->routeType;

		strcpy(((CommandFava*)p_originaldata)->type,((CommandFava*)Pin)->type);
		strcpy(((CommandFava*)p_originaldata)->id,((CommandFava*)Pin)->id);
		strcpy(((CommandFava*)p_originaldata)->variable,((CommandFava*)Pin)->variable);
		strcpy(((CommandFava*)p_originaldata)->msg,((CommandFava*)Pin)->msg);
		strcpy(((CommandFava*)p_originaldata)->zoneType,((CommandFava*)Pin)->zoneType);
		strcpy(((CommandFava*)p_originaldata)->zoneId,((CommandFava*)Pin)->zoneId);


		strcpy(((CommandFava*)p_originaldata)->zoneName,((CommandFava*)Pin)->zoneName);
		strcpy(((CommandFava*)p_originaldata)->senderId,((CommandFava*)Pin)->senderId);
		strcpy(((CommandFava*)p_originaldata)->senderName,((CommandFava*)Pin)->senderName);
		strcpy(((CommandFava*)p_originaldata)->senderType,((CommandFava*)Pin)->senderType);






		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((CommandFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((CommandFava*)p_originaldata)->routeType); 
		root["type"] = Json::Value(((CommandFava*)p_originaldata)->type); 
		root["id"] = Json::Value(((CommandFava*)p_originaldata)->id); 
		root["variable"] = Json::Value(((CommandFava*)p_originaldata)->variable); 
		root["msg"] = Json::Value(((CommandFava*)p_originaldata)->msg); 

		root["zoneType"] = Json::Value(((CommandFava*)p_originaldata)->zoneType); 
		root["zoneId"] = Json::Value(((CommandFava*)p_originaldata)->zoneId); 


		root["zoneName"] = Json::Value(((CommandFava*)p_originaldata)->zoneName); 
		root["senderId"] = Json::Value(((CommandFava*)p_originaldata)->senderId); 
		root["senderName"] = Json::Value(((CommandFava*)p_originaldata)->senderName); 
		root["senderType"] = Json::Value(((CommandFava*)p_originaldata)->senderType); 



		

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=(CString)(data_AfterOper.pByte);
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////





		
	}
	if(flagin==1007)
	{

		this->p_originaldata=new SingleFava();
		((SingleFava*)p_originaldata)->messageType=((SingleFava*)Pin)->messageType;
		((SingleFava*)p_originaldata)->routeType=((SingleFava*)Pin)->routeType;

		strcpy(((SingleFava*)p_originaldata)->playerId,((SingleFava*)Pin)->playerId);
		strcpy(((SingleFava*)p_originaldata)->refId,((SingleFava*)Pin)->refId);
		strcpy(((SingleFava*)p_originaldata)->comId,((SingleFava*)Pin)->comId);
		strcpy(((SingleFava*)p_originaldata)->chatTxt,((SingleFava*)Pin)->chatTxt);
		strcpy(((SingleFava*)p_originaldata)->refPlayerComId,((SingleFava*)Pin)->refPlayerComId);
		strcpy(((SingleFava*)p_originaldata)->nickName,((SingleFava*)Pin)->nickName);


		strcpy(((SingleFava*)p_originaldata)->refPlayerName,((SingleFava*)Pin)->refPlayerName);
		strcpy(((SingleFava*)p_originaldata)->playerType,((SingleFava*)Pin)->playerType);
		strcpy(((SingleFava*)p_originaldata)->refPlayerType,((SingleFava*)Pin)->refPlayerType);

		((SingleFava*)p_originaldata)->playerSkill=((SingleFava*)Pin)->playerSkill;




		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((SingleFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((SingleFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((SingleFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((SingleFava*)p_originaldata)->refId); 
		root["comId"] = Json::Value(((SingleFava*)p_originaldata)->comId); 
		root["chatTxt"] = Json::Value(((SingleFava*)p_originaldata)->chatTxt); 

		root["refPlayerComId"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerComId); 
		root["nickName"] = Json::Value(((SingleFava*)p_originaldata)->nickName); 


		root["refPlayerName"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerName); 
		root["playerType"] = Json::Value(((SingleFava*)p_originaldata)->playerType); 
		root["refPlayerType"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerType); 
		root["playerSkill"] = Json::Value(((SingleFava*)p_originaldata)->playerSkill); 



		/*
		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); */

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/* int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*////////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////

		//////////////////////////////////////////////////////////////////////////////////////////////////


	}
	if(flagin==1008)
	{

		this->p_originaldata=new SingleFava();
		((SingleFava*)p_originaldata)->messageType=((SingleFava*)Pin)->messageType;
		((SingleFava*)p_originaldata)->routeType=((SingleFava*)Pin)->routeType;

		strcpy(((SingleFava*)p_originaldata)->playerId,((SingleFava*)Pin)->playerId);
		strcpy(((SingleFava*)p_originaldata)->refId,((SingleFava*)Pin)->refId);
		strcpy(((SingleFava*)p_originaldata)->comId,((SingleFava*)Pin)->comId);
		strcpy(((SingleFava*)p_originaldata)->chatTxt,((SingleFava*)Pin)->chatTxt);
		strcpy(((SingleFava*)p_originaldata)->refPlayerComId,((SingleFava*)Pin)->refPlayerComId);
		strcpy(((SingleFava*)p_originaldata)->nickName,((SingleFava*)Pin)->nickName);


		strcpy(((SingleFava*)p_originaldata)->refPlayerName,((SingleFava*)Pin)->refPlayerName);
		strcpy(((SingleFava*)p_originaldata)->playerType,((SingleFava*)Pin)->playerType);
		strcpy(((SingleFava*)p_originaldata)->refPlayerType,((SingleFava*)Pin)->refPlayerType);

		((SingleFava*)p_originaldata)->playerSkill=((SingleFava*)Pin)->playerSkill;


		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((SingleFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((SingleFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((SingleFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((SingleFava*)p_originaldata)->refId); 
		root["comId"] = Json::Value(((SingleFava*)p_originaldata)->comId); 
		root["chatTxt"] = Json::Value(((SingleFava*)p_originaldata)->chatTxt); 

		root["refPlayerComId"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerComId); 
		root["nickName"] = Json::Value(((SingleFava*)p_originaldata)->nickName); 


		root["refPlayerName"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerName); 
		root["playerType"] = Json::Value(((SingleFava*)p_originaldata)->playerType); 
		root["refPlayerType"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerType); 
		root["playerSkill"] = Json::Value(((SingleFava*)p_originaldata)->playerSkill); 



		/*
		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); */

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/* int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*/

		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////



	}
	if(flagin==1009)
	{
		this->p_originaldata=new SingleFava();
		((SingleFava*)p_originaldata)->messageType=((SingleFava*)Pin)->messageType;
		((SingleFava*)p_originaldata)->routeType=((SingleFava*)Pin)->routeType;

		strcpy(((SingleFava*)p_originaldata)->playerId,((SingleFava*)Pin)->playerId);
		strcpy(((SingleFava*)p_originaldata)->refId,((SingleFava*)Pin)->refId);
		strcpy(((SingleFava*)p_originaldata)->comId,((SingleFava*)Pin)->comId);
		strcpy(((SingleFava*)p_originaldata)->chatTxt,((SingleFava*)Pin)->chatTxt);
		strcpy(((SingleFava*)p_originaldata)->refPlayerComId,((SingleFava*)Pin)->refPlayerComId);
		strcpy(((SingleFava*)p_originaldata)->nickName,((SingleFava*)Pin)->nickName);


		strcpy(((SingleFava*)p_originaldata)->refPlayerName,((SingleFava*)Pin)->refPlayerName);
		strcpy(((SingleFava*)p_originaldata)->playerType,((SingleFava*)Pin)->playerType);
		strcpy(((SingleFava*)p_originaldata)->refPlayerType,((SingleFava*)Pin)->refPlayerType);

		((SingleFava*)p_originaldata)->playerSkill=((SingleFava*)Pin)->playerSkill;

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((SingleFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((SingleFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((SingleFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((SingleFava*)p_originaldata)->refId); 
		root["comId"] = Json::Value(((SingleFava*)p_originaldata)->comId); 
		root["chatTxt"] = Json::Value(((SingleFava*)p_originaldata)->chatTxt); 

		root["refPlayerComId"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerComId); 
		root["nickName"] = Json::Value(((SingleFava*)p_originaldata)->nickName); 


		root["refPlayerName"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerName); 
		root["playerType"] = Json::Value(((SingleFava*)p_originaldata)->playerType); 
		root["refPlayerType"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerType); 
		root["playerSkill"] = Json::Value(((SingleFava*)p_originaldata)->playerSkill); 



		/*
		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); */

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/*int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*/
		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////



	}
	if(flagin==1010)
	{
		this->p_originaldata=new PlayerIdListFava();
		((PlayerIdListFava*)p_originaldata)->messageType=((PlayerIdListFava*)Pin)->messageType;
		((PlayerIdListFava*)p_originaldata)->routeType=((PlayerIdListFava*)Pin)->routeType;

		strcpy(((PlayerIdListFava*)p_originaldata)->comId,((PlayerIdListFava*)Pin)->comId);





		((PlayerIdListFava*)p_originaldata)->ListLen=((PlayerIdListFava*)Pin)->ListLen;

		for (int i=0;i<((PlayerIdListFava*)Pin)->ListLen;i++)
		{
			((PlayerIdListFava*)p_originaldata)->playerIdArray[i]=new char[128];
			memset(((PlayerIdListFava*)p_originaldata)->playerIdArray[i],0x00,128);
			strcpy(((PlayerIdListFava*)p_originaldata)->playerIdArray[i],((PlayerIdListFava*)Pin)->playerIdArray[i]);
			// ((PlayerIdListFava*)p_originaldata)->playerIdArray[i];

		}








		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerIdListFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerIdListFava*)p_originaldata)->routeType); 
		/* root["playerId"] = Json::Value(((SingleFava*)p_originaldata)->playerId); 
		root["refId"] = Json::Value(((SingleFava*)p_originaldata)->refId); */
		root["comId"] = Json::Value(((PlayerIdListFava*)p_originaldata)->comId); 

		for (int i=0;i<((PlayerIdListFava*)p_originaldata)->ListLen;i++)
		{
			/*char *pTemp=new char[32];
			memset(pTemp,0x00,32);
			strcpy(pTemp,((PlayerIdListFava*)Pin)->playerIdArray[i]);*/
			//((PlayerIdListFava*)p_originaldata)->playerIdArray->push_back(pTemp);

			root["playerIdArray"].append(((PlayerIdListFava*)p_originaldata)->playerIdArray[i]);// 新建一个 Key(名为:key_array),
		}




		/*root["chatTxt"] = Json::Value(((SingleFava*)p_originaldata)->chatTxt); 

		root["refPlayerComId"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerComId); 
		root["nickName"] = Json::Value(((SingleFava*)p_originaldata)->nickName); 


		root["refPlayerName"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerName); 
		root["playerType"] = Json::Value(((SingleFava*)p_originaldata)->playerType); 
		root["refPlayerType"] = Json::Value(((SingleFava*)p_originaldata)->refPlayerType); 
		root["playerSkill"] = Json::Value(((SingleFava*)p_originaldata)->playerSkill); 

		*/

		/*
		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); */

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		//int temp=strlen(data_AfterOper.pByte)+21;
		//memcpy(data_AfterOper.BDataLen,&temp,4);
		//            temp=strlen(data_AfterOper.pByte);

		//memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		//memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		//memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		//memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		//memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		//memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		//memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		//data_AfterOper.iDataInArrayLen=temp+21;

		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		

	}
	if(flagin==1011)
	{


		this->p_originaldata=new ChangeFava();
		((ChangeFava*)p_originaldata)->messageType=((ChangeFava*)Pin)->messageType;
		((ChangeFava*)p_originaldata)->routeType=((ChangeFava*)Pin)->routeType;

		//strcpy(((PlayerIdListFava*)p_originaldata)->comId,((PlayerIdListFava*)Pin)->comId);*/





		/* ((ChangeFava*)p_originaldata)->messageType=((ChangeFava*)Pin)->messageType;
		((ChangeFava*)p_originaldata)->routeType=((ChangeFava*)Pin)->routeType;*/








		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((ChangeFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((ChangeFava*)p_originaldata)->routeType); 
		

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

	
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//((PlayerIdListFava*)p_originaldata)->ListLen=((PlayerIdListFava*)Pin)->ListLen;


	}
	if(flagin==1012)
	{
		this->p_originaldata=new PlayerFava();
		((PlayerFava*)p_originaldata)->messageType=((PlayerFava*)Pin)->messageType;
		((PlayerFava*)p_originaldata)->routeType=((PlayerFava*)Pin)->routeType;

		strcpy(((PlayerFava*)p_originaldata)->playerId,((PlayerFava*)Pin)->playerId);
		strcpy(((PlayerFava*)p_originaldata)->nickName,((PlayerFava*)Pin)->nickName);
		strcpy(((PlayerFava*)p_originaldata)->userType,((PlayerFava*)Pin)->userType);
		strcpy(((PlayerFava*)p_originaldata)->comId,((PlayerFava*)Pin)->comId);

		strcpy(((PlayerFava*)p_originaldata)->comType,((PlayerFava*)Pin)->comType);


		strcpy(((PlayerFava*)p_originaldata)->provinceId,((PlayerFava*)Pin)->provinceId);
		strcpy(((PlayerFava*)p_originaldata)->refId,((PlayerFava*)Pin)->refId);
		strcpy(((PlayerFava*)p_originaldata)->saledptId,((PlayerFava*)Pin)->saledptId);
		strcpy(((PlayerFava*)p_originaldata)->saleManId,((PlayerFava*)Pin)->saleManId);
		strcpy(((PlayerFava*)p_originaldata)->serviceId,((PlayerFava*)Pin)->serviceId);
		strcpy(((PlayerFava*)p_originaldata)->saleCenterId,((PlayerFava*)Pin)->saleCenterId);
		strcpy(((PlayerFava*)p_originaldata)->sceneId,((PlayerFava*)Pin)->sceneId);
		strcpy(((PlayerFava*)p_originaldata)->instanceId,((PlayerFava*)Pin)->instanceId);

		((PlayerFava*)p_originaldata)->diaPlayerNum=((PlayerFava*)Pin)->diaPlayerNum;
		((PlayerFava*)p_originaldata)->playerStatus=((PlayerFava*)Pin)->playerStatus;
		((PlayerFava*)p_originaldata)->playerSkill=((PlayerFava*)Pin)->playerSkill;
		((PlayerFava*)p_originaldata)->clientType=((PlayerFava*)Pin)->clientType;

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((PlayerFava*)p_originaldata)->playerId); 
		root["nickName"] = Json::Value(((PlayerFava*)p_originaldata)->nickName); 
		root["userType"] = Json::Value(((PlayerFava*)p_originaldata)->userType); 
		root["comId"] = Json::Value(((PlayerFava*)p_originaldata)->comId); 

		root["comType"] = Json::Value(((PlayerFava*)p_originaldata)->comType); 

		root["provinceId"] = Json::Value(((PlayerFava*)p_originaldata)->provinceId); 
		root["refId"] = Json::Value(((PlayerFava*)p_originaldata)->refId); 
		root["saledptId"] = Json::Value(((PlayerFava*)p_originaldata)->saledptId); 
		root["saleManId"] = Json::Value(((PlayerFava*)p_originaldata)->saleManId); 
		root["serviceId"] = Json::Value(((PlayerFava*)p_originaldata)->serviceId); 
		root["saleCenterId"] = Json::Value(((PlayerFava*)p_originaldata)->saleCenterId); 

		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());



		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,(const char*)ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/* int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*/
		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////
	}
	if(flagin==1013)
	{
		this->p_originaldata=new PlayerFava();
		((PlayerFava*)p_originaldata)->messageType=((PlayerFava*)Pin)->messageType;
		((PlayerFava*)p_originaldata)->routeType=((PlayerFava*)Pin)->routeType;

		strcpy(((PlayerFava*)p_originaldata)->playerId,((PlayerFava*)Pin)->playerId);
		strcpy(((PlayerFava*)p_originaldata)->nickName,((PlayerFava*)Pin)->nickName);
		strcpy(((PlayerFava*)p_originaldata)->userType,((PlayerFava*)Pin)->userType);
		strcpy(((PlayerFava*)p_originaldata)->comId,((PlayerFava*)Pin)->comId);

		strcpy(((PlayerFava*)p_originaldata)->comType,((PlayerFava*)Pin)->comType);


		strcpy(((PlayerFava*)p_originaldata)->provinceId,((PlayerFava*)Pin)->provinceId);
		strcpy(((PlayerFava*)p_originaldata)->refId,((PlayerFava*)Pin)->refId);
		strcpy(((PlayerFava*)p_originaldata)->saledptId,((PlayerFava*)Pin)->saledptId);
		strcpy(((PlayerFava*)p_originaldata)->saleManId,((PlayerFava*)Pin)->saleManId);
		strcpy(((PlayerFava*)p_originaldata)->serviceId,((PlayerFava*)Pin)->serviceId);
		strcpy(((PlayerFava*)p_originaldata)->saleCenterId,((PlayerFava*)Pin)->saleCenterId);
		strcpy(((PlayerFava*)p_originaldata)->sceneId,((PlayerFava*)Pin)->sceneId);
		strcpy(((PlayerFava*)p_originaldata)->instanceId,((PlayerFava*)Pin)->instanceId);

		((PlayerFava*)p_originaldata)->diaPlayerNum=((PlayerFava*)Pin)->diaPlayerNum;
		((PlayerFava*)p_originaldata)->playerStatus=((PlayerFava*)Pin)->playerStatus;
		((PlayerFava*)p_originaldata)->playerSkill=((PlayerFava*)Pin)->playerSkill;
		((PlayerFava*)p_originaldata)->clientType=((PlayerFava*)Pin)->clientType;


		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((PlayerFava*)p_originaldata)->playerId); 
		root["nickName"] = Json::Value(((PlayerFava*)p_originaldata)->nickName); 
		root["userType"] = Json::Value(((PlayerFava*)p_originaldata)->userType); 
		root["comId"] = Json::Value(((PlayerFava*)p_originaldata)->comId); 

		root["comType"] = Json::Value(((PlayerFava*)p_originaldata)->comType); 

		root["provinceId"] = Json::Value(((PlayerFava*)p_originaldata)->provinceId); 
		root["refId"] = Json::Value(((PlayerFava*)p_originaldata)->refId); 
		root["saledptId"] = Json::Value(((PlayerFava*)p_originaldata)->saledptId); 
		root["saleManId"] = Json::Value(((PlayerFava*)p_originaldata)->saleManId); 
		root["serviceId"] = Json::Value(((PlayerFava*)p_originaldata)->serviceId); 
		root["saleCenterId"] = Json::Value(((PlayerFava*)p_originaldata)->saleCenterId); 

		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());


		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/* int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*/
		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////

	}
	if(flagin==1014)
	{
		this->p_originaldata=new PlayerFava();
		((PlayerFava*)p_originaldata)->messageType=((PlayerFava*)Pin)->messageType;
		((PlayerFava*)p_originaldata)->routeType=((PlayerFava*)Pin)->routeType;

		strcpy(((PlayerFava*)p_originaldata)->playerId,((PlayerFava*)Pin)->playerId);
		strcpy(((PlayerFava*)p_originaldata)->nickName,((PlayerFava*)Pin)->nickName);
		strcpy(((PlayerFava*)p_originaldata)->userType,((PlayerFava*)Pin)->userType);
		strcpy(((PlayerFava*)p_originaldata)->comId,((PlayerFava*)Pin)->comId);

		strcpy(((PlayerFava*)p_originaldata)->comType,((PlayerFava*)Pin)->comType);


		strcpy(((PlayerFava*)p_originaldata)->provinceId,((PlayerFava*)Pin)->provinceId);
		strcpy(((PlayerFava*)p_originaldata)->refId,((PlayerFava*)Pin)->refId);
		strcpy(((PlayerFava*)p_originaldata)->saledptId,((PlayerFava*)Pin)->saledptId);
		strcpy(((PlayerFava*)p_originaldata)->saleManId,((PlayerFava*)Pin)->saleManId);
		strcpy(((PlayerFava*)p_originaldata)->serviceId,((PlayerFava*)Pin)->serviceId);
		strcpy(((PlayerFava*)p_originaldata)->saleCenterId,((PlayerFava*)Pin)->saleCenterId);
		strcpy(((PlayerFava*)p_originaldata)->sceneId,((PlayerFava*)Pin)->sceneId);
		strcpy(((PlayerFava*)p_originaldata)->instanceId,((PlayerFava*)Pin)->instanceId);

		((PlayerFava*)p_originaldata)->diaPlayerNum=((PlayerFava*)Pin)->diaPlayerNum;
		((PlayerFava*)p_originaldata)->playerStatus=((PlayerFava*)Pin)->playerStatus;
		((PlayerFava*)p_originaldata)->playerSkill=((PlayerFava*)Pin)->playerSkill;
		((PlayerFava*)p_originaldata)->clientType=((PlayerFava*)Pin)->clientType;
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Json::Value root; // 表示整个 json 对象
		root["messageType"] = Json::Value(((PlayerFava*)p_originaldata)->messageType); 
		root["routeType"] = Json::Value(((PlayerFava*)p_originaldata)->routeType); 
		root["playerId"] = Json::Value(((PlayerFava*)p_originaldata)->playerId); 
		root["nickName"] = Json::Value(((PlayerFava*)p_originaldata)->nickName); 
		root["userType"] = Json::Value(((PlayerFava*)p_originaldata)->userType); 
		root["comId"] = Json::Value(((PlayerFava*)p_originaldata)->comId); 


		root["comType"] = Json::Value(((PlayerFava*)p_originaldata)->comType); 

		root["provinceId"] = Json::Value(((PlayerFava*)p_originaldata)->provinceId); 
		root["refId"] = Json::Value(((PlayerFava*)p_originaldata)->refId); 
		root["saledptId"] = Json::Value(((PlayerFava*)p_originaldata)->saledptId); 
		root["saleManId"] = Json::Value(((PlayerFava*)p_originaldata)->saleManId); 
		root["serviceId"] = Json::Value(((PlayerFava*)p_originaldata)->serviceId); 
		root["saleCenterId"] = Json::Value(((PlayerFava*)p_originaldata)->saleCenterId); 

		root["sceneId"] = Json::Value(((PlayerFava*)p_originaldata)->sceneId); 
		root["instanceId"] = Json::Value(((PlayerFava*)p_originaldata)->instanceId); 
		root["diaPlayerNum"] = Json::Value(((PlayerFava*)p_originaldata)->diaPlayerNum); 
		root["playerStatus"] = Json::Value(((PlayerFava*)p_originaldata)->playerStatus); 
		root["playerSkill"] = Json::Value(((PlayerFava*)p_originaldata)->playerSkill); 
		root["clientType"] = Json::Value(((PlayerFava*)p_originaldata)->clientType); 

		Json::FastWriter fast_writer;
		// std::cout << fast_writer.write(root) << std::endl;
		strcpy(data_AfterOper.pByte,fast_writer.write(root).data());



		/////////////////////



		TRACE("发送数据GBK %s",data_AfterOper.pByte);
		CString ls=(CString)data_AfterOper.pByte;
		ConvertGBKToUtf8(ls);
		memset(data_AfterOper.pByte,0x00,65536);
		strcpy(data_AfterOper.pByte,ls);
		TRACE("发送数据UTF8 %s",data_AfterOper.pByte);

		///////////////////////////////////////////////////////////////////////////////////////
		/* int temp=strlen(data_AfterOper.pByte)+21;
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memcpy(data_AfterOper.BP+6,data_AfterOper.cert,4);
		memcpy(data_AfterOper.BP+10,&(data_AfterOper.P2pFlag),1);
		memcpy(data_AfterOper.BP+11,data_AfterOper.yl,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memcpy(data_AfterOper.BP+19+temp,data_AfterOper.end,2);
		data_AfterOper.iDataInArrayLen=temp+21;*/
		///////////////////////////////////////////////////////////////////////////////////////
		int temp=strlen(data_AfterOper.pByte)+21;
		temp=htonl(temp);
		memcpy(data_AfterOper.BDataLen,&temp,4);
		temp=strlen(data_AfterOper.pByte);


		///////////////////////////////////////////////
		//string p= fast_writer.write(root);
		////////////////////////////////////////////////
		TRACE("有效字节长度:%d",temp);
		TRACE("有效字节内容:%s",data_AfterOper.pByte);


		memcpy(data_AfterOper.BP+0,data_AfterOper.BDataLen,4);
		memcpy(data_AfterOper.BP+4,data_AfterOper.BnVersion,2);
		memset(data_AfterOper.BP+6,0x00,4);
		memset(data_AfterOper.BP+10,0x01,1);
		memset(data_AfterOper.BP+11,0x00,8);
		memcpy(data_AfterOper.BP+19,data_AfterOper.pByte,temp);
		memset(data_AfterOper.BP+19+temp,0xff,2);
		data_AfterOper.iDataInArrayLen=temp+21;

		TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////
	}

	//TRACE("数据包前4字节 大端模式  %d",data_AfterOper.BDataLen);
	TRACE("本数据包总字节 %d",data_AfterOper.iDataInArrayLen);
	//TRACE("组装数据完毕.组装完毕,data_AfterOper.BP : %s ",data_AfterOper.iDataInArrayLen)
}


CDataClass::~CDataClass(void)
{



	

	if (flag==1000||flag==1016)
	{
		delete (ConnectFava*)p_originaldata;


	}

	if (flag==1001||flag==1005||flag==1012||flag==1013||flag==1014)
	{
		//p_ToDelphiData=new PlayerFava();
		delete (PlayerFava*)p_originaldata;


	}
	if (flag==1002)
	{


		//p_ToDelphiData=new GroupFava();
		delete (GroupFava*)p_originaldata;

	}

	if (flag==1006)
	{


		//p_ToDelphiData=new CommandFava();
		delete (CommandFava*)p_originaldata;


	}
	if (flag==1010)
	{

		 for (int i=0;i<((PlayerIdListFava*)p_originaldata)->ListLen;i++)
		 {
		  

		 delete[]  ((PlayerIdListFava*)p_originaldata)->playerIdArray[i];

		 }
		//p_ToDelphiData=new PlayerIdListFava ();
		delete (PlayerIdListFava*)p_originaldata;

	}

	if (flag==1011)
	{
		//p_ToDelphiData=new ChangeFava();
		delete (ChangeFava*)p_originaldata;


	}

	if (flag==1003||flag==1007||flag==1008||flag==1009)
	{
		//p_ToDelphiData=new SingleFava();
		delete (SingleFava*)p_originaldata;


	}
///////////////////////////////////////////////////////////

}
////返回值1错误
DataReved::DataReved(BYTE* pStart,BYTE* pEnd)
{
	lengthofbyteDataRecvOrigianl=0;

	byteDataRecvOrigianl=new BYTE[65536];
	memset(byteDataRecvOrigianl,0x00,65536);
	memcpy(byteDataRecvOrigianl,pStart+19,pEnd-pStart-20);

	Json::Reader reader;
	Json::Value json_object;

	char json_document[65536];
	memset(json_document,0x00,65536);
	memcpy(json_document,byteDataRecvOrigianl,65536);
	//////////////////

	TRACE("接收数据UTF8 %s",json_document);
	CString ls=(CString)json_document;
	ConvertUtf8ToGBK(ls);
	memset(json_document,0x00,65536);
	strcpy(json_document,ls);
	TRACE("接收数据GBK %s",json_document);

	///////////////////////////
	//strcpy(json_document, "{\"age\" : 26,\"name\" : \"陈尧\"}");
	//strcpy(json_document,fast_writer.write(root).data());


	if (!reader.parse(json_document, json_object))
	{
		// delete[] byteDataRecvOrigianl;
		return ;
	}

	int iType= json_object["routeType"].asInt();
	if (iType==0||iType==1)//flex
	{

		lengthofbyteDataRecvOrigianl=pEnd-pStart+1;
		routeType=iType;
		flag=json_object["messageType"].asInt();
		memset(byteDataRecvOrigianl,0x00,65536);
		memcpy(byteDataRecvOrigianl,pStart,pEnd-pStart+1);

		//delete[] byteDataRecvOrigianl;
		//return;

	}
	if (iType==1||iType==0)//mm
	{
		routeType=iType;
		flag=json_object["messageType"].asInt();

		if (flag==1000||flag==1016)
		{
			p_ToDelphiData=new ConnectFava();
			((ConnectFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((ConnectFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

			strcpy(((ConnectFava*)p_ToDelphiData)->planText, json_object["planText"].asString().data());
			strcpy(((ConnectFava*)p_ToDelphiData)->encodingData, json_object["encodingData"].asString().data());
			strcpy(((ConnectFava*)p_ToDelphiData)->status, json_object["status"].asString().data());
			strcpy(((ConnectFava*)p_ToDelphiData)->playerId, json_object["playerId"].asString().data());

		}

		if (flag==1001||flag==1005||flag==1012||flag==1013||flag==1014)
		{
			p_ToDelphiData=new PlayerFava();
			((PlayerFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((PlayerFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

			strcpy(((PlayerFava*)p_ToDelphiData)->playerId, json_object["playerId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->nickName, json_object["nickName"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->userType, json_object["userType"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->comId, json_object["comId"].asString().data());

			strcpy(((PlayerFava*)p_ToDelphiData)->comType, json_object["comType"].asString().data());

			strcpy(((PlayerFava*)p_ToDelphiData)->provinceId, json_object["provinceId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->refId, json_object["refId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->saledptId, json_object["saledptId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->saleManId, json_object["saleManId"].asString().data());


			strcpy(((PlayerFava*)p_ToDelphiData)->serviceId, json_object["serviceId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->saleCenterId, json_object["saleCenterId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->sceneId, json_object["sceneId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->instanceId, json_object["instanceId"].asString().data());


			((PlayerFava*)p_ToDelphiData)->diaPlayerNum=json_object["diaPlayerNum"].asInt();
			((PlayerFava*)p_ToDelphiData)->playerStatus=json_object["playerStatus"].asInt();

			((PlayerFava*)p_ToDelphiData)->playerSkill=json_object["playerSkill"].asInt();
			((PlayerFava*)p_ToDelphiData)->clientType=json_object["clientType"].asInt();

		}
		if (flag==1002)
		{


			p_ToDelphiData=new GroupFava();
			((GroupFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((GroupFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

			strcpy(((GroupFava*)p_ToDelphiData)->playerId, json_object["playerId"].asString().data());
			strcpy(((GroupFava*)p_ToDelphiData)->refId, json_object["refId"].asString().data());
			strcpy(((GroupFava*)p_ToDelphiData)->comId, json_object["comId"].asString().data());
			strcpy(((GroupFava*)p_ToDelphiData)->chatTxt, json_object["chatTxt"].asString().data());

			strcpy(((GroupFava*)p_ToDelphiData)->nickName, json_object["nickName"].asString().data());
			strcpy(((GroupFava*)p_ToDelphiData)->showChatTxt, json_object["showChatTxt"].asString().data());
			/*  strcpy(((GroupFava*)p_ToDelphiData)->saledptId, json_object["saledptId"].asString().data());
			strcpy(((GroupFava*)p_ToDelphiData)->saleManId, json_object["saleManId"].asString().data());


			strcpy(((PlayerFava*)p_ToDelphiData)->serviceId, json_object["serviceId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->saleCenterId, json_object["saleCenterId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->sceneId, json_object["sceneId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->instanceId, json_object["instanceId"].asString().data());


			((PlayerFava*)p_ToDelphiData)->diaPlayerNum=json_object["diaPlayerNum"].asInt();
			((PlayerFava*)p_ToDelphiData)->playerStatus=json_object["playerStatus"].asInt();

			((PlayerFava*)p_ToDelphiData)->playerSkill=json_object["playerSkill"].asInt();
			((PlayerFava*)p_ToDelphiData)->clientType=json_object["clientType"].asInt();*/


		}

		if (flag==1006)
		{


			p_ToDelphiData=new CommandFava();
			((CommandFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((CommandFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

			strcpy(((CommandFava*)p_ToDelphiData)->type, json_object["type"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->id, json_object["id"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->variable, json_object["variable"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->msg, json_object["msg"].asString().data());

			strcpy(((CommandFava*)p_ToDelphiData)->zoneType, json_object["zoneType"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->zoneId, json_object["zoneId"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->zoneName, json_object["zoneName"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->senderId, json_object["senderId"].asString().data());


			strcpy(((CommandFava*)p_ToDelphiData)->senderName, json_object["senderName"].asString().data());
			strcpy(((CommandFava*)p_ToDelphiData)->senderType, json_object["senderType"].asString().data());
			/*   strcpy(((PlayerFava*)p_ToDelphiData)->sceneId, json_object["sceneId"].asString().data());
			strcpy(((PlayerFava*)p_ToDelphiData)->instanceId, json_object["instanceId"].asString().data());


			((PlayerFava*)p_ToDelphiData)->diaPlayerNum=json_object["diaPlayerNum"].asInt();
			((PlayerFava*)p_ToDelphiData)->playerStatus=json_object["playerStatus"].asInt();

			((PlayerFava*)p_ToDelphiData)->playerSkill=json_object["playerSkill"].asInt();
			((PlayerFava*)p_ToDelphiData)->clientType=json_object["clientType"].asInt();*/


		}
		if (flag==1010)
		{
			p_ToDelphiData=new PlayerIdListFava ();
			((PlayerIdListFava *)p_ToDelphiData)->messageType=json_object["messageType"].asInt();

			TRACE("1收到 flag=1010,messageType= %d",((PlayerIdListFava *)p_ToDelphiData)->messageType);

			((PlayerIdListFava *)p_ToDelphiData)->routeType=json_object["routeType"].asInt();
			strcpy(((PlayerIdListFava *)p_ToDelphiData)->comId, json_object["comId"].asString().data());

			if(json_object["playerIdArray"].isArray())
			{
				Json::Value temp1 = json_object["playerIdArray"];
				// printf("key_array is array.size=%d\n",temp1.size());
				((PlayerIdListFava *)p_ToDelphiData)->ListLen=temp1.size();

				//ValueIterator 
				int iNum=0;
				for(Json::ValueIterator itr=temp1.begin();itr!=temp1.end();itr++)
				{

					Json::Value v1 = *itr;
					/* if(v1.isInt())
					{
					printf("Value=[%d]\n",v1.asInt());
					}
					else */
					if(v1.isString())
					{
						char* pdata=new char[128];
						memset(pdata,0x00,128);
						strcpy(pdata,v1.asString().data());
						((PlayerIdListFava *)p_ToDelphiData)->playerIdArray[iNum]=pdata;
						iNum++;



						//printf("Value=[%s]\n",v1.asString().data());
					}
					else
					{
						// printf("这是什么类型.%d\n");
					}
				}

			}

			TRACE("收到 flag=1010,messageType= %d ,LIst长度,%d",((PlayerIdListFava *)p_ToDelphiData)->messageType,((PlayerIdListFava *)p_ToDelphiData)->ListLen);


		}

		if (flag==1011)
		{
			p_ToDelphiData=new ChangeFava();
			((ChangeFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((ChangeFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

		}

		if (flag==1003||flag==1007||flag==1008||flag==1009)
		{
			p_ToDelphiData=new SingleFava();
			((SingleFava*)p_ToDelphiData)->messageType=json_object["messageType"].asInt();
			((SingleFava*)p_ToDelphiData)->routeType=json_object["routeType"].asInt();

			strcpy(((SingleFava*)p_ToDelphiData)->playerId, json_object["playerId"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->refId, json_object["refId"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->chatTxt, json_object["chatTxt"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->comId, json_object["comId"].asString().data());

			strcpy(((SingleFava*)p_ToDelphiData)->refPlayerComId, json_object["refPlayerComId"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->nickName, json_object["nickName"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->refPlayerName, json_object["refPlayerName"].asString().data());
			strcpy(((SingleFava*)p_ToDelphiData)->playerType, json_object["playerType"].asString().data());


			strcpy(((SingleFava*)p_ToDelphiData)->refPlayerType, json_object["refPlayerType"].asString().data());
			
			((SingleFava*)p_ToDelphiData)->playerSkill=json_object["playerSkill"].asInt();

		}

	}




	return ;
}
DataReved::~DataReved(void)
{
	/* if (flag==1010)
	{

	for (int i=0; i<  ((PlayerIdListFava *)p_ToDelphiData)->ListLen;i++)
	{
	delete ((PlayerIdListFava *)p_ToDelphiData)->
	}
	}*/
	// ((PlayerIdListFava*)p_ToDelphiData)->playerIdArray->at(i);
/////////////////////2011-10-14
	//if (routeType==0)//flex
	//{
	//	delete[] byteDataRecvOrigianl;
	//}
	////////////////////
	if (routeType==1||routeType==0)//mm
	{


		delete[] byteDataRecvOrigianl;


		if (flag==1010)
		{
			int i=0;
			for (i=0;i < ((PlayerIdListFava*)p_ToDelphiData)->ListLen;i++)
			{
				delete[] ((PlayerIdListFava*)p_ToDelphiData)->playerIdArray[i];
			}
		}
		
		//delete p_ToDelphiData;

		/////////////////////////////////////////////////////////////////

		if (flag==1000||flag==1016)
		{
			delete (ConnectFava*)p_ToDelphiData;


		}

		if (flag==1001||flag==1005||flag==1012||flag==1013||flag==1014)
		{
			//p_ToDelphiData=new PlayerFava();
			delete (PlayerFava*)p_ToDelphiData;


		}
		if (flag==1002)
		{


			//p_ToDelphiData=new GroupFava();
			delete (GroupFava*)p_ToDelphiData;

		}

		if (flag==1006)
		{


			//p_ToDelphiData=new CommandFava();
			delete (CommandFava*)p_ToDelphiData;


		}
		if (flag==1010)
		{

			//for (int i=0;i<((PlayerIdListFava*)p_ToDelphiData)->ListLen;i++)
		 //{


			// delete[]  ((PlayerIdListFava*)p_ToDelphiData)->playerIdArray[i];

		 //}
			//p_ToDelphiData=new PlayerIdListFava ();
			delete (PlayerIdListFava*)p_ToDelphiData;

		}

		if (flag==1011)
		{
			//p_ToDelphiData=new ChangeFava();
			delete (ChangeFava*)p_ToDelphiData;


		}

		if (flag==1003||flag==1007||flag==1008||flag==1009)
		{
			//p_ToDelphiData=new SingleFava();
			delete (SingleFava*)p_ToDelphiData;


		}
		///////////////////////////////////////////////////////////


	}

}