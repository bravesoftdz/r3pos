unit ufvchDataSQL;

interface

uses
  SysUtils;


function GetFrvhOrderIDField(const FVCH_GTYPE: string):string;
function GetFrvhDateField(const FVCH_GTYPE: string):string;
function GetFrvhViewSQL(const FVCH_GTYPE: string):wideString;


implementation

uses
  uGlobal;

function GetFrvhOrderIDField(const FVCH_GTYPE: string):string;
var
  Str: string;
  FVCH_GTYPE_IDX: integer;
begin
  FVCH_GTYPE_IDX:=StrToIntDef(FVCH_GTYPE,0);
  case FVCH_GTYPE_IDX of
   1,4: Str:='A.INDE_ID';
   2,3: Str:='A.STOCK_ID';
   5,6,11:
        Str:='A.SALES_ID';
   7,8: Str:='A.CHANGE_ID';
   9,12: Str:='A.RECV_ID';
   10: Str:='A.PAY_ID';
   13,14: Str:='A.IORO_ID';
   15: Str:='A.TRANS_ID';
  end;
  result:=Str+' not in (select FVCH_GID from ACC_FVCHGLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and FVCH_GTYPE='''+FVCH_GTYPE+''') ';
end;

function GetFrvhDateField(const FVCH_GTYPE: string):string;
var
  FVCH_GTYPE_IDX: integer;
begin
  FVCH_GTYPE_IDX:=StrToIntDef(FVCH_GTYPE,0);
  case FVCH_GTYPE_IDX of
   1,4:  result:='INDE_DATE';
   2,3:  result:='STOCK_DATE';
   5,6,11:
         result:='SALES_DATE';
   7,8:  result:='CHANGE_DATE';
   9,12: result:='RECV_DATE';
   10:   result:='PAY_DATE';
   13,14:result:='IORO_DATE';
   15:   result:='TRANS_DATE';
  end;
end;
 
function GetFrvhViewSQL(const FVCH_GTYPE: string):wideString;
var
  FVCH_GTYPE_IDX: integer;
begin
  FVCH_GTYPE_IDX:=StrToIntDef(FVCH_GTYPE,0);
  case FVCH_GTYPE_IDX of
   1: //单据类型(01) 采购订单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.INDE_ID as ORDER_ID,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY,'+
        'round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY,'+
        'B.ADVA_MNY,B.BOND_MNY,(OTH1_MNY+OTH2_MNY+OTH3_MNY+OTH4_MNY+OTH5_MNY+OTH6_MNY)as OTHR_MNY from STK_INDENTDATA A,STK_INDENTORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID';
    end;
   2: //单据类型(02) 采购进货
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.STOCK_ID as ORDER_ID,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY,'+
        'round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY '+
        ' from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID  and STOCK_TYPE=1';
    end;
   3: //单据类型(03) 采购退货
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.STOCK_ID as ORDER_ID,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY,'+
        'round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY '+
        ' from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and STOCK_TYPE=3';
    end;
   4: //单据类型(04) 销售订单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.INDE_ID as ORDER_ID,B.SALES_STYLE as SALES_STYLE,A.GODS_ID,A.IS_PRESENT,'+
        'A.CALC_AMOUNT,A.CALC_MONEY,round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY,B.ADVA_MNY,B.BOND_MNY,'+
        '(OTH1_MNY+OTH2_MNY+OTH3_MNY+OTH4_MNY+OTH5_MNY+OTH6_MNY)as OTHR_MNY from SAL_INDENTDATA A,SAL_INDENTORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID';
    end;
   5: //单据类型(05) 销售出货
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.SALES_ID as ORDER_ID,B.SALES_STYLE as SALES_STYLE,A.GODS_ID,A.IS_PRESENT,'+
        'A.CALC_AMOUNT,A.CALC_MONEY,round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY '+
        ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and SALES_TYPE=1';
    end;
   6: //单据类型(06) 销售退货
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.SALES_ID as ORDER_ID,B.SALES_STYLE as SALES_STYLE,A.GODS_ID,A.IS_PRESENT,'+
        'A.CALC_AMOUNT,A.CALC_MONEY,round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY '+
        ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and SALES_TYPE=3';
    end;
   7: //单据类型(07) 领用单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.DUTY_USER as GUIDE_USER,B.CHANGE_ID as ORDER_ID,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY '+
        ' from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and CHANGE_CODE=''2''';
    end;
   8: //单据类型(08) 损益单
    begin
      result:=
       'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.DUTY_USER as GUIDE_USER,B.CHANGE_ID as ORDER_ID,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY '+
       ' from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and CHANGE_CODE=''1'' ';
    end;
   9: //单据类型(09) 收款单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.ITEM_ID,B.PAYM_ID,B.CLIENT_ID,B.RECV_ID as ORDER_ID,A.RECV_MNY from ACC_RECVDATA A,ACC_RECVORDER B '+
        ' where A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID';
    end;
   10: //单据类型(10) 付款单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.ITEM_ID,B.PAYM_ID,B.CLIENT_ID,B.PAY_ID as ORDER_ID,A.PAY_MNY from ACC_PAYDATA A,ACC_PAYORDER B '+
        ' where A.TENANT_ID=B.TENANT_ID and A.PAY_ID=B.PAY_ID';
    end;
   11: //单据类型(11) 零售单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.GUIDE_USER,B.INVOICE_FLAG,B.SALES_ID as ORDER_ID,B.SALES_STYLE as SALES_STYLE,A.GODS_ID,A.IS_PRESENT,A.CALC_AMOUNT,A.CALC_MONEY,'+
        'PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2) as TAX_MONEY,'+
        'A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=''3'' then B.TAX_RATE else 0 end,2)as NOTAX_MONEY '+
        ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and SALES_TYPE=4'; 
    end;
   12: //单据类型(12) 缴款单
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.ITEM_ID,B.PAYM_ID,B.CLIENT_ID,B.RECV_ID as ORDER_ID,A.RECV_MNY '+
        ' from ACC_RECVDATA A,ACC_RECVORDER B where A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID';
    end;
   13: //单据类型(13) 其他收入 
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.ITEM_ID,B.IORO_USER as GUIDE_USER,B.IORO_ID as ORDER_ID,A.IORO_MNY '+
        ' from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and B.IORO_TYPE=''1'' ';
    end;
   14: //单据类型(14) 其他支出
    begin
      result:=
        'select B.TENANT_ID,B.DEPT_ID,B.SHOP_ID,B.CLIENT_ID,B.ITEM_ID,B.IORO_USER as GUIDE_USER,B.IORO_ID as ORDER_ID,A.IORO_MNY '+
        ' from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and B.IORO_TYPE=''2'' ';
    end;
   15: //单据类型(15) 存取款单 
    begin
      result:='select TENANT_ID,SHOP_ID,TRANS_ID as ORDER_ID,TRANS_MNY from ACC_TRANSORDER A where 1=1 ';
    end;
   end
end;

end.
