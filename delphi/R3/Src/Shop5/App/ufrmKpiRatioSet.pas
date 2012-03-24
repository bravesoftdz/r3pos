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
    edtKPI_CALC: TcxComboBox;
    edtKPI_DATA: TcxComboBox;
    RzLabel2: TRzLabel;
    edtRATIO_TYPE: TcxComboBox;
    edt_GODS_ID: TcxTextEdit;
    edtLEVEL_ID: TcxTextEdit;
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FRatioObj: TRecord_;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure InitParams;  //默认参数
  public
    class function EditDialog(var RatioObj: TRecord_): Boolean;
  end;


implementation

uses
  uGlobal;

{$R *.dfm}

procedure TfrmKpiRatioSet.Btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKpiRatioSet.Btn_SaveClick(Sender: TObject);
begin
  if edt_UNIT_ID.AsString='' then Raise Exception.Create('  请选择商品单位'+edt_UNIT_ID.Text+'！  ');
  FRatioObj.FieldByName('UNIT_ID').AsString:=edt_UNIT_ID.AsString;
  ModalResult := mrOk;
end;

procedure TfrmKpiRatioSet.FormCreate(Sender: TObject);
begin
  inherited;
  edt_UNIT_ID.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
end;

class function TfrmKpiRatioSet.EditDialog(var RatioObj: TRecord_): Boolean;
begin
  //若编辑，记录由RatioObj传入;
  result:=False;
  with TfrmKpiRatioSet.Create(nil) do
  begin
    try
      FRatioObj:=RatioObj;
      InitParams;  //默认参数
      result:=(ShowModal=mrOk);
    finally
      free;
    end;
  end;
end;

procedure TfrmKpiRatioSet.InitParams;
var
  CurID,CurValue: string;
begin
  //达标档位
  CurID:=trim(FRatioObj.FieldByName('SEQNO_ID').AsString);
  edtLevel_ID.Text:=FRatioObj.FieldByName('LEVEL_ID').AsString;
  edtLVL_AMT.Text:=FloatToStr(FRatioObj.FieldByName('LEVEL_ID').AsFloat);
  edtLOW_RATE.Text:=FloatToStr(FRatioObj.FieldByName('LOW_RATE').AsFloat);
  edtTIMES_NAME.Text:=FRatioObj.FieldByName('TIMES_ID').AsString;

  edt_GODS_ID.Text:=FRatioObj.FieldByName('GODS_ID').AsString;
  edtKPI_RATIO.Text:=FloatToStr(FRatioObj.FieldByName('KPI_RATIO').AsFloat);
  //商品ID
  CurID:=trim(FRatioObj.FieldByName('GODS_ID').AsString);
  //单位ID
  CurID:=trim(FRatioObj.FieldByName('UNIT_ID').AsString);
  if edt_UNIT_ID.DataSet.Locate('UNIT_ID',CurID,[]) then
  begin
    edt_UNIT_ID.KeyValue:=CurID;
    edt_UNIT_ID.Text:=edt_UNIT_ID.DataSet.FieldByName('UNIT_NAME').AsString;
  end;
  //考核标准:
  edtKPI_DATA.Properties.ReadOnly:=False;
  CurValue:=trim(FRatioObj.FieldByName('KPI_DATA').AsString);
  edtKPI_DATA.ItemIndex:=TdsItems.FindItems(edtKPI_DATA.Properties.Items,'CODE_ID',CurValue);
  edtKPI_DATA.Properties.ReadOnly:=True;
  //计算标准:
  edtKPI_CALC.Properties.ReadOnly:=False;
  CurValue:=trim(FRatioObj.FieldByName('KPI_CALC').AsString);
  edtKPI_CALC.ItemIndex:=TdsItems.FindItems(edtKPI_CALC.Properties.Items,'CODE_ID',CurValue);
  edtKPI_CALC.Properties.ReadOnly:=True;
  //返利设定:
  edtRATIO_TYPE.Properties.ReadOnly:=False;
  CurValue:=trim(FRatioObj.FieldByName('RATIO_TYPE').AsString);
  edtRATIO_TYPE.ItemIndex:=TdsItems.FindItems(edtRATIO_TYPE.Properties.Items,'CODE_ID',CurValue);
  edtRATIO_TYPE.Properties.ReadOnly:=True;
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

end.
