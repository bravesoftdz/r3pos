// mmPing2.cpp : 定义应用程序的入口点。
//

#include "stdafx.h"
#include "mmPing2.h"
#include "base64.h"

#define MAX_LOADSTRING 100

// 全局变量:
HINSTANCE hInst;								// 当前实例
TCHAR szTitle[MAX_LOADSTRING];					// 标题栏文本
TCHAR szWindowClass[MAX_LOADSTRING];			// 主窗口类名

// 此代码模块中包含的函数的前向声明:
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);

const string mmName = "{FA49A7C5-1A5F-4461-8E0D-65DE9E9D2D0A}";

#define MI_ACTIVEAPP	1  
#define MI_GETHANDLE	2 

/*
2011-11-15 方建勋
1.	用httpdecode解悉输入参数;
2.	检测盟盟是否运行,没运行测运行盟盟程序,没有则运行;
3.	如果盟盟已经运行，向盟盟发送输入参数;
*/

/*
是直接将参数传递到盟盟,还是在转换格式化再传递呢?
*/

//窗体在生成5秒后关闭;因为无显示窗体,所以自动关闭.在交互动作完成后也调用关闭

//检查盟盟是否在运行
//返回值:0:未运行 1:运行中
int isMMRunning();
void fmtErrorMsg(int dwError);

UINT uiMMMsgId = 0;
//盟盟窗体句柄.用来向它发送数据
HWND	hwndMMWindow = 0;



CString trans2String(BYTE bval)
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

void OutputLogHex(byte* pBuff, int len)
{
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
		ATLTRACE("%s",sz1);
	}
}


