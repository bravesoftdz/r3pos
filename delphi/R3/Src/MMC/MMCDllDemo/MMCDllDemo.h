// MMCDllDemo.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CMMCDllDemoApp:
// �йش����ʵ�֣������ MMCDllDemo.cpp
//

class CMMCDllDemoApp : public CWinApp
{
public:
	CMMCDllDemoApp();

// ��д
	public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CMMCDllDemoApp theApp;