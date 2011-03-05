unit ufrmTransOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxRadioGroup, RzButton, cxButtonEdit, zrComboBoxList, ObjCommon, DB, zBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, FR_Class;

type
  TfrmTransOrderList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    DBGridEh1: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    LabTRANS_DATE: TLabel;
    TRANS_DATE1: TcxDateEdit;
    Label1: TLabel;
    TRANS_DATE2: TcxDateEdit;
    LabIN_ACCOUNT_ID: TLabel;
    LabOUT_ACCOUNT_ID: TLabel;
    fndIN_ACCOUNT_ID: TzrComboBoxList;
    fndOUT_ACCOUNT_ID: TzrComboBoxList;
    LabTRANS_USER: TLabel;
    fndTRANS_USER: TzrComboBoxList;
    fndQuery: TRzBitBtn;
    fndOrderStatus: TcxRadioGroup;
    cdsList: TZQuery;
    Dsc_1: TDataSource;
    frReport1: TfrReport;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure actPrintExecute(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure ChangeButton;
    { Private declarations }
  public
    { Public declarations }
    IsEnd2: boolean;
    MaxId2:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function FindColumn(FieldName:string):TColumnEh;
    function EncodeSQL2(id:string;var w:string):string;
    procedure Open2(Id:string);
    function PrintSQL2(tenantid,id:string):string;
  end;


implementation
uses uCtrlUtil,uFnUtil,uGlobal,uShopGlobal,uShopUtil,ufrmBasic,ufrmTransOrder,
  uframeMDForm, uframeDialogForm, Math;
{$R *.dfm}

procedure TfrmTransOrderList.AddRecord(AObj: TRecord_);
begin
  if cdsList.Locate('TRANS_ID',Aobj.FieldByName('TRANS_ID').AsString,[]) then
    cdsList.Edit
  else
    cdsList.Append;
  Aobj.WriteToDataset(cdsList,false);
  cdsList.Post;
end;

procedure TfrmTransOrderList.ChangeButton;
begin
  if cdsList.Active and (cdsList.FieldByName('TRANS_ID').AsString = '') then ToolButton6.Caption := '审核' else ToolButton6.Caption := '弃审';
end;

function TfrmTransOrderList.EncodeSQL2(id: string; var w: string): string;
var StrSql,StrWhere:String;
begin
  if (TRANS_DATE1.EditValue = null) or (TRANS_DATE2.EditValue = null) then
    Raise Exception.Create('存取日期条件不能为空！');
  StrWhere := ' TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TRANS_DATE>=:D1 and TRANS_DATE<=:D2';
  if fndIN_ACCOUNT_ID.Text <> '' then
    StrWhere := StrWhere + ' and IN_ACCOUNT_ID='+QuotedStr(fndIN_ACCOUNT_ID.AsString);
  if fndOUT_ACCOUNT_ID.Text <> '' then
    StrWhere := StrWhere + ' and OUT_ACCOUNT_ID='+QuotedStr(fndOUT_ACCOUNT_ID.AsString);
  if fndTRANS_USER.Text <> '' then
    StrWhere := StrWhere + ' and TRANS_USER='+ QuotedStr(fndTRANS_USER.AsString);
  case fndOrderStatus.ItemIndex of
    1: StrWhere := StrWhere + ' and CHK_DATE is null';
    2: StrWhere := StrWhere + ' and CHK_DATE is not null';
  end;
  if id <> '' then
    StrWhere := StrWhere + ' and TRANS_ID>'+QuotedStr(id);

  StrSql := ' TENANT_ID,SHOP_ID,TRANS_ID,GLIDE_NO,IN_ACCOUNT_ID,OUT_ACCOUNT_ID,TRANS_DATE,TRANS_USER,TRANS_MNY,CHK_DATE,CHK_USER,'+
            'REMARK,CREA_DATE,CREA_USER from ACC_TRANSORDER where COMM not in (''02'',''12'') and '+StrWhere;

  case Factor.iDbType of
    0: Result := 'select top 600 '+StrSql+' order by TRANS_ID';
    4:result :=
       'select * from (select '+strSql+' order by TRANS_ID) tp fetch first 600 rows only';
    5: Result := 'select '+StrSql+' order by TRANS_ID limit 600';
  else
    Result := 'select '+StrSql+' order by TRANS_ID ';
  end;
end;

function TfrmTransOrderList.FindColumn(FieldName: string): TColumnEh;
var i: Integer;
begin
  Result := nil;
  for i := 0 to DBGridEh1.Columns.Count - 1 do
    begin
      if DBGridEh1.Columns[i].FieldName = FieldName then
        begin
          Result := DBGridEh1.Columns[i];
          Break;
        end;
    end;
end;

procedure TfrmTransOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  TDbGridEhSort.InitForm(Self);
  TRANS_DATE1.Date := FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01',Date));
  TRANS_DATE2.Date := FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD',Date));

  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO'); 
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  
  fndIN_ACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  fndOUT_ACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  fndTRANS_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  //fndTRANS_USER.KeyValue := Global.UserID;
  //fndTRANS_USER.ListField := Global.UserName;
end;

procedure TfrmTransOrderList.InitGrid;
var rs:TZQuery;
    Column: TColumnEh;
begin
  InitGridPickList(DBGridEh1);

  rs := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  Column := FindColumn('IN_ACCOUNT_ID');
  if Column <> nil then
    begin
      rs.First;
      while not rs.Eof do
        begin
          Column.KeyList.Add(rs.FieldByName('ACCOUNT_ID').AsString);
          Column.PickList.Add(rs.FieldByName('ACCT_NAME').AsString);
          rs.Next;
        end;
    end;

  Column := FindColumn('OUT_ACCOUNT_ID');
  if Column <> nil then
    begin
      rs.First;
      while not rs.Eof do
        begin
          Column.KeyList.Add(rs.FieldByName('ACCOUNT_ID').AsString);
          Column.PickList.Add(rs.FieldByName('ACCT_NAME').AsString);
          rs.Next;
        end;
    end;
end;

procedure TfrmTransOrderList.Open2(Id: string);
var rs:TZQuery;
    Str:String;
    sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.Close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL2(Id,Str);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',TRANS_DATE1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',TRANS_DATE2.Date));
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldByName('TRANS_ID').AsString;
    if Id = '' then
      begin
        rs.SaveToStream(sm);
        cdsList.LoadFromStream(sm);
        cdsList.IndexFieldNames := 'GLIDE_NO';
      end
    else
      begin
        rs.SaveToStream(sm);
        cdsList.AddFromStream(sm);
      end;
    if rs.RecordCount < 600 then IsEnd2 := True else IsEnd2 := False;

  finally
    cdsList.EnableControls;
    rs.Free;
    sm.Free;
  end;

