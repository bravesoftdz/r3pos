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
    procedure Setid(const Value: string);
    procedure Setcflag(const Value: integer);
    procedure SetcDate(const Value: TDate);
    procedure SeteDate(const Value: TDate);
    procedure Setflag(const Value: integer);
    procedure SetbDate(const Value: TDate);
    procedure SetmDate(const Value: TDate);
    procedure SetuDate(const Value: TDate);
    { Private declarations }
  protected
    procedure DBLock;
    procedure DBUnLock;
  public
    { Public declarations }
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    tempTableName:string;
    //核算前准备
    procedure Prepare;
    procedure CreateTempTable;
    procedure PrepareDataForRck;
    procedure CheckForRck;
    //自动缴银结账
    procedure AutoPosReck;
    //移动平均成本核算<按开单时的平均加计算>
    procedure Calc0;
    //日加权移动平均成本核算
    procedure Calc1;
    //月加权移动平均成本核算
    procedure Calc2;
    //生成月账
    procedure CalcMth;
    //生成结账记录
    procedure ClseRck;
    //计算账户日台账
    procedure CalcAcctDay;
    //计算账户月台账
    procedure CalcAcctMth;
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
    class function StartCalc(Owner:TForm):boolean;
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

  end;
implementation
uses uGlobal,uFnUtil,uShopGlobal,ObjCommon;
{$R *.dfm}

{ TfrmCostCalc }

procedure TfrmCostCalc.Calc1;
var
  i:integer;
  SQL:string;
begin
  Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate));
  for i:= 1 to pt do
    begin
      RzProgressBar1.Percent := (i*100 div pt) div 3+5;
      //生成数据
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
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
        'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
        'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),max(COST_PRICE),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
        'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
        'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
        'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
        'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
        'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
        'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
        'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
        '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST,''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
        'from('+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
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
        'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'union all '+
        'select '+
        'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
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
        'where (A.BAL_AMT<>0 or A.BAL_CST<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
      Factor.ExecSQL(SQL);

      //计算成本
      SQL :=
        'update RCK_GOODS_DAYS set '+
        'COST_PRICE=(select case when sum(ORG_AMT+STOCK_AMT)<>0 then round(cast(sum(ORG_CST+STOCK_MNY) as decimal(18,3)/(cast(sum(ORG_AMT+STOCK_AMT) as decimal(18,3))*1.0),6) else 0 end '+
        'from RCK_GOODS_DAYS A where A.TENANT_ID=RCK_GOODS_DAYS.TENANT_ID and A.GODS_ID=RCK_GOODS_DAYS.GODS_ID and A.BATCH_NO=RCK_GOODS_DAYS.BATCH_NO and A.CREA_DATE=RCK_GOODS_DAYS.CREA_DATE) '+
        'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
      Factor.ExecSQL(SQL);
      
      //计算结余
      SQL :=
        'update RCK_GOODS_DAYS set '+
        'SALE_CST=round(SALE_AMT*COST_PRICE,2),'+
        'SALE_PRF=SALE_MNY - round(SALE_AMT*COST_PRICE,2),'+
        'DBIN_CST=round(DBIN_AMT*COST_PRICE,2),'+
        'DBOUT_CST=round(DBOUT_AMT*COST_PRICE,2),'+
        'CHANGE1_CST=round(CHANGE1_AMT*COST_PRICE,2),'+
        'CHANGE2_CST=round(CHANGE2_AMT*COST_PRICE,2),'+
        'CHANGE3_CST=round(CHANGE3_AMT*COST_PRICE,2),'+
        'CHANGE4_CST=round(CHANGE4_AMT*COST_PRICE,2),'+
        'CHANGE5_CST=round(CHANGE5_AMT*COST_PRICE,2),'+
        'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
        'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
        'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
        'BAL_CST=ORG_CST+STOCK_MNY-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
        'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) '+
        'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
      Factor.ExecSQL(SQL);
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
  RzProgressBar1.Percent := 0;
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
  Label11.Caption := '读取参数...';
  Label11.Update;
  //读取参数
  Prepare;
  if (calc_flag=2) and (flag=1) then Raise Exception.Create('月移动加权平均算法不支持日结账');
  DBLock;
  try
    Label11.Caption := '核算前检测数据...';
    Label11.Update;
    RzProgressBar1.Percent := 1;
    CheckForRck;
    CreateTempTable;
    Label11.Caption := '准备核算数据...';
    Label11.Update;
    //数据准备
    CheckForRck;
    PrepareDataForRck;
    Label11.Caption := '正在核算成本...';
    Label11.Update;
    RzProgressBar1.Percent := 5;
    //计算成本
    case calc_flag of
    0:Calc0;
    1:Calc1;
    2:Calc2;
    end;
    Label11.Caption := '正在计算商品月台账...';
    Label11.Update;
    CalcMth;
    Label11.Caption := '正在计算账户日台账...';
    Label11.Update;
    AutoPosReck;
    CalcAcctDay;
    Label11.Caption := '正在计算账户月台账...';
    Label11.Update;
    CalcAcctMth;

    Label11.Caption := '输出数据中...';
    Label11.Update;
    ClseRck;
    RzProgressBar1.Percent := 100;
  finally
    DBUnLock;
  end;
  ModalResult := MROK;
