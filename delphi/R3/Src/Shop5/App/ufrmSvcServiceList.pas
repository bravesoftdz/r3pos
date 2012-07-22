unit ufrmSvcServiceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, cxTextEdit, Grids, DBGridEh,
  cxRadioGroup, cxButtonEdit, zrComboBoxList, RzButton, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ObjCommon;

type
  TfrmSvcServiceList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label2: TLabel;
    Label8: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndSTATUS: TcxRadioGroup;
    fndP1_CUST_ID: TzrComboBoxList;
    fndP1_DEPT_ID: TzrComboBoxList;
    Panel1: TPanel;
    RzLabel5: TRzLabel;
    Label1: TLabel;
    fndSALES_ID: TcxTextEdit;
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
    DsSalesList: TDataSource;
    CdsSalesList: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel1: TRzLabel;
    Label4: TLabel;
    Label17: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndCREA_USER: TzrComboBoxList;
    fndCLIENT_ID: TzrComboBoxList;
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    DataSource2: TDataSource;
    cdsList: TZQuery;
    Label6: TLabel;
    fndSALES_STYLE: TzrComboBoxList;
    RzLabel6: TRzLabel;
    fndSERIAL_NO: TcxTextEdit;
    RzLabel7: TRzLabel;
    fndCLIENT_CODE: TcxTextEdit;
    Label30: TLabel;
    fndP2_GODS_ID: TzrComboBoxList;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure CdsSalesListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
  private
    { Private declarations }
    procedure ChangeButton;
    function  CheckCanExport: boolean; override;
  public
    { Public declarations }
    IsEnd1,IsEnd2: boolean;
    MaxId1,MaxId2:string;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function FindColumn(FieldName:string):TColumnEh;
    function EncodeSQL1(id:string):string;
    function EncodeSQL2(id:string):string;
    procedure Open1(Id:string);
    procedure Open2(Id:string);
    function PrintSQL2(tenantid,id:string):string;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uCtrlUtil,uShopGlobal,ufrmSvcServiceInfo,
  uframeMDForm, uframeDialogForm, ufrmBasic;
{$R *.dfm}

procedure TfrmSvcServiceList.actNewExecute(Sender: TObject);
var Client_Id,InvoiceFlag:String;
    IsExist:Boolean;
    R:Integer;
