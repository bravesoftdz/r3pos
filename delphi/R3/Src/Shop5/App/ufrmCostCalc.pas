{  22100001	0	日结账 	1	结账	2	撤消   }

unit ufrmCostCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus,ZDataSet, RzButton, RzPrgres, StdCtrls,
  ExtCtrls, ZBase;

type
  TfrmCostCalc = class(TfrmBasic)
    Bevel1: TBevel;
    Label11: TLabel;
    RzProgressBar1: TRzProgressBar;
    Label1: TLabel;
    btnStart: TRzBitBtn;
    Label2: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Fid: string;
    Fcflag: integer;
    FcDate: TDate;
    FeDate: TDate;
    Fflag: integer;
    FbDate: TDate;
    FmDate: TDate;
    FuDate: TDate;
    FPrgPercent: integer;
    procedure Setid(const Value: string);
    procedure Setcflag(const Value: integer);
    procedure SetcDate(const Value: TDate);
    procedure SeteDate(const Value: TDate);
    procedure Setflag(const Value: integer);
    procedure SetbDate(const Value: TDate);
    procedure SetmDate(const Value: TDate);
    procedure SetuDate(const Value: TDate);
    procedure SetPrgPercent(const Value: integer);
    { Private declarations }
  protected
    procedure DBLock;
    procedure DBUnLock;
    function GetTmpSQL(tb:string):string;
  public
    { Public declarations }
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    tempTableName:string;
    tempTableName1:string;
    tempTableName2:string;
    //核算前准备
    procedure Prepare;
    procedure CreateTempTable;
    procedure PrepareDataForRck;
    procedure PrepareDataForAcct;
    procedure CheckForRck;
    procedure TruncTable(tb:string);
    procedure CreateTable(tb:string);
    //自动缴银结账
    procedure AutoPosReck;
    //移动平均成本核算<按开单时的平均加计算>
    procedure Calc0;
    //日加权移动平均成本核算
    procedure Calc1;
    //月加权移动平均成本核算
    procedure Calc2;
    //生成客户商品账
    procedure CalcSpz;
    //生成月账
    procedure CalcMth;
    //生成结账记录
    procedure ClseRck;
    //计算账户日台账
    procedure CalcAcctDay;
    //计算账户月台账
    procedure CalcAcctMth;
    //计算分析数据
    procedure CalcAnaly;
    //核算单位
    property cid:string read Fid write Setid;
    //核算方式 1日加权移动平均 2月加权移平均 3先进先出
    property calc_flag:integer read Fcflag write Setcflag;
    //上次日结日期
    property cDate:TDate read FcDate write SetcDate;
    //本次结账日期
    property eDate:TDate read FeDate write SeteDate;
    //上次月结日期
    property bDate:TDate read FbDate write SetbDate;
    //最大日期
    property mDate:TDate read FmDate write SetmDate;
    //用数据的最大日期
    property uDate:TDate read FuDate write SetuDate;
    //结账类型 0 试算， 1 日结  2 月结
    property flag:integer read Fflag write Setflag;
//    class function StartCalc(Owner:TForm):boolean;
    //计算日账户台账
    class function TryCalcDayAcct(Owner:TForm):boolean;
    //计算日商品台账
    class function TryCalcDayGods(Owner:TForm):boolean;
    //计算月账户台账
    class function TryCalcMthAcct(Owner:TForm):boolean;
    //计算月商品台账
    class function TryCalcMthGods(Owner:TForm):boolean;
    class function StartDayReck(Owner:TForm):boolean;
    class function StartMonthReck(Owner:TForm):boolean;
    //计算库存监控数据
    class function CalcAnalyLister(Owner:TForm):boolean;
    property PrgPercent:integer read FPrgPercent write SetPrgPercent;

  end;
implementation
uses uGlobal,uFnUtil,uShopGlobal,ObjCommon,uSyncFactory;
{$R *.dfm}

{ TfrmCostCalc }

procedure TfrmCostCalc.Calc1;
var
  i,w:integer;
  SQL,mySQL:string;
procedure CreateRck;
begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w)+' ');
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+GetTimeStamp(Factor.iDbType)+' '+
        'from '+tempTableName1+' where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w);
    Factor.ExecSQL(SQL);

    SQL :=
        'insert into '+tempTableName2+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+w+1)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
        'from '+tempTableName1+' A where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w)+' ';
    Factor.ExecSQL(SQL);
    truncTable(tempTableName1);
    Factor.ExecSQL('insert into '+tempTableName1+' select * from '+tempTableName2);
    truncTable(tempTableName2);
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;
begin
  //初始化期初
  SQL :=
    'insert into '+tempTableName1+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
    'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
    'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
    'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
    'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
    'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
    'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
    'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
    'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
    'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
    'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
    'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
    ')'+
    'select '+
    ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+1)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
    '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
    '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
    '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
    '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
    '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
    '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
    '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
    '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
    '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate)+' ';
  Factor.ExecSQL(SQL);
  w := 1;
  for i:= 1 to pt do
    begin
      Label11.Caption := '正在核算成本...'+formatDatetime('YYYY-MM-DD',cDate+i);
      Label11.Update;
      PrgPercent := (i*100 div pt) div 3+5;
      SQL :=
        'insert into '+tempTableName1+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST '+
        'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' ';
      Factor.ExecSQL(SQL);
      //计算成本
      mySQL :=
        ParseSQL(Factor.iDbType,
        'select 0 as TENANT_ID,GODS_ID,BATCH_NO,'+
        'case when sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))<>0 then round(cast(sum(isnull(ORG_CST,0)+isnull(STOCK_MNY,0)) as decimal(18,3))/(cast(sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0)) as decimal(18,3))*1.0),6) else 0 end as COST_PRICE '+
        'from '+tempTableName1+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'group by TENANT_ID,GODS_ID,BATCH_NO');
      //生成数据
      SQL :=
        'insert into '+tempTableName1+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
        ') '+
        'select '+
        'j.TENANT_ID,j.SHOP_ID,j.CREA_DATE,j.GODS_ID,j.BATCH_NO,'+
        'max(NEW_INPRICE) as NEW_INPRICE,max(NEW_OUTPRICE) as NEW_OUTPRICE,'+
        'sum(ORG_AMT) as ORG_AMT,sum(ORG_AMT)*max(NEW_INPRICE) as ORG_MNY,sum(ORG_AMT)*max(NEW_OUTPRICE) as ORG_RTL,sum(ORG_CST) as ORG_CST,'+
        'sum(STOCK_AMT) as STOCK_AMT,sum(STOCK_MNY) as STOCK_MNY,sum(STOCK_TAX) as STOCK_TAX,sum(STOCK_RTL) as STOCK_RTL,sum(STOCK_AGO) as STOCK_AGO,sum(STKRT_AMT) as STKRT_AMT,sum(STKRT_MNY) as STKRT_MNY,sum(STKRT_TAX) as STKRT_TAX,'+
        'sum(SALE_AMT) as SALE_AMT,sum(SALE_RTL) as SALE_RTL,sum(SALE_AGO) as SALE_AGO,sum(SALE_MNY) as SALE_MNY,sum(SALE_TAX) as SALE_TAX,sum(SALRT_AMT) as SALRT_AMT,sum(SALRT_MNY) as SALRT_MNY,sum(SALRT_TAX) as SALRT_TAX,'+
        'sum(DBIN_AMT) as DBIN_AMT,sum(DBIN_MNY) as DBIN_MNY,sum(DBIN_RTL) as DBIN_RTL,'+
        'sum(DBOUT_AMT) as DBOUT_AMT,sum(DBOUT_MNY) as DBOUT_MNY,sum(DBOUT_RTL) as DBOUT_RTL,'+
        'sum(CHANGE1_AMT) as CHANGE1_AMT,sum(CHANGE1_MNY) as CHANGE1_MNY,sum(CHANGE1_RTL) as CHANGE1_RTL,'+
        'sum(CHANGE2_AMT) as CHANGE2_AMT,sum(CHANGE2_MNY) as CHANGE2_MNY,sum(CHANGE2_RTL) as CHANGE2_RTL,'+
        'sum(CHANGE3_AMT) as CHANGE3_AMT,sum(CHANGE3_MNY) as CHANGE3_MNY,sum(CHANGE3_RTL) as CHANGE3_RTL,'+
        'sum(CHANGE4_AMT) as CHANGE4_AMT,sum(CHANGE4_MNY) as CHANGE4_MNY,sum(CHANGE4_RTL) as CHANGE4_RTL,'+
        'sum(CHANGE5_AMT) as CHANGE5_AMT,sum(CHANGE5_MNY) as CHANGE5_MNY,sum(CHANGE5_RTL) as CHANGE5_RTL,'+
        'max(c.COST_PRICE) as COST_PRICE,'+
        'round(sum(SALE_AMT*c.COST_PRICE),2) as SALE_CST,'+
        'sum(SALE_MNY)-round(sum(SALE_AMT*c.COST_PRICE),2) as SALE_PRF,'+
        'round(sum(SALRT_AMT*c.COST_PRICE),2) as SALRT_CST,'+
        'round(sum(DBIN_AMT*c.COST_PRICE),2) as DBIN_CST,'+
        'round(sum(DBOUT_AMT*c.COST_PRICE),2) as DBOUT_CST,'+
        'round(sum(CHANGE1_AMT*c.COST_PRICE),2) as CHANGE1_CST,'+
        'round(sum(CHANGE2_AMT*c.COST_PRICE),2) as CHANGE2_CST,'+
        'round(sum(CHANGE3_AMT*c.COST_PRICE),2) as CHANGE3_CST,'+
        'round(sum(CHANGE4_AMT*c.COST_PRICE),2) as CHANGE4_CST,'+
        'round(sum(CHANGE5_AMT*c.COST_PRICE),2) as CHANGE5_CST,'+
        'sum(ORG_AMT)+sum(STOCK_AMT)-sum(SALE_AMT)+sum(DBIN_AMT)-sum(DBOUT_AMT)+sum(CHANGE1_AMT)+sum(CHANGE2_AMT)+sum(CHANGE3_AMT)+sum(CHANGE4_AMT)+sum(CHANGE5_AMT) as BAL_AMT,'+
        '(sum(ORG_AMT)+sum(STOCK_AMT)-sum(SALE_AMT)+sum(DBIN_AMT)-sum(DBOUT_AMT)+sum(CHANGE1_AMT)+sum(CHANGE2_AMT)+sum(CHANGE3_AMT)+sum(CHANGE4_AMT)+sum(CHANGE5_AMT))*max(NEW_INPRICE) as BAL_MNY,'+
        '(sum(ORG_AMT)+sum(STOCK_AMT)-sum(SALE_AMT)+sum(DBIN_AMT)-sum(DBOUT_AMT)+sum(CHANGE1_AMT)+sum(CHANGE2_AMT)+sum(CHANGE3_AMT)+sum(CHANGE4_AMT)+sum(CHANGE5_AMT))*max(NEW_OUTPRICE) as BAL_RTL,'+
        'sum(ORG_CST)+sum(STOCK_MNY)-round(sum(SALE_AMT*c.COST_PRICE),2)+round(sum(DBIN_AMT*c.COST_PRICE),2)-round(sum(DBOUT_AMT*c.COST_PRICE),2)+'+
        'round(sum(CHANGE1_AMT*c.COST_PRICE),2)+round(sum(CHANGE2_AMT*c.COST_PRICE),2)+round(sum(CHANGE3_AMT*c.COST_PRICE),2)+round(sum(CHANGE4_AMT*c.COST_PRICE),2)+round(sum(CHANGE5_AMT*c.COST_PRICE),2) as BAL_CST '+
        'from('+
        'select '+
        '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL '+
        'from '+tempTableName1+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        ') j left outer join ('+mySQL+') c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID and j.BATCH_NO=c.BATCH_NO '+
        'group by j.TENANT_ID,j.SHOP_ID,j.CREA_DATE,j.GODS_ID,j.BATCH_NO ';
      Factor.ExecSQL(SQL);
      w := i;
      CreateRck;
    end;
