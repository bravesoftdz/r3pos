unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox, DateUtils,
  cxMemo, BaseGrid, AdvGrid, Buttons, DBGrids;

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
    CdsKpiLevel: TZQuery;
    Ds_KpiLevel: TDataSource;
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
    TabSheet3: TRzTabSheet;
    RzPanel3: TRzPanel;
    DBGridEh3: TDBGridEh;
    Ds_KpiTimes: TDataSource;
    CdsKpiTimes: TZQuery;
    PopupMenu3: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    TabSheet4: TRzTabSheet;
    KpiGrid: TAdvStringGrid;
    RzPanel4: TRzPanel;
    lab_KPI_NAME: TRzLabel;
    lab_IDX_TYPE: TRzLabel;
    edtIDX_TYPE: TcxComboBox;
    edtKPI_NAME: TcxTextEdit;
    RzLabel2: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel11: TRzLabel;
    edtKPI_SPELL: TcxTextEdit;
    edtKPI_TYPE: TcxComboBox;
    lab_KPI_TYPE: TLabel;
    RzLabel3: TRzLabel;
    RzLabel9: TRzLabel;
    edtUNIT_NAME: TcxTextEdit;
    RzLabel10: TRzLabel;
    RzLabel5: TRzLabel;
    edtREMARK: TcxMemo;
    KpiPm: TPopupMenu;
    ItemRatio: TMenuItem;
    CdsKpiRatio: TZQuery;
    CdsKpiSeqNo: TZQuery;
    ItemSeqNo: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fndUNIT_IDExit(Sender: TObject);
    procedure fndUNIT_IDEnter(Sender: TObject);
    procedure fndUNIT_IDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fndUNIT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndUNIT_IDPropertiesChange(Sender: TObject);
    procedure DBGridEh2Columns4BeforeShowControl(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
    procedure KpiPmPopup(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure ItemRatioClick(Sender: TObject);
    procedure ItemSeqNoClick(Sender: TObject);
    procedure KpiGridGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure KpiGridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
    procedure KpiGridClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    FRowIdx: integer; //当前行索引
    FColIdx: integer; //当前列索引
    FLevelGodsList: TZQuery;  //1个等级的商品List数据集
    FKpiData: TZQuery;  //考核内容数据集
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
    function  GetGodsRows(GodsID: string): integer;
    //考核指标初始化
    procedure CreateKpiData;    //创建数据集
    procedure InitKpiGrid;      //初始化表头
    procedure InitKpiGridData;  //初始化数据
    function  SaveKpiGridData: Boolean; //从Grid保存数据到数据集
    function  GetKpiLevel_ID: string;   //当前所选行等级Level_ID
    function  GetKpiGods_ID: string;    //当前所选行Gods_ID
    function  GetKpiTimes_ID: string;   //当前所选列时段Times_ID
    function  GetSeqNo_ID: string;      //当前所选行SeqNo_ID
    function  GetRatio_ID: string;      //当前所选行Ratio_ID
    procedure DrawKpiGridData;    //画表格
  public
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
    property KpiLevel_ID: string read GetKpiLevel_ID;  //当前所选行等级Level_ID
    property KpiTimes_ID: string read GetKpiTimes_ID;  //当前所选列时段Times_ID
    property KpiGods_ID: string read GetKpiGods_ID;    //当前所选行Gods_ID
    property KpiSeqNo_ID: string read GetSeqNo_ID;     //当前所选行SeqNo_ID
    property KpiRatio_ID: string read GetRatio_ID;     //当前所选行Ratio_ID
  end;


implementation

uses
  uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,
  uframeSelectGoods,ufrmKpiTimes,ufrmKpiSeqNoSet,ufrmKpiRatioSet;
  
{$R *.dfm}

{ TfrmKipIndexInfo }

class function TfrmKpiIndexInfo.AddDialog(Owner: TForm; var _AObj: TRecord_): boolean;
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
      Factor.AddBatch(CdsKpiSeqNo,'TKpiSeqNo',Params);
      Factor.AddBatch(CdsKpiRatio,'TKpiRatio',Params);
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
    Factor.AddBatch(CdsKpiSeqNo,'TKpiSeqNo');
    Factor.AddBatch(CdsKpiRatio,'TKpiRatio');
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
  //1个等级的商品List数据集
  FLevelGodsList:=TZQuery.Create(self); 
  FKpiData:=TZQuery.Create(self);   //考核内容数据集
  Aobj := TRecord_.Create;
  RowID := 0;
  CurYear := StrToInt(FormatDateTime('YYYY',Date));
  KpiAgioFront := '返利';
  KpiAgioBack := '系数';
  InitGrid;
  FRowIdx:=-1;
  FColIdx:=-1;
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
  SaveKpiGridData;
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
             if (i=1) and (CdsKpiLevel.FieldByName('LEVEL_NAME').AsString <> '') then
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
  TabSheet4.TabVisible:=(dbState<>dsInsert);
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

procedure TfrmKpiIndexInfo.InitKpiGrid;
var
  i,vCol: integer;
begin
  //先画标题: 创建一个 RowCount:2 x  ColCount:6 的Grid表格，行数待 设定的记录数确定。
  //列名: 序号、等级名称、等级基数、等级底数、商品名称、单位、档次量1、考核系数1、档次量2、考核系数2、档次量n、考核系数n
  KpiGrid.Clear;
  KpiGrid.ColCount:=6+CdsKpiTimes.RecordCount*2;
  KpiGrid.RowCount:=3;
  KpiGrid.FixedRows := 2; //设置标题有xx行
  //第1列
  KpiGrid.MergeCells(0,0,1,2);
  KpiGrid.Cells[0,0] := '序号';
  KpiGrid.ColWidths[0] := 32;
  //第2列
  KpiGrid.MergeCells(1,0,1,2);
  KpiGrid.Cells[1,0] := '等级名称';
  KpiGrid.ColWidths[1] := 100;
  //第3列
  KpiGrid.MergeCells(2,0,1,2);
  KpiGrid.Cells[2,0] := '签约量';
  KpiGrid.ColWidths[2] := 60;
  //第4列
  KpiGrid.MergeCells(3,0,1,2);
  KpiGrid.Cells[3,0] := '全年返利比例(%)';
  KpiGrid.ColWidths[3] := 60;
  //第5列
  KpiGrid.MergeCells(4,0,1,2);
  KpiGrid.Cells[4,0] := '商品名称';
  KpiGrid.ColWidths[4] := 100;
  //第6列
  KpiGrid.MergeCells(5,0,1,2);
  KpiGrid.Cells[5,0] := '单位';
  KpiGrid.ColWidths[5] := 44;
  
  //创建时段:
  vCol:=5;
  CdsKpiTimes.First;
  while not CdsKpiTimes.Eof do
  begin
    Inc(vCol);
    KpiGrid.MergeCells(vCol,0,2,1);
    KpiGrid.Cells[vCol,0]:=CdsKpiTimes.FieldByName('TIMES_NAME').AsString;
    KpiGrid.Cells[vCol,1]:='销量';
    KpiGrid.ColWidths[vCol] := 56;
    Inc(vCol);
    KpiGrid.Cells[vCol,1]:='系数';
    KpiGrid.ColWidths[vCol] := 56;
    CdsKpiTimes.Next;
  end;
end;

function TfrmKpiIndexInfo.SaveKpiGridData: Boolean;
var
  i,vCol,vRow: integer;
  TimeNo,SeqNo_ID,Ratio_ID: string;
  FRatioID: string;  //RATIO_ID字段
  FKpiAmt: string;   //数量
  FKpiRatio: string;  //系数
begin
  //循环保存根据KpiGrid的行号对应FKpiData.RecNo进行保存:
  if not FKpiData.Active then Exit;
  vRow:=1;
  FKpiData.Filtered:=False;
  FKpiData.Filter:='';
  for i:=2 to KpiGrid.RowCount-1 do
  begin
    vCol:=5;
    vRow:=vRow+1;
    if i-1>CdsKpiTimes.RecordCount then Continue;
    FKpiData.RecNo:=i-1;
    FKpiData.Edit;
    CdsKpiTimes.First;
    while not CdsKpiTimes.Eof do
    begin
      TimeNo:=IntToStr(CdsKpiTimes.FieldByName('SEQNO').AsInteger); //序号
      FKpiAmt:='KPI_AMT_'+TimeNo;    //数量
      FKpiRatio:='KPI_RATIO_'+TimeNo;  //系数
     {if FKpiData.FindField(FKpiAmt)<>nil then
      begin
        vCol:=vCol+1;
        FKpiData.FieldByName(FKpiAmt).AsFloat:=StrToFloatDef(KpiGrid.Cells[vCol,vRow],0);
      end;}
      if FKpiData.FindField(FKpiRatio)<>nil then
      begin
        vCol:=vCol+2;
        FKpiData.FieldByName(FKpiRatio).AsFloat:=StrToFloatDef(KpiGrid.Cells[vCol,vRow],0);
      end;
      CdsKpiTimes.Next;
    end;
    if FKpiData.State in [dsInsert,dsEdit] then FKpiData.Post;
  end;
  //从数据集(FKpiData)保存到数据集(CdsKpiTimes,CdsKpiRatio)
  FKpiData.First;
  while not FKpiData.Eof do
  begin
    CdsKpiTimes.First;
    while not CdsKpiTimes.Eof do
    begin
      TimeNo:=IntToStr(CdsKpiTimes.FieldByName('SEQNO').AsInteger); //序号
      FRatioID:='RATIO_ID_'+TimeNo;  //RATIO_ID字段
      FKpiAmt:='KPI_AMT_'+TimeNo;    //数量
      FKpiRatio:='KPI_RATIO_'+TimeNo;  //系数
      if FKpiData.FindField(FRatioID)<>nil then //有此字段
      begin
        //系数:
        Ratio_ID:=trim(FKpiData.FieldByName(FRatioID).AsString);    //系数ID
        if CdsKpiRatio.Locate('RATIO_ID',Ratio_ID,[]) then
        begin
          CdsKpiRatio.Edit;
          CdsKpiRatio.FieldByName('KPI_RATIO').AsFloat:=FKpiData.FieldByName(FKpiRatio).AsFloat;
          CdsKpiRatio.Post;
        end;
        //档位:
       {SeqNo_ID:=trim(FKpiData.FieldByName('SEQNO_ID').AsString);  //档次ID
        if CdsKpiSeqNo.Locate('SEQNO_ID',SeqNo_ID,[]) then
        begin
          CdsKpiSeqNo.Edit;
          CdsKpiSeqNo.FieldByName('KPI_AMT').AsFloat:=FKpiData.FieldByName(FKpiAmt).AsFloat;
          CdsKpiSeqNo.Post;
        end;}        
      end;
      CdsKpiTimes.Next;
    end;
    FKpiData.Next;
  end;
  if CdsKpiSeqNo.State in [dsInsert,dsEdit] then CdsKpiSeqNo.Post;
  if CdsKpiRatio.State in [dsInsert,dsEdit] then CdsKpiRatio.Post;
end;

procedure TfrmKpiIndexInfo.KpiPmPopup(Sender: TObject);
var
  IsEdit: Boolean;
  vColIdx,ColNo: integer;
begin
  if FRowIdx>1 then
  begin
    ItemRatio.Visible:=true;
    ItemSeqNo.Visible:=true;
    ItemRatio.Enabled:=true;
    ItemSeqNo.Enabled:=true;
    vColIdx:=FColIdx;
    //前面6列显示
    case vColIdx of
     0..5: //前面5列:
      begin
        ItemRatio.Enabled:=False;
        if trim(KpiSeqNo_ID)='' then  //1、当前行没有SEQNO_ID则进行设置(达标档位)
          ItemSeqNo.Caption:='添加达标档位'
        else //2、当前若已
          ItemSeqNo.Caption:='编辑达标档位';
      end;
     else
      begin
        if trim(KpiSeqNo_ID)='' then //1、当前行没有SEQNO_ID则进行设置(达标档位)
        begin
          ItemRatio.Enabled:=False;
          ItemSeqNo.Caption:='添加达标档位';
        end else //2、当前若已
        begin
          ItemRatio.Enabled:=True;
          ItemSeqNo.Caption:='编辑达标档位';
        end;
      end;
    end;
  end else
  begin
    ItemRatio.Enabled:=False;
    ItemSeqNo.Enabled:=False;
    ItemRatio.Visible:=False;
    ItemSeqNo.Visible:=False;
  end;
end;

procedure TfrmKpiIndexInfo.RzPageChange(Sender: TObject);
begin
  inherited;
  if (TabSheet4.Visible) and (RzPage.ActivePage=TabSheet4) then
  begin
    DrawKpiGridData;
  end;
end;

procedure TfrmKpiIndexInfo.CreateKpiData;
var
  i: integer;
begin
  FKpiData.Close;
  //创建字段:
  FKpiData.FieldDefs.Clear;
  FKpiData.FieldDefs.Add('CNO',ftInteger,0,true);         //序号[自己记录编号]
  FKpiData.FieldDefs.Add('LEVEL_ID',ftString,36,true);    //等级ID
  FKpiData.FieldDefs.Add('LEVEL_NAME',ftString,50,true);  //等级名称
  FKpiData.FieldDefs.Add('GODS_ID',ftString,36,true);     //商品ID
  FKpiData.FieldDefs.Add('GODS_NAME',ftString,50,true);   //商品名称
  FKpiData.FieldDefs.Add('UNIT_ID',ftString,36,true);     //单位ID
  FKpiData.FieldDefs.Add('UNIT_NAME',ftString,50,true);   //单位名称
  FKpiData.FieldDefs.Add('SEQNO_ID',ftString,36,true);    //档次ID
  FKpiData.FieldDefs.Add('LVL_AMT',ftFloat,0,true);       //签约量要求
  FKpiData.FieldDefs.Add('LOW_RATE',ftFloat,0,true);      //保底返利或计提系数 默认为0

  //下面的字段为创建考核周期字段
  CdsKpiTimes.First;
  while not CdsKpiTimes.Eof do
  begin
    i:=CdsKpiTimes.fieldbyName('SEQNO').AsInteger;
    FKpiData.FieldDefs.Add('RATIO_ID_'+IntToStr(i),ftString,36,true);    //等级RATIO_ID
    FKpiData.FieldDefs.Add('KPI_AMT_'+IntToStr(i),ftFloat,0,true);      //保底返利或计提系数 默认为0
    FKpiData.FieldDefs.Add('KPI_RATIO_'+IntToStr(i),ftFloat,0,true);      //保底返利或计提系数 默认为0
    CdsKpiTimes.Next;
  end;
  FKpiData.CreateDataSet;
end;

procedure TfrmKpiIndexInfo.ItemRatioClick(Sender: TObject);
var
  i: integer;
  GodsID: string; 
  SeqNoID: string;
  RatioID: string;
  IsNewFlag: Boolean;
  CurRatioObj: TRecord_;
begin
  inherited;
  if CdsKpiLevel.IsEmpty then Raise Exception.Create('    指标等级不能空，请先设置...    ');
  if CdsKpiTimes.IsEmpty then Raise Exception.Create('    指标时段不能空，请先设置...    ');
  try
    IsNewFlag:=true;
    CurRatioObj:=TRecord_.Create;
    GodsID:=KpiGods_ID;    //当前商品ID
    SeqNoID:=KpiSeqNo_ID;  //当前档次ID
    RatioID:=KpiRatio_ID;  //当前系数ID
    if SeqNoID='' then Raise Exception.Create('  达标档位不能为空...  ');
    if (RatioID<>'') and (CdsKpiRatio.Locate('RATIO_ID',RatioID,[])) then
    begin
      CurRatioObj.ReadFromDataSet(CdsKpiRatio);
      IsNewFlag:=False;  //编辑记录
    end else
    begin
      CurRatioObj.ReadFromDataSet(CdsKpiRatio);
      for i:=0 to CurRatioObj.Count-1 do
        CurRatioObj.Fields[i].AsString:='';
      CurRatioObj.FieldByName('SEQNO_ID').AsString:=SeqNoID;
      CurRatioObj.FieldByName('GODS_ID').AsString:=GodsID;
    end;

    if TfrmKpiRatioSet.EditDialog(CurRatioObj, CdsKpiGoods, CdsKpiSeqNo) then
    begin
      if IsNewFlag then
      begin
        CurRatioObj.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        CurRatioObj.FieldByName('RATIO_ID').AsString:=TSequence.NewId();
        CdsKpiRatio.Append;
        CurRatioObj.WriteToDataSet(CdsKpiRatio);
        CdsKpiRatio.Post;
      end else
      begin
        if CdsKpiRatio.Locate('RATIO_ID',RatioID,[]) then
        begin
          CdsKpiRatio.Edit;
          CurRatioObj.WriteToDataSet(CdsKpiRatio);
          CdsKpiRatio.Post;
        end;
      end;
      //刷新(Draw)KpiGrid
      DrawKpiGridData; 
    end;
  finally
    CurRatioObj.Free;
  end;
end;

procedure TfrmKpiIndexInfo.InitKpiGridData;
var NewRecNo: integer;
  function GetTimeNo(TimeID: string): string;
  begin
    result:='-1';
    if CdsKpiTimes.Locate('TIMES_ID',TimeID,[]) then
      result:=IntToStr(CdsKpiTimes.FieldByName('SEQNO').AsInteger); //时段No
  end;
  //初始一个等级商品列表:
  function GetLevelGodsList(RsRatio: TZQuery; Lvl_ID: string): Boolean;
  var GodsID: string;
  begin
    Result:=False;
    FLevelGodsList.Close;
    FLevelGodsList.FieldDefs.Clear;
    FLevelGodsList.FieldDefs.Add('GODS_ID',ftString,36,true);    //商品ID
    FLevelGodsList.FieldDefs.Add('GODS_NAME',ftString,50,true);  //商品名称
    FLevelGodsList.FieldDefs.Add('GODS_Rows',ftInteger,0,true);  //有多少行
    FLevelGodsList.CreateDataSet;
    //循环商品列表:
    CdsKpiGoods.First;
    while not CdsKpiGoods.Eof do
    begin
      GodsID:=trim(CdsKpiGoods.FieldByName('GODS_ID').AsString);
      if not FLevelGodsList.Locate('GODS_ID',GodsID,[]) then
      begin
        FLevelGodsList.Append;
        FLevelGodsList.FieldByName('GODS_ID').AsString:=GodsID;
        FLevelGodsList.FieldByName('GODS_NAME').AsString:=CdsKpiGoods.FieldByName('GODS_NAME').AsString;
        FLevelGodsList.FieldByName('GODS_Rows').AsInteger:=0;
        FLevelGodsList.Post;
      end;
      CdsKpiGoods.Next;
    end;
    Result:=True;
  end;
  //初始化一个等级:
  function InitKpiLevelData(KpiRatio: TZQuery; LvlObj: TRecord_; var vRecNo: integer): Boolean;
  var
    Gods_Rows: integer; //商品个数
    CurFlag: Boolean;
    Lvl_ID: string;
    TimeID,FilStr,TimeNo: string;
    FKpiAmt,FKpiRatio,FRatioID: string; //字段名称
  begin
    try
      vRecNo:=0;
      Lvl_ID:=LvlObj.FieldByName('LEVEL_ID').AsString;
      //根据商品进行循环
      FLevelGodsList.First;
      while not FLevelGodsList.Eof do
      begin
        FilStr:='LEVEL_ID='''+Lvl_ID+''' and GODS_ID='''+trim(FLevelGodsList.FieldbyName('GODS_ID').AsString)+''' ';
        KpiRatio.Filtered:=False;
        KpiRatio.Filter:=FilStr;
        KpiRatio.Filtered:=true;
        FKpiData.Filtered:=False;
        FKpiData.Filter:=FilStr;
        FKpiData.Filtered:=true;
        if KpiRatio.RecordCount=0 then
        begin
          Gods_Rows:=1;
          Inc(NewRecNo);
          FKpiData.Append;
          FKpiData.FieldByName('CNO').AsInteger:=NewRecNo;
          FKpiData.FieldByName('LEVEL_ID').AsString:=Lvl_ID;
          FKpiData.FieldByName('LEVEL_NAME').AsString:=trim(LvlObj.FieldByName('LEVEL_NAME').AsString);
          FKpiData.FieldByName('LVL_AMT').AsFloat:=LvlObj.FieldByName('LVL_AMT').AsFloat;
          FKpiData.FieldByName('LOW_RATE').AsFloat:=LvlObj.FieldByName('LOW_RATE').AsFloat;
          FKpiData.FieldByName('GODS_ID').AsString:=FLevelGodsList.FieldByName('GODS_ID').AsString;
          FKpiData.FieldByName('GODS_NAME').AsString:=FLevelGodsList.FieldByName('GODS_NAME').AsString;
          FKpiData.FieldByName('UNIT_ID').AsString:='';
          FKpiData.FieldByName('UNIT_NAME').AsString:='';
          FKpiData.FieldByName('SEQNO_ID').AsString:='';
          FKpiData.Post;
        end else
        begin
          KpiRatio.First;
          while not KpiRatio.Eof do
          begin
            CurFlag:=False;
            TimeID:=trim(KpiRatio.FieldByName('TIMES_ID').AsString);
            TimeNo:=GetTimeNo(TimeID);
            FRatioID:='RATIO_ID_'+TimeNo;  //RATIO_ID字段
            FKpiAmt:='KPI_AMT_'+TimeNo;    //数量
            FKpiRatio:='KPI_RATIO_'+TimeNo;  //系数
            FKpiData.First;
            while (not FKpiData.Eof) and (Not CurFlag) do
            begin
              if (not CurFlag) and (FKpiData.FindField(FRatioID)<>nil) and (trim(FKpiData.FieldByName(FRatioID).AsString)='') then //还没被填入
              begin
                FKpiData.Edit;
                FKpiData.FieldByName(FRatioID).AsString:=KpiRatio.FieldByName('RATIO_ID').AsString;
                if FKpiData.FindField(FKpiAmt)<>nil then
                  FKpiData.FieldByName(FKpiAmt).AsFloat:=KpiRatio.FieldByName('KPI_AMT').AsFloat;
                if FKpiData.FindField(FKpiRatio)<>nil then
                  FKpiData.FieldByName(FKpiRatio).AsFloat:=KpiRatio.FieldByName('KPI_RATIO').AsFloat;
                FKpiData.Post;
                CurFlag:=true;
              end;
              FKpiData.Next;
            end;
            if not CurFlag then //新增记录
            begin
              Inc(NewRecNo);
              FKpiData.Append;
              FKpiData.FieldByName('CNO').AsInteger:=NewRecNo;
              FKpiData.FieldByName('LEVEL_ID').AsString:=KpiRatio.FieldByName('LEVEL_ID').AsString;
              FKpiData.FieldByName('LEVEL_NAME').AsString:=KpiRatio.FieldByName('LEVEL_NAME').AsString;
              FKpiData.FieldByName('GODS_ID').AsString:=KpiRatio.FieldByName('GODS_ID').AsString;
              FKpiData.FieldByName('GODS_NAME').AsString:=KpiRatio.FieldByName('GODS_NAME').AsString;
              FKpiData.FieldByName('UNIT_ID').AsString:=KpiRatio.FieldByName('UNIT_ID').AsString;
              FKpiData.FieldByName('UNIT_NAME').AsString:=KpiRatio.FieldByName('UNIT_NAME').AsString;
              FKpiData.FieldByName('SEQNO_ID').AsString:=KpiRatio.FieldByName('SEQNO_ID').AsString;
              FKpiData.FieldByName('LVL_AMT').AsFloat:=KpiRatio.FieldByName('LVL_AMT').AsFloat;
              FKpiData.FieldByName('LOW_RATE').AsFloat:=KpiRatio.FieldByName('LOW_RATE').AsFloat;
              //Ratio_ID
              FKpiData.FieldByName(FRatioID).AsString:=KpiRatio.FieldByName('RATIO_ID').AsString;
              if FKpiData.FindField(FKpiAmt)<>nil then
                FKpiData.FieldByName(FKpiAmt).AsFloat:=KpiRatio.FieldByName('KPI_AMT').AsFloat;
              if FKpiData.FindField(FKpiRatio)<>nil then
                FKpiData.FieldByName(FKpiRatio).AsFloat:=KpiRatio.FieldByName('KPI_RATIO').AsFloat;
              FKpiData.Post;
            end;
            KpiRatio.Next;
          end;
          Gods_Rows:=FKpiData.RecordCount;
        end;

        //当前商品循环完，记录此商品个数据
        FLevelGodsList.Edit;
        FLevelGodsList.FieldByName('Gods_Rows').AsInteger:=Gods_Rows;
        FLevelGodsList.Post;
        vRecNo:=vRecNo+Gods_Rows;  //累计有多少行
        FLevelGodsList.Next;
      end;
    finally
      KpiRatio.Filtered:=False;
      KpiRatio.Filter:='';
    end;
  end;
var
  IsAddFlag: Boolean;
  Lvl_Obj: TRecord_;
  vRowCount,vCol,vRow,gRow,gCurRow: integer;
  Lvl_ID,TimeNo,FieldAmt,FieldRatio,Level_ID,Gods_ID: string;       //当前时段ID
  GodsIDs: wideString;
  KpiRatio: TZQuery;
begin
  if not FKpiData.Active then Exit;
  if not CdsKpiRatio.Active then Exit;
  IsAddFlag:=False;
  NewRecNo:=0;
  try
    Lvl_Obj:=TRecord_.Create;
    KpiRatio:=TZQuery.Create(nil);
    KpiRatio.Data:=CdsKpiRatio.Data;
    CdsKpiLevel.First;
    while not CdsKpiLevel.Eof do
    begin
      Lvl_Obj.ReadFromDataSet(CdsKpiLevel); 
      //初始化一个等级:
      Lvl_ID:=trim(CdsKpiLevel.FieldByName('LEVEL_ID').AsString);
      //过滤商品出来:
      GetLevelGodsList(KpiRatio,Lvl_ID);
      //初始化等级:
      InitKpiLevelData(KpiRatio,Lvl_Obj,vRowCount);
      //保存当前等级有xx条记录[合并单元格需要]:
      CdsKpiLevel.Edit;
      CdsKpiLevel.FieldByName('LEVEL_Rows').AsInteger:=vRowCount;
      CdsKpiLevel.Post;
      //初始化到Grid:
      if vRowCount<=0 then
      begin
        CdsKpiLevel.Next;
        Continue;
      end;
      if Not IsAddFlag then
      begin
        if vRowCount>1 then KpiGrid.RowCount:=vRowCount+2;
        IsAddFlag:=true;
      end else
        KpiGrid.RowCount:=KpiGrid.RowCount+vRowCount;
      try
        FKpiData.Filtered:=False;
        FKpiData.Filter:='LEVEL_ID='''+Lvl_ID+''' ';
        FKpiData.Filtered:=True;
        FKpiData.First;
        while not FKpiData.Eof do
        begin
          vRow:=KpiGrid.RowCount-(vRowCount-FKpiData.RecNo)-1;
          gRow:=vRow;
          //写入前面4列，只写当前等级的第一行:
          if FKpiData.RecNo=1 then
          begin
            KpiGrid.Cells[0,vRow]:=IntToStr(CdsKpiLevel.RecNo); //序号
            KpiGrid.MergeCells(0,vRow,1,vRowCount);
            KpiGrid.Cells[1,vRow]:=trim(FKpiData.FieldByName('LEVEL_NAME').AsString);    //等级名称
            KpiGrid.MergeCells(1,vRow,1,vRowCount);
            KpiGrid.Cells[2,vRow]:=FloatToStr(FKpiData.FieldByName('LVL_AMT').AsFloat);  //等级达标量
            KpiGrid.MergeCells(2,vRow,1,vRowCount);
            KpiGrid.Cells[3,vRow]:=FloatToStr(FKpiData.FieldByName('LOW_RATE').AsFloat); //等级达标率
            KpiGrid.MergeCells(3,vRow,1,vRowCount);
          end;
          //写入商品列(第5列)，只写商品的第一行:
          Level_ID:=Trim(FKpiData.FieldByName('LEVEL_ID').AsString);
          Gods_ID:=Trim(FKpiData.FieldByName('GODS_ID').AsString);
          if Pos(';'+Level_ID+Gods_ID+';',GodsIDs)<=0 then
          begin
            GodsIDs:=GodsIDs+';'+Level_ID+Gods_ID+';';
            gCurRow:=GetGodsRows(Gods_ID); 
            KpiGrid.Cells[4,gRow]:=trim(FKpiData.FieldByName('GODS_NAME').AsString); //商品名称
            KpiGrid.MergeCells(4,gRow,1,gCurRow);
            gRow:=gRow+gCurRow;
          end;
          //写第6列(Col=5)开始:
          KpiGrid.Cells[5,vRow]:=trim(FKpiData.FieldByName('UNIT_NAME').AsString); //单位名称
          vCol:=5;
          CdsKpiTimes.First;
          while not CdsKpiTimes.Eof do
          begin
            vCol:=vCol+1;  //下一列
            TimeNo:=InttoStr(CdsKpiTimes.FieldByName('SEQNO').AsInteger);
            FieldAmt:='KPI_AMT_'+TimeNo;   //达标数量
            FieldRatio:='KPI_RATIO_'+TimeNo;  //达标系数
            if FKpiData.FindField(FieldAmt)<>nil then
              KpiGrid.Cells[vCol,vRow]:=FloatToStr(FKpiData.FieldByName(FieldAmt).AsFloat); //考核数量
            vCol:=vCol+1;  //下一列
            if FKpiData.FindField(FieldRatio)<>nil then
              KpiGrid.Cells[vCol,vRow]:=FloatToStr(FKpiData.FieldByName(FieldRatio).AsFloat); //考核数量
            CdsKpiTimes.Next;
          end;
          FKpiData.Next;
        end;
      finally
        FKpiData.Filtered:=true;
        FKpiData.Filter:='';
      end;
      CdsKpiLevel.Next;
    end;
  finally
    KpiRatio.Free;
  end;
end;

procedure TfrmKpiIndexInfo.KpiGridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if ARow in [0,1] then HAlign := taCenter;
  if ACol=0 then HAlign := taCenter;
end;                                          

function TfrmKpiIndexInfo.GetGodsRows(GodsID: string): integer;
begin
  result:=0;
  if not FLevelGodsList.Active then Exit;
  if FLevelGodsList.Locate('GODS_ID',GodsID,[]) then
    result:=FLevelGodsList.FieldByName('GODS_Rows').AsInteger;
end;

procedure TfrmKpiIndexInfo.KpiGridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  if (FKpiData.Active) then
  begin
    if (ARow>1) and (ACol>5) and (ACol mod 2=1) then
      CanEdit := (dbState <> dsBrowse)
    else
      CanEdit := false;
  end else
    CanEdit := false;
end;

function TfrmKpiIndexInfo.GetKpiGods_ID: string;
var
  CurRecNo: integer;
begin
  result:='';
  if not FKpiData.Active then Exit;
  CurRecNo:=FRowIdx-1;
  if (CurRecNo>0) and (CurRecNo<=FKpiData.RecordCount) then
  begin
    FKpiData.RecNo:=CurRecNo;
    result:=trim(FKpiData.fieldByName('GODS_ID').AsString);
  end;
end;

function TfrmKpiIndexInfo.GetKpiLevel_ID: string;
var
  CurRecNo: integer;
begin
  result:='';
  if not FKpiData.Active then Exit;
  CurRecNo:=FRowIdx-1;
  if (CurRecNo>0) and (CurRecNo<=FKpiData.RecordCount) then
  begin
    FKpiData.RecNo:=CurRecNo;
    result:=trim(FKpiData.fieldByName('LEVEL_ID').AsString);
  end;
end;

function TfrmKpiIndexInfo.GetKpiTimes_ID: string;
var
  vRecNo: integer;
begin
  result:='';    
  if not CdsKpiTimes.Active then Exit;
  vRecNo:=((FColIdx-6) div 2)+1; //第几个（Times_ID时段）
  if (vRecNo>0) and (vRecNo<=CdsKpiTimes.RecordCount) then
  begin
    CdsKpiTimes.RecNo:=vRecNo;
    result:=trim(CdsKpiTimes.fieldByName('TIMES_ID').AsString);
  end;
end;

procedure TfrmKpiIndexInfo.KpiGridClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  FRowIdx:=ARow; //当前行索引
  FColIdx:=ACol; //当前列索引
end;

function TfrmKpiIndexInfo.GetSeqNo_ID: string;
var
  CurRecNo: integer;
begin
  result:='';
  if not FKpiData.Active then Exit;
  CurRecNo:=FRowIdx-1;
  if (CurRecNo>0) and (CurRecNo<=FKpiData.RecordCount) then
  begin
    FKpiData.RecNo:=CurRecNo;
    result:=trim(FKpiData.fieldByName('SEQNO_ID').AsString);
  end;
end;

procedure TfrmKpiIndexInfo.ItemSeqNoClick(Sender: TObject);
var
  i: integer;
  SeqNoID: string;
  LevelID: string;
  Times_ID: string;
  IsNewFlag: Boolean;
  CurSeqNoObj: TRecord_;
  CurLevelObj: TRecord_;
begin
  inherited;
  if CdsKpiLevel.IsEmpty then Raise Exception.Create('    指标等级不能空，请先设置...    ');
  if CdsKpiTimes.IsEmpty then Raise Exception.Create('    指标时段不能空，请先设置...    ');

  try
    IsNewFlag:=true;
    CurSeqNoObj:=TRecord_.Create;
    CurLevelObj:=TRecord_.Create;
    SeqNoID:=KpiSeqNo_ID;
    LevelID:=KpiLevel_ID;
    Times_ID:=KpiTimes_ID;
    if (SeqNoID<>'') and (CdsKpiSeqNo.Locate('SEQNO_ID',SeqNoID,[])) then
    begin
      CurSeqNoObj.ReadFromDataSet(CdsKpiSeqNo);
      IsNewFlag:=False; //编辑记录
    end else
    begin
      CurSeqNoObj.ReadFromDataSet(CdsKpiSeqNo);
      for i:=0 to CurSeqNoObj.Count-1 do
        CurSeqNoObj.Fields[i].AsString:='';
    end;
    //档次记录
    if (LevelID<>'') and (CdsKpiLevel.Locate('LEVEL_ID',LevelID,[])) then
      CurLevelObj.ReadFromDataSet(CdsKpiLevel); 

    if TfrmKpiSeqNoSet.EditDialog(CurSeqNoObj,CurLevelObj,Times_ID,CdsKpiTimes) then
    begin
      if IsNewFlag then
      begin
        i:=CdsKpiSeqNo.RecordCount;
        CurSeqNoObj.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        CurSeqNoObj.FieldByName('SEQNO_ID').AsString:=TSequence.NewId();
        CurSeqNoObj.FieldByName('SEQNO').AsInteger:=i+1;
        CdsKpiSeqNo.Append;
        CurSeqNoObj.WriteToDataSet(CdsKpiSeqNo);
        CdsKpiSeqNo.Post;
      end else
      begin
        if CdsKpiSeqNo.Locate('SEQNO_ID',SeqNoID,[]) then
        begin
          CdsKpiSeqNo.Edit;
          CurSeqNoObj.WriteToDataSet(CdsKpiSeqNo);
          CdsKpiSeqNo.Post;
          CdsKpiRatio.First;
          //循环更新:CdsKpiRatio
          while not CdsKpiRatio.Eof do
          begin
            if trim(CdsKpiRatio.FieldByName('SEQNO_ID').AsString)=SeqNoID then
            begin
              CdsKpiRatio.Edit;
              CdsKpiRatio.FieldByName('TIMES_ID').AsString:=CurSeqNoObj.FieldByName('TIMES_ID').AsString;
              CdsKpiRatio.FieldByName('TIMES_NAME').AsString:=CurSeqNoObj.FieldByName('TIMES_NAME').AsString;
              CdsKpiRatio.FieldByName('KPI_AMT').AsFloat:=CurSeqNoObj.FieldByName('KPI_AMT').AsFloat;
              CdsKpiRatio.FieldByName('KPI_DATE1').AsString:=CurSeqNoObj.FieldByName('KPI_DATE1').AsString;
              CdsKpiRatio.FieldByName('KPI_DATE2').AsString:=CurSeqNoObj.FieldByName('KPI_DATE2').AsString;
              CdsKpiRatio.FieldByName('USING_BRRW').AsString:=CurSeqNoObj.FieldByName('USING_BRRW').AsString;
              CdsKpiRatio.FieldByName('KPI_FLAG').AsString:=CurSeqNoObj.FieldByName('KPI_FLAG').AsString;
              CdsKpiRatio.FieldByName('KPI_DATA').AsString:=CurSeqNoObj.FieldByName('KPI_DATA').AsString;
              CdsKpiRatio.FieldByName('KPI_CALC').AsString:=CurSeqNoObj.FieldByName('KPI_CALC').AsString;
              CdsKpiRatio.FieldByName('RATIO_TYPE').AsString:=CurSeqNoObj.FieldByName('RATIO_TYPE').AsString;
              CdsKpiRatio.Post;
            end;
            CdsKpiRatio.Next;
          end; 
        end;
      end;
      //刷新(Draw)KpiGrid
      DrawKpiGridData;
    end;
  finally
    CurSeqNoObj.Free;
    CurLevelObj.Free;
  end;
end;

function TfrmKpiIndexInfo.GetRatio_ID: string;
var
  vRecNo: integer;
  TimesID,TimeNo,RatioID: string;
begin
  result:='';
  TimesID:=GetKpiTimes_ID;
  if CdsKpiTimes.Locate('TIMES_ID',TimesID,[]) then
    TimeNo:=IntToStr(CdsKpiTimes.FieldByName('SEQNO').AsInteger);
  RatioID:='RATIO_ID_'+TimeNo;
  vRecNo:=FRowIdx-1;
  if (vRecNo>0) and (vRecNo<FKpiData.RecordCount) then
  begin
    FKpiData.RecNo:=vRecNo;
    if FKpiData.FindField(RatioID)<>nil then
      result:=trim(FKpiData.FieldByName(RatioID).AsString);
  end;
end;

procedure TfrmKpiIndexInfo.DrawKpiGridData;
begin
  //刷新(Draw)KpiGrid
  CreateKpiData;
  InitKpiGrid;
  InitKpiGridData;
end;

end.

