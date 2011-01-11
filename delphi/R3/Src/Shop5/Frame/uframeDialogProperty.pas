unit uframeDialogProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, RzButton, DB, ADODB, ZBase, StdCtrls, DBClient;

type
  TframeDialogProperty = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    RzBitBtn2: TRzBitBtn;
    btnOk: TRzBitBtn;
    edtTable: TADODataSet;
    DataSource1: TDataSource;
    edtTableCODE_NAME: TStringField;
    edtTableCODE_ID: TStringField;
    stbHint: TPanel;
    cdsStorage: TADODataSet;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    PopupMenu1: TPopupMenu;
    actAddColor: TAction;
    actAddSize: TAction;
    edtTableSEQ_NO: TIntegerField;
    N1: TMenuItem;
    N2: TMenuItem;
    PubProperty: TClientDataSet;
    procedure edtTableCalcFields(DataSet: TDataSet);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure FormCreate(Sender: TObject);
  private
    FSimple: boolean;
    procedure SetSimple(const Value: boolean);
    { Private declarations }
  public
    { Public declarations }
    SaveColumn:TColumnEh;
    unitName:string;
    procedure Check;
    procedure ReadFrom(AObj:TRecord_;DataSet:TDataSet);
    procedure WriteTo(AObj:TRecord_;DataSet:TDataSet);
    procedure SimpleWriteTo(AObj:TRecord_);
    procedure RecordWriteTo(AObj:TRecord_;rs:TRecordList);
    procedure CreateGrid(AObj:TRecord_);
    procedure OpenStroage(AObj:TRecord_);
    class function ShowDialog(AOwner:TForm;AObj:TRecord_;DataSet:TDataSet;dState:TDataSetState):boolean;
    class function SimpleShowDialog(AOwner:TForm;AObj:TRecord_;dState:TDataSetState):boolean;
    class function RecordShowDialog(AOwner:TForm;AObj:TRecord_;rs:TRecordList;dState:TDataSetState):boolean;
    property Simple:boolean read FSimple write SetSimple;
  end;

implementation
uses uGlobal,uXDictFactory,uShopGlobal;
{$R *.dfm}

{ TframeDialogProperty }

procedure TframeDialogProperty.CreateGrid(AObj:TRecord_);
var
  rs,bs,us:TADODataSet;
  Field:TField;
  Column:TColumnEh;
  r,c:integer;
begin
  bs := Global.GetADODataSetFromName('BAS_GOODSINFO');
  bs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
//  btnSize.Visible := (bs.FieldbyName('PROPERTY_01').AsString <> '');
//  btnColor.Visible := (bs.FieldbyName('PROPERTY_02').AsString <> '');
  us := Global.GetADODataSetFromName('PUB_MEAUNITS');
  if us.Locate('UNIT_ID',bs.FieldbyName('UNIT_ID').AsString,[]) then unitName := us.FieldbyName('UNIT_NAME').AsString;
  edtTable.Close;
  DBGridEh1.FrozenCols := 0;
  rs := TADODataSet.Create(nil);
  edtTable.DisableControls;
  try
    //处理尺码
    if (bs.FieldbyName('PROPERTY_01').AsString = '') or (bs.FieldbyName('PROPERTY_01').AsString = '#') then
       begin
          Column := DBGridEh1.Columns.Add;
          Column.FieldName := 'SIZE_#';
          Column.Width := 30;
          Column.Title.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'尺码') +'|无';
          Column.Footer.ValueType := fvtSum;
          Column.Alignment := taCenter;
          Column.ReadOnly := false;
          Field := TBCDField.Create(edtTable);
          Field.FieldName := 'SIZE_#';
          Field.DataSet := edtTable;
