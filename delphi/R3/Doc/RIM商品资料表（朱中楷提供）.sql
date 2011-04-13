
------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_UM"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_UM"  (
		  "UM_ID" VARCHAR(30) NOT NULL , 
		  "UM_NAME" VARCHAR(10) , 
		  "UM_SIZE" INTEGER WITH DEFAULT 1 , 
		  "NOTE" VARCHAR(30) , 
		  "IS_MRB" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "UM_KIND" VARCHAR(1) WITH DEFAULT '0' )   ;


-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_UM"

ALTER TABLE "DB2ADMIN"."SD_UM" 
	ADD CONSTRAINT "UM_PK" PRIMARY KEY
		("UM_ID");




------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_ITEM_UM"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_ITEM_UM"  (
		  "ITEM_ID" VARCHAR(30) NOT NULL , 
		  "UM_ID" VARCHAR(30) NOT NULL WITH DEFAULT '0' , 
		  "UM_SIZE" INTEGER WITH DEFAULT 1 , 
		  "NOTE" VARCHAR(30) , 
		  "IS_MRB" CHAR(1) NOT NULL WITH DEFAULT '1' )   ;


-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_ITEM_UM"

ALTER TABLE "DB2ADMIN"."SD_ITEM_UM" 
	ADD CONSTRAINT "ITEMUM_PK" PRIMARY KEY
		("ITEM_ID",
		 "UM_ID");




------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_ITEM"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_ITEM"  (
		  "ITEM_ID" VARCHAR(30) NOT NULL , 
		  "ITEM_CODE" VARCHAR(15) NOT NULL , 
		  "ITEM_NAME" VARCHAR(30) , 
		  "SHORT_NAME" VARCHAR(30) , 
		  "UM_ID" VARCHAR(30) NOT NULL WITH DEFAULT '10' , 
		  "PACK_BAR" VARCHAR(30) , 
		  "BOX_BAR" VARCHAR(30) , 
		  "UM_PUH" VARCHAR(30) WITH DEFAULT '0' , 
		  "UM_WHSE" VARCHAR(30) WITH DEFAULT '0' , 
		  "UM_SALE" VARCHAR(30) WITH DEFAULT '0' , 
		  "TAX_ID" VARCHAR(30) , 
		  "CANT_ID" VARCHAR(30) , 
		  "SHELF_PER" INTEGER WITH DEFAULT 365 , 
		  "IS_MRB" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "ITEM_KIND" CHAR(1) WITH DEFAULT '1' , 
		  "ITEM_ID_CCT" VARCHAR(8) , 
		  "COLOUR" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "STAND_BAR_CODE" VARCHAR(30) , 
		  "BIGBOX_BAR" VARCHAR(15) , 
		  "STAND_BAR_NAME" VARCHAR(40) , 
		  "BRAND_ID1" VARCHAR(30) , 
		  "MFR_ID1" VARCHAR(30) , 
		  "VEND_ID" CHAR(30) , 
		  "IS_NORMAL" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "ITEM_SEQU" VARCHAR(10) WITH DEFAULT '' )   ;


-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_ITEM"

ALTER TABLE "DB2ADMIN"."SD_ITEM" 
	ADD PRIMARY KEY
		("ITEM_ID");



------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_ITEM_PRI"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_ITEM_PRI"  (
		  "COM_ID" VARCHAR(30) NOT NULL , 
		  "ITEM_ID" VARCHAR(30) NOT NULL , 
		  "PRI_TYPE" CHAR(2) NOT NULL , 
		  "PRI" DECIMAL(18,6) NOT NULL , 
		  "IS_MRB" CHAR(1) )   ;


-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_ITEM_PRI"

ALTER TABLE "DB2ADMIN"."SD_ITEM_PRI" 
	ADD CONSTRAINT "ITEMPRI_PK" PRIMARY KEY
		("COM_ID",
		 "ITEM_ID",
		 "PRI_TYPE");
		 
		 
		 
