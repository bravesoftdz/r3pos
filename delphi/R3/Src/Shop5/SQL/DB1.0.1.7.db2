update ACC_RECVABLE_INFO set ACCT_MNY=RECV_MNY+RECK_MNY where RECV_TYPE='2';

--������̨��<ͬ�ڽ���>	�޸� DB1.0.1.4.SQLITE�ٵ��ֶ�
        --��������<���˻�>
alter table RCK_GOODS_MONTH add	YEAR_STOCK_AMT decimal(18, 3) ;
        --�������<ĩ˰>
alter table RCK_GOODS_MONTH add	YEAR_STOCK_MNY decimal(18, 3) ;
        --����˰��
alter table RCK_GOODS_MONTH add	YEAR_STOCK_TAX decimal(18, 3) ;

--������̨��<���ڽ���>	
        --��������<���˻�>
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_AMT decimal(18, 3) ;
        --�������<ĩ˰>
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_MNY decimal(18, 3) ;
        --����˰��
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_TAX decimal(18, 3) ;

ALTER TABLE SAL_INDENTORDER ALTER column SALES_STYLE SET DATA TYPE VARCHAR(36);

ALTER TABLE SAL_SALESORDER ALTER column SALES_STYLE SET DATA TYPE VARCHAR(36);
