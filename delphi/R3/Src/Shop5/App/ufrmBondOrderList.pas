{  21300001	0	申领单	1	查询	2	新增	3	修改	4	删除	5	审核	6	打印	7	导出   }

unit ufrmBondOrderList;

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
  TfrmBondOrderList = class(TframeToolForm)
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
    cdsList: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    RzPanel7: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label4: TLabel;
    Label17: TLabel;
    Label40: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndOrderStatus: TcxRadioGroup;
    fndBOND_USER: TzrComboBoxList;
    fndCLIENT_ID: TzrComboBoxList;
    fndSHOP_ID: TzrComboBoxList;
    fndP1_SHOP_ID: TzrComboBoxList; 
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label2: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    CdsRecvList: TZQuery;
    RecvListDs: TDataSource;
    fndP1_CUST_ID: TzrComboBoxList;
    P1_BOND_TYPE: TcxComboBox;
    Label7: TLabel;
    P2_BOND_TYPE: TcxComboBox;
    Label1: TLabel;
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
    procedure frfRecvOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
    procedure actDeleteExecute(Sender: TObject);
    procedure frfRecvOrderGetValue(const ParName: String; var ParValue: Variant);
    procedure CdsRecvListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure ChangeButton;
    function  CheckCanExport: boolean; override;
  public
    IsEnd1,IsEnd2: boolean;
    MaxId1,MaxId2:string;
    pid:string;
    locked:boolean;
    constructor Create(AOwner: TComponent); override;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);

    function FindColumn(FieldName:string):TColumnEh;
    function EncodeSQL1(id:string;var w:string):string;
    function EncodeSQL2(id:string;var w:string):string;
    procedure Open1(Id:string);
    procedure Open2(Id:string);
    function PrintSQL2(tenantid,id:string):string;
  end;

implementation
uses uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmBondOrder,
  ufrmBasic, ObjCommon;
{$R *.dfm}

procedure TfrmBondOrderList.InitGrid;
begin
  InitGridPickList(DBGridEh2);
end;

procedure TfrmBondOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);

  D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndBOND_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  InitGrid;
  //第一分页应收账款:
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  {if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,fndSHOP_ID.Style);
    fndSHOP_ID.Properties.ReadOnly := True;

    SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    fndP1_SHOP_ID.Properties.ReadOnly := True;
  end;}
  //2011.11.10 引入门店权限及部门权限，把原有的控制注释
  fndP1_CUST_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  RzPage.ActivePageIndex := 0;
  
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label3.Caption := '仓库名称';
      Label40.Caption := '所属仓库';
    end;
  ChangeButton;
end;

procedure TfrmBondOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  case RzPage.ActivePageIndex of
   0: Open1('');
   1: Open2('');
  end;
end;

