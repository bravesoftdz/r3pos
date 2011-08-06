{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uVipFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uFnUtil, uBaseSyncFactory, uRimSyncFactory;

type
  TVipSyncFactory=class(TRimSyncFactory)
  private
    UpLoadFlag: Boolean; //�ϴ���Ա���λ[true���ϴ���false���ϴ�]
    ShopInfo: string; //��ǰ�ŵ���Ϣ
    basInfo: TZQuery;
    //�����Ա�
    function GetGender(n:string;flag:integer):string;
    //���յ�RIM�����롣
    function GetRimId(id:string;flag:integer):string;
    //���յ�R3�����롣
    function GetR3Id(id:string;flag:integer):string;
    //����ʱ���
    function GetStamp(UPD_Date:string;UPD_Time:string):int64;
    //���ص�ǰ���ڣ�
    function GetCurDate(s:string;format:string='YYYY-MM-DD'):string;
    //���ؼ۸�ȼ���
    function GetPriceId(tid:string):string;
    //����ԭд��־��
    procedure WriteLogRun(ReportName: string=''); override;  //�����ϱ�    

    //���ػ�Ա 
    function DownLoadCustomer(tid,custid,sid,rid,pid:string;rs:TZQuery): integer; 
    //�ϴ���Ա��tid ��ҵ��  cid ��ԱID
    function UpLoadCustomer(tid,custid:string;rs:TZQuery):integer;
    //ͬ����Ա��tid ��ҵ��
    function SyncCustomer(tid,sid,pid:string;today:boolean=false): Boolean;
  public
    constructor Create; override;
    destructor Destroy;override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;
 
implementation

{ TIVTSyncFactory }

function TVipSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
  custid,pid,SHOP_ID:string;
  RsShop: TZQuery;
begin
  result:=-1;
  PlugInID:='803';
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��[]

  BasInfo.Close;
  BasInfo.SQL.Text := 'select GODS_ID,SORT_ID4,SORT_ID9 from VIW_GOODSINFO where TENANT_ID='+Params.ParambyName('TENANT_ID').asString;
  Open(BasInfo);

  if Params.FindParam('SHOP_ID')<>nil then //����ǰ�ŵ�Ļ�Ա
  begin
    pid := GetPriceId(Params.ParambyName('TENANT_ID').asString);
    try
      if pid<>'' then
       SyncCustomer(Params.ParambyName('TENANT_ID').asString,Params.ParambyName('SHOP_ID').asString,pid,true);
    except
      on E:Exception do
      begin
        PlugIntf.WriteLogFile(Pchar('<'+Params.ParambyName('SHOP_ID').asString+'>������ͬ��[�ϴ�]����'+E.Message));
      end;
    end;
  end else  //Rsp��������ִ��
  begin
    try
      BeginLogRun; //��ʼ��־         
      RsShop:=TZQuery.Create(nil);
      RsShop.SQL.Text := 'select TENANT_ID,SHOP_ID,SHOP_NAME,LICENSE_CODE from CA_SHOP_INFO where TENANT_ID in (select RELATI_ID from CA_RELATIONS where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and RELATION_ID=1000006)';
      Open(RsShop);
      if RsShop.Active then FRunInfo.AllCount:=RsShop.RecordCount;
      //���ŵ�ѭ��ͬ��
      RsShop.First;
      while not RsShop.Eof do
      begin
        SHOP_ID:= RsShop.FieldByName('SHOP_ID').AsString;
        pid := GetPriceId(RsShop.FieldbyName('TENANT_ID').asString);
        try
          //д��־ʹ��
          if RsShop.RecordCount=1 then ShopInfo:='�ŵ�<'+SHOP_ID+'>' else ShopInfo:='('+InttoStr(RsShop.RecNo)+')�ŵ�<'+SHOP_ID+'>';

          if pid<>'' then
            SyncCustomer(RsShop.FieldbyName('TENANT_ID').asString,SHOP_ID,pid,false)
          else
            WriteToLogList(ShopInfo+' �Ҳ����۸�ȼ�', true, False);
        except
          on E:Exception do
          begin
            PlugIntf.WriteLogFile(Pchar('<'+PlugInID+'><'+RsShop.FieldbyName('SHOP_ID').AsString+'>Error��'+E.Message));
          end;
        end;
        RsShop.Next;
      end;
    finally   
      WriteLogRun;
      RsShop.Free;
    end;
  end;
end;


constructor TVipSyncFactory.Create;
begin
  inherited;
  basInfo:=TZQuery.Create(nil);
  UpLoadFlag:=trim(ReadConfig('PARAMS','VipUpload','1'))<>'0';
end;

destructor TVipSyncFactory.Destroy;
begin
  basInfo.Free;
  inherited;
end;

//�����Ա�
function TVipSyncFactory.GetGender(n: string; flag: integer): string;
begin
  //RIM:  0:�С�1:Ů  
  //R3:   0:Ů��1:�� 2:����  
  case flag of
   0: //R3-->Rim
    begin
      if n='0' then
        result := '1'
      else if n='1' then
        result := '0'
      else
        result := '0'; //��R3���ܵ��ϴ�������
    end;
   1: //RIM-->R3
    begin
      if n='0' then
        result := '1'
      else if n='1' then
        result := '0'
      else
        result := '2';
    end;
  end;
end;

//���յ�RIM�����롣
function TVipSyncFactory.GetRimId(id: string; flag: integer): string;
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
       Open(rs);
       result := rs.Fields[0].AsString;
     finally
       rs.Free;
     end;
   end;
end;

//���յ�RIM�����롣
function TVipSyncFactory.GetR3Id(id: string; flag: integer): string;
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
       if Open(rs) then
       begin
         if not rs.IsEmpty and BasInfo.Locate('GODS_ID',rs.Fields[0].AsString,[]) then
           result := rs.FieldbyName('SORT_ID4').AsString;
       end;
     finally
       rs.Free;
     end;
   end;
end;

function TVipSyncFactory.GetCurDate(s, format: string): string;
begin
  if s='' then
    result := 'null'
  else
    result := ''''+formatDatetime(format,fnTime.fnStrtoDate(s))+'''';
end;

function TVipSyncFactory.GetStamp(UPD_Date, UPD_Time: string): int64;
begin
  upd_time := stringreplace(upd_time,':','',[rfReplaceAll]);
  result := round((fnTime.fnStrToDatetime(UPD_DATE+UPD_TIME)-fnTime.fnStrtoDatetime('20110101000000'))*86400);
end;

function TVipSyncFactory.GetPriceId(tid: string): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select PRICE_ID from PUB_PRICEGRADE where TENANT_ID in (select TENANT_ID from CA_RELATIONS where RELATI_ID='+tid+' AND RELATION_ID=1000006) and PRICE_TYPE=''2''';
    Open(rs);
    result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

function TVipSyncFactory.DownLoadCustomer(tid, custid, sid, rid, pid: string; rs: TZQuery):integer;
var
  tmp,idx:TZQuery;
  Str,IcStr,IcStr1,idno,ctid,crname:string;
  r:integer;
begin
  result:=0;
  ctid := rs.FieldbyName('CONSUMER_ID').asString;
  for r :=length(rs.FieldbyName('CONSUMER_ID').asString)+1 to 36 do ctid := ctid +'$';
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    crname := rs.FieldbyName('CR_NAME').asString;
    if crname='' then crname:='������';
    tmp.Close;
    tmp.SQL.Text := 'select TIME_STAMP from PUB_CUSTOMER where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
    Open(tmp); 
    Str :='';
    if not tmp.IsEmpty then
     begin
      if tmp.FieldByName('TIME_STAMP').AsInteger<GetStamp(rs.FieldbyName('UPD_DATE').AsString,rs.FieldbyName('UPD_TIME').AsString) then //�и��£����ϴ�
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
             'SEX='''+GetGender(rs.FieldbyName('GENDER').AsString,1)+''','+
             'BIRTHDAY ='+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
             'FAMI_TELE='''+rs.FieldbyName('HOME_TEL').AsString+''','+
             'MOVE_TELE ='''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
             'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
             'DEGREES='''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
             'MONTH_PAY='''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
             'OCCUPATION='''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
             'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
             'TIME_STAMP='+TBaseSyncFactory.GetTimeStamp(DbType)+' '+
             'where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
             IcStr := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''',TIME_STAMP='+TBaseSyncFactory.GetTimeStamp(DbType)+' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID='''+pid+'''';
             IcStr1 := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''',TIME_STAMP='+TBaseSyncFactory.GetTimeStamp(DbType)+' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID=''#''';
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
           ''''+GetGender(rs.FieldbyName('GENDER').AsString,1)+''','+
           ''+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
           ''''+rs.FieldbyName('HOME_TEL').AsString+''','+
           ''''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
           ''''+rs.FieldbyName('EMAIL').AsString+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
           ''''+rs.FieldbyName('JOBUNIT').AsString+''','+
           ''''+rid+''','+
           '''00'','+TBaseSyncFactory.GetTimeStamp(DbType)+')';

           IcStr :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''','''+pid+''','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''�̲�������'',''system'',''1'',''1'',''00'','+GetTimeStamp(DbType)+')';
             
           IcStr1 :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''',''#'','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''�̲������ߵ��ڻ���'',''system'',''1'',''0'',''00'','+GetTimeStamp(DbType)+')';
             
       end;
    if Str<>'' then
       begin            
         if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
         if IcStr<>'' then
            begin
              if ExecSQL(Pchar(IcStr),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
              if ExecSQL(Pchar(IcStr1),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
            end;
         Str := 'delete from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
         if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);

         //��ʼ����ָ��
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_TYPE from PUB_UNION_INDEX where UNION_ID='''+pid+'''';
         Open(idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '��������' then
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
                        +''',''00'','+GetTimeStamp(DbType)+')';
                       if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                     end;
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ְҵ' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DEGREES').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '������' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('MONTH_PAY').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '�˿�����' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('POP_TYPE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '���ͺ���' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('TAR_CONT').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '��ʳ��ζ' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('FAVOR').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '���⹺����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '�Ƿ�����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '������Ʒ') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('is_buynewitem').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ÿ��������' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ�ó���') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ�ó���') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ������') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ������') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('ITEM_ID').AsString,0)
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ��Ʒ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ��Ʒ��') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('BRAND_ID').AsString,4)
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��λ�ṹ') or (idx.FieldbyName('INDEX_NAME').AsString = '�����λ') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('STRUCT').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��ũ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ַ����') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('ADDRESS_TYPE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
                end;
             idx.Next;
           end; //while not idx.Eof do
         result:=1;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;

function TVipSyncFactory.UpLoadCustomer(tid, custid: string; rs: TZQuery): integer;
var
  tmp,idx:TZQuery;
  Str,idno,ctid:string;
  r:integer;
begin
  result:=0;
  ctid := StringReplace(rs.FieldbyName('CUST_ID').AsString,'$','',[rfReplaceAll]);
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text := 'select UPD_DATE,UPD_TIME from RIM_VIP_CONSUMER where CONSUMER_ID='''+ctid+'''';
    Open(tmp);
    Str :='';
    if rs.FieldbyName('ID_NUMBER').AsString='' then idno := '��' else idno := rs.FieldbyName('ID_NUMBER').AsString;
    if not tmp.IsEmpty then
       begin
        if rs.FieldByName('TIME_STAMP').AsInteger>=GetStamp(tmp.Fields[0].asString,tmp.Fields[1].asString) then //�и��£����ϴ�
           begin
             Str :=
               'update RIM_VIP_CONSUMER set '+
               'CUST_ID='''+custid+''','+
               'CONSUMER_CARD_ID='''+rs.FieldbyName('IC_CARDNO').AsString+''','+
               'CERT_TYPE_ID='''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
               'CERT_ID='''+idno+''','+
               'ADDRESS='''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
               'CR_NAME='''+rs.FieldbyName('CUST_NAME').AsString+''','+
               'GENDER='''+GetGender(rs.FieldbyName('SEX').AsString,0)+''','+
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
           ''''+GetGender(rs.FieldbyName('SEX').AsString,0)+''','+
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
         if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
         //��ʼ����ָ��
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_VALUE from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
         Open(idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '��������' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'SMOKE_DATE='''+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(idx.FieldByName('INDEX_VALUE').AsString) )+''''
                  else
                     Str := Str +'SMOKE_DATE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ְҵ' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DEGREES='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DEGREES=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '������' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'MONTH_PAY='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'MONTH_PAY=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '�˿�����' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'POP_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'POP_TYPE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '���ͺ���' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'TAR_CONT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'TAR_CONT=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '��ʳ��ζ' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FAVOR='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'FAVOR=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '���⹺����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '�Ƿ�����Ʒ') or (idx.FieldbyName('INDEX_NAME').AsString = '������Ʒ') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'is_buynewitem='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'is_buynewitem=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = 'ÿ��������' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DAILY_USE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DAILY_USE=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ�ó���') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ�ó���') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FACT_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,9)+''''
                  else
                     Str := Str +'FACT_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ������') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ������') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'ITEM_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,0)+''''
                  else
                     Str := Str +'ITEM_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = 'ϲ��Ʒ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ϲ��Ʒ��') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'BRAND_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,4)+''''
                  else
                     Str := Str +'BRAND_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��λ�ṹ') or (idx.FieldbyName('INDEX_NAME').AsString = '�����λ') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'STRUCT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'STRUCT=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '��ũ��') or (idx.FieldbyName('INDEX_NAME').AsString = '��ַ����') then
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
             if ExecSQL(Pchar(Str),r)<>0 then Raise Exception.Create(PlugIntf.GetLastError);
             result:=1;
           end;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;