end;

procedure TfrmCostCalc.Prepare;
var
  rs:TZQuery;
  e:TDate;
begin
  reck_flag := StrtoIntDef(ShopGlobal.GetParameter('RECK_OPTION'),1);
  reck_day := StrtoIntDef(ShopGlobal.GetParameter('RECK_DAY'),28);
  calc_flag := StrtoIntDef(ShopGlobal.GetParameter('CALC_FLAG'),0);
  PrgPercent := 0;
  pc := 0;
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    isfirst := false;
    if rs.Fields[0].asString<>'' then
       cDate := fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
       begin
         rs.Close;
         rs.SQL.Text :=  'select value from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE=''USING_DATE'' ';
         Factor.Open(rs);
         if rs.Fields[0].asString<>'' then
            cDate := fnTime.fnStrtoDate(rs.Fields[0].asString)-1
         else
            cDate := Date()-1;
         isfirst := true;
       end;

    rs.Close;
    rs.SQL.Text := 'select max(END_DATE) from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    isfirst := false;
    if rs.Fields[0].asString<>'' then
       bDate := fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
       begin
         rs.Close;
         rs.SQL.Text :=  'select value from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE=''USING_DATE'' ';
         Factor.Open(rs);
         if rs.Fields[0].asString<>'' then
            bDate := fnTime.fnStrtoDate(rs.Fields[0].asString)-1
         else
            bDate := Date()-1;
         isfirst := true;
       end;
    if flag=1 then //检测是否日结账
       begin
         rs.close;
         rs.SQL.Text := 'select CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',eDate);
         Factor.Open(rs);
         btnStart.Enabled := rs.IsEmpty;
         if not rs.IsEmpty then
            eDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
       end;
    if flag=2 then //月结时检测结账月份
       begin
         if reck_flag=1 then
           begin
             e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(date(),1))+'01')-1;
             if e>date() then //还没到结账日
                eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',date())+'01')-1
             else
                eDate := e;
           end
         else
           begin
             e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',date())+formatfloat('00',reck_day));
             if e>date() then //还没到结账日
                eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(date(),-1))+formatfloat('00',reck_day))
             else
                eDate := e;
           end;
         rs.close;
         rs.SQL.Text := 'select month from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH>='+formatDatetime('YYYYMM',eDate);
         Factor.Open(rs);
         btnStart.Enabled := rs.IsEmpty and (eDate>bDate);
         if eDate<bDate then eDate := bDate;
       end;
  finally
    rs.free;
  end;
end;

procedure TfrmCostCalc.SetcDate(const Value: TDate);
begin
  FcDate := Value;
end;

procedure TfrmCostCalc.Setcflag(const Value: integer);
begin
  Fcflag := Value;
end;

procedure TfrmCostCalc.Setid(const Value: string);
begin
  Fid := Value;
end;

procedure TfrmCostCalc.btnStartClick(Sender: TObject);
begin
  inherited;
  if flag in [1,2] then
     begin
       if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线结账!');
       if (ShopGlobal.NetVersion) then SyncFactory.SyncAll; //连锁版结账前都必须同步脱机数据...
     end;
  Label11.Caption := '读取参数...';
  Label11.Update;
  //读取参数
  Prepare;
  if (calc_flag=2) and (flag=1) then Raise Exception.Create('月移动加权平均算法不支持日结账');
  DBLock;
  try
    if Factor.iDbType=5 then Factor.BeginTrans; //对SQLite启动事务，减少IO
    try
      Label11.Caption := '核算前检测数据...';
      Label11.Update;
      PrgPercent := 1;
      CheckForRck;
      if flag in [1,2,4,6] then CreateTempTable;
      Label11.Caption := '准备核算数据...';
      Label11.Update;
      //数据准备
      if flag in [1,2,4,6] then PrepareDataForRck;
      Label11.Caption := '正在核算成本...';
      Label11.Update;
      PrgPercent := 5;
      //计算成本
      if flag in [1,2,4,6] then
      case calc_flag of
      0:Calc0;
      1:Calc1;
      2:Calc2;
      end;
      Label11.Caption := '正在计算客户商品台账...';
      Label11.Update;
      if flag in [1,2,4,6] then CalcSpz;
      Label11.Caption := '正在计算商品月台账...';
      Label11.Update;
      if flag in [1,2,6] then CalcMth;
      Label11.Caption := '正在计算账户日台账...';
      Label11.Update;
      AutoPosReck;
      //数据准备
      if flag in [1,2,3,5] then PrepareDataForAcct;
      if flag in [1,2,3,5] then CalcAcctDay;
      Label11.Caption := '正在计算账户月台账...';
      Label11.Update;
      if flag in [1,2,5] then CalcAcctMth;
    finally
      if Factor.iDbType=5 then Factor.CommitTrans;  //对SQLite启动事务，减少IO
    end;
    Label11.Caption := '输出数据中...';
    Label11.Update;
    ClseRck;
    PrgPercent := 100;
  finally
    DBUnLock;
  end;
  ModalResult := MROK;
end;

{class function TfrmCostCalc.StartCalc(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        Label2.Caption := '成本核算:'+formatDatetime('YYYY-MM-DD',date());
        result :=(ShowModal=MROK);
      finally
        free;
      end;
    end;
end;
}
procedure TfrmCostCalc.Calc2;
var
  i,b:integer;
  SQL,mySQL:string;
  e:TDate;
procedure CreateRck;
begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',e)+'');
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+GetTimeStamp(Factor.iDbType)+' '+
        'from '+tempTableName1+' where TENANT_ID=0 and CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',e)+'';
    Factor.ExecSQL(SQL);

    truncTable(tempTableName2);
    SQL :=
        'insert into '+tempTableName2+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        '0 as TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',e)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
        'from '+tempTableName1+' A where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',e)+' ';
    Factor.ExecSQL(SQL);
    truncTable(tempTableName1);
    Factor.ExecSQL('insert into '+tempTableName1+' select * from '+tempTableName2);
    truncTable(tempTableName2);
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;  
begin
  //初始化期初
  SQL :=
    'insert into '+tempTableName1+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,'+
    'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
    'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
    'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
    'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
    'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
    'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
    'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
    'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
    'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
    'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
    'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
    ')'+
    'select '+
    '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
    '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
    '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
    '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
    '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
    '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
    '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
    '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
    '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
    '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate)+' ';
  Factor.ExecSQL(SQL);
  b := 1;
  while true do
  begin
    if reck_flag=1 then
       begin
         if isfirst and (b=1) then
            begin
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
              if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
            end
         else
            e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
       end
    else
       begin
         e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day));
         if e<=(bDate+b-1) then
            e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
       end;
    Label11.Caption := '正在核算成本...'+formatDatetime('YYYY-MM',bDate+b);
    Label11.Update;
