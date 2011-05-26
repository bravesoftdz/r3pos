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
  TSyncCustomer=class(TZProcFactory)
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
  //下载Rim订单ID: 1002
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
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(1004);
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

{ TSyncCustomer }

function TSyncCustomer.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
begin
  result:=False;
  vParamStr := TftParamList.Encode(Params);
  //下载Rim订单ID: 1002
  PlugIn := PlugInList.Find(803);
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

initialization
  RegisterClass(TSyncMessage);
  RegisterClass(TRimWsdlService);
  RegisterClass(TSyncRimInfo);
  RegisterClass(TSyncCustomer);

finalization
  UnRegisterClass(TSyncMessage);
  UnRegisterClass(TRimWsdlService);
  UnRegisterClass(TSyncRimInfo);
  UnRegisterClass(TSyncCustomer);

end.
