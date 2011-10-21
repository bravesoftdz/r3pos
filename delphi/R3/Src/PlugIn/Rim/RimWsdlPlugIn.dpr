library RimWsdlPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.
}

uses
  SysUtils,
  Classes,
  Forms,
  ZBase,
  ZDataSet,
  IniFiles,
  uPlugInUtil in '..\obj\uPlugInUtil.pas',
  ufrmRimConfig in 'ufrmRimConfig.pas' {frmRimConfig},
  uWsdlFactory in 'uWsdlFactory.pas',
  uBaseSyncFactory in '..\pub\uBaseSyncFactory.pas';

{$R *.res}

//RSPװ�ز��ʱ���ã�������ɷ��ʵķ���ӿ�
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//�����ִ�е����в���������� try except end �������ʱ���ɴ˷������ش���Ϣ
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//���ص�ǰ���˵��
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'Wsdl�����ṩ���';
end;

//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 804;
end;

//RSP���ò��ʱִ�д˷���
//��R3������ã�ֻͬ�����ŵ��
function DoExecute(Params:Pchar;var Data:OleVariant;dbResoler:integer):Integer; stdcall;
var
  ReRun: integer;
  WsdlFactory: TWsdlSyncFactory;
begin
  result:=-1;
  GLastError:='';
  try
    try                                 
      WsdlFactory:=TWsdlSyncFactory.Create;
      WsdlFactory.dbResoler := dbResoler;
      WsdlFactory.N26Version := false;
      ReRun:=WsdlFactory.CallSyncData(GPlugIn,StrPas(Params));
      if ReRun=0 then
      begin
        Data:=WsdlFactory.ReData;
      end;
      if not WsdlFactory.HasError then //����������
        result:=0
      else
        GLastError:='<804>'+WsdlFactory.ErrorMsg;
    finally
      WsdlFactory.Free;
    end;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2001;
      end;
  end;
end;

//RSP���ò���Զ���Ĺ������,û��ʱֱ�ӷ���0
function ShowPlugin:Integer; stdcall;
begin
  try
    with TfrmRimConfig.Create(application) do
      begin
        try
          ShowModal;
        finally
          free;
        end;
      end;
    result := 0;

  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;
exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin
end.
