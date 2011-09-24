unit ummFactory;

interface
uses SysUtils, Classes, Forms, Messages, Windows,Registry, Winsock, NB30, ZBase, Dialogs;
const
  WM_MsgRecv=WM_USER+3000;
  WM_MsgEvent=WM_USER+3001;
  WM_MsgHint=WM_USER+3002;
  WM_LINE=WM_USER+3003;
  WM_MMCLOSE=WM_USER+3004;
  WM_STATUS=WM_USER+3005;
  WM_DESKTOP_REQUEST=WM_USER+3006;
  WM_LCCONTROL=WM_USER+3007;
type

  TmmPlayerFava=class;
  
  PmmUserInfo=^TmmUserInfo;
  TmmUserInfo=record
     uid:string; {用户号}
     line:boolean; {是否在线}
     IsBeBlack:boolean;
     Msgs:TList;
     Handle:THandle;
     PlayerFava:TmmPlayerFava;
  end;
  
  PConnectFava=^TConnectFava;
  TConnectFava=record
    messagetype:integer;
    routetype:integer;
    planText:Pchar;
    encodingData:Pchar;
    status:Pchar;
    playerId:Pchar;
  end;

  PPlayerFava=^TPlayerFava;
  TPlayerFava=record
	  messagetype:integer;
	  routetype:integer;
    //基本信息
	  playerId:pchar;//ID
	  nickName:pchar;//呢称
	  userType:pchar;//类型
	  comId:pchar; //公司ID
    comType:Pchar;  //公司类型，字符串，2位(00:国家局,01:省公司,02:地市公司)
	  provinceId:pchar;//省公司号
	  refId:pchar;//用户refID
	  saledptId:pchar;//营销部ID
	  saleManId:pchar;//客户经理ID
	  serviceId:pchar;//在线客服ID
	  saleCenterId:pchar;//营销中心ID
  	//玩家信息
	  sceneId:pchar; //场景ID
	  instanceId:pchar; //副本ID
	  diaPlayerNum:integer;//正在与当前玩家对话的人数
	  playerStatus:integer;//玩家状态(0：空闲；：忙，默认空闲)
	  playerSkill:integer;//玩家技能(0:没有技能；:客服技能，默认没有技能)
	  clientType:integer;//客户端的类型(0为web客户端，为air客户端)
  end;

  PGroupFava=^TGroupFava;
  TGroupFava=record
	  messagetype:integer;
	  routetype:integer;

	  playerId:pchar;
	  refId:pchar;
	  comId:pchar;
	  chatTxt:pchar;
	  nickName:pchar;
	  showChatTxt:pchar;
  end;

  PSingleFava=^TSingleFava;
  TSingleFava=record
    messagetype:integer;
	  routetype:integer;
    playerId:pchar;//消息发送者
	  refId:pchar;//消息接收者
	  chatTxt:pchar;//内容
	  comId:pchar;//发送消息者公司
	  refPlayerComId:pchar;//消息接收者公司
	  nickName:Pchar;//发送消息者昵称
	  refPlayerName:Pchar;//消息接收者昵称
	  playerType:Pchar;//消息发送者用户类型
	  refPlayerType:Pchar;//消息接收者用户类型
	  playerSkill:integer;//玩家技能(0:没有技能；:客服技能，默认没有技能)
  end;

  PPlayerIdListFava=^TPlayerIdListFava;
  TPlayerIdListFava=record
    messagetype:integer;
	  routetype:integer;
    ListLen:integer;
	  comId:pchar;//发送消息者公司
    playerIdArray:array of pchar;
  end;

  PLCControlFava=^TLCControlFava;
  TLCControlFava=record
    szFlag:integer;
    szMethodName:pchar;
    szPara1:pchar;
    szPara2:pchar;
    szPara3:pchar;
  end;


  TmmMsgFava=class
  private
    FmmFlag: integer;
    FmmEvent: boolean;
    procedure SetmmFlag(const Value: integer);
    procedure SetmmEvent(const Value: boolean);
  public
    constructor Create;
    destructor Destroy;override;
    
    property mmFlag:integer read FmmFlag write SetmmFlag;
    property mmEvent:boolean read FmmEvent write SetmmEvent;
  end;
  
  TmmConnectFava=class(TmmMsgFava)
  private
    ConnectFava:TConnectFava;
  public
    messagetype:integer;
    routetype:integer;
    planText:string;
    encodingData:string;
    status:string;
    playerId:string;

    function Encode:PConnectFava;
    procedure Decode(Value:PConnectFava);
  end;
  
  TmmPlayerFava=class(TmmMsgFava)
  private
    PlayerFava:TPlayerFava;
  public
	  messagetype:integer;
	  routetype:integer;
    //基本信息
	  playerId:string;//ID
	  nickName:string;//呢称
	  userType:string;//类型
	  comId:string; //公司ID

    comType:string;//公司类型，字符串，2位(00:国家局,01:省公司,02:地市公司)
	  provinceId:string;//省公司号
	  refId:string;//用户refID
	  saledptId:string;//营销部ID
	  saleManId:string;//客户经理ID
	  serviceId:string;//在线客服ID
	  saleCenterId:string;//营销中心ID
  	//玩家信息
	  sceneId:string; //场景ID
	  instanceId:string; //副本ID
	  diaPlayerNum:integer;//正在与当前玩家对话的人数
	  playerStatus:integer;//玩家状态(0：空闲；：忙，默认空闲)
	  playerSkill:integer;//玩家技能(0:没有技能；:客服技能，默认没有技能)
	  clientType:integer;//客户端的类型(0为web客户端，为air客户端)

    function Encode:PPlayerFava;
    procedure Decode(Value:PPlayerFava);
  end;

  TmmSingleFava=class(TmmMsgFava)
  private
    SingleFava:TSingleFava;
  public
    messagetype:integer;
	  routetype:integer;
    playerId:string;//消息发送者
	  refId:string;//消息接收者
	  chatTxt:string;//内容
	  comId:string;//发送消息者公司
	  refPlayerComId:string;//消息接收者公司
	  nickName:string;//发送消息者昵称
	  refPlayerName:string;//消息接收者昵称
	  playerType:string;//消息发送者用户类型
	  refPlayerType:string;//消息接收者用户类型
	  playerSkill:integer;//玩家技能(0:没有技能；:客服技能，默认没有技能)
    sendDate:string;
    recvDate:string;

    function Encode:PSingleFava;
    procedure Decode(Value:PSingleFava);

  end;
  TmmGroupFava=class(TmmMsgFava)
  private
    GroupFava:TGroupFava;
  public
	  messagetype:integer;
	  routetype:integer;

	  playerId:string;
	  refId:string;
	  comId:string;
	  chatTxt:string;
	  nickName:string;
	  showChatTxt:string;
    sendDate:string;
    recvDate:string;

    function Encode:PGroupFava;
    procedure Decode(Value:PGroupFava);

  end;

  TmmPlayerIdListFava=class(TmmMsgFava)
  private
    PlayerIdListFava:TPlayerIdListFava;
  public
	  messagetype:integer;
	  routetype:integer;
    ListLen:integer;
	  comId:string;
    playerIdArray:array of string;

    function Encode:PPlayerIdListFava;
    procedure Decode(Value:PPlayerIdListFava);

  end;

  TmmLCControlFava=class(TmmMsgFava)
  private
    LCControlFava:TLCControlFava;
  public
    szMethodName:string;
    szPara1:string;
    szPara2:string;
    szPara3:string;

    function Encode:PLCControlFava;
    procedure Decode(Value:PLCControlFava);
  end;
  
  TmmFactory=class
  private
    FList:TList;
    Flogined: boolean;
    procedure DisposeMsg(index:integer);
    procedure Setlogined(const Value: boolean);
  public
    constructor Create;
    destructor Destroy;override;
    
    procedure Clear;
    function Find(uid:string):PmmUserInfo;
    function GetMsg(mmUserInfo:PmmUserInfo):TmmMsgFava;
    function CheckMsg(mmUserInfo:PmmUserInfo):boolean;
    function HasMsg:boolean;
    function FindFirst:PmmUserInfo;
    procedure Add(mmUserInfo:PmmUserInfo);

    procedure AddRecv(lpData:TmmMsgFava);
    procedure AddEvent(lpData:TmmMsgFava);
    //连接服务
    function mmcConnectTo(Addr:string;Port:integer):boolean;
    function mmcClose:boolean;
    function mmcConnected:boolean;
    //Lc插件方法
    function mmcLcControlFava(mmLCControlFava:TmmLCControlFava):boolean;
    //发送消息
    function mmcSingleFava(mmSingleFava:TmmSingleFava):boolean;
    //请求认证
    function mmcConnectFava(ConnectFava:TmmConnectFava):boolean;
    //注册身份
    function mmcPlayerFava(PlayerFava:TmmPlayerFava):boolean;
    //取在线用户
    function mmcPlayerIdListFava(PlayerIdListFava:TmmPlayerIdListFava):boolean;
    //登录状态
    property logined:boolean read Flogined write Setlogined;
    
  end;

