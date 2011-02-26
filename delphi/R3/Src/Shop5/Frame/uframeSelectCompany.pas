unit uframeSelectCompany;

interface
                ]
                
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, RzButton, DB, cxControls, cxContainer, cxEdit,
  cxTextEdit, StdCtrls, cxMaskEdit, cxDropDownEdit, zBase, cxButtonEdit,
  zrComboBoxList, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TframeSelectCompany = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    DataSource1: TDataSource;
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    Label2: TLabel;
    Label3: TLabel;
    fndSHOP_TYPE: TcxComboBox;
    fndREGION_NAME: TzrComboBoxList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    cdsList: TZQuery;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnOkClick(Sender: TObject);
    procedure fndCOMP_TYPEPropertiesChange(Sender: TObject);
    procedure edtGROUP_NAMEPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fndREGION_NAMESaveValue(Sender: TObject);
    procedure fndREGION_NAMEClearValue(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
  private
    FCanMultSelect: boolean;
    procedure SetCanMultSelect(const Value: boolean);
    { Private declarations }
  public
    { Public declarations }
    ds:TRecordList;
    procedure Open;
    procedure InitForm;
    class function PrcCompList(Owner:TForm;MultSelect:boolean;var rs:TRecordList):boolean;
    property CanMultSelect:boolean read FCanMultSelect write SetCanMultSelect;
  end;


implementation

uses uGlobal,uCtrlUtil;

{$R *.dfm}

{ TfrmPrcCompList }

procedure TframeSelectCompany.Open;
var
  lid,w:string;
begin
  if fndSHOP_TYPE.ItemIndex >0 then
    w := w + ' and SHOP_TYPE='+TRecord_(fndSHOP_TYPE.Properties.Items.Objects[fndSHOP_TYPE.ItemIndex]).FieldbyName('CODE_ID').asString;
  if fndREGION_NAME.AsString <> '' then
    w := w + ' and REGION_ID='''+fndREGION_NAME.AsString+'''';

  cdsList.Close;
  cdsList.SQL.Text:= 'select 0 as A,SHOP_ID,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,SEQ_NO '+
    ' from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+w+' order by SEQ_NO';
  if cdsList.Params.FindParam('TENANT_ID')<>nil then cdsList.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  Factor.Open(cdsList);
end;

class function TframeSelectCompany.PrcCompList(Owner:TForm;MultSelect:boolean;var rs:TRecordList): boolean;
begin
  with TframeSelectCompany.Create(Owner) do
    begin
      try
        ds := rs;
        InitForm;
        CanMultSelect := MultSelect;
        Open;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TframeSelectCompany.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeSelectCompany.FormCreate(Sender: TObject);
var tmp:TZQuery;
begin
  DBGridEh1.FieldColumns['TENANT_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['TENANT_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['TENANT_ID'].KeyList.Add(inttostr(Global.TENANT_ID));
  DBGridEh1.FieldColumns['TENANT_ID'].PickList.Add(Global.TENANT_NAME);     
  {tmp := Global.GetZQueryFromName('CA_SHOP_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['UPCOMP_ID'].KeyList.Add(tmp.Fields[0].asstring);
    DBGridEh1.FieldColumns['UPCOMP_ID'].PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;}
  TDbGridEhSort.InitForm(self);
end;

procedure TframeSelectCompany.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TframeSelectCompany.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = 'SEQ_NO') or (Column.FieldName = 'A') then
     Background := clBtnFace;
end;

procedure TframeSelectCompany.InitForm;
begin
  fndSHOP_TYPE.Properties.Items.Insert(0,'全部');
  fndSHOP_TYPE.ItemIndex := 0; 
  fndREGION_NAME.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');    
end;

procedure TframeSelectCompany.btnOkClick(Sender: TObject);
var
  rs:TRecord_;
begin
  inherited;
  ds.Clear;
  if CanMultSelect then
  begin
    if cdsList.State<>dsEdit then cdsList.Edit;
    cdsList.Post;
    if cdsList.IsEmpty then Raise Exception.Create('请选择门店后再确认');
    cdsList.First;
    while not cdsList.Eof do
    begin
      if trim(cdsList.FieldByName('A').AsString)='1' then
      begin
        rs := TRecord_.Create;
        rs.ReadFromDataSet(cdsList);
        ds.AddRecord(rs);
      end;
      cdsList.Next;
    end;
  end else
  begin
    if cdsList.IsEmpty then Raise Exception.Create('请选择门店后再确认');
    rs := TRecord_.Create;
    rs.ReadFromDataSet(cdsList);
    ds.AddRecord(rs);
  end;
  self.ModalResult := MROK;
end;

procedure TframeSelectCompany.SetCanMultSelect(const Value: boolean);
begin
  FCanMultSelect := Value;
  DBGridEh1.Columns[0].Visible := Value; 
end;

procedure TframeSelectCompany.fndCOMP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TframeSelectCompany.edtGROUP_NAMEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TframeSelectCompany.FormShow(Sender: TObject);
begin
  inherited;
  DBGridEh1.ReadOnly := false;
end;

procedure TframeSelectCompany.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self); 
  inherited;
end;

procedure TframeSelectCompany.fndREGION_NAMESaveValue(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TframeSelectCompany.fndREGION_NAMEClearValue(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TframeSelectCompany.N1Click(Sender: TObject);
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

procedure TframeSelectCompany.N2Click(Sender: TObject);
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
           cdsList.FieldbyName('A').AsInteger := 0;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeSelectCompany.N3Click(Sender: TObject);
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

procedure TframeSelectCompany.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
     begin
        cdsList.Edit;
        if cdsList.FieldbyName('A').AsInteger = 0 then
           cdsList.FieldbyName('A').AsInteger := 1
        else
           cdsList.FieldbyName('A').AsInteger := 1;
        cdsList.Post;
     end;
  if Key=13 then btnOk.OnClick(btnOk);
end;

procedure TframeSelectCompany.DBGridEh1DblClick(Sender: TObject);
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
          btnOkClick(nil);
     end;

end;

procedure TframeSelectCompany.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N1Click(nil);
end;

end.
