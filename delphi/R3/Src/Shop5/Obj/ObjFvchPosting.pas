//ƾ֤����
//1�����뵽���������ݿ�;
//2������ƾ֤�ֶ�(��ѡ�ֶ�);
//3��ACC_FVCHORDER,ACC_FVCHDATA��ACC_FVCHDetail����;


unit ObjFvchPosting;

interface

uses
  Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  //ƾ֤���ˣ���ˣ�
  TFvchPostForInspur_OLD=class(TZProcFactory)
  private
    FDBLink:string;   //����DBLink
    FVCH_BH:string;   //ƾ֤�ֱ��
    FVCH_NAME:string; //ƾ֤��
    FVCH_DATE:string; //ƾ֤����
    FPZZNUM:integer;  //ƾ֤�����
    FPZNM:integer;     //ƾ֤����
    FPZFLNM:integer;   //ƾ֤��¼����
    FvchOrder:TZQuery;  //�������ݼ�
    FvchData:TZQuery;   //��¼���ݼ�
    FvchDetail:TZQuery; //�������ݼ�
    //��ȡ����
    function OpenFvchData(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //����ƾ֤����
    function DoCopyFvchOrder(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //����ƾ֤��¼
    function DoCopyFvchData(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //����ƾ֤��¼��ϸ
    function DoCopyFvchDetail(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //����ԭ����״̬�͵��ݺ�
    function UpdateOldOrderAndBM(AGlobal:IdbHelp;Params:TftParamList): Boolean;
  public
    constructor Create(AGlobal:IdbHelp;Params:TftParamList);override;
    destructor Destroy;override;
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  
implementation
 

{ TFvchAudit }

function TFvchPostForInspur_OLD.DoCopyFvchOrder(AGlobal:IdbHelp;Params:TftParamList): Boolean;
var
  SQL: string;
  iRet: integer;
begin
  result:=False;
  //���������¼
  SQL:=
    'insert into '+FDBLink+'ZWPZK '+
        '(ZWPZK_PZNM'+   //ƾ֤����
        ',ZWPZK_KJND'+   //������
        ',ZWPZK_KJQJ'+   //����ڼ�
        ',ZWPZK_PZRQ'+   //�������
        ',ZWPZK_PZBH'+   //ƾ֤���루8�ֽڣ�
        ',ZWPZK_LXBH'+   //ƾ֤����
        ',ZWPZK_FJZS'+   //������
        ',ZWPZK_ZDR)'+   //�Ƶ���
    ' values '+
        '('''+IntToStr(FPZNM)+''''+
        ','''+Copy(FVCH_DATE,1,4)+''''+
        ','''+Copy(FVCH_DATE,5,2)+''''+
        ','''+FVCH_DATE+''''+
        ','''+FVCH_NAME+''''+
        ','''+FVCH_BH+''''+
        ','+IntToStr(FvchOrder.FieldByName('FVCH_ATTACH').AsInteger)+
        ','''+FvchOrder.FieldByName('SUBJECT_NO').AsString+''')';
  iRet:=AGlobal.ExecSQL(SQL);
  result:=(iRet=1);
end;

function TFvchPostForInspur_OLD.DoCopyFvchData(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SQL: string;
  RecNo,iRet: integer;
begin
  result:=False;
  iRet:=0;
  if not FvchData.Active then Exit;
  FvchData.First;
  while not FvchData.Eof do
  begin
    RecNo:=FvchData.RecNo;
    SQL:=
      'insert into '+FDBLink+'ZWPZFL '+
          '(ZWPZFL_PZNM'+   //ƾ֤����
          ',ZWPZFL_FLNM'+   //��¼����
          ',ZWPZFL_FLBH'+   //��¼��� ��4λϵͳ��ţ�
          ',ZWPZFL_KMBH'+   //��Ŀ��� ���������������еĿ�Ŀ����һ�£�
          ',ZWPZFL_ZY'+     //ժҪ
          ',ZWPZFL_JE'+     //���
          ',ZWPZFL_SL'+     //����
          ',ZWPZFL_DJ'+     //����
          ',ZWPZFL_JZFX'+   //���˷���'1':�跽��'2':����
          ',ZWPZFL_YWRQ)'+  //ҵ������
      ' values '+
          '('''+IntToStr(FPZNM)+''''+
          ','''+IntToStr(FPZFLNM)+''''+
          ','''+FormatFloat('0000',RecNo)+''''+
          ','''+FvchData.FieldByName('SUBJECT_NO').AsString+''''+
          ','''+FvchData.FieldByName('SUMMARY').AsString+''''+
          ','''+FloatToStr(FvchData.FieldByName('AMONEY').AsFloat)+''''+
          ','''+FloatToStr(FvchData.FieldByName('AMOUNT').AsFloat)+''''+
          ','''+FloatToStr(FvchData.FieldByName('APRICE').AsFloat)+''''+
          ','''+FvchData.FieldByName('SUBJECT_TYPE').AsString+''''+
          ','''+IntToStr(FvchData.FieldByName('OPER_DATE').AsInteger)+''''+
          ')';
    //ִ�в����¼SQL
    AGlobal.ExecSQL(SQL);
    FvchData.Next;
    Inc(iRet);
  end;
  result:=(RecNo=iRet);
end;

function TFvchPostForInspur_OLD.DoCopyFvchDetail(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SQL: string;
  RecNo,iRet: integer;
begin
  result:=False;
  iRet:=0;
  if not FvchDetail.Active then Exit;
  FvchDetail.First;
  while not FvchDetail.Eof do
  begin
    RecNo:=FvchDetail.RecNo;
    SQL:=
      'insert into '+FDBLink+'ZWFZYS '+
          '(ZWFZYS_PZNM'+   //ƾ֤����
          ',ZWFZYS_FLNM'+   //��¼����
          ',ZWFZYS_YSBH'+   //�������
          ',ZWPZFL_KMBH'+   //��Ŀ��� ���������������еĿ�Ŀ����һ�£�
          ',ZWFZYS_BMBH'+   //���ű��
          ',ZWFZYS_DWBH'+   //������λ���
          ',ZWFZYS_ZGBH'+   //��Ա����
          ',ZWFZYS_XM01'+   //��Ŀ01
          ',ZWFZYS_XM02'+   //��Ŀ02
          ',ZWFZYS_XM03'+   //��Ŀ03
          ',ZWFZYS_XM04'+   //��Ŀ04
          ',ZWFZYS_XM05'+   //��Ŀ05                              
          ',ZWPZFL_JZFX'+   //���˷���'1':�跽��'2':����
          ',ZWFZYS_SL'+     //����
          ',ZWFZYS_DJ'+     //����
          ',ZWFZYS_JE'+     //���
          ',ZWFZYS_YWRQ)'+   //ҵ������
      ' values '+
          '('''+IntToStr(FPZNM)+''''+
          ','''+IntToStr(FPZFLNM)+''''+
          ','''+FormatFloat('0000',RecNo)+''''+
          ','''+FvchDetail.FieldByName('SUBJECT_NO').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_DEPT_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_CLIENT_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_USER_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR1_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR2_ID').AsString+''''+          
          ','''+FvchDetail.FieldByName('SUBJ_OTHR3_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR4_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR5_ID').AsString+''''+                       
          ','''+FvchDetail.FieldByName('SUBJECT_TYPE').AsString+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('AMOUNT').AsFloat)+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('APRICE').AsFloat)+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('AMONEY').AsFloat)+''''+
          ','''+IntToStr(FvchDetail.FieldByName('OPER_DATE').AsInteger)+''''+
          ')';    
    //ִ�в����¼SQL
    AGlobal.ExecSQL(SQL);
    FvchDetail.Next;
    Inc(iRet);
  end;
  result:=(RecNo=iRet);
end;

function TFvchPostForInspur_OLD.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SaveTrans: Boolean;
begin
  //��������Ӧ��
  try
    if not OpenFvchData(AGlobal,Params) then Exit;
  except
    on E:Exception do
    begin
      Msg := E.Message;
    end;
  end;
  //��ʼ��������
  SaveTrans := AGlobal.InTransaction;
  if not SaveTrans then AGlobal.BeginTrans;
  try
    //111������ƾ֤����
    DoCopyFvchOrder(AGlobal,Params);
    //222������ƾ֤��¼��
    DoCopyFvchData(AGlobal,Params);
    //333������ƾ֤��ϸ��
    DoCopyFvchDetail(AGlobal,Params);
    //444�����µ��������
    UpdateOldOrderAndBM(AGlobal,Params);

    AGlobal.CommitTrans; 
  except
    on E:Exception do
    begin
      Msg := E.Message;
      AGlobal.RollBackTrans;
    end;
  end;
end;

constructor TFvchPostForInspur_OLD.Create(AGlobal: IdbHelp; Params: TftParamList);
begin
  inherited;
  FDBLink:='CWSER.cwbase1.lc0019999.';
  FvchOrder:=TZQuery.Create(nil);  //�������ݼ�
  FvchData:=TZQuery.Create(nil);   //��¼���ݼ�
  FvchDetail:=TZQuery.Create(nil); //�������ݼ�
end;

destructor TFvchPostForInspur_OLD.Destroy;
begin
  FvchOrder.Free;
  FvchData.Free;
  FvchDetail.Free;
  inherited;
end;

function TFvchPostForInspur_OLD.OpenFvchData(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Rs: TZQuery;
  FVCH_ID,ZXTab: string;
begin
  result:=False;
  FPZNM:=0; //ƾ֤����
  FPZFLNM:=0; //ƾ֤��¼����
  Rs:=TZQuery.Create(nil);
  try
    //ȡ����(FvchOrder)FvchData,FvchDetail)
    FvchOrder.Close;
    FvchOrder.SQL.Text:=ParseSQL(AGlobal.iDbType,
      'select a.*,c.SUBJECT_NO from ACC_FVCHORDER a left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.CREA_USER=c.USER_ID '+
      ' where a.TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID and FVCH_FLAG<>''3'' and isnull(FVCH_IMPORT_ID,'''')='''' ');
    FvchOrder.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
    FvchOrder.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
    AGlobal.Open(FvchOrder);
    if FvchOrder.RecordCount=1 then
    begin
      FVCH_ID:=FvchOrder.FieldByName('FVCH_ID').AsString;
      FVCH_DATE:=FvchOrder.FieldByName('FVCH_DATE').AsString;
      FVCH_NAME:=FvchOrder.FieldByName('FVCH_NAME').AsString;
      //ȡƾ֤���롢��¼����
      Rs.Close;
      Rs.SQL.Text:='select LSNBBM_NMBH,LSNBBM_DQNM from '+FDBLink+'LSNBBM where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH in (''ZWPZNM'',''ZWFLNM'')';
      AGlobal.Open(Rs);
      if Rs.Active then
      begin
        if Rs.Locate('LSNBBM_NMBH','ZWPZNM',[]) then
          FPZNM:=StrToIntDef(Rs.FieldByName('LSNBBM_DQNM').AsString,0);
        if Rs.Locate('LSNBBM_NMBH','ZWFLNM',[]) then
          FPZFLNM:=StrToIntDef(Rs.FieldByName('LSNBBM_DQNM').AsString,0);
      end else
        Raise Exception.Create('    ȡƾ֤�������...    ');

      //ȡƾ֤�ֱ��   
      Rs.Close;
      Rs.SQL.Text:='select ZWPZLX_LXBH from '+FDBLink+'ZWPZLX where ZWPZLX_PZZ='''+FVCH_NAME+''' ';
      AGlobal.Open(Rs);
      if (Rs.Active) and (Rs.RecordCount=1) then
        FVCH_BH:=trim(Rs.FieldByName('ZWPZLX_LXBH').AsString) 
      else
      begin
        if Rs.RecordCount>1 then Raise Exception.Create('  �����ظ�ƾ֤����...  ');
        if Rs.RecordCount=0 then Raise Exception.Create('  ƾ֤�֡�'+FVCH_NAME+'���ı�Ų�����...  '); 
      end;

      //ȡƾ֤���[����ƾ֤��]
      Rs.Close;
      Rs.SQL.Text:='select ZWPZBH_PZBH from '+FDBLink+'ZWPZBH where ZWPZBH_KJND='''+copy(FVCH_DATE,1,4)+''' and ZWPZBH_KJQJ='''+copy(FVCH_DATE,5,2)+''' and ZWPZBH_PZZ='''+FVCH_NAME+''' ';
      AGlobal.Open(Rs);
      if (Rs.Active) and (Rs.RecordCount=1) then
      begin
        FPZZNUM:=StrToIntDef(Rs.FieldByName('ZWPZBH_PZBH').AsString,0);
        FVCH_NAME:=FVCH_NAME+FormatFloat('0000',FPZZNUM);
      end else
      begin
        if Rs.RecordCount>1 then Raise Exception.Create('  �����ظ�ƾ֤��...  ');
        if Rs.RecordCount=0 then Raise Exception.Create('  ƾ֤�֡�'+FVCH_NAME+'��������...  '); 
      end;

      //ȡ��¼����(FvchData)
      FvchData.Close;
      FvchData.SQL.Text:='select * from ACC_FVCHDATA where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID order by SUBJECT_TYPE,SEQNO';
      FvchData.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
      FvchData.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
      AGlobal.Open(FvchData);

      //ȡ����(FvchDetail)
      ZXTab:='select CODE_ID,CODE_SPELL as SUBJ_OTHR_ID from PUB_CODE_INFO where TENANT_ID='+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+' and CODE_TYPE=''20'' ';
      FvchDetail.Close;
      FvchDetail.SQL.Text:=ParseSQL(AGlobal.iDbType,
        'select a.*'+
        ',b.SUBJECT_NO'+                      //��Ŀ
        ',c.SUBJECT_NO as SUBJ_USER_ID'+      //��ԱID
        ',d.SUBJECT_NO as SUBJ_DEPT_ID'+      //����ID
        ',e.SUBJECT_NO as SUBJ_SHOP_ID'+      //�ŵ�ID
        ',f.SUBJECT_NO as SUBJ_CLIENT_ID'+    //������λ
        ',g.SUBJ_OTHR_ID as SUBJ_OTHR1_ID'+   //ר��1
        ',h.SUBJ_OTHR_ID as SUBJ_OTHR2_ID'+   //ר��2
        ',i.SUBJ_OTHR_ID as SUBJ_OTHR3_ID'+   //ר��3
        ',j.SUBJ_OTHR_ID as SUBJ_OTHR4_ID'+   //ר��4
        ',k.SUBJ_OTHR_ID as SUBJ_OTHR5_ID '+  //ר��5
        ' from ACC_FVCHDETAIL a '+
        ' left outer join ACC_FVCHDATA b on a.TENANT_ID=b.TENANT_ID and a.FVCH_ID=b.FVCH_ID and a.FVCH_DID=b.FVCH_DID '+
        ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.SUBJ_USER=c.USER_ID '+
        ' left outer join CA_DEPT_INFO d on a.TENANT_ID=c.TENANT_ID and a.SUBJ_DEPT=d.DEPT_ID '+
        ' left outer join CA_SHOP_INFO e on a.TENANT_ID=e.TENANT_ID and a.SUBJ_SHOP=e.SHOP_ID '+
        ' left outer join VIW_CLIENTINFO f on a.TENANT_ID=f.TENANT_ID and a.SUBJ_CLIENT=f.CLIENT_ID '+
        ' left outer join ('+ZXTab+') g on a.TENANT_ID=g.TENANT_ID and a.SUBJ_OTHR1=g.CODE_ID '+
        ' left outer join ('+ZXTab+') h on a.TENANT_ID=h.TENANT_ID and a.SUBJ_OTHR2=h.CODE_ID '+
        ' left outer join ('+ZXTab+') i on a.TENANT_ID=i.TENANT_ID and a.SUBJ_OTHR3=i.CODE_ID '+
        ' left outer join ('+ZXTab+') j on a.TENANT_ID=j.TENANT_ID and a.SUBJ_OTHR4=j.CODE_ID '+
        ' left outer join ('+ZXTab+') k on a.TENANT_ID=k.TENANT_ID and a.SUBJ_OTHR5=k.CODE_ID '+
        ' where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID'
        );
      FvchDetail.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
      FvchDetail.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
      AGlobal.Open(FvchDetail);
      result:=FvchDetail.Active;
    end else
    begin
      if FvchOrder.RecordCount>1 then
        Raise Exception.Create('  �����ظ�ƾ֤����...  ');
      if FvchOrder.RecordCount=0 then
        Raise Exception.Create('  û���ҵ���Ӧƾ֤����...  ');
    end;
  finally
    Rs.Free;
  end;
end;

function TFvchPostForInspur_OLD.UpdateOldOrderAndBM(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  UpSQL: string;
begin               
  //����
  UpSQL:=
    'update ACC_FVCHORDER set FVCH_FLAG=''2'',FVCH_IMPORT_ID='''+IntToStr(FPZNM)+''' '+
    ' where TENANT_ID='+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+' and FVCH_ID='''+Params.ParamByName('FVCH_ID').AsString+''' ';
  AGlobal.ExecSQL(UpSQL);
  
  //����ƾ֤��¼����:
  UpSQL:='update '+FDBLink+'LSNBBM set LSNBBM_DQNM='''+IntToStr(FPZNM)+''' where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH=''ZWPZNM'' ';
  AGlobal.ExecSQL(UpSQL);
  //����ƾ֤��¼����:
  UpSQL:='update '+FDBLink+'LSNBBM set LSNBBM_DQNM='''+IntToStr(FPZFLNM)+''' where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH=''ZWFLNM'' ';
  AGlobal.ExecSQL(UpSQL);
  //����ƾ֤�ֱ���:
  UpSQL:=
   'update '+FDBLink+'ZWPZBH set ZWPZBH_PZBH='''+IntToStr(FPZZNUM)+''' '+
   ' where ZWPZBH_KJND='''+copy(FVCH_DATE,1,4)+''' and ZWPZBH_KJQJ='''+copy(FVCH_DATE,5,2)+''' and ZWPZBH_PZZ='''+FVCH_NAME+''' ';
  AGlobal.ExecSQL(UpSQL);
end;

initialization
  RegisterClass(TFvchPostForInspur);

finalization
  UnRegisterClass(TFvchPostForInspur);

end.
