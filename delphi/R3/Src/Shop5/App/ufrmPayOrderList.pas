{  21400001	0	付款单	1	查询	2	新增 	3	修改	4	删除	5	审核	6	打印 	7	导出  }

unit ufrmPayOrderList;

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
  TfrmPayOrderList = class(TframeToolForm)
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
    actfrmBatchReck: TAction;
    cdsList: TZQuery;
    frfPayOrder: TfrReport;
    TabSheet2: TRzTabSheet;
    Panel1: TPanel;
    RzPanel7: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    Label1: TLabel;
    Label40: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndOrderStatus: TcxRadioGroup;
    fndPAY_USER: TzrComboBoxList;
    fndACCOUNT_ID: TzrComboBoxList;
    fndITEM_ID: TzrComboBoxList;
    fndCLIENT_ID: TzrComboBoxList;
    fndPAYM_ID: TcxComboBox;
    fndSHOP_ID: TzrComboBoxList;
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    RzPanel1: TRzPanel;
    Label3: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label2: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndSTATUS: TcxRadioGroup;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    CdsPayList: TZQuery;
    PayListDs: TDataSource;
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
    procedure frfPayOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
    procedure actDeleteExecute(Sender: TObject);
    procedure frfPayOrderGetValue(const ParName: String; var ParValue: Variant);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);

  private
    procedure ChangeButton;
    function  CheckCanExport: boolean; override;
  public
    { Public declarations }
    IsEnd1, IsEnd2: boolean;
    MaxId1, MaxId2:string;
    pid:string;
    locked:boolean;
    function FindColumn(FieldName:string):TColumnEh;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);

    function EncodeSQL1(id:string;var w:string):string;
    function EncodeSQL2(id:string;var w:string):string;
    procedure Open1(Id:string);
    procedure Open2(Id:string);
    function PrintSQL2(tenantid:string;id:string):string;
  end;

implementation
uses uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmPayOrder,
  ufrmBasic, ObjCommon;
{$R *.dfm}

procedure TfrmPayOrderList.InitGrid;
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

procedure TfrmPayOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  fndITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
  fndPAY_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_PAYMENT'),fndPAYM_ID.Properties.Items,'CODE_NAME');
  fndPAYM_ID.Properties.Items.Insert(0,'全部');
  fndPAYM_ID.ItemIndex := 0; 
  InitGrid;
  //第一分页应付账款:
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      SetEditStyle(dsBrowse,fndSHOP_ID.Style);
      fndSHOP_ID.Properties.ReadOnly := True;

      SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
      fndP1_SHOP_ID.Properties.ReadOnly := True;
    end;
  fndP1_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');  
  RzPage.ActivePageIndex := 0;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label3.Caption := '仓库名称';
      Label40.Caption := '付款仓库';
    end;
  ChangeButton;
end;

procedure TfrmPayOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  case RzPage.ActivePageIndex of
   0: Open1('');
   1: Open2('');
  end;
end;

