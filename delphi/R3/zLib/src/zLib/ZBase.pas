//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZBase;

interface
uses SysUtils,Classes,Windows,DB,Variants,FMTBcd,ZIntf,zConst,ZDataset,ZSqlUpdate,ZSqlStrings;

type
TftParam=class(TParam);
TftParamList=class(TParams)
  public
    function ParamByName(const Value: string): TParam;
    class function Encode(Params:TParams):string;
    class procedure Decode(Params:TParams;str:string);
  end;

TField_=Class(TInterfacedObject)
  private
    FFieldName: String;
    FDataType: TFieldType;
    FNewValue: Variant;
    FOldValue: Variant;
    FProviderFlags: TProviderFlags;
    FTitleCaption: String;
    FVisible: Boolean;
    FPickList: String;
    FWidth: Integer;
    FDataReadOnly: Boolean;
    FTableName: string;
    FIndex: integer;
    procedure SetDataType(const Value: TFieldType);
    procedure SetFieldName(const Value: String);
    procedure SetNewValue(const Value: Variant);
    procedure SetOldValue(const Value: Variant);
    procedure SetProviderFlags(const Value: TProviderFlags);
    function  GetAsFloat: Real;
    function  GetAsString: String;
    function  GetAsValue: Variant;
    procedure SetAsFloat(const Value: Real);
    procedure SetAsString(const Value: String);
    procedure SetAsValue(const Value: Variant);
    function  GetAsInteger: Longint;
    procedure SetAsInteger(const Value: Longint);
    function  GetAsInt64: Int64;
    procedure SetAsInt64(const Value: Int64);
    procedure SetTitleCaption(const Value: String);
    procedure SetVisible(const Value: Boolean);
    procedure SetAsBoolean(const Value: Boolean);
    function  GetAsBoolean: Boolean;
    procedure SetPickList(const Value: String);
    procedure SetWidth(const Value: Integer);
    procedure SetDataReadOnly(const Value: Boolean);
    procedure SetTableName(const Value: string);
    procedure SetAsOldBoolean(const Value: Boolean);
    procedure SetAsOldFloat(const Value: Real);
    procedure SetAsOldInteger(const Value: Longint);
    procedure SetAsOldInt64(const Value: Int64);
    procedure SetAsOldString(const Value: String);
    procedure SetAsOldValue(const Value: Variant);
    function GetAsOldBoolean: Boolean;
    function GetAsOldFloat: Real;
    function GetAsOldInteger: Longint;
    function GetAsOldInt64: Int64;
    function GetAsOldString: String;
    function GetAsOldValue: Variant;
    function GetAsDatetime: TDatetime;
    procedure SetAsDatetime(const Value: TDatetime);
    function GetAsOldDatetime: TDatetime;
    procedure SetAsOldDatetime(const Value: TDatetime);
    procedure SetIndex(const Value: integer);
  public
    constructor Create(AOwner:TObject);
    destructor  Destroy;override;

    //从数据集字段中复制对象的属性
    procedure Assign(Field:TField);
    //从数据集字段中复制对象的字段值
    procedure AssignValue(Field:TField);

    //数据字段名
    Property FieldName:String read FFieldName write SetFieldName;
    //数据字段显示名
    Property TitleCaption:String read FTitleCaption write SetTitleCaption;
    //字段数据类型
    Property DataType:TFieldType read FDataType write SetDataType;
    Property Width:Integer read FWidth write SetWidth;
    //DisplayType 属性是 ftDPPickList时，下拉选择的数据来源，SQL 或 代码=名称+','的字符串格式
    Property PickList:String read FPickList write SetPickList;
    //当前字段，用户可显以不可视
    Property Visible:Boolean read FVisible write SetVisible;
    //当前数据字段值
    Property NewValue:Variant read FNewValue write SetNewValue;
    //数据修改前的值
    Property OldValue:Variant read FOldValue write SetOldValue;
    //字段是更新标志
    Property ProviderFlags:TProviderFlags read FProviderFlags write SetProviderFlags;
    //字段是当前值转换成字符串 ,空字符串会自动转换成null值
    Property AsString:String Read GetAsString write SetAsString;
    //字段是当前值转换成浮点型
    Property AsFloat:Real Read GetAsFloat write SetAsFloat;
    //字段是当前值转换成整形
    Property AsInteger:Longint Read GetAsInteger write SetAsInteger;
    //字段是当前值转换成整形
    Property AsInt64:Int64 Read GetAsInt64 write SetAsInt64;
    //字段是当前值转换成Variant
    Property AsValue:Variant Read GetAsValue write SetAsValue;
    //字段转化为日期型
    Property AsDatetime:TDatetime read GetAsDatetime write SetAsDatetime;
    Property AsBoolean:Boolean read GetAsBoolean write SetAsBoolean;
    property DataReadOnly:Boolean read FDataReadOnly write SetDataReadOnly;
    //表名,用于定义多表查询条件的字段前缀
    property TableName:string read FTableName write SetTableName;

    //字段是原值转换成字符串 ,空字符串会自动转换成null值
    Property AsOldString:String  read GetAsOldString write SetAsOldString;
    //字段是原值转换成浮点型
    Property AsOldFloat:Real read GetAsOldFloat write SetAsOldFloat;
    //字段是原值转换成整形
    Property AsOldInteger:Integer read GetAsOldInteger write SetAsOldInteger;
    //字段是原值转换成整形
    Property AsOldInt64:Int64 read GetAsOldInt64 write SetAsOldInt64;
    //字段是原值转换成Variant
    Property AsOldValue:Variant read GetAsOldValue write SetAsOldValue;
    Property AsOldBoolean:Boolean  read GetAsOldBoolean write SetAsOldBoolean;
    //字段转化为日期型
    Property AsOldDatetime:TDatetime read GetAsOldDatetime write SetAsOldDatetime;
    property Index:integer read FIndex write SetIndex;
  end;

