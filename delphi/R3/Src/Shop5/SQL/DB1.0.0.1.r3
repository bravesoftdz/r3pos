--商品价格
CREATE TABLE [PUB_GOODSPRICE] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --客户类型 # 号为所有客户
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --货号编码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --定价方式<变价方式>
	[PRICE_METHOD] [varchar] (1) NOT NULL ,
        --计量单位售价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --包装1单位售价
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --包装2单位售价
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_PUB_GOODSPRICE_COMM] DEFAULT ('00'),
        --更新时间 从2011-01-01开始的秒数
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_GOODSPRICE] PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
);

CREATE INDEX IX_PUB_GOODSPRICE_TENANT_ID ON PUB_GOODSPRICE(TENANT_ID);
CREATE INDEX IX_PUB_GOODSPRICE_SHOP_ID ON PUB_GOODSPRICE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_PUB_GOODSPRICE_GODS_ID ON PUB_GOODSPRICE(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSPRICE_PRICE_ID ON PUB_GOODSPRICE(TENANT_ID,PRICE_ID);
CREATE INDEX IX_PUB_GOODSPRICE_TIME_STAMP ON PUB_GOODSPRICE(TENANT_ID,TIME_STAMP);

--每个门店都有记录，关联需加门店
--各商品价格
CREATE view [VIW_GOODSPRICE]
as
select A.[TENANT_ID],A.[RELATION_ID],C.SHOP_ID,
       ifnull(B.[PRICE_ID],'#') as PRICE_ID,A.[GODS_ID],A.[GODS_CODE],A.[GODS_ID] as SECOND_ID,A.[GODS_NAME],A.[GODS_SPELL],A.[GODS_TYPE],
       A.[SORT_ID1],A.[SORT_ID2],A.[SORT_ID3],A.[SORT_ID4],A.[SORT_ID5],A.[SORT_ID6],A.[SORT_ID7],A.[SORT_ID8],
       A.[BARCODE],A.[UNIT_ID],A.[CALC_UNITS],A.[SMALL_UNITS],A.[BIG_UNITS],A.[SMALLTO_CALC],A.[BIGTO_CALC],A.[NEW_INPRICE],A.[NEW_OUTPRICE] as RTL_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when ifnull(B.COMM,'02') not in ('02','12') then B.[NEW_OUTPRICE] else A.[NEW_OUTPRICE] end NEW_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE1],B.[NEW_OUTPRICE]*A.SMALLTO_CALC) else A.[NEW_OUTPRICE]*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE2],B.[NEW_OUTPRICE]*A.BIGTO_CALC) else A.[NEW_OUTPRICE]*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.[NEW_LOWPRICE],A.[USING_BARTER],A.[BARTER_INTEGRAL],
       A.[USING_PRICE],A.[HAS_INTEGRAL],A.[USING_BATCH_NO],A.[USING_LOCUS_NO],A.[REMARK],A.[COMM],A.[TIME_STAMP]
from VIW_GOODSINFO A inner join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID
left join PUB_GOODSPRICE B ON C.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.PRICE_ID=B.PRICE_ID;

--商品扩展表
CREATE TABLE [PUB_GOODSINFOEXT] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --货号编码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --计量单位最新进价
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --包装1单位最新进价
	[NEW_INPRICE1] [decimal](18, 3) NULL ,
        --包装2单位最新进价
	[NEW_INPRICE2] [decimal](18, 3) NULL ,
        --安全库存
	[LOWER_AMOUNT] [decimal](18, 3) NULL ,
        --上限库存
	[UPPER_AMOUNT] [decimal](18, 3) NULL ,
        --最低存销比
	[LOWER_RATE] [decimal](18, 3) NULL ,
        --最高存销比
	[UPPER_RATE] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_PUB_GOODSINFOEXT_COMM] DEFAULT ('00'),
        --更新时间 从2011-01-01开始的秒数
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_GOODSINFOEXT] PRIMARY KEY (TENANT_ID,GODS_ID)
);
CREATE INDEX IX_PUB_GOODSINFOEXT_TENANT_ID ON PUB_GOODSINFOEXT(TENANT_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_GODS_ID ON PUB_GOODSINFOEXT(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_TIME_STAMP ON PUB_GOODSINFOEXT(TENANT_ID,TIME_STAMP);

--每个门店都有记录，关联需加门店
CREATE view [VIW_GOODSPRICEEXT]
as
    SELECT 
      j1.TENANT_ID as TENANT_ID,j1.SHOP_ID, 
      j1.GODS_ID as GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE else J2.NEW_INPRICE end as NEW_INPRICE,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.SMALLTO_CALC else J2.NEW_INPRICE1 end as NEW_INPRICE1,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.BIGTO_CALC else J2.NEW_INPRICE2 end as NEW_INPRICE2,
       NEW_OUTPRICE,
       NEW_OUTPRICE1,
       NEW_OUTPRICE2,
       NEW_LOWPRICE,
       SORT_ID1,SORT_ID7,SORT_ID8,USING_BARTER,BARTER_INTEGRAL,RELATION_ID
    FROM 
      VIW_GOODSPRICE j1 LEFT JOIN 
      PUB_GOODSINFOEXT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.GODS_ID = j2.GODS_ID; 
            
--每个门店都有记录，关联需加门店
CREATE view [VIW_GOODSPRICE_SORTEXT]
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSPRICEEXT j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
      
--商品分类视图不分门店
CREATE view [VIW_GOODSINFO_SORTEXT]
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSINFO j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
          
--变价记录
CREATE TABLE [LOG_PRICING_INFO] (
        --行号ID
	[ROWS_ID] [varchar] (36) NOT NULL ,
        --变价日期 20080101
	[PRICING_DATE] int NOT NULL , 
        --操作员
	[PRICING_USER] varchar(36) NOT NULL , 
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --客户类型 # 号为所有客户
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --门店代码 0 时代码所有门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --货号编码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --定价方式
	[PRICE_METHOD] [varchar] (1) NOT NULL ,
        --计量单位售价
	[ORG_OUTPRICE] [decimal](18, 3) NULL ,
        --包装1单位售价
	[ORG_OUTPRICE1] [decimal](18, 3) NULL ,
        --包装2单位售价
	[ORG_OUTPRICE2] [decimal](18, 3) NULL ,
        --计量单位售价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --包装1单位售价
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --包装2单位售价
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_LOG_PRICING_INFO_COMM] DEFAULT ('00'),
        --更新时间 从2011-01-01开始的秒数
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_LOG_PRICING_INFO] PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_LOG_PRICING_INFO_TENANT_ID ON LOG_PRICING_INFO(TENANT_ID);
CREATE INDEX IX_LOG_PRICING_INFO_PRICING_DATE ON LOG_PRICING_INFO(TENANT_ID,PRICING_DATE);
CREATE INDEX IX_LOG_PRICING_INFO_TIME_STAMP ON LOG_PRICING_INFO(TENANT_ID,TIME_STAMP);

--当前库存
CREATE TABLE [STO_STORAGE] (
        --行ID
	[ROWS_ID] varchar(36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --批号，没批号用 #号
	[BATCH_NO] [varchar] (20) NOT NULL,
        --货品代码
	[GODS_ID] [varchar] (38) NOT NULL ,
        --尺码 不分的用 #号
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色 不分的用 #号
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --最近入库日期
	[NEAR_INDATE] [varchar] (10) NULL ,
        --最近出库日期
	[NEAR_OUTDATE] [varchar] (10) NULL ,
        --成本金额
	[AMONEY] [decimal](18, 3) NOT NULL ,
        --库存数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --成本单价
	[COST_PRICE] [decimal](18, 6) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_STORAGE_COMM] DEFAULT ('00'),
        --时间戳 从2011-01-01开始的秒数
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_STO_STORAGE] PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_STO_STORAGE_TENANT_ID ON STO_STORAGE(TENANT_ID);
CREATE INDEX IX_STO_STORAGE_TIME_STAMP ON STO_STORAGE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_STORAGE_GODS_ID ON STO_STORAGE(TENANT_ID,GODS_ID);
CREATE INDEX IX_STO_STORAGE_SHOP_ID ON STO_STORAGE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_STO_STORAGE_KEYINDEX ON STO_STORAGE(TENANT_ID,SHOP_ID,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO);

--会员是否再打折
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','不打折','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','再打折','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','指定折','RATE_OFF','00',5497000);

--促销单表头<单据都以表头COMM,TIME_STAMP通讯标志为准>
CREATE TABLE [SAL_PRICEORDER] (
        --记录ID号
	[PROM_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --开单门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --开始时间 yyyy-mm-dd hh:mm:ss
	[BEGIN_DATE] [varchar] (25) NOT NULL ,
        --结束时间 yyyy-mm-dd hh:mm:ss
	[END_DATE] [varchar] (25) NOT NULL ,
        --会员等级#号时对所有客户
	[PRICE_ID] [varchar] (36) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --制单日期
	[CREA_DATE] int NULL ,
        --制单人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_PRICEORDER_COMM] DEFAULT ('00'),
        --时间戳 从2011-01-01开始的秒数
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_SAL_PRICEORDER] PRIMARY KEY (TENANT_ID,PROM_ID)
);

