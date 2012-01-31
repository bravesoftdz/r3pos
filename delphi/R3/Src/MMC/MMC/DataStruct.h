#pragma once

#include "stdafx.h"

using namespace std ;


struct PLCControlFava
{
	int szFlag;
	char* szMethodName;
	char* szPara1;
	char* szPara2;
	char* szPara3;
};
struct ConnectFava
{
	int messageType;
	int routeType;
    char* planText; 
	char* encodingData;
	char* status;
	char* playerId;

	 ConnectFava()
	{
		


		planText=new char[1024];
		encodingData=new char[1024];
		status=new char[1024];
		playerId=new char[1024];


	 

      memset(planText,0x00,1024);
	  memset(encodingData,0x00,1024);
	  memset(status,0x00,1024);
	  memset(playerId,0x00,1024);




	}
	~ConnectFava()
	{
	


		delete[] planText;
		delete[] encodingData;
		delete[] status;
		delete[] playerId;



 
	}
   
};



struct ChangeFava
{
	int messageType;
	int routeType;



	 ChangeFava()
	{
		

	}
	~ChangeFava()
	{
		
	
	}
  
};




struct CommandFava
{

	int messageType;
	int routeType;

    char* type;//��������
	char* id; // ����id
	char* variable; // ����
	char* msg; // ��������
	char* zoneType; // ɢ����Χ
	char* zoneId; // ɢ����Χid
	char* zoneName;//ɢ����Χ����
	char* senderId;//�������id
	char* senderName;//������߳ƺ�
	char* senderType;//��������û�����


	 CommandFava()
	{



		type=new char[1024];
		id=new char[1024];
		variable=new char[1024];
		msg=new char[1024];
		zoneType=new char[1024];
		zoneId=new char[1024];
		zoneName=new char[1024];
		senderId=new char[1024];
		senderName=new char[1024];
		senderType=new char[1024];

		

      memset(type,0x00,1024);
	  memset(id,0x00,1024);
	  memset(variable,0x00,1024);
	  memset(msg,0x00,1024);
	  memset(zoneType,0x00,1024);
	  memset(zoneId,0x00,1024);
	  memset(zoneName,0x00,1024);
	  memset(senderId,0x00,1024);
	  memset(senderName,0x00,1024);
	  memset(senderType,0x00,1024);

	}
	~CommandFava()
	{

		delete[] type;
		delete[] id;
		delete[] variable;
		delete[] msg;
        delete[] zoneType;
		delete[] zoneId;
		delete[] zoneName;
		delete[] senderId;
		delete[] senderName;
		delete[] senderType;

 
	}


};

struct SingleFava
{

	int messageType;
	int routeType;

    char* playerId;//��Ϣ������
	char* refId;//��Ϣ������
	char* chatTxt;//����
	char* comId;//������Ϣ�߹�˾
	char* refPlayerComId;//��Ϣ�����߹�˾
	char* nickName;//������Ϣ���ǳ�
	char* refPlayerName;//��Ϣ�������ǳ�
	char* playerType;//��Ϣ�������û�����
	char* refPlayerType;//��Ϣ�������û�����
	int playerSkill;//��Ҽ���(0:û�м��ܣ�1:�ͷ����ܣ�Ĭ��û�м���)
      SingleFava()
	{
 


		playerId=new char[1024];
		refId=new char[1024];
		chatTxt=new char[65536];
		comId=new char[1024];
		refPlayerComId=new char[1024];
		nickName=new char[1024];
		refPlayerName=new char[1024];
		playerType=new char[1024];
		refPlayerType=new char[1024];
		playerSkill=0;

	

      memset(playerId,0x00,1024);
	  memset(refId,0x00,1024);
	  memset(chatTxt,0x00,65536);
	  memset(comId,0x00,1024);
	  memset(refPlayerComId,0x00,1024);
	  memset(nickName,0x00,1024);
	  memset(refPlayerName,0x00,1024);
	  memset(playerType,0x00,1024);
	  memset(refPlayerType,0x00,1024);


	}
	  ~SingleFava()
	  {


		delete[] playerId;
		delete[] refId;
		delete[] chatTxt;
		delete[] comId;
        delete[] refPlayerComId;
		delete[] nickName;
		delete[] refPlayerName;
		delete[] playerType;
		delete[] refPlayerType;
		

 
	  }


};




struct PlayerFava
{
	int messageType;
	int routeType;
//������Ϣ
	char*  playerId;//ID
	char*  nickName;//�س�
	char*  userType;//����
	char*  comId; //��˾ID

    char*  comType;//��˾���ͣ��ַ�����2λ(00:���Ҿ�,01:ʡ��˾,02:���й�˾)

	char*  provinceId;//ʡ��˾��
	char*  refId;//�û�refID
	char*  saledptId;//Ӫ����ID
	char*   saleManId;//�ͻ�����ID
	char*   serviceId;//���߿ͷ�ID
	char*   saleCenterId;//Ӫ������ID
	//�����Ϣ
	char* sceneId; //����ID
	char*  instanceId; //����ID
	 int diaPlayerNum;//�����뵱ǰ��ҶԻ�������
	 int playerStatus;//���״̬(0�����У�1��æ��Ĭ�Ͽ���)
	 int playerSkill;//��Ҽ���(0:û�м��ܣ�1:�ͷ����ܣ�Ĭ��û�м���)
	 int clientType;//�ͻ��˵�����(0Ϊweb�ͻ��ˣ�1Ϊair�ͻ���)



