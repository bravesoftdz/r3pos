{
˵��:
   (1)�������й�ϵ���㣬SQLITE�������: �ȳ��� *1.00 ת����������DB2�й�Sum�ֶΣ�
      �����ͱ�������Ҫת��: cast(����ֵ as decimal(18,3))
   (2)2011��3��27����ȷ������С���ĵ�λ������:
      ������:   #0.###
      ������:   #0.00#
      �����:   #0.00
      ë������: #0.00%
      �ۿ�����: #0% 

}                     


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
  cxRadioGroup, Buttons;


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
    PrintDBGridEh1: TPrintDBGridEh;
    procedure ActCloseExecute(Sender: TObject);
    procedure actColumnVisibleExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    procedure rzShowColumnsChange(Sender: TObject; Index: Integer; NewState: TCheckBoxState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actExportExecute(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Excelxls1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSumRecord: TRecord_;  //���ܼ�¼ֵ
    procedure Dofnd_CUST_TYPEChange(Sender: TObject);   //�ͻ�Ⱥ��OnChange
    procedure Dofnd_SHOP_TYPEChange(Sender: TObject);   //�ŵ����Ⱥ��OnChange
    procedure Dofnd_TYPE_IDChange(Sender: TObject);     //��Ʒͳ��ָ��OnChange
    procedure DoRBDate(Sender: TObject);   //��ʱû��
    procedure DoCxDateOnCloseUp(Sender: TObject); //��ʱû��
    function  GetHasChild: Boolean;
  public
    PUB_CLIENT_ID: TZQuery; //�ͻ�Ⱥ�����ݼ�

    constructor Create(AOwner: TComponent); override;
    function  GetDBGridEh: TDBGridEh;virtual;

    //�õ���
    //�����ַ����Ҳ��Ӵ�
    function  RightStr(Str: string; vlen: integer): string;
    //����ָ���ؼ������������: ('fndP3_D1','fndP'); ����: 3;
    function  GetCmpNum(CmpName,BegName: string): string;

    {=======  2011.03.02 Add ˫��TDBGridEh��ʾ��ϸ����[���Ʋ�ѯ����ֵ] =======}
    procedure Copy_ParamsValue(SrcList,DestList: TzrComboBoxList); overload;      //����ֵTzrComboBoxList
    procedure Copy_ParamsValue(vType: string; SrcIdx,DestIdx: integer); overload; //�����ŵ����Ⱥ��:SHOP_TYPE;��Ʒָ��:TYPE_ID

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
    //��ͬ���ݿ�����ת���������ֶ����ƣ�����ת������ʽ:
    function IntToVarchar(FieldName: string): string;
    //����Page��ҳ��ʾ:��IsGroupReport�Ƿ����[�����ŵ�]��
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true);virtual; //

    {=======  2011.03.03 Add ��Ʒͳ�Ƶ�λ�����ϵ   =======}
    //����: CalcIdx: 0:Ĭ��(����)��λ; 1:������λ;  2:С��װ��λ; 3:���װ��λ;
    //����: AliasTabName: �����ı���;  AliasFileName: �����ֶα���;
    function GetUnitID(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λUNIT_ID
    function GetUnitTO_CALC(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //����ͳ�Ƶ�λ�����ϵ
    //����ͳ������������ѯ���ݣ��������ϵķ����ֶΣ�
    function GetUnitIDCnd(CalcIdx: integer; AliasTabName: string): string;
    //��������PageNo��Ϊ�ؼ���No�������������ͷ����
    function  AddReportReport(TitleList: TStringList; PageNo: string): string;virtual; //���Title
    //����˵��:TitlStr�����TitleList;  Cols�������� SplitCount ����֮�������ַ�
    function  FormatReportHead(TitleList: TStringList; Cols: integer): string;virtual;
    //�ж�����������[����]
    function  CheckAccDate(BegDate, EndDate: integer;ShopID: string=''):integer; //����̨�ʱ�����������
    procedure Do_REPORT_FLAGOnChange(Sender: TObject; Grid: TDBGridEh);
    procedure Do_REPORT_FLAGFooterSum(Sender: TObject; RsGrid: TDataSet; AryFields: Array of string); //2011.05.22 Add ���������ܵ�FooterSum
    procedure LoadFormat;override;
    procedure PrintBefore;virtual;
    function  GetRowType:integer;virtual;
    //2011.04.22 Add �����Ƿ��в鿴�ɱ���Ȩ��
    procedure SetNotShowCostPrice(SetGrid: TDBGridEh; AryFields: Array of String);
    procedure RefreshColumn;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure CreateColumn(FieldName,TitleName:string;Index:Integer;ValueType:TFooterValueType=fvtNon;vWidth:Integer=70);
    procedure ClearSortMark;
    //2011.06.30 Am Add ����Excelǰ��ͷ
    function  DoBeforeExport: boolean; override;
    procedure SingleReportParams(ParameStr: string='');virtual; //�򵥱�����ò���
    //��ӱ����������: RptType
    procedure AddReportTypeList(RptType: TcxComboBox);
    procedure DoGodsGroupBySort(DataSet: TZQuery; SORT_IDX,SORT_ID, SORT_NAME: string; SumFields,CalcFields: Array of String); //���鱨��
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    function  GetRelation_ID(Relation_ID: string): string; //��Ӧ������

    property  HasChild: Boolean read GetHasChild;    //�ж��Ƿ���ŵ�
    property  DBGridEh: TDBGridEh read GetDBGridEh;  //��ǰDBGridEh
    property  SumRecord: TRecord_ read FSumRecord;  //���ܼ�¼ֵ
  end;

implementation

uses
  uGlobal,uShopGlobal,uShopUtil,ufrmEhLibReport,uCtrlUtil,
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
  PrintDBGridEh1.PageHeader.CenterText.Text:=Global.TENANT_NAME+trim(PrintDBGridEh1.PageHeader.CenterText.Text);
  DBGridEh.DataSource.DataSet.Filtered := false;
  PrintDBGridEh1.DBGridEh := DBGridEh;
  PrintDBGridEh1.Print;
end;

procedure TframeBaseReport.actPreviewExecute(Sender: TObject);
begin
  if DBGridEh = nil then Exit;
  PrintBefore;
  PrintDBGridEh1.PageHeader.CenterText.Text:=Global.TENANT_NAME+trim(PrintDBGridEh1.PageHeader.CenterText.Text);
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
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  if TDBGridEh(Sender).DataSource.DataSet=nil then Exit;
  if not TDBGridEh(Sender).DataSource.DataSet.Active then Exit;

  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
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
    if rzShowColumns.Items[Index]='' then Exit;
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
    //����Excel����
    DoBeforeExport;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      with TDBGridEhExportAsHTML.Create do
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
  CmpName,FName,vName: string;
  Cbx: TcxComboBox;
  Column:TColumnEh;
begin
  inherited;
  //���ܼ�¼ֵ
  FSumRecord:=TRecord_.Create;

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
        if RightStr(CmpName,10)='_CUST_TYPE' then //�ͻ�Ⱥ��
        begin
          Cbx.Properties.OnChange:=Dofnd_CUST_TYPEChange;
          Cbx.ItemIndex:=0;
        end else
        if RightStr(CmpName,8)='_TYPE_ID' then //��Ʒָ��
        begin
          AddGoodSortTypeItems(Cbx);
          Cbx.Properties.OnChange:=Dofnd_TYPE_IDChange;
          Cbx.ItemIndex:=0;
        end;
        if RightStr(CmpName,8)='_RPTTYPE' then //��Ʒָ��
        begin
          AddReportTypeList(Cbx);
          Cbx.ItemIndex:=0;
        end;  
      end;
    end;

    //����TzrComboBoxList����:
    if Components[i] is TzrComboBoxList then
    begin
      CmpName:=trim(UpperCase(TzrComboBoxList(Components[i]).Name));
      TzrComboBoxList(Components[i]).ShowButton:=true;
      TzrComboBoxList(Components[i]).Buttons:=[zbClear];
      //�ŵ�����
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_SHOP_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
      end;
      //��������
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_DEPT_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_DEPT_INFO');
      end;
      //��Ʒͳ��ָ��
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,11)='_SHOP_VALUE') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
      end;
      //�ͻ�Ⱥ��
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,11)='_CUST_VALUE') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;        
      end;
      //��Ʒ����
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_GODS_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('PUB_GOODSINFO');
      end;
      //�Ƶ���
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_USER_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;        
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_USERS');
      end;
      //�Ƶ���
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,11)='_GUIDE_USER') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;        
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_USERS');
      end;
    end;

    //������ɫ�顢���������Ƿ���ʾ
    if Components[i] is TDBGridEh then
    begin
      Column := FindColumn(TDBGridEh(Components[i]),'PROPERTY_01');
      if Column<>nil then //Column.Visible := (CLVersion='FIG');
        Column.Free;
      Column := FindColumn(TDBGridEh(Components[i]),'PROPERTY_02');
      if Column<>nil then //Column.Visible := (CLVersion='FIG');
        Column.Free;
      //DBGridEh����Ϊ���ͷ
      if not TDBGridEh(Components[i]).UseMultiTitle then
        TDBGridEh(Components[i]).UseMultiTitle:=true;
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

