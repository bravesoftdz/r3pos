unit ufrmTimer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzTabs, RzButton, StdCtrls, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxTimeEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxRadioGroup,DateUtils;

type
  TTaskTimer=class;
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
    class function Designer(var TimerStr:string):Boolean;
    property TaskTimer:TTaskTimer read FTaskTimer write SetTaskTimer;
  end;

  TTimerType=(ttOne,ttDay,ttWeek,ttMonth);
  TTaskTimer=class
  private
    FTimerType: TTimerType;
    FWeekIntrl: Integer;
    FMonthDay: Integer;
    FMonthWeek: Integer;
    FDayIntrl: Integer;
    FMonthType: Integer;
    FMonthEntr: Integer;
    FTime: string;
    FWeeks: string;
    FOneDay: string;
    procedure SetTimerType(const Value: TTimerType);
    procedure SetDayIntrl(const Value: Integer);
    procedure SetMonthDay(const Value: Integer);
    procedure SetMonthEntr(const Value: Integer);
    procedure SetMonthType(const Value: Integer);
    procedure SetMonthWeek(const Value: Integer);
    procedure SetOneDay(const Value: string);
    procedure SetTime(const Value: string);
    procedure SetWeekIntrl(const Value: Integer);
    procedure SetWeeks(const Value: string);
  public
    procedure Decode(Str:string);
    function  EnCode:string;
    function  Checked(aDate:string;NearTime:string): Boolean;

    property TimerType:TTimerType read FTimerType write SetTimerType;
    //一次性时，执行日期 20060101
    property OneDay:string read FOneDay write SetOneDay;
    //按天时，每几天执行
    property DayIntrl:Integer read FDayIntrl write SetDayIntrl;
    //按周时,间隔几周执行
    property WeekIntrl:Integer read FWeekIntrl write SetWeekIntrl;
    //按周时，执行周次 1111111 第一位表示周日
    property Weeks:string read FWeeks write SetWeeks;
    //0 指定几号  1 按周执行
    property MonthType:Integer read FMonthType write SetMonthType;
    //按月指定几号执行
    property MonthDay:Integer read FMonthDay write SetMonthDay;
    //按月指定第几周执行
    property MonthEntr:Integer read FMonthEntr write SetMonthEntr;
    //按月指定的周几执行
    property MonthWeek:Integer read FMonthWeek write SetMonthWeek;
    //执行时间
    property Time:string read FTime write SetTime;

  end;
implementation
uses uFnUtil,uIdComm;
{$R *.dfm}

{ TTaskTimer }

procedure TTaskTimer.Decode(Str: string);
var s:string;
  Size:Integer;
  sm:TStringStream;
  tt:TTimerType;
begin
  if Str='' then Exit;
  s := gsmString2Bytes(Str);
  sm := TStringStream.Create(s);
  try
    sm.ReadBuffer(tt,SizeOf(TimerType));
    TimerType := tt;
    sm.ReadBuffer(Size,SizeOf(Size));
    if Size<>0 then
       begin
         SetLength(s,Size);
         sm.ReadBuffer(Pchar(s)^,Size);
         OneDay := s;
       end;
    sm.ReadBuffer(Size,SizeOf(DayIntrl));
    DayIntrl := Size;
    sm.ReadBuffer(Size,SizeOf(WeekIntrl));
    WeekIntrl := Size;
    sm.ReadBuffer(Size,SizeOf(Size));
    if Size<>0 then
       begin
         SetLength(s,Size);
         sm.ReadBuffer(Pchar(s)^,Size);
         Weeks := s;
       end;
    sm.ReadBuffer(Size,SizeOf(MonthType));
    MonthType := Size;
    sm.ReadBuffer(Size,SizeOf(MonthDay));
    MonthDay := Size;
    sm.ReadBuffer(Size,SizeOf(MonthEntr));
    MonthEntr := Size;
    sm.ReadBuffer(Size,SizeOf(MonthWeek));
    MonthWeek := Size;

    sm.ReadBuffer(Size,SizeOf(Size));
    if Size<>0 then
       begin
         SetLength(s,Size);
         sm.ReadBuffer(Pchar(s)^,Size);
         Time := s;
       end;
  finally
    sm.Free;
  end;
end;

