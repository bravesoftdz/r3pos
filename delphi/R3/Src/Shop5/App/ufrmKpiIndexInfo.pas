unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox;

const
  WM_INIT_RECORD=WM_USER+4;
    
type
  TfrmKpiIndexInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzLabel1: TRzLabel;
    lab_KPI_NAME: TRzLabel;
    lab_IDX_TYPE: TRzLabel;
    RzLabel2: TRzLabel;
    edtKPI_NAME: TcxTextEdit;
    edtKPI_TYPE: TcxComboBox;
    lab_KPI_TYPE: TLabel;
    edtIDX_TYPE: TcxComboBox;
    edtKPI_DATA: TcxComboBox;
    lab_KPI_DATA: TLabel;
    lab_KPI_AGIO: TLabel;
    edtKPI_CALC: TcxComboBox;
    lab_KPI_CALC: TLabel;
    CdsKpiOption: TZQuery;
    Ds_KpiOption: TDataSource;
    edtKPI_AGIO: TcxTextEdit;
    RzLabel3: TRzLabel;
    CdsKpiIndex: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    CdsKpiGoods: TZQuery;
    Ds_KpiGoods: TDataSource;
    DBGridEh2: TDBGridEh;
    fndUNIT_ID: TcxComboBox;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    AddGoods: TMenuItem;
    DeleteGoods: TMenuItem;
    DeleteRecord: TMenuItem;
    edtKPI_OPTN: TcxCheckBox;
    Notebook1: TNotebook;
    edtEndDate: TcxDateEdit;
    edtBeginDate: TcxDateEdit;
    DBGridEh1: TDBGridEh;
    RzLabel4: TRzLabel;
    AddRecord_: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtKPI_TYPEPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fndUNIT_IDExit(Sender: TObject);
    procedure fndUNIT_IDEnter(Sender: TObject);
    procedure fndUNIT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndUNIT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndUNIT_IDPropertiesChange(Sender: TObject);
    procedure DBGridEh2Columns4BeforeShowControl(Sender: TObject);
    procedure edtBeginDateEnter(Sender: TObject);
    procedure edtEndDateEnter(Sender: TObject);
    procedure edtBeginDateExit(Sender: TObject);
    procedure edtEndDateExit(Sender: TObject);
    procedure edtBeginDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBeginDateKeyPress(Sender: TObject; var Key: Char);
    procedure edtBeginDatePropertiesChange(Sender: TObject);
    procedure edtEndDatePropertiesChange(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DeleteGoodsClick(Sender: TObject);
    procedure AddGoodsClick(Sender: TObject);
    procedure edtKPI_OPTNPropertiesChange(Sender: TObject);
    procedure DeleteRecordClick(Sender: TObject);
    procedure AddRecord_Click(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Saved:Boolean;
    procedure InitGrid;
    procedure WMInitRecord(var Message: TMessage); message WM_INIT_RECORD;
    procedure InitRecord;
    procedure OpenDialogGoods;
    procedure AddFromDialog(AObj:TRecord_);
    procedure FocusNextColumn;
  public
    { Public declarations }
    //SEQNO DbGrid1控制号
    RowID:integer;

    Aobj:TRecord_;
    function  FindColumn(FieldName:string):TColumnEh;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure Writeto(Aobj:TRecord_);
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:string):boolean;
  end;


implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,uframeSelectGoods;//
{$R *.dfm}

{ TfrmKipIndexInfo }

class function TfrmKpiIndexInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   //if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增用户的权限,请和管理员联系.');
   with TfrmKpiIndexInfo.Create(Owner) do
    begin
      try
        Append;
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmKpiIndexInfo.Append;
begin
  Open('');
  dbState := dsInsert;
  //InitRecord;

end;

procedure TfrmKpiIndexInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

class function TfrmKpiIndexInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
   //if not ShopGlobal.GetChkRight('31500001',3) then Raise Exception.Create('你没有修改用户的权限,请和管理员联系.');
   with TfrmKpiIndexInfo.Create(Owner) do
    begin
      try
        Edit(id);
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmKpiIndexInfo.Open(code: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('KPI_ID').AsString := code;
    Factor.BeginBatch;
    try
      Factor.AddBatch(CdsKpiIndex,'TKpiIndex',Params);
      Factor.AddBatch(CdsKpiOption,'TKpiOption',Params);
      Factor.AddBatch(CdsKpiGoods,'TKpiGoods',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  
    AObj.ReadFromDataSet(CdsKpiIndex);
    ReadFromObject(AObj,self);
    if Aobj.FieldByName('KPI_OPTN').AsString = '1' then
       begin
         edtKPI_OPTN.Checked := True;
         edtKPI_OPTN.Properties.OnChange(nil);
       end
    else
       begin
         edtKPI_OPTN.Checked := False;
         edtKPI_OPTN.Properties.OnChange(nil);
       end;
    RowID := CdsKpiOption.RecordCount;
    edtKPI_TYPE.Properties.OnChange(nil);
  finally
    Params.Free;
  end;
end;

procedure TfrmKpiIndexInfo.Save;
var Temp:TZQuery;
begin
  if dbState=dsBrowse then exit;
  if trim(edtKPI_NAME.Text)='' then
  begin
    if edtKPI_NAME.CanFocus then edtKPI_NAME.SetFocus;
    raise Exception.Create('指标名称不能为空！');
  end;
  if edtIDX_TYPE.ItemIndex = -1 then
  begin
    if edtIDX_TYPE.CanFocus then edtIDX_TYPE.SetFocus;
    raise Exception.Create('指标类型不能为空！');
  end;
  if edtKPI_TYPE.ItemIndex = -1 then
  begin
    if edtKPI_TYPE.CanFocus then edtKPI_TYPE.SetFocus;
    raise Exception.Create('考核类型不能为空！');
  end;

  //此检测，只对前台检测
  if dbState = dsInsert then
  begin
    Temp := TZQuery.Create(nil);
    try
      Temp.Close;
      Temp.SQL.Text := 'select KPI_NAME from MKT_KPI_INDEX where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and KPI_NAME='+QuotedStr(Trim(edtKPI_NAME.Text));
      Factor.Open(Temp);
      if Temp.FieldByName('KPI_NAME').AsString <> '' then
         raise Exception.Create('该指标名称已经存在，不能重复！');
    finally
      Temp.Free;
    end;
  end
  else if dbState = dsEdit then
  begin
    if Trim(edtKPI_NAME.Text) <> CdsKpiIndex.FieldByName('KPI_NAME').AsString then
    begin
      Temp := TZQuery.Create(nil);
      try
        Temp.Close;
        Temp.SQL.Text := 'select KPI_ID,KPI_NAME from MKT_KPI_INDEX where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and KPI_NAME='+QuotedStr(Trim(edtKPI_NAME.Text));
        Factor.Open(Temp);
        if Temp.FieldByName('KPI_ID').AsString <> AObj.FieldByName('KPI_ID').AsString then
           raise Exception.Create('该指标名称已经存在，不能重复！');
      finally
        Temp.Free;
      end;
    end;
  end;

  //检测结束
  WriteToObject(Aobj,self);

  Factor.BeginBatch;
  try
    if dbState=dsInsert then
    begin
      CdsKpiIndex.Append;
      Aobj.FieldByName('KPI_ID').AsString := TSequence.NewId;
      Aobj.FieldByName('TENANT_ID').AsInteger := ShopGlobal.TENANT_ID;
    end
    else if dbState=dsEdit then
      CdsKpiIndex.Edit;

    Aobj.WriteToDataSet(CdsKpiIndex);
    if edtKPI_OPTN.Checked then
       CdsKpiIndex.FieldByName('KPI_OPTN').AsString := '1'
    else
       CdsKpiIndex.FieldByName('KPI_OPTN').AsString := '0';
    CdsKpiIndex.Post;
    if edtKPI_OPTN.Checked then
    begin
      if edtKPI_TYPE.ItemIndex = 2 then
      begin
        CdsKpiOption.First;
        while not CdsKpiOption.Eof do
        begin
          CdsKpiOption.Edit;
          
          if CdsKpiOption.FieldByName('TENANT_ID').AsString = '' then
            CdsKpiOption.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          if CdsKpiOption.FieldByName('KPI_ID').AsString = '' then
            CdsKpiOption.FieldByName('KPI_ID').AsString := CdsKpiIndex.FieldbyName('KPI_ID').AsString;
          //日期判断
          //CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := Null;
          //CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := Null;
          CdsKpiOption.Post;
          CdsKpiOption.Next;
        end;
      end
      else
      begin
        CdsKpiOption.First;
        while not CdsKpiOption.Eof do
        begin
          CdsKpiOption.Edit;

          if CdsKpiOption.FieldByName('TENANT_ID').AsString = '' then
            CdsKpiOption.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          if CdsKpiOption.FieldByName('KPI_ID').AsString = '' then
            CdsKpiOption.FieldByName('KPI_ID').AsString := CdsKpiIndex.FieldbyName('KPI_ID').AsString;

          CdsKpiOption.FieldByName('KPI_DATE1').Value := Null;
          CdsKpiOption.FieldByName('KPI_DATE2').Value := Null;
          CdsKpiOption.Post;
          CdsKpiOption.Next;
        end;
      end;
    end
    else
    begin
      if not CdsKpiOption.IsEmpty then
         begin
           CdsKpiOption.First;
           while not CdsKpiOption.Eof do
             CdsKpiOption.Delete;
         end;
    end;

    CdsKpiGoods.First;
    while not CdsKpiGoods.Eof do
    begin
      CdsKpiGoods.Edit;
      if CdsKpiGoods.FieldByName('TENANT_ID').AsString = '' then
        CdsKpiGoods.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      if CdsKpiGoods.FieldByName('KPI_ID').AsString = '' then
        CdsKpiGoods.FieldByName('KPI_ID').AsString := CdsKpiIndex.FieldbyName('KPI_ID').AsString;

      CdsKpiGoods.Post;
      CdsKpiGoods.Next;
    end;

    Factor.AddBatch(CdsKpiIndex,'TKpiIndex');
    Factor.AddBatch(CdsKpiOption,'TKpiOption');
    Factor.AddBatch(CdsKpiGoods,'TKpiGoods');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    CdsKpiIndex.CancelUpdates;
    CdsKpiOption.CancelUpdates;
    CdsKpiGoods.CancelUpdates;
  end;
  dbState:=dsBrowse;
  Saved:=True;
end;

class function TfrmKpiIndexInfo.ShowDialog(Owner: TForm;
  id: string): boolean;
begin
   with TfrmKpiIndexInfo.Create(Owner) do
    begin
      try
        Open(id);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmKpiIndexInfo.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
  RowID := 0;
  InitGrid;
end;

procedure TfrmKpiIndexInfo.Writeto(Aobj: TRecord_);
begin
  WriteToObject(Aobj,self);
end;

procedure TfrmKpiIndexInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmKpiIndexInfo.Btn_SaveClick(Sender: TObject);
var bl:Boolean;
begin
  inherited;
  bl := (dbState <> dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增指标?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmKpiIndexInfo.edtKPI_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtKPI_TYPE.ItemIndex = 2 then
  begin
     DBGridEh1.Columns[1].Visible := True;
     DBGridEh1.Columns[2].Visible := True;
  end
  else
  begin
     DBGridEh1.Columns[1].Visible := False;
     DBGridEh1.Columns[2].Visible := False;
  end;
end;

procedure TfrmKpiIndexInfo.FormDestroy(Sender: TObject);            
begin
  inherited;
  Aobj.Free;
  fndUNIT_ID.Properties.Items.Clear;
  Freeform(Self);
end;

procedure TfrmKpiIndexInfo.FormShow(Sender: TObject);
begin
  inherited;
  DBGridEh1.Columns[1].Visible := False;
  DBGridEh1.Columns[2].Visible := False;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmKpiIndexInfo.fndUNIT_IDExit(Sender: TObject);
begin
  inherited;
  fndUNIT_ID.Visible := False;
end;

procedure TfrmKpiIndexInfo.fndUNIT_IDEnter(Sender: TObject);
begin
  inherited;
  fndUNIT_ID.Properties.ReadOnly := DBGridEh2.ReadOnly;
end;

procedure TfrmKpiIndexInfo.fndUNIT_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) then
     begin
       DBGridEh2.SetFocus;
       fndUNIT_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_LEFT) then
     begin
       DBGridEh2.SetFocus;
       fndUNIT_ID.Visible := false;
       DBGridEh2.Col := DBGridEh2.Col -1;
     end;
  if (Key=VK_UP) and (Shift=[]) and not fndUNIT_ID.DroppedDown then
     begin
       DBGridEh2.SetFocus;
       fndUNIT_ID.Visible := false;
       if CdsKpiGoods.Active then CdsKpiGoods.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not fndUNIT_ID.DroppedDown then
     begin
       DBGridEh2.SetFocus;
       fndUNIT_ID.Visible := false;
       //PostMessage(Handle,WM_NEXT_RECORD,0,0);
       if CdsKpiGoods.Active then
         begin
           CdsKpiGoods.Next;
           if CdsKpiGoods.Eof then
              CdsKpiGoods.First;

         end;
     end;
  {if Key=VK_SHIFT then
    begin
      if edtTable.IsEmpty then Exit;
      if DBGridEh1.Columns[DBGridEh1.Col].FieldName='IS_PRESENT' then
         begin
           ConvertPresent;
         end;
      if DBGridEh1.Columns[DBGridEh1.Col].FieldName='UNIT_ID' then
         begin
           ConvertUnit;
       end;
    end;}
end;

procedure TfrmKpiIndexInfo.fndUNIT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       DBGridEh2.SetFocus;
       FocusNextColumn;
     end;
end;

procedure TfrmKpiIndexInfo.fndUNIT_IDPropertiesChange(Sender: TObject);
var
  w:integer;
  rs:TZQuery;
begin
  inherited;
  if fndUNIT_ID.Tag = 1 then Exit;
  if fndUNIT_ID.ItemIndex < 0 then Exit;
  if not fndUNIT_ID.Visible then Exit;
  w := Integer(fndUNIT_ID.Properties.Items.Objects[fndUNIT_ID.ItemIndex]);
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',CdsKpiGoods.FieldbyName('GODS_ID').AsString,[]) then
     begin
       CdsKpiGoods.Edit;
       case w of
       0:CdsKpiGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('CALC_UNITS').AsString;
       1:CdsKpiGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('SMALL_UNITS').AsString;
       2:CdsKpiGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('BIG_UNITS').AsString;
       end;
     end;
end;

procedure TfrmKpiIndexInfo.InitGrid;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  Column := FindColumn('UNIT_ID');
  if Column<>nil then
  begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  Column.ReadOnly := true;
  Column.Control := fndUNIT_ID;
  Column.OnBeforeShowControl := DBGridEh2Columns4BeforeShowControl;
  end;
end;

procedure TfrmKpiIndexInfo.FocusNextColumn;
var i:Integer;
begin
  if RzPage.ActivePageIndex = 0 then
  begin
    i:=DbGridEh1.Col;
    if CdsKpiOption.RecordCount>CdsKpiOption.RecNo then
       begin
         CdsKpiOption.Next;
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
             if Trim(CdsKpiOption.FieldbyName('KPI_ID').asString)='' then
                i := 1;
             if (i=1) and (Trim(CdsKpiOption.FieldbyName('KPI_ID').asString)<>'') then
                begin
                   CdsKpiOption.Next ;
                   if CdsKpiOption.Eof then
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
  end
  else if RzPage.ActivePageIndex = 1 then
  begin
    i:=DbGridEh2.Col;
    if CdsKpiGoods.RecordCount>CdsKpiGoods.RecNo then
       begin
         CdsKpiGoods.Next;
         Exit;
       end;
    Inc(i);
    while True do
      begin
        if i>=DbGridEh2.Columns.Count then i:= 1;
        if (DbGridEh2.Columns[i].ReadOnly or not DbGridEh2.Columns[i].Visible) and (i<>1) then
           inc(i)
        else
           begin
             if Trim(CdsKpiGoods.FieldbyName('GODS_ID').asString)='' then
                i := 1;
             if (i=1) and (Trim(CdsKpiGoods.FieldbyName('GODS_ID').asString)<>'') then
                begin
                   CdsKpiGoods.Next ;
                   if CdsKpiGoods.Eof then
                      begin
                        CdsKpiGoods.First;
                      end;
                   DbGridEh2.SetFocus;
                   DbGridEh2.Col := 1 ;
                end
             else
                DbGridEh2.Col := i;
             Exit;
           end;
      end;
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh2Columns4BeforeShowControl(
  Sender: TObject);
var
  rs:TZQuery;
  us:TZQuery;
begin
  inherited;
  fndUNIT_ID.Tag := 1;
  try
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  us := Global.GetZQueryFromName('PUB_MEAUNITS');
  fndUNIT_ID.Properties.Items.Clear;
  if rs.Locate('GODS_ID',CdsKpiGoods.FieldbyName('GODS_ID').AsString,[]) then
     begin
       if us.Locate('UNIT_ID',rs.FieldbyName('CALC_UNITS').AsString,[]) then
          fndUNIT_ID.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(0));
       if us.Locate('UNIT_ID',rs.FieldbyName('SMALL_UNITS').AsString,[]) then
          fndUNIT_ID.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(1));
       if us.Locate('UNIT_ID',rs.FieldbyName('BIG_UNITS').AsString,[]) then
          fndUNIT_ID.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(2));
     end;
  if us.Locate('UNIT_ID',CdsKpiGoods.FieldbyName('UNIT_ID').AsString,[]) then
     begin
       fndUNIT_ID.Properties.ReadOnly := false;
       fndUNIT_ID.ItemIndex := fndUNIT_ID.Properties.Items.IndexOf(us.FieldbyName('UNIT_NAME').AsString);
       fndUNIT_ID.Properties.ReadOnly := (dbState = dsBrowse);
     end;
  finally
     fndUNIT_ID.Tag := 0;
  end;
