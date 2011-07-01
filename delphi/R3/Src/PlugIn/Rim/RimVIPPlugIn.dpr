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
//RSPװ�ز��ʱ���ã�������ɷ��ʵķ���ӿ�
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;
//�����ִ�е����в���������� try except end �������ʱ���ɴ˷������ش���Ϣ
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;
//���ص�ǰ���˵��
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := '������ͬ�����';
end;
//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 803;
end;
//RSP���ò��ʱִ�д˷���
//��R3������ã�ֻͬ�����ŵ��
function DoExecute(Params:Pchar;var Data:OleVariant):Integer; stdcall;
var basInfo:TZQuery;
//tid ��ҵ��
//cid ��ԱID
procedure UpLoadCustomer(tid,custid:string;rs:TZQuery);
function GetGender(n:string;flag:integer):string;
begin
case flag of
0:begin
  if n='0' then
     result := '��'
  else
     result := 'Ů';
  end;
1:begin
  if n='��' then
     result := '0'
  else
     result := 'Ů';
  end;
end;
end;
//���յ�RIM�����롣
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
    if rs.FieldbyName('ID_NUMBER').AsString='' then idno := '��' else idno := rs.FieldbyName('ID_NUMBER').AsString;
    if not tmp.IsEmpty then
       begin
        if rs.FieldByName('TIME_STAMP').AsInteger>=GetStamp(rs.Fields[0].asString,rs.Fields[1].asString) then //�и��£����ϴ�
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
         //��ʼ����ָ��
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_VALUE from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
         OpenData(GPlugIn,idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '��������' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'SMOKE_DATE='+formatDatetime('YYYYMM',fnTime.fnStrtoDate(idx.FieldByName('INDEX_VALUE').AsString) )
                  else
                     Str := 'SMOKE_DATE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ְҵ' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'DEGREES='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'DEGREES=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '������' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'MONTH_PAY='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'MONTH_PAY=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '�˿�����' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'POP_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'POP_TYPE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '���ͺ���' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'TAR_CONT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'TAR_CONT=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '��ʳ��ζ' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'FAVOR='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'FAVOR=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '���⹺����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '�Ƿ�����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '������Ʒ') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'is_buynewitem='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'is_buynewitem=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ÿ��������' then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'DAILY_USE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'DAILY_USE=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ�ó���') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ�ó���') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'FACT_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,9)+''''
                  else
                     Str := 'FACT_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ������') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ������') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'ITEM_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,0)+''''
                  else
                     Str := 'ITEM_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ��Ʒ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ��Ʒ��') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'BRAND_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,4)+''''
                  else
                     Str := 'BRAND_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��λ�ṹ') or (idx.FieldbyName('INDEX_NAME').AsString = '�����λ') then
                begin
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := 'STRUCT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := 'STRUCT=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��ũ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ַ����') then
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
//tid ��ҵ��
procedure SyncCustomer(tid,sid:string);
var
  str,CustID: string;
  rs: TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      OpenData(GPlugIn,rs);
      if rs.IsEmpty then Raise Exception.Create('���֤����RIM��û�ҵ�����˶����֤��...'); 
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
          //�Ѵ˻�Ա��Ϣ��ͬ����ȥ
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
    //��ʼִ�в�������Ĺ���.
    ParamList := TftParamList.Create(nil);
    rs := TZQuery.Create(nil);
    BasInfo := TZQuery.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      BasInfo.Close;
      BasInfo.SQL.Text := 'select GODS_ID,SORT_ID4,SORT_ID9 from VIW_GOODSINFO where TENANT_ID='+ParamList.ParambyName('TENANT_ID').asString;
      OpenData(GPlugIn,BasInfo);
      if ParamList.FindParam('SHOP_ID')<>nil then //����ǰ�ŵ��
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
//RSP���ò���Զ���Ĺ������,û��ʱֱ�ӷ���0
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
