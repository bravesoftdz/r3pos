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
    function CheckGodsCode(cs,ss:TZQuery;strList:TStringList;codeField:string;index:integer): Boolean;
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
    'BARCODE=������,GODS_CODE=����,GODS_NAME=��Ʒ����,CALC_UNITS=������λ,AMOUNT=����,BATCH_NO=����,PROPERTY_01=��ɫ��,PROPERTY_02=������';

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
var DsGoods,rs,cs,ss:TZQuery;
    GodsId,Bar,Code,Name:String;
    Field:TField;
    strWhere:string;
begin
  try
    rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    cs:=TZQuery.Create(nil);

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
          dsExcel.FieldByName('GODS_ID').AsString:=rs.fieldByName('GODS_ID').AsString;
        dsExcel.Post;
      end;

      Field:=dsExcel.FindField('BATCH_NO');
      if (Field <> nil) then
      begin
        dsExcel.Edit;
        if Field.AsString='' then
          dsExcel.FieldByName('BATCH_NO').AsString:='#'
        else begin

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
  end;
  Result := True;
end;

function TfrmStorageExcel.FindColumn(vStr:string):Boolean;
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
         strError:='������λΪ��;';
      end;
    4:begin
        try
          if str<>'' then
            num:=strtofloat(str)
          else
            strError:='����Ϊ��;';
         except
          strError:='��Ч������ֵ;'
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
      if fieldName <> '' then
      begin
        if (fieldName='BARCODE') or (fieldName='GODS_CODE') or (fieldName='BATCH_NO')  then
        begin
          if (fieldName='BARCODE') or (fieldName='GODS_CODE') then
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
              end;
              strPre:=strNext;
              preID:=rs.fieldByName('ID').AsInteger;
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

    //*********************����*****************************
    FieldName:='';
    if cdsColumn.Locate('FieldName','BARCODE',[]) then
    begin
      FieldName:=cdsColumn.fieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.SQL.Text:=
                  'select VG.BARCODE,VG.GODS_ID,VM1.UNIT_NAME CALC_UNITS_NAME,VG.USING_BATCH_NO,VG.SORT_ID7,VG.SORT_ID8 '+
                  'from VIW_GOODSPRICEEXT VG '+
                  'left join VIW_MEAUNITS VM1 on VG.TENANT_ID=VM1.TENANT_ID and VG.CALC_UNITS=VM1.UNIT_ID '+
                  'where VG.tenant_id='+token.tenantId+' and VG.comm not in(''02'',''12'') and VG.barcode in ('+strWhere+')';
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
            DeleteDuplicateString(FieldCheckSet[c],codeList);

            CheckGodsCode(cs,ss,codeList,CodeField,c);
          end else //if rs.Locate('barcode',strList[i],[]) then rs���ܶ�λ��barcode
          begin
            ss.Filtered:=false;
            ss.Filter:=FieldName+'='''+strList[i]+'''';
            ss.Filtered:=true;
            ss.First;
            while not ss.Eof do
            begin
              //������λ
              if cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
              begin
                UintField:=cdsColumn.fieldByName('FileName').AsString;
                strUnit:=ss.fieldByName(UintField).AsString;
                if strUnit<> '' then
                begin
                  if (not rs.Locate('CALC_UNITS_NAME',strUnit,[])) then
                  begin
                      cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                      cdsExcel.Edit;
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øü�����λ;';
                      cdsExcel.Post;
                  end;
                end;
              end;
              //����
              if cdsColumn.Locate('FieldName','BATCH_NO',[]) then
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
                      cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����ø�����;';
                      cdsExcel.Post;
                    end;
                  end else
                  begin
                    cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                    cdsExcel.Edit;
                    cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû����������;';
                    cdsExcel.Post;
                  end;
                end;
              end;
              //��ɫ
              if cdsColumn.Locate('FieldName','PROPERTY_01',[]) then
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
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����ø���ɫ��;';
                  cdsExcel.Post;
                end;
              end;
              //����
              if cdsColumn.Locate('FieldName','PROPERTY_02',[]) then
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
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øó�����;';
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
        DeleteDuplicateString(FieldCheckSet[c],codeList);
        cdsColumn.Locate('FieldName','GODS_CODE',[]);
        CodeField:=cdsColumn.fieldByName('FileName').AsString;
        c:=cdsColumn.FieldByName('ID').AsInteger;
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
begin
  gs:=TZQuery.Create(nil);
  //***********************����***********************
  cs.Close;
  cs.SQL.Text:=
              'select distinct GODS_CODE,GODS_ID,VM1.UNIT_NAME CALC_UNITS_NAME,VG.USING_BATCH_NO,VG.SORT_ID7,VG.SORT_ID8 '+
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
          cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���Ų�����;';
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
          if cdsColumn.Locate('FieldName','CALC_UNITS',[]) then
          begin
            UintField:=cdsColumn.fieldByName('FileName').AsString;
            strUnit:=ss.fieldByName(UintField).AsString;
            if strUnit<> '' then
            begin
              if (not cs.Locate('CALC_UNITS_NAME',strUnit,[])) then
              begin
                  cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                  cdsExcel.Edit;
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øü�����λ;';
                  cdsExcel.Post;
              end;
            end;
          end;
          //����
          if cdsColumn.Locate('FieldName','BATCH_NO',[]) then
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
                  cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����ø�����;';
                  cdsExcel.Post;
                end;
              end else
              begin
                cdsExcel.Locate('ID',ss.fieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû����������;';
                cdsExcel.Post;
              end;
            end;
          end;
          //��ɫ
          if cdsColumn.Locate('FieldName','PROPERTY_01',[]) then
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
              cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����ø���ɫ��;';
              cdsExcel.Post;
            end;
          end;
          //����
          if cdsColumn.Locate('FieldName','PROPERTY_02',[]) then
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
              cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'��Ʒû�����øó�����;';
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
        cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'���Ų�����;';
        cdsExcel.Post;
        ss.Next;
      end;
      ss.Filtered:=false;
    end
  end;
end;

class function TfrmStorageExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: Boolean): Boolean;
begin
  with TfrmStorageExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--���浥';
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
procedure TfrmStorageExcel.CreateStringList(var vList: TStringList);
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

procedure TfrmStorageExcel.TransformtoString(vList: TStringList;var vStr:wideString);
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

procedure TfrmStorageExcel.Image4Click(Sender: TObject);
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
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ��浼���.xls') then
        CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\��Ʒ��浼���.xls'),pchar(SaveDialog1.FileName),false)
      else
        MessageBox(Handle, Pchar('û���ҵ�����ģ�壡'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('���ص���ģ��ʧ�ܣ�'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmStorageExcel.DeleteDuplicateString(vStr: string;var vStrList:TStringList): string;
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

procedure TfrmStorageExcel.TransformtoString(var vList: string;
  vStr: string);
begin
  if (vList='')  then
    if ((vList='') and (vStr='')) then
      vList:=vList+','
    else
      vList:=vStr
  else
    vList:=vList+','+vStr;
end;

end.
