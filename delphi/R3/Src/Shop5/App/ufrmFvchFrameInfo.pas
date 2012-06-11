unit ufrmFvchFrameInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  StdCtrls, RzLabel, RzButton, cxMemo, ZBase, DB, ZAbstractRODataset, ObjCommon,
  ZAbstractDataset, ZDataset, cxCheckBox, Grids, DBGridEh;

type
  TfrmFvchFrameInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzLabel6: TRzLabel;
    cdsFvchFrame: TZQuery;
    RzPanel3: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    Label1: TLabel;
    Label2: TLabel;
    edtAMONEY: TcxComboBox;
    CdsFvchSwhere: TZQuery;
    DsFvchFrame: TDataSource;
    edtAMONEY_2: TcxComboBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label9: TLabel;
    edtFVCH_GTYPE: TcxTextEdit;
    Label3: TLabel;
    edtFVCH_NAME: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtAMONEYEnter(Sender: TObject);
    procedure edtAMONEYExit(Sender: TObject);
    procedure edtAMONEYKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAMONEYKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh1Columns3BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns4BeforeShowControl(Sender: TObject);
    procedure edtAMONEY_2Enter(Sender: TObject);
    procedure edtAMONEY_2Exit(Sender: TObject);
    procedure edtAMONEYPropertiesChange(Sender: TObject);
    procedure edtAMONEY_2PropertiesChange(Sender: TObject);
    procedure edtAMONEY_2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAMONEY_2KeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    RowID:Integer;
    FSEQ_NO: Integer;
    FFVCH_GTYPE: String;
    procedure SetSEQ_NO(const Value: Integer);
    procedure SetFVCH_GTYPE(const Value: String);
    procedure FocusNextColumn;
    procedure AddRecord;
    //procedure UpdateRecord(AObj:TRecord_;UNIT_ID:string;pt:boolean=false);
    procedure DelRecord;
    procedure InitRecord;
    procedure ClearNullRecord;
    function  FindColumn(FieldName:string):TColumnEh;
  public
    { Public declarations }
    Saved,locked:boolean;
    Aobj:TRecord_;
    destructor Destroy;override;
    procedure Open;
    procedure Save;
    property SEQ_NO:Integer read FSEQ_NO write SetSEQ_NO;
    property FVCH_GTYPE:String read FFVCH_GTYPE write SetFVCH_GTYPE;
  end;

implementation
uses uDsUtil, uShopUtil, ufrmBasic, Math, uGlobal, uFnUtil, uShopGlobal, ufrmFvchFrameDefine,
uXDictFactory;
{$R *.dfm}

{ TfrmFvchFrameInfo }

procedure TfrmFvchFrameInfo.Open;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('FVCH_GTYPE').AsString := FVCH_GTYPE;
    Params.ParamByName('TYPE_CODE').AsString := 'FVCH_DATA_'+FVCH_GTYPE;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsFvchFrame,'TFvchFrame',Params);
      Factor.AddBatch(CdsFvchSwhere,'TFvchSwhere',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
    end;
    edtFVCH_NAME.Text := cdsFvchFrame.FieldByName('FVCH_NAME').AsString;
    RowID := cdsFvchFrame.RecordCount;
    InitRecord;
  finally
    Params.Free;
  end;
end;

procedure TfrmFvchFrameInfo.Save;
var tmp:TZQuery;
    i,j:integer;
begin
  if Trim(edtFVCH_NAME.Text) = '' then Raise Exception.Create('凭证字不能为空!');
  cdsFvchFrame.DisableControls;
  try
    j := cdsFvchFrame.RecNo;
    cdsFvchFrame.First;
    while not cdsFvchFrame.Eof do
    begin
      if (Trim(cdsFvchFrame.FieldByName('SUMMARY').AsString) = '') and (Trim(cdsFvchFrame.FieldByName('SUBJECT_NO').AsString) <> '') then
      begin
         j := cdsFvchFrame.RecNo;
         Raise Exception.Create('序号"'+IntToStr(j)+'"中摘要不能为空!');
      end;
      if (Trim(cdsFvchFrame.FieldByName('SUBJECT_TYPE').AsString) = '') and (Trim(cdsFvchFrame.FieldByName('SUBJECT_NO').AsString) <> '') then
      begin
         j := cdsFvchFrame.RecNo;
         Raise Exception.Create('序号"'+IntToStr(j)+'"中"贷方、借方"两者其一必填!');
      end;
      cdsFvchFrame.Next;
    end;
    ClearNullRecord;
    i := 0;
    cdsFvchFrame.First;
    while not cdsFvchFrame.Eof do
    begin
      Inc(i);
      cdsFvchFrame.Edit;
      cdsFvchFrame.FieldByName('SEQNO').AsInteger := i;
      cdsFvchFrame.FieldByName('FVCH_NAME').AsString := Trim(edtFVCH_NAME.Text);
      cdsFvchFrame.Post;
      cdsFvchFrame.Next;
    end;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsFvchFrame,'TFvchFrame',nil);
      Factor.AddBatch(CdsFvchSwhere,'TFvchSwhere',nil);
      Factor.CommitBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    cdsFvchFrame.EnableControls;
  end;
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmFvchFrameInfo.SetSEQ_NO(const Value: Integer);
begin
  FSEQ_NO := Value;
