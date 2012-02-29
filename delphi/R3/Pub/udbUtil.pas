unit udbUtil;

interface
uses Windows,ShellApi,SysUtils,Classes,ZipUtils,DB,ZDataSet,ZdbFactory,uFnUtil;
type
TCreateDbCallBack=procedure(Title:string;SQL:string;Percent:Integer) of Object;
TCreateDbFactory=class
  private
    FList:TStringList;
    CurVersion,NewVersion: string;
    FPrgVersion: string;
    FCaptureError: Boolean;
    FonCreateDbCallBack: TCreateDbCallBack;
    FHasError: Boolean;
    FTBSPPATH: string;
    FPARTITION: string;
    FTBSPPATH1: string;
    FTBSPPATH3: string;
    FTBSPPATH2: string;
    FTBSPPATH4: string;
    function GetWindowTmp: string;
    procedure SetCaptureError(const Value: Boolean);
    procedure SetonCreateDbCallBack(const Value: TCreateDbCallBack);
    procedure SetHasError(const Value: Boolean);
    function GetiDbType: integer;
    procedure SetTBSPPATH(const Value: string);
    procedure SetPARTITION(const Value: string);
    function EncodeSQL(SQL:string):string;
    procedure SetTBSPPATH1(const Value: string);
    procedure SetTBSPPATH2(const Value: string);
    procedure SetTBSPPATH3(const Value: string);
    procedure SetTBSPPATH4(const Value: string);
  public
    constructor Create;
    destructor  Destroy;override;
    function CompareVersion(v1,v2:string):Boolean;
    function CheckVersion(Version:string;aFactor:TdbFactory=nil):Boolean;
    procedure UpdateVersion;
    procedure Load(FileName:string);
    procedure dbInit;
    procedure Run;
    property WindowTmp:string read GetWindowTmp;
    property PrgVersion:string read FPrgVersion;
    property DbVersion:string read CurVersion;
    property CaptureError:Boolean read FCaptureError write SetCaptureError;
    property onCreateDbCallBack:TCreateDbCallBack read FonCreateDbCallBack write SetonCreateDbCallBack;
    property HasError:Boolean read FHasError write SetHasError;
    property iDbType:integer read GetiDbType;
    property TBSPPATH:string read FTBSPPATH write SetTBSPPATH;
    property TBSPPATH1:string read FTBSPPATH1 write SetTBSPPATH1;
    property TBSPPATH2:string read FTBSPPATH2 write SetTBSPPATH2;
    property TBSPPATH3:string read FTBSPPATH3 write SetTBSPPATH3;
    property TBSPPATH4:string read FTBSPPATH4 write SetTBSPPATH4;
    property PARTITION:string read FPARTITION write SetPARTITION;
  end;
function CheckDbVersion(DBVersion:string):boolean;
implementation
uses uGlobal,ufrmDbUpgrade;
{ TCreateDbFactory }
procedure WriteLog(s:string);
var
  f:TextFile;
begin
  AssignFile(f,ExtractFilePath(ParamStr(0))+'debug\dbUpgrade.log');
  if FileExists(ExtractFilepath(ParamStr(0))+'debug\dbUpgrade.log') then
     append(f)
  else
     rewrite(f);
  try
     writeln(f,formatDatetime('YYYY-MM-DD HH:NN:SS',now())+':'+s);
  finally
     closefile(f);
  end;
end;

function CheckDbVersion(DBVersion:string):boolean;
var Factory:TCreateDbFactory;
begin
  result := true;
  Factory := TCreateDbFactory.Create;
  try
    if FindCmdLineSwitch('DEBUG',['-','+'],false) then
       Factory.CaptureError := false
    else
       Factory.CaptureError := true;
    if not Factory.CheckVersion(DBVersion) then Exit;
    if not FileExists(ExtractFilePath(ParamStr(0))+'dbFile.dat') then Exit;
    result := TfrmDbUpgrade.DbUpgrade(Factory);
  finally
    Factory.Free;
  end;
