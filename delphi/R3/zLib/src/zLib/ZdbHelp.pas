//***********************************************************//
//        ���:��ɭ��     ���룺��ɭ��
//        �汾:5.0        �޸�����:2011-01-10
//        R3��Ŀ��
//***********************************************************//
unit ZdbHelp;

interface
uses Classes,SysUtils,Windows,DB,Variants,ZIntf,ZAbstractRODataset, ZDbcCache,
     ZAbstractDataset, ZDataset, ZConnection, ZDbcIntfs, ZBase, ZSqlUpdate;
type
  TdbHelp=class(TInterfacedObject, IdbHelp)
  private
    ZConn:TZConnection;
  protected
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

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;stdcall;
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TZdbUpdate = class(TZUpdateSQL)
  private
    FdbHelp: IdbHelp;
    FFactory: TZFactory;
  protected
    procedure PSBeforeDeleteSQL(Sender: TObject);
    procedure PSBeforeInsertSQL(Sender: TObject);
    procedure PSBeforeModifySQL(Sender: TObject);
    procedure PSAfterDeleteSQL(Sender: TObject);
    procedure PSAfterInsertSQL(Sender: TObject);
    procedure PSAfterModifySQL(Sender: TObject);
    procedure SetdbHelp(const Value: IdbHelp);
    procedure SetFactory(const Value: TZFactory);

    procedure ReadData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    property dbHelp:IdbHelp read FdbHelp write SetdbHelp;
    property Factory:TZFactory read FFactory write SetFactory;
  end;

  TdbResolver=class
  private
    dbHelp:IdbHelp;
    FList:TList;
  protected
    function CreateFactory(AClassName:string):TZFactory;
  public
    constructor Create;
    destructor Destroy;override;

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
{ TdbHelp }

procedure TdbHelp.BeginTrans(TimeOut: integer);
begin
  ZConn.TransactIsolationLevel := tiReadCommitted;
  ZConn.StartTransaction;
end;

procedure TdbHelp.CommitTrans;
begin
  ZConn.Commit;
  ZConn.TransactIsolationLevel := tiNone;
end;

function TdbHelp.Connect: boolean;
begin
  ZConn.Connect;
end;

function TdbHelp.Connected: boolean;
begin
  result := ZConn.Connected;
end;

constructor TdbHelp.Create;
begin
  ZConn := TZConnection.Create(nil);
end;

destructor TdbHelp.Destroy;
begin
  FreeAndNil(ZConn);
  inherited;
end;

function TdbHelp.DisConnect: boolean;
begin
  ZConn.Disconnect;
end;

function TdbHelp.ExecSQL(const SQL: WideString;
  ObjectFactory: TObject): Integer;
var
  ZQuery:TZQuery;
  i:integer;
begin
  result := -1;
  if ObjectFactory=nil then
     begin
       if not ZConn.ExecuteDirect(SQL,result) then result := -1;
     end
  else
     begin
       ZQuery := TZQuery.Create(nil);
       try
         ZQuery.Connection := ZConn;           
         ZQuery.SQL.Text := SQL;
         if ObjectFactory is TParams then
            ZQuery.Params.AssignValues(TParams(ObjectFactory))
         else
         begin
         for i:=0 to ZQuery.Params.Count -1 do
            begin
              if copy(ZQuery.Params[i].Name,1,4)='OLD_' then
                 ZQuery.Params[i].Value := TZFactory(ObjectFactory).FieldbyName(copy(ZQuery.Params[i].Name,5,50)).OldValue
              else
                 ZQuery.Params[i].Value := TZFactory(ObjectFactory).FieldbyName(ZQuery.Params[i].Name).NewValue;
            end;
         end;
         ZQuery.ExecSQL;
       finally
         ZQuery.Free;
       end;
     end;
end;

function TdbHelp.GetConnectionString: WideString;
begin
  result := 'Provider='+ZConn.Protocol+';HostName='+ZConn.HostName+';DatabaseName='+ZConn.Database+';UID='+ZConn.User+';Password='+ZConn.Password;
end;

function TdbHelp.iDbType: Integer;
begin
  if copy(ZConn.Protocol,1,6) = 'sqlite' then
     result := 5;
end;

function TdbHelp.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  ZConn.Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.DelimitedText := ConnStr;
    ZConn.HostName := vList.Values['HostName'];
    ZConn.Database := vList.Values['DatabaseName'];
    if vList.Values['UID']<>'' then ZConn.User := vList.Values['UID'];
    if vList.Values['Password']<>'' then ZConn.Password := vList.Values['Password'];
    ZConn.Protocol := vList.Values['Provider'];
  finally
    vList.Free;
  end;
end;

function TdbHelp.InTransaction: boolean;
begin
  result := zConn.InTransaction;
end;