CREATE INDEX IX_SAL_PRICEORDER_TENANT_ID ON SAL_PRICEORDER(TENANT_ID);
CREATE INDEX IX_SAL_PRICEORDER_TIME_STAMP ON SAL_PRICEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_PRICEORDER_SHOP_ID ON SAL_PRICEORDER(TENANT_ID,SHOP_ID);

--促销单发布门店
CREATE TABLE [SAL_PROM_SHOP] (
        --行ID
	[ROWS_ID] varchar(36) NOT NULL ,
        --记录ID号
	[PROM_ID] [varchar] (50) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
  CONSTRAINT [PK_SAL_PROM_SHOP] PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_SHOP_ID ON SAL_PROM_SHOP(TENANT_ID,PROM_ID);

--促销单明细
CREATE TABLE [SAL_PRICEDATA] (
        --记录ID号
	[PROM_ID] [varchar] (50) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --商品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --计量单位售价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --包装1单位售价
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --包装2单位售价
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --会员是否再打折
	[RATE_OFF] [int] NOT NULL ,
        --会员再打折率
	[AGIO_RATE] [numeric](18, 3) NULL ,
        --是否积分 1为只对会员,0为不积分
	[ISINTEGRAL] [int] NOT NULL ,
	CONSTRAINT [PK_SAL_PRICEDATA] PRIMARY KEY  
	(
		[PROM_ID],[TENANT_ID],[SEQNO]
	) 
);

CREATE INDEX IX_SAL_PRICEDATA_TENANT_ID ON SAL_PRICEDATA(TENANT_ID);
CREATE INDEX IX_SAL_PRICEDATA_GODS_ID ON SAL_PRICEDATA(GODS_ID);

--各门店促销价格
CREATE view [VIW_PROM_PRICE]
as
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROM_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROM_ID=B.PROM_ID and A.TENANT_ID=C.TENANT_ID and A.PROM_ID=C.PROM_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
B.BEGIN_DATE<=strftime('%Y-%m-%d %H:%M:%S','now','localtime') and B.END_DATE>=strftime('%Y-%m-%d %H:%M:%S','now','localtime');

--发票类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','收款收据','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','普通发票','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','增值税票','INVOICE_FLAG','00',5497000);

--入库类单据类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','入库单','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','STOCK_TYPE','00',5497000);

--入库单表头
CREATE TABLE [STK_STOCKORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --入库单号
	[STOCK_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --单据类型
	[STOCK_TYPE] [int] NOT NULL,
        --入库日期
	[STOCK_DATE] int NOT NULL ,
        --采购员
	[GUIDE_USER] [varchar] (36) NULL ,
        --供应商
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --订货单号
	[FROM_ID] [varchar] (36) NULL ,
        --配货单号
	[FIG_ID] [varchar] (36) NULL ,
        --调拨单号
	[DBOUT_ID] [varchar] (36) NULL ,
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --入库数量
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --入库金额
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --发票类型
	[INVOICE_FLAG] [varchar] (1) NOT NULL ,
        --进项税率
	[TAX_RATE] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_STOCKORDER_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STK_STOCKORDER] PRIMARY KEY 
	(
		[SHOP_ID],
		[STOCK_ID]
	)
);

CREATE INDEX IX_STK_STOCKORDER_TENANT_ID ON STK_STOCKORDER(TENANT_ID);
CREATE INDEX IX_STK_STOCKORDER_TIME_STAMP ON STK_STOCKORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_STOCKORDER_STOCK_DATE ON STK_STOCKORDER(STOCK_DATE);

--业务类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','正常','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','赠送','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','兑换','IS_PRESENT','00',5497000);

--入库单明细
CREATE TABLE [STK_STOCKDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --入库单号
	[STOCK_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码<不分时用 # 号>
	[PROPERTY_01] [varchar] (20) NOT NULL ,
        --颜色<不分时用 # 号>
	[PROPERTY_02] [varchar] (20) NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --进货单位标准售价
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --入库类型<是否赠品>
	[IS_PRESENT] [int] NOT NULL,
        --现售价
	[APRICE] [decimal](18, 3) NULL ,
        --金额
	[AMONEY] [decimal](18, 3) NULL ,
        --折扣率
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --折扣额
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --计量单位数据
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --入库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_STK_STOCKDATA] PRIMARY KEY  
	(
		[TENANT_ID],
		[STOCK_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_STK_STOCKDATA_TENANT_ID ON STK_STOCKDATA(TENANT_ID);
CREATE INDEX IX_STK_STOCKDATA_GODS_ID ON STK_STOCKDATA(TENANT_ID,GODS_ID);

--进货单视图<含退货>
CREATE VIEW VIW_STOCKDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--调拨接收单视图
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,
   A.CALC_AMOUNT,A.CALC_MONEY as COST_MONEY,A.ORG_PRICE*A.AMOUNT as RTL_MONEY,A.AMOUNT
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','销售单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','零售单','SALES_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','销售方式','CODE_TYPE','00',5497000);

--销售单表头
CREATE TABLE [SAL_SALESORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --销售单号
	[SALES_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --销售日期
	[SALES_DATE] int NOT NULL ,
        --单据类型
	[SALES_TYPE] [int] NOT NULL,
        --客户代码
	[CLIENT_ID] [varchar] (36) NULL ,
        --IC卡号
	[IC_CARDNO] [varchar] (36) NULL ,
        --商盟编码
	[UNION_ID] [varchar] (36) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --订货单号
	[FROM_ID] [varchar] (36) NULL ,
        --配货单号
	[FIG_ID] [varchar] (36) NULL ,
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --销售数量
	[SALE_AMT] [decimal](18, 3) NULL ,
        --销售金额
	[SALE_MNY] [decimal](18, 3) NULL ,
        --抹零金额
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --实收现金
	[CASH_MNY] [decimal](18, 3) NULL ,
        --现金找零
	[PAY_ZERO] [decimal](18, 3) NULL ,
        --结算方式
	[PAY_A] [decimal](18, 3) NULL ,
	[PAY_B] [decimal](18, 3) NULL ,
	[PAY_C] [decimal](18, 3) NULL ,
	[PAY_D] [decimal](18, 3) NULL ,
	[PAY_E] [decimal](18, 3) NULL ,
	[PAY_F] [decimal](18, 3) NULL ,
	[PAY_G] [decimal](18, 3) NULL ,
	[PAY_H] [decimal](18, 3) NULL ,
	[PAY_I] [decimal](18, 3) NULL ,
	[PAY_J] [decimal](18, 3) NULL ,
        --本单积分
	[INTEGRAL] [int] NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --发票类型
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --销项税率
	[TAX_RATE] [decimal](18, 3) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --制单人
	[CREA_USER] [varchar] (36) NULL ,
        --业务员<导购员>
	[GUIDE_USER] [varchar] (36) NULL ,
        --销售方式
	[SALES_STYLE] [varchar] (21) NULL ,
        --送货日期
	[PLAN_DATE] [varchar] (10) NULL ,
        --联系人
	[LINKMAN] [varchar] (20) NULL ,
        --联系电话
	[TELEPHONE] [varchar] (30) NULL ,
        --送货地址
	[SEND_ADDR] [varchar] (255) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_SALESORDER_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_SALESORDER] PRIMARY KEY 
	(
		[TENANT_ID],
		[SALES_ID]
	) 
);

CREATE INDEX IX_SAL_SALESORDER_TENANT_ID ON SAL_SALESORDER(TENANT_ID);
CREATE INDEX IX_SAL_SALESORDER_TIME_STAMP ON SAL_SALESORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_SALESORDER_SALES_DATE ON SAL_SALESORDER(SALES_DATE);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','统一定价','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','门店定价','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','产品促销','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','变价销售','POLICY_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','付款方式','CODE_TYPE','00',5497000);

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','现金','XJ','1','1','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','银联','YL','1','2','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','储值卡','CZK','1','3','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','记账','JZ','1','4','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','礼券','LQ','1','5','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','支票','ZP','1','6','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('G','小额支付','XEZF','1','7','00',5497000);

CREATE VIEW VIW_PAYMENT
as
select B.TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,A.COMM,A.TIME_STAMP from PUB_CODE_INFO A,CA_TENANT B where A.TENANT_ID=0 and A.CODE_TYPE='1'
union all
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,COMM,TIME_STAMP from PUB_CODE_INFO where TENANT_ID>0 and CODE_TYPE='1';

--销售单明细
CREATE TABLE [SAL_SALESDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --销售单号
	[SALES_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --货品
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码<不分时用 # 号>
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色<不分时用 # 号>
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --销售单位标准售价
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --定价类型
	[POLICY_TYPE] [int] NOT NULL,
        --是否赠品
	[IS_PRESENT] [int] NOT NULL,
        --兑换积分<最小单位所需的积分>
	[BARTER_INTEGRAL] [int] NULL,
        --现售价
	[APRICE] [decimal](18, 3) NULL ,
        --金额
	[AMONEY] [decimal](18, 3) NULL ,
        --当前计量单位进价
	[COST_PRICE] [decimal](18, 3) NULL ,
        --折扣率
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --折扣额
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --计量单位数据
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --出库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --是否有积分
	[HAS_INTEGRAL] [int] NOT NULL ,
        --说明
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_SAL_SALESDATA] PRIMARY KEY  
	(
		[TENANT_ID],
		[SALES_ID],
		[SEQNO]
	)
) ;

CREATE INDEX IX_SAL_SALESDATA_TENANT_ID ON SAL_SALESDATA(TENANT_ID);
CREATE INDEX IX_SAL_SALESDATA_GODS_ID ON SAL_SALESDATA(TENANT_ID,GODS_ID);

--销售视图<含退货>
CREATE VIEW VIW_SALESDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.CREA_DATE,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT,A.TAX_RATE,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2)-round(B.CALC_AMOUNT*B.COST_PRICE,2) as PRF_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--调拨出货单视图
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as RTL_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.COST_PRICE,B.AMOUNT
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--流水类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','充值','IC_GLIDE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','支付','IC_GLIDE_TYPE','00',5497000);

--储值卡流水记录
CREATE TABLE [SAL_IC_GLIDE] (
        --流水ID号
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --客户ID<不记名卡用 #>
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC卡号
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --销售单号
	[SALES_ID] [varchar] (36) NULL ,
        --操作员
	[CREA_USER] [varchar] (36) NOT NULL ,
        --日期
	[CREA_DATE] int NOT NULL ,
        --摘要
	[GLIDE_INFO] [varchar] (100) NOT NULL ,
        --流水类型
	[IC_GLIDE_TYPE] [varchar] (1) NOT NULL ,
        --结算方式
	[PAY_A] [decimal](18, 3) NULL ,
	[PAY_B] [decimal](18, 3) NULL ,
	[PAY_C] [decimal](18, 3) NULL ,
	[PAY_D] [decimal](18, 3) NULL ,
	[PAY_E] [decimal](18, 3) NULL ,
	[PAY_F] [decimal](18, 3) NULL ,
	[PAY_G] [decimal](18, 3) NULL ,
	[PAY_H] [decimal](18, 3) NULL ,
	[PAY_I] [decimal](18, 3) NULL ,
	[PAY_J] [decimal](18, 3) NULL ,
        --金额
	[GLIDE_MNY] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_IC_GLIDE_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_IC_GLIDE] PRIMARY KEY   
	(
		[GLIDE_ID]
	) 
);

CREATE INDEX IX_SAL_IC_GLIDE_TENANT_ID ON SAL_IC_GLIDE(TENANT_ID);
CREATE INDEX IX_SAL_IC_GLIDE_TIME_STAMP ON SAL_IC_GLIDE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_IC_GLIDE_SALES_ID ON SAL_IC_GLIDE(TENANT_ID,SALES_ID);
CREATE INDEX IX_SAL_IC_GLIDE_CREA_DATE ON SAL_IC_GLIDE(CREA_DATE);
CREATE INDEX IX_SAL_IC_GLIDE_CLIENT_ID ON SAL_IC_GLIDE(TENANT_ID,CLIENT_ID);

--积分类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','赠送积分','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','兑换礼券','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','返还现金','INTEGRAL_FLAG','00',5497000);

--积分对换
CREATE TABLE [SAL_INTEGRAL_GLIDE] (
        --流水ID号
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --客户ID
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC卡号
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --流水日期
	[CREA_DATE] int NOT NULL ,
        --操作员
	[CREA_USER] [varchar] (36) NOT NULL ,
        --类型
	[INTEGRAL_FLAG] [varchar] (1) NOT NULL ,
        --摘要
	[GLIDE_INFO] [varchar] (255) NOT NULL ,
        --积分
	[INTEGRAL] [decimal](18, 3) NULL ,
        --对换值<礼券张数，或现金金额>
	[GLIDE_AMT] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INTEGRAL_GLIDE_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INTEGRAL_GLIDE] PRIMARY KEY 
	(
		[GLIDE_ID]
	)
);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_TENANT_ID ON SAL_INTEGRAL_GLIDE(TENANT_ID);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_TIME_STAMP ON SAL_INTEGRAL_GLIDE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CREA_DATE ON SAL_INTEGRAL_GLIDE(CREA_DATE);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CLIENT_ID ON SAL_INTEGRAL_GLIDE(TENANT_ID,CLIENT_ID);


--调整单类型 最多能添加种类型 1,2,3,4,5 代码分别为
CREATE TABLE [STO_CHANGECODE] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --代码
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --名称
	[CHANGE_NAME] [varchar] (20) NOT NULL ,
        --出入类型
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGECODE_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_CHANGECODE] PRIMARY KEY 
	(
		[TENANT_ID],[CHANGE_CODE]
	) 
);

insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','损益','2','00',5497000);
insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','领用','2','00',5497000);

--调整单
CREATE TABLE [STO_CHANGEORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --调整日期
	[CHANGE_DATE] int NOT NULL ,
        --出入类型
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --类型代码
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --所属部门
	[DEPT_ID] int NULL ,
        --负责人
	[DUTY_USER] [varchar] (36) NULL ,
        --调整数量
	[CHANGE_AMT] [decimal](18, 3) NULL ,
        --调整金额
	[CHANGE_MNY] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --审核用户
	[CHK_USER] [varchar] (36) NULL ,
        --审核人员
	[CHK_DATE] [varchar] (10) NULL ,
        --来源单号,对盘点单时对应盘点表的ID号
	[FROM_ID] [varchar] (36) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGEORDER_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_CHANGEORDER] PRIMARY KEY  
	(
		[CHANGE_ID],
		[TENANT_ID]
	)
);

CREATE INDEX IX_STO_CHANGEORDER_TENANT_ID ON STO_CHANGEORDER(TENANT_ID);
CREATE INDEX IX_STO_CHANGEORDER_TIME_STAMP ON STO_CHANGEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_CHANGEORDER_SALES_DATE ON STO_CHANGEORDER(CHANGE_DATE);

--库存调整单明细
CREATE TABLE [STO_CHANGEDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码 不分的用 #号
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色 不分的用 #号
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --是否赠品
	[IS_PRESENT] [int] NOT NULL,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36)  NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --现售价
	[APRICE] [decimal](18, 3) NULL ,
        --金额
	[AMONEY] [decimal](18, 3) NULL ,
        --计量单位数据
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --当前计量单位进价
	[COST_PRICE] [decimal](18, 3) NULL ,
        --出库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --调整说明
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_STO_CHANGEDATA] PRIMARY KEY   
	(
		[TENANT_ID],
    [CHANGE_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_STO_CHANGEDATA_TENANT_ID ON STO_CHANGEDATA(TENANT_ID);
CREATE INDEX IX_STO_CHANGEDATA_GODS_ID ON STO_CHANGEDATA(TENANT_ID,GODS_ID);

CREATE VIEW VIW_CHANGEDATA
as
select
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,B.CREA_DATE,A.APRICE,A.COST_PRICE,B.DEPT_ID,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.AMOUNT as AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_MONEY as RTL_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as COST_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM1_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM2_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM3_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM4_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM5_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM5_MONEY
from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.COMM not in ('02','12');

--进货订单
CREATE TABLE [STK_INDENTORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号
	[INDE_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --订货日期
	[INDE_DATE] int NULL ,
        --送货日期
	[PLAN_DATE] [varchar] (10) NULL ,
        --联系人
	[LINKMAN] [varchar] (20) NULL ,
        --联系电话
	[TELEPHONE] [varchar] (30) NULL ,
        --送货地址
	[SEND_ADDR] [varchar] (255) NULL ,
        --采购员
	[GUIDE_USER] [varchar] (30) NULL ,
        --供应商
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --配货单号
	[FIG_ID] [varchar] (36) NULL ,
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --订货数量
	[INDE_AMT] [decimal](18, 3) NULL ,
        --订货金额
	[INDE_MNY] [decimal](18, 3) NULL ,
        --发票类型
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --进项税率
	[TAX_RATE] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_INDENTORDER_COMM] DEFAULT ('00'),
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STK_INDENTORDER] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID]
	) 
);

