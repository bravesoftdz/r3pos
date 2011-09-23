{ 11200001	0	进货入库	1	查询	2	新增	3	修改	4	删除	5	审核	6	打印	7	导出
}

unit ufrmInLocusOrderList;

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
  TfrmInLocusOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    fndCLIENT_ID: TzrComboBoxList;
    RzLabel5: TRzLabel;
    fndSTOCK_ID: TcxTextEdit;
    Label1: TLabel;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    frfStockOrder: TfrReport;
    ToolButton17: TToolButton;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    Label3: TLabel;
    fndDEPT_ID: TzrComboBoxList;
    TabSheet2: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RzBitBtn1: TRzBitBtn;
    fndP2_STATUS: TcxRadioGroup;
    fndP2_D1: TcxDateEdit;
    fndP2_D2: TcxDateEdit;
    fndP2_SALES_ID: TcxTextEdit;
    fndP2_CLIENT_ID: TzrComboBoxList;
    fndP2_SHOP_ID: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    DBGridEh2: TDBGridEh;
    cdsP2List: TZQuery;
    dsP2List: TDataSource;
    TabSheet3: TRzTabSheet;
    cdsP3List: TZQuery;
    dsP3List: TDataSource;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    Label6: TLabel;
    Label7: TLabel;
    fndP3_D1: TcxDateEdit;
    fndP3_D2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    fndP3_SALES_ID: TcxTextEdit;
    fndP3_STATUS: TcxRadioGroup;
    fndP3_SHOP_ID: TzrComboBoxList;
    fndP3_CLIENT_ID: TzrComboBoxList;
    DBGridEh3: TDBGridEh;
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
    function PrintSQL(tenantid,id:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    function EncodeSQL2(id:string):string;
    function EncodeSQL3(id:string):string;
    procedure Open2(Id:string);
    procedure Open3(Id:string);
  end;

implementation
uses ufrmStkLocusOrder, ufrmSalRetuLocusOrder, ufrmDbInLocusOrder, uDsUtil, ObjCommon, uFnUtil,uGlobal,uShopUtil,uXDictFactory,ufrmFastReport,uShopGlobal;
{$R *.dfm}

{ TfrmStockOrderList }

function TfrmInLocusOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2 and A.STOCK_TYPE=1';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndDEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID';
  if trim(fndSTOCK_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndSTOCK_ID.Text)+'''';
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w :=w +' and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
       2:w :=w +' and LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.STOCK_ID>'''+id+'''';
  result :=
     'select A.TENANT_ID,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CREA_DATE,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.GUIDE_USER,A.CREA_USER,A.SHOP_ID,A.STOCK_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,A.LOCUS_AMT,'+
     'A.LOCUS_CHK_USER,A.LOCUS_CHK_DATE,(case when LOCUS_STATUS = ''3'' then ''已收货'' else ''待收货'' end ) as LOCUS_STATUS_NAME from STK_STOCKORDER A '+w+'';
  result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
  result := 'select jc.*,c.PAYM_MNY,c.RECK_MNY from ('+result+') jc left join ACC_PAYABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.STOCK_ID=c.STOCK_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
  result := 'select jf.*,f.USER_NAME as LOCUS_USER_TEXT from ('+result+') jf left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.LOCUS_USER=f.USER_ID ';
  result := 'select jg.*,g.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.LOCUS_CHK_USER=g.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by STOCK_ID';
  1:result := 'select * from ('+result+' order by STOCK_ID) j where ROWNUM<=600 ';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by STOCK_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by STOCK_ID limit 600';
  else
    result := 'select * from ('+result+') j order by STOCK_ID';
  end;
end;

function TfrmInLocusOrderList.GetFormClass: TFormClass;
begin
  case rzPage.ActivePageIndex of
  0:result := TfrmStkLocusOrder;
  1:result := TfrmSalRetuLocusOrder;
  2:result := TfrmDbInLocusOrder;
  end;
end;

procedure TfrmInLocusOrderList.Open(Id: string);
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
    MaxId := rs.FieldbyName('STOCK_ID').AsString;
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

procedure TfrmInLocusOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmInLocusOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  InitGridPickList(DBGridEh1);
  InitGridPickList(DBGridEh2);
  InitGridPickList(DBGridEh3);

  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  InitGridPickList(DBGridEh1);
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  D1.Date := date();
  D2.Date := date();

  fndP2_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP2_SHOP_ID.Text := Global.SHOP_NAME;
  fndP2_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP2_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP2_DEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndP2_DEPT_ID.RangeField := 'DEPT_TYPE';
  fndP2_DEPT_ID.RangeValue := '1';
  fndP2_D1.Date := date();
  fndP2_D2.Date := date();

  fndP3_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP3_CLIENT_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP3_D1.Date := date();
  fndP3_D2.Date := date();

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

    fndP3_CLIENT_ID.KeyValue := Global.SHOP_ID;
    fndP3_CLIENT_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP3_CLIENT_ID.Style);
    fndP3_CLIENT_ID.Properties.ReadOnly := True;
    
  end;

    if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '进货仓库';
      Label2.Caption := '仓库名称';
    end;

  RzPage.ActivePageIndex := 0;
end;

procedure TfrmInLocusOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  if ShopGlobal.GetChkRight('11200001',2) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmInLocusOrderList.actFindExecute(Sender: TObject);
begin
  if rzPage.ActivePageIndex > 2 then
     inherited;
  case rzPage.ActivePageIndex of
  0:Open('');
  1:Open2('');
  2:Open3('');
  end;

end;

procedure TfrmInLocusOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14600001',3) then Raise Exception.Create('你没有重扫的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmInLocusOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14600001',3) then Raise Exception.Create('你没有重扫的权限,请和管理员联系.');
  inherited;
end;

procedure TfrmInLocusOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14600001',4) then Raise Exception.Create('你没有审核的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmInLocusOrderList.actInfoExecute(Sender: TObject);
var
  idx:integer;
begin
  if (CurOrder=nil) then
     begin
       idx := RzPage.ActivePageIndex;
       Clear;
       RzPage.ActivePageIndex := idx;
       case idx of
       0:begin
           if cdsList.IsEmpty then Exit;
           OpenForm(cdsList.FieldbyName('STOCK_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
         end;
       1:begin
           if cdsP2List.IsEmpty then Exit;
           OpenForm(cdsP2List.FieldbyName('SALES_ID').AsString,cdsP2List.FieldbyName('SHOP_ID').AsString);
         end;
       2:begin
           if cdsP3List.IsEmpty then Exit;
           OpenForm(cdsP3List.FieldbyName('SALES_ID').AsString,cdsP3List.FieldbyName('SHOP_ID').AsString);
         end;
       end;
     end;
end;

procedure TfrmInLocusOrderList.frfStockOrderUserFunction(const Name: String;
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

function TfrmInLocusOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT,'+
   'j.STOCK_MNY/(1+j.TAX_RATE)*j.TAX_RATE as TOTAL_TAX_MNY,'+
   'j.STOCK_MNY-j.STOCK_MNY/(1+j.TAX_RATE)*j.TAX_RATE as TOTAL_NOTAX_MNY,'+
   '(select sum(RECK_MNY) from ACC_PAYABLE_INFO where TENANT_ID='+tenantid+' and CLIENT_ID=j.CLIENT_ID and STOCK_ID='''+id+''') as ORDER_OWE_MNY,'+
   '(select sum(RECK_MNY) from ACC_PAYABLE_INFO where TENANT_ID='+tenantid+' and CLIENT_ID=j.CLIENT_ID) as TOTAL_OWE_MNY '+
   'from ('+
   'select jm.*,m.DEPT_NAME as DEPT_ID_TEXT from ('+
   'select jl.*,l.CODE_NAME as SETTLE_CODE_TEXT from ('+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.CODE_NAME as INVOICE_FLAG_TEXT from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
   'select jb.*,b.CLIENT_NAME,b.LINKMAN,b.TELEPHONE2 as MOVE_TELE,b.SETTLE_CODE,b.POSTALCODE,b.ADDRESS,b.FAXES CLIENT_FAXES from ('+
   'select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.STOCK_AMT,A.STOCK_MNY,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.GODS_ID,B.LOCUS_NO,B.CALC_MONEY,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT from STK_STOCKORDER A,STK_STOCKDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and A.TENANT_ID='+tenantid+' and A.STOCK_ID='''+id+''' ) jb '+
   'left outer join VIW_CLIENTINFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INVOICE_FLAG'') e on je.INVOICE_FLAG=e.CODE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tenantid+') l on jl.SETTLE_CODE=l.CODE_ID) jm '+
   'left outer join CA_DEPT_INFO m on jm.TENANT_ID=m.TENANT_ID and jm.DEPT_ID=m.DEPT_ID ) j order by SEQNO';
end;

procedure TfrmInLocusOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14600001',5) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfStockOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('STOCK_ID').AsString),frfStockOrder);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmInLocusOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14600001',5) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfStockOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('STOCK_ID').AsString),frfStockOrder,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmInLocusOrderList.actNewExecute(Sender: TObject);
var
  idx:integer;
begin
  if not ShopGlobal.GetChkRight('14600001',2) then Raise Exception.Create('你没有扫码的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       idx := RzPage.ActivePageIndex;
       Clear;
       RzPage.ActivePageIndex := idx;
       case idx of
       0:begin
           if cdsList.IsEmpty then Exit;
           OpenForm(cdsList.FieldbyName('STOCK_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
         end;
       1:begin
           if cdsP2List.IsEmpty then Exit;
           OpenForm(cdsP2List.FieldbyName('SALES_ID').AsString,cdsP2List.FieldbyName('SHOP_ID').AsString);
         end;
       2:begin
           if cdsP3List.IsEmpty then Exit;
           OpenForm(cdsP3List.FieldbyName('SALES_ID').AsString,cdsP3List.FieldbyName('SHOP_ID').AsString);
         end;
       end;
     end;
  if CurOrder<>nil then CurOrder.NewOrder;
end;

procedure TfrmInLocusOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
//  if not ShopGlobal.GetChkRight('400021') then
     actInfo.OnExecute(nil)
//  else
//     actEdit.OnExecute(nil);

end;

procedure TfrmInLocusOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmInLocusOrderList.frfStockOrderGetValue(const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
end;

function TfrmInLocusOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('14600001',6);
end;

procedure TfrmInLocusOrderList.RzPageChange(Sender: TObject);
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

function TfrmInLocusOrderList.EncodeSQL2(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=3 and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2';
  if fndP2_CLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndP2_SHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndP2_DEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID';
  if trim(fndP2_SALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndP2_SALES_ID.Text)+'''';
  if fndP2_STATUS.ItemIndex > 0 then
     begin
       case fndP2_STATUS.ItemIndex of
       1:w :=w +' and (LOCUS_STATUS<>''3'' or LOCUS_STATUS is null)';
       2:w :=w +' and LOCUS_STATUS=''3''';
       3:w :=w +' and A.LOCUS_CHK_USER is null ';
       4:w :=w +' and A.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';
  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.SEND_ADDR,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,'+
            '-A.SALE_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,-A.LOCUS_AMT as LOCUS_AMT,A.LOCUS_CHK_USER,A.LOCUS_CHK_DATE, '+
            '(case when LOCUS_STATUS = ''3'' then ''已收货'' else ''待收货'' end ) as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+'';
  result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left outer join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
  result := 'select jc.*,c.RECV_MNY,c.RECK_MNY from ('+result+') jc left outer join ACC_RECVABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SALES_ID=c.SALES_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
  result := 'select jf.*,f.USER_NAME as LOCUS_USER_TEXT from ('+result+') jf left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.LOCUS_USER=f.USER_ID';
  result := 'select jg.*,g.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.LOCUS_CHK_USER=g.USER_ID '+w1;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by SALES_ID';
  1:result := 'select * from ('+result+' order by SALES_ID) j where ROWNUM<=600 ';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by SALES_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by SALES_ID limit 600';
  else
    result := 'select * from ('+result+') j order by SALES_ID';
  end;
end;

procedure TfrmInLocusOrderList.Open2(Id: string);
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
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndP2_DEPT_ID.AsString;
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

procedure TfrmInLocusOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmInLocusOrderList.cdsP2ListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsP2List.ControlsDisabled then Exit;
  Open(MaxId2);

end;

function TfrmInLocusOrderList.EncodeSQL3(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=2 and A.CHK_DATE is not null and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2 and A.LOCUS_STATUS=''3'' ';
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
     w := w +' and A.CLIENT_ID='''+Global.SHOP_ID+'''';
  if fndP3_CLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndP3_SHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if trim(fndP3_SALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndP3_SALES_ID.Text)+'''';
  if fndP3_STATUS.ItemIndex > 0 then
     begin
       case fndP3_STATUS.ItemIndex of
       1:w1 :=' where (f.LOCUS_STATUS<>''3'' or f.LOCUS_STATUS is null) ';
       2:w1 :=' where f.LOCUS_STATUS=''3'' ';
       3:w1 :=' where f.LOCUS_CHK_USER is null ';
       4:w1 :=' where f.LOCUS_CHK_USER is not null ';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';

  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.SALES_TYPE,A.PLAN_DATE,A.REMARK,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,'+
            'A.SALE_AMT as AMOUNT,A.LOCUS_DATE,A.LOCUS_USER,A.LOCUS_AMT,A.LOCUS_CHK_DATE,A.LOCUS_CHK_USER '+
            ' from SAL_SALESORDER A '+w+' ';
  result := 'select ja.*,a.SHOP_NAME as CLIENT_NAME from ('+result+') ja left outer join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.SHOP_ID';
  result := 'select jc.*,c.SHOP_NAME as SHOP_NAME from ('+result+') jc left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
  result := 'select jf.*,f.GUIDE_USER as STOCK_USER,(case when f.LOCUS_STATUS = ''3'' then ''已收货'' else ''待收货'' end ) as LOCUS_STATUS_NAME from ('+result+') jf left outer join STK_STOCKORDER f on jf.TENANT_ID=f.TENANT_ID and jf.SALES_ID=f.STOCK_ID and jf.SALES_TYPE=f.STOCK_TYPE '+w1;
  result := 'select jg.*,g.USER_NAME as STOCK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.GUIDE_USER=g.USER_ID ';
  result := 'select jh.*,h.USER_NAME as LOCUS_USER_TEXT from ('+result+') jh left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.LOCUS_USER=h.USER_ID ';
  result := 'select ji.*,i.USER_NAME as LOCUS_CHK_USER_TEXT from ('+result+') ji left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.LOCUS_CHK_USER=i.USER_ID ';
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

procedure TfrmInLocusOrderList.Open3(Id: string);
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
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndP3_CLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndP3_SHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId3 := rs.FieldbyName('SALES_ID').AsString;
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

procedure TfrmInLocusOrderList.cdsP3ListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd3 or not DataSet.Eof then Exit;
  if cdsP3List.ControlsDisabled then Exit;
  Open(MaxId3);

end;

procedure TfrmInLocusOrderList.DBGridEh3DrawColumnCell(Sender: TObject;
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

end.