procedure TfrmBondOrderList.actNewExecute(Sender: TObject);
var
  ABLE_ID: string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21300001',2) then Raise Exception.Create('你没有新增申领单的权限,请和管理员联系.');
  ABLE_ID:='';
  if (RzPage.ActivePage=TabSheet1) and (CdsRecvList.Active) and (CdsRecvList.RecordCount>0) then
     ABLE_ID:=trim(CdsRecvList.fieldbyName('ABLE_ID').AsString);
  
  with TfrmBondOrder.Create(self) do
    begin
      try
        Append;
        OnSave := AddRecord;

        //应账款选择第一分页 [账款查询] 时执行
        if ABLE_ID<>'' then
        begin
          edtCLIENT_ID.KeyValue:=trim(CdsRecvList.fieldbyName('CLIENT_ID').AsString);
          edtCLIENT_ID.Text:=trim(CdsRecvList.fieldbyName('CUST_ID_TEXT').AsString);
          edtBOND_TYPE.ItemIndex := TdsItems.FindItems(edtBOND_TYPE.Properties.Items,'CODE_ID',CdsRecvList.fieldbyName('BOND_TYPE').AsString);
          FillData;
          //定位到ABLE_ID
          if cdsDetail.Locate('FROM_ID',ABLE_ID,[]) then
          begin
            if cdsDetail.State<>dsEdit then cdsDetail.Edit;
            cdsDetail.FieldByName('A').AsString:='1';
            cdsDetail.FieldByName('BOND_MNY').AsFloat:=cdsDetail.FieldByName('BALA_MNY').AsFloat;
            cdsDetail.FieldByName('BALA_MNY').AsFloat:=0;
            cdsDetail.Post;
          end; 
        end;
        //应账款选择第一分页 [账款查询] 时执行
        
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmBondOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('21300001',3) then Raise Exception.Create('你没有修改申领单的权限,请和管理员联系.');
  if cdsList.FieldByName('BOND_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('21300001',5) then
        Raise Exception.Create('你没有修改"'+cdsList.FieldByName('BOND_USER_TEXT').AsString+'"录入单据的权限!');
    end;

  if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('此单已经审核,不能执行修改操作.');  
  with TfrmBondOrder.Create(self) do
    begin
      try
        Edit(cdsList.FieldByName('BOND_ID').AsString);
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmBondOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
    with TfrmBondOrder.Create(self) do
      begin
        try
          cid := cdsList.FieldbyName('SHOP_ID').AsString;
          Open(cdsList.FieldByName('BOND_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
end;

procedure TfrmBondOrderList.ChangeButton;
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
procedure TfrmBondOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
    if cdsList.IsEmpty then Raise Exception.Create('请选择待审核的申领单');
   if not ShopGlobal.GetChkRight('21300001',5) then Raise Exception.Create('你没有审核申领单的权限,请和管理员联系.');
    if cdsList.FieldByName('CHK_DATE').AsString<>'' then
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
         if cdsList.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售单执行弃审');
         if MessageBox(Handle,'确认弃审当前申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end
    else
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
         if MessageBox(Handle,'确认审核当前申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    try
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsList.FieldbyName('TENANT_ID').AsInteger;
        Params.ParamByName('SHOP_ID').asString := cdsList.FieldbyName('SHOP_ID').AsString;
        Params.ParamByName('BOND_ID').asString := cdsList.FieldbyName('BOND_ID').AsString;
        Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',date());
        Params.ParamByName('CHK_USER').asString := Global.UserID;
        if cdsList.FieldByName('CHK_DATE').AsString='' then
           Msg := Factor.ExecProc('TBondOrderAudit',Params)
        else
           Msg := Factor.ExecProc('TBondOrderUnAudit',Params) ;
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

procedure TfrmBondOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open1('');
end;

function TfrmBondOrderList.EncodeSQL1(id:string;var w:string): string;
var
  strSql,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('账款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('账款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('账款查询开始日期不能大于结束日期');
  strWhere := strWhere + ' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' ';
  case TRecord_(P1_BOND_TYPE.Properties.Items.Objects[P1_BOND_TYPE.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:if trim(id)<>'' then strWhere:=strWhere+' A.PLAN_ID > '+QuotedStr(id);
  2:if trim(id)<>'' then strWhere:=strWhere+' A.INDE_ID > '+QuotedStr(id);
  end;
  case TRecord_(P1_BOND_TYPE.Properties.Items.Objects[P1_BOND_TYPE.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:begin
    //帐款日期:
    if P1_D1.Date=P1_D2.Date then
      strWhere := strWhere + ' and A.PLAN_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' '
    else
      strWhere := strWhere + ' and A.PLAN_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.PLAN_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+'';
    end;
  2:begin
    //帐款日期:
    if P1_D1.Date=P1_D2.Date then
      strWhere := strWhere + ' and A.INDE_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' '
    else
      strWhere := strWhere + ' and A.INDE_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.INDE_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+'';
    end;
  end;
  //门店条件:
  if fndP1_SHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+'''';
  //客户条件:
  if fndP1_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndP1_CUST_ID.AsString+'''';

  case fndSTATUS.ItemIndex of
   1:strWhere := strWhere + ' and (isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0))<>0 ';
   2:strWhere := strWhere + ' and (isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0))=0 ';
  end;

  case TRecord_(P1_BOND_TYPE.Properties.Items.Objects[P1_BOND_TYPE.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:strSql:=
    'select A.TENANT_ID,A.PLAN_ID as ABLE_ID'+
    ',A.SHOP_ID'+
    ',A.CLIENT_ID'+
    ',B.CLIENT_NAME as CUST_ID_TEXT'+
    ',A.GLIDE_NO,''1'' as BOND_TYPE'+
    ',A.BOND_MNY as ACCT_MNY'+
    ',A.BOND_RET as BOND_MNY'+
    ',(isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0)) as RECK_MNY'+
    ',A.PLAN_DATE as ABLE_DATE'+
    ',C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID '+
    ' from MKT_PLANORDER A,VIW_CUSTOMER B,CA_SHOP_INFO C  '+
    ' where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
    ' '+strWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
  2:strSql:=
    'select A.TENANT_ID,A.INDE_ID as ABLE_ID'+
    ',A.SHOP_ID'+
    ',A.CLIENT_ID'+
    ',B.CLIENT_NAME as CUST_ID_TEXT'+
    ',A.GLIDE_NO,''2'' as BOND_TYPE'+
    ',A.BOND_MNY as ACCT_MNY'+
    ',A.BOND_RET as BOND_MNY'+
    ',(isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0)) as RECK_MNY'+
    ',A.INDE_DATE as ABLE_DATE'+
    ',C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID '+
    ' from SAL_INDENTORDER A,VIW_CUSTOMER B,CA_SHOP_INFO C  '+
    ' where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
    ' '+strWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
  end;
  strsql := 'select j.*,d.DEPT_NAME as DEPT_ID_TEXT from ('+strSql+') j left outer join CA_DEPT_INFO d on j.TENANT_ID=d.TENANT_ID and j.DEPT_ID=d.DEPT_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by ABLE_ID';
  1:result := 'select * from ('+strSql+' order by ABLE_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by ABLE_ID) tp fetch first 600  rows only';

  5:result := 'select * from ('+strSql+') j order by ABLE_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by ABLE_ID';
  end;
end;

function TfrmBondOrderList.EncodeSQL2(id: string; var w: string): string;
var
  strSql,strWhere: string;
begin
  if D1.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  if D2.EditValue = null then Raise Exception.Create('申领日期条件不能为空');
  strWhere := strWhere + ' A.TENANT_ID=:TENANT_ID';
  //帐款日期
  strWhere := strWhere + ' and A.BOND_DATE>=:D1 and A.BOND_DATE<=:D2';
  if P2_BOND_TYPE.ItemIndex > 0 then
     strWhere := strWhere + ' and A.BOND_TYPE='''+TRecord_(P2_BOND_TYPE.Properties.Items.Objects[P2_BOND_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  if fndSHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndSHOP_ID.AsString+'''';
  if fndBOND_USER.AsString <> '' then
     strWhere := strWhere + ' and A.BOND_USER='''+fndBOND_USER.AsString+'''';
  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndCLIENT_ID.AsString+'''';
  case fndOrderStatus.ItemIndex of
  1:strWhere := strWhere + ' and CHK_DATE is null';
  2:strWhere := strWhere + ' and CHK_DATE is not null';
  end;
  if id<>'' then
     strWhere := strWhere + ' and A.BOND_ID > '+QuotedStr(id);
  strSql :='select A.BOND_ID,A.SHOP_ID,A.TENANT_ID,A.CLIENT_ID,A.GLIDE_NO,A.BOND_DATE,A.BOND_USER,A.REMARK,'+
           'A.BOND_MNY,A.CHK_DATE,A.CHK_USER,A.CREA_DATE,A.COMM from MKT_BONDORDER A where '+strWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2);
  strSql :='select je.*,e.USER_NAME as BOND_USER_TEXT  from ('+strSql+') je '+
           'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.BOND_USER=e.USER_ID ';
  strSql :='select jf.*,f.CLIENT_NAME as CLIENT_ID_TEXT  from ('+strSql+') jf '+
           'left outer join VIW_CUSTOMER f on jf.TENANT_ID=f.TENANT_ID and jf.CLIENT_ID=f.CLIENT_ID';
  strSql :='select jh.*,h.USER_NAME as CHK_USER_TEXT  from ('+strSql+') jh '+
           'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by BOND_ID';
  1:result := 'select * from ('+strSql+' order by BOND_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by BOND_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') j order by BOND_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by BOND_ID';
  end;
end;

procedure TfrmBondOrderList.Open1(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if P1_BOND_TYPE.ItemIndex <0 then Exit;
  if not Visible then Exit;
  if Id='' then CdsRecvList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsRecvList.DisableControls;
  try
    rs.SQL.Text :=ParseSQL(Factor.iDbType, EncodeSQL1(Id,Str));
    Factor.Open(rs);
    rs.SortedFields :='ABLE_ID';
    rs.IndexFieldNames :='ABLE_ID';
    if Id='' then
    begin
      rs.SaveToStream(sm);
      CdsRecvList.LoadFromStream(sm);
      CdsRecvList.SortedFields := 'ABLE_ID';
      CdsRecvList.IndexFieldNames := 'ABLE_ID';
    end else
    begin
      rs.SaveToStream(sm);
      CdsRecvList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd1 := True else IsEnd1 := false;
  finally
    CdsRecvList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmBondOrderList.Open2(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if P2_BOND_TYPE.ItemIndex <0 then Exit;
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
    MaxId2 := rs.FieldbyName('BOND_ID').AsString;
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

procedure TfrmBondOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open2(MaxId2);                        
end;

procedure TfrmBondOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmBondOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

function TfrmBondOrderList.PrintSQL2(tenantid,id: string): string;
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
  'left outer join VIW_CUSTOMER d on jd.TENANT_ID=d.TENANT_ID and jd.CLIENT_ID=d.CLIENT_ID ) je '+
  'left outer join VIW_ITEM_INFO e on je.TENANT_ID=e.TENANT_ID and je.ITEM_ID=e.CODE_ID ) jf '+
  'left outer join VIW_ACCOUNT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.ACCOUNT_ID=f.ACCOUNT_ID ) jg '+
  'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
  'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID ) ji '+
  'left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.RECV_USER=i.USER_ID ) j order by j.SEQNO' ;
end;

procedure TfrmBondOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',6) then Raise Exception.Create('你没有打印申领单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           PrintReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;

end;

procedure TfrmBondOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',6) then Raise Exception.Create('你没有打印申领单的权限,请和管理员联系.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           ShowReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;
end;

procedure TfrmBondOrderList.frfRecvOrderUserFunction(const Name: String; p1,
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

procedure TfrmBondOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
   if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',4) then Raise Exception.Create('你没有删除申领单的权限,请和管理员联系.');
   if cdsList.FieldByName('BOND_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('21300001',5) then
        Raise Exception.Create('你没有删除"'+cdsList.FieldByName('BOND_USER_TEXT').AsString+'"录入单据的权限!');
    end;
   if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('此单已经审核,不能执行删除操作.');   
   if MessageBox(Handle,'确认删除当前选中的申领单？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmBondOrder.Create(self) do
      begin
        try
          Open(cdsList.FieldByName('BOND_ID').AsString);
          DeleteOrder;
          cdsList.Delete;
          if cdsList.IsEmpty then cdsDetail.Close;
          MessageBox(Handle,'删除申领单成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmBondOrderList.AddRecord(AObj: TRecord_);
var
  rs:TZQuery;
begin
  //若不是List分页则同步刷新
  case RzPage.ActivePageIndex of
   0:  
   begin
 
   end;
   1:
   begin
      if cdsList.Locate('BOND_ID',AObj.FieldbyName('BOND_ID').AsString,[]) then
        begin
          cdsList.Edit;
          AObj.WriteToDataSet(cdsList,false);
          cdsList.Post;
        end
      else
        begin
          rs := TZQuery.Create(nil);
          try
            rs.SQL.Text := 'select GLIDE_NO from MKT_BONDORDER where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and BOND_ID='+QuotedStr(AObj.FieldbyName('BOND_ID').AsString);
            Factor.Open(rs);
            AObj.FieldByName('GLIDE_NO').AsString := rs.FieldbyName('GLIDE_NO').AsString;
            cdsList.Append;
            AObj.WriteToDataSet(cdsList,False);
            cdsList.Post;
          finally
            rs.Free;
          end;
        end;
      AObj.WriteToDataSet(cdsList,false);
      cdsList.Post;
    end;
  end;
end;

procedure TfrmBondOrderList.frfRecvOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

function TfrmBondOrderList.FindColumn(FieldName: string): TColumnEh;
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

function TfrmBondOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('21300001',7);
end;


procedure TfrmBondOrderList.CdsRecvListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd1 or not DataSet.Eof then Exit;
  if CdsRecvList.ControlsDisabled then Exit;  
  Open1(MaxId1);
end;

procedure TfrmBondOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsRecvList.RecNo)),length(Inttostr(CdsRecvList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

constructor TfrmBondOrderList.Create(AOwner: TComponent);
begin
  inherited;
  P1_BOND_TYPE.Properties.ReadOnly := false;
  if (P1_BOND_TYPE.ItemIndex <0) and (P1_BOND_TYPE.Properties.Items.Count>0) then
     P1_BOND_TYPE.ItemIndex := 0;
  P2_BOND_TYPE.Properties.ReadOnly := false;
  if (P2_BOND_TYPE.ItemIndex <0) and (P2_BOND_TYPE.Properties.Items.Count>0) then
     P2_BOND_TYPE.ItemIndex := 0;
end;

end.
