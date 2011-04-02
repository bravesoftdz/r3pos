unit ufrmIoroOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,ZBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmIoroOrderList = class(TframeToolForm)
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
    frfIoroOrder: TfrReport;
    PrintDBGridEh1: TPrintDBGridEh;
    Label4: TLabel;
    fndIORO_USER: TzrComboBoxList;
    cdsBrowser: TZQuery;
    Label17: TLabel;
    Label40: TLabel;
    fndCLIENT_ID: TzrComboBoxList;
    fndSHOP_ID: TzrComboBoxList;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure frfIoroOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure frfIoroOrderGetValue(const ParName: String;
      var ParValue: Variant);

  private
    FIoroType: integer;
    procedure SetIoroType(const Value: integer);
    function CheckCanExport:boolean;
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function EncodeSQL(id:string;var w:string):string;
    procedure Open(Id:string);
    function PrintSQL(id:string):string;
    property IoroType:integer read FIoroType write SetIoroType;
  end;

implementation
uses uGlobal, uFnUtil, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil,ufrmIoroOrder,
  ufrmBasic;
{$R *.dfm}

procedure TfrmIoroOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmIoroOrderList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
//  if Column.FieldName = 'SEQ_NO' then
//     Background := clBtnFace;
end;

function TfrmIoroOrderList.EncodeSQL(id: string;var w:string): string;
var
  strSql,strWhere: string;
  rs:TZQuery;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');
  //日期
  strWhere := strWhere + 'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.IORO_TYPE='''+inttostr(IoroType)+''' and A.IORO_DATE>=' + FormatDateTime('YYYYMMDD', P1_D1.Date)+ ' and A.IORO_DATE<=' + FormatDateTime('YYYYMMDD', P1_D2.Date);
  if fndSHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndSHOP_ID.AsString+'''';

  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID = '+QuotedStr(fndCLIENT_ID.AsString);

  if fndIORO_USER.AsString <> '' then
     strWhere := strWhere + ' and A.IORO_USER = '+QuotedStr(fndIORO_USER.AsString);

  if id<>'' then
     strWhere := strWhere + ' and A.IORO_ID > '+QuotedStr(id);
     
  case fndSTATUS.ItemIndex of
  1:strWhere := strWhere + ' and A.CHK_DATE is null ';
  2:strWhere := strWhere + ' and A.CHK_DATE is not null ';
  end;
  
  case IoroType of
  1:strSql :=
    'select jg.*,g.USER_NAME as CHK_USER_TEXT from ('+
    'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
    'select je.*,e.USER_NAME as IORO_USER_TEXT from ('+
    'select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+
    'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
    'select A.*,B.CLIENT_NAME as CLIENT_ID_TEXT from ACC_IOROORDER A,VIW_CUSTOMER B where A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID '+strWhere+' ) jc '+
    'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
    'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID ) je '+
    'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.IORO_USER=e.USER_ID ) jf '+
    'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
    'left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.CHK_USER=g.USER_ID';
  2:strSql :=  //支出
    'select jg.*,g.USER_NAME as CHK_USER_TEXT from ('+
    'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
    'select je.*,e.USER_NAME as IORO_USER_TEXT from ('+
    'select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+
    'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
    'select A.*,B.CLIENT_NAME as CLIENT_ID_TEXT from ACC_IOROORDER A,VIW_CLIENTINFO B where A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID '+strWhere+' ) jc '+
    'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
    'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID ) je '+
    'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.IORO_USER=e.USER_ID ) jf '+
    'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
    'left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.CHK_USER=g.USER_ID';
  end;

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by IORO_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by IORO_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') order by IORO_ID limit 600';
  else
    result := 'select * from ('+strSql+') order by IORO_ID';
  end;
end;

procedure TfrmIoroOrderList.Open(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsBrowser.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsBrowser.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id,Str);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('IORO_ID').AsString;
    if Id='' then
       begin
         rs.SaveToStream(sm);
         cdsBrowser.LoadFromStream(sm);
         cdsBrowser.IndexFieldNames := 'GLIDE_NO';
       end
    else
       begin
         rs.SaveToStream(sm);
         cdsBrowser.AddFromStream(sm);
       end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsBrowser.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmIoroOrderList.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='弃审'
  else
    actAudit.Caption:='审核';
  if IsEnd or not DataSet.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmIoroOrderList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if Key=#13 then   actFind.OnExecute(nil);
