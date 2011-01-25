--商品价格
CREATE TABLE [PUB_GOODSPRICE] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --客户类型 # 号为所有客户
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --门店代码
	[SHOP_ID] int NOT NULL ,
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

--各商品价格
CREATE view [VIW_GOODSPRICE]
as
select A.[TENANT_ID],A.[GODS_ID],A.[GODS_CODE],A.[GODS_ID] as SECOND_ID,A.[GODS_NAME],A.[GODS_SPELL],A.[GODS_TYPE],
       A.[SORT_ID1],A.[SORT_ID2],A.[SORT_ID3],A.[SORT_ID4],A.[SORT_ID5],A.[SORT_ID6],A.[SORT_ID7],A.[SORT_ID8],
       A.[BARCODE],A.[CALC_UNITS],A.[SMALL_UNITS],A.[BIG_UNITS],A.[SMALLTO_CALC],A.[BIGTO_CALC],
       A.[NEW_INPRICE],
       case when isnull(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when isnull(B.COMM,'02') not in ('02','12') then B.[NEW_OUTPRICE] else A.[NEW_OUTPRICE] end NEW_OUTPRICE,
       case when isnull(B.COMM,'02') not in ('02','12') then isnull(B.[NEW_OUTPRICE1],B.[NEW_OUTPRICE]*A.SMALLTO_CALC) else A.[NEW_OUTPRICE]*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when isnull(B.COMM,'02') not in ('02','12') then isnull(B.[NEW_OUTPRICE2],B.[NEW_OUTPRICE]*A.BIGTO_CALC) else A.[NEW_OUTPRICE]*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.[NEW_LOWPRICE],A.[USING_BARTER],A.[BARTER_INTEGRAL],
       A.[USING_PRICE],A.[HAS_INTEGRAL],A.[USING_BATCH_NO],A.[REMARK],A.[COMM],A.[TIME_STAMP]
from VIW_GOODSINFO A left outer jion PUB_GOODSPRICE B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID

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
	[SHOP_ID] int NOT NULL ,
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
  CONSTRAINT [PK_LOG_PRICING_INFO] PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
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
	[SHOP_ID] int NOT NULL ,
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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','不打折','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','再打折','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','指定折','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO

--促销单表头<单据都以表头COMM,TIME_STAMP通讯标志为准>
CREATE TABLE [SAL_PRICEORDER] (
        --记录ID号
	[PROM_ID] [varchar] (36) NOT NULL ,
        --流水号
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --开单门店代码
	[SHOP_ID] int NOT NULL ,
        --开始时间 yyyy-mm-dd hh:mm:ss
	[BEGIN_DATE] [varchar] (25) NOT NULL ,
        --结束时间 yyyy-mm-dd hh:mm:ss
	[END_DATE] [varchar] (25) NOT NULL ,
        --会员等级#号时对所有客户
	[PRICE_ID] [varchar] (16) NULL ,
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
	[SHOP_ID] int NOT NULL ,
  CONSTRAINT [PK_SAL_PROM_SHOP] PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_TIME_STAMP ON SAL_PROM_SHOP(TENANT_ID,TIME_STAMP);
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
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROD_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROD_ID=B.PROD_ID and A.TENANT_ID=C.TENANT_ID and A.PROD_ID=C.PROD_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
B.BEGIN_DATE<=strftime('%Y-%m-%d %H:%M:%S','now','localtime') and B.END_DATE>=strftime('%Y-%m-%d %H:%M:%S','now','localtime');

--发票类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','收款收据','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','普通发票','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','增值税票','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
--入库类单据类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','入库单','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);

--入库单表头
CREATE TABLE [STK_STOCKORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
		[COMP_ID],
		[STOCK_ID]
	)
);

CREATE INDEX IX_STK_STOCKORDER_TENANT_ID ON STK_STOCKORDER(TENANT_ID);
CREATE INDEX IX_STK_STOCKORDER_TIME_STAMP ON STK_STOCKORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_STOCKORDER_STOCK_DATE ON STK_STOCKORDER(STOCK_DATE);

--入库单表头--历史表
CREATE TABLE [STK_STOCKORDER_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_STOCKORDER_HIS_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STK_STOCKORDER_HIS] PRIMARY KEY 
	(
		[COMP_ID],
		[STOCK_ID]
	)
);

