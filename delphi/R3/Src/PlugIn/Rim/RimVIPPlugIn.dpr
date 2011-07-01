library RimVIPPlugIn;

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
  ZBase,
  ZDataSet,uFnUtil,
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
  result := '消费者同步插件';
end;
//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 803;
end;
//RSP调用插件时执行此方法
//由R3程序调用，只同步本门店的
function DoExecute(Params:Pchar;var Data:OleVariant):Integer; stdcall;
var basInfo:TZQuery;
//tid 企业号
//cid 会员ID
procedure UpLoadCustomer(tid,custid:string;rs:TZQuery);
function GetGender(n:string;flag:integer):string;
begin
case flag of
0:begin
  if n='0' then
     result := '男'
  else
     result := '女';
  end;
1:begin
  if n='男' then
     result := '0'
  else
     result := '女';
  end;
end;
end;
//对照到RIM的内码。
function GetRimId(id:string;flag:integer):string;
var
  rs:TZQuery;
begin
  result := id;
  if (flag=0) and BasInfo.Locate('GODS_ID',id,[]) then
     result := BasInfo.FieldbyName('SECOND_ID').AsString;
  if (flag=4) and BasInfo.Locate('SORT_ID4',id,[]) then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select BRAND_ID1 from sd_item where ITEM_ID='''+BasInfo.FieldbyName('SECOND_ID').AsString+'''';
         OpenData(GPlugIn,rs);
         result := rs.Fields[0].AsString;
       finally
         rs.Free;
       end;
     end;
end;
function GetStamp(UPD_Date:string;UPD_Time:string):int64;
begin
  upd_time := stringreplace(upd_time,':','',[rfReplaceAll]);
  result := round((fnTime.fnStrToDatetime(UPD_DATE+UPD_TIME)-fnTime.fnStrToDatetime('2011-01-01'))*86400);
end;
var
  tmp,idx:TZQuery;
  Str,idno:string;
  r:integer;
begin
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text := 'select UPD_DATE,UPD_TIME from RIM_VIP_CONSUMER where CONSUMER_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
    OpenData(GPlugIn,tmp);
    Str :='';
    if rs.FieldbyName('ID_NUMBER').AsString='' then idno := '无' else idno := rs.FieldbyName('ID_NUMBER').AsString;
    if not tmp.IsEmpty then
       begin
        if rs.FieldByName('TIME_STAMP').AsInteger>=GetStamp(rs.Fields[0].asString,rs.Fields[1].asString) then //有更新，则上传
           begin
             Str :=
               'update RIM_VIP_CONSUMER set '+
               'CUST_ID='''+custid+''','+
               'CONSUMER_CARD_ID='''+rs.FieldbyName('IC_CARDNO').AsString+''','+
               'CERT_TYPE_ID='''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
               'CERT_ID='''+idno+''','+
               'ADDRESS='''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
               'CR_NAME='''+rs.FieldbyName('CUST_NAME').AsString+''','+
               'GENDER='''+GetGender(rs.FieldbyName('SEX').AsString,1)+''','+
               'BIRTHDAY ='''+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.FieldbyName('BIRTHDAY').AsString))+''','+
               'HOME_TEL='''+rs.FieldbyName('FAMI_TELE').AsString+''','+
               'MOBILE_TEL ='''+rs.FieldbyName('MOVE_TELE').AsString+''','+
               'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
               'DEGREES='''+fnString.FormatStringEx(rs.FieldbyName('DEGREES').AsString,2)+''','+
               'MONTH_PAY='''+fnString.FormatStringEx(rs.FieldbyName('MONTH_PAY').AsString,2)+''','+
               'OCCUPATION='''+fnString.FormatStringEx(rs.FieldbyName('OCCUPATION').AsString,2)+''','+
               'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
               'UPD_DATE='''+formatdatetime('YYYYMMDD',Date())+''','+
               'UPD_TIME='''+formatdatetime('HH:NN:SS',now())+''' '+
               'where CONSUMER_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
           end;
       end
    else
       begin
         Str :=
           'insert into RIM_VIP_CONSUMER(CONSUMER_ID,CUST_ID,CONSUMER_CARD_ID,CERT_TYPE_ID,CERT_ID,ADDRESS,CR_NAME,GENDER,BIRTHDAY,HOME_TEL,MOBILE_TEL,EMAIL,DEGREES,MONTH_PAY,OCCUPATION,JOBUNIT,UPD_DATE,UPD_TIME,CONSUMER_STATUS,'+
           'POP_TYPE,TAR_CONT,FAVOR,is_buynewitem,DAILY_USE,FACT_ID,ITEM_ID,BRAND_ID,STRUCT,ADDRESS_TYPE) '+
           'values('''+rs.FieldbyName('CUST_ID').AsString+''','+
           ''''+custid+''','+
           ''''+rs.FieldbyName('IC_CARDNO').AsString+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
           ''''+idno+''','+
           ''''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
           ''''+rs.FieldbyName('CUST_NAME').AsString+''','+
           ''''+GetGender(rs.FieldbyName('SEX').AsString,1)+''','+
           ''''+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.FieldbyName('BIRTHDAY').AsString))+''','+
           ''''+rs.FieldbyName('FAMI_TELE').AsString+''','+
           ''''+rs.FieldbyName('MOVE_TELE').AsString+''','+
           ''''+rs.FieldbyName('EMAIL').AsString+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('DEGREES').AsString,2)+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('MONTH_PAY').AsString,2)+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('OCCUPATION').AsString,2)+''','+
           ''''+rs.FieldbyName('JOBUNIT').AsString+''','+
           ''''+formatdatetime('YYYYMMDD',Date())+''','+
           ''''+formatdatetime('HH:NN:SS',now())+''',''01'','+
           '''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'')';
       end;
    if Str<>'' then
       begin
         if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
         //开始更新指标
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_VALUE from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
         OpenData(GPlugIn,idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '吸烟日期' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'SMOKE_DATE='+formatDatetime('YYYYMM',fnTime.fnStrtoDate(idx.FieldByName('INDEX_VALUE').AsString) )
                  else
                     Str := 'SMOKE_DATE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '职业' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'DEGREES='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'DEGREES=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '月收入' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'MONTH_PAY='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'MONTH_PAY=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '人口类型' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'POP_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'POP_TYPE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '焦油含量' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'TAR_CONT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'TAR_CONT=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '吸食口味' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'FAVOR='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'FAVOR=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '乐意购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '是否购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '购买新品') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'is_buynewitem='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'is_buynewitem=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '每日吸烟量' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'DAILY_USE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'DAILY_USE=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜好厂家') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜好厂家') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'FACT_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,9)+''''
                  else
                     Str := 'FACT_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱卷烟') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱卷烟') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'ITEM_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,0)+''''
                  else
                     Str := 'ITEM_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱品牌') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱品牌') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'BRAND_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,4)+''''
                  else
                     Str := 'BRAND_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '价位结构') or (idx.FieldbyName('INDEX_NAME').AsString = '常抽价位') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'STRUCT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'STRUCT=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '城农网') or (idx.FieldbyName('INDEX_NAME').AsString = '地址类型') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'ADDRESS_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'ADDRESS_TYPE=''#''';
                end;
             Str := 'update RIM_VIP_CONSUMER set '+Str+' where CONSUMER_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
             if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
             idx.Next;
           end;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;