TRecord_=class(TComponent)
  private
    FList:TList;
    function GetCount: Integer;
    function GetFields(Index: Integer): TField_;
    function IsValid: Boolean;
  protected
    procedure CreateNew(AOwner: TComponent);virtual;
  public
    constructor Create;overLoad;virtual;
    constructor Create(AOwner:TComponent); overLoad;override;
    constructor Create(ADataSet:TDataSet);overLoad;virtual;
    destructor  Destroy;override;

    function  FindField(FieldName:String):TField_;virtual;
    procedure Clear;
    procedure AddField(Field:TField_);overload;
    procedure AddField(AFieldName:string;AFieldValue:Variant;AFieldType:TFieldType=ftString);overload;
    procedure CopyTo(Records:TRecord_);
    procedure CopyToParams(Params:TParams;ForOldValue:boolean=false);
    //从数据集中读入各字段，但不包括字段值
    procedure ReadField(ADataSet:TDataSet);
    //从数据集中读入各字段及值
    procedure ReadFromDataSet(ADataSet:TDataSet;IsFieldExists:Boolean=True);
    //把对象中的各字段值写入后数据集中
    procedure WriteToDataSet(ADataSet:TDataSet;IsExists:Boolean=true);
    //根据字段名取字段对象
    function  FieldByName(FieldName:String):TField_;

    property  Fields[Index:Integer]:TField_ Read GetFields;
    property  Count:Integer Read GetCount;
  end;

type
  TRecordList=class
  private
    FList:TList;
    function GetCount: integer;
    function GetRecords(Index: Integer): TRecord_;
  public
    constructor Create;
    destructor  Destroy;override;

    procedure Clear;
    function  GetList:TList;
    function  FindRecord(FieldName:string;FieldValue:Variant):TRecord_;
    procedure AddRecord(RS:TRecord_);
    procedure Delete(Index:Integer);
    property  Count:integer read GetCount;
    property  Records[Index:Integer]:TRecord_ read GetRecords;

    procedure MoveTo(CurIndex, NewIndex: Integer);

  end;

TSQLCache=Class(TZSQLStrings);
TZFactory=Class;
//原TSingleObj
TZFactory=Class(TRecord_,IZFactory)
  private
    FDeleteSQL:TSQLCache;
    FUpdateSQL:TSQLCache;
    FInsertSQL:TSQLCache;
    FSelectSQL: TSQLCache;
    FParams: TftParamList;
    FDataSet: TDataSet;
    FIsSQLUpdate: Boolean;
    FiDbType: Integer;
    FDLLHandle: THandle;
    FKeyFields: String;
    FZClassName: string;
    FZParamWStr: widestring;
    procedure SetIsSQLUpdate(const Value: Boolean);
    procedure SetDLLHandle(const Value: THandle);
    procedure SetKeyFields(const Value: String);
    procedure SetZClassName(const Value: string);
    procedure SetZParamWStr(const Value: widestring);
  protected
    //初始化对象
    procedure PSInitialize;stdcall;
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeOpenRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集新增检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以新增当前记录
    function PSBeforeInsertRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集修改检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以修改当前记录
    function PSBeforeModifyRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集删除检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以删除当前记录
    function PSBeforeDeleteRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeUpdateRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //所有记录处理完毕后,事务提交以前执行。返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeCommitRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    
    procedure CreateNew(AOwner: TComponent);override;

  public
    constructor Create(ADataSet: TDataSet);override;
    destructor  Destroy;override;

    procedure InitClass;virtual;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;virtual;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;virtual;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;virtual;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;virtual;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;virtual;
    //所有记录处理完毕后,事务提交以前执行。
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;virtual;

    function FindParam(ParamName:string):TParam;virtual;

    property DataSet:TDataSet read FDataSet write FDataSet;
    //是否用自写的SQL语句更新
    property IsSQLUpdate:Boolean read FIsSQLUpdate write SetIsSQLUpdate;
    //数据库驱动类型 0:SQL Server ;1 Oracle ; 2 Sybase 3: access  4: db2
    property iDbType:Integer read FiDbType write FiDbType;
    //关键字段，连接更新时启用。
    property KeyFields:String read FKeyFields write SetKeyFields;
    property DLLHandle:THandle read FDLLHandle write SetDLLHandle;
    property Params:TftParamList read FParams;
    //更新SQL ，SQL的参数用字段名前带':',,如果是取原值用 OLD_+字段名
    property DeleteSQL:TSQLCache read FDeleteSQL;
    property UpdateSQL:TSQLCache read FUpdateSQL;
    property InsertSQL:TSQLCache read FInsertSQL;
    property SelectSQL:TSQLCache read FSelectSQL;

    property ZClassName:string read FZClassName write SetZClassName;
    property ZParamWStr:widestring read FZParamWStr write SetZParamWStr;
  end;

