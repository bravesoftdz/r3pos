unit ufrmCustomerExcel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms,
  Grids, DBGridEh, RzEdit, RzStatus,ComObj,IniFiles, ufrmExcelFactory,
  Menus;

  const
    FieldCount=26;
type
  TfrmCustomerExcel = class(TfrmExcelFactory)
    RzLabel14: TRzLabel;
    procedure Image4Click(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    FShopIdType,FPriceIdType,FRegionIdType:integer; //0 ����û���ļ��еģ�1  �������ļ��е����У�2 �����в����ļ���
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    procedure CreateStringList(var vList:TStringList);
    procedure TransformtoString(vList:TStringList;var vStr:widestring);overload;
    procedure TransformtoString(var vList:string;vStr:string);overload;
    function DeleteDuplicateString(vStr:string;var vStrList:TStringList):string;
    procedure ClearParams;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

  const
    FieldsString =
    'CUST_CODE=��Ա����,CUST_NAME=��Ա����,CUST_SPELL=ƴ����,SEX=�Ա�,SORT_ID=��Ա���,PRICE_ID=��Ա�ȼ�,REGION_ID=����,'+
    'SHOP_ID=����ŵ�,MOVE_TELE=�ƶ��绰,BIRTHDAY=��Ա����,FAMI_ADDR=��ַ,POSTALCODE=�ʱ�,ID_NUMBER=֤������,IDN_TYPE=֤������,SND_DATE=�������,'+
    'CON_DATE=��������,QQ=QQ,MSN=MSN,END_DATE=��Ч��ֹ����,MONTH_PAY=������,DEGREES=ѧ��,EMAIL=�����ʼ�,OFFI_TELE=�칫�绰,FAMI_TELE=��ͥ�绰,'+
    'OCCUPATION=ְҵ,JOBUNIT=������λ,REMARK=��ע';

    FormatString =
    '0=CUST_CODE,1=CUST_NAME,2=CUST_SPELL,3=SEX,4=SORT_ID,5=PRICE_ID,6=REGION_ID,7=SHOP_ID,8=MOVE_TELE,9=BIRTHDAY,10=FAMI_ADDR,'+
    '11=POSTALCODE,12=ID_NUMBER,13=IDN_TYPE,14=SND_DATE,15=CON_DATE,16=QQ,17=MSN,18=END_DATE,19=MONTH_PAY,20=DEGREES,21=EMAIL,22=OFFI_TELE,'+
    '23=FAMI_TELE,24=OCCUPATION,25=JOBUNIT,26=REMARK';


implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmCustomerExcel.CreateUseDataSet;
begin
  inherited; 
  
end;

function TfrmCustomerExcel.SaveExcel(dsExcel:TZQuery):Boolean;
var Field:TField;
    ss,ps,pr,cs:TZQuery;
    str:string;
    Params:TftParamList;
    strWhere:string;
    num:double;
begin
  cs:=TZQuery.Create(nil);
  ss:=dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  ps:=dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  pr:=dllGlobal.GetZQueryFromName('PUB_REGION_INFO');

  strWhere:='';
  if cdsColumn.Locate('FieldName','IDN_TYPE',[]) then
     strWhere:=strWhere+' ''11'' ';
  if cdsColumn.Locate('FieldName','DEGREES',[]) then
    if strWhere<>'' then
     strWhere:=strWhere+',''14'' '
    else
     strWhere:='''14'' ';
  if cdsColumn.Locate('FieldName','MONTH_PAY',[]) then
     if strWhere<>'' then
     strWhere:=strWhere+',''13'' '
    else
     strWhere:='''13'' ';
  if cdsColumn.Locate('FieldName','OCCUPATION',[]) then
     if strWhere<>'' then
     strWhere:=strWhere+',''15'' '
    else
     strWhere:='''15'' ';
  if strWhere <> '' then
  begin
    cs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE in('+strWhere+') and COMM not in (''02'',''12'') ';
    dataFactory.Open(cs);
  end;
  
  try
    dsExcel.First;
    while not dsExcel.Eof do
    begin
      dsExcel.Edit;
      dsExcel.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      dsExcel.FieldByName('CUST_ID').AsString  := TSequence.NewId;
      dsExcel.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
      dsExcel.FieldByName('CREA_USER').AsString := token.userId;
      dsExcel.FieldByName('PASSWRD').AsString := '1234';
      dsExcel.Post;

      Field:=dsExcel.FindField('CUST_SPELL');
      if (Field <> nil) and (dsExcel.FieldByName('CUST_NAME').AsString<> '') then
      begin
        dsExcel.Edit;
        dsExcel.FieldByName('CUST_SPELL').AsString:=FnString.GetWordSpell(dsExcel.FieldByName('CUST_NAME').AsString);
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('SEX');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        if Field.AsString='��' then
           str:='1'
        else if Field.AsString='Ů' then
          str:='0'
        else
          str:='2';
        dsExcel.Edit;
        dsExcel.FieldByName('SEX').AsString:=str;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('SHOP_ID');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        if ss.Locate('SHOP_NAME',dsExcel.fieldByName('SHOP_ID').AsString,[]) then
        begin
          dsExcel.Edit;
          dsExcel.fieldByName('SHOP_ID').AsString:=ss.fieldByName('SHOP_ID').AsString;
          dsExcel.Post;
        end;
      end;

      Field:=dsExcel.FindField('PRICE_ID');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        if ps.Locate('PRICE_NAME',dsExcel.fieldByName('PRICE_ID').AsString,[]) then
        begin
          dsExcel.Edit;
          dsExcel.fieldByName('PRICE_ID').AsString:=ps.fieldByName('PRICE_ID').AsString;
          dsExcel.Post;
        end;
      end;

      Field:=dsExcel.FindField('REGION_ID');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if pr.Locate('CODE_NAME',dsExcel.fieldByName('REGION_ID').AsString,[]) then
          dsExcel.fieldByName('REGION_ID').AsString:=pr.fieldByName('CODE_ID').AsString
        else
          dsExcel.fieldByName('REGION_ID').AsString:='#';
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('IDN_TYPE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if cs.Locate('CODE_NAME',dsExcel.fieldByName('IDN_TYPE').AsString,[]) then
          dsExcel.fieldByName('IDN_TYPE').AsString:=cs.fieldByName('CODE_ID').AsString
        else
          dsExcel.fieldByName('IDN_TYPE').AsString:='';
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('DEGREES');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if cs.Locate('CODE_NAME',dsExcel.fieldByName('DEGREES').AsString,[]) then
          dsExcel.fieldByName('DEGREES').AsString:=cs.fieldByName('CODE_ID').AsString
        else
          dsExcel.fieldByName('DEGREES').AsString:='';
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('MONTH_PAY');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        {
        num:=dsExcel.fieldByName('MONTH_PAY').AsFloat;
        if num>5000 then
          dsExcel.fieldByName('MONTH_PAY').AsString:='6'
        else if (num>4000) and (num<=5000) then
          dsExcel.fieldByName('MONTH_PAY').AsString:='5'
        else if (num>3000) and (num<=4000) then
          dsExcel.fieldByName('MONTH_PAY').AsString:='4'
        else if (num>2000) and (num<=3000) then
          dsExcel.fieldByName('MONTH_PAY').AsString:='3'
        else if (num>1000) and (num<=2000) then
          dsExcel.fieldByName('MONTH_PAY').AsString:='2'
        else
          dsExcel.fieldByName('MONTH_PAY').AsString:='1';
        }

        if cs.Locate('CODE_NAME',dsExcel.fieldByName('MONTH_PAY').AsString,[]) then
          dsExcel.fieldByName('MONTH_PAY').AsString:=cs.fieldByName('CODE_ID').AsString
        else
          dsExcel.fieldByName('MONTH_PAY').AsString:='';
        
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('OCCUPATION');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if cs.Locate('CODE_NAME',dsExcel.fieldByName('OCCUPATION').AsString,[]) then
          dsExcel.fieldByName('OCCUPATION').AsString:=cs.fieldByName('CODE_ID').AsString
        else
          dsExcel.fieldByName('OCCUPATION').AsString:='';
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('BIRTHDAY');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        dsExcel.fieldByName('BIRTHDAY').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.fieldByName('BIRTHDAY').AsString));
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('SND_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        dsExcel.fieldByName('SND_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.fieldByName('SND_DATE').AsString));
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('CON_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        dsExcel.fieldByName('CON_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.fieldByName('CON_DATE').AsString));
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('END_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        dsExcel.fieldByName('END_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.fieldByName('END_DATE').AsString));
        dsExcel.Post;
      end;

      dsExcel.Next;
    end;

    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(dsExcel,'TCustomerV60',nil);
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    cs.Free;
  end;

  Result := True;
end;

function TfrmCustomerExcel.FindColumn(vStr:string):Boolean;
begin
   Result := True;
  if not cdsColumn.Locate('FieldName','GODS_NAME',[]) then
    begin
      Result := False;
    end;
  if not cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
    begin
      Result := False;
    end;
  if not cdsColumn.Locate('FieldName','SORT_ID1',[]) then
    begin
      Result := False;
    end;
  if not cdsColumn.Locate('FieldName','NEW_OUTPRICE',[]) then
    begin
      Result := False;
    end;
end;

procedure TfrmCustomerExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmCustomerExcel.Check(columnIndex:integer): Boolean;
var str,strError,fieldName:string;
    num:double;
begin
  strError:='';
  fieldName:=cdsColumn.FieldByName('FileName').AsString;
  str:=cdsExcel.fieldByName(fieldName).AsString;
  case columnIndex of
    0:begin
         if str='' then
         strError:='��Ա����Ϊ��;';
       end;
    1:begin
         if str='' then
         strError:='��Ա����Ϊ��;';
       end;
    2:begin
       if str='' then
         strError:='ƴ����Ϊ��;';
      end;
    3:begin
       if str='' then
         strError:='�Ա�Ϊ��;';
      end;
    4:begin
        if str='' then
          strError:='��Ա���Ϊ��;';
      end;
    5:begin
      {
        if str='' then
          strError:='��Ա�ȼ�Ϊ��;'
        else if FieldType[5]=0 then
          strError:='��Ա�ȼ�������;';
      }
      end;
    6:begin
        if str='' then
          strError:='����Ϊ��;'
        else if FieldType[6]=0 then
          strError:='����������;';
      end;
    7:begin
        if str='' then
          strError:='����ŵ�Ϊ��;'
        else if FieldType[7]=0 then
          strError:='����ŵ겻����;';
      end;
    8:begin    //�ƶ��绰

      end;
    9:begin    //��Ա����
        if str<>'' then
         begin
           try
             fntime.fnStrtoDate(str);
           except
             strError:='��Ч�Ļ�Ա����;';
           end;
         end;
      end;
    10:begin     //��ַ
      end;
    11:begin    //�ʱ�
      end;
    12:begin    //֤������

      end;
    13:begin    //֤������

      end;
    14:begin    //�������
         if str<>'' then
         begin
           try
             fntime.fnStrtoDate(str);
           except
             strError:='��Ч���������;';
           end;
         end;
      end;
    15:begin   //��������
         if str<>'' then
         begin
           try
             fntime.fnStrtoDate(str);
           except
             strError:='��Ч����������;';
           end;
         end;
      end;
    16:begin     //QQ

      end;
    17:begin    //MSN

      end;
    18:begin    //��Ч��ֹ����
         if str<>'' then
         begin
           try
             fntime.fnStrtoDate(str);
           except
             strError:='��Ч����Ч��ֹ����;';
           end;
         end;
      end;
    19:begin    //������

      end;
    20:begin    //ѧ��

      end;
    21:begin    //�����ʼ�

      end;
    22:begin    //�칫�绰

      end;
    23:begin    //��ͥ�绰

      end;
    24:begin    //ְҵ

      end;
    25:begin    //������λ

      end;
    26:begin    //��ע

      end;

  end;
  if strError<>'' then
    cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;

  result:=true;
end;

procedure TfrmCustomerExcel.ClearParams;
var i:integer;
begin
  for i:=0 to FieldCount do
    FieldCheckSet[i]:='';
end;

function TfrmCustomerExcel.SelfCheckExcute: Boolean;
var isSort:Boolean;
    rs:TZQuery;
    fieldName,FileName:string;
    preId:integer;
    strPre,strNext:string;
begin
  try
    rs:=TZQuery.Create(nil);
    rs.Data:=cdsExcel.Data;

    ClearParams;
    cdsColumn.First;
    while not cdsColumn.Eof do
    begin
      isSort:=false;
      fieldName:=cdsColumn.FieldbyName('FieldName').AsString;
      if fieldName <> '' then
      begin
        if (fieldName='CUST_CODE') or (fieldName='SHOP_ID') or
           (fieldName='SORT_ID') or (fieldName='PRICE_ID') or
           (fieldName='REGION_ID') or (fieldName='IDN_TYPE') or
           (fieldName='DEGREES') or (fieldName='OCCUPATION') then
        begin
          if (fieldName='CUST_CODE') then
          begin
            isSort:=true;
            rs.SortedFields:=cdsColumn.fieldByName('FileName').AsString;
          end;

          FileName:=cdsColumn.fieldByName('FileName').AsString;
          if isSort then
          begin
            rs.First;
            strPre:=rs.fieldByName(FileName).AsString;
            preId:=rs.fieldByName('ID').AsInteger;
            if strPre<>'' then
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strPre);
            rs.Next;
            while not rs.Eof do
            begin
              strNext:=rs.fieldByName(FileName).AsString;
              if strPre=strNext then
              begin
                cdsExcel.Locate('ID',rs.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(preId)+'������'+cdsColumn.fieldByName('DestTitle').asstring+'�ظ�;';
                cdsExcel.Post;
              end;
              strPre:=strNext;
              preID:=rs.fieldByName('ID').AsInteger;
              if strNext<>'' then
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strNext);
              rs.Next;
            end;
          end else
          begin
            rs.First;
            while not rs.Eof do
            begin
              strNext:=rs.fieldByName(FileName).AsString;
              if strNext<> '' then
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strNext);
              rs.Next;
            end;
          end;
        end;
      end;
      cdsColumn.Next;
    end;
    OutCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmCustomerExcel.OutCheckExcute: Boolean;
var rs,ss:TZQuery;
    FieldName,tempField,strError:string;
    i,c,FieldIndex:integer;
    strWhere:string;
    strList:TStringList;
begin
  try
    rs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************��Ա����*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','CUST_CODE',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.SQL.Text:='select distinct CLIENT_CODE from VIW_CUSTOMER where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and CLIENT_CODE in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        rs.First;
        while not rs.Eof do
        begin
          ss.Filtered:=false;
          ss.Filter:=FieldName+'='''+rs.Fields[0].AsString+'''';
          ss.Filtered:=true;
          ss.First;
          while not ss.Eof do
          begin
            cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
            cdsExcel.Edit;
            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'�Ѵ���;';
            cdsExcel.Post;
            ss.Next;
          end;
          ss.Filtered:=false;
          rs.Next;
        end;
      end;
    end;

    //*********************����ŵ�*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','SHOP_ID',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select distinct CS.SHOP_NAME from VIW_CUSTOMER VC,CA_SHOP_INFO CS where VC.TENANT_ID=CS.TENANT_ID and VC.SHOP_ID=CS.SHOP_ID and VC.tenant_id='+token.tenantId+
                   ' and VC.comm not in(''02'',''12'') and CS.SHOP_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('SHOP_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

    //*********************��Ա�ȼ�*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','PRICE_ID',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select distinct CS.PRICE_NAME from VIW_CUSTOMER VC,PUB_PRICEGRADE CS where VC.TENANT_ID=CS.TENANT_ID and VC.PRICE_ID=CS.PRICE_ID and VC.tenant_id='+token.tenantId+
                   ' and VC.comm not in(''02'',''12'') and CS.PRICE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('PRICE_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

    //*********************��Ա���*****************************

    //*********************����*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','REGION_ID',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''8'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('CODE_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

    //*********************֤������*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','IDN_TYPE',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''11'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('CODE_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

    //*********************ѧ��*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','DEGREES',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''14'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('CODE_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

    //*********************ְҵ*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','OCCUPATION',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''15'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FieldType[FieldIndex]:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('CODE_NAME',strList[i],[]) then
            begin
              ss.Filtered:=false;
              ss.Filter:=FieldName+'='''+strList[i]+'''';
              ss.Filtered:=true;
              ss.First;
              while not ss.Eof do
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //����û���ļ��з���
        FieldType[FieldIndex]:=0;
    end;

  finally
    rs.Free;
    ss.Free;
  end;
end;

class function TfrmCustomerExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmCustomerExcel.Create(Owner) do
    begin
      try
        DataSet:=vDataSet;
        CreateUseDataSet;
        DecodeFields(FieldsString);
        DecodeFormats(FormatString);
        SelfCheck:=isSelfCheck;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

//Duplicates ��3����ѡֵ:
//dupIgnore: ����; 
//dupAccept: ����;
//dupError: ��ʾ����
procedure TfrmCustomerExcel.CreateStringList(var vList: TStringList);
begin
  if vList=nil then
  begin
    vList:=TStringList.Create;
    vList.Sorted:=true;
    vList.Duplicates:=dupIgnore;
  end
  else
    vList.Clear;
end;

procedure TfrmCustomerExcel.TransformtoString(vList: TStringList;var vStr:wideString);
var i:integer;
begin
  vStr:='';
  for i:=0 to vList.Count-1 do
  begin
    if vStr='' then
      vStr:=''''+vList[i]+''''
    else
      vStr:=vStr+','+''''+vList[i]+'''';;
  end;
end;

procedure TfrmCustomerExcel.Image4Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('�Ƿ�Ҫ������Ʒ����ģ�壿'),'������ʾ',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then exit;
  saveDialog1.DefaultExt:='*.xls';
  saveDialog1.Filter:='Excel�ĵ�(*.xls)|*.xls';
  if saveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '�Ѿ����ڣ��Ƿ񸲸�����'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    try
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա��Ϣ�����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա��Ϣ�����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmCustomerExcel.DeleteDuplicateString(vStr: string;var vStrList:TStringList): string;
var i:integer;
    strResult:string;
begin
  strResult:='';
  if vStrList=nil then
  begin
    vStrList:=TStringList.Create;
    vStrList.Sorted:=true;
    vStrList.Duplicates:= dupIgnore;
  end
  else
    vStrList.Clear;

  vStrList.DelimitedText:=vStr;
  for i:=0 to vStrList.Count-1 do
  begin
    if strResult='' then
      strResult:=''''+vStrList[i]+''''
    else
    strResult:=strResult+','+''''+vStrList[i]+'''';
  end; 
  result:=strResult;
end;

procedure TfrmCustomerExcel.TransformtoString(var vList: string;
  vStr: string);
begin
  if vList='' then
    vList:=vStr
  else
    vList:=vList+','+vStr;
end;

end.
