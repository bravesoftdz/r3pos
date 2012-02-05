--������ܱ�
create view RIM_JOURNAL 
as
 select
   j.TENANT_ID,   --R3��ҵ��
   j.GODS_ID,     --R3��Ʒ����
   j.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
   C.LICENSE_CODE,--֤��֤��
   D.CUST_CODE,   --�ͻ����
   D.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
   sum(STOCK_AMT) as STOCK_AMT,--��������<������>
   sum(SALES_AMT) as SALES_AMT,--��������<������>
   sum(SALES_MNY) as SALES_MNY,--���۽��
   sum(STOR_AMT) as STOR_AMT --�������<������>
 from ( 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,0 as STOCK_AMT,sum(CALC_AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as SALES_AMT,sum(CALC_MONEY) as SALES_MNY,0 as STOR_AMT 
    from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.SALES_DATE=(year(current date-1 days)*10000+month(current date-1 days)*100+day(current date-1 days))
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID
    union all 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,sum(A.CALC_AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,0 as STOR_AMT 
    from VIW_STOCKDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.STOCK_DATE=(year(current date-1 days)*10000+month(current date-1 days)*100+day(current date-1 days))
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID
    union all 
    select A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,0 as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,sum(A.AMOUNT/case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as STOR_AMT 
    from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 
    group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID
    ) j,CA_SHOP_INFO c,RM_CUST d where j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID and c.LICENSE_CODE=d.LICENSE_CODE 
group by 
   j.TENANT_ID, 
   j.GODS_ID,   
   j.SECOND_ID,   
   C.LICENSE_CODE,D.CUST_CODE,D.CUST_ID;

--�����ܱ�
create view RIM_STORAGE_SUM 
as
select 
A.TENANT_ID,   --R3��ҵ��
A.GODS_ID,     --R3��Ʒ����
B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
C.LICENSE_CODE,--֤��֤��
D.CUST_CODE,   --�ͻ����
D.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
sum(A.AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as BAL_AMT --�������<������>
from STO_STORAGE A,VIW_GOODSINFO B,CA_SHOP_INFO C,RM_CUST D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=d.LICENSE_CODE  
group by 
A.TENANT_ID,
A.GODS_ID,
B.SECOND_ID, 
C.LICENSE_CODE,D.CUST_CODE,D.CUST_ID;

--���ۻ��ܱ�
create view RIM_SALES_SUM 
as
select 
A.TENANT_ID,   --R3��ҵ��
A.GODS_ID,     --R3��Ʒ����
B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
C.LICENSE_CODE,--֤��֤��
D.CUST_CODE,   --�ͻ����
D.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
A.SALES_DATE,  --ҵ������<���� 20110801>
sum(A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end) as SALE_AMT, --��������<������>
sum(A.CALC_MONEY) as SALE_MNY  --���۽��
from VIW_SALESDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,RM_CUST D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=d.LICENSE_CODE   
group by 
A.TENANT_ID,
A.GODS_ID,
B.SECOND_ID, 
C.LICENSE_CODE,D.CUST_CODE,D.CUST_ID,
A.SALES_DATE;

--������ˮ��
create view RIM_SALES_DATA
as
select 
A.TENANT_ID,   --R3��ҵ��
A.SALES_ID,    --R3���۵���<36λΨһ��>
A.GODS_ID,     --R3��Ʒ����
B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
A.SHOP_ID,     --R3�ŵ����
C.LICENSE_CODE,--֤��֤��
E.CUST_CODE,   --�ͻ����
E.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
D.SALES_DATE,  --ҵ������<���� 20110801 >
D.CREA_DATE,   --�Ƶ�����<�ַ��� 2011-08-02 12:23:33>
D.CLIENT_ID,   --������ID��<VIW_CUSTOMER>
D.SALES_TYPE,  --��������<1 �������� 3 �����˻� 4 �ŵ�����>
A.TREND_ID,    --������;<�������� 01.���� 02.������Ʒ 03.�������� 04.��ɥ��Ȣ 05.����>
A.CALC_MONEY,  --���۽��
A.UNIT_ID,     --���۵�λ<���л��ǰ���>
A.SEQNO,       --�к�
A.AMOUNT,      --��������
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --��������<������>
from SAL_SALESDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,SAL_SALESORDER D,RM_CUST E
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=E.LICENSE_CODE and
       A.TENANT_ID=D.TENANT_ID and A.SALES_ID=D.SALES_ID and 
       D.SALES_TYPE in (1,3,4) and D.COMM not in ('02','12'); 

--������ˮ��
create view RIM_STOCK_DATA
as
select 
A.TENANT_ID,   --R3��ҵ��
A.STOCK_ID,    --R3��������<36λΨһ��>
A.GODS_ID,     --R3��Ʒ����
B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
A.SHOP_ID,     --R3�ŵ����
C.LICENSE_CODE,--֤��֤��
E.CUST_CODE,   --�ͻ����
E.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
D.STOCK_DATE,  --ҵ������<���� 20110801 >
D.CREA_DATE,   --�Ƶ�����<�ַ��� 2011-08-02 12:23:33>
D.CLIENT_ID,   --������ID��<VIW_CUSTOMER>
D.STOCK_TYPE,  --��������<1 ���� 3 �˻�>
A.CALC_MONEY,  --�������
A.UNIT_ID,     --������λ<���л��ǰ���>
A.SEQNO,       --�к�
A.AMOUNT,      --��������
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --��������<������>
from STK_STOCKDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,STK_STOCKORDER D,RM_CUST E
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=E.LICENSE_CODE and
       A.TENANT_ID=D.TENANT_ID and A.STOCK_ID=D.STOCK_ID and
       D.STOCK_TYPE in (1,3) and D.COMM not in ('02','12'); 

--����������ˮ
create view RIM_CHANGE_DATA
as
select 
A.TENANT_ID,   --R3��ҵ��
A.CHANGE_ID,    --R3����<36λΨһ��>
A.GODS_ID,     --R3��Ʒ����
B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
A.SHOP_ID,     --R3�ŵ����
C.LICENSE_CODE,--֤��֤��
E.CUST_CODE,   --�ͻ����
E.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
D.CHANGE_DATE,  --ҵ������<���� 20110801 >
D.CREA_DATE,   --�Ƶ�����<�ַ��� 2011-08-02 12:23:33>
D.CHANGE_CODE,  --��������<1 ���� 2 ����>
A.UNIT_ID,     --������λ<���л��ǰ���>
A.SEQNO,       --�к�
A.AMOUNT,      --��������
A.CALC_AMOUNT / case when B.SMALLTO_CALC<>0 then B.SMALLTO_CALC else 1 end as PACK_AMOUNT --��������<������>
from STO_CHANGEDATA A,VIW_GOODSINFO B,CA_SHOP_INFO C,STO_CHANGEORDER D,RM_CUST E
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=E.LICENSE_CODE and
       A.TENANT_ID=D.TENANT_ID and A.CHANGE_ID=D.CHANGE_ID; 

--����������<�½����������>
create view RIM_GOODS_MONTH
as
select 
	A.TENANT_ID , --R3��ҵ����
	A.SHOP_ID,    --R3�ŵ����
	A.MONTH,  --�·�<���� 201108>
	A.GODS_ID,    --R3��Ʒ����
  B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
  C.LICENSE_CODE,--֤��֤��
  D.CUST_CODE,   --�ͻ����
  D.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
--����ʱ��������Ϣ
	A.NEW_INPRICE,--��ʱ����
	A.NEW_OUTPRICE,--��ʱ����
--�ڳ���̨��		
	A.ORG_AMT,--�ڳ�����
	A.ORG_CST,--�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
--������̨��	
 	A.STOCK_AMT,--��������<���˻�>
	A.STOCK_MNY,--�������<ĩ˰>
	A.STOCK_TAX,--����˰��
--������̨��	
	A.SALE_AMT,--��������<���˻�>
	A.SALE_MNY,--���۽��<ĩ˰>
	A.SALE_TAX,--����˰��
	A.SALE_CST,--���۳ɱ�
	A.SALE_PRF,--����ë��
--������̨��	
  	A.DBIN_AMT,--��������
	A.DBIN_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.DBOUT_AMT,--��������
	A.DBOUT_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
--�����̨��	
 	A.CHANGE1_AMT,--��������
	A.CHANGE1_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.CHANGE2_AMT,--��������
	A.CHANGE2_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
 	A.CHANGE3_AMT,--��������
 	A.CHANGE3_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
 	A.CHANGE4_AMT,--��������
	A.CHANGE4_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.CHANGE5_AMT,--��������
	A.CHANGE5_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
--�����̨��		
	A.BAL_AMT,--�������
	A.BAL_CST --���ɱ�<�ƶ���Ȩ�ɱ�>
from RCK_GOODS_MONTH A,VIW_GOODSINFO B,CA_SHOP_INFO C,RM_CUST D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=D.LICENSE_CODE; 

--����������<�½����������>,δ�½�ʱ��������������,�ο��á�
create view RIM_GOODS_DAYS
as
select 
	A.TENANT_ID , --R3��ҵ����
	A.SHOP_ID,    --R3�ŵ����
	A.CREA_DATE,  --����<���� 20110802>
	A.GODS_ID,    --R3��Ʒ����
  B.SECOND_ID,   --ҵ��ϵͳ��Ʒ����<�̲ݹ�˾����>
  C.LICENSE_CODE,--֤��֤��
  D.CUST_CODE,   --�ͻ����
  D.CUST_ID,     --ҵ��ϵͳ�ͻ�����<�̲ݹ�˾����>
--����ʱ��������Ϣ
	A.NEW_INPRICE,--��ʱ����
	A.NEW_OUTPRICE,--��ʱ����
--�ڳ���̨��		
	A.ORG_AMT,--�ڳ�����
	A.ORG_CST,--�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
--������̨��	
 	A.STOCK_AMT,--��������<���˻�>
	A.STOCK_MNY,--�������<ĩ˰>
	A.STOCK_TAX,--����˰��
--������̨��	
	A.SALE_AMT,--��������<���˻�>
	A.SALE_MNY,--���۽��<ĩ˰>
	A.SALE_TAX,--����˰��
	A.SALE_CST,--���۳ɱ�
	A.COST_PRICE,--�ɱ�����<�ƶ���Ȩ�ɱ�>
	A.SALE_PRF,--����ë��
--������̨��	
  A.DBIN_AMT,--��������
	A.DBIN_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.DBOUT_AMT,--��������
	A.DBOUT_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
--�����̨��	
 	A.CHANGE1_AMT,--��������
	A.CHANGE1_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.CHANGE2_AMT,--��������
	A.CHANGE2_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
 	A.CHANGE3_AMT,--��������
 	A.CHANGE3_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
 	A.CHANGE4_AMT,--��������
	A.CHANGE4_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
	A.CHANGE5_AMT,--��������
	A.CHANGE5_CST,--�����ɱ�<�ƶ���Ȩ�ɱ�>
--�����̨��		
	A.BAL_AMT,--�������
	A.BAL_CST --���ɱ�<�ƶ���Ȩ�ɱ�>
from RCK_GOODS_DAYS A,VIW_GOODSINFO B,CA_SHOP_INFO C,RM_CUST D
where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and 
       A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and c.LICENSE_CODE=D.LICENSE_CODE; 
	