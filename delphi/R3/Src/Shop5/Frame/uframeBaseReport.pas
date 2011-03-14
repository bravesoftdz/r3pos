unit uframeBaseReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ToolWin, ComCtrls, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, RzButton, DB, RzBckgnd, CheckLst,
  RzLstBox, RzChkLst, RzCmboBx, Mask, RzEdit, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  DBGridEhImpExp,inifiles, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zrComboBoxList, ZBase, cxCalendar,zrMonthEdit,cxButtonEdit,
  cxRadioGroup;


type
  TframeBaseReport = class(TframeToolForm)
    dsadoReport1: TDataSource;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    actFilter: TAction;
    actExport: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    actColumnVisible: TAction;
    ToolButton10: TToolButton;
    Panel4: TPanel;
    PrintDBGridEh1: TPrintDBGridEh;
    SaveDialog1: TSaveDialog;
    w1: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    PanelColumnS: TPanel;
    Panel2: TPanel;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    rzShowColumns: TRzCheckList;
    RzPanel1: TRzPanel;
    actPrior: TAction;
    ToolButton2: TToolButton;
    Label27: TLabel;
    actFindNext: TAction;
    adoReport1: TZQuery;
    procedure ActCloseExecute(Sender: TObject);
    procedure actColumnVisibleExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    procedure rzShowColumnsChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actExportExecute(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Excelxls1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
  private
    function RightStr(Str: string; vlen: integer): string;
    function GetCmpNum(CmpName,BegName: string): string; //���ص�ǰ�ؼ����������
    procedure Dofnd_SHOP_TYPEChange(Sender: TObject);   //�ŵ����Ⱥ��OnChange
    procedure Dofnd_TYPE_IDChange(Sender: TObject);
    procedure DoRBDate(Sender: TObject);   //
    procedure DoCxDateOnCloseUp(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    function  GetDBGridEh: TDBGridEh;virtual;
    {=======  2011.03.02 Add ˫��TDBGridEh��ʾ��ϸ����[��ѯ����ֵ] =======}
    procedure DoAssignParamsValue(SrcPnl,DestPnl: TRzPanel); //PageIndex=-1��ʾ��Sender�����ȷ��PageIndex
    {=======  2011.03.02 Add TDBGridEh =======}
    //���Grid����Column.KeyList,PickList;
    procedure AddDBGridEhColumnItems(Grid: TDBGridEh; rs: TDataSet; ColName,KeyID,ListName: string);
    //�����Ʒָ���ItemsList[SetFlag��Ӧλ����1..20λ����Ϊ1����ӣ���Ϊ0�����]
    procedure AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    //��̬������Ʒָ���ItemsList: ItemsIdx��Ӧ��Ʒ���ֶΣ�SORT_IDX1..8
    procedure AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);
    //���ͳ�Ƶ�λItems
    procedure AddTongjiUnitList(TJUnit: TcxComboBox);
    //ѡ����Ʒ���[����Ӧ��] ��������[�������]
    function SelectGoodSortType(var SortID:string; var SortRelID: string; var SortName: string):Boolean;

    {=======  2011.03.03 Add ��Ʒͳ�Ƶ�λ�����ϵ   =======}
    //����: CalcIdx: 0:Ĭ��(����)��λ; 1:������λ;  2:С��װ��λ; 3:���װ��λ;
    //����: AliasTabName: �����ı���;  AliasFileName: �����ֶα���;
    function GetUnitID(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λUNIT_ID
    function GetUnitTO_CALC(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λ�����ϵ
    //����ͳ������������ѯ���ݣ��������ϵķ����ֶΣ�
    function GetUnitIDCnd(CalcIdx: integer; AliasTabName: string): string;
    //����˵��:TitlStr�����TitleList;  Cols�������� SplitCount ����֮�������ַ�
    function  FormatReportHead(TitleList: TStringList; Cols: integer; SplitCount: integer=10): string;virtual;
    //�ж�����������[����]
    function  CheckAccDate(BegDate, EndDate: integer;ShopID: string=''):integer; //����̨�ʱ�����������
    procedure Do_REPORT_FLAGOnChange(Sender: TObject; Grid: TDBGridEh);
    procedure DBGridDrawColumn(Sender: TObject; const Rect: TRect; DataCol: Integer;
       Column: TColumnEh; State: TGridDrawState; DrawField: string);
    procedure LoadFormat;override;
    procedure PrintBefore;virtual;
    function  GetRowType:integer;virtual;
    procedure RefreshColumn;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure CreateColumn(FieldName,TitleName:string;Index:Integer;ValueType:TFooterValueType=fvtNon;vWidth:Integer=70);
    procedure ClearSortMark;
    property DBGridEh: TDBGridEh read GetDBGridEh;
  end;

implementation

uses uGlobal,uShopGlobal,uShopUtil,ufrmEhLibReport,uCtrlUtil,
  ufrmSelectGoodSort;

{$R *.dfm}

procedure TframeBaseReport.ActCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TframeBaseReport.actColumnVisibleExecute(Sender: TObject);
begin
  inherited;
  PanelColumnS.Visible := Not PanelColumnS.Visible;
  if PanelColumnS.Visible then rzShowColumns.SetFocus;
end;

procedure TframeBaseReport.actPrintExecute(Sender: TObject);
begin
  if DBGridEh = nil then Exit;
  PrintBefore;
  DBGridEh.DataSource.DataSet.Filtered := false;
  PrintDBGridEh1.DBGridEh := DBGridEh;
  PrintDBGridEh1.Print;
end;

procedure TframeBaseReport.actPreviewExecute(Sender: TObject);
begin
  if DBGridEh = nil then Exit;
  PrintBefore;
  DBGridEh.DataSource.DataSet.Filtered := false;
  PrintDBGridEh1.DBGridEh := DBGridEh;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end;
end;

procedure TframeBaseReport.PrintBefore;
begin

end;

procedure TframeBaseReport.LoadFormat;
begin
  inherited LoadFormat;
  RefreshColumn;
end;

procedure TframeBaseReport.RefreshColumn;
var i,n:Integer;
begin
  inherited;
  if DBGridEh=nil then Exit;
  rzShowColumns.Tag := 1;
  try
  rzShowColumns.Items.Clear;
  for i:=0 to DBGridEh.Columns.Count -1 do
    begin
      n := rzShowColumns.Items.AddObject(DBGridEh.Columns[i].Title.Caption,DBGridEh.Columns[i]);
      if DBGridEh.Columns[i].Visible then
         rzShowColumns.ItemState[n] := cbChecked
      else
         rzShowColumns.ItemState[n] := cbUnchecked;
      rzShowColumns.ItemEnabled[n] := (i>DBGridEh.FrozenCols-1);
    end;
  finally
    rzShowColumns.Tag := 0;
  end;
end;

procedure TframeBaseReport.CreateColumn(FieldName, TitleName: string;
  Index: Integer; ValueType: TFooterValueType; vWidth: Integer);
var
  Column:TColumnEh;
begin
  Column := DBGridEh.Columns.Add;
  Column.FieldName := FieldName;
  Column.Title.Caption := TitleName;
  Column.Width := 70;
  Column.Footer.ValueType := ValueType;
  Column.ReadOnly := true;
  if Index>=0 then Column.Index := Index;
end;

procedure TframeBaseReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and (not
    (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DrawText(Column.Grid.Canvas.Handle,pchar(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),length(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TframeBaseReport.ClearSortMark;
var i:integer;
begin
  DBGridEh.DataSource.DataSet.DisableControls;
  try
    for i:=0 to DBGridEh.Columns.Count -1 do
      DBGridEh.Columns[i].Title.SortMarker := smNoneEh;
  finally
    DBGridEh.DataSource.DataSet.EnableControls;
  end;
end;

procedure TframeBaseReport.rzShowColumnsChange(Sender: TObject;
  Index: Integer; NewState: TCheckBoxState);
begin
  inherited;
  if rzShowColumns.Tag = 1 then Exit;
  try
    TColumnEh(rzShowColumns.Items.Objects[Index]).Visible := (NewState = cbChecked);
    SaveFormat;
  except
  end;
end;

procedure TframeBaseReport.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := Column.Grid.FixedColor
  else
  case GetRowType of
  0:Background := clWhite;
  1:begin
     Background := $00D4D4D4;
     AFont.Style := [fsBold];
    end;
  2:Background := clBtnFace;
  3:begin
      Background := $00A5A5A5;
      AFont.Style := [fsBold];
    end;
  end;
end;

procedure TframeBaseReport.actExportExecute(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  SaveDialog1.DefaultExt := '*.xls';
  SaveDialog1.Files.Text := 'Excel�ļ�|*.xls';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '�Ѿ����ڣ��Ƿ񸲸�����'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      with TDBGridEhExportAsXLS.Create do
      begin
        try
          DBGridEh := self.DBGridEh;
          ExportToStream(Stream, True);
        finally
          Free;
        end;
      end;
      Stream.SaveToFile(SaveDialog1.FileName);
    finally
      Stream.Free;
    end;
  end;
end;

function TframeBaseReport.GetDBGridEh: TDBGridEh;
var i:integer;
begin
  result := nil;
  for i:=0 to ComponentCount-1 do
    begin
      if Components[i].Name = 'DBGridEh'+inttostr(rzPage.ActivePageIndex+1) then
         begin
           result := TDBGridEh(Components[i]);
           break;
         end;
    end;
end;

procedure TframeBaseReport.RzPageChange(Sender: TObject);
begin
  inherited;
  RefreshColumn;
  LoadFormat;
end;

function TframeBaseReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TframeBaseReport.actPriorExecute(Sender: TObject);
var i,MaxCount: integer;
begin
  inherited;
  MaxCount:=rzPage.ActivePageIndex;
  for i:=0 to MaxCount do
  begin
    if rzPage.ActivePageIndex=0 then Exit;
    if rzPage.Pages[MaxCount-1].TabVisible then
    begin
      rzPage.ActivePageIndex := MaxCount - 1;
      break;
    end;
  end;
end;

procedure TframeBaseReport.FormCreate(Sender: TObject);
var
  i:integer;
  CmpName,FName: string;
  Cbx: TcxComboBox;
  Column:TColumnEh;
begin
  inherited;
  //��ʼ������:
  for i:=0 to self.ComponentCount -1 do
  begin
    //��ʼ��Cbx����ѡ��Items
    if (Components[i] is TcxComboBox) then
    begin
      Cbx:=TcxComboBox(Components[i]);
      CmpName:=trim(UpperCase(Cbx.Name));
      FName:=copy(CmpName,1,4);
      if FName='FNDP' then
      begin
        if RightStr(CmpName,8)='_UNIT_ID' then    //ͳ�Ƶ�λ
          AddTongjiUnitList(Cbx)
        else if RightStr(CmpName,12)='_REPORT_FLAG' then  //ͳ������
        begin
          AddGoodSortTypeItems(Cbx,'11111100');
          Cbx.ItemIndex:=0;
        end else
        if RightStr(CmpName,10)='_SHOP_TYPE' then //����Ⱥ��
        begin
          Cbx.Properties.OnChange:=Dofnd_SHOP_TYPEChange;
          Cbx.ItemIndex:=0;
        end else
        if RightStr(CmpName,8)='_TYPE_ID' then //��Ʒָ��
        begin
          AddGoodSortTypeItems(Cbx);
          Cbx.Properties.OnChange:=Dofnd_TYPE_IDChange;
          Cbx.ItemIndex:=0;
        end;
      end;
    end;

    if (Components[i] is TcxRadioButton) then
    begin
      CmpName:=trim(UpperCase(TcxRadioButton(Components[i]).Name));
      if (Pos('WEEK',CmpName)>0) or (Pos('MONTH',CmpName)>0) or (Pos('QUARTER',CmpName)>0) or (Pos('YEAR',CmpName)>0) then
        TcxRadioButton(Components[i]).OnClick:=self.DoRBDate;
    end;

    if (Components[i] is TcxDateEdit) then
    begin
      TcxDateEdit(Components[i]).Properties.OnCloseUp:=DoCxDateOnCloseUp;
    end;

    //����Dataset;
    if Components[i] is TzrComboBoxList then
    begin
      CmpName:=trim(UpperCase(TzrComboBoxList(Components[i]).Name));
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_SHOP_ID') then 
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');    
    end;

    //������ɫ�顢���������Ƿ���ʾ
    if self.Components[i] is TDBGridEh then
    begin
      Column := FindColumn(TDBGridEh(Components[i]),'PROPERTY_01');
      if Column<>nil then Column.Visible := (CLVersion='FIG');
      Column := FindColumn(TDBGridEh(Components[i]),'PROPERTY_02');
      if Column<>nil then Column.Visible := (CLVersion='FIG');
    end;
  end;
  if Width <= 1024 then PanelColumnS.Visible := false;
  RzPageChange(nil);
end;

procedure TframeBaseReport.Excelxls1Click(Sender: TObject);
begin
  inherited;
  actExportExecute(nil);
end;

procedure TframeBaseReport.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if (Key=#13) and (DBGridEh<>nil) then
//     begin
//       if Assigned(DBGridEh.OnDblClick) then
//          DBGridEh.OnDblClick(DBGridEh);
//     end;
end;

procedure TframeBaseReport.FormResize(Sender: TObject);
begin
  inherited;
  if Width <= 800 then PanelColumnS.Visible := false;
end;

constructor TframeBaseReport.Create(AOwner: TComponent);
begin
  inherited;
  LoadFormRes(self);
end;

function TframeBaseReport.FindColumn(DBGrid: TDBGridEh;
  FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
    begin
      if DBGrid.Columns[i].FieldName = FieldName then
         begin
           result := DBGrid.Columns[i];
           Exit;
         end;
    end;
end;

procedure TframeBaseReport.actFilterExecute(Sender: TObject);
begin
  inherited;
  //
end;

function TframeBaseReport.FormatReportHead(TitleList: TStringList; Cols: integer; SplitCount: integer=10): string;
 function GetSpaceStr(vLen: integer): string;
 begin
   result:=Copy('                                                                                                      ',1,vLen);
 end;
const Srcwidth=120;   //1���ֽ�=6px��Ĭ����800���ؿ�����  120
var
  Str,CurStr,SpactStr: string;
  i,j,Idx,vLen,CurLen: integer;
begin
  result:='';
  str:='';
  CurStr:='';
  SpactStr:=Copy('                                                                                                      ',1,SplitCount);
  Idx:=0;
  for i:=0 to TitleList.Count-1 do
  begin
    CurStr:='';
    if Idx>TitleList.Count-1 then Break;
    for j:=0 to Cols-1 do
    begin
      if Idx>TitleList.Count-1 then Break;
      if j=0 then
      begin
        CurStr:=TitleList.Strings[Idx]+SpactStr;
        Inc(Idx);
      end else
      if j>0 then
      begin
        CurStr:=CurStr+TitleList.Strings[Idx]+SpactStr;
        Inc(Idx);
      end;
    end;
    if CurStr<>'' then
    begin
      if Str='' then Str:=trim(CurStr)
      else Str:=Str+#13+trim(CurStr);
    end;
  end;
  result:=Str;
end;

procedure TframeBaseReport.AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);
var
  CodeID: string;
  ItemsIdx: integer;
  Cbx: TcxComboBox;
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    Cbx:=TcxComboBox(Sender);
    CodeID:=trim(TRecord_(Cbx.Properties.Items.Objects[Cbx.ItemIndex]).fieldbyName('CODE_ID').AsString);
    ItemsIdx:=StrtoIntDef(CodeID,0);
  end;
  if ItemsIdx<=0 then Exit;
  case ItemsIdx of
   3:
    begin
      SortTypeList.KeyField:='CLIENT_ID';
      SortTypeList.ListField:='CLIENT_NAME';
      SortTypeList.FilterFields:='CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end;
   else
    begin
      SortTypeList.KeyField:='SORT_ID';
      SortTypeList.ListField:='SORT_NAME';
      SortTypeList.FilterFields:='SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  end;
  SortTypeList.Columns[0].FieldName:=SortTypeList.ListField;
  SortTypeList.Columns[1].FieldName:=SortTypeList.KeyField;
  case ItemsIdx of
   //1: fndP1_STAT_ID.DataSet:=Global.GetZQueryFromName('PUB_GOODSSORT');    //����[����][�ڹ�Ӧ����]
   2: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');    //���[�̲�:һ���̡������̡�������]
   3: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');   //����Ӧ��
   4: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');   //Ʒ��
   5: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');    //�ص�Ʒ��
   6: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');    //ʡ����
   7: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');  //��ɫ
   8: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');   //����
  end;
end;


//�����Ʒָ���ItemsList[SetFlag��Ӧλ����1..8λ����Ϊ1����ӣ���Ϊ0�����]
procedure TframeBaseReport.AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string);
 procedure AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
 var CurObj: TRecord_;
 begin
   if (not Rs.Active) or (Rs.IsEmpty) then Exit;
   Rs.First;
   while not Rs.Eof do
   begin
     if trim(Rs.FieldByName('CODE_ID').AsString)=trim(CodeID) then
     begin
       CurObj:=TRecord_.Create;
       CurObj.ReadFromDataSet(Rs);
       Cbx.Properties.Items.AddObject(CurObj.fieldbyName('CODE_NAME').AsString,CurObj);
       break;
     end;
     Rs.Next;
   end;
 end;
var
  Rs: TZQuery;
  i,InValue: integer;
begin
  try
    Rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
    {Rs.Filtered:=False;
    Rs.Filter:=' TYPE_CODE=''SORT_TYPE'' ';
    Rs.Filtered:=true;}
    ClearCbxPickList(GoodSortList);  //����ڵ㼰Object����
    for i:=1 to length(SetFlag) do
    begin
      InValue:=StrtoIntDef(SetFlag[i],0);
      if InValue=1 then
        AddItems(GoodSortList, Rs, inttostr(i));
    end;
  finally
    Rs.Filtered:=False;
    Rs.Filter:='';
  end;
end;

procedure TframeBaseReport.AddDBGridEhColumnItems(Grid: TDBGridEh; rs: TDataSet; ColName,KeyID,ListName: string);
var SetCol: TColumnEh;
begin
  if (not rs.Active) or (rs.IsEmpty) then Exit;
  SetCol:=FindColumn(Grid,trim(ColName));
  if SetCol<>nil then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName(KeyID).AsString);
      SetCol.PickList.Add(rs.FieldbyName(ListName).AsString);
      rs.Next;
    end;
  end;
end;

{===����GoodInfo��ͳ��[CalUNIT_ID][TabName������AliasFileName �ֶα���]===}
function TframeBaseReport.GetUnitID(CalcIdx: Integer; AliasTabName, AliasFileName: string): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='(case when isnull('+AliasTab+'UNIT_ID,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end) ';  //��[Ĭ�ϵ�λ]Ϊ���� ȡ [������λ]
   1: result:=' '+AliasTab+'CALC_UNITS ';   //[������λ]  ����Ϊ��
   2: result:='(case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end) ';  //С��װ��λ
   3: result:='(case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end) ';      //���װ��λ
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

{===����GoodInfo��ͳ�ƻ����ϵ[CalUNIT_ID][TabName������AliasFileName �ֶα���]===}
function TframeBaseReport.GetUnitTO_CALC(CalcIdx: Integer; AliasTabName, AliasFileName: string): string;
var
  str,AliasTab,SmallCalc,BigCalc: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  SmallCalc:='case when isnull('+AliasTab+'SMALLTO_CALC,0)=0 then 1.0 else '+AliasTab+'SMALLTO_CALC end';
  BigCalc  :='case when isnull('+AliasTab+'BIGTO_CALC,0)=0 then 1.0 else '+AliasTab+'BIGTO_CALC end';

  str:=' case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+   //Ĭ�ϵ�λΪ ������λ
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //Ĭ�ϵ�λΪ С��λ
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+   //Ĭ�ϵ�λΪ ��λ
       ' else 1.0 end ';

  case CalcIdx of
   0: result:=str;       //Ĭ�ϵ�λ
   1: result:=' 1.0 ';   //������λ
   2: result:=SmallCalc; //С��װ��λ
   3: result:=BigCalc;   //���װ��λ
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

function TframeBaseReport.GetUnitIDCnd(CalcIdx: integer;AliasTabName: string): string;
var
  AliasTab: string;
begin
  result:='';
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='((case when isnull('+AliasTab+'UNIT_ID,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end)='+AliasTab+'BARCODE_UNIT_ID) ';  //��[Ĭ�ϵ�λ]Ϊ���� ȡ [������λ]
   1: result:='('+AliasTab+'CALC_UNITS='+AliasTab+'.BARCODE_UNIT_ID) ';   //[������λ]  ����Ϊ��
   2: result:='((case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end)='+AliasTab+'BARCODE_UNIT_ID) ';  //С��װ��λ
   3: result:='((case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end)='+AliasTab+'BARCODE_UNIT_ID) ';      //���װ��λ
  end;
end;      

//���ͳ�Ƶ�λItems
procedure TframeBaseReport.AddTongjiUnitList(TJUnit: TcxComboBox);
begin
  //��˳�����[ͳ��ʱȡ����Ҳ�ǰ���˳��]
  TJUnit.Properties.Items.Clear;
  TJUnit.Properties.Items.Add('Ĭ�ϵ�λ');   
  TJUnit.Properties.Items.Add('������λ');
  TJUnit.Properties.Items.Add('��װ1');
  TJUnit.Properties.Items.Add('��װ2');
  TJUnit.ItemIndex:=0;
end;

function TframeBaseReport.SelectGoodSortType(var SortID:string; var SortRelID: string; var SortName: string):Boolean;
var
  rs:TRecord_;
begin
  result:=False;
  rs := TRecord_.Create;
  try
    if TfrmSelectGoodSort.FindDialog(self,rs) then
    begin
      SortID := rs.FieldbyName('LEVEL_ID').AsString;
      SortRelID := rs.FieldbyName('RELATION_ID').AsString;
      SortName := rs.FieldbyName('SORT_NAME').AsString;
      result:=true;
    end;
  finally
    rs.Free;
  end;
end;


function TframeBaseReport.RightStr(Str: string; vlen: integer): string;
var aLen: integer; 
begin
  aLen:=Length(Str);
  if aLen>vlen then
    result:=Copy(Str,alen-vlen+1,vlen)
  else
    result:=Str;   
end;

function TframeBaseReport.GetCmpNum(CmpName, BegName: string): string;
var i,PosIdx: integer; ReStr: string;
begin
  result:='';
  ReStr:='';
  PosIdx:=Pos(BegName,CmpName);
  if PosIdx=1 then //�ڵ�һλ��
  begin
    for i:=PosIdx+length(BegName) to 100 do
    begin
      if CmpName[i] in ['0'..'9'] then 
        ReStr:=ReStr+CmpName[i]
      else
        break;
    end;
    result:=ReStr;    
  end;
end;

procedure TframeBaseReport.Dofnd_SHOP_TYPEChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //���ؿؼ�Num
  if CmpName<>'' then
  begin
    CmpName:='fndP'+CmpName+'_SHOP_VALUE';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
    begin
      case TcxComboBox(Sender).ItemIndex of
       0: TzrComboBoxList(FindCmp).DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
       1: TzrComboBoxList(FindCmp).DataSet:=Global.GetZQueryFromName('PUB_SHOP_TYPE');
      end;
      TzrComboBoxList(FindCmp).KeyValue:=null;
      TzrComboBoxList(FindCmp).Text:='';
    end;
  end;
end;


procedure TframeBaseReport.Dofnd_TYPE_IDChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //���ؿؼ�Num
  if CmpName<>'' then
  begin
    CmpName:='fndP'+CmpName+'_STAT_ID';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
      AddGoodSortTypeItemsList(Sender,TzrComboBoxList(FindCmp));
  end;
end;

procedure TframeBaseReport.DoAssignParamsValue(SrcPnl, DestPnl: TRzPanel);
 function FindDestComponent(DestPnl: TRzPanel; DestCmpName: string): TComponent;
 var i: integer; FindCmp: TComponent;
 begin
   for i:=0 to DestPnl.ControlCount-1 do
   begin
     FindCmp:=TComponent(DestPnl.Controls[i]);
     if trim(LowerCase(FindCmp.Name))=trim(LowerCase(DestCmpName)) then
     begin
       result:=FindCmp;
       break;
     end;
   end;
 end;
 function GetDestCmpName(SrcCmpName: string): string;  //��һ���»���֮ǰ��NumnΪ�ؼ�PageNum
 var i,PosIdx: integer;FirtStr,NumStr: string; 
 begin
   result:='';
   FirtStr:='';
   NumStr:='';
   PosIdx:=Pos('_',SrcCmpName);
   for i:=1 to PosIdx-1 do
   begin
     if SrcCmpName[i] in ['0'..'9'] then
       NumStr:=NumStr+SrcCmpName[i]
     else
       FirtStr:=FirtStr+SrcCmpName[i];
   end;
   if NumStr<>'' then
   begin
     NumStr:=InttoStr(StrtoIntDef(NumStr,0)+1);
     result:=FirtStr+NumStr+Copy(SrcCmpName,PosIdx,100);
   end;
 end;
var
  DestTab:TRzTabSheet;
  i,PageIdx: integer;
  SrcCmpName,DestCmpName: string;
  SrcCmp,DestCmp: TComponent;
  ParentCmp: TWinControl;
begin
  if (not assigned(SrcPnl)) or (not assigned(DestPnl)) then Exit;
  for i:=0 to SrcPnl.ControlCount -1 do
  begin
    if (SrcPnl.Controls[i] is TLabel) or (SrcPnl.Controls[i] is TRzLabel) or (SrcPnl.Controls[i] is TRzBitBtn) then Continue;
    SrcCmp:=TComponent(SrcPnl.Controls[i]);
    SrcCmpName:=SrcCmp.Name;
    DestCmpName:=GetDestCmpName(SrcCmpName);
    DestCmp:=FindDestComponent(DestPnl,DestCmpName);
    if DestCmp=nil then Continue;
    if SrcPnl.Controls[i] is TcxDateEdit then
      TcxDateEdit(DestCmp).Date:=TcxDateEdit(SrcCmp).Date
    else if SrcPnl.Controls[i] is TcxComboBox then
      TcxComboBox(DestCmp).ItemIndex:=TcxComboBox(SrcCmp).ItemIndex
    else if SrcPnl.Controls[i] is TzrComboBoxList then
    begin
      TzrComboBoxList(DestCmp).KeyValue:=TzrComboBoxList(SrcCmp).KeyValue;
      TzrComboBoxList(DestCmp).Text:=TzrComboBoxList(SrcCmp).Text;
    end else
    if SrcPnl.Controls[i] is TcxButtonEdit then
      TcxButtonEdit(DestCmp).Text:=TcxButtonEdit(SrcCmp).Text;
  end;
  
  //���÷�ҳ��
  ParentCmp:=DestPnl.Parent;
  for i:=1 to 100 do
  begin
    if ParentCmp=nil then break;
    if (ParentCmp<>nil) and (ParentCmp is TRzTabSheet) then
    begin
      RzPage.ActivePage:=TRzTabSheet(ParentCmp);
      break;
    end else
      ParentCmp:=ParentCmp.Parent;
  end;
  self.actFind.OnExecute(nil);
end;

function TframeBaseReport.CheckAccDate(BegDate, EndDate: integer; ShopID: string): integer;
var
  str: string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    str:='select max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID ';
    if trim(ShopID)<>'' then str:=str+' and SHOP_ID=:SHOP_ID '; //�����ŵ�ID
    str:=str+' and CREA_DATE>=:CREA_DATE ';
    rs.SQL.Text :=str;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:= ShopID;
    if rs.Params.FindParam('CREA_DATE')<>nil then rs.ParamByName('CREA_DATE').AsInteger :=BegDate;
    Factor.Open(rs);
    if trim(rs.Fields[0].AsString)='' then
      result := BegDate-1
    else
      result := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

procedure TframeBaseReport.Do_REPORT_FLAGOnChange(Sender: TObject; Grid: TDBGridEh);
var
  Aobj: TRecord_;
  SetCol: TColumnEh;
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    Aobj:=TRecord_(TcxComboBox(Sender).Properties.Items.Objects[TcxComboBox(Sender).ItemIndex]);
    SetCol:=FindColumn(Grid,'SORT_ID');
    if (Aobj<>nil) and (SetCol<>nil) then
    begin
      SetCol.Title.Caption:=Aobj.fieldbyName('CODE_NAME').AsString+'����';
      case length(SetCol.Title.Caption) of
       1..8: SetCol.Width:=70;
       9..12: SetCol.Width:=90;
       13..18: SetCol.Width:=120;
       else SetCol.Width:=160;
      end; 
    end;
    SetCol:=FindColumn(Grid,'SORT_NAME');
    if (Aobj<>nil) and (SetCol<>nil) then
    begin
      SetCol.Title.Caption:=Aobj.fieldbyName('CODE_NAME').AsString+'����';
      case length(SetCol.Title.Caption) of
       1..12: SetCol.Width:=180;
       13..20: SetCol.Width:=220;
       else SetCol.Width:=240;
      end; 
    end;
  end;
end;


procedure TframeBaseReport.DBGridDrawColumn(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumnEh; State: TGridDrawState; DrawField: string);
var
  ARect:TRect;
  CurID: string;
  GridDs: TDataSet;
begin
{  GridDs:=TDBGridEh(Sender).DataSource.DataSet;
  if (not GridDs.active) or (GridDs.FindField(DrawField)=nil) then Exit;
  CurID:=trim(GridDs.FieldbyName(DrawField).AsString);
  if CurID='' then Exit;
  CurID:=copy(CurID,length(CurID),1);
  if StrtoIntDef(CurID,0) mod 2=1 then
    TDBGridEh(Sender).Canvas.Brush.Color := $00FDECDB
  else
    TDBGridEh(Sender).Canvas.Brush.Color := clWhite;
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
}
end;

procedure TframeBaseReport.DoRBDate(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
  CurRB: TcxRadioButton;
begin
  CurRB:=TcxRadioButton(Sender);
  if not CurRB.Checked then Exit;
  CmpName:=GetCmpNum(CurRB.Name,'fndP'); //���ؿؼ�Num
  if CmpName<>'' then
  begin
    CmpName:='P'+CmpName+'_D1';
    FindCmp:=FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TcxDateEdit) then
    begin
      CmpName:=LowerCase(TcxRadioButton(Sender).Name);
      if pos('week',CmpName)>0 then
        TcxDateEdit(FindCmp).Date:=Date()-7
      else if pos('month',CmpName)>0 then
        TcxDateEdit(FindCmp).Date:=Date()-30
      else if pos('quarter',CmpName)>0 then
        TcxDateEdit(FindCmp).Date:=Date()-120
      else if pos('year',CmpName)>0 then
        TcxDateEdit(FindCmp).Date:=Date()-365;
    end;
  end;
end;

procedure TframeBaseReport.DoCxDateOnCloseUp(Sender: TObject);
var
  CmpNum: string;
  FindCmp: TComponent;
begin
  CmpNum:=GetCmpNum(TcxDateEdit(Sender).Name,'P'); //���ؿؼ�Num
  if CmpNum<>'' then
  begin
    FindCmp:=FindComponent('fndP'+CmpNum+'_week');
    if (FindCmp<>nil) and (FindCmp is TcxRadioButton) and (TcxRadioButton(FindCmp).Checked) then
      TcxRadioButton(FindCmp).Checked:=False;

    FindCmp:=FindComponent('fndP'+CmpNum+'_month');
    if (FindCmp<>nil) and (FindCmp is TcxRadioButton) and (TcxRadioButton(FindCmp).Checked) then
      TcxRadioButton(FindCmp).Checked:=False;

    FindCmp:=FindComponent('fndP'+CmpNum+'_quarter');
    if (FindCmp<>nil) and (FindCmp is TcxRadioButton) and (TcxRadioButton(FindCmp).Checked) then
      TcxRadioButton(FindCmp).Checked:=False;

    FindCmp:=FindComponent('fndP'+CmpNum+'_year');
    if (FindCmp<>nil) and (FindCmp is TcxRadioButton) and (TcxRadioButton(FindCmp).Checked) then
      TcxRadioButton(FindCmp).Checked:=False;
  end;
end;

end.
