{
  Create Date: 2011.04.13 Pm
  �������: Rspƽ̨�ϱ����̹�Ӧ�����ݵ� Rim

 }


library RimBillPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas',
  uBillFactory in 'uBillFactory.pas';

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
  result := 'Rspƽ̨�ϱ���RIM��ˮ����';
end;

//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 807;  //RIM�ӿڵĲ��
end;

//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar; var Data: oleVariant):Integer; stdcall;
var
  TENANT_ID: string;
  vParam: TftParamList;
begin
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,StrPas(Params));
    TENANT_ID:=trim(vParam.ParamByName('TENANT_ID').AsString);
  finally
    vParam.Free;
  end;

  try
    //ִ�в���
    CallSync(GPlugIn,TENANT_ID);
    result := 0;
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
    //��ʼ��ʾ�����洰��

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


