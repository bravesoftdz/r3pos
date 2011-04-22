--收款单类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','收款单','RECV_FLAG','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','缴款单','RECV_FLAG','00',5497000);
--单据类型
alter table ACC_RECVORDER add RECV_FLAG varchar(1);
--更新以前的数据
update ACC_RECVORDER set RECV_FLAG='0' where CLIENT_ID<>TENANT_ID;
update ACC_RECVORDER set RECV_FLAG='1' where CLIENT_ID=TENANT_ID;
