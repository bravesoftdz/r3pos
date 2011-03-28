--2011-01-11 ��ɭ�����
--����ѡ��
CREATE TABLE PUB_PARAMS(
    --ѡ�����
	CODE_ID varchar(20) NOT NULL,
    --ѡ������
	CODE_NAME varchar(50) NOT NULL,
    --ƴ����
	CODE_SPELL varchar(50),
    --ѡ������
	TYPE_CODE varchar(50) NOT NULL,
	  --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_PUB_PARAMS PRIMARY KEY (CODE_ID,TYPE_CODE)
);

CREATE INDEX IX_PUB_PARAMS_TYPE_CODE ON PUB_PARAMS(TYPE_CODE);

CREATE INDEX IX_PUB_PARAMS_TIME_STAMP ON PUB_PARAMS(TIME_STAMP);

--��֤����2011-01-21
--Ӧ�÷�������Ϣ��
CREATE TABLE CA_SERVER_INFO(
    --���������<8λ���ִ�>
	SRVR_ID varchar(10) NOT NULL,
    --����������
	SRVR_NAME varchar(30) NOT NULL,
    --ƴ����
	SRVR_SPELL varchar(30) NOT NULL,
    --����ص�
	ADDRESS varchar(100) NOT NULL,
    --��������
	CREA_DATE varchar(10) NOT NULL,
    --������״̬
	SRVR_STATUS varchar(1) NOT NULL,
    --����������
	SRVR_TYPE varchar(1) NOT NULL,
    --��������<ȡPUB_CODE_INFO �� CODE_TYPE=8>
	REGION_ID varchar(21) NOT NULL,
    --������ַ<IP������>
	HOST_NAME varchar(20) NOT NULL,
    --�˿ں�
	SRVR_PORT int NOT NULL,
    --URL·��,���·��Ҫ���IPȡ��ȫ·��
	SRVR_PATH varchar(50) NOT NULL,
    --���������
  MAX_SESSION int,
    --�����
  SEQ_NO int,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SERVER_INFO PRIMARY KEY(SRVR_ID)
);

CREATE INDEX IX_PUB_SERVER_INFO_TIME_STAMP ON CA_SERVER_INFO(TIME_STAMP);

--���ݿ������Ϣ��
CREATE TABLE CA_DB_INFO(
    --8λ���ִ�
	DB_ID int NOT NULL,
    --���ݿ��������
	DB_NAME varchar(30) NOT NULL,
    --ƴ����
	DB_SPELL varchar(30) NOT NULL,
    --����ص�
	ADDRESS varchar(100) NOT NULL,
    --��������
	CREA_DATE varchar(10) NOT NULL,
    --���ݷ���������
	HOST_NAME varchar(50) NOT NULL,
    --���ݷ����¼�û�
	USER_NAME varchar(20) NOT NULL,
    --���ݷ����¼����
	PASSWORD varchar(100) NOT NULL,
    --���ݿ���������
	DATABASE_NAME varchar(100) NOT NULL,
    --���ݿ�����
	DATABASE_TYPE varchar(36) NOT NULL,
    --���ݿ����˿�<0ΪĬ�϶˿�>
  DATABASE_PORT int,
    --����״̬
	DB_STATUS varchar(1) NOT NULL,
    --��������<ȡPUB_CODE_INFO �� CODE_TYPE=8>
	REGION_ID varchar(21) NOT NULL,
    --�����
  MAX_SESSION int,
    --�����
  SEQ_NO int,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DB_INFO PRIMARY KEY(DB_ID)
);

CREATE INDEX IX_CA_DB_INFO_TIME_STAMP ON CA_DB_INFO(TIME_STAMP);

--���ݿ�����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','SQLSERVER','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ORACLE','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','SYBASE','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','ACCESS','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','DB2','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','SQLITE','DATABASE_TYPE','00',5497000);

--Ӧ�÷����������ݹ�ϵ��
CREATE TABLE CA_DB_TO_SRVR(
    --���ݿ������
	DB_ID int NOT NULL,
    --Ӧ�÷��������
	SRVR_ID varchar(10) NOT NULL,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DB_TO_SRVR PRIMARY KEY(DB_ID,SRVR_ID)
);

--������״̬
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','SRVR_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','SRVR_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','����','SRVR_STATUS','00',5497000);

--���ݿ����״̬
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','DB_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','DB_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','����','DB_STATUS','00',5497000);

--����������
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���з�����','SRVR_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�йܷ�����','SRVR_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','�̻�������','SRVR_TYPE','00',5497000);

--���ϵ�к�
CREATE TABLE CA_SN_INFO(
    --���ϵ�к�<>
	SN varchar(20) NOT NULL,
    --���Ӻ�<˳�����ִ�10λ 1000000001>
	SN_CODE varchar(10) NOT NULL,
    --ϵ�к�״̬
	SN_STATUS varchar(1) NOT NULL,
    --�ŵ����
	SHOP_ID varchar (11) NOT NULL,
    --��������
	ACTV_DATE varchar(10) NOT NULL,
    --��Ч��ֹ����
	END_DATE varchar(10) NOT NULL,
    --��������
	CREA_DATE varchar(10) NOT NULL,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SN_INFO PRIMARY KEY(SN)
);

CREATE INDEX IX_PUB_SN_INFO_TIME_STAMP ON CA_SN_INFO(TIME_STAMP);

--ϵ�к�״̬
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ʹ��','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','����','SN_STATUS','00',5497000);

--�����Ʒ��Ϣ��
CREATE TABLE CA_PROD_INFO(
    --��Ʒ��Ų�Ʒ�����޶� ����v3/v5��
	PROD_ID varchar(10) NOT NULL,
    --��Ʒ����
	PROD_NAME varchar(50) NOT NULL,
    --��Ʒ���
	PROD_SHORT_NAME varchar(20) NOT NULL,
    --��Ʒ�汾�� ��Ҫ�������ڲ�Ʒ�����޶����߲�Ʒ��װ���ʹ�����Ʒ�ȼ��޶� ������ҵ��/���˰棻
	PROD_VERSION varchar(10) NOT NULL,
    --��ҵ���� MKT ����<ʳ�ӵ�> FIG ��װ DLI ʳƷ OHR ͨ�� ��Ʒ��ҵ�޶�
	INDUSTRY varchar(3) NOT NULL,
    --��Ʒ���� LCL������ NET������  ��Ʒ���⹦���޶�
	PROD_FLAG varchar(3) NOT NULL,
    --��������
	DEVE_DATE varchar(10),
    --�����������
	LAST_ISSUE_DATE varchar(10),
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
   CONSTRAINT PK_CA_PROD_INFO PRIMARY KEY(PROD_ID)
);

--��ҵ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('MKT','����<ʳ�ӵ�>','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('FIG','��װ','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DLI','ʳƷ','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('OHR','ͨ��','INDUSTRY','00',5497000);

--��Ʒ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('LCL','������','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NET','������','INDUSTRY','00',5497000);
--��ʼ�������Ʒ
 insert into CA_PROD_INFO(PROD_ID,PROD_NAME,PROD_SHORT_NAME,PROD_VERSION,INDUSTRY,PROD_FLAG,DEVE_DATE,LAST_ISSUE_DATE,COMM,TIME_STAMP) values('R3-1YC','R3�ŵ�������-�̲������ն�','R3-RYC','3.0','MKT','LCL','2011-01-01','2011-04-01','00',5497000);
 
--����״̬
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','INDUSTRY','00',5497000);

--�汾���Ʊ�,����Ϊ�����汾���Ʊ�
CREATE TABLE CA_UPGRADE_VERSION(
    --���Ʊ��<ֻҪ��Ψһ���>
	VERSION_ID int NOT NULL,
    --��Ʒ���
	PROD_ID varchar(10) NOT NULL,
    --��ǰ�汾�� 5.0.0.93  ����������/������
    --����Ϊ�����汾��
	UPGRADE_VERSION varchar(11) NOT NULL,
    --Ӧ�÷�����
	SRVR_ID varchar(10) NOT NULL,
    --����״̬ 1 ���� 2 ����
	VERSION_STATUS varchar(1) NOT NULL,
    --�������� 1��ѡ���� 2ǿ������
	UPGRADE_FLAG varchar(1) NOT NULL,
    --������Χ 1<Ӧ�÷�����>��Ӧ��������ҵ 2ָ����ҵ���Ե�Ͷ��
	UPGRADE_RANGE varchar(1) NOT NULL,
    --���������ص�ַ ���ļ��� 
	UPGRADE_URL varchar(255) NOT NULL,
    --��������
	ISSUE_DATE varchar(10) NOT NULL,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_U_VERSION PRIMARY KEY(VERSION_ID)
);

--������Χ
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','������ҵ','UPGRADE_RANGE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ָ����ҵ���Ե�Ͷ��','UPGRADE_RANGE','00',5497000);
--��������
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ѡ����','UPGRADE_FLAG','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','ǿ������','UPGRADE_FLAG','00',5497000);

--������ҵ
CREATE TABLE CA_UPGRADE_RANGE(
    --���Ʊ��
	VERSION_ID int NOT NULL,
    --��ҵ���
	TENANT_ID int NOT NULL,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_U_RANGE PRIMARY KEY(VERSION_ID)
);

--�������ñ�
CREATE TABLE SYS_DEFINE (
        --��ҵ���룬ȫ�ֲ���ʱ����Ϊ 0 
	TENANT_ID int NOT NULL ,
        --������,Ӣ�Ĵ���
	DEFINE varchar (30) NOT NULL ,
        --����ֵ
	VALUE varchar (100) ,
        --�������ͣ�Ĭ��Ϊ0
	VALUE_TYPE integer NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������  
        TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SYS_DEFINE PRIMARY KEY (TENANT_ID,DEFINE)
);

insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'ADMIN','admin',0,'00',5497000);
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'PASSWRD','79415A40',0,'00',5497000);
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'DBVERSION','1.0.0.1',0,'00',5497000);

--��ҵ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','������','TENANT_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','TENANT_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','������','TENANT_TYPE','00',5497000);

--��ϵ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','δ��','AUDIT_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','AUDIT_STATUS','00',5497000);
--��ҵ����
CREATE TABLE CA_TENANT(
    --��ҵ���� 1000001
	TENANT_ID int NOT NULL,
    --��¼���� ��:celeb.net
	LOGIN_NAME varchar(50) NOT NULL,
    --��Ӫ���֤
	LICENSE_CODE varchar(50),
    --��ҵ����
	TENANT_NAME varchar(50) NOT NULL,
    --��ҵ����
	TENANT_TYPE varchar(1) NOT NULL,
    --��ҵ���
	SHORT_TENANT_NAME varchar(50) NOT NULL,
    --ƴ����
	TENANT_SPELL varchar(50) NOT NULL,
    --���˴���
	LEGAL_REPR varchar(20),
    --��ϵ��
	LINKMAN varchar(20),
    --��ϵ�绰
	TELEPHONE varchar(30),
    --����
	FAXES varchar(30),
    --��ҳ
	HOMEPAGE varchar(50),
    --��ַ
	ADDRESS varchar(50),
    --QQ��
	QQ varchar(50),
    --MSN��
	MSN varchar(50),
    --�ʱ�
	POSTALCODE varchar(6),
    --��ע
	REMARK varchar(100),
    --��֤����
	PASSWRD varchar(50),
    --��������
	REGION_ID varchar(10),
    --Ĭ��Ӧ�÷��������
	SRVR_ID varchar(10),
    --״̬ 1���� 2����
	AUDIT_STATUS varchar(1) NOT NULL,
    --�����Ʒ���
	PROD_ID varchar(10),
    --���ݿ����ӱ��
	DB_ID int,
    --ע������
	CREA_DATE varchar(10) ,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_TENANT PRIMARY KEY (TENANT_ID)
);

CREATE INDEX IX_CA_TENANT_TIME_STAMP ON CA_TENANT(TIME_STAMP);

--��ϵ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','������','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���˵�','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��Ӫ��','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','������','RELATION_TYPE','00',5497000);

--��ϵ����
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','RELATION_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���','RELATION_STATUS','00',5497000);

--��Ӧ��
CREATE TABLE CA_RELATION(
    --��Ӧ��ID��
	RELATION_ID int NOT NULL,
    --������ҵ��
	TENANT_ID int NOT NULL,
	  --��Ӧ������
	RELATION_NAME varchar(50) NOT NULL,
	  --ƴ����
	RELATION_SPELL varchar(50) NOT NULL,
	  --˵��
	REMARK varchar(255),
	  --��������
	CREA_DATE varchar(10),
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_RELATION PRIMARY KEY (RELATION_ID)
);

CREATE INDEX IX_CA_RELATION_TENANT_ID ON CA_RELATION(TENANT_ID);
CREATE INDEX IX_CA_RELATION_TIME_STAMP ON CA_RELATION(TIME_STAMP);

--��ҵ��ϵ
CREATE TABLE CA_RELATIONS(
    --��ҵ��ϵID��
	RELATIONS_ID varchar(36) NOT NULL,
    --��Ӧ��ID��
	RELATION_ID int NOT NULL,
    --��ǰ��ҵ����
	TENANT_ID int NOT NULL,
    --�¼���ҵ����
	RELATI_ID int NOT NULL,
    --��ϵ����
	RELATION_TYPE varchar(1) NOT NULL,
    --�ṹ�� 000000 6λһ�������֧��5�� <�ڴ˲���һ������û��ָ��ҵ��Ӧ���޷����ɴ˴���>
	LEVEL_ID varchar(30) NOT NULL,
    --��ϵ״̬  1 ���� 2 ��� 
	RELATION_STATUS varchar(1) NOT NULL,
	  --��������
	CREA_DATE varchar(10),
	  --�������
	CHK_DATE varchar(10),
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_RELATIONS PRIMARY KEY (RELATIONS_ID)
);

CREATE INDEX IX_CA_RELATIONS_TENANT_ID ON CA_RELATIONS(TENANT_ID);

CREATE INDEX IX_CA_RELATIONS_RELATI_ID ON CA_RELATIONS(RELATI_ID);

CREATE INDEX IX_CA_RELATIONS_LEVEL_ID ON CA_RELATIONS(LEVEL_ID);

CREATE INDEX IX_CA_RELATIONS_TIME_STAMP ON CA_RELATIONS(TIME_STAMP);

--��������
CREATE TABLE CA_DEPT_INFO(
    --���Ŵ��� ��ҵ����+3λ���
	DEPT_ID varchar (10) NOT NULL,
    --��������
	DEPT_NAME varchar(50) NOT NULL,
    --ƴ����
	DEPT_SPELL varchar(50) NOT NULL,
    --������ϵ ��3λһ��
	LEVEL_ID varchar(50),
    --��ҵ����
	TENANT_ID int,
    --���ŵ绰
	TELEPHONE varchar(30),
    --��ϵ��
	LINKMAN varchar(20),
    --����
	FAXES varchar(30),
    --��ע
	REMARK varchar(100),
    --�����
  SEQ_NO int,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DEPT_INFO PRIMARY KEY (DEPT_ID )
);

CREATE INDEX IX_CA_DEPT_INFO_TENANT_ID ON CA_DEPT_INFO(TENANT_ID);

CREATE INDEX IX_CA_DEPT_INFO_TIME_STAMP ON CA_DEPT_INFO(TENANT_ID,TIME_STAMP);


--�ŵ�����
CREATE TABLE CA_SHOP_INFO(
    --�ŵ���� ��ҵ����+4λ���
	SHOP_ID varchar (11) NOT NULL,
    --��Ӫ���֤
	LICENSE_CODE varchar(50) NOT NULL,
    --�ŵ�����
	SHOP_NAME varchar(50) NOT NULL,
    --ƴ����
	SHOP_SPELL varchar(50) NOT NULL,
    --��ҵ����
	TENANT_ID int,
    --�ŵ긺����
	LINKMAN varchar(20),
    --��ϵ�绰
	TELEPHONE varchar(30),
    --����
	FAXES varchar(30),
    --�ŵ��ַ
	ADDRESS varchar(50),
    --�ʱ�
	POSTALCODE varchar(6),
    --��ע
	REMARK varchar(100),
    --��������
	REGION_ID varchar(10),
    --�ŵ�����(ԭ����Ⱥ�� ��ӦPUB_CODE_INFO)
	SHOP_TYPE varchar(36),
    --�����
  SEQ_NO int,
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SHOP_INFO PRIMARY KEY(SHOP_ID)
);

CREATE INDEX IX_CA_SHOP_INFO_TENANT_ID ON CA_SHOP_INFO(TENANT_ID);

CREATE INDEX IX_CA_SHOP_INFO_TIME_STAMP ON CA_SHOP_INFO(TENANT_ID,TIME_STAMP);

--ְ������
CREATE TABLE CA_DUTY_INFO(
    --ְ����� ��ҵ����+3λ���
	DUTY_ID varchar(10) NOT NULL,
    --ְ������
	DUTY_NAME varchar(30) NOT NULL,
    --������ϵ ��3λһ��
	LEVEL_ID varchar(50),
    --ƴ����
	DUTY_SPELL varchar(30) NOT NULL,
    --������ҵ
	TENANT_ID int NOT NULL,
    --˵��
	REMARK varchar(100),
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DUTY_INFO PRIMARY KEY(DUTY_ID)
);

CREATE INDEX IX_CA_DUTY_INFO_TENANT_ID ON CA_DUTY_INFO(TENANT_ID);

CREATE INDEX IX_CA_DUTY_INFO_TIME_STAMP ON CA_DUTY_INFO(TENANT_ID,TIME_STAMP);

--��ɫ����
CREATE TABLE CA_ROLE_INFO(
    --��ɫ���� ��ҵ����+3λ���
	ROLE_ID varchar(10) NOT NULL,
    --��ɫ����
	ROLE_NAME varchar(30) NOT NULL,
    --ƴ����
	ROLE_SPELL varchar(30) NOT NULL,
    --������ҵ
	TENANT_ID int NOT NULL,
    --˵��
	REMARK varchar(100),
    --ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_ROLE_INFO PRIMARY KEY(ROLE_ID)
);

CREATE INDEX IX_CA_ROLE_INFO_TENANT_ID ON CA_ROLE_INFO(TENANT_ID);

CREATE INDEX IX_CA_ROLE_INFO_TIME_STAMP ON CA_ROLE_INFO(TENANT_ID,TIME_STAMP);

--�û�����
CREATE TABLE CA_USERS(
    --�û�����newid()��guidֵ
	USER_ID varchar(36) NOT NULL,
    --��¼��  ��ҵ�ڲ��ظ�
	ACCOUNT varchar(20) NOT NULL,
    --ʶ����  IC�ſ���ָ����
	ENCODE varchar(50),
    --�û���
	USER_NAME varchar(20) NOT NULL,
    --ƴ����
	USER_SPELL varchar(20) NOT NULL,
    --����
	PASS_WRD varchar(50),
    --�����ŵ� 
	SHOP_ID varchar (11) NOT NULL,
    --��������
	DEPT_ID varchar (10) NOT NULL,
    --����ְ��,��ְ����,�ŷָ�
	DUTY_IDS varchar(100) NOT NULL,
    --����ְ������,��ְ����,�ŷָ�
	DUTY_NAMES varchar(250) NOT NULL,
    --������ɫ,���ɫ��,�ŷָ�
	ROLE_IDS varchar(100) NOT NULL,
    --������ɫ����,���ɫ��,�ŷָ�
	ROLE_NAMES varchar(250) NOT NULL,
    --��ҵ����
	TENANT_ID int NOT NULL,
    --�Ա�  ��\Ů\����
	SEX varchar(4),
    --���� 
	BIRTHDAY varchar (10),
	  --ѧ��
	DEGREES varchar(36),
    --�ֻ���
	MOBILE varchar(11),
    --�칫�绰
	OFFI_TELE varchar(11),
    --��ͥ�绰
	FAMI_TELE varchar(11),
    --��������
	EMAIL varchar(50),
    --QQ��
	QQ varchar(50),
    --���˺�
	MM varchar(50),
    --MSN��
	MSN varchar(50),
    --֤������
	ID_NUMBER varchar(50),
    --֤������
	IDN_TYPE varchar(36),
    --��ͥ��ַ
	FAMI_ADDR varchar(50),
    --�ʱ�
	POSTALCODE varchar(6),
    --��ְ����
	WORK_DATE varchar(10),
    --ְ������
	DIMI_DATE varchar(10),
    --˵��
	REMARK varchar(100),
	--ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
  COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_USERS PRIMARY KEY (USER_ID )
);

CREATE INDEX IX_CA_USERS_TENANT_ID ON CA_USERS(TENANT_ID);

CREATE INDEX IX_CA_USERS_ACCOUNT ON CA_USERS(TENANT_ID,ACCOUNT);

CREATE INDEX IX_CA_USERS_ENCODE ON CA_USERS(TENANT_ID,ENCODE);

CREATE INDEX IX_CA_USERS_TIME_STAMP ON CA_USERS(TENANT_ID,TIME_STAMP);

CREATE view VIW_USERS
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,QQ,MM,MSN,PASS_WRD,COMM from CA_USERS
union all
select TENANT_ID,trim(char(TENANT_ID))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'����Ա' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,trim(char(B.TENANT_ID))||'0001' as SHOP_ID,'administrator' as USER_ID,'administrator' as ACCOUNT,'��������Ա' as USER_NAME,'cjgly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--������Ϣ��
CREATE TABLE PUB_CODE_INFO(
    --��ҵ����<0Ϊ��������>
	TENANT_ID int NOT NULL,
    --���ϱ��� 
	CODE_ID varchar(36) NOT NULL,
    --��ID��4λһ��
	LEVEL_ID varchar (20) ,
    --��������
	CODE_TYPE varchar(2) NOT NULL,
    --��������
	CODE_NAME varchar(30) NOT NULL,
    --ƴ����
	CODE_SPELL varchar(30) NOT NULL,
    --�����
	SEQ_NO int,
	--ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
    --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_PUB_CODE_INFO PRIMARY KEY (TENANT_ID,CODE_ID,CODE_TYPE)
);

CREATE INDEX IX_PUB_CODE_INFO_CODE_TYPE ON PUB_CODE_INFO(TENANT_ID,CODE_TYPE);

CREATE INDEX IX_PUB_CODE_INFO_TIME_STAMP ON PUB_CODE_INFO(TENANT_ID,TIME_STAMP);

CREATE INDEX IX_PUB_CODE_INFO_TENANT_ID ON PUB_CODE_INFO(TENANT_ID);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('8','��������','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','֤������','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','����Ⱥ��','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('13','�¾�����','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('14','ѧ��','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('15','ְҵ','CODE_TYPE','00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','���֤','SFZ','11',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','��ʻ֤','JSZ','11',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','�籣��','SBK','11',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','����֤','JGZ','11',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','����','HZ','11',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','ѧ��֤','XSZ','11',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','��Ӫ���֤','JYXKZ','11',7,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'99','����','QT','11',8,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','1000����','','13',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','1000-2000','','13',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','2000-3000','','13',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','3000-4000','','13',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','4000-5000','','13',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','5000����','','13',6,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','Сѧ','XX','14',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','����','CZ','14',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','����','GZ','14',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','ר��','ZK','14',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','����','BK','14',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','˶ʿ','SS','14',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','��ʿ','BS','14',7,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','����','XX','15',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','�ز�','CZ','15',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','����','GZ','15',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','IT��Ϣ����','ZK','15',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','������ѯ','BK','15',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','ý�����','SS','15',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','��ҵ����','BS','15',7,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'8','������ѵ','BS','15',8,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'9','��������','BS','15',9,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'10','����','BS','15',10,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'11','����','BS','15',11,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'12','��Դ','BS','15',12,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'13','����ó��','BS','15',13,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'14','����','BS','15',14,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'99','����','BS','15',99,'00',5497000);

 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110000,'110000','������','BJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110101,'110101','������.������','BJSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110102,'110102','������.������','BJSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110103,'110103','������.������','BJSCWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110104,'110104','������.������','BJSXWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110105,'110105','������.������','BJSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110106,'110106','������.��̨��','BJSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110107,'110107','������.ʯ��ɽ��','BJSSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110108,'110108','������.������','BJSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110109,'110109','������.��ͷ����','BJSMTGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110111,'110111','������.��ɽ��','BJSFSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110112,'110112','������.ͨ����','BJSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110113,'110113','������.˳����','BJSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110114,'110114','������.��ƽ��','BJSCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110115,'110115','������.������','BJSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110116,'110116','������.������','BJSHRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110117,'110117','������.ƽ����','BJSPGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110228,'110228','������.������','BJSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110229,'110229','������.������','BJSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120000,'120000','�����','TJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120101,'120101','�����.��ƽ��','TJSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120102,'120102','�����.�Ӷ���','TJSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120103,'120103','�����.������','TJSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120104,'120104','�����.�Ͽ���','TJSNKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120105,'120105','�����.�ӱ���','TJSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120106,'120106','�����.������','TJSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120110,'120110','�����.������','TJSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120111,'120111','�����.������','TJSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120112,'120112','�����.������','TJSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120113,'120113','�����.������','TJSBCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120114,'120114','�����.������','TJSWQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120115,'120115','�����.������','TJSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120116,'120116','�����.��������','TJSBHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120221,'120221','�����.������','TJSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120223,'120223','�����.������','TJSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120225,'120225','�����.����','TJSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130000,'130000','�ӱ�ʡ','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130100,'130100','�ӱ�ʡ.ʯ��ׯ��','HBSSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130102,'130102','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130103,'130103','�ӱ�ʡ.ʯ��ׯ��.�Ŷ���','HBSSJZSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130104,'130104','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130105,'130105','�ӱ�ʡ.ʯ��ׯ��.�»���','HBSSJZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130107,'130107','�ӱ�ʡ.ʯ��ׯ��.�������','HBSSJZSJZKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130108,'130108','�ӱ�ʡ.ʯ��ׯ��.ԣ����','HBSSJZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130121,'130121','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130123,'130123','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130124,'130124','�ӱ�ʡ.ʯ��ׯ��.�����','HBSSJZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130125,'130125','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130126,'130126','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130127,'130127','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130128,'130128','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130129,'130129','�ӱ�ʡ.ʯ��ׯ��.�޻���','HBSSJZSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130130,'130130','�ӱ�ʡ.ʯ��ׯ��.�޼���','HBSSJZSWJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130131,'130131','�ӱ�ʡ.ʯ��ׯ��.ƽɽ��','HBSSJZSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130132,'130132','�ӱ�ʡ.ʯ��ׯ��.Ԫ����','HBSSJZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130133,'130133','�ӱ�ʡ.ʯ��ׯ��.����','HBSSJZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130181,'130181','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSXJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130182,'130182','�ӱ�ʡ.ʯ��ׯ��.޻����','HBSSJZSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130183,'130183','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130184,'130184','�ӱ�ʡ.ʯ��ׯ��.������','HBSSJZSXLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130185,'130185','�ӱ�ʡ.ʯ��ׯ��.¹Ȫ��','HBSSJZSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130200,'130200','�ӱ�ʡ.��ɽ��','HBSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130202,'130202','�ӱ�ʡ.��ɽ��.·����','HBSTSSLNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130203,'130203','�ӱ�ʡ.��ɽ��.·����','HBSTSSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130204,'130204','�ӱ�ʡ.��ɽ��.��ұ��','HBSTSSGYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130205,'130205','�ӱ�ʡ.��ɽ��.��ƽ��','HBSTSSKPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130207,'130207','�ӱ�ʡ.��ɽ��.������','HBSTSSFNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130208,'130208','�ӱ�ʡ.��ɽ��.������','HBSTSSFRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130223,'130223','�ӱ�ʡ.��ɽ��.����','HBSTSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130224,'130224','�ӱ�ʡ.��ɽ��.������','HBSTSSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130225,'130225','�ӱ�ʡ.��ɽ��.��ͤ��','HBSTSSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130227,'130227','�ӱ�ʡ.��ɽ��.Ǩ����','HBSTSSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130229,'130229','�ӱ�ʡ.��ɽ��.������','HBSTSSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130230,'130230','�ӱ�ʡ.��ɽ��.�ƺ���','HBSTSSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130281,'130281','�ӱ�ʡ.��ɽ��.����','HBSTSSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130283,'130283','�ӱ�ʡ.��ɽ��.Ǩ����','HBSTSSQAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130300,'130300','�ӱ�ʡ.�ػʵ���','HBSQHDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130302,'130302','�ӱ�ʡ.�ػʵ���.������','HBSQHDSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130303,'130303','�ӱ�ʡ.�ػʵ���.ɽ������','HBSQHDSSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130304,'130304','�ӱ�ʡ.�ػʵ���.��������','HBSQHDSBDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130321,'130321','�ӱ�ʡ.�ػʵ���.������','HBSQHDSQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130322,'130322','�ӱ�ʡ.�ػʵ���.������','HBSQHDSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130323,'130323','�ӱ�ʡ.�ػʵ���.������','HBSQHDSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130324,'130324','�ӱ�ʡ.�ػʵ���.¬����','HBSQHDSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130400,'130400','�ӱ�ʡ.������','HBSHDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130402,'130402','�ӱ�ʡ.������.��ɽ��','HBSHDSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130403,'130403','�ӱ�ʡ.������.��̨��','HBSHDSCTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130404,'130404','�ӱ�ʡ.������.������','HBSHDSFXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130406,'130406','�ӱ�ʡ.������.������','HBSHDSFFKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130421,'130421','�ӱ�ʡ.������.������','HBSHDSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130423,'130423','�ӱ�ʡ.������.������','HBSHDSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130424,'130424','�ӱ�ʡ.������.�ɰ���','HBSHDSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130425,'130425','�ӱ�ʡ.������.������','HBSHDSDMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130426,'130426','�ӱ�ʡ.������.����','HBSHDSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130427,'130427','�ӱ�ʡ.������.����','HBSHDSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130428,'130428','�ӱ�ʡ.������.������','HBSHDSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130429,'130429','�ӱ�ʡ.������.������','HBSHDSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130430,'130430','�ӱ�ʡ.������.����','HBSHDSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130431,'130431','�ӱ�ʡ.������.������','HBSHDSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130432,'130432','�ӱ�ʡ.������.��ƽ��','HBSHDSGPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130433,'130433','�ӱ�ʡ.������.������','HBSHDSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130434,'130434','�ӱ�ʡ.������.κ��','HBSHDSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130435,'130435','�ӱ�ʡ.������.������','HBSHDSQZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130481,'130481','�ӱ�ʡ.������.�䰲��','HBSHDSWAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130500,'130500','�ӱ�ʡ.��̨��','HBSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130502,'130502','�ӱ�ʡ.��̨��.�Ŷ���','HBSXTSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130503,'130503','�ӱ�ʡ.��̨��.������','HBSXTSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130521,'130521','�ӱ�ʡ.��̨��.��̨��','HBSXTSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130522,'130522','�ӱ�ʡ.��̨��.�ٳ���','HBSXTSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130523,'130523','�ӱ�ʡ.��̨��.������','HBSXTSNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130524,'130524','�ӱ�ʡ.��̨��.������','HBSXTSBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130525,'130525','�ӱ�ʡ.��̨��.¡Ң��','HBSXTSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130526,'130526','�ӱ�ʡ.��̨��.����','HBSXTSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130527,'130527','�ӱ�ʡ.��̨��.�Ϻ���','HBSXTSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130528,'130528','�ӱ�ʡ.��̨��.������','HBSXTSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130529,'130529','�ӱ�ʡ.��̨��.��¹��','HBSXTSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130530,'130530','�ӱ�ʡ.��̨��.�º���','HBSXTSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130531,'130531','�ӱ�ʡ.��̨��.������','HBSXTSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130532,'130532','�ӱ�ʡ.��̨��.ƽ����','HBSXTSPXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130533,'130533','�ӱ�ʡ.��̨��.����','HBSXTSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130534,'130534','�ӱ�ʡ.��̨��.�����','HBSXTSQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130535,'130535','�ӱ�ʡ.��̨��.������','HBSXTSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130581,'130581','�ӱ�ʡ.��̨��.�Ϲ���','HBSXTSNGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130582,'130582','�ӱ�ʡ.��̨��.ɳ����','HBSXTSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130600,'130600','�ӱ�ʡ.������','HBSBDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130602,'130602','�ӱ�ʡ.������.������','HBSBDSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130603,'130603','�ӱ�ʡ.������.������','HBSBDSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130604,'130604','�ӱ�ʡ.������.������','HBSBDSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130621,'130621','�ӱ�ʡ.������.������','HBSBDSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130622,'130622','�ӱ�ʡ.������.��Է��','HBSBDSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130623,'130623','�ӱ�ʡ.������.�ˮ��','HBSBDSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130624,'130624','�ӱ�ʡ.������.��ƽ��','HBSBDSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130625,'130625','�ӱ�ʡ.������.��ˮ��','HBSBDSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130626,'130626','�ӱ�ʡ.������.������','HBSBDSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130627,'130627','�ӱ�ʡ.������.����','HBSBDSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130628,'130628','�ӱ�ʡ.������.������','HBSBDSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130629,'130629','�ӱ�ʡ.������.�ݳ���','HBSBDSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130630,'130630','�ӱ�ʡ.������.�Դ��','HBSBDSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130631,'130631','�ӱ�ʡ.������.������','HBSBDSWDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130632,'130632','�ӱ�ʡ.������.������','HBSBDSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130633,'130633','�ӱ�ʡ.������.����','HBSBDSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130634,'130634','�ӱ�ʡ.������.������','HBSBDSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130635,'130635','�ӱ�ʡ.������.���','HBSBDSlX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130636,'130636','�ӱ�ʡ.������.˳ƽ��','HBSBDSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130637,'130637','�ӱ�ʡ.������.��Ұ��','HBSBDSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130638,'130638','�ӱ�ʡ.������.����','HBSBDSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130681,'130681','�ӱ�ʡ.������.������','HBSBDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130682,'130682','�ӱ�ʡ.������.������','HBSBDSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130683,'130683','�ӱ�ʡ.������.������','HBSBDSAGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130684,'130684','�ӱ�ʡ.������.�߱�����','HBSBDSGBDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130700,'130700','�ӱ�ʡ.�żҿ���','HBSZJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130702,'130702','�ӱ�ʡ.�żҿ���.�Ŷ���','HBSZJKSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130703,'130703','�ӱ�ʡ.�żҿ���.������','HBSZJKSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130705,'130705','�ӱ�ʡ.�żҿ���.������','HBSZJKSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130706,'130706','�ӱ�ʡ.�żҿ���.�»�԰��','HBSZJKSXHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130721,'130721','�ӱ�ʡ.�żҿ���.������','HBSZJKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130722,'130722','�ӱ�ʡ.�żҿ���.�ű���','HBSZJKSZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130723,'130723','�ӱ�ʡ.�żҿ���.������','HBSZJKSKBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130724,'130724','�ӱ�ʡ.�żҿ���.��Դ��','HBSZJKSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130725,'130725','�ӱ�ʡ.�żҿ���.������','HBSZJKSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130726,'130726','�ӱ�ʡ.�żҿ���.ε��','HBSZJKSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130727,'130727','�ӱ�ʡ.�żҿ���.��ԭ��','HBSZJKSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130728,'130728','�ӱ�ʡ.�żҿ���.������','HBSZJKSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130729,'130729','�ӱ�ʡ.�żҿ���.��ȫ��','HBSZJKSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130730,'130730','�ӱ�ʡ.�żҿ���.������','HBSZJKSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130731,'130731','�ӱ�ʡ.�żҿ���.��¹��','HBSZJKSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130732,'130732','�ӱ�ʡ.�żҿ���.�����','HBSZJKSCCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130733,'130733','�ӱ�ʡ.�żҿ���.������','HBSZJKSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130800,'130800','�ӱ�ʡ.�е���','HBSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130802,'130802','�ӱ�ʡ.�е���.˫����','HBSCDSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130803,'130803','�ӱ�ʡ.�е���.˫����','HBSCDSSLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130804,'130804','�ӱ�ʡ.�е���.ӥ��Ӫ�ӿ���','HBSCDSYSYZKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130821,'130821','�ӱ�ʡ.�е���.�е���','HBSCDSCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130822,'130822','�ӱ�ʡ.�е���.��¡��','HBSCDSXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130823,'130823','�ӱ�ʡ.�е���.ƽȪ��','HBSCDSPQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130824,'130824','�ӱ�ʡ.�е���.��ƽ��','HBSCDSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130825,'130825','�ӱ�ʡ.�е���.¡����','HBSCDSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130826,'130826','�ӱ�ʡ.�е���.������','HBSCDSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130827,'130827','�ӱ�ʡ.�е���.�����','HBSCDSKCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130828,'130828','�ӱ�ʡ.�е���.Χ����','HBSCDSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130900,'130900','�ӱ�ʡ.������','HBSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130902,'130902','�ӱ�ʡ.������.�»���','HBSCZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130903,'130903','�ӱ�ʡ.������.�˺���','HBSCZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130921,'130921','�ӱ�ʡ.������.����','HBSCZSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130922,'130922','�ӱ�ʡ.������.����','HBSCZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130923,'130923','�ӱ�ʡ.������.������','HBSCZSDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130924,'130924','�ӱ�ʡ.������.������','HBSCZSHXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130925,'130925','�ӱ�ʡ.������.��ɽ��','HBSCZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130926,'130926','�ӱ�ʡ.������.������','HBSCZSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130927,'130927','�ӱ�ʡ.������.��Ƥ��','HBSCZSNPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130928,'130928','�ӱ�ʡ.������.������','HBSCZSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130929,'130929','�ӱ�ʡ.������.����','HBSCZSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130930,'130930','�ӱ�ʡ.������.�ϴ���','HBSCZSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130981,'130981','�ӱ�ʡ.������.��ͷ��','HBSCZSBTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130982,'130982','�ӱ�ʡ.������.������','HBSCZSRQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130983,'130983','�ӱ�ʡ.������.������','HBSCZSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130984,'130984','�ӱ�ʡ.������.�Ӽ���','HBSCZSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131000,'131000','�ӱ�ʡ.�ȷ���','HBSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131002,'131002','�ӱ�ʡ.�ȷ���.������','HBSLFSACQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131003,'131003','�ӱ�ʡ.�ȷ���.������','HBSLFSGYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131022,'131022','�ӱ�ʡ.�ȷ���.�̰���','HBSLFSGAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131023,'131023','�ӱ�ʡ.�ȷ���.������','HBSLFSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131024,'131024','�ӱ�ʡ.�ȷ���.�����','HBSLFSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131025,'131025','�ӱ�ʡ.�ȷ���.�����','HBSLFSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131026,'131026','�ӱ�ʡ.�ȷ���.�İ���','HBSLFSWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131028,'131028','�ӱ�ʡ.�ȷ���.����','HBSLFSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131081,'131081','�ӱ�ʡ.�ȷ���.������','HBSLFSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131082,'131082','�ӱ�ʡ.�ȷ���.������','HBSLFSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131100,'131100','�ӱ�ʡ.��ˮ��','HBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131102,'131102','�ӱ�ʡ.��ˮ��.�ҳ���','HBSHSSTCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131121,'131121','�ӱ�ʡ.��ˮ��.��ǿ��','HBSHSSZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131122,'131122','�ӱ�ʡ.��ˮ��.������','HBSHSSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131123,'131123','�ӱ�ʡ.��ˮ��.��ǿ��','HBSHSSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131124,'131124','�ӱ�ʡ.��ˮ��.������','HBSHSSRYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131125,'131125','�ӱ�ʡ.��ˮ��.��ƽ��','HBSHSSAPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131126,'131126','�ӱ�ʡ.��ˮ��.�ʳ���','HBSHSSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131127,'131127','�ӱ�ʡ.��ˮ��.����','HBSHSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131128,'131128','�ӱ�ʡ.��ˮ��.������','HBSHSSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131181,'131181','�ӱ�ʡ.��ˮ��.������','HBSHSSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131182,'131182','�ӱ�ʡ.��ˮ��.������','HBSHSSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140000,'140000','ɽ��ʡ','SXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140100,'140100','ɽ��ʡ.̫ԭ��','SXSTYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140105,'140105','ɽ��ʡ.̫ԭ��.С����','SXSTYSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140106,'140106','ɽ��ʡ.̫ԭ��.ӭ����','SXSTYSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140107,'140107','ɽ��ʡ.̫ԭ��.�ӻ�����','SXSTYSXHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140108,'140108','ɽ��ʡ.̫ԭ��.���ƺ��','SXSTYSJCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140109,'140109','ɽ��ʡ.̫ԭ��.�������','SXSTYSWBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140110,'140110','ɽ��ʡ.̫ԭ��.��Դ��','SXSTYSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140121,'140121','ɽ��ʡ.̫ԭ��.������','SXSTYSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140122,'140122','ɽ��ʡ.̫ԭ��.������','SXSTYSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140123,'140123','ɽ��ʡ.̫ԭ��.¦����','SXSTYSLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140181,'140181','ɽ��ʡ.̫ԭ��.�Ž���','SXSTYSGJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140200,'140200','ɽ��ʡ.��ͬ��','SXSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140202,'140202','ɽ��ʡ.��ͬ��.����','SXSDTSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140203,'140203','ɽ��ʡ.��ͬ��.����','SXSDTSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140211,'140211','ɽ��ʡ.��ͬ��.�Ͻ���','SXSDTSNJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140212,'140212','ɽ��ʡ.��ͬ��.������','SXSDTSXRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140221,'140221','ɽ��ʡ.��ͬ��.������','SXSDTSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140222,'140222','ɽ��ʡ.��ͬ��.������','SXSDTSTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140223,'140223','ɽ��ʡ.��ͬ��.������','SXSDTSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140224,'140224','ɽ��ʡ.��ͬ��.������','SXSDTSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140225,'140225','ɽ��ʡ.��ͬ��.��Դ��','SXSDTSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140226,'140226','ɽ��ʡ.��ͬ��.������','SXSDTSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140227,'140227','ɽ��ʡ.��ͬ��.��ͬ��','SXSDTSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140300,'140300','ɽ��ʡ.��Ȫ��','SXSYQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140302,'140302','ɽ��ʡ.��Ȫ��.����','SXSYQSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140303,'140303','ɽ��ʡ.��Ȫ��.����','SXSYQSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140311,'140311','ɽ��ʡ.��Ȫ��.����','SXSYQSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140321,'140321','ɽ��ʡ.��Ȫ��.ƽ����','SXSYQSPDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140322,'140322','ɽ��ʡ.��Ȫ��.����','SXSYQSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140400,'140400','ɽ��ʡ.������','SXSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140402,'140402','ɽ��ʡ.������.����','SXSCZSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140411,'140411','ɽ��ʡ.������.����','SXSCZSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140421,'140421','ɽ��ʡ.������.������','SXSCZSCZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140423,'140423','ɽ��ʡ.������.��ԫ��','SXSCZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140424,'140424','ɽ��ʡ.������.������','SXSCZSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140425,'140425','ɽ��ʡ.������.ƽ˳��','SXSCZSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140426,'140426','ɽ��ʡ.������.�����','SXSCZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140427,'140427','ɽ��ʡ.������.������','SXSCZSHGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140428,'140428','ɽ��ʡ.������.������','SXSCZSCZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140429,'140429','ɽ��ʡ.������.������','SXSCZSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140430,'140430','ɽ��ʡ.������.����','SXSCZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140431,'140431','ɽ��ʡ.������.��Դ��','SXSCZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140481,'140481','ɽ��ʡ.������.º����','SXSCZSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140500,'140500','ɽ��ʡ.������','SXSJCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140502,'140502','ɽ��ʡ.������.����','SXSJCSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140521,'140521','ɽ��ʡ.������.��ˮ��','SXSJCSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140522,'140522','ɽ��ʡ.������.������','SXSJCSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140524,'140524','ɽ��ʡ.������.�괨��','SXSJCSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140525,'140525','ɽ��ʡ.������.������','SXSJCSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140581,'140581','ɽ��ʡ.������.��ƽ��','SXSJCSGPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140600,'140600','ɽ��ʡ.˷����','SXSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140602,'140602','ɽ��ʡ.˷����.˷����','SXSSZSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140603,'140603','ɽ��ʡ.˷����.ƽ³��','SXSSZSPLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140621,'140621','ɽ��ʡ.˷����.ɽ����','SXSSZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140622,'140622','ɽ��ʡ.˷����.Ӧ��','SXSSZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140623,'140623','ɽ��ʡ.˷����.������','SXSSZSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140624,'140624','ɽ��ʡ.˷����.������','SXSSZSHRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140700,'140700','ɽ��ʡ.������','SXSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140702,'140702','ɽ��ʡ.������.�ܴ���','SXSJZSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140721,'140721','ɽ��ʡ.������.������','SXSJZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140722,'140722','ɽ��ʡ.������.��Ȩ��','SXSJZSZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140723,'140723','ɽ��ʡ.������.��˳��','SXSJZSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140724,'140724','ɽ��ʡ.������.������','SXSJZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140725,'140725','ɽ��ʡ.������.������','SXSJZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140726,'140726','ɽ��ʡ.������.̫����','SXSJZSTGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140727,'140727','ɽ��ʡ.������.����','SXSJZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140728,'140728','ɽ��ʡ.������.ƽң��','SXSJZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140729,'140729','ɽ��ʡ.������.��ʯ��','SXSJZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140781,'140781','ɽ��ʡ.������.������','SXSJZSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140800,'140800','ɽ��ʡ.�˳���','SXSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140802,'140802','ɽ��ʡ.�˳���.�κ���','SXSYCSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140821,'140821','ɽ��ʡ.�˳���.�����','SXSYCSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140822,'140822','ɽ��ʡ.�˳���.������','SXSYCSWRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140823,'140823','ɽ��ʡ.�˳���.��ϲ��','SXSYCSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140824,'140824','ɽ��ʡ.�˳���.�ɽ��','SXSYCSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140825,'140825','ɽ��ʡ.�˳���.�����','SXSYCSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140826,'140826','ɽ��ʡ.�˳���.���','SXSYCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140827,'140827','ɽ��ʡ.�˳���.ԫ����','SXSYCSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140828,'140828','ɽ��ʡ.�˳���.����','SXSYCSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140829,'140829','ɽ��ʡ.�˳���.ƽ½��','SXSYCSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140830,'140830','ɽ��ʡ.�˳���.�ǳ���','SXSYCSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140881,'140881','ɽ��ʡ.�˳���.������','SXSYCSYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140882,'140882','ɽ��ʡ.�˳���.�ӽ���','SXSYCSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140900,'140900','ɽ��ʡ.������','SXSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140902,'140902','ɽ��ʡ.������.�ø���','SXSXZSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140921,'140921','ɽ��ʡ.������.������','SXSXZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140922,'140922','ɽ��ʡ.������.��̨��','SXSXZSWTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140923,'140923','ɽ��ʡ.������.����','SXSXZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140924,'140924','ɽ��ʡ.������.������','SXSXZSFZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140925,'140925','ɽ��ʡ.������.������','SXSXZSNWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140926,'140926','ɽ��ʡ.������.������','SXSXZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140927,'140927','ɽ��ʡ.������.�����','SXSXZSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140928,'140928','ɽ��ʡ.������.��կ��','SXSXZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140929,'140929','ɽ��ʡ.������.����','SXSXZSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140930,'140930','ɽ��ʡ.������.������','SXSXZSHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140931,'140931','ɽ��ʡ.������.������','SXSXZSBDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140932,'140932','ɽ��ʡ.������.ƫ����','SXSXZSPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140981,'140981','ɽ��ʡ.������.ԭƽ��','SXSXZSYPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141000,'141000','ɽ��ʡ.�ٷ���','SXSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141002,'141002','ɽ��ʡ.�ٷ���.Ң����','SXSLFSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141021,'141021','ɽ��ʡ.�ٷ���.������','SXSLFSQWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141022,'141022','ɽ��ʡ.�ٷ���.�����','SXSLFSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141023,'141023','ɽ��ʡ.�ٷ���.�����','SXSLFSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141024,'141024','ɽ��ʡ.�ٷ���.�鶴��','SXSLFSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141025,'141025','ɽ��ʡ.�ٷ���.����','SXSLFSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141026,'141026','ɽ��ʡ.�ٷ���.������','SXSLFSAZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141027,'141027','ɽ��ʡ.�ٷ���.��ɽ��','SXSLFSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141028,'141028','ɽ��ʡ.�ٷ���.����','SXSLFSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141029,'141029','ɽ��ʡ.�ٷ���.������','SXSLFSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141030,'141030','ɽ��ʡ.�ٷ���.������','SXSLFSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141031,'141031','ɽ��ʡ.�ٷ���.����','SXSLFSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141032,'141032','ɽ��ʡ.�ٷ���.������','SXSLFSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141033,'141033','ɽ��ʡ.�ٷ���.����','SXSLFSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141034,'141034','ɽ��ʡ.�ٷ���.������','SXSLFSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141081,'141081','ɽ��ʡ.�ٷ���.������','SXSLFSHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141082,'141082','ɽ��ʡ.�ٷ���.������','SXSLFSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141100,'141100','ɽ��ʡ.������','SXSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141102,'141102','ɽ��ʡ.������.��ʯ��','SXSLLSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141121,'141121','ɽ��ʡ.������.��ˮ��','SXSLLSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141122,'141122','ɽ��ʡ.������.������','SXSLLSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141123,'141123','ɽ��ʡ.������.����','SXSLLSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141124,'141124','ɽ��ʡ.������.����','SXSLLSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141125,'141125','ɽ��ʡ.������.������','SXSLLSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141126,'141126','ɽ��ʡ.������.ʯ¥��','SXSLLSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141127,'141127','ɽ��ʡ.������.���','SXSLLSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141128,'141128','ɽ��ʡ.������.��ɽ��','SXSLLSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141129,'141129','ɽ��ʡ.������.������','SXSLLSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141130,'141130','ɽ��ʡ.������.������','SXSLLSJKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141181,'141181','ɽ��ʡ.������.Т����','SXSLLSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141182,'141182','ɽ��ʡ.������.������','SXSLLSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150000,'150000','����','NM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150100,'150100','����.���ͺ�����','NMHHHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150102,'150102','����.���ͺ�����.�³���','NMHHHTSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150103,'150103','����.���ͺ�����.������','NMHHHTSHMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150104,'150104','����.���ͺ�����.��Ȫ��','NMHHHTSYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150105,'150105','����.���ͺ�����.������','NMHHHTSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150121,'150121','����.���ͺ�����.��Ĭ������','NMHHHTSTMTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150122,'150122','����.���ͺ�����.�п�����','NMHHHTSTKTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150123,'150123','����.���ͺ�����.���ָ����','NMHHHTSHLGEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150124,'150124','����.���ͺ�����.��ˮ����','NMHHHTSQSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150125,'150125','����.���ͺ�����.�䴨��','NMHHHTSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150200,'150200','����.��ͷ��','NMBTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150202,'150202','����.��ͷ��.������','NMBTSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150203,'150203','����.��ͷ��.��������','NMBTSKDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150204,'150204','����.��ͷ��.��ɽ��','NMBTSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150205,'150205','����.��ͷ��.ʯ����','NMBTSSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150206,'150206','����.��ͷ��.���ƶ�������','NMBTSBYEBKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150207,'150207','����.��ͷ��.��ԭ��','NMBTSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150221,'150221','����.��ͷ��.��Ĭ������','NMBTSTMTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150222,'150222','����.��ͷ��.������','NMBTSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150223,'150223','����.��ͷ��.�����ï����������','NMBTSDEHMMALHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150300,'150300','����.�ں���','NMWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150302,'150302','����.�ں���.��������','NMWHSHBWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150303,'150303','����.�ں���.������','NMWHSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150304,'150304','����.�ں���.�ڴ���','NMWHSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150400,'150400','����.�����','NMCFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150402,'150402','����.�����.��ɽ��','NMCFSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150403,'150403','����.�����.Ԫ��ɽ��','NMCFSYBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150404,'150404','����.�����.��ɽ��','NMCFSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150421,'150421','����.�����.��³�ƶ�����','NMCFSALKEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150422,'150422','����.�����.��������','NMCFSBLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150423,'150423','����.�����.��������','NMCFSBLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150424,'150424','����.�����.������','NMCFSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150425,'150425','����.�����.��ʲ������','NMCFSKSKTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150426,'150426','����.�����.��ţ����','NMCFSWNTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150428,'150428','����.�����.��������','NMCFSKLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150429,'150429','����.�����.������','NMCFSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150430,'150430','����.�����.������','NMCFSAHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150500,'150500','����.ͨ����','NMTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150502,'150502','����.ͨ����.�ƶ�����','NMTLSKEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150521,'150521','����.ͨ����.�ƶ�����������','NMTLSKEQZYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150522,'150522','����.ͨ����.�ƶ����������','NMTLSKEQZYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150523,'150523','����.ͨ����.��³��','NMTLSKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150524,'150524','����.ͨ����.������','NMTLSKLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150525,'150525','����.ͨ����.������','NMTLSNMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150526,'150526','����.ͨ����.��³����','NMTLSZLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150581,'150581','����.ͨ����.���ֹ�����','NMTLSHLGLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150600,'150600','����.������˹��','NMEEDSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150602,'150602','����.������˹��.��ʤ��','NMEEDSSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150621,'150621','����.������˹��.��������','NMEEDSSDLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150622,'150622','����.������˹��.׼�����','NMEEDSSZGEQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150623,'150623','����.������˹��.���п�ǰ��','NMEEDSSETKQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150624,'150624','����.������˹��.���п���','NMEEDSSETKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150625,'150625','����.������˹��.������','NMEEDSSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150626,'150626','����.������˹��.������','NMEEDSSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150627,'150627','����.������˹��.���������','NMEEDSSYJHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150700,'150700','����.���ױ�����','NMHLBES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150702,'150702','����.���ױ�����.��������','NMHLBESHLEQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150721,'150721','����.���ױ�����.������','NMHLBESARQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150722,'150722','����.���ױ�����.Ī��','NMHLBESMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150723,'150723','����.���ױ�����.���״�������','NMHLBESELCZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150724,'150724','����.���ױ�����.���¿���������','NMHLBESEWKZZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150725,'150725','����.���ױ�����.�°Ͷ�����','NMHLBESCBEHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150726,'150726','����.���ױ�����.�°Ͷ�������','NMHLBESXBEHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150727,'150727','����.���ױ�����.�°Ͷ�������','NMHLBESXBEHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150781,'150781','����.���ױ�����.��������','NMHLBESMZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150782,'150782','����.���ױ�����.����ʯ��','NMHLBESYKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150783,'150783','����.���ױ�����.��������','NMHLBESZLTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150784,'150784','����.���ױ�����.���������','NMHLBESEEGNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150785,'150785','����.���ױ�����.������','NMHLBESGHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150800,'150800','����.�����׶���','NMBYNES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150802,'150802','����.�����׶���.�ٺ���','NMBYNESLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150821,'150821','����.�����׶���.��ԭ��','NMBYNESWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150822,'150822','����.�����׶���.�����','NMBYNESZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150823,'150823','����.�����׶���.������ǰ��','NMBYNESWLTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150824,'150824','����.�����׶���.����������','NMBYNESWLTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150825,'150825','����.�����׶���.�����غ���','NMBYNESWLTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150826,'150826','����.�����׶���.��������','NMBYNESHJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150900,'150900','����.�����첼��','NMWLCBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150902,'150902','����.�����첼��.������','NMWLCBSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150921,'150921','����.�����첼��.׿����','NMWLCBSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150922,'150922','����.�����첼��.������','NMWLCBSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150923,'150923','����.�����첼��.�̶���','NMWLCBSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150924,'150924','����.�����첼��.�˺���','NMWLCBSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150925,'150925','����.�����첼��.������','NMWLCBSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150926,'150926','����.�����첼��.���������ǰ��','NMWLCBSCHEYYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150927,'150927','����.�����첼��.�������������','NMWLCBSCHEYYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150928,'150928','����.�����첼��.������������','NMWLCBSCHEYYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150929,'150929','����.�����첼��.��������','NMWLCBSSZWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150981,'150981','����.�����첼��.������','NMWLCBSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152200,'152200','����.�˰���','NMXAM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152201,'152201','����.�˰���.����������','NMXAMWLHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152202,'152202','����.�˰���.����ɽ��','NMXAMAESS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152221,'152221','����.�˰���.�ƶ�������ǰ��','NMXAMKEQYYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152222,'152222','����.�˰���.�ƶ�����������','NMXAMKEQYYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152223,'152223','����.�˰���.��������','NMXAMZZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152224,'152224','����.�˰���.ͻȪ��','NMXAMTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152500,'152500','����.���ֹ�����','NMXLGLM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152501,'152501','����.���ֹ�����.����������','NMXLGLMELHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152502,'152502','����.���ֹ�����.���ֺ�����','NMXLGLMXLHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152522,'152522','����.���ֹ�����.���͸���','NMXLGLMABGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152523,'152523','����.���ֹ�����.����������','NMXLGLMSNTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152524,'152524','����.���ֹ�����.����������','NMXLGLMSNTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152525,'152525','����.���ֹ�����.������������','NMXLGLMDWZMQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152526,'152526','����.���ֹ�����.������������','NMXLGLMXWZMQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152527,'152527','����.���ֹ�����.̫������','NMXLGLMTPSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152528,'152528','����.���ֹ�����.�����','NMXLGLMXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152529,'152529','����.���ֹ�����.�������','NMXLGLMZXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152530,'152530','����.���ֹ�����.������','NMXLGLMZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152531,'152531','����.���ֹ�����.������','NMXLGLMDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152900,'152900','����.��������','NMALSM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152921,'152921','����.��������.����������','NMALSMALSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152922,'152922','����.��������.����������','NMALSMALSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152923,'152923','����.��������.�������','NMALSMEJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210100,'210100','����ʡ.������','LNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210102,'210102','����ʡ.������.��ƽ��','LNSSYSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210103,'210103','����ʡ.������.�����','LNSSYSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210104,'210104','����ʡ.������.����','LNSSYSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210105,'210105','����ʡ.������.�ʹ���','LNSSYSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210106,'210106','����ʡ.������.������','LNSSYSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210111,'210111','����ʡ.������.�ռ�����','LNSSYSSJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210112,'210112','����ʡ.������.������','LNSSYSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210113,'210113','����ʡ.������.������','LNSSYSSBXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210114,'210114','����ʡ.������.�ں���','LNSSYSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210122,'210122','����ʡ.������.������','LNSSYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210123,'210123','����ʡ.������.��ƽ��','LNSSYSKPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210124,'210124','����ʡ.������.������','LNSSYSFKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210181,'210181','����ʡ.������.������','LNSSYSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210200,'210200','����ʡ.������','LNSDLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210202,'210202','����ʡ.������.��ɽ��','LNSDLSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210203,'210203','����ʡ.������.������','LNSDLSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210204,'210204','����ʡ.������.ɳ�ӿ���','LNSDLSSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210211,'210211','����ʡ.������.�ʾ�����','LNSDLSGJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210212,'210212','����ʡ.������.��˳����','LNSDLSLSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210213,'210213','����ʡ.������.������','LNSDLSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210224,'210224','����ʡ.������.������','LNSDLSCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210281,'210281','����ʡ.������.�߷�����','LNSDLSWFDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210282,'210282','����ʡ.������.��������','LNSDLSPLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210283,'210283','����ʡ.������.ׯ����','LNSDLSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210300,'210300','����ʡ.��ɽ��','LNSASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210302,'210302','����ʡ.��ɽ��.������','LNSASSTDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210303,'210303','����ʡ.��ɽ��.������','LNSASSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210304,'210304','����ʡ.��ɽ��.��ɽ��','LNSASSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210311,'210311','����ʡ.��ɽ��.ǧɽ��','LNSASSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210321,'210321','����ʡ.��ɽ��.̨����','LNSASSTAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210323,'210323','����ʡ.��ɽ��.�������������','LNSASSZYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210381,'210381','����ʡ.��ɽ��.������','LNSASSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210400,'210400','����ʡ.��˳��','LNSFSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210402,'210402','����ʡ.��˳��.�¸���','LNSFSSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210403,'210403','����ʡ.��˳��.������','LNSFSSDZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210404,'210404','����ʡ.��˳��.������','LNSFSSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210411,'210411','����ʡ.��˳��.˳����','LNSFSSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210421,'210421','����ʡ.��˳��.��˳��','LNSFSSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210422,'210422','����ʡ.��˳��.�±�����������','LNSFSSXBMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210423,'210423','����ʡ.��˳��.��ԭ����������','LNSFSSQYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210500,'210500','����ʡ.��Ϫ��','LNSBXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210502,'210502','����ʡ.��Ϫ��.ƽɽ��','LNSBXSPSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210503,'210503','����ʡ.��Ϫ��.Ϫ����','LNSBXSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210504,'210504','����ʡ.��Ϫ��.��ɽ��','LNSBXSMSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210505,'210505','����ʡ.��Ϫ��.�Ϸ���','LNSBXSNFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210521,'210521','����ʡ.��Ϫ��.��Ϫ����������','LNSBXSBXMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210522,'210522','����ʡ.��Ϫ��.��������������','LNSBXSHRMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210600,'210600','����ʡ.������','LNSDDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210602,'210602','����ʡ.������.Ԫ����','LNSDDSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210603,'210603','����ʡ.������.������','LNSDDSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210604,'210604','����ʡ.������.����','LNSDDSZAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210624,'210624','����ʡ.������.�������������','LNSDDSKDMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210681,'210681','����ʡ.������.������','LNSDDSDGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210682,'210682','����ʡ.������.�����','LNSDDSFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210700,'210700','����ʡ.������','LNSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210702,'210702','����ʡ.������.������','LNSJZSGTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210703,'210703','����ʡ.������.�����','LNSJZSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210711,'210711','����ʡ.������.̫����','LNSJZSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210726,'210726','����ʡ.������.��ɽ��','LNSJZSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210727,'210727','����ʡ.������.����','LNSJZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210781,'210781','����ʡ.������.�躣��','LNSJZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210782,'210782','����ʡ.������.������','LNSJZSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210800,'210800','����ʡ.Ӫ����','LNSYKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210802,'210802','����ʡ.Ӫ����.վǰ��','LNSYKSZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210803,'210803','����ʡ.Ӫ����.������','LNSYKSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210804,'210804','����ʡ.Ӫ����.����Ȧ��','LNSYKSBYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210811,'210811','����ʡ.Ӫ����.�ϱ���','LNSYKSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210881,'210881','����ʡ.Ӫ����.������','LNSYKSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210882,'210882','����ʡ.Ӫ����.��ʯ����','LNSYKSDSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210900,'210900','����ʡ.������','LNSFXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210902,'210902','����ʡ.������.������','LNSFXSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210903,'210903','����ʡ.������.������','LNSFXSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210904,'210904','����ʡ.������.̫ƽ��','LNSFXSTPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210905,'210905','����ʡ.������.�������','LNSFXSQHMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210911,'210911','����ʡ.������.ϸ����','LNSFXSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210921,'210921','����ʡ.������.�����ɹ���������','LNSFXSFXMGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210922,'210922','����ʡ.������.������','LNSFXSZWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211000,'211000','����ʡ.������','LNSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211002,'211002','����ʡ.������.������','LNSLYSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211003,'211003','����ʡ.������.��ʥ��','LNSLYSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211004,'211004','����ʡ.������.��ΰ��','LNSLYSHWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211005,'211005','����ʡ.������.��������','LNSLYSGCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211011,'211011','����ʡ.������.̫�Ӻ���','LNSLYSTZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211021,'211021','����ʡ.������.������','LNSLYSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211081,'211081','����ʡ.������.������','LNSLYSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211100,'211100','����ʡ.�̽���','LNSPJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211102,'211102','����ʡ.�̽���.˫̨����','LNSPJSSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211103,'211103','����ʡ.�̽���.��¡̨��','LNSPJSXLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211121,'211121','����ʡ.�̽���.������','LNSPJSDWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211122,'211122','����ʡ.�̽���.��ɽ��','LNSPJSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211200,'211200','����ʡ.������','LNSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211202,'211202','����ʡ.������.������','LNSTLSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211204,'211204','����ʡ.������.�����','LNSTLSQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211221,'211221','����ʡ.������.������','LNSTLSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211223,'211223','����ʡ.������.������','LNSTLSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211224,'211224','����ʡ.������.��ͼ��','LNSTLSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211281,'211281','����ʡ.������.����ɽ��','LNSTLSDBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211282,'211282','����ʡ.������.��ԭ��','LNSTLSKYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211300,'211300','����ʡ.������','LNSCYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211302,'211302','����ʡ.������.˫����','LNSCYSSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211303,'211303','����ʡ.������.������','LNSCYSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211321,'211321','����ʡ.������.������','LNSCYSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211322,'211322','����ʡ.������.��ƽ��','LNSCYSJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211324,'211324','����ʡ.������.������������','LNSCYSKLQZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211381,'211381','����ʡ.������.��Ʊ��','LNSCYSBPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211382,'211382','����ʡ.������.��Դ��','LNSCYSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211400,'211400','����ʡ.��«����','LNSHLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211402,'211402','����ʡ.��«����.��ɽ��','LNSHLDSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211403,'211403','����ʡ.��«����.������','LNSHLDSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211404,'211404','����ʡ.��«����.��Ʊ��','LNSHLDSNPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211421,'211421','����ʡ.��«����.������','LNSHLDSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211422,'211422','����ʡ.��«����.������','LNSHLDSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211481,'211481','����ʡ.��«����.�˳���','LNSHLDSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220000,'220000','����ʡ','JLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220100,'220100','����ʡ.������','JLSCCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220102,'220102','����ʡ.������.�Ϲ���','JLSCCSNGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220103,'220103','����ʡ.������.�����','JLSCCSKCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220104,'220104','����ʡ.������.������','JLSCCSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220105,'220105','����ʡ.������.������','JLSCCSEDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220106,'220106','����ʡ.������.��԰��','JLSCCSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220112,'220112','����ʡ.������.˫����','JLSCCSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220122,'220122','����ʡ.������.ũ����','JLSCCSNAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220181,'220181','����ʡ.������.��̨��','JLSCCSJTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220182,'220182','����ʡ.������.������','JLSCCSYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220183,'220183','����ʡ.������.�»���','JLSCCSDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220200,'220200','����ʡ.������','JLSJLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220202,'220202','����ʡ.������.������','JLSJLSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220203,'220203','����ʡ.������.��̶��','JLSJLSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220204,'220204','����ʡ.������.��Ӫ��','JLSJLSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220211,'220211','����ʡ.������.������','JLSJLSFMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220221,'220221','����ʡ.������.������','JLSJLSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220281,'220281','����ʡ.������.�Ժ���','JLSJLSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220282,'220282','����ʡ.������.�����','JLSJLSZDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220283,'220283','����ʡ.������.������','JLSJLSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220284,'220284','����ʡ.������.��ʯ��','JLSJLSPSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220300,'220300','����ʡ.��ƽ��','JLSSPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220302,'220302','����ʡ.��ƽ��.������','JLSSPSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220303,'220303','����ʡ.��ƽ��.������','JLSSPSTDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220322,'220322','����ʡ.��ƽ��.������','JLSSPSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220323,'220323','����ʡ.��ƽ��.��ͨ����������','JLSSPSYTMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220381,'220381','����ʡ.��ƽ��.��������','JLSSPSGZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220382,'220382','����ʡ.��ƽ��.˫����','JLSSPSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220400,'220400','����ʡ.��Դ��','JLSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220402,'220402','����ʡ.��Դ��.��ɽ��','JLSLYSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220403,'220403','����ʡ.��Դ��.������','JLSLYSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220421,'220421','����ʡ.��Դ��.������','JLSLYSDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220422,'220422','����ʡ.��Դ��.������','JLSLYSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220500,'220500','����ʡ.ͨ����','JLSTHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220502,'220502','����ʡ.ͨ����.������','JLSTHSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220503,'220503','����ʡ.ͨ����.��������','JLSTHSEDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220521,'220521','����ʡ.ͨ����.ͨ����','JLSTHSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220523,'220523','����ʡ.ͨ����.������','JLSTHSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220524,'220524','����ʡ.ͨ����.������','JLSTHSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220581,'220581','����ʡ.ͨ����.÷�ӿ���','JLSTHSMHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220582,'220582','����ʡ.ͨ����.������','JLSTHSJAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220600,'220600','����ʡ.��ɽ��','JLSBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220602,'220602','����ʡ.��ɽ��.�˵�����','JLSBSSBDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220605,'220605','����ʡ.��ɽ��.��Դ��','JLSBSSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220621,'220621','����ʡ.��ɽ��.������','JLSBSSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220622,'220622','����ʡ.��ɽ��.������','JLSBSSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220623,'220623','����ʡ.��ɽ��.������','JLSBSSCBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220681,'220681','����ʡ.��ɽ��.�ٽ���','JLSBSSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220700,'220700','����ʡ.��ԭ��','JLSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220702,'220702','����ʡ.��ԭ��.������','JLSSYSNJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220721,'220721','����ʡ.��ԭ��.ǰ������˹��','JLSSYSQGELSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220722,'220722','����ʡ.��ԭ��.������','JLSSYSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220723,'220723','����ʡ.��ԭ��.Ǭ����','JLSSYSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220724,'220724','����ʡ.��ԭ��.������','JLSSYSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220800,'220800','����ʡ.�׳���','JLSBCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220802,'220802','����ʡ.�׳���.䬱���','JLSBCSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220821,'220821','����ʡ.�׳���.������','JLSBCSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220822,'220822','����ʡ.�׳���.ͨ����','JLSBCSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220881,'220881','����ʡ.�׳���.�����','JLSBCSZNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220882,'220882','����ʡ.�׳���.����','JLSBCSDAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222400,'222400','����ʡ.�ӱ߳�����������','JLSYBCXZZZZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222401,'222401','����ʡ.�ӱ߳�����������.�Ӽ���','JLSYBCXZZZZYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222402,'222402','����ʡ.�ӱ߳�����������.ͼ����','JLSYBCXZZZZTMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222403,'222403','����ʡ.�ӱ߳�����������.�ػ���','JLSYBCXZZZZDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222404,'222404','����ʡ.�ӱ߳�����������.������','JLSYBCXZZZZZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222405,'222405','����ʡ.�ӱ߳�����������.������','JLSYBCXZZZZLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222406,'222406','����ʡ.�ӱ߳�����������.������','JLSYBCXZZZZHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222424,'222424','����ʡ.�ӱ߳�����������.������','JLSYBCXZZZZWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222426,'222426','����ʡ.�ӱ߳�����������.��ͼ��','JLSYBCXZZZZATX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230000,'230000','������ʡ','HLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230100,'230100','������ʡ.��������','HLJSHEBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230102,'230102','������ʡ.��������.������','HLJSHEBSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230103,'230103','������ʡ.��������.�ϸ���','HLJSHEBSNGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230104,'230104','������ʡ.��������.������','HLJSHEBSDWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230108,'230108','������ʡ.��������.ƽ����','HLJSHEBSPFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230109,'230109','������ʡ.��������.�ɱ���','HLJSHEBSSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230110,'230110','������ʡ.��������.�㷻��','HLJSHEBSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230111,'230111','������ʡ.��������.������','HLJSHEBSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230112,'230112','������ʡ.��������.������','HLJSHEBSACQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230123,'230123','������ʡ.��������.������','HLJSHEBSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230124,'230124','������ʡ.��������.������','HLJSHEBSFZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230125,'230125','������ʡ.��������.����','HLJSHEBSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230126,'230126','������ʡ.��������.������','HLJSHEBSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230127,'230127','������ʡ.��������.ľ����','HLJSHEBSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230128,'230128','������ʡ.��������.ͨ����','HLJSHEBSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230129,'230129','������ʡ.��������.������','HLJSHEBSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230182,'230182','������ʡ.��������.˫����','HLJSHEBSSCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230183,'230183','������ʡ.��������.��־��','HLJSHEBSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230184,'230184','������ʡ.��������.�峣��','HLJSHEBSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230200,'230200','������ʡ.���������','HLJSQQHES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230202,'230202','������ʡ.���������.��ɳ��','HLJSQQHESLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230203,'230203','������ʡ.���������.������','HLJSQQHESJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230204,'230204','������ʡ.���������.������','HLJSQQHESTFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230205,'230205','������ʡ.���������.����Ϫ��','HLJSQQHESAAXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230206,'230206','������ʡ.���������.����������','HLJSQQHESFLEJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230207,'230207','������ʡ.���������.����ɽ��','HLJSQQHESNZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230208,'230208','������ʡ.���������.÷��˹��','HLJSQQHESMLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230221,'230221','������ʡ.���������.������','HLJSQQHESLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230223,'230223','������ʡ.���������.������','HLJSQQHESYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230224,'230224','������ʡ.���������.̩����','HLJSQQHESTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230225,'230225','������ʡ.���������.������','HLJSQQHESGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230227,'230227','������ʡ.���������.��ԣ��','HLJSQQHESFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230229,'230229','������ʡ.���������.��ɽ��','HLJSQQHESKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230230,'230230','������ʡ.���������.�˶���','HLJSQQHESKDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230231,'230231','������ʡ.���������.��Ȫ��','HLJSQQHESBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230281,'230281','������ʡ.���������.ګ����','HLJSQQHESZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230300,'230300','������ʡ.������','HLJSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230302,'230302','������ʡ.������.������','HLJSJXSJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230303,'230303','������ʡ.������.��ɽ��','HLJSJXSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230304,'230304','������ʡ.������.�ε���','HLJSJXSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230305,'230305','������ʡ.������.������','HLJSJXSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230306,'230306','������ʡ.������.���Ӻ���','HLJSJXSCZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230307,'230307','������ʡ.������.��ɽ��','HLJSJXSMSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230321,'230321','������ʡ.������.������','HLJSJXSJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230381,'230381','������ʡ.������.������','HLJSJXSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230382,'230382','������ʡ.������.��ɽ��','HLJSJXSMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230400,'230400','������ʡ.�׸���','HLJSHGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230402,'230402','������ʡ.�׸���.������','HLJSHGSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230403,'230403','������ʡ.�׸���.��ũ��','HLJSHGSGNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230404,'230404','������ʡ.�׸���.��ɽ��','HLJSHGSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230405,'230405','������ʡ.�׸���.�˰���','HLJSHGSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230406,'230406','������ʡ.�׸���.��ɽ��','HLJSHGSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230407,'230407','������ʡ.�׸���.��ɽ��','HLJSHGSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230421,'230421','������ʡ.�׸���.�ܱ���','HLJSHGSLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230422,'230422','������ʡ.�׸���.�����','HLJSHGSSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230500,'230500','������ʡ.˫Ѽɽ��','HLJSSYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230502,'230502','������ʡ.˫Ѽɽ��.��ɽ��','HLJSSYSSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230503,'230503','������ʡ.˫Ѽɽ��.�붫��','HLJSSYSSLDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230505,'230505','������ʡ.˫Ѽɽ��.�ķ�̨��','HLJSSYSSSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230506,'230506','������ʡ.˫Ѽɽ��.��ɽ��','HLJSSYSSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230521,'230521','������ʡ.˫Ѽɽ��.������','HLJSSYSSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230522,'230522','������ʡ.˫Ѽɽ��.������','HLJSSYSSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230523,'230523','������ʡ.˫Ѽɽ��.������','HLJSSYSSBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230524,'230524','������ʡ.˫Ѽɽ��.�ĺ���','HLJSSYSSRHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230600,'230600','������ʡ.������','HLJSDQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230602,'230602','������ʡ.������.����ͼ��','HLJSDQSSETQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230603,'230603','������ʡ.������.������','HLJSDQSLFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230604,'230604','������ʡ.������.�ú�·��','HLJSDQSRHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230605,'230605','������ʡ.������.�����','HLJSDQSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230606,'230606','������ʡ.������.��ͬ��','HLJSDQSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230621,'230621','������ʡ.������.������','HLJSDQSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230622,'230622','������ʡ.������.��Դ��','HLJSDQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230623,'230623','������ʡ.������.�ֵ���','HLJSDQSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230624,'230624','������ʡ.������.�Ŷ�������','HLJSDQSDEBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230700,'230700','������ʡ.������','HLJSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230702,'230702','������ʡ.������.������','HLJSYCSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230703,'230703','������ʡ.������.�ϲ���','HLJSYCSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230704,'230704','������ʡ.������.�Ѻ���','HLJSYCSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230705,'230705','������ʡ.������.������','HLJSYCSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230706,'230706','������ʡ.������.������','HLJSYCSCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230707,'230707','������ʡ.������.������','HLJSYCSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230708,'230708','������ʡ.������.��Ϫ��','HLJSYCSMXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230709,'230709','������ʡ.������.��ɽ����','HLJSYCSJSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230710,'230710','������ʡ.������.��Ӫ��','HLJSYCSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230711,'230711','������ʡ.������.�������','HLJSYCSWMHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230712,'230712','������ʡ.������.��������','HLJSYCSTWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230713,'230713','������ʡ.������.������','HLJSYCSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230714,'230714','������ʡ.������.��������','HLJSYCSWYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230715,'230715','������ʡ.������.������','HLJSYCSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230716,'230716','������ʡ.������.�ϸ�����','HLJSYCSSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230722,'230722','������ʡ.������.������','HLJSYCSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230781,'230781','������ʡ.������.������','HLJSYCSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230800,'230800','������ʡ.��ľ˹��','HLJSJMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230803,'230803','������ʡ.��ľ˹��.������','HLJSJMSSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230804,'230804','������ʡ.��ľ˹��.ǰ����','HLJSJMSSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230805,'230805','������ʡ.��ľ˹��.������','HLJSJMSSDFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230811,'230811','������ʡ.��ľ˹��.����','HLJSJMSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230822,'230822','������ʡ.��ľ˹��.������','HLJSJMSSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230826,'230826','������ʡ.��ľ˹��.�봨��','HLJSJMSSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230828,'230828','������ʡ.��ľ˹��.��ԭ��','HLJSJMSSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230833,'230833','������ʡ.��ľ˹��.��Զ��','HLJSJMSSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230881,'230881','������ʡ.��ľ˹��.ͬ����','HLJSJMSSTJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230882,'230882','������ʡ.��ľ˹��.������','HLJSJMSSFJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230900,'230900','������ʡ.��̨����','HLJSQTHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230902,'230902','������ʡ.��̨����.������','HLJSQTHSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230903,'230903','������ʡ.��̨����.��ɽ��','HLJSQTHSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230904,'230904','������ʡ.��̨����.���Ӻ���','HLJSQTHSQZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230921,'230921','������ʡ.��̨����.������','HLJSQTHSBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231000,'231000','������ʡ.ĵ������','HLJSMDJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231002,'231002','������ʡ.ĵ������.������','HLJSMDJSDAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231003,'231003','������ʡ.ĵ������.������','HLJSMDJSYMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231004,'231004','������ʡ.ĵ������.������','HLJSMDJSAMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231005,'231005','������ʡ.ĵ������.������','HLJSMDJSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231024,'231024','������ʡ.ĵ������.������','HLJSMDJSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231025,'231025','������ʡ.ĵ������.�ֿ���','HLJSMDJSLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231081,'231081','������ʡ.ĵ������.��Һ���','HLJSMDJSSFHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231083,'231083','������ʡ.ĵ������.������','HLJSMDJSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231084,'231084','������ʡ.ĵ������.������','HLJSMDJSNAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231085,'231085','������ʡ.ĵ������.������','HLJSMDJSMLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231100,'231100','������ʡ.�ں���','HLJSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231102,'231102','������ʡ.�ں���.������','HLJSHHSAHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231121,'231121','������ʡ.�ں���.�۽���','HLJSHHSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231123,'231123','������ʡ.�ں���.ѷ����','HLJSHHSXKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231124,'231124','������ʡ.�ں���.������','HLJSHHSSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231181,'231181','������ʡ.�ں���.������','HLJSHHSBAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231182,'231182','������ʡ.�ں���.���������','HLJSHHSWDLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231200,'231200','������ʡ.�绯��','HLJSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231202,'231202','������ʡ.�绯��.������','HLJSSHSBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231221,'231221','������ʡ.�绯��.������','HLJSSHSWKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231222,'231222','������ʡ.�绯��.������','HLJSSHSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231223,'231223','������ʡ.�绯��.�����','HLJSSHSQGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231224,'231224','������ʡ.�绯��.�찲��','HLJSSHSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231225,'231225','������ʡ.�绯��.��ˮ��','HLJSSHSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231226,'231226','������ʡ.�绯��.������','HLJSSHSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231281,'231281','������ʡ.�绯��.������','HLJSSHSADS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231282,'231282','������ʡ.�绯��.�ض���','HLJSSHSZDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231283,'231283','������ʡ.�绯��.������','HLJSSHSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232700,'232700','������ʡ.���˰������','HLJSDXALDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232721,'232721','������ʡ.���˰������.������','HLJSDXALDQHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232722,'232722','������ʡ.���˰������.������','HLJSDXALDQTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232723,'232723','������ʡ.���˰������.Į����','HLJSDXALDQMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310000,'310000','�Ϻ���','SHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310101,'310101','�Ϻ���.������','SHSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310103,'310103','�Ϻ���.¬����','SHSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310104,'310104','�Ϻ���.�����','SHSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310105,'310105','�Ϻ���.������','SHSCNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310106,'310106','�Ϻ���.������','SHSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310107,'310107','�Ϻ���.������','SHSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310108,'310108','�Ϻ���.բ����','SHSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310109,'310109','�Ϻ���.�����','SHSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310110,'310110','�Ϻ���.������','SHSYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310112,'310112','�Ϻ���.������','SHSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310113,'310113','�Ϻ���.��ɽ��','SHSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310114,'310114','�Ϻ���.�ζ���','SHSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310115,'310115','�Ϻ���.�ֶ�����','SHSPDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310116,'310116','�Ϻ���.��ɽ��','SHSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310117,'310117','�Ϻ���.�ɽ���','SHSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310118,'310118','�Ϻ���.������','SHSQPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310120,'310120','�Ϻ���.������','SHSFXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310230,'310230','�Ϻ���.������','SHSCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320000,'320000','����ʡ','JSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320100,'320100','����ʡ.�Ͼ���','JSSNJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320102,'320102','����ʡ.�Ͼ���.������','JSSNJSXWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320103,'320103','����ʡ.�Ͼ���.������','JSSNJSBXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320104,'320104','����ʡ.�Ͼ���.�ػ���','JSSNJSQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320105,'320105','����ʡ.�Ͼ���.������','JSSNJSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320106,'320106','����ʡ.�Ͼ���.��¥��','JSSNJSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320107,'320107','����ʡ.�Ͼ���.�¹���','JSSNJSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320111,'320111','����ʡ.�Ͼ���.�ֿ���','JSSNJSPKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320113,'320113','����ʡ.�Ͼ���.��ϼ��','JSSNJSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320114,'320114','����ʡ.�Ͼ���.�껨̨��','JSSNJSYHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320115,'320115','����ʡ.�Ͼ���.������','JSSNJSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320116,'320116','����ʡ.�Ͼ���.������','JSSNJSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320124,'320124','����ʡ.�Ͼ���.��ˮ��','JSSNJSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320125,'320125','����ʡ.�Ͼ���.�ߴ���','JSSNJSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320200,'320200','����ʡ.������','JSSWXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320202,'320202','����ʡ.������.�簲��','JSSWXSCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320203,'320203','����ʡ.������.�ϳ���','JSSWXSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320204,'320204','����ʡ.������.������','JSSWXSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320205,'320205','����ʡ.������.��ɽ��','JSSWXSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320206,'320206','����ʡ.������.��ɽ��','JSSWXSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320211,'320211','����ʡ.������.������','JSSWXSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320281,'320281','����ʡ.������.������','JSSWXSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320282,'320282','����ʡ.������.������','JSSWXSYXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320300,'320300','����ʡ.������','JSSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320302,'320302','����ʡ.������.��¥��','JSSXZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320303,'320303','����ʡ.������.������','JSSXZSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320304,'320304','����ʡ.������.������','JSSXZSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320305,'320305','����ʡ.������.������','JSSXZSJWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320311,'320311','����ʡ.������.Ȫɽ��','JSSXZSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320321,'320321','����ʡ.������.����','JSSXZSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320322,'320322','����ʡ.������.����','JSSXZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320323,'320323','����ʡ.������.ͭɽ��','JSSXZSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320324,'320324','����ʡ.������.�����','JSSXZSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320381,'320381','����ʡ.������.������','JSSXZSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320382,'320382','����ʡ.������.������','JSSXZSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320400,'320400','����ʡ.������','JSSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320402,'320402','����ʡ.������.������','JSSCZSTNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320404,'320404','����ʡ.������.��¥��','JSSCZSZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320405,'320405','����ʡ.������.��������','JSSCZSQSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320411,'320411','����ʡ.������.�±���','JSSCZSXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320412,'320412','����ʡ.������.�����','JSSCZSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320481,'320481','����ʡ.������.������','JSSCZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320482,'320482','����ʡ.������.��̳��','JSSCZSJTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320500,'320500','����ʡ.������','JSSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320502,'320502','����ʡ.������.������','JSSSZSCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320503,'320503','����ʡ.������.ƽ����','JSSSZSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320504,'320504','����ʡ.������.������','JSSSZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320505,'320505','����ʡ.������.������','JSSSZSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320506,'320506','����ʡ.������.������','JSSSZSWZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320507,'320507','����ʡ.������.�����','JSSSZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320581,'320581','����ʡ.������.������','JSSSZSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320582,'320582','����ʡ.������.�żҸ���','JSSSZSZJGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320583,'320583','����ʡ.������.��ɽ��','JSSSZSKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320584,'320584','����ʡ.������.�⽭��','JSSSZSWJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320585,'320585','����ʡ.������.̫����','JSSSZSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320600,'320600','����ʡ.��ͨ��','JSSNTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320602,'320602','����ʡ.��ͨ��.�紨��','JSSNTSCCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320611,'320611','����ʡ.��ͨ��.��բ��','JSSNTSGZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320612,'320612','����ʡ.��ͨ��.ͨ����','JSSNTSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320621,'320621','����ʡ.��ͨ��.������','JSSNTSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320623,'320623','����ʡ.��ͨ��.�綫��','JSSNTSRDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320681,'320681','����ʡ.��ͨ��.������','JSSNTSQDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320682,'320682','����ʡ.��ͨ��.�����','JSSNTSRGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320684,'320684','����ʡ.��ͨ��.������','JSSNTSHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320700,'320700','����ʡ.���Ƹ���','JSSLYGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320703,'320703','����ʡ.���Ƹ���.������','JSSLYGSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320705,'320705','����ʡ.���Ƹ���.������','JSSLYGSXPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320706,'320706','����ʡ.���Ƹ���.������','JSSLYGSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320721,'320721','����ʡ.���Ƹ���.������','JSSLYGSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320722,'320722','����ʡ.���Ƹ���.������','JSSLYGSDHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320723,'320723','����ʡ.���Ƹ���.������','JSSLYGSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320724,'320724','����ʡ.���Ƹ���.������','JSSLYGSGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320800,'320800','����ʡ.������','JSSHAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320802,'320802','����ʡ.������.�����','JSSHASQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320803,'320803','����ʡ.������.������','JSSHASCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320804,'320804','����ʡ.������.������','JSSHASHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320811,'320811','����ʡ.������.������','JSSHASQPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320826,'320826','����ʡ.������.��ˮ��','JSSHASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320829,'320829','����ʡ.������.������','JSSHASHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320830,'320830','����ʡ.������.������','JSSHASZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320831,'320831','����ʡ.������.�����','JSSHASJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320900,'320900','����ʡ.�γ���','JSSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320902,'320902','����ʡ.�γ���.ͤ����','JSSYCSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320903,'320903','����ʡ.�γ���.�ζ���','JSSYCSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320921,'320921','����ʡ.�γ���.��ˮ��','JSSYCSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320922,'320922','����ʡ.�γ���.������','JSSYCSBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320923,'320923','����ʡ.�γ���.������','JSSYCSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320924,'320924','����ʡ.�γ���.������','JSSYCSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320925,'320925','����ʡ.�γ���.������','JSSYCSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320981,'320981','����ʡ.�γ���.��̨��','JSSYCSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320982,'320982','����ʡ.�γ���.�����','JSSYCSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321000,'321000','����ʡ.������','JSSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321002,'321002','����ʡ.������.������','JSSYZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321003,'321003','����ʡ.������.������','JSSYZSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321011,'321011','����ʡ.������.ά����','JSSYZSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321023,'321023','����ʡ.������.��Ӧ��','JSSYZSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321081,'321081','����ʡ.������.������','JSSYZSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321084,'321084','����ʡ.������.������','JSSYZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321088,'321088','����ʡ.������.������','JSSYZSJDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321100,'321100','����ʡ.����','JSSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321102,'321102','����ʡ.����.������','JSSZJSJKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321111,'321111','����ʡ.����.������','JSSZJSRZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321112,'321112','����ʡ.����.��ͽ��','JSSZJSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321181,'321181','����ʡ.����.������','JSSZJSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321182,'321182','����ʡ.����.������','JSSZJSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321183,'321183','����ʡ.����.������','JSSZJSJRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321200,'321200','����ʡ.̩����','JSSTZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321202,'321202','����ʡ.̩����.������','JSSTZSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321203,'321203','����ʡ.̩����.�߸���','JSSTZSGGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321281,'321281','����ʡ.̩����.�˻���','JSSTZSXHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321282,'321282','����ʡ.̩����.������','JSSTZSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321283,'321283','����ʡ.̩����.̩����','JSSTZSTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321284,'321284','����ʡ.̩����.������','JSSTZSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321300,'321300','����ʡ.��Ǩ��','JSSSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321302,'321302','����ʡ.��Ǩ��.�޳���','JSSSQSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321311,'321311','����ʡ.��Ǩ��.��ԥ��','JSSSQSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321322,'321322','����ʡ.��Ǩ��.������','JSSSQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321323,'321323','����ʡ.��Ǩ��.������','JSSSQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321324,'321324','����ʡ.��Ǩ��.������','JSSSQSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330000,'330000','�㽭ʡ','ZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330100,'330100','�㽭ʡ.������','ZJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330102,'330102','�㽭ʡ.������.�ϳ���','ZJSHZSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330103,'330103','�㽭ʡ.������.�³���','ZJSHZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330104,'330104','�㽭ʡ.������.������','ZJSHZSJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330105,'330105','�㽭ʡ.������.������','ZJSHZSGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330106,'330106','�㽭ʡ.������.������','ZJSHZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330108,'330108','�㽭ʡ.������.������','ZJSHZSBJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330109,'330109','�㽭ʡ.������.��ɽ��','ZJSHZSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330110,'330110','�㽭ʡ.������.�ຼ��','ZJSHZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330122,'330122','�㽭ʡ.������.ͩ®��','ZJSHZSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330127,'330127','�㽭ʡ.������.������','ZJSHZSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330182,'330182','�㽭ʡ.������.������','ZJSHZSJDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330183,'330183','�㽭ʡ.������.������','ZJSHZSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330185,'330185','�㽭ʡ.������.�ٰ���','ZJSHZSLAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330200,'330200','�㽭ʡ.������','ZJSNBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330203,'330203','�㽭ʡ.������.������','ZJSNBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330204,'330204','�㽭ʡ.������.������','ZJSNBSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330205,'330205','�㽭ʡ.������.������','ZJSNBSJBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330206,'330206','�㽭ʡ.������.������','ZJSNBSBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330211,'330211','�㽭ʡ.������.����','ZJSNBSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330212,'330212','�㽭ʡ.������.۴����','ZJSNBSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330225,'330225','�㽭ʡ.������.��ɽ��','ZJSNBSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330226,'330226','�㽭ʡ.������.������','ZJSNBSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330281,'330281','�㽭ʡ.������.��Ҧ��','ZJSNBSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330282,'330282','�㽭ʡ.������.��Ϫ��','ZJSNBSCXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330283,'330283','�㽭ʡ.������.���','ZJSNBSFHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330300,'330300','�㽭ʡ.������','ZJSWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330302,'330302','�㽭ʡ.������.¹����','ZJSWZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330303,'330303','�㽭ʡ.������.������','ZJSWZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330304,'330304','�㽭ʡ.������.걺���','ZJSWZSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330322,'330322','�㽭ʡ.������.��ͷ��','ZJSWZSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330324,'330324','�㽭ʡ.������.������','ZJSWZSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330326,'330326','�㽭ʡ.������.ƽ����','ZJSWZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330327,'330327','�㽭ʡ.������.������','ZJSWZSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330328,'330328','�㽭ʡ.������.�ĳ���','ZJSWZSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330329,'330329','�㽭ʡ.������.̩˳��','ZJSWZSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330381,'330381','�㽭ʡ.������.����','ZJSWZSRAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330382,'330382','�㽭ʡ.������.������','ZJSWZSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330400,'330400','�㽭ʡ.������','ZJSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330402,'330402','�㽭ʡ.������.�Ϻ���','ZJSJXSNHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330411,'330411','�㽭ʡ.������.������','ZJSJXSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330421,'330421','�㽭ʡ.������.������','ZJSJXSJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330424,'330424','�㽭ʡ.������.������','ZJSJXSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330481,'330481','�㽭ʡ.������.������','ZJSJXSHNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330482,'330482','�㽭ʡ.������.ƽ����','ZJSJXSPHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330483,'330483','�㽭ʡ.������.ͩ����','ZJSJXSTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330500,'330500','�㽭ʡ.������','ZJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330502,'330502','�㽭ʡ.������.������','ZJSHZSWXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330503,'330503','�㽭ʡ.������.�����','ZJSHZSNZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330521,'330521','�㽭ʡ.������.������','ZJSHZSDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330522,'330522','�㽭ʡ.������.������','ZJSHZSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330523,'330523','�㽭ʡ.������.������','ZJSHZSAJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330600,'330600','�㽭ʡ.������','ZJSSXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330602,'330602','�㽭ʡ.������.Խ����','ZJSSXSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330621,'330621','�㽭ʡ.������.������','ZJSSXSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330624,'330624','�㽭ʡ.������.�²���','ZJSSXSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330681,'330681','�㽭ʡ.������.������','ZJSSXSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330682,'330682','�㽭ʡ.������.������','ZJSSXSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330683,'330683','�㽭ʡ.������.������','ZJSSXSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330700,'330700','�㽭ʡ.����','ZJSJHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330702,'330702','�㽭ʡ.����.�ĳ���','ZJSJHSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330703,'330703','�㽭ʡ.����.����','ZJSJHSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330723,'330723','�㽭ʡ.����.������','ZJSJHSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330726,'330726','�㽭ʡ.����.�ֽ���','ZJSJHSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330727,'330727','�㽭ʡ.����.�Ͱ���','ZJSJHSPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330781,'330781','�㽭ʡ.����.��Ϫ��','ZJSJHSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330782,'330782','�㽭ʡ.����.������','ZJSJHSYWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330783,'330783','�㽭ʡ.����.������','ZJSJHSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330784,'330784','�㽭ʡ.����.������','ZJSJHSYKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330800,'330800','�㽭ʡ.������','ZJSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330802,'330802','�㽭ʡ.������.�³���','ZJSZZSKCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330803,'330803','�㽭ʡ.������.�齭��','ZJSZZSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330822,'330822','�㽭ʡ.������.��ɽ��','ZJSZZSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330824,'330824','�㽭ʡ.������.������','ZJSZZSKHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330825,'330825','�㽭ʡ.������.������','ZJSZZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330881,'330881','�㽭ʡ.������.��ɽ��','ZJSZZSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330900,'330900','�㽭ʡ.��ɽ��','ZJSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330902,'330902','�㽭ʡ.��ɽ��.������','ZJSZSSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330903,'330903','�㽭ʡ.��ɽ��.������','ZJSZSSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330921,'330921','�㽭ʡ.��ɽ��.�ɽ��','ZJSZSSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330922,'330922','�㽭ʡ.��ɽ��.������','ZJSZSSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331000,'331000','�㽭ʡ.̨����','ZJSTZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331002,'331002','�㽭ʡ.̨����.������','ZJSTZSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331003,'331003','�㽭ʡ.̨����.������','ZJSTZSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331004,'331004','�㽭ʡ.̨����.·����','ZJSTZSLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331021,'331021','�㽭ʡ.̨����.����','ZJSTZSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331022,'331022','�㽭ʡ.̨����.������','ZJSTZSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331023,'331023','�㽭ʡ.̨����.��̨��','ZJSTZSTTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331024,'331024','�㽭ʡ.̨����.�ɾ���','ZJSTZSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331081,'331081','�㽭ʡ.̨����.������','ZJSTZSWLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331082,'331082','�㽭ʡ.̨����.�ٺ���','ZJSTZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331100,'331100','�㽭ʡ.��ˮ��','ZJSLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331102,'331102','�㽭ʡ.��ˮ��.������','ZJSLSSLDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331121,'331121','�㽭ʡ.��ˮ��.������','ZJSLSSQTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331122,'331122','�㽭ʡ.��ˮ��.������','ZJSLSSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331123,'331123','�㽭ʡ.��ˮ��.�����','ZJSLSSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331124,'331124','�㽭ʡ.��ˮ��.������','ZJSLSSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331125,'331125','�㽭ʡ.��ˮ��.�ƺ���','ZJSLSSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331126,'331126','�㽭ʡ.��ˮ��.��Ԫ��','ZJSLSSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331127,'331127','�㽭ʡ.��ˮ��.�������������','ZJSLSSJNZZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331181,'331181','�㽭ʡ.��ˮ��.��Ȫ��','ZJSLSSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340000,'340000','����ʡ','AHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340100,'340100','����ʡ.�Ϸ���','AHSHFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340102,'340102','����ʡ.�Ϸ���.������','AHSHFSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340103,'340103','����ʡ.�Ϸ���.®����','AHSHFSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340104,'340104','����ʡ.�Ϸ���.��ɽ��','AHSHFSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340111,'340111','����ʡ.�Ϸ���.������','AHSHFSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340121,'340121','����ʡ.�Ϸ���.������','AHSHFSCFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340122,'340122','����ʡ.�Ϸ���.�ʶ���','AHSHFSFDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340123,'340123','����ʡ.�Ϸ���.������','AHSHFSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340200,'340200','����ʡ.�ߺ���','AHSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340202,'340202','����ʡ.�ߺ���.������','AHSWHSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340203,'340203','����ʡ.�ߺ���.߮����','AHSWHSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340207,'340207','����ʡ.�ߺ���.𯽭��','AHSWHSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340208,'340208','����ʡ.�ߺ���.��ɽ��','AHSWHSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340221,'340221','����ʡ.�ߺ���.�ߺ���','AHSWHSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340222,'340222','����ʡ.�ߺ���.������','AHSWHSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340223,'340223','����ʡ.�ߺ���.������','AHSWHSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340300,'340300','����ʡ.������','AHSBBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340302,'340302','����ʡ.������.���Ӻ���','AHSBBSLZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340303,'340303','����ʡ.������.��ɽ��','AHSBBSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340304,'340304','����ʡ.������.�����','AHSBBSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340311,'340311','����ʡ.������.������','AHSBBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340321,'340321','����ʡ.������.��Զ��','AHSBBSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340322,'340322','����ʡ.������.�����','AHSBBSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340323,'340323','����ʡ.������.������','AHSBBSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340400,'340400','����ʡ.������','AHSHNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340402,'340402','����ʡ.������.��ͨ��','AHSHNSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340403,'340403','����ʡ.������.�������','AHSHNSTJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340404,'340404','����ʡ.������.л�Ҽ���','AHSHNSXJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340405,'340405','����ʡ.������.�˹�ɽ��','AHSHNSBGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340406,'340406','����ʡ.������.�˼���','AHSHNSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340421,'340421','����ʡ.������.��̨��','AHSHNSFTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340500,'340500','����ʡ.��ɽ��','AHSMASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340502,'340502','����ʡ.��ɽ��.���ׯ��','AHSMASSJJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340503,'340503','����ʡ.��ɽ��.��ɽ��','AHSMASSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340504,'340504','����ʡ.��ɽ��.��ɽ��','AHSMASSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340521,'340521','����ʡ.��ɽ��.��Ϳ��','AHSMASSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340600,'340600','����ʡ.������','AHSHBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340602,'340602','����ʡ.������.�ż���','AHSHBSDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340603,'340603','����ʡ.������.��ɽ��','AHSHBSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340604,'340604','����ʡ.������.��ɽ��','AHSHBSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340621,'340621','����ʡ.������.�Ϫ��','AHSHBSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340700,'340700','����ʡ.ͭ����','AHSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340702,'340702','����ʡ.ͭ����.ͭ��ɽ��','AHSTLSTGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340703,'340703','����ʡ.ͭ����.ʨ��ɽ��','AHSTLSSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340711,'340711','����ʡ.ͭ����.����','AHSTLSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340721,'340721','����ʡ.ͭ����.ͭ����','AHSTLSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340800,'340800','����ʡ.������','AHSAQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340802,'340802','����ʡ.������.ӭ����','AHSAQSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340803,'340803','����ʡ.������.�����','AHSAQSDGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340811,'340811','����ʡ.������.������','AHSAQSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340822,'340822','����ʡ.������.������','AHSAQSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340823,'340823','����ʡ.������.������','AHSAQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340824,'340824','����ʡ.������.Ǳɽ��','AHSAQSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340825,'340825','����ʡ.������.̫����','AHSAQSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340826,'340826','����ʡ.������.������','AHSAQSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340827,'340827','����ʡ.������.������','AHSAQSWJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340828,'340828','����ʡ.������.������','AHSAQSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340881,'340881','����ʡ.������.ͩ����','AHSAQSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341000,'341000','����ʡ.��ɽ��','AHSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341002,'341002','����ʡ.��ɽ��.��Ϫ��','AHSHSSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341003,'341003','����ʡ.��ɽ��.��ɽ��','AHSHSSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341004,'341004','����ʡ.��ɽ��.������','AHSHSSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341021,'341021','����ʡ.��ɽ��.���','AHSHSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341022,'341022','����ʡ.��ɽ��.������','AHSHSSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341023,'341023','����ʡ.��ɽ��.����','AHSHSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341024,'341024','����ʡ.��ɽ��.������','AHSHSSQMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341100,'341100','����ʡ.������','AHSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341102,'341102','����ʡ.������.������','AHSCZSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341103,'341103','����ʡ.������.������','AHSCZSNZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341122,'341122','����ʡ.������.������','AHSCZSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341124,'341124','����ʡ.������.ȫ����','AHSCZSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341125,'341125','����ʡ.������.��Զ��','AHSCZSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341126,'341126','����ʡ.������.������','AHSCZSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341181,'341181','����ʡ.������.�쳤��','AHSCZSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341182,'341182','����ʡ.������.������','AHSCZSMGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341200,'341200','����ʡ.������','AHSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341202,'341202','����ʡ.������.�����','AHSFYSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341203,'341203','����ʡ.������.򣶫��','AHSFYSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341204,'341204','����ʡ.������.�Ȫ��','AHSFYSZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341221,'341221','����ʡ.������.��Ȫ��','AHSFYSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341222,'341222','����ʡ.������.̫����','AHSFYSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341225,'341225','����ʡ.������.������','AHSFYSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341226,'341226','����ʡ.������.�����','AHSFYSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341282,'341282','����ʡ.������.������','AHSFYSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341300,'341300','����ʡ.������','AHSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341302,'341302','����ʡ.������.������','AHSSZSYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341321,'341321','����ʡ.������.�ɽ��','AHSSZSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341322,'341322','����ʡ.������.����','AHSSZSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341323,'341323','����ʡ.������.�����','AHSSZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341324,'341324','����ʡ.������.����','AHSSZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341400,'341400','����ʡ.������','AHSCHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341402,'341402','����ʡ.������.�ӳ���','AHSCHSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341421,'341421','����ʡ.������.®����','AHSCHSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341422,'341422','����ʡ.������.��Ϊ��','AHSCHSWWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341423,'341423','����ʡ.������.��ɽ��','AHSCHSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341424,'341424','����ʡ.������.����','AHSCHSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341500,'341500','����ʡ.������','AHSLAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341502,'341502','����ʡ.������.����','AHSLASJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341503,'341503','����ʡ.������.ԣ����','AHSLASYAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341521,'341521','����ʡ.������.����','AHSLASSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341522,'341522','����ʡ.������.������','AHSLASHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341523,'341523','����ʡ.������.�����','AHSLASSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341524,'341524','����ʡ.������.��կ��','AHSLASJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341525,'341525','����ʡ.������.��ɽ��','AHSLASHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341600,'341600','����ʡ.������','AHSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341602,'341602','����ʡ.������.�۳���','AHSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341621,'341621','����ʡ.������.������','AHSZZSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341622,'341622','����ʡ.������.�ɳ���','AHSZZSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341623,'341623','����ʡ.������.������','AHSZZSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341700,'341700','����ʡ.������','AHSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341702,'341702','����ʡ.������.�����','AHSCZSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341721,'341721','����ʡ.������.������','AHSCZSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341722,'341722','����ʡ.������.ʯ̨��','AHSCZSSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341723,'341723','����ʡ.������.������','AHSCZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341800,'341800','����ʡ.������','AHSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341802,'341802','����ʡ.������.������','AHSXCSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341821,'341821','����ʡ.������.��Ϫ��','AHSXCSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341822,'341822','����ʡ.������.�����','AHSXCSGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341823,'341823','����ʡ.������.����','AHSXCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341824,'341824','����ʡ.������.��Ϫ��','AHSXCSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341825,'341825','����ʡ.������.캵���','AHSXCSZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341881,'341881','����ʡ.������.������','AHSXCSNGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350000,'350000','����ʡ','FJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350100,'350100','����ʡ.������','FJSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350102,'350102','����ʡ.������.��¥��','FJSFZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350103,'350103','����ʡ.������.̨����','FJSFZSTJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350104,'350104','����ʡ.������.��ɽ��','FJSFZSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350105,'350105','����ʡ.������.��β��','FJSFZSMWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350111,'350111','����ʡ.������.������','FJSFZSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350121,'350121','����ʡ.������.������','FJSFZSMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350122,'350122','����ʡ.������.������','FJSFZSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350123,'350123','����ʡ.������.��Դ��','FJSFZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350124,'350124','����ʡ.������.������','FJSFZSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350125,'350125','����ʡ.������.��̩��','FJSFZSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350128,'350128','����ʡ.������.ƽ̶��','FJSFZSPTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350181,'350181','����ʡ.������.������','FJSFZSFQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350182,'350182','����ʡ.������.������','FJSFZSCLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350200,'350200','����ʡ.������','FJSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350203,'350203','����ʡ.������.˼����','FJSXMSSMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350205,'350205','����ʡ.������.������','FJSXMSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350206,'350206','����ʡ.������.������','FJSXMSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350211,'350211','����ʡ.������.������','FJSXMSJMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350212,'350212','����ʡ.������.ͬ����','FJSXMSTAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350213,'350213','����ʡ.������.�谲��','FJSXMSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350300,'350300','����ʡ.������','FJSPTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350302,'350302','����ʡ.������.������','FJSPTSCXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350303,'350303','����ʡ.������.������','FJSPTSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350304,'350304','����ʡ.������.�����','FJSPTSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350305,'350305','����ʡ.������.������','FJSPTSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350322,'350322','����ʡ.������.������','FJSPTSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350400,'350400','����ʡ.������','FJSSMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350402,'350402','����ʡ.������.÷����','FJSSMSMLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350403,'350403','����ʡ.������.��Ԫ��','FJSSMSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350421,'350421','����ʡ.������.��Ϫ��','FJSSMSMXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350423,'350423','����ʡ.������.������','FJSSMSQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350424,'350424','����ʡ.������.������','FJSSMSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350425,'350425','����ʡ.������.������','FJSSMSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350426,'350426','����ʡ.������.��Ϫ��','FJSSMSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350427,'350427','����ʡ.������.ɳ��','FJSSMSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350428,'350428','����ʡ.������.������','FJSSMSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350429,'350429','����ʡ.������.̩����','FJSSMSTNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350430,'350430','����ʡ.������.������','FJSSMSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350481,'350481','����ʡ.������.������','FJSSMSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350500,'350500','����ʡ.Ȫ����','FJSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350502,'350502','����ʡ.Ȫ����.�����','FJSQZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350503,'350503','����ʡ.Ȫ����.������','FJSQZSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350504,'350504','����ʡ.Ȫ����.�彭��','FJSQZSLJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350505,'350505','����ʡ.Ȫ����.Ȫ����','FJSQZSQGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350521,'350521','����ʡ.Ȫ����.�ݰ���','FJSQZSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350524,'350524','����ʡ.Ȫ����.��Ϫ��','FJSQZSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350525,'350525','����ʡ.Ȫ����.������','FJSQZSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350526,'350526','����ʡ.Ȫ����.�»���','FJSQZSDHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350527,'350527','����ʡ.Ȫ����.������','FJSQZSJMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350581,'350581','����ʡ.Ȫ����.ʯʨ��','FJSQZSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350582,'350582','����ʡ.Ȫ����.������','FJSQZSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350583,'350583','����ʡ.Ȫ����.�ϰ���','FJSQZSNAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350600,'350600','����ʡ.������','FJSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350602,'350602','����ʡ.������.ܼ����','FJSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350603,'350603','����ʡ.������.������','FJSZZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350622,'350622','����ʡ.������.������','FJSZZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350623,'350623','����ʡ.������.������','FJSZZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350624,'350624','����ʡ.������.گ����','FJSZZSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350625,'350625','����ʡ.������.��̩��','FJSZZSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350626,'350626','����ʡ.������.��ɽ��','FJSZZSDSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350627,'350627','����ʡ.������.�Ͼ���','FJSZZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350628,'350628','����ʡ.������.ƽ����','FJSZZSPHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350629,'350629','����ʡ.������.������','FJSZZSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350681,'350681','����ʡ.������.������','FJSZZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350700,'350700','����ʡ.��ƽ��','FJSNPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350702,'350702','����ʡ.��ƽ��.��ƽ��','FJSNPSYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350721,'350721','����ʡ.��ƽ��.˳����','FJSNPSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350722,'350722','����ʡ.��ƽ��.�ֳ���','FJSNPSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350723,'350723','����ʡ.��ƽ��.������','FJSNPSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350724,'350724','����ʡ.��ƽ��.��Ϫ��','FJSNPSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350725,'350725','����ʡ.��ƽ��.������','FJSNPSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350781,'350781','����ʡ.��ƽ��.������','FJSNPSSWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350782,'350782','����ʡ.��ƽ��.����ɽ��','FJSNPSWYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350783,'350783','����ʡ.��ƽ��.�����','FJSNPSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350784,'350784','����ʡ.��ƽ��.������','FJSNPSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350800,'350800','����ʡ.������','FJSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350802,'350802','����ʡ.������.������','FJSLYSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350821,'350821','����ʡ.������.��͡��','FJSLYSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350822,'350822','����ʡ.������.������','FJSLYSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350823,'350823','����ʡ.������.�Ϻ���','FJSLYSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350824,'350824','����ʡ.������.��ƽ��','FJSLYSWPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350825,'350825','����ʡ.������.������','FJSLYSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350881,'350881','����ʡ.������.��ƽ��','FJSLYSZPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350900,'350900','����ʡ.������','FJSNDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350902,'350902','����ʡ.������.������','FJSNDSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350921,'350921','����ʡ.������.ϼ����','FJSNDSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350922,'350922','����ʡ.������.������','FJSNDSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350923,'350923','����ʡ.������.������','FJSNDSPNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350924,'350924','����ʡ.������.������','FJSNDSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350925,'350925','����ʡ.������.������','FJSNDSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350926,'350926','����ʡ.������.������','FJSNDSZRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350981,'350981','����ʡ.������.������','FJSNDSFAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350982,'350982','����ʡ.������.������','FJSNDSFDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360000,'360000','����ʡ','JXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360100,'360100','����ʡ.�ϲ���','JXSNCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360102,'360102','����ʡ.�ϲ���.������','JXSNCSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360103,'360103','����ʡ.�ϲ���.������','JXSNCSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360104,'360104','����ʡ.�ϲ���.��������','JXSNCSQYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360105,'360105','����ʡ.�ϲ���.������','JXSNCSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360111,'360111','����ʡ.�ϲ���.��ɽ����','JXSNCSQSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360121,'360121','����ʡ.�ϲ���.�ϲ���','JXSNCSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360122,'360122','����ʡ.�ϲ���.�½���','JXSNCSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360123,'360123','����ʡ.�ϲ���.������','JXSNCSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360124,'360124','����ʡ.�ϲ���.������','JXSNCSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360200,'360200','����ʡ.��������','JXSJDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360202,'360202','����ʡ.��������.������','JXSJDZSCJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360203,'360203','����ʡ.��������.��ɽ��','JXSJDZSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360222,'360222','����ʡ.��������.������','JXSJDZSFLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360281,'360281','����ʡ.��������.��ƽ��','JXSJDZSLPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360300,'360300','����ʡ.Ƽ����','JXSPXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360302,'360302','����ʡ.Ƽ����.��Դ��','JXSPXSAYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360313,'360313','����ʡ.Ƽ����.�涫��','JXSPXSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360321,'360321','����ʡ.Ƽ����.������','JXSPXSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360322,'360322','����ʡ.Ƽ����.������','JXSPXSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360323,'360323','����ʡ.Ƽ����.«Ϫ��','JXSPXSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360400,'360400','����ʡ.�Ž���','JXSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360402,'360402','����ʡ.�Ž���.®ɽ��','JXSJJSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360403,'360403','����ʡ.�Ž���.�����','JXSJJSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360421,'360421','����ʡ.�Ž���.�Ž���','JXSJJSJJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360423,'360423','����ʡ.�Ž���.������','JXSJJSWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360424,'360424','����ʡ.�Ž���.��ˮ��','JXSJJSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360425,'360425','����ʡ.�Ž���.������','JXSJJSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360426,'360426','����ʡ.�Ž���.�°���','JXSJJSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360427,'360427','����ʡ.�Ž���.������','JXSJJSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360428,'360428','����ʡ.�Ž���.������','JXSJJSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360429,'360429','����ʡ.�Ž���.������','JXSJJSHKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360430,'360430','����ʡ.�Ž���.������','JXSJJSPZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360481,'360481','����ʡ.�Ž���.�����','JXSJJSRCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360500,'360500','����ʡ.������','JXSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360502,'360502','����ʡ.������.��ˮ��','JXSXYSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360521,'360521','����ʡ.������.������','JXSXYSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360600,'360600','����ʡ.ӥ̶��','JXSYTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360602,'360602','����ʡ.ӥ̶��.�º���','JXSYTSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360622,'360622','����ʡ.ӥ̶��.�཭��','JXSYTSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360681,'360681','����ʡ.ӥ̶��.��Ϫ��','JXSYTSGXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360700,'360700','����ʡ.������','JXSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360702,'360702','����ʡ.������.�¹���','JXSGZSZGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360721,'360721','����ʡ.������.����','JXSGZSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360722,'360722','����ʡ.������.�ŷ���','JXSGZSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360723,'360723','����ʡ.������.������','JXSGZSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360724,'360724','����ʡ.������.������','JXSGZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360725,'360725','����ʡ.������.������','JXSGZSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360726,'360726','����ʡ.������.��Զ��','JXSGZSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360727,'360727','����ʡ.������.������','JXSGZSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360728,'360728','����ʡ.������.������','JXSGZSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360729,'360729','����ʡ.������.ȫ����','JXSGZSQNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360730,'360730','����ʡ.������.������','JXSGZSNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360731,'360731','����ʡ.������.�ڶ���','JXSGZSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360732,'360732','����ʡ.������.�˹���','JXSGZSXGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360733,'360733','����ʡ.������.�����','JXSGZSHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360734,'360734','����ʡ.������.Ѱ����','JXSGZSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360735,'360735','����ʡ.������.ʯ����','JXSGZSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360781,'360781','����ʡ.������.�����','JXSGZSRJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360782,'360782','����ʡ.������.�Ͽ���','JXSGZSNKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360800,'360800','����ʡ.������','JXSJAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360802,'360802','����ʡ.������.������','JXSJASJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360803,'360803','����ʡ.������.��ԭ��','JXSJASQYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360821,'360821','����ʡ.������.������','JXSJASJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360822,'360822','����ʡ.������.��ˮ��','JXSJASJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360823,'360823','����ʡ.������.Ͽ����','JXSJASXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360824,'360824','����ʡ.������.�¸���','JXSJASXGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360825,'360825','����ʡ.������.������','JXSJASYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360826,'360826','����ʡ.������.̩����','JXSJASTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360827,'360827','����ʡ.������.�촨��','JXSJASSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360828,'360828','����ʡ.������.����','JXSJASWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360829,'360829','����ʡ.������.������','JXSJASAFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360830,'360830','����ʡ.������.������','JXSJASYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360881,'360881','����ʡ.������.����ɽ��','JXSJASJGSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360900,'360900','����ʡ.�˴���','JXSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360902,'360902','����ʡ.�˴���.Ԭ����','JXSYCSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360921,'360921','����ʡ.�˴���.������','JXSYCSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360922,'360922','����ʡ.�˴���.������','JXSYCSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360923,'360923','����ʡ.�˴���.�ϸ���','JXSYCSSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360924,'360924','����ʡ.�˴���.�˷���','JXSYCSYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360925,'360925','����ʡ.�˴���.������','JXSYCSJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360926,'360926','����ʡ.�˴���.ͭ����','JXSYCSTGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360981,'360981','����ʡ.�˴���.�����','JXSYCSFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360982,'360982','����ʡ.�˴���.������','JXSYCSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360983,'360983','����ʡ.�˴���.�߰���','JXSYCSGAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361000,'361000','����ʡ.������','JXSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361002,'361002','����ʡ.������.�ٴ���','JXSFZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361021,'361021','����ʡ.������.�ϳ���','JXSFZSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361022,'361022','����ʡ.������.�质��','JXSFZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361023,'361023','����ʡ.������.�Ϸ���','JXSFZSNFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361024,'361024','����ʡ.������.������','JXSFZSCRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361025,'361025','����ʡ.������.�ְ���','JXSFZSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361026,'361026','����ʡ.������.�˻���','JXSFZSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361027,'361027','����ʡ.������.��Ϫ��','JXSFZSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361028,'361028','����ʡ.������.��Ϫ��','JXSFZSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361029,'361029','����ʡ.������.������','JXSFZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361030,'361030','����ʡ.������.�����','JXSFZSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361100,'361100','����ʡ.������','JXSSRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361102,'361102','����ʡ.������.������','JXSSRSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361121,'361121','����ʡ.������.������','JXSSRSSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361122,'361122','����ʡ.������.�����','JXSSRSGFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361123,'361123','����ʡ.������.��ɽ��','JXSSRSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361124,'361124','����ʡ.������.Ǧɽ��','JXSSRSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361125,'361125','����ʡ.������.�����','JXSSRSHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361126,'361126','����ʡ.������.߮����','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361127,'361127','����ʡ.������.�����','JXSSRSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361128,'361128','����ʡ.������.۶����','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361129,'361129','����ʡ.������.������','JXSSRSWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361130,'361130','����ʡ.������.��Դ��','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361181,'361181','����ʡ.������.������','JXSSRSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370000,'370000','ɽ��ʡ','SDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370100,'370100','ɽ��ʡ.������','SDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370102,'370102','ɽ��ʡ.������.������','SDSJNSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370103,'370103','ɽ��ʡ.������.������','SDSJNSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370104,'370104','ɽ��ʡ.������.������','SDSJNSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370105,'370105','ɽ��ʡ.������.������','SDSJNSTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370112,'370112','ɽ��ʡ.������.������','SDSJNSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370113,'370113','ɽ��ʡ.������.������','SDSJNSCQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370124,'370124','ɽ��ʡ.������.ƽ����','SDSJNSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370125,'370125','ɽ��ʡ.������.������','SDSJNSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370126,'370126','ɽ��ʡ.������.�̺���','SDSJNSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370181,'370181','ɽ��ʡ.������.������','SDSJNSZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370200,'370200','ɽ��ʡ.�ൺ��','SDSQDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370202,'370202','ɽ��ʡ.�ൺ��.������','SDSQDSSNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370203,'370203','ɽ��ʡ.�ൺ��.�б���','SDSQDSSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370205,'370205','ɽ��ʡ.�ൺ��.�ķ���','SDSQDSSFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370211,'370211','ɽ��ʡ.�ൺ��.�Ƶ���','SDSQDSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370212,'370212','ɽ��ʡ.�ൺ��.��ɽ��','SDSQDSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370213,'370213','ɽ��ʡ.�ൺ��.�����','SDSQDSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370214,'370214','ɽ��ʡ.�ൺ��.������','SDSQDSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370281,'370281','ɽ��ʡ.�ൺ��.������','SDSQDSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370282,'370282','ɽ��ʡ.�ൺ��.��ī��','SDSQDSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370283,'370283','ɽ��ʡ.�ൺ��.ƽ����','SDSQDSPDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370284,'370284','ɽ��ʡ.�ൺ��.������','SDSQDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370285,'370285','ɽ��ʡ.�ൺ��.������','SDSQDSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370300,'370300','ɽ��ʡ.�Ͳ���','SDSZBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370302,'370302','ɽ��ʡ.�Ͳ���.�ʹ���','SDSZBSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370303,'370303','ɽ��ʡ.�Ͳ���.�ŵ���','SDSZBSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370304,'370304','ɽ��ʡ.�Ͳ���.��ɽ��','SDSZBSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370305,'370305','ɽ��ʡ.�Ͳ���.������','SDSZBSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370306,'370306','ɽ��ʡ.�Ͳ���.�ܴ���','SDSZBSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370321,'370321','ɽ��ʡ.�Ͳ���.��̨��','SDSZBSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370322,'370322','ɽ��ʡ.�Ͳ���.������','SDSZBSGQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370323,'370323','ɽ��ʡ.�Ͳ���.��Դ��','SDSZBSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370400,'370400','ɽ��ʡ.��ׯ��','SDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370402,'370402','ɽ��ʡ.��ׯ��.������','SDSZZSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370403,'370403','ɽ��ʡ.��ׯ��.Ѧ����','SDSZZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370404,'370404','ɽ��ʡ.��ׯ��.ỳ���','SDSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370405,'370405','ɽ��ʡ.��ׯ��.̨��ׯ��','SDSZZSTEZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370406,'370406','ɽ��ʡ.��ׯ��.ɽͤ��','SDSZZSSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370481,'370481','ɽ��ʡ.��ׯ��.������','SDSZZSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370500,'370500','ɽ��ʡ.��Ӫ��','SDSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370502,'370502','ɽ��ʡ.��Ӫ��.��Ӫ��','SDSDYSDYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370503,'370503','ɽ��ʡ.��Ӫ��.�ӿ���','SDSDYSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370521,'370521','ɽ��ʡ.��Ӫ��.������','SDSDYSKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370522,'370522','ɽ��ʡ.��Ӫ��.������','SDSDYSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370523,'370523','ɽ��ʡ.��Ӫ��.������','SDSDYSGRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370600,'370600','ɽ��ʡ.��̨��','SDSYTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370602,'370602','ɽ��ʡ.��̨��.֥���','SDSYTSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370611,'370611','ɽ��ʡ.��̨��.��ɽ��','SDSYTSFSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370612,'370612','ɽ��ʡ.��̨��.Ĳƽ��','SDSYTSMPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370613,'370613','ɽ��ʡ.��̨��.��ɽ��','SDSYTSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370634,'370634','ɽ��ʡ.��̨��.������','SDSYTSCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370681,'370681','ɽ��ʡ.��̨��.������','SDSYTSLKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370682,'370682','ɽ��ʡ.��̨��.������','SDSYTSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370683,'370683','ɽ��ʡ.��̨��.������','SDSYTSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370684,'370684','ɽ��ʡ.��̨��.������','SDSYTSPLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370685,'370685','ɽ��ʡ.��̨��.��Զ��','SDSYTSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370686,'370686','ɽ��ʡ.��̨��.��ϼ��','SDSYTSQXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370687,'370687','ɽ��ʡ.��̨��.������','SDSYTSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370700,'370700','ɽ��ʡ.Ϋ����','SDSWFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370702,'370702','ɽ��ʡ.Ϋ����.Ϋ����','SDSWFSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370703,'370703','ɽ��ʡ.Ϋ����.��ͤ��','SDSWFSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370704,'370704','ɽ��ʡ.Ϋ����.������','SDSWFSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370705,'370705','ɽ��ʡ.Ϋ����.������','SDSWFSKWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370724,'370724','ɽ��ʡ.Ϋ����.������','SDSWFSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370725,'370725','ɽ��ʡ.Ϋ����.������','SDSWFSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370781,'370781','ɽ��ʡ.Ϋ����.������','SDSWFSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370782,'370782','ɽ��ʡ.Ϋ����.�����','SDSWFSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370783,'370783','ɽ��ʡ.Ϋ����.�ٹ���','SDSWFSSGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370784,'370784','ɽ��ʡ.Ϋ����.������','SDSWFSAQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370785,'370785','ɽ��ʡ.Ϋ����.������','SDSWFSGMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370786,'370786','ɽ��ʡ.Ϋ����.������','SDSWFSCYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370800,'370800','ɽ��ʡ.������','SDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370802,'370802','ɽ��ʡ.������.������','SDSJNSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370811,'370811','ɽ��ʡ.������.�γ���','SDSJNSRCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370826,'370826','ɽ��ʡ.������.΢ɽ��','SDSJNSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370827,'370827','ɽ��ʡ.������.��̨��','SDSJNSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370828,'370828','ɽ��ʡ.������.������','SDSJNSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370829,'370829','ɽ��ʡ.������.������','SDSJNSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370830,'370830','ɽ��ʡ.������.������','SDSJNSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370831,'370831','ɽ��ʡ.������.��ˮ��','SDSJNSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370832,'370832','ɽ��ʡ.������.��ɽ��','SDSJNSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370881,'370881','ɽ��ʡ.������.������','SDSJNSQFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370882,'370882','ɽ��ʡ.������.������','SDSJNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370883,'370883','ɽ��ʡ.������.�޳���','SDSJNSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370900,'370900','ɽ��ʡ.̩����','SDSTAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370902,'370902','ɽ��ʡ.̩����.̩ɽ��','SDSTASTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370911,'370911','ɽ��ʡ.̩����.�����','SDSTASZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370921,'370921','ɽ��ʡ.̩����.������','SDSTASNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370923,'370923','ɽ��ʡ.̩����.��ƽ��','SDSTASDPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370982,'370982','ɽ��ʡ.̩����.��̩��','SDSTASXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370983,'370983','ɽ��ʡ.̩����.�ʳ���','SDSTASFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371000,'371000','ɽ��ʡ.������','SDSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371002,'371002','ɽ��ʡ.������.������','SDSWHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371081,'371081','ɽ��ʡ.������.�ĵ���','SDSWHSWDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371082,'371082','ɽ��ʡ.������.�ٳ���','SDSWHSRCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371083,'371083','ɽ��ʡ.������.��ɽ��','SDSWHSRSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371100,'371100','ɽ��ʡ.������','SDSRZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371102,'371102','ɽ��ʡ.������.������','SDSRZSDGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371103,'371103','ɽ��ʡ.������.�ɽ��','SDSRZSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371121,'371121','ɽ��ʡ.������.������','SDSRZSWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371122,'371122','ɽ��ʡ.������.����','SDSRZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371200,'371200','ɽ��ʡ.������','SDSLWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371202,'371202','ɽ��ʡ.������.������','SDSLWSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371203,'371203','ɽ��ʡ.������.�ֳ���','SDSLWSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371300,'371300','ɽ��ʡ.������','SDSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371302,'371302','ɽ��ʡ.������.��ɽ��','SDSLYSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371311,'371311','ɽ��ʡ.������.��ׯ��','SDSLYSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371312,'371312','ɽ��ʡ.������.�Ӷ���','SDSLYSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371321,'371321','ɽ��ʡ.������.������','SDSLYSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371322,'371322','ɽ��ʡ.������.۰����','SDSLYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371323,'371323','ɽ��ʡ.������.��ˮ��','SDSLYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371324,'371324','ɽ��ʡ.������.��ɽ��','SDSLYSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371325,'371325','ɽ��ʡ.������.����','SDSLYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371326,'371326','ɽ��ʡ.������.ƽ����','SDSLYSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371327,'371327','ɽ��ʡ.������.������','SDSLYSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371328,'371328','ɽ��ʡ.������.������','SDSLYSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371329,'371329','ɽ��ʡ.������.������','SDSLYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371400,'371400','ɽ��ʡ.������','SDSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371402,'371402','ɽ��ʡ.������.�³���','SDSDZSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371421,'371421','ɽ��ʡ.������.����','SDSDZSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371422,'371422','ɽ��ʡ.������.������','SDSDZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371423,'371423','ɽ��ʡ.������.������','SDSDZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371424,'371424','ɽ��ʡ.������.������','SDSDZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371425,'371425','ɽ��ʡ.������.�����','SDSDZSQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371426,'371426','ɽ��ʡ.������.ƽԭ��','SDSDZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371427,'371427','ɽ��ʡ.������.�Ľ���','SDSDZSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371428,'371428','ɽ��ʡ.������.�����','SDSDZSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371481,'371481','ɽ��ʡ.������.������','SDSDZSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371482,'371482','ɽ��ʡ.������.�����','SDSDZSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371500,'371500','ɽ��ʡ.�ĳ���','SDSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371502,'371502','ɽ��ʡ.�ĳ���.��������','SDSLCSDCFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371521,'371521','ɽ��ʡ.�ĳ���.������','SDSLCSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371522,'371522','ɽ��ʡ.�ĳ���.ݷ��','SDSLCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371523,'371523','ɽ��ʡ.�ĳ���.��ƽ��','SDSLCSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371524,'371524','ɽ��ʡ.�ĳ���.������','SDSLCSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371525,'371525','ɽ��ʡ.�ĳ���.����','SDSLCSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371526,'371526','ɽ��ʡ.�ĳ���.������','SDSLCSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371581,'371581','ɽ��ʡ.�ĳ���.������','SDSLCSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371600,'371600','ɽ��ʡ.������','SDSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371602,'371602','ɽ��ʡ.������.������','SDSBZSBCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371621,'371621','ɽ��ʡ.������.������','SDSBZSHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371622,'371622','ɽ��ʡ.������.������','SDSBZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371623,'371623','ɽ��ʡ.������.�����','SDSBZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371624,'371624','ɽ��ʡ.������.մ����','SDSBZSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371625,'371625','ɽ��ʡ.������.������','SDSBZSBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371626,'371626','ɽ��ʡ.������.��ƽ��','SDSBZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371700,'371700','ɽ��ʡ.������','SDSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371702,'371702','ɽ��ʡ.������.ĵ����','SDSHZSMDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371721,'371721','ɽ��ʡ.������.����','SDSHZSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371722,'371722','ɽ��ʡ.������.����','SDSHZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371723,'371723','ɽ��ʡ.������.������','SDSHZSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371724,'371724','ɽ��ʡ.������.��Ұ��','SDSHZSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371725,'371725','ɽ��ʡ.������.۩����','SDSHZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371726,'371726','ɽ��ʡ.������.۲����','SDSHZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371727,'371727','ɽ��ʡ.������.������','SDSHZSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371728,'371728','ɽ��ʡ.������.������','SDSHZSDMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410000,'410000','����ʡ','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410100,'410100','����ʡ.֣����','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410102,'410102','����ʡ.֣����.��ԭ��','HNSZZSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410103,'410103','����ʡ.֣����.������','HNSZZSEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410104,'410104','����ʡ.֣����.�ܳǻ�����','HNSZZSGCHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410105,'410105','����ʡ.֣����.��ˮ��','HNSZZSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410106,'410106','����ʡ.֣����.�Ͻ���','HNSZZSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410108,'410108','����ʡ.֣����.�ݼ���','HNSZZSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410122,'410122','����ʡ.֣����.��Ĳ��','HNSZZSZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410181,'410181','����ʡ.֣����.������','HNSZZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410182,'410182','����ʡ.֣����.������','HNSZZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410183,'410183','����ʡ.֣����.������','HNSZZSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410184,'410184','����ʡ.֣����.��֣��','HNSZZSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410185,'410185','����ʡ.֣����.�Ƿ���','HNSZZSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410200,'410200','����ʡ.������','HNSKFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410202,'410202','����ʡ.������.��ͤ��','HNSKFSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410203,'410203','����ʡ.������.˳�ӻ�����','HNSKFSSHHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410204,'410204','����ʡ.������.��¥��','HNSKFSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410205,'410205','����ʡ.������.����̨��','HNSKFSYWTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410211,'410211','����ʡ.������.������','HNSKFSJMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410221,'410221','����ʡ.������.���','HNSKFSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410222,'410222','����ʡ.������.ͨ����','HNSKFSTXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410223,'410223','����ʡ.������.ξ����','HNSKFSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410224,'410224','����ʡ.������.������','HNSKFSKFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410225,'410225','����ʡ.������.������','HNSKFSLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410300,'410300','����ʡ.������','HNSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410302,'410302','����ʡ.������.�ϳ���','HNSLYSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410303,'410303','����ʡ.������.������','HNSLYSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410304,'410304','����ʡ.������.�e�ӻ�����','HNSLYSCHHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410305,'410305','����ʡ.������.������','HNSLYSJXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410306,'410306','����ʡ.������.������','HNSLYSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410311,'410311','����ʡ.������.������','HNSLYSLLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410322,'410322','����ʡ.������.�Ͻ���','HNSLYSMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410323,'410323','����ʡ.������.�°���','HNSLYSXAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410324,'410324','����ʡ.������.�ﴨ��','HNSLYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410325,'410325','����ʡ.������.����','HNSLYSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410326,'410326','����ʡ.������.������','HNSLYSRYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410327,'410327','����ʡ.������.������','HNSLYSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410328,'410328','����ʡ.������.������','HNSLYSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410329,'410329','����ʡ.������.������','HNSLYSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410381,'410381','����ʡ.������.��ʦ��','HNSLYSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410400,'410400','����ʡ.ƽ��ɽ��','HNSPDSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410402,'410402','����ʡ.ƽ��ɽ��.�»���','HNSPDSSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410403,'410403','����ʡ.ƽ��ɽ��.������','HNSPDSSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410404,'410404','����ʡ.ƽ��ɽ��.ʯ����','HNSPDSSSLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410411,'410411','����ʡ.ƽ��ɽ��.տ����','HNSPDSSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410421,'410421','����ʡ.ƽ��ɽ��.������','HNSPDSSBFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410422,'410422','����ʡ.ƽ��ɽ��.Ҷ��','HNSPDSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410423,'410423','����ʡ.ƽ��ɽ��.³ɽ��','HNSPDSSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410425,'410425','����ʡ.ƽ��ɽ��.ۣ��','HNSPDSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410481,'410481','����ʡ.ƽ��ɽ��.�����','HNSPDSSWGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410482,'410482','����ʡ.ƽ��ɽ��.������','HNSPDSSRZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410500,'410500','����ʡ.������','HNSAYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410502,'410502','����ʡ.������.�ķ���','HNSAYSWFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410503,'410503','����ʡ.������.������','HNSAYSBGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410505,'410505','����ʡ.������.����','HNSAYSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410506,'410506','����ʡ.������.������','HNSAYSLAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410522,'410522','����ʡ.������.������','HNSAYSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410523,'410523','����ʡ.������.������','HNSAYSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410526,'410526','����ʡ.������.����','HNSAYSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410527,'410527','����ʡ.������.�ڻ���','HNSAYSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410581,'410581','����ʡ.������.������','HNSAYSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410600,'410600','����ʡ.�ױ���','HNSHBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410602,'410602','����ʡ.�ױ���.��ɽ��','HNSHBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410603,'410603','����ʡ.�ױ���.ɽ����','HNSHBSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410611,'410611','����ʡ.�ױ���.俱���','HNSHBSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410621,'410621','����ʡ.�ױ���.����','HNSHBSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410622,'410622','����ʡ.�ױ���.���','HNSHBSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410700,'410700','����ʡ.������','HNSXXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410702,'410702','����ʡ.������.������','HNSXXSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410703,'410703','����ʡ.������.������','HNSXXSWBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410704,'410704','����ʡ.������.��Ȫ��','HNSXXSFQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410711,'410711','����ʡ.������.��Ұ��','HNSXXSMYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410721,'410721','����ʡ.������.������','HNSXXSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410724,'410724','����ʡ.������.�����','HNSXXSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410725,'410725','����ʡ.������.ԭ����','HNSXXSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410726,'410726','����ʡ.������.�ӽ���','HNSXXSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410727,'410727','����ʡ.������.������','HNSXXSFQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410728,'410728','����ʡ.������.��ԫ��','HNSXXSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410781,'410781','����ʡ.������.������','HNSXXSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410782,'410782','����ʡ.������.������','HNSXXSHXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410800,'410800','����ʡ.������','HNSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410802,'410802','����ʡ.������.�����','HNSJZSJFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410803,'410803','����ʡ.������.��վ��','HNSJZSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410804,'410804','����ʡ.������.�����','HNSJZSMCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410811,'410811','����ʡ.������.ɽ����','HNSJZSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410821,'410821','����ʡ.������.������','HNSJZSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410822,'410822','����ʡ.������.������','HNSJZSBAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410823,'410823','����ʡ.������.������','HNSJZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410825,'410825','����ʡ.������.����','HNSJZSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410882,'410882','����ʡ.������.������','HNSJZSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410883,'410883','����ʡ.������.������','HNSJZSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410900,'410900','����ʡ.�����','HNSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410902,'410902','����ʡ.�����.������','HNSZYSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410922,'410922','����ʡ.�����.�����','HNSZYSQFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410923,'410923','����ʡ.�����.������','HNSZYSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410926,'410926','����ʡ.�����.����','HNSZYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410927,'410927','����ʡ.�����.̨ǰ��','HNSZYSTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410928,'410928','����ʡ.�����.�����','HNSZYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411000,'411000','����ʡ.�����','HNSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411002,'411002','����ʡ.�����.κ����','HNSXCSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411023,'411023','����ʡ.�����.�����','HNSXCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411024,'411024','����ʡ.�����.۳����','HNSXCSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411025,'411025','����ʡ.�����.�����','HNSXCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411081,'411081','����ʡ.�����.������','HNSXCSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411082,'411082','����ʡ.�����.������','HNSXCSCGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411100,'411100','����ʡ.�����','HNSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411102,'411102','����ʡ.�����.Դ����','HNSZHSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411103,'411103','����ʡ.�����.۱����','HNSZHSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411104,'411104','����ʡ.�����.������','HNSZHSZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411121,'411121','����ʡ.�����.������','HNSZHSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411122,'411122','����ʡ.�����.�����','HNSZHSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411200,'411200','����ʡ.����Ͽ��','HNSSMXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411202,'411202','����ʡ.����Ͽ��.������','HNSSMXSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411221,'411221','����ʡ.����Ͽ��.�ų���','HNSSMXSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411222,'411222','����ʡ.����Ͽ��.����','HNSSMXSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411224,'411224','����ʡ.����Ͽ��.¬����','HNSSMXSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411281,'411281','����ʡ.����Ͽ��.������','HNSSMXSYMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411282,'411282','����ʡ.����Ͽ��.�鱦��','HNSSMXSLBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411300,'411300','����ʡ.������','HNSNYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411302,'411302','����ʡ.������.�����','HNSNYSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411303,'411303','����ʡ.������.������','HNSNYSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411321,'411321','����ʡ.������.������','HNSNYSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411322,'411322','����ʡ.������.������','HNSNYSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411323,'411323','����ʡ.������.��Ͽ��','HNSNYSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411324,'411324','����ʡ.������.��ƽ��','HNSNYSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411325,'411325','����ʡ.������.������','HNSNYSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411326,'411326','����ʡ.������.������','HNSNYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411327,'411327','����ʡ.������.������','HNSNYSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411328,'411328','����ʡ.������.�ƺ���','HNSNYSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411329,'411329','����ʡ.������.��Ұ��','HNSNYSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411330,'411330','����ʡ.������.ͩ����','HNSNYSTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411381,'411381','����ʡ.������.������','HNSNYSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411400,'411400','����ʡ.������','HNSSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411402,'411402','����ʡ.������.��԰��','HNSSQSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411403,'411403','����ʡ.������.�����','HNSSQSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411421,'411421','����ʡ.������.��Ȩ��','HNSSQSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411422,'411422','����ʡ.������.���','HNSSQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411423,'411423','����ʡ.������.������','HNSSQSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411424,'411424','����ʡ.������.�ϳ���','HNSSQSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411425,'411425','����ʡ.������.�ݳ���','HNSSQSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411426,'411426','����ʡ.������.������','HNSSQSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411481,'411481','����ʡ.������.������','HNSSQSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411500,'411500','����ʡ.������','HNSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411502,'411502','����ʡ.������.������','HNSXYSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411503,'411503','����ʡ.������.ƽ����','HNSXYSPQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411521,'411521','����ʡ.������.��ɽ��','HNSXYSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411522,'411522','����ʡ.������.��ɽ��','HNSXYSGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411523,'411523','����ʡ.������.����','HNSXYSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411524,'411524','����ʡ.������.�̳���','HNSXYSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411525,'411525','����ʡ.������.��ʼ��','HNSXYSGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411526,'411526','����ʡ.������.�괨��','HNSXYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411527,'411527','����ʡ.������.������','HNSXYSHBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411528,'411528','����ʡ.������.Ϣ��','HNSXYSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411600,'411600','����ʡ.�ܿ���','HNSZKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411602,'411602','����ʡ.�ܿ���.������','HNSZKSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411621,'411621','����ʡ.�ܿ���.������','HNSZKSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411622,'411622','����ʡ.�ܿ���.������','HNSZKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411623,'411623','����ʡ.�ܿ���.��ˮ��','HNSZKSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411624,'411624','����ʡ.�ܿ���.������','HNSZKSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411625,'411625','����ʡ.�ܿ���.������','HNSZKSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411626,'411626','����ʡ.�ܿ���.������','HNSZKSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411627,'411627','����ʡ.�ܿ���.̫����','HNSZKSTKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411628,'411628','����ʡ.�ܿ���.¹����','HNSZKSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411681,'411681','����ʡ.�ܿ���.�����','HNSZKSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411700,'411700','����ʡ.פ�����','HNSZMDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411702,'411702','����ʡ.פ�����.�����','HNSZMDSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411721,'411721','����ʡ.פ�����.��ƽ��','HNSZMDSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411722,'411722','����ʡ.פ�����.�ϲ���','HNSZMDSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411723,'411723','����ʡ.פ�����.ƽ����','HNSZMDSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411724,'411724','����ʡ.פ�����.������','HNSZMDSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411725,'411725','����ʡ.פ�����.ȷɽ��','HNSZMDSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411726,'411726','����ʡ.פ�����.������','HNSZMDSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411727,'411727','����ʡ.פ�����.������','HNSZMDSRNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411728,'411728','����ʡ.פ�����.��ƽ��','HNSZMDSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411729,'411729','����ʡ.פ�����.�²���','HNSZMDSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,419000,'419000','����ʡ.ʡֱϽ�ؼ���������','HNSSZXXJXZQH'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,419001,'419001','����ʡ.��Դ��','HNSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420000,'420000','����ʡ','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420100,'420100','����ʡ.�人��','HBSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420102,'420102','����ʡ.�人��.������','HBSWHSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420103,'420103','����ʡ.�人��.������','HBSWHSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420104,'420104','����ʡ.�人��.�~����','HBSWHSCKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420105,'420105','����ʡ.�人��.������','HBSWHSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420106,'420106','����ʡ.�人��.�����','HBSWHSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420107,'420107','����ʡ.�人��.��ɽ��','HBSWHSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420111,'420111','����ʡ.�人��.��ɽ��','HBSWHSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420112,'420112','����ʡ.�人��.��������','HBSWHSDXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420113,'420113','����ʡ.�人��.������','HBSWHSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420114,'420114','����ʡ.�人��.�̵���','HBSWHSCDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420115,'420115','����ʡ.�人��.������','HBSWHSJXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420116,'420116','����ʡ.�人��.������','HBSWHSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420117,'420117','����ʡ.�人��.������','HBSWHSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420200,'420200','����ʡ.��ʯ��','HBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420202,'420202','����ʡ.��ʯ��.��ʯ����','HBSHSSHSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420203,'420203','����ʡ.��ʯ��.����ɽ��','HBSHSSXSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420204,'420204','����ʡ.��ʯ��.��½��','HBSHSSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420205,'420205','����ʡ.��ʯ��.��ɽ��','HBSHSSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420222,'420222','����ʡ.��ʯ��.������','HBSHSSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420281,'420281','����ʡ.��ʯ��.��ұ��','HBSHSSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420300,'420300','����ʡ.ʮ����','HBSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420302,'420302','����ʡ.ʮ����.é����','HBSSYSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420303,'420303','����ʡ.ʮ����.������','HBSSYSZWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420321,'420321','����ʡ.ʮ����.����','HBSSYSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420322,'420322','����ʡ.ʮ����.������','HBSSYSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420323,'420323','����ʡ.ʮ����.��ɽ��','HBSSYSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420324,'420324','����ʡ.ʮ����.��Ϫ��','HBSSYSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420325,'420325','����ʡ.ʮ����.����','HBSSYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420381,'420381','����ʡ.ʮ����.��������','HBSSYSDJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420500,'420500','����ʡ.�˲���','HBSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420502,'420502','����ʡ.�˲���.������','HBSYCSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420503,'420503','����ʡ.�˲���.��Ҹ���','HBSYCSWJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420504,'420504','����ʡ.�˲���.�����','HBSYCSDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420505,'420505','����ʡ.�˲���.�Vͤ��','HBSYCSX+C2588TQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420506,'420506','����ʡ.�˲���.������','HBSYCSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420525,'420525','����ʡ.�˲���.Զ����','HBSYCSYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420526,'420526','����ʡ.�˲���.��ɽ��','HBSYCSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420527,'420527','����ʡ.�˲���.������','HBSYCSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420528,'420528','����ʡ.�˲���.����������������','HBSYCSCYTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420529,'420529','����ʡ.�˲���.���������������','HBSYCSWFTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420581,'420581','����ʡ.�˲���.�˶���','HBSYCSYDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420582,'420582','����ʡ.�˲���.������','HBSYCSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420583,'420583','����ʡ.�˲���.֦����','HBSYCSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420600,'420600','����ʡ.�差��','HBSXFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420602,'420602','����ʡ.�差��.�����','HBSXFSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420606,'420606','����ʡ.�差��.������','HBSXFSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420607,'420607','����ʡ.�差��.������','HBSXFSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420624,'420624','����ʡ.�差��.������','HBSXFSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420625,'420625','����ʡ.�差��.�ȳ���','HBSXFSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420626,'420626','����ʡ.�差��.������','HBSXFSBKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420682,'420682','����ʡ.�差��.�Ϻӿ���','HBSXFSLHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420683,'420683','����ʡ.�差��.������','HBSXFSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420684,'420684','����ʡ.�差��.�˳���','HBSXFSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420700,'420700','����ʡ.������','HBSEZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420702,'420702','����ʡ.������.���Ӻ���','HBSEZSLZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420703,'420703','����ʡ.������.������','HBSEZSHRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420704,'420704','����ʡ.������.������','HBSEZSECQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420800,'420800','����ʡ.������','HBSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420802,'420802','����ʡ.������.������','HBSJMSDBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420804,'420804','����ʡ.������.�޵���','HBSJMSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420821,'420821','����ʡ.������.��ɽ��','HBSJMSJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420822,'420822','����ʡ.������.ɳ����','HBSJMSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420881,'420881','����ʡ.������.������','HBSJMSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420900,'420900','����ʡ.Т����','HBSXGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420902,'420902','����ʡ.Т����.Т����','HBSXGSXNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420921,'420921','����ʡ.Т����.Т����','HBSXGSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420922,'420922','����ʡ.Т����.������','HBSXGSDWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420923,'420923','����ʡ.Т����.������','HBSXGSYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420981,'420981','����ʡ.Т����.Ӧ����','HBSXGSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420982,'420982','����ʡ.Т����.��½��','HBSXGSALS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420984,'420984','����ʡ.Т����.������','HBSXGSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421000,'421000','����ʡ.������','HBSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421002,'421002','����ʡ.������.ɳ����','HBSJZSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421003,'421003','����ʡ.������.������','HBSJZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421022,'421022','����ʡ.������.������','HBSJZSGAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421023,'421023','����ʡ.������.������','HBSJZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421024,'421024','����ʡ.������.������','HBSJZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421081,'421081','����ʡ.������.ʯ����','HBSJZSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421083,'421083','����ʡ.������.�����','HBSJZSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421087,'421087','����ʡ.������.������','HBSJZSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421100,'421100','����ʡ.�Ƹ���','HBSHGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421102,'421102','����ʡ.�Ƹ���.������','HBSHGSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421121,'421121','����ʡ.�Ƹ���.�ŷ���','HBSHGSTFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421122,'421122','����ʡ.�Ƹ���.�찲��','HBSHGSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421123,'421123','����ʡ.�Ƹ���.������','HBSHGSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421124,'421124','����ʡ.�Ƹ���.Ӣɽ��','HBSHGSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421125,'421125','����ʡ.�Ƹ���.�ˮ��','HBSHGSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421126,'421126','����ʡ.�Ƹ���.ޭ����','HBSHGSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421127,'421127','����ʡ.�Ƹ���.��÷��','HBSHGSHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421181,'421181','����ʡ.�Ƹ���.�����','HBSHGSMCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421182,'421182','����ʡ.�Ƹ���.��Ѩ��','HBSHGSWXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421200,'421200','����ʡ.������','HBSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421202,'421202','����ʡ.������.�̰���','HBSXNSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421221,'421221','����ʡ.������.������','HBSXNSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421222,'421222','����ʡ.������.ͨ����','HBSXNSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421223,'421223','����ʡ.������.������','HBSXNSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421224,'421224','����ʡ.������.ͨɽ��','HBSXNSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421281,'421281','����ʡ.������.�����','HBSXNSCBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421300,'421300','����ʡ.������','HBSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421303,'421303','����ʡ.������.������','HBSSZSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421321,'421321','����ʡ.������.����','HBSSZSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421381,'421381','����ʡ.������.��ˮ��','HBSSZSGSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422800,'422800','����ʡ.��ʩ��.��ʩ��','HBSESZESZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422801,'422801','����ʡ.��ʩ��.��ʩ��','HBSESZESS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422802,'422802','����ʡ.��ʩ��.������','HBSESZLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422822,'422822','����ʡ.��ʩ��.��ʼ��','HBSESZJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422823,'422823','����ʡ.��ʩ��.�Ͷ���','HBSESZBDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422825,'422825','����ʡ.��ʩ��.������','HBSESZXEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422826,'422826','����ʡ.��ʩ��.�̷���','HBSESZXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422827,'422827','����ʡ.��ʩ��.������','HBSESZLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422828,'422828','����ʡ.��ʩ��.�׷���','HBSESZHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429000,'429000','����ʡ','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429004,'429004','����ʡ.������','HBSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429005,'429005','����ʡ.Ǳ����','HBSQJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429006,'429006','����ʡ.������','HBSTMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429021,'429021','����ʡ.��ũ������','HBSSNJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430000,'430000','����ʡ','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430100,'430100','����ʡ.��ɳ��','HNSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430102,'430102','����ʡ.��ɳ��.ܽ����','HNSCSSZRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430103,'430103','����ʡ.��ɳ��.������','HNSCSSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430104,'430104','����ʡ.��ɳ��.��´��','HNSCSSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430105,'430105','����ʡ.��ɳ��.������','HNSCSSKFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430111,'430111','����ʡ.��ɳ��.�껨��','HNSCSSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430121,'430121','����ʡ.��ɳ��.��ɳ��','HNSCSSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430122,'430122','����ʡ.��ɳ��.������','HNSCSSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430124,'430124','����ʡ.��ɳ��.������','HNSCSSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430181,'430181','����ʡ.��ɳ��.�����','HNSCSSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430200,'430200','����ʡ.������','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430202,'430202','����ʡ.������.������','HNSZZSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430203,'430203','����ʡ.������.«����','HNSZZSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430204,'430204','����ʡ.������.ʯ����','HNSZZSSFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430211,'430211','����ʡ.������.��Ԫ��','HNSZZSTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430221,'430221','����ʡ.������.������','HNSZZSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430223,'430223','����ʡ.������.����','HNSZZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430224,'430224','����ʡ.������.������','HNSZZSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430225,'430225','����ʡ.������.������','HNSZZSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430281,'430281','����ʡ.������.������','HNSZZSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430300,'430300','����ʡ.��̶��','HNSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430302,'430302','����ʡ.��̶��.�����','HNSXTSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430304,'430304','����ʡ.��̶��.������','HNSXTSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430321,'430321','����ʡ.��̶��.��̶��','HNSXTSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430381,'430381','����ʡ.��̶��.������','HNSXTSXXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430382,'430382','����ʡ.��̶��.��ɽ��','HNSXTSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430400,'430400','����ʡ.������','HNSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430405,'430405','����ʡ.������.������','HNSHYSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430406,'430406','����ʡ.������.�����','HNSHYSYFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430407,'430407','����ʡ.������.ʯ����','HNSHYSSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430408,'430408','����ʡ.������.������','HNSHYSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430412,'430412','����ʡ.������.������','HNSHYSNYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430421,'430421','����ʡ.������.������','HNSHYSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430422,'430422','����ʡ.������.������','HNSHYSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430423,'430423','����ʡ.������.��ɽ��','HNSHYSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430424,'430424','����ʡ.������.�ⶫ��','HNSHYSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430426,'430426','����ʡ.������.���','HNSHYSQDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430481,'430481','����ʡ.������.������','HNSHYSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430482,'430482','����ʡ.������.������','HNSHYSCNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430500,'430500','����ʡ.������','HNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430502,'430502','����ʡ.������.˫����','HNSSYSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430503,'430503','����ʡ.������.������','HNSSYSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430511,'430511','����ʡ.������.������','HNSSYSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430521,'430521','����ʡ.������.�۶���','HNSSYSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430522,'430522','����ʡ.������.������','HNSSYSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430523,'430523','����ʡ.������.������','HNSSYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430524,'430524','����ʡ.������.¡����','HNSSYSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430525,'430525','����ʡ.������.������','HNSSYSDKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430527,'430527','����ʡ.������.������','HNSSYSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430528,'430528','����ʡ.������.������','HNSSYSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430529,'430529','����ʡ.������.�ǲ�����������','HNSSYSCBMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430581,'430581','����ʡ.������.�����','HNSSYSWGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430600,'430600','����ʡ.������','HNSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430602,'430602','����ʡ.������.����¥��','HNSYYSYYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430603,'430603','����ʡ.������.��Ϫ��','HNSYYSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430611,'430611','����ʡ.������.��ɽ��','HNSYYSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430621,'430621','����ʡ.������.������','HNSYYSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430623,'430623','����ʡ.������.������','HNSYYSHRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430624,'430624','����ʡ.������.������','HNSYYSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430626,'430626','����ʡ.������.ƽ����','HNSYYSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430681,'430681','����ʡ.������.������','HNSYYSZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430682,'430682','����ʡ.������.������','HNSYYSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430700,'430700','����ʡ.������','HNSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430702,'430702','����ʡ.������.������','HNSCDSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430703,'430703','����ʡ.������.������','HNSCDSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430721,'430721','����ʡ.������.������','HNSCDSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430722,'430722','����ʡ.������.������','HNSCDSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430723,'430723','����ʡ.������.���','HNSCDSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430724,'430724','����ʡ.������.�����','HNSCDSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430725,'430725','����ʡ.������.��Դ��','HNSCDSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430726,'430726','����ʡ.������.ʯ����','HNSCDSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430781,'430781','����ʡ.������.������','HNSCDSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430800,'430800','����ʡ.�żҽ���','HNSZJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430802,'430802','����ʡ.�żҽ���.������','HNSZJJSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430811,'430811','����ʡ.�żҽ���.����Դ��','HNSZJJSWLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430821,'430821','����ʡ.�żҽ���.������','HNSZJJSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430822,'430822','����ʡ.�żҽ���.ɣֲ��','HNSZJJSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430900,'430900','����ʡ.������','HNSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430902,'430902','����ʡ.������.������','HNSYYSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430903,'430903','����ʡ.������.��ɽ��','HNSYYSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430921,'430921','����ʡ.������.����','HNSYYSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430922,'430922','����ʡ.������.�ҽ���','HNSYYSTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430923,'430923','����ʡ.������.������','HNSYYSAHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430981,'430981','����ʡ.������.�佭��','HNSYYSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431000,'431000','����ʡ.������','HNSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431002,'431002','����ʡ.������.������','HNSCZSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431003,'431003','����ʡ.������.������','HNSCZSSXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431021,'431021','����ʡ.������.������','HNSCZSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431022,'431022','����ʡ.������.������','HNSCZSYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431023,'431023','����ʡ.������.������','HNSCZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431024,'431024','����ʡ.������.�κ���','HNSCZSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431025,'431025','����ʡ.������.������','HNSCZSLWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431026,'431026','����ʡ.������.�����','HNSCZSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431027,'431027','����ʡ.������.����','HNSCZSGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431028,'431028','����ʡ.������.������','HNSCZSARX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431081,'431081','����ʡ.������.������','HNSCZSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431100,'431100','����ʡ.������','HNSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431102,'431102','����ʡ.������.������','HNSYZSLLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431103,'431103','����ʡ.������.��ˮ̲��','HNSYZSLSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431121,'431121','����ʡ.������.������','HNSYZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431122,'431122','����ʡ.������.������','HNSYZSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431123,'431123','����ʡ.������.˫����','HNSYZSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431124,'431124','����ʡ.������.����','HNSYZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431125,'431125','����ʡ.������.������','HNSYZSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431126,'431126','����ʡ.������.��Զ��','HNSYZSNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431127,'431127','����ʡ.������.��ɽ��','HNSYZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431128,'431128','����ʡ.������.������','HNSYZSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431129,'431129','����ʡ.������.��������������','HNSYZSJHYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431200,'431200','����ʡ.������','HNSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431202,'431202','����ʡ.������.�׳���','HNSHHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431221,'431221','����ʡ.������.�з���','HNSHHSZFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431222,'431222','����ʡ.������.������','HNSHHSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431223,'431223','����ʡ.������.��Ϫ��','HNSHHSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431224,'431224','����ʡ.������.������','HNSHHSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431225,'431225','����ʡ.������.��ͬ��','HNSHHSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431226,'431226','����ʡ.������.��������������','HNSHHSMYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431227,'431227','����ʡ.������.�»ζ���������','HNSHHSXHDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431228,'431228','����ʡ.������.�ƽ�����������','HNSHHSZJDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431229,'431229','����ʡ.������.������','HNSHHSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431230,'431230','����ʡ.������.ͨ������������','HNSHHSTDDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431281,'431281','����ʡ.������.�齭��','HNSHHSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431300,'431300','����ʡ.¦����','HNSLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431302,'431302','����ʡ.¦����.¦����','HNSLDSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431321,'431321','����ʡ.¦����.˫����','HNSLDSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431322,'431322','����ʡ.¦����.�»���','HNSLDSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431381,'431381','����ʡ.¦����.��ˮ����','HNSLDSLSJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431382,'431382','����ʡ.¦����.��Դ��','HNSLDSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433100,'433100','����ʡ.������','HNSXXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433101,'433101','����ʡ.������.������','HNSXXZJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433122,'433122','����ʡ.������.��Ϫ��','HNSXXZZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433123,'433123','����ʡ.������.�����','HNSXXZFHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433124,'433124','����ʡ.������.��ԫ��','HNSXXZHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433125,'433125','����ʡ.������.������','HNSXXZBJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433126,'433126','����ʡ.������.������','HNSXXZGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433127,'433127','����ʡ.������.��˳��','HNSXXZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433130,'433130','����ʡ.������.��ɽ��','HNSXXZLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440000,'440000','�㶫ʡ','GDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440100,'440100','�㶫ʡ.������','GDSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440103,'440103','�㶫ʡ.������.������','GDSGZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440104,'440104','�㶫ʡ.������.Խ����','GDSGZSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440105,'440105','�㶫ʡ.������.������','GDSGZSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440106,'440106','�㶫ʡ.������.�����','GDSGZSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440111,'440111','�㶫ʡ.������.������','GDSGZSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440112,'440112','�㶫ʡ.������.������','GDSGZSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440113,'440113','�㶫ʡ.������.��خ��','GDSGZSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440114,'440114','�㶫ʡ.������.������','GDSGZSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440115,'440115','�㶫ʡ.������.��ɳ��','GDSGZSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440116,'440116','�㶫ʡ.������.�ܸ���','GDSGZSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440183,'440183','�㶫ʡ.������.������','GDSGZSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440184,'440184','�㶫ʡ.������.�ӻ���','GDSGZSCHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440200,'440200','�㶫ʡ.�ع���','GDSSGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440203,'440203','�㶫ʡ.�ع���.�佭��','GDSSGSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440204,'440204','�㶫ʡ.�ع���.䥽���','GDSSGSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440205,'440205','�㶫ʡ.�ع���.������','GDSSGSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440222,'440222','�㶫ʡ.�ع���.ʼ����','GDSSGSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440224,'440224','�㶫ʡ.�ع���.�ʻ���','GDSSGSRHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440229,'440229','�㶫ʡ.�ع���.��Դ��','GDSSGSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440232,'440232','�㶫ʡ.�ع���.��Դ����������','GDSSGSRYYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440233,'440233','�㶫ʡ.�ع���.�·���','GDSSGSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440281,'440281','�㶫ʡ.�ع���.�ֲ���','GDSSGSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440282,'440282','�㶫ʡ.�ع���.������','GDSSGSNXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440300,'440300','�㶫ʡ.������','GDSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440303,'440303','�㶫ʡ.������.�޺���','GDSSZSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440304,'440304','�㶫ʡ.������.������','GDSSZSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440305,'440305','�㶫ʡ.������.��ɽ��','GDSSZSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440306,'440306','�㶫ʡ.������.������','GDSSZSBAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440307,'440307','�㶫ʡ.������.������','GDSSZSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440308,'440308','�㶫ʡ.������.������','GDSSZSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440400,'440400','�㶫ʡ.�麣��','GDSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440402,'440402','�㶫ʡ.�麣��.������','GDSZHSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440403,'440403','�㶫ʡ.�麣��.������','GDSZHSDMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440404,'440404','�㶫ʡ.�麣��.������','GDSZHSJWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440500,'440500','�㶫ʡ.��ͷ��','GDSSTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440507,'440507','�㶫ʡ.��ͷ��.������','GDSSTSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440511,'440511','�㶫ʡ.��ͷ��.��ƽ��','GDSSTSJPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440512,'440512','�㶫ʡ.��ͷ��.婽���','GDSSTSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440513,'440513','�㶫ʡ.��ͷ��.������','GDSSTSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440514,'440514','�㶫ʡ.��ͷ��.������','GDSSTSCNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440515,'440515','�㶫ʡ.��ͷ��.�κ���','GDSSTSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440523,'440523','�㶫ʡ.��ͷ��.�ϰ���','GDSSTSNAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440600,'440600','�㶫ʡ.��ɽ��','GDSFSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440604,'440604','�㶫ʡ.��ɽ��.������','GDSFSSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440605,'440605','�㶫ʡ.��ɽ��.�Ϻ���','GDSFSSNHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440606,'440606','�㶫ʡ.��ɽ��.˳����','GDSFSSSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440607,'440607','�㶫ʡ.��ɽ��.��ˮ��','GDSFSSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440608,'440608','�㶫ʡ.��ɽ��.������','GDSFSSGMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440700,'440700','�㶫ʡ.������','GDSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440703,'440703','�㶫ʡ.������.���','GDSJMSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440704,'440704','�㶫ʡ.������.������','GDSJMSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440705,'440705','�㶫ʡ.������.�»���','GDSJMSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440781,'440781','�㶫ʡ.������.̨ɽ��','GDSJMSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440783,'440783','�㶫ʡ.������.��ƽ��','GDSJMSKPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440784,'440784','�㶫ʡ.������.��ɽ��','GDSJMSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440785,'440785','�㶫ʡ.������.��ƽ��','GDSJMSEPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440800,'440800','�㶫ʡ.տ����','GDSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440802,'440802','�㶫ʡ.տ����.�࿲��','GDSZJSCKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440803,'440803','�㶫ʡ.տ����.ϼɽ��','GDSZJSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440804,'440804','�㶫ʡ.տ����.��ͷ��','GDSZJSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440811,'440811','�㶫ʡ.տ����.������','GDSZJSMZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440823,'440823','�㶫ʡ.տ����.��Ϫ��','GDSZJSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440825,'440825','�㶫ʡ.տ����.������','GDSZJSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440881,'440881','�㶫ʡ.տ����.������','GDSZJSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440882,'440882','�㶫ʡ.տ����.������','GDSZJSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440883,'440883','�㶫ʡ.տ����.�⴨��','GDSZJSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440900,'440900','�㶫ʡ.ï����','GDSMMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440902,'440902','�㶫ʡ.ï����.ï����','GDSMMSMNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440903,'440903','�㶫ʡ.ï����.ï����','GDSMMSMGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440923,'440923','�㶫ʡ.ï����.�����','GDSMMSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440981,'440981','�㶫ʡ.ï����.������','GDSMMSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440982,'440982','�㶫ʡ.ï����.������','GDSMMSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440983,'440983','�㶫ʡ.ï����.������','GDSMMSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441200,'441200','�㶫ʡ.������','GDSZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441202,'441202','�㶫ʡ.������.������','GDSZQSDZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441203,'441203','�㶫ʡ.������.������','GDSZQSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441223,'441223','�㶫ʡ.������.������','GDSZQSGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441224,'441224','�㶫ʡ.������.������','GDSZQSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441225,'441225','�㶫ʡ.������.�⿪��','GDSZQSFKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441226,'441226','�㶫ʡ.������.������','GDSZQSDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441283,'441283','�㶫ʡ.������.��Ҫ��','GDSZQSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441284,'441284','�㶫ʡ.������.�Ļ���','GDSZQSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441300,'441300','�㶫ʡ.������','GDSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441302,'441302','�㶫ʡ.������.�ݳ���','GDSHZSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441303,'441303','�㶫ʡ.������.������','GDSHZSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441322,'441322','�㶫ʡ.������.������','GDSHZSBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441323,'441323','�㶫ʡ.������.�ݶ���','GDSHZSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441324,'441324','�㶫ʡ.������.������','GDSHZSLMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441400,'441400','�㶫ʡ.÷����','GDSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441402,'441402','�㶫ʡ.÷����.÷����','GDSMZSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441421,'441421','�㶫ʡ.÷����.÷��','GDSMZSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441422,'441422','�㶫ʡ.÷����.������','GDSMZSDPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441423,'441423','�㶫ʡ.÷����.��˳��','GDSMZSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441424,'441424','�㶫ʡ.÷����.�廪��','GDSMZSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441426,'441426','�㶫ʡ.÷����.ƽԶ��','GDSMZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441427,'441427','�㶫ʡ.÷����.������','GDSMZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441481,'441481','�㶫ʡ.÷����.������','GDSMZSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441500,'441500','�㶫ʡ.��β��','GDSSWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441502,'441502','�㶫ʡ.��β��.����','GDSSWSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441521,'441521','�㶫ʡ.��β��.������','GDSSWSHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441523,'441523','�㶫ʡ.��β��.½����','GDSSWSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441581,'441581','�㶫ʡ.��β��.½����','GDSSWSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441600,'441600','�㶫ʡ.��Դ��','GDSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441602,'441602','�㶫ʡ.��Դ��.Դ����','GDSHYSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441621,'441621','�㶫ʡ.��Դ��.�Ͻ���','GDSHYSZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441622,'441622','�㶫ʡ.��Դ��.������','GDSHYSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441623,'441623','�㶫ʡ.��Դ��.��ƽ��','GDSHYSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441624,'441624','�㶫ʡ.��Դ��.��ƽ��','GDSHYSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441625,'441625','�㶫ʡ.��Դ��.��Դ��','GDSHYSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441700,'441700','�㶫ʡ.������','GDSYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441702,'441702','�㶫ʡ.������.������','GDSYJSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441721,'441721','�㶫ʡ.������.������','GDSYJSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441723,'441723','�㶫ʡ.������.������','GDSYJSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441781,'441781','�㶫ʡ.������.������','GDSYJSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441800,'441800','�㶫ʡ.��Զ��','GDSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441802,'441802','�㶫ʡ.��Զ��.�����','GDSQYSQCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441821,'441821','�㶫ʡ.��Զ��.�����','GDSQYSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441823,'441823','�㶫ʡ.��Զ��.��ɽ��','GDSQYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441825,'441825','�㶫ʡ.��Զ��.��ɽ��','GDSQYSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441826,'441826','�㶫ʡ.��Զ��.��������������','GDSQYSLNYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441827,'441827','�㶫ʡ.��Զ��.������','GDSQYSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441881,'441881','�㶫ʡ.��Զ��.Ӣ����','GDSQYSYDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441882,'441882','�㶫ʡ.��Զ��.������','GDSQYSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441900,'441900','�㶫ʡ.��ݸ�ж�ݸ��','GDSDZSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,442000,'442000','�㶫ʡ.��ɽ����ɽ��','GDSZSSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445100,'445100','�㶫ʡ.������','GDSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445102,'445102','�㶫ʡ.������.������','GDSCZSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445121,'445121','�㶫ʡ.������.������','GDSCZSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445122,'445122','�㶫ʡ.������.��ƽ��','GDSCZSRPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445200,'445200','�㶫ʡ.������','GDSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445202,'445202','�㶫ʡ.������.�ų���','GDSJYSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445221,'445221','�㶫ʡ.������.�Ҷ���','GDSJYSJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445222,'445222','�㶫ʡ.������.������','GDSJYSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445224,'445224','�㶫ʡ.������.������','GDSJYSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445281,'445281','�㶫ʡ.������.������','GDSJYSPNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445300,'445300','�㶫ʡ.�Ƹ���','GDSYFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445302,'445302','�㶫ʡ.�Ƹ���.�Ƴ���','GDSYFSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445321,'445321','�㶫ʡ.�Ƹ���.������','GDSYFSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445322,'445322','�㶫ʡ.�Ƹ���.������','GDSYFSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445323,'445323','�㶫ʡ.�Ƹ���.�ư���','GDSYFSYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445381,'445381','�㶫ʡ.�Ƹ���.�޶���','GDSYFSLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450000,'450000','����','GX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450100,'450100','����.������','GXNNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450102,'450102','����.������.������','GXNNSXNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450103,'450103','����.������.������','GXNNSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450105,'450105','����.������.������','GXNNSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450107,'450107','����.������.��������','GXNNSXXTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450108,'450108','����.������.������','GXNNSLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450109,'450109','����.������.������','GXNNSZNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450122,'450122','����.������.������','GXNNSWMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450123,'450123','����.������.¡����','GXNNSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450124,'450124','����.������.��ɽ��','GXNNSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450125,'450125','����.������.������','GXNNSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450126,'450126','����.������.������','GXNNSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450127,'450127','����.������.����','GXNNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450200,'450200','����.������','GXLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450202,'450202','����.������.������','GXLZSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450203,'450203','����.������.�����','GXLZSYFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450204,'450204','����.������.������','GXLZSLNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450205,'450205','����.������.������','GXLZSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450221,'450221','����.������.������','GXLZSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450222,'450222','����.������.������','GXLZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450223,'450223','����.������.¹կ��','GXLZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450224,'450224','����.������.�ڰ���','GXLZSRAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450225,'450225','����.������.��ˮ����������','GXLZSRSMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450226,'450226','����.������.��������������','GXLZSSJDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450300,'450300','����.������','GXGLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450302,'450302','����.������.�����','GXGLSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450303,'450303','����.������.������','GXGLSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450304,'450304','����.������.��ɽ��','GXGLSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450305,'450305','����.������.������','GXGLSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450311,'450311','����.������.��ɽ��','GXGLSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450321,'450321','����.������.��˷��','GXGLSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450322,'450322','����.������.�ٹ���','GXGLSLGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450323,'450323','����.������.�鴨��','GXGLSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450324,'450324','����.������.ȫ����','GXGLSQZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450325,'450325','����.������.�˰���','GXGLSXAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450326,'450326','����.������.������','GXGLSYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450327,'450327','����.������.������','GXGLSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450328,'450328','����.������.��ʤ����������','GXGLSLSGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450329,'450329','����.������.��Դ��','GXGLSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450330,'450330','����.������.ƽ����','GXGLSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450331,'450331','����.������.������','GXGLSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450332,'450332','����.������.��������������','GXGLSGCYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450400,'450400','����.������','GXWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450403,'450403','����.������.������','GXWZSWXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450404,'450404','����.������.��ɽ��','GXWZSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450405,'450405','����.������.������','GXWZSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450421,'450421','����.������.������','GXWZSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450422,'450422','����.������.����','GXWZSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450423,'450423','����.������.��ɽ��','GXWZSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450481,'450481','����.������.�Ϫ��','GXWZSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450500,'450500','����.������','GXBHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450502,'450502','����.������.������','GXBHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450503,'450503','����.������.������','GXBHSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450512,'450512','����.������.��ɽ����','GXBHSTSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450521,'450521','����.������.������','GXBHSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450600,'450600','����.���Ǹ���','GXFCGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450602,'450602','����.���Ǹ���.�ۿ���','GXFCGSGKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450603,'450603','����.���Ǹ���.������','GXFCGSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450621,'450621','����.���Ǹ���.��˼��','GXFCGSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450681,'450681','����.���Ǹ���.������','GXFCGSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450700,'450700','����.������','GXQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450702,'450702','����.������.������','GXQZSQNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450703,'450703','����.������.�ձ���','GXQZSQBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450721,'450721','����.������.��ɽ��','GXQZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450722,'450722','����.������.�ֱ���','GXQZSPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450800,'450800','����.�����','GXGGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450802,'450802','����.�����.�۱���','GXGGSGBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450803,'450803','����.�����.������','GXGGSGNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450804,'450804','����.�����.������','GXGGSZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450821,'450821','����.�����.ƽ����','GXGGSPNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450881,'450881','����.�����.��ƽ��','GXGGSGPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450900,'450900','����.������','GXYLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450902,'450902','����.������.������','GXYLSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450921,'450921','����.������.����','GXYLSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450922,'450922','����.������.½����','GXYLSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450923,'450923','����.������.������','GXYLSBBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450924,'450924','����.������.��ҵ��','GXYLSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450981,'450981','����.������.������','GXYLSBLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451000,'451000','����.��ɫ��','GXBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451002,'451002','����.��ɫ��.�ҽ���','GXBSSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451021,'451021','����.��ɫ��.������','GXBSSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451022,'451022','����.��ɫ��.�ﶫ��','GXBSSTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451023,'451023','����.��ɫ��.ƽ����','GXBSSPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451024,'451024','����.��ɫ��.�±���','GXBSSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451025,'451025','����.��ɫ��.������','GXBSSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451026,'451026','����.��ɫ��.������','GXBSSNPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451027,'451027','����.��ɫ��.������','GXBSSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451028,'451028','����.��ɫ��.��ҵ��','GXBSSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451029,'451029','����.��ɫ��.������','GXBSSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451030,'451030','����.��ɫ��.������','GXBSSXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451031,'451031','����.��ɫ��.¡�ָ���������','GXBSSLLGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451100,'451100','����.������','GXHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451102,'451102','����.������.�˲���','GXHZSBBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451121,'451121','����.������.��ƽ��','GXHZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451122,'451122','����.������.��ɽ��','GXHZSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451123,'451123','����.������.��������������','GXHZSFCYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451200,'451200','����.�ӳ���','GXHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451202,'451202','����.�ӳ���.��ǽ���','GXHCSJCJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451221,'451221','����.�ӳ���.�ϵ���','GXHCSNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451222,'451222','����.�ӳ���.�����','GXHCSTEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451223,'451223','����.�ӳ���.��ɽ��','GXHCSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451224,'451224','����.�ӳ���.������','GXHCSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451225,'451225','����.�ӳ���.�޳�������������','GXHCSLCZLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451226,'451226','����.�ӳ���.����ë����������','GXHCSHJMNZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451227,'451227','����.�ӳ���.��������������','GXHCSBMYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451228,'451228','����.�ӳ���.��������������','GXHCSDAYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451229,'451229','����.�ӳ���.������������','GXHCSDHYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451281,'451281','����.�ӳ���.������','GXHCSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451300,'451300','����.������','GXLBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451302,'451302','����.������.�˱���','GXLBSXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451321,'451321','����.������.�ó���','GXLBSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451322,'451322','����.������.������','GXLBSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451323,'451323','����.������.������','GXLBSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451324,'451324','����.������.��������������','GXLBSJXYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451381,'451381','����.������.��ɽ��','GXLBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451400,'451400','����.������','GXCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451402,'451402','����.������.������','GXCZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451421,'451421','����.������.������','GXCZSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451422,'451422','����.������.������','GXCZSNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451423,'451423','����.������.������','GXCZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451424,'451424','����.������.������','GXCZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451425,'451425','����.������.�����','GXCZSTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451481,'451481','����.������.ƾ����','GXCZSPXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460000,'460000','����ʡ','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460100,'460100','����ʡ.������','HNSHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460105,'460105','����ʡ.������.��Ӣ��','HNSHKSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460106,'460106','����ʡ.������.������','HNSHKSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460107,'460107','����ʡ.������.��ɽ��','HNSHKSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460108,'460108','����ʡ.������.������','HNSHKSMLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460200,'460200','����ʡ.������','HNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469001,'469001','����ʡ.��ָɽ��','HNSWZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469002,'469002','����ʡ.����','HNSQHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469003,'469003','����ʡ.������','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469005,'469005','����ʡ.�Ĳ���','HNSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469006,'469006','����ʡ.������','HNSWNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469007,'469007','����ʡ.������','HNSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469021,'469021','����ʡ.������','HNSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469022,'469022','����ʡ.�Ͳ���','HNSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469023,'469023','����ʡ.������','HNSCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469024,'469024','����ʡ.�ٸ���','HNSLGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469025,'469025','����ʡ.��ɳ����������','HNSBSLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469026,'469026','����ʡ.��������������','HNSCJLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469027,'469027','����ʡ.�ֶ�����������','HNSLDLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469028,'469028','����ʡ.��ˮ����������','HNSLSLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469029,'469029','����ʡ.��ͤ��������������','HNSBTLZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469030,'469030','����ʡ.������������������','HNSQZLZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469031,'469031','����ʡ.��ɳȺ��','HNSXSQD'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469032,'469032','����ʡ.��ɳȺ��','HNSNSQD'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469033,'469033','����ʡ.��ɳȺ���ĵ������亣��','HNSZSQDDDJJQHY'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500000,'500000','������','ZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500101,'500101','������.������','ZQSWZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500102,'500102','������.������','ZQSFLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500103,'500103','������.������','ZQSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500104,'500104','������.��ɿ���','ZQSDDKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500105,'500105','������.������','ZQSJBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500106,'500106','������.ɳƺ����','ZQSSPBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500107,'500107','������.��������','ZQSJLPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500108,'500108','������.�ϰ���','ZQSNAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500109,'500109','������.������','ZQSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500110,'500110','������.��ʢ��','ZQSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500111,'500111','������.˫����','ZQSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500112,'500112','������.�山��','ZQSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500113,'500113','������.������','ZQSBNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500114,'500114','������.ǭ����','ZQSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500115,'500115','������.������','ZQSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500116,'500116','������.������','ZQSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500117,'500117','������.�ϴ���','ZQSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500118,'500118','������.������','ZQSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500119,'500119','������.�ϴ���','ZQSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500222,'500222','������.�뽭��','ZQSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500223,'500223','������.������','ZQSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500224,'500224','������.ͭ����','ZQSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500225,'500225','������.������','ZQSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500226,'500226','������.�ٲ���','ZQSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500227,'500227','������.�ɽ��','ZQSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500228,'500228','������.��ƽ��','ZQSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500229,'500229','������.�ǿ���','ZQSCKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500230,'500230','������.�ᶼ��','ZQSFDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500231,'500231','������.�潭��','ZQSDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500232,'500232','������.��¡��','ZQSWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500233,'500233','������.����','ZQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500234,'500234','������.����','ZQSKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500235,'500235','������.������','ZQSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500236,'500236','������.�����','ZQSFJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500237,'500237','������.��ɽ��','ZQSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500238,'500238','������.��Ϫ��','ZQSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500240,'500240','������.ʯ��������������','ZQSSZTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500241,'500241','������.��ɽ����������������','ZQSXSTJZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500242,'500242','������.��������������������','ZQSYYTJZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500243,'500243','������.��ˮ����������������','ZQSPSMZTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510000,'510000','�Ĵ�ʡ','SCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510100,'510100','�Ĵ�ʡ.�ɶ���','SCSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510104,'510104','�Ĵ�ʡ.�ɶ���.������','SCSCDSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510105,'510105','�Ĵ�ʡ.�ɶ���.������','SCSCDSQYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510106,'510106','�Ĵ�ʡ.�ɶ���.��ţ��','SCSCDSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510107,'510107','�Ĵ�ʡ.�ɶ���.�����','SCSCDSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510108,'510108','�Ĵ�ʡ.�ɶ���.�ɻ���','SCSCDSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510112,'510112','�Ĵ�ʡ.�ɶ���.��Ȫ����','SCSCDSLQZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510113,'510113','�Ĵ�ʡ.�ɶ���.��׽���','SCSCDSQBJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510114,'510114','�Ĵ�ʡ.�ɶ���.�¶���','SCSCDSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510115,'510115','�Ĵ�ʡ.�ɶ���.�½���','SCSCDSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510121,'510121','�Ĵ�ʡ.�ɶ���.������','SCSCDSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510122,'510122','�Ĵ�ʡ.�ɶ���.˫����','SCSCDSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510124,'510124','�Ĵ�ʡ.�ɶ���.ۯ��','SCSCDSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510129,'510129','�Ĵ�ʡ.�ɶ���.������','SCSCDSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510131,'510131','�Ĵ�ʡ.�ɶ���.�ѽ���','SCSCDSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510132,'510132','�Ĵ�ʡ.�ɶ���.�½���','SCSCDSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510181,'510181','�Ĵ�ʡ.�ɶ���.��������','SCSCDSDJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510182,'510182','�Ĵ�ʡ.�ɶ���.������','SCSCDSPZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510183,'510183','�Ĵ�ʡ.�ɶ���.������','SCSCDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510184,'510184','�Ĵ�ʡ.�ɶ���.������','SCSCDSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510300,'510300','�Ĵ�ʡ.�Թ���','SCSZGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510302,'510302','�Ĵ�ʡ.�Թ���.��������','SCSZGSZLJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510303,'510303','�Ĵ�ʡ.�Թ���.������','SCSZGSGJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510304,'510304','�Ĵ�ʡ.�Թ���.����','SCSZGSDAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510311,'510311','�Ĵ�ʡ.�Թ���.��̲��','SCSZGSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510321,'510321','�Ĵ�ʡ.�Թ���.����','SCSZGSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510322,'510322','�Ĵ�ʡ.�Թ���.��˳��','SCSZGSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510400,'510400','�Ĵ�ʡ.��֦����','SCSPZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510402,'510402','�Ĵ�ʡ.��֦����.����','SCSPZHSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510403,'510403','�Ĵ�ʡ.��֦����.����','SCSPZHSXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510411,'510411','�Ĵ�ʡ.��֦����.�ʺ���','SCSPZHSRHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510421,'510421','�Ĵ�ʡ.��֦����.������','SCSPZHSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510422,'510422','�Ĵ�ʡ.��֦����.�α���','SCSPZHSYBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510500,'510500','�Ĵ�ʡ.������','SCSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510502,'510502','�Ĵ�ʡ.������.������','SCSZZSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510503,'510503','�Ĵ�ʡ.������.��Ϫ��','SCSZZSNXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510504,'510504','�Ĵ�ʡ.������.����̶��','SCSZZSLMTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510521,'510521','�Ĵ�ʡ.������.����','SCSZZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510522,'510522','�Ĵ�ʡ.������.�Ͻ���','SCSZZSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510524,'510524','�Ĵ�ʡ.������.������','SCSZZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510525,'510525','�Ĵ�ʡ.������.������','SCSZZSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510600,'510600','�Ĵ�ʡ.������','SCSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510603,'510603','�Ĵ�ʡ.������.�����','SCSDYSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510623,'510623','�Ĵ�ʡ.������.�н���','SCSDYSZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510626,'510626','�Ĵ�ʡ.������.�޽���','SCSDYSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510681,'510681','�Ĵ�ʡ.������.�㺺��','SCSDYSGHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510682,'510682','�Ĵ�ʡ.������.ʲ����','SCSDYSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510683,'510683','�Ĵ�ʡ.������.������','SCSDYSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510700,'510700','�Ĵ�ʡ.������','SCSMYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510703,'510703','�Ĵ�ʡ.������.������','SCSMYSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510704,'510704','�Ĵ�ʡ.������.������','SCSMYSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510722,'510722','�Ĵ�ʡ.������.��̨��','SCSMYSSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510723,'510723','�Ĵ�ʡ.������.��ͤ��','SCSMYSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510724,'510724','�Ĵ�ʡ.������.����','SCSMYSAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510725,'510725','�Ĵ�ʡ.������.������','SCSMYSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510726,'510726','�Ĵ�ʡ.������.����Ǽ��������','SCSMYSBCQZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510727,'510727','�Ĵ�ʡ.������.ƽ����','SCSMYSPWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510781,'510781','�Ĵ�ʡ.������.������','SCSMYSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510800,'510800','�Ĵ�ʡ.��Ԫ��','SCSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510802,'510802','�Ĵ�ʡ.��Ԫ��.������','SCSGYSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510811,'510811','�Ĵ�ʡ.��Ԫ��.Ԫ����','SCSGYSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510812,'510812','�Ĵ�ʡ.��Ԫ��.������','SCSGYSCTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510821,'510821','�Ĵ�ʡ.��Ԫ��.������','SCSGYSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510822,'510822','�Ĵ�ʡ.��Ԫ��.�ന��','SCSGYSQCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510823,'510823','�Ĵ�ʡ.��Ԫ��.������','SCSGYSJGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510824,'510824','�Ĵ�ʡ.��Ԫ��.��Ϫ��','SCSGYSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510900,'510900','�Ĵ�ʡ.������','SCSSNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510903,'510903','�Ĵ�ʡ.������.��ɽ��','SCSSNSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510904,'510904','�Ĵ�ʡ.������.������','SCSSNSAJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510921,'510921','�Ĵ�ʡ.������.��Ϫ��','SCSSNSPXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510922,'510922','�Ĵ�ʡ.������.�����','SCSSNSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510923,'510923','�Ĵ�ʡ.������.��Ӣ��','SCSSNSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511000,'511000','�Ĵ�ʡ.�ڽ���','SCSNJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511002,'511002','�Ĵ�ʡ.�ڽ���.������','SCSNJSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511011,'511011','�Ĵ�ʡ.�ڽ���.������','SCSNJSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511024,'511024','�Ĵ�ʡ.�ڽ���.��Զ��','SCSNJSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511025,'511025','�Ĵ�ʡ.�ڽ���.������','SCSNJSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511028,'511028','�Ĵ�ʡ.�ڽ���.¡����','SCSNJSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511100,'511100','�Ĵ�ʡ.��ɽ��','SCSLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511102,'511102','�Ĵ�ʡ.��ɽ��.������','SCSLSSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511111,'511111','�Ĵ�ʡ.��ɽ��.ɳ����','SCSLSSSWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511112,'511112','�Ĵ�ʡ.��ɽ��.��ͨ����','SCSLSSWTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511113,'511113','�Ĵ�ʡ.��ɽ��.��ں���','SCSLSSJKHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511123,'511123','�Ĵ�ʡ.��ɽ��.��Ϊ��','SCSLSSZWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511124,'511124','�Ĵ�ʡ.��ɽ��.������','SCSLSSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511126,'511126','�Ĵ�ʡ.��ɽ��.�н���','SCSLSSJJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511129,'511129','�Ĵ�ʡ.��ɽ��.�崨��','SCSLSSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511132,'511132','�Ĵ�ʡ.��ɽ��.�������������','SCSLSSEBYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511133,'511133','�Ĵ�ʡ.��ɽ��.�������������','SCSLSSMBYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511181,'511181','�Ĵ�ʡ.��ɽ��.��üɽ��','SCSLSSEMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511300,'511300','�Ĵ�ʡ.�ϳ���','SCSNCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511302,'511302','�Ĵ�ʡ.�ϳ���.˳����','SCSNCSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511303,'511303','�Ĵ�ʡ.�ϳ���.��ƺ��','SCSNCSGPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511304,'511304','�Ĵ�ʡ.�ϳ���.������','SCSNCSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511321,'511321','�Ĵ�ʡ.�ϳ���.�ϲ���','SCSNCSNBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511322,'511322','�Ĵ�ʡ.�ϳ���.Ӫɽ��','SCSNCSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511323,'511323','�Ĵ�ʡ.�ϳ���.���','SCSNCSPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511324,'511324','�Ĵ�ʡ.�ϳ���.��¤��','SCSNCSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511325,'511325','�Ĵ�ʡ.�ϳ���.������','SCSNCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511381,'511381','�Ĵ�ʡ.�ϳ���.������','SCSNCSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511400,'511400','�Ĵ�ʡ.üɽ��','SCSMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511402,'511402','�Ĵ�ʡ.üɽ��.������','SCSMSSDPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511421,'511421','�Ĵ�ʡ.üɽ��.������','SCSMSSRSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511422,'511422','�Ĵ�ʡ.üɽ��.��ɽ��','SCSMSSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511423,'511423','�Ĵ�ʡ.üɽ��.������','SCSMSSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511424,'511424','�Ĵ�ʡ.üɽ��.������','SCSMSSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511425,'511425','�Ĵ�ʡ.üɽ��.������','SCSMSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511500,'511500','�Ĵ�ʡ.�˱���','SCSYBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511502,'511502','�Ĵ�ʡ.�˱���.������','SCSYBSCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511521,'511521','�Ĵ�ʡ.�˱���.�˱���','SCSYBSYBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511522,'511522','�Ĵ�ʡ.�˱���.��Ϫ��','SCSYBSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511523,'511523','�Ĵ�ʡ.�˱���.������','SCSYBSJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511524,'511524','�Ĵ�ʡ.�˱���.������','SCSYBSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511525,'511525','�Ĵ�ʡ.�˱���.����','SCSYBSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511526,'511526','�Ĵ�ʡ.�˱���.����','SCSYBSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511527,'511527','�Ĵ�ʡ.�˱���.������','SCSYBS��LX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511528,'511528','�Ĵ�ʡ.�˱���.������','SCSYBSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511529,'511529','�Ĵ�ʡ.�˱���.��ɽ��','SCSYBSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511600,'511600','�Ĵ�ʡ.�㰲��','SCSGAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511602,'511602','�Ĵ�ʡ.�㰲��.�㰲��','SCSGASGAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511621,'511621','�Ĵ�ʡ.�㰲��.������','SCSGASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511622,'511622','�Ĵ�ʡ.�㰲��.��ʤ��','SCSGASWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511623,'511623','�Ĵ�ʡ.�㰲��.��ˮ��','SCSGASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511681,'511681','�Ĵ�ʡ.�㰲��.������','SCSGASHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511700,'511700','�Ĵ�ʡ.������','SCSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511702,'511702','�Ĵ�ʡ.������.ͨ����','SCSDZSTCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511721,'511721','�Ĵ�ʡ.������.����','SCSDZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511722,'511722','�Ĵ�ʡ.������.������','SCSDZSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511723,'511723','�Ĵ�ʡ.������.������','SCSDZSKJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511724,'511724','�Ĵ�ʡ.������.������','SCSDZSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511725,'511725','�Ĵ�ʡ.������.����','SCSDZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511781,'511781','�Ĵ�ʡ.������.��Դ��','SCSDZSWYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511800,'511800','�Ĵ�ʡ.�Ű���','SCSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511802,'511802','�Ĵ�ʡ.�Ű���.�����','SCSYASYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511821,'511821','�Ĵ�ʡ.�Ű���.��ɽ��','SCSYASMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511822,'511822','�Ĵ�ʡ.�Ű���.������','SCSYASZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511823,'511823','�Ĵ�ʡ.�Ű���.��Դ��','SCSYASHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511824,'511824','�Ĵ�ʡ.�Ű���.ʯ����','SCSYASSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511825,'511825','�Ĵ�ʡ.�Ű���.��ȫ��','SCSYASTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511826,'511826','�Ĵ�ʡ.�Ű���.«ɽ��','SCSYASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511827,'511827','�Ĵ�ʡ.�Ű���.������','SCSYASBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511900,'511900','�Ĵ�ʡ.������','SCSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511902,'511902','�Ĵ�ʡ.������.������','SCSBZSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511921,'511921','�Ĵ�ʡ.������.ͨ����','SCSBZSTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511922,'511922','�Ĵ�ʡ.������.�Ͻ���','SCSBZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511923,'511923','�Ĵ�ʡ.������.ƽ����','SCSBZSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512000,'512000','�Ĵ�ʡ.������','SCSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512002,'512002','�Ĵ�ʡ.������.�㽭��','SCSZYSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512021,'512021','�Ĵ�ʡ.������.������','SCSZYSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512022,'512022','�Ĵ�ʡ.������.������','SCSZYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512081,'512081','�Ĵ�ʡ.������.������','SCSZYSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513200,'513200','�Ĵ�ʡ.������','SCSABZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513221,'513221','�Ĵ�ʡ.������.�봨��','SCSABZZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513222,'513222','�Ĵ�ʡ.������.����','SCSABZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513223,'513223','�Ĵ�ʡ.������.ï��','SCSABZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513224,'513224','�Ĵ�ʡ.������.������','SCSABZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513225,'513225','�Ĵ�ʡ.������.��կ����','SCSABZJZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513226,'513226','�Ĵ�ʡ.������.����','SCSABZJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513227,'513227','�Ĵ�ʡ.������.С����','SCSABZXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513228,'513228','�Ĵ�ʡ.������.��ˮ��','SCSABZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513229,'513229','�Ĵ�ʡ.������.�������','SCSABZMEKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513230,'513230','�Ĵ�ʡ.������.������','SCSABZRTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513231,'513231','�Ĵ�ʡ.������.������','SCSABZABX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513232,'513232','�Ĵ�ʡ.������.��������','SCSABZREGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513233,'513233','�Ĵ�ʡ.������.��ԭ��','SCSABZHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513300,'513300','�Ĵ�ʡ.������','SCSGZZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513321,'513321','�Ĵ�ʡ.������.������','SCSGZZKDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513322,'513322','�Ĵ�ʡ.������.����','SCSGZZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513323,'513323','�Ĵ�ʡ.������.������','SCSGZZDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513324,'513324','�Ĵ�ʡ.������.������','SCSGZZJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513325,'513325','�Ĵ�ʡ.������.�Ž���','SCSGZZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513326,'513326','�Ĵ�ʡ.������.������','SCSGZZDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513327,'513327','�Ĵ�ʡ.������.¯����','SCSGZZLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513328,'513328','�Ĵ�ʡ.������.������','SCSGZZGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513329,'513329','�Ĵ�ʡ.������.������','SCSGZZXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513330,'513330','�Ĵ�ʡ.������.�¸���','SCSGZZDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513331,'513331','�Ĵ�ʡ.������.������','SCSGZZBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513332,'513332','�Ĵ�ʡ.������.ʯ����','SCSGZZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513333,'513333','�Ĵ�ʡ.������.ɫ����','SCSGZZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513334,'513334','�Ĵ�ʡ.������.������','SCSGZZLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513335,'513335','�Ĵ�ʡ.������.������','SCSGZZBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513336,'513336','�Ĵ�ʡ.������.�����','SCSGZZXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513337,'513337','�Ĵ�ʡ.������.������','SCSGZZDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513338,'513338','�Ĵ�ʡ.������.������','SCSGZZDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513400,'513400','�Ĵ�ʡ.��ɽ��.��ɽ��','SCSLSZLSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513401,'513401','�Ĵ�ʡ.��ɽ��.������','SCSLSZXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513422,'513422','�Ĵ�ʡ.��ɽ��.ľ�����������','SCSLSZMLCZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513423,'513423','�Ĵ�ʡ.��ɽ��.��Դ��','SCSLSZYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513424,'513424','�Ĵ�ʡ.��ɽ��.�²���','SCSLSZDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513425,'513425','�Ĵ�ʡ.��ɽ��.������','SCSLSZHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513426,'513426','�Ĵ�ʡ.��ɽ��.�ᶫ��','SCSLSZHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513427,'513427','�Ĵ�ʡ.��ɽ��.������','SCSLSZNNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513428,'513428','�Ĵ�ʡ.��ɽ��.�ո���','SCSLSZPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513429,'513429','�Ĵ�ʡ.��ɽ��.������','SCSLSZBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513430,'513430','�Ĵ�ʡ.��ɽ��.������','SCSLSZJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513431,'513431','�Ĵ�ʡ.��ɽ��.�Ѿ���','SCSLSZZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513432,'513432','�Ĵ�ʡ.��ɽ��.ϲ����','SCSLSZXDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513433,'513433','�Ĵ�ʡ.��ɽ��.������','SCSLSZMNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513434,'513434','�Ĵ�ʡ.��ɽ��.Խ����','SCSLSZYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513435,'513435','�Ĵ�ʡ.��ɽ��.������','SCSLSZGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513436,'513436','�Ĵ�ʡ.��ɽ��.������','SCSLSZMGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513437,'513437','�Ĵ�ʡ.��ɽ��.�ײ���','SCSLSZLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520000,'520000','����ʡ','GZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520100,'520100','����ʡ.������','GZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520102,'520102','����ʡ.������.������','GZSGYSNMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520103,'520103','����ʡ.������.������','GZSGYSYYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520111,'520111','����ʡ.������.��Ϫ��','GZSGYSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520112,'520112','����ʡ.������.�ڵ���','GZSGYSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520113,'520113','����ʡ.������.������','GZSGYSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520114,'520114','����ʡ.������.С����','GZSGYSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520121,'520121','����ʡ.������.������','GZSGYSKYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520122,'520122','����ʡ.������.Ϣ����','GZSGYSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520123,'520123','����ʡ.������.������','GZSGYSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520181,'520181','����ʡ.������.������','GZSGYSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520200,'520200','����ʡ.����ˮ��.����ˮ��','GZSLPSSLPSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520201,'520201','����ʡ.����ˮ��.��ɽ��','GZSLPSSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520203,'520203','����ʡ.����ˮ��.��֦����','GZSLPSSLZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520221,'520221','����ʡ.����ˮ��.ˮ����','GZSLPSSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520222,'520222','����ʡ.����ˮ��.����','GZSLPSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520300,'520300','����ʡ.������','GZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520302,'520302','����ʡ.������.�컨����','GZSZYSHHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520303,'520303','����ʡ.������.�㴨��','GZSZYSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520321,'520321','����ʡ.������.������','GZSZYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520322,'520322','����ʡ.������.ͩ����','GZSZYSTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520323,'520323','����ʡ.������.������','GZSZYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520324,'520324','����ʡ.������.������','GZSZYSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520325,'520325','����ʡ.������.������','GZSZYSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520326,'520326','����ʡ.������.����','GZSZYSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520327,'520327','����ʡ.������.�����','GZSZYSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520328,'520328','����ʡ.������.��̶��','GZSZYSZTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520329,'520329','����ʡ.������.������','GZSZYSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520330,'520330','����ʡ.������.ϰˮ��','GZSZYSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520381,'520381','����ʡ.������.��ˮ��','GZSZYSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520382,'520382','����ʡ.������.�ʻ���','GZSZYSRHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520400,'520400','����ʡ.��˳��','GZSASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520402,'520402','����ʡ.��˳��.������','GZSASSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520421,'520421','����ʡ.��˳��.ƽ����','GZSASSPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520422,'520422','����ʡ.��˳��.�ն���','GZSASSPDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520423,'520423','����ʡ.��˳��.������','GZSASSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520424,'520424','����ʡ.��˳��.������','GZSASSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520425,'520425','����ʡ.��˳��.����������','GZSASSZYZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522200,'522200','����ʡ.ͭ�ʵ���.ͭ�ʵ���','GZSTRDQTRDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522201,'522201','����ʡ.ͭ�ʵ���.ͭ����','GZSTRDQTRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522222,'522222','����ʡ.ͭ�ʵ���.������','GZSTRDQJKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522223,'522223','����ʡ.ͭ�ʵ���.������','GZSTRDQYPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522224,'522224','����ʡ.ͭ�ʵ���.ʯ����','GZSTRDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522225,'522225','����ʡ.ͭ�ʵ���.˼����','GZSTRDQSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522226,'522226','����ʡ.ͭ�ʵ���.ӡ����','GZSTRDQYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522227,'522227','����ʡ.ͭ�ʵ���.�½���','GZSTRDQDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522228,'522228','����ʡ.ͭ�ʵ���.�غ���','GZSTRDQYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522229,'522229','����ʡ.ͭ�ʵ���.������','GZSTRDQSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522230,'522230','����ʡ.ͭ�ʵ���.��ɽ����','GZSTRDQWSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522300,'522300','����ʡ.ǭ����','GZSQXN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522301,'522301','����ʡ.ǭ����.������','GZSQXNXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522322,'522322','����ʡ.ǭ����.������','GZSQXNXRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522323,'522323','����ʡ.ǭ����.�հ���','GZSQXNPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522324,'522324','����ʡ.ǭ����.��¡��','GZSQXNQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522325,'522325','����ʡ.ǭ����.�����','GZSQXNZFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522326,'522326','����ʡ.ǭ����.������','GZSQXNWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522327,'522327','����ʡ.ǭ����.�����','GZSQXNCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522328,'522328','����ʡ.ǭ����.������','GZSQXNALX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522400,'522400','����ʡ.�Ͻڵ���','GZSBJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522401,'522401','����ʡ.�Ͻڵ���.�Ͻ���','GZSBJDQBJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522422,'522422','����ʡ.�Ͻڵ���.����','GZSBJDQDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522423,'522423','����ʡ.�Ͻڵ���.ǭ����','GZSBJDQQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522424,'522424','����ʡ.�Ͻڵ���.��ɳ��','GZSBJDQJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522425,'522425','����ʡ.�Ͻڵ���.֯����','GZSBJDQZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522426,'522426','����ʡ.�Ͻڵ���.��Ӻ��','GZSBJDQNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522427,'522427','����ʡ.�Ͻڵ���.������','GZSBJDQWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522428,'522428','����ʡ.�Ͻڵ���.������','GZSBJDQHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522600,'522600','����ʡ.ǭ����','GZSQDN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522601,'522601','����ʡ.ǭ����.������','GZSQDNKLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522622,'522622','����ʡ.ǭ����.��ƽ��','GZSQDNHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522623,'522623','����ʡ.ǭ����.ʩ����','GZSQDNSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522624,'522624','����ʡ.ǭ����.������','GZSQDNSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522625,'522625','����ʡ.ǭ����.��Զ��','GZSQDNZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522626,'522626','����ʡ.ǭ����.᯹���','GZSQDNZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522627,'522627','����ʡ.ǭ����.������','GZSQDNTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522628,'522628','����ʡ.ǭ����.������','GZSQDNJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522629,'522629','����ʡ.ǭ����.������','GZSQDNJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522630,'522630','����ʡ.ǭ����.̨����','GZSQDNTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522631,'522631','����ʡ.ǭ����.��ƽ��','GZSQDNLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522632,'522632','����ʡ.ǭ����.�Ž���','GZSQDNZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522633,'522633','����ʡ.ǭ����.�ӽ���','GZSQDNCJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522634,'522634','����ʡ.ǭ����.��ɽ��','GZSQDNLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522635,'522635','����ʡ.ǭ����.�齭��','GZSQDNMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522636,'522636','����ʡ.ǭ����.��կ��','GZSQDNDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522700,'522700','����ʡ.ǭ����','GZSQNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522701,'522701','����ʡ.ǭ����.������','GZSQNZDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522702,'522702','����ʡ.ǭ����.��Ȫ��','GZSQNZFQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522722,'522722','����ʡ.ǭ����.����','GZSQNZLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522723,'522723','����ʡ.ǭ����.����','GZSQNZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522725,'522725','����ʡ.ǭ����.�Ͱ���','GZSQNZWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522726,'522726','����ʡ.ǭ����.��ɽ��','GZSQNZDSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522727,'522727','����ʡ.ǭ����.ƽ����','GZSQNZPTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522728,'522728','����ʡ.ǭ����.�޵���','GZSQNZLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522729,'522729','����ʡ.ǭ����.��˳��','GZSQNZCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522730,'522730','����ʡ.ǭ����.������','GZSQNZLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522731,'522731','����ʡ.ǭ����.��ˮ��','GZSQNZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522732,'522732','����ʡ.ǭ����.������','GZSQNZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530000,'530000','����ʡ','YNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530100,'530100','����ʡ.������','YNSKMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530102,'530102','����ʡ.������.�廪��','YNSKMSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530103,'530103','����ʡ.������.������','YNSKMSPLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530111,'530111','����ʡ.������.�ٶ���','YNSKMSGDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530112,'530112','����ʡ.������.��ɽ��','YNSKMSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530113,'530113','����ʡ.������.������','YNSKMSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530121,'530121','����ʡ.������.�ʹ���','YNSKMSCGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530122,'530122','����ʡ.������.������','YNSKMSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530124,'530124','����ʡ.������.������','YNSKMSFMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530125,'530125','����ʡ.������.������','YNSKMSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530126,'530126','����ʡ.������.ʯ����','YNSKMSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530127,'530127','����ʡ.������.������','YNSKMSZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530128,'530128','����ʡ.������.»Ȱ��','YNSKMSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530129,'530129','����ʡ.������.Ѱ+B2840����','YNSKMSXDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530181,'530181','����ʡ.������.������','YNSKMSANS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530300,'530300','����ʡ.������','YNSQJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530302,'530302','����ʡ.������.������','YNSQJSQLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530321,'530321','����ʡ.������.������','YNSQJSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530322,'530322','����ʡ.������.½����','YNSQJSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530323,'530323','����ʡ.������.ʦ����','YNSQJSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530324,'530324','����ʡ.������.��ƽ��','YNSQJSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530325,'530325','����ʡ.������.��Դ��','YNSQJSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530326,'530326','����ʡ.������.������','YNSQJSHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530328,'530328','����ʡ.������.մ����','YNSQJSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530381,'530381','����ʡ.������.������','YNSQJSXWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530400,'530400','����ʡ.��Ϫ��','YNSYXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530402,'530402','����ʡ.��Ϫ��.������','YNSYXSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530421,'530421','����ʡ.��Ϫ��.������','YNSYXSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530422,'530422','����ʡ.��Ϫ��.�ν���','YNSYXSCJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530423,'530423','����ʡ.��Ϫ��.ͨ����','YNSYXSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530424,'530424','����ʡ.��Ϫ��.������','YNSYXSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530425,'530425','����ʡ.��Ϫ��.������','YNSYXSYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530426,'530426','����ʡ.��Ϫ��.��ɽ��','YNSYXSESX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530427,'530427','����ʡ.��Ϫ��.��ƽ��','YNSYXSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530428,'530428','����ʡ.��Ϫ��.Ԫ��������','YNSYXSYJZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530500,'530500','����ʡ.��ɽ��','YNSBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530502,'530502','����ʡ.��ɽ��.¡����','YNSBSSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530521,'530521','����ʡ.��ɽ��.ʩ����','YNSBSSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530522,'530522','����ʡ.��ɽ��.�ڳ���','YNSBSSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530523,'530523','����ʡ.��ɽ��.������','YNSBSSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530524,'530524','����ʡ.��ɽ��.������','YNSBSSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530600,'530600','����ʡ.��ͨ��','YNSZTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530602,'530602','����ʡ.��ͨ��.������','YNSZTSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530621,'530621','����ʡ.��ͨ��.³����','YNSZTSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530622,'530622','����ʡ.��ͨ��.�ɼ���','YNSZTSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530623,'530623','����ʡ.��ͨ��.�ν���','YNSZTSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530624,'530624','����ʡ.��ͨ��.�����','YNSZTSDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530625,'530625','����ʡ.��ͨ��.������','YNSZTSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530626,'530626','����ʡ.��ͨ��.�罭��','YNSZTSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530627,'530627','����ʡ.��ͨ��.������','YNSZTSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530628,'530628','����ʡ.��ͨ��.������','YNSZTSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530629,'530629','����ʡ.��ͨ��.������','YNSZTSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530630,'530630','����ʡ.��ͨ��.ˮ����','YNSZTSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530700,'530700','����ʡ.������','YNSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530702,'530702','����ʡ.������.�ų���','YNSLJSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530721,'530721','����ʡ.������.������','YNSLJSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530722,'530722','����ʡ.������.��ʤ��','YNSLJSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530723,'530723','����ʡ.������.��ƺ��','YNSLJSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530724,'530724','����ʡ.������.������','YNSLJSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530800,'530800','����ʡ.�ն���','YNSPES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530802,'530802','����ʡ.�ն���.˼é��','YNSPESSMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530821,'530821','����ʡ.�ն���.������','YNSPESNEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530822,'530822','����ʡ.�ն���.ī����','YNSPESMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530823,'530823','����ʡ.�ն���.������','YNSPESJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530824,'530824','����ʡ.�ն���.������','YNSPESJGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530825,'530825','����ʡ.�ն���.������','YNSPESZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530826,'530826','����ʡ.�ն���.������','YNSPESJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530827,'530827','����ʡ.�ն���.������','YNSPESMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530828,'530828','����ʡ.�ն���.������','YNSPESLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530829,'530829','����ʡ.�ն���.������','YNSPESXMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530900,'530900','����ʡ.�ٲ���','YNSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530902,'530902','����ʡ.�ٲ���.������','YNSLCSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530921,'530921','����ʡ.�ٲ���.������','YNSLCSFQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530922,'530922','����ʡ.�ٲ���.����','YNSLCSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530923,'530923','����ʡ.�ٲ���.������','YNSLCSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530924,'530924','����ʡ.�ٲ���.����','YNSLCSZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530925,'530925','����ʡ.�ٲ���.˫����','YNSLCSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530926,'530926','����ʡ.�ٲ���.������','YNSLCSGMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530927,'530927','����ʡ.�ٲ���.��Դ��','YNSLCSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532300,'532300','����ʡ.������','YNSCXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532301,'532301','����ʡ.������.������','YNSCXZCXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532322,'532322','����ʡ.������.˫����','YNSCXZSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532323,'532323','����ʡ.������.Ĳ����','YNSCXZMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532324,'532324','����ʡ.������.�ϻ���','YNSCXZNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532325,'532325','����ʡ.������.Ҧ����','YNSCXZYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532326,'532326','����ʡ.������.��Ҧ��','YNSCXZDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532327,'532327','����ʡ.������.������','YNSCXZYRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532328,'532328','����ʡ.������.Ԫı��','YNSCXZYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532329,'532329','����ʡ.������.�䶨��','YNSCXZWDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532331,'532331','����ʡ.������.»����','YNSCXZLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532500,'532500','����ʡ.�����','YNSHHZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532501,'532501','����ʡ.�����.������','YNSHHZGJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532502,'532502','����ʡ.�����.��Զ��','YNSHHZKYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532522,'532522','����ʡ.�����.������','YNSHHZMZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532523,'532523','����ʡ.�����.������','YNSHHZPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532524,'532524','����ʡ.�����.��ˮ��','YNSHHZJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532525,'532525','����ʡ.�����.ʯ����','YNSHHZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532526,'532526','����ʡ.�����.������','YNSHHZMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532527,'532527','����ʡ.�����.������','YNSHHZZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532528,'532528','����ʡ.�����.Ԫ����','YNSHHZYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532529,'532529','����ʡ.�����.�����','YNSHHZHHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532530,'532530','����ʡ.�����.��ƽ��','YNSHHZJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532531,'532531','����ʡ.�����.�̴���','YNSHHZLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532532,'532532','����ʡ.�����.�ӿ���','YNSHHZHKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532600,'532600','����ʡ.��ɽ��','YNSWSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532621,'532621','����ʡ.��ɽ��.��ɽ��','YNSWSZWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532622,'532622','����ʡ.��ɽ��.��ɽ��','YNSWSZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532623,'532623','����ʡ.��ɽ��.������','YNSWSZXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532624,'532624','����ʡ.��ɽ��.��������','YNSWSZMLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532625,'532625','����ʡ.��ɽ��.�����','YNSWSZMGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532626,'532626','����ʡ.��ɽ��.����','YNSWSZQBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532627,'532627','����ʡ.��ɽ��.������','YNSWSZGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532628,'532628','����ʡ.��ɽ��.������','YNSWSZFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532800,'532800','����ʡ.��˫����','YNSXSBN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532801,'532801','����ʡ.��˫����.������','YNSXSBNJHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532822,'532822','����ʡ.��˫����.�º���','YNSXSBNZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532823,'532823','����ʡ.��˫����.������','YNSXSBNZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532900,'532900','����ʡ.����','YNSDL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532901,'532901','����ʡ.����.������','YNSDLDLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532922,'532922','����ʡ.����.�����','YNSDLYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532923,'532923','����ʡ.����.������','YNSDLXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532924,'532924','����ʡ.����.������','YNSDLBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532925,'532925','����ʡ.����.�ֶ���','YNSDLMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532926,'532926','����ʡ.����.�Ͻ���','YNSDLNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532927,'532927','����ʡ.����.Ρɽ��','YNSDLWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532928,'532928','����ʡ.����.��ƽ��','YNSDLYPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532929,'532929','����ʡ.����.������','YNSDLYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532930,'532930','����ʡ.����.��Դ��','YNSDLEYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532931,'532931','����ʡ.����.������','YNSDLJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532932,'532932','����ʡ.����.������','YNSDLHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533100,'533100','����ʡ.�º���','YNSDHZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533102,'533102','����ʡ.�º���.������','YNSDHZRLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533103,'533103','����ʡ.�º���.º����','YNSDHZLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533122,'533122','����ʡ.�º���.������','YNSDHZLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533123,'533123','����ʡ.�º���.ӯ����','YNSDHZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533124,'533124','����ʡ.�º���.¤����','YNSDHZLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533300,'533300','����ʡ.ŭ��','YNSNJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533321,'533321','����ʡ.ŭ��.��ˮ��','YNSNJZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533323,'533323','����ʡ.ŭ��.������','YNSNJFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533324,'533324','����ʡ.ŭ��.��ɽ��','YNSNJGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533325,'533325','����ʡ.ŭ��.��ƺ��','YNSNJLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533400,'533400','����ʡ.����','YNSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533421,'533421','����ʡ.����.���������','YNSDQXGLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533422,'533422','����ʡ.����.������','YNSDQDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533423,'533423','����ʡ.����.ά����','YNSDQWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540000,'540000','����������','XCZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540100,'540100','����������.������','XCZZQLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540102,'540102','����������.������.�ǹ���','XCZZQLSSCGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540121,'540121','����������.������.������','XCZZQLSSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540122,'540122','����������.������.������','XCZZQLSSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540123,'540123','����������.������.��ľ��','XCZZQLSSNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540124,'540124','����������.������.��ˮ��','XCZZQLSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540125,'540125','����������.������.����������','XCZZQLSSDLDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540126,'540126','����������.������.������','XCZZQLSSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540127,'540127','����������.������.ī�񹤿���','XCZZQLSSMZGKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542100,'542100','����������.��������','XCZZQCDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542121,'542121','����������.��������.������','XCZZQCDDQCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542122,'542122','����������.��������.������','XCZZQCDDQJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542123,'542123','����������.��������.������','XCZZQCDDQGJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542124,'542124','����������.��������.��������','XCZZQCDDQLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542125,'542125','����������.��������.������','XCZZQCDDQDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542126,'542126','����������.��������.������','XCZZQCDDQCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542127,'542127','����������.��������.������','XCZZQCDDQBSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542128,'542128','����������.��������.����','XCZZQCDDQZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542129,'542129','����������.��������.â����','XCZZQCDDQMKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542132,'542132','����������.��������.��¡��','XCZZQCDDQLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542133,'542133','����������.��������.�߰���','XCZZQCDDQBBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542200,'542200','����������.ɽ�ϵ���','XCZZQSNDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542221,'542221','����������.ɽ�ϵ���.�˶���','XCZZQSNDQNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542222,'542222','����������.ɽ�ϵ���.������','XCZZQSNDQZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542223,'542223','����������.ɽ�ϵ���.������','XCZZQSNDQGGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542224,'542224','����������.ɽ�ϵ���.ɣ����','XCZZQSNDQSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542225,'542225','����������.ɽ�ϵ���.�����','XCZZQSNDQQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542226,'542226','����������.ɽ�ϵ���.������','XCZZQSNDQQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542227,'542227','����������.ɽ�ϵ���.������','XCZZQSNDQCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542228,'542228','����������.ɽ�ϵ���.������','XCZZQSNDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542229,'542229','����������.ɽ�ϵ���.�Ӳ���','XCZZQSNDQJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542231,'542231','����������.ɽ�ϵ���.¡����','XCZZQSNDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542232,'542232','����������.ɽ�ϵ���.������','XCZZQSNDQCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542233,'542233','����������.ɽ�ϵ���.�˿�����','XCZZQSNDQLKZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542300,'542300','����������.�տ������','XCZZQRKZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542301,'542301','����������.�տ������.�տ�����','XCZZQRKZDQRKZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542322,'542322','����������.�տ������.��ľ����','XCZZQRKZDQNMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542323,'542323','����������.�տ������.������','XCZZQRKZDQJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542324,'542324','����������.�տ������.������','XCZZQRKZDQDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542325,'542325','����������.�տ������.������','XCZZQRKZDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542326,'542326','����������.�տ������.������','XCZZQRKZDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542327,'542327','����������.�տ������.������','XCZZQRKZDQARX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542328,'542328','����������.�տ������.лͨ����','XCZZQRKZDQXTMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542329,'542329','����������.�տ������.������','XCZZQRKZDQBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542330,'542330','����������.�տ������.�ʲ���','XCZZQRKZDQRBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542331,'542331','����������.�տ������.������','XCZZQRKZDQKMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542332,'542332','����������.�տ������.������','XCZZQRKZDQDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542333,'542333','����������.�տ������.�ٰ���','XCZZQRKZDQZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542334,'542334','����������.�տ������.�Ƕ���','XCZZQRKZDQYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542335,'542335','����������.�տ������.��¡��','XCZZQRKZDQJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542336,'542336','����������.�տ������.����ľ��','XCZZQRKZDQNLMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542337,'542337','����������.�տ������.������','XCZZQRKZDQSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542338,'542338','����������.�տ������.�ڰ���','XCZZQRKZDQGBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542400,'542400','����������.��������','XCZZQNQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542421,'542421','����������.��������.������','XCZZQNQDQNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542422,'542422','����������.��������.������','XCZZQNQDQJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542423,'542423','����������.��������.������','XCZZQNQDQBRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542424,'542424','����������.��������.������','XCZZQNQDQNRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542425,'542425','����������.��������.������','XCZZQNQDQADX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542426,'542426','����������.��������.������','XCZZQNQDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542427,'542427','����������.��������.����','XCZZQNQDQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542428,'542428','����������.��������.�����','XCZZQNQDQBGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542429,'542429','����������.��������.������','XCZZQNQDQBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542430,'542430','����������.��������.������','XCZZQNQDQNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542500,'542500','����������.�������','XCZZQALDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542521,'542521','����������.�������.������','XCZZQALDQPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542522,'542522','����������.�������.������','XCZZQALDQZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542523,'542523','����������.�������.������','XCZZQALDQGEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542524,'542524','����������.�������.������','XCZZQALDQRTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542525,'542525','����������.�������.�Ｊ��','XCZZQALDQGJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542526,'542526','����������.�������.������','XCZZQALDQGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542527,'542527','����������.�������.������','XCZZQALDQCQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542600,'542600','����������.��֥����','XCZZQLZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542621,'542621','����������.��֥����.��֥��','XCZZQLZDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542622,'542622','����������.��֥����.����������','XCZZQLZDQGBJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542623,'542623','����������.��֥����.������','XCZZQLZDQMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542624,'542624','����������.��֥����.ī����','XCZZQLZDQMTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542625,'542625','����������.��֥����.������','XCZZQLZDQBMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542626,'542626','����������.��֥����.������','XCZZQLZDQCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542627,'542627','����������.��֥����.����','XCZZQLZDQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610000,'610000','����ʡ','SXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610100,'610100','����ʡ.������','SXSXAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610102,'610102','����ʡ.������.�³���','SXSXASXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610103,'610103','����ʡ.������.������','SXSXASBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610104,'610104','����ʡ.������.������','SXSXASLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610111,'610111','����ʡ.������.�����','SXSXASZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610112,'610112','����ʡ.������.δ����','SXSXASWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610113,'610113','����ʡ.������.������','SXSXASYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610114,'610114','����ʡ.������.������','SXSXASYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610115,'610115','����ʡ.������.������','SXSXASLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610116,'610116','����ʡ.������.������','SXSXASCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610122,'610122','����ʡ.������.������','SXSXASLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610124,'610124','����ʡ.������.������','SXSXASZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610125,'610125','����ʡ.������.����','SXSXASHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610126,'610126','����ʡ.������.������','SXSXASGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610200,'610200','����ʡ.ͭ����','SXSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610202,'610202','����ʡ.ͭ����.������','SXSTCSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610203,'610203','����ʡ.ͭ����.ӡ̨��','SXSTCSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610204,'610204','����ʡ.ͭ����.ҫ����','SXSTCSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610222,'610222','����ʡ.ͭ����.�˾���','SXSTCSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610300,'610300','����ʡ.������','SXSBJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610302,'610302','����ʡ.������.μ����','SXSBJSWBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610303,'610303','����ʡ.������.��̨��','SXSBJSJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610304,'610304','����ʡ.������.�²���','SXSBJSCCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610322,'610322','����ʡ.������.������','SXSBJSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610323,'610323','����ʡ.������.�ɽ��','SXSBJSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610324,'610324','����ʡ.������.������','SXSBJSFFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610326,'610326','����ʡ.������.ü��','SXSBJSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610327,'610327','����ʡ.������.¤��','SXSBJSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610328,'610328','����ʡ.������.ǧ����','SXSBJSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610329,'610329','����ʡ.������.������','SXSBJSL+C3117YX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610330,'610330','����ʡ.������.����','SXSBJSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610331,'610331','����ʡ.������.̫����','SXSBJSTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610400,'610400','����ʡ.������','SXSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610402,'610402','����ʡ.������.�ض���','SXSXYSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610403,'610403','����ʡ.������.������','SXSXYSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610404,'610404','����ʡ.������.μ����','SXSXYSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610422,'610422','����ʡ.������.��ԭ��','SXSXYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610423,'610423','����ʡ.������.������','SXSXYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610424,'610424','����ʡ.������.Ǭ��','SXSXYSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610425,'610425','����ʡ.������.��Ȫ��','SXSXYSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610426,'610426','����ʡ.������.������','SXSXYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610427,'610427','����ʡ.������.����','SXSXYSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610428,'610428','����ʡ.������.������','SXSXYSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610429,'610429','����ʡ.������.Ѯ����','SXSXYSѮYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610430,'610430','����ʡ.������.������','SXSXYSCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610431,'610431','����ʡ.������.�书��','SXSXYSWGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610481,'610481','����ʡ.������.��ƽ��','SXSXYSXPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610500,'610500','����ʡ.μ����','SXSWNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610502,'610502','����ʡ.μ����.��μ��','SXSWNSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610521,'610521','����ʡ.μ����.����','SXSWNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610522,'610522','����ʡ.μ����.������','SXSWNSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610523,'610523','����ʡ.μ����.������','SXSWNSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610524,'610524','����ʡ.μ����.������','SXSWNSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610525,'610525','����ʡ.μ����.�γ���','SXSWNSCCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610526,'610526','����ʡ.μ����.�ѳ���','SXSWNSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610527,'610527','����ʡ.μ����.��ˮ��','SXSWNSBSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610528,'610528','����ʡ.μ����.��ƽ��','SXSWNSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610581,'610581','����ʡ.μ����.������','SXSWNSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610582,'610582','����ʡ.μ����.������','SXSWNSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610600,'610600','����ʡ.�Ӱ���','SXSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610602,'610602','����ʡ.�Ӱ���.������','SXSYASBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610621,'610621','����ʡ.�Ӱ���.�ӳ���','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610622,'610622','����ʡ.�Ӱ���.�Ӵ���','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610623,'610623','����ʡ.�Ӱ���.�ӳ���','SXSYASZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610624,'610624','����ʡ.�Ӱ���.������','SXSYASASX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610625,'610625','����ʡ.�Ӱ���.־����','SXSYASZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610626,'610626','����ʡ.�Ӱ���.������','SXSYASWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610627,'610627','����ʡ.�Ӱ���.��Ȫ��','SXSYASGQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610628,'610628','����ʡ.�Ӱ���.����','SXSYASFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610629,'610629','����ʡ.�Ӱ���.�崨��','SXSYASLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610630,'610630','����ʡ.�Ӱ���.�˴���','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610631,'610631','����ʡ.�Ӱ���.������','SXSYASHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610632,'610632','����ʡ.�Ӱ���.������','SXSYASHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610700,'610700','����ʡ.������','SXSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610702,'610702','����ʡ.������.��̨��','SXSHZSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610721,'610721','����ʡ.������.��֣��','SXSHZSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610722,'610722','����ʡ.������.�ǹ���','SXSHZSCGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610723,'610723','����ʡ.������.����','SXSHZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610724,'610724','����ʡ.������.������','SXSHZSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610725,'610725','����ʡ.������.����','SXSHZSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610726,'610726','����ʡ.������.��ǿ��','SXSHZSNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610727,'610727','����ʡ.������.������','SXSHZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610728,'610728','����ʡ.������.�����','SXSHZSZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610729,'610729','����ʡ.������.������','SXSHZSLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610730,'610730','����ʡ.������.��ƺ��','SXSHZSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610800,'610800','����ʡ.������','SXSYLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610802,'610802','����ʡ.������.������','SXSYLSYYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610821,'610821','����ʡ.������.��ľ��','SXSYLSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610822,'610822','����ʡ.������.������','SXSYLSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610823,'610823','����ʡ.������.��ɽ��','SXSYLSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610824,'610824','����ʡ.������.������','SXSYLSJBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610825,'610825','����ʡ.������.������','SXSYLSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610826,'610826','����ʡ.������.�����','SXSYLSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610827,'610827','����ʡ.������.��֬��','SXSYLSMZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610828,'610828','����ʡ.������.����','SXSYLSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610829,'610829','����ʡ.������.�Ɽ��','SXSYLSWBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610830,'610830','����ʡ.������.�彧��','SXSYLSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610831,'610831','����ʡ.������.������','SXSYLSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610900,'610900','����ʡ.������','SXSAKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610902,'610902','����ʡ.������.������','SXSAKSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610921,'610921','����ʡ.������.������','SXSAKSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610922,'610922','����ʡ.������.ʯȪ��','SXSAKSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610923,'610923','����ʡ.������.������','SXSAKSNSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610924,'610924','����ʡ.������.������','SXSAKSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610925,'610925','����ʡ.������.᰸���','SXSAKSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610926,'610926','����ʡ.������.ƽ����','SXSAKSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610927,'610927','����ʡ.������.��ƺ��','SXSAKSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610928,'610928','����ʡ.������.Ѯ����','SXSAKSѮYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610929,'610929','����ʡ.������.�׺���','SXSAKSBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611000,'611000','����ʡ.������','SXSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611002,'611002','����ʡ.������.������','SXSSLSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611021,'611021','����ʡ.������.������','SXSSLSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611022,'611022','����ʡ.������.������','SXSSLSDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611023,'611023','����ʡ.������.������','SXSSLSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611024,'611024','����ʡ.������.ɽ����','SXSSLSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611025,'611025','����ʡ.������.����','SXSSLSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611026,'611026','����ʡ.������.��ˮ��','SXSSLSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620000,'620000','����ʡ','GSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620100,'620100','����ʡ.������','GSSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620102,'620102','����ʡ.������.�ǹ���','GSSLZSCGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620103,'620103','����ʡ.������.�������','GSSLZSQLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620104,'620104','����ʡ.������.������','GSSLZSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620105,'620105','����ʡ.������.������','GSSLZSANQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620111,'620111','����ʡ.������.�����','GSSLZSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620121,'620121','����ʡ.������.������','GSSLZSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620122,'620122','����ʡ.������.������','GSSLZSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620123,'620123','����ʡ.������.������','GSSLZSYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620200,'620200','����ʡ.��������','GSSJYGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620300,'620300','����ʡ.�����','GSSJCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620302,'620302','����ʡ.�����.����','GSSJCSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620321,'620321','����ʡ.�����.������','GSSJCSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620400,'620400','����ʡ.������','GSSBYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620402,'620402','����ʡ.������.������','GSSBYSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620403,'620403','����ʡ.������.ƽ����','GSSBYSPCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620421,'620421','����ʡ.������.��Զ��','GSSBYSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620422,'620422','����ʡ.������.������','GSSBYSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620423,'620423','����ʡ.������.��̩��','GSSBYSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620500,'620500','����ʡ.��ˮ��','GSSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620502,'620502','����ʡ.��ˮ��.������','GSSTSSQZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620503,'620503','����ʡ.��ˮ��.�����','GSSTSSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620521,'620521','����ʡ.��ˮ��.��ˮ��','GSSTSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620522,'620522','����ʡ.��ˮ��.�ذ���','GSSTSSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620523,'620523','����ʡ.��ˮ��.�ʹ���','GSSTSSGGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620524,'620524','����ʡ.��ˮ��.��ɽ��','GSSTSSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620525,'620525','����ʡ.��ˮ��.�żҴ�����������','GSSTSSZJCHZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620600,'620600','����ʡ.������','GSSWWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620602,'620602','����ʡ.������.������','GSSWWSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620621,'620621','����ʡ.������.������','GSSWWSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620622,'620622','����ʡ.������.������','GSSWWSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620623,'620623','����ʡ.������.��ף����������','GSSWWSTZCZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620700,'620700','����ʡ.��Ҵ��','GSSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620702,'620702','����ʡ.��Ҵ��.������','GSSZYSGZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620721,'620721','����ʡ.��Ҵ��.����ԣ����������','GSSZYSSNYGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620722,'620722','����ʡ.��Ҵ��.������','GSSZYSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620723,'620723','����ʡ.��Ҵ��.������','GSSZYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620724,'620724','����ʡ.��Ҵ��.��̨��','GSSZYSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620725,'620725','����ʡ.��Ҵ��.ɽ����','GSSZYSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620800,'620800','����ʡ.ƽ����','GSSPLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620802,'620802','����ʡ.ƽ����.�����','GSSPLSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620821,'620821','����ʡ.ƽ����.������','GSSPLSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620822,'620822','����ʡ.ƽ����.��̨��','GSSPLSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620823,'620823','����ʡ.ƽ����.������','GSSPLSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620824,'620824','����ʡ.ƽ����.��ͤ��','GSSPLSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620825,'620825','����ʡ.ƽ����.ׯ����','GSSPLSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620826,'620826','����ʡ.ƽ����.������','GSSPLSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620900,'620900','����ʡ.��Ȫ��','GSSJQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620902,'620902','����ʡ.��Ȫ��.������','GSSJQSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620921,'620921','����ʡ.��Ȫ��.������','GSSJQSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620922,'620922','����ʡ.��Ȫ��.������','GSSJQSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620923,'620923','����ʡ.��Ȫ��.�౱��','GSSJQSSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620924,'620924','����ʡ.��Ȫ��.��������','GSSJQSAKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620981,'620981','����ʡ.��Ȫ��.������','GSSJQSYMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620982,'620982','����ʡ.��Ȫ��.�ػ���','GSSJQSDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621000,'621000','����ʡ.������','GSSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621002,'621002','����ʡ.������.������','GSSQYSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621021,'621021','����ʡ.������.�����','GSSQYSQCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621022,'621022','����ʡ.������.����','GSSQYSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621023,'621023','����ʡ.������.������','GSSQYSHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621024,'621024','����ʡ.������.��ˮ��','GSSQYSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621025,'621025','����ʡ.������.������','GSSQYSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621026,'621026','����ʡ.������.����','GSSQYSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621027,'621027','����ʡ.������.��ԭ��','GSSQYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621100,'621100','����ʡ.������','GSSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621102,'621102','����ʡ.������.������','GSSDXSADQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621121,'621121','����ʡ.������.ͨμ��','GSSDXSTWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621122,'621122','����ʡ.������.¤����','GSSDXSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621123,'621123','����ʡ.������.μԴ��','GSSDXSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621124,'621124','����ʡ.������.�����','GSSDXSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621125,'621125','����ʡ.������.����','GSSDXSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621126,'621126','����ʡ.������.���','GSSDXSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621200,'621200','����ʡ.¤����','GSSLNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621202,'621202','����ʡ.¤����.�䶼��','GSSLNSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621221,'621221','����ʡ.¤����.����','GSSLNSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621222,'621222','����ʡ.¤����.����','GSSLNSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621223,'621223','����ʡ.¤����.崲���','GSSLNSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621224,'621224','����ʡ.¤����.����','GSSLNSKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621225,'621225','����ʡ.¤����.������','GSSLNSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621226,'621226','����ʡ.¤����.����','GSSLNSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621227,'621227','����ʡ.¤����.����','GSSLNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621228,'621228','����ʡ.¤����.������','GSSLNSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622900,'622900','����ʡ.������','GSSLXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622901,'622901','����ʡ.������.������','GSSLXZLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622921,'622921','����ʡ.������.������','GSSLXZLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622922,'622922','����ʡ.������.������','GSSLXZKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622923,'622923','����ʡ.������.������','GSSLXZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622924,'622924','����ʡ.������.�����','GSSLXZGHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622925,'622925','����ʡ.������.������','GSSLXZHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622926,'622926','����ʡ.������.������������','GSSLXZDXZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622927,'622927','����ʡ.������.��ʯɽ��','GSSLXZJSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623000,'623000','����ʡ.����','GSSGN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623001,'623001','����ʡ.����.������','GSSGNHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623021,'623021','����ʡ.����.��̶��','GSSGNLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623022,'623022','����ʡ.����.׿����','GSSGNZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623023,'623023','����ʡ.����.������','GSSGNZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623024,'623024','����ʡ.����.������','GSSGNDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623025,'623025','����ʡ.����.������','GSSGNMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623026,'623026','����ʡ.����.µ����','GSSGNLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623027,'623027','����ʡ.����.�ĺ���','GSSGNXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630000,'630000','�ຣʡ','QHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630100,'630100','�ຣʡ.������','QHSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630102,'630102','�ຣʡ.������.�Ƕ���','QHSXNSCDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630103,'630103','�ຣʡ.������.������','QHSXNSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630104,'630104','�ຣʡ.������.������','QHSXNSCXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630105,'630105','�ຣʡ.������.�Ǳ���','QHSXNSCBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630121,'630121','�ຣʡ.������.��ͨ��','QHSXNSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630122,'630122','�ຣʡ.������.������','QHSXNSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630123,'630123','�ຣʡ.������.��Դ��','QHSXNSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632100,'632100','�ຣʡ.��������','QHSHDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632121,'632121','�ຣʡ.��������.ƽ����','QHSHDDQPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632122,'632122','�ຣʡ.��������.�����','QHSHDDQMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632123,'632123','�ຣʡ.��������.�ֶ���','QHSHDDQLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632126,'632126','�ຣʡ.��������.������','QHSHDDQHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632127,'632127','�ຣʡ.��������.��¡��','QHSHDDQHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632128,'632128','�ຣʡ.��������.ѭ����','QHSHDDQѭHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632200,'632200','�ຣʡ.������','QHSHBZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632221,'632221','�ຣʡ.������.��Դ����������','QHSHBZMYHZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632222,'632222','�ຣʡ.������.������','QHSHBZQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632223,'632223','�ຣʡ.������.������','QHSHBZHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632224,'632224','�ຣʡ.������.�ղ���','QHSHBZGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632300,'632300','�ຣʡ.������','QHSHNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632321,'632321','�ຣʡ.������.ͬ����','QHSHNZTRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632322,'632322','�ຣʡ.������.������','QHSHNZJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632323,'632323','�ຣʡ.������.�����','QHSHNZZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632324,'632324','�ຣʡ.������.�����ɹ���������','QHSHNZHNMGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632500,'632500','�ຣʡ.������','QHSHNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632521,'632521','�ຣʡ.������.������','QHSHNZGHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632522,'632522','�ຣʡ.������.ͬ����','QHSHNZTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632523,'632523','�ຣʡ.������.�����','QHSHNZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632524,'632524','�ຣʡ.������.�˺���','QHSHNZXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632525,'632525','�ຣʡ.������.������','QHSHNZGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632600,'632600','�ຣʡ.������','QHSGLZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632621,'632621','�ຣʡ.������.������','QHSGLZMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632622,'632622','�ຣʡ.������.������','QHSGLZBMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632623,'632623','�ຣʡ.������.�ʵ���','QHSGLZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632624,'632624','�ຣʡ.������.������','QHSGLZDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632625,'632625','�ຣʡ.������.������','QHSGLZJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632626,'632626','�ຣʡ.������.�����','QHSGLZMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632700,'632700','�ຣʡ.������','QHSYSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632721,'632721','�ຣʡ.������.������','QHSYSZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632722,'632722','�ຣʡ.������.�Ӷ���','QHSYSZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632723,'632723','�ຣʡ.������.�ƶ���','QHSYSZCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632724,'632724','�ຣʡ.������.�ζ���','QHSYSZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632725,'632725','�ຣʡ.������.��ǫ��','QHSYSZNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632726,'632726','�ຣʡ.������.��������','QHSYSZQMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632800,'632800','�ຣʡ.������','QHSHXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632801,'632801','�ຣʡ.������.���ľ��','QHSHXZGEMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632802,'632802','�ຣʡ.������.�������','QHSHXZDLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632821,'632821','�ຣʡ.������.������','QHSHXZWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632822,'632822','�ຣʡ.������.������','QHSHXZDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632823,'632823','�ຣʡ.������.�����','QHSHXZTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640000,'640000','����','NX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640100,'640100','����.������','NXYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640104,'640104','����.������.������','NXYCSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640105,'640105','����.������.������','NXYCSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640106,'640106','����.������.�����','NXYCSJFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640121,'640121','����.������.������','NXYCSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640122,'640122','����.������.������','NXYCSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640181,'640181','����.������.������','NXYCSLWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640200,'640200','����.ʯ��ɽ��','NXSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640202,'640202','����.ʯ��ɽ��.�������','NXSZSSDWKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640205,'640205','����.ʯ��ɽ��.��ũ��','NXSZSSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640221,'640221','����.ʯ��ɽ��.ƽ����','NXSZSSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640300,'640300','����.������','NXWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640302,'640302','����.������.��ͨ��','NXWZSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640303,'640303','����.������.���±���','NXWZSHSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640323,'640323','����.������.�γ���','NXWZSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640324,'640324','����.������.ͬ����','NXWZSTXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640381,'640381','����.������.��ͭϿ��','NXWZSQTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640400,'640400','����.��ԭ��','NXGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640402,'640402','����.��ԭ��.ԭ����','NXGYSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640422,'640422','����.��ԭ��.������','NXGYSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640423,'640423','����.��ԭ��.¡����','NXGYSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640424,'640424','����.��ԭ��.��Դ��','NXGYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640425,'640425','����.��ԭ��.������','NXGYSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640500,'640500','����.������','NXZWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640502,'640502','����.������.ɳ��ͷ��','NXZWSSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640521,'640521','����.������.������','NXZWSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640522,'640522','����.������.��ԭ��','NXZWSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650000,'650000','�½�','XJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650100,'650100','�½�.��³ľ����','XJWLMQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650102,'650102','�½�.��³ľ����.��ɽ��','XJWLMQSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650103,'650103','�½�.��³ľ����.ɳ���Ϳ���','XJWLMQSSYBKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650104,'650104','�½�.��³ľ����.������','XJWLMQSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650105,'650105','�½�.��³ľ����.ˮĥ����','XJWLMQSSMGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650106,'650106','�½�.��³ľ����.ͷ�ͺ���','XJWLMQSTTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650107,'650107','�½�.��³ľ����.�������','XJWLMQSDZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650109,'650109','�½�.��³ľ����.�׶���','XJWLMQSMDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650121,'650121','�½�.��³ľ����.��³ľ����','XJWLMQSWLMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650200,'650200','�½�.����������','XJKLMYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650202,'650202','�½�.����������.��ɽ����','XJKLMYSDSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650203,'650203','�½�.����������.����������','XJKLMYSKLMYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650204,'650204','�½�.����������.�׼�̲��','XJKLMYSBJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650205,'650205','�½�.����������.�ڶ�����','XJKLMYSWEHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652100,'652100','�½�.��³��','XJTLF'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652101,'652101','�½�.��³��.��³����','XJTLFTLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652122,'652122','�½�.��³��.۷����','XJTLFZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652123,'652123','�½�.��³��.�п�ѷ��','XJTLFTKXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652200,'652200','�½�.����','XJHM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652201,'652201','�½�.����.������','XJHMHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652222,'652222','�½�.����.��������','XJHMBLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652223,'652223','�½�.����.������','XJHMYWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652300,'652300','�½�.����','XJCJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652301,'652301','�½�.����.������','XJCJCJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652302,'652302','�½�.����.������','XJCJFKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652323,'652323','�½�.����.��ͼ����','XJCJHTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652324,'652324','�½�.����.����˹��','XJCJMNSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652325,'652325','�½�.����.��̨��','XJCJQTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652327,'652327','�½�.����.��ľ������','XJCJJMSEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652328,'652328','�½�.����.ľ����','XJCJMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652700,'652700','�½�.��������','XJBETL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652701,'652701','�½�.��������.������','XJBETLBLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652722,'652722','�½�.��������.������','XJBETLJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652723,'652723','�½�.��������.��Ȫ��','XJBETLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652800,'652800','�½�.��������','XJBYGL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652801,'652801','�½�.��������.�������','XJBYGLKELS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652822,'652822','�½�.��������.��̨��','XJBYGLLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652823,'652823','�½�.��������.ξ����','XJBYGLWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652824,'652824','�½�.��������.��Ǽ��','XJBYGLRQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652825,'652825','�½�.��������.��ĩ��','XJBYGLQMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652826,'652826','�½�.����','XJYZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652827,'652827','�½�.����.�;���','XJYZHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652828,'652828','�½�.����.��˶��','XJYZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652829,'652829','�½�.����.������','XJYZBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652900,'652900','�½�.������','XJAKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652901,'652901','�½�.������.��������','XJAKSAKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652922,'652922','�½�.������.������','XJAKSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652923,'652923','�½�.������.�⳵��','XJAKSKCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652924,'652924','�½�.������.ɳ����','XJAKSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652925,'652925','�½�.������.�º���','XJAKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652926,'652926','�½�.������.�ݳ���','XJAKSBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652927,'652927','�½�.������.��ʲ��','XJAKSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652928,'652928','�½�.������.��������','XJAKSAWTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652929,'652929','�½�.������.��ƺ��','XJAKSKPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653000,'653000','�½�.������','XJKZL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653001,'653001','�½�.������.��ͼʲ��','XJKZLATSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653022,'653022','�½�.������.��������','XJKZLAKTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653023,'653023','�½�.������.��������','XJKZLAHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653024,'653024','�½�.������.��ǡ��','XJKZLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653100,'653100','�½�.��ʲ','XJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653101,'653101','�½�.��ʲ.��ʲ��','XJKSKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653121,'653121','�½�.��ʲ.�踽��','XJKSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653122,'653122','�½�.��ʲ.������','XJKSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653123,'653123','�½�.��ʲ.Ӣ��ɳ��','XJKSYJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653124,'653124','�½�.��ʲ.������','XJKSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653125,'653125','�½�.��ʲ.ɯ����','XJKSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653126,'653126','�½�.��ʲ.Ҷ����','XJKSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653127,'653127','�½�.��ʲ.�������','XJKSMGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653128,'653128','�½�.��ʲ.���պ���','XJKSYPHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653129,'653129','�½�.��ʲ.٤ʦ��','XJKSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653130,'653130','�½�.��ʲ.�ͳ���','XJKSBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653131,'653131','�½�.��ʲ.��ʲ�������','XJKSTSKEGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653200,'653200','�½�.����','XJHT'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653201,'653201','�½�.����.������','XJHTHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653221,'653221','�½�.����.������','XJHTHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653222,'653222','�½�.����.ī����','XJHTMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653223,'653223','�½�.����.Ƥɽ��','XJHTPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653224,'653224','�½�.����.������','XJHTLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653225,'653225','�½�.����.������','XJHTCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653226,'653226','�½�.����.������','XJHTYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653227,'653227','�½�.����.�����','XJHTMFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654000,'654000','�½�.����','XJYL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654002,'654002','�½�.����.������','XJYLYNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654003,'654003','�½�.����.������','XJYLKTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654021,'654021','�½�.����.������','XJYLYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654022,'654022','�½�.����.�첼�������������','XJYLCBCEXBZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654023,'654023','�½�.����.������','XJYLHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654024,'654024','�½�.����.������','XJYLGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654025,'654025','�½�.����.��Դ��','XJYLXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654026,'654026','�½�.����.������','XJYLZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654027,'654027','�½�.����.�ؿ�˹��','XJYLTKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654028,'654028','�½�.����.���տ���','XJYLNLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654200,'654200','�½�.����','XJTC'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654201,'654201','�½�.����.������','XJTCTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654202,'654202','�½�.����.������','XJTCWSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654221,'654221','�½�.����.������','XJTCEMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654223,'654223','�½�.����.ɳ����','XJTCSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654224,'654224','�½�.����.������','XJTCTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654225,'654225','�½�.����.ԣ����','XJTCYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654226,'654226','�½�.����.�Ͳ���������','XJTCHBKSEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654300,'654300','�½�.����̩','XJALT'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654301,'654301','�½�.����̩.����̩��','XJALTALTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654321,'654321','�½�.����̩.��������','XJALTBEJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654322,'654322','�½�.����̩.������','XJALTFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654323,'654323','�½�.����̩.������','XJALTFHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654324,'654324','�½�.����̩.���ͺ���','XJALTHBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654325,'654325','�½�.����̩.�����','XJALTQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654326,'654326','�½�.����̩.��ľ����','XJALTJMNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659001,'659001','�½�.ʯ������','XJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659002,'659002','�½�.��������','XJALES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659003,'659003','�½�.ͼľ�����','XJTMSKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659004,'659004','�½�.�������','XJWJQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,710000,'710000','̨��ʡ','TWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,810000,'810000','����ر�������','XGTBXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,820000,'820000','�����ر�������','AMTBXZQ');
 
--2011-01-19 ��ɭ�����
--�����ֵ�
CREATE TABLE SYS_XDICT_INFO (
        --����AMOUNT
	XDICT_ID varchar (100) NOT NULL ,
        --���� 1
	XDICT_TYPE numeric(1, 0) NOT NULL ,
        --����
	XDICT_NAME varchar (255) NOT NULL ,
        --ƴ����
	XDICT_SPELL varchar (255) NOT NULL ,
        --���
	SEQ_NO int NOT NULL ,
	--ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
  --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
   CONSTRAINT PK_SYS_XDICT_INFO PRIMARY KEY (XDICT_ID,XDICT_TYPE)
) ;

CREATE INDEX IX_SYS_XDICT_INFO_TIME_STAMP ON SYS_XDICT_INFO(TIME_STAMP);

--frf��ӡ��ʽ�����
CREATE TABLE SYS_FASTFILE (
  --��ҵ����<0Ϊ��������>
	TENANT_ID int NOT NULL ,
	frfFileName varchar (50) NOT NULL ,
	frfFileTitle varchar (100) ,
	frfBlob blob ,
	frfBlob1 blob ,
	frfBlob2 blob ,
	frfBlob3 blob ,
	frfBlob4 blob ,
	frfBlob5 blob ,
	frfDefault int NOT NULL DEFAULT 0,
	--ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
  --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SYS_FASTFILE PRIMARY KEY (TENANT_ID,frfFileName)
);

CREATE INDEX IX_SYS_FASTFILE_TENANT_ID ON SYS_FASTFILE(TENANT_ID);

CREATE INDEX IX_SYS_FASTFILE_TIME_STAMP ON SYS_FASTFILE(TENANT_ID,TIME_STAMP);

--�ؽ�ID��ſ��Ʊ�
CREATE TABLE SYS_SEQUENCE (
  --��ҵ����
	TENANT_ID int NOT NULL ,
	SEQU_ID varchar (20) NOT NULL ,
	FLAG_TEXT varchar (20) ,
	SEQU_NO int ,
	--ͨѶ��־ 00 ���� 01�޸� 02 ɾ�� ��һλΪ0��ͬ��,1��ͬ��
	COMM varchar(2) NOT NULL DEFAULT '00',
  --����ʱ�� ��2011-01-01��ʼ������  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SYS_SEQUENCE PRIMARY KEY (TENANT_ID,SEQU_ID)
);

CREATE INDEX IX_SYS_SEQUENCE_TENANT_ID ON SYS_SEQUENCE(TENANT_ID);

CREATE INDEX IX_SYS_SEQUENCE_TIME_STAMP ON SYS_SEQUENCE(TENANT_ID,TIME_STAMP);

--ģ������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ģ��','MODU_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','MODU_TYPE','00',5497000);

--ģ���
CREATE TABLE CA_MODULE (
        --�����Ʒ
	PROD_ID varchar (10) NOT NULL ,
        --ģ�����
	MODU_ID varchar (20) NOT NULL ,
        --ģ��ʱ��Ϊ 0 ������ʱ��Ӧ byte ����λ�ú� 0101010(1)<ÿһλΪ1������Ȩ��>
	SEQNO int NOT NULL ,
        --ģ������
	MODU_NAME varchar (50) NOT NULL ,
        --�������� 3λһ��
	LEVEL_ID varchar (21) ,
        --ģ������ 
	MODU_TYPE int NOT NULL ,
        --R3 Delphiר��
	ACTION_NAME varchar (50) NOT NULL ,
        --R3 Web��ר��
	ACTION_URL varchar (50) NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
  --����ʱ�� ��2011-01-01��ʼ������  
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_CA_MODULE PRIMARY KEY (PROD_ID,MODU_ID)
);

CREATE INDEX IX_CA_MODULE_PROD_ID ON CA_MODULE(PROD_ID);

CREATE INDEX IX_CA_MODULE_TIME_STAMP ON CA_MODULE(TIME_STAMP);

--Ȩ�޿��Ʊ�
CREATE TABLE CA_RIGHTS (
    --�к� guidֵ
	ROWS_ID char (36) NOT NULL ,
    --��ҵ����
	TENANT_ID int NOT NULL ,
        --ģ�����
	MODU_ID varchar (20) NOT NULL ,
        --�û�������ɫ����
	ROLE_ID varchar (36) NOT NULL ,
        --�û�����
	ROLE_TYPE int NOT NULL ,
        --0��������ģ��û��Ȩ�� ���ƴ�ת10����
	CHK int NOT NULL ,
        --ͨ����־
	COMM varchar (2) NOT NULL DEFAULT '00',
  --����ʱ�� ��2011-01-01��ʼ������  
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_CA_RIGHTS PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_CA_RIGHTS_TENANT_ID ON CA_RIGHTS(TENANT_ID);

CREATE INDEX IX_CA_RIGHTS_MODU_ID ON CA_RIGHTS(TENANT_ID,ROLE_ID);

CREATE INDEX IX_CA_RIGHTS_TIME_STAMP ON CA_RIGHTS(TENANT_ID,TIME_STAMP);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('16','�Զ���ָ��','CODE_TYPE','00',5497000);

--��Ʒ����ָ��
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','����','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','Ʒ��','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','�ص�<�Ƿ��ص�Ʒ��>','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','ʡ����','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('7','��ɫ��','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('8','������','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','�Զ���9','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('10','�Զ���10','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','�Զ���11','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','�Զ���12','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('13','�Զ���13','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('14','�Զ���14','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('15','�Զ���15','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('16','�Զ���16','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('17','�Զ���17','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('18','�Զ���18','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('19','�Զ���19','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('20','�Զ���20','SORT_TYPE','00',5497000);

--��Ʒ��������
CREATE TABLE PUB_GOODSSORT (
        --�������<guid>
	SORT_ID varchar (36) NOT NULL ,
    --��ҵ���� 0������ͳһ����
	TENANT_ID int NOT NULL ,
        --��ID�� 4λһ��
	LEVEL_ID varchar (20) ,
        --��������
	SORT_NAME varchar (30) NOT NULL ,
        --�������� 
	SORT_TYPE int NOT NULL ,
        --ƴ����
	SORT_SPELL varchar (30) NOT NULL ,
        --�����
	SEQ_NO int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSSORT PRIMARY KEY (TENANT_ID,SORT_ID,SORT_TYPE)
);
CREATE INDEX IX_PUB_GOODSSORT_TENANT_ID ON PUB_GOODSSORT(TENANT_ID);

CREATE INDEX IX_PUB_GOODSSORT_SORT_TYPE ON PUB_GOODSSORT(TENANT_ID,SORT_TYPE);

CREATE INDEX IX_PUB_GOODSSORT_TIME_STAMP ON PUB_GOODSSORT(TENANT_ID,TIME_STAMP);


--��Ӫ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','������Ӫ','RELATION_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������Ӫ','RELATION_FLAG','00',5497000);


--��ɫ����
CREATE TABLE PUB_COLOR_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --��ɫ����<guid>
	COLOR_ID varchar (36) NOT NULL ,
        --��������<�����,�ŷָ�>
	SORT_ID7S varchar (36) NOT NULL ,
        --��������<�����,�ŷָ�>
	SORT_ID7_NAMES varchar (36) NOT NULL ,
        --��ɫ����
	COLOR_NAME varchar (30) NOT NULL ,
        --ƴ����
	COLOR_SPELL varchar (30) NOT NULL ,
        --������
	BARCODE_FLAG varchar (3) ,
        --�����
	SEQ_NO int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_COLOR_INFO PRIMARY KEY (TENANT_ID,COLOR_ID)
);
CREATE INDEX IX_PUB_COLOR_INFO_TENANT_ID ON PUB_COLOR_INFO(TENANT_ID);
CREATE INDEX IX_PUB_COLOR_INFO_TIME_STAMP ON PUB_COLOR_INFO(TENANT_ID,TIME_STAMP);

--��ҵ��Ӫ��ɫ����,�Ծ�Ӫ��ɫ����+������ɫ����

CREATE view VIW_COLOR_INFO
as
select 2 as RELATION_FLAG,TENANT_ID,COLOR_ID,SORT_ID7S,COLOR_NAME,COLOR_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_COLOR_INFO
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,COLOR_ID,SORT_ID7S,COLOR_NAME,COLOR_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_COLOR_INFO A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--���뵵��
CREATE TABLE PUB_SIZE_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�������<guid>
	SIZE_ID varchar (36) NOT NULL ,
        --��������<�����,�ŷָ�>
	SORT_ID8S varchar (36) NOT NULL ,
        --��������<�����,�ŷָ�>
	SORT_ID8_NAMES varchar (36) NOT NULL ,
        --��������
	SIZE_NAME varchar (30) NOT NULL ,
        --ƴ����
	SIZE_SPELL varchar (30) NOT NULL ,
        --������
	BARCODE_FLAG varchar (2) ,
        --�����
	SEQ_NO int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_SIZE_INFO PRIMARY KEY (TENANT_ID,SIZE_ID)
);
CREATE INDEX IX_PUB_SIZE_INFO_TENANT_ID ON PUB_SIZE_INFO(TENANT_ID);
CREATE INDEX IX_PUB_SIZE_INFO_TIME_STAMP ON PUB_SIZE_INFO(TENANT_ID,TIME_STAMP);

--��ҵ��Ӫ���뵵��,�Ծ�Ӫ���뵵��+���ӳ��뵵��

CREATE view VIW_SIZE_INFO
as
select 2 as RELATION_FLAG,TENANT_ID,SIZE_ID,SORT_ID8S,SIZE_NAME,SIZE_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_SIZE_INFO
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,SIZE_ID,SORT_ID8S,SIZE_NAME,SIZE_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_SIZE_INFO A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--��ҵ��Ӫ��Ʒ����,�Ծ�Ӫ����+��������
CREATE view VIW_GOODSSORT
as
select 1 as RELATION_FLAG,B.RELATION_ID,B.RELATION_NAME,C.RELATI_ID as TENANT_ID,SORT_ID,A.LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_GOODSSORT A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12')
union all
select 2 as RELATION_FLAG,0 as RELATION_ID,'������Ӫ' as RELATION_NAME,TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_GOODSSORT;

--������λ
CREATE TABLE PUB_MEAUNITS (
        --����<guid>
	UNIT_ID varchar (36) NOT NULL ,
    --��ҵ���� 0������ͳһ����
	TENANT_ID int NOT NULL ,
        --����
	UNIT_NAME varchar (10) NOT NULL ,
        --ƴ����
	UNIT_SPELL varchar (10) NOT NULL ,
        --�����
	SEQ_NO int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ�� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_MEAUNITS PRIMARY KEY (TENANT_ID,UNIT_ID)
);

CREATE INDEX IX_PUB_MEAUNITS_TENANT_ID ON PUB_MEAUNITS(TENANT_ID);

CREATE INDEX IX_PUB_MEAUNITS_TIME_STAMP ON PUB_MEAUNITS(TENANT_ID,TIME_STAMP);

--��ҵ��Ӫ������λ,�Ծ�Ӫ������λ+���Ӽ�����λ

CREATE view VIW_MEAUNITS
as
select 2 as RELATION_FLAG,TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_MEAUNITS
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_MEAUNITS A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--���ѡ��
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','Ҫ�ܿ��','GODS_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���ܿ��','GODS_TYPE','00',5497000);


--����ѡ��
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ɻ���','HAS_INTEGRAL','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','HAS_INTEGRAL','00',5497000);


--�Ƿ����ô����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','USING_PRICE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','USING_PRICE','00',5497000);


--�Ƿ���������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','USING_BATCH_NO','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','USING_BATCH_NO','00',5497000);


--�Ƿ���ƻ��ֻ���
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','������','USING_BARTER','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���ֶһ�','USING_BARTER','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','���ֻ���','USING_BARTER','00',5497000);

--�Ƿ���������������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','����','USING_LOCUS_NO','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','USING_LOCUS_NO','00',5497000);

--��Ʒ����
CREATE TABLE PUB_GOODSINFO (
        --���ű���,ϵͳ�Ա�Ψһ��
	GODS_ID char (36) NOT NULL ,
        --��ҵ���� 0 Ϊ����ά��
	TENANT_ID int NOT NULL ,
        --����<����ʶ����>
	GODS_CODE varchar (20) NOT NULL ,
        --Ʒ��+���
	GODS_NAME varchar (50) NOT NULL ,
        --ƴ����
	GODS_SPELL varchar (50) NOT NULL ,
        --���ѡ��
	GODS_TYPE integer ,
        --����1
	SORT_ID1 varchar (36) ,
        --����2
	SORT_ID2 varchar (36) ,
        --����3
	SORT_ID3 varchar (36) ,
        --����4
	SORT_ID4 varchar (36) ,
        --����5
	SORT_ID5 varchar (36) ,
        --����6
	SORT_ID6 varchar (36) ,
        --��ɫ��
	SORT_ID7 varchar (36) ,
        --������
	SORT_ID8 varchar (36) ,
        --�Զ���9
	SORT_ID9 varchar (36) ,
        --�Զ���10
	SORT_ID10 varchar (36) ,
        --�Զ���11
	SORT_ID11 varchar (36) ,
        --�Զ���12
	SORT_ID12 varchar (36) ,
        --�Զ���13
	SORT_ID13 varchar (36) ,
        --�Զ���14
	SORT_ID14 varchar (36) ,
        --�Զ���15
	SORT_ID15 varchar (36) ,
        --�Զ���16
	SORT_ID16 varchar (36) ,
        --�Զ���17
	SORT_ID17 varchar (36) ,
        --�Զ���18
	SORT_ID18 varchar (36) ,
        --�Զ���19
	SORT_ID19 varchar (36) ,
        --�Զ���20
	SORT_ID20 varchar (36) ,
	      --������λ����
	BARCODE varchar (30) ,
        --Ĭ�ϵ�λ
	UNIT_ID varchar (36) NOT NULL ,
        --������λ
	CALC_UNITS varchar (36) NOT NULL ,
        --��װ1��λ
	SMALL_UNITS varchar (36) ,
        --��װ2��λ
	BIG_UNITS varchar (36) ,
        --��װ1ת��ϵ��
	SMALLTO_CALC decimal(18, 3) ,
        --��װ2ת��ϵ��
	BIGTO_CALC decimal(18, 3) ,
        --��׼����
	NEW_INPRICE decimal(18, 3) ,
        --��׼�ۼ�
	NEW_OUTPRICE decimal(18, 3) ,
        --����ۼ�
	NEW_LOWPRICE decimal(18, 3) ,
        --�Ƿ������ۿ��� 1����,2����
	USING_PRICE int NOT NULL ,
        --�Ƿ�ο�����
	HAS_INTEGRAL int NOT NULL ,
        --�Ƿ�ʹ�����Ź���
	USING_BATCH_NO int NOT NULL ,
        --�Ƿ���ƻ��ֻ���
	USING_BARTER int NOT NULL ,
        --�Ƿ��������������
	USING_LOCUS_NO int NOT NULL ,
        --���ֻ�������
	BARTER_INTEGRAL int NOT NULL ,
        --��ע
	REMARK varchar (200) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ�� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSINFO PRIMARY KEY (TENANT_ID,GODS_ID)
);

CREATE INDEX IX_PUB_GOODSINFO_TENANT_ID ON PUB_GOODSINFO(TENANT_ID);

CREATE INDEX IX_PUB_GOODSINFO_GODS_ID ON PUB_GOODSINFO(GODS_ID);

CREATE INDEX IX_PUB_GOODSINFO_TIME_STAMP ON PUB_GOODSINFO(TENANT_ID,TIME_STAMP);

--���·����Ĺ�Ӧ������Ʒ
CREATE TABLE PUB_GOODS_RELATION (
        --�к�ID <guid>
	ROWS_ID char (36) NOT NULL ,
        --��ҵ���� 
	TENANT_ID int NOT NULL ,
        --��Ӧ��
	RELATION_ID int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL , 
        --��ҵ����<������ϵͳ����>
	SECOND_ID varchar (36) , 
        --����<ʶ����>
	GODS_CODE varchar (36) , 
        --Ʒ��+���
	GODS_NAME varchar (50) NOT NULL ,
        --ƴ����
	GODS_SPELL varchar (50) NOT NULL ,
        --����1
	SORT_ID1 varchar (36) ,
        --����2
	SORT_ID2 varchar (36) ,
        --����3
	SORT_ID3 varchar (36) ,
        --����4
	SORT_ID4 varchar (36) ,
        --����5
	SORT_ID5 varchar (36) ,
        --����6
	SORT_ID6 varchar (36) ,
        --��ɫ��
	SORT_ID7 varchar (36) ,
        --������
	SORT_ID8 varchar (36) ,
        --�Զ���9
	SORT_ID9 varchar (36) ,
        --�Զ���10
	SORT_ID10 varchar (36) ,
        --�Զ���11
	SORT_ID11 varchar (36) ,
        --�Զ���12
	SORT_ID12 varchar (36) ,
        --�Զ���13
	SORT_ID13 varchar (36) ,
        --�Զ���14
	SORT_ID14 varchar (36) ,
        --�Զ���15
	SORT_ID15 varchar (36) ,
        --�Զ���16
	SORT_ID16 varchar (36) ,
        --�Զ���17
	SORT_ID17 varchar (36) ,
        --�Զ���18
	SORT_ID18 varchar (36) ,
        --�Զ���19
	SORT_ID19 varchar (36) ,
        --�Զ���20
	SORT_ID20 varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_RELATION PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_GOODS_RELATION_RELATION_ID ON PUB_GOODS_RELATION(RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_GODS_ID ON PUB_GOODS_RELATION(GODS_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_KEYFIELD ON PUB_GOODS_RELATION(TENANT_ID,GODS_ID,RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_TIME_STAMP ON PUB_GOODS_RELATION(TENANT_ID,TIME_STAMP);


--��ҵ��Ӫ��Ʒ��ͼ,�Ծ�Ӫ��Ʒ+������Ʒ                                              
CREATE view VIW_GOODSINFO
as
select 1 as RELATION_FLAG,B.RELATION_ID,C.RELATI_ID as TENANT_ID,A.GODS_ID,coalesce(B.GODS_CODE,A.GODS_CODE) as GODS_CODE,B.GODS_CODE as SECOND_CODE,B.SECOND_ID,coalesce(B.GODS_NAME,A.GODS_NAME) as GODS_NAME,coalesce(B.GODS_SPELL,A.GODS_SPELL) as GODS_SPELL,GODS_TYPE,
       coalesce(B.SORT_ID1,A.SORT_ID1) as SORT_ID1,
       coalesce(B.SORT_ID2,A.SORT_ID2) as SORT_ID2,
       coalesce(B.SORT_ID3,A.SORT_ID3) as SORT_ID3,
       coalesce(B.SORT_ID4,A.SORT_ID4) as SORT_ID4,
       coalesce(B.SORT_ID5,A.SORT_ID5) as SORT_ID5,
       coalesce(B.SORT_ID6,A.SORT_ID6) as SORT_ID6,
       coalesce(B.SORT_ID7,A.SORT_ID7) as SORT_ID7,
       coalesce(B.SORT_ID8,A.SORT_ID8) as SORT_ID8,
       coalesce(B.SORT_ID9,A.SORT_ID9) as SORT_ID9,
       coalesce(B.SORT_ID10,A.SORT_ID10) as SORT_ID10,
       coalesce(B.SORT_ID11,A.SORT_ID11) as SORT_ID11,
       coalesce(B.SORT_ID12,A.SORT_ID12) as SORT_ID12,
       coalesce(B.SORT_ID13,A.SORT_ID13) as SORT_ID13,
       coalesce(B.SORT_ID14,A.SORT_ID14) as SORT_ID14,
       coalesce(B.SORT_ID15,A.SORT_ID15) as SORT_ID15,
       coalesce(B.SORT_ID16,A.SORT_ID16) as SORT_ID16,
       coalesce(B.SORT_ID17,A.SORT_ID17) as SORT_ID17,
       coalesce(B.SORT_ID18,A.SORT_ID18) as SORT_ID18,
       coalesce(B.SORT_ID19,A.SORT_ID19) as SORT_ID19,
       coalesce(B.SORT_ID20,A.SORT_ID20) as SORT_ID20,
       BARCODE,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_BARTER,BARTER_INTEGRAL,
       USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,REMARK,'#' as PRICE_ID,A.COMM,A.TIME_STAMP
from PUB_GOODSINFO A,PUB_GOODS_RELATION B,CA_RELATIONS C
where A.GODS_ID=B.GODS_ID and B.RELATION_ID=C.RELATION_ID and  
( (B.TENANT_ID=C.TENANT_ID  and C.RELATION_TYPE<>'1')
  or
  (B.TENANT_ID=C.RELATI_ID  and C.RELATION_TYPE='1')
)
and B.COMM not in ('02','12') and C.COMM not in ('02','12') and C.RELATION_STATUS='2'
union all
select 2 as RELATION_FLAG,0 as RELATION_ID,TENANT_ID,GODS_ID,GODS_CODE,GODS_CODE as SECOND_CODE,GODS_ID as SECOND_ID,GODS_NAME,GODS_SPELL,GODS_TYPE,
       SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,
       SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,
       SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,
       BARCODE,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_BARTER,BARTER_INTEGRAL,
       USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,REMARK,'#' as PRICE_ID,COMM,TIME_STAMP
from PUB_GOODSINFO;

--��������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������λ','BARCODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��װ1','BARCODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��װ2','BARCODE_TYPE','00',5497000);

--�����
CREATE TABLE PUB_BARCODE (
        --�к�ID
	ROWS_ID char (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL , 
        --����ID
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫID
	PROPERTY_02 varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --��������
	BARCODE_TYPE varchar(1) NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
        --����
	BARCODE varchar (30) NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_BARCODE PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_BARCODE_TENANT_ID ON PUB_BARCODE(TENANT_ID);

CREATE INDEX IX_PUB_BARCODE_TIME_STAMP ON PUB_BARCODE(TENANT_ID,TIME_STAMP);

CREATE INDEX IX_PUB_BARCODE_GODS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID);

CREATE INDEX IX_PUB_BARCODE_BARCODE ON PUB_BARCODE(TENANT_ID,BARCODE);

CREATE INDEX IX_PUB_BARCODE_ROWS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID);

--��ҵ��Ӫ�����,�Ծ�Ӫ������λ+����������λ
CREATE view VIW_BARCODE
as
select 2 as RELATION_FLAG,TENANT_ID,ROWS_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP
from PUB_BARCODE
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,D.ROWS_ID,D.GODS_ID,PROPERTY_01,PROPERTY_02,D.UNIT_ID,BARCODE_TYPE,BATCH_NO,D.BARCODE,D.COMM,D.TIME_STAMP
from PUB_GOODSINFO A,PUB_GOODS_RELATION B,CA_RELATIONS C,PUB_BARCODE D
where A.GODS_ID=B.GODS_ID and B.RELATION_ID=C.RELATION_ID and  
( (B.TENANT_ID=C.TENANT_ID  and C.RELATION_TYPE<>'1')
  or
  (B.TENANT_ID=C.RELATI_ID  and C.RELATION_TYPE='1')
)
and B.COMM not in ('02','12') and C.COMM not in ('02','12') and C.RELATION_STATUS='2'
and A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID;


--���۷�ʽ
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ͳһ����','PRICE_METHOD','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�ŵ궨��','PRICE_METHOD','00',5497000);

--�Ż�����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','���Ż�','AGIO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ͳһ�ۿ���','AGIO_TYPE','00',5497000); 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','�����ۿ���','AGIO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','ָ���ۼ�','AGIO_TYPE','00',5497000);

--��������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','������','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��������','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ë������','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','����������','INTE_TYPE','00',5497000);

--�ͻ�����
CREATE TABLE PUB_PRICEGRADE (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --����
	PRICE_ID char (36) NOT NULL ,
        --����
	PRICE_NAME varchar (30) NOT NULL ,
        --ƴ����
	PRICE_SPELL varchar (30) NOT NULL ,
        --���ֱ�׼
	INTEGRAL numeric(18, 3) ,
        --���ַ���
	INTE_TYPE int ,
        --����ϵ�� 1��=���ٽ��/ë��/����
	INTE_AMOUNT decimal(18, 3) ,
        --����ۿ���
	MINIMUM_PERCENT numeric(6, 3) ,
        --�Ż�����
	AGIO_TYPE int ,
        --ָ���ۿ���
	AGIO_PERCENT numeric(6, 3) ,
        --�����ۿ���
	AGIO_SORTS varchar (1000) ,
        --�����
	SEQ_NO int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_PRICEGRADE PRIMARY KEY (TENANT_ID,PRICE_ID)
);
CREATE INDEX IX_PUB_PRICEGRADE_TENANT_ID ON PUB_PRICEGRADE(TENANT_ID);
CREATE INDEX IX_PUB_PRICEGRADE_TIME_STAMP ON PUB_PRICEGRADE(TENANT_ID,TIME_STAMP);

--���˵���
CREATE TABLE PUB_UNION_INFO (
        --<�������˵���ҵ,0ʱ����ȫ��ͳһ��ƽ̨����>
	TENANT_ID int NOT NULL ,
        --���˱���
	UNION_ID varchar (36) NOT NULL ,
        --��������
	UNION_NAME varchar (50) NOT NULL ,
        --ƴ����
	UNION_SPELL varchar (50) NOT NULL ,
        --0 ����ָ�� 1����ָ��
	INDEX_FLAG varchar (1) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_UNION_INFO PRIMARY KEY (TENANT_ID,UNION_ID)
);

CREATE INDEX IX_PUB_UNION_INFO_TENANT_ID ON PUB_UNION_INFO(TENANT_ID);
CREATE INDEX IX_PUB_UNION_INFO_TIME_STAMP ON PUB_UNION_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_UNION_INFO_CLIENT_ID ON PUB_UNION_INFO(UNION_ID);

--����ָ��
CREATE TABLE PUB_UNION_INDEX (
        --<�������˵���ҵ,0ʱ����ȫ��ͳһ��ƽ̨����>
	TENANT_ID int NOT NULL ,
        --���˱���
	UNION_ID varchar (36) NOT NULL ,
        --ָ�����
	INDEX_ID varchar (36) NOT NULL ,
        --ָ������
	INDEX_NAME varchar (50) NOT NULL ,
        --ƴ����
	INDEX_SPELL varchar (50) NOT NULL ,
        --ָ������ 1��ָ��ѡ�� ��2��SQL����ѡ�� �ɴ�TENANT_ID����, 3��ֵ�� 4 ������
	INDEX_TYPE varchar (1) NOT NULL ,
        --ָ��ѡ��
	INDEX_OPTION varchar (255) NOT NULL ,
        --�Ƿ������ 1�ǲ���Ϊ�� 2 ����Ϊ��
	INDEX_ISNULL varchar (1) NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_UNION_INDEX PRIMARY KEY (TENANT_ID,UNION_ID,INDEX_ID)
);

CREATE INDEX IX_PUB_UNION_INDEX_TENANT_ID ON PUB_UNION_INDEX(TENANT_ID);
CREATE INDEX IX_PUB_UNION_INDEX_TIME_STAMP ON PUB_UNION_INDEX(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_UNION_INDEX_CLIENT_ID ON PUB_UNION_INDEX(TENANT_ID,UNION_ID);


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','�ͻ�����','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','���㷽ʽ','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('7','���б���','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','��Ӧ�̷���','CODE_TYPE','00',5497000);

--��ҵ�ͻ�
CREATE TABLE PUB_CLIENTINFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --����
	CLIENT_ID varchar (36) NOT NULL ,
        --1 �ǹ�Ӧ�� 2�ǿͻ�
	CLIENT_TYPE varchar (1) NOT NULL ,
        --����,<��ʶ��> 
	CLIENT_CODE varchar (20) NOT NULL ,
        --��Ӫ���֤ 
	LICENSE_CODE varchar (50) ,
        --����
	CLIENT_NAME varchar (50) NOT NULL ,
        --ƴ����
	CLIENT_SPELL varchar (50) NOT NULL ,
        --�������
	SORT_ID varchar (36) NOT NULL ,
        --��������
	REGION_ID varchar (21) NOT NULL ,
        --���ʷ�ʽ
	SETTLE_CODE varchar (36) NOT NULL ,
        --��ַ
	ADDRESS varchar (50) ,
        --�ʱ�
	POSTALCODE varchar (6) ,
        --��ϵ��
	LINKMAN varchar (10) ,
        --�绰3
	TELEPHONE3 varchar (30) ,
        --�绰1
	TELEPHONE1 varchar (30) ,
        --�绰2
	TELEPHONE2 varchar (30) ,
        --����
	FAXES varchar (30) ,
        --��ҳ
	HOMEPAGE varchar (50) ,
        --�����ʼ�
	EMAIL varchar (50) ,
        --QQ
  QQ    varchar  (20),
        --MSN
  MSN    varchar  (35),
        --������
	BANK_ID varchar (10) ,
        --�ʻ�
	ACCOUNT varchar (20) ,
        --��Ʊ����
	INVOICE_FLAG varchar (50) ,
        --��ע
  REMARK varchar (200),
        --����˰��
	TAX_RATE decimal(18, 3) ,
        --�ͻ��ȼ�
	PRICE_ID char (36) ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CLIENTINFO PRIMARY KEY (TENANT_ID,CLIENT_ID)
);

CREATE INDEX IX_PUB_CLIENTINFO_TENANT_ID ON PUB_CLIENTINFO(TENANT_ID);
CREATE INDEX IX_PUB_CLIENTINFO_TIME_STAMP ON PUB_CLIENTINFO(TENANT_ID,TIME_STAMP);

--����������<��Ա>
CREATE TABLE PUB_CUSTOMER (
        --��Ա����
	CUST_ID varchar (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --��Ա��
	CUST_CODE varchar (20) NOT NULL ,
        --��Ա����
	CUST_NAME varchar (30) NOT NULL ,
        --ƴ����
	CUST_SPELL varchar (30) NOT NULL ,
        --�Ա�
	SEX varchar (4) ,
        --�����ʼ�
	EMAIL varchar (50) ,
        --�취�绰
	OFFI_TELE varchar (30) ,
        --��ͥ�绰
	FAMI_TELE varchar (30) ,
        --�ƶ��绰
	MOVE_TELE varchar (30) ,
        --����
	BIRTHDAY varchar (10) ,
        --��ͥ��ַ
	FAMI_ADDR varchar (50) ,
        --�ʱ�
	POSTALCODE varchar (6) ,
    --֤������
	ID_NUMBER varchar(50),
    --֤������
	IDN_TYPE varchar(36),
        --�������
	SND_DATE varchar (10) ,
        --��������
	CON_DATE varchar (10) ,
        --QQ
  QQ    varchar  (20),
        --MSN
  MSN    varchar  (35),
        --��Ч����
	END_DATE varchar (10) ,
        --��Ա����
	SORT_ID varchar (36) ,
        --�ͻ��ȼ�
	PRICE_ID char (36) ,
        --��������
	REGION_ID varchar (21) NOT NULL ,
	      --������
	MONTH_PAY varchar(36),
	      --ѧ��
	DEGREES varchar(36),
	      --ְҵ
	OCCUPATION varchar(36),
	      --������λ
	JOBUNIT varchar(50),
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --��ע
	REMARK varchar (500) ,
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CUSTOMER PRIMARY KEY (TENANT_ID,CUST_ID)
);

CREATE INDEX IX_PUB_CUSTOMER_TENANT_ID ON PUB_CUSTOMER(TENANT_ID);
CREATE INDEX IX_PUB_CUSTOMER_TIME_STAMP ON PUB_CUSTOMER(TENANT_ID,TIME_STAMP);

--���������ռ�����
CREATE TABLE PUB_CUSTOMER_EXT (
        --���
	ROWS_ID char (36) NOT NULL ,
        --��ҵ��
	TENANT_ID int NOT NULL ,
        --���˱���
	UNION_ID varchar (36) NOT NULL ,
        --��Ա����
	CUST_ID varchar (36) NOT NULL ,
        --ָ����
	INDEX_ID varchar (36) ,
        --ָ������
	INDEX_NAME varchar (50) ,
        --ָ������
	INDEX_TYPE varchar (50) ,
        --ָ��ֵ
	INDEX_VALUE varchar (50) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CUST_EXT PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_PUB_CUSTOMER_EXT_TENANT_ID ON PUB_CUSTOMER_EXT(TENANT_ID);
CREATE INDEX IX_PUB_CUSTOMER_EXT_TIME_STAMP ON PUB_CUSTOMER_EXT(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_CUSTOMER_EXT_CUST_ID ON PUB_CUSTOMER_EXT(TENANT_ID,CUST_ID);
CREATE INDEX IX_PUB_CUSTOMER_EXT_INDEX_ID ON PUB_CUSTOMER_EXT(TENANT_ID,UNION_ID,CUST_ID,INDEX_ID);


--IC״̬
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','����','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ʧ','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','ע��','IC_STATUS','00',5497000);

--IC����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','��ҵ��','IC_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���˿�','IC_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���￨','IC_TYPE','00',5497000);

--IC����Ϣ
CREATE TABLE PUB_IC_INFO (
        --��Ա����<��������ʱ��Ϊ#>
	CLIENT_ID varchar (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --���˱��<�������˿�ʱ��Ϊ#>
	UNION_ID varchar (36) NOT NULL ,
        --IC����
	IC_CARDNO varchar (36) NOT NULL ,
        --��������
	CREA_DATE varchar (10) NOT NULL ,
        --��Ч��ֹ����
	END_DATE varchar (10) ,
        --�����û�
	CREA_USER varchar (36) NOT NULL ,
        --ժҪ
	IC_INFO varchar (100) NOT NULL ,
        --IC��״̬
	IC_STATUS varchar (1) NOT NULL ,
        --IC������
	IC_TYPE varchar (1) NOT NULL ,
        --�ۼƻ���
	ACCU_INTEGRAL decimal(10, 3) ,
        --ʹ�û���
	RULE_INTEGRAL decimal(18, 3) ,
        --���û���
	INTEGRAL decimal(18, 3) ,
        --�������
	BALANCE decimal(18, 3) ,
        --��������
	PASSWRD varchar (50) ,
        --���ʹ������
	USING_DATE varchar (10) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_IC_INFO PRIMARY KEY (TENANT_ID,UNION_ID,IC_CARDNO)     
    
);

CREATE INDEX IX_PUB_IC_INFO_TENANT_ID ON PUB_IC_INFO(TENANT_ID);
CREATE INDEX IX_PUB_IC_INFO_TIME_STAMP ON PUB_IC_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_IC_INFO_CLIENT_ID ON PUB_IC_INFO(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_PUB_IC_INFO_IC_CARDNO ON PUB_IC_INFO(TENANT_ID,IC_CARDNO);


--��Ӧ��+�ҵĹ�Ӧ��+�ҵľ�����
CREATE VIEW VIW_CLIENTINFO
as
select 0 as FLAG,TENANT_ID,CLIENT_ID,LICENSE_CODE,CLIENT_TYPE,CLIENT_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,
BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,SHOP_ID,'' as IC_CARDNO,COMM,TIME_STAMP from PUB_CLIENTINFO where CLIENT_TYPE in ('0','1')
union all
select 1 as FLAG,B.RELATI_ID as TENANT_ID,trim(char(A.TENANT_ID)) as CLIENT_ID,A.LICENSE_CODE,'1' as CLIENT_TYPE,A.LOGIN_NAME as CLIENT_CODE,A.TENANT_NAME as CLIENT_NAME,A.TENANT_SPELL as CLIENT_SPELL,
'----' as SORT_ID,A.REGION_ID,'#' as SETTLE_CODE,A.ADDRESS,A.POSTALCODE,A.LINKMAN,A.TELEPHONE as TELEPHONE3,A.TELEPHONE as TELEPHONE1,A.TELEPHONE as TELEPHONE2,
A.FAXES,A.HOMEPAGE,'' as EMAIL,A.QQ,A.MSN,'' as BANK_ID,'' as ACCOUNT,'0' as INVOICE_FLAG,A.REMARK,0 as TAX_RATE,'#' as PRICE_ID,'0' as SHOP_ID,'' as IC_CARDNO,A.COMM,A.TIME_STAMP 
from CA_TENANT A,CA_RELATIONS B where A.TENANT_ID=B.TENANT_ID
union all
select 3 as FLAG,TENANT_ID,trim(char(TENANT_ID)) as CLIENT_ID,LICENSE_CODE,'1' as CLIENT_TYPE,LOGIN_NAME as CLIENT_CODE,TENANT_NAME as CLIENT_NAME,TENANT_SPELL as CLIENT_SPELL,
'----' as SORT_ID,REGION_ID,'#' as SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE as TELEPHONE3,TELEPHONE as TELEPHONE1,TELEPHONE as TELEPHONE2,
FAXES,HOMEPAGE,'' as EMAIL,QQ,MSN,'' as BANK_ID,'' as ACCOUNT,'0' as INVOICE_FLAG,REMARK,0 as TAX_RATE,'#' as PRICE_ID,'0' as SHOP_ID,'' as IC_CARDNO,COMM,TIME_STAMP 
from CA_TENANT;

--����������<��Ա+��ҵ�ͻ�>
CREATE VIEW VIW_CUSTOMER
as
select j.*,ic.IC_CARDNO,ic.BALANCE,ic.INTEGRAL,ic.ACCU_INTEGRAL,ic.RULE_INTEGRAL from (
select 0 as FLAG,TENANT_ID,CLIENT_ID,LICENSE_CODE,CLIENT_TYPE,CLIENT_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,
BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,SHOP_ID,'#' as UNION_ID,COMM,TIME_STAMP from PUB_CLIENTINFO where CLIENT_TYPE in ('0','2')
union all
select 1 as FLAG,B.TENANT_ID as TENANT_ID,trim(char(A.TENANT_ID)) as CLIENT_ID,A.LICENSE_CODE,'2' as CLIENT_TYPE,A.LOGIN_NAME as CLIENT_CODE,A.TENANT_NAME as CLIENT_NAME,A.TENANT_SPELL as CLIENT_SPELL,
'----' as SORT_ID,A.REGION_ID,'#' as SETTLE_CODE,A.ADDRESS,A.POSTALCODE,A.LINKMAN,A.TELEPHONE as TELEPHONE3,A.TELEPHONE as TELEPHONE1,A.TELEPHONE as TELEPHONE2,
A.FAXES,A.HOMEPAGE,'' as EMAIL,A.QQ,A.MSN,'' as BANK_ID,'' as ACCOUNT,'0' as INVOICE_FLAG,A.REMARK,0 as TAX_RATE,'#' as PRICE_ID,'0' as SHOP_ID,'#' as UNION_ID,A.COMM,A.TIME_STAMP 
from CA_TENANT A,CA_RELATIONS B where A.TENANT_ID=B.RELATI_ID
union all
select 2 as FLAG,TENANT_ID,CUST_ID as CLIENT_ID,ID_NUMBER as LICENSE_CODE,'2' as CLIENT_TYPE,CUST_CODE as CLIENT_CODE,CUST_NAME as CLIENT_NAME,CUST_SPELL as CLIENT_SPELL,
SORT_ID,REGION_ID,'#' as SETTLE_CODE,FAMI_ADDR as ADDRESS,POSTALCODE,CUST_NAME as LINKMAN,FAMI_TELE as TELEPHONE3,OFFI_TELE as TELEPHONE1,MOVE_TELE as TELEPHONE2,
'' as FAXES,'' as HOMEPAGE,EMAIL,QQ,MSN,'' as BANK_ID,'' as ACCOUNT,'0' as INVOICE_FLAG,REMARK,0 as TAX_RATE,PRICE_ID,SHOP_ID,'#' as UNION_ID,COMM,TIME_STAMP 
from PUB_CUSTOMER
union all
select 3 as FLAG,TENANT_ID,trim(char(TENANT_ID)) as CLIENT_ID,LICENSE_CODE,'2' as CLIENT_TYPE,LOGIN_NAME as CLIENT_CODE,TENANT_NAME as CLIENT_NAME,TENANT_SPELL as CLIENT_SPELL,
'----' as SORT_ID,REGION_ID,'#' as SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE as TELEPHONE3,TELEPHONE as TELEPHONE1,TELEPHONE as TELEPHONE2,
FAXES,HOMEPAGE,'' as EMAIL,QQ,MSN,'' as BANK_ID,'' as ACCOUNT,'0' as INVOICE_FLAG,REMARK,0 as TAX_RATE,'#' as PRICE_ID,'0' as SHOP_ID,'#' as UNION_ID,COMM,TIME_STAMP 
from CA_TENANT) j left outer join PUB_IC_INFO ic on j.TENANT_ID=ic.TENANT_ID and j.CLIENT_ID=ic.CLIENT_ID and j.UNION_ID=ic.UNION_ID;

--��Ʒ�۸�
CREATE TABLE PUB_GOODSPRICE (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	PRICE_ID char (36) NOT NULL , 
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���ű���
	GODS_ID char (36) NOT NULL ,
        --���۷�ʽ<��۷�ʽ>
	PRICE_METHOD varchar (1) NOT NULL ,
        --������λ�ۼ�
	NEW_OUTPRICE decimal(18, 3) ,
        --��װ1��λ�ۼ�
	NEW_OUTPRICE1 decimal(18, 3) ,
        --��װ2��λ�ۼ�
	NEW_OUTPRICE2 decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ�� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSPRICE PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
);

CREATE INDEX IX_PUB_GOODSPRICE_TENANT_ID ON PUB_GOODSPRICE(TENANT_ID);
CREATE INDEX IX_PUB_GOODSPRICE_SHOP_ID ON PUB_GOODSPRICE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_PUB_GOODSPRICE_GODS_ID ON PUB_GOODSPRICE(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSPRICE_PRICE_ID ON PUB_GOODSPRICE(TENANT_ID,PRICE_ID);
CREATE INDEX IX_PUB_GOODSPRICE_TIME_STAMP ON PUB_GOODSPRICE(TENANT_ID,TIME_STAMP);

--����Ʒ����ҵ�ܲ��ļ۸�<�ۼ�>�������ŵ�
CREATE view VIW_GOODSINFOEXT
as
select A.TENANT_ID,A.RELATION_ID,
       A.PRICE_ID,A.GODS_ID,A.GODS_CODE,A.GODS_ID as SECOND_ID,A.GODS_NAME,A.GODS_SPELL,A.GODS_TYPE,
       A.SORT_ID1,A.SORT_ID2,A.SORT_ID3,A.SORT_ID4,A.SORT_ID5,A.SORT_ID6,A.SORT_ID7,A.SORT_ID8,
       A.SORT_ID9,A.SORT_ID10,A.SORT_ID11,A.SORT_ID12,A.SORT_ID13,A.SORT_ID14,A.SORT_ID15,A.SORT_ID16,
       A.SORT_ID17,A.SORT_ID18,A.SORT_ID19,A.SORT_ID20,
       A.BARCODE,A.UNIT_ID,A.CALC_UNITS,A.SMALL_UNITS,A.BIG_UNITS,A.SMALLTO_CALC,A.BIGTO_CALC,A.NEW_INPRICE,A.NEW_OUTPRICE as RTL_OUTPRICE,
       1 as POLICY_TYPE,
       case when coalesce(B.COMM,'02') not in ('02','12') then B.NEW_OUTPRICE else A.NEW_OUTPRICE end NEW_OUTPRICE,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE1,B.NEW_OUTPRICE*A.SMALLTO_CALC) else A.NEW_OUTPRICE*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE2,B.NEW_OUTPRICE*A.BIGTO_CALC) else A.NEW_OUTPRICE*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.NEW_LOWPRICE,A.USING_BARTER,A.BARTER_INTEGRAL,
       A.USING_PRICE,A.HAS_INTEGRAL,A.USING_BATCH_NO,A.USING_LOCUS_NO,A.REMARK,A.COMM,A.TIME_STAMP
from VIW_GOODSINFO A left join PUB_GOODSPRICE B ON A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and trim(char(A.TENANT_ID))||'0001'=B.SHOP_ID and A.PRICE_ID=B.PRICE_ID;

--ÿ���ŵ궼�м�¼����������ŵ�
--����Ʒ�۸�
CREATE view VIW_GOODSPRICE
as
select A.TENANT_ID,A.RELATION_ID,C.SHOP_ID,
       A.PRICE_ID,A.GODS_ID,A.GODS_CODE,A.GODS_ID as SECOND_ID,A.GODS_NAME,A.GODS_SPELL,A.GODS_TYPE,
       A.SORT_ID1,A.SORT_ID2,A.SORT_ID3,A.SORT_ID4,A.SORT_ID5,A.SORT_ID6,A.SORT_ID7,A.SORT_ID8,
       A.SORT_ID9,A.SORT_ID10,A.SORT_ID11,A.SORT_ID12,A.SORT_ID13,A.SORT_ID14,A.SORT_ID15,A.SORT_ID16,
       A.SORT_ID17,A.SORT_ID18,A.SORT_ID19,A.SORT_ID20,
       A.BARCODE,A.UNIT_ID,A.CALC_UNITS,A.SMALL_UNITS,A.BIG_UNITS,A.SMALLTO_CALC,A.BIGTO_CALC,A.NEW_INPRICE,A.RTL_OUTPRICE,
       case when coalesce(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when coalesce(B.COMM,'02') not in ('02','12') then B.NEW_OUTPRICE else A.NEW_OUTPRICE end NEW_OUTPRICE,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE1,B.NEW_OUTPRICE*A.SMALLTO_CALC) else A.NEW_OUTPRICE*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE2,B.NEW_OUTPRICE*A.BIGTO_CALC) else A.NEW_OUTPRICE*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.NEW_LOWPRICE,A.USING_BARTER,A.BARTER_INTEGRAL,
       A.USING_PRICE,A.HAS_INTEGRAL,A.USING_BATCH_NO,A.USING_LOCUS_NO,A.REMARK,A.COMM,A.TIME_STAMP
from VIW_GOODSINFOEXT A inner join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID
left join PUB_GOODSPRICE B ON C.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.PRICE_ID=B.PRICE_ID;

--��Ʒ��չ��
CREATE TABLE PUB_GOODSINFOEXT (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --���ű���
	GODS_ID char (36) NOT NULL ,
        --������λ���½���
	NEW_INPRICE decimal(18, 3) ,
        --��װ1��λ���½���
	NEW_INPRICE1 decimal(18, 3) ,
        --��װ2��λ���½���
	NEW_INPRICE2 decimal(18, 3) ,
        --��ȫ���
	LOWER_AMOUNT decimal(18, 3) ,
        --���޿��
	UPPER_AMOUNT decimal(18, 3) ,
        --��ʹ�����
	LOWER_RATE decimal(18, 3) ,
        --��ߴ�����
	UPPER_RATE decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ�� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GIEXT PRIMARY KEY (TENANT_ID,GODS_ID)
);
CREATE INDEX IX_PUB_GOODSINFOEXT_TENANT_ID ON PUB_GOODSINFOEXT(TENANT_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_TIME_STAMP ON PUB_GOODSINFOEXT(TENANT_ID,TIME_STAMP);

--ÿ���ŵ궼�м�¼����������ŵ�
CREATE view VIW_GOODSPRICEEXT
as
    SELECT 
      j1.TENANT_ID as TENANT_ID,j1.SHOP_ID,j1.RELATION_ID, 
      j1.GODS_ID as GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE else J2.NEW_INPRICE end as NEW_INPRICE,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.SMALLTO_CALC else J2.NEW_INPRICE1 end as NEW_INPRICE1,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.BIGTO_CALC else J2.NEW_INPRICE2 end as NEW_INPRICE2,
       NEW_OUTPRICE,
       NEW_OUTPRICE1,
       NEW_OUTPRICE2,
       NEW_LOWPRICE,
       SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,
       SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,
       SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,
       USING_BARTER,BARTER_INTEGRAL,
       USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,REMARK,j1.COMM as COMM,j1.TIME_STAMP as TIME_STAMP
    FROM 
      VIW_GOODSPRICE j1 LEFT JOIN 
      PUB_GOODSINFOEXT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.GODS_ID = j2.GODS_ID; 
            
--ÿ���ŵ궼�м�¼����������ŵ�
CREATE view VIW_GOODSPRICE_SORTEXT
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSPRICEEXT j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
      
--��Ʒ������ͼ�����ŵ�
CREATE view VIW_GOODSINFO_SORTEXT
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSINFO j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
          
--��ۼ�¼
CREATE TABLE LOG_PRICING_INFO (
        --�к�ID
	ROWS_ID char (36) NOT NULL ,
        --������� 20080101
	PRICING_DATE int NOT NULL , 
        --����Ա
	PRICING_USER varchar(36) NOT NULL , 
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ͻ����� # ��Ϊ���пͻ�
	PRICE_ID char (36) NOT NULL , 
        --�ŵ���� 0 ʱ���������ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --���ű���
	GODS_ID char (36) NOT NULL ,
        --���۷�ʽ
	PRICE_METHOD varchar (1) NOT NULL ,
        --������λ�ۼ�
	ORG_OUTPRICE decimal(18, 3) ,
        --��װ1��λ�ۼ�
	ORG_OUTPRICE1 decimal(18, 3) ,
        --��װ2��λ�ۼ�
	ORG_OUTPRICE2 decimal(18, 3) ,
        --������λ�ۼ�
	NEW_OUTPRICE decimal(18, 3) ,
        --��װ1��λ�ۼ�
	NEW_OUTPRICE1 decimal(18, 3) ,
        --��װ2��λ�ۼ�
	NEW_OUTPRICE2 decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ�� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_LOG_PI_INFO PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_LOG_PRICING_INFO_TENANT_ID ON LOG_PRICING_INFO(TENANT_ID);
CREATE INDEX IX_LOG_PRICING_INFO_PRICING_DATE ON LOG_PRICING_INFO(TENANT_ID,PRICING_DATE);
CREATE INDEX IX_LOG_PRICING_INFO_TIME_STAMP ON LOG_PRICING_INFO(TENANT_ID,TIME_STAMP);

--��ǰ���
CREATE TABLE STO_STORAGE (
        --��ID
	ROWS_ID varchar(36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���ţ�û������ #��
	BATCH_NO varchar (20) NOT NULL,
        --��Ʒ����
	GODS_ID varchar (38) NOT NULL ,
        --���� ���ֵ��� #��
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	PROPERTY_02 varchar (36) NOT NULL ,
        --����������
	NEAR_INDATE varchar (10) ,
        --�����������
	NEAR_OUTDATE varchar (10) ,
        --�ɱ����
	AMONEY decimal(18, 3) NOT NULL ,
        --�������
	AMOUNT decimal(18, 3) ,
        --�ɱ�����
	COST_PRICE decimal(18, 6) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_STO_STORAGE PRIMARY KEY (ROWS_ID)
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
CREATE TABLE SAL_PRICEORDER (
        --��¼ID��
	PROM_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�����ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --��ʼʱ�� yyyy-mm-dd hh:mm:ss
	BEGIN_DATE varchar (25) NOT NULL ,
        --����ʱ�� yyyy-mm-dd hh:mm:ss
	END_DATE varchar (25) NOT NULL ,
        --��Ա�ȼ�#��ʱ�����пͻ�
	PRICE_ID char (36) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --��ע
	REMARK varchar (100) ,
        --�Ƶ�����
	CREA_DATE int ,
        --�Ƶ���Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��2011-01-01��ʼ������
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SAL_PRICEORDER PRIMARY KEY (TENANT_ID,PROM_ID)
);

CREATE INDEX IX_SAL_PRICEORDER_TENANT_ID ON SAL_PRICEORDER(TENANT_ID);
CREATE INDEX IX_SAL_PRICEORDER_TIME_STAMP ON SAL_PRICEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_PRICEORDER_SHOP_ID ON SAL_PRICEORDER(TENANT_ID,SHOP_ID);

--�����������ŵ�
CREATE TABLE SAL_PROM_SHOP (
        --��ID
	ROWS_ID varchar(36) NOT NULL ,
        --��¼ID��
	PROM_ID varchar (50) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
  CONSTRAINT PK_SAL_PROM_SHOP PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_SHOP_ID ON SAL_PROM_SHOP(TENANT_ID,PROM_ID);

--��������ϸ
CREATE TABLE SAL_PRICEDATA (
        --��¼ID��
	PROM_ID varchar (50) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --������λ�ۼ�
	NEW_OUTPRICE decimal(18, 3) ,
        --��װ1��λ�ۼ�
	NEW_OUTPRICE1 decimal(18, 3) ,
        --��װ2��λ�ۼ�
	NEW_OUTPRICE2 decimal(18, 3) ,
        --��Ա�Ƿ��ٴ���
	RATE_OFF int NOT NULL ,
        --��Ա�ٴ�����
	AGIO_RATE numeric(18, 3) ,
        --�Ƿ���� 1Ϊֻ�Ի�Ա,0Ϊ������
	ISINTEGRAL int NOT NULL ,
	CONSTRAINT PK_SAL_PRICEDATA PRIMARY KEY  
	(
		PROM_ID,TENANT_ID,SEQNO
	) 
);

CREATE INDEX IX_SAL_PRICEDATA_TENANT_ID ON SAL_PRICEDATA(TENANT_ID);
CREATE INDEX IX_SAL_PRICEDATA_GODS_ID ON SAL_PRICEDATA(GODS_ID);

--���ŵ�����۸�
CREATE view VIW_PROM_PRICE
as
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROM_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROM_ID=B.PROM_ID and A.TENANT_ID=C.TENANT_ID and A.PROM_ID=C.PROM_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
B.BEGIN_DATE<=TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS') and B.END_DATE>=TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS');

--��Ʊ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�տ��վ�','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��ͨ��Ʊ','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','��ֵ˰Ʊ','INVOICE_FLAG','00',5497000);

--����൥������
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ⵥ','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','STOCK_TYPE','00',5497000);

--��ⵥ��ͷ
CREATE TABLE STK_STOCKORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --��ⵥ��
	STOCK_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��������
	STOCK_TYPE int NOT NULL,
        --�������
	STOCK_DATE int NOT NULL ,
        --�ɹ�Ա
	GUIDE_USER varchar (36) ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --��������
	FROM_ID char (36) ,
        --�������
	FIG_ID char (36) ,
        --��������
	DBOUT_ID char (36) ,
        --Ԥ����
	ADVA_MNY decimal(18, 3) ,
        --�������
	STOCK_AMT decimal(18, 3) ,
        --�����
	STOCK_MNY decimal(18, 3) ,
        --��Ʊ����
	INVOICE_FLAG varchar (1) NOT NULL ,
        --����˰��
	TAX_RATE decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STK_STOCKORDER PRIMARY KEY 
	(
		SHOP_ID,
		STOCK_ID
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
CREATE TABLE STK_STOCKDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --��ⵥ��
	STOCK_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --����<����ʱ�� # ��>
	PROPERTY_01 varchar (20) NOT NULL ,
        --��ɫ<����ʱ�� # ��>
	PROPERTY_02 varchar (20) NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --��и��ٺ�
	BOM_ID varchar (36) ,
        --����
	AMOUNT decimal(18, 3) ,
        --������λ��׼�ۼ�
	ORG_PRICE decimal(18, 3) ,
        --�������<�Ƿ���Ʒ>
	IS_PRESENT int NOT NULL,
        --���ۼ�
	APRICE decimal(18, 3) ,
        --���
	AMONEY decimal(18, 3) ,
        --�ۿ���
	AGIO_RATE decimal(18, 3) ,
        --�ۿ۶�
	AGIO_MONEY decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,
        --�����
	CALC_MONEY decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
	CONSTRAINT PK_STK_STOCKDATA PRIMARY KEY  
	(
		TENANT_ID,
		STOCK_ID,
		SEQNO
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
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,A.ORG_PRICE*A.AMOUNT as STOCK_RTL,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--�������յ���ͼ
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY as COST_MONEY,A.ORG_PRICE*A.AMOUNT as RTL_MONEY,A.AMOUNT,A.APRICE,A.ORG_PRICE
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','���۵�','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','������','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','�˻���','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���۵�','SALES_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','���۷�ʽ','CODE_TYPE','00',5497000);

--���۵���ͷ
CREATE TABLE SAL_SALESORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���۵���
	SALES_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��������
	SALES_DATE int NOT NULL ,
        --��������
	SALES_TYPE int NOT NULL,
        --�ͻ�����
	CLIENT_ID varchar (36) ,
        --IC����
	IC_CARDNO varchar (36) ,
        --���˱���
	UNION_ID varchar (36) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --��������
	FROM_ID char (36) ,
        --�������
	FIG_ID char (36) ,
        --Ԥ����
	ADVA_MNY decimal(18, 3) ,
        --��������
	SALE_AMT decimal(18, 3) ,
        --���۽��
	SALE_MNY decimal(18, 3) ,
        --Ĩ����
	PAY_DIBS decimal(18, 3) ,
        --ʵ���ֽ�
	CASH_MNY decimal(18, 3) ,
        --�ֽ�����
	PAY_ZERO decimal(18, 3) ,
        --���㷽ʽ
	PAY_A decimal(18, 3) ,
	PAY_B decimal(18, 3) ,
	PAY_C decimal(18, 3) ,
	PAY_D decimal(18, 3) ,
	PAY_E decimal(18, 3) ,
	PAY_F decimal(18, 3) ,
	PAY_G decimal(18, 3) ,
	PAY_H decimal(18, 3) ,
	PAY_I decimal(18, 3) ,
	PAY_J decimal(18, 3) ,
        --��������
	INTEGRAL int ,
        --�һ�����
	BARTER_INTEGRAL int,
        --��ע
	REMARK varchar (100) ,
        --��Ʊ����
	INVOICE_FLAG varchar (1) ,
        --����˰��
	TAX_RATE decimal(18, 3) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --�Ƶ���
	CREA_USER varchar (36) ,
        --ҵ��Ա<����Ա>
	GUIDE_USER varchar (36) ,
        --���۷�ʽ
	SALES_STYLE varchar (21) ,
        --�ͻ�����
	PLAN_DATE varchar (10) ,
        --��ϵ��
	LINKMAN varchar (20) ,
        --��ϵ�绰
	TELEPHONE varchar (30) ,
        --�ͻ���ַ
	SEND_ADDR varchar (255) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_SALESORDER PRIMARY KEY 
	(
		TENANT_ID,
		SALES_ID
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
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'B','����','YL','1',2,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'C','��ֵ��','CZK','1',3,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'D','����','JZ','1',4,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'E','ת��','LQ','1',5,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'F','֧Ʊ','ZP','1',6,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'G','��ȯ','XEZF','1',7,'00',5497000);

CREATE VIEW VIW_PAYMENT
as
select B.TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,A.COMM,A.TIME_STAMP from PUB_CODE_INFO A,CA_TENANT B where A.TENANT_ID=0 and A.CODE_TYPE='1'
union all
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,COMM,TIME_STAMP from PUB_CODE_INFO where TENANT_ID>0 and CODE_TYPE='1';

--���۵���ϸ
CREATE TABLE SAL_SALESDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
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
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --��и��ٺ�
	BOM_ID varchar (36) ,
        --����
	AMOUNT decimal(18, 3) ,
        --���۵�λ��׼�ۼ�
	ORG_PRICE decimal(18, 3) ,
        --��������
	POLICY_TYPE int NOT NULL,
        --�Ƿ���Ʒ
	IS_PRESENT int NOT NULL,
        --�һ�����<��С��λ����Ļ���>
	BARTER_INTEGRAL int,
        --���ۼ�
	APRICE decimal(18, 3) ,
        --���
	AMONEY decimal(18, 3) ,
        --��ǰ������λ����
	COST_PRICE decimal(18, 3) ,
        --�ۿ���
	AGIO_RATE decimal(18, 3) ,
        --�ۿ۶�
	AGIO_MONEY decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,
        --������
	CALC_MONEY decimal(18, 3) ,  
        --�Ƿ��л���
	HAS_INTEGRAL int NOT NULL ,
        --˵��
	REMARK varchar (100) ,
	CONSTRAINT PK_SAL_SALESDATA PRIMARY KEY  
	(
		TENANT_ID,
		SALES_ID,
		SEQNO
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
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.ORG_PRICE,B.COST_PRICE,B.APRICE,B.AMOUNT,A.TAX_RATE,
  round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end,2) as TAX_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,
  B.AGIO_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,
  B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end,2)-round(B.CALC_AMOUNT*B.COST_PRICE,2) as PRF_MONEY
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in ('02','12');

--������������ͼ
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.SALES_TYPE,A.CREA_DATE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as RTL_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.APRICE,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--��ˮ����
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��ֵ','IC_GLIDE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','֧��','IC_GLIDE_TYPE','00',5497000);

--��ֵ����ˮ��¼
CREATE TABLE SAL_IC_GLIDE (
        --��ˮID��
	GLIDE_ID char (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�ͻ�ID<���������� #>
	CLIENT_ID varchar (36) NOT NULL ,
        --IC����
	IC_CARDNO varchar (36) NOT NULL ,
        --���۵���
	SALES_ID char (36) ,
        --����Ա
	CREA_USER varchar (36) NOT NULL ,
        --����
	CREA_DATE int NOT NULL ,
        --ժҪ
	GLIDE_INFO varchar (100) NOT NULL ,
        --��ˮ����
	IC_GLIDE_TYPE varchar (1) NOT NULL ,
        --���㷽ʽ
	PAY_A decimal(18, 3) ,
	PAY_B decimal(18, 3) ,
	PAY_C decimal(18, 3) ,
	PAY_D decimal(18, 3) ,
	PAY_E decimal(18, 3) ,
	PAY_F decimal(18, 3) ,
	PAY_G decimal(18, 3) ,
	PAY_H decimal(18, 3) ,
	PAY_I decimal(18, 3) ,
	PAY_J decimal(18, 3) ,
        --���
	GLIDE_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_IC_GLIDE PRIMARY KEY   
	(
		GLIDE_ID
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
CREATE TABLE SAL_INTEGRAL_GLIDE (
        --��ˮID��
	GLIDE_ID char (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�ͻ�ID
	CLIENT_ID varchar (36) NOT NULL ,
        --IC����
	IC_CARDNO varchar (36) NOT NULL ,
        --��ˮ����
	CREA_DATE int NOT NULL ,
        --����Ա
	CREA_USER varchar (36) NOT NULL ,
        --����
	INTEGRAL_FLAG varchar (1) NOT NULL ,
        --ժҪ
	GLIDE_INFO varchar (255) NOT NULL ,
        --����
	INTEGRAL decimal(18, 3) ,
        --�Ի�ֵ<��ȯ���������ֽ���>
	GLIDE_AMT decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_IG_GLIDE PRIMARY KEY 
	(
		GLIDE_ID
	)
);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_TENANT_ID ON SAL_INTEGRAL_GLIDE(TENANT_ID);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_TIME_STAMP ON SAL_INTEGRAL_GLIDE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CREA_DATE ON SAL_INTEGRAL_GLIDE(CREA_DATE);
CREATE INDEX IX_SAL_INTEGRAL_GLIDE_CLIENT_ID ON SAL_INTEGRAL_GLIDE(TENANT_ID,CLIENT_ID);


--���������� �������������� 1,2,3,4,5 ����ֱ�Ϊ
CREATE TABLE STO_CHANGECODE (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --����
	CHANGE_CODE varchar (10) NOT NULL ,
        --����
	CHANGE_NAME varchar (20) NOT NULL ,
        --��������
	CHANGE_TYPE varchar (1) NOT NULL ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STO_CHANGECODE PRIMARY KEY 
	(
		TENANT_ID,CHANGE_CODE
	) 
);

insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','����','2','00',5497000);
insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','����','2','00',5497000);

--������
CREATE TABLE STO_CHANGEORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --����
	CHANGE_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��������
	CHANGE_DATE int NOT NULL ,
        --��������
	CHANGE_TYPE varchar (1) NOT NULL ,
        --���ʹ���
	CHANGE_CODE varchar (10) NOT NULL ,
        --��������
	DEPT_ID varchar (11) ,
        --������
	DUTY_USER varchar (36) ,
        --��������
	CHANGE_AMT decimal(18, 3) ,
        --�������
	CHANGE_MNY decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
        --����û�
	CHK_USER varchar (36) ,
        --�����Ա
	CHK_DATE varchar (10) ,
        --��Դ����,���̵㵥ʱ��Ӧ�̵���ID��
	FROM_ID char (36) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STO_CHANGEORDER PRIMARY KEY  
	(
		CHANGE_ID,
		TENANT_ID
	)
);

CREATE INDEX IX_STO_CHANGEORDER_TENANT_ID ON STO_CHANGEORDER(TENANT_ID);
CREATE INDEX IX_STO_CHANGEORDER_TIME_STAMP ON STO_CHANGEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_CHANGEORDER_SALES_DATE ON STO_CHANGEORDER(CHANGE_DATE);

--����������ϸ
CREATE TABLE STO_CHANGEDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --����
	CHANGE_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --���� ���ֵ��� #��
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	PROPERTY_02 varchar (36) NOT NULL ,
        --�Ƿ���Ʒ
	IS_PRESENT int NOT NULL,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��и��ٺ�
	BOM_ID char (36)  ,
        --����
	BATCH_NO varchar (36) ,
        --����
	AMOUNT decimal(18, 3) ,
        --���ۼ�
	APRICE decimal(18, 3) ,
        --���
	AMONEY decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,
        --��ǰ������λ����
	COST_PRICE decimal(18, 3) ,
        --������
	CALC_MONEY decimal(18, 3) ,  
        --����˵��
	REMARK varchar (100) ,
	CONSTRAINT PK_STO_CHANGEDATA PRIMARY KEY   
	(
		TENANT_ID,
    CHANGE_ID,
		SEQNO
	) 
);

CREATE INDEX IX_STO_CHANGEDATA_TENANT_ID ON STO_CHANGEDATA(TENANT_ID);
CREATE INDEX IX_STO_CHANGEDATA_GODS_ID ON STO_CHANGEDATA(TENANT_ID,GODS_ID);

CREATE VIEW VIW_CHANGEDATA
as
select
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,B.CREA_DATE,A.APRICE,A.COST_PRICE,B.DEPT_ID,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.AMOUNT as AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.CALC_MONEY as RTL_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as COST_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM1_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_MONEY else 0 end as PARM2_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_MONEY else 0 end as PARM3_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_MONEY else 0 end as PARM4_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_MONEY else 0 end as PARM5_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='5' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM5_MONEY
from STO_CHANGEDATA A,STO_CHANGEORDER B where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.COMM not in ('02','12');

--��������
CREATE TABLE STK_INDENTORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --����
	INDE_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��������
	INDE_DATE int ,
        --�ͻ�����
	PLAN_DATE varchar (10) ,
        --��ϵ��
	LINKMAN varchar (20) ,
        --��ϵ�绰
	TELEPHONE varchar (30) ,
        --�ͻ���ַ
	SEND_ADDR varchar (255) ,
        --�ɹ�Ա
	GUIDE_USER varchar (30) ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --�������
	FIG_ID char (36) ,
        --Ԥ����
	ADVA_MNY decimal(18, 3) ,
        --��������
	INDE_AMT decimal(18, 3) ,
        --�������
	INDE_MNY decimal(18, 3) ,
        --��Ʊ����
	INVOICE_FLAG varchar (1) ,
        --����˰��
	TAX_RATE decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STK_INDENTORDER PRIMARY KEY 
	(
		TENANT_ID,
		INDE_ID
	) 
);

CREATE INDEX IX_STK_INDENTORDER_TENANT_ID ON STK_INDENTORDER(TENANT_ID);
CREATE INDEX IX_STK_INDENTORDER_TIME_STAMP ON STK_INDENTORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STK_INDENTORDER_INDE_DATE ON STK_INDENTORDER(INDE_DATE);

--����������ϸ
CREATE TABLE STK_INDENTDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --������
	INDE_ID char (36) NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --����
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ
	PROPERTY_02 varchar (36) NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��и��ٺ�
	BOM_ID char (36)  ,
        --����
	BATCH_NO varchar (36) ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --��������
	DEMAND_AMOUNT decimal(18, 3) ,
        --��������
	AMOUNT decimal(18, 3) ,
        --ԭ����
	ORG_PRICE decimal(18, 3) ,
        --�Ƿ���Ʒ
	IS_PRESENT int NOT NULL,
        --���ۼ�
	APRICE decimal(18, 3) ,
        --���
	AMONEY decimal(18, 3) ,
        --�ۿ���
	AGIO_RATE decimal(18, 3) ,
        --�ۿ۶�
	AGIO_MONEY decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,
        --��������
	FNSH_AMOUNT decimal(18, 3) ,
        --�����
	CALC_MONEY decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
	CONSTRAINT PK_STK_INDENTDATA PRIMARY KEY  
	(
		TENANT_ID,
		INDE_ID,
		SEQNO
	)
);

CREATE INDEX IX_STK_INDENTDATA_TENANT_ID ON STK_INDENTDATA(TENANT_ID);
CREATE INDEX IX_STK_INDENTDATA_GODS_ID ON STK_INDENTDATA(TENANT_ID,GODS_ID);

--����������ͼ
CREATE VIEW VIW_STKINDENTDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.INDE_ID,B.INVOICE_FLAG,B.INDE_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   dec(round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2),18,3) as TAX_MONEY,
   dec(A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2),18,3) as NOTAX_MONEY
from STK_INDENTDATA A,STK_INDENTORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and B.COMM not in ('02','12');

--���۶���
CREATE TABLE SAL_INDENTORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --����
	INDE_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��������
	INDE_DATE int NOT NULL ,
        --�ͻ�����
	PLAN_DATE varchar (10) ,
        --��ϵ��
	LINKMAN varchar (20) ,
        --��ϵ�绰
	TELEPHONE varchar (30) ,
        --�ͻ���ַ
	SEND_ADDR varchar (255) ,
        --ҵ��Ա<����Ա>
	GUIDE_USER varchar (36) ,
        --���۷�ʽ
	SALES_STYLE varchar (21) ,
        --�ͻ�
	CLIENT_ID varchar (36) NOT NULL ,
        --IC����
	IC_CARDNO varchar (36) ,
        --���˱���
	UNION_ID varchar (36) ,
        --Ԥ����
	ADVA_MNY decimal(18, 3) ,
        --��������
	INDE_AMT decimal(18, 3) ,
        --�������
	INDE_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --�������
	FIG_ID char (36) ,
        --��Ʊ����
	INVOICE_FLAG varchar (1) ,
        --����˰��
	TAX_RATE decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_INDENTORDER PRIMARY KEY 
	(
		TENANT_ID,
		INDE_ID
	)
);

CREATE INDEX IX_SAL_INDENTORDER_TENANT_ID ON SAL_INDENTORDER(TENANT_ID);
CREATE INDEX IX_SAL_INDENTORDER_TIME_STAMP ON SAL_INDENTORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INDENTORDER_SALES_DATE ON SAL_INDENTORDER(INDE_DATE);

--���۶�����ϸ
CREATE TABLE SAL_INDENTDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --������
	INDE_ID char (36) NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --����
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ
	PROPERTY_02 varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��и��ٺ�
	BOM_ID varchar (36)  ,
        --����
	BATCH_NO varchar (36) ,
        --��������
	DEMAND_AMOUNT decimal(18, 3) ,
        --����
	AMOUNT decimal(18, 3) ,
        --ԭ����
	ORG_PRICE decimal(18, 3) ,
        --��������
	POLICY_TYPE int NOT NULL,
        --�Ƿ���Ʒ
	IS_PRESENT int NOT NULL,
        --�һ�����
	BARTER_INTEGRAL int,
        --���ۼ�
	APRICE decimal(18, 3) ,
        --���
	AMONEY decimal(18, 3) ,
        --�ۿ���
	AGIO_RATE decimal(18, 3) ,
        --�ۿ۶�
	AGIO_MONEY decimal(18, 3) ,
        --������λ����
	CALC_AMOUNT decimal(18, 3) ,
        --ִ������
	FNSH_AMOUNT decimal(18, 3) ,
        --�����
	CALC_MONEY decimal(18, 3) ,
        --��ע
	REMARK varchar (100) ,
        --�Ƿ��л���
	HAS_INTEGRAL int NOT NULL ,
	CONSTRAINT PK_SAL_INDENTDATA PRIMARY KEY 
	(
		TENANT_ID,
		INDE_ID,
		SEQNO
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
  dec(round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end,2),18,3) as TAX_MONEY,
  dec(B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in ('2','3') then A.TAX_RATE else 0 end,2),18,3) as NOTAX_MONEY,
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
CREATE TABLE STO_PRINTORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�̵����� 
	PRINT_DATE int NOT NULL ,
        --�̵�״̬
	CHECK_STATUS int NOT NULL ,
        --�̵㷽ʽ
	CHECK_TYPE int NOT NULL ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --����û�
	CHK_USER varchar (36) ,
        --�����Ա
	CHK_DATE varchar (10) ,
        --ͨ����־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STO_PRINTORDER PRIMARY KEY 
	(
		TENANT_ID,
		SHOP_ID,
		PRINT_DATE
	)
);

CREATE INDEX IX_STO_PRINTORDER_TENANT_ID ON STO_PRINTORDER(TENANT_ID);
CREATE INDEX IX_STO_PRINTORDER_PRINT_DATE ON STO_PRINTORDER(PRINT_DATE);

--�̵����ϸ
CREATE TABLE STO_PRINTDATA (
        --�к�
	ROWS_ID varchar(36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�̵����� 
	PRINT_DATE int NOT NULL ,
        --���ţ�û������ #��
	BATCH_NO varchar (36) NOT NULL,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��и��ٺ�
	BOM_ID char (36) ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --���� ���ֵ��� #��
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	PROPERTY_02 varchar (36) NOT NULL ,
        --������
	RCK_AMOUNT decimal(18, 3) ,
        --�̵���
	CHK_AMOUNT decimal(18, 3) ,
        --�̵�״̬ 
	CHECK_STATUS varchar (6) NOT NULL ,
	CONSTRAINT PK_STO_PRINTDATA PRIMARY KEY  
	(
		ROWS_ID
	)
);

CREATE INDEX IX_STO_PRINTDATA_TENANT_ID ON STO_PRINTDATA(TENANT_ID);
CREATE INDEX IX_STO_PRINTDATA_SHOP_ID ON STO_PRINTDATA(SHOP_ID);
CREATE INDEX IX_STO_PRINTDATA_GODS_ID ON STO_PRINTDATA(GODS_ID);
CREATE INDEX IX_STO_PRINTDATA_PRINT_DATE ON STO_PRINTDATA(TENANT_ID,SHOP_ID,PRINT_DATE);

--�̵�¼���
CREATE TABLE STO_CHECKDATA (
        --�к�
	ROWS_ID varchar(36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�̵����� 
	PRINT_DATE int NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --����
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ
	PROPERTY_02 varchar (36) NOT NULL ,
        --��λ
	UNIT_ID varchar (36) NOT NULL ,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��и��ٺ�
	BOM_ID char (36)  ,
        --����
	BATCH_NO varchar (36) ,
        --������
	AMOUNT decimal(18, 3) ,
        --������
	CALC_AMOUNT decimal(18, 3) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
	CONSTRAINT PK_CHK_CHECKDATA PRIMARY KEY  
	(
		ROWS_ID
	)
);

CREATE INDEX IX_STO_CHECKDATA_TENANT_ID ON STO_CHECKDATA(TENANT_ID);
CREATE INDEX IX_STO_CHECKDATA_SHOP_ID ON STO_CHECKDATA(SHOP_ID);
CREATE INDEX IX_STO_CHECKDATA_GODS_ID ON STO_CHECKDATA(GODS_ID);
CREATE INDEX IX_STO_CHECKDATA_PRINT_DATE ON STO_CHECKDATA(TENANT_ID,SHOP_ID,PRINT_DATE);

--�ʻ�����
CREATE TABLE ACC_ACCOUNT_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ʻ�����
	ACCOUNT_ID char (36) NOT NULL ,
        --�����ŵ�<Ϊÿ���ŵ��Զ�����һ��<�ֽ��˻�>
	SHOP_ID varchar (11) NOT NULL ,
        --�ʻ�����
	ACCT_NAME varchar (50) NOT NULL ,
        --ƴ����
	ACCT_SPELL varchar (50) NOT NULL ,
        --��Ӧ֧����ʽ
	PAYM_ID varchar (1) NOT NULL ,
        --�ڳ����
	ORG_MNY decimal(18, 3) ,
        --֧���ܶ� 
	OUT_MNY decimal(18, 3) ,
        --�����ܶ� 
	IN_MNY decimal(18, 3) ,
        --��ǰ���
	BALANCE decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_ACCT_INFO PRIMARY KEY  
	(
		TENANT_ID,ACCOUNT_ID
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
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE='3';


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','Ӧ�տ�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','Ӧ�˿�','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','Ԥ����','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','���ۿ�','RECV_TYPE','00',5497000);

--Ӧ���ʿ�
CREATE TABLE ACC_RECVABLE_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���
	ABLE_ID char (36) NOT NULL ,
        --�ͻ�
	CLIENT_ID varchar (36) NOT NULL ,
        --ժҪ
	ACCT_INFO varchar (255) NOT NULL ,
        --����
	RECV_TYPE varchar (1) NOT NULL ,
        --�տʽ
	PAYM_ID varchar (1) ,
        --�ʿ���
	ACCT_MNY decimal(18, 3) ,
        --���ս��
	RECV_MNY decimal(18, 3) ,
        --������
	RECK_MNY decimal(18, 3) ,
        --���ʽ��
	REVE_MNY decimal(18, 3) ,
        --�ʿ�����
	ABLE_DATE int ,
        --����տ�����
	NEAR_DATE varchar (10) ,
        --��Դ����
	SALES_ID varchar (50) ,
        --��¼��������
	CREA_DATE varchar (30) ,
        --�����û�
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_RA_INFO PRIMARY KEY  
	(
		TENANT_ID,ABLE_ID
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
CREATE TABLE ACC_PAYABLE_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --���
	ABLE_ID char (36) NOT NULL ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --ժҪ
	ACCT_INFO varchar (255) NOT NULL ,
        --����
	ABLE_TYPE varchar (1) NOT NULL ,
        --�ʿ���
	ACCT_MNY decimal(18, 3) ,
        --�Ѹ����
	PAYM_MNY decimal(18, 3) ,
        --������
	RECK_MNY decimal(18, 3) ,
        --���ʽ��
	REVE_MNY decimal(18, 3) ,
        --�ʿ�����
	ABLE_DATE int ,
        --�����������
	NEAR_DATE varchar (10) ,
        --��Դ����
	STOCK_ID varchar (50) ,
        --��¼��������
	CREA_DATE varchar (20) ,
        --�����û�
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_PA_INFO PRIMARY KEY  
	(
		TENANT_ID,ABLE_ID
	) 
) ;

CREATE INDEX IX_ACC_PAYABLE_INFO_TENANT_ID ON ACC_PAYABLE_INFO(TENANT_ID);
CREATE INDEX IX_ACC_PAYABLE_INFO_TIME_STAMP ON ACC_PAYABLE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_PAYABLE_INFO_ABLE_DATE ON ACC_PAYABLE_INFO(ABLE_DATE);
CREATE INDEX IX_ACC_PAYABLE_INFOCLIENT_ID ON ACC_PAYABLE_INFO(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_ACC_PAYABLE_INFO_STOCK_ID ON ACC_PAYABLE_INFO(STOCK_ID);

--���
CREATE TABLE ACC_PAYORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	PAY_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --�ʻ�����
	ACCOUNT_ID char (36) NOT NULL ,
        --���ʽ
	PAYM_ID varchar (1) NOT NULL ,
        --��֧��Ŀ
	ITEM_ID varchar (36) NOT NULL ,
        --��������
	PAY_DATE int ,
        --������
	PAY_USER varchar (30) ,
        --�����ܼ�
	PAY_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --Ʊ�ݱ��
	BILL_NO varchar (50) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_PAYORDER PRIMARY KEY 
	(
		TENANT_ID,PAY_ID
	) 
) ;

CREATE INDEX IX_ACC_PAYORDER_TENANT_ID ON ACC_PAYORDER(TENANT_ID);
CREATE INDEX IX_ACC_PAYORDER_TIME_STAMP ON ACC_PAYORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_PAYORDER_PAY_DATE ON ACC_PAYORDER(PAY_DATE);
CREATE INDEX IX_ACC_PAYORDER_INFO_CLIENT_ID ON ACC_PAYORDER(CLIENT_ID);

--�����ϸ
CREATE TABLE ACC_PAYDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	PAY_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --�ʿ�ID��
	ABLE_ID char (36) NOT NULL ,
        --����
	ABLE_TYPE varchar (1) NOT NULL ,
        --֧�����
	PAY_MNY decimal(18, 3) ,
	CONSTRAINT PK_ACC_PAYDATA PRIMARY KEY  
	(
		TENANT_ID,PAY_ID,SEQNO
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
CREATE TABLE ACC_RECVORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	RECV_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��Ӧ��
	CLIENT_ID varchar (36) NOT NULL ,
        --�ʻ�����
	ACCOUNT_ID char (36) NOT NULL ,
        --���ʽ
	PAYM_ID varchar (1) NOT NULL ,
        --��֧��Ŀ
	ITEM_ID varchar (36) NOT NULL ,
        --��������
	RECV_DATE int ,
        --������
	RECV_USER varchar (30) ,
        --�տ�ϼ�
	RECV_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --Ʊ�ݱ��
	BILL_NO varchar (50) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_RECVORDER PRIMARY KEY 
	(
		TENANT_ID,RECV_ID
	) 
) ;

CREATE INDEX IX_ACC_RECVORDER_TENANT_ID ON ACC_RECVORDER(TENANT_ID);
CREATE INDEX IX_ACC_RECVORDER_TIME_STAMP ON ACC_RECVORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_RECVORDER_PAY_DATE ON ACC_RECVORDER(RECV_DATE);
CREATE INDEX IX_ACC_RECVORDER_INFO_CLIENT_ID ON ACC_RECVORDER(CLIENT_ID);

--�տ��ϸ
CREATE TABLE ACC_RECVDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	RECV_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --�ʿ�ID��
	ABLE_ID char (36) NOT NULL ,
        --����
	RECV_TYPE varchar (1) NOT NULL ,
        --֧�����
	RECV_MNY decimal(18, 3) ,
	CONSTRAINT PK_ACC_RECVDATA PRIMARY KEY  
	(
		TENANT_ID,RECV_ID,SEQNO
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
CREATE TABLE ACC_IOROORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	IORO_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --�ͻ�����
	CLIENT_ID varchar (36) ,
        --��֧��Ŀ
	ITEM_ID varchar (36) NOT NULL ,
        --��֧����
	DEPT_ID varchar (10) ,
        --��֧����
	IORO_TYPE varchar (1) NOT NULL ,
        --��֧����
	IORO_DATE int NOT NULL ,
        --������
	IORO_USER varchar (36) ,
        --�ϼƽ��
	IORO_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ���
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_IOROORDER PRIMARY KEY 
	(
		TENANT_ID,IORO_ID
	) 
) ;

CREATE INDEX IX_ACC_IOROORDER_TENANT_ID ON ACC_IOROORDER(TENANT_ID);
CREATE INDEX IX_ACC_IOROORDER_TIME_STAMP ON ACC_IOROORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_IOROORDER_IORO_DATE ON ACC_IOROORDER(TENANT_ID,IORO_DATE);
CREATE INDEX IX_ACC_IOROORDER_CLIENT_ID ON ACC_IOROORDER(TENANT_ID,CLIENT_ID);

--��֧��ϸ
CREATE TABLE ACC_IORODATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	IORO_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL ,
        --��֧�˻�
	ACCOUNT_ID char (36) NOT NULL ,
        --��Ӧ֧����ʽ
	PAYM_ID varchar (1) NOT NULL ,
        --Ʊ�ݱ��
	BILL_NO varchar(50) ,
        --ժҪ
	IORO_INFO varchar (255) NOT NULL ,
        --��֧���
	IORO_MNY decimal(18, 3) ,
	CONSTRAINT PK_ACC_IORODATA PRIMARY KEY  
	(
		TENANT_ID,IORO_ID,SEQNO
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','�ŵ�����','CLSE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','��Ա��ֵ','CLSE_TYPE','00',5497000);
--������˱�
CREATE TABLE ACC_CLOSE_FORDAY (
        --�к�
	ROWS_ID char (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --��������
	CLSE_TYPE char (1) NOT NULL ,
        --��������
	CLSE_DATE int,
        --���˽��
	CLSE_MNY decimal(18, 3) ,
        --���㷽ʽ
	PAY_A decimal(18, 3) ,
	PAY_B decimal(18, 3) ,
	PAY_C decimal(18, 3) ,
	PAY_D decimal(18, 3) ,
	PAY_E decimal(18, 3) ,
	PAY_F decimal(18, 3) ,
	PAY_G decimal(18, 3) ,
	PAY_H decimal(18, 3) ,
	PAY_I decimal(18, 3) ,
	PAY_J decimal(18, 3) ,
	      --������Ǯ
	BALANCE decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ���
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_CLSE_FORDAY PRIMARY KEY  
	(
		ROWS_ID
	) 
) ;
CREATE INDEX IX_ACC_CLOSE_FORDAY_TENANT_ID ON ACC_CLOSE_FORDAY(TENANT_ID);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATE ON ACC_CLOSE_FORDAY(CLSE_DATE);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATA ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

--��ȡ�
CREATE TABLE ACC_TRANSORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	TRANS_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --ת���˺�
	IN_ACCOUNT_ID char (36) NOT NULL ,
        --ת���˺�
	OUT_ACCOUNT_ID char (36) NOT NULL ,
        --����
	TRANS_DATE int NOT NULL ,
        --������
	TRANS_USER varchar (36) ,
	      --��ȡ���
	TRANS_MNY decimal(18, 3) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --Ʊ�ݱ��
	BILL_NO varchar(50) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ���
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_TRANSORDER PRIMARY KEY 
	(
		TENANT_ID,TRANS_ID
	) 
) ;

CREATE INDEX IX_ACC_TRANSORDER_TENANT_ID ON ACC_TRANSORDER(TENANT_ID);
CREATE INDEX IX_ACC_TRANSORDER_TIME_STAMP ON ACC_TRANSORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_TRANSORDER_TRANS_DATE ON ACC_TRANSORDER(TENANT_ID,TRANS_DATE);


--��а�װ<BOM�嵥>
CREATE TABLE SAL_BOMORDER (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����<�����ŵ�>
	SHOP_ID varchar (11) NOT NULL ,
        --�������
	BOM_ID char (36) NOT NULL ,
        --��ˮ��
	GLIDE_NO varchar (20) NOT NULL ,
        --��б��
	GIFT_CODE varchar (36) NOT NULL ,
        --�������
	GIFT_NAME varchar (36) NOT NULL ,
        --����
	BARCODE varchar (36) NOT NULL ,
        --�������
	BOM_AMOUNT decimal(18, 3) ,
        --��������
	RCK_AMOUNT decimal(18, 3) ,
        --���ۼ�
	RTL_PRICE decimal(18, 3) ,
        --��װ����
	BOM_DATE int NOT NULL ,
        --������
	BOM_USER varchar (36) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --˵��
	REMARK varchar (255) ,
        --����ʱ��
	CREA_DATE varchar (30) ,
        --������Ա
	CREA_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ���
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_BOMORDER PRIMARY KEY 
	(
		TENANT_ID,BOM_ID
	) 
) ;

CREATE INDEX IX_SAL_BOMORDER_TENANT_ID ON SAL_BOMORDER(TENANT_ID);
CREATE INDEX IX_SAL_BOMORDER_TIME_STAMP ON SAL_BOMORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMORDER_BOM_DATE ON SAL_BOMORDER(TENANT_ID,BOM_DATE);

--����Ӽ���Ʒ�嵥<BOM�嵥>
CREATE TABLE SAL_BOMDATA (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --����
	BOM_ID char (36) NOT NULL ,
        --���
	SEQNO int NOT NULL,
        --���ţ�û������ #��
	BATCH_NO varchar (36) NOT NULL,
        --�������ٺ�
	LOCUS_NO varchar (36) ,
        --��Ʒ����
	GODS_ID char (36) NOT NULL ,
        --������λ
	UNIT_ID varchar (36) NOT NULL ,
        --���� ���ֵ��� #��
	PROPERTY_01 varchar (36) NOT NULL ,
        --��ɫ ���ֵ��� #��
	PROPERTY_02 varchar (36) NOT NULL ,
        --һ�������ӵ�е�����
	AMOUNT decimal(18, 3) ,
        --һ�������ӵ�е�����
	CALC_AMOUNT decimal(18, 3) ,
        --��е�Ʒ���۵���
	RTL_PRICE decimal(18, 3) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ���
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_BOMDATA PRIMARY KEY 
	(
		TENANT_ID,BOM_ID,SEQNO
	) 
) ;

CREATE INDEX IX_SAL_BOMDATA_TENANT_ID ON SAL_BOMDATA(TENANT_ID);
CREATE INDEX IX_SAL_BOMDATA_TIME_STAMP ON SAL_BOMDATA(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMDATA_GODS_ID ON SAL_BOMDATA(TENANT_ID,GODS_ID);

--��Ʊ����
CREATE TABLE SAL_INVOICE_BOOK (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --��ˮID��
	INVH_ID char (36) NOT NULL ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --������
	CREA_USER int NOT NULL ,
        --��������
	CREA_DATE int NOT NULL ,
        --��ע
	REMARK varchar (100) ,
        --��Ʊ����
	INVH_NO varchar (50) NOT NULL ,
        --��Ʊ��ʼ��
	BEGIN_NO int NOT NULL ,
        --��Ʊ��ֹ��
	ENDED_NO int NOT NULL ,
        --�ϼ�����
	TOTAL_AMT int ,
        --��Ʊ����
	USING_AMT int ,
        --��������
	CANCEL_AMT int ,
        --��������
	BALANCE int ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_IV_BOOK PRIMARY KEY   
	(
		TENANT_ID,INVH_ID
	) 
);

CREATE INDEX IX_SAL_INVOICE_BOOK_TENANT_ID ON SAL_INVOICE_BOOK(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_BOOK_TIME_STAMP ON SAL_INVOICE_BOOK(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_BOOK_CREA_DATE ON SAL_INVOICE_BOOK(CREA_DATE);
CREATE INDEX IX_SAL_INVOICE_BOOK_SHOP_ID ON SAL_INVOICE_BOOK(TENANT_ID,SHOP_ID);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','��Ʊ','INVOICE_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','����','INVOICE_STATUS','00',5497000);

--��Ʊ��ϸ
CREATE TABLE SAL_INVOICE_INFO (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --��ˮID��
	INVH_ID char (36) NOT NULL ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --��Ʊ��
	CREA_USER varchar (36) NOT NULL ,
        --��Ʊ����
	CREA_DATE int NOT NULL ,
        --�ͻ�����
	CLIENT_ID varchar (36)  NOT NULL ,
        --��ע
	REMARK varchar (100) ,
	      --��Ʊ��
	INVOICE_NO int NOT NULL ,
        --��Ʊ״̬
	INVOICE_STATUS varchar (1) NOT NULL ,
        --���۵���
	SALES_ID char (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_IV_INFO PRIMARY KEY   
	(
		TENANT_ID,INVH_ID,INVOICE_NO
	) 
);

CREATE INDEX IX_SAL_INVOICE_INFO_TENANT_ID ON SAL_INVOICE_INFO(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_INFO_TIME_STAMP ON SAL_INVOICE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_INFO_CREA_DATE ON SAL_INVOICE_INFO(CREA_DATE);

--   ̨�˹滮      ---
--ʱ��:2011-02-21
--����:��ɭ��

--�ս��˼�¼
CREATE TABLE RCK_DAYS_CLOSE (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --����
	CREA_DATE int NOT NULL ,
        --�����û�
	CREA_USER varchar (36) NOT NULL ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_DAYS_CLOSE PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,CREA_DATE
	) 
);

--�½��˼�¼
CREATE TABLE RCK_MONTH_CLOSE (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --����
	MONTH int NOT NULL ,
        --�����û�
	CREA_USER varchar (36) NOT NULL ,
        --��ʼ����
	BEGIN_DATE varchar (10) ,
        --��������
	END_DATE varchar (10) ,
        --�������
	CHK_DATE varchar (10) ,
        --�����Ա
	CHK_USER varchar (36) ,
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_MONTH_CLOSE PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,MONTH
	) 
);

--��Ʒ��̨��
CREATE TABLE RCK_GOODS_DAYS (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --����
	CREA_DATE int NOT NULL ,
        --�ͻ�����
	GODS_ID char (36)  NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,

--����ʱ��������Ϣ
        --��ʱ����
	NEW_INPRICE decimal(18, 3) ,
        --��ʱ����
	NEW_OUTPRICE decimal(18, 3) ,

--�ڳ���̨��		
        --�ڳ�����
	ORG_AMT decimal(18, 3) ,
        --�ڳ����<����ʱ����>
	ORG_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	ORG_RTL decimal(18, 3) ,
        --�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
	ORG_CST decimal(18, 3) ,
	
--������̨��	
        --��������<���˻�>
	STOCK_AMT decimal(18, 3) ,
        --�������<ĩ˰>
	STOCK_MNY decimal(18, 3) ,
        --����˰��
	STOCK_TAX decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	STOCK_RTL decimal(18, 3) ,
        --�������<��Ӧ������>
	STOCK_AGO decimal(18, 3) ,
	
        --�����˻�����
	STKRT_AMT decimal(18, 3) ,
        --�˻����<ĩ˰>
	STKRT_MNY decimal(18, 3) ,
        --����˰��
	STKRT_TAX decimal(18, 3) ,
	

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
	
--������̨��	
        --��������
	DBIN_AMT decimal(18, 3) ,
        --������<����ʱ����>
	DBIN_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	DBIN_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	DBIN_CST decimal(18, 3) ,
	
        --��������
	DBOUT_AMT decimal(18, 3) ,
        --������<����ʱ����>
	DBOUT_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	DBOUT_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	DBOUT_CST decimal(18, 3) ,
	
--�����̨��	
        --��������
	CHANGE1_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE1_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE1_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE1_CST decimal(18, 3) ,

        --��������
	CHANGE2_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE2_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE2_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE2_CST decimal(18, 3) ,

        --��������
	CHANGE3_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE3_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE3_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE3_CST decimal(18, 3) ,

        --��������
	CHANGE4_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE4_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE4_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE4_CST decimal(18, 3) ,
	
        --��������
	CHANGE5_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE5_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE5_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE5_CST decimal(18, 3) ,

--�����̨��		
        --�������
	BAL_AMT decimal(18, 3) ,
        --������<����ʱ����>
	BAL_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	BAL_RTL decimal(18, 3) ,
        --���ɱ�<�ƶ���Ȩ�ɱ�>
	BAL_CST decimal(18, 3) ,
	
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_GOODS_DAYS PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO
	) 
);
CREATE INDEX IX_RCK_GOODS_DAYS_TENANT_ID ON RCK_GOODS_DAYS(TENANT_ID);
CREATE INDEX IX_RCK_GOODS_DAYS_TIME_STAMP ON RCK_GOODS_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_GOODS_DAYS_CREA_DATE ON RCK_GOODS_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCK_GOODS_DAYS_GODS_ID ON RCK_GOODS_DAYS(TENANT_ID,GODS_ID);

--��Ʒ��̨��
CREATE TABLE RCK_GOODS_MONTH (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --�·�
	MONTH int NOT NULL ,
        --�ͻ�����
	GODS_ID char (36)  NOT NULL ,
        --����
	BATCH_NO varchar (36) NOT NULL ,
	
--����ʱ��������Ϣ
        --��ʱ����
	NEW_INPRICE decimal(18, 3) ,
        --��ʱ����
	NEW_OUTPRICE decimal(18, 3) ,

--�ڳ���̨��		
        --�ڳ�����
	ORG_AMT decimal(18, 3) ,
        --�ڳ����<����ʱ����>
	ORG_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	ORG_RTL decimal(18, 3) ,
        --�ڳ��ɱ�<�ƶ���Ȩ�ɱ�>
	ORG_CST decimal(18, 3) ,
	
--������̨��	
        --��������<���˻�>
	STOCK_AMT decimal(18, 3) ,
        --�������<ĩ˰>
	STOCK_MNY decimal(18, 3) ,
        --����˰��
	STOCK_TAX decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	STOCK_RTL decimal(18, 3) ,
        --�������<��Ӧ������>
	STOCK_AGO decimal(18, 3) ,

        --�����˻�����
	STKRT_AMT decimal(18, 3) ,
        --�˻����<ĩ˰>
	STKRT_MNY decimal(18, 3) ,
        --����˰��
	STKRT_TAX decimal(18, 3) ,
	

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
        --����ë��
	SALE_PRF decimal(18, 3) ,
	
        --�����˻�����<���˻�>
	SALRT_AMT decimal(18, 3) ,
        --���۽��<ĩ˰>
	SALRT_MNY decimal(18, 3) ,
        --����˰��
	SALRT_TAX decimal(18, 3) ,
        --�˻��ɱ�
	SALRT_CST decimal(18, 3) ,
	
        --ȥ��ͬ������<���˻�>
	PRIOR_YEAR_AMT decimal(18, 3) ,
        --���۽��<ĩ˰>
	PRIOR_YEAR_MNY decimal(18, 3) ,
        --����˰��
	PRIOR_YEAR_TAX decimal(18, 3) ,
        --����ɱ�
	PRIOR_YEAR_CST decimal(18, 3) ,
	
        --������������
	PRIOR_MONTH_AMT decimal(18, 3) ,
        --���۽��<ĩ˰>
	PRIOR_MONTH_MNY decimal(18, 3) ,
        --����˰��
	PRIOR_MONTH_TAX decimal(18, 3) ,
        --����ɱ�
	PRIOR_MONTH_CST decimal(18, 3) ,
	
--������̨��	
        --��������
	DBIN_AMT decimal(18, 3) ,
        --������<����ʱ����>
	DBIN_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	DBIN_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	DBIN_CST decimal(18, 3) ,
	
        --��������
	DBOUT_AMT decimal(18, 3) ,
        --������<����ʱ����>
	DBOUT_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	DBOUT_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	DBOUT_CST decimal(18, 3) ,
	
--�����̨��	
        --��������
	CHANGE1_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE1_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE1_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE1_CST decimal(18, 3) ,

        --��������
	CHANGE2_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE2_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE2_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE2_CST decimal(18, 3) ,

        --��������
	CHANGE3_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE3_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE3_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE3_CST decimal(18, 3) ,

        --��������
	CHANGE4_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE4_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE4_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE4_CST decimal(18, 3) ,
	
        --��������
	CHANGE5_AMT decimal(18, 3) ,
        --������<����ʱ����>
	CHANGE5_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	CHANGE5_RTL decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	CHANGE5_CST decimal(18, 3) ,

--�����̨��		
        --�������
	BAL_AMT decimal(18, 3) ,
        --������<����ʱ����>
	BAL_MNY decimal(18, 3) ,
        --�����۶�<�����ۼ�>
	BAL_RTL decimal(18, 3) ,
        --���ɱ�<�ƶ���Ȩ�ɱ�>
	BAL_CST decimal(18, 3) ,
        --�����ɱ�<�ƶ���Ȩ�ɱ�>
	ADJ_CST decimal(18, 3) ,
	
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_GOODS_MONTH PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,MONTH,GODS_ID,BATCH_NO
	) 
);
CREATE INDEX IX_RCK_GOODS_MONTH_TENANT_ID ON RCK_GOODS_MONTH(TENANT_ID);
CREATE INDEX IX_RCK_GOODS_MONTH_TIME_STAMP ON RCK_GOODS_MONTH(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_GOODS_MONTH_MONTH ON RCK_GOODS_MONTH(TENANT_ID,MONTH);
CREATE INDEX IX_RCK_GOODS_MONTH_GODS_ID ON RCK_GOODS_MONTH(TENANT_ID,GODS_ID);

--�˻���̨��
CREATE TABLE RCK_ACCT_DAYS (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --����
	CREA_DATE int NOT NULL ,
        --�˻�����
	ACCOUNT_ID char (36)  NOT NULL ,

--�ڳ���̨��		
        --�ڳ����
	ORG_MNY decimal(18, 3) ,
 
--������̨��		
        --������
	IN_MNY decimal(18, 3) ,

--֧����̨��		
        --֧�����
	OUT_MNY decimal(18, 3) ,

--������		
	PAY_MNY decimal(18, 3) ,
--�տ���		
	RECV_MNY decimal(18, 3) ,
--���۽��		
	POS_MNY decimal(18, 3) ,
--�����		
	TRN_IN_MNY decimal(18, 3) ,
--ȡ����		
	TRN_OUT_MNY decimal(18, 3) ,
--��ֵ���		
	PUSH_MNY decimal(18, 3) ,
--��������		
	IORO_IN_MNY decimal(18, 3) ,
--����֧��		
	IORO_OUT_MNY decimal(18, 3) ,
	
--�����̨��		
        --�������
	BAL_MNY decimal(18, 3) ,
	
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_ACCT_DAYS PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,CREA_DATE,ACCOUNT_ID
	) 
);

CREATE INDEX IX_RCK_ACCT_DAYS_TENANT_ID ON RCK_ACCT_DAYS(TENANT_ID);
CREATE INDEX IX_RCK_ACCT_DAYS_TIME_STAMP ON RCK_ACCT_DAYS(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_ACCT_DAYS_CREA_DATE ON RCK_ACCT_DAYS(TENANT_ID,CREA_DATE);
CREATE INDEX IX_RCK_ACCT_DAYS_ACCOUNT_ID ON RCK_ACCT_DAYS(TENANT_ID,ACCOUNT_ID);

--�˻���̨��
CREATE TABLE RCK_ACCT_MONTH (
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�����ŵ�
	SHOP_ID varchar (11) NOT NULL ,
        --�·�
	MONTH int NOT NULL ,
        --�˻�����
	ACCOUNT_ID char (36)  NOT NULL ,

--�ڳ���̨��		
        --�ڳ����
	ORG_MNY decimal(18, 3) ,
 
--������̨��		
        --������
	IN_MNY decimal(18, 3) ,

--֧����̨��		
        --֧�����
	OUT_MNY decimal(18, 3) ,

--������		
	PAY_MNY decimal(18, 3) ,
--�տ���		
	RECV_MNY decimal(18, 3) ,
--���۽��		
	POS_MNY decimal(18, 3) ,
--�����		
	TRN_IN_MNY decimal(18, 3) ,
--ȡ����		
	TRN_OUT_MNY decimal(18, 3) ,
--��ֵ���		
	PUSH_MNY decimal(18, 3) ,
--��������		
	IORO_IN_MNY decimal(18, 3) ,
--����֧��		
	IORO_OUT_MNY decimal(18, 3) ,
	
--�����̨��		
        --�������
	BAL_MNY decimal(18, 3) ,
	
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_ACCT_MONTH PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,MONTH,ACCOUNT_ID
	) 
);

CREATE INDEX IX_RCK_ACCT_MONTH_TENANT_ID ON RCK_ACCT_MONTH(TENANT_ID);
CREATE INDEX IX_RCK_ACCT_MONTH_TIME_STAMP ON RCK_ACCT_MONTH(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_RCK_ACCT_MONTH_MONTH ON RCK_ACCT_MONTH(TENANT_ID,MONTH);
CREATE INDEX IX_RCK_ACCT_MONTH_ACCOUNT_ID ON RCK_ACCT_MONTH(TENANT_ID,ACCOUNT_ID);

create view VIW_GOODS_DAYS
as
select TENANT_ID,SHOP_ID,STOCK_ID as ORDER_ID,GLIDE_NO,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,LOCUS_NO,UNIT_ID,10+STOCK_TYPE as ORDER_TYPE,CLIENT_ID,CREA_USER,APRICE,AMOUNT,CALC_MONEY,
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
select TENANT_ID,SHOP_ID,SALES_ID as ORDER_ID,GLIDE_NO,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,LOCUS_NO,UNIT_ID,20+SALES_TYPE as ORDER_TYPE,CLIENT_ID,CREA_USER,APRICE,AMOUNT,CALC_MONEY,
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
select TENANT_ID,SHOP_ID,STOCK_ID as ORDER_ID,GLIDE_NO,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,LOCUS_NO,UNIT_ID,10+STOCK_TYPE as ORDER_TYPE,CLIENT_ID,CREA_USER,APRICE,AMOUNT,COST_MONEY as CALC_MONEY,
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
select TENANT_ID,SHOP_ID,SALES_ID as ORDER_ID,GLIDE_NO,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,LOCUS_NO,UNIT_ID,20+SALES_TYPE as ORDER_TYPE,CLIENT_ID,CREA_USER,round(round(COST_PRICE*CALC_AMOUNT,2)/AMOUNT,3) as APRICE,AMOUNT,round(COST_PRICE*CALC_AMOUNT,2) as CALC_MONEY,
   0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,   
   0 as SALE_AMT,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,   
   0 as DBIN_AMT,0 as DBIN_RTL,0 as DBIN_CST,   
   CALC_AMOUNT as DBOUT_AMT,RTL_MONEY as DBOUT_RTL,
   COST_MONEY as DBOUT_CST,
   0 as CHANGE1_AMT,0 as CHANGE1_RTL,0 as CHANGE1_CST,   
   0 as CHANGE2_AMT,0 as CHANGE2_RTL,0 as CHANGE2_CST,   
   0 as CHANGE3_AMT,0 as CHANGE3_RTL,0 as CHANGE3_CST,   
   0 as CHANGE4_AMT,0 as CHANGE4_RTL,0 as CHANGE4_CST,   
   0 as CHANGE5_AMT,0 as CHANGE5_RTL,0 as CHANGE5_CST   
from VIW_MOVEOUTDATA
union all
select TENANT_ID,SHOP_ID,CHANGE_ID as ORDER_ID,GLIDE_NO,CHANGE_DATE as CREA_DATE,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,LOCUS_NO,UNIT_ID,30+cast(CHANGE_CODE as int) as ORDER_TYPE,' ' as CLIENT_ID,CREA_USER,
   round(round(COST_PRICE*CALC_AMOUNT,2)/AMOUNT,3) as APRICE,AMOUNT,round(COST_PRICE*CALC_AMOUNT,2) as CALC_MONEY,
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

create view VIW_ACCT_DAYS
as
select 1 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,PAY_DATE as CREA_DATE,0 as IN_MNY,PAY_MNY as OUT_MNY,PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from VIW_PAYDATA
union all
select 2 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,RECV_DATE as CREA_DATE,RECV_MNY as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from VIW_RECVDATA
union all
select 3 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,IORO_DATE as CREA_DATE,IN_MONEY as IN_MNY,OUT_MONEY as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,IN_MONEY as IORO_IN_MNY,OUT_MONEY as IORO_OUT_MNY from VIW_IORODATA
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,IN_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,TRANS_MNY as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,TRANS_MNY as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from ACC_TRANSORDER
union all
select 5 as FLAG,TENANT_ID,SHOP_ID,OUT_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,0 as IN_MNY,TRANS_MNY as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,TRANS_MNY as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from ACC_TRANSORDER;

--������ͼ���������������������
CREATE VIEW VIW_MOVEDATA
as 
 select
   A.TENANT_ID,A.SHOP_ID,A.STOCK_ID as MOVE_ID,B.STOCK_DATE as MOVE_Date,B.GLIDE_NO,A.BATCH_NO,A.LOCUS_NO,IS_PRESENT,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,B.CREA_USER,
   B.GUIDE_USER as GUIDE_USER,B.CLIENT_ID as ASHOP_ID,A.APRICE as DBIN_PRC,A.AMOUNT as DBIN_AMT,A.CALC_MONEY as DBIN_CST,A.ORG_PRICE*A.AMOUNT as DBIN_RTL,0 as DBOUT_AMT,
   0 as DBOUT_PRC,0 as DBOUT_CST,0 as DBOUT_RTL,1 as MOVE_TYPE,B.CREA_DATE
 from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE=2 and B.COMM not in ('02','12')
union all 
 select                                                                       
   A.TENANT_ID,A.SHOP_ID,A.SALES_ID as MOVE_ID,B.SALES_DATE as MOVE_Date,B.GLIDE_NO,A.BATCH_NO,A.LOCUS_NO,IS_PRESENT,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,B.CREA_USER,
   B.GUIDE_USER as GUIDE_USER,B.CLIENT_ID as ASHOP_ID,0 as DBIN_PRC,0 as DBIN_AMT,0 as DBIN_CST,0 as DBIN_RTL,A.AMOUNT as DBOUT_AMT,
   A.APRICE as DBOUT_PRC,round(A.CALC_AMOUNT*A.COST_PRICE,2) as DBOUT_CST,A.CALC_MONEY as DBOUT_RTL,2 as MOVE_TYPE,B.CREA_DATE
 from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.SALES_TYPE=2 and B.COMM not in ('02','12');
 
--�������ˣ�����û�нɿ�Ǽǵ�
create view VIW_RCKDATA
as 
select TENANT_ID,SHOP_ID,ROWS_ID as RECV_ID,CLSE_TYPE as GLIDE_NO,SHOP_ID as CLIENT_ID,CLSE_DATE as RECV_DATE,CREA_USER,CHK_DATE,CLSE_TYPE,
CLSE_MNY as RECV_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from ACC_CLOSE_FORDAY
union all
select TENANT_ID,SHOP_ID,RECV_ID,GLIDE_NO,CLIENT_ID,RECV_DATE,RECV_USER as CREA_USER,CHK_DATE,'3' as CLSE_TYPE,
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
from VIW_RECVDATA where RECV_TYPE<>'4';

--�ͻ��տ��
create view VIW_RECVABLEDATA
as 
SELECT A.*,B.ABLE_DATE,B.ACCT_MNY,B.RECV_MNY as SETT_MNY,B.REVE_MNY,B.RECK_MNY,B.ACCT_INFO,B.SALES_ID,B.CREA_USER as ABLE_USER
FROM VIW_RECVDATA A
     INNER JOIN ACC_RECVABLE_INFO AS B ON A.TENANT_ID = B.TENANT_ID and A.ABLE_ID = B.ABLE_ID ;
     
--��Ӧ�̸����[ʱ����]
CREATE VIEW VIW_PAYABLEDATA
as
select A.*,B.ABLE_DATE,B.ACCT_MNY,B.PAYM_MNY as SETT_MNY,B.REVE_MNY,B.RECK_MNY,B.ACCT_INFO,B.STOCK_ID,B.CREA_USER as ABLE_USER 
from VIW_PAYDATA A left outer join ACC_PAYABLE_INFO B 
  on A.TENANT_ID=B.TENANT_ID and A.ABLE_ID=B.ABLE_ID;     


delete from CA_MODULE where PROD_ID='R3_RYC';
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','10000001',0,'���������','001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11000001',0,'��������','001001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100001',0,'��������','001001001',1,'actfrmStkIndentOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100002',1,'��ѯ','001001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100003',2,'����','001001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100004',3,'�޸�','001001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100005',4,'ɾ��','001001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100006',5,'���','001001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100007',6,'��ӡ','001001001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100008',7,'����','001001001008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200001',0,'�������','001001002',1,'actfrmStockOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200002',1,'��ѯ','001001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200003',2,'����','001001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200004',3,'�޸�','001001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200005',4,'ɾ��','001001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200006',5,'���','001001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200007',6,'��ӡ','001001002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200008',7,'����','001001002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300001',0,'�ɹ��˻�','001001003',1,'actfrmStkRetuOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300002',1,'��ѯ','001001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300003',2,'����','001001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300004',3,'�޸�','001001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300005',4,'ɾ��','001001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300006',5,'���','001001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300007',6,'��ӡ','001001003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300008',7,'����','001001003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12000002',0,'���۹���','001002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100001',0,'��������','001002001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100002',1,'��ѯ','001002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100003',2,'����','001002001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100004',3,'�޸�','001002001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100005',4,'ɾ��','001002001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100006',5,'���','001002001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100007',6,'��ӡ','001002001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100008',7,'����','001002001008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200001',0,'��Ʒ����','001002002',1,'actfrmPriceOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200002',1,'��ѯ','001002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200003',2,'����','001002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200004',3,'�޸�','001002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200005',4,'ɾ��','001002002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200006',5,'���','001002002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200007',6,'��ӡ','001002002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200008',7,'����','001002002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300001',0,'���۶���','001002003',1,'actfrmSalIndentOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300002',1,'��ѯ','001002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300003',2,'����','001002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300004',3,'�޸�','001002003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300005',4,'ɾ��','001002003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300006',5,'���','001002003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300007',6,'����','001002003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300008',7,'���','001002003008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300009',8,'��ӡ','001002003009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300010',10,'����','001002003010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400001',0,'���۳���','001002004',1,'actfrmSalesOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400002',1,'��ѯ','001002004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400003',2,'����','001002004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400004',3,'�޸�','001002004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400005',4,'ɾ��','001002004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400006',5,'���','001002004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400007',6,'����','001002004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400008',7,'���','001002004008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400009',8,'��ӡ','001002004009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400010',10,'����','001002004010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500001',0,'�����˻�','001002005',1,'actfrmSalRetuOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500002',1,'��ѯ','001002005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500003',2,'����','001002005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500004',3,'�޸�','001002005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500005',4,'ɾ��','001002005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500006',5,'���','001002005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500007',6,'����','001002005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500008',7,'���','001002005008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500009',8,'��ӡ','001002005009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500010',10,'����','001002005010',2,'#','#','00',5497000);

--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','13000003',0,'�ŵ�����','001003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100001',0,'�ŵ�����','001003001',1,'actfrmPosMain','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100002',1,'��ѯ','001003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100003',2,'����','001003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100004',3,'�޸�','001003001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100005',4,'ɾ��','001003001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100006',5,'���','001003001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100007',6,'����','001003001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100008',7,'�һ�','001003001008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100009',8,'�˻�','001003001009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100010',9,'��ӡ','001003001010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200001',0,'�������','001003002',1,'actfrmCloseForDay','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200002',1,'�鿴','001003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200003',2,'����','001003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200004',3,'����','001003002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200005',4,'���','001003002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200006',5,'��ӡ','001003002006',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300001',0,'�ɿ�Ǽ�','001003003',1,'actfrmRecvForDay','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300002',1,'�鿴','001003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300003',2,'����','001003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300004',3,'�޸�','001003003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300005',4,'ɾ��','001003003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300006',5,'���','001003003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300007',6,'��ӡ','001003003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300008',7,'����','001003003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14000001',0,'�������','001004',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100001',0,'������','001004001',1,'actfrmDbOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100002',1,'��ѯ','001004001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100003',2,'����','001004001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100004',3,'�޸�','001004001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100005',4,'ɾ��','001004001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100006',5,'����ȷ��','001004001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100007',6,'���','001004001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100008',7,'��ӡ','001004001008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100009',8,'����','001004001009',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200001',0,'���õ�','001004002',1,'actfrmChangeOrderList2','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200002',1,'��ѯ','001004002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200003',2,'����','001004002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200004',3,'�޸�','001004002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200005',4,'ɾ��','001004002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200006',5,'���','001004002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200007',6,'��ӡ','001004002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200008',7,'����','001004002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300001',0,'���浥','001004003',1,'actfrmChangeOrderList1','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300002',1,'��ѯ','001004003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300003',2,'����','001004003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300004',3,'�޸�','001004003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300005',4,'ɾ��','001004003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300006',5,'���','001004003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300007',6,'��ӡ','001004003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300008',7,'����','001004003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400001',0,'�̵㵥','001004004',1,'actfrmCheckOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400002',1,'��ѯ','001004004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400003',2,'����','001004004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400004',3,'�޸�','001004004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400005',4,'ɾ��','001004004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400006',5,'���','001004004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400007',6,'��ӡ','001004004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400008',7,'����','001004004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500001',0,'����ѯ','001004005',1,'actfrmStorageTracking','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500002',1,'��ѯ','001004005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500003',2,'�ɱ�','001004005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500004',3,'��ӡ','001004005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500005',4,'����','001004005005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','20000001',0,'�������','002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21000001',0,'�ֽ�����','002001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100001',0,'�����˻�','002001001',1,'actfrmAccount','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100002',1,'��ѯ','002001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100003',2,'����','002001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100004',3,'�޸�','002001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100005',4,'ɾ��','002001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100006',5,'��ӡ','002001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100007',6,'����','002001001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200001',0,'��֧��Ŀ','002001002',1,'actfrmCodeInfo3','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200002',1,'��ѯ','002001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200003',2,'����','002001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200004',3,'�޸�','002001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200005',4,'ɾ��','002001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200006',5,'��ӡ','002001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200007',6,'����','002001002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300001',0,'Ӧ�տ���','002001003',1,'actfrmRecvOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300002',1,'��ѯ','002001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300003',2,'�տ�','002001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300004',3,'�޸�','002001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300005',4,'ɾ��','002001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300006',5,'���','002001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300007',6,'��ӡ','002001003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300008',7,'����','002001003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400001',0,'Ӧ���˿�','002001004',1,'actfrmPayOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400002',1,'��ѯ','002001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400003',2,'����','002001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400004',3,'�޸�','002001004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400005',4,'ɾ��','002001004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400006',5,'���','002001004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400007',6,'��ӡ','002001004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400008',7,'����','002001004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500001',0,'��������','002001005',1,'actfrmIoroOrderList1','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500002',1,'��ѯ','002001005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500003',2,'����','002001005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500004',3,'�޸�','002001005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500005',4,'ɾ��','002001005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500006',5,'���','002001005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500007',6,'��ӡ','002001005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500008',7,'����','002001005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600001',0,'����֧��','002001006',1,'actfrmIoroOrderList2','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600002',1,'��ѯ','002001006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600003',2,'����','002001006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600004',3,'�޸�','002001006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600005',4,'ɾ��','002001006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600006',5,'���','002001006006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600007',6,'��ӡ','002001006007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600008',7,'����','002001006008',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700001',0,'��ȡ�','002001007',1,'actfrmTransOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700002',1,'��ѯ','002001007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700003',2,'����','002001007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700004',3,'�޸�','002001007004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700005',4,'ɾ��','002001007005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700006',5,'���','002001007006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700007',6,'��ӡ','002001007007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700008',7,'����','002001007008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22000001',0,'̨�˹���','002002',1,'#','#','00',5497000);

--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100001',0,'�ս���','002002001',1,'actfrmDaysClose','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100002',1,'����','002002001002',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100003',2,'����','002002001003',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100004',3,'���','002002001004',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100005',4,'��ӡ','002002001005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200001',0,'��ĩ����','002002002',1,'actfrmMonthClose','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200002',1,'����','002002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200003',2,'����','002002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200004',3,'���','002002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200005',4,'��ӡ','002002002005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300001',0,'���˹���','002002003',1,'actfrmRckMng','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300002',1,'�鿴','002002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300003',2,'���','002002003003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','30000001',0,'��������','003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31000001',0,'��������','003001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100001',0,'�ŵ굵��','003001001',1,'actfrmShopInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100002',1,'��ѯ','003001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100003',2,'����','003001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100004',3,'�޸�','003001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100005',4,'ɾ��','003001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100006',5,'��ӡ','003001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100007',6,'����','003001001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200001',0,'���ŵ���','003001002',1,'actfrmDeptInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200002',1,'��ѯ','003001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200003',2,'����','003001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200004',3,'�޸�','003001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200005',4,'ɾ��','003001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200006',5,'��ӡ','003001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200007',6,'����','003001002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300001',0,'ְ�񵵰�','003001003',1,'actfrmDutyInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300002',1,'��ѯ','003001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300003',2,'����','003001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300004',3,'�޸�','003001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300005',4,'ɾ��','003001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300006',5,'��ӡ','003001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300007',6,'����','003001003007',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400001',0,'��ɫȨ��','003001004',1,'actfrmRoleInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400002',1,'��ѯ','003001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400003',2,'����','003001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400004',3,'�޸�','003001004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400005',4,'ɾ��','003001004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400006',5,'��Ȩ','003001004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400007',6,'��ӡ','003001004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400008',7,'����','003001004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500001',0,'Ա������','003001005',1,'actfrmUsers','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500002',1,'��ѯ','003001005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500003',2,'����','003001005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500004',3,'�޸�','003001005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500005',4,'ɾ��','003001005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500006',5,'��Ȩ','003001005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500007',6,'��ӡ','003001005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500008',7,'����','003001005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32000001',0,'��Ʒ����','003002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100001',0,'��Ʒ����','003002001',1,'actfrmGoodsSort','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100002',1,'��ѯ','003002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100003',2,'����','003002001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100004',3,'�޸�','003002001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100005',4,'ɾ��','003002001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100006',5,'��ӡ','003002001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100007',6,'����','003002001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200001',0,'��Ʒ��λ','003002002',1,'actfrmMeaUnits','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200002',1,'��ѯ','003002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200003',2,'����','003002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200004',3,'�޸�','003002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200005',4,'ɾ��','003002002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200006',5,'��ӡ','003002002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200007',6,'����','003002002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300001',0,'ͳ��ָ��','003002003',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300002',1,'��ѯ','003002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300003',2,'����','003002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300004',3,'�޸�','003002003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300005',4,'ɾ��','003002003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300006',5,'��ӡ','003002003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300007',6,'����','003002003007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600001',0,'��Ʒ����','003002006',1,'actfrmGoodsInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600002',1,'��ѯ','003002006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600003',2,'����','003002006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600004',3,'�޸�','003002006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600005',4,'ɾ��','003002006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600006',5,'��ӡ','003002006006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600007',6,'����','003002006007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700001',0,'��Ӧ������','003002007',1,'actfrmRelation','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700002',1,'��ѯ','003002007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700003',2,'����','003002007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700004',3,'����','003002007004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700005',4,'ɾ��','003002007005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700006',5,'ά��','003002007006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700007',6,'����','003002007007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700008',7,'��ӡ','003002007008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33000001',0,'�ͻ���Դ','003003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100001',0,'��Ӧ�̵���','003003001',1,'actfrmSupplier','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100002',1,'��ѯ','003003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100003',2,'����','003003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100004',3,'�޸�','003003001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100005',4,'ɾ��','003003001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100006',5,'��ӡ','003003001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100007',6,'����','003003001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200001',0,'�ͻ��ȼ�','003003002',1,'actfrmPriceGradeInfo','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200002',1,'��ѯ','003003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200003',2,'����','003003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200004',3,'�޸�','003003002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200005',4,'ɾ��','003003002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200006',5,'��ӡ','003003002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200007',6,'����','003003002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300001',0,'��ҵ�ͻ�','003003003',1,'actfrmClient','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300002',1,'��ѯ','003003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300003',2,'����','003003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300004',3,'�޸�','003003003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300005',4,'ɾ��','003003003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300006',5,'��ӡ','003003003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300007',6,'����','003003003007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400001',0,'��Ա����','003003004',1,'actfrmCustomer','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400002',1,'��ѯ','003003004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400003',2,'����','003003004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400004',3,'�޸�','003003004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400005',4,'ɾ��','003003004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400006',5,'��ӡ','003003004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400007',6,'����','003003004007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500001',0,'��ֵ��','003003005',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500002',1,'��ѯ','003003005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500003',2,'�ƿ�','003003005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500004',3,'����','003003005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500005',4,'��ֵ','003003005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500006',5,'�˿�','003003005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500007',6,'��ʧ','003003005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500008',7,'ע��','003003005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600001',0,'���ֹ���','003003006',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600002',1,'��ѯ','003003006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600003',2,'���ͻ���','003003006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600004',3,'�һ�����','003003006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600005',4,'��������','003003006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600006',5,'���ֶһ�','003003006006',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','40000001',0,'ͳ�Ʊ���','004',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41000001',0,'ҵ�񱨱�','004001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100001',0,'��Ʒ��������','004001001',1,'actfrmStockDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100002',1,'��ѯ','004001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100003',2,'��ӡ','004001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100004',3,'����','004001001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200001',0,'��Ʒ���۱���','004001002',1,'actfrmSaleDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200002',1,'��ѯ','004001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200003',2,'��ӡ','004001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200004',3,'����','004001002004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600001',0,'��Ʒ��������','004001006',1,'actfrmDbDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600002',1,'��ѯ','004001006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600003',2,'��ӡ','004001006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600004',3,'����','004001006004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700001',0,'��Ʒ���ñ���','004001007',1,'actfrmChange2DayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700002',1,'��ѯ','004001007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700003',2,'��ӡ','004001007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700004',3,'����','004001007004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800001',0,'��Ʒ���汨��','004001008',1,'actfrmChange1DayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800002',1,'��ѯ','004001008002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800003',2,'��ӡ','004001008003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800004',3,'����','004001008004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900001',0,'��Ʒ��汨��','004001009',1,'actfrmStorageDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900002',1,'��ѯ','004001009002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900003',2,'��ӡ','004001009003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900004',3,'����','004001009004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42000001',0,'���񱨱�','004002',1,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300001',0,'Ӫҵ���˱���','004002003',1,'actfrmRckDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300002',1,'��ѯ','004002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300003',2,'��ӡ','004002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300004',3,'����','004002003004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400001',0,'�ͻ��տ��','004002004',1,'actfrmRecvDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400002',1,'��ѯ','004002004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400003',2,'��ӡ','004002004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400004',3,'����','004002004004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500001',0,'�ͻ������','004002005',1,'actfrmPayDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500002',1,'��ѯ','004002005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500003',2,'��ӡ','004002005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500004',3,'����','004002005004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010001',0,'Ӧ���˿��','004002010',1,'actfrmRecvAbleReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010002',1,'��ѯ','004002010002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010003',2,'��ӡ','004002010003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010004',3,'����','004002010004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020001',0,'Ӧ���˿��','004002011',1,'actfrmPayAbleReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020002',1,'��ѯ','004002011002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020003',2,'��ӡ','004002011003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020004',3,'����','004002011004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42000002',0,'�ۺϱ���','004003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100001',0,'ҵ�����˱���','004003001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100002',1,'��ѯ','004003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100003',2,'��ӡ','004003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100004',3,'����','004003001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200001',0,'��Ʒ��ˮ����','004003002',1,'actfrmGodsRunningReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200002',1,'��ѯ','004003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200003',2,'��ӡ','004003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200004',3,'����','004003002004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300001',0,'������ͳ�Ʊ�','004003003',1,'actfrmJxcTotalReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300002',1,'��ѯ','004003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300003',2,'��ӡ','004003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300004',3,'����','004003003004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','90000001',0,'ϵͳ����','009',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91000001',0,'���ù���','009001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100001',0,'�������','009001001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100002',1,'��ѯ','009001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100003',2,'����','009001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100004',3,'����','009001001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200001',0,'�ֻ�����','009001002',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200002',1,'��ѯ','009001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200003',2,'����','009001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200004',3,'��ֵ','009001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200005',4,'����','009001002005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300001',0,'��־����','009001003',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300002',1,'��ѯ','009001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300003',2,'���','009001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300004',3,'����','009001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300005',4,'����','009001003005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400001',0,'���ݻָ�','009001004',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400002',1,'����','009001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400003',2,'�ָ�','009001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400004',3,'����','009001004004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92000001',0,'ϵͳ����','009002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100001',0,'ϵͳ����','009002001',1,'actfrmSysDefine','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100002',1,'��ѯ','009002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100003',2,'�޸�','009002001003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200001',0,'�豸����','009002002',1,'actfrmDevFactory','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200002',1,'��ѯ','009002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200003',2,'�޸�','009002002003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300001',0,'�ӿڲ���','009002003',1,'actfrmIntfSetup','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300002',1,'��ѯ','009002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300003',2,'�޸�','009002003003',2,'#','#','00',5497000);
