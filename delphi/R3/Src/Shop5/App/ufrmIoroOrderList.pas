unit ufrmIoroOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,objBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmVoucherOrderList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DataSource1: TDataSource;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    frfVoucherOrder: TfrReport;
    PrintDBGridEh1: TPrintDBGridEh;
    Label5: TLabel;
    fndACCOUNT_ID: TzrComboBoxList;
    Label4: TLabel;
    fndVOUC_USER: TzrComboBoxList;
    cdsBrowser: TZQuery;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure frfVoucherOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure frfVoucherOrderGetValue(const ParName: String;
      var ParValue: Variant);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    IsEnd2: boolean;
    MaxId2:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function EncodeSQL(id:string;var w:string):string;
    procedure Open(Id:string);
    procedure ChangeButton;
    function sumField(TableName:TClientDataSet;FieldName:string):Real;
    procedure OpenDetail(Id:string);
    function PrintSQL(id:string):string;
  end;

implementation
uses uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil,ufrmVoucherOrder;
{$R *.dfm}

procedure TfrmVoucherOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmVoucherOrderList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
//  if Column.FieldName = 'SEQ_NO' then
//     Background := clBtnFace;
end;

function TfrmVoucherOrderList.EncodeSQL(id: string;var w:string): string;
var
  strSql,strWhere: string;
  rs:TZQuery;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  //帐款日期
  strWhere := strWhere + ' and A.VOUC_DATE>=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D1.Date))+ ' and A.VOUC_DATE<=' + QuotedStr(FormatDateTime('YYYY-MM-DD', P1_D2.Date));
  strWhere := strWhere + ' and A.COMP_ID='''+Global.CompanyID+'''';

  if fndACCOUNT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ACCOUNT_ID = '+QuotedStr(fndACCOUNT_ID.AsString);

  if fndVOUC_USER.AsString <> '' then
     strWhere := strWhere + ' and A.VOUC_USER = '+QuotedStr(fndVOUC_USER.AsString);

  if id<>'' then
     strWhere := strWhere + ' and A.VOUC_ID > '+QuotedStr(id);
     
  case fndSTATUS.ItemIndex of
  1:strWhere := strWhere + ' and CHK_DATE is null ';
  2:strWhere := strWhere + ' and CHK_DATE is not null ';
  end;
  
  strSql :=
     'select top 100 jd.*,d.USER_NAME as CHK_USER_TEXT,E.CLIENT_NAME  from ('+
     'select jc.*,c.USER_NAME as VOUC_USER_TEXT from ('+
     'select A.CLIENT_ID,A.VOUC_ID,A.COMP_ID,A.GLIDE_NO,A.ACCOUNT_ID,A.VOUC_DATE,A.VOUC_USER,A.CHK_DATE,A.REMARK,A.CHK_USER,B.ACCT_NAME as ACCOUNT_ID_TEXT,A.COMM '+
     'from RCK_VOUCHERORDER A,VIW_ACCOUNT_INFO B where A.ACCOUNT_ID=B.ACCOUNT_ID '+strWhere+' ) jc '+
     'left outer join VIW_USERS c on jc.VOUC_USER=c.USER_ID ) jd '+
     'left outer join VIW_USERS d on jd.CHK_USER=d.USER_ID '+
     'left outer join VIW_CLIENTINFO E on jd.CLIENT_ID=E.CLIENT_ID '+
     ' order by GLIDE_NO';
  result := strSql;
end;

procedure TfrmVoucherOrderList.Open(Id: string);
var
  rs:TClientDataSet;
  Str:string;
  tmp:TZQuery;
begin
  if not Visible then Exit;
  if Id='' then cdsBrowser.close;
  rs := TClientDataSet.Create(nil);
  cdsBrowser.DisableControls;
  try
    rs.CommandText := EncodeSQL(Id,Str);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('VOUC_ID').AsString;
    if Id='' then
       begin
         cdsBrowser.Data := rs.Data;
         cdsBrowser.IndexFieldNames := 'GLIDE_NO';
       end
    else
       cdsBrowser.AppendData(rs.Data,true);
    if rs.RecordCount <100 then IsEnd := True else IsEnd := false;
  finally
    cdsBrowser.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmVoucherOrderList.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  if IsEnd or not DataSet.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);
  OpenDetail(cdsBrowser.FieldbyName('VOUC_ID').AsString);  
  if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='弃审'
  else
    actAudit.Caption:='审核';
end;

procedure TfrmVoucherOrderList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if Key=#13 then   actFind.OnExecute(nil);
end;

procedure TfrmVoucherOrderList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmVoucherOrderList.InitGrid;
begin
  InitGridPickList(DBGridEh1);
end;

procedure TfrmVoucherOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndACCOUNT_ID.DataSet := Global.GeTZQueryFromName('RCK_ACCOUNT_INFO');
  fndVOUC_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndSTATUS.ItemIndex := 0;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmVoucherOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
  if cdsBrowSer.IsEmpty then cdsDetail.Close;
  if not cdsBrowSer.IsEmpty then
  begin
    if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
  end;
end;

procedure TfrmVoucherOrderList.AddRecord(AObj: TRecord_);
begin
  actFindExecute(nil);
  if cdsBrowser.Locate('VOUC_ID',AObj.FieldbyName('VOUC_ID').AsString,[]) then;
  OpenDetail(cdsBrowser.FieldbyName('VOUC_ID').AsString);
end;

procedure TfrmVoucherOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  if cdsBrowSer.IsEmpty then cdsDetail.Close;
  if not cdsBrowSer.IsEmpty then
  begin
    if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
  end;
end;

procedure TfrmVoucherOrderList.OpenDetail(Id: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    pid := id;
    Params.ParamByName('VOUC_ID',True).asString := id;
    cdsDetail.Close;
    Factor.Open(cdsDetail,'TVoucherData',Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmVoucherOrderList.Timer1Timer(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty then Exit;
  if pid<>cdsBrowser.FieldbyName('VOUC_ID').AsString then OpenDetail(cdsBrowser.FieldbyName('VOUC_ID').AsString);
end;

procedure TfrmVoucherOrderList.ChangeButton;
begin
end;

function TfrmVoucherOrderList.PrintSQL(id: string): string;
begin
  result :='select jd.GLIDE_NO 收支凭证单号,'+
   'I.ACCT_NAME as 帐户名称,'+
   'F.COMP_NAME as 门店名称,'+
   'jd.REMARK as 说明,'+
   'jd.SEQNO as 序号,'+
   'H.ITEM_NAME as 项目名称,'+
   'jd.BREMARK as 摘要,'+
   'jd.VOUC_DATE as 账款日期,'+
   'jd.IN_MNY as 收入,'+
   'jd.OUT_MNY as 支出,'+
   'jd.VOUC_USER_TEXT as 开单员,'+
   'd.USER_NAME as 审核人,E.CLIENT_NAME 往来单位  from ('+
   'select jc.*,c.USER_NAME as VOUC_USER_TEXT from ('+
   'select A.CLIENT_ID,A.VOUC_ID,A.COMP_ID,A.GLIDE_NO,A.ACCOUNT_ID,A.VOUC_DATE,A.VOUC_USER,'+
   'A.CHK_DATE,A.REMARK,A.CHK_USER,A.COMM,B.SEQNO,B.ITEM_ID,B.IN_MNY,B.OUT_MNY,  '+
   'B.REMARK BREMARK '+
   'from RCK_VOUCHERORDER A,RCK_VOUCHERDATA B where A.VOUC_ID=B.VOUC_ID and A.VOUC_ID='+QuotedStr(id)+'  ) jc '+
   'left outer join VIW_USERS c on jc.VOUC_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.CHK_USER=d.USER_ID '+
   'left outer join CA_COMPANY F on jd.COMP_ID=F.COMP_ID '+
   'left outer join RCK_ITEM_INFO H on jd.ITEM_ID=H.ITEM_ID and H.COMM<>''02'' and H.COMM<>''12'' '+
   'left outer join VIW_ACCOUNT_INFO I on jd.ACCOUNT_ID=I.ACCOUNT_ID '+
   'left outer join VIW_CLIENTINFO E on jd.CLIENT_ID=E.CLIENT_ID ';
end;

procedure TfrmVoucherOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700035') then Raise Exception.Create('你没有打印其他费用的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
         PrintReport(PrintSQL(cdsBrowser.FieldbyName('VOUC_ID').AsString),frfVoucherOrder);
      finally
         free;
      end;
    end;
end;

procedure TfrmVoucherOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700035') then Raise Exception.Create('你没有打印其他费用的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
         ShowReport(PrintSQL(cdsBrowser.FieldbyName('VOUC_ID').AsString),frfVoucherOrder);
      finally
         free;
      end;
    end;
end;

procedure TfrmVoucherOrderList.frfVoucherOrderUserFunction(const Name: String; p1,
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

procedure TfrmVoucherOrderList.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if cdsBrowser.IsEmpty then Exit;
  if pid<>cdsBrowser.FieldbyName('VOUC_ID').AsString then OpenDetail(cdsBrowser.FieldbyName('VOUC_ID').AsString);

end;

procedure TfrmVoucherOrderList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700031') then Raise Exception.Create('你没有添加其他费用的权限,请和管理员联系.');
  with TfrmVoucherOrder.Create(self) do
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

procedure TfrmVoucherOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if  (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('700032') then Raise Exception.Create('你没有修改其他费用的权限,请和管理员联系.');
  with TfrmVoucherOrder.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(cdsBrowser.FieldByName('VOUC_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmVoucherOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if  (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  with TfrmVoucherOrder.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Open(cdsBrowser.FieldByName('VOUC_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmVoucherOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('700033') then Raise Exception.Create('你没有删除其他费用的权限,请和管理员联系.');
   if MessageBox(Handle,'确认删除当前选中的其他费用？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmVoucherOrder.Create(self) do
      begin
        try
          Open(cdsBrowser.FieldByName('VOUC_ID').AsString);
          DeleteOrder;
          cdsBrowser.Delete;
          cdsDetail.Close;
          MessageBox(Handle,'删除其他费用成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmVoucherOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsBrowser.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('700034') then Raise Exception.Create('你没有审核其他费用的权限,请和管理员联系.');
  if cdsBrowser.FieldByName('CHK_DATE').AsString<>'' then
     begin
       if copy(cdsBrowser.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsBrowser.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前收支凭证执行弃审');
       if MessageBox(Handle,'确认弃审当前收支凭证？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if copy(cdsBrowser.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前收支凭证？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('COMP_ID',True).asString := cdsBrowser.FieldbyName('COMP_ID').AsString;
      Params.ParamByName('VOUC_ID',True).asString := cdsBrowser.FieldbyName('VOUC_ID').AsString;
      Params.ParamByName('CHK_DATE',True).asString := FormatDatetime('YYYY-MM-DD',date());
      Params.ParamByName('CHK_USER',True).asString := Global.UserID;
      if cdsBrowser.FieldByName('CHK_DATE').AsString='' then
      begin
         try
           Msg := Factor.ExecProc('TVoucherAudit',Params);
           actAudit.Caption:='弃审';
         except
           actAudit.Caption:='审核';
         end;
      end
      else
      begin
       try
         Msg := Factor.ExecProc('TVoucherUnAudit',Params) ;
         actAudit.Caption:='审核';
       except
         actAudit.Caption:='弃审';
       end;
      end;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    if cdsBrowser.FieldByName('CHK_DATE').AsString='' then
       begin
          cdsBrowser.Edit;
          cdsBrowser.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',date());
          cdsBrowser.FieldByName('CHK_USER').AsString := Global.UserID;
          cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
          cdsBrowser.Post;
       end
    else
       begin
          cdsBrowser.Edit;
          cdsBrowser.FieldByName('CHK_DATE').AsString := '';
          cdsBrowser.FieldByName('CHK_USER').AsString := '';
          cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := '';
          cdsBrowser.Post;
       end;
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
end;

procedure TfrmVoucherOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmVoucherOrderList.frfVoucherOrderGetValue(
  const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='总收入' then
    ParValue:=sumField(cdsDetail,'IN_MNY');
  if ParName='总支出' then
    ParValue:=sumField(cdsDetail,'OUT_MNY');
end;

function TfrmVoucherOrderList.sumField(TableName: TClientDataSet;
  FieldName: string): Real;
var re:Real;
begin
  TableName.First;
  re:=0;
  while not TableName.Eof do
  begin
    re:=re+TableName.FieldByName(FieldName).AsFloat;
    TableName.Next;
  end;
  Result:=re;
end;

procedure TfrmVoucherOrderList.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
 if cdsDetail.FieldByName('item_type').AsString='1' then
  begin
    if (Column.FieldName='ITEM_ID_TEXT')  then
      DBGridEh4.Canvas.Font.Color:=clLime;
  end
  else  if cdsDetail.FieldByName('item_type').AsString='2' then
  begin
    if (Column.FieldName='ITEM_ID_TEXT')  then
      DBGridEh4.Canvas.Font.Color:=clRed;
  end;
  DBGridEh4.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