end;

procedure TfrmIoroOrderList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmIoroOrderList.InitGrid;
begin
  InitGridPickList(DBGridEh1);
end;

procedure TfrmIoroOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndIORO_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndSTATUS.ItemIndex := 0;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmIoroOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',1) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',1) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');

  Open('');
  if not cdsBrowser.IsEmpty then
  begin
    if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
  end;
end;

procedure TfrmIoroOrderList.AddRecord(AObj: TRecord_);
var rs:TZQuery;
begin
  if cdsBrowser.Locate('IORO_ID',AObj.FieldbyName('IORO_ID').AsString,[]) then
    begin
      cdsBrowser.Edit;
      AObj.WriteToDataSet(cdsBrowser,false);
      cdsBrowser.Post;
    end
  else
    begin
      try
        rs := TZQuery.Create(nil);
        rs.SQL.Text := ' select GLIDE_NO from ACC_IOROORDER where  TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID ';
        rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        rs.Params.ParamByName('IORO_ID').AsString := AObj.FieldbyName('IORO_ID').AsString;
        Factor.Open(rs);

        cdsBrowser.Append;
        AObj.WriteToDataSet(cdsBrowser,false);
        cdsBrowser.FieldByName('GLIDE_NO').AsString := rs.FieldbyName('GLIDE_NO').AsString;
        cdsBrowser.Post;
      finally
        rs.Free;
      end;
    end;
end;

function TfrmIoroOrderList.PrintSQL(id: string): string;
var tb:string;
  code_name:string;
