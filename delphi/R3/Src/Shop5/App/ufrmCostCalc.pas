{  22100001	0	�ս��� 	1	����	2	����   }

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
    FOldPrgPercent:integer;  //ѭ��ǰ�Ľ���
    FAllPrgCount:integer;    //��ǰѭ���ܸ�����
    FSubPrgPercent:real;     //�ӹ�����ռ��������%;
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
    FMthCount: integer; //�����·���
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
    function CheckAutoClsMthRck:Boolean; //�ж��Ƿ񳬹�7�첢�Զ��½���
  protected
    procedure CheckCalcReckStatus; //���߰��ж��Ƿ����ͬʱ�ں���
    procedure ClearCalcReckStatus; //���߰����������
    procedure CheckForRck; //�ж��Ƿ�δ����̵�
    procedure DoSetPrgPercent(CurNo,CurPoint:integer);

    function CheckValidDate(dateStr: string):string;
    function GetMonthCount:integer; //���ؽ����·���
    function LockCompanyCheck: boolean;
    function DoCalcDayReckByMth(InParams:TftParamList;ClsFalg:Boolean=True):Boolean; //�����·����������̨��
    function DoCalcUpdateStorage(InParams:TftParamList):Boolean; //���¿��ɱ���
    function DoCalcMonthReck(InParams:TftParamList;CalcFlag:string):Boolean;   //������̨��
    function DoCalcAnalyLister:Boolean; //�����Ʒϵ��

    function CalcForDayReck(InParams:TftParamList):Boolean;   //�����ս���(flag=1)
    function CalcForMonthReck(InParams:TftParamList):Boolean; //�����½���(flag=2)
    function CalcForMonthData(InParams:TftParamList;CalcFlag:string):Boolean; //�������˻�̨��(flag=5)����Ʒ̨��(flag=6)
  public
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    //����ǰ׼��
    procedure Prepare;
    //���㵥λ
    property cid:string read Fid write Setid;
    //���㷽ʽ 1�ռ�Ȩ�ƶ�ƽ�� 2�¼�Ȩ��ƽ�� 3�Ƚ��ȳ�
    property calc_flag:integer read Fcflag write Setcflag;
    //�ϴ��ս�����
    property cDate:TDate read FcDate write SetcDate;
    //���ν�������
    property eDate:TDate read FeDate write SeteDate;
    //�ϴ��½�����
    property bDate:TDate read FbDate write SetbDate;
    //�������
    property mDate:TDate read FmDate write SetmDate;
    //�����ݵ��������
    property uDate:TDate read FuDate write SetuDate;
    //�������� 0 ���㣬 1 �ս�  2 �½�
    property flag:integer read Fflag write Setflag;
    //�½���������
    property MthCount:integer read FMthCount;
    //�������˻�̨��
    class function TryCalcDayAcct(Owner:TForm):boolean;
    //��������Ʒ̨��
    class function TryCalcDayGods(Owner:TForm):boolean;
    //�������˻�̨��
    class function TryCalcMthAcct(Owner:TForm):boolean;
    //��������Ʒ̨��
    class function TryCalcMthGods(Owner:TForm):boolean;
    class function StartDayReck(Owner:TForm):boolean;
    class function StartMonthReck(Owner:TForm):boolean;
    //������������
    class function CalcAnalyLister(Owner:TForm):boolean;
    //�ж��Ƿ��½���
    class function CheckMonthReck(Owner:TForm):boolean;
    //�˳��ϱ��������
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
        Raise Exception.Create('ϵͳ�������������ڴ��ˣ������õ�['+rs.Fields[0].AsString+']֮ǰ����');
      isfirst := true;
    end;

    //������һ���½�������
    rs.Close;
    rs.SQL.Text := 'select max(END_DATE) from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+'';
    Factor.Open(rs);
    isfirst := false;  //�Ƿ��һ�μ���
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
     1: //����Ƿ��ս���
      begin
        rs.close;
        rs.SQL.Text := 'select CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',eDate);
        Factor.Open(rs);
        btnStart.Enabled := rs.IsEmpty;
        if not rs.IsEmpty then
          eDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
      end;
     2: //�½�ʱ�������·�
      begin
        if reck_flag=1 then //�µ׽���
        begin
          e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(date(),1))+'01')-1;
          if e>date() then //��û��������
            eDate := fnTime.fnStrtoDate(formatDatetime('YYYYMM',date())+'01')-1
          else
            eDate := e;
        end else  //ָ�����½���
        begin
          e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',date())+formatfloat('00',reck_day)));
          if e>date() then //��û��������
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
    
    //�ж�����
    myDate := cDate;
    if calc_flag=2 then myDate := bDate;
    rs.close;
    rs.SQL.Text :=  //��3��������ȡ������
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

    //ÿ�μ��㶼�㵽���һ��
    if mDate<eDate then mDate := eDate;
    if mDate<date() then mDate := date();
    pt := round(mDate-cDate);
    //���ر����½�������
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
  // ��ȡ����DBKey
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
  CheckCalcReckStatus; //���߰��ж��Ƿ����ͬʱ�ں���
  Label1.Caption:='���ں�����Ҫ�ϳ���ʱ��,���Ժ�....';
  Label11.Caption := '��ȡ����...';
  Update;
  //1����ȡ����
  Prepare;
  if (calc_flag=2) and (flag=1) then Raise Exception.Create('���ƶ���Ȩƽ���㷨��֧���ս���');
  PrgPercent := 1;
  Factor.DBLock(true);
  btnStart.Enabled := false;
  CalcParams:=TftParamList.Create(nil);
  try
    //ϵͳ����ֵ
    CalcParams.ParamByName('FLAG').AsInteger:=flag; //���㷽��(0:�ƶ���Ȩƽ��;1:���ƶ���Ȩƽ��;2:���ƶ���Ȩƽ��)
    CalcParams.ParamByName('CALC_FLAG').AsInteger:=calc_flag; //���㷽��(0:�ƶ���Ȩƽ��;1:���ƶ���Ȩƽ��;2:���ƶ���Ȩƽ��)
    CalcParams.ParamByName('RECK_FLAG').AsInteger:=reck_flag; //�½�������(�µ׽��ˡ�ָ���ս���)
    CalcParams.ParamByName('RECK_DAY').AsInteger:=reck_day;   //ָ���ս���
    //̨�˲���
    CalcParams.ParamByName('CDATE').AsString:=FormatDatetime('YYYYMMDD',cDate); //����ս�����
    CalcParams.ParamByName('MDATE').AsString:=FormatDatetime('YYYYMMDD',mDate); //������̨������(�������)
    CalcParams.ParamByName('EDATE').AsString:=FormatDatetime('YYYYMMDD',eDate); //�����ս�������(֮ǰ���첻����,����������)
    CalcParams.ParamByName('BDATE').AsString:=FormatDatetime('YYYYMMDD',bDate); //�ϴ��½�����RCK_MONTH_CLOSE.END_DATE
    CalcParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID; //��ҵID
    CalcParams.ParamByName('USER_ID').AsString:=Global.UserID; //����ԱID
    //���ݺ��������
    case flag of
     1: CalcForDayReck(CalcParams); //������̨��(flag=1)
     2: CalcForMonthReck(CalcParams); //������̨��(flag=2)
     3,4:  //�������˻�(flag=3)������Ʒ(flag=4)
      begin
        Label11.Caption := '����ǰ�������...';
        Update;
        PrgPercent := 2;
        //1������Ϊ��λ������̨��(92)
        FOldPrgPercent:=PrgPercent; //ѭ��ǰ�Ľ���
        FAllPrgCount:=MthCount;      //��ǰѭ���ܸ�����
        FSubPrgPercent:=0.90;  //�ӹ�����ռ��������%;

        DayClsFlag:=GetDayCloseFlag(flag);
        DoCalcDayReckByMth(CalcParams,DayClsFlag);
        //2���ɱ�����ɹ��������һ��ҵ����(ƽʱ���㲻���¿��)
        //DoCalcUpdateStorage(CalcParams);
      end;
     5: CalcForMonthData(CalcParams,'010'); //�������˻�(flag=5) //�˻���̨��
     6: CalcForMonthData(CalcParams,'100'); //�������˻�(flag=6) //��Ʒ��̨��
    end;
  finally
    ClearCalcReckStatus; //���߰����������
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
        Caption := '�ս���';
        eDate := Date()-1;
        Prepare;
        Label2.Caption := '��������:'+formatDatetime('YYYY-MM-DD',eDate);
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
        Caption := '�½���';
        eDate := Date()-1;
        Prepare;
        Label2.Caption := '�½�����:'+formatDatetime('YYYY-MM-DD',eDate);
        if eDate>Date() then Raise Exception.Create('û�е����½����գ��޷�ִ���½������');
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
    if not rs.IsEmpty then Raise Exception.Create(rs.Fields[0].asString+'�ŵ�'+rs.Fields[1].asString+'�ŵ��̵�û�����,���ܽ���.');
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
        Label2.Caption := '����̨��:'+formatDatetime('YYYY-MM-DD',date());
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
        Label2.Caption := '����̨��:'+formatDatetime('YYYY-MM-DD',date());
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
        Label2.Caption := '����̨��:'+formatDatetime('YYYY-MM-DD',date());
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
        Label2.Caption := '����̨��:'+formatDatetime('YYYY-MM-DD',date());
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
        Caption := '��ȫ��������';
        Label2.Caption := '��ȫ��������';
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

