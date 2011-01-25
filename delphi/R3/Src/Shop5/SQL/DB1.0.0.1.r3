--��Ʒ�۸�
CREATE TABLE [PUB_GOODSPRICE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���ű���
	[GODS_ID] [varchar] (36) NOT NULL ,
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

--����Ʒ�۸�
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

--��ۼ�¼
CREATE TABLE [LOG_PRICING_INFO] (
        --�к�ID
	[ROWS_ID] [varchar] (36) NOT NULL ,
        --������� 20080101
	[PRICING_DATE] int NOT NULL , 
        --����Ա
	[PRICING_USER] varchar(36) NOT NULL , 
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --�ŵ���� 0 ʱ���������ŵ�
	[SHOP_ID] int NOT NULL ,
        --���ű���
	[GODS_ID] [varchar] (36) NOT NULL ,
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
  CONSTRAINT [PK_LOG_PRICING_INFO] PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
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
	[SHOP_ID] int NOT NULL ,
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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ٴ���','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ָ����','RATE_OFF','00',strftime('%s','now','localtime')-1293840000)
GO

--��������ͷ<���ݶ��Ա�ͷCOMM,TIME_STAMPͨѶ��־Ϊ׼>
CREATE TABLE [SAL_PRICEORDER] (
        --��¼ID��
	[PROM_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ����
	[SHOP_ID] int NOT NULL ,
        --��ʼʱ�� yyyy-mm-dd hh:mm:ss
	[BEGIN_DATE] [varchar] (25) NOT NULL ,
        --����ʱ�� yyyy-mm-dd hh:mm:ss
	[END_DATE] [varchar] (25) NOT NULL ,
        --��Ա�ȼ�#��ʱ�����пͻ�
	[PRICE_ID] [varchar] (16) NULL ,
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
	[SHOP_ID] int NOT NULL ,
  CONSTRAINT [PK_SAL_PROM_SHOP] PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_TIME_STAMP ON SAL_PROM_SHOP(TENANT_ID,TIME_STAMP);
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
	[GODS_ID] [varchar] (36) NOT NULL ,
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

--���ŵ�����۸�
CREATE view [VIW_PROM_PRICE]
as
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROD_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROD_ID=B.PROD_ID and A.TENANT_ID=C.TENANT_ID and A.PROD_ID=C.PROD_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
B.BEGIN_DATE<=strftime('%Y-%m-%d %H:%M:%S','now','localtime') and B.END_DATE>=strftime('%Y-%m-%d %H:%M:%S','now','localtime');

--��Ʊ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�տ��վ�','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ͨ��Ʊ','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��ֵ˰Ʊ','INVOICE_FLAG','00',strftime('%s','now','localtime')-1293840000);
--����൥������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ⵥ','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','STOCK_TYPE','00',strftime('%s','now','localtime')-1293840000);

--��ⵥ��ͷ
CREATE TABLE [STK_STOCKORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [varchar] (36) NOT NULL ,
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
	[FROM_ID] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --��������
	[DBOUT_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
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
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_STOCKORDER_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--��ⵥ��ͷ--��ʷ��
CREATE TABLE [STK_STOCKORDER_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [varchar] (36) NOT NULL ,
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
	[FROM_ID] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --��������
	[DBOUT_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
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
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_STOCKORDER_HIS_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--ҵ������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�һ�','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);

--��ⵥ��ϸ
CREATE TABLE [STK_STOCKDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (20) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (20) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --��׼�ۼ�
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

--��ⵥ��ϸ
CREATE TABLE [STK_STOCKDATA_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --��ⵥ��
	[STOCK_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (20) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (20) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --��׼�ۼ�
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
	CONSTRAINT [PK_STK_STOCKDATA_HIS] PRIMARY KEY  
	(
		[TENANT_ID],
		[STOCK_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_STK_STOCKDATA_HIS_TENANT_ID ON STK_STOCKDATA_HIS(TENANT_ID);
CREATE INDEX IX_STK_STOCKDATA_HIS_GODS_ID ON STK_STOCKDATA_HIS(TENANT_ID,GODS_ID);

--��������ͼ<���˻�>
CREATE VIEW VIW_STOCKDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER_ B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--��������ʷ��ͼ<���˻�>
CREATE VIEW VIW_STOCKDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--�������յ���ͼ
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

--�������յ���ͼ
CREATE VIEW VIW_MOVEINDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���۵�','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���۵�','SALES_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���۷�ʽ','CODE_TYPE','00',strftime('%s','now','localtime')-1293840000);

--���۵���ͷ
CREATE TABLE [SAL_SALESORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[SALES_DATE] int NOT NULL ,
        --��������
	[SALES_TYPE] [int] NOT NULL,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --��������
	[FROM_ID] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --���۽��
	[SALE_MNY] [decimal](18, 3) NULL ,
        --Ĩ����
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --ʵ���ֽ�
	[RECV_MNY] [decimal](18, 3) NULL ,
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

--���۵���ͷ
CREATE TABLE [SAL_SALESORDER_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[SALES_DATE] int NOT NULL ,
        --��������
	[SALES_TYPE] [int] NOT NULL,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --��������
	[FROM_ID] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --���۽��
	[SALE_MNY] [decimal](18, 3) NULL ,
        --Ĩ����
	[PAY_DIBS] [decimal](18, 3) NULL ,
        --ʵ���ֽ�
	[RECV_MNY] [decimal](18, 3) NULL ,
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
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_SALESORDER_HIS_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ͳһ����','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�ŵ궨��','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��Ʒ����','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','�������','POLICY_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���ʽ','CODE_TYPE','00',strftime('%s','now','localtime')-1293840000);

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','�ֽ�','XJ','1','1','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','����','YL','1','2','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','��ֵ��','CZK','1','3','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','����','JZ','1','4','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','��ȯ','LQ','1','5','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','֧Ʊ','ZP','1','6','00',strftime('%s','now','localtime')-1293840000);


--���۵���ϸ
CREATE TABLE [SAL_SALESDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --��׼�ۼ�
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
        --������
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --�ɱ�����
	[COST_PRICE] [decimal](18, 6) NULL ,
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

--���۵���ϸ
CREATE TABLE [SAL_SALESDATA_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����<����ʱ�� # ��>
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --��׼�ۼ�
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
        --������
	[CALC_MONEY] [decimal](18, 3) NULL ,  
        --�ɱ�����
	[COST_PRICE] [decimal](18, 6) NULL ,
        --�Ƿ��л���
	[HAS_INTEGRAL] [int] NOT NULL ,
        --˵��
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

--������ͼ<���˻�>
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

--������ͼ<���˻�>
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

--������������ͼ
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

--������������ͼ
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

--��ˮ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ֵ','IC_GLIDE_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IC_GLIDE_TYPE','00',strftime('%s','now','localtime')-1293840000);

--��ֵ����ˮ��¼
CREATE TABLE [SAL_IC_GLIDE] (
        --��ˮID��
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NOT NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --��ˮ����
	[CREA_DATE] int NOT NULL ,
        --ժҪ
	[GLIDE_INFO] [varchar] (100) NOT NULL ,
        --��ˮ����
	[IC_GLIDE_TYPE] [varchar] (1) NOT NULL ,
        --���
	[GLIDE_MNY] [decimal](18, 3) NULL ,
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
CREATE INDEX IX_SAL_IC_GLIDE_KEYFIELD ON SAL_IC_GLIDE(TENANT_ID,SHOP_ID,SALES_ID);
CREATE INDEX IX_SAL_IC_GLIDE_CREA_DATE ON SAL_IC_GLIDE(CREA_DATE);
CREATE INDEX IX_SAL_IC_GLIDE_IC_CARDNO ON SAL_IC_GLIDE(IC_CARDNO);

--�Ի���ʽ
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ȯ','INTEGRAL_FLAG','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��Ʒ','INTEGRAL_FLAG','00',strftime('%s','now','localtime')-1293840000);

--���ֶԻ�
CREATE TABLE [SAL_INTEGRAL_GLIDE] (
        --��ˮID��
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --��Ա��
	[CUST_ID] [varchar] (36) NOT NULL ,
        --��ˮ����
	[CREA_DATE] int NOT NULL ,
        --�Ի���ʽ
	[INTEGRAL_FLAG] [varchar] (1) NOT NULL ,
        --ժҪ
	[GLIDE_INFO] [varchar] (255) NOT NULL ,
        --ʹ�û���
	[INTEGRAL] [decimal](18, 3) NULL ,
        --�Ի�ֵ<��ȯ����������Ʒ����>
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
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CUST_ID ON SAL_INTEGRAL_GLIDE(CUST_ID);


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
		[TENANT_ID,CHANGE_CODE]
	) 
) ;

insert into BAS_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','����','1','00',strftime('%s','now','localtime')-1293840000);
insert into BAS_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','����','2','00',strftime('%s','now','localtime')-1293840000);

--������
CREATE TABLE [STO_CHANGEORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[CHANGE_DATE] int NOT NULL ,
        --��������
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --���ʹ���
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --������
	[DUTY_USER] [varchar] (36) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����û�
	[CHK_USER] [varchar] (36) NULL ,
        --�����Ա
	[CHK_DATE] [varchar] (10) NULL ,
        --��Դ����,���̵㵥ʱ��Ӧ�̵���ID��
	[FROM_ID] [varchar] (36) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
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

--������
CREATE TABLE [STO_CHANGEORDER_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��������
	[CHANGE_DATE] int NOT NULL ,
        --��������
	[CHANGE_TYPE] [varchar] (1) NOT NULL ,
        --���ʹ���
	[CHANGE_CODE] [varchar] (10) NOT NULL ,
        --������
	[DUTY_USER] [varchar] (36) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --����û�
	[CHK_USER] [varchar] (36) NULL ,
        --�����Ա
	[CHK_DATE] [varchar] (10) NULL ,
        --��Դ����,���̵㵥ʱ��Ӧ�̵���ID��
	[FROM_ID] [varchar] (36) NULL ,
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STO_CHANGEORDER_HIS_COMM] DEFAULT ('00'),
        --ʱ��� 
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

--����������ϸ
CREATE TABLE [STO_CHANGEDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --�ɱ�����
	[COST_PRICE] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
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

--����������ϸ
CREATE TABLE [STO_CHANGEDATA_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[CHANGE_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --�Ƿ���Ʒ
	[IS_PRESENT] [int] NOT NULL,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NULL ,
        --����
	[AMOUNT] [decimal](18, 3) NULL ,
        --�ɱ�����
	[COST_PRICE] [decimal](18, 3) NULL ,
        --������λ����
	[CALC_AMOUNT] [decimal](18, 3) NULL ,
        --����˵��
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

--��������
CREATE TABLE [STK_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[INDE_ID] [varchar] (36) NOT NULL ,
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
	[GUIDE_USER] [varchar] (30) NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_INDENTORDER_COMM] DEFAULT ('00'),
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
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

--��������
CREATE TABLE [STK_INDENTORDER_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[INDE_ID] [varchar] (36) NOT NULL ,
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
	[GUIDE_USER] [varchar] (30) NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --��Ʊ����
	[INVOICE_FLAG] [varchar] (1) NULL ,
        --����˰��
	[TAX_RATE] [decimal](18, 3) NULL ,
        --��ע
	[REMARK] [varchar] (100) NULL ,
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_STK_INDENTORDER_HIS_COMM] DEFAULT ('00'),
        --����ʱ��
	[CREA_DATE] [varchar] (30) NULL ,
        --������Ա
	[CREA_USER] [varchar] (36) NULL ,
        --ʱ��� ��ǰϵͳ����*86400000
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

--����������ϸ
CREATE TABLE [STK_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [varchar] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
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

--����������ϸ
CREATE TABLE [STK_INDENTDATA_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [varchar] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
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
	CONSTRAINT [PK_STK_INDENTDATA_HIS] PRIMARY KEY  
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	)
);

CREATE INDEX IX_STK_INDENTDATA_HIS_TENANT_ID ON STK_INDENTDATA_HIS(TENANT_ID);
CREATE INDEX IX_STK_INDENTDATA_HIS_GODS_ID ON STK_INDENTDATA_HIS(TENANT_ID,GODS_ID);

--����������ͼ
CREATE VIEW VIW_STKINDENTDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--����������ͼ
CREATE VIEW VIW_STKINDENTDATA_HIS
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA_HIS A,STK_STOCKORDER_HIS B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--���۶���
CREATE TABLE [SAL_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[INDE_ID] [varchar] (36) NOT NULL ,
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
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
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

--���۶���
CREATE TABLE [SAL_INDENTORDER_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --����
	[INDE_ID] [varchar] (36) NOT NULL ,
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
        --Ԥ����
	[ADVA_MNY] [decimal](18, 3) NULL ,
        --�������
	[INDE_MNY] [decimal](18, 3) NULL ,
        --�������
	[CHK_DATE] [varchar] (10) NULL ,
        --�����Ա
	[CHK_USER] [varchar] (36) NULL ,
        --�������
	[FIG_ID] [varchar] (36) NULL ,
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
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SAL_INDENTORDER_HIS_COMM] DEFAULT ('00'),
        --ʱ��� ��ǰϵͳ����*86400000
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

--���۶�����ϸ
CREATE TABLE [SAL_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [varchar] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
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

--���۶�����ϸ
CREATE TABLE [SAL_INDENTDATA_HIS] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] int NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --������
	[INDE_ID] [varchar] (36) NOT NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --����
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --����
	[BATCH_NO] [varchar] (36) NOT NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
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
	CONSTRAINT [PK_SAL_INDENTDATA_HIS] PRIMARY KEY 
	(
		[TENANT_ID],
		[INDE_ID],
		[SEQNO]
	) 
);

CREATE INDEX IX_SAL_INDENTDATA_HIS_TENANT_ID ON SAL_INDENTDATA_HIS(TENANT_ID);
CREATE INDEX IX_SAL_INDENTDATA_HIS_GODS_ID ON SAL_INDENTDATA_HIS(TENANT_ID,GODS_ID);

--���۶�����ͼ
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

--���۶�����ͼ
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

