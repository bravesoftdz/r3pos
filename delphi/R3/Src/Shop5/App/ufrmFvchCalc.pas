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
    FvchOrder: TZQuery;
    CB_CHECK: TCheckBox;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    Ds_BillName: TDataSource;
    CdsFvchOrder: TZQuery;
    CdsFvchData: TZQuery;
    CdsFvchDetail: TZQuery;
    CdsFvchGlide: TZQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FvchDataSQL: string;
    FvchDetailSQL: string;
    FvchGlideSQL: string;
      
    Rs_BillName: TZQuery;
    Rs_FvchFrame: TZQuery;
    FPrgPercent: Integer;
    function  GetDeptID: string;
    function  GetBillName: Boolean;
    function  GetFvchName: Boolean;
    function  SetFvchNameFlag(const FVCH_GTYPE,SUBJECT_TYPE: string; var Rs_Fvch: TZQuery): Boolean;
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
    Rs_ChoiceBill.First;
    while not Rs_ChoiceBill.Eof do
    begin
      labInfomation.Caption:='正在生成['+Rs_ChoiceBill.FieldByName('CODE_NAME').AsString+']...';
      FVCH_GTYPE:=trim(Rs_ChoiceBill.FieldByName('CODE_ID').AsString);
      //开始生成1类别的凭证
      StartCalcFvchOrder(FVCH_GTYPE,trim(Rs_ChoiceBill.FieldByName('CODE_NAME').AsString));
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
begin
  FPrgPercent := Value;
  PB.Percent := Value;
  Update;
end;


procedure TfrmFvchCalc.FormCreate(Sender: TObject);
begin
  inherited;
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  
  //创建数据集对象
  Rs_BillName:=TZQuery.Create(self);
  Rs_FvchFrame:=TZQuery.Create(self);

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
        ' substr(TAB_SQL,1,256)as SQL1 '+
        ',substr(TAB_SQL,257,256)as SQL2'+
        ',substr(TAB_SQL,513,256)as SQL3'+
        ',substr(TAB_SQL,768,256)as SQL4'+
        ',substr(TAB_SQL,1024,256)as SQL5'+
        ',substr(TAB_SQL,1280,256)as SQL6'+
        ',substr(TAB_SQL,1536,256)as SQL7'+
        ',substr(TAB_SQL,1792,256)as SQL8'+
        ',substr(TAB_SQL,2048,256)as SQL9'+
        ',substr(TAB_SQL,2304,256)as SQL10'+
        ',substr(TAB_SQL,2560,256)as SQL11'+
        ',substr(TAB_SQL,2816,256)as SQL12'+
        ',substr(TAB_SQL,3072,256)as SQL13'+
        ',substr(TAB_SQL,3328,256)as SQL14'+
        ',substr(TAB_SQL,3584,256)as SQL15'+
        ',substr(TAB_SQL,3840,256)as SQL16 ';
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
  cxFields: widestring;
begin
  case Factor.iDbType of
   0,5:
    begin
      cxFields:=
        ' substr(SWHERE,1,256)as SQL1 '+
        ',substr(SWHERE,257,256)as SQL2'+
        ',substr(SWHERE,513,256)as SQL3'+
        ',substr(SWHERE,768,256)as SQL4'+
        ',substr(SWHERE,1024,256)as SQL5'+
        ',substr(SWHERE,1280,256)as SQL6'+
        ',substr(SWHERE,1536,256)as SQL7'+
        ',substr(SWHERE,1792,256)as SQL8'+
        ',substr(SWHERE,2048,256)as SQL9'+
        ',substr(SWHERE,2304,256)as SQL10'+
        ',substr(SWHERE,2560,256)as SQL11'+
        ',substr(SWHERE,2816,256)as SQL12'+
        ',substr(SWHERE,3072,256)as SQL13'+
        ',substr(SWHERE,3328,256)as SQL14'+
        ',substr(SWHERE,3584,256)as SQL15'+
        ',substr(SWHERE,3840,256)as SQL16 ';
    end;
   else
     cxFields:=' SWHERE as SQL1 ';
  end;

  //判断是否定义凭证模板(ACC_FVCHFRAME)
  Str:=
     'select FVCH_GTYPE,SEQNO,SUBJECT_NO,SUMMARY,AMONEY,AMOUNT,APRICE,'+cxFields+',DATAFLAG,SUBJECT_TYPE,SEQNO as FLAG from ACC_FVCHFRAME '+
     ' where TENANT_ID='+IntToStr(Global.TENANT_ID);
  Rs_FvchFrame.Close;
  Rs_FvchFrame.SQL.Text:=Str;
  Factor.Open(Rs_FvchFrame);
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

