unit ufrmOrderExcel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms,
  Grids, DBGridEh, RzEdit, RzStatus,ComObj,IniFiles,ufrmOrderForm,ufrmExcelFactory,
  Menus, RzPrgres;

type
  TfrmOrderExcel = class(TfrmExcelFactory)
    chkPrice: TcxCheckBox;
    cxCheckBox1: TcxCheckBox;
    procedure chkPriceClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure RzLabel17Click(Sender: TObject);
  private
    FBarcode:widestring;
    FGoodsCode:widestring;
    FUnits:widestring;
    FSorts:widestring;
    FBarcodeType:integer;
    FGodsCodeType:integer; //0 ����û���ļ��еķ��ࣻ1  �������ļ��еĲ�Ϊ�����з��ࣻ2 �����в����ļ��з���
    barCodeList,godsCodeList,unitList,sortList:TStringList;
    FPriceCount:integer;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function CheckExcute:Boolean;override;
    function FindColumn(vStr:string):Boolean;override;
    function FindColumn2(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function CheckGodsCode(cs,ss:TZQuery):Boolean;
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    function IsRequiredFiled(strFiled:string):Boolean;override;
    procedure ClearParams;
    procedure fillExecl(FileName: string);
  public
    orderForm:TfrmOrderForm;
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmOrderExcel.CreateUseDataSet;
begin
  inherited;

end;

function TfrmOrderExcel.SaveExcel(dsExcel:TZQuery):Boolean;
var us,gs:TZQuery;
    Field:TField;
    RecordObj:TRecord_;
begin
  if dsExcel.RecordCount=0 then exit;
  ProgressBar1.Visible:=true;
  Result:=false;
  us:=dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  gs:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  RecordObj:=TRecord_.Create;
  try
    dsExcel.First;
    while not dsExcel.Eof do
    begin
      ProgressBar1.Percent:=round(dsExcel.RecNo/dsExcel.RecordCount*100);
      ProgressBar1.Update;
      Field:=dsExcel.FindField('UNIT_ID');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if us.Locate('UNIT_NAME',dsExcel.fieldbyName('UNIT_ID').AsString,[]) then
           dsExcel.fieldbyName('UNIT_ID').AsString:=us.fieldByName('UNIT_ID').asstring;
        dsExcel.Post;
      end
      else
        raise exception.Create('û���ҵ���Ӧ�ĵ�λ��');

      if (gs.Locate('BARCODE',dsExcel.fieldByName('BARCODE').AsString,[])) or
         (gs.Locate('GODS_CODE',dsExcel.fieldByName('GODS_CODE').AsString,[])) then
      begin
        dsExcel.Edit;
        dsExcel.FieldByName('GODS_ID').AsString:=gs.fieldByName('GODS_ID').AsString;
        dsExcel.Post;
        RecordObj.ReadFromDataSet(gs,False);
      end
      else
        raise exception.Create('û���ҵ���Ӧ����Ʒ��');

      orderForm.AddRecord(RecordObj,dsExcel.fieldbyName('UNIT_ID').AsString);

      Field:=dsExcel.FindField('AMOUNT');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        orderForm.edtTable.Edit;
        orderForm.edtTable.FieldByName('AMOUNT').AsFloat := Field.AsFloat;
        orderForm.edtTable.Post;
        orderForm.AmountToCalc(Field.AsFloat);
      end;

      Field:=dsExcel.FindField('APRICE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        orderForm.edtTable.Edit;
        orderForm.edtTable.FieldByName('APRICE').AsFloat := Field.AsFloat;
        orderForm.edtTable.Post;
        orderForm.PriceToCalc(Field.AsFloat);
      end;
      
      Field:=dsExcel.FindField('AGIO_RATE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        orderForm.edtTable.Edit;
        orderForm.edtTable.FieldByName('AGIO_RATE').AsFloat := Field.AsFloat;
        orderForm.edtTable.Post;
        orderForm.AgioToCalc(Field.AsFloat);
      end;

      Field:=dsExcel.FindField('AGIO_MONEY');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        orderForm.edtTable.Edit;
        orderForm.edtTable.FieldByName('AGIO_MONEY').AsFloat := Field.AsFloat;
        orderForm.edtTable.Post;
      end;

      Field:=dsExcel.FindField('REMARK');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        orderForm.edtTable.Edit;
        orderForm.edtTable.FieldByName('REMARK').AsString := Field.AsString;
        orderForm.edtTable.Post;
      end;

      dsExcel.Next;
    end;
  except
    ProgressBar1.Visible:=false;
    raise;
  end;
  ProgressBar1.Visible:=false;
  Result := True;
end;

function TfrmOrderExcel.FindColumn(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if not cdsColumn.Locate('FieldName','BARCODE',[]) then
  begin
    Result := False;
    strError:='������';
  end;
  if not cdsColumn.Locate('FieldName','GODS_CODE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'����'
    else
      strError:='����';
  end;
  if not cdsColumn.Locate('FieldName','GODS_NAME',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��Ʒ����'
    else
    strError:='��Ʒ����';
  end;
  if not cdsColumn.Locate('FieldName','UNIT_ID',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��λ'
    else
    strError:='��λ';
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('ȱ��'+strError+'�ֶζ�Ӧ��ϵ�������Ӧ��ϵ���û����ļ���');
  end;
end;

function TfrmOrderExcel.FindColumn2(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    strError:='������';
  end;
  if (cdsColumn.Locate('FieldName','GODS_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'����'
    else
      strError:='����';
  end;
  if (cdsColumn.Locate('FieldName','GODS_NAME',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��Ʒ����'
    else
    strError:='��Ʒ����';
  end;
  if (cdsColumn.Locate('FieldName','UNIT_ID',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��λ'
    else
    strError:='��λ';
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('ȱ��'+strError+'�ֶζ�Ӧ��ϵ�������Ӧ��ϵ���û����ļ���');
  end;
end;

procedure TfrmOrderExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmOrderExcel.Check(columnIndex:integer): Boolean;
var str,fieldName,strError:string;
    num:double;
begin
  strError:='';
  fieldName:=cdsColumn.fieldbyName('FieldName').AsString;
  str:=cdsExcel.fieldByName(cdsColumn.fieldbyName('FileName').AsString).AsString;
  if fieldName='GODS_NAME' then
  begin
    if str='' then
      strError:='��Ʒ����Ϊ��;';
  end;
  if fieldName='BARCODE' then
  begin
    if (isNull) and (str='') then
      strError:='���š�����Ϊ��;'
    else begin
      if FBarcodeType=0 then
        strError:='���벻����;'
      else begin

      end;
    end;
  end;
  if fieldName='GODS_CODE' then
  begin
    if (str='') then
      isNull:=true;
  end;
  if fieldName='UNIT_ID' then
  begin
    if str='' then
      strError:='��λΪ��;';
  end;
  if fieldName='AMOUNT' then
  begin
    try
    if str='' then
      strError:='����Ϊ��;'
    else
      num:=strtofloat(str);
    except
      strError:='��Ч������ֵ;'
    end;
  end;
  if fieldName='APRICE' then
  begin
    try
    if str<>'' then
      num:=strtofloat(str);
    except
      strError:='��Ч�ĵ���ֵ;'
    end;
  end;
  if fieldName='AMONEY' then
  begin
    try
    if str<>'' then
      num:=strtofloat(str);
    except
      strError:='��Ч�Ľ��ֵ;'
    end;
  end;
  if fieldName='AGIO_RATE' then
  begin
    try
    if str<>'' then
      num:=strtofloat(str);
    except
      strError:='��Ч���ۿ�ֵ;'
    end;
  end;
  if fieldName='AGIO_MONEY' then
  begin
    try
    if str<>'' then
      num:=strtofloat(str);
    except
      strError:='��Ч������ֵ;'
    end;
  end;
  if fieldName='REMARK' then
  begin
    
  end;
  if strError<>'' then
  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;

  result:=true;
end;

procedure TfrmOrderExcel.ClearParams;
begin

end;

function TfrmOrderExcel.SelfCheckExcute: Boolean;
var rs:TZQuery;
    strPre,strNext:string;
    fieldBarcode,fieldGodscode,fieldUnit,fieldSort:string;
    preID:integer;
begin
  try
    CreateStringList(barCodeList);
    CreateStringList(godsCodeList);
    CreateStringList(unitList);

    //����
    if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'')  then
        fieldBarcode:=cdsColumn.fieldByName('FileName').AsString;
    //����
    if (cdsColumn.Locate('FieldName','GODS_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
        fieldGodscode:=cdsColumn.fieldByName('FileName').AsString;
    //��λ
    if (cdsColumn.Locate('FieldName','UNIT_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
        fieldUnit:=cdsColumn.fieldByName('FileName').AsString;

    rs:=TZQuery.Create(nil);
    rs.Data:=cdsExcel.Data;
    rs.First;
    while not rs.Eof do
    begin
      if (rs.fieldByName(fieldBarcode).AsString<> '') or
         ((rs.fieldByName(fieldBarcode).AsString='') and
         (rs.fieldbyName(fieldGodscode).AsString<>'')) then
       barCodeList.Add(rs.fieldByName(fieldBarcode).AsString);
      if rs.fieldbyName(fieldGodscode).AsString<>'' then
        godsCodeList.Add(rs.fieldbyName(fieldGodscode).AsString);
      if rs.fieldbyName(fieldUnit).AsString<>'' then
        unitList.Add(rs.fieldbyName(fieldUnit).AsString);
      rs.Next;
    end;

    TransformtoString(barCodeList,FBarcode);
    TransformtoString(godsCodeList,FGoodsCode);
    TransformtoString(unitList,FUnits);

    OutCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmOrderExcel.OutCheckExcute: Boolean;
var rs,ss,cs:TZQuery;
    FieldName,UintField,strCode,strUnit,PriceField,strPrice,strError:string;
    i,j:integer;
begin
  try
    rs:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************����*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      rs.SQL.Text:=
                  'select BARCODE,GODS_ID,BARCODE_TYPE,VM1.UNIT_NAME '+
                  'from VIW_BARCODE VG '+
                  'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.UNIT_ID=VM1.UNIT_ID '+
                  'where VG.tenant_id='+token.tenantId+' and VG.comm not in(''02'',''12'') and VG.barcode in ('+FBarcode+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        FBarcodeType:=1;
        cdsColumn.Locate('FieldName','GODS_CODE',[]);
        strCode:=cdsColumn.fieldByName('FileName').AsString;
        for i:=0 to barcodeList.Count-1 do
        begin
          godscodeList.Clear;
          FGoodsCode:='';
          if not rs.Locate('barcode',barcodeList[i],[]) then
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+barcodeList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              if barcodeList[i]<>'' then
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���벻����;';
                cdsExcel.Post;
              end;
              if ss.fieldByName(strCode).AsString<>'' then
                godscodeList.Add(ss.fieldByName(strCode).AsString);
              ss.Next;
            end;
            ss.Filtered:=false;
            TransformtoString(godscodeList,FGoodsCode);

            CheckGodsCode(cs,ss);
          end else if rs.Locate('barcode',barcodeList[i],[]) then //rs���ܶ�λ��barcode
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+barcodeList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              //��GODS_ID��дCODE��Ϊ������Ψһ���ж�
              cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
              cdsExcel.Edit;
              cdsExcel.FieldByName('CODE').AsString:=rs.fieldbyName('GODS_ID').AsString;
              cdsExcel.Post;
              if (cdsColumn.Locate('FieldName','UNIT_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                UintField:=cdsColumn.fieldByName('FileName').AsString;
                strUnit:=ss.fieldByName(UintField).AsString;
                if strUnit<> '' then
                begin
                  if (not rs.Locate('UNIT_NAME',strUnit,[])) then
                  begin
                      cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                      cdsExcel.Edit;
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øõ�λ;';
                      cdsExcel.Post;
                  end;
                  {
                  else if (rs.Locate('CALC_UNITS_NAME',strUnit,[])) or (rs.Locate('CALC_UNITS_NAME',strUnit,[])) or(rs.Locate('CALC_UNITS_NAME',strUnit,[])) then
                  begin
                    if cdsColumn.Locate('FieldName','APRICE',[]) then
                    begin
                      rs.Locate('barcode',barcodeList[i],[]);
                      PriceField:=cdsColumn.fieldByName('FileName').AsString;
                      strPrice:=ss.fieldByName(PriceField).AsString;
                      if strPrice<>'' then
                      begin
                        cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                        cdsExcel.Edit;
                        if strUnit=rs.FieldByName('CALC_UNITS_NAME').AsString then
                        begin
                          if strPrice<>rs.FieldByName('NEW_OUTPRICE').AsString then
                          begin
                            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�������Ʒ��Ӧ��λ�ĵ��۲�һ��;';
                            cdsExcel.FieldByName('STATE').AsInteger:=2;
                          end;
                        end else if strUnit=rs.FieldByName('SMALL_UNITS_NAME').AsString then
                        begin
                          if strPrice<>rs.FieldByName('NEW_OUTPRICE1').AsString then
                          begin
                            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�������Ʒ��Ӧ��λ�ĵ��۲�һ��;';
                            cdsExcel.FieldByName('STATE').AsInteger:=2;
                          end;
                        end else if strUnit=rs.FieldByName('BIG_UNITS_NAME').AsString then
                        begin
                          if strPrice<>rs.FieldByName('NEW_OUTPRICE2').AsString then
                          begin
                            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�������Ʒ��Ӧ��λ�ĵ��۲�һ��;';
                            cdsExcel.FieldByName('STATE').AsInteger:=2;
                          end;
                        end;
                        cdsExcel.Post;
                      end;
                    end;
                  end;
                  }
                end;
              end;
              ss.Next;
            end;
            ss.Filtered:=false;
          end;
        end;
      end
      else begin
        FBarcodeType:=0;
        CheckGodsCode(cs,ss);
      end;
    end;
  finally
    rs.Free;
    cs.Free;
    ss.Free;
  end;
end;

function TfrmOrderExcel.CheckGodsCode(cs,ss:TZQuery): Boolean;
var strCode,strUnit,UintField:string;
    j:integer;
begin
  //***********************����***********************
  cs.Close;
  cs.SQL.Text:=
              'select distinct GODS_CODE,GODS_ID,VM1.UNIT_NAME CALC_UNITS_NAME,VM2.UNIT_NAME SMALL_UNITS_NAME,VM3.UNIT_NAME BIG_UNITS_NAME '+
              'from VIW_GOODSPRICEEXT VG '+
              'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.CALC_UNITS=VM1.UNIT_ID '+
              'left join VIW_MEAUNITS VM2 on VG.TENANT_ID=VM2.TENANT_ID and VG.SMALL_UNITS=VM2.UNIT_ID '+
              'left join VIW_MEAUNITS VM3 on VG.TENANT_ID=VM3.TENANT_ID and VG.BIG_UNITS=VM3.UNIT_ID '+
              'where VG.tenant_id='+token.tenantId+' and VG.comm not in(''02'',''12'') and VG.GODS_CODE in ('+FGoodsCode+')';
  dataFactory.Open(cs);

  cdsColumn.Locate('FieldName','GODS_CODE',[]);
  strCode:=cdsColumn.fieldByName('FileName').AsString;

  if not cs.IsEmpty then   //ͨ�����Ŷ��ڿ����ҵ�
  begin
    FGodsCodeType:=1;
    for j:=0 to godscodeList.Count-1 do
    begin
      if not cs.Locate('GODS_CODE',godscodeList[j],[]) then
      begin
        ss.Filtered:=false;
        ss.Filter:=strCode+'='''+godscodeList[j]+'''';
        ss.Filtered:=true;
        ss.First;
        while not ss.Eof do
        begin
          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
          cdsExcel.Edit;
          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���Ų�����;';
          cdsExcel.Post;
          ss.Next;
        end;
        ss.Filtered:=false;
      end else
      begin
        ss.Filtered:=false;
        ss.Filter:=strCode+'='''+godscodeList[j]+'''';
        ss.Filtered:=true;
        ss.First;
        while not ss.Eof do
        begin
          //��GODS_ID��дCODE��Ϊ������Ψһ���ж�
          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
          cdsExcel.Edit;
          cdsExcel.FieldByName('CODE').AsString:=cs.fieldbyName('GODS_ID').AsString;
          cdsExcel.Post;
          if (cdsColumn.Locate('FieldName','UNIT_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
          begin
            UintField:=cdsColumn.fieldByName('FileName').AsString;
            strUnit:=ss.fieldByName(UintField).AsString;
            if strUnit<> '' then
            begin
              if (not cs.Locate('CALC_UNITS_NAME',strUnit,[])) and
                 (not cs.Locate('SMALL_UNITS_NAME',strUnit,[])) and
                 (not cs.Locate('BIG_UNITS_NAME',strUnit,[])) then
              begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øõ�λ;';
                  cdsExcel.Post;
              end;
            end;
          end;
          ss.Next;
        end;
        ss.Filtered:=false;
      end;
    end;
  end else
  begin
    for j:=0 to godscodeList.Count-1 do
    begin
      ss.Filtered:=false;
      ss.Filter:=strCode+'='''+godscodeList[j]+'''';
      ss.Filtered:=true;
      ss.First;
      while not ss.Eof do
      begin
        cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
        cdsExcel.Edit;
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���Ų�����;';
        cdsExcel.Post;
        ss.Next;
      end;
      ss.Filtered:=false;
    end
  end;
end;

class function TfrmOrderExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmOrderExcel.Create(Owner) do
    begin
      try
        orderForm:=TfrmOrderForm(Owner);
        RzLabel26.Caption:=RzLabel26.Caption+'--'+orderForm.Caption;
        DataSet:=vDataSet;
        CreateUseDataSet;
        DecodeFields2(Fields);
        //DecodeFormats(Formats);
        SelfCheck:=isSelfCheck;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

function TfrmOrderExcel.CheckExcute: Boolean;
begin
  Inherited CheckExcute;
  {
  cdsExcel.Filtered:=false;
  cdsExcel.Filter:='STATE=''2'' or STATE=''3''';
  cdsExcel.Filtered:=true;
  FPriceCount:=cdsExcel.RecordCount;
  cdsExcel.Filtered:=false;

  RzStatus2.Caption := '�쳣����:'+inttostr(ExceptCount)+'��';
  if FPriceCount>0 then
  RzStatus2.Caption:=RzStatus2.Caption+'(��������е��۲�һ��:'+inttostr(FPriceCount)+'��)';
  RzStatus2.Caption:=RzStatus2.Caption+'    ������:'+inttostr(SumCount)+'��';
  RzStatus2.Update;
  }
end;

procedure TfrmOrderExcel.chkPriceClick(Sender: TObject);
var j:integer;
    str:string;
begin
  inherited;
  {
  cdsExcel.DisableControls;

  cdsExcel.Filtered:=false;
  cdsExcel.Filter:='STATE=''2'' or STATE=''3''';
  cdsExcel.Filtered:=true;
  if cdsExcel.RecordCount>0 then
  begin
    if chkPrice.Checked then
    begin
      cdsExcel.First;
      while not cdsExcel.Eof do
      begin
        cdsExcel.Edit;
        str:=cdsExcel.fieldByName('Msg').asString;
        j:=pos('�������Ʒ��Ӧ��λ�ĵ��۲�һ��;',str);
        if j>=1 then
        cdsExcel.FieldByName('Msg').AsString:=copy(str,1,j-1)+copy(str,j+length('�������Ʒ��Ӧ��λ�ĵ��۲�һ��;'),length(str)-j-length('�������Ʒ��Ӧ��λ�ĵ��۲�һ��;')+1);
        cdsExcel.Post;
        cdsExcel.Next;
      end;
      ExceptCount:=ExceptCount-FPriceCount;
      RzStatus2.Caption := '�쳣����:'+inttostr(ExceptCount)+'��(��������е��۲�һ��:'+inttostr(FPriceCount)+'��)    ������:'+inttostr(SumCount)+'��';
      RzStatus2.Update;
    end else if not chkPrice.Checked then
    begin
      cdsExcel.First;
      while not cdsExcel.Eof do
      begin
        cdsExcel.Edit;
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�������Ʒ��Ӧ��λ�ĵ��۲�һ��;';
        cdsExcel.Post;
        cdsExcel.Next;
      end;
      ExceptCount:=ExceptCount+FPriceCount;
      RzStatus2.Caption := '�쳣����:'+inttostr(ExceptCount)+'��(��������е��۲�һ��:'+inttostr(FPriceCount)+'��)    ������:'+inttostr(SumCount)+'��';
      RzStatus2.Update;
    end;
  end;
  cdsExcel.Filtered:=false;

  cdsExcel.EnableControls;
  }
end;

procedure TfrmOrderExcel.btnNextClick(Sender: TObject);
begin
{
  if rzpage.ActivePageIndex=3 then
  begin
    cdsExcel.EnableControls;
    cdsColumn.EnableControls;

    cdsExcel.Filtered:=false;
    cdsExcel.Filter:='STATE=''2'' or STATE=''3''';
    cdsExcel.Filtered:=true;
    cdsExcel.First;
    while not cdsExcel.Eof do
    begin
      if cdsExcel.FieldByName('Msg').AsString='' then
      begin
        DataSet.Append;
        cdsColumn.First;
        while not cdsColumn.Eof do
        begin
          if cdsColumn.FieldbyName('FieldName').AsString <> '' then
          begin
           if DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).DataType in [ftString,ftWideString,ftFixedChar] then
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := trim(cdsExcel.fieldByName(cdsColumn.FieldbyName('FileName').AsString).AsString)
           else
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := StrtoFloatDef(trim(cdsExcel.fieldByName(cdsColumn.FieldbyName('FileName').AsString).AsString),0);
          end;
          cdsColumn.Next;
        end;
        DataSet.Post;
      end;
      cdsExcel.Next;
    end;

    cdsExcel.Filtered:=false;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
  end;
  }
  inherited;

  {
  if rzPage.ActivePageIndex=3 then
  begin
    if FPriceCount>0 then
    begin
      chkPrice.Visible:=true;
    end else
    begin
      chkPrice.Visible:=false;
      chkignore.Top:=chkignore.Top-11;
    end;
  end
  else
    chkPrice.Visible:=false;
  }
end;

procedure TfrmOrderExcel.RzLabel17Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('�Ƿ�Ҫ������Ʒ���ݵ���ģ�壿'),'������ʾ..',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then exit;
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ���ݵ����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ���ݵ����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), '������ʾ..', MB_OK + MB_ICONQUESTION);
      if cxCheckBox1.Checked then
         fillExecl(SaveDialog1.FileName);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmOrderExcel.IsRequiredFiled(strFiled: string): Boolean;
begin
    result:=false;
  if (strFiled='BARCODE') or (strFiled='GODS_CODE') or
     (strFiled='GODS_NAME') or (strFiled='UNIT_ID') then
    result:=true;
end;

procedure TfrmOrderExcel.fillExecl(FileName: string);
var
  Excel,excelWorkBook,Range: Variant;
  i:integer;
  rs,un:TZQuery;
begin
    RzStatus.Caption := '����д����Ʒ����';
    RzStatus.Update;
    try
      Excel := CreateOleObject('Excel.Application');
    except
      MessageBox(Handle, Pchar('��鿴�Ƿ�װExcelӦ�ó���'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
    try
      excelWorkBook:=Excel.WorkBooks.open(FileName);
      rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
      un := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
      rs.First;
      Range := excelWorkBook.sheets[1].Range[Excel.Cells.Item[4, 1],Excel.Cells.Item[4, 10]];
      for i:=0 to rs.RecordCount-9 do
        begin
          Range.rows.insert;
        end;
      i := 2;
      //������������֮�����Ϊ����
      while not rs.Eof do
      begin
          RzStatus.Caption := 'д��'+rs.FieldbyName('GODS_NAME').asString+'��...';
          RzStatus.Update;
          Excel.Cells.Item[i, 1] := rs.FieldbyName('BARCODE').AsString;
          Excel.Cells.Item[i, 2] := rs.FieldbyName('GODS_CODE').AsString;
          Excel.Cells.Item[i, 3] := rs.FieldbyName('GODS_NAME').AsString;
          if un.Locate('UNIT_ID',rs.FieldbyName('UNIT_ID').AsString,[]) then
             Excel.Cells.Item[i, 4] := un.FieldbyName('UNIT_NAME').AsString;
          Excel.Cells.Item[i, 5] := '';
          Excel.Cells.Item[i, 6] := rs.FieldByName('NEW_INPRICE').AsString;
          Excel.Cells.Item[i, 7] := '';
          inc(i);
          rs.Next;
      end;
      excelWorkBook.save;
      RzStatus.Caption := 'д�����';
      RzStatus.Update;
    finally
      excelWorkBook.close;
      Excel.quit;
    end;
end;
end.
