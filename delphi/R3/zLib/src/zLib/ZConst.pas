//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZConst;

interface
resourcestring
  SIdInvalidToken = '接受无效的Token:%d';
  SIdInvalidConnectionString = '无效连接字符串:%s';
  SIdInvalidSocketConnection = ' 无效的 Socket 连接';
  SIdInvalidConnectID = '无效连接ID号:%d';
  SIdInvalidServerGuid = '没有注册的COM组件 CLSID:%s';
  SIdInvalidFlags = '无效的 Flags:%d';

  SIdInvalidDataSet = '不支持数据集类型';

  SIdInvalidDataBaseType = '不支持的数据库类型';
  SIdInvalidDataBlock = '无效的DataBlock数据nil';
  SIdInitADOError = '初始化 ADO 属性错误';
  SIdNotSupportFunction = '%s 不支持方法';
  SIdNotSupportObjectClassType = '%s 不支持的ObjectFactoryClassType';
  SIdParameterNotNull = '%s 参数不能是null';
  SIdInvalidParameterType = '%s 不支持的参数数值类型';
  SIdParameterNotfound = '%s 参数没有被找到';

  SIdDataSetNotNull = '%s对象的DataSet属性不能为nil';
  SIdNotSupportCombinationType = '%s 不支持的DataSet类型组合';

  SIdObjectNotRegistry = '%s 对象没有被注册';
  SIdQuarrelWith = '服务器拒绝接纳%s服务';
  SIdVssCheckedInvalid = '无法通过服务端的VSS安全认证.';

  SIdUndefinedError= '未定义的错误类型';
  SIdDisconnection = '程序已经断开跟服务器连接,请检查网络是否正常或人为中断';

  SIdNotAffectRecord = '更新记录数为零,是否被另一用户更改';
  SIdCheckValidityError = '执行%s检测对象合法性错误';
  SIdObjectTypeDiffer = '客户端跟服务端组合类型不一至';
  SIdNotAccessCloseDataSet = '不能操作关闭的数据集。';
  SIdParamterParseError = '参数解悉错误';

  SIdSessionNotFound = '没找到连接Session';
  SIdSessionMaxCount = '最大许可用户数为%d,增加许可用户数请和供应商联系';
implementation

end.
