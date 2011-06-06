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
  Str, IndeTab, TenantID: string;
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
    Str:='select AA.*,BB.TENANT_ID as CLIENT_ID,BB.TENANT_NAME as CLIENT_NAME from '+
         '(select * from INF_INDEORDER A where A.TENANT_ID='+TenantID+' and not '+
         '  exists(select 1 from STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.COMM_ID and B.TENANT_ID='+TenantID+')) AA, '+
         '(select R.RELATI_ID as RELATI_ID,T.TENANT_ID,T.TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
         '  where T.TENANT_ID=R.TENANT_ID and T.COMM not in (''02'',''12'') and R.RELATI_ID='+TenantID+' and R.RELATION_ID=1000006) BB '+
         ' where AA.TENANT_ID=BB.RELATI_ID '+
         ' order by AA.INDE_DATE,AA.INDE_ID ';
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise;
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
  Str,TENANT_ID,IndeID: string;
begin
  result:=False;
  IndeID:=Params.ParamByName('INDE_ID').AsString;
  TENANT_ID:=Params.ParamByName('TENANT_ID').AsString;

  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params);  //格式化字符串参数列表;

    //执行插件将RIM_SD_CO对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);

    //返回订单明细表Data
    Str:='select INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,PRI3,AGIO_MONEY,AMONEY,CALC_AMOUNT from INF_INDEDATA '+
         ' where TENANT_ID='+TENANT_ID+' and INDE_ID='''+IndeID+''' ';

    //返回查询结果集:
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise;
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
