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
  Menus, RzPrgres;

const FieldCount=25;

type
  TfrmCustomerExcel = class(TfrmExcelFactory)
    procedure RzLabel17Click(Sender: TObject);
  private
    FieldCheckSet:array[0..FieldCount] of string;
    FieldType:array [0..FieldCount] of integer;
    procedure CreateUseDataSet;override;
    procedure CreateParams;override;
    function FindColumn(vStr:string):boolean;override;
    function FindColumn2(vStr:string):boolean;override;
    function SelfCheckExcute:boolean;override;   //导入文件内部判断有无重复
    function OutCheckExcute:boolean;             //导入文件与库中数据对比
    function Check(columnIndex:integer):boolean;override;
    function SaveExcel(dsExcel:TZQuery):boolean;override;
    function IsRequiredFiled(strFiled:string):boolean;override;
    procedure ClearParams;
  public
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:boolean=false):boolean;override;
  end;

const
  FieldsString =
    'CUST_CODE=会员卡号,CUST_NAME=会员名称,PRICE_ID=会员等级,SEX=性别,REGION_ID=地区,'+
    'SHOP_ID=入会门店,MOVE_TELE=移动电话,BIRTHDAY=会员生日,FAMI_ADDR=地址,POSTALCODE=邮编,ID_NUMBER=证件号码,IDN_TYPE=证件类型,SND_DATE=入会日期,'+
    'CON_DATE=续会日期,QQ=QQ,MSN=MSN,END_DATE=有效截止日期,MONTH_PAY=月收入,DEGREES=学历,EMAIL=电子邮件,OFFI_TELE=办公电话,FAMI_TELE=家庭电话,'+
    'OCCUPATION=职业,JOBUNIT=工作单位,REMARK=备注,INTEGRAL=积分';

  FormatString =
    '0=CUST_CODE,1=CUST_NAME,2=PRICE_ID,3=SEX,4=REGION_ID,5=SHOP_ID,6=MOVE_TELE,7=BIRTHDAY,8=FAMI_ADDR,'+
    '9=POSTALCODE,10=ID_NUMBER,11=IDN_TYPE,12=SND_DATE,13=CON_DATE,14=QQ,15=MSN,16=END_DATE,17=MONTH_PAY,18=DEGREES,19=EMAIL,20=OFFI_TELE,'+
    '21=FAMI_TELE,22=OCCUPATION,23=JOBUNIT,24=REMARK,25=INTEGRAL';

implementation

uses udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits,EncDec;

{$R *.dfm}

procedure TfrmCustomerExcel.CreateUseDataSet;
begin
  inherited; 
end;

function TfrmCustomerExcel.SaveExcel(dsExcel:TZQuery):boolean;
var
  Field:TField;
  ss,ps,pr,cs:TZQuery;
  str:string;
  strWhere:string;
