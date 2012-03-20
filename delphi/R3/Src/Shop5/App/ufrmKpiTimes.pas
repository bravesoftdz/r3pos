unit ufrmKpiTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, ZBase,
  cxDropDownEdit, StdCtrls, RzLabel, cxCalendar, cxCheckBox, uDsUtil, uFnUtil;

type
  TfrmKpiTimes = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    lab_IDX_TYPE: TRzLabel;
    RzLabel2: TRzLabel;
    lab_KPI_TYPE: TLabel;
    RzLabel3: TRzLabel;
    edtKPI_CALC: TcxComboBox;
    edtKPI_DATA: TcxComboBox;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    edtKPI_DATE1: TcxDateEdit;
    edtKPI_DATE2: TcxDateEdit;
    RzLabel4: TRzLabel;
    edtTIMES_NAME: TcxTextEdit;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    edtRATIO_TYPE: TcxComboBox;
    edtKPI_FLAG: TcxCheckBox;
    edtUSING_BRRW: TcxCheckBox;
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FKpiFlag: String;
    FKpiCalc: String;
    FKpiData: string;
    FKpiDate2: Integer;
    FKpiDate1: Integer;
    FRatioType: String;
    FTimesName: String;
    FUsingBrrw: String;
    FIsFirst: Boolean;
    procedure SetKpiFlag(const Value: String);
    procedure SetKpiCalc(const Value: String);
    procedure SetKpiData(const Value: string);
    procedure SetKpiDate1(const Value: Integer);
    procedure SetKpiDate2(const Value: Integer);
    procedure SetRatioType(const Value: String);
    procedure SetTimesName(const Value: String);
    procedure SetUsingBrrw(const Value: String);
    procedure SetIsFirst(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property IsFirst:Boolean read FIsFirst write SetIsFirst;
    property KpiFlag:String read FKpiFlag write SetKpiFlag;
    property KpiData:string read FKpiData write SetKpiData;
    property KpiCalc:String read FKpiCalc write SetKpiCalc;
    property RatioType:String read FRatioType write SetRatioType;
    property TimesName:String read FTimesName write SetTimesName;
    property UsingBrrw:String read FUsingBrrw write SetUsingBrrw;
    property KpiDate1:Integer read FKpiDate1 write SetKpiDate1;
    property KpiDate2:Integer read FKpiDate2 write SetKpiDate2;
  end;


implementation

{$R *.dfm}

procedure TfrmKpiTimes.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmKpiTimes.SetIsFirst(const Value: Boolean);
begin
  FIsFirst := Value;
end;

procedure TfrmKpiTimes.SetKpiCalc(const Value: String);
begin
  FKpiCalc := Value;
  if not IsFirst then Exit;
  edtKPI_CALC.ItemIndex := TdsItems.FindItems(edtKPI_CALC.Properties.Items,'CODE_ID',Value);
end;

procedure TfrmKpiTimes.SetKpiData(const Value: string);
begin
  FKpiData := Value;
  if not IsFirst then Exit;
  edtKPI_DATA.ItemIndex := TdsItems.FindItems(edtKPI_DATA.Properties.Items,'CODE_ID',Value);
end;

procedure TfrmKpiTimes.SetKpiDate1(const Value: Integer);
begin
  FKpiDate1 := Value;
  if not IsFirst then Exit;

  edtKPI_DATE1.Date := FnTime.fnStrtoDate(IntToStr(CurrentYear*10000+Value));
end;

procedure TfrmKpiTimes.SetKpiDate2(const Value: Integer);
begin
  FKpiDate2 := Value;
  if not IsFirst then Exit;
  if FKpiDate1 > FKpiDate2 then
     edtKPI_DATE2.Date := FnTime.fnStrtoDate(IntToStr((CurrentYear+1)*10000+Value))
  else
     edtKPI_DATE2.Date := FnTime.fnStrtoDate(IntToStr(CurrentYear*10000+Value));
end;

procedure TfrmKpiTimes.SetKpiFlag(const Value: String);
begin
  FKpiFlag := Value;
  if not IsFirst then Exit;
  if Value = '0' then
     edtKPI_FLAG.Checked := False
  else
     edtKPI_FLAG.Checked := True;
end;

procedure TfrmKpiTimes.SetRatioType(const Value: String);
begin
  FRatioType := Value;
  if not IsFirst then Exit;
  edtRATIO_TYPE.ItemIndex := TdsItems.FindItems(edtRATIO_TYPE.Properties.Items,'CODE_ID',Value);
end;

procedure TfrmKpiTimes.SetTimesName(const Value: String);
begin
  FTimesName := Value;
  if not IsFirst then Exit;
  edtTIMES_NAME.Text := Value;
end;

procedure TfrmKpiTimes.SetUsingBrrw(const Value: String);
begin
  FUsingBrrw := Value;
  if not IsFirst then Exit;
  if Value = '1' then
     edtUSING_BRRW.Checked := True
  else
     edtUSING_BRRW.Checked := False;
end;

procedure TfrmKpiTimes.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  if edtKPI_DATE1.Date > edtKPI_DATE2.Date then Raise Exception.Create('"开始日期"不能大于"终止日期",请重新选择!');
  IsFirst := False;
  TimesName := edtTIMES_NAME.Text;
  RatioType := TRecord_(edtRATIO_TYPE.Properties.Items.Objects[edtRATIO_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  KpiData := TRecord_(edtKPI_DATA.Properties.Items.Objects[edtKPI_DATA.ItemIndex]).FieldbyName('CODE_ID').AsString;
  KpiCalc := TRecord_(edtKPI_CALC.Properties.Items.Objects[edtKPI_CALC.ItemIndex]).FieldbyName('CODE_ID').AsString;;
  KpiDate1 := StrToInt(FormatDateTime('YYYYMMDD',edtKPI_DATE1.Date)) mod 10000;
  KpiDate2 := StrToInt(FormatDateTime('YYYYMMDD',edtKPI_DATE2.Date)) mod 10000;
  if edtKPI_FLAG.Checked then KpiFlag := '1' else KpiFlag := '0';
  if edtUSING_BRRW.Checked then UsingBrrw := '1' else UsingBrrw := '0';
  ModalResult := mrOk;
end;

procedure TfrmKpiTimes.FormShow(Sender: TObject);
begin
  inherited;
  if edtTIMES_NAME.CanFocus then edtTIMES_NAME.SetFocus;
end;

end.
