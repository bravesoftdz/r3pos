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
uses uShopGlobal,uGlobal,ZLogFile,uMsgBox,ufrmLogo;
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
  if not Global.RemoteFactory.Connected then Exit;
  frmLogo.Show;
  try
  frmLogo.ShowTitle := '正在执行远程指令...';
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
    on E:Exception do
       begin
          Global.RemoteFactory.RollbackTrans;
          Global.LocalFactory.RollbackTrans;
          LogFile.AddLogFile(0,Str_Sql+' 错误原因:'+E.Message);
          frmLogo.Close;
          ShowMsgBox('服务端的异常处理指令失败了，请联系客服人员','友情提示...',MB_OK+MB_ICONINFORMATION);
       end;
  end;
  finally
    frmLogo.Close;
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
