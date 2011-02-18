--��Ʒ�۸�
CREATE TABLE [PUB_GOODSPRICE] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	[PRICE_ID] [varchar] (36) NOT NULL , 
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
select A.[TENANT_ID],A.[RELATION_ID],C.SHOP_ID,
       ifnull(B.[PRICE_ID],'#') as PRICE_ID,A.[GODS_ID],A.[GODS_CODE],A.[GODS_ID] as SECOND_ID,A.[GODS_NAME],A.[GODS_SPELL],A.[GODS_TYPE],
       A.[SORT_ID1],A.[SORT_ID2],A.[SORT_ID3],A.[SORT_ID4],A.[SORT_ID5],A.[SORT_ID6],A.[SORT_ID7],A.[SORT_ID8],
       A.[BARCODE],A.[CALC_UNITS],A.[SMALL_UNITS],A.[BIG_UNITS],A.[SMALLTO_CALC],A.[BIGTO_CALC],A.[NEW_INPRICE],A.[NEW_OUTPRICE] as RTL_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when ifnull(B.COMM,'02') not in ('02','12') then B.[NEW_OUTPRICE] else A.[NEW_OUTPRICE] end NEW_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE1],B.[NEW_OUTPRICE]*A.SMALLTO_CALC) else A.[NEW_OUTPRICE]*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE2],B.[NEW_OUTPRICE]*A.BIGTO_CALC) else A.[NEW_OUTPRICE]*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.[NEW_LOWPRICE],A.[USING_BARTER],A.[BARTER_INTEGRAL],
       A.[USING_PRICE],A.[HAS_INTEGRAL],A.[USING_BATCH_NO],A.[REMARK],A.[COMM],A.[TIME_STAMP]
from VIW_GOODSINFO A inner join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID
left join PUB_GOODSPRICE B ON C.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.PRICE_ID=B.PRICE_ID;