//          edtTable.Fields.Add(Field);
       end
    else
       begin
          rs.Close;
          if bs.FieldbyName('PROPERTY_01').AsString='G' then //自定义颜色
             rs.CommandText := 'select ''000''+B.CODE_ID as CODE_ID,B.CODE_NAME from PUB_PROPERTY A,PUB_CODE_INFO B where A.CODE_ID=B.CODE_ID and A.GODS_ID='''+bs.FieldbyName('GODS_ID').AsString+''' and A.CODE_TYPE=2 and B.CODE_TYPE=2 and A.COMM not in (''02'',''12'') order by A.SEQ_NO'
          else
             rs.CommandText := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_ID like '''+bs.FieldbyName('PROPERTY_01').AsString+'%'' and len(CODE_ID)>3 and CODE_TYPE=2 and COMM not in (''02'',''12'') order by SEQ_NO';
          Factor.Open(rs);
          rs.First;
          while not rs.Eof do
             begin
               Column := DBGridEh1.Columns.Add;
               Column.FieldName := 'SIZE_'+copy(rs.FieldbyName('CODE_ID').AsString,4,3);
               Column.Width := 30;
               Column.Title.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'尺码')+'|'+rs.FieldbyName('CODE_NAME').AsString;
               Column.Footer.ValueType := fvtSum;
               Column.Alignment := taCenter;
               Column.ReadOnly := false;
               Field := TBCDField.Create(edtTable);
               Field.FieldName := 'SIZE_'+copy(rs.FieldbyName('CODE_ID').AsString,4,3);
               Field.DataSet := edtTable;
//               edtTable.Fields.Add(Field);
               rs.Next;
             end;
          Column := DBGridEh1.Columns.Add;
          Column.FieldName := 'SIZE_#';
          Column.Width := 30;
          Column.Title.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'尺码')+'|无';
          Column.Footer.ValueType := fvtSum;
          Column.Alignment := taCenter;
          Column.ReadOnly := false;
          Field := TBCDField.Create(edtTable);
          Field.FieldName := 'SIZE_#';
          Field.DataSet := edtTable;
          Column := DBGridEh1.Columns.Add;
          Column.FieldName := 'SIZE_TOTAL';
          Column.Width := 40;
          Column.Title.Caption := '小计';
          Column.Footer.ValueType := fvtSum;
          Column.Alignment := taCenter;
          Column.ReadOnly := false;
          Field := TBCDField.Create(edtTable);
          Field.FieldName := 'SIZE_TOTAL';
          Field.DataSet := edtTable;
          Field.Calculated := true;
//          edtTable.Fields.Add(Field);
       end;
    // end
    edtTable.CreateDataSet;
    //处理颜色
    if (bs.FieldbyName('PROPERTY_02').AsString = '') or (bs.FieldbyName('PROPERTY_02').AsString = '#') then
       begin
          edtTable.Append;
          edtTable.FieldbyName('CODE_NAME').AsString := '无';
          edtTable.FieldbyName('CODE_ID').AsString := '#';
       end
    else
       begin
          rs.Close;
          if bs.FieldbyName('PROPERTY_02').AsString='G' then //自定义颜色
             rs.CommandText := 'select ''000''+B.CODE_ID as CODE_ID,B.CODE_NAME from PUB_PROPERTY A,PUB_CODE_INFO B where A.CODE_ID=B.CODE_ID and A.GODS_ID='''+bs.FieldbyName('GODS_ID').AsString+''' and B.CODE_TYPE=4 and A.CODE_TYPE=4 and A.COMM not in (''02'',''12'') order by A.SEQ_NO'
          else
             rs.CommandText := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_ID like '''+bs.FieldbyName('PROPERTY_02').AsString+'%'' and len(CODE_ID)>3 and CODE_TYPE=4 and COMM not in (''02'',''12'') order by SEQ_NO';
          Factor.Open(rs);
          rs.First;
          while not rs.Eof do
             begin
               edtTable.Append;
               edtTable.FieldbyName('CODE_NAME').AsString := rs.FieldbyName('CODE_NAME').AsString;
               edtTable.FieldbyName('CODE_ID').AsString := copy(rs.FieldbyName('CODE_ID').AsString,4,3);
               inc(r);
               edtTable.FieldbyName('SEQ_NO').AsInteger := r;
               rs.Next;
             end;
          edtTable.Append;
          edtTable.FieldbyName('CODE_NAME').AsString := '无';
          edtTable.FieldbyName('CODE_ID').AsString := '#';
          inc(r);
          edtTable.FieldbyName('SEQ_NO').AsInteger := r;
       end;
    // end

  finally
    edtTable.First;
    edtTable.EnableControls;
    rs.free;
  end;
  if DBGridEh1.Columns.Count > 1 then DBGridEh1.FrozenCols := 1;
