{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uIVTFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TIVTSyncFactory=class(TRimSyncFactory)
  private
    DeubugFlag: Boolean;
    //写调试日志
    function WriteToDebuLog(DebugText: string): Boolean; overload; //调试用

    //返回OPTION_IDS
    function GetOPTION_IDS(SUBJECT_ID: string): string;
    //下载写入一个问卷[]
    function Write_Question_Page(Volume_ID,tid,sid,Mid: string): string;

    //同步调查
    function SyncInvest(tid,sid,qid:string): integer;
    //同步问卷: tid 企业号  sid 门店号
    function SyncQuestion(tid,sid:string): integer; //问卷
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

{ TIVTSyncFactory }

function TIVTSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
  rs: TZQuery;
begin
  result:=-1;
  PlugInID:='807';
  DeubugFlag:=FileExists('debug.bug');
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记[]

  if SyncType<0 then //计划任务执行
  begin

  end else
  begin
    RimParam.ComID:='';
    RimParam.CustID:='';
    RimParam.TenID:=trim(Params.ParambyName('TENANT_ID').asString);
    RimParam.ShopID:=trim(Params.ParambyName('SHOP_ID').asString);
    try
      rs:=TZQuery.Create(nil);
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+RimParam.TenID+' and B.SHOP_ID='''+RimParam.ShopID+''' ';
      if Open(rs) then
      begin
        RimParam.ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        RimParam.CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
      if rs.IsEmpty then Raise Exception.Create('在RIM中没找到此客户[零售户]');
    finally
      rs.Free;
    end;

    if SyncType=2 then  //提交问卷
    begin
      try
        WriteToDebuLog('RimParam.ComID='+RimParam.ComID+';  RimParam.CustID='+RimParam.CustID);
        SyncInvest(RimParam.TenID,RimParam.ShopID,Params.ParambyName('QUESTION_ID').asString)
      finally
      end;
    end else  //下载问卷
      SyncQuestion(RimParam.TenID,RimParam.ShopID);
  end;
end;

//从R3提交问答卷到Rim:
function TIVTSyncFactory.SyncInvest(tid, sid, qid: string): integer;
var
  r,vCount,Idx: integer;
  IsComTrans: Boolean; //是否正常提交事务
  mid,An_Value: string;
  RimSQL1,R3SQL,Str: string;
  DetailQry: TZQuery;   //明细查询Qry
  DetailSQlList: TStringList; //明细语句List
begin
  result:=-1;
  Str:='';
  vCount:=0;
  IsComTrans:=False;
  DetailQry:= TZQuery.Create(nil); //明细Qry
  DetailSQlList:=TStringList.Create; //明细SQL.List
  try
    mid := formatDatetime('YYYYMMDDHHNNSS',now())+inttostr(Random(9999999999999999));
    //插入Rim我的调查表
    RimSQL1 :=
      'insert into CC_MYINVESTIGATE(MYINVEST_ID,INVEST_ID,VOLUME_ID,INVEST_DATE,INVEST_TIME,CUST_ID) '+
      'select '''+mid+''',A.INVEST_ID,A.VOLUME_ID,'''+formatDatetime('YYYYMMDD',date())+''','''+formatDatetime('HH:NN:SS',now())+''','''+RimParam.CustID+''' '+
      ' from CC_INVESTIGATE A,MSC_QUESTION B,MSC_INVEST_LIST C where B.TENANT_ID='+tid+' and B.COMM_ID=A.INVEST_ID '+
      ' and B.QUESTION_ID='''+qid+''' and B.TENANT_ID=C.TENANT_ID and B.QUESTION_ID=C.QUESTION_ID and C.QUESTION_FEEDBACK_STATUS=1 and C.QUESTION_ANSWER_STATUS=1 and C.SHOP_ID='''+sid+''' '+
      ' and not Exists(select * from CC_MYINVESTIGATE D where A.INVEST_ID=D.INVEST_ID and D.CUST_ID='''+RimParam.CustID+''')';

    WriteToDebuLog('RimSQL1='+RimSQL1);  
    //插入Rim我的调查行表
    DetailQry.Close;
    DetailQry.SQL.Text:=
      'select B.COMM_ID,A.ANSWER_VALUE from MSC_INVEST_ANSWER A,MSC_QUESTION_ITEM B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.QUESTION_ID=B.QUESTION_ID and  A.QUESTION_ITEM_ID=B.QUESTION_ITEM_ID and A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.QUESTION_ID='''+qid+'''';
    if Open(DetailQry) then //明细List
    begin
      WriteToDebuLog('After Open... Recout:'+InttoStr(DetailQry.RecordCount));
      DetailQry.First;
      while not DetailQry.Eof do
      begin
        WriteToDebuLog('while not DetailQry.Eof do... CurRecNo:'+InttoStr(DetailQry.RecNo));
        An_Value:=trim(DetailQry.fieldbyName('ANSWER_VALUE').AsString);
        while length(trim(An_Value))>5 do
        begin
          Idx:=Pos(',',An_Value);
          if Idx>0 then //多个有豆号间隔
          begin
            Str:='insert into CC_MYINVEST_SUBJECT(MYSUBJECT_ID,MYINVEST_ID,SUBJECT_ID,MYOPTION_ID) values '+
                 '('''+TBaseSyncFactory.newRandomId()+''','''+mid+''','''+DetailQry.fieldbyName('COMM_ID').AsString+''','''+Copy(An_Value,1,Idx-1)+''')';
            DetailSQlList.Add(Str);
            An_Value:=Copy(An_Value,Idx+1,Length(An_Value)-Idx-1); //删除前面字符
          end else
          begin //单个情况
            Str:='insert into CC_MYINVEST_SUBJECT(MYSUBJECT_ID,MYINVEST_ID,SUBJECT_ID,MYOPTION_ID) values '+
                 '('''+TBaseSyncFactory.newRandomId()+''','''+mid+''','''+DetailQry.fieldbyName('COMM_ID').AsString+''','''+An_Value+''')';
            DetailSQlList.Add(Str);
            An_Value:='';
          end;
        end;
        DetailQry.Next;
      end;             
    end else
      WriteToDebuLog(' not Open...');

    WriteToDebuLog(DetailSQlList.CommaText);
    //更新R3提交状态
    R3SQL:='update MSC_INVEST_LIST set QUESTION_FEEDBACK_STATUS=2 where TENANT_ID='+tid+' and SHOP_ID='''+sid+''' and QUESTION_ID='''+qid+''' ';

    if TWO_PHASE_COMMIT then //启用分布式事务同时更新
    begin
      try
        BeginTrans;
        if ExecSQL(PChar(RimSQL1),r)<>0 then Raise Exception.Create(GetLastError);
        if r>0 then
        begin
         if ExecSQL(DetailSQlList,r)<>0 then Raise Exception.Create(GetLastError); 
         if ExecSQL(pchar(R3SQL),r)<>0 then Raise Exception.Create(GetLastError);
        end;
        CommitTrans;
      except
        RollbackTrans;
        Raise
      end;
    end else
    begin
      //开始写Rim事务
      try
        BeginTrans;
        if ExecSQL(PChar(RimSQL1),r)<>0 then Raise Exception.Create(GetLastError);
        WriteToDebuLog('RimSQL1 Execte 影响记录数：'+InttoStr(r));
        vCount:=r;
        if r>0 then
        begin
          WriteToDebuLog('DetailSQlList Before ');
          if ExecSQL(DetailSQlList,r)<>0 then Raise Exception.Create(GetLastError);
          WriteToDebuLog('DetailSQlList After ');
          vCount:=vCount+r;
        end;
        IsComTrans:=CommitTrans;
      except
        RollbackTrans;
        Raise
      end;
      //开始写R3事务
      WriteToDebuLog('ExecTransSQL  总影响记录数：'+IntToStr(vCount));
      if IsComTrans and (vCount>0) then ExecTransSQL(R3SQL,r);
      WriteToDebuLog('R3SQL  总影响记录数：'+IntToStr(r));
    end;
  finally
    DetailQry.Free;
    DetailSQlList.Free;
  end;
end;

function TIVTSyncFactory.GetOPTION_IDS(SUBJECT_ID: string): string;
var
  Rs: TZQuery;
  ReStr: string;
begin
  ReStr:='';
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text := 'select OPTION_ID,OPTION_TITLE from CC_INVEST_OPTION where SUBJECT_ID='''+SUBJECT_ID+''' ';
    if Open(Rs) then
    begin
      ReStr:= '';
      Rs.First;
      while not Rs.Eof do
      begin
        if ReStr<>'' then ReStr := ReStr + ',';
        ReStr := ReStr + '"'+Rs.Fields[0].AsString+'='+Rs.Fields[1].AsString+'"';
        Rs.Next;
      end;
    end;
  finally
    Rs.Free;
  end;
  result:=ReStr;
end;

//从Rim同步问答卷到R3:  全部插入R3库，直接启动单向连接事务
function TIVTSyncFactory.SyncQuestion(tid, sid: string): integer;
var
  r,vCount:integer;
  str,mid,Msg:string;
  rs: TZQuery;
  Beg_Date,END_Date,IS_REPEAT: string;
begin
  vCount:=0;
  Msg:='';
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=
       'select INVEST_ID,VOLUME_ID,BEGIN_DATE,END_DATE,IS_REPEAT from CC_INVESTIGATE A where A.INVEST_GROUP=''01'' and A.END_DATE>='''+FormatDatetime('YYYYMMDD',Now())+''' '+
       'and not exists(select * from MSC_INVEST_LIST B where A.INVEST_ID=B.COMM_ID and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''')';
    Open(rs);
    rs.First;
    while not rs.Eof do
    begin
      try
        BeginTrans; //开始事务
        mid := newid(sid);
        Beg_Date:=rs.fieldbyName('BEGIN_DATE').AsString;
        END_Date:=trim(rs.fieldbyName('END_DATE').AsString);
        END_Date:=Copy(END_Date,1,4)+'-'+Copy(END_Date,5,2)+'-'+Copy(END_Date,7,2);  //转成[2011-07-29]格式
        if trim(rs.fieldbyName('IS_REPEAT').AsString)='1' then //(1:是,0:否)
          IS_REPEAT:='1'
        else
          IS_REPEAT:='2';

        str :=
          'insert into MSC_QUESTION(TENANT_ID,QUESTION_ID,QUESTION_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,QUESTION_SOURCE,ISSUE_USER,QUESTION_TITLE,ANSWER_FLAG,QUESTION_ITEM_AMT,REMARK,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
          'select '+tid+','''+mid+''',''1'','+Beg_Date+',0,A.INVEST_NAME,''system'',B.VOLUME_NAME,'''+IS_REPEAT+''',0,B.VOLUME_NOTE,'''+END_Date+''',A.INVEST_ID,''00'','+GetTimeStamp(DbType)+' '+
          'from CC_INVESTIGATE A,CC_VOLUME B where A.VOLUME_ID=B.VOLUME_ID and A.ORGAN_ID=B.ORGAN_ID and '+
          ' A.INVEST_ID='''+rs.Fields[0].asString+''' and A.ORGAN_ID='''+RimParam.ComID+''' and not exists(select * from MSC_QUESTION B where A.INVEST_ID=B.COMM_ID and B.TENANT_ID='+tid+')';
        if ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GetLastError);

        //初始化[一张问卷]题目
        if r>0 then
          Write_Question_Page(rs.Fields[1].AsString,tid,sid,Mid);  //VOLUME_ID

        str:='insert into MSC_INVEST_LIST(TENANT_ID,QUESTION_ID,SHOP_ID,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID,COMM,TIME_STAMP) '+
             'values('+tid+','''+mid+''','''+sid+''',1,2,'''+rs.Fields[0].AsString+''',''00'','+GetTimeStamp(DbType)+')';
        if ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GetLastError);
        CommitTrans;
        Inc(vCount);
      except
        on E:Exception do
        begin
          RollbackTrans;
          if Msg='' then Msg:=E.Message else Msg:=Msg+'; '+E.Message;
        end;
      end;
      rs.Next;
    end;
  finally
    if DeubugFlag then
    begin
      if vCount=rs.RecordCount then
        PlugIntf.WriteLogFile(Pchar('<'+sid+'>下载了<'+InttoStr(vCount)+'>'))
      else if vCount<rs.RecordCount then
        PlugIntf.WriteLogFile(Pchar('<'+sid+'>下载了<'+InttoStr(vCount)+'> Error=['+Msg+']'));
    end;
    rs.Free;
  end;
end;

function TIVTSyncFactory.Write_Question_Page(Volume_ID,tid,sid,Mid: string): string;
var
  r: integer;
  str,S,imust: string;
  tmp: TZQuery;
begin
  tmp:=TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text := 'select SUBJECT_ID,SUBJECT_TITLE,SUBJECT_TYPE,IS_MUST,NOTE from CC_INVEST_ITEM where VOLUME_ID='''+Volume_ID+'''';
    Open(tmp);
    tmp.First;
    while not tmp.Eof do
    begin
      S:=GetOPTION_IDS(tmp.fieldbyName('SUBJECT_ID').AsString); //返回答案的选项
      if trim(S)='' then
        Raise Exception.Create('<题目：'+tmp.FieldByName('SUBJECT_TITLE').AsString+'['+tmp.FieldByName('SUBJECT_ID').AsString+']>没有答案选项');
      if tmp.Fields[3].AsString ='Y' then imust := '1' else imust := '2';
      str :=
        'insert into MSC_QUESTION_ITEM(TENANT_ID,QUESTION_ID,QUESTION_ITEM_ID,SEQ_NO,QUESTION_ITEM_TYPE,QUESTION_IS_MUST,QUESTION_INFO,QUESTION_OPTIONS,COMM_ID)'+
        'values('+tid+','''+mid+''','''+newid(sid)+''','+inttostr(tmp.RecNo)+','''+inttostr(tmp.Fields[2].asInteger+1)+''','''+imust+''','''+tmp.Fields[1].AsString+''','''+s+''','''+tmp.Fields[0].AsString+''')';
      if ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GetLastError);
      tmp.Next;
    end;
    str := 'update MSC_QUESTION set QUESTION_ITEM_AMT='+inttostr(tmp.recordCount)+' where TENANT_ID='+tid+' and QUESTION_ID='''+mid+'''';
    if ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GetLastError);
  finally
    tmp.Free;
  end;
end;

function TIVTSyncFactory.WriteToDebuLog(DebugText: string): Boolean;
var
  SaveList: TStringList;
begin
  if DeubugFlag then
  begin
    try
      SaveList:=TStringList.Create;
      if FileExists('debug.log') then
        SaveList.LoadFromFile('debug.log');   
      SaveList.Add(DebugText);
      SaveList.SaveToFile('debug.log'); 
    finally
      SaveList.Free;
    end;
  end;
end;

end.















