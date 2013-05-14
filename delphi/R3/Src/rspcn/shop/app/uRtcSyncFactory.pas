unit uRtcSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase,
  ObjCommon, Dialogs, DB, msxml, ComObj, dllApi, ufrmSyncData;

const
  appId = '123';
  dllname = 'iRTCLib.dll';

type
  TDllGetCustAuthen = function(appId:pchar;var netStatus:integer;ticket:pchar;var ticketLength:integer):integer;stdcall;
  TDllSendDataAsync = function(appId:pchar;ticket:pchar;var ticketLength:integer;data:pchar;dataLength:integer;controlFlag:integer;var jobId:integer):integer;stdcall;

  TRtcSyncFactory=class
  private
    F:TextFile;
    dllHandle:THandle;
    dllLoaded,dllValid:boolean;
    DefaultPath:string;
    LicenseCode:string;
    FThreadLock:TRTLCriticalSection;
    GetCustAuthen:TDllGetCustAuthen;
    SendDataAsync:TDllSendDataAsync;
    FProHandle: Hwnd;
    FProTitle: string;
    procedure GetLicenseCode;
    function  GetXmlHeader(xml:widestring):widestring;
    function  GetTransUnitId(unitId:string):string;
    function  CreateXML(flag:string;godsType:string=''): IXMLDomDocument;
    function  GetSyncTimeStamp(tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSyncTimeStamp(tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    procedure SyncStockOrder;
    procedure SyncSalesOrder;
    procedure SyncStorage;
    procedure SyncCustomer;
    // 日志处理
    procedure Enter;
    procedure Leave;
    procedure AddSyncLogFile(s:string);
    // dll接口
    procedure LoadDllFactory;
    procedure FreeDllFactory;
    function  GetToken:boolean;
    function  SendData(xml:widestring):boolean;
    procedure SetProHandle(const Value: Hwnd);
    procedure SetProTitle(const Value: string);
  protected
    procedure SetProCaption;
    procedure SetProMax(max:integer);
    procedure SetProPosition(position:integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SyncRtcData;
    property  ProTitle:string read FProTitle write SetProTitle;
    property  ProHandle:Hwnd read FProHandle write SetProHandle;
  end;

var RtcSyncFactory:TRtcSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,EncDec;

constructor TRtcSyncFactory.Create;
begin
  dllValid := false;
  dllLoaded := false;
  DefaultPath := ExtractShortPathName(ExtractFilePath(ParamStr(0)));
  ForceDirectories(DefaultPath+'log');
  InitializeCriticalSection(FThreadLock);
end;

destructor TRtcSyncFactory.Destroy;
begin
  Enter;
  try
    inherited;
    RtcSyncFactory := nil;
  finally
    Leave;
    DeleteCriticalSection(FThreadLock);
  end;
end;

function TRtcSyncFactory.CreateXML(flag:string;godsType:string): IXMLDomDocument;
var Node:IXMLDOMElement;
begin
  result := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  try
    Node := result.createElement('INFO_IN');
    Node.setAttribute('FLAG',flag);
    if godsType <> '' then
       Node.setAttribute('GOODS_TYPE',godsType);
    result.documentElement := Node;
  except
    result := nil;
    Raise;
  end;
end;

function TRtcSyncFactory.GetSyncTimeStamp(tbName, SHOP_ID: string): int64;
var rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  rs := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    dataFactory.Open(rs);
    if rs.IsEmpty then
       result := 0
    else
       result := rs.Fields[0].Value;
  finally
    rs.Free;
    dataFactory.MoveToDefault;
  end;
end;

procedure TRtcSyncFactory.SetSyncTimeStamp(tbName: string; TimeStamp: int64; SHOP_ID: string);
var r:integer;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  dataFactory.MoveToSqlite;
  try
    r := dataFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+token.tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
    if r=0 then
       dataFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+token.tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TRtcSyncFactory.GetTransUnitId(unitId: string): string;
begin
  if unitId = '13F817A7-9472-48CF-91CD-27125E077FEB' then
     result := '02'
  else
  if unitId = '95331F4A-7AD6-45C2-B853-C278012C5525' then
     result := '03'
  else
  if unitid = '93996CD7-B043-4440-9037-4B82BB5207DA' then
     result := '05'
  else
     result := '';
end;

procedure TRtcSyncFactory.GetLicenseCode;
var rs:TZQuery;
begin
  if trim(LicenseCode) <> '' then Exit;
  rs := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  if rs.Locate('SHOP_ID',token.shopId,[]) then
     LicenseCode := rs.FieldByName('LICENSE_CODE').AsString
  else
     begin
       rs := dllGlobal.GetZQueryFromName('CA_TENANT');
       LicenseCode := rs.FieldByName('LICENSE_CODE').AsString;
     end;
  if trim(LicenseCode) = '' then Raise Exception.Create('当前门店许可证号无效...');
end;

procedure TRtcSyncFactory.SyncStockOrder;
var
  tbName:string;
  rs_h,rs_d:TZQuery;
  SyncTimeStamp,MaxTimeStamp:int64;
  root_1,root_2:IXMLDomDocument;
  Node_1,Node_11,Node_2,Node_22:IXMLDOMElement;
begin
  tbName := 'RTC_STK_STOCKORDER';
  SyncTimeStamp := GetSyncTimeStamp(tbName,token.shopId);
  rs_h := TZQuery.Create(nil);
  try
    rs_h.SQL.Text := 'select STOCK_ID,STOCK_DATE,CREA_DATE,TIME_STAMP from STK_STOCKORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP order by TIME_STAMP asc';
    rs_h.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    rs_h.ParamByName('SHOP_ID').AsString:=token.shopId;
    rs_h.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
    dataFactory.Open(rs_h);
    if rs_h.IsEmpty then Exit;
    root_1 := CreateXML('3','1');
    root_2 := CreateXML('3','2');
    rs_h.First;
    while not rs_h.Eof do
      begin
        rs_d := TZQuery.Create(nil);
        try
          rs_d.SQL.Text := ' select a.UNIT_ID,a.AMOUNT,a.CALC_MONEY,a.APRICE,b.BARCODE,c.RELATION_ID '+
                           ' from   STK_STOCKDATA a,VIW_BARCODE b,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,RELATION_ID,GODS_ID')+') c '+
                           ' where  a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.UNIT_ID=b.UNIT_ID '+
                           '        and a.TENANT_ID=c.TENANT_ID and a.GODS_ID=c.GODS_ID '+
                           '        and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.STOCK_ID=:STOCK_ID ';
          rs_d.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
          rs_d.ParamByName('SHOP_ID').AsString:=token.shopId;
          rs_d.ParamByName('STOCK_ID').AsString := rs_h.FieldByName('STOCK_ID').AsString;
          dataFactory.Open(rs_d);

          rs_d.Filtered:=false;
          rs_d.Filter:='RELATION_ID=1000006';
          rs_d.Filtered:=true;
          if not rs_d.IsEmpty then
             begin
               Node_1 := IXMLDOMElement(root_1.documentElement.appendChild(root_1.createElement('VOUCHER_INFO')));
               Node_1.setAttribute('VOUCHER_ID',rs_h.FieldByName('STOCK_ID').AsString);
               Node_1.setAttribute('LICENSE_CODE',LicenseCode);
               Node_1.setAttribute('PUH_DATE',rs_h.FieldByName('STOCK_DATE').AsString);
               Node_1.setAttribute('PUH_TIME',Copy(rs_h.FieldByName('CREA_DATE').AsString,12,8));
               rs_d.First;
               while not rs_d.Eof do
                 begin
                   Node_11 := IXMLDOMElement(Node_1.appendChild(root_1.createElement('VOUCHER_LINE_INFO')));
                   Node_11.setAttribute('PACK_BAR',rs_d.FieldByName('BARCODE').AsString);
                   Node_11.setAttribute('QTY',rs_d.FieldByName('AMOUNT').AsString);
                   Node_11.setAttribute('PRICE',rs_d.FieldByName('APRICE').AsString);
                   Node_11.setAttribute('UM_ID',GetTransUnitId(rs_d.FieldByName('UNIT_ID').AsString));
                   Node_11.setAttribute('AMT',rs_d.FieldByName('CALC_MONEY').AsString);
                   rs_d.Next;
                 end;
             end;

          rs_d.Filtered:=false;
          rs_d.Filter:='RELATION_ID<>1000006';
          rs_d.Filtered:=true;
          if not rs_d.IsEmpty then
             begin
               Node_2 := IXMLDOMElement(root_2.documentElement.appendChild(root_2.createElement('VOUCHER_INFO')));
               Node_2.setAttribute('VOUCHER_ID',rs_h.FieldByName('STOCK_ID').AsString);
               Node_2.setAttribute('LICENSE_CODE',LicenseCode);
               Node_2.setAttribute('PUH_DATE',rs_h.FieldByName('STOCK_DATE').AsString);
               Node_2.setAttribute('PUH_TIME',Copy(rs_h.FieldByName('CREA_DATE').AsString,12,8));
               rs_d.First;
               while not rs_d.Eof do
                 begin
                   Node_22 := IXMLDOMElement(Node_2.appendChild(root_2.createElement('VOUCHER_LINE_INFO')));
                   Node_22.setAttribute('PACK_BAR',rs_d.FieldByName('BARCODE').AsString);
                   Node_22.setAttribute('QTY',rs_d.FieldByName('AMOUNT').AsString);
                   Node_22.setAttribute('PRICE',rs_d.FieldByName('APRICE').AsString);
                   Node_22.setAttribute('AMT',rs_d.FieldByName('CALC_MONEY').AsString);
                   rs_d.Next;
                 end;
             end;
        finally
          rs_d.Free;
        end;
        rs_h.Next;
      end;
    if SendData(root_1.xml) and SendData(root_2.xml) then
       begin
         AddSyncLogFile('成功-进货数据<卷烟>：'+root_1.xml);
         AddSyncLogFile('成功-进货数据<非烟>：'+root_2.xml);
         rs_h.Last;
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);
         SetSyncTimeStamp(tbName,MaxTimeStamp,token.shopId);
       end
    else
       begin
         AddSyncLogFile('失败-进货数据<卷烟>：'+root_1.xml);
         AddSyncLogFile('失败-进货数据<非烟>：'+root_2.xml);
       end;
  finally
    rs_h.Free;
  end;  
end;

procedure TRtcSyncFactory.SyncSalesOrder;
var
  tbName:string;
  rs_h,rs_d:TZQuery;
  SyncTimeStamp,MaxTimeStamp:int64;
  root_1,root_2:IXMLDomDocument;
  Node_1,Node_11,Node_2,Node_22:IXMLDOMElement;
begin
  tbName := 'RTC_SAL_SALESORDER';
  SyncTimeStamp := GetSyncTimeStamp(tbName,token.shopId);
  rs_h := TZQuery.Create(nil);
  try
    rs_h.SQL.Text := 'select SALES_ID,SALES_DATE,CREA_DATE,TIME_STAMP from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP order by TIME_STAMP asc';
    rs_h.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    rs_h.ParamByName('SHOP_ID').AsString:=token.shopId;
    rs_h.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
    dataFactory.Open(rs_h);
    if rs_h.IsEmpty then Exit;
    root_1 := CreateXML('2','1');
    root_2 := CreateXML('2','2');
    rs_h.First;
    while not rs_h.Eof do
      begin
        rs_d := TZQuery.Create(nil);
        try
          rs_d.SQL.Text := ' select a.UNIT_ID,a.AMOUNT,a.CALC_MONEY,a.APRICE,b.BARCODE,c.RELATION_ID '+
                           ' from   SAL_SALESDATA a,VIW_BARCODE b,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,RELATION_ID,GODS_ID')+') c '+
                           ' where  a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.UNIT_ID=b.UNIT_ID '+
                           '        and a.TENANT_ID=c.TENANT_ID and a.GODS_ID=c.GODS_ID '+
                           '        and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.SALES_ID=:SALES_ID ';
          rs_d.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
          rs_d.ParamByName('SHOP_ID').AsString:=token.shopId;
          rs_d.ParamByName('SALES_ID').AsString := rs_h.FieldByName('SALES_ID').AsString;
          dataFactory.Open(rs_d);

          rs_d.Filtered:=false;
          rs_d.Filter:='RELATION_ID=1000006';
          rs_d.Filtered:=true;
          if not rs_d.IsEmpty then
             begin
               Node_1 := IXMLDOMElement(root_1.documentElement.appendChild(root_1.createElement('SALE_INFO')));
               Node_1.setAttribute('SALE_ID',rs_h.FieldByName('SALES_ID').AsString);
               Node_1.setAttribute('LICENSE_CODE',LicenseCode);
               Node_1.setAttribute('PUH_DATE',rs_h.FieldByName('SALES_DATE').AsString);
               Node_1.setAttribute('PUH_TIME',Copy(rs_h.FieldByName('CREA_DATE').AsString,12,8));
               rs_d.First;
               while not rs_d.Eof do
                 begin
                   Node_11 := IXMLDOMElement(Node_1.appendChild(root_1.createElement('SALE_LINE_INFO')));
                   Node_11.setAttribute('PACK_BAR',rs_d.FieldByName('BARCODE').AsString);
                   Node_11.setAttribute('QTY',rs_d.FieldByName('AMOUNT').AsString);
                   Node_11.setAttribute('PRICE',rs_d.FieldByName('APRICE').AsString);
                   Node_11.setAttribute('UM_ID',GetTransUnitId(rs_d.FieldByName('UNIT_ID').AsString));
                   Node_11.setAttribute('AMT',rs_d.FieldByName('CALC_MONEY').AsString);
                   rs_d.Next;
                 end;
             end;

          rs_d.Filtered:=false;
          rs_d.Filter:='RELATION_ID<>1000006';
          rs_d.Filtered:=true;
          if not rs_d.IsEmpty then
             begin
               Node_2 := IXMLDOMElement(root_2.documentElement.appendChild(root_2.createElement('SALE_INFO')));
               Node_2.setAttribute('SALE_ID',rs_h.FieldByName('SALES_ID').AsString);
               Node_2.setAttribute('LICENSE_CODE',LicenseCode);
               Node_2.setAttribute('PUH_DATE',rs_h.FieldByName('SALES_DATE').AsString);
               Node_2.setAttribute('PUH_TIME',Copy(rs_h.FieldByName('CREA_DATE').AsString,12,8));
               rs_d.First;
               while not rs_d.Eof do
                 begin
                   Node_22 := IXMLDOMElement(Node_2.appendChild(root_2.createElement('SALE_LINE_INFO')));
                   Node_22.setAttribute('PACK_BAR',rs_d.FieldByName('BARCODE').AsString);
                   Node_22.setAttribute('QTY',rs_d.FieldByName('AMOUNT').AsString);
                   Node_22.setAttribute('PRICE',rs_d.FieldByName('APRICE').AsString);
                   Node_22.setAttribute('AMT',rs_d.FieldByName('CALC_MONEY').AsString);
                   rs_d.Next;
                 end;
             end;
        finally
          rs_d.Free;
        end;
        rs_h.Next;
      end;
    if SendData(root_1.xml) and SendData(root_2.xml) then
       begin
         AddSyncLogFile('成功-销售数据<卷烟>：'+root_1.xml);
         AddSyncLogFile('成功-销售数据<非烟>：'+root_2.xml);
         rs_h.Last;
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);
         SetSyncTimeStamp(tbName,MaxTimeStamp,token.shopId);
       end
    else
       begin
         AddSyncLogFile('失败-销售数据<卷烟>：'+root_1.xml);
         AddSyncLogFile('失败-销售数据<非烟>：'+root_2.xml);
       end;
  finally
    rs_h.Free;
  end;  
