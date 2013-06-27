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
    FGodsCodeType:integer; //0 库中没有文件中的分类；1  库中有文件中的不为空所有分类；2 库中有部分文件中分类
    barCodeList,godsCodeList,unitList,sortList:TStringList;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //导入文件内部判断有无重复
    function OutCheckExcute:Boolean;             //导入文件与库中数据对比
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
        raise exception.Create('没有找到对应的单位！');

      if gs.Locate('BARCODE',dsExcel.fieldByName('BARCODE').AsString,[]) then
      begin
        dsExcel.Edit;
        dsExcel.FieldByName('GODS_ID').AsString:=gs.fieldByName('GODS_ID').AsString;
        dsExcel.Post;
        RecordObj.ReadFromDataSet(gs,False);
      end
      else
        raise exception.Create('没有找到对应的商品！');

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
      strError:='商品名称为空;';
  end;
  if fieldName='BARCODE' then
  begin
    if str='' then
      strError:='条码为空;'
    else begin
      if FBarcodeType=0 then
        strError:='条码不存在;'
      else begin

      end;
    end;
  end;
  if fieldName='GODS_CODE' then
  begin
    if str='' then
      strError:='货号为空;';
  end;
  if fieldName='UNIT_ID' then
  begin
    if str='' then
      strError:='单位为空;';
  end;
  if fieldName='AMOUNT' then
  begin
    try
    if str='' then
      strError:='数量为空;'
    else
      num:=strtofloat(str);
    except
      strError:='无效的数量值;'
    end;
  end;
  if fieldName='APRICE' then
  begin
    try
    if str='' then
      strError:='单价为空;'
    else
      num:=strtofloat(str);
    except
      strError:='无效的单价值;'
    end;
  end;
  if fieldName='AMONEY' then
  begin
    try
    if str='' then
      strError:='金额为空;'
    else
      num:=strtofloat(str);
    except
      strError:='无效的金额值;'
    end;
  end;
  if fieldName='AGIO_RATE' then
  begin
    try
    if str='' then
      strError:='折扣为空;'
    else
      num:=strtofloat(str);
    except
      strError:='无效的折扣值;'
    end;
  end;
  if fieldName='AGIO_MONEY' then
  begin
    try
    if str='' then
      strError:='让利为空;'
    else
      num:=strtofloat(str);
    except
      strError:='无效的让利值;'
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

    //条码
    if cdsColumn.Locate('FieldName','BARCODE',[]) then
        fieldBarcode:=cdsColumn.fieldByName('FileName').AsString;
    if fieldBarcode='' then
      raise exception.Create('查询的字段不存在！');
    //货号
    if cdsColumn.Locate('FieldName','GODS_CODE',[]) then
        fieldGodscode:=cdsColumn.fieldByName('FileName').AsString;
    //单位
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

    //*********************条码*****************************
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
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'条码不存在;';
                cdsExcel.Post;
              end;
              if ss.fieldByName(strCode).AsString<>'' then
                godscodeList.Add(ss.fieldByName(strCode).AsString);
              ss.Next;
            end;
            ss.Filtered:=false;
            TransformtoString(godscodeList,FGoodsCode);

            CheckGodsCode(cs,ss);
          end else //rs中能定位到barcode
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
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该单位;';
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
  //***********************货号***********************
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

  if not cs.IsEmpty then   //通过货号都在库中找到
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
          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'货号不存在;';
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
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该单位;';
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
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'货号不存在;';
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

//Duplicates 有3个可选值:
//dupIgnore: 放弃; 
//dupAccept: 结束;
//dupError: 提示错误
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
  if MessageBox(Handle,pchar('是否要下载商品导入模板？'),'友情提示',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then exit;
  saveDialog1.DefaultExt:='*.xls';
  saveDialog1.Filter:='Excel文档(*.xls)|*.xls';
  if saveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    try
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\商品单据导入表.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\商品单据导入表.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('没有找到导入模板！'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('下载导入模板失败！'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
  end;
end;



end.