//    if (bDate+b)<=uDate then //只计算有数据部份
    begin

      SQL :=
        'insert into '+tempTableName1+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST '+
        'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+' ';
      Factor.ExecSQL(SQL);

      truncTable(tempTableName2);

      SQL :=
        'insert into '+tempTableName2+'(TENANT_ID,GODS_ID,BATCH_NO,SHOP_ID,CREA_DATE,COST_PRICE) '+
        'select TENANT_ID,GODS_ID,BATCH_NO,''#'' as SHOP_ID,0,'+
        'case when sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))<>0 then round(cast(sum(isnull(ORG_CST,0)+isnull(STOCK_MNY,0)) as decimal(18,3))/(cast(sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0)) as decimal(18,3))*1.0),6) else 0 end as COST_PRICE '+
        'from '+tempTableName1+' '+
        'group by TENANT_ID,GODS_ID,BATCH_NO';
      Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));

    end;

    for i:= b to pt do
      begin
        if (bDate+i)>e then break;
        Label11.Caption := '正在核算成本...'+formatDatetime('YYYY-MM-DD',bDate+i);
        Label11.Update;
        PrgPercent := (i*100 div pt) div 3+5;
        //生成数据
        SQL :=
          'insert into '+tempTableName1+'('+
          'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
          'NEW_INPRICE,NEW_OUTPRICE,'+
          'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
          'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
          'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
          'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
          'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
          'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
          'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
          'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
          'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
          'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
          'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
          'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST,'+
          'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
          ') '+
          'select jc.*,'+
          'round(SALE_AMT*COST_PRICE,2) as SALE_CST,'+
          'SALE_MNY-round(SALE_AMT*COST_PRICE,2) as SALE_PRF,'+
          'round(SALRT_AMT*COST_PRICE,2) as SALRT_CST,'+
          'round(DBIN_AMT*COST_PRICE,2) as DBIN_CST,'+
          'round(DBOUT_AMT*COST_PRICE,2) as DBOUT_CST,'+
          'round(CHANGE1_AMT*COST_PRICE,2) as CHANGE1_CST,'+
          'round(CHANGE2_AMT*COST_PRICE,2) as CHANGE2_CST,'+
          'round(CHANGE3_AMT*COST_PRICE,2) as CHANGE3_CST,'+
          'round(CHANGE4_AMT*COST_PRICE,2) as CHANGE4_CST,'+
          'round(CHANGE5_AMT*COST_PRICE,2) as CHANGE5_CST,'+
          'ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT as BAL_AMT,'+
          '(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE as BAL_MNY,'+
          '(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE as BAL_RTL,'+
          'ORG_CST+STOCK_MNY-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
          'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) as BAL_CST from ( '+
          'select '+
          'j.TENANT_ID,j.SHOP_ID,j.CREA_DATE,j.GODS_ID,j.BATCH_NO,'+
          'max(j.NEW_INPRICE) as NEW_INPRICE,max(j.NEW_OUTPRICE) as NEW_OUTPRICE,'+
          'sum(j.ORG_AMT) as ORG_AMT,sum(j.ORG_AMT)*max(j.NEW_INPRICE) as ORG_MNY,sum(j.ORG_AMT)*max(j.NEW_OUTPRICE) as ORG_RTL,sum(j.ORG_CST) as ORG_CST,'+
          'sum(j.STOCK_AMT) as STOCK_AMT,sum(j.STOCK_MNY) as STOCK_MNY,sum(j.STOCK_TAX) as STOCK_TAX,sum(j.STOCK_RTL) as STOCK_RTL,sum(j.STOCK_AGO) as STOCK_AGO,sum(j.STKRT_AMT) as STKRT_AMT,sum(j.STKRT_MNY) as STKRT_MNY,sum(j.STKRT_TAX) as STKRT_TAX,'+
          'sum(j.SALE_AMT) as SALE_AMT,sum(j.SALE_RTL) as SALE_RTL,sum(j.SALE_AGO) as SALE_AGO,sum(j.SALE_MNY) as SALE_MNY,sum(j.SALE_TAX) as SALE_TAX,'+
          'sum(j.SALRT_AMT) as SALRT_AMT,sum(j.SALRT_MNY) as SALRT_MNY,sum(j.SALRT_TAX) as SALRT_TAX,'+
          'sum(j.DBIN_AMT) as DBIN_AMT,sum(j.DBIN_MNY) as DBIN_MNY,sum(j.DBIN_RTL) as DBIN_RTL,'+
          'sum(j.DBOUT_AMT) as DBOUT_AMT,sum(j.DBOUT_MNY) as DBOUT_MNY,sum(j.DBOUT_RTL) as DBOUT_RTL,'+
          'sum(j.CHANGE1_AMT) as CHANGE1_AMT,sum(j.CHANGE1_MNY) as CHANGE1_MNY,sum(j.CHANGE1_RTL) as CHANGE1_RTL,'+
          'sum(j.CHANGE2_AMT) as CHANGE2_AMT,sum(j.CHANGE2_MNY) as CHANGE2_MNY,sum(j.CHANGE2_RTL) as CHANGE2_RTL,'+
          'sum(j.CHANGE3_AMT) as CHANGE3_AMT,sum(j.CHANGE3_MNY) as CHANGE3_MNY,sum(j.CHANGE3_RTL) as CHANGE3_RTL,'+
          'sum(j.CHANGE4_AMT) as CHANGE4_AMT,sum(j.CHANGE4_MNY) as CHANGE4_MNY,sum(j.CHANGE4_RTL) as CHANGE4_RTL,'+
          'sum(j.CHANGE5_AMT) as CHANGE5_AMT,sum(j.CHANGE5_MNY) as CHANGE5_MNY,sum(j.CHANGE5_RTL) as CHANGE5_RTL,max(isnull(c.COST_PRICE,0)) as COST_PRICE '+
          'from('+
          'select '+
          '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
          'NEW_INPRICE,NEW_OUTPRICE,'+
          '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
          'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
          'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
          'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
          'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
          'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
          'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
          'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
          'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
          'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
          'from '+tempTableName1+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+' '+
          'union all '+
          'select '+
          '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
          'A.NEW_INPRICE,A.NEW_OUTPRICE,'+
          'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
          '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
          '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
          '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
          '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
          '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
          '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
          '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
          '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
          '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
          'from '+tempTableName1+' A where A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i-1)+' '+
          ') j left outer join ('+tempTableName2+') c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID and j.BATCH_NO=c.BATCH_NO '+
          'group by j.TENANT_ID,j.SHOP_ID,j.CREA_DATE,j.GODS_ID,j.BATCH_NO ) jc ';
        Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));

      end;
      CreateRck;
      if e>=mDate then break;
      b := b +round(e-(bDate+b))+1;
  end;
end;

procedure TfrmCostCalc.PrepareDataForRck;
var
  SQL:string;
  rs:TZQuery;
  myDate:TDate;
begin
  myDate := cDate;
  if (calc_flag=2) then myDate := bDate;
  SQL :=
    'insert into '+tempTableName+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
    'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
    'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
    'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
    'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
    'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
    'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
    'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
    'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
    'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
    ') '+
    'select '+
    'A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'max(isnull(B.NEW_INPRICE,0)),max(isnull(B.NEW_OUTPRICE,0)),'+
    '0,0,0,0,'+
    'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(round(STOCK_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
    'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),case when sum(SALE_AMT)<>0 then sum(SALE_CST)/(sum(SALE_AMT)*1.0) else 0 end,sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
    'sum(DBIN_AMT),sum(round(DBIN_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(DBIN_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(DBIN_CST),'+
    'sum(DBOUT_AMT),sum(round(DBOUT_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(DBOUT_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(DBOUT_CST),'+
    'sum(CHANGE1_AMT),sum(round(CHANGE1_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(CHANGE1_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(CHANGE1_CST),'+
    'sum(CHANGE2_AMT),sum(round(CHANGE2_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(CHANGE2_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(CHANGE2_CST),'+
    'sum(CHANGE3_AMT),sum(round(CHANGE3_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(CHANGE3_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(CHANGE3_CST),'+
    'sum(CHANGE4_AMT),sum(round(CHANGE4_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(CHANGE4_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(CHANGE4_CST),'+
    'sum(CHANGE5_AMT),sum(round(CHANGE5_AMT*isnull(B.NEW_INPRICE,0),2)),sum(round(CHANGE5_AMT*isnull(B.NEW_OUTPRICE,0),2)),sum(CHANGE5_CST) '+
    'from VIW_GOODS_DAYS A,VIW_GOODSPRICEEXT B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO ';
  Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from '+tempTableName+' where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
       begin
         myDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
         if myDate>(Date()+7) then myDate := Date()+7;
       end;
    if (myDate>eDate) and (eDate=0) then eDate := myDate;
    
    mDate := myDate;
    uDate := mDate;
    
    //每次计算都算到最后一天
    if mDate<eDate then mDate := eDate;
    pt := round(mDate-cDate);
  finally
    rs.Free;
  end;
