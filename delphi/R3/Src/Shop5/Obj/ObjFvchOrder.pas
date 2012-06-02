unit ObjFvchOrder;

interface

uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  //财务凭证
  TFvchOrder = class(TZFactory)
  private
    procedure UpdateCalcDate(AGlobal:IdbHelp); //更新单据的计算日期
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

  //凭证分录
  TFvchData = class(TZFactory)
  public
    procedure InitClass;override;
  end;

  //凭证明细
  TFvchDetail = class(TZFactory)
  public
    procedure InitClass;override;
  end;

  //单据关联
  TFvchGlide = class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;


implementation

uses
  DateUtils;

{ TFvchOrder }

function TFvchOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Fvch_Code: string;
begin
  Fvch_Code:=GetSequence(AGlobal,'GNO_11_'+Params.ParamByName('TENANT_ID').AsString,
                         Params.ParamByName('TENANT_ID').AsString,
                         Params.ParamByName('FVCH_GTYPE').AsString,6);
  FieldbyName('FVCH_CODE').AsString := Fvch_Code;
  DataSet.Edit;
  DataSet.FieldByName('FVCH_CODE').AsString:=Fvch_Code;
  DataSet.Post;                       
end;

procedure TFvchOrder.InitClass;          
var
  Str: string;
begin
  inherited;
  IsSQLUpdate := True;  
  SelectSQL.Text:=
    'select j.TENANT_ID,j.SHOP_ID,j.DEPT_ID,j.FVCH_ID,j.FVCH_DATE,j.FVCH_ATTACH'+
    ' ,j.CREA_USER,j.FVCH_FLAG,j.FVCH_CODE,j.FVCH_IMPORT_ID,j.COMM,j.TIME_STAMP'+
    ' ,a.SHOP_NAME as SHOP_ID_TEXT '+
    ' ,b.DEPT_NAME as DEPT_ID_TEXT '+
    ' from ACC_FVCHORDER j '+
    ' left outer join CA_SHOP_INFO a on j.TENANT_ID=a.TENANT_ID and j.SHOP_ID=a.SHOP_ID '+
    ' left outer join CA_DEPT_INFO b on j.TENANT_ID=b.TENANT_ID and j.DEPT_ID=b.DEPT_ID '+
    ' where j.TENANT_ID=:TENANT_ID and j.FVCH_ID=:FVCH_ID and j.COMM not in (''02'',''12'') ';

  InsertSQL.Text :=
    'insert into ACC_FVCHORDER '+
    ' (TENANT_ID,SHOP_ID,DEPT_ID,FVCH_ID,FVCH_DATE,FVCH_ATTACH,CREA_USER,FVCH_FLAG,FVCH_CODE,FVCH_IMPORT_ID,COMM,TIME_STAMP) '+
    ' VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:FVCH_ID,:FVCH_DATE,:FVCH_ATTACH,:CREA_USER,:FVCH_FLAG,:FVCH_CODE,:FVCH_IMPORT_ID,'+
    ' ''00'','+GetTimeStamp(iDbType)+')';

  UpdateSQL.Text :=
    'update ACC_FVCHORDER '+
    ' set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,FVCH_ID=:FVCH_ID,FVCH_DATE=:FVCH_DATE,FVCH_ATTACH=:FVCH_ATTACH,CREA_USER=:CREA_USER,'+
    ' FVCH_FLAG=:FVCH_FLAG,FVCH_CODE=:FVCH_CODE,FVCH_IMPORT_ID=:FVCH_IMPORT_ID,COMM=' + GetCommStr(iDbType) +',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID ';

  DeleteSQL.Text :=
    'delete from ACC_FVCHORDER where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID';   
end;

procedure TFvchOrder.UpdateCalcDate(AGlobal: IdbHelp);
var
  Str,CurDate,DEFINE: string;
