//***********************************************************//
//        ���:��ɭ��     ���룺��ɭ��
//        �汾:5.0        �޸�����:2011-01-10
//        R3��Ŀ��
//***********************************************************//
unit ZdbFactory;

interface
uses SysUtils,Classes,Windows,DB,ZIntf,ZdbHelp,ZBase,ZAbstractDataset;
type
  TdbFactory = class(TComponent)
  private
    dbResolver:TdbResolver;
  public
    constructor Create;
    destructor  Destroy;override;

    //�������Ӳ���
    function  Initialize(Const ConnStr:WideString):boolean;stdcall;
    //��ȡ���Ӵ�
    function  GetConnectionString:WideString;stdcall;
    //�������ݿ�
    function  Connect:boolean;stdcall;
    //���ͨѶ����״̬
    function  Connected:boolean;stdcall;
    //�ر����ݿ�
    function  DisConnect:boolean;stdcall;

    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //�ύ����
    procedure CommitTrans;stdcall;
    //�ع�����
    procedure RollbackTrans;stdcall;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //���ݰ���֯
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //��ѯ����;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; stdcall;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload; stdcall;
    function Open(DataSet:TDataSet):Boolean;overload;stdcall;

    //�ύ����
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; stdcall;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload; stdcall;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;stdcall;

    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;stdcall;

    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;stdcall;
  end;
implementation

{ TdbFactory }

procedure TdbFactory.BeginTrans(TimeOut: integer);
begin
  dbResolver.BeginTrans(TimeOut); 
end;

procedure TdbFactory.CommitTrans;
begin
  dbResolver.CommitTrans;
end;

function TdbFactory.Connect: boolean;
begin
  result := dbResolver.Connect;
end;

function TdbFactory.Connected: boolean;
begin
  result := dbResolver.Connected;
end;

constructor TdbFactory.Create;
begin
  dbResolver := TdbResolver.Create;
end;

destructor TdbFactory.Destroy;
begin
  dbResolver := nil;
  inherited;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.Open(DataSet,AClassName,Params)
end;

function TdbFactory.DisConnect: boolean;
begin
  result := dbResolver.DisConnect;
end;

function TdbFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  result := dbResolver.ExecSQL(SQL,ObjectFactory);
end;

function TdbFactory.GetConnectionString: WideString;
begin
  result := dbResolver.GetConnectionString;
end;

function TdbFactory.iDbType: Integer;
begin
  result := dbResolver.iDbType;
end;

function TdbFactory.Initialize(const ConnStr: WideString): boolean;
begin
  result := dbResolver.Initialize(ConnStr);
end;

function TdbFactory.InTransaction: boolean;
begin
  result := dbResolver.InTransaction;
end;

function TdbFactory.Open(DataSet: TDataSet): Boolean;
begin
  result := dbResolver.Open(DataSet); 
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.UpdateBatch(DataSet,AClassName,Params);
  if result then TZAbstractDataset(DataSet).CommitUpdates;

end;

procedure TdbFactory.RollbackTrans;
begin
  dbResolver.RollbackTrans;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  result := dbResolver.UpdateBatch(DataSet); 
  if result then TZAbstractDataset(DataSet).CommitUpdates;
end;

function TdbFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.AddBatch(DataSet,AClassName,Params);
end;

function TdbFactory.BeginBatch: Boolean;
begin
  result := dbResolver.BeginBatch;
end;

function TdbFactory.CancelBatch: Boolean;
begin
  result := dbResolver.CancelBatch;
end;

function TdbFactory.CommitBatch: Boolean;
begin
  result := dbResolver.CommitBatch;
end;

function TdbFactory.OpenBatch: Boolean;
begin
  result := dbResolver.OpenBatch;
end;

function TdbFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin
  result := dbResolver.ExecProc(AClassName,Params);
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

end.
