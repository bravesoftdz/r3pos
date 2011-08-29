--登录日志
CREATE TABLE CA_LOGIN_INFO(
  LOGIN_ID char(36) NOT NULL,
        --企业代码
	TENANT_ID int NOT NULL ,
    --门店代码 企业代码+4位序号
	SHOP_ID varchar(13) NOT NULL,
	      --用户ID号
	USER_ID varchar(36) NOT NULL,
	      --登录IP
	IP_ADDR varchar(15),
	      --计算机名
	COMPUTER_NAME varchar(100),
	      --网卡地址
	MAC_ADDR varchar(15),
	      --操作系统信息
	SYSTEM_INFO varchar(100),
	      --使用软件
	PRODUCT_ID varchar(30) NOT NULL,
	      --1 在线操作  2 离线操作
	NETWORK_STATUS varchar(1) NOT NULL,
	      --连接服务器
	CONNECT_TO varchar(100),
	      --登录日期
	LOGIN_DATE varchar(19) NOT NULL,
	      --退出日期
	LOGOUT_DATE varchar(19),
	      --在线时长<分钟> 默认-1
	CONNECT_TIMES int NOT NULL,
        --通讯标志
	COMM varchar(2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_CA_LOGIN_INFO PRIMARY KEY   
	(
		LOGIN_ID
	) 
);

CREATE INDEX IX_CLGN_TENANT_ID ON CA_LOGIN_INFO(TENANT_ID);
CREATE INDEX IX_CLGN_TIME_STAMP ON CA_LOGIN_INFO(TENANT_ID,TIME_STAMP);

--模块点击日志
CREATE TABLE CA_MODULE_CLICK(
  ROWS_ID char(36) NOT NULL,
        --登录ID
  LOGIN_ID char(36) NOT NULL,
        --企业代码
	TENANT_ID int NOT NULL ,
	      --用户ID号
	USER_ID varchar(36) NOT NULL,
	      --模块ID号
	MODU_ID varchar(36) NOT NULL,
	      --点击时间
	CLICK_DATE varchar(19) NOT NULL,
        --通讯标志
	COMM varchar(2) NOT NULL DEFAULT '00',
        --时间戳 
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