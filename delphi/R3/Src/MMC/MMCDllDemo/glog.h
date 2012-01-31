
#ifndef _GLOG_STRUCT_
#define _GLOG_STRUCT_

#include <atlbase.h>
#include <atlfile.h>
#include <atltime.h>


static struct GLogStruct
{
public:
	CAtlFile  glbLogFile;
	GLogStruct()
	{
		try
		{		

			if (glbLogFile.m_h!=NULL)
				return;
		//	CreateDirectory(_T(".\\inspurLogs\\"),NULL);
		//	char fileName[256],dt[16];
		//	memset(fileName,0x00,sizeof(fileName));
		//	_strdate(dt);
		//	int pos=0;
		//	pos=strcspn(dt,"/");
		//	dt[pos]='_';
		//	pos=strcspn(dt,"/");
		//	dt[pos]='_';

		//	char buff[256];
		//::GetCurrentDirectory(255,buff);
		//TRACE("250:%s",buff);
		//CString str_filename;
  //      str_filename.Format("\\inspurLogs\\splog-%s.log",dt);
		//str_filename=(CString)buff+str_filename;
		//	//sprintf(fileName,".\\Logs\\springlet2-%s.log",dt);
		//strcpy(fileName,str_filename.GetBuffer());
		//	file=fopen(fileName,"a+");


			
			TCHAR szTempName[MAX_PATH];
			GetTempPath(MAX_PATH-1,szTempName);

			CString szPath;

			//打开日志文件
			TCHAR fileName[MAX_PATH];
			memset(fileName,0x00,sizeof(fileName));

			ATL::CTime tm = CTime::GetCurrentTime();	
			static int idx = 0;
			_stprintf(fileName,_T("%sMMC_%s_%d_%d.log"),szTempName,tm.Format(_T("%Y%m%d-%H%M%S")),::GetCurrentProcessId(),idx++);

            
			HRESULT hr = glbLogFile.Create(fileName,GENERIC_WRITE|GENERIC_READ,FILE_SHARE_READ,OPEN_ALWAYS);
			if(hr == S_OK)
			{

				//glbLogFile.Close();
			}
			else
			{

			}


		}
		catch(...)
		{

		}
		//保存当前路径，避免意外修改
		
		//char buff[256];
		//::GetCurrentDirectory(255,buff);
		//m_szCurrentDir=buff;

	}

	~GLogStruct()
	{
		try
		{
			glbLogFile.Close();
		}
		catch (...)
		{
		}
	}

	void output(char *info,...)
	{
///////////////////////////////////////
		int len;
		char *buffer;
		va_list args;

		//try
		//{
			va_start(args,info);
			len = _vscprintf(info,args)+1;
			buffer = (char*)malloc(len*sizeof(TCHAR));
			vsprintf(buffer,info,args);

		//	char dt[16],tm[16];
		//	_strdate(dt);
		//	_strtime(tm);
		//	CString szBuff;
		//	szBuff.Format(_T("%S %S:[%d]:[%S] \r\n"),dt,tm,::GetCurrentThreadId(),buffer);

		//	TRACE("%s",szBuff);
		//	//fprintf(file,szBuff.GetBuffer());
		//	glbLogFile.Write(szBuff.GetBuffer(),sizeof(TCHAR)*szBuff.GetLength());
		//	
		//	free(buffer);
		//}
		//catch (...)
		//{
		//}
/////////////////////////////////////////


		char buff[4096];
		::ZeroMemory(buff,sizeof(buff));

		CTime now = CTime::GetCurrentTime();
		char rt[3]={0x0D,0x0A,0x00};
		sprintf(buff,"[[%08d]%02d:%02d:%02d][%s]%s",::GetCurrentThreadId(),now.GetHour(),now.GetMinute(),now.GetSecond(),buffer,rt);
		try
		{
			glbLogFile.Write(buff,(DWORD)strlen(buff));
		}
		catch(...)
		{
			OutputDebugString("输出日志到文件出错");
		}


delete[] buffer;

		//fflush(file);
		glbLogFile.Flush();
	}

	FILE *file;
}gLog;

#endif //_GLOG_STRUCT_