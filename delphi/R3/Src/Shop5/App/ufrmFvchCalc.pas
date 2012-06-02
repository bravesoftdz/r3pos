unit ufrmFvchCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, cxSpinEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, StdCtrls, RzLabel, RzPrgres, RzButton, DB, ZBase, uKpiCalculate,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxDBEdit, cxDropDownEdit,
  cxCalendar, Grids, DBGridEh, Math;
  
type
  TfrmFvchCalc = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    PB: TRzProgressBar;
    btnStart: TRzBitBtn;
    labINFO: TLabel;
    Bevel1: TBevel;
    labInfomation: TLabel;
    RzLabel2: TRzLabel;
    P1_D1: TcxDateEdit;
    RzLabel3: TRzLabel;
    P1_D2: TcxDateEdit;
    RzLabel1: TRzLabel;
    edt_Fvch_Type: TcxComboBox;
    CB_CHECK: TCheckBox;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    Ds_BillName: TDataSource;
    CdsFvchOrder: TZQuery;
    CdsFvchData: TZQuery;
    CdsFvchDetail: TZQuery;
    CdsFvchGlide: TZQuery;
    GridPm: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    //控制进度
    FAllRecNo: integer; //所有记录
    FCurRecNo: integer; //当前记录
    
    FvchDataSQL: WideString;
    FvchDetailSQL: WideString;
    FvchGlideSQL: WideString;
      
    Rs_BillName: TZQuery;
    Rs_FvchFrame: TZQuery;
    Rs_FvchWhere: TZQuery;
    FPrgPercent: Integer;
    function  GetDeptID: string;
    function  GetBillName: Boolean;
    function  GetFvchName: Boolean;
    function  SetFvchNameFlag(const FVCH_GTYPE,SUBJECT_TYPE: string; var Rs_Fvch: TZQuery): Boolean;
    function  GetGodsSORT_ID(const SWHERE_ID: string): string;
    function  GetSQLCnd(const FieldType: Integer; const SWHERE_ID,Field_Name: string): string;
    function  GetFvchWhereCnd(const SWHERE_ID: string): WideString;
    function  GetFvchDataSQL(const FvchObj: TRecord_; const vBegDate,vEndDate: string): Boolean;
    function  FillFvchData(const FVCH_GTYPE,SUBJECT_TYPE,BegDate,EndDate:string; var Sub_Mny:Currency): Boolean;
    function  StartCalcFvchOrder(const FVCH_GTYPE,BillName:string): Boolean;
    procedure SetPrgPercent(const Value: Integer);
  public
    property PrgPercent:Integer read FPrgPercent write SetPrgPercent;
  end;

implementation

{$R *.dfm}

uses
  uShopUtil, uGlobal, uShopGlobal,uDsUtil,ObjCommon, uFnUtil;
 
procedure TfrmFvchCalc.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFvchCalc.btnStartClick(Sender: TObject);
var
  FVCH_GTYPE: string; //单据类型
  Rs_ChoiceBill: TZQuery;
begin
  if P1_D2.Date < P1_D1.Date then Raise Exception.Create(' 业务结束日期不能小于开始日期... ');
  btnStart.Enabled := False;
  try
    PB.Percent:=0;
    Rs_ChoiceBill:=TZQuery.Create(nil);
    Rs_ChoiceBill.Data:=Rs_BillName.Data;
    Rs_ChoiceBill.Filtered:=False;
    Rs_ChoiceBill.Filter:='A=1';
    Rs_ChoiceBill.Filtered:=true;
    //判断是否选择单据类型
    if Rs_ChoiceBill.RecordCount=0 then Raise Exception.Create('  请先选择要生成的单据  ');
    FAllRecNo:=Rs_ChoiceBill.RecordCount;
    Rs_ChoiceBill.First;
    while not Rs_ChoiceBill.Eof do
    begin
      FCurRecNo:=Rs_ChoiceBill.RecNo; //设置当前进度
      labInfomation.Caption:='正在生成['+Rs_ChoiceBill.FieldByName('CODE_NAME').AsString+']...';
      FVCH_GTYPE:=trim(Rs_ChoiceBill.FieldByName('CODE_ID').AsString);

      //开始生成1类别的凭证
      StartCalcFvchOrder(FVCH_GTYPE,trim(Rs_ChoiceBill.FieldByName('CODE_NAME').AsString));

      //补充一下进度
      PB.Percent:=Round((100*Rs_ChoiceBill.RecNo)/Rs_ChoiceBill.RecordCount);
      Rs_ChoiceBill.Next;
    end;
  finally
    PB.Percent:=100;
    labInfomation.Caption:='....';
    btnStart.Enabled := True;
    Rs_ChoiceBill.Free;
  end;
  ModalResult := MROK;
end;

procedure TfrmFvchCalc.SetPrgPercent(const Value: Integer);
var
  BigStep,SmallStep: Real;
begin
  FPrgPercent := Value;
  if (FCurRecNo>0) and (FCurRecNo<=FAllRecNo) and (FPrgPercent>0) then
  begin
    BigStep:=RoundTo((100/FAllRecNo),-2); //进度条的步长
    SmallStep:=RoundTo((BigStep/5)*FPrgPercent,-2);
    PB.Percent:=Round(BigStep*(FCurRecNo-1)+SmallStep);
    Update;
  end;
