unit uCommand;

interface
uses
  Windows, Messages, Forms, SysUtils, Classes,ZDataSet,ZBase,ObjCommon;

type
  TCommandPush=class
  private
    Ds: TZQuery;
    FCommandType: Integer;
    FCommandText: String;
    FCommandStatus: Integer;
    procedure SetCommandStatus(const Value: Integer);
    procedure GetCommandType;
    procedure SetCommandText(const Value: String);
    procedure SetCommandType(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ExecuteCommand;
    property CommandStatus: Integer read FCommandStatus write SetCommandStatus;
    property CommandType: Integer read FCommandType write SetCommandType;
    property CommandText: String read FCommandText write SetCommandText;
  end;

var CommandPush:TCommandPush;
  
implementation
uses uShopGlobal,uGlobal;
{ TCommandPush }

constructor TCommandPush.Create;
begin
  FCommandType := 0;
  FCommandText := '';
  FCommandStatus := 0;
  Ds := TZQuery.Create(nil);
end;

destructor TCommandPush.Destroy;
begin
  inherited;
end;

procedure TCommandPush.ExecuteCommand;
begin
  GetCommandType;
  if FCommandType <> 1 then Exit;     //目前只执行 SQL 语句
  if FCommandStatus <> 1 then Exit;

  case FCommandType of
    1:begin
      try
        Global.LocalFactory.ExecSQL(FCommandText);
      except
        Raise Exception.Create('指令类型 1 执行失败!');
      end;
    end;
    2:begin
      try
        //Global.LocalFactory.ExecSQL(FCommandText);
      except
        Raise Exception.Create('指令类型 2 执行失败!');
      end;
    end;
    3:begin
      try
        //Global.LocalFactory.ExecSQL(FCommandText);
      except
        Raise Exception.Create('指令类型 3 执行失败!');
      end;
    end;
  end;
  try
    Global.RemoteFactory.ExecSQL('update SYS_COMMAND set COMMAND_STATUS=''2'' where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID));
  except
    Raise;
  end;
end;

procedure TCommandPush.GetCommandType;
begin
  Ds.Close;
  Ds.SQL.Text := 'select * from SYS_COMMAND where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID);
  Global.RemoteFactory.Open(Ds);
  if not Ds.IsEmpty then
    begin
      FCommandType := Ds.FieldbyName('COMMAND_TYPE').AsInteger;
      FCommandText := Ds.FieldbyName('COMMAND_TEXT').AsString;
      FCommandStatus := Ds.FieldbyName('COMMAND_STATUS').AsInteger;
    end;
end;

procedure TCommandPush.SetCommandStatus(const Value: Integer);
begin
  FCommandStatus := Value;
end;

procedure TCommandPush.SetCommandText(const Value: String);
begin
  FCommandText := Value;
end;

procedure TCommandPush.SetCommandType(const Value: Integer);
begin
  FCommandType := Value;
end;

initialization
  CommandPush := TCommandPush.Create;
finalization
  CommandPush.Free;
end.
