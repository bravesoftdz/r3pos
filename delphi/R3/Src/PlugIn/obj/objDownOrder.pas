unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  //���ض����б�
  TDownOrder=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  //���ض�����ϸ
  TDownIndeData=class(TZProcFactory)
  private
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;  


implementation

uses ZPlugIn;

{ TDownOrder }       

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr,Str: string;
  vData: OleVariant;
begin
  result:=False;
  //����Rim����ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params); //��ʽ���ַ��������б�;
    //ִ�в����RIM_SD_CO �Խӵ� �м��[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);
    //���ز�ѯ�����:

    Str:='select * from INF_INDEORDER A where not '+
         ' exists(select 1 from STK_STOCKORDER B where A.INDE_ID=B.COMM_ID) order by A.INDE_DATE,A.INDE_ID ';
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TDownOrder.InitClass;
begin
  inherited;

end;
 

{ TDownIndeData }

function TDownIndeData.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  PlugIn: TPlugIn;
  vParamStr,Str: string;
  vData: OleVariant;
begin
  result:=False;
  //����Rim����ID: 1002
  PlugIn := PlugInList.Find(1002);
  try
    vParamStr:=Params.Encode(Params);  //��ʽ���ַ��������б�;

    //ִ�в����RIM_SD_CO �Խӵ� �м��[INF_INDEORDER]:
    PlugIn.DLLDoExecute(vParamStr,vData);
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

initialization
  RegisterClass(TDownOrder);
  RegisterClass(TDownIndeData); 

finalization
  UnRegisterClass(TDownOrder);
  UnRegisterClass(TDownIndeData);

end.
