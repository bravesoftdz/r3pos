{-------------------------------------------------------------------------------
  //消息同步
 ------------------------------------------------------------------------------}

unit uMsgFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uFnUtil, uBaseSyncFactory, uRimSyncFactory;

type
  TMsgSyncFactory=class(TRimSyncFactory)
  private
    //同步会员：tid 企业号
    function SyncMessage: Boolean;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

{ TMsgSyncFactory }

//tid 企业号; sid 门店号
function TMsgSyncFactory.SyncMessage: Boolean;
var
  iRet:integer;
  str,s,mid: string;
  rs: TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    case DbType of
    4:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (POSSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and (saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+       ')'+       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    1:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (INSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+
       ')'+
       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    end;
    if Open(Rs) then
    begin
      rs.First;
      while not rs.Eof do
      begin
        BeginTrans;
        try
          mid:= TBaseSyncFactory.newid(RimParam.ShopID);
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
               'values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(str),iRet) <>0 then Raise Exception.Create(GPlugIn.GetLastError);

          if rs.Fields[1].asString='01' then
             s := '促销信息'
          else
          if rs.Fields[1].asString='02' then
             s := '广告信息'
          else
          if rs.Fields[1].asString='03' then
             s := '货源信息'
          else
          if rs.Fields[1].asString='04' then
             s := '新品信息'
          else
          if rs.Fields[1].asString='05' then
             s := '通知'
          else
          if rs.Fields[1].asString='99' then
             s := '到货通知'
          else
             s := '公告';
          case DbType of
           4:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',int(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
           1:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',to_number(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          end;
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          CommitTrans;
        except
          on E:Exception do
          begin
            WriteRunErrorMsg(E.Message);
            RollbackTrans;
            Raise
          end;
        end;
        rs.Next;
      end;
    end;
  finally
    rs.Free;
  end;
end;


function TMsgSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result:=-1;
  PlugInID:='803';
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  if Params.FindParam('SHOP_ID')=nil then Params.ParambyName('SHOP_ID').asString := Params.ParambyName('TENANT_ID').asString+'0001';

  RimParam.TenID  :=trim(Params.ParambyName('TENANT_ID').asString);   //R3企业ID (Field: TENANT_ID)
  RimParam.ShopID :=trim(Params.ParambyName('SHOP_ID').asString);     //R3门店ID (Field: SHOP_ID)
  SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;

  if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
  begin   
    SyncMessage;
    result:=0;
  end;
end;

end.















