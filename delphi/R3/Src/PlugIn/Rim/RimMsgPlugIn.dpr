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
//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;
//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;
//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := '信息互动同步';
end;
//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 802;
end;
//RSP调用插件时执行此方法
function DoExecute(Params:Pchar):Integer; stdcall;
var
  ParamList:TftParamList;
begin
  try
    //开始执行插件该做的工作.
    ParamList := TftParamList.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      case ParamList.ParamByName('flag').AsInteger of
      0:begin //同步调查
        end;
      1:begin //同步投诉
        end;
      2:begin //同步表扬
        end;
      3:begin //同步信息
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
//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    //开始显示主界面窗体
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
