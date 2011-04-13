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
  TDownIndeData=class(TZProcFactory)
  private
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;  


implementation

uses ZPlugIn;

{ TDownOrder }       

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr,Str: string;
  vData: OleVariant;
begin
  result:=False;
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params); //格式化字符串参数列表;
    //执行插件将RIM_SD_CO 对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);
    //返回查询结果集:

    Str:='select * from INF_INDEORDER A where not '+
         ' exists(select 1 from STK_STOCKORDER B where A.INDE_ID=B.COMM_ID) order by A.INDE_DATE,A.INDE_ID ';
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

function TDownIndeData.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr,Str: string;
  vData: OleVariant;
begin
  result:=False;
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params);  //格式化字符串参数列表;

    //执行插件将RIM_SD_CO 对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

initialization
  RegisterClass(TDownOrder);
  RegisterClass(TDownIndeData); 

finalization
  UnRegisterClass(TDownOrder);
  UnRegisterClass(TDownIndeData);

end.