type
   TmmcSetDataCallBack=function(func:Pointer):integer;stdcall;
   TmmcSetEventCallBack=function(func:Pointer):integer;stdcall;
   TmmcSend=function(flag:integer;lpData:Pointer):integer;stdcall;
   TmmcSendSync=function(flag:integer;lpData:Pointer):integer;stdcall;
   TmmcConnect=function(ipAddr:pchar;nPort:integer):integer;stdcall;
   TmmcGetSockStatus=function():integer;stdcall;
   TmmcSetSockClose=function():integer;stdcall;
   TmmcGetDescriptionFromErrorID=function(errCode:integer):pchar;stdcall;

var mmFactory:TmmFactory;
implementation
uses ummGlobal,ufrmMMList;
const dllname='mmc.dll';
var
  DLLHandle:THandle;
  mmcSetDataCallBack:TmmcSetDataCallBack;
  mmcSetEventCallBack:TmmcSetEventCallBack;
  mmcSend:TmmcSend;
  mmcSendSync:TmmcSendSync;
  mmcConnect:TmmcConnect;
  mmcGetSockStatus:TmmcGetSockStatus;
  mmcSetSockClose:TmmcSetSockClose;
  mmcGetDescriptionFromErrorID:TmmcGetDescriptionFromErrorID;
