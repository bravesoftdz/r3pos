unit uStorageFactory;

interface

uses
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TStorageSyncFactory=class(TRimSyncFactory)
  private
    function SendCustStorage(vRimParam: TRimParams): integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;

implementation


{ TStorageSyncFactory }

//�ϱ�һ���ŵ��� 
function TStorageSyncFactory.SendCustStorage(vRimParam: TRimParams): integer;
var
  iRet,iRet1,iRet2,iRet3: integer;    //����ExeSQLӰ������м�¼
  Str,StoreTab,ShortID: string;
begin
  result := -1;
  try
    BeginTrans;
    ShortID:=Copy(vRimParam.ShopID,length(vRimParam.ShopID)-3,4); //�ŵ�����4λ
    
    //1���Ȳ��벻������Ʒ:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         ' select '''+vRimParam.CustID+''' as CUST_ID,B.SECOND_ID,'''+vRimParam.ComID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+FormatDatetime('YYYYMMDD',Date())+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'' '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+vRimParam.ComID+''' and C.CUST_ID='''+vRimParam.CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('���벻������ƷRIM_CUST_ITEM_SWHSE����'+PlugIntf.GetLastError);

    //2������: RIM_CUST_ITEM_SWHSE
    Str:=ParseSQL(DbType,
           'update RIM_CUST_ITEM_SWHSE '+
           ' set QTY=coalesce((select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY from STO_STORAGE A,VIW_GOODSINFO B '+
           ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' and '+
           ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID),0)'+
           ' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TERM_ID='''+ShortID+''' ');
         // ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)';
    if PlugIntf.ExecSQL(pchar(Str), iRet1)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE��¼����:'+PlugIntf.GetLastError);

    //3���ȸ��µ�ǰ������м����м��[RIM_CUST_ITEM_SWHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
         ' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' ';
    str:=ParseSQL(DbType,str);
    if PlugIntf.ExecSQL(pchar(Str), iRet2)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE����:'+PlugIntf.GetLastError);

    //4��û�и��µ���¼�����м��[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE A where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if PlugIntf.ExecSQL(pchar(Str), iRet3)<>0 then
      Raise Exception.Create('����RIM_CUST_ITEM_SWHSE�¼�¼����:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;
    result:=iRet1+iRet2+iRet3;

    //�ϱ��ɹ�д��־��
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'11','�ϱ����ۻ����ɹ���','02');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'11','�ϱ����ۻ������','02');  //�ϱ�����д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

function TStorageSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  RimParam: TRimParams;
  R3ShopList: TZQuery;
begin
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��[SyncType=3��ǰ̨����ִ��]

  {------��ʼ������־------}
  BeginLogRun;
  R3ShopList := TZQuery.Create(nil);
  try
    DBLock(true); //��������
    //����R3���ϱ�ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='��ҵID('+RimParam.TenID+')û�ж�Ӧ���ϱ��ŵ�(�ϱ��˳�ִ��)��';
      Exit;
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);      //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString);    //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);        //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);     //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)
        //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //�����̲ݹ�˾ComID�����ۻ�CustID

        //if ='' then Raise Exception.Create('R3������ҵID��'+RimParam.TenID+' - '+RimParam.TenName+'����RIM��û�ҵ���Ӧ��COM_IDֵ...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //��ʼ��־

          //��ʼ�����ۻ����
          iRet:=SendCustStorage(RimParam);
          LogInfo.AddBillMsg('���ۻ����',iRet);

          if R3ShopList.RecordCount=1 then
            LogInfo.SetLogMsg(LogList) //��ӱ���ִ����־
          else
            LogInfo.SetLogMsg(LogList, R3ShopList.RecNo);  //��ӱ���ִ����־
          if iRet=-1 then
            Inc(FRunInfo.ErrorCount)
          else
            Inc(FRunInfo.RunCount);
        end else
        begin
          Inc(FRunInfo.NotCount);  //��Ӧ����
          LogList.Add('   �ŵ�('+RimParam.TenName+'-'+RimParam.ShopName+')���֤��'+RimParam.LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�����ۻ���'); 
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          // AddLogMsg(0,'R3�ŵ�:'+RimParam.ShopID+' ��'+RimParam.ShopName+' ���֤��'+RimParam.LICENSE_CODE+' �ϱ�����'+'  '+E.Message);
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���
    DBLock(False);
    R3ShopList.Free;
    if SyncType<>3 then
      WriteLogRun('���ۻ����'); //������ı���־
  end;
end;

end.
