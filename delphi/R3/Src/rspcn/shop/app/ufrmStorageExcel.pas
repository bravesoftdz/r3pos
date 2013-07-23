unit ufrmStorageExcel;

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
    FieldCount=9;

type
  TfrmStorageExcel = class(TfrmExcelFactory)
    procedure RzLabel17Click(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):Boolean;override;
    function FindColumn2(vStr:string):Boolean;override;
    function SelfCheckExcute:Boolean;override;   //导入文件内部判断有无重复
    function OutCheckExcute:Boolean;             //导入文件与库中数据对比
    function DuplicateCheckExcute:Boolean;
    function Check(columnIndex:integer):Boolean;override;
    function CheckGodsCode(cs,ss:TZQuery;strList:TStringList;codeField:string;index:integer): Boolean;
    function SaveExcel(dsExcel:TZQuery):Boolean;override;
    function IsRequiredFiled(strFiled:string):Boolean;override;
    procedure ClearParams;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;override;
  end;

  const
    FieldsString =
    'BARCODE=条形码,GODS_CODE=货号,GODS_NAME=商品名称,CALC_UNITS=计量单位,AMOUNT=数量,BATCH_NO=批号,PROPERTY_01=颜色组,PROPERTY_02=尺码组';

    FormatString =
    '0=BARCODE,1=GODS_CODE,2=GODS_NAME,3=CALC_UNITS,5=AMOUNT,6=BATCH_NO,7=PROPERTY_01,8=PROPERTY_02';

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmStorageExcel.CreateUseDataSet;
begin
  inherited; 
  with DataSet.FieldDefs do
    begin
      Add('GODS_ID',ftString,36,False);
      Add('BARCODE',ftString,30,False);
      Add('GODS_CODE',ftString,20,False);
      Add('GODS_NAME',ftString,50,False);
      Add('CALC_UNITS',ftString,36,False);
      Add('AMOUNT',ftFloat,0,False);
      Add('BATCH_NO',ftString,36,False);
      Add('PROPERTY_01',ftString,36,False);
      Add('PROPERTY_02',ftString,36,False);
    end;
  DataSet.CreateDataSet;
end;

function TfrmStorageExcel.SaveExcel(dsExcel:TZQuery):Boolean;
var rs,cs,ss,bs:TZQuery;
    GodsId,Bar,Code,Name:String;
    Field:TField;
    strWhere:string;
