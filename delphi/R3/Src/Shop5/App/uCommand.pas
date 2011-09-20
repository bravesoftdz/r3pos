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
uses uShopGlobal,uGlobal;
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
  GetCommandType;
  if List.IsEmpty then Exit;

  Global.LocalFactory.BeginTrans;
  Global.RemoteFactory.BeginTrans;
  try
    List.First;
    while not List.Eof do
    begin
      case List.FieldByName('COMMAND_TYPE').AsInteger of
      1:begin
          Str_Sql := List.FieldbyName('COMMAND_TEXT').AsString;
          Str_Sql := stringreplace(Str_Sql,':TENANT_ID',inttostr(Global.TENANT_ID),[rfReplaceAll]);
          Str_Sql := stringreplace(Str_Sql,':SHOP_ID',Global.SHOP_ID,[rfReplaceAll]);
          Global.LocalFactory.ExecSQL(Str_Sql);
          Global.RemoteFactory.ExecSQL('update SYS_COMMAND set COMMAND_STATUS=''2'' where ROWS_ID='+QuotedStr(List.FieldbyName('ROWS_ID').AsString));
        end;
      end;
      List.Next;
    end;
    Global.RemoteFactory.CommitTrans;
    Global.LocalFactory.CommitTrans;
  except
    Global.RemoteFactory.RollbackTrans;
    Global.LocalFactory.RollbackTrans;
    Raise;
  end;

end;

procedure TCommandPush.GetCommandType;
begin
  List.Close;
  List.SQL.Text := 'select * from SYS_COMMAND where COMMAND_STATUS=''1'' and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
  List.ParamByName('TENANT_ID').AsInteger := ShopGlobal.TENANT_ID;
  List.ParamByName('SHOP_ID').AsString := ShopGlobal.SHOP_ID;
  Global.RemoteFactory.Open(List);
end;

initialization
  CommandPush := TCommandPush.Create;
finalization
  CommandPush.Free;
end.