TZFactoryClass= class of TZFactory;

TZProcFactory=class(TComponent,IzProcFactory)
  private
    FParams: TftParamList;
    FOutData: Olevariant;
    procedure SetParams(const Value: TftParamList);
    procedure SetOutMsg(const Value: String);
    function GetOutMsg: String;
  protected
    function PSExecute(AGlobal:IdbHelp;HasResult:Boolean):Boolean;stdcall;
    function PSGetOutMessage:WideString;stdcall;
    function PSGetOutData:OleVariant;stdcall;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;OverLoad;virtual;
    function Execute(AGlobal:IdbHelp;Params:TftParamList;Out aData:OleVariant):Boolean;OverLoad;virtual;
    constructor Create(AGlobal:IdbHelp;Params:TftParamList);virtual;
    destructor Destroy;override;
    property Params:TftParamList read FParams write SetParams;
    property Msg:String read GetOutMsg write SetOutMsg;
  end;

TZProcFactoryClass= class of TZProcFactory;


procedure StrToStrings(S: string; Sep: string; List: TStrings);
function gsmBytes2String(pSrc:string):string;
function gsmString2Bytes(pSrc:string):string;

implementation
uses encddecd,IniFiles,Registry;

procedure StrToStrings(S: string; Sep: string; List: TStrings);
var
  I, L: Integer;
  Left: string;
begin
  List.Clear;
  L := Length(Sep);
  I := Pos(Sep, S);
  while (I > 0) do
  begin
    Left := Copy(S,1,I - 1);
    List.Add(Left);
    Delete(S, 1, I + L - 1);
    I := Pos(Sep, S);
  end;
  if S <> '' then
    List.Add(S);
end;
// 如："C8329BFD0E01" --> {0xC8, 0x32, 0x9B, 0xFD, 0x0E, 0x01}
function gsmString2Bytes(pSrc:string):string;
var i,nSrcLength:Integer;
    t:string;
    ch:Byte;
    P:PChar;
begin
  i:=0;
  nSrcLength := Length(pSrc);
  p := Pchar(pSrc);
  Result := '';
  while i< nSrcLength do
    begin
        t := '';

        t := t + p^;
        inc(p);
        t := t + p^;
        t := '$'+t;
        inc(p);
        ch := StrtoInt(t);

        Result := Result + Chr(ch);
        Inc(i,2);
    end;
end;
// 字节数据转换为可打印字符串
// 如：{0xC8, 0x32, 0x9B, 0xFD, 0x0E, 0x01} --> "C8329BFD0E01" 
function gsmBytes2String(pSrc:string):string;
var
   i,nSrcLength:integer;
   ch:Byte;
   t:string;
   p:Pchar;
begin
    Result := '';
    nSrcLength := Length(pSrc);
    p := Pchar(pSrc);
    for i:= 0 to nSrcLength-1 do
      begin
        ch := ord(p^);
        t  := format('%2.2x',[ch]);
        Result := Result +t;
        inc(p);
      end;
end;
{ TField_ }

procedure TField_.Assign(Field: TField);
begin
  FFieldName := Field.FieldName;
  FDataType  := Field.DataType;
  FTitleCaption := Field.DisplayName;
  FVisible := Field.Visible;
  FWidth := Field.Size;
  FDataReadOnly := Field.ReadOnly;

  ProviderFlags := [];
  ProviderFlags := ProviderFlags+Field.ProviderFlags ;
