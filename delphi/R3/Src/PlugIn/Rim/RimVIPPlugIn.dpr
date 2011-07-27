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
  ZDataSet,
  uFnUtil,
  uPlugInUtil in '..\obj\uPlugInUtil.pas',
  ufrmRimConfig in 'ufrmRimConfig.pas' {frmRimConfig};

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
     result := '1';
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
//对照到RIM的内码。
function GetR3Id(id:string;flag:integer):string;
var
  rs:TZQuery;
begin
  result := id;
  if (flag=0) and BasInfo.Locate('SECOND_ID',id,[]) then
     result := BasInfo.FieldbyName('GODS_ID').AsString;
  if (flag=4) then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select ITEM_ID from sd_item A,RIM_GOODS_RELATION B where A.BRAND_ID1='''+id+''' and A.ITEM_ID=B.GODS_ID';
         OpenData(GPlugIn,rs);
         if not rs.IsEmpty and BasInfo.Locate('GODS_ID',rs.Fields[0].AsString,[]) then
            result := rs.FieldbyName('SORT_ID4').AsString;
       finally
         rs.Free;
       end;
     end;
end;
function GetStamp(UPD_Date:string;UPD_Time:string):int64;
begin
  upd_time := stringreplace(upd_time,':','',[rfReplaceAll]);
  result := round((fnTime.fnStrToDatetime(UPD_DATE+UPD_TIME)-fnTime.fnStrtoDatetime('20110101000000'))*86400);
end;
function GetCurDate(s:string;format:string='YYYY-MM-DD'):string;
begin
  if s='' then result := 'null'
  else
     begin
       result := ''''+formatDatetime(format,fnTime.fnStrtoDate(s))+'''';
     end;
end;
procedure DownLoadCustomer(tid,custid,sid,rid,pid:string;rs:TZQuery);
var
  tmp,idx:TZQuery;
  Str,IcStr,IcStr1,idno,ctid,crname:string;
  r:integer;
