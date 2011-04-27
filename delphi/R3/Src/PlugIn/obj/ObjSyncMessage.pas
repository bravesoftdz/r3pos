unit ObjSyncMessage;

interface
uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;
type
  TSyncMessage=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation
uses ZPlugIn, ZlogFile;

{ TSyncMessage }

function TSyncMessage.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
begin
  result:=False;
  vParamStr := TftParamList.Encode(Params); 
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(802);
  try
    //执行插件将RIM_SD_CO 对接到 中间表[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

initialization
  RegisterClass(TSyncMessage);

finalization
  UnRegisterClass(TSyncMessage);
end.