//���: 80���ֽ� ���һ�в��Ӹ�ʽ���������Ҷ���
function TframeBaseReport.FormatReportHead(TitleList: TStringList; Cols: integer): string;
var
  spaceStr,str1: string;
  i,j: integer;
begin
  //�м���4���ո�:
  result:='';
  for i:=0 to TitleList.Count-1 do
  begin
    if i mod Cols=0 then
    begin
      j:=i;
      if j<=TitleList.Count-1 then str1:=trim(TitleList.Strings[j]);    //1
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //2
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //3
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //4
      case length(str1) of
        1.. 50:  spaceStr:='                         ';
        51..60:  spaceStr:='                  ';
        61..75:  spaceStr:='            ';
        76..90:  spaceStr:='      ';
        else     spaceStr:=' ';
      end;
    end;
    if result='' then result:=trim(TitleList.Strings[i])
    else
    begin
      if (i mod Cols=0) and (i>=Cols) then
        result:=result+#13+trim(TitleList.Strings[i])
      else
        result:=result+spaceStr+trim(TitleList.Strings[i]);
    end;
  end;
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
  if SortTypeList.Columns.Count>1 then
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
   0: result:='(case when '+AliasTab+'UNIT_ID is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end) ';  //��[Ĭ�ϵ�λ]Ϊ���� ȡ [������λ]
   1: result:=' '+AliasTab+'CALC_UNITS ';   //[������λ]  ����Ϊ��
   2: result:='(case when '+AliasTab+'SMALL_UNITS is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end) ';  //С��װ��λ
   3: result:='(case when '+AliasTab+'BIG_UNITS is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end) ';      //���װ��λ
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

  str:=' case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+            //Ĭ�ϵ�λΪ ������λ
            ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //Ĭ�ϵ�λΪ С��λ
            ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+      //Ĭ�ϵ�λΪ ��λ
            ' else 1.0 end ';

  case CalcIdx of 
   0: result:=' '+str+' ';       //Ĭ�ϵ�λ
   1: result:=' 1.0 ';   //������λ
   2: result:=' '+SmallCalc+' '; //С��װ��λ
   3: result:=' '+BigCalc+' ';   //���װ��λ
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

