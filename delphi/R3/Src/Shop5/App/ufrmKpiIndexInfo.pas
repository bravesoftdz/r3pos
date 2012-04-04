unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox, DateUtils,
  cxMemo, BaseGrid, AdvGrid, Buttons, DBGrids, cxSpinEdit, cxButtonEdit;

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
    CdsKpiGoods: TZQuery;
    Ds_KpiGoods: TDataSource;
    Pm_Level: TPopupMenu;
    Pm_Gods: TPopupMenu;
    AddGoods: TMenuItem;
    DeleteGoods: TMenuItem;
    DelLevel: TMenuItem;
    Notebook1: TNotebook;
    DBGridEh1: TDBGridEh;
    RzLabel4: TRzLabel;
    AddLevel: TMenuItem;
    TabSheet3: TRzTabSheet;
    RzPanel3: TRzPanel;
    Ds_KpiTimes: TDataSource;
    CdsKpiTimes: TZQuery;
    Pm_Times: TPopupMenu;
    AddKpiTimes: TMenuItem;
    EditKpiTimes: TMenuItem;
    DelKpiTimes: TMenuItem;
    TabSheet4: TRzTabSheet;
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
    RzLabel10: TRzLabel;
    RzLabel5: TRzLabel;
    KpiPm: TPopupMenu;
    ItemRatio: TMenuItem;    
    CdsKpiRatio: TZQuery;
    CdsKpiSeqNo: TZQuery;
    AddSeqNo: TMenuItem;
    TabSheet5: TRzTabSheet;
    RzPanel5: TRzPanel;
    DBGridEh5: TDBGridEh;
    fndUNIT_ID1: TcxComboBox;
    CdsMktGoods: TZQuery;
    Ds_MktGoods: TDataSource;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    RzPnl_left: TRzPanel;
    RzPanel7: TRzPanel;
    RzPnl_right: TRzPanel;
    DBGridEh3: TDBGridEh;
    DBGridEh2: TDBGridEh;
    RzPanel9: TRzPanel;
    fndUNIT_ID: TcxComboBox;
    RzPanel1: TRzPanel;
    KpiGrid: TAdvStringGrid;
    Btn_Left_add: TRzBitBtn;
    Btn_Left_del: TRzBitBtn;
    Btn_Right_add: TRzBitBtn;
    Btn_Right_edit: TRzBitBtn;
    Btn_Right_del: TRzBitBtn;
    edtUNIT_NAME: TcxTextEdit;
    edtREMARK: TcxTextEdit;
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
    procedure fndUNIT_ID1Enter(Sender: TObject);
    procedure fndUNIT_ID1Exit(Sender: TObject);
    procedure fndUNIT_ID1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fndUNIT_ID1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh5Columns4BeforeShowControl(Sender: TObject);
    procedure fndUNIT_ID1PropertiesChange(Sender: TObject);    
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DeleteGoodsClick(Sender: TObject);
    procedure AddGoodsClick(Sender: TObject);
    procedure DelLevelClick(Sender: TObject);
    procedure AddLevelClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh2KeyPress(Sender: TObject; var Key: Char);
    procedure edtIDX_TYPEPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtKPI_NAMEPropertiesChange(Sender: TObject);
    procedure DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure AddKpiTimesClick(Sender: TObject);
    procedure EditKpiTimesClick(Sender: TObject);
    procedure DelKpiTimesClick(Sender: TObject);
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
    procedure DBGridEh5DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N8Click(Sender: TObject);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure RzPanel3Resize(Sender: TObject);
    procedure Btn_Left_addClick(Sender: TObject);
    procedure Btn_Left_delClick(Sender: TObject);
    procedure Btn_Right_addClick(Sender: TObject);
    procedure Btn_Right_delClick(Sender: TObject);
    procedure Btn_Right_editClick(Sender: TObject);
    procedure edtUNIT_NAMEPropertiesChange(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure KpiGridGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: String);
  private
    pBaseRow:pKpiRow;   //��ʼ������ʱ
    FKpiState: Boolean; //����ָ��״̬
    FChangeState: Boolean;  //���Ρ�ϵ���༭״̬
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
    procedure FocusNextColumn(IsRight: Boolean=False);
    //����ָ���ʼ��
    procedure InitKpiGrid;      //��ʼ����ͷ
    procedure InitKpiGridData;  //��ʼ������
    procedure DrawKpiGridData;  //�����
    procedure SetKpiState;      //���ñ仯״̬
    function WriteRowKpiGridToDataSet(pRow: pKpiRow; GridRow: integer):Boolean; //��Grid����һ�����ݵ�
    function SaveKpiGridData:Boolean;     //��Grid�������ݵ����ݼ�
    function GetKpiLevel_ID(RowIdx: integer=-1):string;   //��ǰ��ѡ�еȼ�Level_ID
    function GetKpiTimes_ID(ColIdx: integer=-1):string;
    procedure SetChangeState(const Value: Boolean);   //��ǰ��ѡ��ʱ��Times_ID
  public
    RowID:integer;
    Aobj:TRecord_;
    destructor Destroy;override;
    function  FindColumn(FindGrid:TDBGridEh; FieldName:string):TColumnEh;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure CheckKpiLevel;  //����ж�KpiLevel��¼���
    procedure BeforSaveCheckData; //����ǰ�ж����ݺϷ���
    procedure Save;
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:string):boolean;
    property ChangeState:Boolean read FChangeState write SetChangeState;
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
          _AObj.AddField('GOODS_SUM',CdsKpiGoods.RecordCount,ftFloat);
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
  Aobj.FieldByName('KPI_ID').AsString := TSequence.NewId;  //guid
  Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID; //TENANT_ID
  edtKPI_TYPE.ItemIndex := TdsItems.FindItems(edtKPI_TYPE.Properties.Items,'CODE_ID','1');
  edtIDX_TYPE.ItemIndex := TdsItems.FindItems(edtIDX_TYPE.Properties.Items,'CODE_ID','1');