procedure Loadmmc;
begin
  DLLHandle := LoadLibrary(pchar(dllname));
  if DLLHandle=0 then Raise Exception.Create('没找到mmc.dll文件');
  @mmcSetDataCallBack := GetProcAddress(DLLHandle, 'SetDataCallBack');
  @mmcSetEventCallBack := GetProcAddress(DLLHandle, 'SetEventCallBack');
  @mmcSend := GetProcAddress(DLLHandle, 'Send');
  @mmcSendSync := GetProcAddress(DLLHandle, 'SendSync');
  @mmcConnect := GetProcAddress(DLLHandle, 'Connect');
  @mmcGetSockStatus := GetProcAddress(DLLHandle, 'GetSockStatus');
  @mmcSetSockClose := GetProcAddress(DLLHandle, 'SetSockClose');
  @mmcGetDescriptionFromErrorID := GetProcAddress(DLLHandle, 'GetDescriptionFromErrorID');
end;
function mmcRecv(flag:integer;lpData:Pointer):integer;stdcall;
var
  mmSingleFava:TmmSingleFava;
  mmGroupFava:TmmGroupFava;
  mmPlayerIdListFava:TmmPlayerIdListFava;
  mmPlayerFava:TmmPlayerFava;
  mmLCControlFava:TmmLCControlFava;
