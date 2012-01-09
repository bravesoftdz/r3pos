update PUB_PARAMS set CODE_NAME='商品分类' where TYPE_CODE='SORT_TYPE' and CODE_ID='1';
update PUB_PARAMS set CODE_NAME='商品价类' where TYPE_CODE='SORT_TYPE' and CODE_ID='2';
update PUB_PARAMS set CODE_NAME='主供应商' where TYPE_CODE='SORT_TYPE' and CODE_ID='3';
update PUB_PARAMS set CODE_NAME='所属品牌' where TYPE_CODE='SORT_TYPE' and CODE_ID='4';
update PUB_PARAMS set CODE_NAME='重点品牌' where TYPE_CODE='SORT_TYPE' and CODE_ID='5';
update PUB_PARAMS set CODE_NAME='省内外' where TYPE_CODE='SORT_TYPE' and CODE_ID='6';
update PUB_PARAMS set CODE_NAME='生产厂家' where TYPE_CODE='SORT_TYPE' and CODE_ID='9';

update CA_MODULE set MODU_NAME='商品库存' where MODU_ID='14500001';

--日均销量
alter table STO_STORAGE add	DAY_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add DAY_SALE_AMT decimal(18, 3);
--最近安全天数内的
alter table STO_STORAGE add	NEAR_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add NEAR_SALE_AMT decimal(18, 3);
--当月的销量
alter table STO_STORAGE add	MTH_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add MTH_SALE_AMT decimal(18, 3);

--商品门店扩展表
CREATE TABLE PUB_GOODS_INSHOP (
        --企业代码
	TENANT_ID int NOT NULL ,
        --货号编码
	GODS_ID char (36) NOT NULL ,
        --门店代码
	SHOP_ID varchar (13) NOT NULL ,
        --安全库存
	LOWER_AMOUNT decimal(18, 3) ,
        --上限库存
	UPPER_AMOUNT decimal(18, 3) ,
        --最低存销比
	LOWER_RATE decimal(18, 3) ,
        --最高存销比
	UPPER_RATE decimal(18, 3) ,
        --日均销量
	DAY_SALE_AMT decimal(18, 3) ,
        --最近安全天数内的销量
	NEAR_SALE_AMT decimal(18, 3) ,
        --当月的销量
	MTH_SALE_AMT decimal(18, 3) ,
	COMM varchar(2) NOT NULL  DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_INSHOP PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID)
) IN R3TB4K_BAS;
CREATE INDEX I_PGIS_TENANT_ID ON PUB_GOODS_INSHOP(TENANT_ID);
CREATE INDEX I_PGIS_GODS_ID ON PUB_GOODS_INSHOP(TENANT_ID,GODS_ID);
CREATE INDEX I_PGIS_TIME_STAMP ON PUB_GOODS_INSHOP(TENANT_ID,TIME_STAMP);
 
--在途量计算
create view VIW_SR_INFO
as
select A.TENANT_ID,B.CLIENT_ID as SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,sum(A.CALC_AMOUNT) as AMOUNT 
from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.SALES_TYPE=2 and B.PLAN_DATE is null
group by A.TENANT_ID,B.CLIENT_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02;

--添加收货地址，收货人
alter table STO_CHANGEORDER add	SEND_ADDR varchar(255);
alter table STO_CHANGEORDER add TELEPHONE varchar(30);
alter table STO_CHANGEORDER add LINKMAN varchar(20);
