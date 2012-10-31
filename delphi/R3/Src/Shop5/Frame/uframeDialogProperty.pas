unit uframeDialogProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, RzButton, DB, ADODB, ZBase, StdCtrls, DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TframeDialogProperty = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    RzBitBtn2: TRzBitBtn;
    btnOk: TRzBitBtn;
    DataSource1: TDataSource;
    stbHint: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    PopupMenu1: TPopupMenu;
    actAddColor: TAction;
    actAddSize: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    edtTable: TZQuery;
    cdsStorage: TZQuery;
    RzBitBtn1: TRzBitBtn;
    DBGridEh2: TDBGridEh;
    DataSource2: TDataSource;
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
    procedure RzBitBtn1Click(Sender: TObject);
    procedure stbHintClick(Sender: TObject);
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
uses uGlobal,uXDictFactory,uShopGlobal, ufrmBasic, StrUtils;
{$R *.dfm}

{ TframeDialogProperty }

procedure TframeDialogProperty.CreateGrid(AObj:TRecord_);
var
  cs,ss,bs,us:TZQuery;
  Field:TField;
  Column:TColumnEh;
  r,c:integer;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('无效商品代码,代码:'+AObj.FieldbyName('GODS_ID').AsString+'');
  cs := Global.GetZQueryFromName('PUB_COLOR_RELATION');
  ss := Global.GetZQueryFromName('PUB_SIZE_RELATION');
  us := Global.GetZQueryFromName('PUB_MEAUNITS');
  if us.Locate('UNIT_ID',bs.FieldbyName('UNIT_ID').AsString,[]) then unitName := us.FieldbyName('UNIT_NAME').AsString;

  edtTable.Close;
  edtTable.FieldDefs.Add('SEQ_NO',ftInteger,0);
  edtTable.FieldDefs.Add('CODE_NAME',ftString,50);
  edtTable.FieldDefs.Add('CODE_ID',ftString,36);
  DBGridEh1.FrozenCols := 0;
  edtTable.DisableControls;
  try
    //处理尺码
    if (bs.FieldbyName('SORT_ID8').AsString = '') or (bs.FieldbyName('SORT_ID8').AsString = '#') then
       begin
          Column := DBGridEh1.Columns.Add;
          Column.FieldName := 'SIZE_#';
          Column.Width := 30;
          Column.Title.Caption := '尺码|无';
          Column.Footer.ValueType := fvtSum;
          Column.Alignment := taCenter;
          Column.ReadOnly := false;
          edtTable.FieldDefs.Add('SIZE_#',ftInteger,0);
          //Field := TBCDField.Create(edtTable);
          //Field.FieldName := 'SIZE_#';
          //Field.DataSet := edtTable;
       end
    else
       begin
          ss.Filtered := False;
          ss.Filter := 'SORT_ID='''+bs.FieldbyName('SORT_ID8').AsString+'''';
          ss.Filtered := True;
          ss.First;
          while not ss.Eof do
             begin
               //if pos(','+bs.FieldbyName('SORT_ID8').AsString+',',','+ss.FieldbyName('SORT_ID8S').AsString+',')>0 then
               begin
               Column := DBGridEh1.Columns.Add;
               Column.FieldName := 'SIZE_'+ss.FieldbyName('SIZE_ID').AsString;
               Column.Width := 30;
               Column.Title.Caption := '尺码|'+ss.FieldbyName('SIZE_NAME').AsString;
               Column.Footer.ValueType := fvtSum;
               Column.Alignment := taCenter;
               Column.ReadOnly := false;
               edtTable.FieldDefs.Add('SIZE_'+ss.FieldbyName('SIZE_ID').AsString,ftInteger,0);
               end;
               ss.Next;
             end;
          Column := DBGridEh1.Columns.Add;
          Column.FieldName := 'SIZE_#';
          Column.Width := 30;
          Column.Title.Caption := '尺码|无';
          Column.Footer.ValueType := fvtSum;
          Column.Alignment := taCenter;
          Column.ReadOnly := false;
          edtTable.FieldDefs.Add('SIZE_#',ftInteger,0);
          //Column := DBGridEh1.Columns.Add;
          //Column.FieldName := 'SIZE_TOTAL';
          //Column.Width := 40;
          //Column.Title.Caption := '小计';
          //Column.Footer.ValueType := fvtSum;
          //Column.Alignment := taCenter;
          //Column.ReadOnly := false;
          edtTable.FieldDefs.Add('SIZE_TOTAL',ftInteger,0);
       end;
    // end
    Field := TBCDField.Create(edtTable);
    Field.FieldName := 'SIZE_TOTAL';
    Field.DataSet := edtTable;
    Field.Calculated := true;
    edtTable.CreateDataSet;
    //处理颜色
    if (bs.FieldbyName('SORT_ID7').AsString = '') or (bs.FieldbyName('SORT_ID7').AsString = '#') then
       begin
          edtTable.Append;
          edtTable.FieldbyName('CODE_NAME').AsString := '无';
          edtTable.FieldbyName('CODE_ID').AsString := '#';
       end
    else
       begin
          cs.Filtered := False;
          cs.Filter := 'SORT_ID='''+bs.FieldbyName('SORT_ID7').AsString+'''';
          cs.Filtered := True;
          cs.First;
          while not cs.Eof do
             begin
               //if pos(','+bs.FieldbyName('SORT_ID7').AsString+',',','+cs.FieldbyName('SORT_ID7S').AsString+',')>0 then
               begin
               edtTable.Append;
               edtTable.FieldbyName('CODE_NAME').AsString := cs.FieldbyName('COLOR_NAME').AsString;
               edtTable.FieldbyName('CODE_ID').AsString := cs.FieldbyName('COLOR_ID').AsString;
               inc(r);
               edtTable.FieldbyName('SEQ_NO').AsInteger := r;
               end;
               cs.Next;
             end;
          edtTable.Append;
          edtTable.FieldbyName('CODE_NAME').AsString := '无';
          edtTable.FieldbyName('CODE_ID').AsString := '#';
          inc(r);
          edtTable.FieldbyName('SEQ_NO').AsInteger := r;
       end;
  finally
    edtTable.First;
    edtTable.EnableControls;
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
     if cdsStorage.Locate('SHOP_ID;PROPERTY_01;PROPERTY_02',varArrayOf([Global.SHOP_ID,copy(Column.FieldName,6,36),edtTable.FieldbyName('CODE_ID').asString]),[]) then
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
  if (AObj.FieldbyName('BATCH_NO').AsString = '#') or (AObj.FieldbyName('BATCH_NO').AsString = '') then
     cdsStorage.SQL.Text := 'select sum(AMOUNT) as AMOUNT,PROPERTY_01,PROPERTY_02,SHOP_ID from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID group by PROPERTY_01,PROPERTY_02,SHOP_ID'
  else
     cdsStorage.SQL.Text := 'select sum(AMOUNT) as AMOUNT,PROPERTY_01,PROPERTY_02,SHOP_ID from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID and BATCH_NO=:BATCH_NO group by PROPERTY_01,PROPERTY_02,SHOP_ID';
  cdsStorage.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
//  cdsStorage.Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID; 
  cdsStorage.Params.ParamByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  if cdsStorage.Params.FindParam('BATCH_NO')<>nil then cdsStorage.Params.FindParam('BATCH_NO').AsString := AObj.FieldbyName('BATCH_NO').AsString;
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
       if cdsStorage.Locate('PROPERTY_01;PROPERTY_02',varArrayOf([copy(Column.FieldName,6,36),edtTable.FieldbyName('CODE_ID').asString]),[]) then
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
               DataSet.FieldByName('PROPERTY_01').AsString := copy(edtTable.Fields[i].FieldName,6,36);
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
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  SaveColumn := nil;
  Simple := false;
  rs := Global.GetZQueryFromName('CA_SHOP_INFO');
  Column :=  FindDBColumn(DBGridEh2,'SHOP_ID');
  rs.First;
  while not rs.Eof do
     begin
       Column.KeyList.Add(rs.FieldbyName('SHOP_ID').AsString);
       Column.PickList.Add(rs.FieldbyName('SHOP_NAME').AsString);
       rs.next;
     end;
  rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
  Column :=  FindDBColumn(DBGridEh2,'PROPERTY_01');
  rs.First;
  while not rs.Eof do
     begin
       Column.KeyList.Add(rs.FieldbyName('SIZE_ID').AsString);
       Column.PickList.Add(rs.FieldbyName('SIZE_NAME').AsString);
       rs.next;
     end;
  rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
  Column :=  FindDBColumn(DBGridEh2,'PROPERTY_02');
  rs.First;
  while not rs.Eof do
     begin
       Column.KeyList.Add(rs.FieldbyName('COLOR_ID').AsString);
       Column.PickList.Add(rs.FieldbyName('COLOR_NAME').AsString);
       rs.next;
     end;
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
               AObj.FieldByName('PROPERTY_01').AsString := copy(edtTable.Fields[i].FieldName,6,36);
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

procedure TframeDialogProperty.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  DBGridEh2.visible := false;
  RzBitBtn1.visible := false;
end;

procedure TframeDialogProperty.stbHintClick(Sender: TObject);
begin
  inherited;
  DBGridEh2.visible := true;
  DBGridEh2.bringtoFront;
  RzBitBtn1.visible := true;

end;

end.
