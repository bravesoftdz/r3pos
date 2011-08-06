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
  //��Ϣͬ��
  PlugIn := PlugInList.Find(802);
  try
    if PlugIn<>nil then
       begin
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
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
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
         msg := vData;
       end
    else
       Exception.Create('û�п�ͨRIM��wsdl����..');
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
    //��ǰ���
    PlugIn := PlugInList.Find(805);
    if PlugIn<>nil then
       begin
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
         msg := 'succ';
       end
    else
       msg := 'none';

    //������
    PlugIn := PlugInList.Find(803);
    if PlugIn<>nil then
       begin
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
         msg := 'succ';
       end
    else
       msg := 'none';

    //���ۻ���
    PlugIn := PlugInList.Find(810);
    if PlugIn<>nil then
       begin
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
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

{ TSyncQuestion }

function TSyncQuestion.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vData: OleVariant;
  vParamStr: string;
begin
  result:=False;
  vParamStr := TftParamList.Encode(Params);
  //��Ϣͬ��
  PlugIn := PlugInList.Find(807);
  try
    if PlugIn<>nil then
       begin
         PlugIn.Enter;
         try
            if PlugIn.Working=0 then
            PlugIn.DLLDoExecute(vParamStr,vData);
         finally
            PlugIn.Leave;
         end;
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
  RegisterClass(TSyncQuestion);
  RegisterClass(TRimWsdlService);
  RegisterClass(TSyncRimInfo);

finalization
  UnRegisterClass(TSyncMessage);
  UnRegisterClass(TSyncQuestion);
  UnRegisterClass(TRimWsdlService);
  UnRegisterClass(TSyncRimInfo);

end.
