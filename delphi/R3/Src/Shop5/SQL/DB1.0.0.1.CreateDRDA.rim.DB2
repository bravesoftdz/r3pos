--RIM系统DB2版：

--关于NICKNAME后可以直接访问到远程对象表，创建视图是为了以后数据库优化、物化视图做好准备;
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

---=================================以下是Window操作系统===================================

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


---=================================以下是Linux操作系统===================================
UPDATE DBM CFG USING FEDERATED YES;  --执行后需要执行重启实例才生效; 
DB2STOP FORCE;
DB2START;
CONNECT TO DB_R3 USER R3_loginname USING R3_Password;
--2、创建安装包：(若存在先删除：DROP WRAPPER DRDA)
CREATE WRAPPER DRDA LIBRARY 'libdb2drda.so' OPTIONS (ADD DB2_FENCED 'N');  
--3、创建服务器定义：
CREATE SERVER RIMLINK TYPE DB2/UDB VERSION '9.1' WRAPPER DRDA AUTHID "RIM_loginname" PASSWORD "RIM_Password" OPTIONS(ADD DBNAME 'RIMDB');
--4、创建用户映射：
CREATE USER MAPPING FOR R3_loginname SERVER RIMLINK OPTIONS (ADD REMOTE_AUTHID 'RIM_loginname', ADD REMOTE_PASSWORD 'RIM_Password');


--2011.06.16 增加设置RimLink分布式事务参数：
--V8版本：
ALTER SERVER "RIMLINK" OPTIONS (SET DB2_TWO_PHASE_COMMIT 'Y');

--V9版本：
ALTER SERVER RIMLINK OPTIONS (ADD DB2_TWO_PHASE_COMMIT 'Y') ; 




