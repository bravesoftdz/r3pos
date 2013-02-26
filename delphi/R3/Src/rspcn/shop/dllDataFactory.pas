unit dllDataFactory;

interface

uses
  SysUtils, Classes, rspcn_TLB,DB ,ZDataSet, ZBase;

type
  TdataFactory = class(TDataModule)
  private
    { Private declarations }
    intf:IjavaScriptExt;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);
    //�ύ����
    procedure CommitTrans;
    //�ع�����
    procedure RollbackTrans;

    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;
    //���ݰ���֯
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //��ѯ����;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function Open(DataSet:TDataSet):Boolean;overload;

    //�ύ����
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;

    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;

    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;
  end;

var
  dataFactory: TdataFactory;

implementation

{$R *.dfm}

{ TdataFactory }

function TdataFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin

end;

function TdataFactory.BeginBatch: Boolean;
begin
  intf.beginbatch;
end;

procedure TdataFactory.BeginTrans(TimeOut: integer);
begin

end;

function TdataFactory.CancelBatch: Boolean;
begin

end;

function TdataFactory.CommitBatch: Boolean;
begin

end;

procedure TdataFactory.CommitTrans;
begin

end;

constructor TdataFactory.Create(AOwner: TComponent);
begin
  inherited;
  intf := CojavaScriptExt.Create;
end;

destructor TdataFactory.Destroy;
begin
  intf := nil;
  inherited;
end;

function TdataFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin

end;

function TdataFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin

end;

function TdataFactory.iDbType: Integer;
begin

end;

function TdataFactory.InTransaction: boolean;
begin

end;

function TdataFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin

end;

function TdataFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin

end;

function TdataFactory.Open(DataSet: TDataSet): Boolean;
begin

end;

function TdataFactory.OpenBatch: Boolean;
begin

end;

procedure TdataFactory.RollbackTrans;
begin

end;

function TdataFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin

end;

function TdataFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin

end;

function TdataFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin

end;

initialization
  dataFactory := TdataFactory.create(nil);
finalization
  dataFactory.Free;
end.