end;

class function TfrmCostCalc.StartCalc(Owner: TForm): boolean;
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

procedure TfrmCostCalc.Calc2;
var
  i,b:integer;
  SQL:string;
  e:TDate;
begin
  b := 1;
  while true do
  begin
    if pt>0 then RzProgressBar1.Percent := (b*100 div pt) div 3+5;
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
    if (bDate+b)<=uDate then //只计算有数据部份
    begin
    //准备期初
    SQL :=
          'insert into '+tempTableName+'('+
          'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
          'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST)'+
          'select '+
          'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+b)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
          'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST '+
          'from RCK_GOODS_DAYS A where (A.BAL_AMT<>0 or A.BAL_CST<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b-1)+' ';
    Factor.ExecSQL(SQL);

    //计算成本
    SQL :=
      'update '+tempTableName+' set '+
      'COST_PRICE=(select case when sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))<>0 then round(cast(sum(isnull(ORG_CST,0)+isnull(STOCK_MNY,0)) as decimal(18,3))/(cast(sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0)) as decimal(18,3))*1.0),6) else 0 end '+
      'from '+tempTableName+' A where A.TENANT_ID='+tempTableName+'.TENANT_ID and A.GODS_ID='+tempTableName+'.GODS_ID and A.BATCH_NO='+tempTableName+'.BATCH_NO and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+') '+
      'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',e)+'';
    Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));
    end;
    Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',bDate+b-1));
    for i:= b to pt do
      begin
        if (bDate+i)>e then continue;
        //生成数据
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
          'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
          'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
          'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
          'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
          'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),max(COST_PRICE),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
          'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
          'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
          'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
          'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
          'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
          'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
          'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
          '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST,''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
          'from('+
          'select '+
          'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
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
          'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+' '+
          'union all '+
          'select '+
          'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
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
          'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
          'where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i-1)+' '+
          ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
        Factor.ExecSQL(SQL);

        //计算结余
        SQL :=
          'update RCK_GOODS_DAYS set '+
          'SALE_CST=round(SALE_AMT*COST_PRICE,2),'+
          'SALE_PRF=SALE_MNY - round(SALE_AMT*COST_PRICE,2),'+
          'DBIN_CST=round(DBIN_AMT*COST_PRICE,2),'+
          'DBOUT_CST=round(DBOUT_AMT*COST_PRICE,2),'+
          'CHANGE1_CST=round(CHANGE1_AMT*COST_PRICE,2),'+
          'CHANGE2_CST=round(CHANGE2_AMT*COST_PRICE,2),'+
          'CHANGE3_CST=round(CHANGE3_AMT*COST_PRICE,2),'+
          'CHANGE4_CST=round(CHANGE4_AMT*COST_PRICE,2),'+
          'CHANGE5_CST=round(CHANGE5_AMT*COST_PRICE,2),'+
          'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
          'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
          'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
          'BAL_CST=ORG_CST+STOCK_MNY-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
          'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) '+
          'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+'';
        Factor.ExecSQL(SQL);
      end;
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
  SQL := 'delete from '+tempTableName+' where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
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
    'max(B.NEW_INPRICE),max(B.NEW_OUTPRICE),'+
    '0,0,0,0,'+
    'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
    'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),case when sum(SALE_AMT)<>0 then sum(SALE_CST)/(sum(SALE_AMT)*1.0) else 0 end,sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
    'sum(DBIN_AMT),sum(round(DBIN_AMT*B.NEW_INPRICE,2)),sum(DBIN_RTL),sum(DBIN_CST),'+
    'sum(DBOUT_AMT),sum(round(DBOUT_AMT*B.NEW_INPRICE,2)),sum(DBOUT_RTL),sum(DBOUT_CST),'+
    'sum(CHANGE1_AMT),sum(round(CHANGE1_AMT*B.NEW_INPRICE,2)),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
    'sum(CHANGE2_AMT),sum(round(CHANGE2_AMT*B.NEW_INPRICE,2)),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
    'sum(CHANGE3_AMT),sum(round(CHANGE3_AMT*B.NEW_INPRICE,2)),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
    'sum(CHANGE4_AMT),sum(round(CHANGE4_AMT*B.NEW_INPRICE,2)),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
    'sum(CHANGE5_AMT),sum(round(CHANGE5_AMT*B.NEW_INPRICE,2)),sum(CHANGE5_RTL),sum(CHANGE5_CST) '+
    'from VIW_GOODS_DAYS A,VIW_GOODSPRICEEXT B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and B.SHOP_ID='''+inttostr(Global.TENANT_ID)+'0001'' and A.CREA_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO ';
  Factor.ExecSQL(SQL);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from '+tempTableName+' where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
       myDate := fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
       myDate := cDate;
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
  i:integer;
  SQL,u:string;
