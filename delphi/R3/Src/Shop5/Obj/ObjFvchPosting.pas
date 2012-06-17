//ƾ֤����
//1�����뵽���������ݿ�;
//2������ƾ֤�ֶ�(��ѡ�ֶ�);
//3��ACC_FVCHORDER,ACC_FVCHDATA��ACC_FVCHDetail����;

unit ObjFvchPosting;

interface

uses
  Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  //ƾ֤���ˣ���ˣ�
  TFvchPostForInspur=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;


implementation
 

{ TFvchPostForInspur }


function TFvchPostForInspur.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Ten_ID: integer;
  Fvch_ID: string;
  Rs: TZQuery;
begin
  result:=False;
  Ten_ID:=Params.ParamByName('TENANT_ID').AsInteger;
  Fvch_ID:=Params.ParamByName('FVCH_ID').AsString;
  try
    Rs:=TZQuery.Create(nil);
    //�ж��Ƿ��ѹ���
    Rs.Close;
    Rs.SQL.Text:='select FVCH_FLAG from ACC_FVCHORDER where FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''')';
    AGlobal.Open(Rs);
    if not Rs.IsEmpty then

    //��ʼִ�й���...
    Rs.Close;
    Rs.SQL.Text:='exec dt_repPosting '+IntToStr(Ten_ID)+','''+Fvch_ID+''' ';
    AGlobal.Open(Rs);
    if not Rs.IsEmpty then
      Msg:='  ƾ֤���˳ɹ��� '
    else
      Msg:='  ƾ֤����ʧ�ܣ� ';
    result:=(not Rs.IsEmpty);
  finally
    Rs.Free;
  end;
end; 

initialization
  RegisterClass(TFvchPostForInspur);

finalization
  UnRegisterClass(TFvchPostForInspur);

end.
