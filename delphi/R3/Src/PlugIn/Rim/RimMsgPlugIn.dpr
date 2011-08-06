library RimMsgPlugIn;

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
  uFnUtil,
  ZDataSet,
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
  result := '信息公告同步插件';
end;
//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 802;
end;
//RSP调用插件时执行此方法
//由R3程序调用，只同步本门店的
function DoExecute(Params:Pchar;var Data:OleVariant;dbResoler:integer):Integer; stdcall;
//tid 企业号
//sid 门店号
procedure SyncMessage(tid,sid:string);
var
  str,ComID,CustID,s: string;
  rs: TZQuery;
  r,iDbType:integer;
  mid:string;
begin
  rs:=TZQuery.Create(nil);
  try
      rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
      if OpenData(GPlugIn, rs,dbResoler) then
      begin
        ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
      if rs.IsEmpty then Raise Exception.Create('在RIM中没找到此客户');
      GPlugIn.iDbType(iDbType,dbResoler);
      rs.Close;
      case iDbType of
      4:rs.SQL.Text :=
         'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+ComID+''' and '+
         '('+
         ' (POSSTR(RECEIVER,'''+CustID+','')>0) or ('+
         ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+CustID+''') or slsman_id is null or slsman_id=''all'' or slsman_id='''') '+
         ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+CustID+''') or saleorg_id is null or saleorg_id=''all'' or saleorg_id='''') '+         ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+CustID+''') or sale_center_id is null or sale_center_id=''all'' or sale_center_id='''') '+         ' and (receiver is null or receiver ='''' or receiver ='','') '+         ' )'+
         ')'+ 
         'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
         'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+sid+''' and B.TENANT_ID='+tid+' and B.COMM_ID=A.MSG_ID)';
      1:rs.SQL.Text :=
         'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+ComID+''' and '+
         '('+
         ' (INSTR(RECEIVER,'''+CustID+','')>0) or ('+
         ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+CustID+''') or slsman_id is null or slsman_id=''all'' or slsman_id='''') '+
         ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+CustID+''') or saleorg_id is null or saleorg_id=''all'' or saleorg_id='''') '+         ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+CustID+''') or sale_center_id is null or sale_center_id=''all'' or sale_center_id='''') '+         ' and (receiver is null or receiver ='''' or receiver ='','') '+         ' )'+
         ')'+ 
         'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
         'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+sid+''' and B.TENANT_ID='+tid+' and B.COMM_ID=A.MSG_ID)';
      end;
      OpenData(GPlugIn, rs,dbResoler);
      rs.First;                                  
      while not rs.Eof do
      begin
        if GPlugIn.BeginTrans(dbResoler)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        try
          GPlugIn.iDbType(iDbType,dbResoler);
          mid := newid(sid);
          str :=
           'insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
           'values('+tid+','''+mid+''','''+sid+''',1,1,''00'','+GetTimeStamp(iDbType)+')';
          if GPlugIn.ExecSQL(pchar(str),r,dbResoler)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
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
          case iDbType of
          4:str :=
           'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
           'select '+tid+','''+mid+''',''0'',int(USE_DATE),'+tid+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(iDbType)+' from RIM_MESSAGE A where COM_ID='''+ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          1:str :=
           'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
           'select '+tid+','''+mid+''',''0'',to_number(USE_DATE),'+tid+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(iDbType)+' from RIM_MESSAGE A where COM_ID='''+ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          end;
          if GPlugIn.ExecSQL(pchar(str),r,dbResoler)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          if GPlugIn.CommitTrans(dbResoler)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
        except
          if GPlugIn.RollbackTrans(dbResoler)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          Raise
        end;
      rs.Next;
      end;
  finally
    rs.Free;
  end;
end;
var ParamList:TftParamList;
begin
  try
    //开始执行插件该做的工作.
    ParamList := TftParamList.Create(nil);
    try
      ParamList.Decode(ParamList,Params);
      if ParamList.FindParam('SHOP_ID')=nil then ParamList.ParambyName('SHOP_ID').asString := ParamList.ParambyName('TENANT_ID').asString+'0001';
      SyncMessage(ParamList.ParambyName('TENANT_ID').asString,ParamList.ParambyName('SHOP_ID').asString);
    finally
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
