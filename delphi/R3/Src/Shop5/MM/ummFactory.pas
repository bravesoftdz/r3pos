unit ummFactory;

interface
uses SysUtils, Classes, Windows,Registry, Winsock, NB30, ZBase, Dialogs;
type
  PmmUserInfo=^TmmUserInfo;
  TmmUserInfo=record

  
  end;
  
  PConnectFava=^TConnectFava;
  TConnectFava=record
    planText:Pchar;
    encodingData:Pchar;
    status:Pchar;
    playerId:Pchar;
  end;

  TmmFactory=class
  private
  public
    constructor Create;
    destructor Destroy;override;

    function ConnectTo():boolean;
  end;
function mmcSetCallBack(func:Pointer):integer;stdcall;
function mmcSend(flag:integer;lpData:Pointer):integer;stdcall;
var mmFactory:TmmFactory;
implementation
const dllname='mmc.dll';
function mmcSetCallBack;external dllname name 'SetCallBack';
function mmcSend;external dllname name 'dllfunc';

function mmcRecv(flag:integer;lpData:Pointer):integer;stdcall;
var
  ConnectFava:PConnectFava;
begin
  ConnectFava := lpData;
end;

{ TmmFactory }
function TmmFactory.ConnectTo: boolean;
var
  ConnectFava:TConnectFava;
  s1,s2,s3,s4:string;
begin
  s1 := 'test';
  ConnectFava.planText := Pchar(s1);
  ConnectFava.encodingData := Pchar(s2);
  ConnectFava.status := Pchar(s3);
  ConnectFava.playerId := Pchar(s4);
  mmcSend(1,@ConnectFava);
end;

constructor TmmFactory.Create;
begin
  mmFactory := self;
  mmcSetCallBack(@mmcRecv);
end;

destructor TmmFactory.Destroy;
begin

  inherited;
end;
end.