--��Ʒ��չ��
CREATE TABLE [PUB_GOODSINFOEXT] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --���ű���
	[GODS_ID] [varchar] (36) NOT NULL ,
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
        --ͨѶ��־
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_PUB_GOODSINFOEXT_COMM] DEFAULT ('00'),
        --����ʱ�� ��2011-01-01��ʼ������
  [TIME_STAMP] bigint NOT NULL,
  CONSTRAINT [PK_PUB_GOODSINFOEXT] PRIMARY KEY (TENANT_ID,GODS_ID)
);
CREATE INDEX IX_PUB_GOODSINFOEXT_TENANT_ID ON PUB_GOODSINFOEXT(TENANT_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_GODS_ID ON PUB_GOODSINFOEXT(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_TIME_STAMP ON PUB_GOODSINFOEXT(TENANT_ID,TIME_STAMP);

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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������','RATE_OFF','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ٴ���','RATE_OFF','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ָ����','RATE_OFF','00',strftime('%s','now','localtime')-1293840000);

--��������ͷ<���ݶ��Ա�ͷCOMM,TIME_STAMPͨѶ��־Ϊ׼>
CREATE TABLE [SAL_PRICEORDER] (
        --��¼ID��
	[PROM_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --��ʼʱ�� yyyy-mm-dd hh:mm:ss
	[BEGIN_DATE] [varchar] (25) NOT NULL ,
        --����ʱ�� yyyy-mm-dd hh:mm:ss
	[END_DATE] [varchar] (25) NOT NULL ,
        --��Ա�ȼ�#��ʱ�����пͻ�
	[PRICE_ID] [varchar] (36) NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROM_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROM_ID=B.PROM_ID and A.TENANT_ID=C.TENANT_ID and A.PROM_ID=C.PROM_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�һ�','IS_PRESENT','00',strftime('%s','now','localtime')-1293840000);

--��ⵥ��ϸ
CREATE TABLE [STK_STOCKDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36) NULL ,
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

--��������ͼ<���˻�>
CREATE VIEW VIW_STOCKDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,A.IS_PRESENT,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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

CREATE VIEW VIW_PAYMENT
as
select B.TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,A.COMM,A.TIME_STAMP from PUB_CODE_INFO A,CA_TENANT B where A.TENANT_ID=0 and A.CODE_TYPE='1'
union all
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,COMM,TIME_STAMP from PUB_CODE_INFO where TENANT_ID>0 and CODE_TYPE='1';

--���۵���ϸ
CREATE TABLE [SAL_SALESDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NULL ,
        --��λ
	[UNIT_ID] [varchar] (36) NOT NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36) NULL ,
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

--������ͼ<���˻�>
CREATE VIEW VIW_SALESDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--������������ͼ
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BATCH_NO,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.IS_PRESENT,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
		[TENANT_ID],[CHANGE_CODE]
	) 
);

insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','����','2','00',strftime('%s','now','localtime')-1293840000);
insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','����','2','00',strftime('%s','now','localtime')-1293840000);

--������
CREATE TABLE [STO_CHANGEORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
        --��������
	[DEPT_ID] int NULL ,
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

--����������ϸ
CREATE TABLE [STO_CHANGEDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36)  NULL ,
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

CREATE VIEW VIW_CHANGEDATA
as
select
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,A.APRICE,A.COST_PRICE,B.DEPT_ID,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.AMOUNT as AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_MONEY as CALC_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_MONEY else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_MONEY else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_MONEY else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_MONEY else 0 end as PARM5_MONEY
from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.COMM not in ('02','12');

--��������
CREATE TABLE [STK_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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

--����������ϸ
CREATE TABLE [STK_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36)  NULL ,
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

--���۶���
CREATE TABLE [SAL_INDENTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
        --��������
	[INDE_AMT] [decimal](18, 3) NULL ,
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

--���۶�����ϸ
CREATE TABLE [SAL_INDENTDATA] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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

--�̵�״̬ 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���̵�','CHECK_STATUS','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���̵�','CHECK_STATUS','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�����','CHECK_STATUS','00',strftime('%s','now','localtime')-1293840000);

--�̵㷽ʽ 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���̵�','CHECK_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�����̵�','CHECK_TYPE','00',strftime('%s','now','localtime')-1293840000);

--�̵���ͷ
CREATE TABLE [STO_PRINTORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
CREATE INDEX IX_STO_PRINTORDER_PRINT_DATE ON STO_PRINTORDER(SHOP_ID,PRINT_DATE);

--�̵����ϸ
CREATE TABLE [STO_PRINTDATA] (
        --�к�
	[ROWS_ID] varchar(36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�̵����� 
	[PRINT_DATE] int NOT NULL ,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (36) NOT NULL,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36) NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
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
CREATE INDEX IX_STO_PRINTDATA_PRINT_DATE ON STO_PRINTDATA(SHOP_ID,PRINT_DATE);

--�̵�¼���
CREATE TABLE [STO_CHECKDATA] (
        --�к�
	[ROWS_ID] varchar(36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�̵����� 
	[PRINT_DATE] int NOT NULL ,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (36) NOT NULL,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��и��ٺ�
	[BOM_ID] [varchar] (36) NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
        --���� ���ֵ��� #��
	[PROPERTY_01] [varchar] (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	[PROPERTY_02] [varchar] (36) NOT NULL ,
        --������
	[AMOUNT] [decimal](18, 3) NULL ,
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
CREATE INDEX IX_STO_CHECKDATA_PRINT_DATE ON STO_CHECKDATA(SHOP_ID,PRINT_DATE);

--�ʻ�����
CREATE TABLE [ACC_ACCOUNT_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --�����ŵ�<Ϊÿ���ŵ��Զ�����һ��<�ֽ��˻�>
	[SHOP_ID] [varchar] (11) NOT NULL ,
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

CREATE VIEW VIW_ACCOUNT_INFO
as
select TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM,TIME_STAMP from ACC_ACCOUNT_INFO;

--������֧��Ŀ���
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��֧��Ŀ','CODE_TYPE','00',strftime('%s','now','localtime')-1293840000);

CREATE VIEW VIW_ITEM_INFO
as
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE=3;


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','Ӧ�տ�','RECV_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','Ӧ�˿�','RECV_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','Ԥ����','RECV_TYPE','00',strftime('%s','now','localtime')-1293840000);

--Ӧ���ʿ�
CREATE TABLE [ACC_RECVABLE_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --���
	[ABLE_ID] [varchar] (36) NOT NULL ,
        --�ͻ�
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --ժҪ
	[ACCT_INFO] [varchar] (255) NOT NULL ,
        --����
	[RECV_TYPE] [varchar] (1) NOT NULL ,
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


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','Ӧ����','ABLE_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','Ӧ�˿�','ABLE_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','Ԥ����','ABLE_TYPE','00',strftime('%s','now','localtime')-1293840000);

--Ӧ���ʿ�
CREATE TABLE [ACC_PAYABLE_INFO] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --���
	[ABLE_ID] [varchar] (36) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[PAY_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[PAY_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --�ʿ�ID��
	[ABLE_ID] [varchar] (36) NOT NULL ,
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

CREATE VIEW VIW_PAYDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.PAY_ID,A.ABLE_ID,A.ABLE_TYPE,A.PAY_MNY,B.PAY_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.PAY_USER
from ACC_PAYDATA A,ACC_PAYORDER B where A.TENANT_ID=B.TENANT_ID and A.PAY_ID=B.PAY_ID and B.COMM not in ('02','12');

--�տ
CREATE TABLE [ACC_RECVORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[RECV_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --��Ӧ��
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --�ʻ�����
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[RECV_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --�ʿ�ID��
	[ABLE_ID] [varchar] (36) NOT NULL ,
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

CREATE VIEW VIW_RECVDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.ABLE_ID,A.RECV_TYPE,A.RECV_MNY,B.RECV_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.RECV_USER
from ACC_RECVDATA A,ACC_RECVORDER B where A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IORO_TYPE','00',strftime('%s','now','localtime')-1293840000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IORO_TYPE','00',strftime('%s','now','localtime')-1293840000);

--����֧��
CREATE TABLE [ACC_IOROORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[IORO_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --�ͻ�����
	[CLIENT_ID] [varchar] (36) NULL ,
        --��֧��Ŀ
	[ITEM_ID] [varchar] (36) NOT NULL ,
        --��֧����
	[DEPT_ID] int NULL ,
        --��֧����
	[IORO_TYPE] [varchar] (1) NOT NULL ,
        --��֧����
	[IORO_DATE] int NOT NULL ,
        --������
	[IORO_USER] [varchar] (36) NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[IORO_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] [int] NOT NULL ,
        --��֧�˻�
	[ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --ժҪ
	[IORO_INFO] [varchar] (255) NOT NULL ,
        --��֧���
	[IORO_MNY] [decimal](18, 3) NULL ,
	CONSTRAINT [PK_ACC_IORODATA] PRIMARY KEY  
	(
		[TENANT_ID],[SEQNO]
	) 
) ;
CREATE INDEX IX_ACC_IORODATA_TENANT_ID ON ACC_IORODATA(TENANT_ID);
CREATE INDEX IX_ACC_IORODATA_CLIENT_ID ON ACC_IORODATA(TENANT_ID,IORO_ID);

--����֧����ͼ
CREATE VIEW VIW_IORODATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.IORO_ID,A.ACCOUNT_ID,A.IORO_INFO,A.IORO_MNY,B.IORO_DATE,B.CLIENT_ID,B.ITEM_ID,B.DEPT_ID,B.GLIDE_NO,B.IORO_USER,
  case when B.IORO_TYPE='1' then A.IORO_MNY else 0 end as IN_MONEY,
  case when B.IORO_TYPE='2' then A.IORO_MNY else 0 end as OUT_MONEY
from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and B.COMM not in ('02','12');



--������˱�
CREATE TABLE [ACC_CLOSE_FORDAY] (
        --�к�
	[ROWS_ID] [varchar] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --��������
	[CLSE_DATE] int NULL ,
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
CREATE INDEX IX_ACC_CLOSE_FORDAY_KEYFIELD ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

--��ȡ�
CREATE TABLE [ACC_TRANSORDER] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[TRANS_ID] [varchar] (36) NOT NULL ,
        --��ˮ��
	[GLIDE_NO] [varchar] (20) NOT NULL ,
        --ת���˺�
	[IN_ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --ת���˺�
	[OUT_ACCOUNT_ID] [varchar] (36) NOT NULL ,
        --����
	[TRANS_DATE] int NOT NULL ,
        --������
	[TRANS_USER] [varchar] (36) NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�������
	[BOM_ID] [varchar] (36) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --����
	[BOM_ID] [varchar] (36) NOT NULL ,
        --���
	[SEQNO] int NOT NULL,
        --���ţ�û������ #��
	[BATCH_NO] [varchar] (36) NOT NULL,
        --�������ٺ�
	[LOCUS_NO] [varchar] (36) NULL ,
        --��Ʒ����
	[GODS_ID] [varchar] (36) NOT NULL ,
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

