unit ufrmKpiRatioSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,DB,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, ZBase,
  cxDropDownEdit, StdCtrls, RzLabel, cxCalendar, cxCheckBox, uDsUtil, uFnUtil,
  cxButtonEdit, zrComboBoxList, zDataSet;

type
  TfrmKpiRatioSet = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzLabel3: TRzLabel;
    edtTIMES_NAME: TcxTextEdit;
    RzLabel7: TRzLabel;
    Label33: TLabel;
    edtGODS_ID: TzrComboBoxList;
    Label30: TLabel;
    edt_UNIT_ID: TzrComboBoxList;
    RzLabel8: TRzLabel;
    RzLabel5: TRzLabel;
    edtLVL_AMT: TcxTextEdit;
    RzLabel6: TRzLabel;
    edtLOW_RATE: TcxTextEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    edtKPI_RATIO: TcxTextEdit;
    edtLevel_ID: TzrComboBoxList;
    edtKPI_CALC: TcxComboBox;
    edtKPI_DATA: TcxComboBox;
    RzLabel2: TRzLabel;
    edtRATIO_TYPE: TcxComboBox;
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLevel_IDSaveValue(Sender: TObject);
    procedure edtRATIO_TYPEPropertiesChange(Sender: TObject);
  private
    FRatioID: string;
    FRatioObj: TRecord_;     //当前返利系数
    FCdsKpiGods: TZQuery;    //考核商品列表
    FCdsKpiSeqNo: TZQuery;   //达标档位
    procedure SetdbState(const Value: TDataSetState); override;
    procedure InitParams;  //默认参数
    procedure SaveLevelID;  //保存LEVELID
  public
    class function EditDialog(var RatioObj: TRecord_; const cdsKpiGods,cdsKpiSeqNo: TZQuery): Boolean;
  end;


implementation

uses
  uGlobal;

{$R *.dfm}

procedure TfrmKpiRatioSet.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmKpiRatioSet.Btn_SaveClick(Sender: TObject);
var
  CurID: string;
  CurDs: TDataSet;
begin
  inherited;
  if edtLevel_ID.AsString='' then Raise Exception.Create('  请选择等级名称！  ');
  if edtGODS_ID.AsString=''  then Raise Exception.Create('  请选择商品名称！  ');

  CurID:=trim(edtLevel_ID.DataSet.fieldByName('SEQNO_ID').AsString);
  CurDs:=edtLevel_ID.DataSet;
  if CurDs.Locate('SEQNO_ID',CurID,[]) then
  begin
    FRatioObj.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    FRatioObj.FieldByName('KPI_ID').AsString:=CurDs.FieldByName('KPI_ID').AsString;
    FRatioObj.FieldByName('LEVEL_ID').AsString:=CurDs.FieldByName('LEVEL_ID').AsString;
    FRatioObj.FieldByName('LEVEL_NAME').AsString:=CurDs.FieldByName('LEVEL_NAME').AsString;
    FRatioObj.FieldByName('TIMES_ID').AsString:=CurDs.FieldByName('TIMES_ID').AsString;
    FRatioObj.FieldByName('TIMES_NAME').AsString:=CurDs.FieldByName('TIMES_NAME').AsString;
    FRatioObj.FieldByName('SEQNO_ID').AsString:=CurDs.FieldByName('SEQNO_ID').AsString;
    FRatioObj.FieldByName('SEQNO').AsInteger:=CurDs.FieldByName('SEQNO').AsInteger;
    FRatioObj.FieldByName('LVL_AMT').AsFloat:=CurDs.FieldByName('LVL_AMT').AsFloat;
    FRatioObj.FieldByName('LOW_RATE').AsFloat:=CurDs.FieldByName('LOW_RATE').AsFloat;    
    FRatioObj.FieldByName('KPI_AMT').AsFloat:=CurDs.FieldByName('KPI_AMT').AsFloat;
    FRatioObj.FieldByName('KPI_DATE1').AsInteger:=CurDs.FieldByName('KPI_DATE1').AsInteger;
    FRatioObj.FieldByName('KPI_DATE2').AsInteger:=CurDs.FieldByName('KPI_DATE2').AsInteger;

    FRatioObj.FieldByName('GODS_ID').AsString:=edtGODS_ID.AsString;
    FRatioObj.FieldByName('GODS_NAME').AsString:=edtGODS_ID.Text;
    if edt_UNIT_ID.Enabled then
    begin
      FRatioObj.FieldByName('UNIT_ID').AsString:=edt_UNIT_ID.AsString;
      FRatioObj.FieldByName('UNIT_NAME').AsString:=edt_UNIT_ID.Text;
    end else
    begin
      FRatioObj.FieldByName('UNIT_ID').AsString:='';
      FRatioObj.FieldByName('UNIT_NAME').AsString:='';
    end;
    FRatioObj.FieldByName('KPI_RATIO').AsFloat:=StrToFloatDef(edtKPI_RATIO.Text,0);
    ModalResult := mrOk;
  end;
end;

procedure TfrmKpiRatioSet.FormCreate(Sender: TObject);
begin
  inherited;
  edt_UNIT_ID.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
end;

