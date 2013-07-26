unit ufrmGoodsExcel;

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
  Menus, RzPrgres;

  const
    FieldCount=20;

type
  TfrmGoodsExcel = class(TfrmExcelFactory)
    procedure RzLabel17Click(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    FSortType:integer; //0 ����û���ļ��еķ��ࣻ1  �������ļ��е����з��ࣻ2 �����в����ļ��з���
    FUnitType:array[0..2] of integer; //ͬFSortType
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function FindColumn2(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    procedure ClearParams;
    function AddUnits:Boolean;
    function IsRequiredFiled(strFiled:string):Boolean;override;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

  const
    FieldsString =
    'BARCODE1=������,GODS_CODE=����,GODS_NAME=��Ʒ����,GODS_SPELL=ƴ����,CALC_UNITS=������λ,SORT_ID1=��Ʒ����,NEW_OUTPRICE=��׼�ۼ�,'+
    'NEW_INPRICE=���½���,NEW_LOWPRICE=����ۼ�,MY_OUTPRICE=�����ۼ�,SORT_ID7=��ɫ��,SORT_ID8=������,SMALL_UNITS=С��װ��λ,SMALLTO_CALC=С��װ����ϵ��,'+
    'BARCODE2=С��װ����,MY_OUTPRICE1=С��װ�����ۼ�,BIG_UNITS=���װ��λ,BIGTO_CALC=���װ����ϵ��,BARCODE3=���װ����,MY_OUTPRICE2=���װ�����ۼ�,SORT_ID3=��Ӧ��';

    FormatString =
    '0=BARCODE1,1=GODS_CODE,2=GODS_NAME,3=GODS_SPELL,4=CALC_UNITS,5=SORT_ID1,6=NEW_OUTPRICE,7=NEW_INPRICE,8=NEW_LOWPRICE,9=MY_OUTPRICE,'+
    '10=SORT_ID7,11=SORT_ID8,12=SMALL_UNITS,13=SMALLTO_CALC,14=BARCODE2,15=MY_OUTPRICE1,16=BIG_UNITS,17=BIGTO_CALC,18=BARCODE3,19=MY_OUTPRICE2,20=SORT_ID3';

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits,ufrmProgressBar;

{$R *.dfm}

procedure TfrmGoodsExcel.CreateUseDataSet;
begin
  inherited; 
  with DataSet.FieldDefs do
    begin
      Add('BARCODE1',ftString,30,False);
      Add('GODS_CODE',ftString,20,False);
      Add('GODS_NAME',ftString,50,False);
      Add('GODS_SPELL',ftString,50,False);
      Add('CALC_UNITS',ftString,36,False);
      Add('SORT_ID1',ftString,36,False);
      Add('NEW_OUTPRICE',ftFloat,0,False);
      Add('NEW_INPRICE',ftFloat,0,False);
      Add('NEW_LOWPRICE',ftFloat,0,False);
      Add('MY_OUTPRICE',ftFloat,0,False);
      Add('SORT_ID7',ftString,36,False);
      Add('SORT_ID8',ftString,36,False);
      Add('SMALL_UNITS',ftString,36,False);
      Add('SMALLTO_CALC',ftFloat,0,False);
      Add('BARCODE2',ftString,30,False);
      Add('MY_OUTPRICE1',ftFloat,0,False);
      Add('BIG_UNITS',ftString,36,False);
      Add('BIGTO_CALC',ftFloat,0,False);
      Add('BARCODE3',ftString,30,False);
      Add('MY_OUTPRICE2',ftFloat,0,False);
      Add('SORT_ID3',ftString,36,False);
    end;
  DataSet.CreateDataSet;
end;

function TfrmGoodsExcel.SaveExcel(dsExcel:TZQuery):Boolean;
procedure WriteToBarcode(Data_Bar:TZQuery;Gods_Id,Unit_Id,BarCode,BarcodeType:String);
  begin
    Data_Bar.Append;
    //Data_Bar.FieldByName('RELATION_FLAG').AsString := '2';
    Data_Bar.FieldByName('TENANT_ID').AsInteger :=strtoint(token.tenantId);
    Data_Bar.FieldByName('GODS_ID').AsString := Gods_Id;
    Data_Bar.FieldByName('ROWS_ID').AsString := TSequence.NewId;  //�к�[GUID���]
    Data_Bar.FieldByName('PROPERTY_01').AsString := '#';
    Data_Bar.FieldByName('PROPERTY_02').AsString := '#';
    Data_Bar.FieldByName('BARCODE_TYPE').AsString := BarcodeType;
    Data_Bar.FieldByName('UNIT_ID').AsString := Unit_Id;
    Data_Bar.FieldByName('BATCH_NO').AsString := '#';
    Data_Bar.FieldByName('BARCODE').AsString := BarCode;
    Data_Bar.Post;
  end;
  procedure WriteToGoodsPrice(Data_Price:TZQuery;Gods_Id:string;OutPrice,OutPrice1,OutPrice2:double);
  begin
    Data_Price.Append;
    Data_Price.FieldByName('TENANT_ID').AsInteger :=strtoint(token.tenantId);
    Data_Price.FieldByName('PRICE_ID').AsString :='#';
    Data_Price.FieldByName('SHOP_ID').AsString:=token.shopId;
    Data_Price.FieldByName('GODS_ID').AsString:=Gods_Id;
    Data_Price.FieldByName('PRICE_METHOD').AsString:='1';
    Data_Price.FieldByName('NEW_OUTPRICE').AsFloat:=OutPrice;
    Data_Price.FieldByName('NEW_OUTPRICE1').AsString:=floattostr(OutPrice1);
    Data_Price.FieldByName('NEW_OUTPRICE2').AsString:=floattostr(OutPrice2);
    Data_Price.Post;
  end;
var DsGoods,DsBarcode,DsGoodsPrice,rs,us,ss,cs:TZQuery;
    GodsId,Bar,Code,Name,Error_Info:String;
    SumBarcode,SumCode,SumName:Integer;
    Params:TftParamList;
    cl,sl:TZQuery;
begin
  if dsExcel.RecordCount=0 then exit;
  ProgressBar1.Visible:=true;
  Result := False;

  DsGoods := TZQuery.Create(nil);
  DsBarcode := TZQuery.Create(nil);
  DsGoodsPrice:=TZQuery.Create(nil);
  cl:=TZQuery.Create(nil);
  sl:=TZQuery.Create(nil);

  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  us:=dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  ss:=dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
  cs:=dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');

  try
    cl.Close;
    cl.SQL.Text:='select COLOR_ID,COLOR_NAME,SORT_ID7S from VIW_COLOR_INFO where tenant_id='+token.tenantId+
                 ' and comm not in(''02'',''12'') ';
    dataFactory.Open(cl);
    sl.Close;
    sl.SQL.Text:='select SIZE_ID,SIZE_NAME,SORT_ID8S from VIW_SIZE_INFO where tenant_id='+token.tenantId+
                 ' and comm not in(''02'',''12'') ';
    dataFactory.Open(sl);

    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').asInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString :=token.shopId;
    Params.ParamByName('GODS_ID').asString :='';
    Params.ParamByName('PRICE_ID').asString :='';
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(DsGoods,'TGoodsInfoV60',Params);
      dataFactory.AddBatch(DsBarcode,'TBarCodeV60',Params);
      dataFactory.AddBatch(DsGoodsPrice,'TGoodsPriceV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

    dsExcel.First;
    while not dsExcel.Eof do
      begin
        ProgressBar1.Percent:=round(dsExcel.RecNo/dsExcel.RecordCount*100);
        ProgressBar1.Update;
        Bar := dsExcel.FieldByName('BARCODE1').AsString;
        Code := dsExcel.FieldByName('GODS_CODE').AsString;
        Name := dsExcel.FieldByName('GODS_NAME').AsString;

        DsGoods.Append;
        GodsId := TSequence.NewId;
        DsGoods.FieldByName('GODS_ID').AsString := GodsId;
        DsGoods.FieldByName('TENANT_ID').AsInteger :=strtoint(token.tenantId);
        //DsGoods.FieldByName('SHOP_ID').AsString :=token.shopId;  
        DsGoods.FieldByName('GODS_CODE').AsString := Code;
        DsGoods.FieldByName('GODS_NAME').AsString := Name;
        DsGoods.FieldByName('GODS_TYPE').AsString :='1';

        if dsExcel.FieldByName('GODS_SPELL').AsString <> '' then
          DsGoods.FieldByName('GODS_SPELL').AsString := dsExcel.FieldByName('GODS_SPELL').AsString
        else
          DsGoods.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(Trim(Name),3);

        if ss.Locate('SORT_NAME',dsExcel.FieldByName('SORT_ID1').AsString,[]) then
          DsGoods.FieldByName('SORT_ID1').AsString := ss.FieldByName('SORT_ID').AsString;
        if cs.Locate('CLIENT_NAME',dsExcel.FieldByName('SORT_ID3').AsString,[]) then
          DsGoods.FieldByName('SORT_ID3').AsString := cs.FieldByName('CLIENT_ID').AsString;
        if cl.Locate('COLOR_NAME',dsExcel.FieldByName('SORT_ID7').AsString,[]) then
          DsGoods.FieldByName('SORT_ID7').AsString :=cl.fieldByName('COLOR_ID').AsString ;
        if sl.Locate('SIZE_NAME',dsExcel.FieldByName('SORT_ID8').AsString,[]) then
          DsGoods.FieldByName('SORT_ID8').AsString := sl.fieldByName('SIZE_ID').AsString;
        if us.Locate('UNIT_NAME',dsExcel.FieldByName('CALC_UNITS').AsString,[]) then
        begin
          DsGoods.FieldByName('UNIT_ID').AsString := us.fieldByName('UNIT_ID').AsString;
          DsGoods.FieldByName('CALC_UNITS').AsString := us.fieldByName('UNIT_ID').AsString;
        end;

        if Bar <> '' then
        begin
          DsGoods.FieldByName('BARCODE').AsString := Bar;
          if us.Locate('UNIT_NAME',dsExcel.FieldByName('CALC_UNITS').AsString,[]) then
          WriteToBarcode(DsBarcode,GodsId,us.fieldByName('UNIT_ID').AsString,dsExcel.FieldByName('BARCODE1').AsString,'0');
        end;

        if dsExcel.FieldByName('BARCODE2').AsString <> '' then
          begin
            if us.Locate('UNIT_NAME',dsExcel.FieldByName('SMALL_UNITS').AsString,[]) then
            DsGoods.FieldByName('SMALL_UNITS').AsString := us.FieldByName('UNIT_ID').AsString;
            DsGoods.FieldByName('SMALLTO_CALC').AsString := dsExcel.FieldByName('SMALLTO_CALC').AsString;
            WriteToBarcode(DsBarcode,GodsId,DsGoods.FieldByName('SMALL_UNITS').AsString,dsExcel.FieldByName('BARCODE2').AsString,'1');
          end;

        if dsExcel.FieldByName('BARCODE3').AsString <> '' then
          begin
            if us.Locate('UNIT_NAME',dsExcel.FieldByName('BIG_UNITS').AsString,[]) then
            DsGoods.FieldByName('BIG_UNITS').AsString := us.FieldByName('UNIT_ID').AsString;
            DsGoods.FieldByName('BIGTO_CALC').AsString := dsExcel.FieldByName('BIGTO_CALC').AsString;
            WriteToBarcode(DsBarcode,GodsId,DsGoods.FieldByName('BIG_UNITS').AsString,dsExcel.FieldByName('BARCODE3').AsString,'2');
          end;

        DsGoods.FieldByName('NEW_INPRICE').AsFloat := dsExcel.FieldByName('NEW_INPRICE').AsFloat;
        DsGoods.FieldByName('NEW_OUTPRICE').AsFloat := dsExcel.FieldByName('NEW_OUTPRICE').AsFloat;
        DsGoods.FieldByName('NEW_LOWPRICE').AsFloat := dsExcel.FieldByName('NEW_LOWPRICE').AsFloat;
        if dsExcel.FieldByName('MY_OUTPRICE').AsString<>'' then
        begin
          WriteToGoodsPrice(DsGoodsPrice,GodsId,dsExcel.FieldByName('MY_OUTPRICE').AsFloat,dsExcel.FieldByName('MY_OUTPRICE1').AsFloat,dsExcel.FieldByName('MY_OUTPRICE2').AsFloat);
        end;

        DsGoods.FieldByName('USING_PRICE').AsInteger := 1;
        DsGoods.FieldByName('HAS_INTEGRAL').AsInteger := 1;
        DsGoods.FieldByName('USING_BATCH_NO').AsInteger := 2;
        DsGoods.FieldByName('USING_BARTER').AsInteger := 1;
        DsGoods.FieldByName('USING_LOCUS_NO').AsInteger := 2;
        DsGoods.FieldByName('BARTER_INTEGRAL').AsInteger := 0;

        DsGoods.Post;
        dsExcel.Next;
      end;

      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(DsGoods,'TGoodsInfoV60',nil);
        dataFactory.AddBatch(DsBarcode,'TBarCodeV60',nil);
        dataFactory.AddBatch(DsGoodsPrice,'TGoodsPriceV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        ProgressBar1.Visible:=false;
        Raise;
      end;

  finally
    DsGoods.Free;
    DsBarcode.Free;
    DsGoodsPrice.Free;
    sl.Free;
    cl.Free;
    Params.Free;
    ProgressBar1.Visible:=false;
  end;
  Result := True;
end;

function TfrmGoodsExcel.FindColumn(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if not cdsColumn.Locate('FieldName','BARCODE1',[]) then
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
  if not cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������λ'
    else
    strError:='������λ';
  end;
  if not cdsColumn.Locate('FieldName','SORT_ID1',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��Ʒ����'
    else
    strError:='��Ʒ����';
  end;
  if not cdsColumn.Locate('FieldName','NEW_OUTPRICE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��׼�ۼ�'
    else
    strError:='��׼�ۼ�';
  end;
  if not cdsColumn.Locate('FieldName','NEW_INPRICE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'���½���'
    else
    strError:='���½���';
  end;
  if not cdsColumn.Locate('FieldName','MY_OUTPRICE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'�����ۼ�'
    else
    strError:='�����ۼ�';
  end;
  
  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('ȱ��'+strError+'�ֶζ�Ӧ��ϵ�������Ӧ��ϵ���û����ļ���');
  end;
end;

function TfrmGoodsExcel.FindColumn2(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if (cdsColumn.Locate('FieldName','BARCODE1',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
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
  if (cdsColumn.Locate('FieldName','CALC_UNITS',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������λ'
    else
    strError:='������λ';
  end;
  if (cdsColumn.Locate('FieldName','SORT_ID1',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��Ʒ����'
    else
    strError:='��Ʒ����';
  end;
  if (cdsColumn.Locate('FieldName','NEW_OUTPRICE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'��׼�ۼ�'
    else
    strError:='��׼�ۼ�';
  end;
  if (cdsColumn.Locate('FieldName','NEW_INPRICE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'���½���'
    else
    strError:='���½���';
  end;
  if (cdsColumn.Locate('FieldName','MY_OUTPRICE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'�����ۼ�'
    else
    strError:='�����ۼ�';
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('ȱ��'+strError+'�ֶζ�Ӧ��ϵ�������Ӧ��ϵ���û����ļ���');
  end;
end;

procedure TfrmGoodsExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmGoodsExcel.Check(columnIndex:integer): Boolean;
var str,strError,fieldName:string;
    num:double;
begin
  strError:='';
  fieldName:=cdsColumn.FieldByName('FileName').AsString;
  str:=cdsExcel.fieldByName(fieldName).AsString;
  case columnIndex of
    0:begin
         if str='' then
         strError:='������Ϊ��;';
       end;
    1:begin
         if str='' then
         strError:='����Ϊ��;';
       end;
    2:begin
       if str='' then
         strError:='��Ʒ����Ϊ��;';
      end;
    3:begin
       if str='' then
         strError:='ƴ����Ϊ��;';
      end;
    4:begin
        if str='' then
          strError:='������λΪ��;'
        else begin
          if FUnitType[0]=0 then
            strError:='������λ������;';
        end;
      end;
    5:begin
        if str='' then
          strError:='��Ʒ����Ϊ��;'
        else begin
          if FSortType=0 then
            strError:='��Ʒ���಻����;';
        end;
      end;
    6:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='��׼�ۼ�Ϊ��;';
         except
          strError:='��Ч�ı�׼�ۼ�;'
        end;
      end;
    7:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='���½���Ϊ��;';
        except
          strError:='��Ч�����½���;'
        end;
      end;
    8:begin
        try
          if str<>'' then
            num:=strtofloat(str);
        except
          strError:='��Ч������ۼ�;'
        end;
      end;
    9:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='�����ۼ�Ϊ��;';
        except
          strError:='��Ч�ı����ۼ�;'
        end;
      end;
    10:begin     //Color
      end;
    11:begin    //size
      end;
    12:begin
         if str='' then
          //strError:='С��װ��λΪ��;'
        else begin
          if FUnitType[1]=0 then
            strError:='С��װ��λ������;';
        end;
      end;
    13:begin
        try
          if str<>''then
            num:=strtofloat(str);
        except
          strError:='��Ч��С��װ����ϵ��;'
        end;
      end;
    14:begin
        // if str='' then
        // strError:='С��װ������Ϊ��;';
      end;
    15:begin
        try
          if str<> '' then
            num:=strtofloat(str);
        except
          strError:='��Ч��С��װ�����ۼ�;'
        end;
      end;
    16:begin
         if str='' then
          //strError:='���װ��λΪ��;'
        else begin
          if FUnitType[2]=0 then
            strError:='���װ��λ������;';
        end;
      end;
    17:begin
        try
          if str<> '' then
            num:=strtofloat(str);
        except
          strError:='��Ч�Ĵ��װ����ϵ��;'
        end;
      end;
    18:begin
        //if str='' then
        // strError:='���װ������Ϊ��;';
      end;
    19:begin
        try
          if str<> '' then
           num:=strtofloat(str);
        except
          strError:='��Ч�Ĵ��װ�����ۼ�;'
        end;
      end;
    20:begin
        if str='' then
         //strError:='��Ӧ��Ϊ��;'
        else begin
          if FieldType[20]=0 then
            strError:='��Ӧ�̲�����;';
        end;
      end;
  end;
  if strError<>'' then
  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;

  result:=true;
end;

procedure TfrmGoodsExcel.ClearParams;
var i:integer;
begin
  for i:=0 to FieldCount do
    FieldCheckSet[i]:='';
end; 

function TfrmGoodsExcel.SelfCheckExcute: Boolean;
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
      FileName:=cdsColumn.fieldByName('FileName').AsString;
      if (fieldName<>'') and (FileName <> '') then
      begin
        if (fieldName='BARCODE1') or (fieldName='BARCODE2') or
           (fieldName='BARCODE3') or (fieldName='GODS_CODE') or
           (fieldName='CALC_UNITS') or (fieldName='SMALL_UNITS') or
           (fieldName='BIG_UNITS') or (fieldName='SORT_ID1') or
           (fieldName='SORT_ID3') then
        begin
          if (fieldName='BARCODE1') or (fieldName='BARCODE2') or
             (fieldName='BARCODE3') or (fieldName='GODS_CODE') then
          begin
            isSort:=true;
            rs.SortedFields:=cdsColumn.fieldByName('FileName').AsString;
          end;

          if isSort then
          begin
            rs.First;
            strPre:=trim(rs.fieldByName(FileName).AsString);
            preId:=rs.fieldByName('ID').AsInteger;
            //if strPre<>'' then
            TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strPre);
            rs.Next;
            while not rs.Eof do
            begin
              strNext:=trim(rs.fieldByName(FileName).AsString);
              if (strPre<>'') and (strPre=strNext) then        //�ǿ����ʱ�����ظ��ж�
              begin
                cdsExcel.Locate('ID',rs.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(preId)+'������'+cdsColumn.fieldByName('DestTitle').asstring+'�ظ�;';
                cdsExcel.Post;
              end
              else if strPre<>strNext then
              begin
                strPre:=strNext;
                preID:=rs.fieldByName('ID').AsInteger;
              end;
              //if strNext<>'' then
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strNext);
              rs.Next;
            end;
          end else
          begin
            rs.First;
            while not rs.Eof do
            begin
              strNext:=trim(rs.fieldByName(FileName).AsString);
              if strNext<> '' then
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strNext);
              rs.Next;
            end;
          end;
        end;
      end;
      cdsColumn.Next;
    end;
    AddUnits;
    OutCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmGoodsExcel.OutCheckExcute: Boolean;
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

    //*********************����*****************************
    for c:=0 to 2 do
    begin
      if c=0 then
        tempField:='BARCODE1'
      else if c=1 then
        tempField:='BARCODE2'
      else if c=2 then
        tempField:='BARCODE3';

      FieldName:='';
      if (cdsColumn.Locate('FieldName',tempField,[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
      begin
        FieldName:=cdsColumn.fieldByName('FileName').AsString;
        strWhere:=DeleteDuplicateString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strList);
        rs.SQL.Text:='select distinct barcode from VIW_BARCODE where tenant_id='+token.tenantId+' and barcode_type='''+inttostr(c)+''' and comm not in(''02'',''12'') and barcode in ('+strWhere+')';
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
    end;

    //*********************����*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','GODS_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      strWhere:=DeleteDuplicateString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strList);
      rs.Close;
      rs.SQL.Text:='select distinct GODS_CODE from VIW_GOODSPRICEEXT where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and GODS_CODE in ('+strWhere+')';
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
            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�����Ѵ���;';
            cdsExcel.Post;
            ss.Next;
          end;
          ss.Filtered:=false;
          rs.Next;
        end;
      end;
    end;

    //*********************��λ*****************************
    for c:=0 to 2 do
    begin
      if c=0 then
        tempField:='CALC_UNITS'
      else if c=1 then
        tempField:='SMALL_UNITS'
      else if c=2 then
        tempField:='BIG_UNITS';

      FieldName:='';
      if (cdsColumn.Locate('FieldName',tempField,[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
      begin
        FieldName:=cdsColumn.fieldByName('FileName').AsString;
        strWhere:=DeleteDuplicateString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strList);
        rs.Close;
        rs.SQL.Text:='select distinct UNIT_NAME from VIW_MEAUNITS where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and UNIT_NAME in ('+strWhere+')';
        dataFactory.Open(rs);
        if not rs.IsEmpty then
        begin
          if rs.RecordCount=strList.Count then
          begin
            FUnitType[c]:=1;
          end
          else if rs.RecordCount<strList.Count then
          begin
            FUnitType[c]:=2;
            for i:=0 to strList.Count-1 do
            begin
              if not rs.Locate('UNIT_NAME',strList[i],[]) then
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
          end;
        end
        else
          FUnitType[c]:=0;
      end;
    end; 

    //*********************��Ʒ����*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','SORT_ID1',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      strWhere:=DeleteDuplicateString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strList);
      rs.Close;
      rs.SQL.Text:='select distinct SORT_NAME from VIW_GOODSSORT where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and SORT_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //���еķ��඼�ڿ���
        begin
          FSortType:=1;
        end
        else if rs.RecordCount<strList.Count then  //���ַ����ڿ���
        begin
          FSortType:=2;
          for i:=0 to strList.Count-1 do
          begin
            if not rs.Locate('SORT_NAME',strList[i],[]) then
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
        FSortType:=0;
    end;

    //*********************��Ӧ��*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','SORT_ID3',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select distinct CLIENT_NAME from VIW_CLIENTINFO where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and CLIENT_NAME in ('+strWhere+')';
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
            if not rs.Locate('CLIENT_NAME',strList[i],[]) then
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

    //*********************��ɫ������*****************************

  finally
    rs.Free;
    ss.Free;
  end;
end;

class function TfrmGoodsExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmGoodsExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--��Ʒ����';
        DataSet:=vDataSet;
        CreateUseDataSet;
        DecodeFields2(FieldsString);
        //DecodeFormats(FormatString);
        SelfCheck:=isSelfCheck;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsExcel.RzLabel17Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('�Ƿ�Ҫ������Ʒ����ģ�壿'),'������ʾ..',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then exit;
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ��Ϣ�����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ��Ϣ�����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'),'������ʾ..', MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmGoodsExcel.AddUnits: Boolean;
  function GetSeqNo(tenantId:string):integer;
  var rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select MAX(SEQ_NO) from PUB_MEAUNITS where TENANT_ID='+tenantId;
      dataFactory.Open(rs);
      if rs.Fields[0].AsString = '' then
         result := 1
      else
         result := rs.Fields[0].AsInteger + 1;
    finally
      rs.Free;
    end;
  end;
var unitField,tempField,strWhere,strUnits:string;
    unitList,tmpList:TStringlist;
    c,i:integer;
    rs,cdsUnits,tmpUnits:TZQuery;
    Params:TftParamList;
    tmpObj:TRecord_;
begin
  result:=false;
  try
    rs:=TZQuery.Create(nil);
    CreateStringList(unitList);
    tmpList:=TStringList.Create;

    //������λ��С��װ��λ�����װ��λ
    for c:=0 to 2 do
    begin
      if c=0 then
        tempField:='CALC_UNITS'
      else if c=1 then
        tempField:='SMALL_UNITS'
      else if c=2 then
        tempField:='BIG_UNITS';

      unitField:='';
      if (cdsColumn.Locate('FieldName',tempField,[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
      begin
        tmpList.CommaText:=FieldCheckSet[cdsColumn.fieldByName('ID').asInteger];
        for i:=0 to tmpList.Count-1 do
        begin
          if tmpList[i]<>'' then
            unitList.Add(tmpList[i]);
        end;
      end;
    end;

    //����������ڼ���
    for i:=0 to unitList.Count-1 do
    begin
      if strWhere='' then
        strWhere:=''''+unitList[i]+''''
      else
      strWhere:=strWhere+','+''''+unitList[i]+'''';
    end;

    if unitList.Count>0 then
    begin
      rs.Close;
      rs.SQL.Text:='select distinct UNIT_NAME from VIW_MEAUNITS where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and UNIT_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if (rs.IsEmpty) then
      begin
        strUnits:=unitList.Text;
      end else
      begin
        for i:=0 to unitList.Count-1 do
        begin
          if not rs.Locate('UNIT_NAME',unitList[i],[]) then
          begin
            if strUnits='' then
              strUnits:=unitList[i]
            else
              strunits:=strUnits+','+unitList[i];
          end;
        end;
      end;
    end;

    if strUnits<>'' then
    begin
      try
        if MessageBox(Handle,pchar('������ϵͳ��û�����µ�λ��'+strUnits+'���Ƿ��룿'),'������ʾ',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)=6 then
        begin
          tmpList.Clear;
          tmpList.CommaText:=strUnits;

          cdsUnits:=TZQuery.Create(nil);
          Params := TftParamList.Create(nil);
          cdsUnits.Close;
          try
            Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            Params.ParamByName('UNIT_ID').AsString := '';
            dataFactory.Open(cdsUnits,'TMeaUnitsV60',Params);
          finally
            Params.Free;
          end;

          for i:=0 to tmpList.Count-1 do
          begin
            cdsUnits.Append;
            cdsUnits.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            cdsUnits.FieldByName('UNIT_ID').AsString := TSequence.NewId;
            cdsUnits.FieldByName('SEQ_NO').AsInteger := GetSeqNo(token.tenantId)+i;
            cdsUnits.FieldByName('UNIT_NAME').AsString := trim(tmpList[i]);
            cdsUnits.FieldByName('UNIT_SPELL').AsString := fnString.GetWordSpell(tmpList[i],3);
            cdsUnits.Post;
          end;

          dataFactory.BeginBatch;
          try
            dataFactory.AddBatch(cdsUnits,'TMeaUnitsV60');
            dataFactory.CommitBatch;
          except
            dataFactory.CancelBatch;
            Raise;
          end;
        end;

        // ���ر���
        if dataFactory.iDbType <> 5 then
        begin
           dataFactory.MoveToSqlite;
           tmpUnits := TZQuery.Create(nil);
           Params := TftParamList.Create(nil);
           tmpObj := TRecord_.Create;
           try
             cdsUnits.First;
             while not cdsUnits.Eof do
             begin
               Params.ParamByName('TENANT_ID').AsInteger := cdsUnits.FieldByName('TENANT_ID').AsInteger;
               Params.ParamByName('UNIT_ID').AsString := cdsUnits.FieldByName('UNIT_ID').AsString;
               dataFactory.Open(tmpUnits,'TMeaUnitsV60',Params);

               if tmpUnits.IsEmpty then tmpUnits.Append else tmpUnits.Edit;

               tmpObj.ReadFromDataSet(cdsUnits);
               tmpObj.WriteToDataSet(tmpUnits);
               cdsUnits.Next;
             end;

             dataFactory.BeginBatch;
             try
              dataFactory.AddBatch(tmpUnits,'TMeaUnitsV60');
              dataFactory.CommitBatch;
             except
              dataFactory.CancelBatch;
              Raise;
             end;
           finally
             dataFactory.MoveToDefault;
             tmpUnits.Free;
             Params.Free;
             tmpObj.Free;
           end;
        end;
      finally
        cdsUnits.Free;
      end;
      dllGlobal.Refresh('PUB_MEAUNITS');
    end;

  finally
    rs.Free;
    unitList.Free;
    tmpList.Free;
  end;
  result:=true;
end;

function TfrmGoodsExcel.IsRequiredFiled(strFiled:string):Boolean;
begin
  result:=false;
  if (strFiled='BARCODE1') or (strFiled='GODS_CODE') or (strFiled='GODS_NAME') or
     (strFiled='CALC_UNITS') or (strFiled='SORT_ID1') or (strFiled='NEW_OUTPRICE') or
     (strFiled='NEW_INPRICE') or (strFiled='MY_OUTPRICE')then
    result:=true;

end;

end.
