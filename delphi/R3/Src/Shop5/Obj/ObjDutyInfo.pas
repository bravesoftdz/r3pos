
unit ObjDutyInfo;

interface

uses
  Dialogs,SysUtils,zBase,Classes, zDataSet,ZIntf,ObjCommon;

type
  TGetSQL=class
  public
    class function GetUpdateDutyTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
  end;

type
  TDutyInfo=class(TZFactory)
  public
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean; override;
    procedure InitClass;override;
  end;

  {== 删除处理 ==}
  TDutyInfoDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

  {== 树型中同一级职务排序 ==}
  TDutyInfoSort=class(TZProcFactory)
  private
    function GetMoveNodeData(var zQuery: TZQuery; AGlobal:IdbHelp; Params:TftParamList): Boolean;
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation


{ TGetSQL }

class function TGetSQL.GetUpdateDutyTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
var
  OldIDLen,SQL,OperChar: string;
begin
  Result:='';
  OperChar:=GetStrJoin(iDbType);
  if OldLEVEL_ID='' then
    OldIDLen:='0'
  else
    OldIDLen:=InttoStr(Length(OldLEVEL_ID));
  SQL:='update CA_DUTY_INFO Set LEVEL_ID=:LEVEL_ID '+OperChar+' ifnull(substr(LEVEL_ID,'+OldIDLen+'+1,length(LEVEL_ID)-'+OldIDLen+'),'''') '+
       ' where TENANT_ID=:TENANT_ID and substr(LEVEL_ID,1,'+OldIDLen+')=:OLD_LEVEL_ID ';
  Result:=ParseSQL(iDbType,SQL);
end;

{ TDutyInfo }

function TDutyInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('LEVEL_ID').AsString)<>trim(FieldbyName('LEVEL_ID').AsOldString) then
  begin
    Str:=TGetSQL.GetUpdateDutyTreeSQL(iDbType,trim(FieldbyName('LEVEL_ID').AsOldString));
    if Str<>'' then
      AGlobal.ExecSQL(Str,self);
  end;
end;

procedure TDutyInfo.InitClass;
var
  Str:string;
begin
  //初始化更新逻辑
  Str:='select DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,substr(LEVEL_ID,1,Length(LEVEL_ID)-3) as UPDUTY_ID '+
       ' From CA_DUTY_INFO Where TENANT_ID=:TENANT_ID and DUTY_ID=:DUTY_ID ';
  SelectSQL.Text:=ParseSQL(iDbType,Str);

  Str :='insert into CA_DUTY_INFO (DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,COMM,TIME_STAMP) '+
        ' values (:DUTY_ID,:DUTY_NAME,:LEVEL_ID,:DUTY_SPELL,:TENANT_ID,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);

  Str :='update CA_DUTY_INFO set DUTY_ID=:DUTY_ID,DUTY_NAME=:DUTY_NAME,DUTY_SPELL=:DUTY_SPELL,REMARK=:REMARK,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        '  where TENANT_ID=:OLD_TENANT_ID and DUTY_ID=:OLD_DUTY_ID';
  UpdateSQL.Add(Str);

  Str := 'update CA_DUTY_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and DUTY_ID=:OLD_DUTY_ID';
  DeleteSQL.Add(Str);
end;

{ TDutyInfoDelete }

function TDutyInfoDelete.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  tmp: TZQuery;
  Str,vLen,OperChar: string;
begin
  Result:=False;
  OperChar:=GetStrJoin(AGlobal.iDbType); //字符连接操作符: +、||
  AGlobal.BeginTrans;
  try
    tmp:=TZQuery.Create(nil);
    try
      vLen:=InttoStr(Length(Params.ParamByName('LEVEL_ID').asString));
      Str:=GetLikeCnd(AGlobal.iDbType,'LEVEL_ID',':LEVEL_ID','','R');  // 返回: (LEVEL_ID like :LEVEL_ID+''%'')
      Str:='Select Count(*) as ReSum From CA_DUTY_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and ('+Str+' and (length(LEVEL_ID)>'+vLen+')) ';
      Str:=ParseSQL(AGlobal.iDbType,Str); //函数转换处理
      tmp.Close;
      tmp.SQL.Text:=Str;
      if Params<>nil then tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('职务'+Params.ParamByName('DUTY_NAME').asString+'有下级职务不能删除！');

      str:=' and '','''+OperChar+'DUTY_IDS'+OperChar+''','' Like ''%,'''+OperChar+':DUTY_ID '+OperChar+''',%'' ';   //' '',''+DUTY_IDS+'','' Like ''%,''+:DUTY_ID+'',%'' ';
      Str:='Select Count(*) as ReSum From CA_USERS where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+str;
      tmp.Close;
      tmp.SQL.Text:=Str;
      if Params<>nil then tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('职务'+Params.ParamByName('DUTY_NAME').asString+'有用户使用不能删除！');

      Str:='Update CA_DUTY_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
           ' where TENANT_ID=:TENANT_ID and DUTY_ID=:DUTY_ID ';
      AGlobal.ExecSQL(Str,Params);  //Params参数是从前台传入
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

{ TDutyInfoSort }

function TDutyInfoSort.GetMoveNodeData(var zQuery: TZQuery; AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Str,vlen,MoveKind: string;
begin
  result:=False;
  vlen:=InttoStr(Length(Params.ParamByName('LEVEL_ID').AsString));
  MoveKind:=trim(UpperCase(Params.ParamByName('movekind').AsString));
  if (MoveKind='FIRST') or (MoveKind='PRIOR') then
    Str:='Select LEVEL_ID From CA_DUTY_INFO Where TENANT_ID=:TENANT_ID and LEVEL_ID<:LEVEL_ID and length(LEVEL_ID)='+vlen // +' order by LEVEL_ID desc '
  else
    Str:='Select LEVEL_ID From CA_DUTY_INFO Where TENANT_ID=:TENANT_ID and LEVEL_ID>:LEVEL_ID and length(LEVEL_ID)='+vlen; // +' order by LEVEL_ID  ';
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


function TDutyInfoSort.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Qry: TZQuery;
  Str,FirstLEVEL_ID,LevelID: string;
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
      Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,LevelID);
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
        Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,Qry.FieldByName('LEVEL_ID').AsString);
        AGlobal.ExecSQL(Str,UpParams);
        UpParams.ParamByName('LEVEL_ID').AsString:=trim(Qry.fieldbyName('LEVEL_ID').AsString); //把 传入的LevelID 作为: NewLevel_ID [新值作为更新值]
        Qry.Next;
      end;

      {=== 第三步:  “_”开头的给改正确  ===}
      UpParams.ParamByName('OLD_LEVEL_ID').AsString:='_'+LevelID;
      Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,'_'+LevelID);
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


initialization
  RegisterClass(TDutyInfo);
  RegisterClass(TDutyInfoDelete);
  RegisterClass(TDutyInfoSort);
finalization
  UnRegisterClass(TDutyInfo);
  UnRegisterClass(TDutyInfoDelete);
  UnRegisterClass(TDutyInfoSort);
end.
