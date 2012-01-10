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
    cdsKpiOption: TZQuery;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    CdsKpiId:TZQuery;
    FIdxType: String;
    KpiCalculate:TKpiCalculate;
    Params:TftParamList;
    FPrgPercent: Integer;
    procedure SetIdxType(const Value: String);
    procedure PrepareData;         //开始准备数据
    procedure StatisticalData;     //开始统计数据
    procedure OpenResultList(TENANT_ID:Integer;PLAN_ID,KPI_ID:String);
    procedure OpenResult;
    procedure GetResultAmt_Mny(var Amt,Mny:Currency);    //计算当前考核指标的完成销量、完成金额
    function GetResultListVle:Currency;   //计算当前考核指标下的各等级完成销量或金额
    function GetResultListMny:Currency;   //计算当前考核指标下的各等级考核结果
    function EncodeSql:String;
    procedure SetPrgPercent(const Value: Integer);
  public
    { Public declarations }
    procedure StartCalculate;
    property IdxType:String read FIdxType write SetIdxType;
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
  fndKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));
  CdsKpiId := TZQuery.Create(nil);
  fndKPI_ID.DataSet := CdsKpiId;
end;

procedure TfrmMktKpiCalculate.FormDestroy(Sender: TObject);
begin
  inherited;
  Params.Free;
  CdsKpiId.Free;
end;

procedure TfrmMktKpiCalculate.SetIdxType(const Value: String);
begin
  FIdxType := Value;
  if Value = '1' then
     Caption := '返利计算'
  else if Value = '2' then
     Caption := '计提计算'
  else if Value = '3' then
     Caption := '业绩计算';
end;

