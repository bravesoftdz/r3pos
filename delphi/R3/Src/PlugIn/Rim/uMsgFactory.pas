unit uMsgFactory;

interface
uses windows,SysUtils,Classes,EncdDecd,ZLib,WsdlComm,ZDataSet,Forms,SoapInvestigate,SoapGetMessage,SoapRimSuggestionService,SoapRimImpeachService,Variants,DB,uFnUtil,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc;
procedure DoSyncMessage(tid,lscode:string);
procedure DoSyncQuestion(tid,lscode:string);
procedure DoSaveQuestion(tid,lscode,qid:string);
procedure DoSaveImpeach(tid,lscode,rid:string);
implementation
procedure DoSyncMessage(tid,lscode:string);
var
 txt:WideString;
 Node,P1,P2,V:IXMLNode;
 XMLDoc: TXMLDocument;
 ErrorInfo,tmpStr,Msg:string;
 i:integer;
 RimCaTenant:TRimCaTenant;
 rs:TZQuery;
begin
   RimCaTenant := GetRimInfo(tid,lscode);
   if RimCaTenant.CustId='' then
     begin
       GPlugIn.WriteLogFile(Pchar('在RIM中没找到'+lscode));
       Exit;
     end;
   txt:=
   '<MESSAGE_INFO_IN> '+
	 '<MESSAGE_INFO '+
	 '	CUST_ID='+QuotedStr(RimCaTenant.CustId)+
	 '	LOGIN_DATE='+QuotedStr(formatDatetime('YYYYMMDD',Date()))+' '+
	 '	COM_ID='+QuotedStr(RimCaTenant.ComId)+' '+
	 '	> '+
   '  </MESSAGE_INFO> '+
   '  </MESSAGE_INFO_IN> ';
   rs := TZQuery.Create(nil);
   XMLDoc := TXMLDocument.Create(Application);
   try
     XMLDoc.XML.Text := decodeZipBase64(GetMessageService(true,url+'/GetMessage?wsdl',nil).getMessage(txt));
     XMLDoc.Active :=true;
     Node :=  XMLDoc.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     msg:=pchar('消息公告：'+ErrorInfo);
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);

     P1 := Node.ChildNodes.Last;
     V := P1.ChildNodes.First;

     rs.FieldDefs.Add('TENANT_ID',ftInteger,0);
     rs.FieldDefs.Add('MSG_ID',ftString,36);
     rs.FieldDefs.Add('MSG_CLASS',ftString,36);
     rs.FieldDefs.Add('ISSUE_DATE',ftInteger,0);
     rs.FieldDefs.Add('ISSUE_TENANT_ID',ftInteger,0);
     rs.FieldDefs.Add('MSG_SOURCE',ftString,50);
     rs.FieldDefs.Add('ISSUE_USER',ftString,36);
     rs.FieldDefs.Add('MSG_TITLE',ftString,50);
     rs.FieldDefs.Add('MSG_CONTENT',ftString,500);
     rs.FieldDefs.Add('END_DATE',ftString,10);
     rs.FieldDefs.Add('COMM_ID',ftString,36);
     rs.CreateDataSet;
     /// 遍历开始
     for i:=0 to  P1.ChildNodes.Count-1 do
       begin
         V := P1.ChildNodes[i];
         if V.Attributes['MSG_ID']=null then Continue;
         rs.Append;
         rs.FieldByName('TENANT_ID').AsInteger := strtoint(tid);
         rs.FieldByName('MSG_ID').AsString := V.Attributes['MSG_ID'];
         rs.FieldByName('MSG_CLASS').AsString := '0';
         rs.FieldByName('MSG_TITLE').AsString := V.Attributes['TITLE'];
         rs.FieldByName('MSG_CONTENT').AsString := V.Attributes['CONTENT'];
         rs.FieldByName('ISSUE_DATE').AsInteger := StrtoInt(V.Attributes['USE_DATE']);
         if not VarisNull(V.Attributes['INVALID_DATE']) then
            rs.FieldByName('END_DATE').AsString := formatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(V.Attributes['INVALID_DATE']));
         rs.Post;
       end;  // end j
       if GPlugIn.UpdateBatch(rs.Delta,'TMessage')<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));

   finally
     XMLDoc.Free;
     rs.Free;
   end;
