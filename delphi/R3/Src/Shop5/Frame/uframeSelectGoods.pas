unit uframeSelectGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, cxRadioGroup, DB, DBClient, ADODB, ObjBase,
  cxMaskEdit, cxDropDownEdit, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TframeSelectGoods = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzPanel3: TRzPanel;
    RzTree: TRzTreeView;
    RzPanel4: TRzPanel;
    DBGridEh1: TDBGridEh;
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    Label8: TLabel;
    Label1: TLabel;
    edtSearch: TcxTextEdit;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    btnFilter: TRzBitBtn;
    dsList: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label2: TLabel;
    fndGODS_FLAG1: TcxComboBox;
    CheckBox1: TCheckBox;
    cdsList: TZQuery;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure btnFilterClick(Sender: TObject);
    procedure RzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Rb1Click(Sender: TObject);
    procedure Rb2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure fndGODS_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
  private
    { Private declarations }
    IsEnd: boolean;
    MaxId:string;
    FMultiSelect: boolean;
    procedure InitGrid;
    procedure LoadLevelSort;
    procedure LoadBrandInfo;
    procedure LoadProvInfo;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    procedure SetMultiSelect(const Value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
  end;

implementation
uses uCtrlUtil, uGlobal, uTreeUtil, uShopGlobal;
{$R *.dfm}

{ TframeSelectGoods }

constructor TframeSelectGoods.Create(AOwner: TComponent);
begin
  inherited;
  MultiSelect := false;
  InitGrid;
  TDbGridEhSort.InitForm(self);
end;

destructor TframeSelectGoods.Destroy;
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TframeSelectGoods.InitGrid;
var rs: TADODataSet;
begin
  inherited;
  fndGODS_FLAG1.ItemIndex := 0;
  rs := Global.GetADODataSetFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[5].KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      DBGridEh1.Columns[5].PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;
end;

procedure TframeSelectGoods.Open(Id: string);
var
  rs:TClientDataSet;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TClientDataSet.Create(nil);
  cdsList.DisableControls;
  try
    rs.CommandText := EncodeSQL(Id);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    if Id='' then
       cdsList.Data := rs.Data
    else
       cdsList.AppendData(rs.Data,true);
    if rs.RecordCount <100 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    rs.Free;
  end;
end;

function TframeSelectGoods.EncodeSQL(id: string): string;
var w:string;
begin
  w := 'and j.COMP_ID='''+Global.CompanyId+''' and j.COMM not in (''02'',''12'') ';
  if id<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + 'j.GODS_ID>='''+id+'''';
     end;
  if (rzTree.Selected<>nil) and (rzTree.Selected.Level>0) then
     begin
      if w<>'' then w := w + ' and ';
      case fndGODS_FLAG1.ItemIndex of
      0:w := w + 'b.LEVEL_ID like '''+TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').asString+'%''';
      1:w := w + 'j.BRAND = '''+TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').asString+'''';
      2:w := w + 'j.PROVIDE = '''+TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').asString+'''';
      end;
     end;
  if trim(edtSearch.Text)<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + '(j.GODS_CODE like ''%'+trim(edtSearch.Text)+'%'' or j.BCODE like ''%'+trim(edtSearch.Text)+'%'' or j.GODS_NAME like ''%'+trim(edtSearch.Text)+'%'' or j.GODS_SPELL like ''%'+trim(edtSearch.Text)+'%'' or Exists(select * from PUB_BARCODE where BARCODE like ''%'+trim(edtSearch.Text)+''' and GODS_ID=j.GODS_ID))';
     end;