end;

function TfrmTransOrderList.PrintSQL2(tenantid, id: string): string;
begin

end;

procedure TfrmTransOrderList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700014') then Raise Exception.Create('你没有新增存取单的权限,请和管理员联系.');
  with TfrmTransOrder.Create(nil) do
    begin
      try
        Append;
        OnSave:=AddRecord;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmTransOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList.Active) and cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('700016') then Raise Exception.Create('你没有删除存取单的权限,请和管理员联系.');
  if MessageBox(Self.Handle,pchar('是否要删除当前存取款单'),pchar(Caption),MB_YESNO+MB_DEFBUTTON1) = 6 then
    begin
      try
        cdsList.Delete;
        Factor.UpdateBatch(cdsList,'TTransOrder');
      except
        cdsList.CancelUpdates;
        Raise;
      end;
    end;
end;

procedure TfrmTransOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('700015') then Raise Exception.Create('你没有编辑存取单的权限,请和管理员联系.');
  with TfrmTransOrder.Create(nil) do
    begin
      try
        Edit(cdsList.FieldByName('TRANS_ID').AsString);
        OnSave := AddRecord;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmTransOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open2('');
end;

procedure TfrmTransOrderList.actAuditExecute(Sender: TObject);
var Msg: String;
    Params:TftParamList;
begin
  inherited;
  if cdsList.IsEmpty then Exception.Create('请选择待审核的存取单');
  if not ShopGlobal.GetChkRight('700017') then Raise Exception.Create('你没有审核存取单的权限,请和管理员联系.');
  if cdsList.FieldByName('CHK_DATE').AsString = '' then
    begin
      if Copy(cdsList.FieldByName('COMM').AsString,1,1)='1' then raise Exception.Create('已经同步的数据不能弃审');
      if cdsList.FieldByName('CHK_NAME').AsString <> Global.UserName then Raise Exception.Create('只有审核人才能对当前存取单执行弃审');
      if MessageBox(Handle,'确认弃审当前存取单？',pchar(Application.Title),MB_OK+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(cdsList.FieldByName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能再审核心');
      if MessageBox(Handle,'确认审核当前存取单？',pchar(Application.Title),MB_OK+MB_ICONQUESTION)<>6 then Exit;
    end;
  try
    Params := TftParamList.Create(nil);
      try
        Params.ParamByName('').AsString := Global.SHOP_ID;
        Params.ParamByName('').AsInteger := Global.TENANT_ID;
        Params.ParamByName('').AsInteger := Global.TENANT_ID;
        Params.ParamByName('').AsInteger := Global.TENANT_ID;
        if cdsList.FieldByName('CHK_DATE').AsString = '' then
          Msg := Factor.ExecProc('TTransOrderAudit',Params)
        else
          Msg := Factor.ExecProc('TTransOrderUnAudit',Params);

      finally
        Params.Free;
      end;
      MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
      if cdsList.FieldByName('CHK_DATE').AsString = '' then
        begin
          cdsList.Edit;
          cdsList.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',date());
          cdsList.FieldByName('CHK_USER').AsString := Global.UserID;
          cdsList.Post;
        end
      else
        begin
          cdsList.Edit;
          cdsList.FieldByName('CHK_DATE').AsString := '';
          cdsList.FieldByName('CHK_USER').AsString := '';
          cdsList.Post;
        end;

  except
    on E:Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TfrmTransOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open2(MaxId2); 
end;

procedure TfrmTransOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700018') then Raise Exception.Create('你没有删除收款单的权限,请和管理员联系.');
end;

procedure TfrmTransOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

procedure TfrmTransOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  with TfrmTransOrder.Create(nil) do
    begin
      try
        Open(cdsList.FieldByName('TRANS_ID').AsString);
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmTransOrderList.FormShow(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
end;

procedure TfrmTransOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clHighlight;
  end;
  
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

end.
