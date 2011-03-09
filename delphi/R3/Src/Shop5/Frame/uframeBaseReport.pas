unit uframeBaseReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ToolWin, ComCtrls, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, RzButton, DB, RzBckgnd, CheckLst,
  RzLstBox, RzChkLst, RzCmboBx, Mask, RzEdit, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  DBGridEhImpExp,inifiles, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zrComboBoxList, ZBase, cxCalendar,zrMonthEdit;


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
    procedure AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
  public
    constructor Create(AOwner: TComponent); override;
    function GetDBGridEh: TDBGridEh;virtual;
    {=======  2011.03.02 Add TDBGridEh\TzrComboBoxList���ѡ��Ŀ  =======}
    //���Grid����Column.KeyList,PickList;
    procedure AddDBGridEhColumnItems(Grid: TDBGridEh; rs: TDataSet; ColName,KeyID,ListName: string);

    //�����Ʒָ���ItemsList[SetFlag��Ӧλ����1..8λ����Ϊ1����ӣ���Ϊ0�����]
    procedure AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111111');
    //��̬������Ʒָ���ItemsList: ItemsIdx��Ӧ��Ʒ���ֶΣ�SORT_IDX1..8
    procedure AddGoodSortTypeItemsList(SortTypeList: TzrComboBoxList; ItemsIdx: integer);overload;
    procedure AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);overload;

    //����ŵ����Ⱥ���ItemsList[SetFlag��Ӧλ����(REGION_ID��SHOP_ID)1..2λ����Ϊ1����ӣ���Ϊ0�����]
    procedure AddShopGroupItems(ShopGroupID: TcxComboBox; SetFlag: string='11');
    //��̬�����ŵ����Ⱥ���ItemsList: ItemsIdx��Ӧ�ŵ���ֶΣ��ŵ꣺REGION_ID��SHOP_TYPE
    procedure AddShopGroupItemsList(ShopGroupList: TzrComboBoxList; ItemsIdx: integer);overload;
    procedure AddShopGroupItemsList(Sender: TObject; ShopGroupList: TzrComboBoxList);overload;

    //���ͳ�Ƶ�λItems
    procedure AddTongjiUnitList(TJUnit: TcxComboBox);

    //ѡ����Ʒ���[����Ӧ��] ��������[�������]
    function SelectGoodSortType(var SortID,SortRelID: string): string;

    {=======  2011.03.03 Add ��Ʒͳ�Ƶ�λ�����ϵ   =======}
    //����: CalcIdx: 0:Ĭ��(����)��λ; 1:������λ;  2:С��װ��λ; 3:���װ��λ;
    //����: AliasTabName: �����ı���;  AliasFileName: �����ֶα���;
    function GetUnitID(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λUNIT_ID
    function GetUnitTO_CALC(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λ�����ϵ

    {=======  2011.03.05 Add ���ɲ�ѯ����  =======}
    //�������ڲ�ѯ��������˵��:
    // (1)��JoinOper:��ѯ���������߼�[and|or|��]; (2)��FieldName:�ֶ���;    (3)����ѯ�ֶαȽϹ�ϵ��: RelChar[>��=��<��>=��<=];
    // (4)��CxDate:��ѯ����ֵ��ʱ��ؼ�;          (5)��ʱ���ʽ:FormatStr;  (6)���ֶ�����[1: �����͡�2: �ַ��͡�3: ������:��Ϊ��ϲ�ѯ�����ο�]
    function GetCxDate(JoinOper,FieldName,RelChar:String; CxDate: TDate; FormatStr: string='YYYYMMDD'; FieldType: integer=1):string;overload;
    function GetCxDate(JoinOper,FieldName,RelChar:String; CxDate: TcxDateEdit; FormatStr: string='YYYYMMDD'; FieldType: integer=1):string;overload;
    function GetCxDate(JoinOper,FieldName:String; InBegDate, InEndDate: TcxDateEdit; FormatStr: string='YYYYMMDD'; IsTime: Boolean=False;FieldType: integer=1):string;overload;
    function GetCxDate(JoinOper,FieldName:String; InBegMonth, InEndMonth: TzrMonthEdit; FieldType: integer=1):string;overload;
    //����ͳ������������ѯ���ݣ��������ϵķ����ֶΣ�
    function GetUnitIDCnd(CalcIdx: integer; AliasTabName: string): string;
    //���ص���Ʒָ��Ĳ�ѯ�Ĳ�ѯ����:
    function  GetGoodSortTypeCnd(GoodSortItems: TcxComboBox; SortTypeValue: string; AliasTabName: string; JoinOper: string=''): string;
    //�����ŵ����Ⱥ��: [��������|�ŵ�����]
    function  GetShopGroupCnd(ShopGroup: TcxComboBox; GroupValue: string; AliasTabName: string; JoinOper: string=''): string;
    //����������ֶ���������ֵ�����ֵ�Ŀؼ����ز�ѯ����
    function  GetQueryCnd(FileName,ParamsValue: string; JoinOper: string=''): string; overload; //�����ѯ�ֶ�[��������]������ֵ����ѯ���������ַ�
    function  GetQueryCnd(Cbx:TzrComboBoxList;FileName: string; JoinOper: string=''): string; overload; //�����ѯ�ֶ�[��������]������ֵ����ѯ���������ַ�

    //����˵��:TitlStr�����TitleList;  Cols�������� SplitCount ����֮�������ַ�
    function  FormatTitel(TitlStr: TStringList; Cols: integer; SplitCount: integer=10): string;virtual;

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
begin
  inherited;
  if (rzPage.ActivePageIndex > 0) and (rzPage.Pages[rzPage.ActivePageIndex-1].Visible) then rzPage.ActivePageIndex := rzPage.ActivePageIndex - 1;
end;

procedure TframeBaseReport.FormCreate(Sender: TObject);
var i:integer;
  Column:TColumnEh;
begin
  inherited;
  //������ɫ�顢���������Ƿ���ʾ
  for i:=0 to self.ComponentCount -1 do
  begin
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

function TframeBaseReport.FormatTitel(TitlStr: TStringList; Cols: integer; SplitCount: integer=10): string;
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
  for i:=0 to TitlStr.Count-1 do
  begin
    CurStr:='';
    if Idx>TitlStr.Count-1 then Break;
    for j:=0 to Cols-1 do
    begin
      if Idx>TitlStr.Count-1 then Break;
      if j=0 then
      begin
        CurStr:=TitlStr.Strings[Idx]+SpactStr;
        Inc(Idx);
      end else
      if j>0 then
      begin
        CurStr:=CurStr+TitlStr.Strings[Idx]+SpactStr;
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

procedure TframeBaseReport.AddGoodSortTypeItemsList(SortTypeList: TzrComboBoxList; ItemsIdx: integer);
begin
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

procedure TframeBaseReport.AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);
var
  ID: string;
begin
  SortTypeList.KeyValue := null;
  SortTypeList.Text := '';
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    ID:=TRecord_(TcxComboBox(Sender).Properties.Items.Objects[TcxComboBox(Sender).ItemIndex]).fieldbyName('CODE_ID').AsString;
    if ID<>'' then
      self.AddGoodSortTypeItemsList(SortTypeList,StrToInt(ID));
  end;
end;


//�����Ʒָ���ItemsList[SetFlag��Ӧλ����1..8λ����Ϊ1����ӣ���Ϊ0�����]
procedure TframeBaseReport.AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111111');
var
  Rs: TZQuery;
  i,InValue: integer;
begin
  try
    Rs:=Global.GetZQueryFromName('PUB_PARAMS');
    Rs.Filtered:=False;
    Rs.Filter:=' TYPE_CODE=''SORT_TYPE'' ';
    Rs.Filtered:=true;
    GoodSortList.Properties.Items.Clear;
    for i:=1 to 8 do
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

//��Ʒָ��[SQL�Ĳ�ѯ����]
function TframeBaseReport.GetGoodSortTypeCnd(GoodSortItems: TcxComboBox; SortTypeValue: string; AliasTabName: string; JoinOper: string=''): string;
var
  SortIdx: integer;
  AliasName: string;
begin
  result:='';
  AliasName:='';
  if AliasTabName<>'' then AliasName:=AliasTabName+'.';
  if GoodSortItems.ItemIndex<>-1 then
  begin
    SortIdx:=StrtoInt(TRecord_(GoodSortItems.Properties.Items.Objects[GoodSortItems.ItemIndex]).fieldbyName('CODE_ID').asString);
    result:=JoinOper+'('+AliasName+'SORT_ID'+InttoStr(SortIdx)+'='+QuotedStr(SortTypeValue)+')';
   {Cnd:=' SORT_ID'+InttoStr(SortIdx)+'='+QuotedStr(SortTypeValue)+'';
    Cnd:='select GODS_ID from PUB_GOODSINFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and PUB_GOODSINFO.GODS_ID='+AliasTabName+'GODS_ID and '+Cnd;
    Cnd:=JoinOper+' exists('+Cnd+')';
    result:=Cnd;
   }
  end;
end;

//�����ŵ����Ⱥ��: [��������|�ŵ�����]
function TframeBaseReport.GetShopGroupCnd(ShopGroup: TcxComboBox; GroupValue, AliasTabName, JoinOper: string): string;
var
  SortID, Cnd,AliasName: string;
begin
  result:='';
  AliasName:='';
  if AliasTabName<>'' then AliasName:=AliasTabName+'.';
  if ShopGroup.ItemIndex<>-1 then
  begin
    SortID:=trim(TRecord_(ShopGroup.Properties.Items.Objects[ShopGroup.ItemIndex]).fieldbyName('CODE_ID').asString);
    if SortID='8' then
      SortID:='REGION_ID'
    else if SortID='12' then
      SortID:='SHOP_TYPE';
    Cnd:=AliasName+'.'+SortID+'='+QuotedStr(GroupValue);
    result:=JoinOper+'('+Cnd+')';

   {
    Cnd:='select SHOP_ID from CA_SHOP_INFO where '+AliasTabName+'TENANT_ID=CA_SHOP_INFO.TENANT_ID and '+AliasTabName+'SHOP_ID=CA_SHOP_INFO.SHOP_ID and '+Cnd;
    result:=JoinOper+' exists('+Cnd+')';
   }
  end;
end;


//����ŵ����Ⱥ���ItemsList[SetFlag��Ӧλ����1..2λ����Ϊ1����ӣ���Ϊ0�����]
procedure TframeBaseReport.AddShopGroupItems(ShopGroupID: TcxComboBox; SetFlag: string);
var
  Rs: TZQuery;
  InValue: integer;
  RegID,GroupID: string;
begin
  try
    InValue:=StrtoIntDef(SetFlag,0);
    Rs:=Global.GetZQueryFromName('PUB_PARAMS');
    Rs.Filtered:=False;
    Rs.Filter:=' TYPE_CODE=''CODE_TYPE'' ';
    Rs.Filtered:=true;
    if not Rs.Active then Exit;
    ShopGroupID.Properties.Items.Clear;
    if Copy(SetFlag,1,1)='1' then RegID:='8';    //�ŵ���������
    if Copy(SetFlag,2,1)='1' then GroupID:='12'; //�ŵ����Ⱥ��
    //������������:
    self.AddItems(ShopGroupID,Rs,RegID);
    //���ع���Ⱥ��:
    self.AddItems(ShopGroupID,Rs,GroupID);
  finally
    Rs.Filtered:=False;
    Rs.Filter:='';  
  end;
end;

procedure TframeBaseReport.AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
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

//��̬�����ŵ����Ⱥ���ItemsList: ItemsIdx��Ӧ�ŵ���ֶΣ��ŵ꣺REGION_ID��SHOP_TYPE
procedure TframeBaseReport.AddShopGroupItemsList(ShopGroupList: TzrComboBoxList; ItemsIdx: integer);
begin
  case ItemsIdx of
   8:
    begin
      ShopGroupList.KeyField:='CODE_ID';
      ShopGroupList.ListField:='CODE_NAME';
      ShopGroupList.Filter:='CODE_ID;CODE_NAME;CODE_SPELL';
      ShopGroupList.Columns[0].FieldName:=ShopGroupList.ListField;
      ShopGroupList.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');  //��������
    end;
   12:
    begin
      ShopGroupList.KeyField:='SORT_ID';
      ShopGroupList.ListField:='SORT_NAME';
      ShopGroupList.Filter:='SORT_ID;SORT_NAME;SORT_SPELL';
      ShopGroupList.Columns[0].FieldName:=ShopGroupList.ListField;
      ShopGroupList.DataSet:=Global.GetZQueryFromName('PUB_SHOP_TYPE');  //�ŵ�����
    end;
  end;
end;

procedure TframeBaseReport.AddShopGroupItemsList(Sender: TObject; ShopGroupList: TzrComboBoxList);
var
  ID: string;
begin
  ShopGroupList.KeyValue := null;
  ShopGroupList.Text := '';
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    ID:=TRecord_(TcxComboBox(Sender).Properties.Items.Objects[TcxComboBox(Sender).ItemIndex]).fieldbyName('CODE_ID').AsString;
    if ID<>'' then
      self.AddShopGroupItemsList(ShopGroupList,StrToInt(ID));
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
    result:=result+' as '+AliasFileName+' '
  else
    result:=result+' as UNIT_ID '
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

function TframeBaseReport.GetCxDate(JoinOper, FieldName, RelChar: String;
  CxDate: TDate;FormatStr: string; FieldType: integer): string;
var
  Cnd,CurDate: string;
begin
  result:='';
  if trim(RelChar)='' then Exit;
  CurDate:=Formatdatetime(FormatStr,CxDate);
  if CurDate='' then Exit;
  case FieldType of
   1: Cnd:='('+FieldName+RelChar+CurDate+')';
   2: Cnd:='('+FieldName+RelChar+''''+CurDate+''')';
   3: Cnd:='('+FieldName+RelChar+''''+CurDate+''')';
  end;
  if trim(JoinOper)<>'' then
    Cnd:=JoinOper+' '+Cnd;
  result:=Cnd;
