unit ObjSysDefineV60;

interface

uses SysUtils, ZBase, Classes, zIntf,ObjCommon, zDataSet;

type

  TSysDefineV60 = class(TZFactory)
  private
    procedure InitClass; override;
    function BeforeDeleteRecord(AGlobal: IdbHelp): Boolean; override;
    function BeforeInsertRecord(AGlobal: IdbHelp): Boolean; override;
    function BeforeModifyRecord(AGlobal: IdbHelp): Boolean; override;
  end;

  TSysFastFileV60 = class(TZFactory)
  public
    procedure InitClass; override;
  end;

implementation

uses udllFnUtil;

function TSysDefineV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TSysDefineV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TSysDefineV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  if (FieldbyName('DEFINE').AsString = 'USING_DATE') and (FieldbyName('VALUE').AsOldString <> FieldbyName('VALUE').AsString) then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.SQL.Text := 'select min(CREA_DATE) from VIW_GOODS_DAYS where TENANT_ID=:TENANT_ID and CREA_DATE<=:CREA_DATE';
      rs.parambyName('TENANT_ID').asInteger := FieldbyName('TENANT_ID').asInteger;
      rs.parambyName('CREA_DATE').asInteger := StrtoInt(formatDatetime('YYYYMMDD',udllFnUtil.FnTime.fnStrtoDate(FieldbyName('VALUE').AsString)));
      AGlobal.Open(rs);
      if rs.Fields[0].AsString <> '' then
         Raise Exception.Create('系统参数的启用日期不能大于['+rs.Fields[0].AsString+']日');
    finally
      rs.Free;
    end;
  end;
  result := true;
end;

procedure TSysDefineV60.InitClass;
var Str,l,r: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;DEFINE';

  IsSQLUpdate := True;
  case iDbType of
  0,3:begin l:='[';r:=']';end;
  1:begin l:='"';r:='"';end;
  else
    begin
      l:='"';r:='"';
    end;
  end;

  Str := 'select TENANT_ID,DEFINE,'+l+'VALUE'+r+',VALUE_TYPE from SYS_DEFINE where TENANT_ID=:TENANT_ID';
  SelectSQL.Text := Str;

  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,'+l+'VALUE'+r+',VALUE_TYPE,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:DEFINE,:VALUE,:VALUE_TYPE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update SYS_DEFINE set TENANT_ID=:TENANT_ID,DEFINE=:DEFINE,'+l+'VALUE'+r+'=:VALUE,VALUE_TYPE=:VALUE_TYPE,'+
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and DEFINE=:OLD_DEFINE';
  UpdateSQL.Text := Str;

  Str := 'delete from SYS_DEFINE where TENANT_ID=:OLD_TENANT_ID and DEFINE=:OLD_DEFINE';
  DeleteSQL.Text := Str;
end;

procedure TSysFastFileV60.InitClass;
var
  Str:string;
begin
  inherited;
  Str := 'insert into SYS_FASTFILE(TENANT_ID,frfFileName,frfFileTitle,frfBlob,frfDefault,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:frfFileName,:frfFileTitle,:frfBlob,:frfDefault,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update SYS_FASTFILE set TENANT_ID=:TENANT_ID,frfFileName=:frfFileName,frfFileTitle=:frfFileTitle,frfBlob=:frfBlob,frfDefault=:frfDefault,'+
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and frfFileName=:OLD_frfFileName';
  UpdateSQL.Text := Str;
end;

initialization
  RegisterClass(TSysDefineV60);
  RegisterClass(TSysFastFileV60);
finalization
  UnRegisterClass(TSysDefineV60);
  UnRegisterClass(TSysFastFileV60);
end.