end;

procedure TField_.AssignValue(Field: TField);
begin
  Case Field.DataSet.State of
    dsInsert:   //在插入状态下是没有OldValue值
            Begin
               FOldValue := null;
            end;
    else
        Begin
          case Field.DataSet.UpdateStatus  of
            usModified,usInserted,usDeleted:begin
                if VarIsStr(Field.OldValue) and (Field.OldValue='') then
                   FOldValue  := null
                else
                   FOldValue  := Field.OldValue;
            end
            else
              begin
                if VarIsStr(Field.Value) and (Field.Value='') then
                   FOldValue  := null
                else
                   FOldValue  := Field.Value;
              end;
          end;
        end;
  end; //End Case
  case Field.DataSet.UpdateStatus of
     usModified:begin
        if not VarIsClear(Field.Value) then
           begin
              if VarIsStr(Field.Value) and (Field.Value='') then
                 FNewValue  := null
              else
                 FNewValue  := Field.Value;
           end
        else
           begin
              if VarIsStr(Field.oldValue) and (Field.oldValue='') then
                 FNewValue  := null
              else
                 FNewValue  := Field.oldValue;
           end;
       end;
     usInserted:begin
          if VarIsStr(Field.Value) and (Field.Value='') then
             FNewValue  := null
          else
             FNewValue  := Field.Value;
       end;
     else
       begin
          if VarIsStr(Field.Value) and (Field.Value='') then
             FNewValue  := null
          else
             FNewValue  := Field.Value;
       end;
  end;
end;

constructor TField_.Create(AOwner:TObject);
begin
//  inherited Create(AOwner);
  inherited Create;
  FTableName := '';
end;

destructor TField_.Destroy;
begin
  inherited Destroy;
end;

function TField_.GetAsBoolean: Boolean;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := False
  else
     Result := FNewValue;
end;

function TField_.GetAsDatetime: TDatetime;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := 0
  else
     begin
       Result := FNewValue;
     end;
end;

function TField_.GetAsFloat: Real;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := 0
  else
     Result := FNewValue
end;

function TField_.GetAsInt64: Int64;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := 0
  else
     Result := FNewValue;
end;

function TField_.GetAsInteger: Longint;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := 0
  else
     Result := FNewValue;
end;

function TField_.GetAsOldBoolean: Boolean;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
    Result := False
  else
  if FOldValue>0 then
     Result := True
  else
     Result := False
end;

function TField_.GetAsOldDatetime: TDatetime;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
     Result := 0
  else
     Result := FOldValue
end;

function TField_.GetAsOldFloat: Real;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
     Result := 0
  else
     Result := FOldValue
end;

function TField_.GetAsOldInt64: Int64;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
     Result := 0
  else
     Result := FOldValue
end;

function TField_.GetAsOldInteger: Longint;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
     Result := 0
  else
     Result := FOldValue
end;

function TField_.GetAsOldString: String;
begin
  if VarIsNull(FOldValue) or VarIsClear(FOldValue) then
     Result := ''
  else
     Result := VartoStr(FOldValue)

end;

function TField_.GetAsOldValue: Variant;
begin
  Result := FOldValue
end;

function TField_.GetAsString: String;
begin
  if VarIsNull(FNewValue) or VarIsClear(FNewValue) then
     Result := ''
  else
     Result := VartoStr(FNewValue)
end;

function TField_.GetAsValue: Variant;
begin
  Result := NewValue;
end;

procedure TField_.SetAsBoolean(const Value: Boolean);
begin
  FNewValue := Value;
end;

procedure TField_.SetAsDatetime(const Value: TDatetime);
begin
  if Value=0 then
     FNewValue := null
  else
    begin
       Case DataType of
          ftString,ftMemo,ftWideString:
             FNewValue := formatDatetime('YYYY-MM-DD',Date());
          else
            begin
             FNewValue := Value;
             DataType := ftDatetime;
            end;
       end;
    end;
end;

procedure TField_.SetAsFloat(const Value: Real);
begin
  FNewValue := Value;
end;

procedure TField_.SetAsInt64(const Value: Int64);
begin
  FNewValue := Value;
end;

procedure TField_.SetAsInteger(const Value: Longint);
begin
  FNewValue := Value;
end;

procedure TField_.SetAsOldBoolean(const Value: Boolean);
begin
  if Value then
     FOldValue := 1
  else
     FOldValue := 0;
end;

procedure TField_.SetAsOldDatetime(const Value: TDatetime);
begin
  if Value=0 then
     FOldValue := null
  else
    begin
       Case DataType of
          ftString,ftMemo,ftWideString:
             FOldValue := formatDatetime('YYYY-MM-DD',Date());
          else
            begin
             FOldValue := Value;
             DataType := ftDatetime;
            end;
       end;
    end;
