unit ufrmPriceExcel;

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
    FieldCount=20;

type
  TPriceGrade=class
  public
      priceId:string;
      priceName:string;
      PriceField:string;
      priceIndex:integer;
  end;

  TfrmPriceExcel = class(TfrmExcelFactory)
    procedure RzLabel17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    FPriceCount:integer;
    ValidPriceIdList:TStringList;
    FieldsString,FormatString:string;

    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function FindColumn2(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function OutCheckExcute2:Boolean;
    function CheckGodsCode(ss:TZQuery;strList:TStringList;codeField:string;index:integer): Boolean;
    function DuplicateCheckExcute: Boolean;
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    procedure ClearParams;
    function ReWriteExcelTemplate(rs:TZQuery):Boolean;
    function ConfirmPriceGrade:Boolean;
    function IsRequiredFiled(strFiled:string):Boolean;override;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmPriceExcel.CreateUseDataSet;
var rs:TZQuery;
    str,str1,FileName:string;
    i,excelRow,excelCol:integer;
begin
  try
  rs:=dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  {
  if rs.RecordCount=0 then
  begin
     MessageBox(Handle, Pchar('����ҵ�»�û�����û�Ա�ȼ��������ú��ٵ������ݣ�'), '������ʾ..', MB_OK + MB_ICONQUESTION);
     ModalResult:=MrCancel;
  end;
  }
  FieldsString :=
    'BARCODE=������,GODS_CODE=����,GODS_NAME=��Ʒ����,NEW_OUTPRICE=�����ۼ�,NEW_OUTPRICE1=�����ۼ�-С��װ,NEW_OUTPRICE2=�����ۼ�-���װ';
  FormatString :=
    '0=BARCODE,1=GODS_CODE,2=GODS_NAME,3=NEW_OUTPRICE,4=NEW_OUTPRICE1,5=NEW_OUTPRICE2';
  FPriceCount:=0;
  i:=0;
  with DataSet.FieldDefs do
    begin
      Add('BARCODE',ftString,30,False);
      Add('GODS_CODE',ftString,20,False);
      Add('GODS_NAME',ftString,50,False);
      Add('NEW_OUTPRICE',ftFloat,0,False);
      Add('NEW_OUTPRICE1',ftFloat,0,False);
      Add('NEW_OUTPRICE2',ftFloat,0,False);
      rs.First;
      while not rs.Eof do
      begin
        inc(FPriceCount);
        str:=rs.fieldByName('PRICE_NAME').AsString;
        str1:='PRICE_ID'+inttostr(FPriceCount)+'_OUTPRICE';

        FieldsString:=FieldsString+','+str1+'='+str+'-�ۼ�';
        FieldsString:=FieldsString+','+str1+'1='+str+'-С��װ�ۼ�';
        FieldsString:=FieldsString+','+str1+'2='+str+'-���װ�ۼ�';
        FormatString:=FormatString+','+inttostr(6+i*3)+'='+str1;
        FormatString:=FormatString+','+inttostr(7+i*3)+'='+str1+'1';
        FormatString:=FormatString+','+inttostr(8+i*3)+'='+str1+'2';
        inc(i);
        
        Add(str1,ftFloat,0,False);
        Add(str1+'1',ftFloat,0,False);
        Add(str1+'2',ftFloat,0,False);
        rs.Next;
      end;
    end;
  DataSet.CreateDataSet;
  if rs.RecordCount>0 then
    ReWriteExcelTemplate(rs);
  finally
    //rs.Free;
  end;
end;

function TfrmPriceExcel.ReWriteExcelTemplate(rs:TZQuery): Boolean;
var Excel,excelWorkBook,excelWksheet: Variant;
    i,excelRow,excelCol:integer;
    str,FileName:string;
begin
  FileName:=ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����_.xls';
  if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls') then
   CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls'),pchar(FileName),false)
  else
    Raise Exception.Create('��鿴�Ƿ���ڸ�ģ�壡');;
  try
    Excel := CreateOleObject('Excel.Application');
  except
    Raise Exception.Create('��鿴�Ƿ�װExcelӦ�ó���');
  end;
  try
    try
      excelWorkBook:=Excel.WorkBooks.open(FileName);
      Excel.Visible := false;
      excelWksheet:=excelWorkBook.WorkSheets[1];
      excelRow:=excelWksheet.UsedRange.Rows.Count;
      excelCol:=excelWksheet.UsedRange.Columns.Count;
      rs.First;
      i:=0;
      while not rs.Eof do
      begin
        str:=rs.fieldByName('PRICE_NAME').AsString;
        excelWksheet.Cells.item[1,excelCol+1+i*3]:=str+'-�ۼ�';
        excelWksheet.Cells.item[1,excelCol+1+i*3].font.color:=clRed;
        excelWksheet.Cells.item[1,excelCol+2+i*3]:=str+'-С��װ�ۼ�';
        excelWksheet.Cells.item[1,excelCol+3+i*3]:=str+'-���װ�ۼ�';
        inc(i);
        rs.Next;
      end;
      //�Զ������п�
      //excelWksheet.Columns.AutoFit;
      //����ʾ������ʾ��Ĭ����ʾ
      Excel.DisplayAlerts:=false;
      Excel.Save;
    except
      raise;
    end;
  finally
    excelWorkBook.close;
    Excel.quit;
  end;
end;

function TfrmPriceExcel.SaveExcel(dsExcel:TZQuery):Boolean;
var Params: TftParamList;
    priceList,rs,gs,ps:TZQuery;
    Field:TField;
    godsId,str:string;
    i:integer;
    priceGrade:TPriceGrade;
begin
  try
    priceList:=TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    gs:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    ps:=dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');

    try
      priceList.Close;
      priceList.SQL.Text:='select TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP '+
                   'from   PUB_GOODSPRICE '+
                   'where tenant_id='+token.tenantId+' and SHOP_ID in('''+token.shopId+''','''+token.tenantId+'0001'+''') and comm not in(''02'',''12'') ';
      dataFactory.Open(priceList);
    except
      raise;
    end;

    dsExcel.First;
    while not dsExcel.Eof do
    begin
      Field:=dsExcel.FindField('BARCODE');
      if (Field <> nil) and (dsExcel.FieldByName('BARCODE').AsString<> '') then
      begin
        if gs.Locate('BARCODE',dsExcel.FieldByName('BARCODE').AsString,[]) then
        begin
          godsId:=gs.fieldByName('GODS_ID').AsString;
        end;
      end;

      //��ͨ��Ա��
      if priceList.Locate('PRICE_ID;SHOP_ID;GODS_ID',VarArrayof(['#',token.shopId,godsId]),[]) then
      begin
        priceList.Edit;
      end
      else begin
        priceList.Append;
        priceList.FieldByName('TENANT_ID').AsString:=token.tenantId;
        priceList.FieldByName('SHOP_ID').AsString:=token.shopId;
        priceList.FieldByName('PRICE_METHOD').AsString:='1';
        priceList.FieldByName('PRICE_ID').AsString:='#';
       priceList.FieldByName('GODS_ID').AsString:=godsId;
      end;
      gs.Locate('GODS_ID',godsId,[]);
      Field:=dsExcel.FindField('NEW_OUTPRICE');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE').AsString<> '0') then
      begin
        priceList.FieldByName('NEW_OUTPRICE').AsFloat:=dsExcel.FieldByName('NEW_OUTPRICE').AsFloat;
      end;

      Field:=dsExcel.FindField('NEW_OUTPRICE1');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE1').AsString<> '0') then
      begin
        priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=dsExcel.FieldByName('NEW_OUTPRICE1').AsFloat;
      end
      else if (dsExcel.FieldByName('NEW_OUTPRICE1').AsString='0') then
      begin
        if (gs.FieldByName('SMALL_UNITS').AsString<>'') and (gs.FieldByName('SMALLTO_CALC').AsString<>'') then
          priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=priceList.FieldByName('NEW_OUTPRICE').AsFloat* gs.fieldByName('SMALLTO_CALC').AsFloat
        else
          priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=0;
      end;

      Field:=dsExcel.FindField('NEW_OUTPRICE2');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE2').AsString<> '0') then
      begin
        priceList.FieldByName('NEW_OUTPRICE2').AsString:=dsExcel.FieldByName('NEW_OUTPRICE2').AsString;
      end;
      if (dsExcel.FieldByName('NEW_OUTPRICE2').AsString='0') then
      begin
        if (gs.FieldByName('BIG_UNITS').AsString<>'') and (gs.FieldByName('BIGTO_CALC').AsString<>'') then
          priceList.FieldByName('NEW_OUTPRICE2').AsFloat:=priceList.FieldByName('NEW_OUTPRICE').AsFloat* gs.fieldByName('BIGTO_CALC').AsFloat
        else
          priceList.FieldByName('NEW_OUTPRICE2').AsFloat:=0;
      end;
      priceList.Post;

      //������Ա��
      for i:=0 to ValidPriceIdList.Count-1 do
      begin
        priceGrade:=TPriceGrade(ValidPriceIdList.Objects[i]);
        if priceList.Locate('PRICE_ID;SHOP_ID;GODS_ID',VarArrayof([priceGrade.priceId,token.shopId,godsId]),[]) then
        begin
          priceList.Edit;
        end
        else begin
          priceList.Append;
          priceList.FieldByName('TENANT_ID').AsString:=token.tenantId;
          priceList.FieldByName('SHOP_ID').AsString:=token.shopId;
          priceList.FieldByName('PRICE_METHOD').AsString:='1';
          priceList.FieldByName('PRICE_ID').AsString:=priceGrade.priceId;
          priceList.FieldByName('GODS_ID').AsString:=godsId;
        end;

        gs.Locate('GODS_ID',godsId,[]);

        str:='PRICE_ID'+inttostr(i+1)+'_OUTPRICE';
        Field:=dsExcel.FindField('NEW_OUTPRICE');
        if (Field <> nil) and (dsExcel.FieldByName(str).AsString<> '0') then
        begin
          priceList.FieldByName('NEW_OUTPRICE').AsFloat:=dsExcel.FieldByName(str).AsFloat;
        end;

        Field:=dsExcel.FindField('NEW_OUTPRICE1');
        if (Field <> nil) and (dsExcel.FieldByName(str+'1').AsString<> '0') then
        begin
          priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=dsExcel.FieldByName(str+'1').AsFloat;
        end
        else if (dsExcel.FieldByName(str+'1').AsString='0') then
        begin
          if (gs.FieldByName('SMALL_UNITS').AsString<>'') and (gs.FieldByName('SMALLTO_CALC').AsString<>'') then
            priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=priceList.FieldByName('NEW_OUTPRICE').AsFloat* gs.fieldByName('SMALLTO_CALC').AsFloat
          else
            priceList.FieldByName('NEW_OUTPRICE1').AsFloat:=0;
        end;

        Field:=dsExcel.FindField('NEW_OUTPRICE2');
        if (Field <> nil) and (dsExcel.FieldByName(str+'2').AsString<> '0') then
        begin
          priceList.FieldByName('NEW_OUTPRICE2').AsFloat:=dsExcel.FieldByName(str+'2').AsFloat;
        end;
        if (dsExcel.FieldByName(str+'2').AsString='0') then
        begin
          if (gs.FieldByName('BIG_UNITS').AsString<>'') and (gs.FieldByName('BIGTO_CALC').AsString<>'') then
            priceList.FieldByName('NEW_OUTPRICE2').AsFloat:=priceList.FieldByName('NEW_OUTPRICE').AsFloat* gs.fieldByName('BIGTO_CALC').AsFloat
          else
            priceList.FieldByName('NEW_OUTPRICE2').AsFloat:=0;
        end;
        priceList.Post;
      end;

      dsExcel.Next;
    end;

    try
      dataFactory.UpdateBatch(priceList,'TGoodsPriceV60');
    except
      Raise;
    end;

  finally
    Params.Free;
    priceList.Free;
  end;

  Result := True;
end;

function TfrmPriceExcel.FindColumn(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if not cdsColumn.Locate('FieldName','BARCODE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������'
    else
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
  if not cdsColumn.Locate('FieldName','NEW_OUTPRICE',[]) then
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

function TfrmPriceExcel.FindColumn2(vStr: string): Boolean;
var strError:string;
    i:integer;
    priceGrade:TPriceGrade;
begin
   Result := True;
   strError:='';
  if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������'
    else
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
  if (cdsColumn.Locate('FieldName','NEW_OUTPRICE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'�����ۼ�'
    else
    strError:='�����ۼ�';
  end;

  for i:=0 to ValidPriceIdList.Count-1 do
  begin
    priceGrade:=TPriceGrade(ValidPriceIdList.Objects[i]);
    cdsColumn.Locate('FieldName',priceGrade.priceField,[]);
    if cdsColumn.FieldByName('FileName').AsString='' then
    begin
      Result := False;
      if strError<>'' then
        strError:=strError+'��'+priceGrade.priceName+'-�ۼ�'
      else
       strError:=priceGrade.priceName+'-�ۼ�';
    end;
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('ȱ��'+strError+'�ֶζ�Ӧ��ϵ�������Ӧ��ϵ���û����ļ���');
  end;

end;

procedure TfrmPriceExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmPriceExcel.Check(columnIndex:integer): Boolean;
var str,strError,fieldName,fileTitle,priceName,strtmp:string;
    num:double;
    rs:TZQuery;
begin
  strError:='';
  fieldName:=cdsColumn.FieldByName('FileName').AsString;      
  str:=cdsExcel.fieldByName(fieldName).AsString;
  case columnIndex of
    0:begin
      if str='' then
        isNull:=true
      else if FieldType[0]=0 then
      begin
        strError:='�����벻����;'
      end;
    end;
    1:begin
      if (isNull) and (str='') then
        strError:='�����롢����Ϊ��;';
    end;
    2:begin   //��Ʒ����

    end;

    3:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='�����ۼ�Ϊ��;';
         except
          strError:='��Ч�ı����ۼ�;'
        end;
    end;
    else begin
      rs:=dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
      fileTitle:=cdsColumn.FieldByName('FileTitle').AsString;
      if copy(fileTitle,length(fileTitle)-length('-�ۼ�')+1,length('-�ۼ�'))='-�ۼ�' then
      begin
        priceName:=copy(fileTitle,1,length(fileTitle)-length('-�ۼ�'));
        if rs.Locate('PRICE_NAME',priceName,[]) then
        begin
          try
            if str<>'' then
              num:=strtofloat(str)
            else
              strError:=fileTitle+'Ϊ��;';
          except
            strError:='��Ч��'+fileTitle+';'
          end;
        end
        else begin
          strError:='��Ч�Ļ�Ա�ȼ�����:'+priceName+';';
        end;
      end;
      {
      if rs.RecordCount>0 then
      begin
        rs.first;
        while not rs.Eof do
        begin
          if rs.FieldByName('PRICE_NAME').AsString+'-�ۼ�'=fileTitle then
          begin
            try
              if str<>'' then
                num:=strtofloat(str)
              else
                strError:=fileTitle+'Ϊ��;';
             except
              strError:='��Ч��'+fileTitle+';'
            end;
          end;
          rs.Next;
        end;
      end;
      }
    end;

  end;

  if strError<>'' then
  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;

  result:=true;
end;

procedure TfrmPriceExcel.ClearParams;
var i:integer;
begin
  for i:=0 to FieldCount do
    FieldCheckSet[i]:='';
end;

function TfrmPriceExcel.SelfCheckExcute: Boolean;
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
      if (fieldName <> '') and (FileName<>'') then
      begin
        if (fieldName='BARCODE') or (fieldName='GODS_CODE') then
        begin
          if (fieldName='BARCODE') or (fieldName='GODS_CODE') then
          begin
            isSort:=true;
            rs.SortedFields:=cdsColumn.fieldByName('FileName').AsString;
          end;

          if isSort then
          begin
            rs.First;
            strPre:=rs.fieldByName(FileName).AsString;
            preId:=rs.fieldByName('ID').AsInteger;
            //if strPre<>'' then
            TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strPre);
            rs.Next;
            while not rs.Eof do
            begin
              strNext:=rs.fieldByName(FileName).AsString;
              if (strPre<>'') and (strPre=strNext) then
              begin
                cdsExcel.Locate('ID',rs.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(preId)+'������'+cdsColumn.fieldByName('DestTitle').asstring+'�ظ�;';
                cdsExcel.Post;
              end
              else if (strPre<>strNext) then
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
    //OutCheckExcute;
    OutCheckExcute2;
    DuplicateCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmPriceExcel.OutCheckExcute: Boolean;
var rs,ss,gs,cs,ds:TZQuery;
    FieldName,barField,strError,codeField:string;
    i,j,c,FieldIndex,preId,codeIndex:integer;
    strWhere,barWhere,codeWhere:string;
    strList,barList,codeList:TStringList;
    preBarcode,nextBarcode,priceId,strcode:string;
begin
  try
    rs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    gs:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ds:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************��Ա�ȼ�*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','PRICE_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.SQL.Text:='select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and PRICE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount<=strList.Count then
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
            end else
            begin
              priceId:=rs.fieldByName('PRICE_ID').AsString;
              DeleteDuplicateString('',barList);
              if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                barField:=cdsColumn.fieldByName('FileName').AsString;
                c:=cdsColumn.FieldByName('ID').AsInteger;
                FieldCheckSet[c]:='';

                ss.Filtered:=false;
                ss.Filter:=FieldName+'='''+strList[i]+'''';
                ss.Filtered:=true;
                ss.First;
                while not ss.Eof do
                begin
                  if ss.FieldByName(barField).AsString<>'' then
                    TransformtoString(FieldCheckSet[c],ss.FieldByName(barField).AsString);
                  ss.Next;
                end;
                ss.Filtered:=false;
                barWhere:=DeleteDuplicateString(FieldCheckSet[c],barList);
                gs.Close;
                gs.SQL.Text:='select distinct barcode,GODS_ID from VIW_BARCODE where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and barcode in ('+barWhere+')';
                dataFactory.Open(gs);
                if not gs.IsEmpty then
                begin
                  if gs.RecordCount<= barList.Count then
                  begin
                    for j:=0 to barList.Count-1 do
                    begin
                      // add �������Ƿ���ڵȼ���Ӧ�Ķ���
                      if gs.Locate('barcode',barList[j],[]) then
                      begin
                        cs.Close;
                        cs.SQL.Text:='select PRICE_ID,GODS_ID from PUB_GOODSPRICE where tenant_id='+token.tenantId+
                                     ' and comm not in(''02'',''12'') and PRICE_ID='''+priceId+''' and GODS_ID='''+gs.fieldByName('GODS_ID').AsString+'''';
                        dataFactory.Open(cs);
                      end;
                      //
                      //add ����
                      DeleteDuplicateString('',codeList);
                      cdsColumn.Locate('FieldName','GODS_CODE',[]);
                      CodeField:=cdsColumn.fieldByName('FileName').AsString;
                      codeIndex:=cdsColumn.FieldByName('ID').AsInteger;
                      FieldCheckSet[codeIndex]:='';
                      //
                      cdsColumn.Locate('FieldName','BARCODE',[]);
                      ss.Filtered:=false;
                      ss.Filter:=FieldName+'='''+strList[i]+''' and '+barField+'='''+barList[j]+'''';
                      ss.Filtered:=true;
                      ss.SortedFields:=barField;
                      ss.First;
                      preBarcode:=ss.fieldByName(barField).AsString;
                      preId:=ss.fieldByName('ID').AsInteger;
                      strCode:=ss.fieldByName(CodeField).AsString;
                      if not gs.Locate('barcode',preBarcode,[]) then
                      begin
                        cdsExcel.Locate('ID',preId,[]);
                        cdsExcel.Edit;
                        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                        cdsExcel.Post;
                        if strCode<>'' then
                          TransformtoString(FieldCheckSet[codeIndex],strCode);
                      end else
                      begin
                        cdsExcel.Locate('ID',preId,[]);
                        cdsExcel.Edit;
                        cdsExcel.FieldByName('CODE').AsString:=gs.fieldByName('GODS_ID').AsString;
                        if not cs.IsEmpty then
                          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�õȼ����ڴ���Ʒ�Ļ�Ա��;';
                        cdsExcel.Post;
                      end;
                      ss.Next;
                      while not ss.Eof do
                      begin
                        nextBarcode:=ss.fieldByName(barField).AsString;
                        if not gs.Locate('barcode',nextBarcode,[]) then
                        begin
                          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                          cdsExcel.Edit;
                          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                          cdsExcel.Post;
                          if ss.fieldByName(CodeField).AsString<>'' then
                            TransformtoString(FieldCheckSet[codeIndex],ss.fieldByName(CodeField).AsString);
                        end else
                        begin
                          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                          cdsExcel.Edit;
                          cdsExcel.FieldByName('CODE').AsString:=gs.fieldByName('GODS_ID').AsString;
                          if (not cs.IsEmpty) and (preBarcode<>nextBarcode) then
                            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�õȼ����ڴ���Ʒ�Ļ�Ա��;';
                          cdsExcel.Post;
                        end;
                        if preBarcode=nextBarcode then
                        begin
                          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                          cdsExcel.Edit;
                          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(preId)+'������'+cdsColumn.fieldByName('DestTitle').asstring+'�ظ�;';
                          cdsExcel.Post;
                        end;
                        preBarcode:=nextBarcode;
                        preId:=ss.fieldByName('ID').AsInteger;
                        ss.Next;
                      end;
                      if FieldCheckSet[codeIndex]<>'' then
                      begin
                        ds.Data:=ss.Data;
                        FieldCheckSet[codeIndex]:=DeleteDuplicateString(FieldCheckSet[codeIndex],codeList);
                        CheckGodsCode(ss,codeList,CodeField,codeIndex);
                      end;
                      ss.Filtered:=false;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end
      end
      else
        FieldType[FieldIndex]:=0;
    end;

  finally
    rs.Free;
    ss.Free;
    gs.Free;
  end;
end;

function TfrmPriceExcel.OutCheckExcute2: Boolean;
var rs,ss,gs,cs,ds:TZQuery;
    FieldName,barField,strError,codeField:string;
    i,j,c,FieldIndex,preId,codeIndex:integer;
    strWhere,barWhere,codeWhere:string;
    strList,barList,codeList:TStringList;
    preBarcode,nextBarcode,priceId,strcode:string;
    priceId_C,priceId_S,priceId_B:string;
    priceGrade:TPriceGrade;
begin
  try
    rs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    gs:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ds:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************����*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.SQL.Text:=
                  'select VB.BARCODE,VB.GODS_ID,VB.BARCODE_TYPE,VM1.UNIT_NAME CALC_UNITS_NAME,VG.USING_BATCH_NO,VG.SORT_ID7,VG.SORT_ID8 '+
                  'from VIW_BARCODE VB '+
                  'left join VIW_GOODSPRICEEXT VG on VB.TENANT_ID=VG.TENANT_ID and VB.GODS_ID=VG.GODS_ID '+
                  'left join VIW_MEAUNITS VM1 on VB.TENANT_ID=VM1.TENANT_ID and VB.UNIT_ID=VM1.UNIT_ID '+
                  'where VB.tenant_id='+token.tenantId+' and VB.comm not in(''02'',''12'') and VG.comm not in(''02'',''12'') and VB.BARCODE_TYPE=''0'' and VB.barcode in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        FieldType[FieldIndex]:=1;
        for i:=0 to strList.Count-1 do
        begin
          if not rs.Locate('barcode',strList[i],[]) then
          begin
            DeleteDuplicateString('',codeList);
            cdsColumn.Locate('FieldName','GODS_CODE',[]);
            CodeField:=cdsColumn.fieldByName('FileName').AsString;
            c:=cdsColumn.FieldByName('ID').AsInteger;
            FieldCheckSet[c]:='';

            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+strList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              if strList[i]<>'' then
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���벻����;';
                cdsExcel.Post;
              end;
              if ss.fieldByName(CodeField).AsString<>'' then
                TransformtoString(FieldCheckSet[c],ss.FieldByName(CodeField).AsString);
              ss.Next;
            end;
            ss.Filtered:=false;
            FieldCheckSet[c]:=DeleteDuplicateString(FieldCheckSet[c],codeList);

            CheckGodsCode(ss,codeList,CodeField,c);
          end else 
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+strList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              //��GODS_ID��дCODE��Ϊ������Ψһ���ж�
              cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
              cdsExcel.Edit;
              cdsExcel.FieldByName('CODE').AsString:=rs.fieldbyName('GODS_ID').AsString;
              cdsExcel.Post;
              ss.Next;
            end;
            ss.Filtered:=false;
          end;
        end;
      end
      else begin
        FieldType[FieldIndex]:=0;
        cdsColumn.Locate('FieldName','GODS_CODE',[]);
        CodeField:=cdsColumn.fieldByName('FileName').AsString;
        c:=cdsColumn.FieldByName('ID').AsInteger;
        FieldCheckSet[c]:=DeleteDuplicateString(FieldCheckSet[c],codeList);
        CheckGodsCode(ss,codeList,CodeField,c);
      end;
    end;
    {
    for i:=0 to FPriceCount-1 do
    begin
      priceId_C:='PRICE_ID'+inttostr(i+1)+'_OUTPRICE';
      priceId_S:='PRICE_ID'+inttostr(i+1)+'_OUTPRICE1';
      priceId_B:='PRICE_ID'+inttostr(i+1)+'_OUTPRICE2';

      FieldName:='';
      if (cdsColumn.Locate('FieldName',priceId_C,[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
      begin
        strWhere:=cdsColumn.FieldByName('DestTitle').asString;
        strWhere:=copy(strWhere,1,length(strWhere)-length('-�ۼ�'));  //copy(strWhere,1,pos('-',strWhere)-1)
        rs.Close;
        rs.SQL.Text:='select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and PRICE_NAME ='''+strWhere+''' ';
        dataFactory.Open(rs);
        if not rs.IsEmpty then
        begin
          priceGrade:=TPriceGrade.Create;
          priceGrade.priceId:=rs.fieldByName('PRICE_ID').AsString;
          priceGrade.priceName:=rs.fieldByName('PRICE_NAME').AsString;
          priceGrade.PriceField:=priceId_C;
          priceGrade.priceIndex:=cdsColumn.FieldByName('ID').AsInteger;
          ValidPriceIdList.AddObject(priceGrade.priceId,priceGrade);
          FieldType[cdsColumn.FieldByName('ID').AsInteger]:=1;
        end;
      end;
    end;
    }
  finally
    ds.Free;
    cs.Free;
    gs.Free;
    rs.Free;
    ss.Free;
  end;
end;

function TfrmPriceExcel.CheckGodsCode(ss:TZQuery;strList:TStringList;codeField:string;index:integer): Boolean;
var strCode,preCode,nextCode:string;
    j,preIndex:integer;
    FieldName2:string;
    isHas:Boolean;
    gs,cs:TZQuery;
    strLog:TStringList;
begin
  strLog:=TStringlist.Create;
  cs:=TZQuery.Create(nil);
  gs:=TZQuery.Create(nil);
  try
    ss.SortedFields:=codeField;
    ss.First;
    preCode:=ss.fieldByName(codeField).AsString;
    preIndex:=ss.fieldByName('ID').AsInteger;
    ss.Next;
    while not ss.Eof do
    begin
      nextCode:=ss.fieldByName(codeField).AsString;
      if (preCode=nextCode) then
      begin
        cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
        cdsExcel.Edit;
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(preIndex)+'�����ݻ����ظ�;';
        cdsExcel.Post;
        ss.Next;
      end else
      begin
        preCode:=nextCode;
        preIndex:=ss.fieldByName('ID').AsInteger;
      end;
      ss.Next;
    end;
    //***********************����***********************
    cs.Close;
    cs.SQL.Text:=
                'select distinct VG.GODS_CODE,VG.GODS_ID,VM1.UNIT_NAME CALC_UNITS_NAME,VG.USING_BATCH_NO,VG.SORT_ID7,VG.SORT_ID8 '+
                'from VIW_GOODSPRICEEXT VG '+
                'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.CALC_UNITS=VM1.UNIT_ID '+
                'where VG.tenant_id='+token.tenantId+' and VG.comm not in(''02'',''12'') and VG.GODS_CODE in ('+FieldCheckSet[index]+')';
    dataFactory.Open(cs);

    strCode:=codeField;
    if not cs.IsEmpty then   //ͨ�����Ŷ��ڿ����ҵ�
    begin
      FieldType[index]:=1;
      for j:=0 to strList.Count-1 do
      begin
        ss.Filtered:=false;
        ss.Filter:=strCode+'='''+strList[j]+'''';
        ss.Filtered:=true;
        ss.First;
        if not cs.Locate('GODS_CODE',strList[j],[]) then
        begin
          while not ss.Eof do
          begin
            cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
            cdsExcel.Edit;
            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���Ų�����;';
            cdsExcel.Post;
            ss.Next;
          end;
        end else
        begin
          while not ss.Eof do
          begin
            cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
            cdsExcel.Edit;
            cdsExcel.FieldByName('CODE').AsString:=cs.fieldByName('GODS_ID').AsString;
            cdsExcel.Post;
            ss.Next;
          end;
        end;
        ss.Filtered:=false;
      end;
    end else
    begin
      for j:=0 to strList.Count-1 do
      begin
        ss.Filtered:=false;
        ss.Filter:=strCode+'='''+strList[j]+'''';
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
  finally
    cs.Free;
    gs.Free;
  end;
end;

function TfrmPriceExcel.DuplicateCheckExcute: Boolean;
var strPre,strNext:string;
    strIndex:integer;
    rs:TZQuery;
    i:integer;
    priceGrade:TPriceGrade;
begin
  result:=false;

  rs:=TZQuery.Create(nil);
  rs.SQL.Text:='select PRICE_ID,GODS_ID from PUB_GOODSPRICE where tenant_id='+token.tenantId+' and shop_id='''+token.shopId+''' and comm not in(''02'',''12'')';
  dataFactory.Open(rs);

  cdsExcel.DisableControls;
  //ֻ�ж�дCODE��������
  cdsExcel.Filtered:=false;
  cdsExcel.Filter:='CODE<>''''';
  cdsExcel.Filtered:=true;
  //��CODE�ֶ�����
  cdsExcel.SortedFields:='CODE';

  cdsExcel.First;
  strPre:=cdsExcel.fieldByName('CODE').AsString;
  strIndex:=cdsExcel.fieldByName('ID').AsInteger;
  {
  if cdsExcel.FieldByName('Msg').AsString='' then
  begin
    for i:=0 to ValidPriceIDList.Count-1 do
    begin
      priceGrade:=TPriceGrade(ValidPriceIDList.Objects[i]);
      if rs.Locate('PRICE_ID;GODS_ID',VarArrayof([priceGrade.priceId,strPre]),[]) then
      begin
        cdsExcel.Edit;
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'����Ʒ����'+priceGrade.priceName+'�Ļ�Ա��;';
        cdsExcel.Post;
      end;
    end;
  end;
  }
  cdsExcel.Next;
  while not cdsExcel.Eof do
  begin
    strNext:=cdsExcel.fieldByName('CODE').AsString;
    if strPre=strNext then
    begin
      cdsExcel.Edit;
      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���'+inttostr(strIndex)+'������ָ��ͬһ��Ʒ����ȷ�����롢�����Ƿ�ͳһ;';
      cdsExcel.Post;
    end else
    begin
      strPre:=strNext;
      strIndex:=cdsExcel.fieldByName('ID').AsInteger;
    end;
   { if cdsExcel.FieldByName('Msg').AsString='' then
      begin
        for i:=0 to ValidPriceIDList.Count-1 do
        begin
          priceGrade:=TPriceGrade(ValidPriceIDList.Objects[i]);
          if rs.Locate('PRICE_ID;GODS_ID',VarArrayof([priceGrade.priceId,strNext]),[]) then
          begin
            cdsExcel.Edit;
            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'����Ʒ����'+priceGrade.priceName+'�Ļ�Ա��;';
            cdsExcel.Post;
          end;
        end;
      end;
      }
    cdsExcel.Next;
  end;
  cdsExcel.SortedFields:='ID';
  cdsExcel.Filtered:=false;
  cdsExcel.EnableControls;
  result:=true;
end;

class function TfrmPriceExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmPriceExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--��Ա��';
        DataSet:=vDataSet;
        CreateUseDataSet;
        if ModalResult=MrCancel then exit;
        DecodeFields2(FieldsString);
        //DecodeFormats(FormatString);
        SelfCheck:=isSelfCheck;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmPriceExcel.RzLabel17Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('�Ƿ�Ҫ���ػ�Ա�۸���ģ�壿'),'������ʾ..',MB_YESNO+ MB_ICONQUESTION)<>6 then exit;
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����_.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����_.xls'),pchar(SaveDialog1.FileName),false)
      else if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