CREATE INDEX IX_STK_STOCKORDER_HIS_TENANT_ID ON STK_STOCKORDER_HIS(TENANT_ID);
CREATE INDEX IX_STK_STOCKORDER_HIS_TIME_STAMP ON STK_STOCKORDER_HIS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_STOCKORDER_HIS_STOCK_DATE ON STK_STOCKORDER_HIS(STOCK_DATE);

--业务类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','正常','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','赠送','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','兑换','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);

--入库单明细
CREATE TABLE [STK_STOCKDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --标准售价
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

--入库单明细
CREATE TABLE [STK_STOCKDATA_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --标准售价
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
	CONSTRAINT [PK_STK_STOCKDATA_HIS] PRIMARY KEY  
	(
		[TENANT_ID],
		[STOCK_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_STK_STOCKDATA_HIS_TENANT_ID ON STK_STOCKDATA_HIS(TENANT_ID);
CREATE INDEX IX_STK_STOCKDATA_HIS_GODS_ID ON STK_STOCKDATA_HIS(TENANT_ID,GODS_ID);

--进货单视图<含退货>
CREATE VIEW VIW_STOCKDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER_ B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--进货单历史视图<含退货>
CREATE VIEW VIW_STOCKDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--调拨接收单视图
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

--调拨接收单视图
CREATE VIEW VIW_MOVEINDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','销售单','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','零售单','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','销售方式','CODE_TYPE','00',strftime('%s','now','localtime')-1293840000);

--销售单表头
CREATE TABLE [SAL_SALESORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --销售金额
	[SALE_MNY] [decimal](18, 3) NULL ,
        --抹零金额
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --实收现金
	[RECV_MNY] [decimal](18, 3) NULL ,
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

--销售单表头
CREATE TABLE [SAL_SALESORDER_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --销售金额
	[SALE_MNY] [decimal](18, 3) NULL ,
        --抹零金额
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --实收现金
	[RECV_MNY] [decimal](18, 3) NULL ,
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
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_SALESORDER_HIS_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_SALESORDER_HIS] PRIMARY KEY 
	(
		[TENANT_ID],
		[SALES_ID]
	) 
);

CREATE INDEX IX_SAL_SALESORDER_HIS_TENANT_ID ON SAL_SALESORDER_HIS(TENANT_ID);
CREATE INDEX IX_SAL_SALESORDER_HIS_TIME_STAMP ON SAL_SALESORDER_HIS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_SALESORDER_HIS_SALES_DATE ON SAL_SALESORDER_HIS(SALES_DATE);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','统一定价','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','门店定价','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','产品促销','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','变价销售','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','付款方式','CODE_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','现金','XJ','1','1','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','银联','YL','1','2','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','储值卡','CZK','1','3','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','记账','JZ','1','4','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','礼券','LQ','1','5','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','支票','ZP','1','6','00',strftime('%s','now','localtime')-1293840000);


--销售单明细
CREATE TABLE [SAL_SALESDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --标准售价
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
        --计量单位数据
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --出库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --成本单价
	[COST_PRICE] [decimal](18, 6) NULL ,
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

--销售单明细
CREATE TABLE [SAL_SALESDATA_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --标准售价
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
        --计量单位数据
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --出库金额
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --成本单价
	[COST_PRICE] [decimal](18, 6) NULL ,
        --是否有积分
	[HAS_INTEGRAL] [int] NOT NULL ,
        --说明
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_SAL_SALESDATA_HIS] PRIMARY KEY  
	(
		[TENANT_ID],
		[SALES_ID],
		[SEQNO]
	)
) ;

CREATE INDEX IX_SAL_SALESDATA_HIS_TENANT_ID ON SAL_SALESDATA_HIS(TENANT_ID);
CREATE INDEX IX_SAL_SALESDATA_HIS_GODS_ID ON SAL_SALESDATA_HIS(TENANT_ID,GODS_ID);

--销售视图<含退货>
CREATE VIEW VIW_SALESDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.AGIO_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--销售视图<含退货>
CREATE VIEW VIW_SALESDATA_HIS
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.AGIO_MONEY
from SAL_SALESORDER_HIS A,SAL_SALESDATA_HIS B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--调拨出货单视图
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.AGIO_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--调拨出货单视图
CREATE VIEW VIW_MOVEOUTDATA_HIS
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.AGIO_MONEY
from SAL_SALESORDER_HIS A,SAL_SALESDATA_HIS B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--流水类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','充值','IC_GLIDE_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','支付','IC_GLIDE_TYPE','00',strftime('%s','now','localtime')-1293840000);

--储值卡流水记录
CREATE TABLE [SAL_IC_GLIDE] (
        --流水ID号
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
        --销售单号
	[SALES_ID] [varchar] (36) NOT NULL ,
        --IC卡号
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --流水日期
	[CREA_DATE] int NOT NULL ,
        --摘要
	[GLIDE_INFO] [varchar] (100) NOT NULL ,
        --流水类型
	[IC_GLIDE_TYPE] [varchar] (1) NOT NULL ,
        --金额
	[GLIDE_MNY] [decimal](18, 3) NULL ,
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
CREATE INDEX IX_SAL_IC_GLIDE_KEYFIELD ON SAL_IC_GLIDE(TENANT_ID,SHOP_ID,SALES_ID);
CREATE INDEX IX_SAL_IC_GLIDE_CREA_DATE ON SAL_IC_GLIDE(CREA_DATE);
CREATE INDEX IX_SAL_IC_GLIDE_IC_CARDNO ON SAL_IC_GLIDE(IC_CARDNO);

--对换方式
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','礼券','INTEGRAL_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','礼品','INTEGRAL_FLAG','00',strftime('%s','now','localtime')-1293840000);

--积分对换
CREATE TABLE [SAL_INTEGRAL_GLIDE] (
        --流水ID号
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
        --会员号
	[CUST_ID] [varchar] (36) NOT NULL ,
        --流水日期
	[CREA_DATE] int NOT NULL ,
        --对换方式
	[INTEGRAL_FLAG] [varchar] (1) NOT NULL ,
        --摘要
	[GLIDE_INFO] [varchar] (255) NOT NULL ,
        --使用积分
	[INTEGRAL] [decimal](18, 3) NULL ,
        --对换值<礼券张数，或礼品数量>
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
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CUST_ID ON SAL_INTEGRAL_GLIDE(CUST_ID);


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
		[TENANT_ID,CHANGE_CODE]
	) 
) ;

insert into BAS_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','损益','1','00',strftime('%s','now','localtime')-1293840000);
insert into BAS_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','领用','2','00',strftime('%s','now','localtime')-1293840000);

--调整单
CREATE TABLE [STO_CHANGEORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --负责人
	[DUTY_USER] [varchar] (36) NULL ,
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

--调整单
CREATE TABLE [STO_CHANGEORDER_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --负责人
	[DUTY_USER] [varchar] (36) NULL ,
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
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGEORDER_HIS_COMM] DEFAULT ('00'),
        --时间戳 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_CHANGEORDER_HIS] PRIMARY KEY  
	(
		[CHANGE_ID],
		[TENANT_ID]
	)
);

CREATE INDEX IX_STO_CHANGEORDER_HIS_TENANT_ID ON STO_CHANGEORDER_HIS(TENANT_ID);
CREATE INDEX IX_STO_CHANGEORDER_HIS_TIME_STAMP ON STO_CHANGEORDER_HIS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_CHANGEORDER_HIS_SALES_DATE ON STO_CHANGEORDER_HIS(CHANGE_DATE);

--库存调整单明细
CREATE TABLE [STO_CHANGEDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --成本单价
	[COST_PRICE] [decimal](18, 3) NULL ,
        --计量单位数量
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
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

--库存调整单明细
CREATE TABLE [STO_CHANGEDATA_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --批号
	[BATCH_NO] [varchar] (36) NULL ,
        --数量
	[AMOUNT] [decimal](18, 3) NULL ,
        --成本单价
	[COST_PRICE] [decimal](18, 3) NULL ,
        --计量单位数量
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --调整说明
	[REMARK] [varchar] (100) NULL ,
	CONSTRAINT [PK_STO_CHANGEDATA_HIS] PRIMARY KEY   
	(
		[TENANT_ID],
    [CHANGE_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_STO_CHANGEDATA_HIS_TENANT_ID ON STO_CHANGEDATA_HIS(TENANT_ID);
CREATE INDEX IX_STO_CHANGEDATA_HIS_GODS_ID ON STO_CHANGEDATA_HIS(TENANT_ID,GODS_ID);

CREATE VIEW VIW_CHANGEDATA
as
select
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,case when B.CHANGE_TYPE=1 then 1 else -1 end*A.AMOUNT as AMOUNT,A.COST_PRICE,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as NOTAX_MONEY, 
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM5_MONEY
from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.COMM not in ('02','12');


CREATE VIEW VIW_CHANGEDATA_HIS
as
select
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,case when B.CHANGE_TYPE=1 then 1 else -1 end*A.AMOUNT as AMOUNT,A.COST_PRICE,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as NOTAX_MONEY, 
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM5_MONEY
from STO_CHANGEDATA_HIS A,STO_CHANGEORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.COMM not in ('02','12');

--进货订单
CREATE TABLE [STK_INDENTORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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

--进货订单
CREATE TABLE [STK_INDENTORDER_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --订货金额
	[INDE_MNY] [decimal](18, 3) NULL ,
        --发票类型
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --进项税率
	[TAX_RATE] [decimal](18, 3) NULL ,
        --备注
	[REMARK] [varchar] (100) NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_INDENTORDER_HIS_COMM] DEFAULT ('00'),
        --操作时间
	[CREA_DATE] [varchar] (30) NULL ,
        --操作人员
	[CREA_USER] [varchar] (36) NULL ,
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STK_INDENTORDER_HIS] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID]
	) 
);

CREATE INDEX IX_STK_INDENTORDER_HIS_TENANT_ID ON STK_INDENTORDER_HIS(TENANT_ID);
CREATE INDEX IX_STK_INDENTORDER_HIS_TIME_STAMP ON STK_INDENTORDER_HIS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_INDENTORDER_HIS_INDE_DATE ON STK_INDENTORDER_HIS(INDE_DATE);

--进货订单明细
CREATE TABLE [STK_INDENTDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
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

--进货订单明细
CREATE TABLE [STK_INDENTDATA_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
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
	CONSTRAINT [PK_STK_INDENTDATA_HIS] PRIMARY KEY  
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	)
);

CREATE INDEX IX_STK_INDENTDATA_HIS_TENANT_ID ON STK_INDENTDATA_HIS(TENANT_ID);
CREATE INDEX IX_STK_INDENTDATA_HIS_GODS_ID ON STK_INDENTDATA_HIS(TENANT_ID,GODS_ID);

--进货订单视图
CREATE VIEW VIW_STKINDENTDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--进货订单视图
CREATE VIEW VIW_STKINDENTDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--销售订单
CREATE TABLE [SAL_INDENTORDER] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
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

--销售订单
CREATE TABLE [SAL_INDENTORDER_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --预付款
	[ADVA_MNY] [decimal](18, 3) NULL ,
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
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INDENTORDER_HIS_COMM] DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INDENTORDER_HIS] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID]
	)
);

