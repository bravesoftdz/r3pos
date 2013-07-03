unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, RzLabel, RzButton, Grids,
  DBGridEh, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, StdCtrls,
  ComCtrls, RzTreeVw, RzBmpBtn,ZDataSet, DB, ZAbstractRODataset,ZBase,
  ZAbstractDataset, RzBckgnd, RzBorder, cxRadioGroup, Menus, PrnDbgeh,
  pngimage;

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
    toolDelete: TRzToolButton;
    toolEdit: TRzToolButton;
    toolSpacer: TRzSpacer;
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
    btnSave: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    RzPanel9: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel17: TRzLabel;
    RzPanel10: TRzPanel;
    Image2: TImage;
    edtBK_CUST_NAME: TRzPanel;
    RzPanel24: TRzPanel;
    RzLabel6: TRzLabel;
    edtBK_CUST_CODE: TRzPanel;
    RzPanel30: TRzPanel;
    RzLabel2: TRzLabel;
    edtBK_MOVE_TELE: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel4: TRzLabel;
    edtBK_BIRTHDAY: TRzPanel;
    RzPanel16: TRzPanel;
    RzLabel5: TRzLabel;
    RzPanel17: TRzPanel;
    RzPanel18: TRzPanel;
    RzLabel7: TRzLabel;
    RzPanel19: TRzPanel;
    RzPanel20: TRzPanel;
    RzLabel8: TRzLabel;
    edtBK_QQ: TRzPanel;
    RzPanel22: TRzPanel;
    RzLabel9: TRzLabel;
    edtBK_MSN: TRzPanel;
    RzPanel25: TRzPanel;
    RzLabel10: TRzLabel;
    edtBK_FAMI_ADDR: TRzPanel;
    RzPanel27: TRzPanel;
    RzLabel11: TRzLabel;
    RzBorder1: TRzBorder;
    edtCUST_CODE: TcxTextEdit;
    edtCUST_NAME: TcxTextEdit;
    edtBK_PRICE_ID: TRzPanel;
    RzPanel29: TRzPanel;
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
    RzPanel34: TRzPanel;
    RzLabel16: TRzLabel;
    edtBK_SEX: TRzPanel;
    RzPanel36: TRzPanel;
    RzLabel14: TRzLabel;
    edtSEX1: TcxRadioButton;
    edtSEX3: TcxRadioButton;
    edtSEX2: TcxRadioButton;
    edtCUST_SPELL: TcxTextEdit;
    PriceGradeMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    red1: TLabel;
    red2: TLabel;
    procedure RzBmpButton2Click(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure serachTextChange(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure toolEditClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure RzLabel13Click(Sender: TObject);
    procedure RzLabel17Click(Sender: TObject);
    procedure RzLabel12Click(Sender: TObject);
    procedure edtCUST_NAMEPropertiesChange(Sender: TObject);
    procedure toolDeleteClick(Sender: TObject);
    procedure btnNewSortClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure serachTextKeyPress(Sender: TObject; var Key: Char);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure ExcelImportClick(Sender: TObject);
  private
    searchTxt:string;
    FdbState: TDataSetState;
    AObj:TRecord_;
    function FindColumn(fieldname:string):TColumnEh;
    procedure SetdbState(const Value: TDataSetState);
    procedure ReadInfo;
    procedure WriteInfo;
    procedure DBGridPrint;
  public
    procedure CreatePriceGrade;
    procedure OpenInfo(custId:string);
    procedure SaveInfo;
    procedure SaveLocalInfo;
    procedure DeleteInfo(custId:string);
    procedure unDeleteInfo(custId:string);
    procedure UpdateGrade(custId:string);
    procedure NewInfo;
    procedure Open;
    procedure showForm;override;
    property dbState:TDataSetState read FdbState write SetdbState;
  end;

var frmCustomer: TfrmCustomer;

implementation

uses udllGlobal,uTreeUtil,udataFactory,utokenFactory,udllShopUtil,udllDsUtil,uFnUtil,ufrmPriceGrade,
     ufrmDBGridPreview,ufrmCustomerExcel;

{$R *.dfm}

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
   rzTree.Items.Add(nil,'回收站');
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
  cdsList.SQL.Text := 'select 0 as A,A.TENANT_ID,A.CUST_ID,CUST_NAME,CUST_CODE,MOVE_TELE,BIRTHDAY,A.PRICE_ID,A.COMM,B.INTEGRAL,B.BALANCE '+
     'from PUB_CUSTOMER A,PUB_IC_INFO B '+
     'where A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID and B.UNION_ID=''#'' and A.TENANT_ID=:TENANT_ID ';
  cdsList.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level=0) then
     begin
       if rzTree.Selected.Text='回收站' then
          cdsList.SQL.Text := cdsList.SQL.Text + ' and a.COMM in (''12'',''02'') '
       else
          cdsList.SQL.Text := cdsList.SQL.Text + ' and a.COMM not in (''12'',''02'') ';
     end
  else
     cdsList.SQL.Text := cdsList.SQL.Text + ' and a.COMM not in (''12'',''02'') ';
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
  rowToolNav.Visible := not cdsList.IsEmpty;
  toolSpacer.Visible := Node.Text<>'回收站';
  toolEdit.Visible := Node.Text<>'回收站';
  if toolEdit.Visible then
     toolDelete.Caption := '删除'
  else
     toolDelete.Caption := '还原';
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
    (gdFocused in State) or not DBGridEh1.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top-1);
       end
    else
       begin
         DBGridEh1.Canvas.Font.Color := clBlack;
         DBGridEh1.Canvas.Brush.Color := clWhite;
       end;
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
  tmpCustomer:TZQuery;
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

  if dataFactory.iDbType <> 5 then
  begin
    tmpCustomer := TZQuery.Create(nil);
    Params := TftParamList.Create;
    dataFactory.MoveToSqlite;
    try
      dataFactory.BeginBatch;
      try
         Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
         Params.ParamByName('CUST_ID').AsString := custId;
         dataFactory.AddBatch(tmpCustomer,'TCustomerV60',Params);
         dataFactory.OpenBatch;
      except
         dataFactory.CancelBatch;
         Raise;
      end;
      if not tmpCustomer.IsEmpty then tmpCustomer.Delete;
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      tmpCustomer.Free;
      Params.Free;
    end;
  end;
  dllGlobal.GetZQueryFromName('PUB_CUSTOMER').Close;
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
    if not cdsCustomer.IsEmpty and (cdsCustomer.FieldByName('COMM').AsString[2]='2') then
       dbState := dsBrowse
    else
       dbState := dsEdit;
    EditPanel.Visible := true;
    if edtCUST_CODE.CanFocus then edtCUST_CODE.SetFocus;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomer.SaveInfo;