procedure TfrmPriceExcel.FormCreate(Sender: TObject);
begin
  inherited;
  ValidPriceIdList:=TStringList.Create;
end;

procedure TfrmPriceExcel.FormDestroy(Sender: TObject);
begin
  ValidPriceIdList.Free;
  inherited;
end;

function TfrmPriceExcel.IsRequiredFiled(strFiled: string): Boolean;
function CheckPriceID(vField:string):Boolean;
var i:integer;
    priceGrade:TPriceGrade;
begin
  result:=false;
  for i:=0 to ValidPriceIdList.Count-1 do
  begin
    priceGrade:=TPriceGrade(ValidPriceIdList.Objects[i]);
    if priceGrade.PriceField=vField then
    begin
      result:=true;
      break;
    end;
  end;
end;
begin
  result:=false;
  if (strFiled='BARCODE') or (strFiled='GODS_CODE') or (strFiled='GODS_NAME') or
      (strFiled='NEW_OUTPRICE') or CheckPriceID(strFiled) then
    result:=true;
end;

procedure TfrmPriceExcel.btnNextClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex=2 then
  begin
    ConfirmPriceGrade;
  end;
end;

function TfrmPriceExcel.ConfirmPriceGrade: Boolean;
var i,n:integer;
    rs:TZQuery;
    fileTitle,priceName:string;
    priceGrade:TPriceGrade;
begin
  n:=0;
  rs:=dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  for i:=0 to DBGridEh1.Columns.Count-1 do
  begin
    if i>SumCol then exit;
    fileTitle:=DBGridEh1.Columns[i].Title.Caption;
    if copy(fileTitle,length(fileTitle)-length('-�ۼ�')+1,length('-�ۼ�'))='-�ۼ�' then
    begin
      priceName:=copy(fileTitle,1,length(fileTitle)-length('-�ۼ�'));
      if rs.Locate('PRICE_NAME',priceName,[]) then
      begin
        inc(n);
        priceGrade:=TPriceGrade.Create;
        priceGrade.priceId:=rs.fieldByName('PRICE_ID').AsString;
        priceGrade.priceName:=priceName;
        priceGrade.PriceField:='PRICE_ID'+inttostr(n)+'_OUTPRICE';
        ValidPriceIdList.AddObject(priceGrade.priceId,priceGrade);
      end;
    end;
  end;
end;

end.
