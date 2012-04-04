unit ufrmKpiIndex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, RzButton, cxControls, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxContainer, cxEdit,
  cxTextEdit, Grids, DBGridEh, PrnDbgeh, ObjCommon, cxMaskEdit,
  cxDropDownEdit;

type
  TfrmKpiIndex = class(TframeToolForm)
    Btn_Add: TToolButton;
    Btn_Edit: TToolButton;
    Btn_Info: TToolButton;
    Btn_Delete: TToolButton;
    ToolButton5: TToolButton;
    Btn_Print: TToolButton;
    Btn_Preview: TToolButton;
    Btn_Exit: TToolButton;
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    DBGridEh1: TDBGridEh;
    Label3: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Label1: TLabel;
    Bevel1: TBevel;
    Cds_KpiIndex: TZQuery;
    Ds_KpiIndex: TDataSource;
    PrintDBGridEh1: TPrintDBGridEh;
    lab_IDX_TYPE: TRzLabel;
    fndIDX_TYPE: TcxComboBox;
    fndKPI_TYPE: TcxComboBox;
    lab_KPI_TYPE: TLabel;
    Label2: TLabel;
    procedure actNewExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actInfoExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function  CheckCanExport:Boolean;
    procedure PrintView;    
  public
    { Public declarations }
    procedure AddRecord(AObj:TRecord_);
  end;


implementation
uses ufrmKpiIndexInfo,uGlobal,uShopGlobal, ufrmBasic, ufrmEhLibReport,
  uframeMDForm;
{$R *.dfm}

procedure TfrmKpiIndex.actNewExecute(Sender: TObject);
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002143',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmKpiIndexInfo.Create(self) do
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

procedure TfrmKpiIndex.AddRecord(AObj: TRecord_);
begin
  if not Cds_KpiIndex.Active  then exit;
  if Cds_KpiIndex.Locate('KPI_ID',AObj.FieldByName('KPI_ID').AsString,[]) then
  begin
     Cds_KpiIndex.Edit;
     AObj.WriteToDataSet(Cds_KpiIndex,false);
     Cds_KpiIndex.Post;
  end
  else
  begin
     Cds_KpiIndex.Append;
     AObj.WriteToDataSet(Cds_KpiIndex,false);
     Cds_KpiIndex.Post;
  end;
  //InitGrid;
  if Cds_KpiIndex.Locate('KPI_ID',AObj.FieldByName('KPI_ID').AsString,[]) then exit;
end;

procedure TfrmKpiIndex.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmKpiIndex.actDeleteExecute(Sender: TObject);
var
  i: Integer;
  Params: TftParamList;
begin
  if (Not Cds_KpiIndex.Active) then Exit;
  if (Cds_KpiIndex.RecordCount = 0) then Exit;
  if Copy(trim(Cds_KpiIndex.FieldByName('COMM').AsString),1,1)='1' then Raise Exception.Create('       已同步过单据不能删除...        ');

  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    try
      Cds_KpiIndex.CommitUpdates;
      try
        //删除数据库
        Params:=TftParamList.Create(nil);
        Params.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        Params.ParamByName('KPI_ID').AsString:=trim(Cds_KpiIndex.FieldByName('KPI_ID').AsString);
        Factor.ExecProc('TKpiIndexDelete',Params);
        //删除数据集
        Cds_KpiIndex.Delete;
      finally
        Params.Free;
      end;
      //Factor.UpdateBatch(Cds_KpiIndex,'TKpiIndex');
    Except
      Cds_KpiIndex.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmKpiIndex.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_KpiIndex.Active) or (Cds_KpiIndex.IsEmpty) then exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002143',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  with TfrmKpiIndexInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(Cds_KpiIndex.FieldByName('KPI_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

function TfrmKpiIndex.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('100002143',6);
end;

procedure TfrmKpiIndex.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '员工档案管理';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmKpiIndex.actFindExecute(Sender: TObject);
var StrSql:String;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002143',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  if Trim(edtKey.Text) <> '' then
     StrSql := ' and A.KPI_NAME like ''%'+Trim(edtKey.Text)+'%'' ';
  if fndIDX_TYPE.ItemIndex <> -1 then
     StrSql := StrSql + ' and A.IDX_TYPE='''+TRecord_(fndIDX_TYPE.Properties.Items.Objects[fndIDX_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  if fndKPI_TYPE.ItemIndex <> -1 then
     StrSql := StrSql + ' and A.KPI_TYPE='''+TRecord_(fndKPI_TYPE.Properties.Items.Objects[fndKPI_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  Cds_KpiIndex.Close;
  Cds_KpiIndex.SQL.Text :=
  ParseSQL(Factor.iDbType,
  'select A.TENANT_ID,A.KPI_ID,A.KPI_NAME,A.UNIT_NAME,A.IDX_TYPE,A.KPI_TYPE,A.REMARK,A.COMM,count(B.GODS_ID) as GOODS_SUM from MKT_KPI_INDEX A,MKT_KPI_GOODS B '+
  ' where A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID and A.COMM not in (''02'',''12'') and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+StrSql+
  ' group by A.TENANT_ID,A.KPI_ID,A.KPI_NAME,A.UNIT_NAME,A.IDX_TYPE,A.KPI_TYPE,A.REMARK,A.COMM');
  Factor.Open(Cds_KpiIndex);
end;

procedure TfrmKpiIndex.DBGridEh1DrawColumnCell(Sender: TObject;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_KpiIndex.RecNo)),length(Inttostr(Cds_KpiIndex.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmKpiIndex.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(Sender);
end;

procedure TfrmKpiIndex.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
end;

procedure TfrmKpiIndex.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not Cds_KpiIndex.Active then Exception.Create('没有数据！');
  if Cds_KpiIndex.IsEmpty then Exception.Create('没有数据！');
  with TfrmKpiIndexInfo.Create(self) do
    begin
      try
        Open(Cds_KpiIndex.FieldByName('KPI_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmKpiIndex.actPreviewExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002143',6) then Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmKpiIndex.actPrintExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002143',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');

  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmKpiIndex.FormShow(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
end;

end.
