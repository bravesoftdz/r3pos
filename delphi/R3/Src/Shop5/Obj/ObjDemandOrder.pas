unit ObjDemandOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TDemandOrder=class(TZFactory)
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
  TDemandData=class(TZFactory)
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
  TDemandOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TDemandOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TDemandOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDemandOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDemandOrderForDb=class(TZFactory)
  public
    procedure InitClass; override;
  end;
  TDemandDataForDb=class(TZFactory)
  public
    procedure InitClass; override;
  end;
implementation

{ TDemandData }

function TDemandData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

function TDemandData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TDemandData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TDemandData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TDemandData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

procedure TDemandData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  ParseSQL(iDbType,'select j.TENANT_ID,j.SHOP_ID,j.SEQNO,j.DEMA_ID,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.LOCUS_NO,j.BOM_ID,j.BATCH_NO,'+
  'j.IS_PRESENT,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.APRICE,b.GODS_NAME,b.GODS_CODE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
  'case when isnull(j.CALC_AMOUNT,0)=0 then 0 else j.SHIP_AMOUNT/(cast(j.CALC_AMOUNT/(j.AMOUNT*1.0) as decimal(18,3))*1.0) end as SHIP_AMOUNT,'+
  'j.REMARK from MKT_DEMANDDATA j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.DEMA_ID=:DEMA_ID order by SEQNO');
  IsSQLUpdate := True;
  Str :=
  'insert into MKT_DEMANDDATA(TENANT_ID,SHOP_ID,SEQNO,DEMA_ID,GODS_ID,PROPERTY_01,PROPERTY_02,LOCUS_NO,BOM_ID,BATCH_NO,IS_PRESENT,UNIT_ID,AMOUNT,'+
  'ORG_PRICE,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,SHIP_AMOUNT,REMARK) VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:DEMA_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,'+
  ':LOCUS_NO,:BOM_ID,:BATCH_NO,:IS_PRESENT,:UNIT_ID,:AMOUNT,:ORG_PRICE,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:SHIP_AMOUNT,:REMARK)';
  InsertSQL.Text := Str;
  Str :=
  'update MKT_DEMANDDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,DEMA_ID=:DEMA_ID,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,'+
  'PROPERTY_02=:PROPERTY_02,LOCUS_NO=:LOCUS_NO,BOM_ID=:BOM_ID,BATCH_NO=:BATCH_NO,IS_PRESENT=:IS_PRESENT,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,'+
  'ORG_PRICE=:ORG_PRICE,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,CALC_MONEY=:CALC_MONEY,'+
  'SHIP_AMOUNT=:SHIP_AMOUNT,REMARK=:REMARK where TENANT_ID=:OLD_TENANT_ID and DEMA_ID=:OLD_DEMA_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_DEMANDDATA where TENANT_ID=:OLD_TENANT_ID and DEMA_ID=:OLD_DEMA_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;


end;

{ TDemandOrder }

function TDemandOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TDemandOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TDemandOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_C_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;

  result := true;
end;

function TDemandOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TDemandOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
//   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
//      begin
//        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('INDE_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
//        if FieldbyName('INDE_DATE').AsOldString <> '' then
//           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('INDE_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
//        result := true;
//      end
//   else
//      Result := true;
  result := true;
end;

function TDemandOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_DEMANDORDER where DEMA_ID='''+FieldbyName('DEMA_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TDemandOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
  'select ja.TENANT_ID,ja.SHOP_ID,ja.DEMA_ID,ja.DEMA_TYPE,ja.GLIDE_NO,ja.DEMA_DATE,ja.DEPT_ID,b.DEPT_NAME,ja.CLIENT_ID,ja.DEMA_USER,ja.CHK_DATE,ja.CHK_USER,ja.REMARK,ja.CREA_DATE,ja.CREA_USER,ja.DEMA_AMT,ja.DEMA_MNY,ja.COMM,'+
  'ja.TIME_STAMP,a.USER_NAME as CHK_USER_TEXT from MKT_DEMANDORDER ja left join VIW_USERS a on ja.TENANT_ID=a.TENANT_ID and ja.CHK_USER=a.USER_ID '+
  ' left join CA_DEPT_INFO b on ja.TENANT_ID=b.TENANT_ID and ja.DEPT_ID=b.DEPT_ID where ja.TENANT_ID=:TENANT_ID and ja.DEMA_ID=:DEMA_ID';
  IsSQLUpdate := True;
  Str :=
  'insert into MKT_DEMANDORDER(TENANT_ID,SHOP_ID,DEMA_ID,DEMA_TYPE,GLIDE_NO,DEMA_DATE,CLIENT_ID,DEPT_ID,DEMA_USER,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,DEMA_AMT,DEMA_MNY,COMM,TIME_STAMP) '+
  'VALUES(:TENANT_ID,:SHOP_ID,:DEMA_ID,:DEMA_TYPE,:GLIDE_NO,:DEMA_DATE,:CLIENT_ID,:DEPT_ID,:DEMA_USER,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,:DEMA_AMT,:DEMA_MNY,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str :=
  'update MKT_DEMANDORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEMA_ID=:DEMA_ID,DEMA_TYPE=:DEMA_TYPE,GLIDE_NO=:GLIDE_NO,DEMA_DATE=:DEMA_DATE,DEPT_ID=:DEPT_ID,'+
  'CLIENT_ID=:CLIENT_ID,DEMA_USER=:DEMA_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,DEMA_AMT=:DEMA_AMT,DEMA_MNY=:DEMA_MNY,'+
  'COMM=' + GetCommStr(iDbType) +
  ',TIME_STAMP='+GetTimeStamp(iDbType) +
  ' where TENANT_ID=:OLD_TENANT_ID and DEMA_ID=:OLD_DEMA_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_DEMANDORDER where TENANT_ID=:OLD_TENANT_ID and DEMA_ID=:OLD_DEMA_ID';
  DeleteSQL.Text := Str;
end;

{ TDemandOrderGetPrior }

procedure TDemandOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO DESC limit 1';
  end;
end;

{ TDemandOrderGetNext }

procedure TDemandOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select DEMA_ID from MKT_DEMANDORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and DEMA_TYPE=:DEMA_TYPE order by GLIDE_NO limit 1';
  end;
end;

{ TDemandOrderAudit }

function TDemandOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    //Temp:TZQuery;
begin
  try
    {Temp := TZQuery.Create(nil);
    try
      Temp.SQL.Text := 'select SALBILL_STATUS from SAL_INDENTORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+'''';
      AGlobal.Open(Temp);
      if Temp.Fields[0].AsInteger>0 then Raise Exception.Create('已经出货的订单不能再修改了...');  
    finally
      Temp.Free;
    end;}
    Str := 'update MKT_DEMANDORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and DEMA_ID='''+Params.FindParam('DEMA_ID').asString+''' and CHK_DATE IS NULL';
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

{ TDemandOrderUnAudit }

function TDemandOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   try
    rs := TZQuery.Create(nil);
    try
      if Params.FindParam('DEMA_TYPE').AsString = '1' then
      begin
        rs.Close;
        if Copy(Params.FindParam('SHOP_ID').AsString,length(Params.FindParam('SHOP_ID').AsString)-3,length(Params.FindParam('SHOP_ID').AsString)) <> '0001' then
           rs.SQL.Text := 'select FIG_ID from SAL_SALESORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and FIG_ID='''+Params.FindParam('DEMA_ID').asString+''''
        else
           rs.SQL.Text := 'select FIG_ID from STK_INDENTORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and FIG_ID='''+Params.FindParam('DEMA_ID').asString+'''';
        AGlobal.Open(rs);
        if rs.FieldbyName('FIG_ID').AsString <> '' then Raise Exception.Create('已经配货的申请单不能弃审...');
      end
      else if Params.FindParam('DEMA_TYPE').AsString = '2' then
      begin
        rs.Close;
        rs.SQL.Text := 'select FIG_ID from STO_CHANGEORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and FIG_ID='''+Params.FindParam('DEMA_ID').asString+'''';
        AGlobal.Open(rs);
        if rs.FieldbyName('FIG_ID').AsString <> '' then Raise Exception.Create('已经配货的申请单不能弃审...');
      end;
    finally
      rs.Free;
    end;
    Str := 'update MKT_DEMANDORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and DEMA_ID='''+Params.FindParam('DEMA_ID').asString+''' and CHK_DATE IS NOT NULL';
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

{ TDemandDataForStock }

procedure TDemandDataForDb.InitClass;
begin
  SelectSQL.Text :=
  ParseSQL(iDbType,
  'select j.TENANT_ID,j.SHOP_ID,j.SEQNO,j.DEMA_ID,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.LOCUS_NO,j.BOM_ID,'+
  'j.BATCH_NO,j.IS_PRESENT,j.UNIT_ID,isnull(j.AMOUNT,0)-isnull(j.SHIP_AMOUNT,0) as AMOUNT,j.ORG_PRICE,j.APRICE,b.GODS_NAME,b.GODS_CODE,'+
  'j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,j.REMARK from MKT_DEMANDDATA j left outer join VIW_GOODSINFO '+
  ' b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.DEMA_ID=:DEMA_ID order by SEQNO');
end;

{ TDemandOrderForDb }

procedure TDemandOrderForDb.InitClass;
begin
  SelectSQL.Text :=
  ParseSQL(iDbType,
  'select ja.TENANT_ID,ja.SHOP_ID as CLIENT_ID,ja.DEMA_ID,ja.DEMA_TYPE,ja.GLIDE_NO,ja.DEMA_DATE,ja.CLIENT_ID,b.DEPT_NAME,'+
  'ja.DEMA_USER,ja.CHK_DATE,ja.CHK_USER,ja.REMARK,ja.CREA_DATE,ja.CREA_USER,ja.DEMA_AMT,ja.DEMA_MNY,ja.COMM,'+
  'ja.TIME_STAMP,a.USER_NAME as CHK_USER_TEXT from MKT_DEMANDORDER ja left join VIW_USERS a on ja.TENANT_ID=a.TENANT_ID '+
  ' and ja.CHK_USER=a.USER_ID left join CA_DEPT_INFO b on ja.TENANT_ID=b.TENANT_ID and ja.DEPT_ID=b.DEPT_ID where ja.TENANT_ID=:TENANT_ID and ja.DEMA_ID=:DEMA_ID');
end;

initialization
  RegisterClass(TDemandOrder);
  RegisterClass(TDemandData);
  RegisterClass(TDemandOrderAudit);
  RegisterClass(TDemandOrderUnAudit);
  RegisterClass(TDemandOrderGetPrior);
  RegisterClass(TDemandOrderGetNext);
  RegisterClass(TDemandDataForDb);
  RegisterClass(TDemandOrderForDb);
finalization
  UnRegisterClass(TDemandOrder);
  UnRegisterClass(TDemandData);
  UnRegisterClass(TDemandOrderAudit);
  UnRegisterClass(TDemandOrderUnAudit);
  UnRegisterClass(TDemandOrderGetPrior);
  UnRegisterClass(TDemandOrderGetNext);
  UnRegisterClass(TDemandDataForDb);
  UnRegisterClass(TDemandOrderForDb);
end.
