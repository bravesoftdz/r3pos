{  22100001	0	日结账 	1	结账	2	撤消   }

unit ufrmCostCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus,ZDataSet, RzButton, RzPrgres, StdCtrls,
  ExtCtrls, ZBase, DB, uDsUtil, DateUtils;

type
  TfrmCostCalc = class(TfrmBasic)
    Bevel1: TBevel;
    Label11: TLabel;
    RzProgressBar1: TRzProgressBar;
    Label1: TLabel;
    btnStart: TRzBitBtn;
    Label2: TLabel;
    LblTime: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FOldPrgPercent:integer;  //循环前的进度
    FAllPrgCount:integer;    //当前循环总个数据
    FSubPrgPercent:real;     //子过程中占整个过程%;
    Fid: string;
    Fcflag: integer;
    FcDate: TDate;
    FeDate: TDate;
    Fflag: integer;
    FbDate: TDate;
    FmDate: TDate;
    FuDate: TDate;
    FPrgPercent: integer;
    FBegTickCount:integer;
    FMthCount: integer; //区间月份数
    procedure Setid(const Value: string);
    procedure Setcflag(const Value: integer);
    procedure SetcDate(const Value: TDate);
    procedure SeteDate(const Value: TDate);
    procedure Setflag(const Value: integer);
    procedure SetbDate(const Value: TDate);
    procedure SetmDate(const Value: TDate);
    procedure SetuDate(const Value: TDate);
    procedure SetPrgPercent(const Value: integer);
    procedure SetBegTickCount(const Value: integer);
    function GetDayCloseFlag(flag:integer):Boolean;
    function CheckAutoClsMthRck:Boolean; //判断是否超过7天并自动月结账
  protected
    procedure CheckCalcReckStatus; //在线版判断是否多人同时在核算
    procedure ClearCalcReckStatus; //在线版清除核算标记
    procedure CheckForRck; //判断是否未审核盘点
    procedure DoSetPrgPercent(CurNo,CurPoint:integer);

    function CheckValidDate(dateStr: string):string;
    function GetMonthCount:integer; //返回结账月份数
    function LockCompanyCheck: boolean;
    function DoCalcDayReckByMth(InParams:TftParamList;ClsFalg:Boolean=True):Boolean; //根据月份区间计算日台账
    function DoCalcUpdateStorage(InParams:TftParamList):Boolean; //更新库存成本价
    function DoCalcMonthReck(InParams:TftParamList;CalcFlag:string):Boolean;   //计算月台账
    function DoCalcAnalyLister:Boolean; //监控商品系数

    function CalcForDayReck(InParams:TftParamList):Boolean;   //计算日结账(flag=1)
    function CalcForMonthReck(InParams:TftParamList):Boolean; //计算月结账(flag=2)
    function CalcForMonthData(InParams:TftParamList;CalcFlag:string):Boolean; //计算月账户台账(flag=5)、商品台账(flag=6)
  public
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    //核算前准备
    procedure Prepare;
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
    //月结账区间数
    property MthCount:integer read FMthCount;
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
    //判断是否月结账
    class function CheckMonthReck(Owner:TForm):boolean;
    //退出上报条件检测
    class function CheckSyncReck(Owner:TForm):boolean;
    property PrgPercent:integer read FPrgPercent write SetPrgPercent;
    property BegTickCount:integer read FBegTickCount write SetBegTickCount;
  end;

implementation

uses uGlobal,uFnUtil,uShopGlobal,ObjCommon,uSyncFactory,ufrmMain;

{$R *.dfm}


{ TfrmCostCalc }

procedure TfrmCostCalc.Prepare;
var
  rs:TZQuery;
  e:TDate;
  myDate:TDate;
