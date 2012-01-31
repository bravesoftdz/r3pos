// MMCDllDemoDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "MMCDllDemo.h"
#include "MMCDllDemoDlg.h"
#include "DS.h"
#include  "glog.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif

typedef int (WINAPI *SetDataCalBack)(int func);
typedef int (WINAPI *SetEventCalBack)(int func);
typedef int (WINAPI *ConnectFunc)(const char* ipAddr,int nPort);
typedef int (WINAPI *GetSockStatusFunc)();
typedef int (WINAPI *SetSockCloseFunc)();
typedef int (WINAPI *SendFunc)(int flag,void * Pin);
typedef int (WINAPI *SendSyncFunc)(int flag,void * Pin);
typedef const char* (WINAPI *GetErrorFunc)(int nError);


//typedef const char* (WINAPI *GetErrorFunc)(int nError);



HINSTANCE hDll; //DLL句柄 

int getdesp(int i)
{

	GetErrorFunc pShowDlg = (GetErrorFunc)GetProcAddress(hDll,"GetDescriptionFromErrorID");

	if (NULL==pShowDlg)

	{

		AfxMessageBox((LPCTSTR)"DLL中函数GetDescriptionFromErrorID寻找失败"); 

	}

	//pShowDlg();





	const char* retConnect=pShowDlg(i);
	AfxMessageBox(retConnect);
	return i;
	//const char* retConnect1=pShowDlg(10035);
}


LPSTR ConvertErrorCodeToString(DWORD ErrorCode)
{
	HLOCAL LocalAddress=NULL;
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_IGNORE_INSERTS|FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,ErrorCode,0,(PTSTR)&LocalAddress,0,NULL);
	return (LPSTR)LocalAddress;
}


void ConvertGBKToUtf8(CString& strGBK)
{
	int len=MultiByteToWideChar(CP_ACP, 0, (LPCTSTR)strGBK, -1, NULL,0);
	unsigned short * wszUtf8 = new unsigned short[len+1];
	memset(wszUtf8, 0, len * 2 + 2);
	MultiByteToWideChar(CP_ACP, 0, (LPCTSTR)strGBK, -1,(LPWSTR) wszUtf8, len);

	len = WideCharToMultiByte(CP_UTF8, 0,(LPCWSTR) wszUtf8, -1, NULL, 0, NULL, NULL);
	char *szUtf8=new char[len + 1];
	memset(szUtf8, 0, len + 1);
	WideCharToMultiByte (CP_UTF8, 0,(LPCWSTR) wszUtf8, -1, szUtf8, len, NULL,NULL);

	strGBK = szUtf8;
	delete[] szUtf8;
	delete[] wszUtf8;
}


void ErrorExit(int i) 
{ 
	TCHAR szBuf[80]; 
	LPVOID lpMsgBuf;
	DWORD dw = i; 

	FormatMessage(
		FORMAT_MESSAGE_ALLOCATE_BUFFER | 
		FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,
		dw,
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
		(LPTSTR) &lpMsgBuf,
		0, NULL );

	//wsprintf(szBuf, 
	//	"%s failed with error %d: %s", 
	//	lpszFunction, dw, lpMsgBuf); 

	MessageBox(NULL, szBuf, _T("Error"), MB_OK); 

	LocalFree(lpMsgBuf);
	//ExitProcess(dw); 
}

const char * GetErrorMessage(int i)
{
	GetErrorFunc pShowDlg = (GetErrorFunc)GetProcAddress(hDll,"GetDescriptionFromErrorID");

	if (NULL==pShowDlg)

	{

		AfxMessageBox((LPCTSTR)"DLL中函数GetDescriptionFromErrorID寻找失败"); 

	}
	return pShowDlg(i);

}