begin
  if trim(edtCUST_CODE.Text) = '' then
     begin
       if edtCUST_CODE.CanFocus then edtCUST_CODE.SetFocus;
       Raise Exception.Create('会员卡号不能为空...');
     end;
  if trim(edtCUST_NAME.Text) = '' then
     begin
       if edtCUST_NAME.CanFocus then edtCUST_NAME.SetFocus;
       Raise Exception.Create('会员名称不能为空...');
     end;
  if trim(cmbPRICE_ID.AsString) = '' then
     begin
       if cmbPRICE_ID.CanFocus then cmbPRICE_ID.SetFocus;
       Raise Exception.Create('会员等级不能为空...');
     end;
  WriteInfo;
  dataFactory.BeginBatch;
  try
     dataFactory.AddBatch(cdsCustomer,'TCustomerV60',nil);
     dataFactory.CommitBatch;
  except
     dataFactory.CancelBatch;
     Raise;
  end;

  SaveLocalInfo;

  dllGlobal.GetZQueryFromName('PUB_CUSTOMER').Close;

  if cdsList.Locate('CUST_ID',AObj.FieldbyName('CUST_ID').AsString,[]) then
     begin
       cdsList.Edit;
       cdsList.FieldByName('CUST_NAME').AsString := edtCUST_NAME.Text;
       cdsList.FieldByName('CUST_CODE').AsString := edtCUST_CODE.Text;
       cdsList.FieldByName('PRICE_ID').AsString := cmbPRICE_ID.asString;
       cdsList.FieldByName('MOVE_TELE').AsString := edtMOVE_TELE.Text;
       if trim(cmbBIRTHDAY.Text) <> '' then
          cdsList.FieldByName('BIRTHDAY').AsString := FormatDatetime('YYYY-MM-DD',cmbBIRTHDAY.Date)
       else
          cdsList.FieldByName('BIRTHDAY').AsString := '';
       cdsList.Post;
     end;