end;


procedure TfrmFvchCalc.FormCreate(Sender: TObject);
begin
  inherited;
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  
  //创建数据集对象
  Rs_BillName:=TZQuery.Create(self);
  Rs_FvchFrame:=TZQuery.Create(self);
  Rs_FvchWhere:=TZQuery.Create(self);

  GetBillName; //取SQL;
  Ds_BillName.DataSet:=Rs_BillName;
  edt_Fvch_Type.ItemIndex:=0;
  edt_Fvch_Type.Enabled:=False;
  CB_CHECK.Checked:=(trim(ShopGlobal.GetParameter('FVCH_BILL_CHECK'))='1');

  //取凭证模板
  GetFvchName;
end;

function TfrmFvchCalc.StartCalcFvchOrder(const FVCH_GTYPE,BillName:string): Boolean;
var
  msg: string;
  i,allDay: integer;
  BegDate,EndDate: TDate;
  InParams: TftParamList;
  JieFangMny: Currency;
  DaiFangMny: Currency;
begin
  result:=False;
  try
    i:=1;
    BegDate:=P1_D1.Date; //开始日期
    EndDate:=P1_D2.Date; //结束日期
    allDay:=Round(P1_D2.Date-P1_D1.Date);
    InParams:=TftParamList.Create(nil);
    InParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    InParams.ParamByName('FVCH_GTYPE').AsString:=FVCH_GTYPE;
    SetPrgPercent(1);  //进度1111
    //本次实现1天1张凭证
    while (BegDate<EndDate) do
    begin
      InParams.ParamByName('FVCH_ID').AsString:='';
      //1、批量取数据
      Factor.BeginBatch;
      try
        Factor.AddBatch(CdsFvchOrder,'TFvchOrder',InParams);
        Factor.AddBatch(CdsFvchData,'TFvchData',InParams);
        Factor.AddBatch(CdsFvchDetail,'TFvchDetail',InParams);
        Factor.AddBatch(CdsFvchGlide,'TFvchGlide',InParams);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      SetPrgPercent(2);  //进度2222
      //2、编辑凭证主表数据
      CdsFvchOrder.Append;
      CdsFvchOrder.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
      CdsFvchOrder.FieldByName('SHOP_ID').AsString:=Global.SHOP_ID;
      CdsFvchOrder.FieldByName('DEPT_ID').AsString:=GetDeptID;
      CdsFvchOrder.FieldByName('FVCH_ID').AsString:=TSequence.NewId(); //NewID
      CdsFvchOrder.FieldByName('FVCH_DATE').AsInteger:=StrTointDef(FormatDatetime('YYYYMMDD',BegDate),0); 
      CdsFvchOrder.FieldByName('FVCH_ATTACH').AsInteger:=0;
      CdsFvchOrder.FieldByName('CREA_USER').AsString:=Global.UserID;
      CdsFvchOrder.FieldByName('FVCH_FLAG').AsString:='0';
      CdsFvchOrder.Post; 

      //3、开始填冲借方数据(借方[SUBJECT_TYPE='1'])
      FillFvchData(FVCH_GTYPE,'1',FormatDatetime('YYYYMMDD',BegDate),FormatDatetime('YYYYMMDD',EndDate),JieFangMny);
      SetPrgPercent(3);  //进度3333
      //4、开始填冲贷方数据(贷方[SUBJECT_TYPE='2'])
      FillFvchData(FVCH_GTYPE,'2',FormatDatetime('YYYYMMDD',BegDate),FormatDatetime('YYYYMMDD',EndDate),DaiFangMny);

      //5、判断借贷方金额是否相等
      if RoundTo(JieFangMny ,-2) <> RoundTo(DaiFangMny ,-2) then
      begin
        msg:=' 业务单据['+BillName+'] ';
        if BegDate = EndDate then
          msg:=msg+' 日期['+FormatDatetime('YYYY-MM-DD',BegDate)+']'
        else
          msg:=msg+' 日期['+FormatDatetime('YYYY-MM-DD',BegDate)+' ~ '+FormatDatetime('YYYY-MM-DD',EndDate)+' ]';
        msg:=msg+'生成凭证借贷不平衡'+#13+'[借方:'+FormatFloat('#0.00',RoundTo(JieFangMny,-2))+'和贷方:'+FormatFloat('#0.00', RoundTo(DaiFangMny,-2))+']！ ';
        Raise Exception.Create(msg);
      end;
      SetPrgPercent(4);  //进度4444

      //6、开始提交保存数据
      if CdsFvchData.RecordCount>0 then
      begin
        Factor.BeginBatch;
        try
          Factor.AddBatch(CdsFvchOrder,'TFvchOrder',InParams);
          Factor.AddBatch(CdsFvchData,'TFvchData',InParams);
          Factor.AddBatch(CdsFvchDetail,'TFvchDetail',InParams);
          Factor.AddBatch(CdsFvchGlide,'TFvchGlide',InParams);
          Factor.CommitBatch;
        except
          Factor.CancelBatch;
          Raise;
        end;
      end;
      SetPrgPercent(5);  //进度5555  
      //日期+1天
      BegDate:=BegDate+1;
    end;
  finally
    InParams.Free;
  end;
