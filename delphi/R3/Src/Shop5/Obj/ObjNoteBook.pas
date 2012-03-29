unit ObjNoteBook;

interface

uses
  Dialogs,SysUtils,zBase,Classes, ZDataSet,ZIntf,ObjCommon;

type
  TNoteBook=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;  
    procedure InitClass;override;
  end;

implementation

{ TRole }

function TNoteBook.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
  MaxID: integer;
begin
  Rs:=TZQuery.Create(nil);
  try
    Rs.Close;
    Rs.SQL.Clear;
    Rs.SQL.Text:='select max(NB_SEQNO) as MaxID from OA_NOTEBOOK ';
    if Params.FindParam('TENANT_ID')<>nil then
      Rs.SQL.Text:= Rs.SQL.Text +' where TENANT_ID='+IntToStr(Params.FindParam('TENANT_ID').AsInteger);
    AGlobal.Open(Rs);
    MaxID:=Rs.Fields[0].AsInteger+1;
  finally
    Rs.Free;
  end;
  DataSet.Edit;
  DataSet.FieldByName('NB_SEQNO').AsInteger:=MaxID;
  FieldByName('NB_SEQNO').AsInteger:=MaxID;
  DataSet.Post;
end;

procedure TNoteBook.InitClass;
var
  Str:string;
begin
  KeyFields:='TENANT_ID;ROWS_ID'; 
  //初始化查询
  SelectSQL.Text:=
    'select TENANT_ID,ROWS_ID,NB_TYPE,NB_DATE,NB_SEQNO,USER_ID,NB_GROUP,NB_TITLE,NB_TEXT From OA_NOTEBOOK '+
    ' where TENANT_ID=:TENANT_ID and ROWS_ID=:ROWS_ID ';
  //初始化更新逻辑
  Str:=
    'insert into OA_NOTEBOOK(TENANT_ID,ROWS_ID,NB_TYPE,NB_DATE,NB_SEQNO,USER_ID,NB_GROUP,NB_TITLE,NB_TEXT,COMM,TIME_STAMP)'+
    ' values (:TENANT_ID,:ROWS_ID,:NB_TYPE,:NB_DATE,:NB_SEQNO,:USER_ID,:NB_GROUP,:NB_TITLE,:NB_TEXT,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);

  Str :=
    'update OA_NOTEBOOK '+
    ' set TENANT_ID=:TENANT_ID,ROWS_ID=:ROWS_ID,NB_TYPE=:NB_TYPE,NB_DATE=:NB_DATE,NB_SEQNO=:NB_SEQNO,USER_ID=:USER_ID,'+
    ' NB_GROUP=:NB_GROUP,NB_TITLE=:NB_TITLE,NB_TEXT=:NB_TEXT,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID';
  UpdateSQL.Add(Str);
  Str := 'delete from OA_NOTEBOOK where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID';
  DeleteSQL.Add(Str);
end;


initialization
  RegisterClass(TNoteBook);
  
finalization
  UnRegisterClass(TNoteBook);
  
end.