CREATE INDEX IX_STK_INDENTORDER_TENANT_ID ON STK_INDENTORDER(TENANT_ID);
CREATE INDEX IX_STK_INDENTORDER_TIME_STAMP ON STK_INDENTORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_INDENTORDER_INDE_DATE ON STK_INDENTORDER(INDE_DATE);

--进货订单明细
CREATE TABLE [STK_INDENTDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --订单号
	[INDE_ID] [varchar] (36) NOT NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36)  NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --需求数量
	[DEMAND_AMOUNT] [decimal](18, 3) NULL ,
        --订货数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --原单价
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --是否赠品
	[IS_PRESENT] [int] NOT NULL,
        --现售价
	[APRICE] [decimal](18, 3) NULL ,
        --金额
	[AMONEY] [decimal](18, 3) NULL ,
        --折扣率
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --折扣额
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --计量单位数量
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --到货数量
	[FNSH_AMOUNT] [decimal](18, 3) NULL ,
        --入库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_STK_INDENTDATA] PRIMARY KEY  
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	)
);

CREATE INDEX IX_STK_INDENTDATA_TENANT_ID ON STK_INDENTDATA(TENANT_ID);
CREATE INDEX IX_STK_INDENTDATA_GODS_ID ON STK_INDENTDATA(TENANT_ID,GODS_ID);

--进货订单视图
CREATE VIEW VIW_STKINDENTDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--销售订单
CREATE TABLE [SAL_INDENTORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号
	[INDE_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --订货日期
	[INDE_DATE] int NOT NULL ,
        --送货日期
	[PLAN_DATE] [varchar] (10) NULL ,
        --联系人
	[LINKMAN] [varchar] (20) NULL ,
        --联系电话
	[TELEPHONE] [varchar] (30) NULL ,
        --送货地址
	[SEND_ADDR] [varchar] (255) NULL ,
        --业务员<导购员>
	[GUIDE_USER] [varchar] (36) NULL ,
        --销售方式
	[SALES_STYLE] [varchar] (21) NULL ,
        --客户
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC卡号
	[IC_CARDNO] [varchar] (36) NULL ,
        --商盟编码
	[UNION_ID] [varchar] (36) NULL ,
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --订货数量
	[INDE_AMT] [decimal](18, 3) NULL ,
        --订货金额
	[INDE_MNY] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --配货单号
	[FIG_ID] [varchar] (36) NULL ,
        --发票类型
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --销项税率
	[TAX_RATE] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INDENTORDER_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INDENTORDER] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID]
	)
);

CREATE INDEX IX_SAL_INDENTORDER_TENANT_ID ON SAL_INDENTORDER(TENANT_ID);
CREATE INDEX IX_SAL_INDENTORDER_TIME_STAMP ON SAL_INDENTORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INDENTORDER_SALES_DATE ON SAL_INDENTORDER(INDE_DATE);

--销售订单明细
CREATE TABLE [SAL_INDENTDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --订单号
	[INDE_ID] [varchar] (36) NOT NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36)  NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NULL ,
        --需求数量
	[DEMAND_AMOUNT] [decimal](18, 3) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --原单价
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --定价类型
	[POLICY_TYPE] [int] NOT NULL,
        --是否赠品
	[IS_PRESENT] [int] NOT NULL,
        --兑换积分
	[BARTER_INTEGRAL] [int] NULL,
        --现售价
	[APRICE] [decimal](18, 3) NULL ,
        --金额
	[AMONEY] [decimal](18, 3) NULL ,
        --折扣率
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --折扣额
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --计量单位数量
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --执行数量
	[FNSH_AMOUNT] [decimal](18, 3) NULL ,
        --入库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --是否有积分
	[HAS_INTEGRAL] [int] NOT NULL ,
	CONSTRAINT [PK_SAL_INDENTDATA] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_SAL_INDENTDATA_TENANT_ID ON SAL_INDENTDATA(TENANT_ID);
CREATE INDEX IX_SAL_INDENTDATA_GODS_ID ON SAL_INDENTDATA(TENANT_ID,GODS_ID);

--销售订单视图
CREATE VIEW VIW_SALINDENTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,A.GUIDE_USER,B.POLICY_TYPE,A.INDE_DATE,A.INDE_ID,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.HAS_INTEGRAL,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_INDENTORDER A,SAL_INDENTDATA B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and A.COMM not in ('02','12');

--盘点状态 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','待盘点','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','已盘点','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','已审核','CHECK_STATUS','00',5497000);

--盘点方式 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','简单盘点','CHECK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','多人盘点','CHECK_TYPE','00',5497000);

--盘点表表头
CREATE TABLE [STO_PRINTORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --盘点日期 
	[PRINT_DATE] int NOT NULL ,
        --盘点状态
	[CHECK_STATUS] [int] NOT NULL ,
        --盘点方式
	[CHECK_TYPE] [int] NOT NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --审核用户
	[CHK_USER] [varchar] (36) NULL ,
        --审核人员
	[CHK_DATE] [varchar] (10) NULL ,
        --通读标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_PRINTORDER_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_PRINTORDER] PRIMARY KEY 
	(
		[TENANT_ID],
		[SHOP_ID],
		[PRINT_DATE]
	)
);

CREATE INDEX IX_STO_PRINTORDER_TENANT_ID ON STO_PRINTORDER(TENANT_ID);
CREATE INDEX IX_STO_PRINTORDER_PRINT_DATE ON STO_PRINTORDER(SHOP_ID,PRINT_DATE);

--盘点表明细
CREATE TABLE [STO_PRINTDATA] (
        --行号
	[ROWS_ID] varchar(36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --盘点日期 
	[PRINT_DATE] int NOT NULL ,
        --批号，没批号用 #号
	[BATCH_NO] [varchar] (36) NOT NULL,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36) NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码 不分的用 #号
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色 不分的用 #号
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --帐面库存
	[RCK_AMOUNT] [decimal](18, 3) NULL ,
        --盘点库存
	[CHK_AMOUNT] [decimal](18, 3) NULL ,
        --盘点状态 
	[CHECK_STATUS] [varchar] (6) NOT NULL ,
	CONSTRAINT [PK_STO_PRINTDATA] PRIMARY KEY  
	(
		[ROWS_ID]
	)
);

CREATE INDEX IX_STO_PRINTDATA_TENANT_ID ON STO_PRINTDATA(TENANT_ID);
CREATE INDEX IX_STO_PRINTDATA_SHOP_ID ON STO_PRINTDATA(SHOP_ID);
CREATE INDEX IX_STO_PRINTDATA_GODS_ID ON STO_PRINTDATA(GODS_ID);
CREATE INDEX IX_STO_PRINTDATA_PRINT_DATE ON STO_PRINTDATA(SHOP_ID,PRINT_DATE);

