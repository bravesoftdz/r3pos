unit ufrmFilterDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, ExtCtrls, Grids, DBGridEh,
  ValEdit,Objbase, cxDropDownEdit, cxSpinEdit, cxTimeEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxCheckBox,
  cxButtonEdit, ucxMonthEdit;
type
  PPacketFilter=^TPacketFilter;
  TPacketFilter=record
       TableName:string;
       Filter:string;
       end;
  TPacketFilterList=class
  private
    FList:TList;
    function GetFilters(Index: Integer): string;
    function GetNames(Index: Integer): string;
    procedure SetFilters(Index: Integer; const Value: string);
    function GetCount: integer;
  public
    constructor Create;
    destructor  Destroy;override;

    procedure Clear;
    function  FindFilter(TableName:string):Integer;
    procedure AddFilter(TableName,Filter:string);

    function  FilterByName(TableName:string;ADefaultTable:String=''):string;

    property  Filters[Index:Integer]:string read GetFilters write SetFilters;
    property  Names[Index:Integer]:string read GetNames ;
    property  Count:integer read GetCount;
  end;
type
  TfrmFilterDialog = class(TfrmBasic)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    VList: TValueListEditor;
    DatePick: TcxDateEdit;
    TimePick: TcxTimeEdit;
    YearPick: TcxSpinEdit;
    PickEdit: TcxComboBox;
    ChkPick: TcxCheckBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    NULL1: TMenuItem;
    ActClear: TAction;
    ActNull: TAction;
    MonthPick: TcxMonthEdit;
    procedure VListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure PickEditPropertiesChange(Sender: TObject);
    procedure YearPickPropertiesChange(Sender: TObject);
    procedure DatePickPropertiesChange(Sender: TObject);
    procedure MonthPickPropertiesChange(Sender: TObject);
    procedure TimePickPropertiesChange(Sender: TObject);
    procedure ChkPickPropertiesChange(Sender: TObject);
    procedure PickEditKeyPress(Sender: TObject; var Key: Char);
    procedure DatePickPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MonthPickPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure YearPickPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TimePickPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnOKClick(Sender: TObject);
    procedure VListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ActClearExecute(Sender: TObject);
    procedure ActNullExecute(Sender: TObject);
    procedure PickEditExit(Sender: TObject);
  private
    FRecord:TRecord_;
    FCurRow:Integer;
    FPacketFilters: TPacketFilterList;
    FLocked: Boolean;
    procedure SetCaption;override;

    procedure SetRecord(Value:TRecord_);
    function  GetFilter:boolean;
    procedure SetDisableVisible;
    function  GetRect(Row:Integer;Col:Integer):TRect;
    function InitPick(Component:TcxCombobox;Str:string):Boolean;
    procedure SetPacketFilters(const Value: TPacketFilterList);
    procedure ClearValue(ARS:TRecord_);
    procedure SetLocked(const Value: Boolean);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;

    class function ShowExecute(ARecord:TRecord_;Var AFilterText:string): boolean; overload;
    class function ShowExecute(ARecord:TRecord_;Var APacketFilter:TPacketFilterList): boolean;overload;
    property PacketFilters:TPacketFilterList read FPacketFilters write SetPacketFilters;
    property Locked:Boolean read FLocked write SetLocked;
    { Public declarations }
  end;

implementation
uses DB,ADODB,CommonFunc;
{$R *.dfm}

{ TfrmFilterDialog }

