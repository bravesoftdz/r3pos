unit ummFactory;

interface
uses SysUtils, Classes, Windows,Registry, Winsock, NB30, ZBase;
type
  PmmUserInfo=^TmmUserInfo;
  TmmUserInfo=record
  end;
  TmmFactory=class
  private
    Furl: string;
    procedure Seturl(const Value: string);

  public
    constructor Create;
    destructor Destroy;override;
    //用户操作
    function AddUser(userId:string):boolean;
    function DeleteUser(userId:string):boolean;
    function ModifyUser(userInfo:TmmUserInfo):boolean;
    //读我的好友
    function getAllfriends:boolean;
    //读我的黑名单
    function getBlackFriends:boolean;
    //读我所在黑名单
    function getBeBlackFriends:boolean;
    //认证服务器跟路径
    property url:string read Furl write Seturl;
  end;
implementation

{ TmmFactory }

function TmmFactory.AddUser(userId: string): boolean;
begin

end;

constructor TmmFactory.Create;
begin

end;

function TmmFactory.DeleteUser(userId: string): boolean;
begin

end;

destructor TmmFactory.Destroy;
begin

  inherited;
end;

function TmmFactory.getAllfriends: boolean;
begin

end;

function TmmFactory.getBeBlackFriends: boolean;
begin

end;

function TmmFactory.getBlackFriends: boolean;
begin

end;

function TmmFactory.ModifyUser(userInfo: TmmUserInfo): boolean;
begin

end;

procedure TmmFactory.Seturl(const Value: string);
begin
  Furl := Value;
end;

end.
