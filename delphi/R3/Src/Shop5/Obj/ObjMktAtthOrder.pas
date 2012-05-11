unit ObjMktAtthOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TMktAtthOrder=class(TZFactory)
  private
    Locked:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TMktAtthData=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TMktAtthOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktAtthOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktAtthOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TMktAtthOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TMktAtthOrder }

function TMktAtthOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Locked and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then  Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TMktAtthOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_E_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
end;

function TMktAtthOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Locked := true;
  try
    if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  finally
    Locked := false;
  end;
end;

function TMktAtthOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_REQUORDER where REQU_ID='''+FieldbyName('REQU_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
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

procedure TMktAtthOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,A.ATTH_ID,A.DEPT_ID,C.DEPT_NAME as DEPT_ID_TEXT,A.REQU_TYPE,'+
  'A.GLIDE_NO,A.REQU_DATE,A.CLIENT_ID,D.PRICE_ID,D.CLIENT_NAME as CLIENT_ID_TEXT,E.USER_NAME as REQU_USER_TEXT,A.REQU_USER,'+
  'A.CHK_DATE,A.CHK_USER,G.USER_NAME as CHK_USER_TEXT,A.REQU_ID,H.GLIDE_NO as REQU_ID_TEXT,A.KPI_MNY,A.BUDG_MNY,A.AGIO_MNY,A.OTHR_MNY,'+
  'A.REMARK,A.CREA_DATE,A.CREA_USER,F.USER_NAME as CREA_USER_TEXT,A.COMM,A.TIME_STAMP '+
  ' from MKT_ATTHORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.REQU_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CREA_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CHK_USER=G.USER_ID  '+
  ' left join MKT_REQUORDER H on A.TENANT_ID=H.TENANT_ID and A.REQU_ID=H.REQU_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.ATTH_ID=:ATTH_ID';
  IsSQLUpdate := True;
  Str := 'insert into MKT_ATTHORDER(TENANT_ID,SHOP_ID,ATTH_ID,DEPT_ID,REQU_TYPE,GLIDE_NO,REQU_DATE,CLIENT_ID,REQU_USER,CHK_DATE,CHK_USER,REQU_ID,KPI_MNY,BUDG_MNY,AGIO_MNY,OTHR_MNY,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:ATTH_ID,:DEPT_ID,:REQU_TYPE,:GLIDE_NO,:REQU_DATE,:CLIENT_ID,:REQU_USER,:CHK_DATE,:CHK_USER,:REQU_ID,:KPI_MNY,:BUDG_MNY,:AGIO_MNY,:OTHR_MNY,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update MKT_ATTHORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,ATTH_ID=:ATTH_ID,DEPT_ID=:DEPT_ID,REQU_TYPE=:REQU_TYPE,GLIDE_NO=:GLIDE_NO,'+
         'REQU_DATE=:REQU_DATE,CLIENT_ID=:CLIENT_ID,REQU_USER=:REQU_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,KPI_MNY=:KPI_MNY,BUDG_MNY=:BUDG_MNY,'+
         'AGIO_MNY=:AGIO_MNY,OTHR_MNY=:OTHR_MNY,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,REQU_ID=:REQU_ID,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         'where TENANT_ID=:OLD_TENANT_ID and ATTH_ID=:OLD_ATTH_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from MKT_ATTHORDER where TENANT_ID=:OLD_TENANT_ID and ATTH_ID=:OLD_ATTH_ID ';
  DeleteSQL.Text := Str;
end;

{ TMktAtthOrderGetPrior }

procedure TMktAtthOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TMktAtthOrderGetNext }

procedure TMktAtthOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select ATTH_ID from MKT_ATTHORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TMktAtthOrderAudit }

function TMktAtthOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str,ChkUser:string;
    n:Integer;
    Temp:TZQuery;
begin
  AGlobal.BeginTrans;
  try

    Str := 'update MKT_ATTHORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and ATTH_ID='''+Params.FindParam('ATTH_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    AGlobal.CommitTrans;
    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        AGlobal.RollbackTrans;
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TMktAtthOrderUnAudit }

function TMktAtthOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update MKT_ATTHORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) +',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
           ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and ATTH_ID='''+Params.FindParam('ATTH_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    AGlobal.CommitTrans;
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         AGlobal.RollbackTrans;
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

{ TMktAtthData }

function TMktAtthData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktAtthData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktAtthData.InitClass;
var
  Str: string;
begin
  inherited;
  //Locked := false;
  Str :=
  'select A.TENANT_ID,A.SHOP_ID,A.SEQNO,A.ATTH_ID,A.GODS_ID,A.UNIT_ID,A.AMOUNT,A.CALC_AMOUNT,'+
  'case when A.UNIT_ID=B.CALC_UNITS then isnull(B.NEW_OUTPRICE,0) when A.UNIT_ID=B.SMALL_UNITS then isnull(B.[NEW_OUTPRICE],0)*B.SMALLTO_CALC '+
  'when A.UNIT_ID=B.BIG_UNITS then isnull(B.[NEW_OUTPRICE],0)*B.BIGTO_CALC end as APRICE,A.CALC_AMOUNT*B.NEW_OUTPRICE as AMONEY,'+
  'A.KPI_MNY,A.BUDG_MNY,A.AGIO_MNY,A.OTHR_MNY,A.REMARK,B.GODS_NAME,B.GODS_CODE,''#'' as BATCH_NO,'+
  '''#'' as LOCUS_NO,''#'' as BOM_ID,''#'' as PROPERTY_01,''#'' as PROPERTY_02,0 as IS_PRESENT '+
  ' from MKT_ATTHDATA A left join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID  '+
  ' where A.TENANT_ID=:TENANT_ID and ATTH_ID=:ATTH_ID ';
  SelectSQL.Text := ParseSQL(iDbType,Str);
  IsSQLUpdate := True;
  Str := 'insert into MKT_ATTHDATA(TENANT_ID,SHOP_ID,SEQNO,ATTH_ID,GODS_ID,UNIT_ID,AMOUNT,CALC_AMOUNT,KPI_MNY,BUDG_MNY,AGIO_MNY,OTHR_MNY,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:ATTH_ID,:GODS_ID,:UNIT_ID,:AMOUNT,:CALC_AMOUNT,:KPI_MNY,:BUDG_MNY,:AGIO_MNY,:OTHR_MNY,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update MKT_ATTHDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,ATTH_ID=:ATTH_ID,GODS_ID=:GODS_ID,UNIT_ID=:UNIT_ID,'+
         'AMOUNT=:AMOUNT,CALC_AMOUNT=:CALC_AMOUNT,KPI_MNY=:KPI_MNY,BUDG_MNY=:BUDG_MNY,AGIO_MNY=:AGIO_MNY,OTHR_MNY=:OTHR_MNY,REMARK=:REMARK '+
         'where TENANT_ID=:OLD_TENANT_ID and ATTH_ID=:OLD_ATTH_ID and SEQNO=:OLD_SEQNO ';
  UpdateSQL.Text := Str;
  Str := ' delete from MKT_ATTHDATA where TENANT_ID=:OLD_TENANT_ID and ATTH_ID=:OLD_ATTH_ID and SEQNO=:OLD_SEQNO ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TMktAtthOrder);
  RegisterClass(TMktAtthData);
  RegisterClass(TMktAtthOrderGetPrior);
  RegisterClass(TMktAtthOrderGetNext);
  RegisterClass(TMktAtthOrderAudit);
  RegisterClass(TMktAtthOrderUnAudit);
finalization
  UnRegisterClass(TMktAtthOrder);
  UnRegisterClass(TMktAtthData);
  UnRegisterClass(TMktAtthOrderGetPrior);
  UnRegisterClass(TMktAtthOrderGetNext);
  UnRegisterClass(TMktAtthOrderAudit);
  UnRegisterClass(TMktAtthOrderUnAudit);
end.
{
}