function TfrmFvchCalc.GetFvchDataSQL(const FvchObj: TRecord_; const vBegDate,vEndDate:string): Boolean;
var
  str: string;
  Fields_mny: string;
  Fields_amt: string;
  Fields_price: string;
  cxFields,GroupFields: string;
  ViwTab: string;
  ViwCnd,WhereCnd: string;
  FilterCnd: string;
begin
  Result:=False;
  ViwCnd:='';
  ViwTab:='';
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
      Rs_FvchFrame.First;
      while not Rs_FvchFrame.Eof do
      begin
        case Factor.iDbType of
         0,5:
          begin
            str:=
              '('+Rs_FvchFrame.FieldByName('SQL1').AsString+Rs_FvchFrame.FieldByName('SQL2').AsString+Rs_FvchFrame.FieldByName('SQL3').AsString+
                  Rs_FvchFrame.FieldByName('SQL4').AsString+Rs_FvchFrame.FieldByName('SQL5').AsString+Rs_FvchFrame.FieldByName('SQL6').AsString+
                  Rs_FvchFrame.FieldByName('SQL7').AsString+Rs_FvchFrame.FieldByName('SQL8').AsString+Rs_FvchFrame.FieldByName('SQL9').AsString+
                  Rs_FvchFrame.FieldByName('SQL10').AsString+Rs_FvchFrame.FieldByName('SQL11').AsString+Rs_FvchFrame.FieldByName('SQL12').AsString+
                  Rs_FvchFrame.FieldByName('SQL13').AsString+Rs_FvchFrame.FieldByName('SQL14').AsString+Rs_FvchFrame.FieldByName('SQL15').AsString+
                  Rs_FvchFrame.FieldByName('SQL16').AsString+')';
          end;
         else
          str:='('+Rs_FvchFrame.FieldByName('SQL1').AsString+')';
        end;
        if ViwCnd='' then
          ViwCnd:=str
        else
          ViwCnd:=ViwCnd+' or '+str;
        Rs_FvchFrame.Edit;
        Rs_FvchFrame.FieldByName('FLAG').AsInteger:=1; //设置取标记
        Rs_FvchFrame.Post;
        Rs_FvchFrame.Next;
      end;
      //连接条件
      if Rs_FvchFrame.RecordCount=1 then
        ViwCnd:=' and '+ViwCnd+' '
      else
        ViwCnd:=' and ('+ViwCnd+') ';

      //过滤企业条件
      WhereCnd:=' where TENANT_ID='+IntToStr(Global.TENANT_ID);

      //过滤业务日期条件
      if vBegDate<vEndDate then
      begin
        WhereCnd:=WhereCnd+' and ('+Rs_BillName.FieldByName('DATE_FIELD').AsString+'>='+vBegDate+' and '
                                   +Rs_BillName.FieldByName('DATE_FIELD').AsString+'<='+vEndDate+')';
      end else
        WhereCnd:=WhereCnd+' and '+Rs_BillName.FieldByName('DATE_FIELD').AsString+'='+vBegDate+' ';

      WhereCnd:=WhereCnd+ViwCnd;
    finally
      Rs_FvchFrame.Filtered:=False;
      Rs_FvchFrame.Filter:='';
    end;
           
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
    ViwTab:='('+str+')';

    //生成此条模板的凭证分录SQL
    FvchDataSQL:='select '+cxFields+' from '+ViwTab+' as tp '+ViwCnd;

    //生成插入单据关联(ACC_FVCHGLIDE)
    FvchGlideSQL:=//'insert into ACC_FVCHGLIDE(TENANT_ID,FVCH_GLID,FVCH_ID,FVCH_GTYPE,FVCH_GID) '+
      'select ORDER_ID from  '+ViwTab+' as tp '+ViwCnd+' and ORDER_ID not in (select FVCH_GID from ACC_FVCHGLIDE and FVCH_GTYPE='''+FvchObj.FieldByName('FVCH_GTYPE').AsString+''') ';

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

end.
