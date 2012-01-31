
//#define LCCONTROLDLL_API __declspec(dllexport)
#define LCCONTROLDLL_API extern "C" _declspec(dllexport)


//创建LocalConnection.
//参数:连接名称.
//返回值:0:成功 1:创建工作线程失败 2:已存在同名的LC  3:其他为未知异常
LCCONTROLDLL_API int __stdcall LC_Create(char*szName);

//关闭LocalConnection
//参数:连接名称
//返回值:0:没有找到 1:找到了并取消注册成功 ;  其他为异常或失败
LCCONTROLDLL_API int __stdcall LC_Close(char* szName);

//向某个LC发送1个参数的方法调用
//参数:连接名称,方法名,参数1
//返回值:0:发送成功 1:获取Mutex失败 2:等待4秒仍没等到操作区 3:没有找到这个LC  4:数据区有没有使用的数据,强制写入数据 其他为捕获异常
LCCONTROLDLL_API int __stdcall LC_Send(char *szName,char *szMethod,char *para1);

//向某个LC发送2个参数的方法调用
//参数:连接名称,方法名,参数1,参数2
//返回值:0:发送成功 1:获取Mutex失败 2:等待4秒仍没等到操作区 3:没有找到这个LC  4:数据区有没有使用的数据,强制写入数据 其他为捕获异常
LCCONTROLDLL_API int __stdcall LC_Send2(char *szName,char *szMethod,char *para1,char *para2);

//向某个LC发送3个参数的方法调用
//参数:连接名称,方法名,参数1,参数2,参数3:
//返回值:0:发送成功 1:获取Mutex失败 2:等待4秒仍没等到操作区 3:没有找到这个LC  4:数据区有没有使用的数据,强制写入数据 其他为捕获异常
LCCONTROLDLL_API int __stdcall LC_Send3(char *szName,char *szMethod,char *para1,char *para2,char *para3);

//关闭工作线程
LCCONTROLDLL_API void __stdcall LC_FreeLibrary();

//注册一个方法及其回调函数
LCCONTROLDLL_API int __stdcall LC_MethodRegister(char *szLcName,char*szMethodName,int funcCallBack);

//支持string和bytearray等数据的接口
LCCONTROLDLL_API int __stdcall LC_NSend(char *szName,char *szMethod,int vt,void *pData,int len);

