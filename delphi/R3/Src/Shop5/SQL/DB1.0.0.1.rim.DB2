--RIM系统DB2版：

--关于NICKNAME后可以直接访问到远程对象表，创建视图是为了以后数据库优化、物化视图做好准备;
--使用环境：Window平台 
--创建前(创建中出错时)，请详细阅读[DB2联邦(DB2使用联邦功能链接DB2).doc(url:http://loveseaside.iteye.com/blog/663110)]
--创建前的准备工作：
--(1)RIMDB库与DB_R3库不在同一机器上，请先设置RIMDB远程机器的在本地的编目（catalog)，;
--  A、局域网内可以通过DB2的控制中心(〖所有系统〗==>〖添加系统〗);
--  B、广域网、局域网均可通过设置ODBC配置;
--  C、也可以通过DB2命令配置;

--DB_R3使用联邦功能链接RIMDB创建过程：(根据实际情况替换参数) 
--参数说明：(1)固定参数：A、安装包名称：DRDA; B、远程服务器名: RIMLINK)
--          (2)RIM库：   A、库名：RIMDB;      B、登录名：RIM_loginname   C、登陆密码：RIM_Password; 
--          (3)DB_R3库： A、库名：DB_R3;      B、登陆名：R3_loginname    C、登陆密码：R3_Password; 


--//////////////////////////////// 【 第一步：  先创建RIMLINK   】  ////////////////////////////////////
------------以下语句在【DB2控制中心】用【管理员用户】登陆【DB_R3】,在【命令编辑器】中运行------------------------------------------------------------
--1、创建前准备配置参数(以下语句请一条一条运行)： 
UPDATE DBM CFG USING FEDERATED YES;  --执行后需要执行重启实例才生效; 
DB2STOP FORCE;
DB2START;
CONNECT TO DB_R3 USER R3_loginname USING R3_Password;
--2、创建安装包：(若存在先删除：DROP WRAPPER DRDA)
CREATE WRAPPER DRDA LIBRARY 'db2drda.dll' OPTIONS (ADD DB2_FENCED 'N');
--3、创建服务器定义：
CREATE SERVER RIMLINK TYPE DB2/UDB VERSION '9.1' WRAPPER DRDA AUTHID "RIM_loginname" PASSWORD "RIM_Password" OPTIONS(ADD DBNAME 'RIMDB');
--4、创建用户映射：
CREATE USER MAPPING FOR R3_loginname SERVER RIMLINK OPTIONS (ADD REMOTE_AUTHID 'RIM_loginname', ADD REMOTE_PASSWORD 'RIM_Password');
 
 
--//////////////////////////////// 【 第二步： 创建Rim的同义词[SYNONYM]  】  //////////////////////////////////// 
--2011.04.07 PM：创建RIM烟草公司表(PUB_ORGAN)：
CREATE NICKNAME PUB_ORGAN FOR RIMLINK.DB2ADMIN.PUB_ORGAN; 
--2011.04.11 PM：下载订单创建远程链接表：
CREATE NICKNAME RM_CUST FOR  RIMLINK.DB2ADMIN.RM_CUST;       --创建RM_CUST(零售户)的NICKNAME: 
CREATE NICKNAME SD_CO FOR  RIMLINK.DB2ADMIN.SD_CO;           --创建SD_CO(订单主表)的NICKNAME: 
CREATE NICKNAME SD_CO_LINE FOR  RIMLINK.DB2ADMIN.SD_CO_LINE; --创建SD_CO_LINE(订单明细)的NICKNAME: 

--2011.04.14 PM添加同步单据最大时间戳:RIM_R3_NUM,月台账映射NICKNAME：
CREATE NICKNAME RIM_R3_NUM FOR  RIMLINK.DB2ADMIN.RIM_R3_NUM;                   
CREATE NICKNAME RIM_BAL_LOG FOR  RIMLINK.DB2ADMIN.RIM_BAL_LOG; 
CREATE NICKNAME RIM_CUST_MONTH FOR  RIMLINK.DB2ADMIN.RIM_CUST_MONTH; 
        