begin
  if dsExcel.RecordCount=0 then Exit;
  ProgressBar1.Visible:=true;
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
      ProgressBar1.Percent:=round(dsExcel.RecNo/dsExcel.RecordCount*100);
      ProgressBar1.Update;
      dsExcel.Edit;
      dsExcel.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      dsExcel.FieldByName('CUST_ID').AsString  := TSequence.NewId;
      dsExcel.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
      dsExcel.FieldByName('CREA_USER').AsString := token.userId;
      dsExcel.FieldByName('PASSWRD').AsString := EncStr('1234',ENC_KEY);     //'79415A40'
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
           if Field.AsString='男' then
              str:='1'
           else if Field.AsString='女' then
              str:='0'
           else
              str:='2';
           dsExcel.Edit;
           dsExcel.FieldByName('SEX').AsString:=str;
           dsExcel.Post;
         end
      else
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('SEX').AsString:='2';
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('SHOP_ID');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           if ss.Locate('SHOP_NAME',dsExcel.FieldByName('SHOP_ID').AsString,[]) then
              begin
                dsExcel.Edit;
                dsExcel.FieldByName('SHOP_ID').AsString:=ss.FieldByName('SHOP_ID').AsString;
                dsExcel.Post;
              end;
         end
      else
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('SHOP_ID').AsString:=token.shopId;
           dsExcel.Post;
         end;

      dsExcel.Edit;
      dsExcel.FieldByName('SORT_ID').AsString:='#';
      dsExcel.Post;

      Field:=dsExcel.FindField('PRICE_ID');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           if ps.Locate('PRICE_NAME',dsExcel.FieldByName('PRICE_ID').AsString,[]) then
              begin
                dsExcel.Edit;
                dsExcel.FieldByName('PRICE_ID').AsString:=ps.FieldByName('PRICE_ID').AsString;
                dsExcel.Post;
              end
           else
              begin
                dsExcel.Edit;
                dsExcel.FieldByName('PRICE_ID').AsString:='#';
                dsExcel.Post;
              end;
         end;

      Field:=dsExcel.FindField('REGION_ID');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           if pr.Locate('CODE_NAME',dsExcel.FieldByName('REGION_ID').AsString,[]) then
              dsExcel.FieldByName('REGION_ID').AsString:=pr.FieldByName('CODE_ID').AsString
           else
              begin
                if ss.FieldByName('REGION_ID').AsString = '' then
                   dsExcel.FieldByName('REGION_ID').AsString:='#'
                else
                   dsExcel.FieldByName('REGION_ID').AsString:=ss.FieldByName('REGION_ID').AsString;
              end;
           dsExcel.Post;
         end
      else
         begin
           dsExcel.Edit;
           if ss.FieldByName('REGION_ID').AsString = '' then
              dsExcel.FieldByName('REGION_ID').AsString:='#'
           else
              dsExcel.FieldByName('REGION_ID').AsString:=ss.FieldByName('REGION_ID').AsString;
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('IDN_TYPE');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           if cs.Locate('CODE_NAME',dsExcel.FieldByName('IDN_TYPE').AsString,[]) then
              dsExcel.FieldByName('IDN_TYPE').AsString:=cs.FieldByName('CODE_ID').AsString
           else
              dsExcel.FieldByName('IDN_TYPE').AsString:='';
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('DEGREES');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           if cs.Locate('CODE_NAME',dsExcel.FieldByName('DEGREES').AsString,[]) then
              dsExcel.FieldByName('DEGREES').AsString:=cs.FieldByName('CODE_ID').AsString
           else
              dsExcel.FieldByName('DEGREES').AsString:='';
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('MONTH_PAY');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           if cs.Locate('CODE_NAME',dsExcel.FieldByName('MONTH_PAY').AsString,[]) then
              dsExcel.FieldByName('MONTH_PAY').AsString:=cs.FieldByName('CODE_ID').AsString
           else
              dsExcel.FieldByName('MONTH_PAY').AsString:='';
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('OCCUPATION');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           if cs.Locate('CODE_NAME',dsExcel.FieldByName('OCCUPATION').AsString,[]) then
              dsExcel.FieldByName('OCCUPATION').AsString:=cs.FieldByName('CODE_ID').AsString
           else
              dsExcel.FieldByName('OCCUPATION').AsString:='';
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('BIRTHDAY');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('BIRTHDAY').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.FieldByName('BIRTHDAY').AsString));
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('SND_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('SND_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.FieldByName('SND_DATE').AsString));
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('CON_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('CON_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.FieldByName('CON_DATE').AsString));
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('END_DATE');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('END_DATE').AsString:=FormatDateTime('YYYY-MM-DD',fntime.fnStrtoDate(dsExcel.FieldByName('END_DATE').AsString));
           dsExcel.Post;
         end;

      Field:=dsExcel.FindField('INTEGRAL');
      if (Field <> nil) and (Field.AsString <> '') then
         begin
           dsExcel.Edit;
           dsExcel.FieldByName('INTEGRAL').AsFloat:=dsExcel.FieldByName('INTEGRAL').AsFloat;
           dsExcel.FieldByName('ACCU_INTEGRAL').AsFloat:=dsExcel.FieldByName('INTEGRAL').AsFloat;
           dsExcel.Post;
         end;

      dsExcel.Next;
    end;

    try
      dataFactory.UpdateBatch(dsExcel,'TCustomerV60');
    except
      ProgressBar1.Visible:=false;
      Raise;
    end; 

  finally
    cs.Free;
    ProgressBar1.Visible:=false;
  end;

  result := true;
