unit uRspSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs, uSyncFactory, DB;

type

  TRspSyncFactory=class
  private
    FProTitle:string;
    FProHandle: Hwnd;
    FParams: TftParamList;
    procedure SetProTitle(const Value: string);
    procedure SetProHandle(const Value: Hwnd);
    procedure SetParams(const Value: TftParamList);
    procedure SetProCaption;
    procedure SetProMax(max:integer);
    procedure SetProPosition(position:integer);
  public
    procedure downloadTenants;
    procedure downloadServiceLines;
    procedure downloadRelations;
    procedure downloadUnion;
    procedure downloadModules;
    procedure downloadGoodsSort;
    procedure copyGoodsSort;
    procedure SyncAll;
    property  Params:TftParamList read FParams write SetParams;
    property  ProTitle:string read FProTitle write SetProTitle;
    property  ProHandle:Hwnd read FProHandle write SetProHandle;
  end;

var RspSyncFactory:TRspSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,msxml,uRspFactory,EncDec,
     ufrmSyncData;

procedure TRspSyncFactory.downloadTenants;
var
  doc:IXMLDomDocument;
  caTenantDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
begin
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_CA_TENANT');
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadTenants(strtoint(token.tenantId), 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('LOGIN_NAME',ftstring,50,true);
    rs.FieldDefs.Add('LICENSE_CODE',ftstring,50,true);
    rs.FieldDefs.Add('TENANT_NAME',ftstring,50,true);
    rs.FieldDefs.Add('TENANT_TYPE',ftstring,1,true);
    rs.FieldDefs.Add('SHORT_TENANT_NAME',ftstring,50,true);
    rs.FieldDefs.Add('TENANT_SPELL',ftstring,50,true);
    rs.FieldDefs.Add('LEGAL_REPR',ftstring,20,true);
    rs.FieldDefs.Add('LINKMAN',ftstring,20,true);
    rs.FieldDefs.Add('TELEPHONE',ftstring,30,true);
    rs.FieldDefs.Add('FAXES',ftstring,30,true);
    rs.FieldDefs.Add('HOMEPAGE',ftstring,50,true);
    rs.FieldDefs.Add('ADDRESS',ftstring,50,true);
    rs.FieldDefs.Add('QQ',ftstring,50,true);
    rs.FieldDefs.Add('MSN',ftstring,50,true);
    rs.FieldDefs.Add('POSTALCODE',ftstring,6,true);
    rs.FieldDefs.Add('REMARK',ftstring,100,true);
    rs.FieldDefs.Add('PASSWRD',ftstring,100,true);
    rs.FieldDefs.Add('REGION_ID',ftstring,10,true);
    rs.FieldDefs.Add('SRVR_ID',ftstring,10,true);
    rs.FieldDefs.Add('AUDIT_STATUS',ftstring,1,true);
    rs.FieldDefs.Add('PROD_ID',ftstring,10,true);
    rs.FieldDefs.Add('DB_ID',ftInteger,0,true);
    rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    caTenantDownloadResp := Node.firstChild;
    while caTenantDownloadResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caTenantDownloadResp,'tenantId'));
        rs.FieldByName('LOGIN_NAME').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'loginName');
        rs.FieldByName('LICENSE_CODE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'licenseCode');
        rs.FieldByName('TENANT_NAME').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'tenantName');
        rs.FieldByName('TENANT_TYPE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'tenantType');
        rs.FieldByName('SHORT_TENANT_NAME').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'shortTenantName');
        rs.FieldByName('TENANT_SPELL').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'tenantSpell');
        rs.FieldByName('LEGAL_REPR').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'legalRepr');
        rs.FieldByName('LINKMAN').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'linkman');
        rs.FieldByName('TELEPHONE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'telephone');
        rs.FieldByName('FAXES').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'faxes');
        rs.FieldByName('HOMEPAGE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'homepage');
        rs.FieldByName('ADDRESS').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'address');
        rs.FieldByName('QQ').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'qq');
        rs.FieldByName('MSN').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'msn');
        rs.FieldByName('POSTALCODE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'postalcode');
        rs.FieldByName('REMARK').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'remark');
        rs.FieldByName('PASSWRD').AsString := EncStr(rspFactory.GetNodeValue(caTenantDownloadResp,'passwrd'),ENC_KEY);
        rs.FieldByName('REGION_ID').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'regionId');
        rs.FieldByName('SRVR_ID').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'passwrd');
        rs.FieldByName('AUDIT_STATUS').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'auditStatus');
        rs.FieldByName('PROD_ID').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'prodId');
        rs.FieldByName('DB_ID').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'dbId');
        rs.FieldByName('CREA_DATE').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'creaDate');
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(caTenantDownloadResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(caTenantDownloadResp,'timeStamp'));
        rs.Post;
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
        caTenantDownloadResp := caTenantDownloadResp.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'CA_TENANT';
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID';
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := timestamp;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_CA_TENANT',maxtimestamp);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'CA_TENANT';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID';
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timestamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          finally
            Params.Free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
  dllGlobal.GetZQueryFromName('CA_TENANT').Close;
