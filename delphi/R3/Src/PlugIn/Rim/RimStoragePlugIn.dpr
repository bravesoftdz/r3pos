{
 ���������
  (1)����ִ��:����Ҫ����:TYPE
  (2)ǰ̨����:��Ҫ�������:TYPE����Value=0;
 }


library RimStoragePlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System,
  Windows,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  DB,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';

{$R *.res}


//////2011.04.15 AM�ϱ����ۻ��� (ÿ���ϱ�һ��)����Ҫ�ϱ�ʱ���  
function SendCustStorage(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string): Boolean;
var
  iRet,iDBType: integer;    //����ExeSQLӰ������м�¼
  Str,StoreTab,ShortID: string;
begin
  result := False;
  try
    if PlugIntf.iDbType(iDBType)<>0 then Raise Exception.Create('�����������ʹ���');   
    PlugIntf.BeginTrans;
    ShortID:=Copy(SHOP_ID,length(SHOP_ID)-3,4);
    //1���Ȳ��벻������Ʒ:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         ' select '''+CustID+''' as CustID,B.SECOND_ID,'''+ORGAN_ID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+FormatDatetime('YYYYMMDD',Date())+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'' '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+ORGAN_ID+''' and C.CUST_ID='''+CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('���벻������ƷRIM_CUST_ITEM_SWHSE����'+PlugIntf.GetLastError);

    //2������: RIM_CUST_ITEM_SWHSE
    Str:='update RIM_CUST_ITEM_SWHSE '+
         ' set QTY=(select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and '+
         ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)'+
         ' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TERM_ID='''+ShortID+''' ';
         // ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE��¼����:'+PlugIntf.GetLastError);

    //3���ȸ��µ�ǰ������м����м��[RIM_CUST_ITEM_SWHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
         ' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' ';
    str:=ParseSQL(iDBType,str);
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE����:'+PlugIntf.GetLastError);

    //4��û�и��µ���¼�����м��[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE A where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE�¼�¼����:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;
    result:=true;
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf,LICENSE_CODE,CustID,'11','�ϱ����ۻ������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

procedure CallReportStorageSync(PlugIntf:IPlugIn; InParam: string);  //�ϱ����
var
  RunInfo: TRunInfo; //�ϱ���¼��Ϣ
  Str: string;       //��ҵ����ͼ
  OrganID,           //RIM�̲ݹ�˾ID
  LICENSE_CODE,      //RIM���ۻ����֤��
  CustID,            //RIM���ۻ�ID
  TenantID,          //R3�ϱ���ҵID
  TenName,           //R3�ϱ���ҵName
  ShopID,            //R3�ϱ��ŵ�ID
  ShopName: string;  //R3�ϱ��ŵ�����;
  R3ShopList,Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;  //�Ƿ�Ϊ���ۻ�ֱ���ϱ�
  BegTime,ErrorStr: string; //��ʼ����ʱ���
  BegTick,RunCount,NotCount,ErrorCount: integer;
begin
  BegTime:=Timetostr(time());
  BegTick:=GetTickCount;
  RunCount:=0;
  NotCount:=0;
  ErrorCount:=0;
  ErrorStr:='';
  
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,InParam);
    TenantID:=vParam.ParamByName('TENANT_ID').AsString;
    IsFlag:=False; 
    if (vParam.FindParam('FLAG')<>nil) and (vParam.FindParam('FLAG').AsInteger=3) then
      IsFlag:=true;
  finally
    vParam.Free;
  end;

  Rs := TZQuery.Create(nil);
  R3ShopList := TZQuery.Create(nil);
  try
    //����R3���ϱ�ShopList
    GetR3ReportShopList(PlugIntf, R3ShopList, InParam);
    if R3ShopList.RecordCount=0 then Raise Exception.Create(' ��ҵ��û�ж�Ӧ�����ݣ������ϱ��� ');

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      CustID:='';
      try
        TenantID:=trim(R3ShopList.Fields[0].AsString);      //R3��ҵID (Field: TENANT_NAME)
        TenName:=trim(R3ShopList.Fields[1].AsString);       //R3��ҵ���� (Field: TENANT_NAME)
        ShopID:=trim(R3ShopList.Fields[2].AsString);        //R3�ŵ�ID (Field: SHOP_ID)
        ShopName:=trim(R3ShopList.Fields[3].AsString);      //R3�ŵ����� (Field: SHOP_NAME)
        LICENSE_CODE:=trim(R3ShopList.Fields[4].AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)

        //����R3�����̲ݹ�˾��ҵID(TENANT_ID)
        Rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenantID+' and B.SHOP_ID='''+ShopID+''' ';
        if OpenData(GPlugIn, Rs) then        begin          OrganID:=trim(rs.fieldbyName('COM_ID').AsString);          CustID:=trim(rs.fieldbyName('CUST_ID').AsString);        end;
        if OrganID='' then Raise Exception.Create('R3������ҵID��'+TenantID+'����RIM��û�ҵ���Ӧ��ORGAN_IDֵ...');
        CustID:=GetRimCust_ID(PlugIntf, OrganID, LICENSE_CODE);
        if CustID<>'' then
        begin
          //��ʼ�����ۻ����
          if SendCustStorage(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE) then
            Inc(RunCount)   //�ۼ��ϱ��ɹ�����
          else
            Inc(ErrorCount); //�ۼ�ʧ�ܸ���
        end else
        begin
          ErrorStr:=ErrorStr+'   '+'R3�ŵ�:'+ShopID+' ��'+ShopName+' ���֤��'+LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�ϣ�';
          Inc(NotCount);  //��Ӧ����
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          ErrorStr:=ErrorStr+'   '+E.Message;
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','�ϱ���������','02'); //дRim�������־
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    Rs.Free; 
    R3ShopList.Free;
    BegTick:=GetTickCount-BegTick; //��ִ�ж�����
    //�����־:
    if IsFlag then  //�ͻ��˵����ŵ���־
    begin
      if RunCount=1 then
        PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,�����ŵ꣺('+ShopID+'- '+ShopName+') ��ʼִ��ʱ�䣺'+BegTime+' ��ִ��'+FormatFloat('#0.00',BegTick/1000)+'��  �ϱ��ɹ���')) 
      else
        PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,�����ŵ꣺('+ShopID+'- '+ShopName+') ��ʼִ��ʱ�䣺'+BegTime+' ��ִ��'+FormatFloat('#0.00',BegTick/1000)+'��  �ϱ�����:'+ErrorStr));
    end else  //��̨��������:
    begin
      PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,������ҵ��('+TenantID+'- '+TenName+') ��ʼִ��ʱ�䣺'+BegTime+' ��ִ��'+FormatFloat('#0.00',BegTick/1000)+'�� '));
      Str:='�ϱ��ɹ��ŵ�����'+inttostr(RunCount)+'  Rim��û�ж�Ӧ�ŵ���:'+inttoStr(NotCount)+' �ϱ�ʧ���ŵ���:'+inttoStr(ErrorCount);
      if ErrorStr<>'' then Str:=Str+' ������Ϣ�� '+#13+ErrorStr;
      PlugIntf.WriteLogFile(Pchar(ErrorStr));
    end; 
  end;
end;     

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
  result := 'RSPƽ̨�ϱ�RIM���';
end;

//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 1004;  //RIM�ӿڵĲ��
end;

//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar; var Data: oleVariant):Integer; stdcall;
begin
  try
    //�ϱ����
    CallReportStorageSync(GPlugIn, StrPas(Params));
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
    //��ʼ��ʾ�����洰��

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


