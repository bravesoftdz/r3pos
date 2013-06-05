unit uRtcLibFactory;

interface

uses Windows, Messages, Forms, SysUtils, Classes, Dialogs, DB, msxml, ComObj;

const
  appId = '01_01_01_0';
  dllname = 'iRTCLib.dll';

type
  TDllGetCustAuthen = function(appId:pchar;var netStatus:integer;ticket:pchar;var ticketLength:integer):integer;stdcall;
  TDllLog = function(appId:pchar;ticket:pchar;ticketLength:integer;levelId,eventId:integer;logText:pchar;logTextLength:integer):integer;stdcall;
  TDllSendDataAsync = function(appId:pchar;ticket:pchar;ticketLength:integer;data:pchar;dataLength:integer;controlFlag:integer;var jobId:integer):integer;stdcall;
  TDllHeartBeat = function(appId:pchar;ticket:pchar;ticketLength:integer;msg:pchar;var msgLength:integer):integer;stdcall;

  TRtcLibFactory=class
  private
    dllHandle:THandle;
    DllLog:TDllLog;
    DllHeartBeat:TDllHeartBeat;
    GetCustAuthen:TDllGetCustAuthen;
    SendDataAsync:TDllSendDataAsync;
    procedure LoadDllFactory;
    procedure FreeDllFactory;
    function  GetXmlHeader(xml:widestring):widestring;
  public
    ticket:string;
    ticketLength,NetStatus:integer;
    dllLoaded,dllValid,dllAuthed:boolean;
    constructor Create;
    destructor Destroy; override;
    function  GetToken:integer;
    function  HeartBeat:integer;
    function  RtcLogout:integer;
    function  SendData(xml:widestring):integer;
  end;

var RtcLibFactory:TRtcLibFactory;

implementation

constructor TRtcLibFactory.Create;
begin
  dllValid := false;
  dllLoaded := false;
  dllAuthed := false;
  LoadDllFactory;
  if dllValid then
     begin
       ticketLength := 5000;
       SetLength(ticket,ticketLength);
     end;
end;

destructor TRtcLibFactory.Destroy;
begin
  inherited;
  FreeDllFactory;
end;

procedure TRtcLibFactory.LoadDllFactory;
begin
  if dllValid then Exit;
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  dllHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if dllHandle = 0 then Exit;
  dllLoaded := true;

  @GetCustAuthen := GetProcAddress(dllHandle, 'GetCustAuthen');
  if @GetCustAuthen = nil then Exit;

  @DllLog := GetProcAddress(dllHandle, 'Log');
  if @DllLog = nil then Exit;

  @DllHeartBeat := GetProcAddress(dllHandle, 'HeartBeat');
  if @DllHeartBeat = nil then Exit;

  @SendDataAsync := GetProcAddress(dllHandle, 'SendDataAsync');
  if @SendDataAsync = nil then Exit;

  dllValid := true;
end;

procedure TRtcLibFactory.FreeDllFactory;
begin
  if not dllLoaded then Exit;
  FreeLibrary(dllHandle);
  dllValid := false; 
  dllLoaded := false;
  dllAuthed := false;
end;

function TRtcLibFactory.GetToken: integer;
var rtn:integer;
begin
  result := -1;
  if not dllValid then Exit;
  if dllAuthed then
     begin
       result := 0;
       Exit;
     end;
  result := GetCustAuthen(pchar(appId),NetStatus,pchar(ticket),ticketLength);
  if result = 0 then
     begin
       dllAuthed := true;
       SetLength(ticket,ticketLength);
     end;
end;

function TRtcLibFactory.HeartBeat: integer;
var
  msg:string;
  msgLength:integer;
begin
  result := -1;
  if not dllValid then Exit;
  if not dllAuthed then Exit;
  msgLength := 256;
  SetLength(msg,msgLength);
  result := DllHeartBeat(pchar(appId),pchar(ticket),ticketLength,pchar(msg),msgLength);
end;

function TRtcLibFactory.RtcLogout: integer;
var
  logText:string;
  logTextLength:integer;
begin
  result := -1;
  if not dllValid then Exit;
  if not dllAuthed then Exit;
  logText := 'Logout';
  logTextLength := Length(logText);
  result := DllLog(pchar(appId),pchar(ticket),ticketLength,1,2,pchar(logText),logTextLength);
end;

function TRtcLibFactory.SendData(xml: widestring): integer;
var
  jobId:integer;
  data:widestring;
  dataLength:integer;
begin
  result := -1;
  if not dllValid then Exit;
  if not dllAuthed then Exit;
  data := GetXmlHeader(xml);
  ticketLength := Length(ticket);
  dataLength := Length(data);
  result := SendDataAsync(pchar(appId),pchar(ticket),ticketLength,pchar(data),dataLength,3,jobId);
end;

function TRtcLibFactory.GetXmlHeader(xml: widestring): widestring;
begin
  result := '<?xml version="1.0" encoding="UTF-8"?>'+xml;
end;

initialization
  RtcLibFactory := TRtcLibFactory.Create;
finalization
  if Assigned(RtcLibFactory) then FreeAndNil(RtcLibFactory);
end.
