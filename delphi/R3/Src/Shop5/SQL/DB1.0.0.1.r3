--��Ʒ�۸�
CREATE TABLE [PUB_GOODSPRICE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	[PRICE_ID] [char] (36) NOT NULL , 
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���ű���
	[GODS_ID] [char] (36) NOT NULL ,
        --���۷�ʽ<��۷�ʽ>
	[PRICE_METHOD] [varchar] (1) NOT NULL ,
        --������λ�ۼ�
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --��װ1��λ�ۼ�
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --��װ2��λ�ۼ�
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_PUB_GOODSPRICE_COMM] DEFAULT ('00'),
        --����ʱ�� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_GOODSPRICE] PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
);

CREATE INDEX IX_PUB_GOODSPRICE_TENANT_ID ON PUB_GOODSPRICE(TENANT_ID);
CREATE INDEX IX_PUB_GOODSPRICE_SHOP_ID ON PUB_GOODSPRICE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_PUB_GOODSPRICE_GODS_ID ON PUB_GOODSPRICE(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSPRICE_PRICE_ID ON PUB_GOODSPRICE(TENANT_ID,PRICE_ID);
CREATE INDEX IX_PUB_GOODSPRICE_TIME_STAMP ON PUB_GOODSPRICE(TENANT_ID,TIME_STAMP);

--��Ʒ��չ��
CREATE TABLE [PUB_GOODSINFOEXT] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --���ű���
	[GODS_ID] [char] (36) NOT NULL ,
        --����1
	[SORT_ID1] [varchar] (36) NULL ,
        --����2
	[SORT_ID2] [varchar] (36) NULL ,
        --����3
	[SORT_ID3] [varchar] (36) NULL ,
        --����4
	[SORT_ID4] [varchar] (36) NULL ,
        --����5
	[SORT_ID5] [varchar] (36) NULL ,
        --����6
	[SORT_ID6] [varchar] (36) NULL ,
        --��ɫ��
	[SORT_ID7] [varchar] (36) NULL ,
        --������
	[SORT_ID8] [varchar] (36) NULL ,
        --�Զ���9
	[SORT_ID9] [varchar] (36) NULL ,
        --�Զ���10
	[SORT_ID10] [varchar] (36) NULL ,
        --�Զ���11
	[SORT_ID11] [varchar] (36) NULL ,
        --�Զ���12
	[SORT_ID12] [varchar] (36) NULL ,
        --�Զ���13
	[SORT_ID13] [varchar] (36) NULL ,
        --�Զ���14
	[SORT_ID14] [varchar] (36) NULL ,
        --�Զ���15
	[SORT_ID15] [varchar] (36) NULL ,
        --�Զ���16
	[SORT_ID16] [varchar] (36) NULL ,
        --�Զ���17
	[SORT_ID17] [varchar] (36) NULL ,
        --�Զ���18
	[SORT_ID18] [varchar] (36) NULL ,
        --�Զ���19
	[SORT_ID19] [varchar] (36) NULL ,
        --�Զ���20
	[SORT_ID20] [varchar] (36) NULL ,
        --������λ���½���
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --��װ1��λ���½���
	[NEW_INPRICE1] [decimal](18, 3) NULL ,
        --��װ2��λ���½���
	[NEW_INPRICE2] [decimal](18, 3) NULL ,
        --��ȫ���
	[LOWER_AMOUNT] [decimal](18, 3) NULL ,
        --���޿��
	[UPPER_AMOUNT] [decimal](18, 3) NULL ,
        --��ʹ�����
	[LOWER_RATE] [decimal](18, 3) NULL ,
        --��ߴ�����
	[UPPER_RATE] [decimal](18, 3) NULL ,
        --�վ�����
	[DAY_SALE_AMT] [decimal](18, 3) NULL ,
        --�����ȫ�����ڵ�
	[NEAR_SALE_AMT] [decimal](18, 3) NULL ,
        --���µ�����
	[MTH_SALE_AMT] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_PUB_GOODSINFOEXT_COMM] DEFAULT ('00'),
        --����ʱ�� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_GOODSINFOEXT] PRIMARY KEY (TENANT_ID,GODS_ID)
);
CREATE INDEX IX_PUB_GOODSINFOEXT_TENANT_ID ON PUB_GOODSINFOEXT(TENANT_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_TIME_STAMP ON PUB_GOODSINFOEXT(TENANT_ID,TIME_STAMP);
  
  
--��Ʒ�ŵ���չ��
CREATE TABLE [PUB_GOODS_INSHOP] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --���ű���
	[GODS_ID] [char] (36) NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��ȫ���
	[LOWER_AMOUNT] [decimal](18, 3) NULL ,
        --���޿��
	[UPPER_AMOUNT] [decimal](18, 3) NULL ,
        --��ʹ�����
	[LOWER_RATE] [decimal](18, 3) NULL ,
        --��ߴ�����
	[UPPER_RATE] [decimal](18, 3) NULL ,
        --�վ�����
	[DAY_SALE_AMT] [decimal](18, 3) NULL ,
        --�����ȫ�����ڵ�����
	[NEAR_SALE_AMT] [decimal](18, 3) NULL ,
        --���µ�����
	[MTH_SALE_AMT] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [PUB_GOODS_INSHOP_COMM] DEFAULT ('00'),
        --����ʱ�� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_G_INSHOP] PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID)
);
CREATE INDEX IX_PUB_G_INSHOP_TENANT_ID ON PUB_GOODS_INSHOP(TENANT_ID);
CREATE INDEX IX_PUB_G_INSHOP_GODS_ID ON PUB_GOODS_INSHOP(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_G_INSHOP_TIME_STAMP ON PUB_GOODS_INSHOP(TENANT_ID,TIME_STAMP);
               
--��ۼ�¼
CREATE TABLE [LOG_PRICING_INFO] (
        --�к�ID
	[ROWS_ID] [char] (36) NOT NULL ,
        --������� 20080101
	[PRICING_DATE] int NOT NULL , 
        --����Ա
	[PRICING_USER] varchar(36) NOT NULL , 
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	[PRICE_ID] [char] (36) NOT NULL , 
        --�ŵ���� 0 ʱ���������ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���ű���
	[GODS_ID] [char] (36) NOT NULL ,
        --���۷�ʽ
	[PRICE_METHOD] [varchar] (1) NOT NULL ,
        --������λ�ۼ�
	[ORG_OUTPRICE] [decimal](18, 3) NULL ,
        --��װ1��λ�ۼ�
	[ORG_OUTPRICE1] [decimal](18, 3) NULL ,
        --��װ2��λ�ۼ�
	[ORG_OUTPRICE2] [decimal](18, 3) NULL ,
        --������λ�ۼ�
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --��װ1��λ�ۼ�
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --��װ2��λ�ۼ�
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_LOG_PRICING_INFO_COMM] DEFAULT ('00'),
        --����ʱ�� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_LOG_PRICING_INFO] PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_LOG_PRICING_INFO_TENANT_ID ON LOG_PRICING_INFO(TENANT_ID);