procedure TframeBaseReport.Dofnd_CUST_TYPEChange(Sender: TObject);
var
  i: integer;
  CmpName: string;
  FindCmp: TComponent;
  CustValueList: TzrComboBoxList;
begin
  if not assigned(PUB_CLIENT_ID) then
  begin
    PUB_CLIENT_ID:=TZQuery.Create(self);
    PUB_CLIENT_ID.Close;
    PUB_CLIENT_ID.SQL.Text:='select 0 as SEQ_NO,DEFINE as CODE_ID,VALUE as CODE_NAME from SYS_DEFINE where 1=2 ';
    Factor.Open(PUB_CLIENT_ID);
    PUB_CLIENT_ID.IndexFieldNames:='SEQ_NO';
    //��ӣ�ȫ��
    PUB_CLIENT_ID.Edit;
    PUB_CLIENT_ID.FieldByName('SEQ_NO').AsString:='1';
    PUB_CLIENT_ID.FieldByName('CODE_ID').AsString:='1';
    PUB_CLIENT_ID.FieldByName('CODE_NAME').AsString:='ȫ��';
    PUB_CLIENT_ID.Post;
    //��ӣ���ҵ�ͻ�
    PUB_CLIENT_ID.Append;
    PUB_CLIENT_ID.FieldByName('SEQ_NO').AsString:='2';
    PUB_CLIENT_ID.FieldByName('CODE_ID').AsString:='0';
    PUB_CLIENT_ID.FieldByName('CODE_NAME').AsString:='��ҵ�ͻ�';
    PUB_CLIENT_ID.Post;
    //��ӣ���Ա
    PUB_CLIENT_ID.Append;
    PUB_CLIENT_ID.FieldByName('SEQ_NO').AsString:='3';
    PUB_CLIENT_ID.FieldByName('CODE_ID').AsString:='2';
    PUB_CLIENT_ID.FieldByName('CODE_NAME').AsString:='��Ա';
    PUB_CLIENT_ID.Post;
  end;

  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //���ؿؼ�Num
  if CmpName<>'' then
  begin
    CmpName:='fndP'+CmpName+'_CUST_VALUE';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
    begin
      CustValueList:=TzrComboBoxList(FindCmp);
      case TcxComboBox(Sender).ItemIndex of
       0:
        begin
          CustValueList.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO'); //�������� �Ϳͻ�����
          CustValueList.KeyField:='CODE_ID';
          CustValueList.ListField:='CODE_NAME';
          CustValueList.FilterFields:='CODE_ID;CODE_NAME;CODE_SPELL';
          CustValueList.DropWidth:=170;
          CustValueList.DropHeight:=180;
        end;
       1:
        begin
          CustValueList.DataSet:=Global.GetZQueryFromName('PUB_PRICEGRADE');  //�ͻ��ȼ�
          CustValueList.KeyField:='PRICE_ID';
          CustValueList.ListField:='PRICE_NAME';
          CustValueList.FilterFields:='PRICE_ID;PRICE_NAME;PRICE_SPELL';
          CustValueList.DropWidth:=CustValueList.Width+15;
          CustValueList.DropHeight:=120;
        end;
        2:
        begin
          CustValueList.DataSet:=Global.GetZQueryFromName('PUB_CLIENTSORT'); //�������� �Ϳͻ�����
          CustValueList.KeyField:='CODE_ID';
          CustValueList.ListField:='CODE_NAME';
          CustValueList.FilterFields:='CODE_ID;CODE_NAME;CODE_SPELL';
          CustValueList.DropWidth:=150;
          CustValueList.DropHeight:=154;
        end;
        3:
        begin
          CustValueList.DataSet:=PUB_CLIENT_ID; //�������� �Ϳͻ�����
          CustValueList.KeyField:='CODE_ID';
          CustValueList.ListField:='CODE_NAME';
          CustValueList.FilterFields:='CODE_ID;CODE_NAME';
          CustValueList.DropWidth:=CustValueList.Width+15;
          CustValueList.DropHeight:=120;
        end;
      end;
      CustValueList.Columns[0].FieldName:=CustValueList.ListField;
      if CustValueList.Columns.Count>1 then
      begin
        CustValueList.Columns[1].FieldName:=CustValueList.KeyField;
        CustValueList.Columns[1].Visible:=not((TcxComboBox(Sender).ItemIndex=1) or (TcxComboBox(Sender).ItemIndex=3));
      end;
      CustValueList.KeyValue:=null;
      CustValueList.Text:='';
    end;
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

