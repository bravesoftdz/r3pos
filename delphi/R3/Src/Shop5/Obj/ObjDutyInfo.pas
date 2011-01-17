
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
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation


{ TGetSQL }

class function TGetSQL.GetUpdateDutyTreeSQL(iDbType: Integer; OldLEVEL_ID: string): string;
var
  OldIDLen: string;
begin
  Result:='';
  if OldLEVEL_ID='' then OldIDLen:='0'
  else OldIDLen:=InttoStr(Length(OldLEVEL_ID));  

  case iDbType of
    0: Result:='Update CA_DUTY_INFO Set LEVEL_ID=:LEVEL_ID + SubString(LEVEL_ID,'+OldIDLen+'+1,100) '+
          ' Where TENANT_ID=:OLD_TENANT_ID and Left(LEVEL_ID,'+OldIDLen+')=:OLD_LEVEL_ID ';
    5: Result:='Update CA_DUTY_INFO Set LEVEL_ID=:LEVEL_ID || SubStr(LEVEL_ID,'+OldIDLen+'+1,100) '+
         ' Where TENANT_ID=:OLD_TENANT_ID and SubStr(LEVEL_ID,1,'+OldIDLen+')=:OLD_LEVEL_ID ';
  end;
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
  IsSQLUpdate := true;
  KeyFields:='DUTY_ID';
  //初始化查询
  case iDbType of
   0:Str:='select DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,SubString(LEVEL_ID,1,Len(LEVEL_ID)-3) as UPDUTY_ID '+
          ' From CA_DUTY_INFO Where TENANT_ID=:TENANT_ID and DUTY_ID=:DUTY_ID ';
   5:Str:='select DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,SubStr(LEVEL_ID,1,Length(LEVEL_ID)-3) as UPDUTY_ID '+
          ' From CA_DUTY_INFO Where TENANT_ID=:TENANT_ID and DUTY_ID=:DUTY_ID ';
  end; 
  SelectSQL.Text:=Str;
  Str :='insert into CA_DUTY_INFO (DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,COMM,TIME_STAMP) '+
        ' values (:DUTY_ID,:DUTY_NAME,:LEVEL_ID,:DUTY_SPELL,:TENANT_ID,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);

  Str :='update CA_DUTY_INFO set DUTY_ID=:DUTY_ID,DUTY_NAME=:DUTY_NAME,DUTY_SPELL=:DUTY_SPELL,'+
        'REMARK=:REMARK,COMM='+ GetCommStr(iDbType)+','+ 'TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and DUTY_ID=:OLD_DUTY_ID';
  UpdateSQL.Add(Str);

  Str := 'update CA_DUTY_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and DUTY_ID=:OLD_DUTY_ID';
  DeleteSQL.Add(Str);
end;

{ TDutyInfoDelete }

function TDutyInfoDelete.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
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
      tmp.Close;
      tmp.SQL.Text:='Select Count(*) as ReSum From CA_DUTY_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and ((LEVEL_ID like :LEVEL_ID+''%'') and (length(LEVEL_ID)>'+vLen+')) ';
      if Params<>nil then
        tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('职务'+Params.ParamByName('DUTY_NAME').asString+'有下级职务不能删除！');
      tmp.Close;
      tmp.SQL.Text:='Select Count(*) as ReSum From CA_USERS where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and '+
           ' '';''+DUTY_IDS+'';'' Like '';''+:DUTY_ID+'';'' ';
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('职务'+Params.ParamByName('DUTY_NAME').asString+'有用户使用不能删除！');

      Str:='Update CA_DUTY_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
           ' where TENANT_ID=:TENANT_ID and DUTY_ID=:DUTY_ID ';
      AGlobal.ExecSQL(Str);
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

function TDutyInfoSort.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Qry: TZQuery;
  Str,vlen,MoveKind,FirstLEVEL_ID: string;
 begin
  Result:=False;   
  vlen:=InttoStr(Length(Params.ParamByName('OLD_LEVEL_ID').AsString));
  MoveKind:=trim(UpperCase(Params.ParamByName('movekind').AsString));
  if (MoveKind='FIRST') or (MoveKind='PRIOR') then
    Str:='Select LEVEL_ID From CA_DUTY_INFO Where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID<:OLD_LEVEL_ID and Length(LEVEL_ID)='+vlen+' Order by LEVEL_ID Desc '
  else
    Str:='Select LEVEL_ID From CA_DUTY_INFO Where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID>:OLD_LEVEL_ID and Length(LEVEL_ID)='+vlen+' Order by LEVEL_ID  ';

  if(MoveKind='NEXT') or (MoveKind='PRIOR') then
    Str:=Str+' limit 2 ';

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
      //先将当前的选中的记录给设置成: _开头的
      FirstLEVEL_ID:=trim(Params.ParamByName('LEVEL_ID').AsString);
      Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,Params.ParamByName('OLD_LEVEL_ID').AsString);
      AGlobal.ExecSQL(Str,Params);
      //循环执行
      Params.ParamByName('LEVEL_ID').Value:=Params.ParamByName('OLD_LEVEL_ID').Value;
      while not Qry.Eof do
      begin
        Params.ParamByName('OLD_LEVEL_ID').Value:=Qry.fieldbyName('LEVEL_ID').Value;
        Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,Qry.FieldByName('LEVEL_ID').AsString);
        AGlobal.ExecSQL(Str,Params);
        Qry.Next;
      end;
      //把刚才修改“_”开头的给改正确
      Params.ParamByName('LEVEL_ID').AsString:=Params.ParamByName('OLD_LEVEL_ID').AsString;
      Params.ParamByName('OLD_LEVEL_ID').AsString:=FirstLEVEL_ID;
      Str:=TGetSQL.GetUpdateDutyTreeSQL(AGlobal.iDbType,FirstLEVEL_ID);
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
  RegisterClass(TDutyInfo);
  RegisterClass(TDutyInfoDelete);
  RegisterClass(TDutyInfoSort);
finalization
  UnRegisterClass(TDutyInfo);
  UnRegisterClass(TDutyInfoDelete);
  UnRegisterClass(TDutyInfoSort);
end.
