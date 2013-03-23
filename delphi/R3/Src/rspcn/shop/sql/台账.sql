--˰�ʴ���
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

--��������ˮ
CREATE TABLE RCK_STOCKS_DATA
(
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (13) NOT NULL ,
        --����
	BILL_ID char (36) NOT NULL ,
        --������ˮ��
	BILL_CODE varchar (20) NULL ,
        --��������
	BILL_TYPE int NOT NULL ,
        --��������
	BILL_NAME varchar (10) NULL ,
        --����
	BILL_DATE int NOT NULL ,
        --�����-ÿ����ˮ
	SEQNO int NOT NULL ,
        --��Ӧ��
	RELATION_ID int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --����<����ʶ����>
	GODS_CODE varchar (20) NOT NULL ,
        --Ʒ�����
	GODS_NAME varchar (50) NOT NULL ,
	--������λ����
	BARCODE varchar (30) NULL ,
        --��Ʒ����
	SORT_ID varchar (36) NOT NULL ,
        --��������
	SORT_NAME varchar (10) NULL ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --����<��ʶ��> 
	CLIENT_CODE varchar (20) NULL ,
        --�ͻ�����
	CLIENT_NAME varchar (50) NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --��λ����
	UNIT_NAME varchar (10) NULL ,
        --ת������С��λϵ��
    	CONV_RATE decimal(18, 3) NOT NULL ,
        --����
        BATCH_NO varchar (36) NOT NULL ,
        --���
        PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ
        PROPERTY_02 varchar (36) NOT NULL ,
        --�� {����ͳһ�洢��С��λ}
    	IN_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,
	IN_PRICE  decimal(18, 6) NOT NULL DEFAULT 0,
	IN_MONEY  decimal(18, 3) NOT NULL DEFAULT 0,
	IN_TAX  decimal(18, 3) NOT NULL DEFAULT 0,
        --��
        OUT_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,			
        --�ɱ�����
        OUT_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        --�ɱ����
        OUT_MONEY decimal(18, 3) NOT NULL DEFAULT 0,		
        --��	 
        SALE_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        SALE_MONEY decimal(18, 3) NOT NULL DEFAULT 0,			
        SALE_TAX decimal(18, 3) NOT NULL DEFAULT 0,	
        --��		
        BAL_AMOUNT decimal(18, 3) NOT NULL DEFAULT 0,			
        BAL_PRICE decimal(18, 6) NOT NULL DEFAULT 0,			
        BAL_MONEY decimal(18, 3) NOT NULL DEFAULT 0,			
        --ҵ��Ա<����Ա,������>
	GUIDE_USER varchar (36) NULL ,
	GUIDE_NAME varchar (20) NULL ,
        --�Ƶ�Ա
	CREA_USER varchar (36) NULL ,
	CREA_NAME varchar (20) NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL CONSTRAINT DF_RCK_STOCKS_DATA_COMM DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
        TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_STOCKS_DATA PRIMARY KEY 
	(
		ID
	)
);

CREATE INDEX IX_RCK_STOCKS_DATA_TENANT_ID ON RCK_STOCKS_DATA(TENANT_ID);
CREATE INDEX IX_RCK_STOCKS_DATA_GODS_ID ON RCK_STOCKS_DATA(GODS_ID);
CREATE INDEX IX_RCK_STOCKS_DATA_BILL_DATE ON RCK_STOCKS_DATA(BILL_DATE);
