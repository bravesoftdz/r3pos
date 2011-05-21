library RimMsgPlugIn_Oracle;

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
  ZDataSet,
  IniFiles,
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
  uMsgFactory in 'uMsgFactory.pas',
  ObjSyncMessage in '..\obj\ObjSyncMessage.pas',
  ufrmRimConfig in 'ufrmRimConfig.pas' {frmRimConfig};

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
  result := 1054;
end;
//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar;var Data:OleVariant):Integer; stdcall;
var
  ParamList:TftParamList;
  rs:TZQuery;
  V:OleVariant;
  F:TIniFile;
begin
  try
    //��ʼִ�в�������Ĺ���.
    ParamList := TftParamList.Create(nil);
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
    try
      url := F.ReadString('rim','url','');
      ParamList.Decode(ParamList,Params);
      if ParamList.ParamByName('flag').AsInteger <0 then
         begin
           if url='' then Raise Exception.Create('û������rim�ķ����ַ...'); 
           rs := TZQuery.Create(nil);
           try
             if GPlugIn.Open(pchar('select TENANT_ID,LICENSE_CODE from CA_TENANT where TENANT_ID in (select RELATI_ID from CA_RELATIONS where TENANT_ID='+ParamList.ParamByName('TENANT_ID').AsString+' and RELATION_ID=1000006)'),V)<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
             rs.Data := V;
             rs.First;
             while not rs.Eof do
               begin
                 DoSyncMessage(rs.Fields[0].asString,rs.Fields[1].asString);
                 DoSyncQuestion(rs.Fields[0].asString,rs.Fields[1].asString);
                 rs.Next;
               end;
           finally
             rs.Free;
           end;
         end
      else
        case ParamList.ParamByName('flag').AsInteger of
        0:DoSaveQuestion(ParamList.ParamByName('TENANT_ID').asString,ParamList.ParamByName('LICENSE_CODE').asString,ParamList.ParamByName('QUESTION_ID').asString);
        1:DoSaveImpeach(ParamList.ParamByName('TENANT_ID').asString,ParamList.ParamByName('LICENSE_CODE').asString,ParamList.ParamByName('ROWS_ID').asString);
        end;
    finally
      F.free;
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
    with TfrmRimConfig.Create(nil) do
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
