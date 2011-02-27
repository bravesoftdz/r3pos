unit ufrmCostCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus,ZDataSet, RzButton, RzPrgres, StdCtrls,
  ExtCtrls;

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
  public
    { Public declarations }
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    //核算前准备
    procedure Prepare;
    procedure PrepareDataForRck;
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
        'from TMP_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'union all '+
        'select '+
        'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
        'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
        'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
        '0,0,0,0,0,0,0,0,'+
        '0,0,0,0,0,0,0,0,0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0 '+
        'from RCK_GOODS_DAYS A  Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
        'where (A.BAL_AMT<>0 or A.BAL_CST<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
      Factor.ExecSQL(SQL);

      //计算成本
      SQL :=
        'update RCK_GOODS_DAYS set '+
        'COST_PRICE=(select case when sum(ORG_AMT+STOCK_AMT)<>0 then round(sum(ORG_CST+STOCK_MNY)/(sum(ORG_AMT+STOCK_AMT)*1.0),6) else 0 end '+
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
  //读取参数
  Prepare;
  if (calc_flag=2) and (flag=1) then Raise Exception.Create('月移动加权平均算法不支持日结账');
  Factor.DBLock(true);
  try
    //数据准备
    PrepareDataForRck;
    //计算成本
    case calc_flag of
    0:Calc0;
    1:Calc1;
    2:Calc2;
    end;
    CalcMth;
    ClseRck;
  finally
    Factor.DBLock(false);
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
    if reck_flag=1 then
       begin
         if isfirst and (b=1) then
            begin
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
              if e<=bDate+1 then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
            end
         else
            e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
       end
    else
       e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
    if (bDate+b)<=uDate then //只计算有数据部份
    begin
    //准备期初
    SQL :=
          'insert into TMP_GOODS_DAYS('+
          'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
          'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST)'+
          'select '+
          'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+b)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
          'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST '+
          'from RCK_GOODS_DAYS A where (A.BAL_AMT<>0 or A.BAL_CST<>0) and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b-1)+' ';
    Factor.ExecSQL(SQL);

    //计算成本
    SQL :=
      'update TMP_GOODS_DAYS set '+
      'COST_PRICE=(select case when sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))<>0 then round(sum(isnull(ORG_CST,0)+isnull(STOCK_MNY,0))/(sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))*1.0),6) else 0 end '+
      'from TMP_GOODS_DAYS A where A.TENANT_ID=TMP_GOODS_DAYS.TENANT_ID and A.GODS_ID=TMP_GOODS_DAYS.GODS_ID and A.BATCH_NO=TMP_GOODS_DAYS.BATCH_NO and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+') '+
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
          'from TMP_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+' '+
          'union all '+
          'select '+
          'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
          'A.NEW_INPRICE,A.NEW_OUTPRICE,'+
          'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
          '0,0,0,0,0,0,0,0,'+
          '0,0,0,0,0,0,0,0,0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0,'+
          '0,0,0,0 '+
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
  SQL := 'delete from TMP_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  SQL :=
    'insert into TMP_GOODS_DAYS('+
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
    'from VIW_GOODS_DAYS A,VIW_GOODSPRICEEXT B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and B.SHOP_ID='''+inttostr(Global.TENANT_ID)+'0001'' and A.CREA_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO ';
  Factor.ExecSQL(SQL);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from TMP_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
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
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),round(case when sum(SALE_AMT)=0 then 0 else sum(SALE_CST)/(sum(SALE_AMT)*1.0) end,6),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
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
        'from TMP_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'union all '+
        'select '+
        'A.TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
        'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
        'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
        '0,0,0,0,0,0,0,0,'+
        '0,0,0,0,0,0,0,0,0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0 '+
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
    if reck_flag=1 then
       begin
         if isfirst and (b=1) then
            begin
              e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
              if e<=cDate+1 then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
            end
         else
            e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
       end
    else
       e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
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
      'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
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
      'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end)*max(NEW_INPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_AMT else 0 end)*max(NEW_OUTPRICE),sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',bDate+bl)+' then BAL_CST else 0 end),''00'' as COMM,'+GetTimeStamp(Factor.iDbType)+' '+
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
      '0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,0,0,0,0,'+
      '0,0,0,0,0,0,0,0,0,0,0,0,'+
      'SALE_AMT as PRIOR_YEAR_AMT,SALE_MNY as PRIOR_YEAR_MNY,SALE_TAX as PRIOR_YEAR_TAX,SALE_CST as PRIOR_YEAR_CST,0 as PRIOR_MONTH_AMT,0 as PRIOR_MONTH_MNY,0 as PRIOR_MONTH_TAX,0 as PRIOR_MONTH_CST,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0 '+
      'from RCK_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',incmonth(bDate+b,-12))+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',incmonth(e,-12))+' '+
      'union all '+
      'select '+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      '0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,0,0,0,0,'+
      '0,0,0,0,0,0,0,0,0,0,0,0,'+
      '0 as PRIOR_YEAR_AMT,0 as PRIOR_YEAR_MNY,0 as PRIOR_YEAR_TAX,0 as PRIOR_YEAR_CST,SALE_AMT as PRIOR_MONTH_AMT,SALE_MNY as PRIOR_MONTH_MNY,SALE_TAX as PRIOR_MONTH_TAX,SALE_CST as PRIOR_MONTH_CST,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0,'+
      '0,0,0,0 '+
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
    for i:=1 to pt do
       begin
         if (cDate+i)<=eDate then //只有日结内时间要生成记录已生成日台账部份
         begin
         Factor.ExecSQL('insert into RCK_DAYS_CLOSE(TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,CHK_DATE,CHK_USER,COMM,TIME_STAMP) '+
                        'select TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+','''+Global.UserID+''',null,null,''00'','+GetTimeStamp(Factor.iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)
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
                  if e<=bDate+1 then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
                end
             else
                e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
           end
        else
           e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
        SQL :=
           'insert into RCK_MONTH_CLOSE(TENANT_ID,SHOP_ID,MONTH,BEGIN_DATE,END_DATE,CREA_USER,CHK_DATE,CHK_USER,COMM,TIME_STAMP) '+
           'select TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMM',e)+','''+formatDatetime('YYYY-MM-DD',bDate+b)+''','''+formatDatetime('YYYY-MM-DD',e)+''','''+Global.UserID+''',null,null,''00'','+GetTimeStamp(Factor.iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(Global.TENANT_ID);
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

end.
