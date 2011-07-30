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
  result := 'Wsdl�����ṩ���';
end;
//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 804;
end;
//RSP���ò��ʱִ�д˷���
//��R3������ã�ֻͬ�����ŵ��
function DoExecute(Params:Pchar;var Data:OleVariant):Integer; stdcall;
var
  ParamList:TftParamList;
  rs:TZQuery;
  F:TIniFile;
begin
  try
    //��ʼִ�в�������Ĺ���.
    ParamList := TftParamList.Create(nil);
    rs := TZQuery.Create(nil);
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
    try
      ParamList.Decode(ParamList,Params);
      if ParamList.FindParam('SHOP_ID')=nil then ParamList.ParambyName('SHOP_ID').asString := ParamList.ParambyName('TENANT_ID').asString+'0001';
      rs.SQL.Text:='select A.CUST_ID,A.COM_ID,A.CUST_CODE from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+ParamList.ParambyName('TENANT_ID').asString+' and B.SHOP_ID='''+ParamList.ParambyName('SHOP_ID').asString+''' ';
      OpenData(GPlugIn, rs);
      ParamList.ParamByName('xsmuid').AsString := rs.Fields[0].AsString;
      ParamList.ParamByName('rimuid').AsString := rs.Fields[2].AsString;
      ParamList.ParamByName('rimpwd').AsString := rs.Fields[2].AsString;
      ParamList.ParamByName('rimcid').AsString := rs.Fields[1].AsString;
      ParamList.ParamByName('rimurl').AsString := F.readString('rim','url','');
      Data := ParamList.Encode(ParamList);
    finally
      F.free;
      rs.Free;
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
