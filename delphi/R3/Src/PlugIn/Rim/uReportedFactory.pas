unit uReportedFactory;

interface

uses
  SysUtils,uIdFactor,ADODB,ufnUtil,ComObj,uSyncComm;

procedure CallSync(LocalFactor,RemoteFactor:TIdFactor);

implementation

function CheckReckonine(CompId,custid,cid:string;LocalFactor,RemoteFactor:TIdFactor;var ID:string;var m:string):boolean;
 function GetMxId:string;
 var rs:TADODataSet;
 begin
   rs := TADODataSet.Create(nil);
   try
     rs.CommandText := 'select BAL_TIME from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''00'' and TERM_ID='''+compid+'''';
     RemoteFactor.Open(rs);
     result := rs.Fields[0].AsString;
     if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM,BAL_TIME) values('''+cid+''','''+custid+''',''00'','''+compid+''',''000000000000000'',null)');
   finally
     rs.Free;
   end;
end;
var
  rs:TADODataSet;
  mx:string;
begin
  result := false;
  rs := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    rs.CommandText := 'select PRINT_ID from STO_PRINTORDER where COMP_ID='''+CompId+''' and UPD_TIME>'''+mx+''' and STATUS=3 order by UPD_TIME';
    LocalFactor.Open(rs);
    if rs.IsEmpty then Exit;
//    if (formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.Fields[0].asString)+1)
//       =
//       formatDatetime('YYYYMM',IncMonth(date(),1))+'01') then //今天是否月底
//       begin
         m := copy(rs.Fields[0].asString,1,6);
//       end
//    else
//       begin
//         m := formatDatetime('YYYYMM',IncMonth(fnTime.fnStrtoDate(rs.Fields[0].asString),-1))
//       end;
    ID := rs.Fields[0].asString;
    result := true;
  finally
    rs.Free;
  end;
end;
                                                            //门店ID,企业ID，许可证号
procedure SendSalesDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string; DefUnit: Integer);
  function GetMxId:string;
  var rs:TADODataSet;
  begin
    rs := TADODataSet.Create(nil);
    try
     rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''01'' and TERM_ID='''+compid+'''';
     RemoteFactor.Open(rs);
      result := rs.Fields[0].AsString;
      if rs.IsEmpty then
        RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''01'','''+compid+''',''000000000000000'')');
    finally
      rs.Free;
    end;
  end;
  //根据传入的字符判断是是否使用|禁用
  function GetIsUse(ReMark: string): string;
  begin
    if trim(ReMark)='00' then result:='0'
    else result:='1';
  end;
  //2010.01.19 Add 零
  function GetSaleDateList(li: TADODataSet): Boolean;
  begin
    result:=false;
    li.Close;
    li.CommandText :=
      'select distinct SALES_DATE from ('+
      'select distinct SALES_DATE from POS_SALESORDER A,POS_SALESDATA B,PUB_GOODSINFO C where B.GODS_ID=C.GODS_ID and C.SYS_FLAG=1 and A.COMP_ID='''+compid+''' and A.COMM<>''11'' and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID '+
      'union all '+
      'select distinct SALES_DATE from SAL_SALESORDER A,SAL_SALESDATA B,PUB_GOODSINFO C where B.GODS_ID=C.GODS_ID and C.SYS_FLAG=1 and A.COMP_ID='''+compid+''' and A.COMM<>''11'' and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID '+
      ') J ';
     LocalFactor.Open(li);
     result:=li.Active;
  end;
  //2010.01.19 Add 
  function GetSALEList(rs: TADODataSet; SaleDate: string): Boolean;
  begin
    result:=false;
    rs.Close;
    rs.CommandText := 'select '''+custid+''' as CUST_ID,'''+SaleDate+''' as SALE_DATE,B.GODS_ISN as ITEM_ID,'+
      'AMOUNT/case '+inttostr(DefUnit)+' when 0 then 1.0 when 1 then B.SMALLTO_CALC when 2 then B.BIGTO_CALC else 1.0 end as QTY_ORD,'+
      'convert(varchar(8),getdate(),112) as UPD_DATE,convert(varchar(8),getdate(),108) as UPD_TIME,AMONEY AMT from ('+
      'select GODS_ID,sum(AMOUNT) AMOUNT,sum(AMONEY) AMONEY from ('+
      'select GODS_ID,sum(CALC_AMOUNT) AMOUNT,sum(CALC_MONEY) AMONEY from POS_SALESORDER A,POS_SALESDATA B where A.COMP_ID='''+compid+''' and A.SALES_DATE='''+SaleDate+''' and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID group by GODS_ID '+
      'union all '+
      'select GODS_ID,sum(CALC_AMOUNT) AMOUNT,sum(CALC_MONEY) AMONEY from SAL_SALESORDER A,SAL_SALESDATA B where A.COMP_ID='''+compid+''' and A.SALES_DATE='''+SaleDate+''' and A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID group by GODS_ID '+
      ') S group by GODS_ID) P,PUB_GOODSINFO B where P.GODS_ID=B.GODS_ID and B.SYS_FLAG=1';
    LocalFactor.Open(rs);
    result:=rs.Active;
  end;
var
  IsRun:Boolean;  //判断一天执行一次。
  li,rs:TADODataSet;  //数据循环使用
  sv,SvMain:TADODataSet;
  SumQTY_ORD,SumAMT: Real; //合计数量
  SaleNo,SaleDate,CurDate,mx,w,Str:string;
begin
  IsRun:=true;  //判断是否执行过
  rs := TADODataSet.Create(nil);
  li :=TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  SvMain := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      WriteDebug('报单号'+mx);
      rs.Close;
      rs.CommandText := 'select J.*,B.CARD_CODE from (select top 100 * from POS_SALESORDER where COMP_ID='''+CompId+''' and SALES_ID>'''+mx+''' order by SALES_ID ) J left outer join BAS_CUSTOMER B on J.CUST_ID=B.CUST_ID order by J.SALES_ID';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      WriteDebug('记录数'+inttostr(rs.RecordCount));
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,R3_NUM,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME from RIM_RETAIL_INFO where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_0_'+rs.FieldbyName('sales_id').AsString;
            WriteDebug('写单号'+sv.Fields[0].AsString);
            //CONSUMER_CARD_ID
            sv.Fields[1].AsString := rs.FieldbyName('card_code').AsString;
            //CONSUMER_ID
            sv.Fields[2].AsString := rs.FieldbyName('cust_id').AsString;
            //CUST_ID
            sv.Fields[3].AsString := custid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('sales_id').AsString;
            //COM_ID
            sv.Fields[6].AsString := cid;
            //SCORE
            sv.Fields[7].AsFloat := rs.FieldbyName('add_integral').AsFloat;
            //SCORE_DATE
            sv.Fields[8].AsString := rs.FieldbyName('sales_date').AsString;
            //VIP_RTL_CARD_ID
            sv.Fields[9].AsString := rs.FieldbyName('card_code').AsString;
            //PUH_DATE
            sv.Fields[10].AsString := rs.FieldbyName('sales_date').AsString;
            //PUH_TIME         
            sv.Fields[11].AsString := rs.FieldbyName('sales_time').AsString;
            if sv.Fields[11].AsString='' then sv.Fields[11].AsString := '00:00:00';
            //CRT_USER_ID
            sv.Fields[12].AsString := rs.FieldbyName('shroff').AsString;
            //TYPE
            sv.Fields[13].AsString := '01';
            //UPDATE_TIME
            sv.Fields[14].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('SALES_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME,D.SALES_DATE from POS_SALESDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C,POS_SALESORDER D where A.COMP_ID=D.COMP_ID and A.SALES_ID=D.SALES_ID and A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.SALES_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;                                                                                        { 2011.04.03 Add 零售单明细增加: TREND_ID  }
        sv.CommandText := 'select RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID from RIM_RETAIL_DETAIL where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_0_'+rs.FieldbyName('sales_id').AsString;
            //LINE_NUM
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[4].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[4].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[4].AsString := '04'
            else
               sv.Fields[4].AsString := '02';
            //UNIT_COST
            sv.Fields[5].AsFloat := rs.FieldbyName('cost_price').AsFloat;
            //RETAIL_PRICE
            sv.Fields[6].AsFloat := rs.FieldbyName('aprice').AsFloat;
            //QTY_SALE
            sv.Fields[7].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[8].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT
            sv.Fields[9].AsFloat := rs.FieldbyName('calc_money').AsFloat;
            //Note
            sv.Fields[10].AsString := rs.FieldbyName('remark').AsString;
            //PUH_DATE
            sv.Fields[11].AsString := rs.FieldbyName('sales_date').AsString;
            //TREND_ID (流向)  2011.04.03 Add 零售单明细增加: TREND_ID 
            sv.Fields[12].AsString := rs.FieldbyName('TREND_ID').AsString;
            sv.Post;
            rs.Next;
          end;
          RemoteFactor.UpdateBatch(sv);

        //2010.01.19 Add 零售户商品日帐数据 上报 RIM_CUST_DAY （每天每一种商品的汇总数量插入）;
        if GetSaleDateList(li) and (IsRun) then // 返回当前有多少天的销售数据没有上报[以天为单位上报]
        begin
          SaleDate:=trim(li.fieldbyName('SALES_DATE').AsString); //销售日期
          li.First;
          while not li.Eof do  //循环新零售单没上报则需要重新汇总
          begin
            {====重新汇总插入前先删除====}
            //2010.02.24 AM Add 删除当天时候已生成过汇总数据[先删明细表在删主表]
            //第一步: 先删除当天的零售单数据：
            RemoteFactor.ExecSQL('delete from RIM_RETAIL_CO_LINE '+
                                 ' where  exists(select A.CO_NUM from RIM_RETAIL_CO A where A.COM_ID='''+cid+''' and A.TERM_ID='''+compid+''' and A.CUST_ID='''+custid+''' and A.PUH_DATE='''+SaleDate+''' and A.CO_NUM=RIM_RETAIL_CO_LINE.CO_NUM) ');
            RemoteFactor.ExecSQL('delete from RIM_RETAIL_CO where COM_ID='''+cid+''' and TERM_ID='''+compid+''' and CUST_ID='''+custid+''' and  PUH_DATE='''+SaleDate+'''  ');

            //第二步: 插入当天的零售单数据：
            //字段: CUST_ID,SALE_DATE,ITEM_ID,QTY_SALE,UPD_DATE,UPD_TIME,AMONEY
            if GetSALEList(rs, SaleDate) then  //返回XX天[日期:20110102]的零售数据汇总[按每门店、商品汇总数量和金额]
            begin
              SaleNo:=SaleDate+'_'+custid+'_'+compid;  //销售单号: 日期+'_'+公司ID+'_'+门店ID
              SumQTY_ORD:=0;
              SumAMT:=0;
              SvMain.Close; //每个门店每天虚拟一条主表记录
              SvMain.CommandText:='Select CO_NUM,CUST_ID,COM_ID,QTY_SUM,AMT_SUM,TERM_ID,PUH_DATE,STATUS,UPD_DATE,UPD_TIME From RIM_RETAIL_CO Where 0=1 ';
              RemoteFactor.Open(SvMain);               
              sv.Close;
              sv.CommandText:='Select CO_NUM,ITEM_ID,QTY_ORD,AMT From RIM_RETAIL_CO_LINE where 0=1 ';  //备注： COM_ID,PUH_DATE, [没有对应字段]
              RemoteFactor.Open(sv);
              rs.First;
              while not rs.Eof do //零售汇总的记录循环
              begin
                sv.Append;
                //单据号     [CO_NUM]
                sv.FieldByName('CO_NUM').AsString:=SaleNo;  
                //sv.Fields[1].AsString:=cid;       //公司内码   [COM_ID]
                //sv.Fields[2].AsString:=SaleDate;  //购买日期 [PUH_DATE]
                //商品内码   [ITEM_ID]
                sv.FieldByName('ITEM_ID').AsString:=rs.fieldbyName('ITEM_ID').AsString;
                //销售数量:  [QTY_ORD]                
                sv.FieldByName('QTY_ORD').AsFloat:=rs.FieldByName('QTY_ORD').AsFloat;
                //销售金额:  [AMT]
                sv.FieldByName('AMT').AsFloat:=rs.FieldByName('AMT').AsFloat;
                sv.Post;  
                SumQTY_ORD:=SumQTY_ORD+rs.FieldByName('QTY_ORD').AsFloat;  //循环累计数量
                SumAMT:=SumAMT+rs.FieldByName('AMT').AsFloat;    //循环累计金额
                rs.Next;
              end;
              //虚拟生成主表
              SvMain.Edit;       
              SvMain.FieldByName('CO_NUM').AsString:=SaleNo;
              SvMain.FieldByName('CUST_ID').AsString:=custid;
              SvMain.FieldByName('COM_ID').AsString:=cid;
              SvMain.FieldByName('QTY_SUM').AsFloat:=SumQTY_ORD;  //主表数量累计
              SvMain.FieldByName('AMT_SUM').AsFloat:=SumAMT;      //主表数量累计
              SvMain.FieldByName('TERM_ID').AsString:=compid;
              SvMain.FieldByName('PUH_DATE').AsString:=SaleDate;
              SvMain.FieldByName('STATUS').AsString:='01';
              SvMain.FieldByName('UPD_DATE').AsString:=FormatDatetime('YYYYMMDD',Date());
              SvMain.FieldByName('UPD_TIME').AsString:=TimetoStr(time());
              SvMain.Post;  
              RemoteFactor.UpdateBatch(SvMain);  //提交数据
              RemoteFactor.UpdateBatch(sv);      //提交数据
            end;
            li.Next;  //循环每天销售的数据
          end;
          IsRun:=False;  //循环过一次后，将标记位置False;
        end;

        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''01'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update POS_SALESORDER set COMM=''11'' where COMP_ID='''+CompId+''' and SALES_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
        begin
          RemoteFactor.RollbackTrans;
          LocalFactor.RollbackTrans;
          sleep(1);
          RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
          Exit;
        end;
      end;
    end;
    sleep(1);

    {=========== 2010.01.19 Add 零售户库存 上报 [RIM_CUST_ITEM_SWHSE]、RIM_CUST_ITEM_WHSE 表 ============}
    CurDate:=FormatDatetime('YYYYMMDD',Date());  //取系统当前日期
    RemoteFactor.BeginTrans;
    try
      //第一步: 先删除已上报的数据:
      RemoteFactor.ExecSQL('delete from RIM_CUST_ITEM_SWHSE where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TERM_ID='''+compid+''' ');
      //第二步: 汇总库存插入 [RIM_CUST_ITEM_SWHSE] 
      rs.Close;
      rs.CommandText:='select ITEM_ID,Convert(varchar(8),getdate(),112) as UPD_DATE,Convert(varchar(8),getdate(),108) as UPD_TIME,sum(QTY) as QTY from '+
        ' (Select B.GODS_ISN as ITEM_ID,AMOUNT/case '+inttostr(DefUnit)+' when 0 then 1.0 when 1 then B.SMALLTO_CALC when 2 then B.BIGTO_CALC else 1.0 end as QTY '+
        ' From (Select GODS_ID,sum(AMOUNT) AMOUNT from STO_STORAGE where COMP_ID='''+CompId+''' group by GODS_ID) P,'+
        ' PUB_GOODSINFO B where P.GODS_ID=B.GODS_ID and B.SYS_FLAG=1) as tmp  '+
        ' group by ITEM_ID ';
      LocalFactor.Open(rs);
      sv.Close;                                                                  // NOTE: 备注
      sv.CommandText:='select CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB from RIM_CUST_ITEM_SWHSE where 1=0 ';
      RemoteFactor.Open(sv);
      rs.First;
      while not rs.Eof do  //对应字段值: custid --> CUST_ID
      begin
        //2010.02.24 AM 先删除存在记录[]
        sv.Append;
        //零售户内码:[CUST_ID]
        sv.Fields[0].AsString:=custid;
        //商品内码:  [ITEM_ID]
        sv.Fields[1].AsString:=rs.fieldbyName('ITEM_ID').AsString;
        //公司内码:  [COM_ID]
        sv.Fields[2].AsString:=cid;
        //门店内码:  [TERM_ID]
        sv.Fields[3].AsString:=compid;
        //库存量:    [QTY]
        sv.Fields[4].AsString:=rs.fieldbyName('QTY').AsString;
        //更新日期: [DATE1]
        sv.Fields[5].AsString:=rs.fieldbyName('UPD_DATE').AsString;
        //更新时间: [UPD_TIME]
        sv.Fields[6].AsString:=rs.fieldbyName('UPD_TIME').AsString;
        //是否使用: [IS_MRB]  [00:表示在使用  表示禁用]
         sv.Fields[7].AsString:='0';
        sv.Post; 
        rs.Next;
      end;
      RemoteFactor.UpdateBatch(sv);  //提交数据   

      //第三步: 先更新当前当天的中间库存中间表：[RIM_CUST_ITEM_SWHSE]:
      str:=' update RIM_CUST_ITEM_WHSE '+
           '  set QTY=nvl((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
           ' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' ';
      RemoteFactor.ExecSQL(Str);
      //第四步: 没有更新到记录插入中间表：[RIM_CUST_ITEM_WHSE]:
      str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
           ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE  A '+
           ' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and '+
           ' not Exists(select * from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
           ' group by COM_ID,CUST_ID,ITEM_ID ';
      RemoteFactor.ExecSQL(Str);
      RemoteFactor.CommitTrans;
    except
      on E:Exception do
      begin
        RemoteFactor.RollbackTrans;
        sleep(1);
        RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
        Exit;
      end;
    end;

    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报销售流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    li.Free;
    rs.Free;
    SvMain.Free;
  end;
  {
  RemoteFactor.ExecSQL('delete from RIM_CUST_ITEM_WHSE where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and DATE1='''+CurDate+''' ');
  Str:=' insert into RIM_CUST_ITEM_WHSE (COM_ID,CUST_ID,ITEM_ID,DATE1,IS_MRB,QTY) '+  // 6个字段
       ' select COM_ID,CUST_ID,ITEM_ID,DATE1,IS_MRB,sum(QTY) as QTY from RIM_CUST_ITEM_SWHSE '+
       ' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and DATE1='''+CurDate+''' '+
       ' group by COM_ID,CUST_ID,ITEM_ID,DATE1,IS_MRB  ';
  }

end;
procedure SendSaleBatchDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''02'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''02'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 * from SAL_SALESORDER where COMP_ID='''+CompId+''' and SALES_ID>'''+mx+''' order by SALES_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,R3_NUM,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME from RIM_RETAIL_INFO where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('sales_id').AsString;
            //CONSUMER_CARD_ID
            sv.Fields[1].AsString := '';
            //CONSUMER_ID
            sv.Fields[2].AsString := '';
            //CUST_ID
            sv.Fields[3].AsString := custid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('sales_id').AsString;
            //COM_ID
            sv.Fields[6].AsString := cid;
            //SCORE
            sv.Fields[7].AsString := '0';
            //SCORE_DATE
            sv.Fields[8].AsString := rs.FieldbyName('sales_date').AsString;
            //VIP_RTL_CARD_ID
            sv.Fields[9].AsString := '';
            //PUH_DATE
            sv.Fields[10].AsString := rs.FieldbyName('sales_date').AsString;
            //PUH_TIME         
            sv.Fields[11].AsString := '';
            //CRT_USER_ID
            sv.Fields[12].AsString := rs.FieldbyName('oper_user').AsString;
            //TYPE
            sv.Fields[13].AsString := '01';
            //UPDATE_TIME
            sv.Fields[14].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('SALES_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME,D.SALES_DATE from SAL_SALESDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C,SAL_SALESORDER D where A.COMP_ID=D.COMP_ID and A.SALES_ID=D.SALES_ID and A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.SALES_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE from RIM_RETAIL_DETAIL where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('sales_id').AsString;
            //LINE_NUM
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[4].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[4].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[4].AsString := '04'
            else
               sv.Fields[4].AsString := '02';
            //UNIT_COST
            sv.Fields[5].AsFloat := rs.FieldbyName('cost_price').AsFloat;
            //RETAIL_PRICE
            sv.Fields[6].AsFloat := rs.FieldbyName('aprice').AsFloat;
            //QTY_SALE
            sv.Fields[7].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[8].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT
            sv.Fields[9].AsFloat := rs.FieldbyName('calc_money').AsFloat;
            //Note
            sv.Fields[10].AsString := rs.FieldbyName('remark').AsString;
            //PUH_DATE
            sv.Fields[11].AsString := rs.FieldbyName('sales_date').AsString;
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''02'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update SAL_SALESORDER set COMM=''11'' where COMP_ID='''+CompId+''' and SALES_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报批发流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;

procedure SendSaleRetDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''03'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''03'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 * from SAL_RETUORDER where COMP_ID='''+CompId+''' and RETU_ID>'''+mx+''' order by RETU_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,R3_NUM,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME from RIM_RETAIL_INFO where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_2_'+rs.FieldbyName('retu_id').AsString;
            //CONSUMER_CARD_ID
            sv.Fields[1].AsString := '';
            //CONSUMER_ID
            sv.Fields[2].AsString := '';
            //CUST_ID
            sv.Fields[3].AsString := custid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('retu_id').AsString;
            //COM_ID
            sv.Fields[6].AsString := cid;
            //SCORE
            sv.Fields[7].AsString := '0';
            //SCORE_DATE
            sv.Fields[8].AsString := rs.FieldbyName('retu_date').AsString;
            //VIP_RTL_CARD_ID
            sv.Fields[9].AsString := '';
            //PUH_DATE
            sv.Fields[10].AsString := rs.FieldbyName('retu_date').AsString;
            //PUH_TIME         
            sv.Fields[11].AsString := '';
            //CRT_USER_ID
            sv.Fields[12].AsString := rs.FieldbyName('oper_user').AsString;
            //TYPE
            sv.Fields[13].AsString := '02';
            //UPDATE_TIME
            sv.Fields[14].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('RETU_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME,D.RETU_DATE from SAL_RETUDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C,SAL_RETUORDER D where A.COMP_ID=D.COMP_ID and A.RETU_ID=D.RETU_ID and A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.RETU_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE from RIM_RETAIL_DETAIL where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //RETAIL_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_2_'+rs.FieldbyName('retu_id').AsString;
            //LINE_NUM
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[4].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[4].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[4].AsString := '04'
            else
               sv.Fields[4].AsString := '02';
            //UNIT_COST
            sv.Fields[5].AsFloat := rs.FieldbyName('cost_price').AsFloat;
            //RETAIL_PRICE
            sv.Fields[6].AsFloat := rs.FieldbyName('aprice').AsFloat;
            //QTY_SALE
            sv.Fields[7].AsFloat := - rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[8].AsFloat := - rs.FieldbyName('calc_amount').AsFloat;
            //AMT
            sv.Fields[9].AsFloat := - rs.FieldbyName('calc_money').AsFloat;
            //Note
            sv.Fields[10].AsString := rs.FieldbyName('remark').AsString;
            //PUH_DATE
            sv.Fields[11].AsString := rs.FieldbyName('retu_date').AsString;
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''03'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update SAL_RETUORDER set COMM=''11'' where COMP_ID='''+CompId+''' and RETU_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报销售退货流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;
procedure SenddbDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select BAL_TIME from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''04'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM,BAL_TIME) values('''+cid+''','''+custid+''',''04'','''+compid+''',''000000000000000'',null)');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select * from SAL_WITHINORDER where COMP_ID='''+CompId+''' and STOR_ID is NOT NULL and UPD_TIME>'''+mx+''' order by UPD_TIME';
      //rs.CommandText := 'select * from SAL_WITHINORDER where COMP_ID='''+CompId+''' and STOR_ID is NOT NULL and not (CHK_DATE=''00000000'' or CHK_DATE is null) and COMM<>''11'' order by UPD_TIME';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,R3_NUM,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME from RIM_CUST_TRN where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //TRN_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_'+rs.FieldbyName('sales_id').AsString;
            //CUST_ID
            sv.Fields[1].AsString := custid;
            //TYPE
            sv.Fields[2].AsString := formatfloat('00',rs.FieldbyName('sales_type').AsInteger+1);
            //COM_ID
            sv.Fields[3].AsString := cid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('sales_id').AsString;
            //STATUS
            sv.Fields[6].AsString := cid;
            //CRT_DATE
            sv.Fields[7].AsString := rs.FieldbyName('sales_date').AsString;
            //CRT_USER_ID
            sv.Fields[8].AsString := rs.FieldbyName('oper_user').AsString;
            //POST_DATE
            sv.Fields[9].AsString := rs.FieldbyName('sales_date').AsString;
            //UPDATE_TIME
            sv.Fields[10].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('SALES_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.ExecSQL('delete from RIM_CUST_TRN_LINE where TRN_NUM in (select TRN_NUM from RIM_CUST_TRN where CUST_ID='''+custid+''' and TERM_ID='''+compid+''' and R3_NUM in ('+w+'))');
        RemoteFactor.ExecSQL('delete from RIM_CUST_TRN where CUST_ID='''+custid+''' and TERM_ID='''+compid+''' and R3_NUM in ('+w+')');
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME from SAL_WITHINDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C where A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.SALES_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,UM_ID,NOTE from RIM_CUST_TRN_LINE where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //TRN_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_'+rs.FieldbyName('sales_id').AsString;
            //LINE_NUM
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //QTY_TRN
            sv.Fields[4].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[5].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT_TRN
            sv.Fields[6].AsFloat := rs.FieldbyName('calc_money').AsFloat;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[7].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[7].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[7].AsString := '04'
            else
               sv.Fields[7].AsString := '02';
            //Note
            sv.Fields[8].AsString := rs.FieldbyName('remark').AsString;
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set BAL_TIME='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''04'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update SAL_WITHINORDER set COMM=''11'' where COMP_ID='''+CompId+''' and SALES_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报调拨流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;
function SendMonthReck(LocalFactor,RemoteFactor:TIdFactor;id,m,compid,cid,custid,custcode:string):boolean;
var d1,d2,MaxDate:string;
  rs,sv:TADODataSet;
begin
  result := false;
  d1 := m+'01';
  d2 := formatDatetime('YYYYMMDD',incMonth(fnTime.fnStrtoDate(m+'01'),1)-1);
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select max(PRINT_DATE) from STO_PRINTORDER where COMP_ID='''+compid+''' and PRINT_DATE<='''+d1+'''';
    LocalFactor.Open(rs);
    MaxDate := rs.Fields[0].AsString;
    if MaxDate='' then MaxDate := '00000000'; 
  finally
    rs.Free;
  end;
  WriteDebug('台帐月份'+m);
  RemoteFactor.BeginTrans;
  LocalFactor.BeginTrans;
  try
    rs := TADODataSet.Create(nil);
    sv := TADODataSet.Create(nil);
    try
      case RemoteFactor.iDbType of
      1: RemoteFactor.ExecSQL('delete RIM_CUST_MONTH where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and MONTH='''+m+''' and TERM_ID='''+compid+'''');
      4: RemoteFactor.ExecSQL('delete from RIM_CUST_MONTH where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and MONTH='''+m+''' and TERM_ID='''+compid+'''');
      end;
      sv.CommandText := 'select COM_ID,CUST_ID,ITEM_ID,MONTH,PRI3,PRI4,PRI_SOLD,AMT_GROSS_PROFIT_THEO,QTY_IOM,AMT_IOM,QTY_PURCH,'+
                        'AMT_PURCH,QTY_SOLD,AMT_SOLD_WITH_TAX,QTY_PROFIT,AMT_PROFIT,QTY_LOSS,AMT_LOSS,QTY_TAKE,AMT_TAKE,QTY_TRN_IN,'+
                        'AMT_TRN_IN,QTY_TRN_OUT,AMT_TRN_OUT,QTY_EOM,AMT_EOM,UNIT_COST,SUMCOST_SOLD,AMT_GROSS_PROFIT,AMT_PROFIT_COM,TERM_ID '+
                        'from RIM_CUST_MONTH where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and MONTH='''+m+'''';
      RemoteFactor.Open(sv);
      rs.CommandText := 'exec dt_rep1 '''+compid+''','''+d1+''','''+d2+''','''',2,'''','''+compid+''',1,''%'',1';
      WriteDebug('台帐SQL：'+rs.CommandText);
      LocalFactor.Open(rs);
      rs.First;
      while not rs.Eof do
        begin
          //WriteDebug('写行：'+inttostr(rs.recno));
          if not ((rs.FieldbyName('grp0').AsInteger = 0) and (rs.FieldbyName('grp2').AsInteger = 0)) then
             begin
               rs.Next;
               continue;
             end;
          sv.Append;
          //COM_ID
          sv.Fields[0].AsString := cid;
          //CUST_ID
          sv.Fields[1].AsString := custid;
          //ITEM_ID
          sv.Fields[2].AsString := rs.Fieldbyname('gods_isn').AsString;
          //MONTH
          sv.Fields[3].AsString := m;
          //PRI3
          sv.Fields[4].AsString := '0';
          //PRI4
          sv.Fields[5].AsString := '0';
          //PRI_SOLD
          sv.Fields[6].AsString := '0';
          //AMT_GROSS_PROFIT_THEO
          sv.Fields[7].AsString := '0';
          //QTY_IOM
          sv.Fields[8].asFloat := rs.Fieldbyname('org_amt').asFloat;
          //AMT_IOM
          sv.Fields[9].asFloat := rs.Fieldbyname('org_money').asFloat;
          //QTY_PURCH
          sv.Fields[10].asFloat := rs.Fieldbyname('stock_amt').asFloat;
          //AMT_PURCH
          sv.Fields[11].asFloat := rs.Fieldbyname('stock_money').asFloat;
          //QTY_SOLD
          sv.Fields[12].asFloat := rs.Fieldbyname('sales_amt').asFloat;
          //AMT_SOLD_WITH_TAX
          sv.Fields[13].asFloat := rs.Fieldbyname('rtl_money').asFloat;
          if rs.Fieldbyname('param01_amt').AsFloat > 0 then
          begin
          //QTY_PROFIT
          sv.Fields[14].asFloat := rs.Fieldbyname('param01_amt').asFloat;
          //AMT_PROFIT
          sv.Fields[15].asFloat := rs.Fieldbyname('param01_mny').asFloat;
          end
          else
          begin
          //QTY_LOSS
          sv.Fields[16].asFloat := -rs.Fieldbyname('param01_amt').AsFloat;
          //AMT_LOSS
          sv.Fields[17].asFloat := -rs.Fieldbyname('param01_mny').AsFloat;
          end;
          //QTY_TAKE
          sv.Fields[18].asFloat := rs.Fieldbyname('param02_amt').AsFloat+rs.Fieldbyname('param03_amt').AsFloat+rs.Fieldbyname('param04_amt').AsFloat+rs.Fieldbyname('param05_amt').AsFloat+rs.Fieldbyname('param06_amt').AsFloat;
          //AMT_TAKE
          sv.Fields[19].asFloat := rs.Fieldbyname('param02_mny').AsFloat+rs.Fieldbyname('param03_mny').AsFloat+rs.Fieldbyname('param04_mny').AsFloat+rs.Fieldbyname('param05_mny').AsFloat+rs.Fieldbyname('param06_mny').AsFloat;
          //QTY_TRN_IN
          sv.Fields[20].asFloat := rs.Fieldbyname('within_amt').asFloat;
          //AMT_TRN_IN
          sv.Fields[21].asFloat := rs.Fieldbyname('within_money').asFloat;
          //QTY_TRN_OUT
          sv.Fields[22].asFloat := rs.Fieldbyname('without_amt').asFloat;
          //AMT_TRN_OUT
          sv.Fields[23].asFloat := rs.Fieldbyname('without_money').asFloat;
          //QTY_EOM
          sv.Fields[24].asFloat := rs.Fieldbyname('bal_amt').asFloat;
          //AMT_EOM
          sv.Fields[25].asFloat := rs.Fieldbyname('bal_money').asFloat;
          //UNIT_COST
          if rs.Fieldbyname('sales_amt').AsFloat <> 0 then
             sv.Fields[26].AsString := formatfloat('#0.000000', rs.Fieldbyname('sales_money').AsFloat / rs.Fieldbyname('sales_amt').AsFloat)
          else
             sv.Fields[26].asFloat := 0;
          //SUMCOST_SOLD
          sv.Fields[27].asFloat := rs.Fieldbyname('sales_money').asFloat;
          //AMT_GROSS_PROFIT
          sv.Fields[28].asFloat := rs.Fieldbyname('ptf_money').asFloat;
          //AMT_PROFIT_COM 不用
          sv.Fields[29].AsString := '0';
          //TERM_ID
          sv.Fields[30].AsString := compid;
          sv.Post;
          rs.Next;
        end;
      WriteDebug('写完：'+inttostr(rs.recno));
      rs.Close;
      rs.CommandText := 'select UPD_TIME from STO_PRINTORDER where COMP_ID='''+compid+''' and PRINT_ID='''+id+'''';
      LocalFactor.Open(rs);
      WriteDebug('台帐时间标识：'+rs.Fields[0].AsString);
      RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+id+''',BAL_TIME='''+rs.Fields[0].AsString+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''00'' and TERM_ID='''+compid+'''');
      WriteDebug('写成功标识：'+'update RIM_R3_NUM set MAX_NUM='''+id+''',BAL_TIME='''+rs.Fields[0].AsString+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''00'' and TERM_ID='''+compid+'''');
      RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+maxDate+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''09'' and TERM_ID='''+compid+''' and MAX_NUM>'''+maxDate+'''');
      WriteDebug('写成功标识：'+'update RIM_R3_NUM set MAX_NUM='''+maxDate+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''09'' and TERM_ID='''+compid+''' and MAX_NUM>'''+maxDate+'''');
      RemoteFactor.UpdateBatch(sv);
    finally
      sv.Free;
      rs.Free;
    end;
    LocalFactor.ExecSQL('update STO_PRINTORDER set COMM=''11'' where COMP_ID='''+compid+''' and PRINT_ID='''+id+'''');
    RemoteFactor.CommitTrans;
    LocalFactor.CommitTrans;
    sleep(1);
    WriteDebug('写成功日志：'+'insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''02'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报'+m+'月台帐成功'',''auto'',''01'')');
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''02'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报'+m+'月台帐成功'',''auto'',''01'')');
    result := true;
  except
    on E:Exception do
       begin
         RemoteFactor.RollbackTrans;
         LocalFactor.RollbackTrans;
         sleep(1);
         WriteDebug('写错误：'+'insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''02'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
         RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''02'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','+ QuotedStr(E.Message)+',''auto'',''02'')');
       end;
  end;
end;


procedure SendStockDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''05'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''05'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 * from STK_STOCKORDER where COMP_ID='''+CompId+''' and STOCK_ID>'''+mx+''' order by STOCK_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,R3_NUM,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME from RIM_VOUCHER where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //VOUCHER_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_'+rs.FieldbyName('stock_id').AsString;
            //RETAIL_NUM
            sv.Fields[1].AsString := '';
            //CUST_ID
            sv.Fields[2].AsString := custid;
            //COM_ID
            sv.Fields[3].AsString := cid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('stock_id').AsString;
            //STATUS
            sv.Fields[6].AsString := '02';
            //CRT_DATE
            sv.Fields[7].AsString := copy(rs.FieldbyName('comm_id').AsString,4,8);
            //CRT_USER_ID
            sv.Fields[8].AsString := '';
            //POST_DATE
            sv.Fields[9].AsString := rs.FieldbyName('stock_date').AsString;
            //TYPE
            sv.Fields[10].AsString := '01';
            //UPDATE_TIME
            sv.Fields[11].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('STOCK_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME from STK_STOCKDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C where A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.STOCK_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT,UM_ID from RIM_VOUCHER_LINE where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //VOUCHER_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_'+rs.FieldbyName('stock_id').AsString;
            //VOUCHER_LINE
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //QTY_INCEPT
            sv.Fields[4].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[5].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT_INCEPT
            sv.Fields[6].AsFloat :=  rs.FieldbyName('calc_money').AsFloat;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[7].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[7].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[7].AsString := '04'
            else
               sv.Fields[7].AsString := '02';
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''05'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update STK_STOCKORDER set COMM=''11'' where COMP_ID='''+CompId+''' and STOCK_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报入库流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;
procedure SendStkRetuDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''06'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''06'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 * from STK_RETUORDER where COMP_ID='''+CompId+''' and RETU_ID>'''+mx+''' order by RETU_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,R3_NUM,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME from RIM_VOUCHER where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //VOUCHER_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_2_'+rs.FieldbyName('retu_id').AsString;
            //RETAIL_NUM
            sv.Fields[1].AsString := '';
            //CUST_ID
            sv.Fields[2].AsString := custid;
            //COM_ID
            sv.Fields[3].AsString := cid;
            //TERM_ID
            sv.Fields[4].AsString := compid;
            //R3_NUM
            sv.Fields[5].AsString := rs.FieldbyName('retu_id').AsString;
            //STATUS
            sv.Fields[6].AsString := '02';
            //CRT_DATE
            sv.Fields[7].AsString := '';
            //CRT_USER_ID
            sv.Fields[8].AsString := '';
            //POST_DATE
            sv.Fields[9].AsString := rs.FieldbyName('retu_date').AsString;
            //TYPE
            sv.Fields[10].AsString := '02';
            //UPDATE_TIME
            sv.Fields[11].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('RETU_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.*,B.GODS_ISN,C.UNIT_NAME from STK_RETUDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C where A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.RETU_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT,UM_ID from RIM_VOUCHER_LINE where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //VOUCHER_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_2_'+rs.FieldbyName('retu_id').AsString;
            //VOUCHER_LINE
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //QTY_INCEPT
            sv.Fields[4].AsFloat := - rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[5].AsFloat := - rs.FieldbyName('calc_amount').AsFloat;
            //AMT_INCEPT
            sv.Fields[6].AsFloat := - rs.FieldbyName('calc_money').AsFloat;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[7].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[7].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[7].AsString := '04'
            else
               sv.Fields[7].AsString := '02';
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''06'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update STK_RETUORDER set COMM=''11'' where COMP_ID='''+CompId+''' and RETU_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报进货退货流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;

procedure SendChangeDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''07'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''07'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 * from STO_CHANGEORDER where COMP_ID='''+CompId+''' and CHANGE_ID>'''+mx+''' order by CHANGE_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,R3_NUM,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME from RIM_ADJUST_INFO where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //ADJUST_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('change_id').AsString;
            //CUST_ID
            sv.Fields[1].AsString := custid;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //TERM_ID
            sv.Fields[3].AsString := compid;
            //R3_NUM
            sv.Fields[4].AsString := rs.FieldbyName('change_id').AsString;
            //TYPE
            if rs.FieldByName('CHANGE_CODE').AsString = '01' then
               sv.Fields[5].AsString := '02'
            else
               sv.Fields[5].AsString := '03';
            //STATUS
            sv.Fields[6].AsString := '02';
            //CRT_DATE
            sv.Fields[7].AsString := rs.FieldbyName('change_date').AsString;
            //CRT_USER_ID
            sv.Fields[8].AsString := '';
            //POST_DATE
            sv.Fields[9].AsString := rs.FieldbyName('change_date').AsString;
            //UPDATE_TIME
            sv.Fields[10].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('CHANGE_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        rs.Close;
        rs.CommandText := 'select A.CHANGE_ID,A.SEQNO,case when D.CHANGE_TYPE=1 then 1 else -1 end *A.AMOUNT AMOUNT,case when D.CHANGE_TYPE=1 then 1 else -1 end *A.CALC_AMOUNT CALC_AMOUNT,case when D.CHANGE_TYPE=1 then 1 else -1 end *A.AMONEY AMONEY,B.GODS_ISN,C.UNIT_NAME '+
                          'from STO_CHANGEDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C,STO_CHANGEORDER D '+
                          'where A.COMP_ID=D.COMP_ID and A.CHANGE_ID=D.CHANGE_ID and A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.CHANGE_ID in ('+w+')';
        LocalFactor.Open(rs);
        sv.Close;
        sv.CommandText := 'select ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST,UM_ID from RIM_ADJUST_DETAIL where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //ADJUST_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('change_id').AsString;
            //ADJUST_LINE
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //QTY_ADJUST
            sv.Fields[4].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            sv.Fields[5].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT_ADJUST
            sv.Fields[6].AsFloat :=  rs.FieldbyName('amoney').AsFloat;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[7].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[7].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[7].AsString := '04'
            else
               sv.Fields[7].AsString := '02';
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''07'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update STO_CHANGEORDER set COMM=''11'' where COMP_ID='''+CompId+''' and CHANGE_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报库存调整流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;
procedure SendCombDetail(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''08'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''08'','''+compid+''',''000000000000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx,w:string;
  n:integer;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    while true do
    begin
      rs.Close;
      rs.CommandText := 'select top 100 A.*,B.GODS_ISN,B.SYS_FLAG,C.UNIT_NAME from STO_COMBORDER A,PUB_GOODSINFO B,PUB_MEAUNITS C where A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and A.COMP_ID='''+CompId+''' and A.COMB_ID>'''+mx+''' order by A.COMB_ID ';
      LocalFactor.Open(rs);
      if rs.IsEmpty then break;
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        w := '';
        //报表头
        sv.Close;
        sv.CommandText := 'select ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,R3_NUM,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME from RIM_ADJUST_INFO where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //ADJUST_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_2_'+rs.FieldbyName('comb_id').AsString;
            //CUST_ID
            sv.Fields[1].AsString := custid;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //TERM_ID
            sv.Fields[3].AsString := compid;
            //R3_NUM
            sv.Fields[4].AsString := rs.FieldbyName('comb_id').AsString;
            //TYPE
            sv.Fields[5].AsString := '03';
            //STATUS
            sv.Fields[6].AsString := '02';
            //CRT_DATE
            sv.Fields[7].AsString := rs.FieldbyName('comb_date').AsString;
            //CRT_USER_ID
            sv.Fields[8].AsString := '';
            //POST_DATE
            sv.Fields[9].AsString := rs.FieldbyName('comb_date').AsString;
            //UPDATE_TIME
            sv.Fields[10].AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
            sv.Post;
            mx := rs.FieldbyName('COMB_ID').AsString;
            if w<>'' then w := w + ',';
            w := w + ''''+mx+'''';
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //报表体
        sv.Close;
        sv.CommandText := 'select ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST,UM_ID from RIM_ADJUST_DETAIL where 1<>1';
        RemoteFactor.Open(sv);
        rs.First;
        while not rs.Eof do
          begin
            if rs.FieldbyName('sys_flag').AsInteger = 1 then
               begin
                  sv.Append;
                  //ADJUST_NUM
                  sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('change_id').AsString;
                  //ADJUST_LINE
                  sv.Fields[1].AsInteger := rs.recno;
                  //COM_ID
                  sv.Fields[2].AsString := cid;
                  //ITEM_ID
                  sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
                  //QTY_ADJUST
                  if rs.FieldByName('comb_type').AsInteger = 0 then
                     sv.Fields[4].AsFloat := rs.FieldbyName('amount').AsFloat
                  else
                     sv.Fields[4].AsFloat := -rs.FieldbyName('amount').AsFloat;
                  //QTY_MINI_UM
                  if rs.FieldByName('comb_type').AsInteger = 0 then
                     sv.Fields[5].AsFloat := rs.FieldbyName('calc_amount').AsFloat
                  else
                     sv.Fields[5].AsFloat := -rs.FieldbyName('calc_amount').AsFloat;
                  //AMT_ADJUST
                  if rs.FieldByName('comb_type').AsInteger = 0 then
                     sv.Fields[6].AsFloat :=  rs.FieldbyName('amoney').AsFloat
                  else
                     sv.Fields[6].AsFloat :=  -rs.FieldbyName('amoney').AsFloat;
                  //UM_ID
                  if rs.FieldbyName('unit_name').AsString='支' then
                     sv.Fields[7].AsString := '01'
                  else
                  if rs.FieldbyName('unit_name').AsString='条' then
                     sv.Fields[7].AsString := '03'
                  else
                  if rs.FieldbyName('unit_name').AsString='箱' then
                     sv.Fields[7].AsString := '04'
                  else
                     sv.Fields[7].AsString := '02';
                  sv.Post;
               end;
            rs.Next;
          end;

        rs.Close;
        rs.CommandText := 'select A.CHANGE_ID,A.SEQNO,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,B.GODS_ISN,C.UNIT_NAME,D.SYS_FLAG '+
                          'from STO_COMBDATA A,PUB_GOODSINFO B,PUB_MEAUNITS C,STO_COMBORDER D '+
                          'where A.COMP_ID=D.COMP_ID and A.COMB_ID=D.COMB_ID and A.GODS_ID=B.GODS_ID and A.UNIT_ID=C.UNIT_ID and B.SYS_FLAG=1 and A.COMP_ID='''+CompId+''' and A.COMB_ID in ('+w+')';
        LocalFactor.Open(rs);
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //ADJUST_NUM
            sv.Fields[0].AsString := custid+'_'+compid+'_1_'+rs.FieldbyName('change_id').AsString;
            //ADJUST_LINE
            sv.Fields[1].AsInteger := rs.recno;
            //COM_ID
            sv.Fields[2].AsString := cid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //QTY_ADJUST
            if rs.FieldByName('comb_type').AsInteger = 0 then
               sv.Fields[4].AsFloat := -rs.FieldbyName('amount').AsFloat
            else
               sv.Fields[4].AsFloat := rs.FieldbyName('amount').AsFloat;
            //QTY_MINI_UM
            if rs.FieldByName('comb_type').AsInteger = 0 then
               sv.Fields[5].AsFloat := -rs.FieldbyName('calc_amount').AsFloat
            else
               sv.Fields[5].AsFloat := rs.FieldbyName('calc_amount').AsFloat;
            //AMT_ADJUST
            if rs.FieldByName('comb_type').AsInteger = 0 then
               sv.Fields[6].AsFloat :=  - rs.FieldbyName('amoney').AsFloat
            else
               sv.Fields[6].AsFloat :=  rs.FieldbyName('amoney').AsFloat;
            //UM_ID
            if rs.FieldbyName('unit_name').AsString='支' then
               sv.Fields[7].AsString := '01'
            else
            if rs.FieldbyName('unit_name').AsString='条' then
               sv.Fields[7].AsString := '03'
            else
            if rs.FieldbyName('unit_name').AsString='箱' then
               sv.Fields[7].AsString := '04'
            else
               sv.Fields[7].AsString := '02';
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''08'' and TERM_ID='''+compid+'''');
        LocalFactor.ExecSQL('update STO_COMBORDER set COMM=''11'' where COMP_ID='''+CompId+''' and COMB_ID in ('+w+')');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报拆卸组装流水成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;

procedure SendCostPrice(LocalFactor,RemoteFactor:TIdFactor;compid,cid,custid,custcode:string);
function GetMxId:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select MAX_NUM from RIM_R3_NUM where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''09'' and TERM_ID='''+compid+'''';
    RemoteFactor.Open(rs);
    result := rs.Fields[0].AsString;
    if rs.IsEmpty then
       RemoteFactor.ExecSQL('insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values('''+cid+''','''+custid+''',''09'','''+compid+''',''00000000'')');
  finally
    rs.Free;
  end;

end;
var
  rs:TADODataSet;
  sv:TADODataSet;
  mx:string;
  MinDate,MaxDate:TDatetime;
begin
  rs := TADODataSet.Create(nil);
  sv := TADODataSet.Create(nil);
  try
    mx := GetMxId;
    rs.Close;
    rs.CommandText := 'select A.SALES_DATE,C.GODS_ISN, '+
       'sum(CALC_AMOUNT*COST_PRICE) as AMONEY,'+
       'sum(CALC_AMOUNT) AMOUNT '+
       'from ALL_SALESORDER A,ALL_SALESDATA B,PUB_GOODSINFO C  '+
       'where A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID and B.GODS_ID=C.GODS_ID and C.SYS_FLAG=1 and A.COMP_ID='''+compid+''' and A.SALES_DATE>'''+mx+''' '+
       'group by A.SALES_DATE,C.GODS_ISN order by A.SALES_DATE';
    LocalFactor.Open(rs);
    if rs.IsEmpty then Exit;
    rs.First;
    MinDate := EncodeDate(StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,1,4)),StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,5,2)),StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,7,2)));
    rs.Last;
    MaxDate := EncodeDate(StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,1,4)),StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,5,2)),StrtoInt(Copy(rs.FieldbyName('sales_date').AsString,7,2)));
    while MinDate<=MaxDate do
    begin
      RemoteFactor.BeginTrans;
      LocalFactor.BeginTrans;
      try
        RemoteFactor.ExecSQL('delete from RIM_CUST_ITEM_COST where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TERM_ID='''+compid+''' and DATE1='''+formatDatetime('YYYYMMDD',MinDate)+'''');
        //报表头
        sv.Close;
        sv.CommandText := 'select COM_ID,CUST_ID,TERM_ID,ITEM_ID,DATE1,UNIT_COST from RIM_CUST_ITEM_COST where 1<>1';
        RemoteFactor.Open(sv);
        rs.Filtered := false;
        rs.Filter := 'SALES_DATE='''+formatDatetime('YYYYMMDD',MinDate)+'''';
        rs.Filtered := true;
        rs.First;
        while not rs.Eof do
          begin
            sv.Append;
            //COM_ID
            sv.Fields[0].AsString := cid;
            //CUST_ID
            sv.Fields[1].AsString := custid;
            //TERM_ID
            sv.Fields[2].AsString := compid;
            //ITEM_ID
            sv.Fields[3].AsString := rs.FieldbyName('gods_isn').AsString;
            //DATE1
            sv.Fields[4].AsString := rs.FieldbyName('sales_date').AsString;
            //UNIT_COST
            if rs.FieldbyName('amount').AsFloat <> 0 then
               sv.Fields[5].AsFloat := rs.FieldbyName('amoney').AsFloat / rs.FieldbyName('amount').AsFloat
            else
               sv.Fields[5].AsFloat := 0;
            sv.Post;
            rs.Next;
          end;
        RemoteFactor.UpdateBatch(sv);
        mx := formatDatetime('YYYYMMDD',MinDate);
        MinDate := MinDate + 1;
        //写标志单号
        RemoteFactor.ExecSQL('update RIM_R3_NUM set MAX_NUM='''+mx+''' where COM_ID='''+cid+''' and CUST_ID='''+custid+''' and TYPE=''09'' and TERM_ID='''+compid+'''');
        RemoteFactor.CommitTrans;
        LocalFactor.CommitTrans;
      except
        on E:Exception do
           begin
             RemoteFactor.RollbackTrans;
             LocalFactor.RollbackTrans;
             sleep(1);
             RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','+ QuotedStr(E.Message)+',''auto'',''02'')');
             Exit;
           end;
      end;
    end;
    sleep(1);
    RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''01'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''',''上报销售成本单价成功'',''auto'',''01'')');
  finally
    sv.Free;
    rs.Free;
  end;
end;

procedure CallSync(LocalFactor,RemoteFactor:TIdFactor);
var
  DefUnit: integer;
  rs,ls:TADODataSet;
  id,m,cid,custid,compid,custcode,compname:string;
begin
  rs := TADODataSet.Create(nil);
  ls := TADODataSet.Create(nil);
  try
    rs.Close;
    rs.CommandText := 'select COMP_ID,INTF_SELF,INTF_CODE,COMP_NAME,INTF_UNIT from CA_COMPANY where INTF_SELF is not null order by COMP_ID';
    LocalFactor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        try
          WriteDebug('开始上报:'+rs.Fields[3].asString+'('+rs.Fields[1].asString+')');
          cid := rs.Fields[2].AsString;
          compid := rs.Fields[0].AsString;
          custcode := rs.Fields[1].AsString;
          compname := rs.Fields[3].AsString;
          DefUnit:= rs.Fields[4].AsInteger;
          ls.Close;
          ls.CommandText := 'select ORGAN_ID from PUB_ORGAN where ORGAN_ID='''+cid+'''';
          RemoteFactor.Open(ls);
          cid := ls.Fields[0].AsString;
          WriteDebug('rimcid:'+cid);
          if cid='' then Raise Exception.Create(compname+'->请正确设置接口参数');
          ls.Close;
          ls.CommandText := 'select CUST_ID from RM_CUST where COM_ID='''+cid+''' and CUST_CODE='''+custcode+'''';
          RemoteFactor.Open(ls);
          custid := ls.Fields[0].AsString;
          WriteDebug('custid:'+custid);
          if custid='' then Raise Exception.Create(compname+'->'+cid+'在RIM中没找到对应的CUST_ID值...');
          WriteDebug('报月台帐:'+custid);
          while true do
          begin
            if CheckReckonine(compid,custid,cid,LocalFactor,RemoteFactor,id,m) then //上报月台帐
            begin
              WriteDebug('报月台帐:'+custid);
              if not SendMonthReck(LocalFactor,RemoteFactor,id,m,compid,cid,custid,custcode) then Break;
            end else
              break;
          end;
          WriteDebug('报销售:'+custid);
          SendSalesDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode,DefUnit);
          WriteDebug('报批发:'+custid);
          SendSaleBatchDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报销售退货:'+custid);
          SendSaleRetDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报调拨:'+custid);
          SenddbDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报入库:'+custid);
          SendStockDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报采购退货:'+custid);
          SendStkRetuDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报调整:'+custid);
          SendChangeDetail(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
          WriteDebug('报成本:'+custid);
          SendCostPrice(LocalFactor,RemoteFactor,compid,cid,custid,custcode);
        except
          on E:Exception do
             begin
               sleep(1);
               WriteDebug(E.Message);
               RemoteFactor.ExecSQL('insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values('''+custcode+formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''',''00'','''+custid+''','''+formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''' ,'+ QuotedStr(E.Message)+',''auto'',''02'')');
             end;
        end;
        rs.Next;
      end;
  finally
    ls.Free;
    rs.Free;
  end;
end;
end.