end;

procedure TfrmKpiIndexInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
end;

class function TfrmKpiIndexInfo.EditDialog(Owner: TForm; id: string; var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002143',3) then Raise Exception.Create('��û���޸Ŀ���ָ���Ȩ��,��͹���Ա��ϵ.');
   with TfrmKpiIndexInfo.Create(Owner) do
    begin
      try
        Edit(id);
        if ShowModal=MROK then
        begin
          _AObj.AddField('GOODS_SUM',CdsKpiGoods.RecordCount,ftFloat);
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
      Factor.AddBatch(CdsMktGoods,'TMktRatio',Params);
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
begin
  if dbState=dsBrowse then exit;
  BeforSaveCheckData; //����ǰ�ж����ݺϷ���
  CheckKpiLevel;  //����ж�KpiLevel��¼���

  //������
  WriteToObject(Aobj,self); //
  CdsKpiIndex.Edit;
  Aobj.WriteToDataSet(CdsKpiIndex);
  //����ָ��
  if CdsKpiIndex.State in [dsInsert,dsEdit] then CdsKpiIndex.Post;
  //1�����˵ȼ�
  if CdsKpiLevel.State in [dsInsert,dsEdit] then CdsKpiLevel.Post;
  //2��������Ʒ
  if CdsKpiGoods.State in [dsInsert,dsEdit] then CdsKpiGoods.Post;
  //3������ʱ��
  if CdsKpiTimes.State in [dsInsert,dsEdit] then CdsKpiTimes.Post;
  //4�����˵���
  if CdsKpiSeqNo.State in [dsInsert,dsEdit] then CdsKpiSeqNo.Post;
  //5������ϵ��
  if CdsKpiRatio.State in [dsInsert,dsEdit] then CdsKpiRatio.Post;
  //6���г��Ѽ���
  if CdsMktGoods.State in [dsInsert,dsEdit] then CdsMktGoods.Post;

  //�������
  Factor.BeginBatch;
  try
    Factor.AddBatch(CdsKpiIndex,'TKpiIndex');
    Factor.AddBatch(CdsKpiLevel,'TKpiLevel');
    Factor.AddBatch(CdsKpiGoods,'TKpiGoods');
    Factor.AddBatch(CdsKpiTimes,'TKpiTimes');
    Factor.AddBatch(CdsKpiSeqNo,'TKpiSeqNo');
    Factor.AddBatch(CdsKpiRatio,'TKpiRatio');
    Factor.AddBatch(CdsMktGoods,'TMktRatio');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    CdsKpiIndex.CancelUpdates;
    CdsKpiLevel.CancelUpdates;
    CdsKpiGoods.CancelUpdates;
    CdsKpiTimes.CancelUpdates;
    CdsKpiSeqNo.CancelUpdates;        
    CdsKpiRatio.CancelUpdates;
    CdsMktGoods.CancelUpdates;
    Raise;
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
  FKpiState:=False;
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
  if Saved and Assigned(OnSave) then
  begin
    Aobj.FieldByName('GOODS_SUM').AsInteger:=CdsKpiGoods.RecordCount; //��Ʒ��¼��
    OnSave(Aobj);
  end;
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
       DBGridEh1.SetFocus;
       fndUNIT_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_LEFT) then
     begin
       DBGridEh1.SetFocus;
       fndUNIT_ID.Visible := false;
       DBGridEh2.Col := DBGridEh2.Col -1;
     end;
  if (Key=VK_UP) and (Shift=[]) and not fndUNIT_ID.DroppedDown then
     begin
       DBGridEh1.SetFocus;
       fndUNIT_ID.Visible := false;
       if CdsKpiGoods.Active then CdsKpiGoods.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not fndUNIT_ID.DroppedDown then
     begin
       DBGridEh1.SetFocus;
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
       DBGridEh1.SetFocus;
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
    if CdsKpiGoods.State in [dsInsert,dsEdit] then CdsKpiGoods.Post;
    SetKpiState; //�����޸�״̬
  end;
end;

procedure TfrmKpiIndexInfo.InitGrid;
var
  rs:TZQuery;
  SetCol1,SetCol2:TColumnEh;
