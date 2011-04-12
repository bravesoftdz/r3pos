unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  {===¿‡À∆STK_StockOrderµ•æ›===}
  TInf_StockOrder=class(TZFactory)
  private
  public
    procedure InitClass; override;
  end;

  TInf_StockDATA=class(TZFactory)
  private 
  public
    procedure InitClass; override;
  end;


  TDownOrder=class(TZFactory)
  private
  public
    procedure InitClass; override;
  end;

implementation

uses ZPlugIn;

{ TDownOrder }       

procedure TDownOrder.InitClass;
begin
  inherited;

end;
 

{ TInf_StockOrder }

procedure TInf_StockOrder.InitClass;
var
  str: string;
begin
  inherited;
  SelectSQL.Text:='select * from INF_STOCKORDER where STOCK_ID=:STOCK_ID ';
  Str:='insert into INF_STOCKORDER(TENANT_ID,SHOP_ID, STOCK_ID,GLIDE_NO,STOCK_TYPE,STOCK_DATE,GUIDE_USER,CLIENT_ID,FROM_ID,FIG_ID,ADVA_MNY,STOCK_AMT,NEED_AMT,STOCK_MNY,INVOICE_FLAG,TAX_RATE,REMARK,CREA_DATE,CREA_USER)'+
       ' values(:TENANT_ID,:SHOP_ID,:STOCK_ID,:GLIDE_NO,:STOCK_TYPE,:STOCK_DATE,:GUIDE_USER,:CLIENT_ID,:FROM_ID,:FIG_ID,:ADVA_MNY,:STOCK_AMT,:NEED_AMT,:STOCK_MNY,:INVOICE_FLAG,:TAX_RATE,:REMARK,:CREA_DATE,:CREA_USER)';
  InsertSQL.Add(Str);
end;

{ TInf_StockDATA }

procedure TInf_StockDATA.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text:='select * from INF_STOCKDATA where STOCK_ID=:STOCK_ID ';
  str:='insert into INF_STOCKDATA(TENANT_ID,SHOP_ID,STOCK_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_NO,UNIT_ID,BOM_ID,AMOUNT,NEED_AMT,ORG_PRICE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,REMARK)';
       'values (:TENANT_ID,:SHOP_ID,:STOCK_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_NO,:UNIT_ID,:BOM_ID,:AMOUNT,:NEED_AMT,:ORG_PRICE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:REMARK)';
  InsertSQL.Add(str);  
end;

initialization
  RegisterClass(TInf_StockOrder);
  RegisterClass(TInf_StockDATA);
  RegisterClass(TDownOrder);
  
finalization
  UnRegisterClass(TInf_StockOrder);
  UnRegisterClass(TInf_StockDATA);
  UnRegisterClass(TDownOrder);

end.
