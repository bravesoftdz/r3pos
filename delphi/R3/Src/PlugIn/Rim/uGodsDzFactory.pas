unit uGodsDzFactory;

interface

uses
  SysUtils, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

//������ϵͳ���ݶԽӵĻ���
type
  TGodsDzSyncFactory=class(TRimSyncFactory)
  private
    R3BarSum: TZQuery; //R3����_Sum
    //2011.09.20 ����R3�������
    function CreateBarCode(PubBarTable: TZQuery): integer;
    function GetR3BarCode(BarCode: string): integer;

    //2011.08.25 ���ص�ǰ�м�����ҵID�����̹�Ӧ����
    function GetParentTENANT_ID: integer;
    //����Web.Rsp��������:
    procedure DoDownBaseInfo;

    //��RIM�ṩ��ͼ[RIM_GOODS_RELATION]�����м��
    function InsertData_INF_GOODS_RELATION(COM_ID: string; UpdateMode: integer): Integer;
  public
    constructor Create; override;
    destructor Destroy;override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;

implementation

uses
  uGodsDzCaFactory;

{ TRimSyncFactory }

constructor TGodsDzSyncFactory.Create;
begin
  inherited;
  R3BarSum:=TZQuery.Create(nil);
end;

destructor TGodsDzSyncFactory.Destroy;
begin
  R3BarSum.Free;
  inherited;
end;

function TGodsDzSyncFactory.InsertData_INF_GOODS_RELATION(COM_ID: string; UpdateMode: integer): Integer;
var
  iRet,BarCount: integer;  //���ظ��ļ�¼��
  SelectSQL: string;       //��ѯ���
  Sort_ID2,Sort_ID5,Sort_ID6,Sort_ID10: string;
  CALC_UNIT,TENANT_ID: string; //�۸���� ���Ƿ���ʡ���⡡��������λ
  Box_InPrice, Box_OutPrice, BarCode: string;    //�������ۡ��������ۼۡ�����
  StrSQL,RimSQL: Pchar;
  AObj: TRecord_;
  RsRim,RsInf,RsBarPub: TZQuery;
