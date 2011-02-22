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
    procedure btnStartClick(Sender: TObject);
  private
    Fid: string;
    Fcflag: integer;
    FcDate: TDate;
    procedure Setid(const Value: string);
    procedure Setcflag(const Value: integer);
    procedure SetcDate(const Value: TDate);
    { Private declarations }
  public
    { Public declarations }
    pt,pc:integer;
    reck_flag:integer;
    reck_day:integer;
    //核算前准备
    procedure Prepare;
    procedure PrepareDataForRck;
    //日加权移动平均成本核算
    procedure Calc1;
    //月加权移动平均成本核算
    procedure Calc2;
    //核算单位
    property cid:string read Fid write Setid;
    //核算方式 1日加权移动平均 2月加权移平均 3先进先出
    property calc_flag:integer read Fcflag write Setcflag;
    //期初日期
    property cDate:TDate read FcDate write SetcDate;
    class function StartCalc(Owner:TForm):boolean;
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
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),sum(COST_PRICE),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
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
        'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
        '0,0,'+
        'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST,'+
        '0,0,0,0,0,0,0,0,'+
        '0,0,0,0,0,0,0,0,0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0,'+
        '0,0,0,0 '+
        'from RCK_GOODS_DAYS A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
      Factor.ExecSQL(SQL);

      //计算成本
      SQL :=
        'update RCK_GOODS_DAYS set '+
        'COST_PRICE=(select case when sum(BAL_AMT+STOCK_AMT)<>0 then sum(ORG_CST+STOCK_MNY)/sum(BAL_AMT+STOCK_AMT) else 0 end '+
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
        'BAL_CST=ORG_CST+STOCK_CST-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
        'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) '+
        'where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
      Factor.ExecSQL(SQL);
    end;
end;

procedure TfrmCostCalc.Prepare;
var
  rs:TZQuery;
begin
  reck_flag := StrtoIntDef(ShopGlobal.GetParameter('RECK_OPTION'),1);
  reck_day := StrtoIntDef(ShopGlobal.GetParameter('RECK_DAY'),28);
  calc_flag := StrtoIntDef(ShopGlobal.GetParameter('CALC_FLAG'),2);
  RzProgressBar1.Percent := 0;
  pc := 0;
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
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
       end;
    pt := round(Date()-cDate)+1;
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
  //数据准备
  PrepareDataForRck;
  //计算成本
  case calc_flag of
  1:Calc1;
  2:Calc2;
  end;
  ModalResult := MROK;
end;