end;

procedure TField_.SetAsOldFloat(const Value: Real);
begin
  FOldValue := Value;
end;

procedure TField_.SetAsOldInt64(const Value: Int64);
begin
  FOldValue := Value;
end;

procedure TField_.SetAsOldInteger(const Value: Longint);
begin
  FOldValue := Value;
end;

procedure TField_.SetAsOldString(const Value: String);
begin
  if Value='' then
     FOldValue := Null
  else
    begin
       Case DataType of
          ftString,ftMemo,ftWideString:
             FOldValue := Value;
          ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD:
             FOldValue := StrtoFloat(Value);
          else
            begin
             FOldValue := Value;
             DataType := ftString;
            end;
       end;
    end;
end;

procedure TField_.SetAsOldValue(const Value: Variant);
begin
  FOldValue := Value;
end;

procedure TField_.SetAsString(const Value: String);
begin
  if Value='' then
     FNewValue := Null
  else
    begin
       Case DataType of
          ftString,ftMemo,ftWideString:
             FNewValue := Value;
          ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD:
             FNewValue := StrtoFloat(Value);
          else
            begin
             FNewValue := Value;
             DataType := ftString;
            end;
       end;
    end;
end;

procedure TField_.SetAsValue(const Value: Variant);
begin
  FNewValue := Value;
end;

procedure TField_.SetDataReadOnly(const Value: Boolean);
begin
  FDataReadOnly := Value;
end;

procedure TField_.SetDataType(const Value: TFieldType);
begin
  FDataType := Value;
end;

procedure TField_.SetFieldName(const Value: String);
begin
  FFieldName := Value;
end;

procedure TField_.SetIndex(const Value: integer);
begin
  FIndex := Value;
end;

procedure TField_.SetNewValue(const Value: Variant);
begin
  FNewValue := Value;
end;

procedure TField_.SetOldValue(const Value: Variant);
begin
  FOldValue := Value;
end;

procedure TField_.SetPickList(const Value: String);
begin
  FPickList := Value;
end;

procedure TField_.SetProviderFlags(const Value: TProviderFlags);
begin
  FProviderFlags := Value;
end;

procedure TField_.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

procedure TField_.SetTitleCaption(const Value: String);
begin
  FTitleCaption := Value;
end;

procedure TField_.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure TField_.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ TRecord_ }

procedure TRecord_.Clear;
var i:Integer;
begin
  for i:=0 to FList.Count-1 do
    Fields[i].Free;
  FList.Clear;
end;

constructor TRecord_.Create;
begin
  CreateNew(nil);
end;

constructor TRecord_.Create(ADataSet: TDataSet);
begin
  CreateNew(nil);
  ReadField(ADataSet);
end;

destructor TRecord_.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TRecord_.FindField(FieldName: String): TField_;
var i:Integer;
begin
  Result := nil;
  for i:=0 to Count-1 do
    begin
    if UpperCase(Fields[i].FieldName) = UpperCase(FieldName) then
       begin
         Result := Fields[i];
         result.Index := i;
         Exit;
       end;
    end;
end;

function TRecord_.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TRecord_.FieldbyName(FieldName: String): TField_;
begin
  Result := FindField(FieldName);
  if Result = nil then
     Raise Exception.Create(FieldName+'字段没找到。');
end;

function TRecord_.GetFields(Index: Integer): TField_;
begin
  Result := TField_(FList[Index]);
end;

function TRecord_.IsValid: Boolean;
begin
  Result := True;
end;

procedure TRecord_.ReadField(ADataSet: TDataSet);
var TmpField:TField_;
    i:Integer;
begin
  Clear;
  for i:=0 to ADataSet.FieldCount-1 do
    begin
      if ADataSet.Fields[i].FieldKind in [fkData,fkCalculated,fkInternalCalc,fkAggregate] then
         begin
            TmpField := TField_.Create(self);
            TmpField.Assign(ADataSet.Fields[i]);
            TmpField.Index := FList.Count;
            FList.Add(TmpField);
         end;
    end;
end;

procedure TRecord_.ReadFromDataSet(ADataSet: TDataSet;IsFieldExists:Boolean=True);
var TmpField:TField_;
    i:Integer;
begin
  if not ADataSet.Active then Exit;
  if FList.Count =0 then ReadField(ADataSet);

  for i:=0 to ADataSet.FieldCount-1 do
    begin
      if IsFieldExists then
         TmpField := FieldByName(ADataSet.Fields[i].FieldName)
      else
         begin
           TmpField := FindField(ADataSet.Fields[i].FieldName);
           if TmpField=nil then Continue;
         end;
      TmpField.AssignValue(ADataSet.Fields[i]);
    end;
