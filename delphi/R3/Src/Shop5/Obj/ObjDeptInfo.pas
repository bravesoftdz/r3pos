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
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation


{ TGetSQL }

class function TGetSQL.GetUpdateDeptTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
var
  OldIDLen: string; {==旧值的长度==}
begin
  Result:='';
  if OldLEVEL_ID='' then OldIDLen:='0'
  else OldIDLen:=InttoStr(Length(OldLEVEL_ID));  

  case iDbType of
   0:   Result:='Update CA_DEPT_INFO Set LEVEL_ID=:LEVEL_ID + SubString(LEVEL_ID,'+OldIDLen+'+1,100) '+
           ' Where TENANT_ID=:OLD_TENANT_ID and Left(LEVEL_ID,'+OldIDLen+')=:OLD_LEVEL_ID ';
   4,5: Result:='Update CA_DEPT_INFO Set LEVEL_ID=:LEVEL_ID || SubStr(LEVEL_ID,'+OldIDLen+'+1,100) '+
           ' Where TENANT_ID=:OLD_TENANT_ID and SubStr(LEVEL_ID,1,'+OldIDLen+')=:OLD_LEVEL_ID ';
  end;
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
  Str,TopStr,vlen,MoveKind,FirstLEVEL_ID: string;
begin
  Result:=False;
  vlen:=InttoStr(Length(Params.ParamByName('OLD_LEVEL_ID').AsString));
  MoveKind:=trim(UpperCase(Params.ParamByName('movekind').AsString));
  //查询出需要修改的树型的记录:
  case AGlobal.iDbType of
   0: //SQL Server
    begin
      if MoveKind='FIRST' then
        Str:='select LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID<:OLD_LEVEL_ID and length(LEVEL_ID)='+vlen+' order by LEVEL_ID desc '
      else if MoveKind='PRIOR' then
        Str:='select top 2 LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID<:OLD_LEVEL_ID and length(LEVEL_ID)='+vlen+' order by LEVEL_ID desc '
      else if MoveKind='NEXT' then
        Str:='select top 2 LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID>:OLD_LEVEL_ID and length(LEVEL_ID)='+vlen+' order by LEVEL_ID  '
      else if MoveKind='LAST' then
        Str:='select LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID>:OLD_LEVEL_ID and length(LEVEL_ID)='+vlen+' order by LEVEL_ID  ';
    end;
   4: //DB2
    begin
      Str:='select LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and length(LEVEL_ID)='+vlen+' ';
      if (MoveKind='FIRST') or (MoveKind='PRIOR') then Str:=Str+' LEVEL_ID<:OLD_LEVEL_ID Order by LEVEL_ID desc '
      else Str:=Str+' LEVEL_ID>:OLD_LEVEL_ID order by LEVEL_ID ';
      if(MoveKind='NEXT') or (MoveKind='PRIOR') then Str:=Str+' fetch first 2 rows only ';
    end;
   5: //SQLITE
    begin
      Str:='select LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:OLD_TENANT_ID and length(LEVEL_ID)='+vlen+' ';
      if (MoveKind='FIRST') or (MoveKind='PRIOR') then Str:=Str+' LEVEL_ID<:OLD_LEVEL_ID Order by LEVEL_ID desc '
      else Str:=Str+' LEVEL_ID>:OLD_LEVEL_ID order by LEVEL_ID ';
      if(MoveKind='NEXT') or (MoveKind='PRIOR') then Str:=Str+' limit 2 ';
    end;
  end;

  AGlobal.BeginTrans;
  try
    try
      Qry:=TZQuery.Create(nil);
      Qry.Close;
      Qry.SQL.Text:=Str;
      Qry.Params.AssignValues(Params);  
      AGlobal.Open(Qry);
      if not Qry.Active then Exit;
      if Qry.RecordCount=0 then Exit;
      {-------------------------------------------------------------------------
       说明: (1)先将当前的选中的LEVEl_ID改成：'_LEVEL_ID'
             (2)按取出数据执行循环将逐条修改上一条的LEVEL_ID;
             (3)循环结束后，将[_LEVEL_ID]改成 循环后最后一条的LEVEL_ID
       -------------------------------------------------------------------------}
      //(1)、先将当前的选中的记录给设置成: _开头的
      FirstLEVEL_ID:=trim(Params.ParamByName('LEVEL_ID').AsString);
      Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,Params.ParamByName('OLD_LEVEL_ID').AsString);
      AGlobal.ExecSQL(Str,Params);

      //(2)、循环执行[修改LVEVLEID]
      Params.ParamByName('LEVEL_ID').Value:=Params.ParamByName('OLD_LEVEL_ID').Value;
      while not Qry.Eof do
      begin
        Params.ParamByName('OLD_LEVEL_ID').Value:=Qry.fieldbyName('LEVEL_ID').Value;
        Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,Qry.FieldByName('LEVEL_ID').AsString);
        AGlobal.ExecSQL(Str,Params);
        Qry.Next;
      end;
      //(3)、把刚才修改“_”开头的给改正确
      Params.ParamByName('LEVEL_ID').AsString:=Params.ParamByName('OLD_LEVEL_ID').AsString;
      Params.ParamByName('OLD_LEVEL_ID').AsString:=FirstLEVEL_ID;
      Str:=TGetSQL.GetUpdateDeptTreeSQL(AGlobal.iDbType,FirstLEVEL_ID);
      AGlobal.ExecSQL(Str,Params);  
      AGlobal.CommitTrans;
      Result:=true;
    finally
      Qry.Free;
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

initialization
  RegisterClass(TDeptInfo);
  RegisterClass(TDeptInfoDelete);
  RegisterClass(TDeptInfoSort);
finalization
  UnRegisterClass(TDeptInfo);
  UnRegisterClass(TDeptInfoDelete);
  UnRegisterClass(TDeptInfoSort);
end.