--盘点录入表
CREATE TABLE [STO_CHECKDATA] (
        --行号
	[ROWS_ID] varchar(36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --盘点日期 
	[PRINT_DATE] int NOT NULL ,
        --批号，没批号用 #号
	[BATCH_NO] [varchar] (36) NOT NULL,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --礼盒跟踪号
	[BOM_ID] [varchar] (36) NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --尺码 不分的用 #号
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色 不分的用 #号
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --帐面库存
	[AMOUNT] [decimal](18, 3) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
	CONSTRAINT [PK_CHK_CHECKDATA] PRIMARY KEY  
	(
		[ROWS_ID]
	)
);

CREATE INDEX IX_STO_CHECKDATA_TENANT_ID ON STO_CHECKDATA(TENANT_ID);
CREATE INDEX IX_STO_CHECKDATA_SHOP_ID ON STO_CHECKDATA(SHOP_ID);
CREATE INDEX IX_STO_CHECKDATA_GODS_ID ON STO_CHECKDATA(GODS_ID);
CREATE INDEX IX_STO_CHECKDATA_PRINT_DATE ON STO_CHECKDATA(SHOP_ID,PRINT_DATE);

--帐户档案
CREATE TABLE [ACC_ACCOUNT_INFO] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --帐户代码
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --所属门店<为每个门店自动创建一个<现金账户>
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --帐户名称
	[ACCT_NAME] [varchar] (50) NOT NULL ,
        --拼音码
	[ACCT_SPELL] [varchar] (50) NOT NULL ,
        --对应支付方式
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --期初余额
	[ORG_MNY] [decimal](18, 3) NULL ,
        --支收总额 
	[OUT_MNY] [decimal](18, 3) NULL ,
        --收入总额 
	[IN_MNY] [decimal](18, 3) NULL ,
        --当前余额
	[BALANCE] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_ACCOUNT_INFO_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_ACCOUNT_INFO] PRIMARY KEY  
	(
		[TENANT_ID],[ACCOUNT_ID]
	)
) ;

CREATE INDEX IX_ACC_ACCOUNT_INFO_TENANT_ID ON ACC_ACCOUNT_INFO(TENANT_ID);
CREATE INDEX IX_ACC_ACCOUNT_INFO_TIME_STAMP ON ACC_ACCOUNT_INFO(TENANT_ID,TIME_STAMP);

CREATE VIEW VIW_ACCOUNT_INFO
as
select TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM,TIME_STAMP from ACC_ACCOUNT_INFO;

--定义收支项目编号
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','收支项目','CODE_TYPE','00',5497000);

CREATE VIEW VIW_ITEM_INFO
as
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE=3;


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','应收款','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','应退款','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','预付款','RECV_TYPE','00',5497000);

--应收帐款
CREATE TABLE [ACC_RECVABLE_INFO] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --序号
	[ABLE_ID] [varchar] (36) NOT NULL ,
        --客户
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --摘要
	[ACCT_INFO] [varchar] (255) NOT NULL ,
        --类型
	[RECV_TYPE] [varchar] (1) NOT NULL ,
        --帐款金额
	[ACCT_MNY] [decimal](18, 3) NULL ,
        --已收金额
	[RECV_MNY] [decimal](18, 3) NULL ,
        --结余金额
	[RECK_MNY] [decimal](18, 3) NULL ,
        --冲帐金额
	[REVE_MNY] [decimal](18, 3) NULL ,
        --帐款日期
	[ABLE_DATE] int NULL ,
        --最近收款日期
	[NEAR_DATE] [varchar] (10) NULL ,
        --来源单号
	[SALES_ID] [varchar] (50) NULL ,
        --记录生成日期
	[CREA_DATE] [varchar] (30) NULL ,
        --操作用户
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_RECVABLE_INFO_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_RECVABLE_INFO] PRIMARY KEY  
	(
		[TENANT_ID],[ABLE_ID]
	)
) ;

CREATE INDEX IX_ACC_RECVABLE_INFO_TENANT_ID ON ACC_RECVABLE_INFO(TENANT_ID);
CREATE INDEX IX_ACC_RECVABLE_INFO_TIME_STAMP ON ACC_RECVABLE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_RECVABLE_INFO_ABLE_DATE ON ACC_RECVABLE_INFO(ABLE_DATE);
CREATE INDEX IX_ACC_RECVABLE_INFO_CLIENT_ID ON ACC_RECVABLE_INFO(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_ACC_RECVABLE_INFO_SALES_ID ON ACC_RECVABLE_INFO(SALES_ID);


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','应付款','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','应退款','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','预付款','ABLE_TYPE','00',5497000);

--应付帐款
CREATE TABLE [ACC_PAYABLE_INFO] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --序号
	[ABLE_ID] [varchar] (36) NOT NULL ,
        --供应商
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --摘要
	[ACCT_INFO] [varchar] (255) NOT NULL ,
        --类型
	[ABLE_TYPE] [varchar] (1) NOT NULL ,
        --帐款金额
	[ACCT_MNY] [decimal](18, 3) NULL ,
        --已付金额
	[PAYM_MNY] [decimal](18, 3) NULL ,
        --结余金额
	[RECK_MNY] [decimal](18, 3) NULL ,
        --冲帐金额
	[REVE_MNY] [decimal](18, 3) NULL ,
        --帐款日期
	[ABLE_DATE] int NULL ,
        --最近付款日期
	[NEAR_DATE] [varchar] (10) NULL ,
        --来源单号
	[STOCK_ID] [varchar] (50) NULL ,
        --记录生成日期
	[CREA_DATE] [varchar] (20) NULL ,
        --操作用户
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_PAYABLE_INFO_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_PAYABLE_INFO] PRIMARY KEY  
	(
		[TENANT_ID],[ABLE_ID]
	) 
) ;