------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_ITEM_COM"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_ITEM_COM"  (
		  "COM_ID" VARCHAR(30) NOT NULL , 
		  "ITEM_ID" VARCHAR(30) NOT NULL , 
		  "UNIT_COST" DECIMAL(18,8) NOT NULL WITH DEFAULT 0 , 
		  "BRAND_MANGER_ID" VARCHAR(30) NOT NULL , 
		  "ABC" CHAR(1) WITH DEFAULT '1' , 
		  "ITEM_TYPE1" VARCHAR(10) , 
		  "ITEM_TYPE2" VARCHAR(10) , 
		  "SHORT_CODE" VARCHAR(8) NOT NULL , 
		  "BRD_TYPE" CHAR(1) , 
		  "ITEM_KIND" CHAR(2) WITH DEFAULT '01' , 
		  "CATEGORY" VARCHAR(30) , 
		  "BRAND_ID" VARCHAR(30) NOT NULL , 
		  "MFR_ID" VARCHAR(30) , 
		  "NET_DATE" CHAR(8) , 
		  "IS_MRB" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "IS_COSTING" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "STATUS" CHAR(2) NOT NULL WITH DEFAULT '01' , 
		  "IS_HUNDREDBRAND" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "IS_LOWEND" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "IS_RARE" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "IS_MATURE" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "UPLIMIT_RATE" DECIMAL(18,6) , 
		  "DOWNLIMIT_RATE" DECIMAL(18,6) , 
		  "DEAL_TYPE" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "OUT_DATE" CHAR(8) WITH DEFAULT '' , 
		  "IS_BREED" CHAR(1) NOT NULL WITH DEFAULT '0' , 
		  "IS_COLLECT_STORE" CHAR(1) NOT NULL WITH DEFAULT '0' , 
		  "IS_COLLECT_PRI" CHAR(1) NOT NULL WITH DEFAULT '0' , 
		  "ITEM_GRADE" VARCHAR(2) , 
		  "BRD_KEY1" CHAR(1) WITH DEFAULT '0' , 
		  "ISRIMMRB" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "IS_RIM_MRB" CHAR(1) NOT NULL WITH DEFAULT '1' , 
		  "ENOUGH_STATUS" VARCHAR(2) WITH DEFAULT '01' )   ;

-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_ITEM_COM"

ALTER TABLE "DB2ADMIN"."SD_ITEM_COM" 
	ADD CONSTRAINT "CC1111731783109" PRIMARY KEY
		("COM_ID",
		 "ITEM_ID");		
		 
		 
------------------------------------------------
-- 表的 DDL 语句 "DB2ADMIN"."SD_ITEM_TOBACCO"
------------------------------------------------
 

CREATE TABLE "DB2ADMIN"."SD_ITEM_TOBACCO"  (
		  "ITEM_ID" VARCHAR(30) NOT NULL , 
		  "SPEC" VARCHAR(20) , 
		  "KIND" CHAR(1) WITH DEFAULT '1' , 
		  "TAR_CONT" DECIMAL(18,6) WITH DEFAULT 0 , 
		  "GAS_NICOTINE" DECIMAL(18,6) WITH DEFAULT 0 , 
		  "CO_CONT" DECIMAL(18,6) WITH DEFAULT 0 , 
		  "BRD_KIND" CHAR(1) WITH DEFAULT '0' , 
		  "BRD_KEY" CHAR(1) WITH DEFAULT '0' , 
		  "PACK_KIND" CHAR(1) , 
		  "PRODUCT_TYPE" CHAR(1) , 
		  "NATIONAL" CHAR(1) WITH DEFAULT '1' , 
		  "IS_IMPORTED" CHAR(1) WITH DEFAULT '0' , 
		  "BAR_TYPE" CHAR(1) , 
		  "DESCRIPTION" VARCHAR(250) , 
		  "FILTER_COLOR" CHAR(1) , 
		  "KIND1" CHAR(1) , 
		  "IS_ABNORMAL" VARCHAR(1) WITH DEFAULT '0' )   ;


-- 表上主键的 DDL 语句 "DB2ADMIN"."SD_ITEM_TOBACCO"

ALTER TABLE "DB2ADMIN"."SD_ITEM_TOBACCO" 
	ADD CONSTRAINT "ITEMTOBACCO_PK" PRIMARY KEY
		("ITEM_ID");