end;

procedure TRspSyncFactory.downloadServiceLines;
var
  doc:IXMLDomDocument;
  caServiceLineDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
begin
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_CA_RELATION');
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadServiceLines(strtoint(token.tenantId), 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
    rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('RELATION_NAME',ftstring,50,true);
    rs.FieldDefs.Add('RELATION_SPELL',ftstring,50,true);
    rs.FieldDefs.Add('REMARK',ftstring,255,true);
    rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    caServiceLineDownloadResp := Node.firstChild;
    while caServiceLineDownloadResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('RELATION_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caServiceLineDownloadResp,'serviceLineId'));
        rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caServiceLineDownloadResp,'tenantId'));
        rs.FieldByName('RELATION_NAME').AsString := rspFactory.GetNodeValue(caServiceLineDownloadResp,'serviceLineName');
        rs.FieldByName('RELATION_SPELL').AsString := rspFactory.GetNodeValue(caServiceLineDownloadResp,'serviceLineSpell');
        rs.FieldByName('REMARK').AsString := rspFactory.GetNodeValue(caServiceLineDownloadResp,'remark');
        rs.FieldByName('CREA_DATE').AsString := rspFactory.GetNodeValue(caServiceLineDownloadResp,'creaDate');
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(caServiceLineDownloadResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(caServiceLineDownloadResp,'timeStamp'));
        rs.Post;
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
        caServiceLineDownloadResp := caServiceLineDownloadResp.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATION';
          Params.ParamByName('KEY_FIELDS').AsString := 'RELATION_ID';
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := timestamp;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_CA_RELATION',maxtimestamp);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATION';
            Params.ParamByName('KEY_FIELDS').AsString := 'RELATION_ID';
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timestamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          finally
            Params.Free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
end;

procedure TRspSyncFactory.downloadRelations;
var
  doc:IXMLDomDocument;
  caRelationDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