procedure TframeBaseReport.Copy_ParamsValue(SrcList, DestList: TzrComboBoxList);
begin
  if (SrcList<>nil) and (DestList<>nil) then
  begin
    DestList.KeyValue:=SrcList.KeyValue;
    DestList.Text:=SrcList.Text;
  end;
end;

//�����ŵ����Ⱥ��:SHOP_TYPE;  ��Ʒָ��:TYPE_ID
procedure TframeBaseReport.Copy_ParamsValue(vType: string; SrcIdx,DestIdx: integer);
var
  SrcCmp,DestCmp: TComponent;
begin
  if vType='SHOP_TYPE' then
  begin
    //�ȸ���Ⱥ������
    SrcCmp:=FindComponent('fndP'+InttoStr(SrcIdx)+'_SHOP_TYPE');
    DestCmp:=FindComponent('fndP'+InttoStr(DestIdx)+'_SHOP_TYPE');
    if (SrcCmp<>nil) and (DestCmp<>nil) and (SrcCmp is TcxComboBox) and (DestCmp is TcxComboBox) then
    begin
      TcxComboBox(DestCmp).ItemIndex:=TcxComboBox(SrcCmp).ItemIndex;
    end;
    //����Ⱥ��ѡ��ֵ
    SrcCmp:=FindComponent('fndP'+InttoStr(SrcIdx)+'_SHOP_VALUE');
    DestCmp:=FindComponent('fndP'+InttoStr(DestIdx)+'_SHOP_VALUE');
    if (SrcCmp<>nil) and (DestCmp<>nil) and (SrcCmp is TzrComboBoxList) and (DestCmp is TzrComboBoxList) then
    begin
      TzrComboBoxList(DestCmp).KeyValue:=TzrComboBoxList(SrcCmp).KeyValue;
      TzrComboBoxList(DestCmp).Text:=TzrComboBoxList(SrcCmp).Text;
    end;
  end else
  if vType='TYPE_ID' then
  begin
    //�ȸ���Ⱥ������
    SrcCmp:=FindComponent('fndP'+InttoStr(SrcIdx)+'_TYPE_ID');
    DestCmp:=FindComponent('fndP'+InttoStr(DestIdx)+'_TYPE_ID');
    if (SrcCmp<>nil) and (DestCmp<>nil) and (SrcCmp is TcxComboBox) and (DestCmp is TcxComboBox) then
    begin
      TcxComboBox(DestCmp).ItemIndex:=TcxComboBox(SrcCmp).ItemIndex;
    end;
    //����Ⱥ��ѡ��ֵ
    SrcCmp:=FindComponent('fndP'+InttoStr(SrcIdx)+'_STAT_ID');
    DestCmp:=FindComponent('fndP'+InttoStr(DestIdx)+'_STAT_ID');
    if (SrcCmp<>nil) and (DestCmp<>nil) and (SrcCmp is TzrComboBoxList) and (DestCmp is TzrComboBoxList) then
    begin
      TzrComboBoxList(DestCmp).KeyValue:=TzrComboBoxList(SrcCmp).KeyValue;
      TzrComboBoxList(DestCmp).Text:=TzrComboBoxList(SrcCmp).Text;
    end;
  end;
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
  i: integer;
  Aobj: TRecord_;
  SetCol: TColumnEh;
  SetType: TFooterValueType; //������������
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    Aobj:=TRecord_(TcxComboBox(Sender).Properties.Items.Objects[TcxComboBox(Sender).ItemIndex]);
    {
    SetCol:=FindColumn(Grid,'SORT_ID');
    if (Aobj<>nil) and (SetCol<>nil) then
    begin
      SetCol.Title.Caption:=Aobj.fieldbyName('CODE_NAME').AsString+'����';
      SetCol.Width:=90;
      end;
    end;
    }
    //��������
    SetCol:=FindColumn(Grid,'SORT_NAME');
    if (Aobj<>nil) and (SetCol<>nil) then
    begin
      SetCol.Title.Caption:=Aobj.fieldbyName('CODE_NAME').AsString+'����';
      SetCol.Width:=220;
    end;
  end;
