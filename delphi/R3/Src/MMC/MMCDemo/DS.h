#include "stdafx.h"
#include <list>
#include <queue>
#include <vector>
#include <iostream>

using namespace std ;



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
		/*messageType=new char[1024];
		routeType=new char[1024];*/


		planText=new char[1024];
		encodingData=new char[1024];
		status=new char[1024];
		playerId=new char[1024];


		//memset(messageType,0x00,1024);
		//memset(routeType,0x00,1024);

		memset(planText,0x00,1024);
		memset(encodingData,0x00,1024);
		memset(status,0x00,1024);
		memset(playerId,0x00,1024);




	}
	~ConnectFava()
	{
		/*delete messageType;
		delete routeType;*/


		delete planText;
		delete encodingData;
		delete status;
		delete playerId;




	}
	/* ConnectFava()
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
	delete planText;
	delete encodingData;
	delete status;
	delete playerId;


	}*/
};



struct ChangeFava
{
	int messageType;
	int routeType;



	ChangeFava()
	{
		/*messageType=new char[1024];
		routeType=new char[1024];*/

	}
	~ChangeFava()
	{

		/*delete messageType;
		delete routeType;
		*/
	}

};


//struct ConnectFavaStr
//{
//	ConnectFavaStr()
//	{
//      memset(planText,0x00,1024);
//	  memset(encodingData,0x00,1024);
//	  memset(status,0x00,1024);
//	  memset(playerId,0x00,1024);
//
//	}
//    char planText[1024]; 
//	char encodingData[1024];
//	char status[1024];
//	char playerId[1024];
//
//};

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
		/*	messageType=new char[1024];
		routeType=new char[1024];*/


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

		/*memset(messageType,0x00,1024);
		memset(routeType,0x00,1024);*/

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
		/*delete messageType;
		delete routeType;*/
		delete type;
		delete id;
		delete variable;
		delete msg;
		delete zoneType;
		delete zoneId;
		delete zoneName;
		delete senderId;
		delete senderName;
		delete senderType;


	}


};
//struct CommandFavaStr
//{
//
//	CommandFavaStr()
//	{
//      memset(type,0x00,1024);
//	  memset(id,0x00,1024);
//	  memset(variable,0x00,1024);
//	  memset(msg,0x00,1024);
//
//	  memset(zoneType,0x00,1024);
//	  memset(zoneId,0x00,1024);
//	  memset(zoneName,0x00,1024);
//	  memset(senderId,0x00,1024);
//	  memset(senderName,0x00,1024);
//	  memset(senderType,0x00,1024);
//
//	}
//
//
//
//    char type[1024];//��������
//	char id[1024]; // ����id
//	char variable[1024]; // ����
//	char msg[1024]; // ��������
//	char zoneType[1024]; // ɢ����Χ
//	char zoneId[1024]; // ɢ����Χid
//	char zoneName[1024];//ɢ����Χ����
//	char senderId[1024];//�������id
//	char senderName[1024];//������߳ƺ�
//	char senderType[1024];//��������û�����
//
//
//
//};
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
		/*    messageType=new char[1024];
		routeType=new char[1024];*/


		playerId=new char[1024];
		refId=new char[1024];
		chatTxt=new char[1024];
		comId=new char[1024];
		refPlayerComId=new char[1024];
		nickName=new char[1024];
		refPlayerName=new char[1024];
		playerType=new char[1024];
		refPlayerType=new char[1024];
		playerSkill=0;

		/*memset(messageType,0x00,1024);
		memset(routeType,0x00,1024);*/

		memset(playerId,0x00,1024);
		memset(refId,0x00,1024);
		memset(chatTxt,0x00,1024);
		memset(comId,0x00,1024);
		memset(refPlayerComId,0x00,1024);
		memset(nickName,0x00,1024);
		memset(refPlayerName,0x00,1024);
		memset(playerType,0x00,1024);
		memset(refPlayerType,0x00,1024);
		// memset(senderType,0x00,1024);

	}
	~SingleFava()
	{
		//delete messageType;
		//	    delete routeType;

		delete playerId;
		delete refId;
		delete chatTxt;
		delete comId;
		delete refPlayerComId;
		delete nickName;
		delete refPlayerName;
		delete playerType;
		delete refPlayerType;
		//delete senderType;


	}


};