end;

procedure TRtcSyncFactory.SyncStorage;
var
  rs_1,rs_2:TZQuery;
  root_1,root_2:IXMLDomDocument;
  Node_1,Node_11,Node_2,Node_22:IXMLDOMElement;
begin
  rs_1 := TZQuery.Create(nil);
  rs_2 := TZQuery.Create(nil);
  try
    rs_1.SQL.Text := ParseSQL(dataFactory.iDbType,
                     ' select b.BARCODE,a.AMOUNT/(cast(case when isnull(c.SMALLTO_CALC,0)=0 then 1.0 else c.SMALLTO_CALC end as decimal(18,3))*1.0) as AMOUNT '+
                     ' from   STO_STORAGE a,VIW_BARCODE b,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,RELATION_ID,GODS_ID,SMALLTO_CALC')+') c '+
                     ' where  a.TENANT_ID = b.TENANT_ID and a.GODS_ID = b.GODS_ID and b.UNIT_ID = ''95331F4A-7AD6-45C2-B853-C278012C5525'' '+
                     '        and a.TENANT_ID = c.TENANT_ID and a.GODS_ID = c.GODS_ID and c.RELATION_ID = 1000006 '+
                     '        and a.TENANT_ID = :TENANT_ID and a.SHOP_ID = :SHOP_ID ');
    rs_1.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    rs_1.ParamByName('SHOP_ID').AsString:=token.shopId;
    dataFactory.Open(rs_1);
    if not rs_1.IsEmpty then
       begin
         root_1 := CreateXML('1','1');
         Node_1 := IXMLDOMElement(root_1.documentElement.appendChild(root_1.createElement('CUST_ITEM_WHSE_INFO')));
         rs_1.First;
         while not rs_1.Eof do
           begin
             Node_11 := IXMLDOMElement(Node_1.appendChild(root_1.createElement('CUST_ITEM_WHSE_LINE_INFO')));
             Node_11.setAttribute('LICENSE_CODE',LicenseCode);
             Node_11.setAttribute('PACK_BAR',rs_1.FieldByName('BARCODE').AsString);
             Node_11.setAttribute('QTY',rs_1.FieldByName('AMOUNT').AsString);
             Node_11.setAttribute('WHSE_DATE',FormatDateTime('YYYYMMDD',now()));
             Node_11.setAttribute('WHSE_TIME',FormatDateTime('HH:NN:SS',now()));
             rs_1.Next;
           end;
         if SendData(root_1.xml) then
            AddSyncLogFile('成功-库存数据<卷烟>：'+root_1.xml)
         else
            AddSyncLogFile('失败-库存数据<卷烟>：'+root_1.xml);
       end;

    rs_2.SQL.Text := ParseSQL(dataFactory.iDbType,
                     ' select b.BARCODE,a.AMOUNT '+
                     ' from   STO_STORAGE a,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,RELATION_ID,GODS_ID,BARCODE')+') b '+
                     ' where  a.TENANT_ID = b.TENANT_ID and a.GODS_ID = b.GODS_ID and b.RELATION_ID <> 1000006 '+
                     '        and a.TENANT_ID = :TENANT_ID and a.SHOP_ID = :SHOP_ID ');
    rs_2.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    rs_2.ParamByName('SHOP_ID').AsString:=token.shopId;
    dataFactory.Open(rs_2);
    if not rs_2.IsEmpty then
       begin
         root_2 := CreateXML('1','2');
         Node_2 := IXMLDOMElement(root_2.documentElement.appendChild(root_2.createElement('CUST_ITEM_WHSE_INFO')));
         rs_2.First;
         while not rs_2.Eof do
           begin
             Node_22 := IXMLDOMElement(Node_2.appendChild(root_2.createElement('CUST_ITEM_WHSE_LINE_INFO')));
             Node_22.setAttribute('LICENSE_CODE',LicenseCode);
             Node_22.setAttribute('PACK_BAR',rs_2.FieldByName('BARCODE').AsString);
             Node_22.setAttribute('QTY',rs_2.FieldByName('AMOUNT').AsString);
             Node_22.setAttribute('WHSE_DATE',FormatDateTime('YYYYMMDD',now()));
             Node_22.setAttribute('WHSE_TIME',FormatDateTime('HH:NN:SS',now()));
             rs_2.Next;
           end;
         if SendData(root_2.xml) then
            AddSyncLogFile('成功-库存数据<非烟>：'+root_2.xml)
         else
            AddSyncLogFile('失败-库存数据<非烟>：'+root_2.xml);
       end;
  finally
    rs_1.Free;
    rs_2.Free;
  end;
