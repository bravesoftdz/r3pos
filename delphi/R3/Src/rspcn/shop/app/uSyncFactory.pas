unit uSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs;

type
  PSynTableInfo=^TSynTableInfo;

  TSynTableInfo=record
    tbname:string;//表名
    tbtitle:string;//说明
    keyFields:string;//关健字段
    synFlag:integer;
    KeyFlag:integer; //0是按表结构关健字 1是按业务关健字
  end;

  TSyncFactory=class
  private
    _Start:Int64;
    FList:TList;
    FStoped: boolean;
    FSyncTimeStamp: int64;
    FParams: TftParamList;
    procedure SetParams(const Value: TftParamList);
    procedure SetSyncTimeStamp(const Value: int64);
    procedure SetStoped(const Value: boolean);
  protected
    rDate,lDate,SubmitRecordNum:integer;
    procedure SetTicket;
    function GetTicket:Int64;
  public
    Locked:integer;
    constructor Create;
    destructor  Destroy;override;
    procedure InitList;
    procedure ReadTimeStamp;
    function  GetSynTimeStamp(tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    function  GetFactoryName(node:PSynTableInfo):string;
    function  GetTableFields(tbName:string):string;
    procedure SyncSingleTable(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0;timeStampNoChg:integer=1);
    property  Params:TftParamList read FParams write SetParams;
    property  SyncTimeStamp:int64 read FSyncTimeStamp write SetSyncTimeStamp;
    property  Stoped:boolean read FStoped write SetStoped;
  end; 

var SyncFactory:TSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles;

constructor TSyncFactory.Create;
begin
  Locked := 0;
  SubmitRecordNum := 500;
  FParams := TftParamList.Create(nil);
  FList := TList.Create;
end;

destructor TSyncFactory.Destroy;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Free;
  FParams.Free;
  inherited;
end;

function TSyncFactory.GetFactoryName(node: PSynTableInfo): string;
begin
  result := 'TSyncSingleTableV60';
end;

function TSyncFactory.GetTicket:int64;
begin
  result := GetTickCount - _Start;
end;

procedure TSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TSyncFactory.SetSyncTimeStamp(const Value: int64);
begin
  FSyncTimeStamp := Value;
end;

procedure TSyncFactory.SetTicket;
begin
  _Start := GetTickCount;
end;

procedure TSyncFactory.InitList;
var
  n:PSynTableInfo;
  i:integer;
begin
  lDate := 99999999;
  rDate := 99999999;
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Clear;

  new(n);
  n^.tbname := 'SYS_DEFINE';
  n^.keyFields := 'TENANT_ID;DEFINE';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '参数定义表';
  FList.Add(n);
end;

procedure TSyncFactory.ReadTimeStamp;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    if not (dataFactory.iDbType = 5) then
      begin
        try
          dataFactory.MoveToSqlite;
          dataFactory.ExecProc('TGetSyncTimeStamp',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;
    dataFactory.ExecProc('TGetSyncTimeStamp',Params);
  finally
    Params.free;
  end;
end;

function TSyncFactory.GetSynTimeStamp(tbName: string;SHOP_ID:string='#'): int64;
var
  rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    dataFactory.MoveToSqlite;
    try
      dataFactory.Open(rs);
    finally
      dataFactory.MoveToDefault;
    end;
    if rs.IsEmpty then result := 0 else result := rs.Fields[0].Value;
  finally
    rs.Free;
  end;
end;

procedure TSyncFactory.SetSynTimeStamp(tbName: string; TimeStamp: int64;SHOP_ID:string='#');
var
  r:integer;
  rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  try
    dataFactory.MoveToSqlite;
    r := dataFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+token.tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
    if r=0 then
      dataFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+token.tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
  finally
    dataFactory.MoveToDefault;
  end;

  //更新服务端时间戳
  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    r := dataFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+token.tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+''' and TIME_STAMP<'+inttostr(TimeStamp));
    if r=0 then
      begin
        rs.SQL.Text := 'select 1 from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
        rs.Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
        rs.Params.ParamByName('SHOP_ID').AsString := '#';
        rs.Params.ParamByName('TABLE_NAME').AsString := tbName;
        dataFactory.Open(rs);
        if rs.IsEmpty then
          dataFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+token.tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
      end;
  finally
    rs.Free;
    dataFactory.MoveToDefault;
  end;
end;

function TSyncFactory.GetTableFields(tbName:string):string;
var
  ls:TZQuery;
  i:integer;
  selectFields:string;
begin
  ls := TZQuery.Create(nil);
  try
    ls.SQL.Text := 'select * from '+tbName+' limit 1';
    dllGlobal.OpenSqlite(ls);
    for i:=0 to ls.FieldList.Count - 1 do
      begin
        if selectFields<>'' then selectFields := selectFields + ',';
        selectFields := selectFields + ls.FieldList.Fields[i].FieldName;
      end;
    result := selectFields;
  finally
    ls.Free;
  end;
end;

procedure TSyncFactory.SyncSingleTable(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0;timeStampNoChg:integer=1);
var
  cs,rs:TZQuery;
  i:integer;
  tmpObj:TRecord_;
  maxTimeStamp:int64;
  F:TIniFile;
  download:boolean;
  upload:boolean;
begin
  F := TIniFile.Create(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'r3.cfg');
  try
    if F.ReadString('db','SFVersion','.LCL')='.LCL' then
       upload := true
    else
       download := true;
  finally
    F.Free;
  end;

  SyncTimeStamp := GetSynTimeStamp(tbName);
  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('TABLE_FIELDS').AsString := GetTableFields(tbName);

  LogFile.AddLogFile(0,'开始<'+tbName+'>上次时间:'+Params.ParamByName('TIME_STAMP').asString+'  本次时间:'+inttostr(SyncTimeStamp));

  if download then
  begin
    //下载
    cs := TZQuery.Create(nil);
    rs := TZQuery.Create(nil);
    tmpObj := TRecord_.Create;
    try
      Params.ParamByName('SYN_COMM').AsBoolean := false;
      cs.Close;
      rs.Close;
      SetTicket;
      try
        dataFactory.MoveToRemote;
        dataFactory.Open(rs,ZClassName,Params);
      finally
        dataFactory.MoveToDefault;
      end;
      LogFile.AddLogFile(0,'下载<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(rs.RecordCount));
      SetTicket;

      cs.FieldDefs := rs.FieldDefs;
      cs.CreateDataSet;
      //分包同步
      i := 1;
      rs.First;
      while (not rs.Eof) and (not Stoped) do
        begin
          cs.Append;
          tmpObj.ReadFromDataSet(rs);
          tmpObj.WriteToDataSet(cs);
          maxTimeStamp := rs.FieldByName('TIME_STAMP').AsInteger;
          inc(i);
          rs.Next;
          if ((i > SubmitRecordNum) and (rs.FieldByName('TIME_STAMP').AsInteger > maxTimeStamp)) or (rs.Eof) then
            begin
              //提交
              if not cs.IsEmpty then
                try
                  dataFactory.MoveToSqlite;
                  dataFactory.UpdateBatch(cs,ZClassName,Params);
                finally
                  dataFactory.MoveToDefault;
                end;
              SetSynTimeStamp(tbName,maxTimeStamp);
              ReadTimeStamp;
              cs.Close;
              cs.FieldDefs := rs.FieldDefs;
              cs.CreateDataSet;
              i := 1;
            end;
        end;
      LogFile.AddLogFile(0,'下载<'+tbName+'>保存时长:'+inttostr(GetTicket));
    finally
      rs.Free;
      cs.Free;
      tmpObj.Free;
    end;
  end;

  if upload then
  begin
    //上传
    cs := TZQuery.Create(nil);
    rs := TZQuery.Create(nil);
    tmpObj := TRecord_.Create;
    try
      Params.ParamByName('SYN_COMM').AsBoolean := false;
      cs.Close;
      rs.Close;
      SetTicket;
      try
        dataFactory.MoveToSqlite;
        dataFactory.Open(rs,ZClassName,Params);
      finally
        dataFactory.MoveToDefault;
      end;
      LogFile.AddLogFile(0,'上传<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(rs.RecordCount));
      SetTicket;

      cs.FieldDefs := rs.FieldDefs;
      cs.CreateDataSet;
      //分包同步
      i := 1;
      rs.First;
      while (not rs.Eof) and (not Stoped) do
        begin
          cs.Append;
          tmpObj.ReadFromDataSet(rs);
          tmpObj.WriteToDataSet(cs);
          maxTimeStamp := rs.FieldByName('TIME_STAMP').AsInteger;
          inc(i);
          rs.Next;
          if ((i > SubmitRecordNum) and (rs.FieldByName('TIME_STAMP').AsInteger > maxTimeStamp)) or (rs.Eof) then
            begin
              //提交
              if not cs.IsEmpty then
                try
                  dataFactory.MoveToRemote;
                  dataFactory.UpdateBatch(cs,ZClassName,Params);
                finally
                  dataFactory.MoveToDefault;
                end;
              SetSynTimeStamp(tbName,maxTimeStamp);
              ReadTimeStamp;
              cs.Close;
              cs.FieldDefs := rs.FieldDefs;
              cs.CreateDataSet;
              i := 1;
            end;
        end;
      LogFile.AddLogFile(0,'上传<'+tbName+'>保存时长:'+inttostr(GetTicket));
    finally
      rs.Free;
      cs.Free;
      tmpObj.Free;
    end;
  end;
end;

procedure TSyncFactory.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  SyncFactory.Free;
end.
