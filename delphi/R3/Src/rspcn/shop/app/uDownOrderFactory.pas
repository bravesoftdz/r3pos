unit uDownOrderFactory;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, ZDataSet, ZBase, ComObj,
 DB, ZAbstractRODataset, ZAbstractDataset, msxml, ZLogFile, IdHTTP,
 IniFiles, Dialogs;

type
  TDownOrderFactory=class
    public
      class function getOrderInfo(cdsTable:TZQuery;vParam:TftParamList):boolean;
      class function getOrderDetail(cdsTable:TZQuery;vParam:TftParamList):boolean;
    end;

implementation

uses uTokenFactory,udataFactory;

function GetUrlStream(url:string; Stream:TStream): boolean;
var Http:TIdHTTP;
begin
  try
    LogFile.AddLogFile(0,'下载订单:'+url); 
    Http := TIdHttp.Create(nil);
    try
      Http.HandleRedirects := True;
      Http.ReadTimeout := 15000;
      Stream.Position := 0;
      Http.Get(url,Stream);
      result := true;
    finally
      Http.Free;
    end;
  except
    result := false;
  end;
end;

function CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml出错了,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml字符串不能为空...');
  except
    result := nil;
    Raise;
  end;
end;

function FindElement(root: IXMLDOMNode; s: string): IXMLDOMNode;
begin
  result := root.firstChild;
  while result<>nil do
    begin
      if result.nodeName=s then exit;
      result := result.nextSibling;
    end;
  result := nil;
end;

function FindNode(doc: IXMLDomDocument; tree: string): IXMLDOMNode;
var
  s:TStringList;
  i:integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '\';
    s.DelimitedText := tree;
    result := doc.documentElement;
    for i:=0 to s.Count -1 do
      begin
        if result <>nil then result := FindElement(result,s[i]);
      end;
  finally
    s.Free;
  end;
end;

function GetNodeValue(root: IXMLDOMNode; s: string):string;
var node:IXMLDOMNode;
begin
  node := FindElement(root,s);
  if node = nil then Raise Exception.Create('XML读取出错，原因：'+s+'结点属性没找到.');
  result := Node.text;
end;

class function TDownOrderFactory.getOrderInfo(cdsTable:TZQuery;vParam:TftParamList): boolean;
var
  rimUrl,comId,custId:string;
  sm:TStringStream;
  doc:IXMLDomDocument;
  Node:IXMLDOMNode;
  rs:TZQuery;
  clientId:string;
  clientName:string;
  xml:string;