begin
  inherited;
  SetCol1 := FindColumn(DBGridEh1,'UNIT_ID');
  SetCol2 := FindColumn(DBGridEh5,'UNIT_ID');
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
  begin
    if SetCol1<>nil then
    begin
      SetCol1.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      SetCol1.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
    end;
    if SetCol2<>nil then
    begin
      SetCol2.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      SetCol2.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
    end;
    rs.Next;
  end;
  if SetCol1<>nil then
  begin
    SetCol1.ReadOnly := true;
    SetCol1.Control := fndUNIT_ID;
    SetCol1.OnBeforeShowControl := DBGridEh2Columns4BeforeShowControl;
  end;
  if SetCol2<>nil then
  begin
    SetCol2.ReadOnly := true;
    SetCol2.Control := fndUNIT_ID1;
    SetCol2.OnBeforeShowControl := DBGridEh5Columns4BeforeShowControl;
  end;  
end;

procedure TfrmKpiIndexInfo.FocusNextColumn(IsRight: Boolean);
var i:Integer;
begin
  if RzPage.ActivePage = self.TabSheet1 then  //��Ʒ�嵥
  begin
    i:=DbGridEh1.Col;
    if CdsKpiGoods.RecordCount>CdsKpiGoods.RecNo then
    begin
      CdsKpiGoods.Next;
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
        if Trim(CdsKpiGoods.FieldbyName('GODS_ID').asString)='' then
          i := 1;
        if (i=1) and (Trim(CdsKpiGoods.FieldbyName('GODS_ID').asString)<>'') then
        begin
          CdsKpiGoods.Next ;
          if CdsKpiGoods.Eof then
          begin
            CdsKpiGoods.First;
          end;
          DbGridEh1.SetFocus;
          DbGridEh1.Col := 1 ;
        end else
        DbGridEh1.Col := i;
        Exit;
      end;
    end;
  end else
  if RzPage.ActivePage = self.TabSheet3 then
  begin              
    if not IsRight then //���:DbGridEh2
    begin
      i:=DbGridEh2.Col;
      if CdsKpiLevel.RecordCount>CdsKpiLevel.RecNo then
      begin
        CdsKpiLevel.Next;
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
          if (i=1) and (CdsKpiLevel.FieldByName('LEVEL_NAME').AsString <> '') then
          begin
            CdsKpiLevel.Next ;
            if CdsKpiLevel.Eof then
            begin
              InitRecord;
            end;
            DbGridEh2.SetFocus;
            DbGridEh2.Col := i;
          end else
            DbGridEh2.Col := i;
          Exit;
        end;
      end;
    end else
    begin
      i:=DBGridEh3.Col;
      if CdsKpiTimes.RecordCount>CdsKpiTimes.RecNo then
      begin
        CdsKpiTimes.Next;
        Exit;
      end;
      Inc(i);
      while True do
      begin
        if i>=DBGridEh3.Columns.Count then i:= 1;
        if (DBGridEh3.Columns[i].ReadOnly or not DBGridEh3.Columns[i].Visible) and (i<>1) then
          inc(i)
        else
        begin
          if (i=1) and (CdsKpiTimes.FieldByName('LEVEL_NAME').AsString <> '') then
          begin
            CdsKpiTimes.Next ;
            if CdsKpiTimes.Eof then
            begin
              CdsKpiTimes.First;;
            end;
            DbGridEh3.SetFocus;
            DbGridEh3.Col := i;
          end else
            DbGridEh3.Col := i;
          Exit;
        end;
      end;
    end;
  end else
  if RzPage.ActivePage = self.TabSheet5 then
  begin
    i:=DbGridEh5.Col;
    if CdsMktGoods.RecordCount>CdsMktGoods.RecNo then
    begin
      CdsMktGoods.Next;
      Exit;
    end;
    Inc(i);
    while True do
    begin
      if i>=DbGridEh5.Columns.Count then i:= 1;
      if (DbGridEh5.Columns[i].ReadOnly or not DbGridEh5.Columns[i].Visible) and (i<>1) then
        inc(i)
      else
      begin
        if Trim(CdsMktGoods.FieldbyName('GODS_ID').asString)='' then
          i := 1;
        if (i=1) and (Trim(CdsMktGoods.FieldbyName('GODS_ID').asString)<>'') then
        begin
          CdsMktGoods.Next ;
          if CdsMktGoods.Eof then
          begin
            CdsMktGoods.First;
          end;
          DbGridEh5.SetFocus;
          DbGridEh5.Col := 1 ;
        end else
        DbGridEh5.Col := i;
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

function TfrmKpiIndexInfo.FindColumn(FindGrid:TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to FindGrid.Columns.Count -1 do
  begin
    if UpperCase(FindGrid.Columns[i].FieldName)=UpperCase(FieldName) then
    begin
      Result := FindGrid.Columns[i];
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
    if DBGridEh2.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh2.SetFocus;
  finally
    CdsKpiLevel.EnableControls;
    CdsKpiLevel.Edit;
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect: TRect;
  GridDs: TDataSet;
begin
  inherited;
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col,DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  GridDs:=TDataSet(TDBGridEh(Sender).DataSource.DataSet);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.Brush.Color := $0000F2F2;
      DbGridEh2.canvas.FillRect(ARect);
      DrawText(DbGridEh2.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)),length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndexInfo.DeleteGoodsClick(Sender: TObject);
