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
  //ÏÂÔØRim¶©µ¥ID: 1002
  PlugIn := PlugInList.Find(802);
  try
    if PlugIn=nil then
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

finalization
  UnRegisterClass(TSyncMessage);
end.