begin
  result := false;

  rimUrl := vParam.ParamByName('rimUrl').AsString;
  comId := vParam.ParamByName('comId').AsString;
  custId := vParam.ParamByName('custId').AsString;

  // 获取上级供应商
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text:=
        'select T.TENANT_ID as TENANT_ID,T.TENANT_NAME as TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
        'where T.TENANT_ID=R.TENANT_ID and T.COMM not in (''02'',''12'') and R.RELATI_ID='+token.tenantId+' and R.RELATION_ID=1000006 ';
    if dataFactory.Open(rs) then
      begin
        clientId:=trim(rs.fieldbyName('TENANT_ID').AsString);
        clientName:=trim(rs.fieldbyName('TENANT_NAME').AsString);
      end
  finally
    rs.Free;
  end;

  if clientId = '' then Raise Exception.Create('获取上级烟草公司信息失败！');

  cdsTable.Close;
  cdsTable.FieldDefs.Clear;
  cdsTable.FieldDefs.Add('SELFLAG',ftInteger,0,true);
  cdsTable.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
  cdsTable.FieldDefs.Add('SHOP_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('INDE_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('STATUS',ftstring,36,true);
  cdsTable.FieldDefs.Add('ARR_DATE',ftstring,36,true);
  cdsTable.FieldDefs.Add('INDE_DATE',ftstring,36,true);
  cdsTable.FieldDefs.Add('CLIENT_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('CLIENT_NAME',ftstring,36,true);
  cdsTable.FieldDefs.Add('INDE_AMT',ftFloat,0,true);
  cdsTable.FieldDefs.Add('INDE_MNY',ftFloat,0,true);
  cdsTable.FieldDefs.Add('NEED_AMT',ftFloat,0,true);
  cdsTable.CreateDataSet;

  sm := TStringStream.Create('');
  try
    if not GetUrlStream(rimUrl+'listOrderInfo.action?comId='+comId+'&custId='+custId,sm) then Exit;
{   //测试xml
    xml := '<?xml version="1.0" encoding="gb2312" standalone="no"?>'+
           '<message>'+
           '<header>'+
           '<pub>'+
           '<recAck>0000</recAck>'+
           '<msg>成功处理</msg>'+
           '</pub>'+
           '</header>'+
           '<body>'+
           '<dataset>'+
           '<dataset_line>'+
           '<coNum>JAW801507685</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>135.000000</qtySum>'+
           '<amtSum>12023.30</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>JA0000003042198</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>17.000000</qtySum>'+
           '<amtSum>765.00</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>JAW801529304</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>55.000000</qtySum>'+
           '<amtSum>6557.00</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>JAW801551880</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>52.000000</qtySum>'+
           '<amtSum>6930.00</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>JAW801569020</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>55.000000</qtySum>'+
           '<amtSum>5040.50</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>JA0000003045225</coNum>'+
           '<crtDate>20130603</crtDate>'+
           '<qtySum>19.000000</qtySum>'+
           '<amtSum>855.00</amtSum>'+
           '<status>06</status>'+
           '<arrDate>20130603</arrDate>'+
           '</dataset_line>'+
           '</dataset>'+
           '</body>'+
           '</message>';
    sm.Create(xml);
}
    doc := CreateXML(sm.DataString);
    if doc = nil then Exit;
    Node := FindNode(doc,'body\dataset\dataset_line');
    while Node <> nil do
      begin
        cdsTable.Append;
        cdsTable.FieldByName('SELFLAG').AsInteger := 0;
        cdsTable.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
        cdsTable.FieldByName('SHOP_ID').AsString := token.shopId;
        cdsTable.FieldByName('INDE_ID').AsString := GetNodeValue(Node, 'coNum');
        cdsTable.FieldByName('STATUS').AsString := GetNodeValue(Node, 'status');
        cdsTable.FieldByName('ARR_DATE').AsString := GetNodeValue(Node, 'arrDate');
        cdsTable.FieldByName('INDE_DATE').AsString := GetNodeValue(Node, 'crtDate');
        cdsTable.FieldByName('CLIENT_ID').AsString := clientId;
        cdsTable.FieldByName('CLIENT_NAME').AsString := clientName;
        cdsTable.FieldByName('INDE_AMT').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'qtySum'),0);
        cdsTable.FieldByName('INDE_MNY').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'amtSum'),0);
        cdsTable.FieldByName('NEED_AMT').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'qtySum'),0);
        cdsTable.Post;
        Node := Node.nextSibling;
      end;
  finally
    sm.Free;
  end;

  result := true;
end;

class function TDownOrderFactory.getOrderDetail(cdsTable:TZQuery;vParam:TftParamList): boolean;
var
  rimUrl,comId,custId:string;
  sm:TStringStream;
  doc:IXMLDomDocument;
  Node:IXMLDOMNode;
  rs,gods:TZQuery;
  xml:string;