end;

procedure TRecord_.WriteToDataSet(ADataSet: TDataSet;IsExists:Boolean=true);
var i:Integer;
    Field:TField_;
begin
  if FList.Count =0 then
     Raise Exception.Create('对象中的各字段没有初始化。');
  if not IsValid then
     Raise Exception.Create('对象中的各字段数据不能通过合法性检测');
  for i:=0 to ADataSet.FieldCount-1 do
    begin
       if ADataSet.Fields[i].ReadOnly then continue;
       Field := FindField(ADataSet.Fields[i].FieldName);
       if not Assigned(Field) then
          begin
            if IsExists then
            Raise Exception.Create(ADataSet.Fields[i].FieldName+'在对象中没找到。')
            else Continue;
          end;
       if not (ADataSet.State in [dsEdit,dsInsert]) then ADataSet.Edit;
       if VarIsClear(Field.NewValue) or (VarIsStr(Field.NewValue) and (Field.NewValue='')) then
          ADataSet.Fields[i].Value := null
       else
          begin
            case ADataSet.Fields[i].DataType of
              ftLargeint:ADataSet.Fields[i].AsString := InttoStr(Field.asInt64);
            else
              ADataSet.Fields[i].Value := Field.NewValue;
            end;
          end;
    end;
end;

procedure TRecord_.CopyTo(Records: TRecord_);
var i:Integer;
    Field:TField_;
begin
  Records.Clear;
  for i:=0 to Count -1 do
    begin
      Field := TField_.Create(nil);
      Field.FieldName := Fields[i].FieldName;
      Field.TitleCaption := Fields[i].TitleCaption;
      Field.DataType := Fields[i].DataType;
      Field.PickList := Fields[i].PickList;
      Field.Visible := Fields[i].Visible;
      Field.NewValue := Fields[i].NewValue;
      Field.OldValue := Fields[i].OldValue;
      Field.Width := Fields[i].Width;
      Field.DataReadOnly := Fields[i].DataReadOnly;
      Field.TableName := Fields[i].TableName;
      Records.AddField(Field); 
    end;
end;

procedure TRecord_.AddField(Field: TField_);
begin
  if FindField(Field.FieldName)<>nil then
     Raise Exception.Create(Field.FieldName+'已经存在。');
  Field.Index := FList.Count;
  FList.Add(Field);
end;

procedure TRecord_.AddField(AFieldName: string; AFieldValue: Variant; AFieldType:TFieldType=ftString);
var Field:TField_;
begin
   Field := TField_.Create(nil);
   AddField(Field);
   Field.FieldName := AFieldName;
   Field.NewValue  := AFieldValue;
   Field.OldValue  := AFieldValue;
   Field.DataType := AFieldType;
end;

constructor TRecord_.Create(AOwner: TComponent);
begin
  inherited;
  CreateNew(nil);
end;

constructor TZProcFactory.Create(AGlobal:IdbHelp;Params:TftParamList);
begin
  inherited Create(nil);
  FParams := TftParamList.Create(nil);
  if Params<>nil then
     FParams.Assign(Params); 
end;

destructor TZProcFactory.Destroy;
begin
  Params.Free;
  inherited;
end;

function TZProcFactory.Execute(AGlobal: IdbHelp; Params: TftParamList;
  out aData: OleVariant): Boolean;
begin
  Result := Execute(AGlobal,Params);
  aData := Msg;
  if not Result then
     begin
       if Msg = '' then Msg := '错误了,TProcFactory的方法是否没有返回值';
       Raise Exception.Create(Msg);
     end;
end;

function TZProcFactory.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
begin
  result := false;
end;

function TZProcFactory.GetOutMsg: String;
begin
  if VarIsStr(FOutData) then
     Result := FOutData
  else
     Result := 'null';
end;

function TZProcFactory.PSExecute(AGlobal:IdbHelp;HasResult:Boolean): Boolean;
begin
  if HasResult then
     Result := Execute(AGlobal,Params,FOutData)
  else
     Result := Execute(AGlobal,Params);
end;

function TZProcFactory.PSGetOutData: OleVariant;
begin
  Result := FOutData;
end;

function TZProcFactory.PSGetOutMessage: WideString;
begin
  if VarIsStr(FOutData) then
     Result := FOutData
  else
     Result := '';
end;

procedure TZProcFactory.SetOutMsg(const Value: String);
begin
  FOutData := Value;
end;

procedure TZProcFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TRecord_.CreateNew(AOwner: TComponent);
begin
  inherited Create(nil);
  FList := TList.Create;
end;

