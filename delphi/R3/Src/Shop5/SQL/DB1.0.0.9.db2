update PUB_PARAMS set CODE_NAME='��Ʒ����' where TYPE_CODE='SORT_TYPE' and CODE_ID='1';
update PUB_PARAMS set CODE_NAME='��Ʒ����' where TYPE_CODE='SORT_TYPE' and CODE_ID='2';
update PUB_PARAMS set CODE_NAME='����Ӧ��' where TYPE_CODE='SORT_TYPE' and CODE_ID='3';
update PUB_PARAMS set CODE_NAME='����Ʒ��' where TYPE_CODE='SORT_TYPE' and CODE_ID='4';
update PUB_PARAMS set CODE_NAME='�ص�Ʒ��' where TYPE_CODE='SORT_TYPE' and CODE_ID='5';
update PUB_PARAMS set CODE_NAME='ʡ����' where TYPE_CODE='SORT_TYPE' and CODE_ID='6';
update PUB_PARAMS set CODE_NAME='��������' where TYPE_CODE='SORT_TYPE' and CODE_ID='9';

update CA_MODULE set MODU_NAME='��Ʒ���' where MODU_ID='14500001';

--�վ�����
alter table STO_STORAGE add	DAY_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add DAY_SALE_AMT decimal(18, 3);
--�����ȫ�����ڵ�
alter table STO_STORAGE add	NEAR_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add NEAR_SALE_AMT decimal(18, 3);
--���µ�����
alter table STO_STORAGE add	MTH_SALE_AMT decimal(18, 3);
alter table PUB_GOODSINFOEXT add MTH_SALE_AMT decimal(18, 3);

--��Ʒ�ŵ���չ��
CREATE TABLE PUB_GOODS_INSHOP (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --���ű���
	GODS_ID char (36) NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (13) NOT NULL ,
        --��ȫ���
	LOWER_AMOUNT decimal(18, 3) ,
        --���޿��
	UPPER_AMOUNT decimal(18, 3) ,
        --��ʹ�����
	LOWER_RATE decimal(18, 3) ,
        --��ߴ�����
	UPPER_RATE decimal(18, 3) ,
        --�վ�����
	DAY_SALE_AMT decimal(18, 3) ,
        --�����ȫ�����ڵ�����
	NEAR_SALE_AMT decimal(18, 3) ,
        --���µ�����
	MTH_SALE_AMT decimal(18, 3) ,
	COMM varchar(2) NOT NULL  DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_INSHOP PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID)
) IN R3TB4K_BAS;
CREATE INDEX I_PGIS_TENANT_ID ON PUB_GOODS_INSHOP(TENANT_ID);
CREATE INDEX I_PGIS_GODS_ID ON PUB_GOODS_INSHOP(TENANT_ID,GODS_ID);
CREATE INDEX I_PGIS_TIME_STAMP ON PUB_GOODS_INSHOP(TENANT_ID,TIME_STAMP);
 
--��;������
create view VIW_SR_INFO
as
select A.TENANT_ID,B.CLIENT_ID as SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,sum(A.CALC_AMOUNT) as AMOUNT 
from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.SALES_TYPE=2 and B.PLAN_DATE is null
group by A.TENANT_ID,B.CLIENT_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02;

--����ջ���ַ���ջ���
alter table STO_CHANGEORDER add	SEND_ADDR varchar(255);
alter table STO_CHANGEORDER add TELEPHONE varchar(30);
alter table STO_CHANGEORDER add LINKMAN varchar(20);
