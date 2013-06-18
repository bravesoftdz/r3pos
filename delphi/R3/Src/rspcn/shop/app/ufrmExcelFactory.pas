unit ufrmExcelFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms,
  Grids, DBGridEh, RzEdit, RzStatus,ComObj,IniFiles;

type
  TfrmExcelFactory = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzBackground1: TRzBackground;
    RzLabel2: TRzLabel;
    RzBorder1: TRzBorder;
    TabSheet2: TRzTabSheet;
    RzBackground2: TRzBackground;
    TabSheet3: TRzTabSheet;
    RzBackground3: TRzBackground;
    RzPanel4: TRzPanel;
    btnNext: TRzBmpButton;
    btnPrev: TRzBmpButton;
    cdsGoodsPrice: TZQuery;
    cdsGoodsInfo: TZQuery;
    cdsGoodsRelation: TZQuery;
    cdsBarCode: TZQuery;
    edtTable: TZQuery;
    RzLabel26: TRzLabel;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzBackground6: TRzBackground;
    RzBackground7: TRzBackground;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    OpenDialog1: TOpenDialog;
    dsExcel: TDataSource;
    cdsColumn: TZQuery;
    dsColumn: TDataSource;
    edtBK_Input: TRzPanel;
    RzPanel24: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel11: TRzLabel;
    edtFileName: TcxButtonEdit;
    chkHeader: TcxCheckBox;
    RzPanel7: TRzPanel;
    RzPanel5: TRzPanel;
    RzLabel8: TRzLabel;
    edtNum: TcxSpinEdit;
    RzPanel8: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    RzPanel11: TRzPanel;
    DBGridEh2: TDBGridEh;
    cdsDropColumn: TcxComboBox;
    RzStatus: TRzStatusPane;
    TabSheet6: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel12: TRzLabel;
    DBGridEh3: TDBGridEh;
    cdsExcel: TZQuery;
    RzStatus1: TRzStatusPane;
    RzStatus2: TRzStatusPane;
    Image4: TImage;
    SaveDialog1: TSaveDialog;
    RzLabel7: TRzLabel;
    procedure edtFileNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsDropColumnPropertiesChange(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure Image4Click(Sender: TObject);
  private
    FDataSet: TZQuery;
    FStartRow: Integer;
    FBarcode:wideString;
    FGoodsCode:wideString;
    FUnits:wideString;
    FSorts:wideString;
    FSumCount,FExceptCount:integer;
    function FindColumn(CdsCol:TDataSet):Boolean;
    function SaveExcel(dsExcel:TDataSet):Boolean;
    function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
    function Check2:Boolean;
    procedure DecodeFields(s: string);
    procedure DecodeFormats(s: string);
    procedure WriteToDataSet(DataSet: TDataSet);
    procedure OpenExecl(FileName: string);
    procedure CreateDataSet;
    procedure SetStartRow(value:integer);
    procedure IsHeader;
    procedure CreateColumn;
    procedure CreateParams;
    procedure CreateDbGridEhTitle;
  public
    vList:TStringList;
    mxCol,ErrorSum:Integer;
    FilePath: String;
    class function ExcelFactory(Owner: TForm):Boolean;
    property DataSet:TZQuery read FDataSet;
    property StartRow:integer read FStartRow write SetStartRow;
  end;

  const
    FieldsString =
    'BARCODE1=条形码,GODS_CODE=货号,GODS_NAME=商品名称,GODS_SPELL=拼音码,CALC_UNITS=计量单位,SORT_ID1=商品分类,NEW_OUTPRICE=标准售价,'+
    'NEW_INPRICE=最新进价,NEW_LOWPRICE=最低售价,MY_OUTPRICE=本店售价,SORT_ID7=颜色组,SORT_ID8=尺码组,SMALL_UNITS=小包装单位,SMALLTO_CALC=小包装换算系数,'+
    'BARCODE2=小包装条码,MY_OUTPRICE1=小包装本店售价,BIG_UNITS=大包装单位,BIGTO_CALC=大包装换算系数,BARCODE3=大包装条码,MY_OUTPRICE2=大包装本店售价,SORT_ID3=供应商';

    FormatString =
    '0=BARCODE1,1=GODS_CODE,2=GODS_NAME,3=GODS_SPELL,4=CALC_UNITS,5=SORT_ID1,6=NEW_OUTPRICE,7=NEW_INPRICE,8=NEW_LOWPRICE,9=MY_OUTPRICE,'+
    '10=SORT_ID7,11=SORT_ID8,12=SMALL_UNITS,13=SMALLTO_CALC,14=BARCODE2,15=MY_OUTPRICE1,16=BIG_UNITS,17=BIGTO_CALC,18=BARCODE3,19=MY_OUTPRICE2,20=SORT_ID3';


implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmExcelFactory.CreateDataSet;
begin
  FDataSet:=TZQuery.Create(nil);
  with FDataSet.FieldDefs do
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
  FDataSet.CreateDataSet;
end;

procedure TfrmExcelFactory.DecodeFields(s: string);
var vList1:TStringList;
  i:integer;
  Field:TField;
begin
  if s='' then Raise Exception.Create('没有定义要导入的字段');
  vList1 := TStringList.Create;
  try
    vList1.CommaText := s;
    cdsDropColumn.Properties.Items.Clear;
    for i:=0 to vList1.Count -1 do
      begin
        Field := DataSet.FindField(vList1.Names[i]);
        if Field=nil then Raise Exception.Create(vList1.Names[i]+'字段名无效...');
        cdsDropColumn.Properties.Items.AddObject(vList1.ValueFromIndex[i],Pointer(Field.Index));
      end;
  finally
    vList1.Free;
  end;
end;

procedure TfrmExcelFactory.DecodeFormats(s: string);
begin
  if s='' then Raise Exception.Create('没有定义要导入的字段');  
  vList.CommaText := s;
  if s<>'' then
     mxCol := StrtoInt(vList.Names[vList.Count-1])+1
  else
     mxCol := 27;
end;

procedure TfrmExcelFactory.WriteToDataSet(DataSet: TDataSet);
begin
  cdsColumn.First;
  while not cdsColumn.Eof do
    begin
        if cdsColumn.FieldbyName('FieldName').AsString <> '' then
        begin
          if not Check(cdsExcel,DataSet,cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].FieldName,cdsColumn.FieldbyName('FieldName').AsString) then
          begin
           if DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).DataType in [ftString,ftWideString,ftFixedChar] then
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := trim(cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].AsString)
           else
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := StrtoFloatDef(trim(cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].asString),0);
          end;
        end;
      cdsColumn.Next;
    end;