function TdbHelp.Open(DataSet: TDataSet): boolean;
begin
  result := false;
  DataSet.Close;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).CachedUpdates := true;
       TZQuery(DataSet).Connection := ZConn;
     end;
  if DataSet.ClassNameIs('TZTable') then
     begin
       TZTable(DataSet).CachedUpdates := true;
       TZTable(DataSet).Connection := ZConn;
     end;
  try
    DataSet.Open;
    result := true;
  finally
    if DataSet.ClassNameIs('TZQuery') then
       begin
         TZQuery(DataSet).Connection := nil;
       end;
    if DataSet.ClassNameIs('TZTable') then
       begin
         TZTable(DataSet).Connection := nil;
       end;
  end;

end;

procedure TdbHelp.RollbackTrans;
begin
  ZConn.Rollback;
  ZConn.TransactIsolationLevel := tiNone;
end;

function TdbHelp.UpdateBatch(DataSet: TDataSet): boolean;
begin
  result := false;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).Connection := ZConn;
     end;
  if DataSet.ClassNameIs('TZTable') then
     begin
       TZTable(DataSet).Connection := ZConn;
     end;
  try
    with TZAbstractDataset(DataSet) do
      begin
        ApplyUpdates;
        result := true;
      end;
  finally
    if DataSet.ClassNameIs('TZQuery') then
       begin
         TZQuery(DataSet).Connection := nil;
       end;
    if DataSet.ClassNameIs('TZTable') then
       begin
         TZTable(DataSet).Connection := nil;
       end;
  end;
end;

{ TdbResolver }

procedure TdbResolver.BeginTrans(TimeOut: integer);
begin
  dbHelp.BeginTrans(TimeOut);
end;

procedure TdbResolver.CommitTrans;
begin
  dbHelp.CommitTrans;
end;

function TdbResolver.Connect: boolean;
begin
  result := dbHelp.Connect;
end;

function TdbResolver.Connected: boolean;
begin
  result := dbHelp.Connected;
end;

constructor TdbResolver.Create;
begin
  dbHelp := TdbHelp.Create;
  FList := TList.Create;
end;

function TdbResolver.CreateFactory(AClassName: string): TZFactory;
var
  FactoryClass:TPersistentClass;
begin
  FactoryClass := GetClass(AClassName);
  if FactoryClass = nil then Raise Exception.Create(AClassName+'������û���ҵ�.');
  result := TZFactoryClass(FactoryClass).Create;
  result.iDbType := dbHelp.iDbType;
  result.ZClassName:=AClassName;  //����AClassName����
end;

destructor TdbResolver.Destroy;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  dbHelp := nil;
  inherited;
end;