begin
  reck_flag := StrtoIntDef(ShopGlobal.GetParameter('RECK_OPTION'),1);
  reck_day := StrtoIntDef(ShopGlobal.GetParameter('RECK_DAY'),28);
  calc_flag := StrtoIntDef(ShopGlobal.GetParameter('CALC_FLAG'),0);
  PrgPercent := 0;
  pc := 0;
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(CREA_DATE)as max_date from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    isfirst := false;
    if rs.Fields[0].asString<>'' then
      cDate:=fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
    begin
      rs.Close;
      rs.SQL.Text :=  'select value from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE=''USING_DATE'' ';
      Factor.Open(rs);
      if rs.Fields[0].asString<>'' then
        cDate := fnTime.fnStrtoDate(rs.Fields[0].asString)-1
       else
        cDate := Date()-1;
      rs.Close;
      rs.SQL.Text := 'select min(CREA_DATE) from VIW_GOODS_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',cDate);
      Factor.Open(rs);
      if rs.Fields[0].AsString <> '' then
        Raise Exception.Create('系统参数的启用日期错了，请设置到['+rs.Fields[0].AsString+']之前日期');
      isfirst := true;
    end;

    //计算上一次月结账日期
    rs.Close;
    rs.SQL.Text := 'select max(END_DATE) from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    isfirst := false;  //是否第一次计算
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

    case flag of
     1: //检测是否日结账
      begin
        rs.close;
        rs.SQL.Text := 'select CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',eDate);
        Factor.Open(rs);
        btnStart.Enabled := rs.IsEmpty;
        if not rs.IsEmpty then
          eDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
      end;
     2: //月结时检测结账月份
      begin
        if reck_flag=1 then //月底结账
        begin
          e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(date(),1))+'01')-1;
          if e>date() then //还没到结账日
            eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',date())+'01')-1
          else
            eDate := e;
        end else  //指定日月结账
        begin
          e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',date())+formatfloat('00',reck_day)));
          if e>date() then //还没到结账日
            eDate := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(date(),-1))+formatfloat('00',reck_day)))
          else
            eDate := e;
        end;
        rs.close;
        rs.SQL.Text := 'select month from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH>='+formatDatetime('YYYYMM',eDate);
        Factor.Open(rs);
        btnStart.Enabled := rs.IsEmpty and (eDate>bDate);
        if eDate<bDate then eDate := bDate;
      end;
    end;
    
    //判断条件
    myDate := cDate;
    if calc_flag=2 then myDate := bDate;
    rs.close;
    rs.SQL.Text :=  //从3个表单据中取此日期
       'select max(HDate)as HDate,min(LDate)as LDate from '+
       '('+
        'select max(STOCK_DATE) as HDate,min(STOCK_DATE) as LDate from STK_STOCKORDER where TENANT_ID='+inttostr(Global.TENANT_ID)+' and STOCK_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
        ' union all '+
        'select max(SALES_DATE) as HDate,min(SALES_DATE) as LDate from SAL_SALESORDER where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SALES_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
        ' union all '+
        'select max(CHANGE_DATE) as HDate,min(CHANGE_DATE) as LDate from STO_CHANGEORDER where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CHANGE_DATE>'+formatDatetime('YYYYMMDD',myDate)+
       ')TP ';
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
    if mDate<date() then mDate := date();
    pt := round(mDate-cDate);
    //返回本次月结账区间
    FMthCount:=GetMonthCount;
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

function getLocalDBKey() : string;
var rs : TZQuery;
var localDBKey : string;
begin
  // 获取本机DBKey
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+Global.SHOP_ID+''' and TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.LocalFactory.Open(rs);
    if not rs.IsEmpty then
      localDBKey := rs.Fields[0].AsString
    else
      begin
        localDBKey := TSequence.newId();
        Global.LocalFactory.ExecSQL('insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+'DBKEY_'+Global.SHOP_ID+''','''+localDBKey+''',0,''00'',0)');
      end
  finally
    rs.Free;
  end;
  result := localDBKey;
end;

procedure TfrmCostCalc.btnStartClick(Sender: TObject);
var
  i:integer;
  DayClsFlag:Boolean;
  ReMsg,Rck_Date:string;
  CalcParams:TftParamList;
  StrList:TStringlist;
