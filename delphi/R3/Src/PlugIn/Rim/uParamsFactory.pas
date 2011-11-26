{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uParamsFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TParamsSyncFactory=class(TRimSyncFactory)
  private
    procedure WriteDownLoadToReportLog(LogMsg: string); //���ز���д��־
    //��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]
    function  DownRimParamsToR3: Boolean;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
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
  //2011.11.26�ն�������ִ�в���
  PlugInIdx:=8;
  if not GetPlugInRunFlag then //�������ִ��
  begin
    result:=0;
    Exit;
  end;

  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��

  //2011.06.12 Add��Rim���������޼ۡ������������ֵ
  DownRimParamsToR3;
  result:=1;
end;

//��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]  Rim�ĵ�λ������R3��λ���У�Ĭ�Ϲ�ϵΪ:10;
function TParamsSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //�ŵ��ϱ�����
  Str,COM_ID,CHANGE_PRICE,CHGCnd: string;
begin
  Str:='';
  UpCnd:='';
  CustCnd:='';
  COM_ID:=GetRimCOM_ID(trim(Params.ParamByName('TENANT_ID').AsString));

  if SyncType=3 then //�ŵ�ͬ��[ֻͬ�����ŵ�]
  begin
    CustCnd:=' and C.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and C.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
    UpCnd:=' and A.RELATI_ID='+Params.ParamByName('TENANT_ID').AsString+' ';
  end else
    UpCnd:=' and A.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  {Rim:1:����     0:������  R3: 1:��ҵ��� 2: ͳһ���� }
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
    BeginLogReport; //��ʼ�ϱ���־
    try
      if COM_ID<>'' then
      begin
        IsRun:=ExecTransSQL(Str,iRet,'����Rim���ۻ��޼���������');
        if IsRun and (SyncType<>3) then //������д��־
        begin
          FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //��ִ�ж�����
          Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ����'+InttoStr(iRet)+'�ʣ�����'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'��-------';
        end;
      end else
      begin
        if SyncType<>3 then Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ����: û�ҵ���ӦRim.COM_ID��-------'; //д��[REPORT]
        WriteLogFile('<Rim���ۻ��޼�������> ����: û�ҵ���ӦRim.COM_ID��'); 
      end;
    except
      on E:Exception do
      begin
        Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ������'+E.Message+'����-------';
        WriteLogFile(Msg);
      end;    
    end;
  finally
    WriteDownLoadToReportLog(Msg); //д��REPORT�ļ�
  end;
end;

procedure TParamsSyncFactory.WriteDownLoadToReportLog(LogMsg: string);
var
  LogFile: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //ǰִ̨�в�д��־
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















