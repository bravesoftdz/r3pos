alter table MKT_KPI_MODIFY add KPI_DATE int;
alter table MKT_KPI_MODIFY add REMARK varchar(100);
alter table MKT_KPI_RESULT_LIST add ADJS_RATE decimal(18, 3);
alter table MKT_KPI_RESULT_LIST add REMARK varchar(100);

alter table SAL_VOUCHERORDER add PRINT_TIMES int;
alter table SAL_VOUCHERORDER add PRINT_USER varchar(36);

--1.4
--alter table SAL_VOUCHERDATA alter column BARCODE varchar(60) not null;
--alter table SAL_VHSENDDATA alter column BARCODE varchar(60) not null;
--alter table SAL_VHPAY_GLIDE alter column BARCODE varchar(60) not null;

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���ȯ','VOUCHER_TYPE','00',5497000);

--��������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('20','��������','CODE_TYPE','00',5497000);
--����ʽ
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('21','����ʽ','CODE_TYPE','00',5497000);
--��������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('22','��������','CODE_TYPE','00',5497000);

--�豸��װ��ά���ǼǱ�
CREATE TABLE SVC_SERVICE_INFO (
        --��ҵ����
	TENANT_ID int  NOT NULL,
        --��ˮID��(����)
	SRVR_ID char (36) NOT NULL ,
        --���۵���  
	SALES_ID char (36) NOT NULL ,
        --��Ʒ����  
	GODS_ID char (36),
        --��Ʒ����  
	GODS_NAME varchar (50),
        --��Ʒ���к�  
	SERIAL_NO varchar (50),
        --�ͻ�  
	CLIENT_ID char (36) NOT NULL ,
        --�û���
	CLIENT_CODE varchar (30),
        --��ϵ��
	LINKMAN varchar (30),
        --��ϵ�绰
	TELEPHONE varchar (30),
        --��ַ
	ADDRESS varchar (120),
        --��������  
	RECV_CLASS varchar (36) NOT NULL ,
        --��������  
	PROB_DESC varchar (200),
        --����ʱ��
	RECV_DATE int,
        --������Ա
	RECV_USER varchar (36),
        --����ʽ  
	SRVR_CLASS varchar (36) NOT NULL ,
        --ָ����Ա
	SRVR_USER varchar (36),
				--��������
	SRVR_DATE int,
        --��������  
	SRVR_DESC varchar (200),
        --�Ƿ��շ�  0 ���շ� 1�շ�
	FEE_FLAG char (1),
        --���ý��
	FEE_MNY decimal(18, 3),
        --��������
	SATI_DEGR varchar (36),
         --����ʱ��
	CREA_DATE varchar (30),
        --������Ա
	CREA_USER varchar (36),
      	--ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SVC_SRV_INFO PRIMARY KEY 
  ( 
		TENANT_ID,
		SRVR_ID
  )
) IN R3TB32K_BIZ INDEX IN R3IX32K_DEF;
CREATE INDEX IX_SSRV_TENANT_ID ON SVC_SERVICE_INFO(TENANT_ID);
CREATE INDEX IX_SSRV_SALES_ID ON SVC_SERVICE_INFO(TENANT_ID,SALES_ID);
CREATE INDEX IX_SSRV_RECV_DATE ON SVC_SERVICE_INFO(TENANT_ID,RECV_DATE);
CREATE INDEX IX_SSRV_SRVR_DATE ON SVC_SERVICE_INFO(TENANT_ID,SRVR_DATE);

--�����ϵ��
CREATE TABLE PUB_CODE_RELATION (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --��ɫ/�������
	CODE_ID varchar (36) NOT NULL ,
        --��������
	SORT_ID varchar (36) NOT NULL ,
        --�������� 
	SORT_TYPE int NOT NULL ,
        --�����
	SEQ_NO int,
      --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CODE_RTL PRIMARY KEY (TENANT_ID,CODE_ID,SORT_TYPE,SORT_ID)
) IN R3TB4K_BAS;
CREATE INDEX IX_CRTL_TENANT_ID ON PUB_CODE_RELATION(TENANT_ID);
CREATE INDEX IX_CRTL_TIME_STAMP ON PUB_CODE_RELATION(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_CRTL_SORT_ID ON PUB_CODE_RELATION(TENANT_ID,SORT_ID);