	  PlayerFava()
	{
   


		playerId=new char[1024];
		nickName=new char[1024];

		userType=new char[1024];
		comId=new char[1024];
        comType=new char[1024];
		provinceId=new char[1024];
		refId=new char[1024];

		saledptId=new char[1024];
		
		saleManId=new char[1024];
		serviceId=new char[1024];
		saleCenterId=new char[1024];

		sceneId=new char[1024];
		instanceId=new char[1024];


        diaPlayerNum=0;
        playerStatus=0;
		playerSkill=0;
		clientType=0;



      memset(playerId,0x00,1024);
	  memset(nickName,0x00,1024);
	  memset(userType,0x00,1024);
	  memset(comId,0x00,1024);
	  memset(comType,0x00,1024);
	  memset(provinceId,0x00,1024);
	  memset(refId,0x00,1024);
	  memset(saledptId,0x00,1024);
	  memset(saleManId,0x00,1024);
	  memset(serviceId,0x00,1024);
	  memset(saleCenterId,0x00,1024);

	  memset(sceneId,0x00,1024);
	  memset(instanceId,0x00,1024);

	}
	  ~PlayerFava()
	  {
	

		delete[] playerId;
		delete[] nickName;
		delete[] userType;
		delete[] comId;
        delete[] comType;
        delete[] provinceId;
		delete[] refId;
		delete[] saledptId;
		delete[] saleManId;
		delete[] serviceId;
		delete[] saleCenterId;

		delete[] sceneId;
		delete[] instanceId;



 
	  }


};





struct GroupFava
{
	int messageType;
	int routeType;

	char* playerId;
	char* refId;
	char* comId;
	char* chatTxt;
	char* nickName;
	char* showChatTxt;


	 GroupFava()
	{
       


		playerId=new char[1024];
		refId=new char[1024];

		comId=new char[1024];
		chatTxt=new char[65536];

		nickName=new char[1024];
		showChatTxt=new char[1024];

		

      memset(playerId,0x00,1024);
	  memset(refId,0x00,1024);

	  memset(comId,0x00,1024);
	  memset(chatTxt,0x00,65536);

	  memset(nickName,0x00,1024);
	  memset(showChatTxt,0x00,1024);


	}
	  ~GroupFava()
	  {


		delete[] playerId;
		delete[] refId;
		delete[] comId;
		delete[] chatTxt;



        delete[] nickName;
		delete[] showChatTxt;
		



 
	  }




};



typedef vector<char*> CListChar;
struct PlayerIdListFava
{
	int messageType;
	int routeType;

    int ListLen;
	char* comId;
	char** playerIdArray;




	 PlayerIdListFava()
	{
       

		ListLen =0;

       comId=new char[1024];
       playerIdArray=new char*[1024];



	
	   memset(comId,0x00,1024);
      




	}
	  ~PlayerIdListFava()
	  {
		

		delete[] comId;
		delete[] (char**)playerIdArray;

 
	  }


};




struct strDataStruct
{

	strDataStruct()
	{
		nVertion=1;
		nVertion=htons(nVertion);
		memcpy(BnVersion,&nVertion,2);
		cert[0]=cert[0]&0x00;
		cert[1]=cert[1]&0x00;
		cert[2]=cert[2]&0x00;
		cert[3]=cert[3]&0x00;
		P2pFlag=0x01;
		yl[0]=yl[0]&0x00;
		yl[1]=yl[1]&0x00;
		yl[2]=yl[2]&0x00;
		yl[3]=yl[3]&0x00;
		yl[4]=yl[4]&0x00;
		yl[5]=yl[5]&0x00;
		yl[6]=yl[6]&0x00;
		yl[7]=yl[7]&0x00;
		end[0]=0xFF;
		end[1]=0xFF;

     
        memset(BDataLen,0x00,4);
       // memset(BnVersion,0x00,2);


       BP=new BYTE[65536];
	   memset(BP,0x00,65536);

	   pByte=new char[65536];
	   memset(pByte,0x00,65536);

	}


	~strDataStruct()
	{
		

delete[] pByte;
delete[] BP;

	}

	// ���ݳ���
	int DataLen;
	BYTE BDataLen[4];//


	;
	//Э��汾
	

	SHORT nVertion;
	BYTE BnVersion[2];

	BYTE cert[4];
    //char messageType[2];
    BYTE P2pFlag;//1������ת����2 P2P

	BYTE yl[8];
	//BYTE Message[1024];

	BYTE end[2];



	char *pByte;
    BYTE *BP;
	int iDataInArrayLen;
	
	
  
};


class CDataClass
{
public:
	       CDataClass(BYTE* pLCByte);
           CDataClass(int flagin,void* Pin);

		 

		   ~CDataClass(void);
		
	void * p_originaldata;
	
	int flag;

    struct strDataStruct  data_AfterOper;




};

class DataReved
{
	public:
	DataReved(BYTE* pStart,BYTE* pEnd);
	
	~DataReved(void);//Flex�ͻ��˶���Ϊ0���������͵Ķ���Ϊ1


	BYTE * byteDataRecvOrigianl;
    int flag;
	int iOriginalDataLen;
    void * p_ToDelphiData;
	int routeType;//

	int lengthofbyteDataRecvOrigianl;



};
