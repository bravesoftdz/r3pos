unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox, DateUtils,
  cxMemo;

const
  WM_INIT_RECORD=WM_USER+4;

type
  TDateRecord = Record
    BeginDate:Integer;
    EndDate:Integer;
  end;
  
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
    CdsKpiLevel: TZQuery;
    Ds_KpiLevel: TDataSource;
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
    Notebook1: TNotebook;
    DBGridEh1: TDBGridEh;
    RzLabel4: TRzLabel;
    AddRecord_: TMenuItem;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    edtUNIT_NAME: TcxTextEdit;
    RzLabel11: TRzLabel;
    edtKPI_SPELL: TcxTextEdit;
    edtREMARK: TcxMemo;
    RzLabel5: TRzLabel;
    TabSheet3: TRzTabSheet;
    RzPanel3: TRzPanel;
    DBGridEh3: TDBGridEh;
    Ds_KpiTimes: TDataSource;
    CdsKpiTimes: TZQuery;
    PopupMenu3: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fndUNIT_IDExit(Sender: TObject);
    procedure fndUNIT_IDEnter(Sender: TObject);
    procedure fndUNIT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndUNIT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndUNIT_IDPropertiesChange(Sender: TObject);
    procedure DBGridEh2Columns4BeforeShowControl(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DeleteGoodsClick(Sender: TObject);
    procedure AddGoodsClick(Sender: TObject);
    procedure DeleteRecordClick(Sender: TObject);
    procedure AddRecord_Click(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh2KeyPress(Sender: TObject; var Key: Char);
    procedure edtIDX_TYPEPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtKPI_NAMEPropertiesChange(Sender: TObject);
    procedure DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    Saved,DisplayPer:Boolean;
    KpiAgioFront,KpiAgioBack:String;
    Changed:Boolean;
    CurYear:Integer;
    function IsNull:Boolean;
    procedure ShowGrid;
    procedure InitGrid;
    procedure WMInitRecord(var Message: TMessage); message WM_INIT_RECORD;
    procedure InitRecord;
    procedure InitTimesRecord;
    procedure OpenDialogGoods;
    procedure AddFromDialog(AObj:TRecord_);
    procedure FocusNextColumn;
  public
    { Public declarations }
    RowID:integer;
    Aobj:TRecord_;
    destructor Destroy;override;
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
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,uframeSelectGoods,ufrmKpiTimes;//
{$R *.dfm}

{ TfrmKipIndexInfo }

class function TfrmKpiIndexInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002143',2) then Raise Exception.Create('你没有新增考核指标的权限,请和管理员联系.');
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
  Aobj.FieldByName('KPI_ID').AsString := TSequence.NewId;
  edtKPI_TYPE.ItemIndex := TdsItems.FindItems(edtKPI_TYPE.Properties.Items,'CODE_ID','1');
  edtIDX_TYPE.ItemIndex := TdsItems.FindItems(edtIDX_TYPE.Properties.Items,'CODE_ID','1');
end;

procedure TfrmKpiIndexInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

class function TfrmKpiIndexInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002143',3) then Raise Exception.Create('你没有修改考核指标的权限,请和管理员联系.');
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
      Factor.AddBatch(CdsKpiLevel,'TKpiLevel',Params);
      Factor.AddBatch(CdsKpiGoods,'TKpiGoods',Params);
      Factor.AddBatch(CdsKpiTimes,'TKpiTimes',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;
    AObj.ReadFromDataSet(CdsKpiIndex);
    ReadFromObject(AObj,self);
    RowID := CdsKpiTimes.RecordCount;
    //
  finally
    Params.Free;
  end;
end;

procedure TfrmKpiIndexInfo.Save;
var Temp:TZQuery;
    Filter:String;
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
         raise Exception.Create('该指标名称已经存在,不能重复!');
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
        Temp.SQL.Text := 'select KPI_ID,KPI_NAME from MKT_KPI_INDEX where COMM not in (''12'',''02'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and KPI_NAME='+QuotedStr(Trim(edtKPI_NAME.Text));
        Factor.Open(Temp);
        if (Temp.FieldByName('KPI_ID').AsString <> AObj.FieldByName('KPI_ID').AsString) and ( not Temp.IsEmpty) then
           raise Exception.Create('该指标名称已经存在，不能重复！');
      finally
        Temp.Free;
      end;
    end;
  end;

  //检测结束
  WriteToObject(Aobj,self);
  CdsKpiIndex.Edit;
  Aobj.WriteToDataSet(CdsKpiIndex);
  if dbState = dsInsert then
  begin
     CdsKpiIndex.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     CdsKpiIndex.FieldByName('KPI_ID').AsString := Aobj.FieldByName('KPI_ID').AsString;
  end;
  CdsKpiIndex.Post;

  CdsKpiIndex.DisableControls;
  CdsKpiGoods.DisableControls;
  CdsKpiTimes.DisableControls;
  Factor.BeginBatch;
  try
    Factor.AddBatch(CdsKpiIndex,'TKpiIndex');
    Factor.AddBatch(CdsKpiLevel,'TKpiLevel');
    Factor.AddBatch(CdsKpiGoods,'TKpiGoods');
    Factor.AddBatch(CdsKpiTimes,'TKpiTimes');
    Factor.CommitBatch;
  finally
    CdsKpiTimes.EnableControls;
    CdsKpiGoods.EnableControls;
    CdsKpiIndex.EnableControls;
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
  CurYear := StrToInt(FormatDateTime('YYYY',Date));
  KpiAgioFront := '返利';
  KpiAgioBack := '系数';
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
  if CdsKpiLevel.State in [dsEdit,dsInsert] then CdsKpiLevel.Post;
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

procedure TfrmKpiIndexInfo.FormDestroy(Sender: TObject);            
begin
  inherited;
  Aobj.Free;
  Freeform(Self);
end;

procedure TfrmKpiIndexInfo.FormShow(Sender: TObject);
begin
  inherited;
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
       if CdsKpiGoods.Active then
         begin
           CdsKpiGoods.Next;
           if CdsKpiGoods.Eof then
              CdsKpiGoods.First;
         end;
     end;
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
    if CdsKpiLevel.RecordCount>CdsKpiLevel.RecNo then
       begin
         CdsKpiLevel.Next;
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
             if (i=1) and (CdsKpiLevel.FieldByName('LEVELD_NAME').AsString <> '') then
                begin
                   CdsKpiLevel.Next ;
                   if CdsKpiLevel.Eof then
                      begin
                        InitRecord;
                      end;
                   DbGridEh1.SetFocus;
                   DbGridEh1.Col := i;
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

procedure TfrmKpiIndexInfo.WMInitRecord(var Message: TMessage);
begin
  InitRecord;
end;

procedure TfrmKpiIndexInfo.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if CdsKpiLevel.State in [dsEdit,dsInsert] then CdsKpiLevel.Post;
  CdsKpiLevel.DisableControls;
  try
    CdsKpiLevel.Last;
    CdsKpiLevel.Append;
    CdsKpiLevel.FieldByName('LEVEL_ID').AsString := TSequence.NewId;
    CdsKpiLevel.FieldByName('TENANT_ID').asInteger := Global.TENANT_ID;
    CdsKpiLevel.FieldByName('KPI_ID').AsString := Aobj.FieldByName('KPI_ID').AsString;
    CdsKpiLevel.Post;
    DBGridEh1.Col := 1;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    CdsKpiLevel.EnableControls;
    CdsKpiLevel.Edit;
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col,DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.Brush.Color := $0000F2F2;
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
  if CdsKpiGoods.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('商品清单中已经存在"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
  CdsKpiGoods.Append;
  CdsKpiGoods.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CdsKpiGoods.FieldByName('KPI_ID').AsString := Self.Aobj.FieldByName('KPI_ID').AsString;
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
  if not CdsKpiGoods.Active then Exit;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  OpenDialogGoods;
end;

procedure TfrmKpiIndexInfo.DeleteRecordClick(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiLevel.IsEmpty and (MessageBox(Handle,pchar('确认删除本"签约等级"吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       CdsKpiLevel.Delete;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.AddRecord_Click(Sender: TObject);
begin
  inherited;
  if not CdsKpiLevel.Active then Exit;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  InitRecord;
end;

procedure TfrmKpiIndexInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Btn_Save.Visible := (value<>dsBrowse);
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

procedure TfrmKpiIndexInfo.edtIDX_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtIDX_TYPE.ItemIndex = 0 then
     KpiAgioFront := '返利'
  else if edtIDX_TYPE.ItemIndex = 1 then
     KpiAgioFront := '计提'
  else if edtIDX_TYPE.ItemIndex = 2 then
     KpiAgioFront := '提成';

  ShowGrid;
end;

procedure TfrmKpiIndexInfo.ShowGrid;
begin
  {if DisplayPer then
  begin
    DBGridEh1.Columns[5].Title.Caption := KpiAgioFront + KpiAgioBack;
    DBGridEh1.Columns[5].DisplayFormat := '#0%';
  end
  else
  begin
    DBGridEh1.Columns[5].Title.Caption := KpiAgioFront + KpiAgioBack;
    DBGridEh1.Columns[5].DisplayFormat := '';
  end; }
end;

function TfrmKpiIndexInfo.IsNull: Boolean;
var B1,B2:Boolean;
begin

end;

procedure TfrmKpiIndexInfo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
begin
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsKpiLevel.RecNo)),length(Inttostr(CdsKpiLevel.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

destructor TfrmKpiIndexInfo.Destroy;
begin
  fndUNIT_ID.Properties.Items.Clear;
  inherited;
end;

procedure TfrmKpiIndexInfo.edtKPI_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  If dbState <> dsBrowse Then
     edtKPI_SPELL.Text := FnString.GetWordSpell(edtKPI_NAME.Text);
end;

procedure TfrmKpiIndexInfo.DBGridEh3DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
begin
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh3.canvas.Brush.Color := $0000F2F2;
      DBGridEh3.canvas.FillRect(ARect);
      DrawText(DBGridEh3.Canvas.Handle,pchar(Inttostr(CdsKpiTimes.RecNo)),length(Inttostr(CdsKpiTimes.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndexInfo.N1Click(Sender: TObject);
begin
  inherited;
  with TfrmKpiTimes.Create(Self) do
  begin
    try
      IsFirst := True;
      if ShowModal = mrOk then
      begin
        if CdsKpiTimes.State in [dsInsert,dsEdit] then CdsKpiTimes.Post;
        InitTimesRecord;
        CdsKpiTimes.Edit;
        CdsKpiTimes.FieldByName('TIMES_NAME').AsString := TimesName;
        CdsKpiTimes.FieldByName('KPI_DATE1').AsInteger := KpiDate1;
        CdsKpiTimes.FieldByName('KPI_DATE2').AsInteger := KpiDate2;
        CdsKpiTimes.FieldByName('USING_BRRW').AsString := UsingBrrw;
        CdsKpiTimes.FieldByName('KPI_FLAG').AsString := KpiFlag;
        CdsKpiTimes.FieldByName('RATIO_TYPE').AsString := RatioType;
        CdsKpiTimes.FieldByName('KPI_DATA').AsString := KpiData;
        CdsKpiTimes.FieldByName('KPI_CALC').AsString := KpiCalc;
        CdsKpiTimes.Post;
        CdsKpiTimes.Edit;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmKpiIndexInfo.N2Click(Sender: TObject);
begin
  inherited;
  with TfrmKpiTimes.Create(Self) do
  begin
    try
      IsFirst := True;
      TimesName := CdsKpiTimes.FieldByName('TIMES_NAME').AsString;
      KpiDate1 := CdsKpiTimes.FieldByName('KPI_DATE1').AsInteger;
      KpiDate2 := CdsKpiTimes.FieldByName('KPI_DATE2').AsInteger;
      UsingBrrw := CdsKpiTimes.FieldByName('USING_BRRW').AsString;
      KpiFlag := CdsKpiTimes.FieldByName('KPI_FLAG').AsString;
      RatioType := CdsKpiTimes.FieldByName('RATIO_TYPE').AsString;
      KpiData := CdsKpiTimes.FieldByName('KPI_DATA').AsString;
      KpiCalc := CdsKpiTimes.FieldByName('KPI_CALC').AsString;
      if ShowModal = mrOk then
      begin
        if CdsKpiTimes.State in [dsInsert,dsEdit] then CdsKpiTimes.Post;
        CdsKpiTimes.Edit;
        CdsKpiTimes.FieldByName('TIMES_NAME').AsString := TimesName;
        CdsKpiTimes.FieldByName('KPI_DATE1').AsInteger := KpiDate1;
        CdsKpiTimes.FieldByName('KPI_DATE2').AsInteger := KpiDate2;
        CdsKpiTimes.FieldByName('USING_BRRW').AsString := UsingBrrw;
        CdsKpiTimes.FieldByName('KPI_FLAG').AsString := KpiFlag;
        CdsKpiTimes.FieldByName('RATIO_TYPE').AsString := RatioType;
        CdsKpiTimes.FieldByName('KPI_DATA').AsString := KpiData;
        CdsKpiTimes.FieldByName('KPI_CALC').AsString := KpiCalc;
        CdsKpiTimes.Post;
        CdsKpiTimes.Edit;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmKpiIndexInfo.InitTimesRecord;
begin
  if dbState = dsBrowse then Exit;
  if CdsKpiTimes.State in [dsEdit,dsInsert] then CdsKpiTimes.Post;
  CdsKpiTimes.DisableControls;
  try
    inc(RowID);
    CdsKpiTimes.Last;
    CdsKpiTimes.Append;
    CdsKpiTimes.FieldByName('TENANT_ID').asInteger := Global.TENANT_ID;
    CdsKpiTimes.FieldByName('TIMES_ID').AsString := TSequence.NewId;
    CdsKpiTimes.FieldByName('KPI_ID').AsString := Aobj.FieldByName('KPI_ID').AsString;
    CdsKpiTimes.FieldByName('SEQNO').asInteger := RowID;
    CdsKpiTimes.Post;
    DBGridEh3.Col := 1;
    if DBGridEh3.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh3.SetFocus;
  finally
    CdsKpiTimes.EnableControls;
    CdsKpiTimes.Edit;
  end;
end;

procedure TfrmKpiIndexInfo.N3Click(Sender: TObject);
begin
  inherited;
  if DBGridEh3.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiTimes.IsEmpty and (MessageBox(Handle,pchar('确认删除本"时段"吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       CdsKpiTimes.Delete;
       Dec(RowID);
       DBGridEh3.SetFocus;
     end;
end;

end.

