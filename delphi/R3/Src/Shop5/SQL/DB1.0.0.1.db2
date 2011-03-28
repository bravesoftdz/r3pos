--2011-01-11 张森荣设计
--参数选项
CREATE TABLE PUB_PARAMS(
    --选项代码
	CODE_ID varchar(20) NOT NULL,
    --选项名称
	CODE_NAME varchar(50) NOT NULL,
    --拼音码
	CODE_SPELL varchar(50),
    --选项类型
	TYPE_CODE varchar(50) NOT NULL,
	  --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_PUB_PARAMS PRIMARY KEY (CODE_ID,TYPE_CODE)
);

CREATE INDEX IX_PUB_PARAMS_TYPE_CODE ON PUB_PARAMS(TYPE_CODE);

CREATE INDEX IX_PUB_PARAMS_TIME_STAMP ON PUB_PARAMS(TIME_STAMP);

--认证中心2011-01-21
--应用服务器信息表
CREATE TABLE CA_SERVER_INFO(
    --服务器编号<8位数字串>
	SRVR_ID varchar(10) NOT NULL,
    --服务器名称
	SRVR_NAME varchar(30) NOT NULL,
    --拼音码
	SRVR_SPELL varchar(30) NOT NULL,
    --部署地点
	ADDRESS varchar(100) NOT NULL,
    --部署日期
	CREA_DATE varchar(10) NOT NULL,
    --服务器状态
	SRVR_STATUS varchar(1) NOT NULL,
    --服务器类型
	SRVR_TYPE varchar(1) NOT NULL,
    --所属地区<取PUB_CODE_INFO 表 CODE_TYPE=8>
	REGION_ID varchar(21) NOT NULL,
    --主机地址<IP或域名>
	HOST_NAME varchar(20) NOT NULL,
    --端口号
	SRVR_PORT int NOT NULL,
    --URL路径,相对路径要结合IP取得全路径
	SRVR_PATH varchar(50) NOT NULL,
    --最大连接数
  MAX_SESSION int,
    --排序号
  SEQ_NO int,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SERVER_INFO PRIMARY KEY(SRVR_ID)
);

CREATE INDEX IX_PUB_SERVER_INFO_TIME_STAMP ON CA_SERVER_INFO(TIME_STAMP);

--数据库服务信息表
CREATE TABLE CA_DB_INFO(
    --8位数字串
	DB_ID int NOT NULL,
    --数据库服务名称
	DB_NAME varchar(30) NOT NULL,
    --拼音码
	DB_SPELL varchar(30) NOT NULL,
    --部署地点
	ADDRESS varchar(100) NOT NULL,
    --部署日期
	CREA_DATE varchar(10) NOT NULL,
    --数据服务主机名
	HOST_NAME varchar(50) NOT NULL,
    --数据服务登录用户
	USER_NAME varchar(20) NOT NULL,
    --数据服务登录密码
	PASSWORD varchar(100) NOT NULL,
    --数据库账套名称
	DATABASE_NAME varchar(100) NOT NULL,
    --数据库类型
	DATABASE_TYPE varchar(36) NOT NULL,
    --数据库服务端口<0为默认端口>
  DATABASE_PORT int,
    --服务状态
	DB_STATUS varchar(1) NOT NULL,
    --所属地区<取PUB_CODE_INFO 表 CODE_TYPE=8>
	REGION_ID varchar(21) NOT NULL,
    --最大负载
  MAX_SESSION int,
    --排序号
  SEQ_NO int,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DB_INFO PRIMARY KEY(DB_ID)
);

CREATE INDEX IX_CA_DB_INFO_TIME_STAMP ON CA_DB_INFO(TIME_STAMP);

--数据库类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','SQLSERVER','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','ORACLE','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','SYBASE','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','ACCESS','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','DB2','DATABASE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','SQLITE','DATABASE_TYPE','00',5497000);

--应用服务器跟数据关系表
CREATE TABLE CA_DB_TO_SRVR(
    --数据库服务编号
	DB_ID int NOT NULL,
    --应用服务器编号
	SRVR_ID varchar(10) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DB_TO_SRVR PRIMARY KEY(DB_ID,SRVR_ID)
);

--服务器状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','正常','SRVR_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','爆满','SRVR_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','禁用','SRVR_STATUS','00',5497000);

--数据库服务状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','正常','DB_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','爆满','DB_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','禁用','DB_STATUS','00',5497000);

--服务器类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','自有服务器','SRVR_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','托管服务器','SRVR_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','商户服务器','SRVR_TYPE','00',5497000);

--软件系列号
CREATE TABLE CA_SN_INFO(
    --软件系列号<>
	SN varchar(20) NOT NULL,
    --种子号<顺序数字串10位 1000000001>
	SN_CODE varchar(10) NOT NULL,
    --系列号状态
	SN_STATUS varchar(1) NOT NULL,
    --门店代码
	SHOP_ID varchar (11) NOT NULL,
    --激活日期
	ACTV_DATE varchar(10) NOT NULL,
    --有效截止日期
	END_DATE varchar(10) NOT NULL,
    --创建日期
	CREA_DATE varchar(10) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SN_INFO PRIMARY KEY(SN)
);

CREATE INDEX IX_PUB_SN_INFO_TIME_STAMP ON CA_SN_INFO(TIME_STAMP);

--系列号状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','空置','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','使用','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','过期','SN_STATUS','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','禁用','SN_STATUS','00',5497000);

--软件产品信息表
CREATE TABLE CA_PROD_INFO(
    --产品编号产品世代限定 比如v3/v5版
	PROD_ID varchar(10) NOT NULL,
    --产品名称
	PROD_NAME varchar(50) NOT NULL,
    --产品简称
	PROD_SHORT_NAME varchar(20) NOT NULL,
    --产品版本号 主要可能用于产品功能限定或者产品安装介质关联产品等级限定 比如企业版/个人版；
	PROD_VERSION varchar(10) NOT NULL,
    --行业类型 MKT 超市<食杂店> FIG 服装 DLI 食品 OHR 通用 产品行业限定
	INDUSTRY varchar(3) NOT NULL,
    --产品类型 LCL单机版 NET连锁版  产品特殊功能限定
	PROD_FLAG varchar(3) NOT NULL,
    --开发日期
	DEVE_DATE varchar(10),
    --最近发布日期
	LAST_ISSUE_DATE varchar(10),
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
   CONSTRAINT PK_CA_PROD_INFO PRIMARY KEY(PROD_ID)
);

--行业类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('MKT','超市<食杂店>','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('FIG','服装','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DLI','食品','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('OHR','通用','INDUSTRY','00',5497000);

--产品类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('LCL','单机版','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NET','连锁版','INDUSTRY','00',5497000);
--初始化软件产品
 insert into CA_PROD_INFO(PROD_ID,PROD_NAME,PROD_SHORT_NAME,PROD_VERSION,INDUSTRY,PROD_FLAG,DEVE_DATE,LAST_ISSUE_DATE,COMM,TIME_STAMP) values('R3-1YC','R3门店管理软件-烟草零售终端','R3-RYC','3.0','MKT','LCL','2011-01-01','2011-04-01','00',5497000);
 
--发布状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','新增','INDUSTRY','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','发布','INDUSTRY','00',5497000);

--版本控制表,更名为升级版本控制表
CREATE TABLE CA_UPGRADE_VERSION(
    --控制编号<只要求唯一编号>
	VERSION_ID int NOT NULL,
    --产品编号
	PROD_ID varchar(10) NOT NULL,
    --当前版本号 5.0.0.93  控制升级包/补丁包
    --更名为升级版本号
	UPGRADE_VERSION varchar(11) NOT NULL,
    --应用服务器
	SRVR_ID varchar(10) NOT NULL,
    --发布状态 1 新增 2 发布
	VERSION_STATUS varchar(1) NOT NULL,
    --升级类型 1可选升级 2强制升级
	UPGRADE_FLAG varchar(1) NOT NULL,
    --升级范围 1<应用服务器>对应的所有企业 2指定企业做试点投放
	UPGRADE_RANGE varchar(1) NOT NULL,
    --升级包下载地址 带文件名 
	UPGRADE_URL varchar(255) NOT NULL,
    --发布日期
	ISSUE_DATE varchar(10) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_U_VERSION PRIMARY KEY(VERSION_ID)
);

--升级范围
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','所有企业','UPGRADE_RANGE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','指定企业做试点投放','UPGRADE_RANGE','00',5497000);
--升级类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','可选升级','UPGRADE_FLAG','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','强制升级','UPGRADE_FLAG','00',5497000);

--升级企业
CREATE TABLE CA_UPGRADE_RANGE(
    --控制编号
	VERSION_ID int NOT NULL,
    --企业编号
	TENANT_ID int NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_U_RANGE PRIMARY KEY(VERSION_ID)
);

--参数设置表
CREATE TABLE SYS_DEFINE (
        --企业代码，全局参数时代码为 0 
	TENANT_ID int NOT NULL ,
        --参数名,英文代码
	DEFINE varchar (30) NOT NULL ,
        --参数值
	VALUE varchar (100) ,
        --参数类型，默认为0
	VALUE_TYPE integer NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数  
        TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SYS_DEFINE PRIMARY KEY (TENANT_ID,DEFINE)
);

insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'ADMIN','admin',0,'00',5497000);
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'PASSWRD','79415A40',0,'00',5497000);
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'DBVERSION','1.0.0.1',0,'00',5497000);

--企业类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','制造商','TENANT_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','经销商','TENANT_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','零售商','TENANT_TYPE','00',5497000);

--关系类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','未审','AUDIT_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','已审','AUDIT_STATUS','00',5497000);
--企业资料
CREATE TABLE CA_TENANT(
    --企业代码 1000001
	TENANT_ID int NOT NULL,
    --登录名称 例:celeb.net
	LOGIN_NAME varchar(50) NOT NULL,
    --经营许可证
	LICENSE_CODE varchar(50),
    --企业名称
	TENANT_NAME varchar(50) NOT NULL,
    --企业类型
	TENANT_TYPE varchar(1) NOT NULL,
    --企业简称
	SHORT_TENANT_NAME varchar(50) NOT NULL,
    --拼音码
	TENANT_SPELL varchar(50) NOT NULL,
    --法人代表
	LEGAL_REPR varchar(20),
    --联系人
	LINKMAN varchar(20),
    --联系电话
	TELEPHONE varchar(30),
    --传真
	FAXES varchar(30),
    --主页
	HOMEPAGE varchar(50),
    --地址
	ADDRESS varchar(50),
    --QQ号
	QQ varchar(50),
    --MSN号
	MSN varchar(50),
    --邮编
	POSTALCODE varchar(6),
    --备注
	REMARK varchar(100),
    --认证密码
	PASSWRD varchar(50),
    --所属区域
	REGION_ID varchar(10),
    --默认应用服务器编号
	SRVR_ID varchar(10),
    --状态 1申请 2已审
	AUDIT_STATUS varchar(1) NOT NULL,
    --软件产品编号
	PROD_ID varchar(10),
    --数据库连接编号
	DB_ID int,
    --注册日期
	CREA_DATE varchar(10) ,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_TENANT PRIMARY KEY (TENANT_ID)
);

CREATE INDEX IX_CA_TENANT_TIME_STAMP ON CA_TENANT(TIME_STAMP);

--关系类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','经销商','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','加盟店','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','联营店','RELATION_TYPE','00',5497000);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','代销点','RELATION_TYPE','00',5497000);

--关系类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','申请','RELATION_STATUS','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','审核','RELATION_STATUS','00',5497000);

--供应链
CREATE TABLE CA_RELATION(
    --供应链ID号
	RELATION_ID int NOT NULL,
    --创建企业号
	TENANT_ID int NOT NULL,
	  --供应链名称
	RELATION_NAME varchar(50) NOT NULL,
	  --拼音码
	RELATION_SPELL varchar(50) NOT NULL,
	  --说明
	REMARK varchar(255),
	  --创建日期
	CREA_DATE varchar(10),
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_RELATION PRIMARY KEY (RELATION_ID)
);

CREATE INDEX IX_CA_RELATION_TENANT_ID ON CA_RELATION(TENANT_ID);
CREATE INDEX IX_CA_RELATION_TIME_STAMP ON CA_RELATION(TIME_STAMP);

--企业关系
CREATE TABLE CA_RELATIONS(
    --企业关系ID号
	RELATIONS_ID varchar(36) NOT NULL,
    --供应链ID号
	RELATION_ID int NOT NULL,
    --当前企业代码
	TENANT_ID int NOT NULL,
    --下级企业代码
	RELATI_ID int NOT NULL,
    --关系类型
	RELATION_TYPE varchar(1) NOT NULL,
    --结构树 000000 6位一级，最多支持5级 <在此不是一棵树，没有指企业供应链无法生成此代号>
	LEVEL_ID varchar(30) NOT NULL,
    --关系状态  1 申请 2 审核 
	RELATION_STATUS varchar(1) NOT NULL,
	  --创建日期
	CREA_DATE varchar(10),
	  --审核日期
	CHK_DATE varchar(10),
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_RELATIONS PRIMARY KEY (RELATIONS_ID)
);

CREATE INDEX IX_CA_RELATIONS_TENANT_ID ON CA_RELATIONS(TENANT_ID);

CREATE INDEX IX_CA_RELATIONS_RELATI_ID ON CA_RELATIONS(RELATI_ID);

CREATE INDEX IX_CA_RELATIONS_LEVEL_ID ON CA_RELATIONS(LEVEL_ID);

CREATE INDEX IX_CA_RELATIONS_TIME_STAMP ON CA_RELATIONS(TIME_STAMP);

--部门资料
CREATE TABLE CA_DEPT_INFO(
    --部门代码 企业代码+3位序号
	DEPT_ID varchar (10) NOT NULL,
    --部门名称
	DEPT_NAME varchar(50) NOT NULL,
    --拼音码
	DEPT_SPELL varchar(50) NOT NULL,
    --从属关系 第3位一级
	LEVEL_ID varchar(50),
    --企业代码
	TENANT_ID int,
    --部门电话
	TELEPHONE varchar(30),
    --联系人
	LINKMAN varchar(20),
    --传真
	FAXES varchar(30),
    --备注
	REMARK varchar(100),
    --排序号
  SEQ_NO int,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DEPT_INFO PRIMARY KEY (DEPT_ID )
);

CREATE INDEX IX_CA_DEPT_INFO_TENANT_ID ON CA_DEPT_INFO(TENANT_ID);

CREATE INDEX IX_CA_DEPT_INFO_TIME_STAMP ON CA_DEPT_INFO(TENANT_ID,TIME_STAMP);


--门店资料
CREATE TABLE CA_SHOP_INFO(
    --门店代码 企业代码+4位序号
	SHOP_ID varchar (11) NOT NULL,
    --经营许可证
	LICENSE_CODE varchar(50) NOT NULL,
    --门店名称
	SHOP_NAME varchar(50) NOT NULL,
    --拼音码
	SHOP_SPELL varchar(50) NOT NULL,
    --企业代码
	TENANT_ID int,
    --门店负责人
	LINKMAN varchar(20),
    --联系电话
	TELEPHONE varchar(30),
    --传真
	FAXES varchar(30),
    --门店地址
	ADDRESS varchar(50),
    --邮编
	POSTALCODE varchar(6),
    --备注
	REMARK varchar(100),
    --所属区域
	REGION_ID varchar(10),
    --门店类型(原管理群组 对应PUB_CODE_INFO)
	SHOP_TYPE varchar(36),
    --排序号
  SEQ_NO int,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_SHOP_INFO PRIMARY KEY(SHOP_ID)
);

CREATE INDEX IX_CA_SHOP_INFO_TENANT_ID ON CA_SHOP_INFO(TENANT_ID);

CREATE INDEX IX_CA_SHOP_INFO_TIME_STAMP ON CA_SHOP_INFO(TENANT_ID,TIME_STAMP);

--职务资料
CREATE TABLE CA_DUTY_INFO(
    --职务代码 企业代码+3位序号
	DUTY_ID varchar(10) NOT NULL,
    --职务名称
	DUTY_NAME varchar(30) NOT NULL,
    --从属关系 第3位一级
	LEVEL_ID varchar(50),
    --拼音码
	DUTY_SPELL varchar(30) NOT NULL,
    --所属企业
	TENANT_ID int NOT NULL,
    --说明
	REMARK varchar(100),
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_DUTY_INFO PRIMARY KEY(DUTY_ID)
);

CREATE INDEX IX_CA_DUTY_INFO_TENANT_ID ON CA_DUTY_INFO(TENANT_ID);

CREATE INDEX IX_CA_DUTY_INFO_TIME_STAMP ON CA_DUTY_INFO(TENANT_ID,TIME_STAMP);

--角色资料
CREATE TABLE CA_ROLE_INFO(
    --角色代码 企业代码+3位序号
	ROLE_ID varchar(10) NOT NULL,
    --角色名称
	ROLE_NAME varchar(30) NOT NULL,
    --拼音码
	ROLE_SPELL varchar(30) NOT NULL,
    --所属企业
	TENANT_ID int NOT NULL,
    --说明
	REMARK varchar(100),
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_CA_ROLE_INFO PRIMARY KEY(ROLE_ID)
);

CREATE INDEX IX_CA_ROLE_INFO_TENANT_ID ON CA_ROLE_INFO(TENANT_ID);

CREATE INDEX IX_CA_ROLE_INFO_TIME_STAMP ON CA_ROLE_INFO(TENANT_ID,TIME_STAMP);

--用户资料
CREATE TABLE CA_USERS(
    --用户代码newid()的guid值
	USER_ID varchar(36) NOT NULL,
    --登录名  企业内不重复
	ACCOUNT varchar(20) NOT NULL,
    --识别码  IC号卡或指纹码
	ENCODE varchar(50),
    --用户名
	USER_NAME varchar(20) NOT NULL,
    --拼音码
	USER_SPELL varchar(20) NOT NULL,
    --密码
	PASS_WRD varchar(50),
    --所属门店 
	SHOP_ID varchar (11) NOT NULL,
    --所属部门
	DEPT_ID varchar (10) NOT NULL,
    --所属职务,多职务用,号分隔
	DUTY_IDS varchar(100) NOT NULL,
    --所属职务名称,多职务用,号分隔
	DUTY_NAMES varchar(250) NOT NULL,
    --所属角色,多角色用,号分隔
	ROLE_IDS varchar(100) NOT NULL,
    --所属角色名称,多角色用,号分隔
	ROLE_NAMES varchar(250) NOT NULL,
    --企业代码
	TENANT_ID int NOT NULL,
    --性别  男\女\保密
	SEX varchar(4),
    --生日 
	BIRTHDAY varchar (10),
	  --学历
	DEGREES varchar(36),
    --手机号
	MOBILE varchar(11),
    --办公电话
	OFFI_TELE varchar(11),
    --家庭电话
	FAMI_TELE varchar(11),
    --电子邮箱
	EMAIL varchar(50),
    --QQ号
	QQ varchar(50),
    --盟盟号
	MM varchar(50),
    --MSN号
	MSN varchar(50),
    --证件号码
	ID_NUMBER varchar(50),
    --证件类型
	IDN_TYPE varchar(36),
    --家庭地址
	FAMI_ADDR varchar(50),
    --邮编
	POSTALCODE varchar(6),
    --入职日期
	WORK_DATE varchar(10),
    --职务日期
	DIMI_DATE varchar(10),
    --说明
	REMARK varchar(100),
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
  COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
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
select TENANT_ID,trim(char(TENANT_ID))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,trim(char(B.TENANT_ID))||'0001' as SHOP_ID,'administrator' as USER_ID,'administrator' as ACCOUNT,'超级管理员' as USER_NAME,'cjgly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--代码信息表
CREATE TABLE PUB_CODE_INFO(
    --企业代码<0为公共资料>
	TENANT_ID int NOT NULL,
    --资料编码 
	CODE_ID varchar(36) NOT NULL,
    --树ID号4位一级
	LEVEL_ID varchar (20) ,
    --资料类型
	CODE_TYPE varchar(2) NOT NULL,
    --资料名称
	CODE_NAME varchar(30) NOT NULL,
    --拼音码
	CODE_SPELL varchar(30) NOT NULL,
    --排序号
	SEQ_NO int,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
    --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
    CONSTRAINT PK_PUB_CODE_INFO PRIMARY KEY (TENANT_ID,CODE_ID,CODE_TYPE)
);

CREATE INDEX IX_PUB_CODE_INFO_CODE_TYPE ON PUB_CODE_INFO(TENANT_ID,CODE_TYPE);

CREATE INDEX IX_PUB_CODE_INFO_TIME_STAMP ON PUB_CODE_INFO(TENANT_ID,TIME_STAMP);

CREATE INDEX IX_PUB_CODE_INFO_TENANT_ID ON PUB_CODE_INFO(TENANT_ID);

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('8','地区编码','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','证件类型','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','管理群组','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('13','月均收入','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('14','学历','CODE_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('15','职业','CODE_TYPE','00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','身份证','SFZ','11',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','驾驶证','JSZ','11',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','社保卡','SBK','11',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','军官证','JGZ','11',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','护照','HZ','11',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','学生证','XSZ','11',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','经营许可证','JYXKZ','11',7,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'99','其他','QT','11',8,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','1000以下','','13',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','1000-2000','','13',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','2000-3000','','13',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','3000-4000','','13',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','4000-5000','','13',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','5000以上','','13',6,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','小学','XX','14',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','初中','CZ','14',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','高中','GZ','14',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','专科','ZK','14',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','本科','BK','14',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','硕士','SS','14',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','博士','BS','14',7,'00',5497000);

 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'1','金融','XX','15',1,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'2','地产','CZ','15',2,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'3','汽车','GZ','15',3,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'4','IT信息技术','ZK','15',4,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'5','顾问咨询','BK','15',5,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'6','媒体出版','SS','15',6,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'7','事业机关','BS','15',7,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'8','教育培训','BS','15',8,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'9','旅游休闲','BS','15',9,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'10','制造','BS','15',10,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'11','零售','BS','15',11,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'12','能源','BS','15',12,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'13','国际贸易','BS','15',13,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'14','物流','BS','15',14,'00',5497000);
 insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'99','其他','BS','15',99,'00',5497000);

 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110000,'110000','北京市','BJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110101,'110101','北京市.东城区','BJSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110102,'110102','北京市.西城区','BJSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110103,'110103','北京市.崇文区','BJSCWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110104,'110104','北京市.宣武区','BJSXWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110105,'110105','北京市.朝阳区','BJSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110106,'110106','北京市.丰台区','BJSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110107,'110107','北京市.石景山区','BJSSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110108,'110108','北京市.海淀区','BJSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110109,'110109','北京市.门头沟区','BJSMTGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110111,'110111','北京市.房山区','BJSFSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110112,'110112','北京市.通州区','BJSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110113,'110113','北京市.顺义区','BJSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110114,'110114','北京市.昌平区','BJSCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110115,'110115','北京市.大兴区','BJSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110116,'110116','北京市.怀柔区','BJSHRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110117,'110117','北京市.平谷区','BJSPGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110228,'110228','北京市.密云县','BJSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,110229,'110229','北京市.延庆县','BJSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120000,'120000','天津市','TJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120101,'120101','天津市.和平区','TJSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120102,'120102','天津市.河东区','TJSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120103,'120103','天津市.河西区','TJSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120104,'120104','天津市.南开区','TJSNKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120105,'120105','天津市.河北区','TJSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120106,'120106','天津市.红桥区','TJSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120110,'120110','天津市.东丽区','TJSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120111,'120111','天津市.西青区','TJSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120112,'120112','天津市.津南区','TJSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120113,'120113','天津市.北辰区','TJSBCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120114,'120114','天津市.武清区','TJSWQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120115,'120115','天津市.宝坻区','TJSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120116,'120116','天津市.滨海新区','TJSBHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120221,'120221','天津市.宁河县','TJSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120223,'120223','天津市.静海县','TJSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,120225,'120225','天津市.蓟县','TJSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130000,'130000','河北省','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130100,'130100','河北省.石家庄市','HBSSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130102,'130102','河北省.石家庄市.长安区','HBSSJZSCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130103,'130103','河北省.石家庄市.桥东区','HBSSJZSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130104,'130104','河北省.石家庄市.桥西区','HBSSJZSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130105,'130105','河北省.石家庄市.新华区','HBSSJZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130107,'130107','河北省.石家庄市.井陉矿区','HBSSJZSJZKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130108,'130108','河北省.石家庄市.裕华区','HBSSJZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130121,'130121','河北省.石家庄市.井陉县','HBSSJZSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130123,'130123','河北省.石家庄市.正定县','HBSSJZSZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130124,'130124','河北省.石家庄市.栾城县','HBSSJZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130125,'130125','河北省.石家庄市.行唐县','HBSSJZSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130126,'130126','河北省.石家庄市.灵寿县','HBSSJZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130127,'130127','河北省.石家庄市.高邑县','HBSSJZSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130128,'130128','河北省.石家庄市.深泽县','HBSSJZSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130129,'130129','河北省.石家庄市.赞皇县','HBSSJZSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130130,'130130','河北省.石家庄市.无极县','HBSSJZSWJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130131,'130131','河北省.石家庄市.平山县','HBSSJZSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130132,'130132','河北省.石家庄市.元氏县','HBSSJZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130133,'130133','河北省.石家庄市.赵县','HBSSJZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130181,'130181','河北省.石家庄市.辛集市','HBSSJZSXJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130182,'130182','河北省.石家庄市.藁城市','HBSSJZSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130183,'130183','河北省.石家庄市.晋州市','HBSSJZSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130184,'130184','河北省.石家庄市.新乐市','HBSSJZSXLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130185,'130185','河北省.石家庄市.鹿泉市','HBSSJZSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130200,'130200','河北省.唐山市','HBSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130202,'130202','河北省.唐山市.路南区','HBSTSSLNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130203,'130203','河北省.唐山市.路北区','HBSTSSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130204,'130204','河北省.唐山市.古冶区','HBSTSSGYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130205,'130205','河北省.唐山市.开平区','HBSTSSKPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130207,'130207','河北省.唐山市.丰南区','HBSTSSFNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130208,'130208','河北省.唐山市.丰润区','HBSTSSFRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130223,'130223','河北省.唐山市.滦县','HBSTSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130224,'130224','河北省.唐山市.滦南县','HBSTSSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130225,'130225','河北省.唐山市.乐亭县','HBSTSSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130227,'130227','河北省.唐山市.迁西县','HBSTSSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130229,'130229','河北省.唐山市.玉田县','HBSTSSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130230,'130230','河北省.唐山市.唐海县','HBSTSSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130281,'130281','河北省.唐山市.遵化市','HBSTSSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130283,'130283','河北省.唐山市.迁安市','HBSTSSQAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130300,'130300','河北省.秦皇岛市','HBSQHDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130302,'130302','河北省.秦皇岛市.海港区','HBSQHDSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130303,'130303','河北省.秦皇岛市.山海关区','HBSQHDSSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130304,'130304','河北省.秦皇岛市.北戴河区','HBSQHDSBDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130321,'130321','河北省.秦皇岛市.青龙县','HBSQHDSQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130322,'130322','河北省.秦皇岛市.昌黎县','HBSQHDSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130323,'130323','河北省.秦皇岛市.抚宁县','HBSQHDSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130324,'130324','河北省.秦皇岛市.卢龙县','HBSQHDSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130400,'130400','河北省.邯郸市','HBSHDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130402,'130402','河北省.邯郸市.邯山区','HBSHDSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130403,'130403','河北省.邯郸市.丛台区','HBSHDSCTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130404,'130404','河北省.邯郸市.复兴区','HBSHDSFXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130406,'130406','河北省.邯郸市.峰峰矿区','HBSHDSFFKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130421,'130421','河北省.邯郸市.邯郸县','HBSHDSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130423,'130423','河北省.邯郸市.临漳县','HBSHDSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130424,'130424','河北省.邯郸市.成安县','HBSHDSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130425,'130425','河北省.邯郸市.大名县','HBSHDSDMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130426,'130426','河北省.邯郸市.涉县','HBSHDSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130427,'130427','河北省.邯郸市.磁县','HBSHDSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130428,'130428','河北省.邯郸市.肥乡县','HBSHDSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130429,'130429','河北省.邯郸市.永年县','HBSHDSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130430,'130430','河北省.邯郸市.邱县','HBSHDSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130431,'130431','河北省.邯郸市.鸡泽县','HBSHDSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130432,'130432','河北省.邯郸市.广平县','HBSHDSGPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130433,'130433','河北省.邯郸市.馆陶县','HBSHDSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130434,'130434','河北省.邯郸市.魏县','HBSHDSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130435,'130435','河北省.邯郸市.曲周县','HBSHDSQZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130481,'130481','河北省.邯郸市.武安市','HBSHDSWAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130500,'130500','河北省.邢台市','HBSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130502,'130502','河北省.邢台市.桥东区','HBSXTSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130503,'130503','河北省.邢台市.桥西区','HBSXTSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130521,'130521','河北省.邢台市.邢台县','HBSXTSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130522,'130522','河北省.邢台市.临城县','HBSXTSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130523,'130523','河北省.邢台市.内丘县','HBSXTSNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130524,'130524','河北省.邢台市.柏乡县','HBSXTSBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130525,'130525','河北省.邢台市.隆尧县','HBSXTSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130526,'130526','河北省.邢台市.任县','HBSXTSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130527,'130527','河北省.邢台市.南和县','HBSXTSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130528,'130528','河北省.邢台市.宁晋县','HBSXTSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130529,'130529','河北省.邢台市.巨鹿县','HBSXTSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130530,'130530','河北省.邢台市.新河县','HBSXTSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130531,'130531','河北省.邢台市.广宗县','HBSXTSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130532,'130532','河北省.邢台市.平乡县','HBSXTSPXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130533,'130533','河北省.邢台市.威县','HBSXTSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130534,'130534','河北省.邢台市.清河县','HBSXTSQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130535,'130535','河北省.邢台市.临西县','HBSXTSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130581,'130581','河北省.邢台市.南宫市','HBSXTSNGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130582,'130582','河北省.邢台市.沙河市','HBSXTSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130600,'130600','河北省.保定市','HBSBDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130602,'130602','河北省.保定市.新市区','HBSBDSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130603,'130603','河北省.保定市.北市区','HBSBDSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130604,'130604','河北省.保定市.南市区','HBSBDSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130621,'130621','河北省.保定市.满城县','HBSBDSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130622,'130622','河北省.保定市.清苑县','HBSBDSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130623,'130623','河北省.保定市.涞水县','HBSBDSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130624,'130624','河北省.保定市.阜平县','HBSBDSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130625,'130625','河北省.保定市.徐水县','HBSBDSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130626,'130626','河北省.保定市.定兴县','HBSBDSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130627,'130627','河北省.保定市.唐县','HBSBDSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130628,'130628','河北省.保定市.高阳县','HBSBDSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130629,'130629','河北省.保定市.容城县','HBSBDSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130630,'130630','河北省.保定市.涞源县','HBSBDSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130631,'130631','河北省.保定市.望都县','HBSBDSWDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130632,'130632','河北省.保定市.安新县','HBSBDSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130633,'130633','河北省.保定市.易县','HBSBDSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130634,'130634','河北省.保定市.曲阳县','HBSBDSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130635,'130635','河北省.保定市.蠡县','HBSBDSlX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130636,'130636','河北省.保定市.顺平县','HBSBDSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130637,'130637','河北省.保定市.博野县','HBSBDSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130638,'130638','河北省.保定市.雄县','HBSBDSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130681,'130681','河北省.保定市.涿州市','HBSBDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130682,'130682','河北省.保定市.定州市','HBSBDSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130683,'130683','河北省.保定市.安国市','HBSBDSAGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130684,'130684','河北省.保定市.高碑店市','HBSBDSGBDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130700,'130700','河北省.张家口市','HBSZJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130702,'130702','河北省.张家口市.桥东区','HBSZJKSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130703,'130703','河北省.张家口市.桥西区','HBSZJKSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130705,'130705','河北省.张家口市.宣化区','HBSZJKSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130706,'130706','河北省.张家口市.下花园区','HBSZJKSXHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130721,'130721','河北省.张家口市.宣化县','HBSZJKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130722,'130722','河北省.张家口市.张北县','HBSZJKSZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130723,'130723','河北省.张家口市.康保县','HBSZJKSKBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130724,'130724','河北省.张家口市.沽源县','HBSZJKSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130725,'130725','河北省.张家口市.尚义县','HBSZJKSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130726,'130726','河北省.张家口市.蔚县','HBSZJKSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130727,'130727','河北省.张家口市.阳原县','HBSZJKSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130728,'130728','河北省.张家口市.怀安县','HBSZJKSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130729,'130729','河北省.张家口市.万全县','HBSZJKSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130730,'130730','河北省.张家口市.怀来县','HBSZJKSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130731,'130731','河北省.张家口市.涿鹿县','HBSZJKSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130732,'130732','河北省.张家口市.赤城县','HBSZJKSCCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130733,'130733','河北省.张家口市.崇礼县','HBSZJKSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130800,'130800','河北省.承德市','HBSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130802,'130802','河北省.承德市.双桥区','HBSCDSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130803,'130803','河北省.承德市.双滦区','HBSCDSSLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130804,'130804','河北省.承德市.鹰手营子矿区','HBSCDSYSYZKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130821,'130821','河北省.承德市.承德县','HBSCDSCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130822,'130822','河北省.承德市.兴隆县','HBSCDSXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130823,'130823','河北省.承德市.平泉县','HBSCDSPQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130824,'130824','河北省.承德市.滦平县','HBSCDSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130825,'130825','河北省.承德市.隆化县','HBSCDSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130826,'130826','河北省.承德市.丰宁县','HBSCDSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130827,'130827','河北省.承德市.宽城县','HBSCDSKCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130828,'130828','河北省.承德市.围场县','HBSCDSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130900,'130900','河北省.沧州市','HBSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130902,'130902','河北省.沧州市.新华区','HBSCZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130903,'130903','河北省.沧州市.运河区','HBSCZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130921,'130921','河北省.沧州市.沧县','HBSCZSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130922,'130922','河北省.沧州市.青县','HBSCZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130923,'130923','河北省.沧州市.东光县','HBSCZSDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130924,'130924','河北省.沧州市.海兴县','HBSCZSHXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130925,'130925','河北省.沧州市.盐山县','HBSCZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130926,'130926','河北省.沧州市.肃宁县','HBSCZSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130927,'130927','河北省.沧州市.南皮县','HBSCZSNPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130928,'130928','河北省.沧州市.吴桥县','HBSCZSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130929,'130929','河北省.沧州市.献县','HBSCZSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130930,'130930','河北省.沧州市.孟村县','HBSCZSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130981,'130981','河北省.沧州市.泊头市','HBSCZSBTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130982,'130982','河北省.沧州市.任丘市','HBSCZSRQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130983,'130983','河北省.沧州市.黄骅市','HBSCZSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,130984,'130984','河北省.沧州市.河间市','HBSCZSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131000,'131000','河北省.廊坊市','HBSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131002,'131002','河北省.廊坊市.安次区','HBSLFSACQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131003,'131003','河北省.廊坊市.广阳区','HBSLFSGYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131022,'131022','河北省.廊坊市.固安县','HBSLFSGAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131023,'131023','河北省.廊坊市.永清县','HBSLFSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131024,'131024','河北省.廊坊市.香河县','HBSLFSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131025,'131025','河北省.廊坊市.大城县','HBSLFSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131026,'131026','河北省.廊坊市.文安县','HBSLFSWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131028,'131028','河北省.廊坊市.大厂县','HBSLFSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131081,'131081','河北省.廊坊市.霸州市','HBSLFSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131082,'131082','河北省.廊坊市.三河市','HBSLFSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131100,'131100','河北省.衡水市','HBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131102,'131102','河北省.衡水市.桃城区','HBSHSSTCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131121,'131121','河北省.衡水市.枣强县','HBSHSSZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131122,'131122','河北省.衡水市.武邑县','HBSHSSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131123,'131123','河北省.衡水市.武强县','HBSHSSWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131124,'131124','河北省.衡水市.饶阳县','HBSHSSRYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131125,'131125','河北省.衡水市.安平县','HBSHSSAPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131126,'131126','河北省.衡水市.故城县','HBSHSSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131127,'131127','河北省.衡水市.景县','HBSHSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131128,'131128','河北省.衡水市.阜城县','HBSHSSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131181,'131181','河北省.衡水市.冀州市','HBSHSSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,131182,'131182','河北省.衡水市.深州市','HBSHSSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140000,'140000','山西省','SXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140100,'140100','山西省.太原市','SXSTYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140105,'140105','山西省.太原市.小店区','SXSTYSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140106,'140106','山西省.太原市.迎泽区','SXSTYSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140107,'140107','山西省.太原市.杏花岭区','SXSTYSXHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140108,'140108','山西省.太原市.尖草坪区','SXSTYSJCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140109,'140109','山西省.太原市.万柏林区','SXSTYSWBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140110,'140110','山西省.太原市.晋源区','SXSTYSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140121,'140121','山西省.太原市.清徐县','SXSTYSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140122,'140122','山西省.太原市.阳曲县','SXSTYSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140123,'140123','山西省.太原市.娄烦县','SXSTYSLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140181,'140181','山西省.太原市.古交市','SXSTYSGJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140200,'140200','山西省.大同市','SXSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140202,'140202','山西省.大同市.城区','SXSDTSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140203,'140203','山西省.大同市.矿区','SXSDTSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140211,'140211','山西省.大同市.南郊区','SXSDTSNJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140212,'140212','山西省.大同市.新荣区','SXSDTSXRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140221,'140221','山西省.大同市.阳高县','SXSDTSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140222,'140222','山西省.大同市.天镇县','SXSDTSTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140223,'140223','山西省.大同市.广灵县','SXSDTSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140224,'140224','山西省.大同市.灵丘县','SXSDTSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140225,'140225','山西省.大同市.浑源县','SXSDTSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140226,'140226','山西省.大同市.左云县','SXSDTSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140227,'140227','山西省.大同市.大同县','SXSDTSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140300,'140300','山西省.阳泉市','SXSYQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140302,'140302','山西省.阳泉市.城区','SXSYQSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140303,'140303','山西省.阳泉市.矿区','SXSYQSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140311,'140311','山西省.阳泉市.郊区','SXSYQSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140321,'140321','山西省.阳泉市.平定县','SXSYQSPDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140322,'140322','山西省.阳泉市.盂县','SXSYQSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140400,'140400','山西省.长治市','SXSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140402,'140402','山西省.长治市.城区','SXSCZSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140411,'140411','山西省.长治市.郊区','SXSCZSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140421,'140421','山西省.长治市.长治县','SXSCZSCZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140423,'140423','山西省.长治市.襄垣县','SXSCZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140424,'140424','山西省.长治市.屯留县','SXSCZSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140425,'140425','山西省.长治市.平顺县','SXSCZSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140426,'140426','山西省.长治市.黎城县','SXSCZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140427,'140427','山西省.长治市.壶关县','SXSCZSHGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140428,'140428','山西省.长治市.长子县','SXSCZSCZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140429,'140429','山西省.长治市.武乡县','SXSCZSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140430,'140430','山西省.长治市.沁县','SXSCZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140431,'140431','山西省.长治市.沁源县','SXSCZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140481,'140481','山西省.长治市.潞城市','SXSCZSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140500,'140500','山西省.晋城市','SXSJCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140502,'140502','山西省.晋城市.城区','SXSJCSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140521,'140521','山西省.晋城市.沁水县','SXSJCSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140522,'140522','山西省.晋城市.阳城县','SXSJCSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140524,'140524','山西省.晋城市.陵川县','SXSJCSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140525,'140525','山西省.晋城市.泽州县','SXSJCSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140581,'140581','山西省.晋城市.高平市','SXSJCSGPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140600,'140600','山西省.朔州市','SXSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140602,'140602','山西省.朔州市.朔城区','SXSSZSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140603,'140603','山西省.朔州市.平鲁区','SXSSZSPLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140621,'140621','山西省.朔州市.山阴县','SXSSZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140622,'140622','山西省.朔州市.应县','SXSSZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140623,'140623','山西省.朔州市.右玉县','SXSSZSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140624,'140624','山西省.朔州市.怀仁县','SXSSZSHRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140700,'140700','山西省.晋中市','SXSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140702,'140702','山西省.晋中市.榆次区','SXSJZSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140721,'140721','山西省.晋中市.榆社县','SXSJZSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140722,'140722','山西省.晋中市.左权县','SXSJZSZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140723,'140723','山西省.晋中市.和顺县','SXSJZSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140724,'140724','山西省.晋中市.昔阳县','SXSJZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140725,'140725','山西省.晋中市.寿阳县','SXSJZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140726,'140726','山西省.晋中市.太谷县','SXSJZSTGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140727,'140727','山西省.晋中市.祁县','SXSJZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140728,'140728','山西省.晋中市.平遥县','SXSJZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140729,'140729','山西省.晋中市.灵石县','SXSJZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140781,'140781','山西省.晋中市.介休市','SXSJZSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140800,'140800','山西省.运城市','SXSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140802,'140802','山西省.运城市.盐湖区','SXSYCSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140821,'140821','山西省.运城市.临猗县','SXSYCSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140822,'140822','山西省.运城市.万荣县','SXSYCSWRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140823,'140823','山西省.运城市.闻喜县','SXSYCSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140824,'140824','山西省.运城市.稷山县','SXSYCSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140825,'140825','山西省.运城市.新绛县','SXSYCSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140826,'140826','山西省.运城市.绛县','SXSYCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140827,'140827','山西省.运城市.垣曲县','SXSYCSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140828,'140828','山西省.运城市.夏县','SXSYCSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140829,'140829','山西省.运城市.平陆县','SXSYCSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140830,'140830','山西省.运城市.芮城县','SXSYCSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140881,'140881','山西省.运城市.永济市','SXSYCSYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140882,'140882','山西省.运城市.河津市','SXSYCSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140900,'140900','山西省.忻州市','SXSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140902,'140902','山西省.忻州市.忻府区','SXSXZSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140921,'140921','山西省.忻州市.定襄县','SXSXZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140922,'140922','山西省.忻州市.五台县','SXSXZSWTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140923,'140923','山西省.忻州市.代县','SXSXZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140924,'140924','山西省.忻州市.繁峙县','SXSXZSFZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140925,'140925','山西省.忻州市.宁武县','SXSXZSNWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140926,'140926','山西省.忻州市.静乐县','SXSXZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140927,'140927','山西省.忻州市.神池县','SXSXZSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140928,'140928','山西省.忻州市.五寨县','SXSXZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140929,'140929','山西省.忻州市.岢岚县','SXSXZSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140930,'140930','山西省.忻州市.河曲县','SXSXZSHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140931,'140931','山西省.忻州市.保德县','SXSXZSBDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140932,'140932','山西省.忻州市.偏关县','SXSXZSPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,140981,'140981','山西省.忻州市.原平市','SXSXZSYPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141000,'141000','山西省.临汾市','SXSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141002,'141002','山西省.临汾市.尧都区','SXSLFSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141021,'141021','山西省.临汾市.曲沃县','SXSLFSQWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141022,'141022','山西省.临汾市.翼城县','SXSLFSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141023,'141023','山西省.临汾市.襄汾县','SXSLFSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141024,'141024','山西省.临汾市.洪洞县','SXSLFSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141025,'141025','山西省.临汾市.古县','SXSLFSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141026,'141026','山西省.临汾市.安泽县','SXSLFSAZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141027,'141027','山西省.临汾市.浮山县','SXSLFSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141028,'141028','山西省.临汾市.吉县','SXSLFSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141029,'141029','山西省.临汾市.乡宁县','SXSLFSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141030,'141030','山西省.临汾市.大宁县','SXSLFSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141031,'141031','山西省.临汾市.隰县','SXSLFSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141032,'141032','山西省.临汾市.永和县','SXSLFSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141033,'141033','山西省.临汾市.蒲县','SXSLFSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141034,'141034','山西省.临汾市.汾西县','SXSLFSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141081,'141081','山西省.临汾市.侯马市','SXSLFSHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141082,'141082','山西省.临汾市.霍州市','SXSLFSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141100,'141100','山西省.吕梁市','SXSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141102,'141102','山西省.吕梁市.离石区','SXSLLSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141121,'141121','山西省.吕梁市.文水县','SXSLLSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141122,'141122','山西省.吕梁市.交城县','SXSLLSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141123,'141123','山西省.吕梁市.兴县','SXSLLSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141124,'141124','山西省.吕梁市.临县','SXSLLSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141125,'141125','山西省.吕梁市.柳林县','SXSLLSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141126,'141126','山西省.吕梁市.石楼县','SXSLLSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141127,'141127','山西省.吕梁市.岚县','SXSLLSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141128,'141128','山西省.吕梁市.方山县','SXSLLSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141129,'141129','山西省.吕梁市.中阳县','SXSLLSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141130,'141130','山西省.吕梁市.交口县','SXSLLSJKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141181,'141181','山西省.吕梁市.孝义市','SXSLLSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,141182,'141182','山西省.吕梁市.汾阳市','SXSLLSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150000,'150000','内蒙','NM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150100,'150100','内蒙.呼和浩特市','NMHHHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150102,'150102','内蒙.呼和浩特市.新城区','NMHHHTSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150103,'150103','内蒙.呼和浩特市.回民区','NMHHHTSHMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150104,'150104','内蒙.呼和浩特市.玉泉区','NMHHHTSYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150105,'150105','内蒙.呼和浩特市.赛罕区','NMHHHTSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150121,'150121','内蒙.呼和浩特市.土默特左旗','NMHHHTSTMTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150122,'150122','内蒙.呼和浩特市.托克托县','NMHHHTSTKTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150123,'150123','内蒙.呼和浩特市.和林格尔县','NMHHHTSHLGEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150124,'150124','内蒙.呼和浩特市.清水河县','NMHHHTSQSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150125,'150125','内蒙.呼和浩特市.武川县','NMHHHTSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150200,'150200','内蒙.包头市','NMBTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150202,'150202','内蒙.包头市.东河区','NMBTSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150203,'150203','内蒙.包头市.昆都仑区','NMBTSKDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150204,'150204','内蒙.包头市.青山区','NMBTSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150205,'150205','内蒙.包头市.石拐区','NMBTSSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150206,'150206','内蒙.包头市.白云鄂博矿区','NMBTSBYEBKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150207,'150207','内蒙.包头市.九原区','NMBTSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150221,'150221','内蒙.包头市.土默特右旗','NMBTSTMTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150222,'150222','内蒙.包头市.固阳县','NMBTSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150223,'150223','内蒙.包头市.达尔罕茂明安联合旗','NMBTSDEHMMALHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150300,'150300','内蒙.乌海市','NMWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150302,'150302','内蒙.乌海市.海勃湾区','NMWHSHBWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150303,'150303','内蒙.乌海市.海南区','NMWHSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150304,'150304','内蒙.乌海市.乌达区','NMWHSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150400,'150400','内蒙.赤峰市','NMCFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150402,'150402','内蒙.赤峰市.红山区','NMCFSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150403,'150403','内蒙.赤峰市.元宝山区','NMCFSYBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150404,'150404','内蒙.赤峰市.松山区','NMCFSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150421,'150421','内蒙.赤峰市.阿鲁科尔沁旗','NMCFSALKEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150422,'150422','内蒙.赤峰市.巴林左旗','NMCFSBLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150423,'150423','内蒙.赤峰市.巴林右旗','NMCFSBLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150424,'150424','内蒙.赤峰市.林西县','NMCFSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150425,'150425','内蒙.赤峰市.克什克腾旗','NMCFSKSKTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150426,'150426','内蒙.赤峰市.翁牛特旗','NMCFSWNTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150428,'150428','内蒙.赤峰市.喀喇沁旗','NMCFSKLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150429,'150429','内蒙.赤峰市.宁城县','NMCFSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150430,'150430','内蒙.赤峰市.敖汉旗','NMCFSAHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150500,'150500','内蒙.通辽市','NMTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150502,'150502','内蒙.通辽市.科尔沁区','NMTLSKEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150521,'150521','内蒙.通辽市.科尔沁左翼中旗','NMTLSKEQZYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150522,'150522','内蒙.通辽市.科尔沁左翼后旗','NMTLSKEQZYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150523,'150523','内蒙.通辽市.开鲁县','NMTLSKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150524,'150524','内蒙.通辽市.库伦旗','NMTLSKLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150525,'150525','内蒙.通辽市.奈曼旗','NMTLSNMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150526,'150526','内蒙.通辽市.扎鲁特旗','NMTLSZLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150581,'150581','内蒙.通辽市.霍林郭勒市','NMTLSHLGLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150600,'150600','内蒙.鄂尔多斯市','NMEEDSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150602,'150602','内蒙.鄂尔多斯市.东胜区','NMEEDSSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150621,'150621','内蒙.鄂尔多斯市.达拉特旗','NMEEDSSDLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150622,'150622','内蒙.鄂尔多斯市.准格尔旗','NMEEDSSZGEQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150623,'150623','内蒙.鄂尔多斯市.鄂托克前旗','NMEEDSSETKQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150624,'150624','内蒙.鄂尔多斯市.鄂托克旗','NMEEDSSETKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150625,'150625','内蒙.鄂尔多斯市.杭锦旗','NMEEDSSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150626,'150626','内蒙.鄂尔多斯市.乌审旗','NMEEDSSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150627,'150627','内蒙.鄂尔多斯市.伊金霍洛旗','NMEEDSSYJHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150700,'150700','内蒙.呼伦贝尔市','NMHLBES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150702,'150702','内蒙.呼伦贝尔市.海拉尔区','NMHLBESHLEQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150721,'150721','内蒙.呼伦贝尔市.阿荣旗','NMHLBESARQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150722,'150722','内蒙.呼伦贝尔市.莫旗','NMHLBESMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150723,'150723','内蒙.呼伦贝尔市.鄂伦春自治旗','NMHLBESELCZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150724,'150724','内蒙.呼伦贝尔市.鄂温克族自治旗','NMHLBESEWKZZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150725,'150725','内蒙.呼伦贝尔市.陈巴尔虎旗','NMHLBESCBEHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150726,'150726','内蒙.呼伦贝尔市.新巴尔虎左旗','NMHLBESXBEHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150727,'150727','内蒙.呼伦贝尔市.新巴尔虎右旗','NMHLBESXBEHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150781,'150781','内蒙.呼伦贝尔市.满洲里市','NMHLBESMZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150782,'150782','内蒙.呼伦贝尔市.牙克石市','NMHLBESYKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150783,'150783','内蒙.呼伦贝尔市.扎兰屯市','NMHLBESZLTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150784,'150784','内蒙.呼伦贝尔市.额尔古纳市','NMHLBESEEGNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150785,'150785','内蒙.呼伦贝尔市.根河市','NMHLBESGHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150800,'150800','内蒙.巴彦淖尔市','NMBYNES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150802,'150802','内蒙.巴彦淖尔市.临河区','NMBYNESLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150821,'150821','内蒙.巴彦淖尔市.五原县','NMBYNESWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150822,'150822','内蒙.巴彦淖尔市.磴口县','NMBYNESZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150823,'150823','内蒙.巴彦淖尔市.乌拉特前旗','NMBYNESWLTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150824,'150824','内蒙.巴彦淖尔市.乌拉特中旗','NMBYNESWLTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150825,'150825','内蒙.巴彦淖尔市.乌拉特后旗','NMBYNESWLTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150826,'150826','内蒙.巴彦淖尔市.杭锦后旗','NMBYNESHJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150900,'150900','内蒙.乌兰察布市','NMWLCBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150902,'150902','内蒙.乌兰察布市.集宁区','NMWLCBSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150921,'150921','内蒙.乌兰察布市.卓资县','NMWLCBSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150922,'150922','内蒙.乌兰察布市.化德县','NMWLCBSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150923,'150923','内蒙.乌兰察布市.商都县','NMWLCBSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150924,'150924','内蒙.乌兰察布市.兴和县','NMWLCBSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150925,'150925','内蒙.乌兰察布市.凉城县','NMWLCBSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150926,'150926','内蒙.乌兰察布市.察哈尔右翼前旗','NMWLCBSCHEYYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150927,'150927','内蒙.乌兰察布市.察哈尔右翼中旗','NMWLCBSCHEYYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150928,'150928','内蒙.乌兰察布市.察哈尔右翼后旗','NMWLCBSCHEYYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150929,'150929','内蒙.乌兰察布市.四子王旗','NMWLCBSSZWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,150981,'150981','内蒙.乌兰察布市.丰镇市','NMWLCBSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152200,'152200','内蒙.兴安盟','NMXAM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152201,'152201','内蒙.兴安盟.乌兰浩特市','NMXAMWLHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152202,'152202','内蒙.兴安盟.阿尔山市','NMXAMAESS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152221,'152221','内蒙.兴安盟.科尔沁右翼前旗','NMXAMKEQYYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152222,'152222','内蒙.兴安盟.科尔沁右翼中旗','NMXAMKEQYYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152223,'152223','内蒙.兴安盟.扎赉特旗','NMXAMZZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152224,'152224','内蒙.兴安盟.突泉县','NMXAMTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152500,'152500','内蒙.锡林郭勒盟','NMXLGLM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152501,'152501','内蒙.锡林郭勒盟.二连浩特市','NMXLGLMELHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152502,'152502','内蒙.锡林郭勒盟.锡林浩特市','NMXLGLMXLHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152522,'152522','内蒙.锡林郭勒盟.阿巴嘎旗','NMXLGLMABGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152523,'152523','内蒙.锡林郭勒盟.苏尼特左旗','NMXLGLMSNTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152524,'152524','内蒙.锡林郭勒盟.苏尼特右旗','NMXLGLMSNTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152525,'152525','内蒙.锡林郭勒盟.东乌珠穆沁旗','NMXLGLMDWZMQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152526,'152526','内蒙.锡林郭勒盟.西乌珠穆沁旗','NMXLGLMXWZMQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152527,'152527','内蒙.锡林郭勒盟.太仆寺旗','NMXLGLMTPSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152528,'152528','内蒙.锡林郭勒盟.镶黄旗','NMXLGLMXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152529,'152529','内蒙.锡林郭勒盟.正镶白旗','NMXLGLMZXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152530,'152530','内蒙.锡林郭勒盟.正蓝旗','NMXLGLMZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152531,'152531','内蒙.锡林郭勒盟.多伦县','NMXLGLMDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152900,'152900','内蒙.阿拉善盟','NMALSM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152921,'152921','内蒙.阿拉善盟.阿拉善左旗','NMALSMALSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152922,'152922','内蒙.阿拉善盟.阿拉善右旗','NMALSMALSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,152923,'152923','内蒙.阿拉善盟.额济纳旗','NMALSMEJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210100,'210100','辽宁省.沈阳市','LNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210102,'210102','辽宁省.沈阳市.和平区','LNSSYSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210103,'210103','辽宁省.沈阳市.沈河区','LNSSYSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210104,'210104','辽宁省.沈阳市.大东区','LNSSYSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210105,'210105','辽宁省.沈阳市.皇姑区','LNSSYSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210106,'210106','辽宁省.沈阳市.铁西区','LNSSYSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210111,'210111','辽宁省.沈阳市.苏家屯区','LNSSYSSJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210112,'210112','辽宁省.沈阳市.东陵区','LNSSYSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210113,'210113','辽宁省.沈阳市.沈北新区','LNSSYSSBXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210114,'210114','辽宁省.沈阳市.于洪区','LNSSYSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210122,'210122','辽宁省.沈阳市.辽中县','LNSSYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210123,'210123','辽宁省.沈阳市.康平县','LNSSYSKPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210124,'210124','辽宁省.沈阳市.法库县','LNSSYSFKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210181,'210181','辽宁省.沈阳市.新民市','LNSSYSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210200,'210200','辽宁省.大连市','LNSDLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210202,'210202','辽宁省.大连市.中山区','LNSDLSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210203,'210203','辽宁省.大连市.西岗区','LNSDLSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210204,'210204','辽宁省.大连市.沙河口区','LNSDLSSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210211,'210211','辽宁省.大连市.甘井子区','LNSDLSGJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210212,'210212','辽宁省.大连市.旅顺口区','LNSDLSLSKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210213,'210213','辽宁省.大连市.金州区','LNSDLSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210224,'210224','辽宁省.大连市.长海县','LNSDLSCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210281,'210281','辽宁省.大连市.瓦房店市','LNSDLSWFDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210282,'210282','辽宁省.大连市.普兰店市','LNSDLSPLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210283,'210283','辽宁省.大连市.庄河市','LNSDLSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210300,'210300','辽宁省.鞍山市','LNSASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210302,'210302','辽宁省.鞍山市.铁东区','LNSASSTDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210303,'210303','辽宁省.鞍山市.铁西区','LNSASSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210304,'210304','辽宁省.鞍山市.立山区','LNSASSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210311,'210311','辽宁省.鞍山市.千山区','LNSASSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210321,'210321','辽宁省.鞍山市.台安县','LNSASSTAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210323,'210323','辽宁省.鞍山市.岫岩满族自治县','LNSASSZYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210381,'210381','辽宁省.鞍山市.海城市','LNSASSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210400,'210400','辽宁省.抚顺市','LNSFSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210402,'210402','辽宁省.抚顺市.新抚区','LNSFSSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210403,'210403','辽宁省.抚顺市.东洲区','LNSFSSDZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210404,'210404','辽宁省.抚顺市.望花区','LNSFSSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210411,'210411','辽宁省.抚顺市.顺城区','LNSFSSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210421,'210421','辽宁省.抚顺市.抚顺县','LNSFSSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210422,'210422','辽宁省.抚顺市.新宾满族自治县','LNSFSSXBMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210423,'210423','辽宁省.抚顺市.清原满族自治县','LNSFSSQYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210500,'210500','辽宁省.本溪市','LNSBXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210502,'210502','辽宁省.本溪市.平山区','LNSBXSPSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210503,'210503','辽宁省.本溪市.溪湖区','LNSBXSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210504,'210504','辽宁省.本溪市.明山区','LNSBXSMSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210505,'210505','辽宁省.本溪市.南芬区','LNSBXSNFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210521,'210521','辽宁省.本溪市.本溪满族自治县','LNSBXSBXMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210522,'210522','辽宁省.本溪市.桓仁满族自治县','LNSBXSHRMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210600,'210600','辽宁省.丹东市','LNSDDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210602,'210602','辽宁省.丹东市.元宝区','LNSDDSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210603,'210603','辽宁省.丹东市.振兴区','LNSDDSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210604,'210604','辽宁省.丹东市.振安区','LNSDDSZAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210624,'210624','辽宁省.丹东市.宽甸满族自治县','LNSDDSKDMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210681,'210681','辽宁省.丹东市.东港市','LNSDDSDGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210682,'210682','辽宁省.丹东市.凤城市','LNSDDSFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210700,'210700','辽宁省.锦州市','LNSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210702,'210702','辽宁省.锦州市.古塔区','LNSJZSGTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210703,'210703','辽宁省.锦州市.凌河区','LNSJZSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210711,'210711','辽宁省.锦州市.太和区','LNSJZSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210726,'210726','辽宁省.锦州市.黑山县','LNSJZSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210727,'210727','辽宁省.锦州市.义县','LNSJZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210781,'210781','辽宁省.锦州市.凌海市','LNSJZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210782,'210782','辽宁省.锦州市.北镇市','LNSJZSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210800,'210800','辽宁省.营口市','LNSYKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210802,'210802','辽宁省.营口市.站前区','LNSYKSZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210803,'210803','辽宁省.营口市.西市区','LNSYKSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210804,'210804','辽宁省.营口市.鲅鱼圈区','LNSYKSBYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210811,'210811','辽宁省.营口市.老边区','LNSYKSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210881,'210881','辽宁省.营口市.盖州市','LNSYKSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210882,'210882','辽宁省.营口市.大石桥市','LNSYKSDSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210900,'210900','辽宁省.阜新市','LNSFXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210902,'210902','辽宁省.阜新市.海州区','LNSFXSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210903,'210903','辽宁省.阜新市.新邱区','LNSFXSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210904,'210904','辽宁省.阜新市.太平区','LNSFXSTPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210905,'210905','辽宁省.阜新市.清河门区','LNSFXSQHMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210911,'210911','辽宁省.阜新市.细河区','LNSFXSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210921,'210921','辽宁省.阜新市.阜新蒙古族自治县','LNSFXSFXMGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,210922,'210922','辽宁省.阜新市.彰武县','LNSFXSZWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211000,'211000','辽宁省.辽阳市','LNSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211002,'211002','辽宁省.辽阳市.白塔区','LNSLYSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211003,'211003','辽宁省.辽阳市.文圣区','LNSLYSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211004,'211004','辽宁省.辽阳市.宏伟区','LNSLYSHWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211005,'211005','辽宁省.辽阳市.弓长岭区','LNSLYSGCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211011,'211011','辽宁省.辽阳市.太子河区','LNSLYSTZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211021,'211021','辽宁省.辽阳市.辽阳县','LNSLYSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211081,'211081','辽宁省.辽阳市.灯塔市','LNSLYSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211100,'211100','辽宁省.盘锦市','LNSPJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211102,'211102','辽宁省.盘锦市.双台子区','LNSPJSSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211103,'211103','辽宁省.盘锦市.兴隆台区','LNSPJSXLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211121,'211121','辽宁省.盘锦市.大洼县','LNSPJSDWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211122,'211122','辽宁省.盘锦市.盘山县','LNSPJSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211200,'211200','辽宁省.铁岭市','LNSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211202,'211202','辽宁省.铁岭市.银州区','LNSTLSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211204,'211204','辽宁省.铁岭市.清河区','LNSTLSQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211221,'211221','辽宁省.铁岭市.铁岭县','LNSTLSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211223,'211223','辽宁省.铁岭市.西丰县','LNSTLSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211224,'211224','辽宁省.铁岭市.昌图县','LNSTLSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211281,'211281','辽宁省.铁岭市.调兵山市','LNSTLSDBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211282,'211282','辽宁省.铁岭市.开原市','LNSTLSKYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211300,'211300','辽宁省.朝阳市','LNSCYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211302,'211302','辽宁省.朝阳市.双塔区','LNSCYSSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211303,'211303','辽宁省.朝阳市.龙城区','LNSCYSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211321,'211321','辽宁省.朝阳市.朝阳县','LNSCYSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211322,'211322','辽宁省.朝阳市.建平县','LNSCYSJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211324,'211324','辽宁省.朝阳市.喀喇沁自治县','LNSCYSKLQZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211381,'211381','辽宁省.朝阳市.北票市','LNSCYSBPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211382,'211382','辽宁省.朝阳市.凌源市','LNSCYSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211400,'211400','辽宁省.葫芦岛市','LNSHLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211402,'211402','辽宁省.葫芦岛市.连山区','LNSHLDSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211403,'211403','辽宁省.葫芦岛市.龙港区','LNSHLDSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211404,'211404','辽宁省.葫芦岛市.南票区','LNSHLDSNPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211421,'211421','辽宁省.葫芦岛市.绥中县','LNSHLDSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211422,'211422','辽宁省.葫芦岛市.建昌县','LNSHLDSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,211481,'211481','辽宁省.葫芦岛市.兴城市','LNSHLDSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220000,'220000','吉林省','JLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220100,'220100','吉林省.长春市','JLSCCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220102,'220102','吉林省.长春市.南关区','JLSCCSNGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220103,'220103','吉林省.长春市.宽城区','JLSCCSKCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220104,'220104','吉林省.长春市.朝阳区','JLSCCSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220105,'220105','吉林省.长春市.二道区','JLSCCSEDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220106,'220106','吉林省.长春市.绿园区','JLSCCSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220112,'220112','吉林省.长春市.双阳区','JLSCCSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220122,'220122','吉林省.长春市.农安县','JLSCCSNAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220181,'220181','吉林省.长春市.九台市','JLSCCSJTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220182,'220182','吉林省.长春市.榆树市','JLSCCSYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220183,'220183','吉林省.长春市.德惠市','JLSCCSDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220200,'220200','吉林省.吉林市','JLSJLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220202,'220202','吉林省.吉林市.昌邑区','JLSJLSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220203,'220203','吉林省.吉林市.龙潭区','JLSJLSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220204,'220204','吉林省.吉林市.船营区','JLSJLSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220211,'220211','吉林省.吉林市.丰满区','JLSJLSFMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220221,'220221','吉林省.吉林市.永吉县','JLSJLSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220281,'220281','吉林省.吉林市.蛟河市','JLSJLSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220282,'220282','吉林省.吉林市.桦甸市','JLSJLSZDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220283,'220283','吉林省.吉林市.舒兰市','JLSJLSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220284,'220284','吉林省.吉林市.磐石市','JLSJLSPSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220300,'220300','吉林省.四平市','JLSSPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220302,'220302','吉林省.四平市.铁西区','JLSSPSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220303,'220303','吉林省.四平市.铁东区','JLSSPSTDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220322,'220322','吉林省.四平市.梨树县','JLSSPSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220323,'220323','吉林省.四平市.伊通满族自治县','JLSSPSYTMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220381,'220381','吉林省.四平市.公主岭市','JLSSPSGZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220382,'220382','吉林省.四平市.双辽市','JLSSPSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220400,'220400','吉林省.辽源市','JLSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220402,'220402','吉林省.辽源市.龙山区','JLSLYSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220403,'220403','吉林省.辽源市.西安区','JLSLYSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220421,'220421','吉林省.辽源市.东丰县','JLSLYSDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220422,'220422','吉林省.辽源市.东辽县','JLSLYSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220500,'220500','吉林省.通化市','JLSTHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220502,'220502','吉林省.通化市.东昌区','JLSTHSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220503,'220503','吉林省.通化市.二道江区','JLSTHSEDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220521,'220521','吉林省.通化市.通化县','JLSTHSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220523,'220523','吉林省.通化市.辉南县','JLSTHSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220524,'220524','吉林省.通化市.柳河县','JLSTHSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220581,'220581','吉林省.通化市.梅河口市','JLSTHSMHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220582,'220582','吉林省.通化市.集安市','JLSTHSJAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220600,'220600','吉林省.白山市','JLSBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220602,'220602','吉林省.白山市.八道江区','JLSBSSBDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220605,'220605','吉林省.白山市.江源区','JLSBSSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220621,'220621','吉林省.白山市.抚松县','JLSBSSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220622,'220622','吉林省.白山市.靖宇县','JLSBSSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220623,'220623','吉林省.白山市.长白县','JLSBSSCBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220681,'220681','吉林省.白山市.临江市','JLSBSSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220700,'220700','吉林省.松原市','JLSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220702,'220702','吉林省.松原市.宁江区','JLSSYSNJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220721,'220721','吉林省.松原市.前郭尔罗斯县','JLSSYSQGELSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220722,'220722','吉林省.松原市.长岭县','JLSSYSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220723,'220723','吉林省.松原市.乾安县','JLSSYSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220724,'220724','吉林省.松原市.扶余县','JLSSYSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220800,'220800','吉林省.白城市','JLSBCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220802,'220802','吉林省.白城市.洮北区','JLSBCSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220821,'220821','吉林省.白城市.镇赉县','JLSBCSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220822,'220822','吉林省.白城市.通榆县','JLSBCSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220881,'220881','吉林省.白城市.洮南市','JLSBCSZNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,220882,'220882','吉林省.白城市.大安市','JLSBCSDAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222400,'222400','吉林省.延边朝鲜族自治州','JLSYBCXZZZZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222401,'222401','吉林省.延边朝鲜族自治州.延吉市','JLSYBCXZZZZYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222402,'222402','吉林省.延边朝鲜族自治州.图们市','JLSYBCXZZZZTMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222403,'222403','吉林省.延边朝鲜族自治州.敦化市','JLSYBCXZZZZDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222404,'222404','吉林省.延边朝鲜族自治州.珲春市','JLSYBCXZZZZZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222405,'222405','吉林省.延边朝鲜族自治州.龙井市','JLSYBCXZZZZLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222406,'222406','吉林省.延边朝鲜族自治州.和龙市','JLSYBCXZZZZHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222424,'222424','吉林省.延边朝鲜族自治州.汪清县','JLSYBCXZZZZWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,222426,'222426','吉林省.延边朝鲜族自治州.安图县','JLSYBCXZZZZATX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230000,'230000','黑龙江省','HLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230100,'230100','黑龙江省.哈尔滨市','HLJSHEBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230102,'230102','黑龙江省.哈尔滨市.道里区','HLJSHEBSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230103,'230103','黑龙江省.哈尔滨市.南岗区','HLJSHEBSNGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230104,'230104','黑龙江省.哈尔滨市.道外区','HLJSHEBSDWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230108,'230108','黑龙江省.哈尔滨市.平房区','HLJSHEBSPFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230109,'230109','黑龙江省.哈尔滨市.松北区','HLJSHEBSSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230110,'230110','黑龙江省.哈尔滨市.香坊区','HLJSHEBSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230111,'230111','黑龙江省.哈尔滨市.呼兰区','HLJSHEBSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230112,'230112','黑龙江省.哈尔滨市.阿城区','HLJSHEBSACQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230123,'230123','黑龙江省.哈尔滨市.依兰县','HLJSHEBSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230124,'230124','黑龙江省.哈尔滨市.方正县','HLJSHEBSFZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230125,'230125','黑龙江省.哈尔滨市.宾县','HLJSHEBSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230126,'230126','黑龙江省.哈尔滨市.巴彦县','HLJSHEBSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230127,'230127','黑龙江省.哈尔滨市.木兰县','HLJSHEBSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230128,'230128','黑龙江省.哈尔滨市.通河县','HLJSHEBSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230129,'230129','黑龙江省.哈尔滨市.延寿县','HLJSHEBSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230182,'230182','黑龙江省.哈尔滨市.双城市','HLJSHEBSSCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230183,'230183','黑龙江省.哈尔滨市.尚志市','HLJSHEBSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230184,'230184','黑龙江省.哈尔滨市.五常市','HLJSHEBSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230200,'230200','黑龙江省.齐齐哈尔市','HLJSQQHES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230202,'230202','黑龙江省.齐齐哈尔市.龙沙区','HLJSQQHESLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230203,'230203','黑龙江省.齐齐哈尔市.建华区','HLJSQQHESJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230204,'230204','黑龙江省.齐齐哈尔市.铁锋区','HLJSQQHESTFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230205,'230205','黑龙江省.齐齐哈尔市.昂昂溪区','HLJSQQHESAAXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230206,'230206','黑龙江省.齐齐哈尔市.富拉尔基区','HLJSQQHESFLEJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230207,'230207','黑龙江省.齐齐哈尔市.碾子山区','HLJSQQHESNZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230208,'230208','黑龙江省.齐齐哈尔市.梅里斯区','HLJSQQHESMLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230221,'230221','黑龙江省.齐齐哈尔市.龙江县','HLJSQQHESLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230223,'230223','黑龙江省.齐齐哈尔市.依安县','HLJSQQHESYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230224,'230224','黑龙江省.齐齐哈尔市.泰来县','HLJSQQHESTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230225,'230225','黑龙江省.齐齐哈尔市.甘南县','HLJSQQHESGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230227,'230227','黑龙江省.齐齐哈尔市.富裕县','HLJSQQHESFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230229,'230229','黑龙江省.齐齐哈尔市.克山县','HLJSQQHESKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230230,'230230','黑龙江省.齐齐哈尔市.克东县','HLJSQQHESKDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230231,'230231','黑龙江省.齐齐哈尔市.拜泉县','HLJSQQHESBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230281,'230281','黑龙江省.齐齐哈尔市.讷河市','HLJSQQHESZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230300,'230300','黑龙江省.鸡西市','HLJSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230302,'230302','黑龙江省.鸡西市.鸡冠区','HLJSJXSJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230303,'230303','黑龙江省.鸡西市.恒山区','HLJSJXSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230304,'230304','黑龙江省.鸡西市.滴道区','HLJSJXSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230305,'230305','黑龙江省.鸡西市.梨树区','HLJSJXSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230306,'230306','黑龙江省.鸡西市.城子河区','HLJSJXSCZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230307,'230307','黑龙江省.鸡西市.麻山区','HLJSJXSMSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230321,'230321','黑龙江省.鸡西市.鸡东县','HLJSJXSJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230381,'230381','黑龙江省.鸡西市.虎林市','HLJSJXSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230382,'230382','黑龙江省.鸡西市.密山市','HLJSJXSMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230400,'230400','黑龙江省.鹤岗市','HLJSHGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230402,'230402','黑龙江省.鹤岗市.向阳区','HLJSHGSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230403,'230403','黑龙江省.鹤岗市.工农区','HLJSHGSGNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230404,'230404','黑龙江省.鹤岗市.南山区','HLJSHGSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230405,'230405','黑龙江省.鹤岗市.兴安区','HLJSHGSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230406,'230406','黑龙江省.鹤岗市.东山区','HLJSHGSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230407,'230407','黑龙江省.鹤岗市.兴山区','HLJSHGSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230421,'230421','黑龙江省.鹤岗市.萝北县','HLJSHGSLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230422,'230422','黑龙江省.鹤岗市.绥滨县','HLJSHGSSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230500,'230500','黑龙江省.双鸭山市','HLJSSYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230502,'230502','黑龙江省.双鸭山市.尖山区','HLJSSYSSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230503,'230503','黑龙江省.双鸭山市.岭东区','HLJSSYSSLDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230505,'230505','黑龙江省.双鸭山市.四方台区','HLJSSYSSSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230506,'230506','黑龙江省.双鸭山市.宝山区','HLJSSYSSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230521,'230521','黑龙江省.双鸭山市.集贤县','HLJSSYSSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230522,'230522','黑龙江省.双鸭山市.友谊县','HLJSSYSSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230523,'230523','黑龙江省.双鸭山市.宝清县','HLJSSYSSBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230524,'230524','黑龙江省.双鸭山市.饶河县','HLJSSYSSRHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230600,'230600','黑龙江省.大庆市','HLJSDQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230602,'230602','黑龙江省.大庆市.萨尔图区','HLJSDQSSETQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230603,'230603','黑龙江省.大庆市.龙凤区','HLJSDQSLFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230604,'230604','黑龙江省.大庆市.让胡路区','HLJSDQSRHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230605,'230605','黑龙江省.大庆市.红岗区','HLJSDQSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230606,'230606','黑龙江省.大庆市.大同区','HLJSDQSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230621,'230621','黑龙江省.大庆市.肇州县','HLJSDQSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230622,'230622','黑龙江省.大庆市.肇源县','HLJSDQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230623,'230623','黑龙江省.大庆市.林甸县','HLJSDQSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230624,'230624','黑龙江省.大庆市.杜尔伯特县','HLJSDQSDEBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230700,'230700','黑龙江省.伊春市','HLJSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230702,'230702','黑龙江省.伊春市.伊春区','HLJSYCSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230703,'230703','黑龙江省.伊春市.南岔区','HLJSYCSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230704,'230704','黑龙江省.伊春市.友好区','HLJSYCSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230705,'230705','黑龙江省.伊春市.西林区','HLJSYCSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230706,'230706','黑龙江省.伊春市.翠峦区','HLJSYCSCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230707,'230707','黑龙江省.伊春市.新青区','HLJSYCSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230708,'230708','黑龙江省.伊春市.美溪区','HLJSYCSMXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230709,'230709','黑龙江省.伊春市.金山屯区','HLJSYCSJSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230710,'230710','黑龙江省.伊春市.五营区','HLJSYCSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230711,'230711','黑龙江省.伊春市.乌马河区','HLJSYCSWMHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230712,'230712','黑龙江省.伊春市.汤旺河区','HLJSYCSTWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230713,'230713','黑龙江省.伊春市.带岭区','HLJSYCSDLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230714,'230714','黑龙江省.伊春市.乌伊岭区','HLJSYCSWYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230715,'230715','黑龙江省.伊春市.红星区','HLJSYCSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230716,'230716','黑龙江省.伊春市.上甘岭区','HLJSYCSSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230722,'230722','黑龙江省.伊春市.嘉荫县','HLJSYCSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230781,'230781','黑龙江省.伊春市.铁力市','HLJSYCSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230800,'230800','黑龙江省.佳木斯市','HLJSJMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230803,'230803','黑龙江省.佳木斯市.向阳区','HLJSJMSSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230804,'230804','黑龙江省.佳木斯市.前进区','HLJSJMSSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230805,'230805','黑龙江省.佳木斯市.东风区','HLJSJMSSDFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230811,'230811','黑龙江省.佳木斯市.郊区','HLJSJMSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230822,'230822','黑龙江省.佳木斯市.桦南县','HLJSJMSSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230826,'230826','黑龙江省.佳木斯市.桦川县','HLJSJMSSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230828,'230828','黑龙江省.佳木斯市.汤原县','HLJSJMSSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230833,'230833','黑龙江省.佳木斯市.抚远县','HLJSJMSSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230881,'230881','黑龙江省.佳木斯市.同江市','HLJSJMSSTJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230882,'230882','黑龙江省.佳木斯市.富锦市','HLJSJMSSFJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230900,'230900','黑龙江省.七台河市','HLJSQTHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230902,'230902','黑龙江省.七台河市.新兴区','HLJSQTHSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230903,'230903','黑龙江省.七台河市.桃山区','HLJSQTHSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230904,'230904','黑龙江省.七台河市.茄子河区','HLJSQTHSQZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,230921,'230921','黑龙江省.七台河市.勃利县','HLJSQTHSBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231000,'231000','黑龙江省.牡丹江市','HLJSMDJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231002,'231002','黑龙江省.牡丹江市.东安区','HLJSMDJSDAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231003,'231003','黑龙江省.牡丹江市.阳明区','HLJSMDJSYMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231004,'231004','黑龙江省.牡丹江市.爱民区','HLJSMDJSAMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231005,'231005','黑龙江省.牡丹江市.西安区','HLJSMDJSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231024,'231024','黑龙江省.牡丹江市.东宁县','HLJSMDJSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231025,'231025','黑龙江省.牡丹江市.林口县','HLJSMDJSLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231081,'231081','黑龙江省.牡丹江市.绥芬河市','HLJSMDJSSFHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231083,'231083','黑龙江省.牡丹江市.海林市','HLJSMDJSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231084,'231084','黑龙江省.牡丹江市.宁安市','HLJSMDJSNAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231085,'231085','黑龙江省.牡丹江市.穆棱市','HLJSMDJSMLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231100,'231100','黑龙江省.黑河市','HLJSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231102,'231102','黑龙江省.黑河市.爱辉区','HLJSHHSAHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231121,'231121','黑龙江省.黑河市.嫩江县','HLJSHHSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231123,'231123','黑龙江省.黑河市.逊克县','HLJSHHSXKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231124,'231124','黑龙江省.黑河市.孙吴县','HLJSHHSSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231181,'231181','黑龙江省.黑河市.北安市','HLJSHHSBAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231182,'231182','黑龙江省.黑河市.五大连池市','HLJSHHSWDLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231200,'231200','黑龙江省.绥化市','HLJSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231202,'231202','黑龙江省.绥化市.北林区','HLJSSHSBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231221,'231221','黑龙江省.绥化市.望奎县','HLJSSHSWKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231222,'231222','黑龙江省.绥化市.兰西县','HLJSSHSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231223,'231223','黑龙江省.绥化市.青冈县','HLJSSHSQGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231224,'231224','黑龙江省.绥化市.庆安县','HLJSSHSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231225,'231225','黑龙江省.绥化市.明水县','HLJSSHSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231226,'231226','黑龙江省.绥化市.绥棱县','HLJSSHSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231281,'231281','黑龙江省.绥化市.安达市','HLJSSHSADS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231282,'231282','黑龙江省.绥化市.肇东市','HLJSSHSZDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,231283,'231283','黑龙江省.绥化市.海伦市','HLJSSHSHLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232700,'232700','黑龙江省.大兴安岭地区','HLJSDXALDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232721,'232721','黑龙江省.大兴安岭地区.呼玛县','HLJSDXALDQHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232722,'232722','黑龙江省.大兴安岭地区.塔河县','HLJSDXALDQTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,232723,'232723','黑龙江省.大兴安岭地区.漠河县','HLJSDXALDQMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310000,'310000','上海市','SHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310101,'310101','上海市.黄浦区','SHSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310103,'310103','上海市.卢湾区','SHSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310104,'310104','上海市.徐汇区','SHSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310105,'310105','上海市.长宁区','SHSCNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310106,'310106','上海市.静安区','SHSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310107,'310107','上海市.普陀区','SHSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310108,'310108','上海市.闸北区','SHSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310109,'310109','上海市.虹口区','SHSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310110,'310110','上海市.杨浦区','SHSYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310112,'310112','上海市.闵行区','SHSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310113,'310113','上海市.宝山区','SHSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310114,'310114','上海市.嘉定区','SHSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310115,'310115','上海市.浦东新区','SHSPDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310116,'310116','上海市.金山区','SHSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310117,'310117','上海市.松江区','SHSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310118,'310118','上海市.青浦区','SHSQPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310120,'310120','上海市.奉贤区','SHSFXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,310230,'310230','上海市.崇明县','SHSCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320000,'320000','江苏省','JSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320100,'320100','江苏省.南京市','JSSNJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320102,'320102','江苏省.南京市.玄武区','JSSNJSXWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320103,'320103','江苏省.南京市.白下区','JSSNJSBXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320104,'320104','江苏省.南京市.秦淮区','JSSNJSQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320105,'320105','江苏省.南京市.建邺区','JSSNJSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320106,'320106','江苏省.南京市.鼓楼区','JSSNJSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320107,'320107','江苏省.南京市.下关区','JSSNJSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320111,'320111','江苏省.南京市.浦口区','JSSNJSPKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320113,'320113','江苏省.南京市.栖霞区','JSSNJSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320114,'320114','江苏省.南京市.雨花台区','JSSNJSYHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320115,'320115','江苏省.南京市.江宁区','JSSNJSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320116,'320116','江苏省.南京市.六合区','JSSNJSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320124,'320124','江苏省.南京市.溧水县','JSSNJSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320125,'320125','江苏省.南京市.高淳县','JSSNJSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320200,'320200','江苏省.无锡市','JSSWXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320202,'320202','江苏省.无锡市.崇安区','JSSWXSCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320203,'320203','江苏省.无锡市.南长区','JSSWXSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320204,'320204','江苏省.无锡市.北塘区','JSSWXSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320205,'320205','江苏省.无锡市.锡山区','JSSWXSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320206,'320206','江苏省.无锡市.惠山区','JSSWXSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320211,'320211','江苏省.无锡市.滨湖区','JSSWXSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320281,'320281','江苏省.无锡市.江阴市','JSSWXSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320282,'320282','江苏省.无锡市.宜兴市','JSSWXSYXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320300,'320300','江苏省.徐州市','JSSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320302,'320302','江苏省.徐州市.鼓楼区','JSSXZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320303,'320303','江苏省.徐州市.云龙区','JSSXZSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320304,'320304','江苏省.徐州市.九里区','JSSXZSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320305,'320305','江苏省.徐州市.贾汪区','JSSXZSJWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320311,'320311','江苏省.徐州市.泉山区','JSSXZSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320321,'320321','江苏省.徐州市.丰县','JSSXZSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320322,'320322','江苏省.徐州市.沛县','JSSXZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320323,'320323','江苏省.徐州市.铜山县','JSSXZSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320324,'320324','江苏省.徐州市.睢宁县','JSSXZSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320381,'320381','江苏省.徐州市.新沂市','JSSXZSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320382,'320382','江苏省.徐州市.邳州市','JSSXZSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320400,'320400','江苏省.常州市','JSSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320402,'320402','江苏省.常州市.天宁区','JSSCZSTNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320404,'320404','江苏省.常州市.钟楼区','JSSCZSZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320405,'320405','江苏省.常州市.戚墅堰区','JSSCZSQSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320411,'320411','江苏省.常州市.新北区','JSSCZSXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320412,'320412','江苏省.常州市.武进区','JSSCZSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320481,'320481','江苏省.常州市.溧阳市','JSSCZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320482,'320482','江苏省.常州市.金坛市','JSSCZSJTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320500,'320500','江苏省.苏州市','JSSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320502,'320502','江苏省.苏州市.沧浪区','JSSSZSCLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320503,'320503','江苏省.苏州市.平江区','JSSSZSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320504,'320504','江苏省.苏州市.金阊区','JSSSZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320505,'320505','江苏省.苏州市.虎丘区','JSSSZSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320506,'320506','江苏省.苏州市.吴中区','JSSSZSWZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320507,'320507','江苏省.苏州市.相城区','JSSSZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320581,'320581','江苏省.苏州市.常熟市','JSSSZSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320582,'320582','江苏省.苏州市.张家港市','JSSSZSZJGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320583,'320583','江苏省.苏州市.昆山市','JSSSZSKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320584,'320584','江苏省.苏州市.吴江市','JSSSZSWJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320585,'320585','江苏省.苏州市.太仓市','JSSSZSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320600,'320600','江苏省.南通市','JSSNTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320602,'320602','江苏省.南通市.崇川区','JSSNTSCCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320611,'320611','江苏省.南通市.港闸区','JSSNTSGZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320612,'320612','江苏省.南通市.通州区','JSSNTSTZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320621,'320621','江苏省.南通市.海安县','JSSNTSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320623,'320623','江苏省.南通市.如东县','JSSNTSRDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320681,'320681','江苏省.南通市.启东市','JSSNTSQDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320682,'320682','江苏省.南通市.如皋市','JSSNTSRGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320684,'320684','江苏省.南通市.海门市','JSSNTSHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320700,'320700','江苏省.连云港市','JSSLYGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320703,'320703','江苏省.连云港市.连云区','JSSLYGSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320705,'320705','江苏省.连云港市.新浦区','JSSLYGSXPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320706,'320706','江苏省.连云港市.海州区','JSSLYGSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320721,'320721','江苏省.连云港市.赣榆县','JSSLYGSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320722,'320722','江苏省.连云港市.东海县','JSSLYGSDHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320723,'320723','江苏省.连云港市.灌云县','JSSLYGSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320724,'320724','江苏省.连云港市.灌南县','JSSLYGSGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320800,'320800','江苏省.淮安市','JSSHAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320802,'320802','江苏省.淮安市.清河区','JSSHASQHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320803,'320803','江苏省.淮安市.楚州区','JSSHASCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320804,'320804','江苏省.淮安市.淮阴区','JSSHASHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320811,'320811','江苏省.淮安市.清浦区','JSSHASQPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320826,'320826','江苏省.淮安市.涟水县','JSSHASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320829,'320829','江苏省.淮安市.洪泽县','JSSHASHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320830,'320830','江苏省.淮安市.盱眙县','JSSHASZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320831,'320831','江苏省.淮安市.金湖县','JSSHASJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320900,'320900','江苏省.盐城市','JSSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320902,'320902','江苏省.盐城市.亭湖区','JSSYCSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320903,'320903','江苏省.盐城市.盐都区','JSSYCSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320921,'320921','江苏省.盐城市.响水县','JSSYCSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320922,'320922','江苏省.盐城市.滨海县','JSSYCSBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320923,'320923','江苏省.盐城市.阜宁县','JSSYCSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320924,'320924','江苏省.盐城市.射阳县','JSSYCSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320925,'320925','江苏省.盐城市.建湖县','JSSYCSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320981,'320981','江苏省.盐城市.东台市','JSSYCSDTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,320982,'320982','江苏省.盐城市.大丰市','JSSYCSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321000,'321000','江苏省.扬州市','JSSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321002,'321002','江苏省.扬州市.广陵区','JSSYZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321003,'321003','江苏省.扬州市.邗江区','JSSYZSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321011,'321011','江苏省.扬州市.维扬区','JSSYZSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321023,'321023','江苏省.扬州市.宝应县','JSSYZSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321081,'321081','江苏省.扬州市.仪征市','JSSYZSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321084,'321084','江苏省.扬州市.高邮市','JSSYZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321088,'321088','江苏省.扬州市.江都市','JSSYZSJDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321100,'321100','江苏省.镇江市','JSSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321102,'321102','江苏省.镇江市.京口区','JSSZJSJKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321111,'321111','江苏省.镇江市.润州区','JSSZJSRZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321112,'321112','江苏省.镇江市.丹徒区','JSSZJSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321181,'321181','江苏省.镇江市.丹阳市','JSSZJSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321182,'321182','江苏省.镇江市.扬中市','JSSZJSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321183,'321183','江苏省.镇江市.句容市','JSSZJSJRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321200,'321200','江苏省.泰州市','JSSTZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321202,'321202','江苏省.泰州市.海陵区','JSSTZSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321203,'321203','江苏省.泰州市.高港区','JSSTZSGGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321281,'321281','江苏省.泰州市.兴化市','JSSTZSXHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321282,'321282','江苏省.泰州市.靖江市','JSSTZSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321283,'321283','江苏省.泰州市.泰兴市','JSSTZSTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321284,'321284','江苏省.泰州市.姜堰市','JSSTZSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321300,'321300','江苏省.宿迁市','JSSSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321302,'321302','江苏省.宿迁市.宿城区','JSSSQSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321311,'321311','江苏省.宿迁市.宿豫区','JSSSQSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321322,'321322','江苏省.宿迁市.沭阳县','JSSSQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321323,'321323','江苏省.宿迁市.泗阳县','JSSSQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,321324,'321324','江苏省.宿迁市.泗洪县','JSSSQSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330000,'330000','浙江省','ZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330100,'330100','浙江省.杭州市','ZJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330102,'330102','浙江省.杭州市.上城区','ZJSHZSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330103,'330103','浙江省.杭州市.下城区','ZJSHZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330104,'330104','浙江省.杭州市.江干区','ZJSHZSJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330105,'330105','浙江省.杭州市.拱墅区','ZJSHZSGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330106,'330106','浙江省.杭州市.西湖区','ZJSHZSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330108,'330108','浙江省.杭州市.滨江区','ZJSHZSBJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330109,'330109','浙江省.杭州市.萧山区','ZJSHZSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330110,'330110','浙江省.杭州市.余杭区','ZJSHZSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330122,'330122','浙江省.杭州市.桐庐县','ZJSHZSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330127,'330127','浙江省.杭州市.淳安县','ZJSHZSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330182,'330182','浙江省.杭州市.建德市','ZJSHZSJDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330183,'330183','浙江省.杭州市.富阳市','ZJSHZSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330185,'330185','浙江省.杭州市.临安市','ZJSHZSLAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330200,'330200','浙江省.宁波市','ZJSNBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330203,'330203','浙江省.宁波市.海曙区','ZJSNBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330204,'330204','浙江省.宁波市.江东区','ZJSNBSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330205,'330205','浙江省.宁波市.江北区','ZJSNBSJBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330206,'330206','浙江省.宁波市.北仑区','ZJSNBSBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330211,'330211','浙江省.宁波市.镇海区','ZJSNBSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330212,'330212','浙江省.宁波市.鄞州区','ZJSNBSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330225,'330225','浙江省.宁波市.象山县','ZJSNBSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330226,'330226','浙江省.宁波市.宁海县','ZJSNBSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330281,'330281','浙江省.宁波市.余姚市','ZJSNBSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330282,'330282','浙江省.宁波市.慈溪市','ZJSNBSCXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330283,'330283','浙江省.宁波市.奉化市','ZJSNBSFHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330300,'330300','浙江省.温州市','ZJSWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330302,'330302','浙江省.温州市.鹿城区','ZJSWZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330303,'330303','浙江省.温州市.龙湾区','ZJSWZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330304,'330304','浙江省.温州市.瓯海区','ZJSWZSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330322,'330322','浙江省.温州市.洞头县','ZJSWZSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330324,'330324','浙江省.温州市.永嘉县','ZJSWZSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330326,'330326','浙江省.温州市.平阳县','ZJSWZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330327,'330327','浙江省.温州市.苍南县','ZJSWZSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330328,'330328','浙江省.温州市.文成县','ZJSWZSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330329,'330329','浙江省.温州市.泰顺县','ZJSWZSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330381,'330381','浙江省.温州市.瑞安市','ZJSWZSRAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330382,'330382','浙江省.温州市.乐清市','ZJSWZSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330400,'330400','浙江省.嘉兴市','ZJSJXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330402,'330402','浙江省.嘉兴市.南湖区','ZJSJXSNHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330411,'330411','浙江省.嘉兴市.秀洲区','ZJSJXSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330421,'330421','浙江省.嘉兴市.嘉善县','ZJSJXSJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330424,'330424','浙江省.嘉兴市.海盐县','ZJSJXSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330481,'330481','浙江省.嘉兴市.海宁市','ZJSJXSHNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330482,'330482','浙江省.嘉兴市.平湖市','ZJSJXSPHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330483,'330483','浙江省.嘉兴市.桐乡市','ZJSJXSTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330500,'330500','浙江省.湖州市','ZJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330502,'330502','浙江省.湖州市.吴兴区','ZJSHZSWXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330503,'330503','浙江省.湖州市.南浔区','ZJSHZSNZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330521,'330521','浙江省.湖州市.德清县','ZJSHZSDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330522,'330522','浙江省.湖州市.长兴县','ZJSHZSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330523,'330523','浙江省.湖州市.安吉县','ZJSHZSAJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330600,'330600','浙江省.绍兴市','ZJSSXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330602,'330602','浙江省.绍兴市.越城区','ZJSSXSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330621,'330621','浙江省.绍兴市.绍兴县','ZJSSXSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330624,'330624','浙江省.绍兴市.新昌县','ZJSSXSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330681,'330681','浙江省.绍兴市.诸暨市','ZJSSXSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330682,'330682','浙江省.绍兴市.上虞市','ZJSSXSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330683,'330683','浙江省.绍兴市.嵊州市','ZJSSXSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330700,'330700','浙江省.金华市','ZJSJHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330702,'330702','浙江省.金华市.婺城区','ZJSJHSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330703,'330703','浙江省.金华市.金东区','ZJSJHSJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330723,'330723','浙江省.金华市.武义县','ZJSJHSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330726,'330726','浙江省.金华市.浦江县','ZJSJHSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330727,'330727','浙江省.金华市.磐安县','ZJSJHSPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330781,'330781','浙江省.金华市.兰溪市','ZJSJHSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330782,'330782','浙江省.金华市.义乌市','ZJSJHSYWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330783,'330783','浙江省.金华市.东阳市','ZJSJHSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330784,'330784','浙江省.金华市.永康市','ZJSJHSYKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330800,'330800','浙江省.衢州市','ZJSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330802,'330802','浙江省.衢州市.柯城区','ZJSZZSKCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330803,'330803','浙江省.衢州市.衢江区','ZJSZZSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330822,'330822','浙江省.衢州市.常山县','ZJSZZSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330824,'330824','浙江省.衢州市.开化县','ZJSZZSKHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330825,'330825','浙江省.衢州市.龙游县','ZJSZZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330881,'330881','浙江省.衢州市.江山市','ZJSZZSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330900,'330900','浙江省.舟山市','ZJSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330902,'330902','浙江省.舟山市.定海区','ZJSZSSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330903,'330903','浙江省.舟山市.普陀区','ZJSZSSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330921,'330921','浙江省.舟山市.岱山县','ZJSZSSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,330922,'330922','浙江省.舟山市.嵊泗县','ZJSZSSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331000,'331000','浙江省.台州市','ZJSTZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331002,'331002','浙江省.台州市.椒江区','ZJSTZSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331003,'331003','浙江省.台州市.黄岩区','ZJSTZSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331004,'331004','浙江省.台州市.路桥区','ZJSTZSLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331021,'331021','浙江省.台州市.玉环县','ZJSTZSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331022,'331022','浙江省.台州市.三门县','ZJSTZSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331023,'331023','浙江省.台州市.天台县','ZJSTZSTTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331024,'331024','浙江省.台州市.仙居县','ZJSTZSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331081,'331081','浙江省.台州市.温岭市','ZJSTZSWLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331082,'331082','浙江省.台州市.临海市','ZJSTZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331100,'331100','浙江省.丽水市','ZJSLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331102,'331102','浙江省.丽水市.莲都区','ZJSLSSLDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331121,'331121','浙江省.丽水市.青田县','ZJSLSSQTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331122,'331122','浙江省.丽水市.缙云县','ZJSLSSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331123,'331123','浙江省.丽水市.遂昌县','ZJSLSSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331124,'331124','浙江省.丽水市.松阳县','ZJSLSSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331125,'331125','浙江省.丽水市.云和县','ZJSLSSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331126,'331126','浙江省.丽水市.庆元县','ZJSLSSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331127,'331127','浙江省.丽水市.景宁畲族自治县','ZJSLSSJNZZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,331181,'331181','浙江省.丽水市.龙泉市','ZJSLSSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340000,'340000','安徽省','AHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340100,'340100','安徽省.合肥市','AHSHFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340102,'340102','安徽省.合肥市.瑶海区','AHSHFSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340103,'340103','安徽省.合肥市.庐阳区','AHSHFSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340104,'340104','安徽省.合肥市.蜀山区','AHSHFSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340111,'340111','安徽省.合肥市.包河区','AHSHFSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340121,'340121','安徽省.合肥市.长丰县','AHSHFSCFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340122,'340122','安徽省.合肥市.肥东县','AHSHFSFDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340123,'340123','安徽省.合肥市.肥西县','AHSHFSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340200,'340200','安徽省.芜湖市','AHSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340202,'340202','安徽省.芜湖市.镜湖区','AHSWHSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340203,'340203','安徽省.芜湖市.弋江区','AHSWHSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340207,'340207','安徽省.芜湖市.鸠江区','AHSWHSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340208,'340208','安徽省.芜湖市.三山区','AHSWHSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340221,'340221','安徽省.芜湖市.芜湖县','AHSWHSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340222,'340222','安徽省.芜湖市.繁昌县','AHSWHSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340223,'340223','安徽省.芜湖市.南陵县','AHSWHSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340300,'340300','安徽省.蚌埠市','AHSBBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340302,'340302','安徽省.蚌埠市.龙子湖区','AHSBBSLZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340303,'340303','安徽省.蚌埠市.蚌山区','AHSBBSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340304,'340304','安徽省.蚌埠市.禹会区','AHSBBSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340311,'340311','安徽省.蚌埠市.淮上区','AHSBBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340321,'340321','安徽省.蚌埠市.怀远县','AHSBBSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340322,'340322','安徽省.蚌埠市.五河县','AHSBBSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340323,'340323','安徽省.蚌埠市.固镇县','AHSBBSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340400,'340400','安徽省.淮南市','AHSHNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340402,'340402','安徽省.淮南市.大通区','AHSHNSDTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340403,'340403','安徽省.淮南市.田家庵区','AHSHNSTJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340404,'340404','安徽省.淮南市.谢家集区','AHSHNSXJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340405,'340405','安徽省.淮南市.八公山区','AHSHNSBGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340406,'340406','安徽省.淮南市.潘集区','AHSHNSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340421,'340421','安徽省.淮南市.凤台县','AHSHNSFTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340500,'340500','安徽省.马鞍山市','AHSMASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340502,'340502','安徽省.马鞍山市.金家庄区','AHSMASSJJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340503,'340503','安徽省.马鞍山市.花山区','AHSMASSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340504,'340504','安徽省.马鞍山市.雨山区','AHSMASSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340521,'340521','安徽省.马鞍山市.当涂县','AHSMASSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340600,'340600','安徽省.淮北市','AHSHBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340602,'340602','安徽省.淮北市.杜集区','AHSHBSDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340603,'340603','安徽省.淮北市.相山区','AHSHBSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340604,'340604','安徽省.淮北市.烈山区','AHSHBSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340621,'340621','安徽省.淮北市.濉溪县','AHSHBSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340700,'340700','安徽省.铜陵市','AHSTLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340702,'340702','安徽省.铜陵市.铜官山区','AHSTLSTGSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340703,'340703','安徽省.铜陵市.狮子山区','AHSTLSSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340711,'340711','安徽省.铜陵市.郊区','AHSTLSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340721,'340721','安徽省.铜陵市.铜陵县','AHSTLSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340800,'340800','安徽省.安庆市','AHSAQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340802,'340802','安徽省.安庆市.迎江区','AHSAQSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340803,'340803','安徽省.安庆市.大观区','AHSAQSDGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340811,'340811','安徽省.安庆市.宜秀区','AHSAQSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340822,'340822','安徽省.安庆市.怀宁县','AHSAQSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340823,'340823','安徽省.安庆市.枞阳县','AHSAQSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340824,'340824','安徽省.安庆市.潜山县','AHSAQSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340825,'340825','安徽省.安庆市.太湖县','AHSAQSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340826,'340826','安徽省.安庆市.宿松县','AHSAQSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340827,'340827','安徽省.安庆市.望江县','AHSAQSWJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340828,'340828','安徽省.安庆市.岳西县','AHSAQSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,340881,'340881','安徽省.安庆市.桐城市','AHSAQSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341000,'341000','安徽省.黄山市','AHSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341002,'341002','安徽省.黄山市.屯溪区','AHSHSSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341003,'341003','安徽省.黄山市.黄山区','AHSHSSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341004,'341004','安徽省.黄山市.徽州区','AHSHSSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341021,'341021','安徽省.黄山市.歙县','AHSHSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341022,'341022','安徽省.黄山市.休宁县','AHSHSSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341023,'341023','安徽省.黄山市.黟县','AHSHSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341024,'341024','安徽省.黄山市.祁门县','AHSHSSQMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341100,'341100','安徽省.滁州市','AHSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341102,'341102','安徽省.滁州市.琅琊区','AHSCZSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341103,'341103','安徽省.滁州市.南谯区','AHSCZSNZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341122,'341122','安徽省.滁州市.来安县','AHSCZSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341124,'341124','安徽省.滁州市.全椒县','AHSCZSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341125,'341125','安徽省.滁州市.定远县','AHSCZSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341126,'341126','安徽省.滁州市.凤阳县','AHSCZSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341181,'341181','安徽省.滁州市.天长市','AHSCZSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341182,'341182','安徽省.滁州市.明光市','AHSCZSMGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341200,'341200','安徽省.阜阳市','AHSFYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341202,'341202','安徽省.阜阳市.颍州区','AHSFYSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341203,'341203','安徽省.阜阳市.颍东区','AHSFYSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341204,'341204','安徽省.阜阳市.颍泉区','AHSFYSZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341221,'341221','安徽省.阜阳市.临泉县','AHSFYSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341222,'341222','安徽省.阜阳市.太和县','AHSFYSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341225,'341225','安徽省.阜阳市.阜南县','AHSFYSFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341226,'341226','安徽省.阜阳市.颍上县','AHSFYSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341282,'341282','安徽省.阜阳市.界首市','AHSFYSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341300,'341300','安徽省.宿州市','AHSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341302,'341302','安徽省.宿州市.埇桥区','AHSSZSYQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341321,'341321','安徽省.宿州市.砀山县','AHSSZSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341322,'341322','安徽省.宿州市.萧县','AHSSZSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341323,'341323','安徽省.宿州市.灵璧县','AHSSZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341324,'341324','安徽省.宿州市.泗县','AHSSZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341400,'341400','安徽省.巢湖市','AHSCHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341402,'341402','安徽省.巢湖市.居巢区','AHSCHSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341421,'341421','安徽省.巢湖市.庐江县','AHSCHSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341422,'341422','安徽省.巢湖市.无为县','AHSCHSWWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341423,'341423','安徽省.巢湖市.含山县','AHSCHSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341424,'341424','安徽省.巢湖市.和县','AHSCHSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341500,'341500','安徽省.六安市','AHSLAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341502,'341502','安徽省.六安市.金安区','AHSLASJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341503,'341503','安徽省.六安市.裕安区','AHSLASYAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341521,'341521','安徽省.六安市.寿县','AHSLASSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341522,'341522','安徽省.六安市.霍邱县','AHSLASHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341523,'341523','安徽省.六安市.舒城县','AHSLASSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341524,'341524','安徽省.六安市.金寨县','AHSLASJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341525,'341525','安徽省.六安市.霍山县','AHSLASHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341600,'341600','安徽省.亳州市','AHSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341602,'341602','安徽省.亳州市.谯城区','AHSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341621,'341621','安徽省.亳州市.涡阳县','AHSZZSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341622,'341622','安徽省.亳州市.蒙城县','AHSZZSMCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341623,'341623','安徽省.亳州市.利辛县','AHSZZSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341700,'341700','安徽省.池州市','AHSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341702,'341702','安徽省.池州市.贵池区','AHSCZSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341721,'341721','安徽省.池州市.东至县','AHSCZSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341722,'341722','安徽省.池州市.石台县','AHSCZSSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341723,'341723','安徽省.池州市.青阳县','AHSCZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341800,'341800','安徽省.宣城市','AHSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341802,'341802','安徽省.宣城市.宣州区','AHSXCSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341821,'341821','安徽省.宣城市.郎溪县','AHSXCSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341822,'341822','安徽省.宣城市.广德县','AHSXCSGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341823,'341823','安徽省.宣城市.泾县','AHSXCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341824,'341824','安徽省.宣城市.绩溪县','AHSXCSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341825,'341825','安徽省.宣城市.旌德县','AHSXCSZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,341881,'341881','安徽省.宣城市.宁国市','AHSXCSNGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350000,'350000','福建省','FJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350100,'350100','福建省.福州市','FJSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350102,'350102','福建省.福州市.鼓楼区','FJSFZSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350103,'350103','福建省.福州市.台江区','FJSFZSTJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350104,'350104','福建省.福州市.仓山区','FJSFZSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350105,'350105','福建省.福州市.马尾区','FJSFZSMWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350111,'350111','福建省.福州市.晋安区','FJSFZSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350121,'350121','福建省.福州市.闽侯县','FJSFZSMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350122,'350122','福建省.福州市.连江县','FJSFZSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350123,'350123','福建省.福州市.罗源县','FJSFZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350124,'350124','福建省.福州市.闽清县','FJSFZSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350125,'350125','福建省.福州市.永泰县','FJSFZSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350128,'350128','福建省.福州市.平潭县','FJSFZSPTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350181,'350181','福建省.福州市.福清市','FJSFZSFQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350182,'350182','福建省.福州市.长乐市','FJSFZSCLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350200,'350200','福建省.厦门市','FJSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350203,'350203','福建省.厦门市.思明区','FJSXMSSMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350205,'350205','福建省.厦门市.海沧区','FJSXMSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350206,'350206','福建省.厦门市.湖里区','FJSXMSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350211,'350211','福建省.厦门市.集美区','FJSXMSJMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350212,'350212','福建省.厦门市.同安区','FJSXMSTAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350213,'350213','福建省.厦门市.翔安区','FJSXMSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350300,'350300','福建省.莆田市','FJSPTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350302,'350302','福建省.莆田市.城厢区','FJSPTSCXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350303,'350303','福建省.莆田市.涵江区','FJSPTSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350304,'350304','福建省.莆田市.荔城区','FJSPTSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350305,'350305','福建省.莆田市.秀屿区','FJSPTSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350322,'350322','福建省.莆田市.仙游县','FJSPTSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350400,'350400','福建省.三明市','FJSSMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350402,'350402','福建省.三明市.梅列区','FJSSMSMLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350403,'350403','福建省.三明市.三元区','FJSSMSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350421,'350421','福建省.三明市.明溪县','FJSSMSMXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350423,'350423','福建省.三明市.清流县','FJSSMSQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350424,'350424','福建省.三明市.宁化县','FJSSMSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350425,'350425','福建省.三明市.大田县','FJSSMSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350426,'350426','福建省.三明市.尤溪县','FJSSMSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350427,'350427','福建省.三明市.沙县','FJSSMSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350428,'350428','福建省.三明市.将乐县','FJSSMSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350429,'350429','福建省.三明市.泰宁县','FJSSMSTNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350430,'350430','福建省.三明市.建宁县','FJSSMSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350481,'350481','福建省.三明市.永安市','FJSSMSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350500,'350500','福建省.泉州市','FJSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350502,'350502','福建省.泉州市.鲤城区','FJSQZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350503,'350503','福建省.泉州市.丰泽区','FJSQZSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350504,'350504','福建省.泉州市.洛江区','FJSQZSLJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350505,'350505','福建省.泉州市.泉港区','FJSQZSQGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350521,'350521','福建省.泉州市.惠安县','FJSQZSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350524,'350524','福建省.泉州市.安溪县','FJSQZSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350525,'350525','福建省.泉州市.永春县','FJSQZSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350526,'350526','福建省.泉州市.德化县','FJSQZSDHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350527,'350527','福建省.泉州市.金门县','FJSQZSJMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350581,'350581','福建省.泉州市.石狮市','FJSQZSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350582,'350582','福建省.泉州市.晋江市','FJSQZSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350583,'350583','福建省.泉州市.南安市','FJSQZSNAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350600,'350600','福建省.漳州市','FJSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350602,'350602','福建省.漳州市.芗城区','FJSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350603,'350603','福建省.漳州市.龙文区','FJSZZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350622,'350622','福建省.漳州市.云霄县','FJSZZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350623,'350623','福建省.漳州市.漳浦县','FJSZZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350624,'350624','福建省.漳州市.诏安县','FJSZZSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350625,'350625','福建省.漳州市.长泰县','FJSZZSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350626,'350626','福建省.漳州市.东山县','FJSZZSDSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350627,'350627','福建省.漳州市.南靖县','FJSZZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350628,'350628','福建省.漳州市.平和县','FJSZZSPHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350629,'350629','福建省.漳州市.华安县','FJSZZSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350681,'350681','福建省.漳州市.龙海市','FJSZZSLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350700,'350700','福建省.南平市','FJSNPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350702,'350702','福建省.南平市.延平区','FJSNPSYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350721,'350721','福建省.南平市.顺昌县','FJSNPSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350722,'350722','福建省.南平市.浦城县','FJSNPSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350723,'350723','福建省.南平市.光泽县','FJSNPSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350724,'350724','福建省.南平市.松溪县','FJSNPSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350725,'350725','福建省.南平市.政和县','FJSNPSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350781,'350781','福建省.南平市.邵武市','FJSNPSSWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350782,'350782','福建省.南平市.武夷山市','FJSNPSWYSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350783,'350783','福建省.南平市.建瓯市','FJSNPSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350784,'350784','福建省.南平市.建阳市','FJSNPSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350800,'350800','福建省.龙岩市','FJSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350802,'350802','福建省.龙岩市.新罗区','FJSLYSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350821,'350821','福建省.龙岩市.长汀县','FJSLYSCTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350822,'350822','福建省.龙岩市.永定县','FJSLYSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350823,'350823','福建省.龙岩市.上杭县','FJSLYSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350824,'350824','福建省.龙岩市.武平县','FJSLYSWPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350825,'350825','福建省.龙岩市.连城县','FJSLYSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350881,'350881','福建省.龙岩市.漳平市','FJSLYSZPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350900,'350900','福建省.宁德市','FJSNDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350902,'350902','福建省.宁德市.蕉城区','FJSNDSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350921,'350921','福建省.宁德市.霞浦县','FJSNDSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350922,'350922','福建省.宁德市.古田县','FJSNDSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350923,'350923','福建省.宁德市.屏南县','FJSNDSPNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350924,'350924','福建省.宁德市.寿宁县','FJSNDSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350925,'350925','福建省.宁德市.周宁县','FJSNDSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350926,'350926','福建省.宁德市.柘荣县','FJSNDSZRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350981,'350981','福建省.宁德市.福安市','FJSNDSFAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,350982,'350982','福建省.宁德市.福鼎市','FJSNDSFDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360000,'360000','江西省','JXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360100,'360100','江西省.南昌市','JXSNCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360102,'360102','江西省.南昌市.东湖区','JXSNCSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360103,'360103','江西省.南昌市.西湖区','JXSNCSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360104,'360104','江西省.南昌市.青云谱区','JXSNCSQYPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360105,'360105','江西省.南昌市.湾里区','JXSNCSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360111,'360111','江西省.南昌市.青山湖区','JXSNCSQSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360121,'360121','江西省.南昌市.南昌县','JXSNCSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360122,'360122','江西省.南昌市.新建县','JXSNCSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360123,'360123','江西省.南昌市.安义县','JXSNCSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360124,'360124','江西省.南昌市.进贤县','JXSNCSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360200,'360200','江西省.景德镇市','JXSJDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360202,'360202','江西省.景德镇市.昌江区','JXSJDZSCJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360203,'360203','江西省.景德镇市.珠山区','JXSJDZSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360222,'360222','江西省.景德镇市.浮梁县','JXSJDZSFLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360281,'360281','江西省.景德镇市.乐平市','JXSJDZSLPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360300,'360300','江西省.萍乡市','JXSPXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360302,'360302','江西省.萍乡市.安源区','JXSPXSAYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360313,'360313','江西省.萍乡市.湘东区','JXSPXSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360321,'360321','江西省.萍乡市.莲花县','JXSPXSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360322,'360322','江西省.萍乡市.上栗县','JXSPXSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360323,'360323','江西省.萍乡市.芦溪县','JXSPXSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360400,'360400','江西省.九江市','JXSJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360402,'360402','江西省.九江市.庐山区','JXSJJSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360403,'360403','江西省.九江市.浔阳区','JXSJJSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360421,'360421','江西省.九江市.九江县','JXSJJSJJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360423,'360423','江西省.九江市.武宁县','JXSJJSWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360424,'360424','江西省.九江市.修水县','JXSJJSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360425,'360425','江西省.九江市.永修县','JXSJJSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360426,'360426','江西省.九江市.德安县','JXSJJSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360427,'360427','江西省.九江市.星子县','JXSJJSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360428,'360428','江西省.九江市.都昌县','JXSJJSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360429,'360429','江西省.九江市.湖口县','JXSJJSHKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360430,'360430','江西省.九江市.彭泽县','JXSJJSPZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360481,'360481','江西省.九江市.瑞昌市','JXSJJSRCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360500,'360500','江西省.新余市','JXSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360502,'360502','江西省.新余市.渝水区','JXSXYSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360521,'360521','江西省.新余市.分宜县','JXSXYSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360600,'360600','江西省.鹰潭市','JXSYTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360602,'360602','江西省.鹰潭市.月湖区','JXSYTSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360622,'360622','江西省.鹰潭市.余江县','JXSYTSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360681,'360681','江西省.鹰潭市.贵溪市','JXSYTSGXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360700,'360700','江西省.赣州市','JXSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360702,'360702','江西省.赣州市.章贡区','JXSGZSZGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360721,'360721','江西省.赣州市.赣县','JXSGZSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360722,'360722','江西省.赣州市.信丰县','JXSGZSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360723,'360723','江西省.赣州市.大余县','JXSGZSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360724,'360724','江西省.赣州市.上犹县','JXSGZSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360725,'360725','江西省.赣州市.崇义县','JXSGZSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360726,'360726','江西省.赣州市.安远县','JXSGZSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360727,'360727','江西省.赣州市.龙南县','JXSGZSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360728,'360728','江西省.赣州市.定南县','JXSGZSDNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360729,'360729','江西省.赣州市.全南县','JXSGZSQNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360730,'360730','江西省.赣州市.宁都县','JXSGZSNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360731,'360731','江西省.赣州市.于都县','JXSGZSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360732,'360732','江西省.赣州市.兴国县','JXSGZSXGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360733,'360733','江西省.赣州市.会昌县','JXSGZSHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360734,'360734','江西省.赣州市.寻乌县','JXSGZSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360735,'360735','江西省.赣州市.石城县','JXSGZSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360781,'360781','江西省.赣州市.瑞金市','JXSGZSRJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360782,'360782','江西省.赣州市.南康市','JXSGZSNKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360800,'360800','江西省.吉安市','JXSJAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360802,'360802','江西省.吉安市.吉州区','JXSJASJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360803,'360803','江西省.吉安市.青原区','JXSJASQYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360821,'360821','江西省.吉安市.吉安县','JXSJASJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360822,'360822','江西省.吉安市.吉水县','JXSJASJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360823,'360823','江西省.吉安市.峡江县','JXSJASXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360824,'360824','江西省.吉安市.新干县','JXSJASXGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360825,'360825','江西省.吉安市.永丰县','JXSJASYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360826,'360826','江西省.吉安市.泰和县','JXSJASTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360827,'360827','江西省.吉安市.遂川县','JXSJASSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360828,'360828','江西省.吉安市.万安县','JXSJASWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360829,'360829','江西省.吉安市.安福县','JXSJASAFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360830,'360830','江西省.吉安市.永新县','JXSJASYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360881,'360881','江西省.吉安市.井冈山市','JXSJASJGSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360900,'360900','江西省.宜春市','JXSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360902,'360902','江西省.宜春市.袁州区','JXSYCSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360921,'360921','江西省.宜春市.奉新县','JXSYCSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360922,'360922','江西省.宜春市.万载县','JXSYCSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360923,'360923','江西省.宜春市.上高县','JXSYCSSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360924,'360924','江西省.宜春市.宜丰县','JXSYCSYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360925,'360925','江西省.宜春市.靖安县','JXSYCSJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360926,'360926','江西省.宜春市.铜鼓县','JXSYCSTGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360981,'360981','江西省.宜春市.丰城市','JXSYCSFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360982,'360982','江西省.宜春市.樟树市','JXSYCSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,360983,'360983','江西省.宜春市.高安市','JXSYCSGAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361000,'361000','江西省.抚州市','JXSFZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361002,'361002','江西省.抚州市.临川区','JXSFZSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361021,'361021','江西省.抚州市.南城县','JXSFZSNCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361022,'361022','江西省.抚州市.黎川县','JXSFZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361023,'361023','江西省.抚州市.南丰县','JXSFZSNFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361024,'361024','江西省.抚州市.崇仁县','JXSFZSCRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361025,'361025','江西省.抚州市.乐安县','JXSFZSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361026,'361026','江西省.抚州市.宜黄县','JXSFZSYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361027,'361027','江西省.抚州市.金溪县','JXSFZSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361028,'361028','江西省.抚州市.资溪县','JXSFZSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361029,'361029','江西省.抚州市.东乡县','JXSFZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361030,'361030','江西省.抚州市.广昌县','JXSFZSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361100,'361100','江西省.上饶市','JXSSRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361102,'361102','江西省.上饶市.信州区','JXSSRSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361121,'361121','江西省.上饶市.上饶县','JXSSRSSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361122,'361122','江西省.上饶市.广丰县','JXSSRSGFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361123,'361123','江西省.上饶市.玉山县','JXSSRSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361124,'361124','江西省.上饶市.铅山县','JXSSRSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361125,'361125','江西省.上饶市.横峰县','JXSSRSHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361126,'361126','江西省.上饶市.弋阳县','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361127,'361127','江西省.上饶市.余干县','JXSSRSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361128,'361128','江西省.上饶市.鄱阳县','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361129,'361129','江西省.上饶市.万年县','JXSSRSWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361130,'361130','江西省.上饶市.婺源县','JXSSRSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,361181,'361181','江西省.上饶市.德兴市','JXSSRSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370000,'370000','山东省','SDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370100,'370100','山东省.济南市','SDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370102,'370102','山东省.济南市.历下区','SDSJNSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370103,'370103','山东省.济南市.市中区','SDSJNSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370104,'370104','山东省.济南市.槐荫区','SDSJNSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370105,'370105','山东省.济南市.天桥区','SDSJNSTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370112,'370112','山东省.济南市.历城区','SDSJNSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370113,'370113','山东省.济南市.长清区','SDSJNSCQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370124,'370124','山东省.济南市.平阴县','SDSJNSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370125,'370125','山东省.济南市.济阳县','SDSJNSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370126,'370126','山东省.济南市.商河县','SDSJNSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370181,'370181','山东省.济南市.章丘市','SDSJNSZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370200,'370200','山东省.青岛市','SDSQDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370202,'370202','山东省.青岛市.市南区','SDSQDSSNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370203,'370203','山东省.青岛市.市北区','SDSQDSSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370205,'370205','山东省.青岛市.四方区','SDSQDSSFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370211,'370211','山东省.青岛市.黄岛区','SDSQDSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370212,'370212','山东省.青岛市.崂山区','SDSQDSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370213,'370213','山东省.青岛市.李沧区','SDSQDSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370214,'370214','山东省.青岛市.城阳区','SDSQDSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370281,'370281','山东省.青岛市.胶州市','SDSQDSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370282,'370282','山东省.青岛市.即墨市','SDSQDSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370283,'370283','山东省.青岛市.平度市','SDSQDSPDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370284,'370284','山东省.青岛市.胶南市','SDSQDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370285,'370285','山东省.青岛市.莱西市','SDSQDSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370300,'370300','山东省.淄博市','SDSZBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370302,'370302','山东省.淄博市.淄川区','SDSZBSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370303,'370303','山东省.淄博市.张店区','SDSZBSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370304,'370304','山东省.淄博市.博山区','SDSZBSBSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370305,'370305','山东省.淄博市.临淄区','SDSZBSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370306,'370306','山东省.淄博市.周村区','SDSZBSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370321,'370321','山东省.淄博市.桓台县','SDSZBSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370322,'370322','山东省.淄博市.高青县','SDSZBSGQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370323,'370323','山东省.淄博市.沂源县','SDSZBSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370400,'370400','山东省.枣庄市','SDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370402,'370402','山东省.枣庄市.市中区','SDSZZSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370403,'370403','山东省.枣庄市.薛城区','SDSZZSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370404,'370404','山东省.枣庄市.峄城区','SDSZZSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370405,'370405','山东省.枣庄市.台儿庄区','SDSZZSTEZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370406,'370406','山东省.枣庄市.山亭区','SDSZZSSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370481,'370481','山东省.枣庄市.滕州市','SDSZZSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370500,'370500','山东省.东营市','SDSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370502,'370502','山东省.东营市.东营区','SDSDYSDYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370503,'370503','山东省.东营市.河口区','SDSDYSHKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370521,'370521','山东省.东营市.垦利县','SDSDYSKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370522,'370522','山东省.东营市.利津县','SDSDYSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370523,'370523','山东省.东营市.广饶县','SDSDYSGRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370600,'370600','山东省.烟台市','SDSYTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370602,'370602','山东省.烟台市.芝罘区','SDSYTSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370611,'370611','山东省.烟台市.福山区','SDSYTSFSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370612,'370612','山东省.烟台市.牟平区','SDSYTSMPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370613,'370613','山东省.烟台市.莱山区','SDSYTSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370634,'370634','山东省.烟台市.长岛县','SDSYTSCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370681,'370681','山东省.烟台市.龙口市','SDSYTSLKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370682,'370682','山东省.烟台市.莱阳市','SDSYTSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370683,'370683','山东省.烟台市.莱州市','SDSYTSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370684,'370684','山东省.烟台市.蓬莱市','SDSYTSPLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370685,'370685','山东省.烟台市.招远市','SDSYTSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370686,'370686','山东省.烟台市.栖霞市','SDSYTSQXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370687,'370687','山东省.烟台市.海阳市','SDSYTSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370700,'370700','山东省.潍坊市','SDSWFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370702,'370702','山东省.潍坊市.潍城区','SDSWFSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370703,'370703','山东省.潍坊市.寒亭区','SDSWFSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370704,'370704','山东省.潍坊市.坊子区','SDSWFSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370705,'370705','山东省.潍坊市.奎文区','SDSWFSKWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370724,'370724','山东省.潍坊市.临朐县','SDSWFSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370725,'370725','山东省.潍坊市.昌乐县','SDSWFSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370781,'370781','山东省.潍坊市.青州市','SDSWFSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370782,'370782','山东省.潍坊市.诸城市','SDSWFSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370783,'370783','山东省.潍坊市.寿光市','SDSWFSSGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370784,'370784','山东省.潍坊市.安丘市','SDSWFSAQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370785,'370785','山东省.潍坊市.高密市','SDSWFSGMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370786,'370786','山东省.潍坊市.昌邑市','SDSWFSCYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370800,'370800','山东省.济宁市','SDSJNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370802,'370802','山东省.济宁市.市中区','SDSJNSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370811,'370811','山东省.济宁市.任城区','SDSJNSRCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370826,'370826','山东省.济宁市.微山县','SDSJNSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370827,'370827','山东省.济宁市.鱼台县','SDSJNSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370828,'370828','山东省.济宁市.金乡县','SDSJNSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370829,'370829','山东省.济宁市.嘉祥县','SDSJNSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370830,'370830','山东省.济宁市.汶上县','SDSJNSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370831,'370831','山东省.济宁市.泗水县','SDSJNSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370832,'370832','山东省.济宁市.梁山县','SDSJNSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370881,'370881','山东省.济宁市.曲阜市','SDSJNSQFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370882,'370882','山东省.济宁市.兖州市','SDSJNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370883,'370883','山东省.济宁市.邹城市','SDSJNSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370900,'370900','山东省.泰安市','SDSTAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370902,'370902','山东省.泰安市.泰山区','SDSTASTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370911,'370911','山东省.泰安市.岱岳区','SDSTASZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370921,'370921','山东省.泰安市.宁阳县','SDSTASNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370923,'370923','山东省.泰安市.东平县','SDSTASDPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370982,'370982','山东省.泰安市.新泰市','SDSTASXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,370983,'370983','山东省.泰安市.肥城市','SDSTASFCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371000,'371000','山东省.威海市','SDSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371002,'371002','山东省.威海市.环翠区','SDSWHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371081,'371081','山东省.威海市.文登市','SDSWHSWDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371082,'371082','山东省.威海市.荣成市','SDSWHSRCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371083,'371083','山东省.威海市.乳山市','SDSWHSRSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371100,'371100','山东省.日照市','SDSRZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371102,'371102','山东省.日照市.东港区','SDSRZSDGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371103,'371103','山东省.日照市.岚山区','SDSRZSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371121,'371121','山东省.日照市.五莲县','SDSRZSWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371122,'371122','山东省.日照市.莒县','SDSRZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371200,'371200','山东省.莱芜市','SDSLWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371202,'371202','山东省.莱芜市.莱城区','SDSLWSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371203,'371203','山东省.莱芜市.钢城区','SDSLWSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371300,'371300','山东省.临沂市','SDSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371302,'371302','山东省.临沂市.兰山区','SDSLYSLSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371311,'371311','山东省.临沂市.罗庄区','SDSLYSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371312,'371312','山东省.临沂市.河东区','SDSLYSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371321,'371321','山东省.临沂市.沂南县','SDSLYSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371322,'371322','山东省.临沂市.郯城县','SDSLYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371323,'371323','山东省.临沂市.沂水县','SDSLYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371324,'371324','山东省.临沂市.苍山县','SDSLYSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371325,'371325','山东省.临沂市.费县','SDSLYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371326,'371326','山东省.临沂市.平邑县','SDSLYSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371327,'371327','山东省.临沂市.莒南县','SDSLYSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371328,'371328','山东省.临沂市.蒙阴县','SDSLYSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371329,'371329','山东省.临沂市.临沭县','SDSLYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371400,'371400','山东省.德州市','SDSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371402,'371402','山东省.德州市.德城区','SDSDZSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371421,'371421','山东省.德州市.陵县','SDSDZSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371422,'371422','山东省.德州市.宁津县','SDSDZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371423,'371423','山东省.德州市.庆云县','SDSDZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371424,'371424','山东省.德州市.临邑县','SDSDZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371425,'371425','山东省.德州市.齐河县','SDSDZSQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371426,'371426','山东省.德州市.平原县','SDSDZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371427,'371427','山东省.德州市.夏津县','SDSDZSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371428,'371428','山东省.德州市.武城县','SDSDZSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371481,'371481','山东省.德州市.乐陵市','SDSDZSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371482,'371482','山东省.德州市.禹城市','SDSDZSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371500,'371500','山东省.聊城市','SDSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371502,'371502','山东省.聊城市.东昌府区','SDSLCSDCFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371521,'371521','山东省.聊城市.阳谷县','SDSLCSYGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371522,'371522','山东省.聊城市.莘县','SDSLCSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371523,'371523','山东省.聊城市.茌平县','SDSLCSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371524,'371524','山东省.聊城市.东阿县','SDSLCSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371525,'371525','山东省.聊城市.冠县','SDSLCSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371526,'371526','山东省.聊城市.高唐县','SDSLCSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371581,'371581','山东省.聊城市.临清市','SDSLCSLQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371600,'371600','山东省.滨州市','SDSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371602,'371602','山东省.滨州市.滨城区','SDSBZSBCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371621,'371621','山东省.滨州市.惠民县','SDSBZSHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371622,'371622','山东省.滨州市.阳信县','SDSBZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371623,'371623','山东省.滨州市.无棣县','SDSBZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371624,'371624','山东省.滨州市.沾化县','SDSBZSZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371625,'371625','山东省.滨州市.博兴县','SDSBZSBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371626,'371626','山东省.滨州市.邹平县','SDSBZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371700,'371700','山东省.菏泽市','SDSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371702,'371702','山东省.菏泽市.牡丹区','SDSHZSMDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371721,'371721','山东省.菏泽市.曹县','SDSHZSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371722,'371722','山东省.菏泽市.单县','SDSHZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371723,'371723','山东省.菏泽市.成武县','SDSHZSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371724,'371724','山东省.菏泽市.巨野县','SDSHZSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371725,'371725','山东省.菏泽市.郓城县','SDSHZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371726,'371726','山东省.菏泽市.鄄城县','SDSHZSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371727,'371727','山东省.菏泽市.定陶县','SDSHZSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,371728,'371728','山东省.菏泽市.东明县','SDSHZSDMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410000,'410000','河南省','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410100,'410100','河南省.郑州市','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410102,'410102','河南省.郑州市.中原区','HNSZZSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410103,'410103','河南省.郑州市.二七区','HNSZZSEQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410104,'410104','河南省.郑州市.管城回族区','HNSZZSGCHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410105,'410105','河南省.郑州市.金水区','HNSZZSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410106,'410106','河南省.郑州市.上街区','HNSZZSSJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410108,'410108','河南省.郑州市.惠济区','HNSZZSHJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410122,'410122','河南省.郑州市.中牟县','HNSZZSZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410181,'410181','河南省.郑州市.巩义市','HNSZZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410182,'410182','河南省.郑州市.荥阳市','HNSZZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410183,'410183','河南省.郑州市.新密市','HNSZZSXMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410184,'410184','河南省.郑州市.新郑市','HNSZZSXZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410185,'410185','河南省.郑州市.登封市','HNSZZSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410200,'410200','河南省.开封市','HNSKFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410202,'410202','河南省.开封市.龙亭区','HNSKFSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410203,'410203','河南省.开封市.顺河回族区','HNSKFSSHHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410204,'410204','河南省.开封市.鼓楼区','HNSKFSGLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410205,'410205','河南省.开封市.禹王台区','HNSKFSYWTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410211,'410211','河南省.开封市.金明区','HNSKFSJMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410221,'410221','河南省.开封市.杞县','HNSKFSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410222,'410222','河南省.开封市.通许县','HNSKFSTXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410223,'410223','河南省.开封市.尉氏县','HNSKFSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410224,'410224','河南省.开封市.开封县','HNSKFSKFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410225,'410225','河南省.开封市.兰考县','HNSKFSLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410300,'410300','河南省.洛阳市','HNSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410302,'410302','河南省.洛阳市.老城区','HNSLYSLCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410303,'410303','河南省.洛阳市.西工区','HNSLYSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410304,'410304','河南省.洛阳市.瀍河回族区','HNSLYSCHHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410305,'410305','河南省.洛阳市.涧西区','HNSLYSJXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410306,'410306','河南省.洛阳市.吉利区','HNSLYSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410311,'410311','河南省.洛阳市.洛龙区','HNSLYSLLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410322,'410322','河南省.洛阳市.孟津县','HNSLYSMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410323,'410323','河南省.洛阳市.新安县','HNSLYSXAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410324,'410324','河南省.洛阳市.栾川县','HNSLYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410325,'410325','河南省.洛阳市.嵩县','HNSLYSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410326,'410326','河南省.洛阳市.汝阳县','HNSLYSRYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410327,'410327','河南省.洛阳市.宜阳县','HNSLYSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410328,'410328','河南省.洛阳市.洛宁县','HNSLYSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410329,'410329','河南省.洛阳市.伊川县','HNSLYSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410381,'410381','河南省.洛阳市.偃师市','HNSLYSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410400,'410400','河南省.平顶山市','HNSPDSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410402,'410402','河南省.平顶山市.新华区','HNSPDSSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410403,'410403','河南省.平顶山市.卫东区','HNSPDSSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410404,'410404','河南省.平顶山市.石龙区','HNSPDSSSLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410411,'410411','河南省.平顶山市.湛河区','HNSPDSSZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410421,'410421','河南省.平顶山市.宝丰县','HNSPDSSBFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410422,'410422','河南省.平顶山市.叶县','HNSPDSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410423,'410423','河南省.平顶山市.鲁山县','HNSPDSSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410425,'410425','河南省.平顶山市.郏县','HNSPDSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410481,'410481','河南省.平顶山市.舞钢市','HNSPDSSWGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410482,'410482','河南省.平顶山市.汝州市','HNSPDSSRZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410500,'410500','河南省.安阳市','HNSAYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410502,'410502','河南省.安阳市.文峰区','HNSAYSWFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410503,'410503','河南省.安阳市.北关区','HNSAYSBGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410505,'410505','河南省.安阳市.殷都区','HNSAYSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410506,'410506','河南省.安阳市.龙安区','HNSAYSLAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410522,'410522','河南省.安阳市.安阳县','HNSAYSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410523,'410523','河南省.安阳市.汤阴县','HNSAYSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410526,'410526','河南省.安阳市.滑县','HNSAYSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410527,'410527','河南省.安阳市.内黄县','HNSAYSNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410581,'410581','河南省.安阳市.林州市','HNSAYSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410600,'410600','河南省.鹤壁市','HNSHBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410602,'410602','河南省.鹤壁市.鹤山区','HNSHBSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410603,'410603','河南省.鹤壁市.山城区','HNSHBSSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410611,'410611','河南省.鹤壁市.淇滨区','HNSHBSZBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410621,'410621','河南省.鹤壁市.浚县','HNSHBSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410622,'410622','河南省.鹤壁市.淇县','HNSHBSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410700,'410700','河南省.新乡市','HNSXXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410702,'410702','河南省.新乡市.红旗区','HNSXXSHQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410703,'410703','河南省.新乡市.卫滨区','HNSXXSWBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410704,'410704','河南省.新乡市.凤泉区','HNSXXSFQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410711,'410711','河南省.新乡市.牧野区','HNSXXSMYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410721,'410721','河南省.新乡市.新乡县','HNSXXSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410724,'410724','河南省.新乡市.获嘉县','HNSXXSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410725,'410725','河南省.新乡市.原阳县','HNSXXSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410726,'410726','河南省.新乡市.延津县','HNSXXSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410727,'410727','河南省.新乡市.封丘县','HNSXXSFQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410728,'410728','河南省.新乡市.长垣县','HNSXXSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410781,'410781','河南省.新乡市.卫辉市','HNSXXSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410782,'410782','河南省.新乡市.辉县市','HNSXXSHXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410800,'410800','河南省.焦作市','HNSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410802,'410802','河南省.焦作市.解放区','HNSJZSJFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410803,'410803','河南省.焦作市.中站区','HNSJZSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410804,'410804','河南省.焦作市.马村区','HNSJZSMCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410811,'410811','河南省.焦作市.山阳区','HNSJZSSYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410821,'410821','河南省.焦作市.修武县','HNSJZSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410822,'410822','河南省.焦作市.博爱县','HNSJZSBAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410823,'410823','河南省.焦作市.武陟县','HNSJZSWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410825,'410825','河南省.焦作市.温县','HNSJZSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410882,'410882','河南省.焦作市.沁阳市','HNSJZSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410883,'410883','河南省.焦作市.孟州市','HNSJZSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410900,'410900','河南省.濮阳市','HNSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410902,'410902','河南省.濮阳市.华龙区','HNSZYSHLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410922,'410922','河南省.濮阳市.清丰县','HNSZYSQFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410923,'410923','河南省.濮阳市.南乐县','HNSZYSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410926,'410926','河南省.濮阳市.范县','HNSZYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410927,'410927','河南省.濮阳市.台前县','HNSZYSTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,410928,'410928','河南省.濮阳市.濮阳县','HNSZYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411000,'411000','河南省.许昌市','HNSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411002,'411002','河南省.许昌市.魏都区','HNSXCSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411023,'411023','河南省.许昌市.许昌县','HNSXCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411024,'411024','河南省.许昌市.鄢陵县','HNSXCSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411025,'411025','河南省.许昌市.襄城县','HNSXCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411081,'411081','河南省.许昌市.禹州市','HNSXCSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411082,'411082','河南省.许昌市.长葛市','HNSXCSCGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411100,'411100','河南省.漯河市','HNSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411102,'411102','河南省.漯河市.源汇区','HNSZHSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411103,'411103','河南省.漯河市.郾城区','HNSZHSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411104,'411104','河南省.漯河市.召陵区','HNSZHSZLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411121,'411121','河南省.漯河市.舞阳县','HNSZHSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411122,'411122','河南省.漯河市.临颍县','HNSZHSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411200,'411200','河南省.三门峡市','HNSSMXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411202,'411202','河南省.三门峡市.湖滨区','HNSSMXSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411221,'411221','河南省.三门峡市.渑池县','HNSSMXSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411222,'411222','河南省.三门峡市.陕县','HNSSMXSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411224,'411224','河南省.三门峡市.卢氏县','HNSSMXSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411281,'411281','河南省.三门峡市.义马市','HNSSMXSYMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411282,'411282','河南省.三门峡市.灵宝市','HNSSMXSLBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411300,'411300','河南省.南阳市','HNSNYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411302,'411302','河南省.南阳市.宛城区','HNSNYSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411303,'411303','河南省.南阳市.卧龙区','HNSNYSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411321,'411321','河南省.南阳市.南召县','HNSNYSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411322,'411322','河南省.南阳市.方城县','HNSNYSFCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411323,'411323','河南省.南阳市.西峡县','HNSNYSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411324,'411324','河南省.南阳市.镇平县','HNSNYSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411325,'411325','河南省.南阳市.内乡县','HNSNYSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411326,'411326','河南省.南阳市.淅川县','HNSNYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411327,'411327','河南省.南阳市.社旗县','HNSNYSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411328,'411328','河南省.南阳市.唐河县','HNSNYSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411329,'411329','河南省.南阳市.新野县','HNSNYSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411330,'411330','河南省.南阳市.桐柏县','HNSNYSTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411381,'411381','河南省.南阳市.邓州市','HNSNYSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411400,'411400','河南省.商丘市','HNSSQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411402,'411402','河南省.商丘市.梁园区','HNSSQSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411403,'411403','河南省.商丘市.睢阳区','HNSSQSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411421,'411421','河南省.商丘市.民权县','HNSSQSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411422,'411422','河南省.商丘市.睢县','HNSSQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411423,'411423','河南省.商丘市.宁陵县','HNSSQSNLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411424,'411424','河南省.商丘市.柘城县','HNSSQSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411425,'411425','河南省.商丘市.虞城县','HNSSQSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411426,'411426','河南省.商丘市.夏邑县','HNSSQSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411481,'411481','河南省.商丘市.永城市','HNSSQSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411500,'411500','河南省.信阳市','HNSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411502,'411502','河南省.信阳市.浉河区','HNSXYSSHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411503,'411503','河南省.信阳市.平桥区','HNSXYSPQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411521,'411521','河南省.信阳市.罗山县','HNSXYSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411522,'411522','河南省.信阳市.光山县','HNSXYSGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411523,'411523','河南省.信阳市.新县','HNSXYSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411524,'411524','河南省.信阳市.商城县','HNSXYSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411525,'411525','河南省.信阳市.固始县','HNSXYSGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411526,'411526','河南省.信阳市.潢川县','HNSXYSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411527,'411527','河南省.信阳市.淮滨县','HNSXYSHBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411528,'411528','河南省.信阳市.息县','HNSXYSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411600,'411600','河南省.周口市','HNSZKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411602,'411602','河南省.周口市.川汇区','HNSZKSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411621,'411621','河南省.周口市.扶沟县','HNSZKSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411622,'411622','河南省.周口市.西华县','HNSZKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411623,'411623','河南省.周口市.商水县','HNSZKSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411624,'411624','河南省.周口市.沈丘县','HNSZKSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411625,'411625','河南省.周口市.郸城县','HNSZKSDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411626,'411626','河南省.周口市.淮阳县','HNSZKSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411627,'411627','河南省.周口市.太康县','HNSZKSTKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411628,'411628','河南省.周口市.鹿邑县','HNSZKSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411681,'411681','河南省.周口市.项城市','HNSZKSXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411700,'411700','河南省.驻马店市','HNSZMDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411702,'411702','河南省.驻马店市.驿城区','HNSZMDSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411721,'411721','河南省.驻马店市.西平县','HNSZMDSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411722,'411722','河南省.驻马店市.上蔡县','HNSZMDSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411723,'411723','河南省.驻马店市.平舆县','HNSZMDSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411724,'411724','河南省.驻马店市.正阳县','HNSZMDSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411725,'411725','河南省.驻马店市.确山县','HNSZMDSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411726,'411726','河南省.驻马店市.泌阳县','HNSZMDSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411727,'411727','河南省.驻马店市.汝南县','HNSZMDSRNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411728,'411728','河南省.驻马店市.遂平县','HNSZMDSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,411729,'411729','河南省.驻马店市.新蔡县','HNSZMDSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,419000,'419000','河南省.省直辖县级行政区划','HNSSZXXJXZQH'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,419001,'419001','河南省.济源市','HNSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420000,'420000','湖北省','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420100,'420100','湖北省.武汉市','HBSWHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420102,'420102','湖北省.武汉市.江岸区','HBSWHSJAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420103,'420103','湖北省.武汉市.江汉区','HBSWHSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420104,'420104','湖北省.武汉市.硚口区','HBSWHSCKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420105,'420105','湖北省.武汉市.汉阳区','HBSWHSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420106,'420106','湖北省.武汉市.武昌区','HBSWHSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420107,'420107','湖北省.武汉市.青山区','HBSWHSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420111,'420111','湖北省.武汉市.洪山区','HBSWHSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420112,'420112','湖北省.武汉市.东西湖区','HBSWHSDXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420113,'420113','湖北省.武汉市.汉南区','HBSWHSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420114,'420114','湖北省.武汉市.蔡甸区','HBSWHSCDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420115,'420115','湖北省.武汉市.江夏区','HBSWHSJXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420116,'420116','湖北省.武汉市.黄陂区','HBSWHSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420117,'420117','湖北省.武汉市.新洲区','HBSWHSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420200,'420200','湖北省.黄石市','HBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420202,'420202','湖北省.黄石市.黄石港区','HBSHSSHSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420203,'420203','湖北省.黄石市.西塞山区','HBSHSSXSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420204,'420204','湖北省.黄石市.下陆区','HBSHSSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420205,'420205','湖北省.黄石市.铁山区','HBSHSSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420222,'420222','湖北省.黄石市.阳新县','HBSHSSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420281,'420281','湖北省.黄石市.大冶市','HBSHSSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420300,'420300','湖北省.十堰市','HBSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420302,'420302','湖北省.十堰市.茅箭区','HBSSYSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420303,'420303','湖北省.十堰市.张湾区','HBSSYSZWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420321,'420321','湖北省.十堰市.郧县','HBSSYSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420322,'420322','湖北省.十堰市.郧西县','HBSSYSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420323,'420323','湖北省.十堰市.竹山县','HBSSYSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420324,'420324','湖北省.十堰市.竹溪县','HBSSYSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420325,'420325','湖北省.十堰市.房县','HBSSYSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420381,'420381','湖北省.十堰市.丹江口市','HBSSYSDJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420500,'420500','湖北省.宜昌市','HBSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420502,'420502','湖北省.宜昌市.西陵区','HBSYCSXLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420503,'420503','湖北省.宜昌市.伍家岗区','HBSYCSWJGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420504,'420504','湖北省.宜昌市.点军区','HBSYCSDJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420505,'420505','湖北省.宜昌市.猇亭区','HBSYCSX+C2588TQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420506,'420506','湖北省.宜昌市.夷陵区','HBSYCSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420525,'420525','湖北省.宜昌市.远安县','HBSYCSYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420526,'420526','湖北省.宜昌市.兴山县','HBSYCSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420527,'420527','湖北省.宜昌市.秭归县','HBSYCSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420528,'420528','湖北省.宜昌市.长阳土家族自治县','HBSYCSCYTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420529,'420529','湖北省.宜昌市.五峰土家族自治县','HBSYCSWFTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420581,'420581','湖北省.宜昌市.宜都市','HBSYCSYDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420582,'420582','湖北省.宜昌市.当阳市','HBSYCSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420583,'420583','湖北省.宜昌市.枝江市','HBSYCSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420600,'420600','湖北省.襄樊市','HBSXFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420602,'420602','湖北省.襄樊市.襄城区','HBSXFSXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420606,'420606','湖北省.襄樊市.樊城区','HBSXFSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420607,'420607','湖北省.襄樊市.襄阳区','HBSXFSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420624,'420624','湖北省.襄樊市.南漳县','HBSXFSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420625,'420625','湖北省.襄樊市.谷城县','HBSXFSGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420626,'420626','湖北省.襄樊市.保康县','HBSXFSBKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420682,'420682','湖北省.襄樊市.老河口市','HBSXFSLHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420683,'420683','湖北省.襄樊市.枣阳市','HBSXFSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420684,'420684','湖北省.襄樊市.宜城市','HBSXFSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420700,'420700','湖北省.鄂州市','HBSEZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420702,'420702','湖北省.鄂州市.梁子湖区','HBSEZSLZHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420703,'420703','湖北省.鄂州市.华容区','HBSEZSHRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420704,'420704','湖北省.鄂州市.鄂城区','HBSEZSECQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420800,'420800','湖北省.荆门市','HBSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420802,'420802','湖北省.荆门市.东宝区','HBSJMSDBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420804,'420804','湖北省.荆门市.掇刀区','HBSJMSDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420821,'420821','湖北省.荆门市.京山县','HBSJMSJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420822,'420822','湖北省.荆门市.沙洋县','HBSJMSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420881,'420881','湖北省.荆门市.钟祥市','HBSJMSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420900,'420900','湖北省.孝感市','HBSXGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420902,'420902','湖北省.孝感市.孝南区','HBSXGSXNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420921,'420921','湖北省.孝感市.孝昌县','HBSXGSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420922,'420922','湖北省.孝感市.大悟县','HBSXGSDWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420923,'420923','湖北省.孝感市.云梦县','HBSXGSYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420981,'420981','湖北省.孝感市.应城市','HBSXGSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420982,'420982','湖北省.孝感市.安陆市','HBSXGSALS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,420984,'420984','湖北省.孝感市.汉川市','HBSXGSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421000,'421000','湖北省.荆州市','HBSJZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421002,'421002','湖北省.荆州市.沙市区','HBSJZSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421003,'421003','湖北省.荆州市.荆州区','HBSJZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421022,'421022','湖北省.荆州市.公安县','HBSJZSGAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421023,'421023','湖北省.荆州市.监利县','HBSJZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421024,'421024','湖北省.荆州市.江陵县','HBSJZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421081,'421081','湖北省.荆州市.石首市','HBSJZSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421083,'421083','湖北省.荆州市.洪湖市','HBSJZSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421087,'421087','湖北省.荆州市.松滋市','HBSJZSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421100,'421100','湖北省.黄冈市','HBSHGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421102,'421102','湖北省.黄冈市.黄州区','HBSHGSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421121,'421121','湖北省.黄冈市.团风县','HBSHGSTFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421122,'421122','湖北省.黄冈市.红安县','HBSHGSHAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421123,'421123','湖北省.黄冈市.罗田县','HBSHGSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421124,'421124','湖北省.黄冈市.英山县','HBSHGSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421125,'421125','湖北省.黄冈市.浠水县','HBSHGSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421126,'421126','湖北省.黄冈市.蕲春县','HBSHGSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421127,'421127','湖北省.黄冈市.黄梅县','HBSHGSHMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421181,'421181','湖北省.黄冈市.麻城市','HBSHGSMCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421182,'421182','湖北省.黄冈市.武穴市','HBSHGSWXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421200,'421200','湖北省.咸宁市','HBSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421202,'421202','湖北省.咸宁市.咸安区','HBSXNSXAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421221,'421221','湖北省.咸宁市.嘉鱼县','HBSXNSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421222,'421222','湖北省.咸宁市.通城县','HBSXNSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421223,'421223','湖北省.咸宁市.崇阳县','HBSXNSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421224,'421224','湖北省.咸宁市.通山县','HBSXNSTSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421281,'421281','湖北省.咸宁市.赤壁市','HBSXNSCBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421300,'421300','湖北省.随州市','HBSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421303,'421303','湖北省.随州市.曾都区','HBSSZSZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421321,'421321','湖北省.随州市.随县','HBSSZSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,421381,'421381','湖北省.随州市.广水市','HBSSZSGSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422800,'422800','湖北省.恩施州.恩施州','HBSESZESZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422801,'422801','湖北省.恩施州.恩施市','HBSESZESS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422802,'422802','湖北省.恩施州.利川市','HBSESZLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422822,'422822','湖北省.恩施州.建始县','HBSESZJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422823,'422823','湖北省.恩施州.巴东县','HBSESZBDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422825,'422825','湖北省.恩施州.宣恩县','HBSESZXEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422826,'422826','湖北省.恩施州.咸丰县','HBSESZXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422827,'422827','湖北省.恩施州.来凤县','HBSESZLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,422828,'422828','湖北省.恩施州.鹤峰县','HBSESZHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429000,'429000','湖北省','HBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429004,'429004','湖北省.仙桃市','HBSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429005,'429005','湖北省.潜江市','HBSQJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429006,'429006','湖北省.天门市','HBSTMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,429021,'429021','湖北省.神农架林区','HBSSNJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430000,'430000','湖南省','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430100,'430100','湖南省.长沙市','HNSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430102,'430102','湖南省.长沙市.芙蓉区','HNSCSSZRQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430103,'430103','湖南省.长沙市.天心区','HNSCSSTXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430104,'430104','湖南省.长沙市.岳麓区','HNSCSSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430105,'430105','湖南省.长沙市.开福区','HNSCSSKFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430111,'430111','湖南省.长沙市.雨花区','HNSCSSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430121,'430121','湖南省.长沙市.长沙县','HNSCSSCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430122,'430122','湖南省.长沙市.望城县','HNSCSSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430124,'430124','湖南省.长沙市.宁乡县','HNSCSSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430181,'430181','湖南省.长沙市.浏阳市','HNSCSSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430200,'430200','湖南省.株洲市','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430202,'430202','湖南省.株洲市.荷塘区','HNSZZSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430203,'430203','湖南省.株洲市.芦淞区','HNSZZSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430204,'430204','湖南省.株洲市.石峰区','HNSZZSSFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430211,'430211','湖南省.株洲市.天元区','HNSZZSTYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430221,'430221','湖南省.株洲市.株洲县','HNSZZSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430223,'430223','湖南省.株洲市.攸县','HNSZZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430224,'430224','湖南省.株洲市.茶陵县','HNSZZSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430225,'430225','湖南省.株洲市.炎陵县','HNSZZSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430281,'430281','湖南省.株洲市.醴陵市','HNSZZSLLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430300,'430300','湖南省.湘潭市','HNSXTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430302,'430302','湖南省.湘潭市.雨湖区','HNSXTSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430304,'430304','湖南省.湘潭市.岳塘区','HNSXTSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430321,'430321','湖南省.湘潭市.湘潭县','HNSXTSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430381,'430381','湖南省.湘潭市.湘乡市','HNSXTSXXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430382,'430382','湖南省.湘潭市.韶山市','HNSXTSSSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430400,'430400','湖南省.衡阳市','HNSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430405,'430405','湖南省.衡阳市.珠晖区','HNSHYSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430406,'430406','湖南省.衡阳市.雁峰区','HNSHYSYFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430407,'430407','湖南省.衡阳市.石鼓区','HNSHYSSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430408,'430408','湖南省.衡阳市.蒸湘区','HNSHYSZXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430412,'430412','湖南省.衡阳市.南岳区','HNSHYSNYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430421,'430421','湖南省.衡阳市.衡阳县','HNSHYSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430422,'430422','湖南省.衡阳市.衡南县','HNSHYSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430423,'430423','湖南省.衡阳市.衡山县','HNSHYSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430424,'430424','湖南省.衡阳市.衡东县','HNSHYSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430426,'430426','湖南省.衡阳市.祁东县','HNSHYSQDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430481,'430481','湖南省.衡阳市.耒阳市','HNSHYSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430482,'430482','湖南省.衡阳市.常宁市','HNSHYSCNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430500,'430500','湖南省.邵阳市','HNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430502,'430502','湖南省.邵阳市.双清区','HNSSYSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430503,'430503','湖南省.邵阳市.大祥区','HNSSYSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430511,'430511','湖南省.邵阳市.北塔区','HNSSYSBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430521,'430521','湖南省.邵阳市.邵东县','HNSSYSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430522,'430522','湖南省.邵阳市.新邵县','HNSSYSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430523,'430523','湖南省.邵阳市.邵阳县','HNSSYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430524,'430524','湖南省.邵阳市.隆回县','HNSSYSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430525,'430525','湖南省.邵阳市.洞口县','HNSSYSDKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430527,'430527','湖南省.邵阳市.绥宁县','HNSSYSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430528,'430528','湖南省.邵阳市.新宁县','HNSSYSXNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430529,'430529','湖南省.邵阳市.城步苗族自治县','HNSSYSCBMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430581,'430581','湖南省.邵阳市.武冈市','HNSSYSWGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430600,'430600','湖南省.岳阳市','HNSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430602,'430602','湖南省.岳阳市.岳阳楼区','HNSYYSYYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430603,'430603','湖南省.岳阳市.云溪区','HNSYYSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430611,'430611','湖南省.岳阳市.君山区','HNSYYSJSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430621,'430621','湖南省.岳阳市.岳阳县','HNSYYSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430623,'430623','湖南省.岳阳市.华容县','HNSYYSHRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430624,'430624','湖南省.岳阳市.湘阴县','HNSYYSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430626,'430626','湖南省.岳阳市.平江县','HNSYYSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430681,'430681','湖南省.岳阳市.汨罗市','HNSYYSZLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430682,'430682','湖南省.岳阳市.临湘市','HNSYYSLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430700,'430700','湖南省.常德市','HNSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430702,'430702','湖南省.常德市.武陵区','HNSCDSWLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430703,'430703','湖南省.常德市.鼎城区','HNSCDSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430721,'430721','湖南省.常德市.安乡县','HNSCDSAXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430722,'430722','湖南省.常德市.汉寿县','HNSCDSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430723,'430723','湖南省.常德市.澧县','HNSCDSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430724,'430724','湖南省.常德市.临澧县','HNSCDSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430725,'430725','湖南省.常德市.桃源县','HNSCDSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430726,'430726','湖南省.常德市.石门县','HNSCDSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430781,'430781','湖南省.常德市.津市市','HNSCDSJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430800,'430800','湖南省.张家界市','HNSZJJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430802,'430802','湖南省.张家界市.永定区','HNSZJJSYDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430811,'430811','湖南省.张家界市.武陵源区','HNSZJJSWLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430821,'430821','湖南省.张家界市.慈利县','HNSZJJSCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430822,'430822','湖南省.张家界市.桑植县','HNSZJJSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430900,'430900','湖南省.益阳市','HNSYYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430902,'430902','湖南省.益阳市.资阳区','HNSYYSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430903,'430903','湖南省.益阳市.赫山区','HNSYYSHSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430921,'430921','湖南省.益阳市.南县','HNSYYSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430922,'430922','湖南省.益阳市.桃江县','HNSYYSTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430923,'430923','湖南省.益阳市.安化县','HNSYYSAHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,430981,'430981','湖南省.益阳市.沅江市','HNSYYSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431000,'431000','湖南省.郴州市','HNSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431002,'431002','湖南省.郴州市.北湖区','HNSCZSBHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431003,'431003','湖南省.郴州市.苏仙区','HNSCZSSXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431021,'431021','湖南省.郴州市.桂阳县','HNSCZSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431022,'431022','湖南省.郴州市.宜章县','HNSCZSYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431023,'431023','湖南省.郴州市.永兴县','HNSCZSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431024,'431024','湖南省.郴州市.嘉禾县','HNSCZSJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431025,'431025','湖南省.郴州市.临武县','HNSCZSLWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431026,'431026','湖南省.郴州市.汝城县','HNSCZSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431027,'431027','湖南省.郴州市.桂东县','HNSCZSGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431028,'431028','湖南省.郴州市.安仁县','HNSCZSARX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431081,'431081','湖南省.郴州市.资兴市','HNSCZSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431100,'431100','湖南省.永州市','HNSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431102,'431102','湖南省.永州市.零陵区','HNSYZSLLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431103,'431103','湖南省.永州市.冷水滩区','HNSYZSLSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431121,'431121','湖南省.永州市.祁阳县','HNSYZSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431122,'431122','湖南省.永州市.东安县','HNSYZSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431123,'431123','湖南省.永州市.双牌县','HNSYZSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431124,'431124','湖南省.永州市.道县','HNSYZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431125,'431125','湖南省.永州市.江永县','HNSYZSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431126,'431126','湖南省.永州市.宁远县','HNSYZSNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431127,'431127','湖南省.永州市.蓝山县','HNSYZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431128,'431128','湖南省.永州市.新田县','HNSYZSXTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431129,'431129','湖南省.永州市.江华瑶族自治县','HNSYZSJHYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431200,'431200','湖南省.怀化市','HNSHHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431202,'431202','湖南省.怀化市.鹤城区','HNSHHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431221,'431221','湖南省.怀化市.中方县','HNSHHSZFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431222,'431222','湖南省.怀化市.沅陵县','HNSHHSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431223,'431223','湖南省.怀化市.辰溪县','HNSHHSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431224,'431224','湖南省.怀化市.溆浦县','HNSHHSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431225,'431225','湖南省.怀化市.会同县','HNSHHSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431226,'431226','湖南省.怀化市.麻阳苗族自治县','HNSHHSMYMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431227,'431227','湖南省.怀化市.新晃侗族自治县','HNSHHSXHDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431228,'431228','湖南省.怀化市.芷江侗族自治县','HNSHHSZJDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431229,'431229','湖南省.怀化市.靖州县','HNSHHSJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431230,'431230','湖南省.怀化市.通道侗族自治县','HNSHHSTDDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431281,'431281','湖南省.怀化市.洪江市','HNSHHSHJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431300,'431300','湖南省.娄底市','HNSLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431302,'431302','湖南省.娄底市.娄星区','HNSLDSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431321,'431321','湖南省.娄底市.双峰县','HNSLDSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431322,'431322','湖南省.娄底市.新化县','HNSLDSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431381,'431381','湖南省.娄底市.冷水江市','HNSLDSLSJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,431382,'431382','湖南省.娄底市.涟源市','HNSLDSLYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433100,'433100','湖南省.湘西州','HNSXXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433101,'433101','湖南省.湘西州.吉首市','HNSXXZJSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433122,'433122','湖南省.湘西州.泸溪县','HNSXXZZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433123,'433123','湖南省.湘西州.凤凰县','HNSXXZFHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433124,'433124','湖南省.湘西州.花垣县','HNSXXZHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433125,'433125','湖南省.湘西州.保靖县','HNSXXZBJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433126,'433126','湖南省.湘西州.古丈县','HNSXXZGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433127,'433127','湖南省.湘西州.永顺县','HNSXXZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,433130,'433130','湖南省.湘西州.龙山县','HNSXXZLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440000,'440000','广东省','GDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440100,'440100','广东省.广州市','GDSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440103,'440103','广东省.广州市.荔湾区','GDSGZSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440104,'440104','广东省.广州市.越秀区','GDSGZSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440105,'440105','广东省.广州市.海珠区','GDSGZSHZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440106,'440106','广东省.广州市.天河区','GDSGZSTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440111,'440111','广东省.广州市.白云区','GDSGZSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440112,'440112','广东省.广州市.黄埔区','GDSGZSHPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440113,'440113','广东省.广州市.番禺区','GDSGZSFZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440114,'440114','广东省.广州市.花都区','GDSGZSHDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440115,'440115','广东省.广州市.南沙区','GDSGZSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440116,'440116','广东省.广州市.萝岗区','GDSGZSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440183,'440183','广东省.广州市.增城市','GDSGZSZCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440184,'440184','广东省.广州市.从化市','GDSGZSCHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440200,'440200','广东省.韶关市','GDSSGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440203,'440203','广东省.韶关市.武江区','GDSSGSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440204,'440204','广东省.韶关市.浈江区','GDSSGSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440205,'440205','广东省.韶关市.曲江区','GDSSGSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440222,'440222','广东省.韶关市.始兴县','GDSSGSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440224,'440224','广东省.韶关市.仁化县','GDSSGSRHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440229,'440229','广东省.韶关市.翁源县','GDSSGSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440232,'440232','广东省.韶关市.乳源瑶族自治县','GDSSGSRYYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440233,'440233','广东省.韶关市.新丰县','GDSSGSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440281,'440281','广东省.韶关市.乐昌市','GDSSGSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440282,'440282','广东省.韶关市.南雄市','GDSSGSNXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440300,'440300','广东省.深圳市','GDSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440303,'440303','广东省.深圳市.罗湖区','GDSSZSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440304,'440304','广东省.深圳市.福田区','GDSSZSFTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440305,'440305','广东省.深圳市.南山区','GDSSZSNSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440306,'440306','广东省.深圳市.宝安区','GDSSZSBAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440307,'440307','广东省.深圳市.龙岗区','GDSSZSLGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440308,'440308','广东省.深圳市.盐田区','GDSSZSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440400,'440400','广东省.珠海市','GDSZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440402,'440402','广东省.珠海市.香洲区','GDSZHSXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440403,'440403','广东省.珠海市.斗门区','GDSZHSDMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440404,'440404','广东省.珠海市.金湾区','GDSZHSJWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440500,'440500','广东省.汕头市','GDSSTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440507,'440507','广东省.汕头市.龙湖区','GDSSTSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440511,'440511','广东省.汕头市.金平区','GDSSTSJPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440512,'440512','广东省.汕头市.濠江区','GDSSTSZJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440513,'440513','广东省.汕头市.潮阳区','GDSSTSCYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440514,'440514','广东省.汕头市.潮南区','GDSSTSCNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440515,'440515','广东省.汕头市.澄海区','GDSSTSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440523,'440523','广东省.汕头市.南澳县','GDSSTSNAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440600,'440600','广东省.佛山市','GDSFSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440604,'440604','广东省.佛山市.禅城区','GDSFSSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440605,'440605','广东省.佛山市.南海区','GDSFSSNHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440606,'440606','广东省.佛山市.顺德区','GDSFSSSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440607,'440607','广东省.佛山市.三水区','GDSFSSSSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440608,'440608','广东省.佛山市.高明区','GDSFSSGMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440700,'440700','广东省.江门市','GDSJMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440703,'440703','广东省.江门市.蓬江区','GDSJMSPJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440704,'440704','广东省.江门市.江海区','GDSJMSJHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440705,'440705','广东省.江门市.新会区','GDSJMSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440781,'440781','广东省.江门市.台山市','GDSJMSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440783,'440783','广东省.江门市.开平市','GDSJMSKPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440784,'440784','广东省.江门市.鹤山市','GDSJMSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440785,'440785','广东省.江门市.恩平市','GDSJMSEPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440800,'440800','广东省.湛江市','GDSZJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440802,'440802','广东省.湛江市.赤坎区','GDSZJSCKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440803,'440803','广东省.湛江市.霞山区','GDSZJSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440804,'440804','广东省.湛江市.坡头区','GDSZJSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440811,'440811','广东省.湛江市.麻章区','GDSZJSMZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440823,'440823','广东省.湛江市.遂溪县','GDSZJSSXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440825,'440825','广东省.湛江市.徐闻县','GDSZJSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440881,'440881','广东省.湛江市.廉江市','GDSZJSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440882,'440882','广东省.湛江市.雷州市','GDSZJSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440883,'440883','广东省.湛江市.吴川市','GDSZJSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440900,'440900','广东省.茂名市','GDSMMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440902,'440902','广东省.茂名市.茂南区','GDSMMSMNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440903,'440903','广东省.茂名市.茂港区','GDSMMSMGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440923,'440923','广东省.茂名市.电白县','GDSMMSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440981,'440981','广东省.茂名市.高州市','GDSMMSGZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440982,'440982','广东省.茂名市.化州市','GDSMMSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,440983,'440983','广东省.茂名市.信宜市','GDSMMSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441200,'441200','广东省.肇庆市','GDSZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441202,'441202','广东省.肇庆市.端州区','GDSZQSDZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441203,'441203','广东省.肇庆市.鼎湖区','GDSZQSDHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441223,'441223','广东省.肇庆市.广宁县','GDSZQSGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441224,'441224','广东省.肇庆市.怀集县','GDSZQSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441225,'441225','广东省.肇庆市.封开县','GDSZQSFKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441226,'441226','广东省.肇庆市.德庆县','GDSZQSDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441283,'441283','广东省.肇庆市.高要市','GDSZQSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441284,'441284','广东省.肇庆市.四会市','GDSZQSSHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441300,'441300','广东省.惠州市','GDSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441302,'441302','广东省.惠州市.惠城区','GDSHZSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441303,'441303','广东省.惠州市.惠阳区','GDSHZSHYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441322,'441322','广东省.惠州市.博罗县','GDSHZSBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441323,'441323','广东省.惠州市.惠东县','GDSHZSHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441324,'441324','广东省.惠州市.龙门县','GDSHZSLMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441400,'441400','广东省.梅州市','GDSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441402,'441402','广东省.梅州市.梅江区','GDSMZSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441421,'441421','广东省.梅州市.梅县','GDSMZSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441422,'441422','广东省.梅州市.大埔县','GDSMZSDPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441423,'441423','广东省.梅州市.丰顺县','GDSMZSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441424,'441424','广东省.梅州市.五华县','GDSMZSWHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441426,'441426','广东省.梅州市.平远县','GDSMZSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441427,'441427','广东省.梅州市.蕉岭县','GDSMZSJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441481,'441481','广东省.梅州市.兴宁市','GDSMZSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441500,'441500','广东省.汕尾市','GDSSWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441502,'441502','广东省.汕尾市.城区','GDSSWSCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441521,'441521','广东省.汕尾市.海丰县','GDSSWSHFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441523,'441523','广东省.汕尾市.陆河县','GDSSWSLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441581,'441581','广东省.汕尾市.陆丰市','GDSSWSLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441600,'441600','广东省.河源市','GDSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441602,'441602','广东省.河源市.源城区','GDSHYSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441621,'441621','广东省.河源市.紫金县','GDSHYSZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441622,'441622','广东省.河源市.龙川县','GDSHYSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441623,'441623','广东省.河源市.连平县','GDSHYSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441624,'441624','广东省.河源市.和平县','GDSHYSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441625,'441625','广东省.河源市.东源县','GDSHYSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441700,'441700','广东省.阳江市','GDSYJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441702,'441702','广东省.阳江市.江城区','GDSYJSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441721,'441721','广东省.阳江市.阳西县','GDSYJSYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441723,'441723','广东省.阳江市.阳东县','GDSYJSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441781,'441781','广东省.阳江市.阳春市','GDSYJSYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441800,'441800','广东省.清远市','GDSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441802,'441802','广东省.清远市.清城区','GDSQYSQCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441821,'441821','广东省.清远市.佛冈县','GDSQYSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441823,'441823','广东省.清远市.阳山县','GDSQYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441825,'441825','广东省.清远市.连山县','GDSQYSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441826,'441826','广东省.清远市.连南瑶族自治县','GDSQYSLNYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441827,'441827','广东省.清远市.清新县','GDSQYSQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441881,'441881','广东省.清远市.英德市','GDSQYSYDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441882,'441882','广东省.清远市.连州市','GDSQYSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,441900,'441900','广东省.东莞市东莞市','GDSDZSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,442000,'442000','广东省.中山市中山市','GDSZSSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445100,'445100','广东省.潮州市','GDSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445102,'445102','广东省.潮州市.湘桥区','GDSCZSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445121,'445121','广东省.潮州市.潮安县','GDSCZSCAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445122,'445122','广东省.潮州市.饶平县','GDSCZSRPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445200,'445200','广东省.揭阳市','GDSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445202,'445202','广东省.揭阳市.榕城区','GDSJYSZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445221,'445221','广东省.揭阳市.揭东县','GDSJYSJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445222,'445222','广东省.揭阳市.揭西县','GDSJYSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445224,'445224','广东省.揭阳市.惠来县','GDSJYSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445281,'445281','广东省.揭阳市.普宁市','GDSJYSPNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445300,'445300','广东省.云浮市','GDSYFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445302,'445302','广东省.云浮市.云城区','GDSYFSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445321,'445321','广东省.云浮市.新兴县','GDSYFSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445322,'445322','广东省.云浮市.郁南县','GDSYFSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445323,'445323','广东省.云浮市.云安县','GDSYFSYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,445381,'445381','广东省.云浮市.罗定市','GDSYFSLDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450000,'450000','广西','GX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450100,'450100','广西.南宁市','GXNNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450102,'450102','广西.南宁市.兴宁区','GXNNSXNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450103,'450103','广西.南宁市.青秀区','GXNNSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450105,'450105','广西.南宁市.江南区','GXNNSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450107,'450107','广西.南宁市.西乡塘区','GXNNSXXTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450108,'450108','广西.南宁市.良庆区','GXNNSLQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450109,'450109','广西.南宁市.邕宁区','GXNNSZNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450122,'450122','广西.南宁市.武鸣县','GXNNSWMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450123,'450123','广西.南宁市.隆安县','GXNNSLAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450124,'450124','广西.南宁市.马山县','GXNNSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450125,'450125','广西.南宁市.上林县','GXNNSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450126,'450126','广西.南宁市.宾阳县','GXNNSBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450127,'450127','广西.南宁市.横县','GXNNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450200,'450200','广西.柳州市','GXLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450202,'450202','广西.柳州市.城中区','GXLZSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450203,'450203','广西.柳州市.鱼峰区','GXLZSYFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450204,'450204','广西.柳州市.柳南区','GXLZSLNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450205,'450205','广西.柳州市.柳北区','GXLZSLBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450221,'450221','广西.柳州市.柳江县','GXLZSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450222,'450222','广西.柳州市.柳城县','GXLZSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450223,'450223','广西.柳州市.鹿寨县','GXLZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450224,'450224','广西.柳州市.融安县','GXLZSRAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450225,'450225','广西.柳州市.融水苗族自治县','GXLZSRSMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450226,'450226','广西.柳州市.三江侗族自治县','GXLZSSJDZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450300,'450300','广西.桂林市','GXGLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450302,'450302','广西.桂林市.秀峰区','GXGLSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450303,'450303','广西.桂林市.叠彩区','GXGLSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450304,'450304','广西.桂林市.象山区','GXGLSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450305,'450305','广西.桂林市.七星区','GXGLSQXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450311,'450311','广西.桂林市.雁山区','GXGLSYSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450321,'450321','广西.桂林市.阳朔县','GXGLSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450322,'450322','广西.桂林市.临桂县','GXGLSLGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450323,'450323','广西.桂林市.灵川县','GXGLSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450324,'450324','广西.桂林市.全州县','GXGLSQZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450325,'450325','广西.桂林市.兴安县','GXGLSXAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450326,'450326','广西.桂林市.永福县','GXGLSYFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450327,'450327','广西.桂林市.灌阳县','GXGLSGYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450328,'450328','广西.桂林市.龙胜各族自治县','GXGLSLSGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450329,'450329','广西.桂林市.资源县','GXGLSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450330,'450330','广西.桂林市.平乐县','GXGLSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450331,'450331','广西.桂林市.荔蒲县','GXGLSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450332,'450332','广西.桂林市.恭城瑶族自治县','GXGLSGCYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450400,'450400','广西.梧州市','GXWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450403,'450403','广西.梧州市.万秀区','GXWZSWXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450404,'450404','广西.梧州市.蝶山区','GXWZSDSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450405,'450405','广西.梧州市.长洲区','GXWZSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450421,'450421','广西.梧州市.苍梧县','GXWZSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450422,'450422','广西.梧州市.藤县','GXWZSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450423,'450423','广西.梧州市.蒙山县','GXWZSMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450481,'450481','广西.梧州市.岑溪市','GXWZSZXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450500,'450500','广西.北海市','GXBHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450502,'450502','广西.北海市.海城区','GXBHSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450503,'450503','广西.北海市.银海区','GXBHSYHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450512,'450512','广西.北海市.铁山港区','GXBHSTSGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450521,'450521','广西.北海市.合浦县','GXBHSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450600,'450600','广西.防城港市','GXFCGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450602,'450602','广西.防城港市.港口区','GXFCGSGKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450603,'450603','广西.防城港市.防城区','GXFCGSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450621,'450621','广西.防城港市.上思县','GXFCGSSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450681,'450681','广西.防城港市.东兴市','GXFCGSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450700,'450700','广西.钦州市','GXQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450702,'450702','广西.钦州市.钦南区','GXQZSQNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450703,'450703','广西.钦州市.钦北区','GXQZSQBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450721,'450721','广西.钦州市.灵山县','GXQZSLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450722,'450722','广西.钦州市.浦北县','GXQZSPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450800,'450800','广西.贵港市','GXGGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450802,'450802','广西.贵港市.港北区','GXGGSGBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450803,'450803','广西.贵港市.港南区','GXGGSGNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450804,'450804','广西.贵港市.覃塘区','GXGGSZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450821,'450821','广西.贵港市.平南县','GXGGSPNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450881,'450881','广西.贵港市.桂平市','GXGGSGPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450900,'450900','广西.玉林市','GXYLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450902,'450902','广西.玉林市.玉州区','GXYLSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450921,'450921','广西.玉林市.容县','GXYLSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450922,'450922','广西.玉林市.陆川县','GXYLSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450923,'450923','广西.玉林市.博白县','GXYLSBBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450924,'450924','广西.玉林市.兴业县','GXYLSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,450981,'450981','广西.玉林市.北流市','GXYLSBLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451000,'451000','广西.百色市','GXBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451002,'451002','广西.百色市.右江区','GXBSSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451021,'451021','广西.百色市.田阳县','GXBSSTYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451022,'451022','广西.百色市.田东县','GXBSSTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451023,'451023','广西.百色市.平果县','GXBSSPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451024,'451024','广西.百色市.德保县','GXBSSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451025,'451025','广西.百色市.靖西县','GXBSSJXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451026,'451026','广西.百色市.那坡县','GXBSSNPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451027,'451027','广西.百色市.凌云县','GXBSSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451028,'451028','广西.百色市.乐业县','GXBSSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451029,'451029','广西.百色市.田林县','GXBSSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451030,'451030','广西.百色市.西林县','GXBSSXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451031,'451031','广西.百色市.隆林各族自治县','GXBSSLLGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451100,'451100','广西.贺州市','GXHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451102,'451102','广西.贺州市.八步区','GXHZSBBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451121,'451121','广西.贺州市.昭平县','GXHZSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451122,'451122','广西.贺州市.钟山县','GXHZSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451123,'451123','广西.贺州市.富川瑶族自治县','GXHZSFCYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451200,'451200','广西.河池市','GXHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451202,'451202','广西.河池市.金城江区','GXHCSJCJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451221,'451221','广西.河池市.南丹县','GXHCSNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451222,'451222','广西.河池市.天峨县','GXHCSTEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451223,'451223','广西.河池市.凤山县','GXHCSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451224,'451224','广西.河池市.东兰县','GXHCSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451225,'451225','广西.河池市.罗城仫佬族自治县','GXHCSLCZLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451226,'451226','广西.河池市.环江毛南族自治县','GXHCSHJMNZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451227,'451227','广西.河池市.巴马瑶族自治县','GXHCSBMYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451228,'451228','广西.河池市.都安瑶族自治县','GXHCSDAYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451229,'451229','广西.河池市.大化瑶族自治县','GXHCSDHYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451281,'451281','广西.河池市.宜州市','GXHCSYZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451300,'451300','广西.来宾市','GXLBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451302,'451302','广西.来宾市.兴宾区','GXLBSXBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451321,'451321','广西.来宾市.忻城县','GXLBSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451322,'451322','广西.来宾市.象州县','GXLBSXZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451323,'451323','广西.来宾市.武宣县','GXLBSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451324,'451324','广西.来宾市.金秀瑶族自治县','GXLBSJXYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451381,'451381','广西.来宾市.合山市','GXLBSHSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451400,'451400','广西.崇左市','GXCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451402,'451402','广西.崇左市.江洲区','GXCZSJZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451421,'451421','广西.崇左市.扶绥县','GXCZSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451422,'451422','广西.崇左市.宁明县','GXCZSNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451423,'451423','广西.崇左市.龙州县','GXCZSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451424,'451424','广西.崇左市.大新县','GXCZSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451425,'451425','广西.崇左市.天等县','GXCZSTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,451481,'451481','广西.崇左市.凭祥市','GXCZSPXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460000,'460000','海南省','HNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460100,'460100','海南省.海口市','HNSHKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460105,'460105','海南省.海口市.秀英区','HNSHKSXYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460106,'460106','海南省.海口市.龙华区','HNSHKSLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460107,'460107','海南省.海口市.琼山区','HNSHKSQSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460108,'460108','海南省.海口市.美兰区','HNSHKSMLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,460200,'460200','海南省.三亚市','HNSSYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469001,'469001','海南省.五指山市','HNSWZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469002,'469002','海南省.琼海市','HNSQHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469003,'469003','海南省.儋州市','HNSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469005,'469005','海南省.文昌市','HNSWCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469006,'469006','海南省.万宁市','HNSWNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469007,'469007','海南省.东方市','HNSDFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469021,'469021','海南省.定安县','HNSDAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469022,'469022','海南省.屯昌县','HNSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469023,'469023','海南省.澄迈县','HNSCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469024,'469024','海南省.临高县','HNSLGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469025,'469025','海南省.白沙黎族自治县','HNSBSLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469026,'469026','海南省.昌江黎族自治县','HNSCJLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469027,'469027','海南省.乐东黎族自治县','HNSLDLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469028,'469028','海南省.陵水黎族自治县','HNSLSLZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469029,'469029','海南省.保亭黎族苗族自治县','HNSBTLZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469030,'469030','海南省.琼中黎族苗族自治县','HNSQZLZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469031,'469031','海南省.西沙群岛','HNSXSQD'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469032,'469032','海南省.南沙群岛','HNSNSQD'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,469033,'469033','海南省.中沙群岛的岛礁及其海域','HNSZSQDDDJJQHY'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500000,'500000','重庆市','ZQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500101,'500101','重庆市.万州区','ZQSWZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500102,'500102','重庆市.涪陵区','ZQSFLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500103,'500103','重庆市.渝中区','ZQSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500104,'500104','重庆市.大渡口区','ZQSDDKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500105,'500105','重庆市.江北区','ZQSJBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500106,'500106','重庆市.沙坪坝区','ZQSSPBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500107,'500107','重庆市.九龙坡区','ZQSJLPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500108,'500108','重庆市.南岸区','ZQSNAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500109,'500109','重庆市.北碚区','ZQSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500110,'500110','重庆市.万盛区','ZQSWSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500111,'500111','重庆市.双桥区','ZQSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500112,'500112','重庆市.渝北区','ZQSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500113,'500113','重庆市.巴南区','ZQSBNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500114,'500114','重庆市.黔江区','ZQSQJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500115,'500115','重庆市.长寿区','ZQSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500116,'500116','重庆市.江津区','ZQSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500117,'500117','重庆市.合川区','ZQSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500118,'500118','重庆市.永川区','ZQSYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500119,'500119','重庆市.南川区','ZQSNCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500222,'500222','重庆市.綦江县','ZQSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500223,'500223','重庆市.潼南县','ZQSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500224,'500224','重庆市.铜梁县','ZQSTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500225,'500225','重庆市.大足县','ZQSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500226,'500226','重庆市.荣昌县','ZQSRCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500227,'500227','重庆市.璧山县','ZQSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500228,'500228','重庆市.梁平县','ZQSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500229,'500229','重庆市.城口县','ZQSCKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500230,'500230','重庆市.丰都县','ZQSFDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500231,'500231','重庆市.垫江县','ZQSDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500232,'500232','重庆市.武隆县','ZQSWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500233,'500233','重庆市.忠县','ZQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500234,'500234','重庆市.开县','ZQSKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500235,'500235','重庆市.云阳县','ZQSYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500236,'500236','重庆市.奉节县','ZQSFJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500237,'500237','重庆市.巫山县','ZQSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500238,'500238','重庆市.巫溪县','ZQSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500240,'500240','重庆市.石柱土家族自治县','ZQSSZTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500241,'500241','重庆市.秀山土家族苗族自治县','ZQSXSTJZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500242,'500242','重庆市.酉阳土家族苗族自治县','ZQSYYTJZMZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,500243,'500243','重庆市.彭水苗族土家族自治县','ZQSPSMZTJZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510000,'510000','四川省','SCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510100,'510100','四川省.成都市','SCSCDS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510104,'510104','四川省.成都市.锦江区','SCSCDSJJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510105,'510105','四川省.成都市.青羊区','SCSCDSQYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510106,'510106','四川省.成都市.金牛区','SCSCDSJNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510107,'510107','四川省.成都市.武侯区','SCSCDSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510108,'510108','四川省.成都市.成华区','SCSCDSCHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510112,'510112','四川省.成都市.龙泉驿区','SCSCDSLQZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510113,'510113','四川省.成都市.青白江区','SCSCDSQBJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510114,'510114','四川省.成都市.新都区','SCSCDSXDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510115,'510115','四川省.成都市.温江区','SCSCDSWJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510121,'510121','四川省.成都市.金堂县','SCSCDSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510122,'510122','四川省.成都市.双流县','SCSCDSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510124,'510124','四川省.成都市.郫县','SCSCDSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510129,'510129','四川省.成都市.大邑县','SCSCDSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510131,'510131','四川省.成都市.蒲江县','SCSCDSPJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510132,'510132','四川省.成都市.新津县','SCSCDSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510181,'510181','四川省.成都市.都江堰市','SCSCDSDJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510182,'510182','四川省.成都市.彭州市','SCSCDSPZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510183,'510183','四川省.成都市.邛崃市','SCSCDSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510184,'510184','四川省.成都市.崇州市','SCSCDSCZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510300,'510300','四川省.自贡市','SCSZGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510302,'510302','四川省.自贡市.自流井区','SCSZGSZLJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510303,'510303','四川省.自贡市.贡井区','SCSZGSGJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510304,'510304','四川省.自贡市.大安区','SCSZGSDAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510311,'510311','四川省.自贡市.沿滩区','SCSZGSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510321,'510321','四川省.自贡市.荣县','SCSZGSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510322,'510322','四川省.自贡市.富顺县','SCSZGSFSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510400,'510400','四川省.攀枝花市','SCSPZHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510402,'510402','四川省.攀枝花市.东区','SCSPZHSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510403,'510403','四川省.攀枝花市.西区','SCSPZHSXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510411,'510411','四川省.攀枝花市.仁和区','SCSPZHSRHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510421,'510421','四川省.攀枝花市.米易县','SCSPZHSMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510422,'510422','四川省.攀枝花市.盐边县','SCSPZHSYBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510500,'510500','四川省.泸州市','SCSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510502,'510502','四川省.泸州市.江阳区','SCSZZSJYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510503,'510503','四川省.泸州市.纳溪区','SCSZZSNXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510504,'510504','四川省.泸州市.龙马潭区','SCSZZSLMTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510521,'510521','四川省.泸州市.泸县','SCSZZSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510522,'510522','四川省.泸州市.合江县','SCSZZSHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510524,'510524','四川省.泸州市.叙永县','SCSZZSXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510525,'510525','四川省.泸州市.古蔺县','SCSZZSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510600,'510600','四川省.德阳市','SCSDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510603,'510603','四川省.德阳市.旌阳区','SCSDYSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510623,'510623','四川省.德阳市.中江县','SCSDYSZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510626,'510626','四川省.德阳市.罗江县','SCSDYSLJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510681,'510681','四川省.德阳市.广汉市','SCSDYSGHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510682,'510682','四川省.德阳市.什邡市','SCSDYSSZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510683,'510683','四川省.德阳市.绵竹市','SCSDYSMZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510700,'510700','四川省.绵阳市','SCSMYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510703,'510703','四川省.绵阳市.涪城区','SCSMYSFCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510704,'510704','四川省.绵阳市.游仙区','SCSMYSYXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510722,'510722','四川省.绵阳市.三台县','SCSMYSSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510723,'510723','四川省.绵阳市.盐亭县','SCSMYSYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510724,'510724','四川省.绵阳市.安县','SCSMYSAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510725,'510725','四川省.绵阳市.梓潼县','SCSMYSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510726,'510726','四川省.绵阳市.北川羌族自治县','SCSMYSBCQZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510727,'510727','四川省.绵阳市.平武县','SCSMYSPWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510781,'510781','四川省.绵阳市.江油市','SCSMYSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510800,'510800','四川省.广元市','SCSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510802,'510802','四川省.广元市.利州区','SCSGYSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510811,'510811','四川省.广元市.元坝区','SCSGYSYBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510812,'510812','四川省.广元市.朝天区','SCSGYSCTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510821,'510821','四川省.广元市.旺苍县','SCSGYSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510822,'510822','四川省.广元市.青川县','SCSGYSQCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510823,'510823','四川省.广元市.剑阁县','SCSGYSJGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510824,'510824','四川省.广元市.苍溪县','SCSGYSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510900,'510900','四川省.遂宁市','SCSSNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510903,'510903','四川省.遂宁市.船山区','SCSSNSCSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510904,'510904','四川省.遂宁市.安居区','SCSSNSAJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510921,'510921','四川省.遂宁市.蓬溪县','SCSSNSPXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510922,'510922','四川省.遂宁市.射洪县','SCSSNSSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,510923,'510923','四川省.遂宁市.大英县','SCSSNSDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511000,'511000','四川省.内江市','SCSNJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511002,'511002','四川省.内江市.市中区','SCSNJSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511011,'511011','四川省.内江市.东兴区','SCSNJSDXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511024,'511024','四川省.内江市.威远县','SCSNJSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511025,'511025','四川省.内江市.资中县','SCSNJSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511028,'511028','四川省.内江市.隆昌县','SCSNJSLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511100,'511100','四川省.乐山市','SCSLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511102,'511102','四川省.乐山市.市中区','SCSLSSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511111,'511111','四川省.乐山市.沙湾区','SCSLSSSWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511112,'511112','四川省.乐山市.五通桥区','SCSLSSWTQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511113,'511113','四川省.乐山市.金口河区','SCSLSSJKHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511123,'511123','四川省.乐山市.犍为县','SCSLSSZWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511124,'511124','四川省.乐山市.井研县','SCSLSSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511126,'511126','四川省.乐山市.夹江县','SCSLSSJJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511129,'511129','四川省.乐山市.沐川县','SCSLSSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511132,'511132','四川省.乐山市.峨边彝族自治县','SCSLSSEBYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511133,'511133','四川省.乐山市.马边彝族自治县','SCSLSSMBYZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511181,'511181','四川省.乐山市.峨眉山市','SCSLSSEMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511300,'511300','四川省.南充市','SCSNCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511302,'511302','四川省.南充市.顺庆区','SCSNCSSQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511303,'511303','四川省.南充市.高坪区','SCSNCSGPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511304,'511304','四川省.南充市.嘉陵区','SCSNCSJLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511321,'511321','四川省.南充市.南部县','SCSNCSNBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511322,'511322','四川省.南充市.营山县','SCSNCSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511323,'511323','四川省.南充市.蓬安县','SCSNCSPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511324,'511324','四川省.南充市.仪陇县','SCSNCSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511325,'511325','四川省.南充市.西充县','SCSNCSXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511381,'511381','四川省.南充市.阆中市','SCSNCSZZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511400,'511400','四川省.眉山市','SCSMSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511402,'511402','四川省.眉山市.东坡区','SCSMSSDPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511421,'511421','四川省.眉山市.仁寿县','SCSMSSRSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511422,'511422','四川省.眉山市.彭山县','SCSMSSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511423,'511423','四川省.眉山市.洪雅县','SCSMSSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511424,'511424','四川省.眉山市.丹棱县','SCSMSSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511425,'511425','四川省.眉山市.青神县','SCSMSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511500,'511500','四川省.宜宾市','SCSYBS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511502,'511502','四川省.宜宾市.翠屏区','SCSYBSCPQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511521,'511521','四川省.宜宾市.宜宾县','SCSYBSYBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511522,'511522','四川省.宜宾市.南溪县','SCSYBSNXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511523,'511523','四川省.宜宾市.江安县','SCSYBSJAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511524,'511524','四川省.宜宾市.长宁县','SCSYBSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511525,'511525','四川省.宜宾市.高县','SCSYBSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511526,'511526','四川省.宜宾市.珙县','SCSYBSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511527,'511527','四川省.宜宾市.筠连县','SCSYBS筠LX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511528,'511528','四川省.宜宾市.兴文县','SCSYBSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511529,'511529','四川省.宜宾市.屏山县','SCSYBSPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511600,'511600','四川省.广安市','SCSGAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511602,'511602','四川省.广安市.广安区','SCSGASGAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511621,'511621','四川省.广安市.岳池县','SCSGASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511622,'511622','四川省.广安市.武胜县','SCSGASWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511623,'511623','四川省.广安市.邻水县','SCSGASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511681,'511681','四川省.广安市.华蓥市','SCSGASHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511700,'511700','四川省.达州市','SCSDZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511702,'511702','四川省.达州市.通川区','SCSDZSTCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511721,'511721','四川省.达州市.达县','SCSDZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511722,'511722','四川省.达州市.宣汉县','SCSDZSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511723,'511723','四川省.达州市.开江县','SCSDZSKJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511724,'511724','四川省.达州市.大竹县','SCSDZSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511725,'511725','四川省.达州市.渠县','SCSDZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511781,'511781','四川省.达州市.万源市','SCSDZSWYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511800,'511800','四川省.雅安市','SCSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511802,'511802','四川省.雅安市.雨城区','SCSYASYCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511821,'511821','四川省.雅安市.名山县','SCSYASMSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511822,'511822','四川省.雅安市.荥经县','SCSYASZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511823,'511823','四川省.雅安市.汉源县','SCSYASHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511824,'511824','四川省.雅安市.石棉县','SCSYASSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511825,'511825','四川省.雅安市.天全县','SCSYASTQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511826,'511826','四川省.雅安市.芦山县','SCSYASLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511827,'511827','四川省.雅安市.宝兴县','SCSYASBXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511900,'511900','四川省.巴中市','SCSBZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511902,'511902','四川省.巴中市.巴州区','SCSBZSBZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511921,'511921','四川省.巴中市.通江县','SCSBZSTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511922,'511922','四川省.巴中市.南江县','SCSBZSNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,511923,'511923','四川省.巴中市.平昌县','SCSBZSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512000,'512000','四川省.资阳市','SCSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512002,'512002','四川省.资阳市.雁江区','SCSZYSYJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512021,'512021','四川省.资阳市.安岳县','SCSZYSAYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512022,'512022','四川省.资阳市.乐至县','SCSZYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,512081,'512081','四川省.资阳市.简阳市','SCSZYSJYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513200,'513200','四川省.阿坝州','SCSABZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513221,'513221','四川省.阿坝州.汶川县','SCSABZZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513222,'513222','四川省.阿坝州.理县','SCSABZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513223,'513223','四川省.阿坝州.茂县','SCSABZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513224,'513224','四川省.阿坝州.松潘县','SCSABZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513225,'513225','四川省.阿坝州.九寨沟县','SCSABZJZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513226,'513226','四川省.阿坝州.金川县','SCSABZJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513227,'513227','四川省.阿坝州.小金县','SCSABZXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513228,'513228','四川省.阿坝州.黑水县','SCSABZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513229,'513229','四川省.阿坝州.马尔康县','SCSABZMEKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513230,'513230','四川省.阿坝州.壤塘县','SCSABZRTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513231,'513231','四川省.阿坝州.阿坝县','SCSABZABX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513232,'513232','四川省.阿坝州.若尔盖县','SCSABZREGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513233,'513233','四川省.阿坝州.红原县','SCSABZHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513300,'513300','四川省.甘孜州','SCSGZZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513321,'513321','四川省.甘孜州.康定县','SCSGZZKDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513322,'513322','四川省.甘孜州.泸定县','SCSGZZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513323,'513323','四川省.甘孜州.丹巴县','SCSGZZDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513324,'513324','四川省.甘孜州.九龙县','SCSGZZJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513325,'513325','四川省.甘孜州.雅江县','SCSGZZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513326,'513326','四川省.甘孜州.道孚县','SCSGZZDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513327,'513327','四川省.甘孜州.炉霍县','SCSGZZLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513328,'513328','四川省.甘孜州.甘孜县','SCSGZZGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513329,'513329','四川省.甘孜州.新龙县','SCSGZZXLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513330,'513330','四川省.甘孜州.德格县','SCSGZZDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513331,'513331','四川省.甘孜州.白玉县','SCSGZZBYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513332,'513332','四川省.甘孜州.石渠县','SCSGZZSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513333,'513333','四川省.甘孜州.色达县','SCSGZZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513334,'513334','四川省.甘孜州.理塘县','SCSGZZLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513335,'513335','四川省.甘孜州.巴塘县','SCSGZZBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513336,'513336','四川省.甘孜州.乡城县','SCSGZZXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513337,'513337','四川省.甘孜州.稻城县','SCSGZZDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513338,'513338','四川省.甘孜州.得荣县','SCSGZZDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513400,'513400','四川省.凉山州.凉山州','SCSLSZLSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513401,'513401','四川省.凉山州.西昌市','SCSLSZXCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513422,'513422','四川省.凉山州.木里藏族自治县','SCSLSZMLCZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513423,'513423','四川省.凉山州.盐源县','SCSLSZYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513424,'513424','四川省.凉山州.德昌县','SCSLSZDCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513425,'513425','四川省.凉山州.会理县','SCSLSZHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513426,'513426','四川省.凉山州.会东县','SCSLSZHDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513427,'513427','四川省.凉山州.宁南县','SCSLSZNNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513428,'513428','四川省.凉山州.普格县','SCSLSZPGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513429,'513429','四川省.凉山州.布拖县','SCSLSZBTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513430,'513430','四川省.凉山州.金阳县','SCSLSZJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513431,'513431','四川省.凉山州.昭觉县','SCSLSZZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513432,'513432','四川省.凉山州.喜德县','SCSLSZXDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513433,'513433','四川省.凉山州.冕宁县','SCSLSZMNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513434,'513434','四川省.凉山州.越西县','SCSLSZYXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513435,'513435','四川省.凉山州.甘洛县','SCSLSZGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513436,'513436','四川省.凉山州.美姑县','SCSLSZMGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,513437,'513437','四川省.凉山州.雷波县','SCSLSZLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520000,'520000','贵州省','GZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520100,'520100','贵州省.贵阳市','GZSGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520102,'520102','贵州省.贵阳市.南明区','GZSGYSNMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520103,'520103','贵州省.贵阳市.云岩区','GZSGYSYYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520111,'520111','贵州省.贵阳市.花溪区','GZSGYSHXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520112,'520112','贵州省.贵阳市.乌当区','GZSGYSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520113,'520113','贵州省.贵阳市.白云区','GZSGYSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520114,'520114','贵州省.贵阳市.小河区','GZSGYSXHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520121,'520121','贵州省.贵阳市.开阳县','GZSGYSKYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520122,'520122','贵州省.贵阳市.息烽县','GZSGYSXFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520123,'520123','贵州省.贵阳市.修文县','GZSGYSXWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520181,'520181','贵州省.贵阳市.清镇市','GZSGYSQZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520200,'520200','贵州省.六盘水市.六盘水市','GZSLPSSLPSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520201,'520201','贵州省.六盘水市.钟山区','GZSLPSSZSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520203,'520203','贵州省.六盘水市.六枝特区','GZSLPSSLZTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520221,'520221','贵州省.六盘水市.水城县','GZSLPSSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520222,'520222','贵州省.六盘水市.盘县','GZSLPSSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520300,'520300','贵州省.遵义市','GZSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520302,'520302','贵州省.遵义市.红花岗区','GZSZYSHHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520303,'520303','贵州省.遵义市.汇川区','GZSZYSHCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520321,'520321','贵州省.遵义市.遵义县','GZSZYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520322,'520322','贵州省.遵义市.桐梓县','GZSZYSTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520323,'520323','贵州省.遵义市.绥阳县','GZSZYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520324,'520324','贵州省.遵义市.正安县','GZSZYSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520325,'520325','贵州省.遵义市.道真县','GZSZYSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520326,'520326','贵州省.遵义市.务川县','GZSZYSWCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520327,'520327','贵州省.遵义市.凤冈县','GZSZYSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520328,'520328','贵州省.遵义市.湄潭县','GZSZYSZTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520329,'520329','贵州省.遵义市.余庆县','GZSZYSYQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520330,'520330','贵州省.遵义市.习水县','GZSZYSXSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520381,'520381','贵州省.遵义市.赤水市','GZSZYSCSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520382,'520382','贵州省.遵义市.仁怀市','GZSZYSRHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520400,'520400','贵州省.安顺市','GZSASS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520402,'520402','贵州省.安顺市.西秀区','GZSASSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520421,'520421','贵州省.安顺市.平坝县','GZSASSPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520422,'520422','贵州省.安顺市.普定县','GZSASSPDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520423,'520423','贵州省.安顺市.镇宁县','GZSASSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520424,'520424','贵州省.安顺市.关岭县','GZSASSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,520425,'520425','贵州省.安顺市.紫云自治县','GZSASSZYZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522200,'522200','贵州省.铜仁地区.铜仁地区','GZSTRDQTRDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522201,'522201','贵州省.铜仁地区.铜仁市','GZSTRDQTRS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522222,'522222','贵州省.铜仁地区.江口县','GZSTRDQJKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522223,'522223','贵州省.铜仁地区.玉屏县','GZSTRDQYPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522224,'522224','贵州省.铜仁地区.石阡县','GZSTRDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522225,'522225','贵州省.铜仁地区.思南县','GZSTRDQSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522226,'522226','贵州省.铜仁地区.印江县','GZSTRDQYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522227,'522227','贵州省.铜仁地区.德江县','GZSTRDQDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522228,'522228','贵州省.铜仁地区.沿河县','GZSTRDQYHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522229,'522229','贵州省.铜仁地区.松桃县','GZSTRDQSTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522230,'522230','贵州省.铜仁地区.万山特区','GZSTRDQWSTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522300,'522300','贵州省.黔西南','GZSQXN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522301,'522301','贵州省.黔西南.兴义市','GZSQXNXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522322,'522322','贵州省.黔西南.兴仁县','GZSQXNXRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522323,'522323','贵州省.黔西南.普安县','GZSQXNPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522324,'522324','贵州省.黔西南.晴隆县','GZSQXNQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522325,'522325','贵州省.黔西南.贞丰县','GZSQXNZFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522326,'522326','贵州省.黔西南.望谟县','GZSQXNWZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522327,'522327','贵州省.黔西南.册亨县','GZSQXNCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522328,'522328','贵州省.黔西南.安龙县','GZSQXNALX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522400,'522400','贵州省.毕节地区','GZSBJDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522401,'522401','贵州省.毕节地区.毕节市','GZSBJDQBJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522422,'522422','贵州省.毕节地区.大方县','GZSBJDQDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522423,'522423','贵州省.毕节地区.黔西县','GZSBJDQQXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522424,'522424','贵州省.毕节地区.金沙县','GZSBJDQJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522425,'522425','贵州省.毕节地区.织金县','GZSBJDQZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522426,'522426','贵州省.毕节地区.纳雍县','GZSBJDQNYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522427,'522427','贵州省.毕节地区.威宁县','GZSBJDQWNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522428,'522428','贵州省.毕节地区.赫章县','GZSBJDQHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522600,'522600','贵州省.黔东南','GZSQDN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522601,'522601','贵州省.黔东南.凯里市','GZSQDNKLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522622,'522622','贵州省.黔东南.黄平县','GZSQDNHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522623,'522623','贵州省.黔东南.施秉县','GZSQDNSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522624,'522624','贵州省.黔东南.三穗县','GZSQDNSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522625,'522625','贵州省.黔东南.镇远县','GZSQDNZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522626,'522626','贵州省.黔东南.岑巩县','GZSQDNZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522627,'522627','贵州省.黔东南.天柱县','GZSQDNTZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522628,'522628','贵州省.黔东南.锦屏县','GZSQDNJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522629,'522629','贵州省.黔东南.剑河县','GZSQDNJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522630,'522630','贵州省.黔东南.台江县','GZSQDNTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522631,'522631','贵州省.黔东南.黎平县','GZSQDNLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522632,'522632','贵州省.黔东南.榕江县','GZSQDNZJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522633,'522633','贵州省.黔东南.从江县','GZSQDNCJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522634,'522634','贵州省.黔东南.雷山县','GZSQDNLSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522635,'522635','贵州省.黔东南.麻江县','GZSQDNMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522636,'522636','贵州省.黔东南.丹寨县','GZSQDNDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522700,'522700','贵州省.黔南州','GZSQNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522701,'522701','贵州省.黔南州.都匀市','GZSQNZDYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522702,'522702','贵州省.黔南州.福泉市','GZSQNZFQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522722,'522722','贵州省.黔南州.荔波县','GZSQNZLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522723,'522723','贵州省.黔南州.贵定县','GZSQNZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522725,'522725','贵州省.黔南州.瓮安县','GZSQNZWAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522726,'522726','贵州省.黔南州.独山县','GZSQNZDSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522727,'522727','贵州省.黔南州.平塘县','GZSQNZPTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522728,'522728','贵州省.黔南州.罗甸县','GZSQNZLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522729,'522729','贵州省.黔南州.长顺县','GZSQNZCSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522730,'522730','贵州省.黔南州.龙里县','GZSQNZLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522731,'522731','贵州省.黔南州.惠水县','GZSQNZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,522732,'522732','贵州省.黔南州.三都县','GZSQNZSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530000,'530000','云南省','YNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530100,'530100','云南省.昆明市','YNSKMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530102,'530102','云南省.昆明市.五华区','YNSKMSWHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530103,'530103','云南省.昆明市.盘龙区','YNSKMSPLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530111,'530111','云南省.昆明市.官渡区','YNSKMSGDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530112,'530112','云南省.昆明市.西山区','YNSKMSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530113,'530113','云南省.昆明市.东川区','YNSKMSDCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530121,'530121','云南省.昆明市.呈贡县','YNSKMSCGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530122,'530122','云南省.昆明市.晋宁县','YNSKMSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530124,'530124','云南省.昆明市.富民县','YNSKMSFMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530125,'530125','云南省.昆明市.宜良县','YNSKMSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530126,'530126','云南省.昆明市.石林县','YNSKMSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530127,'530127','云南省.昆明市.嵩明县','YNSKMSZMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530128,'530128','云南省.昆明市.禄劝县','YNSKMSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530129,'530129','云南省.昆明市.寻+B2840甸县','YNSKMSXDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530181,'530181','云南省.昆明市.安宁市','YNSKMSANS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530300,'530300','云南省.曲靖市','YNSQJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530302,'530302','云南省.曲靖市.麒麟区','YNSQJSQLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530321,'530321','云南省.曲靖市.马龙县','YNSQJSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530322,'530322','云南省.曲靖市.陆良县','YNSQJSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530323,'530323','云南省.曲靖市.师宗县','YNSQJSSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530324,'530324','云南省.曲靖市.罗平县','YNSQJSLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530325,'530325','云南省.曲靖市.富源县','YNSQJSFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530326,'530326','云南省.曲靖市.会泽县','YNSQJSHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530328,'530328','云南省.曲靖市.沾益县','YNSQJSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530381,'530381','云南省.曲靖市.宣威市','YNSQJSXWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530400,'530400','云南省.玉溪市','YNSYXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530402,'530402','云南省.玉溪市.红塔区','YNSYXSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530421,'530421','云南省.玉溪市.江川县','YNSYXSJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530422,'530422','云南省.玉溪市.澄江县','YNSYXSCJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530423,'530423','云南省.玉溪市.通海县','YNSYXSTHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530424,'530424','云南省.玉溪市.华宁县','YNSYXSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530425,'530425','云南省.玉溪市.易门县','YNSYXSYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530426,'530426','云南省.玉溪市.峨山县','YNSYXSESX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530427,'530427','云南省.玉溪市.新平县','YNSYXSXPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530428,'530428','云南省.玉溪市.元江自治县','YNSYXSYJZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530500,'530500','云南省.保山市','YNSBSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530502,'530502','云南省.保山市.隆阳区','YNSBSSLYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530521,'530521','云南省.保山市.施甸县','YNSBSSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530522,'530522','云南省.保山市.腾冲县','YNSBSSTCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530523,'530523','云南省.保山市.龙陵县','YNSBSSLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530524,'530524','云南省.保山市.昌宁县','YNSBSSCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530600,'530600','云南省.昭通市','YNSZTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530602,'530602','云南省.昭通市.昭阳区','YNSZTSZYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530621,'530621','云南省.昭通市.鲁甸县','YNSZTSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530622,'530622','云南省.昭通市.巧家县','YNSZTSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530623,'530623','云南省.昭通市.盐津县','YNSZTSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530624,'530624','云南省.昭通市.大关县','YNSZTSDGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530625,'530625','云南省.昭通市.永善县','YNSZTSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530626,'530626','云南省.昭通市.绥江县','YNSZTSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530627,'530627','云南省.昭通市.镇雄县','YNSZTSZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530628,'530628','云南省.昭通市.彝良县','YNSZTSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530629,'530629','云南省.昭通市.威信县','YNSZTSWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530630,'530630','云南省.昭通市.水富县','YNSZTSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530700,'530700','云南省.丽江市','YNSLJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530702,'530702','云南省.丽江市.古城区','YNSLJSGCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530721,'530721','云南省.丽江市.玉龙县','YNSLJSYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530722,'530722','云南省.丽江市.永胜县','YNSLJSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530723,'530723','云南省.丽江市.华坪县','YNSLJSHPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530724,'530724','云南省.丽江市.宁蒗县','YNSLJSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530800,'530800','云南省.普洱市','YNSPES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530802,'530802','云南省.普洱市.思茅区','YNSPESSMQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530821,'530821','云南省.普洱市.宁洱县','YNSPESNEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530822,'530822','云南省.普洱市.墨江县','YNSPESMJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530823,'530823','云南省.普洱市.景东县','YNSPESJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530824,'530824','云南省.普洱市.景谷县','YNSPESJGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530825,'530825','云南省.普洱市.镇沅县','YNSPESZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530826,'530826','云南省.普洱市.江城县','YNSPESJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530827,'530827','云南省.普洱市.孟连县','YNSPESMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530828,'530828','云南省.普洱市.澜沧县','YNSPESLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530829,'530829','云南省.普洱市.西盟县','YNSPESXMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530900,'530900','云南省.临沧市','YNSLCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530902,'530902','云南省.临沧市.临翔区','YNSLCSLXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530921,'530921','云南省.临沧市.凤庆县','YNSLCSFQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530922,'530922','云南省.临沧市.云县','YNSLCSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530923,'530923','云南省.临沧市.永德县','YNSLCSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530924,'530924','云南省.临沧市.镇康县','YNSLCSZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530925,'530925','云南省.临沧市.双江县','YNSLCSSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530926,'530926','云南省.临沧市.耿马县','YNSLCSGMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,530927,'530927','云南省.临沧市.沧源县','YNSLCSCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532300,'532300','云南省.楚雄州','YNSCXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532301,'532301','云南省.楚雄州.楚雄市','YNSCXZCXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532322,'532322','云南省.楚雄州.双柏县','YNSCXZSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532323,'532323','云南省.楚雄州.牟定县','YNSCXZMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532324,'532324','云南省.楚雄州.南华县','YNSCXZNHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532325,'532325','云南省.楚雄州.姚安县','YNSCXZYAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532326,'532326','云南省.楚雄州.大姚县','YNSCXZDYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532327,'532327','云南省.楚雄州.永仁县','YNSCXZYRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532328,'532328','云南省.楚雄州.元谋县','YNSCXZYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532329,'532329','云南省.楚雄州.武定县','YNSCXZWDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532331,'532331','云南省.楚雄州.禄丰县','YNSCXZLFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532500,'532500','云南省.红河州','YNSHHZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532501,'532501','云南省.红河州.个旧市','YNSHHZGJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532502,'532502','云南省.红河州.开远市','YNSHHZKYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532522,'532522','云南省.红河州.蒙自县','YNSHHZMZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532523,'532523','云南省.红河州.屏边县','YNSHHZPBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532524,'532524','云南省.红河州.建水县','YNSHHZJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532525,'532525','云南省.红河州.石屏县','YNSHHZSPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532526,'532526','云南省.红河州.弥勒县','YNSHHZMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532527,'532527','云南省.红河州.泸西县','YNSHHZZXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532528,'532528','云南省.红河州.元阳县','YNSHHZYYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532529,'532529','云南省.红河州.红河县','YNSHHZHHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532530,'532530','云南省.红河州.金平县','YNSHHZJPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532531,'532531','云南省.红河州.绿春县','YNSHHZLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532532,'532532','云南省.红河州.河口县','YNSHHZHKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532600,'532600','云南省.文山州','YNSWSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532621,'532621','云南省.文山州.文山县','YNSWSZWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532622,'532622','云南省.文山州.砚山县','YNSWSZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532623,'532623','云南省.文山州.西畴县','YNSWSZXCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532624,'532624','云南省.文山州.麻栗坡县','YNSWSZMLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532625,'532625','云南省.文山州.马关县','YNSWSZMGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532626,'532626','云南省.文山州.丘北县','YNSWSZQBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532627,'532627','云南省.文山州.广南县','YNSWSZGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532628,'532628','云南省.文山州.富宁县','YNSWSZFNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532800,'532800','云南省.西双版纳','YNSXSBN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532801,'532801','云南省.西双版纳.景洪市','YNSXSBNJHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532822,'532822','云南省.西双版纳.勐海县','YNSXSBNZHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532823,'532823','云南省.西双版纳.勐腊县','YNSXSBNZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532900,'532900','云南省.大理','YNSDL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532901,'532901','云南省.大理.大理市','YNSDLDLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532922,'532922','云南省.大理.漾濞县','YNSDLYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532923,'532923','云南省.大理.祥云县','YNSDLXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532924,'532924','云南省.大理.宾川县','YNSDLBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532925,'532925','云南省.大理.弥渡县','YNSDLMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532926,'532926','云南省.大理.南涧县','YNSDLNJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532927,'532927','云南省.大理.巍山县','YNSDLWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532928,'532928','云南省.大理.永平县','YNSDLYPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532929,'532929','云南省.大理.云龙县','YNSDLYLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532930,'532930','云南省.大理.洱源县','YNSDLEYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532931,'532931','云南省.大理.剑川县','YNSDLJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,532932,'532932','云南省.大理.鹤庆县','YNSDLHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533100,'533100','云南省.德宏州','YNSDHZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533102,'533102','云南省.德宏州.瑞丽市','YNSDHZRLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533103,'533103','云南省.德宏州.潞西市','YNSDHZLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533122,'533122','云南省.德宏州.梁河县','YNSDHZLHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533123,'533123','云南省.德宏州.盈江县','YNSDHZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533124,'533124','云南省.德宏州.陇川县','YNSDHZLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533300,'533300','云南省.怒江','YNSNJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533321,'533321','云南省.怒江.泸水县','YNSNJZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533323,'533323','云南省.怒江.福贡县','YNSNJFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533324,'533324','云南省.怒江.贡山县','YNSNJGSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533325,'533325','云南省.怒江.兰坪县','YNSNJLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533400,'533400','云南省.迪庆','YNSDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533421,'533421','云南省.迪庆.香格里拉县','YNSDQXGLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533422,'533422','云南省.迪庆.德钦县','YNSDQDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,533423,'533423','云南省.迪庆.维西县','YNSDQWXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540000,'540000','西藏自治区','XCZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540100,'540100','西藏自治区.拉萨市','XCZZQLSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540102,'540102','西藏自治区.拉萨市.城关区','XCZZQLSSCGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540121,'540121','西藏自治区.拉萨市.林周县','XCZZQLSSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540122,'540122','西藏自治区.拉萨市.当雄县','XCZZQLSSDXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540123,'540123','西藏自治区.拉萨市.尼木县','XCZZQLSSNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540124,'540124','西藏自治区.拉萨市.曲水县','XCZZQLSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540125,'540125','西藏自治区.拉萨市.堆龙德庆县','XCZZQLSSDLDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540126,'540126','西藏自治区.拉萨市.达孜县','XCZZQLSSDZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,540127,'540127','西藏自治区.拉萨市.墨竹工卡县','XCZZQLSSMZGKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542100,'542100','西藏自治区.昌都地区','XCZZQCDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542121,'542121','西藏自治区.昌都地区.昌都县','XCZZQCDDQCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542122,'542122','西藏自治区.昌都地区.江达县','XCZZQCDDQJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542123,'542123','西藏自治区.昌都地区.贡觉县','XCZZQCDDQGJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542124,'542124','西藏自治区.昌都地区.类乌齐县','XCZZQCDDQLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542125,'542125','西藏自治区.昌都地区.丁青县','XCZZQCDDQDQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542126,'542126','西藏自治区.昌都地区.察雅县','XCZZQCDDQCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542127,'542127','西藏自治区.昌都地区.八宿县','XCZZQCDDQBSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542128,'542128','西藏自治区.昌都地区.左贡县','XCZZQCDDQZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542129,'542129','西藏自治区.昌都地区.芒康县','XCZZQCDDQMKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542132,'542132','西藏自治区.昌都地区.洛隆县','XCZZQCDDQLLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542133,'542133','西藏自治区.昌都地区.边坝县','XCZZQCDDQBBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542200,'542200','西藏自治区.山南地区','XCZZQSNDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542221,'542221','西藏自治区.山南地区.乃东县','XCZZQSNDQNDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542222,'542222','西藏自治区.山南地区.扎囊县','XCZZQSNDQZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542223,'542223','西藏自治区.山南地区.贡嘎县','XCZZQSNDQGGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542224,'542224','西藏自治区.山南地区.桑日县','XCZZQSNDQSRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542225,'542225','西藏自治区.山南地区.琼结县','XCZZQSNDQQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542226,'542226','西藏自治区.山南地区.曲松县','XCZZQSNDQQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542227,'542227','西藏自治区.山南地区.措美县','XCZZQSNDQCMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542228,'542228','西藏自治区.山南地区.洛扎县','XCZZQSNDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542229,'542229','西藏自治区.山南地区.加查县','XCZZQSNDQJCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542231,'542231','西藏自治区.山南地区.隆子县','XCZZQSNDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542232,'542232','西藏自治区.山南地区.错那县','XCZZQSNDQCNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542233,'542233','西藏自治区.山南地区.浪卡子县','XCZZQSNDQLKZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542300,'542300','西藏自治区.日喀则地区','XCZZQRKZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542301,'542301','西藏自治区.日喀则地区.日喀则市','XCZZQRKZDQRKZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542322,'542322','西藏自治区.日喀则地区.南木林县','XCZZQRKZDQNMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542323,'542323','西藏自治区.日喀则地区.江孜县','XCZZQRKZDQJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542324,'542324','西藏自治区.日喀则地区.定日县','XCZZQRKZDQDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542325,'542325','西藏自治区.日喀则地区.萨迦县','XCZZQRKZDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542326,'542326','西藏自治区.日喀则地区.拉孜县','XCZZQRKZDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542327,'542327','西藏自治区.日喀则地区.昂仁县','XCZZQRKZDQARX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542328,'542328','西藏自治区.日喀则地区.谢通门县','XCZZQRKZDQXTMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542329,'542329','西藏自治区.日喀则地区.白朗县','XCZZQRKZDQBLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542330,'542330','西藏自治区.日喀则地区.仁布县','XCZZQRKZDQRBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542331,'542331','西藏自治区.日喀则地区.康马县','XCZZQRKZDQKMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542332,'542332','西藏自治区.日喀则地区.定结县','XCZZQRKZDQDJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542333,'542333','西藏自治区.日喀则地区.仲巴县','XCZZQRKZDQZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542334,'542334','西藏自治区.日喀则地区.亚东县','XCZZQRKZDQYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542335,'542335','西藏自治区.日喀则地区.吉隆县','XCZZQRKZDQJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542336,'542336','西藏自治区.日喀则地区.聂拉木县','XCZZQRKZDQNLMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542337,'542337','西藏自治区.日喀则地区.萨嘎县','XCZZQRKZDQSGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542338,'542338','西藏自治区.日喀则地区.岗巴县','XCZZQRKZDQGBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542400,'542400','西藏自治区.那曲地区','XCZZQNQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542421,'542421','西藏自治区.那曲地区.那曲县','XCZZQNQDQNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542422,'542422','西藏自治区.那曲地区.嘉黎县','XCZZQNQDQJLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542423,'542423','西藏自治区.那曲地区.比如县','XCZZQNQDQBRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542424,'542424','西藏自治区.那曲地区.聂荣县','XCZZQNQDQNRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542425,'542425','西藏自治区.那曲地区.安多县','XCZZQNQDQADX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542426,'542426','西藏自治区.那曲地区.申扎县','XCZZQNQDQSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542427,'542427','西藏自治区.那曲地区.索县','XCZZQNQDQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542428,'542428','西藏自治区.那曲地区.班戈县','XCZZQNQDQBGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542429,'542429','西藏自治区.那曲地区.巴青县','XCZZQNQDQBQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542430,'542430','西藏自治区.那曲地区.尼玛县','XCZZQNQDQNMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542500,'542500','西藏自治区.阿里地区','XCZZQALDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542521,'542521','西藏自治区.阿里地区.普兰县','XCZZQALDQPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542522,'542522','西藏自治区.阿里地区.札达县','XCZZQALDQZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542523,'542523','西藏自治区.阿里地区.噶尔县','XCZZQALDQGEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542524,'542524','西藏自治区.阿里地区.日土县','XCZZQALDQRTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542525,'542525','西藏自治区.阿里地区.革吉县','XCZZQALDQGJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542526,'542526','西藏自治区.阿里地区.改则县','XCZZQALDQGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542527,'542527','西藏自治区.阿里地区.措勤县','XCZZQALDQCQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542600,'542600','西藏自治区.林芝地区','XCZZQLZDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542621,'542621','西藏自治区.林芝地区.林芝县','XCZZQLZDQLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542622,'542622','西藏自治区.林芝地区.工布江达县','XCZZQLZDQGBJDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542623,'542623','西藏自治区.林芝地区.米林县','XCZZQLZDQMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542624,'542624','西藏自治区.林芝地区.墨脱县','XCZZQLZDQMTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542625,'542625','西藏自治区.林芝地区.波密县','XCZZQLZDQBMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542626,'542626','西藏自治区.林芝地区.察隅县','XCZZQLZDQCYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,542627,'542627','西藏自治区.林芝地区.朗县','XCZZQLZDQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610000,'610000','陕西省','SXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610100,'610100','陕西省.西安市','SXSXAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610102,'610102','陕西省.西安市.新城区','SXSXASXCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610103,'610103','陕西省.西安市.碑林区','SXSXASBLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610104,'610104','陕西省.西安市.莲湖区','SXSXASLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610111,'610111','陕西省.西安市.灞桥区','SXSXASZQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610112,'610112','陕西省.西安市.未央区','SXSXASWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610113,'610113','陕西省.西安市.雁塔区','SXSXASYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610114,'610114','陕西省.西安市.阎良区','SXSXASYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610115,'610115','陕西省.西安市.临潼区','SXSXASLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610116,'610116','陕西省.西安市.长安区','SXSXASCAQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610122,'610122','陕西省.西安市.蓝田县','SXSXASLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610124,'610124','陕西省.西安市.周至县','SXSXASZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610125,'610125','陕西省.西安市.户县','SXSXASHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610126,'610126','陕西省.西安市.高陵县','SXSXASGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610200,'610200','陕西省.铜川市','SXSTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610202,'610202','陕西省.铜川市.王益区','SXSTCSWYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610203,'610203','陕西省.铜川市.印台区','SXSTCSYTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610204,'610204','陕西省.铜川市.耀州区','SXSTCSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610222,'610222','陕西省.铜川市.宜君县','SXSTCSYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610300,'610300','陕西省.宝鸡市','SXSBJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610302,'610302','陕西省.宝鸡市.渭滨区','SXSBJSWBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610303,'610303','陕西省.宝鸡市.金台区','SXSBJSJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610304,'610304','陕西省.宝鸡市.陈仓区','SXSBJSCCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610322,'610322','陕西省.宝鸡市.凤翔县','SXSBJSFXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610323,'610323','陕西省.宝鸡市.岐山县','SXSBJSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610324,'610324','陕西省.宝鸡市.扶风县','SXSBJSFFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610326,'610326','陕西省.宝鸡市.眉县','SXSBJSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610327,'610327','陕西省.宝鸡市.陇县','SXSBJSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610328,'610328','陕西省.宝鸡市.千阳县','SXSBJSQYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610329,'610329','陕西省.宝鸡市.麟游县','SXSBJSL+C3117YX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610330,'610330','陕西省.宝鸡市.凤县','SXSBJSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610331,'610331','陕西省.宝鸡市.太白县','SXSBJSTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610400,'610400','陕西省.咸阳市','SXSXYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610402,'610402','陕西省.咸阳市.秦都区','SXSXYSQDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610403,'610403','陕西省.咸阳市.杨陵区','SXSXYSYLQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610404,'610404','陕西省.咸阳市.渭城区','SXSXYSWCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610422,'610422','陕西省.咸阳市.三原县','SXSXYSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610423,'610423','陕西省.咸阳市.泾阳县','SXSXYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610424,'610424','陕西省.咸阳市.乾县','SXSXYSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610425,'610425','陕西省.咸阳市.礼泉县','SXSXYSLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610426,'610426','陕西省.咸阳市.永寿县','SXSXYSYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610427,'610427','陕西省.咸阳市.彬县','SXSXYSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610428,'610428','陕西省.咸阳市.长武县','SXSXYSCWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610429,'610429','陕西省.咸阳市.旬邑县','SXSXYS旬YX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610430,'610430','陕西省.咸阳市.淳化县','SXSXYSCHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610431,'610431','陕西省.咸阳市.武功县','SXSXYSWGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610481,'610481','陕西省.咸阳市.兴平市','SXSXYSXPS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610500,'610500','陕西省.渭南市','SXSWNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610502,'610502','陕西省.渭南市.临渭区','SXSWNSLWQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610521,'610521','陕西省.渭南市.华县','SXSWNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610522,'610522','陕西省.渭南市.潼关县','SXSWNSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610523,'610523','陕西省.渭南市.大荔县','SXSWNSDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610524,'610524','陕西省.渭南市.合阳县','SXSWNSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610525,'610525','陕西省.渭南市.澄城县','SXSWNSCCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610526,'610526','陕西省.渭南市.蒲城县','SXSWNSPCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610527,'610527','陕西省.渭南市.白水县','SXSWNSBSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610528,'610528','陕西省.渭南市.富平县','SXSWNSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610581,'610581','陕西省.渭南市.韩城市','SXSWNSHCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610582,'610582','陕西省.渭南市.华阴市','SXSWNSHYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610600,'610600','陕西省.延安市','SXSYAS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610602,'610602','陕西省.延安市.宝塔区','SXSYASBTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610621,'610621','陕西省.延安市.延长县','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610622,'610622','陕西省.延安市.延川县','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610623,'610623','陕西省.延安市.子长县','SXSYASZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610624,'610624','陕西省.延安市.安塞县','SXSYASASX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610625,'610625','陕西省.延安市.志丹县','SXSYASZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610626,'610626','陕西省.延安市.吴起县','SXSYASWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610627,'610627','陕西省.延安市.甘泉县','SXSYASGQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610628,'610628','陕西省.延安市.富县','SXSYASFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610629,'610629','陕西省.延安市.洛川县','SXSYASLCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610630,'610630','陕西省.延安市.宜川县','SXSYASYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610631,'610631','陕西省.延安市.黄龙县','SXSYASHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610632,'610632','陕西省.延安市.黄陵县','SXSYASHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610700,'610700','陕西省.汉中市','SXSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610702,'610702','陕西省.汉中市.汉台区','SXSHZSHTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610721,'610721','陕西省.汉中市.南郑县','SXSHZSNZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610722,'610722','陕西省.汉中市.城固县','SXSHZSCGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610723,'610723','陕西省.汉中市.洋县','SXSHZSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610724,'610724','陕西省.汉中市.西乡县','SXSHZSXXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610725,'610725','陕西省.汉中市.勉县','SXSHZSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610726,'610726','陕西省.汉中市.宁强县','SXSHZSNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610727,'610727','陕西省.汉中市.略阳县','SXSHZSLYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610728,'610728','陕西省.汉中市.镇巴县','SXSHZSZBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610729,'610729','陕西省.汉中市.留坝县','SXSHZSLBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610730,'610730','陕西省.汉中市.佛坪县','SXSHZSFPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610800,'610800','陕西省.榆林市','SXSYLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610802,'610802','陕西省.榆林市.榆阳区','SXSYLSYYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610821,'610821','陕西省.榆林市.神木县','SXSYLSSMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610822,'610822','陕西省.榆林市.府谷县','SXSYLSFGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610823,'610823','陕西省.榆林市.横山县','SXSYLSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610824,'610824','陕西省.榆林市.靖边县','SXSYLSJBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610825,'610825','陕西省.榆林市.定边县','SXSYLSDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610826,'610826','陕西省.榆林市.绥德县','SXSYLSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610827,'610827','陕西省.榆林市.米脂县','SXSYLSMZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610828,'610828','陕西省.榆林市.佳县','SXSYLSJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610829,'610829','陕西省.榆林市.吴堡县','SXSYLSWBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610830,'610830','陕西省.榆林市.清涧县','SXSYLSQJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610831,'610831','陕西省.榆林市.子洲县','SXSYLSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610900,'610900','陕西省.安康市','SXSAKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610902,'610902','陕西省.安康市.汉滨区','SXSAKSHBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610921,'610921','陕西省.安康市.汉阴县','SXSAKSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610922,'610922','陕西省.安康市.石泉县','SXSAKSSQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610923,'610923','陕西省.安康市.宁陕县','SXSAKSNSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610924,'610924','陕西省.安康市.紫阳县','SXSAKSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610925,'610925','陕西省.安康市.岚皋县','SXSAKSZGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610926,'610926','陕西省.安康市.平利县','SXSAKSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610927,'610927','陕西省.安康市.镇坪县','SXSAKSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610928,'610928','陕西省.安康市.旬阳县','SXSAKS旬YX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,610929,'610929','陕西省.安康市.白河县','SXSAKSBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611000,'611000','陕西省.商洛市','SXSSLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611002,'611002','陕西省.商洛市.商州区','SXSSLSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611021,'611021','陕西省.商洛市.洛南县','SXSSLSLNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611022,'611022','陕西省.商洛市.丹凤县','SXSSLSDFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611023,'611023','陕西省.商洛市.商南县','SXSSLSSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611024,'611024','陕西省.商洛市.山阳县','SXSSLSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611025,'611025','陕西省.商洛市.镇安县','SXSSLSZAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,611026,'611026','陕西省.商洛市.柞水县','SXSSLSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620000,'620000','甘肃省','GSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620100,'620100','甘肃省.兰州市','GSSLZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620102,'620102','甘肃省.兰州市.城关区','GSSLZSCGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620103,'620103','甘肃省.兰州市.七里河区','GSSLZSQLHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620104,'620104','甘肃省.兰州市.西固区','GSSLZSXGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620105,'620105','甘肃省.兰州市.安宁区','GSSLZSANQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620111,'620111','甘肃省.兰州市.红古区','GSSLZSHGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620121,'620121','甘肃省.兰州市.永登县','GSSLZSYDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620122,'620122','甘肃省.兰州市.皋兰县','GSSLZSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620123,'620123','甘肃省.兰州市.榆中县','GSSLZSYZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620200,'620200','甘肃省.嘉峪关市','GSSJYGS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620300,'620300','甘肃省.金昌市','GSSJCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620302,'620302','甘肃省.金昌市.金川区','GSSJCSJCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620321,'620321','甘肃省.金昌市.永昌县','GSSJCSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620400,'620400','甘肃省.白银市','GSSBYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620402,'620402','甘肃省.白银市.白银区','GSSBYSBYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620403,'620403','甘肃省.白银市.平川区','GSSBYSPCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620421,'620421','甘肃省.白银市.靖远县','GSSBYSJYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620422,'620422','甘肃省.白银市.会宁县','GSSBYSHNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620423,'620423','甘肃省.白银市.景泰县','GSSBYSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620500,'620500','甘肃省.天水市','GSSTSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620502,'620502','甘肃省.天水市.秦州区','GSSTSSQZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620503,'620503','甘肃省.天水市.麦积区','GSSTSSMJQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620521,'620521','甘肃省.天水市.清水县','GSSTSSQSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620522,'620522','甘肃省.天水市.秦安县','GSSTSSQAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620523,'620523','甘肃省.天水市.甘谷县','GSSTSSGGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620524,'620524','甘肃省.天水市.武山县','GSSTSSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620525,'620525','甘肃省.天水市.张家川回族自治县','GSSTSSZJCHZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620600,'620600','甘肃省.武威市','GSSWWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620602,'620602','甘肃省.武威市.凉州区','GSSWWSLZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620621,'620621','甘肃省.武威市.民勤县','GSSWWSMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620622,'620622','甘肃省.武威市.古浪县','GSSWWSGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620623,'620623','甘肃省.武威市.天祝藏族自治县','GSSWWSTZCZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620700,'620700','甘肃省.张掖市','GSSZYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620702,'620702','甘肃省.张掖市.甘州区','GSSZYSGZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620721,'620721','甘肃省.张掖市.肃南裕固族自治县','GSSZYSSNYGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620722,'620722','甘肃省.张掖市.民乐县','GSSZYSMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620723,'620723','甘肃省.张掖市.临泽县','GSSZYSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620724,'620724','甘肃省.张掖市.高台县','GSSZYSGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620725,'620725','甘肃省.张掖市.山丹县','GSSZYSSDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620800,'620800','甘肃省.平凉市','GSSPLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620802,'620802','甘肃省.平凉市.崆峒区','GSSPLSZZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620821,'620821','甘肃省.平凉市.泾川县','GSSPLSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620822,'620822','甘肃省.平凉市.灵台县','GSSPLSLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620823,'620823','甘肃省.平凉市.崇信县','GSSPLSCXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620824,'620824','甘肃省.平凉市.华亭县','GSSPLSHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620825,'620825','甘肃省.平凉市.庄浪县','GSSPLSZLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620826,'620826','甘肃省.平凉市.静宁县','GSSPLSJNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620900,'620900','甘肃省.酒泉市','GSSJQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620902,'620902','甘肃省.酒泉市.肃州区','GSSJQSSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620921,'620921','甘肃省.酒泉市.金塔县','GSSJQSJTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620922,'620922','甘肃省.酒泉市.瓜州县','GSSJQSGZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620923,'620923','甘肃省.酒泉市.肃北县','GSSJQSSBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620924,'620924','甘肃省.酒泉市.阿克塞县','GSSJQSAKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620981,'620981','甘肃省.酒泉市.玉门市','GSSJQSYMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,620982,'620982','甘肃省.酒泉市.敦煌市','GSSJQSDHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621000,'621000','甘肃省.庆阳市','GSSQYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621002,'621002','甘肃省.庆阳市.西峰区','GSSQYSXFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621021,'621021','甘肃省.庆阳市.庆城县','GSSQYSQCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621022,'621022','甘肃省.庆阳市.环县','GSSQYSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621023,'621023','甘肃省.庆阳市.华池县','GSSQYSHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621024,'621024','甘肃省.庆阳市.合水县','GSSQYSHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621025,'621025','甘肃省.庆阳市.正宁县','GSSQYSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621026,'621026','甘肃省.庆阳市.宁县','GSSQYSNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621027,'621027','甘肃省.庆阳市.镇原县','GSSQYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621100,'621100','甘肃省.定西市','GSSDXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621102,'621102','甘肃省.定西市.安定区','GSSDXSADQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621121,'621121','甘肃省.定西市.通渭县','GSSDXSTWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621122,'621122','甘肃省.定西市.陇西县','GSSDXSLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621123,'621123','甘肃省.定西市.渭源县','GSSDXSWYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621124,'621124','甘肃省.定西市.临洮县','GSSDXSLZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621125,'621125','甘肃省.定西市.漳县','GSSDXSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621126,'621126','甘肃省.定西市.岷县','GSSDXSZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621200,'621200','甘肃省.陇南市','GSSLNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621202,'621202','甘肃省.陇南市.武都区','GSSLNSWDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621221,'621221','甘肃省.陇南市.成县','GSSLNSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621222,'621222','甘肃省.陇南市.文县','GSSLNSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621223,'621223','甘肃省.陇南市.宕昌县','GSSLNSZCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621224,'621224','甘肃省.陇南市.康县','GSSLNSKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621225,'621225','甘肃省.陇南市.西和县','GSSLNSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621226,'621226','甘肃省.陇南市.礼县','GSSLNSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621227,'621227','甘肃省.陇南市.徽县','GSSLNSHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,621228,'621228','甘肃省.陇南市.两当县','GSSLNSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622900,'622900','甘肃省.临夏州','GSSLXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622901,'622901','甘肃省.临夏州.临夏市','GSSLXZLXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622921,'622921','甘肃省.临夏州.临夏县','GSSLXZLXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622922,'622922','甘肃省.临夏州.康乐县','GSSLXZKLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622923,'622923','甘肃省.临夏州.永靖县','GSSLXZYJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622924,'622924','甘肃省.临夏州.广河县','GSSLXZGHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622925,'622925','甘肃省.临夏州.和政县','GSSLXZHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622926,'622926','甘肃省.临夏州.东乡族自治县','GSSLXZDXZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,622927,'622927','甘肃省.临夏州.积石山县','GSSLXZJSSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623000,'623000','甘肃省.甘南','GSSGN'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623001,'623001','甘肃省.甘南.合作市','GSSGNHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623021,'623021','甘肃省.甘南.临潭县','GSSGNLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623022,'623022','甘肃省.甘南.卓尼县','GSSGNZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623023,'623023','甘肃省.甘南.舟曲县','GSSGNZQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623024,'623024','甘肃省.甘南.迭部县','GSSGNDBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623025,'623025','甘肃省.甘南.玛曲县','GSSGNMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623026,'623026','甘肃省.甘南.碌曲县','GSSGNLQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,623027,'623027','甘肃省.甘南.夏河县','GSSGNXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630000,'630000','青海省','QHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630100,'630100','青海省.西宁市','QHSXNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630102,'630102','青海省.西宁市.城东区','QHSXNSCDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630103,'630103','青海省.西宁市.城中区','QHSXNSCZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630104,'630104','青海省.西宁市.城西区','QHSXNSCXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630105,'630105','青海省.西宁市.城北区','QHSXNSCBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630121,'630121','青海省.西宁市.大通县','QHSXNSDTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630122,'630122','青海省.西宁市.湟中县','QHSXNSZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,630123,'630123','青海省.西宁市.湟源县','QHSXNSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632100,'632100','青海省.海东地区','QHSHDDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632121,'632121','青海省.海东地区.平安县','QHSHDDQPAX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632122,'632122','青海省.海东地区.民和县','QHSHDDQMHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632123,'632123','青海省.海东地区.乐都县','QHSHDDQLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632126,'632126','青海省.海东地区.互助县','QHSHDDQHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632127,'632127','青海省.海东地区.化隆县','QHSHDDQHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632128,'632128','青海省.海东地区.循化县','QHSHDDQ循HX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632200,'632200','青海省.海北州','QHSHBZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632221,'632221','青海省.海北州.门源回族自治县','QHSHBZMYHZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632222,'632222','青海省.海北州.祁连县','QHSHBZQLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632223,'632223','青海省.海北州.海晏县','QHSHBZHZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632224,'632224','青海省.海北州.刚察县','QHSHBZGCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632300,'632300','青海省.黄南州','QHSHNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632321,'632321','青海省.黄南州.同仁县','QHSHNZTRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632322,'632322','青海省.黄南州.尖扎县','QHSHNZJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632323,'632323','青海省.黄南州.泽库县','QHSHNZZKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632324,'632324','青海省.黄南州.河南蒙古族自治县','QHSHNZHNMGZZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632500,'632500','青海省.海南州','QHSHNZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632521,'632521','青海省.海南州.共和县','QHSHNZGHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632522,'632522','青海省.海南州.同德县','QHSHNZTDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632523,'632523','青海省.海南州.贵德县','QHSHNZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632524,'632524','青海省.海南州.兴海县','QHSHNZXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632525,'632525','青海省.海南州.贵南县','QHSHNZGNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632600,'632600','青海省.果洛州','QHSGLZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632621,'632621','青海省.果洛州.玛沁县','QHSGLZMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632622,'632622','青海省.果洛州.班玛县','QHSGLZBMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632623,'632623','青海省.果洛州.甘德县','QHSGLZGDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632624,'632624','青海省.果洛州.达日县','QHSGLZDRX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632625,'632625','青海省.果洛州.久治县','QHSGLZJZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632626,'632626','青海省.果洛州.玛多县','QHSGLZMDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632700,'632700','青海省.玉树州','QHSYSZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632721,'632721','青海省.玉树州.玉树县','QHSYSZYSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632722,'632722','青海省.玉树州.杂多县','QHSYSZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632723,'632723','青海省.玉树州.称多县','QHSYSZCDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632724,'632724','青海省.玉树州.治多县','QHSYSZZDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632725,'632725','青海省.玉树州.囊谦县','QHSYSZNQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632726,'632726','青海省.玉树州.曲麻莱县','QHSYSZQMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632800,'632800','青海省.海西州','QHSHXZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632801,'632801','青海省.海西州.格尔木市','QHSHXZGEMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632802,'632802','青海省.海西州.德令哈市','QHSHXZDLHS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632821,'632821','青海省.海西州.乌兰县','QHSHXZWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632822,'632822','青海省.海西州.都兰县','QHSHXZDLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,632823,'632823','青海省.海西州.天峻县','QHSHXZTJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640000,'640000','宁夏','NX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640100,'640100','宁夏.银川市','NXYCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640104,'640104','宁夏.银川市.兴庆区','NXYCSXQQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640105,'640105','宁夏.银川市.西夏区','NXYCSXXQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640106,'640106','宁夏.银川市.金凤区','NXYCSJFQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640121,'640121','宁夏.银川市.永宁县','NXYCSYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640122,'640122','宁夏.银川市.贺兰县','NXYCSHLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640181,'640181','宁夏.银川市.灵武市','NXYCSLWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640200,'640200','宁夏.石嘴山市','NXSZSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640202,'640202','宁夏.石嘴山市.大武口区','NXSZSSDWKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640205,'640205','宁夏.石嘴山市.惠农区','NXSZSSHNQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640221,'640221','宁夏.石嘴山市.平罗县','NXSZSSPLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640300,'640300','宁夏.吴忠市','NXWZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640302,'640302','宁夏.吴忠市.利通区','NXWZSLTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640303,'640303','宁夏.吴忠市.红寺堡区','NXWZSHSBQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640323,'640323','宁夏.吴忠市.盐池县','NXWZSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640324,'640324','宁夏.吴忠市.同心县','NXWZSTXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640381,'640381','宁夏.吴忠市.青铜峡市','NXWZSQTXS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640400,'640400','宁夏.固原市','NXGYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640402,'640402','宁夏.固原市.原州区','NXGYSYZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640422,'640422','宁夏.固原市.西吉县','NXGYSXJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640423,'640423','宁夏.固原市.隆德县','NXGYSLDX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640424,'640424','宁夏.固原市.泾源县','NXGYSZYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640425,'640425','宁夏.固原市.彭阳县','NXGYSPYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640500,'640500','宁夏.中卫市','NXZWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640502,'640502','宁夏.中卫市.沙坡头区','NXZWSSPTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640521,'640521','宁夏.中卫市.中宁县','NXZWSZNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,640522,'640522','宁夏.中卫市.海原县','NXZWSHYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650000,'650000','新疆','XJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650100,'650100','新疆.乌鲁木齐市','XJWLMQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650102,'650102','新疆.乌鲁木齐市.天山区','XJWLMQSTSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650103,'650103','新疆.乌鲁木齐市.沙依巴克区','XJWLMQSSYBKQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650104,'650104','新疆.乌鲁木齐市.新市区','XJWLMQSXSQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650105,'650105','新疆.乌鲁木齐市.水磨沟区','XJWLMQSSMGQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650106,'650106','新疆.乌鲁木齐市.头屯河区','XJWLMQSTTHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650107,'650107','新疆.乌鲁木齐市.达坂城区','XJWLMQSDZCQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650109,'650109','新疆.乌鲁木齐市.米东区','XJWLMQSMDQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650121,'650121','新疆.乌鲁木齐市.乌鲁木齐县','XJWLMQSWLMQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650200,'650200','新疆.克拉玛依市','XJKLMYS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650202,'650202','新疆.克拉玛依市.独山子区','XJKLMYSDSZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650203,'650203','新疆.克拉玛依市.克拉玛依区','XJKLMYSKLMYQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650204,'650204','新疆.克拉玛依市.白碱滩区','XJKLMYSBJTQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,650205,'650205','新疆.克拉玛依市.乌尔禾区','XJKLMYSWEHQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652100,'652100','新疆.吐鲁番','XJTLF'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652101,'652101','新疆.吐鲁番.吐鲁番市','XJTLFTLFS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652122,'652122','新疆.吐鲁番.鄯善县','XJTLFZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652123,'652123','新疆.吐鲁番.托克逊县','XJTLFTKXX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652200,'652200','新疆.哈密','XJHM'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652201,'652201','新疆.哈密.哈密市','XJHMHMS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652222,'652222','新疆.哈密.巴里坤县','XJHMBLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652223,'652223','新疆.哈密.伊吾县','XJHMYWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652300,'652300','新疆.昌吉','XJCJ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652301,'652301','新疆.昌吉.昌吉市','XJCJCJS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652302,'652302','新疆.昌吉.阜康市','XJCJFKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652323,'652323','新疆.昌吉.呼图壁县','XJCJHTBX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652324,'652324','新疆.昌吉.玛纳斯县','XJCJMNSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652325,'652325','新疆.昌吉.奇台县','XJCJQTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652327,'652327','新疆.昌吉.吉木萨尔县','XJCJJMSEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652328,'652328','新疆.昌吉.木垒县','XJCJMLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652700,'652700','新疆.博尔塔拉','XJBETL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652701,'652701','新疆.博尔塔拉.博乐市','XJBETLBLS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652722,'652722','新疆.博尔塔拉.精河县','XJBETLJHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652723,'652723','新疆.博尔塔拉.温泉县','XJBETLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652800,'652800','新疆.巴音郭楞','XJBYGL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652801,'652801','新疆.巴音郭楞.库尔勒市','XJBYGLKELS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652822,'652822','新疆.巴音郭楞.轮台县','XJBYGLLTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652823,'652823','新疆.巴音郭楞.尉犁县','XJBYGLWLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652824,'652824','新疆.巴音郭楞.若羌县','XJBYGLRQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652825,'652825','新疆.巴音郭楞.且末县','XJBYGLQMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652826,'652826','新疆.焉耆','XJYZ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652827,'652827','新疆.焉耆.和静县','XJYZHJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652828,'652828','新疆.焉耆.和硕县','XJYZHSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652829,'652829','新疆.焉耆.博湖县','XJYZBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652900,'652900','新疆.阿克苏','XJAKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652901,'652901','新疆.阿克苏.阿克苏市','XJAKSAKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652922,'652922','新疆.阿克苏.温宿县','XJAKSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652923,'652923','新疆.阿克苏.库车县','XJAKSKCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652924,'652924','新疆.阿克苏.沙雅县','XJAKSSYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652925,'652925','新疆.阿克苏.新和县','XJAKSXHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652926,'652926','新疆.阿克苏.拜城县','XJAKSBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652927,'652927','新疆.阿克苏.乌什县','XJAKSWSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652928,'652928','新疆.阿克苏.阿瓦提县','XJAKSAWTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,652929,'652929','新疆.阿克苏.柯坪县','XJAKSKPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653000,'653000','新疆.克孜勒','XJKZL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653001,'653001','新疆.克孜勒.阿图什市','XJKZLATSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653022,'653022','新疆.克孜勒.阿克陶县','XJKZLAKTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653023,'653023','新疆.克孜勒.阿合奇县','XJKZLAHQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653024,'653024','新疆.克孜勒.乌恰县','XJKZLWQX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653100,'653100','新疆.喀什','XJKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653101,'653101','新疆.喀什.喀什市','XJKSKSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653121,'653121','新疆.喀什.疏附县','XJKSSFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653122,'653122','新疆.喀什.疏勒县','XJKSSLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653123,'653123','新疆.喀什.英吉沙县','XJKSYJSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653124,'653124','新疆.喀什.泽普县','XJKSZPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653125,'653125','新疆.喀什.莎车县','XJKSSCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653126,'653126','新疆.喀什.叶城县','XJKSYCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653127,'653127','新疆.喀什.麦盖提县','XJKSMGTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653128,'653128','新疆.喀什.岳普湖县','XJKSYPHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653129,'653129','新疆.喀什.伽师县','XJKSZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653130,'653130','新疆.喀什.巴楚县','XJKSBCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653131,'653131','新疆.喀什.塔什库尔干县','XJKSTSKEGX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653200,'653200','新疆.和田','XJHT'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653201,'653201','新疆.和田.和田市','XJHTHTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653221,'653221','新疆.和田.和田县','XJHTHTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653222,'653222','新疆.和田.墨玉县','XJHTMYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653223,'653223','新疆.和田.皮山县','XJHTPSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653224,'653224','新疆.和田.洛浦县','XJHTLPX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653225,'653225','新疆.和田.策勒县','XJHTCLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653226,'653226','新疆.和田.于田县','XJHTYTX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,653227,'653227','新疆.和田.民丰县','XJHTMFX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654000,'654000','新疆.伊犁','XJYL'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654002,'654002','新疆.伊犁.伊宁市','XJYLYNS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654003,'654003','新疆.伊犁.奎屯市','XJYLKTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654021,'654021','新疆.伊犁.伊宁县','XJYLYNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654022,'654022','新疆.伊犁.察布查尔锡伯自治县','XJYLCBCEXBZZX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654023,'654023','新疆.伊犁.霍城县','XJYLHCX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654024,'654024','新疆.伊犁.巩留县','XJYLGLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654025,'654025','新疆.伊犁.新源县','XJYLXYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654026,'654026','新疆.伊犁.昭苏县','XJYLZSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654027,'654027','新疆.伊犁.特克斯县','XJYLTKSX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654028,'654028','新疆.伊犁.尼勒克县','XJYLNLKX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654200,'654200','新疆.塔城','XJTC'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654201,'654201','新疆.塔城.塔城市','XJTCTCS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654202,'654202','新疆.塔城.乌苏市','XJTCWSS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654221,'654221','新疆.塔城.额敏县','XJTCEMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654223,'654223','新疆.塔城.沙湾县','XJTCSWX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654224,'654224','新疆.塔城.托里县','XJTCTLX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654225,'654225','新疆.塔城.裕民县','XJTCYMX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654226,'654226','新疆.塔城.和布克赛尔县','XJTCHBKSEX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654300,'654300','新疆.阿勒泰','XJALT'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654301,'654301','新疆.阿勒泰.阿勒泰市','XJALTALTS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654321,'654321','新疆.阿勒泰.布尔津县','XJALTBEJX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654322,'654322','新疆.阿勒泰.富蕴县','XJALTFYX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654323,'654323','新疆.阿勒泰.福海县','XJALTFHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654324,'654324','新疆.阿勒泰.哈巴河县','XJALTHBHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654325,'654325','新疆.阿勒泰.青河县','XJALTQHX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,654326,'654326','新疆.阿勒泰.吉木乃县','XJALTJMNX'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659001,'659001','新疆.石河子市','XJSHZS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659002,'659002','新疆.阿拉尔市','XJALES'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659003,'659003','新疆.图木舒克市','XJTMSKS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,659004,'659004','新疆.五家渠市','XJWJQS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,710000,'710000','台湾省','TWS'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,810000,'810000','香港特别行政区','XGTBXZQ'); 
 insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,'8','00',5497000,820000,'820000','澳门特别行政区','AMTBXZQ');
 
--2011-01-19 张森荣设计
--数据字典
CREATE TABLE SYS_XDICT_INFO (
        --编码AMOUNT
	XDICT_ID varchar (100) NOT NULL ,
        --类型 1
	XDICT_TYPE numeric(1, 0) NOT NULL ,
        --名称
	XDICT_NAME varchar (255) NOT NULL ,
        --拼音码
	XDICT_SPELL varchar (255) NOT NULL ,
        --序号
	SEQ_NO int NOT NULL ,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
  --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
   CONSTRAINT PK_SYS_XDICT_INFO PRIMARY KEY (XDICT_ID,XDICT_TYPE)
) ;

CREATE INDEX IX_SYS_XDICT_INFO_TIME_STAMP ON SYS_XDICT_INFO(TIME_STAMP);

--frf打印格式定义表
CREATE TABLE SYS_FASTFILE (
  --企业代码<0为公共资料>
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
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
  --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SYS_FASTFILE PRIMARY KEY (TENANT_ID,frfFileName)
);

CREATE INDEX IX_SYS_FASTFILE_TENANT_ID ON SYS_FASTFILE(TENANT_ID);

CREATE INDEX IX_SYS_FASTFILE_TIME_STAMP ON SYS_FASTFILE(TENANT_ID,TIME_STAMP);

--关健ID序号控制表
CREATE TABLE SYS_SEQUENCE (
  --企业代码
	TENANT_ID int NOT NULL ,
	SEQU_ID varchar (20) NOT NULL ,
	FLAG_TEXT varchar (20) ,
	SEQU_NO int ,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	COMM varchar(2) NOT NULL DEFAULT '00',
  --更新时间 从2011-01-01开始的秒数  
	TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SYS_SEQUENCE PRIMARY KEY (TENANT_ID,SEQU_ID)
);

CREATE INDEX IX_SYS_SEQUENCE_TENANT_ID ON SYS_SEQUENCE(TENANT_ID);

CREATE INDEX IX_SYS_SEQUENCE_TIME_STAMP ON SYS_SEQUENCE(TENANT_ID,TIME_STAMP);

--模块类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','模块','MODU_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','功能','MODU_TYPE','00',5497000);

--模块表
CREATE TABLE CA_MODULE (
        --软件产品
	PROD_ID varchar (10) NOT NULL ,
        --模块编码
	MODU_ID varchar (20) NOT NULL ,
        --模块时都为 0 功能项时对应 byte 串的位置号 0101010(1)<每一位为1代表有权限>
	SEQNO int NOT NULL ,
        --模块名称
	MODU_NAME varchar (50) NOT NULL ,
        --树级编码 3位一级
	LEVEL_ID varchar (21) ,
        --模块类型 
	MODU_TYPE int NOT NULL ,
        --R3 Delphi专用
	ACTION_NAME varchar (50) NOT NULL ,
        --R3 Web版专用
	ACTION_URL varchar (50) NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
  --更新时间 从2011-01-01开始的秒数  
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_CA_MODULE PRIMARY KEY (PROD_ID,MODU_ID)
);

CREATE INDEX IX_CA_MODULE_PROD_ID ON CA_MODULE(PROD_ID);

CREATE INDEX IX_CA_MODULE_TIME_STAMP ON CA_MODULE(TIME_STAMP);

--权限控制表
CREATE TABLE CA_RIGHTS (
    --行号 guid值
	ROWS_ID char (36) NOT NULL ,
    --企业代码
	TENANT_ID int NOT NULL ,
        --模块代码
	MODU_ID varchar (20) NOT NULL ,
        --用户代码或角色代码
	ROLE_ID varchar (36) NOT NULL ,
        --用户类型
	ROLE_TYPE int NOT NULL ,
        --0代表整个模块没有权限 二制串转10整型
	CHK int NOT NULL ,
        --通读标志
	COMM varchar (2) NOT NULL DEFAULT '00',
  --更新时间 从2011-01-01开始的秒数  
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_CA_RIGHTS PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_CA_RIGHTS_TENANT_ID ON CA_RIGHTS(TENANT_ID);

CREATE INDEX IX_CA_RIGHTS_MODU_ID ON CA_RIGHTS(TENANT_ID,ROLE_ID);

CREATE INDEX IX_CA_RIGHTS_TIME_STAMP ON CA_RIGHTS(TENANT_ID,TIME_STAMP);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('16','自定义指标','CODE_TYPE','00',5497000);

--商品常用指标
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','分类','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','类别','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','厂家','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','品牌','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','重点<是否重点品牌>','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','省内外','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('7','颜色组','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('8','尺码组','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','自定义9','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('10','自定义10','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','自定义11','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','自定义12','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('13','自定义13','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('14','自定义14','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('15','自定义15','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('16','自定义16','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('17','自定义17','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('18','自定义18','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('19','自定义19','SORT_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('20','自定义20','SORT_TYPE','00',5497000);

--商品分类属性
CREATE TABLE PUB_GOODSSORT (
        --分类代码<guid>
	SORT_ID varchar (36) NOT NULL ,
    --企业代码 0是中心统一分类
	TENANT_ID int NOT NULL ,
        --树ID号 4位一级
	LEVEL_ID varchar (20) ,
        --分类名称
	SORT_NAME varchar (30) NOT NULL ,
        --分类类型 
	SORT_TYPE int NOT NULL ,
        --拼音码
	SORT_SPELL varchar (30) NOT NULL ,
        --排序号
	SEQ_NO int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSSORT PRIMARY KEY (TENANT_ID,SORT_ID,SORT_TYPE)
);
CREATE INDEX IX_PUB_GOODSSORT_TENANT_ID ON PUB_GOODSSORT(TENANT_ID);

CREATE INDEX IX_PUB_GOODSSORT_SORT_TYPE ON PUB_GOODSSORT(TENANT_ID,SORT_TYPE);

CREATE INDEX IX_PUB_GOODSSORT_TIME_STAMP ON PUB_GOODSSORT(TENANT_ID,TIME_STAMP);


--经营类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','连锁经营','RELATION_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','自主经营','RELATION_FLAG','00',5497000);


--颜色档案
CREATE TABLE PUB_COLOR_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --颜色代码<guid>
	COLOR_ID varchar (36) NOT NULL ,
        --所属分组<多个用,号分隔>
	SORT_ID7S varchar (36) NOT NULL ,
        --所属分组<多个用,号分隔>
	SORT_ID7_NAMES varchar (36) NOT NULL ,
        --颜色名称
	COLOR_NAME varchar (30) NOT NULL ,
        --拼音码
	COLOR_SPELL varchar (30) NOT NULL ,
        --条码标号
	BARCODE_FLAG varchar (3) ,
        --排序号
	SEQ_NO int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_COLOR_INFO PRIMARY KEY (TENANT_ID,COLOR_ID)
);
CREATE INDEX IX_PUB_COLOR_INFO_TENANT_ID ON PUB_COLOR_INFO(TENANT_ID);
CREATE INDEX IX_PUB_COLOR_INFO_TIME_STAMP ON PUB_COLOR_INFO(TENANT_ID,TIME_STAMP);

--企业经营颜色档案,自经营颜色档案+连接颜色档案

CREATE view VIW_COLOR_INFO
as
select 2 as RELATION_FLAG,TENANT_ID,COLOR_ID,SORT_ID7S,COLOR_NAME,COLOR_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_COLOR_INFO
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,COLOR_ID,SORT_ID7S,COLOR_NAME,COLOR_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_COLOR_INFO A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--尺码档案
CREATE TABLE PUB_SIZE_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --尺码代码<guid>
	SIZE_ID varchar (36) NOT NULL ,
        --所属分组<多个用,号分隔>
	SORT_ID8S varchar (36) NOT NULL ,
        --所属分组<多个用,号分隔>
	SORT_ID8_NAMES varchar (36) NOT NULL ,
        --尺码名称
	SIZE_NAME varchar (30) NOT NULL ,
        --拼音码
	SIZE_SPELL varchar (30) NOT NULL ,
        --条码标号
	BARCODE_FLAG varchar (2) ,
        --排序号
	SEQ_NO int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_SIZE_INFO PRIMARY KEY (TENANT_ID,SIZE_ID)
);
CREATE INDEX IX_PUB_SIZE_INFO_TENANT_ID ON PUB_SIZE_INFO(TENANT_ID);
CREATE INDEX IX_PUB_SIZE_INFO_TIME_STAMP ON PUB_SIZE_INFO(TENANT_ID,TIME_STAMP);

--企业经营尺码档案,自经营尺码档案+连接尺码档案

CREATE view VIW_SIZE_INFO
as
select 2 as RELATION_FLAG,TENANT_ID,SIZE_ID,SORT_ID8S,SIZE_NAME,SIZE_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_SIZE_INFO
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,SIZE_ID,SORT_ID8S,SIZE_NAME,SIZE_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_SIZE_INFO A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--企业经营商品分类,自经营分类+连锁分类
CREATE view VIW_GOODSSORT
as
select 1 as RELATION_FLAG,B.RELATION_ID,B.RELATION_NAME,C.RELATI_ID as TENANT_ID,SORT_ID,A.LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_GOODSSORT A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12')
union all
select 2 as RELATION_FLAG,0 as RELATION_ID,'自主经营' as RELATION_NAME,TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_GOODSSORT;

--计量单位
CREATE TABLE PUB_MEAUNITS (
        --代码<guid>
	UNIT_ID varchar (36) NOT NULL ,
    --企业代码 0是中心统一分类
	TENANT_ID int NOT NULL ,
        --名称
	UNIT_NAME varchar (10) NOT NULL ,
        --拼音码
	UNIT_SPELL varchar (10) NOT NULL ,
        --排序号
	SEQ_NO int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --更新时间 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_MEAUNITS PRIMARY KEY (TENANT_ID,UNIT_ID)
);

CREATE INDEX IX_PUB_MEAUNITS_TENANT_ID ON PUB_MEAUNITS(TENANT_ID);

CREATE INDEX IX_PUB_MEAUNITS_TIME_STAMP ON PUB_MEAUNITS(TENANT_ID,TIME_STAMP);

--企业经营计量单位,自经营计量单位+连接计量单位

CREATE view VIW_MEAUNITS
as
select 2 as RELATION_FLAG,TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,COMM,TIME_STAMP
from PUB_MEAUNITS
union all
select 1 as RELATION_FLAG,C.RELATI_ID as TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,A.COMM,A.TIME_STAMP
from PUB_MEAUNITS A,CA_RELATION B,CA_RELATIONS C
where A.TENANT_ID=B.TENANT_ID and B.RELATION_ID=C.RELATION_ID and C.RELATION_STATUS='2' and C.COMM not in ('02','12');

--库存选项
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','要管库存','GODS_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','不管库存','GODS_TYPE','00',5497000);


--积分选项
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','可积分','HAS_INTEGRAL','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','不积分','HAS_INTEGRAL','00',5497000);


--是否启用打拆率
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','启用','USING_PRICE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','禁用','USING_PRICE','00',5497000);


--是否启用批号
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','启用','USING_BATCH_NO','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','禁用','USING_BATCH_NO','00',5497000);


--是否管制积分换购
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','不启用','USING_BARTER','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','积分兑换','USING_BARTER','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','积分换购','USING_BARTER','00',5497000);

--是否启用物流跟踪码
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','启用','USING_LOCUS_NO','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','禁用','USING_LOCUS_NO','00',5497000);

--商品资料
CREATE TABLE PUB_GOODSINFO (
        --货号编码,系统自编唯一号
	GODS_ID char (36) NOT NULL ,
        --企业代码 0 为中心维护
	TENANT_ID int NOT NULL ,
        --货号<店内识别码>
	GODS_CODE varchar (20) NOT NULL ,
        --品名+规格
	GODS_NAME varchar (50) NOT NULL ,
        --拼音码
	GODS_SPELL varchar (50) NOT NULL ,
        --库存选项
	GODS_TYPE integer ,
        --分类1
	SORT_ID1 varchar (36) ,
        --分类2
	SORT_ID2 varchar (36) ,
        --分类3
	SORT_ID3 varchar (36) ,
        --分类4
	SORT_ID4 varchar (36) ,
        --分类5
	SORT_ID5 varchar (36) ,
        --分类6
	SORT_ID6 varchar (36) ,
        --颜色组
	SORT_ID7 varchar (36) ,
        --尺码组
	SORT_ID8 varchar (36) ,
        --自定义9
	SORT_ID9 varchar (36) ,
        --自定义10
	SORT_ID10 varchar (36) ,
        --自定义11
	SORT_ID11 varchar (36) ,
        --自定义12
	SORT_ID12 varchar (36) ,
        --自定义13
	SORT_ID13 varchar (36) ,
        --自定义14
	SORT_ID14 varchar (36) ,
        --自定义15
	SORT_ID15 varchar (36) ,
        --自定义16
	SORT_ID16 varchar (36) ,
        --自定义17
	SORT_ID17 varchar (36) ,
        --自定义18
	SORT_ID18 varchar (36) ,
        --自定义19
	SORT_ID19 varchar (36) ,
        --自定义20
	SORT_ID20 varchar (36) ,
	      --计量单位条码
	BARCODE varchar (30) ,
        --默认单位
	UNIT_ID varchar (36) NOT NULL ,
        --计量单位
	CALC_UNITS varchar (36) NOT NULL ,
        --包装1单位
	SMALL_UNITS varchar (36) ,
        --包装2单位
	BIG_UNITS varchar (36) ,
        --包装1转换系数
	SMALLTO_CALC decimal(18, 3) ,
        --包装2转换系数
	BIGTO_CALC decimal(18, 3) ,
        --标准进价
	NEW_INPRICE decimal(18, 3) ,
        --标准售价
	NEW_OUTPRICE decimal(18, 3) ,
        --最低售价
	NEW_LOWPRICE decimal(18, 3) ,
        --是否启用折扣率 1启用,2禁用
	USING_PRICE int NOT NULL ,
        --是否参考积分
	HAS_INTEGRAL int NOT NULL ,
        --是否使用批号管制
	USING_BATCH_NO int NOT NULL ,
        --是否管制积分换购
	USING_BARTER int NOT NULL ,
        --是否管制物流跟踪码
	USING_LOCUS_NO int NOT NULL ,
        --积分换购积分
	BARTER_INTEGRAL int NOT NULL ,
        --备注
	REMARK varchar (200) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --更新时间 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSINFO PRIMARY KEY (TENANT_ID,GODS_ID)
);

CREATE INDEX IX_PUB_GOODSINFO_TENANT_ID ON PUB_GOODSINFO(TENANT_ID);

CREATE INDEX IX_PUB_GOODSINFO_GODS_ID ON PUB_GOODSINFO(GODS_ID);

CREATE INDEX IX_PUB_GOODSINFO_TIME_STAMP ON PUB_GOODSINFO(TENANT_ID,TIME_STAMP);

--向下发布的供应链与商品
CREATE TABLE PUB_GOODS_RELATION (
        --行号ID <guid>
	ROWS_ID char (36) NOT NULL ,
        --企业代码 
	TENANT_ID int NOT NULL ,
        --供应链
	RELATION_ID int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL , 
        --行业内码<第三方系统内码>
	SECOND_ID varchar (36) , 
        --货号<识别码>
	GODS_CODE varchar (36) , 
        --品名+规格
	GODS_NAME varchar (50) NOT NULL ,
        --拼音码
	GODS_SPELL varchar (50) NOT NULL ,
        --分类1
	SORT_ID1 varchar (36) ,
        --分类2
	SORT_ID2 varchar (36) ,
        --分类3
	SORT_ID3 varchar (36) ,
        --分类4
	SORT_ID4 varchar (36) ,
        --分类5
	SORT_ID5 varchar (36) ,
        --分类6
	SORT_ID6 varchar (36) ,
        --颜色组
	SORT_ID7 varchar (36) ,
        --尺码组
	SORT_ID8 varchar (36) ,
        --自定义9
	SORT_ID9 varchar (36) ,
        --自定义10
	SORT_ID10 varchar (36) ,
        --自定义11
	SORT_ID11 varchar (36) ,
        --自定义12
	SORT_ID12 varchar (36) ,
        --自定义13
	SORT_ID13 varchar (36) ,
        --自定义14
	SORT_ID14 varchar (36) ,
        --自定义15
	SORT_ID15 varchar (36) ,
        --自定义16
	SORT_ID16 varchar (36) ,
        --自定义17
	SORT_ID17 varchar (36) ,
        --自定义18
	SORT_ID18 varchar (36) ,
        --自定义19
	SORT_ID19 varchar (36) ,
        --自定义20
	SORT_ID20 varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_RELATION PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_GOODS_RELATION_RELATION_ID ON PUB_GOODS_RELATION(RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_GODS_ID ON PUB_GOODS_RELATION(GODS_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_KEYFIELD ON PUB_GOODS_RELATION(TENANT_ID,GODS_ID,RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_TIME_STAMP ON PUB_GOODS_RELATION(TENANT_ID,TIME_STAMP);


--企业经营商品视图,自经营商品+连锁商品                                              
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

--条码类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','计量单位','BARCODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','包装1','BARCODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','包装2','BARCODE_TYPE','00',5497000);

--条码表
CREATE TABLE PUB_BARCODE (
        --行号ID
	ROWS_ID char (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL , 
        --尺码ID
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色ID
	PROPERTY_02 varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --条码类型
	BARCODE_TYPE varchar(1) NOT NULL ,
        --批号
	BATCH_NO varchar (36) NOT NULL ,
        --条码
	BARCODE varchar (30) NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_BARCODE PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_BARCODE_TENANT_ID ON PUB_BARCODE(TENANT_ID);

CREATE INDEX IX_PUB_BARCODE_TIME_STAMP ON PUB_BARCODE(TENANT_ID,TIME_STAMP);

CREATE INDEX IX_PUB_BARCODE_GODS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID);

CREATE INDEX IX_PUB_BARCODE_BARCODE ON PUB_BARCODE(TENANT_ID,BARCODE);

CREATE INDEX IX_PUB_BARCODE_ROWS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID);

--企业经营条码表,自经营计量单位+连锁计量单位
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


--定价方式
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','统一定价','PRICE_METHOD','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','门店定价','PRICE_METHOD','00',5497000);

--优惠类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','不优惠','AGIO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','统一折扣率','AGIO_TYPE','00',5497000); 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','分类折扣率','AGIO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','指定售价','AGIO_TYPE','00',5497000);

--积分类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','不积分','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','按金额积分','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','按毛利积分','INTE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','按数量积分','INTE_TYPE','00',5497000);

--客户分类
CREATE TABLE PUB_PRICEGRADE (
        --企业代码
	TENANT_ID int NOT NULL ,
        --编码
	PRICE_ID char (36) NOT NULL ,
        --名称
	PRICE_NAME varchar (30) NOT NULL ,
        --拼音码
	PRICE_SPELL varchar (30) NOT NULL ,
        --积分标准
	INTEGRAL numeric(18, 3) ,
        --积分方法
	INTE_TYPE int ,
        --积分系数 1分=多少金额/毛利/数量
	INTE_AMOUNT decimal(18, 3) ,
        --最低折扣率
	MINIMUM_PERCENT numeric(6, 3) ,
        --优惠类型
	AGIO_TYPE int ,
        --指定折扣率
	AGIO_PERCENT numeric(6, 3) ,
        --分类折扣率
	AGIO_SORTS varchar (1000) ,
        --排序号
	SEQ_NO int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_PRICEGRADE PRIMARY KEY (TENANT_ID,PRICE_ID)
);
CREATE INDEX IX_PUB_PRICEGRADE_TENANT_ID ON PUB_PRICEGRADE(TENANT_ID);
CREATE INDEX IX_PUB_PRICEGRADE_TIME_STAMP ON PUB_PRICEGRADE(TENANT_ID,TIME_STAMP);

--商盟档案
CREATE TABLE PUB_UNION_INFO (
        --<创建商盟的企业,0时代表全国统一，平台创建>
	TENANT_ID int NOT NULL ,
        --商盟编码
	UNION_ID varchar (36) NOT NULL ,
        --商盟名称
	UNION_NAME varchar (50) NOT NULL ,
        --拼音码
	UNION_SPELL varchar (50) NOT NULL ,
        --0 禁用指标 1启用指标
	INDEX_FLAG varchar (1) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_UNION_INFO PRIMARY KEY (TENANT_ID,UNION_ID)
);

CREATE INDEX IX_PUB_UNION_INFO_TENANT_ID ON PUB_UNION_INFO(TENANT_ID);
CREATE INDEX IX_PUB_UNION_INFO_TIME_STAMP ON PUB_UNION_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_UNION_INFO_CLIENT_ID ON PUB_UNION_INFO(UNION_ID);

--商盟指标
CREATE TABLE PUB_UNION_INDEX (
        --<创建商盟的企业,0时代表全国统一，平台创建>
	TENANT_ID int NOT NULL ,
        --商盟编码
	UNION_ID varchar (36) NOT NULL ,
        --指标编码
	INDEX_ID varchar (36) NOT NULL ,
        --指标名称
	INDEX_NAME varchar (50) NOT NULL ,
        --拼音码
	INDEX_SPELL varchar (50) NOT NULL ,
        --指标类型 1是指定选项 ，2是SQL定义选项 可带TENANT_ID参数, 3数值型 4 日期型
	INDEX_TYPE varchar (1) NOT NULL ,
        --指标选项
	INDEX_OPTION varchar (255) NOT NULL ,
        --是否必填项 1是不以为空 2 允许为空
	INDEX_ISNULL varchar (1) NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_UNION_INDEX PRIMARY KEY (TENANT_ID,UNION_ID,INDEX_ID)
);

CREATE INDEX IX_PUB_UNION_INDEX_TENANT_ID ON PUB_UNION_INDEX(TENANT_ID);
CREATE INDEX IX_PUB_UNION_INDEX_TIME_STAMP ON PUB_UNION_INDEX(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_UNION_INDEX_CLIENT_ID ON PUB_UNION_INDEX(TENANT_ID,UNION_ID);


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','客户分类','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','结算方式','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('7','银行编码','CODE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','供应商分类','CODE_TYPE','00',5497000);

--企业客户
CREATE TABLE PUB_CLIENTINFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --编码
	CLIENT_ID varchar (36) NOT NULL ,
        --1 是供应商 2是客户
	CLIENT_TYPE varchar (1) NOT NULL ,
        --代码,<标识码> 
	CLIENT_CODE varchar (20) NOT NULL ,
        --经营许可证 
	LICENSE_CODE varchar (50) ,
        --名称
	CLIENT_NAME varchar (50) NOT NULL ,
        --拼音码
	CLIENT_SPELL varchar (50) NOT NULL ,
        --分类编码
	SORT_ID varchar (36) NOT NULL ,
        --地区编码
	REGION_ID varchar (21) NOT NULL ,
        --结帐方式
	SETTLE_CODE varchar (36) NOT NULL ,
        --地址
	ADDRESS varchar (50) ,
        --邮编
	POSTALCODE varchar (6) ,
        --联系人
	LINKMAN varchar (10) ,
        --电话3
	TELEPHONE3 varchar (30) ,
        --电话1
	TELEPHONE1 varchar (30) ,
        --电话2
	TELEPHONE2 varchar (30) ,
        --传真
	FAXES varchar (30) ,
        --主页
	HOMEPAGE varchar (50) ,
        --电子邮件
	EMAIL varchar (50) ,
        --QQ
  QQ    varchar  (20),
        --MSN
  MSN    varchar  (35),
        --开户行
	BANK_ID varchar (10) ,
        --帐户
	ACCOUNT varchar (20) ,
        --发票类型
	INVOICE_FLAG varchar (50) ,
        --备注
  REMARK varchar (200),
        --进项税率
	TAX_RATE decimal(18, 3) ,
        --客户等级
	PRICE_ID char (36) ,
        --所属门店
	SHOP_ID varchar (11) NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CLIENTINFO PRIMARY KEY (TENANT_ID,CLIENT_ID)
);

CREATE INDEX IX_PUB_CLIENTINFO_TENANT_ID ON PUB_CLIENTINFO(TENANT_ID);
CREATE INDEX IX_PUB_CLIENTINFO_TIME_STAMP ON PUB_CLIENTINFO(TENANT_ID,TIME_STAMP);

--个人消费者<会员>
CREATE TABLE PUB_CUSTOMER (
        --会员编码
	CUST_ID varchar (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --入会门店
	SHOP_ID varchar (11) NOT NULL ,
        --会员号
	CUST_CODE varchar (20) NOT NULL ,
        --会员名称
	CUST_NAME varchar (30) NOT NULL ,
        --拼音码
	CUST_SPELL varchar (30) NOT NULL ,
        --性别
	SEX varchar (4) ,
        --电子邮件
	EMAIL varchar (50) ,
        --办法电话
	OFFI_TELE varchar (30) ,
        --家庭电话
	FAMI_TELE varchar (30) ,
        --移动电话
	MOVE_TELE varchar (30) ,
        --生日
	BIRTHDAY varchar (10) ,
        --家庭地址
	FAMI_ADDR varchar (50) ,
        --邮编
	POSTALCODE varchar (6) ,
    --证件号码
	ID_NUMBER varchar(50),
    --证件类型
	IDN_TYPE varchar(36),
        --入会日期
	SND_DATE varchar (10) ,
        --续会日期
	CON_DATE varchar (10) ,
        --QQ
  QQ    varchar  (20),
        --MSN
  MSN    varchar  (35),
        --有效日期
	END_DATE varchar (10) ,
        --会员分类
	SORT_ID varchar (36) ,
        --客户等级
	PRICE_ID char (36) ,
        --地区编码
	REGION_ID varchar (21) NOT NULL ,
	      --月收入
	MONTH_PAY varchar(36),
	      --学历
	DEGREES varchar(36),
	      --职业
	OCCUPATION varchar(36),
	      --工作单位
	JOBUNIT varchar(50),
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --备注
	REMARK varchar (500) ,
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CUSTOMER PRIMARY KEY (TENANT_ID,CUST_ID)
);

CREATE INDEX IX_PUB_CUSTOMER_TENANT_ID ON PUB_CUSTOMER(TENANT_ID);
CREATE INDEX IX_PUB_CUSTOMER_TIME_STAMP ON PUB_CUSTOMER(TENANT_ID,TIME_STAMP);

--商盟资料收集档案
CREATE TABLE PUB_CUSTOMER_EXT (
        --编号
	ROWS_ID char (36) NOT NULL ,
        --企业号
	TENANT_ID int NOT NULL ,
        --商盟编码
	UNION_ID varchar (36) NOT NULL ,
        --会员编码
	CUST_ID varchar (36) NOT NULL ,
        --指标编号
	INDEX_ID varchar (36) ,
        --指标名称
	INDEX_NAME varchar (50) ,
        --指标类型
	INDEX_TYPE varchar (50) ,
        --指标值
	INDEX_VALUE varchar (50) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_CUST_EXT PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_PUB_CUSTOMER_EXT_TENANT_ID ON PUB_CUSTOMER_EXT(TENANT_ID);
CREATE INDEX IX_PUB_CUSTOMER_EXT_TIME_STAMP ON PUB_CUSTOMER_EXT(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_CUSTOMER_EXT_CUST_ID ON PUB_CUSTOMER_EXT(TENANT_ID,CUST_ID);
CREATE INDEX IX_PUB_CUSTOMER_EXT_INDEX_ID ON PUB_CUSTOMER_EXT(TENANT_ID,UNION_ID,CUST_ID,INDEX_ID);


--IC状态
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','申请','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','审核','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','挂失','IC_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','注销','IC_STATUS','00',5497000);

--IC类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','企业卡','IC_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','商盟卡','IC_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','购物卡','IC_TYPE','00',5497000);

--IC卡信息
CREATE TABLE PUB_IC_INFO (
        --会员编码<不计名卡时，为#>
	CLIENT_ID varchar (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --商盟编号<不是商盟卡时，为#>
	UNION_ID varchar (36) NOT NULL ,
        --IC卡号
	IC_CARDNO varchar (36) NOT NULL ,
        --发卡日期
	CREA_DATE varchar (10) NOT NULL ,
        --有效截止日期
	END_DATE varchar (10) ,
        --发卡用户
	CREA_USER varchar (36) NOT NULL ,
        --摘要
	IC_INFO varchar (100) NOT NULL ,
        --IC卡状态
	IC_STATUS varchar (1) NOT NULL ,
        --IC卡类型
	IC_TYPE varchar (1) NOT NULL ,
        --累计积分
	ACCU_INTEGRAL decimal(10, 3) ,
        --使用积分
	RULE_INTEGRAL decimal(18, 3) ,
        --可用积分
	INTEGRAL decimal(18, 3) ,
        --可用余额
	BALANCE decimal(18, 3) ,
        --消费密码
	PASSWRD varchar (50) ,
        --最近使用日期
	USING_DATE varchar (10) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_IC_INFO PRIMARY KEY (TENANT_ID,UNION_ID,IC_CARDNO)     
    
);

CREATE INDEX IX_PUB_IC_INFO_TENANT_ID ON PUB_IC_INFO(TENANT_ID);
CREATE INDEX IX_PUB_IC_INFO_TIME_STAMP ON PUB_IC_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_PUB_IC_INFO_CLIENT_ID ON PUB_IC_INFO(TENANT_ID,CLIENT_ID);
CREATE INDEX IX_PUB_IC_INFO_IC_CARDNO ON PUB_IC_INFO(TENANT_ID,IC_CARDNO);


--供应商+我的供应商+我的经销商
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

--所有消费者<会员+企业客户>
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

--商品价格
CREATE TABLE PUB_GOODSPRICE (
        --企业代码
	TENANT_ID int NOT NULL ,
        --客户类型 # 号为所有客户
	PRICE_ID char (36) NOT NULL , 
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --货号编码
	GODS_ID char (36) NOT NULL ,
        --定价方式<变价方式>
	PRICE_METHOD varchar (1) NOT NULL ,
        --计量单位售价
	NEW_OUTPRICE decimal(18, 3) ,
        --包装1单位售价
	NEW_OUTPRICE1 decimal(18, 3) ,
        --包装2单位售价
	NEW_OUTPRICE2 decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --更新时间 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GOODSPRICE PRIMARY KEY (TENANT_ID,GODS_ID,SHOP_ID,PRICE_ID)
);

CREATE INDEX IX_PUB_GOODSPRICE_TENANT_ID ON PUB_GOODSPRICE(TENANT_ID);
CREATE INDEX IX_PUB_GOODSPRICE_SHOP_ID ON PUB_GOODSPRICE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_PUB_GOODSPRICE_GODS_ID ON PUB_GOODSPRICE(TENANT_ID,GODS_ID);
CREATE INDEX IX_PUB_GOODSPRICE_PRICE_ID ON PUB_GOODSPRICE(TENANT_ID,PRICE_ID);
CREATE INDEX IX_PUB_GOODSPRICE_TIME_STAMP ON PUB_GOODSPRICE(TENANT_ID,TIME_STAMP);

--各商品在企业总部的价格<售价>，不分门店
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

--每个门店都有记录，关联需加门店
--各商品价格
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

--商品扩展表
CREATE TABLE PUB_GOODSINFOEXT (
        --企业代码
	TENANT_ID int NOT NULL ,
        --货号编码
	GODS_ID char (36) NOT NULL ,
        --计量单位最新进价
	NEW_INPRICE decimal(18, 3) ,
        --包装1单位最新进价
	NEW_INPRICE1 decimal(18, 3) ,
        --包装2单位最新进价
	NEW_INPRICE2 decimal(18, 3) ,
        --安全库存
	LOWER_AMOUNT decimal(18, 3) ,
        --上限库存
	UPPER_AMOUNT decimal(18, 3) ,
        --最低存销比
	LOWER_RATE decimal(18, 3) ,
        --最高存销比
	UPPER_RATE decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --更新时间 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_GIEXT PRIMARY KEY (TENANT_ID,GODS_ID)
);
CREATE INDEX IX_PUB_GOODSINFOEXT_TENANT_ID ON PUB_GOODSINFOEXT(TENANT_ID);
CREATE INDEX IX_PUB_GOODSINFOEXT_TIME_STAMP ON PUB_GOODSINFOEXT(TENANT_ID,TIME_STAMP);

--每个门店都有记录，关联需加门店
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
            
--每个门店都有记录，关联需加门店
CREATE view VIW_GOODSPRICE_SORTEXT
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSPRICEEXT j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
      
--商品分类视图不分门店
CREATE view VIW_GOODSINFO_SORTEXT
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSINFO j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
          
--变价记录
CREATE TABLE LOG_PRICING_INFO (
        --行号ID
	ROWS_ID char (36) NOT NULL ,
        --变价日期 20080101
	PRICING_DATE int NOT NULL , 
        --操作员
	PRICING_USER varchar(36) NOT NULL , 
        --企业代码
	TENANT_ID int NOT NULL ,
        --客户类型 # 号为所有客户
	PRICE_ID char (36) NOT NULL , 
        --门店代码 0 时代码所有门店
	SHOP_ID varchar (11) NOT NULL ,
        --货号编码
	GODS_ID char (36) NOT NULL ,
        --定价方式
	PRICE_METHOD varchar (1) NOT NULL ,
        --计量单位售价
	ORG_OUTPRICE decimal(18, 3) ,
        --包装1单位售价
	ORG_OUTPRICE1 decimal(18, 3) ,
        --包装2单位售价
	ORG_OUTPRICE2 decimal(18, 3) ,
        --计量单位售价
	NEW_OUTPRICE decimal(18, 3) ,
        --包装1单位售价
	NEW_OUTPRICE1 decimal(18, 3) ,
        --包装2单位售价
	NEW_OUTPRICE2 decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --更新时间 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_LOG_PI_INFO PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_LOG_PRICING_INFO_TENANT_ID ON LOG_PRICING_INFO(TENANT_ID);
CREATE INDEX IX_LOG_PRICING_INFO_PRICING_DATE ON LOG_PRICING_INFO(TENANT_ID,PRICING_DATE);
CREATE INDEX IX_LOG_PRICING_INFO_TIME_STAMP ON LOG_PRICING_INFO(TENANT_ID,TIME_STAMP);

--当前库存
CREATE TABLE STO_STORAGE (
        --行ID
	ROWS_ID varchar(36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --批号，没批号用 #号
	BATCH_NO varchar (20) NOT NULL,
        --货品代码
	GODS_ID varchar (38) NOT NULL ,
        --尺码 不分的用 #号
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色 不分的用 #号
	PROPERTY_02 varchar (36) NOT NULL ,
        --最近入库日期
	NEAR_INDATE varchar (10) ,
        --最近出库日期
	NEAR_OUTDATE varchar (10) ,
        --成本金额
	AMONEY decimal(18, 3) NOT NULL ,
        --库存数量
	AMOUNT decimal(18, 3) ,
        --成本单价
	COST_PRICE decimal(18, 6) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_STO_STORAGE PRIMARY KEY (ROWS_ID)
);
CREATE INDEX IX_STO_STORAGE_TENANT_ID ON STO_STORAGE(TENANT_ID);
CREATE INDEX IX_STO_STORAGE_TIME_STAMP ON STO_STORAGE(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_STO_STORAGE_GODS_ID ON STO_STORAGE(TENANT_ID,GODS_ID);
CREATE INDEX IX_STO_STORAGE_SHOP_ID ON STO_STORAGE(TENANT_ID,SHOP_ID);
CREATE INDEX IX_STO_STORAGE_KEYINDEX ON STO_STORAGE(TENANT_ID,SHOP_ID,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO);

--会员是否再打折
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','不打折','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','再打折','RATE_OFF','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','指定折','RATE_OFF','00',5497000);

--促销单表头<单据都以表头COMM,TIME_STAMP通讯标志为准>
CREATE TABLE SAL_PRICEORDER (
        --记录ID号
	PROM_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --开单门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --开始时间 yyyy-mm-dd hh:mm:ss
	BEGIN_DATE varchar (25) NOT NULL ,
        --结束时间 yyyy-mm-dd hh:mm:ss
	END_DATE varchar (25) NOT NULL ,
        --会员等级#号时对所有客户
	PRICE_ID char (36) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --备注
	REMARK varchar (100) ,
        --制单日期
	CREA_DATE int ,
        --制单人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 从2011-01-01开始的秒数
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_SAL_PRICEORDER PRIMARY KEY (TENANT_ID,PROM_ID)
);

CREATE INDEX IX_SAL_PRICEORDER_TENANT_ID ON SAL_PRICEORDER(TENANT_ID);
CREATE INDEX IX_SAL_PRICEORDER_TIME_STAMP ON SAL_PRICEORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_PRICEORDER_SHOP_ID ON SAL_PRICEORDER(TENANT_ID,SHOP_ID);

--促销单发布门店
CREATE TABLE SAL_PROM_SHOP (
        --行ID
	ROWS_ID varchar(36) NOT NULL ,
        --记录ID号
	PROM_ID varchar (50) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
  CONSTRAINT PK_SAL_PROM_SHOP PRIMARY KEY (ROWS_ID)
);

CREATE INDEX IX_SAL_PROM_SHOP_TENANT_ID ON SAL_PROM_SHOP(TENANT_ID);
CREATE INDEX IX_SAL_PROM_SHOP_SHOP_ID ON SAL_PROM_SHOP(TENANT_ID,PROM_ID);

--促销单明细
CREATE TABLE SAL_PRICEDATA (
        --记录ID号
	PROM_ID varchar (50) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --商品代码
	GODS_ID char (36) NOT NULL ,
        --计量单位售价
	NEW_OUTPRICE decimal(18, 3) ,
        --包装1单位售价
	NEW_OUTPRICE1 decimal(18, 3) ,
        --包装2单位售价
	NEW_OUTPRICE2 decimal(18, 3) ,
        --会员是否再打折
	RATE_OFF int NOT NULL ,
        --会员再打折率
	AGIO_RATE numeric(18, 3) ,
        --是否积分 1为只对会员,0为不积分
	ISINTEGRAL int NOT NULL ,
	CONSTRAINT PK_SAL_PRICEDATA PRIMARY KEY  
	(
		PROM_ID,TENANT_ID,SEQNO
	) 
);

CREATE INDEX IX_SAL_PRICEDATA_TENANT_ID ON SAL_PRICEDATA(TENANT_ID);
CREATE INDEX IX_SAL_PRICEDATA_GODS_ID ON SAL_PRICEDATA(GODS_ID);

--各门店促销价格
CREATE view VIW_PROM_PRICE
as
select C.SHOP_ID,B.PRICE_ID,A.TENANT_ID,A.GODS_ID,A.NEW_OUTPRICE,A.NEW_OUTPRICE1,A.NEW_OUTPRICE2,A.RATE_OFF,A.AGIO_RATE,A.ISINTEGRAL from SAL_PRICEDATA A,SAL_PRICEORDER B,SAL_PROM_SHOP C
where A.TENANT_ID=B.TENANT_ID and A.PROM_ID=B.PROM_ID and A.TENANT_ID=C.TENANT_ID and A.PROM_ID=C.PROM_ID and B.COMM not in ('02','12') and B.CHK_DATE IS NOT NULL and 
B.BEGIN_DATE<=TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS') and B.END_DATE>=TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS');

--发票类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','收款收据','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','普通发票','INVOICE_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','增值税票','INVOICE_FLAG','00',5497000);

--入库类单据类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','入库单','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','STOCK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','STOCK_TYPE','00',5497000);

--入库单表头
CREATE TABLE STK_STOCKORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --入库单号
	STOCK_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --单据类型
	STOCK_TYPE int NOT NULL,
        --入库日期
	STOCK_DATE int NOT NULL ,
        --采购员
	GUIDE_USER varchar (36) ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --订货单号
	FROM_ID char (36) ,
        --配货单号
	FIG_ID char (36) ,
        --调拨单号
	DBOUT_ID char (36) ,
        --预付款
	ADVA_MNY decimal(18, 3) ,
        --入库数量
	STOCK_AMT decimal(18, 3) ,
        --入库金额
	STOCK_MNY decimal(18, 3) ,
        --发票类型
	INVOICE_FLAG varchar (1) NOT NULL ,
        --进项税率
	TAX_RATE decimal(18, 3) ,
        --备注
	REMARK varchar (100) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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

--业务类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','正常','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','赠送','IS_PRESENT','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','兑换','IS_PRESENT','00',5497000);

--入库单明细
CREATE TABLE STK_STOCKDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --入库单号
	STOCK_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码<不分时用 # 号>
	PROPERTY_01 varchar (20) NOT NULL ,
        --颜色<不分时用 # 号>
	PROPERTY_02 varchar (20) NOT NULL ,
        --批号
	BATCH_NO varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --礼盒跟踪号
	BOM_ID varchar (36) ,
        --数量
	AMOUNT decimal(18, 3) ,
        --进货单位标准售价
	ORG_PRICE decimal(18, 3) ,
        --入库类型<是否赠品>
	IS_PRESENT int NOT NULL,
        --现售价
	APRICE decimal(18, 3) ,
        --金额
	AMONEY decimal(18, 3) ,
        --折扣率
	AGIO_RATE decimal(18, 3) ,
        --折扣额
	AGIO_MONEY decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,
        --入库金额
	CALC_MONEY decimal(18, 3) ,
        --备注
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

--进货单视图<含退货>
CREATE VIEW VIW_STOCKDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,A.ORG_PRICE*A.AMOUNT as STOCK_RTL,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--调拨接收单视图
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY as COST_MONEY,A.ORG_PRICE*A.AMOUNT as RTL_MONEY,A.AMOUNT,A.APRICE,A.ORG_PRICE
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (2) and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','销售单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','调拨单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','退货单','SALES_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','零售单','SALES_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','销售方式','CODE_TYPE','00',5497000);

--销售单表头
CREATE TABLE SAL_SALESORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --销售单号
	SALES_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --销售日期
	SALES_DATE int NOT NULL ,
        --单据类型
	SALES_TYPE int NOT NULL,
        --客户代码
	CLIENT_ID varchar (36) ,
        --IC卡号
	IC_CARDNO varchar (36) ,
        --商盟编码
	UNION_ID varchar (36) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --订货单号
	FROM_ID char (36) ,
        --配货单号
	FIG_ID char (36) ,
        --预付款
	ADVA_MNY decimal(18, 3) ,
        --销售数量
	SALE_AMT decimal(18, 3) ,
        --销售金额
	SALE_MNY decimal(18, 3) ,
        --抹零金额
	PAY_DIBS decimal(18, 3) ,
        --实收现金
	CASH_MNY decimal(18, 3) ,
        --现金找零
	PAY_ZERO decimal(18, 3) ,
        --结算方式
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
        --本单积分
	INTEGRAL int ,
        --兑换积分
	BARTER_INTEGRAL int,
        --备注
	REMARK varchar (100) ,
        --发票类型
	INVOICE_FLAG varchar (1) ,
        --销项税率
	TAX_RATE decimal(18, 3) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --制单人
	CREA_USER varchar (36) ,
        --业务员<导购员>
	GUIDE_USER varchar (36) ,
        --销售方式
	SALES_STYLE varchar (21) ,
        --送货日期
	PLAN_DATE varchar (10) ,
        --联系人
	LINKMAN varchar (20) ,
        --联系电话
	TELEPHONE varchar (30) ,
        --送货地址
	SEND_ADDR varchar (255) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','统一定价','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','门店定价','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','产品促销','POLICY_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','变价销售','POLICY_TYPE','00',5497000);

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','付款方式','CODE_TYPE','00',5497000);

insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'A','现金','XJ','1',1,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'B','银联','YL','1',2,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'C','储值卡','CZK','1',3,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'D','记账','JZ','1',4,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'E','转账','LQ','1',5,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'F','支票','ZP','1',6,'00',5497000);
insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values(0,'G','礼券','XEZF','1',7,'00',5497000);

CREATE VIEW VIW_PAYMENT
as
select B.TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,A.COMM,A.TIME_STAMP from PUB_CODE_INFO A,CA_TENANT B where A.TENANT_ID=0 and A.CODE_TYPE='1'
union all
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,COMM,TIME_STAMP from PUB_CODE_INFO where TENANT_ID>0 and CODE_TYPE='1';

--销售单明细
CREATE TABLE SAL_SALESDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --销售单号
	SALES_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --货品
	GODS_ID char (36) NOT NULL ,
        --尺码<不分时用 # 号>
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色<不分时用 # 号>
	PROPERTY_02 varchar (36) NOT NULL ,
        --批号
	BATCH_NO varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --礼盒跟踪号
	BOM_ID varchar (36) ,
        --数量
	AMOUNT decimal(18, 3) ,
        --销售单位标准售价
	ORG_PRICE decimal(18, 3) ,
        --定价类型
	POLICY_TYPE int NOT NULL,
        --是否赠品
	IS_PRESENT int NOT NULL,
        --兑换积分<最小单位所需的积分>
	BARTER_INTEGRAL int,
        --现售价
	APRICE decimal(18, 3) ,
        --金额
	AMONEY decimal(18, 3) ,
        --当前计量单位进价
	COST_PRICE decimal(18, 3) ,
        --折扣率
	AGIO_RATE decimal(18, 3) ,
        --折扣额
	AGIO_MONEY decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,
        --出库金额
	CALC_MONEY decimal(18, 3) ,  
        --是否有积分
	HAS_INTEGRAL int NOT NULL ,
        --说明
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

--销售视图<含退货>
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

--调拨出货单视图
CREATE VIEW VIW_MOVEOUTDATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.SALES_TYPE,A.CREA_DATE, 
  B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as RTL_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,B.APRICE,B.ORG_PRICE,B.COST_PRICE,B.AMOUNT
from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (2) and A.COMM not in ('02','12');

--流水类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','充值','IC_GLIDE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','支付','IC_GLIDE_TYPE','00',5497000);

--储值卡流水记录
CREATE TABLE SAL_IC_GLIDE (
        --流水ID号
	GLIDE_ID char (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --客户ID<不记名卡用 #>
	CLIENT_ID varchar (36) NOT NULL ,
        --IC卡号
	IC_CARDNO varchar (36) NOT NULL ,
        --销售单号
	SALES_ID char (36) ,
        --操作员
	CREA_USER varchar (36) NOT NULL ,
        --日期
	CREA_DATE int NOT NULL ,
        --摘要
	GLIDE_INFO varchar (100) NOT NULL ,
        --流水类型
	IC_GLIDE_TYPE varchar (1) NOT NULL ,
        --结算方式
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
        --金额
	GLIDE_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--积分类型
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','赠送积分','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','兑换礼券','INTEGRAL_FLAG','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','返还现金','INTEGRAL_FLAG','00',5497000);

--积分对换
CREATE TABLE SAL_INTEGRAL_GLIDE (
        --流水ID号
	GLIDE_ID char (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --客户ID
	CLIENT_ID varchar (36) NOT NULL ,
        --IC卡号
	IC_CARDNO varchar (36) NOT NULL ,
        --流水日期
	CREA_DATE int NOT NULL ,
        --操作员
	CREA_USER varchar (36) NOT NULL ,
        --类型
	INTEGRAL_FLAG varchar (1) NOT NULL ,
        --摘要
	GLIDE_INFO varchar (255) NOT NULL ,
        --积分
	INTEGRAL decimal(18, 3) ,
        --对换值<礼券张数，或现金金额>
	GLIDE_AMT decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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


--调整单类型 最多能添加种类型 1,2,3,4,5 代码分别为
CREATE TABLE STO_CHANGECODE (
        --企业代码
	TENANT_ID int NOT NULL ,
        --代码
	CHANGE_CODE varchar (10) NOT NULL ,
        --名称
	CHANGE_NAME varchar (20) NOT NULL ,
        --出入类型
	CHANGE_TYPE varchar (1) NOT NULL ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_STO_CHANGECODE PRIMARY KEY 
	(
		TENANT_ID,CHANGE_CODE
	) 
);

insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'1','损益','2','00',5497000);
insert into STO_CHANGECODE(TENANT_ID,CHANGE_CODE,CHANGE_NAME,CHANGE_TYPE,COMM,TIME_STAMP) values(0,'2','领用','2','00',5497000);

--调整单
CREATE TABLE STO_CHANGEORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号
	CHANGE_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --调整日期
	CHANGE_DATE int NOT NULL ,
        --出入类型
	CHANGE_TYPE varchar (1) NOT NULL ,
        --类型代码
	CHANGE_CODE varchar (10) NOT NULL ,
        --所属部门
	DEPT_ID varchar (11) ,
        --负责人
	DUTY_USER varchar (36) ,
        --调整数量
	CHANGE_AMT decimal(18, 3) ,
        --调整金额
	CHANGE_MNY decimal(18, 3) ,
        --备注
	REMARK varchar (100) ,
        --审核用户
	CHK_USER varchar (36) ,
        --审核人员
	CHK_DATE varchar (10) ,
        --来源单号,对盘点单时对应盘点表的ID号
	FROM_ID char (36) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--库存调整单明细
CREATE TABLE STO_CHANGEDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号
	CHANGE_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码 不分的用 #号
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色 不分的用 #号
	PROPERTY_02 varchar (36) NOT NULL ,
        --是否赠品
	IS_PRESENT int NOT NULL,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --礼盒跟踪号
	BOM_ID char (36)  ,
        --批号
	BATCH_NO varchar (36) ,
        --数量
	AMOUNT decimal(18, 3) ,
        --现售价
	APRICE decimal(18, 3) ,
        --金额
	AMONEY decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,
        --当前计量单位进价
	COST_PRICE decimal(18, 3) ,
        --出库金额
	CALC_MONEY decimal(18, 3) ,  
        --调整说明
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

--进货订单
CREATE TABLE STK_INDENTORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号
	INDE_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --订货日期
	INDE_DATE int ,
        --送货日期
	PLAN_DATE varchar (10) ,
        --联系人
	LINKMAN varchar (20) ,
        --联系电话
	TELEPHONE varchar (30) ,
        --送货地址
	SEND_ADDR varchar (255) ,
        --采购员
	GUIDE_USER varchar (30) ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --配货单号
	FIG_ID char (36) ,
        --预付款
	ADVA_MNY decimal(18, 3) ,
        --订货数量
	INDE_AMT decimal(18, 3) ,
        --订货金额
	INDE_MNY decimal(18, 3) ,
        --发票类型
	INVOICE_FLAG varchar (1) ,
        --进项税率
	TAX_RATE decimal(18, 3) ,
        --备注
	REMARK varchar (100) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --时间戳 当前系统日期*86400000
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

--进货订单明细
CREATE TABLE STK_INDENTDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --订单号
	INDE_ID char (36) NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色
	PROPERTY_02 varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --礼盒跟踪号
	BOM_ID char (36)  ,
        --批号
	BATCH_NO varchar (36) ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --需求数量
	DEMAND_AMOUNT decimal(18, 3) ,
        --订货数量
	AMOUNT decimal(18, 3) ,
        --原单价
	ORG_PRICE decimal(18, 3) ,
        --是否赠品
	IS_PRESENT int NOT NULL,
        --现售价
	APRICE decimal(18, 3) ,
        --金额
	AMONEY decimal(18, 3) ,
        --折扣率
	AGIO_RATE decimal(18, 3) ,
        --折扣额
	AGIO_MONEY decimal(18, 3) ,
        --计量单位数量
	CALC_AMOUNT decimal(18, 3) ,
        --到货数量
	FNSH_AMOUNT decimal(18, 3) ,
        --入库金额
	CALC_MONEY decimal(18, 3) ,
        --备注
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

--进货订单视图
CREATE VIEW VIW_STKINDENTDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.INDE_ID,B.INVOICE_FLAG,B.INDE_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.AMOUNT,
   dec(round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2),18,3) as TAX_MONEY,
   dec(A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2),18,3) as NOTAX_MONEY
from STK_INDENTDATA A,STK_INDENTORDER B where A.TENANT_ID=B.TENANT_ID and A.INDE_ID=B.INDE_ID and B.COMM not in ('02','12');

--销售订单
CREATE TABLE SAL_INDENTORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号
	INDE_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --订货日期
	INDE_DATE int NOT NULL ,
        --送货日期
	PLAN_DATE varchar (10) ,
        --联系人
	LINKMAN varchar (20) ,
        --联系电话
	TELEPHONE varchar (30) ,
        --送货地址
	SEND_ADDR varchar (255) ,
        --业务员<导购员>
	GUIDE_USER varchar (36) ,
        --销售方式
	SALES_STYLE varchar (21) ,
        --客户
	CLIENT_ID varchar (36) NOT NULL ,
        --IC卡号
	IC_CARDNO varchar (36) ,
        --商盟编码
	UNION_ID varchar (36) ,
        --预付款
	ADVA_MNY decimal(18, 3) ,
        --订货数量
	INDE_AMT decimal(18, 3) ,
        --订货金额
	INDE_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --配货单号
	FIG_ID char (36) ,
        --发票类型
	INVOICE_FLAG varchar (1) ,
        --销项税率
	TAX_RATE decimal(18, 3) ,
        --备注
	REMARK varchar (100) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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

--销售订单明细
CREATE TABLE SAL_INDENTDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --订单号
	INDE_ID char (36) NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色
	PROPERTY_02 varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --礼盒跟踪号
	BOM_ID varchar (36)  ,
        --批号
	BATCH_NO varchar (36) ,
        --需求数量
	DEMAND_AMOUNT decimal(18, 3) ,
        --数量
	AMOUNT decimal(18, 3) ,
        --原单价
	ORG_PRICE decimal(18, 3) ,
        --定价类型
	POLICY_TYPE int NOT NULL,
        --是否赠品
	IS_PRESENT int NOT NULL,
        --兑换积分
	BARTER_INTEGRAL int,
        --现售价
	APRICE decimal(18, 3) ,
        --金额
	AMONEY decimal(18, 3) ,
        --折扣率
	AGIO_RATE decimal(18, 3) ,
        --折扣额
	AGIO_MONEY decimal(18, 3) ,
        --计量单位数量
	CALC_AMOUNT decimal(18, 3) ,
        --执行数量
	FNSH_AMOUNT decimal(18, 3) ,
        --入库金额
	CALC_MONEY decimal(18, 3) ,
        --备注
	REMARK varchar (100) ,
        --是否有积分
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

--销售订单视图
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

--盘点状态 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','待盘点','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','已盘点','CHECK_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','已审核','CHECK_STATUS','00',5497000);

--盘点方式 
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','简单盘点','CHECK_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','多人盘点','CHECK_TYPE','00',5497000);

--盘点表表头
CREATE TABLE STO_PRINTORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --盘点日期 
	PRINT_DATE int NOT NULL ,
        --盘点状态
	CHECK_STATUS int NOT NULL ,
        --盘点方式
	CHECK_TYPE int NOT NULL ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --审核用户
	CHK_USER varchar (36) ,
        --审核人员
	CHK_DATE varchar (10) ,
        --通读标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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

--盘点表明细
CREATE TABLE STO_PRINTDATA (
        --行号
	ROWS_ID varchar(36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --盘点日期 
	PRINT_DATE int NOT NULL ,
        --批号，没批号用 #号
	BATCH_NO varchar (36) NOT NULL,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --礼盒跟踪号
	BOM_ID char (36) ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码 不分的用 #号
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色 不分的用 #号
	PROPERTY_02 varchar (36) NOT NULL ,
        --帐面库存
	RCK_AMOUNT decimal(18, 3) ,
        --盘点库存
	CHK_AMOUNT decimal(18, 3) ,
        --盘点状态 
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

--盘点录入表
CREATE TABLE STO_CHECKDATA (
        --行号
	ROWS_ID varchar(36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --盘点日期 
	PRINT_DATE int NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --尺码
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色
	PROPERTY_02 varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --礼盒跟踪号
	BOM_ID char (36)  ,
        --批号
	BATCH_NO varchar (36) ,
        --帐面库存
	AMOUNT decimal(18, 3) ,
        --帐面库存
	CALC_AMOUNT decimal(18, 3) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
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

--帐户档案
CREATE TABLE ACC_ACCOUNT_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --帐户代码
	ACCOUNT_ID char (36) NOT NULL ,
        --所属门店<为每个门店自动创建一个<现金账户>
	SHOP_ID varchar (11) NOT NULL ,
        --帐户名称
	ACCT_NAME varchar (50) NOT NULL ,
        --拼音码
	ACCT_SPELL varchar (50) NOT NULL ,
        --对应支付方式
	PAYM_ID varchar (1) NOT NULL ,
        --期初余额
	ORG_MNY decimal(18, 3) ,
        --支收总额 
	OUT_MNY decimal(18, 3) ,
        --收入总额 
	IN_MNY decimal(18, 3) ,
        --当前余额
	BALANCE decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--定义收支项目编号
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','收支项目','CODE_TYPE','00',5497000);

CREATE VIEW VIW_ITEM_INFO
as
select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_CODE_INFO where CODE_TYPE='3';


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','应收款','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','应退款','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','预付款','RECV_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','零售款','RECV_TYPE','00',5497000);

--应收帐款
CREATE TABLE ACC_RECVABLE_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --序号
	ABLE_ID char (36) NOT NULL ,
        --客户
	CLIENT_ID varchar (36) NOT NULL ,
        --摘要
	ACCT_INFO varchar (255) NOT NULL ,
        --类型
	RECV_TYPE varchar (1) NOT NULL ,
        --收款方式
	PAYM_ID varchar (1) ,
        --帐款金额
	ACCT_MNY decimal(18, 3) ,
        --已收金额
	RECV_MNY decimal(18, 3) ,
        --结余金额
	RECK_MNY decimal(18, 3) ,
        --冲帐金额
	REVE_MNY decimal(18, 3) ,
        --帐款日期
	ABLE_DATE int ,
        --最近收款日期
	NEAR_DATE varchar (10) ,
        --来源单号
	SALES_ID varchar (50) ,
        --记录生成日期
	CREA_DATE varchar (30) ,
        --操作用户
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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


insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','应付款','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('5','应退款','ABLE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('6','预付款','ABLE_TYPE','00',5497000);

--应付帐款
CREATE TABLE ACC_PAYABLE_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --序号
	ABLE_ID char (36) NOT NULL ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --摘要
	ACCT_INFO varchar (255) NOT NULL ,
        --类型
	ABLE_TYPE varchar (1) NOT NULL ,
        --帐款金额
	ACCT_MNY decimal(18, 3) ,
        --已付金额
	PAYM_MNY decimal(18, 3) ,
        --结余金额
	RECK_MNY decimal(18, 3) ,
        --冲帐金额
	REVE_MNY decimal(18, 3) ,
        --帐款日期
	ABLE_DATE int ,
        --最近付款日期
	NEAR_DATE varchar (10) ,
        --来源单号
	STOCK_ID varchar (50) ,
        --记录生成日期
	CREA_DATE varchar (20) ,
        --操作用户
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
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

--付款单
CREATE TABLE ACC_PAYORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	PAY_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --帐户代码
	ACCOUNT_ID char (36) NOT NULL ,
        --付款方式
	PAYM_ID varchar (1) NOT NULL ,
        --收支项目
	ITEM_ID varchar (36) NOT NULL ,
        --财务日期
	PAY_DATE int ,
        --付款人
	PAY_USER varchar (30) ,
        --付款总计
	PAY_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --票据编号
	BILL_NO varchar (50) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--付款单明细
CREATE TABLE ACC_PAYDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	PAY_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --帐款ID号
	ABLE_ID char (36) NOT NULL ,
        --类型
	ABLE_TYPE varchar (1) NOT NULL ,
        --支付金额
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

--收款单
CREATE TABLE ACC_RECVORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	RECV_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --供应商
	CLIENT_ID varchar (36) NOT NULL ,
        --帐户代码
	ACCOUNT_ID char (36) NOT NULL ,
        --付款方式
	PAYM_ID varchar (1) NOT NULL ,
        --收支项目
	ITEM_ID varchar (36) NOT NULL ,
        --财务日期
	RECV_DATE int ,
        --付款人
	RECV_USER varchar (30) ,
        --收款合计
	RECV_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --票据编号
	BILL_NO varchar (50) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--收款单明细
CREATE TABLE ACC_RECVDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	RECV_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --帐款ID号
	ABLE_ID char (36) NOT NULL ,
        --类型
	RECV_TYPE varchar (1) NOT NULL ,
        --支付金额
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','收入','IORO_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','支出','IORO_TYPE','00',5497000);

--收入支出
CREATE TABLE ACC_IOROORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	IORO_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --客户名称
	CLIENT_ID varchar (36) ,
        --收支项目
	ITEM_ID varchar (36) NOT NULL ,
        --收支部门
	DEPT_ID varchar (10) ,
        --收支日期
	IORO_TYPE varchar (1) NOT NULL ,
        --收支日期
	IORO_DATE int NOT NULL ,
        --负责人
	IORO_USER varchar (36) ,
        --合计金额
	IORO_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳
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

--收支明细
CREATE TABLE ACC_IORODATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	IORO_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL ,
        --收支账户
	ACCOUNT_ID char (36) NOT NULL ,
        --对应支付方式
	PAYM_ID varchar (1) NOT NULL ,
        --票据编号
	BILL_NO varchar(50) ,
        --摘要
	IORO_INFO varchar (255) NOT NULL ,
        --收支金额
	IORO_MNY decimal(18, 3) ,
	CONSTRAINT PK_ACC_IORODATA PRIMARY KEY  
	(
		TENANT_ID,IORO_ID,SEQNO
	) 
) ;
CREATE INDEX IX_ACC_IORODATA_TENANT_ID ON ACC_IORODATA(TENANT_ID);
CREATE INDEX IX_ACC_IORODATA_CLIENT_ID ON ACC_IORODATA(TENANT_ID,IORO_ID);

--收入支出视图
CREATE VIEW VIW_IORODATA
as
select 
  A.TENANT_ID,A.SHOP_ID,A.IORO_ID,A.ACCOUNT_ID,A.IORO_INFO,A.IORO_MNY,B.IORO_DATE,B.CLIENT_ID,B.ITEM_ID,B.DEPT_ID,B.GLIDE_NO,B.IORO_USER,
  case when B.IORO_TYPE='1' then A.IORO_MNY else 0 end as IN_MONEY,
  case when B.IORO_TYPE='2' then A.IORO_MNY else 0 end as OUT_MONEY
from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and B.COMM not in ('02','12');

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','门店销售','CLSE_TYPE','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','会员充值','CLSE_TYPE','00',5497000);
--交班结账表
CREATE TABLE ACC_CLOSE_FORDAY (
        --行号
	ROWS_ID char (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --关账类型
	CLSE_TYPE char (1) NOT NULL ,
        --关账日期
	CLSE_DATE int,
        --关账金额
	CLSE_MNY decimal(18, 3) ,
        --结算方式
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
	      --保留零钱
	BALANCE decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_CLSE_FORDAY PRIMARY KEY  
	(
		ROWS_ID
	) 
) ;
CREATE INDEX IX_ACC_CLOSE_FORDAY_TENANT_ID ON ACC_CLOSE_FORDAY(TENANT_ID);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATE ON ACC_CLOSE_FORDAY(CLSE_DATE);
CREATE INDEX IX_ACC_CLOSE_FORDAY_CLSE_DATA ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

--存取款单
CREATE TABLE ACC_TRANSORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	TRANS_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --转入账号
	IN_ACCOUNT_ID char (36) NOT NULL ,
        --转出账号
	OUT_ACCOUNT_ID char (36) NOT NULL ,
        --日期
	TRANS_DATE int NOT NULL ,
        --负责人
	TRANS_USER varchar (36) ,
	      --存取金额
	TRANS_MNY decimal(18, 3) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --票据编号
	BILL_NO varchar(50) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_ACC_TRANSORDER PRIMARY KEY 
	(
		TENANT_ID,TRANS_ID
	) 
) ;

CREATE INDEX IX_ACC_TRANSORDER_TENANT_ID ON ACC_TRANSORDER(TENANT_ID);
CREATE INDEX IX_ACC_TRANSORDER_TIME_STAMP ON ACC_TRANSORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_ACC_TRANSORDER_TRANS_DATE ON ACC_TRANSORDER(TENANT_ID,TRANS_DATE);


--礼盒包装<BOM清单>
CREATE TABLE SAL_BOMORDER (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码<发布门店>
	SHOP_ID varchar (11) NOT NULL ,
        --单号序号
	BOM_ID char (36) NOT NULL ,
        --流水号
	GLIDE_NO varchar (20) NOT NULL ,
        --礼盒编号
	GIFT_CODE varchar (36) NOT NULL ,
        --礼盒名称
	GIFT_NAME varchar (36) NOT NULL ,
        --条码
	BARCODE varchar (36) NOT NULL ,
        --礼盒数量
	BOM_AMOUNT decimal(18, 3) ,
        --结余数量
	RCK_AMOUNT decimal(18, 3) ,
        --零售价
	RTL_PRICE decimal(18, 3) ,
        --包装日期
	BOM_DATE int NOT NULL ,
        --负责人
	BOM_USER varchar (36) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --说明
	REMARK varchar (255) ,
        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_BOMORDER PRIMARY KEY 
	(
		TENANT_ID,BOM_ID
	) 
) ;

CREATE INDEX IX_SAL_BOMORDER_TENANT_ID ON SAL_BOMORDER(TENANT_ID);
CREATE INDEX IX_SAL_BOMORDER_TIME_STAMP ON SAL_BOMORDER(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMORDER_BOM_DATE ON SAL_BOMORDER(TENANT_ID,BOM_DATE);

--礼盒子件商品清单<BOM清单>
CREATE TABLE SAL_BOMDATA (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --单号
	BOM_ID char (36) NOT NULL ,
        --序号
	SEQNO int NOT NULL,
        --批号，没批号用 #号
	BATCH_NO varchar (36) NOT NULL,
        --物流跟踪号
	LOCUS_NO varchar (36) ,
        --货品代码
	GODS_ID char (36) NOT NULL ,
        --计量单位
	UNIT_ID varchar (36) NOT NULL ,
        --尺码 不分的用 #号
	PROPERTY_01 varchar (36) NOT NULL ,
        --颜色 不分的用 #号
	PROPERTY_02 varchar (36) NOT NULL ,
        --一个礼盒所拥有的数量
	AMOUNT decimal(18, 3) ,
        --一个礼盒所拥有的数量
	CALC_AMOUNT decimal(18, 3) ,
        --礼盒单品销售单价
	RTL_PRICE decimal(18, 3) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_BOMDATA PRIMARY KEY 
	(
		TENANT_ID,BOM_ID,SEQNO
	) 
) ;

CREATE INDEX IX_SAL_BOMDATA_TENANT_ID ON SAL_BOMDATA(TENANT_ID);
CREATE INDEX IX_SAL_BOMDATA_TIME_STAMP ON SAL_BOMDATA(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_BOMDATA_GODS_ID ON SAL_BOMDATA(TENANT_ID,GODS_ID);

--发票管理
CREATE TABLE SAL_INVOICE_BOOK (
        --企业代码
	TENANT_ID int NOT NULL ,
        --流水ID号
	INVH_ID char (36) NOT NULL ,
        --领用门店
	SHOP_ID varchar (11) NOT NULL ,
        --领用人
	CREA_USER int NOT NULL ,
        --领用日期
	CREA_DATE int NOT NULL ,
        --备注
	REMARK varchar (100) ,
        --发票代码
	INVH_NO varchar (50) NOT NULL ,
        --发票起始号
	BEGIN_NO int NOT NULL ,
        --发票终止号
	ENDED_NO int NOT NULL ,
        --合计张数
	TOTAL_AMT int ,
        --开票张数
	USING_AMT int ,
        --作废张数
	CANCEL_AMT int ,
        --结余张数
	BALANCE int ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','开票','INVOICE_STATUS','00',5497000);
insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','作废','INVOICE_STATUS','00',5497000);

--发票明细
CREATE TABLE SAL_INVOICE_INFO (
        --企业代码
	TENANT_ID int NOT NULL ,
        --流水ID号
	INVH_ID char (36) NOT NULL ,
        --领用门店
	SHOP_ID varchar (11) NOT NULL ,
        --开票人
	CREA_USER varchar (36) NOT NULL ,
        --开票日期
	CREA_DATE int NOT NULL ,
        --客户编码
	CLIENT_ID varchar (36)  NOT NULL ,
        --备注
	REMARK varchar (100) ,
	      --发票号
	INVOICE_NO int NOT NULL ,
        --发票状态
	INVOICE_STATUS varchar (1) NOT NULL ,
        --销售单号
	SALES_ID char (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_SAL_IV_INFO PRIMARY KEY   
	(
		TENANT_ID,INVH_ID,INVOICE_NO
	) 
);

CREATE INDEX IX_SAL_INVOICE_INFO_TENANT_ID ON SAL_INVOICE_INFO(TENANT_ID);
CREATE INDEX IX_SAL_INVOICE_INFO_TIME_STAMP ON SAL_INVOICE_INFO(TENANT_ID,TIME_STAMP);
CREATE INDEX IX_SAL_INVOICE_INFO_CREA_DATE ON SAL_INVOICE_INFO(CREA_DATE);

--   台账规划      ---
--时间:2011-02-21
--初稿:张森荣

--日结账记录
CREATE TABLE RCK_DAYS_CLOSE (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店
	SHOP_ID varchar (11) NOT NULL ,
        --日期
	CREA_DATE int NOT NULL ,
        --结账用户
	CREA_USER varchar (36) NOT NULL ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_DAYS_CLOSE PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,CREA_DATE
	) 
);

--月结账记录
CREATE TABLE RCK_MONTH_CLOSE (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店
	SHOP_ID varchar (11) NOT NULL ,
        --日期
	MONTH int NOT NULL ,
        --结账用户
	CREA_USER varchar (36) NOT NULL ,
        --开始日期
	BEGIN_DATE varchar (10) ,
        --结束日期
	END_DATE varchar (10) ,
        --审核日期
	CHK_DATE varchar (10) ,
        --审核人员
	CHK_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
  TIME_STAMP bigint NOT NULL,
	CONSTRAINT PK_RCK_MONTH_CLOSE PRIMARY KEY   
	(
		TENANT_ID,SHOP_ID,MONTH
	) 
);

--商品日台账
CREATE TABLE RCK_GOODS_DAYS (
        --企业代码
	TENANT_ID int NOT NULL ,
        --领用门店
	SHOP_ID varchar (11) NOT NULL ,
        --日期
	CREA_DATE int NOT NULL ,
        --客户编码
	GODS_ID char (36)  NOT NULL ,
        --批号
	BATCH_NO varchar (36) NOT NULL ,

--结账时进销价信息
        --当时进价
	NEW_INPRICE decimal(18, 3) ,
        --当时销价
	NEW_OUTPRICE decimal(18, 3) ,

--期初类台账		
        --期初数量
	ORG_AMT decimal(18, 3) ,
        --期初金额<按当时进价>
	ORG_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	ORG_RTL decimal(18, 3) ,
        --期初成本<移动加权成本>
	ORG_CST decimal(18, 3) ,
	
--进货类台账	
        --进货数量<含退货>
	STOCK_AMT decimal(18, 3) ,
        --进货金额<末税>
	STOCK_MNY decimal(18, 3) ,
        --进项税额
	STOCK_TAX decimal(18, 3) ,
        --可销售额<按零售价>
	STOCK_RTL decimal(18, 3) ,
        --让利金额<供应商让利>
	STOCK_AGO decimal(18, 3) ,
	
        --其中退货数量
	STKRT_AMT decimal(18, 3) ,
        --退货金额<末税>
	STKRT_MNY decimal(18, 3) ,
        --进项税额
	STKRT_TAX decimal(18, 3) ,
	

--销售类台账	
        --销售数量<含退货>
	SALE_AMT decimal(18, 3) ,
        --可销售额<按零售价>
	SALE_RTL decimal(18, 3) ,
        --让利金额<销售让利>
	SALE_AGO decimal(18, 3) ,
        --销售金额<末税>
	SALE_MNY decimal(18, 3) ,
        --销项税额
	SALE_TAX decimal(18, 3) ,
        --销售成本
	SALE_CST decimal(18, 3) ,
        --成本单价<移动加权成本>
	COST_PRICE decimal(18, 6) ,
        --销售毛利
	SALE_PRF decimal(18, 3) ,
	
	
        --其中退货数量
	SALRT_AMT decimal(18, 3) ,
        --销售金额<末税>
	SALRT_MNY decimal(18, 3) ,
        --销项税额
	SALRT_TAX decimal(18, 3) ,
        --退货成本
	SALRT_CST decimal(18, 3) ,
	
--调拨类台账	
        --调入数量
	DBIN_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	DBIN_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	DBIN_RTL decimal(18, 3) ,
        --调拨成本<移动加权成本>
	DBIN_CST decimal(18, 3) ,
	
        --调出数量
	DBOUT_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	DBOUT_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	DBOUT_RTL decimal(18, 3) ,
        --调拨成本<移动加权成本>
	DBOUT_CST decimal(18, 3) ,
	
--库存类台账	
        --调整数量
	CHANGE1_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE1_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE1_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE1_CST decimal(18, 3) ,

        --调整数量
	CHANGE2_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE2_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE2_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE2_CST decimal(18, 3) ,

        --调整数量
	CHANGE3_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE3_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE3_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE3_CST decimal(18, 3) ,

        --调整数量
	CHANGE4_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE4_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE4_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE4_CST decimal(18, 3) ,
	
        --调整数量
	CHANGE5_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE5_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE5_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE5_CST decimal(18, 3) ,

--结存类台账		
        --结存数量
	BAL_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	BAL_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	BAL_RTL decimal(18, 3) ,
        --结存成本<移动加权成本>
	BAL_CST decimal(18, 3) ,
	
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--商品月台账
CREATE TABLE RCK_GOODS_MONTH (
        --企业代码
	TENANT_ID int NOT NULL ,
        --领用门店
	SHOP_ID varchar (11) NOT NULL ,
        --月份
	MONTH int NOT NULL ,
        --客户编码
	GODS_ID char (36)  NOT NULL ,
        --批号
	BATCH_NO varchar (36) NOT NULL ,
	
--结账时进销价信息
        --当时进价
	NEW_INPRICE decimal(18, 3) ,
        --当时销价
	NEW_OUTPRICE decimal(18, 3) ,

--期初类台账		
        --期初数量
	ORG_AMT decimal(18, 3) ,
        --期初金额<按当时进价>
	ORG_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	ORG_RTL decimal(18, 3) ,
        --期初成本<移动加权成本>
	ORG_CST decimal(18, 3) ,
	
--进货类台账	
        --进货数量<含退货>
	STOCK_AMT decimal(18, 3) ,
        --进货金额<末税>
	STOCK_MNY decimal(18, 3) ,
        --进项税额
	STOCK_TAX decimal(18, 3) ,
        --可销售额<按零售价>
	STOCK_RTL decimal(18, 3) ,
        --让利金额<供应商让利>
	STOCK_AGO decimal(18, 3) ,

        --其中退货数量
	STKRT_AMT decimal(18, 3) ,
        --退货金额<末税>
	STKRT_MNY decimal(18, 3) ,
        --进项税额
	STKRT_TAX decimal(18, 3) ,
	

--销售类台账	
        --销售数量<含退货>
	SALE_AMT decimal(18, 3) ,
        --可销售额<按零售价>
	SALE_RTL decimal(18, 3) ,
        --让利金额<销售让利>
	SALE_AGO decimal(18, 3) ,
        --销售金额<末税>
	SALE_MNY decimal(18, 3) ,
        --销项税额
	SALE_TAX decimal(18, 3) ,
        --销售成本
	SALE_CST decimal(18, 3) ,
        --销售毛利
	SALE_PRF decimal(18, 3) ,
	
        --其中退货数量<含退货>
	SALRT_AMT decimal(18, 3) ,
        --销售金额<末税>
	SALRT_MNY decimal(18, 3) ,
        --销项税额
	SALRT_TAX decimal(18, 3) ,
        --退货成本
	SALRT_CST decimal(18, 3) ,
	
        --去年同期数量<含退货>
	PRIOR_YEAR_AMT decimal(18, 3) ,
        --销售金额<末税>
	PRIOR_YEAR_MNY decimal(18, 3) ,
        --销项税额
	PRIOR_YEAR_TAX decimal(18, 3) ,
        --销项成本
	PRIOR_YEAR_CST decimal(18, 3) ,
	
        --上月销售数量
	PRIOR_MONTH_AMT decimal(18, 3) ,
        --销售金额<末税>
	PRIOR_MONTH_MNY decimal(18, 3) ,
        --销项税额
	PRIOR_MONTH_TAX decimal(18, 3) ,
        --销项成本
	PRIOR_MONTH_CST decimal(18, 3) ,
	
--调拨类台账	
        --调入数量
	DBIN_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	DBIN_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	DBIN_RTL decimal(18, 3) ,
        --调拨成本<移动加权成本>
	DBIN_CST decimal(18, 3) ,
	
        --调出数量
	DBOUT_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	DBOUT_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	DBOUT_RTL decimal(18, 3) ,
        --调拨成本<移动加权成本>
	DBOUT_CST decimal(18, 3) ,
	
--库存类台账	
        --调整数量
	CHANGE1_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE1_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE1_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE1_CST decimal(18, 3) ,

        --调整数量
	CHANGE2_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE2_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE2_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE2_CST decimal(18, 3) ,

        --调整数量
	CHANGE3_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE3_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE3_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE3_CST decimal(18, 3) ,

        --调整数量
	CHANGE4_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE4_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE4_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE4_CST decimal(18, 3) ,
	
        --调整数量
	CHANGE5_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	CHANGE5_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	CHANGE5_RTL decimal(18, 3) ,
        --调整成本<移动加权成本>
	CHANGE5_CST decimal(18, 3) ,

--结存类台账		
        --结存数量
	BAL_AMT decimal(18, 3) ,
        --进项金额<按当时进价>
	BAL_MNY decimal(18, 3) ,
        --可销售额<按零售价>
	BAL_RTL decimal(18, 3) ,
        --结存成本<移动加权成本>
	BAL_CST decimal(18, 3) ,
        --调整成本<移动加权成本>
	ADJ_CST decimal(18, 3) ,
	
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--账户日台账
CREATE TABLE RCK_ACCT_DAYS (
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店
	SHOP_ID varchar (11) NOT NULL ,
        --日期
	CREA_DATE int NOT NULL ,
        --账户代码
	ACCOUNT_ID char (36)  NOT NULL ,

--期初类台账		
        --期初金额
	ORG_MNY decimal(18, 3) ,
 
--收入类台账		
        --收入金额
	IN_MNY decimal(18, 3) ,

--支出类台账		
        --支出金额
	OUT_MNY decimal(18, 3) ,

--付款金额		
	PAY_MNY decimal(18, 3) ,
--收款金额		
	RECV_MNY decimal(18, 3) ,
--零售金额		
	POS_MNY decimal(18, 3) ,
--存款金额		
	TRN_IN_MNY decimal(18, 3) ,
--取款金额		
	TRN_OUT_MNY decimal(18, 3) ,
--充值金额		
	PUSH_MNY decimal(18, 3) ,
--其他收入		
	IORO_IN_MNY decimal(18, 3) ,
--其他支出		
	IORO_OUT_MNY decimal(18, 3) ,
	
--结存类台账		
        --结存数量
	BAL_MNY decimal(18, 3) ,
	
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--账户月台账
CREATE TABLE RCK_ACCT_MONTH (
        --企业代码
	TENANT_ID int NOT NULL ,
        --领用门店
	SHOP_ID varchar (11) NOT NULL ,
        --月份
	MONTH int NOT NULL ,
        --账户代码
	ACCOUNT_ID char (36)  NOT NULL ,

--期初类台账		
        --期初金额
	ORG_MNY decimal(18, 3) ,
 
--收入类台账		
        --收入金额
	IN_MNY decimal(18, 3) ,

--支出类台账		
        --支出金额
	OUT_MNY decimal(18, 3) ,

--付款金额		
	PAY_MNY decimal(18, 3) ,
--收款金额		
	RECV_MNY decimal(18, 3) ,
--零售金额		
	POS_MNY decimal(18, 3) ,
--存款金额		
	TRN_IN_MNY decimal(18, 3) ,
--取款金额		
	TRN_OUT_MNY decimal(18, 3) ,
--充值金额		
	PUSH_MNY decimal(18, 3) ,
--其他收入		
	IORO_IN_MNY decimal(18, 3) ,
--其他支出		
	IORO_OUT_MNY decimal(18, 3) ,
	
--结存类台账		
        --结存数量
	BAL_MNY decimal(18, 3) ,
	
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 
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

--调拨视图（包括出货单和入货单）
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
 
--收银结账，包抱没有缴款登记的
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

--客户收款报表：
create view VIW_RECVABLEDATA
as 
SELECT A.*,B.ABLE_DATE,B.ACCT_MNY,B.RECV_MNY as SETT_MNY,B.REVE_MNY,B.RECK_MNY,B.ACCT_INFO,B.SALES_ID,B.CREA_USER as ABLE_USER
FROM VIW_RECVDATA A
     INNER JOIN ACC_RECVABLE_INFO AS B ON A.TENANT_ID = B.TENANT_ID and A.ABLE_ID = B.ABLE_ID ;
     
--供应商付款报表：[时间差放]
CREATE VIEW VIW_PAYABLEDATA
as
select A.*,B.ABLE_DATE,B.ACCT_MNY,B.PAYM_MNY as SETT_MNY,B.REVE_MNY,B.RECK_MNY,B.ACCT_INFO,B.STOCK_ID,B.CREA_USER as ABLE_USER 
from VIW_PAYDATA A left outer join ACC_PAYABLE_INFO B 
  on A.TENANT_ID=B.TENANT_ID and A.ABLE_ID=B.ABLE_ID;     


delete from CA_MODULE where PROD_ID='R3_RYC';
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','10000001',0,'进销存管理','001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11000001',0,'进货管理','001001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100001',0,'进货订单','001001001',1,'actfrmStkIndentOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100002',1,'查询','001001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100003',2,'新增','001001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100004',3,'修改','001001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100005',4,'删除','001001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100006',5,'审核','001001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100007',6,'打印','001001001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11100008',7,'导出','001001001008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200001',0,'进货入库','001001002',1,'actfrmStockOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200002',1,'查询','001001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200003',2,'新增','001001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200004',3,'修改','001001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200005',4,'删除','001001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200006',5,'审核','001001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200007',6,'打印','001001002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11200008',7,'导出','001001002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300001',0,'采购退货','001001003',1,'actfrmStkRetuOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300002',1,'查询','001001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300003',2,'新增','001001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300004',3,'修改','001001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300005',4,'删除','001001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300006',5,'审核','001001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300007',6,'打印','001001003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','11300008',7,'导出','001001003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12000002',0,'销售管理','001002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100001',0,'批量调价','001002001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100002',1,'查询','001002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100003',2,'新增','001002001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100004',3,'修改','001002001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100005',4,'删除','001002001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100006',5,'审核','001002001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100007',6,'打印','001002001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12100008',7,'导出','001002001008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200001',0,'商品促销','001002002',1,'actfrmPriceOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200002',1,'查询','001002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200003',2,'新增','001002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200004',3,'修改','001002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200005',4,'删除','001002002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200006',5,'审核','001002002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200007',6,'打印','001002002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12200008',7,'导出','001002002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300001',0,'销售订单','001002003',1,'actfrmSalIndentOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300002',1,'查询','001002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300003',2,'新增','001002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300004',3,'修改','001002003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300005',4,'删除','001002003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300006',5,'变价','001002003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300007',6,'增送','001002003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300008',7,'审核','001002003008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300009',8,'打印','001002003009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12300010',10,'导出','001002003010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400001',0,'销售出货','001002004',1,'actfrmSalesOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400002',1,'查询','001002004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400003',2,'新增','001002004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400004',3,'修改','001002004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400005',4,'删除','001002004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400006',5,'变价','001002004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400007',6,'增送','001002004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400008',7,'审核','001002004008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400009',8,'打印','001002004009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12400010',10,'导出','001002004010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500001',0,'销售退货','001002005',1,'actfrmSalRetuOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500002',1,'查询','001002005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500003',2,'新增','001002005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500004',3,'修改','001002005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500005',4,'删除','001002005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500006',5,'变价','001002005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500007',6,'增送','001002005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500008',7,'审核','001002005008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500009',8,'打印','001002005009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','12500010',10,'导出','001002005010',2,'#','#','00',5497000);

--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','13000003',0,'门店销售','001003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100001',0,'门店销售','001003001',1,'actfrmPosMain','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100002',1,'查询','001003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100003',2,'新增','001003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100004',3,'修改','001003001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100005',4,'删除','001003001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100006',5,'变价','001003001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100007',6,'赠送','001003001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100008',7,'兑换','001003001008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100009',8,'退货','001003001009',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13100010',9,'打印','001003001010',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200001',0,'交班结账','001003002',1,'actfrmCloseForDay','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200002',1,'查看','001003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200003',2,'结账','001003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200004',3,'撤消','001003002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200005',4,'审核','001003002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13200006',5,'打印','001003002006',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300001',0,'缴款登记','001003003',1,'actfrmRecvForDay','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300002',1,'查看','001003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300003',2,'新增','001003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300004',3,'修改','001003003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300005',4,'删除','001003003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300006',5,'审核','001003003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300007',6,'打印','001003003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','13300008',7,'导出','001003003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14000001',0,'存货管理','001004',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100001',0,'调拨单','001004001',1,'actfrmDbOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100002',1,'查询','001004001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100003',2,'新增','001004001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100004',3,'修改','001004001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100005',4,'删除','001004001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100006',5,'到货确认','001004001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100007',6,'审核','001004001007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100008',7,'打印','001004001008',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14100009',8,'导出','001004001009',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200001',0,'领用单','001004002',1,'actfrmChangeOrderList2','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200002',1,'查询','001004002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200003',2,'新增','001004002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200004',3,'修改','001004002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200005',4,'删除','001004002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200006',5,'审核','001004002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200007',6,'打印','001004002007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14200008',7,'导出','001004002008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300001',0,'损益单','001004003',1,'actfrmChangeOrderList1','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300002',1,'查询','001004003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300003',2,'新增','001004003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300004',3,'修改','001004003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300005',4,'删除','001004003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300006',5,'审核','001004003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300007',6,'打印','001004003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14300008',7,'导出','001004003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400001',0,'盘点单','001004004',1,'actfrmCheckOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400002',1,'查询','001004004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400003',2,'新增','001004004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400004',3,'修改','001004004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400005',4,'删除','001004004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400006',5,'审核','001004004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400007',6,'打印','001004004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14400008',7,'导出','001004004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500001',0,'库存查询','001004005',1,'actfrmStorageTracking','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500002',1,'查询','001004005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500003',2,'成本','001004005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500004',3,'打印','001004005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','14500005',4,'导出','001004005005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','20000001',0,'财务管理','002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21000001',0,'现金银行','002001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100001',0,'银行账户','002001001',1,'actfrmAccount','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100002',1,'查询','002001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100003',2,'新增','002001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100004',3,'修改','002001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100005',4,'删除','002001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100006',5,'打印','002001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21100007',6,'导出','002001001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200001',0,'收支科目','002001002',1,'actfrmCodeInfo3','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200002',1,'查询','002001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200003',2,'新增','002001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200004',3,'修改','002001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200005',4,'删除','002001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200006',5,'打印','002001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21200007',6,'导出','002001002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300001',0,'应收款账','002001003',1,'actfrmRecvOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300002',1,'查询','002001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300003',2,'收款','002001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300004',3,'修改','002001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300005',4,'删除','002001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300006',5,'审核','002001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300007',6,'打印','002001003007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21300008',7,'导出','002001003008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400001',0,'应付账款','002001004',1,'actfrmPayOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400002',1,'查询','002001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400003',2,'付款','002001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400004',3,'修改','002001004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400005',4,'删除','002001004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400006',5,'审核','002001004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400007',6,'打印','002001004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21400008',7,'导出','002001004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500001',0,'其他收入','002001005',1,'actfrmIoroOrderList1','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500002',1,'查询','002001005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500003',2,'新增','002001005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500004',3,'修改','002001005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500005',4,'删除','002001005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500006',5,'审核','002001005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500007',6,'打印','002001005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21500008',7,'导出','002001005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600001',0,'其他支出','002001006',1,'actfrmIoroOrderList2','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600002',1,'查询','002001006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600003',2,'新增','002001006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600004',3,'修改','002001006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600005',4,'删除','002001006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600006',5,'审核','002001006006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600007',6,'打印','002001006007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21600008',7,'导出','002001006008',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700001',0,'存取款单','002001007',1,'actfrmTransOrderList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700002',1,'查询','002001007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700003',2,'新增','002001007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700004',3,'修改','002001007004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700005',4,'删除','002001007005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700006',5,'审核','002001007006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700007',6,'打印','002001007007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','21700008',7,'导出','002001007008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22000001',0,'台账管理','002002',1,'#','#','00',5497000);

--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100001',0,'日结账','002002001',1,'actfrmDaysClose','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100002',1,'结账','002002001002',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100003',2,'撤消','002002001003',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100004',3,'审核','002002001004',2,'#','#','00',5497000);
--insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
--values('R3_RYC','22100005',4,'打印','002002001005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200001',0,'月末结账','002002002',1,'actfrmMonthClose','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200002',1,'结账','002002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200003',2,'撤消','002002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200004',3,'审核','002002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22200005',4,'打印','002002002005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300001',0,'结账管理','002002003',1,'actfrmRckMng','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300002',1,'查看','002002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','22300003',2,'审核','002002003003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','30000001',0,'基础资料','003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31000001',0,'基础档案','003001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100001',0,'门店档案','003001001',1,'actfrmShopInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100002',1,'查询','003001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100003',2,'新增','003001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100004',3,'修改','003001001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100005',4,'删除','003001001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100006',5,'打印','003001001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31100007',6,'导出','003001001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200001',0,'部门档案','003001002',1,'actfrmDeptInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200002',1,'查询','003001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200003',2,'新增','003001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200004',3,'修改','003001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200005',4,'删除','003001002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200006',5,'打印','003001002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31200007',6,'导出','003001002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300001',0,'职务档案','003001003',1,'actfrmDutyInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300002',1,'查询','003001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300003',2,'新增','003001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300004',3,'修改','003001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300005',4,'删除','003001003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300006',5,'打印','003001003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31300007',6,'导出','003001003007',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400001',0,'角色权限','003001004',1,'actfrmRoleInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400002',1,'查询','003001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400003',2,'新增','003001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400004',3,'修改','003001004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400005',4,'删除','003001004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400006',5,'授权','003001004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400007',6,'打印','003001004007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31400008',7,'导出','003001004008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500001',0,'员工档案','003001005',1,'actfrmUsers','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500002',1,'查询','003001005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500003',2,'新增','003001005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500004',3,'修改','003001005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500005',4,'删除','003001005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500006',5,'授权','003001005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500007',6,'打印','003001005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','31500008',7,'导出','003001005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32000001',0,'商品档案','003002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100001',0,'商品分类','003002001',1,'actfrmGoodsSort','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100002',1,'查询','003002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100003',2,'新增','003002001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100004',3,'修改','003002001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100005',4,'删除','003002001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100006',5,'打印','003002001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32100007',6,'导出','003002001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200001',0,'商品单位','003002002',1,'actfrmMeaUnits','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200002',1,'查询','003002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200003',2,'新增','003002002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200004',3,'修改','003002002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200005',4,'删除','003002002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200006',5,'打印','003002002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32200007',6,'导出','003002002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300001',0,'统计指标','003002003',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300002',1,'查询','003002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300003',2,'新增','003002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300004',3,'修改','003002003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300005',4,'删除','003002003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300006',5,'打印','003002003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32300007',6,'导出','003002003007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600001',0,'商品档案','003002006',1,'actfrmGoodsInfoList','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600002',1,'查询','003002006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600003',2,'新增','003002006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600004',3,'修改','003002006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600005',4,'删除','003002006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600006',5,'打印','003002006006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32600007',6,'导出','003002006007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700001',0,'供应链管理','003002007',1,'actfrmRelation','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700002',1,'查询','003002007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700003',2,'申请','003002007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700004',3,'创建','003002007004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700005',4,'删除','003002007005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700006',5,'维护','003002007006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700007',6,'导出','003002007007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','32700008',7,'打印','003002007008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33000001',0,'客户资源','003003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100001',0,'供应商档案','003003001',1,'actfrmSupplier','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100002',1,'查询','003003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100003',2,'新增','003003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100004',3,'修改','003003001004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100005',4,'删除','003003001005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100006',5,'打印','003003001006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33100007',6,'导出','003003001007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200001',0,'客户等级','003003002',1,'actfrmPriceGradeInfo','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200002',1,'查询','003003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200003',2,'新增','003003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200004',3,'修改','003003002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200005',4,'删除','003003002005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200006',5,'打印','003003002006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33200007',6,'导出','003003002007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300001',0,'企业客户','003003003',1,'actfrmClient','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300002',1,'查询','003003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300003',2,'新增','003003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300004',3,'修改','003003003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300005',4,'删除','003003003005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300006',5,'打印','003003003006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33300007',6,'导出','003003003007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400001',0,'会员档案','003003004',1,'actfrmCustomer','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400002',1,'查询','003003004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400003',2,'新增','003003004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400004',3,'修改','003003004004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400005',4,'删除','003003004005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400006',5,'打印','003003004006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33400007',6,'导出','003003004007',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500001',0,'储值卡','003003005',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500002',1,'查询','003003005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500003',2,'制卡','003003005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500004',3,'发卡','003003005004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500005',4,'充值','003003005005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500006',5,'退款','003003005006',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500007',6,'挂失','003003005007',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33500008',7,'注销','003003005008',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600001',0,'积分管理','003003006',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600002',1,'查询','003003006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600003',2,'赠送积分','003003006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600004',3,'兑换规则','003003006004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600005',4,'积分清零','003003006005',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','33600006',5,'积分兑换','003003006006',2,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','40000001',0,'统计报表','004',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41000001',0,'业务报表','004001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100001',0,'商品进货报表','004001001',1,'actfrmStockDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100002',1,'查询','004001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100003',2,'打印','004001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41100004',3,'导出','004001001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200001',0,'商品销售报表','004001002',1,'actfrmSaleDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200002',1,'查询','004001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200003',2,'打印','004001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41200004',3,'导出','004001002004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600001',0,'商品调拨报表','004001006',1,'actfrmDbDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600002',1,'查询','004001006002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600003',2,'打印','004001006003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41600004',3,'导出','004001006004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700001',0,'商品领用报表','004001007',1,'actfrmChange2DayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700002',1,'查询','004001007002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700003',2,'打印','004001007003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41700004',3,'导出','004001007004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800001',0,'商品损益报表','004001008',1,'actfrmChange1DayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800002',1,'查询','004001008002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800003',2,'打印','004001008003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41800004',3,'导出','004001008004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900001',0,'商品库存报表','004001009',1,'actfrmStorageDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900002',1,'查询','004001009002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900003',2,'打印','004001009003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41900004',3,'导出','004001009004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42000001',0,'财务报表','004002',1,'#','#','00',5497000);


insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300001',0,'营业结账报表','004002003',1,'actfrmRckDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300002',1,'查询','004002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300003',2,'打印','004002003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41300004',3,'导出','004002003004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400001',0,'客户收款报表','004002004',1,'actfrmRecvDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400002',1,'查询','004002004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400003',2,'打印','004002004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41400004',3,'导出','004002004004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500001',0,'客户付款报表','004002005',1,'actfrmPayDayReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500002',1,'查询','004002005002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500003',2,'打印','004002005003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41500004',3,'导出','004002005004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010001',0,'应收账款报表','004002010',1,'actfrmRecvAbleReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010002',1,'查询','004002010002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010003',2,'打印','004002010003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41010004',3,'导出','004002010004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020001',0,'应付账款报表','004002011',1,'actfrmPayAbleReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020002',1,'查询','004002011002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020003',2,'打印','004002011003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','41020004',3,'导出','004002011004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42000002',0,'综合报表','004003',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100001',0,'业绩考核报表','004003001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100002',1,'查询','004003001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100003',2,'打印','004003001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42100004',3,'导出','004003001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200001',0,'商品流水报表','004003002',1,'actfrmGodsRunningReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200002',1,'查询','004003002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200003',2,'打印','004003002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42200004',3,'导出','004003002004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300001',0,'进销存统计表','004003003',1,'actfrmJxcTotalReport','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300002',1,'查询','004003003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300003',2,'打印','004003003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','42300004',3,'导出','004003003004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','90000001',0,'系统管理','009',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91000001',0,'常用工具','009001',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100001',0,'公告管理','009001001',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100002',1,'查询','009001001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100003',2,'发布','009001001003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91100004',3,'撤消','009001001004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200001',0,'手机短信','009001002',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200002',1,'查询','009001002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200003',2,'发送','009001002003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200004',3,'充值','009001002004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91200005',4,'设置','009001002005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300001',0,'日志管理','009001003',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300002',1,'查询','009001003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300003',2,'清除','009001003003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300004',3,'导出','009001003004',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91300005',4,'设置','009001003005',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400001',0,'备份恢复','009001004',1,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400002',1,'备份','009001004002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400003',2,'恢复','009001004003',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','91400004',3,'设置','009001004004',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92000001',0,'系统设置','009002',1,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100001',0,'系统参数','009002001',1,'actfrmSysDefine','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100002',1,'查询','009002001002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92100003',2,'修改','009002001003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200001',0,'设备参数','009002002',1,'actfrmDevFactory','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200002',1,'查询','009002002002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92200003',2,'修改','009002002003',2,'#','#','00',5497000);

insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300001',0,'接口参数','009002003',1,'actfrmIntfSetup','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300002',1,'查询','009002003002',2,'#','#','00',5497000);
insert into CA_MODULE(PROD_ID,MODU_ID,SEQNO,MODU_NAME,LEVEL_ID,MODU_TYPE,ACTION_NAME,ACTION_URL,COMM,TIME_STAMP)
values('R3_RYC','92300003',2,'修改','009002003003',2,'#','#','00',5497000);