begin
  case flag of
  1,2,3:begin
         mmLCControlFava := TmmLCControlFava.Create;
         mmLCControlFava.Decode(PLCControlFava(lpData));
         mmFactory.AddRecv(mmLCControlFava);
       end;
  1003:begin
         mmSingleFava := TmmSingleFava.Create;
         mmSingleFava.Decode(PSingleFava(lpData));
         mmFactory.AddRecv(mmSingleFava);
       end;
  1002:begin
         mmGroupFava := TmmGroupFava.Create;
         mmGroupFava.Decode(pGroupFava(lpData));
         mmFactory.AddRecv(mmGroupFava);
       end;
  1010:begin
         mmPlayerIdListFava := TmmPlayerIdListFava.Create;
         mmPlayerIdListFava.Decode(pPlayerIdListFava(lpData));
         mmFactory.AddRecv(mmPlayerIdListFava);
       end;
  1005,1016,1001:begin
         mmPlayerFava := TmmPlayerFava.Create;
         mmPlayerFava.Decode(pPlayerFava(lpData));
         mmFactory.AddRecv(mmPlayerFava);
       end;
  end;
end;
function mmcEvent(Event,EFlag:integer;lpData:Pointer):integer;stdcall;
var
  mmSingleFava:TmmSingleFava;
  mmGroupFava:TmmGroupFava;
begin
case Event of
3:begin
  case EFlag of
  1003:begin
         mmSingleFava := TmmSingleFava.Create;
         try
            mmSingleFava.Decode(PSingleFava(lpData));
            mmFactory.AddEvent(mmSingleFava);
         finally
            mmSingleFava.Free;
         end;
       end;
  1002:begin
         mmGroupFava := TmmGroupFava.Create;
         try
            mmGroupFava.Decode(pGroupFava(lpData));
            mmFactory.AddEvent(mmGroupFava);
         finally
            mmGroupFava.Free;
         end;
       end;
  end;
  end;
2:begin
    if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_MMCLOSE,1,1);
    mmFactory.logined := false;
  end;
end;
end;

{ TmmFactory }
procedure TmmFactory.Add(mmUserInfo: PmmUserInfo);
begin
  FList.Add(mmUserInfo);
  mmUserInfo.Msgs := TList.Create;
end;

procedure TmmFactory.AddEvent(lpData: TmmMsgFava);
var
  mmUserInfo:PmmUserInfo;
begin
  case lpData.mmFlag of
  1003:begin
         mmUserInfo := Find(TmmSingleFava(lpData).playerId);
         if mmUserInfo.IsBeBlack then //黑名单，直接丢去
            begin
              lpData.Free;
              Exit;
            end;
         lpData.mmEvent := true;
         mmUserInfo^.Msgs.Add(lpData);
         PostMessage(mmUserInfo^.Handle,WM_MsgEvent,0,0);
       end;
  1002:begin
         mmUserInfo := Find(TmmGroupFava(lpData).playerId);
         if mmUserInfo.IsBeBlack then //黑名单，直接丢去
            begin
              lpData.Free;
              Exit;
            end;
         lpData.mmEvent := true;
         mmUserInfo^.Msgs.Add(lpData);
         PostMessage(mmUserInfo^.Handle,WM_MsgEvent,0,0);
       end;
  else
       begin
         //丢去不接收对象
         lpData.Free;
       end;
  end;
end;

procedure TmmFactory.AddRecv(lpData: TmmMsgFava);
var
  mmUserInfo:PmmUserInfo;
  i:integer;
