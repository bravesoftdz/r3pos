library RimMsgPlugIn;

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
  SysUtils,
  Classes,
  ZBase,
  WsdlComm in 'Wsdl\WsdlComm.pas',
  SoapCheckCustCo in 'Wsdl\SoapCheckCustCo.pas',
  SoapConsumerScoreService in 'Wsdl\SoapConsumerScoreService.pas',
  SoapCoSimulatorService in 'Wsdl\SoapCoSimulatorService.pas',
  SoapGetCustItemMaxWhse in 'Wsdl\SoapGetCustItemMaxWhse.pas',
  SoapGetMessage in 'Wsdl\SoapGetMessage.pas',
  SoapInitCustWhse in 'Wsdl\SoapInitCustWhse.pas',
  SoapinsertRetailCo in 'Wsdl\SoapinsertRetailCo.pas',
  SoapInvestigate in 'Wsdl\SoapInvestigate.pas',
  SoapQueryCoDetai in 'Wsdl\SoapQueryCoDetai.pas',
  SoapQueryCoService in 'Wsdl\SoapQueryCoService.pas',
  SoapQueryCustBankAccService in 'Wsdl\SoapQueryCustBankAccService.pas',
  SoapQueryItemInfoService in 'Wsdl\SoapQueryItemInfoService.pas',
  SoapQueryItemUmSize in 'Wsdl\SoapQueryItemUmSize.pas',
  SoapRimCoSave in 'Wsdl\SoapRimCoSave.pas',
  SoapRimImpeachService in 'Wsdl\SoapRimImpeachService.pas',
  SoapRimSuggestionService in 'Wsdl\SoapRimSuggestionService.pas',
  SoapUserRegister in 'Wsdl\SoapUserRegister.pas',
  uMsgFactory in 'uMsgFactory.pas';

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
  result := '��Ϣ����ͬ��';
end;
//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 802;
end;
//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar):Integer; stdcall;
var
  ParamList:TftParamList;
begin
  try
    //��ʼִ�в�������Ĺ���.
    ParamList := TftParamList.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      case ParamList.ParamByName('flag').AsInteger of
      0:begin //ͬ������
        end;
      1:begin //ͬ��Ͷ��
        end;
      2:begin //ͬ������
        end;
      3:begin //ͬ����Ϣ
        end;
      end;
    finally
      ParamList.Free;
    end;
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