//struct SingleFavaStr
//{
//
//	SingleFavaStr()
//	{
//      memset(playerId,0x00,1024);
//	  memset(refId,0x00,1024);
//	  memset(chatTxt,0x00,1024);
//	  memset(comId,0x00,1024);
//
//	  memset(refPlayerComId,0x00,1024);
//	  memset(nickName,0x00,1024);
//	  memset(refPlayerName,0x00,1024);
//	  memset(playerType,0x00,1024);
//	  memset(refPlayerType,0x00,1024);
//	 
//	  playerSkill=0;
//
//	}
//
//    char playerId[1024];//��Ϣ������
//	char refId[1024];//��Ϣ������
//	char chatTxt[1024];//����
//	char comId[1024];//������Ϣ�߹�˾
//	char refPlayerComId[1024];//��Ϣ�����߹�˾
//	char nickName[1024];//������Ϣ���ǳ�
//	char refPlayerName[1024];//��Ϣ�������ǳ�
//	char playerType[1024];//��Ϣ�������û�����
//	char refPlayerType[1024];//��Ϣ�������û�����
//	int playerSkill;//��Ҽ���(0:û�м��ܣ�1:�ͷ����ܣ�Ĭ��û�м���)
//
//
//};

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
		/*   messageType=new char[1024];
		routeType=new char[1024];*/


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

		//memset(messageType,0x00,1024);
		//memset(routeType,0x00,1024);

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
		/*delete messageType;
		delete routeType;*/

		delete playerId;
		delete nickName;
		delete userType;
		delete comId;
		delete comType;
		delete provinceId;
		delete refId;
		delete saledptId;
		delete saleManId;
		delete serviceId;
		delete saleCenterId;

		delete sceneId;
		delete instanceId;




	}


};

//struct PlayerFavaStr
//{
////������Ϣ
//
//
//	PlayerFavaStr()
//	{
//      memset(playerId,0x00,1024);
//	  memset(nickName,0x00,1024);
//	  memset(userType,0x00,1024);
//	  memset(comId,0x00,1024);
//
//	  memset(provinceId,0x00,1024);
//	  memset(refId,0x00,1024);
//	  memset(saledptId,0x00,1024);
//	  memset(saleManId,0x00,1024);
//	  memset(serviceId,0x00,1024);
//
//	  memset(saleCenterId,0x00,1024);
//
//	  memset(sceneId,0x00,1024);
//	  memset(instanceId,0x00,1024);
//	 
//	 diaPlayerNum=0;
//    playerStatus=0;
//   playerSkill=0;
//   clientType=0;
//	}
//
//
//	char  playerId[1024];//ID
//	char  nickName[1024];//�س�
//	char  userType[1024];//����
//	char  comId[1024]; //��˾ID
//	char  provinceId[1024];//ʡ��˾��
//	char  refId[1024];//�û�refID
//	char  saledptId[1024];//Ӫ����ID
//	char   saleManId[1024];//�ͻ�����ID
//	char   serviceId[1024];//���߿ͷ�ID
//	char   saleCenterId[1024];//Ӫ������ID
//	//�����Ϣ
//	char sceneId[1024]; //����ID
//	char  instanceId[1024]; //����ID
//	 int diaPlayerNum;//�����뵱ǰ��ҶԻ�������
//	 int playerStatus;//���״̬(0�����У�1��æ��Ĭ�Ͽ���)
//	 int playerSkill;//��Ҽ���(0:û�м��ܣ�1:�ͷ����ܣ�Ĭ��û�м���)
//	 int clientType;//�ͻ��˵�����(0Ϊweb�ͻ��ˣ�1Ϊair�ͻ���)
//
//
//};



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
		/*messageType=new char[1024];
		routeType=new char[1024];*/


		playerId=new char[1024];
		refId=new char[1024];

		comId=new char[1024];
		chatTxt=new char[1024];

		nickName=new char[1024];
		showChatTxt=new char[1024];

		/*saledptId=new char[1024];

		saleManId=new char[1024];
		serviceId=new char[1024];
		saleCenterId=new char[1024];

		sceneId=new char[1024];
		instanceId=new char[1024];


		diaPlayerNum=0;
		playerStatus=0;
		playerSkill=0;
		clientType=0;*/

		/*memset(messageType,0x00,1024);
		memset(routeType,0x00,1024);*/

		memset(playerId,0x00,1024);
		memset(refId,0x00,1024);

		memset(comId,0x00,1024);
		memset(chatTxt,0x00,1024);

		memset(nickName,0x00,1024);
		memset(showChatTxt,0x00,1024);

		/*
		memset(saledptId,0x00,1024);
		memset(saleManId,0x00,1024);
		memset(serviceId,0x00,1024);
		memset(saleCenterId,0x00,1024);

		memset(sceneId,0x00,1024);
		memset(instanceId,0x00,1024);*/

	}
	~GroupFava()
	{
		/*	delete messageType;
		delete routeType;*/

		delete playerId;
		delete refId;
		delete comId;
		delete chatTxt;



		delete nickName;
		delete showChatTxt;


		/*
		delete saledptId;
		delete saleManId;
		delete serviceId;
		delete saleCenterId;

		delete sceneId;
		delete instanceId;

		*/


	}




};


