unit objGoodsMonth;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TGoodsMonth = class(TZFactory)
    procedure InitClass;override;
    end;

implementation

{ TGoodsMonth }

procedure TGoodsMonth.InitClass;
var
  Str: string;
begin
  inherited;
  //初始化更新逻辑
  IsSQLUpdate := true;

  case iDbType of
    0:Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*isnull(BAL_AMT,0)-isnull(BAL_CST,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
     ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
    1:Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*nvl(BAL_AMT,0)-nvl(BAL_CST,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
     ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
    3:Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*iif(isnull(BAL_AMT),0,BAL_AMT)-iif(isnull(BAL_CST),0,BAL_CST),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
     ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
    4:Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*coalesce(BAL_AMT,0)-coalesce(BAL_CST,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
     ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
    5:Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*IfNull(BAL_AMT,0)-IfNull(BAL_CST,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
     ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  end;
  UpdateSQL.Text := Str;

end;


initialization
  RegisterClass(TGoodsMonth);
finalization
  UnRegisterClass(TGoodsMonth);

end.