end;

procedure TfrmCostCalc.Calc0;
var
  i,w:integer;
  SQL,u:string;
procedure CreateRck;
begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w)+' ');
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+GetTimeStamp(Factor.iDbType)+' '+
        'from '+tempTableName1+' where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w);
    Factor.ExecSQL(SQL);

    SQL :=
        'insert into '+tempTableName2+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+w+1)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
        'from '+tempTableName1+' A where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+w)+' ';
    Factor.ExecSQL(SQL);
    truncTable(tempTableName1);
    Factor.ExecSQL('insert into '+tempTableName1+' select * from '+tempTableName2);
    truncTable(tempTableName2);
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;
begin
  //初始化期初
  SQL :=
    'insert into '+tempTableName1+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
    'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
    'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
    'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
    'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
    'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
    'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
    'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
    'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
    'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
    'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
    'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
    ')'+
    'select '+
    ''+inttostr(Global.TENANT_ID)+' as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+1)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
    '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
    '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
    '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
    '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
    '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
    '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
    '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
    '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
    '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate)+' ';
  Factor.ExecSQL(SQL);
  w := 1;
  for i:= 1 to pt do
    begin
      Label11.Caption := '正在核算成本...'+formatDatetime('YYYY-MM-DD',cDate+i);
      Label11.Update;
      PrgPercent := (i*100 div pt) div 3+5;
      //准备期初
      SQL :=
        'insert into '+tempTableName1+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST'+
        ')'+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALRT_AMT,SALRT_MNY,SALRT_TAX,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,'+
        'COST_PRICE,SALE_CST,SALE_PRF,SALRT_CST,DBIN_CST,DBOUT_CST,'+
        'CHANGE1_CST,CHANGE2_CST,CHANGE4_CST,CHANGE5_CST,CHANGE3_CST '+
        'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' ';
      Factor.ExecSQL(SQL);
      //生成数据
      SQL :=
        'insert into '+tempTableName1+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
        ') '+
        'select jc.*,'+
        'ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT as BAL_AMT,'+
        '(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE as BAL_MNY,'+
        '(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE as BAL_RTL,'+
        'ORG_CST+STOCK_MNY-SALE_CST+DBIN_CST-DBOUT_CST+'+
        'CHANGE1_CST+CHANGE2_CST+CHANGE3_CST+CHANGE4_CST+CHANGE5_CST as BAL_CST from('+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'max(NEW_INPRICE) as NEW_INPRICE,max(NEW_OUTPRICE) as NEW_OUTPRICE,'+
        'sum(ORG_AMT) as ORG_AMT,sum(ORG_AMT)*max(NEW_INPRICE) as ORG_MNY,sum(ORG_AMT)*max(NEW_OUTPRICE) as ORG_RTL,sum(ORG_CST) as ORG_CST,'+
        'sum(STOCK_AMT) as STOCK_AMT,sum(STOCK_MNY) as STOCK_MNY,sum(STOCK_TAX) as STOCK_TAX,sum(STOCK_RTL) as STOCK_RTL,sum(STOCK_AGO) as STOCK_AGO,sum(STKRT_AMT) as STKRT_AMT,sum(STKRT_MNY) as STKRT_MNY,sum(STKRT_TAX) as STKRT_TAX,'+
        'sum(SALE_AMT) as SALE_AMT,sum(SALE_RTL) as SALE_RTL,sum(SALE_AGO) as SALE_AGO,sum(SALE_MNY) as SALE_MNY,sum(SALE_TAX) as SALE_TAX,sum(SALE_CST) as SALE_CST,'+
        'round(case when sum(SALE_AMT)<>0 then cast(sum(SALE_CST) as decimal(18,3))/(cast(sum(SALE_AMT) as decimal(18,3))*1.0) else 0 end,6) as COST_PRICE,sum(SALE_PRF) as SALE_PRF,'+
        'sum(SALRT_AMT) as SALRT_AMT,sum(SALRT_MNY) as SALRT_MNY,sum(SALRT_TAX) as SALRT_TAX,sum(SALRT_CST) as SALRT_CST,'+
        'sum(DBIN_AMT) as DBIN_AMT,sum(DBIN_MNY) as DBIN_MNY,sum(DBIN_RTL) as DBIN_RTL,sum(DBIN_CST) as DBIN_CST,'+
        'sum(DBOUT_AMT) as DBOUT_AMT,sum(DBOUT_MNY) as DBOUT_MNY,sum(DBOUT_RTL) as DBOUT_RTL,sum(DBOUT_CST) as DBOUT_CST,'+
        'sum(CHANGE1_AMT) as CHANGE1_AMT,sum(CHANGE1_MNY) as CHANGE1_MNY,sum(CHANGE1_RTL) as CHANGE1_RTL,sum(CHANGE1_CST) as CHANGE1_CST,'+
        'sum(CHANGE2_AMT) as CHANGE2_AMT,sum(CHANGE2_MNY) as CHANGE2_MNY,sum(CHANGE2_RTL) as CHANGE2_RTL,sum(CHANGE2_CST) as CHANGE2_CST,'+
        'sum(CHANGE3_AMT) as CHANGE3_AMT,sum(CHANGE3_MNY) as CHANGE3_MNY,sum(CHANGE3_RTL) as CHANGE3_RTL,sum(CHANGE3_CST) as CHANGE3_CST,'+
        'sum(CHANGE4_AMT) as CHANGE4_AMT,sum(CHANGE4_MNY) as CHANGE4_MNY,sum(CHANGE4_RTL) as CHANGE4_RTL,sum(CHANGE4_CST) as CHANGE4_CST,'+
        'sum(CHANGE5_AMT) as CHANGE5_AMT,sum(CHANGE5_MNY) as CHANGE5_MNY,sum(CHANGE5_RTL) as CHANGE5_RTL,sum(CHANGE5_CST) as CHANGE5_CST '+
        'from('+
        'select '+
        '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
        'from '+tempTableName1+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ) jc ';
      Factor.ExecSQL(SQL);
      w := i;
      CreateRck;
    end;
end;

procedure TfrmCostCalc.SeteDate(const Value: TDate);
begin
  FeDate := Value;
end;

procedure TfrmCostCalc.FormCreate(Sender: TObject);
begin
  inherited;
  eDate := 0;
end;