begin
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_CA_RELATIONS');
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadRelations(strtoint(token.tenantId), 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('RELATIONS_ID',ftstring,36,true);
    rs.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
    rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('RELATI_ID',ftInteger,0,true);
    rs.FieldDefs.Add('RELATION_TYPE',ftstring,1,true);
    rs.FieldDefs.Add('LEVEL_ID',ftstring,50,true);
    rs.FieldDefs.Add('RELATION_STATUS',ftstring,1,true);
    rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
    rs.FieldDefs.Add('CHK_DATE',ftstring,10,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    caRelationDownloadResp := Node.firstChild;
    while caRelationDownloadResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('RELATIONS_ID').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'relationsId');
        rs.FieldByName('RELATION_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caRelationDownloadResp,'serviceLineId'));
        rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caRelationDownloadResp,'supTenantId'));
        rs.FieldByName('RELATI_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caRelationDownloadResp,'subTenantId'));
        rs.FieldByName('RELATION_TYPE').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'relationType');
        rs.FieldByName('LEVEL_ID').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'levelId');
        rs.FieldByName('RELATION_STATUS').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'relationStatus');
        rs.FieldByName('CREA_DATE').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'creaDate');
        rs.FieldByName('CHK_DATE').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'chkDate');
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(caRelationDownloadResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(caRelationDownloadResp,'timeStamp'));
        rs.Post;
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
        caRelationDownloadResp := caRelationDownloadResp.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATIONS';
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;RELATION_ID;RELATI_ID';
          Params.ParamByName('KEY_FLAG').AsInteger := 1;
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := timeStamp;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_CA_RELATIONS',maxtimestamp);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATIONS';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;RELATION_ID;RELATI_ID';
            Params.ParamByName('KEY_FLAG').AsInteger := 1;
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timeStamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          finally
            Params.Free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
  dllGlobal.GetZQueryFromName('CA_RELATIONS').Close;
end;

procedure TRspSyncFactory.downloadUnion;
  function GetParent:integer;
  var rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID='+token.tenantId;
      dataFactory.Open(rs);
      result := rs.Fields[0].AsInteger;
    finally
      rs.Free;
    end;
  end;
var
  doc:IXMLDomDocument;
  pubUnionQueryResp,IndexResp,UnionIndex:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs,idx,prc:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