--2011.04.14 PM日台账:(RIM_CUST_MONTH、RIM_RETAIL_CO_LINE)映射NICKNAME：
CREATE NICKNAME RIM_RETAIL_CO FOR  RIMLINK.DB2ADMIN.RIM_RETAIL_CO;   
CREATE NICKNAME RIM_RETAIL_CO_LINE FOR  RIMLINK.DB2ADMIN.RIM_RETAIL_CO_LINE;  

--2011.04.15 AM添加零售户每天库、零售最新库存(RIM_CUST_ITEM_SWHSE、RIM_CUST_ITEM_WHSE)映射NICKNAME：
CREATE NICKNAME RIM_CUST_ITEM_SWHSE FOR  RIMLINK.DB2ADMIN.RIM_CUST_ITEM_SWHSE;    
CREATE NICKNAME RIM_CUST_ITEM_WHSE FOR  RIMLINK.DB2ADMIN.RIM_CUST_ITEM_WHSE;      

--2011.04.15 PM添加销售单(RIM_RETAIL_INFO、RIM_RETAIL_DETAIL)映射NICKNAME：
CREATE NICKNAME RIM_RETAIL_INFO FOR  RIMLINK.DB2ADMIN.RIM_RETAIL_INFO;       
CREATE NICKNAME RIM_RETAIL_DETAIL FOR  RIMLINK.DB2ADMIN.RIM_RETAIL_DETAIL;   

--2011.04.18 AM添加调拨单(RIM_CUST_TRN、RIM_CUST_TRN_LINE)映射NICKNAME：
CREATE NICKNAME RIM_CUST_TRN FOR  RIMLINK.DB2ADMIN.RIM_CUST_TRN;           
CREATE NICKNAME RIM_CUST_TRN_LINE FOR  RIMLINK.DB2ADMIN.RIM_CUST_TRN_LINE;  

--2011.04.18 PM添加入库单(RIM_VOUCHER、RIM_VOUCHER_LINE)映射NICKNAME：
CREATE NICKNAME RIM_VOUCHER FOR  RIMLINK.DB2ADMIN.RIM_VOUCHER;            
CREATE NICKNAME RIM_VOUCHER_LINE FOR  RIMLINK.DB2ADMIN.RIM_VOUCHER_LINE; 

--2011.04.18 PM添加调整单(RIM_ADJUST_INFO、RIM_ADJUST_DETAIL)映射NICKNAME：  
CREATE NICKNAME RIM_ADJUST_INFO FOR  RIMLINK.DB2ADMIN.RIM_ADJUST_INFO;            
CREATE NICKNAME RIM_ADJUST_DETAIL FOR  RIMLINK.DB2ADMIN.RIM_ADJUST_DETAIL; 
 
--2011.05.26 PM添加会员同步的映射：
CREATE NICKNAME RIM_VIP_CONSUMER FOR RIMLINK.DB2ADMIN.RIM_VIP_CONSUMER; 

--2011.05.31 PM 创建问卷调查SYNONYM：
CREATE NICKNAME CC_INVESTIGATE FOR RIMLINK.DB2ADMIN.CC_INVESTIGATE;
--2011.05.31 PM 创建问卷表SYNONYM:
CREATE NICKNAME CC_VOLUME FOR RIMLINK.DB2ADMIN.CC_VOLUME;
--2011.05.31 PM 问卷题目表:
CREATE NICKNAME CC_INVEST_ITEM FOR RIMLINK.DB2ADMIN.CC_INVEST_ITEM;
--2011.05.31 PM 题目选项表:
CREATE NICKNAME CC_INVEST_OPTION FOR RIMLINK.DB2ADMIN.CC_INVEST_OPTION;
--2011.05.31 PM 我的调查表:
CREATE NICKNAME CC_MYINVESTIGATE FOR RIMLINK.DB2ADMIN.CC_MYINVESTIGATE;
--2011.05.31 PM 我的调查行表:
CREATE NICKNAME CC_MYINVEST_SUBJECT FOR RIMLINK.DB2ADMIN.CC_MYINVEST_SUBJECT;



--//////////////////////////////// 【 第三步： 创建对接用到Rim视图和中间表 】   ////////////////////////////////////
--2011.05.27 Add 修改RIM系统的字段：
--1、零售表(RIM_RETAIL_DETAIL)：泰安测试库和提供脚本均还没加门店字段：TREND_ID  (注：老软件是在2011.04.03增加 [流向功能])
--ALTER TABLE RIM_RETAIL_DETAIL ADD TREND_ID varchar(13);  

