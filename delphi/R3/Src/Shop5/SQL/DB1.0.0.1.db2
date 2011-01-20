--参数选项
CREATE TABLE [PUB_PARAMS](
    --选项代码
	[CODE_ID] [varchar](20) NOT NULL,
    --选项名称
	[CODE_NAME] [nvarchar](50) NOT NULL,
    --拼音码
	[CODE_SPELL] [nvarchar](50) NULL,
    --选项类型
	[TYPE_CODE] [varchar](50) NOT NULL,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_PARAMS_COMM]  DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY ([CODE_ID],[TYPE_CODE])
);

CREATE INDEX IX_PUB_PARAMS_TYPE_CODE ON PUB_PARAMS(TYPE_CODE);

CREATE INDEX IX_PUB_PARAMS_TIME_STAMP ON PUB_PARAMS(TIME_STAMP);

--参数设置表
CREATE TABLE [SYS_DEFINE] (
        --企业代码，全局参数时代码为 0 
	[TENANT_ID] int NOT NULL ,
        --参数名,英文代码
	[DEFINE] [varchar] (30) NOT NULL ,
        --参数值
	[VALUE] [varchar] (100) NULL ,
        --参数类型，默认为0
	[VALUE_TYPE] [tinyint] NOT NULL ,
        --通讯标志
	[COMM] [varchar] (2) NOT NULL CONSTRAINT [DF_SYS_DEFINE_COMM] DEFAULT ('00'),
        --时间戳 重2011-01-01开始的秒数  
        [TIME_STAMP] bigint NOT NULL,
	PRIMARY KEY ([TENANT_ID],[DEFINE])
);

insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'ADMIN','admin',0,'00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'PASSWRD','79415A40',0,'00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,'DBVERSION','DB1.0.0.1',0,'00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--企业类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','制造商','TENANT_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','经销商','TENANT_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','零售商','TENANT_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--企业资料
CREATE TABLE [CA_TENANT](
    --企业代码
	[TENANT_ID] int NOT NULL,
    --登录名称 例:celeb.net
	[LOGIN_NAME] [varchar](50) NOT NULL,
    --企业名称
	[TENANT_NAME] [varchar](50) NOT NULL,
    --企业类型
	[TENANT_TYPE] [varchar](1) NOT NULL,
    --企业简称
	[SHORT_TENANT_NAME] [varchar](50) NOT NULL,
    --拼音码
	[TENANT_SPELL] [varchar](50) NOT NULL,
    --法人代表
	[LEGAL_REPR] [varchar](20) NULL,
    --联系人
	[LINKMAN] [varchar](20) NULL,
    --联系电话
	[TELEPHONE] [varchar](30) NULL,
    --传真
	[FAXES] [varchar](30) NULL,
    --主页
	[HOMEPAGE] [varchar](50) NULL,
    --地址
	[ADDRESS] [varchar](50) NULL,
    --邮编
	[POSTALCODE] [varchar](6) NULL,
    --备注
	[REMARK] [varchar](100) NULL,
    --认证密码
	[PASSWRD] [varchar](50) NULL,
    --所属区域
	[REGION_ID] [varchar](10) NULL,
    --服务器编号
	[SRVR_ID] [varchar](10) NULL,
    --软件产品编号
	[PROD_ID] [varchar](10) NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_TENANT_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY ([TENANT_ID])
);

CREATE INDEX IX_CA_TENANT_TIME_STAMP ON CA_TENANT(TIME_STAMP);