//�ж��Ƿ��½���
class function TfrmCostCalc.CheckMonthReck(Owner: TForm): boolean;
var
  tmp: TZQuery;
begin
  result:=False;
  //���ж����½���Ȩ��
  if not frmMain.FindAction('actfrmMonthClose').Enabled then Exit;

  with TfrmCostCalc.Create(Owner) do
  begin
    try
      tmp:=Global.GetZQueryFromName('CA_SHOP_INFO');
      if (tmp.Active) and (tmp.RecordCount=1) then //�ǵ��겢���ϴν��˵�5���Ժ�
      begin
        if 1=1 then //CheckReckMonthDay 
        begin
          flag := 2;
          Caption := '�½���';
          eDate := Date()-1;
          Prepare;
          if not btnStart.Enabled then Exit;
          if Date() <= (eDate+5) then Exit;
          Label2.Caption := '�½�����:'+formatDatetime('YYYY-MM-DD',eDate);
          Label1.Caption:='������ִ�С���ʼ�½��� ';
          Show;
          btnStartClick(nil); // �������Զ��½�
        end;
      end
    finally
      free;
    end;
  end;
end;

//���������ж�
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
    // 2012-7-4 ���㵱����̨��
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',Date());
    uGlobal.Factor.Open(rs);
    result := (rs.Fields[0].AsInteger=0); 
  finally
    rs.Free;
  end;