end;

class function TframeDialogProperty.ShowDialog(AOwner:TForm;AObj: TRecord_;
  DataSet: TDataSet;dState:TDataSetState): boolean;
begin
  with TframeDialogProperty.Create(AOwner) do
    begin
      try
        Caption := '商品名称：('+AObj.FieldbyName('GODS_CODE').AsString+')'+AObj.FieldbyName('GODS_NAME').AsString; 
        dbState := dState;
        CreateGrid(AObj);
        OpenStroage(AObj);
        ReadFrom(AObj,DataSet);
        DBGridEh1.ReadOnly := (dbState=dsBrowse);
        btnOk.Visible := (dbState<>dsBrowse);
        result := (ShowModal=MROK);
        if result then
           WriteTo(AObj,DataSet);
      finally
        free;
      end;
    end;
end;

procedure TframeDialogProperty.edtTableCalcFields(DataSet: TDataSet);
var
  i:integer;
  v:real;
begin
  inherited;
  v := 0;
  for i :=0 to DataSet.Fields.Count -1 do
    begin
      if (copy(DataSet.Fields[i].FieldName,1,5)='SIZE_') and not DataSet.Fields[i].Calculated then
         v := v + DataSet.Fields[i].AsFloat;
    end;
  edtTable.FieldbyName('SIZE_TOTAL').AsFloat := v;
end;

procedure TframeDialogProperty.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName <> 'CODE_NAME') and not Column.Field.Calculated then
     begin
       if (edtTable.RecNo mod 2) = 0 then
          Background := cl3DLight
       else
          Background := clWhite;
     end;
  if Column.FieldName = 'CODE_NAME' then
     begin
       Background := clBtnFace;
     end
  else
     if Column.Field.Calculated then Background := clYellow
  else
     if cdsStorage.Locate('PROPERTY_01;PROPERTY_02',varArrayOf([copy(Column.FieldName,6,3),edtTable.FieldbyName('CODE_ID').asString]),[]) then
        begin
          if cdsStorage.FieldbyName('AMOUNT').asFloat>0 then
              Background := Shape1.Brush.Color;
          if cdsStorage.FieldbyName('AMOUNT').asFloat<0 then
              Background := Shape2.Brush.Color;
        end;
end;

procedure TframeDialogProperty.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeDialogProperty.btnOkClick(Sender: TObject);
begin
  inherited;
  Check;
  ModalResult := MROK;
end;

procedure TframeDialogProperty.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       if edtTable.State = dsBrowse then  btnOkClick(nil)
       else edtTable.Post;
       //DBGridEh1.SumList.RecalcAll;
     end;
end;