end;

procedure TfrmFvchFrameInfo.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
end;

procedure TfrmFvchFrameInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmFvchFrameInfo.Destroy;
begin
  ClearCbxPickList(edtAMONEY);
  ClearCbxPickList(edtAMONEY_2);
  FreeAndNil(Aobj);
  inherited;
end;

procedure TfrmFvchFrameInfo.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  Save;
  ModalResult := mrOk;
end;

procedure TfrmFvchFrameInfo.SetFVCH_GTYPE(const Value: String);
var i:Integer;
    rs,Rs_Params:TZQuery;
    sSql:String;
begin
  FFVCH_GTYPE := Value;
  //xhh修改成取Global
  Rs_Params:=Global.GetZQueryFromName('PUB_PARAMS');
  if (Rs_Params<>nil) and (not Rs_Params.IsEmpty) then
  begin
    if Rs_Params.Locate('TYPE_CODE;CODE_ID',VarArrayOf(['BILL_NAME',FFVCH_GTYPE]),[]) then
    begin
       Label1.Caption := Rs_Params.FieldByName('CODE_NAME').AsString+'模板';
       edtFVCH_GTYPE.Text := Rs_Params.FieldByName('CODE_NAME').AsString;
    end;
  end;

  rs := TZQuery.Create(nil);
  try
    sSql :='select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=:TYPE_CODE and CODE_ID not in (''CALC_AMOUNT'',''APRICE'',''COST_ APRICE'') ';
    if trim(FFVCH_GTYPE)='11' then
      sSql := sSql +
        ' union all '+
        ' select ''PAY_'' '+GetStrJoin(Factor.iDbType)+' CODE_ID as CODE_ID,CODE_NAME from VIW_PAYMENT where TENANT_ID=:TENANT_ID ';
    rs.Close;
    rs.SQL.Text:=sSql;
    rs.Params.ParamByName('TYPE_CODE').AsString := 'FVCH_DATA_'+Value;
    if rs.Params.FindParam('TENANT_ID') <> nil then rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    AddCbxPickList(edtAMONEY,'',rs);
    AddCbxPickList(edtAMONEY_2,'',rs);
  finally
    rs.Free;
  end;
end;

