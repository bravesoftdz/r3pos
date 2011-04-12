unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  TDownOrder=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;  
    procedure InitClass; override;
  end;

implementation

uses ZPlugIn;

{ TDownOrder }       

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr: string;
  vData: oldVariant;
begin
  result:=False;
  //����Rim����ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params); //��ʽ���ַ��������б�;

    //��һ��: �ӵ�������ͼ[RIM_SD_CO] �� RSP�м�� [INF_INDEORDER];
    PlugIn.DLLDoExecute(vParamStr,vData);

    //�ڶ���: ��RSP�м���ѯ������ʾ
    SelectSQL.Text:=
      'select * from  ';
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TDownOrder.InitClass;
begin
  inherited;

end;
 

initialization
  RegisterClass(TDownOrder);

finalization
  UnRegisterClass(TDownOrder);

end.