function TfrmFilterDialog.GetFilter: boolean;
  function GetStrValue(Str:String):string;
    begin
      if Uppercase(Str)='NULL' then Result := ' is null '
      else
         Result := ' = '''+Str+'''';
    end;
  function GetNumValue(Str:String):string;
    begin
      if UpperCase(Str)='NULL' then Result := ' is null '
      else
         Result := ' = '+Str+' ';
    end;
var i:Integer;
    Str:String;
    Y,M,D:Word;
    Field:TField_;
begin
  Result := false;
  PacketFilters.Clear;
  
  for i:=0 to VList.Strings.Count -1 do
    begin
      if VList.Strings.ValueFromIndex[i]='' then Continue;
      Field := TField_(VList.Strings.Objects[i]);
      case Field.DisplayType of
       ftDPNone,ftDPText:begin
           if Field.DataType in [ftString,ftWideString,ftFixedChar,ftMemo,ftFmtMemo,ftUnknown] then
              Str := Field.FieldName +GetStrValue(VList.Strings.ValueFromIndex[i])
           else
              Str := Field.FieldName +GetNumValue(VList.Strings.ValueFromIndex[i]);
           end;
       ftDPPickList:begin
           if Field.DataType in [ftString,ftWideString,ftFixedChar,ftMemo,ftFmtMemo,ftUnknown] then
              Str := Field.FieldName +GetStrValue(Field.AsString)
           else
              Str := Field.FieldName +GetNumValue(Field.AsString);
           end;
       ftDPNumber: begin
              try
                if Field.DataType in [ftSmallint, ftInteger, ftWord] then
                   StrtoInt(VList.Strings.ValueFromIndex[i])
                else
                   StrtoFloat(VList.Strings.ValueFromIndex[i]);
              except
                if Field.DataType in [ftSmallint, ftInteger, ftWord] then
                  Raise Exception.Create(VList.Strings.ValueFromIndex[i]+'不是有效的整型数据。')
                else
                  Raise Exception.Create(VList.Strings.ValueFromIndex[i]+'不是有效的数值型数据。');
              end;
              Str := Field.FieldName +GetNumValue(VList.Strings.ValueFromIndex[i]);
           end;
       ftDPCheckBox:begin
           case Field.DataType of
            ftString,ftWideString,ftFixedChar,ftMemo,ftFmtMemo: begin
               if VList.Strings.ValueFromIndex[i]='true' then
                 Str := Field.FieldName +GetStrValue('1')
               else
                 Str := Field.FieldName +GetStrValue('0')
             end
            else
             begin
               if VList.Strings.ValueFromIndex[i]='true' then
                 Str := Field.FieldName +GetNumValue('1')
               else
                 Str := Field.FieldName +GetNumValue('0')
             end;
           end;
           end;
       ftDPYear:begin
           Str := VList.Strings.ValueFromIndex[i];
           if Length(Str)<>4 then
              Raise Exception.Create(Field.TitleCaption+'无效年份格式。格式：YYYY，如2004');
           if Field.DataType in [ftString,ftWideString,ftFixedChar,ftMemo,ftFmtMemo] then
              Str := Field.FieldName + GetStrValue(Str)
           else
              Str := Field.FieldName + GetNumValue(Str);
          end;
       ftDPMonth:begin
           Str := VList.Strings.ValueFromIndex[i];
           if (Length(Str)<>7) and (UpperCase(Str)<>'NULL') then
              Raise Exception.Create(Field.TitleCaption+'无效年份格式。格式：YYYY-MM，如2004-01');
           if Field.DataType in [ftString,ftWideString,ftFixedChar,ftMemo,ftFmtMemo,ftUnknown] then
              Str := Field.FieldName + GetStrValue(Copy(Str,1,4)+Copy(Str,6,2))
           else
              Str := Field.FieldName + GetNumValue(Copy(Str,1,4)+Copy(Str,6,2));
          end;
       ftDPDate:begin
           Str := VList.Strings.ValueFromIndex[i];
           if (Length(Str)<>10) and (UpperCase(Str)<>'NULL') then
              Raise Exception.Create(Field.TitleCaption+'无效年份格式。格式：YYYY-MM-DD，如2004-01-01');
           if Field.DataType in [ftDateTime] then
              begin
                Y := StrtoInt(Copy(Str,1,4));
                M := StrtoInt(Copy(Str,6,2));
                D := StrtoInt(Copy(Str,9,2));
                Str := Field.FieldName + GetNumValue(FormatDateTime('YYYY/MM/DD',EnCodeDate(Y,M,D)));
              end
           else
              Str := Field.FieldName + GetStrValue(Copy(Str,1,4)+Copy(Str,6,2)+Copy(Str,9,2));
           end;
       ftDPTime:begin
           Str := VList.Strings.ValueFromIndex[i];
           if (Length(Str)<>8) and (UpperCase(Str)<>'NULL') then
              Raise Exception.Create(Field.TitleCaption+'无效年份格式。格式：HH:NN:SS，如13:01:20');
           if Field.DataType in [ftDateTime] then
              Str := Field.FieldName + GetnumValue('0000-00-00 '+Str)
           else
              Str := Field.FieldName + GetStrValue(Str);
          end;
      end;

      PacketFilters.AddFilter(Field.TableName,Str);
    end;
end;

procedure TfrmFilterDialog.SetDisableVisible;
begin
  PickEdit.Visible := False;
  YearPick.Visible := False;
  DatePick.Visible := False;
  MonthPick.Visible := False;
  TimePick.Visible := False;
  ChkPick.Visible := False;
end;

procedure TfrmFilterDialog.SetRecord(Value: TRecord_);
var i:Integer;
    Rect:TGridRect;
    T:Boolean;
begin
  VList.Strings.Clear;
  for i:=0 to Value.Count -1 do
    begin
      VList.Strings.AddObject(Value.Fields[i].TitleCaption+'=',Value.Fields[i]);
    end;
  if VList.Strings.Count >0 then
    begin
      Rect.Top :=1;
      Rect.Right :=1;
      Rect.Bottom :=1;
      Rect.Left := 1;
      VList.Selection := Rect;
      VListSelectCell(VList,1,1,T);
    end;
end;

class function TfrmFilterDialog.ShowExecute(ARecord: TRecord_;Var AFilterText:string): boolean;
begin
  if ARecord=nil then exit;
  with TfrmFilterDialog.Create(Application) do
    begin
      try
        ClearValue(ARecord);
        SetRecord(ARecord);
        if Showmodal=MROK then
           begin
             if PacketFilters.Count >1 then
                Raise Exception.Create('本过程不支持多表查询。');
             if PacketFilters.Count =1 then
                AFilterText := PacketFilters.Filters[0]
             else
                AFilterText := '';
             Result := True;
           end
        else
           Result := False;
      finally
        Free;
      end;
    end;
end;

function TfrmFilterDialog.GetRect(Row, Col: Integer): TRect;
begin
  Result := VList.CellRect(Col,Row);
  Result.Top := Result.Top +1;
  Result.Left := Result.Left +1;
  Result.Right := Result.Right +3;
end;

procedure TfrmFilterDialog.VListSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Rect:TRect;
    n:Integer;
begin
  CanSelect := not Locked;
  if Locked then Exit;
  Locked := true;
  try
  FCurRow := ARow;
  if VList.Strings.Count =0 then Exit;
  SetDisableVisible;
  if ACol<>1 then Exit;
  case TField_(VList.Strings.Objects[ARow-1]).DisplayType of
    ftDPPickList:begin
      PickEdit.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      PickEdit.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      if InitPick(PickEdit,TField_(VList.Strings.Objects[ARow-1]).PickList) then
         begin
           PickEdit.Properties.DropDownListStyle := lsFixedList;
           n := PickEdit.Properties.Items.IndexOfName(TField_(VList.Strings.Objects[ARow-1]).asString);
           if n>=0 then
              PickEdit.ItemIndex := n
           else
              begin
                PickEdit.ItemIndex := -1;
                PickEdit.ClearSelection;
              end;
         end
      else
         begin
           PickEdit.Properties.DropDownListStyle := lsEditList;
           PickEdit.Text := VList.Cells[ACol,ARow];
         end;
      PickEdit.Visible := True;
      if Visible then
         PickEdit.SetFocus;
      finally
         PickEdit.Tag := 0;
      end;
    end;
    ftDPCheckBox:begin
      ChkPick.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      ChkPick.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      ChkPick.Visible := True;
      if VList.Cells[ACol,ARow]='true' then
         ChkPick.Checked := True
      else
         ChkPick.Checked := False;
      if Visible then
         ChkPick.SetFocus;
      finally
        ChkPick.Tag := 0;
      end;
    end;
    ftDPYear:begin
      YearPick.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      YearPick.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      YearPick.Visible := True;
      if (VList.Cells[ACol,ARow]='null') or (VList.Cells[ACol,ARow]='') then
         YearPick.EditValue := null
      else
         YearPick.Value := StrtoIntDef(VList.Cells[ACol,ARow],StrtoInt(FormatDatetime('YYYY',Date())));
      if Visible then
         YearPick.SetFocus;
      finally
        YearPick.Tag := 0;
      end;
    end;
    ftDPMonth:begin
      MonthPick.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      MonthPick.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      MonthPick.Visible := True;
      if (VList.Cells[ACol,ARow]='') or (VList.Cells[ACol,ARow]='null') then
         MonthPick.Text := ''
      else
         MonthPick.Text := VList.Cells[ACol,ARow];
      if Visible then
         MonthPick.SetFocus;
      finally
         MonthPick.Tag := 0;
      end;
    end;
    ftDPDate:begin
      DatePick.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      DatePick.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      DatePick.Visible := True;
      if (VList.Cells[ACol,ARow]='') or (VList.Cells[ACol,ARow]='null') then
      DatePick.EditValue := null
      else
      DatePick.Date := StrtoDateDef(VList.Cells[ACol,ARow],Date());
      if Visible then
         DatePick.SetFocus;
      finally
         DatePick.Tag := 0;
      end;
    end;
    ftDPTime:begin
      TimePick.Tag := 1;
      try
      Rect := GetRect(ARow,ACol);
      TimePick.SetBounds(Rect.Left,Rect.Top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
      TimePick.Visible := True;
      if (VList.Cells[ACol,ARow]='') or (VList.Cells[ACol,ARow]='null') then
      TimePick.EditValue := null
      else
      TimePick.Time := StrtoTime(VList.Cells[ACol,ARow]);
      if Visible then
         TimePick.SetFocus;
      finally
         TimePick.Tag := 0;
      end;
    end;
  end;
  finally
    Locked := false;
  end;
end;

function TfrmFilterDialog.InitPick(Component: TcxCombobox; Str: string):Boolean;
var TmpStr:String;
    Temp:TADODataSet;
    List:TStrings;
begin
  Component.Properties.Items.Clear;
  TmpStr := UpperCase(Str);
  if Pos('SELECT',TmpStr)>0 then
     begin
       Temp := TADODataSet.Create(nil);
       try
         Temp.CommandText := Str;
         Factor.Open(Temp);
         Result := (Temp.Fields.Count>1);
         Temp.First;
         while not Temp.Eof do
           begin
             if Temp.Fields.Count>1 then
                Component.Properties.Items.Add(Temp.Fields[0].asString+'='+Temp.Fields[1].asString)
             else
                Component.Properties.Items.Add(Temp.Fields[0].asString);
             Temp.Next;
           end;
       finally
         Temp.Free;
       end;
     end
  else
     begin
        List := TStringList.Create;
        try
           List.CommaText := Str;
           Result := (pos('=',Str)>0);
           Component.Properties.Items.AddStrings(List);
        finally
           List.Free;
        end;
     end;
end;

procedure TfrmFilterDialog.PickEditPropertiesChange(Sender: TObject);
var Str:string;
    n:Integer;
begin
  if not PickEdit.Focused or not PickEdit.Visible then Exit;
  if Locked then Exit;
  Locked := true;
  try
  if PickEdit.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  Str := PickEdit.Text;
  n := pos('=',Str);
  if n >0 then
     begin
       VList.Cells[1,FCurRow] := Copy(Str,n+1,Length(Str)-n);
       TField_(VList.Strings.Objects[FCurRow-1]).AsString := Copy(Str,1,n-1);
     end
  else
     begin
       VList.Cells[1,FCurRow] := Str;
       TField_(VList.Strings.Objects[FCurRow-1]).AsString := Str
     end;
  finally
    Locked := false;
  end;
end;

procedure TfrmFilterDialog.YearPickPropertiesChange(Sender: TObject);
begin
  if not YearPick.Focused  or not YearPick.Visible then Exit;
  if Locked then Exit;
  Locked := true;
  try
  if YearPick.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  if YearPick.Value <100 then
     VList.Cells[1,FCurRow] := '20'+FormatFloat('00',YearPick.Value)
  else
     VList.Cells[1,FCurRow] := YearPick.Text;
  finally
     Locked := false;
  end;
end;

procedure TfrmFilterDialog.DatePickPropertiesChange(Sender: TObject);
begin
  if not DatePick.Focused or not DatePick.Visible then Exit;
  if Locked then Exit;
  Locked := true;
  try
  if DatePick.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  if DatePick.Text ='' then
     VList.Cells[1,FCurRow] := ''
  else
     VList.Cells[1,FCurRow] := FormatDatetime('YYYY/MM/DD',DatePick.Date);
  finally
     Locked := false;
  end;
end;

procedure TfrmFilterDialog.MonthPickPropertiesChange(Sender: TObject);
begin
  if not MonthPick.Focused or not MonthPick.Visible then Exit;
  if Locked then Exit;
  Locked := true;
  try
  if MonthPick.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  if MonthPick.IsNull then
     VList.Cells[1,FCurRow] := ''
  else
     VList.Cells[1,FCurRow] := MonthPick.Text;
  finally
     Locked := false;
  end;
end;

procedure TfrmFilterDialog.TimePickPropertiesChange(Sender: TObject);
begin
  if not TimePick.Focused or not TimePick.Visible then Exit;
  if Locked then Exit;
  Locked := true;
  try
  if TimePick.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  if (TimePick.Text ='00:00:00') or VarIsNull(TimePick.EditValue) then
    begin
     if VList.Cells[1,FCurRow]<>'null' then
        VList.Cells[1,FCurRow] := '';
    end
  else
     VList.Cells[1,FCurRow] := FormatDatetime('HH:NN:SS',TimePick.Time);
  finally
    Locked := false;
  end;
end;

procedure TfrmFilterDialog.ChkPickPropertiesChange(Sender: TObject);
begin
 if not ChkPick.Focused or not ChkPick.Visible then Exit;
 if Locked then Exit;
  Locked := true;
  try
   if ChkPick.Tag <>0 then Exit;
  if FCurRow <=0 then Exit;
  if ChkPick.Checked then
     VList.Cells[1,FCurRow] := 'true'
  else
     VList.Cells[1,FCurRow] := 'false'
  finally
     Locked := false;
  end;
end;

procedure TfrmFilterDialog.PickEditKeyPress(Sender: TObject;
  var Key: Char);
var Rect:TGridRect;
    T:Boolean;
begin
  if Locked then Exit;
  if Key=#13 then
     begin
      VList.SetFocus;
      Rect := VList.Selection;
      if Rect.Top < VList.Strings.Count then
         Rect.Top := Rect.Top +1
      else
        begin
         BtnOk.SetFocus;
         exit;
        end;
      if Rect.Bottom < VList.Strings.Count then
         Rect.Bottom := Rect.Bottom +1
      else
        begin
         BtnOk.SetFocus;
         exit;
        end;
      VList.Selection := Rect;
      VListSelectCell(VList,Rect.Left,Rect.Top,T);
     end;
end;

procedure TfrmFilterDialog.DatePickPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := '';
end;

procedure TfrmFilterDialog.MonthPickPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := '';

end;

procedure TfrmFilterDialog.YearPickPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := '';

end;

procedure TfrmFilterDialog.TimePickPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := '';

end;

procedure TfrmFilterDialog.btnOKClick(Sender: TObject);
begin
  inherited;
  GetFilter;
  ModalResult := MROK;
end;

procedure TfrmFilterDialog.VListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var Field:TField_;
    ARect:TRect;
begin
  if ACol<1 then Exit;
  if ARow<1 then Exit;
  Field := TField_(VList.Strings.Objects[ARow-1]);
  if Field.DisplayType in [ftDPCheckBox] then
    begin
      if VList.Cells[ACol,ARow]='true' then
         begin
           VList.Canvas.TextRect(Rect,1,1,'');
           VList.Canvas.Pen.Color := clBlue;
           ARect.Left := Rect.Left + ((Rect.Right - Rect.Left) DIV 2)-6;
           ARect.Top  := Rect.Top +  ((Rect.bottom -Rect.Top) DIV 2)-6;
           ARect.Right := Rect.Left + ((Rect.Right - Rect.Left) DIV 2)+6;
           ARect.Bottom := Rect.Top +  ((Rect.bottom -Rect.Top) DIV 2)+6;
           VList.Canvas.Rectangle(ARect);
           VList.Canvas.Pen.Width := 2;
           VList.Canvas.MoveTo(ARect.Left+1,ARect.Top+5);
           VList.Canvas.LineTo(ARect.Left+5,ARect.Bottom-1);
           VList.Canvas.MoveTo(ARect.Left+5,ARect.Bottom-1);
           VList.Canvas.LineTo(ARect.Right-1,ARect.Top+1);
         end
      else
      if VList.Cells[ACol,ARow]='false' then
         begin
           VList.Canvas.TextRect(Rect,1,1,'');
           VList.Canvas.Pen.Color := clBlue;
           ARect.Left := Rect.Left + ((Rect.Right - Rect.Left) DIV 2)-6;
           ARect.Top  := Rect.Top +  ((Rect.bottom -Rect.Top) DIV 2)-6;
           ARect.Right := Rect.Left + ((Rect.Right - Rect.Left) DIV 2)+6;
           ARect.Bottom := Rect.Top +  ((Rect.bottom -Rect.Top) DIV 2)+6;
           VList.Canvas.Rectangle(ARect);
           VList.Canvas.Pen.Width := 2;
           VList.Canvas.MoveTo(ARect.Left+1,ARect.Top+1);
           VList.Canvas.LineTo(ARect.Right-1,ARect.Bottom-1);
           VList.Canvas.MoveTo(ARect.Left+1,ARect.Bottom-1);
           VList.Canvas.LineTo(ARect.Right-1,ARect.Top+1);
         end;
    end;
end;

procedure TfrmFilterDialog.ActClearExecute(Sender: TObject);
var T:Boolean;
begin
  if FCurRow <=0 then Exit;
  VList.Cells[1,FCurRow] := '';
  if TField_(VList.Strings.Objects[FCurRow-1]).DisplayType = ftDPPickList then
     begin
       TField_(VList.Strings.Objects[FCurRow-1]).asString := '';
     end;
  VListSelectCell(VList,1,FCurRow,T);
end;

procedure TfrmFilterDialog.ActNullExecute(Sender: TObject);
var T:Boolean;
begin
  if FCurRow <=0 then Exit;
  VList.Cells[1,FCurRow] := 'null';
  if TField_(VList.Strings.Objects[FCurRow-1]).DisplayType = ftDPPickList then
     begin
       TField_(VList.Strings.Objects[FCurRow-1]).asString := 'null';
     end;
  VListSelectCell(VList,1,FCurRow,T);

end;

procedure TfrmFilterDialog.SetPacketFilters(
  const Value: TPacketFilterList);
begin
  FPacketFilters := Value;
end;

constructor TfrmFilterDialog.Create(AOwner: TComponent);
begin
  inherited;
  FPacketFilters := TPacketFilterList.Create;
end;

destructor TfrmFilterDialog.Destroy;
begin
  FPacketFilters.Free;
  inherited;
end;

class function TfrmFilterDialog.ShowExecute(ARecord: TRecord_;
  var APacketFilter: TPacketFilterList): boolean;
var i:Integer;
begin
  if ARecord=nil then exit;
  if APacketFilter=nil then
     Raise Exception.Create('APacketFilter参数没有Create。');
  with TfrmFilterDialog.Create(Application) do
    begin
      try
        ClearValue(ARecord);
        SetRecord(ARecord);
        if Showmodal=MROK then
           begin
             APacketFilter.Clear;
             for i:= 0 to PacketFilters.Count -1 do
                begin
                  APacketFilter.AddFilter(PacketFilters.Names[i],PacketFilters.Filters[i]); 
                end;
             Result := True;
           end
        else
           Result := False;
      finally
        Free;
      end;
    end;

end;

procedure TfrmFilterDialog.ClearValue(ARS: TRecord_);
var i:Integer;
begin
  for i:=0 to ARS.Count -1 do
    begin
      ARS.Fields[i].OldValue := null;
      ARS.Fields[i].NewValue := null;
    end;
end;

procedure TfrmFilterDialog.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
end;

procedure TfrmFilterDialog.SetCaption;
begin
  inherited;
  btnOk.Caption := Factor.XDict.GetCaption('btnOkCaption',btnOk.Caption,1);
  btnCancel.Caption := Factor.XDict.GetCaption('btnCancelCaption',btnCancel.Caption,1);
  VList.TitleCaptions[0]  := Factor.XDict.GetCaption('cmnFieldNameCaption',VList.TitleCaptions[0],1);
  VList.TitleCaptions[1]  := Factor.XDict.GetCaption('cmnFieldValueCaption',VList.TitleCaptions[1],1);

end;

{ TPacketFilterList }

procedure TPacketFilterList.AddFilter(TableName, Filter: string);
var i:Integer;
    Node:PPacketFilter;
begin
  if Trim(Filter)='' then Exit;
  i := FindFilter(TableName);
  if i>=0 then
     begin
       PPacketFilter(FList[i])^.Filter := PPacketFilter(FList[i])^.Filter+ ' and '+Filter;
     end
  else
     begin
       New(Node);
       Node^.TableName := TableName;
       Node^.Filter := Filter;
       FList.Add(Node); 
     end;
end;

procedure TPacketFilterList.Clear;
var i:Integer;
begin
  for i:=0 to FList.Count -1 do
    Dispose(FList[i]);
  FList.Clear;
end;

constructor TPacketFilterList.Create;
begin
  FList := TList.Create;
  inherited;
end;

destructor TPacketFilterList.Destroy;
begin
  Clear;
  FList.free;
  inherited;
end;

function TPacketFilterList.FilterByName(TableName: string;ADefaultTable:String=''): string;
var i:Integer;
begin
  i := FindFilter(TableName);
  if i=-1 then
     begin
       if ADefaultTable<>'' then
          begin
             i := FindFilter('');
             if i=-1 then
               Result := ' '
             else
               Result := Filters[i];
          end
       else
          Result := ' ';
     end
  else
     Result := Filters[i];
end;

function TPacketFilterList.FindFilter(TableName: string): Integer;
var i:integer;
begin
  Result := -1;
  for i:=0 to FList.Count -1 do
    begin
      if UpperCase(Names[i])=UpperCase(TableName) then
        begin
          Result := i;
          exit;
        end;
    end;
end;

function TPacketFilterList.GetCount: integer;
begin
  Result := FList.Count ;
end;

function TPacketFilterList.GetFilters(Index: Integer): string;
begin
  Result := PPacketFilter(FList[Index])^.Filter;
end;

function TPacketFilterList.GetNames(Index: Integer): string;
begin
  Result := PPacketFilter(FList[Index])^.TableName;
end;

procedure TPacketFilterList.SetFilters(Index: Integer;
  const Value: string);
begin
  PPacketFilter(FList[Index])^.Filter := Value;

end;

procedure TfrmFilterDialog.PickEditExit(Sender: TObject);
begin
  inherited;
  VList.SetFocus;
end;

end.
