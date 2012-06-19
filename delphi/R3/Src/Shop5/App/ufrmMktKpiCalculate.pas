unit ufrmMktKpiCalculate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, cxSpinEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, StdCtrls, RzLabel, RzPrgres, RzButton, DB, ZBase, uKpiCalculate,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxDBEdit;
  
type
  TfrmMktKpiCalculate = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel4: TRzLabel;
    fndCLIENT_ID: TzrComboBoxList;
    fndKPI_YEAR: TcxSpinEdit;
    RzLabel7: TRzLabel;
    ProgressBar1: TRzProgressBar;
    RzLabel1: TRzLabel;
    fndKPI_ID: TzrComboBoxList;
    btnStart: TRzBitBtn;
    labINFO: TLabel;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    cdsKpiIndex: TZQuery;
    cdsKpiLevel: TZQuery;
    Bevel1: TBevel;
    fndPLAN_USER: TzrComboBoxList;
    CdsKpiRatio: TZQuery;
    CdsKpiSeqNo: TZQuery;
    CdsKpiTimes: TZQuery;
    CdsKpiGoods: TZQuery;
    CdsActiveRatio: TZQuery;
    labInfomation: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure fndKPI_YEARPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    { Private declarations }
    CdsKpiId:TZQuery;
    FIdxType: String;
    //KpiCalculate:TKpiCalculate;
    KpiCalculate:TClientRebate;
    Params:TftParamList;
    FPrgPercent: Integer;
    FPlanType: String;
    procedure SetIdxType(const Value: String);
    procedure PrepareData;         //开始准备数据
    procedure StatisticalData;     //开始统计数据
    procedure OpenResultList(CLIENT_ID,KPI_ID:String);
    procedure OpenResult;
    function EncodeSql:String;
    procedure SetPrgPercent(const Value: Integer);
    procedure SetPlanType(const Value: String);
  public
    { Public declarations }
    procedure StartCalculate;
    property IdxType:String read FIdxType write SetIdxType;
    property PlanType:String read FPlanType write SetPlanType;
    property PrgPercent:Integer read FPrgPercent write SetPrgPercent;
  end;

implementation
uses uShopGlobal,uGlobal;
{$R *.dfm}

procedure TfrmMktKpiCalculate.FormCreate(Sender: TObject);
begin
  inherited;
  Params := TftParamList.Create;

  fndCLIENT_ID.DataSet := ShopGlobal.GetZQueryFromName('PUB_CUSTOMER');
  fndCLIENT_ID.DataSet.Filtered := False;
  fndCLIENT_ID.DataSet.Filter := ' FLAG<>2 ';
  fndCLIENT_ID.DataSet.Filtered := True;
  fndPLAN_USER.DataSet := ShopGlobal.GetZQueryFromName('CA_USERS');
  fndKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));
  CdsKpiId := TZQuery.Create(nil);
  fndKPI_ID.DataSet := CdsKpiId;
end;

procedure TfrmMktKpiCalculate.FormDestroy(Sender: TObject);
begin
  inherited;
  fndCLIENT_ID.DataSet.Filtered := False;
  Params.Free;
  CdsKpiId.Free;
end;

procedure TfrmMktKpiCalculate.SetIdxType(const Value: String);
begin
  FIdxType := Value;
  if Value = '1' then
  begin
     Caption := '返利计算';
     RzLabel4.Caption := '经 销 商';
     fndPLAN_USER.Visible := False;
  end
  else if Value = '2' then
  begin
     Caption := '计提计算';
     RzLabel4.Caption := '经 销 商';
     fndPLAN_USER.Visible := False;
  end
  else if Value = '3' then
  begin
     Caption := '业绩计算';
     RzLabel4.Caption := '业 务 员';
     fndCLIENT_ID.Visible := False;
  end;
end;

procedure TfrmMktKpiCalculate.FormShow(Sender: TObject);
begin
  inherited;
  CdsKpiId.Close;
  CdsKpiId.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL from MKT_KPI_INDEX where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and IDX_TYPE='+QuotedStr(IdxType);
  Factor.Open(CdsKpiId);
end;

