unit ObjPRICEGRADEInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;
TYPE
  TPRICEGRADEInfo=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TPRICEGRADEInfo }

function TPRICEGRADEInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from VIW_CUSTOMER where TENANT_ID=:TENANT_ID and PRICE_ID=:OLD_PRICE_ID and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('OLD_PRICE_ID').AsString := FieldByName('PRICE_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('PRICE_NAME').AsOldString+'"已经在会员档案中使用不能删除.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TPRICEGRADEInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_PRICEGRADE where PRICE_ID<>:PRICE_ID and TENANT_ID=:TENANT_ID and INTEGRAL=:INTEGRAL and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('PRICE_ID').AsString := FieldByName('PRICE_ID').AsString;
    rs.ParamByName('INTEGRAL').AsInteger := FieldByName('INTEGRAL').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('在客户等积中,有积分设置相同的情况.请检查..');

    rs.SQL.Text := 'select PRICE_ID,COMM from PUB_PRICEGRADE where TENANT_ID=:TENANT_ID and PRICE_NAME=:PRICE_NAME';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('PRICE_NAME').AsString := FieldByName('PRICE_NAME').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的等级，重新启动原有编码
           begin
             FieldbyName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
             case iDbType of
             0: AGlobal.ExecSQL('delete PUB_PRICEGRADE where PRICE_ID=:PRICE_ID and TENANT_ID=:OLD_TENANT_ID ',self);
             3: AGlobal.ExecSQL('delete from PUB_PRICEGRADE where PRICE_ID=:PRICE_ID and TENANT_ID=:OLD_TENANT_ID ',self);
             end;
           end
        else
           Raise Exception.Create('"'+FieldbyName('PRICE_NAME').AsString+'"等级名不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
  result := True;
end;

function TPRICEGRADEInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_PRICEGRADE where PRICE_ID<>:PRICE_ID and TENANT_ID=:TENANT_ID and INTEGRAL=:INTEGRAL and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('PRICE_ID').AsString := FieldByName('PRICE_ID').AsString;
    rs.ParamByName('INTEGRAL').AsInteger := FieldByName('INTEGRAL').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('在客户等积中,有积分设置相同的情况.请检查..');

    rs.SQL.Text := 'select PRICE_ID,COMM from PUB_PRICEGRADE where TENANT_ID=:OLD_TENANT_ID and PRICE_ID<>:OLD_PRICE_ID and PRICE_NAME=:PRICE_NAME ';
    rs.ParamByName('OLD_TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('OLD_PRICE_ID').AsString := FieldByName('PRICE_ID').AsOldString;
    rs.ParamByName('PRICE_NAME').AsString := FieldByName('PRICE_NAME').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的等级，重新启动原有编码
           begin
             FieldbyName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
             case iDbType of
             0: AGlobal.ExecSQL('delete PUB_PRICEGRADE where PRICE_ID=:PRICE_ID and TENANT_ID=:OLD_TENANT_ID ',self);
             3: AGlobal.ExecSQL('delete from PUB_PRICEGRADE where PRICE_ID=:PRICE_ID and TENANT_ID=:OLD_TENANT_ID ',self);
             end;
           end
        else
           Raise Exception.Create('"'+FieldbyName('PRICE_NAME').AsString+'"等级名不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
  result := True;
end;

procedure TPRICEGRADEInfo.InitClass;
var Str:string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,'+
  'AGIO_SORTS,SEQ_NO,''0000'' as LEVEL_ID,COMM,TIME_STAMP from PUB_PRICEGRADE where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID order by INTEGRAL,PRICE_ID';
  IsSQLUpdate := True;

  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,AGIO_SORTS,SEQ_NO,COMM,TIME_STAMP) '
  +'VALUES(:TENANT_ID,:PRICE_ID,:PRICE_NAME,:PRICE_SPELL,:INTEGRAL,:INTE_TYPE,:INTE_AMOUNT,:MINIMUM_PERCENT,:AGIO_TYPE,:AGIO_PERCENT,:AGIO_SORTS,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_PRICEGRADE set PRICE_ID=:PRICE_ID,PRICE_NAME=:PRICE_NAME,PRICE_SPELL=:PRICE_SPELL,INTEGRAL=:INTEGRAL,INTE_TYPE=:INTE_TYPE,'+
  'INTE_AMOUNT=:INTE_AMOUNT,MINIMUM_PERCENT=:MINIMUM_PERCENT,AGIO_TYPE=:AGIO_TYPE,AGIO_PERCENT=:AGIO_PERCENT,AGIO_SORTS=:AGIO_SORTS,SEQ_NO=:SEQ_NO,'+
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and PRICE_ID=:OLD_PRICE_ID ';
  UpdateSQL.Text := Str;
  
  Str := 'update PUB_PRICEGRADE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and PRICE_ID=:OLD_PRICE_ID';
  DeleteSQL.Text := Str;

end;
initialization
  RegisterClass(TPRICEGRADEInfo);
finalization
  UnRegisterClass(TPRICEGRADEInfo);
end.
