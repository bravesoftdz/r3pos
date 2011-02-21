unit ObjDeptRights;
interface
uses Dialogs,SysUtils,ObjBase,Classes, AdoDb,uIdComm,ObjCommon;
type
  TRigths=class(TSingleObj)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
//    function BeforeInsertRecord(AGlobal:IaAgent):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
//    function BeforeModifyRecord(AGlobal:IaAgent):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
//    function BeforeDeleteRecord(AGlobal:IaAgent):Boolean;override;
    //所有记录处理完毕后,事务提交以前执行。
    function AfterUpdateBatch(AGlobal:IaAgent):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TRigths }


function TRigths.AfterUpdateBatch(AGlobal: IaAgent): Boolean;
var str:string;
begin
  Str :='delete from CA_RIGHTS where UTYPE=0  and UID='''+FieldByName('UID').AsString+''' and  COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+FieldByName('COMP_ID').AsString+''' and COMP_TYPE=2 and COMM not in (''02'',''12'') )';
  AGlobal.ExecSQL(Str);

  Str := 'insert into CA_RIGHTS(COMP_ID,MID,UID,UTYPE,CHK,COMM,TIME_STAMP) '
  +'select A.COMP_ID,B.MID,B.UID,B.UTYPE,B.CHK,''00'','+GetTimeStamp(iDbType)+' from CA_COMPANY A,CA_RIGHTS B where A.UPCOMP_ID='''+FieldByName('COMP_ID').AsString
  +''' and A.COMP_TYPE=2 and A.COMM not in (''02'',''12'')  and B.UTYPE=0 and B.COMP_ID='''+FieldByName('COMP_ID').AsString+''' and B.UID='''+FieldByName('UID').AsString+'''';
  AGlobal.ExecSQL(Str);
  Result:=True;
end;

procedure TRigths.InitClass;
var Str:string;
begin
  inherited;
  KeyFields:='COMP_ID;UID';
  SelectSQL := 'select COMP_ID,MID,UID,UTYPE,CHK from CA_RIGHTS where UTYPE=0 and COMP_ID=:COMP_ID and UID=:UID ';
  IsSQLUpdate := True;
  Str := 'insert into CA_RIGHTS(COMP_ID,MID,UID,UTYPE,CHK,COMM,TIME_STAMP) '
    + 'VALUES(:COMP_ID,:MID,:UID,:UTYPE,:CHK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add('', Str);
  Str:='update CA_RIGHTS set COMP_ID=:COMP_ID,MID=:MID,UID=:UID,UTYPE=0,CHK=:CHK,'
  + 'COMM=' + GetCommStr(iDbType) + ','
  + 'TIME_STAMP='+GetTimeStamp(iDbType)
  + 'where COMP_ID=:OLD_COMP_ID and UID=:OLD_UID  and UTYPE=0 and MID=:OLD_MID';
  UpdateSQL.Add('',Str);
  case iDbType of
  0:Str := 'delete CA_RIGHTS where  COMP_ID=:COMP_ID and UID=:UID  and UTYPE=0 and MID=:MID';
  3:Str := 'delete from CA_RIGHTS where  COMP_ID=:COMP_ID and UID=:UID and UTYPE=0 and MID=:MID';
  end;
  DeleteSQL.Add('', Str);
end;

initialization
  RegisterClass(TRigths);
finalization
  UnRegisterClass(TRigths);
end.
