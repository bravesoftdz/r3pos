unit ufrmPriceLevelSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,RzButton,
  Grids, DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, RzLabel, DBGrids;

type
  TfrmPriceLevelSet = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsPriceLv: TDataSource;
    btnAppend: TRzBitBtn;
    btnDelete: TRzBitBtn;
    Pm: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    cdsPriceLv: TZQuery;
    RzPanel1: TRzPanel;
    lblTypeName: TLabel;
    edtLVL_TYPE: TcxComboBox;
    RzLabel23: TRzLabel;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    CtrlAdd: TAction;
    CtrlDel: TAction;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsPriceLvBeforePost(DataSet: TDataSet);
    procedure cdsPriceLvNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsPriceLvAfterEdit(DataSet: TDataSet);
    procedure CtrlUpExecute(Sender: TObject);
    procedure CtrlDownExecute(Sender: TObject);
    procedure CtrlHomeExecute(Sender: TObject);
    procedure CtrlEndExecute(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLVL_TYPEPropertiesEditValueChanged(Sender: TObject);
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure cdsPriceLvBeforeInsert(DataSet: TDataSet);
    procedure CtrlAddExecute(Sender: TObject);
    procedure CtrlDelExecute(Sender: TObject);
    procedure edtLVL_TYPEPropertiesChange(Sender: TObject);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetdbState(const Value: TDataSetState);
    function CheckCanExport:boolean;
    function GetLVL_TYPE: integer;
    procedure SetUpdateState();
    procedure SetBrowseState();
  public
    //��ǰ�����޸�״̬
    formEditStatus:boolean;
    OutPrice:Real;
    CarryRule,Deci:integer;
    //���ۼ�¼(����)
    PriceObj: TRecord_;
    procedure Open;
    function  Save: boolean;
    class function AddDialog(Owner:TForm; var AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm; AObj:TRecord_):boolean;
    property LVL_TYPE: integer read GetLVL_TYPE; //��λ���� 1����� 2������
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math,TypInfo;
{$R *.dfm}

procedure TfrmPriceLevelSet.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  c:integer;
  sCurrStr,sNo:string;
  mCurrStu:TDataSetState;
  tmp: TZQuery;
begin
  inherited;
  SetUpdateState;
  if StrtoFloatDef(Text,0)<=0 then
  begin
    //if dbstate=dsBrowse then dbstate:=dsEdit;
    cdsPriceLv.FieldByName('LV_AMT').AsString:='';
    Raise Exception.Create('    ��Ʒ�۸�λ��'+InttoStr(cdsPriceLv.RecNo)+'���Ĵ��������С��0�����0��  ');
  end;
  //ShowMessage('Text='+Text+',lv_amt='+cdsPriceLv.FieldByName('LV_AMT').AsString);
  mCurrStu :=   cdsPriceLv.State;
  sNo := cdsPriceLv.FieldbyName('SEQ_NO').AsString;
  sCurrStr := Text; ;

  //showmessage('state = '+GetEnumName(TypeInfo(TDataSetState),Ord(cdsPriceLv.State)));
  //cdsPriceLv.DisableControls;
  try
    tmp:=TZQuery.Create(nil);
    tmp.Data:=cdsPriceLv.Data;
    c := 0;
    tmp.First;
    while not tmp.Eof do
      begin
        if
           (tmp.FieldbyName('LV_AMT').AsString = sCurrStr)
           //and
           //(cdsPriceLv.FieldbyName('SEQNO').AsString <> sNo)
        then
           begin
             c:=c+1;
             break;
           end;
        tmp.Next;
      end;
    cdsPriceLv.Edit;
    if c>0 then
      begin

        Text := '';
        //MessageBox(self.handle,Pchar('��Ʒ��λ"'+sCurrStr+'"�Ѿ�����,����������..'),Pchar(Caption),MB_OK);
        //PostMessage(self.Handle,WM_Locate_msg,cdsPriceLv.RecNo,DBGridEh1.SelectedIndex);
        Raise Exception.Create('��Ʒ��λ"'+sCurrStr+'"�Ѿ�����.');

      end;
  finally
    tmp.Free;
  end;
end;

procedure TfrmPriceLevelSet.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  SetUpdateState;
  if StrtoFloatDef(Text,0)<=0 then
  begin
    //if dbstate=dsBrowse then dbstate:=dsEdit;
    cdsPriceLv.FieldByName('AGIO_RATE').AsString:='';
    Raise Exception.Create('   ��Ʒ�۸�λ��'+InttoStr(cdsPriceLv.RecNo)+'�����ۿ��ʲ���С��0�����0��  ');
  end;
  cdsPriceLv.Edit;
  //cdsPriceLv.FieldByName('LV_PRC').AsFloat := RoundTo(StrtoFloatDef(Text,0)*OutPrice,0);
  cdsPriceLv.FieldByName('LV_PRC').AsFloat :=FnNumber.ConvertToFight(StrtoFloatDef(Text,0)*OutPrice/100,CarryRule,deci);

end;

procedure TfrmPriceLevelSet.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  SetUpdateState;
  if StrtoFloatDef(Text,0)<=0 then
  begin
    //if dbstate=dsBrowse then dbstate:=dsEdit;
    cdsPriceLv.FieldByName('LV_PRC').AsString:='';
    Raise Exception.Create('   ��Ʒ�۸�λ��'+InttoStr(cdsPriceLv.RecNo)+'�����Żݼ۲���С��0�����0��  ');
  end;
  cdsPriceLv.Edit;
  //cdsPriceLv.FieldByName('AGIO_RATE').AsFloat := RoundTo(StrtoFloatDef(Text,0)*10/OutPrice,-2);
  cdsPriceLv.FieldByName('AGIO_RATE').AsFloat :=FnNumber.ConvertToFight(StrtoFloatDef(Text,0)/OutPrice*100,CarryRule,deci);

end;

procedure TfrmPriceLevelSet.btnAppendClick(Sender: TObject);
begin
  inherited;
  if cdsPriceLv.State in [dsEdit,dsInsert] then cdsPriceLv.Post;
  if not cdsPriceLv.IsEmpty then
  begin
    cdsPriceLv.Last;
    if (cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0) and (cdsPriceLv.FieldByName('LV_PRC').AsFloat<=0) then
      exit;
    //FLAG: RowCount���������У�һ��ʹ��: cdsPriceLv.RecordCount
    if (cdsPriceLv.RecordCount >=9) then
    begin
      MessageBox(Handle,pchar('���ֻ������9����λ.'),'������ʾ...',MB_OK);
      exit;
    end;
  end;
  //�жϵ���¼�����
  cdsPriceLv.DisableControls;
  try
    cdsPriceLv.First;
    while not cdsPriceLv.Eof do
    begin
      //FLAG:�ĳ�:cdsPriceLv.FieldByName('LV_AMT').AsFloat
      if cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0 then
      begin
        if LVL_TYPE=1 then
          raise Exception.Create('��λ'+IntToStr(cdsPriceLv.RecNo)+'������С�ڻ����0��')
        else
          raise Exception.Create('��λ'+IntToStr(cdsPriceLv.RecNo)+'�����������С�ڻ����0��')
      end;
      if cdsPriceLv.FieldByName('LV_PRC').AsString='' then
        raise Exception.Create('��λ�Żݼ۲��ܣ�');
      cdsPriceLv.Next;
    end;
  finally
    cdsPriceLv.EnableControls;
  end;
  cdsPriceLv.Append;

  DBGridEh1.SetFocus;
  DBGridEh1.Col:=1;
  DBGridEh1.EditorMode := true;
  //if dbstate=dsBrowse then dbstate:=dsEdit;
  SetUpdateState;
end;

procedure TfrmPriceLevelSet.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('ȷ��Ҫɾ����λ"'+InttoStr(cdsPriceLv.RecNo)+'" ?'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  //FLAG: ��һ��λ��
  if cdsPriceLv.State in [dsEdit,dsInsert] then cdsPriceLv.Post;
  cdsPriceLv.Delete;

  //ɾ������������
  cdsPriceLv.DisableControls;
  try
    cdsPriceLv.First;
    while not cdsPriceLv.Eof do
    begin
      cdsPriceLv.Edit;
      cdsPriceLv.FieldByName('SEQ_NO').AsInteger:=cdsPriceLv.RecNo;
      cdsPriceLv.Post;
      cdsPriceLv.Next;
    end;
  finally
    cdsPriceLv.EnableControls;
  end;
  btnSave.Enabled:=True;
  //���ɾ����û�м�¼��ɾ����ť���ܲ���
  if cdsPriceLv.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmPriceLevelSet.btnSaveClick(Sender: TObject);
begin
  inherited;

  if cdsPriceLv.State in [dsInsert,dsEdit] then cdsPriceLv.Post;
  if (cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0) and (cdsPriceLv.FieldByName('LV_PRC').AsFloat<=0) then
  begin
    if not cdsPriceLv.IsEmpty then
      cdsPriceLv.Delete;
  end;
  cdsPriceLv.DisableControls;
  try
    cdsPriceLv.First;
    while not cdsPriceLv.Eof do
    begin
      if cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0 then
      begin
        if LVL_TYPE=1 then
          raise Exception.Create('��λ'+IntToStr(cdsPriceLv.RecNo)+'������С�ڻ����0��')
        else
          raise Exception.Create('��λ'+IntToStr(cdsPriceLv.RecNo)+'�����������С�ڻ����0��');
      end;
      if cdsPriceLv.FieldByName('LV_PRC').AsFloat<=0 then
        raise Exception.Create('��λ'+IntToStr(cdsPriceLv.RecNo)+'�Żݼ۲���С�ڻ����0��');
      cdsPriceLv.Next;
    end;
  finally
    cdsPriceLv.EnableControls;
  end;
  Save;
  ModalResult:=mrOk;
end;

procedure TfrmPriceLevelSet.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmPriceLevelSet.Open;
var
  iNum:integer;
  iCurrNum:integer;
  sLVL_TYPE:string;
begin
  //����Ҫ�������ݣ��������ݼ�
  cdsPriceLv.Close;
  cdsPriceLv.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
  cdsPriceLv.FieldDefs.Add('LV_AMT',ftFloat,0,true);
  cdsPriceLv.FieldDefs.Add('AGIO_RATE',ftFloat,0,true);
  cdsPriceLv.FieldDefs.Add('LV_PRC',ftFloat,0,true);
  cdsPriceLv.CreateDataSet;
  //��PriceObj�����ת�ɼ�¼��
  iCurrNum :=1;
  iNum :=1;
  OutPrice :=PriceObj.FieldByName('OUT_PRICE').AsFloat;
  While iNum <=9 do
  begin
    if (PriceObj.FieldByName('LV'+inttostr(iNum)+'_AMT').AsFloat>0) and (PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsFloat >0)    then
    begin
      cdsPriceLv.Append;
      cdsPriceLv.FieldByName('SEQ_NO').AsInteger := iCurrNum;
      cdsPriceLv.FieldByName('LV_AMT').AsFloat := PriceObj.FieldByName('LV'+inttostr(iNum)+'_AMT').AsFloat;
      cdsPriceLv.FieldByName('LV_PRC').AsFloat := PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsFloat;
      //cdsPriceLv.FieldByName('AGIO_RATE').AsFloat := RoundTo(PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsFloat*10/PriceObj.FieldByName('OUT_PRICE').AsFloat,-2);
      cdsPriceLv.FieldByName('AGIO_RATE').AsFloat := FnNumber.ConvertToFight(PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsFloat*100/PriceObj.FieldByName('OUT_PRICE').AsFloat,CarryRule,deci);
      cdsPriceLv.Post;
      iCurrNum := iCurrNum+1;
    end;
    iNum := iNum+1;
  end;


  sLVL_TYPE := PriceObj.FieldByName('LVL_TYPE').AsString;
  if sLVL_TYPE ='' then
  begin
    SetUpdateState;
    sLVL_TYPE :='1';
    edtLVL_TYPE.ItemIndex := 0;
    exit;
  end;

  case sLVL_TYPE[1]  of
    '1':  edtLVL_TYPE.ItemIndex := 0;
    '2':  edtLVL_TYPE.ItemIndex := 1;
    '3':  edtLVL_TYPE.ItemIndex := 2;
  else
    edtLVL_TYPE.ItemIndex := 0;
  end;

  if formEditStatus then  SetUpdateState
  else
  begin
  SetBrowseState;
  DBGridEh1.ReadOnly:=true;
  end;
  //dbstate:=dsBrowse;

end;

function TfrmPriceLevelSet.Save:Boolean;
var iNum:integer;
Temp:TZQuery;
begin
  result:=false;
  //cdsPriceLv.SortType:=stAscending;
  cdsPriceLv.IndexFieldNames := 'LV_AMT ASC';
  //��ǰ���ݼ�ת������PriceObj
  cdsPriceLv.First;
  iNum := 1;
  while (not cdsPriceLv.Eof) and (iNum <=9) do
  begin
      PriceObj.FieldByName('LV'+inttostr(iNum)+'_AMT').AsFloat:=cdsPriceLv.FieldByName('LV_AMT').AsFloat;
      PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsFloat :=  cdsPriceLv.FieldByName('LV_PRC').AsFloat;
      cdsPriceLv.Next;
      iNum := iNum+1;
  end;
  while iNum <=9 do
  begin
    PriceObj.FieldByName('LV'+inttostr(iNum)+'_AMT').AsString :='0';
    PriceObj.FieldByName('LV'+inttostr(iNum)+'_PRC').AsString :='0';
    iNum := iNum+1;
  end;
  PriceObj.FieldByName('LVL_TYPE').AsString := inttostr(edtLVL_TYPE.ItemIndex+1);
  dbstate:=dsBrowse;
  //SetBrowseState;
  result:=true;

end;

procedure TfrmPriceLevelSet.cdsPriceLvBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and (cdsPriceLv.FieldByName('LV_AMT').AsString='') then
  begin
    exit;
  end;
end;

procedure TfrmPriceLevelSet.cdsPriceLvNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsPriceLv.FieldByName('SEQ_NO').AsString:=IntToStr(cdsPriceLv.RecordCount+1);
end;

procedure TfrmPriceLevelSet.FormShow(Sender: TObject);
begin
  inherited;
  Open; //������
  btnSave.Enabled:=False;
  DBGridEh1.SetFocus;
end;

procedure TfrmPriceLevelSet.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmPriceLevelSet.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin
  inherited;
  if dbstate=dsEdit then
  begin
    i:=MessageBox(Handle,Pchar('��Ʒ���������������޸�,�Ƿ�Ҫ������?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;
end;

procedure TfrmPriceLevelSet.cdsPriceLvAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmPriceLevelSet.AddDialog(Owner: TForm; var AObj: TRecord_): boolean;
begin
  result:=False;
  with TfrmPriceLevelSet.Create(Owner) do
  begin
    try
      //����OBJ��¼
      PriceObj:=AObj;
      formEditStatus :=true;
  //    SetUpdateState;
      ShowModal;
      result:=(ModalResult=mrOk);
    finally
      free;
    end;
  end;
end;

//��������
procedure TfrmPriceLevelSet.CtrlUpExecute(Sender: TObject);
var
  CurNo,UpNo: integer;
begin
  inherited;
  if cdsPriceLv.IsEmpty then exit;
  if cdsPriceLv.RecordCount=1 then exit;
  if cdsPriceLv.RecNo=1 then exit;
  if cdsPriceLv.State in [dsEdit,dsInsert] then cdsPriceLv.Post;
  if cdsPriceLv.RecNo=cdsPriceLv.RecordCount then
  begin
    if (cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0) and (cdsPriceLv.FieldByName('LV_PRC').AsFloat<=0) then
    begin
      cdsPriceLv.Delete;
      exit;
    end;
  end;
  //��һ��:��ȡ��¼��SEQ_NO
  CurNo:=cdsPriceLv.FieldByName('SEQ_NO').AsInteger;  //��ǰ��¼��SEQ_NO
  cdsPriceLv.Prior;  //��ǰ��һ����¼
  UpNo:=cdsPriceLv.FieldByName('SEQ_NO').AsInteger;  //��ǰ�Ƽ�¼��SEQ_NO
  //�ڶ����������滻
  cdsPriceLv.Edit;
  cdsPriceLv.FieldByName('SEQ_NO').AsInteger:=-1;
  cdsPriceLv.Post;
  if cdsPriceLv.Locate('SEQ_NO',CurNo,[]) then
  begin
    cdsPriceLv.Edit;
    cdsPriceLv.FieldByName('SEQ_NO').AsInteger:=UpNo;
    cdsPriceLv.Post;
  end;
  if cdsPriceLv.Locate('SEQ_NO',-1,[]) then
  begin
    cdsPriceLv.Edit;
    cdsPriceLv.FieldByName('SEQ_NO').AsInteger:=CurNo;
    cdsPriceLv.Post;
  end;
  //�����������������ֶ�
  cdsPriceLv.indexfieldnames:='SEQ_NO';
end;

//��������
procedure TfrmPriceLevelSet.CtrlDownExecute(Sender: TObject);
var
  iItem,iItem1:TRecord_;
begin
  inherited;
  if cdsPriceLv.IsEmpty then exit;
  if cdsPriceLv.RecordCount=1 then exit;
  if cdsPriceLv.RecNo=cdsPriceLv.RecordCount then exit;
  if cdsPriceLv.State in [dsEdit,dsInsert] then cdsPriceLv.Post;
  if cdsPriceLv.RecNo=cdsPriceLv.RecordCount then
  begin
    if (cdsPriceLv.FieldByName('LV_AMT').AsFloat<=0) and (cdsPriceLv.FieldByName('LV_PRC').AsFloat<=0) then
    begin
      cdsPriceLv.Delete;
      exit;
    end;
  end;

  iItem:= TRecord_.Create;
  iItem1:= TRecord_.Create;
  try
    //��һ������ȡ��ǰ����һ����¼��OBj��¼����
    iItem.ReadFromDataSet(cdsPriceLv);
    cdsPriceLv.Next;
    iItem1.ReadFromDataSet(cdsPriceLv);
    //�ڶ���������ǰ����¼д����һ����¼
    cdsPriceLv.Edit;
    cdsPriceLv.FieldByName('LV_AMT').AsFloat:=iItem.FieldByName('LV_AMT').AsFloat;
    cdsPriceLv.FieldByName('AGIO_RATE').AsFloat:=iItem.FieldByName('AGIO_RATE').AsFloat;
    cdsPriceLv.FieldByName('LV_PRC').AsFloat:=iItem.FieldByName('LV_PRC').AsFloat;
    cdsPriceLv.Post;
    //������������һ��д��ԭ��ǰ��
    if cdsPriceLv.Locate('SEQ_NO',iItem.FieldByName('SEQ_NO').AsInteger,[]) then
    begin
      cdsPriceLv.Edit;
      cdsPriceLv.FieldByName('LV_AMT').AsFloat:=iItem1.FieldByName('LV_AMT').AsFloat;
      cdsPriceLv.FieldByName('AGIO_RATE').AsFloat:=iItem1.FieldByName('AGIO_RATE').AsFloat;
      cdsPriceLv.FieldByName('LV_PRC').AsFloat:=iItem.FieldByName('LV_PRC').AsFloat;
      cdsPriceLv.Post;
    end;
  finally
    iItem.Free;
    iItem1.Free;
  end;
end;

procedure TfrmPriceLevelSet.CtrlHomeExecute(Sender: TObject);
begin
  //�Ƶ���һ��
  while cdsPriceLv.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmPriceLevelSet.CtrlEndExecute(Sender: TObject);
begin
  //�Ƶ����һ��
  while cdsPriceLv.RecNo<cdsPriceLv.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmPriceLevelSet.DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlUpExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlDownExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlHomeExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlEndExecute(nil);
  end;
end;

class function TfrmPriceLevelSet.ShowDialog(Owner: TForm; AObj:TRecord_): boolean;
begin
  with TfrmPriceLevelSet.Create(Owner) do
  begin
    try
      //����OBJ��¼
      PriceObj:=AObj;
      formEditStatus :=false;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmPriceLevelSet.SetdbState(const Value: TDataSetState);
begin
   inherited;
end;

function TfrmPriceLevelSet.CheckCanExport: boolean;
begin
  //Ĭ�ϲ���Ȩ��
  result:=true;
end;

function TfrmPriceLevelSet.GetLVL_TYPE: integer;
begin
  result:=edtLVL_TYPE.ItemIndex+1;
end;

procedure TfrmPriceLevelSet.SetUpdateState;
begin
  if dbstate=dsBrowse then
  begin
    dbstate:=dsEdit;
    btnSave.Enabled:=True;
  end;
end;

procedure TfrmPriceLevelSet.SetBrowseState;
begin
  dbstate:=dsBrowse;
  btnSave.Enabled:=False;
end;

procedure TfrmPriceLevelSet.edtLVL_TYPEPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  SetUpdateState;
end;

procedure TfrmPriceLevelSet.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer; Column: TColumnEh);
var
  sortstring:string; //������
begin
  //��������
  with Column do
  begin
    if FieldName = '' then
      Exit;
    case Title.SortMarker of
      smNoneEh:
      begin
        Title.SortMarker := smDownEh;
        sortstring := Column.FieldName + ' ASC';
      end;
      smDownEh: sortstring := Column.FieldName + ' ASC';
      smUpEh: sortstring := Column.FieldName + ' DESC';
    end;
    //��������
    try
      cdsPriceLv.IndexFieldNames := sortstring;
    except
    end;
  end;
end;

procedure TfrmPriceLevelSet.cdsPriceLvBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if cdsPriceLv.RecordCount >9 then
    raise Exception.Create('��Ʒ�����۶��岻�ܳ���9��..');
end;

procedure TfrmPriceLevelSet.CtrlAddExecute(Sender: TObject);
begin
  inherited;
   btnAppendClick(Sender);
end;

procedure TfrmPriceLevelSet.CtrlDelExecute(Sender: TObject);
begin
  inherited;
  btnDeleteClick(Sender);
end;

procedure TfrmPriceLevelSet.edtLVL_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  // 0 �����
  {if edtLVL_TYPE.ItemIndex=0 then
     DBGridEh1.Columns[1].Title.caption :='���۽��'
  else
     DBGridEh1.Columns[1].Title.caption :='��������';   }
  case edtLVL_TYPE.ItemIndex  of
    0:  DBGridEh1.Columns[1].Title.caption :='��Ʒ���';
    1:  DBGridEh1.Columns[1].Title.caption :='��Ʒ����';
    2:  DBGridEh1.Columns[1].Title.caption :='�������';
  else
    DBGridEh1.Columns[1].Title.caption :='��Ʒ���';
  end;

end;



procedure TfrmPriceLevelSet.FormCreate(Sender: TObject);
begin
  inherited;
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
  //��λ����
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
end;

end.
