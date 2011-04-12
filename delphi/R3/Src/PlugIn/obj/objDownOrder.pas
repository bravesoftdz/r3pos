unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  TDownOrder=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;  
    procedure InitClass; override;
  end;

implementation

uses ZPlugIn;

{ TDownOrder }       

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr: string;
  vData: oldVariant;
begin
  result:=False;
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params); //格式化字符串参数列表;

    //第一步: 从第三方视图[RIM_SD_CO] 到 RSP中间表 [INF_INDEORDER];
    PlugIn.DLLDoExecute(vParamStr,vData);

    //第二步: 从RSP中间表查询返回显示
    SelectSQL.Text:=
      'select * from  ';
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TDownOrder.InitClass;
begin
  inherited;

end;
 

initialization
  RegisterClass(TDownOrder);

finalization
  UnRegisterClass(TDownOrder);

end.
