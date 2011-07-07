--2011.06.13中午修改过滤类型；
--创建视图：RIM_SD_CO (订单主表)
drop view RIM_SD_CO;
create view RIM_SD_CO
as
select 
  CO_NUM,      --订单号ID
  COM_ID,      --供应商公司ID
  CUST_ID,     --客户编号（零售户）ID
  CRT_DATE,    --创建日期
  BORN_DATE,   --生效日期 为客户保留库存
  ARR_DATE,    --送达日期, 承诺订单的商品送达到客户手中的日期
  QTY_SUM,     --数量合计  
  AMT_SUM,     --应收金额合计
  STATUS       --单据状态		
from SD_CO
where STATUS in ('05','06') ;
 
--2011.06.16 增加设置RimLink分布式事务参数：
ALTER SERVER RIMLINK OPTIONS (ADD DB2_TWO_PHASE_COMMIT 'Y' ) ; 
 