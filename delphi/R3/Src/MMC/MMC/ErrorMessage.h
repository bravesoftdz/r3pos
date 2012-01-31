//
//#include <iostream>
//#include <vector>
//
//class KVPoint
//{
//public :
//	KVPoint(int iKey ,char* pValue)
//	{
//		char* value=new char[128];
//		memset(value,0x00,128);
//		strcpy(value,pValue);
//		key=iKey;
//
//	}
//	~KVPoint()
//	{
//		delete[] value;
//
//
//	}
//	int key;
//	char* value;
//};
//typedef vector<KVPoint*> CErrorPointArray;
//
//class CErrorMessage
//{
//public:
//	CErrorMessage()
//	{
//		char Error30002[]="网络连接断开";
//		char Error30011[]="认证失败";//connectFava 认证失败
//		char Error30012[]="修改用户信息失败";//1012 失败
//		char Error30013[]="没有获取到客服";//1013失败
//		char Error30020[]="未连接";//
//
//		char Error60001[]="未定义错误";//
//
//		KVPoint* E30002=new KVPoint(30002,Error30002);
//		KVPoint* E30011=new KVPoint(30011,Error30011);
//		KVPoint* E30012=new KVPoint(30012,Error30012);
//		KVPoint* E30013=new KVPoint(30013,Error30013);
//		KVPoint* E30020=new KVPoint(30020,Error30020);
//
//		KVPoint* E60001=new KVPoint(60001,Error60001);
//
//		ObiectErrorPointArray.push_back(E30002);
//		ObiectErrorPointArray.push_back(E30011);
//		ObiectErrorPointArray.push_back(E30012);
//		ObiectErrorPointArray.push_back(E30013);
//		ObiectErrorPointArray.push_back(E30020);
//		ObiectErrorPointArray.push_back(E60001);
//
//
//
//	}
//	~CErrorMessage(void)
//	{
//		for (int i=0;i<ObiectErrorPointArray.size();i++)
//		{
//			delete ObiectErrorPointArray.at(i);
//
//
//		}
//		ObiectErrorPointArray.clear();
//
//	
//	}
//
//	CErrorPointArray ObiectErrorPointArray;
//	const char* GetErrorMessage(int iError)
//	{
//
//		for (int i=0 ;i<ObiectErrorPointArray.size();i++)
//		{
//			if ((ObiectErrorPointArray.at(i))->key==iError)
//			{
//				return (ObiectErrorPointArray.at(i))->value;
//			}
//
//		}
//
//		for (int i=0 ;i<ObiectErrorPointArray.size();i++)
//		{
//			if ((ObiectErrorPointArray.at(i))->key==60001)
//			{
//				return (ObiectErrorPointArray.at(i))->value;
//			}
//
//		}
//		
//
//
//	}
//};

class CErrorMessage
{
public:
	char* Error30002;
	char* Error30011;
	char* Error30012;
	char* Error30013;
	char* Error30020;
	char* Error60001;
	char* Error30003;
	char* Error30030;
	char* Error30040;

	char* Error30050;
	char* Error30051;
	char* Error30052;
	char* Error30053;

	CErrorMessage()
	{

		Error30002=new char[128];
		Error30011=new char[128];
		Error30012=new char[128];
		Error30013=new char[128];
		Error30020=new char[128];
		Error60001=new char[128];
		Error30003=new char[128];
		Error30030=new char[128];
		Error30040=new char[128];

		Error30050=new char[128];
		Error30051=new char[128];
		Error30052=new char[128];
		Error30053=new char[128];

		memset(Error30002,0x00,128);
		memset(Error30011,0x00,128);
		memset(Error30012,0x00,128);
		memset(Error30013,0x00,128);
		memset(Error30020,0x00,128);
		memset(Error60001,0x00,128);
		memset(Error30003,0x00,128);
		memset(Error30030,0x00,128);
		memset(Error30040,0x00,128);

		memset(Error30050,0x00,128);
		memset(Error30051,0x00,128);
		memset(Error30052,0x00,128);
		memset(Error30053,0x00,128);

		strcpy(Error30002,"网络连接断开");
		strcpy(Error30011,"认证失败");
		strcpy(Error30012,"修改用户信息失败");
		strcpy(Error30013,"没有获取到客服");
		strcpy(Error30020,"未连接");
		strcpy(Error60001,"未定义错误");
		strcpy(Error30003,"已经连接");
		strcpy(Error30030,"您发送消息的字数太多，请重新发送。");
		strcpy(Error30040,"LCCoonnection初始化失败。");

		strcpy(Error30050,"内存异常");
		strcpy(Error30051,"文件异常");
		strcpy(Error30052,"一般异常");
		strcpy(Error30053,"未知异常");




		//      
		//char* Error30002[]="网络连接断开";
		//char Error30Error30030011[]="认证失败";//connectFava 认证失败
		//char Error30012[]="修改用户信息失败";//1012 失败
		//char Error30013[]="没有获取到客服";//1013失败
		//char Error30020[]="未连接";//

		//char Error60001[]="未定义错误";//



	}
	~CErrorMessage(void)
	{
		delete[] Error30002;
		delete[] Error30011;
		delete[] Error30012;
		delete[] Error30013;
		delete[] Error30020;
		delete[] Error60001;
		delete[] Error30003;
		delete[] Error30030;
		delete[] Error30040;

		delete[] Error30050;
		delete[] Error30051;
		delete[] Error30052;
		delete[] Error30053;


	}

	//CErrorPointArray ObiectErrorPointArray;
	char* GetErrorMessage(int iError)
	{

		switch (iError)
		{
		case 30002:
			return Error30002;
		case 30011:
			return Error30011;
		case 30012:
			return Error30012;
		case 30013:
			return Error30013;
		case 30020:
			return Error30020;
		case 30003:
			return Error30003;
		case 30030:
			return Error30030;
		case 30040:
			return Error30040;

		case 30050:
			return Error30050;
		case 30051:
			return Error30051;
		case 30052:
			return Error30052;
		case 30053:
			return Error30053;





		default:
			return Error60001;
			//break;
		}



	}
};