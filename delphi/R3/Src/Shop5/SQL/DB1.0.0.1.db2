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
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,PASS_WRD,COMM from CA_USERS
union all
select TENANT_ID,trim(char(TENANT_ID))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,trim(char(B.TENANT_ID))||'0001' as SHOP_ID,'administrator' as USER_ID,'administrator' as ACCOUNT,'超级管理员' as USER_NAME,'cjgly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,
VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--代码信息表
CREATE TABLE PUB_CODE_INFO(
    --企业代码<0为公共资料>
	TENANT_ID int NOT NULL DEFAULT 0,
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

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','身份证','SFZ','11',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','驾驶证','JSZ','11',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','社保卡','SBK','11',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','军官证','JGZ','11',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','护照','HZ','11',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','学生证','XSZ','11',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','经营许可证','JYXKZ','11',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('99','其他','QT','11',8,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','1000以下','','13',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','1000-2000','','13',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','2000-3000','','13',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','3000-4000','','13',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','4000-5000','','13',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','5000以上','','13',6,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','小学','XX','14',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','初中','CZ','14',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','高中','GZ','14',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','专科','ZK','14',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','本科','BK','14',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','硕士','SS','14',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','博士','BS','14',7,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','金融','XX','15',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','地产','CZ','15',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','汽车','GZ','15',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('4','IT信息技术','ZK','15',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('5','顾问咨询','BK','15',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('6','媒体出版','SS','15',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('7','事业机关','BS','15',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('8','教育培训','BS','15',8,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('9','旅游休闲','BS','15',9,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('10','制造','BS','15',10,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('11','零售','BS','15',11,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('12','能源','BS','15',12,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('13','国际贸易','BS','15',13,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('14','物流','BS','15',14,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('99','其他','BS','15',99,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100','北京市','BJS','8',1,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100100','北京市.西城区','BJSXCQ','8',2,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100101','北京市.崇文区','BJSCWQ','8',3,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100102','北京市.海淀区','BJSHDQ','8',4,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100103','北京市.门头沟区','BJSMTGQ','8',5,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100104','北京市.通县','BJSTX','8',6,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100105','北京市.顺义县','BJSSYX','8',7,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100106','北京市.密云县','BJSMYX','8',8,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100107','北京市.昌平县','BJSCPX','8',9,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100108','北京市.东城区','BJSDCQ','8',10,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100109','北京市.宣武区','BJSXWQ','8',11,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100110','北京市.朝阳区','BJSCYQ','8',12,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100111','北京市.丰台区','BJSFTQ','8',13,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100112','北京市.石景山区','BJSSJSQ','8',14,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100113','北京市.平觳县','BJSPZX','8',15,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100114','北京市.怀柔县','BJSHRX','8',16,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100115','北京市.延庆县','BJSYQX','8',17,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100116','北京市.大兴县','BJSDXX','8',18,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101','上海市','SHS','8',19,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101100','上海市.卢湾区','SHSLWQ','8',20,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101101','上海市.吴松区','SHSWSQ','8',21,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101102','上海市.闸北区','SHSZBQ','8',22,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101103','上海市.虹口区','SHSHKQ','8',23,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101104','上海市.黄浦区','SHSHPQ','8',24,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101105','上海市.静安区','SHSJAQ','8',25,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101106','上海市.上海县','SHSSHX','8',26,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101107','上海市.南汇县','SHSNHX','8',27,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101108','上海市.金山县','SHSJSX','8',28,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101109','上海市.青浦县','SHSQPX','8',29,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101110','上海市.宝山县','SHSBSX','8',30,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101111','上海市.长宁区','SHSCNQ','8',31,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101112','上海市.杨浦区','SHSYPQ','8',32,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101113','上海市.闵行区','SHSZXQ','8',33,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101114','上海市.南市区','SHSNSQ','8',34,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101115','上海市.徐汇区','SHSXHQ','8',35,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101116','上海市.普陀区','SHSPTQ','8',36,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101117','上海市.嘉定县','SHSJDX','8',37,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101118','上海市.川沙县','SHSCSX','8',38,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101119','上海市.奉贤县','SHSFXX','8',39,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101120','上海市.松江县','SHSSJX','8',40,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101121','上海市.崇明县','SHSCMX','8',41,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102','天津市','TJS','8',42,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102100','天津市.河西区 ','TJSHXQ ','8',43,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102101','天津市.南开区 ','TJSNKQ ','8',44,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102102','天津市.塘沽区','TJSTGQ','8',45,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102103','天津市.东郊区','TJSDJQ','8',46,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102104','天津市.西郊区 ','TJSXJQ ','8',47,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102105','天津市.大港区','TJSDGQ','8',48,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102106','天津市.河东区','TJSHDQ','8',49,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102107','天津市.河北区','TJSHBQ','8',50,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102108','天津市.红桥区','TJSHQQ','8',51,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102109','天津市.汉沽区 ','TJSHGQ ','8',52,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102110','天津市.南郊区','TJSNJQ','8',53,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102111','天津市.北郊区 ','TJSBJQ ','8',54,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('103','重庆市','ZQS','8',55,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104','内蒙古自治区','NMGZZQ','8',56,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104100','内蒙古.呼和浩特市','NMGHHHTS','8',57,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104101','内蒙古.二连浩特市','NMGELHTS','8',58,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104102','内蒙古.临河市','NMGLHS','8',59,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104103','内蒙古.东胜市','NMGDSS','8',60,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104104','内蒙古.满洲里市','NMGMZLS','8',61,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104105','内蒙古.赤峰市','NMGCFS','8',62,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104106','内蒙古.乌兰浩特市','NMGWLHTS','8',63,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104107','内蒙古.鄂尔多斯市','NMGEEDSS','8',64,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104108','内蒙古.兴安盟','NMGXAM','8',65,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104109','内蒙古.乌兰察布盟','NMGWLCBM','8',66,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104110','内蒙古.阿拉善盟','NMGALSM','8',67,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104111','内蒙古.集宁市','NMGJNS','8',68,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104112','内蒙古.包头市','NMGBTS','8',69,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104113','内蒙古.乌海市','NMGWHS','8',70,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104114','内蒙古.海拉尔市','NMGHLES','8',71,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104115','内蒙古.牙克石市','NMGYKSS','8',72,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104116','内蒙古.锡林浩特市','NMGXLHTS','8',73,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104117','内蒙古.通辽市','NMGTLS','8',74,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104118','内蒙古.呼伦贝尔市','NMGHLBES','8',75,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104119','内蒙古.锡林郭勒盟','NMGXLGLM','8',76,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104120','内蒙古.巴彦淖尔盟','NMGBYNEM','8',77,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105','山西省','SXS','8',78,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105100','山西省.太原市','SXSTYS','8',79,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105101','山西省.忻州市','SXSXZS','8',80,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105102','山西省.临汾市','SXSLFS','8',81,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105103','山西省.运城市','SXSYCS','8',82,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105104','山西省.长治市','SXSCZS','8',83,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105105','山西省.朔州市','SXSSZS','8',84,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105106','山西省.吕梁地区','SXSLLDQ','8',85,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105107','山西省.榆次市','SXSYCS','8',86,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105108','山西省.大同市','SXSDTS','8',87,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105109','山西省.侯马市','SXSHMS','8',88,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105110','山西省.阳泉市','SXSYQS','8',89,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105111','山西省.晋城市','SXSJCS','8',90,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105112','山西省.晋中市','SXSJZS','8',91,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106','河北省','HBS','8',92,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106100','河北省.石家庄市','HBSSJZS','8',93,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106101','河北省.辛集市','HBSXJS','8',94,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106102','河北省.邢台市','HBSXTS','8',95,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106103','河北省.邯郸市','HBSHDS','8',96,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106104','河北省.泊头市','HBSBTS','8',97,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106105','河北省.唐山市','HBSTSS','8',98,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106106','河北省.北戴河','HBSBDH','8',99,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106107','河北省.保定市','HBSBDS','8',100,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106108','河北省.定州市','HBSDZS','8',101,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106109','河北省.廊坊市','HBSLFS','8',102,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106110','河北省.南宫市','HBSNGS','8',103,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106111','河北省.衡水市','HBSHSS','8',104,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106112','河北省.沙河市','HBSSHS','8',105,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106113','河北省.沧州市','HBSCZS','8',106,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106114','河北省.任丘市','HBSRQS','8',107,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106115','河北省.秦皇岛市','HBSQHDS','8',108,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106116','河北省.承德市','HBSCDS','8',109,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106117','河北省.涿州市','HBSZZS','8',110,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106118','河北省.张家口市','HBSZJKS','8',111,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107','辽宁省','LNS','8',112,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107100','辽宁省.沈阳市','LNSSYS','8',113,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107101','辽宁省.铁岭市','LNSTLS','8',114,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107102','辽宁省.抚顺市','LNSFSS','8',115,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107103','辽宁省.海城市','LNSHCS','8',116,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107104','辽宁省.大连市','LNSDLS','8',117,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107105','辽宁省.本溪市','LNSBXS','8',118,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107106','辽宁省.锦州市','LNSJZS','8',119,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107107','辽宁省.兴城市','LNSXCS','8',120,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107108','辽宁省.北票市','LNSBPS','8',121,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107109','辽宁省.盘锦市','LNSPJS','8',122,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107110','辽宁省.辽阳市','LNSLYS','8',123,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107111','辽宁省.铁岭市','LNSTLS','8',124,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107112','辽宁省.鞍山市','LNSASS','8',125,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107113','辽宁省.营口市','LNSYKS','8',126,'00',5497000) ;
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107114','辽宁省.瓦房店市','LNSWFDS','8',127,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107115','辽宁省.丹东市','LNSDDS','8',128,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107116','辽宁省.锦西市','LNSJXS','8',129,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107117','辽宁省.朝阳市','LNSCYS','8',130,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107118','辽宁省.阜新市','LNSFXS','8',131,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107119','辽宁省.葫芦岛市','LNSHLDS','8',132,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108','吉林省','JLS','8',133,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108100','吉林省.长春市 ','JLSCCS ','8',134,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108101','吉林省.吉林市 ','JLSJLS ','8',135,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108102','吉林省.延吉市 ','JLSYJS ','8',136,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108103','吉林省.龙井市 ','JLSLJS ','8',137,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108104','吉林省.通化市 ','JLSTHS ','8',138,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108105','吉林省.浑江市 ','JLSHJS ','8',139,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108106','吉林省.四平市 ','JLSSPS ','8',140,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108107','吉林省.辽源市 ','JLSLYS ','8',141,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108108','吉林省.洮南市 ','JLSZNS ','8',142,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108109','吉林省.松原市 ','JLSSYS ','8',143,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108110','吉林省.扶余市 ','JLSFYS ','8',144,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108111','吉林省.桦甸市 ','JLSZDS ','8',145,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108112','吉林省.图门市 ','JLSTMS ','8',146,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108113','吉林省.敦化市 ','JLSDHS ','8',147,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108114','吉林省.集安市 ','JLSJAS ','8',148,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108115','吉林省.梅河口市 ','JLSMHKS ','8',149,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108116','吉林省.公主岭市 ','JLSGZLS ','8',150,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108117','吉林省.白城市 ','JLSBCS ','8',151,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108118','吉林省.白山市','JLSBSS','8',152,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108119','吉林省.延边朝鲜族自治州','JLS.YBCXZZZZ','8',153,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109','黑龙江省','HLJS','8',154,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109100','黑龙江省.哈尔滨市 ','HLJSHEBS ','8',155,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109101','黑龙江省.肇东市 ','HLJSZDS ','8',156,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109102','黑龙江省.伊春市 ','HLJSYCS ','8',157,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109103','黑龙江省.鹤岗市 ','HLJSHGS ','8',158,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109104','黑龙江省.双鸭山市 ','HLJSSYSS ','8',159,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109105','黑龙江省.牡丹江市 ','HLJSMDJS ','8',160,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109106','黑龙江省.鸡西市 ','HLJSJXS ','8',161,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109107','黑龙江省.大庆市 ','HLJSDQS ','8',162,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109108','黑龙江省.黑河市 ','HLJSHHS ','8',163,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109109','黑龙江省.大兴安岭地区','HLJS.DXALDQ','8',164,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109110','黑龙江省.阿城市 ','HLJSACS ','8',165,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109111','黑龙江省.绥化市 ','HLJSSHS ','8',166,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109112','黑龙江省.佳木斯市 ','HLJSJMSS ','8',167,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109113','黑龙江省.七台河市 ','HLJSQTHS ','8',168,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109114','黑龙江省.同江市 ','HLJSTJS ','8',169,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109115','黑龙江省.绥汾河市 ','HLJSSFHS ','8',170,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109116','黑龙江省.齐齐哈尔市 ','HLJS.QQHES ','8',171,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109117','黑龙江省.北安市 ','HLJSBAS ','8',172,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109118','黑龙江省.五大连池市 ','HLJS.WDLCS ','8',173,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110','江苏省','JSS','8',174,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110100','江苏省.南京市 ','JSSNJS ','8',175,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110101','江苏省.镇江市','JSSZJS','8',176,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110102','江苏省.常州市 ','JSSCZS ','8',177,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110103','江苏省.宜兴市 ','JSSYXS ','8',178,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110104','江苏省.苏州市 ','JSSSZS ','8',179,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110105','江苏省.徐州市 ','JSSXZS ','8',180,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110106','江苏省.淮阴市 ','JSSHYS ','8',181,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110107','江苏省.宿迁市 ','JSSSQS ','8',182,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110108','江苏省.东台市 ','JSSDTS ','8',183,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110109','江苏省.泰州市 ','JSSTZS ','8',184,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110110','江苏省.南通市 ','JSSNTS ','8',185,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110111','江苏省.仪征市 ','JSSYZS ','8',186,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110112','江苏省.丹阳市 ','JSSDYS ','8',187,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110113','江苏省.无锡市 ','JSSWXS ','8',188,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110114','江苏省.江阴市 ','JSSJYS ','8',189,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110115','江苏省.常熟市 ','JSSCSS ','8',190,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110116','江苏省.连云港市 ','JSSLYGS ','8',191,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110117','江苏省.淮安市 ','JSSHAS ','8',192,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110118','江苏省.盐城市 ','JSSYCS ','8',193,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110119','江苏省.扬州市 ','JSSYZS ','8',194,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110120','江苏省.兴化市 ','JSSXHS ','8',195,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111','安徽省','AHS','8',196,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111100','安徽省.合肥市 ','AHSHFS ','8',197,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111101','安徽省.蚌埠市 ','AHSBBS ','8',198,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111102','安徽省.淮北市 ','AHSHBS ','8',199,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111103','安徽省.毫州市 ','AHSHZS ','8',200,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111104','安徽省.巢湖市 ','AHSCHS ','8',201,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111105','安徽省.芜湖市 ','AHSWHS ','8',202,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111106','安徽省.黄山市 ','AHSHSS ','8',203,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111107','安徽省.铜陵市 ','AHSTLS ','8',204,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111108','安徽省.安庆市 ','AHSAQS ','8',205,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111109','安徽省.淮南市 ','AHSHNS ','8',206,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111110','安徽省.宿州市 ','AHSSZS ','8',207,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111111','安徽省.阜阳市 ','AHSFYS ','8',208,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111112','安徽省.六安市 ','AHSLAS ','8',209,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111113','安徽省.滁州市 ','AHSCZS ','8',210,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111114','安徽省.宣城市 ','AHSXCS ','8',211,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111115','安徽省.马鞍山市 ','AHSMASS ','8',212,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111116','安徽省.池州市','AHSCZS','8',213,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112','山东省','SDS','8',214,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112100','山东省.济南市 ','SDSJNS ','8',215,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112101','山东省.临清市 ','SDSLQS ','8',216,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112102','山东省.淄博市 ','SDSZBS ','8',217,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112103','山东省.东营市 ','SDSDYS ','8',218,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112104','山东省.诸城市 ','SDSZCS ','8',219,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112105','山东省.烟台市 ','SDSYTS ','8',220,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112106','山东省.青岛市 ','SDSQDS ','8',221,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112107','山东省.莱芜市 ','SDSLWS ','8',222,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112108','山东省.济宁市 ','JNS SDS','8',223,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112109','山东省.荷泽市 ','SDSHZS ','8',224,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112110','山东省.日照市 ','SDSRZS ','8',225,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112111','山东省.藤州市 ','SDSTZS ','8',226,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112112','山东省.聊城市 ','SDSLCS ','8',227,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112113','山东省.德州市 ','SDSDZS ','8',228,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112114','山东省.滨州市 ','SDSBZS ','8',229,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112115','山东省.潍坊市 ','SDSWFS ','8',230,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112116','山东省.青州市 ','SDSQZS ','8',231,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112117','山东省.威海市 ','SDSWHS ','8',232,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112118','山东省.泰安市 ','SDSTAS ','8',233,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112119','山东省.新泰市 ','SDSXTS ','8',234,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112120','山东省.曲阜市 ','SDSQFS ','8',235,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112121','山东省.临沂市 ','SDSLYS ','8',236,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112122','山东省.枣庄市 ','SDSZZS ','8',237,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113','浙江省','ZJS','8',238,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113100','浙江省.杭州市 ','ZJSHZS ','8',239,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113101','浙江省.下城区','ZJSXCQ','8',240,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113102','浙江省.江干区','ZJSJGQ','8',241,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113103','浙江省.绍兴市 ','ZJSSXS ','8',242,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113104','浙江省.嘉兴市 ','ZJSJXS ','8',243,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113105','浙江省.宁波市 ','ZJSNBS ','8',244,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113106','浙江省.舟山市 ','ZJSZSS ','8',245,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113107','浙江省.椒江市 ','ZJSJJS ','8',246,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113108','浙江省.兰溪市 ','ZJSLXS ','8',247,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113109','浙江省.衙州市 ','ZJSYZS ','8',248,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113110','浙江省.温州市 ','ZJSWZS ','8',249,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113111','浙江省.东阳市 ','ZJSDYS ','8',250,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113112','浙江省.乐清市','ZJSLQS','8',251,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113113','浙江省.上城区','ZJSSCQ','8',252,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113114','浙江省.西湖区','ZJSXHQ','8',253,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113115','浙江省.萧山市 ','ZJSXSS ','8',254,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113116','浙江省.湖州市 ','ZJSHZS ','8',255,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113117','浙江省.海宁市 ','ZJSHNS ','8',256,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113118','浙江省.余姚市 ','ZJSYYS ','8',257,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113119','浙江省.临海市 ','ZJSLHS ','8',258,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113120','浙江省.金华市 ','ZJSJHS ','8',259,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113121','浙江省.丽水市 ','ZJSLSS ','8',260,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113122','浙江省.江山市 ','ZJSJSS ','8',261,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113123','浙江省.义乌市 ','ZJSYWS ','8',262,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113124','浙江省.瑞安市 ','ZJSRAS ','8',263,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113125','浙江省.台州市','ZJSTZS','8',264,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114','江西省','JXS','8',265,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114100','江西省.南昌市','JXSNCS','8',266,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114101','江西省.景德镇市','JXSJDZS','8',267,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114102','江西省.鹰潭市','JXSYTS','8',268,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114103','江西省.新余市','JXSXYS','8',269,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114104','江西省.赣州市','JXSGZS','8',270,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114105','江西省.井冈山市','JXSJGSS','8',271,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114106','江西省.临川市','JXSLCS','8',272,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114107','江西省.九江市','JXSJJS','8',273,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114108','江西省.上饶市','JXSSRS','8',274,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114109','江西省.宜春市','JXSYCS','8',275,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114110','江西省.萍乡市','JXSPXS','8',276,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114111','江西省.吉安市','JXSJAS','8',277,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114112','江西省.抚州市','JXSFZS','8',278,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115','福建省','FJS','8',279,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115100','福建省.福州市','FJSFZS','8',280,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115101','福建省.南平市','FJSNPS','8',281,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115102','福建省.厦门市','FJSXMS','8',282,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115103','福建省.石狮市','FJSSSS','8',283,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115104','福建省.龙岩市','FJSLYS','8',284,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115105','福建省.永安市','FJSYAS','8',285,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115106','福建省.莆田市','FJSPTS','8',286,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115107','福建省.邵武市','FJSSWS','8',287,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115108','福建省.泉州市','FJSQZS','8',288,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115109','福建省.漳州市','FJSZZS','8',289,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115110','福建省.三明市','FJSSMS','8',290,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115111','福建省.宁德市','FJSNDS','8',291,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116','湖南省','HNS','8',292,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116100','湖南省.长沙市','HNSCSS','8',293,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116101','湖南省.湘乡市','HNSXXS','8',294,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116102','湖南省.益阳市','HNSYYS','8',295,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116103','湖南省.汨罗市','HNSZLS','8',296,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116104','湖南省.津市市','HNSJSS','8',297,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116105','湖南省.大庸市','HNSDYS','8',298,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116106','湖南省.连源市','HNSLYS','8',299,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116107','湖南省.怀化市','HNSHHS','8',300,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116108','湖南省.衡阳市','HNSHYS','8',301,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116109','湖南省.邵阳市','HNSSYS','8',302,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116110','湖南省.永州市','HNSYZS','8',303,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116111','湖南省.张家界市','HNSZJJS','8',304,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116112','湖南省.湘潭市','HNSXTS','8',305,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116113','湖南省.株洲市','HNSZZS','8',306,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116114','湖南省.岳阳市','HNSYYS','8',307,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116115','湖南省.常德市','HNSCDS','8',308,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116116','湖南省.吉首市','HNSJSS','8',309,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116117','湖南省.娄底市','HNSLDS','8',310,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116118','湖南省.冷水江市','HNSLSJS','8',311,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116119','湖南省.洪江市','HNSHJS','8',312,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116120','湖南省.来阳市','HNSLYS','8',313,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116121','湖南省.彬州市','HNSBZS','8',314,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116122','湖南省.冷水滩市','HNSLSTS','8',315,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116123','湖南省.湘西土家族苗族自治州','HNS.XXTJZMZZZZ','8',316,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117','湖北省','HBS','8',317,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117100','湖北省.武汉市','HBSWHS','8',318,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117101','湖北省.天门市','HBSTMS','8',319,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117102','湖北省.应城市','HBSYCS','8',320,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117103','湖北省.应城市','HBSYCS','8',321,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117104','湖北省.应城市','HBSYCS','8',322,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117105','湖北省.应城市','HBSYCS','8',323,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117106','湖北省.应城市','HBSYCS','8',324,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117107','湖北省.咸宁市','HBSXNS','8',325,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117108','湖北省.蒲昕市','HBSPZS','8',326,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117109','湖北省.咸宁市','HBSXNS','8',327,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117110','湖北省.咸宁市','HBSXNS','8',328,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117111','湖北省.咸宁市','HBSXNS','8',329,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117112','湖北省.利川市','HBSLCS','8',330,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117113','湖北省.利川市','HBSLCS','8',331,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117114','湖北省.利川市','HBSLCS','8',332,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117115','湖北省.孝感市','HBSXGS','8',333,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117116','湖北省.安陆市','HBSALS','8',334,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117117','湖北省.洪湖市','HBSHHS','8',335,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117118','湖北省.石首市','HBSSSS','8',336,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117119','湖北省.黄石市','HBSHSS','8',337,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117120','湖北省.武穴市','HBSW穴S','8',338,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117121','湖北省.襄樊市','HBSXFS','8',339,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117122','湖北省.随州市','HBSSZS','8',340,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117123','湖北省.丹江口市','HBSDJKS','8',341,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117124','湖北省.宜昌市','HBSYCS','8',342,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117125','湖北省.恩施土家族苗族自治州','HBS.ESTJZMZZZZ','8',343,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117126','湖北省.利川市','HBSLCS','8',344,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118','河南省','HNS','8',345,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118100','河南省.郑州市','HNSZZS','8',346,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118101','河南省.焦作市','HNSJZS','8',347,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118102','河南省.鹤壁市','HNSHBS','8',348,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118103','河南省.许昌市','HNSXCS','8',349,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118104','河南省.驻马店市','HNSZMDS','8',350,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118105','河南省.周口市','HNSZKS','8',351,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118106','河南省.洛阳市','HNSLYS','8',352,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118107','河南省.义马市','HNSYMS','8',353,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118108','河南省.开封市','HNSKFS','8',354,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118109','河南省.新乡市','HNSXXS','8',355,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118110','河南省.安阳市','HNSAYS','8',356,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118111','河南省.濮阳市','HNSZYS','8',357,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118112','河南省.缧河市','HNSZHS','8',358,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118113','河南省.信阳市','HNSXYS','8',359,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118114','河南省.平顶山市','HNSPDSS','8',360,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118115','河南省.三门峡市','HNSSMXS','8',361,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118116','河南省.南阳市','HNSNYS','8',362,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118117','河南省.商丘市','HNSSQS','8',363,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119','广东省','GDS','8',364,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119100','广东省.广州市','GDSGZS','8',365,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119101','广东省.东莞市','GDSDZS','8',366,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119102','广东省.梅州市','GDSMZS','8',367,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119103','广东省.潮州市','GDSCZS','8',368,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119104','广东省.汕尾市','GDSSWS','8',369,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119105','广东省.深圳市','GDSSZS','8',370,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119106','广东省.茂名市','GDSMMS','8',371,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119107','广东省.佛山市','GDSFSS','8',372,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119108','广东省.江门市','GDSJMS','8',373,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119109','广东省.珠海市','GDSZHS','8',374,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119110','广东省.云浮市','GDSYFS','8',375,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119111','广东省.清远市','GDSQYS','8',376,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119112','广东省.韶关市','GDSSGS','8',377,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119113','广东省.汕头市','GDSSTS','8',378,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119114','广东省.惠州市','GDSHZS','8',379,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119115','广东省.河源市','GDSHYS','8',380,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119116','广东省.湛江市','GDSZJS','8',381,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119117','广东省.肇庆市','GDSZQS','8',382,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119118','广东省.中山市','GDSZSS','8',383,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119119','广东省.阳江市','GDSYJS','8',384,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119120','广东省.揭阳市','GDSJYS','8',385,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120','海南省','HNS','8',386,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120100','海南省.海口市','HNSHKS','8',387,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120101','海南省.通什市','HNSTSS','8',388,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120102','海南省.三亚市','HNSSYS','8',389,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120103','海南省.海南省','HNSHNS','8',390,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121','广西壮族自治区','GXZZZZQ','8',391,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121100','广西.南宁市','GXNNS','8',392,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121101','广西.百色市','GXBSS','8',393,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121102','广西.北海市','GXBHS','8',394,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121103','广西.桂林市','GXGLS','8',395,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121104','广西.柳州市','GXLZS','8',396,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121105','广西.河池市','GXHCS','8',397,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121106','广西.贵港市','GXGGS','8',398,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121107','广西.凭祥市','GXPXS','8',399,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121108','广西.钦州市','GXQZS','8',400,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121109','广西.玉林市','GXYLS','8',401,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121110','广西.梧州市','GXWZS','8',402,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121111','广西.台山市','GXTSS','8',403,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121112','广西.防城港市','GXFCGS','8',404,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121113','广西.贺州市','GXHZS','8',405,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122','贵州省','GZS','8',406,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122100','贵州省.贵阳市','GZSGYS','8',407,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122101','贵州省.铜仁市','GZSTRS','8',408,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122102','贵州省.都匀市','GZSDYS','8',409,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122103','贵州省.兴义市','GZSXYS','8',410,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122104','贵州省.赤水市','GZSCSS','8',411,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122105','贵州省.六盘水市','GZSLPSS','8',412,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122106','贵州省.凯里市','GZSKLS','8',413,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122107','贵州省.安顺市','GZSASS','8',414,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122108','贵州省.遵义市','GZSZYS','8',415,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122109','贵州省.毕节地区','GZSBJDQ','8',416,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122110','贵州省.黔东南苗族侗族自治州','GZS.QDNMZDZZZZ','8',417,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122111','贵州省.黔西南布依族苗族自治州 ','GZS.QXNBYZMZZZZ ','8',418,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122112','贵州省.黔南布依族苗族自治州','GZS.QNBYZMZZZZ','8',419,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123','四川省','SCS','8',420,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123100','四川省.成都市','SCSCDS','8',421,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123101','四川省.温江县','SCSWJX','8',422,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123102','四川省.都江堰市','SCSDJYS','8',423,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123103','四川省.攀枝花市','SCSPZHS','8',424,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123104','四川省.自贡市','SCSZGS','8',425,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123105','四川省.绵阳市','SCSMYS','8',426,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123106','四川省.南充市','SCSNCS','8',427,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123107','四川省.达州市','SCSDZS','8',428,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123108','四川省.遂宁市','SCSSNS','8',429,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123109','四川省.广安市','SCSGAS','8',430,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123110','四川省.巴中市','SCSBZS','8',431,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123111','四川省.泸州市','SCSZZS','8',432,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123112','四川省.宜宾市','SCSYBS','8',433,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123113','四川省.内江市','SCSNJS','8',434,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123114','四川省.资阳市','SCSZYS','8',435,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123115','四川省.乐山市','SCSLSS','8',436,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123116','四川省.眉山市','SCSMSS','8',437,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123117','四川省.凉山彝族自治州','SCS.LSYZZZZ','8',438,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123118','四川省.雅安市','SCSYAS','8',439,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123119','四川省.甘孜藏族自治州','SCS.GZCZZZZ','8',440,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123120','四川省.阿坝藏族羌族自治州','SCS.ABCZQZZZZ','8',441,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123121','四川省.德阳市','SCSDYS','8',442,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123122','四川省.广元市','SCSGYS','8',443,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124','云南省','YNS','8',444,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124100','云南省.西双版纳傣族自治州','YNS.XSBNDZZZZ','8',445,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124101','云南省.德宏傣族景颇族自治州','YNS.DHDZJPZZZZ','8',446,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124102','云南省.昭通市','YNSZTS','8',447,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124103','云南省.昆明市','YNSKMS','8',448,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124104','云南省.大理市','YNSDLS','8',449,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124105','云南省.大理白族自治州','YNS.DLBZZZZ','8',450,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124106','云南省.红河哈尼族彝族自治州','YNS.HHHNZYZZZZ','8',451,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124107','云南省.个旧市','YNSGJS','8',452,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124108','云南省.曲靖市','YNSQJS','8',453,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124109','云南省.保山市','YNSBSS','8',454,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124110','云南省.文山壮族苗族自治州','YNS.WSZZMZZZZ','8',455,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124111','云南省.玉溪市','YNSYXS','8',456,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124112','云南省.楚雄彝族自治州','YNS.CXYZZZZ','8',457,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124113','云南省.思茅地区','YNSSMDQ','8',458,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124114','云南省.临沧地区','YNSLCDQ','8',459,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124115','云南省.怒江傈僳族自治州','YNS.NJLSZZZZ','8',460,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124116','云南省.迪庆藏族自治州','YNS.DQCZZZZ','8',461,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124117','云南省.丽江地区','YNSLJDQ','8',462,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124118','云南省.东川市','YNSDCS','8',463,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124119','云南省.开远市','YNSKYS','8',464,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125','陕西省','SXS','8',465,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125100','陕西省.西安市','SXSXAS','8',466,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125101','陕西省.咸阳市','SXSXYS','8',467,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125102','陕西省.延安市','SXSYAS','8',468,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125103','陕西省.榆林市','SXSYLS','8',469,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125104','陕西省.渭南市','SXSWNS','8',470,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125105','陕西省.商洛市','SXSSLS','8',471,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125106','陕西省.安康市','SXSAKS','8',472,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125107','陕西省.汉中市','SXSHZS','8',473,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125108','陕西省.宝鸡市','SXSBJS','8',474,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125109','陕西省.铜川市','SXSTCS','8',475,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125110','陕西省.韩城市','SXSHCS','8',476,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126','甘肃省','GSS','8',477,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126100','甘肃省.兰州市','GSSLZS','8',478,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126101','甘肃省.临夏回族自治州','GSS.LXHZZZZ','8',479,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126102','甘肃省.定西地区','GSSDXDQ','8',480,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126103','甘肃省.平凉市','GSSPLS','8',481,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126104','甘肃省.庆阳市','GSSQYS','8',482,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126105','甘肃省.西峰市','GSSXFS','8',483,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126106','甘肃省.武威市','GSSWWS','8',484,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126107','甘肃省.张掖市','GSSZYS','8',485,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126108','甘肃省.嘉峪关市','GSSJYGS','8',486,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126109','甘肃省.金昌市','GSSJCS','8',487,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126110','甘肃省.酒泉市','GSSJQS','8',488,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126111','甘肃省.天水市','GSSTSS','8',489,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126112','甘肃省.陇南地区','GSSLNDQ','8',490,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126113','甘肃省.甘南藏族自治州','GSS.GNCZZZZ','8',491,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126114','甘肃省.白银市','GSSBYS','8',492,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126115','甘肃省.玉门市','GSSYMS','8',493,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127','宁夏回族自治区','NXHZZZQ','8',494,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127100','宁夏.银川市','NXYCS','8',495,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127101','宁夏.石嘴山市','NXSZSS','8',496,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127102','宁夏.青铜峡市','NXQTXS','8',497,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127103','宁夏.吴忠市','NXWZS','8',498,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127104','宁夏.固原市','NXGYS','8',499,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128','青海省','QHS','8',500,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128100','青海省.西宁市','QHSXNS','8',501,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128101','青海省.海北藏族自治州','QHS.HBCZZZZ','8',502,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128102','青海省.海东地区','QHSHDDQ','8',503,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128103','青海省.黄南藏族自治州','QHS.HNCZZZZ','8',504,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128104','青海省.海南藏族自治州','QHS.HNCZZZZ','8',505,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128105','青海省.果洛藏族自治州','QHS.GLCZZZZ','8',506,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128106','青海省.玉树藏族自治州','QHS.YSCZZZZ','8',507,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128107','青海省.德令哈市','QHSDLHS','8',508,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128108','青海省.海西蒙古族藏族自治州','QHS.HXMGZCZZZZ','8',509,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128109','青海省.格尔木市','QHSGEMS','8',510,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129','新疆维吾尔自治区','XJWWEZZQ','8',511,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129100','新疆.乌鲁木齐市','XJWLMQS','8',512,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129101','新疆.塔城地区','XJTCDQ','8',513,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129102','新疆.哈密地区','XJHMDQ','8',514,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129103','新疆.和田地区','XJHTDQ','8',515,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129104','新疆.阿勒泰地区','XJALTDQ','8',516,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129105','新疆.克孜勒苏柯尔克孜自治州','XJ.KZLSKEKZZZZ','8',517,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129106','新疆.博乐塔拉蒙古族自治州','XJ.BLTLMGZZZZ','8',518,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129107','新疆.克拉玛依市','XJKLMYS','8',519,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129108','新疆.伊犁哈萨克自治州','XJ.YLHSKZZZ','8',520,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129109','新疆.奎屯市','XJKTS','8',521,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129110','新疆.石河子市','XJSHZS','8',522,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129111','新疆.昌吉回族自治州','XJCJHZZZZ','8',523,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129112','新疆.吐鲁番市','XJTLFS','8',524,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129113','新疆.巴音郭楞蒙古自治州','XJ.BYGLMGZZZ','8',525,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129114','新疆.库尔勒市','XJKELS','8',526,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129115','新疆.阿克苏地区','XJAKSDQ','8',527,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129116','新疆.喀什地区','XJKSDQ','8',528,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129117','新疆.伊宁市','XJYNS','8',529,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129118','新疆.阿图什市','XJATSS','8',530,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130','西藏自治区','XCZZQ','8',531,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130100','西藏.拉萨市','XCLSS','8',532,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130101','西藏.日喀则地区','XCRKZDQ','8',533,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130102','西藏.山南地区','XCSNDQ','8',534,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130103','西藏.林芝地区','XCLZDQ','8',535,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130104','西藏.昌都地区','XCCDDQ','8',536,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130105','西藏.那曲地区','XCNQDQ','8',537,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130106','西藏.阿里地区','XCALDQ','8',538,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131','台湾省','TWS','8',539,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131100','台湾省.基隆','TWSJL','8',540,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131101','台湾省.台北','TWSTB','8',541,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131102','台湾省.台中','TWSTZ','8',542,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131103','台湾省.台南','TWSTN','8',543,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131104','台湾省.高雄','TWSGX','8',544,'00',5497000);
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131105','台湾省.台东','TWSTD','8',545,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('132','香港特别行政区','XGTBXZQ','8',546,'00',5497000);

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('133','澳门特别行政区','AMTBXZQ','8',547,'00',5497000);

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
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
  CONSTRAINT PK_PUB_G_RELATION PRIMARY KEY (ROWS_ID)
) ;