end;

procedure TfrmCustomer.UpdateGrade(custId: string);
var Params:TftParamList;
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

    cdsCustomer.Edit;
    cdsCustomer.FieldbyName('PRICE_ID').asString := fndPRICE_ID.asString;
    cdsCustomer.Post;

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

  SaveLocalInfo;

  dllGlobal.GetZQueryFromName('PUB_CUSTOMER').Close;
end;

procedure TfrmCustomer.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
  btnSave.Visible := dbState <> dsBrowse;
end;

procedure TfrmCustomer.ReadInfo;
begin
  AObj.ReadFromDataSet(cdsCustomer);
  ReadFromObject(AObj,self);
  case AObj.FieldbyName('SEX').AsInteger of
  1:edtSEX1.Checked := true;
  2:edtSEX2.Checked := true;
  else
    edtSEX3.Checked := true;
  end;
end;

procedure TfrmCustomer.WriteInfo;
var rs:TZQuery;
begin
  WriteToObject(AObj,self);
  if edtSEX1.Checked then AObj.FieldbyName('SEX').AsInteger := 1;
  if edtSEX2.Checked then AObj.FieldbyName('SEX').AsInteger := 2;
  if edtSEX3.Checked then AObj.FieldbyName('SEX').AsInteger := 3;
  AObj.FieldbyName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  if AObj.FieldbyName('REGION_ID').AsString='' then
     begin
       rs := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
       if rs.Locate('SHOP_ID',token.shopId,[]) then
          AObj.FieldbyName('REGION_ID').AsString := rs.FieldbyName('REGION_ID').AsString
       else
          AObj.FieldbyName('REGION_ID').AsString := '999999';
     end;
  if AObj.FieldbyName('SHOP_ID').AsString='' then AObj.FieldbyName('SHOP_ID').AsString := token.shopId;
  if AObj.FieldbyName('CUST_ID').AsString='' then AObj.FieldbyName('CUST_ID').AsString := TSequence.NewId();
  if AObj.FieldbyName('CREA_USER').AsString='' then AObj.FieldbyName('CREA_USER').AsString := token.userId;
  if AObj.FieldbyName('CREA_DATE').AsString='' then AObj.FieldbyName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD',now());
  cdsCustomer.Edit;
  AObj.WriteToDataSet(cdsCustomer);
  cdsCustomer.Post;
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

procedure TfrmCustomer.toolEditClick(Sender: TObject);
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

procedure TfrmCustomer.btnSaveClick(Sender: TObject);
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
  isSelected:boolean;