function TVipSyncFactory.SyncCustomer(tid, sid, pid: string; today: boolean): Boolean;
var
  str,CustID,rid,UpMsg,DownMsg: string;
  DCount,DErrCount,UCount,UErrCount,ReRun: integer;
  rs: TZQuery;
begin
  result:=False;
  UCount:=0;
  UErrCount:=0;
  DCount:=0;
  DErrCount:=0;
  UpMsg:='';
  DownMsg:='';

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID,B.REGION_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
    Open(rs);
    if rs.IsEmpty then
    begin
      WriteToLogList(ShopInfo+'��RIM��û�ҵ�...',False,False);
      Raise Exception.Create(sid+'�ŵ�����֤����RIM��û�ҵ�����˶����֤��...');
    end;
    custid := rs.fieldbyname('CUST_ID').AsString;
    rid := rs.fieldbyname('REGION_ID').AsString;

    //�ϴ������� [ȫ��дRim��ֱ�ӿ�������]
    if UpLoadFlag then
    begin
      rs.Close;
      rs.SQL.Text:=
         'select A.CUST_ID,A.CUST_NAME,A.IDN_TYPE,A.ID_NUMBER,A.FAMI_ADDR,A.SEX,A.BIRTHDAY,A.FAMI_TELE,A.MOVE_TELE,A.POSTALCODE,A.EMAIL,'+
         'B.IC_CARDNO,B.CREA_DATE,B.END_DATE,B.IC_STATUS,'+
         'A.MONTH_PAY,A.DEGREES,A.OCCUPATION,A.JOBUNIT,A.TIME_STAMP '+
         'from PUB_CUSTOMER A,PUB_IC_INFO B '+
         ' where A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.SHOP_ID<>''#'' and B.UNION_ID='''+pid+''' and A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID';
      if today then rs.SQL.Text := rs.SQL.Text + ' and A.SND_DATE='''+formatDatetime('YYYY-MM-DD',date())+'''';
      Open(rs);
      rs.First;
      while not rs.Eof do
      begin
        BeginTrans;
        try
          //�Ѵ˻�Ա��Ϣ��ͬ����ȥ
          ReRun:=UpLoadCustomer(tid,custid,rs);
          CommitTrans;
          if ReRun=1 then Inc(DCount); //�ۼ�
        except
          Inc(DErrCount);   //�����ۼ�1;
          RollbackTrans;
          Raise
        end;
        rs.Next;
      end;
    end;
    if toDay then
    begin
      result:=(DErrCount=0);
      Exit;  //ǰ̨�ŵ�ִ�У�������
    end;

    //���������� [ȫ��дR3��ֱ����������]
    rs.Close;
    rs.SQL.Text:='select * from RIM_VIP_CONSUMER where CUST_ID='''+custid+''' and CONSUMER_STATUS=''03'' ';
    Open(rs);
    rs.First;
    while not rs.Eof do
    begin
      BeginTrans;
      try
        //�Ѵ˻�Ա��Ϣ��ͬ����ȥ
        ReRun:=DownLoadCustomer(tid,custid,sid,rid,pid,rs);
        CommitTrans;
        if ReRun=1 then Inc(UCount); //�ۼ�
      except
        Inc(UErrCount);   //�����ۼ�1;
        RollbackTrans;
        Raise
      end;
      rs.Next;
    end;

    //д��־
    if DCount+DErrCount+UCount+UErrCount=0 then WriteToLogList(ShopInfo+'����', true, true)
    else
    begin
      if DCount+DErrCount>0 then
      begin
        if DCount>0 then DownMsg:='����:'+InttoStr(DCount);
        if DErrCount>0 then
        begin
          if DCount>0 then DownMsg:=DownMsg+';����'+InttoStr(DErrCount) else DownMsg:='���ش���:'+InttoStr(DErrCount);
        end;
      end;
      if UCount+UErrCount>0 then
      begin
        if UCount>0 then UpMsg:='�ϴ�:'+InttoStr(UCount);
        if UErrCount>0 then
        begin
          if UCount>0 then UpMsg:=UpMsg+';����'+InttoStr(UErrCount)+']' else UpMsg:='�ϴ�����:'+InttoStr(UErrCount)+'';
        end;
      end;
      WriteToLogList(ShopInfo+'['+DownMsg+UpMsg+']', true, (DErrCount+UErrCount>0))
    end;
    result:=(DErrCount+UErrCount=0);
  finally
    rs.Free;
  end;
end;

procedure TVipSyncFactory.WriteLogRun(ReportName: string);
var
  i: integer;
  LogFile,Str,ReportTitle: string;
  LogFileList: TStringList;
begin
  LogFile:=ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
  FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick; //��ִ�ж�����
  try
    LogFileList:=TStringList.Create;
    if FileExists(LogFile) then
    begin
      LogFileList.LoadFromFile(LogFile);
      LogFileList.Add('    ');
    end;

    //�����־:
    ReportTitle:='��������ͬ���� ��ʼִ��:'+FRunInfo.BegTime+' �ŵ�������'+inttoStr(FRunInfo.AllCount)+'�ɹ���'+inttoStr(FRunInfo.RunCount);
    if FRunInfo.ErrorCount>0 then ReportTitle:=ReportTitle+'���쳣��'+inttoStr(FRunInfo.ErrorCount);
    if FRunInfo.NotCount>0   then ReportTitle:=ReportTitle+'��û�ж�ӦRim���ۻ�����'+inttoStr(FRunInfo.NotCount);

    //ȫ����Rsp�����ϱ���־:
    LogFileList.Add('----- RSP����ͬ�� '+ReportTitle+' ------');
    for i:=0 to LogList.Count-1 do
    begin
      LogFileList.Add(LogList.Strings[i]);
    end;
    LogFileList.Add('----- ͬ������[ִ��<'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'>��] --------');
    LogFileList.Add('  ');
  finally
    LogFileList.SaveToFile(LogFile);
  end; 
end;

end.