begin
  ctid := rs.FieldbyName('CONSUMER_ID').asString;
  for r :=length(rs.FieldbyName('CONSUMER_ID').asString)+1 to 36 do ctid := ctid +'$';
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    crname := rs.FieldbyName('CR_NAME').asString;
    if crname='' then crname:='不记名';
    tmp.Close;
    tmp.SQL.Text := 'select TIME_STAMP from PUB_CUSTOMER where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
    OpenData(GPlugIn,tmp);
    Str :='';
    if not tmp.IsEmpty then
       begin
        if tmp.FieldByName('TIME_STAMP').AsInteger<GetStamp(rs.FieldbyName('UPD_DATE').AsString,rs.FieldbyName('UPD_TIME').AsString) then //有更新，则上传
           begin
             Str :=
               'update PUB_CUSTOMER set '+
               'SHOP_ID='''+sid+''','+
               'REGION_ID='''+rid+''','+
               'CUST_CODE='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','+
               'IDN_TYPE='''+inttostr(StrtoIntDef(rs.FieldbyName('CERT_TYPE_ID').AsString,1))+''','+
               'ID_NUMBER='''+rs.FieldbyName('CERT_ID').AsString+''','+
               'FAMI_ADDR='''+rs.FieldbyName('ADDRESS').AsString+''','+
               'CUST_NAME='''+crname+''','+
               'CUST_SPELL='''+crname+''','+
               'SEX='''+GetGender(rs.FieldbyName('GENDER').AsString,0)+''','+
               'BIRTHDAY ='+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
               'FAMI_TELE='''+rs.FieldbyName('HOME_TEL').AsString+''','+
               'MOVE_TELE ='''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
               'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
               'DEGREES='''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
               'MONTH_PAY='''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
               'OCCUPATION='''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
               'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
               'TIME_STAMP='+inttostr(GetStamp(rs.FieldbyName('UPD_DATE').AsString,rs.FieldbyName('UPD_TIME').AsString))+' '+
               'where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
               IcStr := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID='''+pid+'''';
               IcStr1 := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID=''#''';
           end;
       end
    else
       begin
         Str :=
           'insert into PUB_CUSTOMER(TENANT_ID,SHOP_ID,CUST_ID,PRICE_ID,CUST_CODE,IDN_TYPE,ID_NUMBER,FAMI_ADDR,CUST_NAME,CUST_SPELL,SEX,BIRTHDAY,FAMI_TELE,MOVE_TELE,EMAIL,DEGREES,MONTH_PAY,OCCUPATION,JOBUNIT,REGION_ID,COMM,TIME_STAMP) '+
           'values('+tid+','''+sid+''','''+ctid+''','+
           ''''+pid+''','+
           ''''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('CERT_TYPE_ID').AsString,1))+''','+
           ''''+rs.FieldbyName('CERT_ID').AsString+''','+
           ''''+rs.FieldbyName('ADDRESS').AsString+''','+
           ''''+crname+''','+
           ''''+crname+''','+
           ''''+GetGender(rs.FieldbyName('GENDER').AsString,0)+''','+
           ''+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
           ''''+rs.FieldbyName('HOME_TEL').AsString+''','+
           ''''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
           ''''+rs.FieldbyName('EMAIL').AsString+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
           ''''+rs.FieldbyName('JOBUNIT').AsString+''','+
           ''''+rid+''','+
           '''00'','+inttostr(GetStamp(rs.FieldbyName('UPD_DATE').AsString,rs.FieldbyName('UPD_TIME').AsString))+')';

           IcStr :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''','''+pid+''','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''烟草消费者'',''system'',''1'',''1'',''00'','+GetTimeStamp(GdbType)+')';
             
           IcStr1 :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''',''#'','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''烟草消费者店内积分'',''system'',''1'',''0'',''00'','+GetTimeStamp(GdbType)+')';
             
       end;
    if Str<>'' then
       begin
         if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
         if IcStr<>'' then
            begin
              if GPlugIn.ExecSQL(Pchar(IcStr),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
              if GPlugIn.ExecSQL(Pchar(IcStr1),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
            end;
         Str := 'delete from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
         if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
         //开始更新指标
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_TYPE from PUB_UNION_INDEX where UNION_ID='''+pid+'''';
         OpenData(GPlugIn,idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '吸烟日期' then
                begin
                  if rs.FieldbyName('SMOKE_DATE').AsString<>'' then
                     begin
                       if length(rs.FieldbyName('SMOKE_DATE').AsString)=6 then
                          icStr := rs.FieldbyName('SMOKE_DATE').AsString+'01'
                       else
                          icStr := rs.FieldbyName('SMOKE_DATE').AsString;
                       Str :=
                        'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                        'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                        formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(icStr))
                        +''',''00'','+GetTimeStamp(GdbType)+')';
                       if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                     end;
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '职业' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DEGREES').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '月收入' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('MONTH_PAY').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '人口类型' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('POP_TYPE').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '焦油含量' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('TAR_CONT').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '吸食口味' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('FAVOR').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '乐意购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '是否购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '购买新品') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('is_buynewitem').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '每日吸烟量' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜好厂家') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜好厂家') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱卷烟') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱卷烟') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('ITEM_ID').AsString,0)
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱品牌') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱品牌') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('BRAND_ID').AsString,4)
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '价位结构') or (idx.FieldbyName('INDEX_NAME').AsString = '常抽价位') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('STRUCT').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '城农网') or (idx.FieldbyName('INDEX_NAME').AsString = '地址类型') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('ADDRESS_TYPE').AsString
                  +''',''00'','+GetTimeStamp(GdbType)+')';
                  if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
                end;
             idx.Next;
           end;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;
//tid 企业号
//cid 会员ID
procedure UpLoadCustomer(tid,custid:string;rs:TZQuery);
var
  tmp,idx:TZQuery;
  Str,idno,ctid:string;
  r:integer;
begin
  ctid := StringReplace(rs.FieldbyName('CUST_ID').AsString,'$','',[rfReplaceAll]);
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text := 'select UPD_DATE,UPD_TIME from RIM_VIP_CONSUMER where CONSUMER_ID='''+ctid+'''';
    OpenData(GPlugIn,tmp);
    Str :='';
    if rs.FieldbyName('ID_NUMBER').AsString='' then idno := '无' else idno := rs.FieldbyName('ID_NUMBER').AsString;
    if not tmp.IsEmpty then
       begin
        if rs.FieldByName('TIME_STAMP').AsInteger>=GetStamp(tmp.Fields[0].asString,tmp.Fields[1].asString) then //有更新，则上传
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
               'BIRTHDAY ='+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString,'YYYYMMDD')+','+
               'HOME_TEL='''+rs.FieldbyName('FAMI_TELE').AsString+''','+
               'MOBILE_TEL ='''+rs.FieldbyName('MOVE_TELE').AsString+''','+
               'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
               'DEGREES='''+fnString.FormatStringEx(rs.FieldbyName('DEGREES').AsString,2)+''','+
               'MONTH_PAY='''+fnString.FormatStringEx(rs.FieldbyName('MONTH_PAY').AsString,2)+''','+
               'OCCUPATION='''+fnString.FormatStringEx(rs.FieldbyName('OCCUPATION').AsString,2)+''','+
               'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
               'UPD_DATE='''+formatdatetime('YYYYMMDD',Date())+''','+
               'UPD_TIME='''+formatdatetime('HH:NN:SS',now())+''' '+
               'where CONSUMER_ID='''+ctid+'''';
           end;
       end
    else
       begin
         Str :=
           'insert into RIM_VIP_CONSUMER(CONSUMER_ID,CUST_ID,CONSUMER_CARD_ID,CERT_TYPE_ID,CERT_ID,ADDRESS,CR_NAME,GENDER,BIRTHDAY,HOME_TEL,MOBILE_TEL,EMAIL,DEGREES,MONTH_PAY,OCCUPATION,JOBUNIT,UPD_DATE,UPD_TIME,CONSUMER_STATUS,'+
           'POP_TYPE,TAR_CONT,FAVOR,is_buynewitem,DAILY_USE,FACT_ID,ITEM_ID,BRAND_ID,STRUCT,ADDRESS_TYPE) '+
           'values('''+ctid+''','+
           ''''+custid+''','+
           ''''+rs.FieldbyName('IC_CARDNO').AsString+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
           ''''+idno+''','+
           ''''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
           ''''+rs.FieldbyName('CUST_NAME').AsString+''','+
           ''''+GetGender(rs.FieldbyName('SEX').AsString,1)+''','+
           ''+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString,'YYYYMMDD')+','+
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
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'SMOKE_DATE='''+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(idx.FieldByName('INDEX_VALUE').AsString) )+''''
                  else
                     Str := Str +'SMOKE_DATE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '职业' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DEGREES='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DEGREES=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '月收入' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'MONTH_PAY='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'MONTH_PAY=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '人口类型' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'POP_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'POP_TYPE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '焦油含量' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'TAR_CONT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'TAR_CONT=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '吸食口味' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FAVOR='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'FAVOR=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '乐意购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '是否购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '购买新品') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'is_buynewitem='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'is_buynewitem=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '每日吸烟量' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DAILY_USE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DAILY_USE=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜好厂家') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜好厂家') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FACT_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,9)+''''
                  else
                     Str := Str +'FACT_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱卷烟') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱卷烟') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'ITEM_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,0)+''''
                  else
                     Str := Str +'ITEM_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱品牌') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱品牌') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'BRAND_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,4)+''''
                  else
                     Str := Str +'BRAND_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '价位结构') or (idx.FieldbyName('INDEX_NAME').AsString = '常抽价位') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'STRUCT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'STRUCT=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '城农网') or (idx.FieldbyName('INDEX_NAME').AsString = '地址类型') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'ADDRESS_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'ADDRESS_TYPE=''#''';
                end;
             idx.Next;
           end;
        if Str<>'' then
           begin
             Str := 'update RIM_VIP_CONSUMER set '+Str+' where CONSUMER_ID='''+ctid+'''';
             if GPlugIn.ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
           end;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;
//tid 企业号
procedure SyncCustomer(tid,sid,pid:string;today:boolean=false);
var
  str,CustID,rid: string;
  rs: TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID,B.REGION_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      OpenData(GPlugIn,rs);
      if rs.IsEmpty then
         begin
            Raise Exception.Create(sid+'门店的许可证号在RIM中没找到，请核对许可证号...');
         end;
      custid := rs.fieldbyname('CUST_ID').AsString;
      rid := rs.fieldbyname('REGION_ID').AsString;
      //上传消费者
      rs.Close;
      rs.SQL.Text:=
         'select A.CUST_ID,A.CUST_NAME,A.IDN_TYPE,A.ID_NUMBER,A.FAMI_ADDR,A.SEX,A.BIRTHDAY,A.FAMI_TELE,A.MOVE_TELE,A.POSTALCODE,A.EMAIL,'+
         'B.IC_CARDNO,B.CREA_DATE,B.END_DATE,B.IC_STATUS,'+
         'A.MONTH_PAY,A.DEGREES,A.OCCUPATION,A.JOBUNIT,A.TIME_STAMP '+
         'from PUB_CUSTOMER A,PUB_IC_INFO B where A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.SHOP_ID<>''#'' and B.UNION_ID='''+pid+''' and A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID';
      if today then rs.SQL.Text := rs.SQL.Text + ' and A.SND_DATE='''+formatDatetime('YYYY-MM-DD',date())+'''';
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
      if toDay then Exit;
      //下载消费者
      rs.Close;
      rs.SQL.Text:=
         'select * from RIM_VIP_CONSUMER where CUST_ID='''+custid+''' and CONSUMER_STATUS=''03'' ';
      OpenData(GPlugIn, rs);
      if rs.IsEmpty then Exit;
      rs.First;
      while not rs.Eof do
      begin
        if GPlugIn.BeginTrans<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        try
          //把此会员信息，同步上去
          DownLoadCustomer(tid,custid,sid,rid,pid,rs);
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
function GetPriceId(tid:string):string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select PRICE_ID from PUB_PRICEGRADE where TENANT_ID in (select TENANT_ID from CA_RELATIONS where RELATI_ID='+tid+' AND RELATION_ID=1000006) and PRICE_TYPE=''2''';
    OpenData(GPlugIn,rs);
    result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;