//struct GroupFavaStr
//{
//	GroupFavaStr()
//	{
//        memset(playerId,0x00,1024);
//		memset(refId,0x00,1024);
//		memset(comId,0x00,1024);
//		memset(chatTxt,0x00,1024);
//		memset(nickName,0x00,1024);
//		memset(showChatTxt,0x00,1024);
//
//	}
//
//
//	char playerId[1024];
//	char refId[1024];
//	char comId[1024];
//	char chatTxt[1024];
//	char nickName[1024];
//	char showChatTxt[1024];
//};

typedef list<struct PlayerFava*> CListPlayerFava;
struct InitPlayerFava
{

	int messageType;
	int routeType;

	int ListLen;
	char* sceneId;
	CListPlayerFava* playerList; 

	InitPlayerFava()
	{
		/* messageType=new char[1024];
		routeType=new char[1024];*/


		sceneId=new char[1024];

		ListLen =0;

		playerList=new CListPlayerFava();



		/*refId=new char[1024];

		comId=new char[1024];
		chatTxt=new char[1024];

		nickName=new char[1024];
		showChatTxt=new char[1024];*/



		/*memset(messageType,0x00,1024);
		memset(routeType,0x00,1024);*/

		memset(sceneId,0x00,1024);


		/* memset(refId,0x00,1024);

		memset(comId,0x00,1024);
		memset(chatTxt,0x00,1024);

		memset(nickName,0x00,1024);
		memset(showChatTxt,0x00,1024);*/



	}
	~InitPlayerFava()
	{
		/*delete messageType;
		delete routeType;*/

		delete sceneId;
		delete playerList;



		//delete comId;
		//delete chatTxt;



		//      delete nickName;
		//delete showChatTxt;
		//

		/*
		delete saledptId;
		delete saleManId;
		delete serviceId;
		delete saleCenterId;

		delete sceneId;
		delete instanceId;

		*/


	}

};
typedef vector<char*> CListChar;
struct PlayerIdListFava
{
	int messageType;
	int routeType;

	int ListLen;
	char* comId;
	CListChar* playerIdArray;




	PlayerIdListFava()
	{
		/* messageType=new char[1024];
		routeType=new char[1024];*/

		ListLen =0;

		comId=new char[1024];
		playerIdArray=new CListChar();



		//memset(messageType,0x00,1024);
		//memset(routeType,0x00,1024);
		memset(comId,0x00,1024);

		//memset(sceneId,0x00,1024);



	}
	~PlayerIdListFava()
	{
		/*delete messageType;
		delete routeType;*/

		delete comId;
		delete playerIdArray;


	}


};

struct PlayerListFava
{
	int messageType;
	int routeType;

	int ListLen;
	struct PlayerFava* playerFava;
	CListPlayerFava* playerList;


	PlayerListFava()
	{
		/*    messageType=new char[1024];
		routeType=new char[1024];*/

		ListLen =0;

		playerFava=new PlayerFava();
		playerList=new CListPlayerFava();



		/*  memset(messageType,0x00,1024);
		memset(routeType,0x00,1024);*/

		//memset(sceneId,0x00,1024);



	}
	~PlayerListFava()
	{
		/*	delete messageType;
		delete routeType;*/

		delete playerFava;
		delete playerList;


	}
};
//struct InitPlayerFavaStr
//{
//
//	private String sceneId;
//	private List<PlayerFava> playerList;
//};

