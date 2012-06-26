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
  TFvchPosting=class(TZProcFactory)
  private
    //�ж��Ƿ��ظ�
    function CheckDataExists(AGlobal:IdbHelp;const Str:string):Boolean;
    //����ǰ�ж��Ƿ�����
    function DoCheckFvchPosting(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //��ͬ�Խ�ϵͳ����
    //�˳�ͨ��
    function DoFvchPostForInspur(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //���Ѳ���
    function DoFvchPostForYonYou(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //�������
    function DoFvchPostForKingDee(AGlobal:IdbHelp;Params:TftParamList):Boolean;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;


implementation
 

{ TFvchPosting }

function TFvchPosting.CheckDataExists(AGlobal:IdbHelp;const Str:string):Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if (Rs.Active) then
    begin
      if Rs.FindField('RESUM')<>nil then //�����ֶ�
        result:=(Rs.FieldByName('RESUM').AsInteger>0)
      else
        result:=(trim(Rs.Fields[0].AsString)<>'');  //�ж��ֶ�ֵ�Ƿ�Ϊ��
     end;
  finally
    Rs.Free;
  end;
end;

function TFvchPosting.DoCheckFvchPosting(AGlobal:IdbHelp;Params:TftParamList): Boolean;
var
  Ten_ID: integer;
  Fvch_ID: string;
  Str,ZxTab,ReStr,UserID,CurValue: string;
  Rs: TZQuery;
begin
  result:=False;
  Ten_ID:=Params.ParamByName('TENANT_ID').AsInteger;
  Fvch_ID:=Params.ParamByName('FVCH_ID').AsString;
  //�ж��Ƿ����
  Str:='select count(*) as RESUM from ACC_FVCHORDER '+
       ' where TENANT_ID='+IntToStr(Ten_ID)+' and FVCH_ID='''+Fvch_ID+''' and FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''') ';
  if CheckDataExists(AGlobal,Str) then
  begin
    Msg:='     ��ǰƾ֤�ѹ��ˣ������ظ����ˣ�   ';
    Exit;
  end;

  try
    Rs:=TZQuery.Create(nil);
    //�жϵ��ݵ���Ա�Ƿ�ά������ϵͳ����
    Str:='select a.CREA_USER as CREA_USER,c.SUBJECT_NO as SUBJECT_NO from ACC_FVCHORDER a '+
         ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.CREA_USER=c.USER_ID '+
         ' where a.TENANT_ID='+IntToStr(Ten_ID)+' and a.FVCH_ID='''+Fvch_ID+''' ';
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if (Rs.Active) and (Trim(Rs.FieldByName('CREA_USER').AsString)<>'') then
    begin
      UserID:=Trim(UpperCase(Rs.FieldByName('CREA_USER').AsString));
      if (UserID='ADMIN') or (UserID='SYSTEM') then 
      begin
        Rs.Close;
        Rs.SQL.Text:='select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Ten_ID)+' and DEFINE in (''ADMIN_SUBJECT_NO'',''SYSTEM_SUBJECT_NO'') ';
        AGlobal.Open(Rs);
        if UserID='ADMIN' then
        begin
          if Rs.Locate('DEFINE','ADMIN_SUBJECT_NO',[]) then
          begin
            if trim(Rs.FieldByName('VALUE').AsString) = '' then
            begin
              Msg:='   ��ǰƾ֤�Ƶ���(��������Աadmin)û�����ò���ϵͳ�Ķ�Ӧ���룬����������Ա�������룡   ';
              Exit;
            end;
          end;
        end else
        if UserID='SYSTEM' then
        begin
          if Rs.Locate('DEFINE','SYSTEM_SUBJECT_NO',[]) then
          begin
            if trim(Rs.FieldByName('VALUE').AsString) = '' then
            begin
              Msg:='   ��ǰƾ֤�Ƶ���(��������Աsystem)û�����ò���ϵͳ�Ķ�Ӧ���룬����������Ա�������룡  ';
              Exit;
            end;
          end;
        end;
      end else
      begin
        if Trim(Rs.FieldByName('SUBJECT_NO').AsString)<>'' then
        begin
          Msg:='   ��ǰƾ֤�Ƶ���û�����ò���ϵͳ�Ķ�Ӧ���룬����������Ա�������룡   ';
          Exit;
        end;
      end;
    end;

    //��¼��ϸ
    ZxTab:='select CODE_ID,CODE_SPELL as SUBJ_OTHR_ID,CODE_NAME from PUB_CODE_INFO where TENANT_ID='+IntToStr(Ten_ID)+' and CODE_TYPE=''20'' ';
    Str:=
      'select '+
        ' a.SUBJ_USER,c.SUBJECT_NO as SUBJ_USER_ID,USER_NAME'+        //��ԱID
        ',a.SUBJ_DEPT,d.SUBJECT_NO as SUBJ_DEPT_ID,DEPT_NAME'+       //����ID
        ',a.SUBJ_CLIENT,f.SUBJECT_NO as SUBJ_CLIENT_ID,CLIENT_ID'+   //������λ
        ',a.SUBJ_OTHR1,g.SUBJ_OTHR_ID as SUBJ_OTHR1_ID,g.CODE_NAME as CODE_NAME1'+   //ר��1
        ',a.SUBJ_OTHR2,h.SUBJ_OTHR_ID as SUBJ_OTHR2_ID,h.CODE_NAME as CODE_NAME2'+   //ר��2
        ',a.SUBJ_OTHR3,i.SUBJ_OTHR_ID as SUBJ_OTHR3_ID,i.CODE_NAME as CODE_NAME3'+   //ר��3
        ',a.SUBJ_OTHR4,j.SUBJ_OTHR_ID as SUBJ_OTHR4_ID,j.CODE_NAME as CODE_NAME4'+   //ר��4
        ',a.SUBJ_OTHR5,k.SUBJ_OTHR_ID as SUBJ_OTHR5_ID,k.CODE_NAME as CODE_NAME5 '+  //ר��5
      ' from ACC_FVCHDETAIL a '+
      ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.SUBJ_USER=c.USER_ID '+
      ' left outer join CA_DEPT_INFO d on a.TENANT_ID=c.TENANT_ID and a.SUBJ_DEPT=d.DEPT_ID '+
      ' left outer join PUB_CLIENTINFO f on a.TENANT_ID=f.TENANT_ID and a.SUBJ_CLIENT=f.CLIENT_ID '+
      ' left outer join ('+ZxTab+') g on a.SUBJ_OTHR1=g.CODE_ID '+
      ' left outer join ('+ZxTab+') h on a.SUBJ_OTHR2=h.CODE_ID '+
      ' left outer join ('+ZxTab+') i on a.SUBJ_OTHR3=i.CODE_ID '+
      ' left outer join ('+ZxTab+') j on a.SUBJ_OTHR4=j.CODE_ID '+
      ' left outer join ('+ZxTab+') k on a.SUBJ_OTHR5=k.CODE_ID '+
      ' where a.TENANT_ID='+IntToStr(Ten_ID)+' and a.FVCH_ID='''+Fvch_ID+''' ';
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if Rs.Active then
    begin
      ReStr:='';
      Rs.First;
      while not Rs.Eof do
      begin
        if (trim(Rs.FieldByName('SUBJ_USER').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_USER_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('USER_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ��Ա��'+CurValue+'��û��ά������ϵͳ��Ա����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_DEPT').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_DEPT_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('DEPT_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ���ţ�'+CurValue+'��û��ά������ϵͳ���ű���;';
        end;
        if (trim(Rs.FieldByName('SUBJ_CLIENT').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_CLIENT_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('DEPT_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ������λ��'+CurValue+'��û��ά������ϵͳ������λ����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR1').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR1_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME1').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ר�'+CurValue+'��û��ά������ϵͳ����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR2').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR2_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME2').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ר�'+CurValue+'��û��ά������ϵͳ����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR3').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR3_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME3').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ר�'+CurValue+'��û��ά������ϵͳ����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR4').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR4_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME4').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ר�'+CurValue+'��û��ά������ϵͳ����;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR5').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR5_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME5').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   ר�'+CurValue+'��û��ά������ϵͳ����;';
        end;
        Rs.Next;
      end;
    end;
    if trim(ReStr)<>'' then
    begin
      Msg:=ReStr;
      Exit;
    end;
  finally
    Rs.Free;
  end;
  result:=true;
end;

function TFvchPosting.DoFvchPostForInspur(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Ten_ID: integer;
  Fvch_ID: string;
  Str: string;
  Rs: TZQuery;
begin
  result:=False;
  Ten_ID:=Params.ParamByName('TENANT_ID').AsInteger;
  Fvch_ID:=Params.ParamByName('FVCH_ID').AsString;
  try
    //�ж��Ƿ����
    Str:='select count(*) as RESUM from ACC_FVCHORDER '+
         ' where TENANT_ID='+IntToStr(Ten_ID)+' and FVCH_ID='''+Fvch_ID+''' and FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''') ';
    if CheckDataExists(AGlobal,Str) then
    begin
      Msg:='     ��ǰƾ֤�ѹ��ˣ������ظ����ˣ�   ';
      Exit;
    end;
    //�жϵ����Ƿ��ѹ���
    Rs:=TZQuery.Create(nil);
    //��ʼִ�й���...
    Rs.Close;
    Rs.SQL.Text:='exec dt_AccPosting '+IntToStr(Ten_ID)+','''+Fvch_ID+''' ';
    AGlobal.Open(Rs);
    if (not Rs.IsEmpty) and (Rs.Fields[0].AsInteger>0) then
      Msg:='  ƾ֤���˳ɹ��� '
    else
      Msg:='  ƾ֤����ʧ�ܣ� ';
    result:=(not Rs.IsEmpty);
  finally
    Rs.Free;
  end;
end;

function TFvchPosting.DoFvchPostForKingDee(AGlobal: IdbHelp; Params: TftParamList): Boolean;
begin

end;

function TFvchPosting.DoFvchPostForYonYou(AGlobal: IdbHelp; Params: TftParamList): Boolean;
begin

end;

{==����ϵͳ����:1�˳�ͨ��ERP-PS����ϵͳ; 2:���Ѳ���ϵͳ;3:�������ϵͳ==}
function TFvchPosting.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  CW_IDX: integer; //����ϵͳ����
  Rs:TZQuery;
begin
  result:=False;
  //����ǰ�ж�
  if not DoCheckFvchPosting(AGlobal,Params) then Exit;

  //���ù���
  CW_IDX:=Params.ParamByName('CW_IDX').AsInteger;
  case CW_IDX of
   1: result:=DoFvchPostForInspur(AGlobal,Params);
   2: result:=DoFvchPostForYonYou(AGlobal,Params);
   3: result:=DoFvchPostForKingDee(AGlobal,Params);
  end;
end;

initialization
  RegisterClass(TFvchPosting);

finalization
  UnRegisterClass(TFvchPosting);

end.
