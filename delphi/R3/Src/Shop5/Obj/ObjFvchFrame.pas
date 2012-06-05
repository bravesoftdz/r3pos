unit ObjFvchFrame;

interface
uses Dialogs,SysUtils,ZBase,Classes, DB, ZDataSet,ZIntf,ObjCommon;

type
  TFvchFrame=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  
  TFvchSwhere=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TFvchFrame }

function TFvchFrame.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TFvchFrame.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(SEQNO) as SEQNO from ACC_FVCHFRAME where TENANT_ID=:TENANT_ID and FVCH_GTYPE=:FVCH_GTYPE ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('FVCH_GTYPE').AsString := FieldByName('FVCH_GTYPE').AsString;
    AGlobal.Open(rs);
    FieldByName('SEQNO').AsInteger := rs.Fields[0].AsInteger + 1;
  finally
    rs.Free;
  end;
end;

function TFvchFrame.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TFvchFrame.InitClass;
var
 Str,ViwTab:String;
begin
  inherited;
  ViwTab := ' select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=:TYPE_CODE '+
            ' union all '+
            ' select ''PAY_'''+GetStrJoin(iDbType)+'CODE_ID as CODE_ID,CODE_NAME from VIW_PAYMENT where TENANT_ID=:TENANT_ID';
            
  SelectSQL.Text := 'select A.TENANT_ID,A.FVCH_GTYPE,A.SEQNO,A.SUBJECT_NO,A.SUMMARY,A.AMONEY,A.AMOUNT,A.APRICE,A.SWHERE,A.DATAFLAG,A.SUBJECT_TYPE,'+
                    'case A.SUBJECT_TYPE when ''1'' then B.CODE_NAME when ''2'' then '''' end as SUBJECT_TYPE_1,'+
                    'case A.SUBJECT_TYPE when ''1'' then '''' when ''2'' then B.CODE_NAME end as SUBJECT_TYPE_2,'''' as OPTION '+
                    ' from ACC_FVCHFRAME A left join ( ' + ViwTab + ') B on A.AMONEY=B.CODE_ID '+
                    'where A.TENANT_ID=:TENANT_ID and A.FVCH_GTYPE=:FVCH_GTYPE ';

  {' select TENANT_ID,FVCH_GTYPE,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,SWHERE,DATAFLAG,SUBJECT_TYPE '+
                    ' from ACC_FVCHFRAME where TENANT_ID=:TENANT_ID and FVCH_GTYPE=:FVCH_GTYPE and SEQNO=:SEQNO '; }
  IsSQLUpdate := True;
  InsertSQL.Text := ' insert into ACC_FVCHFRAME(TENANT_ID,FVCH_GTYPE,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,SWHERE,DATAFLAG,SUBJECT_TYPE) '+
                    ' values(:TENANT_ID,:FVCH_GTYPE,:SEQNO,:SUBJECT_NO,:SUMMARY,:AMONEY,:AMOUNT,:APRICE,:SWHERE,:DATAFLAG,:SUBJECT_TYPE)';

  UpdateSQL.Text := ' update ACC_FVCHFRAME set TENANT_ID=:TENANT_ID,FVCH_GTYPE=:FVCH_GTYPE,SEQNO=:SEQNO,SUBJECT_NO=:SUBJECT_NO,SUMMARY=:SUMMARY,'+
                    'AMONEY=:AMONEY,AMOUNT=:AMOUNT,APRICE=:APRICE,SWHERE=:SWHERE,DATAFLAG=:DATAFLAG,SUBJECT_TYPE=:SUBJECT_TYPE '+
                    ' where TENANT_ID=:OLD_TENANT_ID and FVCH_GTYPE=:OLD_FVCH_GTYPE and SEQNO=:OLD_SEQNO ';

  DeleteSQL.Text := ' delete from ACC_FVCHFRAME where TENANT_ID=:OLD_TENANT_ID and FVCH_GTYPE=:OLD_FVCH_GTYPE and SEQNO=:OLD_SEQNO ';
end;


{ TFvchSwhere }

function TFvchSwhere.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TFvchSwhere.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TFvchSwhere.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TFvchSwhere.InitClass;
var Str:String;
begin
  inherited;
  SelectSQL.Text := ' select TENANT_ID,SROW_ID,SWHERE,FIELD_NAME,FIELD_EQUE,FIELD_VALUE from ACC_FVCHSWHERE where TENANT_ID=:TENANT_ID '+
                    ' and SWHERE in (select SWHERE from ACC_FVCHFRAME where TENANT_ID=:TENANT_ID and FVCH_GTYPE=:FVCH_GTYPE)';
  IsSQLUpdate := True;
  InsertSQL.Text := ' insert into ACC_FVCHSWHERE(TENANT_ID,SROW_ID,SWHERE,FIELD_NAME,FIELD_EQUE,FIELD_VALUE) '+
                    ' values(:TENANT_ID,:SROW_ID,:SWHERE,:FIELD_NAME,:FIELD_EQUE,:FIELD_VALUE)';

  UpdateSQL.Text := ' update ACC_FVCHSWHERE set TENANT_ID=:TENANT_ID,SROW_ID=:SROW_ID,SWHERE=:SWHERE,FIELD_NAME=:FIELD_NAME,'+
                    'FIELD_EQUE=:FIELD_EQUE,FIELD_VALUE=:FIELD_VALUE where TENANT_ID=:OLD_TENANT_ID and SROW_ID=:OLD_SROW_ID ';

  DeleteSQL.Text := ' delete from ACC_FVCHSWHERE where TENANT_ID=:OLD_TENANT_ID and SROW_ID=:OLD_SROW_ID ';
end;

initialization
  RegisterClass(TFvchFrame);
  RegisterClass(TFvchSwhere);
finalization
  UnRegisterClass(TFvchFrame);
  UnRegisterClass(TFvchSwhere);

end.
