unit uCommand;

interface
uses
  Windows, Messages, Forms, SysUtils, Classes,ZDataSet,ZBase,ObjCommon;

type
  TCommandPush=class
  private
    List: TZQuery;
    procedure GetCommandType;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ExecuteCommand;
  end;

var CommandPush:TCommandPush;
  
implementation
uses udataFactory,uTokenFactory;
{ TCommandPush }

constructor TCommandPush.Create;
begin
  List := TZQuery.Create(nil);
end;

destructor TCommandPush.Destroy;
begin
  List.Free;
  inherited;
end;

procedure TCommandPush.ExecuteCommand;
var Str_Sql: String;
begin
  if not token.online then Exit;
  if token.tenantId='' then Exit;
  GetCommandType;
  if List.IsEmpty then Exit;
  try
    List.First;
    while not List.Eof do
    begin
      case List.FieldByName('COMMAND_TYPE').AsInteger of
      1:begin
          Str_Sql := List.FieldbyName('COMMAND_TEXT').AsString;
          Str_Sql := stringreplace(Str_Sql,':TENANT_ID',token.tenantId,[rfReplaceAll]);
          Str_Sql := stringreplace(Str_Sql,':SHOP_ID',''''+token.shopId+'''',[rfReplaceAll]);
          dataFactory.MoveToSqlite;
          try
            dataFactory.ExecSQL(Str_Sql);
            dataFactory.MoveToRemote;
            dataFactory.ExecSQL('update SYS_COMMAND set COMMAND_STATUS=''2'' where ROWS_ID='+QuotedStr(List.FieldbyName('ROWS_ID').AsString));
          finally
            dataFactory.MoveToDefault;
          end;
        end;
      end;
      List.Next;
    end;
  except
  end;
end;

procedure TCommandPush.GetCommandType;
begin
  List.Close;
  List.SQL.Text := 'select * from SYS_COMMAND where COMMAND_STATUS=''1'' and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
  List.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  List.ParamByName('SHOP_ID').AsString := token.shopId;
  dataFactory.MoveToRemote;
  try
    dataFactory.Open(List);
  finally
    dataFactory.MoveToDefault;
  end;
end;

initialization
  CommandPush := TCommandPush.Create;
finalization
  CommandPush.Free;
end.