int WINAPI EventCallBack(int mevent,int flag,void* pin)
{
	//MessageBox()
	TRACE("收到事件 event : %d",mevent);
return 0;


}
int WINAPI DataCallBack(int flag,void* pin)
{

	if (flag==1010)
	{
		/*PlayerIdListFava* lp=new PlayerIdListFava();
		lp->messageType=((PlayerIdListFava*)pin)->messageType;
		lp->routeType=((PlayerIdListFava*)pin)->routeType;
		lp->ListLen=((PlayerIdListFava*)pin)->ListLen;
		strcpy(lp->comId,((PlayerIdListFava*)pin)->comId);
		char** p=new char*[3];
		memset(p,0x00,12);
			p=(char**)((PlayerIdListFava*)pin)->playerIdArray;
			char pchar1[256];
			memset(pchar1,0x00,256);
			strcpy(pchar1,p[0]);
			char  pchar2[256];
			memset(pchar2,0x00,256);
			strcpy(pchar2,p[1]);
			char  pchar3[256];
			memset(pchar3,0x00,256);
			strcpy(pchar3,p[2]);
			int i=0;*/

	}
	gLog.output("Demo收到个");

return 0;

}
// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CMMCDllDemoDlg 对话框




CMMCDllDemoDlg::CMMCDllDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMMCDllDemoDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMMCDllDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CMMCDllDemoDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDOK, &CMMCDllDemoDlg::OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON1, &CMMCDllDemoDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CMMCDllDemoDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, &CMMCDllDemoDlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, &CMMCDllDemoDlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &CMMCDllDemoDlg::OnBnClickedButton5)
	ON_BN_CLICKED(IDCANCEL, &CMMCDllDemoDlg::OnBnClickedCancel)
	ON_BN_CLICKED(IDC_BUTTON6, &CMMCDllDemoDlg::OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON7, &CMMCDllDemoDlg::OnBnClickedButton7)
	ON_BN_CLICKED(IDC_BUTTON8, &CMMCDllDemoDlg::OnBnClickedButton8)
	ON_BN_CLICKED(IDC_BUTTON9, &CMMCDllDemoDlg::OnBnClickedButton9)
	ON_BN_CLICKED(IDC_BUTTON10, &CMMCDllDemoDlg::OnBnClickedButton10)
END_MESSAGE_MAP()


// CMMCDllDemoDlg 消息处理程序

BOOL CMMCDllDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	//////////////////////////////



	/////////////////////////

	::CoInitialize(NULL);

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CMMCDllDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CMMCDllDemoDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CMMCDllDemoDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CMMCDllDemoDlg::OnBnClickedOk()
{
	FreeLibrary(hDll);
	// TODO: 在此添加控件通知处理程序代码
	OnOK();
}