end;

// �����ĩ���������Ƿ���Ч���½�����24-31��
function TfrmCostCalc.CheckValidDate(dateStr: string):string;
begin
  if Length(dateStr) <> 8 then
    Raise Exception.Create('��ĩ������������'+dateStr+'��Ч�������ַ�����');

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
    Raise Exception.Create('��ĩ������������'+dateStr+'��Ч�������ַ�����');
end;

procedure TfrmCostCalc.CheckCalcReckStatus;
var localDBKey : string;
var Params:TftParamList;
var msg : string;
begin
  if flag in [1,2] then
  begin
    if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('�����治�������߽���!');
    if MessageBox(Handle,'����ǰ����ȷ�ϸ��ŵ���ѻ������Ƿ��ϱ���ϣ�','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  Label11.Caption := '����ǰ�������...';
  Update;
  PrgPercent := 2;
  //1���ж��ա��½����Ƿ����δ����̵�
  if (flag=1)or(flag=2) then CheckForRck;

  //2������Ϊ��λ������̨��(70)
  FOldPrgPercent:=PrgPercent; //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount;      //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.70;  //�ӹ�����ռ��������%;
  DoCalcDayReckByMth(InParams);

  //3���ɱ�����ɹ��������һ��ҵ����
  DoCalcUpdateStorage(InParams);

  //4�����·�Ϊ��λ������̨��
  FOldPrgPercent:=PrgPercent;  //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount; //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.20;        //�ӹ�����ռ��������%
  DoCalcMonthReck(InParams,'110');

  //5�������Ʒϵ��
  DoCalcAnalyLister;
  
  MessageBox(Handle,'ִ�н������.','������ʾ..',MB_OK+MB_ICONINFORMATION);
  Update;
end;

function TfrmCostCalc.CalcForMonthData(InParams:TftParamList;CalcFlag:string): Boolean;
var
  i:integer;
  DayClsFlag:Boolean;  
  ReMsg,Rck_Date:string;
begin
  Label11.Caption := '����ǰ�������...';
  Update;
  PrgPercent := 2;
  //1������Ϊ��λ������̨��(70)
  FOldPrgPercent:=PrgPercent; //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount;      //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.70;  //�ӹ�����ռ��������%;
  DayClsFlag:=GetDayCloseFlag(self.flag);
  DoCalcDayReckByMth(InParams,DayClsFlag);

  //2���ɱ�����ɹ��������һ��ҵ���� (ƽʱ���㲻���¿��)
  // DoCalcUpdateStorage(InParams);

  //3�����·�Ϊ��λ������̨��
  FOldPrgPercent:=PrgPercent;  //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount; //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.25;        //�ӹ�����ռ��������%
  DoCalcMonthReck(InParams,CalcFlag);
end;

function TfrmCostCalc.CalcForMonthReck(InParams:TftParamList): Boolean;
var
  i:integer;
  ReMsg,Rck_Date:string;
begin
  if LockCompanyCheck=False then Raise Exception.Create('�����������ԣ������½���');
  Label11.Caption := '����ǰ�������...';
  Update;
  PrgPercent := 2;
  //1���ж��ա��½����Ƿ����δ����̵�
  if (flag=1)or(flag=2) then CheckForRck;

  //2������Ϊ��λ������̨��(70)
  FOldPrgPercent:=PrgPercent; //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount;      //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.65;  //�ӹ�����ռ��������%;
  DoCalcDayReckByMth(InParams,True);

  //3���ɱ�����ɹ��������һ��ҵ����
  DoCalcUpdateStorage(InParams);

  //4�����·�Ϊ��λ������̨��
  FOldPrgPercent:=PrgPercent;  //ѭ��ǰ�Ľ���
  FAllPrgCount:=MthCount; //��ǰѭ���ܸ�����
  FSubPrgPercent:=0.24;        //�ӹ�����ռ��������%
  DoCalcMonthReck(InParams,'111');

  //5�������Ʒϵ��
  DoCalcAnalyLister;
  
  MessageBox(Handle,'ִ�н������.','������ʾ..',MB_OK+MB_ICONINFORMATION);
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
        //2012.08.29xhh�޸��½��������ж�
        if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
          e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
      end;
      Inc(CurMthCount); //�·���+1

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
  SetBegTickCount(0); //��������ʱ��  
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
      //2012.08.29xhh�޸��½��������ж�
      if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
        e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
    end;
    //2013.02.24�жϵ�ǰ���ҵ������
    if e> mDate then e:=mDate;

    CurNo:=CurNo+1;
    ReckBegDate:=bDate+b;
    //[�ƶ���Ȩ�����ƶ���Ȩ]�жϸ������Ƿ��ս���(cDate�ϴ��ս�������)
    if (Fcflag in [0,1]) and (cDate>e) then
    begin
      b := b +round(e-(bDate+b))+1;
      Continue;
    end;
    //[�ƶ���Ȩ�����ƶ���Ȩ] [���κ������ڴ����һ�ι������ڿ�ʼ]
    if (Fcflag in [0,1]) and (cDate>=ReckBegDate) then
      ReckBegDate:=cDate+1; //�ϴ��ս�������+1;  

    //����������ʾ
    if ReckBegDate = e then
      ReckMonth:=FormatDatetime('YYYY-MM-DD',ReckBegDate)
    else
      ReckMonth:=FormatDatetime('YYYY-MM-DD',ReckBegDate)+' �� '+FormatDatetime('YYYY-MM-DD',e); //��������

    //�������½�������
    InParams.ParamByName('CDATE').AsString:=FormatDatetime('YYYYMMDD',cDate); //����ս�����

    //AAAAAAAAAAAAAAA��������Ʒ�ɱ���������̨��
    Label11.Caption := '���ں���['+ReckMonth+']�ɱ�...';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //���俪ʼ����
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //�����������
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('����ɱ�['+ReckMonth+']����<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,5); //���ý���

    //BBBBBBBBBBBBBBB���Զ����������������
    Label11.Caption := '�������['+ReckMonth+']';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
    //�Զ�������ʱȺ���������ǰ3��
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate-3);  //���俪ʼ����
    //2013.03.17ֻ�Ե�ǰҵ������֮ǰ�Ľ����ս����(�ս����С�ڵ�ǰҵ������)
    if (e>=Global.sysDate) then
      InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',Global.sysDate-1) //�����������
    else
      InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //�����������
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('�������['+ReckMonth+']����<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,7); //���ý���

    //CCCCCCCCCCCCCCC���˿���̨��
    Label11.Caption := '�����˻�['+ReckMonth+']';
    Update;
    InParams.ParamByName('CALC_CMD_IDX').AsInteger:=3;
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //���俪ʼ����
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //�����������
    ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('�����˻�['+ReckMonth+']����<'+ReMsg+'>');
    DoSetPrgPercent(CurNo,9); //���ý���

    //DDDDDDDDDDDDDD�������ս��ͷ����
    if (ClsFalg) and (LockCompanyCheck) and (cDate<=e) then //ֻ���ս���ʱ��Ҫ���ɼ�¼��������̨�˲���
    begin
      Label11.Caption := '��������['+ReckMonth+']�ս���';
      Update;
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=4;
      //if (Fcflag=2) and (cDate>=ReckBegDate) then //���ƶ�ƽ���������ڴ����������ڿ�ʼ�����㵱��
      //  InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',cDate+1)  //���俪ʼ����
      //else
        InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDateTime('YYYYMMDD',ReckBegDate);  //���俪ʼ����
      //2013.03.17ֻ�Ե�ǰҵ������֮ǰ�Ľ����ս����(�ս����С�ڵ�ǰҵ������) [�����ս�]
      if (e>=Global.sysDate) then
      begin
        e:=Global.sysDate;
        InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',e); //�����������
        IS_CLS_FLAG:=true;
      end;
      ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('�ս���['+ReckMonth+']����<'+ReMsg+'>');
      cDate:=e;
      DoSetPrgPercent(CurNo,10); //���ý���
    end;

    if e>=mDate then break;
    if IS_CLS_FLAG then break; //���һ�ι���Ҳ�˳�
    b := b +round(e-(bDate+b))+1;
  end;
end;

function TfrmCostCalc.DoCalcUpdateStorage(InParams: TftParamList): Boolean;
var
  ReMsg:string;
begin
  result:=False;
  Label11.Caption := '���ڸ��¿��ɱ�...';
  Update;
  InParams.ParamByName('CALC_CMD_IDX').AsInteger:=5;
  InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDatetime('YYYYMMDD',mDate); //��������
  ReMsg:=Factor.ExecProc('TCostCalcForDayReck',InParams);
  if ReMsg<>'RCK_OK' then Raise Exception.Create('���¿��ɱ�����<'+ReMsg+'>');
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
  //ͳ����Ʒ(��ȫ��������)
  Label11.Caption := '������Ʒ��ȫ��������...';
  Update;
  InParams:=TftParamList.Create(nil);
  try
    InParams.ParamByName('SAFE_DAY').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('SAFE_DAY'),7);
    InParams.ParamByName('REAS_DAY').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('REAS_DAY'),14);
    InParams.ParamByName('DAY_SALE_STAND').AsInteger:=StrtoIntDef(ShopGlobal.GetParameter('DAY_SALE_STAND'),90);
    InParams.ParamByName('SMT_RATE').AsString:=ShopGlobal.GetParameter('SMT_RATE');
    ReMsg:=Factor.ExecProc('TCostCalcForAnalyLister',InParams);
    if ReMsg<>'RCK_OK' then Raise Exception.Create('��Ʒ��ȫ�����������<'+ReMsg+'>');
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
    Inc(i);  //���+1
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
      //2012.08.29xhh�޸��½��������ж�
      if (e<=(bDate+b-1)) or (formatDatetime('YYYYMM',bDate+b-1)=formatDatetime('YYYYMM',e)) then
        e := fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day)));
    end;
    //2013.03.21���һ������ĩ��Ҫ��ʵ�������˼�¼��������ȡ
    if e>mDate then e:=mDate;
        
    RckBegDate:=bDate+b; //��ʼ����
    RckMonth:=FormatDatetime('YYYYMM',e);
    Label11.Caption := '���ں���['+RckMonth+']��̨��...';
    Update;

    //���ý�������(����)
    InParams.ParamByName('RCK_BEG_DATE').AsString:=FormatDatetime('YYYYMMDD',RckBegDate); //�½��˿�ʼ����
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDatetime('YYYYMMDD',e); //�½��˽�������

    //������Ʒ��̨����ˮ
    if Copy(CalcFlag,1,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('������Ʒ���˳���<'+ReMsg+'>');
      DoSetPrgPercent(i,6); //���ý���
    end;

    //�����˻�̨����ˮ
    if Copy(CalcFlag,2,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('�����ʻ����˳���<'+ReMsg+'>');
      DoSetPrgPercent(i,8); //���ý���
    end;

    //������̨�˽��˵ļ�¼
    if (Copy(CalcFlag,3,1)='1') or CheckAutoClsMthRck then
    begin
      //�жϵ�ǰ��������Ƿ�����½������� [��ǰ����ϵͳ������ǰһ���½�������]
      case reck_flag of
       1:CurEndDate:=fnTime.fnStrtoDate(formatDatetime('YYYYMM',Date())+'01')-1;
       2:CurEndDate:=fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',incMonth(date(),-1))+formatfloat('00',reck_day)));
      end;
      if (e<=CurEndDate) then
      begin
        InParams.ParamByName('CALC_CMD_IDX').AsInteger:=3;
        ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
        if ReMsg<>'RCK_OK' then Raise Exception.Create('�½��˳���<'+ReMsg+'>');
        DoSetPrgPercent(i,10); //���ý���
      end;
    end;

    if e>=eDate then break; //�·ݽ���
    b := b +round(e-(bDate+b))+1;
    SetBegTickCount(0);
  end;
  
  //���㵱ǰ�·�
  if FormatDateTime('YYYYMM',eDate)<>FormatDateTime('YYYYMM',mDate) then
  begin
    Inc(i);
    InParams.ParamByName('RCK_END_DATE').AsString:=FormatDateTime('YYYYMMDD',mDate); //�����������
    if Copy(CalcFlag,1,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=1;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('������Ʒ���˳���<'+ReMsg+'>');
      DoSetPrgPercent(i,5); //���ý���
    end;
    //�����˻�̨����ˮ
    if Copy(CalcFlag,2,1)='1' then
    begin
      InParams.ParamByName('CALC_CMD_IDX').AsInteger:=2;
      ReMsg:=Factor.ExecProc('TCostCalcForMonthReck',InParams);
      if ReMsg<>'RCK_OK' then Raise Exception.Create('�����ʻ����˳���<'+ReMsg+'>');
      DoSetPrgPercent(i,10); //���ý���
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
    //(���߰�) and (����ģʽ)
    if (ShopGlobal.NetVersion) and ShopGlobal.offline then Exit;
    //(������ǵ�����) and (��������) 
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
  if flag<>2 then //�����½���
  begin
    //���ݽ��������ж�
    case reck_flag of
     1://�µ׽���
      begin
        NearMthDate:=fnTime.fnStrtoDate(formatDatetime('YYYYMM',Global.SysDate)+'01')-1;
        result:=(Global.SysDate > NearMthDate+7);  //����7��
      end;
     2://ָ���ս���
      begin
        NearMthDate:=fnTime.fnStrtoDate(CheckValidDate(formatDatetime('YYYYMM',IncMonth(Global.SysDate,-1))+FormatFloat('00',reck_day)));
        result:=(Global.SysDate > NearMthDate+7);  //����7��
      end;
    end;
  end;
end;

end.
