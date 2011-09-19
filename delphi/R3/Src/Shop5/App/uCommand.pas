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
var rs:TZQuery;
begin
  GetCommandType;
  if List.IsEmpty then Exit;

  rs := TZQuery.Create(nil);
  try
    Global.LocalFactory.BeginTrans;
    Global.RemoteFactory.BeginTrans;
    try
      List.First;
      while not List.Eof do
      begin
        if List.FieldByName('COMMAND_STATUS').AsInteger = 1 then
        begin
          rs.Close;
          rs.SQL.Text := List.FieldbyName('COMMAND_TEXT').AsString;
          if rs.Params.FindParam('TENANT_ID') <> nil then rs.Params.ParamByName('TENANT_ID').AsInteger := ShopGlobal.TENANT_ID;
          if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := ShopGlobal.SHOP_ID;
          Global.LocalFactory.UpdateBatch(rs);
        end;
      end;
      Global.RemoteFactory.ExecSQL('update SYS_COMMAND set COMMAND_STATUS=''2'' where COMMAND_TYPE=''1'' and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID));
      Global.LocalFactory.CommitTrans;
      Global.RemoteFactory.CommitTrans;
    except
      Global.LocalFactory.RollbackTrans;
      Global.RemoteFactory.RollbackTrans;
      Raise;
    end;
  finally
    rs.Free;
  end;

end;

procedure TCommandPush.GetCommandType;
begin
  List.Close;
  List.SQL.Text := 'select * from SYS_COMMAND where COMMAND_TYPE=''1'' and TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+' and SHOP_ID='+QuotedStr(ShopGlobal.SHOP_ID);
  Global.RemoteFactory.Open(List);
end;

initialization
  CommandPush := TCommandPush.Create;
finalization
  CommandPush.Free;
end.
