// MMC.h : MMC DLL ����ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������
#include "ClientSocket.h"

// CMMCApp
// �йش���ʵ�ֵ���Ϣ������� MMC.cpp
//

class CMMCApp : public CWinApp
{
public:
	CMMCApp();

	


// ��д
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
	virtual int ExitInstance();
};
