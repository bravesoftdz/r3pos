--有效期
alter table SAL_VOUCHERORDER add column VAILD_DATE int;
--面值
alter table SAL_VOUCHERORDER add column VOUCHER_PRC int;
--礼券名称
alter table SAL_VOUCHERORDER add column VUCH_NAME varchar(50);
--序号
alter table SAL_VOUCHERDATA add column SEQNO int;


--代金券领用
drop table SAL_VHLEADDATA;
CREATE TABLE SAL_VHLEADDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --领用单号
	VHLEAD_ID char (36) NOT NULL ,
        --领用的入库单号
	VOUCHER_ID varchar (36) NOT NULL ,
        --摘要
	SUMMARY varchar(100)   NOT NULL,
        --领用张数
	AMOUNT decimal(18, 3) ,
        --面值
	VOUCHER_PRC int NOT NULL ,
        --面值金额
	VOUCHER_TTL decimal(18, 3) ,
	CONSTRAINT PK_SAL_VHLEADDATA PRIMARY KEY   
	(
		TENANT_ID,VHLEAD_ID,VOUCHER_ID
	) 
);

CREATE INDEX IX_VLDD_TENANT_ID ON SAL_VHLEADDATA(TENANT_ID);
CREATE INDEX IX_VLDD_VHLEAD_ID ON SAL_VHLEADDATA(TENANT_ID,VHLEAD_ID);


--代金券发放
drop table SAL_VHSENDDATA;
CREATE TABLE SAL_VHSENDDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --发放单号
	VHSEND_ID char (36) NOT NULL ,
        --领用的入库单号
	VOUCHER_ID varchar (36) NOT NULL ,
        --防伪码--不记名时 为 #
	BARCODE varchar (50) NOT NULL ,
        --领用张数
	AMOUNT decimal(18, 3) ,
        --面值
	VOUCHER_PRC int NOT NULL ,
        --面值金额
	VOUCHER_TTL decimal(18, 3) ,
        --实收金额
	VOUCHER_MNY decimal(18, 3) ,
        --折扣率
	AGIO_RATE decimal(18, 3) ,
        --折扣额
	AGIO_MONEY decimal(18, 3) ,
	CONSTRAINT PK_SAL_VHSEADDATA PRIMARY KEY   
	(
		TENANT_ID,VHSEND_ID,VOUCHER_ID,BARCODE
	) 
);

CREATE INDEX IX_VSDD_TENANT_ID ON SAL_VHSENDDATA(TENANT_ID);
CREATE INDEX IX_VSDD_VHSEND_ID ON SAL_VHSENDDATA(TENANT_ID,VHSEND_ID);

--财务系统编码对照
alter table CA_SHOP_INFO add column SUBJECT_NO varchar(30);
alter table CA_DEPT_INFO add column SUBJECT_NO varchar(30);
alter table CA_USERS add column SUBJECT_NO varchar(30);
alter table PUB_CLIENTINFO add column SUBJECT_NO varchar(30);

--凭证模块
DROP TABLE ACC_FVCHFRAME;
CREATE TABLE ACC_FVCHFRAME (
  --企业代码
  TENANT_ID int  NOT NULL,
  --单据类型 01采购订单 02采购进货 03采购退货 04 销售订单 05 销售出货 06销售退货 07领用单 08 损益单 09收款单 10 付款单  11 零售单据 12缴款单 13 其他收入 14其他支出 15 存取款单
  FVCH_GTYPE char(2)   NOT NULL,
  --序号
  SEQNO int NOT NULL ,
  --科目代码
  SUBJECT_NO varchar(10)   NOT NULL,
  --凭证字
  FVCH_NAME varchar(20)   NOT NULL,
  --摘要
  SUMMARY varchar(100)   NOT NULL,
        --金额<取数字段>
	AMONEY varchar(20),
        --数量<取数字段>
	AMOUNT varchar(20),
        --单价<取数字段>
	APRICE varchar(20),
  --取数条件=>ACC_FVCHSWHERE
  SWHERE char(36),
  --分录明细 100000000 按位取数0代表不分细明1表代分明细(1人员 2部门 3门店<仓库> 4往来单位 其他分别为专项1-5)
  DATAFLAG varchar(9)   NOT NULL,
  --记账方向  1借方 2贷方
  SUBJECT_TYPE char(1) NOT NULL,
  CONSTRAINT PK_ACC_FVCHFRAME PRIMARY KEY 
  ( 
		TENANT_ID,
		FVCH_GTYPE,
    SEQNO
  )
);
CREATE INDEX IX_FVFR_TENANT_ID ON ACC_FVCHFRAME (TENANT_ID);
CREATE INDEX IX_FVFR_FVCH_GTYPE ON ACC_FVCHFRAME (TENANT_ID,FVCH_GTYPE);

