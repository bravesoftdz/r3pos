--发货状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','待发货','LOCUS_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','待收货','LOCUS_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','已完成','LOCUS_STATUS','00',5497000);
 
--扫码发货信息
alter table SAL_SALESORDER add	LOCUS_STATUS char(1);
alter table SAL_SALESORDER add	LOCUS_USER varchar(36);
alter table SAL_SALESORDER add	LOCUS_DATE varchar(10);
alter table SAL_SALESORDER add	LOCUS_AMT decimal(18, 3);
alter table SAL_SALESORDER add	LOCUS_CHK_USER varchar(36);
alter table SAL_SALESORDER add	LOCUS_CHK_DATE varchar(10);
--扫码发货信息
alter table STO_CHANGEORDER add	LOCUS_STATUS char(1);
alter table STO_CHANGEORDER add	LOCUS_USER varchar(36);
alter table STO_CHANGEORDER add	LOCUS_DATE varchar(10);
alter table STO_CHANGEORDER add	LOCUS_AMT decimal(18, 3);
alter table STO_CHANGEORDER add	LOCUS_CHK_USER varchar(36);
alter table STO_CHANGEORDER add	LOCUS_CHK_DATE varchar(10);
--扫码发货信息
alter table STK_STOCKORDER add	LOCUS_STATUS char(1);
alter table STK_STOCKORDER add	LOCUS_USER varchar(36);
alter table STK_STOCKORDER add	LOCUS_DATE varchar(10);
alter table STK_STOCKORDER add	LOCUS_AMT decimal(18, 3);
alter table STK_STOCKORDER add	LOCUS_CHK_USER varchar(36);
alter table STK_STOCKORDER add	LOCUS_CHK_DATE varchar(10);

update STK_STOCKORDER set LOCUS_STATUS=case when STOCK_TYPE='1' then '2' else '1' end;
update STK_STOCKORDER set LOCUS_STATUS='3',LOCUS_AMT=STOCK_AMT,LOCUS_USER='system',LOCUS_DATE='20110520' where Exists(select * from STK_LOCUS_FORSTCK where TENANT_ID=STK_STOCKORDER.TENANT_ID and STOCK_ID=STK_STOCKORDER.STOCK_ID);

update STO_CHANGEORDER set LOCUS_STATUS='1';
update STO_CHANGEORDER set LOCUS_STATUS='3',LOCUS_AMT=CHANGE_AMT,LOCUS_USER='system',LOCUS_DATE='20110520' where Exists(select * from STO_LOCUS_FORCHAG where TENANT_ID=STO_CHANGEORDER.TENANT_ID and CHANGE_ID=STO_CHANGEORDER.CHANGE_ID);

update SAL_SALESORDER set LOCUS_STATUS=case when SALES_TYPE='3' then '2' else '1' end;
update SAL_SALESORDER set LOCUS_STATUS='3',LOCUS_AMT=SALE_AMT,LOCUS_USER='system',LOCUS_DATE='20110520' where Exists(select * from SAL_LOCUS_FORSALE where TENANT_ID=SAL_SALESORDER.TENANT_ID and SALES_ID=SAL_SALESORDER.SALES_ID);

update CA_MODULE set MODU_NAME='收货单' where MODU_ID='14600001';
update CA_MODULE set MODU_NAME='发货单' where MODU_ID='14700001';

update SYS_SYNC_CTRL set SHOP_ID='#' where SHOP_ID is null or SHOP='';