procedure TfrmFvchFrameInfo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsFvchFrame.RecNo)),length(Inttostr(cdsFvchFrame.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'OPTION_SET' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(DBGridEh1.Canvas.Font);
      try
        DBGridEh1.canvas.FillRect(ARect);
        DBGridEh1.Canvas.Font.Color := clBlue;
        DBGridEh1.Canvas.Font.Style := [fsUnderline];
        DrawText(DBGridEh1.Canvas.Handle,pchar('编辑'),length('编辑'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER);
      finally
        DBGridEh1.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
end;

procedure TfrmFvchFrameInfo.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName = 'OPTION_SET' then
  begin
    if cdsFvchFrame.FieldByName('SUBJECT_NO').AsString = '' then Raise Exception.Create('"科目代码"不能为空!');
    if cdsFvchFrame.FieldByName('SUMMARY').AsString = '' then Raise Exception.Create('"摘要"不能为空!');
    with TfrmFvchFrameDefine.Create(Self) do
    begin
      try
        DataFlag := cdsFvchFrame.FieldByName('DATAFLAG').AsString;
        SubjectNo := cdsFvchFrame.FieldByName('SUBJECT_NO').AsString;
        sWhere := cdsFvchFrame.FieldByName('SWHERE').AsString;
        FvchType := FVCH_GTYPE;
        DataSet_Swhere := CdsFvchSwhere;
        if ShowModal = mrOk then
        begin
           cdsFvchFrame.Edit;
           cdsFvchFrame.FieldByName('DATAFLAG').AsString := DataFlag;
           cdsFvchFrame.Post;
        end;
      finally
        Free;
      end;
    end;
    DBGridEh1.Col := 0;
  end;
end;

procedure TfrmFvchFrameInfo.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  if cdsFvchFrame.RecordCount>cdsFvchFrame.RecNo then
     begin
       cdsFvchFrame.Next;
       Exit;
     end;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsFvchFrame.FieldbyName('SUBJECT_NO').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsFvchFrame.FieldbyName('SUBJECT_NO').asString)<>'') then
              begin
                 cdsFvchFrame.Next ;
                 if cdsFvchFrame.Eof then
                    begin
                      InitRecord;
                    end;
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmFvchFrameInfo.InitRecord;
var iFvch:Integer;
begin
  if cdsFvchFrame.State in [dsEdit,dsInsert] then cdsFvchFrame.Post;
  cdsFvchFrame.DisableControls;
  try
  cdsFvchFrame.Last;
  if cdsFvchFrame.IsEmpty or (cdsFvchFrame.FieldbyName('SUBJECT_NO').AsString <>'') then
    begin
      inc(RowID);
      cdsFvchFrame.Append;
      cdsFvchFrame.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      cdsFvchFrame.FieldByName('FVCH_GTYPE').AsString := FVCH_GTYPE;
      cdsFvchFrame.FieldByName('SWHERE').AsString := TSequence.NewId;
      {iFvch := StrToInt(FVCH_GTYPE);
      case iFvch of
        1,2,3,4,5,6,11:begin
          cdsFvchFrame.FieldByName('AMOUNT').AsString := 'CALC_AMOUNT';
          cdsFvchFrame.FieldByName('APRICE').AsString := 'APRICE';
        end;
        7,8:begin
          cdsFvchFrame.FieldByName('AMOUNT').AsString := 'CALC_AMOUNT';
          cdsFvchFrame.FieldByName('APRICE').AsString := '';
        end;
        9,10,12,13,14,15:begin
          cdsFvchFrame.FieldByName('AMOUNT').AsString := '';
          cdsFvchFrame.FieldByName('APRICE').AsString := '';
        end;
      end;}
      cdsFvchFrame.FieldByName('DATAFLAG').AsString := '00000000';
      cdsFvchFrame.FieldByName('SUBJECT_NO').Value := null;
      cdsFvchFrame.FieldByName('SUMMARY').Value := null;
      if cdsFvchFrame.FindField('SEQNO')<> nil then
         cdsFvchFrame.FindField('SEQNO').asInteger := RowID;
      cdsFvchFrame.Post;
    end;
    DbGridEh1.Col := 1 ;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    cdsFvchFrame.EnableControls;
    cdsFvchFrame.Edit;
  end;
end;

procedure TfrmFvchFrameInfo.AddRecord;
begin
  inc(RowID);
  if (cdsFvchFrame.FieldbyName('GODS_ID').asString='') and (cdsFvchFrame.FieldbyName('SEQNO').asString<>'') then
  cdsFvchFrame.Edit else InitRecord;
  cdsFvchFrame.FieldbyName('GODS_ID').AsString := '';
  cdsFvchFrame.FieldbyName('GODS_NAME').AsString := '';
  cdsFvchFrame.FieldbyName('GODS_CODE').AsString := '';
  cdsFvchFrame.FieldByName('IS_PRESENT').asInteger := 0;
  cdsFvchFrame.FieldbyName('BATCH_NO').AsString := '#';
  cdsFvchFrame.Edit;

end;

procedure TfrmFvchFrameInfo.FormShow(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmFvchFrameInfo.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#13) then
     begin
       FocusNextColumn;
       Key := #0;
     end;
  inherited;
end;

procedure TfrmFvchFrameInfo.edtAMONEYEnter(Sender: TObject);
begin
  inherited;
  edtAMONEY.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmFvchFrameInfo.edtAMONEYExit(Sender: TObject);
begin
  inherited;
  edtAMONEY.Visible := false;
end;

procedure TfrmFvchFrameInfo.edtAMONEYKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_LEFT) then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       DBGridEh1.Col := DBGridEh1.Col -1;
     end;
  if (Key=VK_UP) and (Shift=[]) and not edtAMONEY.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       if cdsFvchFrame.Active then cdsFvchFrame.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtAMONEY.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       if cdsFvchFrame.Active then
       begin
          cdsFvchFrame.Next;
          if cdsFvchFrame.Eof then InitRecord;
       end;
     end;
  if Key=VK_SHIFT then
     begin

     end;
end;

procedure TfrmFvchFrameInfo.edtAMONEYKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       DBGridEh1.SetFocus;
       FocusNextColumn;
     end;

end;

procedure TfrmFvchFrameInfo.DBGridEh1DrawFooterCell(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'SUBJECT_NO' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       if FindColumn('SUMMARY') <> nil then
          R.Right := Rect.Right + FindColumn('SUMMARY').Width;

       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s科目',[Inttostr(cdsFvchFrame.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left) div 2,Rect.Top+2,s);
     end;
end;

function TfrmFvchFrameInfo.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;

procedure TfrmFvchFrameInfo.DBGridEh1Columns3BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  if Trim(cdsFvchFrame.FieldByName('SUBJECT_TYPE_1').AsString) <> '' then
     edtAMONEY.ItemIndex := edtAMONEY.Properties.Items.IndexOf(cdsFvchFrame.FieldByName('SUBJECT_TYPE_1').AsString);
  edtAMONEY.Visible := True;
end;

procedure TfrmFvchFrameInfo.DBGridEh1Columns4BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  if Trim(cdsFvchFrame.FieldByName('SUBJECT_TYPE_2').AsString) <> '' then
     edtAMONEY.ItemIndex := edtAMONEY.Properties.Items.IndexOf(cdsFvchFrame.FieldByName('SUBJECT_TYPE_2').AsString);
  edtAMONEY_2.Visible := True;
end;

procedure TfrmFvchFrameInfo.edtAMONEY_2Enter(Sender: TObject);
begin
  inherited;
  edtAMONEY_2.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmFvchFrameInfo.edtAMONEY_2Exit(Sender: TObject);
begin
  inherited;
  edtAMONEY_2.Visible := False;
end;

procedure TfrmFvchFrameInfo.edtAMONEYPropertiesChange(Sender: TObject);
var sAmoney:String;
begin
  inherited;
  if edtAMONEY.ItemIndex < 0 then Exit;
  if not edtAMONEY.Visible then Exit;
  sAmoney := TRecord_(edtAMONEY.Properties.Items.Objects[edtAMONEY.ItemIndex]).FieldByName('CODE_ID').AsString;
  cdsFvchFrame.Edit;
  cdsFvchFrame.FieldByName('AMONEY').AsString := sAmoney;
  cdsFvchFrame.FieldByName('SUBJECT_TYPE').AsString := '1';
  cdsFvchFrame.FieldByName('SUBJECT_TYPE_1').AsString := edtAMONEY.Text;
  cdsFvchFrame.FieldByName('SUBJECT_TYPE_2').AsString := '';
  cdsFvchFrame.Post;
  cdsFvchFrame.Edit;
end;

procedure TfrmFvchFrameInfo.edtAMONEY_2PropertiesChange(Sender: TObject);
var sAmoney:String;
begin
  inherited;
  if edtAMONEY_2.ItemIndex < 0 then Exit;
  if not edtAMONEY_2.Visible then Exit;
  sAmoney := TRecord_(edtAMONEY_2.Properties.Items.Objects[edtAMONEY_2.ItemIndex]).FieldByName('CODE_ID').AsString;
  cdsFvchFrame.Edit;
  cdsFvchFrame.FieldByName('AMONEY').AsString := sAmoney;
  cdsFvchFrame.FieldByName('SUBJECT_TYPE').AsString := '2';
  cdsFvchFrame.FieldByName('SUBJECT_TYPE_2').AsString := edtAMONEY_2.Text;
  cdsFvchFrame.FieldByName('SUBJECT_TYPE_1').AsString := '';
  cdsFvchFrame.Post;
  cdsFvchFrame.Edit;
end;

procedure TfrmFvchFrameInfo.edtAMONEY_2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_LEFT) then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       DBGridEh1.Col := DBGridEh1.Col -1;
     end;
  if (Key=VK_UP) and (Shift=[]) and not edtAMONEY.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       if cdsFvchFrame.Active then cdsFvchFrame.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtAMONEY.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       edtAMONEY.Visible := false;
       if cdsFvchFrame.Active then
       begin
          cdsFvchFrame.Next;
          if cdsFvchFrame.Eof then InitRecord;
       end;
     end;
  if Key=VK_SHIFT then
     begin

     end;
end;

procedure TfrmFvchFrameInfo.edtAMONEY_2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       DBGridEh1.SetFocus;
       FocusNextColumn;
     end;
end;

procedure TfrmFvchFrameInfo.N1Click(Sender: TObject);
begin
  inherited;
  InitRecord;
end;

procedure TfrmFvchFrameInfo.N2Click(Sender: TObject);
begin
  inherited;
  DelRecord;
end;

procedure TfrmFvchFrameInfo.DelRecord;
var i:Integer;
begin
  if not cdsFvchFrame.IsEmpty then Exit;
  i:=MessageBox(Handle,Pchar('确定要删除当前科目?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  if i <> 6 then Exit;
  cdsFvchFrame.DisableControls;
  try
    CdsFvchSwhere.Filtered := False;
    CdsFvchSwhere.Filter := 'SWHERE='+QuotedStr(cdsFvchFrame.FieldByName('SWHERE').AsString);
    CdsFvchSwhere.Filtered := True;
    if not CdsFvchSwhere.IsEmpty then
    begin
       CdsFvchSwhere.First;
       while not CdsFvchSwhere.Eof do CdsFvchSwhere.Delete;
    end;
    cdsFvchFrame.Delete;
  finally
    CdsFvchSwhere.Filtered := False;
    cdsFvchFrame.EnableControls;
  end;
end;

procedure TfrmFvchFrameInfo.ClearNullRecord;
var
  Field:TField;
  Controls:boolean;
  r:integer;
begin
  if cdsFvchFrame.State in [dsEdit,dsInsert] then cdsFvchFrame.Post;
  Controls := cdsFvchFrame.ControlsDisabled;
  r := cdsFvchFrame.RecNo;
  cdsFvchFrame.DisableControls;
  try
  cdsFvchFrame.First;
  while not cdsFvchFrame.Eof do
    begin
      if (cdsFvchFrame.FieldByName('SUBJECT_NO').AsString = '') then
         cdsFvchFrame.Delete
      else
         cdsFvchFrame.Next;
    end;
  finally
    if r>0 then cdsFvchFrame.RecNo := r;
    if not Controls then  cdsFvchFrame.EnableControls;
  end;
end;

end.

