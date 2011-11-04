unit ObjChatInfo;

interface
uses SysUtils,ZBase,Classes, ZIntf,ObjCommon,ZDataset;

type
  TmqqGrouping = class(TZFactory)
  private
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TmqqFriends = class(TZFactory)
  private
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;


implementation

{ TmqqGrouping }

function TmqqGrouping.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from MQQ_GROUPING where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString);
end;

procedure TmqqGrouping.InitClass;
begin
  inherited;
  SelectSQL.Text := 'select * from MQQ_GROUPING where TENANT_ID=:TENANT_ID order by SEQ_NO';
  isSQLUpdate := true;
  InsertSQL.Text := 'insert into MQQ_GROUPING(TENANT_ID,S_GROUP_ID,G_USER_ID,I_SHOW_NAME,I_GROUP_NAME,SEQ_NO) values(:TENANT_ID,:S_GROUP_ID,:G_USER_ID,:I_SHOW_NAME,:I_GROUP_NAME,:SEQ_NO)';
end;

{ TmqqFriends }

function TmqqFriends.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from MQQ_FRIENDS where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString);
end;

procedure TmqqFriends.InitClass;
begin
  inherited;
  SelectSQL.Text := 'select * from MQQ_FRIENDS where TENANT_ID=:TENANT_ID order by SEQ_NO';
  isSQLUpdate := true;
  InsertSQL.Text :=
    'insert into MQQ_FRIENDS(TENANT_ID,F_USER_ID,FRIEND_ID,FRIEND_NAME,IS_BE_BLACK,S_GROUP_ID,NOTE,U_SHOW_NAME,IS_ONLINE,REF_ID,USER_TYPE,SEQ_NO) '+
    'values(:TENANT_ID,:F_USER_ID,:FRIEND_ID,:FRIEND_NAME,:IS_BE_BLACK,:S_GROUP_ID,:NOTE,:U_SHOW_NAME,:IS_ONLINE,:REF_ID,:USER_TYPE,:SEQ_NO)';
end;

initialization
  RegisterClass(TmqqGrouping);
  RegisterClass(TmqqFriends);
finalization
  UnRegisterClass(TmqqGrouping);
  UnRegisterClass(TmqqFriends);
end.
