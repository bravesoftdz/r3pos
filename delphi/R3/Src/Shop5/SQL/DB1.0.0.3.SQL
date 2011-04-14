--等级类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','企业会员','PRICE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','商盟会员','PRICE_TYPE','00',5497000);

alter table PUB_PRICEGRADE add PRICE_TYPE add char(1);

--加添接口内码
alter table STK_STOCKORDER add COMM_ID varchar(50);

alter table STK_INDENTORDER add COMM_ID varchar(50);

alter table SAL_INDENTORDER add COMM_ID varchar(50);

alter table SAL_SALESORDER add COMM_ID varchar(50);

alter table STO_CHANGEORDER add COMM_ID varchar(50);

alter table MSC_MESSAGE add COMM_ID varchar(50);

alter table MSC_QUESTION add COMM_ID varchar(50);

alter table MSC_QUESTION_ITEM add COMM_ID varchar(50);

alter table MSC_IMPEACH add COMM_ID varchar(50);