begin
  try
    rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    cs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    bs:=TZQuery.Create(nil);

    ss.Close;
    ss.SQL.Text:='select GODS_ID,AMOUNT,BATCH_NO,PROPERTY_01,PROPERTY_02 from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+'''';
    dataFactory.Open(ss);

    //批号
    if (cdsColumn.Locate('FieldName','BATCH_NO',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      bs.Close;
      bs.SQL.Text:='select BATCH_NO,BATCH_NAME from PUB_BATCH_NO where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') ';
      dataFactory.Open(cs);
    end;

    strWhere:='';
    if strWhere <> '' then
    begin
      cs.Close;
      cs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE in('+strWhere+') and COMM not in (''02'',''12'') ';
      dataFactory.Open(cs);
    end;

    dsExcel.First;
    while not dsExcel.Eof do
    begin
      Field:=dsExcel.FindField('BARCODE');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if rs.Locate('BARCODE',dsExcel.fieldByName('BARCODE').AsString,[]) then
        begin
          dsExcel.FieldByName('GODS_ID').AsString:=rs.fieldByName('GODS_ID').AsString;
        end;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('AMOUNT');
      if (Field <> nil) and (Field.AsString <> '') then
      begin
        dsExcel.Edit;
        if ss.Locate('GODS_ID',dsExcel.fieldByName('GODS_ID').AsString,[]) then
        begin
          dsExcel.FieldByName('AMOUNT').AsFloat:=ss.fieldByName('AMOUNT').AsFloat-dsExcel.FieldByName('AMOUNT').AsFloat;
        end else
        begin
          dsExcel.FieldByName('AMOUNT').AsFloat:=-dsExcel.FieldByName('AMOUNT').AsFloat;
        end;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('BATCH_NO');
      if (Field <> nil) then
      begin
        dsExcel.Edit;
        if Field.AsString='' then
          dsExcel.FieldByName('BATCH_NO').AsString:='#'
        else begin
          if bs.Locate('GODS_ID',dsExcel.fieldByName('GODS_ID').AsString,[]) then
            dsExcel.FieldByName('BATCH_NO').AsString:=bs.fieldByName('BATCH_NO').AsString;
        end;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('PROPERTY_01');
      if (Field <> nil) then
      begin
        dsExcel.Edit;
        if Field.AsString='' then
          dsExcel.FieldByName('PROPERTY_01').AsString:='#'
        else begin

        end;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('PROPERTY_02');
      if (Field <> nil) then
      begin
        dsExcel.Edit;
        if Field.AsString='' then
          dsExcel.FieldByName('PROPERTY_02').AsString:='#'
        else begin

        end;
        dsExcel.Post;
      end;
      dsExcel.Next;
    end;
  finally
    cs.Free;
    ss.Free;
    bs.Free;
  end;
  Result := True;
end;

function TfrmStorageExcel.FindColumn(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if not cdsColumn.Locate('FieldName','BARCODE',[]) then
  begin
    Result := False;
    strError:='条形码';
  end;
  if not cdsColumn.Locate('FieldName','GODS_CODE',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'货号'
    else
      strError:='货号';
  end;
  if not cdsColumn.Locate('FieldName','GODS_NAME',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'商品名称'
    else
    strError:='商品名称';
  end;
  if not cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'计量单位'
    else
    strError:='计量单位';
  end;
  if not cdsColumn.Locate('FieldName','AMOUNT',[]) then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'数量'
    else
    strError:='数量';
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('缺少'+strError+'字段对应关系，请检查对应关系设置或导入文件！');
  end;
end;

function TfrmStorageExcel.FindColumn2(vStr:string):Boolean;
var strError:string;
begin
   Result := True;
   strError:='';
  if (cdsColumn.Locate('FieldName','BARCODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    strError:='条形码';
  end;
  if (cdsColumn.Locate('FieldName','GODS_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'货号'
    else
      strError:='货号';
  end;
  if (cdsColumn.Locate('FieldName','GODS_NAME',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'商品名称'
    else
    strError:='商品名称';
  end;
  if (cdsColumn.Locate('FieldName','CALC_UNITS',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'计量单位'
    else
    strError:='计量单位';
  end;
  if (cdsColumn.Locate('FieldName','AMOUNT',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
  begin
    Result := False;
    if strError<>'' then
      strError:=strError+'、'+'数量'
    else
    strError:='数量';
  end;

  if (strError<>'') then
  begin
    cdsColumn.RecNo:=LastcdsColumnIndex;
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    Raise Exception.Create('缺少'+strError+'字段对应关系，请检查对应关系设置或导入文件！');
  end;
end;

procedure TfrmStorageExcel.CreateParams;
var rs:TZQuery;
    str:string;
    i:integer;
begin
  inherited;
end;

function TfrmStorageExcel.Check(columnIndex:integer): Boolean;
var str,strError,fieldName:string;
    num:double;
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
          strError:='条形码不存在;';
         end;
       end;
    1:begin
         if (isNull) and (str='') then
         strError:='条形码、货号为空;';
       end;
    2:begin
       if str='' then
         strError:='商品名称为空;';
      end;
    3:begin
       if str='' then
         strError:='计量单位为空;';
      end;
    4:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='数量为空;';
         except
          strError:='无效的数量值;'
        end;
      end;
    5:begin     //BATCH_NO
      end;
    6:begin     //Color
      end;
    7:begin    //size
      end;
  end;
  if strError<>'' then
  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+strError;

  result:=true;
end;

procedure TfrmStorageExcel.ClearParams;
var i:integer;
begin
  for i:=0 to FieldCount do
    FieldCheckSet[i]:='';
end;

function TfrmStorageExcel.SelfCheckExcute: Boolean;
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
        if (fieldName='BARCODE') or (fieldName='GODS_CODE') or (fieldName='BATCH_NO')  then
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
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'与第'+inttostr(preId)+'条数据'+cdsColumn.fieldByName('DestTitle').asstring+'重复;';
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
    OutCheckExcute;
    DuplicateCheckExcute;
  finally
    rs.Free;
  end;
end;

function TfrmStorageExcel.OutCheckExcute: Boolean;
var rs,ss,cs:TZQuery;
    FieldName,FieldName2,CodeField,UintField,strUnit,strError:string;
    i,c,FieldIndex:integer;
    strWhere,strWhere2,codeWhere:string;
    strList,codeList:TStringList;
    isHas:Boolean;
begin
  try
    rs:=TZQuery.Create(nil);
    ss:=TZQuery.Create(nil);
    cs:=TZQuery.Create(nil);
    ss.Data:=cdsExcel.Data;

    //*********************条码*****************************
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
                  'where VB.tenant_id='+token.tenantId+' and VB.comm not in(''02'',''12'') and VG.comm not in(''02'',''12'') and VB.BARCODE_TYPE=0 and VB.barcode in ('+strWhere+')';
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
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'条码不存在;';
                cdsExcel.Post;
              end;
              if ss.fieldByName(CodeField).AsString<>'' then
                TransformtoString(FieldCheckSet[c],ss.FieldByName(CodeField).AsString);
              ss.Next;
            end;
            ss.Filtered:=false;
            FieldCheckSet[c]:=DeleteDuplicateString(FieldCheckSet[c],codeList);

            CheckGodsCode(cs,ss,codeList,CodeField,c);
          end else //if rs.Locate('barcode',strList[i],[]) then rs中能定位到barcode
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+strList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              //用GODS_ID来写CODE是为了数据唯一性判断
              cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
              cdsExcel.Edit;
              cdsExcel.FieldByName('CODE').AsString:=rs.fieldbyName('GODS_ID').AsString;
              cdsExcel.Post;
              //计量单位
              if (cdsColumn.Locate('FieldName','CALC_UNITS',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                UintField:=cdsColumn.fieldByName('FileName').AsString;
                strUnit:=ss.fieldByName(UintField).AsString;
                if strUnit<> '' then
                begin
                  if (not rs.Locate('CALC_UNITS_NAME',strUnit,[])) then
                  begin
                      cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                      cdsExcel.Edit;
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该计量单位;';
                      cdsExcel.Post;
                  end;
                end;
              end;
              //批号
              if (cdsColumn.Locate('FieldName','BATCH_NO',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                FieldName2:=cdsColumn.fieldByName('FileName').AsString;
                if ss.FieldByName(FieldName2).AsString<>'' then
                begin
                  rs.Locate('barcode',strList[i],[]);
                  if rs.FieldByName('USING_BATCH_NO').AsString='1' then
                  begin
                    cs.Close;
                    cs.SQL.Text:='select BATCH_NAME from PUB_BATCH_NO where tenant_id='+token.tenantId+
                                 ' and comm not in(''02'',''12'') and GODS_ID='''+rs.fieldByName('GODS_ID').AsString+'''';
                    dataFactory.Open(cs);
                    if cs.IsEmpty then
                    begin
                      cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                      cdsExcel.Edit;
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该批号;';
                      cdsExcel.Post;
                    end;
                  end else
                  begin
                    cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                    cdsExcel.Edit;
                    cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有启用批号;';
                    cdsExcel.Post;
                  end;
                end;
              end;
              //颜色
              if (cdsColumn.Locate('FieldName','PROPERTY_01',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                isHas:=false;
                FieldName2:=cdsColumn.fieldByName('FileName').AsString;
                if ss.FieldByName(FieldName2).AsString<>'' then
                begin
                  rs.Locate('barcode',strList[i],[]);
                  if rs.FieldByName('SORT_ID7').AsString<>'' then
                  begin
                    cs.Close;
                    cs.SQL.Text:='select COLOR_ID,COLOR_NAME,SORT_ID7S from VIW_COLOR_INFO where tenant_id='+token.tenantId+
                                 ' and comm not in(''02'',''12'') and COLOR_NAME='''+ss.FieldByName(FieldName2).AsString+'''';
                    dataFactory.Open(cs);
                    if not cs.IsEmpty then
                    begin
                      if pos(rs.fieldByName('SORT_ID7').AsString,cs.FieldByName('SORT_ID7S').AsString)<=0 then
                      begin
                        isHas:=true;
                      end;
                    end else
                      isHas:=true;
                  end else
                  begin
                    isHas:=true;
                  end;
                end;
                if isHas then
                begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该颜色组;';
                  cdsExcel.Post;
                end;
              end;
              //尺码
              if (cdsColumn.Locate('FieldName','PROPERTY_02',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
              begin
                isHas:=false;
                FieldName2:=cdsColumn.fieldByName('FileName').AsString;
                if ss.FieldByName(FieldName2).AsString<>'' then
                begin
                  rs.Locate('barcode',strList[i],[]);
                  if rs.FieldByName('SORT_ID8').AsString<>'' then
                  begin
                    cs.Close;
                    cs.SQL.Text:='select SIZE_ID,SIZE_NAME,SORT_ID8S from VIW_SIZE_INFO where tenant_id='+token.tenantId+
                                 ' and comm not in(''02'',''12'') and SIZE_NAME='''+ss.FieldByName(FieldName2).AsString+'''';
                    dataFactory.Open(cs);
                    if not cs.IsEmpty then
                    begin
                      if pos(rs.fieldByName('SORT_ID8').AsString,cs.FieldByName('SORT_ID8S').AsString)<=0 then
                      begin
                        isHas:=true;
                      end;
                    end else
                      isHas:=true;
                  end else
                  begin
                    isHas:=true;
                  end;
                end;
                if isHas then
                begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该尺码组;';
                  cdsExcel.Post;
                end;
              end;
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
        CheckGodsCode(cs,ss,codeList,CodeField,c);
      end;
    end;

  finally
    rs.Free;
    ss.Free;
  end;
end;

function TfrmStorageExcel.CheckGodsCode(cs,ss:TZQuery;strList:TStringList;codeField:string;index:integer): Boolean;
var strCode,strUnit,UintField:string;
    j:integer;
    FieldName2:string;
    isHas:Boolean;
    gs:TZQuery;
    strLog:TStringList;
begin
  gs:=TZQuery.Create(nil);
  //***********************货号***********************
  cs.Close;
  cs.SQL.Text:=
              'select distinct VG.GODS_CODE,VG.GODS_ID,VM1.UNIT_NAME CALC_UNITS_NAME,VG.USING_BATCH_NO,VG.SORT_ID7,VG.SORT_ID8 '+
              'from VIW_GOODSPRICEEXT VG '+
              'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.CALC_UNITS=VM1.UNIT_ID '+
              'where VG.tenant_id='+token.tenantId+' and VG.comm not in(''02'',''12'') and VG.GODS_CODE in ('+FieldCheckSet[index]+')';
  dataFactory.Open(cs);

  strCode:=codeField;
  if not cs.IsEmpty then   //通过货号都在库中找到
  begin
    FieldType[index]:=1;
    for j:=0 to strList.Count-1 do
    begin
      if not cs.Locate('GODS_CODE',strList[j],[]) then
      begin
        ss.Filtered:=false;
        ss.Filter:=strCode+'='''+strList[j]+'''';
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
        ss.Filter:=strCode+'='''+strList[j]+'''';
        ss.Filtered:=true;
        ss.First;
        while not ss.Eof do
        begin
          //用GODS_ID来写CODE是为了数据唯一性判断
          cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
          cdsExcel.Edit;
          cdsExcel.FieldByName('CODE').AsString:=cs.fieldbyName('GODS_ID').AsString;
          cdsExcel.Post;
          if (cdsColumn.Locate('FieldName','CALC_UNITS',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
          begin
            UintField:=cdsColumn.fieldByName('FileName').AsString;
            strUnit:=ss.fieldByName(UintField).AsString;
            if strUnit<> '' then
            begin
              if (not cs.Locate('CALC_UNITS_NAME',strUnit,[])) then
              begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该计量单位;';
                  cdsExcel.Post;
              end;
            end;
          end;
          //批号
          if (cdsColumn.Locate('FieldName','BATCH_NO',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
          begin
            FieldName2:=cdsColumn.fieldByName('FileName').AsString;
            if ss.FieldByName(FieldName2).AsString<>'' then
            begin
              cs.Locate('GODS_CODE',strList[j],[]);
              if cs.FieldByName('USING_BATCH_NO').AsString='1' then
              begin
                gs.Close;
                gs.SQL.Text:='select BATCH_NAME from PUB_BATCH_NO where tenant_id='+token.tenantId+
                             ' and comm not in(''02'',''12'') and GODS_ID='''+cs.fieldByName('GODS_ID').AsString+'''';
                dataFactory.Open(gs);
                if ss.IsEmpty then
                begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该批号;';
                  cdsExcel.Post;
                end;
              end else
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有启用批号;';
                cdsExcel.Post;
              end;
            end;
          end;
          //颜色
          if (cdsColumn.Locate('FieldName','PROPERTY_01',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
          begin
            isHas:=false;
            FieldName2:=cdsColumn.fieldByName('FileName').AsString;
            if ss.FieldByName(FieldName2).AsString<>'' then
            begin
              cs.Locate('GODS_CODE',strList[j],[]);
              if cs.FieldByName('SORT_ID7').AsString<>'' then
              begin
                gs.Close;
                gs.SQL.Text:='select COLOR_ID,COLOR_NAME,SORT_ID7S from VIW_COLOR_INFO where tenant_id='+token.tenantId+
                             ' and comm not in(''02'',''12'') and COLOR_NAME='''+ss.FieldByName(FieldName2).AsString+'''';
                dataFactory.Open(gs);
                if not cs.IsEmpty then
                begin
                  if pos(cs.fieldByName('SORT_ID7').AsString,gs.FieldByName('SORT_ID7S').AsString)<=0 then
                  begin
                    isHas:=true;
                  end;
                end else
                  isHas:=true;
              end else
              begin
                isHas:=true;
              end;
            end;
            if isHas then
            begin
              cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
              cdsExcel.Edit;
              cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该颜色组;';
              cdsExcel.Post;
            end;
          end;
          //尺码
          if (cdsColumn.Locate('FieldName','PROPERTY_02',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
          begin
            isHas:=false;
            FieldName2:=cdsColumn.fieldByName('FileName').AsString;
            if ss.FieldByName(FieldName2).AsString<>'' then
            begin
              cs.Locate('GODS_CODE',strList[j],[]);
              if cs.FieldByName('SORT_ID8').AsString<>'' then
              begin
                gs.Close;
                gs.SQL.Text:='select SIZE_ID,SIZE_NAME,SORT_ID8S from VIW_SIZE_INFO where tenant_id='+token.tenantId+
                             ' and comm not in(''02'',''12'') and SIZE_NAME='''+ss.FieldByName(FieldName2).AsString+'''';
                dataFactory.Open(gs);
                if not cs.IsEmpty then
                begin
                  if pos(cs.fieldByName('SORT_ID8').AsString,gs.FieldByName('SORT_ID8S').AsString)<=0 then
                  begin
                    isHas:=true;
                  end;
                end else
                  isHas:=true;
              end else
              begin
                isHas:=true;
              end;
            end;
            if isHas then
            begin
              cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
              cdsExcel.Edit;
              cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'商品没有设置该尺码组;';
              cdsExcel.Post;
            end;
          end;
          ss.Next;
        end;
        ss.Filtered:=false;
      end;
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
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'货号不存在;';
        cdsExcel.Post;
        ss.Next;
      end;
      ss.Filtered:=false;
    end
  end;
end;

function TfrmStorageExcel.DuplicateCheckExcute: Boolean;
var strPre,strNext:string;
    strIndex:integer;
begin
  result:=false;
  cdsExcel.DisableControls;
  //只判断写CODE的数据条
  cdsExcel.Filtered:=false;
  cdsExcel.Filter:='CODE<>''''';
  cdsExcel.Filtered:=true;
  //按CODE字段排序
  cdsExcel.SortedFields:='CODE';

  cdsExcel.First;
  strPre:=cdsExcel.fieldByName('CODE').AsString;
  strIndex:=cdsExcel.fieldByName('ID').AsInteger;
  cdsExcel.Next;
  while not cdsExcel.Eof do
  begin
    strNext:=cdsExcel.fieldByName('CODE').AsString;
    if strPre=strNext then
    begin
      cdsExcel.Edit;
      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'与第'+inttostr(strIndex)+'条数据指向同一商品，请确认条码、货号是否统一;';
      cdsExcel.Post;
    end else
    begin
      strPre:=strNext;
      strIndex:=cdsExcel.fieldByName('ID').AsInteger;
    end;
    cdsExcel.Next;
  end;
  cdsExcel.SortedFields:='ID';
  cdsExcel.Filtered:=false;
  cdsExcel.EnableControls;
  result:=true;
end;

class function TfrmStorageExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmStorageExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--库存';
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

procedure TfrmStorageExcel.RzLabel17Click(Sender: TObject);
begin
  inherited;
   if MessageBox(Handle,pchar('是否要下载库存导入模板？'),'友情提示..',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then exit;
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\库存导入表.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\库存导入表.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('没有找到导入模板！'), '友情提示..', MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('下载导入模板失败！'), '友情提示..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmStorageExcel.IsRequiredFiled(strFiled: string): Boolean;
begin
  result:=false;
  if (strFiled='BARCODE') or (strFiled='GODS_CODE') or (strFiled='GODS_NAME') or
     (strFiled='CALC_UNITS') or (strFiled='AMOUNT') then
    result:=true;  
end;

end.
