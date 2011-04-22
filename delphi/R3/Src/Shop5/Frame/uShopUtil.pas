unit uShopUtil;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls, cxMaskEdit, cxDropDownEdit, cxControls, cxContainer,
  cxEdit, cxTextEdit,ZDataSet,ZBase,DB,DBGridEh,cxButtonEdit, cxCalendar,cxMemo,zrComboBoxList,
  cxRadioGroup,cxSpinEdit,cxCheckBox;

//添加下拉选择框
procedure AddCbxPickList(Cbx:TcxComboBox;cname:string='';temp:TZQuery=nil);
//清除下拉选择框
procedure ClearCbxPickList(Cbx:TcxComboBox);
//初始freme窗体
procedure Initframe(frame:Tframe);
//悉放freme窗体
procedure Freeframe(frame:Tframe);
//初始form窗体
procedure Initform(form:Tform);
//悉放form窗体
procedure Freeform(form:Tform);
//设置输入框状态
procedure SetEditStyle(dbState:TDataSetState;AStyle:TcxCustomEditStyle);
//设置frame状态
procedure SetFrameEditStatus(frame:Tframe;dbState:TDataSetState);
//设置foram状态
procedure SetFormEditStatus(form:TForm;dbState:TDataSetState);
//设置DBGridEh参数
procedure InitGridPickList(Grid:TDBGridEh);
//绑定数据源
procedure ReadFromObject(AObj:TRecord_;form:Tform;_tag:string='');
//写入数据源
procedure WriteToObject(AObj:TRecord_;form:Tform;_tag:string='');
//数值条件解悉
function EncodeNumber(field:string;value:string):string;
//字符条件解悉
function EncodeString(field:string;value:string):string;

//打开界面资源
procedure LoadFormRes(Form:TForm);

//自编条码
function GetBarCode(ID:string;Size,Color:string;Len:Integer=13):string;
function GetBarCodeID(BarCode:string):string;
function GetBarCodeColor(BarCode:string):string;
function GetBarCodeSize(BarCode:string):string;

//判断控件值不是否为空，并聚焦
procedure CheckEdtValueIsEmpty(CmpCtrl: TWinControl; MsgStr: string);

//截地区后缀
function GetRegionId(id:string):string;


implementation
uses uGlobal,uShopGlobal,uFnUtil,uDsUtil,uXDictFactory;
function GetRegionId(id:string):string;
begin
  result := id;
  if copy(result,length(result)-1,2)='00' then
     delete(result,length(result)-1,2);
  if copy(result,length(result)-1,2)='00' then
     delete(result,length(result)-1,2);
end;
function GetBarCodeID(BarCode:string):string;
begin
  Result := copy(BarCode,2,6);
end;
function GetBarCodeColor(BarCode:string):string;
begin
  if Length(BarCode)<13 then
     begin
       result := '#';
       Exit;
     end;
  Result := copy(BarCode,10,3);
  result := result;
  if Result = '000' then Result := '#';
end;
function GetBarCodeSize(BarCode:string):string;
begin
  if Length(BarCode)<13 then
     begin
       result := '#';
       Exit;
     end;
  Result := copy(BarCode,8,2);
  result := '0'+result;
  if Result = '000' then Result := '#';
end;
//自编条码
function GetBarCode(ID:string;Size,Color:string;Len:Integer=13):string;
  function GetCodeFlag(data:String): String;
        var i,fak,sum : Integer;  begin
          sum := 0;
          fak := Length(data);
          for i:=1 to Length(data) do
          begin
                  if (fak mod 2) = 0 then
                          sum := sum + (StrToInt(data[i])*1)
                  else
                          sum := sum + (StrToInt(data[i])*3);
                  dec(fak);
          end;
          if (sum mod 10) = 0 then
                  result := data+'0'
          else
                  result := data+IntToStr(10-(sum mod 10));
  end;
var s,p1,p2:string;
begin
  if not( Length(ID) in [6]) then  Raise Exception.Create('条码种子位必须是6位');
  if (Length(Size)>3) and (Size[1]<>'0') then
     Raise Exception.Create('尺码属于不能大于2位');
  p1 := copy(Size,length(Size)-1,2);
  if p1='#' then p1 := '00';
  if Length(Color)>3 then
     Raise Exception.Create('颜色属于不能大于3位');
  p2 := Color;
  if p2='#' then p2 := '000';
  s := '9'+FnString.FormatStringEx(ID,6)+FnString.FormatStringEx(p1,2)+FnString.FormatStringEx(p2,3);
  Result := GetCodeFlag(s);
