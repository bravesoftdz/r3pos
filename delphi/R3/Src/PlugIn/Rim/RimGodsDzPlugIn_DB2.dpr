{
  Create Date: 2011.04.08 Pm
  ˵��:
    1�����ID: �Ƕ���ʵ��ĳ�����ܲ�����;

 }


library RimGodsDzPlugIn_DB2;

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
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';

   
{$R *.res}


function GetORGAN_ID(PlugIntf: IPlugIn; TENANT_ID: string): string;
var
  str: string;
  Rs: TZQuery;
  vData: OleVariant;
begin
  result:='';
  try
    str:='select A.ORGAN_ID as ORGAN_ID from RIM_PUB_ORGAN A,CA_TENANT B where A.ORGAN_CODE=B.LOGIN_NAME and B.TENANT_ID='+TENANT_ID+' ';
    try
      Rs:=TZQuery.Create(nil);
      OpenData(PlugIntf, Rs, str);
      if Rs.Active then
        result:=trim(Rs.fieldbyName('ORGAN_ID').AsString);
    finally
      Rs.Free;
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('����R3��ҵID:('+TENANT_ID+') ����Rim����ҵID����'+E.Message);
    end;
  end;
end;

//2011.04.08 Pm  Add [RIM_GOODSINFO] === [INF_GOODS_RELATION]
function DoUpdateINF_GOODSINFO(PlugIntf: IPlugIn; TENANT_ID: string): Integer;
var
  NotGods: string;     //��־����ʹ��
  Sort_ID2, Sort_ID6,CALC_UNIT: string; //�۸���� ���Ƿ���ʡ���⡡��������λ
  Box_InPrice, Box_OutPrice: string;    //�������ۡ��������ۼ�
  ORGAN_ID, BarCode: string;   //1��RIM��˾ID 2������
  StrSQL,RimSQL: Pchar;   
  iRet: integer;   //���ظ��ļ�¼��
  AObj: TRecord_;
  RsRim,RsInf,RsBarPub: TZQuery;