function TTaskTimer.EnCode: string;
var sm:TStringStream;
  Size:Integer;
  s:string;
begin
  sm := TStringStream.Create('');
  try
    sm.Write(TimerType,SizeOf(TimerType));
    Size := length(OneDay);
    sm.Write(Size,SizeOf(Size));
    if Size<>0 then
       sm.Write(Pchar(OneDay)^,Size);

    sm.Write(DayIntrl,SizeOf(DayIntrl));
    sm.Write(WeekIntrl,SizeOf(WeekIntrl));

    Size := length(Weeks);
    sm.Write(Size,SizeOf(Size));
    if Size<>0 then
       sm.Write(Pchar(Weeks)^,Size);

    sm.Write(MonthType,SizeOf(MonthType));
    sm.Write(MonthDay,SizeOf(MonthDay));
    sm.Write(MonthEntr,SizeOf(MonthEntr));
    sm.Write(MonthWeek,SizeOf(MonthWeek));
    Size := length(Time);
    sm.Write(Size,SizeOf(Size));
    if Size<>0 then
       sm.Write(Pchar(Time)^,Size);
    s := sm.DataString;

    result := gsmBytes2String(s);
  finally
    sm.Free;
  end;
end;

function TTaskTimer.Checked(aDate:string;NearTime:string): Boolean;
begin
  result := false;
  if aDate='' then exit;
  case TimerType of
  ttOne:begin
      Result := (formatDatetime('YYYYMMDD',date())=OneDay);
    end;
  ttDay:begin
      Result := ((trunc(Date()-fnTime.fnStrtoDate(aDate)) mod DayIntrl)=0);
    end;
  ttWeek:begin
      result :=  (trunc((WeekOfTheYear(Date())-WeekOfTheYear(fnTime.fnStrtoDate(aDate))) mod WeekIntrl)=0);
      result := result and (Weeks[DayOfWeek(Date())]='1');
    end;
  ttMonth:begin
      case MonthType of
      0:begin
          result := (DayOf(Date())=MonthDay);
        end;
      1:begin
          result := ((WeekOfTheYear(Date())-WeekOfTheYear(EncodeDate(YearOf(Date()),MonthOf(Date()),1))+1)=MonthEntr);
          result := result and (DayOfWeek(Date())=MonthWeek);
        end;
      end;
    end;
  end;
  Result := Result and (Time<=formatDatetime('HH:NN:SS',now())) and (Time>NearTime);
end;

procedure TTaskTimer.SetDayIntrl(const Value: Integer);
begin
  FDayIntrl := Value;
end;

procedure TTaskTimer.SetMonthDay(const Value: Integer);
begin
  FMonthDay := Value;
end;

procedure TTaskTimer.SetMonthEntr(const Value: Integer);
begin
  FMonthEntr := Value;
end;

procedure TTaskTimer.SetMonthType(const Value: Integer);
begin
  FMonthType := Value;
end;

procedure TTaskTimer.SetMonthWeek(const Value: Integer);
begin
  FMonthWeek := Value;
end;

procedure TTaskTimer.SetOneDay(const Value: string);
begin
  FOneDay := Value;
end;

procedure TTaskTimer.SetTime(const Value: string);
begin
  FTime := Value;
end;

procedure TTaskTimer.SetTimerType(const Value: TTimerType);
begin
  FTimerType := Value;
end;

procedure TTaskTimer.SetWeekIntrl(const Value: Integer);
begin
  FWeekIntrl := Value;
end;

procedure TTaskTimer.SetWeeks(const Value: string);
begin
  FWeeks := Value;
end;

{ TfrmTimer }

class function TfrmTimer.Designer(var TimerStr: string): Boolean;
begin
  with TfrmTimer.Create(Application) do
    begin
      try
         TaskTimer.Decode(TimerStr);
         ShowTimer;
         Result := (ShowModal=MROK);
         if Result then
            TimerStr := TaskTimer.EnCode;
      finally
         free;
      end;
    end;
end;

procedure TfrmTimer.edtTimerTypeClick(Sender: TObject);
begin
  inherited;
  case edtTimerType.ItemIndex of
  0:GroupBox1.BringToFront;
  1:GroupBox2.BringToFront;
  2:GroupBox3.BringToFront;
  3:GroupBox4.BringToFront;
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
