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
  //初始化查询
  {SelectSQL.Text := 'select TENANT_ID,SHOP_ID,MONTH,GODS_ID,BATCH_NO,BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,ADJ_CST from RCK_GOODS_MONTH '+
  'where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH and GODS_ID=:GODS_ID and BATCH_NO=:BATCH_NO '; }
  //初始化更新逻辑
  IsSQLUpdate := true;

  Str :='update RCK_GOODS_MONTH set ADJ_CST=:ADJ_PRICE*BAL_AMT-BAL_CST,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and MONTH=:OLD_MONTH and GODS_ID=:OLD_GODS_ID and BATCH_NO=:OLD_BATCH_NO';
  UpdateSQL.Text :=  Str;

end;


initialization
  RegisterClass(TGoodsMonth);
finalization
  UnRegisterClass(TGoodsMonth);

end.