//  if Rb1.Checked then
  result := 'select top 100 0 as A,l.*,r.AMOUNT from(select j.* from VIW_GOODSINFO j,PUB_GOODSSORT b where j.SORT_ID=b.SORT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where COMP_ID='''+Global.CompanyId+''' group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID'
//  else
//  result := 'select top 100 0 as A,l.*,r.AMOUNT from(select j.* from VIW_GOODSINFO j,PUB_GOODSSORT b where j.SORT_ID=b.SORT_ID '+w+') l '+
//            'inner join '+
//            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where COMP_ID='''+Global.CompanyId+''' group by GODS_ID having sum(AMOUNT)<>0) r '+
//            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID'
end;

procedure TframeSelectGoods.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TframeSelectGoods.btnFilterClick(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.RzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeSelectGoods.btnOkClick(Sender: TObject);
procedure SetCurrent;
begin
  if cdsList.IsEmpty then Exit;
  cdsList.Edit;
  cdsList.FieldByName('A').AsInteger :=1 ;
  cdsList.Post;
end;
var bs:TADODataSet;
  i:integer;
begin
  inherited;
  cdsList.DisableControls;
  try
    if not MultiSelect then SetCurrent;
    cdsList.Filtered := false;
    cdsList.Filter := 'A=1';
    cdsList.Filtered := true;
    if cdsList.IsEmpty then
       begin
         Raise Exception.Create('请选择货品,在选择栏打勾');
       end;
  except
    cdsList.Filtered := false;
    cdsList.EnableControls;
    Raise;
  end;
  ModalResult := MROK;
end;

procedure TframeSelectGoods.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
  DBGridEh1.Columns[0].Visible := Value;
  N2.Enabled:=Value;
  N3.Enabled:=Value;
  N4.Enabled:=Value;
end;

procedure TframeSelectGoods.DBGridEh1DblClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if Assigned(OnSave) then
     begin
       AObj := TRecord_.Create;
       try
         AObj.ReadFromDataSet(cdsList);
         OnSave(AObj); 
       finally
         AObj.Free;
       end;
     end
  else
     begin
       if not cdsList.IsEmpty then
          btnOkClick(nil)
       else
          edtSearch.SetFocus;
     end;
end;

procedure TframeSelectGoods.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.edtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //if Key=VK_UP then cdsList.Prior;
  //if Key=VK_DOWN then cdsList.Next;
  if Key=VK_RETURN then
     begin
       Open('');
       //edtSearch.Text := '';
       DBGridEh1.SetFocus;
     end;

end;

procedure TframeSelectGoods.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=13 then
     begin
       if cdsList.IsEmpty then Exit;
       cdsList.Edit;
       cdsList.FieldbyName('A').AsInteger := 1;
       cdsList.Post;
       Key := 0;
       btnOkClick(nil);
     end;
  if Key=VK_SPACE then
     begin
       if MultiSelect then
          begin
            if cdsList.IsEmpty then Exit;
            cdsList.Edit;
            cdsList.FieldbyName('A').AsInteger := 1;
            cdsList.Post;
          end
       else
          DBGridEh1DblClick(nil);
     end;
end;

procedure TframeSelectGoods.RzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then DBGridEh1.SetFocus;
end;

procedure TframeSelectGoods.Rb1Click(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.Rb2Click(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TframeSelectGoods.N1Click(Sender: TObject);
begin
  inherited;
  while not IsEnd do Open(MaxID);
end;

procedure TframeSelectGoods.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) AND (KEY<>VK_CONTROL) then
     edtSearch.SetFocus;
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TframeSelectGoods.FormCreate(Sender: TObject);
begin
  inherited;
  DBGridEh1.Columns[3].Visible := ShopGlobal.GetChkRight('600041');
  N2.Enabled:=False;
  N3.Enabled:=False;
  N4.Enabled:=False;
end;

procedure TframeSelectGoods.CheckBox1Click(Sender: TObject);
begin
  inherited;
  MultiSelect := CheckBox1.Checked;
  N2.Visible := CheckBox1.Checked;
  N3.Visible := CheckBox1.Checked;
  N4.Visible := CheckBox1.Checked;
end;

procedure TframeSelectGoods.N2Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 1;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectGoods.N3Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        if cdsList.FieldbyName('A').AsInteger = 0 then
           cdsList.FieldbyName('A').AsInteger := 1
        else
           cdsList.FieldbyName('A').AsInteger := 0    ;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectGoods.N4Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 0;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectGoods.LoadBrandInfo;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.Close;
    rs.CommandText := 'select CODE_ID as SORT_ID,CODE_NAME as SORT_NAME,null as PID from PUB_CODE_INFO where CODE_TYPE=6 and CODE_ID in (select distinct BRAND from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''') order by CODE_ID';
    Factor.Open(rs);
    CreateParantTree(rs, RzTree, 'SORT_ID', 'SORT_NAME', 'PID');
    AddRoot(rzTree,'全部商品');
  finally
    if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
    rs.free;
  end;
end;

procedure TframeSelectGoods.LoadLevelSort;
var rs: TADODataSet;
begin
  try
    rs := Global.GetADODataSetFromName('PUB_GOODSSORT');
    CreateLevelTree(rs, rzTree, '3333333333', 'SORT_ID', 'SORT_NAME', 'LEVEL_ID', 1, 3);
    AddRoot(rzTree,'全部商品');
  finally
    if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
  end;
end;

procedure TframeSelectGoods.LoadProvInfo;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select CLIENT_ID as SORT_ID, CLIENT_NAME as SORT_NAME,null as PID from BAS_CLIENTINFO where CLIENT_ID in (select distinct PROVIDE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyID+''')';
    Factor.Open(rs);
    CreateParantTree(rs, RzTree, 'SORT_ID', 'SORT_NAME', 'PID');
    AddRoot(rzTree,'全部商品');
  finally
    if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
    rs.free;
  end;
end;

procedure TframeSelectGoods.fndGODS_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  case fndGODS_FLAG1.ItemIndex of
  0:LoadLevelSort;
  1:LoadBrandInfo;
  2:LoadProvInfo;
  end;
end;

procedure TframeSelectGoods.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N2Click(nil);
end;

end.