alter table ACC_FVCHORDER add  column FVCH_NAME varchar(20);
--凭证模块条件
CREATE TABLE ACC_FVCHSWHERE (
  --企业代码
  TENANT_ID int  NOT NULL,
  --行号
  SROW_ID char(36)   NOT NULL,
  --条件ID
  SWHERE char(36)   NOT NULL,
  --条件字段
  FIELD_NAME varchar(30)   NOT NULL,
  --操作符 in 或 not in
	FIELD_EQUE varchar(6),
  --字段值
  FIELD_VALUE varchar(50),
  CONSTRAINT PK_ACC_FVCHSWHERE PRIMARY KEY 
  ( 
		TENANT_ID,
		SROW_ID
  )
);
CREATE INDEX IX_FVFS_TENANT_ID ON ACC_FVCHSWHERE (TENANT_ID);
CREATE INDEX IX_FVFS_SWHERE ON ACC_FVCHSWHERE (TENANT_ID,SWHERE);

--单据类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('01','采购订单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('02','采购进货','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('03','采购退货','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('04','销售订单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('05','销售出货','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('06','销售退货','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('07','领用单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('08','损益单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('09','收款单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('10','付款单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','零售单据','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','缴款单','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('13','其他收入','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('14','其他支出','BILL_NAME','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('15','存取款单','BILL_NAME','00',5497000);

--取数字段定义 采购订单(FVCH_DATA_(单据代码01))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','进项税额','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ADVA_MNY','预付款','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('BOND_MNY','保证金','FVCH_DATA_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('OTHR_MNY','其他费用','FVCH_DATA_01','00',5497000);
--取数条件定义 采购订单(FVCH_WHERE_(单据代码01))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','供应商','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','采购员','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_01','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_01','00',5497000);

--取数字段定义 采购进货(FVCH_DATA_(单据代码02))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','进项税额','FVCH_DATA_02','00',5497000);
--取数条件定义 采购进货(FVCH_WHERE_(单据代码02))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','供应商','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','收货员','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_02','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_02','00',5497000);

--取数字段定义 采购退货(FVCH_DATA_(单据代码03))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','进项税额','FVCH_DATA_03','00',5497000);
--取数条件定义 采购退货(FVCH_WHERE_(单据代码03))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','供应商','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','收货员','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_03','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_03','00',5497000);

--取数字段定义 销售订单(FVCH_DATA_(单据代码04))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','销项税额','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ADVA_MNY','预收款','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('BOND_MNY','保证金','FVCH_DATA_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('OTHR_MNY','其他费用','FVCH_DATA_04','00',5497000);
--取数条件定义 销售订单(FVCH_WHERE_(单据代码04))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','客户名称','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','导购员','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_04','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SALES_STYLE','销售方式','FVCH_WHERE_04','00',5497000);

--取数字段定义 销售出货(FVCH_DATA_(单据代码05))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','销项税额','FVCH_DATA_05','00',5497000);
--取数条件定义 销售出货(FVCH_WHERE_(单据代码05))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','客户名称','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','导购员','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_05','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SALES_STYLE','销售方式','FVCH_WHERE_05','00',5497000);

--取数字段定义 销售退货(FVCH_DATA_(单据代码06))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','销项税额','FVCH_DATA_06','00',5497000);
--取数条件定义 销售退货(FVCH_WHERE_(单据代码06))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','客户名称','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','导购员','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_06','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SALES_STYLE','销售方式','FVCH_WHERE_06','00',5497000);

--取数字段定义 领用单 (FVCH_DATA_(单据代码07))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('COST_APRICE','成本价','FVCH_DATA_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('COST_MONEY','成本金额','FVCH_DATA_07','00',5497000);
--取数条件定义 领用单 (FVCH_WHERE_(单据代码07))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DUTY_USER','经手人','FVCH_WHERE_07','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_07','00',5497000);

--取数字段定义 损益单 (FVCH_DATA_(单据代码08))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('COST_APRICE','成本价','FVCH_DATA_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('COST_MONEY','成本金额','FVCH_DATA_08','00',5497000);
--取数条件定义 损益单 (FVCH_WHERE_(单据代码08))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DUTY_USER','经手人','FVCH_WHERE_08','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_08','00',5497000);

--取数字段定义 收款单 (FVCH_DATA_(单据代码09))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('RECV_MNY','收款金额','FVCH_DATA_09','00',5497000); 
--取数条件定义 收款单 (FVCH_WHERE_(单据代码09))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_09','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_09','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ITEM_ID','收支科目','FVCH_WHERE_09','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('PAYM_ID','收款方式','FVCH_WHERE_09','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','客户名称','FVCH_WHERE_09','00',5497000);

--取数字段定义 付款单 (FVCH_DATA_(单据代码10))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('RECV_MNY','付款金额','FVCH_DATA_10','00',5497000); 
--取数条件定义 付款单 (FVCH_WHERE_(单据代码10))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_10','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_10','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ITEM_ID','收支科目','FVCH_WHERE_10','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('PAYM_ID','付款方式','FVCH_WHERE_10','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','供应商','FVCH_WHERE_10','00',5497000);

--取数字段定义 零售单据 (FVCH_DATA_(单据代码11))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_AMOUNT','数量','FVCH_DATA_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('APRICE','单价','FVCH_DATA_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CALC_MONEY','含税金额','FVCH_DATA_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NOTAX_MONEY','不含税金额','FVCH_DATA_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TAX_MONEY','销项税额','FVCH_DATA_11','00',5497000);

--取数条件定义 零售单据 (FVCH_WHERE_(单据代码11))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SORT_ID','商品指标','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','客户名称','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GUIDE_USER','收银员','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('INVOICE_FLAG','票据类型','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IS_PRESENT','是否赠品','FVCH_WHERE_11','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SALES_STYLE','销售方式','FVCH_WHERE_11','00',5497000);

--取数字段定义 缴款单 (FVCH_DATA_(单据代码12))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('RECV_MNY','缴款金额','FVCH_DATA_12','00',5497000); 
--取数条件定义 缴款单 (FVCH_WHERE_(单据代码12))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_12','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_12','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ITEM_ID','收支科目','FVCH_WHERE_12','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('PAYM_ID','缴款方式','FVCH_WHERE_12','00',5497000);
 
--取数字段定义 其他收入 (FVCH_DATA_(单据代码13))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IORO_MNY','金额','FVCH_DATA_13','00',5497000); 
--取数条件定义 其他收入 (FVCH_WHERE_(单据代码13))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_13','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_13','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','往来单位','FVCH_WHERE_13','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ITEM_ID','收支科目','FVCH_WHERE_13','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IORO_USER','经手人','FVCH_WHERE_13','00',5497000);
 
--取数字段定义 其他支出 (FVCH_DATA_(单据代码14))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IORO_MNY','金额','FVCH_DATA_14','00',5497000); 
--取数条件定义 其他支出 (FVCH_WHERE_(单据代码14))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DEPT_ID','部门','FVCH_WHERE_14','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_14','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('CLIENT_ID','往来单位','FVCH_WHERE_14','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('ITEM_ID','收支科目','FVCH_WHERE_14','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('IORO_USER','经手人','FVCH_WHERE_14','00',5497000);

--取数字段定义 存取款单 (FVCH_DATA_(单据代码15))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TRANS_MNY','金额','FVCH_DATA_15','00',5497000); 
--取数条件定义 其他支出 (FVCH_WHERE_(单据代码15))
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','门店','FVCH_WHERE_15','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('TRANS_USER','经手人','FVCH_WHERE_15','00',5497000);


--删除约束
alter table RCK_C_GOODS_DAYS drop CONSTRAINT PK_RCK_C_G_DAYS;