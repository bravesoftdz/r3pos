update ACC_RECVABLE_INFO set ACCT_MNY=RECV_MNY+RECK_MNY where RECV_TYPE='2';

--进货类台账<同期进货>	修复 DB1.0.1.4.SQLITE少的字段
        --进货数量<含退货>
alter table RCK_GOODS_MONTH add	YEAR_STOCK_AMT decimal(18, 3) ;
        --进货金额<末税>
alter table RCK_GOODS_MONTH add	YEAR_STOCK_MNY decimal(18, 3) ;
        --进项税额
alter table RCK_GOODS_MONTH add	YEAR_STOCK_TAX decimal(18, 3) ;

--进货类台账<上期进货>	
        --进货数量<含退货>
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_AMT decimal(18, 3) ;
        --进货金额<末税>
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_MNY decimal(18, 3) ;
        --进项税额
alter table RCK_GOODS_MONTH add	PRIOR_STOCK_TAX decimal(18, 3) ;

ALTER TABLE SAL_INDENTORDER ALTER column SALES_STYLE SET DATA TYPE VARCHAR(36);

ALTER TABLE SAL_SALESORDER ALTER column SALES_STYLE SET DATA TYPE VARCHAR(36);