class function TfrmCostCalc.StartCalc(Owner: TForm): boolean;
begin
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        result :=(ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmCostCalc.Calc2;
var
  rcktmp,midtmp,sql:string;
  edate:TDate;
begin
  try
    rcktmp := '#rcktmp';
    midtmp := '#midtmp';
    sql := 'create table '+rcktmp+'(gods_id varchar(50),batch_no varchar(20),IS_PRESENT int,amt decimal(18, 3),mny decimal(18, 3),prc decimal(18, 6))';
    Factor.ExecSQL(sql);
  except
    Factor.ExecSQL('drop table '+rcktmp);
    Raise;
  end;
  try
    sql := 'create table '+midtmp+'(gods_id varchar(50),batch_no varchar(20),IS_PRESENT int,amt decimal(18, 3),mny decimal(18, 3),prc decimal(18, 6))';
    Factor.ExecSQL(sql);
  except
    Factor.ExecSQL('drop table '+midtmp);
    Raise;
  end;
  try
  //插入期初
  Factor.ExecSQL('insert into '+rcktmp+' select GODS_ID,BATCH_NO,0,sum(RCK_AMOUNT),sum(RCK_AMONEY+MDI_AMONEY),case when sum(RCK_AMOUNT)=0 then 0 else sum(RCK_AMONEY+MDI_AMONEY)/sum(RCK_AMOUNT) end from STO_PRINTDATA A,STO_PRINTORDER B '+
      'where A.COMP_ID=B.COMP_ID and A.PRINT_ID=B.PRINT_ID and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and B.PRINT_ID='''+formatDatetime('YYYYMMDD',cDate)+''' group by GODS_ID,BATCH_NO');
  cDate := cDate + 1;
  while cDate<date() do
    begin
      if reck_flag=1 then
         eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(cDate,2))+'01')-1
      else
         eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(cDate,1))+formatfloat('00',reck_day));
      pc := pc + round(eDate-cDate);
      RzProgressBar1.Percent := (pc*100) div pt;
      //算成本
      Factor.ExecSQL('delete from '+midtmp);
      Factor.ExecSQL('insert into '+midtmp+' '+
      'select GODS_ID,BATCH_NO,0,sum(amt),sum(mny),case when sum(amt)=0 then 0 else sum(mny)/sum(amt) end from ('+
      'select GODS_ID,BATCH_NO,amt,mny from '+rcktmp+' '+
      'union all '+
      'select GODS_ID,BATCH_NO,sum(IN_AMOUNT),sum(IN_NOTAX) from VIW_STOCKDATA '+
      'where STOCK_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and STOCK_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or COMP_ID='''+cid+''') group by GODS_ID,BATCH_NO)'+
      'j group by GODS_ID,BATCH_NO');

      //更新捆绑拆卸单成本
      Factor.ExecSQL('update STO_COMBDATA set COST_PRICE=0 from STO_COMBDATA A,STO_COMBORDER B where A.COMP_ID=B.COMP_ID and A.COMB_ID=B.COMB_ID and B.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');
      Factor.ExecSQL('update STO_COMBDATA set COST_PRICE=c.prc from STO_COMBDATA A,STO_COMBORDER B,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.BATCH_NO=C.BATCH_NO and A.COMP_ID=B.COMP_ID and A.COMB_ID=B.COMB_ID and B.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');
      Factor.ExecSQL('update STO_COMBORDER set COST_PRICE=0 from STO_COMBORDER A where A.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and A.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');
      Factor.ExecSQL('update STO_COMBORDER set COST_PRICE=c.prc from STO_COMBORDER A,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and A.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');

      //计算捆绑单成本
      Factor.ExecSQL('update STO_COMBORDER set COST_PRICE=(D.MNY/A.CALC_AMOUNT) from STO_COMBORDER A,'+
                     '(select C.COMP_ID,C.COMB_ID,sum(round(B.COST_PRICE*B.CALC_AMOUNT,2)) as MNY from STO_COMBDATA B,STO_COMBORDER C where B.COMP_ID=C.COMP_ID and B.COMB_ID=C.COMB_ID and C.COMB_TYPE=1 and C.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and C.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (C.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or C.COMP_ID='''+cid+''') '+
                     'group by C.COMP_ID,C.COMB_ID) D where A.COMP_ID=D.COMP_ID and A.COMB_ID=D.COMB_ID and A.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and A.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');
      //计算拆卸成本
      Factor.ExecSQL('update STO_COMBDATA set COST_PRICE=round(E.CALC_AMOUNT*E.COST_PRICE,2)/ D.AMT from STO_COMBDATA A,STO_COMBORDER E,'+
                     '(select C.COMP_ID,C.COMB_ID,sum(B.CALC_AMOUNT) as AMT from STO_COMBDATA B,STO_COMBORDER C where B.COMP_ID=C.COMP_ID and B.COMB_ID=C.COMB_ID and C.COMB_TYPE=2 and C.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and C.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (C.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or C.COMP_ID='''+cid+''') '+
                     'group by C.COMP_ID,C.COMB_ID) D where A.COMP_ID=E.COMP_ID and A.COMB_ID=E.COMB_ID and A.COMP_ID=D.COMP_ID and A.COMB_ID=D.COMB_ID and E.COMB_TYPE=2 and E.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and E.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (E.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or E.COMP_ID='''+cid+''')');


      //开始计算结余
      Factor.ExecSQL(
         'insert into '+midtmp+'(gods_id,BATCH_NO,IS_PRESENT,amt,mny) '+
         'select A.GODS_ID,A.BATCH_NO,0,sum(case when B.COMB_TYPE=2 then A.CALC_AMOUNT else -A.CALC_AMOUNT end),sum(round(case when B.COMB_TYPE=2 then A.CALC_AMOUNT*A.COST_PRICE else -A.CALC_AMOUNT*A.COST_PRICE end,3)) '+
         'from STO_COMBDATA A,STO_COMBORDER B '+
         'where A.COMP_ID=B.COMP_ID and A.COMB_ID=B.COMB_ID and B.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') group by A.GODS_ID,A.BATCH_NO '+
         'union all '+
         'select A.GODS_ID,A.BATCH_NO,0,sum(case when A.COMB_TYPE=1 then A.CALC_AMOUNT else -A.CALC_AMOUNT end),sum(round(case when A.COMB_TYPE=1 then A.CALC_AMOUNT*A.COST_PRICE else -A.CALC_AMOUNT*A.COST_PRICE end,2)) from STO_COMBORDER A '+
         'where A.COMB_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and A.COMB_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') group by A.GODS_ID,A.BATCH_NO '
      );

      Factor.ExecSQL('delete from '+rcktmp);
      Factor.ExecSQL('insert into '+rcktmp+ ' select gods_id,BATCH_NO,0,sum(amt),sum(mny),case when sum(amt)=0 then 0 else sum(mny)/sum(amt) end from '+midtmp+' group by gods_id,BATCH_NO');
      Factor.ExecSQL('delete from '+midtmp);
      Factor.ExecSQL('insert into '+midtmp+ ' select * from '+rcktmp);

      //更新调拨成本
      Factor.ExecSQL('update STK_STOCKDATA set CALC_MONEY=0,APRICE=0,AMONEY=0,AGIO_MONEY=0,AGIO_RATE=100 from STK_STOCKDATA A,STK_STOCKORDER B where A.COMP_ID=B.COMP_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.STOCK_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and STOCK_TYPE=2');
      Factor.ExecSQL('update STK_STOCKDATA set CALC_MONEY=CALC_AMOUNT*c.prc,AMONEY=CALC_AMOUNT*c.prc,APRICE=(CALC_AMOUNT*c.prc)/AMOUNT from STK_STOCKDATA A,STK_STOCKORDER B,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.COMP_ID=B.COMP_ID and A.STOCK_ID=B.STOCK_ID and B.STOCK_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.STOCK_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and STOCK_TYPE=2');
      Factor.ExecSQL('update SAL_SALESDATA set COST_PRICE=0,CALC_MONEY=0,APRICE=0,AMONEY=0,AGIO_MONEY=0,AGIO_RATE=100 from SAL_SALESDATA A,SAL_SALESORDER B where A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and SALES_TYPE=2');
      Factor.ExecSQL('update SAL_SALESDATA set COST_PRICE=c.prc,CALC_MONEY=CALC_AMOUNT*c.prc,AMONEY=CALC_AMOUNT*c.prc,APRICE=(CALC_AMOUNT*c.prc)/AMOUNT from SAL_SALESDATA A,SAL_SALESORDER B,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and SALES_TYPE=2');
      //更新销售成本
      Factor.ExecSQL('update SAL_SALESDATA set COST_PRICE=0 from SAL_SALESDATA A,SAL_SALESORDER B where A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and SALES_TYPE in (1,3,4)');
      Factor.ExecSQL('update SAL_SALESDATA set COST_PRICE=c.prc from SAL_SALESDATA A,SAL_SALESORDER B,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') and SALES_TYPE in (1,3,4)');
      //更新调整成本
      Factor.ExecSQL('update STO_CHANGEDATA set COST_PRICE=0 from STO_CHANGEDATA A,STO_CHANGEORDER B where A.COMP_ID=B.COMP_ID and A.CHANGE_ID=B.CHANGE_ID and B.CHANGE_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.CHANGE_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');
      Factor.ExecSQL('update STO_CHANGEDATA set COST_PRICE=c.prc from STO_CHANGEDATA A,STO_CHANGEORDER B,'+midtmp+' C where A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO and A.COMP_ID=B.COMP_ID and A.CHANGE_ID=B.CHANGE_ID and B.CHANGE_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.CHANGE_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''')');

      //开始计算结余
      Factor.ExecSQL(
         'insert into '+midtmp+'(gods_id,BATCH_NO,IS_PRESENT,amt,mny) '+
         'select GODS_ID,BATCH_NO,0,sum(MOVEIN_AMOUNT),sum(MOVEIN_NOTAX) from VIW_MOVEINDATA where MOVE_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and MOVE_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or COMP_ID='''+cid+''') group by GODS_ID,BATCH_NO '+
         'union all '+
         'select A.GODS_ID,A.BATCH_NO,0,-sum(A.CALC_AMOUNT),-sum(round(A.CALC_AMOUNT*A.COST_PRICE,2)) from SAL_SALESDATA A,SAL_SALESORDER B where A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') group by A.GODS_ID,A.BATCH_NO '+
         'union all '+
         'select A.GODS_ID,A.BATCH_NO,0,sum(case when B.CHANGE_TYPE=1 then A.CALC_AMOUNT else -A.CALC_AMOUNT end),sum(round(case when B.CHANGE_TYPE=1 then A.CALC_AMOUNT*A.COST_PRICE else -A.CALC_AMOUNT*A.COST_PRICE end,2)) '+
         'from STO_CHANGEDATA A,STO_CHANGEORDER B '+
         'where A.COMP_ID=B.COMP_ID and A.CHANGE_ID=B.CHANGE_ID and B.CHANGE_DATE>='''+formatDatetime('YYYY-MM-DD',cDate)+''' and B.CHANGE_DATE<='''+formatDatetime('YYYY-MM-DD',eDate)+''' and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+cid+''' and COMP_TYPE=2) or A.COMP_ID='''+cid+''') group by A.GODS_ID,A.BATCH_NO '
      );

      Factor.ExecSQL('delete from '+rcktmp);
      Factor.ExecSQL('insert into '+rcktmp+ ' select gods_id,BATCH_NO,0,sum(amt),sum(mny),case when sum(amt)=0 then 0 else sum(mny)/sum(amt) end from '+midtmp+' group by gods_id,BATCH_NO');
      cDate := eDate + 1;
    end;
    Factor.ExecSQL('update STO_STORAGE set COST_PRICE=b.prc,AMONEY=A.AMOUNT*b.prc from STO_STORAGE A,'+rcktmp+' B where A.GODS_ID=B.GODS_ID and A.IS_PRESENT=B.IS_PRESENT and A.BATCH_NO=B.BATCH_NO');
  finally
    Factor.ExecSQL('drop table '+rcktmp);
    Factor.ExecSQL('drop table '+midtmp);
  end;