var
  ParamList:TftParamList;
  custid,pid:string;
  rs:TZQuery;
begin
  try
    if GPlugIn.iDbType(GdbType) <> 0 then Raise Exception.Create(GPlugIn.GetLastError);
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
           pid := GetPriceId(ParamList.ParambyName('TENANT_ID').asString);
           try
             if pid='' then SyncCustomer(ParamList.ParambyName('TENANT_ID').asString,ParamList.ParambyName('SHOP_ID').asString,pid,true);
             GPlugIn.WriteLogFile(Pchar('<'+ParamList.ParambyName('SHOP_ID').asString+'>同步完毕'));
           except
             on E:Exception do
                begin
                  GPlugIn.WriteLogFile(Pchar('<'+ParamList.ParambyName('SHOP_ID').asString+'>'+E.Message));
                end;
           end;
         end
      else
         begin
           rs.Close;
           rs.SQL.Text := 'select TENANT_ID,SHOP_ID from CA_SHOP_INFO where TENANT_ID in (select RELATI_ID from CA_RELATIONS where TENANT_ID='+ParamList.ParambyName('TENANT_ID').asString+' and RELATION_ID=1000006)';
           OpenData(GPlugIn,rs);
           rs.First;
           while not rs.Eof do
             begin
               pid := GetPriceId(rs.FieldbyName('TENANT_ID').asString);
               try
                 if pid<>'' then SyncCustomer(rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').AsString,pid,false);
                 GPlugIn.WriteLogFile(Pchar('<'+rs.FieldbyName('SHOP_ID').AsString+'>同步完毕'));
               except
                 on E:Exception do
                    begin
                      GPlugIn.WriteLogFile(Pchar('<'+rs.FieldbyName('SHOP_ID').AsString+'>'+E.Message));
                    end;
               end;
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