begin
  case lpData.mmFlag of
  1,2,3:
       begin
         PostMessage(Application.MainForm.Handle,WM_LCControl,integer(lpData),0);
       end;
  1003:begin
         case TmmSingleFava(lpData).playerSkill of
         9996,9997,9998,9999:
            begin
               mmUserInfo := Find(TmmSingleFava(lpData).refId);
               lpData.mmEvent := true;
            end
         else
            begin
               if (TmmSingleFava(lpData).playerId='') or (TmmSingleFava(lpData).playerId=mmGlobal.xsm_username) then
                  begin
                    mmUserInfo := Find(TmmSingleFava(lpData).refId);
                    if (TmmSingleFava(lpData).playerId='') then
                       begin
                         TmmSingleFava(lpData).playerId := mmGlobal.xsm_username;
                         lpData.mmEvent := true;
                       end;
                  end
               else
                  mmUserInfo := Find(TmmSingleFava(lpData).playerId);
            end;
         end;
         if not Assigned(mmUserInfo) or mmUserInfo.IsBeBlack then //黑名单，直接丢去
            begin
              lpData.Free;
              Exit;
            end;
         mmUserInfo^.Msgs.Add(lpData);
         if lpData.mmEvent then
         begin
            PostMessage(mmUserInfo^.Handle,WM_MsgEvent,0,0);
            if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_MsgHint,0,0);
         end
         else
            PostMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
       end;
  1002:begin
         mmUserInfo := Find(TmmGroupFava(lpData).playerId);
         if not Assigned(mmUserInfo) or mmUserInfo.IsBeBlack then //黑名单，直接丢去
            begin
              lpData.Free;
              Exit;
            end;
         mmUserInfo^.Msgs.Add(lpData);
         PostMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
         if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_MsgHint,0,0);
       end;
  1010:begin
         for i:=0 to TmmPlayerIdListFava(lpData).ListLen - 1 do
            begin
               mmUserInfo := Find(TmmPlayerIdListFava(lpData).playerIdArray[i]);
               if Assigned(mmUserInfo) then
                  mmUserInfo^.line := true;
            end;
         lpData.Free;
         if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_LINE,0,0);
       end;
  1005:begin
         mmUserInfo := Find(TmmPlayerFava(lpData).playerId);
         if Assigned(mmUserInfo) then
            mmUserInfo^.line := false;
         lpData.Free;
         if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_LINE,0,0);
       end;
  1001:begin
         mmUserInfo := Find(TmmPlayerFava(lpData).playerId);
         if Assigned(mmUserInfo) then
            mmUserInfo^.line := true;
         if TmmPlayerFava(lpData).playerId = mmGlobal.xsm_username then
             begin
               if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_MMCLOSE,0,0);
             end
         else
             begin
               if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_LINE,0,0);
             end;
         lpData.Free;
       end;
  1016:begin
         if frmMMList<>nil then PostMessage(frmMMList.Handle,WM_MMCLOSE,0,0);
         lpData.Free;
       end;
  else
       begin
         //丢去不接收对象
         lpData.Free;
       end;
  end;
end;

function TmmFactory.CheckMsg(mmUserInfo: PmmUserInfo): boolean;
begin
  result := (mmUserInfo^.Msgs.Count>0);
end;

procedure TmmFactory.Clear;
var
  i:integer;
begin
  for i := FList.Count -1 downto 0 do
    DisposeMsg(i);
  FList.Clear;
end;

function TmmFactory.mmcConnectTo(Addr:string;Port:integer): boolean;
var
  errCode:integer;
begin
  result := mmcClose;
  errCode := mmcConnect(Pchar(Addr),Port);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

constructor TmmFactory.Create;
begin
  Loadmmc;
  mmFactory := self;
  mmcSetDataCallBack(@mmcRecv);
  mmcSetEventCallBack(@mmcEvent);
  FList := TList.Create;
end;

destructor TmmFactory.Destroy;
begin
  Clear;
  FList.Free;
  mmcSetSockClose;
  if DLLHandle>0 then FreeLibrary(DLLHandle);
  inherited;