int APIENTRY _tWinMain(HINSTANCE hInstance,
					   HINSTANCE hPrevInstance,
					   LPTSTR    lpCmdLine,
					   int       nCmdShow)
{

	ATLTRACE("_tWinMain.lpCmdLine=[%s]",lpCmdLine);
	list<string>szArgs;
	//解析参数.只能有两个参数.第一个参数为Exe,第二个参数为URL
	LPWSTR *szArglist;
	int nArgs;
	int i;

	USES_CONVERSION;
	
	szArglist = CommandLineToArgvW(GetCommandLineW(), &nArgs);
	if( NULL == szArglist )
	{
		ATLTRACE(L"CommandLineToArgvW failed");
		return 0;
	}
	else
	{
		if(nArgs == 1)
		{
			//
			ATLTRACE("没有参数.");
			return 0;
		}
		if(nArgs > 2)
		{
			ATLTRACE("参数太多.参数应该为两个");
			return 1;
		}

		string pp1 = string(CW2A(szArglist[0]));
		OutputLogHex((byte*)pp1.c_str(),pp1.size());
		pp1 = string(CW2A(szArglist[1]));
		OutputLogHex((byte*)pp1.c_str(),pp1.size());
		//exe路径
		szArgs.push_back(string(CW2A(szArglist[0])));
		//输入参数格式为mmping:// /
		CString szArg0;
		szArg0.Format("%s",CW2A(szArglist[1]));

		szArg0.Replace("mmping://","");
		szArg0.Replace("mmPing://","");
		
		/*
		//接收的字符串中间如果有 空格,则转换为+
		//如果有%20则替换为 
		szArg0.Replace("%20","+");
		//szArg0.Replace(" ","+");
		//Base64编码都是4的倍数.所以如果最后一个字符为/,且长度不为4的倍数,就应该去掉
		if(szArg0.GetLength()%4>0)
		{
			//去掉最后的"/"
			if(szArg0.Right(1)=="/")
			{
				szArg0=szArg0.Left(szArg0.GetLength() - 1);
			}
		}
		
		//进行base64解码,成为utf8,再转成wchar,再转成本地多字节字符
		int len = Base64::GetDecodeNewLen(szArg0.GetBuffer());
		char *pe = new char[len];
		::ZeroMemory(pe,len+1);
		Base64::Base64_Decode(szArg0.GetBuffer(),pe);

		int nChars = ::MultiByteToWideChar(CP_UTF8,0,pe,strlen(pe),0,0);
		printf("nChars=%d\n",nChars);
		wchar_t *pc = new wchar_t[nChars+1];
		::ZeroMemory(pc,sizeof(wchar_t)*(nChars+1));
		::MultiByteToWideChar(CP_UTF8,0,pe,strlen(pe),pc,nChars);
		printf("%S\n",pc);

		//转成多字节字符
		nChars = WideCharToMultiByte(CP_ACP, 0, pc, nChars, NULL, 0, NULL, NULL);
		char *ret = new char[nChars+1];
		::ZeroMemory(ret,nChars+1);
		WideCharToMultiByte(CP_ACP, 0, pc, nChars, ret, nChars, NULL, NULL);
		printf("ret=%s\n",ret);

		szArgs.push_back(string("-mmPing"));
		
		//解析后的参数szArg1,格式为以空格分割的字符串.
		CString szArg1;
		szArg1.Format("%s",ret);
		*/

		CString szArg1;
		szArg1.Format("%s",szArg0);

		int curPos = 0;
		CString strToken;
		
		strToken = szArg1.Tokenize(" ",curPos);
		while(strToken != "")
		{
			//把字符串加入列表
			szArgs.push_back(string(strToken));
			strToken = szArg1.Tokenize(" ",curPos);
		}		
	}

	ATLTRACE("CmdLine:%s",lpCmdLine);
	// Free memory allocated for CommandLineToArgvW arguments.
	LocalFree(szArglist);


	//首先检测盟盟是否运行了
	if(!isMMRunning())
	{
		//盟盟没有运行.在此打开盟盟程序,并把参数传过去
		//名字为d:\shop\r3.exe;与该Exe在同一个目录下
		string szR3Name((*szArgs.begin()).c_str());
		string szMpName = PathFindFileName((*szArgs.begin()).c_str());
		szR3Name.replace(szR3Name.rfind(szMpName),szMpName.size(),"Shop.exe");
		
		string szPath((*szArgs.begin()).c_str());
		szPath.replace(szPath.rfind(szMpName),szMpName.size(),"");
		//在这里启动进程Shop.Exe
		
		list<string>::const_iterator itr;
		for(itr=szArgs.begin(),i=0;itr!=szArgs.end();itr++)
		{
			ATLTRACE("%d: %s\n", i++,(*itr).c_str() );
		}
		//命令行
		char cmdLine[1024*16];
		::ZeroMemory(cmdLine,1024*16);
		strcpy(cmdLine,szR3Name.c_str());		

		
		for(itr=szArgs.begin(),itr++;itr!=szArgs.end();itr++)
		{
			strcat(cmdLine," ");
			strcat(cmdLine,(*itr).c_str());
		}

		//当前路径
		char currPath[MAX_PATH];
		::ZeroMemory(currPath,MAX_PATH);
		strcpy(currPath,szPath.c_str());

		PROCESS_INFORMATION  pi;
		::ZeroMemory(&pi,sizeof(pi));

		STARTUPINFO si;
		::ZeroMemory(&si,sizeof(si));
		
		ATLTRACE("CmdLine=%s",cmdLine);
		ATLTRACE("CurrPath=%s",currPath);

		BOOL blRtv = ::CreateProcess(NULL,cmdLine,NULL,NULL,FALSE,NORMAL_PRIORITY_CLASS,NULL,currPath,&si,&pi);
		if(blRtv)
		{
			//启动成功
			ATLTRACE("启动盟盟成功");
		}
		else
		{
			//启动失败
			ATLTRACE("启动盟盟失败.");
			::fmtErrorMsg(::GetLastError());
		}
		return 0;
	}


 	// TODO: 在此放置代码。
	MSG msg;
	HACCEL hAccelTable;

	// 初始化全局字符串
	LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
	LoadString(hInstance, IDC_MMPING2, szWindowClass, MAX_LOADSTRING);
	MyRegisterClass(hInstance);

	// 执行应用程序初始化:
	if (!InitInstance (hInstance, nCmdShow)) 
	{
		return FALSE;
	}

	hAccelTable = LoadAccelerators(hInstance, (LPCTSTR)IDC_MMPING2);

	// 主消息循环:
	while (GetMessage(&msg, NULL, 0, 0)) 
	{
		if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg)) 
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	return (int) msg.wParam;
}



//
//  函数: MyRegisterClass()
//
//  目的: 注册窗口类。
//
//  注释: 
//
//    仅当希望在已添加到 Windows 95 的
//    “RegisterClassEx”函数之前此代码与 Win32 系统兼容时，
//    才需要此函数及其用法。调用此函数
//    十分重要，这样应用程序就可以获得关联的
//   “格式正确的”小图标。
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
	WNDCLASSEX wcex;

	wcex.cbSize = sizeof(WNDCLASSEX); 

	wcex.style			= CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc	= (WNDPROC)WndProc;
	wcex.cbClsExtra		= 0;
	wcex.cbWndExtra		= 0;
	wcex.hInstance		= hInstance;
	wcex.hIcon			= LoadIcon(hInstance, (LPCTSTR)IDI_MMPING2);
	wcex.hCursor		= LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground	= (HBRUSH)(COLOR_WINDOW+1);
	wcex.lpszMenuName	= (LPCTSTR)IDC_MMPING2;
	wcex.lpszClassName	= szWindowClass;
	wcex.hIconSm		= LoadIcon(wcex.hInstance, (LPCTSTR)IDI_SMALL);

	return RegisterClassEx(&wcex);
}

