unit ummFactory;

interface
uses SysUtils, Classes, Messages, Windows,Registry, Winsock, NB30, ZBase, Dialogs;
const
  WM_MsgRecv=WM_USER+3000;
  WM_MsgEvent=WM_USER+3001;
  WM_MsgHint=WM_USER+3002;
type

  TmmPlayerFava=class;
  
  PmmUserInfo=^TmmUserInfo;
  TmmUserInfo=record
     uid:string; {�û���}
     line:boolean; {�Ƿ�����}
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
    //������Ϣ
	  playerId:pchar;//ID
	  nickName:pchar;//�س�
	  userType:pchar;//����
	  comId:pchar; //��˾ID
	  provinceId:pchar;//ʡ��˾��
	  refId:pchar;//�û�refID
	  saledptId:pchar;//Ӫ����ID
	  saleManId:pchar;//�ͻ�����ID
	  serviceId:pchar;//���߿ͷ�ID
	  saleCenterId:pchar;//Ӫ������ID
  	//�����Ϣ
	  sceneId:pchar; //����ID
	  instanceId:pchar; //����ID
	  diaPlayerNum:integer;//�����뵱ǰ��ҶԻ�������
	  playerStatus:integer;//���״̬(0�����У���æ��Ĭ�Ͽ���)
	  playerSkill:integer;//��Ҽ���(0:û�м��ܣ�:�ͷ����ܣ�Ĭ��û�м���)
	  clientType:integer;//�ͻ��˵�����(0Ϊweb�ͻ��ˣ�Ϊair�ͻ���)
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
    playerId:pchar;//��Ϣ������
	  refId:pchar;//��Ϣ������
	  chatTxt:pchar;//����
	  comId:pchar;//������Ϣ�߹�˾
	  refPlayerComId:pchar;//��Ϣ�����߹�˾
	  nickName:Pchar;//������Ϣ���ǳ�
	  refPlayerName:Pchar;//��Ϣ�������ǳ�
	  playerType:Pchar;//��Ϣ�������û�����
	  refPlayerType:Pchar;//��Ϣ�������û�����
	  playerSkill:integer;//��Ҽ���(0:û�м��ܣ�:�ͷ����ܣ�Ĭ��û�м���)
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
    //������Ϣ
	  playerId:string;//ID
	  nickName:string;//�س�
	  userType:string;//����
	  comId:string; //��˾ID
	  provinceId:string;//ʡ��˾��
	  refId:string;//�û�refID
	  saledptId:string;//Ӫ����ID
	  saleManId:string;//�ͻ�����ID
	  serviceId:string;//���߿ͷ�ID
	  saleCenterId:string;//Ӫ������ID
  	//�����Ϣ
	  sceneId:string; //����ID
	  instanceId:string; //����ID
	  diaPlayerNum:integer;//�����뵱ǰ��ҶԻ�������
	  playerStatus:integer;//���״̬(0�����У���æ��Ĭ�Ͽ���)
	  playerSkill:integer;//��Ҽ���(0:û�м��ܣ�:�ͷ����ܣ�Ĭ��û�м���)
	  clientType:integer;//�ͻ��˵�����(0Ϊweb�ͻ��ˣ�Ϊair�ͻ���)

    function Encode:PPlayerFava;
    procedure Decode(Value:PPlayerFava);
  end;

  TmmSingleFava=class(TmmMsgFava)
  private
    SingleFava:TSingleFava;
  public
    messagetype:integer;
	  routetype:integer;
    playerId:string;//��Ϣ������
	  refId:string;//��Ϣ������
	  chatTxt:string;//����
	  comId:string;//������Ϣ�߹�˾
	  refPlayerComId:string;//��Ϣ�����߹�˾
	  nickName:string;//������Ϣ���ǳ�
	  refPlayerName:string;//��Ϣ�������ǳ�
	  playerType:string;//��Ϣ�������û�����
	  refPlayerType:string;//��Ϣ�������û�����
	  playerSkill:integer;//��Ҽ���(0:û�м��ܣ�:�ͷ����ܣ�Ĭ��û�м���)
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

  TmmFactory=class
  private
    FList:TList;
    procedure DisposeMsg(index:integer);
  public
    constructor Create;
    destructor Destroy;override;
    
    procedure Clear;
    function Find(uid:string):PmmUserInfo;
    function GetMsg(mmUserInfo:PmmUserInfo):TmmMsgFava;
    function CheckMsg(mmUserInfo:PmmUserInfo):boolean;
    procedure Add(mmUserInfo:PmmUserInfo);

    procedure AddRecv(lpData:TmmMsgFava);
    procedure AddEvent(lpData:TmmMsgFava);
    //���ӷ���
    function mmcConnectTo(Addr:string;Port:integer):boolean;
    //������֤
    function mmcConnectFava(ConnectFava:TmmConnectFava):boolean;
    //ע�����
    function mmcPlayerFava(PlayerFava:TmmPlayerFava):boolean;
  end;