begin
  result:=-1;
  iRet:=-1;
  NotGods:='';
  ORGAN_ID:=GetORGAN_ID(PlugIntf,TENANT_ID); //����R3��ҵID����Rim��ҵ����(comp_id)
  TLogRunInfo.LogWrite('��ʼִ�ж���ȡ����:��R3��ҵID��'+TENANT_ID+'��RIM�̲ݹ�˾ID:'+ORGAN_ID+'��','RimGodsDzPlugIn.dll');
  if ORGAN_ID='' then Raise Exception.Create('û���ҵ�Rimϵͳ�̲ݹ�˾ID��'); 

  Sort_ID2:=
    '(case when SORT_ID2=''1'' then ''85994503-9CBC-4346-BC86-24C7F5A92BC6'''+  //����
         ' when SORT_ID2=''2'' then ''59FD3FCD-2E8F-440A-B9B6-727B45524535'''+
         ' when SORT_ID2=''3'' then ''C7591724-53FF-4DA0-BE32-FACCDB3A3BFC'''+
         ' when SORT_ID2=''4'' then ''48F953FF-D86D-4A77-AA9A-0D56491B43EF'''+
         ' when SORT_ID2=''5'' then ''B82B26CF-E0D3-499C-808C-C074B0240881'''+
         ' when SORT_ID2=''6'' then ''70EC2D50-6CA7-4730-8362-D76909D3BFF2'''+
         ' else ''#'' end) as SORT_ID2';
  Sort_ID6:=
    '(case when SORT_ID6=''0'' then ''635E6FB4-8B94-4996-95E1-A77401323560'''+  //�Ƿ�ʡ���⡢������
         ' when SORT_ID6=''1'' then ''E76D1A2A-1423-42E1-B827-8B268AF92CCD'''+
         ' when SORT_ID6=''3'' then ''800F74E2-B697-4D95-9131-8FAD458EC992'''+
         ' else ''#'' end) as SORT_ID6';
  CALC_UNIT:='''95331F4A-7AD6-45C2-B853-C278012C5525'' as CALC_UNIT '; //�а�װ��λ: GUID

  Box_InPrice:='(case when CAlC_AMT>0 then PACK_INPRICE/CAlC_AMT else PACK_INPRICE end) as NEW_INPRICE ';   //�е�λ�� ����
  Box_OutPrice:='(case when CAlC_AMT>0 then PACK_OUTPRICE/CAlC_AMT else PACK_OUTPRICE end) as NEW_OUTPRICE ';  //�е�λ�� ���ۼ�

  //1����ɾ����Ӧ��ϵ�м��:
  StrSQL:=PChar('delete from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' ');
  if PlugIntf.ExecSQL(StrSQL,iRet)<>0 then Raise Exception.Create('1����ɾ����Ӧ��ϵ�м��:'); 

  //2�����봫����ҵ��Ʒ��Ӧ��:
  try
    AObj:=TRecord_.Create;
    RsRim:=TZQuery.Create(nil);  //Rim��ͼ
    RsInf:=TZQuery.Create(nil);  //R3�м��
    RsBarPub:=TZQuery.Create(nil);  //R3����_��Ӧ��
    StrSQL:=Pchar(
      'select A.GODS_ID,A.BARCODE,B.ROWS_ID,B.SECOND_ID,B.RELATION_ID,(case when A.GODS_ID=B.Gods_ID and B.SECOND_ID is not null then 1 else 2 end) as IsFlag from PUB_BARCODE A '+
      'left outer join (select * from PUB_GOODS_RELATION where TENANT_ID='+TENANT_ID+') B on A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=110000001 and A.BARCODE_TYPE=''1'' ');
    OpenData(PlugIntf, RsBarPub, StrSQL);
    RimSQL:=Pchar('select GODS_ID as SECOND_ID,GODS_CODE,GODS_NAME,'+Sort_ID2+','+Sort_ID6+','+Box_InPrice+','+Box_OutPrice+',PACK_BARCODE from RIM_GOODS_RELATION where TENANT_ID='''+ORGAN_ID+''' ');
    OpenData(PlugIntf, RsRim, RimSQL);
    OpenData(PlugIntf, RsInf, Pchar('select * from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID));

    //д������־:
    TLogRunInfo.LogWrite('����Open���ݣ�1��RsBarPub.SQL='+StrSQL+'  ���ؼ�¼��:'+InttoStr(RsBarPub.RecordCount)+' 2��RsRim.SQL='+RimSQL+'  ���ؼ�¼��:'+InttoStr(RsRim.RecordCount),'RimGodsDzPlugIn.dll');

    //��ʼѭ������
    try
      if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then
      begin
        RsRim.First;
        while not RsRim.Eof do
        begin
          AObj.ReadFromDataSet(RsRim);
          BarCode:=trim(RsRim.fieldbyName('PACK_BARCODE').AsString);
          if RsBarPub.Locate('BARCODE',BarCode,[]) then  //�����ܹ�����
          begin
            if RsInf.IsEmpty then RsInf.Edit else RsInf.Append;
            AObj.WriteToDataSet(RsInf,False);  //Aobjд��DataSet;
            if trim(RsBarPub.fieldbyName('ROWS_ID').AsString)<>'' then
              RsInf.FieldByName('ROWS_ID').AsString:=RsBarPub.fieldbyName('ROWS_ID').AsString
            else
              RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��1000006
            RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString; //���Ҿ��̹�Ӧ��
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=RsBarPub.fieldbyName('IsFlag').AsInteger; //״̬[1��ʾ�¶��ϣ�2��ʾԭ�Ѷ���]
            RsInf.Post;
          end else  {==�Բ��ϣ���Ϊ������ʾ����鿴==}
          begin
            if NotGods='' then NotGods:=BarCode else NotGods:=NotGods+';'+BarCode; //���е��Լ�¼�Բ�������
            if RsInf.IsEmpty then RsInf.Edit else RsInf.Append;
            AObj.WriteToDataSet(RsInf, False); //Aobjд��DataSet;
            RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��:1000006
            RsInf.FieldByName('GODS_ID').AsString:='#';  //��Ӧ����Ĭ��Ϊ��#
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=0; //״̬[1�Բ���]
            RsInf.Post;
          end;
          RsRim.Next;
        end; //end (ѭ��: while not RsRim.Eof do)
        TLogRunInfo.LogWrite('ѭ�����ս�����Բ���Rim����λ���룺'+NotGods,'RimGodsDzPlugIn.dll');
        result:=PlugIntf.UpdateBatch(RsInf.Data, 'TInf_Goods_Relation'); //�ύRsInf�����м��:INF_GOODS_RELATION;
        if result<>0 then
          Raise Exception.Create('�ύ�м��INF_GOODS_RELATION�����쳣��');
      end //end (if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then)
      else
        Raise Exception.Create(' �������ݼ�û��Open��');
    except
      on E:Exception do
      begin
        Raise Exception.Create('��RIM_GOODS_RELATION��ͼ���뵽�м��:INF_GOODS_RELATION����'+E.Message);
      end;
    end;
    TLogRunInfo.LogWrite('����ִ����ϣ�','RimGodsDzPlugIn.dll');
  finally
    AObj.Free;
    RsRim.Free;
    RsInf.Free;
    RsBarPub.Free;
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
  result := 'RSPƽ̨��RIMϵͳ���̵�������';
end;

//Ϊÿ���������һ��Ψһ��ʶ�ţ���Χ1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 1001;  //RIM�ӿڵĲ��
end;

//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar; var Data: oleVariant):Integer; stdcall;
begin
  try
    //2011.04.08 Pm  Add ִ�д�[RIM_GOODSINFO] ==> [INF_GOODS_RELATION]����
    //����ʹ��: DoUpdateINF_GOODSINFO(GPlugIn, '100011'); //StrPas(Params)
    //GPlugIn.WriteLogFile(PChar('����Tenant_ID:'+Params));
    
    result:=DoUpdateINF_GOODSINFO(GPlugIn, StrPas(Params));  //StrPas(Params)
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      GPlugIn.WriteLogFile(PChar(GLastError));
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




 { ////��SQL�������м��:
  StrSQL:=PChar(
    'insert into INF_GOODS_RELATION '+
    ' (TENANT_ID,RELATION_ID,GODS_ID,GODS_CODE,GODS_NAME,SORT_ID2,SORT_ID6,NEW_INPRICE,NEW_OUTPRICE,UPDATE_FLAG) '+
    ' select '+TENANT_ID+' as TENANT_ID,'+InttoStr(NT_RELATION_ID)+' as RELATION_ID,A.GODS_ID,A.GODS_CODE,A.GODS_NAME,'+Sort_ID2+','+Sort_ID6+','+Box_InPrice+','+Box_OutPrice+',(case when coalesce(B.GODS_ID,'''')<>'''' then 1 else 0 end) as UPDATE_FLAG '+
    ' from RIM_GOODS_RELATION A '+
    ' left join VIW_BARCODE B on A.BOX_BARCODE=B.BARCODE '+
    ' where A.TENANT_ID='''+ORGAN_ID+''' ');
  PlugIntf.ExecSQL(StrSQL,iRet);  }