end;

procedure DoSyncQuestion(tid,lscode:string);
var
  RimCaTenant:TRimCaTenant;
function GetYesNo(s:string):string;
begin
  if s='Y' then result := '1' else result := '2';
end;
procedure InsertQuestion(id,title,is_repeat:string);
var
  txt:widestring;
  xmlDoc:TXMLDocument;
  Node,P1,P2,V:IXMLNode;
  ErrorInfo,msg,gid,ops:string;
  i,j,iret:integer;
  h,d:TZQuery;
begin
  txt:='<INVESTIGATE_INFO_IN> '+
       '   <INVESTIGATE_INFO '+
       '    INVEST_ID='+QuotedStr(ID)+
       '    COM_ID ='+QuotedStr(RimCaTenant.ComId)+
       '    > '+
       '  </INVESTIGATE_INFO> '+
       ' </INVESTIGATE_INFO_IN> ';
  xmlDoc:=TXMLDocument.Create(Application);
  h := TZQuery.Create(nil);
  d := TZQuery.Create(nil);
  try
    xmlDoc.XML.Text :=decodeZipBase64(GetInvestigateService(true,url+'/Investigate?wsdl',nil).getVolume(txt));
    xmlDoc.Active :=true;

     Node :=  xmlDoc.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     msg:=pchar('打开题库：'+ErrorInfo);
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);
    //初始化表结构
    h.FieldDefs.Add('TENANT_ID',ftInteger,0);
    h.FieldDefs.Add('QUESTION_ID',ftString,36);
    h.FieldDefs.Add('QUESTION_CLASS',ftString,36);
    h.FieldDefs.Add('ISSUE_DATE',ftInteger,0);
    h.FieldDefs.Add('ISSUE_TENANT_ID',ftInteger,0);
    h.FieldDefs.Add('QUESTION_SOURCE',ftString,50);
    h.FieldDefs.Add('ISSUE_USER',ftString,36);
    h.FieldDefs.Add('QUESTION_TITLE',ftString,50);
    h.FieldDefs.Add('ANSWER_FLAG',ftInteger,0);
    h.FieldDefs.Add('QUESTION_ITEM_AMT',ftInteger,0);
    h.FieldDefs.Add('REMARK',ftString,100);
    h.FieldDefs.Add('END_DATE',ftString,10);
    h.FieldDefs.Add('COMM_ID',ftString,50);
    h.CreateDataSet;

    d.FieldDefs.Add('TENANT_ID',ftInteger,0);
    d.FieldDefs.Add('QUESTION_ID',ftString,36);
    d.FieldDefs.Add('QUESTION_ITEM_ID',ftString,36);
    d.FieldDefs.Add('SEQ_NO',ftInteger,0);
    d.FieldDefs.Add('QUESTION_ITEM_TYPE',ftString,1);
    d.FieldDefs.Add('QUESTION_INFO',ftString,200);
    d.FieldDefs.Add('QUESTION_OPTIONS',ftString,400);
    d.FieldDefs.Add('COMM_ID',ftString,50);
    d.CreateDataSet;

    if GPlugIn.BeginTrans<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
    try
      gid := NewId(tid+'0001');
      P1 := Node.ChildNodes.Last;
      h.Append;
      h.FieldByName('TENANT_ID').AsInteger := strtoint(tid);
      h.FieldByName('QUESTION_ID').AsString := gid;
      h.FieldByName('QUESTION_CLASS').AsString := '1';
      h.FieldByName('ISSUE_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',Date()));
      h.FieldByName('ISSUE_TENANT_ID').AsInteger := strtoint(RimCaTenant.P_TENANT_ID);
      h.FieldByName('QUESTION_SOURCE').AsString := RimCaTenant.P_TENANT_NAME;
      h.FieldByName('ISSUE_USER').AsString := 'system';
      h.FieldByName('QUESTION_TITLE').AsString := title;
      h.FieldByName('ANSWER_FLAG').AsInteger := strtoint(IS_REPEAT);
      h.FieldByName('REMARK').AsString := P1.Attributes['NOTE'];
      h.FieldByName('COMM_ID').AsString := V.Attributes['VOLUME_ID'];
      for i:=0 to  P1.ChildNodes.Count-1 do
       begin
         V := P1.ChildNodes[i];
         if V.Attributes['SUBJECT_ID']=NULL then Continue;
         ops := '';
         for j:= 0 to V.ChildNodes.Count - 1 do
           begin
             P2 := V.ChildNodes[j];
             if ops<>'' then ops := ops + ',';
             ops := ops +'"'+P2.Attributes['OPTION_ID']+'='+P2.Attributes['OPTION_TITLE']+'"';
           end;
         d.Append;
         d.FieldByName('TENANT_ID').AsInteger := strtoint(tid);
         d.FieldByName('QUESTION_ID').AsString := gid;
         d.FieldByName('QUESTION_ITEM_ID').AsString := NewId(tid+'0001');
         d.FieldByName('SEQ_NO').AsInteger := i+1;
         d.FieldByName('QUESTION_ITEM_TYPE').AsString := inttostr(StrtoIntDef(V.Attributes['SUBJECT_TYPE'],0)+1);
         d.FieldByName('QUESTION_INFO').AsString := V.Attributes['SUBJECT_TITLE'];
         d.FieldByName('QUESTION_OPTIONS').AsString := ops;
         d.FieldByName('COMM_ID').AsString := V.Attributes['SUBJECT_ID'];
         d.Post;
       end;
       h.FieldByName('QUESTION_ITEM_AMT').AsInteger := d.RecordCount;
       h.Post;
       if GPlugIn.UpdateBatch(h.Delta,'TQuestion')<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
       if GPlugIn.UpdateBatch(d.Delta,'TQuestionItem')<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
       if GPlugIn.ExecSQL(
           pchar('insert into MSC_INVEST_LIST(TENANT_ID,QUESTION_ID,SHOP_ID,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID,COMM,TIME_STAMP) value('+tid+','''+gid+''','''+tid+'0001'',''1'',''2'','''+id+''',''00'','+inttostr(trunc((now()-40542.0)*86400))+')')
               ,iret)<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
       if GPlugIn.CommitTrans<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
     except
       on E:Exception do
          begin
            if GPlugin.RollbackTrans<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
            GPlugIn.WriteLogFile(pchar('<问卷调查>'+e.Message+ 'xml='+xmlDoc.XML.Text));
            Raise;
          end;
     end;
  finally
    h.free;
    d.free;
    xmlDoc.free;
  end;
end;
var
  txt:widestring;
  xmlDoc:TXMLDocument;
  Node,P1,P2,V:IXMLNode;
  ErrorInfo,msg:string;
  i:integer;
  rs:TZQuery;
  iRet:OleVariant;
begin
  RimCaTenant := GetRimInfo(tid,lscode);
  if RimCaTenant.CustId='' then
     begin
       GPlugIn.WriteLogFile(pchar('在RIM中没找到'+lscode));
       Exit;
     end;
  txt:='<INVESTIGATE_INFO_IN> '+
       '   <INVESTIGATE_INFO  '+
       '    CUST_ID='+QuotedStr(RimCaTenant.CustId)+
       '    LOGIN_DATE ='+QuotedStr(FormatDateTime('YYYYMMDD',Now))+
       '    COM_ID ='+QuotedStr(RimCaTenant.ComId)+
       '    > '+
       '  </INVESTIGATE_INFO> '+
       ' </INVESTIGATE_INFO_IN> ';
  xmlDoc:=TXMLDocument.Create(Application);
  try
    try
     xmlDoc.XML.Text :=decodeZipBase64(GetInvestigateService(true,url+'/Investigate?wsdl',nil).getInvestigate(txt));
     xmlDoc.Active :=true;

     Node :=  xmlDoc.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);
     rs := TZQuery.Create(nil);
     try
       P1 := Node.ChildNodes.Last;
       if P1<>nil then
       begin
         for i:=0 to  P1.ChildNodes.Count-1 do
         begin
           V := P1.ChildNodes[i];
           if VarIsNull(V.Attributes['INVEST_ID']) then continue;
           rs.close;
           rs.SQL.Text := 'select count(*) from MSC_QUESTION where TENANT_ID='+tid+' and COMM_ID='''+V.Attributes['INVEST_ID']+'''';
           if GPlugIn.Open(pchar(rs.SQL.Text),iRet)<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
           rs.Data := iRet;
           if rs.Fields[0].AsInteger = 0 then
              begin
                InsertQuestion(V.Attributes['INVEST_ID'],V.Attributes['INVEST_NAME'],GetYesNo(V.Attributes['IS_REPEAT']));
              end;
         end;
       end;
     finally
       rs.free;
     end;
     except
       on E:Exception do
          begin
            GPlugIn.WriteLogFile(pchar('<问卷调查>'+Pchar(e.Message)+ 'xml='+xmlDoc.XML.Text));
            Raise;
          end;
     end;
  finally
    xmlDoc.free;
  end;
end;
procedure DoSaveQuestion(tid,lscode,qid:string);
var
  txt:widestring;
  XMLDoc:TXMLDocument;
  Node,P1,P2,V:IXMLNode;
  ErrorInfo,msg:string;
  i:integer;
  IsHas:Boolean;
  sRet:OleVariant;
  rs:TZQuery;
  v1,v2:TStringList;
  RimCaTenant:TRimCaTenant;
begin
  RimCaTenant := GetRimInfo(tid,lscode);
  if RimCaTenant.CustId='' then Exit;
  rs := TZQuery.Create(nil);
  v1 := TStringList.Create;
  v2 := TStringList.Create;
  try
  if GPlugIn.Open(pchar(
   'select D.COMM_ID as INVEST_ID,A.COMM_ID as VOLUME_ID,B.COMM_ID as SUBJECT_ID,C.ANSWER_VALUE,C.ANSWER_DISPLAY from MSC_QUESTION A,MSC_QUESTION_ITEM B,MSC_INVEST_ANSWER C,MSC_INVEST_LIST D where '+
   ' A.TENANT_ID=B.TENANT_ID and A.QUESTION_ID=B.QUESTION_ID '+
   ' and '+
   ' A.TENANT_ID=C.TENANT_ID and A.QUESTION_ID=C.QUESTION_ID '+
   ' and '+
   ' A.TENANT_ID=D.TENANT_ID and A.QUESTION_ID=D.QUESTION_ID and C.SHOP_ID=D.SHOP_ID '+
   ' and '+
   ' C.SHOP_ID='''+tid+'0001'' and A.TENANT_ID='+tid+' and A.QUESTION_ID='''+qid+'''')
   ,sRet)<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
  rs.Data := sRet;
  txt:='<?xml version=''1.0''	encoding=''gb2312'' standalone=''no''?> '+
       '<VOLUME_INFO_IN> '+
       '   <VOLUME_INFO '+
       '    INVEST_ID ='+QuotedStr(rs.FieldbyName('INVEST_ID').AsString)+
       '    VOLUME_ID ='+QuotedStr(rs.FieldbyName('VOLUME_ID').AsString)+
       '    INVEST_DATE ='+QuotedStr(FormatDateTime('YYYYMMDD',Now))+
       '    INVEST_TIME ='+QuotedStr(FormatDateTime('HHNNSS',Now))+
       '    NOTE ='+QuotedStr('')+
       '    IP ='+QuotedStr('')+
       '    CUST_ID ='+QuotedStr(RimCaTenant.CustId)+
       '    > ';
  IsHas := false;
  rs.First;
  while not rs.Eof do
    begin
      txt := txt +
        '<SUBJECT_INFO SUBJECT_ID='+QuotedStr(rs.FieldbyName('SUBJECT_ID').AsString)+'>';
      V1.CommaText := rs.FieldbyName('ANSWER_VALUE').AsString;
      V2.CommaText := rs.FieldbyName('ANSWER_DISPLAY').AsString;
      for i:=0 to V1.Count -1 do
        begin
         txt := txt +
            '<OPTION_INFO OPTION_ID='+QuotedStr(V1[I])+' OPTION_TITLE='+QuotedStr(V2[I])+'/>';
        end;
      txt := txt +
        '</SUBJECT_INFO>';
      rs.Next;
    end;
  txt := txt +
       '  </VOLUME_INFO> '+
       ' </VOLUME_INFO_IN> ';
  finally
    rs.free;
    v1.free;
    v2.free;
  end;
  XMLDoc:=TXMLDocument.Create(Application);
  try
     XMLDoc.XML.Text :=decodeZipBase64(GetInvestigateService(true,url+'/Investigate?wsdl',nil).saveVolume(txt));
     XMLDoc.Active :=true;
     Node :=  XMLDoc.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     msg:=pchar('上传问卷：'+ErrorInfo);
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);
  finally
    XMLDoc.free;
  end;
end;
procedure DoSaveImpeach(tid,lscode,rid:string);
var txt:widestring;
  XMLDocument1:TXMLDocument;
  Node,P1,V:IXMLNode;
  ErrorInfo,msg:string;
  i:integer;
  rs:TZQuery;
  sRet:OleVariant;
  RimCaTenant:TRimCaTenant;
begin
  RimCaTenant := GetRimInfo(tid,lscode);
  if RimCaTenant.CustId='' then Exit;
  rs := TZQuery.Create(nil);
  try
  if GPlugIn.Open(pchar('select CONTENT,IMPEACH_CLASS,IS_REPEAT,IS_URGENCY,IS_REPLY from MSC_IMPEACH where TENANT_ID='+tid+' and ROWS_ID='''+rid+'''')
   ,sRet)<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
  rs.Data := sRet;
  if rs.IsEmpty then Exit;
  if rs.FieldbyName('IMPEACH_CLASS').AsString = '1' then
  txt:='<?xml version=''1.0''	encoding=''gb2312'' standalone=''no''?> '+
       '<IMPEACH_ADD_IN> '+
       '   <IMPEACH '+
       '    CUST_ID='+QuotedStr(RimCaTenant.CustId)+
       '    IS_REPEAT ='+QuotedStr(rs.FieldbyName('IS_REPEAT').AsString)+
       '    IS_URGENCY ='+QuotedStr(rs.FieldbyName('IS_URGENCY').AsString)+
       '    IS_REPLY ='+QuotedStr(rs.FieldbyName('IS_REPLY').AsString)+
       '     ><CONTENT>'+QuotedStr(rs.FieldbyName('CONTENT').AsString)+'</CONTENT>'+
       '  </IMPEACH> '+
       ' </IMPEACH_ADD_IN> '
  else
  txt:='<?xml version=''1.0''	encoding=''gb2312'' standalone=''no''?> '+
       '<SUGGESTION_ADD_IN> '+
       '   <SUGGESTION '+
       '    CUST_ID='+QuotedStr(RimCaTenant.CustId)+
       '     ><CONTENT>'+QuotedStr(rs.FieldbyName('CONTENT').AsString)+'</CONTENT>'+
       '  </SUGGESTION> '+
       ' </SUGGESTION_ADD_IN> ';
  XMLDocument1:=TXMLDocument.Create(Application);
  try
     if rs.FieldbyName('IMPEACH_CLASS').AsString = '1' then
        XMLDocument1.XML.Text :=decodeZipBase64(GetRimImpeachService(true,url+'/RimImpeachService?wsdl',nil).AddImpeach(txt))
     else
        XMLDocument1.XML.Text :=decodeZipBase64(GetRimSuggestionService(true,url+'/RimSuggestionService?wsdl',nil).AddSuggestion(txt));
     XMLDocument1.Active :=true;

     Node :=  XMLDocument1.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     msg:=pchar('保存建议表扬：'+ErrorInfo);
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);
  finally
    XMLDocument1.free;
  end;
  finally
    rs.free;
  end;
end;
end.