--2、修改RIM系统原定义门店字段长度（R3的门店编号长度：SHOP_ID varchar (13)）
ALTER TABLE RIM_R3_NUM ALTER column TERM_ID SET DATA TYPE VARCHAR(13);   

--3.修改会员同步字段长度为：36位；(协调后做修改)
ALTER TABLE RIM_VIP_CONSUMER ALTER column CONSUMER_ID SET DATA TYPE CHAR(36);  

--4、修改销售汇总单据号长度：CO_NUM (2011.01月中旬协调后修改)
ALTER TABLE RIM_RETAIL_CO      ALTER column CO_NUM SET DATA TYPE VARCHAR(50); 
ALTER TABLE RIM_RETAIL_CO_LINE ALTER column CO_NUM SET DATA TYPE VARCHAR(50);
 
--DB_R3上报RIMDB数据注意事项：
--(1)、RIM系统创建RIM_R3_NUM同步时间戳表[以后老系统升级需要对此表时间初始值进行处理])： 
--(2)、使用临时表，需要有用户临时表空间存在，创建用户临时表空间：（在V9安装后默认创建：SYSTOOLSTMPSPACE，根据情况创建）
--CREATE USER TEMPORARY TABLESPACE USERTMPSPACE PAGESIZE 4 K MANAGED BY SYSTEM USING ('[CURDIR]\TEMP'); 

--创建视图：RIM_PUB_ORGAN
create view RIM_PUB_ORGAN as select * from PUB_ORGAN;

--////2011.04.07 PM：对照经营供应链商品， 创建远程对象表NICKNAME：
CREATE NICKNAME SD_UM FOR  RIMLINK.DB2ADMIN.SD_UM; 
CREATE NICKNAME SD_ITEM FOR  RIMLINK.DB2ADMIN.SD_ITEM;
CREATE NICKNAME SD_ITEM_UM FOR  RIMLINK.DB2ADMIN.SD_ITEM_UM;  
CREATE NICKNAME SD_ITEM_PRI FOR  RIMLINK.DB2ADMIN.SD_ITEM_PRI;
CREATE NICKNAME SD_ITEM_COM FOR  RIMLINK.DB2ADMIN.SD_ITEM_COM;
CREATE NICKNAME SD_ITEM_TOBACCO FOR  RIMLINK.DB2ADMIN.SD_ITEM_TOBACCO; 

--创建视图：RIM_GOODS_RELATION
create view RIM_GOODS_RELATION
as
select
  e.com_id as TENANT_ID,      --企业（公司）ID（包括省级、地市公司）
  a.item_id as GODS_ID,       --商品内码
  a.item_code as GODS_CODE,   --商品编码
  a.item_name as GODS_NAME,   --商品名称
  a.short_name as GODS_SNAME, --商品简称 
  b.kind as SORT_ID2,         --烟分类（1：一类烟..6:无价类）
  b.IS_IMPORTED as SORT_ID6,  --省内外烟 
  b.spec as GODS_SPEC,        --商品规格
  '条' as CALC_UNIT,          --单位
  PACK_BAR as PACK_BARCODE,   --条条码
  BOX_BAR as BOX_BARCODE,     --盒条码
  um2.um_size/um1.um_size as CAlC_AMT, --条换算成合的换算关系
  c.pri as PACK_INPRICE,      --批发价
  d.pri as PACK_OUTPRICE      --零售价
from sd_item a,sd_item_tobacco b,
     (SELECT A.ITEM_ID,A.UM_ID,COALESCE(B.UM_SIZE,A.UM_SIZE) UM_SIZE FROM (SELECT I.ITEM_ID,U.UM_ID,U.UM_SIZE FROM SD_ITEM I,SD_UM U) A 
       LEFT JOIN SD_ITEM_UM B ON A.ITEM_ID=B.ITEM_ID AND A.UM_ID=B.UM_ID )um1,
     (SELECT A.ITEM_ID,A.UM_ID,COALESCE(B.UM_SIZE,A.UM_SIZE) UM_SIZE FROM (SELECT I.ITEM_ID,U.UM_ID,U.UM_SIZE FROM SD_ITEM I,SD_UM U) A 
       LEFT JOIN SD_ITEM_UM B ON A.ITEM_ID=B.ITEM_ID AND A.UM_ID=B.UM_ID)um2,
     sd_item_pri c,
     sd_item_pri d,
     sd_item_com e
