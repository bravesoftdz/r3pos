unit ObjPriceOrder;

interface

uses
  Dialogs,SysUtils,zBase,Classes, AdoDb,zIntf,ObjCommon,DB,ZDataset;

type
  TPriceOrder=class(TZFactory)
  private
    Locked:boolean;
  public
    function CheckTimeStamp(AGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TPriceData=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  //促销门店
  TPriceShopList=class(TZFactory)
  public
    procedure InitClass; override;
  end;

  TPriceOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  TPriceOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  TPriceOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;

  TPriceOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;

implementation


{ TPriceOrder }


function TPriceOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Locked and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then  Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TPriceOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin                                        
    if  (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
      FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_6_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
  end;
  result := true;
end;

function TPriceOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Locked := true;
  try
    if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    Locked := false;
  end;
end;

function TPriceOrder.CheckTimeStamp(AGlobal: IdbHelp; s: string; comm:boolean=true): boolean;
var rs: TZQuery;
begin
  result:=false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text:='select TIME_STAMP,COMM from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID ';;
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=fieldbyName('TENANT_ID').AsInteger;
    if rs.Params.FindParam('PROM_ID')<>nil then rs.ParamByName('PROM_ID').AsString:=FieldbyName('PROM_ID').AsString;
    AGlobal.Open(rs);
    result:=(rs.Fields[0].AsString=s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..'); 
  finally
    rs.Free;
  end;
end;

procedure TPriceOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
    'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
    'select jc.*,c.PRICE_NAME as PRICE_ID_TEXT from ('+
    'select PROM_ID,GLIDE_NO,TENANT_ID,SHOP_ID,BEGIN_DATE,END_DATE,PRICE_ID,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP '+
    ' from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID) jc '+
    ' left outer join PUB_PRICEGRADE c on jc.TENANT_ID=c.TENANT_ID and jc.PRICE_ID=c.PRICE_ID ) jd '+
    ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID';
    
  str:='Insert Into SAL_PRICEORDER(PROM_ID,GLIDE_NO,TENANT_ID,SHOP_ID,BEGIN_DATE,END_DATE,PRICE_ID,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP)'+
    ' Values (:PROM_ID,:GLIDE_NO,:TENANT_ID,:SHOP_ID,:BEGIN_DATE,:END_DATE,:PRICE_ID,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);
  
  Str:='Update SAL_PRICEORDER set PROM_ID=:PROM_ID,GLIDE_NO=:GLIDE_NO,TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,BEGIN_DATE=:BEGIN_DATE,END_DATE=:END_DATE,PRICE_ID=:PRICE_ID,'
    +' CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,COMM=' + GetCommStr(iDbType)+','
    +' TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and PROM_ID=:OLD_PROM_ID ';
  UpdateSQL.Add(Str);
  Str:='delete from SAL_PRICEORDER where TENANT_ID=:OLD_TENANT_ID and PROM_ID=:OLD_PROM_ID ';
  DeleteSQL.Add(Str);
end;


{ TPriceData }

function TPriceData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  try
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TPriceData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  try
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TPriceData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

procedure TPriceData.InitClass;
var Str: string;
begin
  inherited;
  //新商品视图: VIW_GOODSPRICE 已包括商品信息
  SelectSQL.Text:='select * From  '+
    '(select j.TENANT_ID,j.PROM_ID,j.SEQNO,j.GODS_ID,''#'' as BATCH_NO,0 as IS_PRESENT,b.CALC_UNITS as UNIT_ID,''#'' as PROPERTY_01,''#'' as PROPERTY_02,'+
    'j.NEW_OUTPRICE as OUT_PRICE,j.NEW_OUTPRICE1 as OUT_PRICE1,j.NEW_OUTPRICE2 as OUT_PRICE2,j.AGIO_RATE,j.RATE_OFF,j.ISINTEGRAL,b.GODS_NAME,b.GODS_CODE,b.SMALL_UNITS,b.CALC_UNITS,b.BIG_UNITS,b.NEW_OUTPRICE   '+
    ' from SAL_PRICEDATA j '+
    ' left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
    //' left outer join VIW_GOODSPRICE c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
    'where j.TENANT_ID=:TENANT_ID and j.PROM_ID=:PROM_ID) as tmp order by SEQNO ';
    
  Str:='Insert Into SAL_PRICEDATA(PROM_ID,TENANT_ID,SEQNO,GODS_ID,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,RATE_OFF,AGIO_RATE,ISINTEGRAL) '+
    ' Values (:PROM_ID,:TENANT_ID,:SEQNO,:GODS_ID,:OUT_PRICE,:OUT_PRICE1,:OUT_PRICE2,:RATE_OFF,:AGIO_RATE,:ISINTEGRAL)';
  InsertSQL.Add(Str);

  Str:='update SAL_PRICEDATA set PROM_ID=:PROM_ID,TENANT_ID=:TENANT_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,NEW_OUTPRICE=:OUT_PRICE,NEW_OUTPRICE1=:OUT_PRICE1,NEW_OUTPRICE2=:OUT_PRICE2,RATE_OFF=:RATE_OFF,AGIO_RATE=:AGIO_RATE,ISINTEGRAL=:ISINTEGRAL '+
    ' where TENANT_ID=:OLD_TENANT_ID and PROM_ID=:OLD_PROM_ID and SEQNO=:OLD_SEQNO ';
  UpdateSQL.Add(Str);

  case iDbType of
   1: Str := 'delete SAL_PRICEDATA where TENANT_ID=:OLD_TENANT_ID and PROM_ID=:OLD_PROM_ID and SEQNO=:OLD_SEQNO ';
   0,3,4,5:
      Str := 'delete from SAL_PRICEDATA where TENANT_ID=:OLD_TENANT_ID and PROM_ID=:OLD_PROM_ID and SEQNO=:OLD_SEQNO ';
  end;
  DeleteSQL.Add(Str);
end;


{ TPriceShopList }

procedure TPriceShopList.InitClass;
var Str: string;
begin
  inherited;
  SelectSQL.Text:='select B.*,A.ROWS_ID as ROWS_ID,PROM_ID from '+
    '(select TENANT_ID,SHOP_ID,ROWS_ID,PROM_ID from SAL_PROM_SHOP where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID) A, '+
    '(select SHOP_ID,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,SEQ_NO from CA_SHOP_INFO where TENANT_ID=:TENANT_ID) B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID order by B.SEQ_NO ';

  InsertSQL.Add('insert into SAL_PROM_SHOP (ROWS_ID,PROM_ID,TENANT_ID,SHOP_ID) values (:ROWS_ID,:PROM_ID,:TENANT_ID,:SHOP_ID)');
  str:='update SAL_PROM_SHOP set ROWS_ID=:ROWS_ID,PROM_ID=:PROM_ID,TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  UpdateSQL.Add(Str);

  case iDbType of
   1: Str:='delete SAL_PROM_SHOP where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
   else
      Str:='delete from SAL_PROM_SHOP where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  end;
  DeleteSQL.Add(Str);     
end;


{ TPriceOrderGetPrior }

procedure TPriceOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO desc';
  1:SelectSQL.Text := 'select * from (select ROWNUM,PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO desc) where ROWNUM<2 ';
  4:SelectSQL.Text := 'select * from (select PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO desc) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TPriceOrderGetNext }

procedure TPriceOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
   0,3:SelectSQL.Text := 'select top 1 PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
   1:SelectSQL.Text := 'select * from (select ROWNUM,PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM<2 ';
   4:SelectSQL.Text := 'select * from (select PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
   5:SelectSQL.Text := 'select PROM_ID from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TPriceOrderAudit }

function TPriceOrderAudit.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var Str:string; n:Integer;
begin
  AGlobal.BeginTrans; 
  try
    Str:='update SAL_PRICEORDER set CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where CHK_DATE IS NULL and TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID ';
    n:=AGlobal.ExecSQL(Str,Params);
   {
    if n=0 then
       Raise DLLException.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise DLLException.Create('删除指令会影响多行，可能数据库中数据误。');
   }
    if n=1 then
    begin
      AGlobal.CommitTrans;
      Result := true;
      Msg := '审核单据成功';
    end else
    begin
      AGlobal.RollbackTrans;
      if n=0 then
        Msg := '审核单据异常！'
      else if n>1 then
        Msg := ' 审核单据会影响多行，可能数据库中数据误。！'
    end;
  except
    on E:Exception do
      begin
        AGlobal.RollbackTrans;
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TPriceOrderUnAudit }

function TPriceOrderUnAudit.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var Str:string; n:Integer;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update SAL_PRICEORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where CHK_DATE IS NOT NULL and TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID ';
    n := AGlobal.ExecSQL(Str, Params);
   {
    if n=0 then
       Raise DLLException.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise DLLException.Create('删除指令会影响多行，可能数据库中数据误。');
   }
    if n=1 then
    begin
      AGlobal.CommitTrans;
      MSG := '反审核单据成功。';
      Result := True;
    end else
    begin
      AGlobal.RollbackTrans;
      if n=0 then
        Msg := '审核单据异常！'
      else if n>1 then
        Msg := ' 审核单据会影响多行，可能数据库中数据误。！'
    end;
  except
    on E:Exception do
       begin
         AGlobal.RollbackTrans;
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

initialization
  RegisterClass(TPriceOrder);
  RegisterClass(TPriceData);
  RegisterClass(TPriceShopList);
  RegisterClass(TPriceOrderGetPrior);
  RegisterClass(TPriceOrderGetNext);
  RegisterClass(TPriceOrderAudit);
  RegisterClass(TPriceOrderUnAudit);
finalization
  UnRegisterClass(TPriceOrder);
  UnRegisterClass(TPriceData);
  UnRegisterClass(TPriceShopList);  
  UnRegisterClass(TPriceOrderGetPrior);
  UnRegisterClass(TPriceOrderGetNext);
  UnRegisterClass(TPriceOrderAudit);
  UnRegisterClass(TPriceOrderUnAudit);
end.
