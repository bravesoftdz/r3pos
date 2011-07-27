library RimIVTPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.
}

uses
  SysUtils,
  Classes,
  ZBase,Math,
  uFnUtil,
  ZDataSet,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';

{$R *.res}
//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;
//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;
//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := '问卷调查同步插件';
end;
//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 807;
end;
//RSP调用插件时执行此方法
//由R3程序调用，只同步本门店的
function DoExecute(Params:Pchar;var Data:OleVariant):Integer; stdcall;
procedure SyncInvest(tid,sid,qid:string);
var
  str,ComID,CustID,s,imust: string;
  rs,tmp,tmp1: TZQuery;
  r,iDbType:integer;
  mid:string;
begin
  rs:=TZQuery.Create(nil);
  tmp:=TZQuery.Create(nil);
  tmp1:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      if OpenData(GPlugIn, rs) then
      begin
        ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
      if rs.IsEmpty then Raise Exception.Create('在RIM中没找到此客户');
      GPlugIn.iDbType(iDbType);
      if GPlugIn.BeginTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
      try
        GPlugIn.iDbType(iDbType);
        mid := formatDatetime('YYYYMMDDHHNNSS',now())+inttostr(Random(9999999999999999));
        str :=
         'insert into CC_MYINVESTIGATE(MYINVEST_ID,INVEST_ID,VOLUME_ID,INVEST_DATE,INVEST_TIME,CUST_ID) '+
         'select '+mid+',A.INVEST_ID,A.VOLUME_ID,'''+formatDatetime('YYYYMMDD',date())+''','''+formatDatetime('HH:NN:SS',now())+''','''+custid+''' '+
         'from CC_INVESTIGATE A,MSC_QUESTION B,MSC_INVEST_LIST C where B.TENANT_ID='+tid+' and B.COMM_ID=A.INVEST_ID '+
         'and B.QUESTION_ID='''+qid+''' and B.TENANT_ID=C.TENANT_ID and B.QUESTION_ID=C.QUESTION_ID and C.QUESTION_FEEDBACK_STATUS=1 and C.QUESTION_ANSWER_STATUS=1 and C.SHOP_ID='''+sid+''' '+
         'and not Exists(select * from CC_MYINVESTIGATE where INVEST_ID=A.INVEST_ID and CUST_ID='''+custid+''') ';
        if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        if r>0 then //初始化题目
        begin
          str :=
           'insert into CC_MYINVEST_SUBJECT(MYSUBJECT_ID,MYINVEST_ID,SUBJECT_ID,MYOPTION_ID) '+
           'select '''+formatDatetime('YYYYMMDDHHNNSS',now())+inttostr(Random(9999999999999999))+''','''+mid+''',B.COMM_ID,A.ANSWER_VALUE from MSC_INVEST_ANSWER A,MSC_QUESTION_ITEM B '+
           'where A.TENANT_ID=B.TENANT_ID and A.QUESTION_ID=B.QUESTION_ID and A.QUESTION_ITEM_ID=B.QUESTION_ITEM_ID and A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.QUESTION_ID='''+qid+'''';
           if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          str :=
           'update MSC_INVEST_LIST set QUESTION_FEEDBACK_STATUS=2 where TENANT_ID='+tid+' and SHOP_ID='''+sid+''' and QUESTION_ID='''+qid+''' ';
           if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        end;

        if GPlugIn.CommitTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
      except
        if GPlugIn.RollbackTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        Raise
      end;
  finally
    tmp1.Free;
    tmp.Free;
    rs.Free;
  end;
end;
//tid 企业号
//sid 门店号
procedure SyncQuestion(tid,sid:string);
var
  str,ComID,CustID,s,imust: string;
  rs,tmp,tmp1: TZQuery;
  r,iDbType:integer;
  mid:string;
begin
  rs:=TZQuery.Create(nil);
  tmp:=TZQuery.Create(nil);
  tmp1:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      if OpenData(GPlugIn, rs) then
      begin
        ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
      if rs.IsEmpty then Raise Exception.Create('在RIM中没找到此客户');
      GPlugIn.iDbType(iDbType);
      rs.Close;
      rs.SQL.Text :=
         'select INVEST_ID,VOLUME_ID from CC_INVESTIGATE A where INVEST_GROUP=''01'' '+
         'and not Exists(select * from MSC_INVEST_LIST B where B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' and B.COMM_ID=A.INVEST_ID)';
      OpenData(GPlugIn, rs);
      rs.First;                                  
      while not rs.Eof do
      begin
        if GPlugIn.BeginTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        try
          GPlugIn.iDbType(iDbType);
          mid := newid(sid);
          str :=
           'insert into MSC_QUESTION(TENANT_ID,QUESTION_ID,QUESTION_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,QUESTION_SOURCE,ISSUE_USER,QUESTION_TITLE,ANSWER_FLAG,QUESTION_ITEM_AMT,REMARK,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
           'select '+tid+','''+mid+''',''1'','+formatDatetime('YYYYMMDD',Date())+',0,A.INVEST_NAME,''system'',B.VOLUME_NAME,''2'',0,B.VOLUME_NOTE,''2099-12-31'',A.INVEST_ID,''00'','+GetTimeStamp(iDbType)+' '+
           'from CC_INVESTIGATE A,CC_VOLUME B where A.VOLUME_ID=B.VOLUME_ID and A.ORGAN_ID=B.ORGAN_ID '+
           'and A.INVEST_ID='''+rs.Fields[0].asString+''' and A.ORGAN_ID='''+ComId+''' and not Exists(select * from MSC_QUESTION where TENANT_ID='+tid+' and COMM_ID=A.INVEST_ID) ';
          if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          if r>0 then //初始化题目
          begin
            tmp.Close;
            tmp.SQL.Text := 'select SUBJECT_ID,SUBJECT_TITLE,SUBJECT_TYPE,IS_MUST,NOTE from CC_INVEST_ITEM where VOLUME_ID='''+rs.Fields[1].AsString+'''';
            OpenData(GPlugIn, tmp);
            tmp.First;
            while not tmp.Eof do
            begin
              tmp1.Close;
              tmp1.SQL.Text := 'select OPTION_ID,OPTION_TITLE from CC_INVEST_OPTION where SUBJECT_ID='''+tmp.Fields[0].AsString+'''';
              OpenData(GPlugIn, tmp1);
              s := '';
              tmp1.First;
              while not tmp1.Eof do
                begin
                  if s<>'' then s := s + ',';
                  s := s + '"'+tmp1.Fields[0].AsString+'='+tmp1.Fields[1].AsString+'"';
                  tmp1.Next;
                end;
              if tmp.Fields[3].AsString ='Y' then imust := '1' else imust := '2';
              str :=
               'insert into MSC_QUESTION_ITEM(TENANT_ID,QUESTION_ID,QUESTION_ITEM_ID,SEQ_NO,QUESTION_ITEM_TYPE,QUESTION_IS_MUST,QUESTION_INFO,QUESTION_OPTIONS,COMM_ID)'+
               'values('+tid+','''+mid+''','''+newid(sid)+''','+inttostr(tmp.RecNo)+','''+inttostr(tmp.Fields[2].asInteger+1)+''','''+imust+''','''+tmp.Fields[1].AsString+''','''+s+''','''+tmp.Fields[0].AsString+''')';
              if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
              tmp.Next;
            end;
            str := 'update MSC_QUESTION set QUESTION_ITEM_AMT='+inttostr(tmp.recordCount)+' where TENANT_ID='+tid+' and QUESTION_ID='''+mid+'''';
            if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          end;

          str :=
            'insert into MSC_INVEST_LIST(TENANT_ID,QUESTION_ID,SHOP_ID,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID,COMM,TIME_STAMP) '+
            'values('+tid+','''+mid+''','''+sid+''',''1'',''2'','''+rs.Fields[0].AsString+''',''00'','+GetTimeStamp(iDbType)+')';
          if GPlugIn.ExecSQL(pchar(str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          if GPlugIn.CommitTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        except
          if GPlugIn.RollbackTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          Raise
        end;
      rs.Next;
      end;
  finally
    tmp1.Free;
    tmp.Free;
    rs.Free;
  end;
end;
var ParamList:TftParamList;
begin
  try
    //开始执行插件该做的工作.
    ParamList := TftParamList.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      if ParamList.ParamByName('flag').AsInteger <0 then //计划任务执行
         begin
         end
      else
         begin
            if ParamList.ParamByName('flag').AsInteger=2 then
               SyncInvest(ParamList.ParambyName('TENANT_ID').asString,ParamList.ParambyName('SHOP_ID').asString,ParamList.ParambyName('QUESTION_ID').asString)
            else
               SyncQuestion(ParamList.ParambyName('TENANT_ID').asString,ParamList.ParambyName('SHOP_ID').asString);
         end;
    finally
      ParamList.Free;
    end;
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2001;
      end;
  end;
end;
//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;
exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin
end.