end;

procedure TfrmCostCalc.PrepareDataForRck;
var
  SQL:string;
begin
  SQL := 'delete from TMP_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
  Factor.ExecSQL(SQL);
  SQL :=
    'insert into TMP_GOODS_DAYS('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
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
    'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
    'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),case when sum(SALE_AMT)<>0 then sum(SALE_CST)/sum(SALE_AMT) else 0 end,sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
    'sum(DBIN_AMT),sum(round(DBIN_AMT*B.NEW_INPRICE,2)),sum(DBIN_RTL),sum(DBIN_CST),'+
    'sum(DBOUT_AMT),sum(round(DBOUT_AMT*B.NEW_INPRICE,2)),sum(DBOUT_RTL),sum(DBOUT_CST),'+
    'sum(CHANGE1_AMT),sum(round(CHANGE1_AMT*B.NEW_INPRICE,2)),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
    'sum(CHANGE2_AMT),sum(round(CHANGE2_AMT*B.NEW_INPRICE,2)),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
    'sum(CHANGE3_AMT),sum(round(CHANGE3_AMT*B.NEW_INPRICE,2)),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
    'sum(CHANGE4_AMT),sum(round(CHANGE4_AMT*B.NEW_INPRICE,2)),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
    'sum(CHANGE5_AMT),sum(round(CHANGE5_AMT*B.NEW_INPRICE,2)),sum(CHANGE5_RTL),sum(CHANGE5_CST) '+
    'from VIW_GOODS_DAYS A,VIW_GOODSPRICEEXT B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and B.SHOP_ID='''+inttostr(Global.TENANT_ID)+'0001'' and A.CREA_DATE>'+formatDatetime('YYYYMMDD',cDate)+' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO ';
  Factor.ExecSQL(SQL);
end;

end.
