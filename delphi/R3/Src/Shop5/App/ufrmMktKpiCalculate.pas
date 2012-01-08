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
    btnCancel: TRzBitBtn;
    labINFO: TLabel;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    cdsKpiIndex: TZQuery;
    cdsKpiOption: TZQuery;
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
    procedure SetIdxType(const Value: String);
    procedure PrepareData;         //��ʼ׼������
    procedure StatisticalData;     //��ʼͳ������
    procedure OpenResultList(TENANT_ID:Integer;PLAN_ID,KPI_ID:String);
    procedure OpenResult;
    procedure GetResultAmt_Mny(var Amt,Mny:Currency);    //���㵱ǰ����ָ��������������ɽ��
    function GetResultListVle:Currency;   //���㵱ǰ����ָ���µĸ��ȼ������������
    function GetResultListMny:Currency;   //���㵱ǰ����ָ���µĸ��ȼ����˽��
    function EncodeSql:String;
  public
    { Public declarations }
    procedure StartCalculate;
    property IdxType:String read FIdxType write SetIdxType;
  end;

implementation
uses uShopGlobal,uGlobal;
{$R *.dfm}

procedure TfrmMktKpiCalculate.FormCreate(Sender: TObject);
begin
  inherited;
  fndCLIENT_ID.DataSet := ShopGlobal.GetZQueryFromName('PUB_CUSTOMER');
  {
  select CLIENT_ID,LICENSE_CODE,CLIENT_CODE,CLIENT_NAME,LINKMAN,CLIENT_SPELL,ADDRESS,
TELEPHONE2,IC_CARDNO,SETTLE_CODE,INVOICE_FLAG,TAX_RATE,PRICE_ID,FLAG
 from VIW_CUSTOMER A,MKT_PLANORDER B
where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.COMM not in ('02','12')  and A.CLIENT_TYPE='2'
and A.TENANT_ID=:TENANT_ID and B.COMM not in ('02','12') and B.CHK_DATE is not null order by A.CLIENT_CODE
}
  fndKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));
  CdsKpiId := TZQuery.Create(nil);
  fndKPI_ID.DataSet := CdsKpiId;
end;

procedure TfrmMktKpiCalculate.FormDestroy(Sender: TObject);
begin
  inherited;
  CdsKpiId.Free;
end;