begin
  result := false;

  rimUrl := vParam.ParamByName('rimUrl').AsString;
  comId := vParam.ParamByName('comId').AsString;
  custId := vParam.ParamByName('custId').AsString;

  cdsTable.Close;
  cdsTable.FieldDefs.Clear;
  cdsTable.FieldDefs.Add('INDE_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('GODS_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('UNIT_ID',ftstring,36,true);
  cdsTable.FieldDefs.Add('AMOUNT',ftFloat,0,true);
  cdsTable.FieldDefs.Add('APRICE',ftFloat,0,true);
  cdsTable.FieldDefs.Add('AMONEY',ftFloat,0,true);
  cdsTable.FieldDefs.Add('AGIO_MONEY',ftFloat,0,true);
  cdsTable.FieldDefs.Add('NEED_AMT',ftFloat,0,true);
  cdsTable.FieldDefs.Add('CHK_AMT',ftFloat,0,true);
  cdsTable.CreateDataSet;

  rs := TZQuery.Create(nil);
  gods := TZQuery.Create(nil);
  sm := TStringStream.Create('');
  try
    rs.FieldDefs.Add('INDE_ID',ftstring,36,true);
    rs.FieldDefs.Add('ITEM_ID',ftstring,36,true);
    rs.FieldDefs.Add('QTY_NEED',ftFloat,0,true);
    rs.FieldDefs.Add('QTY_ORD',ftFloat,0,true);
    rs.FieldDefs.Add('QTY_VFY',ftFloat,0,true);
    rs.FieldDefs.Add('AMT',ftFloat,0,true);
    rs.FieldDefs.Add('RET_AMT',ftFloat,0,true);
    rs.CreateDataSet;

    if not GetUrlStream(rimUrl+'listOrderDetail.action?comId='+comId+'&coNum='+vParam.ParamByName('INDE_ID').AsString,sm) then Exit;
{   测试xml
    xml := '<?xml version="1.0" encoding="gb2312" standalone="no"?>'+
           '<message>'+
           '<header>'+
           '<pub>'+
           '<recAck>0000</recAck>'+
           '<msg>成功处理</msg>'+
           '</pub>'+
           '</header>'+
           '<body>'+
           '<dataset>'+
           '<dataset_line>'+
           '<coNum>'+vParam.ParamByName('INDE_ID').AsString+'</coNum>'+
           '<itemId>d0817028da169b0128f1d65897233c</itemId>'+
           '<qtyNeed>1.000000</qtyNeed>'+
           '<qtyOrd>1.000000</qtyOrd>'+
           '<qtyVfy>1.000000</qtyVfy>'+
           '<amt>130.000000</amt>'+
           '<retAmt>0.000000</retAmt>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>'+vParam.ParamByName('INDE_ID').AsString+'</coNum>'+
           '<itemId>d081702c7e1456012c96ab97e21f75</itemId>'+
           '<qtyNeed>2.000000</qtyNeed>'+
           '<qtyOrd>2.000000</qtyOrd>'+
           '<qtyVfy>2.000000</qtyVfy>'+
           '<amt>126.000000</amt>'+
           '<retAmt>0.000000</retAmt>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>'+vParam.ParamByName('INDE_ID').AsString+'</coNum>'+
           '<itemId>11882</itemId>'+
           '<qtyNeed>1.000000</qtyNeed>'+
           '<qtyOrd>1.000000</qtyOrd>'+
           '<qtyVfy>1.000000</qtyVfy>'+
           '<amt>88.000000</amt>'+
           '<retAmt>0.000000</retAmt>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>'+vParam.ParamByName('INDE_ID').AsString+'</coNum>'+
           '<itemId>03552</itemId>'+
           '<qtyNeed>3.000000</qtyNeed>'+
           '<qtyOrd>3.000000</qtyOrd>'+
           '<qtyVfy>3.000000</qtyVfy>'+
           '<amt>1080.000000</amt>'+
           '<retAmt>0.000000</retAmt>'+
           '</dataset_line>'+
           '<dataset_line>'+
           '<coNum>'+vParam.ParamByName('INDE_ID').AsString+'</coNum>'+
           '<itemId>01158</itemId>'+
           '<qtyNeed>1.000000</qtyNeed>'+
           '<qtyOrd>1.000000</qtyOrd>'+
           '<qtyVfy>1.000000</qtyVfy>'+
           '<amt>63.000000</amt>'+
           '<retAmt>0.000000</retAmt>'+
           '</dataset_line>'+
           '</dataset>'+
           '</body>'+
           '</message>';
    sm.Create(xml);
}
    doc := CreateXML(sm.DataString);
    if doc = nil then Exit;
    Node := FindNode(doc,'body\dataset\dataset_line');
    while Node <> nil do
      begin
        rs.Append;
        rs.FieldByName('INDE_ID').AsString := GetNodeValue(Node, 'coNum');
        rs.FieldByName('ITEM_ID').AsString := GetNodeValue(Node, 'itemId');
        rs.FieldByName('QTY_NEED').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'qtyNeed'),0);
        rs.FieldByName('QTY_ORD').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'qtyOrd'),0);
        rs.FieldByName('QTY_VFY').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'qtyVfy'),0);
        rs.FieldByName('AMT').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'amt'),0);
        rs.FieldByName('RET_AMT').AsFloat := StrtoFloatDef(GetNodeValue(Node, 'retAmt'),0);
        rs.Post;
        Node := Node.nextSibling;
      end;

    if not rs.IsEmpty then
      begin
        // 商品缓存
        gods.SQL.Text := 'select GODS_ID,SECOND_ID,COMM_ID,ZOOM_RATE from VIW_GOODSINFO where TENANT_ID = ' + token.tenantId + ' and COMM not in (''02'',''12'') and RELATION_ID = 1000006 ';
        dataFactory.Open(gods);

        rs.First;
        while not rs.Eof do
          begin
            // 检测SECOND_ID
            if gods.Locate('SECOND_ID',rs.FieldByName('ITEM_ID').AsString,[]) then
              begin
                if not cdsTable.Locate('GODS_ID',gods.FieldByName('GODS_ID').AsString,[]) then
                  begin
                    cdsTable.Append;
                    cdsTable.FieldByName('INDE_ID').AsString := rs.FieldByName('INDE_ID').AsString;
                    cdsTable.FieldByName('GODS_ID').AsString := gods.FieldByName('GODS_ID').AsString;
                    cdsTable.FieldByName('UNIT_ID').AsString := '95331F4A-7AD6-45C2-B853-C278012C5525';
                    cdsTable.FieldByName('AMOUNT').AsFloat := rs.FieldByName('QTY_ORD').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    cdsTable.FieldByName('AMONEY').AsFloat := rs.FieldByName('AMT').AsFloat;
                    cdsTable.FieldByName('AGIO_MONEY').AsFloat := rs.FieldByName('RET_AMT').AsFloat;
                    cdsTable.FieldByName('NEED_AMT').AsFloat := rs.FieldByName('QTY_NEED').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    cdsTable.FieldByName('CHK_AMT').AsFloat := rs.FieldByName('QTY_VFY').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    if cdsTable.FieldByName('AMOUNT').AsFloat <> 0 then
                      cdsTable.FieldByName('APRICE').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat/cdsTable.FieldByName('AMOUNT').AsFloat
                    else
                      cdsTable.FieldByName('APRICE').AsFloat := 0;
                    cdsTable.Post;
                  end
                else
                  begin
                    cdsTable.Edit;
                    cdsTable.FieldByName('AMOUNT').AsFloat := cdsTable.FieldByName('AMOUNT').AsFloat + rs.FieldByName('QTY_ORD').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    cdsTable.FieldByName('AMONEY').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat + rs.FieldByName('AMT').AsFloat;
                    cdsTable.FieldByName('AGIO_MONEY').AsFloat := cdsTable.FieldByName('AGIO_MONEY').AsFloat + rs.FieldByName('RET_AMT').AsFloat;
                    cdsTable.FieldByName('NEED_AMT').AsFloat := cdsTable.FieldByName('NEED_AMT').AsFloat + rs.FieldByName('QTY_NEED').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    cdsTable.FieldByName('CHK_AMT').AsFloat := cdsTable.FieldByName('CHK_AMT').AsFloat + rs.FieldByName('QTY_VFY').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                    if cdsTable.FieldByName('AMOUNT').AsFloat <> 0 then
                      cdsTable.FieldByName('APRICE').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat/cdsTable.FieldByName('AMOUNT').AsFloat
                    else
                      cdsTable.FieldByName('APRICE').AsFloat := 0;
                    cdsTable.Post;
                  end;
              end
            else
              begin
                // 检测COMM_ID
                gods.First;
                while not gods.Eof do
                  begin
                    if gods.FieldByName('COMM_ID').AsString <> '' then
                      begin
                        if pos(',' + rs.FieldByName('ITEM_ID').AsString + ',', ',' + gods.FieldByName('COMM_ID').AsString + ',') > 0 then
                          begin
                            if not cdsTable.Locate('GODS_ID',gods.FieldByName('GODS_ID').AsString,[]) then
                              begin
                                cdsTable.Append;
                                cdsTable.FieldByName('INDE_ID').AsString := rs.FieldByName('INDE_ID').AsString;
                                cdsTable.FieldByName('GODS_ID').AsString := gods.FieldByName('GODS_ID').AsString;
                                cdsTable.FieldByName('UNIT_ID').AsString := '95331F4A-7AD6-45C2-B853-C278012C5525';
                                cdsTable.FieldByName('AMOUNT').AsFloat := rs.FieldByName('QTY_ORD').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                cdsTable.FieldByName('AMONEY').AsFloat := rs.FieldByName('AMT').AsFloat;
                                cdsTable.FieldByName('AGIO_MONEY').AsFloat := rs.FieldByName('RET_AMT').AsFloat;
                                cdsTable.FieldByName('NEED_AMT').AsFloat := rs.FieldByName('QTY_NEED').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                cdsTable.FieldByName('CHK_AMT').AsFloat := rs.FieldByName('QTY_VFY').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                if cdsTable.FieldByName('AMOUNT').AsFloat <> 0 then
                                  cdsTable.FieldByName('APRICE').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat/cdsTable.FieldByName('AMOUNT').AsFloat
                                else
                                  cdsTable.FieldByName('APRICE').AsFloat := 0;
                                cdsTable.Post;
                              end
                            else
                              begin
                                cdsTable.Edit;
                                cdsTable.FieldByName('AMOUNT').AsFloat := cdsTable.FieldByName('AMOUNT').AsFloat + rs.FieldByName('QTY_ORD').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                cdsTable.FieldByName('AMONEY').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat + rs.FieldByName('AMT').AsFloat;
                                cdsTable.FieldByName('AGIO_MONEY').AsFloat := cdsTable.FieldByName('AGIO_MONEY').AsFloat + rs.FieldByName('RET_AMT').AsFloat;
                                cdsTable.FieldByName('NEED_AMT').AsFloat := cdsTable.FieldByName('NEED_AMT').AsFloat + rs.FieldByName('QTY_NEED').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                cdsTable.FieldByName('CHK_AMT').AsFloat := cdsTable.FieldByName('CHK_AMT').AsFloat + rs.FieldByName('QTY_VFY').AsFloat * gods.FieldByName('ZOOM_RATE').AsFloat;
                                if cdsTable.FieldByName('AMOUNT').AsFloat <> 0 then
                                  cdsTable.FieldByName('APRICE').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat/cdsTable.FieldByName('AMOUNT').AsFloat
                                else
                                  cdsTable.FieldByName('APRICE').AsFloat := 0;
                                cdsTable.Post;
                              end;
                            break;
                          end;
                      end;
                    gods.Next;
                  end;
                // 没有找到对照商品
                if gods.Eof then
                  begin
                    cdsTable.Append;
                    cdsTable.FieldByName('INDE_ID').AsString := rs.FieldByName('INDE_ID').AsString;
                    cdsTable.FieldByName('UNIT_ID').AsString := '95331F4A-7AD6-45C2-B853-C278012C5525';
                    cdsTable.FieldByName('AMOUNT').AsFloat := rs.FieldByName('QTY_ORD').AsFloat;
                    cdsTable.FieldByName('AMONEY').AsFloat := rs.FieldByName('AMT').AsFloat;
                    cdsTable.FieldByName('AGIO_MONEY').AsFloat := rs.FieldByName('RET_AMT').AsFloat;
                    cdsTable.FieldByName('NEED_AMT').AsFloat := rs.FieldByName('QTY_NEED').AsFloat;
                    cdsTable.FieldByName('CHK_AMT').AsFloat := rs.FieldByName('QTY_VFY').AsFloat;
                    if cdsTable.FieldByName('AMOUNT').AsFloat <> 0 then
                      cdsTable.FieldByName('APRICE').AsFloat := cdsTable.FieldByName('AMONEY').AsFloat/cdsTable.FieldByName('AMOUNT').AsFloat
                    else
                      cdsTable.FieldByName('APRICE').AsFloat := 0;
                    cdsTable.Post;
                  end;
              end;
            rs.Next;
          end;
      end;
  finally
    sm.Free;
    rs.Free;
    gods.Free;
  end;

  result := true;
end;

end.
