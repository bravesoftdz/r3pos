unit ufrmPriceGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  RzButton, Grids, DBGridEh, cxSpinEdit, StdCtrls, cxMaskEdit,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxTextEdit, ComCtrls,
  RzTreeVw, RzLabel, RzBckgnd, ZBase, DB, cxButtonEdit, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmPriceGrade = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzLabel26: TRzLabel;
    RzPanel3: TRzPanel;
    edtBK_PRICE_NAME: TRzPanel;
    RzPanel42: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel11: TRzLabel;
    edtPRICE_NAME: TcxTextEdit;
    edtBK_AGIO_TYPE: TRzPanel;
    RzPanel5: TRzPanel;
    RzBackground1: TRzBackground;
    edtAGIO_TYPE: TcxComboBox;
    RzPanel13: TRzPanel;
    RzPanel14: TRzPanel;
    edtBK_INTE_TYPE: TRzPanel;
    RzPanel7: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel2: TRzLabel;
    edtINTE_TYPE: TcxComboBox;
    edtBK_INTE_AMOUNT: TRzPanel;
    RzPanel9: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel3: TRzLabel;
    edtINTE_AMOUNT: TcxTextEdit;
    RzPanel10: TRzPanel;
    RzPanel11: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel4: TRzLabel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    PNL_AGIO_TYPE_0: TRzPanel;
    PNL_AGIO_TYPE_1: TRzPanel;
    PNL_AGIO_TYPE_2: TRzPanel;
    PNL_AGIO_TYPE_3: TRzPanel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzPanel12: TRzPanel;
    RzPanel15: TRzPanel;
    RzBackground6: TRzBackground;
    RzLabel7: TRzLabel;
    RzPanel16: TRzPanel;
    RzPanel17: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel8: TRzLabel;
    edtAGIO_PERCENT: TcxSpinEdit;
    RzPanel18: TRzPanel;
    RzPanel21: TRzPanel;
    Label17: TLabel;
    DBGridEh1: TDBGridEh;
    edtSORT_ID: TcxButtonEdit;
    DataSource1: TDataSource;
    cdsPriceGrade: TZQuery;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    cdsGoodsPercent: TZQuery;
    RzLabel9: TRzLabel;
    procedure edtAGIO_TYPEPropertiesChange(Sender: TObject);
    procedure edtINTE_TYPEPropertiesChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtSORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure AddSort;
    procedure edtSORT_IDEnter(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure RzToolButton1Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    AObj:TRecord_;
    procedure Open(id:string);
    procedure Save;
    procedure ReadInfo;
    procedure WriteInfo;
    procedure ClearInvaid;
    procedure CheckInput;
  public
    class function ShowDialog(AOwner:TForm;id:string):boolean;
  end;

implementation

uses udllShopUtil,ufrmSortDropFrom,udllGlobal,uTokenFactory,udataFactory,udllDsUtil,
     uFnUtil;

{$R *.dfm}

procedure TfrmPriceGrade.edtAGIO_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  case edtAGIO_TYPE.ItemIndex of
  0:
    begin
      PNL_AGIO_TYPE_0.Visible := true;
      PNL_AGIO_TYPE_1.Visible := false;
      PNL_AGIO_TYPE_2.Visible := false;
      PNL_AGIO_TYPE_3.Visible := false;
    end;
  1:
    begin
      PNL_AGIO_TYPE_0.Visible := false;
      PNL_AGIO_TYPE_1.Visible := true;
      PNL_AGIO_TYPE_2.Visible := false;
      PNL_AGIO_TYPE_3.Visible := false;
    end;
  2:
    begin
      PNL_AGIO_TYPE_0.Visible := false;
      PNL_AGIO_TYPE_1.Visible := false;
      PNL_AGIO_TYPE_2.Visible := true;
      PNL_AGIO_TYPE_3.Visible := false;
    end;
  3:
    begin
      PNL_AGIO_TYPE_0.Visible := false;
      PNL_AGIO_TYPE_1.Visible := false;
      PNL_AGIO_TYPE_2.Visible := false;
      PNL_AGIO_TYPE_3.Visible := true;
    end;
  end;
end;

procedure TfrmPriceGrade.edtINTE_TYPEPropertiesChange(Sender: TObject);
var str:string;
begin
  if (edtINTE_TYPE.ItemIndex=-1) or (TRecord_(edtINTE_TYPE.Properties.Items.Objects[edtINTE_TYPE.ItemIndex])=nil) then Exit;

  str := TRecord_(edtINTE_TYPE.Properties.Items.Objects[edtINTE_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  if str='0' then
     begin
       if edtINTE_AMOUNT.Text='' then
          edtINTE_AMOUNT.Text:='0';
       edtINTE_AMOUNT.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse, edtINTE_AMOUNT.Style);
       edtBK_INTE_AMOUNT.Color := edtINTE_AMOUNT.Style.Color;
     end
  else
     begin
       edtINTE_AMOUNT.Properties.ReadOnly := false;
       SetEditStyle(dsInsert, edtINTE_AMOUNT.Style);
       edtBK_INTE_AMOUNT.Color := edtINTE_AMOUNT.Style.Color;
       if str='1' then
          begin
            RzLabel3.Caption:='积一分需购买';
            RzLabel4.Caption:='元的商品';
          end
       else if str='2' then
          begin
            RzLabel3.Caption:='积一分需产生';
            RzLabel4.Caption:='元的毛利';
          end
       else if str='3' then
          begin
            RzLabel3.Caption:='积一分需购买';
            RzLabel4.Caption:='数量的商品';
          end;
     end;
end;

procedure TfrmPriceGrade.Open(id: string);
var Params: TftParamList;
begin
  inherited;
  Params := TftParamList.Create;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('PRICE_ID').AsString := id;
    dataFactory.Open(cdsPriceGrade,'TPriceGradeV60',Params);
  finally
    Params.Free;
  end;
  if cdsPriceGrade.IsEmpty then
     dbState := dsInsert
  else
     dbState := dsEdit;
  if not cdsGoodsPercent.Active then cdsGoodsPercent.CreateDataSet;
  if not cdsGoodsPercent.IsEmpty then cdsGoodsPercent.EmptyDataSet;
end;

procedure TfrmPriceGrade.ReadInfo;
var
  vList:TStringList;
  rs:TZQuery;
  strSort:string;
  i:integer;
begin
  AObj.ReadFromDataSet(cdsPriceGrade);
  udllShopUtil.ReadFromObject(AObj,self);
  if dbState = dsInsert then
     begin
       edtINTE_TYPE.ItemIndex:=0;
       edtAGIO_TYPE.ItemIndex:=0;
       edtINTE_AMOUNT.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse, edtINTE_AMOUNT.Style);
       edtBK_INTE_AMOUNT.Color := edtINTE_AMOUNT.Style.Color;
     end
  else
     begin
       vList := TStringList.Create;
       try
         vList.CommaText := AObj.FieldByName('AGIO_SORTS').AsString;
         rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
         for i:=0 to vList.Count-1  do
         begin
           strSort := Copy(vList.Strings[i],1,AnsiPos('=',vList.Strings[i])-1);
           if rs.Locate('SORT_ID',strSort,[]) then
              begin
                cdsGoodsPercent.Append;
                cdsGoodsPercent.FieldByName('SORT_ID').AsString:=rs.FieldByName('SORT_ID').AsString;
                cdsGoodsPercent.FieldByName('SORT_NAME').AsString:=rs.FieldByName('SORT_NAME').AsString;
                cdsGoodsPercent.FieldByName('AGIO_SORTS').AsString:=vList.Values[strSort];
                cdsGoodsPercent.Post;
              end;
         end;
       finally
         vList.Free;
       end;
     end;
end;

class function TfrmPriceGrade.ShowDialog(AOwner: TForm; id: string): boolean;
begin
  with TfrmPriceGrade.Create(AOwner) do
    begin
      try
        Open(id);
        ReadInfo;
        result := (ShowModal = MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmPriceGrade.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPriceGrade.edtSORT_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    frmSortDropFrom.ShowNoSort := false;
    frmSortDropFrom.SelectChildren := true;  
    if frmSortDropFrom.DropForm(edtSORT_ID,Obj) then
    begin
      if Obj.Count > 0 then
         begin
          if cdsGoodsPercent.Locate('SORT_ID',Obj.FieldbyName('SORT_ID').AsString,[]) then
             begin
               MessageBox(Handle,pchar('此分类已经添加到列表.'),pchar('友情提示..'),MB_OK+MB_ICONINFORMATION);
             end
          else
             begin
               cdsGoodsPercent.Edit;
               cdsGoodsPercent.FieldByName('SORT_ID').AsString := Obj.FieldbyName('SORT_ID').AsString;
               cdsGoodsPercent.FieldByName('SORT_NAME').AsString := Obj.FieldbyName('SORT_NAME').AsString;
               cdsGoodsPercent.FieldByName('AGIO_SORTS').AsFloat := 100;
               cdsGoodsPercent.Post;
             end;
         end
      else
         begin
           cdsGoodsPercent.Edit;
           cdsGoodsPercent.FieldByName('SORT_ID').AsString := '';
           cdsGoodsPercent.FieldByName('SORT_NAME').AsString := '';
           cdsGoodsPercent.FieldByName('AGIO_SORTS').AsFloat := 100;
           cdsGoodsPercent.Post;
         end;
    end;
    edtSORT_ID.Visible := false;
  finally
    Obj.Free;
  end;
end;

procedure TfrmPriceGrade.AddSort;
begin
  inherited;
  if not cdsGoodsPercent.Active then Exit;
  if cdsGoodsPercent.State in [dsEdit,dsInsert] then cdsGoodsPercent.Post;
  cdsGoodsPercent.DisableControls;
  try
    cdsGoodsPercent.First;
    while not cdsGoodsPercent.Eof do
    begin
      if cdsGoodsPercent.FieldByName('SORT_ID').AsString = '' then Exit;
      cdsGoodsPercent.Next;
    end;
    cdsGoodsPercent.Append;
    cdsGoodsPercent.Post;
  finally
    cdsGoodsPercent.EnableControls
  end;
end;

procedure TfrmPriceGrade.edtSORT_IDEnter(Sender: TObject);
begin
  inherited;
  if cdsGoodsPercent.FieldByName('SORT_ID').AsString = '' then Exit;
  edtSORT_ID.Text := cdsGoodsPercent.FieldByName('SORT_NAME').AsString;
end;

procedure TfrmPriceGrade.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmPriceGrade.Save;
var
  rs:TZQuery;
  tmpObj:TRecord_;
  tmpPriceGrade:TZQuery;
  Params:TftParamList;
begin
  ClearInvaid;
  CheckInput;
  WriteInfo;

  rs := dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  if rs.Locate('PRICE_NAME',cdsPriceGrade.FieldByName('PRICE_NAME').AsString,[]) then
     begin
       if rs.FieldByName('PRICE_ID').AsString <> cdsPriceGrade.FieldByName('PRICE_ID').AsString then
          Raise Exception.Create('该等级已经存在...');
     end;

  try
    dataFactory.UpdateBatch(cdsPriceGrade,'TPriceGradeV60');
  except
    cdsPriceGrade.CancelUpdates;
    Raise;
  end;

  if dataFactory.iDbType <> 5 then
  begin
    tmpObj := TRecord_.Create;
    Params := TftParamList.Create;
    tmpPriceGrade := TZQuery.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsPriceGrade.FieldByName('TENANT_ID').AsInteger;
      Params.ParamByName('PRICE_ID').AsString := cdsPriceGrade.FieldByName('PRICE_ID').AsString;
      dataFactory.Open(tmpPriceGrade,'TPriceGradeV60',Params);

      if tmpPriceGrade.IsEmpty then tmpPriceGrade.Append else tmpPriceGrade.Edit;
      tmpObj.ReadFromDataSet(cdsPriceGrade);
      tmpObj.WriteToDataSet(tmpPriceGrade);

      try
        dataFactory.UpdateBatch(tmpPriceGrade,'TPriceGradeV60');
      except
        tmpPriceGrade.CancelUpdates;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      tmpPriceGrade.Free;
      Params.Free;
      tmpObj.Free;
    end;
  end;
  
  dllGlobal.GetZQueryFromName('PUB_PRICEGRADE').Close;
  ModalResult := MROK;
end;

procedure TfrmPriceGrade.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmPriceGrade.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmPriceGrade.WriteInfo;
var AgioSorts:string;
begin
  udllShopUtil.WriteToObject(AObj,self);
  if dbState = dsInsert then
     begin
       AObj.FieldByName('PRICE_ID').AsString := TSequence.NewId;
       AObj.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
       AObj.FieldByName('MINIMUM_PERCENT').AsFloat := 0;
       AObj.FieldByName('INTEGRAL').AsFloat := 0;
     end;
  cdsGoodsPercent.First;
  while not cdsGoodsPercent.Eof do
  begin
    if AgioSorts='' then
       AgioSorts:=cdsGoodsPercent.FieldByName('SORT_ID').AsString+'='+ cdsGoodsPercent.FieldByName('AGIO_SORTS').AsString
    else
       AgioSorts:=AgioSorts+','+cdsGoodsPercent.FieldByName('SORT_ID').AsString+'='+ cdsGoodsPercent.FieldByName('AGIO_SORTS').AsString;
    cdsGoodsPercent.Next;
  end;
  AObj.FieldbyName('AGIO_SORTS').AsString := AgioSorts;
  AObj.WriteToDataSet(cdsPriceGrade);
  cdsPriceGrade.FieldByName('PRICE_SPELL').AsString := fnString.GetWordSpell(cdsPriceGrade.FieldByName('PRICE_NAME').AsString,3);
end;

procedure TfrmPriceGrade.CheckInput;
begin
  if trim(edtPRICE_NAME.Text) = '' then
     begin
       if edtPRICE_NAME.CanFocus then edtPRICE_NAME.SetFocus;
       Raise Exception.Create('等级名称不能为空...');
     end;
  if (not edtINTE_AMOUNT.Properties.ReadOnly) and (trim(edtINTE_AMOUNT.Text) = '') then
     begin
       if edtINTE_AMOUNT.CanFocus then edtINTE_AMOUNT.SetFocus;
       Raise Exception.Create('积分系数不能为空...');
     end;
  try
    StrtoFloat(edtINTE_AMOUNT.Text);
  except
    if edtINTE_AMOUNT.CanFocus then edtINTE_AMOUNT.SetFocus;
    Raise Exception.Create('"'+edtINTE_AMOUNT.Text+'"无效数值...');
  end;
  if (edtAGIO_TYPE.ItemIndex = 2) and (cdsGoodsPercent.IsEmpty) then
     Raise Exception.Create('分类折扣数据不能为空...'); 
end;

procedure TfrmPriceGrade.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  inherited;
  try
    if Text='' then r := 0
    else r := StrtoFloat(Text);
    if (r > 100) or (r < 0) then
       begin
         Text := '100';
         Value := 100;
         Raise Exception.Create('输入的数值无效');
       end;
  except
    Text := '100';
    Value := 100;
    Raise Exception.Create('输入无效数值型');
  end;
end;

procedure TfrmPriceGrade.ClearInvaid;
begin
  cdsGoodsPercent.First;
  while not cdsGoodsPercent.Eof do
  begin
    if cdsGoodsPercent.FieldByName('SORT_ID').AsString = '' then
       cdsGoodsPercent.Delete
    else
       cdsGoodsPercent.Next;
  end;
end;

procedure TfrmPriceGrade.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if (cdsGoodsPercent.IsEmpty) or (not cdsGoodsPercent.Active) then Exit;
  cdsGoodsPercent.Delete;
end;

procedure TfrmPriceGrade.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
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
         if cdsGoodsPercent.FieldByName('SORT_ID').AsString <> '' then
            rowToolNav.Visible := true
         else
            rowToolNav.Visible := false;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
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
      DbGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsGoodsPercent.RecNo)),length(Inttostr(cdsGoodsPercent.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmPriceGrade.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
begin
  inherited;
  Cell := DBGridEh1.MouseCoord(X,Y);
  if Cell.Y > DBGridEh1.VisibleRowCount -2 then AddSort;
end;

end.