end;
procedure TmmFactory.DisposeMsg(index: integer);
var
  i:integer;
  mmUserInfo:PmmUserInfo;
begin
  mmUserInfo := PmmUserInfo(FList[index]);
  for i:=0 to mmUserInfo^.Msgs.Count - 1 do
    TObject(mmUserInfo^.Msgs[i]).Free;
  if mmUserInfo^.PlayerFava <> nil then freeAndNil(mmUserInfo^.PlayerFava);
  if mmUserInfo^.Msgs <> nil then freeAndNil(mmUserInfo^.Msgs);
  dispose(mmUserInfo);
  FList.Delete(index);
end;

function TmmFactory.Find(uid: string): PmmUserInfo;
var
  i:integer;
begin
  result := nil;
  for i:=0 to FList.Count -1 do
    begin
      if PmmUserInfo(FList[i])^.uid = uid then
         begin
           result := PmmUserInfo(FList[i]);
           break;
         end;
    end;
end;

function TmmFactory.GetMsg(mmUserInfo: PmmUserInfo): TmmMsgFava;
begin
  result := TmmMsgFava(mmUserInfo^.Msgs[0]);
  mmUserInfo^.Msgs.Delete(0);
end;

function TmmFactory.mmcConnectFava(ConnectFava: TmmConnectFava): boolean;
var
  _ConnectFava:PConnectFava;
  errCode:integer;
begin
  _ConnectFava := ConnectFava.Encode;
  errCode := mmcSendSync(1000,_ConnectFava);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

function TmmFactory.mmcPlayerFava(PlayerFava: TmmPlayerFava): boolean;
var
  _PlayerFava:PPlayerFava;
  errCode:integer;
begin
  _PlayerFava := PlayerFava.Encode;
  errCode := mmcSendSync(1001,_PlayerFava);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

function TmmFactory.mmcClose: boolean;
var
  errCode:integer;
  i:integer;
begin
  for i:=FList.Count - 1 downto 0 do
    PmmUserInfo(FList[i])^.line := false;
  errCode := mmcSetSockClose();
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
  logined := false;
end;

function TmmFactory.mmcConnected: boolean;
begin
  result := (mmcGetSockStatus=0);
end;

function TmmFactory.mmcPlayerIdListFava(
  PlayerIdListFava: TmmPlayerIdListFava): boolean;
var
  _PlayerIdListFava:PPlayerIdListFava;
  errCode:integer;
begin
  _PlayerIdListFava := PlayerIdListFava.Encode;
  errCode := mmcSend(1010,_PlayerIdListFava);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

function TmmFactory.mmcSingleFava(mmSingleFava: TmmSingleFava): boolean;
var
  _mmSingleFava:PSingleFava;
  errCode:integer;
begin
  _mmSingleFava := mmSingleFava.Encode;
  errCode := mmcSend(1003,_mmSingleFava);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

function TmmFactory.HasMsg: boolean;
var
  i:integer;
begin
  result := false;
  for i:=FList.Count -1 downto 0 do
    begin
      if PmmUserInfo(FList[i]).Msgs.Count >0 then
         begin
           result := true;
           break;
         end;
    end;
end;

function TmmFactory.FindFirst: PmmUserInfo;
var
  i:integer;
begin
  result := nil;
  for i:=FList.Count -1 downto 0 do
    begin
      if PmmUserInfo(FList[i]).Msgs.Count >0 then
         begin
           result := PmmUserInfo(FList[i]);
           break;
         end;
    end;
end;

procedure TmmFactory.Setlogined(const Value: boolean);
begin
  Flogined := Value;
  if frmMMList<>nil then
     PostMessage(frmMMList.Handle,WM_STATUS,0,0);
end;

function TmmFactory.mmcLcControlFava(
  mmLCControlFava: TmmLCControlFava): boolean;
var
  _mmLCControlFava:PLCControlFava;
  errCode:integer;