CREATE INDEX IX_PUB_GOODS_RELATION_RELATION_ID ON PUB_GOODS_RELATION(RELATION_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_GODS_ID ON PUB_GOODS_RELATION(GODS_ID);

CREATE INDEX IX_PUB_GOODS_RELATION_TIME_STAMP ON PUB_GOODS_RELATION(TENANT_ID,TIME_STAMP);


--企业经营商品视图,自经营商品+连锁商品                                              
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

CREATE INDEX IX_PUB_BARCODE_ROWS_ID ON PUB_BARCODE(TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BATCH_NO);

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

--每个门店都有记录，关联需加门店
--各商品价格
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
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.GLIDE_NO,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
   A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.UNIT_ID,B.CREA_USER,B.GLIDE_NO,B.STOCK_TYPE,B.CREA_DATE,
   A.CALC_AMOUNT,A.CALC_MONEY,A.AGIO_MONEY,A.AGIO_RATE,A.ORG_PRICE,A.APRICE,A.AMOUNT,B.TAX_RATE,A.ORG_PRICE*A.AMOUNT as STOCK_RTL,
   round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as TAX_MONEY,
   A.CALC_MONEY-round(A.CALC_MONEY/(1+case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end)*case when B.INVOICE_FLAG='3' then B.TAX_RATE else 0 end,2) as NOTAX_MONEY  
from STK_STOCKDATA A,STK_STOCKORDER B where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_TYPE in (1,3) and B.COMM not in ('02','12');

--调拨接收单视图
CREATE VIEW VIW_MOVEINDATA
as 
select
   B.TENANT_ID,B.SHOP_ID,B.STOCK_ID,B.GLIDE_NO,B.INVOICE_FLAG,B.STOCK_DATE,B.CLIENT_ID,A.BATCH_NO,A.LOCUS_NO,B.GUIDE_USER,
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

insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('A','现金','XJ','1',1,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('B','银联','YL','1',2,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('C','储值卡','CZK','1',3,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('D','记账','JZ','1',4,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('E','礼券','LQ','1',5,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('F','支票','ZP','1',6,'00',5497000);
insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('G','小额支付','XEZF','1',7,'00',5497000);

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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.CREA_DATE,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,A.GLIDE_NO,B.BARTER_INTEGRAL,
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
  A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.CREA_USER,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,A.GLIDE_NO,
  B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.SALES_TYPE, 
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

--交班结账表
CREATE TABLE ACC_CLOSE_FORDAY (
        --行号
	ROWS_ID char (36) NOT NULL ,
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (11) NOT NULL ,
        --关账日期
	CLSE_DATE int ,
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
CREATE INDEX IX_ACC_CLOSE_FORDAY_KEYFIELD ON ACC_CLOSE_FORDAY(TENANT_ID,SHOP_ID,CLSE_DATE);

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

--调拨视图（包括出货单和入货单）
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