end;

//2011.05.22 Add ���������ܵ�FooterSum
procedure TframeBaseReport.Do_REPORT_FLAGFooterSum(Sender: TObject; RsGrid: TDataSet; AryFields: array of string);
var
  i: integer;
  FName: string;
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    if TRecord_(TcxComboBox(Sender).Properties.Items.Objects[TcxComboBox(Sender).ItemIndex]).FieldByName('CODE_ID').AsInteger<>1 then //����[�ֹ�����]
      FSumRecord.Clear
    else
    begin
      FSumRecord.Clear;
      FSumRecord.ReadField(RsGrid);
      RsGrid.DisableControls;
      try
        RsGrid.First;
        while not RsGrid.Eof do
        begin
          if trim(RsGrid.FieldByName('LEVEL_ID').AsString)='' then
          begin
            for i:=Low(AryFields) to High(AryFields) do
            begin
              FName:=trim(AryFields[i]);
              FSumRecord.FieldByName(FName).AsFloat:=FSumRecord.FieldByName(FName).AsFloat+RsGrid.FieldByName(FName).AsFloat;
            end;
          end;
          RsGrid.Next;
        end;
        rsGrid.First;
      finally
        rsGrid.EnableControls;
      end;
    end;
  end;
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

function TframeBaseReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  i: integer;
  CmpName: string;
  Contrl: TWinControl;
  FindCmp1,FindCmp2: TComponent;
begin
  // 1������Ⱥ�飺
  FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_TYPE');
  FindCmp2:=FindComponent('fndP'+PageNo+'_SHOP_VALUE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp2<>nil)and (FindCmp2.Tag<>100) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList)  and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'')  then
  begin
    TitleList.add(TcxComboBox(FindCmp1).Text+'��'+TzrComboBoxList(FindCmp2).Text);
  end;

  //  2���ͻ�����
  FindCmp1:=FindComponent('fndP'+PageNo+'_CUST_TYPE');
  FindCmp2:=FindComponent('fndP'+PageNo+'_CUST_VALUE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp2<>nil)and (FindCmp2.Tag<>100) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList)  and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'')  then
  begin
    TitleList.add(TcxComboBox(FindCmp1).Text+'��'+TzrComboBoxList(FindCmp2).Text);
  end;
  
  // 4���ŵ����ƣ�
  FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_ID');
  if (FindCmp1<>nil)and (FindCmp1.Tag<>100) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
  begin
    TitleList.Add('�ŵ����ƣ�'+TzrComboBoxList(FindCmp1).Text);
  end;

  // 5����������:
  FindCmp1:=FindComponent('fndP'+PageNo+'_DEPT_ID');
  if (FindCmp1<>nil)and (FindCmp1.Tag<>100) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
  begin
    TitleList.Add('�������ƣ�'+TzrComboBoxList(FindCmp1).Text);
  end;

  // 6����Ʒָ�꣺
  FindCmp1:=FindComponent('fndP'+PageNo+'_TYPE_ID');
  FindCmp2:=FindComponent('fndP'+PageNo+'_STAT_ID');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp2<>nil)and (FindCmp2.Tag<>100) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList) and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'') then
  begin
    TitleList.add(TcxComboBox(FindCmp1).Text+'��'+TzrComboBoxList(FindCmp2).Text);
  end;
  // 7����Ʒ����
  FindCmp1:=FindComponent('fndP'+PageNo+'_SORT_ID');
  if (FindCmp1<>nil)and (FindCmp1.Tag<>100) and (FindCmp1 is TcxButtonEdit) and (TcxButtonEdit(FindCmp1).Visible) and (TcxButtonEdit(FindCmp1).Text<>'') then
  begin
    TitleList.Add('��Ʒ���ࣺ'+TcxButtonEdit(FindCmp1).Text);
  end;

  // 8����Ʒ���ƣ�
  FindCmp1:=FindComponent('fndP'+PageNo+'_GODS_ID');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
  begin
    TitleList.Add('��Ʒ���ƣ�'+TzrComboBoxList(FindCmp1).Text);
  end;

  // 9��������λ
  FindCmp1:=FindComponent('fndP'+PageNo+'_UNIT_ID');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex<>-1) then
    TitleList.Add('ͳ�Ƶ�λ��'+TcxComboBox(FindCmp1).Text);

  // 10��ҵ��Ա������Ա
  FindCmp1:=FindComponent('fndP'+PageNo+'_GUIDE_USER');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).Visible) and (TzrComboBoxList(FindCmp1).AsString<>'') then
  begin
    if ProductID = 'R3_RYC' then
      TitleList.Add('����Ա��'+TzrComboBoxList(FindCmp1).Text)
    else
      TitleList.Add('ҵ��Ա��'+TzrComboBoxList(FindCmp1).Text);
  end;

  // 11����������:[ȫ����������]
  FindCmp1:=FindComponent('fndP'+PageNo+'_ALL');
  if (FindCmp1<>nil) and (FindCmp1 is TcxRadioButton) and (not TcxRadioButton(FindCmp1).Checked) then //����:
  begin
    Contrl:=TcxRadioButton(FindCmp1).Parent;
    if (Contrl<>nil) and (Contrl.ControlCount>0) then  //����[��ѯ�������:Conrol ѭ����ѯ]
    begin
      for i:=0 to Contrl.ControlCount-1 do
      begin
        CmpName:=copy(trim(LowerCase(TComponent(Contrl.Controls[i]).Name)),1,5+length(PageNo));
        if (Contrl.Controls[i] is TcxRadioButton) and (TcxRadioButton(Contrl.Controls[i]).Checked) and (CmpName='fndp'+PageNo+'_') then
        begin
          TitleList.Add('�������ͣ�'+TcxRadioButton(Contrl.Controls[i]).Caption);
          Break;
        end;
      end;
    end;
  end;
