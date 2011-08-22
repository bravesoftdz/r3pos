unit uStorageFactory;

interface

uses
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TStorageSyncFactory=class(TRimSyncFactory)
  private
    function SendCustStorage: integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;

implementation


{ TStorageSyncFactory }

//�ϱ�һ���ŵ��� 
function TStorageSyncFactory.SendCustStorage: integer;
var
  IsComTrans: Boolean; //�ύ���񷵻�
  iRet,iRet1,iRet2,iRet3: integer;    //����ExeSQLӰ������м�¼
  Str,ShortID,Up_Date: string;
begin
  result := -1;
  IsComTrans:=False;
  try
    Up_Date:=FormatDatetime('YYYYMMDD',Date());
    ShortID:=Copy(RimParam.ShopID,length(RimParam.ShopID)-3,4); //�ŵ�����4λ

    //1���Ȳ��벻������Ʒ[�м����]:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         ' select '''+RimParam.CustID+''' as CUST_ID,B.SECOND_ID,'''+RimParam.ComID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+Up_Date+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'' '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+RimParam.ComID+''' and C.CUST_ID='''+RimParam.CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    IsComTrans:=ExecTransSQL(Str,iRet,'���벻������ƷRIM_CUST_ITEM_SWHSE����');

    //2������: RIM_CUST_ITEM_SWHSE
    Str:=ParseSQL(DbType,
           'update RIM_CUST_ITEM_SWHSE '+
           ' set QTY=coalesce((select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY from STO_STORAGE A,VIW_GOODSINFO B '+
                             ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and '+
                             ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID),0)'+
                ',DATE1='''+Up_Date+''',TIME1='''+TimeToStr(Time())+''' '+
           ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TERM_ID='''+ShortID+''' '+
           ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)');
    if IsComTrans then 
      IsComTrans:=ExecTransSQL(Str,iRet1,'����RIM_CUST_ITEM_SWHSE��¼����:');

    //3���ȸ��µ�ǰ������м��浽���ۻ�����[RIM_CUST_ITEM_WHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0),'+
              ' DATE1='''+Up_Date+''',UPD_TIME='''+TimeToStr(Time())+''' '+
         ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' ';
    str:=ParseSQL(DbType,str);
    if IsComTrans then
      IsComTrans:=ExecTransSQL(Str,iRet2,'����RIM_CUST_ITEM_WHSE����:');
      
    //4��û�и��µ���¼�����м��[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY,DATE1,UPD_TIME) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY),'''+Up_Date+''' as Up_Date,'''+TimeToStr(Time())+''' as UPD_TIME from RIM_CUST_ITEM_SWHSE A '+
           ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and '+
           ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if IsComTrans then
      IsComTrans:=ExecTransSQL(Str,iRet3,'����RIM_CUST_ITEM_WHSE�¼�¼����:');

    result:=iRet1+iRet2+iRet3;
  except
    on E:Exception do
    begin
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'11','�ϱ����ۻ�������','02');  //�ϱ�����д��־
      Raise;
    end;
  end;

  //�ϱ��ɹ�д��־��
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'11','�ϱ����ۻ����ɹ���','01');
end;

function TStorageSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
begin
  result:=-1;
  PlugInID:='810';
  
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��[SyncType=3��ǰ̨����ִ��]

  {------��ʼ������־------}
  BeginLogReport;
  try
    DBLock(true); //��������
    //����R3���ϱ�ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      Raise Exception.Create('<'+PlugInID+'>'+'[��ҵID('+RimParam.TenID+')û�п��ϱ��ŵ�(�˳�)��]');
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      try
        ErrorFlag:=False;
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);      //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString);    //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);        //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);     //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);   //R3�ŵ����֤�� (Field: LICENSE_CODE)
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          BeginLogShopReport; //��ʼ�ŵ���־
          //��ʼ�����ۻ����
          try
            iRet:=SendCustStorage;
            AddBillMsg('���ۻ����',iRet);
          except
            on E:Exception do
            begin
              AddBillMsg('���ۻ����',-1,E.Message);
              ErrorFlag:=true;
            end;
          end;
          EndLogShopReport(True,ErrorFlag); //д���ŵ��ϱ����
        end else
          EndLogShopReport(False); //��Ӧ�����ŵ���־
      except
        on E: Exception do
        begin
          WriteLogFile(E.Message); 
        end;
      end;
      R3ShopList.Next;
    end;
    result:=1;
  finally
    DBLock(False);
    WriteToReportLogFile('���ۻ����'); //������ı���־
  end;
end;

end.
