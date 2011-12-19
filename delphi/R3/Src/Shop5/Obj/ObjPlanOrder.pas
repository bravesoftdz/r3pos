unit ObjPlanOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TPlanOrder=class(TZFactory)
  private
    lock:boolean;
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
  TPlanData=class(TZFactory)
  private
    IsZeroOut:Boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TPlanOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TPlanOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TPlanOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TPlanOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TPlanData }

function TPlanData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

function TPlanData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TPlanData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TPlanData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TPlanData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

procedure TPlanData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select j.TENANT_ID,j.SHOP_ID,j.SEQNO,j.PLAN_ID,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.LOCUS_NO,j.BOM_ID,j.BATCH_NO,j.IS_PRESENT,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.APRICE,j.AMONEY,j.AGIO_RATE,b.GODS_NAME,b.GODS_CODE,'+
  'j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,j.REMARK from MKT_PLANDATA j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.PLAN_ID=:PLAN_ID order by j.SEQNO';

  IsSQLUpdate := True;
  Str :=
  'insert into MKT_PLANDATA(TENANT_ID,SHOP_ID,SEQNO,PLAN_ID,GODS_ID,PROPERTY_01,PROPERTY_02,LOCUS_NO,BOM_ID,BATCH_NO,IS_PRESENT,UNIT_ID,AMOUNT,ORG_PRICE,APRICE,AMONEY,AGIO_RATE,'+
  'AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,REMARK) VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:PLAN_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:LOCUS_NO,:BOM_ID,:BATCH_NO,:IS_PRESENT,:UNIT_ID,'+
  ':AMOUNT,:ORG_PRICE,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:REMARK)';

  InsertSQL.Text := Str;
  Str :=
  'update MKT_PLANDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,PLAN_ID=:PLAN_ID,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,LOCUS_NO=:LOCUS_NO,'+
  'BOM_ID=:BOM_ID,BATCH_NO=:BATCH_NO,IS_PRESENT=:IS_PRESENT,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,'+
  'AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,CALC_MONEY=:CALC_MONEY,REMARK=:REMARK where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID and SEQNO=:OLD_SEQNO';

  UpdateSQL.Text := Str;
  Str := 'delete from MKT_PLANDATA where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;


end;

{ TPlanOrder }

function TPlanOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TPlanOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

  result := true;
end;

function TPlanOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_D_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;

  result := true;
end;

function TPlanOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  lock := true;
  try
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
end;

function TPlanOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TPlanOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_PLANORDER where PLAN_ID='''+FieldbyName('PLAN_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TPlanOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
  'select TENANT_ID,SHOP_ID,PLAN_ID,GLIDE_NO,PLAN_DATE,BEGIN_DATE,END_DATE,CLIENT_ID,PLAN_USER,PLAN_AMT,PLAN_MNY,CHK_DATE,CHK_USER,REMARK,'+
  'CREA_DATE,CREA_USER,COMM,TIME_STAMP from MKT_PLANORDER where TENANT_ID=:TENANT_ID and PLAN_ID=:PLAN_ID';

  IsSQLUpdate := True;
  Str :=
  'insert into MKT_PLANORDER(TENANT_ID,SHOP_ID,PLAN_ID,GLIDE_NO,PLAN_DATE,BEGIN_DATE,END_DATE,CLIENT_ID,PLAN_USER,PLAN_AMT,PLAN_MNY,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
  'VALUES(:TENANT_ID,:SHOP_ID,:PLAN_ID,:GLIDE_NO,:PLAN_DATE,:BEGIN_DATE,:END_DATE,:CLIENT_ID,:PLAN_USER,:PLAN_AMT,:PLAN_MNY,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str :=
  'update MKT_PLANORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,PLAN_ID=:PLAN_ID,GLIDE_NO=:GLIDE_NO,PLAN_DATE=:PLAN_DATE,BEGIN_DATE=:BEGIN_DATE,END_DATE=:END_DATE,CLIENT_ID=:CLIENT_ID,'+
  'PLAN_USER=:PLAN_USER,PLAN_AMT=:PLAN_AMT,PLAN_MNY=:PLAN_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,'+
  'COMM=' + GetCommStr(iDbType) +
  ',TIME_STAMP='+GetTimeStamp(iDbType) +
  ' where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_PLANORDER where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID';
  DeleteSQL.Text := Str;
end;

{ TPlanOrderGetPrior }

procedure TPlanOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TPlanOrderGetNext }

procedure TPlanOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TPlanOrderAudit }

function TPlanOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
  try
    Str :=
    'update MKT_PLANORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) +
    ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and PLAN_ID='''+Params.FindParam('PLAN_ID').asString+''' and CHK_DATE IS NULL';

    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TPlanOrderUnAudit }

function TPlanOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update MKT_PLANORDER set CHK_DATE=null,CHK_USER=null,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
    ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and PLAN_ID='''+Params.FindParam('PLAN_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

initialization
  RegisterClass(TPlanOrder);
  RegisterClass(TPlanData);
  RegisterClass(TPlanOrderAudit);
  RegisterClass(TPlanOrderUnAudit);
  RegisterClass(TPlanOrderGetPrior);
  RegisterClass(TPlanOrderGetNext);
finalization
  UnRegisterClass(TPlanOrder);
  UnRegisterClass(TPlanData);
  UnRegisterClass(TPlanOrderAudit);
  UnRegisterClass(TPlanOrderUnAudit);
  UnRegisterClass(TPlanOrderGetPrior);
  UnRegisterClass(TPlanOrderGetNext);
end.
