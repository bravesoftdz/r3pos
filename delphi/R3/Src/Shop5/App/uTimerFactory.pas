unit uTimerFactory;

interface
uses Classes,SysUtils,Windows,ActiveX;
type
  TTimerFactory=class(TThread)
  private
    Proc:TNotifyEvent;
    FTimeOut: int64;
    hEvent: THandle;
    hExecEvent: THandle;
    procedure SetTimeOut(const Value: int64);
  public
    function Terminated:boolean;
    procedure Execute; override;
    constructor Create(AProc:TNotifyEvent;uTimeOut:int64);
    destructor Destroy; override;
    property TimeOut:int64 read FTimeOut write SetTimeOut;
  end;
var TimerFactory:TTimerFactory;
implementation

{ TTimerFactory }

constructor TTimerFactory.Create(AProc:TNotifyEvent;uTimeOut:int64);
begin
  Proc := AProc;
  FreeOnTerminate := false;
  hEvent := CreateEvent(nil, True, False, nil);
  hExecEvent := CreateEvent(nil, True, False, nil);
  ResetEvent(hEvent);
  ResetEvent(hExecEvent);
  TimeOut := uTimeOut;
  inherited Create(false);
end;

destructor TTimerFactory.Destroy;
begin
  Terminate;
  SetEvent(hEvent);
  TimeOut := 20000;
  WaitForSingleObject(hExecEvent, TimeOut);
  if hEvent<>0 then CloseHandle(hEvent);
  if hExecEvent<>0 then CloseHandle(hExecEvent);
  inherited;
  TimerFactory := nil;
end;

procedure TTimerFactory.Execute;
begin
  CoInitialize(nil);
  try
    ResetEvent(hEvent);
    ResetEvent(hExecEvent);
    while not Terminated do
      begin
        if StrtoIntDef(formatDatetime('hh',now()),0) in [8..20] then Proc(nil);
        if not Terminated then
           begin
             ResetEvent(hEvent);
             WaitForSingleObject(hEvent, TimeOut);
           end;
      end;
  finally
    SetEvent(hExecEvent);
    CoUninitialize;
  end;
end;

procedure TTimerFactory.SetTimeOut(const Value: int64);
begin
  FTimeOut := Value;
  SetEvent(hEvent);
end;

function TTimerFactory.Terminated: boolean;
begin
  result := inherited Terminated;
end;

end.