end;

procedure TfrmExcelFactory.SetStartRow(value:integer);
begin
  FStartRow:=value;
end;

procedure TfrmExcelFactory.OpenExecl(FileName: string);
function CheckNull(V:array of string):Boolean;
var i:integer;
begin
  result := true;
  for i:=0 to 3 do
    result := result and (trim(V[i])='');
end;
var Excel,excelWorkBook: Variant;
  r,n,i:Integer;
  excelCount:integer;
  V:array [1..50] of string;
begin
  cdsExcel.Close;
  cdsExcel.CreateDataSet;
  cdsExcel.DisableControls;
  try
  RzStatus.Caption := '正在打开Excel';
  RzStatus.Update;
  Excel := CreateOleObject('Excel.Application');
    try
      excelWorkBook:=Excel.WorkBooks.open(FileName);
      Excel.Visible := false;
      excelCount:=excelWorkBook.WorkSheets[1].UsedRange.Rows.Count;
      r := 0;
      while r< excelCount do
      begin
        inc(r);
        if r<StartRow then Continue;
        if (r mod 10)=0 then
        begin
          RzStatus.Caption := '打开'+inttostr(r)+'行...';
          RzStatus.Update;
        end;

        cdsExcel.Append;
        cdsExcel.FieldByName('ID').AsInteger := r-1;
        for i:= 1 to mxCol do
          cdsExcel.Fields[i].AsString := Excel.Cells[r,i].Value;
        cdsExcel.Post;
      end;

    finally
      excelWorkBook.close;
      Excel.quit;
    end;
  finally
    cdsExcel.First;
    cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.IsHeader;
var i:integer;
    Column: TColumnEh;
begin
  inherited;
  cdsExcel.First;
  if not chkHeader.Checked then
  begin
    cdsExcel.Filtered := false;
    for i:=1 to mxCol do
      begin
        DBGridEh1.Columns[i].Title.Caption := Char(64+i);
      end;
  end
  else
  begin
    if cdsExcel.IsEmpty then Exit;
    for i:=1 to mxCol do
      begin
        DBGridEh1.Columns[i].Title.Caption := cdsExcel.FieldbyName(Char(64+i)).AsString;
      end;
    cdsExcel.Delete;
  end;
  FSumCount:=cdsExcel.RecordCount;
end;

class function TfrmExcelFactory.ExcelFactory(Owner: TForm): Boolean;
begin
  with TfrmExcelFactory.Create(Owner) do
    begin
      try
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

