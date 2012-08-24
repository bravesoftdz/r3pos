

drop table RCK_C_GOODS_DAYS;
--�ͻ���Ʒ������
CREATE TABLE RCK_C_GOODS_DAYS (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ�
	SHOP_ID varchar (13) NOT NULL ,
        --����
	DEPT_ID varchar (12) NOT NULL ,
        --�ͻ�
	CLIENT_ID varchar (36) NOT NULL ,
        --�ͻ�
	GUIDE_USER varchar (36) NOT NULL ,
        --��������
	CREA_DATE int NOT NULL ,
        --�ͻ�����
	GODS_ID char (36)  NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,

--������̨��	
        --��������<���˻�>
	SALE_AMT decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	SALE_RTL decimal(18, 3) ,
        --�������<��������>
	SALE_AGO decimal(18, 3) ,
        --���۽��<ĩ˰>
	SALE_MNY decimal(18, 3) ,
        --����˰��
	SALE_TAX decimal(18, 3) ,
        --���۳ɱ�
	SALE_CST decimal(18, 3) ,
        --�ɱ�����<�ƶ���Ȩ�ɱ�>
	COST_PRICE decimal(18, 6) ,
        --����ë��
	SALE_PRF decimal(18, 3) ,
	
	
        --�����˻�����
	SALRT_AMT decimal(18, 3) ,
        --���۽��<ĩ˰>
	SALRT_MNY decimal(18, 3) ,
        --����˰��
	SALRT_TAX decimal(18, 3) ,
        --�˻��ɱ�
	SALRT_CST decimal(18, 3) ,
	
	
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_C_G_DAYS PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,DEPT_ID,GUIDE_USER,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO
	) 
) IN R3TB32K_RCK INDEX IN R3IX32K_DEF %PARTITION%;
CREATE INDEX IX_RCKCG_TEN_ID ON RCK_C_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_RCKCG_TIM_STMP ON RCK_C_GOODS_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCKCG_CREA_DATE ON RCK_C_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCKCG_GODS_ID ON RCK_C_GOODS_DAYS(TENANT_ID,GODS_ID);
CREATE INDEX IX_RCKCG_CLIENT_ID ON RCK_C_GOODS_DAYS(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_RCKCG_DEPT_ID ON RCK_C_GOODS_DAYS(TENANT_ID,DEPT_ID);

insert into RCK_C_GOODS_DAYS(TENANT_ID,SHOP_ID,DEPT_ID,GUIDE_USER,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO,
SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,COMM,TIME_STAMP) 
select A.TENANT_ID,A.SHOP_ID,case when A.DEPT_ID is null then '#' else A.DEPT_ID end,case when A.GUIDE_USER is null then '#' else A.GUIDE_USER end,case when A.CLIENT_ID is null then '#' else A.CLIENT_ID end,A.SALES_DATE,A.GODS_ID,A.BATCH_NO, 
sum(A.CALC_AMOUNT) as SALE_AMT,sum(A.CALC_MONEY+A.AGIO_MONEY) as SALE_RTL,sum(A.AGIO_MONEY) as SALE_AGO,sum(A.NOTAX_MONEY) as SALE_MNY,sum(A.TAX_MONEY) as SALE_TAX, 
sum(round(A.CALC_AMOUNT*B.COST_PRICE,2)) as SALE_CST,max(B.COST_PRICE) as COST_PRICE, 
sum(A.NOTAX_MONEY-round(A.CALC_AMOUNT*B.COST_PRICE,2)) as SALE_PRF, 
sum(case when A.SALES_TYPE=3 then A.CALC_AMOUNT else 0 end) as SALRT_AMT, 
sum(case when A.SALES_TYPE=3 then A.NOTAX_MONEY else 0 end) as SALRT_MNY, 
sum(case when A.SALES_TYPE=3 then A.TAX_MONEY else 0 end) as SALRT_TAX, 
sum(case when A.SALES_TYPE=3 then round(A.CALC_AMOUNT*B.COST_PRICE,2) else 0 end) as SALRT_CST, 
'00',86400*(DAYS(CURRENT DATE)-DAYS(DATE('2011-01-01')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP) from VIW_SALESDATA A,RCK_GOODS_DAYS B 
where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_DATE=B.CREA_DATE and A.GODS_ID=B.GODS_ID and A.BATCH_NO=B.BATCH_NO  
group by A.TENANT_ID,A.SHOP_ID,A.GUIDE_USER,A.DEPT_ID,A.CLIENT_ID,A.SALES_DATE,A.GODS_ID,A.BATCH_NO;


 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','�½�̨��','REPORT_SOURCE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('GODS_ID','��Ʒ','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SHOP_ID','�ŵ�','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SREGION_ID','�ŵ�������(��)','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SREGION_ID1','�ŵ�����ʡ','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('SREGION_ID2','�ŵ�������','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('21','��Ʒ����','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('22','��Ʒ����','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('23','��ƷС��','INDEX_TYPE4','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('24','��Ӧ��','INDEX_TYPE4','00',5497000);

alter table SYS_REPORT_TEMPLATE add CELL_WIDTH int;

--����������
alter table CA_SHOP_INFO add XSM_CODE varchar(50);
alter table CA_SHOP_INFO add XSM_PSWD varchar(50);

drop view VIW_USERS;
CREATE view VIW_USERS
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,QQ,MM,MSN,PASS_WRD,DEPT_ID,COMM from CA_USERS
union all
select TENANT_ID,ltrim(rtrim(char(TENANT_ID)))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'����Ա' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,ltrim(rtrim(char(TENANT_ID)))||'001' as DEPT_ID, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,ltrim(rtrim(char(B.TENANT_ID)))||'0001' as SHOP_ID,'system' as USER_ID,'system' as ACCOUNT,'ϵͳ�û�' as USER_NAME,'xtyf' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,ltrim(rtrim(char(B.TENANT_ID)))||'001' as DEPT_ID, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0
union all
select TENANT_ID,SHOP_ID,SHOP_ID as USER_ID,XSM_CODE as ACCOUNT,LINKMAN as USER_NAME,'' as USER_SPELL,'xsm' as DUTY_IDS,'xsm' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
XSM_PSWD as PASS_WRD,ltrim(rtrim(char(TENANT_ID)))||'001' as DEPT_ID, '00' as COMM from CA_SHOP_INFO where XSM_CODE is not null;

ALTER TABLE CA_MODULE ALTER column ACTION_URL SET DATA TYPE VARCHAR(255);   
