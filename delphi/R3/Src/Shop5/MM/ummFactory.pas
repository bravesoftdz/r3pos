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
    //�û�����
    function AddUser(userId:string):boolean;
    function DeleteUser(userId:string):boolean;
    function ModifyUser(userInfo:TmmUserInfo):boolean;
    //���ҵĺ���
    function getAllfriends:boolean;
    //���ҵĺ�����
    function getBlackFriends:boolean;
    //�������ں�����
    function getBeBlackFriends:boolean;
    //��֤��������·��
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
