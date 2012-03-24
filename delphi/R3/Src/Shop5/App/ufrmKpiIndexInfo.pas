unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox, DateUtils,
  cxMemo, BaseGrid, AdvGrid, Buttons, DBGrids, cxSpinEdit;

const
  WM_INIT_RECORD=WM_USER+4;

type
  TDateRecord = Record
    BeginDate:Integer;
    EndDate:Integer;
  end;
  //���δ��ϵ��
  TKpiRatio=record
    Index:integer;
    ColType:integer;  //������(ǰ��3��:0;�����:1;���ϵ��:2;)
    SEQNO_ID:string;  //����ID
    TIME_ID:string;   //ʱ��ID
    GODS_ID:string;   //��ƷID
  end;
  pKpiRow=^TKpiRow;
  TKpiRow=record
    RowState:integer;   //0:�²���; 1:ԭ����;
    TimesCount:integer; //ʱ�θ���
    LEVEL_ID:string;
    Ratio:array [0..255] of TKpiRatio;
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
    AddSeqNo: TMenuItem;
    Button1: TButton;
    Row: TcxSpinEdit;
    Col: TcxSpinEdit;
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
    procedure ItemRatioClick(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure KpiGridGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure KpiGridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
    procedure KpiGridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure AddSeqNoClick(Sender: TObject);
    procedure RzPageChanging(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
    procedure KpiGridCellsChanged(Sender: TObject; R: TRect);
    procedure KpiGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    pBaseRow:pKpiRow;  //��ʼ������ʱ
    FChangeState: Boolean;  //�仯״̬
    FListCount: Integer;    //Draw������
    FRowIdx: integer;   //��ǰ������
    FColIdx: integer;   //��ǰ������
    FKpiGridList: TList;  //�����(����ʱ�Ρ�����ID)[RowIdx=KpiGird.Rows]

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
    //����ָ���ʼ��
    procedure InitKpiGrid;      //��ʼ����ͷ
    procedure InitKpiGridData;  //��ʼ������
    procedure DrawKpiGridData;  //�����
    function WriteRowKpiGridToDataSet(pRow: pKpiRow; GridRow: integer):Boolean; //��Grid����һ�����ݵ�
    function SaveKpiGridData:Boolean;     //��Grid�������ݵ����ݼ�
    function GetKpiLevel_ID(RowIdx: integer=-1):string;   //��ǰ��ѡ�еȼ�Level_ID
    function GetKpiTimes_ID(ColIdx: integer=-1):string;   //��ǰ��ѡ��ʱ��Times_ID
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
  end;


implementation

uses
  uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,
  uframeSelectGoods,ufrmKpiTimes,ufrmKpiRatioSet;
  
{$R *.dfm}

{ TfrmKipIndexInfo }

class function TfrmKpiIndexInfo.AddDialog(Owner: TForm; var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002143',2) then Raise Exception.Create('��û����������ָ���Ȩ��,��͹���Ա��ϵ.');
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
   if not ShopGlobal.GetChkRight('100002143',3) then Raise Exception.Create('��û���޸Ŀ���ָ���Ȩ��,��͹���Ա��ϵ.');
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
    raise Exception.Create('ָ�����Ʋ���Ϊ�գ�');
  end;
  if edtIDX_TYPE.ItemIndex = -1 then
  begin
    if edtIDX_TYPE.CanFocus then edtIDX_TYPE.SetFocus;
    raise Exception.Create('ָ�����Ͳ���Ϊ�գ�');
  end;
  if edtKPI_TYPE.ItemIndex = -1 then
  begin
    if edtKPI_TYPE.CanFocus then edtKPI_TYPE.SetFocus;
    raise Exception.Create('�������Ͳ���Ϊ�գ�');
  end;

  //�˼�⣬ֻ��ǰ̨���
  if dbState = dsInsert then
  begin
    Temp := TZQuery.Create(nil);
    try
      Temp.Close;
      Temp.SQL.Text := 'select KPI_NAME from MKT_KPI_INDEX where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and KPI_NAME='+QuotedStr(Trim(edtKPI_NAME.Text));
      Factor.Open(Temp);
      if Temp.FieldByName('KPI_NAME').AsString <> '' then
         raise Exception.Create('��ָ�������Ѿ�����,�����ظ�!');
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
           raise Exception.Create('��ָ�������Ѿ����ڣ������ظ���');
      finally
        Temp.Free;
      end;
    end;
  end;

  //������
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
  FKpiGridList:=TList.Create;  //�����(����ʱ�Ρ�����ID)
  Aobj := TRecord_.Create;
  RowID := 0;
  CurYear := StrToInt(FormatDateTime('YYYY',Date));
  KpiAgioFront := '����';
  KpiAgioBack := 'ϵ��';
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
    if MessageBox(Handle,'�Ƿ��������ָ��?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
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
  FKpiGridList.Free;
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
  if not CdsKpiGoods.IsEmpty and (MessageBox(Handle,pchar('ȷ��ɾ��"'+CdsKpiGoods.FieldbyName('GODS_NAME').AsString+'"��Ʒ��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
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
  if not basInfo.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ӫ��Ʒ��û�ҵ�"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
  //AddRecord(AObj,basInfo.FieldbyName('UNIT_ID').AsString,True);
  if CdsKpiGoods.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ʒ�嵥���Ѿ�����"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
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
  if not CdsKpiLevel.IsEmpty and (MessageBox(Handle,pchar('ȷ��ɾ����"ǩԼ�ȼ�"��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
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
  dsInsert:Caption:='����ָ��--(����)';
  dsEdit:Caption:='����ָ��--(�޸�)';
  else
    begin
      Caption:='����ָ��';
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
     KpiAgioFront := '����'
  else if edtIDX_TYPE.ItemIndex = 1 then
     KpiAgioFront := '����'
  else if edtIDX_TYPE.ItemIndex = 2 then
     KpiAgioFront := '���';

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
  if not CdsKpiTimes.IsEmpty and (MessageBox(Handle,pchar('ȷ��ɾ����"ʱ��"��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
     begin
       CdsKpiTimes.Delete;
       Dec(RowID);
       DBGridEh3.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.InitKpiGrid;
  procedure SetpRowValue(vCol,ColType: integer; TIMES_ID,GODS_ID: string);
  begin
    pBaseRow^.LEVEL_ID:='';
    pBaseRow^.Ratio[vCol].Index:=vCol;
    pBaseRow^.Ratio[vCol].ColType:=ColType;
    pBaseRow^.Ratio[vCol].SEQNO_ID:='';
    pBaseRow^.Ratio[vCol].TIME_ID:=TIMES_ID;
    pBaseRow^.Ratio[vCol].GODS_ID:=GODS_ID;
  end;
var
  i,vCol,vGodsCount: integer;
  GodsName,GodsID,TimeID: string;
begin
  New(pBaseRow);
  //�Ȼ�����: ����һ�� RowCount:2 x  ColCount:6 ��Grid��������� �趨�ļ�¼��ȷ����
  //����: ��š��ȼ����ơ��ȼ��������ȼ���������Ʒ���ơ���λ��������1������ϵ��1��������2������ϵ��2��������n������ϵ��n
  KpiGrid.Clear;
  KpiGrid.RowCount:=3;
  KpiGrid.ColCount:=4;
  KpiGrid.FixedRows :=2; //���ñ�����xx��
  KpiGrid.FixedCols :=1; //�������
  //��1��
  KpiGrid.MergeCells(0,0,1,2);
  KpiGrid.Cells[0,0] := '���';
  KpiGrid.ColWidths[0] := 30;
  SetpRowValue(0,0,'','');
  //��2��
  KpiGrid.MergeCells(1,0,1,2);
  KpiGrid.Cells[1,0] := '�ȼ�����';
  KpiGrid.ColWidths[1] := 100;
  SetpRowValue(1,0,'','');
  //��3��
  KpiGrid.MergeCells(2,0,1,2);
  KpiGrid.Cells[2,0] := 'ǩԼ��';
  KpiGrid.ColWidths[2] := 60;
  SetpRowValue(2,0,'','');
  //��4��
  KpiGrid.MergeCells(3,0,1,2);
  KpiGrid.Cells[3,0] := 'ȫ�귵������(%)';
  KpiGrid.ColWidths[3] := 60;
  SetpRowValue(3,0,'','');
  //����ʱ��:
  vCol:=3;
  vGodsCount:=CdsKpiGoods.RecordCount;
  CdsKpiTimes.First;
  while not CdsKpiTimes.Eof do
  begin
    Inc(vCol); //��������һ��
    TimeID:=trim(CdsKpiTimes.FieldByName('TIMES_ID').AsString);
    if CdsKpiTimes.FieldByName('RATIO_TYPE').AsString='1' then
    begin
      KpiGrid.ColCount:=KpiGrid.ColCount+2;
      //�ϲ�ʱ�α���
      KpiGrid.MergeCells(vCol,0,2,1); //�ж��ٸ���Ʒ�ϲ�
      KpiGrid.Cells[vCol,0]:=CdsKpiTimes.FieldByName('TIMES_NAME').AsString;
      //�����
      KpiGrid.Cells[vCol,1] := '�����';
      KpiGrid.ColWidths[vCol] := 60;
      SetpRowValue(vCol,1,TimeID,'#');

      //����ϵ��
      Inc(vCol);
      KpiGrid.Cells[vCol,1]:='����ϵ��(%)';
      KpiGrid.ColWidths[vCol] := 70;
      SetpRowValue(vCol,2,TimeID,'#');
    end else
    begin
      KpiGrid.ColCount:=KpiGrid.ColCount+vGodsCount+1;
      //�ϲ�ʱ�α���
      KpiGrid.MergeCells(vCol,0,vGodsCount+1,1); //�ж��ٸ���Ʒ�ϲ�
      KpiGrid.Cells[vCol,0]:=CdsKpiTimes.FieldByName('TIMES_NAME').AsString;
      //�����
      KpiGrid.Cells[vCol,1] := '�����';
      KpiGrid.ColWidths[vCol] := 60;
      SetpRowValue(vCol,1,TimeID,'');

      //ѭ����Ʒ
      CdsKpiGoods.First;
      while not CdsKpiGoods.Eof do
      begin
        Inc(vCol);  //��������һ��
        GodsID:=trim(CdsKpiGoods.FieldByName('GODS_ID').AsString);
        GodsName:='';
        if CdsKpiGoods.FindField('SHORT_GODS_NAME')<>nil then
          GodsName:=trim(CdsKpiGoods.FieldByName('SHORT_GODS_NAME').AsString);
        if GodsName='' then GodsName:=trim(CdsKpiGoods.FieldByName('GODS_NAME').AsString);
        KpiGrid.Cells[vCol,1]:=GodsName;
        KpiGrid.ColWidths[vCol]:= 60;
        SetpRowValue(vCol,2,TimeID,GodsID);
        CdsKpiGoods.Next;
      end;
    end;
    CdsKpiTimes.Next;
  end;
end;

//��Grid����һ�����ݵ�[CdsSeqNoList,CdsRatioList]
function TfrmKpiIndexInfo.WriteRowKpiGridToDataSet(pRow: pKpiRow; GridRow: integer):Boolean;
 function GetGodsDefUnitID(GODS_ID:string): string;
 var RsGods: TZQuery;
 begin
   result:='#';
   RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO');
   if (RsGods<>nil) and (RsGods.Locate('GODS_ID',GODS_ID,[])) then
     result:=trim(RsGods.fieldByName('CALC_UNITS').AsString);
 end;
var
  IsEdit: Boolean; //�༭״̬
  gCol,i,SEQ_NO: integer;   //ѭ����
  CellText,NewID: string;
  pRaito: TKpiRatio;
begin
  result:=False;
  for gCol:=4 to KpiGrid.ColCount-1 do
  begin
    CellText:=KpiGrid.Cells[gCol,GridRow]; //��ǰֵ
    pRow:=pKpiRow(FKpiGridList.Items[GridRow-2]); //��ǰKpiGird��-2
    pRaito:=pRow.Ratio[gCol];
    if trim(CellText)='' then //Ϊ�ս���ɾ��
    begin
      case pRaito.ColType of
       1: //��굵������:MKT_KPI_SEQNO
        begin
          if (pRaito.SEQNO_ID<>'') and (CdsKpiSeqNo.Locate('SEQNO_ID',pRaito.SEQNO_ID,[])) then
            CdsKpiSeqNo.Delete;
        end;
       2: //���ϵ��:MKT_KPI_RATIO
        begin
          if (pRaito.SEQNO_ID<>'') and (pRaito.GODS_ID<>'') then
          begin
            if CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([pRaito.SEQNO_ID,pRaito.GODS_ID]),[]) then
              CdsKpiRatio.Delete;
          end;
        end
      end;
    end else //��Ϊ������и���DataSet
    begin
      case pRaito.ColType of
       1: //��굵������:MKT_KPI_SEQNO
        begin
          IsEdit:=False;
          if (pRaito.SEQNO_ID<>'') and (CdsKpiSeqNo.Locate('SEQNO_ID',pRaito.SEQNO_ID,[])) then
          begin
            CdsKpiSeqNo.Edit;
            CdsKpiSeqNo.FieldByName('KPI_AMT').AsFloat:=StrToFloatDef(CellText,0.0);
            CdsKpiSeqNo.Post;
            IsEdit:=True;
          end;
          if not IsEdit then
          begin
            SEQ_NO:=CdsKpiSeqNo.RecordCount+1;
            NewID:=TSequence.NewId;
            CdsKpiSeqNo.Append;
            CdsKpiSeqNo.FieldByName('SEQNO_ID').AsString:=NewID;
            CdsKpiSeqNo.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
            CdsKpiSeqNo.FieldByName('KPI_ID').AsString:=Aobj.FieldByName('KPI_ID').AsString;
            CdsKpiSeqNo.FieldByName('LEVEL_ID').AsString:=pRow.LEVEL_ID;
            CdsKpiSeqNo.FieldByName('TIMES_ID').AsString:=pRaito.TIME_ID;
            CdsKpiSeqNo.FieldByName('SEQNO').AsInteger:=SEQ_NO;   //����ǰ�ٴ�����    
            CdsKpiSeqNo.FieldByName('KPI_AMT').AsFloat:=StrToFloatDef(CellText,0.0);  //��������
            CdsKpiSeqNo.Post;
            pRow.Ratio[gCol].SEQNO_ID:=NewID;
            if pRaito.GODS_ID='#' then //��ͨ����
              pRow.Ratio[gCol+1].SEQNO_ID:=NewID 
            else
            begin
              for i:=0 to CdsKpiGoods.RecordCount-1 do //ѭ��
                pRow.Ratio[gCol+1+i].SEQNO_ID:=NewID;
            end;
          end; 
        end;
       2: //���ϵ��:MKT_KPI_RATIO
        begin
          IsEdit:=False;
          if CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([pRaito.SEQNO_ID,pRaito.GODS_ID]),[]) then
          begin
            CdsKpiRatio.Edit;
            CdsKpiRatio.FieldByName('KPI_RATIO').AsFloat:=StrToFloatDef(CellText,0.0);
            CdsKpiRatio.Post;
            IsEdit:=True;
          end;
          if not IsEdit then
          begin
            NewID:=TSequence.NewId;  //��GUID
            CdsKpiRatio.Append;
            CdsKpiRatio.FieldByName('RATIO_ID').AsString:=NewID;
            CdsKpiRatio.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
            CdsKpiRatio.FieldByName('KPI_ID').AsString:=Aobj.FieldByName('KPI_ID').AsString;
            CdsKpiRatio.FieldByName('LEVEL_ID').AsString:=pRow.LEVEL_ID;
            CdsKpiRatio.FieldByName('TIMES_ID').AsString:=pRaito.TIME_ID;
            CdsKpiRatio.FieldByName('SEQNO_ID').AsString:=pRaito.SEQNO_ID;
            CdsKpiRatio.FieldByName('GODS_ID').AsString:=pRaito.GODS_ID;
            if trim(pRaito.GODS_ID)='#' then
              CdsKpiRatio.FieldByName('UNIT_ID').AsString:='#'
            else
              CdsKpiRatio.FieldByName('UNIT_ID').AsString:=GetGodsDefUnitID(pRaito.GODS_ID);
            CdsKpiRatio.FieldByName('KPI_RATIO').AsFloat:=StrToFloatDef(CellText,0.0);   //����ϵ��
            CdsKpiRatio.Post; 
          end; 
        end;  //2:
      end;  //case pRaito.ColType of
    end;  //��Ϊ���ύend
  end;  //for .
end;                              

function TfrmKpiIndexInfo.SaveKpiGridData: Boolean;
var
  gRow: integer;
  pCurRow: pKpiRow;
begin
  //����KpiGrid��ѭ��:�ӵ�һ����ʼѭ��
  for gRow:=2 to KpiGrid.RowCount-1 do
  begin
    if FKpiGridList.Count>=(gRow-2) then
    begin
      pCurRow:=pKpiRow(FKpiGridList.Items[gRow-2]);
      //��Grid����һ�����ݵ�
      WriteRowKpiGridToDataSet(pCurRow,gRow);
    end;
  end;
  if CdsKpiSeqNo.State in [dsInsert,dsEdit] then CdsKpiSeqNo.Post;
  if CdsKpiRatio.State in [dsInsert,dsEdit] then CdsKpiRatio.Post;
end;

procedure TfrmKpiIndexInfo.KpiPmPopup(Sender: TObject);
var
  GODS_ID: string;
  pRow: pKpiRow;
  pRatio: TKpiRatio;
begin
  if FRowIdx>1 then
  begin
    ItemRatio.Visible:=true;
    AddSeqNo.Visible:=true;
    ItemRatio.Enabled:=true;
    AddSeqNo.Enabled:=true;
    //ǰ��6����ʾ
    if FColIdx<4 then
    begin
      ItemRatio.Enabled:=False;
      ItemRatio.Visible:=False;
    end else
    begin
      pRow:=pKpiRow(FKpiGridList.Items[FRowIdx-2]);
      if (pRow.Ratio[FColIdx].GODS_ID='#') or (pRow.Ratio[FColIdx].GODS_ID='') then //��ͨ�����򲻿���
        ItemRatio.Enabled:=False;
      if (ItemRatio.Enabled) and (FRowIdx-2>=0) and (FRowIdx-1<=FKpiGridList.Count) then
      begin
        pRow:=pKpiRow(FKpiGridList.Items[FRowIdx-2]);
        pRatio:=pRow.Ratio[FColIdx];
        if not CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([pRatio.SEQNO_ID,pRatio.GODS_ID]),[]) then
          ItemRatio.Enabled:=False;
      end;
    end;
  end else
  begin
    ItemRatio.Enabled:=False;
    AddSeqNo.Enabled:=False;
    ItemRatio.Visible:=False;
    AddSeqNo.Visible:=False;
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

procedure TfrmKpiIndexInfo.InitKpiGridData;
  function GetColIdx(TimID: string):integer; //����ʱ�η��ؿ��˵���ColIdx
  var i: integer;
  begin
    result:=-1;
    for i:=0 to High(pBaseRow^.Ratio) do
    begin
      if trim(TimID)=trim(pBaseRow^.Ratio[i].TIME_ID) then
      begin
        result:=i;
        Exit;
      end;
    end;
  end;
  //��ʼ��һ���ȼ��ĵ���:
  function InitKpiLevelData(Lvl_ID: string; var vRecNo: integer): Boolean;
  var
    i,j,ColIdx: integer;
    TimID: string;    //�ȼ�ID
    CurFlag: Boolean;  //��ǰѭ�����
    pRow,newRow: pKpiRow;
  begin
    try
      vRecNo:=0;
      //����CdsKpiSeqNo����ѭ��
      CdsKpiSeqNo.Filtered:=False;
      CdsKpiSeqNo.Filter:='LEVEL_ID='''+Lvl_ID+'''';
      CdsKpiSeqNo.Filtered:=True;
      CdsKpiSeqNo.First;
      while not CdsKpiSeqNo.Eof do
      begin
        CurFlag:=False;
        TimID:=trim(CdsKpiSeqNo.FieldByName('TIMES_ID').AsString);
        ColIdx:=GetColIdx(TimID); //���ص�ǰ����������ColIdx
        for i:=0 to FKpiGridList.Count-1 do
        begin
          pRow:=pKpiRow(FKpiGridList.Items[i]);
          if (not CurFlag) and (trim(pRow^.LEVEL_ID)=trim(Lvl_ID)) and
             (pRow^.Ratio[ColIdx].TIME_ID=TimID) and (pRow^.Ratio[ColIdx].SEQNO_ID='') then //ֱ��д���λ��
          begin
            for j:=ColIdx to High(pBaseRow^.Ratio) do
            begin
              if (trim(pRow^.Ratio[j].TIME_ID)=TimID) and (trim(pRow^.Ratio[j].TIME_ID)<>'') then
                pRow^.Ratio[j].SEQNO_ID:=trim(CdsKpiSeqNo.FieldByName('SEQNO_ID').AsString);
            end;
            CurFlag:=true;
          end;
        end;
        if not CurFlag then //û���¼�
        begin
          Inc(vRecNo);
          New(newRow);
          System.Move(pBaseRow^,newRow^,sizeof(pBaseRow^)); //����
          //��ʼ��
          newRow^.RowState:=1;
          newRow^.LEVEL_ID:=Lvl_ID;
          //��ʼ����ǰʱ�ε���
          for j:=ColIdx to High(pBaseRow^.Ratio) do
          begin
            if (trim(newRow^.Ratio[j].TIME_ID)=TimID) and (trim(newRow^.Ratio[j].TIME_ID)<>'') then
              newRow^.Ratio[j].SEQNO_ID:=trim(CdsKpiSeqNo.FieldByName('SEQNO_ID').AsString);
          end;
          FKpiGridList.Add(newRow); 
          CurFlag:=true;
        end;
        CdsKpiSeqNo.Next;
      end;
      if vRecNo=0 then //���ȼ���û���嵵��,Ĭ��һ������
      begin
        Inc(vRecNo);
        New(newRow);
        System.Move(pBaseRow^,newRow^,sizeof(pBaseRow^)); //����
        //��ʼ��
        newRow^.RowState:=0;
        newRow^.LEVEL_ID:=Lvl_ID;
        FKpiGridList.Add(newRow);
      end;
    finally
      CdsKpiSeqNo.Filtered:=False;
      CdsKpiSeqNo.Filter:='';
    end;
  end;
  function GetCellValue(pRaito: TKpiRatio): string;
  begin
    result:='';
    case pRaito.ColType of
     1:
      begin
        if CdsKpiSeqNo.Locate('SEQNO_ID',pRaito.SEQNO_ID,[]) then
        begin
          if not CdsKpiSeqNo.fieldByName('KPI_AMT').IsNull then
            result:=FloatToStr(CdsKpiSeqNo.fieldByName('KPI_AMT').AsFloat);
        end;
      end;
     2:
      begin
        //����Ʒ���� �� ��ͨ����(GODS_ID='#')
        if CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([pRaito.SEQNO_ID,pRaito.GODS_ID]),[])then
        begin
          if not CdsKpiRatio.fieldByName('KPI_RATIO').IsNull then
            result:=FloatToStr(CdsKpiRatio.fieldByName('KPI_RATIO').AsFloat);
        end;
      end;
    end; //case pRaito.ColType of
  end;
var
  CurRow: integer;    //Grid.Draw��
  gRow,gCol,vRowCount: integer;
  Lvl_ID,ReValue: string;       //��ǰʱ��ID
  pRow: pKpiRow;
  pRaito: TKpiRatio;
begin
  if not CdsKpiLevel.Active then Exit;
  if not CdsKpiSeqNo.Active then Exit;
  if not CdsKpiRatio.Active then Exit;
  FKpiGridList.Clear; //���Grid����
  try
    CurRow:=2;
    CdsKpiLevel.First;
    while not CdsKpiLevel.Eof do
    begin
      Lvl_ID:=trim(CdsKpiLevel.FieldByName('LEVEL_ID').AsString); //��ʼ��һ���ȼ�:
      //��ʼ���ȼ�:
      InitKpiLevelData(Lvl_ID,vRowCount);
      //���浱ǰ�ȼ���xx����¼[�ϲ���Ԫ����Ҫ]:
      CdsKpiLevel.Edit;
      CdsKpiLevel.FieldByName('LEVEL_Rows').AsInteger:=vRowCount;
      CdsKpiLevel.Post;

      //��ʼ����Grid(�ж��Ƿ��һ�γ�ʼGrid��)
      CurRow:=CurRow+vRowCount;
      if KpiGrid.RowCount<CurRow then KpiGrid.RowCount:=CurRow;

      for gRow:=CurRow-vRowCount to CurRow-1 do  //���ϴ��п�ʼѭ��
      begin
        //д��ǰ��4�У�ֻд��ǰ�ȼ��ĵ�һ��:
        if gRow=(CurRow-vRowCount) then
        begin
          KpiGrid.Cells[0,gRow]:=IntToStr(CdsKpiLevel.RecNo); //���
          KpiGrid.MergeCells(0,gRow,1,vRowCount);
          KpiGrid.Cells[1,gRow]:=trim(CdsKpiLevel.FieldByName('LEVEL_NAME').AsString);    //�ȼ�����
          KpiGrid.MergeCells(1,gRow,1,vRowCount);
          KpiGrid.Floats[2,gRow]:=CdsKpiLevel.FieldByName('LVL_AMT').AsFloat;  //�ȼ������
          KpiGrid.MergeCells(2,gRow,1,vRowCount);
          KpiGrid.Floats[3,gRow]:=CdsKpiLevel.FieldByName('LOW_RATE').AsFloat; //�ȼ������
          KpiGrid.MergeCells(3,gRow,1,vRowCount);
        end;
        //д��ʱ����:��4�п�ʼ:
        pRow:=pKpiRow(FKpiGridList.Items[gRow-2]); //��ǰKpiGird��-2
        for gCol:=4 to KpiGrid.ColCount-1 do
        begin
          KpiGrid.Cells[gCol,gRow]:=GetCellValue(pRow^.Ratio[gCol]); //ȡֵ��䵽Cells��Ԫ��
        end;
      end;
      CdsKpiLevel.Next;
    end;
  finally
  end;
end;

procedure TfrmKpiIndexInfo.KpiGridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if ARow in [0,1] then HAlign := taCenter;
  if ACol=0 then HAlign := taCenter;
end;

procedure TfrmKpiIndexInfo.KpiGridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  if FKpiGridList.Count>0 then
  begin
    if (ARow>1) and (ACol>3) then
      CanEdit := (dbState <> dsBrowse)
    else
      CanEdit := false;
  end else
    CanEdit := false;
end;

function TfrmKpiIndexInfo.GetKpiLevel_ID(RowIdx: integer): string;
var
  CurRow: integer;
begin
  result:='';
  if RowIdx=-1 then
    CurRow:=FRowIdx-2  //������2��
  else
    CurRow:=RowIdx;
  if (CurRow>=0) and (CurRow<=FKpiGridList.Count) then
  begin
    result:=pKpiRow(FKpiGridList.Items[CurRow]).LEVEL_ID;
  end;
end;

function TfrmKpiIndexInfo.GetKpiTimes_ID(ColIdx: integer): string;
var
  CurIdx: integer;
  FieldName: string; //�ֶ���
begin
  result:='';
  if ColIdx=-1 then //Ĭ�ϵ�ǰ��Ԫ��
     CurIdx:=FColIdx
  else
     CurIdx:=ColIdx;
  if (CurIdx>3) and (CurIdx<KpiGrid.ColCount-1) then
    result:=pBaseRow^.Ratio[CurIdx].TIME_ID;
end;

procedure TfrmKpiIndexInfo.KpiGridClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  FRowIdx:=ARow; //��ǰ������
  FColIdx:=ACol; //��ǰ������
end;

procedure TfrmKpiIndexInfo.DrawKpiGridData;
begin
  //ˢ��(Draw)KpiGrid
  InitKpiGrid;
  InitKpiGridData;
  FChangeState:=False;
  FListCount:=FKpiGridList.Count;
end;

//��ӵ���
procedure TfrmKpiIndexInfo.AddSeqNoClick(Sender: TObject);
var
  vRow,BegRow,Lvl_Rows: integer;
  LvlID,NewID: string;  //�ȼ�ID
  AryIdx: integer;
  newRow: pKpiRow;
begin
  LvlID:=GetKpiLevel_ID;
  if (LvlID<>'') and (FRowIdx>1) then
  begin
    //�²�����
    New(newRow);
    System.Move(pBaseRow^,newRow^,sizeof(pBaseRow^)); //����
    newRow^.RowState:=0;
    newRow^.LEVEL_ID:=LvlID;
    FKpiGridList.Insert(FRowIdx-1,newRow);   
    //KpiGrid�²���1��
    KpiGrid.InsertRows(FRowIdx+1,1);
    if CdsKpiLevel.Locate('LEVEL_ID',LvlID,[]) then
    begin
      Lvl_Rows:=CdsKpiLevel.FieldByName('LEVEL_Rows').AsInteger+1;
      CdsKpiLevel.Edit;
      CdsKpiLevel.FieldByName('LEVEL_Rows').AsInteger:=Lvl_Rows;
      CdsKpiLevel.Post;
    end;
    BegRow:=2;
    CdsKpiLevel.First;
    while not CdsKpiLevel.Eof do
    begin
      if trim(CdsKpiLevel.FieldByName('LEVEL_ID').AsString)=LvlID then
        Break  //��������˳�
      else
        BegRow:=BegRow+CdsKpiLevel.FieldByName('LEVEL_Rows').AsInteger;
      CdsKpiLevel.Next;
    end;
    //�ϲ���Ԫ��
    KpiGrid.MergeCells(0,BegRow,1,Lvl_Rows);  //�ϲ���1��
    KpiGrid.MergeCells(1,BegRow,1,Lvl_Rows);  //�ϲ���2��
    KpiGrid.MergeCells(2,BegRow,1,Lvl_Rows);  //�ϲ���3��
    KpiGrid.MergeCells(3,BegRow,1,Lvl_Rows);  //�ϲ���4��
  end;
  if not FChangeState then
    FChangeState:=(FListCount<FKpiGridList.Count);
end;

procedure TfrmKpiIndexInfo.RzPageChanging(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
begin
  if (FChangeState=True) and (RzPage.ActivePage=TabSheet4) and (NewIndex<>TabSheet4.TabIndex) then
  begin
    if MessageBox(self.Handle,Pchar('     '+#13+'     ��ǰ���δ������ϵ�����޸Ļ�û���棬�Ƿ񱣴棿   '+#13+'      '),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1)=6 then
    begin
      SaveKpiGridData;
    end;
  end;
end;

procedure TfrmKpiIndexInfo.KpiGridCellsChanged(Sender: TObject; R: TRect);
begin
  //ָ���к��з�Χ���б仯��
  if (not FChangeState) and (FRowIdx>3) and (FColIdx>1) then
    FChangeState:=True;
end;

procedure TfrmKpiIndexInfo.KpiGridKeyPress(Sender: TObject; var Key: Char);
var
  CurText: string;
begin
  CurText:=KpiGrid.Cells[FColIdx,FRowIdx];
  if (Key=#161) or (Key='��') then Key:='.';
  if (StrToFloatDef(CurText,0)>999999999) and (Key<>#8) then
    Raise Exception.Create('�������ֵ������Ч...');
  if Pos('.',CurText)>0 then
  begin
    if Key in ['0'..'9',#8] then
    else Key:=#0;
  end else
  begin
    if Key in ['0'..'9','.',#8] then
    else Key:=#0;
  end;
end;

procedure TfrmKpiIndexInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i: integer;
begin
  if (dbState=dsBrowse) or (Application.Terminated) then exit;
  try
    if FChangeState and 
      (not((dbState = dsInsert) and (trim(edtKPI_NAME.Text)='') and (trim(edtUNIT_NAME.Text)='') and (edtIDX_TYPE.ItemIndex=-1) and (edtKPI_TYPE.ItemIndex=-1))) then
    begin
      i:=MessageBox(handle,Pchar('    ����ָ�����޸ģ��Ƿ񱣴��޸���Ϣ��    '),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
      if i=6 then
      begin
        if CdsKpiLevel.State in [dsEdit,dsInsert] then CdsKpiLevel.Post;
        SaveKpiGridData;
        Save;
        if Saved and Assigned(OnSave) then OnSave(Aobj);
      end;
      if i=2 then abort;
    end;
  except
    CanClose := false;
    Raise;
  end;
end;

procedure TfrmKpiIndexInfo.ItemRatioClick(Sender: TObject);
var
  pRow: pKpiRow;
  pRatio: TKpiRatio;
  RatioObj: TRecord_;
  Lvl_ID,Gods_ID: string;
begin
  if (FRowIdx-2>=0) and (FRowIdx-1<=FKpiGridList.Count) and (FColIdx>3) then
  begin
    pRow:=pKpiRow(FKpiGridList.Items[FRowIdx-2]);
    pRatio:=pRow.Ratio[FColIdx];
    if pRatio.ColType=2 then
    begin
      if CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([pRatio.SEQNO_ID,pRatio.GODS_ID]),[]) then
      begin
        try
          RatioObj:=TRecord_.Create;
          RatioObj.ReadFromDataSet(CdsKpiRatio);
          Lvl_ID:=trim(RatioObj.FieldByName('LEVEL_ID').AsString);
          Gods_ID:=trim(RatioObj.FieldByName('GODS_ID').AsString);
          if CdsKpiLevel.Locate('LEVEL_ID',Lvl_ID,[]) then
            RatioObj.FieldByName('LEVEL_ID').AsString:=trim(CdsKpiLevel.FieldByName('LEVEL_NAME').AsString);
          if CdsKpiGoods.Locate('GODS_ID',Gods_ID,[]) then
            RatioObj.FieldByName('GODS_ID').AsString:=trim(CdsKpiGoods.FieldByName('GODS_NAME').AsString);
          if TfrmKpiRatioSet.EditDialog(RatioObj) then
          begin
            CdsKpiRatio.Edit;
            CdsKpiRatio.FieldByName('UNIT_ID').AsString:=RatioObj.FieldByName('UNIT_ID').AsString;
            CdsKpiRatio.Post;
          end;
        finally
          RatioObj.Free;
        end;
      end;
    end;
  end;
end;

end.

