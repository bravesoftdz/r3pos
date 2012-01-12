unit ufrmKpiIndexInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxDropDownEdit, Grids, DBGridEh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, cxCalendar, cxRadioGroup, cxCheckBox, DateUtils;

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
    Label1: TLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzPanel3: TRzPanel;
    edtKPI_LV: TcxComboBox;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    labKPI_LV: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    edtUNIT_NAME: TcxTextEdit;
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
    procedure edtIDX_TYPEPropertiesChange(Sender: TObject);
    procedure edtKPI_CALCPropertiesChange(Sender: TObject);
    procedure edtKPI_DATAPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtKPI_LVPropertiesChange(Sender: TObject);
    procedure D1PropertiesChange(Sender: TObject);
    procedure D2PropertiesChange(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns3EditButtonClick(Sender: TObject;
      var Handled: Boolean);
  private
    { Private declarations }
    Saved,DisplayPer:Boolean;
    KpiAgioFront,KpiAgioBack:String;
    Date_1,Date_2,Date_3,Date_4:TDateRecord;
    C1,C2,C3,C4:Integer;
    function IsNull:Boolean;
    procedure ShowGrid;
    procedure InitGrid;
    procedure WMInitRecord(var Message: TMessage); message WM_INIT_RECORD;
    procedure InitRecord;
    procedure OpenDialogGoods;
    procedure AddFromDialog(AObj:TRecord_);
    procedure FocusNextColumn;
    procedure AddItem;
  public
    { Public declarations }
    //SEQNO DbGrid1控制号
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
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,uframeSelectGoods;//
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
  edtKPI_AGIO.Text := '100';
  edtKPI_OPTN.Checked := True;
  edtKPI_TYPE.ItemIndex := TdsItems.FindItems(edtKPI_TYPE.Properties.Items,'CODE_ID','1');
  edtKPI_CALC.ItemIndex := TdsItems.FindItems(edtKPI_CALC.Properties.Items,'CODE_ID','1');
  edtIDX_TYPE.ItemIndex := TdsItems.FindItems(edtIDX_TYPE.Properties.Items,'CODE_ID','1');
  edtKPI_DATA.ItemIndex := TdsItems.FindItems(edtKPI_DATA.Properties.Items,'CODE_ID','1');
  edtKPI_LV.ItemIndex := 0;

end;

procedure TfrmKpiIndexInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  if edtKPI_TYPE.ItemIndex in [0,1] then
  begin
     edtKPI_LV.ItemIndex := 0;
     edtKPI_LV.Properties.OnChange(nil);
  end;
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
       edtKPI_OPTN.Checked := True
    else
       edtKPI_OPTN.Checked := False;
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
    //
  finally
    Params.Free;
  end;
end;

procedure TfrmKpiIndexInfo.Save;
var Temp:TZQuery;
    R,R1,R2,R3,R4,R5:Integer;
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
  if edtKPI_DATA.ItemIndex = -1 then
  begin
    if edtKPI_DATA.CanFocus then edtKPI_DATA.SetFocus;
    raise Exception.Create('考核标准不能为空！');
  end;
  if edtKPI_CALC.ItemIndex = -1 then
  begin
    if edtKPI_CALC.CanFocus then edtKPI_CALC.SetFocus;
    raise Exception.Create('计算标准不能为空！');
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
  if edtKPI_OPTN.Checked then
     Aobj.FieldByName('KPI_OPTN').AsString := '1'
  else
     Aobj.FieldByName('KPI_OPTN').AsString := '2';

  Filter := CdsKpiOption.Filter;
  CdsKpiOption.DisableControls;
  try
    CdsKpiOption.Filtered := False;
    if edtKPI_OPTN.Checked then
    begin
      CdsKpiOption.First;
      while not CdsKpiOption.Eof do
      begin
        if not IsNull then
           raise Exception.Create('"指标标准"页中有必填项不能为空!');
        CdsKpiOption.Next;
      end;
    end;

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
        R1 := 0;
        R2 := 0;
        R3 := 0;
        R4 := 0;
        R5 := 0;
      
        CdsKpiOption.First;
        while not CdsKpiOption.Eof do
        begin
          if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 0 then
          begin
             Inc(R5);
             R := R5;
          end
          else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 1 then
          begin
             Inc(R1);
             R := R1;
          end
          else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 2 then
          begin
             Inc(R2);
             R := R2;
          end
          else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 3 then
          begin
             Inc(R3);
             R := R3;
          end
          else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 4 then
          begin
             Inc(R5);
             R := R5;
          end;
          CdsKpiOption.Edit;
          CdsKpiOption.FieldByName('SEQNO').AsInteger := R;
          if CdsKpiOption.FieldByName('TENANT_ID').AsString = '' then
            CdsKpiOption.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          if CdsKpiOption.FieldByName('KPI_ID').AsString = '' then
            CdsKpiOption.FieldByName('KPI_ID').AsString := CdsKpiIndex.FieldbyName('KPI_ID').AsString;
          if edtKPI_DATA.ItemIndex in [0,1,2] then
             CdsKpiOption.FieldByName('KPI_AMT').Value := null
          else
             CdsKpiOption.FieldByName('KPI_RATE').Value := null;

          if edtKPI_TYPE.ItemIndex <> 2 then
          begin
             if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 1 then
             begin
                CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := Date_1.BeginDate;
                CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := Date_1.EndDate;
             end
             else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 2 then
             begin
                CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := Date_2.BeginDate;
                CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := Date_2.EndDate;
             end
             else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 3 then
             begin
                CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := Date_3.BeginDate;
                CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := Date_3.EndDate;
             end
             else if CdsKpiOption.FieldByName('KPI_LV').AsInteger = 4 then
             begin
                CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := Date_4.BeginDate;
                CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := Date_4.EndDate;
             end;
          end;
          CdsKpiOption.Post;
          CdsKpiOption.Next;
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

    end;
  finally
    if Trim(Filter) <> '' then
    begin
      CdsKpiOption.Filtered := False;
      CdsKpiOption.Filter := Filter;
      CdsKpiOption.Filtered := True;
    end;
    CdsKpiOption.EnableControls;
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
  C1 := 0;
  C2 := 0;
  C3 := 0;
  C4 := 0;
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
     RzPanel3.Visible := False;
     CdsKpiOption.Filtered := False;
     CdsKpiOption.Filter := '';
     if dbState <> dsBrowse then
     begin
       CdsKpiOption.First;
       while not CdsKpiOption.Eof do CdsKpiOption.Delete;
     end;
  end
  else
  begin
     DBGridEh1.Columns[1].Visible := False;
     DBGridEh1.Columns[2].Visible := False;
     RzPanel3.Visible := True;
     CdsKpiOption.Filtered := False;
     CdsKpiOption.Filter := '';
     if dbState <> dsBrowse then
     begin
       CdsKpiOption.First;
       while not CdsKpiOption.Eof do CdsKpiOption.Delete;
     end;
     AddItem;
     edtKPI_LV.ItemIndex := 0;
     edtKPI_LV.Text := edtKPI_LV.Properties.Items.Strings[0];

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
  RzPage.ActivePageIndex := 0;
  if dbState = dsBrowse then
     edtKPI_LV.Properties.ReadOnly := False;
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
             if IsNull then
                i := 1;
             if (i=1) and IsNull then
                begin
                   CdsKpiOption.Next ;
                   if CdsKpiOption.Eof then
                      begin
                        InitRecord;
                      end;
                   DbGridEh1.SetFocus;
                   if edtKPI_TYPE.ItemIndex = 2 then
                      DBGridEh1.Col := 1
                   else
                      if edtKPI_DATA.ItemIndex in [0,1,2] then
                         DbGridEh1.Col := 3
                      else
                         DBGridEh1.Col := 4;
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
  CdsKpiOption.DisableControls;
  try
    CdsKpiOption.Last;
    if CdsKpiOption.IsEmpty or IsNull then
    begin
      inc(RowID);
      CdsKpiOption.Append;
      CdsKpiOption.FieldByName('KPI_ID').Value := null;
      if edtKPI_TYPE.ItemIndex = 2 then
         CdsKpiOption.FieldByName('KPI_LV').AsInteger := 0
      else
         CdsKpiOption.FieldByName('KPI_LV').AsInteger := edtKPI_LV.ItemIndex + 1;
      CdsKpiOption.FieldByName('SEQNO').asInteger := RowID;
      CdsKpiOption.FieldByName('USING_BRRW').AsString := '1';
      CdsKpiOption.Post;
    end;
    if edtKPI_TYPE.ItemIndex = 2 then
       DBGridEh1.Col := 1
    else
       if edtKPI_DATA.ItemIndex in [0,1,2] then
          DbGridEh1.Col := 3
       else
          DBGridEh1.Col := 4;
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
  CdsKpiOption.FieldByName('KPI_DATE1').AsInteger := StrToInt(FormatDateTime('MMDD',edtBeginDate.Date));
  CdsKpiOption.Post;
end;

procedure TfrmKpiIndexInfo.edtEndDatePropertiesChange(Sender: TObject);
begin
  inherited;
  if not CdsKpiOption.Active then Exit;

  CdsKpiOption.Edit;
  CdsKpiOption.FieldByName('KPI_DATE2').AsInteger := StrToInt(FormatDateTime('MMDD',edtEndDate.Date));
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
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
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
  if not CdsKpiGoods.Active then Exit;
  if DBGridEh2.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
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
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmKpiIndexInfo.AddRecord_Click(Sender: TObject);
begin
  inherited;
  if not CdsKpiOption.Active then Exit;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
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

procedure TfrmKpiIndexInfo.edtIDX_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtIDX_TYPE.ItemIndex = 0 then
     KpiAgioFront := '返利'
  else if edtIDX_TYPE.ItemIndex = 1 then
     KpiAgioFront := '计提'
  else if edtIDX_TYPE.ItemIndex = 2 then
     KpiAgioFront := '提成';

  lab_KPI_AGIO.Caption := KpiAgioFront+KpiAgioBack;
  ShowGrid;
end;

procedure TfrmKpiIndexInfo.edtKPI_CALCPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtKPI_CALC.ItemIndex in [0,3] then
  begin
     KpiAgioBack := '系数';
     DisplayPer := False;
  end
  else if edtKPI_CALC.ItemIndex in [1,2,4,5] then
  begin
     KpiAgioBack := '比率';
     DisplayPer := True;
  end;
  lab_KPI_AGIO.Caption := KpiAgioFront+KpiAgioBack;
  ShowGrid;
end;

procedure TfrmKpiIndexInfo.edtKPI_DATAPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtKPI_DATA.ItemIndex in [0,1,2] then
  begin
     DBGridEh1.Columns[3].Visible := True;
     DBGridEh1.Columns[4].Visible := False;
     {if Visible then
     begin
       DBGridEh1.SetFocus;
       if edtKPI_TYPE.ItemIndex = 2 then
          DBGridEh1.Col := 1
       else
          DBGridEh1.Col := 3;
     end;}
  end
  else
  begin
     DBGridEh1.Columns[3].Visible := False;
     DBGridEh1.Columns[4].Visible := True;
     {if Visible then
     begin
       DBGridEh1.SetFocus;
       if edtKPI_TYPE.ItemIndex = 2 then
          DBGridEh1.Col := 1
       else
          DBGridEh1.Col := 4;
     end;}
  end;
end;

procedure TfrmKpiIndexInfo.ShowGrid;
begin
  if DisplayPer then
  begin
    DBGridEh1.Columns[5].Title.Caption := KpiAgioFront + KpiAgioBack;
    DBGridEh1.Columns[5].DisplayFormat := '#0%';
  end
  else
  begin
    DBGridEh1.Columns[5].Title.Caption := KpiAgioFront + KpiAgioBack;
    DBGridEh1.Columns[5].DisplayFormat := '';
  end;
  Label1.Visible := DisplayPer;
end;

function TfrmKpiIndexInfo.IsNull: Boolean;
var B1,B2:Boolean;
begin
  B1 := True;
  B2 := True;
  if edtKPI_TYPE.ItemIndex = 2 then
  begin
     if (CdsKpiOption.FieldByName('KPI_DATE1').AsString = '') or (CdsKpiOption.FieldByName('KPI_DATE2').AsString = '') then
        B1 := False;
  end
  else if edtKPI_TYPE.ItemIndex = 1 then
  begin
     if (edtKPI_LV.ItemIndex = 0) and ((Date_1.BeginDate = 0) or (Date_1.EndDate = 0)) then
        B1 := False;
     if (edtKPI_LV.ItemIndex = 1) and ((Date_2.BeginDate = 0) or (Date_2.EndDate = 0)) then
        B1 := False;
     if (edtKPI_LV.ItemIndex = 2) and ((Date_3.BeginDate = 0) or (Date_3.EndDate = 0)) then
        B1 := False;
     if (edtKPI_LV.ItemIndex = 3) and ((Date_4.BeginDate = 0) or (Date_4.EndDate = 0)) then
        B1 := False;

  end
  else if edtKPI_TYPE.ItemIndex = 0 then
  begin
  end;
  if edtKPI_DATA.ItemIndex in [0,1,2] then
  begin
     if (CdsKpiOption.FieldByName('KPI_RATE').AsString = '') or (CdsKpiOption.FieldByName('KPI_AGIO').AsString = '') then
        B2 := False;
  end
  else
  begin
     if (CdsKpiOption.FieldByName('KPI_AMT').AsString = '') or (CdsKpiOption.FieldByName('KPI_AGIO').AsString = '') then
        B2 := False;
  end;
  if B1 and B2 then
     Result := True
  else
     Result := False;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsKpiOption.RecNo)),length(Inttostr(CdsKpiOption.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndexInfo.AddItem;
begin
  edtKPI_LV.Properties.Items.Clear;
  //ClearCbxPickList(edtKPI_LV);
  if edtKPI_TYPE.ItemIndex = 0 then
  begin
    edtKPI_LV.Properties.Items.AddObject('上半年',TObject(0));
    edtKPI_LV.Properties.Items.AddObject('下半年',TObject(1));
    labKPI_LV.Caption := '年度';
  end
  else if edtKPI_TYPE.ItemIndex = 1 then
  begin
    edtKPI_LV.Properties.Items.AddObject('一季度',TObject(0));
    edtKPI_LV.Properties.Items.AddObject('二季度',TObject(1));
    edtKPI_LV.Properties.Items.AddObject('三季度',TObject(2));
    edtKPI_LV.Properties.Items.AddObject('四季度',TObject(3));
    labKPI_LV.Caption := '季度';
  end;
end;

procedure TfrmKpiIndexInfo.edtKPI_LVPropertiesChange(Sender: TObject);
var Date1,Date2:Integer;
begin
  inherited;
  if edtKPI_LV.ItemIndex = -1 then Exit;
  if CdsKpiOption.State in [dsEdit,dsInsert] then CdsKpiOption.Post;
  CdsKpiOption.Filtered := False;
  CdsKpiOption.Filter := ' KPI_LV='''+IntToStr(edtKPI_LV.ItemIndex+1)+'''';
  CdsKpiOption.Filtered := True;
  if edtKPI_LV.ItemIndex = 0 then
  begin
     if C1 = 0 then
     begin
        Date_1.BeginDate := CdsKpiOption.FieldByName('KPI_DATE1').AsInteger;
        Date_1.EndDate := CdsKpiOption.FieldByName('KPI_DATE2').AsInteger;
     end;
     Inc(C1);
     Date1 := Date_1.BeginDate;
     Date2 := Date_1.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 1 then
  begin
     if C2 = 0 then
     begin
        Date_2.BeginDate := CdsKpiOption.FieldByName('KPI_DATE1').AsInteger;
        Date_2.EndDate := CdsKpiOption.FieldByName('KPI_DATE2').AsInteger;
     end;
     Inc(C2);
     Date1 := Date_2.BeginDate;
     Date2 := Date_2.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 2 then
  begin
     if C3 = 0 then
     begin
        Date_3.BeginDate := CdsKpiOption.FieldByName('KPI_DATE1').AsInteger;
        Date_3.EndDate := CdsKpiOption.FieldByName('KPI_DATE2').AsInteger;
     end;
     Inc(C3);
     Date1 := Date_3.BeginDate;
     Date2 := Date_3.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 3 then
  begin
     if C4 = 0 then
     begin
        Date_4.BeginDate := CdsKpiOption.FieldByName('KPI_DATE1').AsInteger;
        Date_4.EndDate := CdsKpiOption.FieldByName('KPI_DATE2').AsInteger;
     end;
     Inc(C4);
     Date1 := Date_4.BeginDate;
     Date2 := Date_4.EndDate;
  end;
  if Date1 = 0 then
     D1.Date := Date()
  else
  begin
     if Date1 > Date2 then
        D1.Date := FnTime.fnStrtoDate(IntToStr(StrToInt(FormatDateTime('YYYY',IncYear(Date,-1)))*10000+Date1))
     else
        D1.Date := FnTime.fnStrtoDate(IntToStr(StrToInt(FormatDateTime('YYYY',Date))*10000+Date1));
  end;

end;

procedure TfrmKpiIndexInfo.D1PropertiesChange(Sender: TObject);
var Date2:Integer;
begin
  inherited;
  if not CdsKpiOption.Active then Exit;
  if edtKPI_LV.ItemIndex = 0 then
  begin
     Date_1.BeginDate := StrToInt(FormatDateTime('MMDD',D1.Date));
     Date2 := Date_1.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 1 then
  begin
     Date_2.BeginDate := StrToInt(FormatDateTime('MMDD',D1.Date));
     Date2 := Date_2.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 2 then
  begin
     Date_3.BeginDate := StrToInt(FormatDateTime('MMDD',D1.Date));
     Date2 := Date_3.EndDate;
  end
  else if edtKPI_LV.ItemIndex = 3 then
  begin
     Date_4.BeginDate := StrToInt(FormatDateTime('MMDD',D1.Date));
     Date2 := Date_4.EndDate;
  end;
  if Date2 = 0 then
  begin
    if edtKPI_TYPE.ItemIndex = 0 then
       D2.Date := IncMonth(D1.Date,6)-1
    else if edtKPI_TYPE.ItemIndex = 1 then
       D2.Date := IncMonth(D1.Date,3)-1;
  end
  else
     D2.Date := FnTime.fnStrtoDate(IntToStr(StrToInt(FormatDateTime('YYYY',Date))*10000+Date2));
end;

procedure TfrmKpiIndexInfo.D2PropertiesChange(Sender: TObject);
begin
  inherited;
  if not CdsKpiOption.Active then Exit;
  if edtKPI_LV.ItemIndex = 0 then
     Date_1.EndDate := StrToInt(FormatDateTime('MMDD',D2.Date))
  else if edtKPI_LV.ItemIndex = 1 then
     Date_2.EndDate := StrToInt(FormatDateTime('MMDD',D2.Date))
  else if edtKPI_LV.ItemIndex = 2 then
     Date_3.EndDate := StrToInt(FormatDateTime('MMDD',D2.Date))
  else if edtKPI_LV.ItemIndex = 3 then
     Date_4.EndDate := StrToInt(FormatDateTime('MMDD',D2.Date));

end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  CdsKpiOption.Post;
  CdsKpiOption.Edit;
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  CdsKpiOption.Post;
  CdsKpiOption.Edit;
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  CdsKpiOption.Post;
  CdsKpiOption.Edit;
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  CdsKpiOption.Post;
  CdsKpiOption.Edit;
end;

procedure TfrmKpiIndexInfo.DBGridEh1Columns3EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
  CdsKpiOption.Post;
  CdsKpiOption.Edit;
end;

destructor TfrmKpiIndexInfo.Destroy;
begin
  edtKPI_LV.Properties.Items.Clear;
  inherited;
end;

end.