end;

function TframeBaseReport.IntToVarchar(FieldName: string): string;
begin
  result:=trim(FieldName);
  case Factor.iDbType of
   0,5:
      result:='cast('+FieldName+' as varchar)';
   1: result:='cast('+FieldName+' as varchar(30))';
   3: result:='str('+FieldName+')';
   4: result:='trim(char('+FieldName+'))';
  end;
end;

function TframeBaseReport.GetHasChild: Boolean;
begin
  result:=(ShopGlobal.GetZQueryFromName('CA_SHOP_INFO').RecordCount>1);
end;

procedure TframeBaseReport.SetRzPageActivePage(IsGroupReport: Boolean);
var i: integer;
begin
  if (IsGroupReport) and (RzPage.PageCount>1) then
  begin
    rzPage.Pages[0].TabVisible := HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
    rzPage.Pages[1].TabVisible := HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
  end;
  for i:=0 to rzPage.PageCount -1 do
  begin
    if rzPage.Pages[i].TabVisible then
    begin
      rzPage.ActivePageIndex:=i;
      Break;
    end;
  end;
end;

procedure TframeBaseReport.SetNotShowCostPrice(SetGrid: TDBGridEh; AryFields: array of String);
var
  i: integer;
  ColName: string;
  SetCol: TColumnEh;
begin
  for i:=Low(AryFields) to High(AryFields) do
  begin
    ColName:=trim(AryFields[i]);
    SetCol:=FindColumn(SetGrid, ColName);
    if SetCol<>nil then
      SetCol.Free;
  end;
end;

procedure TframeBaseReport.FormDestroy(Sender: TObject);
begin
  inherited;
  FSumRecord.Free;
end;

//2011.06.30 Am Add ����Excelǰ��ͷ
function TframeBaseReport.DoBeforeExport: boolean;
var
  i: integer;                      
  PageNo,CurStr: string;  //�ؼ�ҳ��
  Str: WideString;
  TitleList: TStringList;