class function TfrmCostCalc.StartDayReck(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 1;
        Caption := '日结账';
        eDate := Date()-1;
        Prepare;
        Label2.Caption := '结账日期:'+formatDatetime('YYYY-MM-DD',eDate);
        result :=(ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

class function TfrmCostCalc.StartMonthReck(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 2;
        Caption := '月结账';
        eDate := Date()-1;
        Prepare;
        Label2.Caption := '月结日期:'+formatDatetime('YYYY-MM-DD',eDate);
        if eDate>Date() then Raise Exception.Create('没有到本月结账日，无法执行月结操作。');
        result :=(ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmCostCalc.CalcMth;
var
  i,b,bl:integer;
  SQL:string;
  e:TDate;
begin
  b := 1;
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    while true do
    begin
      if pt>0 then PrgPercent := (b*100 div pt) div 3+35;
      if reck_flag=1 then
         begin
           if isfirst and (b=1) then
              begin
                e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
                if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
              end
           else
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
         end
      else
         begin
           e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day));
           if e<=(bDate+b-1) then
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
         end;
      SQL := 'delete from RCK_GOODS_MONTH where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH>='+formatDatetime('YYYYMM',e);

      bl := round(e-bdate);
      if e>mDate then //最后一个月期末，要按实际有日账记录的数据来取
         begin
           bl := round(mDate-bdate);
         end;
      Factor.ExecSQL(SQL);
      SQL :=
        'insert into RCK_GOODS_MONTH('+
        'TENANT_ID,SHOP_ID,MONTH,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'PRIOR_YEAR_AMT,PRIOR_YEAR_MNY,PRIOR_YEAR_TAX,PRIOR_YEAR_CST,PRIOR_MONTH_AMT,PRIOR_MONTH_MNY,PRIOR_MONTH_TAX,PRIOR_MONTH_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,ADJ_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMM',e)+',GODS_ID,BATCH_NO,'+
        'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b)+' then ORG_AMT else 0 end),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b)+' then ORG_AMT else 0 end)*max(NEW_INPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b)+' then ORG_AMT else 0 end)*max(NEW_OUTPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b)+' then ORG_CST else 0 end),'+
        'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
        'sum(PRIOR_YEAR_AMT),sum(PRIOR_YEAR_MNY),sum(PRIOR_YEAR_TAX),sum(PRIOR_YEAR_CST),sum(PRIOR_MONTH_AMT),sum(PRIOR_MONTH_MNY),sum(PRIOR_MONTH_TAX),sum(PRIOR_MONTH_CST),'+
        'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
        'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
        'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
        'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
        'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
        'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
        'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end)*max(NEW_INPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end)*max(NEW_OUTPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_CST else 0 end),0,''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
        'from('+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        '0 as PRIOR_YEAR_AMT,0 as PRIOR_YEAR_MNY,0 as PRIOR_YEAR_TAX,0 as PRIOR_YEAR_CST,0 as PRIOR_MONTH_AMT,0 as PRIOR_MONTH_MNY,0 as PRIOR_MONTH_TAX,0 as PRIOR_MONTH_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
        'from RCK_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+' '+
        'union all '+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        '0 as NEW_INPRICE,0 as NEW_OUTPRICE,'+
        '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        'SALE_AMT as PRIOR_YEAR_AMT,SALE_MNY as PRIOR_YEAR_MNY,SALE_TAX as PRIOR_YEAR_TAX,SALE_CST as PRIOR_YEAR_CST,0 as PRIOR_MONTH_AMT,0 as PRIOR_MONTH_MNY,0 as PRIOR_MONTH_TAX,0 as PRIOR_MONTH_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST,'+
        '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST '+
        'from RCK_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',incmonth(bDate+b,-12))+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',incmonth(e,-12))+' '+
        'union all '+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        '0 as NEW_INPRICE,0 as NEW_OUTPRICE,'+
        '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as PRIOR_YEAR_AMT,0 as PRIOR_YEAR_MNY,0 as PRIOR_YEAR_TAX,0 as PRIOR_YEAR_CST,SALE_AMT as PRIOR_MONTH_AMT,SALE_MNY as PRIOR_MONTH_MNY,SALE_TAX as PRIOR_MONTH_TAX,SALE_CST as PRIOR_MONTH_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST,'+
        '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST '+
        'from RCK_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',incmonth(bDate+b,-1))+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',incmonth(e,-1))+' '+
        ') j group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO';
      Factor.ExecSQL(SQL);
      if e>=mdate then break;
      b := b +round(e-(bDate+b))+1;
    end;
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;

procedure TfrmCostCalc.Setflag(const Value: integer);
begin
  Fflag := Value;
end;

procedure TfrmCostCalc.ClseRck;
var
  i,b:integer;
  SQL:string;
  e:TDate;