procedure TfrmMktKpiCalculate.SetIdxType(const Value: String);
begin
  FIdxType := Value;
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
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    // ��MKT_KPI_RESULT�����������һϵ�в���
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('CREA_USER').AsString := Global.UserID;
    Params.ParamByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    Params.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
    if fndCLIENT_ID.AsString <> '' then
       Params.ParamByName('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if fndKPI_ID.AsString <> '' then
       Params.ParamByName('KPI_ID').AsString := fndKPI_ID.AsString;
    // EXCETYPE ����: 1������ 2���޸� 3��ɾ��
    Params.ParamByName('EXCETYPE').AsInteger := 1;
    Factor.ExecProc('TMktKpiResultHeader',Params);

    Params.ParamByName('EXCETYPE').AsInteger := 2;
    Factor.ExecProc('TMktKpiResultHeader',Params);

    Params.ParamByName('EXCETYPE').AsInteger := 3;
    Factor.ExecProc('TMktKpiResultHeader',Params);

  finally
    Params.Free;
  end;
end;

function TfrmMktKpiCalculate.EncodeSql: String;
var w:String;
begin
  w := ' where TENANT_ID=:TENANT_ID and KPI_YEAR=:KPI_YEAR and COMM not in (''02'',''12'') ';
  if fndCLIENT_ID.AsString <> '' then
     w := w + ' and CLIENT_ID=:CLIENT_ID ';
  if fndKPI_ID.AsString <> '' then
     w := w + ' and KPI_ID=:KPI_ID ';

  Result := 'select TENANT_ID,PLAN_ID,IDX_TYPE,KPI_CALC,KPI_TYPE,KPI_DATA,KPI_ID,KPI_YEAR,BEGIN_DATE,END_DATE,CLIENT_ID,'+
            'CHK_DATE,CHK_USER,PLAN_AMT,PLAN_MNY,FISH_AMT,FISH_MNY,KPI_MNY,WDW_MNY '+
            ' from MKT_KPI_RESULT '+w+' order by PLAN_ID ';
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
      if cdsKpiOption.FieldByName('KPI_TYPE').AsString <> KpiLv then
      begin
         IsAdd := True;
         KpiLv := cdsKpiOption.FieldByName('KPI_TYPE').AsString;
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
      cdsDetail.FieldByName('KPI_TYPE').AsString := cdsKpiIndex.FieldByName('KPI_TYPE').AsString;
      cdsDetail.FieldByName('KPI_DATA').AsString := cdsKpiIndex.FieldByName('KPI_DATA').AsString;
      cdsDetail.FieldByName('KPI_CALC').AsString := cdsKpiIndex.FieldByName('KPI_CALC').AsString;
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
  //��ʼ׼������
  PrepareData;
  //��ȡҪ���˵����ݼ�
  OpenResult;
  if cdsHeader.IsEmpty then
     Raise Exception.Create('�ڵ�ǰ������,û�ҵ�Ҫ���˵�����!');

  cdsHeader.First;
  while not cdsHeader.Eof do
  begin
    OpenResultList(cdsHeader.FieldByName('TENANT_ID').AsInteger,cdsHeader.FieldByName('PLAN_ID').AsString,cdsHeader.FieldByName('KPI_ID').AsString);
    GetResultAmt_Mny(Fish_Amt,Fish_Mny);
    KpiCalculate := TKpiCalculate.Create;
    try
      cdsHeader.Edit;
      cdsHeader.FieldByName('FISH_AMT').AsFloat := Fish_Amt;
      cdsHeader.FieldByName('FISH_MNY').AsFloat := Fish_Mny;
      cdsHeader.Post;
      KpiCalculate.FKpiInfo.TenantId := cdsHeader.FieldByName('TENANT_ID').AsInteger;
      KpiCalculate.FKpiInfo.KpiYear := cdsHeader.FieldByName('KPI_YEAR').AsInteger;
      KpiCalculate.FKpiInfo.KpiId := cdsHeader.FieldByName('KPI_ID').AsString;
      KpiCalculate.FKpiInfo.ClientId := cdsHeader.FieldByName('CLIENT_ID').AsString;
      KpiCalculate.FKpiInfo.IdxType := cdsHeader.FieldByName('IDX_TYPE').AsString;
      KpiCalculate.FKpiInfo.KpiType := cdsKpiIndex.FieldByName('KPI_TYPE').AsString;
      KpiCalculate.FKpiInfo.KpiData := cdsKpiIndex.FieldByName('KPI_DATA').AsString;
      KpiCalculate.FKpiInfo.KpiCalc := cdsKpiIndex.FieldByName('KPI_CALC').AsString;
      KpiCalculate.FKpiInfo.KpiOptn := cdsKpiIndex.FieldByName('KPI_OPTN').AsString;
      KpiCalculate.FKpiInfo.KpiAgio := cdsKpiIndex.FieldByName('KPI_AGIO').AsFloat;
      KpiCalculate.FKpiInfo.PlanAmt := cdsHeader.FieldByName('PLAN_AMT').AsFloat;    
      KpiCalculate.FKpiInfo.PlanMny := cdsHeader.FieldByName('PLAN_MNY').AsFloat;

      StatisticalData;
      Factor.UpdateBatch(cdsDetail,'TMktKpiResultList',nil);
    finally
      KpiCalculate.Destroy;
    end;
    cdsHeader.Next;
  end;

  Factor.UpdateBatch(cdsHeader,'TMktKpiResult',nil); 
end;

procedure TfrmMktKpiCalculate.btnStartClick(Sender: TObject);
begin
  inherited;
  StartCalculate;
end;

procedure TfrmMktKpiCalculate.OpenResult;
begin
  cdsHeader.Close;
  cdsHeader.SQL.Text := EncodeSql;
  cdsHeader.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsHeader.Params.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
  if cdsHeader.Params.FindParam('CLIENT_ID') <> nil then cdsHeader.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
  if cdsHeader.Params.FindParam('KPI_ID') <> nil then cdsHeader.Params.FindParam('KPI_ID').AsString := fndKPI_ID.AsString;
  Factor.Open(cdsHeader);
end;

function TfrmMktKpiCalculate.GetResultListMny: Currency;
begin
  Result := 0;
end;

end.
