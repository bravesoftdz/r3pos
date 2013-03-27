unit uRightsFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs, DB, udllDsUtil, Math, Des;

type
  TRightsFactory=class
  private
    R:Integer;
    RsRight:TZQuery;
    procedure InitRights;
    procedure DoSql(sql:string);
    procedure DoSqlToDataSet(sql:string);
    function  GetRightsInfo:boolean;
  public
    constructor Create;
    destructor  Destroy;override;
    procedure InitialRights;
  end;

var RightsFactory:TRightsFactory;

implementation

uses udataFactory,udllGlobal,uTokenFactory;

constructor TRightsFactory.Create;
begin
  RsRight := TZQuery.Create(nil);
  RsRight.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
  RsRight.FieldDefs.Add('SQL01',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL02',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL03',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL04',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL05',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL06',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL07',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL08',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL09',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL10',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL11',ftstring,250,true);
  RsRight.FieldDefs.Add('SQL12',ftstring,250,true);
  RsRight.CreateDataSet;
end;

destructor TRightsFactory.Destroy;
begin
  inherited;
  RsRight.Free;
end;

procedure TRightsFactory.DoSql(sql: string);
begin
  sql := stringreplace(sql,':ROWS_ID',''''+TSequence.NewId+'''',[rfReplaceAll]);
  sql := stringreplace(sql,':TENANT_ID',token.tenantId,[rfReplaceAll]);
  sql := stringreplace(sql,':ROLE_ID',''''+token.tenantId+formatFloat('000',r)+'''',[rfReplaceAll]);
  dataFactory.ExecSQL(sql);
end;

procedure TRightsFactory.DoSqlToDataSet(sql: string);
  function GetFieldSQL(Sql:string;FieldIdx: integer):string;
  var BegIdx:integer;
  begin
    result:='';
    BegIdx:=(FieldIdx-1)*250+1;
    if Length(Sql)>=BegIdx then
       result:=Copy(Sql,BegIdx,250);
  end;
var RecNo: integer;
begin
  sql := stringreplace(sql,':ROWS_ID',''''+TSequence.NewId+'''',[rfReplaceAll]);
  sql := stringreplace(sql,':TENANT_ID',token.tenantId,[rfReplaceAll]);
  sql := stringreplace(sql,':ROLE_ID',''''+token.tenantId+formatFloat('000',r)+'''',[rfReplaceAll]);

  RecNo := RsRight.RecordCount+1;
  RsRight.Append;
  RsRight.FieldByName('SEQ_NO').AsInteger:=RecNo;
  RsRight.FieldByName('SQL01').AsString:=GetFieldSQL(sql, 1);
  RsRight.FieldByName('SQL02').AsString:=GetFieldSQL(sql, 2);
  RsRight.FieldByName('SQL03').AsString:=GetFieldSQL(sql, 3);
  RsRight.FieldByName('SQL04').AsString:=GetFieldSQL(sql, 4);
  RsRight.FieldByName('SQL05').AsString:=GetFieldSQL(sql, 5);
  RsRight.FieldByName('SQL06').AsString:=GetFieldSQL(sql, 6);
  RsRight.FieldByName('SQL07').AsString:=GetFieldSQL(sql, 7);
  RsRight.FieldByName('SQL08').AsString:=GetFieldSQL(sql, 8);
  RsRight.FieldByName('SQL09').AsString:=GetFieldSQL(sql, 9);
  RsRight.FieldByName('SQL10').AsString:=GetFieldSQL(sql,10);
  RsRight.FieldByName('SQL11').AsString:=GetFieldSQL(sql,11);
  RsRight.FieldByName('SQL12').AsString:=GetFieldSQL(sql,12);
  RsRight.Post; 
end;

function TRightsFactory.GetRightsInfo: boolean;
var rs:TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from CA_RIGHTS where TENANT_ID='+token.tenantId;
    dataFactory.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;

procedure TRightsFactory.InitialRights;
var
  F:TextFile;
  FileName,s:String;
  SQL:TStringList;
begin
  if GetRightsInfo then Exit;
 
  FileName := ExtractFilePath(Application.ExeName)+'Initial.dat';
  if not FileExists(FileName) then Raise Exception.Create('系统没找到初始化脚本，无法执行初始化工作!');
  copyfile(pchar(FileName),pchar(FileName+'~'),false);
  des.DecryFile(FileName+'~',DES_KEY);
  SQL := TStringList.Create;
  Assignfile(F,FileName+'~');
  try
    reset(f);
    try
      InitRights;
      while not Eof(f) do
      begin
        readln(f,s);
        s := trim(s);
        if s='' then Continue;
        if copy(s,1,2)='--' then Continue;
        if copy(s,1,2)='//' then
           begin
             R := StrToInt(copy(s,3,length(s)));
             Continue;
           end;
        if (s[length(s)]=';') then
           begin
             if (s[length(s)]=';') then
                begin
                  delete(s,length(s),1);
                  SQL.Add(s);
                end;
             if (SQL.Count>0) then
                begin
                  DoSqlToDataSet(SQL.Text);
                end;
             SQL.Clear;
           end
        else
           begin
             if copy(s,1,2)<>'--' then
                SQL.Add(s);
           end;
      end;
      if (SQL.Count>0) then
         begin
           DoSQL(SQL.Text);
           DoSqlToDataSet(SQL.Text);
           SQL.Clear;
         end;
      if RsRight.RecordCount>0 then
         begin
           dataFactory.UpdateBatch(RsRight,'TInitRightV60');
         end;
    except
      on E:Exception do
         begin
           Raise Exception.Create('初始化角色权限出错了,错误:'+E.Message);
         end;
    end;
  finally
    SQL.Free;
    closefile(f);
    deletefile(FileName+'~');
  end;
end;

procedure TRightsFactory.InitRights;
var
  ProductID,Str,Str_Insert: string;
  Rs: TZQuery;
begin
  ProductID := dllGlobal.GetProductId;
  Str:='select distinct A.MODU_ID as MODU_ID,B.SEQNO as SEQNO from '+
       '(select MODU_ID,LEVEL_ID from ca_Module where PROD_ID='''+ProductID+''' and MODU_TYPE=1) A,'+
       '(select LEVEL_ID,Max(SEQNO) as SEQNO from '+
       ' (select substr(LEVEL_ID,1,len(LEVEL_ID)-3) as LEVEL_ID,SEQNO from ca_Module where PROD_ID='''+ProductID+''' and MODU_TYPE=2) tmp '+
       ' group by LEVEL_ID) B '+
       ' where B.LEVEL_ID=A.LEVEL_ID '+
       ' order by MODU_ID ';
  Rs:=TZQuery.Create(nil);
  try
    Rs.SQl.Text:=ParseSQL(dataFactory.iDbType,Str);
    dataFactory.Open(Rs);
    Rs.First;
    while not Rs.Eof do
    begin
      Str_Insert := 'insert into CA_RIGHTS(ROWS_ID,TENANT_ID,MODU_ID,ROLE_ID,ROLE_TYPE,CHK,COMM,TIME_STAMP) '+
      'values('''+TSequence.NewId+''',:TENANT_ID,'''+Rs.FieldbyName('MODU_ID').asstring+''',:ROLE_ID,1,'+FloatToStr(Power(2,Rs.FieldbyName('SEQNO').asInteger)-1)+',''00'',5497000)';
      DoSql(Str_Insert);
      Rs.Next;
    end;
  finally
    Rs.Free;                                                       
  end;
end;

initialization
  RightsFactory := TRightsFactory.Create;
finalization
  if assigned(RightsFactory) then FreeAndNil(RightsFactory);
end.
