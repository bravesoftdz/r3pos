unit ObjSyncMessage;

interface
uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;
type
  TSyncMessage=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSyncQuestion=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TRimWsdlService=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSyncRimInfo=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation
uses ZPlugIn, ZlogFile,objPlugInSyncData;

{ TSyncMessage }

function TSyncMessage.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  vData: OleVariant;
  PlugInObj: TPlugInSyncMessage;
begin
  result:=False;
  //信息同步
  try
    try
      PlugInObj:=TPlugInSyncMessage.Create(AGlobal);
      PlugInObj.DLLDoExecute(Params,vData);
    finally
      PlugInObj.Free;
    end;
    result := true;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;
end;

{ TRimWsdlService }

function TRimWsdlService.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  vData: OleVariant;
  RimWsdlObj: TPlugSyncWsdlService;
begin
  result:=False;
  //RIM的wsdl服务
  try
    try
      RimWsdlObj:=TPlugSyncWsdlService.Create(AGlobal);
      RimWsdlObj.DLLDoExecute(Params,vData);
    finally
      RimWsdlObj.Free;
    end;
    msg:=vData;
    result:=true;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;
end;

{ TSyncRimStorage }

function TSyncRimInfo.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  vData: OleVariant;
  PlugInBase: TPlugInBase;  
begin
  result:=False;
  try
    //当前库存
    try
      PlugInBase:=TPlugInSyncStorage.Create(AGlobal);
      PlugInBase.DLLDoExecute(Params,vData);
    finally
      PlugInBase.Free;
    end;

    //消费者
    try
      PlugInBase:=TPlugSyncVip.Create(AGlobal);
      PlugInBase.DLLDoExecute(Params,vData);
    finally
      PlugInBase.Free;
    end;

    //销售汇总
    try
      PlugInBase:=TPlugSyncSaleTotal.Create(AGlobal);
      PlugInBase.DLLDoExecute(Params,vData);
    finally
      PlugInBase.Free;
    end;
    result:=true;
  except
    Raise;
  end;
end;

{ TSyncQuestion }

function TSyncQuestion.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  vData: OleVariant;
  PlugQuestionObj: TPlugSyncQuestion;
begin
  result:=False;
  //信息同步
  try
    //当前库存
    try
      PlugQuestionObj:=TPlugSyncQuestion.Create(AGlobal);
      PlugQuestionObj.DLLDoExecute(Params,vData);
      result:=true;
    finally
      PlugQuestionObj.Free;
    end;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;    
end;

initialization
  RegisterClass(TSyncMessage);
  RegisterClass(TSyncQuestion);
  RegisterClass(TRimWsdlService);
  RegisterClass(TSyncRimInfo);

finalization
  UnRegisterClass(TSyncMessage);
  UnRegisterClass(TSyncQuestion);
  UnRegisterClass(TRimWsdlService);
  UnRegisterClass(TSyncRimInfo);

end.
