unit ScrnCtrl;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MultiMon, DSUtil, RzPanel, ExtCtrls, jpeg, rzCtrls;
const
  MonitorDefaultFlags: array[TMonitorDefaultTo] of DWORD = (MONITOR_DEFAULTTONEAREST,
                                                          MONITOR_DEFAULTTONULL,
                                                          MONITOR_DEFAULTTOPRIMARY);
function FindMonitor(Handle: THandle): TMonitor;
function MonitorFromWindow(const Handle: THandle;
  MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
function FindMonitorIndex(Monitor: TMonitor): integer;
function GetMonitorExt:integer;
function IsWorkStationLocked:boolean;
function ForceForegroundWindow(hWnd: THandle): BOOL;
var
  MMonitor:TMonitor;
  MIndex:integer;
  SLocked:boolean;
implementation
procedure SwitchToThisWindow(hWnd:THandle;bRestore:boolean);stdcall; external user32 name 'SwitchToThisWindow';  
function ForceForegroundWindow(hWnd: THandle): BOOL;
begin
   SwitchToThisWindow(hWnd,true);
//  AttachThreadInput(GetCurrentThreadId,GetWindowThreadProcessId(hWnd, nil), True);
//  Result := SetForegroundWindow(hWnd);
//  AttachThreadInput(GetCurrentThreadId,GetWindowThreadProcessId(hWnd, nil), False);
end;

function IsWorkStationLocked:boolean;
var
  hDesk:THandle;
begin
  hDesk := OpenDesktop('Default', 0, FALSE, DESKTOP_SWITCHDESKTOP);
  if (hDesk>0) then
     begin
       result := not SwitchDesktop(hDesk);
       CloseDesktop(hDesk);
     end;
  SLocked := result;
end;
function GetMonitorExt:integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Screen.MonitorCount - 1 do
    if MIndex <> I then
    begin
      Result := I;
      break;
    end;
end;
function FindMonitor(Handle: THandle): TMonitor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[I].Handle = Handle then
    begin
      Result := Screen.Monitors[I];
      break;
    end;
end;
function FindMonitorIndex(Monitor: TMonitor): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[I].Handle = Monitor.Handle then
    begin
      Result := i;
      break;
    end;
end;

function MonitorFromWindow(const Handle: THandle;
  MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
begin
  Result := Screen.MonitorFromWindow(Handle,mdNearest);
end;

end.