procedure TfrmMktKpiCalculate.FormShow(Sender: TObject);
begin
  inherited;
  CdsKpiId.Close;
  CdsKpiId.SQL.Text := ' select KPI_ID,KPI_NAME from MKT_KPI_INDEX where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and IDX_TYPE='+QuotedStr(IdxType);
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
    Params.ParamByName('PLAN_TYPE').AsString := '1';
    Params.ParamByName('IDX_TYPE').AsString := '1';
    if fndCLIENT_ID.AsString <> '' then
       Params.ParamByName('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if fndKPI_ID.AsString <> '' then
       Params.ParamByName('KPI_ID').AsString := fndKPI_ID.AsString;
    // EXCETYPE 类型: 1、插入 2、修改 3、删除
    Params.ParamByName('EXCETYPE').AsInteger := 1;
    Factor.ExecProc('TMktKpiResultHeader',Params);

//    Params.ParamByName('EXCETYPE').AsInteger := 2;
//    Factor.ExecProc('TMktKpiResultHeader',Params);

    Params.ParamByName('EXCETYPE').AsInteger := 3;
    Factor.ExecProc('TMktKpiResultHeader',Params);
end;

function TfrmMktKpiCalculate.EncodeSql: String;
var w:String;
begin
  w :=
     ' and A.TENANT_ID=:TENANT_ID and A.KPI_YEAR=:KPI_YEAR and C.PLAN_TYPE=:PLAN_TYPE and B.IDX_TYPE=:IDX_TYPE and A.COMM not in (''02'',''12'') ';
  if fndCLIENT_ID.AsString <> '' then
     w := w + ' and A.CLIENT_ID=:CLIENT_ID ';
  if fndKPI_ID.AsString <> '' then
     w := w + ' and A.KPI_ID=:KPI_ID ';

  Result := 'select A.TENANT_ID,A.PLAN_ID,B.KPI_CALC,B.KPI_TYPE,B.KPI_DATA,A.KPI_ID,A.CLIENT_ID,C.PLAN_AMT,C.PLAN_MNY,A.FISH_AMT,A.FISH_MNY,A.KPI_MNY,B.KPI_OPTN,B.KPI_AGIO '+
            ' from MKT_KPI_RESULT A,MKT_KPI_INDEX B,MKT_PLANORDER C '+
            ' where A.TENANT_ID=C.TENANT_ID and A.PLAN_ID=C.PLAN_ID and A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID '+w+' order by A.PLAN_ID,A.KPI_ID ';
end;

procedure TfrmMktKpiCalculate.StatisticalData;
var i:Integer;
    KpiIn:PKpiIndex;
    IsAdd:Boolean;
    KpiLv:String;
    FshVle,KpiMny:Real;
begin
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;

  KpiCalculate.DataSet_Kpi := cdsKpiOption;
  KpiCalculate.BeginCalculate;
  KpiLv := '';
  cdsKpiOption.First;
  while not cdsKpiOption.Eof do
  begin
    if cdsHeader.FieldByName('KPI_TYPE').AsString = '3' then
    begin
      IsAdd := True;
      KpiLv := '0';
    end
    else
    begin
      if cdsKpiOption.FieldByName('KPI_LV').AsString <> KpiLv then
      begin
         IsAdd := True;
         KpiLv := cdsKpiOption.FieldByName('KPI_LV').AsString;
      end;
    end;
    if IsAdd then
    begin
      cdsDetail.Append;
      cdsDetail.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      cdsDetail.FieldByName('PLAN_ID').AsString := cdsHeader.FieldByName('PLAN_ID').AsString;
      cdsDetail.FieldByName('KPI_ID').AsString := cdsKpiOption.FieldByName('KPI_ID').AsString;
      cdsDetail.FieldByName('KPI_LV').AsInteger := cdsKpiOption.FieldByName('KPI_LV').AsInteger;
      if cdsHeader.FieldByName('KPI_TYPE').AsString = '3' then
         cdsDetail.FieldByName('SEQNO').AsInteger := cdsKpiOption.FieldByName('SEQNO').AsInteger
      else
         cdsDetail.FieldByName('SEQNO').AsInteger := KpiCalculate.CurSeq[KpiLv];
      cdsDetail.FieldByName('KPI_RATE').AsFloat := cdsKpiOption.FieldByName('KPI_RATE').AsFloat;
      cdsDetail.FieldByName('KPI_AMT').AsFloat := cdsKpiOption.FieldByName('KPI_AMT').AsFloat;
      cdsDetail.FieldByName('KPI_DATE1').AsInteger := cdsKpiOption.FieldByName('KPI_DATE1').AsInteger;
      cdsDetail.FieldByName('KPI_DATE2').AsInteger := cdsKpiOption.FieldByName('KPI_DATE2').AsInteger;
      cdsDetail.FieldByName('KPI_AGIO').AsFloat := cdsKpiOption.FieldByName('KPI_AGIO').AsFloat;
      KpiIn := KpiCalculate.FindKipIndex(KpiLv,cdsDetail.FieldByName('SEQNO').AsInteger);
      cdsDetail.FieldByName('FSH_VLE').AsFloat := KpiIn.FshVle;
      FshVle := FshVle + cdsDetail.FieldByName('FSH_VLE').AsFloat;
      cdsDetail.FieldByName('KPI_MNY').AsFloat := KpiCalculate.KpiMny[KpiLv];
      KpiMny := KpiMny + cdsDetail.FieldByName('KPI_MNY').AsFloat;
      cdsDetail.Post;
      IsAdd := False;
    end;
    cdsKpiOption.Next;
  end;
  cdsHeader.Edit;
  if cdsHeader.FieldByName('KPI_DATA').AsInteger in [1,4] then
     cdsHeader.FieldByName('FISH_AMT').AsFloat := FshVle
  else if cdsHeader.FieldByName('KPI_DATA').AsInteger in [2,5] then
     cdsHeader.FieldByName('FISH_MNY').AsFloat := FshVle
  else if cdsHeader.FieldByName('KPI_DATA').AsInteger in [3,6] then
     cdsHeader.FieldByName('FISH_MNY').AsFloat := FshVle;
  cdsHeader.FieldByName('KPI_MNY').AsFloat := KpiMny;       
  cdsHeader.Post;
end;

procedure TfrmMktKpiCalculate.GetResultAmt_Mny(var Amt,Mny:Currency);
var rs:TZQuery;
    Params:TftParamList;
    GodsId:String;
begin
  if (cdsKpiOption.IsEmpty) then
  begin
     Amt := 0;
     Mny := 0;
  end;

  rs := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('CLIENT_ID').AsString := cdsHeader.FieldbyName('CLIENT_ID').AsString;
    Params.ParamByName('KPI_ID').AsString := cdsKpiIndex.FieldByName('KPI_ID').AsString;
    Params.ParamByName('SALES_DATE1').AsInteger := StrToInt(FormatDateTime('YYYY0101', date()));
    Params.ParamByName('SALES_DATE2').AsInteger := StrToInt(FormatDateTime('YYYY1231', date()));;
    Factor.Open(rs,'TMktKpiResultSale',Params);
    Amt := rs.FieldbyName('CALC_AMOUNT').AsFloat;
    Mny := rs.FieldbyName('CALC_MONEY').AsFloat;
  finally
    Params.Free;
    rs.Free;
  end;
end;

function TfrmMktKpiCalculate.GetResultListVle: Currency;
begin
  Result := 0;
end;

procedure TfrmMktKpiCalculate.OpenResultList(TENANT_ID:Integer;PLAN_ID,
  KPI_ID: String);
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := TENANT_ID;
    Params.ParamByName('PLAN_ID').AsString := PLAN_ID;
    Params.ParamByName('KPI_ID').AsString := KPI_ID;
    Factor.BeginBatch;
    try
      Factor.AddBatch(CdsKpiIndex,'TKpiIndex',Params);
      Factor.AddBatch(CdsKpiOption,'TKpiOption',Params);
      Factor.AddBatch(cdsDetail,'TMktKpiResultList',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmMktKpiCalculate.StartCalculate;
var i:Integer;
    Fish_Amt,Fish_Mny:Currency;
begin
  //开始准备数据
  PrepareData;
  //获取要考核的数据集
  OpenResult;
  if cdsHeader.IsEmpty then
     Raise Exception.Create('在当前条件下,没找到要考核的数据!');
  ProgressBar1.Percent := 0;
  cdsHeader.First;
  while not cdsHeader.Eof do
  begin
    OpenResultList(Global.TENANT_ID,cdsHeader.FieldByName('PLAN_ID').AsString,cdsHeader.FieldByName('KPI_ID').AsString);
    KpiCalculate := TKpiCalculate.Create;
    try
      KpiCalculate.FKpiInfo.TenantId := Global.TENANT_ID;
      KpiCalculate.FKpiInfo.KpiYear := Params.ParamByName('KPI_YEAR').AsInteger;
      KpiCalculate.FKpiInfo.KpiId := cdsHeader.FieldByName('KPI_ID').AsString;
      KpiCalculate.FKpiInfo.ClientId := cdsHeader.FieldByName('CLIENT_ID').AsString;
      KpiCalculate.FKpiInfo.IdxType := Params.ParamByName('IDX_TYPE').AsString;
      KpiCalculate.FKpiInfo.KpiType := cdsHeader.FieldByName('KPI_TYPE').AsString;
      KpiCalculate.FKpiInfo.KpiData := cdsHeader.FieldByName('KPI_DATA').AsString;
      KpiCalculate.FKpiInfo.KpiCalc := cdsHeader.FieldByName('KPI_CALC').AsString;
      KpiCalculate.FKpiInfo.KpiOptn := cdsHeader.FieldByName('KPI_OPTN').AsString;
      KpiCalculate.FKpiInfo.KpiAgio := cdsHeader.FieldByName('KPI_AGIO').AsFloat;
      KpiCalculate.FKpiInfo.PlanAmt := cdsHeader.FieldByName('PLAN_AMT').AsFloat;
      KpiCalculate.FKpiInfo.PlanMny := cdsHeader.FieldByName('PLAN_MNY').AsFloat;

      StatisticalData;
      Factor.UpdateBatch(cdsDetail,'TMktKpiResultList',nil);
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
  StartCalculate;
  ModalResult := MROK;
end;

procedure TfrmMktKpiCalculate.OpenResult;
begin
  cdsHeader.Close;
  cdsHeader.SQL.Text := EncodeSql;
  cdsHeader.Params.AssignValues(Params);
//  cdsHeader.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
//  cdsHeader.Params.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
//  if cdsHeader.Params.FindParam('CLIENT_ID') <> nil then cdsHeader.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
//  if cdsHeader.Params.FindParam('KPI_ID') <> nil then cdsHeader.Params.FindParam('KPI_ID').AsString := fndKPI_ID.AsString;
  Factor.Open(cdsHeader);
end;

function TfrmMktKpiCalculate.GetResultListMny: Currency;
begin
  Result := 0;
end;

procedure TfrmMktKpiCalculate.SetPrgPercent(const Value: Integer);
begin
  FPrgPercent := Value;
  ProgressBar1.Percent := Value;
  Update;
end;

end.