begin
  if not (flag in [1,2]) then Exit;
  Factor.BeginTrans;
  try
    if pt>0 then PrgPercent := (b*100 div pt) div 3+90;
    for i:=1 to pt do
       begin
         if (cDate+i)<=eDate then //只有日结内时间要生成记录已生成日台账部份
         begin
         Factor.ExecSQL('insert into RCK_DAYS_CLOSE(TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
                        'select TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+','''+Global.UserID+''',''00'','+GetTimeStamp(Factor.iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)
                        );
         end;
       end;
       
    if flag=2 then
    begin
      b := 1;
      while true do
      begin
        if reck_flag=1 then
           begin
             if isfirst and (b=1) then
                begin
                  e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
                  if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
                end
             else
                e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
           end
        else
           begin
             e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day));
             if e<=(bDate+b-1) then
                e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
           end;
        SQL :=
           'insert into RCK_MONTH_CLOSE(TENANT_ID,SHOP_ID,MONTH,BEGIN_DATE,END_DATE,CREA_USER,COMM,TIME_STAMP) '+
           'select TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMM',e)+','''+formatDatetime('YYYY-MM-DD',bDate+b)+''','''+formatDatetime('YYYY-MM-DD',e)+''','''+Global.UserID+''',''00'','+GetTimeStamp(Factor.iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(Global.TENANT_ID);
        Factor.ExecSQL(SQL);
        if e>=eDate then break;
        b := b +round(e-(bDate+b))+1;
      end;
    end;
    Factor.CommitTrans;
  except
    Factor.RollbackTrans;
    raise;
  end;
end;

procedure TfrmCostCalc.SetbDate(const Value: TDate);
begin
  FbDate := Value;
end;

procedure TfrmCostCalc.SetmDate(const Value: TDate);
begin
  FmDate := Value;
end;

procedure TfrmCostCalc.SetuDate(const Value: TDate);
begin
  FuDate := Value;
end;

function TfrmCostCalc.GetTmpSQL(tb:string):string;
begin
  case Factor.iDbType of
  0,5:result :=
    'CREATE TABLE '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	CREA_DATE int NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	NEW_INPRICE decimal(18, 3) NULL ,'+
    '	NEW_OUTPRICE decimal(18, 3) NULL ,'+
    '	ORG_AMT decimal(18, 3) NULL ,'+
    '	ORG_MNY decimal(18, 3) NULL ,'+
    '	ORG_RTL decimal(18, 3) NULL ,'+
    '	ORG_CST decimal(18, 3) NULL ,'+
    '	STOCK_AMT decimal(18, 3) NULL ,'+
    '	STOCK_MNY decimal(18, 3) NULL ,'+
    '	STOCK_TAX decimal(18, 3) NULL ,'+
    '	STOCK_RTL decimal(18, 3) NULL ,'+
    '	STOCK_AGO decimal(18, 3) NULL ,'+
    '	STKRT_AMT decimal(18, 3) NULL ,'+
    '	STKRT_MNY decimal(18, 3) NULL ,'+
    '	STKRT_TAX decimal(18, 3) NULL ,'+
    '	SALE_AMT decimal(18, 3) NULL ,'+
    '	SALE_RTL decimal(18, 3) NULL ,'+
    '	SALE_AGO decimal(18, 3) NULL ,'+
    '	SALE_MNY decimal(18, 3) NULL ,'+
    '	SALE_TAX decimal(18, 3) NULL ,'+
    '	SALE_CST decimal(18, 3) NULL ,'+
    '	COST_PRICE decimal(18, 6) NULL ,'+
    '	SALE_PRF decimal(18, 3) NULL ,'+
    '	SALRT_AMT decimal(18, 3) NULL ,'+
    '	SALRT_MNY decimal(18, 3) NULL ,'+
    '	SALRT_TAX decimal(18, 3) NULL ,'+
    '	SALRT_CST decimal(18, 3) NULL ,'+
    '	DBIN_AMT decimal(18, 3) NULL ,'+
    '	DBIN_MNY decimal(18, 3) NULL ,'+
    '	DBIN_RTL decimal(18, 3) NULL ,'+
    '	DBIN_CST decimal(18, 3) NULL ,'+
    '	DBOUT_AMT decimal(18, 3) NULL ,'+
    '	DBOUT_MNY decimal(18, 3) NULL ,'+
    '	DBOUT_RTL decimal(18, 3) NULL ,'+
    '	DBOUT_CST decimal(18, 3) NULL ,'+
    '	CHANGE1_AMT decimal(18, 3) NULL ,'+
    '	CHANGE1_MNY decimal(18, 3) NULL ,'+
    '	CHANGE1_RTL decimal(18, 3) NULL ,'+
    '	CHANGE1_CST decimal(18, 3) NULL ,'+
    '	CHANGE2_AMT decimal(18, 3) NULL ,'+
    '	CHANGE2_MNY decimal(18, 3) NULL ,'+
    '	CHANGE2_RTL decimal(18, 3) NULL ,'+
    '	CHANGE2_CST decimal(18, 3) NULL ,'+
    '	CHANGE3_AMT decimal(18, 3) NULL ,'+
    '	CHANGE3_MNY decimal(18, 3) NULL ,'+
    '	CHANGE3_RTL decimal(18, 3) NULL ,'+
    '	CHANGE3_CST decimal(18, 3) NULL ,'+
    '	CHANGE4_AMT decimal(18, 3) NULL ,'+
    '	CHANGE4_MNY decimal(18, 3) NULL ,'+
    '	CHANGE4_RTL decimal(18, 3) NULL ,'+
    '	CHANGE4_CST decimal(18, 3) NULL ,'+
    '	CHANGE5_AMT decimal(18, 3) NULL ,'+
    '	CHANGE5_MNY decimal(18, 3) NULL ,'+
    '	CHANGE5_RTL decimal(18, 3) NULL ,'+
    '	CHANGE5_CST decimal(18, 3) NULL ,'+
    '	BAL_AMT decimal(18, 3) NULL ,'+
    '	BAL_MNY decimal(18, 3) NULL ,'+
    '	BAL_RTL decimal(18, 3) NULL ,'+
    '	BAL_CST decimal(18, 3) NULL '+
    ')';
  1:result := 
    'create global temporary table '+tb+' ('+
    ' TENANT_ID NUMBER(9,0) NOT NULL ,'+
    ' SHOP_ID varchar2(13) NOT NULL ,'+
    ' CREA_DATE NUMBER(9,0) NOT NULL ,'+
    ' GODS_ID varchar2(36)  NOT NULL ,'+
    ' BATCH_NO varchar2(36) NOT NULL ,'+
    ' NEW_INPRICE decimal(18, 3) ,'+
    ' NEW_OUTPRICE decimal(18, 3) ,'+
    ' ORG_AMT decimal(18, 3) ,'+
    ' ORG_MNY decimal(18, 3) ,'+
    ' ORG_RTL decimal(18, 3) ,'+
    ' ORG_CST decimal(18, 3) ,'+
    ' STOCK_AMT decimal(18, 3) ,'+
    ' STOCK_MNY decimal(18, 3) ,'+
    ' STOCK_TAX decimal(18, 3) ,'+
    ' STOCK_RTL decimal(18, 3) ,'+
    ' STOCK_AGO decimal(18, 3) ,'+
    ' STKRT_AMT decimal(18, 3) ,'+
    ' STKRT_MNY decimal(18, 3) ,'+
    ' STKRT_TAX decimal(18, 3) ,'+
    ' SALE_AMT decimal(18, 3) ,'+
    ' SALE_RTL decimal(18, 3) ,'+
    ' SALE_AGO decimal(18, 3) ,'+
    ' SALE_MNY decimal(18, 3) ,'+
    ' SALE_TAX decimal(18, 3) ,'+
    ' SALE_CST decimal(18, 3) ,'+
    ' COST_PRICE decimal(18, 6) ,'+
    ' SALE_PRF decimal(18, 3) ,'+
    ' SALRT_AMT decimal(18, 3) ,'+
    ' SALRT_MNY decimal(18, 3) ,'+
    ' SALRT_TAX decimal(18, 3) ,'+
    ' SALRT_CST decimal(18, 3) ,'+
    ' DBIN_AMT decimal(18, 3) ,'+
    ' DBIN_MNY decimal(18, 3) ,'+
    ' DBIN_RTL decimal(18, 3) ,'+
    ' DBIN_CST decimal(18, 3) ,'+
    ' DBOUT_AMT decimal(18, 3) ,'+
    ' DBOUT_MNY decimal(18, 3) ,'+
    ' DBOUT_RTL decimal(18, 3) ,'+
    ' DBOUT_CST decimal(18, 3) ,'+
    ' CHANGE1_AMT decimal(18, 3) ,'+
    ' CHANGE1_MNY decimal(18, 3) ,'+
    ' CHANGE1_RTL decimal(18, 3) ,'+
    ' CHANGE1_CST decimal(18, 3) ,'+
    ' CHANGE2_AMT decimal(18, 3) ,'+
    ' CHANGE2_MNY decimal(18, 3) ,'+
    ' CHANGE2_RTL decimal(18, 3) ,'+
    ' CHANGE2_CST decimal(18, 3) ,'+
    ' CHANGE3_AMT decimal(18, 3) ,'+
    ' CHANGE3_MNY decimal(18, 3) ,'+
    ' CHANGE3_RTL decimal(18, 3) ,'+
    ' CHANGE3_CST decimal(18, 3) ,'+
    ' CHANGE4_AMT decimal(18, 3) ,'+
    ' CHANGE4_MNY decimal(18, 3) ,'+
    ' CHANGE4_RTL decimal(18, 3) ,'+
    ' CHANGE4_CST decimal(18, 3) ,'+
    ' CHANGE5_AMT decimal(18, 3) ,'+
    ' CHANGE5_MNY decimal(18, 3) ,'+
    ' CHANGE5_RTL decimal(18, 3) ,'+
    ' CHANGE5_CST decimal(18, 3) ,'+
    '	BAL_AMT decimal(18, 3) ,'+
    '	BAL_MNY decimal(18, 3) ,'+
    '	BAL_RTL decimal(18, 3) ,'+
    '	BAL_CST decimal(18, 3) '+
    ') ON COMMIT PRESERVE ROWS';
  4:result :=
    'declare global temporary table '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	CREA_DATE int NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	NEW_INPRICE decimal(18, 3) ,'+
    '	NEW_OUTPRICE decimal(18, 3) ,'+
    '	ORG_AMT decimal(18, 3) ,'+
    '	ORG_MNY decimal(18, 3) ,'+
    '	ORG_RTL decimal(18, 3) ,'+
    '	ORG_CST decimal(18, 3) ,'+
    '	STOCK_AMT decimal(18, 3) ,'+
    '	STOCK_MNY decimal(18, 3) ,'+
    '	STOCK_TAX decimal(18, 3) ,'+
    '	STOCK_RTL decimal(18, 3) ,'+
    '	STOCK_AGO decimal(18, 3) ,'+
    '	STKRT_AMT decimal(18, 3) ,'+
    '	STKRT_MNY decimal(18, 3) ,'+
    '	STKRT_TAX decimal(18, 3) ,'+
    '	SALE_AMT decimal(18, 3) ,'+
    '	SALE_RTL decimal(18, 3) ,'+
    '	SALE_AGO decimal(18, 3) ,'+
    '	SALE_MNY decimal(18, 3) ,'+
    '	SALE_TAX decimal(18, 3) ,'+
    '	SALE_CST decimal(18, 3) ,'+
    '	COST_PRICE decimal(18, 6) ,'+
    '	SALE_PRF decimal(18, 3) ,'+
    '	SALRT_AMT decimal(18, 3) ,'+
    '	SALRT_MNY decimal(18, 3) ,'+
    '	SALRT_TAX decimal(18, 3) ,'+
    '	SALRT_CST decimal(18, 3) ,'+
    '	DBIN_AMT decimal(18, 3) ,'+
    '	DBIN_MNY decimal(18, 3) ,'+
    '	DBIN_RTL decimal(18, 3) ,'+
    '	DBIN_CST decimal(18, 3) ,'+
    '	DBOUT_AMT decimal(18, 3) ,'+
    '	DBOUT_MNY decimal(18, 3) ,'+
    '	DBOUT_RTL decimal(18, 3) ,'+
    '	DBOUT_CST decimal(18, 3) ,'+
    '	CHANGE1_AMT decimal(18, 3) ,'+
    '	CHANGE1_MNY decimal(18, 3) ,'+
    '	CHANGE1_RTL decimal(18, 3) ,'+
    '	CHANGE1_CST decimal(18, 3) ,'+
    '	CHANGE2_AMT decimal(18, 3) ,'+
    '	CHANGE2_MNY decimal(18, 3) ,'+
    '	CHANGE2_RTL decimal(18, 3) ,'+
    '	CHANGE2_CST decimal(18, 3) ,'+
    '	CHANGE3_AMT decimal(18, 3) ,'+
    '	CHANGE3_MNY decimal(18, 3) ,'+
    '	CHANGE3_RTL decimal(18, 3) ,'+
    '	CHANGE3_CST decimal(18, 3) ,'+
    '	CHANGE4_AMT decimal(18, 3) ,'+
    '	CHANGE4_MNY decimal(18, 3) ,'+
    '	CHANGE4_RTL decimal(18, 3) ,'+
    '	CHANGE4_CST decimal(18, 3) ,'+
    '	CHANGE5_AMT decimal(18, 3) ,'+
    '	CHANGE5_MNY decimal(18, 3) ,'+
    '	CHANGE5_RTL decimal(18, 3) ,'+
    '	CHANGE5_CST decimal(18, 3) ,'+
    '	BAL_AMT decimal(18, 3) ,'+
    '	BAL_MNY decimal(18, 3) ,'+
    '	BAL_RTL decimal(18, 3) ,'+
    '	BAL_CST decimal(18, 3) '+
    ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  end;
end;
procedure TfrmCostCalc.CreateTempTable;
var
  SQL:string;
  rs:TZQuery;
begin
  case Factor.iDbType of
  0:tempTableName := '#TMP_GOODS_DAYS';
  5:begin tempTableName := 'TMP_GOODS_DAYS';end;
  1:begin tempTableName := 'TMP_GOODS_DAYS';end;
  4:tempTableName := 'session.TMP_GOODS_DAYS';
  end;
  tempTableName1 := tempTableName+'_1';
  tempTableName2 := tempTableName+'_2';
  //生数据临时表
  case Factor.iDbType of
  0:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select OBJECT_ID(N''tempdb..'+tempTableName+''')';
      Factor.Open(rs);
      if rs.Fields[0].AsString = '' then
         begin
         Factor.ExecSQL(GetTmpSQL(tempTableName));
         Factor.ExecSQL('CREATE INDEX IX_'+tempTableName+'_CREA_DATE ON '+tempTableName+'(TENANT_ID,CREA_DATE)');
         end;
    finally
      rs.Free;
    end;
  end;
  4:begin
    Factor.ExecSQL(GetTmpSQL(tempTableName));
    end;
  1:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select count(*) from user_tables where table_name='''+tempTableName+'''';
      Factor.Open(rs);
      if rs.Fields[0].asInteger = 0 then
         begin
           Factor.ExecSQL(GetTmpSQL(tempTableName));
           Factor.ExecSQL('CREATE INDEX IX_'+tempTableName+'_CREA_DATE ON '+tempTableName+'(TENANT_ID,CREA_DATE)');
         end;
    finally
      rs.Free;
    end;
  end;
  5:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select count(*) from sqlite_master where type=''table'' and name='''+tempTableName+'''';
      Factor.Open(rs);
      if rs.Fields[0].asInteger = 0 then
         begin
           Factor.ExecSQL(GetTmpSQL(tempTableName));
           Factor.ExecSQL('CREATE INDEX IX_'+tempTableName+'_CREA_DATE ON '+tempTableName+'(TENANT_ID,CREA_DATE)');
         end;
    finally
      rs.Free;
    end;
  end;
  end;

  case Factor.iDbType of
  0,1:Factor.ExecSQL('truncate table '+tempTableName);
  5:Factor.ExecSQL('delete from '+tempTableName);
  end;
  //生成中间计算表
  CreateTable(tempTableName1);
  CreateTable(tempTableName2);