procedure TfrmMktKpiCalculate.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMktKpiCalculate.PrepareData;
begin
    // 对MKT_KPI_RESULT考核主表进行一系列操作
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('CREA_USER').AsString := Global.UserID;
    Params.ParamByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    Params.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
    Params.ParamByName('PLAN_TYPE').AsString := PlanType;
    Params.ParamByName('IDX_TYPE').AsString := IdxType;
    if fndCLIENT_ID.AsString <> '' then
       Params.ParamByName('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if fndPLAN_USER.AsString <> '' then
       Params.ParamByName('PLAN_USER').AsString := fndPLAN_USER.AsString;
    if fndKPI_ID.AsString <> '' then
       Params.ParamByName('KPI_ID').AsString := fndKPI_ID.AsString;
    // EXCETYPE 类型: 1、插入 2、修改 3、删除
    Params.ParamByName('EXCETYPE').AsInteger := 1;
    Factor.ExecProc('TMktKpiResultHeader',Params);

//    Params.ParamByName('EXCETYPE').AsInteger := 2;
//    Factor.ExecProc('TMktKpiResultHeader',Params);

//    Params.ParamByName('EXCETYPE').AsInteger := 3;
//    Factor.ExecProc('TMktKpiResultHeader',Params);
end;

function TfrmMktKpiCalculate.EncodeSql: String;
var w:String;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.KPI_YEAR=:KPI_YEAR and C.PLAN_TYPE=:PLAN_TYPE and A.COMM not in (''02'',''12'') ';
  if IdxType = '3' then
  begin
    if fndPLAN_USER.AsString <> '' then
       w := w + ' and A.CLIENT_ID=:PLAN_USER ';
  end
  else
  begin
    if fndCLIENT_ID.AsString <> '' then
       w := w + ' and A.CLIENT_ID=:CLIENT_ID ';
  end;
  if fndKPI_ID.AsString <> '' then
     w := w + ' and A.KPI_ID=:KPI_ID ';

  Result := ' select A.TENANT_ID,A.KPI_YEAR,B.KPI_TYPE,A.KPI_ID,A.CLIENT_ID,A.PLAN_AMT,A.PLAN_MNY,A.FISH_AMT,A.FISH_MNY,A.ADJS_AMT,A.ADJS_MNY,A.KPI_MNY,A.BUDG_KPI '+
  ' from MKT_KPI_RESULT A inner join MKT_KPI_INDEX B on A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID '+
  ' left join MKT_PLANORDER C on A.TENANT_ID=C.TENANT_ID and A.PLAN_ID=C.PLAN_ID '+w+' order by A.KPI_ID ';
  
end;

procedure TfrmMktKpiCalculate.StatisticalData;
begin

end;

procedure TfrmMktKpiCalculate.OpenResultList(CLIENT_ID, KPI_ID: String);
var Param:TftParamList;
begin
  Param := TftParamList.Create(nil);
  try
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Param.ParamByName('CLIENT_ID').AsString := CLIENT_ID;
    Param.ParamByName('KPI_ID').AsString := KPI_ID;
    Param.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
    Factor.BeginBatch;
    try
      Factor.AddBatch(CdsKpiIndex,'TKpiIndex',Param);
      Factor.AddBatch(cdsKpiLevel,'TKpiLevel',Param);
      Factor.AddBatch(CdsKpiSeqNo,'TKpiSeqNo',Param);
      Factor.AddBatch(CdsKpiTimes,'TKpiTimes',Param);
      Factor.AddBatch(CdsKpiGoods,'TKpiGoods',Param);
      Factor.AddBatch(CdsKpiRatio,'TKpiRatio',Param);
      Factor.AddBatch(CdsActiveRatio,'TMktRatio',Param);
      Factor.AddBatch(cdsDetail,'TMktKpiResultList',Param);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    Param.Free;
  end;
end;

procedure TfrmMktKpiCalculate.StartCalculate;
var i:Integer;
    Fish_Amt,Fish_Mny:Currency;
    SumFishAmt,SumFishMny,SumAdjsAmt,SumAdjsMny,SumKpiMny,SumBudgKpi:Real;    
begin
  //开始准备数据
  PrepareData;
  //获取要考核的数据集
  OpenResult;
  if cdsHeader.IsEmpty then
     Raise Exception.Create('在当前条件下,没找到要考核的数据!'+sLineBreak+'原因:相关签约单据可能没有审核!');
  ProgressBar1.Percent := 0;
  cdsHeader.First;
  while not cdsHeader.Eof do
  begin
    OpenResultList(cdsHeader.FieldByName('CLIENT_ID').AsString,cdsHeader.FieldByName('KPI_ID').AsString);
    labInfomation.Caption := '正计算"'+cdsKpiIndex.FieldByName('KPI_NAME').AsString+'"指标...';
    SumFishAmt := 0;
    SumFishMny := 0;
    SumAdjsAmt := 0;
    SumAdjsMny := 0;
    SumKpiMny := 0;
    SumBudgKpi := 0;
    KpiCalculate := TClientRebate.Create;
    try
      KpiCalculate.FKpiIndexInfo.TenantId := Global.TENANT_ID;
      KpiCalculate.FKpiIndexInfo.KpiYear := Params.ParamByName('KPI_YEAR').AsInteger;
      KpiCalculate.FKpiIndexInfo.KpiId := cdsHeader.FieldByName('KPI_ID').AsString;
      KpiCalculate.FKpiIndexInfo.ClientId := cdsHeader.FieldByName('CLIENT_ID').AsString;
      KpiCalculate.FKpiIndexInfo.IdxType := IdxType;
      KpiCalculate.FKpiIndexInfo.KpiType := cdsHeader.FieldByName('KPI_TYPE').AsString;
      KpiCalculate.FKpiIndexInfo.PlanAmt := cdsHeader.FieldByName('PLAN_AMT').AsFloat;
      KpiCalculate.FKpiIndexInfo.PlanMny := cdsHeader.FieldByName('PLAN_MNY').AsFloat;
      //StatisticalData;
      KpiCalculate.KpiGoods := CdsKpiGoods;
      KpiCalculate.KpiLevel := cdsKpiLevel;
      KpiCalculate.KpiTimes := CdsKpiTimes;
      KpiCalculate.KpiSeqNo := CdsKpiSeqNo;
      KpiCalculate.KpiRatio := CdsKpiRatio;
      KpiCalculate.ActiveRatio := CdsActiveRatio;
      KpiCalculate.KpiDetail := cdsDetail;
      KpiCalculate.CalculationRebate;
      cdsDetail.First;
      while not cdsDetail.Eof do
      begin
        if CdsKpiTimes.Locate('TIMES_ID',cdsDetail.FieldByName('TIMES_ID').AsString,[]) and (CdsKpiTimes.FieldByName('KPI_FLAG').AsString = '0') then
           begin
              SumFishAmt := SumFishAmt + cdsDetail.FieldByName('FISH_AMT').AsFloat;
              SumFishMny := SumFishMny + cdsDetail.FieldByName('FISH_MNY').AsFloat;
              SumAdjsAmt := SumAdjsAmt + cdsDetail.FieldByName('ADJS_AMT').AsFloat;
              SumAdjsMny := SumAdjsMny + cdsDetail.FieldByName('ADJS_MNY').AsFloat;
           end;
        SumKpiMny := SumKpiMny + cdsDetail.FieldByName('KPI_MNY').AsFloat;
        SumBudgKpi := SumBudgKpi + cdsDetail.FieldByName('BUDG_KPI').AsFloat;
        cdsDetail.Next;
      end;
      cdsHeader.Edit;
      cdsHeader.FieldByName('FISH_AMT').AsFloat := SumFishAmt;
      cdsHeader.FieldByName('ADJS_AMT').AsFloat := SumAdjsAmt;
      cdsHeader.FieldByName('FISH_MNY').AsFloat := SumFishMny;
      cdsHeader.FieldByName('ADJS_MNY').AsFloat := SumAdjsMny;
      cdsHeader.FieldByName('KPI_MNY').AsFloat := SumKpiMny;
      cdsHeader.FieldByName('BUDG_KPI').AsFloat := SumBudgKpi;
      cdsHeader.Post;
      try
        Factor.UpdateBatch(cdsDetail,'TMktKpiResultList',nil);
      except
        Raise;
      end;
    finally
      KpiCalculate.Destroy;
    end;
    ProgressBar1.Percent := (cdsHeader.RecNo*100 div cdsHeader.RecordCount);
    cdsHeader.Next;
  end;

  Factor.UpdateBatch(cdsHeader,'TMktKpiResult',nil);
  ProgressBar1.Percent := 100;
end;

procedure TfrmMktKpiCalculate.btnStartClick(Sender: TObject);
begin
  inherited;
  btnStart.Enabled := False;
  try
    StartCalculate;
  finally
    btnStart.Enabled := True;
  end;
  ModalResult := MROK;
end;

procedure TfrmMktKpiCalculate.OpenResult;
begin
  cdsHeader.Close;
  cdsHeader.SQL.Text := EncodeSql;
  cdsHeader.Params.AssignValues(Params);
  Factor.Open(cdsHeader);
end;

procedure TfrmMktKpiCalculate.SetPrgPercent(const Value: Integer);
begin
  FPrgPercent := Value;
  ProgressBar1.Percent := Value;
  Update;
end;

procedure TfrmMktKpiCalculate.SetPlanType(const Value: String);
begin
  FPlanType := Value;
end;

procedure TfrmMktKpiCalculate.fndKPI_YEARPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if (fndKPI_YEAR.Value < 2000) or (fndKPI_YEAR.Value > 2111) then
     Raise Exception.Create('输入年度范围"2000-2111"');
end;

end.
