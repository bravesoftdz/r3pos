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
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,PASS_WRD,COMM from CA_USERS
union all
select TENANT_ID,trim(char(TENANT_ID))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'����Ա' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,trim(char(B.TENANT_ID))||'0001' as SHOP_ID,'administrator' as USER_ID,'administrator' as ACCOUNT,'��������Ա' as USER_NAME,'cjgly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--������Ϣ��
CREATE TABLE PUB_CODE_INFO(
    --��ҵ����<0Ϊ��������>
	TENANT_ID int NOT NULL DEFAULT 0,
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

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','���֤','SFZ','11',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','��ʻ֤','JSZ','11',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','�籣��','SBK','11',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','����֤','JGZ','11',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','����','HZ','11',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','ѧ��֤','XSZ','11',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','��Ӫ���֤','JYXKZ','11',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('99','����','QT','11',8,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','1000����','','13',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','1000-2000','','13',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','2000-3000','','13',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','3000-4000','','13',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','4000-5000','','13',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','5000����','','13',6,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','Сѧ','XX','14',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','����','CZ','14',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','����','GZ','14',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','ר��','ZK','14',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','����','BK','14',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','˶ʿ','SS','14',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','��ʿ','BS','14',7,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','����','XX','15',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','�ز�','CZ','15',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','����','GZ','15',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','IT��Ϣ����','ZK','15',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','������ѯ','BK','15',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','ý�����','SS','15',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','��ҵ����','BS','15',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('8','������ѵ','BS','15',8,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('9','��������','BS','15',9,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('10','����','BS','15',10,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('11','����','BS','15',11,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('12','��Դ','BS','15',12,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('13','����ó��','BS','15',13,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('14','����','BS','15',14,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('99','����','BS','15',99,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100','������','BJS','8',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100100','������.������','BJSXCQ','8',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100101','������.������','BJSCWQ','8',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100102','������.������','BJSHDQ','8',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100103','������.��ͷ����','BJSMTGQ','8',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100104','������.ͨ��','BJSTX','8',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100105','������.˳����','BJSSYX','8',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100106','������.������','BJSMYX','8',8,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100107','������.��ƽ��','BJSCPX','8',9,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100108','������.������','BJSDCQ','8',10,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100109','������.������','BJSXWQ','8',11,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100110','������.������','BJSCYQ','8',12,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100111','������.��̨��','BJSFTQ','8',13,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100112','������.ʯ��ɽ��','BJSSJSQ','8',14,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100113','������.ƽ���','BJSPZX','8',15,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100114','������.������','BJSHRX','8',16,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100115','������.������','BJSYQX','8',17,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100116','������.������','BJSDXX','8',18,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101','�Ϻ���','SHS','8',19,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101100','�Ϻ���.¬����','SHSLWQ','8',20,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101101','�Ϻ���.������','SHSWSQ','8',21,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101102','�Ϻ���.բ����','SHSZBQ','8',22,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101103','�Ϻ���.�����','SHSHKQ','8',23,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101104','�Ϻ���.������','SHSHPQ','8',24,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101105','�Ϻ���.������','SHSJAQ','8',25,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101106','�Ϻ���.�Ϻ���','SHSSHX','8',26,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101107','�Ϻ���.�ϻ���','SHSNHX','8',27,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101108','�Ϻ���.��ɽ��','SHSJSX','8',28,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101109','�Ϻ���.������','SHSQPX','8',29,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101110','�Ϻ���.��ɽ��','SHSBSX','8',30,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101111','�Ϻ���.������','SHSCNQ','8',31,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101112','�Ϻ���.������','SHSYPQ','8',32,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101113','�Ϻ���.������','SHSZXQ','8',33,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101114','�Ϻ���.������','SHSNSQ','8',34,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101115','�Ϻ���.�����','SHSXHQ','8',35,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101116','�Ϻ���.������','SHSPTQ','8',36,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101117','�Ϻ���.�ζ���','SHSJDX','8',37,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101118','�Ϻ���.��ɳ��','SHSCSX','8',38,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101119','�Ϻ���.������','SHSFXX','8',39,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101120','�Ϻ���.�ɽ���','SHSSJX','8',40,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101121','�Ϻ���.������','SHSCMX','8',41,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102','�����','TJS','8',42,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102100','�����.������ ','TJSHXQ ','8',43,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102101','�����.�Ͽ��� ','TJSNKQ ','8',44,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102102','�����.������','TJSTGQ','8',45,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102103','�����.������','TJSDJQ','8',46,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102104','�����.������ ','TJSXJQ ','8',47,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102105','�����.�����','TJSDGQ','8',48,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102106','�����.�Ӷ���','TJSHDQ','8',49,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102107','�����.�ӱ���','TJSHBQ','8',50,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102108','�����.������','TJSHQQ','8',51,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102109','�����.������ ','TJSHGQ ','8',52,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102110','�����.�Ͻ���','TJSNJQ','8',53,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102111','�����.������ ','TJSBJQ ','8',54,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('103','������','ZQS','8',55,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104','���ɹ�������','NMGZZQ','8',56,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104100','���ɹ�.���ͺ�����','NMGHHHTS','8',57,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104101','���ɹ�.����������','NMGELHTS','8',58,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104102','���ɹ�.�ٺ���','NMGLHS','8',59,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104103','���ɹ�.��ʤ��','NMGDSS','8',60,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104104','���ɹ�.��������','NMGMZLS','8',61,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104105','���ɹ�.�����','NMGCFS','8',62,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104106','���ɹ�.����������','NMGWLHTS','8',63,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104107','���ɹ�.������˹��','NMGEEDSS','8',64,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104108','���ɹ�.�˰���','NMGXAM','8',65,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104109','���ɹ�.�����첼��','NMGWLCBM','8',66,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104110','���ɹ�.��������','NMGALSM','8',67,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104111','���ɹ�.������','NMGJNS','8',68,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104112','���ɹ�.��ͷ��','NMGBTS','8',69,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104113','���ɹ�.�ں���','NMGWHS','8',70,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104114','���ɹ�.��������','NMGHLES','8',71,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104115','���ɹ�.����ʯ��','NMGYKSS','8',72,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104116','���ɹ�.���ֺ�����','NMGXLHTS','8',73,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104117','���ɹ�.ͨ����','NMGTLS','8',74,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104118','���ɹ�.���ױ�����','NMGHLBES','8',75,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104119','���ɹ�.���ֹ�����','NMGXLGLM','8',76,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104120','���ɹ�.�����׶���','NMGBYNEM','8',77,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105','ɽ��ʡ','SXS','8',78,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105100','ɽ��ʡ.̫ԭ��','SXSTYS','8',79,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105101','ɽ��ʡ.������','SXSXZS','8',80,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105102','ɽ��ʡ.�ٷ���','SXSLFS','8',81,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105103','ɽ��ʡ.�˳���','SXSYCS','8',82,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105104','ɽ��ʡ.������','SXSCZS','8',83,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105105','ɽ��ʡ.˷����','SXSSZS','8',84,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105106','ɽ��ʡ.��������','SXSLLDQ','8',85,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105107','ɽ��ʡ.�ܴ���','SXSYCS','8',86,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105108','ɽ��ʡ.��ͬ��','SXSDTS','8',87,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105109','ɽ��ʡ.������','SXSHMS','8',88,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105110','ɽ��ʡ.��Ȫ��','SXSYQS','8',89,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105111','ɽ��ʡ.������','SXSJCS','8',90,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105112','ɽ��ʡ.������','SXSJZS','8',91,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106','�ӱ�ʡ','HBS','8',92,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106100','�ӱ�ʡ.ʯ��ׯ��','HBSSJZS','8',93,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106101','�ӱ�ʡ.������','HBSXJS','8',94,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106102','�ӱ�ʡ.��̨��','HBSXTS','8',95,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106103','�ӱ�ʡ.������','HBSHDS','8',96,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106104','�ӱ�ʡ.��ͷ��','HBSBTS','8',97,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106105','�ӱ�ʡ.��ɽ��','HBSTSS','8',98,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106106','�ӱ�ʡ.������','HBSBDH','8',99,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106107','�ӱ�ʡ.������','HBSBDS','8',100,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106108','�ӱ�ʡ.������','HBSDZS','8',101,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106109','�ӱ�ʡ.�ȷ���','HBSLFS','8',102,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106110','�ӱ�ʡ.�Ϲ���','HBSNGS','8',103,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106111','�ӱ�ʡ.��ˮ��','HBSHSS','8',104,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106112','�ӱ�ʡ.ɳ����','HBSSHS','8',105,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106113','�ӱ�ʡ.������','HBSCZS','8',106,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106114','�ӱ�ʡ.������','HBSRQS','8',107,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106115','�ӱ�ʡ.�ػʵ���','HBSQHDS','8',108,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106116','�ӱ�ʡ.�е���','HBSCDS','8',109,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106117','�ӱ�ʡ.������','HBSZZS','8',110,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106118','�ӱ�ʡ.�żҿ���','HBSZJKS','8',111,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107','����ʡ','LNS','8',112,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107100','����ʡ.������','LNSSYS','8',113,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107101','����ʡ.������','LNSTLS','8',114,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107102','����ʡ.��˳��','LNSFSS','8',115,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107103','����ʡ.������','LNSHCS','8',116,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107104','����ʡ.������','LNSDLS','8',117,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107105','����ʡ.��Ϫ��','LNSBXS','8',118,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107106','����ʡ.������','LNSJZS','8',119,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107107','����ʡ.�˳���','LNSXCS','8',120,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107108','����ʡ.��Ʊ��','LNSBPS','8',121,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107109','����ʡ.�̽���','LNSPJS','8',122,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107110','����ʡ.������','LNSLYS','8',123,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107111','����ʡ.������','LNSTLS','8',124,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107112','����ʡ.��ɽ��','LNSASS','8',125,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107113','����ʡ.Ӫ����','LNSYKS','8',126,'00',5497000) ;
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107114','����ʡ.�߷�����','LNSWFDS','8',127,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107115','����ʡ.������','LNSDDS','8',128,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107116','����ʡ.������','LNSJXS','8',129,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107117','����ʡ.������','LNSCYS','8',130,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107118','����ʡ.������','LNSFXS','8',131,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107119','����ʡ.��«����','LNSHLDS','8',132,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108','����ʡ','JLS','8',133,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108100','����ʡ.������ ','JLSCCS ','8',134,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108101','����ʡ.������ ','JLSJLS ','8',135,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108102','����ʡ.�Ӽ��� ','JLSYJS ','8',136,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108103','����ʡ.������ ','JLSLJS ','8',137,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108104','����ʡ.ͨ���� ','JLSTHS ','8',138,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108105','����ʡ.�뽭�� ','JLSHJS ','8',139,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108106','����ʡ.��ƽ�� ','JLSSPS ','8',140,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108107','����ʡ.��Դ�� ','JLSLYS ','8',141,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108108','����ʡ.����� ','JLSZNS ','8',142,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108109','����ʡ.��ԭ�� ','JLSSYS ','8',143,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108110','����ʡ.������ ','JLSFYS ','8',144,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108111','����ʡ.����� ','JLSZDS ','8',145,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108112','����ʡ.ͼ���� ','JLSTMS ','8',146,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108113','����ʡ.�ػ��� ','JLSDHS ','8',147,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108114','����ʡ.������ ','JLSJAS ','8',148,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108115','����ʡ.÷�ӿ��� ','JLSMHKS ','8',149,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108116','����ʡ.�������� ','JLSGZLS ','8',150,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108117','����ʡ.�׳��� ','JLSBCS ','8',151,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108118','����ʡ.��ɽ��','JLSBSS','8',152,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108119','����ʡ.�ӱ߳�����������','JLS.YBCXZZZZ','8',153,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109','������ʡ','HLJS','8',154,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109100','������ʡ.�������� ','HLJSHEBS ','8',155,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109101','������ʡ.�ض��� ','HLJSZDS ','8',156,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109102','������ʡ.������ ','HLJSYCS ','8',157,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109103','������ʡ.�׸��� ','HLJSHGS ','8',158,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109104','������ʡ.˫Ѽɽ�� ','HLJSSYSS ','8',159,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109105','������ʡ.ĵ������ ','HLJSMDJS ','8',160,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109106','������ʡ.������ ','HLJSJXS ','8',161,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109107','������ʡ.������ ','HLJSDQS ','8',162,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109108','������ʡ.�ں��� ','HLJSHHS ','8',163,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109109','������ʡ.���˰������','HLJS.DXALDQ','8',164,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109110','������ʡ.������ ','HLJSACS ','8',165,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109111','������ʡ.�绯�� ','HLJSSHS ','8',166,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109112','������ʡ.��ľ˹�� ','HLJSJMSS ','8',167,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109113','������ʡ.��̨���� ','HLJSQTHS ','8',168,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109114','������ʡ.ͬ���� ','HLJSTJS ','8',169,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109115','������ʡ.��ں��� ','HLJSSFHS ','8',170,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109116','������ʡ.��������� ','HLJS.QQHES ','8',171,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109117','������ʡ.������ ','HLJSBAS ','8',172,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109118','������ʡ.��������� ','HLJS.WDLCS ','8',173,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110','����ʡ','JSS','8',174,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110100','����ʡ.�Ͼ��� ','JSSNJS ','8',175,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110101','����ʡ.����','JSSZJS','8',176,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110102','����ʡ.������ ','JSSCZS ','8',177,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110103','����ʡ.������ ','JSSYXS ','8',178,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110104','����ʡ.������ ','JSSSZS ','8',179,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110105','����ʡ.������ ','JSSXZS ','8',180,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110106','����ʡ.������ ','JSSHYS ','8',181,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110107','����ʡ.��Ǩ�� ','JSSSQS ','8',182,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110108','����ʡ.��̨�� ','JSSDTS ','8',183,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110109','����ʡ.̩���� ','JSSTZS ','8',184,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110110','����ʡ.��ͨ�� ','JSSNTS ','8',185,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110111','����ʡ.������ ','JSSYZS ','8',186,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110112','����ʡ.������ ','JSSDYS ','8',187,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110113','����ʡ.������ ','JSSWXS ','8',188,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110114','����ʡ.������ ','JSSJYS ','8',189,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110115','����ʡ.������ ','JSSCSS ','8',190,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110116','����ʡ.���Ƹ��� ','JSSLYGS ','8',191,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110117','����ʡ.������ ','JSSHAS ','8',192,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110118','����ʡ.�γ��� ','JSSYCS ','8',193,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110119','����ʡ.������ ','JSSYZS ','8',194,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110120','����ʡ.�˻��� ','JSSXHS ','8',195,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111','����ʡ','AHS','8',196,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111100','����ʡ.�Ϸ��� ','AHSHFS ','8',197,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111101','����ʡ.������ ','AHSBBS ','8',198,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111102','����ʡ.������ ','AHSHBS ','8',199,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111103','����ʡ.������ ','AHSHZS ','8',200,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111104','����ʡ.������ ','AHSCHS ','8',201,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111105','����ʡ.�ߺ��� ','AHSWHS ','8',202,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111106','����ʡ.��ɽ�� ','AHSHSS ','8',203,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111107','����ʡ.ͭ���� ','AHSTLS ','8',204,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111108','����ʡ.������ ','AHSAQS ','8',205,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111109','����ʡ.������ ','AHSHNS ','8',206,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111110','����ʡ.������ ','AHSSZS ','8',207,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111111','����ʡ.������ ','AHSFYS ','8',208,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111112','����ʡ.������ ','AHSLAS ','8',209,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111113','����ʡ.������ ','AHSCZS ','8',210,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111114','����ʡ.������ ','AHSXCS ','8',211,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111115','����ʡ.��ɽ�� ','AHSMASS ','8',212,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111116','����ʡ.������','AHSCZS','8',213,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112','ɽ��ʡ','SDS','8',214,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112100','ɽ��ʡ.������ ','SDSJNS ','8',215,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112101','ɽ��ʡ.������ ','SDSLQS ','8',216,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112102','ɽ��ʡ.�Ͳ��� ','SDSZBS ','8',217,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112103','ɽ��ʡ.��Ӫ�� ','SDSDYS ','8',218,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112104','ɽ��ʡ.����� ','SDSZCS ','8',219,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112105','ɽ��ʡ.��̨�� ','SDSYTS ','8',220,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112106','ɽ��ʡ.�ൺ�� ','SDSQDS ','8',221,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112107','ɽ��ʡ.������ ','SDSLWS ','8',222,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112108','ɽ��ʡ.������ ','JNS SDS','8',223,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112109','ɽ��ʡ.������ ','SDSHZS ','8',224,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112110','ɽ��ʡ.������ ','SDSRZS ','8',225,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112111','ɽ��ʡ.������ ','SDSTZS ','8',226,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112112','ɽ��ʡ.�ĳ��� ','SDSLCS ','8',227,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112113','ɽ��ʡ.������ ','SDSDZS ','8',228,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112114','ɽ��ʡ.������ ','SDSBZS ','8',229,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112115','ɽ��ʡ.Ϋ���� ','SDSWFS ','8',230,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112116','ɽ��ʡ.������ ','SDSQZS ','8',231,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112117','ɽ��ʡ.������ ','SDSWHS ','8',232,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112118','ɽ��ʡ.̩���� ','SDSTAS ','8',233,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112119','ɽ��ʡ.��̩�� ','SDSXTS ','8',234,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112120','ɽ��ʡ.������ ','SDSQFS ','8',235,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112121','ɽ��ʡ.������ ','SDSLYS ','8',236,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112122','ɽ��ʡ.��ׯ�� ','SDSZZS ','8',237,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113','�㽭ʡ','ZJS','8',238,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113100','�㽭ʡ.������ ','ZJSHZS ','8',239,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113101','�㽭ʡ.�³���','ZJSXCQ','8',240,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113102','�㽭ʡ.������','ZJSJGQ','8',241,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113103','�㽭ʡ.������ ','ZJSSXS ','8',242,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113104','�㽭ʡ.������ ','ZJSJXS ','8',243,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113105','�㽭ʡ.������ ','ZJSNBS ','8',244,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113106','�㽭ʡ.��ɽ�� ','ZJSZSS ','8',245,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113107','�㽭ʡ.������ ','ZJSJJS ','8',246,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113108','�㽭ʡ.��Ϫ�� ','ZJSLXS ','8',247,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113109','�㽭ʡ.������ ','ZJSYZS ','8',248,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113110','�㽭ʡ.������ ','ZJSWZS ','8',249,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113111','�㽭ʡ.������ ','ZJSDYS ','8',250,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113112','�㽭ʡ.������','ZJSLQS','8',251,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113113','�㽭ʡ.�ϳ���','ZJSSCQ','8',252,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113114','�㽭ʡ.������','ZJSXHQ','8',253,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113115','�㽭ʡ.��ɽ�� ','ZJSXSS ','8',254,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113116','�㽭ʡ.������ ','ZJSHZS ','8',255,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113117','�㽭ʡ.������ ','ZJSHNS ','8',256,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113118','�㽭ʡ.��Ҧ�� ','ZJSYYS ','8',257,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113119','�㽭ʡ.�ٺ��� ','ZJSLHS ','8',258,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113120','�㽭ʡ.���� ','ZJSJHS ','8',259,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113121','�㽭ʡ.��ˮ�� ','ZJSLSS ','8',260,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113122','�㽭ʡ.��ɽ�� ','ZJSJSS ','8',261,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113123','�㽭ʡ.������ ','ZJSYWS ','8',262,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113124','�㽭ʡ.���� ','ZJSRAS ','8',263,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113125','�㽭ʡ.̨����','ZJSTZS','8',264,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114','����ʡ','JXS','8',265,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114100','����ʡ.�ϲ���','JXSNCS','8',266,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114101','����ʡ.��������','JXSJDZS','8',267,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114102','����ʡ.ӥ̶��','JXSYTS','8',268,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114103','����ʡ.������','JXSXYS','8',269,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114104','����ʡ.������','JXSGZS','8',270,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114105','����ʡ.����ɽ��','JXSJGSS','8',271,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114106','����ʡ.�ٴ���','JXSLCS','8',272,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114107','����ʡ.�Ž���','JXSJJS','8',273,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114108','����ʡ.������','JXSSRS','8',274,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114109','����ʡ.�˴���','JXSYCS','8',275,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114110','����ʡ.Ƽ����','JXSPXS','8',276,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114111','����ʡ.������','JXSJAS','8',277,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114112','����ʡ.������','JXSFZS','8',278,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115','����ʡ','FJS','8',279,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115100','����ʡ.������','FJSFZS','8',280,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115101','����ʡ.��ƽ��','FJSNPS','8',281,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115102','����ʡ.������','FJSXMS','8',282,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115103','����ʡ.ʯʨ��','FJSSSS','8',283,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115104','����ʡ.������','FJSLYS','8',284,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115105','����ʡ.������','FJSYAS','8',285,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115106','����ʡ.������','FJSPTS','8',286,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115107','����ʡ.������','FJSSWS','8',287,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115108','����ʡ.Ȫ����','FJSQZS','8',288,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115109','����ʡ.������','FJSZZS','8',289,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115110','����ʡ.������','FJSSMS','8',290,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115111','����ʡ.������','FJSNDS','8',291,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116','����ʡ','HNS','8',292,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116100','����ʡ.��ɳ��','HNSCSS','8',293,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116101','����ʡ.������','HNSXXS','8',294,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116102','����ʡ.������','HNSYYS','8',295,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116103','����ʡ.������','HNSZLS','8',296,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116104','����ʡ.������','HNSJSS','8',297,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116105','����ʡ.��ӹ��','HNSDYS','8',298,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116106','����ʡ.��Դ��','HNSLYS','8',299,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116107','����ʡ.������','HNSHHS','8',300,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116108','����ʡ.������','HNSHYS','8',301,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116109','����ʡ.������','HNSSYS','8',302,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116110','����ʡ.������','HNSYZS','8',303,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116111','����ʡ.�żҽ���','HNSZJJS','8',304,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116112','����ʡ.��̶��','HNSXTS','8',305,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116113','����ʡ.������','HNSZZS','8',306,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116114','����ʡ.������','HNSYYS','8',307,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116115','����ʡ.������','HNSCDS','8',308,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116116','����ʡ.������','HNSJSS','8',309,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116117','����ʡ.¦����','HNSLDS','8',310,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116118','����ʡ.��ˮ����','HNSLSJS','8',311,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116119','����ʡ.�齭��','HNSHJS','8',312,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116120','����ʡ.������','HNSLYS','8',313,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116121','����ʡ.������','HNSBZS','8',314,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116122','����ʡ.��ˮ̲��','HNSLSTS','8',315,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116123','����ʡ.��������������������','HNS.XXTJZMZZZZ','8',316,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117','����ʡ','HBS','8',317,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117100','����ʡ.�人��','HBSWHS','8',318,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117101','����ʡ.������','HBSTMS','8',319,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117102','����ʡ.Ӧ����','HBSYCS','8',320,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117103','����ʡ.Ӧ����','HBSYCS','8',321,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117104','����ʡ.Ӧ����','HBSYCS','8',322,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117105','����ʡ.Ӧ����','HBSYCS','8',323,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117106','����ʡ.Ӧ����','HBSYCS','8',324,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117107','����ʡ.������','HBSXNS','8',325,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117108','����ʡ.�����','HBSPZS','8',326,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117109','����ʡ.������','HBSXNS','8',327,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117110','����ʡ.������','HBSXNS','8',328,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117111','����ʡ.������','HBSXNS','8',329,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117112','����ʡ.������','HBSLCS','8',330,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117113','����ʡ.������','HBSLCS','8',331,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117114','����ʡ.������','HBSLCS','8',332,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117115','����ʡ.Т����','HBSXGS','8',333,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117116','����ʡ.��½��','HBSALS','8',334,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117117','����ʡ.�����','HBSHHS','8',335,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117118','����ʡ.ʯ����','HBSSSS','8',336,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117119','����ʡ.��ʯ��','HBSHSS','8',337,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117120','����ʡ.��Ѩ��','HBSWѨS','8',338,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117121','����ʡ.�差��','HBSXFS','8',339,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117122','����ʡ.������','HBSSZS','8',340,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117123','����ʡ.��������','HBSDJKS','8',341,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117124','����ʡ.�˲���','HBSYCS','8',342,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117125','����ʡ.��ʩ����������������','HBS.ESTJZMZZZZ','8',343,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117126','����ʡ.������','HBSLCS','8',344,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118','����ʡ','HNS','8',345,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118100','����ʡ.֣����','HNSZZS','8',346,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118101','����ʡ.������','HNSJZS','8',347,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118102','����ʡ.�ױ���','HNSHBS','8',348,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118103','����ʡ.�����','HNSXCS','8',349,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118104','����ʡ.פ�����','HNSZMDS','8',350,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118105','����ʡ.�ܿ���','HNSZKS','8',351,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118106','����ʡ.������','HNSLYS','8',352,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118107','����ʡ.������','HNSYMS','8',353,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118108','����ʡ.������','HNSKFS','8',354,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118109','����ʡ.������','HNSXXS','8',355,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118110','����ʡ.������','HNSAYS','8',356,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118111','����ʡ.�����','HNSZYS','8',357,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118112','����ʡ.�к���','HNSZHS','8',358,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118113','����ʡ.������','HNSXYS','8',359,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118114','����ʡ.ƽ��ɽ��','HNSPDSS','8',360,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118115','����ʡ.����Ͽ��','HNSSMXS','8',361,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118116','����ʡ.������','HNSNYS','8',362,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118117','����ʡ.������','HNSSQS','8',363,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119','�㶫ʡ','GDS','8',364,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119100','�㶫ʡ.������','GDSGZS','8',365,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119101','�㶫ʡ.��ݸ��','GDSDZS','8',366,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119102','�㶫ʡ.÷����','GDSMZS','8',367,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119103','�㶫ʡ.������','GDSCZS','8',368,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119104','�㶫ʡ.��β��','GDSSWS','8',369,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119105','�㶫ʡ.������','GDSSZS','8',370,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119106','�㶫ʡ.ï����','GDSMMS','8',371,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119107','�㶫ʡ.��ɽ��','GDSFSS','8',372,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119108','�㶫ʡ.������','GDSJMS','8',373,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119109','�㶫ʡ.�麣��','GDSZHS','8',374,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119110','�㶫ʡ.�Ƹ���','GDSYFS','8',375,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119111','�㶫ʡ.��Զ��','GDSQYS','8',376,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119112','�㶫ʡ.�ع���','GDSSGS','8',377,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119113','�㶫ʡ.��ͷ��','GDSSTS','8',378,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119114','�㶫ʡ.������','GDSHZS','8',379,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119115','�㶫ʡ.��Դ��','GDSHYS','8',380,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119116','�㶫ʡ.տ����','GDSZJS','8',381,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119117','�㶫ʡ.������','GDSZQS','8',382,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119118','�㶫ʡ.��ɽ��','GDSZSS','8',383,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119119','�㶫ʡ.������','GDSYJS','8',384,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119120','�㶫ʡ.������','GDSJYS','8',385,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120','����ʡ','HNS','8',386,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120100','����ʡ.������','HNSHKS','8',387,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120101','����ʡ.ͨʲ��','HNSTSS','8',388,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120102','����ʡ.������','HNSSYS','8',389,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120103','����ʡ.����ʡ','HNSHNS','8',390,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121','����׳��������','GXZZZZQ','8',391,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121100','����.������','GXNNS','8',392,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121101','����.��ɫ��','GXBSS','8',393,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121102','����.������','GXBHS','8',394,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121103','����.������','GXGLS','8',395,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121104','����.������','GXLZS','8',396,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121105','����.�ӳ���','GXHCS','8',397,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121106','����.�����','GXGGS','8',398,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121107','����.ƾ����','GXPXS','8',399,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121108','����.������','GXQZS','8',400,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121109','����.������','GXYLS','8',401,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121110','����.������','GXWZS','8',402,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121111','����.̨ɽ��','GXTSS','8',403,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121112','����.���Ǹ���','GXFCGS','8',404,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121113','����.������','GXHZS','8',405,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122','����ʡ','GZS','8',406,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122100','����ʡ.������','GZSGYS','8',407,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122101','����ʡ.ͭ����','GZSTRS','8',408,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122102','����ʡ.������','GZSDYS','8',409,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122103','����ʡ.������','GZSXYS','8',410,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122104','����ʡ.��ˮ��','GZSCSS','8',411,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122105','����ʡ.����ˮ��','GZSLPSS','8',412,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122106','����ʡ.������','GZSKLS','8',413,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122107','����ʡ.��˳��','GZSASS','8',414,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122108','����ʡ.������','GZSZYS','8',415,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122109','����ʡ.�Ͻڵ���','GZSBJDQ','8',416,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122110','����ʡ.ǭ�������嶱��������','GZS.QDNMZDZZZZ','8',417,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122111','����ʡ.ǭ���ϲ��������������� ','GZS.QXNBYZMZZZZ ','8',418,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122112','����ʡ.ǭ�ϲ���������������','GZS.QNBYZMZZZZ','8',419,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123','�Ĵ�ʡ','SCS','8',420,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123100','�Ĵ�ʡ.�ɶ���','SCSCDS','8',421,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123101','�Ĵ�ʡ.�½���','SCSWJX','8',422,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123102','�Ĵ�ʡ.��������','SCSDJYS','8',423,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123103','�Ĵ�ʡ.��֦����','SCSPZHS','8',424,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123104','�Ĵ�ʡ.�Թ���','SCSZGS','8',425,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123105','�Ĵ�ʡ.������','SCSMYS','8',426,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123106','�Ĵ�ʡ.�ϳ���','SCSNCS','8',427,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123107','�Ĵ�ʡ.������','SCSDZS','8',428,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123108','�Ĵ�ʡ.������','SCSSNS','8',429,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123109','�Ĵ�ʡ.�㰲��','SCSGAS','8',430,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123110','�Ĵ�ʡ.������','SCSBZS','8',431,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123111','�Ĵ�ʡ.������','SCSZZS','8',432,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123112','�Ĵ�ʡ.�˱���','SCSYBS','8',433,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123113','�Ĵ�ʡ.�ڽ���','SCSNJS','8',434,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123114','�Ĵ�ʡ.������','SCSZYS','8',435,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123115','�Ĵ�ʡ.��ɽ��','SCSLSS','8',436,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123116','�Ĵ�ʡ.üɽ��','SCSMSS','8',437,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123117','�Ĵ�ʡ.��ɽ����������','SCS.LSYZZZZ','8',438,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123118','�Ĵ�ʡ.�Ű���','SCSYAS','8',439,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123119','�Ĵ�ʡ.���β���������','SCS.GZCZZZZ','8',440,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123120','�Ĵ�ʡ.���Ӳ���Ǽ��������','SCS.ABCZQZZZZ','8',441,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123121','�Ĵ�ʡ.������','SCSDYS','8',442,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123122','�Ĵ�ʡ.��Ԫ��','SCSGYS','8',443,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124','����ʡ','YNS','8',444,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124100','����ʡ.��˫���ɴ���������','YNS.XSBNDZZZZ','8',445,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124101','����ʡ.�º���徰����������','YNS.DHDZJPZZZZ','8',446,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124102','����ʡ.��ͨ��','YNSZTS','8',447,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124103','����ʡ.������','YNSKMS','8',448,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124104','����ʡ.������','YNSDLS','8',449,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124105','����ʡ.�������������','YNS.DLBZZZZ','8',450,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124106','����ʡ.��ӹ���������������','YNS.HHHNZYZZZZ','8',451,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124107','����ʡ.������','YNSGJS','8',452,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124108','����ʡ.������','YNSQJS','8',453,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124109','����ʡ.��ɽ��','YNSBSS','8',454,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124110','����ʡ.��ɽ׳������������','YNS.WSZZMZZZZ','8',455,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124111','����ʡ.��Ϫ��','YNSYXS','8',456,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124112','����ʡ.��������������','YNS.CXYZZZZ','8',457,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124113','����ʡ.˼é����','YNSSMDQ','8',458,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124114','����ʡ.�ٲ׵���','YNSLCDQ','8',459,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124115','����ʡ.ŭ��������������','YNS.NJLSZZZZ','8',460,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124116','����ʡ.�������������','YNS.DQCZZZZ','8',461,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124117','����ʡ.��������','YNSLJDQ','8',462,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124118','����ʡ.������','YNSDCS','8',463,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124119','����ʡ.��Զ��','YNSKYS','8',464,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125','����ʡ','SXS','8',465,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125100','����ʡ.������','SXSXAS','8',466,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125101','����ʡ.������','SXSXYS','8',467,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125102','����ʡ.�Ӱ���','SXSYAS','8',468,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125103','����ʡ.������','SXSYLS','8',469,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125104','����ʡ.μ����','SXSWNS','8',470,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125105','����ʡ.������','SXSSLS','8',471,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125106','����ʡ.������','SXSAKS','8',472,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125107','����ʡ.������','SXSHZS','8',473,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125108','����ʡ.������','SXSBJS','8',474,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125109','����ʡ.ͭ����','SXSTCS','8',475,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125110','����ʡ.������','SXSHCS','8',476,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126','����ʡ','GSS','8',477,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126100','����ʡ.������','GSSLZS','8',478,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126101','����ʡ.���Ļ���������','GSS.LXHZZZZ','8',479,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126102','����ʡ.��������','GSSDXDQ','8',480,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126103','����ʡ.ƽ����','GSSPLS','8',481,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126104','����ʡ.������','GSSQYS','8',482,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126105','����ʡ.������','GSSXFS','8',483,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126106','����ʡ.������','GSSWWS','8',484,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126107','����ʡ.��Ҵ��','GSSZYS','8',485,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126108','����ʡ.��������','GSSJYGS','8',486,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126109','����ʡ.�����','GSSJCS','8',487,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126110','����ʡ.��Ȫ��','GSSJQS','8',488,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126111','����ʡ.��ˮ��','GSSTSS','8',489,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126112','����ʡ.¤�ϵ���','GSSLNDQ','8',490,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126113','����ʡ.���ϲ���������','GSS.GNCZZZZ','8',491,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126114','����ʡ.������','GSSBYS','8',492,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126115','����ʡ.������','GSSYMS','8',493,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127','���Ļ���������','NXHZZZQ','8',494,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127100','����.������','NXYCS','8',495,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127101','����.ʯ��ɽ��','NXSZSS','8',496,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127102','����.��ͭϿ��','NXQTXS','8',497,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127103','����.������','NXWZS','8',498,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127104','����.��ԭ��','NXGYS','8',499,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128','�ຣʡ','QHS','8',500,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128100','�ຣʡ.������','QHSXNS','8',501,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128101','�ຣʡ.��������������','QHS.HBCZZZZ','8',502,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128102','�ຣʡ.��������','QHSHDDQ','8',503,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128103','�ຣʡ.���ϲ���������','QHS.HNCZZZZ','8',504,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128104','�ຣʡ.���ϲ���������','QHS.HNCZZZZ','8',505,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128105','�ຣʡ.�������������','QHS.GLCZZZZ','8',506,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128106','�ຣʡ.��������������','QHS.YSCZZZZ','8',507,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128107','�ຣʡ.�������','QHSDLHS','8',508,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128108','�ຣʡ.�����ɹ������������','QHS.HXMGZCZZZZ','8',509,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128109','�ຣʡ.���ľ��','QHSGEMS','8',510,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129','�½�ά���������','XJWWEZZQ','8',511,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129100','�½�.��³ľ����','XJWLMQS','8',512,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129101','�½�.���ǵ���','XJTCDQ','8',513,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129102','�½�.���ܵ���','XJHMDQ','8',514,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129103','�½�.�������','XJHTDQ','8',515,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129104','�½�.����̩����','XJALTDQ','8',516,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129105','�½�.�������տ¶�����������','XJ.KZLSKEKZZZZ','8',517,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129106','�½�.���������ɹ���������','XJ.BLTLMGZZZZ','8',518,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129107','�½�.����������','XJKLMYS','8',519,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129108','�½�.���������������','XJ.YLHSKZZZ','8',520,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129109','�½�.������','XJKTS','8',521,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129110','�½�.ʯ������','XJSHZS','8',522,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129111','�½�.��������������','XJCJHZZZZ','8',523,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129112','�½�.��³����','XJTLFS','8',524,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129113','�½�.���������ɹ�������','XJ.BYGLMGZZZ','8',525,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129114','�½�.�������','XJKELS','8',526,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129115','�½�.�����յ���','XJAKSDQ','8',527,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129116','�½�.��ʲ����','XJKSDQ','8',528,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129117','�½�.������','XJYNS','8',529,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129118','�½�.��ͼʲ��','XJATSS','8',530,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130','����������','XCZZQ','8',531,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130100','����.������','XCLSS','8',532,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130101','����.�տ������','XCRKZDQ','8',533,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130102','����.ɽ�ϵ���','XCSNDQ','8',534,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130103','����.��֥����','XCLZDQ','8',535,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130104','����.��������','XCCDDQ','8',536,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130105','����.��������','XCNQDQ','8',537,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130106','����.�������','XCALDQ','8',538,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131','̨��ʡ','TWS','8',539,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131100','̨��ʡ.��¡','TWSJL','8',540,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131101','̨��ʡ.̨��','TWSTB','8',541,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131102','̨��ʡ.̨��','TWSTZ','8',542,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131103','̨��ʡ.̨��','TWSTN','8',543,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131104','̨��ʡ.����','TWSGX','8',544,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131105','̨��ʡ.̨��','TWSTD','8',545,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('132','����ر�������','XGTBXZQ','8',546,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('133','�����ر�������','AMTBXZQ','8',547,'00',5497000);

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
        --ͨѶ��־
	COMM varchar (2) NOT NULL DEFAULT '00',
        --ʱ��� ��ǰϵͳ����*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_RELATION PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_GOODS_RELATION_RELATION_ID ON PUB_GOODS_RELATION(RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_GODS_ID ON PUB_GOODS_RELATION(GODS_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_TIME_STAMP ON PUB_GOODS_RELATION(TENANT_ID,TIME_STAMP);


--��ҵ��Ӫ��Ʒ��ͼ,�Ծ�Ӫ��Ʒ+������Ʒ                                              
CREATE view VIW_GOODSINFO
as
select 1 as RELATION_FLAG,B.RELATION_ID,C.RELATI_ID as TENANT_ID,A.GODS_ID,coalesce(B.GODS_CODE,A.GODS_CODE) as GODS_CODE,B.SECOND_ID,GODS_NAME,GODS_SPELL,GODS_TYPE,
       SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,
       SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,
       SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,
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
select 2 as RELATION_FLAG,0 as RELATION_ID,TENANT_ID,GODS_ID,GODS_CODE,GODS_ID as SECOND_ID,GODS_NAME,GODS_SPELL,GODS_TYPE,
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

CREATE INDEX IX_PUB_BARCODE_ROWS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BATCH_NO);

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

--ÿ���ŵ궼�м�¼����������ŵ�
--����Ʒ�۸�
CREATE view VIW_GOODSPRICE
as
select A.TENANT_ID,A.RELATION_ID,C.SHOP_ID,
       coalesce(B.PRICE_ID,'#') as PRICE_ID,A.GODS_ID,A.GODS_CODE,A.GODS_ID as SECOND_ID,A.GODS_NAME,A.GODS_SPELL,A.GODS_TYPE,
       A.SORT_ID1,A.SORT_ID2,A.SORT_ID3,A.SORT_ID4,A.SORT_ID5,A.SORT_ID6,A.SORT_ID7,A.SORT_ID8,
       A.SORT_ID9,A.SORT_ID10,A.SORT_ID11,A.SORT_ID12,A.SORT_ID13,A.SORT_ID14,A.SORT_ID15,A.SORT_ID16,
       A.SORT_ID17,A.SORT_ID18,A.SORT_ID19,A.SORT_ID20,
       A.BARCODE,A.UNIT_ID,A.CALC_UNITS,A.SMALL_UNITS,A.BIG_UNITS,A.SMALLTO_CALC,A.BIGTO_CALC,A.NEW_INPRICE,A.NEW_OUTPRICE as RTL_OUTPRICE,
       case when coalesce(B.COMM,'02') not in ('02','12') then 2 else 1 end as POLICY_TYPE,
       case when coalesce(B.COMM,'02') not in ('02','12') then B.NEW_OUTPRICE else A.NEW_OUTPRICE end NEW_OUTPRICE,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE1,B.NEW_OUTPRICE*A.SMALLTO_CALC) else A.NEW_OUTPRICE*A.SMALLTO_CALC end NEW_OUTPRICE1,
       case when coalesce(B.COMM,'02') not in ('02','12') then coalesce(B.NEW_OUTPRICE2,B.NEW_OUTPRICE*A.BIGTO_CALC) else A.NEW_OUTPRICE*A.BIGTO_CALC end NEW_OUTPRICE2,
       A.NEW_LOWPRICE,A.USING_BARTER,A.BARTER_INTEGRAL,
       A.USING_PRICE,A.HAS_INTEGRAL,A.USING_BATCH_NO,A.USING_LOCUS_NO,A.REMARK,A.COMM,A.TIME_STAMP