end;

procedure TfrmCostCalc.CalcAcctMth;
var
  i,b,bl:integer;
  SQL:string;
  e:TDate;
begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    b := 1;
    while true do
    begin
      if pt>0 then PrgPercent := (b*100 div pt) div 3+80;
      if reck_flag=1 then
         begin
           if isfirst and (b=1) then
              begin
                e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
                if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
              end
           else
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
         end
      else
         begin
           e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day));
           if e<=(bDate+b-1) then
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
         end;
      //计算账户账款
      SQL := 'delete from RCK_ACCT_MONTH where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH>='+formatDatetime('YYYYMM',e);
      Factor.ExecSQL(SQL);
      SQL :=
        'insert into RCK_ACCT_MONTH('+
        'TENANT_ID,SHOP_ID,MONTH,ACCOUNT_ID,'+
        'ORG_MNY,IN_MNY,OUT_MNY,BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY,COMM,TIME_STAMP '+
        ') '+
        'select '+
        'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMM',e)+',ACCOUNT_ID,'+
        'sum(ORG_MNY),sum(IN_MNY),sum(OUT_MNY),sum(ORG_MNY)+sum(IN_MNY)-sum(OUT_MNY),'+
        'sum(PAY_MNY),sum(RECV_MNY),sum(POS_MNY),sum(TRN_IN_MNY),sum(TRN_OUT_MNY),sum(PUSH_MNY),sum(IORO_IN_MNY),sum(IORO_OUT_MNY),'+
        '''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
        'from('+
        'select '+
        'B.TENANT_ID,B.SHOP_ID,B.ACCOUNT_ID,'+
        'isnull(A.BAL_MNY,0)+isnull(B.ORG_MNY,0) as ORG_MNY,0 as IN_MNY,0 as OUT_MNY,0 as BAL_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY '+
        'from ACC_ACCOUNT_INFO B left outer join (select * from RCK_ACCT_MONTH where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH='+formatDatetime('YYYYMM',incmonth(e,-1))+') A '+
        'on B.TENANT_ID=A.TENANT_ID and B.ACCOUNT_ID=A.ACCOUNT_ID where B.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+
        'union all '+
        'select '+
        'TENANT_ID,SHOP_ID,ACCOUNT_ID,'+
        '0 as ORG_MNY,IN_MNY,OUT_MNY,0 as BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY '+
        'from RCK_ACCT_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+' '+
        ') j group by TENANT_ID,SHOP_ID,ACCOUNT_ID';
      Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));

      if e>=eDate then break;
      b := b +round(e-(bDate+b))+1;
    end;
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;

procedure TfrmCostCalc.DBLock;
begin
  Factor.DBLock(true);
end;

procedure TfrmCostCalc.DBUnLock;
begin
  Factor.DBLock(false);
end;

procedure TfrmCostCalc.CalcAcctDay;
var
  i:integer;
  SQL,u:string;
begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    Factor.ExecSQL('delete from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate));
    for i:= 1 to pt do
      begin
        PrgPercent := (i*100 div pt) div 3+60;
        SQL :=
          'insert into RCK_ACCT_DAYS('+
          'TENANT_ID,SHOP_ID,CREA_DATE,ACCOUNT_ID,'+
          'ORG_MNY,IN_MNY,OUT_MNY,BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY,COMM,TIME_STAMP '+
          ') '+
          'select '+
          'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+',ACCOUNT_ID,'+
          'sum(ORG_MNY),sum(IN_MNY),sum(OUT_MNY),sum(ORG_MNY)+sum(IN_MNY)-sum(OUT_MNY),'+
          'sum(PAY_MNY),sum(RECV_MNY),sum(POS_MNY),sum(TRN_IN_MNY),sum(TRN_OUT_MNY),sum(PUSH_MNY),sum(IORO_IN_MNY),sum(IORO_OUT_MNY),'+
          '''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
          'from('+
          'select '+
          'B.TENANT_ID,B.SHOP_ID,B.ACCOUNT_ID,'+
          'isnull(A.BAL_MNY,0)+isnull(B.ORG_MNY,0) as ORG_MNY,0 as IN_MNY,0 as OUT_MNY,0 as BAL_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY '+
          'from ACC_ACCOUNT_INFO B left outer join (select * from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+') A '+
          'on B.TENANT_ID=A.TENANT_ID and B.ACCOUNT_ID=A.ACCOUNT_ID where B.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+
          'union all '+
          'select '+
          'A.TENANT_ID,B.SHOP_ID,A.ACCOUNT_ID,'+
          '0 as ORG_MNY,A.IN_MNY,A.OUT_MNY,0 as BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY '+
          'from VIW_ACCT_DAYS A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.ACCOUNT_ID=B.ACCOUNT_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
          ') j group by TENANT_ID,SHOP_ID,ACCOUNT_ID';
        Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));
      end;
    if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    Raise;
  end;
end;

procedure TfrmCostCalc.CheckForRck;
var
  rs:TZQuery;
begin
  if not (flag in [1,2]) then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
      'select B.SHOP_NAME,A.PRINT_DATE from STO_PRINTORDER A,CA_SHOP_INFO B '+
      'where A.TENANT_ID=:TENANT_ID and A.PRINT_DATE>:PRINT_DATE and A.TENANT_ID=B.TENANT_ID and A.CHK_DATE is null';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('PRINT_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',bDate));
    Factor.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create(rs.Fields[0].asString+'门店'+rs.Fields[1].asString+'号的盘点没有审核,不能结账.');
  finally
    rs.Free;
  end;
end;

