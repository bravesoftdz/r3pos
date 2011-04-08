unit ufrmTimer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ActnList, Menus, RzTabs, RzButton, StdCtrls, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxTimeEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxRadioGroup,DateUtils,uTask;

type
  TfrmTimer = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    edtTimerType: TRadioGroup;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    cxBtnOk: TRzBitBtn;
    cxbtnCancel: TRzBitBtn;
    Label1: TLabel;
    edtTime: TcxTimeEdit;
    Label3: TLabel;
    edtDayIntrl: TcxSpinEdit;
    edtWeekIntrl: TcxSpinEdit;
    Label5: TLabel;
    edtWeek2: TcxCheckBox;
    edtWeek3: TcxCheckBox;
    edtWeek4: TcxCheckBox;
    edtWeek5: TcxCheckBox;
    edtWeek6: TcxCheckBox;
    edtWeek7: TcxCheckBox;
    edtWeek1: TcxCheckBox;
    procedure edtTimerTypeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
  private
    FTaskTimer: TTaskTimer;
    procedure SetTaskTimer(const Value: TTaskTimer);
    { Private declarations }
  public
    { Public declarations }
    procedure ShowTimer;
    procedure WriteTimer;
    class function Designer(Timer:TTaskTimer):Boolean;
    property TaskTimer:TTaskTimer read FTaskTimer write SetTaskTimer;
  end;
implementation
uses uFnUtil;
{$R *.dfm}

{ TfrmTimer }

class function TfrmTimer.Designer(Timer:TTaskTimer): Boolean;
begin
  with TfrmTimer.Create(Application) do
    begin
      try
         TaskTimer := Timer;
         ShowTimer;
         Result := (ShowModal=MROK);
      finally
         free;
      end;
    end;
end;

procedure TfrmTimer.edtTimerTypeClick(Sender: TObject);
begin
  inherited;
  case edtTimerType.ItemIndex of
//  0:GroupBox1.BringToFront;
  1:GroupBox2.BringToFront;
  2:GroupBox3.BringToFront;
//  3:GroupBox4.BringToFront;
  end;
end;

procedure TfrmTimer.SetTaskTimer(const Value: TTaskTimer);
begin
  FTaskTimer := Value;
end;

procedure TfrmTimer.FormCreate(Sender: TObject);
begin
  inherited;
  TaskTimer := TTaskTimer.Create;
end;

procedure TfrmTimer.FormDestroy(Sender: TObject);
begin
  inherited;
  TaskTimer.Free;
end;

procedure TfrmTimer.ShowTimer;
begin
  if TaskTimer.DayIntrl=0 then
     edtMonthDay.Value := 1
  else
     edtMonthDay.Value := TaskTimer.MonthDay;
  edtMonthEntr.ItemIndex := TaskTimer.MonthEntr-1;
  edtMonthWeek.ItemIndex := TaskTimer.MonthWeek-1;
  if TaskTimer.DayIntrl=0 then
     edtWeekIntrl.Value := 1
  else
     edtWeekIntrl.Value := TaskTimer.WeekIntrl;
  if TaskTimer.Weeks= '' then TaskTimer.Weeks := '0000000';
  edtWeek1.Checked := (TaskTimer.Weeks[1]='1');
  edtWeek2.Checked := (TaskTimer.Weeks[2]='1');
  edtWeek3.Checked := (TaskTimer.Weeks[3]='1');
  edtWeek4.Checked := (TaskTimer.Weeks[4]='1');
  edtWeek5.Checked := (TaskTimer.Weeks[5]='1');
  edtWeek6.Checked := (TaskTimer.Weeks[6]='1');
  edtWeek7.Checked := (TaskTimer.Weeks[7]='1');
  if TaskTimer.DayIntrl=0 then
     edtDayIntrl.Value := 1
  else
     edtDayIntrl.Value := TaskTimer.DayIntrl;
  if TaskTimer.OneDay = '' then
     edtOneDay.EditValue := Date()
  else
     edtOneDay.EditValue := fnTime.fnStrtoDate(TaskTimer.OneDay);

  if TaskTimer.Time = '' then
     edtTime.Text := '00:00:00'
  else
     edtTime.Text := TaskTimer.Time;
  edtTimerType.ItemIndex := ord(TaskTimer.TimerType);
end;

procedure TfrmTimer.cxBtnOkClick(Sender: TObject);
begin
  inherited;
  WriteTimer;
  Self.ModalResult := MROK;
end;

procedure TfrmTimer.WriteTimer;
var s:string;
begin
  TaskTimer.MonthDay := edtMonthDay.Value;
  TaskTimer.MonthEntr := edtMonthEntr.ItemIndex+1;
  TaskTimer.MonthWeek := edtMonthWeek.ItemIndex+1;
  TaskTimer.WeekIntrl := edtWeekIntrl.Value;
  s := '';
  if edtWeek1.Checked then s := s+'1' else s := s+'0';
  if edtWeek2.Checked then s := s+'1' else s := s+'0';
  if edtWeek3.Checked then s := s+'1' else s := s+'0';
  if edtWeek4.Checked then s := s+'1' else s := s+'0';
  if edtWeek5.Checked then s := s+'1' else s := s+'0';
  if edtWeek6.Checked then s := s+'1' else s := s+'0';
  if edtWeek7.Checked then s := s+'1' else s := s+'0';
  TaskTimer.Weeks := s;
  TaskTimer.DayIntrl := edtDayIntrl.Value;
  TaskTimer.OneDay := formatDatetime('YYYYMMDD',edtOneDay.date);
  TaskTimer.Time   := edtTime.Text;
  TaskTimer.TimerType := TTimerType(edtTimerType.ItemIndex);
end;

end.
