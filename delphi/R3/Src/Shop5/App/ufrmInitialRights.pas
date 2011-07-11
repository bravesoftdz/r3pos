unit ufrmInitialRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzPrgres, ExtCtrls, ZDataset, Math;

type
  TfrmInitialRights = class(TfrmBasic)
    Panel1: TPanel;
    ProgressBar1: TRzProgressBar;
  private
    { Private declarations }
    R:Integer;
    alread:Boolean;
    function GetRightsInfo:boolean;
  public
    { Public declarations }
    procedure InitialRights; //读取初始化其它角色权限脚本
    procedure InitRights;    //生成初始化老板权限脚本
    procedure DoSql(Sql:String);
    class function Rights(Owner:TForm):Boolean;
  end;

implementation
uses uGlobal,uCaFactory,Des,uShopGlobal,uDsUtil,ObjCommon;
{$R *.dfm}

{ TfrmInitialRights }

procedure TfrmInitialRights.DoSql(Sql: String);
begin
  sql := stringreplace(sql,':ROWS_ID',''''+TSequence.NewId+'''',[rfReplaceAll]);
  sql := stringreplace(sql,':TENANT_ID',inttostr(Global.TENANT_ID),[rfReplaceAll]);
  sql := stringreplace(sql,':ROLE_ID',''''+inttostr(Global.TENANT_ID)+formatFloat('000',r)+'''',[rfReplaceAll]);
  Factor.ExecSQL(sql);
end;

function TfrmInitialRights.GetRightsInfo:Boolean;
var
  Str: String;
  rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from CA_RIGHTS where TENANT_ID='+IntToStr(Global.TENANT_ID);
    Factor.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;

procedure TfrmInitialRights.InitialRights;
var
  F:TextFile;
  FileName,s:String;
  SQL:TStringList;
  i,CurSize,TotalSize:Integer;
begin
  FileName := ExtractFilePath(Application.ExeName)+'Initial.dat';
  if not FileExists(FileName) then Raise Exception.Create('系统没找到初始化脚本，无法执行初始化工作!');
  copyfile(pchar(FileName),pchar(FileName+'~'),false);
  des.DecryFile(FileName+'~',DES_KEY);
  SQL := TStringList.Create;
  Assignfile(F,FileName+'~');
  try
    reset(f);
    try
       Factor.BeginTrans();
       InitRights;
       TotalSize := FileSize(F)*1024 div 8;
       if TotalSize=0 then TotalSize := 1;
       CurSize := 0;
       while not eof(f) do
       begin
         readln(f,s);
         CurSize := CurSize + length(s);
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
                   DoSQL(SQL.Text);
                 end;
              SQL.Clear;
            end
         else
            begin
              if copy(s,1,2)<>'--' then
                 SQL.Add(s);
            end;
         ProgressBar1.Percent := CurSize*100 div TotalSize;
       end;
       if (SQL.Count>0) then
          begin
            DoSQL(SQL.Text);
            SQL.Clear;
          end;
       Factor.CommitTrans;
    except
      on E:Exception do
        begin
          Factor.RollbackTrans;
          Raise Exception.Create('初始化角色权限出错了,错误:'+E.Message);
        end;
    end;
  finally
    SQL.Free;
    closefile(f);
    deletefile(FileName+'~');
  end;
end;

class function TfrmInitialRights.Rights(Owner: TForm): Boolean;
begin
  with TfrmInitialRights.Create(Owner) do
    begin
      try
        R := 1;
        if not GetRightsInfo then InitialRights;
      finally
        Free;
      end;
    end;
end;

procedure TfrmInitialRights.InitRights;
var
  Str,Str_Insert: string;
  Rs: TZQuery;
begin
  //返回当前产品：ProductID所有模块
  Str:='select distinct A.MODU_ID as MODU_ID,B.SEQNO as SEQNO from '+
       '(select MODU_ID,LEVEL_ID from ca_Module where PROD_ID='''+ProductID+''' and MODU_TYPE=1) A,'+
       '(select LEVEL_ID,Max(SEQNO) as SEQNO from '+
       ' (select substr(LEVEL_ID,1,len(LEVEL_ID)-3) as LEVEL_ID,SEQNO from ca_Module where PROD_ID='''+ProductID+''' and MODU_TYPE=2) tmp '+
       ' group by LEVEL_ID) B '+
       ' where B.LEVEL_ID=A.LEVEL_ID '+
       ' order by MODU_ID ';
  Rs:=TZQuery.Create(nil);
  try
    Rs.SQl.Text:=ParseSQL(Factor.iDbType,Str);
    Factor.Open(Rs);
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

end.
 