begin
  result:=-1;
  HasError:=False;
  iRet:=-1;
  TENANT_ID:= Params.ParamByName('TENANT_ID').AsString;
  Sort_ID2:=
    '(case when SORT_ID2=''1'' then ''85994503-9CBC-4346-BC86-24C7F5A92BC6'''+  //����
         ' when SORT_ID2=''2'' then ''59FD3FCD-2E8F-440A-B9B6-727B45524535'''+
         ' when SORT_ID2=''3'' then ''C7591724-53FF-4DA0-BE32-FACCDB3A3BFC'''+
         ' when SORT_ID2=''4'' then ''48F953FF-D86D-4A77-AA9A-0D56491B43EF'''+
         ' when SORT_ID2=''5'' then ''B82B26CF-E0D3-499C-808C-C074B0240881'''+
         ' when SORT_ID2=''6'' then ''70EC2D50-6CA7-4730-8362-D76909D3BFF2'''+
         ' else ''#'' end) as SORT_ID2';
  //�����Ƿ��ص�Ʒ��:
  Sort_ID5:=
    '(case when SORT_ID4=''1'' then ''01072169-2F03-42C1-9EAB-541D031647AF'''+  //�Ƿ��ص�Ʒ��
         ' else ''15CD1495-B3C7-42C7-8709-5376FC061305'' end) as SORT_ID5 ';
  //�Ƿ�ʡ�����̣�
  Sort_ID6:=
    '(case when SORT_ID6=''0'' then ''635E6FB4-8B94-4996-95E1-A77401323560'''+  //�Ƿ�ʡ���⡢������
         ' when SORT_ID6=''1'' then ''E76D1A2A-1423-42E1-B827-8B268AF92CCD'''+
         ' when SORT_ID6=''3'' then ''800F74E2-B697-4D95-9131-8FAD458EC992'''+
         ' else ''#'' end) as SORT_ID6';
  CALC_UNIT:='''95331F4A-7AD6-45C2-B853-C278012C5525'' as CALC_UNIT '; //�а�װ��λ: GUID
  //����Ʒ��(1����Ʒ,2����,3˳��4����)��
  Sort_ID10:=
    '(case when SORT_ID10=''1'' then ''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'''+
         ' when SORT_ID10=''2'' then ''FE684BAA-F8F9-40EB-BFE5-716A143E53E3'''+
         ' when SORT_ID10=''3'' then ''5D8D7AF6-2DE3-4866-85C7-925E07F66096'''+
         ' else ''C988E384-AB8D-4F5E-95F4-554D4689396C'' end) as SORT_ID10';

  //2011.06.29�޸Ļ���ϵ����R3�ĵ�λ����ϵ��:
   Box_InPrice:=' PACK_INPRICE as NEW_INPRICE ';   //�е�λ�� ����
   Box_OutPrice:=' PACK_OUTPRICE as NEW_OUTPRICE ';  //�е�λ�� ���ۼ�
  {Box_InPrice:='(case when CAlC_AMT>0 then PACK_INPRICE*1.00/CAlC_AMT else PACK_INPRICE end) as NEW_INPRICE ';   //�е�λ�� ����
   Box_OutPrice:='(case when CAlC_AMT>0 then PACK_OUTPRICE*1.00/CAlC_AMT else PACK_OUTPRICE end) as NEW_OUTPRICE ';  //�е�λ�� ���ۼ�
  }
  
  //1����ɾ����Ӧ��ϵ�м��:
  StrSQL:=PChar('delete from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' ');
  if ExecSQL(StrSQL,iRet)<>0 then Raise Exception.Create('1����ɾ����Ӧ��ϵ�м��:');

  //2�����봫����ҵ��Ʒ��Ӧ��:
  try
    AObj:=TRecord_.Create;
    RsRim:=TZQuery.Create(nil);  //Rim��ͼ
    RsInf:=TZQuery.Create(nil);  //R3�м��
    RsBarPub:=TZQuery.Create(nil);  //R3����_��Ӧ��

    SelectSQL:=
      'select A.GODS_ID,A.BARCODE,B.ROWS_ID,B.SECOND_ID,B.RELATION_ID,'+
      '(case when A.GODS_ID=B.Gods_ID and nvl(B.SECOND_ID,'''')<>'''' then 1 else 2 end) as IsFlag from PUB_BARCODE A '+
      'left outer join (select * from PUB_GOODS_RELATION where TENANT_ID='+TENANT_ID+' and COMM not in (''02'',''12'')) B '+
      ' on A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=110000001 and A.BARCODE_TYPE=''1'' and A.COMM not in (''02'',''12'') ';
    RsBarPub.SQL.Text:=ParseSQL(DbType,SelectSQL);
    Open(RsBarPub);
    RsRim.Close;
    RsRim.SQL.Text:='select GODS_ID as SECOND_ID,GODS_CODE,GODS_NAME,'+Sort_ID2+','+Sort_ID5+','+Sort_ID6+','+Sort_ID10+','+Box_InPrice+','+Box_OutPrice+',PACK_BARCODE from RIM_GOODS_RELATION where TENANT_ID='''+COM_ID+''' ';
    Open(RsRim);
    RsInf.SQL.Text:='select A.*,0 as UpdateMode,0 as FLAG from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID;
    Open(RsInf);

    //2011.09.24 xhh ���ɻ��ܵ�BarCode���ݼ�:
    CreateBarCode(RsBarPub);
    
    //��ʼѭ������
    try
      if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then
      begin
        RsRim.First;
        while not RsRim.Eof do
        begin
          AObj.ReadFromDataSet(RsRim);
          BarCode:=trim(RsRim.fieldbyName('PACK_BARCODE').AsString);
          if RsBarPub.Locate('BARCODE',BarCode,[]) then  //�������ܹ�����
          begin
            //���ص�ǰ�������ж��ٸ�
            BarCount:=GetR3BarCode(BarCode);
            if BarCount=1 then  //Rim.BarCode=R3.BarCode(1��1)���
            begin
              //�жϵ�ǰ�������Ƿ���������ظ����:
              if RsInf.Locate('PACK_BARCODE',BarCode,[]) then  //�Ѵ���[�ظ�]
              begin
                //����ԭ��¼״̬
                RsInf.Edit;
                RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
                RsInf.FieldByName('UPDATE_FLAG').AsInteger:=4;       //״̬[4: �ظ�����]
                RsInf.FieldByName('SORT_ID3').AsString:=TENANT_ID;   //2011.08.29 ����Ӧ��Ĭ�ϣ��о��̲ݹ�˾ID
                RsInf.FieldByName('GODS_NAME').AsString:=RsInf.FieldByName('GODS_NAME').AsString+'(rim�ظ�)';
                RsInf.Post;
                //�²��뵱ǰ
                RsInf.Append;
                AObj.WriteToDataSet(RsInf,False);  //Aobjд��DataSet;
                RsInf.FieldByName('ROWS_ID').AsString:=NewId();
                RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
                RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��1000006
                RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString;
                RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
                RsInf.FieldByName('UPDATE_FLAG').AsInteger:=4;       //״̬[4: �ظ�����]
                RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //����ģʽ
                RsInf.FieldByName('FLAG').AsInteger:=SyncType; //��������[R3��Rsp]
                RsInf.FieldByName('SORT_ID3').AsString:=TENANT_ID; //2011.08.29 ����Ӧ��Ĭ�ϣ��о��̲ݹ�˾ID
                RsInf.FieldByName('GODS_NAME').AsString:=RsInf.FieldByName('GODS_NAME').AsString+'(rim�ظ�)';
                RsInf.Post;
              end else
              begin //Rim.BarCode��R3�д��ڶ������:
                RsInf.Append;
                AObj.WriteToDataSet(RsInf,False);  //Aobjд��DataSet;
                RsInf.FieldByName('ROWS_ID').AsString:=NewId();
                RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
                RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��1000006
                RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString; //���Ҿ��̹�Ӧ��
                RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
                RsInf.FieldByName('UPDATE_FLAG').AsInteger:=RsBarPub.fieldbyName('IsFlag').AsInteger; //״̬[1��ʾ�¶��ϣ�2��ʾԭ�Ѷ���]
                RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //����ģʽ
                RsInf.FieldByName('FLAG').AsInteger:=SyncType; //��������[R3��Rsp]
                RsInf.FieldByName('SORT_ID3').AsString:=TENANT_ID; //2011.08.29 ����Ӧ��Ĭ�ϣ��о��̲ݹ�˾ID
                RsInf.Post;
              end;
            end else //Rim.BarCode��R3.BarCode���ж��(���ظ�)
            begin
              //�²��뵱ǰ
              RsInf.Append;
              AObj.WriteToDataSet(RsInf,False);  //Aobjд��DataSet;
              RsInf.FieldByName('ROWS_ID').AsString:=NewId();
              RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
              RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��1000006
              RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString;
              RsInf.FieldByName('GODS_NAME').AsString:=RsInf.FieldByName('GODS_NAME').AsString+'(r3�ظ�)';
              RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
              RsInf.FieldByName('UPDATE_FLAG').AsInteger:=4;       //״̬[4: �ظ�����]
              RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //����ģʽ
              RsInf.FieldByName('FLAG').AsInteger:=SyncType; //��������[R3��Rsp]
              RsInf.FieldByName('SORT_ID3').AsString:=TENANT_ID; //2011.08.29 ����Ӧ��Ĭ�ϣ��о��̲ݹ�˾ID
              RsInf.Post;
            end;
          end else {==Rim.BarCode<>R3.BarCode ��Ϊ������ʾ����鿴==}
          begin
            RsInf.Append;
            //AObj.WriteToDataSet(RsInf, False); //Aobjд��DataSet;
            RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //���Ҿ��̹�Ӧ��:1000006
            RsInf.FieldByName('GODS_ID').AsString:='#';  //��Ӧ����Ĭ��Ϊ��#
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //������
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=0; //״̬[1�Բ���]
            RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //����ģʽ
            RsInf.FieldByName('FLAG').AsInteger:=SyncType; //��������[R3��Rsp]
            RsInf.FieldByName('SORT_ID3').AsString:=TENANT_ID; //2011.08.29 ����Ӧ��Ĭ�ϣ��о��̲ݹ�˾ID
            RsInf.Post;
          end;
          RsRim.Next;
        end; //end (ѭ��: while not RsRim.Eof do)

        //�ύ���ݿ�
        if RsInf.Changed then
        begin
          result:=UpdateBatch(RsInf.Data, 'TInf_Goods_Relation',dbResoler);
        end else
          Raise Exception.Create('��Rimû���ҵ���Ӧ����ľ��̵�����');
      end else
        Raise Exception.Create('�������ݼ�û��Open״̬��');
    except
      on E:Exception do
      begin
        Raise Exception.Create('��RIM_GOODS_RELATION��ͼ���뵽�м��:INF_GOODS_RELATION����'+E.Message); 
      end;
    end;
  finally
    AObj.Free;
    RsRim.Free;
    RsInf.Free;
    RsBarPub.Free;
  end;
end;

function TGodsDzSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  COM_ID: String;
  UpdateMode: integer; //����ģʽ
begin
  result:=-1;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;

  //1���������ݿ�����
  GetDBType;

  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��

  //3������֮ǰ������Rsp��������[Rsp���Ȳ�����]
  //if SyncType<>3 then
  // DoDownBaseInfo;

  UpdateMode:=1;  //Ĭ��Ϊȫ����
  if Params.FindParam('UPDATE_MODE')<>nil then
  begin
    UpdateMode:=Params.ParamByName('UPDATE_MODE').AsInteger;  //ˢ��ģʽ
    if (UpdateMode<1) or (UpdateMode>3) then
      UpdateMode:=1;  //Ĭ��Ϊȫ����  
  end;

  //4������Rim�̲ݹ�˾Com_ID
  COM_ID:=GetRimCOM_ID(Params.ParamByName('TENANT_ID').AsString,true);
  if COM_ID='' then Raise Exception.Create('û���ҵ���ӦRimϵͳ�̲ݹ�˾��');

  {------��ʼ�������------}
  try
    result:=InsertData_INF_GOODS_RELATION(COM_ID, UpdateMode);
  except
    on E:Exception do
    begin
      HasError:=true;
      ErrorMsg:=E.Message;
    end;
  end;
end;

function TGodsDzSyncFactory.GetParentTENANT_ID: integer;
var
  Qry: TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID='+Params.ParamByName('TENANT_ID').AsString;
    Open(Qry);
    if Qry.Active then
      result:=Qry.fieldbyName('TENANT_ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TGodsDzSyncFactory.DoDownBaseInfo;
var
  TenID: integer;
begin
  if SyncType=3 then Exit;  //ǰִ̨������
  TenID:=GetParentTENANT_ID;
  try
    CaFactory.DBFactory:=self;
    //�ж��Ƿ�ʡ����˾
    if (TenID>0) and (TenID<>110000001)  then  //�����ڹ��Ҽ���ҵ
    begin
      try
        CaFactory.TENANT_ID:=TenID;
        CaFactory.SyncAll(1);  //ִ��ʡ��˾
      except
        Raise;
      end;
    end;
    //ִ���м���˾
    try
      CaFactory.TENANT_ID:=Params.ParamByName('TENANT_ID').AsInteger;
      CaFactory.SyncAll(1);  //ִ��ʡ��˾
    except
      Raise;
    end;
  except    
  end;
end;

function TGodsDzSyncFactory.GetR3BarCode(BarCode: string): integer;
begin
  result:=0;
  try
    if R3BarSum.Locate('BARCODE',BarCode,[]) then
    begin
      result:=R3BarSum.fieldbyName('RESUM').AsInteger;
    end;
  except
  end;
end;

function TGodsDzSyncFactory.CreateBarCode(PubBarTable: TZQuery): integer;
var
  BarCode: string;
  allCount: integer;
begin
  result:=0;
  allCount:=0;
  R3BarSum.Close;
  R3BarSum.FieldDefs.Add('BARCODE',ftstring,30,true);
  R3BarSum.FieldDefs.Add('RESUM',ftInteger,0,true);
  R3BarSum.CreateDataSet;
  //��ʼѭ���ۼ�
  PubBarTable.First;
  while not PubBarTable.Eof do
  begin
    BarCode:=trim(PubBarTable.FieldbyName('BARCODE').AsString);
    if R3BarSum.Locate('BARCODE',BarCode,[]) then
    begin
      R3BarSum.Edit;
      R3BarSum.FieldByName('RESUM').AsInteger:=R3BarSum.FieldByName('RESUM').AsInteger+1;
      R3BarSum.Post;
      Inc(allCount);
    end else
    begin
      R3BarSum.Append;
      R3BarSum.FieldByName('BARCODE').AsString:=BarCode;
      R3BarSum.FieldByName('RESUM').AsInteger:=1;
      R3BarSum.Post;
      Inc(allCount);
    end;
    PubBarTable.Next;
  end;
  result:=allCount;
end;


end.