end;

function TfrmCustomerExcel.FindColumn(vStr:string):boolean;
var strError:string;
begin
  result := true;
  strError:='';

  if not cdsColumn.Locate('FieldName','CUST_CODE',[]) then
     begin
       result := False;
       strError:='会员卡号';
     end;

  if not cdsColumn.Locate('FieldName','CUST_NAME',[]) then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'会员名称'
       else
          strError:='会员名称';
     end;

  if not cdsColumn.Locate('FieldName','SHOP_ID',[]) then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'入会门店'
       else
          strError:='入会门店';
     end;

  if not cdsColumn.Locate('FieldName','SEX',[]) then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'性别'
       else
          strError:='性别';
     end;

  if not cdsColumn.Locate('FieldName','PRICE_ID',[]) then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'会员等级'
       else
          strError:='会员等级';
     end;

  if not cdsColumn.Locate('FieldName','REGION_ID',[]) then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'地区'
       else
          strError:='地区';
     end;

  if strError<>'' then
     begin
       cdsColumn.RecNo:=LastcdsColumnIndex;
       cdsColumn.EnableControls;
       cdsExcel.EnableControls;
       Raise Exception.Create('缺少'+strError+'字段对应关系，请检查对应关系设置或导入文件！');
     end;
end;

function TfrmCustomerExcel.FindColumn2(vStr:string):boolean;
var strError:string;
begin
  result := true;
  strError:='';
  if (cdsColumn.Locate('FieldName','CUST_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
     begin
       result := False;
       strError:='会员卡号';
     end;

  if (cdsColumn.Locate('FieldName','CUST_NAME',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'会员名称'
       else
          strError:='会员名称';
     end;

  if (cdsColumn.Locate('FieldName','PRICE_ID',[])) and (cdsColumn.FieldByName('FileName').AsString='') then
     begin
       result := False;
       if strError<>'' then
          strError:=strError+'、'+'会员等级'
       else
          strError:='会员等级';
     end;

  if strError<>'' then
     begin
       cdsColumn.RecNo:=LastcdsColumnIndex;
       cdsColumn.EnableControls;
       cdsExcel.EnableControls;
       Raise Exception.Create('缺少'+strError+'字段对应关系，请检查对应关系设置或导入文件！');
     end;
end;

procedure TfrmCustomerExcel.CreateParams;
begin
  inherited;
end;

function TfrmCustomerExcel.Check(columnIndex:integer): boolean;
var
  str,strError,FieldName:string;
begin
  strError:='';
  FieldName:=cdsColumn.FieldByName('FileName').AsString;
  str:=cdsExcel.FieldByName(FieldName).AsString;
  case columnIndex of
    0: begin
         if str='' then
            strError:='会员卡号为空;';
       end;
    1: begin
         if str='' then
            strError:='会员名称为空;';
       end;
    2: begin
         if str='' then
            strError:='拼音码为空;';
       end;
    3: begin
         if str='' then
            strError:='性别为空;';
       end;
    4: begin
         // if str='' then
         // strError:='会员类别为空;';
       end;
    5: begin
         if (str<>'') and (FieldType[5]=0) then
            strError:='会员等级不存在;';
       end;
    6: begin
         //if str='' then
         //  strError:='地区为空;'
         //else if FieldType[6]=0 then
         //  strError:='地区不存在;';
       end;
    7: begin
         //if str='' then
         //  strError:='入会门店为空;'
         //else if FieldType[7]=0 then
         //  strError:='入会门店不存在;';
       end;
    8: begin    //移动电话
       end;
    9: begin    //会员生日
         if str<>'' then
            begin
              try
                fntime.fnStrtoDate(str);
              except
                strError:='无效的会员生日;';
              end;
            end;
       end;
    10:begin     //地址
       end;
    11:begin    //邮编
       end;
    12:begin    //证件号码
       end;
    13:begin    //证件类型
       end;
    14:begin    //入会日期
         if str<>'' then
            begin
              try
                fntime.fnStrtoDate(str);
              except
                strError:='无效的入会日期;';
              end;
            end;
       end;
    15:begin   //续会日期
         if str<>'' then
            begin
              try
                fntime.fnStrtoDate(str);
              except
                strError:='无效的续会日期;';
              end;
            end;
       end;
    16:begin     //QQ
       end;
    17:begin    //MSN
       end;
    18:begin    //有效截止日期
         if str<>'' then
            begin
              try
                fntime.fnStrtoDate(str);
              except
                strError:='无效的有效截止日期;';
              end;
            end;
       end;
    19:begin    //月收入
       end;
    20:begin    //学历
       end;
    21:begin    //电子邮件
       end;
    22:begin    //办公电话
       end;
    23:begin    //家庭电话
       end;
    24:begin    //职业
       end;
    25:begin    //工作单位
       end;
    26:begin    //备注
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

function TfrmCustomerExcel.SelfCheckExcute: boolean;
var isSort:boolean;
    rs:TZQuery;
    FieldName,FileName:string;
    preId:integer;
    strPre,strNext:string;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Data := cdsExcel.Data;
    ClearParams;
    cdsColumn.First;
    while not cdsColumn.Eof do
    begin
      isSort:=false;
      FieldName:=cdsColumn.FieldByName('FieldName').AsString;
      FileName:=cdsColumn.FieldByName('FileName').AsString;
      if (FieldName <> '') and (FileName<>'') then
      begin
        if (FieldName='CUST_CODE') or (FieldName='SHOP_ID') or
           (FieldName='SORT_ID') or (FieldName='PRICE_ID') or
           (FieldName='REGION_ID') or (FieldName='IDN_TYPE') or
           (FieldName='DEGREES') or (FieldName='OCCUPATION') then
        begin
          if (FieldName='CUST_CODE') then
          begin
            isSort:=true;
            rs.SortedFields:=cdsColumn.FieldByName('FileName').AsString;
          end;

          if isSort then
          begin
            rs.First;
            strPre:=rs.FieldByName(FileName).AsString;
            preId:=rs.FieldByName('ID').AsInteger;
            //if strPre<>'' then
            TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strPre);
            rs.Next;
            while not rs.Eof do
            begin
              strNext:=rs.FieldByName(FileName).AsString;
              if (strPre<>'') and (strPre=strNext) then
              begin
                cdsExcel.Locate('ID',rs.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+'与第'+inttostr(preId)+'条数据'+cdsColumn.FieldByName('DestTitle').asstring+'重复;';
                cdsExcel.Post;
              end
              else if (strPre<>strNext) then
              begin
                strPre:=strNext;
                preID:=rs.FieldByName('ID').AsInteger;
              end;
              TransformtoString(FieldCheckSet[cdsColumn.FieldByName('ID').AsInteger],strNext);
              rs.Next;
            end;
          end else
          begin
            rs.First;
            while not rs.Eof do
            begin
              strNext:=rs.FieldByName(FileName).AsString;
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

function TfrmCustomerExcel.OutCheckExcute: boolean;
var
  rs,ss:TZQuery;
  FieldName:string;
  i,FieldIndex:integer;
  strWhere:string;
  strList:TStringList;
begin
  rs:=TZQuery.Create(nil);
  ss:=TZQuery.Create(nil);
  try
    ss.Data := cdsExcel.Data;

    //*********************会员卡号*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','CUST_CODE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
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
            cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
            cdsExcel.Edit;
            cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'已存在;';
            cdsExcel.Post;
            ss.Next;
          end;
          ss.Filtered:=false;
          rs.Next;
        end;
      end;
    end;

    //*********************入会门店*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','SHOP_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select SHOP_NAME from CA_SHOP_INFO where tenant_id='+token.tenantId+' and comm not in(''02'',''12'') and SHOP_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;

    //*********************会员等级*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','PRICE_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:=' select distinct CS.PRICE_NAME from VIW_CUSTOMER VC,PUB_PRICEGRADE CS where VC.TENANT_ID=CS.TENANT_ID and VC.PRICE_ID=CS.PRICE_ID and VC.tenant_id='+token.tenantId+
                   ' and VC.comm not in(''02'',''12'') and CS.PRICE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;

    //*********************会员类别*****************************

    //*********************地区*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','REGION_ID',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''8'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;

    //*********************证件类型*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','IDN_TYPE',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''11'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;

    //*********************学历*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','DEGREES',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''14'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;

    //*********************职业*****************************
    FieldName:='';
    if (cdsColumn.Locate('FieldName','OCCUPATION',[])) and (cdsColumn.FieldByName('FileName').AsString<>'') then
    begin
      FieldName:=cdsColumn.FieldByName('FileName').AsString;
      FieldIndex:=cdsColumn.FieldByName('ID').AsInteger;
      strWhere:=DeleteDuplicateString(FieldCheckSet[FieldIndex],strList);
      rs.Close;
      rs.SQL.Text:='select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''15'' and COMM not in (''02'',''12'') and CODE_NAME in ('+strWhere+')';
      dataFactory.Open(rs);
      if not rs.IsEmpty then
      begin
        if rs.RecordCount=strList.Count then  //所有的分类都在库中
        begin
          FieldType[FieldIndex]:=1;
        end
        else if rs.RecordCount<strList.Count then  //部分分类在库中
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
                cdsExcel.Locate('ID',ss.FieldByName('ID').AsInteger,[]);
                cdsExcel.Edit;
                cdsExcel.FieldByName('Msg').AsString:=cdsExcel.FieldByName('Msg').AsString+cdsColumn.FieldByName('DestTitle').AsString+'不存在;';
                cdsExcel.Post;
                ss.Next;
              end;
              ss.Filtered:=false;
            end;
          end;
        end
      end
      else                                  //库中没有文件中分类
        FieldType[FieldIndex]:=0;
    end;
  finally
    rs.Free;
    ss.Free;
  end;
end;

class function TfrmCustomerExcel.ExcelFactory(Owner: TForm; vDataSet: TZQuery;Fields,Formats:string;
  isSelfCheck: boolean): boolean;
begin
  with TfrmCustomerExcel.Create(Owner) do
    begin
      try
        RzLabel26.Caption:=RzLabel26.Caption+'--会员档案';
        DataSet:=vDataSet;
        CreateUseDataSet;
        DecodeFields2(FieldsString);
        SelfCheck:=isSelfCheck;
        result := (ShowModal=MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmCustomerExcel.RzLabel17Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('是否要下载会员信息导入模板？'),'友情提示..',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then Exit;
  saveDialog1.DefaultExt:='*.xls';
  saveDialog1.Filter:='Excel文档(*.xls)|*.xls';
  if saveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
         Exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    try
      if FileExists(ExtractFilePath(Application.ExeName)+'ExcelTemplate\会员信息导入表.xls') then
         CopyFile(pchar(ExtractFilePath(Application.ExeName)+'ExcelTemplate\会员信息导入表.xls'),pchar(SaveDialog1.FileName),false)
      else
         MessageBox(Handle, Pchar('没有找到导入模板！'),'友情提示..', MB_OK + MB_ICONQUESTION);
    except
      MessageBox(Handle, Pchar('下载导入模板失败！'),'友情提示..', MB_OK + MB_ICONQUESTION);
    end;
  end;
end;

function TfrmCustomerExcel.IsRequiredFiled(strFiled: string): boolean;
begin
  result:=false;
  if (strFiled='CUST_CODE') or (strFiled='CUST_NAME') or (strFiled='PRICE_ID') then
     result:=true;
end;

end.
