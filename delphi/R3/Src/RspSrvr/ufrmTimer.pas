unit ufrmTimer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ActnList, Menus, RzTabs, RzButton, StdCtrls, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxTimeEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxRadioGroup,DateUtils,uTask,
  Spin, Mask;

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
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    rm1: TRadioButton;
    rm2: TRadioButton;
    edtMonthDay: TSpinEdit;
    edtMonthEntr: TComboBox;
    edtMonthWeek: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dm1: TRadioButton;
    dm2: TRadioButton;
    edtTime: TMaskEdit;
    edtTimeIntrl: TSpinEdit;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    procedure edtTimerTypeClick(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
  private
    FTaskTimer: TTaskTimer;
    procedure SetTaskTimer(const Value: TTaskTimer);
    { Private declarations }
  public
    { Public declarations }
    procedure ShowTimer;
    procedure WriteTimer;
    class function Designer(Owner:TForm;Timer:TTaskTimer):Boolean;
    property TaskTimer:TTaskTimer read FTaskTimer write SetTaskTimer;
  end;
implementation
uses uFnUtil;
{$R *.dfm}

{ TfrmTimer }

class function TfrmTimer.Designer(Owner:TForm;Timer:TTaskTimer): Boolean;
begin
  with TfrmTimer.Create(Owner) do
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
  0:begin
      GroupBox1.Visible := true;
      GroupBox2.Visible := false;
      GroupBox3.Visible := false;
      GroupBox4.Visible := false;
    end;
  1:begin
      GroupBox1.Visible := false;
      GroupBox2.Visible := true;
      GroupBox3.Visible := false;
      GroupBox4.Visible := false;
    end;
  2:begin
      GroupBox1.Visible := false;
      GroupBox2.Visible := false;
      GroupBox3.Visible := true;
      GroupBox4.Visible := false;
    end;
  3:begin
      GroupBox1.Visible := false;
      GroupBox2.Visible := false;
      GroupBox3.Visible := false;
      GroupBox4.Visible := true;
    end;
  end;
end;

procedure TfrmTimer.SetTaskTimer(const Value: TTaskTimer);
begin
  FTaskTimer := Value;
end;

procedure TfrmTimer.ShowTimer;
begin
  if TaskTimer.DayIntrl<=0 then
     edtDayIntrl.Value := 1
  else
     edtDayIntrl.Value := TaskTimer.DayIntrl;
  if TaskTimer.WeekIntrl<=0 then
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

  rm1.Checked := (TaskTimer.MonthDay >0);
  rm2.Checked := not rm1.Checked;

  if TaskTimer.MonthDay<=0 then
     edtMonthDay.Value := 1
  else
     edtMonthDay.Value := TaskTimer.MonthDay;
  edtMonthEntr.ItemIndex := TaskTimer.MonthEntr-1;
  edtMonthWeek.ItemIndex := TaskTimer.MonthWeek-1;

  if TaskTimer.Time = '' then
     edtTime.Text := '00:00:00'
  else
     edtTime.Text := TaskTimer.Time;
  dm1.Checked := edtTime.Text <> '00:00:00';
  dm2.Checked := not dm1.Checked;
  edtTimerType.ItemIndex := ord(TaskTimer.TimerType);

  edtTimeIntrl.Value := TaskTimer.TimeIntrl;
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
  TaskTimer.TimerType := TTimerType(edtTimerType.ItemIndex);

  TaskTimer.DayIntrl := edtDayIntrl.Value;

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
  if not rm1.Checked then TaskTimer.MonthDay := 0;

  TaskTimer.MonthDay := edtMonthDay.Value;
  TaskTimer.MonthEntr := edtMonthEntr.ItemIndex+1;
  TaskTimer.MonthWeek := edtMonthWeek.ItemIndex+1;

  TaskTimer.Time := edtTime.Text;
  if not dm1.Checked then TaskTimer.Time := '00:00:00' else
     begin
       if TaskTimer.Time='00:00:00' then Raise Exception.Create('请设置一次性发生时间点...');
     end;
  TaskTimer.TimeIntrl := edtTimeIntrl.Value;
end;

end.
