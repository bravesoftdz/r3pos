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
    FieldCount=6;

type
  TfrmPriceExcel = class(TfrmExcelFactory)
    RzLabel14: TRzLabel;
    procedure Image4Click(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //�����ļ��ڲ��ж������ظ�
    function OutCheckExcute:Boolean;             //�����ļ���������ݶԱ�
    function Check(columnIndex:integer):Boolean;override;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    procedure ClearParams;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

  const
    FieldsString =
    'PRICE_ID=��Ա�ȼ�,BARCODE=������,NEW_OUTPRICE=������λ�ۼ�,NEW_OUTPRICE1=С��װ�ۼ�,NEW_OUTPRICE2=���װ�ۼ�';   //PRICE_METHOD=���۷�ʽ,

    FormatString =
    '0=PRICE_ID,1=BARCODE,2=NEW_OUTPRICE,3=NEW_OUTPRICE1,4=NEW_OUTPRICE2';   //2=PRICE_METHOD,

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmPriceExcel.CreateUseDataSet;
begin
  with DataSet.FieldDefs do
    begin
      Add('PRICE_ID',ftString,30,False);
      Add('BARCODE',ftString,30,False);
      //Add('PRICE_METHOD',ftString,50,False);
      Add('NEW_OUTPRICE',ftFloat,0,False);
      Add('NEW_OUTPRICE1',ftFloat,0,False);
      Add('NEW_OUTPRICE2',ftFloat,0,False);
    end;
  DataSet.CreateDataSet;
end;

function TfrmPriceExcel.SaveExcel(dsExcel:TZQuery):Boolean;
var Params: TftParamList;
    priceList,rs,gs:TZQuery;
    Field:TField;
begin
  try
    priceList:=TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    gs:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    rs:=TZQuery.Create(nil);
    rs.SQL.Text:='select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE where tenant_id='+token.tenantId+' and comm not in(''02'',''12'')';
    dataFactory.Open(rs);

    priceList.Close;
    try
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      Params.ParamByName('SHOP_ID').AsString := token.shopId;
      Params.ParamByName('GODS_ID').AsString := '';
      Params.ParamByName('PRICE_ID').AsString := '#';
      dataFactory.Open(priceList,'TGoodsPriceV60',Params);
    except
      raise;
    end;

    dsExcel.First;
    while not dsExcel.Eof do
    begin
      priceList.Append;
      priceList.FieldByName('TENANT_ID').AsString:=token.tenantId;
      priceList.FieldByName('SHOP_ID').AsString:=token.shopId;
      priceList.FieldByName('PRICE_METHOD').AsString:='1';

      Field:=dsExcel.FindField('PRICE_ID');
      if (Field <> nil) and (dsExcel.FieldByName('PRICE_ID').AsString<> '') then
      begin
        if rs.Locate('PRICE_NAME',dsExcel.FieldByName('PRICE_ID').AsString,[]) then
        begin
          priceList.FieldByName('PRICE_ID').AsString:=rs.fieldByName('PRICE_ID').AsString;
        end
        else
          priceList.FieldByName('PRICE_ID').AsString:='#';
      end;

      Field:=dsExcel.FindField('BARCODE');
      if (Field <> nil) and (dsExcel.FieldByName('BARCODE').AsString<> '') then
      begin
        if gs.Locate('BARCODE',dsExcel.FieldByName('BARCODE').AsString,[]) then
        begin
          priceList.FieldByName('GODS_ID').AsString:=gs.fieldByName('GODS_ID').AsString;
        end;
      end;

      Field:=dsExcel.FindField('NEW_OUTPRICE');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE').AsString<> '') then
      begin
        priceList.FieldByName('NEW_OUTPRICE').AsString:=dsExcel.FieldByName('NEW_OUTPRICE').AsString;
      end;

      Field:=dsExcel.FindField('NEW_OUTPRICE1');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE1').AsString<> '') then
      begin
        priceList.FieldByName('NEW_OUTPRICE1').AsString:=dsExcel.FieldByName('NEW_OUTPRICE1').AsString;
      end;

      Field:=dsExcel.FindField('NEW_OUTPRICE2');
      if (Field <> nil) and (dsExcel.FieldByName('NEW_OUTPRICE2').AsString<> '') then
      begin
        priceList.FieldByName('NEW_OUTPRICE2').AsString:=dsExcel.FieldByName('NEW_OUTPRICE2').AsString;
      end;
      priceList.Post;
      dsExcel.Next;
    end;

    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(priceList,'TGoodsPriceV60',nil);
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

  finally
    rs.Free;
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
  if not cdsColumn.Locate('FieldName','PRICE_ID',[]) then
  begin
    Result := False;
    strError:='��Ա�ȼ�';
  end;
  if not cdsColumn.Locate('FieldName','BARCODE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������'
    else
      strError:='������';
  end;
  if not cdsColumn.Locate('FieldName','NEW_OUTPRICE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'��'+'������λ�ۼ�'
    else
    strError:='������λ�ۼ�';
  end;

  if (strError<>'') then
    Raise Exception.Create('ȱ��'+strError+'�ֶΣ������ֶζ�Ӧ��ϵ�����ļ���');
end;

procedure TfrmPriceExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmPriceExcel.Check(columnIndex:integer): Boolean;
var str,strError,fieldName:string;
    num:double;
begin
  strError:='';
  fieldName:=cdsColumn.FieldByName('FileName').AsString;
  str:=cdsExcel.fieldByName(fieldName).AsString;
  case columnIndex of
    0:begin
      if str='' then
        strError:='��Ա�ȼ�Ϊ��;';
    end;
    1:begin
      if str='' then
        strError:='����Ϊ��;';
    end;
    2:begin     //���۷�ʽ

    end;
    3:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='������λ�ۼ�Ϊ��;';
         except
          strError:='��Ч�ļ�����λ�ۼ�;'
        end;
    end;
    4:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='С��װ�ۼ�Ϊ��;';
         except
          strError:='��Ч��С��װ�ۼ�;'
        end;
    end;
    5:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='���װ�ۼ�Ϊ��;';
         except
          strError:='��Ч�Ĵ��װ�ۼ�;'
        end;
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
      if fieldName <> '' then
      begin
        if (fieldName='PRICE_ID') then
        begin
          FileName:=cdsColumn.fieldByName('FileName').AsString;
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
      cdsColumn.Next;
    end;
    OutCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmPriceExcel.OutCheckExcute: Boolean;
var rs,ss,gs,cs:TZQuery;
    FieldName,barField,strError:string;
    i,j,c,FieldIndex,preId:integer;
    strWhere,barWhere:string;
    strList,barList:TStringList;
    preBarcode,nextBarcode,priceId:string;
begin
  try
    rs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    gs:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************��Ա�ȼ�*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','PRICE_ID',[]) then
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
              if cdsColumn.Locate('FieldName','BARCODE',[]) then
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
                      // �������Ƿ���ڵȼ���Ӧ�Ķ���
                      if gs.Locate('barcode',barList[j],[]) then
                      begin
                        cs.Close;
                        cs.SQL.Text:='select PRICE_ID,GODS_ID from PUB_GOODSPRICE where tenant_id='+token.tenantId+
                                     ' and comm not in(''02'',''12'') and PRICE_ID='''+priceId+''' and GODS_ID='''+gs.fieldByName('GODS_ID').AsString+'''';
                        dataFactory.Open(cs);
                      end;
                      //
                      ss.Filtered:=false;
                      ss.Filter:=FieldName+'='''+strList[i]+''' and '+barField+'='''+barList[j]+'''';
                      ss.Filtered:=true;
                      ss.SortedFields:=barField;
                      ss.First;
                      preBarcode:=ss.fieldByName(barField).AsString;
                      preId:=ss.fieldByName('ID').AsInteger;
                      if not gs.Locate('barcode',preBarcode,[]) then
                      begin
                        cdsExcel.Locate('ID',preId,[]);
                        cdsExcel.Edit;
                        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.fieldByName('DestTitle').AsString+'������;';
                        cdsExcel.Post;
                      end else
                      begin
                        cdsExcel.Locate('ID',preId,[]);
                        cdsExcel.Edit;
                        if not cs.IsEmpty then
                          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�õȼ��Ĵ��ڴ���Ʒ�Ļ�Ա��;';
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
                        end else
                        begin
                          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                          cdsExcel.Edit;
                          if (not cs.IsEmpty) and (preBarcode<>nextBarcode) then
                            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'�õȼ��Ĵ��ڴ���Ʒ�Ļ�Ա��;';
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

class function TfrmPriceExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmPriceExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--��Ա��';
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

procedure TfrmPriceExcel.Image4Click(Sender: TObject);
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ա�۸����.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), '������ʾ..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

end.
