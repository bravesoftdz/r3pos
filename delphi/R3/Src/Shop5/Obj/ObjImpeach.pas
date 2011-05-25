unit ObjImpeach;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  TImpeach=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //���м�¼������Ϻ�,�����ύ��ǰִ�С�
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TImpeach }

function TImpeach.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
//var
//  Proc:TZProcFactory;
//  ProcClass:TPersistentClass;
//  Params:TftParamList;
//  rs:TZQuery;
begin
  //���ʴ����ֱ���ϴ����ϼ���ҵ
{  ProcClass := GetClass('TSyncMessage');
  if ProcClass=nil then Exit;
  Proc := TZProcFactoryClass(ProcClass).Create(AGlobal,nil);
  Params := TftParamList.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    Params.ParamByName('flag').AsInteger := 2;
    Params.ParamByName('QUESTION_ID').AsString := FieldbyName('ROWS_ID').AsString;
    Params.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    if not Proc.Execute(AGlobal,Params) then Raise Exception.Create('ͬ���ӿ�û����ȷ����ֵ');
  finally
    rs.Free;
    Params.Free;
    Proc.Free;
  end;
}  
end;

function TImpeach.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TImpeach.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TImpeach.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TImpeach.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='ACCOUNT_ID;TENANT_ID';

  Str :=
  'select ROWS_ID,TENANT_ID,SHOP_ID,IMPH_TENANT_ID,IMPH_DATE,CREA_DATE,CREA_USER,IMPEACH_CLASS,IMPEACH_FEEDBACK_STATUS,IS_REPEAT,IS_URGENCY,'+
  'IS_REPLY,CONTENT,IMPEACH_USER,IMPEACH_PROC_STATUS,IMPEACH_PROC_INFO,IMPEACH_PROC_DATE from MSC_IMPEACH where ROWS_ID=:ROWS_ID and TENANT_ID=:TENANT_ID ';
  SelectSQL.Text := Str;

  IsSQLUpdate := True;
  Str := 'insert into MSC_IMPEACH(ROWS_ID,TENANT_ID,SHOP_ID,IMPH_TENANT_ID,IMPH_DATE,CREA_DATE,CREA_USER,IMPEACH_CLASS,IMPEACH_FEEDBACK_STATUS,'+
  'IS_REPEAT,IS_URGENCY,IS_REPLY,CONTENT,IMPEACH_USER,IMPEACH_PROC_STATUS,IMPEACH_PROC_INFO,IMPEACH_PROC_DATE,COMM,TIME_STAMP) '+
  'values(:ROWS_ID,:TENANT_ID,:SHOP_ID,:IMPH_TENANT_ID,:IMPH_DATE,:CREA_DATE,:CREA_USER,:IMPEACH_CLASS,:IMPEACH_FEEDBACK_STATUS,:IS_REPEAT,'+
  ':IS_URGENCY,:IS_REPLY,:CONTENT,:IMPEACH_USER,:IMPEACH_PROC_STATUS,:IMPEACH_PROC_INFO,:IMPEACH_PROC_DATE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str :=
  'update MSC_IMPEACH set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,IMPH_TENANT_ID=:IMPH_TENANT_ID,IMPH_DATE=:IMPH_DATE,CREA_DATE=:CREA_DATE,'+
  'CREA_USER=:CREA_USER,IMPEACH_CLASS=:IMPEACH_CLASS,IMPEACH_FEEDBACK_STATUS=:IMPEACH_FEEDBACK_STATUS,IS_REPEAT=:IS_REPEAT,IS_URGENCY=:IS_URGENCY,'+
  'IS_REPLY=:IS_REPLY,CONTENT=:CONTENT,IMPEACH_USER=:IMPEACH_USER,IMPEACH_PROC_STATUS=:IMPEACH_PROC_STATUS,IMPEACH_PROC_INFO=:IMPEACH_PROC_INFO,'+
  'IMPEACH_PROC_DATE=:IMPEACH_PROC_DATE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  UpdateSQL.Text := Str;

  Str := 'update MSC_IMPEACH set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TImpeach);
finalization
  UnRegisterClass(TImpeach);

end.
 