end;

procedure ClearCbxPickList(Cbx:TcxComboBox);
var i:integer;
begin
  Cbx.ItemIndex := -1;
  for i:=0 to Cbx.Properties.Items.Count -1 do
    Cbx.Properties.Items.Objects[i].Free;
  Cbx.Properties.Items.Clear;
end;

procedure AddCbxPickList(Cbx:TcxComboBox;cname:string='';temp:TZQuery=nil);
var
  rs:TZQuery;
  AObj:TRecord_;
  i:integer;
begin
  if temp=nil then
  begin
    rs := Global.GetZQueryFromName('PUB_PARAMS');
    rs.Filtered := false;
    if cname='' then
       rs.Filter := 'TYPE_CODE='''+copy(Cbx.Name,4,50)+''''
    else
       rs.Filter := 'TYPE_CODE='''+cname+'''';
    rs.Filtered := true;
  end
  else
    rs := temp;
  try
  if not rs.IsEmpty then ClearCbxPickList(cbx);
  rs.First;
  while not rs.Eof do
    begin
      AObj := TRecord_.Create;
      AObj.ReadFromDataSet(rs);
      Cbx.Properties.Items.AddObject(rs.FieldbyName('CODE_NAME').AsString,AObj);
      rs.Next;
    end;
  finally
    rs.Filtered := false;
    rs.Filter := '';
  end;
end;
procedure Initframe(frame:Tframe);
var i:integer;
begin
  for i:=0 to frame.ComponentCount -1 do
    begin
      if frame.Components[i] is TcxComboBox then
         AddCbxPickList(TcxComboBox(frame.Components[i]));
    end;
end;
procedure Freeframe(frame:Tframe);
var i:integer;
begin
  for i:=0 to frame.ComponentCount -1 do
    begin
      if frame.Components[i] is TcxComboBox then
         ClearCbxPickList(TcxComboBox(frame.Components[i]));
    end;
end;
//初始form窗体
procedure Initform(form:Tform);
var i:integer;
begin
  for i:=0 to form.ComponentCount -1 do
    begin
      if form.Components[i] is TcxComboBox then
         AddCbxPickList(TcxComboBox(form.Components[i]));
      if form.Components[i] is TDBGridEh then
         InitGridPickList(TDBGridEh(form.Components[i]));
    end;
end;
//悉放form窗体
procedure Freeform(form:Tform);
var i:integer;
begin
  for i:=0 to form.ComponentCount -1 do
    begin
      if form.Components[i] is TcxComboBox then
         ClearCbxPickList(TcxComboBox(form.Components[i]));
    end;
end;
procedure SetEditStyle(dbState:TDataSetState;AStyle:TcxCustomEditStyle);
begin
  if dbState = dsBrowse then
     begin
       AStyle.BorderStyle := ebsUltraFlat;
       AStyle.Color := clBtnFace;
     end
  else
     begin
       AStyle.BorderStyle := ebsUltraFlat;
       AStyle.Color := clWhite;
     end;
end;
procedure SetFrameEditStatus(frame:Tframe;dbState:TDataSetState);
var i:integer;
begin
  for i:=0 to frame.ComponentCount -1 do
    begin
      if frame.Components[i] is TcxComboBox then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxComboBox(frame.Components[i]).Style);
             TcxComboBox(frame.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxComboBox(frame.Components[i]).Style);
             TcxComboBox(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxButtonEdit then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxButtonEdit(frame.Components[i]).Style);
             TcxButtonEdit(frame.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxButtonEdit(frame.Components[i]).Style);
             TcxButtonEdit(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxRadioGroup then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxRadioGroup(frame.Components[i]).Style);
             TcxRadioGroup(frame.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxRadioGroup(frame.Components[i]).Style);
             TcxRadioGroup(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxSpinEdit then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxSpinEdit(frame.Components[i]).Style);
             TcxSpinEdit(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxSpinEdit(frame.Components[i]).Style);
             TcxSpinEdit(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxMaskEdit then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxTextEdit(frame.Components[i]).Style);
             TcxMaskEdit(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxTextEdit(frame.Components[i]).Style);
             TcxMaskEdit(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxMemo then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxMemo(frame.Components[i]).Style);
             TcxMemo(frame.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxMemo(frame.Components[i]).Style);
             TcxMemo(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;

      if frame.Components[i] is TcxRadioGroup then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxRadioGroup(frame.Components[i]).Style);
             TcxRadioGroup(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxRadioGroup(frame.Components[i]).Style);
             TcxRadioGroup(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxTextEdit then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxTextEdit(frame.Components[i]).Style);
             TcxTextEdit(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxTextEdit(frame.Components[i]).Style);
             TcxTextEdit(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TzrComboBoxList then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TzrComboBoxList(frame.Components[i]).Style);
             TzrComboBoxList(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TzrComboBoxList(frame.Components[i]).Style);
             TzrComboBoxList(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if frame.Components[i] is TcxDateEdit then
         begin
           if frame.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxDateEdit(frame.Components[i]).Style);
             TcxDateEdit(frame.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxDateEdit(frame.Components[i]).Style);
             TcxDateEdit(frame.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
    end;
end;
//设置form状态
procedure SetFormEditStatus(form:TForm;dbState:TDataSetState);
var i:integer;
begin
  for i:=0 to form.ComponentCount -1 do
    begin
      if form.Components[i].tag <0 then continue;
      if form.Components[i] is TcxComboBox then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxComboBox(form.Components[i]).Style);
             TcxComboBox(form.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxComboBox(form.Components[i]).Style);
             TcxComboBox(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxRadioGroup then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxRadioGroup(form.Components[i]).Style);
             TcxRadioGroup(form.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxRadioGroup(form.Components[i]).Style);
             TcxRadioGroup(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxButtonEdit then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxButtonEdit(form.Components[i]).Style);
             TcxButtonEdit(form.Components[i]).Properties.ReadOnly := True;
           end
           else
           begin
             SetEditStyle(dbState,TcxButtonEdit(form.Components[i]).Style);
             TcxButtonEdit(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxSpinEdit then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxSpinEdit(form.Components[i]).Style);
             TcxSpinEdit(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxSpinEdit(form.Components[i]).Style);
             TcxSpinEdit(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxMaskEdit then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxTextEdit(form.Components[i]).Style);
             TcxMaskEdit(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxTextEdit(form.Components[i]).Style);
             TcxMaskEdit(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxTextEdit then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxTextEdit(form.Components[i]).Style);
             TcxTextEdit(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxTextEdit(form.Components[i]).Style);
             TcxTextEdit(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TzrComboBoxList then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TzrComboBoxList(form.Components[i]).Style);
             TzrComboBoxList(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TzrComboBoxList(form.Components[i]).Style);
             TzrComboBoxList(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxDateEdit then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxDateEdit(form.Components[i]).Style);
             TcxDateEdit(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxDateEdit(form.Components[i]).Style);
             TcxDateEdit(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
      if form.Components[i] is TcxMemo then
         begin
           if form.Components[i].Tag = 1 then
           begin
             SetEditStyle(dsBrowse,TcxMemo(form.Components[i]).Style);
             TcxMemo(form.Components[i]).Properties.ReadOnly := true;
           end
           else
           begin
             SetEditStyle(dbState,TcxMemo(form.Components[i]).Style);
             TcxMemo(form.Components[i]).Properties.ReadOnly := (dbState=dsBrowse);
           end;
         end;
    end;
end;
//设置DBGridEh参数
procedure InitGridPickList(Grid:TDBGridEh);
var
  i:integer;
  rs:TZQuery;
begin
  for i:=0 to Grid.Columns.Count -1 do
    begin
      rs := Global.GetZQueryFromName('PUB_PARAMS');
      rs.Filtered := false;
      rs.Filter := 'TYPE_CODE='''+Grid.Columns[i].FieldName+'''';
      rs.Filtered := true;
      if rs.IsEmpty then Continue;
      try
      Grid.Columns[i].KeyList.Clear;
      Grid.Columns[i].PickList.Clear;
      rs.First;
      while not rs.Eof do
        begin
          Grid.Columns[i].KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
          Grid.Columns[i].PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
          rs.Next;
        end;
      finally
        rs.Filtered := false;
        rs.Filter := '';
      end;
    end;
end;

//绑定数据源
procedure ReadFromObject(AObj:TRecord_;form:Tform;_tag:string='');
var
  i:integer;
  fldname:string;
  saveed:boolean;
begin
  with form do
  begin
  for i := 0 to ComponentCount-1 do
    begin
      if (_tag<>'') and (copy(Components[i].Name,1,3) <> _tag) then Continue;
      fldname := copy(Components[i].Name,4,50);
      if AObj.FindField(fldname)=nil then continue; 
      if Components[i] is TcxComboBox then
         begin
           saveed := TcxComboBox(Components[i]).Properties.ReadOnly;
           TcxComboBox(Components[i]).Properties.ReadOnly := false;
           TcxComboBox(Components[i]).ItemIndex := TdsItems.FindItems(TcxComboBox(Components[i]).Properties.Items,'CODE_ID',AObj.FieldbyName(fldname).AsString);
           TcxComboBox(Components[i]).Properties.ReadOnly := saveed;
         end;
      if Components[i] is TcxSpinEdit then
         begin
           TcxSpinEdit(Components[i]).Value := AObj.FieldbyName(fldname).AsFloat;
         end;
      if Components[i] is TcxCheckBox then
         begin
           TcxCheckBox(Components[i]).Checked := AObj.FieldbyName(fldname).AsBoolean;
         end;
      if Components[i] is TcxTextEdit then
         begin
           TcxTextEdit(Components[i]).Text := AObj.FieldbyName(fldname).AsString;
         end;
      if Components[i] is TcxMaskEdit then
         begin
           TcxMaskEdit(Components[i]).Text := AObj.FieldbyName(fldname).AsString;
         end;
      if Components[i].ClassNameIs('TcxButtonEdit') then
         begin
           TcxButtonEdit(Components[i]).Text := AObj.FieldbyName(fldname).AsString;
         end;
      if Components[i] is TzrComboBoxList then
         begin
           TzrComboBoxList(Components[i]).KeyValue := AObj.FieldbyName(fldname).AsString;
           if AObj.FindField(fldname+'_TEXT') <> nil then
              TzrComboBoxList(Components[i]).Text := AObj.FieldbyName(fldname+'_TEXT').AsString
           else
              begin
                if (TzrComboBoxList(Components[i]).DataSet <> nil)
                   and
                   TzrComboBoxList(Components[i]).DataSet.Active
                then
                   TzrComboBoxList(Components[i]).Text := TdsFind.GetNameByID(TzrComboBoxList(Components[i]).DataSet,TzrComboBoxList(Components[i]).KeyField,TzrComboBoxList(Components[i]).ListField,AObj.FieldbyName(fldname).AsString);
              end;
         end;
      if Components[i] is TcxMemo then
         begin
           TcxMemo(Components[i]).Text := AObj.FieldbyName(fldname).AsString;
         end;
      if Components[i] is TcxDateEdit then
         begin
           if AObj.FieldbyName(fldname).AsString = '' then
              TcxDateEdit(Components[i]).EditValue := null
           else
              TcxDateEdit(Components[i]).Date := fnTime.fnStrtoDate(AObj.FieldbyName(fldname).AsString);
         end;
    end;
  end;
end;

//写入数据源
procedure WriteToObject(AObj:TRecord_;form:Tform;_tag:string='');
var
  i:integer;
  fldname:string;
begin
  with form do
  begin
  for i := 0 to ComponentCount-1 do
    begin
      if (_tag<>'') and (copy(Components[i].Name,1,3) <> _tag) then Continue;
      fldname := copy(Components[i].Name,4,50);
      if AObj.FindField(fldname)=nil then continue;
      if Components[i] is TcxCheckBox then
         begin
           //if TcxCheckBox(Components[i]).Properties.ReadOnly then continue;
           AObj.FieldbyName(fldname).AsBoolean := TcxCheckBox(Components[i]).Checked;
         end;
      if Components[i] is TcxComboBox then
         begin
           //if TcxComboBox(Components[i]).Properties.ReadOnly then continue;
           if TcxComboBox(Components[i]).ItemIndex=-1 then
              AObj.FieldbyName(fldname).AsString := ''
           else
              AObj.FieldbyName(fldname).AsString := TRecord_(TcxComboBox(Components[i]).Properties.Items.Objects[TcxComboBox(Components[i]).ItemIndex]).FieldbyName('CODE_ID').AsString;
         end;
      if Components[i] is TcxDateEdit then
         begin
           //if TcxDateEdit(Components[i]).Properties.ReadOnly then continue;
           if TcxDateEdit(Components[i]).EditValue = null then
              AObj.FieldbyName(fldname).AsString := ''
           else
              begin
                if AObj.FieldbyName(fldname).DataType in [ftString,ftWideString] then
                   AObj.FieldbyName(fldname).AsString := formatDatetime('YYYY-MM-DD',TcxDateEdit(Components[i]).Date)
                else
                   AObj.FieldbyName(fldname).asInteger := StrtoInt(formatDatetime('YYYYMMDD',TcxDateEdit(Components[i]).Date));
              end;
         end;
      if Components[i] is TcxMemo then
         begin
           //if TcxMemo(Components[i]).Properties.ReadOnly then continue;
           AObj.FieldbyName(fldname).AsString := TcxMemo(Components[i]).Text;
         end;
      if Components[i] is TzrComboBoxList then
         begin
           //if TzrComboBoxList(Components[i]).Properties.ReadOnly then continue;
           AObj.FieldbyName(fldname).AsString := TzrComboBoxList(Components[i]).AsString;
           if AObj.FindField(fldname+'_TEXT')<>nil then AObj.FieldbyName(fldname+'_TEXT').asString := TzrComboBoxList(Components[i]).Text;

         end;
      if Components[i] is TcxSpinEdit then
         begin
           AObj.FieldbyName(fldname).NewValue := TcxSpinEdit(Components[i]).Value;
         end;
      if Components[i] is TcxMaskEdit then
         begin
           //if TcxMaskEdit(Components[i]).Properties.ReadOnly then continue;
           if (AObj.FieldbyName(fldname).DataType in [ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD]) and (trim(TcxMaskEdit(Components[i]).Text)='') then
              AObj.FieldbyName(fldname).NewValue := null
           else
              begin
                if (AObj.FieldbyName(fldname).DataType in [ftSmallint, ftInteger, ftWord, ftLargeint]) then
                   begin
                     try
                       StrtoInt(TcxMaskEdit(Components[i]).Text);
                     except
                       Raise Exception.Create(TcxMaskEdit(Components[i]).Text+'无效整型数据');
                     end;
                   end;
                if (AObj.FieldbyName(fldname).DataType in [ftFloat, ftCurrency, ftBCD]) then
                   begin
                     try
                       StrtoFloat(TcxMaskEdit(Components[i]).Text);
                     except
                       Raise Exception.Create(TcxMaskEdit(Components[i]).Text+'无效数值型数据');
                     end;
                   end;
                AObj.FieldbyName(fldname).AsString := trim(TcxMaskEdit(Components[i]).Text);
              end;
         end;
      if Components[i].ClassNameIs('TcxButtonEdit') then
         begin
           AObj.FieldbyName(fldname).AsString := TcxButtonEdit(Components[i]).Text;
         end;
      if Components[i] is TcxTextEdit then
         begin
           //if TcxTextEdit(Components[i]).Properties.ReadOnly then continue;
           if (AObj.FieldbyName(fldname).DataType in [ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD]) and (trim(TcxTextEdit(Components[i]).Text)='') then
              AObj.FieldbyName(fldname).NewValue := null
           else
              begin
                if (AObj.FieldbyName(fldname).DataType in [ftSmallint, ftInteger, ftWord, ftLargeint]) then
                   begin
                     try
                       StrtoInt(TcxTextEdit(Components[i]).Text);
                     except
                       Raise Exception.Create(TcxTextEdit(Components[i]).Text+'无效整型数据');
                     end;
                   end;
                if (AObj.FieldbyName(fldname).DataType in [ftFloat, ftCurrency, ftBCD]) then
                   begin
                     try
                       StrtoFloat(TcxTextEdit(Components[i]).Text);
                     except
                       Raise Exception.Create(TcxTextEdit(Components[i]).Text+'无效数值型数据');
                     end;
                   end;
                AObj.FieldbyName(fldname).AsString := trim(TcxTextEdit(Components[i]).Text);
              end;
         end;
    end;
  end;
end;

//数值条件解悉
function EncodeNumber(field:string;value:string):string;
var
  n,i:integer;
  s,s1,s2,s3,dot1,dot2,dot3:string;
  vList:TStringList;
begin
  s := trim(value);
  if s='' then Exit;
  vList := TStringList.Create;
  try
    StrToStrings(s,',',vList);
    if vList.Count > 1 then
    begin
      result := '';
      for i:=0 to vList.Count-1 do
        begin
          if result<>'' then result := result +' or ';
          result := result + EncodeNumber(field,vList[i]);
        end;
      if result <> '' then result := '('+result+')';
      Exit;
    end;
  finally
    vList.Free;
  end;
  n := pos('~',s);
  if n>0 then
     begin
       s1 := trim(copy(s,1,n-1));
       s2 := trim(copy(s,n+1,length(s)-n));
       if (s1='') and (s2='') then Exit;
       if trim(s1)='' then
          result := field+'<='+FloatToStr(StrToFloatDef(s2,0))
       else
       if trim(s2)='' then
          result := field+'>='+FloatToStr(StrToFloatDef(s1,0))
       else
          result := field+'>='+FloatToStr(StrToFloatDef(s1,0))+' and '+field+'<='+FloatToStr(StrToFloatDef(s2,0));
     end
  else
     begin
       result := field+'='+FloatToStr(StrToFloatDef(s,0))
     end;
end;
//字符条件解悉
function EncodeString(field:string;value:string):string;
var
  n,i:integer;
  s,s1,s2,s3,dot1,dot2,dot3:string;
  vList:TStringList;
begin
  s := trim(value);
  if s='' then Exit;
  vList := TStringList.Create;
  try
    StrToStrings(s,',',vList);
    if vList.Count > 1 then
    begin
      result := '';
      for i:=0 to vList.Count-1 do
        begin
          if result<>'' then result := result +' or ';
          result := result + EncodeString(field,vList[i]);
        end;
      if result <> '' then result := '('+result+')';
      Exit;
    end;
  finally
    vList.Free;
  end;
  n := pos('~',s);
  if n>0 then
     begin
       s1 := trim(copy(s,1,n-1));
       s2 := trim(copy(s,n+1,length(s)-n));
       if (s1='') and (s2='') then Exit;
       if trim(s1)='' then
          result := field+'<='''+FloatToStr(StrToFloatDef(s2,0))+''''
       else
       if trim(s2)='' then
          result := field+'>='''+FloatToStr(StrToFloatDef(s1,0))+''''
       else
          result := field+'>='''+FloatToStr(StrToFloatDef(s1,0))+''''+' and '+field+'<='''+FloatToStr(StrToFloatDef(s2,0))+'''';
     end
  else
     begin
       result := field+'='''+FloatToStr(StrToFloatDef(s,0))+'''';
     end;
end;
procedure LoadFormRes(Form:TForm);
function FindColumn(FieldName:string;DBGrid:TDBGridEh):TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
    begin
      if DBGrid.Columns[i].FieldName = FieldName then
         begin
           result := DBGrid.Columns[i];
           Exit;
         end;
    end;
end;
var
  Column:TColumnEh;
  i:integer;
begin
  for i:=0 to Form.ComponentCount -1 do
  begin
    if Form.Components[i] is TDBGridEH then
    begin
      Column := FindColumn('PROPERTY_01',TDBGridEh(Form.Components[i]));
      if Column<>nil then
      begin
        Column.Title.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'尺码');
      end;
    end;
  end;
end;

procedure CheckEdtValueIsEmpty(CmpCtrl: TWinControl; MsgStr: string);
var
  Msg: string;
begin
  if CmpCtrl=nil then Exit;
  Msg:='     '+#13+trim(MsgStr)+#13+'     ';
  if (CmpCtrl is TcxTextEdit) and (trim(TcxTextEdit(CmpCtrl).Text)='') then
  begin
    if TcxTextEdit(CmpCtrl).CanFocus then TcxTextEdit(CmpCtrl).SetFocus;
    raise Exception.Create(Msg);
  end else
  if (CmpCtrl is TcxMemo) and (trim(TcxMemo(CmpCtrl).Text)='') then
  begin
    if TcxMemo(CmpCtrl).CanFocus then TcxMemo(CmpCtrl).SetFocus;
    raise Exception.Create(Msg);
  end else
  if (CmpCtrl is TcxDateEdit) and (trim(TcxDateEdit(CmpCtrl).Text)='') then
  begin
    if TcxDateEdit(CmpCtrl).CanFocus then TcxDateEdit(CmpCtrl).SetFocus;
    raise Exception.Create(Msg);
  end else
  if (CmpCtrl is TzrComboBoxList) and (trim(TzrComboBoxList(CmpCtrl).AsString)='') then
  begin
    if TzrComboBoxList(CmpCtrl).CanFocus then TzrComboBoxList(CmpCtrl).SetFocus;
    raise Exception.Create(Msg);
  end;
end;

end.