from VIW_GOODSINFO A inner join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID
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
      j1.TENANT_ID as TENANT_ID,j1.SHOP_ID, 
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
       USING_BARTER,BARTER_INTEGRAL,RELATION_ID
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
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.GLIDE_NO,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,A.ORG_PRICE*A.AMOUNT as STOCK_RTL,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--�������յ���ͼ
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.GLIDE_NO,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
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

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','�ֽ�','XJ','1',1,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','����','YL','1',2,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','��ֵ��','CZK','1',3,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','����','JZ','1',4,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','��ȯ','LQ','1',5,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','֧Ʊ','ZP','1',6,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('G','С��֧��','XEZF','1',7,'00',5497000);

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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.CREA_DATE,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,A.GLIDE_NO,B.BARTER_INTEGRAL,
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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,A.GLIDE_NO,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.SALES_TYPE, 
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
  B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,B.CHANGE_TYPE,B.CHANGE_ID,B.GLIDE_NO,B.CHANGE_CODE,B.DUTY_USER,B.CHK_DATE,A.BATCH_NO,A.LOCUS_NO,A.UNIT_ID,
  A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,B.GLIDE_NO,B.CREA_USER,B.CREA_DATE,A.APRICE,A.COST_PRICE,B.DEPT_ID,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.CALC_AMOUNT as CALC_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.AMOUNT as AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*A.CALC_MONEY as RTL_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*round(A.CALC_AMOUNT*A.COST_PRICE,2) as COST_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_AMOUNT else 0 end as PARM1_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM1_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM1_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='2' then A.CALC_AMOUNT else 0 end as PARM2_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM2_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='2' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM2_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='3' then A.CALC_AMOUNT else 0 end as PARM3_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM3_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='3' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM3_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='4' then A.CALC_AMOUNT else 0 end as PARM4_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM4_RTL,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='4' then round(A.CALC_AMOUNT*A.COST_PRICE,2) else 0 end as PARM4_MONEY,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='5' then A.CALC_AMOUNT else 0 end as PARM5_AMOUNT,
  case when B.CHANGE_TYPE='1' then 1 else -1 end*case when B.CHANGE_CODE='1' then A.CALC_MONEY else 0 end as PARM5_RTL,
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

