unit ufrmBatchNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzLabel, ComCtrls, ToolWin, DB, ZBase, EncDec,
  FR_Class, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset, PrnDbgeh,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit;

type
  TfrmBatchNo = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Panel2: TPanel;
    edtKey: TcxTextEdit;
    dsBatchNo: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    But_Edit: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    actRights: TAction;
    btnOk: TRzBitBtn;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    cdsBatchNo: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    N2: TMenuItem;
    actPasswordReset: TAction;
    Label3: TLabel;
    N3: TMenuItem;
    Excel1: TMenuItem;
    Label1: TLabel;
    edtP2_GoodsName: TzrComboBoxList;
    procedure actFindExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsBatchNoAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    { Private declarations }
    function CheckCanExport:Boolean;override;
    procedure PrintView;
  public
    { Public declarations }
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
  end;


implementation
uses ufrmBatchNoInfo, ufrmBasic, uframeDialogForm, uGlobal, objCommon, uShopUtil, uFnUtil,
     uDsUtil, uShopGlobal, ufrmEhLibReport, uCtrlUtil, ufrmExcelFactory;
{$R *.dfm}

procedure TfrmBatchNo.actFindExecute(Sender: TObject);
var
  str:string;
begin
  inherited;
  //查自已门店用户，及下属直营门店的用户
  if not ShopGlobal.GetChkRight('100002513',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  if edtP2_GoodsName.AsString <> '' then
    str := ' and GODS_ID = '+QuotedStr(edtP2_GoodsName.AsString);
  if edtKey.Text<>'' then
     str:= str + ' and BATCH_NO LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%');
  cdsBatchNo.Close;
  cdsBatchNo.SQL.Text :=
  ParseSQL(Factor.iDbType,
  'select ja.*,isnull(a.GODS_NAME,''无'') as GODS_ID_TEXT from('+
  'select TENANT_ID,BATCH_NO,GODS_ID,FACT_DATE,VILD_DATE,REMARK from PUB_BATCH_NO  '+
  'where COMM not in (''12'',''02'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+str+') ja '+
  'left outer join VIW_GOODSINFO a on ja.TENANT_ID=a.TENANT_ID and ja.GODS_ID=a.GODS_ID ORDER BY ja.GODS_ID,ja.BATCH_NO'
  );
  Factor.Open(cdsBatchNo);
end;

procedure TfrmBatchNo.actDeleteExecute(Sender: TObject);
var i:integer;
begin
  inherited;
  if (Not cdsBatchNo.Active) then Exit;
  if (cdsBatchNo.RecordCount = 0) then Exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002513',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    try
      cdsBatchNo.CommitUpdates;
      cdsBatchNo.Delete;
      Factor.UpdateBatch(cdsBatchNo,'TBatchNo');
    Except
      cdsBatchNo.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmBatchNo.actNewExecute(Sender: TObject);
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002513',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmBatchNoInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmBatchNo.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBatchNo.Active) or (cdsBatchNo.IsEmpty) then exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002513',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  with TfrmBatchNoInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(cdsBatchNo.FieldByName('BATCH_NO').AsString,cdsBatchNo.FieldByName('GODS_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmBatchNo.AddRecord(AObj: TRecord_);
begin
  if not cdsBatchNo.Active  then exit;
  if cdsBatchNo.Locate('BATCH_NO;GODS_ID',VarArrayOf([AObj.FieldByName('BATCH_NO').AsString,AObj.FieldByName('GODS_ID').AsString]),[]) then
  begin
     cdsBatchNo.Edit;
     AObj.WriteToDataSet(cdsBatchNo,false);
     cdsBatchNo.Post;
  end
  else
  begin
     cdsBatchNo.Append;
     AObj.WriteToDataSet(cdsBatchNo,false);
     cdsBatchNo.Post;
  end;
  InitGrid;
  if cdsBatchNo.Locate('BATCH_NO;GODS_ID',VarArrayOf([AObj.FieldByName('BATCH_NO').AsString,AObj.FieldByName('GODS_ID').AsString]),[]) then exit;
end;

procedure TfrmBatchNo.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBatchNo.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  edtP2_GoodsName.DataSet:=Global.GetZQueryFromName('PUB_GOODSINFO');
  TDbGridEhSort.InitForm(self);  
end;

procedure TfrmBatchNo.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not cdsBatchNo.Active then Exception.Create('没有数据！');
  if cdsBatchNo.IsEmpty then Exception.Create('没有数据！');
  with TfrmBatchNoInfo.Create(self) do
    begin
      try
        Open(cdsBatchNo.FieldByName('BATCH_NO').AsString,cdsBatchNo.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmBatchNo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBatchNo.RecNo)),length(Inttostr(cdsBatchNo.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmBatchNo.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
end;

procedure TfrmBatchNo.InitGrid;
var tmp:TZQuery;
begin
  {try
    DBGridEh1.FieldColumns['SHOP_ID'].PickList.Clear;
    DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Clear;

    tmp := TZQuery.Create(nil);
    tmp.SQL.Text := 'select SHOP_ID,SHOP_NAME from CA_SHOP_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    tmp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(tmp);
    tmp.First;
    while not tmp.Eof do
    begin
      DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Add(tmp.Fields[0].asstring);
      DBGridEh1.FieldColumns['SHOP_ID'].PickList.Add(tmp.Fields[1].asstring);
      tmp.Next;
    end;
  finally
    tmp.Free;
  end;}
end;

procedure TfrmBatchNo.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
  edtKey.SetFocus;
end;

procedure TfrmBatchNo.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBatchNo.Next;
  if Key=VK_UP then
     cdsBatchNo.Prior;
end;

procedure TfrmBatchNo.cdsBatchNoAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBatchNo.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBatchNo.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cdsBatchNo.RecordCount)+'条';
end;

procedure TfrmBatchNo.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

procedure TfrmBatchNo.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002513',5) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');

  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmBatchNo.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002513',5) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
  PrintView;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
end;

function TfrmBatchNo.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('100002513',6);
end;

procedure TfrmBatchNo.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '批号档案';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

end.