end;
function TCreateDbFactory.CheckVersion(Version: string;aFactor:TdbFactory=nil): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select Value from SYS_DEFINE where TENANT_ID=0 and DEFINE=''DBVERSION''';
    try
      FPrgVersion := Version;
      if aFactor=nil then
         Factor.Open(rs)
      else
         aFactor.Open(rs);
      CurVersion := rs.Fields[0].asString;
      result := CompareVersion(Version,rs.Fields[0].asString);
    except
      result := true;
      CurVersion := '';
//      raise;
    end;
  finally
    rs.Free;
  end;
end;

function TCreateDbFactory.CompareVersion(v1, v2: string): Boolean;
var L1,L2:TStringList;
  v11,v12,v13,v14:Integer;
  v21,v22,v23,v24:Integer;
begin
  L1 := TStringList.Create;
  L2 := TStringList.Create;
  try
    L1.Delimiter := '.';
    L1.DelimitedText := v1;
    L2.Delimiter := '.';
    L2.DelimitedText := v2;

    if L1.Count >= 1 then v11 := StrtoIntDef(L1[0],0) else v11 := 0;
    if L1.Count >= 2 then v12 := StrtoIntDef(L1[1],0) else v12 := 0;
    if L1.Count >= 3 then v13 := StrtoIntDef(L1[2],0) else v13 := 0;
    if L1.Count >= 4 then v14 := StrtoIntDef(L1[3],0) else v14 := 0;

    if L2.Count >= 1 then v21 := StrtoIntDef(L2[0],0) else v21 := 0;
    if L2.Count >= 2 then v22 := StrtoIntDef(L2[1],0) else v22 := 0;
    if L2.Count >= 3 then v23 := StrtoIntDef(L2[2],0) else v23 := 0;
    if L2.Count >= 4 then v24 := StrtoIntDef(L2[3],0) else v24 := 0;

    if v11>v21 then
       result := true
    else
    if v11<v21 then
       result := false
    else
    if v12>v22 then
       result := true
    else
    if v12<v22 then
       result := false
    else
    if v13>v23 then
       result := true
    else
    if v13<v23 then
       result := false
    else
    if v14>v24 then
       result := true
    else
       result := false;
  finally
    L1.Free;
    L2.Free;
  end;
end;

constructor TCreateDbFactory.Create;
begin
  FList := TStringList.Create;
end;

procedure TCreateDbFactory.dbInit;
var
  n,CurSize,TotalSize,j:integer;
  tmpPath,s:string;
  F:TextFile;
  SQL:TStringList;
  rs,fs:TZQuery;
  srDbType:integer;
  dbInit:string;
begin
  if CompareVersion(CurVersion,'1.0.2.4') then Exit;
  if not (Factor.iDbType in [1,4]) then Exit;
  if TBSPPATH1='' then Raise Exception.Create('请正确设置基础表空间的存储路径');
  if TBSPPATH2='' then Raise Exception.Create('请正确设置业务表空间的存储路径');
  if TBSPPATH3='' then Raise Exception.Create('请正确设置台账表空间的存储路径');
  if TBSPPATH4='' then Raise Exception.Create('请正确设置索引表空间的存储路径');
  HasError := false;
  tmpPath := GetWindowTmp;
  SQL := TStringList.Create;
  try
       srDbType := -1;
       SQL.Clear;
       if Assigned(onCreateDbCallBack) then
          onCreateDbCallBack('初始化数据库','',0);
       case Factor.iDbType of
       0:dbInit := 'dbInit.mssql';
       1:dbInit := 'dbInit.oracle';
       4:dbInit := 'dbInit.db2';
       5:dbInit := 'dbInit.sqlite';
       else
          dbInit := 'dbInit.sql';
       end;
       if not fileExists(tmpPath+dbInit) then Exit;
       AssignFile(F,tmpPath+dbInit);
       Reset(f);
       CurSize :=0;
       try
         TotalSize := FileSize(F)*1024 div 8;
         if TotalSize=0 then TotalSize := 1;
         while not eof(f) do
         begin
           readln(f,s);
           CurSize := CurSize + length(s);
           s := trim(s);
           if s='' then Continue;
           if copy(s,1,10)='--{idbType' then
              begin
                srDbType := StrtoInt(copy(s,12,1));
                Continue;
              end;
           if copy(s,1,2)='--' then Continue;
           if (uppercase(s)='GO') or (s[length(s)]=';') then
              begin
                try
                  if (s[length(s)]=';') then
                     begin
                       delete(s,length(s),1);
                       SQL.Add(s);
                     end;
                  if (SQL.Count>0) and ((srDbType<0) or (srDbType=iDbType)) then
                     begin
                        Factor.ExecSQL(
                            EncodeSQL(SQL.Text)
                            );
                     end;
                  srDbType := -1;
                  if Assigned(onCreateDbCallBack) then
                    onCreateDbCallBack('执行脚本',SQL.Text,CurSize*100 div TotalSize);
                except
                  on E:Exception do
                  begin
                     HasError := true;
                     if Assigned(onCreateDbCallBack) then
                        onCreateDbCallBack('执行错误:'+E.Message,SQL.Text,100);
                     WriteLog('错误:'+E.Message+#13+SQL.Text);
                     if CaptureError then Raise;
                  end;
                end;
                SQL.Clear;
              end
           else
              begin
                if copy(s,1,2)<>'--' then
                   SQL.Add(s);
              end;
         end;
           try
             if (SQL.Count>0) and ((srDbType<0) or (srDbType=iDbType)) then
                Factor.ExecSQL(
                    EncodeSQL(SQL.Text)
                    );
             srDbType := -1;
             SQL.Clear;
             if Assigned(onCreateDbCallBack) then
                onCreateDbCallBack('执行脚本',SQL.Text,100);
           except
             on E:Exception do
               begin
                 HasError := true;
                 if Assigned(onCreateDbCallBack) then
                    onCreateDbCallBack('执行错误:'+E.Message,SQL.Text,100);
                 WriteLog('错误:'+E.Message+#13+SQL.Text);
                 if CaptureError then Raise;
               end;
           end;
         if Assigned(onCreateDbCallBack) then
            onCreateDbCallBack('数据库初始化完毕','',100);
       finally
         CloseFile(f);
         deleteFile(tmpPath+dbInit);
       end;
  finally
    SQL.Free;
  end;
end;

destructor TCreateDbFactory.Destroy;
begin
  FList.Free;
  inherited;
end;
function TCreateDbFactory.EncodeSQL(SQL: string): string;
begin
  result := SQL;
  result := StringReplace(result,'%TBSPPATH%',TBSPPATH,[rfReplaceAll]);
  result := StringReplace(result,'%TBSPPATH1%',TBSPPATH1,[rfReplaceAll]);
  result := StringReplace(result,'%TBSPPATH2%',TBSPPATH2,[rfReplaceAll]);
  result := StringReplace(result,'%TBSPPATH3%',TBSPPATH3,[rfReplaceAll]);
  result := StringReplace(result,'%TBSPPATH4%',TBSPPATH4,[rfReplaceAll]);
  result := StringReplace(result,'%PARTITION%',PARTITION,[rfReplaceAll]);
end;

function TCreateDbFactory.GetiDbType: integer;
begin
  result := Factor.iDbType;
end;

function TCreateDbFactory.GetWindowTmp: string;
begin
  result := FnSystem.GetWinTmp;
end;

procedure TCreateDbFactory.Load(FileName: string);
var s:string;
begin
  try
    UnZipFiles(FileName,WindowTmp,'',s);
    if s='' then Raise Exception.Create('无效数据包文件');
  except
    on E:Exception do
      begin
        WriteLog('打开升级包'+FileName+'失败,错误:'+E.Message);
      end;
  end;
  FList.CommaText := s;
end;

procedure TCreateDbFactory.Run;
var
  i,n,CurSize,TotalSize,j:integer;
  Version,tmpPath,s:string;
  F:TextFile;
  SQL:TStringList;
  rs,fs:TZQuery;
  srDbType:integer;
begin
  HasError := false;
  tmpPath := GetWindowTmp;
  SQL := TStringList.Create;
  srDbType := -1;
  try
  FList.Sort;
  for i:= 0 to FList.Count - 1 do
    begin
      if uppercase(FList[i])='dbinit' then continue;
      SQL.Clear;
      n := length(FList[i])-2-length(ExtractFileExt(FList[i]));
      Version := copy(FList[i],3,n);
      if (
          ((iDbType = 0) and (uppercase(ExtractFileExt(FList[i]))='.MSSQL'))
         or
          ((iDbType = 1) and (uppercase(ExtractFileExt(FList[i]))='.ORACLE'))
         or
          ((iDbType = 3) and (uppercase(ExtractFileExt(FList[i]))='.ACCESS'))
         or
          ((iDbType = 4) and (uppercase(ExtractFileExt(FList[i]))='.DB2'))
         or
          ((iDbType = 5) and (uppercase(ExtractFileExt(FList[i]))='.SQLITE'))
         or
          (uppercase(ExtractFileExt(FList[i]))='.SQL')
         )
         and
         CompareVersion(Version,CurVersion)
      then
         begin
           if Assigned(onCreateDbCallBack) then
              onCreateDbCallBack('版本 db'+Version,'',0);
           AssignFile(F,tmpPath+FList[i]);
           Reset(f);
           CurSize :=0;
           try
             TotalSize := FileSize(F)*1024 div 8;
             if TotalSize=0 then TotalSize := 1;
             while not eof(f) do
             begin
               readln(f,s);
               CurSize := CurSize + length(s);
               s := trim(s);
               if s='' then Continue;
               if copy(s,1,10)='--{idbType' then
                  begin
                    srDbType := StrtoInt(copy(s,12,1));
                    Continue;
                  end;
               if copy(s,1,2)='--' then Continue;
               if (uppercase(s)='GO') or (s[length(s)]=';') then
                  begin
                    try
                      if (s[length(s)]=';') then
                         begin
                           delete(s,length(s),1);
                           SQL.Add(s);
                         end;
                      if (SQL.Count>0) and ((srDbType<0) or (srDbType=iDbType)) then
                          Factor.ExecSQL(
                              EncodeSQL(SQL.Text)
                              );
                      srDbType := -1;
                      if Assigned(onCreateDbCallBack) then
                        onCreateDbCallBack('执行脚本',SQL.Text,CurSize*100 div TotalSize);
                    except
                      on E:Exception do
                      begin
                         HasError := true;
                         if Assigned(onCreateDbCallBack) then
                            onCreateDbCallBack('执行错误:'+E.Message,SQL.Text,100);
                         WriteLog('错误:'+E.Message+#13+SQL.Text);
                         if CaptureError then Raise;
                      end;
                    end;
                    SQL.Clear;
                  end
               else
                  begin
                    if copy(s,1,2)<>'--' then
                       SQL.Add(s);
                  end;
             end;
               try
                 if (SQL.Count>0) and ((srDbType<0) or (srDbType=iDbType)) then
                    Factor.ExecSQL(
                        EncodeSQL(SQL.Text)
                        );
                 srDbType := -1;
                 SQL.Clear;
                 if Assigned(onCreateDbCallBack) then
                    onCreateDbCallBack('执行脚本',SQL.Text,100);
               except
                 on E:Exception do
                   begin
                     HasError := true;
                     if Assigned(onCreateDbCallBack) then
                        onCreateDbCallBack('执行错误:'+E.Message,SQL.Text,100);
                     WriteLog('错误:'+E.Message+#13+SQL.Text);
                     if CaptureError then Raise;
                   end;
               end;
             NewVersion := Version;
             UpdateVersion;
             if Assigned(onCreateDbCallBack) then
                onCreateDbCallBack('执行完毕:当前最新版本'+NewVersion,'',100);
           finally
             CloseFile(f);
             deleteFile(tmpPath+FList[i]);
           end;
         end;
    end;
  finally
    SQL.Free;
  end;
end;

procedure TCreateDbFactory.SetCaptureError(const Value: Boolean);
begin
  FCaptureError := Value;
end;

procedure TCreateDbFactory.SetHasError(const Value: Boolean);
begin
  FHasError := Value;
end;

procedure TCreateDbFactory.SetonCreateDbCallBack(
  const Value: TCreateDbCallBack);
begin
  FonCreateDbCallBack := Value;
end;

procedure TCreateDbFactory.SetPARTITION(const Value: string);
begin
  FPARTITION := Value;
end;

procedure TCreateDbFactory.SetTBSPPATH(const Value: string);
begin
  FTBSPPATH := Value;
end;

procedure TCreateDbFactory.SetTBSPPATH1(const Value: string);
begin
  FTBSPPATH1 := Value;
end;

procedure TCreateDbFactory.SetTBSPPATH2(const Value: string);
begin
  FTBSPPATH2 := Value;
end;

procedure TCreateDbFactory.SetTBSPPATH3(const Value: string);
begin
  FTBSPPATH3 := Value;
end;

procedure TCreateDbFactory.SetTBSPPATH4(const Value: string);
begin
  FTBSPPATH4 := Value;
end;

procedure TCreateDbFactory.UpdateVersion;
var n:integer;
begin
  try
    n := Factor.ExecSQL('update SYS_DEFINE set VALUE='''+NewVersion+''' where TENANT_ID=0 and DEFINE=''DBVERSION''');
    if n=0 then  Factor.ExecSQL('insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''DBVERSION'','''+NewVersion+''',0,''00'',5497000)');
  except
    on E:Exception do
      begin
       // if pos('SYS_DEFINE',E.Message)=0 then
       //    begin
             WriteLog(E.Message);
             Raise;
       //    end;
      end;
  end;
end;

end.