begin
  Str:='';
  try
    DBGridEh.DBGridHeader.Clear;
    DBGridEh.DBGridFooter.Clear;
    PageNo:=InttoStr(RzPage.ActivePageIndex+1);
    DBGridEh.DBGridTitle:=RzPage.ActivePage.Caption;
    //����DBGridEh��Print����ȡ��������
    TitleList:=TStringList.Create;
    AddReportReport(TitleList, PageNo);
    for i:=0 to TitleList.Count-1 do
    begin
      CurStr:=trim(TitleList.Strings[i]);
      if (i>0) and (i mod 4=0) then  //4��������һ��
        Str:=Str+#13+CurStr
      else
      begin
        if i=0 then
          Str:=CurStr
        else
          Str:=Str+'      '+CurStr;
      end;
    end;
  finally
    TitleList.Free;
  end;
  DBGridEh.DBGridHeader.Text:=Str;
  DBGridEh.DBGridFooter.Add(' '+#13+' ����Ա��'+Global.UserName+'  ����ʱ�䣺'+formatDatetime('YYYY-MM-DD HH:NN:SS',now()));
end;

procedure TframeBaseReport.SingleReportParams(ParameStr: string);
begin

end;

procedure TframeBaseReport.DoGodsGroupBySort(DataSet: TZQuery; SORT_IDX,SORT_ID,SORT_NAME: string; SumFields,CalcFields: Array of String);
 //ȡSortList:
 procedure SetSortList(SortList: TStringList);
 var SortID: string;
 begin
   try
     SortList.Clear;
     DataSet.First;
     while not DataSet.Eof do
     begin
       SortID:=trim(DataSet.fieldbyname(SORT_ID).AsString);
       if SortList.IndexOf(SortID)=-1 then
         SortList.Add(SortID);
       DataSet.Next;
     end;
   finally
     DataSet.First;
   end;
 end;
 procedure CalcValue(AObj: TRecord_); //�����������
 var i,Idx: integer; CalcField1,CalcField2,CalcValue: string; CalcCount: real;
 begin
   CalcCount:=1.0;
   for i:=Low(CalcFields) to High(CalcFields) do
   begin
     CalcField2:=trim(CalcFields[i]);
     Idx:=Pos('=',CalcField2);
     CalcValue:=Copy(CalcField2,1,Idx-1);
     delete(CalcField2,1,Idx);
     Idx:=Pos('/',CalcField2);
     CalcField1:=Copy(CalcField2,1,Idx-1);
     delete(CalcField2,1,Idx);
     Idx:=Pos('*',CalcField2);
     if Idx>0 then
     begin
       CalcCount:=StrtoFloatDef(Copy(CalcField2,Idx+1,length(CalcField2)-Idx),1.0);
       CalcField2:=Copy(CalcField2,1,Idx-1);
     end;

     if (AObj.FindField(CalcValue)<>nil) and (AObj.FindField(CalcField1)<>nil) and (AObj.FindField(CalcField2)<>nil) then
     begin
       if AObj.FindField(CalcField2).AsFloat<>0 then 
         AObj.FindField(CalcValue).AsFloat:=(AObj.FindField(CalcField1).AsFloat / AObj.FindField(CalcField2).AsFloat)*CalcCount;
     end;
   end;
 end;
 procedure CalcSum(AllObj, SortObj, tmpObj: TRecord_); //�����������
 var i: integer; FieldName: string;
 begin
   for i:=Low(SumFields) to High(SumFields) do
   begin
     FieldName:=trim(SumFields[i]);
     AllObj.FieldByName(FieldName).AsFloat:=AllObj.FieldByName(FieldName).AsFloat+tmpObj.FieldByName(FieldName).AsFloat;
     SortObj.FieldByName(FieldName).AsFloat:=SortObj.FieldByName(FieldName).AsFloat+tmpObj.FieldByName(FieldName).AsFloat;
   end;
 end;

 function GetSortName(SORT_ID: string): string;
 var SortRs: TZQuery;
 begin
   result:='';
   case strtoInt(SORT_IDX) of
   0:
    begin
      if trim(SORT_ID)='0' then
        result:='������Ӫ'
      else
      begin
        SortRs:=Global.GetZQueryFromName('CA_RELATIONS');
        if SortRs<>nil then
        begin
          if SortRs.Locate('RELATION_ID',SORT_ID,[]) then
            result:=trim(SortRs.fieldbyName('RELATION_NAME').AsString);
        end;
      end;
    end;
   1:
    begin
      SortRs:=Global.GetZQueryFromName('PUB_GOODSSORT');
      if SortRs<>nil then
      begin
        if SortRs.Locate('SORT_ID',SORT_ID,[]) then
          result:=trim(SortRs.fieldbyName('SORT_NAME').AsString);
      end;
    end;
   else
    begin
      SortRs:=Global.GetZQueryFromName('PUB_GOODS_INDEXS');
      if SortRs<>nil then
      begin
        if SortRs.Locate('SORT_ID',SORT_ID,[]) then
          result:=trim(SortRs.fieldbyName('SORT_NAME').AsString);
      end;
    end;
   end;
 end;
var
  i: integer;
  SID: string;
  Rs: TZQuery;
  SortList: TStringList;
  SortObj, tmpObj: TRecord_;
begin
  try
    Rs:=TZQuery.Create(nil);
    Rs.Data:=DataSet.Data;
    SortList:=TStringList.Create;
    SortObj:=TRecord_.Create;
    tmpObj:=TRecord_.Create;
    FSumRecord.Clear;
    FSumRecord.ReadField(DataSet);
    SetSortList(SortList); //��ȡ�������
    DataSet.EmptyDataSet;  //�������
    DataSet.IndexFieldNames:='vNO';
    DataSet.SortedFields:='vNO';
    Rs.First;
    for i:=0 to SortList.Count-1 do  //�������ѭ������
    begin
      SID:=trim(SortList.Strings[i]);
      SortObj.ReadField(DataSet);
      while not Rs.Eof do
      begin
        if SID=trim(Rs.fieldbyname(SORT_ID).AsString) then
        begin
          tmpObj.ReadFromDataSet(Rs);
          CalcSum(FSumRecord,SortObj,tmpObj); //�����������
          DataSet.Append;
          tmpObj.WriteToDataSet(DataSet);  //д�����ݼ�
          DataSet.FieldByName('VNO').AsString:=inttoStr(10000000+DataSet.RecordCount);
          Rs.Next;
        end else
        begin
          //���뵱ǰSortID�Ļ�����
          CalcValue(SortObj); //�����������
          DataSet.Append;
          SortObj.WriteToDataSet(DataSet);  //д�����ݼ�
          DataSet.FieldByName(SORT_NAME).AsString:='    '+GetSortName(SID)+' (С��)';
          DataSet.FieldByName('VNO').AsString:=inttoStr(10000000+DataSet.RecordCount);
          DataSet.FieldByName(SORT_ID).AsString:='-1';
          SortObj.Clear;
          Break;  //��������˳�ѭ��
        end;
      end;
    end;

    //���һ�η�����ܣ�
    if (not DataSet.IsEmpty) and (SortObj.Count>0) then
    begin
      CalcValue(SortObj); //�����������
      DataSet.Append;
      SortObj.WriteToDataSet(DataSet);  //д�����ݼ�
      DataSet.FieldByName(SORT_NAME).AsString:='    '+GetSortName(SID)+' (С��)';
      DataSet.FieldByName('VNO').AsString:=inttoStr(10000000+DataSet.RecordCount);
      DataSet.FieldByName(SORT_ID).AsString:='-1';
      SortObj.Clear;
    end;      

    //���ؼ�¼��
    FSumRecord.FieldByName(SORT_NAME).AsString:=InttoStr(Rs.RecordCount);
    //�����ܺϼ�
    if not DataSet.IsEmpty then
      CalcValue(FSumRecord); //�����������
  finally
    Rs.Free;
    SortList.Free;
    SortObj.Free;
    tmpObj.Free;
  end;
end;

procedure TframeBaseReport.AddReportTypeList(RptType: TcxComboBox);
var
  i: integer;
  CurObj: TRecord_;
  rs,StatInfo: TZQuery;
begin
  try
    rs:=TZQuery.Create(nil);
    rs.Close;
    rs.FieldDefs.Add('SORT_ID',ftInteger,0,true);
    rs.FieldDefs.Add('SORT_NAME',ftstring,50,true);
    rs.FieldDefs.Add('GROUP_NAME',ftstring,50,true);
    rs.CreateDataSet;
    //��Ӧ������ͳ��
    rs.Append;
    rs.FieldByName('SORT_ID').AsInteger:=0;
    rs.FieldByName('SORT_NAME').AsString:='��Ӧ��';
    rs.FieldByName('GROUP_NAME').AsString:='��Ӧ��';
    rs.Post;
    //��Ʒ�������ͳ��
    {rs.Append;
    rs.FieldByName('SORT_ID').AsInteger:=1;
    rs.FieldByName('SORT_NAME').AsString:='��Ʒ����';
    rs.FieldByName('GROUP_NAME').AsString:='��Ʒ�������ͳ��';
    rs.Post;
    }
    StatInfo:=Global.GetZQueryFromName('PUB_STAT_INFO');
    StatInfo.First;
    while not StatInfo.Eof do
    begin
      rs.Append;
      rs.FieldByName('SORT_ID').AsString:=StatInfo.fieldbyName('CODE_ID').AsString;
      rs.FieldByName('SORT_NAME').AsString:=StatInfo.fieldbyName('CODE_NAME').AsString;
      rs.FieldByName('GROUP_NAME').AsString:=StatInfo.fieldbyName('CODE_NAME').AsString;
      rs.Post;
      StatInfo.Next;
    end;
    ClearCbxPickList(RptType);  //����ڵ㼰Object����
    rs.First;
    while not rs.Eof do
    begin
      CurObj:=TRecord_.Create;
      CurObj.ReadFromDataSet(rs);
      RptType.Properties.Items.AddObject(CurObj.fieldbyName('GROUP_NAME').AsString,CurObj);
      rs.Next;
    end;
  finally
    rs.Free;
  end;
end;

procedure TframeBaseReport.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;
begin
  if TDBGridEh(Sender).DataSource.DataSet=nil then Exit;
  if not TDBGridEh(Sender).DataSource.DataSet.Active then Exit;

  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DrawText(Column.Grid.Canvas.Handle,pchar(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),length(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;

  if trim(TDBGridEh(Sender).DataSource.DataSet.fieldbyName('SORT_ID').AsString) = '-1' then
  begin
    if trim(Column.FieldName)<>'SEQNO' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00E7E2E3; //$00A5A5A5;
      TDBGridEh(Sender).Canvas.Font.Style:=[fsBold];
      TDBGridEh(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

function TframeBaseReport.GetRelation_ID(Relation_ID: string): string;
begin
  case Factor.iDbType of
   0,1,4:
      result:='(case when '+Relation_ID+'=0 then 9999999 else '+Relation_ID+' end)';
   5: result:='(case when '+Relation_ID+'=''0'' then ''9999999'' else '+Relation_ID+' end)';
   else
      result:='(case when '+Relation_ID+'=0 then 9999999 else '+Relation_ID+' end)';
  end;
end;

end.
