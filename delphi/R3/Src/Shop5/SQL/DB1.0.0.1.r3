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

--ÿ���ŵ궼�м�¼����������ŵ�
--����Ʒ�۸�
CREATE view [VIW_GOODSPRICE]
as
select A.[TENANT_ID],A.[RELATION_ID],C.SHOP_ID,
       ifnull(B.[PRICE_ID],'#') as PRICE_ID,A.[GODS_ID],A.[GODS_CODE],A.[GODS_ID] as SECOND_ID,A.[GODS_NAME],A.[GODS_SPELL],A.[GODS_TYPE],
       A.[SORT_ID1],A.[SORT_ID2],A.[SORT_ID3],A.[SORT_ID4],A.[SORT_ID5],A.[SORT_ID6],A.[SORT_ID7],A.[SORT_ID8],
       A.[BARCODE],A.[UNIT_ID],A.[CALC_UNITS],A.[SMALL_UNITS],A.[BIG_UNITS],A.[SMALLTO_CALC],A.[BIGTO_CALC],A.[NEW_INPRICE],A.[NEW_OUTPRICE] as RTL_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when ifnull(B.COMM,'02') not in ('02','12') then B.[NEW_OUTPRICE] else A.[NEW_OUTPRICE] end NEW_OUTPRICE,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE1],B.[NEW_OUTPRICE]*A.SMALLTO_CALC) else A.[NEW_OUTPRICE]*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when ifnull(B.COMM,'02') not in ('02','12') then ifnull(B.[NEW_OUTPRICE2],B.[NEW_OUTPRICE]*A.BIGTO_CALC) else A.[NEW_OUTPRICE]*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.[NEW_LOWPRICE],A.[USING_BARTER],A.[BARTER_INTEGRAL],
       A.[USING_PRICE],A.[HAS_INTEGRAL],A.[USING_BATCH_NO],A.[USING_LOCUS_NO],A.[REMARK],A.[COMM],A.[TIME_STAMP]
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

--ÿ���ŵ궼�м�¼����������ŵ�
CREATE view [VIW_GOODSPRICEEXT]
as
    SELECT 
      j1.TENANT_ID as TENANT_ID,j1.SHOP_ID, 
      j1.GODS_ID as GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE else J2.NEW_INPRICE end as NEW_INPRICE,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.SMALLTO_CALC else J2.NEW_INPRICE1 end as NEW_INPRICE1,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.BIGTO_CALC else J2.NEW_INPRICE2 end as NEW_INPRICE2,
       NEW_OUTPRICE,
       NEW_OUTPRICE1,
       NEW_OUTPRICE2,
       NEW_LOWPRICE,
       SORT_ID1,SORT_ID7,SORT_ID8,USING_BARTER,BARTER_INTEGRAL,RELATION_ID
    FROM 
      VIW_GOODSPRICE j1 LEFT JOIN 
      PUB_GOODSINFOEXT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.GODS_ID = j2.GODS_ID; 
            
--ÿ���ŵ궼�м�¼����������ŵ�
CREATE view [VIW_GOODSPRICE_SORTEXT]
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSPRICEEXT j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
      
--��Ʒ������ͼ�����ŵ�
CREATE view [VIW_GOODSINFO_SORTEXT]
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSINFO j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
          
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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ٴ���','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ָ����','RATE_OFF','00',5497000);

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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�һ�','IS_PRESENT','00',5497000);

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
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG=3 then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--�������յ���ͼ
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,
   A.CALC_AMOUNT,A.CALC_MONEY as COST_MONEY,A.ORG_PRICE*A.AMOUNT as RTL_MONEY,A.AMOUNT
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

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
        --IC����
	[IC_CARDNO] [varchar] (36) NULL ,
        --���˱���
	[UNION_ID] [varchar] (36) NULL ,
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ͳһ����','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�ŵ궨��','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��Ʒ����','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','�������','POLICY_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���ʽ','CODE_TYPE','00',5497000);

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','�ֽ�','XJ','1','1','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','����','YL','1','2','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','��ֵ��','CZK','1','3','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','����','JZ','1','4','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','��ȯ','LQ','1','5','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','֧Ʊ','ZP','1','6','00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('G','С��֧��','XEZF','1','7','00',5497000);

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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.CREA_DATE,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT,A.TAX_RATE,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2)-round(B.CALC_AMOUNT*B.COST_PRICE,2) as PRF_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--������������ͼ
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as RTL_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.COST_PRICE,B.AMOUNT
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--��ˮ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ֵ','IC_GLIDE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IC_GLIDE_TYPE','00',5497000);