procedure TRecord_.CopyToParams(Params: TParams;ForOldValue:boolean=false);
var
  i:integer;
  Field:TField_;
begin
  for i:=0 to Params.Count -1 do
    begin
      Field := FindField(Params[i].Name);
      if Field<>nil then
         begin
           Params[i].DataType := Field.DataType;
           if ForOldValue then
              Params[i].Value := Field.OldValue
           else
              Params[i].Value := Field.NewValue;
         end;
    end;
end;

{ TZFactory }

function TZFactory.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TZFactory.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TZFactory.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TZFactory.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TZFactory.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TZFactory.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

constructor TZFactory.Create(ADataSet: TDataSet);
begin
  inherited;
  FDataSet := ADataSet;
  if ADataSet.ClassNameIs('TZQuery') then
  begin
     SelectSQL.Text := TZQuery(ADataSet).SQL.Text;
  end;
  if ADataSet.ClassNameIs('TZQuery') then
  begin
     SelectSQL.Text := TZReadOnlyQuery(ADataSet).SQL.Text;
  end;
  if ADataSet.ClassNameIs('TZTable') then
  begin
     SelectSQL.Text := TZTable(ADataSet).TableName;
  end;
end;

procedure TZFactory.CreateNew(AOwner: TComponent);
begin
  inherited;
  FDataSet := nil;
  FIsSQLUpdate := False;
  FSelectSQL := TSQLCache.Create;
  FDeleteSQL := TSQLCache.Create;
  FUpdateSQL := TSQLCache.Create;
  FInsertSQL := TSQLCache.Create;
  FParams := TftParamList.Create(self);

end;

destructor TZFactory.Destroy;
begin
  Clear;
  FSelectSQL.Free;
  FDeleteSQL.Free;
  FUpdateSQL.Free;
  FInsertSQL.Free;
  FParams.Free;
  inherited;
end;

function TZFactory.FindParam(ParamName: string): TParam;
begin
  Result := Params.FindParam(ParamName);
end;

procedure TZFactory.InitClass;
begin

end;


