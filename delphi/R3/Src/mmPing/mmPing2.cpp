// mmPing2.cpp : ����Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include "mmPing2.h"
#include "base64.h"

#define MAX_LOADSTRING 100

// ȫ�ֱ���:
HINSTANCE hInst;								// ��ǰʵ��
TCHAR szTitle[MAX_LOADSTRING];					// �������ı�
TCHAR szWindowClass[MAX_LOADSTRING];			// ����������

// �˴���ģ���а����ĺ�����ǰ������:
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);

const string mmName = "{FA49A7C5-1A5F-4461-8E0D-65DE9E9D2D0A}";

#define MI_ACTIVEAPP	1  
#define MI_GETHANDLE	2 

/*
2011-11-15 ����ѫ
1.	��httpdecode��Ϥ�������;
2.	��������Ƿ�����,û���в��������˳���,û��������;
3.	��������Ѿ����У������˷����������;
*/

/*
��ֱ�ӽ��������ݵ�����,������ת����ʽ���ٴ�����?
*/

//����������5���ر�;��Ϊ����ʾ����,�����Զ��ر�.�ڽ���������ɺ�Ҳ���ùر�

//��������Ƿ�������
//����ֵ:0:δ���� 1:������
int isMMRunning();
void fmtErrorMsg(int dwError);

UINT uiMMMsgId = 0;
//���˴�����.����������������
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
	//ÿ�� 16���ַ�
	int cols = 16;
	int rows = (len / cols) + ((len %cols)>0?1:0);	

	for(int i=0;i<rows;i++)
	{
		//����к�
		CString sz1,sz2;
		sz1.Format("%08XH: ",i*cols);
		for(int j=0;j<cols;j++)
		{
			if(i*cols+j<len)
			{
				//�������
				sz2.Format("%02X(%s) ",(BYTE)pBuff[i*cols+j],trans2String((BYTE)pBuff[i*cols+j]));
				sz1+=sz2;
			}
		}
		//���������
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
	//��������.ֻ������������.��һ������ΪExe,�ڶ�������ΪURL
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
			ATLTRACE("û�в���.");
			return 0;
		}
		if(nArgs > 2)
		{
			ATLTRACE("����̫��.����Ӧ��Ϊ����");
			return 1;
		}

		string pp1 = string(CW2A(szArglist[0]));
		OutputLogHex((byte*)pp1.c_str(),pp1.size());
		pp1 = string(CW2A(szArglist[1]));
		OutputLogHex((byte*)pp1.c_str(),pp1.size());
		//exe·��
		szArgs.push_back(string(CW2A(szArglist[0])));
		//���������ʽΪmmping:// /
		CString szArg0;
		szArg0.Format("%s",CW2A(szArglist[1]));

		szArg0.Replace("mmping://","");
		szArg0.Replace("mmPing://","");
		
		/*
		//���յ��ַ����м������ �ո�,��ת��Ϊ+
		//�����%20���滻Ϊ 
		szArg0.Replace("%20","+");
		//szArg0.Replace(" ","+");
		//Base64���붼��4�ı���.����������һ���ַ�Ϊ/,�ҳ��Ȳ�Ϊ4�ı���,��Ӧ��ȥ��
		if(szArg0.GetLength()%4>0)
		{
			//ȥ������"/"
			if(szArg0.Right(1)=="/")
			{
				szArg0=szArg0.Left(szArg0.GetLength() - 1);
			}
		}
		
		//����base64����,��Ϊutf8,��ת��wchar,��ת�ɱ��ض��ֽ��ַ�
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

		//ת�ɶ��ֽ��ַ�
		nChars = WideCharToMultiByte(CP_ACP, 0, pc, nChars, NULL, 0, NULL, NULL);
		char *ret = new char[nChars+1];
		::ZeroMemory(ret,nChars+1);
		WideCharToMultiByte(CP_ACP, 0, pc, nChars, ret, nChars, NULL, NULL);
		printf("ret=%s\n",ret);

		szArgs.push_back(string("-mmPing"));
		
		//������Ĳ���szArg1,��ʽΪ�Կո�ָ���ַ���.
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
			//���ַ��������б�
			szArgs.push_back(string(strToken));
			strToken = szArg1.Tokenize(" ",curPos);
		}		
	}

	ATLTRACE("CmdLine:%s",lpCmdLine);
	// Free memory allocated for CommandLineToArgvW arguments.
	LocalFree(szArglist);


	//���ȼ�������Ƿ�������
	if(!isMMRunning())
	{
		//����û������.�ڴ˴����˳���,���Ѳ�������ȥ
		//����Ϊd:\shop\r3.exe;���Exe��ͬһ��Ŀ¼��
		string szR3Name((*szArgs.begin()).c_str());
		string szMpName = PathFindFileName((*szArgs.begin()).c_str());
		szR3Name.replace(szR3Name.rfind(szMpName),szMpName.size(),"Shop.exe");
		
		string szPath((*szArgs.begin()).c_str());
		szPath.replace(szPath.rfind(szMpName),szMpName.size(),"");
		//��������������Shop.Exe
		
		list<string>::const_iterator itr;
		for(itr=szArgs.begin(),i=0;itr!=szArgs.end();itr++)
		{
			ATLTRACE("%d: %s\n", i++,(*itr).c_str() );
		}
		//������
		char cmdLine[1024*16];
		::ZeroMemory(cmdLine,1024*16);
		strcpy(cmdLine,szR3Name.c_str());		

		
		for(itr=szArgs.begin(),itr++;itr!=szArgs.end();itr++)
		{
			strcat(cmdLine," ");
			strcat(cmdLine,(*itr).c_str());
		}

		//��ǰ·��
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
			//�����ɹ�
			ATLTRACE("�������˳ɹ�");
		}
		else
		{
			//����ʧ��
			ATLTRACE("��������ʧ��.");
			::fmtErrorMsg(::GetLastError());
		}
		return 0;
	}


 	// TODO: �ڴ˷��ô��롣
	MSG msg;
	HACCEL hAccelTable;

	// ��ʼ��ȫ���ַ���
	LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
	LoadString(hInstance, IDC_MMPING2, szWindowClass, MAX_LOADSTRING);
	MyRegisterClass(hInstance);

	// ִ��Ӧ�ó����ʼ��:
	if (!InitInstance (hInstance, nCmdShow)) 
	{
		return FALSE;
	}

	hAccelTable = LoadAccelerators(hInstance, (LPCTSTR)IDC_MMPING2);

	// ����Ϣѭ��:
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
//  ����: MyRegisterClass()
//
//  Ŀ��: ע�ᴰ���ࡣ
//
//  ע��: 
//
//    ����ϣ��������ӵ� Windows 95 ��
//    ��RegisterClassEx������֮ǰ�˴����� Win32 ϵͳ����ʱ��
//    ����Ҫ�˺��������÷������ô˺���
//    ʮ����Ҫ������Ӧ�ó���Ϳ��Ի�ù�����
//   ����ʽ��ȷ�ġ�Сͼ�ꡣ
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
//   ����: InitInstance(HANDLE, int)
//
//   Ŀ��: ����ʵ�����������������
//
//   ע��: 
//
//        �ڴ˺����У�������ȫ�ֱ����б���ʵ�������
//        ��������ʾ�����򴰿ڡ�
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   HWND hWnd;

   hInst = hInstance; // ��ʵ������洢��ȫ�ֱ�����

   hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

   if (!hWnd)
   {
      return FALSE;
   }

   //����������
   ShowWindow(hWnd,/*nCmdShow*/ SW_HIDE);
   UpdateWindow(hWnd);

   //��������ر�ʱ��

   ::SetTimer(hWnd,1,5000,NULL);
   //
   ATLTRACE("RegisterWindowMessage.%s",mmName.c_str());
   UINT uiRtv = RegisterWindowMessage(mmName.c_str());
   if(uiRtv == 0)
   {
	   ATLTRACE("ע����Ϣʧ��");
	   ::fmtErrorMsg(::GetLastError());
	   return FALSE;
   }
   else
   {
	   ATLTRACE("ע����Ϣ�ɹ�");
	   uiMMMsgId = uiRtv;
   }

   DWORD dwRecipients = BSM_APPLICATIONS;
   long lv = BroadcastSystemMessage(BSF_IGNORECURRENTTASK|BSF_POSTMESSAGE,&dwRecipients,uiMMMsgId,MI_GETHANDLE,LPARAM(hWnd));
   if(lv > 0)
   {
		ATLTRACE("�㲥��Ϣ�ɹ�");
   }
   else
   {
	    ATLTRACE("�㲥��Ϣʧ��");
   }
   return TRUE;
}