end;

procedure TRtcSyncFactory.SyncCustomer;
var
  tbName:string;
  rs_1:TZQuery;
  SyncTimeStamp,MaxTimeStamp:int64;
  root_1:IXMLDomDocument;
  Node_1,Node_11:IXMLDOMElement;
begin
  tbName := 'RTC_PUB_CUSTOMER';
  SyncTimeStamp := GetSyncTimeStamp(tbName,token.shopId);
  rs_1 := TZQuery.Create(nil);
  try
    rs_1.SQL.Text := ParseSQL(dataFactory.iDbType,
      ' select a.CUST_ID,a.CUST_CODE,a.IDN_TYPE,a.ID_NUMBER,ifnull(c7.INDEX_VALUE,'''') ADDRESS_TYPE,a.FAMI_ADDR, '+
      '        a.CUST_NAME,a.SEX,a.BIRTHDAY,ifnull(c1.INDEX_VALUE,'''') SMOKE_DATE,ifnull(c2.INDEX_VALUE,'''') TAR_CONT, '+
      '        ifnull(c3.INDEX_VALUE,'''') STRUCT,ifnull(c4.INDEX_VALUE,'''') FAVOR,ifnull(c5.INDEX_VALUE,'''') FACT_ID, '+
      '        ifnull(c6.INDEX_VALUE,'''') DAILY_USE,a.MOVE_TELE,a.EMAIL,a.POSTALCODE,a.MONTH_PAY,a.DEGREES,a.OCCUPATION, '+
      '        b.INTEGRAL,a.TIME_STAMP '+
      ' from   PUB_CUSTOMER a '+
      '        inner join PUB_IC_INFO b on a.TENANT_ID = b.TENANT_ID and a.CUST_ID = b.CLIENT_ID and b.UNION_ID = ''#'' '+
      ' 		   left  join PUB_CUSTOMER_EXT c1 on a.TENANT_ID = c1.TENANT_ID and a.CUST_ID = c1.CUST_ID and c1.INDEX_NAME = ''烟龄''     '+
      ' 		   left  join PUB_CUSTOMER_EXT c2 on a.TENANT_ID = c2.TENANT_ID and a.CUST_ID = c2.CUST_ID and c2.INDEX_NAME = ''焦油含量'' '+
      ' 		   left  join PUB_CUSTOMER_EXT c3 on a.TENANT_ID = c3.TENANT_ID and a.CUST_ID = c3.CUST_ID and c3.INDEX_NAME = ''价位结构'' '+
      ' 			 left  join PUB_CUSTOMER_EXT c4 on a.TENANT_ID = c4.TENANT_ID and a.CUST_ID = c4.CUST_ID and c4.INDEX_NAME = ''吸食口味'' '+
      ' 			 left  join PUB_CUSTOMER_EXT c5 on a.TENANT_ID = c5.TENANT_ID and a.CUST_ID = c5.CUST_ID and c5.INDEX_NAME = ''喜好产地'' '+
      ' 			 left  join PUB_CUSTOMER_EXT c6 on a.TENANT_ID = c6.TENANT_ID and a.CUST_ID = c6.CUST_ID and c6.INDEX_NAME = ''每日吸量'' '+
      ' 		   left  join PUB_CUSTOMER_EXT c7 on a.TENANT_ID = c7.TENANT_ID and a.CUST_ID = c7.CUST_ID and c7.INDEX_NAME = ''地址类型'' '+
      ' where  a.TENANT_ID = :TENANT_ID and a.TIME_STAMP > :TIME_STAMP '+
      ' order by a.TIME_STAMP asc'
      );
    rs_1.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs_1.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
    dataFactory.Open(rs_1);
    if not rs_1.IsEmpty then
       begin
         root_1 := CreateXML('4');
         Node_1 := IXMLDOMElement(root_1.documentElement.appendChild(root_1.createElement('CONSUMSER_INFO')));
         rs_1.First;
         while not rs_1.Eof do
           begin
             Node_11 := IXMLDOMElement(Node_1.appendChild(root_1.createElement('CONSUMER_DETAIL_INFO')));
             Node_11.setAttribute('CONSUMER_ID',rs_1.FieldByName('CUST_ID').AsString);
             Node_11.setAttribute('CONSUMER_CARD_ID',rs_1.FieldByName('CUST_CODE').AsString);
             Node_11.setAttribute('CERT_TYPE_ID',rs_1.FieldByName('IDN_TYPE').AsString);
             Node_11.setAttribute('CERT_ID',rs_1.FieldByName('ID_NUMBER').AsString);
             Node_11.setAttribute('ADDRESS_TYPE',rs_1.FieldByName('ADDRESS_TYPE').AsString);
             Node_11.setAttribute('ADDRESS',rs_1.FieldByName('FAMI_ADDR').AsString);
             Node_11.setAttribute('CR_NAME',rs_1.FieldByName('CUST_NAME').AsString);
             Node_11.setAttribute('GENDER',rs_1.FieldByName('SEX').AsString);
             Node_11.setAttribute('BIRTHDAY',rs_1.FieldByName('BIRTHDAY').AsString);
             Node_11.setAttribute('SMOKE_DATE',rs_1.FieldByName('SMOKE_DATE').AsString);
             Node_11.setAttribute('TAR_CONT',rs_1.FieldByName('TAR_CONT').AsString);
             Node_11.setAttribute('STRUCT',rs_1.FieldByName('STRUCT').AsString);
             Node_11.setAttribute('FAVOR',rs_1.FieldByName('FAVOR').AsString);
             Node_11.setAttribute('FACT_ID',rs_1.FieldByName('FACT_ID').AsString);
             Node_11.setAttribute('DAILY_USE',rs_1.FieldByName('DAILY_USE').AsString);
             Node_11.setAttribute('MOBILE_TEL',rs_1.FieldByName('MOVE_TELE').AsString);
             Node_11.setAttribute('LICENSE_CODE',LicenseCode);
             Node_11.setAttribute('EMAIL',rs_1.FieldByName('EMAIL').AsString);
             Node_11.setAttribute('ZIP_CODE',rs_1.FieldByName('POSTALCODE').AsString);
             Node_11.setAttribute('MONTH_PAY',rs_1.FieldByName('MONTH_PAY').AsString);
             Node_11.setAttribute('DEGREES',rs_1.FieldByName('DEGREES').AsString);
             Node_11.setAttribute('OCCUPATION',rs_1.FieldByName('OCCUPATION').AsString);
             Node_11.setAttribute('CUR_SCORE',rs_1.FieldByName('INTEGRAL').AsString);
             Node_11.setAttribute('CONSUMER_STATUS','03');
             rs_1.Next;
           end;
         if SendData(root_1.xml) then
            begin
              AddSyncLogFile('成功-消费者数据：'+root_1.xml);
              rs_1.Last;
              MaxTimeStamp := StrtoInt64(rs_1.FieldByName('TIME_STAMP').AsString);
              SetSyncTimeStamp(tbName,MaxTimeStamp,token.shopId);
            end
         else AddSyncLogFile('失败-消费者数据：'+root_1.xml);
       end;
  finally
    rs_1.Free;
  end;
end;

procedure TRtcSyncFactory.AddSyncLogFile(s: string);
var LogFile:string;
begin
  Enter;
  try
    try
      LogFile := DefaultPath+'log\log_rtc_sync'+formatDatetime('YYYYMMDD',date)+'.log';
      AssignFile(F,LogFile);
      if FileExists(LogFile) then Append(F) else rewrite(F);
      try
        Writeln(F,'<'+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+'>'+s);
      finally
        CloseFile(F);
      end;
    except
    end;
  finally
    Leave;
  end;
end;

procedure TRtcSyncFactory.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TRtcSyncFactory.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TRtcSyncFactory.SyncRtcData;
begin
  LoadDllFactory;
  try
    if not dllValid then Exit;
    if not GetToken then Exit;
    GetLicenseCode;
    SetProMax(4);
    SetProPosition(0);
    ProTitle := '正在上传<进货单>...';
    Application.ProcessMessages;
    SyncStockOrder;
    SetProPosition(1);
    ProTitle := '正在上传<销售单>...';
    Application.ProcessMessages;
    SyncSalesOrder;
    SetProPosition(2);
    ProTitle := '正在上传<库存数据>...';
    Application.ProcessMessages;
    SyncStorage;
    SetProPosition(3);
    ProTitle := '正在上传<消费者信息>...';
    Application.ProcessMessages;
    SyncCustomer;
    SetProPosition(4);
  finally
    FreeDllFactory;
  end;
end;

procedure TRtcSyncFactory.LoadDllFactory;
begin
  if dllValid then Exit;
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  dllHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if dllHandle = 0 then Exit;
  dllLoaded := true;

  @GetCustAuthen := GetProcAddress(dllHandle, 'GetCustAuthen');
  if @GetCustAuthen = nil then
     begin
       AddSyncLogFile('加载容器插件失败，插件未实现GetCustAuthen方法...');
       Exit;
     end;
  @SendDataAsync := GetProcAddress(dllHandle, 'SendDataAsync');
  if @SendDataAsync = nil then
     begin
       AddSyncLogFile('加载容器插件失败，插件未实现GetCustAuthen方法...');
       Exit;
     end;
  dllValid := true;
end;

procedure TRtcSyncFactory.FreeDllFactory;
begin
  if not dllLoaded then Exit;
  FreeLibrary(dllHandle);
  dllValid := false; 
  dllLoaded := false;
end;

function TRtcSyncFactory.GetToken:boolean;
var
  rtn:integer;
  ticket:string;
  NetStatus,ticketLength:integer;
begin
  rtn := GetCustAuthen(pchar(appId),NetStatus,pchar(ticket),ticketLength);
  if rtn = 0 then
     begin
     end
  else AddSyncLogFile('容器认证失败，接口返回值='+inttostr(rtn));
  result := (rtn = 0);
end;

function TRtcSyncFactory.SendData(xml:widestring):boolean;
var
  rtn:integer;
  jobId:integer;
  ticket:string;
  data:widestring;
  dataLength:integer;
  ticketLength:integer;
begin
  data := GetXmlHeader(xml);
  ticketLength := Length(ticket);
  dataLength := Length(data);
  rtn := SendDataAsync(pchar(appId),pchar(ticket),ticketLength,pchar(data),dataLength,3,jobId);
  if rtn <> 0 then AddSyncLogFile('异步数据发送失败，接口返回值='+inttostr(rtn));
  result := (rtn = 0);
end;

function TRtcSyncFactory.GetXmlHeader(xml:widestring):widestring;
begin
  result := '<?xml version="1.0" encoding="UTF-8"?>'+xml;
end;

procedure TRtcSyncFactory.SetProTitle(const Value: string);
begin
  FProTitle := Value;
  SetProCaption;
end;

procedure TRtcSyncFactory.SetProHandle(const Value: Hwnd);
begin
  FProHandle := Value;
end;

procedure TRtcSyncFactory.SetProCaption;
begin
  inherited;
  PostMessage(ProHandle, MSC_SET_CAPTION, 0, 2);
  Application.ProcessMessages;
end;

procedure TRtcSyncFactory.SetProMax(max: integer);
begin
  PostMessage(ProHandle, MSC_SET_MAX, max, 0);
  Application.ProcessMessages;
end;

procedure TRtcSyncFactory.SetProPosition(position: integer);
begin
  PostMessage(ProHandle, MSC_SET_POSITION, position, 0);
  Application.ProcessMessages;
end;

initialization
  RtcSyncFactory := TRtcSyncFactory.Create;
finalization
  if Assigned(RtcSyncFactory) then FreeAndNil(RtcSyncFactory);
end.
