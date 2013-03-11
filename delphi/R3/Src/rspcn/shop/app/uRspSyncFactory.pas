unit uRspSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs, uSyncFactory, DB;

type

  TRspSyncFactory=class(TSyncFactory)
  public
    procedure downloadGoodsSort;
  end;

var RspSyncFactory:TRspSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,msxml,uRspFactory;

{ TRspSyncFactory }

procedure TRspSyncFactory.downloadGoodsSort;
var
  doc:IXMLDomDocument;
  pubGoodsSortDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
begin
  timestamp := SyncFactory.GetSynTimeStamp('RSP_PUB_GOODSSORT');
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadSort(strtoint(token.tenantId), 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('SORT_ID',ftstring,36,true);
    rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('LEVEL_ID',ftstring,20,true);
    rs.FieldDefs.Add('SORT_NAME',ftstring,30,true);
    rs.FieldDefs.Add('SORT_TYPE',ftInteger,0,true);
    rs.FieldDefs.Add('SORT_SPELL',ftstring,30,true);
    rs.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    pubGoodsSortDownloadResp := Node.firstChild;
    while pubGoodsSortDownloadResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('SORT_ID').AsString := rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'sortId');
        rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'tenantId'));
        rs.FieldByName('LEVEL_ID').AsString := rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'levelId');
        rs.FieldByName('SORT_NAME').AsString := rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'sortName');
        rs.FieldByName('SORT_TYPE').AsInteger := StrtoInt(rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'sortType'));
        rs.FieldByName('SORT_SPELL').AsString := rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'sortSpell');
        if rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'seqNo')='' then
           rs.FieldByName('SEQ_NO').AsInteger := 0
        else
           rs.FieldByName('SEQ_NO').AsInteger := StrtoInt(rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'seqNo'));
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(pubGoodsSortDownloadResp,'timeStamp'));
        rs.Post;
        if rs.FieldByName('TIME_STAMP').AsInteger > maxtimestamp then
           maxtimestamp := rs.FieldByName('TIME_STAMP').AsInteger;
        pubGoodsSortDownloadResp := pubGoodsSortDownloadResp.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSSORT';
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SORT_ID;SORT_TYPE';
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := timestamp;
          Params.ParamByName('SYN_TIME_STAMP').Value := timestamp;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          SyncFactory.SetSynTimeStamp('RSP_PUB_GOODSSORT',maxtimestamp,'#');
        finally
          Params.free;
        end;
        // ±¾µØ±£´æ
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSSORT';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SORT_ID;SORT_TYPE';
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timestamp;
            Params.ParamByName('SYN_TIME_STAMP').Value := timestamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          finally
            Params.free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
  dllGlobal.GetZQueryFromName('PUB_GOODSSORT').Close;
end;

initialization
  RspSyncFactory := TRspSyncFactory.Create;
finalization
  RspSyncFactory.Free;
end.
