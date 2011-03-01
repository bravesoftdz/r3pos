unit ObjTransOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  TTransOrder = class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TTransOrderAudit = class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TTransOrderUnAudit = class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation
  
{ TTransOrder }

function TTransOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TTransOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
       if FieldbyName('GLIDE_NO').AsString='' then
          FieldbyName('GLIDE_NO').AsString := GetSequence(AGlobal,'GNO_5_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),9);
     end;
     
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:TRANS_MNY+IN_MNY,BALANCE=:TRANS_MNY+BALANCE,TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID and SHOP_ID=:SHOP_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=:TRANS_MNY+OUT_MNY,BALANCE=BALANCE-:TRANS_MNY,TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID and SHOP_ID=:SHOP_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  result := true;
end;

function TTransOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TTransOrder.InitClass;
var Str:String;
begin
  inherited;
  KeyFields := 'TENANT_ID;TRANS_ID';

  Str := 'select TENANT_ID,SHOP_ID,TRANS_ID,GLIDE_NO,IN_ACCOUNT_ID,OUT_ACCOUNT_ID,TRANS_DATE,TRANS_USER,TRANS_MNY,CHK_DATE,CHK_USER,'+
  'REMARK,CREA_DATE,CREA_USER from ACC_TRANSORDER where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TRANS_ID=:TRANS_ID';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;

  Str := 'insert into ACC_TRANSORDER(TENANT_ID,SHOP_ID,TRANS_ID,GLIDE_NO,IN_ACCOUNT_ID,OUT_ACCOUNT_ID,TRANS_DATE,TRANS_USER,TRANS_MNY,'+
  'CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values(:TENANT_ID,:SHOP_ID,:TRANS_ID,:GLIDE_NO,:IN_ACCOUNT_ID,'+
  ':OUT_ACCOUNT_ID,:TRANS_DATE,:TRANS_USER,:TRANS_MNY,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update ACC_TRANSORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,TRANS_ID=:TRANS_ID,GLIDE_NO=:GLIDE_NO,IN_ACCOUNT_ID=:IN_ACCOUNT_ID,'+
  'OUT_ACCOUNT_ID=:OUT_ACCOUNT_ID,TRANS_DATE=:TRANS_DATE,TRANS_USER=:TRANS_USER,TRANS_MNY=:TRANS_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,'+
  'REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and TRANS_ID=:OLD_TRANS_ID ';
  UpdateSQL.Text := Str;
  Str := 'update ACC_TRANSORDER set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and TRANS_ID=:OLD_TRANS_ID ';
  DeleteSQL.Text := Str;
end;

{ TTransOrderUnAudit }

function TTransOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:String;
    n:Integer;
begin
  try
    Str := 'update ACC_TRANSORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').AsString+
    ''',CHK_USER='''+Params.FindParam('CHK_USER').AsString+''',COMM='''+GetCommStr(AGlobal.iDbType)+
    ''',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and TRANS_ID='''+Params.FindParam('TRANS_ID').AsString+''' and CHK_DATE is null';
    n := AGlobal.ExecSQL(Str);
    if n = 0 then
      Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
      if n > 1 then
        Raise Exception.Create('指令会影响多行，可能数据库中数据有误。');
    Result := True;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := False;
        Msg := '审核错误'+E.Message;
      end;
  end;


end;

{ TTransOrderAudit }

function TTransOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:String;
    n:Integer;
begin
  try
    Str := 'update ACC_TRANSORDER set CHK_DATE=null,CHK_USER=null,COMM='''+GetCommStr(AGlobal.iDbType)+
    ''',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and TRANS_ID='''+Params.FindParam('TRANS_ID').AsString+''' and CHK_DATE is not null';
    n := AGlobal.ExecSQL(Str);
    if n = 0 then
      Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
      if n > 1 then
        Raise Exception.Create('指令会影响多行，可能数据库中数据误。');
    Result := True;
    Msg := '反审核单据成功。';
  except
    on E:Exception do
      begin
        Result := False;
        Msg := '反审核错误:'+E.Message;
      end;
  end;

end;

initialization
  RegisterClass(TTransOrder);
  RegisterClass(TTransOrderAudit);
  RegisterClass(TTransOrderUnAudit);

finalization
  UnRegisterClass(TTransOrder);
  UnRegisterClass(TTransOrderAudit);
  UnRegisterClass(TTransOrderUnAudit);

end.