--��ֵ����ˮ��¼
CREATE TABLE [SAL_IC_GLIDE] (
        --��ˮID��
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�ͻ�ID<���������� #>
	[CLIENT_ID] [varchar] (36) NOT NULL ,
        --IC����
	[IC_CARDNO] [varchar] (36) NOT NULL ,
        --���۵���
	[SALES_ID] [varchar] (36) NULL ,
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
	[GLIDE_ID] [varchar] (36) NOT NULL ,
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�ŵ����
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,B.CREA_DATE,A.APRICE,A.COST_PRICE,B.DEPT_ID,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.AMOUNT as AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*A.CALC_MONEY as RTL_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as COST_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM1_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM2_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM3_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM4_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM5_RTL,
  case when B.CHANGE_TYPE=1 then 1 else -1 end*case when B.CHANGE_CODE='5' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM5_MONEY
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
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,
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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,A.GUIDE_USER,B.POLICY_TYPE,A.INDE_DATE,A.INDE_ID,B.BARTER_INTEGRAL,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.HAS_INTEGRAL,A.SALES_STYLE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.AGIO_RATE,B.ORG_PRICE,B.AMOUNT,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (2,3) then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY
from SAL_INDENTORDER A,SAL_INDENTDATA B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and A.COMM not in ('02','12');

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
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��֧��Ŀ','CODE_TYPE','00',5497000);

CREATE VIEW VIW_ITEM_INFO
as
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE=3;


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','Ӧ�տ�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','Ӧ�˿�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','Ԥ����','RECV_TYPE','00',5497000);

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


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','Ӧ����','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','Ӧ�˿�','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','Ԥ����','ABLE_TYPE','00',5497000);

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
  A.TENANT_ID,A.SHOP_ID,A.PAY_ID,A.ABLE_ID,A.ABLE_TYPE,A.PAY_MNY,B.PAY_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.PAY_USER,B.CHK_DATE,B.CHK_USER
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
  A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.ABLE_ID,A.RECV_TYPE,A.RECV_MNY,B.RECV_DATE,B.CLIENT_ID,B.PAYM_ID,B.ITEM_ID,B.ACCOUNT_ID,B.GLIDE_NO,B.RECV_USER,B.CHK_DATE,B.CHK_USER
from ACC_RECVDATA A,ACC_RECVORDER B where A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','IORO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IORO_TYPE','00',5497000);

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
	[DEPT_ID] [varchar] (10) NULL ,
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
		[TENANT_ID],[IORO_ID],[SEQNO]
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
	      --��ȡ���
	[TRANS_MNY] [decimal](18, 3) NULL ,
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

--��Ʊ����
CREATE TABLE [SAL_INVOICE_BOOK] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --��ˮID��
	[INVH_ID] [varchar] (36) NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[INVH_ID] [varchar] (36) NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[SALES_ID] [varchar] (36) NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [varchar] (36)  NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --����
	[CREA_DATE] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [varchar] (36)  NOT NULL ,
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
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�·�
	[MONTH] int NOT NULL ,
        --�ͻ�����
	[GODS_ID] [varchar] (36)  NOT NULL ,
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
CREATE TABLE [RCK_ACCT_MONTH] (
        --��ҵ����
	[TENANT_ID] int NOT NULL ,
        --�����ŵ�
	[SHOP_ID] [varchar] (11) NOT NULL ,
        --�·�
	[MONTH] int NOT NULL ,
        --�˻�����
	[ACCOUNT_ID] [varchar] (36)  NOT NULL ,

--�ڳ���̨��		
        --�ڳ����
	[ORG_MNY] [decimal](18, 3) NULL ,
 
--������̨��		
        --������
	[IN_MNY] [decimal](18, 3) NULL ,

--֧����̨��		
        --֧�����
	[OUT_MNY] [decimal](18, 3) NULL ,
	
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

create view VIW_GOODS_DAYS
as
select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO,
   case when STOCK_TYPE=3 then CALC_AMOUNT else 0 end as STKRT_AMT,
   case when STOCK_TYPE=3 then NOTAX_MONEY else 0 end as STKRT_MNY,
   case when STOCK_TYPE=3 then TAX_MONEY else 0 end as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_STOCKDATA
union all
select TENANT_ID,SHOP_ID,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,CALC_MONEY+AGIO_MONEY as SALE_RTL,AGIO_MONEY as SALE_AGO,
   COST_MONEY as SALE_CST,
   PRF_MONEY as SALE_PRF,
   case when SALES_TYPE=3 then CALC_AMOUNT else 0 end as SALRT_AMT,
   case when SALES_TYPE=3 then NOTAX_MONEY else 0 end as SALRT_MNY,
   case when SALES_TYPE=3 then TAX_MONEY else 0 end as SALRT_TAX,
   case when SALES_TYPE=3 then COST_MONEY else 0 end as SALRT_CST,
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_SALESDATA
union all
select TENANT_ID,SHOP_ID,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   CALC_AMOUNT as DBIN_AMT,RTL_MONEY as DBIN_RTL,COST_MONEY as DBIN_CST,
   0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_MOVEINDATA
union all
select TENANT_ID,SHOP_ID,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,   
   CALC_AMOUNT as DBOUT_AMT,RTL_MONEY as DBIN_RTL,
   COST_MONEY as DBOUT_CST,
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_MOVEOUTDATA
union all
select TENANT_ID,SHOP_ID,CHANGE_DATE as CREA_DATE,GODS_ID,BATCH_NO, 
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,0 as DBOUT_AMT,0 as DBOUT_RTL,0 as DBOUT_CST,   
PARM1_AMOUNT as CHANGE1_AMT,
PARM1_RTL as CHANGE1_RTL,
PARM1_MONEY as CHANGE1_CST,
PARM2_AMOUNT as CHANGE2_AMT,
PARM2_RTL as CHANGE2_RTL,
PARM2_MONEY as CHANGE2_CST,
PARM3_AMOUNT as CHANGE3_AMT,
PARM3_RTL as CHANGE3_RTL,
PARM3_MONEY as CHANGE3_CST,
PARM4_AMOUNT as CHANGE4_AMT,
PARM4_RTL as CHANGE4_RTL,
PARM4_MONEY as CHANGE4_CST,
PARM5_AMOUNT as CHANGE5_AMT,
PARM5_RTL as CHANGE5_RTL,
PARM5_MONEY as CHANGE5_CST
from VIW_CHANGEDATA;

create view VIW_RECVALLDATA
as 
select TENANT_ID,SHOP_ID,CLSE_DATE as RECV_DATE,CREA_USER,CHK_DATE,
isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0) as RECV_MNY,
PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from ACC_CLOSE_FORDAY
union all
select TENANT_ID,SHOP_ID,CREA_DATE as RECV_DATE,CREA_USER,CHK_DATE,
isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0) as RECV_MNY,
PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from SAL_IC_GLIDE where IC_GLIDE_TYPE='1'
union all
select TENANT_ID,SHOP_ID,RECV_DATE,RECV_USER as CREA_USER,CHK_DATE,
RECV_MNY,
case when PAYM_ID='A' then RECV_MNY else 0 end as PAY_A,
case when PAYM_ID='B' then RECV_MNY else 0 end as PAY_B,
case when PAYM_ID='C' then RECV_MNY else 0 end as PAY_C,
case when PAYM_ID='D' then RECV_MNY else 0 end as PAY_D,
case when PAYM_ID='E' then RECV_MNY else 0 end as PAY_E,
case when PAYM_ID='F' then RECV_MNY else 0 end as PAY_F,
case when PAYM_ID='G' then RECV_MNY else 0 end as PAY_G,
case when PAYM_ID='H' then RECV_MNY else 0 end as PAY_H,
case when PAYM_ID='I' then RECV_MNY else 0 end as PAY_I,
case when PAYM_ID='J' then RECV_MNY else 0 end as PAY_J
from VIW_RECVDATA;

create view VIW_ACCT_DAYS
as
select 1 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,PAY_DATE as CREA_DATE,0 as IN_MNY,PAY_MNY as OUT_MNY from VIW_PAYDATA
union all
select 2 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,RECV_DATE as CREA_DATE,RECV_MNY as IN_MNY,0 as OUT_MNY from VIW_RECVDATA
union all
select 3 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,IORO_DATE as CREA_DATE,IN_MONEY as IN_MNY,OUT_MONEY as OUT_MNY from VIW_IORODATA
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,IN_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,TRANS_MNY as IN_MNY,0 as OUT_MNY from ACC_TRANSORDER
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,OUT_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,0 as IN_MNY,TRANS_MNY as OUT_MNY from ACC_TRANSORDER
union all
select 5 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,CLSE_DATE as CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY from ACC_CLOSE_FORDAY A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A'
union all
select 6 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,A.CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY from SAL_IC_GLIDE A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A';
