unit ufrmKpiSeqNoSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,DB,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, ZBase,
  cxDropDownEdit, StdCtrls, RzLabel, cxCalendar, cxCheckBox, uDsUtil, uFnUtil,
  cxButtonEdit, zrComboBoxList, zDataSet;

type
  TfrmKpiSeqNoSet = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzLabel3: TRzLabel;
    edtLEVEL_NAME: TcxTextEdit;
    RzLabel7: TRzLabel;
    RzLabel5: TRzLabel;
    edtLVL_AMT: TcxTextEdit;
    RzLabel6: TRzLabel;
    edtLOW_RATE: TcxTextEdit;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    lab_IDX_TYPE: TRzLabel;
    lab_KPI_TYPE: TLabel;
    RzLabel2: TRzLabel;
    edtKPI_DATE1: TcxTextEdit;
    edtKPI_DATE2: TcxTextEdit;
    edtTIMES_ID: TzrComboBoxList;
    edtKPI_DATA: TcxComboBox;
    edtKPI_CALC: TcxComboBox;
    edtRATIO_TYPE: TcxComboBox;
    RzLabel4: TRzLabel;
    edtKPI_AMT: TcxTextEdit;
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtTIMES_IDSaveValue(Sender: TObject);
  private
    FTime_ID: string;     //时段ID
    FSeqNoObj: TRecord_;  //返回档次
    FLevelObj: TRecord_;  //等级名城
    FcdsKpiTimes: TZQuery;
    procedure SaveTimesID;
    procedure InitParams;  //默认参数
  public
    class function EditDialog(var SeqNoObj: TRecord_; const LevelObj: TRecord_; const Times_ID: string; const cdsKpiTimes: TZQuery): Boolean;
  end;


implementation

uses
  uGlobal;

{$R *.dfm}

procedure TfrmKpiSeqNoSet.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmKpiSeqNoSet.Btn_SaveClick(Sender: TObject);
var
  TimeObj: TRecord_;
begin
  if edtTIMES_ID.AsString='' then Raise Exception.Create('   请选择时段名称    ');
  try
    TimeObj:=TRecord_.Create;
    TimeObj.ReadFromDataSet(edtTIMES_ID.DataSet);
    FSeqNoObj.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    FSeqNoObj.FieldByName('KPI_ID').AsString:=TimeObj.FieldByName('KPI_ID').AsString;
    FSeqNoObj.FieldByName('LEVEL_ID').AsString:=FLevelObj.FieldByName('LEVEL_ID').AsString;
    FSeqNoObj.FieldByName('LEVEL_NAME').AsString:=FLevelObj.FieldByName('LEVEL_NAME').AsString;
    FSeqNoObj.FieldByName('TIMES_ID').AsString:=TimeObj.FieldByName('TIMES_ID').AsString;
    FSeqNoObj.FieldByName('TIMES_NAME').AsString:=TimeObj.FieldByName('TIMES_NAME').AsString;
    FSeqNoObj.FieldByName('LOW_RATE').AsFloat:=FLevelObj.FieldByName('LOW_RATE').AsFloat;
    FSeqNoObj.FieldByName('KPI_DATE1').AsInteger:=TimeObj.FieldByName('KPI_DATE1').AsInteger;
    FSeqNoObj.FieldByName('KPI_DATE2').AsInteger:=TimeObj.FieldByName('KPI_DATE2').AsInteger;
    FSeqNoObj.FieldByName('USING_BRRW').AsString:=TimeObj.FieldByName('USING_BRRW').AsString;
    FSeqNoObj.FieldByName('KPI_FLAG').AsString:=TimeObj.FieldByName('KPI_FLAG').AsString;
    FSeqNoObj.FieldByName('KPI_DATA').AsString:=TimeObj.FieldByName('KPI_DATA').AsString;
    FSeqNoObj.FieldByName('KPI_CALC').AsString:=TimeObj.FieldByName('KPI_CALC').AsString;
    FSeqNoObj.FieldByName('RATIO_TYPE').AsString:=TimeObj.FieldByName('RATIO_TYPE').AsString;
    FSeqNoObj.FieldByName('KPI_AMT').AsFloat:=StrToFloatDef(edtKPI_AMT.Text,0);  //达标量(输入)
  finally
    TimeObj.Free;
  end;
  ModalResult := mrOk;
