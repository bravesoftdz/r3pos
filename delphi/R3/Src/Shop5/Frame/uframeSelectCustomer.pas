unit uframeSelectCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, cxRadioGroup, DB, ZBase,
  cxMaskEdit, cxDropDownEdit, cxButtonEdit, zrComboBoxList,
  ZAbstractRODataset, ZDataset, ZAbstractDataset;

type
  TframeSelectCustomer = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzPanel4: TRzPanel;
    DBGridEh1: TDBGridEh;
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    edtSearch: TcxTextEdit;
    btnFilter: TRzBitBtn;
    dsList: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label1: TLabel;
    edtFIND_FLAG: TcxComboBox;
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
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
  private
    { Private declarations }
    IsEnd: boolean;
    MaxId:string;
    FMultiSelect: boolean;
    FCustType: integer;
    procedure InitGrid;
    function EncodeSQL(id:string):string;
    procedure SetMultiSelect(const Value: boolean);
    procedure SetCustType(const Value: integer);
  public
    { Public declarations }
    procedure Open(Id:string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
    //0 所有，1企业客户 2会员
    property CustType:integer read FCustType write SetCustType;
  end;

implementation
uses uCtrlUtil, uGlobal, uTreeUtil, ObjCommon;
{$R *.dfm}

{ TframeSelectGoods }

constructor TframeSelectCustomer.Create(AOwner: TComponent);
begin
  inherited;
  CustType := 0;
  MultiSelect := false;
  InitGrid;
  TDbGridEhSort.InitForm(self);
end;

destructor TframeSelectCustomer.Destroy;
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TframeSelectCustomer.InitGrid;
begin
  inherited;
end;

procedure TframeSelectCustomer.Open(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('CLIENT_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsList.LoadFromStream(sm);
       cdsList.IndexFieldNames := 'CLIENT_CODE';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    sm.Free;
    cdsList.EnableControls;
    rs.Free;
  end;
end;

function TframeSelectCustomer.EncodeSQL(id: string): string;
var w:string;
begin
  w := 'where COMM not in (''12'',''02'')';
  case CustType of
  1:w := w + ' and CLIENT_TYPE in (0)';
  2:w := w + ' and CLIENT_TYPE in (2)';
  end;
  if id<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + 'CLIENT_ID>'''+id+'''';
     end;

  if trim(edtSearch.Text)<>'' then
     begin
      if w<>'' then w := w + ' and ';
      case  edtFIND_FLAG.ItemIndex of
      0:w := w + '(CLIENT_CODE like ''%'+trim(edtSearch.Text)+'%'' or CLIENT_NAME like ''%'+trim(edtSearch.Text)+'%'' or CLIENT_SPELL like ''%'+trim(edtSearch.Text)+'%'' or IC_CARDNO like ''%'+trim(edtSearch.Text)+'%'' or LICENSE_CODE like ''%'+trim(edtSearch.Text)+'%'' or TELEPHONE2 like ''%'+trim(edtSearch.Text)+'%'' or ADDRESS like ''%'+trim(edtSearch.Text)+'%'')';
      1:w := w + '(CLIENT_CODE like ''%'+trim(edtSearch.Text)+'%'')';
      2:w := w + '(CLIENT_NAME like ''%'+trim(edtSearch.Text)+'%'' or CLIENT_SPELL like ''%'+trim(edtSearch.Text)+'%'')';
      3:w := w + '(TELEPHONE2 like ''%'+trim(edtSearch.Text)+'%'')';
      4:w := w + '(LICENSE_CODE like ''%'+trim(edtSearch.Text)+'%'')';
      5:w := w + '(IC_CARDNO like ''%'+trim(edtSearch.Text)+'%'')';
      6:w := w + '(ADDRESS like ''%'+trim(edtSearch.Text)+'%'')';
      end;
     end;

  result :=
           'select jp.*,p.PRICE_NAME from ( '+
           'select jc.*,c.SHOP_NAME from ( '+
           'select 0 as A,TENANT_ID,SHOP_ID,PRICE_ID,CLIENT_ID,CLIENT_SPELL,IC_CARDNO,CLIENT_CODE,CLIENT_NAME,SND_DATE,ADDRESS,TELEPHONE2,LICENSE_CODE from VIW_CUSTOMER jc'+w+
           'left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID) jp '+
           'left outer join PUB_PRICEGRADE p on jp.TENANT_ID=p.TENANT_ID and jp.PRICE_ID=p.PRICE_ID ';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by CLIENT_ID';
  4:result :=
       'select * from ('+
       'select * from ('+result+') order by CLIENT_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') order by CLIENT_ID limit 600';
  else
    result := 'select * from ('+result+') order by CLIENT_ID';
  end;
end;

procedure TframeSelectCustomer.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TframeSelectCustomer.btnFilterClick(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectCustomer.RzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TframeSelectCustomer.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeSelectCustomer.btnOkClick(Sender: TObject);
procedure SetCurrent;
begin
  if cdsList.IsEmpty then Exit;
  cdsList.Edit;
  cdsList.FieldByName('A').AsInteger :=1 ;
  cdsList.Post;
end;
var 
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

procedure TframeSelectCustomer.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
  DBGridEh1.Columns[0].Visible := Value;
  N2.Enabled:=Value;
  N3.Enabled:=Value;
  N4.Enabled:=Value;
end;

procedure TframeSelectCustomer.DBGridEh1DblClick(Sender: TObject);
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

procedure TframeSelectCustomer.FormShow(Sender: TObject);
begin
  inherited;
  edtFIND_FLAG.ItemIndex := 1;
  if trim(edtSearch.Text)<>'' then
     begin
       edtFIND_FLAG.ItemIndex := 0;
       Open('');
     end;
end;

procedure TframeSelectCustomer.edtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
//  if Key=VK_UP then cdsList.Prior;
//  if Key=VK_DOWN then cdsList.Next;
  if Key=VK_RETURN then
     begin
       Open('');
       if not cdsList.IsEmpty then
//       edtSearch.Text := '';
          DBGridEh1.SetFocus
       else
          edtSearch.SetFocus;
       Key := 0;
     end;

end;

procedure TframeSelectCustomer.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=13 then
     begin
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
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE)  and (Key<>VK_SPACE) and (Key<>VK_TAB) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) and (KEY<>VK_CONTROL) then
     edtSearch.SetFocus;
end;

procedure TframeSelectCustomer.RzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then DBGridEh1.SetFocus;
end;

procedure TframeSelectCustomer.Rb1Click(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectCustomer.Rb2Click(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TframeSelectCustomer.N1Click(Sender: TObject);
begin
  inherited;
  while not IsEnd do Open(MaxID);
end;

procedure TframeSelectCustomer.FormCreate(Sender: TObject);
begin
  inherited;
  N2.Enabled:=False;
  N3.Enabled:=False;
  N4.Enabled:=False;
end;

procedure TframeSelectCustomer.SetCustType(const Value: integer);
begin
  FCustType := Value;
end;

procedure TframeSelectCustomer.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not edtSearch.Focused then
     begin
       inherited;
     end;

end;

procedure TframeSelectCustomer.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsList.Active then exit;
  if cdsList.IsEmpty then exit;
  while not IsEnd do Open(MaxID);
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
    begin
      cdsList.Edit;
      cdsList.FieldByName('A').AsInteger:=1;
      cdsList.Post;
      cdsList.Next;
    end;
  finally
    cdsList.First;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectCustomer.N3Click(Sender: TObject);
begin
  inherited;
  if not cdsList.Active then exit;
  if cdsList.IsEmpty then exit;
  while not IsEnd do Open(MaxID); 
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
    begin
      cdsList.Edit;
      if cdsList.FieldByName('A').AsInteger=1 then
         cdsList.FieldByName('A').AsInteger:=0
      else
         cdsList.FieldByName('A').AsInteger:=1;
      cdsList.Post;
      cdsList.Next;
    end;
  finally
    cdsList.First;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectCustomer.N4Click(Sender: TObject);
begin
  inherited;
  if not cdsList.Active then exit;
  if cdsList.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
    begin
      cdsList.Edit;
      cdsList.FieldByName('A').AsInteger:=0;
      cdsList.Post;
      cdsList.Next;
    end;
  finally
    cdsList.First;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectCustomer.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N2Click(nil);
end;

end.