where e.com_id=d.com_id and e.com_id=c.com_id and c.com_id=d.com_id and a.item_id=b.item_id and a.item_id=um1.item_id and a.item_id=um2.item_id and um1.UM_ID='02' and um2.UM_ID='03' and
      a.item_id=c.item_id and a.item_id=d.item_id and a.item_id=e.item_id and  c.pri_type='03' and d.pri_type='04' and a.is_mrb='1' and 
      c.is_mrb='1' and e.is_mrb='1';   
      
--////2011.04.07 PM ：创建对接中间表：INF_GOODS_RELATION （国家烟草供应链：1000006）
CREATE TABLE INF_GOODS_RELATION (
     --GUID号
	ROWS_ID char (36) NOT NULL ,
     --企业代码 
	TENANT_ID int NOT NULL ,
     --供应链
	RELATION_ID int NOT NULL ,
     --货品代码
	GODS_ID char (36) NOT NULL , 
     --行业内码<第三方系统内码>
	SECOND_ID varchar (36), 
     --货号<识别码>
	GODS_CODE varchar (36), 
     --品名+规格
	GODS_NAME varchar (50) ,
     --拼音码
	GODS_SPELL varchar (50) ,
     --分类1
	SORT_ID1 varchar (36),
     --分类2
	SORT_ID2 varchar (36),
     --分类3
	SORT_ID3 varchar (36),
     --分类4
	SORT_ID4 varchar (36),
     --分类5
	SORT_ID5 varchar (36),
     --分类6
	SORT_ID6 varchar (36),
     --颜色组
	SORT_ID7 varchar (36),
     --尺码组
	SORT_ID8 varchar (36),
     --自定义9
	SORT_ID9 varchar (36),
     --自定义10
	SORT_ID10 varchar (36),
     --自定义11
	SORT_ID11 varchar (36),
     --自定义12
	SORT_ID12 varchar (36),
     --自定义13
	SORT_ID13 varchar (36),
     --自定义14
	SORT_ID14 varchar (36),
     --自定义15
	SORT_ID15 varchar (36),
     --自定义16
	SORT_ID16 varchar (36),
     --自定义17
	SORT_ID17 varchar (36),
     --自定义18
	SORT_ID18 varchar (36),
     --自定义19
	SORT_ID19 varchar (36),
     --自定义20
	SORT_ID20 varchar (36),
     --标准进价
	NEW_INPRICE decimal(18, 3),
     --标准售价
	NEW_OUTPRICE decimal(18, 3),
     --最低售价
	NEW_LOWPRICE decimal(18, 3),
     --是否启用折扣率 1启用,2禁用
	USING_PRICE int ,
     --是否参考积分
	HAS_INTEGRAL int ,
     --是否使用批号管制
	USING_BATCH_NO int ,
     --是否管制积分换购
	USING_BARTER int ,
     --是否管制物流跟踪码
	USING_LOCUS_NO int ,
     --积分换购积分
	BARTER_INTEGRAL int ,
	   --条条码
  PACK_BARCODE varchar(30),
     --更新标记位(0:表示没有更新对应; 1:表示修改; 2: 表示插入)、
  UPDATE_FLAG int NOT NULL,
  CONSTRAINT PK_INF_G_RELATION  PRIMARY KEY (ROWS_ID)  --广西柳州（PK_INF_G_RELATION）创建
);

-- 表上创建索引
CREATE INDEX IX_INF_RELATION_TENANT_ID ON INF_GOODS_RELATION(TENANT_ID,RELATION_ID,GODS_ID);
 
--创建视图：RIM_RM_CUST(零售户档案)
create view RIM_RM_CUST
as
select 
  CUST_ID     --零售户内码
  CUST_CODE , --零售户编码
  CORPORATION_NAME,  --企业名称
  CUST_SHORT_NAME,   --零售户简称 
  CUST_SHORT_ID,     --助记码 
  COM_ID, 	    --公司内码
  REGIE_ID,     --专卖局内码
  LICENSE_CODE  --许可证号