function TdbResolver.Open(DataSet: TDataSet; AClassName: String;
  Params:TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := CreateFactory(AClassName);
  try
    Factory.DataSet := DataSet;
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.InitClass;
    Factory.ReadFromDataSet(DataSet);
    Factory.BeforeOpenRecord(dbHelp);
    if DataSet.ClassNameIs('TZQuery') then
       begin
         TZQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
         if Assigned(Params) then TZQuery(DataSet).Params.AssignValues(Params);
       end
    else
    if DataSet.ClassNameIs('TZReadOnlyQuery') then
       begin
         TZReadOnlyQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
         if Assigned(Params) then TZReadOnlyQuery(DataSet).Params.AssignValues(Params);
       end
    else
       Raise Exception.Create('��֧�ֵ����ݼ�.');
    result := Open(DataSet);
  finally
    Factory.Free;
  end;
end;

function TdbResolver.DisConnect: boolean;
begin
  result := dbHelp.DisConnect;
end;

function TdbResolver.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  if Assigned(ObjectFactory) then
     result := dbHelp.ExecSQL(SQL,TObject(TZFactory))
  else
     result := dbHelp.ExecSQL(SQL);
end;

function TdbResolver.GetConnectionString: WideString;
begin
  result := dbHelp.GetConnectionString;
end;

function TdbResolver.iDbType: Integer;
begin
  result := dbHelp.iDbType;
end;

function TdbResolver.Initialize(const ConnStr: WideString): boolean;
begin
  result := dbHelp.Initialize(ConnStr);
end;

function TdbResolver.InTransaction: boolean;
begin
  result := dbHelp.InTransaction;
end;

function TdbResolver.Open(DataSet: TDataSet): Boolean;
begin
  result := dbHelp.Open(DataSet);
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
  SaveTrans:Boolean;
  UpdateSQL:TZdbUpdate;
begin
  Factory := CreateFactory(AClassName);
  UpdateSQL := TZdbUpdate.Create(nil);
  try
    UpdateSQL.dbHelp := dbHelp;
    UpdateSQL.Factory := Factory;
    Factory.DataSet := DataSet;
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.InitClass;
    SaveTrans := dbHelp.InTransaction;
    if not SaveTrans then dbHelp.BeginTrans;
    try
      Factory.ReadFromDataSet(DataSet);
      Factory.BeforeUpdateRecord(dbHelp);
      UpdateSQL.DeleteSQL.Text := Factory.DeleteSQL.Text;
      UpdateSQL.ModifySQL.Text := Factory.UpdateSQL.Text;
      UpdateSQL.InsertSQL.Text := Factory.InsertSQL.Text;
      if DataSet.ClassNameIs('TZQuery') then
         begin
           TZQuery(DataSet).UpdateObject := UpdateSQL;
           if Params<>nil then TZQuery(DataSet).Params.AssignValues(Params);
         end
      else
         Raise Exception.Create('��֧�ֵ����ݼ�.');

      result := UpdateBatch(DataSet);
      Factory.BeforeCommitRecord(dbHelp); 
      if not SaveTrans then dbHelp.CommitTrans;
    except
      if not SaveTrans then dbHelp.RollbackTrans;
      Raise;
    end;
  finally
    TZQuery(DataSet).UpdateObject := nil;
    UpdateSQL.Free;
    Factory.Free;
  end;
end;

procedure TdbResolver.RollbackTrans;
begin
  dbHelp.RollbackTrans;
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  result := dbHelp.UpdateBatch(DataSet);
end;

function TdbResolver.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := CreateFactory(AClassName);
  FList.Add(Factory); 
  Factory.DataSet := DataSet;
  if Assigned(Params) then  Factory.Params.Assign(Params);
  Factory.InitClass;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       if not TZQuery(DataSet).Active then   //Ҫ�жϣ�CommitBatchǰ���д��ʱ��������ݼ����رյ�
          TZQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
       if Assigned(Params) then TZQuery(DataSet).Params.AssignValues(Params);
     end
  else
  if DataSet.ClassNameIs('TZReadOnlyQuery') then
     begin
       TZReadOnlyQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
       if Assigned(Params) then TZReadOnlyQuery(DataSet).Params.AssignValues(Params);
     end
  else
     Raise Exception.Create('��֧�ֵ����ݼ�.');
end;

function TdbResolver.BeginBatch: Boolean;
begin
  if FList.Count > 0 then Raise Exception.Create('������֯���ݰ����޷���ʼ�µ����ݰ���'); 
end;

function TdbResolver.CancelBatch: Boolean;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Clear;
end;

function TdbResolver.CommitBatch: Boolean;
var
  i:integer;
  SQLUpdate:TZdbUpdate;
  SaveTrans:boolean;
begin
  SaveTrans := dbHelp.InTransaction;
  if not SaveTrans then dbHelp.BeginTrans;
  SQLUpdate := TZdbUpdate.Create(nil);
  try
    //���¼�¼ǰ
    for i:=0 to FList.Count -1 do
      begin
        SQLUpdate.dbHelp := dbHelp;
        SQLUpdate.Factory := TZFactory(FList[i]);
        with TZFactory(FList[i]) do
          begin
            if ZClassName<>'' then
               begin
                 ReadFromDataSet(DataSet);
                 BeforeUpdateRecord(dbHelp);
               end;
          end;
      end;
    //���¼�¼��
    for i:=0 to FList.Count -1 do
      begin
        SQLUpdate.dbHelp := dbHelp;
        SQLUpdate.Factory := TZFactory(FList[i]);
        with TZFactory(FList[i]) do
          begin
            if ZClassName='' then
               begin
                 dbHelp.UpdateBatch(DataSet); 
               end
            else
               begin
                 TZQuery(DataSet).UpdateObject := SQLUpdate;
                 SQLUpdate.DeleteSQL.Text := DeleteSQL.Text;
                 SQLUpdate.ModifySQL.Text := UpdateSQL.Text;
                 SQLUpdate.InsertSQL.Text := InsertSQL.Text;
                 dbHelp.UpdateBatch(DataSet);
               end;
          end;
      end;
    //���¼�¼��
    for i:=0 to FList.Count -1 do
      begin
        SQLUpdate.dbHelp := dbHelp;
        SQLUpdate.Factory := TZFactory(FList[i]);
        with TZFactory(FList[i]) do
          begin
            if ZClassName<>'' then
               begin
                 ReadFromDataSet(DataSet);
                 BeforeCommitRecord(dbHelp);
               end;
          end;
      end;
    for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
    FList.Clear;
    SQLUpdate.Free;
    if not SaveTrans then dbHelp.CommitTrans;
    result := true;
  except
    if not SaveTrans then dbHelp.RollbackTrans;
    SQLUpdate.Free;
    result := false;
    Raise;
  end;
end;

function TdbResolver.OpenBatch: Boolean;
var
  i:integer;
begin
  result := false;
  try
    for i:=0 to FList.Count -1 do
      begin
        with TZFactory(FList[i]) do
          begin
            ReadFromDataSet(DataSet);
            BeforeOpenRecord(dbHelp);
            result := dbHelp.Open(DataSet);
          end;
      end;
    for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
    FList.Clear;
    result := true;
  except
    result := false;
    Raise;
  end;
end;

function TdbResolver.ExecProc(AClassName: String;
  Params: TftParamList): String;
function CreateFactory(AClassName: string): TZProcFactory;
var
  FactoryClass:TPersistentClass;
begin
  FactoryClass := GetClass(AClassName);
  if FactoryClass = nil then Raise Exception.Create(AClassName+'������û���ҵ�.');
  result := TZProcFactoryClass(FactoryClass).Create(dbHelp,Params);
end;
var
  Factory:TZProcFactory;
  V:oleVariant;
begin
  Factory := CreateFactory(AClassName);
  try
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.Execute(dbHelp,Params,V);
    result := V;
  finally
    Factory.Free;
  end;
end;

function TdbResolver.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

{ TZdbUpdate }

constructor TZdbUpdate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AfterDeleteSQL := PSAfterDeleteSQL;
  AfterInsertSQL := PSAfterInsertSQL;
  AfterModifySQL := PSAfterModifySQL;
  BeforeDeleteSQL := PSBeforeDeleteSQL;
  BeforeInsertSQL := PSBeforeInsertSQL;
  BeforeModifySQL := PSBeforeModifySQL;
end;

destructor TZdbUpdate.Destroy;
begin

  inherited;
end;

procedure TZdbUpdate.PSAfterDeleteSQL;
begin

end;

procedure TZdbUpdate.PSAfterInsertSQL;
begin

end;

procedure TZdbUpdate.PSAfterModifySQL;
begin

end;

procedure TZdbUpdate.PSBeforeDeleteSQL;
begin
  ReadData;
  Factory.BeforeDeleteRecord(dbHelp);

end;

procedure TZdbUpdate.PSBeforeInsertSQL;
begin
  ReadData;
  Factory.BeforeInsertRecord(dbHelp);

end;

procedure TZdbUpdate.PSBeforeModifySQL;
begin
  ReadData;
  Factory.BeforeModifyRecord(dbHelp);

end;

procedure TZdbUpdate.ReadData;
var
  i:integer;
  WasNull:boolean;
begin
  for i:=0 to Factory.Count -1 do
     begin
      case FNewRowAccessor.GetColumnType(i+1)  of
        stBoolean:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetBoolean(i+1, WasNull);
        stByte:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetByte(i+1, WasNull);
        stShort:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetShort(i+1, WasNull);
        stInteger:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetInt(i+1, WasNull);
        stLong:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetLong(i+1, WasNull);
        stFloat:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetFloat(i+1, WasNull);
        stDouble:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetDouble(i+1, WasNull);
        stBigDecimal:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetBigDecimal(i+1, WasNull);
        stString, stUnicodeString:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetString(i+1, WasNull);
        stBytes:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetBytes(i+1, WasNull);
        stDate:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetDate(i+1, WasNull);
        stTime:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetTime(i+1, WasNull);
        stTimestamp:
          Factory.Fields[i].NewValue := FNewRowAccessor.GetTimestamp(i+1, WasNull);
      end;
      if WasNull then Factory.Fields[i].NewValue := null;
      if FNewRowAccessor.RowBuffer.UpdateType = utModified then
         begin
            case FNewRowAccessor.GetColumnType(i+1)  of
              stBoolean:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetBoolean(i+1, WasNull);
              stByte:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetByte(i+1, WasNull);
              stShort:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetShort(i+1, WasNull);
              stInteger:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetInt(i+1, WasNull);
              stLong:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetLong(i+1, WasNull);
              stFloat:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetFloat(i+1, WasNull);
              stDouble:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetDouble(i+1, WasNull);
              stBigDecimal:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetBigDecimal(i+1, WasNull);
              stString, stUnicodeString:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetString(i+1, WasNull);
              stBytes:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetBytes(i+1, WasNull);
              stDate:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetDate(i+1, WasNull);
              stTime:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetTime(i+1, WasNull);
              stTimestamp:
                Factory.Fields[i].OldValue := FOldRowAccessor.GetTimestamp(i+1, WasNull);
            end;
         end
      else
         Factory.Fields[i].OldValue := Factory.Fields[i].NewValue;
     end;
end;

procedure TZdbUpdate.SetdbHelp(const Value: IdbHelp);
begin
  FdbHelp := Value;
end;

procedure TZdbUpdate.SetFactory(const Value: TZFactory);
begin
  FFactory := Value;
end;

end.
