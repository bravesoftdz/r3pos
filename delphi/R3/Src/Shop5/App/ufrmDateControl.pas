unit ufrmDateControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, RzPanel, StdCtrls, RzLabel, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmDateControl = class(TFrame)
    RzPanel1: TRzPanel;
    LabToday: TRzLabel;
    LabYesterday: TRzLabel;
    LabThisweek: TRzLabel;
    LabThisMonth: TRzLabel;
    LabLastMonth: TRzLabel;
    procedure LabTodayClick(Sender: TObject);
    procedure LabYesterdayClick(Sender: TObject);
    procedure LabThisweekClick(Sender: TObject);
    procedure LabThisMonthClick(Sender: TObject);
    procedure LabLastMonthClick(Sender: TObject);
  private
    FEndDateControl: TComponent;
    FStartDateControl: TComponent;
    procedure SetEndDateControl(const Value: TComponent);
    procedure SetStartDateControl(const Value: TComponent);
    { Private declarations }
  public
    { Public declarations }
    property StartDateControl: TComponent read FStartDateControl write SetStartDateControl;
    property EndDateControl:TComponent read FEndDateControl write SetEndDateControl;
  end;

implementation
uses DateUtils, uFnUtil;
{$R *.dfm}

{ TfrmDateControl }

procedure TfrmDateControl.LabTodayClick(Sender: TObject);
begin
  if StartDateControl is TcxDateEdit then
    TcxDateEdit(StartDateControl).Date := Today();
  if EndDateControl is TcxDateEdit then
    TcxDateEdit(EndDateControl).Date := Today();
end;

procedure TfrmDateControl.LabYesterdayClick(Sender: TObject);
begin
  if StartDateControl is TcxDateEdit then
    TcxDateEdit(StartDateControl).Date := Yesterday();
  if EndDateControl is TcxDateEdit then
    TcxDateEdit(EndDateControl).Date := Yesterday();
end;

procedure TfrmDateControl.SetEndDateControl(const Value: TComponent);
begin
  FEndDateControl := Value;
end;

procedure TfrmDateControl.SetStartDateControl(const Value: TComponent);
begin
  FStartDateControl := Value;
end;

procedure TfrmDateControl.LabThisweekClick(Sender: TObject);
begin
  if StartDateControl is TcxDateEdit then
    TcxDateEdit(StartDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', StartOfTheWeek(date())));
  if EndDateControl is TcxDateEdit then
    TcxDateEdit(EndDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date()));
end;

procedure TfrmDateControl.LabThisMonthClick(Sender: TObject);
begin
  if StartDateControl is TcxDateEdit then
    TcxDateEdit(StartDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date()));
  if EndDateControl is TcxDateEdit then
    TcxDateEdit(EndDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date()));
end;

procedure TfrmDateControl.LabLastMonthClick(Sender: TObject);
begin
  if StartDateControl is TcxDateEdit then
    TcxDateEdit(StartDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', IncMonth(Date,-1)));
  if EndDateControl is TcxDateEdit then
    TcxDateEdit(EndDateControl).Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', EndOfTheMonth(IncMonth(Date,-1))));
end;

end.
