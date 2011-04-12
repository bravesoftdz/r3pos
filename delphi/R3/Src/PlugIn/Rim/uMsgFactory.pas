unit uMsgFactory;

interface
uses windows,SysUtils,Classes,EncdDecd,ZLib,WsdlComm,ZDataSet,Forms,SoapInvestigate,Variants,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc;
procedure DoSyncQuestion(tid,lscode:string);
implementation
procedure DoSyncQuestion(tid,lscode:string);
var
  txt:widestring;
  xmlDoc:TXMLDocument;
  Node,P1,P2,V:IXMLNode;
  ErrorInfo,msg:string;
  i:integer;
  OrgId,ComId:string;
  rs:TZQuery;
  iRet:OleVariant;
begin
  OrgId := GetOrgId(lsCode);
  ComId := GetComId(lsCode);
  txt:='<INVESTIGATE_INFO_IN> '+
       '   <INVESTIGATE_INFO '+
       '    CUST_ID='+QuotedStr(OrgId)+
       '    LOGIN_DATE ='+QuotedStr(FormatDateTime('YYYYMMDD',Now))+
       '    COM_ID ='+QuotedStr(ComId)+
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
     if V.Attributes['REC_ACK']<>'0000' then// ���� 0000 ����ִ�гɹ�
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
                if GPlugIn.ExecSQL('insert into MSC_QUESTION()')<>0 then Raise Exception.Create(StrPas(GPlugIn.GetLastError));
              end;
           AObj := TRecord_.Create;
           AObj.AddField('INVEST_ID',V.Attributes['INVEST_ID']);
           AObj.AddField('INVEST_NAME',V.Attributes['INVEST_NAME']);
           AObj.AddField('VOLUME_ID',V.Attributes['VOLUME_ID']);
           edtQList.Properties.Items.AddObject(AObj.FieldbyName('INVEST_NAME').AsString,AObj);
         end;
       end;
     finally
       rs.free;
     end;
     except
       on E:Exception do
          begin
            GPlugIn.WriteLogFile('<�ʾ����>'+Pchar(e.Message)+ 'xml='+xmlDoc.XML.Text);
            Raise;
          end;
     end;
  finally
    xmlDoc.free;
  end;
end;
end.