function TZFactory.PSBeforeCommitRecord(
  ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeCommitRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

function TZFactory.PSBeforeDeleteRecord(
  ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeDeleteRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

function TZFactory.PSBeforeInsertRecord(
  ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeInsertRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

function TZFactory.PSBeforeModifyRecord(
  ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeModifyRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

function TZFactory.PSBeforeOpenRecord(
  ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeOpenRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

function TZFactory.PSBeforeUpdateRecord(ObjectFactory: IdbHelp): HRESULT;
begin
  if BeforeUpdateRecord(ObjectFactory) then
     Result := 0
  else
     Result := 0;
end;

procedure TZFactory.PSInitialize;
begin
  InitClass;
end;

procedure TZFactory.SetDLLHandle(const Value: THandle);
begin
  FDLLHandle := Value;
end;

procedure TZFactory.SetIsSQLUpdate(const Value: Boolean);
begin
  FIsSQLUpdate := Value;
end;

procedure TZFactory.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

procedure TZFactory.SetZClassName(const Value: string);
begin
  FZClassName := Value;
end;

procedure TZFactory.SetZParamWStr(const Value: widestring);
begin
  FZParamWStr := Value;
end;

{ TRecordList }

procedure TRecordList.AddRecord(RS: TRecord_);
begin
  FList.Add(RS);
end;

procedure TRecordList.Clear;
var i:Integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      TRecord_(FList[i]).Free;
    end;
  FList.Clear;
end;

constructor TRecordList.Create;
begin
  inherited;
  FList := TList.Create;
end;

procedure TRecordList.Delete(Index: Integer);
begin
  TRecord_(FList[Index]).Free;
  FList.Delete(Index);
end;

destructor TRecordList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TRecordList.FindRecord(FieldName: string;
  FieldValue: Variant): TRecord_;
var i:Integer;
begin
  Result := nil;
  for i:=0 to Count-1 do
    begin
      if Records[i].FieldByName(FieldName).AsValue = FieldValue then
         begin
           Result := Records[i];
           Exit;
         end;
    end;
end;

function TRecordList.GetCount: integer;
begin
  Result := FList.Count;
end;

function TRecordList.GetList: TList;
begin
  Result := FList;
end;

function TRecordList.GetRecords(Index: Integer): TRecord_;
begin
  Result := TRecord_(FList[Index]);
end;

procedure TRecordList.MoveTo(CurIndex, NewIndex: Integer);
begin
  FList.Move(CurIndex,NewIndex);
end;

{ TftParamList }

class procedure TftParamList.Decode(Params: TParams; str: string);
var
  i,w,c:integer;
  ss:TStringStream;
  cname:string;
  n:boolean;
  p1:integer;
  p2:boolean;
  p3:Currency;
  p4:tdatetime;
  p5:double;
  p6:int64;
  p7:TBcd;
  param:TParam;
begin
  if str='' then
     begin
       Params.Clear;
       Exit;
     end;
  ss := TStringStream.Create(DecodeString(str));
  try
    ss.Position := 0;
    ss.Read(c,sizeof(c)); 
    for i:=0 to c-1 do
      begin
        //参数名
        ss.Read(w,sizeof(w));
        cname := ss.ReadString(w);
        //参数类型
        ss.Read(w,sizeof(w));
        param := Params.FindParam(cname);
        if param=nil then
           begin
             param := TParam(Params.add);
             param.Name := cname;
             param.ParamType := ptInput;
           end;
        param.DataType := TFieldType(w);
        //是否为空
        ss.Read(n,sizeof(n));
        if n then continue;
        //参数值
        case Params[i].DataType of
        ftString,ftFixedChar,ftWideString:
           begin
             ss.Read(w,sizeof(w));
             Param.asString := ss.ReadString(w);
           end;
        ftSmallint,ftInteger,ftWord:
           begin
             ss.Read(p1,sizeof(p1));
             param.AsInteger := p1;
           end;
        ftBoolean:
           begin
             ss.Read(p2,sizeof(p2));
             param.AsBoolean := p2;
           end;
        ftCurrency,ftBCD:
           begin
             ss.Read(p3,sizeof(p3));
             param.AsCurrency := p3;
           end;
        ftDate,ftTime,ftDateTime:
           begin
             ss.Read(p4,sizeof(p4));
             param.AsDateTime := p4;
           end;
        ftFloat:
           begin
             ss.Read(p5,sizeof(p5));
             param.AsFloat := p5;
           end;
        ftLargeint:
           begin
             ss.Read(p6,sizeof(p6));
             param.asString := inttostr(p6);
           end;
        ftFMTBcd:
           begin
             ss.Read(p7,sizeof(p7));
             param.AsFMTBCD := p7;
           end;
        else
           Raise Exception.Create('不支持的数据参数类型'); 
        end;
      end;
  finally
    ss.free;
  end;
end;

class function TftParamList.Encode(Params: TParams): string;
var
  i,w:integer;
  ss:TStringStream;
  n:boolean;
  p1:integer;
  p2:boolean;
  p3:Currency;
  p4:tdatetime;
  p5:double;
  p6:int64;
  p7:TBcd;
begin
  ss := TStringStream.Create('');
  try
    //写入参数个数
    w := Params.Count;
    ss.Write(w,sizeof(w));
    for i:=0 to Params.Count-1 do
      begin
        //参数名
        w := length(Params[i].Name);
        ss.Write(w,sizeof(w));
        ss.WriteString(Params[i].Name);
        //参数类型
        w := ord(Params[i].DataType);
        ss.Write(w,sizeof(w));
        //是否为空
        n := Params[i].IsNull;
        ss.Write(n,sizeof(n));
        if Params[i].IsNull then continue;
        //参数值
        case Params[i].DataType of
        ftString,ftFixedChar,ftWideString:
           begin
             w := length(Params[i].AsString);
             ss.Write(w,sizeof(w));
             ss.WriteString(Params[i].AsString);
           end;
        ftSmallint,ftInteger,ftWord:
           begin
             p1 := Params[i].AsInteger;
             ss.Write(p1,sizeof(p1));
           end;
        ftBoolean:
           begin
             p2 := Params[i].AsBoolean;
             ss.Write(p2,sizeof(p2));
           end;
        ftCurrency,ftBCD:
           begin
             p3 := Params[i].AsCurrency;
             ss.Write(p3,sizeof(p3));
           end;
        ftDate,ftTime,ftDateTime:
           begin
             p4 := Params[i].AsDateTime;
             ss.Write(p4,sizeof(p4));
           end;
        ftFloat:
           begin
             p5 := Params[i].AsFloat;
             ss.Write(p5,sizeof(p5));
           end;
        ftLargeint:
           begin
             p6 := StrtoInt64Def(Params[i].asString,0);
             ss.Write(p6,sizeof(p6));
           end;
        ftFMTBcd:
           begin
             p7 := Params[i].AsFMTBCD;
             ss.Write(p7,sizeof(p7));
           end;
        else
           Raise Exception.Create('不支持的数据参数类型'); 
        end;
      end;
    result := EncodeString(ss.DataString);
  finally
    ss.free;
  end;
end;

function TftParamList.ParamByName(const Value: string): TParam;
begin
  Result := FindParam(Value);
  if Result = nil then
     begin
       result := TParam(Add);
       result.Name := Value;
       result.ParamType := ptInput;
     end;
end;

end.
