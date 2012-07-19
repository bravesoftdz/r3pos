unit objGoodsMonth;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TGoodsMonth = class(TZFactory)
    private
    month:string;
    bdate:string;
    edate:string;
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
    end;

implementation

{ TGoodsMonth }

function TGoodsMonth.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  //还原调整前的成本
  Str :='update RCK_GOODS_MONTH set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)-isnull(ADJ_CST,0),'+
        'BAL_CST=isnull(BAL_CST,0)-isnull(ADJ_CST,0) '+
        ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //还原调整前的成本
  Str :='update RCK_GOODS_DAYS set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)-(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {转成最后天的损益量}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //还原调整前的结余成本
  Str :='update RCK_GOODS_DAYS set '+
        'BAL_CST=isnull(BAL_CST,0)-(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {转成最后天的损益量}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  
  //对月账表进行处理
  Str :='update RCK_GOODS_MONTH set '+
        'ADJ_CST=round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0),'+  {成本调增量}
        'CHANGE1_CST=isnull(CHANGE1_CST,0)+(round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0)),'+  {转成最后天的损益量}
        'BAL_CST=isnull(BAL_CST,0)+(round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0)),'+  {转成最后天的损益量}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //对最后一天的日账表进行处理
  Str :='update RCK_GOODS_DAYS set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)+(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {转成最后天的损益量}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //对最后一天的日账表的结余成本进行
  Str :='update RCK_GOODS_DAYS set '+
        'BAL_CST=isnull(BAL_CST,0)+(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {转成最后天的损益量}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
end;

function TGoodsMonth.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select * from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH>:MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('MONTH').AsInteger := FieldbyName('MONTH').AsInteger;
    AGlobal.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create('只能对最后一个月的成本进行调整');
    rs.Close;
    rs.SQL.Text := 'select * from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH=:MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('MONTH').AsInteger := FieldbyName('MONTH').AsInteger;
    AGlobal.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('当前调整月没有月结，不能调整成本.');
    month:=rs.FieldbyName('TENANT_ID').asString;
    bdate:=StringReplace(rs.FieldbyName('BEGIN_DATE').asString,'-','',[rfReplaceAll]);
    edate:=StringReplace(rs.FieldbyName('END_DATE').asString,'-','',[rfReplaceAll]);
    AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(FieldbyName('TENANT_ID').AsInteger)+' and CREA_DATE>'+edate+'');
  finally
    rs.Free;
  end;
end;

procedure TGoodsMonth.InitClass;
var
  Str: string;
begin
  inherited;
  //初始化更新逻辑
  IsSQLUpdate := true;
end;


initialization
  RegisterClass(TGoodsMonth);
finalization
  UnRegisterClass(TGoodsMonth);

end.
