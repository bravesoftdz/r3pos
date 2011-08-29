--��¼��־
CREATE TABLE CA_LOGIN_INFO(
  LOGIN_ID char(36) NOT NULL,
        --��ҵ����
	TENANT_ID int NOT NULL ,
    --�ŵ���� ��ҵ����+4λ���
	SHOP_ID varchar(13) NOT NULL,
	      --�û�ID��
	USER_ID varchar(36) NOT NULL,
	      --��¼IP
	IP_ADDR varchar(15),
	      --�������
	COMPUTER_NAME varchar(100),
	      --������ַ
	MAC_ADDR varchar(15),
	      --����ϵͳ��Ϣ
	SYSTEM_INFO varchar(100),
	      --ʹ�����
	PRODUCT_ID varchar(30) NOT NULL,
	      --1 ���߲���  2 ���߲���
	NETWORK_STATUS varchar(1) NOT NULL,
	      --���ӷ�����
	CONNECT_TO varchar(100),
	      --��¼����
	LOGIN_DATE varchar(19) NOT NULL,
	      --�˳�����
	LOGOUT_DATE varchar(19),
	      --����ʱ��<����> Ĭ��-1
	CONNECT_TIMES int NOT NULL,
        --ͨѶ��־
	COMM varchar(2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_CA_LOGIN_INFO PRIMARY KEY   
	(
		LOGIN_ID
	) 
);

CREATE INDEX IX_CLGN_TENANT_ID ON CA_LOGIN_INFO(TENANT_ID);
CREATE INDEX IX_CLGN_TIME_STAMP ON CA_LOGIN_INFO(TENANT_ID,TIME_STAMP);

--ģ������־
CREATE TABLE CA_MODULE_CLICK(
  ROWS_ID char(36) NOT NULL,
        --��¼ID
  LOGIN_ID char(36) NOT NULL,
        --��ҵ����
	TENANT_ID int NOT NULL ,
	      --�û�ID��
	USER_ID varchar(36) NOT NULL,
	      --ģ��ID��
	MODU_ID varchar(36) NOT NULL,
	      --���ʱ��
	CLICK_DATE varchar(19) NOT NULL,
        --ͨѶ��־
	COMM varchar(2) NOT NULL DEFAULT '00',
        --ʱ��� 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_CA_MODULE_CLICK PRIMARY KEY   
	(
		ROWS_ID
	) 
);

CREATE INDEX IX_CMEC_TENANT_ID ON CA_MODULE_CLICK(TENANT_ID);
CREATE INDEX IX_CMEC_TIME_STAMP ON CA_MODULE_CLICK(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_CMEC_LOGIN_ID ON CA_MODULE_CLICK(TENANT_ID,LOGIN_ID);



CREATE INDEX IX_PGDS_BARCODE ON PUB_GOODSINFO(BARCODE);
CREATE INDEX IX_PGDS_GODS_CODE ON PUB_GOODSINFO(GODS_CODE);