CREATE INDEX IX_SAL_INDENTORDER_HIS_TENANT_ID ON SAL_INDENTORDER_HIS(TENANT_ID);
CREATE INDEX IX_SAL_INDENTORDER_HIS_TIME_STAMP ON SAL_INDENTORDER_HIS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INDENTORDER_HIS_SALES_DATE ON SAL_INDENTORDER_HIS(INDE_DATE);

--销售订单明细
CREATE TABLE [SAL_INDENTDATA] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
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

--销售订单明细
CREATE TABLE [SAL_INDENTDATA_HIS] (
        --企业代码
	[TENANT_ID] int NOT NULL ,
        --门店代码
	[SHOP_ID] int NOT NULL ,
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
        --批号
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --单位
	[UNIT_ID] [varchar] (36) NOT NULL ,
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
	CONSTRAINT [PK_SAL_INDENTDATA_HIS] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_SAL_INDENTDATA_HIS_TENANT_ID ON SAL_INDENTDATA_HIS(TENANT_ID);
CREATE INDEX IX_SAL_INDENTDATA_HIS_GODS_ID ON SAL_INDENTDATA_HIS(TENANT_ID,GODS_ID);

--销售订单视图
CREATE VIEW VIW_SALINDENTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.INDE_DATE,A.INDE_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.HAS_INTEGRAL,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_INDENTORDER A,SAL_INDENTDATA B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and A.COMM not in ('02','12');

--销售订单视图
CREATE VIEW VIW_SALINDENTDATA_HIS
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.INDE_DATE,A.INDE_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.HAS_INTEGRAL,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_INDENTORDER_HIS A,SAL_INDENTDATA_HIS B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and A.COMM not in ('02','12');

