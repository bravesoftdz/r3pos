unit ufrmRecvOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,zBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmRecvOrderList = class(TframeToolForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    DataSource2: TDataSource;
    frfRecvOrder: TfrReport;
    actfrmBatchReck: TAction;
    RzPanel7: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndOrderStatus: TcxRadioGroup;
    fndRECV_USER: TzrComboBoxList;
    fndACCOUNT_ID: TzrComboBoxList;
    fndITEM_ID: TzrComboBoxList;
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    Label17: TLabel;
    cdsList: TZQuery;
    fndCLIENT_ID: TzrComboBoxList;
    Label1: TLabel;
    fndPAYM_ID: TcxComboBox;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzPageChange(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure frfRecvOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actDeleteExecute(Sender: TObject);
    procedure frfRecvOrderGetValue(const ParName: String;
      var ParValue: Variant);

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
uses uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmRecvOrder;
{$R *.dfm}

procedure TfrmRecvOrderList.InitGrid;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  InitGridPickList(DBGridEh2);
  rs := Global.GetZQueryFromName('PUB_PAYMENT');
  Column := FindColumn('PAYM_ID');
  if Column<>nil then
     begin
       rs.First;
       while not rs.Eof do
         begin
           Column.KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
           Column.PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
           rs.Next;
         end;
     end;
end;

procedure TfrmRecvOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);

  D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
  fndRECV_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_PAYMENT'),fndPAYM_ID.Properties.Items,'CODE_NAME');
  fndPAYM_ID.Properties.Items.Insert(0,'全部');
  fndPAYM_ID.ItemIndex := 0; 
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmRecvOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open2('');
end;

procedure TfrmRecvOrderList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700014') then Raise Exception.Create('你没有新增收款单的权限,请和管理员联系.');
  with TfrmRecvOrder.Create(self) do
    begin
      try
        Append;
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmRecvOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('700015') then Raise Exception.Create('你没有修改收款单的权限,请和管理员联系.');
  with TfrmRecvOrder.Create(self) do
    begin
      try
        Edit(cdsList.FieldByName('RECV_ID').AsString);
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmRecvOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
    with TfrmRecvOrder.Create(self) do
      begin
        try
          cid := cdsList.FieldbyName('SHOP_ID').AsString;
          Open(cdsList.FieldByName('RECV_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
end;

procedure TfrmRecvOrderList.ChangeButton;
begin
  if cdsList.Active and (cdsList.FieldByName('CHK_DATE').AsString = '') then actAudit.Caption := '审核' else actAudit.Caption := '弃审';
end;
procedure TfrmRecvOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
    if cdsList.IsEmpty then Raise Exception.Create('请选择待审核的收款单');
   if not ShopGlobal.GetChkRight('700017') then Raise Exception.Create('你没有审核收款单的权限,请和管理员联系.');
    if cdsList.FieldByName('CHK_DATE').AsString<>'' then
       begin
         if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
         if cdsList.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售单执行弃审');
         if MessageBox(Handle,'确认弃审当前收款单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end
    else
       begin
         if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
         if MessageBox(Handle,'确认审核当前收款单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    try
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsList.FieldbyName('TENANT_ID').AsInteger;
        Params.ParamByName('SHOP_ID').asString := cdsList.FieldbyName('SHOP_ID').AsString;
        Params.ParamByName('RECV_ID').asString := cdsList.FieldbyName('RECV_ID').AsString;
        Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',date());
        Params.ParamByName('CHK_USER').asString := Global.UserID;
        if cdsList.FieldByName('CHK_DATE').AsString='' then
           Msg := Factor.ExecProc('TRecvOrderAudit',Params)
        else
           Msg := Factor.ExecProc('TRecvOrderUnAudit',Params) ;
      finally
         Params.free;
      end;
      MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
      if cdsList.FieldByName('CHK_DATE').AsString='' then
         begin
            cdsList.Edit;
            cdsList.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',date());
            cdsList.FieldByName('CHK_USER').AsString := Global.UserID;
            cdsList.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
            cdsList.Post;
         end
      else
         begin
            cdsList.Edit;
            cdsList.FieldByName('CHK_DATE').AsString := '';
            cdsList.FieldByName('CHK_USER').AsString := '';
            cdsList.FieldByName('CHK_USER_TEXT').AsString := '';
            cdsList.Post;
         end;
    except
      on E:Exception do
         begin
           Raise Exception.Create(E.Message);
         end;
    end;
end;

procedure TfrmRecvOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open2('');
end;

function TfrmRecvOrderList.EncodeSQL2(id: string; var w: string): string;
var
  strSql,strWhere: string;
  rs:TZQuery;
begin
  if D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  strWhere := strWhere + ' A.SHOP_ID=:SHOP_ID and A.TENANT_ID=:TENANT_ID';
  //帐款日期
  strWhere := strWhere + ' and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2';
  if fndPAYM_ID.ItemIndex > 0 then
     strWhere := strWhere + ' and A.PAYM_ID='''+TRecord_(fndPAYM_ID.Properties.Items.Objects[fndPAYM_ID.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  if fndSHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndSHOP_ID.AsString+'''';
  if fndACCOUNT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ACCOUNT_ID='''+fndACCOUNT_ID.AsString+'''';
  if fndITEM_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ITEM_ID='''+fndITEM_ID.AsString+'''';
  if fndRECV_USER.AsString <> '' then
     strWhere := strWhere + ' and A.RECV_USER='''+fndRECV_USER.AsString+'''';
  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndCLIENT_ID.AsString+'''';
  case fndOrderStatus.ItemIndex of
  1:strWhere := strWhere + ' and CHK_DATE is null';
  2:strWhere := strWhere + ' and CHK_DATE is not null';
  end;
  if id<>'' then
     strWhere := strWhere + ' and A.RECV_ID > '+QuotedStr(id);
  strSql :='select A.RECV_ID,A.SHOP_ID,A.TENANT_ID,A.ACCOUNT_ID,A.CLIENT_ID,A.PAYM_ID,A.ITEM_ID,A.GLIDE_NO,A.RECV_DATE,A.RECV_USER,A.REMARK,A.RECV_MNY,A.CHK_DATE,A.CHK_USER,A.CREA_DATE,A.COMM from ACC_RECVORDER A where '+strWhere;
  strSql :='select jc.*,c.ACCT_NAME as ACCOUNT_ID_TEXT from ('+strSql+') jc '+
           'left outer join VIW_ACCOUNT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.ACCOUNT_ID=c.ACCOUNT_ID';
  strSql :='select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+strSql+') jd '+
           'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID';
  strSql :='select je.*,e.USER_NAME as RECV_USER_TEXT  from ('+strSql+') je '+
           'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.RECV_USER=e.USER_ID ';
  strSql :='select jf.*,f.CLIENT_NAME as CLIENT_ID_TEXT  from ('+strSql+') jf '+
           'left outer join VIW_CUSTOMER f on jf.CLIENT_ID=f.CLIENT_ID';
  strSql :='select jg.*,g.CODE_NAME as PAYM_ID_TEXT  from ('+strSql+') jg '+
           'left outer join VIW_PAYMENT g on jg.TENANT_ID=g.TENANT_ID and jg.PAYM_ID=g.CODE_ID';
  strSql :='select jh.*,h.USER_NAME as CHK_USER_TEXT  from ('+strSql+') jh '+
           'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by RECV_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') order by RECV_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') order by RECV_ID limit 600';
  else
    result := 'select * from ('+strSql+') order by RECV_ID';
  end;
end;

procedure TfrmRecvOrderList.Open2(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL2(Id,Str);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldbyName('RECV_ID').AsString;
    if Id='' then
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
    if rs.RecordCount <600 then IsEnd2 := True else IsEnd2 := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmRecvOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;

  Open2(MaxId2);

end;

procedure TfrmRecvOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.FillRect(ARect);
      DrawText(DbGridEh2.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmRecvOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

function TfrmRecvOrderList.PrintSQL2(tenantid,id: string): string;
begin
  result :=
  'select j.* '+
  'from ( '+
  'select ji.*,i.USER_NAME as RECV_USER_TEXT from ('+
  'select jh.*,h.USER_NAME as CHK_USER_TEXT from ('+
  'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
  'select jf.*,f.ACCT_NAME as ACCOUNT_ID_TEXT from ('+
  'select je.*,e.CODE_NAME as ITEM_ID_TEXT from ('+
  'select jd.*,d.CLIENT_NAME as CLIENT_ID_TEXT,d.CLIENT_CODE,d.ADDRESS,d.POSTALCODE,d.LINKMAN,d.TELEPHONE2 as MOVE_TELE from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.SEQNO,A.RECV_MNY,'+
  'b.ACCT_INFO,c.CLIENT_ID,b.ABLE_DATE,C.ITEM_ID,C.ACCOUNT_ID,C.GLIDE_NO,C.RECV_USER,B.RECK_MNY,B.RECV_MNY as ABLE_RECV_MNY,B.ACCT_MNY,C.RECV_MNY as TOTAL_RECV_MNY,C.REMARK,C.RECV_DATE,B.RECV_TYPE,C.CHK_USER '+
  'from ACC_RECVDATA A,ACC_RECVABLE_INFO B,ACC_RECVORDER C where A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=C.TENANT_ID and A.ABLE_ID=B.ABLE_ID and A.RECV_ID=C.RECV_ID and A.TENANT_ID='+tenantid+' and A.RECV_ID='''+id+''' ) jd '+
  'left outer join VIW_CUSTOMER d on jd.CLIENT_ID=d.CLIENT_ID ) je '+
  'left outer join VIW_ITEM_INFO e on je.TENANT_ID=e.TENANT_ID and je.ITEM_ID=e.CODE_ID ) jf '+
  'left outer join VIW_ACCOUNT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.ACCOUNT_ID=f.ACCOUNT_ID ) jg '+
  'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
  'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID ) ji '+
  'left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.RECV_USER=i.USER_ID ) j order by j.SEQNO' ;
end;

procedure TfrmRecvOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('700018') then Raise Exception.Create('你没有打印收款单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           PrintReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;

end;

procedure TfrmRecvOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('700018') then Raise Exception.Create('你没有打印收款单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           ShowReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;
end;

procedure TfrmRecvOrderList.frfRecvOrderUserFunction(const Name: String; p1,
  p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

procedure TfrmRecvOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
   if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('700016') then Raise Exception.Create('你没有删除收款单的权限,请和管理员联系.');
   if MessageBox(Handle,'确认删除当前选中的收款单？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmRecvOrder.Create(self) do
      begin
        try
          Open(cdsList.FieldByName('RECV_ID').AsString);
          DeleteOrder;
          cdsList.Delete;
          if cdsList.IsEmpty then cdsDetail.Close;
          MessageBox(Handle,'删除收款单成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmRecvOrderList.AddRecord(AObj: TRecord_);
begin
  if cdsList.Locate('RECV_ID',AObj.FieldbyName('RECV_ID').AsString,[]) then
     cdsList.Edit
  else
     cdsList.Append;
  AObj.WriteToDataSet(cdsList,false);
  cdsList.Post;
end;

procedure TfrmRecvOrderList.frfRecvOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

function TfrmRecvOrderList.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if DBGridEh2.Columns[i].FieldName = FieldName then
         begin
           result := DBGridEh2.Columns[i];
           break;
         end;
    end;
end;

end.