begin
  _mmLCControlFava := mmLCControlFava.Encode;
  errCode := mmcSend(_mmLCControlFava.szFlag,_mmLCControlFava);
  result := (errCode=0);
  if not result then
     Raise Exception.Create(StrPas(mmcGetDescriptionFromErrorID(errCode)));
end;

{ TmmConnectFava }

procedure TmmConnectFava.Decode(Value: PConnectFava);
begin
  mmFlag := Value^.messagetype;
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  planText := StrPas(Value^.planText);
  encodingData := StrPas(Value^.encodingData);
  status := StrPas(Value^.status);
  playerId := StrPas(Value^.playerId);
end;

function TmmConnectFava.Encode: PConnectFava;
begin
  ConnectFava.messagetype := messagetype;
  ConnectFava.routetype := routetype;
  ConnectFava.planText := Pchar(planText);
  ConnectFava.encodingData := Pchar(encodingData);
  ConnectFava.status := Pchar(status);
  ConnectFava.playerId := Pchar(playerId);
  result := @ConnectFava;
end;

{ TmmPlayerFava }

procedure TmmPlayerFava.Decode(Value: PPlayerFava);
begin
  mmFlag := Value^.messagetype;
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  playerId := StrPas(Value^.playerId);
  nickName := StrPas(Value^.nickName);
  userType := StrPas(Value^.userType);
  comId := StrPas(Value^.comId);
  comType := StrPas(Value^.comType);
  provinceId := StrPas(Value^.provinceId);
  refId := StrPas(Value^.refId);
  saledptId := StrPas(Value^.saledptId);
  saleManId := StrPas(Value^.saleManId);
  serviceId := StrPas(Value^.serviceId);
  saleCenterId := StrPas(Value^.saleCenterId);
  sceneId := StrPas(Value^.sceneId);
  instanceId := StrPas(Value^.instanceId);
  diaPlayerNum := Value^.diaPlayerNum;
  playerStatus := Value^.playerStatus;
  playerSkill := Value^.playerSkill;
  clientType := Value^.clientType;
end;

function TmmPlayerFava.Encode: PPlayerFava;
begin
  PlayerFava.messagetype := messagetype;
  PlayerFava.routetype := routetype;
  PlayerFava.playerId := Pchar(playerId);
  PlayerFava.nickName := Pchar(nickName);
  PlayerFava.userType := Pchar(userType);
  PlayerFava.comId := Pchar(comId);
  PlayerFava.comType := Pchar(comType);
  PlayerFava.provinceId := Pchar(provinceId);
  PlayerFava.refId := Pchar(refId);
  PlayerFava.saledptId := Pchar(saledptId);
  PlayerFava.saleManId := Pchar(saleManId);
  PlayerFava.serviceId := Pchar(serviceId);
  PlayerFava.saleCenterId := Pchar(saleCenterId);
  PlayerFava.sceneId := Pchar(sceneId);
  PlayerFava.instanceId := Pchar(instanceId);
  PlayerFava.diaPlayerNum := diaPlayerNum;
  PlayerFava.playerStatus := playerStatus;
  PlayerFava.playerSkill := playerSkill;
  PlayerFava.clientType := clientType;
  result := @PlayerFava;
end;

{ TmmSingleFava }

procedure TmmSingleFava.Decode(Value: PSingleFava);
begin
  mmFlag := Value^.messagetype;
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  playerId := Strpas(Value^.playerId);
  refId := Strpas(Value^.refId);
  chatTxt := StrPas(Value^.chatTxt);
  comId := StrPas(Value^.comId);
  refPlayerComId := StrPas(Value^.refPlayerComId);
  nickName := StrPas(Value^.nickName);
  refPlayerName := StrPas(Value^.refPlayerName);
  playerType := Pchar(Value^.playerType);
  refPlayerType := Pchar(Value^.refPlayerType);
  playerSkill := Value^.playerSkill;
end;

