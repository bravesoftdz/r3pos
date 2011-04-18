--部门类型
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('1','营销部','DEPT_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('2','财务部','DEPT_TYPE','00',5497000);
 insert into PUB_PARAMS(CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP) values('3','管理部','DEPT_TYPE','00',5497000);
--发货仓库(默认)
alter table CA_DEPT_INFO add SHOP_ID varchar(13);
--部门类型
alter table CA_DEPT_INFO add DEPT_TYPE char(1);
--历史数据默认成（营销部）
update CA_DEPT_INFO set DEPT_TYPE='1';
--{idbType=5}
update CA_DEPT_INFO set SHOP_ID=cast(TENANT_ID as varchar)||'0001';
--{idbType=4}
update CA_DEPT_INFO set SHOP_ID=trim(char(TENANT_ID))||'0001';
--{idbType=0}
update CA_DEPT_INFO set SHOP_ID=convert(varchar,TENANT_ID)||'0001';

--添加营销部门
alter table STK_STOCKORDER add DEPT_ID varchar(12);
alter table STK_INDENTORDER add DEPT_ID varchar(12);
alter table SAL_SALESORDER add DEPT_ID varchar(12);
alter table SAL_INDENTORDER add DEPT_ID varchar(12);

--{idbType=5}
update STK_STOCKORDER set DEPT_ID=cast(TENANT_ID as varchar)||'001';
--{idbType=5}
update STK_INDENTORDER set DEPT_ID=cast(TENANT_ID as varchar)||'001';
--{idbType=5}
update SAL_SALESORDER set DEPT_ID=cast(TENANT_ID as varchar)||'001';
--{idbType=5}
update SAL_INDENTORDER set DEPT_ID=cast(TENANT_ID as varchar)||'001';

--{idbType=4}
update STK_STOCKORDER set DEPT_ID=trim(char(TENANT_ID))||'001';
--{idbType=4}
update STK_INDENTORDER set DEPT_ID=trim(char(TENANT_ID))||'001';
--{idbType=4}
update SAL_SALESORDER set DEPT_ID=trim(char(TENANT_ID))||'001';
--{idbType=4}
update SAL_INDENTORDER set DEPT_ID=trim(char(TENANT_ID))||'001';

--{idbType=0}
update STK_STOCKORDER set DEPT_ID=convert(varchar,TENANT_ID)||'001';
--{idbType=0}
update STK_INDENTORDER set DEPT_ID=convert(varchar,TENANT_ID)||'001';
--{idbType=0}
update SAL_SALESORDER set DEPT_ID=convert(varchar,TENANT_ID)||'001';
--{idbType=0}
update SAL_INDENTORDER set DEPT_ID=convert(varchar,TENANT_ID)||'001';

--{idbType=5}
drop view VIW_USERS;
--{idbType=5}
create view [VIW_USERS]
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,QQ,MM,MSN,PASS_WRD,DEPT_ID,COMM from CA_USERS
union all
select TENANT_ID,cast(TENANT_ID*10000+1 as varchar(13)) as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLES_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,cast(TENANT_ID*1000+1 as varchar(12)) as DEPT_ID, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,cast(B.TENANT_ID*10000+1 as varchar(11)) as SHOP_ID,'system' as USER_ID,'system' as ACCOUNT,'系统用户' as USER_NAME,'xtyf' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLES_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,cast(B.TENANT_ID*1000+1 as varchar(12)) as DEPT_ID, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--{idbType=0}
alter view [VIW_USERS]
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,QQ,MM,MSN,PASS_WRD,DEPT_ID,COMM from CA_USERS
union all
select TENANT_ID,convert(varchar,TENANT_ID)+'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLES_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,convert(varchar,TENANT_ID)+'001' as DEPT_ID, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,convert(varchar,B.TENANT_ID)+'0001' as SHOP_ID,'system' as USER_ID,'system' as ACCOUNT,'系统用户' as USER_NAME,'xtyf' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLES_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,convert(varchar,B.TENANT_ID)+'001' as DEPT_ID, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0

--{idbType=4}
drop view VIW_USERS;
--{idbType=4}
CREATE view VIW_USERS
as
select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,ROLE_IDS,QQ,MM,MSN,PASS_WRD,DEPT_ID,COMM from CA_USERS
union all
select TENANT_ID,trim(char(TENANT_ID))||'0001' as SHOP_ID,'admin' as USER_ID,'admin' as ACCOUNT,'管理员' as USER_NAME,'gly' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,trim(char(TENANT_ID))||'001' as DEPT_ID, '00' as COMM from SYS_DEFINE where DEFINE='PASSWRD' and TENANT_ID<>0
union all
select B.TENANT_ID,trim(char(B.TENANT_ID))||'0001' as SHOP_ID,'system' as USER_ID,'system' as ACCOUNT,'系统用户' as USER_NAME,'xtyf' as USER_SPELL,'#' as DUTY_IDS,'#' as ROLE_IDS,'' as QQ,'' as MM,'' as MSN,
VALUE as PASS_WRD,trim(char(B.TENANT_ID))||'001' as DEPT_ID, '00' as COMM from SYS_DEFINE A,CA_TENANT B where DEFINE='PASSWRD' and A.TENANT_ID=0;

--扫码出库
CREATE TABLE SAL_LOCUS_FORSALE(
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (13) NOT NULL ,
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
        --扫码日期
	LOCUS_DATE int NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --数量
	AMOUNT decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,

        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_SAL_LS_FORSALE PRIMARY KEY  
	(
		TENANT_ID,
		SALES_ID,
		SEQNO
	)
);

--扫码出库<领用，损益等的出库>
CREATE TABLE STO_LOCUS_FORCHAG(
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (13) NOT NULL ,
        --调整单号
	CHANGE_ID char (36) NOT NULL ,
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
        --扫码日期
	LOCUS_DATE int NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --数量
	AMOUNT decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,

        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_STO_LS_FORCHAG PRIMARY KEY  
	(
		TENANT_ID,
		CHANGE_ID,
		SEQNO
	)
);


--扫码入库
CREATE TABLE STK_LOCUS_FORSTCK(
        --企业代码
	TENANT_ID int NOT NULL ,
        --门店代码
	SHOP_ID varchar (13) NOT NULL ,
        --销售单号
	STOCK_ID char (36) NOT NULL ,
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
        --扫码日期
	LOCUS_DATE int NOT NULL ,
        --物流跟踪号
	LOCUS_NO varchar (36) NOT NULL ,
        --单位
	UNIT_ID varchar (36) NOT NULL ,
        --数量
	AMOUNT decimal(18, 3) ,
        --计量单位数据
	CALC_AMOUNT decimal(18, 3) ,

        --操作时间
	CREA_DATE varchar (30) ,
        --操作人员
	CREA_USER varchar (36) ,
        --通讯标志
	COMM varchar (2) NOT NULL DEFAULT '00',
        --时间戳 当前系统日期*86400000
  TIME_STAMP bigint NOT NULL,
	
	CONSTRAINT PK_STK_LS_FORSTCK PRIMARY KEY  
	(
		TENANT_ID,
		STOCK_ID,
		SEQNO
	)
);


--为此视图加了GODS_TYPE
drop view VIW_GOODSPRICEEXT;
CREATE view [VIW_GOODSPRICEEXT]
as
    SELECT 
      j1.TENANT_ID as TENANT_ID,j1.SHOP_ID,j1.RELATION_ID, 
      j1.GODS_ID as GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,j1.GODS_TYPE,GODS_NAME,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE else J2.NEW_INPRICE end as NEW_INPRICE,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.SMALLTO_CALC else J2.NEW_INPRICE1 end as NEW_INPRICE1,
       case when J2.NEW_INPRICE is null then J1.NEW_INPRICE*J1.BIGTO_CALC else J2.NEW_INPRICE2 end as NEW_INPRICE2,
       NEW_OUTPRICE,
       NEW_OUTPRICE1,
       NEW_OUTPRICE2,
       NEW_LOWPRICE,
       J1.RTL_OUTPRICE as RTL_OUTPRICE,
       SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,
       SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,
       SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,
       USING_BARTER,BARTER_INTEGRAL,
       USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,REMARK,j1.COMM as COMM,j1.TIME_STAMP as TIME_STAMP
    FROM 
      VIW_GOODSPRICE j1 LEFT JOIN 
      PUB_GOODSINFOEXT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.GODS_ID = j2.GODS_ID; 
            
--要重建有应用到VIW_GOODSPRICEEXT的视图
drop view VIW_GOODSPRICE_SORTEXT;
CREATE view [VIW_GOODSPRICE_SORTEXT]
as
    SELECT 
      j1.*,j2.LEVEL_ID,j2.SORT_NAME
    FROM 
      VIW_GOODSPRICEEXT j1 LEFT JOIN 
      VIW_GOODSSORT j2 ON j1.TENANT_ID = j2.TENANT_ID AND j1.SORT_ID1 = j2.SORT_ID and j1.RELATION_ID=j2.RELATION_ID; 
      
