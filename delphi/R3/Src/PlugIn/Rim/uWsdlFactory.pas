{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uWsdlFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uFnUtil, uBaseSyncFactory, uRimSyncFactory;

type
  TWsdlSyncFactory=class(TRimSyncFactory)
  private
    FReData: OleVariant;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
    property ReData:OleVariant read FReData;
  end;

implementation

{ TWsdlSyncFactory }

function TWsdlSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  RimURL:string;
  Rs: TZQuery;
begin
  result:=-1;
  PlugInID:='804';
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //����RimURL
  RimURL:=ReadConfig('rim','url','');

  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  rs := TZQuery.Create(nil);
  try
    try
      if Params.FindParam('SHOP_ID')=nil then
        Params.ParambyName('SHOP_ID').asString := Params.ParambyName('TENANT_ID').asString+'0001';
      rs.close;
      rs.SQL.Text:=
         'select A.CUST_ID,A.COM_ID,A.CUST_CODE from RM_CUST A,CA_SHOP_INFO B '+
         ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and B.SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' ';
      if Open(rs) then
      begin
        Params.ParamByName('xsmuid').AsString := rs.Fields[0].AsString;
        Params.ParamByName('rimuid').AsString := rs.Fields[2].AsString;
        Params.ParamByName('rimpwd').AsString := rs.Fields[2].AsString;
        Params.ParamByName('rimcid').AsString := rs.Fields[1].AsString;
        Params.ParamByName('rimurl').AsString := RimURL;
        FReData := Params.Encode(Params);
        result:=0;
      end;
    except
      on E:Exception do
      begin
        WriteRunErrorMsg(E.Message);
        Raise;
      end;
    end;
  finally
    rs.Free;
  end;
end;

end.