end;

function TfrmFvchCalc.GetDeptID: string;
var
  rs: TZQuery;
begin
  result:='#';
  rs:=Global.GetZQueryFromName('CA_USERS');
  //定位部门:
  if rs.Locate('USER_ID',Global.UserID,[]) then
    result:=trim(rs.FieldByName('DEPT_ID').AsString);
end;

function TfrmFvchCalc.GetBillName: Boolean;
var
  str: string;
  cxFields: string;
begin
  //取单据名称
  case Factor.iDbType of
   0,5:
    begin
      cxFields:=
        ' substr(TAB_SQL,1,255)as SQL1 '+
        ',substr(TAB_SQL,256,510)as SQL2'+
        ',substr(TAB_SQL,512,256)as SQL3'+
        ',substr(TAB_SQL,769,256)as SQL4'+
        ',substr(TAB_SQL,1025,256)as SQL5'+
        ',substr(TAB_SQL,1281,256)as SQL6'+
        ',substr(TAB_SQL,1537,256)as SQL7'+
        ',substr(TAB_SQL,1793,256)as SQL8'+
        ',substr(TAB_SQL,2049,256)as SQL9'+
        ',substr(TAB_SQL,2305,256)as SQL10'+
        ',substr(TAB_SQL,2561,256)as SQL11'+
        ',substr(TAB_SQL,2817,256)as SQL12'+
        ',substr(TAB_SQL,3073,256)as SQL13'+
        ',substr(TAB_SQL,3329,256)as SQL14'+
        ',substr(TAB_SQL,3585,256)as SQL15'+
        ',substr(TAB_SQL,3841,256)as SQL16 ';
    end;
   else
     cxFields:='TAB_SQL as SQL1 ';
  end;
  
  str:='select 0 as A,A.CODE_ID,A.CODE_NAME,DATE_FIELD,'+cxFields+' from PUB_PARAMS A,ACC_FVCHDATA_SQL B '+
       ' where A.CODE_ID=B.FVCH_GTYPE and A.TYPE_CODE=''BILL_NAME'' ';
  Rs_BillName.Close;
  Rs_BillName.SQL.Text:=ParseSQL(Factor.iDbType, str);
  Factor.Open(Rs_BillName);
end;

function TfrmFvchCalc.GetFvchName: Boolean;
var
  Str: widestring;
begin
  //判断是否定义凭证模板(ACC_FVCHFRAME)
  Str:=
     'select FVCH_GTYPE,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,SWHERE,DATAFLAG,SUBJECT_TYPE,SEQNO as FLAG from ACC_FVCHFRAME '+
     ' where TENANT_ID='+IntToStr(Global.TENANT_ID);
  Rs_FvchFrame.Close;
  Rs_FvchFrame.SQL.Text:=Str;
  Factor.Open(Rs_FvchFrame);

  //取条件SQL:
  Str:=
    'select B.FVCH_GTYPE as FVCH_GTYPE'+     //单据类型
          ',A.SWHERE as SWHERE'+             //条件ID
          ',A.FIELD_NAME as FIELD_NAME'+     //字段名称
          ',A.FIELD_EQUE as FIELD_EQUE'+     //条件关系
          ',A.FIELD_VALUE as FIELD_VALUE'+   //字段值
    ' from ACC_FVCHSWHERE A,ACC_FVCHFRAME B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SWHERE=B.SWHERE '+
    ' order by B.FVCH_GTYPE';
  Rs_FvchWhere.Close;
  Rs_FvchWhere.SQL.Text:=Str;
  Factor.Open(Rs_FvchWhere);
  //if Rs_FvchFrame.RecordCount=0 then Raise Exception.Create(' 没有找到凭证模板... ');
end;

function TfrmFvchCalc.FillFvchData(const FVCH_GTYPE,SUBJECT_TYPE,BegDate,EndDate:string; var Sub_Mny:Currency): Boolean;
var
  SEQ_NO: integer;
  FVCH_DID: string;  //分录ID
  FindField: string;  //查找字段
  Rs_Fvch: TZQuery;
  Rs_Data: TZQuery;
  FvchObj: TRecord_;