function TfrmExcelFactory.Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
var rs:TZQuery;
begin
  if (SFieldName <> '') and (DFieldName <> '') then
    begin
      Result := False;
      // *******************计量单位********************
      if DFieldName = 'CALC_UNITS' then
        begin
          if Source.FieldByName(SFieldName).AsString <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
              if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                begin
                  Dest.FieldByName('CALC_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的计量单位...');
            end
          else
            Raise Exception.Create('计量单位不能为空!');
        end;

      // *******************包装1单位********************
      if DFieldName = 'SMALL_UNITS' then
        begin
          if Source.FieldByName(SFieldName).AsString <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
              if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                begin
                  Dest.FieldByName('SMALL_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的包装1单位...');
            end;
        end;

      // *******************包装2单位********************
      if DFieldName = 'BIG_UNITS' then
        begin
          if Source.FieldByName(SFieldName).AsString <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
              if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                begin
                  Dest.FieldByName('BIG_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的包装2单位...');
            end;
        end;

      //*******************商品分类*****************
      if DFieldName = 'SORT_ID1' then
        begin
          if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
              if rs.Locate('SORT_NAME,RELATION_ID',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'0']),[]) then
                begin
                  Dest.FieldByName('SORT_ID1').AsString := rs.FieldbyName('SORT_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的商品分类...');
            end
          else
            Raise Exception.Create('商品分类不能为空!');
        end;

      //*******************颜色组*****************
      if DFieldName = 'SORT_ID7' then
        begin
          if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_COLOR_INFO');
              if rs.Locate('COLOR_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                begin
                  Dest.FieldByName('SORT_ID7').AsString := rs.FieldbyName('COLOR_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的颜色...');
            end;
        end;

      //*******************尺码组*****************
      if DFieldName = 'SORT_ID8' then
        begin
          if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_SIZE_INFO');
              if rs.Locate('SIZE_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                begin
                  Dest.FieldByName('SORT_ID8').AsString := rs.FieldbyName('SIZE_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的尺码...');
            end;
        end;

      //*******************供应商*****************
      if DFieldName = 'SORT_ID3' then
        begin
          if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
            begin
              rs := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
              if rs.Locate('CLIENT_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                begin
                  Dest.FieldByName('SORT_ID3').AsString := rs.FieldbyName('CLIENT_ID').AsString;
                  Result := True;
                  Exit;
                end
              else
                Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的供应商...');
            end;
        end;

      //货号
      if DFieldName = 'GODS_CODE' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 20 then
                Raise Exception.Create('货号应在20个字符以内!')
              else
                begin
                  Dest.FieldbyName('GODS_CODE').AsString := Source.FieldByName(SFieldName).AsString;
                end;
            end
          else
            begin     
              Dest.FieldbyName('GODS_CODE').AsString := TSequence.GetSequence('GODS_CODE',token.tenantId,'',6);  //企业内码ID
            end;
          Result := True;
          Exit;
        end;

      //条形码1
      if DFieldName = 'BARCODE1' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                Raise Exception.Create('条形码应在30个字符以内!')
              else
                begin
                  if (Dest.FieldByName('BARCODE2').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Source.FieldByName('BARCODE2').AsString) then
                    raise Exception.Create('计量单位的条码不能和小包装条码一样!');
                  if (Dest.FieldByName('BARCODE3').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE3').AsString) then
                    raise Exception.Create('计量单位的条码不能和大包装条码一样!');

                  Dest.FieldbyName('BARCODE1').AsString := Source.FieldByName(SFieldName).AsString;
                end;
            end
          else
            begin
              Dest.FieldbyName('BARCODE1').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
            end;
          Result := True;
          Exit;
        end;

      //条形码2
      if DFieldName = 'BARCODE2' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                Raise Exception.Create('条形码应在30个字符以内!')
              else
                begin
                  if (Dest.FieldByName('BARCODE1').AsString <> '') and (Dest.FieldByName('BARCODE1').AsString = Source.FieldByName(SFieldName).AsString) then
                    raise Exception.Create('计量单位的条码不能和小包装条码一样!');
                  if (Dest.FieldByName('BARCODE3').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE3').AsString) then
                    raise Exception.Create('小包装条码不能和大包装条码一样!');

                  Dest.FieldbyName('BARCODE2').AsString := Source.FieldByName(SFieldName).AsString;
                  Result := True;
                  Exit;
                end;
            end;
        end;

      //条形码3
      if DFieldName = 'BARCODE3' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                Raise Exception.Create('条形码应在30个字符以内!')
              else
                begin
                  if (Dest.FieldByName('BARCODE1').AsString <> '') and (Dest.FieldByName('BARCODE1').AsString = Source.FieldByName(SFieldName).AsString) then
                    raise Exception.Create('计量单位的条码不能和大包装条码一样!');
                  if (Dest.FieldByName('BARCODE2').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE2').AsString) then
                    raise Exception.Create('小包装条码不能和大包装条码一样!');

                  Dest.FieldbyName('BARCODE3').AsString := Source.FieldByName(SFieldName).AsString;
                  Result := True;
                  Exit;
                end;
            end;
        end;

      //商品名称
      if DFieldName = 'GODS_NAME' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                Raise Exception.Create('商品名称就在50个字符以内!')
              else
                begin
                  Dest.FieldbyName('GODS_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                  Result := True;
                  Exit;
                end;
            end
          else
            Raise Exception.Create('商品名称不能为空!');
        end;

      //商品拼音码
      if DFieldName = 'GODS_SPELL' then
        begin
          if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
            begin
              if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                Raise Exception.Create('商品拼音码就在50个字符以内!')
              else
                begin
                  Dest.FieldbyName('GODS_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
                  Result := True;
                  Exit;
                end;
            end;
        end;
    end
  else
    begin
      //单条数据作比较 包装1参数对比
      if (Dest.FieldByName('BARCODE2').AsString <> '') or (Dest.FieldByName('SMALL_UNITS').AsString <> '') or (Dest.FieldByName('SMALLTO_CALC').AsInteger <> 0) then
        begin
          if (Dest.FieldByName('BARCODE2').AsString = '') or (Dest.FieldByName('SMALL_UNITS').AsString = '') or (Dest.FieldByName('SMALLTO_CALC').AsInteger = 0) then
            raise Exception.Create('包装1参数不完整!')
          else
            begin
              if Dest.FieldByName('MY_OUTPRICE1').AsString = '' then
                Dest.FieldByName('MY_OUTPRICE1').AsInteger := Dest.FieldByName('SMALLTO_CALC').AsInteger * Dest.FieldByName('MY_OUTPRICE').AsInteger;
            end;
        end;

      //单条数据作比较 包装2参数对比
      if (Dest.FieldByName('BARCODE3').AsString <> '') or (Dest.FieldByName('BIG_UNITS').AsString <> '') or (Dest.FieldByName('BIGTO_CALC').AsInteger <> 0) then
        begin
          if (Dest.FieldByName('BARCODE3').AsString = '') or (Dest.FieldByName('BIG_UNITS').AsString = '') or (Dest.FieldByName('BIGTO_CALC').AsInteger = 0) then
            raise Exception.Create('包装2参数不完整!')
          else
            begin
              if Dest.FieldByName('MY_OUTPRICE2').AsString = '' then
                Dest.FieldByName('MY_OUTPRICE2').AsInteger := Dest.FieldByName('BIGTO_CALC').AsInteger * Dest.FieldByName('MY_OUTPRICE').AsInteger;
            end;
        end;

    end;
end;

function TfrmExcelFactory.SaveExcel(dsExcel:TDataSet):Boolean;
  procedure WriteToBarcode(Data_Bar:TZQuery;Gods_Id,Unit_Id,BarCode,BarcodeType:String);
  begin
    Data_Bar.Append;
    //Data_Bar.FieldByName('RELATION_FLAG').AsString := '2';
    Data_Bar.FieldByName('TENANT_ID').AsInteger :=strtoint(token.tenantId);
    Data_Bar.FieldByName('GODS_ID').AsString := Gods_Id;
    Data_Bar.FieldByName('ROWS_ID').AsString := TSequence.NewId;  //行号[GUID编号]
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
var DsGoods,DsBarcode,DsGoodsPrice,rs:TZQuery;
    GodsId,Bar,Code,Name,Error_Info:String;
    SumBarcode,SumCode,SumName:Integer;
    Params:TftParamList;
begin
  Result := False;
  DsGoods := TZQuery.Create(nil);
  DsBarcode := TZQuery.Create(nil);
  DsGoodsPrice:=TZQuery.Create(nil);

  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').asInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString :=token.shopId;
    Params.ParamByName('GODS_ID').asString :='';
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
        Bar := dsExcel.FieldByName('BARCODE1').AsString;
        Code := dsExcel.FieldByName('GODS_CODE').AsString;
        Name := dsExcel.FieldByName('GODS_NAME').AsString;
        {
        if rs.Locate('BARCODE',Bar,[]) then
          Inc(SumBarcode);
        if rs.Locate('GODS_CODE',Code,[]) then
          Inc(SumCode);
        if rs.Locate('GODS_NAME',Name,[]) then
          Inc(SumName);
        if DsGoods.Locate('BARCODE',Bar,[]) then
          Inc(SumBarcode);
        if DsGoods.Locate('GODS_CODE',Code,[]) then
          Inc(SumCode);
        if DsGoods.Locate('GODS_NAME',Name,[]) then
          Inc(SumName);
         }
        DsGoods.Append;
        GodsId := TSequence.NewId;
        DsGoods.FieldByName('GODS_ID').AsString := GodsId;
        DsGoods.FieldByName('TENANT_ID').AsInteger :=strtoint(token.tenantId);
        //DsGoods.FieldByName('SHOP_ID').AsString :=token.shopId;
        DsGoods.FieldByName('GODS_CODE').AsString := Code;
        DsGoods.FieldByName('GODS_NAME').AsString := Name;
        if dsExcel.FieldByName('GODS_SPELL').AsString <> '' then
          DsGoods.FieldByName('GODS_SPELL').AsString := dsExcel.FieldByName('GODS_SPELL').AsString
        else
          DsGoods.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(Trim(Name),3);
        DsGoods.FieldByName('GODS_TYPE').AsString :='';
        DsGoods.FieldByName('SORT_ID1').AsString := dsExcel.FieldByName('SORT_ID1').AsString;
        DsGoods.FieldByName('SORT_ID3').AsString := dsExcel.FieldByName('SORT_ID3').AsString;
        DsGoods.FieldByName('SORT_ID7').AsString := dsExcel.FieldByName('SORT_ID7').AsString;
        DsGoods.FieldByName('SORT_ID8').AsString := dsExcel.FieldByName('SORT_ID8').AsString;
        DsGoods.FieldByName('UNIT_ID').AsString := dsExcel.FieldByName('CALC_UNITS').AsString;
        DsGoods.FieldByName('CALC_UNITS').AsString := dsExcel.FieldByName('CALC_UNITS').AsString;

        //2011.08.25加判断条码是否为空:
        if Bar <> '' then
        begin
          DsGoods.FieldByName('BARCODE').AsString := Bar;
          WriteToBarcode(DsBarcode,GodsId,dsExcel.FieldByName('CALC_UNITS').AsString,dsExcel.FieldByName('BARCODE1').AsString,'0');
        end;
          
        if dsExcel.FieldByName('BARCODE2').AsString <> '' then
          begin
            DsGoods.FieldByName('SMALL_UNITS').AsString := dsExcel.FieldByName('SMALL_UNITS').AsString;
            DsGoods.FieldByName('SMALLTO_CALC').AsString := dsExcel.FieldByName('SMALLTO_CALC').AsString;
            WriteToBarcode(DsBarcode,GodsId,dsExcel.FieldByName('SMALL_UNITS').AsString,dsExcel.FieldByName('BARCODE2').AsString,'1');
          end;

        if dsExcel.FieldByName('BARCODE3').AsString <> '' then
          begin
            DsGoods.FieldByName('BIG_UNITS').AsString := dsExcel.FieldByName('BIG_UNITS').AsString;
            DsGoods.FieldByName('BIGTO_CALC').AsString := dsExcel.FieldByName('BIGTO_CALC').AsString;
            WriteToBarcode(DsBarcode,GodsId,dsExcel.FieldByName('BIG_UNITS').AsString,dsExcel.FieldByName('BARCODE3').AsString,'2');
          end;

        DsGoods.FieldByName('NEW_INPRICE').AsFloat := dsExcel.FieldByName('NEW_INPRICE').AsFloat;
        DsGoods.FieldByName('NEW_OUTPRICE').AsFloat := dsExcel.FieldByName('NEW_OUTPRICE').AsFloat;
        DsGoods.FieldByName('NEW_LOWPRICE').AsFloat := dsExcel.FieldByName('NEW_LOWPRICE').AsFloat;
        if dsExcel.FieldByName('MY_OUTPRICE').AsString<>'' then
        begin
          WriteToGoodsPrice(DsGoodsPrice,GodsId,dsExcel.FieldByName('MY_OUTPRICE').AsFloat,dsExcel.FieldByName('MY_OUTPRICE1').AsFloat,dsExcel.FieldByName('MY_OUTPRICE2').AsFloat);
          //DsGoods.FieldByName('NEW_OUTPRICE').AsFloat := dsExcel.FieldByName('MY_OUTPRICE').AsFloat;
          //DsGoods.FieldByName('NEW_OUTPRICE1').AsFloat := dsExcel.FieldByName('MY_OUTPRICE1').AsFloat;
          //DsGoods.FieldByName('NEW_OUTPRICE2').AsFloat := dsExcel.FieldByName('MY_OUTPRICE2').AsFloat;
        end;

        DsGoods.FieldByName('USING_PRICE').AsInteger := 1;
        DsGoods.FieldByName('HAS_INTEGRAL').AsInteger := 1;
        //DsGoods.FieldByName('INTEGRAL_RATE').AsFloat := 1;
        DsGoods.FieldByName('USING_BATCH_NO').AsInteger := 2;
        DsGoods.FieldByName('USING_BARTER').AsInteger := 1;
        DsGoods.FieldByName('USING_LOCUS_NO').AsInteger := 2;
        DsGoods.FieldByName('BARTER_INTEGRAL').AsInteger := 0;
        //DsGoods.FieldByName('USING_IN_TAX_RATE').AsString := '0';
        //DsGoods.FieldByName('USING_OUT_TAX_RATE').AsString := '0';

        DsGoods.Post;
        dsExcel.Next;
      end;
      {
      rs := dllGlobal.GetZQueryFromName('SYS_DEFINE');
      rs.Filtered := False;
      rs.Filter := ' DEFINE=''DUPBARCODE'' ';
      rs.Filtered := True;

      if (SumBarcode > 0 ) and (rs.FieldByName('VALUE').AsString<>'1') then
        Raise Exception.Create('系统设置不允许条码重复使用（即一码多品）');

      if (SumBarcode > 0 ) or (SumCode > 0 ) or (SumName > 0) then
        begin
          Error_Info := '在导入数据中:'+#13#10;

          if SumBarcode > 0 then
            Error_Info := Error_Info + '条形码相同有"'+IntToStr(SumBarcode)+'"条;'+#13#10;
          if SumCode > 0 then
            Error_Info := Error_Info + '货号相同有"'+IntToStr(SumCode)+'"条;'+#13#10;
          if SumName > 0 then
            Error_Info := Error_Info + '商品名称相同有"'+IntToStr(SumName)+'"条;'+#13#10;
          Error_Info := Error_Info + '是否导入！';

          //if Messagebox(Pchar(Error_Info),'提示信息..',MB_YESNO+MB_ICONQUESTION) <> 6 then
          if Messagebox(Handle,Pchar(Error_Info),'提示信息..',MB_YESNO+MB_ICONQUESTION) <> 6 then
            begin
              Exit;
            end;
        end;
        }

      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(DsGoods,'TGoodsInfoV60',Params);
        dataFactory.AddBatch(DsBarcode,'TBarCodeV60',Params);
        dataFactory.AddBatch(DsGoodsPrice,'TGoodsPriceV60',Params);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
  finally
    DsGoods.Free;
    DsBarcode.Free;
    DsGoodsPrice.Free;
    Params.Free;
  end;
  Result := True;
end;

function TfrmExcelFactory.FindColumn(CdsCol:TDataSet):Boolean;
begin
  Result := True;
  if not CdsCol.Locate('FieldName','GODS_NAME',[]) then
    begin
      Result := False;
      Raise Exception.Create('缺少商品名称字段!');
    end;
  if not CdsCol.Locate('FieldName','CALC_UNITS',[]) then
    begin
      Result := False;
      Raise Exception.Create('缺少计量单位字段!');  
    end;
  if not CdsCol.Locate('FieldName','SORT_ID1',[]) then
    begin
      Result := False;
      Raise Exception.Create('缺少商品分类字段!');   
    end;
  if not CdsCol.Locate('FieldName','NEW_OUTPRICE',[]) then
    begin
      Result := False;
      Raise Exception.Create('缺少标准售价字段!');
    end;
end;

procedure TfrmExcelFactory.edtFileNameClick(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  edtFileName.Text := OpenDialog1.FileName;
  FilePath := Trim(edtFileName.Text);
end;

procedure TfrmExcelFactory.FormCreate(Sender: TObject);
begin
  inherited;
  CreateDataSet;
  vList := TStringList.Create;
  StartRow := 1;
  DecodeFields(FieldsString);
  DecodeFormats(FormatString);
  CreateParams;
end;

procedure TfrmExcelFactory.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
end;

procedure TfrmExcelFactory.btnNextClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex=5 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=0;
  end
  else if rzPage.ActivePageIndex=0 then
  begin
    //打开Excel
    if FilePath='' then raise Exception.Create('请选择导入的Excel文件');
    OpenExecl(FilePath);
    IsHeader;
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=1;
  end
  else if rzPage.ActivePageIndex=1 then
  begin
    CreateColumn;
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=2;
  end
  else if rzPage.ActivePageIndex=2 then
  begin
    Check2;
    CreateDbGridEhTitle;
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=3;
  end
  else if rzPage.ActivePageIndex=3 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='执行';
    rzPage.ActivePageIndex:=4;
  end
  else if rzPage.ActivePageIndex=4 then
  begin
    if btnNext.Caption='完成' then Close;
    SaveExcel(FDataSet);
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='完成';
  end;
end;

procedure TfrmExcelFactory.btnPrevClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex=5 then
  begin
  end
  else if rzPage.ActivePageIndex=4 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=3;
  end
  else if rzPage.ActivePageIndex=3 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=2;
  end
  else if rzPage.ActivePageIndex=2 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=1;
  end
  else if rzpage.ActivePageIndex=1 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='上一步';
    btnNext.Visible:=True;
    btnNext.Caption:='下一步';
    rzPage.ActivePageIndex:=0;
  end
  else if rzPage.ActivePageIndex=0 then
  begin
    btnPrev.Visible:=False;
    btnNext.Visible:=True;
    btnNext.Caption:='开始';
    rzPage.ActivePageIndex:=5;
  end;
end;

procedure TfrmExcelFactory.FormShow(Sender: TObject);
begin
  inherited;
  rzPage.ActivePageIndex:=5;
  btnPrev.Visible:=False;
  btnNext.Visible:=True;
  btnNext.Caption:='开始';
end;

procedure TfrmExcelFactory.CreateColumn;
var i,n,index:integer;
  FieldName:string;
begin
  cdsColumn.Close;
  cdsColumn.CreateDataSet;
  for i:=0 to DBGridEh1.Columns.Count -3 do
    begin
      if DBGridEh1.Columns[i+1].Visible then
         begin
           cdsColumn.Append;
           cdsColumn.FieldByName('ID').AsInteger := i+1;
           cdsColumn.FieldByName('FileTitle').AsString := DBGridEh1.Columns[i+1].Title.Caption;
           cdsColumn.FieldByName('FileName').AsString:=DBGridEh1.Columns[i+1].FieldName;
           if not chkHeader.Checked then
             begin
               if vList.IndexOfName(inttostr(i))>=0 then
                  begin
                    cdsColumn.FieldByName('FieldName').AsString := vList.Values[inttostr(i)];
                    index := DataSet.FieldByName(cdsColumn.FieldByName('FieldName').AsString).Index;
                    for n:= 0 to cdsDropColumn.Properties.Items.Count -1 do
                      begin
                        if Integer(cdsDropColumn.Properties.Items.Objects[n])=index then
                           begin
                             cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Properties.Items[n];
                             Break;
                           end;
                      end;
                  end;
              end
             else
              begin
                for n := 0 to cdsDropColumn.Properties.Items.Count - 1 do
                  begin
                    if cdsColumn.FieldByName('FileTitle').AsString = cdsDropColumn.Properties.Items[n] then
                      begin
                        cdsDropColumn.ItemIndex := n;
                        cdsColumn.FieldByName('FieldName').AsString := DataSet.Fields[Integer(cdsDropColumn.Properties.Items.Objects[cdsDropColumn.ItemIndex])].FieldName;
                        cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Text;
                        Break;
                      end;
                  end;
              end;
           cdsColumn.Post;
         end;
    end;
  cdsColumn.First;
end; 

procedure TfrmExcelFactory.cdsDropColumnPropertiesChange(Sender: TObject);
begin
  inherited;
  if cdsDropColumn.Visible and cdsDropColumn.Focused then
     begin
       if cdsDropColumn.ItemIndex >=0 then
       begin
         cdsColumn.Edit;
         cdsColumn.FieldByName('FieldName').AsString := DataSet.Fields[Integer(cdsDropColumn.Properties.Items.Objects[cdsDropColumn.ItemIndex])].FieldName;
         cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Text;
         cdsColumn.Post;
       end
       else
       begin
         cdsColumn.Edit;
         cdsColumn.FieldByName('FieldName').AsString := '';
         cdsColumn.FieldByName('DestTitle').AsString := '';
         cdsColumn.Post;
       end;
     end;
end;


procedure TfrmExcelFactory.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='A' then Text := '合计:'+Text+'笔';
end;

procedure TfrmExcelFactory.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='Msg' then Text := '合计:'+Text+'笔';
end;

procedure TfrmExcelFactory.CreateParams;
var rs:TZQuery;
    str:string;
begin

  rs:=TZQuery.Create(nil);
  rs:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

  rs.First;
  while not rs.Eof do
  begin
    if FBarcode='' then
      FBarcode:=''''+rs.fieldbyName('BARCODE').AsString+''''
    else
      FBarcode:=FBarcode+','+''''+rs.fieldbyName('BARCODE').AsString+'''';

    if FGoodsCode='' then
      FGoodsCode:=''''+rs.fieldbyName('GODS_CODE').AsString+''''
    else
      FGoodsCode:=FGoodsCode+','+''''+rs.fieldbyName('GODS_CODE').AsString+'''';
    rs.Next;
  end;

  rs:=dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
  begin
    if FUnits='' then
      FUnits:=''''+rs.fieldbyName('UNIT_NAME').AsString+''''
    else
      FUnits:=FUnits+','+''''+rs.fieldbyName('UNIT_NAME').AsString+'''';
    rs.Next;
  end;

  rs:=dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
  rs.First;
  while not rs.Eof do
  begin
    if FSorts='' then
      FSorts:=''''+rs.fieldbyName('SORT_NAME').AsString+''''
    else
      FSorts:=FSorts+','+''''+rs.fieldbyName('SORT_NAME').AsString+'''';
    rs.Next;
  end;

end;

//条码、货号、商品名称、计量单位、商品分类、标准售价、最新进价、最低售价、本店售价
function TfrmExcelFactory.Check2: Boolean;
var rs:TZQuery;
    FieldName,str,strError:string;
    num:double;
    testUnits:Boolean;
begin
  rs:=TZQuery.Create(nil);
  cdsColumn.DisableControls;
  cdsExcel.First;
  while not cdsExcel.Eof do
  begin
    str:='';
    strError:='';
    testUnits:=false;
    RzStatus1.Caption := '数据检测:'+InttoStr(cdsExcel.RecNo)+'/'+InttoStr(cdsExcel.RecordCount);
    RzStatus1.Update;
    FDataSet.Append;
    cdsExcel.Edit;
    //************************条形码**********************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','BARCODE1',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'条形码为空；'
    else
      begin
        rs.Close;
        rs.SQL.Text:='select 1 as isExist from VIW_GOODSPRICEEXT where barcode='''+str+''' and barcode in ('+FBarcode+')';
        dataFactory.Open(rs);
        if not rs.IsEmpty then
           strError:=strError+'条形码已存在；'
        else
        begin
          FDataSet.FieldByName('BARCODE1').AsString:=str;
          if cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
            FieldName:=cdsColumn.fieldByName('FileName').AsString;
          str:=cdsExcel.fieldbyName(FieldName).AsString;
          if str='' then
            strError:=strError+'计量单位为空；'
          else
            begin
              rs.Close;
              rs.SQL.Text:='select 1 as isExist,UNIT_ID from VIW_MEAUNITS where UNIT_NAME='''+str+''' and UNIT_NAME in ('+FUnits+')';
              dataFactory.Open(rs);
              if rs.IsEmpty then
                strError:=strError+'计量单位不存在；'
              else
                FDataSet.FieldByName('CALC_UNITS').AsString:=rs.Fields[1].AsString;
            end;
          testUnits:=true;
        end;
      end;

    //***********************货号**************************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','GODS_CODE',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'货号为空；'
    else
      begin
        rs.Close;
        rs.SQL.Text:='select 1 as isExist from VIW_GOODSPRICEEXT where GODS_CODE='''+str+''' and GODS_CODE in ('+FGoodsCode+')';
        dataFactory.Open(rs);
        if not rs.IsEmpty then
           strError:=strError+'货号已存在；'
        else begin
          FDataSet.FieldByName('GODS_CODE').AsString:=str;
          if not testUnits then
          begin 
            if cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
              FieldName:=cdsColumn.fieldByName('FileName').AsString;
            str:=cdsExcel.fieldbyName(FieldName).AsString;
            if str='' then
              strError:=strError+'计量单位为空；'
            else
              begin
                rs.Close;
                rs.SQL.Text:='select 1 as isExist from VIW_MEAUNITS where UNIT_NAME='''+str+''' and UNIT_NAME in ('+FUnits+')';
                dataFactory.Open(rs);
                if rs.IsEmpty then
                  strError:=strError+'计量单位不存在；'
                else
                  FDataSet.FieldByName('CALC_UNITS').AsString:=str;
              end;
          end;
        end;
      end;

     //***************************商品名称****************************
     FieldName:='';
     if cdsColumn.Locate('FieldName','GODS_NAME',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'商品名称为空；'
    else
      FDataSet.FieldByName('GODS_NAME').AsString:=str;

     //************************商品分类************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','SORT_ID1',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'商品分类为空；'
    else
      begin
        rs.Close;
        rs.SQL.Text:='select 1 as isExist,SORT_ID from VIW_GOODSSORT where SORT_NAME='''+str+''' and SORT_NAME in ('+FSorts+')';
        dataFactory.Open(rs);
        if rs.IsEmpty then
           strError:=strError+'商品分类不存在；'
        else
           FDataSet.FieldByName('SORT_ID1').AsString:=rs.Fields[1].AsString;
      end;

     //************************标准售价************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','NEW_OUTPRICE',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'标准售价为空；'
    else
      begin
        try
          num:=strtofloat(str);
        except
          strError:=strError+'无效的标准售价；'
        end;
        FDataSet.FieldByName('NEW_OUTPRICE').AsFloat:=num;
      end;

     //***********************最新进价************************
     FieldName:='';
    if cdsColumn.Locate('FieldName','NEW_INPRICE',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'最新进价为空；'
    else
      begin
        try
          num:=strtofloat(str);
        except
          strError:=strError+'无效的最新进价；'
        end;
        FDataSet.FieldByName('NEW_INPRICE').AsFloat:=num;
      end;

     //*********************最低售价*************************
     FieldName:='';
    if cdsColumn.Locate('FieldName','NEW_LOWPRICE',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'最低售价为空；'
    else
      begin
        try
          num:=strtofloat(str);
        except
          strError:=strError+'无效的最低售价；'
        end;
        FDataSet.FieldByName('NEW_LOWPRICE').AsFloat:=num;
      end;

     //**********************本店售价************************
     FieldName:='';
    if cdsColumn.Locate('FieldName','MY_OUTPRICE',[]) then
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
    str:=cdsExcel.fieldbyName(FieldName).AsString;
    if str='' then
      strError:=strError+'本店售价为空；'
    else
      begin
        try
          num:=strtofloat(str);
        except
          strError:=strError+'无效的本店售价；'
        end;
        FDataSet.FieldByName('MY_OUTPRICE').AsFloat:=num;
      end;

    if strError<>'' then
    begin
       cdsExcel.FieldByName('STATE').AsString:='1';
       FDataSet.Delete;
    end
    else
    begin
       cdsExcel.FieldByName('STATE').AsString:='0';
       FDataSet.Post;
    end;
    cdsExcel.FieldByName('Msg').AsString:=strError;
    cdsExcel.Post;
    cdsExcel.Next;
  end;
  cdsColumn.EnableControls;

  cdsExcel.Filtered:=False;
  cdsExcel.Filter:='STATE=''1''';
  cdsExcel.Filtered:=True;
  FExceptCount:=cdsExcel.RecordCount;
  RzStatus2.Caption := '异常数据:'+inttostr(FExceptCount)+'条    总数据:'+inttostr(FSumCount)+'条';
  RzStatus2.Update;
  cdsExcel.Filtered:=False;
end;

procedure TfrmExcelFactory.CreateDbGridEhTitle;
var i:integer;
    FieldName:string;
begin
  for i:=1 to DBGridEh1.Columns.Count-1 do
  begin
    DBGridEh3.Columns[i+1].Title:=DBGridEh1.Columns[i].Title;
  end;
end;



procedure TfrmExcelFactory.Image4Click(Sender: TObject);
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
    //CopyFile(pchar(img),pchar(ExtractFilePath(Application.ExeName)+'built-in\images\user.png'),false);
    try
      CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\商品信息导入表.xls'),pchar(SaveDialog1.FileName),false)
    except
      MessageBox(Handle, Pchar('下载导入模板失败！'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

end.