begin
  inherited;
  case RzPage.ActivePageIndex of
  0: begin
    //if not ShopGlobal.GetChkRight('100002314',2) then Raise Exception.Create('你没有登记的权限,请和管理员联系.');
    if CdsSalesList.State in [dsInsert,dsEdit] then CdsSalesList.Post;
    CdsSalesList.DisableControls;
    try
      IsExist := False;
      if (RzPage.ActivePage=TabSheet1) and (CdsSalesList.Active) and (CdsSalesList.RecordCount>0) then
         IsExist := True;

      if not IsExist then Raise Exception.Create('请选择要登记的销售单...');

      with TfrmSvcServiceInfo.Create(self) do
      begin
        try
          SalesId := CdsSalesList.FieldByName('SALES_ID').AsString;
          GodsId := CdsSalesList.FieldByName('GODS_ID').AsString;
          Append;
          ClientId := CdsSalesList.FieldByName('CLIENT_ID').AsString;
          GodsName := CdsSalesList.FieldByName('GODS_NAME').AsString;
          OnSave := AddRecord;
          //登记选择第一分页 [查询] 时执行
          ShowModal;
        finally
          free;
        end;
      end;
    finally
      CdsSalesList.EnableControls;
    end;
  end;
  1: begin
      with TfrmSvcServiceInfo.Create(self) do
      begin
        try
          Edit(cdsList.FieldByName('SRVR_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
  end;
  end;
end;

procedure TfrmSvcServiceList.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  //if not ShopGlobal.GetChkRight('100002314',4) then Raise Exception.Create('你没有删除设备安装及维保单的权限,请和管理员联系.');
  if cdsList.FieldByName('CREA_USER').AsString <> Global.UserID then
  begin
    if not ShopGlobal.GetChkRight('100002314',4) then
      Raise Exception.Create('你没有删除"'+cdsList.FieldByName('CREA_USER_TEXT').AsString+'"设备安装及维保单的权限!');
  end;

  if MessageBox(Handle,'确认删除当前选中的设备安装及维保单吗？','友情提示',MB_YESNO+MB_ICONQUESTION)=6 then
  begin
     try
       cdsList.DisableControls;
       try
         cdsList.CommitUpdates;
         cdsList.Delete;
         Factor.UpdateBatch(cdsList,'TSvcServiceInfo');
         MessageBox(Handle,'删除设备安装及维保单成功...','友情提示...',MB_OK+MB_ICONINFORMATION);
       except
         cdsList.CancelUpdates;
         Raise;
       end;
     finally
       cdsList.EnableControls;
     end;
  end;
end;

procedure TfrmSvcServiceList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  //if not ShopGlobal.GetChkRight('100002314',3) then Raise Exception.Create('你没有修改设备安装及维保单的权限,请和管理员联系.');
  if cdsList.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002314',3) then
        Raise Exception.Create('你没有修改"'+cdsList.FieldByName('CREA_USER_TEXT').AsString+'"设备安装及维保单的权限!');
    end;

  with TfrmSvcServiceInfo.Create(self) do
    begin
      try
        Edit(cdsList.FieldByName('SRVR_ID').AsString);
        //OrderType := CdsSalesList.FieldByName('').AsInteger;
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmSvcServiceList.actPrintExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002314',6) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');
  Raise Exception.Create('此功能暂时没有开放.')
end;

procedure TfrmSvcServiceList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002314',7) then Raise Exception.Create('你没有导出的权限,请和管理员联系.');
  Raise Exception.Create('此功能暂时没有开放.')
end;

procedure TfrmSvcServiceList.actFindExecute(Sender: TObject);
begin
  inherited;
  case RzPage.ActivePageIndex of
    0:Open1('');
    1:Open2('');
  end;
end;

procedure TfrmSvcServiceList.actInfoExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
    with TfrmSvcServiceInfo.Create(self) do
      begin
        try
          //cid := cdsList.FieldbyName('SHOP_ID').AsString;
          Open(cdsList.FieldByName('SRVR_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
end;

procedure TfrmSvcServiceList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
  rs:TZQuery;
begin
  inherited;
{  if cdsList.IsEmpty then Raise Exception.Create('请选择要作废的发票');
  if not ShopGlobal.GetChkRight('100002314',5) then Raise Exception.Create('你没有作废发票的权限,请和管理员联系.');
  if cdsList.FieldByName('INVOICE_STATUS').AsString='1' then
     begin
       //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能作废');
       //if cdsList.FieldByName('CREA_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售单执行弃审');
       if MessageBox(Handle,'确认作废当前发票？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认还原作废发票？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create;
    rs := TZQuery.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('INVD_ID').AsString := cdsList.FieldByName('INVD_ID').AsString;
      Factor.Open(rs,'TInvoiceOrder',Params);

      if cdsList.FieldByName('INVOICE_STATUS').AsString='1' then
         begin
            rs.Edit;
            rs.FieldByName('INVOICE_STATUS').AsString := '2';
            rs.Post;
            Factor.UpdateBatch(rs,'TInvoiceOrder');
            MessageBox(Handle,Pchar('作废发票成功'),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
         end
      else
         begin
            rs.Edit;
            rs.FieldByName('INVOICE_STATUS').AsString := '1';
            rs.Post;
            Factor.UpdateBatch(rs,'TInvoiceOrder');
            MessageBox(Handle,Pchar('还原发票成功'),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
         end;
    finally
      rs.Free;
      Params.Free;
    end;

  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  ChangeButton; }
end;

procedure TfrmSvcServiceList.AddRecord(AObj: TRecord_);
begin
  //若不是List分页则同步刷新
  case RzPage.ActivePageIndex of
   0:  
   begin
 
   end;
   1:
   begin
      if cdsList.Locate('SRVR_ID',AObj.FieldbyName('SRVR_ID').AsString,[]) then
        begin
          cdsList.Edit;
          AObj.WriteToDataSet(cdsList,false);
          cdsList.Post;
        end
      else
        begin
          cdsList.Append;
          AObj.WriteToDataSet(cdsList,False);
          cdsList.Post;
        end;
    end;
  end;
end;

procedure TfrmSvcServiceList.ChangeButton;
begin
  //if cdsList.Active and (cdsList.FieldByName('INVOICE_STATUS').AsString = '1') then actAudit.Caption := '作废' else actAudit.Caption := '还原';
  //if RzPage.ActivePageIndex = 0 then actNew.Caption := '开票' else actNew.Caption := '登记';
//  if rzPage.ActivePageIndex = 0 then
     begin
       actDelete.Enabled := rzPage.ActivePageIndex > 0;
       actEdit.Enabled := rzPage.ActivePageIndex > 0;
       actSave.Enabled := rzPage.ActivePageIndex > 0;
       actCancel.Enabled := false;
       actInfo.Enabled := rzPage.ActivePageIndex > 0;
       actAudit.Enabled := rzPage.ActivePageIndex > 0;
       actNew.Enabled := RzPage.ActivePageIndex = 0;
     end;
end;

function TfrmSvcServiceList.CheckCanExport: boolean;
begin

end;

function TfrmSvcServiceList.EncodeSQL1(id: string): string;
var
  strSql,strWhere,StrField: string;
  Column:TColumnEh;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('销售查询开始日期不能大于结束日期');

  strWhere := strWhere + ' where B.TENANT_ID=:TENANT_ID and B.SALES_TYPE=1 and B.SALES_DATE>=:D1 and B.SALES_DATE<=:D2 ';

  //分批取数据的条件:
  if trim(id)<>'' then
    strWhere:=strWhere+' and B.SALES_ID > '+QuotedStr(id);
  //门店条件:
  if fndP1_SHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and B.SHOP_ID=:SHOP_ID ';
  //部门条件:
  if fndP1_DEPT_ID.AsString <> '' then
     strWhere := strWhere + ' and B.DEPT_ID=:DEPT_ID ';
  //客户条件:
  if fndP1_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and B.CLIENT_ID=:CLIENT_ID ';
  if trim(fndSALES_ID.Text) <> '' then
     strWhere := strWhere + ' and B.GLIDE_NO like ''%'+trim(fndSALES_ID.Text)+''' ';
  if fndSALES_STYLE.AsString <> '' then
     strWhere := strWhere + ' and B.SALES_STYLE=:SALES_STYLE ';

  case fndSTATUS.ItemIndex of
    1:strWhere := strWhere + ' and isnull(I.SERIAL_NO_NUM,0) = 0 ';
    2:strWhere := strWhere + ' and (isnull(I.SERIAL_NO_NUM,0) <> 0) and (isnull(I.SERIAL_NO_NUM,0) < A.AMOUNT) ';
    3:strWhere := strWhere + ' and isnull(I.SERIAL_NO_NUM,0) = A.AMOUNT ';
  end;

  strSql:=
  'select B.TENANT_ID,B.SALES_ID,B.GLIDE_NO,B.SALES_DATE,B.REMARK,B.CLIENT_ID,C.CLIENT_NAME,B.SALES_TYPE,B.SHOP_ID,H.USER_NAME as CREA_USER_TEXT,'+
  ' case when isnull(I.SERIAL_NO_NUM,0)=0 then ''未登记'' '+
  '      when (isnull(I.SERIAL_NO_NUM,0)<>0) and (isnull(I.SERIAL_NO_NUM,0) < A.AMOUNT) then ''部分登记'' '+
  '      when isnull(I.SERIAL_NO_NUM,0) = A.AMOUNT then ''完成登记'' '+
  ' end as STATUS,'+
  'A.GODS_ID,E.GODS_NAME,D.SHOP_NAME as SHOP_ID_TEXT,B.CREA_DATE,B.INVOICE_FLAG,A.AMOUNT,A.APRICE,A.AMONEY,G.USER_NAME as GUIDE_USER_TEXT '+
  ' from SAL_SALESDATA A inner join SAL_SALESORDER B on A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
  ' left join VIW_CUSTOMER C on B.TENANT_ID=C.TENANT_ID and B.CLIENT_ID=C.CLIENT_ID '+
  ' left join CA_SHOP_INFO D on B.TENANT_ID=D.TENANT_ID and B.SHOP_ID=D.SHOP_ID '+
  ' left join VIW_GOODSINFO E on A.TENANT_ID=E.TENANT_ID and A.GODS_ID=E.GODS_ID '+
  ' left join VIW_MEAUNITS F on A.TENANT_ID=F.TENANT_ID and A.UNIT_ID=F.UNIT_ID '+
  ' left join VIW_USERS G on B.TENANT_ID=G.TENANT_ID and B.GUIDE_USER=G.USER_ID '+
  ' left join VIW_USERS H on B.TENANT_ID=H.TENANT_ID and B.CREA_USER=H.USER_ID '+
  ' left join ( '+
  ' select TENANT_ID,SALES_ID,GODS_ID,count(distinct SERIAL_NO) as SERIAL_NO_NUM from SVC_SERVICE_INFO '+
  ' group by TENANT_ID,SALES_ID,GODS_ID '+
  ' ) I on A.TENANT_ID=I.TENANT_ID and A.SALES_ID=I.SALES_ID and A.GODS_ID=I.GODS_ID '+strWhere+ShopGlobal.GetDataRight('B.SHOP_ID',1)+ShopGlobal.GetDataRight('B.DEPT_ID',2)+' ';

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by SALES_ID';
  1:result := 'select * from ('+strSql+' order by SALES_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by SALES_ID) tp fetch first 600  rows only';

  5:result := 'select * from ('+strSql+') j order by SALES_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by SALES_ID';
  end;

end;

function TfrmSvcServiceList.EncodeSQL2(id: string): string;
var
  strSql,strWhere: string;
begin
  if D1.EditValue = null then Raise Exception.Create('受理日期条件不能为空');
  if D2.EditValue = null then Raise Exception.Create('受理日期条件不能为空');
  if D1.Date > D2.Date then Raise Exception.Create('受理查询开始日期不能大于结束日期');
  strWhere := strWhere + ' where A.TENANT_ID=:TENANT_ID and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 ';

  //分批取数据的条件:
  if trim(id)<>'' then
    strWhere:=strWhere+' and A.SRVR_ID > '+QuotedStr(id);
  //客户条件:
  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID=:CLIENT_ID ';
  if fndCREA_USER.AsString <> '' then
     strWhere := strWhere + ' and A.CREA_USER=:CREA_USER';
  if Trim(fndSERIAL_NO.Text) <> '' then
     strWhere := strWhere + ' and A.SERIAL_NO=:SERIAL_NO';
  if Trim(fndCLIENT_CODE.Text) <> '' then
     strWhere := strWhere + ' and A.CLIENT_CODE=:CLIENT_CODE';
  if fndP2_GODS_ID.asString<>'' then
     strWhere := strWhere + ' and A.GODS_ID=:GODS_ID';

  strSql:=
  'select A.TENANT_ID,A.SRVR_ID,F.GLIDE_NO,A.GODS_NAME,A.SERIAL_NO,A.RECV_DATE,A.RECV_USER,D.USER_NAME as RECV_USER_TEXT,A.SRVR_DATE,'+
  'E.USER_NAME as SRVR_USER_TEXT,A.CREA_DATE,A.CREA_USER,C.USER_NAME as CREA_USER_TEXT,B.CLIENT_NAME as CLIENT_ID_TEXT '+
  ' from SVC_SERVICE_INFO A left join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
  ' left join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.CREA_USER=C.USER_ID '+
  ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.RECV_USER=D.USER_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.SRVR_USER=E.USER_ID '+
  ' left join SAL_SALESORDER F on A.TENANT_ID=E.TENANT_ID and A.SALES_ID=F.SALES_ID '+strWhere;

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by SRVR_ID';
  1:result := 'select * from ('+strSql+' order by SRVR_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by SRVR_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') j order by SRVR_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by SRVR_ID';
  end;
end;

function TfrmSvcServiceList.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if DBGridEh1.Columns[i].FieldName = FieldName then
         begin
           result := DBGridEh1.Columns[i];
           break;
         end;
    end;
end;

procedure TfrmSvcServiceList.InitGrid;
begin

end;

procedure TfrmSvcServiceList.Open1(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsSalesList.DisableControls;
  try
    rs.SQL.Text := ParseSQL(Factor.iDbType,EncodeSQL1(Id));
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndP1_CUST_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    if rs.Params.FindParam('SALES_STYLE')<>nil then rs.Params.FindParam('SALES_STYLE').AsString := fndSALES_STYLE.AsString; 
    Factor.Open(rs);
    rs.Last;
    MaxId1 := rs.FieldbyName('SALES_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       CdsSalesList.LoadFromStream(sm);
       CdsSalesList.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       CdsSalesList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd1 := True else IsEnd1 := false;
  finally
    CdsSalesList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmSvcServiceList.Open2(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL2(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if rs.Params.FindParam('CREA_USER')<>nil then rs.Params.FindParam('CREA_USER').AsString := fndCREA_USER.AsString;
    if rs.Params.FindParam('SERIAL_NO')<>nil then rs.Params.FindParam('SERIAL_NO').AsString := Trim(fndSERIAL_NO.Text);
    if rs.Params.FindParam('CLIENT_CODE')<>nil then rs.Params.FindParam('CLIENT_CODE').AsString := Trim(fndCLIENT_CODE.Text);
    if rs.Params.FindParam('GODS_ID')<>nil then rs.Params.FindParam('GODS_ID').AsString := fndP2_GODS_ID.asString;
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldbyName('SRVR_ID').AsString;
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

function TfrmSvcServiceList.PrintSQL2(tenantid, id: string): string;
begin

end;

procedure TfrmSvcServiceList.DBGridEh1DrawColumnCell(Sender: TObject;
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
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsSalesList.RecNo)),length(Inttostr(CdsSalesList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmSvcServiceList.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmSvcServiceList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open2(MaxId2);
end;

procedure TfrmSvcServiceList.CdsSalesListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd1 or not DataSet.Eof then Exit;
  if CdsSalesList.ControlsDisabled then Exit;
  Open1(MaxId1);
end;

procedure TfrmSvcServiceList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);

  D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndSALES_STYLE.DataSet := Global.GetZQueryFromName('PUB_SALE_STYLE');

  //第一分页销售开票查询:
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  fndP1_CUST_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP1_DEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  RzPage.ActivePageIndex := 0;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label3.Caption := '仓库名称';
    end;
  ChangeButton;
end;

procedure TfrmSvcServiceList.FormShow(Sender: TObject);
begin
  inherited;
  Open1('');
  if P1_D1.CanFocus then P1_D1.SetFocus;
end;

procedure TfrmSvcServiceList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

end.