begin
  result:=False;
  try
    Sub_Mny:=0;
    FvchObj:=TRecord_.Create;
    Rs_Fvch:=TZQuery.Create(nil);
    Rs_Data:=TZQuery.Create(nil);
    if not SetFvchNameFlag(FVCH_GTYPE, SUBJECT_TYPE, Rs_Fvch) then Exit; //初始化凭证模板
    if not Rs_Fvch.Active then Exit;
    //根据凭证模板开始循环
    Rs_Fvch.First;
    while not Rs_Fvch.Eof do
    begin
      FvchObj.ReadFromDataSet(Rs_Fvch);
      if GetFvchDataSQL(FvchObj,BegDate,EndDate) then //生成对应SQLITE
      begin
        SEQ_NO:=CdsFvchData.RecordCount+1;
        //取分录的数据(ACC_FVCHDATA)
        Rs_Data.Close;
        Rs_Data.SQL.Text:=FvchDataSQL;
        Factor.Open(Rs_Data);
        if not Rs_Data.IsEmpty then
        begin
          FVCH_DID:=TSequence.NewId(); //分录ID
          CdsFvchData.Append;
          CdsFvchData.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
          CdsFvchData.FieldByName('SHOP_ID').AsString:=Global.SHOP_ID;
          CdsFvchData.FieldByName('FVCH_ID').AsString:=CdsFvchOrder.FieldByName('FVCH_ID').AsString;
          CdsFvchData.FieldByName('FVCH_DID').AsString:=FVCH_DID;
          CdsFvchData.FieldByName('SEQNO').AsInteger:=SEQ_NO;
          CdsFvchData.FieldByName('SUBJECT_NO').AsString:=FvchObj.FieldByName('SUBJECT_NO').AsString;
          CdsFvchData.FieldByName('SUMMARY').AsString:=FvchObj.FieldByName('SUMMARY').AsString;
          CdsFvchData.FieldByName('SUBJECT_TYPE').AsString:=SUBJECT_TYPE;
          CdsFvchData.FieldByName('OPER_DATE').AsInteger:=StrTointDef(BegDate,0); ;
          //查找对应字段:
          FindField:=trim(FvchObj.FieldByName('AMONEY').AsString);
          if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
            CdsFvchData.FieldByName('AMONEY').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;

          //数量字段
          FindField:=trim(FvchObj.FieldByName('AMOUNT').AsString);
          if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
            CdsFvchData.FieldByName('AMOUNT').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;

          //单价字段
          FindField:=trim(FvchObj.FieldByName('APRICE').AsString);
          if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
            CdsFvchData.FieldByName('APRICE').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;
          CdsFvchData.Post;

          //判断是否有明细插入明细数据(ACC_FVCHDETAIL)
          if FvchDetailSQL<>'' then
          begin
            Rs_Data.Close;
            Rs_Data.SQL.Text:=FvchDetailSQL;
            Factor.Open(Rs_Data);
            Rs_Data.First;
            while not Rs_Data.Eof do
            begin
              SEQ_NO:=CdsFvchDetail.RecordCount+1;
              CdsFvchDetail.Append;
              CdsFvchDetail.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
              CdsFvchDetail.FieldByName('SHOP_ID').AsString:=Global.SHOP_ID;
              CdsFvchDetail.FieldByName('FVCH_TID').AsString:=TSequence.NewId();
              CdsFvchDetail.FieldByName('FVCH_ID').AsString:=CdsFvchOrder.FieldByName('FVCH_ID').AsString;
              CdsFvchDetail.FieldByName('FVCH_DID').AsString:=FVCH_DID;
              CdsFvchDetail.FieldByName('SEQNO').AsInteger:=SEQ_NO;
              CdsFvchDetail.FieldByName('SUMMARY').AsString:=FvchObj.FieldByName('SUMMARY').AsString;
              CdsFvchDetail.FieldByName('OPER_DATE').AsInteger:=StrTointDef(BegDate,0); ;
              CdsFvchDetail.FieldByName('SUBJ_OTHR1').AsString:='';
              CdsFvchDetail.FieldByName('SUBJ_OTHR2').AsString:='';
              CdsFvchDetail.FieldByName('SUBJ_OTHR3').AsString:='';
              CdsFvchDetail.FieldByName('SUBJ_OTHR4').AsString:='';
              CdsFvchDetail.FieldByName('SUBJ_OTHR5').AsString:='';
              //按人员核算:
              if Rs_Data.FindField('GUIDE_USER')<>nil then
                CdsFvchDetail.FieldByName('SUBJ_USER').AsString:=Rs_Data.FieldByName('GUIDE_USER').AsString;
              //按部门核算:
              if Rs_Data.FindField('DEPT_ID')<>nil then
                CdsFvchDetail.FieldByName('SUBJ_DEPT').AsString:=Rs_Data.FieldByName('DEPT_ID').AsString;
              //按门店核算:
              if Rs_Data.FindField('SHOP_ID')<>nil then
                CdsFvchDetail.FieldByName('SUBJ_SHOP').AsString:=Rs_Data.FieldByName('SHOP_ID').AsString;
              //按客户核算:
              if Rs_Data.FindField('CLIENT_ID')<>nil then
                CdsFvchDetail.FieldByName('SUBJ_CLIENT').AsString:=Rs_Data.FieldByName('CLIENT_ID').AsString;
              //金额字段
              FindField:=trim(FvchObj.FieldByName('AMONEY').AsString);
              if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
                CdsFvchDetail.FieldByName('AMONEY').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;
              //数量字段
              FindField:=trim(FvchObj.FieldByName('AMOUNT').AsString);
              if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
                CdsFvchDetail.ParamByName('AMOUNT').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;
              //单价字段
              FindField:=trim(FvchObj.FieldByName('APRICE').AsString);
              if (FindField<>'') and (Rs_Data.FindField(FindField)<>nil) then
                CdsFvchDetail.ParamByName('APRICE').AsFloat:=Rs_Data.FieldByName(FindField).AsFloat;
              CdsFvchDetail.Post;
              Rs_Data.Next;
            end;
          end;
          //关联单据保存(ACC_FVCHGLIDE)
          Rs_Data.Close;
          Rs_Data.SQL.Text:=FvchGlideSQL;
          Factor.Open(Rs_Data);
          Rs_Data.First;
          while not Rs_Data.Eof do
          begin
            FVCH_DID:=trim(Rs_Data.FieldByName('ORDER_ID').AsString);
            if not (CdsFvchGlide.Locate('FVCH_GID',FVCH_DID,[])) then //没有定位到则新插入
            begin
              CdsFvchGlide.Append;
              CdsFvchGlide.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
              CdsFvchGlide.FieldByName('FVCH_GLID').AsString:=TSequence.NewId();
              CdsFvchGlide.FieldByName('FVCH_ID').AsString:=CdsFvchOrder.FieldByName('FVCH_ID').AsString;
              CdsFvchGlide.FieldByName('FVCH_GTYPE').AsString:=FVCH_GTYPE;
              CdsFvchGlide.FieldByName('FVCH_GID').AsString:=FVCH_DID; 
              CdsFvchGlide.Post; 
            end;
            Rs_Data.Next;
          end;
        end; //if not Rs_Data.IsEmpty then
      end;  // if GetFvchDataSQL(FvchObj) then //生成对应SQLITE
      Rs_Fvch.Next;
    end; //while not Rs_Fvch.Eof do
  finally
    Rs_Fvch.Free;
    Rs_Data.Free;
    FvchObj.Free;
  end;
