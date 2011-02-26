unit ObjDeptInfo;

interface

uses
  Dialogs,SysUtils,zBase,Classes, zDataSet,ZIntf,ObjCommon;

type
  TGetSQL=class
  public
    class function GetUpdateDeptTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
  end;

type
  TDeptInfo=class(TZFactory)
  public
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean; override;
    procedure InitClass;override;
  end;

  {== 删除处理 ==}
  TDeptInfoDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

  {== 树型中同一级职务排序 ==}
  TDeptInfoSort=class(TZProcFactory)
  private
    function GetMoveNodeData(var zQuery: TZQuery; AGlobal:IdbHelp; Params:TftParamList): Boolean;
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation


{ TGetSQL }

class function TGetSQL.GetUpdateDeptTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
var
  OldIDLen, SQL, OperChar: string; {==旧值的长度==}
begin
  Result:='';
  OperChar:=GetStrJoin(iDbType);
  if OldLEVEL_ID='' then OldIDLen:='0'
  else OldIDLen:=InttoStr(Length(OldLEVEL_ID));

  SQL:='update CA_DEPT_INFO Set LEVEL_ID=:LEVEL_ID '+OperChar+' ifnull(substr(LEVEL_ID,'+OldIDLen+'+1,length(LEVEL_ID)-'+OldIDLen+'),'''') '+
       ' where TENANT_ID=:TENANT_ID and substr(LEVEL_ID,1,'+OldIDLen+')=:OLD_LEVEL_ID ';
  Result:=ParseSQL(iDbType,SQL);
end;

{ TDeptInfo }

function TDeptInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('LEVEL_ID').AsString)<>trim(FieldbyName('LEVEL_ID').AsOldString) then
  begin
    Str:=TGetSQL.GetUpdateDeptTreeSQL(iDbType,trim(FieldbyName('LEVEL_ID').AsOldString)); 
    if Str<>'' then 
      AGlobal.ExecSQL(Str,self);
  end;
end;

procedure TDeptInfo.InitClass;
var
  Str:string;
begin
  //初始化更新逻辑
  KeyFields:='DEPT_ID';
  //初始化查询
  case iDbType of
   0:   Str:='select DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SEQ_NO,SubString(LEVEL_ID,1,Len(LEVEL_ID)-3) as UPDEPT_ID '+
          ' From CA_DEPT_INFO Where TENANT_ID=:TENANT_ID and DEPT_ID=:DEPT_ID ';
   4,5: Str:='select DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SEQ_NO,SubStr(LEVEL_ID,1,Length(LEVEL_ID)-3) as UPDEPT_ID '+
          ' From CA_DEPT_INFO Where TENANT_ID=:TENANT_ID and DEPT_ID=:DEPT_ID ';
  end;
  selectSQL.Text:=Str;
  Str :='insert into CA_DEPT_INFO (DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SEQ_NO,COMM,TIME_STAMP) '+
        ' values (:DEPT_ID,:DEPT_NAME,:LEVEL_ID,:DEPT_SPELL,:TENANT_ID,:TELEPHONE,:LINKMAN,:FAXES,:REMARK,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';

  IsSQLUpdate := true;
  InsertSQL.Add(Str);

  Str :='update CA_DEPT_INFO set DEPT_ID=:DEPT_ID,DEPT_NAME=:DEPT_NAME,DEPT_SPELL=:DEPT_SPELL,'+
        ' TELEPHONE=:TELEPHONE,LINKMAN=:LINKMAN,FAXES=:FAXES,REMARK=:REMARK,SEQ_NO=:SEQ_NO,'+
        ' COMM='+ GetCommStr(iDbType)+','+ 'TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and DEPT_ID=:OLD_DEPT_ID';
  UpdateSQL.Add(Str);

  Str := 'update CA_DEPT_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and DEPT_ID=:OLD_DEPT_ID';
  DeleteSQL.Add(Str);
end;

{ TDeptInfoDelete }

function TDeptInfoDelete.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  tmp: TZQuery;
  Str,vLen: string;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    tmp:=TZQuery.Create(nil);
    try
      vLen:=InttoStr(Length(Params.ParamByName('LEVEL_ID').asString));
      case AGlobal.iDbType of
       0  : Str:=' and ((LEVEL_ID like :LEVEL_ID + ''%'') and (length(LEVEL_ID)>'+vLen+')) ';
       4,5: Str:=' and ((LEVEL_ID like :LEVEL_ID ||''%'') and (length(LEVEL_ID)>'+vLen+')) ';
      end;
      tmp.Close;
      tmp.SQL.Text:='select Count(*) as ReSum From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Str;
      if Params<>nil then tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('部门'+Params.ParamByName('DEPT_NAME').asString+'有下级部门不能删除！');
      tmp.Close;                             
      tmp.SQL.Text:='select count(*) as RESUM from CA_USERS where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and DEPT_ID=:DEPT_ID ';
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('部门'+Params.ParamByName('DEPT_NAME').asString+'有用户使用不能删除！');

      Str:='Update CA_DEPT_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID=:TENANT_ID and DEPT_ID=:DEPT_ID ';
      AGlobal.ExecSQL(Str,Params);
      AGlobal.CommitTrans;
    finally
      tmp.Free;
    end;
    Result:=True;
  except
    on E:Exception do
    begin
      Msg := E.Message;
      AGlobal.RollBackTrans;
    end;
  end;
end;

{ TDeptInfoSort }

function TDeptInfoSort.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Qry: TZQuery;
  Str, LevelID: string;
  UpParams: TftParamList;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    try
      Qry:=TZQuery.Create(nil);
      UpParams:=TftParamList.Create(nil);
      GetMoveNodeData(Qry, AGlobal,Params);
      if not Qry.Active then Exit;
      if Qry.RecordCount=0 then Exit;

      {=== 第一步:  先将当前传入的记录给设置成: _开头的  ===}
      LevelID:=trim(Params.ParamByName('LEVEL_ID').AsString);  
      Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,LevelID);
      UpParams.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger; //企业ID
      UpParams.ParamByName('LEVEL_ID').AsString:='_'+LevelID;  //NewLevel_ID [新值作为更新值]
      UpParams.ParamByName('OLD_LEVEL_ID').AsString:=LevelID;  //OLDLevel_ID [原值作为条件]
      AGlobal.ExecSQL(Str,UpParams);

      {=== 第二步:  循环执行[] ===}
      UpParams.ParamByName('LEVEL_ID').AsString:=LevelID;  //把 传入的LevelID 作为: NewLevel_ID [新值作为更新值]
      Qry.First;
      while not Qry.Eof do
      begin
        UpParams.ParamByName('OLD_LEVEL_ID').AsString:=trim(Qry.fieldbyName('LEVEL_ID').AsString); //OLDLevel_ID [原值作为条件]
        Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,Qry.FieldByName('LEVEL_ID').AsString);
        AGlobal.ExecSQL(Str,UpParams);
        UpParams.ParamByName('LEVEL_ID').AsString:=trim(Qry.fieldbyName('LEVEL_ID').AsString); //把 传入的LevelID 作为: NewLevel_ID [新值作为更新值]
        Qry.Next;
      end;

      {=== 第三步:  “_”开头的给改正确  ===}
      UpParams.ParamByName('OLD_LEVEL_ID').AsString:='_'+LevelID;
      Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,'_'+LevelID);
      AGlobal.ExecSQL(Str,UpParams);  
      AGlobal.CommitTrans;
      Result:=true;
    finally
      UpParams.Free;
      Qry.Free;
    end;
  except
    on E:Exception do
    begin
      Msg := E.Message;
      AGlobal.RollBackTrans;
    end;
  end;
end;

function TDeptInfoSort.GetMoveNodeData(var zQuery: TZQuery; AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Str,vlen,MoveKind: string;
begin
  result:=False;
  vlen:=InttoStr(Length(Params.ParamByName('LEVEL_ID').AsString));
  MoveKind:=trim(UpperCase(Params.ParamByName('movekind').AsString));
  if (MoveKind='FIRST') or (MoveKind='PRIOR') then
    Str:='Select LEVEL_ID From CA_DEPT_INFO Where TENANT_ID=:TENANT_ID and LEVEL_ID<:LEVEL_ID and length(LEVEL_ID)='+vlen // +' order by LEVEL_ID desc '
  else
    Str:='Select LEVEL_ID From CA_DEPT_INFO Where TENANT_ID=:TENANT_ID and LEVEL_ID>:LEVEL_ID and length(LEVEL_ID)='+vlen; // +' order by LEVEL_ID  ';
  str:=ParseSQL(AGlobal.iDbType,Str); //SQL函数转换

  if MoveKind='FIRST' then
    str:=str+' order by LEVEL_ID desc '
  else if MoveKind='PRIOR' then
    str:=GetBatchSQL(AGlobal.iDbType, str, 'LEVEL_ID', 'desc', '1')
  else if MoveKind='NEXT' then
    str:=GetBatchSQL(AGlobal.iDbType, str, 'LEVEL_ID', 'asc', '1')
  else if MoveKind='LAST' then
    str:=str+' order by LEVEL_ID asc ';

  zQuery.Close;
  zQuery.SQL.Text:=Str;
  zQuery.Params.AssignValues(Params);
  AGlobal.Open(zQuery);
  result:=zQuery.Active;
end;

initialization
  RegisterClass(TDeptInfo);
  RegisterClass(TDeptInfoDelete);
  RegisterClass(TDeptInfoSort);
finalization
  UnRegisterClass(TDeptInfo);
  UnRegisterClass(TDeptInfoDelete);
  UnRegisterClass(TDeptInfoSort);
end.
