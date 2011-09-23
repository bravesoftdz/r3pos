{ 11200001	0	进货入库	1	查询	2	新增	3	修改	4	删除	5	审核	6	打印	7	导出
}

unit ufrmOutLocusOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ActnList, Menus, ComCtrls,
  ToolWin, StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, RzButton,
  cxRadioGroup, ZBase, FR_Class, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmOutLocusOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    ToolButton17: TToolButton;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label40: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    fndSALES_ID: TcxTextEdit;
    fndCLIENT_ID: TzrComboBoxList;
    fndSHOP_ID: TzrComboBoxList;
    fndDEPT_ID: TzrComboBoxList;
    frfSalesOrder: TfrReport;
    TabSheet2: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    Label2: TLabel;
    Label4: TLabel;
    fndP2_D1: TcxDateEdit;
    fndP2_D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndP2_SALES_ID: TcxTextEdit;
    fndP2_STATUS: TcxRadioGroup;
    fndP2_SHOP_ID: TzrComboBoxList;
    fndP2_CLIENT_ID: TzrComboBoxList;
    DBGridEh2: TDBGridEh;
    cdsP2List: TZQuery;
    dsP2List: TDataSource;
    TabSheet3: TRzTabSheet;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    Label5: TLabel;
    RzLabel12: TRzLabel;
    Label6: TLabel;
    fndP3_D1: TcxDateEdit;
    fndP3_D2: TcxDateEdit;
    fndP3_CHANGE_ID: TcxTextEdit;
    RzBitBtn2: TRzBitBtn;
    fndP3_STATUS: TcxRadioGroup;
    fndP3_DUTY_USER: TzrComboBoxList;
    fndP3_SHOP_ID: TzrComboBoxList;
    DBGridEh3: TDBGridEh;
    cdsP3List: TZQuery;
    dsP3List: TDataSource;
    TabSheet4: TRzTabSheet;
    RzPanel10: TRzPanel;
    RzPanel11: TRzPanel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    fndP4_D1: TcxDateEdit;
    fndP4_D2: TcxDateEdit;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_STOCK_ID: TcxTextEdit;
    RzBitBtn3: TRzBitBtn;
    fndP4_STATUS: TcxRadioGroup;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    DBGridEh4: TDBGridEh;
    cdsP4List: TZQuery;
    dsP4List: TDataSource;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure frfStockOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure frfStockOrderGetValue(const ParName: String;
      var ParValue: Variant);
    procedure RzPageChange(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsP2ListAfterScroll(DataSet: TDataSet);
    procedure cdsP3ListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsP4ListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    oid:string;
    function  CheckCanExport: boolean; override;
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    IsEnd2: boolean;
    MaxId2:string;
    IsEnd3: boolean;
    MaxId3:string;
    IsEnd4: boolean;
    MaxId4:string;
    function PrintSQL(tenantid,id:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    function EncodeSQL2(id:string):string;
    function EncodeSQL3(id:string):string;
    function EncodeSQL4(id:string):string;
    procedure Open(Id:string);
    procedure Open2(Id:string);
    procedure Open3(Id:string);
    procedure Open4(Id:string);
  end;

implementation
uses ufrmSalLocusOrder, ufrmDbLocusOrder, ufrmChangeLocusOrder, ufrmStkRetuLocusOrder, uDsUtil, uFnUtil,uGlobal,uShopUtil,uXDictFactory,ufrmFastReport,uShopGlobal,
  ObjCommon, ufrmDbOkDialog;
{$R *.dfm}

{ TfrmStockOrderList }

function TfrmOutLocusOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=1 and A.CHK_DATE is not null and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndDEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID';
  if trim(fndSALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndSALES_ID.Text)+'''';
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w :=w +' and (A.LOCUS_STATUS<>''3'' or A.LOCUS_STATUS is null)';
       2:w :=w +' and A.LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';
  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.SEND_ADDR,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,'+
            'A.SALE_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,A.LOCUS_AMT,A.LOCUS_CHK_DATE,A.LOCUS_CHK_USER, '+
            'case when LOCUS_STATUS = ''3'' then ''已发货'' else ''待发货'' end as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+' ';
  result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left outer join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
  result := 'select jc.*,c.RECV_MNY,c.RECK_MNY from ('+result+') jc left outer join ACC_RECVABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SALES_ID=c.SALES_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
  result := 'select jf.*,f.USER_NAME as LOCUS_USER_TEXT from ('+result+') jf left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.LOCUS_USER=f.USER_ID ';
  result := 'select jg.*,g.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.LOCUS_CHK_USER=g.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by SALES_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by SALES_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by SALES_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by SALES_ID limit 600';
  else
    result := 'select * from ('+result+') j order by SALES_ID';
  end;
end;

function TfrmOutLocusOrderList.GetFormClass: TFormClass;
begin
  case rzPage.ActivePageIndex of
  0:result := TfrmSalLocusOrder;
  1:result := TfrmDbLocusOrder;
  2:result := TfrmChangeLocusOrder;
  3:result := TfrmStkRetuLocusOrder;
  end;
end;

procedure TfrmOutLocusOrderList.Open(Id: string);
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
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('SALES_ID').AsString;
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
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmOutLocusOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmOutLocusOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  InitGridPickList(DBGridEh1);
  InitGridPickList(DBGridEh2);
  InitGridPickList(DBGridEh3);
  InitGridPickList(DBGridEh4);
  
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  D1.Date := date();
  D2.Date := date();

  fndP2_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP2_SHOP_ID.Text := Global.SHOP_NAME;
  fndP2_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  InitGridPickList(DBGridEh1);
  fndP2_CLIENT_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP2_D1.Date := date();
  fndP2_D2.Date := date();

  fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP3_SHOP_ID.Text := Global.SHOP_NAME;
  fndP3_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP3_DUTY_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndP3_D1.Date := date();
  fndP3_D2.Date := date();

  fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP4_SHOP_ID.Text := Global.SHOP_NAME;
  fndP4_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP4_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP4_DEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndP4_DEPT_ID.RangeField := 'DEPT_TYPE';
  fndP4_DEPT_ID.RangeValue := '1';
  fndP4_D1.Date := date();
  fndP4_D2.Date := date();

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndSHOP_ID.KeyValue := Global.SHOP_ID;
    fndSHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndSHOP_ID.Style);
    fndSHOP_ID.Properties.ReadOnly := True;

    fndP2_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP2_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP2_SHOP_ID.Style);
    fndP2_SHOP_ID.Properties.ReadOnly := True;

    fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP3_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
    fndP3_SHOP_ID.Properties.ReadOnly := True;

    fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP4_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP4_SHOP_ID.Style);
    fndP4_SHOP_ID.Properties.ReadOnly := True;
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';

      Label2.Caption := '调出仓库';
      RzLabel7.Caption := '调入仓库';

      Label6.Caption := '仓库名称';

      Label8.Caption := '仓库名称';
    end;
end;

procedure TfrmOutLocusOrderList.FormShow(Sender: TObject);
begin
  inherited;
  rzPage.ActivePageIndex := 0;
  Open('');
  if ShopGlobal.GetChkRight('11200001',2) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmOutLocusOrderList.actFindExecute(Sender: TObject);
begin
  if rzPage.ActivePageIndex > 3 then
     inherited;
  case rzPage.ActivePageIndex of
  0:Open('');
  1:Open2('');
  2:Open3('');
  3:Open4('');
  end;

end;

procedure TfrmOutLocusOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14700001',3) then Raise Exception.Create('你没有重扫的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmOutLocusOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14700001',3) then Raise Exception.Create('你没有重扫的权限,请和管理员联系.');
  inherited;
end;

procedure TfrmOutLocusOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14700001',4) then Raise Exception.Create('你没有审核的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmOutLocusOrderList.actInfoExecute(Sender: TObject);
var idx:integer;
begin
  inherited;
  if (CurOrder=nil) then
     begin
       idx := RzPage.ActivePageIndex;
       Clear;
       RzPage.ActivePageIndex := idx;
       case idx of
       0:begin
           if cdsList.IsEmpty then Exit;
           OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
         end;
       1:begin
           if cdsP2List.IsEmpty then Exit;
           OpenForm(cdsP2List.FieldbyName('SALES_ID').AsString,cdsP2List.FieldbyName('SHOP_ID').AsString);
         end;
       2:begin
           if cdsP3List.IsEmpty then Exit;
           OpenForm(cdsP3List.FieldbyName('CHANGE_ID').AsString,cdsP3List.FieldbyName('SHOP_ID').AsString);
         end;
       3:begin
           if cdsP4List.IsEmpty then Exit;
           OpenForm(cdsP4List.FieldbyName('STOCK_ID').AsString,cdsP4List.FieldbyName('SHOP_ID').AsString);
         end;
       end;
     end;

end;

procedure TfrmOutLocusOrderList.frfStockOrderUserFunction(const Name: String;
  p1, p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

function TfrmOutLocusOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT ,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+') as TOTAL_OWE_MNY,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+' and SALES_ID='''+id+''') as ORDER_OWE_MNY '+
   'from ('+
   'select jn.*,n.DEPT_NAME as DEPT_ID_TEXT from ('+
   'select jm.*,m.CODE_NAME as SETTLE_CODE_TEXT from ( '+
   'select jl.*,l.CODE_NAME as SALES_STYLE_TEXT from ( '+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.CODE_NAME as INVOICE_FLAG_TEXT from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
   'select jb.*,b.CLIENT_NAME,b.CLIENT_CODE,b.SETTLE_CODE,b.ADDRESS,b.POSTALCODE,b.TELEPHONE2 as MOVE_TELE,b.INTEGRAL as ACCU_INTEGRAL,b.FAXES as CLIENT_FAXES from ('+
   'select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.SALE_AMT,A.SALE_MNY,A.CASH_MNY,A.PAY_ZERO,A.PAY_DIBS,A.PAY_A,A.PAY_B,A.PAY_C,A.PAY_D,'+
   'A.PAY_E,A.PAY_F,A.PAY_G,A.PAY_H,A.PAY_I,A.PAY_J,A.INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_STYLE,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,B.CALC_MONEY,A.BARTER_INTEGRAL,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT from SAL_SALESORDER A,SAL_SALESDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+tenantid+' and A.SALES_ID='''+id+''' ) jb '+
   'left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INVOICE_FLAG'') e on je.INVOICE_FLAG=e.CODE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and  jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl  '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''2'' and TENANT_ID='+tenantid+') l on jl.SALES_STYLE=l.CODE_ID) jm '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tenantid+') m on jm.SETTLE_CODE=m.CODE_ID) jn '+
   'left outer join CA_DEPT_INFO n on jn.TENANT_ID=n.TENANT_ID and jn.DEPT_ID=n.DEPT_ID ) j order by SEQNO';
end;

procedure TfrmOutLocusOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14700001',5) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfSalesOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfSalesOrder);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmOutLocusOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14700001',5) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfSalesOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfSalesOrder,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmOutLocusOrderList.actNewExecute(Sender: TObject);
var
  idx: integer;
  SendMan: String;  //送货人
  SendDate: TDate;  //送货日期
begin
  if not ShopGlobal.GetChkRight('14700001',2) then Raise Exception.Create('你没有扫码的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       idx := RzPage.ActivePageIndex;
       Clear;
       RzPage.ActivePageIndex := idx;
       case idx of
       0:begin
           if cdsList.IsEmpty then Exit;
           OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
         end;
       1:begin
           if cdsP2List.IsEmpty then Exit;
//           SendMan := Global.UserId;
//           SendDate := Date();
//           if TfrmDbOkDialog.DBOkDialog(self,SendDate,SendMan) then
//           begin
           OpenForm(cdsP2List.FieldbyName('SALES_ID').AsString,cdsP2List.FieldbyName('SHOP_ID').AsString);
//             TfrmDbLocusOrder(CurOrder).edtGUIDE_USER.KeyValue:=SendMan;
//             TfrmDbLocusOrder(CurOrder).edtGUIDE_USER.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',SendMan);
//             TfrmDbLocusOrder(CurOrder).edtSALES_DATE.Date:=SendDate;
//           end;
         end;
       2:begin
           if cdsP3List.IsEmpty then Exit;
           OpenForm(cdsP3List.FieldbyName('CHANGE_ID').AsString,cdsP3List.FieldbyName('SHOP_ID').AsString);
         end;
       3:begin
           if cdsP4List.IsEmpty then Exit;
           OpenForm(cdsP4List.FieldbyName('STOCK_ID').AsString,cdsP4List.FieldbyName('SHOP_ID').AsString);
         end;
       end;
     end;
  if CurOrder<>nil then CurOrder.NewOrder;

end;

procedure TfrmOutLocusOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
//  if not ShopGlobal.GetChkRight('400021') then
     actInfo.OnExecute(nil)
//  else
//     actEdit.OnExecute(nil);

end;

procedure TfrmOutLocusOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

end;

procedure TfrmOutLocusOrderList.frfStockOrderGetValue(const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
end;

function TfrmOutLocusOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('14700001',6);
end;

procedure TfrmOutLocusOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  if CurOrder<>nil then
     begin
       actDelete.Enabled := (CurOrder.dbState<>dsBrowse);
       actAudit.Enabled := (CurOrder.dbState=dsBrowse);
     end
  else
     begin
        actDelete.Enabled := false;
        actAudit.Enabled := false;
     end;

end;

procedure TfrmOutLocusOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    //DBGridEh1.Canvas.Font.Color := clWhite;
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := $0000F2F2;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsP2List.RecNo)),length(Inttostr(cdsP2List.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

function TfrmOutLocusOrderList.EncodeSQL2(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=2 and A.CHK_DATE is not null and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2 ';
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
     w := w +' and A.SHOP_ID='''+Global.SHOP_ID+'''';
  if fndP2_CLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndP2_SHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if trim(fndP2_SALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndP2_SALES_ID.Text)+'''';
  if fndP2_STATUS.ItemIndex > 0 then
     begin
       case fndP2_STATUS.ItemIndex of
       1:w :=w +' and (A.LOCUS_STATUS<>''3'' or A.LOCUS_STATUS is null)';
       2:w :=w +' and A.LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';

  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.SALES_TYPE,A.PLAN_DATE,A.REMARK,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,'+
            'A.SALE_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,A.LOCUS_AMT,A.LOCUS_CHK_DATE,A.LOCUS_CHK_USER, '+
            'case when LOCUS_STATUS = ''3'' then ''已发货'' else ''待发货'' end as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+' ';
  result := 'select ja.*,a.SHOP_NAME as CLIENT_NAME from ('+result+') ja left outer join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.SHOP_ID';
  result := 'select jc.*,c.SHOP_NAME as SHOP_NAME from ('+result+') jc left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
  result := 'select jf.*,f.GUIDE_USER as STOCK_USER from ('+result+') jf left outer join STK_STOCKORDER f on jf.TENANT_ID=f.TENANT_ID and jf.SALES_ID=f.STOCK_ID and jf.SALES_TYPE=f.STOCK_TYPE ';
  result := 'select jg.*,g.USER_NAME as STOCK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.GUIDE_USER=g.USER_ID ';
  result := 'select jh.*,h.USER_NAME as LOCUS_USER_TEXT from ('+result+') jh left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.LOCUS_USER=h.USER_ID ';
  result := 'select ji.*,i.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') ji left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.LOCUS_CHK_USER=i.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by SALES_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by SALES_ID) where ROWNUM<=600';  
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by SALES_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by SALES_ID limit 600';
  else
    result := 'select * from ('+result+') j order by SALES_ID';
  end;
  result:=ParseSQL(Factor.iDbType, result);