end;

function TfrmFvchCalc.SetFvchNameFlag(const FVCH_GTYPE,SUBJECT_TYPE: string; var Rs_Fvch: TZQuery): Boolean;
begin
  result:=False;
  if not Rs_FvchFrame.Active then Exit; 
  //循环生成凭证分录
  try
    Rs_FvchFrame.Filtered:=False;
    Rs_FvchFrame.Filter:='FVCH_GTYPE='''+FVCH_GTYPE+''' and SUBJECT_TYPE='''+SUBJECT_TYPE+''' ';  
    Rs_FvchFrame.Filtered:=True;
    Rs_FvchFrame.First;
    while Rs_FvchFrame.Eof do
    begin
      Rs_FvchFrame.Edit;
      Rs_FvchFrame.FieldByName('FLAG').AsInteger:=0;
      Rs_FvchFrame.Post;
      Rs_FvchFrame.Next;
    end;
    result:=true;
    Rs_Fvch.Data:=Rs_FvchFrame.Data; //设置数据包
  except    
  end;
end;

//返回查询条件
function TfrmFvchCalc.GetSQLCnd(const FieldType: Integer; const SWHERE_ID,Field_Name: string): string;
var
  Value_IDS,CurValue: string;
  PosIdx,Field_Eque: Integer;
begin
  result:='';
  try
    Value_IDS:='';
    //过滤:(1)单据条件SWHERE;(2)字段名称FIELD_NAME;
    Rs_FvchWhere.Filtered:=False;
    Rs_FvchWhere.Filter:='SWHERE='''+trim(SWHERE_ID)+''' and FIELD_NAME='''+Field_Name+''' ';
    Rs_FvchWhere.Filtered:=true;
    if Rs_FvchWhere.RecordCount=0 then Exit; //没有条件则退出
    if trim(UpperCase(Rs_FvchWhere.FieldbyName('FIELD_EQUE').AsString))='IN' then Field_Eque:=1 else Field_Eque:=-1;
    //开始循环取条件值
    Rs_FvchWhere.First;
    while not Rs_FvchWhere.Eof do
    begin
      CurValue:=trim(Rs_FvchWhere.FieldbyName('FIELD_VALUE').AsString); //当前字段值
      case FieldType of
       0: if Value_IDS='' then Value_IDS:=CurValue else Value_IDS:=Value_IDS+','+CurValue;  //整型
       1: if Value_IDS='' then Value_IDS:=CurValue else Value_IDS:=Value_IDS+','+CurValue;  //字符型
      end;
      Rs_FvchWhere.Next;
    end;
    //组合条件
    case FieldType of
     0: //整型
      begin
        case Field_Eque of
         -1: //not in
          begin
            if Rs_FvchWhere.RecordCount=1 then //单条记录
              result:='('+Field_Name+'<>'+Value_IDS+')'
            else
              result:='('+Field_Name+' not in ('+Value_IDS+'))';
          end;
           1: //in
          begin
            if Rs_FvchWhere.RecordCount=1 then //单条记录
              result:='('+Field_Name+'='+Value_IDS+')'
            else
              result:='('+Field_Name+' in ('+Value_IDS+'))';
          end;
        end;
      end;
     1: //字符型
      begin
        case Field_Eque of
         -1: //not in
          begin
            if Rs_FvchWhere.RecordCount=1 then //单条记录
              result:='('+Field_Name+'<>'''+Value_IDS+''')'
            else
              result:='('+Field_Name+' not in('''+StringReplace(Value_IDS,',',''',''',[rfReplaceAll])+'''))';
          end;
           1: //in
          begin
            if Rs_FvchWhere.RecordCount=1 then //单条记录
              result:='('+Field_Name+'='''+Value_IDS+''')'
            else
              result:='('+Field_Name+' in('''+StringReplace(Value_IDS,',',''',''',[rfReplaceAll])+'''))';
          end;
        end; //end case Field_Eque of
      end; //end字符型
    end; //end case FieldType of
  finally
    Rs_FvchWhere.Filtered:=False;
    Rs_FvchWhere.Filter:='';      
  end;
end;

//返回商品分类(SORT_ID1)
function TfrmFvchCalc.GetGodsSORT_ID(const SWHERE_ID: string): string;
var
  Str: string;
  CurID: string;
  Rs_Sort: TZQuery;
begin
  result:='';
  Str:='';
  Rs_Sort:=Global.GetZQueryFromName('PUB_GOODSSORT');
  if Rs_Sort=nil then Exit;
  //过滤:(1)单据条件SWHERE;(2)字段名称FIELD_NAME;
  Rs_FvchWhere.Filtered:=False;
  Rs_FvchWhere.Filter:='SWHERE='''+trim(SWHERE_ID)+''' and FIELD_NAME=''SORT_ID1'' ';
  Rs_FvchWhere.Filtered:=true;
  if Rs_FvchWhere.RecordCount=0 then Exit; //没有条件则退出

  //开始循环取条件值
  Rs_FvchWhere.First;
  while not Rs_FvchWhere.Eof do
  begin
    CurID:=trim(Rs_FvchWhere.FieldbyName('FIELD_VALUE').AsString); //当前字段值
    if Rs_Sort.Locate('SORT_ID',CurID,[]) then
    begin
      if trim(Rs_Sort.FieldByName('LEVEL_ID').AsString)<>'' then
      begin
        if Str='' then
          Str:='(LEVEL_ID like '''+trim(Rs_Sort.FieldByName('LEVEL_ID').AsString)+'%'')'
        else
          Str:=Str+' or (LEVEL_ID like '''+trim(Rs_Sort.FieldByName('LEVEL_ID').AsString)+'%'')';
      end;
    end;
    Rs_FvchWhere.Next;
  end;
 
  if Rs_FvchWhere.RecordCount>1 then Str:='('+Str+')';
  if Str<>'' then
  begin
    result:='(select SORT_ID from VIW_GOODSSORT where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''02'',''12'') and SORT_TYPE=1 and '+Str+')';
    if trim(UpperCase(Rs_FvchWhere.FieldbyName('FIELD_EQUE').AsString))='IN' then
      result:=' SORT_ID1 in '+result 
    else
      result:=' SORT_ID1 not in '+result; 
  end;