//
//   函数: InitInstance(HANDLE, int)
//
//   目的: 保存实例句柄并创建主窗口
//
//   注释: 
//
//        在此函数中，我们在全局变量中保存实例句柄并
//        创建和显示主程序窗口。
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   HWND hWnd;

   hInst = hInstance; // 将实例句柄存储在全局变量中

   hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

   if (!hWnd)
   {
      return FALSE;
   }

   //隐藏主窗体
   ShowWindow(hWnd,/*nCmdShow*/ SW_HIDE);
   UpdateWindow(hWnd);

   //创建窗体关闭时钟

   ::SetTimer(hWnd,1,5000,NULL);
   //
   ATLTRACE("RegisterWindowMessage.%s",mmName.c_str());
   UINT uiRtv = RegisterWindowMessage(mmName.c_str());
   if(uiRtv == 0)
   {
	   ATLTRACE("注册消息失败");
	   ::fmtErrorMsg(::GetLastError());
	   return FALSE;
   }
   else
   {
	   ATLTRACE("注册消息成功");
	   uiMMMsgId = uiRtv;
   }

   DWORD dwRecipients = BSM_APPLICATIONS;
   long lv = BroadcastSystemMessage(BSF_IGNORECURRENTTASK|BSF_POSTMESSAGE,&dwRecipients,uiMMMsgId,MI_GETHANDLE,LPARAM(hWnd));
   if(lv > 0)
   {
		ATLTRACE("广播消息成功");
   }
   else
   {
	    ATLTRACE("广播消息失败");
   }
   return TRUE;
}

//
//  函数: WndProc(HWND, unsigned, WORD, LONG)
//
//  目的: 处理主窗口的消息。
//
//  WM_COMMAND	- 处理应用程序菜单
//  WM_PAINT	- 绘制主窗口
//  WM_DESTROY	- 发送退出消息并返回
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int wmId, wmEvent;
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message) 
	{
	case WM_COMMAND:
		wmId    = LOWORD(wParam); 
		wmEvent = HIWORD(wParam); 
		// 分析菜单选择:
		switch (wmId)
		{
		case IDM_EXIT:
			DestroyWindow(hWnd);
			break;
		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
		}
		break;
	case WM_PAINT:
		hdc = BeginPaint(hWnd, &ps);
		// TODO: 在此添加任意绘图代码...
		EndPaint(hWnd, &ps);
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_TIMER:
		KillTimer(hWnd,1);
		::PostQuitMessage(0);
		break;
	default:
		if(uiMMMsgId>0 && message == uiMMMsgId)
		{
			ATLTRACE("收到盟盟消息");
			if(wParam == MI_ACTIVEAPP)
			{
				//LPARAM为mm窗体句柄
				hwndMMWindow = (HWND)lParam;

				//在这里向hwndMMWindow发送消息
				COPYDATASTRUCT  data;
				::ZeroMemory(&data,sizeof(data));
				data.lpData = "good";
				data.dwData = NULL;
				data.cbData = 4;
				::SendMessage(hwndMMWindow,WM_COPYDATA,0,(LPARAM)&data);

				//收到消息后关闭窗体
				KillTimer(hWnd,1);
				::PostQuitMessage(0);
			}
		}
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

int isMMRunning()
{
	HANDLE hMutex = ::CreateMutex(NULL,FALSE,mmName.c_str());
	if(hMutex)
	{
		DWORD dwError = ::GetLastError();		
		if(dwError == ERROR_ALREADY_EXISTS)
		{
			ATLTRACE("盟盟已打开");
			::CloseHandle(hMutex);
			return 1;
		}
		else
		{	
			ATLTRACE("盟盟没有打开");
			fmtErrorMsg(dwError);
			::CloseHandle(hMutex);
			return 0;
		}
	}
	ATLTRACE("未知错误:检测Mutex失败.");
	DWORD dwError = ::GetLastError();
	fmtErrorMsg(dwError);
	return 0;
}

void fmtErrorMsg(int dwError)
{
	char *lpBuffer = NULL;
	//输出未知的出错信息
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_IGNORE_INSERTS|FORMAT_MESSAGE_FROM_SYSTEM,NULL,
dwError,LANG_NEUTRAL,(LPTSTR) & lpBuffer, 0 ,NULL );
	if(lpBuffer == NULL)
	{
		ATLTRACE("信息:code=%d",dwError);
	}
	else
	{
		ATLTRACE("信息:%s",lpBuffer);
		::LocalFree(lpBuffer);
	}
}

