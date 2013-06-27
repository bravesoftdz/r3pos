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
  Menus;

type
  TfrmOrderExcel = class(TfrmExcelFactory)
    RzLabel14: TRzLabel;
    procedure Image4Click(Sender: TObject);
  private
    FBarcode:widestring;
    FGoodsCode:widestring;
    FUnits:widestring;
    FSorts:widestring;
    FBarcodeType:integer;
    FGodsCodeType:integer; //0 ����û���ļ��еķ��ࣻ1  �������ļ��еĲ�Ϊ�����з��ࣻ2 �����в����ļ��з���
    barCodeList,godsCodeList,unitList,sortList:TStringList;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function CheckGodsCode(cs,ss:TZQuery):Boolean;
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    procedure CreateStringList(var vList:TStringList);
    procedure TransformtoString(vList:TStringList;var vStr:widestring);
    procedure ClearParams;
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
  Result:=false;
  dllGlobal.GetZQueryFromName('PUB_MEAUNITS').Close;
  us:=dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  dllGlobal.GetZQueryFromName('PUB_GOODSINFO').Close;
  gs:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  RecordObj:=TRecord_.Create;
  try
    dsExcel.First;
    while not dsExcel.Eof do
    begin
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

      if gs.Locate('BARCODE',dsExcel.fieldByName('BARCODE').AsString,[]) then
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
    raise;
  end;
  Result := True;
end;

function TfrmOrderExcel.FindColumn(vStr:string):Boolean;
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
  fieldName:=cdsColumn.fieldbyName('FieldName').AsString;
  str:=cdsExcel.Fields[columnIndex].AsString;
  if fieldName='GODS_NAME' then
  begin
    if str='' then
      strError:='��Ʒ����Ϊ��;';
  end;
  if fieldName='BARCODE' then
  begin
    if str='' then
      strError:='����Ϊ��;'
    else begin
      if FBarcodeType=0 then
        strError:='���벻����;'
      else begin

      end;
    end;
  end;
  if fieldName='GODS_CODE' then
  begin
    if str='' then
      strError:='����Ϊ��;';
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
    if str='' then
      strError:='����Ϊ��;'
    else
      num:=strtofloat(str);
    except
      strError:='��Ч�ĵ���ֵ;'
    end;
  end;
  if fieldName='AMONEY' then
  begin
    try
    if str='' then
      strError:='���Ϊ��;'
    else
      num:=strtofloat(str);
    except
      strError:='��Ч�Ľ��ֵ;'
    end;
  end;
  if fieldName='AGIO_RATE' then
  begin
    try
    if str='' then
      strError:='�ۿ�Ϊ��;'
    else
      num:=strtofloat(str);
    except
      strError:='��Ч���ۿ�ֵ;'
    end;
  end;
  if fieldName='AGIO_MONEY' then
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
  if fieldName='REMARK' then
  begin
    
  end;

  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;
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
    if cdsColumn.Locate('FieldName','BARCODE',[]) then
        fieldBarcode:=cdsColumn.fieldByName('FileName').AsString;
    if fieldBarcode='' then
      raise exception.Create('��ѯ���ֶβ����ڣ�');
    //����
    if cdsColumn.Locate('FieldName','GODS_CODE',[]) then
        fieldGodscode:=cdsColumn.fieldByName('FileName').AsString;
    //��λ
    if cdsColumn.Locate('FieldName','UNIT_ID',[]) then
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
    FieldName,UintField,strCode,strUnit,strError:string;
    i,j:integer;
begin
  try
    rs:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************����*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','BARCODE',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      rs.SQL.Text:=
                  'select BARCODE,VM1.UNIT_NAME CALC_UNITS_NAME,VM2.UNIT_NAME SMALL_UNITS_NAME,VM3.UNIT_NAME BIG_UNITS_NAME '+
                  'from VIW_GOODSPRICEEXT VG '+
                  'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.CALC_UNITS=VM1.UNIT_ID '+
                  'left join VIW_MEAUNITS VM2 on VG.TENANT_ID=VM2.TENANT_ID and VG.SMALL_UNITS=VM2.UNIT_ID '+
                  'left join VIW_MEAUNITS VM3 on VG.TENANT_ID=VM3.TENANT_ID and VG.BIG_UNITS=VM3.UNIT_ID '+
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
          end else //rs���ܶ�λ��barcode
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+barcodeList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              if cdsColumn.Locate('FieldName','UNIT_ID',[]) then
              begin
                UintField:=cdsColumn.fieldByName('FileName').AsString;
                strUnit:=ss.fieldByName(UintField).AsString;
                if strUnit<> '' then
                begin
                  if (not rs.Locate('CALC_UNITS_NAME',strUnit,[])) and
                     (not rs.Locate('SMALL_UNITS_NAME',strUnit,[])) and
                     (not rs.Locate('BIG_UNITS_NAME',strUnit,[])) then
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
              'select distinct GODS_CODE,VM1.UNIT_NAME CALC_UNITS_NAME,VM2.UNIT_NAME SMALL_UNITS_NAME,VM3.UNIT_NAME BIG_UNITS_NAME '+
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
          if cdsColumn.Locate('FieldName','UNIT_ID',[]) then
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
        DataSet:=vDataSet;
        CreateUseDataSet;
        DecodeFields(Fields);
        DecodeFormats(Formats);
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
procedure TfrmOrderExcel.CreateStringList(var vList: TStringList);
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

procedure TfrmOrderExcel.TransformtoString(vList: TStringList;var vStr:wideString);
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

procedure TfrmOrderExcel.Image4Click(Sender: TObject);
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ���ݵ����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ���ݵ����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
  end;
end;



end.