begin
  {if FileExists('c:\LogSQL.Log') then
  begin
    try
      StrList:=TStringlist.Create;
      StrList.LoadFromFile('c:\LogSQL.Log');
      StrList.Clear;
      StrList.SaveToFile('c:\LogSQL.Log');
    finally
      StrList.Free;
    end;
  end;}
  LblTime.Caption:='[0s]';
  FBegTickCount:=GetTickCount;
  CheckCalcReckStatus; //在线版判断是否多人同时在核算
  Label1.Caption:='正在核算需要较长的时间,请稍候....';
  Label11.Caption := '读取参数...';
  Update;
  //1、读取参数
  Prepare;
  if (calc_flag=2) and (flag=1) then Raise Exception.Create('月移动加权平均算法不支持日结账');
  PrgPercent := 1;
  Factor.DBLock(true);
  btnStart.Enabled := false;
  CalcParams:=TftParamList.Create(nil);
  try
    //系统参数值
    CalcParams.ParamByName('FLAG').AsInteger:=flag; //核算方法(0:移动加权平均;1:日移动加权平均;2:月移动加权平均)
    CalcParams.ParamByName('CALC_FLAG').AsInteger:=calc_flag; //核算方法(0:移动加权平均;1:日移动加权平均;2:月移动加权平均)
    CalcParams.ParamByName('RECK_FLAG').AsInteger:=reck_flag; //月结账类型(月底结账、指定日结账)
    CalcParams.ParamByName('RECK_DAY').AsInteger:=reck_day;   //指定日结账
    //台账参数
    CalcParams.ParamByName('CDATE').AsString:=FormatDatetime('YYYYMMDD',cDate); //最后日结日期
    CalcParams.ParamByName('MDATE').AsString:=FormatDatetime('YYYYMMDD',mDate); //本次日台账日期(最大日期)
    CalcParams.ParamByName('EDATE').AsString:=FormatDatetime('YYYYMMDD',eDate); //本次日结账日期(之前当天不关账,现在无限制)
    CalcParams.ParamByName('BDATE').AsString:=FormatDatetime('YYYYMMDD',bDate); //上次月结日期RCK_MONTH_CLOSE.END_DATE
    CalcParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID; //企业ID
    CalcParams.ParamByName('USER_ID').AsString:=Global.UserID; //操作员ID
    //根据核算类调用
    case flag of
     1: CalcForDayReck(CalcParams); //计算日台账(flag=1)
     2: CalcForMonthReck(CalcParams); //计算月台账(flag=2)
     3,4:  //计算日账户(flag=3)、日商品(flag=4)
      begin
        Label11.Caption := '核算前检测数据...';
        Update;
        PrgPercent := 2;
        //1、以天为单位计算日台账(92)
        FOldPrgPercent:=PrgPercent; //循环前的进度
        FAllPrgCount:=MthCount;      //当前循环总个数据
        FSubPrgPercent:=0.90;  //子过程中占整个过程%;

        DayClsFlag:=GetDayCloseFlag(flag);
        DoCalcDayReckByMth(CalcParams,DayClsFlag);
        //2、成本核算成功更新最后一天业务库存(平时试算不更新库存)
        //DoCalcUpdateStorage(CalcParams);
      end;
     5: CalcForMonthData(CalcParams,'010'); //计算月账户(flag=5) //账户月台账
     6: CalcForMonthData(CalcParams,'100'); //计算月账户(flag=6) //商品月台账
    end;
  finally
    ClearCalcReckStatus; //在线版清除核算标记
    CalcParams.Free;
    Factor.DBLock(False);
    btnStart.Enabled := true;
  end;
  ModalResult := MROK;
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

procedure TfrmCostCalc.Setflag(const Value: integer);
begin
  Fflag := Value;
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

procedure TfrmCostCalc.CheckForRck;
var
  rs:TZQuery;
begin
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
  result:=False;
  with TfrmCostCalc.Create(Owner) do
    begin
      try
        flag := 4;
        Label2.Caption := '计算台账:'+formatDatetime('YYYY-MM-DD',date());
        Show;
        btnStartClick(nil);
        result:=true;
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
        DoCalcAnalyLister;
      finally
        free;
      end;
    end;
end;