begin
  CurDate:=FormatDatetime('YYYY-MM-DD',Date());
  DEFINE:='CALC_DATE_'+Params.ParamByName('FVCH_GTYPE').AsString;
  //先更新
  Str:='update sys_define set VALUE=case when VALUE<'''+CurDate+''' then '''+CurDate+''' else VALUE end '+
       ' where TENANT_ID='+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+' and DEFINE='''+DEFINE+''' and VALUE_TYPE=1 ';
  if AGlobal.ExecSQL(Str)=0 then
  begin
    //更新不到在插入
    Str:='insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values '+
         '('+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+','''+DEFINE+''','''+CurDate+''',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
    AGlobal.ExecSQL(Str);
  end;
end;

{ TFvchData }

procedure TFvchData.InitClass;
var
  Str: string;
begin
  inherited;
  IsSQLUpdate := True;  
  SelectSQL.Text:=
    'select TENANT_ID,SHOP_ID,FVCH_ID,FVCH_DID,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,SUBJECT_TYPE,OPER_DATE '+
    ' from ACC_FVCHDATA where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID ';

  InsertSQL.Text :=
    'insert into ACC_FVCHDATA '+
    ' (TENANT_ID,SHOP_ID,FVCH_ID,FVCH_DID,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,SUBJECT_TYPE,OPER_DATE) '+
    ' VALUES(:TENANT_ID,:SHOP_ID,:FVCH_ID,:FVCH_DID,:SEQNO,:SUBJECT_NO,:SUMMARY,:AMONEY,:AMOUNT,:APRICE,:SUBJECT_TYPE,:OPER_DATE)';

  UpdateSQL.Text :=
    'update ACC_FVCHDATA '+
    ' set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,FVCH_ID=:FVCH_ID,FVCH_DID=:FVCH_DID,SEQNO=:SEQNO,SUBJECT_NO=:SUBJECT_NO,'+
    ' SUMMARY=:SUMMARY,AMONEY=:AMONEY,AMOUNT=:AMOUNT,APRICE=:APRICE,SUBJECT_TYPE=:SUBJECT_TYPE,OPER_DATE=:OPER_DATE '+
    ' where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID and FVCH_DID=:OLD_FVCH_DID and SEQNO=:OLD_SEQNO';

  DeleteSQL.Text :=
    'delete from ACC_FVCHDATA where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID and FVCH_DID=:OLD_FVCH_DID and SEQNO=:OLD_SEQNO';   
end;

{ TFvchDetail }

procedure TFvchDetail.InitClass;
var
  Str: string;
begin
  inherited;
  IsSQLUpdate := True;
  SelectSQL.Text:=
    'select TENANT_ID,SHOP_ID,FVCH_TID,FVCH_ID,FVCH_DID,SEQNO,SUBJ_USER,SUBJ_DEPT,SUBJ_SHOP,SUBJ_CLIENT,SUBJ_OTHR1,SUBJ_OTHR2,SUBJ_OTHR3,SUBJ_OTHR4,SUBJ_OTHR5,'+
    'SUMMARY,AMONEY,AMOUNT,APRICE,OPER_DATE from ACC_FVCHDETAIL where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID ';

  InsertSQL.Text :=
    'insert into ACC_FVCHDATA '+
    ' (TENANT_ID,SHOP_ID,FVCH_TID,FVCH_ID,FVCH_DID,SEQNO,SUBJ_USER,SUBJ_DEPT,SUBJ_SHOP,SUBJ_CLIENT,SUBJ_OTHR1,SUBJ_OTHR2,SUBJ_OTHR3,SUBJ_OTHR4,SUBJ_OTHR5,'+
      'SUMMARY,AMONEY,AMOUNT,APRICE,OPER_DATE) '+
    ' VALUES(:TENANT_ID,:SHOP_ID,:FVCH_TID,:FVCH_ID,:FVCH_DID,:SEQNO,:SUBJ_USER,:SUBJ_DEPT,:SUBJ_SHOP,:SUBJ_CLIENT,:SUBJ_OTHR1,:SUBJ_OTHR2,:SUBJ_OTHR3,:SUBJ_OTHR4,:SUBJ_OTHR5,'+
      ':SUMMARY,:AMONEY,:AMOUNT,:APRICE,:OPER_DATE)';

  UpdateSQL.Text :=
    'update ACC_FVCHDATA '+
    ' set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,FVCH_TID=:FVCH_TID,FVCH_ID=:FVCH_ID,FVCH_DID=:FVCH_DID,SEQNO=:SEQNO,SUBJ_USER=:SUBJ_USER,SUBJ_DEPT=:SUBJ_DEPT,'+
      'SUBJ_SHOP=:SUBJ_SHOP,SUBJ_CLIENT=:SUBJ_CLIENT,SUBJ_OTHR1=:SUBJ_OTHR1,SUBJ_OTHR2=:SUBJ_OTHR2,SUBJ_OTHR3=:SUBJ_OTHR3,SUBJ_OTHR4=:SUBJ_OTHR4,SUBJ_OTHR5=:SUBJ_OTHR5,'+
      'SUMMARY=:SUMMARY,AMONEY=:AMONEY,AMOUNT=:AMOUNT,APRICE=:APRICE,OPER_DATE=:OPER_DATE '+
    ' where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID and FVCH_DID=:OLD_FVCH_DID and FVCH_TID=:OLD_FVCH_TID and SEQNO=:OLD_SEQNO';

  DeleteSQL.Text :=
    'delete from ACC_FVCHDATA where TENANT_ID=:OLD_TENANT_ID and FVCH_ID=:OLD_FVCH_ID and and FVCH_DID=:OLD_FVCH_DID and FVCH_TID=:OLD_FVCH_TID and SEQNO=:OLD_SEQNO';
end;

{ TFvchGlide }

function TFvchGlide.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  //插入前做判断
  try
    Str:='insert into ACC_FVCHGLIDE(TENANT_ID,FVCH_GLID,FVCH_ID,FVCH_GTYPE,FVCH_GID) values (:TENANT_ID,:FVCH_GLID,:FVCH_ID,:FVCH_GTYPE,:FVCH_GID)';
    AGlobal.ExecSQL(Str,self);
  except
  end;
end;


procedure TFvchGlide.InitClass;
begin
  SelectSQL.Text:='select TENANT_ID,FVCH_GLID,FVCH_ID,FVCH_GTYPE,FVCH_GID from ACC_FVCHGLIDE where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID';
end;

initialization
  RegisterClass(TFvchOrder);
  RegisterClass(TFvchData);
  RegisterClass(TFvchDetail);
  RegisterClass(TFvchGlide);

finalization
  UnRegisterClass(TFvchOrder);
  UnRegisterClass(TFvchData);
  UnRegisterClass(TFvchDetail);
  UnRegisterClass(TFvchGlide);

end.