var
  GodsID: string;
begin
  inherited;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if CdsKpiGoods.IsEmpty then Exit;
  if MessageBox(Handle,pchar('ȷ��ɾ��"'+CdsKpiGoods.FieldbyName('GODS_NAME').AsString+'"��Ʒ��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
  begin
    GodsID:=trim(CdsKpiGoods.FieldByName('GODS_ID').AsString);
    CdsKpiGoods.Delete;
    if CdsMktGoods.Locate('GODS_ID',GodsID,[]) then
      CdsMktGoods.Delete;
    DBGridEh1.SetFocus;
  end;
  SetKpiState; //�����޸�״̬
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
  function GetGodsUnitID: string;
  var RsUnit,RsGods: TZQuery; GodsID: string;
  begin
    result:=AObj.FieldbyName('UNIT_ID').AsString;  //Ĭ�ϵ�ǰ��ƷĬ�ϵ�λ
    GodsID:=trim(AObj.FieldByName('GODS_ID').AsString);
    RsUnit:=Global.GetZQueryFromName('PUB_MEAUNITS'); //��λDataSet;
    RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO'); 
    //�������뵥λ���ƶ�λ�Ƿ���ڴ���Ʒ
    if (trim(edtUNIT_NAME.Text)<>'') and (RsGods.Locate('GODS_ID',GodsID,[])) then
    begin
      //������λ
      if RsUnit.Locate('UNIT_ID',trim(RsGods.FieldbyName('CALC_UNITS').AsString),[]) then
      begin
        if trim(RsUnit.FieldByName('UNIT_NAME').AsString)=trim(edtUNIT_NAME.Text) then
          result:=trim(RsGods.FieldbyName('CALC_UNITS').AsString);
      end;
      //С����λ
      if RsUnit.Locate('UNIT_ID',trim(RsGods.FieldbyName('SMALL_UNITS').AsString),[]) then
      begin
        if trim(RsUnit.FieldByName('UNIT_NAME').AsString)=trim(edtUNIT_NAME.Text) then
          result:=trim(RsGods.FieldbyName('SMALL_UNITS').AsString);
      end;
      //�����λ
      if RsUnit.Locate('UNIT_ID',trim(RsGods.FieldbyName('BIG_UNITS').AsString),[]) then
      begin
        if trim(RsUnit.FieldByName('UNIT_NAME').AsString)=trim(edtUNIT_NAME.Text) then
          result:=trim(RsGods.FieldbyName('BIG_UNITS').AsString);
      end;
    end; 
  end;
var
  GODS_ID,UNIT_ID: string;
  basInfo:TZQuery;
begin
  UNIT_ID:='';
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not basInfo.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ӫ��Ʒ��û�ҵ�"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
  GODS_ID:=trim(AObj.FieldbyName('GODS_ID').AsString);
  if not CdsKpiGoods.Locate('GODS_ID',GODS_ID,[]) then //û�������
  begin
    //�����Ʒ�嵥
    CdsKpiGoods.Append;
    CdsKpiGoods.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    CdsKpiGoods.FieldByName('KPI_ID').AsString := Self.Aobj.FieldByName('KPI_ID').AsString;
    CdsKpiGoods.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
    CdsKpiGoods.FieldByName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
    CdsKpiGoods.FieldByName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
    CdsKpiGoods.FieldByName('BARCODE').AsString := AObj.FieldbyName('BARCODE').AsString;
    CdsKpiGoods.FieldByName('UNIT_ID').AsString := GetGodsUnitID;
    CdsKpiGoods.Post;
    //����г�����Ʒ�嵥
    if not CdsMktGoods.Locate('GODS_ID',GODS_ID,[]) then //û�������
    begin
      CdsMktGoods.Append;
      CdsMktGoods.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      CdsMktGoods.FieldByName('ACTR_ID').AsString := TSequence.NewId;
      CdsMktGoods.FieldByName('KPI_ID').AsString := Self.Aobj.FieldByName('KPI_ID').AsString;
      CdsMktGoods.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
      CdsMktGoods.FieldByName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
      CdsMktGoods.FieldByName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
      CdsMktGoods.FieldByName('BARCODE').AsString := AObj.FieldbyName('BARCODE').AsString;
      CdsMktGoods.FieldByName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString;
      CdsMktGoods.Post;
    end;
  end;
end;

procedure TfrmKpiIndexInfo.AddGoodsClick(Sender: TObject);
begin
  inherited;
  if not CdsKpiGoods.Active then Exit;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  OpenDialogGoods;
  SetKpiState; //�����޸�״̬
end;

procedure TfrmKpiIndexInfo.DelLevelClick(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiLevel.IsEmpty and (MessageBox(Handle,pchar('ȷ��ɾ����"ǩԼ�ȼ�"��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
  begin
    CdsKpiLevel.Delete;
    DBGridEh2.SetFocus;
    SetKpiState; //�����޸�״̬
  end;
end;

procedure TfrmKpiIndexInfo.AddLevelClick(Sender: TObject);
begin
  inherited;
  if not CdsKpiLevel.Active then Exit;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  InitRecord;
  DBGridEh2.SetFocus;
  SetKpiState; //�����޸�״̬
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
  GridDs: TDataSet;
begin
  GridDs:=TDataSet(TDBGridEh(Sender).DataSource.DataSet);
  if Column.FieldName = 'SEQNO' then
   begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)),length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

destructor TfrmKpiIndexInfo.Destroy;
begin
  fndUNIT_ID.Properties.Items.Clear;
  fndUNIT_ID1.Properties.Items.Clear;
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
  GridDs: TDataSet;  
begin
  GridDs:=TDataSet(TDBGridEh(Sender).DataSource.DataSet);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh3.canvas.Brush.Color := $0000F2F2;
      DBGridEh3.canvas.FillRect(ARect);
      DrawText(DBGridEh3.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)),length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndexInfo.AddKpiTimesClick(Sender: TObject);
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
        SetKpiState; //�����޸�״̬
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmKpiIndexInfo.EditKpiTimesClick(Sender: TObject);
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
        SetKpiState; //�����޸�״̬
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

procedure TfrmKpiIndexInfo.DelKpiTimesClick(Sender: TObject);
begin
  inherited;
  if DBGridEh3.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if not CdsKpiTimes.IsEmpty and (MessageBox(Handle,pchar('ȷ��ɾ����"ʱ��"��'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
  begin
    CdsKpiTimes.Delete;
    Dec(RowID);
    DBGridEh3.SetFocus;
    SetKpiState; //�����޸�״̬
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
  KpiGrid.ColCount:=3;
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
  KpiGrid.ColWidths[1] := 80;
  SetpRowValue(1,0,'','');
  //��3��
 {KpiGrid.MergeCells(2,0,1,2);
  KpiGrid.Cells[2,0] := 'ǩԼ��';
  KpiGrid.ColWidths[2] := 50;
  SetpRowValue(2,0,'','');}
  //��4��
  KpiGrid.MergeCells(2,0,1,2);
  KpiGrid.Cells[2,0] := '��������';
  KpiGrid.ColWidths[2] := 60;
  SetpRowValue(2,0,'','');
  //����ʱ��:
  vCol:=2;
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
      SetpRowValue(vCol,1,TimeID,'#');

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
  gCol,i,j,SEQ_NO: integer;   //ѭ����
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
          //����ɾ��������Ӧϵ��Ҳɾ����:
          if trim(pRaito.GODS_ID)='#' then //��ͨ����
            KpiGrid.Cells[gCol+1,GridRow]:='' 
          else  //����Ʒ����
          begin
            for j:=gCol+1 to KpiGrid.ColCount-1 do
            begin
              if (pRow.Ratio[j].GODS_ID=pRaito.GODS_ID) and (trim(KpiGrid.Cells[j,GridRow])<>'') then
                KpiGrid.Cells[j,GridRow]:='';
            end; 
          end;
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
            if pRow.Ratio[gCol+1].GODS_ID='#' then //��ͨ����
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
  result:=False;
  if FKpiGridList.Count<=0 then Exit;
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
  FChangeState:=False;
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
          //KpiGrid.Cells[2,gRow]:=FloatToStr(CdsKpiLevel.FieldByName('LVL_AMT').AsFloat);  //�ȼ������
          //KpiGrid.MergeCells(2,gRow,1,vRowCount);
          KpiGrid.Cells[2,gRow]:=FloatToStr(CdsKpiLevel.FieldByName('LOW_RATE').AsFloat)+'%'; //�ȼ������
          KpiGrid.MergeCells(2,gRow,1,vRowCount);
        end;
        //д��ʱ����:��4�п�ʼ:
        pRow:=pKpiRow(FKpiGridList.Items[gRow-2]); //��ǰKpiGird��-2
        for gCol:=3 to KpiGrid.ColCount-1 do
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
  if (ARow>1) and (ACol>2) then HAlign:=taRightJustify;
end;

procedure TfrmKpiIndexInfo.KpiGridCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
var
  i: integer;
  EmptyFlag: Boolean;
  TIMES_ID: string;
  pCurRow: pKpiRow;  //��ʼ������ʱ
begin
  inherited;
  if FKpiGridList.Count>0 then
  begin
    if (ARow>1) and (ACol>2) then
    begin
      CanEdit := (dbState <> dsBrowse);
      //�ж��Ƿ�����д���˵���:[MKT_KPI_SEQNO]
      if CanEdit and (pBaseRow.Ratio[ACol].ColType=2) then
      begin
        //��ͨ����
        if (pBaseRow.Ratio[ACol].GODS_ID='#') and (KpiGrid.Floats[ACol-1,ARow]<=0) then
        begin
          KpiGrid.Cells[ACol,ARow]:='';
          CanEdit:=False;
        end;
        //����Ʒ����
        if pBaseRow.Ratio[ACol].GODS_ID<>'#' then
        begin
          EmptyFlag:=False;
          TIMES_ID:=pBaseRow.Ratio[ACol].TIME_ID;
          for i:=4 to KpiGrid.ColCount do //�ӵ�4�п�ʼѭ�� �����һ��
          begin
            if (trim(pBaseRow.Ratio[i].TIME_ID)=trim(TIMES_ID)) and (trim(pBaseRow.Ratio[i].TIME_ID)<>'') then //ʱ����ͬ
            begin
              if (trim(pBaseRow.Ratio[i].GODS_ID)='#') and (KpiGrid.Floats[i,ARow]<=0) then
              begin
                EmptyFlag:=True;
                CanEdit:=False;
              end;
              if EmptyFlag and (trim(pBaseRow.Ratio[i].GODS_ID)<>'#') and (KpiGrid.Cells[i,ARow]<>'') then
                KpiGrid.Cells[i,ARow]:=''; 
            end;
          end;
        end;
      end;
    end else
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
  if (CurIdx>2) and (CurIdx<KpiGrid.ColCount-1) then
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
  ChangeState:=False;
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
    //KpiGrid.MergeCells(3,BegRow,1,Lvl_Rows);  //�ϲ���4��
  end;
  if not ChangeState then
    ChangeState:=(FListCount<FKpiGridList.Count);
end;

procedure TfrmKpiIndexInfo.RzPageChanging(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
begin
  //����ж�KpiLevel��¼���:
  if (RzPage.ActivePage=TabSheet1) and (NewIndex<>TabSheet1.TabIndex) then
    CheckKpiLevel;
    
  //�ж��Ƿ񱣴�:
  if (ChangeState=True) and (RzPage.ActivePage=TabSheet4) and (NewIndex<>TabSheet4.TabIndex) then
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
  if (not ChangeState) and (FRowIdx>1) and (FColIdx>2) then
    ChangeState:=True;
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
    if FKpiState and 
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
  Lvl_ID,TimID,Gods_ID: string;
begin
  if (FRowIdx-2>=0) and (FRowIdx-1<=FKpiGridList.Count) and (FColIdx>2) then
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
          TimID:=trim(RatioObj.FieldByName('TIMES_ID').AsString);
          Gods_ID:=trim(RatioObj.FieldByName('GODS_ID').AsString);
          if CdsKpiLevel.Locate('LEVEL_ID',Lvl_ID,[]) then
          begin
            RatioObj.FieldByName('LEVEL_ID').AsString:=trim(CdsKpiLevel.FieldByName('LEVEL_NAME').AsString);
            RatioObj.AddField('LVL_AMT',CdsKpiLevel.FieldByName('LVL_AMT').AsFloat,ftFloat);
            RatioObj.AddField('LOW_RATE',CdsKpiLevel.FieldByName('LOW_RATE').AsFloat,ftFloat);
          end;
          if CdsKpiTimes.Locate('TIMES_ID',TimID,[]) then
          begin
            RatioObj.FieldByName('TIMES_ID').AsString:=trim(CdsKpiTimes.FieldByName('TIMES_NAME').AsString);
            RatioObj.AddField('KPI_DATA',CdsKpiTimes.FieldByName('KPI_DATA').AsFloat,ftFloat);
            RatioObj.AddField('KPI_CALC',CdsKpiTimes.FieldByName('KPI_CALC').AsFloat,ftFloat);
            RatioObj.AddField('RATIO_TYPE',CdsKpiTimes.FieldByName('RATIO_TYPE').AsFloat,ftFloat);
          end;
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

procedure TfrmKpiIndexInfo.fndUNIT_ID1Enter(Sender: TObject);
begin
  inherited;
  fndUNIT_ID1.Properties.ReadOnly := DBGridEh5.ReadOnly;
end;

procedure TfrmKpiIndexInfo.fndUNIT_ID1Exit(Sender: TObject);
begin
  inherited;
  fndUNIT_ID1.Visible := False;
end;

procedure TfrmKpiIndexInfo.fndUNIT_ID1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) then
     begin
       DBGridEh5.SetFocus;
       fndUNIT_ID1.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_LEFT) then
     begin
       DBGridEh5.SetFocus;
       fndUNIT_ID1.Visible := false;
       DBGridEh5.Col := DBGridEh5.Col -1;
     end;
  if (Key=VK_UP) and (Shift=[]) and not fndUNIT_ID.DroppedDown then
     begin
       DBGridEh5.SetFocus;
       fndUNIT_ID1.Visible := false;
       if CdsMktGoods.Active then CdsMktGoods.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not fndUNIT_ID1.DroppedDown then
     begin
       DBGridEh5.SetFocus;
       fndUNIT_ID1.Visible := false;
       if CdsMktGoods.Active then
       begin
         CdsMktGoods.Next;
         if CdsMktGoods.Eof then
           CdsMktGoods.First;
       end;
     end;
end;

procedure TfrmKpiIndexInfo.fndUNIT_ID1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    Key := #0;
    DBGridEh5.SetFocus;
    FocusNextColumn;
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh5Columns4BeforeShowControl(Sender: TObject);
var
  rs:TZQuery;
  us:TZQuery;
  GODS_ID: string;
begin
  inherited;
  if CdsMktGoods.IsEmpty then Exit;
  fndUNIT_ID1.Tag := 1;
  try
    GODS_ID:=trim(CdsMktGoods.FieldbyName('GODS_ID').AsString);
    rs := Global.GetZQueryFromName('PUB_GOODSINFO');
    us := Global.GetZQueryFromName('PUB_MEAUNITS');
    fndUNIT_ID1.Properties.Items.Clear;
    if rs.Locate('GODS_ID',GODS_ID,[]) then
    begin
      if us.Locate('UNIT_ID',rs.FieldbyName('CALC_UNITS').AsString,[]) then
        fndUNIT_ID1.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(0));
      if us.Locate('UNIT_ID',rs.FieldbyName('SMALL_UNITS').AsString,[]) then
        fndUNIT_ID1.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(1));
      if us.Locate('UNIT_ID',rs.FieldbyName('BIG_UNITS').AsString,[]) then
        fndUNIT_ID1.Properties.Items.AddObject(us.FieldbyName('UNIT_NAME').AsString,TObject(2));
    end;
    if us.Locate('UNIT_ID',CdsMktGoods.FieldbyName('UNIT_ID').AsString,[]) then
    begin
      fndUNIT_ID1.Properties.ReadOnly := false;
      fndUNIT_ID1.ItemIndex := fndUNIT_ID1.Properties.Items.IndexOf(us.FieldbyName('UNIT_NAME').AsString);
      fndUNIT_ID1.Properties.ReadOnly := (dbState = dsBrowse);
    end;
  finally
    fndUNIT_ID1.Tag := 0;
  end;
end;

procedure TfrmKpiIndexInfo.fndUNIT_ID1PropertiesChange(Sender: TObject);
var
  w:integer;
  rs:TZQuery;
begin
  inherited;
  if fndUNIT_ID1.Tag = 1 then Exit;
  if fndUNIT_ID1.ItemIndex < 0 then Exit;
  if not fndUNIT_ID1.Visible then Exit;
  w := Integer(fndUNIT_ID1.Properties.Items.Objects[fndUNIT_ID1.ItemIndex]);
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',CdsMktGoods.FieldbyName('GODS_ID').AsString,[]) then
  begin
    CdsMktGoods.Edit;
    case w of
     0:CdsMktGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('CALC_UNITS').AsString;
     1:CdsMktGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('SMALL_UNITS').AsString;
     2:CdsMktGoods.FieldByName('UNIT_ID').AsString := rs.FieldbyName('BIG_UNITS').AsString;
    end;
    CdsMktGoods.Post;
    SetKpiState; //�����޸�״̬
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh5DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect: TRect;
  GridDs: TDataSet;    
begin
  inherited;
  if (Rect.Top = DBGridEh5.CellRect(DBGridEh5.Col,DBGridEh5.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh5.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh5.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  GridDs:=TDataSet(TDBGridEh(Sender).DataSource.DataSet);  
  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DbGridEh5.canvas.Brush.Color := $0000F2F2;
    DbGridEh5.canvas.FillRect(ARect);
    DrawText(DbGridEh5.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)),length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmKpiIndexInfo.CheckKpiLevel;
begin
  //�жϿ��˵ȼ������Ƿ�Ϊ��,Ϊ��ɾ����
  if CdsKpiLevel.State in [dsInsert,dsEdit] then CdsKpiLevel.Post; 
  CdsKpiLevel.DisableControls;
  try
    CdsKpiLevel.First;
    while not CdsKpiLevel.Eof do
    begin
      if trim(CdsKpiLevel.FieldByName('LEVEL_NAME').AsString)='' then
      begin
        CdsKpiLevel.Delete;
        Continue;
      end;
      CdsKpiLevel.Next;
    end;
  finally
    CdsKpiLevel.EnableControls;
  end;
end;

procedure TfrmKpiIndexInfo.BeforSaveCheckData;
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
  if trim(edtUNIT_NAME.Text)='' then
  begin
    if edtUNIT_NAME.CanFocus then edtUNIT_NAME.SetFocus;
    raise Exception.Create(' ��λ����Ϊ�գ� ');
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
end;

procedure TfrmKpiIndexInfo.N8Click(Sender: TObject);
begin
  inherited;
  SaveKpiGridData; 
end;

procedure TfrmKpiIndexInfo.SetKpiState;
begin
  if (dbState=dsEdit) and (not FKpiState) then //�༭״̬������
    FKpiState:=true;
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  if trim(Text)<>trim(Value) then
    SetKpiState; //�����޸�״̬
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  if trim(Text)<>trim(Value) then
    SetKpiState; //�����޸�״̬
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  if trim(Text)<>trim(Value) then
    SetKpiState; //�����޸�״̬
end;

procedure TfrmKpiIndexInfo.SetChangeState(const Value: Boolean);
begin
  FChangeState := Value;
  if FChangeState then
    SetKpiState; //�����޸�״̬
end;

procedure TfrmKpiIndexInfo.RzPanel3Resize(Sender: TObject);
begin
  inherited;
  RzPnl_left.Width:=Round(RzPanel3.Width div 2);
end;

procedure TfrmKpiIndexInfo.Btn_Left_addClick(Sender: TObject);
begin
  inherited;
  AddLevel.Click;
end;

procedure TfrmKpiIndexInfo.Btn_Left_delClick(Sender: TObject);
begin
  inherited;
  DelLevel.Click;
end;

procedure TfrmKpiIndexInfo.Btn_Right_addClick(Sender: TObject);
begin
  inherited;
  AddKpiTimes.Click;
end;

procedure TfrmKpiIndexInfo.Btn_Right_delClick(Sender: TObject);
begin
  inherited;
  DelKpiTimes.Click;
end;

procedure TfrmKpiIndexInfo.Btn_Right_editClick(Sender: TObject);
begin
  inherited;
  EditKpiTimes.Click;
end;

procedure TfrmKpiIndexInfo.edtUNIT_NAMEPropertiesChange(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(DBGridEh2,'LVL_AMT');
  if SetCol<>nil then
  begin
    if trim(edtUNIT_NAME.Text)<>'' then
      SetCol.Title.Caption:='ǩԼ��('+trim(edtUNIT_NAME.Text)+')'
    else
      SetCol.Title.Caption:='ǩԼ��'
  end;
end;

procedure TfrmKpiIndexInfo.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  EditKpiTimes.Click;
end;

procedure TfrmKpiIndexInfo.KpiGridGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: String);
 function GetCellValue(TIMES_ID,SEQNO_ID,GODS_ID: String): string;
 var KPI_CALC:integer; UNIT_ID: string; RsTime,RsGods,RsUnit: TZQuery;
 begin
   result:='';
   RsTime:=TZQuery.Create(nil);
   try
     RsTime.Data:=CdsKpiTimes.Data;
     if RsTime.Locate('TIMES_ID',TIMES_ID,[]) then
     begin
       KPI_CALC:=StrToIntDef(trim(RsTime.FieldByName('KPI_CALC').AsString),0);
       //���ϵ������(KPI_CALC:[1:���ٷ���];[2:�������];[3:ָ�����]);
       case KPI_CALC of
        1: result:='��';
        2:
         begin
           //ϵ����λ��
           if CdsKpiRatio.Locate('SEQNO_ID;GODS_ID',VarArrayOf([SEQNO_ID,GODS_ID]),[]) then
             UNIT_ID:=trim(CdsKpiRatio.FieldByName('UNIT_ID').AsString)
           else
           begin
             RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO');
             if RsGods.Locate('GODS_ID',GODS_ID,[]) then
               UNIT_ID:=trim(RsGods.FieldByName('CALC_UNITS').AsString);
           end;
           RsUnit:= Global.GetZQueryFromName('PUB_MEAUNITS');
           if RsUnit.Locate('UNIT_ID',UNIT_ID,[]) then
             result:=trim(RsUnit.FieldByName('UNIT_NAME').AsString);
           if result<>'' then result:='/'+result;
         end;
        3: result:='Ԫ';
       end;
     end;
   finally
     RsTime.Free;
   end;
 end;
var
  i: integer;
  CellText,TIMES_ID,SEQNO_ID,GODS_ID: string;
  pRow: pKpiRow;
begin
  CellText:=trim(KpiGrid.Cells[ACol,ARow]);
  if ACol=0 then
    FloatFormat:=CellText;
  if (ARow>1) and (ACol>2) and (FKpiGridList.Count>0) then
  begin
    if CellText='' then
      FloatFormat:=''
    else
    begin
      pRow:=pKpiRow(FKpiGridList.Items[ARow-2]);
      case pRow.Ratio[ACol].ColType of
       1: //���ε�λ=ָ�굥λ
        begin
          FloatFormat:=CellText+edtUNIT_NAME.Text;
        end;
       2: //���ϵ������(KPI_CALC:[1:���ٷ���];[2:�������];[3:ָ�����]);
        begin
          if pRow.Ratio[ACol].GODS_ID='#' then //��ͨ����(Ĭ��ȡ��һ����Ʒ��λ)
          begin
            for i:=4 to High(pBaseRow.Ratio) do
            begin
              if pBaseRow.Ratio[i].GODS_ID<>'#' then
              begin
                GODS_ID:=trim(pBaseRow.Ratio[i].GODS_ID);
                break;
              end;
            end;
            FloatFormat:=CellText+GetCellValue(pRow.Ratio[ACol].TIME_ID,pRow.Ratio[ACol].SEQNO_ID,GODS_ID);
          end else
          begin
            FloatFormat:=CellText+GetCellValue(pRow.Ratio[ACol].TIME_ID,pRow.Ratio[ACol].SEQNO_ID,pRow.Ratio[ACol].GODS_ID);
          end;
        end;
      end;
    end;
  end;
end;

end.