end;

function TfrmFvchCalc.GetFvchWhereCnd(const SWHERE_ID: string): WideString;
 //设置当前单据有几个条件字段
 function SetFvchFrameList(var FvchFrameList: TZQuery): Boolean;
 var vRecNo: integer;
 begin
   result:=False;
   try
     //创建数据集
     FvchFrameList.Close;
     FvchFrameList.FieldDefs.Clear;
     FvchFrameList.FieldDefs.Add('FIELD_ID',ftInteger,0,true);
     FvchFrameList.FieldDefs.Add('FIELD_NAME',ftstring,30,true);
     FvchFrameList.CreateDataSet;
     //循环生成
     Rs_FvchWhere.Filtered:=False;
     Rs_FvchWhere.Filter:='SWHERE='''+trim(SWHERE_ID)+''' ';
     Rs_FvchWhere.Filtered:=true;
     Rs_FvchWhere.First;
     while not Rs_FvchWhere.Eof do
     begin
       vRecNo:=FvchFrameList.RecordCount+1;
       if not(FvchFrameList.Locate('FIELD_NAME',trim(Rs_FvchWhere.FieldByName('FIELD_NAME').AsString),[])) then
       begin
         FvchFrameList.Append;
         FvchFrameList.FieldByName('FIELD_ID').AsInteger:=vRecNo+1;
         FvchFrameList.FieldByName('FIELD_NAME').AsString:=trim(Rs_FvchWhere.FieldByName('FIELD_NAME').AsString);
         FvchFrameList.Post;
       end;
       Rs_FvchWhere.Next;
     end;
     result:=true;
   finally
     Rs_FvchWhere.Filtered:=False;
     Rs_FvchWhere.Filter:='';
   end;
 end;
var
  vCnd:string;
  Field_Name:string; //字段名
  Rs_FvchList:TZQuery; //1张凭证模板的字段条件List
begin
  result:='';
  //组合SQL条件
  try
    Rs_FvchList:=TZQuery.Create(nil);
    if SetFvchFrameList(Rs_FvchList) then //设置1条凭证模板内包含的条件字段
    begin
      //开始循环凭证模板字段条件
      Rs_FvchList.First;   
      while not Rs_FvchList.Eof do
      begin
        vCnd:='';
        Field_Name:=trim(Rs_FvchList.FieldByName('FIELD_NAME').AsString); //字段名
        //字段特殊处理:
        if Field_Name='IS_PRESENT' then //整型字段
          vCnd:=GetSQLCnd(0,SWHERE_ID,'IS_PRESENT')
        else if Field_Name='SORT_ID1' then //商品分类[树型结构]
          vCnd:=GetGodsSORT_ID(SWHERE_ID)
        else //其他通用字段
          vCnd:=GetSQLCnd(1,SWHERE_ID,Field_Name);
          
        if result='' then
          result:=vCnd
        else
          result:=result+' and '+vCnd;
        Rs_FvchList.Next;
      end;
    end; //条件字段循环 end
    
    if Rs_FvchList.RecordCount>1 then  result:='('+result+')';
  finally
    Rs_FvchList.Free;
  end;
end;

function TfrmFvchCalc.GetFvchDataSQL(const FvchObj: TRecord_; const vBegDate,vEndDate:string): Boolean;
  function GetViewTab(FVCH_GTYPE: string): string;
  var str,Cnd,DateFields: string;
  begin
    result:='';
    if Rs_BillName.Locate('FVCH_GTYPE',FVCH_GTYPE,[]) then
    begin
      case Factor.iDbType of
       0,5:
        begin
          str:=
             Rs_BillName.FieldByName('SQL1').AsString+Rs_BillName.FieldByName('SQL2').AsString+Rs_BillName.FieldByName('SQL3').AsString+
             Rs_BillName.FieldByName('SQL4').AsString+Rs_BillName.FieldByName('SQL5').AsString+Rs_BillName.FieldByName('SQL6').AsString+
             Rs_BillName.FieldByName('SQL7').AsString+Rs_BillName.FieldByName('SQL8').AsString+Rs_BillName.FieldByName('SQL9').AsString+
             Rs_BillName.FieldByName('SQL10').AsString+Rs_BillName.FieldByName('SQL11').AsString+Rs_BillName.FieldByName('SQL12').AsString+
             Rs_BillName.FieldByName('SQL13').AsString+Rs_BillName.FieldByName('SQL14').AsString+Rs_BillName.FieldByName('SQL15').AsString+
             Rs_BillName.FieldByName('SQL16').AsString;
        end;
       else
        str:=Rs_BillName.FieldByName('SQL1').AsString;
      end;
      //过滤企业条件
      Cnd:=' and A.TENANT_ID='+IntToStr(Global.TENANT_ID);
      //过滤业务日期条件
      DateFields:=trim(Rs_BillName.FieldByName('DATE_FIELD').AsString);
      if vBegDate<vEndDate then
        Cnd:=Cnd+' and ('+DateFields+'>='+vBegDate+' and '+DateFields+'<='+vEndDate+')'
      else
        Cnd:=Cnd+' and '+DateFields+'='+vBegDate+' ';
      result:='('+str+')';
    end;
  end;
var
  str: string;
  Fields_mny: string;
  Fields_amt: string;
  Fields_price: string;
  cxFields,GroupFields: string;
  ViwTab,ViwCnd: string;
  WhereCnd,CurCnd: string;
  FilterCnd: string;
begin
  Result:=False;
  ViwCnd:='';
  ViwTab:='';
  CurCnd:='';
  WhereCnd:='';
  cxFields:='';
  GroupFields:='';
  FvchDataSQL:='';              
  FvchDetailSQL:='';
  if Rs_FvchFrame.Locate('SEQNO',FvchObj.FieldByName('SEQNO').AsInteger,[]) then
  begin
    if Rs_FvchFrame.FieldByName('FLAG').AsInteger=1 then Exit; //此条件已取过
    Fields_mny:=trim(FvchObj.FieldByName('AMONEY').AsString);
    Fields_amt:=trim(FvchObj.FieldByName('AMOUNT').AsString);
    Fields_price:=trim(FvchObj.FieldByName('APRICE').AsString);
    if Fields_mny<>'' then
      cxFields:='sum('+Fields_mny+')as '+Fields_mny+' ';
    if Fields_amt<>'' then
    begin
      if cxFields='' then
        cxFields:='sum('+Fields_amt+')as '+Fields_amt+' '
      else
        cxFields:=cxFields+',sum('+Fields_amt+')as '+Fields_amt+' ';
    end;
    if (Fields_mny<>'') and (Fields_amt<>'') and (Fields_price<>'') then
      cxFields:=cxFields+',(case when sum('+Fields_amt+')<>0 then cast(sum('+Fields_mny+')/sum('+Fields_amt+') as decimal(18,3)) else 0 end)as '+Fields_price+' ';

    //取查询条件(单据类型等条件都满足后)
    try
      FilterCnd:=
        'FVCH_GTYPE='''+FvchObj.FieldByName('FVCH_GTYPE').AsString+''' and '+
        ' SUBJECT_NO='''+FvchObj.FieldByName('SUBJECT_NO').AsString+''' and '+
        ' SUMMARY='''+FvchObj.FieldByName('SUMMARY').AsString+''' and '+
        ' AMONEY='''+FvchObj.FieldByName('AMONEY').AsString+''' and '+
        ' AMOUNT='''+FvchObj.FieldByName('AMOUNT').AsString+''' and '+
        ' APRICE='''+FvchObj.FieldByName('APRICE').AsString+''' and '+
        ' DATAFLAG='''+FvchObj.FieldByName('DATAFLAG').AsString+''' and '+
        ' SUBJECT_TYPE='''+FvchObj.FieldByName('SUBJECT_TYPE').AsString+''' ';
      Rs_FvchFrame.Filtered:=False;
      Rs_FvchFrame.Filter:=FilterCnd;
      Rs_FvchFrame.Filtered:=true;
      FilterCnd:='';
      Rs_FvchFrame.First;
      while not Rs_FvchFrame.Eof do
      begin
        CurCnd:=GetFvchWhereCnd(Rs_FvchFrame.FieldByName('SWHERE').AsString);
        //连接条件
        if CurCnd<>'' then
        begin
          if ViwCnd='' then
            ViwCnd:=CurCnd
          else
            ViwCnd:=ViwCnd+' or '+CurCnd;
        end;
        Rs_FvchFrame.Edit;
        Rs_FvchFrame.FieldByName('FLAG').AsInteger:=1; //设置取标记
        Rs_FvchFrame.Post;
        Rs_FvchFrame.Next;
      end;
      ViwCnd:=' where ('+ViwCnd+')';
    finally
      Rs_FvchFrame.Filtered:=False;
      Rs_FvchFrame.Filter:='';
    end;

    ViwTab:=GetViewTab(FvchObj.FieldByName('FVCH_GTYPE').AsString);
    //生成此条模板的凭证分录SQL
    FvchDataSQL:='select '+cxFields+' from '+ViwTab+' as tp '+ViwCnd;

    //生成插入单据关联(ACC_FVCHGLIDE)
    FvchGlideSQL:=
      'select ORDER_ID from '+ViwTab+' as tp '+ViwCnd+
      ' and ORDER_ID not in (select FVCH_GID from ACC_FVCHGLIDE and FVCH_GTYPE='''+FvchObj.FieldByName('FVCH_GTYPE').AsString+''')';

    //生成此条模板的凭证分录明细SQL[专项目前没有对应字段]
    FilterCnd:=trim(FvchObj.FieldByName('DATAFLAG').AsString);
    if Copy(FilterCnd,1,1)='1' then
      GroupFields:='GUIDE_USER';
    if Copy(FilterCnd,2,1)='1' then
    begin
      if GroupFields='' then
        GroupFields:='DEPT_ID'
      else
        GroupFields:=GroupFields+',DEPT_ID';
    end;
    if Copy(FilterCnd,3,1)='1' then
    begin
      if GroupFields='' then
        GroupFields:='SHOP_ID'
      else
        GroupFields:=GroupFields+',SHOP_ID';
    end;
    if Copy(FilterCnd,4,1)='1' then
    begin
      if GroupFields='' then
        GroupFields:='CLIENT_ID'
      else
        GroupFields:=GroupFields+',CLIENT_ID';
    end;
    if GroupFields='' then
      FvchDetailSQL:=''
    else
      FvchDetailSQL:='select '+GroupFields+','+cxFields+' from '+ViwTab+' as tp '+ViwCnd+' group by '+GroupFields;
    result:=true;
  end;
end;

procedure TfrmFvchCalc.N2Click(Sender: TObject);
var
  r:integer;
begin
  r := Rs_BillName.RecNo;
  Rs_BillName.DisableControls;
  try
    Rs_BillName.First;
    while not Rs_BillName.Eof do
    begin
      Rs_BillName.Edit;
      Rs_BillName.FieldbyName('A').AsInteger := 1;
      Rs_BillName.Post;
      Rs_BillName.Next;
    end;
  finally
    if r>0 then Rs_BillName.RecNo := r;
    Rs_BillName.EnableControls;
  end;
end;

procedure TfrmFvchCalc.N3Click(Sender: TObject);
var
  r:integer;
begin
  r := Rs_BillName.RecNo;
  Rs_BillName.DisableControls;
  try
    Rs_BillName.First;
    while not Rs_BillName.Eof do
    begin
      Rs_BillName.Edit;
      if Rs_BillName.FieldbyName('A').AsInteger = 0 then
         Rs_BillName.FieldbyName('A').AsInteger := 1
      else
         Rs_BillName.FieldbyName('A').AsInteger := 0 ;
      Rs_BillName.Post;
      Rs_BillName.Next;
    end;
  finally
    if r>0 then Rs_BillName.RecNo := r;
    Rs_BillName.EnableControls;
  end;
end;

procedure TfrmFvchCalc.N4Click(Sender: TObject);
var
  r:integer;
begin
  r := Rs_BillName.RecNo;
  Rs_BillName.DisableControls;
  try
    Rs_BillName.First;
    while not Rs_BillName.Eof do
    begin
      Rs_BillName.Edit;
      Rs_BillName.FieldbyName('A').AsInteger := 0;
      Rs_BillName.Post;
      Rs_BillName.Next;
    end;
  finally
    if r>0 then Rs_BillName.RecNo := r;
    Rs_BillName.EnableControls;
  end;
end;

end.