procedure TfrmPayOrderList.actNewExecute(Sender: TObject);
var
  ABLE_ID: string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21400001',2) then Raise Exception.Create('你没有新增付款单的权限,请和管理员联系.');
  ABLE_ID:='';
  if (RzPage.ActivePage=TabSheet1) and (CdsPayList.Active) and (CdsPayList.RecordCount>0) then
    ABLE_ID:=trim(CdsPayList.fieldbyName('ABLE_ID').AsString);

  with TfrmPayOrder.Create(self) do
    begin
      try
        Append;
        OnSave := AddRecord;
        //直接选择应付单进行收款
        if ABLE_ID<>'' then
        begin
          edtCLIENT_ID.KeyValue:=trim(CdsPayList.fieldbyName('CLIENT_ID').AsString);
          edtCLIENT_ID.Text:=trim(CdsPayList.fieldbyName('CLIENT_ID_TEXT').AsString);
          FillData;
          //定位到ABLE_ID
          if cdsDetail.Locate('ABLE_ID',ABLE_ID,[]) then
          begin
            if cdsDetail.State<>dsEdit then cdsDetail.Edit;
            cdsDetail.FieldByName('A').AsString:='1';
            cdsDetail.FieldByName('PAY_MNY').AsFloat:=cdsDetail.FieldByName('BALA_MNY').AsFloat;
            cdsDetail.FieldByName('BALA_MNY').AsFloat:=0;
            cdsDetail.Post;
          end; 
        end;
        //直接选择应付单进行收款

        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmPayOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('21400001',3) then Raise Exception.Create('你没有修改付款单的权限,请和管理员联系.');
  if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('此单已经审核,不能执行修改操作.');  
  with TfrmPayOrder.Create(self) do
    begin
      try
        Edit(cdsList.FieldByName('PAY_ID').AsString);
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmPayOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
    with TfrmPayOrder.Create(self) do
      begin
        try
          cid := cdsList.FieldbyName('SHOP_ID').AsString;
          Open(cdsList.FieldByName('PAY_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
end;

procedure TfrmPayOrderList.ChangeButton;
begin
  if cdsList.Active and (cdsList.FieldByName('CHK_DATE').AsString = '') then actAudit.Caption := '审核' else actAudit.Caption := '弃审';
//  if rzPage.ActivePageIndex = 0 then
     begin
       actDelete.Enabled := rzPage.ActivePageIndex > 0;
       actEdit.Enabled := rzPage.ActivePageIndex > 0;
       actSave.Enabled := rzPage.ActivePageIndex > 0;
       actCancel.Enabled := false;
       actInfo.Enabled := rzPage.ActivePageIndex > 0;
       actAudit.Enabled := rzPage.ActivePageIndex > 0;
     end;
end;
procedure TfrmPayOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
    if cdsList.IsEmpty then Raise Exception.Create('请选择待审核的付款单');
   if not ShopGlobal.GetChkRight('21400001',5) then Raise Exception.Create('你没有审核付款单的权限,请和管理员联系.');
    if cdsList.FieldByName('CHK_DATE').AsString<>'' then
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
         if cdsList.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售单执行弃审');
         if MessageBox(Handle,'确认弃审当前付款单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end
    else
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
         if MessageBox(Handle,'确认审核当前付款单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    try
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsList.FieldbyName('TENANT_ID').AsInteger;
        Params.ParamByName('SHOP_ID').asString := cdsList.FieldbyName('SHOP_ID').AsString;
        Params.ParamByName('PAY_ID').asString := cdsList.FieldbyName('PAY_ID').AsString;
        Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',date());
        Params.ParamByName('CHK_USER').asString := Global.UserID;
        if cdsList.FieldByName('CHK_DATE').AsString='' then
           Msg := Factor.ExecProc('TPayOrderAudit',Params)
        else
           Msg := Factor.ExecProc('TPayOrderUnAudit',Params) ;
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

procedure TfrmPayOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open1('');
end;

function TfrmPayOrderList.EncodeSQL1(id: string; var w: string): string;
var
  strSql,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('付款查询开始日期不能大于结束日期');
  strWhere := strWhere + ' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' ';
  //分批取数据的条件:
  if trim(id)<>'' then
    strWhere:=strWhere+' A.ABLE_ID > '+QuotedStr(id);
  //帐款日期:
  if P1_D1.Date=P1_D2.Date then
    strWhere := strWhere + ' and A.ABLE_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' ' 
  else
    strWhere := strWhere + ' and A.ABLE_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.ABLE_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+'';
  //门店条件:
  if fndP1_SHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+'''';
  //客户条件:
  if fndP1_CLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+'''';

  case fndSTATUS.ItemIndex of
   1:strWhere := strWhere + ' and isnull(A.RECK_MNY,0)<>0 ';
   2:strWhere := strWhere + ' and isnull(A.RECK_MNY,0)=0 ';
  end;

  strSql:=
    'select A.ABLE_ID as ABLE_ID '+
    ',A.SHOP_ID as SHOP_ID '+
    ',A.CLIENT_ID as CLIENT_ID'+
    ',B.CLIENT_NAME as CLIENT_ID_TEXT'+
    ',A.ACCT_INFO as ACCT_INFO'+
    ',A.ABLE_TYPE as ABLE_TYPE'+
    ',A.ACCT_MNY as ACCT_MNY'+
    ',A.PAYM_MNY as PAYM_MNY'+
    ',A.REVE_MNY as REVE_MNY'+
    ',A.RECK_MNY as RECK_MNY'+
    ',A.ABLE_DATE as ABLE_DATE'+
    ',A.NEAR_DATE as NEAR_DATE'+
    ',C.SHOP_NAME as SHOP_ID_TEXT '+
    ' from ACC_PAYABLE_INFO A,VIW_CLIENTINFO B,CA_SHOP_INFO C  '+
    ' where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
    ' '+strWhere+' ';

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by ABLE_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by ABLE_ID) tp fetch first 600  rows only';

  5:result := 'select * from ('+strSql+') j order by ABLE_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by ABLE_ID';
  end;   
end;

procedure TfrmPayOrderList.Open1(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then CdsPayList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsPayList.DisableControls;
  try
    rs.SQL.Text :=ParseSQL(Factor.iDbType, EncodeSQL1(Id,Str));
    Factor.Open(rs);
    rs.SortedFields :='ABLE_ID';
    rs.IndexFieldNames :='ABLE_ID';
    if Id='' then
    begin
      rs.SaveToStream(sm);
      CdsPayList.LoadFromStream(sm);
      CdsPayList.SortedFields := 'ABLE_ID';
      CdsPayList.IndexFieldNames := 'ABLE_ID';
    end else
    begin
      rs.SaveToStream(sm);
      CdsPayList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd1 := True else IsEnd1 := false;
  finally
    CdsPayList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

function TfrmPayOrderList.EncodeSQL2(id: string; var w: string): string;
var
  strSql,strWhere: string;
  rs:TZQuery;
begin
  if D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  strWhere := strWhere + ' A.TENANT_ID=:TENANT_ID ';
  //帐款日期
  strWhere := strWhere + ' and A.PAY_DATE>=:D1 and A.PAY_DATE<=:D2';
  if fndPAYM_ID.ItemIndex > 0 then
     strWhere := strWhere + ' and A.PAYM_ID='''+TRecord_(fndPAYM_ID.Properties.Items.Objects[fndPAYM_ID.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  if fndSHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndSHOP_ID.AsString+'''';
  if fndACCOUNT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ACCOUNT_ID='''+fndACCOUNT_ID.AsString+'''';
  if fndITEM_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ITEM_ID='''+fndITEM_ID.AsString+'''';
  if fndPAY_USER.AsString <> '' then
     strWhere := strWhere + ' and A.PAY_USER='''+fndPAY_USER.AsString+'''';
  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndCLIENT_ID.AsString+'''';
  case fndOrderStatus.ItemIndex of
  1:strWhere := strWhere + ' and CHK_DATE is null';
  2:strWhere := strWhere + ' and CHK_DATE is not null';
  end;
  if id<>'' then
     strWhere := strWhere + ' and A.PAY_ID > '+QuotedStr(id);
  strSql :='select A.PAY_ID,A.SHOP_ID,A.TENANT_ID,A.ACCOUNT_ID,A.CLIENT_ID,A.PAYM_ID,A.ITEM_ID,A.GLIDE_NO,A.PAY_DATE,A.PAY_USER,A.REMARK,A.PAY_MNY,A.CHK_DATE,A.CREA_DATE,A.CHK_USER,A.BILL_NO,A.COMM from ACC_PAYORDER A where '+strWhere;
  strSql :='select jc.*,c.ACCT_NAME as ACCOUNT_ID_TEXT from ('+strSql+') jc '+
           'left outer join VIW_ACCOUNT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.ACCOUNT_ID=c.ACCOUNT_ID';
  strSql :='select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+strSql+') jd '+
           'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID';
  strSql :='select je.*,e.USER_NAME as PAY_USER_TEXT  from ('+strSql+') je '+
           'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.PAY_USER=e.USER_ID ';
  strSql :='select jf.*,f.CLIENT_NAME as CLIENT_ID_TEXT  from ('+strSql+') jf '+
           'left outer join VIW_CLIENTINFO f on jf.TENANT_ID=f.TENANT_ID and jf.CLIENT_ID=f.CLIENT_ID';
  strSql :='select jg.*,g.CODE_NAME as PAYM_ID_TEXT  from ('+strSql+') jg '+
           'left outer join VIW_PAYMENT g on jg.TENANT_ID=g.TENANT_ID and jg.PAYM_ID=g.CODE_ID';
  strSql :='select jh.*,h.USER_NAME as CHK_USER_TEXT  from ('+strSql+') jh '+
           'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by PAY_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by PAY_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') j order by PAY_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by PAY_ID';
  end;
end;

procedure TfrmPayOrderList.Open2(Id: string);
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
//    rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldbyName('PAY_ID').AsString;
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

procedure TfrmPayOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open2(MaxId2);

end;

procedure TfrmPayOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmPayOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

function TfrmPayOrderList.PrintSQL2(tenantid:string;id: string): string;
begin
  result :=
  'select j.* '+
  'from ( '+
  'select ji.*,i.USER_NAME as PAY_USER_TEXT from ('+
  'select jh.*,h.USER_NAME as CHK_USER_TEXT from ('+
  'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
  'select jf.*,f.ACCT_NAME as ACCOUNT_ID_TEXT from ('+
  'select je.*,e.CODE_NAME as ITEM_ID_TEXT from ('+
  'select jd.*,d.CLIENT_NAME as CLIENT_ID_TEXT,d.CLIENT_CODE,d.ADDRESS,d.POSTALCODE,d.LINKMAN,d.TELEPHONE2 as MOVE_TELE from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.PAY_ID,A.SEQNO,A.PAY_MNY,'+
  'b.ACCT_INFO,c.CLIENT_ID,b.ABLE_DATE,C.ITEM_ID,C.ACCOUNT_ID,C.GLIDE_NO,C.PAY_USER,B.RECK_MNY,B.PAYM_MNY as ABLE_PAY_MNY,B.ACCT_MNY,C.PAY_MNY as TOTAL_PAY_MNY,C.REMARK,C.PAY_DATE,B.ABLE_TYPE,C.CHK_USER '+
  'from ACC_PAYDATA A,ACC_PAYABLE_INFO B,ACC_PAYORDER C where A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=C.TENANT_ID and A.ABLE_ID=B.ABLE_ID and A.PAY_ID=C.PAY_ID and A.TENANT_ID='+tenantid+' and A.PAY_ID='''+id+''' ) jd '+
  'left outer join VIW_CLIENTINFO d on jd.TENANT_ID=d.TENANT_ID and jd.CLIENT_ID=d.CLIENT_ID ) je '+
  'left outer join VIW_ITEM_INFO e on je.TENANT_ID=e.TENANT_ID and je.ITEM_ID=e.CODE_ID ) jf '+
  'left outer join VIW_ACCOUNT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.ACCOUNT_ID=f.ACCOUNT_ID ) jg '+
  'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
  'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID ) ji '+
  'left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.PAY_USER=i.USER_ID ) j order by j.SEQNO' ;
end;

procedure TfrmPayOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21400001',6) then Raise Exception.Create('你没有打印付款单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           PrintReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('PAY_ID').AsString),frfPayOrder);
        finally
           free;
        end;
      end;

end;

procedure TfrmPayOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21400001',6) then Raise Exception.Create('你没有打印付款单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           ShowReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('PAY_ID').AsString),frfPayOrder);
        finally
           free;
        end;
      end;
end;

procedure TfrmPayOrderList.frfPayOrderUserFunction(const Name: String; p1,
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

procedure TfrmPayOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
   if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21400001',4) then Raise Exception.Create('你没有删除付款单的权限,请和管理员联系.');
   if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('此单已经审核,不能执行删除操作.');
   if MessageBox(Handle,'确认删除当前选中的付款单？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmPayOrder.Create(self) do
      begin
        try
          Open(cdsList.FieldByName('PAY_ID').AsString);
          DeleteOrder;
          cdsList.Delete;
          if cdsList.IsEmpty then cdsDetail.Close;
          MessageBox(Handle,'删除付款单成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmPayOrderList.AddRecord(AObj: TRecord_);
var rs:TZQuery;
begin
  //若不是List分页则同步刷新
 case RzPage.ActivePageIndex of
  0:
  begin

  end;
  1:
  begin
    if cdsList.Locate('PAY_ID',AObj.FieldbyName('PAY_ID').AsString,[]) then
      begin
        cdsList.Edit;
        AObj.WriteToDataSet(cdsList,false);
        cdsList.Post;
      end
    else
      begin
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text := 'select GLIDE_NO from ACC_PAYORDER where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and PAY_ID='+QuotedStr(AObj.FieldbyName('PAY_ID').AsString);
          Factor.Open(rs);
          AObj.FieldByName('GLIDE_NO').AsString := rs.FieldByName('GLIDE_NO').AsString;
          cdsList.Append;
          AObj.WriteToDataSet(cdsList,False);
          cdsList.Post;
        finally
          rs.Free;
        end;
      end;
   end;
  end;
end;

function TfrmPayOrderList.FindColumn(FieldName: string): TColumnEh;
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
procedure TfrmPayOrderList.frfPayOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

function TfrmPayOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('32600001',7);
end;


procedure TfrmPayOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
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
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsPayList.RecNo)),length(Inttostr(CdsPayList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

end.