CREATE INDEX IX_ACC_PAYABLE_INFO_TENANT_ID ON ACC_PAYABLE_INFO(TENANT_ID);
CREATE INDEX IX_ACC_PAYABLE_INFO_TIME_STAMP ON ACC_PAYABLE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_PAYABLE_INFO_ABLE_DATE ON ACC_PAYABLE_INFO(ABLE_DATE);
CREATE INDEX IX_ACC_PAYABLE_INFOCLIENT_ID ON ACC_PAYABLE_INFO(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_ACC_PAYABLE_INFO_STOCK_ID ON ACC_PAYABLE_INFO(STOCK_ID);

--付款单
CREATE TABLE [ACC_PAYORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[PAY_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --供应商
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --帐户代码
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --付款方式
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --收支项目
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --财务日期
	[PAY_DATE] int NULL ,
        --付款人
	[PAY_USER] [varchar] (30) NULL ,
        --付款总计
	[PAY_MNY] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_PAYORDER_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_PAYORDER] PRIMARY KEY 
	(
		[TENANT_ID],[PAY_ID]
	) 
) ;

CREATE INDEX IX_ACC_PAYORDER_TENANT_ID ON ACC_PAYORDER(TENANT_ID);
CREATE INDEX IX_ACC_PAYORDER_TIME_STAMP ON ACC_PAYORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_PAYORDER_PAY_DATE ON ACC_PAYORDER(PAY_DATE);
CREATE INDEX IX_ACC_PAYORDER_INFO_CLIENT_ID ON ACC_PAYORDER(CLIENT_ID);

--付款单明细
CREATE TABLE [ACC_PAYDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[PAY_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --帐款ID号
	[ABLE_ID] [varchar] (36) NOT NULL ,
        --类型
	[ABLE_TYPE] [varchar] (1) NOT NULL ,
        --支付金额
	[PAY_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_PAYDATA] PRIMARY KEY  
	(
		[TENANT_ID],[PAY_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_ACC_PAYDATA_TENANT_ID ON ACC_PAYDATA(TENANT_ID);
CREATE INDEX IX_ACC_PAYDATA_PAY_ID ON ACC_PAYDATA(TENANT_ID,PAY_ID);
CREATE INDEX IX_ACC_PAYDATA_ABLE_ID ON ACC_PAYDATA(TENANT_ID,ABLE_ID);

CREATE VIEW VIW_PAYDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.PAY_ID,A.ABLE_ID,A.ABLE_TYPE,A.PAY_MNY,B.PAY_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.PAY_USER,B.CHK_DATE,B.CHK_USER
from ACC_PAYDATA A,ACC_PAYORDER B where A.TENANT_ID=B.TENANT_ID and A.PAY_ID=B.PAY_ID and B.COMM not in ('02','12');

--收款单
CREATE TABLE [ACC_RECVORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[RECV_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --供应商
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --帐户代码
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --付款方式
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --收支项目
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --财务日期
	[RECV_DATE] int NULL ,
        --付款人
	[RECV_USER] [varchar] (30) NULL ,
        --收款合计
	[RECV_MNY] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_RECVORDER_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_RECVORDER] PRIMARY KEY 
	(
		[TENANT_ID],[RECV_ID]
	) 
) ;

CREATE INDEX IX_ACC_RECVORDER_TENANT_ID ON ACC_RECVORDER(TENANT_ID);
CREATE INDEX IX_ACC_RECVORDER_TIME_STAMP ON ACC_RECVORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_RECVORDER_PAY_DATE ON ACC_RECVORDER(RECV_DATE);
CREATE INDEX IX_ACC_RECVORDER_INFO_CLIENT_ID ON ACC_RECVORDER(CLIENT_ID);

--收款单明细
CREATE TABLE [ACC_RECVDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[RECV_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --帐款ID号
	[ABLE_ID] [varchar] (36) NOT NULL ,
        --类型
	[RECV_TYPE] [varchar] (1) NOT NULL ,
        --支付金额
	[RECV_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_RECVDATA] PRIMARY KEY  
	(
		[TENANT_ID],[RECV_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_ACC_RECVDATA_TENANT_ID ON ACC_RECVDATA(TENANT_ID);
CREATE INDEX IX_ACC_RECVDATA_RECV_ID ON ACC_RECVDATA(TENANT_ID,RECV_ID);
CREATE INDEX IX_ACC_RECVDATA_ABLE_ID ON ACC_RECVDATA(TENANT_ID,ABLE_ID);

CREATE VIEW VIW_RECVDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.ABLE_ID,A.RECV_TYPE,A.RECV_MNY,B.RECV_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.RECV_USER,B.CHK_DATE,B.CHK_USER
from ACC_RECVDATA A,ACC_RECVORDER B where A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','收入','IORO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','支出','IORO_TYPE','00',5497000);

--收入支出
CREATE TABLE [ACC_IOROORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[IORO_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --客户名称
	[CLIENT_ID] [varchar] (36) NULL ,
        --收支项目
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --收支部门
	[DEPT_ID] [varchar] (10) NULL ,
        --收支日期
	[IORO_TYPE] [varchar] (1) NOT NULL ,
        --收支日期
	[IORO_DATE] int NOT NULL ,
        --负责人
	[IORO_USER] [varchar] (36) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_IOROORDER_COMM] DEFAULT ('00'),
        --时间戳
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_IOROORDER] PRIMARY KEY 
	(
		[TENANT_ID],[IORO_ID]
	) 
) ;

CREATE INDEX IX_ACC_IOROORDER_TENANT_ID ON ACC_IOROORDER(TENANT_ID);
CREATE INDEX IX_ACC_IOROORDER_TIME_STAMP ON ACC_IOROORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_IOROORDER_IORO_DATE ON ACC_IOROORDER(TENANT_ID,IORO_DATE);
CREATE INDEX IX_ACC_IOROORDER_CLIENT_ID ON ACC_IOROORDER(TENANT_ID,CLIENT_ID);

--收支明细
CREATE TABLE [ACC_IORODATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[IORO_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] [int] NOT NULL ,
        --收支账户
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --摘要
	[IORO_INFO] [varchar] (255) NOT NULL ,
        --收支金额
	[IORO_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_IORODATA] PRIMARY KEY  
	(
		[TENANT_ID],[IORO_ID],[SEQNO]
	) 
) ;
CREATE INDEX IX_ACC_IORODATA_TENANT_ID ON ACC_IORODATA(TENANT_ID);
CREATE INDEX IX_ACC_IORODATA_CLIENT_ID ON ACC_IORODATA(TENANT_ID,IORO_ID);

--收入支出视图
CREATE VIEW VIW_IORODATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.IORO_ID,A.ACCOUNT_ID,A.IORO_INFO,A.IORO_MNY,B.IORO_DATE,B.CLIENT_ID,B.ITEM_ID,B.DEPT_ID,B.GLIDE_NO,B.IORO_USER,
  case when B.IORO_TYPE='1' then A.IORO_MNY else 0 end as IN_MONEY,
  case when B.IORO_TYPE='2' then A.IORO_MNY else 0 end as OUT_MONEY
from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and B.COMM not in ('02','12');

--交班结账表
CREATE TABLE [ACC_CLOSE_FORDAY] (
        --行号
	[ROWS_ID] [varchar] (36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --关账日期
	[CLSE_DATE] int NULL ,
        --结算方式
	[PAY_A] [decimal](18, 3) NULL ,
	[PAY_B] [decimal](18, 3) NULL ,
	[PAY_C] [decimal](18, 3) NULL ,
	[PAY_D] [decimal](18, 3) NULL ,
	[PAY_E] [decimal](18, 3) NULL ,
	[PAY_F] [decimal](18, 3) NULL ,
	[PAY_G] [decimal](18, 3) NULL ,
	[PAY_H] [decimal](18, 3) NULL ,
	[PAY_I] [decimal](18, 3) NULL ,
	[PAY_J] [decimal](18, 3) NULL ,
	      --保留零钱
	[BALANCE] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_CLOSE_FORDAY_COMM] DEFAULT ('00'),
        --时间戳
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_CLOSE_FORDAY] PRIMARY KEY  
	(
		[ROWS_ID]
	) 
) ;
CREATE INDEX IX_ACC_CLOSE_FORDAY_TENANT_ID ON ACC_CLOSE_FORDAY(TENANT_ID);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATE ON ACC_CLOSE_FORDAY(CLSE_DATE);
CREATE INDEX IX_ACC_CLOSE_FORDAY_KEYFIELD ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

--存取款单
CREATE TABLE [ACC_TRANSORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[TRANS_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --转入账号
	[IN_ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --转出账号
	[OUT_ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --日期
	[TRANS_DATE] int NOT NULL ,
        --负责人
	[TRANS_USER] [varchar] (36) NULL ,
	      --存取金额
	[TRANS_MNY] [decimal](18, 3) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_TRANSORDER_COMM] DEFAULT ('00'),
        --时间戳
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_TRANSORDER] PRIMARY KEY 
	(
		[TENANT_ID],[TRANS_ID]
	) 
) ;

CREATE INDEX IX_ACC_TRANSORDER_TENANT_ID ON ACC_TRANSORDER(TENANT_ID);
CREATE INDEX IX_ACC_TRANSORDER_TIME_STAMP ON ACC_TRANSORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_TRANSORDER_TRANS_DATE ON ACC_TRANSORDER(TENANT_ID,TRANS_DATE);


--礼盒包装<BOM清单>
CREATE TABLE [SAL_BOMORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码<发布门店>
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号序号
	[BOM_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --礼盒编号
	[GIFT_CODE] [varchar] (36) NOT NULL ,
        --礼盒名称
	[GIFT_NAME] [varchar] (36) NOT NULL ,
        --条码
	[BARCODE] [varchar] (36) NOT NULL ,
        --礼盒数量
	[BOM_AMOUNT] [decimal](18, 3) NULL ,
        --结余数量
	[RCK_AMOUNT] [decimal](18, 3) NULL ,
        --零售价
	[RTL_PRICE] [decimal](18, 3) NULL ,
        --包装日期
	[BOM_DATE] int NOT NULL ,
        --负责人
	[BOM_USER] [varchar] (36) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --说明
	[REMARK] [varchar] (255) NULL ,
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_BOMORDER_COMM] DEFAULT ('00'),
        --时间戳
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_BOMORDER] PRIMARY KEY 
	(
		[TENANT_ID],[BOM_ID]
	) 
) ;

CREATE INDEX IX_SAL_BOMORDER_TENANT_ID ON SAL_BOMORDER(TENANT_ID);
CREATE INDEX IX_SAL_BOMORDER_TIME_STAMP ON SAL_BOMORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMORDER_BOM_DATE ON SAL_BOMORDER(TENANT_ID,BOM_DATE);

--礼盒子件商品清单<BOM清单>
CREATE TABLE [SAL_BOMDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --单号
	[BOM_ID] [varchar] (36) NOT NULL ,
        --序号
	[SEQNO] int NOT NULL,
        --批号，没批号用 #号
	[BATCH_NO] [varchar] (36) NOT NULL,
        --物流跟踪号
	[LOCUS_NO] [varchar] (36) NULL ,
        --货品代码
	[GODS_ID] [varchar] (36) NOT NULL ,
        --计量单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --尺码 不分的用 #号
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --颜色 不分的用 #号
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --一个礼盒所拥有的数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --一个礼盒所拥有的数量
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --礼盒单品销售单价
	[RTL_PRICE] [decimal](18, 3) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_BOMDATA_COMM] DEFAULT ('00'),
        --时间戳
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_BOMDATA] PRIMARY KEY 
	(
		[TENANT_ID],[BOM_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_SAL_BOMDATA_TENANT_ID ON SAL_BOMDATA(TENANT_ID);
CREATE INDEX IX_SAL_BOMDATA_TIME_STAMP ON SAL_BOMDATA(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMDATA_GODS_ID ON SAL_BOMDATA(TENANT_ID,GODS_ID);

--发票管理
CREATE TABLE [SAL_INVOICE_BOOK] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --流水ID号
	[INVH_ID] [varchar] (36) NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --领用人
	[CREA_USER] int NOT NULL ,
        --领用日期
	[CREA_DATE] int NOT NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --发票代码
	[INVH_NO] [varchar] (50) NOT NULL ,
        --发票起始号
	[BEGIN_NO] int NOT NULL ,
        --发票终止号
	[ENDED_NO] int NOT NULL ,
        --合计张数
	[TOTAL_AMT] int NULL ,
        --开票张数
	[USING_AMT] int NULL ,
        --作废张数
	[CANCEL_AMT] int NULL ,
        --结余张数
	[BALANCE] int NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INVOICE_BOOK_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INVOICE_BOOK] PRIMARY KEY   
	(
		[TENANT_ID],[INVH_ID]
	) 
);

CREATE INDEX IX_SAL_INVOICE_BOOK_TENANT_ID ON SAL_INVOICE_BOOK(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_BOOK_TIME_STAMP ON SAL_INVOICE_BOOK(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_BOOK_CREA_DATE ON SAL_INVOICE_BOOK(CREA_DATE);
CREATE INDEX IX_SAL_INVOICE_BOOK_SHOP_ID ON SAL_INVOICE_BOOK(TENANT_ID,SHOP_ID);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','开票','INVOICE_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','作废','INVOICE_STATUS','00',5497000);

--发票明细
CREATE TABLE [SAL_INVOICE_INFO] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --流水ID号
	[INVH_ID] [varchar] (36) NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --开票人
	[CREA_USER] [varchar] (36) NOT NULL ,
        --开票日期
	[CREA_DATE] int NOT NULL ,
        --客户编码
	[CLIENT_ID] [varchar] (36)  NOT NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
	      --发票号
	[INVOICE_NO] int NOT NULL ,
        --发票状态
	[INVOICE_STATUS] [varchar] (1) NOT NULL ,
        --销售单号
	[SALES_ID] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INVOICE_INFO_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INVOICE_INFO] PRIMARY KEY   
	(
		[TENANT_ID],[INVH_ID],[INVOICE_NO]
	) 
);

CREATE INDEX IX_SAL_INVOICE_INFO_TENANT_ID ON SAL_INVOICE_INFO(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_INFO_TIME_STAMP ON SAL_INVOICE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_INFO_CREA_DATE ON SAL_INVOICE_INFO(CREA_DATE);

--   台账规划      ---
--时间:2011-02-21
--初稿:张森荣

--日结账记录
CREATE TABLE [RCK_DAYS_CLOSE] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --日期
	[CREA_DATE] int NOT NULL ,
        --结账用户
	[CREA_USER] [varchar] (36) NOT NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_DAYS_CLOSE_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_DAYS_CLOSE] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[CREA_DATE]
	) 
);

--月结账记录
CREATE TABLE [RCK_MONTH_CLOSE] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --日期
	[MONTH] int NOT NULL ,
        --结账用户
	[CREA_USER] [varchar] (36) NOT NULL ,
        --开始日期
	[BEGIN_DATE] [varchar] (10) NULL ,
        --结束日期
	[END_DATE] [varchar] (10) NULL ,
        --审核日期
	[CHK_DATE] [varchar] (10) NULL ,
        --审核人员
	[CHK_USER] [varchar] (36) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_MONTH_CLOSE_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_MONTH_CLOSE] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[MONTH]
	) 
);

--商品日台账
CREATE TABLE [RCK_GOODS_DAYS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --日期
	[CREA_DATE] int NOT NULL ,
        --客户编码
	[GODS_ID] [varchar] (36)  NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,

--结账时进销价信息
        --当时进价
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --当时销价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--期初类台账		
        --期初数量
	[ORG_AMT] [decimal](18, 3) NULL ,
        --期初金额<按当时进价>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --期初成本<移动加权成本>
	[ORG_CST] [decimal](18, 3) NULL ,
	
--进货类台账	
        --进货数量<含退货>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --进货金额<末税>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --让利金额<供应商让利>
	[STOCK_AGO] [decimal](18, 3) NULL ,
	
        --其中退货数量
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --退货金额<末税>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--销售类台账	
        --销售数量<含退货>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --让利金额<销售让利>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALE_TAX] [decimal](18, 3) NULL ,
        --销售成本
	[SALE_CST] [decimal](18, 3) NULL ,
        --成本单价<移动加权成本>
	[COST_PRICE] [decimal](18, 6) NULL ,
        --销售毛利
	[SALE_PRF] [decimal](18, 3) NULL ,
	
	
        --其中退货数量
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --退货成本
	[SALRT_CST] [decimal](18, 3) NULL ,
	
--调拨类台账	
        --调入数量
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --调出数量
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--库存类台账	
        --调整数量
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --调整数量
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE5_CST] [decimal](18, 3) NULL ,

--结存类台账		
        --结存数量
	[BAL_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[BAL_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[BAL_RTL] [decimal](18, 3) NULL ,
        --结存成本<移动加权成本>
	[BAL_CST] [decimal](18, 3) NULL ,
	
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_GOODS_DAYS_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_GOODS_DAYS] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[CREA_DATE],[GODS_ID],[BATCH_NO]
	) 
);
CREATE INDEX IX_RCK_GOODS_DAYS_TENANT_ID ON RCK_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_RCK_GOODS_DAYS_TIME_STAMP ON RCK_GOODS_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_GOODS_DAYS_CREA_DATE ON RCK_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCK_GOODS_DAYS_GODS_ID ON RCK_GOODS_DAYS(TENANT_ID,GODS_ID);