//
//  ����: WndProc(HWND, unsigned, WORD, LONG)
//
//  Ŀ��: ���������ڵ���Ϣ��
//
//  WM_COMMAND	- ����Ӧ�ó���˵�
//  WM_PAINT	- ����������
//  WM_DESTROY	- �����˳���Ϣ������
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
		// �����˵�ѡ��:
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
		// TODO: �ڴ���������ͼ����...
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
			ATLTRACE("�յ�������Ϣ");
			if(wParam == MI_ACTIVEAPP)
			{
				//LPARAMΪmm������
				hwndMMWindow = (HWND)lParam;

				//��������hwndMMWindow������Ϣ
				COPYDATASTRUCT  data;
				::ZeroMemory(&data,sizeof(data));
				data.lpData = "good";
				data.dwData = NULL;
				data.cbData = 4;
				::SendMessage(hwndMMWindow,WM_COPYDATA,0,(LPARAM)&data);

				//�յ���Ϣ��رմ���
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
			ATLTRACE("�����Ѵ�");
			::CloseHandle(hMutex);
			return 1;
		}
		else
		{	
			ATLTRACE("����û�д�");
			fmtErrorMsg(dwError);
			::CloseHandle(hMutex);
			return 0;
		}
	}
	ATLTRACE("δ֪����:���Mutexʧ��.");
	DWORD dwError = ::GetLastError();
	fmtErrorMsg(dwError);
	return 0;
}

void fmtErrorMsg(int dwError)
{
	char *lpBuffer = NULL;
	//���δ֪�ĳ�����Ϣ
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_IGNORE_INSERTS|FORMAT_MESSAGE_FROM_SYSTEM,NULL,
dwError,LANG_NEUTRAL,(LPTSTR) & lpBuffer, 0 ,NULL );
	if(lpBuffer == NULL)
	{
		ATLTRACE("��Ϣ:code=%d",dwError);
	}
	else
	{
		ATLTRACE("��Ϣ:%s",lpBuffer);
		::LocalFree(lpBuffer);
	}
}

