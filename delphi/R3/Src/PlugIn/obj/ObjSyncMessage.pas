unit ObjSyncMessage;

interface
uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;
type
  TSyncMessage=class(TZProcFactory)
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
  //信息同步
  PlugIn := PlugInList.Find(802);
  try
    if PlugIn<>nil then
       begin
         PlugIn.DLLDoExecute(vParamStr,vData);
         msg := 'succ';
       end
    else
       msg := 'none';
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

{ TRimWsdlService }

function TRimWsdlService.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
begin
  result:=False;
  vParamStr := TftParamList.Encode(Params);
  PlugIn := PlugInList.Find(804);
  try
    if PlugIn<>nil then
       begin
         PlugIn.DLLDoExecute(vParamStr,vData);
         msg := vData;
       end
    else
       Exception.Create('没有开通RIM的wsdl服务..');
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

{ TSyncRimStorage }

function TSyncRimInfo.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
begin
  result:=False;
  vParamStr := TftParamList.Encode(Params);
  try
    //当前库存
    PlugIn := PlugInList.Find(805);
    if PlugIn<>nil then
       begin
         PlugIn.DLLDoExecute(vParamStr,vData);
         msg := 'succ';
       end
    else
       msg := 'none';

    //消费者
    PlugIn := PlugInList.Find(803);
    if PlugIn<>nil then
       begin
         PlugIn.DLLDoExecute(vParamStr,vData);
         msg := 'succ';
       end
    else
       msg := 'none';

    //销售汇总
    PlugIn := PlugInList.Find(810);
    if PlugIn<>nil then
       begin
         PlugIn.DLLDoExecute(vParamStr,vData);
         msg := 'succ';
       end
    else
       msg := 'none';

    result:=true;
  except
    if PlugIn<>nil then
       Raise Exception.Create(PlugIn.DLLGetLastError)
    else
       Raise;
  end;
end;

initialization
  RegisterClass(TSyncMessage);
  RegisterClass(TRimWsdlService);
  RegisterClass(TSyncRimInfo);

finalization
  UnRegisterClass(TSyncMessage);
  UnRegisterClass(TRimWsdlService);
  UnRegisterClass(TSyncRimInfo);

end.