end;

class function TfrmKpiSeqNoSet.EditDialog(var SeqNoObj: TRecord_; const LevelObj: TRecord_; const Times_ID: string; const cdsKpiTimes: TZQuery): Boolean;
begin
  result:=False;
  with TfrmKpiSeqNoSet.Create(nil) do
  begin
    try
      dbState:=dsEdit;
      FSeqNoObj:=SeqNoObj;
      FLevelObj:=LevelObj;
      FTime_ID:=trim(Times_ID);
      FcdsKpiTimes:=cdsKpiTimes;
      edtTIMES_ID.DataSet:=FcdsKpiTimes;
      InitParams;  //默认参数
      result:=(ShowModal=mrOk);
    finally
      free;
    end;
  end;
end;

procedure TfrmKpiSeqNoSet.InitParams;
begin
  edtLEVEL_NAME.Text:=FLevelObj.FieldByName('LEVEL_NAME').AsString;
  edtLVL_AMT.Text:=FloatToStr(FLevelObj.FieldByName('LVL_AMT').AsFloat);
  edtLOW_RATE.Text:=FloatToStr(FLevelObj.FieldByName('LOW_RATE').AsFloat);
  //数据集关闭
  if not FcdsKpiTimes.Active then Exit;
  if FcdsKpiTimes.Locate('TIMES_ID',FTime_ID,[]) then
  begin
    edtTIMES_ID.KeyValue:=FTime_ID;
    edtTIMES_ID.Text:=FcdsKpiTimes.fieldByName('TIMES_NAME').AsString;
    SaveTimesID;
  end;
  //达标档位
  edtKPI_AMT.Text:=FloatToStr(FSeqNoObj.FieldByName('KPI_AMT').AsFloat);
end;

procedure TfrmKpiSeqNoSet.SaveTimesID;
var
  CurValue: string;
begin
  //考核标准:
  edtKPI_DATA.Properties.ReadOnly:=False;
  CurValue:=trim(FcdsKpiTimes.FieldByName('KPI_DATA').AsString);
  edtKPI_DATA.ItemIndex:=TdsItems.FindItems(edtKPI_DATA.Properties.Items,'CODE_ID',CurValue);
  edtKPI_DATA.Properties.ReadOnly:=True;
  //计算标准:
  edtKPI_CALC.Properties.ReadOnly:=False;
  CurValue:=trim(FcdsKpiTimes.FieldByName('KPI_CALC').AsString);
  edtKPI_CALC.ItemIndex:=TdsItems.FindItems(edtKPI_CALC.Properties.Items,'CODE_ID',CurValue);
  edtKPI_CALC.Properties.ReadOnly:=True;
  //返利设定:
  edtRATIO_TYPE.Properties.ReadOnly:=False;
  CurValue:=trim(FcdsKpiTimes.FieldByName('RATIO_TYPE').AsString);
  edtRATIO_TYPE.ItemIndex:=TdsItems.FindItems(edtRATIO_TYPE.Properties.Items,'CODE_ID',CurValue);
  edtRATIO_TYPE.Properties.ReadOnly:=True;
  //日期:
  edtKPI_DATE1.Text:=FormatFloat('00-00',FcdsKpiTimes.FieldByName('KPI_DATE1').AsInteger);
  edtKPI_DATE2.Text:=FormatFloat('00-00',FcdsKpiTimes.FieldByName('KPI_DATE2').AsInteger);
end;

procedure TfrmKpiSeqNoSet.edtTIMES_IDSaveValue(Sender: TObject);
begin
  inherited;
  SaveTimesID;
end;

end.