CREATE INDEX IX_LOG_PRICING_INFO_PRICING_DATE ON LOG_PRICING_INFO(TENANT_ID,PRICING_DATE);
CREATE INDEX IX_LOG_PRICING_INFO_TIME_STAMP ON LOG_PRICING_INFO(TENANT_ID,TIME_STAMP);

--��ǰ���
CREATE TABLE [STO_STORAGE] (
        --��ID
	[ROWS_ID] varchar(36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (20) NOT NULL,
        --��Ʒ����
	[GODS_ID] [varchar] (38) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����������
	[NEAR_INDATE] [varchar] (10) NULL ,
        --�����������
	[NEAR_OUTDATE] [varchar] (10) NULL ,
        --�ɱ����
	[AMONEY] [decimal](18, 3) NOT NULL ,
        --�������
	[AMOUNT] [decimal](18, 3) NULL ,
        --�ɱ�����
	[COST_PRICE] [decimal](18, 6) NULL ,
        --��ȫ���
	[LOWER_AMOUNT] [decimal](18, 3) NULL ,
        --���޿��
	[UPPER_AMOUNT] [decimal](18, 3) NULL ,
        --��ʹ�����
	[LOWER_RATE] [decimal](18, 3) NULL ,
        --��ߴ�����
	[UPPER_RATE] [decimal](18, 3) NULL ,
        --�վ�����
	[DAY_SALE_AMT] [decimal](18, 3) NULL ,
        --�����ȫ�����ڵ�
	[NEAR_SALE_AMT] [decimal](18, 3) NULL ,
        --���µ�����
	[MTH_SALE_AMT] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_STORAGE_COMM] DEFAULT ('00'),
        --ʱ��� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_STO_STORAGE] PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_STO_STORAGE_TENANT_ID ON STO_STORAGE(TENANT_ID);
CREATE INDEX IX_STO_STORAGE_TIME_STAMP ON STO_STORAGE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_STORAGE_GODS_ID ON STO_STORAGE(TENANT_ID,GODS_ID);
CREATE INDEX IX_STO_STORAGE_SHOP_ID ON STO_STORAGE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_STO_STORAGE_KEYINDEX ON STO_STORAGE(TENANT_ID,SHOP_ID,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO);

--��Ա�Ƿ��ٴ���
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ٴ���','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ָ����','RATE_OFF','00',5497000);

--��������ͷ<���ݶ��Ա�ͷCOMM,TIME_STAMPͨѶ��־Ϊ׼>
CREATE TABLE [SAL_PRICEORDER] (
        --��¼ID��
	[PROM_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��ʼʱ�� yyyy-mm-dd hh:mm:ss
	[BEGIN_DATE] [varchar] (25) NOT NULL ,
        --����ʱ�� yyyy-mm-dd hh:mm:ss
	[END_DATE] [varchar] (25) NOT NULL ,
        --��Ա�ȼ�#��ʱ�����пͻ�
	[PRICE_ID] [char] (36) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --�Ƶ�����
	[CREA_DATE] int NULL ,
        --�Ƶ���Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_PRICEORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_SAL_PRICEORDER] PRIMARY KEY (TENANT_ID,PROM_ID)
);

CREATE INDEX IX_SAL_PRICEORDER_TENANT_ID ON SAL_PRICEORDER(TENANT_ID);
CREATE INDEX IX_SAL_PRICEORDER_TIME_STAMP ON SAL_PRICEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_PRICEORDER_SHOP_ID ON SAL_PRICEORDER(TENANT_ID,SHOP_ID);

