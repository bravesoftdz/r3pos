//凭证过账
//1、插入到第三方数据库;
//2、导出凭证字段(可选字段);
//3、ACC_FVCHORDER,ACC_FVCHDATA、ACC_FVCHDetail三表;

unit ObjFvchPosting;

interface

uses
  Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  //凭证过账（审核）
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
    //判断是否已过账
    Rs.Close;
    Rs.SQL.Text:='select FVCH_FLAG from ACC_FVCHORDER where FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''')';
    AGlobal.Open(Rs);
    if not Rs.IsEmpty then

    //开始执行过账...
    Rs.Close;
    Rs.SQL.Text:='exec dt_repPosting '+IntToStr(Ten_ID)+','''+Fvch_ID+''' ';
    AGlobal.Open(Rs);
    if not Rs.IsEmpty then
      Msg:='  凭证过账成功！ '
    else
      Msg:='  凭证过账失败！ ';
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