--关系类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','经销商','RELATION_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','加盟店','RELATION_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','联营店','RELATION_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('4','代销点','RELATION_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--关系类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','申请','RELATION_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','审核','RELATION_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
--企业关系
CREATE TABLE [CA_RELATIONS](
    --ID号
	[RELATION_ID] int NOT NULL,
    --当前企业代码
	[TENANT_ID] int NOT NULL,
    --下级企业代码
	[RELATI_ID] int NOT NULL,
    --关系类型
	[RELATION_TYPE] [varchar](1) NOT NULL,
    --结构树 0000 4位一级，最多支持7级
	[LEVEL_ID] [varchar](28) NOT NULL,
    --关系状态  1 申请 2 审核 
	[RELATION_STATUS] [varchar](1) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_RELATIONS_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
 PRIMARY KEY ([RELATION_ID])
);

CREATE INDEX IX_CA_RELATIONS_TENANT_ID ON CA_RELATIONS(TENANT_ID);

CREATE INDEX IX_CA_RELATIONS_RELATI_ID ON CA_RELATIONS(RELATI_ID);

CREATE INDEX IX_CA_RELATIONS_LEVEL_ID ON CA_RELATIONS(LEVEL_ID);

CREATE INDEX IX_CA_RELATIONS_TIME_STAMP ON CA_RELATIONS(TIME_STAMP);

--部门资料
CREATE TABLE [CA_DEPT_INFO](
    --部门代码 企业代码+3位序号
	[DEPT_ID] int NOT NULL,
    --部门名称
	[DEPT_NAME] [varchar](50) NOT NULL,
    --拼音码
	[DEPT_SPELL] [varchar](50) NOT NULL,
    --从属关系 第3位一级
	[LEVEL_ID] [varchar](50) NULL,
    --企业代码
	[TENANT_ID] int NULL,
    --部门电话
	[TELEPHONE] [varchar](30) NULL,
    --联系人
	[LINKMAN] [varchar](20) NULL,
    --传真
	[FAXES] [varchar](30) NULL,
    --备注
	[REMARK] [varchar](100) NULL,
    --排序号
    [SEQ_NO] int NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_DEPT_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY ([DEPT_ID] )
);

CREATE INDEX IX_CA_DEPT_INFO_TENANT_ID ON CA_DEPT_INFO(TENANT_ID);

CREATE INDEX IX_CA_DEPT_INFO_TIME_STAMP ON CA_DEPT_INFO(TIME_STAMP);


--门店资料
CREATE TABLE [CA_SHOP_INFO](
    --门店代码 企业代码+4位序号
	[SHOP_ID] int NOT NULL,
    --门店名称
	[SHOP_NAME] [varchar](50) NOT NULL,
    --拼音码
	[SHOP_SPELL] [varchar](50) NOT NULL,
    --企业代码
	[TENANT_ID] int NULL,
    --门店负责人
	[LINKMAN] [varchar](20) NULL,
    --联系电话
	[TELEPHONE] [varchar](30) NULL,
    --传真
	[FAXES] [varchar](30) NULL,
    --门店地址
	[ADDRESS] [varchar](50) NULL,
    --邮编
	[POSTALCODE] [varchar](6) NULL,
    --备注
	[REMARK] [varchar](100) NULL,
    --所属区域
	[REGION_ID] [varchar](10) NULL,
    --门店类型(原管理群组 对应PUB_CODE_INFO)
	[SHOP_TYPE] [varchar](21) NULL,
    --排序号
        [SEQ_NO] int NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_SHOP_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([SHOP_ID])
);

CREATE INDEX IX_CA_SHOP_INFO_TENANT_ID ON CA_SHOP_INFO(TENANT_ID);

CREATE INDEX IX_CA_SHOP_INFO_TIME_STAMP ON CA_SHOP_INFO(TIME_STAMP);

--职务资料
CREATE TABLE [CA_DUTY_INFO](
    --职务代码 企业代码+3位序号
	[DUTY_ID] [varchar](10) NOT NULL,
    --职务名称
	[DUTY_NAME] [varchar](30) NOT NULL,
    --从属关系 第3位一级
	[LEVEL_ID] [varchar](50) NULL,
    --拼音码
	[DUTY_SPELL] [varchar](30) NOT NULL,
    --所属企业
	[TENANT_ID] int NOT NULL,
    --说明
	[REMARK] [varchar](100) NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_DUTY_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([DUTY_ID])
);

CREATE INDEX IX_CA_DUTY_INFO_TENANT_ID ON CA_DUTY_INFO(TENANT_ID);

CREATE INDEX IX_CA_DUTY_INFO_TIME_STAMP ON CA_DUTY_INFO(TIME_STAMP);

--角色资料
CREATE TABLE [CA_ROLE_INFO](
    --角色代码 企业代码+3位序号
	[ROLE_ID] [varchar](10) NOT NULL,
    --角色名称
	[ROLE_NAME] [varchar](30) NOT NULL,
    --拼音码
	[ROLE_SPELL] [varchar](30) NOT NULL,
    --所属企业
	[TENANT_ID] int NOT NULL,
    --说明
	[REMARK] [varchar](100) NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_ROLE_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([ROLE_ID])
);

CREATE INDEX IX_CA_ROLE_INFO_TENANT_ID ON CA_ROLE_INFO(TENANT_ID);

CREATE INDEX IX_CA_ROLE_INFO_TIME_STAMP ON CA_ROLE_INFO(TIME_STAMP);

--用户资料
CREATE TABLE [CA_USERS](
    --用户代码newid()的guid值
	[USER_ID] [varchar](36) NOT NULL,
    --登录名  企业内不重复
	[ACCOUNT] [varchar](20) NOT NULL,
    --识别码  IC号卡或指纹码
	[ENCODE] [varchar](50) NULL,
    --用户名
	[USER_NAME] [varchar](20) NOT NULL,
    --拼音码
	[USER_SPELL] [varchar](20) NOT NULL,
    --密码
	[PASS_WRD] [varchar](50) NULL,
    --所属门店 
	[SHOP_ID] int NOT NULL,
    --所属部门
	[DEPT_ID] int NOT NULL,
    --所属职务,多职务用,号分隔
	[DUTY_IDS] [varchar](100) NOT NULL,
    --所属职务名称,多职务用,号分隔
	[DUTY_NAMES] [varchar](250) NOT NULL,
    --所属角色,多角色用,号分隔
	[ROLE_IDS] [varchar](100) NOT NULL,
    --所属角色名称,多角色用,号分隔
	[ROLE_NAMES] [varchar](250) NOT NULL,
    --企业代码
	[TENANT_ID] int NOT NULL,
    --性别  男\女\保密
	[SEX] [varchar](4) NULL,
    --手机号
	[MOBILE] [varchar](11) NULL,
    --办公电话
	[OFFI_TELE] [varchar](11) NULL,
    --家庭电话
	[FAMI_TELE] [varchar](11) NULL,
    --电子邮箱
	[EMAIL] [varchar](50) NULL,
    --QQ号
	[QQ] [varchar](50) NULL,
    --MSN号
	[MSN] [varchar](50) NULL,
    --证件号码
	[ID_NUMBER] [varchar](50) NULL,
    --证件类型
	[IDN_TYPE] [varchar](21) NULL,
    --家庭地址
	[FAMI_ADDR] [varchar](50) NULL,
    --邮编
	[POSTALCODE] [varchar](6) NULL,
    --入职日期
	[WORK_DATE] [varchar](10) NULL,
    --职务日期
	[DIMI_DATE] [varchar](10) NULL,
    --说明
	[REMARK] [varchar](100) NULL,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
    [COMM] [varchar](2) NOT NULL CONSTRAINT [DF_CA_USERS_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY ([USER_ID] )
);

CREATE INDEX IX_CA_USERS_TENANT_ID ON CA_USERS(TENANT_ID);

CREATE INDEX IX_CA_USERS_ACCOUNT ON CA_USERS(ACCOUNT);

CREATE INDEX IX_CA_USERS_ENCODE ON CA_USERS(ENCODE);

CREATE INDEX IX_CA_USERS_TIME_STAMP ON CA_USERS(TIME_STAMP);

CREATE view [VIW_USERS]
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,PASS_WRD,COMM from CA_USERS
union all
select 0 as TENANT_ID,0 as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLES_IDS,VALUE as PASS_WRD, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID=0;

--其他资料
CREATE TABLE [PUB_CODE_INFO](
    --企业代码<0为公共资料>
	[TENANT_ID] int NOT NULL CONSTRAINT [DF_PUB_CODE_INFO_TENANT_ID]  DEFAULT (0),
    --资料编码
	[CODE_ID] [varchar](36) NOT NULL,
    --树ID号 4位一级
	[LEVEL_ID] [varchar] (20) NULL ,
    --资料类型
	[CODE_TYPE] varchar(2) NOT NULL,
    --资料名称
	[CODE_NAME] [varchar](30) NOT NULL,
    --拼音码
	[CODE_SPELL] [varchar](30) NOT NULL,
    --排序号
	[SEQ_NO] int NULL,
	--通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_CODE_INFO_COMM]  DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY ([CODE_ID],[CODE_TYPE])
);

CREATE INDEX IX_PUB_CODE_INFO_CODE_TYPE ON PUB_CODE_INFO(CODE_TYPE);

CREATE INDEX IX_PUB_CODE_INFO_TIME_STAMP ON PUB_CODE_INFO(TIME_STAMP);

CREATE INDEX IX_PUB_CODE_INFO_TENANT_ID ON PUB_CODE_INFO(TENANT_ID);

--服务器路由表
CREATE TABLE [PUB_SERVER_INFO](
    --服务器编号
	[SRVR_ID] [varchar](10) NOT NULL,
    --服务名称
	[SRVR_NAME] [varchar](30) NOT NULL,
    --拼音码
	[SRVR_SPELL] [varchar](30) NOT NULL,
    --安装地点
	[ADDRESS] [varchar](100) NOT NULL,
    --安装日期
	[CREA_DATE] [varchar](10) NOT NULL,
    --服务器状态
	[SRVR_STATUS] [varchar](1) NOT NULL,
    --服务器类型
	[SRVR_TYPE] [varchar](1) NOT NULL,
    --主机地址
	[HOST_NAME] [varchar](20) NOT NULL,
    --服务端口号
	[SRVR_PORT] int NOT NULL,
    --URL路径,相对路径要结合IP取得全路径
	[SRVR_PATH] [varchar](50) NOT NULL,
    --排序号
    [SEQ_NO] int NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_SERVER_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([SRVR_ID])
);

CREATE INDEX IX_PUB_SERVER_INFO_TIME_STAMP ON PUB_SERVER_INFO(TIME_STAMP);

--服务器状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','正常','SRVR_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','爆满','SRVR_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','禁用','SRVR_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--服务器类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','自有服务器','SRVR_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','托管服务器','SRVR_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','商户服务器','SRVR_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--系列号
CREATE TABLE [PUB_SN_INFO](
    --系列号
	[SN] [varchar](20) NOT NULL,
    --种子号
	[SN_CODE] [varchar](10) NOT NULL,
    --系列号状态
	[SN_STATUS] [varchar](1) NOT NULL,
    --门店代码
	[SHOP_ID] int NOT NULL,
    --激活日期
	[ACTV_DATE] [varchar](10) NOT NULL,
    --有效截止日期
	[END_DATE] [varchar](10) NOT NULL,
    --创建日期
	[CREA_DATE] [varchar](10) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_SN_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([SN])
);

CREATE INDEX IX_PUB_SN_INFO_SN ON PUB_SN_INFO(SN);

CREATE INDEX IX_PUB_SN_INFO_TIME_STAMP ON PUB_SN_INFO(TIME_STAMP);

--系列号状态
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('0','空置','SN_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','使用','SN_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','过期','SN_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('9','禁用','SN_STATUS','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('8','地区编码','CODE_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('11','证件类型','CODE_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('12','管理群组','CODE_TYPE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('1','身份证','SFZ','11','1','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('2','驾驶证','JSZ','11','2','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('3','社保卡','SBK','11','2','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('99','其他','QT','11','2','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100','北京市','BJS','8','1','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100100','北京市.西城区','BJS.XCQ','8','2','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100101','北京市.崇文区','BJS.CWQ','8','3','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100102','北京市.海淀区','BJS.HDQ','8','4','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100103','北京市.门头沟区','BJS.MTGQ','8','5','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100104','北京市.通县','BJS.TX','8','6','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100105','北京市.顺义县','BJS.SYX','8','7','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100106','北京市.密云县','BJS.MYX','8','8','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100107','北京市.昌平县','BJS.CPX','8','9','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100108','北京市.东城区','BJS.DCQ','8','10','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100109','北京市.宣武区','BJS.XWQ','8','11','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100110','北京市.朝阳区','BJS.CYQ','8','12','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100111','北京市.丰台区','BJS.FTQ','8','13','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100112','北京市.石景山区','BJS.SJSQ','8','14','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100113','北京市.平觳县','BJS.PZX','8','15','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100114','北京市.怀柔县','BJS.HRX','8','16','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100115','北京市.延庆县','BJS.YQX','8','17','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('100116','北京市.大兴县','BJS.DXX','8','18','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101','上海市','SHS','8','19','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101100','上海市.卢湾区','SHS.LWQ','8','20','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101101','上海市.吴松区','SHS.WSQ','8','21','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101102','上海市.闸北区','SHS.ZBQ','8','22','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101103','上海市.虹口区','SHS.HKQ','8','23','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101104','上海市.黄浦区','SHS.HPQ','8','24','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101105','上海市.静安区','SHS.JAQ','8','25','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101106','上海市.上海县','SHS.SHX','8','26','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101107','上海市.南汇县','SHS.NHX','8','27','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101108','上海市.金山县','SHS.JSX','8','28','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101109','上海市.青浦县','SHS.QPX','8','29','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101110','上海市.宝山县','SHS.BSX','8','30','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101111','上海市.长宁区','SHS.CNQ','8','31','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101112','上海市.杨浦区','SHS.YPQ','8','32','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101113','上海市.闵行区','SHS.ZXQ','8','33','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101114','上海市.南市区','SHS.NSQ','8','34','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101115','上海市.徐汇区','SHS.XHQ','8','35','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101116','上海市.普陀区','SHS.PTQ','8','36','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101117','上海市.嘉定县','SHS.JDX','8','37','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101118','上海市.川沙县','SHS.CSX','8','38','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101119','上海市.奉贤县','SHS.FXX','8','39','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101120','上海市.松江县','SHS.SJX','8','40','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('101121','上海市.崇明县','SHS.CMX','8','41','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102','天津市','TJS','8','42','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102100','天津市.河西区 ','TJS.HXQ ','8','43','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102101','天津市.南开区 ','TJS.NKQ ','8','44','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102102','天津市.塘沽区','TJS.TGQ','8','45','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102103','天津市.东郊区','TJS.DJQ','8','46','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102104','天津市.西郊区 ','TJS.XJQ ','8','47','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102105','天津市.大港区','TJS.DGQ','8','48','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102106','天津市.河东区','TJS.HDQ','8','49','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102107','天津市.河北区','TJS.HBQ','8','50','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102108','天津市.红桥区','TJS.HQQ','8','51','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102109','天津市.汉沽区 ','TJS.HGQ ','8','52','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102110','天津市.南郊区','TJS.NJQ','8','53','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('102111','天津市.北郊区 ','TJS.BJQ ','8','54','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('103','重庆市','ZQS','8','55','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104','内蒙古自治区','NMGZZQ','8','56','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104100','内蒙古.呼和浩特市','NMG.HHHTS','8','57','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104101','内蒙古.二连浩特市','NMG.ELHTS','8','58','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104102','内蒙古.临河市','NMG.LHS','8','59','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104103','内蒙古.东胜市','NMG.DSS','8','60','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104104','内蒙古.满洲里市','NMG.MZLS','8','61','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104105','内蒙古.赤峰市','NMG.CFS','8','62','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104106','内蒙古.乌兰浩特市','NMG.WLHTS','8','63','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104107','内蒙古.鄂尔多斯市','NMG.EEDSS','8','64','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104108','内蒙古.兴安盟','NMG.XAM','8','65','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104109','内蒙古.乌兰察布盟','NMG.WLCBM','8','66','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104110','内蒙古.阿拉善盟','NMG.ALSM','8','67','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104111','内蒙古.集宁市','NMG.JNS','8','68','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104112','内蒙古.包头市','NMG.BTS','8','69','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104113','内蒙古.乌海市','NMG.WHS','8','70','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104114','内蒙古.海拉尔市','NMG.HLES','8','71','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104115','内蒙古.牙克石市','NMG.YKSS','8','72','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104116','内蒙古.锡林浩特市','NMG.XLHTS','8','73','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104117','内蒙古.通辽市','NMG.TLS','8','74','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104118','内蒙古.呼伦贝尔市','NMG.HLBES','8','75','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104119','内蒙古.锡林郭勒盟','NMG.XLGLM','8','76','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('104120','内蒙古.巴彦淖尔盟','NMG.BYNEM','8','77','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105','山西省','SXS','8','78','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105100','山西省.太原市','SXS.TYS','8','79','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105101','山西省.忻州市','SXS.XZS','8','80','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105102','山西省.临汾市','SXS.LFS','8','81','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105103','山西省.运城市','SXS.YCS','8','82','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105104','山西省.长治市','SXS.CZS','8','83','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105105','山西省.朔州市','SXS.SZS','8','84','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105106','山西省.吕梁地区','SXS.LLDQ','8','85','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105107','山西省.榆次市','SXS.YCS','8','86','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105108','山西省.大同市','SXS.DTS','8','87','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105109','山西省.侯马市','SXS.HMS','8','88','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105110','山西省.阳泉市','SXS.YQS','8','89','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105111','山西省.晋城市','SXS.JCS','8','90','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('105112','山西省.晋中市','SXS.JZS','8','91','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106','河北省','HBS','8','92','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106100','河北省.石家庄市','HBS.SJZS','8','93','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106101','河北省.辛集市','HBS.XJS','8','94','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106102','河北省.邢台市','HBS.XTS','8','95','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106103','河北省.邯郸市','HBS.HDS','8','96','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106104','河北省.泊头市','HBS.BTS','8','97','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106105','河北省.唐山市','HBS.TSS','8','98','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106106','河北省.北戴河','HBS.BDH','8','99','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106107','河北省.保定市','HBS.BDS','8','100','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106108','河北省.定州市','HBS.DZS','8','101','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106109','河北省.廊坊市','HBS.LFS','8','102','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106110','河北省.南宫市','HBS.NGS','8','103','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106111','河北省.衡水市','HBS.HSS','8','104','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106112','河北省.沙河市','HBS.SHS','8','105','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106113','河北省.沧州市','HBS.CZS','8','106','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106114','河北省.任丘市','HBS.RQS','8','107','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106115','河北省.秦皇岛市','HBS.QHDS','8','108','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106116','河北省.承德市','HBS.CDS','8','109','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106117','河北省.涿州市','HBS.ZZS','8','110','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('106118','河北省.张家口市','HBS.ZJKS','8','111','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107','辽宁省','LNS','8','112','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107100','辽宁省.沈阳市','LNS.SYS','8','113','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107101','辽宁省.铁岭市','LNS.TLS','8','114','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107102','辽宁省.抚顺市','LNS.FSS','8','115','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107103','辽宁省.海城市','LNS.HCS','8','116','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107104','辽宁省.大连市','LNS.DLS','8','117','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107105','辽宁省.本溪市','LNS.BXS','8','118','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107106','辽宁省.锦州市','LNS.JZS','8','119','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107107','辽宁省.兴城市','LNS.XCS','8','120','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107108','辽宁省.北票市','LNS.BPS','8','121','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107109','辽宁省.盘锦市','LNS.PJS','8','122','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107110','辽宁省.辽阳市','LNS.LYS','8','123','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107111','辽宁省.铁岭市','LNS.TLS','8','124','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107112','辽宁省.鞍山市','LNS.ASS','8','125','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107113','辽宁省.营口市','LNS.YKS','8','126','00',convert(bigint,(convert(float,getdate())-40542.0)*86400)) ;
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107114','辽宁省.瓦房店市','LNS.WFDS','8','127','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107115','辽宁省.丹东市','LNS.DDS','8','128','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107116','辽宁省.锦西市','LNS.JXS','8','129','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107117','辽宁省.朝阳市','LNS.CYS','8','130','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107118','辽宁省.阜新市','LNS.FXS','8','131','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('107119','辽宁省.葫芦岛市','LNS.HLDS','8','132','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108','吉林省','JLS','8','133','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108100','吉林省.长春市 ','JLS.CCS ','8','134','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108101','吉林省.吉林市 ','JLS.JLS ','8','135','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108102','吉林省.延吉市 ','JLS.YJS ','8','136','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108103','吉林省.龙井市 ','JLS.LJS ','8','137','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108104','吉林省.通化市 ','JLS.THS ','8','138','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108105','吉林省.浑江市 ','JLS.HJS ','8','139','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108106','吉林省.四平市 ','JLS.SPS ','8','140','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108107','吉林省.辽源市 ','JLS.LYS ','8','141','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108108','吉林省.洮南市 ','JLS.ZNS ','8','142','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108109','吉林省.松原市 ','JLS.SYS ','8','143','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108110','吉林省.扶余市 ','JLS.FYS ','8','144','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108111','吉林省.桦甸市 ','JLS.ZDS ','8','145','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108112','吉林省.图门市 ','JLS.TMS ','8','146','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108113','吉林省.敦化市 ','JLS.DHS ','8','147','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108114','吉林省.集安市 ','JLS.JAS ','8','148','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108115','吉林省.梅河口市 ','JLS.MHKS ','8','149','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108116','吉林省.公主岭市 ','JLS.GZLS ','8','150','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108117','吉林省.白城市 ','JLS.BCS ','8','151','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108118','吉林省.白山市','JLS.BSS','8','152','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('108119','吉林省.延边朝鲜族自治州','JLS.YBCXZZZZ','8','153','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109','黑龙江省','HLJS','8','154','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109100','黑龙江省.哈尔滨市 ','HLJS.HEBS ','8','155','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109101','黑龙江省.肇东市 ','HLJS.ZDS ','8','156','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109102','黑龙江省.伊春市 ','HLJS.YCS ','8','157','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109103','黑龙江省.鹤岗市 ','HLJS.HGS ','8','158','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109104','黑龙江省.双鸭山市 ','HLJS.SYSS ','8','159','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109105','黑龙江省.牡丹江市 ','HLJS.MDJS ','8','160','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109106','黑龙江省.鸡西市 ','HLJS.JXS ','8','161','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109107','黑龙江省.大庆市 ','HLJS.DQS ','8','162','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109108','黑龙江省.黑河市 ','HLJS.HHS ','8','163','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109109','黑龙江省.大兴安岭地区','HLJS.DXALDQ','8','164','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109110','黑龙江省.阿城市 ','HLJS.ACS ','8','165','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109111','黑龙江省.绥化市 ','HLJS.SHS ','8','166','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109112','黑龙江省.佳木斯市 ','HLJS.JMSS ','8','167','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109113','黑龙江省.七台河市 ','HLJS.QTHS ','8','168','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109114','黑龙江省.同江市 ','HLJS.TJS ','8','169','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109115','黑龙江省.绥汾河市 ','HLJS.SFHS ','8','170','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109116','黑龙江省.齐齐哈尔市 ','HLJS.QQHES ','8','171','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109117','黑龙江省.北安市 ','HLJS.BAS ','8','172','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('109118','黑龙江省.五大连池市 ','HLJS.WDLCS ','8','173','00',convert(bigint,(convert(float,getdate())-40542.0)*86400))

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110','江苏省','JSS','8','174','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110100','江苏省.南京市 ','JSS.NJS ','8','175','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110101','江苏省.镇江市','JSS.ZJS','8','176','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110102','江苏省.常州市 ','JSS.CZS ','8','177','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110103','江苏省.宜兴市 ','JSS.YXS ','8','178','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110104','江苏省.苏州市 ','JSS.SZS ','8','179','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110105','江苏省.徐州市 ','JSS.XZS ','8','180','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110106','江苏省.淮阴市 ','JSS.HYS ','8','181','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110107','江苏省.宿迁市 ','JSS.SQS ','8','182','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110108','江苏省.东台市 ','JSS.DTS ','8','183','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110109','江苏省.泰州市 ','JSS.TZS ','8','184','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110110','江苏省.南通市 ','JSS.NTS ','8','185','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110111','江苏省.仪征市 ','JSS.YZS ','8','186','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110112','江苏省.丹阳市 ','JSS.DYS ','8','187','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110113','江苏省.无锡市 ','JSS.WXS ','8','188','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110114','江苏省.江阴市 ','JSS.JYS ','8','189','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110115','江苏省.常熟市 ','JSS.CSS ','8','190','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110116','江苏省.连云港市 ','JSS.LYGS ','8','191','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110117','江苏省.淮安市 ','JSS.HAS ','8','192','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110118','江苏省.盐城市 ','JSS.YCS ','8','193','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110119','江苏省.扬州市 ','JSS.YZS ','8','194','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('110120','江苏省.兴化市 ','JSS.XHS ','8','195','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111','安徽省','AHS','8','196','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111100','安徽省.合肥市 ','AHS.HFS ','8','197','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111101','安徽省.蚌埠市 ','AHS.BBS ','8','198','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111102','安徽省.淮北市 ','AHS.HBS ','8','199','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111103','安徽省.毫州市 ','AHS.HZS ','8','200','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111104','安徽省.巢湖市 ','AHS.CHS ','8','201','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111105','安徽省.芜湖市 ','AHS.WHS ','8','202','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111106','安徽省.黄山市 ','AHS.HSS ','8','203','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111107','安徽省.铜陵市 ','AHS.TLS ','8','204','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111108','安徽省.安庆市 ','AHS.AQS ','8','205','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111109','安徽省.淮南市 ','AHS.HNS ','8','206','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111110','安徽省.宿州市 ','AHS.SZS ','8','207','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111111','安徽省.阜阳市 ','AHS.FYS ','8','208','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111112','安徽省.六安市 ','AHS.LAS ','8','209','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111113','安徽省.滁州市 ','AHS.CZS ','8','210','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111114','安徽省.宣城市 ','AHS.XCS ','8','211','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111115','安徽省.马鞍山市 ','AHS.MASS ','8','212','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('111116','安徽省.池州市','AHS.CZS','8','213','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112','山东省','SDS','8','214','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112100','山东省.济南市 ','SDS.JNS ','8','215','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112101','山东省.临清市 ','SDS.LQS ','8','216','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112102','山东省.淄博市 ','SDS.ZBS ','8','217','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112103','山东省.东营市 ','SDS.DYS ','8','218','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112104','山东省.诸城市 ','SDS.ZCS ','8','219','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112105','山东省.烟台市 ','SDS.YTS ','8','220','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112106','山东省.青岛市 ','SDS.QDS ','8','221','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112107','山东省.莱芜市 ','SDS.LWS ','8','222','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112108','济宁市 山东省.','JNS SDS.','8','223','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112109','山东省.荷泽市 ','SDS.HZS ','8','224','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112110','山东省.日照市 ','SDS.RZS ','8','225','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112111','山东省.藤州市 ','SDS.TZS ','8','226','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112112','山东省.聊城市 ','SDS.LCS ','8','227','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112113','山东省.德州市 ','SDS.DZS ','8','228','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112114','山东省.滨州市 ','SDS.BZS ','8','229','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112115','山东省.潍坊市 ','SDS.WFS ','8','230','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112116','山东省.青州市 ','SDS.QZS ','8','231','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112117','山东省.威海市 ','SDS.WHS ','8','232','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112118','山东省.泰安市 ','SDS.TAS ','8','233','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112119','山东省.新泰市 ','SDS.XTS ','8','234','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112120','山东省.曲阜市 ','SDS.QFS ','8','235','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112121','山东省.临沂市 ','SDS.LYS ','8','236','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('112122','山东省.枣庄市 ','SDS.ZZS ','8','237','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113','浙江省','ZJS','8','238','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113100','浙江省.杭州市 ','ZJS.HZS ','8','239','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113101','浙江省.下城区','ZJS.XCQ','8','240','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113102','浙江省.江干区','ZJS.JGQ','8','241','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113103','浙江省.绍兴市 ','ZJS.SXS ','8','242','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113104','浙江省.嘉兴市 ','ZJS.JXS ','8','243','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113105','浙江省.宁波市 ','ZJS.NBS ','8','244','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113106','浙江省.舟山市 ','ZJS.ZSS ','8','245','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113107','浙江省.椒江市 ','ZJS.JJS ','8','246','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113108','浙江省.兰溪市 ','ZJS.LXS ','8','247','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113109','浙江省.衙州市 ','ZJS.YZS ','8','248','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113110','浙江省.温州市 ','ZJS.WZS ','8','249','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113111','浙江省.东阳市 ','ZJS.DYS ','8','250','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113112','浙江省.乐清市','ZJS.LQS','8','251','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113113','浙江省.上城区','ZJS.SCQ','8','252','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113114','浙江省.西湖区','ZJS.XHQ','8','253','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113115','浙江省.萧山市 ','ZJS.XSS ','8','254','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113116','浙江省.湖州市 ','ZJS.HZS ','8','255','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113117','浙江省.海宁市 ','ZJS.HNS ','8','256','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113118','浙江省.余姚市 ','ZJS.YYS ','8','257','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113119','浙江省.临海市 ','ZJS.LHS ','8','258','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113120','浙江省.金华市 ','ZJS.JHS ','8','259','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113121','浙江省.丽水市 ','ZJS.LSS ','8','260','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113122','浙江省.江山市 ','ZJS.JSS ','8','261','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113123','浙江省.义乌市 ','ZJS.YWS ','8','262','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113124','浙江省.瑞安市 ','ZJS.RAS ','8','263','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('113125','浙江省.台州市','ZJS.TZS','8','264','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114','江西省','JXS','8','265','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114100','江西省.南昌市','JXS.NCS','8','266','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114101','江西省.景德镇市','JXS.JDZS','8','267','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114102','江西省.鹰潭市','JXS.YTS','8','268','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114103','江西省.新余市','JXS.XYS','8','269','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114104','江西省.赣州市','JXS.GZS','8','270','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114105','江西省.井冈山市','JXS.JGSS','8','271','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114106','江西省.临川市','JXS.LCS','8','272','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114107','江西省.九江市','JXS.JJS','8','273','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114108','江西省.上饶市','JXS.SRS','8','274','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114109','江西省.宜春市','JXS.YCS','8','275','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114110','江西省.萍乡市','JXS.PXS','8','276','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114111','江西省.吉安市','JXS.JAS','8','277','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('114112','江西省.抚州市','JXS.FZS','8','278','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115','福建省','FJS','8','279','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115100','福建省.福州市','FJS.FZS','8','280','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115101','福建省.南平市','FJS.NPS','8','281','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115102','福建省.厦门市','FJS.XMS','8','282','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115103','福建省.石狮市','FJS.SSS','8','283','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115104','福建省.龙岩市','FJS.LYS','8','284','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115105','福建省.永安市','FJS.YAS','8','285','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115106','福建省.莆田市','FJS.PTS','8','286','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115107','福建省.邵武市','FJS.SWS','8','287','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115108','福建省.泉州市','FJS.QZS','8','288','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115109','福建省.漳州市','FJS.ZZS','8','289','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115110','福建省.三明市','FJS.SMS','8','290','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('115111','福建省.宁德市','FJS.NDS','8','291','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116','湖南省','HNS','8','292','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116100','湖南省.长沙市','HNS.CSS','8','293','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116101','湖南省.湘乡市','HNS.XXS','8','294','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116102','湖南省.益阳市','HNS.YYS','8','295','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116103','湖南省.汨罗市','HNS.ZLS','8','296','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116104','湖南省.津市市','HNS.JSS','8','297','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116105','湖南省.大庸市','HNS.DYS','8','298','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116106','湖南省.连源市','HNS.LYS','8','299','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116107','湖南省.怀化市','HNS.HHS','8','300','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116108','湖南省.衡阳市','HNS.HYS','8','301','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116109','湖南省.邵阳市','HNS.SYS','8','302','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116110','湖南省.永州市','HNS.YZS','8','303','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116111','湖南省.张家界市','HNS.ZJJS','8','304','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116112','湖南省.湘潭市','HNS.XTS','8','305','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116113','湖南省.株洲市','HNS.ZZS','8','306','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116114','湖南省.岳阳市','HNS.YYS','8','307','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116115','湖南省.常德市','HNS.CDS','8','308','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116116','湖南省.吉首市','HNS.JSS','8','309','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116117','湖南省.娄底市','HNS.LDS','8','310','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116118','湖南省.冷水江市','HNS.LSJS','8','311','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116119','湖南省.洪江市','HNS.HJS','8','312','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116120','湖南省.来阳市','HNS.LYS','8','313','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116121','湖南省.彬州市','HNS.BZS','8','314','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116122','湖南省.冷水滩市','HNS.LSTS','8','315','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('116123','湖南省.湘西土家族苗族自治州','HNS.XXTJZMZZZZ','8','316','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117','湖北省','HBS','8','317','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117100','湖北省.武汉市','HBS.WHS','8','318','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117101','湖北省.天门市','HBS.TMS','8','319','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117102','湖北省.应城市','HBS.YCS','8','320','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117103','湖北省.应城市','HBS.YCS','8','321','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117104','湖北省.应城市','HBS.YCS','8','322','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117105','湖北省.应城市','HBS.YCS','8','323','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117106','湖北省.应城市','HBS.YCS','8','324','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117107','湖北省.咸宁市','HBS.XNS','8','325','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117108','湖北省.蒲昕市','HBS.PZS','8','326','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117109','湖北省.咸宁市','HBS.XNS','8','327','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117110','湖北省.咸宁市','HBS.XNS','8','328','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117111','湖北省.咸宁市','HBS.XNS','8','329','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117112','湖北省.利川市','HBS.LCS','8','330','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117113','湖北省.利川市','HBS.LCS','8','331','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117114','湖北省.利川市','HBS.LCS','8','332','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117115','湖北省.孝感市','HBS.XGS','8','333','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117116','湖北省.安陆市','HBS.ALS','8','334','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117117','湖北省.洪湖市','HBS.HHS','8','335','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117118','湖北省.石首市','HBS.SSS','8','336','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117119','湖北省.黄石市','HBS.HSS','8','337','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117120','湖北省.武穴市','HBS.W穴S','8','338','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117121','湖北省.襄樊市','HBS.XFS','8','339','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117122','湖北省.随州市','HBS.SZS','8','340','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117123','湖北省.丹江口市','HBS.DJKS','8','341','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117124','湖北省.宜昌市','HBS.YCS','8','342','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117125','湖北省.恩施土家族苗族自治州','HBS.ESTJZMZZZZ','8','343','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('117126','湖北省.利川市','HBS.LCS','8','344','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118','河南省','HNS','8','345','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118100','河南省.郑州市','HNS.ZZS','8','346','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118101','河南省.焦作市','HNS.JZS','8','347','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118102','河南省.鹤壁市','HNS.HBS','8','348','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118103','河南省.许昌市','HNS.XCS','8','349','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118104','河南省.驻马店市','HNS.ZMDS','8','350','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118105','河南省.周口市','HNS.ZKS','8','351','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118106','河南省.洛阳市','HNS.LYS','8','352','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118107','河南省.义马市','HNS.YMS','8','353','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118108','河南省.开封市','HNS.KFS','8','354','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118109','河南省.新乡市','HNS.XXS','8','355','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118110','河南省.安阳市','HNS.AYS','8','356','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118111','河南省.濮阳市','HNS.ZYS','8','357','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118112','河南省.缧河市','HNS.ZHS','8','358','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118113','河南省.信阳市','HNS.XYS','8','359','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118114','河南省.平顶山市','HNS.PDSS','8','360','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118115','河南省.三门峡市','HNS.SMXS','8','361','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118116','河南省.南阳市','HNS.NYS','8','362','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('118117','河南省.商丘市','HNS.SQS','8','363','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119','广东省','GDS','8','364','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119100','广东省.广州市','GDS.GZS','8','365','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119101','广东省.东莞市','GDS.DZS','8','366','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119102','广东省.梅州市','GDS.MZS','8','367','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119103','广东省.潮州市','GDS.CZS','8','368','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119104','广东省.汕尾市','GDS.SWS','8','369','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119105','广东省.深圳市','GDS.SZS','8','370','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119106','广东省.茂名市','GDS.MMS','8','371','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119107','广东省.佛山市','GDS.FSS','8','372','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119108','广东省.江门市','GDS.JMS','8','373','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119109','广东省.珠海市','GDS.ZHS','8','374','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119110','广东省.云浮市','GDS.YFS','8','375','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119111','广东省.清远市','GDS.QYS','8','376','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119112','广东省.韶关市','GDS.SGS','8','377','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119113','广东省.汕头市','GDS.STS','8','378','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119114','广东省.惠州市','GDS.HZS','8','379','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119115','广东省.河源市','GDS.HYS','8','380','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119116','广东省.湛江市','GDS.ZJS','8','381','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119117','广东省.肇庆市','GDS.ZQS','8','382','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119118','广东省.中山市','GDS.ZSS','8','383','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119119','广东省.阳江市','GDS.YJS','8','384','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('119120','广东省.揭阳市','GDS.JYS','8','385','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120','海南省','HNS','8','386','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120100','海南省.海口市','HNS.HKS','8','387','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120101','海南省.通什市','HNS.TSS','8','388','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120102','海南省.三亚市','HNS.SYS','8','389','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('120103','海南省.海南省','HNS.HNS','8','390','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121','广西壮族自治区','GXZZZZQ','8','391','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121100','广西.南宁市','GX.NNS','8','392','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121101','广西.百色市','GX.BSS','8','393','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121102','广西.北海市','GX.BHS','8','394','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121103','广西.桂林市','GX.GLS','8','395','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121104','广西.柳州市','GX.LZS','8','396','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121105','广西.河池市','GX.HCS','8','397','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121106','广西.贵港市','GX.GGS','8','398','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121107','广西.凭祥市','GX.PXS','8','399','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121108','广西.钦州市','GX.QZS','8','400','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121109','广西.玉林市','GX.YLS','8','401','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121110','广西.梧州市','GX.WZS','8','402','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121111','广西.台山市','GX.TSS','8','403','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121112','广西.防城港市','GX.FCGS','8','404','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('121113','广西.贺州市','GX.HZS','8','405','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122','贵州省','GZS','8','406','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122100','贵州省.贵阳市','GZS.GYS','8','407','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122101','贵州省.铜仁市','GZS.TRS','8','408','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122102','贵州省.都匀市','GZS.DYS','8','409','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122103','贵州省.兴义市','GZS.XYS','8','410','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122104','贵州省.赤水市','GZS.CSS','8','411','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122105','贵州省.六盘水市','GZS.LPSS','8','412','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122106','贵州省.凯里市','GZS.KLS','8','413','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122107','贵州省.安顺市','GZS.ASS','8','414','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122108','贵州省.遵义市','GZS.ZYS','8','415','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122109','贵州省.毕节地区','GZS.BJDQ','8','416','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122110','贵州省.黔东南苗族侗族自治州','GZS.QDNMZDZZZZ','8','417','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122111','贵州省.黔西南布依族苗族自治州 ','GZS.QXNBYZMZZZZ ','8','418','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('122112','贵州省.黔南布依族苗族自治州','GZS.QNBYZMZZZZ','8','419','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123','四川省','SCS','8','420','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123100','四川省.成都市','SCS.CDS','8','421','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123101','四川省.温江县','SCS.WJX','8','422','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123102','四川省.都江堰市','SCS.DJYS','8','423','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123103','四川省.攀枝花市','SCS.PZHS','8','424','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123104','四川省.自贡市','SCS.ZGS','8','425','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123105','四川省.绵阳市','SCS.MYS','8','426','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123106','四川省.南充市','SCS.NCS','8','427','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123107','四川省.达州市','SCS.DZS','8','428','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123108','四川省.遂宁市','SCS.SNS','8','429','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123109','四川省.广安市','SCS.GAS','8','430','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123110','四川省.巴中市','SCS.BZS','8','431','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123111','四川省.泸州市','SCS.ZZS','8','432','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123112','四川省.宜宾市','SCS.YBS','8','433','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123113','四川省.内江市','SCS.NJS','8','434','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123114','四川省.资阳市','SCS.ZYS','8','435','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123115','四川省.乐山市','SCS.LSS','8','436','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123116','四川省.眉山市','SCS.MSS','8','437','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123117','四川省.凉山彝族自治州','SCS.LSYZZZZ','8','438','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123118','四川省.雅安市','SCS.YAS','8','439','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123119','四川省.甘孜藏族自治州','SCS.GZCZZZZ','8','440','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123120','四川省.阿坝藏族羌族自治州','SCS.ABCZQZZZZ','8','441','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123121','四川省.德阳市','SCS.DYS','8','442','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('123122','四川省.广元市','SCS.GYS','8','443','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124','云南省','YNS','8','444','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124100','云南省.西双版纳傣族自治州','YNS.XSBNDZZZZ','8','445','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124101','云南省.德宏傣族景颇族自治州','YNS.DHDZJPZZZZ','8','446','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124102','云南省.昭通市','YNS.ZTS','8','447','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124103','云南省.昆明市','YNS.KMS','8','448','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124104','云南省.大理市','YNS.DLS','8','449','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124105','云南省.大理白族自治州','YNS.DLBZZZZ','8','450','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124106','云南省.红河哈尼族彝族自治州','YNS.HHHNZYZZZZ','8','451','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124107','云南省.个旧市','YNS.GJS','8','452','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124108','云南省.曲靖市','YNS.QJS','8','453','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124109','云南省.保山市','YNS.BSS','8','454','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124110','云南省.文山壮族苗族自治州','YNS.WSZZMZZZZ','8','455','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124111','云南省.玉溪市','YNS.YXS','8','456','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124112','云南省.楚雄彝族自治州','YNS.CXYZZZZ','8','457','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124113','云南省.思茅地区','YNS.SMDQ','8','458','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124114','云南省.临沧地区','YNS.LCDQ','8','459','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124115','云南省.怒江傈僳族自治州','YNS.NJLSZZZZ','8','460','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124116','云南省.迪庆藏族自治州','YNS.DQCZZZZ','8','461','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124117','云南省.丽江地区','YNS.LJDQ','8','462','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124118','云南省.东川市','YNS.DCS','8','463','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('124119','云南省.开远市','YNS.KYS','8','464','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125','陕西省','SXS','8','465','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125100','陕西省.西安市','SXS.XAS','8','466','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125101','陕西省.咸阳市','SXS.XYS','8','467','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125102','陕西省.延安市','SXS.YAS','8','468','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125103','陕西省.榆林市','SXS.YLS','8','469','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125104','陕西省.渭南市','SXS.WNS','8','470','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125105','陕西省.商洛市','SXS.SLS','8','471','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125106','陕西省.安康市','SXS.AKS','8','472','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125107','陕西省.汉中市','SXS.HZS','8','473','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125108','陕西省.宝鸡市','SXS.BJS','8','474','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125109','陕西省.铜川市','SXS.TCS','8','475','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('125110','陕西省.韩城市','SXS.HCS','8','476','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126','甘肃省','GSS','8','477','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126100','甘肃省.兰州市','GSS.LZS','8','478','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126101','甘肃省.临夏回族自治州','GSS.LXHZZZZ','8','479','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126102','甘肃省.定西地区','GSS.DXDQ','8','480','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126103','甘肃省.平凉市','GSS.PLS','8','481','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126104','甘肃省.庆阳市','GSS.QYS','8','482','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126105','甘肃省.西峰市','GSS.XFS','8','483','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126106','甘肃省.武威市','GSS.WWS','8','484','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126107','甘肃省.张掖市','GSS.ZYS','8','485','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126108','甘肃省.嘉峪关市','GSS.JYGS','8','486','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126109','甘肃省.金昌市','GSS.JCS','8','487','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126110','甘肃省.酒泉市','GSS.JQS','8','488','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126111','甘肃省.天水市','GSS.TSS','8','489','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126112','甘肃省.陇南地区','GSS.LNDQ','8','490','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126113','甘肃省.甘南藏族自治州','GSS.GNCZZZZ','8','491','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126114','甘肃省.白银市','GSS.BYS','8','492','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('126115','甘肃省.玉门市','GSS.YMS','8','493','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127','宁夏回族自治区','NXHZZZQ','8','494','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127100','宁夏.银川市','NX.YCS','8','495','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127101','宁夏.石嘴山市','NX.SZSS','8','496','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127102','宁夏.青铜峡市','NX.QTXS','8','497','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127103','宁夏.吴忠市','NX.WZS','8','498','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('127104','宁夏.固原市','NX.GYS','8','499','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128','青海省','QHS','8','500','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128100','青海省.西宁市','QHS.XNS','8','501','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128101','青海省.海北藏族自治州','QHS.HBCZZZZ','8','502','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128102','青海省.海东地区','QHS.HDDQ','8','503','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128103','青海省.黄南藏族自治州','QHS.HNCZZZZ','8','504','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128104','青海省.海南藏族自治州','QHS.HNCZZZZ','8','505','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128105','青海省.果洛藏族自治州','QHS.GLCZZZZ','8','506','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128106','青海省.玉树藏族自治州','QHS.YSCZZZZ','8','507','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128107','青海省.德令哈市','QHS.DLHS','8','508','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128108','青海省.海西蒙古族藏族自治州','QHS.HXMGZCZZZZ','8','509','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('128109','青海省.格尔木市','QHS.GEMS','8','510','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129','新疆维吾尔自治区','XJWWEZZQ','8','511','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129100','新疆.乌鲁木齐市','XJ.WLMQS','8','512','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129101','新疆.塔城地区','XJ.TCDQ','8','513','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129102','新疆.哈密地区','XJ.HMDQ','8','514','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129103','新疆.和田地区','XJ.HTDQ','8','515','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129104','新疆.阿勒泰地区','XJ.ALTDQ','8','516','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129105','新疆.克孜勒苏柯尔克孜自治州','XJ.KZLSKEKZZZZ','8','517','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129106','新疆.博乐塔拉蒙古族自治州','XJ.BLTLMGZZZZ','8','518','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129107','新疆.克拉玛依市','XJ.KLMYS','8','519','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129108','新疆.伊犁哈萨克自治州','XJ.YLHSKZZZ','8','520','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129109','新疆.奎屯市','XJ.KTS','8','521','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129110','新疆.石河子市','XJ.SHZS','8','522','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129111','新疆.昌吉回族自治州','XJ.CJHZZZZ','8','523','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129112','新疆.吐鲁番市','XJ.TLFS','8','524','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129113','新疆.巴音郭楞蒙古自治州','XJ.BYGLMGZZZ','8','525','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129114','新疆.库尔勒市','XJ.KELS','8','526','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129115','新疆.阿克苏地区','XJ.AKSDQ','8','527','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129116','新疆.喀什地区','XJ.KSDQ','8','528','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129117','新疆.伊宁市','XJ.YNS','8','529','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('129118','新疆.阿图什市','XJ.ATSS','8','530','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130','西藏自治区','XCZZQ','8','531','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130100','西藏.拉萨市','XC.LSS','8','532','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130101','西藏.日喀则地区','XC.RKZDQ','8','533','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130102','西藏.山南地区','XC.SNDQ','8','534','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130103','西藏.林芝地区','XC.LZDQ','8','535','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130104','西藏.昌都地区','XC.CDDQ','8','536','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130105','西藏.那曲地区','XC.NQDQ','8','537','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('130106','西藏.阿里地区','XC.ALDQ','8','538','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131','台湾省','TWS','8','539','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131100','台湾省.基隆','TWS.JL','8','540','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131101','台湾省.台北','TWS.TB','8','541','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131102','台湾省.台中','TWS.TZ','8','542','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131103','台湾省.台南','TWS.TN','8','543','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131104','台湾省.高雄','TWS.GX','8','544','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('131105','台湾省.台东','TWS.TD','8','545','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('132','香港特别行政区','XGTBXZQ','8','546','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_CODE_INFO(code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp) values('133','澳门特别行政区','AMTBXZQ','8','547','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--产品信息表
CREATE TABLE [PUB_PROD_INFO](
    --产品编号
	[PROD_ID] varchar(10) NOT NULL,
    --产品名称
	[PROD_NAME] [varchar](50) NOT NULL,
    --产品简称
	[PROD_SHORT_NAME] [varchar](20) NOT NULL,
    --产品版本号 大版本5.0
	[VERSION] [varchar](10) NOT NULL,
    --行业类型 MKT 超市<食杂店> FIG 服装 DLI 食品 OHR 通用 
	[INDUSTRY] [varchar](3) NOT NULL,
    --产品类型 LCL单机版 NET连锁版  
	[PROD_FLAG] [varchar](3) NOT NULL,
    --开发日期
	[DEVE_DATE] [varchar](10) NULL,
    --最近发布日期
	[ISSUE_DATE] [varchar](10) NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_PROD_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([PROD_ID])
);

--行业类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('MKT','超市<食杂店>','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('FIG','服装','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('DLI','食品','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('OHR','通用','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--产品类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('LCL','单机版','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('NET','连锁版','INDUSTRY','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
--初始化软件产品
 insert into PUB_PROD_INFO(PROD_ID,PROD_NAME,PROD_SHORT_NAME,VERSION,INDUSTRY,PROD_FLAG,DEVE_DATE,ISSUE_DATE,COMM,TIME_STAMP) values('R3-RYC','R3门店管理软件-烟草零售终端','R3-RYC','3.0','MKT','LCL','2011-01-01','2011-04-01','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
 
--版本控制表
CREATE TABLE [PUB_VERSION_INFO](
    --控制编号
	[VERSION_ID] int NOT NULL,
    --产品编号
	[PROD_ID] varchar(10) NOT NULL,
    --当前版本号 5.0.0.93
	[VERSION] [varchar](11) NOT NULL,
    --对应服务机组
	[SRVR_ID] [varchar](10) NOT NULL,
    --升级类型 1可选升级 2强制升级
	[UPGRADE_FLAG] int NOT NULL,
    --升级范围 1所有企业 2指定企业做试点投放
	[UPGRADE_RANGE] int NOT NULL,
    --升级包下载地址 带文件名 
	[URL] [varchar](255) NOT NULL,
    --发布日期
	[ISSUE_DATE] [varchar](10) NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_VERSION_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([VERSION_ID])
);

--升级范围
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','所有企业','UPGRADE_RANGE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','指定企业做试点投放','UPGRADE_RANGE','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));
--升级类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','可选升级','UPGRADE_FLAG','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','强制升级','UPGRADE_FLAG','00',convert(bigint,(convert(float,getdate())-40542.0)*86400));

--升级企业
CREATE TABLE [PUB_UPGRADE_RANGE](
    --控制编号
	[VERSION_ID] int NOT NULL,
    --企业编号
	[TENANT_ID] int NOT NULL,
    --通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
	[COMM] [varchar](2) NOT NULL CONSTRAINT [DF_PUB_VERSION_INFO_COMM] DEFAULT ('00'),
    --更新时间 重2011-01-01开始的秒数  
	[TIME_STAMP] [bigint] NOT NULL,
PRIMARY KEY([VERSION_ID])
);

