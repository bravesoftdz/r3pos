unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, RzLabel, RzButton, Grids,
  DBGridEh, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, StdCtrls,
  ComCtrls, RzTreeVw, RzBmpBtn,ZDataSet, DB, ZAbstractRODataset,ZBase,
  ZAbstractDataset, RzBckgnd, RzBorder, cxRadioGroup;

type
  TfrmCustomer = class(TfrmWebToolForm)
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    btnNewSort: TRzBitBtn;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton3: TRzToolButton;
    RzToolButton4: TRzToolButton;
    RzPanel8: TRzPanel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzPanel15: TRzPanel;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    serachText: TEdit;
    lblCaption: TRzLabel;
    btnFind: TRzBmpButton;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton7: TRzBmpButton;
    RzPanel1: TRzPanel;
    cdsList: TZQuery;
    dsList: TDataSource;
    EditPanel: TRzPanel;
    barcode_panel_left_line: TImage;
    barcode_panel_right_line: TImage;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    barcode_top: TRzPanel;
    barcode_panel_top_left: TImage;
    barcode_panel_top_right: TImage;
    barcode_panel_top_line: TImage;
    barcode_botton: TRzPanel;
    barcode_panel_bottom_line: TImage;
    barcodeb_panel_right_line: TImage;
    barcodeb_panel_left_line: TImage;
    RzPanel9: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel17: TRzLabel;
    RzPanel10: TRzPanel;
    Image2: TImage;
    edtBK_BARCODE: TRzPanel;
    RzPanel24: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel6: TRzLabel;
    RzPanel12: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel3: TRzLabel;
    edtBK_GODS_NAME: TRzPanel;
    RzPanel30: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel2: TRzLabel;
    edtBK_CALC_UNITS: TRzPanel;
    RzPanel32: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel4: TRzLabel;
    RzPanel14: TRzPanel;
    RzPanel16: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel5: TRzLabel;
    RzPanel17: TRzPanel;
    RzPanel18: TRzPanel;
    RzBackground6: TRzBackground;
    RzLabel7: TRzLabel;
    RzPanel19: TRzPanel;
    RzPanel20: TRzPanel;
    RzBackground8: TRzBackground;
    RzLabel8: TRzLabel;
    RzPanel21: TRzPanel;
    RzPanel22: TRzPanel;
    RzBackground9: TRzBackground;
    RzLabel9: TRzLabel;
    RzPanel23: TRzPanel;
    RzPanel25: TRzPanel;
    RzBackground10: TRzBackground;
    RzLabel10: TRzLabel;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    RzBackground11: TRzBackground;
    RzLabel11: TRzLabel;
    RzBorder1: TRzBorder;
    edtCUST_CODE: TcxTextEdit;
    edtCUST_NAME: TcxTextEdit;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    cxRadioButton3: TcxRadioButton;
    RzPanel28: TRzPanel;
    RzPanel29: TRzPanel;
    RzBackground12: TRzBackground;
    RzLabel1: TRzLabel;
    cmbBIRTHDAY: TcxDateEdit;
    edtMOVE_TELE: TcxTextEdit;
    edtQQ: TcxTextEdit;
    edtEMAIL: TcxTextEdit;
    cmbFAMI_ADDR: TcxTextEdit;
    cmbINTEGRAL: TcxTextEdit;
    cmbBALANCE: TcxTextEdit;
    RzPanel31: TRzPanel;
    RzBackground13: TRzBackground;
    RzLabel12: TRzLabel;
    RzPanel33: TRzPanel;
    RzBackground14: TRzBackground;
    RzLabel13: TRzLabel;
    cmbPRICE_ID: TzrComboBoxList;
    cdsCustomer: TZQuery;
    fndPRICE_ID: TzrComboBoxList;
    procedure RzBmpButton2Click(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure serachTextChange(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
  private
    { Private declarations }
    searchTxt:string;
    FdbState: TDataSetState;
    AObj:TRecord_;
    function FindColumn(fieldname:string):TColumnEh;
    procedure SetdbState(const Value: TDataSetState);
    procedure ReadInfo;
    procedure WriteInfo;
  public
    { Public declarations }
    procedure CreatePriceGrade;
    procedure OpenInfo(custId:string);
    procedure SaveInfo;
    procedure DeleteInfo(custId:string);
    procedure UpdateGrade(custId:string);
    procedure NewInfo;

    procedure Open;
    procedure showForm;override;
    property dbState:TDataSetState read FdbState write SetdbState;
  end;

var
  frmCustomer: TfrmCustomer;

implementation
uses udllGlobal,uTreeUtil,udataFactory,utokenFactory,udllShopUtil;
{$R *.dfm}

{ TfrmCustomer }

procedure TfrmCustomer.CreatePriceGrade;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  cmbPRICE_ID.DataSet := rs;
  fndPRICE_ID.DataSet := rs;
  CreateParantTree(rs,rzTree,'PRICE_ID','PRICE_NAME','TENANT_ID');
  AddRoot(rzTree,'所有会员');
  Column := FindColumn('PRICE_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('PRICE_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('PRICE_NAME').AsString);  
      rs.Next;
    end;
end;

function TfrmCustomer.FindColumn(fieldname: string): TColumnEh;
var
  i:integer;
begin
  for i:=0 to DBGridEh1.Columns.Count-1 do
    begin
      if lowercase(DBGridEh1.Columns[i].FieldName)=lowercase(fieldname) then
         begin
           result := DBGridEh1.Columns[i];
           break;
         end;
    end;
end;

procedure TfrmCustomer.Open;
begin
  cdsList.Close;
  cdsList.SQL.Text := 'select 0 as A,A.TENANT_ID,A.CUST_ID,CUST_NAME,CUST_CODE,MOVE_TELE as MOBILE,BIRTHDAY,A.PRICE_ID,B.INTEGRAL,B.BALANCE '+
     'from PUB_CUSTOMER A,PUB_IC_INFO B '+
     'where A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID and B.UNION_ID=''#'' and A.TENANT_ID=:TENANT_ID';
  cdsList.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level>0) then
     begin
       cdsList.SQL.Text := cdsList.SQL.Text + ' and a.PRICE_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('PRICE_ID').AsString+'''';
     end;
  if trim(searchTxt)<>'' then
     cdsList.SQL.Text := 'select j.* from ('+cdsList.SQL.Text+') j '+
     'where CUST_NAME like ''%'+trim(searchTxt)+'%'' or CUST_CODE like ''%'+trim(searchTxt)+'%'' or MOVE_TELE like ''%'+trim(searchTxt)+'%''';
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by CUST_CODE';
  dataFactory.Open(cdsList);
end;

procedure TfrmCustomer.showForm;
begin
  inherited;
  CreatePriceGrade;
  Open;
end;

procedure TfrmCustomer.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmCustomer.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.CanFocus then Open;

end;

procedure TfrmCustomer.serachTextChange(Sender: TObject);
begin
  inherited;
  if serachText.Focused then searchTxt := serachText.Text;

end;

procedure TfrmCustomer.serachTextEnter(Sender: TObject);
begin
  inherited;
  serachText.Text := searchTxt;
  serachText.SelectAll;

end;

procedure TfrmCustomer.serachTextExit(Sender: TObject);
begin
  inherited;
  if searchTxt='' then serachText.Text := serachText.Hint;

end;

procedure TfrmCustomer.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  rowToolNav.Visible := not cdsList.IsEmpty;
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top-1);
       end
    else
       DBGridEh1.Canvas.Brush.Color := clWhite;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmCustomer.DeleteInfo(custId: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    dataFactory.BeginBatch;
    try
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       Params.ParamByName('CUST_ID').AsString := custId;
       dataFactory.AddBatch(cdsCustomer,'TCustomerV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;

    if not cdsCustomer.IsEmpty then cdsCustomer.Delete;
    dataFactory.BeginBatch;
    try
       dataFactory.AddBatch(cdsCustomer,'TCustomerV60',nil);
       dataFactory.CommitBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomer.OpenInfo(custId: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    dataFactory.BeginBatch;
    try
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       Params.ParamByName('CUST_ID').AsString := custId;
       dataFactory.AddBatch(cdsCustomer,'TCustomerV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
    ReadInfo;
    dbState := dsEdit;
    EditPanel.Visible := true;
    if edtCUST_CODE.CanFocus then edtCUST_CODE.SetFocus;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomer.SaveInfo;
begin
  WriteInfo;
  dataFactory.BeginBatch;
  try
     dataFactory.AddBatch(cdsCustomer,'TCustomerV60',nil);
     dataFactory.CommitBatch;
  except
     dataFactory.CancelBatch;
     Raise;
  end;
  if cdsList.Locate('CUST_ID',AObj.FieldbyName('CUST_ID').AsString,[]) then
     begin
       cdsList.Edit;
       cdsList.FieldByName('CUST_NAME').AsString := edtCUST_NAME.Text;
       cdsList.FieldByName('CUST_CODE').AsString := edtCUST_CODE.Text;
       cdsList.FieldByName('PRICE_ID').AsString := cmbPRICE_ID.asString;
       cdsList.FieldByName('MOVE_TELE').AsString := edtMOVE_TELE.Text;
       cdsList.FieldByName('BIRTHDAY').AsString := formatDatetime('YYYY-MM-DD',cmbBIRTHDAY.Date);
       cdsList.Post;
     end;
end;

procedure TfrmCustomer.UpdateGrade(custId: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    dataFactory.BeginBatch;
    try
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       Params.ParamByName('CUST_ID').AsString := custId;
       dataFactory.AddBatch(cdsCustomer,'TCustomerV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;

    cdsCustomer.FieldbyName('PRICE_ID').asString := fndPRICE_ID.asString;
    dataFactory.BeginBatch;
    try
       dataFactory.AddBatch(cdsCustomer,'TCustomerV60',nil);
       dataFactory.CommitBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomer.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
end;

procedure TfrmCustomer.ReadInfo;
begin
  AObj.ReadFromDataSet(cdsCustomer);
  ReadFromObject(AObj,self);

end;

procedure TfrmCustomer.WriteInfo;
begin
  WriteToObject(AObj,self);

end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;

end;

procedure TfrmCustomer.FormDestroy(Sender: TObject);
begin
  AObj.Free;
  inherited;

end;

procedure TfrmCustomer.RzToolButton2Click(Sender: TObject);
begin
  inherited;
  openinfo(cdsList.FieldbyName('CUST_ID').AsString);

end;

procedure TfrmCustomer.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  openinfo(cdsList.FieldbyName('CUST_ID').AsString);
end;

procedure TfrmCustomer.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  SaveInfo;
  EditPanel.Visible := false;

end;

procedure TfrmCustomer.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  EditPanel.Visible := false;

end;

procedure TfrmCustomer.RzBmpButton7Click(Sender: TObject);
var
  gid:string;
begin
  inherited;
  if fndPRICE_ID.asString='' then Raise Exception.Create('请选择更改的目标等级。');
  if MessageBox(Handle,'是否修改选中的所有会员等级？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  gid := cdsList.FieldbyName('CUST_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldbyName('A').AsString='1' then
           begin
             UpdateGrade(cdsList.FieldbyName('CUST_ID').AsString);
             cdsList.Edit;
             cdsList.FieldbyName('PRICE_ID').AsString := fndPRICE_ID.AsString;
             cdsList.Post;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('CUST_ID',gid,[]);
    cdsList.EnableControls;
  end;
end;

procedure TfrmCustomer.RzBmpButton6Click(Sender: TObject);
var
  gid:string;
begin
  inherited;
  if MessageBox(Handle,'是否删除选中的所有会员？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  gid := cdsList.FieldbyName('CUST_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldbyName('A').AsString='1' then
           begin
             DeleteInfo(cdsList.FieldbyName('CUST_ID').AsString);
             cdsList.Delete;
           end
        else
           cdsList.Next;
      end;
  finally
    cdsList.Locate('CUST_ID',gid,[]);
    cdsList.EnableControls;
  end;
end;

procedure TfrmCustomer.NewInfo;
begin
  OpenInfo('');
  dbState := dsInsert;
end;

procedure TfrmCustomer.btnFindClick(Sender: TObject);
begin
  inherited;
  NewInfo;
end;

initialization
  RegisterClass(TfrmCustomer);
finalization
  UnRegisterClass(TfrmCustomer);
end.