function TmmSingleFava.Encode: PSingleFava;
begin
  SingleFava.messagetype := messagetype;
  SingleFava.routetype := routetype;
  SingleFava.playerId := Pchar(playerId);
  SingleFava.refId := Pchar(refId);
  SingleFava.chatTxt := Pchar(chatTxt);
  SingleFava.comId := Pchar(comId);
  SingleFava.refPlayerComId := Pchar(refPlayerComId);
  SingleFava.nickName := Pchar(nickName);
  SingleFava.refPlayerName := Pchar(refPlayerName);
  SingleFava.playerType := Pchar(playerType);
  SingleFava.refPlayerType := Pchar(refPlayerType);
  SingleFava.playerSkill := playerSkill;
  result := @SingleFava;
end;

{ TmmMsgFava }

constructor TmmMsgFava.Create;
begin
  mmEvent := false;
end;

destructor TmmMsgFava.Destroy;
begin

  inherited;
end;

procedure TmmMsgFava.SetmmEvent(const Value: boolean);
begin
  FmmEvent := Value;
end;

procedure TmmMsgFava.SetmmFlag(const Value: integer);
begin
  FmmFlag := Value;
end;

{ TmmGroupFava }

procedure TmmGroupFava.Decode(Value: PGroupFava);
begin
  mmFlag := Value^.messagetype;
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  playerId := Strpas(Value^.playerId);
  refId := Strpas(Value^.refId);
  chatTxt := StrPas(Value^.chatTxt);
  comId := StrPas(Value^.comId);
  nickName := StrPas(GroupFava.nickName);
  showChatTxt := StrPas(GroupFava.showChatTxt);
end;

function TmmGroupFava.Encode: PGroupFava;
begin
  GroupFava.messagetype := messagetype;
  GroupFava.routetype := routetype;
  GroupFava.playerId := Pchar(playerId);
  GroupFava.refId := Pchar(refId);
  GroupFava.chatTxt := Pchar(chatTxt);
  GroupFava.comId := Pchar(comId);
  GroupFava.nickName := Pchar(nickName);
  GroupFava.showChatTxt := Pchar(showChatTxt);
  result := @GroupFava;
end;

{ TmmPlayerIdListFava }

procedure TmmPlayerIdListFava.Decode(Value: PPlayerIdListFava);
var i:integer;
begin
  mmFlag := Value^.messagetype;
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  ListLen := Value^.ListLen;
  comId := StrPas(Value^.comId);
  SetLength(playerIdArray,ListLen);
  for i:=0 to ListLen-1 do
    playerIdArray[i] := StrPas(Value^.playerIdArray[i]);
end;

function TmmPlayerIdListFava.Encode: PPlayerIdListFava;
var
  i:integer;
begin
  PlayerIdListFava.messagetype := messagetype;
  PlayerIdListFava.routetype := routetype;
  PlayerIdListFava.ListLen := ListLen;
  PlayerIdListFava.comId := Pchar(comId);
  for i:=0 to ListLen-1 do
    PlayerIdListFava.playerIdArray[i] := Pchar(playerIdArray[i]);
  result := @PlayerIdListFava;
end;

{ TmmLCControlFava }

procedure TmmLCControlFava.Decode(Value: PLCControlFava);
begin
  mmFlag := Value^.szFlag;
  szMethodName := StrPas(Value^.szMethodName);
  szPara1 := StrPas(Value^.szPara1);
  szPara2 := StrPas(Value^.szPara2);
  szPara3 := StrPas(Value^.szPara3);
end;

function TmmLCControlFava.Encode: PLCControlFava;
begin
  LCControlFava.szFlag := mmFlag;
  LCControlFava.szMethodName := Pchar(szMethodName);
  LCControlFava.szPara1 := Pchar(szPara1);
  LCControlFava.szPara2 := Pchar(szPara2);
  LCControlFava.szPara3 := Pchar(szPara3);
  result := @LCControlFava;
end;

end.