end;

procedure TfrmOutLocusOrderList.Open2(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsP2List.DisableControls;
  try
    rs.SQL.Text := EncodeSQL2(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP2_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP2_D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndP2_CLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndP2_SHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldbyName('SALES_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsP2List.LoadFromStream(sm);
       cdsP2List.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsP2List.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd2 := True else IsEnd2 := false;
  finally
    cdsP2List.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmOutLocusOrderList.cdsP2ListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsP2List.ControlsDisabled then Exit;
  Open(MaxId2);

end;

function TfrmOutLocusOrderList.EncodeSQL3(id: string): string;
var w,w1:string;
begin
  w := 'where A.TENANT_ID=:TENANT_ID and A.CHK_DATE is not null and A.CHANGE_DATE>=:D1 and A.CHANGE_DATE<=:D2';
  if fndP3_DUTY_USER.AsString <> '' then
     w := w +' and A.DUTY_USER=:DUTY_USER';
  if fndP3_SHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if trim(fndP3_CHANGE_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndP3_CHANGE_ID.Text)+'''';
  if fndP3_STATUS.ItemIndex > 0 then
     begin
       case fndP3_STATUS.ItemIndex of
       1:w :=w +' and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
       2:w :=w +' and LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.CHANGE_ID>'''+id+'''';
  result := 'select A.CHANGE_ID,A.CHANGE_DATE,A.GLIDE_NO,A.CHANGE_TYPE,A.REMARK,A.DUTY_USER,A.CHANGE_CODE,A.TENANT_ID,A.DEPT_ID,A.SHOP_ID,A.CREA_DATE,A.CREA_USER,'+
            'A.CHANGE_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,A.LOCUS_AMT,A.LOCUS_CHK_DATE,A.LOCUS_CHK_USER, '+
            'case when LOCUS_STATUS = ''3'' then ''已发货'' else ''待发货'' end as LOCUS_STATUS_NAME from STO_CHANGEORDER A  '+w + ' ';
  result := 'select ja.*,a.DEPT_NAME from ('+result+') ja left outer join CA_DEPT_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.DEPT_ID=a.DEPT_ID';
  result := 'select jb.*,b.USER_NAME as DUTY_USER_TEXT from ('+result+') jb left outer join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.DUTY_USER=b.USER_ID';
  result := 'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+result+') jc left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID';
  result := 'select je.*,e.USER_NAME as LOCUS_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.LOCUS_USER=e.USER_ID ';
  result := 'select jf.*,f.SHOP_NAME as SHOP_NAME_TEXT from ('+result+') jf left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ';
  result := 'select jg.*,g.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.LOCUS_CHK_USER=g.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by CHANGE_ID';
  1:result := 'select * from ('+result+' order by CHANGE_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by CHANGE_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by CHANGE_ID limit 600';
  else
    result := 'select * from ('+result+') j order by CHANGE_ID';
  end;
end;

procedure TfrmOutLocusOrderList.Open3(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsP3List.DisableControls;
  try
    rs.SQL.Text := EncodeSQL3(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP3_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP3_D2.Date));
    if rs.Params.FindParam('DUTY_USER')<>nil then rs.Params.FindParam('DUTY_USER').AsString := fndP3_DUTY_USER.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndP3_SHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId3 := rs.FieldbyName('CHANGE_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsP3List.LoadFromStream(sm);
       cdsP3List.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsP3List.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd3 := True else IsEnd3 := false;
  finally
    cdsP3List.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmOutLocusOrderList.cdsP3ListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd3 or not DataSet.Eof then Exit;
  if cdsP3List.ControlsDisabled then Exit;
  Open(MaxId3);

end;

procedure TfrmOutLocusOrderList.DBGridEh3DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh3.CellRect(DBGridEh3.Col, DBGridEh3.Row).Top) and (not
    (gdFocused in State) or not DBGridEh3.Focused) then
  begin
    //DBGridEh1.Canvas.Font.Color := clWhite;
    DBGridEh3.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh3.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh3.canvas.Brush.Color := $0000F2F2;
      DBGridEh3.canvas.FillRect(ARect);
      DrawText(DBGridEh3.Canvas.Handle,pchar(Inttostr(cdsP3List.RecNo)),length(Inttostr(cdsP3List.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

function TfrmOutLocusOrderList.EncodeSQL4(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.CHK_DATE is not null and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2 and A.STOCK_TYPE=3';
  if fndP4_CLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndP4_SHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndP4_DEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID';
  if trim(fndP4_STOCK_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndP4_STOCK_ID.Text)+'''';
  if fndP4_STATUS.ItemIndex > 0 then
     begin
       case fndP4_STATUS.ItemIndex of
       1:w :=w +' and (A.LOCUS_STATUS<>''3'' or A.LOCUS_STATUS is null)';
       2:w :=w +' and A.LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';       
       end;
     end;
  if id<>'' then
     w := w +' and A.STOCK_ID>'''+id+'''';
  result :=
     'select A.TENANT_ID,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CREA_DATE,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.GUIDE_USER,A.CREA_USER,A.SHOP_ID,'+
     '-A.STOCK_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,-A.LOCUS_AMT as LOCUS_AMT,A.LOCUS_CHK_DATE,A.LOCUS_CHK_USER, '+
     'case when LOCUS_STATUS = ''3'' then ''已发货'' else ''待发货'' end as LOCUS_STATUS_NAME from STK_STOCKORDER A '+w+'';
  result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
  result := 'select jc.*,c.PAYM_MNY,c.RECK_MNY from ('+result+') jc left join ACC_PAYABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.STOCK_ID=c.STOCK_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
  result := 'select jf.*,f.USER_NAME as LOCUS_USER_TEXT from ('+result+') jf left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.LOCUS_USER=f.USER_ID ';
  result := 'select jg.*,g.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.LOCUS_CHK_USER=g.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by STOCK_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by STOCK_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by STOCK_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by STOCK_ID limit 600';
  else
    result := 'select * from ('+result+') j order by STOCK_ID';
  end;
end;

procedure TfrmOutLocusOrderList.Open4(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsP4List.DisableControls;
  try
    rs.SQL.Text := EncodeSQL4(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP4_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',fndP4_D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndP4_CLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndP4_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndP4_DEPT_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId4 := rs.FieldbyName('STOCK_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsP4List.LoadFromStream(sm);
       cdsP4List.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsP4List.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd4 := True else IsEnd4 := false;
  finally
    cdsP4List.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmOutLocusOrderList.cdsP4ListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd4 or not DataSet.Eof then Exit;
  if cdsP4List.ControlsDisabled then Exit;
  Open(MaxId4);

end;

procedure TfrmOutLocusOrderList.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh4.CellRect(DBGridEh4.Col, DBGridEh4.Row).Top) and (not
    (gdFocused in State) or not DBGridEh4.Focused) then
  begin
    //DBGridEh1.Canvas.Font.Color := clWhite;
    DBGridEh4.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh4.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh4.canvas.Brush.Color := $0000F2F2;
      DBGridEh4.canvas.FillRect(ARect);
      DrawText(DBGridEh4.Canvas.Handle,pchar(Inttostr(cdsP4List.RecNo)),length(Inttostr(cdsP4List.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

end.
