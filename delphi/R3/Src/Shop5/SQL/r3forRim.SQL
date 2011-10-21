--配货汇总表
create view RIM_JOURNAL 
as
 select
   j.TENANT_ID,   --R3企业号
   j.GODS_ID,     --R3商品内码
   j.SECOND_ID,   --业务系统商品内码<烟草公司内码>
   C.LICENSE_CODE,--证可证号
   sum(STOCK_AMT) as STOCK_AMT,--进货数量<条数量>
   sum(SALES_AMT) as SALES_AMT,--销售数量<条数量>
   sum(SALES_MNY) as SALES_MNY,--销售金额
   sum(STOR_AMT) as STOR_AMT --库存数量<条数量>
 from ( 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,0 as STOCK_AMT,sum(CALC_AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as SALES_AMT,sum(CALC_MONEY) as SALES_MNY,0 as STOR_AMT 
    from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.SALES_DATE=(year(current date-1 days)*10000+month(current date-1 days)*100+day(current date-1 days))
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,B.SECOND_ID 
    union all 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,sum(A.CALC_AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,0 as STOR_AMT 
    from VIW_STOCKDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.STOCK_DATE=(year(current date-1 days)*10000+month(current date-1 days)*100+day(current date-1 days))
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID
    union all 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,0 as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,sum(A.AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as STOR_AMT 
    from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID
    ) j,CA_SHOP_INFO c where j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID 
group by 
   j.TENANT_ID, 
   j.GODS_ID,   
   j.SECOND_ID,   
   C.LICENSE_CODE;

--库存汇总表
create view RIM_STORAGE_SUM 
as
select 
A.TENANT_ID,   --R3企业号
A.GODS_ID,     --R3商品内码
B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
C.LICENSE_CODE,--证可证号
sum(A.AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as BAL_AMT --库存数量<条数量>
from STO_STORAGE A,VIW_GOODSINFO B,CA_SHOP_INFO C
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and
      A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID 
group by 
A.TENANT_ID,
A.GODS_ID,
B.SECOND_ID, 
C.LICENSE_CODE;

--销售汇总表
create view RIM_SALES_SUM 
as
select 
A.TENANT_ID,   --R3企业号
A.GODS_ID,     --R3商品内码
B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
C.LICENSE_CODE,--证可证号
A.SALES_DATE,  --业务日期<整型 20110801>
sum(A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as SALE_AMT, --销售数量<条数量>
sum(A.CALC_MONEY) as SALE_MNY  --销售金额
from VIW_SALESDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
      A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID 
group by 
A.TENANT_ID,
A.GODS_ID,
B.SECOND_ID, 
C.LICENSE_CODE,
A.SALES_DATE;

--销售流水表
create view RIM_SALES_DATA
as
select 
A.TENANT_ID,   --R3企业号
A.SALES_ID,    --R3销售单号<36位唯一号>
A.GODS_ID,     --R3商品内码
B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
A.SHOP_ID,     --R3门店编码
C.LICENSE_CODE,--证可证号
D.SALES_DATE,  --业务日期<整型 20110801 >
D.CREA_DATE,   --制单日期<字符串 2011-08-02 12:23:33>
D.CLIENT_ID,   --消费者ID号<VIW_CUSTOMER>
D.SALES_TYPE,  --销售类型<1 批发销售 3 批发退货 4 门店零售>
A.TREND_ID,    --购买用途<卷烟流向 01.自用 02.馈赠礼品 03.团体消费 04.婚丧嫁娶 05.其他>
A.CALC_MONEY,  --销售金额
A.UNIT_ID,     --销售单位<按盒还是按条>
A.SEQNO,       --行号
A.AMOUNT,      --销售数量
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --销售数量<条数量>
from SAL_SALESDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,SAL_SALESORDER D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and
       A.TENANT_ID=D.TENANT_ID and A.SALES_ID=D.SALES_ID and 
       D.SALES_TYPE in (1,3,4) and D.COMM not in ('02','12'); 

--进货流水表
create view RIM_STOCK_DATA
as
select 
A.TENANT_ID,   --R3企业号
A.STOCK_ID,    --R3进货单号<36位唯一号>
A.GODS_ID,     --R3商品内码
B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
A.SHOP_ID,     --R3门店编码
C.LICENSE_CODE,--证可证号
D.STOCK_DATE,  --业务日期<整型 20110801 >
D.CREA_DATE,   --制单日期<字符串 2011-08-02 12:23:33>
D.CLIENT_ID,   --消费者ID号<VIW_CUSTOMER>
D.STOCK_TYPE,  --进货类型<1 进货 3 退货>
A.CALC_MONEY,  --进货金额
A.UNIT_ID,     --进货单位<按盒还是按条>
A.SEQNO,       --行号
A.AMOUNT,      --进货数量
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --进货数量<条数量>
from STK_STOCKDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,STK_STOCKORDER D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and
       A.TENANT_ID=D.TENANT_ID and A.STOCK_ID=D.STOCK_ID and
       D.STOCK_TYPE in (1,3) and D.COMM not in ('02','12'); 

--其他单据流水
create view RIM_CHANGE_DATA
as
select 
A.TENANT_ID,   --R3企业号
A.CHANGE_ID,    --R3单号<36位唯一号>
A.GODS_ID,     --R3商品内码
B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
A.SHOP_ID,     --R3门店编码
C.LICENSE_CODE,--证可证号
D.CHANGE_DATE,  --业务日期<整型 20110801 >
D.CREA_DATE,   --制单日期<字符串 2011-08-02 12:23:33>
D.CHANGE_CODE,  --单据类型<1 损益 2 领用>
A.UNIT_ID,     --调整单位<按盒还是按条>
A.SEQNO,       --行号
A.AMOUNT,      --调整数量
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --调整数量<条数量>
from STO_CHANGEDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,STO_CHANGEORDER D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and
       A.TENANT_ID=D.TENANT_ID and A.CHANGE_ID=D.CHANGE_ID; 

--进销存月账<月结后生成数据>
create view RIM_GOODS_MONTH
as
select 
	A.TENANT_ID , --R3企业代码
	A.SHOP_ID,    --R3门店代码
	A.MONTH,  --月份<整型 201108>
	A.GODS_ID,    --R3商品内码
  B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
  C.LICENSE_CODE,--证可证号
  D.CUST_CODE,   --客户编号
  D.CUST_ID,     --业务系统客户内码<烟草公司内码>
--结账时进销价信息
	A.NEW_INPRICE,--当时进价
	A.NEW_OUTPRICE,--当时销价
--期初类台账		
	A.ORG_AMT,--期初数量
	A.ORG_CST,--期初成本<移动加权成本>
--进货类台账	
 	A.STOCK_AMT,--进货数量<含退货>
	A.STOCK_MNY,--进货金额<末税>
	A.STOCK_TAX,--进项税额
--销售类台账	
	A.SALE_AMT,--销售数量<含退货>
	A.SALE_MNY,--销售金额<末税>
	A.SALE_TAX,--销项税额
	A.SALE_CST,--销售成本
	A.SALE_PRF,--销售毛利
--调拨类台账	
  	A.DBIN_AMT,--调入数量
	A.DBIN_CST,--调拨成本<移动加权成本>
	A.DBOUT_AMT,--调出数量
	A.DBOUT_CST,--调拨成本<移动加权成本>
--库存类台账	
 	A.CHANGE1_AMT,--损益数量
	A.CHANGE1_CST,--调整成本<移动加权成本>
	A.CHANGE2_AMT,--领用数量
	A.CHANGE2_CST,--调整成本<移动加权成本>
 	A.CHANGE3_AMT,--备用数量
 	A.CHANGE3_CST,--调整成本<移动加权成本>
 	A.CHANGE4_AMT,--备用数量
	A.CHANGE4_CST,--调整成本<移动加权成本>
	A.CHANGE5_AMT,--备用数量
	A.CHANGE5_CST,--调整成本<移动加权成本>
--结存类台账		
	A.BAL_AMT,--结存数量
	A.BAL_CST --结存成本<移动加权成本>
from RCK_GOODS_MONTH A,VIW_GOODSINFO B,CA_SHOP_INFO C
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID ; 

--进销存日账<月结后生成数据>,未月结时可能有试算数据,参考用。
create view RIM_GOODS_DAYS
as
select 
	A.TENANT_ID , --R3企业代码
	A.SHOP_ID,    --R3门店代码
	A.CREA_DATE,  --日期<整型 20110802>
	A.GODS_ID,    --R3商品内码
  B.SECOND_ID,   --业务系统商品内码<烟草公司内码>
  C.LICENSE_CODE,--证可证号
--结账时进销价信息
	A.NEW_INPRICE,--当时进价
	A.NEW_OUTPRICE,--当时销价
--期初类台账		
	A.ORG_AMT,--期初数量
	A.ORG_CST,--期初成本<移动加权成本>
--进货类台账	
 	A.STOCK_AMT,--进货数量<含退货>
	A.STOCK_MNY,--进货金额<末税>
	A.STOCK_TAX,--进项税额
--销售类台账	
	A.SALE_AMT,--销售数量<含退货>
	A.SALE_MNY,--销售金额<末税>
	A.SALE_TAX,--销项税额
	A.SALE_CST,--销售成本
	A.COST_PRICE,--成本单价<移动加权成本>
	A.SALE_PRF,--销售毛利
--调拨类台账	
  A.DBIN_AMT,--调入数量
	A.DBIN_CST,--调拨成本<移动加权成本>
	A.DBOUT_AMT,--调出数量
	A.DBOUT_CST,--调拨成本<移动加权成本>
--库存类台账	
 	A.CHANGE1_AMT,--损益数量
	A.CHANGE1_CST,--调整成本<移动加权成本>
	A.CHANGE2_AMT,--领用数量
	A.CHANGE2_CST,--调整成本<移动加权成本>
 	A.CHANGE3_AMT,--备用数量
 	A.CHANGE3_CST,--调整成本<移动加权成本>
 	A.CHANGE4_AMT,--备用数量
	A.CHANGE4_CST,--调整成本<移动加权成本>
	A.CHANGE5_AMT,--备用数量
	A.CHANGE5_CST,--调整成本<移动加权成本>
--结存类台账		
	A.BAL_AMT,--结存数量
	A.BAL_CST --结存成本<移动加权成本>
from RCK_GOODS_DAYS A,VIW_GOODSINFO B,CA_SHOP_INFO C
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID; 
	
