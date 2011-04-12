unit uMsgFactory;

interface
uses windows,SysUtils,Classes,EncdDecd,ZLib,WsdlComm,
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

     Node :=  XMLDocument1.DocumentElement;
     P1 := Node.ChildNodes.First;
     V := P1.ChildNodes.First;
     ErrorInfo:= V.Attributes['MSG'];
     if V.Attributes['REC_ACK']<>'0000' then// 返回 0000 才是执行成功
        Raise Exception.Create(Msg);

     P1 := Node.ChildNodes.Last;
     if P1<>nil then
     begin
       for i:=0 to  P1.ChildNodes.Count-1 do
       begin
         V := P1.ChildNodes[i];
         if V.Attributes['INVEST_ID']=nil then continue;

         

         AObj := TRecord_.Create;
         AObj.AddField('INVEST_ID',V.Attributes['INVEST_ID']);
         AObj.AddField('INVEST_NAME',V.Attributes['INVEST_NAME']);
         AObj.AddField('VOLUME_ID',V.Attributes['VOLUME_ID']);
         edtQList.Properties.Items.AddObject(AObj.FieldbyName('INVEST_NAME').AsString,AObj);
       end;
     end;
     except
       on E:Exception do
          begin
            GPlugIn.WriteLogFile('<问卷调查>'+Pchar(e.Message)+ 'xml='+xmlDoc.XML.Text);
            Raise;
          end;
     end;
  finally
    xmlDoc.free;
  end;
end;
end.
