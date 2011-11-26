{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uParamsFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TParamsSyncFactory=class(TRimSyncFactory)
  private
    procedure WriteDownLoadToReportLog(LogMsg: string); //下载参数写日志
    //从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]
    function  DownRimParamsToR3: Boolean;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TParamsSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
begin
  result:=-1;
  PlugInID:='1006';
  //2011.11.26日定义插件不执行参数
  PlugInIdx:=8;
  if not GetPlugInRunFlag then //插件定义执行
  begin
    result:=0;
    Exit;
  end;

  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记

  //2011.06.12 Add从Rim下载销售限价、限量定义参数值
  DownRimParamsToR3;
  result:=1;
end;

//从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]  Rim的单位：条，R3单位：盒，默认关系为:10;
function TParamsSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //门店上报更新
  Str,COM_ID,CHANGE_PRICE,CHGCnd: string;
begin
  Str:='';
  UpCnd:='';
  CustCnd:='';
  COM_ID:=GetRimCOM_ID(trim(Params.ParamByName('TENANT_ID').AsString));

  if SyncType=3 then //门店同步[只同步本门店]
  begin
    CustCnd:=' and C.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and C.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
    UpCnd:=' and A.RELATI_ID='+Params.ParamByName('TENANT_ID').AsString+' ';
  end else
    UpCnd:=' and A.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  {Rim:1:接受     0:不接受  R3: 1:企业变价 2: 统一定价 }
  case DbType of
   1: CHANGE_PRICE:='DECODE(IS_CHG_PRI,''0'',''2'',''1'')';
   4: CHANGE_PRICE:='(case when IS_CHG_PRI=''0'' then ''2'' else ''1'' end)';
  end;
  CHGCnd:=ParseSQL(DbType,'(nvl(A.SINGLE_LIMIT,0)<>nvl(B.single_sale_limit,0)*10.0)or(nvl(A.SALE_LIMIT,0)<>nvl(B.sale_limit,0)*10.0)or(A.CHANGE_PRICE<>'+CHANGE_PRICE+')');
  Str:=
    'update CA_RELATIONS A '+
    ' set (SINGLE_LIMIT,SALE_LIMIT,CHANGE_PRICE,TIME_STAMP)='+
        '(select distinct single_sale_limit*10.0,sale_limit*10.0,'+CHANGE_PRICE+' as IS_CHG_PRI,'+GetTimeStamp(DbType)+' as TIME_STAMP '+
        ' from RM_CUST B,CA_SHOP_INFO C '+
        ' where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+')) '+
    ' where A.RELATION_STATUS=''2'' and A.RELATION_ID='+InttoStr(NT_RELATION_ID)+' '+UpCnd+
    ' and exists(select 1 from RM_CUST B,CA_SHOP_INFO C where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+'))';

  try
    BeginLogReport; //开始上报日志
    try
      if COM_ID<>'' then
      begin
        IsRun:=ExecTransSQL(Str,iRet,'下载Rim零售户限价限量出错：');
        if IsRun and (SyncType<>3) then //批量才写日志
        begin
          FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //总执行多少秒
          Msg:='---- RSP调度【Rim零售户限价量参数】 同步：'+InttoStr(iRet)+'笔，运行'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'秒-------';
        end;
      end else
      begin
        if SyncType<>3 then Msg:='---- RSP调度【Rim零售户限价量参数】 出错: 没找到对应Rim.COM_ID！-------'; //写入[REPORT]
        WriteLogFile('<Rim零售户限价量参数> 出错: 没找到对应Rim.COM_ID！'); 
      end;
    except
      on E:Exception do
      begin
        Msg:='---- RSP调度【Rim零售户限价量参数】 同步出错（'+E.Message+'）！-------';
        WriteLogFile(Msg);
      end;    
    end;
  finally
    WriteDownLoadToReportLog(Msg); //写入REPORT文件
  end;
end;

procedure TParamsSyncFactory.WriteDownLoadToReportLog(LogMsg: string);
var
  LogFile: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //前台执行不写日志
  try
    LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
    LogFileList:=TStringList.Create;
    if FileExists(LogFile) then
    begin
      LogFileList.LoadFromFile(LogFile);
      LogFileList.Add('    ');
    end;
    LogFileList.Add(LogMsg);
    LogFileList.SaveToFile(LogFile);
  finally
    LogFileList.Free;
  end;
end;

end.