--������˱�
CREATE TABLE ACC_CLOSE_FORDAY (
        --�к�
	ROWS_ID char (36) NOT NULL ,
        --��ҵ����
	TENANT_ID int NOT NULL ,
        --�ŵ����
	SHOP_ID varchar (11) NOT NULL ,
        --��������
	CLSE_DATE int ,
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
CREATE INDEX IX_ACC_CLOSE_FORDAY_KEYFIELD ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

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
select TENANT_ID,SHOP_ID,STOCK_ID as ORDER_ID,GLIDE_NO,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,LOCUS_NO,UNIT_ID,'1'+STOCK_TYPE as ORDER_TYPE,APRICE,AMOUNT,CALC_MONEY,
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
select TENANT_ID,SHOP_ID,SALES_ID as ORDER_ID,GLIDE_NO,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,LOCUS_NO,UNIT_ID,'2'+STOCK_TYPE as ORDER_TYPE,APRICE,AMOUNT,CALC_MONEY,
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
select TENANT_ID,SHOP_ID,STOCK_ID as ORDER_ID,GLIDE_NO,STOCK_DATE as CREA_DATE,GODS_ID,BATCH_NO,LOCUS_NO,UNIT_ID,'1'+STOCK_TYPE as ORDER_TYPE,APRICE,AMOUNT,COST_MONEY as CALC_MONEY,
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
select TENANT_ID,SHOP_ID,SALES_ID as ORDER_ID,GLIDE_NO,SALES_DATE as CREA_DATE,GODS_ID,BATCH_NO,LOCUS_NO,UNIT_ID,'2'+STOCK_TYPE as ORDER_TYPE,round(round(COST_PRICE*CALC_AMOUNT,2)/AMOUNT,3) as APRICE,AMOUNT,round(COST_PRICE*CALC_AMOUNT,2) as CALC_MONEY,
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
select TENANT_ID,SHOP_ID,CHANGE_ID as ORDER_ID,GLIDE_NO,CHANGE_DATE as CREA_DATE,GODS_ID,BATCH_NO,LOCUS_NO,UNIT_ID,'3'+CHANGE_CODE as ORDER_TYPE,round(round(COST_PRICE*CALC_AMOUNT,2)/AMOUNT,3) as APRICE,AMOUNT,round(COST_PRICE*CALC_AMOUNT,2) as CALC_MONEY,
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

--������ͼ���������������������
CREATE VIEW VIW_MOVEDATA
as 
 select
   A.TENANT_ID,A.SHOP_ID,A.STOCK_ID as MOVE_ID,B.STOCK_DATE as MOVE_Date,B.GLIDE_NO,A.BATCH_NO,A.LOCUS_NO,IS_PRESENT,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,B.CREA_USER,
   B.GUIDE_USER as GUIDE_USER,B.CLIENT_ID as ASHOP_ID,A.APRICE as DBIN_PRC,A.AMOUNT as DBIN_AMT,A.CALC_MONEY as DBIN_CST,dec(A.ORG_PRICE*A.AMOUNT,18,3) as DBIN_RTL,0 as DBOUT_AMT,
   0 as DBOUT_PRC,0 as DBOUT_CST,0 as DBOUT_RTL,1 as MOVE_TYPE,B.CREA_DATE
 from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE=2 and B.COMM not in ('02','12')
union all 
 select                                                                       
   A.TENANT_ID,A.SHOP_ID,A.SALES_ID as MOVE_ID,B.SALES_DATE as MOVE_Date,B.GLIDE_NO,A.BATCH_NO,A.LOCUS_NO,IS_PRESENT,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,B.CREA_USER,
   B.GUIDE_USER as GUIDE_USER,B.CLIENT_ID as ASHOP_ID,0 as DBIN_PRC,0 as DBIN_AMT,0 as DBIN_CST,0 as DBIN_RTL,A.AMOUNT as DBOUT_AMT,
   A.APRICE as DBOUT_PRC,dec(round(A.CALC_AMOUNT*A.COST_PRICE,2),18,3) as DBOUT_CST,A.CALC_MONEY as DBOUT_RTL,2 as MOVE_TYPE,B.CREA_DATE
 from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.SALES_TYPE=2 and B.COMM not in ('02','12');
 

create view VIW_RECVALLDATA
as 
select TENANT_ID,SHOP_ID,CLSE_DATE as RECV_DATE,CREA_USER,CHK_DATE,
coalesce(PAY_A,0)+coalesce(PAY_B,0)+coalesce(PAY_C,0)+coalesce(PAY_E,0)+coalesce(PAY_F,0)+coalesce(PAY_G,0)+coalesce(PAY_H,0)+coalesce(PAY_I,0)+coalesce(PAY_J,0) as RECV_MNY,
PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J
from ACC_CLOSE_FORDAY
union all
select TENANT_ID,SHOP_ID,CREA_DATE as RECV_DATE,CREA_USER,CHK_DATE,
coalesce(PAY_A,0)+coalesce(PAY_B,0)+coalesce(PAY_C,0)+coalesce(PAY_E,0)+coalesce(PAY_F,0)+coalesce(PAY_G,0)+coalesce(PAY_H,0)+coalesce(PAY_I,0)+coalesce(PAY_J,0) as RECV_MNY,
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
select 1 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,PAY_DATE as CREA_DATE,0 as IN_MNY,PAY_MNY as OUT_MNY,PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from VIW_PAYDATA
union all
select 2 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,RECV_DATE as CREA_DATE,RECV_MNY as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from VIW_RECVDATA
union all
select 3 as FLAG,TENANT_ID,SHOP_ID,ACCOUNT_ID,IORO_DATE as CREA_DATE,IN_MONEY as IN_MNY,OUT_MONEY as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,IN_MONEY as IORO_IN_MNY,OUT_MONEY as IORO_OUT_MNY from VIW_IORODATA
union all
select 4 as FLAG,TENANT_ID,SHOP_ID,IN_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,TRANS_MNY as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,TRANS_MNY as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from ACC_TRANSORDER
union all
select 5 as FLAG,TENANT_ID,SHOP_ID,OUT_ACCOUNT_ID as ACCOUNT_ID,TRANS_DATE as CREA_DATE,0 as IN_MNY,TRANS_MNY as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,TRANS_MNY as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from ACC_TRANSORDER
union all
select 6 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,CLSE_DATE as CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,PAY_A as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from ACC_CLOSE_FORDAY A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A'
union all
select 7 as FLAG,A.TENANT_ID,A.SHOP_ID,B.ACCOUNT_ID,A.CREA_DATE,PAY_A as IN_MNY,0 as OUT_MNY,0 as PAY_MNY,0 as RECV_MNY,PAY_A as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY from SAL_IC_GLIDE A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and B.PAYM_ID='A';