begin
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_PUB_UNION_INFO');
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadUnion(strtoint(token.tenantId), GetParent, 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');

  rs := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  prc := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('UNION_ID',ftstring,36,true);
    rs.FieldDefs.Add('UNION_NAME',ftstring,50,true);
    rs.FieldDefs.Add('UNION_SPELL',ftstring,50,true);
    rs.FieldDefs.Add('INDEX_FLAG',ftstring,1,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    idx.Close;
    idx.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    idx.FieldDefs.Add('UNION_ID',ftstring,36,true);
    idx.FieldDefs.Add('INDEX_ID',ftstring,36,true);
    idx.FieldDefs.Add('INDEX_NAME',ftstring,50,true);
    idx.FieldDefs.Add('INDEX_SPELL',ftstring,50,true);
    idx.FieldDefs.Add('INDEX_TYPE',ftstring,1,true);
    idx.FieldDefs.Add('INDEX_OPTION',ftstring,255,true);
    idx.FieldDefs.Add('INDEX_ISNULL',ftstring,1,true);
    idx.FieldDefs.Add('COMM',ftstring,2,true);
    idx.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    idx.CreateDataSet;
    prc.Close;
    prc.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
    prc.FieldDefs.Add('PRICE_ID',ftstring,36,true);
    prc.FieldDefs.Add('PRICE_NAME',ftstring,30,true);
    prc.FieldDefs.Add('PRICE_SPELL',ftstring,30,true);
    prc.FieldDefs.Add('PRICE_TYPE',ftstring,1,true);
    prc.FieldDefs.Add('INTEGRAL',ftfloat,0,true);
    prc.FieldDefs.Add('INTE_TYPE',ftInteger,0,true);
    prc.FieldDefs.Add('INTE_AMOUNT',ftfloat,0,true);
    prc.FieldDefs.Add('MINIMUM_PERCENT',ftfloat,0,true);
    prc.FieldDefs.Add('AGIO_TYPE',ftInteger,0,true);
    prc.FieldDefs.Add('AGIO_PERCENT',ftfloat,0,true);
    prc.FieldDefs.Add('AGIO_SORTS',ftstring,255,true);
    prc.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
    prc.FieldDefs.Add('COMM',ftstring,2,true);
    prc.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    prc.CreateDataSet;
    pubUnionQueryResp := Node.firstChild;
    while pubUnionQueryResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(pubUnionQueryResp,'tenantId'));
        rs.FieldByName('UNION_ID').AsString := rspFactory.GetNodeValue(pubUnionQueryResp,'unionId');
        rs.FieldByName('UNION_NAME').AsString := rspFactory.GetNodeValue(pubUnionQueryResp,'unionName');
        rs.FieldByName('UNION_SPELL').AsString := rspFactory.GetNodeValue(pubUnionQueryResp,'unionSpell');
        rs.FieldByName('INDEX_FLAG').AsString := rspFactory.GetNodeValue(pubUnionQueryResp,'indexFlag');
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(pubUnionQueryResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(pubUnionQueryResp,'timeStamp'));
        rs.Post;
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
        IndexResp :=  pubUnionQueryResp.firstChild;
        while IndexResp<>nil do
          begin
            if indexResp.nodeName='indexs' then
              begin
                UnionIndex := indexResp.firstChild;
                while UnionIndex<>nil do
                  begin
                    idx.Append;
                    idx.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(UnionIndex,'tenantId'));
                    idx.FieldByName('UNION_ID').AsString := rspFactory.GetNodeValue(UnionIndex,'unionId');
                    idx.FieldByName('INDEX_ID').AsString := rspFactory.GetNodeValue(UnionIndex,'indexId');
                    idx.FieldByName('INDEX_NAME').AsString := rspFactory.GetNodeValue(UnionIndex,'indexName');
                    idx.FieldByName('INDEX_SPELL').AsString := rspFactory.GetNodeValue(UnionIndex,'indexSpell');
                    idx.FieldByName('INDEX_TYPE').AsString := rspFactory.GetNodeValue(UnionIndex,'indexType');
                    idx.FieldByName('INDEX_OPTION').AsString := rspFactory.GetNodeValue(UnionIndex,'indexOption');
                    idx.FieldByName('INDEX_ISNULL').AsString := rspFactory.GetNodeValue(UnionIndex,'indexIsnull');
                    idx.FieldByName('COMM').AsString := rspFactory.GetNodeValue(UnionIndex,'comm');
                    TLargeintField(idx.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(UnionIndex,'timeStamp'));
                    idx.Post;
                    if StrtoInt64(idx.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
                       maxtimestamp := StrtoInt64(idx.FieldByName('TIME_STAMP').AsString);
                    UnionIndex := UnionIndex.nextSibling;
                  end;
              end
            else
              if indexResp.nodeName='pubPricegrade' then
                begin
                  prc.Append;
                  prc.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
                  prc.FieldByName('PRICE_ID').AsString := rspFactory.GetNodeValue(indexResp,'priceId');
                  prc.FieldByName('PRICE_NAME').AsString := rspFactory.GetNodeValue(indexResp,'priceName');
                  prc.FieldByName('PRICE_SPELL').AsString := rspFactory.GetNodeValue(indexResp,'priceSpell');
                  prc.FieldByName('PRICE_TYPE').AsString := '2';
                  prc.FieldByName('INTEGRAL').AsFloat := StrtoFloatDef(rspFactory.GetNodeValue(indexResp,'integral'),0);
                  prc.FieldByName('INTE_TYPE').AsInteger := StrtoIntDef(rspFactory.GetNodeValue(indexResp,'inteType'),0);
                  prc.FieldByName('INTE_AMOUNT').AsFloat := StrtoFloatDef(rspFactory.GetNodeValue(indexResp,'inteAmount'),0);
                  prc.FieldByName('MINIMUM_PERCENT').AsFloat := StrtoFloatDef(rspFactory.GetNodeValue(indexResp,'minimumPercent'),0);
                  prc.FieldByName('AGIO_TYPE').AsInteger := StrtoIntDef(rspFactory.GetNodeValue(indexResp,'agioType'),0);
                  prc.FieldByName('AGIO_PERCENT').AsFloat := StrtoIntDef(rspFactory.GetNodeValue(indexResp,'agioPercent'),100);
                  prc.FieldByName('AGIO_SORTS').AsString := rspFactory.GetNodeValue(indexResp,'agioSorts');
                  prc.FieldByName('SEQ_NO').AsInteger := 0;
                  prc.FieldByName('COMM').AsString := rspFactory.GetNodeValue(indexResp,'comm');
                  TLargeintField(prc.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(indexResp,'timeStamp'));
                  prc.Post;
                  if StrtoInt64(prc.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
                     maxtimestamp := StrtoInt64(prc.FieldByName('TIME_STAMP').AsString);
                end;
            IndexResp := IndexResp.nextSibling;
          end;
        pubUnionQueryResp := pubUnionQueryResp.nextSibling;
      end;

    if not rs.IsEmpty or not idx.IsEmpty or not prc.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          dataFactory.BeginBatch;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'PUB_UNION_INFO';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;UNION_ID';
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timestamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            Params.ParamByName('KEY_FLAG').AsString := '1';
            dataFactory.AddBatch(rs,'TSyncSingleTableV60',Params);
            Params.ParamByName('TABLE_NAME').AsString := 'PUB_UNION_INDEX';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;UNION_ID;INDEX_ID';
            dataFactory.AddBatch(idx,'TSyncSingleTableV60',Params);
            Params.ParamByName('TABLE_NAME').AsString := 'PUB_PRICEGRADE';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;PRICE_ID';
            Params.ParamByName('KEY_FLAG').AsString := '2';
            dataFactory.AddBatch(prc,'TSyncSingleTableV60',Params);
            dataFactory.CommitBatch;
          except
            dataFactory.CancelBatch;
            Raise;
          end;
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_PUB_UNION_INFO',maxtimestamp);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            dataFactory.BeginBatch;
            try
              Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
              Params.ParamByName('TABLE_NAME').AsString := 'PUB_UNION_INFO';
              Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;UNION_ID';
              Params.ParamByName('COMM_LOCK').AsString := '1';
              Params.ParamByName('TIME_STAMP').Value := timestamp;
              Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
              Params.ParamByName('KEY_FLAG').AsString := '1';
              dataFactory.AddBatch(rs,'TSyncSingleTableV60',Params);
              Params.ParamByName('TABLE_NAME').AsString := 'PUB_UNION_INDEX';
              Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;UNION_ID;INDEX_ID';
              dataFactory.AddBatch(idx,'TSyncSingleTableV60',Params);
              Params.ParamByName('TABLE_NAME').AsString := 'PUB_PRICEGRADE';
              Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;PRICE_ID';
              Params.ParamByName('KEY_FLAG').AsString := '2';
              dataFactory.AddBatch(prc,'TSyncSingleTableV60',Params);
              dataFactory.CommitBatch;
            except
              dataFactory.CancelBatch;
              Raise;
            end;
          finally
            dataFactory.MoveToDefault;
            Params.Free;
          end;
        end;
      end;
  finally
    prc.Free;
    idx.Free;
    rs.Free;
  end;
end;

procedure TRspSyncFactory.downloadModules;
var
  doc:IXMLDomDocument;
  listModulesResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  outxml:WideString;
  rs:TZQuery;
  Params:TftParamList;
  timestamp,maxtimestamp:int64;
  ProductId:string;
begin
  ProductId := dllGlobal.GetProductId;
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_CA_MODULE',ProductId);
  maxtimestamp := timestamp;
  outxml := rspFactory.downloadModules(strtoint(token.tenantId), 1, timestamp);
  doc := rspFactory.CreateXML(outxml);
  Node := rspFactory.FindNode(doc,'body');

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.FieldDefs.Add('PROD_ID',ftstring,10,true);
    rs.FieldDefs.Add('MODU_ID',ftstring,20,true);
    rs.FieldDefs.Add('SEQNO',ftInteger,0,true);
    rs.FieldDefs.Add('MODU_NAME',ftstring,50,true);
    rs.FieldDefs.Add('LEVEL_ID',ftstring,21,true);
    rs.FieldDefs.Add('MODU_TYPE',ftInteger,0,true);
    rs.FieldDefs.Add('ACTION_NAME',ftstring,50,true);
    rs.FieldDefs.Add('ACTION_URL',ftstring,255,true);
    rs.FieldDefs.Add('COMM',ftstring,2,true);
    rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
    rs.CreateDataSet;
    listModulesResp := Node.firstChild;
    while listModulesResp<>nil do
      begin
        rs.Append;
        rs.FieldByName('PROD_ID').AsString := rspFactory.GetNodeValue(listModulesResp,'prodId');
        rs.FieldByName('MODU_ID').AsString := rspFactory.GetNodeValue(listModulesResp,'moduId');
        if rspFactory.GetNodeValue(listModulesResp,'seqno')='' then
           rs.FieldByName('SEQNO').AsInteger := 0
        else
           rs.FieldByName('SEQNO').AsInteger := StrtoInt(rspFactory.GetNodeValue(listModulesResp,'seqno'));
        rs.FieldByName('MODU_NAME').AsString := rspFactory.GetNodeValue(listModulesResp,'moduName');
        rs.FieldByName('LEVEL_ID').AsString := rspFactory.GetNodeValue(listModulesResp,'levelId');
        rs.FieldByName('MODU_TYPE').AsInteger := StrtoInt(rspFactory.GetNodeValue(listModulesResp,'moduType'));
        rs.FieldByName('ACTION_NAME').AsString := rspFactory.GetNodeValue(listModulesResp,'actionName');
        rs.FieldByName('ACTION_URL').AsString := rspFactory.GetNodeValue(listModulesResp,'actionUrl');
        rs.FieldByName('COMM').AsString := rspFactory.GetNodeValue(listModulesResp,'comm');
        TLargeintField(rs.FieldByName('TIME_STAMP')).Value := StrtoInt64(rspFactory.GetNodeValue(listModulesResp,'timeStamp'));
        rs.Post;
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
        listModulesResp := listModulesResp.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'CA_MODULE';
          Params.ParamByName('KEY_FIELDS').AsString := 'PROD_ID;MODU_ID';
          Params.ParamByName('PROD_ID').AsString := rs.FieldByName('PROD_ID').AsString;
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := timestamp;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
          dataFactory.UpdateBatch(rs,'TSyncCaModuleV60',Params);
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_CA_MODULE',maxtimeStamp,ProductId);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          dataFactory.MoveToSqlite;
          Params := TftParamList.Create(nil);
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'CA_MODULE';
            Params.ParamByName('KEY_FIELDS').AsString := 'PROD_ID;MODU_ID';
            Params.ParamByName('PROD_ID').AsString := rs.FieldByName('PROD_ID').AsString;
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := timestamp;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
            dataFactory.UpdateBatch(rs,'TSyncCaModuleV60',Params);
          finally
            dataFactory.MoveToDefault;
            Params.Free;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
end;

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
  timestamp := SyncFactory.GetSynTimeStamp(token.tenantId,'RSP_PUB_GOODSSORT');
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
        if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > maxtimestamp then
           maxtimestamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
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
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          SyncFactory.SetSynTimeStamp(token.tenantId,'RSP_PUB_GOODSSORT',maxtimestamp);
        finally
          Params.Free;
        end;
        // 本地保存
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
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(rs,'TSyncSingleTableV60',Params);
          finally
            Params.Free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
  end;
  dllGlobal.GetZQueryFromName('PUB_GOODSSORT').Close;
end;

procedure TRspSyncFactory.SyncAll;
begin
  SetProMax(6);
  SetProPosition(0);
  ProTitle := '正在下载<企业信息>...';
  downloadTenants;
  SetProPosition(1);
  ProTitle := '正在下载<供应链信息>...';
  downloadServiceLines;
  SetProPosition(2);
  ProTitle := '正在下载<供应关系>...';
  downloadRelations;
  SetProPosition(3);
  ProTitle := '正在下载<计量单位>...';
  downloadUnion;
  SetProPosition(4);
  ProTitle := '正在下载<商品分类>...';
  downloadGoodsSort;
  SetProPosition(5);
  ProTitle := '正在下载<功能模块>...';
  downloadModules;
  SetProPosition(6);
end;

procedure TRspSyncFactory.copyGoodsSort;
var rs,ss:TZQuery;
begin
  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    rs.SQL.Text := 'select 1 from PUB_GOODSSORT where SORT_TYPE=1 and TENANT_ID='+token.tenantId;
    dataFactory.Open(rs);
    if not rs.IsEmpty then Exit;
  finally
    dataFactory.MoveToDefault;
    rs.Free;
  end;

  rs := TZQuery.Create(nil);
  ss := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from PUB_GOODSSORT where SORT_TYPE=1 and TENANT_ID=110000002';
    dataFactory.Open(rs);
    ss.FieldDefs := rs.FieldDefs;
    ss.CreateDataSet;
    rs.First;
    while not rs.Eof do
    begin
      ss.Append;
      ss.FieldByName('SORT_ID').AsString := TSequence.NewId;
      ss.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      ss.FieldByName('LEVEL_ID').AsString := rs.FieldByName('LEVEL_ID').AsString;
      ss.FieldByName('SORT_NAME').AsString := rs.FieldByName('SORT_NAME').AsString;
      ss.FieldByName('SORT_TYPE').AsInteger := rs.FieldByName('SORT_TYPE').AsInteger;
      ss.FieldByName('SORT_SPELL').AsString := rs.FieldByName('SORT_SPELL').AsString;
      ss.FieldByName('SEQ_NO').AsInteger := rs.FieldByName('SEQ_NO').AsInteger;
      ss.FieldByName('COMM').AsString := rs.FieldByName('COMM').AsString;
      TLargeintField(ss.FieldByName('TIME_STAMP')).Value := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);
      ss.Post;
      rs.Next;
    end;

    if not ss.IsEmpty then
      begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSSORT';
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SORT_ID;SORT_TYPE';
          Params.ParamByName('COMM_LOCK').AsString := '1';
          Params.ParamByName('TIME_STAMP').Value := 0;
          Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
          dataFactory.UpdateBatch(ss,'TSyncSingleTableV60',Params);
        finally
          Params.Free;
        end;
        // 本地保存
        if dataFactory.iDbType <> 5 then
        begin
          Params := TftParamList.Create(nil);
          dataFactory.MoveToSqlite;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSSORT';
            Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SORT_ID;SORT_TYPE';
            Params.ParamByName('COMM_LOCK').AsString := '1';
            Params.ParamByName('TIME_STAMP').Value := 0;
            Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
            dataFactory.UpdateBatch(ss,'TSyncSingleTableV60',Params);
          finally
            Params.Free;
            dataFactory.MoveToDefault;
          end;
        end;
      end;
  finally
    rs.Free;
    ss.Free;
  end;
  dllGlobal.GetZQueryFromName('PUB_GOODSSORT').Close;
end;

procedure TRspSyncFactory.SetProTitle(const Value: string);
begin
  FProTitle := Value;
  SetProCaption;
end;

procedure TRspSyncFactory.SetProHandle(const Value: Hwnd);
begin
  FProHandle := Value;
end;

procedure TRspSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TRspSyncFactory.SetProCaption;
begin
  GlobalProTitle := ProTitle;
  PostMessage(ProHandle, MSC_SET_CAPTION, 0, 1);
  Application.ProcessMessages;
end;

procedure TRspSyncFactory.SetProMax(max: integer);
begin
  PostMessage(ProHandle, MSC_SET_MAX, max, 0);
  Application.ProcessMessages;
end;

procedure TRspSyncFactory.SetProPosition(position: integer);
begin
  PostMessage(ProHandle, MSC_SET_POSITION, position, 0);
  Application.ProcessMessages;
end;

initialization
  RspSyncFactory := TRspSyncFactory.Create;
finalization
  if Assigned(RspSyncFactory) then FreeAndNil(RspSyncFactory);
end.