procedure TfrmCostCalc.SetPrgPercent(const Value: integer);
begin
  FPrgPercent := Value;
  if Value<100 then
    RzProgressBar1.Percent := Value
  else
    RzProgressBar1.Percent:=100;
  Update;
end;

//判断是否月结账
class function TfrmCostCalc.CheckMonthReck(Owner: TForm): boolean;
var
  tmp: TZQuery;
begin
  result:=False;
  //先判断有月结账权限
  if not frmMain.FindAction('actfrmMonthClose').Enabled then Exit;

  with TfrmCostCalc.Create(Owner) do
  begin
    try
      tmp:=Global.GetZQueryFromName('CA_SHOP_INFO');
      if (tmp.Active) and (tmp.RecordCount=1) then //是单店并且上次结账第5天以后
      begin
        if 1=1 then //CheckReckMonthDay 
        begin
          flag := 2;
          Caption := '月结账';
          eDate := Date()-1;
          Prepare;
          if not btnStart.Enabled then Exit;
          if Date() <= (eDate+5) then Exit;
          Label2.Caption := '月结日期:'+formatDatetime('YYYY-MM-DD',eDate);
          Label1.Caption:='请点击〖执行〗开始月结帐 ';
          Show;
          btnStartClick(nil); // 单机版自动月结
        end;
      end
    finally
      free;
    end;
  end;
end;