from RM_CUST; 
--创建视图：RIM_SD_CO (订单主表)
create view RIM_SD_CO
as
select 
  CO_NUM,      --订单号ID
  COM_ID,      --供应商公司ID
  CUST_ID,     --客户编号（零售户）ID
  CRT_DATE,    --创建日期
  BORN_DATE,   --生效日期 为客户保留库存
  ARR_DATE,    --送达日期, 承诺订单的商品送达到客户手中的日期
  QTY_SUM,     --数量合计  
  AMT_SUM,     --应收金额合计
  STATUS       --单据状态		
from SD_CO

--创建视图：RIM_SD_CO_LINE ( 订单明明细表)
create view RIM_SD_CO_LINE
as
select 
  CO_NUM,   --订单编号
  LINE_NUM, --行号
  ITEM_ID,  --商品编号
  UM_ID,    --计量单位
  QTY_NEED, --需求数量
  QTY_VFY,  --审核数量
  QTY_ORD,  --订购数量
  PRI,      --折扣价格
  PRI3,     --三级批发价
  AMT,      --含税金额, 金额=订购数量*折扣价格
  RET_AMT,  --折扣额
  NOTE as NOTE   --备注					
from SD_CO_LINE;

--2011.04.11 PM：创建入库单中间表主表：
CREATE TABLE INF_INDEORDER (
        --企业ID(对应：Rim供应商:CLIENT_ID)
	TENANT_ID int NOT NULL ,
        --门店ID(对应：零售户代码:CUST_ID)
	SHOP_ID varchar (13) NOT NULL ,
        --订单单号
	INDE_ID varchar (50) NOT NULL ,
        --入库日期
	INDE_DATE varchar(10) NOT NULL ,
        --入库数量      
	INDE_AMT decimal(18, 6) ,
        --需求数量（下载订单导入）      
	NEED_AMT decimal(18, 6) ,
        --入库金额
	INDE_MNY decimal(18, 6) ,
	 --单据状态	
  STATUS varchar(4), 		
	CONSTRAINT PK_INF_INDEORDER PRIMARY KEY (INDE_ID)
);
--创建索引
CREATE INDEX IX_INF_INDEORDER_TENANT_ID ON INF_INDEORDER(TENANT_ID);
CREATE INDEX IX_INF_INDEORDER_STOCK_DATE ON INF_INDEORDER(INDE_DATE);

--2011.04.11 PM：创建入库单中间表明细表：
 CREATE TABLE INF_INDEDATA (
     --企业ID(对应：Rim供应商:CLIENT_ID)
 	TENANT_ID int NOT NULL , 
 	   --订单编号
  INDE_ID varchar (50) NOT NULL ,
     --商品编号(R3)  
  GODS_ID varchar (50) ,   
     --商品编号(第三方)
  SECOND_ID varchar (50) ,   
     --计量单位
  UNIT_ID char (36) ,         
     --需求数量
  NEED_AMT decimal(18, 6) ,    
     --审核数量
  CHK_AMT decimal(18, 6) ,   
     --订购数量 
  AMOUNT decimal(18, 6) ,    
     --折扣价格
  APRICE decimal(18, 6),     
     --三级批发价  
  PRI3 decimal(18, 6) ,      
     --折扣金额	
  AGIO_MONEY decimal(18, 6),  
     --含税金额, 金额=订购数量*折扣价格
  AMONEY decimal(18, 6),      
     --计量单位数据						
	CALC_AMOUNT decimal(18, 3)  
  );
--创建索引 
CREATE INDEX IX_INF_INDEDATA_GODS_ID ON INF_INDEDATA(TENANT_ID,INDE_ID);
 
--2011.05.25 PM添加创建视图： 
Create VIEW RIM_MESSAGE as 
select 
  COM_ID,MSG_ID,TYPE,TITLE,CONTENT,USE_DATE,INVALID_DATE,OPERATOR,REC_TYPE,RECEIVER,STATUS,UPD_DATE,UPD_TIME,RECEIVER_TYPE 
from RIMLINK.DB2ADMIN.RIM_MESSAGE;