function mmcSetDataCallBack(func:Pointer):integer;stdcall;
function mmcSetEventCallBack(func:Pointer):integer;stdcall;
function mmcSend(flag:integer;lpData:Pointer):integer;stdcall;
function mmcConnect(ipAddr:pchar;nPort:integer):integer;stdcall;
function mmcGetSockStatus():integer;stdcall;
function mmcSetSockClose():integer;stdcall;

var mmFactory:TmmFactory;
implementation
const dllname='mmc.dll';
function mmcSetDataCallBack;external dllname name 'SetDataCallBack';
function mmcSetEventCallBack;external dllname name 'SetEventCallBack';
function mmcSend;external dllname name 'Send';
function mmcConnect;external dllname name 'Connect';
function mmcGetSockStatus;external dllname name 'GetSockStatus';
function mmcSetSockClose;external dllname name 'SetSockClose';

function mmcRecv(flag:integer;lpData:Pointer):integer;stdcall;
var
  ConnectFava:PConnectFava;
begin
  ConnectFava := lpData;
end;
function mmcEvent(Event,EFlag:integer;lpData:Pointer):integer;stdcall;
var
  ConnectFava:PConnectFava;
begin
  ConnectFava := lpData;
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
         if mmUserInfo.IsBeBlack then //��������ֱ�Ӷ�ȥ
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
         if mmUserInfo.IsBeBlack then //��������ֱ�Ӷ�ȥ
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
         //��ȥ�����ն���
         lpData.Free;
       end;
  end;
end;

procedure TmmFactory.AddRecv(lpData: TmmMsgFava);
var
  mmUserInfo:PmmUserInfo;
begin
  case lpData.mmFlag of
  1003:begin
         mmUserInfo := Find(TmmSingleFava(lpData).playerId);
         if mmUserInfo.IsBeBlack then //��������ֱ�Ӷ�ȥ
            begin
              lpData.Free;
              Exit;
            end;
         mmUserInfo^.Msgs.Add(lpData);
         PostMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
         PostMessage(mmUserInfo^.Handle,WM_MsgHint,0,0);
       end;
  1002:begin
         mmUserInfo := Find(TmmGroupFava(lpData).playerId);
         if mmUserInfo.IsBeBlack then //��������ֱ�Ӷ�ȥ
            begin
              lpData.Free;
              Exit;
            end;
         mmUserInfo^.Msgs.Add(lpData);
         PostMessage(mmUserInfo^.Handle,WM_MsgRecv,0,0);
         PostMessage(mmUserInfo^.Handle,WM_MsgHint,0,0);
       end;
  else
       begin
         //��ȥ�����ն���
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
  mmcSetDataCallBack(@mmcRecv);
  mmcSetEventCallBack(@mmcEvent);
  FList := TList.Create;
end;

destructor TmmFactory.Destroy;
begin
  Clear;
  FList.Free;
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
begin

end;

function TmmFactory.mmcPlayerFava(PlayerFava: TmmPlayerFava): boolean;
begin

end;

{ TmmConnectFava }

procedure TmmConnectFava.Decode(Value: PConnectFava);
begin
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
  messagetype := Value^.messagetype;
  routetype := Value^.routetype;
  playerId := StrPas(Value^.playerId);
  nickName := StrPas(Value^.nickName);
  userType := StrPas(Value^.userType);
  comId := StrPas(Value^.comId);
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

end.