end;

function TframeBaseReport.GetCxDate(JoinOper, FieldName, RelChar: String; CxDate: TcxDateEdit;
  FormatStr: string; FieldType: integer): string;
begin
  result:='';
  if (trim(CxDate.Text)='') or (DatetoStr(CxDate.Date)='0000-0-0') then exit; //ʱ��ֵΪ�����˳�
  GetCxDate(JoinOper,FieldName,RelChar,CxDate.Date,FormatStr,FieldType);
end;

function TframeBaseReport.GetCxDate(JoinOper, FieldName: String; InBegDate,InEndDate: TcxDateEdit;
  FormatStr: string; IsTime: Boolean; FieldType: integer): string;
var
  Str, vBegDate, vEndDate, FmStr: String;
begin
  result:='';
  vBegDate:='';
  vEndDate:='';
  if trim(FieldName)='' then Exit;
  if (trim(InBegDate.Text)='') or (DatetoStr(InBegDate.Date)='0000-0-0') then
    vBegDate:=Formatdatetime(FormatStr,InBegDate.Date);
  if (trim(InEndDate.Text)='') or (DatetoStr(InEndDate.Date)='0000-0-0') then
    vEndDate:=Formatdatetime(FormatStr,InEndDate.Date);

  if vBegDate > vEndDate then //�Զ���������ǰ���С
  begin
    Str:=vBegDate;
    vBegDate:=vEndDate;
    vEndDate:=Str;
  end;
  //�Ƿ�:����+ʱ��
  if (IsTime) and (vBegDate<>'') then vBegDate:=vBegDate+' 00:00:00';
  if (IsTime) and (vEndDate<>'') then vEndDate:=vEndDate+' 23:59:59';
  //���ݲ�ѯ���ͽ������ò�ѯֵ:
  if (FieldType=2) or (FieldType=3) then
  begin
    if vBegDate<>'' then vBegDate:=''''+vBegDate+'''';
    if vEndDate<>'' then vEndDate:=''''+vEndDate+'''';
  end;

  if (vBegDate<>'') and (vEndDate<>'') then     //��ʼ���ڡ��������ھ���Ϊ��
    Str:='('+FieldName+'>='+vBegDate+' and '+FieldName+'<='+vEndDate+')'
  else if (vBegDate<>'') and (vEndDate='') then  //��ʼ���ڲ�Ϊ�ա���������Ϊ��
    Str:='('+FieldName+'>='+vBegDate+')'
  else if (vBegDate='') and (vEndDate<>'') then  //��ʼ����Ϊ�ա��������ڲ�Ϊ��
    Str:='('+FieldName+'<='''+vEndDate+''')';
  //�ж��Ƿ�����������ӷ�[and | or]
  if (trim(Str)<>'') and (trim(JoinOper)<>'') then
    Str:=' and '+Str;
  result:=str;
end;

function TframeBaseReport.GetCxDate(JoinOper, FieldName: String;
  InBegMonth, InEndMonth: TzrMonthEdit; FieldType: integer): string;
var
  Str,vBegMonth,vEndMonth: string;
begin
  result:='';
  if InBegMonth.asString>=InEndMonth.asString then
  begin
    vBegMonth:=InBegMonth.asString;
    vEndMonth:=InEndMonth.asString;
  end else
  begin
    vBegMonth:=InEndMonth.asString;
    vEndMonth:=InBegMonth.asString;
  end;
  if FieldType<>1 then
  begin
    vBegMonth:=''''+vBegMonth+'''';
    vEndMonth:=''''+vEndMonth+'''';
  end;
  Str:=' ('+FieldName+'>='+vBegMonth+') and ('+FieldName+'<='+vEndMonth+') ';
  if JoinOper<>'' then
    Str:=' '+JoinOper+Str;
  result:=Str;
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
end;

function TframeBaseReport.SelectGoodSortType(var SortID, SortRelID: string): string;
var
  rs:TRecord_;
begin
  result:='';
  SortID:='';
  SortRelID:='';
  rs := TRecord_.Create;
  try
    if TfrmSelectGoodSort.FindDialog(self,rs) then
    begin
      SortID := rs.FieldbyName('LEVEL_ID').AsString;
      SortRelID := rs.FieldbyName('RELATION_ID').AsString;
      result:=rs.FieldbyName('SORT_NAME').AsString;
    end;
  finally
    rs.Free;
  end;
end;


function TframeBaseReport.GetQueryCnd(FileName, ParamsValue,JoinOper: string): string;
begin
  result:='';
  if trim(FileName)='' then Exit;
  result:=' ('+FileName+'='''+ParamsValue+''') ';
  if (trim(JoinOper)<>'') and (result<>'') then
    result:=' '+JoinOper+' '+result;
end;

function TframeBaseReport.GetQueryCnd(Cbx: TzrComboBoxList; FileName, JoinOper: string): string;
begin
  result:='';
  if Cbx.AsString<>'' then
    result:=self.GetQueryCnd(FileName,Cbx.AsString,JoinOper); 
end;



end.
