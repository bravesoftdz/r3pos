unit ObjGoodsSort;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TGoodsSort=class(TZFactory)
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TGoodsSort }

function TGoodsSort.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Sort_Id:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  case FieldByName('SORT_TYPE').AsInteger of
    1: Sort_Id := 'SORT_ID1';    // ����
    2: Sort_Id := 'SORT_ID2';    // ���
    3: Sort_Id := 'SORT_ID3';    // ����
    4: Sort_Id := 'SORT_ID4';    // Ʒ��
    5: Sort_Id := 'SORT_ID5';    // �ص�(Ʒ��)
    6: Sort_Id := 'SORT_ID6';    // ʡ����
    7: Sort_Id := 'SORT_ID7';    // ��ɫ��
    8: Sort_Id := 'SORT_ID8';    // ������
  end;
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_GOODSINFO where '+Sort_Id+'=:UNIT_ID and COMM not in (''02'',''12'')';
    AGlobal.Open(rs);
    rs.ParamByName('UNIT_ID').AsString := FieldbyName('SORT_ID').AsString;
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsOldString+'"�Ѿ�����Ʒ������ʹ�ò���ɾ��.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TGoodsSort.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
    rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select SORT_ID,COMM,SEQ_NO from PUB_GOODSSORT where SORT_NAME=:SORT_NAME and SORT_TYPE=:SORT_TYPE and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    rs.ParamByName('SORT_TYPE').AsInteger := Fieldbyname('SORT_TYPE').AsInteger;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('SORT_NAME').AsString := Fieldbyname('SORT_NAME').AsString;
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //���ԭ��ɾ���ķ��飬��������ԭ�б���
           begin
             FieldbyName('SORT_ID').AsString := rs.FieldbyName('SORT_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_GOODSSORT where SORT_ID=:SORT_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsString+'"���Ʋ����ظ�����');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TGoodsSort.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_GOODSSORT where SORT_NAME=:SORT_NAME and SORT_ID<>:OLD_SORT_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsOldInteger;
    rs.ParamByName('SORT_NAME').AsString := Fieldbyname('SORT_NAME').AsString;
    rs.ParamByName('SORT_ID').AsString := Fieldbyname('SORT_ID').AsOldString;
    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsString+'"���Ʋ����ظ�����');
  finally
    rs.Free;
  end;
end;

procedure TGoodsSort.InitClass;
var
  Str: string;
begin
  inherited;
  //��ʼ����ѯ
  SelectSQL.Text := 'select SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,TENANT_ID from PUB_GOODSSORT '+
  'where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE order by LEVEL_ID';
  //��ʼ�������߼�
  IsSQLUpdate := true;
  Str :='insert into PUB_GOODSSORT (TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,COMM,TIME_STAMP) '+
  'values (:TENANT_ID,:SORT_ID,:LEVEL_ID,:SORT_NAME,:SORT_TYPE,:SORT_SPELL,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str :='update PUB_GOODSSORT set TENANT_ID=:TENANT_ID,SORT_ID=:SORT_ID,LEVEL_ID=:LEVEL_ID,SORT_NAME=:SORT_NAME,SORT_TYPE=:SORT_TYPE,SORT_SPELL=:SORT_SPELL,'+
  'SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text :=  Str;
  Str := 'update PUB_GOODSSORT set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;
initialization
  RegisterClass(TGoodsSort);
finalization
  UnRegisterClass(TGoodsSort);
end.