end;

function TfrmKpiIndexInfo.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh2.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh2.Columns[i];
           Exit;
         end;
    end;
end;

procedure TfrmKpiIndexInfo.edtBeginDateEnter(Sender: TObject);
begin
  inherited;
  edtBeginDate.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmKpiIndexInfo.edtEndDateEnter(Sender: TObject);
begin
  inherited;
  edtEndDate.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmKpiIndexInfo.edtBeginDateExit(Sender: TObject);
begin
  inherited;
  if not edtBeginDate.DroppedDown then edtBeginDate.Visible := False;
end;

procedure TfrmKpiIndexInfo.edtEndDateExit(Sender: TObject);
begin
  inherited;
  if not edtEndDate.DroppedDown then edtEndDate.Visible := False;
end;

procedure TfrmKpiIndexInfo.edtBeginDateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtBeginDate.EditModified then
     begin
       DBGridEh1.SetFocus;
       edtBeginDate.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtBeginDate.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       edtBeginDate.Visible := false;
       CdsKpiGoods.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtBeginDate.DroppedDown then
     begin
       if (CdsKpiGoods.FieldByName('SEQNO').AsString<>'') and (CdsKpiGoods.FieldByName('KPI_ID').AsString='') then
         //
       else
       begin
         DBGridEh1.SetFocus;
         edtBeginDate.Visible := false;
         CdsKpiGoods.Next;
         if CdsKpiGoods.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (CdsKpiGoods.FieldByName('KPI_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;

end;

procedure TfrmKpiIndexInfo.WMInitRecord(var Message: TMessage);
begin
  InitRecord;
end;

procedure TfrmKpiIndexInfo.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if CdsKpiOption.State in [dsEdit,dsInsert] then CdsKpiOption.Post;
  //fndGODS_ID.Visible := false;
  CdsKpiOption.DisableControls;
  try
    CdsKpiOption.Last;
    //if (CdsKpiOption.FieldbyName('KPI_ID').AsString = '') then
    //begin
      inc(RowID);
      CdsKpiOption.Append;
      CdsKpiOption.FieldByName('KPI_ID').Value := null;
      if CdsKpiOption.FindField('SEQNO')<> nil then
         CdsKpiOption.FindField('SEQNO').asInteger := RowID;
      CdsKpiOption.Post;
    //end;
    if edtKPI_TYPE.ItemIndex = 2 then
       DBGridEh1.Col := 1
    else
       DbGridEh1.Col := 3;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    CdsKpiOption.EnableControls;
    CdsKpiOption.Edit;
  end;
end;

procedure TfrmKpiIndexInfo.edtBeginDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if CdsKpiOption.FieldbyName('KPI_ID').AsString = '' then
          begin
            edtBeginDate.Properties.BeginUpdate;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.edtBeginDatePropertiesChange(Sender: TObject);
begin
  inherited;
  if not CdsKpiOption.Active then Exit;

  CdsKpiOption.Edit;
  CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',edtBeginDate.Date));
  CdsKpiOption.Post;
end;

procedure TfrmKpiIndexInfo.edtEndDatePropertiesChange(Sender: TObject);
begin
  inherited;
  if not CdsKpiOption.Active then Exit;

  CdsKpiOption.Edit;
  CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',edtEndDate.Date));
  CdsKpiOption.Post;
end;

procedure TfrmKpiIndexInfo.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.FillRect(ARect);
      DrawText(DbGridEh2.Canvas.Handle,pchar(Inttostr(CdsKpiGoods.RecNo)),length(Inttostr(CdsKpiGoods.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndexInfo.DeleteGoodsClick(Sender: TObject);
begin
  inherited;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiGoods.IsEmpty and (MessageBox(Handle,pchar('确认删除"'+CdsKpiGoods.FieldbyName('GODS_NAME').AsString+'"商品吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       CdsKpiGoods.Delete;
       DBGridEh2.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.OpenDialogGoods;
var
  AObj:TRecord_;
begin
  with TframeSelectGoods.Create(self) do
    begin
      try
        MultiSelect := false;
        edtSearch.Text := '';
        OnSave := AddFromDialog;
        if ShowModal=MROK then
           begin
             cdsList.first;
             while not cdsList.eof do
               begin
                 AObj := TRecord_.Create;
                 try
                   AObj.ReadFromDataSet(cdsList);
                   AddFromDialog(AObj);
                 finally
                   AObj.Free;
                 end;
                 cdsList.Next;
               end;
           end;
      finally
        free;
      end;
    end;

end;

procedure TfrmKpiIndexInfo.AddFromDialog(AObj: TRecord_);
var basInfo:TZQuery;
begin
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  if not basInfo.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
  //AddRecord(AObj,basInfo.FieldbyName('UNIT_ID').AsString,True);
  CdsKpiGoods.Append;
  CdsKpiGoods.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  CdsKpiGoods.FieldByName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
  CdsKpiGoods.FieldByName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
  CdsKpiGoods.FieldByName('BARCODE').AsString := AObj.FieldbyName('BARCODE').AsString;
  CdsKpiGoods.FieldByName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString;
  CdsKpiGoods.Post;
end;

procedure TfrmKpiIndexInfo.AddGoodsClick(Sender: TObject);
begin
  inherited;
  if DBGridEh2.ReadOnly then Exit;
  OpenDialogGoods;
end;

procedure TfrmKpiIndexInfo.edtKPI_OPTNPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtKPI_OPTN.Checked then
     Notebook1.ActivePage := 'P1'
  else
     Notebook1.ActivePage := 'P0';
end;

procedure TfrmKpiIndexInfo.DeleteRecordClick(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiOption.IsEmpty and (MessageBox(Handle,pchar('确认删除本标准吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       CdsKpiOption.Delete;
       Dec(RowID);
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.AddRecord_Click(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  InitRecord;
end;

procedure TfrmKpiIndexInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Btn_Save.Visible := (value<>dsBrowse);
  edtKPI_OPTN.Enabled := (value<>dsBrowse);
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  DBGridEh2.ReadOnly := (Value=dsBrowse);
  case dbState of
  dsInsert:Caption:='考核指标--(新增)';
  dsEdit:Caption:='考核指标--(修改)';
  else
    begin
      Caption:='考核指标';
    end;
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmKpiIndexInfo.DBGridEh2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

end.
