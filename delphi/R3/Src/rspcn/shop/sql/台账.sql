--税率处理
alter table STK_STOCKDATA add TAX_RATE decimal(18, 3) NOT NULL DEFAULT 0;
alter table SAL_SALESDATA add TAX_RATE decimal(18, 3) NOT NULL DEFAULT 0;

alter table PUB_GOODSINFOEXT add USING_TAX_RATE char(1) NOT NULL DEFAULT('0');
alter table PUB_GOODSINFOEXT add IN_TAX_RATE decimal(18, 3) NULL;
alter table PUB_GOODSINFOEXT add OUT_TAX_RATE decimal(18, 3) NULL;


alter table STK_STOCKORDER add PAY_ZERO decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_A decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_B decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_C decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_D decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_E decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_F decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_G decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_H decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_I decimal(18, 3) DEFAULT 0;
alter table STK_STOCKORDER add PAY_J decimal(18, 3) DEFAULT 0;

--进销存流水
CREATE TABLE RCK_STOCKS_DATA
(
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (13) NOT NULL ,
        --单号
	BILL_ID char (36) NOT NULL ,
        --单据流水号
	BILL_CODE varchar (20) NULL ,
        --单据类型
	BILL_TYPE int NOT NULL ,
        --单据名称
	BILL_NAME varchar (10) NULL ,
        --日期
	BILL_DATE int NOT NULL ,
        --排序号-每笔流水
	SEQNO int NOT NULL ,
        --供应链
	RELATION_ID int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --货号<店内识别码>
	GODS_CODE varchar (20) NOT NULL ,
        --品名规格
	GODS_NAME varchar (50) NOT NULL ,
	--计量单位条码
	BARCODE varchar (30) NULL ,
        --商品分类
	SORT_ID varchar (36) NOT NULL ,
        --分类名称
	SORT_NAME varchar (10) NULL ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --代码<标识码> 
	CLIENT_CODE varchar (20) NULL ,
        --客户名称
	CLIENT_NAME varchar (50) NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --单位名称
	UNIT_NAME varchar (10) NULL ,
        --转换成最小单位系数
    	CONV_RATE decimal(18, 3) NOT NULL ,
        --批号
        BATCH_NO varchar (36) NOT NULL ,
        --规格
        PROPERTY_01 varchar (36) NOT NULL ,
        --颜色
        PROPERTY_02 varchar (36) NOT NULL ,
        --进 {数量统一存储最小单位}
    	IN_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,
	IN_PRICE  decimal(18, 6) NOT NULL DEFAULT 0,
	IN_MONEY  decimal(18, 3) NOT NULL DEFAULT 0,
	IN_TAX  decimal(18, 3) NOT NULL DEFAULT 0,
        --出
        OUT_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,			
        --成本单价
        OUT_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        --成本金额
        OUT_MONEY decimal(18, 3) NOT NULL DEFAULT 0,		
        --销	 
        SALE_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        SALE_MONEY decimal(18, 3) NOT NULL DEFAULT 0,			
        SALE_TAX decimal(18, 3) NOT NULL DEFAULT 0,	
        --存		
        BAL_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,			
        BAL_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        BAL_MONEY decimal(18, 3) NOT NULL DEFAULT 0,			
        --业务员<导购员,负责人>
	GUIDE_USER varchar (36) NULL ,
	GUIDE_NAME varchar (20) NULL ,
        --制单员
	CREA_USER varchar (36) NULL ,
	CREA_NAME varchar (20) NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL CONSTRAINT DF_RCK_STOCKS_DATA_COMM DEFAULT ('00'),
        --时间戳 当前系统日期*86400000
        TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_STOCKS_DATA PRIMARY KEY 
	(
		ID
	)
);

CREATE INDEX IX_RCK_STOCKS_DATA_TENANT_ID ON RCK_STOCKS_DATA(TENANT_ID);
CREATE INDEX IX_RCK_STOCKS_DATA_GODS_ID ON RCK_STOCKS_DATA(GODS_ID);
CREATE INDEX IX_RCK_STOCKS_DATA_BILL_DATE ON RCK_STOCKS_DATA(BILL_DATE);