//tid 企业号
procedure SyncCustomer(tid,sid:string);
var
  str,CustID: string;
  rs: TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      OpenData(GPlugIn,rs);
      if rs.IsEmpty then Raise Exception.Create('许可证号在RIM中没找到，请核对许可证号...'); 
      custid := rs.fieldbyname('CUST_ID').AsString;
      rs.Close;
      rs.SQL.Text:=
         'select A.CUST_ID,A.CUST_NAME,A.IDN_TYPE,A.ID_NUMBER,A.FAMI_ADDR,A.SEX,A.BIRTHDAY,A.FAMI_TELE,A.MOVE_TELE,A.POSTALCODE,A.EMAIL,'+
         'B.IC_CARDNO,B.CREA_DATE,B.END_DATE,B.IC_STATUS,'+
         'A.MONTH_PAY,A.DEGREES,A.OCCUPATION,A.JOBUNIT,A.TIME_STAMP '+
         'from PUB_CUSTOMER A,PUB_IC_INFO B where A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.SHOP_ID<>''#'' and B.UNION_ID in (select PRICE_ID from PUB_PRICEGRADE where TENANT_ID in (select TENANT_ID from CA_RELATIONS where RELATI_ID='+tid+' AND RELATION_ID=1000006) and PRICE_TYPE=''2'') and A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID';
      OpenData(GPlugIn, rs);
      if rs.IsEmpty then Exit;
      rs.First;
      while not rs.Eof do
      begin
        if GPlugIn.BeginTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        try
          //把此会员信息，同步上去
          UpLoadCustomer(tid,custid,rs);
          if GPlugIn.CommitTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        except
          if GPlugIn.RollbackTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          Raise
        end;
      rs.Next;
      end;
  finally
    rs.Free;
  end;
end;
var
  ParamList:TftParamList;
  custid:string;
  rs:TZQuery;
begin
  try
    //开始执行插件该做的工作.
    ParamList := TftParamList.Create(nil);
    rs := TZQuery.Create(nil);
    BasInfo := TZQuery.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      BasInfo.Close;
      BasInfo.SQL.Text := 'select GODS_ID,SORT_ID4,SORT_ID9 from VIW_GOODSINFO where TENANT_ID='+ParamList.ParambyName('TENANT_ID').asString;
      OpenData(GPlugIn,BasInfo);
      if ParamList.FindParam('SHOP_ID')<>nil then //报当前门店的
         begin
           SyncCustomer(ParamList.ParambyName('TENANT_ID').asString,ParamList.ParambyName('SHOP_ID').asString);
         end
      else
         begin
           rs.Close;
           rs.SQL.Text := 'select TENANT_ID,SHOP_ID from CA_SHOP_INFO where TENANT_ID='+ParamList.ParambyName('TENANT_ID').asString+'';
           OpenData(GPlugIn,rs);
           rs.First;
           while not rs.Eof do
             begin
               SyncCustomer(ParamList.ParambyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').AsString);
               rs.Next;
             end;
         end;
    finally
      BasInfo.Free;
      rs.Free;
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
