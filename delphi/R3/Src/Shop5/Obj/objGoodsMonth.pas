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
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
    end;

implementation

{ TGoodsMonth }

function TGoodsMonth.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  //��ԭ����ǰ�ĳɱ�
  Str :='update RCK_GOODS_MONTH set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)-isnull(ADJ_CST,0),'+
        'BAL_CST=isnull(BAL_CST,0)-isnull(ADJ_CST,0) '+
        ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //��ԭ����ǰ�ĳɱ�
  Str :='update RCK_GOODS_DAYS set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)-(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {ת��������������}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //��ԭ����ǰ�Ľ���ɱ�
  Str :='update RCK_GOODS_DAYS set '+
        'BAL_CST=isnull(BAL_CST,0)-(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {ת��������������}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  
  //�����˱���д���
  Str :='update RCK_GOODS_MONTH set '+
        'ADJ_CST=round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0),'+  {�ɱ�������}
        'CHANGE1_CST=isnull(CHANGE1_CST,0)+(round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0)),'+  {ת��������������}
        'BAL_CST=isnull(BAL_CST,0)+(round(:ADJ_PRICE*isnull(BAL_AMT,0),2)-isnull(BAL_CST,0)),'+  {ת��������������}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //�����һ������˱���д���
  Str :='update RCK_GOODS_DAYS set '+
        'CHANGE1_CST=isnull(CHANGE1_CST,0)+(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {ת��������������}
        'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and CREA_DATE='+eDate+' and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  //�����һ������˱�Ľ���ɱ�����
  Str :='update RCK_GOODS_DAYS set '+
        'BAL_CST=isnull(BAL_CST,0)+(select sum(ADJ_CST) from RCK_GOODS_MONTH '+
        'where TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=RCK_GOODS_DAYS.GODS_ID and BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and SHOP_ID=RCK_GOODS_DAYS.SHOP_ID),'+  {ת��������������}
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
    if not rs.IsEmpty then Raise Exception.Create('ֻ�ܶ����һ���µĳɱ����е���');
    rs.Close;
    rs.SQL.Text := 'select * from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH=:MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('MONTH').AsInteger := FieldbyName('MONTH').AsInteger;
    AGlobal.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('��ǰ������û���½ᣬ���ܵ����ɱ�.');
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
  //��ʼ�������߼�
  IsSQLUpdate := true;
end;


initialization
  RegisterClass(TGoodsMonth);
finalization
  UnRegisterClass(TGoodsMonth);

end.