--成本核算临时表
CREATE TABLE [TMP_GOODS_DAYS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --日期
	[CREA_DATE] int NOT NULL ,
        --客户编码
	[GODS_ID] [varchar] (36)  NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
	
--结账时进销价信息
        --当时进价
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --当时销价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--期初类台账		
        --期初数量
	[ORG_AMT] [decimal](18, 3) NULL ,
        --期初金额<按当时进价>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --期初成本<移动加权成本>
	[ORG_CST] [decimal](18, 3) NULL ,

--进货类台账	
        --进货数量<含退货>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --进货金额<末税>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --让利金额<供应商让利>
	[STOCK_AGO] [decimal](18, 3) NULL ,
	
        --其中退货数量
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --退货金额<末税>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--销售类台账	
        --销售数量<含退货>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --让利金额<销售让利>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALE_TAX] [decimal](18, 3) NULL ,
        --销售成本
	[SALE_CST] [decimal](18, 3) NULL ,
        --成本单价<移动加权成本>
	[COST_PRICE] [decimal](18, 6) NULL ,
        --销售毛利
	[SALE_PRF] [decimal](18, 3) NULL ,
	
	
        --其中退货数量
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --退货成本
	[SALRT_CST] [decimal](18, 3) NULL ,
	
--调拨类台账	
        --调入数量
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --调出数量
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--库存类台账	
        --调整数量
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --调整数量
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE5_CST] [decimal](18, 3) NULL 
);
CREATE INDEX IX_TMP_GOODS_DAYS_TENANT_ID ON TMP_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_TMP_GOODS_DAYS_CREA_DATE ON TMP_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_TMP_GOODS_DAYS_GODS_ID ON TMP_GOODS_DAYS(TENANT_ID,GODS_ID);

--商品月台账
CREATE TABLE [RCK_GOODS_MONTH] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --月份
	[MONTH] int NOT NULL ,
        --客户编码
	[GODS_ID] [varchar] (36)  NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
	
--结账时进销价信息
        --当时进价
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --当时销价
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--期初类台账		
        --期初数量
	[ORG_AMT] [decimal](18, 3) NULL ,
        --期初金额<按当时进价>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --期初成本<移动加权成本>
	[ORG_CST] [decimal](18, 3) NULL ,
	
