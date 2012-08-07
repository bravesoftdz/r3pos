alter table MKT_KPI_MODIFY add KPI_DATE int;
alter table MKT_KPI_MODIFY add REMARK varchar(100);
alter table MKT_KPI_RESULT_LIST add ADJS_RATE decimal(18, 3);
alter table MKT_KPI_RESULT_LIST add REMARK varchar(100);

alter table SAL_VOUCHERORDER add PRINT_TIMES int;
alter table SAL_VOUCHERORDER add PRINT_USER varchar(36);

--1.4
--alter table SAL_VOUCHERDATA alter column BARCODE varchar(60) not null;
--alter table SAL_VHSENDDATA alter column BARCODE varchar(60) not null;
--alter table SAL_VHPAY_GLIDE alter column BARCODE varchar(60) not null;

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','提货券','VOUCHER_TYPE','00',5497000);

--受理类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('20','受理类型','CODE_TYPE','00',5497000);
--服务方式
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('21','服务方式','CODE_TYPE','00',5497000);
--服务质量
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('22','服务质量','CODE_TYPE','00',5497000);

--设备安装及维保登记表
CREATE TABLE SVC_SERVICE_INFO (
        --企业代码
	TENANT_ID int  NOT NULL,
        --流水ID号(内码)
	SRVR_ID char (36) NOT NULL ,
        --销售单号  
	SALES_ID char (36) NOT NULL ,
        --商品单号  
	GODS_ID char (36),
        --商品名称  
	GODS_NAME varchar (50),
        --产品序列号  
	SERIAL_NO varchar (50),
        --客户  
	CLIENT_ID char (36) NOT NULL ,
        --用户号
	CLIENT_CODE varchar (30),
        --联系人
	LINKMAN varchar (30),
        --联系电话
	TELEPHONE varchar (30),
        --地址
	ADDRESS varchar (120),
        --受理类型  
	RECV_CLASS varchar (36) NOT NULL ,
        --问题描述  
	PROB_DESC varchar (200),
        --受理时间
	RECV_DATE int,
        --受理人员
	RECV_USER varchar (36),
        --服务方式  
	SRVR_CLASS varchar (36) NOT NULL ,
        --指派人员
	SRVR_USER varchar (36),
				--处理日期
	SRVR_DATE int,
        --处理描述  
	SRVR_DESC varchar (200),
        --是否收费  0 不收费 1收费
	FEE_FLAG char (1),
        --费用金额
	FEE_MNY decimal(18, 3),
        --服务质量
	SATI_DEGR varchar (36),
         --操作时间
	CREA_DATE varchar (30),
        --操作人员
	CREA_USER varchar (36),
      	--通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SVC_SRV_INFO PRIMARY KEY 
  ( 
		TENANT_ID,
		SRVR_ID
  )
) IN R3TB32K_BIZ INDEX IN R3IX32K_DEF;
CREATE INDEX IX_SSRV_TENANT_ID ON SVC_SERVICE_INFO(TENANT_ID);
CREATE INDEX IX_SSRV_SALES_ID ON SVC_SERVICE_INFO(TENANT_ID,SALES_ID);
CREATE INDEX IX_SSRV_RECV_DATE ON SVC_SERVICE_INFO(TENANT_ID,RECV_DATE);
CREATE INDEX IX_SSRV_SRVR_DATE ON SVC_SERVICE_INFO(TENANT_ID,SRVR_DATE);

--分组关系表
CREATE TABLE PUB_CODE_RELATION (
        --企业代码
	TENANT_ID int NOT NULL ,
        --颜色/尺码编码
	CODE_ID varchar (36) NOT NULL ,
        --所属分组
	SORT_ID varchar (36) NOT NULL ,
        --分类类型 
	SORT_TYPE int NOT NULL ,
        --排序号
	SEQ_NO int,
      --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CODE_RTL PRIMARY KEY (TENANT_ID,CODE_ID,SORT_TYPE,SORT_ID)
) IN R3TB4K_BAS;
CREATE INDEX IX_CRTL_TENANT_ID ON PUB_CODE_RELATION(TENANT_ID);
CREATE INDEX IX_CRTL_TIME_STAMP ON PUB_CODE_RELATION(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_CRTL_SORT_ID ON PUB_CODE_RELATION(TENANT_ID,SORT_ID);