begin
  Factor.ExecSQL('delete from RCK_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate));
  for i:= 1 to pt do
    begin
      RzProgressBar1.Percent := (i*100 div pt) div 3+5;
      //生成数据
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
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
        'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
        'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),'+
        'round(case when sum(SALE_AMT)<>0 then cast(sum(SALE_CST) as decimal(18,3))/(cast(sum(SALE_AMT) as decimal(18,3))*1.0) else 0 end,6),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
        'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
        'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
        'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
        'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
        'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
        'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
        'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
        '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST,''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
        'from('+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
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
        'from '+tempTableName+' A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'union all '+
        'select '+
        'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
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
        'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
      Factor.ExecSQL(SQL);

      //计算结余
      SQL :=
        'update RCK_GOODS_DAYS set '+
        'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
        'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
        'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
        'BAL_CST=ORG_CST+STOCK_MNY-SALE_CST+DBIN_CST-DBOUT_CST+'+
        'CHANGE1_CST+CHANGE2_CST+CHANGE3_CST+CHANGE4_CST+CHANGE5_CST '+
        'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
      Factor.ExecSQL(SQL);
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
        Label2.Caption := '结账月份:'+formatDatetime('YYYY-MM-DD',eDate);
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
  while true do
  begin
    if pt>0 then RzProgressBar1.Percent := (b*100 div pt) div 3+35;
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
  if flag=0 then Exit;
  Factor.BeginTrans;
  try
    if pt>0 then RzProgressBar1.Percent := (b*100 div pt) div 3+90;
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

procedure TfrmCostCalc.CreateTempTable;
var
  SQL:string;
begin
  case Factor.iDbType of
  0:tempTableName := '#TMP_GOODS_DAYS';
  1,5:begin tempTableName := 'TMP_GOODS_DAYS';exit;end;
  4:tempTableName := 'session.TMP_GOODS_DAYS';
  end;
  case Factor.iDbType of
  0:begin
  SQL :=
  'if OBJECT_ID(N''tempdb..'+tempTableName+''') is null '+
  'CREATE TABLE '+tempTableName+' ('+
  '	TENANT_ID int NOT NULL ,'+
  '	SHOP_ID varchar (11) NOT NULL ,'+
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
  '	CHANGE5_CST decimal(18, 3) NULL '+
  ')'
  end;
  4:begin
  SQL :=
  'declare global temporary table '+tempTableName+' ('+
  '	TENANT_ID int NOT NULL ,'+
  '	SHOP_ID varchar (11) NOT NULL ,'+
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
  '	CHANGE5_CST decimal(18, 3) '+
  ') NOT LOGGED WITH REPLACE '
  end;
  end;
  Factor.ExecSQL(SQL);
  if Factor.iDbType=0 then Factor.ExecSQL('truncate table '+tempTableName);
end;

procedure TfrmCostCalc.CalcAcctMth;
var
  i,b,bl:integer;
  SQL:string;
  e:TDate;
begin
  b := 1;
  while true do
  begin
    if pt>0 then RzProgressBar1.Percent := (b*100 div pt) div 3+80;
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
  Factor.ExecSQL('delete from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate));
  for i:= 1 to pt do
    begin
      RzProgressBar1.Percent := (i*100 div pt) div 3+60;
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
        '0 as ORG_MNY,A.IN_MNY,B.OUT_MNY,0 as BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY '+
        'from VIW_ACCT_DAYS A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.ACCOUNT_ID=B.ACCOUNT_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        ') j group by TENANT_ID,SHOP_ID,ACCOUNT_ID';
      Factor.ExecSQL(ParseSQL(Factor.iDbType,SQL));
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
  rs := TZQuery.Create(nil);
  sv := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
    Str :=
    'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,'+
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
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2 '+
    ' and not exists('+
    ' select * from ACC_CLOSE_FORDAY  where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.SALES_DATE'+
    ' )group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE';
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

end.