begin
  inherited;
  isSelected := false;
  gid := cdsList.FieldbyName('CUST_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldByName('A').AsString = '1' then
           begin
             isSelected := true;
             break;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('CUST_ID',gid,[]);
    cdsList.EnableControls;
  end;
  if not isSelected then Raise Exception.Create('请选择要变更的记录...');
  if fndPRICE_ID.asString='' then Raise Exception.Create('请选择更改的目标等级...');
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
  isSelected,canDelete:boolean;
begin
  inherited;
  isSelected := false;
  canDelete := true;
  gid := cdsList.FieldbyName('CUST_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldByName('A').AsString = '1' then
           begin
             isSelected := true;
             if Copy(cdsList.FieldByName('COMM').AsString,2,2) = '2' then
                begin
                  canDelete := false;
                  break;
                end;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('CUST_ID',gid,[]);
    cdsList.EnableControls;
  end;
  if not isSelected then Raise Exception.Create('请选择要删除的记录...');
  if not canDelete then Raise Exception.Create('回收站内会员不能删除...');  
  if MessageBox(Handle,'是否删除选中的所有会员？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  gid := cdsList.FieldbyName('CUST_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldbyName('A').AsString='1' then
           begin
             if Copy(cdsList.FieldByName('COMM').AsString,2,2) <> '2' then
                begin
                  DeleteInfo(cdsList.FieldbyName('CUST_ID').AsString);
                  cdsList.Delete;
                end
             else cdsList.Next;
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
  edtSEX1.Checked := true;
  cmbPRICE_ID.KeyValue := cmbPRICE_ID.DataSet.FieldbyName('PRICE_ID').asString;
  cmbPRICE_ID.Text := cmbPRICE_ID.DataSet.FieldbyName('PRICE_NAME').asString;
end;

procedure TfrmCustomer.btnFindClick(Sender: TObject);
begin
  inherited;
  NewInfo;
end;

procedure TfrmCustomer.RzLabel13Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前功能还没有开通，敬请期待','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmCustomer.RzLabel17Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前功能还没有开通，敬请期待','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmCustomer.RzLabel12Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前功能还没有开通，敬请期待','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmCustomer.edtCUST_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtCUST_NAME.Focused then edtCUST_SPELL.Text := FnString.GetWordSpell(edtCUST_NAME.Text,3) ;
end;

procedure TfrmCustomer.unDeleteInfo(custId: string);
var
  Params:TftParamList;
  tmpCustomer:TZQuery;
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
    cdsCustomer.First;
    while not cdsCustomer.Eof do
       begin
         cdsCustomer.Edit;
         cdsCustomer.FieldbyName('COMM').AsString := '10';
         cdsCustomer.Post;
         cdsCustomer.Next;
       end;
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

  if dataFactory.iDbType <> 5 then
  begin
    tmpCustomer := TZQuery.Create(nil);
    Params := TftParamList.Create;
    dataFactory.MoveToSqlite;
    try
      dataFactory.BeginBatch;
      try
         Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
         Params.ParamByName('CUST_ID').AsString := custId;
         dataFactory.AddBatch(tmpCustomer,'TCustomerV60',Params);
         dataFactory.OpenBatch;
      except
         dataFactory.CancelBatch;
         Raise;
      end;
      tmpCustomer.First;
      while not tmpCustomer.Eof do
        begin
          tmpCustomer.Edit;
          tmpCustomer.FieldbyName('COMM').AsString := '10';
          tmpCustomer.Post;
          tmpCustomer.Next;
        end;
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      tmpCustomer.Free;
      Params.Free;
    end;
  end;
  dllGlobal.GetZQueryFromName('PUB_CUSTOMER').Close;
end;

procedure TfrmCustomer.toolDeleteClick(Sender: TObject);
begin
  inherited;
  if cdsList.FieldbyName('COMM').AsString[2]<>'2' then
     begin
       if MessageBox(Handle,'是否删除当前行的会员？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       DeleteInfo(cdsList.FieldbyName('CUST_ID').AsString);
       cdsList.Delete;
     end
  else
     begin
       if MessageBox(Handle,'是否还原当前行的会员？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       unDeleteInfo(cdsList.FieldbyName('CUST_ID').AsString);
       cdsList.Delete;
     end;
end;

procedure TfrmCustomer.btnNewSortClick(Sender: TObject);
begin
  inherited;
  if TfrmPriceGrade.ShowDialog(self,'') then
     begin
       rzTree.OnChange := nil;
       CreatePriceGrade;
       rzTree.OnChange := rzTreeChange;
     end;
end;

procedure TfrmCustomer.N1Click(Sender: TObject);
var SObj:TRecord_;
begin
  inherited;
  SObj := TRecord_(rzTree.Selected.Data);
  if (SObj = nil) then Raise Exception.Create('该等级不允许修改...');
  if TfrmPriceGrade.ShowDialog(self,SObj.FieldByName('PRICE_ID').AsString) then
     begin
       rzTree.OnChange := nil;
       CreatePriceGrade;
       rzTree.OnChange := rzTreeChange;
     end;
end;

procedure TfrmCustomer.N2Click(Sender: TObject);
var
  SObj:TRecord_;
  cdsPriceGrade:TZQuery;
  Params:TftParamList;
begin
  inherited;
  SObj := TRecord_(rzTree.Selected.Data);
  if (SObj = nil) then Raise Exception.Create('该等级不允许删除...');

  if MessageBox(Handle,Pchar('确定要删除"'+SObj.FieldByName('PRICE_NAME').AsString+'"等级吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) <> 6 then Exit;

  cdsPriceGrade := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('PRICE_ID').AsString := SObj.FieldByName('PRICE_ID').AsString;
    dataFactory.Open(cdsPriceGrade,'TPriceGradeV60',Params);
    if not cdsPriceGrade.IsEmpty then cdsPriceGrade.Delete;
    try
      dataFactory.UpdateBatch(cdsPriceGrade,'TPriceGradeV60');
    except
      cdsPriceGrade.CancelUpdates;
      Raise;
    end
  finally
    cdsPriceGrade.Free;
    Params.Free;
  end;

  if dataFactory.iDbType <> 5 then
  begin
    cdsPriceGrade := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      Params.ParamByName('PRICE_ID').AsString := SObj.FieldByName('PRICE_ID').AsString;
      dataFactory.Open(cdsPriceGrade,'TPriceGradeV60',Params);
      if not cdsPriceGrade.IsEmpty then cdsPriceGrade.Delete;
      try
        dataFactory.UpdateBatch(cdsPriceGrade,'TPriceGradeV60');
      except
        cdsPriceGrade.CancelUpdates;
        Raise;
      end
    finally
      dataFactory.MoveToDefault;
      cdsPriceGrade.Free;
      Params.Free;
    end;
  end;
  dllGlobal.GetZQueryFromName('PUB_PRICEGRADE').Close;
  rzTree.OnChange := nil;
  CreatePriceGrade;
  rzTree.OnChange := rzTreeChange;
end;

procedure TfrmCustomer.SaveLocalInfo;
var
  Params:TftParamList;
  tmpCustomer:TZQuery;
  tmpObj:TRecord_;
begin
  if dataFactory.iDbType <> 5 then
  begin
    tmpObj := TRecord_.Create;
    tmpCustomer := TZQuery.Create(nil);
    Params := TftParamList.Create;
    dataFactory.MoveToSqlite;
    try
      dataFactory.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsCustomer.FieldByName('TENANT_ID').AsInteger;
        Params.ParamByName('CUST_ID').AsString := cdsCustomer.FieldByName('CUST_ID').AsString;;
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
      if tmpCustomer.IsEmpty then tmpCustomer.Append else tmpCustomer.Edit;
      tmpObj.ReadFromDataSet(cdsCustomer);
      tmpObj.WriteToDataSet(tmpCustomer);
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpCustomer.Free;
      tmpObj.Free;
    end;
  end;
end;

procedure TfrmCustomer.serachTextKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
     Open;
end;

procedure TfrmCustomer.DBGridPrint;
begin
  inherited;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.PageHeader.CenterText.Text := '会员档案';
  DBGridEh1.DBGridTitle := '会员档案';
  DBGridEh1.DBGridHeader.Text := '';
  DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '']);
end;

procedure TfrmCustomer.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Preview(self,PrintDBGridEh1);
end;

procedure TfrmCustomer.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Print(self,PrintDBGridEh1);
end;

procedure TfrmCustomer.ExcelImportClick(Sender: TObject);
var Params:TftParamList;
    rs:TZQuery;
begin
  inherited;
  Params := TftParamList.Create(nil);
  rs := TZQuery.Create(nil);
  try
    dataFactory.BeginBatch;
    try
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       Params.ParamByName('CUST_ID').AsString := '';
       dataFactory.AddBatch(rs,'TCustomerV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;

    if TfrmCustomerExcel.ExcelFactory(self,rs,'','',true) then
      dllGlobal.GetZQueryFromName('PUB_CUSTOMER').Close;

  finally
    Params.Free;
    rs.Free;
  end;
end;

initialization
  RegisterClass(TfrmCustomer);
finalization
  UnRegisterClass(TfrmCustomer);
end.