begin
  case IoroType of
  1:begin
      tb := 'VIW_CUSTOMER';
      code_name := '收入';
    end;
  2:begin
      tb := 'VIW_CLIENTINFO';
      code_name := '支出';
    end;
  end;
  result :=
  'select j.*,'''+code_name+''' as CODE_NAME '+
  'from ( '+
  'select jl.*,l.CODE_NAME as PAYM_ID_TEXT from ('+
  'select jk.*,k.USER_NAME as CREA_USER_TEXT from ('+
  'select ji.*,i.USER_NAME as IORO_USER_TEXT from ('+
  'select jh.*,h.USER_NAME as CHK_USER_TEXT from ('+
  'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
  'select jf.*,f.ACCT_NAME as ACCOUNT_ID_TEXT from ('+
  'select je.*,e.CODE_NAME as ITEM_ID_TEXT from ('+
  'select jd.*,d.CLIENT_NAME as CLIENT_ID_TEXT,d.CLIENT_CODE,d.ADDRESS,d.POSTALCODE,d.LINKMAN,d.TELEPHONE2 as MOVE_TELE from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.IORO_ID,A.SEQNO,A.IORO_MNY,A.PAYM_ID,A.BILL_NO,'+
  'A.IORO_INFO,c.CLIENT_ID,C.ITEM_ID,A.ACCOUNT_ID,C.GLIDE_NO,C.IORO_USER,C.IORO_MNY as TOTAL_IORO_MNY,C.CREA_USER,C.REMARK,C.IORO_DATE,C.IORO_TYPE,C.CHK_USER '+
  'from ACC_IORODATA A,ACC_IOROORDER C where A.TENANT_ID=C.TENANT_ID and A.IORO_ID=C.IORO_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.IORO_ID='''+id+''' ) jd '+
  'left outer join '+tb+' d on jd.TENANT_ID=d.TENANT_ID and jd.CLIENT_ID=d.CLIENT_ID ) je '+
  'left outer join VIW_ITEM_INFO e on je.TENANT_ID=e.TENANT_ID and je.ITEM_ID=e.CODE_ID ) jf '+
  'left outer join VIW_ACCOUNT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.ACCOUNT_ID=f.ACCOUNT_ID ) jg '+
  'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
  'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID ) ji '+
  'left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.IORO_USER=i.USER_ID ) jk '+
  'left outer join VIW_USERS k on jk.TENANT_ID=k.TENANT_ID and jk.CREA_USER=k.USER_ID ) jl '+
  'left outer join VIW_PAYMENT l on jl.TENANT_ID=l.TENANT_ID and jl.PAYM_ID=l.CODE_ID ) j '+
  'order by j.SEQNO' ;
end;

procedure TfrmIoroOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',6) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',6) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');

  with TfrmFastReport.Create(Self) do
    begin
      try
         PrintReport(PrintSQL(cdsBrowser.FieldbyName('IORO_ID').AsString),frfIoroOrder);
      finally
         free;
      end;
    end;
end;

procedure TfrmIoroOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',6) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',6) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
         ShowReport(PrintSQL(cdsBrowser.FieldbyName('IORO_ID').AsString),frfIoroOrder);
      finally
         free;
      end;
    end;
end;

procedure TfrmIoroOrderList.frfIoroOrderUserFunction(const Name: String; p1,
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

procedure TfrmIoroOrderList.actNewExecute(Sender: TObject);
begin
  inherited;
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',2) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',2) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');

  with TfrmIoroOrder.Create(self) do
  begin
    try
      IoroType := self.IoroType;
      OnSave := AddRecord;
      Append;
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmIoroOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if  (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('审核状态下,不能进行修改操作!');
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',3) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',3) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');
    
  with TfrmIoroOrder.Create(self) do
  begin
    try
      IoroType := self.IoroType;
      OnSave := AddRecord;
      Edit(cdsBrowser.FieldByName('IORO_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmIoroOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if  (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  with TfrmIoroOrder.Create(self) do
  begin
    try
      IoroType := self.IoroType;
      OnSave := AddRecord;
      Open(cdsBrowser.FieldByName('IORO_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmIoroOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty then Exit;
  if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('审核状态下,不能进行删除操作!');
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',4) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',4) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');

   if MessageBox(Handle,'确认删除当前选中的其他费用？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmIoroOrder.Create(self) do
      begin
        try
          IoroType := self.IoroType;
          Open(cdsBrowser.FieldByName('IORO_ID').AsString);
          DeleteOrder;
          cdsBrowser.Delete;
          cdsDetail.Close;
          MessageBox(Handle,'删除当前单据成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmIoroOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsBrowser.IsEmpty then exit;
  if IoroType = 1 then
    if not ShopGlobal.GetChkRight('21500001',5) then Raise Exception.Create('你没有添加其他收入的权限,请和管理员联系.')
  else
    if not ShopGlobal.GetChkRight('21600001',5) then Raise Exception.Create('你没有添加其他支出的权限,请和管理员联系.');

  if cdsBrowser.FieldByName('CHK_DATE').AsString<>'' then
     begin
       if copy(cdsBrowser.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsBrowser.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
       if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if copy(cdsBrowser.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('IORO_ID').asString := cdsBrowser.FieldbyName('IORO_ID').AsString;
      Params.ParamByName('IORO_TYPE').AsInteger := IoroType;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',date());
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if cdsBrowser.FieldByName('CHK_DATE').AsString='' then
      begin
         try
           Msg := Factor.ExecProc('TIoroAudit',Params);
           actAudit.Caption:='弃审';
         except
           actAudit.Caption:='审核';
         end;
      end
      else
      begin
       try
         Msg := Factor.ExecProc('TIoroUnAudit',Params) ;
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

procedure TfrmIoroOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(nil);
end;

procedure TfrmIoroOrderList.SetIoroType(const Value: integer);
begin
  FIoroType := Value;
  case Value of
  1:begin
     fndCLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
     Label17.Caption := '客户名称';
     DBGridEh1.Columns[3].Title.Caption := '客户名称';
     Caption := '其他收入';
     lblToolCaption.Caption := '当前位置->'+Caption;
     fndCLIENT_ID.DataSet := Global.GeTZQueryFromName('PUB_CUSTOMER');
     TabSheet1.Caption := Caption + '查询';
    end;
  2:begin
     fndCLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');
     Label17.Caption := '供应商名称';
     DBGridEh1.Columns[3].Title.Caption := '供应商名称';
     Caption := '其他支出';
     lblToolCaption.Caption := '当前位置->'+Caption;
     fndCLIENT_ID.DataSet := Global.GeTZQueryFromName('PUB_CLIENTINFO');
     TabSheet1.Caption := Caption + '查询';
    end;
  end;
  Open('');
  if not cdsBrowSer.IsEmpty then
  begin
    if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
  end;
end;

function TfrmIoroOrderList.CheckCanExport: boolean;
begin
  if IoroType = 1 then
    Result := ShopGlobal.GetChkRight('21500001',7)
  else
    Result := ShopGlobal.GetChkRight('21600001',7);

end;

procedure TfrmIoroOrderList.frfIoroOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

end.