void CMMCDllDemoDlg::OnBnClickedButton1()
{
	hDll = LoadLibrary(_T(".\\MMC.dll"));

	if (NULL==hDll)

	{

		MessageBox((LPCTSTR)"DLL加载失败");

	}
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton2()
{

	SetDataCalBack pShowDlg = (SetDataCalBack)GetProcAddress(hDll,"SetDataCallBack");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数SetDataCallBack寻找失败"); 

	}

	//pShowDlg();





	pShowDlg((int)DataCallBack);

	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton3()
{
	SetEventCalBack pShowDlg = (SetEventCalBack)GetProcAddress(hDll,"SetEventCallBack");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数SetEventCallBack寻找失败"); 

	}

	//pShowDlg();





	pShowDlg((int)EventCallBack);
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton4()
{
	ConnectFunc pShowDlg = (ConnectFunc)GetProcAddress(hDll,"Connect");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数ConnectFunc寻找失败"); 

	}

	//pShowDlg();





	int retConnect=pShowDlg("202.103.239.141",9085);
	getdesp(retConnect);
	//LPSTR lp=ConvertErrorCodeToString(retConnect);
	//AfxMessageBox(GetErrorMessage(retConnect));
	//delete pShowDlg;
	
	//gLog.output("connect return;%d" ,retConnect);
	//ErrorExit(retConnect);
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton5()
{

	ConnectFava *p=new ConnectFava();

	//strcpy(p->encodingData,"3a5e673872a63acb0c48cce5f269b92d45d0e49f85272386e141cc08f49679dc071a6d4390f09d8b442561cb23e61b7b6330bf1c19b5d8728cadf0f8ba695a035017a73e52b6c8ebb9c32d421956a245a7edd9f8bfb031a957ab6f23533c11b2438ab6b565946bab8ad5a34d7896b8812d49fdded38b4a6bcb320d5fcbd64968");
	//strcpy(p->encodingData,"abcde");
	//CString ls="ZHAOYAN赵燕1000112102010114210213210042大连市烟草公司02大连市110000011316333508312";
	strcpy(p->encodingData,"aa2e118116dc698193fdaf8cd9fc961bc07c69b77af7471e1c59551f71920662b74b7536d1c61c634dc5729c672ab8d0207f166ce4424c068e74db9b388615aaf9019e8af0ca89becf0b53a124a6f85d1fdaa19e23da5c1d029ca7439eb03f7f77f8c84ad99653f23441a3fa804d15232c10be5c32d03ec14b502ae6b8003f29");
	CString ls="ZHANGTIANNEO22101121020111210200210213210042大连市烟草公司02大连市110000011316580991265";
	
	//ConvertGBKToUtf8( ls);

	strcpy(p->planText,(const char*)ls);
	p->messageType=1000;
	p->routeType=1;
    strcpy(p->playerId,"");
	strcpy(p->status,"");




	SendSyncFunc pShowDlg = (SendSyncFunc)GetProcAddress(hDll,"SendSync");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数SendSync寻找失败"); 

	}

	//pShowDlg();





	int retConnect=pShowDlg(1000,p);
	//AfxMessageBox(GetErrorMessage(retConnect));
	CString lsp;
	lsp.Format("%d",retConnect);
	//AfxMessageBox(lsp);
	delete p;



	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedCancel()
{
	FreeLibrary(hDll);
	// TODO: 在此添加控件通知处理程序代码
	OnCancel();
}

void CMMCDllDemoDlg::OnBnClickedButton6()
{

	SetSockCloseFunc pShowDlg = (SetSockCloseFunc)GetProcAddress(hDll,"SetSockClose");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数SetSockClose寻找失败"); 

	}

	//pShowDlg();





	int retConnect=pShowDlg();
	//AfxMessageBox(GetErrorMessage(retConnect));
	//LPSTR lp=ConvertErrorCodeToString(retConnect);
	//AfxMessageBox(lp);

	// TODO: 在此添加控件通知处理程序代码
}


void CMMCDllDemoDlg::OnBnClickedButton7()
{

	GetErrorFunc pShowDlg = (GetErrorFunc)GetProcAddress(hDll,"GetDescriptionFromErrorID");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数GetDescriptionFromErrorID寻找失败"); 

	}

	//pShowDlg();





	const char* retConnect=pShowDlg(30002);
	const char* retConnect1=pShowDlg(10035);
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton8()
{
	//playerIDlistfava

		SendFunc pShowDlg = (SendFunc)GetProcAddress(hDll,"Send");

	if (NULL==pShowDlg)

	{

		MessageBox((LPCTSTR)"DLL中函数Send寻找失败"); 

	}

	//pShowDlg();

PlayerIdListFava *p=new PlayerIdListFava();
strcpy(p->comId,"11210201");
p->ListLen=0;
p->messageType=1010;
p->routeType=1;
int ret=pShowDlg(1010,p);
//AfxMessageBox(GetErrorMessage(ret));

delete (PlayerIdListFava*)p;



//	const char* retConnect=pShowDlg(30001);
//	const char* retConnect1=pShowDlg(10035);
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton9()
{
	
	// TODO: 在此添加控件通知处理程序代码
}

void CMMCDllDemoDlg::OnBnClickedButton10()
{
	hDll = LoadLibrary(_T(".\\MMC.dll"));
	if (NULL==hDll)
	{
		MessageBox((LPCTSTR)"DLL加载失败");
	}

	OnBnClickedButton2();
	OnBnClickedButton3();

	//closesocket
	OnBnClickedButton6();
	//connect
	OnBnClickedButton4();
	//fava
	OnBnClickedButton5();
	OnBnClickedButton8();
	FreeLibrary(hDll);
}
