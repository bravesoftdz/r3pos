unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  //下载订单列表
  TDownOrder=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  //下载订单明细
  TDownIndeData=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;  


implementation

uses ZPlugIn, ZlogFile;

{ TDownOrder }       

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
  Str, TenantID: string;
begin
  result:=False;
  //取企业ID
  TenantID:=InttoStr(Params.ParamByName('TENANT_ID').AsInteger);

  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params); //格式化字符串参数列表;
    //执行插件将RIM_SD_CO 对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);

    //返回查询结果集:
    Str:='select * from INF_INDEORDER A where A.TENANT_ID='+TenantID+' and not '+
         ' exists(select 1 from STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.COMM_ID and B.TENANT_ID='+TenantID+')'+
         ' order by A.INDE_DATE,A.INDE_ID ';
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TDownOrder.InitClass;
begin
  inherited;

end;
 

 { TDownIndeData }

function TDownIndeData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
  Str,SumTab,TENANT_ID,IndeID: string;
begin
  result:=False;
  LogFile.AddLogFile(0, '1111'); 
  IndeID:=Params.ParamByName('INDE_ID').AsString;
  TENANT_ID:=Params.ParamByName('TENANT_ID').AsString;
  LogFile.AddLogFile(0, '2222'); 
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params);  //格式化字符串参数列表;

    //执行插件将RIM_SD_CO 对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);

    //返回查询结果集:
    SumTab:='select SECOND_ID,count(*) as resum from INF_INDEDATA where INDE_ID='''+IndeID+''' and coalesce(GODS_ID,'''')='''' group by SECOND_ID';
    Str:=' select * from (select B.item_id as SECOND_ID,B.item_code as GODS_CODE,B.item_name as GODS_NAME from SD_ITEM B,INF_INDEDATA A '+
         ' where A.SECOND_ID=B.item_id and A.INDE_ID='''+IndeID+''' and coalesce(GODS_ID,'''')='''')tp fetch first 30 rows only  ';
    Str:='select AA.*,BB.resum from ('+Str+') AA,('+SumTab+')BB where AA.SECOND_ID=BB.SECOND_ID ';
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TDownIndeData.InitClass;
begin
  inherited;

end;

initialization
  RegisterClass(TDownOrder);
  RegisterClass(TDownIndeData); 

finalization
  UnRegisterClass(TDownOrder);
  UnRegisterClass(TDownIndeData);

end.