procedure TframeDialogProperty.OpenStroage(AObj: TRecord_);
begin
  cdsStorage.Close;
  if AObj.FieldbyName('BATCH_NO').AsString = '#' then
     cdsStorage.CommandText := 'select sum(AMOUNT) as AMOUNT,PROPERTY_01,PROPERTY_02 from STO_STORAGE where COMP_ID='''+Global.CompanyID+''' and GODS_ID='''+AObj.FieldbyName('GODS_ID').AsString+''' group by PROPERTY_01,PROPERTY_02'
  else
     cdsStorage.CommandText := 'select sum(AMOUNT) as AMOUNT,PROPERTY_01,PROPERTY_02 from STO_STORAGE where COMP_ID='''+Global.CompanyID+''' and GODS_ID='''+AObj.FieldbyName('GODS_ID').AsString+''' and BATCH_NO='''+AObj.FieldbyName('BATCH_NO').AsString+''' group by PROPERTY_01,PROPERTY_02';
  Factor.Open(cdsStorage);
end;

procedure TframeDialogProperty.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (gdSelected in State) or (gdFocused in State) and DBGridEh1.Focused then
     begin
       if cdsStorage.Locate('PROPERTY_01;PROPERTY_02',varArrayOf([copy(Column.FieldName,6,3),edtTable.FieldbyName('CODE_ID').asString]),[]) then
          stbHint.Caption := '"'+edtTable.FieldbyName('CODE_NAME').AsString+' / '+copy(Column.Title.Caption,6,20)+ '" 可用库存为：'+cdsStorage.FieldbyName('AMOUNT').AsString+unitName
       else
          stbHint.Caption := '"'+edtTable.FieldbyName('CODE_NAME').AsString+' / '+copy(Column.Title.Caption,6,20)+ '" 可用库存为：0';


       ARect := DBGridEh1.CellRect(0,edtTable.RecNo);
       DBGridEh1.Brush.Color := clYellow;
       DBGridEh1.DefaultDrawColumnCell(ARect, 0, DBGridEh1.Columns[0], []);
       DBGridEh1.Brush.Color := clWhite;
       //DbGridEh1.canvas.DrawFocusRect(ARect);
       
       if SaveColumn = Column then Exit;
       if SaveColumn<>nil then SaveColumn.Title.Color := clBtnFace;
       Column.Title.Color := clHighlight;
       SaveColumn := Column;
     end;
end;

procedure TframeDialogProperty.ReadFrom(AObj: TRecord_; DataSet: TDataSet);
var
  fld,row:string;
begin
  edtTable.DisableControls;
  try
  DataSet.Filtered := false;
  DataSet.Filter := 'SEQNO='''+AObj.FieldbyName('SEQNO').AsString+'''';
  DataSet.Filtered := true;
  DataSet.First;
  while not DataSet.Eof do
    begin
      fld := 'SIZE_'+DataSet.FieldbyName('PROPERTY_01').AsString;
      if edtTable.FindField(fld)=nil then fld := 'SIZE_#';
      row := DataSet.FieldbyName('PROPERTY_02').AsString;
      if not edtTable.Locate('CODE_ID',row,[]) then row := '#';
      edtTable.Locate('CODE_ID',row,[]);
      edtTable.Edit;
      edtTable.FieldbyName(fld).Value := DataSet.FieldbyName('AMOUNT').AsFloat;
      edtTable.Post;
      DataSet.Next;
    end;
  finally
    edtTable.EnableControls;
  end;
end;

procedure TframeDialogProperty.WriteTo(AObj: TRecord_; DataSet: TDataSet);
var
  i,j:integer;
  amt:real;
begin
  edtTable.DisableControls;
  try
  DataSet.Filtered := false;
  DataSet.Filter := 'SEQNO='''+AObj.FieldbyName('SEQNO').AsString+'''';
  DataSet.Filtered := true;
  DataSet.First;
  while not DataSet.Eof do DataSet.Delete;
  edtTable.First;
  amt := 0;
  while not edtTable.Eof do
    begin
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if (copy(edtTable.Fields[i].FieldName,1,5)='SIZE_') and not edtTable.Fields[i].Calculated
             and
             (edtTable.Fields[i].AsString <> '')
          then
             begin
               DataSet.Append;
               for j:=0 to DataSet.Fields.Count -1 do
                 begin
                   if AObj.FindField(DataSet.Fields[j].FieldName)<>nil then
                      DataSet.Fields[j].Value := AObj.FieldbyName(DataSet.Fields[j].FieldName).NewValue;
                 end;
               DataSet.FieldByName('PROPERTY_01').AsString := copy(edtTable.Fields[i].FieldName,6,3);
               DataSet.FieldByName('PROPERTY_02').AsString := edtTable.FieldbyName('CODE_ID').AsString;
               DataSet.FieldByName('AMOUNT').AsFloat := edtTable.Fields[i].AsFloat;
               amt := amt + edtTable.Fields[i].AsFloat;
               DataSet.Post;
             end;
        end;
      edtTable.Next;
    end;
  AObj.FieldByName('AMOUNT').AsFloat := amt;
  finally
    edtTable.EnableControls;
  end;
end;

procedure TframeDialogProperty.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then
     Background := clBtnFace
  else
     Background := clYellow;
end;

procedure TframeDialogProperty.FormCreate(Sender: TObject);
begin
  inherited;
  SaveColumn := nil;
  Simple := false;
end;

class function TframeDialogProperty.SimpleShowDialog(AOwner: TForm;
  AObj: TRecord_; dState: TDataSetState): boolean;
begin
  with TframeDialogProperty.Create(AOwner) do
    begin
      try
        Caption := '商品名称：('+AObj.FieldbyName('GODS_CODE').AsString+')'+AObj.FieldbyName('GODS_NAME').AsString; 
        dbState := dState;
        Simple := true;
        CreateGrid(AObj);
        OpenStroage(AObj);
        DBGridEh1.ReadOnly := (dbState=dsBrowse);
        btnOk.Visible := (dbState<>dsBrowse);
        result := (ShowModal=MROK);
        if result then
           begin
             SimpleWriteTo(AObj);
           end;
      finally
        free;
      end;
    end;
end;

procedure TframeDialogProperty.SetSimple(const Value: boolean);
begin
  FSimple := Value;
end;

procedure TframeDialogProperty.SimpleWriteTo(AObj: TRecord_);
var
  i,j:integer;
begin
  edtTable.First;
  while not edtTable.Eof do
    begin
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if (copy(edtTable.Fields[i].FieldName,1,5)='SIZE_') and not edtTable.Fields[i].Calculated
             and
             (edtTable.Fields[i].asString <> '')
          then
             begin
               AObj.FieldByName('PROPERTY_01').AsString := copy(edtTable.Fields[i].FieldName,6,3);
               AObj.FieldByName('PROPERTY_02').AsString := edtTable.FieldbyName('CODE_ID').AsString;
               AObj.FieldByName('AMOUNT').AsFloat := edtTable.Fields[i].AsFloat;
             end;
        end;
      edtTable.Next;
    end;
end;

procedure TframeDialogProperty.Check;
var
  i,j:integer;
  amt:real;
  r:boolean;
  isinput:boolean;
begin
  amt := 0;
  edtTable.DisableControls;
  try
  r := false;
  edtTable.First;
  isinput := false;
  while not edtTable.Eof do
    begin
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if (copy(edtTable.Fields[i].FieldName,1,5)='SIZE_') and not edtTable.Fields[i].Calculated
             and
             (edtTable.Fields[i].asString <> '')
          then
             begin
               if Simple and (amt<>0) then Raise Exception.Create('只能输入在一个单元格中输入数量.');
               amt := amt + edtTable.Fields[i].AsFloat;
               r := true;
               isinput := true;
             end;
        end;
      edtTable.Next;
    end;
    if not isinput then Raise Exception.Create('请输入数量后再点击确定按钮.');
  finally
    edtTable.EnableControls;
  end;
end;

procedure TframeDialogProperty.RecordWriteTo(AObj: TRecord_;
  rs: TRecordList);
var
  i,j:integer;
  _Obj:TRecord_;
begin
  edtTable.First;
  while not edtTable.Eof do
    begin
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if (copy(edtTable.Fields[i].FieldName,1,5)='SIZE_') and not edtTable.Fields[i].Calculated
             and
             (edtTable.Fields[i].asString <> '')
          then
             begin
               _Obj := TRecord_.Create;
               AObj.CopyTo(_Obj);
               _Obj.FieldByName('PROPERTY_01').AsString := copy(edtTable.Fields[i].FieldName,6,3);
               _Obj.FieldByName('PROPERTY_02').AsString := edtTable.FieldbyName('CODE_ID').AsString;
               _Obj.FieldByName('AMOUNT').AsFloat := edtTable.Fields[i].AsFloat;
               rs.AddRecord(_Obj); 
             end;
        end;
      edtTable.Next;
    end;
end;

class function TframeDialogProperty.RecordShowDialog(AOwner: TForm;
  AObj: TRecord_;rs:TRecordList; dState: TDataSetState): boolean;
begin
  with TframeDialogProperty.Create(AOwner) do
    begin
      try
        Caption := '商品名称：('+AObj.FieldbyName('GODS_CODE').AsString+')'+AObj.FieldbyName('GODS_NAME').AsString; 
        dbState := dState;
        CreateGrid(AObj);
        OpenStroage(AObj);
        DBGridEh1.ReadOnly := (dbState=dsBrowse);
        btnOk.Visible := (dbState<>dsBrowse);
        result := (ShowModal=MROK);
        if result then
           begin
             RecordWriteTo(AObj,rs);
           end;
      finally
        free;
      end;
    end;
end;

end.