//锁定电脑判断
function TfrmCostCalc.LockCompanyCheck: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+Global.SHOP_ID+''' and TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.LocalFactory.Open(rs);
    result := (rs.Fields[0].AsString<>'');
  finally
    rs.Free;
  end;
end;

class function TfrmCostCalc.CheckSyncReck(Owner: TForm): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    // rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',Date()-1);
    // 2012-7-4 计算当天日台账
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',Date());
    uGlobal.Factor.Open(rs);
    result := (rs.Fields[0].AsInteger=0); 
  finally
    rs.Free;
  end;
end;

// 检测月末结账日期是否有效，月结日期24-31日
function TfrmCostCalc.CheckValidDate(dateStr: string):string;
begin
  if Length(dateStr) <> 8 then
    Raise Exception.Create('月末结账日期有误！'+dateStr+'无效的日期字符串！');

  if IsValidDate(StrToIntDef(Copy(dateStr,1,4),0),StrToIntDef(Copy(dateStr,5,2),0),StrToIntDef(Copy(dateStr,7,2),0)) then
    result := dateStr
  else
  if IsValidDate(StrToIntDef(Copy(dateStr,1,4),0),StrToIntDef(Copy(dateStr,5,2),0),StrToIntDef(Copy(dateStr,7,2),0)-1) then
    result := Copy(dateStr,1,4) + Copy(dateStr,5,2) + formatFloat('00',StrToIntDef(Copy(dateStr,7,2),0)-1)
  else
  if IsValidDate(StrToIntDef(Copy(dateStr,1,4),0),StrToIntDef(Copy(dateStr,5,2),0),StrToIntDef(Copy(dateStr,7,2),0)-2) then
    result := Copy(dateStr,1,4) + Copy(dateStr,5,2) + formatFloat('00',StrToIntDef(Copy(dateStr,7,2),0)-2)
  else
  if IsValidDate(StrToIntDef(Copy(dateStr,1,4),0),StrToIntDef(Copy(dateStr,5,2),0),StrToIntDef(Copy(dateStr,7,2),0)-3) then
    result := Copy(dateStr,1,4) + Copy(dateStr,5,2) + formatFloat('00',StrToIntDef(Copy(dateStr,7,2),0)-3)
  else
    Raise Exception.Create('月末结账日期有误！'+dateStr+'无效的日期字符串！');
end;

procedure TfrmCostCalc.CheckCalcReckStatus;
var localDBKey : string;
var Params:TftParamList;
var msg : string;
begin
  if flag in [1,2] then
  begin
    if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线结账!');
    if MessageBox(Handle,'结账前，请确认各门店的脱机数据是否上报完毕？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  end;

  if not ShopGlobal.offline then
    begin
      Params := TftParamList.Create(nil);
      try
        localDBKey := getLocalDBKey();
        Params.ParamByName('localDBKey').AsString := localDBKey;
        Params.ParamByName('tenantId').AsInteger := Global.TENANT_ID;
        msg := Factor.ExecProc('TCheckCostCalc',Params) ;
      finally
        Params.Free;
      end;
    end;

  if (msg <> 'null') and (msg <> '') then  Raise Exception.Create(msg);
end;

procedure TfrmCostCalc.ClearCalcReckStatus;
begin
  if not ShopGlobal.offline then
    Factor.ExecSQL('delete from SYS_DEFINE where TENANT_ID = ' + inttostr(Global.TENANT_ID) + ' and DEFINE in (''RCK_ID'',''RCK_TIME'') ');
end;

function TfrmCostCalc.CalcForDayReck(InParams:TftParamList): Boolean;
var
  i:integer;
  ReMsg,Rck_Date:string;
begin
  Label11.Caption := '核算前检测数据...';
  Update;
  PrgPercent := 2;
  //1、判断日、月结账是否存在未审核盘点
  if (flag=1)or(flag=2) then CheckForRck;

  //2、以天为单位计算日台账(70)
  FOldPrgPercent:=PrgPercent; //循环前的进度
  FAllPrgCount:=MthCount;      //当前循环总个数据
  FSubPrgPercent:=0.70;  //子过程中占整个过程%;
  DoCalcDayReckByMth(InParams);

  //3、成本核算成功更新最后一天业务库存
  DoCalcUpdateStorage(InParams);

  //4、以月份为单位计算日台账
  FOldPrgPercent:=PrgPercent;  //循环前的进度
  FAllPrgCount:=MthCount; //当前循环总个数据
  FSubPrgPercent:=0.20;        //子过程中占整个过程%
  DoCalcMonthReck(InParams,'110');

  //5、监控商品系数
  DoCalcAnalyLister;
  
  MessageBox(Handle,'执行结账完毕.','友情提示..',MB_OK+MB_ICONINFORMATION);
  Update;
end;

function TfrmCostCalc.CalcForMonthData(InParams:TftParamList;CalcFlag:string): Boolean;
var
  i:integer;
  DayClsFlag:Boolean;  
  ReMsg,Rck_Date:string;
begin
  Label11.Caption := '核算前检测数据...';
  Update;
  PrgPercent := 2;
  //1、以天为单位计算日台账(70)
  FOldPrgPercent:=PrgPercent; //循环前的进度
  FAllPrgCount:=MthCount;      //当前循环总个数据
  FSubPrgPercent:=0.70;  //子过程中占整个过程%;
  DayClsFlag:=GetDayCloseFlag(self.flag);
  DoCalcDayReckByMth(InParams,DayClsFlag);

  //2、成本核算成功更新最后一天业务库存 (平时试算不更新库存)
  // DoCalcUpdateStorage(InParams);

  //3、以月份为单位计算日台账
  FOldPrgPercent:=PrgPercent;  //循环前的进度
  FAllPrgCount:=MthCount; //当前循环总个数据
  FSubPrgPercent:=0.25;        //子过程中占整个过程%
  DoCalcMonthReck(InParams,CalcFlag);
end;

function TfrmCostCalc.CalcForMonthReck(InParams:TftParamList): Boolean;
var
  i:integer;
  ReMsg,Rck_Date:string;
begin
  if LockCompanyCheck=False then Raise Exception.Create('不是锁定电脑，不能月结账');
  Label11.Caption := '核算前检测数据...';
  Update;
  PrgPercent := 2;
  //1、判断日、月结账是否存在未审核盘点
  if (flag=1)or(flag=2) then CheckForRck;

  //2、以天为单位计算日台账(70)
  FOldPrgPercent:=PrgPercent; //循环前的进度
  FAllPrgCount:=MthCount;      //当前循环总个数据
  FSubPrgPercent:=0.65;  //子过程中占整个过程%;
  DoCalcDayReckByMth(InParams,True);

  //3、成本核算成功更新最后一天业务库存
  DoCalcUpdateStorage(InParams);

  //4、以月份为单位计算日台账
  FOldPrgPercent:=PrgPercent;  //循环前的进度
  FAllPrgCount:=MthCount; //当前循环总个数据
  FSubPrgPercent:=0.24;        //子过程中占整个过程%
  DoCalcMonthReck(InParams,'111');

  //5、监控商品系数
  DoCalcAnalyLister;
  
  MessageBox(Handle,'执行结账完毕.','友情提示..',MB_OK+MB_ICONINFORMATION);
  Update;
end;

function TfrmCostCalc.GetMonthCount: integer;
var
  b:integer;
  CurMthCount:integer;
  e:TDate;
begin
  CurMthCount:=0;
  try
    b := 1;
    while true do
    begin
      if reck_flag=1 then
      begin
        if isfirst and (b=1) then
        begin
          e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
          if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
        end else
          e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
      end else
      begin
        e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day)));
        //2012.08.29xhh修改月结账区间判断
        if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
          e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
      end;
      Inc(CurMthCount); //月份累+1

      if e>=mDate then break; 
      b := b +round(e-(bDate+b))+1;
    end;
  except
    raise;
  end;
  result:=CurMthCount;
end;

procedure TfrmCostCalc.DoSetPrgPercent(CurNo,CurPoint:integer);
var
  SingleValue:real;
  CurValue:integer;
begin
  if (CurPoint<0) or (CurPoint>10) then CurPoint:=10;
  SingleValue:=(100.000*FSubPrgPercent)/FAllPrgCount;
  SingleValue:=SingleValue*(CurNo-1)*1.000+Round(SingleValue*CurPoint*1.000/10.0);
  CurValue:=Round(SingleValue);
  if (FOldPrgPercent+CurValue)>PrgPercent then
    PrgPercent:=FOldPrgPercent+CurValue;
  SetBegTickCount(0); //设置运行时间  
end;

function TfrmCostCalc.DoCalcDayReckByMth(InParams: TftParamList; ClsFalg: Boolean): Boolean;
var
  i,b,ept:integer;
  CurNo:integer;
  e:TDate;
  ReckBegDate:TDate;
  ReckMonth:string;
  ReMsg:string;
  IS_CLS_FLAG:Boolean;
begin
  result:=False;
  IS_CLS_FLAG:=False;
  CurNo:=0;
  b := 1;
  while true do
  begin
    if reck_flag=1 then
    begin
      if isfirst and (b=1) then
      begin
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
        if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
      end else
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
    end else
    begin
      e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day)));
      //2012.08.29xhh修改月结账区间判断
      if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
        e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
    end;
    //2013.02.24判断当前最大业务日期
    if e> mDate then e:=mDate;

    CurNo:=CurNo+1;
    ReckBegDate:=bDate+b;
    //[移动加权、日移动加权]判断该区间是否日结账(cDate上次日结账日期)
    if (Fcflag in [0,1]) and (cDate>e) then
    begin
      b := b +round(e-(bDate+b))+1;
      Continue;
    end;
    //[移动加权、日移动加权] [本次核算日期从最后一次关账日期开始]
    if (Fcflag in [0,1]) and (cDate>=ReckBegDate) then
      ReckBegDate:=cDate+1; //上次日结账日期+1;  

    //核算日期提示
    if ReckBegDate = e then
      ReckMonth:=FormatDatetime('YYYY-MM-DD',ReckBegDate)
    else
      ReckMonth:=FormatDatetime('YYYY-MM-DD',ReckBegDate)+' 至 '+FormatDatetime('YYYY-MM-DD',e); //核算区间

    //设置最新结账日期
    InParams.ParamByName('CDATE').AsString:=FormatDatetime('YYYYMMDD',cDate); //最后日结日期

    //AAAAAAAAAAAAAAA、计算商品成本、生成日台账
    Label11.Caption := '正在核算['+ReckMonth+']成本...';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //区间开始日期
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //区间结束日期
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('核算成本['+ReckMonth+']出错<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,5); //设置进度

    //BBBBBBBBBBBBBBB、自动交班结账昨天日期
    Label11.Caption := '交班结账['+ReckMonth+']';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
    //自动交班结帐比核算区间提前3天
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate-3);  //区间开始日期
    //2013.03.17只对当前业务日期之前的进行日结关账(日结关账小于当前业务日期)
    if (e>=Global.sysDate) then
      InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',Global.sysDate-1) //区间结束日期
    else
      InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //区间结束日期
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('交班结账['+ReckMonth+']出错<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,7); //设置进度

    //CCCCCCCCCCCCCCC、账款日台账
    Label11.Caption := '核算账户['+ReckMonth+']';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=3;
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //区间开始日期
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //区间结束日期
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('核算账户['+ReckMonth+']出错<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,9); //设置进度

    //DDDDDDDDDDDDDD、插入日结表头关账
    if (ClsFalg) and (LockCompanyCheck) and (cDate<=e) then //只有日结内时间要生成记录已生成日台账部份
    begin
      Label11.Caption := '正在生成['+ReckMonth+']日结账';
      Update;
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=4;
      //if (Fcflag=2) and (cDate>=ReckBegDate) then //月移动平均关账日期从最大结账日期开始到核算当天
      //  InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',cDate+1)  //区间开始日期
      //else
        InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //区间开始日期
      //2013.03.17只对当前业务日期之前的进行日结关账(日结关账小于当前业务日期) [当天日结]
      if (e>=Global.sysDate) then
      begin
        e:=Global.sysDate;
        InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //区间结束日期
        IS_CLS_FLAG:=true;
      end;
      ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('日结账['+ReckMonth+']出错<'+ReMsg+'>');
      cDate:=e;
      DoSetPrgPercent(CurNo,10); //设置进度
    end;

    if e>=mDate then break;
    if IS_CLS_FLAG then break; //最后一次关账也退出
    b := b +round(e-(bDate+b))+1;
  end;
end;

function TfrmCostCalc.DoCalcUpdateStorage(InParams: TftParamList): Boolean;
var
  ReMsg:string;
begin
  result:=False;
  Label11.Caption := '正在更新库存成本...';
  Update;
  InParams.ParamByName('CALC_CMD_IDX').AsInteger:=5;
  InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDatetime('YYYYMMDD',mDate); //更新日期
  ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
  if ReMsg<>'RCK_OK' then Raise Exception.Create('更新库存成本出错<'+ReMsg+'>');
  PrgPercent := PrgPercent+5;
  result:=True;
  SetBegTickCount(0);
end;

function TfrmCostCalc.DoCalcAnalyLister: Boolean;
var
  ReMsg:string;
  InParams:TftParamList;
begin
  result:=False;
  //统计商品(安全参数测算)
  Label11.Caption := '正在商品安全参数测算...';
  Update;
  InParams:=TftParamList.Create(nil);
  try
    InParams.ParamByName('SAFE_DAY').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('SAFE_DAY'),7);
    InParams.ParamByName('REAS_DAY').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('REAS_DAY'),14);
    InParams.ParamByName('DAY_SALE_STAND').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('DAY_SALE_STAND'),90);
    InParams.ParamByName('SMT_RATE').AsString:=ShopGlobal.GetParameter('SMT_RATE');
    ReMsg:=Factor.ExecProc('TCostCalcForAnalyLister',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('商品安全参数测算出错<'+ReMsg+'>');
    PrgPercent := 100;
    Update;
    SetBegTickCount(0);
  finally
    InParams.Free;
  end;
  result:=True;
end;

function TfrmCostCalc.DoCalcMonthReck(InParams: TftParamList;CalcFlag:string): Boolean;
var
  i:integer;
  b,bl:integer;
  RckBegDate,e,CurEndDate:TDate;
  RckMonth:string;
  ReMsg:string;
begin
  i:=0;
  b := 1;
  while true do
  begin
    Inc(i);  //序号+1
    if reck_flag=1 then
    begin
      if isfirst and (b=1) then
      begin
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
        if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
      end else
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
    end else
    begin
      e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day)));
      //2012.08.29xhh修改月结账区间判断
      if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
        e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
    end;
    //2013.03.21最后一个月期末，要按实际有日账记录的数据来取
    if e>mDate then e:=mDate;
        
    RckBegDate:=bDate+b; //开始日期
    RckMonth:=FormatDatetime('YYYYMM',e);
    Label11.Caption := '正在核算['+RckMonth+']月台账...';
    Update;

    //设置结账日期(区间)
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDatetime('YYYYMMDD',RckBegDate); //月结账开始日期
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDatetime('YYYYMMDD',e); //月结账结束日期

    //计算商品月台账流水
    if Copy(CalcFlag,1,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('计算商品月账出错<'+ReMsg+'>');
      DoSetPrgPercent(i,6); //设置进度
    end;

    //计算账户台账流水
    if Copy(CalcFlag,2,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('计算帐户月账出错<'+ReMsg+'>');
      DoSetPrgPercent(i,8); //设置进度
    end;

    //计算月台账结账的记录
    if (Copy(CalcFlag,3,1)='1') or CheckAutoClsMthRck then
    begin
      //判断当前最大日期是否符合月结账条件 [当前操作系统的日期前一个月结账日期]
      case reck_flag of
       1:CurEndDate:=fnTime.fnStrtoDate(formatDatetime('YYYYMM',Date())+'01')-1;
       2:CurEndDate:=fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(date(),-1))+formatfloat('00',reck_day)));
      end;
      if (e<=CurEndDate) then
      begin
        InParams.ParamByName('CALC_CMD_IDX').AsInteger:=3;
        ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
        if ReMsg<>'RCK_OK' then Raise Exception.Create('月结账出错<'+ReMsg+'>');
        DoSetPrgPercent(i,10); //设置进度
      end;
    end;

    if e>=eDate then break; //月份结账
    b := b +round(e-(bDate+b))+1;
    SetBegTickCount(0);
  end;
  
  //核算当前月份
  if FormatDateTime('YYYYMM',eDate)<>FormatDateTime('YYYYMM',mDate) then
  begin
    Inc(i);
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',mDate); //区间结束日期
    if Copy(CalcFlag,1,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('计算商品月账出错<'+ReMsg+'>');
      DoSetPrgPercent(i,5); //设置进度
    end;
    //计算账户台账流水
    if Copy(CalcFlag,2,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('计算帐户月账出错<'+ReMsg+'>');
      DoSetPrgPercent(i,10); //设置进度
    end;
  end;
end;


procedure TfrmCostCalc.SetBegTickCount(const Value: integer);
var
  CurValue:integer;
begin
  CurValue:=(GetTickCount-FBegTickCount) div 1000;
  LblTime.Caption:='['+IntToStr(CurValue)+'s]';
  LblTime.Left:=self.Width-LblTime.Width-6;
end;

function TfrmCostCalc.GetDayCloseFlag(flag: integer): Boolean;
begin
  result:=False;
  if not (flag in [1,2]) then
  begin
    //(在线版) and (离线模式)
    if (ShopGlobal.NetVersion) and ShopGlobal.offline then Exit;
    //(检测若是单机版) and (锁定电脑) 
    if not (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) and not LockCompanyCheck then Exit;
  end;
  result:=true;
end;

function TfrmCostCalc.CheckAutoClsMthRck: Boolean;
var
  Rs:TZQuery;
  NearMthDate:TDate;
begin
  result:=False;
  if flag<>2 then //不是月结账
  begin
    //根据结账日期判断
    case reck_flag of
     1://月底结账
      begin
        NearMthDate:=fnTime.fnStrtoDate(formatDatetime('YYYYMM',Global.SysDate)+'01')-1;
        result:=(Global.SysDate > NearMthDate+7);  //大于7天
      end;
     2://指定日结账
      begin
        NearMthDate:=fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',IncMonth(Global.SysDate,-1))+FormatFloat('00',reck_day)));
        result:=(Global.SysDate > NearMthDate+7);  //大于7天
      end;
    end;
  end;
end;

end.