--进货类台账	
        --进货数量<含退货>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --进货金额<末税>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --让利金额<供应商让利>
	[STOCK_AGO] [decimal](18, 3) NULL ,

        --其中退货数量
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --退货金额<末税>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --进项税额
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--销售类台账	
        --销售数量<含退货>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --让利金额<销售让利>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALE_TAX] [decimal](18, 3) NULL ,
        --销售成本
	[SALE_CST] [decimal](18, 3) NULL ,
        --销售毛利
	[SALE_PRF] [decimal](18, 3) NULL ,
	
        --其中退货数量<含退货>
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --退货成本
	[SALRT_CST] [decimal](18, 3) NULL ,
	
        --去年同期数量<含退货>
	[PRIOR_YEAR_AMT] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[PRIOR_YEAR_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[PRIOR_YEAR_TAX] [decimal](18, 3) NULL ,
        --销项成本
	[PRIOR_YEAR_CST] [decimal](18, 3) NULL ,
	
        --上月销售数量
	[PRIOR_MONTH_AMT] [decimal](18, 3) NULL ,
        --销售金额<末税>
	[PRIOR_MONTH_MNY] [decimal](18, 3) NULL ,
        --销项税额
	[PRIOR_MONTH_TAX] [decimal](18, 3) NULL ,
        --销项成本
	[PRIOR_MONTH_CST] [decimal](18, 3) NULL ,
	
--调拨类台账	
        --调入数量
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --调出数量
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --调拨成本<移动加权成本>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--库存类台账	
        --调整数量
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --调整数量
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --调整数量
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[CHANGE5_CST] [decimal](18, 3) NULL ,

--结存类台账		
        --结存数量
	[BAL_AMT] [decimal](18, 3) NULL ,
        --进项金额<按当时进价>
	[BAL_MNY] [decimal](18, 3) NULL ,
        --可销售额<按零售价>
	[BAL_RTL] [decimal](18, 3) NULL ,
        --结存成本<移动加权成本>
	[BAL_CST] [decimal](18, 3) NULL ,
        --调整成本<移动加权成本>
	[ADJ_CST] [decimal](18, 3) NULL ,
	
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_GOODS_MONTH_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_GOODS_MONTH] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[MONTH],[GODS_ID],[BATCH_NO]
	) 
);
CREATE INDEX IX_RCK_GOODS_MONTH_TENANT_ID ON RCK_GOODS_MONTH(TENANT_ID);
CREATE INDEX IX_RCK_GOODS_MONTH_TIME_STAMP ON RCK_GOODS_MONTH(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_GOODS_MONTH_MONTH ON RCK_GOODS_MONTH(TENANT_ID,MONTH);
CREATE INDEX IX_RCK_GOODS_MONTH_GODS_ID ON RCK_GOODS_MONTH(TENANT_ID,GODS_ID);

--账户月台账
CREATE TABLE [RCK_ACCT_MONTH] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --领用门店
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --月份
	[MONTH] int NOT NULL ,
        --账户代码
	[ACCOUNT_ID] [varchar] (36)  NOT NULL ,

--期初类台账		
        --期初金额
	[ORG_MNY] [decimal](18, 3) NULL ,
 
--收入类台账		
        --收入金额
	[IN_MNY] [decimal](18, 3) NULL ,

--支出类台账		
        --支出金额
	[OUT_MNY] [decimal](18, 3) NULL ,
	
--结存类台账		
        --结存数量
	[BAL_MNY] [decimal](18, 3) NULL ,
	
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_ACCT_MONTH_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_ACCT_MONTH] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[MONTH],[ACCOUNT_ID]
	) 
);

CREATE INDEX IX_RCK_ACCT_MONTH_TENANT_ID ON RCK_ACCT_MONTH(TENANT_ID);
CREATE INDEX IX_RCK_ACCT_MONTH_TIME_STAMP ON RCK_ACCT_MONTH(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_ACCT_MONTH_MONTH ON RCK_ACCT_MONTH(TENANT_ID,MONTH);
CREATE INDEX IX_RCK_ACCT_MONTH_ACCOUNT_ID ON RCK_ACCT_MONTH(TENANT_ID,ACCOUNT_ID);

create view VIW_GOODS_DAYS
as
select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO,
   case when STOCK_TYPE=3 then CALC_AMOUNT else 0 end as STKRT_AMT,
   case when STOCK_TYPE=3 then NOTAX_MONEY else 0 end as STKRT_MNY,
   case when STOCK_TYPE=3 then TAX_MONEY else 0 end as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_STOCKDATA
union all
select TENANT_ID,SHOP_ID,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,CALC_MONEY+AGIO_MONEY as SALE_RTL,AGIO_MONEY as SALE_AGO,
   COST_MONEY as SALE_CST,
   PRF_MONEY as SALE_PRF,
   case when SALES_TYPE=3 then CALC_AMOUNT else 0 end as SALRT_AMT,
   case when SALES_TYPE=3 then NOTAX_MONEY else 0 end as SALRT_MNY,
   case when SALES_TYPE=3 then TAX_MONEY else 0 end as SALRT_TAX,
   case when SALES_TYPE=3 then COST_MONEY else 0 end as SALRT_CST,
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_SALESDATA
union all
select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   CALC_AMOUNT as DBIN_AMT,RTL_MONEY as DBIN_RTL,COST_MONEY as DBIN_CST,
   0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_MOVEINDATA
union all
select TENANT_ID,SHOP_ID,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,   
   CALC_AMOUNT as DBOUT_AMT,RTL_MONEY as DBIN_RTL,
   COST_MONEY as DBOUT_CST,
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_MOVEOUTDATA
union all
select TENANT_ID,SHOP_ID,CHANGE_DATE as CREA_DATE,GODS_ID,BATCH_NO, 
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
PARM1_AMOUNT as CHANGE1_AMT,
PARM1_RTL as CHANGE1_RTL,
PARM1_MONEY as CHANGE1_CST,
PARM2_AMOUNT as CHANGE2_AMT,
PARM2_RTL as CHANGE2_RTL,
PARM2_MONEY as CHANGE2_CST,
PARM3_AMOUNT as CHANGE3_AMT,
PARM3_RTL as CHANGE3_RTL,
PARM3_MONEY as CHANGE3_CST,
PARM4_AMOUNT as CHANGE4_AMT,
PARM4_RTL as CHANGE4_RTL,
PARM4_MONEY as CHANGE4_CST,
PARM5_AMOUNT as CHANGE5_AMT,
PARM5_RTL as CHANGE5_RTL,
PARM5_MONEY as CHANGE5_CST
from VIW_CHANGEDATA;

create view VIW_RECVALLDATA
as 
select TENANT_ID,SHOP_ID,CLSE_DATE as RECV_DATE,CREA_USER,CHK_DATE,
isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0) as RECV_MNY,
PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from ACC_CLOSE_FORDAY
union all
select TENANT_ID,SHOP_ID,CREA_DATE as RECV_DATE,CREA_USER,CHK_DATE,
isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0) as RECV_MNY,
PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from SAL_IC_GLIDE where IC_GLIDE_TYPE='1'
union all
select TENANT_ID,SHOP_ID,RECV_DATE,RECV_USER as CREA_USER,CHK_DATE,
RECV_MNY,
case when PAYM_ID='A' then RECV_MNY else 0 end as PAY_A,
case when PAYM_ID='B' then RECV_MNY else 0 end as PAY_B,
case when PAYM_ID='C' then RECV_MNY else 0 end as PAY_C,
case when PAYM_ID='D' then RECV_MNY else 0 end as PAY_D,
case when PAYM_ID='E' then RECV_MNY else 0 end as PAY_E,
case when PAYM_ID='F' then RECV_MNY else 0 end as PAY_F,
case when PAYM_ID='G' then RECV_MNY else 0 end as PAY_G,
case when PAYM_ID='H' then RECV_MNY else 0 end as PAY_H,
case when PAYM_ID='I' then RECV_MNY else 0 end as PAY_I,
case when PAYM_ID='J' then RECV_MNY else 0 end as PAY_J
from VIW_RECVDATA;

create view VIW_ACCT_DAYS
as
select 1 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,PAY_DATE as CREA_DATE,0 as IN_MNY,PAY_MNY as OUT_MNY from VIW_PAYDATA
union all
select 2 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,RECV_DATE as CREA_DATE,RECV_MNY as IN_MNY,0 as OUT_MNY from VIW_RECVDATA
union all
select 3 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,IORO_DATE as CREA_DATE,IN_MONEY as IN_MNY,OUT_MONEY as OUT_MNY from VIW_IORODATA
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,IN_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,TRANS_MNY as IN_MNY,0 as OUT_MNY from ACC_TRANSORDER
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,OUT_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,0 as IN_MNY,TRANS_MNY as OUT_MNY from ACC_TRANSORDER
union all
select 5 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,CLSE_DATE as CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY from ACC_CLOSE_FORDAY A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A'
union all
select 6 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,A.CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY from SAL_IC_GLIDE A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A';