--�����������ŵ�
CREATE TABLE [SAL_PROM_SHOP] (
        --��ID
	[ROWS_ID] varchar(36) NOT NULL ,
        --��¼ID��
	[PROM_ID] [varchar] (50) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
  CONSTRAINT [PK_SAL_PROM_SHOP] PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_SHOP_ID ON SAL_PROM_SHOP(TENANT_ID,PROM_ID);

--��������ϸ
CREATE TABLE [SAL_PRICEDATA] (
        --��¼ID��
	[PROM_ID] [varchar] (50) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --������λ�ۼ�
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,
        --��װ1��λ�ۼ�
	[NEW_OUTPRICE1] [decimal](18, 3) NULL ,
        --��װ2��λ�ۼ�
	[NEW_OUTPRICE2] [decimal](18, 3) NULL ,
        --��Ա�Ƿ��ٴ���
	[RATE_OFF] [int] NOT NULL ,
        --��Ա�ٴ�����
	[AGIO_RATE] [numeric](18, 3) NULL ,
        --�Ƿ���� 1Ϊֻ�Ի�Ա,0Ϊ������
	[ISINTEGRAL] [int] NOT NULL ,
	CONSTRAINT [PK_SAL_PRICEDATA] PRIMARY KEY  
	(
		[PROM_ID],[TENANT_ID],[SEQNO]
	) 
);

CREATE INDEX IX_SAL_PRICEDATA_TENANT_ID ON SAL_PRICEDATA(TENANT_ID);
CREATE INDEX IX_SAL_PRICEDATA_GODS_ID ON SAL_PRICEDATA(GODS_ID);

--��Ʊ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�տ��վ�','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ͨ��Ʊ','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��ֵ˰Ʊ','INVOICE_FLAG','00',5497000);

--����൥������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ⵥ','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','STOCK_TYPE','00',5497000);

--��ⵥ��ͷ
CREATE TABLE [STK_STOCKORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[STOCK_TYPE] [int] NOT NULL,
        --�������
	[STOCK_DATE] int NOT NULL ,
        --�ɹ�Ա
	[GUIDE_USER] [varchar] (36) NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --��������
	[FROM_ID] [char] (36) NULL ,
        --�������
	[FIG_ID] [char] (36) NULL ,
        --��������
	[DBOUT_ID] [char] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --�������
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --�����
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NOT NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
	      --ͨѶID��
	[COMM_ID] varchar(50) NULL,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_STOCKORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--ҵ������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�һ�','IS_PRESENT','00',5497000);

--��ⵥ��ϸ
CREATE TABLE [STK_STOCKDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (20) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (20) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --������λ��׼�ۼ�
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --�������<�Ƿ���Ʒ>
	[IS_PRESENT] [int] NOT NULL,
        --���ۼ�
	[APRICE] [decimal](18, 3) NULL ,
        --���
	[AMONEY] [decimal](18, 3) NULL ,
        --�ۿ���
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --�ۿ۶�
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --�����
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --��ע
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���۵�','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���۵�','SALES_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���۷�ʽ','CODE_TYPE','00',5497000);

--���۵���ͷ
CREATE TABLE [SAL_SALESORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���۵���
	[SALES_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[SALES_DATE] int NOT NULL ,
        --��������
	[SALES_TYPE] [int] NOT NULL,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36) NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NULL ,
        --���˱���
	[UNION_ID] [varchar] (36) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --��������
	[FROM_ID] [char] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --��������
	[SALE_AMT] [decimal](18, 3) NULL ,
        --���۽��
	[SALE_MNY] [decimal](18, 3) NULL ,
        --Ĩ����
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --ʵ���ֽ�
	[CASH_MNY] [decimal](18, 3) NULL ,
        --�ֽ�����
	[PAY_ZERO] [decimal](18, 3) NULL ,
        --���㷽ʽ
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
        --��������
	[INTEGRAL] [int] NULL ,
        --�һ�����
	[BARTER_INTEGRAL] [int] NULL,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --�Ƶ���
	[CREA_USER] [varchar] (36) NULL ,
        --ҵ��Ա<����Ա>
	[GUIDE_USER] [varchar] (36) NULL ,
        --���۷�ʽ
	[SALES_STYLE] [varchar] (21) NULL ,
        --�ͻ�����
	[PLAN_DATE] [varchar] (10) NULL ,
        --��ϵ��
	[LINKMAN] [varchar] (20) NULL ,
        --��ϵ�绰
	[TELEPHONE] [varchar] (30) NULL ,
        --�ͻ���ַ
	[SEND_ADDR] [varchar] (255) NULL ,
  --ˢ������
  BANK_ID varchar(36),
  --ˢ������
  BANK_CODE varchar(36),
	      --ͨѶID��
	[COMM_ID] varchar(50) NULL,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_SALESORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ͳһ����','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�ŵ궨��','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��Ʒ����','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','�������','POLICY_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���ʽ','CODE_TYPE','00',5497000);

insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'A','�ֽ�','XJ','1',1,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'B','ˢ��','YL','1',2,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'C','��ֵ��','CZK','1',3,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'D','����','JZ','1',4,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'E','ת��','LQ','1',5,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'F','֧Ʊ','ZP','1',6,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'G','��ȯ','XEZF','1',7,'00',5497000);

--���۵���ϸ
CREATE TABLE [SAL_SALESDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���۵���
	[SALES_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ
	[GODS_ID] [char] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --���۵�λ��׼�ۼ�
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --��������
	[POLICY_TYPE] [int] NOT NULL,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --�һ�����<��С��λ����Ļ���>
	[BARTER_INTEGRAL] [int] NULL,
        --���ۼ�
	[APRICE] [decimal](18, 3) NULL ,
        --���
	[AMONEY] [decimal](18, 3) NULL ,
        --��ǰ������λ����
	[COST_PRICE] [decimal](18, 3) NULL ,
        --�ۿ���
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --�ۿ۶�
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --������
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --�Ƿ��л���
	[HAS_INTEGRAL] [int] NOT NULL ,
        --˵��
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

--��ˮ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ֵ','IC_GLIDE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IC_GLIDE_TYPE','00',5497000);

--��ֵ����ˮ��¼
CREATE TABLE [SAL_IC_GLIDE] (
        --��ˮID��
	[GLIDE_ID] [char] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�ͻ�ID<���������� #>
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --���۵���
	[SALES_ID] [char] (36) NULL ,
        --����Ա
	[CREA_USER] [varchar] (36) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --ժҪ
	[GLIDE_INFO] [varchar] (100) NOT NULL ,
        --��ˮ����
	[IC_GLIDE_TYPE] [varchar] (1) NOT NULL ,
        --���㷽ʽ
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
        --���
	[GLIDE_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_IC_GLIDE_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--��������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���ͻ���','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�һ���ȯ','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�����ֽ�','INTEGRAL_FLAG','00',5497000);

--���ֶԻ�
CREATE TABLE [SAL_INTEGRAL_GLIDE] (
        --��ˮID��
	[GLIDE_ID] [char] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�ͻ�ID
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --��ˮ����
	[CREA_DATE] int NOT NULL ,
        --����Ա
	[CREA_USER] [varchar] (36) NOT NULL ,
        --����
	[INTEGRAL_FLAG] [varchar] (1) NOT NULL ,
        --ժҪ
	[GLIDE_INFO] [varchar] (255) NOT NULL ,
        --����
	[INTEGRAL] [decimal](18, 3) NULL ,
        --�Ի�ֵ<��ȯ���������ֽ���>
	[GLIDE_AMT] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INTEGRAL_GLIDE_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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


--���������� �������������� 1,2,3,4,5 ����ֱ�Ϊ
CREATE TABLE [STO_CHANGECODE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --����
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --����
	[CHANGE_NAME] [varchar] (20) NOT NULL ,
        --��������
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGECODE_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_CHANGECODE] PRIMARY KEY 
	(
		[TENANT_ID],[CHANGE_CODE]
	) 
);

insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','����','2','00',5497000);
insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','����','2','00',5497000);

--������
CREATE TABLE [STO_CHANGEORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CHANGE_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[CHANGE_DATE] int NOT NULL ,
        --��������
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --���ʹ���
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --��������
	[DEPT_ID] [varchar] (12) NULL ,
        --������
	[DUTY_USER] [varchar] (36) NULL ,
        --��������
	[CHANGE_AMT] [decimal](18, 3) NULL ,
        --�������
	[CHANGE_MNY] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����û�
	[CHK_USER] [varchar] (36) NULL ,
        --�����Ա
	[CHK_DATE] [varchar] (10) NULL ,
        --��Դ����,���̵㵥ʱ��Ӧ�̵���ID��
	[FROM_ID] [char] (36) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --��ϵ��
	[LINKMAN] [varchar] (20) NULL ,
        --��ϵ�绰
	[TELEPHONE] [varchar] (30) NULL ,
        --�ͻ���ַ
	[SEND_ADDR] [varchar] (255) NULL ,
	      --ͨѶID��
	[COMM_ID] varchar(50) NULL,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGEORDER_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--����������ϸ
CREATE TABLE [STO_CHANGEDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CHANGE_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36)  NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --���ۼ�
	[APRICE] [decimal](18, 3) NULL ,
        --���
	[AMONEY] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --��ǰ������λ����
	[COST_PRICE] [decimal](18, 3) NULL ,
        --������
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --����˵��
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

--��������
CREATE TABLE [STK_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[INDE_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[INDE_DATE] int NULL ,
        --�ͻ�����
	[PLAN_DATE] [varchar] (10) NULL ,
        --��ϵ��
	[LINKMAN] [varchar] (20) NULL ,
        --��ϵ�绰
	[TELEPHONE] [varchar] (30) NULL ,
        --�ͻ���ַ
	[SEND_ADDR] [varchar] (255) NULL ,
        --�ɹ�Ա
	[GUIDE_USER] [varchar] (36) NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [char] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --��������
	[INDE_AMT] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
	      --ͨѶID��
	[COMM_ID] varchar(50) NULL,
	      --����״̬
	STKBILL_STATUS int NULL,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_INDENTORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--����������ϸ
CREATE TABLE [STK_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [char] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36)  NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --��������
	[DEMAND_AMOUNT] [decimal](18, 3) NULL ,
        --��������
	[AMOUNT] [decimal](18, 3) NULL ,
        --ԭ����
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --���ۼ�
	[APRICE] [decimal](18, 3) NULL ,
        --���
	[AMONEY] [decimal](18, 3) NULL ,
        --�ۿ���
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --�ۿ۶�
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --��������
	[FNSH_AMOUNT] [decimal](18, 3) NULL ,
        --�����
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --��ע
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

--���۶���
CREATE TABLE [SAL_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[INDE_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[INDE_DATE] int NOT NULL ,
        --�ͻ�����
	[PLAN_DATE] [varchar] (10) NULL ,
        --��ϵ��
	[LINKMAN] [varchar] (20) NULL ,
        --��ϵ�绰
	[TELEPHONE] [varchar] (30) NULL ,
        --�ͻ���ַ
	[SEND_ADDR] [varchar] (255) NULL ,
        --ҵ��Ա<����Ա>
	[GUIDE_USER] [varchar] (36) NULL ,
        --���۷�ʽ
	[SALES_STYLE] [varchar] (21) NULL ,
        --�ͻ�
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NULL ,
        --���˱���
	[UNION_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --��������
	[INDE_AMT] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [char] (36) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
	      --ͨѶID��
	[COMM_ID] varchar(50) NULL,
	      --����״̬
	SALBILL_STATUS int NULL,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INDENTORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--���۶�����ϸ
CREATE TABLE [SAL_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [char] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36)  NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --��������
	[DEMAND_AMOUNT] [decimal](18, 3) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --ԭ����
	[ORG_PRICE] [decimal](18, 3) NULL ,
        --��������
	[POLICY_TYPE] [int] NOT NULL,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --�һ�����
	[BARTER_INTEGRAL] [int] NULL,
        --���ۼ�
	[APRICE] [decimal](18, 3) NULL ,
        --���
	[AMONEY] [decimal](18, 3) NULL ,
        --�ۿ���
	[AGIO_RATE] [decimal](18, 3) NULL ,
        --�ۿ۶�
	[AGIO_MONEY] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --ִ������
	[FNSH_AMOUNT] [decimal](18, 3) NULL ,
        --�����
	[CALC_MONEY] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --�Ƿ��л���
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

--�̵�״̬ 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���̵�','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���̵�','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�����','CHECK_STATUS','00',5497000);

--�̵㷽ʽ 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���̵�','CHECK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�����̵�','CHECK_TYPE','00',5497000);

--�̵���ͷ
CREATE TABLE [STO_PRINTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�̵����� 
	[PRINT_DATE] int NOT NULL ,
        --�̵�״̬
	[CHECK_STATUS] [int] NOT NULL ,
        --�̵㷽ʽ
	[CHECK_TYPE] [int] NOT NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --����û�
	[CHK_USER] [varchar] (36) NULL ,
        --�����Ա
	[CHK_DATE] [varchar] (10) NULL ,
        --ͨ����־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_PRINTORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_STO_PRINTORDER] PRIMARY KEY 
	(
		[TENANT_ID],
		[SHOP_ID],
		[PRINT_DATE]
	)
);

CREATE INDEX IX_STO_PRINTORDER_TENANT_ID ON STO_PRINTORDER(TENANT_ID);
CREATE INDEX IX_STO_PRINTORDER_PRINT_DATE ON STO_PRINTORDER(PRINT_DATE);

--�̵����ϸ
CREATE TABLE [STO_PRINTDATA] (
        --�к�
	[ROWS_ID] varchar(36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�̵����� 
	[PRINT_DATE] int NOT NULL ,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (36) NOT NULL,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36) NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --������
	[RCK_AMOUNT] [decimal](18, 3) NULL ,
        --�̵���
	[CHK_AMOUNT] [decimal](18, 3) NULL ,
        --�̵�״̬ 
	[CHECK_STATUS] [varchar] (6) NOT NULL ,
	CONSTRAINT [PK_STO_PRINTDATA] PRIMARY KEY  
	(
		[ROWS_ID]
	)
);

CREATE INDEX IX_STO_PRINTDATA_TENANT_ID ON STO_PRINTDATA(TENANT_ID);
CREATE INDEX IX_STO_PRINTDATA_SHOP_ID ON STO_PRINTDATA(SHOP_ID);
CREATE INDEX IX_STO_PRINTDATA_GODS_ID ON STO_PRINTDATA(GODS_ID);
CREATE INDEX IX_STO_PRINTDATA_PRINT_DATE ON STO_PRINTDATA(TENANT_ID,SHOP_ID,PRINT_DATE);

--�̵�¼���
CREATE TABLE [STO_CHECKDATA] (
        --�к�
	[ROWS_ID] varchar(36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�̵����� 
	[PRINT_DATE] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [char] (36)  NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --������
	[AMOUNT] [decimal](18, 3) NULL ,
        --������
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
	CONSTRAINT [PK_CHK_CHECKDATA] PRIMARY KEY  
	(
		[ROWS_ID]
	)
);

CREATE INDEX IX_STO_CHECKDATA_TENANT_ID ON STO_CHECKDATA(TENANT_ID);
CREATE INDEX IX_STO_CHECKDATA_SHOP_ID ON STO_CHECKDATA(SHOP_ID);
CREATE INDEX IX_STO_CHECKDATA_GODS_ID ON STO_CHECKDATA(GODS_ID);
CREATE INDEX IX_STO_CHECKDATA_PRINT_DATE ON STO_CHECKDATA(TENANT_ID,SHOP_ID,PRINT_DATE);

--�ʻ�����
CREATE TABLE [ACC_ACCOUNT_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [char] (36) NOT NULL ,
        --�����ŵ�<Ϊÿ���ŵ��Զ�����һ��<�ֽ��˻�>
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�ʻ�����
	[ACCT_NAME] [varchar] (50) NOT NULL ,
        --ƴ����
	[ACCT_SPELL] [varchar] (50) NOT NULL ,
        --��Ӧ֧����ʽ
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --�ڳ����
	[ORG_MNY] [decimal](18, 3) NULL ,
        --֧���ܶ� 
	[OUT_MNY] [decimal](18, 3) NULL ,
        --�����ܶ� 
	[IN_MNY] [decimal](18, 3) NULL ,
        --��ǰ���
	[BALANCE] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_ACCOUNT_INFO_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_ACCOUNT_INFO] PRIMARY KEY  
	(
		[TENANT_ID],[ACCOUNT_ID]
	)
) ;

CREATE INDEX IX_ACC_ACCOUNT_INFO_TENANT_ID ON ACC_ACCOUNT_INFO(TENANT_ID);
CREATE INDEX IX_ACC_ACCOUNT_INFO_TIME_STAMP ON ACC_ACCOUNT_INFO(TENANT_ID,TIME_STAMP);

--������֧��Ŀ���
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��֧��Ŀ','CODE_TYPE','00',5497000);

CREATE VIEW VIW_ITEM_INFO
as
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE='3';


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','Ӧ�տ�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','Ӧ�˿�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','Ԥ�տ�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���ۿ�','RECV_TYPE','00',5497000);

--Ӧ���ʿ�
CREATE TABLE [ACC_RECVABLE_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���
	[ABLE_ID] [char] (36) NOT NULL ,
        --�ͻ�
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --ժҪ
	[ACCT_INFO] [varchar] (255) NOT NULL ,
        --����
	[RECV_TYPE] [varchar] (1) NOT NULL ,
        --�տʽ
	[PAYM_ID] [varchar] (1) NULL ,
        --�ʿ���
	[ACCT_MNY] [decimal](18, 3) NULL ,
        --���ս��
	[RECV_MNY] [decimal](18, 3) NULL ,
        --������
	[RECK_MNY] [decimal](18, 3) NULL ,
        --���ʽ��
	[REVE_MNY] [decimal](18, 3) NULL ,
        --�ʿ�����
	[ABLE_DATE] int NULL ,
        --����տ�����
	[NEAR_DATE] [varchar] (10) NULL ,
        --��Դ����
	[SALES_ID] [varchar] (50) NULL ,
        --��¼��������
	[CREA_DATE] [varchar] (30) NULL ,
        --�����û�
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_RECVABLE_INFO_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','Ӧ����','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','Ӧ�˿�','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','Ԥ����','ABLE_TYPE','00',5497000);

--Ӧ���ʿ�
CREATE TABLE [ACC_PAYABLE_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --���
	[ABLE_ID] [char] (36) NOT NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --ժҪ
	[ACCT_INFO] [varchar] (255) NOT NULL ,
        --����
	[ABLE_TYPE] [varchar] (1) NOT NULL ,
        --�ʿ���
	[ACCT_MNY] [decimal](18, 3) NULL ,
        --�Ѹ����
	[PAYM_MNY] [decimal](18, 3) NULL ,
        --������
	[RECK_MNY] [decimal](18, 3) NULL ,
        --���ʽ��
	[REVE_MNY] [decimal](18, 3) NULL ,
        --�ʿ�����
	[ABLE_DATE] int NULL ,
        --�����������
	[NEAR_DATE] [varchar] (10) NULL ,
        --��Դ����
	[STOCK_ID] [varchar] (50) NULL ,
        --��¼��������
	[CREA_DATE] [varchar] (20) NULL ,
        --�����û�
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_PAYABLE_INFO_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--���
CREATE TABLE [ACC_PAYORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[PAY_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [char] (36) NOT NULL ,
        --���ʽ
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --��֧��Ŀ
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --��������
	[PAY_DATE] int NULL ,
        --������
	[PAY_USER] [varchar] (30) NULL ,
        --�����ܼ�
	[PAY_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --Ʊ�ݱ��
	[BILL_NO] [varchar] (50) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_PAYORDER_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--�����ϸ
CREATE TABLE [ACC_PAYDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[PAY_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --�ʿ�ID��
	[ABLE_ID] [char] (36) NOT NULL ,
        --����
	[ABLE_TYPE] [varchar] (1) NOT NULL ,
        --֧�����
	[PAY_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_PAYDATA] PRIMARY KEY  
	(
		[TENANT_ID],[PAY_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_ACC_PAYDATA_TENANT_ID ON ACC_PAYDATA(TENANT_ID);
CREATE INDEX IX_ACC_PAYDATA_PAY_ID ON ACC_PAYDATA(TENANT_ID,PAY_ID);
CREATE INDEX IX_ACC_PAYDATA_ABLE_ID ON ACC_PAYDATA(TENANT_ID,ABLE_ID);

--�տ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','�տ','RECV_FLAG','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ɿ','RECV_FLAG','00',5497000);

--�տ
CREATE TABLE [ACC_RECVORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[RECV_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [char] (36) NOT NULL ,
        --���ʽ
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --��֧��Ŀ
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --��������
	[RECV_DATE] int NULL ,
        --������
	[RECV_USER] [varchar] (30) NULL ,
        --�տ�ϼ�
	[RECV_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --ˢ������
  BANK_ID varchar(36) NULL,
        --ˢ������
  BANK_CODE varchar(36) NULL,
        --�տ����
  RECV_FLAG varchar(1) NOT NULL,
        --Ʊ�ݱ��
	[BILL_NO] [varchar] (50) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_RECVORDER_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--�տ��ϸ
CREATE TABLE [ACC_RECVDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[RECV_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --�ʿ�ID��
	[ABLE_ID] [char] (36) NOT NULL ,
        --����
	[RECV_TYPE] [varchar] (1) NOT NULL ,
        --֧�����
	[RECV_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_RECVDATA] PRIMARY KEY  
	(
		[TENANT_ID],[RECV_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_ACC_RECVDATA_TENANT_ID ON ACC_RECVDATA(TENANT_ID);
CREATE INDEX IX_ACC_RECVDATA_RECV_ID ON ACC_RECVDATA(TENANT_ID,RECV_ID);
CREATE INDEX IX_ACC_RECVDATA_ABLE_ID ON ACC_RECVDATA(TENANT_ID,ABLE_ID);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IORO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IORO_TYPE','00',5497000);

--����֧��
CREATE TABLE [ACC_IOROORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[IORO_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36) NULL ,
        --��֧��Ŀ
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --��֧����
	[DEPT_ID] [varchar] (12) NULL ,
        --��֧����
	[IORO_TYPE] [varchar] (1) NOT NULL ,
        --��֧����
	[IORO_DATE] int NOT NULL ,
        --������
	[IORO_USER] [varchar] (36) NULL ,
        --�ϼƽ��
	[IORO_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_IOROORDER_COMM] DEFAULT ('00'),
        --ʱ���
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

--��֧��ϸ
CREATE TABLE [ACC_IORODATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[IORO_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��֧�˻�
	[ACCOUNT_ID] [char] (36) NOT NULL ,
        --��Ӧ֧����ʽ
	[PAYM_ID] [varchar] (1) NOT NULL ,
        --Ʊ�ݱ��
	[BILL_NO] [varchar] (50) NULL ,
        --ժҪ
	[IORO_INFO] [varchar] (255) NULL ,
        --��֧���
	[IORO_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_IORODATA] PRIMARY KEY  
	(
		[TENANT_ID],[IORO_ID],[SEQNO]
	) 
) ;
CREATE INDEX IX_ACC_IORODATA_TENANT_ID ON ACC_IORODATA(TENANT_ID);
CREATE INDEX IX_ACC_IORODATA_CLIENT_ID ON ACC_IORODATA(TENANT_ID,IORO_ID);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ŵ�����','CLSE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��Ա��ֵ','CLSE_TYPE','00',5497000);

--���۽��˱�
CREATE TABLE [ACC_CLOSE_FORDAY] (
        --�к�
	[ROWS_ID] [char] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��������
	[CLSE_TYPE] [varchar] (1) NOT NULL ,
        --��������
	[CLSE_DATE] int NULL ,
        --���˽��
	[CLSE_MNY] [decimal](18, 3) NULL ,
        --���㷽ʽ
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
	      --������Ǯ
	[BALANCE] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_CLOSE_FORDAY_COMM] DEFAULT ('00'),
        --ʱ���
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_CLOSE_FORDAY] PRIMARY KEY  
	(
		[ROWS_ID]
	) 
) ;
CREATE INDEX IX_ACC_CLOSE_FORDAY_TENANT_ID ON ACC_CLOSE_FORDAY(TENANT_ID);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATE ON ACC_CLOSE_FORDAY(CLSE_DATE);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATA ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

--��ȡ�
CREATE TABLE [ACC_TRANSORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[TRANS_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --ת���˺�
	[IN_ACCOUNT_ID] [char] (36) NOT NULL ,
        --ת���˺�
	[OUT_ACCOUNT_ID] [char] (36) NOT NULL ,
        --����
	[TRANS_DATE] int NOT NULL ,
        --������
	[TRANS_USER] [varchar] (36) NULL ,
	      --��ȡ���
	[TRANS_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --Ʊ�ݱ��
	[BILL_NO] [varchar] (50) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_ACC_TRANSORDER_COMM] DEFAULT ('00'),
        --ʱ���
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_ACC_TRANSORDER] PRIMARY KEY 
	(
		[TENANT_ID],[TRANS_ID]
	) 
) ;

CREATE INDEX IX_ACC_TRANSORDER_TENANT_ID ON ACC_TRANSORDER(TENANT_ID);
CREATE INDEX IX_ACC_TRANSORDER_TIME_STAMP ON ACC_TRANSORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_TRANSORDER_TRANS_DATE ON ACC_TRANSORDER(TENANT_ID,TRANS_DATE);


--��а�װ<BOM�嵥>
CREATE TABLE [SAL_BOMORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����<�����ŵ�>
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�������
	[BOM_ID] [char] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��б��
	[GIFT_CODE] [varchar] (36) NOT NULL ,
        --�������
	[GIFT_NAME] [varchar] (36) NOT NULL ,
        --����
	[BARCODE] [varchar] (36) NOT NULL ,
        --�������
	[BOM_AMOUNT] [decimal](18, 3) NULL ,
        --��������
	[RCK_AMOUNT] [decimal](18, 3) NULL ,
        --���ۼ�
	[RTL_PRICE] [decimal](18, 3) NULL ,
        --��װ����
	[BOM_DATE] int NOT NULL ,
        --������
	[BOM_USER] [varchar] (36) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --˵��
	[REMARK] [varchar] (255) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_BOMORDER_COMM] DEFAULT ('00'),
        --ʱ���
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_BOMORDER] PRIMARY KEY 
	(
		[TENANT_ID],[BOM_ID]
	) 
) ;

CREATE INDEX IX_SAL_BOMORDER_TENANT_ID ON SAL_BOMORDER(TENANT_ID);
CREATE INDEX IX_SAL_BOMORDER_TIME_STAMP ON SAL_BOMORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMORDER_BOM_DATE ON SAL_BOMORDER(TENANT_ID,BOM_DATE);

--����Ӽ���Ʒ�嵥<BOM�嵥>
CREATE TABLE [SAL_BOMDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[BOM_ID] [char] (36) NOT NULL ,
        --���
	[SEQNO] int NOT NULL,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (36) NOT NULL,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��Ʒ����
	[GODS_ID] [char] (36) NOT NULL ,
        --������λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --һ�������ӵ�е�����
	[AMOUNT] [decimal](18, 3) NULL ,
        --һ�������ӵ�е�����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --��е�Ʒ���۵���
	[RTL_PRICE] [decimal](18, 3) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_BOMDATA_COMM] DEFAULT ('00'),
        --ʱ���
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_BOMDATA] PRIMARY KEY 
	(
		[TENANT_ID],[BOM_ID],[SEQNO]
	) 
) ;

CREATE INDEX IX_SAL_BOMDATA_TENANT_ID ON SAL_BOMDATA(TENANT_ID);
CREATE INDEX IX_SAL_BOMDATA_TIME_STAMP ON SAL_BOMDATA(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMDATA_GODS_ID ON SAL_BOMDATA(TENANT_ID,GODS_ID);

--��Ʊ����
CREATE TABLE [SAL_INVOICE_BOOK] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --��ˮID��
	[INVH_ID] [char] (36) NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --������
	[CREA_USER] int NOT NULL ,
        --��������
	[CREA_DATE] int NOT NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --��Ʊ����
	[INVH_NO] [varchar] (50) NOT NULL ,
        --��Ʊ��ʼ��
	[BEGIN_NO] int NOT NULL ,
        --��Ʊ��ֹ��
	[ENDED_NO] int NOT NULL ,
        --�ϼ�����
	[TOTAL_AMT] int NULL ,
        --��Ʊ����
	[USING_AMT] int NULL ,
        --��������
	[CANCEL_AMT] int NULL ,
        --��������
	[BALANCE] int NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INVOICE_BOOK_COMM] DEFAULT ('00'),
        --ʱ��� 
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��Ʊ','INVOICE_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','INVOICE_STATUS','00',5497000);

--��Ʊ��ϸ
CREATE TABLE [SAL_INVOICE_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --��ˮID��
	[INVH_ID] [char] (36) NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --��Ʊ��
	[CREA_USER] [varchar] (36) NOT NULL ,
        --��Ʊ����
	[CREA_DATE] int NOT NULL ,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36)  NOT NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
	      --��Ʊ��
	[INVOICE_NO] int NOT NULL ,
        --��Ʊ״̬
	[INVOICE_STATUS] [varchar] (1) NOT NULL ,
        --���۵���
	[SALES_ID] [char] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INVOICE_INFO_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_SAL_INVOICE_INFO] PRIMARY KEY   
	(
		[TENANT_ID],[INVH_ID],[INVOICE_NO]
	) 
);

CREATE INDEX IX_SAL_INVOICE_INFO_TENANT_ID ON SAL_INVOICE_INFO(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_INFO_TIME_STAMP ON SAL_INVOICE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_INFO_CREA_DATE ON SAL_INVOICE_INFO(CREA_DATE);

--   ̨�˹滮      ---
--ʱ��:2011-02-21
--����:��ɭ��

--�ս��˼�¼
CREATE TABLE [RCK_DAYS_CLOSE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�����û�
	[CREA_USER] [varchar] (36) NOT NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_DAYS_CLOSE_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_DAYS_CLOSE] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[CREA_DATE]
	) 
);

--�½��˼�¼
CREATE TABLE [RCK_MONTH_CLOSE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[MONTH] int NOT NULL ,
        --�����û�
	[CREA_USER] [varchar] (36) NOT NULL ,
        --��ʼ����
	[BEGIN_DATE] [varchar] (10) NULL ,
        --��������
	[END_DATE] [varchar] (10) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_MONTH_CLOSE_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_MONTH_CLOSE] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[MONTH]
	) 
);

--��Ʒ��̨��
CREATE TABLE [RCK_GOODS_DAYS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [char] (36)  NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,

--����ʱ��������Ϣ
        --��ʱ����
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --��ʱ����
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--�ڳ���̨��		
        --�ڳ�����
	[ORG_AMT] [decimal](18, 3) NULL ,
        --�ڳ����<����ʱ����>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
	[ORG_CST] [decimal](18, 3) NULL ,
	
--������̨��	
        --��������<���˻�>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --�������<ĩ˰>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --�������<��Ӧ������>
	[STOCK_AGO] [decimal](18, 3) NULL ,
	
        --�����˻�����
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --�˻����<ĩ˰>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--������̨��	
        --��������<���˻�>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --�������<��������>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALE_TAX] [decimal](18, 3) NULL ,
        --���۳ɱ�
	[SALE_CST] [decimal](18, 3) NULL ,
        --�ɱ�����<�ƶ���Ȩ�ɱ�>
	[COST_PRICE] [decimal](18, 6) NULL ,
        --����ë��
	[SALE_PRF] [decimal](18, 3) NULL ,
	
	
        --�����˻�����
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --�˻��ɱ�
	[SALRT_CST] [decimal](18, 3) NULL ,
	
--������̨��	
        --��������
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --��������
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--�����̨��	
        --��������
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --��������
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE5_CST] [decimal](18, 3) NULL ,

--�����̨��		
        --�������
	[BAL_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[BAL_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[BAL_RTL] [decimal](18, 3) NULL ,
        --���ɱ�<�ƶ���Ȩ�ɱ�>
	[BAL_CST] [decimal](18, 3) NULL ,
	
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_GOODS_DAYS_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--�ɱ�������ʱ��
CREATE TABLE [TMP_GOODS_DAYS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [char] (36)  NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
	
--����ʱ��������Ϣ
        --��ʱ����
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --��ʱ����
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--�ڳ���̨��		
        --�ڳ�����
	[ORG_AMT] [decimal](18, 3) NULL ,
        --�ڳ����<����ʱ����>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
	[ORG_CST] [decimal](18, 3) NULL ,

--������̨��	
        --��������<���˻�>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --�������<ĩ˰>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --�������<��Ӧ������>
	[STOCK_AGO] [decimal](18, 3) NULL ,
	
        --�����˻�����
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --�˻����<ĩ˰>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--������̨��	
        --��������<���˻�>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --�������<��������>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALE_TAX] [decimal](18, 3) NULL ,
        --���۳ɱ�
	[SALE_CST] [decimal](18, 3) NULL ,
        --�ɱ�����<�ƶ���Ȩ�ɱ�>
	[COST_PRICE] [decimal](18, 6) NULL ,
        --����ë��
	[SALE_PRF] [decimal](18, 3) NULL ,
	
	
        --�����˻�����
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --�˻��ɱ�
	[SALRT_CST] [decimal](18, 3) NULL ,
	
--������̨��	
        --��������
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --��������
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--�����̨��	
        --��������
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --��������
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE5_CST] [decimal](18, 3) NULL 
);
CREATE INDEX IX_TMP_GOODS_DAYS_TENANT_ID ON TMP_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_TMP_GOODS_DAYS_CREA_DATE ON TMP_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_TMP_GOODS_DAYS_GODS_ID ON TMP_GOODS_DAYS(TENANT_ID,GODS_ID);

--��Ʒ��̨��
CREATE TABLE [RCK_GOODS_MONTH] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�·�
	[MONTH] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [char] (36)  NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
	
--����ʱ��������Ϣ
        --��ʱ����
	[NEW_INPRICE] [decimal](18, 3) NULL ,
        --��ʱ����
	[NEW_OUTPRICE] [decimal](18, 3) NULL ,

--�ڳ���̨��		
        --�ڳ�����
	[ORG_AMT] [decimal](18, 3) NULL ,
        --�ڳ����<����ʱ����>
	[ORG_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[ORG_RTL] [decimal](18, 3) NULL ,
        --�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
	[ORG_CST] [decimal](18, 3) NULL ,
	
--������̨��	
        --��������<���˻�>
	[STOCK_AMT] [decimal](18, 3) NULL ,
        --�������<ĩ˰>
	[STOCK_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STOCK_TAX] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[STOCK_RTL] [decimal](18, 3) NULL ,
        --�������<��Ӧ������>
	[STOCK_AGO] [decimal](18, 3) NULL ,

        --�����˻�����
	[STKRT_AMT] [decimal](18, 3) NULL ,
        --�˻����<ĩ˰>
	[STKRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[STKRT_TAX] [decimal](18, 3) NULL ,
	

--������̨��	
        --��������<���˻�>
	[SALE_AMT] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[SALE_RTL] [decimal](18, 3) NULL ,
        --�������<��������>
	[SALE_AGO] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALE_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALE_TAX] [decimal](18, 3) NULL ,
        --���۳ɱ�
	[SALE_CST] [decimal](18, 3) NULL ,
        --����ë��
	[SALE_PRF] [decimal](18, 3) NULL ,
	
        --�����˻�����<���˻�>
	[SALRT_AMT] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[SALRT_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[SALRT_TAX] [decimal](18, 3) NULL ,
        --�˻��ɱ�
	[SALRT_CST] [decimal](18, 3) NULL ,
	
        --ȥ��ͬ������<���˻�>
	[PRIOR_YEAR_AMT] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[PRIOR_YEAR_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[PRIOR_YEAR_TAX] [decimal](18, 3) NULL ,
        --����ɱ�
	[PRIOR_YEAR_CST] [decimal](18, 3) NULL ,
	
        --������������
	[PRIOR_MONTH_AMT] [decimal](18, 3) NULL ,
        --���۽��<ĩ˰>
	[PRIOR_MONTH_MNY] [decimal](18, 3) NULL ,
        --����˰��
	[PRIOR_MONTH_TAX] [decimal](18, 3) NULL ,
        --����ɱ�
	[PRIOR_MONTH_CST] [decimal](18, 3) NULL ,
	
--������̨��	
        --��������
	[DBIN_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBIN_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBIN_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBIN_CST] [decimal](18, 3) NULL ,
	
        --��������
	[DBOUT_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[DBOUT_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[DBOUT_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[DBOUT_CST] [decimal](18, 3) NULL ,
	
--�����̨��	
        --��������
	[CHANGE1_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE1_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE1_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE1_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE2_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE2_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE2_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE2_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE3_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE3_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE3_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE3_CST] [decimal](18, 3) NULL ,

        --��������
	[CHANGE4_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE4_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE4_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE4_CST] [decimal](18, 3) NULL ,
	
        --��������
	[CHANGE5_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[CHANGE5_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[CHANGE5_RTL] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[CHANGE5_CST] [decimal](18, 3) NULL ,

--�����̨��		
        --�������
	[BAL_AMT] [decimal](18, 3) NULL ,
        --������<����ʱ����>
	[BAL_MNY] [decimal](18, 3) NULL ,
        --�����۶�<�����ۼ�>
	[BAL_RTL] [decimal](18, 3) NULL ,
        --���ɱ�<�ƶ���Ȩ�ɱ�>
	[BAL_CST] [decimal](18, 3) NULL ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	[ADJ_CST] [decimal](18, 3) NULL ,
	
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_GOODS_MONTH_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--�˻���̨��
CREATE TABLE [RCK_ACCT_DAYS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�˻�����
	[ACCOUNT_ID] [char] (36)  NOT NULL ,

--�ڳ���̨��		
        --�ڳ����
	[ORG_MNY] [decimal](18, 3) NULL ,
 
--������̨��		
        --������
	[IN_MNY] [decimal](18, 3) NULL ,

--֧����̨��		
        --֧�����
	[OUT_MNY] [decimal](18, 3) NULL ,

--������		
	[PAY_MNY] [decimal](18, 3) NULL ,
--�տ���		
	[RECV_MNY] [decimal](18, 3) NULL ,
--���۽��		
	[POS_MNY] [decimal](18, 3) NULL ,
--�����		
	[TRN_IN_MNY] [decimal](18, 3) NULL ,
--ȡ����		
	[TRN_OUT_MNY] [decimal](18, 3) NULL ,
--��ֵ���		
	[PUSH_MNY] [decimal](18, 3) NULL ,
--��������		
	[IORO_IN_MNY] [decimal](18, 3) NULL ,
--����֧��		
	[IORO_OUT_MNY] [decimal](18, 3) NULL ,
	
--�����̨��		
        --�������
	[BAL_MNY] [decimal](18, 3) NULL ,
	
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_ACCT_DAYS_COMM] DEFAULT ('00'),
        --ʱ��� 
  [TIME_STAMP] bigint NOT NULL,
	CONSTRAINT [PK_RCK_ACCT_DAYS] PRIMARY KEY   
	(
		[TENANT_ID],[SHOP_ID],[CREA_DATE],[ACCOUNT_ID]
	) 
);

CREATE INDEX IX_RCK_ACCT_DAYS_TENANT_ID ON RCK_ACCT_DAYS(TENANT_ID);
CREATE INDEX IX_RCK_ACCT_DAYS_TIME_STAMP ON RCK_ACCT_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_ACCT_DAYS_CREA_DATE ON RCK_ACCT_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCK_ACCT_DAYS_ACCOUNT_ID ON RCK_ACCT_DAYS(TENANT_ID,ACCOUNT_ID);

--�˻���̨��
CREATE TABLE [RCK_ACCT_MONTH] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (13) NOT NULL ,
        --�·�
	[MONTH] int NOT NULL ,
        --�˻�����
	[ACCOUNT_ID] [char] (36)  NOT NULL ,

--�ڳ���̨��		
        --�ڳ����
	[ORG_MNY] [decimal](18, 3) NULL ,
 
--������̨��		
        --������
	[IN_MNY] [decimal](18, 3) NULL ,

--֧����̨��		
        --֧�����
	[OUT_MNY] [decimal](18, 3) NULL ,

--������		
	[PAY_MNY] [decimal](18, 3) NULL ,
--�տ���		
	[RECV_MNY] [decimal](18, 3) NULL ,
--���۽��		
	[POS_MNY] [decimal](18, 3) NULL ,
--�����		
	[TRN_IN_MNY] [decimal](18, 3) NULL ,
--ȡ����		
	[TRN_OUT_MNY] [decimal](18, 3) NULL ,
--��ֵ���		
	[PUSH_MNY] [decimal](18, 3) NULL ,
--��������		
	[IORO_IN_MNY] [decimal](18, 3) NULL ,
--����֧��		
	[IORO_OUT_MNY] [decimal](18, 3) NULL ,
	
--�����̨��		
        --�������
	[BAL_MNY] [decimal](18, 3) NULL ,
	
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_RCK_ACCT_MONTH_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--ɨ�����
CREATE TABLE SAL_LOCUS_FORSALE(
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (13) NOT NULL ,
        --���۵���
	SALES_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ
	GODS_ID char (36) NOT NULL ,
        --����<����ʱ�� # ��>
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	PROPERTY_02 varchar (36) NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
        --ɨ������
	LOCUS_DATE int NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --����
	AMOUNT decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,

        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --���ʱ��
	CHK_DATE varchar (30) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_SAL_LS_FORSALE PRIMARY KEY  
	(
		TENANT_ID,
		SALES_ID,
		SEQNO
	)
);

--ɨ�����<���ã�����ȵĳ���>
CREATE TABLE STO_LOCUS_FORCHAG(
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (13) NOT NULL ,
        --��������
	CHANGE_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ
	GODS_ID char (36) NOT NULL ,
        --����<����ʱ�� # ��>
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	PROPERTY_02 varchar (36) NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
        --ɨ������
	LOCUS_DATE int NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --����
	AMOUNT decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,

        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --���ʱ��
	CHK_DATE varchar (30) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_STO_LS_FORCHAG PRIMARY KEY  
	(
		TENANT_ID,
		CHANGE_ID,
		SEQNO
	)
);


--ɨ�����
CREATE TABLE STK_LOCUS_FORSTCK(
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (13) NOT NULL ,
        --���۵���
	STOCK_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ
	GODS_ID char (36) NOT NULL ,
        --����<����ʱ�� # ��>
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	PROPERTY_02 varchar (36) NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
        --ɨ������
	LOCUS_DATE int NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --����
	AMOUNT decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,

        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --���ʱ��
	CHK_DATE varchar (30) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_STK_LS_FORSTCK PRIMARY KEY  
	(
		TENANT_ID,
		STOCK_ID,
		SEQNO
	)
);


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
		TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO
	) 
);
CREATE INDEX IX_RCK_C_GOODS_DAYS_TENANT_ID ON RCK_C_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_RCK_C_GOODS_DAYS_TIME_STAMP ON RCK_C_GOODS_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_C_GOODS_DAYS_CREA_DATE ON RCK_C_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCK_C_GOODS_DAYS_GODS_ID ON RCK_C_GOODS_DAYS(TENANT_ID,GODS_ID);
CREATE INDEX IX_RCK_C_GOODS_DAYS_CLIENT_ID ON RCK_C_GOODS_DAYS(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_RCK_C_GOODS_DAYS_DEPT_ID ON RCK_C_GOODS_DAYS(TENANT_ID,DEPT_ID);