class function TfrmKpiRatioSet.EditDialog(var RatioObj: TRecord_; const cdsKpiGods,cdsKpiSeqNo: TZQuery): Boolean;
begin
  //若编辑，记录由RatioObj传入;
  result:=False;
  with TfrmKpiRatioSet.Create(nil) do
  begin
    try
      FRatioObj:=RatioObj;
      FCdsKpiGods:=cdsKpiGods;
      FCdsKpiSeqNo:=cdsKpiSeqNo;
      edtGODS_ID.DataSet:=FCdsKpiGods;
      edtLevel_ID.DataSet:=FCdsKpiSeqNo;
      InitParams;  //默认参数
      result:=(ShowModal=mrOk);
    finally
      free;
    end;
  end;
end;

procedure TfrmKpiRatioSet.InitParams;
var
  CurID: string;
begin
  FRatioID:=trim(FRatioObj.FieldByName('RATIO_ID').AsString);
  //达标档位
  CurID:=trim(FRatioObj.FieldByName('SEQNO_ID').AsString);
  if FCdsKpiSeqNo.Locate('SEQNO_ID',CurID,[]) then
  begin
    //等级ID
    edtLevel_ID.KeyValue:=FCdsKpiSeqNo.FieldByName('LEVEL_ID').AsString;
    edtLevel_ID.Text:=FCdsKpiSeqNo.FieldByName('LEVEL_NAME').AsString;
    SaveLevelID;
  end;
  //商品ID
  CurID:=trim(FRatioObj.FieldByName('GODS_ID').AsString);
  if FCdsKpiGods.Locate('GODS_ID',CurID,[]) then
  begin
    edtGODS_ID.KeyValue:=FCdsKpiGods.FieldByName('GODS_ID').AsString;;
    edtGODS_ID.Text:=FCdsKpiGods.FieldByName('GODS_NAME').AsString;
  end;
  //单位ID
  CurID:=trim(FRatioObj.FieldByName('UNIT_ID').AsString);
  if edt_UNIT_ID.DataSet.Locate('UNIT_ID',CurID,[]) then
  begin
    edt_UNIT_ID.KeyValue:=CurID;
    edt_UNIT_ID.Text:=edt_UNIT_ID.DataSet.FieldByName('UNIT_NAME').AsString;
  end;
  edtKPI_RATIO.Text:=FloatToStr(FRatioObj.FieldByName('KPI_RATIO').AsFloat);
end;

procedure TfrmKpiRatioSet.SetdbState(const Value: TDataSetState);
begin
  inherited;
  edtLVL_AMT.Style.Color:=$00EAEAEA;
  edtLOW_RATE.Style.Color:=$00EAEAEA;
  edtTIMES_NAME.Style.Color:=$00EAEAEA;
  edtKPI_DATA.Style.Color:=$00EAEAEA;
  edtKPI_CALC.Style.Color:=$00EAEAEA;
end;

procedure TfrmKpiRatioSet.SaveLevelID;
var
  SelObj: TRecord_;
  CurValue: string;
begin
  try
    SelObj:=TRecord_.Create;
    SelObj.ReadFromDataSet(FCdsKpiSeqNo);     
    edtLVL_AMT.Text:=FloatToStr(SelObj.FieldByName('LVL_AMT').AsFloat);
    edtLOW_RATE.Text:=FloatToStr(SelObj.FieldByName('LOW_RATE').AsFloat);
    edtTIMES_NAME.Text:=SelObj.fieldByName('TIMES_NAME').AsString;
    //考核标准:
    edtKPI_DATA.Properties.ReadOnly:=False;
    CurValue:=trim(SelObj.FieldByName('KPI_DATA').AsString);
    edtKPI_DATA.ItemIndex:=TdsItems.FindItems(edtKPI_DATA.Properties.Items,'CODE_ID',CurValue);
    edtKPI_DATA.Properties.ReadOnly:=True;
    //计算标准:
    edtKPI_CALC.Properties.ReadOnly:=False;
    CurValue:=trim(SelObj.FieldByName('KPI_CALC').AsString);
    edtKPI_CALC.ItemIndex:=TdsItems.FindItems(edtKPI_CALC.Properties.Items,'CODE_ID',CurValue);
    edtKPI_CALC.Properties.ReadOnly:=True;
    //返利设定:
    edtRATIO_TYPE.Properties.ReadOnly:=False;
    CurValue:=trim(SelObj.FieldByName('RATIO_TYPE').AsString);
    edtRATIO_TYPE.ItemIndex:=TdsItems.FindItems(edtRATIO_TYPE.Properties.Items,'CODE_ID',CurValue);
    edtRATIO_TYPE.Properties.ReadOnly:=True;
  finally
    SelObj.Free;
  end;
end;

procedure TfrmKpiRatioSet.edtLevel_IDSaveValue(Sender: TObject);
begin
  inherited;
  SaveLevelID;
end;

procedure TfrmKpiRatioSet.edtRATIO_TYPEPropertiesChange(Sender: TObject);
var
  AObj: TRecord_;
begin
  inherited;
  if edtRATIO_TYPE.ItemIndex<>-1 then
  begin
    edt_UNIT_ID.Enabled:=True;
    AObj:=TRecord_(edtRATIO_TYPE.Properties.Items.Objects[edtRATIO_TYPE.ItemIndex]);
    if (AObj<>nil) and (trim(AObj.FieldByName('CODE_ID').AsString)='1') then
    begin
      edt_UNIT_ID.KeyValue:='';
      edt_UNIT_ID.Text:='';
      edt_UNIT_ID.Enabled:=False;
    end;
  end;
end;

end.
