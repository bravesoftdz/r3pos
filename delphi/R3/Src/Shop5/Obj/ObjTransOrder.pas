unit ObjTransOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  TTransOrder = class(TZFactory)
  private
    lock:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
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
var
  Str:String;
begin
  if not lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=round(ifnull(IN_MNY,0)- :OLD_TRANS_MNY,2),BALANCE=round(ifnull(BALANCE,0)- :OLD_TRANS_MNY,2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=round(ifnull(OUT_MNY,0)- :OLD_TRANS_MNY,2),BALANCE=round(ifnull(BALANCE,0)+:OLD_TRANS_MNY,2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  result := true;
end;

function TTransOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
       if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
         FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_9_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
     
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=round(:TRANS_MNY+ifnull(IN_MNY,0),2),BALANCE=round(:TRANS_MNY+ifnull(BALANCE,0),2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=round(:TRANS_MNY+ifnull(OUT_MNY,0),2),BALANCE=round(ifnull(BALANCE,0)- :TRANS_MNY,2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  result := true;
end;

function TTransOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  lock := true;
  try
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
end;

function TTransOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('TRANS_DATE').AsString);
        if FieldbyName('TRANS_DATE').AsOldString <> '' then
           Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('TRANS_DATE').AsOldString);
        result := true;
      end
   else
      Result := true;
end;

function TTransOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_TRANSORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and TRANS_ID='''+FieldbyName('TRANS_ID').AsString+'''';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and
    (
       (copy(rs.Fields[1].asString,1,1)='1')
       or
       (copy(rs.Fields[1].asString,2,1)<>'0')
    )
    then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TTransOrder.InitClass;
var Str:String;
begin
  inherited;
  lock := false;
  KeyFields := 'TENANT_ID;TRANS_ID';

  Str :=
  'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
  'select jd.*,d.USER_NAME as TRANS_USER_TEXT from ('+
  'select jc.*,c.ACCT_NAME as OUT_ACCOUNT_ID_TEXT,c.BALANCE as OUT_BALANCE from ('+
  'select jb.*,b.ACCT_NAME as IN_ACCOUNT_ID_TEXT,b.BALANCE as IN_BALANCE from ('+
  'select ja.*,a.SHOP_NAME as SHOP_ID_TEXT from ('+
  'select TENANT_ID,SHOP_ID,TRANS_ID,GLIDE_NO,IN_ACCOUNT_ID,OUT_ACCOUNT_ID,TRANS_DATE,TRANS_USER,TRANS_MNY,CHK_DATE,CHK_USER,'+
  'REMARK,CREA_DATE,CREA_USER,TIME_STAMP from ACC_TRANSORDER where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and TRANS_ID=:TRANS_ID ) ja '+
  'left outer join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.SHOP_ID=a.SHOP_ID) jb '+
  'left outer join VIW_ACCOUNT_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.IN_ACCOUNT_ID=b.ACCOUNT_ID) jc '+
  'left outer join VIW_ACCOUNT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.OUT_ACCOUNT_ID=c.ACCOUNT_ID) jd '+
  'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.TRANS_USER=d.USER_ID) jf '+
  'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;

  Str := 'insert into ACC_TRANSORDER(TENANT_ID,SHOP_ID,TRANS_ID,GLIDE_NO,IN_ACCOUNT_ID,OUT_ACCOUNT_ID,TRANS_DATE,TRANS_USER,TRANS_MNY,'+
  'CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values(:TENANT_ID,:SHOP_ID,:TRANS_ID,:GLIDE_NO,:IN_ACCOUNT_ID,'+
  ':OUT_ACCOUNT_ID,:TRANS_DATE,:TRANS_USER,:TRANS_MNY,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update ACC_TRANSORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,TRANS_ID=:TRANS_ID,GLIDE_NO=:GLIDE_NO,IN_ACCOUNT_ID=:IN_ACCOUNT_ID,'+
  'OUT_ACCOUNT_ID=:OUT_ACCOUNT_ID,TRANS_DATE=:TRANS_DATE,TRANS_USER=:TRANS_USER,TRANS_MNY=:TRANS_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,'+
  'REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and TRANS_ID=:OLD_TRANS_ID ';
  UpdateSQL.Text := Str;
  Str := 'delete from ACC_TRANSORDER where TENANT_ID=:OLD_TENANT_ID and TRANS_ID=:OLD_TRANS_ID ';
  DeleteSQL.Text := Str;
end;

{ TTransOrderAudit }

function TTransOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:String;
    n:Integer;
begin
  try
    Str := 'update ACC_TRANSORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').AsString+
    ''',CHK_USER='''+Params.FindParam('CHK_USER').AsString+''',COMM='+GetCommStr(AGlobal.iDbType)+
    ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and TRANS_ID='''+Params.FindParam('TRANS_ID').AsString+''' and SHOP_ID='''+Params.FindParam('SHOP_ID').AsString+''' and CHK_DATE is null';
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

{ TTransOrderUnAudit }

function TTransOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:String;
    n:Integer;
begin
  try
    Str := 'update ACC_TRANSORDER set CHK_DATE=null,CHK_USER=null,COMM='+GetCommStr(AGlobal.iDbType)+
    ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and TRANS_ID='''+Params.FindParam('TRANS_ID').AsString+''' and SHOP_ID='''+Params.FindParam('SHOP_ID').AsString+''' and CHK_DATE is not null';
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