class function TfrmCostCalc.TryCalcDayAcct(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 3;
        Label2.Caption := '计算台账:'+formatDatetime('YYYY-MM-DD',date());
        Show;
        btnStartClick(nil);
      finally
        free;
      end;
    end;
end;

class function TfrmCostCalc.TryCalcDayGods(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 4;
        Label2.Caption := '计算台账:'+formatDatetime('YYYY-MM-DD',date());
        Show;
        btnStartClick(nil);
      finally
        free;
      end;
    end;
end;

class function TfrmCostCalc.TryCalcMthAcct(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 5;
        Label2.Caption := '计算台账:'+formatDatetime('YYYY-MM-DD',date());
        Show;
        btnStartClick(nil);
      finally
        free;
      end;
    end;
end;

class function TfrmCostCalc.TryCalcMthGods(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 6;
        Label2.Caption := '计算台账:'+formatDatetime('YYYY-MM-DD',date());
        Show;
        btnStartClick(nil);
      finally
        free;
      end;
    end;
end;

procedure TfrmCostCalc.AutoPosReck;
var
  rs,sv:TZQuery;
  Str:string;
  AObj:TRecord_;
begin
  if not (flag in [1,2]) then Exit;
  rs := TZQuery.Create(nil);
  sv := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
    Str :=
    'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,''1'' as CLSE_TYPE,'+
    'sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2 group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE'+
    ' union all '+
    'select TENANT_ID,SHOP_ID,CREA_USER,CREA_DATE as CLSE_DATE,''2'' as CLSE_TYPE,'+
    'sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_IC_GLIDE A'+
    ' where IC_GLIDE_TYPE = ''1'' and TENANT_ID=:TENANT_ID and CREA_DATE>=:D1 and CREA_DATE<=:D2 group by TENANT_ID,SHOP_ID,CREA_USER,CREA_DATE';

    Str :=
    'select A.* from ('+Str+') A where not exists('+
    'select * from ACC_CLOSE_FORDAY where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.CLSE_DATE'+
    ')';
    rs.SQL.Text := Str;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',bDate));
    rs.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',eDate));
    Factor.Open(rs);
    sv.Delta := rs.Delta;
    rs.First;
    while not rs.Eof do
      begin
        sv.Append;
        AObj.ReadFromDataSet(rs); 
        AObj.WriteToDataSet(sv);
        sv.Post;
        rs.Next;
      end;
    Factor.UpdateBatch(sv,'TCloseForDay');
  finally
    AObj.free;
    sv.Free;
    rs.Free;
  end;
end;

procedure TfrmCostCalc.PrepareDataForAcct;
var
  SQL:string;
  rs:TZQuery;
  myDate:TDate;
begin
  myDate := cDate;
  if (calc_flag=2) then myDate := bDate;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from VIW_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
       myDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
//    else
//       myDate := cDate;
    if (myDate>eDate) and (eDate=0) then eDate := myDate;
    
    mDate := myDate;
    uDate := mDate;
    
    //每次计算都算到最后一天
    if mDate<eDate then mDate := eDate;
    if round(mDate-cDate)>pt then pt := round(mDate-cDate);
  finally
    rs.Free;
  end;
end;

procedure TfrmCostCalc.CalcSpz;
var
  i:integer;
begin
//  for i:=1 to pt do
//  begin
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
     PrgPercent := PrgPercent+3;
     Factor.ExecSQL('delete from RCK_C_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate)+'');
     Factor.ExecSQL(
     'insert into RCK_C_GOODS_DAYS(TENANT_ID,SHOP_ID,DEPT_ID,GUIDE_USER,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
     'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,COMM,TIME_STAMP) '+
     'select A.TENANT_ID,A.SHOP_ID,case when A.DEPT_ID is null then ''#'' else A.DEPT_ID end,'+
     'case when A.GUIDE_USER is null then ''#'' else A.GUIDE_USER end,'+
     'case when A.CLIENT_ID is null then ''#'' else A.CLIENT_ID end,A.SALES_DATE,A.GODS_ID,A.BATCH_NO, '+
     'sum(A.CALC_AMOUNT) as SALE_AMT,sum(A.CALC_MONEY+A.AGIO_MONEY) as SALE_RTL,sum(A.AGIO_MONEY) as SALE_AGO,sum(A.NOTAX_MONEY) as SALE_MNY,sum(A.TAX_MONEY) as SALE_TAX, '+
     'sum(round(A.CALC_AMOUNT*B.COST_PRICE,2)) as SALE_CST,max(B.COST_PRICE) as COST_PRICE, '+
     'sum(A.NOTAX_MONEY-round(A.CALC_AMOUNT*B.COST_PRICE,2)) as SALE_PRF, '+
     'sum(case when A.SALES_TYPE=3 then A.CALC_AMOUNT else 0 end) as SALRT_AMT, '+
     'sum(case when A.SALES_TYPE=3 then A.NOTAX_MONEY else 0 end) as SALRT_MNY, '+
     'sum(case when A.SALES_TYPE=3 then A.TAX_MONEY else 0 end) as SALRT_TAX, '+
     'sum(case when A.SALES_TYPE=3 then round(A.CALC_AMOUNT*B.COST_PRICE,2) else 0 end) as SALRT_CST, '+
     '''00'','+GetTimeStamp(Factor.iDbType)+' from VIW_SALESDATA A,RCK_GOODS_DAYS B '+
     'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_DATE=B.CREA_DATE and A.GODS_ID=B.GODS_ID and A.BATCH_NO=B.BATCH_NO and '+
     'A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.SALES_DATE>'+formatDatetime('YYYYMMDD',cDate)+' '+
     'group by A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.GUIDE_USER,A.CLIENT_ID,A.SALES_DATE,A.GODS_ID,A.BATCH_NO'
     );
     if Factor.iDbType <> 5 then Factor.CommitTrans;
  except
     if Factor.iDbType <> 5 then Factor.RollbackTrans;
     Raise;
  end;
//  end;

end;

procedure TfrmCostCalc.CalcAnaly;
var
  SQL,id,v,v1,v2,sid:string;
  safe,reas,daySale,w:integer;
  LRate,HRate:real;
  rs:TZQuery;
begin
  PrgPercent := 0;
  safe := StrtoIntDef(ShopGlobal.GetParameter('SAFE_DAY'),7);
  reas := StrtoIntDef(ShopGlobal.GetParameter('REAS_DAY'),14);
  daySale := StrtoIntDef(ShopGlobal.GetParameter('DAY_SALE_STAND'),90);
  SQL :=
    'insert into PUB_GOODS_INSHOP(TENANT_ID,GODS_ID,SHOP_ID,COMM,TIME_STAMP)'+
    'select TENANT_ID,GODS_ID,SHOP_ID,''00'','+GetTimeStamp(Factor.iDbType)+' from VIW_GOODSPRICE A where TENANT_ID='+inttostr(Global.TENANT_ID)+' and '+
    'not Exists(select * from PUB_GOODS_INSHOP where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and SHOP_ID=A.SHOP_ID)';
  Factor.ExecSQL(SQL);
  PrgPercent := 10;
  //算近期销量
  SQL :=
    'update PUB_GOODS_INSHOP set NEAR_SALE_AMT=(select sum(CALC_AMOUNT) from VIW_SALESDATA where SALES_DATE>='+formatDatetime('YYYYMMDD',Date-safe-1)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+
    ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID) '+
    'where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  PrgPercent := 20;
  //日均销量测算
  SQL :=
    'update PUB_GOODS_INSHOP set DAY_SALE_AMT=(select round(sum(CALC_AMOUNT)*1.0/'+GetDayDiff(Factor.iDbType,'min(SALES_DATE)','max(SALES_DATE)')+',3) from VIW_SALESDATA where SALES_DATE>='+formatDatetime('YYYYMMDD',Date-daySale-1)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+
    ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID) '+
    'where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  PrgPercent := 30;
  //安全库存及合理库存测算
  SQL :=
    'update PUB_GOODS_INSHOP set LOWER_AMOUNT=DAY_SALE_AMT*'+inttostr(safe)+',UPPER_AMOUNT=DAY_SALE_AMT*'+inttostr(reas)+' '+
    'where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  PrgPercent := 40;
  //本月销量
  SQL :=
    'update PUB_GOODS_INSHOP set MTH_SALE_AMT=(select sum(CALC_AMOUNT) from VIW_SALESDATA where SALES_DATE>='+formatDatetime('YYYYMM01',Date)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+
    ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID) '+
    'where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  PrgPercent := 50;
  sid := ShopGlobal.GetParameter('SMT_RATE');
  if sid='' then sid := '2';
  //计算存销比
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE like ''SMT_RATE_%'' and COMM not in (''02'',''12'')';
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        id := copy(rs.Fields[0].AsString,1,36);
        v := trim(copy(rs.Fields[0].AsString,38,555));
        w := pos('-',v);
        v1:= copy(v,1,w-1);
        v2:= copy(v,w+1,20);
        SQL := 'update PUB_GOODS_INSHOP set LOWER_RATE='+v1+',UPPER_RATE='+v2+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and exists(select * from VIW_GOODSINFO where TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID and SORT_ID'+sid+'='''+id+''')';
        Factor.ExecSQL(SQL);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
  PrgPercent := 60;
end;

class function TfrmCostCalc.CalcAnalyLister(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 3;
        Caption := '安全参数测算';
        Label2.Caption := '安全参数测算';
        Show;
        Update;
        CalcAnaly;
      finally
        free;
      end;
    end;
end;

procedure TfrmCostCalc.SetPrgPercent(const Value: integer);
begin
  FPrgPercent := Value;
  RzProgressBar1.Percent := Value;
  RzProgressBar1.Update;
end;

procedure TfrmCostCalc.TruncTable(tb: string);
begin
  case Factor.iDbType of
  0,1:Factor.ExecSQL('truncate table '+tb);
  4:Factor.ExecSQL(GetTmpSQL(tb)); 
  5:Factor.ExecSQL('delete from '+tb);
  end;
end;

procedure TfrmCostCalc.CreateTable(tb: string);
var rs:TZQuery;
begin
  case Factor.iDbType of
  0:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select OBJECT_ID(N''tempdb..'+tb+''')';
      Factor.Open(rs);
      if rs.Fields[0].AsString = '' then
         begin
         Factor.ExecSQL(GetTmpSQL(tb));
         end;
    finally
      rs.Free;
    end;
  end;
  4:begin
    Factor.ExecSQL(GetTmpSQL(tb));
    end;
  1:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select count(*) from user_tables where table_name='''+tb+'''';
      Factor.Open(rs);
      if rs.Fields[0].asInteger = 0 then
         begin
           Factor.ExecSQL(GetTmpSQL(tb));
         end;
    finally
      rs.Free;
    end;
  end;
  5:begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select count(*) from sqlite_master where type=''table'' and name='''+tb+'''';
      Factor.Open(rs);
      if rs.Fields[0].asInteger = 0 then
         begin
           Factor.ExecSQL(GetTmpSQL(tb));
         end;
    finally
      rs.Free;
    end;
  end;
  end;

  case Factor.iDbType of
  0,1:Factor.ExecSQL('truncate table '+tb);
  5:Factor.ExecSQL('delete from '+tb);
  end;
end;

end.
