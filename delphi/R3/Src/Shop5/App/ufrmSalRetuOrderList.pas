
{  12500001	0	销售退货  1	查询  2	新增  3	修改  4	删除  5	变价  6	增送  7	审核 8	打印  9 导出 }

unit ufrmSalRetuOrderList;

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
  TfrmSalRetuOrderList = class(TframeOrderToolForm)
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    btnOk: TRzBitBtn;
    RzLabel5: TRzLabel;
    fndSALES_ID: TcxTextEdit;
    fndSTATUS: TcxRadioGroup;
    fndCLIENT_ID: TzrComboBoxList;
    actReport: TAction;
    frfSalRetuOrder: TfrReport;
    Label40: TLabel;
    actRecv: TAction;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    Label1: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    Label3: TLabel;
    fndDEPT_ID: TzrComboBoxList;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure frfSalRetuOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actRecvExecute(Sender: TObject);
    procedure frfSalRetuOrderGetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    oid:string;
    PrintTimes:Integer;
    function  CheckCanExport: boolean; override;
    procedure PrintBefore(Sender:TObject);
    procedure PrintAfter(Sender:TObject);
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function PrintSQL(tenantid,id:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
  end;

implementation
uses ufrmSalRetuOrder,uDevFactory,ufrmFastReport,uGlobal,uFnUtil,uShopUtil,uXDictFactory,ufrmRecvOrder,
  uShopGlobal,uDsUtil,uMsgBox;
{$R *.dfm}

{ TfrmStockOrderList }

function TfrmSalRetuOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=3 and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2';
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
       1:w := w +' and A.CHK_DATE is null';
       2:w := w +' and A.CHK_DATE is not null';
       3:w1 := w1 +' where RECK_MNY<>0';
       4:w1 := w1 +' where RECK_MNY=0';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';
  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.SEND_ADDR,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,-A.SALE_AMT as AMOUNT,-A.SALE_MNY as AMONEY,''2'' as RECV_TYPE, '+
            'case when LOCUS_STATUS = ''3'' then 3 else 1 end as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+' ';
  result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left outer join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
  result := 'select jc.*,-c.RECV_MNY as RECV_MNY,-c.RECK_MNY as RECK_MNY from ('+result+') jc left outer join ACC_RECVABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SALES_ID=c.SALES_ID and jc.RECV_TYPE=c.RECV_TYPE';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
  result := 'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+result+') jf left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID '+w1;
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

function TfrmSalRetuOrderList.GetFormClass: TFormClass;
begin
  result := TfrmSalRetuOrder;
end;

procedure TfrmSalRetuOrderList.Open(Id: string);
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

procedure TfrmSalRetuOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmSalRetuOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,fndSHOP_ID.Style);
    fndSHOP_ID.Properties.ReadOnly := True;
  end;  
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO'); 
  InitGridPickList(DBGridEh1);
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  D1.Date := date();
  D2.Date := date();

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
      DBGridEh1.Columns[4].Title.Caption := '仓库名称';
    end;
end;

procedure TfrmSalRetuOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  if ShopGlobal.GetChkRight('12500001',2) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmSalRetuOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12500001',3) then Raise Exception.Create('你没有编辑退货单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder=nil then Raise Exception.Create('"销售退货单"打开异常!');

  if TfrmSalRetuOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('12500001',7) then
        Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmSalRetuOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;

end;

procedure TfrmSalRetuOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12500001',4) then Raise Exception.Create('你没有删除退货单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder=nil then Raise Exception.Create('"销售退货单"打开异常!');

  if TfrmSalRetuOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('12500001',7) then
        Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmSalRetuOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('12500001',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增退货单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmSalRetuOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       //try
       //if DevFactory.SavePrint then
       //   DoPrintTicket(CurOrder.cid,CurOrder.oid,0,TfrmSalesOrder(CurOrder).Cash,TfrmSalesOrder(CurOrder).Dibs);
       //except
       //   MessageBox(Handle,'打印小票出错，请确定纸张是否安装，小票打印电源是否打开？',pchar(Application.Title),MB_OK+MB_ICONQUESTION);
       //end;
       //DevFactory.OpenCashBox;
       if (ShopGlobal.GetParameter('SAVE_SALES_PRINT')='1')
          and
          ShopGlobal.GetChkRight('12500001',8)
       then
          begin
            actPrint.OnExecute(nil);
          end;
       if ShopGlobal.GetChkRight('12500001',2) and (MessageBox(Handle,'是否继续新增退货单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmSalRetuOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12500001',7) then Raise Exception.Create('你没有新增退货单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;

end;

procedure TfrmSalRetuOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmSalRetuOrderList.actPriorExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('SHOP_ID').asString := CurOrder.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          Params.ParamByName('SALES_TYPE').asString := '3';
          if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TSalRetuOrderGetPrior',Params);
             if Temp.Fields[0].asString<>'' then
                CurOrder.Open(Temp.Fields[0].asString);
          finally
             Temp.Free;
          end;
        finally
          Params.Free;
        end;
     end
  else
     begin
        cdsList.Prior;
     end;
end;

procedure TfrmSalRetuOrderList.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('SHOP_ID').asString := CurOrder.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          Params.ParamByName('SALES_TYPE').asString := '3';
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TSalRetuOrderGetNext',Params);
             if Temp.Fields[0].asString<>'' then
                CurOrder.Open(Temp.Fields[0].asString);
          finally
             Temp.Free;
          end;
        finally
          Params.Free;
        end;
     end
  else
     begin
        cdsList.Next;
     end;
end;

procedure TfrmSalRetuOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

function TfrmSalRetuOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT ,'+
   '(select -sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+') as TOTAL_OWE_MNY,'+
   '(select -sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+' and SALES_ID='''+id+''') as ORDER_OWE_MNY,'+
   '(select GLIDE_NO from SAL_SALESORDER where SALES_ID=j.FROM_ID and TENANT_ID='+tenantid+') as GLIDE_NO_FROM '+
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
   'select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,A.PRINT_TIMES,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,-A.SALE_AMT as SALE_AMT,-A.SALE_MNY as SALE_MNY,A.CASH_MNY,A.PAY_ZERO,-A.PAY_DIBS as PAY_DIBS,-A.PAY_A as PAY_A,-A.PAY_B as PAY_B,-A.PAY_C as PAY_C,-A.PAY_D as PAY_D,'+
   '-A.PAY_E as PAY_E,-A.PAY_F as PAY_F,-A.PAY_G as PAY_G,-A.PAY_H as PAY_H,-A.PAY_I as PAY_I,-A.PAY_J as PAY_J,-A.INTEGRAL as INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_STYLE,'+
   '-B.AMOUNT as AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,-B.CALC_MONEY as CALC_MONEY,-A.BARTER_INTEGRAL as BARTER_INTEGRAL,'+
   'B.AGIO_RATE,-B.AGIO_MONEY as AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from SAL_SALESORDER A,SAL_SALESDATA B '+
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

procedure TfrmSalRetuOrderList.frfSalRetuOrderUserFunction(const Name: String;
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

procedure TfrmSalRetuOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12500001',8) then Raise Exception.Create('你没有打印退货单的权限,请和管理员联系.');
  //if (CurOrder<>nil) then
  //   begin
  //     if DevFactory.SavePrint then
  //        begin
  //          DoPrintTicket(CurOrder.cid,CurOrder.oid,0,0,0);
  //          Exit;
  //        end;
  //   end;
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             BeforePrint := PrintBefore;
             AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfSalRetuOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             BeforePrint := PrintBefore;
             AfterPrint := PrintAfter;             
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfSalRetuOrder);
           end;
      finally
         free;
      end;
    end;

end;

procedure TfrmSalRetuOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12500001',8) then Raise Exception.Create('你没有打印退货单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             BeforePrint := PrintBefore;
             AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfSalRetuOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             BeforePrint := PrintBefore;
             AfterPrint := PrintAfter;             
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfSalRetuOrder,nil,true);
           end;
      finally
         free;
       end;
    end;                
end;

procedure TfrmSalRetuOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12500001',2) then Raise Exception.Create('你没有新增退货单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmSalRetuOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
//  if not ShopGlobal.GetChkRight('500029') then
     actInfo.OnExecute(nil)
//  else
//     actEdit.OnExecute(nil);
end;

procedure TfrmSalRetuOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmSalRetuOrderList.actRecvExecute(Sender: TObject);
var
  rs:TZQuery;
  clid,cpid,oid:string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21300001',2) then Raise Exception.Create('你没有收款单新增权限,请和管理员联系.');
  rs := TZQuery.Create(nil);
  try
  if CurOrder<>nil then
     begin
       clid := TfrmSalRetuOrder(CurOrder).edtCLIENT_ID.AsString;
       cpid := CurOrder.cid;
       oid := CurOrder.oid;
     end
  else
     begin
       if cdsList.IsEmpty then Exit;
       clid := cdsList.FieldbyName('CLIENT_ID').AsString;
       cpid := cdsList.FieldbyName('SHOP_ID').AsString;
       oid := cdsList.FieldbyName('SALES_ID').AsString;
     end;
  rs.SQL.Text :=
     'select j.* from ('+
     'select A.ABLE_ID,A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,A.SALES_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.ACCT_INFO,A.RECV_TYPE,A.ACCT_MNY,A.RECV_MNY,A.REVE_MNY,A.RECK_MNY,A.ABLE_DATE,A.NEAR_DATE,C.SHOP_NAME as SHOP_ID_TEXT '+
     'from ACC_RECVABLE_INFO A,VIW_CUSTOMER B,CA_SHOP_INFO C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+clid+''' and A.RECK_MNY<>0  and A.RECV_TYPE<>''4'') j order by ABLE_ID';
  Factor.Open(rs);
  if rs.IsEmpty then Raise Exception.Create('当前选中的客户没有欠款...');
  with TfrmRecvOrder.Create(self) do
    begin
      try
        Append;
        edtCLIENT_ID.KeyValue := clid;
        edtCLIENT_ID.Text := TdsFind.GetNameByID(edtCLIENT_ID.DataSet,'CLIENT_ID','CLIENT_NAME',clid);
        rs.First;
        while not rs.eof do
          begin
            if rs.FieldbyName('RECK_MNY').AsFloat <> 0 then
               begin
                 cdsDetail.Append;
                 cdsDetail.FieldByName('ABLE_ID').AsString := rs.FieldbyName('ABLE_ID').AsString;
                 cdsDetail.FieldByName('ACCT_INFO').AsString := rs.FieldbyName('ACCT_INFO').AsString;
                 cdsDetail.FieldByName('RECV_TYPE').AsString := rs.FieldbyName('RECV_TYPE').AsString;
                 cdsDetail.FieldByName('ACCT_MNY').AsString := rs.FieldbyName('ACCT_MNY').AsString;
                 cdsDetail.FieldByName('RECK_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                 if rs.FieldbyName('SALES_ID').AsString = oid then
                    begin
                      cdsDetail.FieldByName('A').AsString := '1';
                      cdsDetail.FieldByName('RECV_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                      cdsDetail.FieldByName('BALA_MNY').AsString := '0';
                    end
                 else
                    begin
                      cdsDetail.FieldByName('A').AsString := '0';
                      cdsDetail.FieldByName('RECV_MNY').AsString := '0';
                      cdsDetail.FieldByName('BALA_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                    end;
                 cdsDetail.FieldByName('ABLE_DATE').AsString := rs.FieldbyName('ABLE_DATE').AsString;
                 cdsDetail.FieldByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
                 cdsDetail.FieldByName('CLIENT_ID_TEXT').AsString := rs.FieldbyName('CLIENT_ID_TEXT').AsString;
                 cdsDetail.FieldByName('SHOP_ID').AsString := rs.FieldbyName('SHOP_ID').AsString;
                 cdsDetail.FieldByName('SHOP_ID_TEXT').AsString := rs.FieldbyName('SHOP_ID_TEXT').AsString;
                 cdsDetail.Post;
               end;
            rs.Next;
          end;
        if ShowModal=MROK then
           begin
             if CurOrder<>nil then TfrmSalRetuOrder(CurOrder).ShowOweInfo;
           end;
      finally
        free;
      end;
    end;
 finally
   rs.Free;
 end;   
end;

procedure TfrmSalRetuOrderList.frfSalRetuOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  if ParName='打印人' then ParValue := ShopGlobal.UserName;
end;

function TfrmSalRetuOrderList.CheckCanExport: boolean;
begin
  result:=(ShopGlobal.GetChkRight('12300001',9) or ShopGlobal.GetChkRight('12300001',10));
end;

procedure TfrmSalRetuOrderList.PrintAfter(Sender: TObject);
var Sql_Str:String;
begin
  if CurOrder<>nil then
     Sql_Str := 'update SAL_SALESORDER set PRINT_TIMES = '+IntToStr(PrintTimes+1)+',PRINT_USER = '''+ShopGlobal.UserID+''' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SALES_ID='+QuotedStr(CurOrder.oid)
  else
     Sql_Str := 'update SAL_SALESORDER set PRINT_TIMES = '+IntToStr(PrintTimes+1)+',PRINT_USER = '''+ShopGlobal.UserID+''' where TENANT_ID='+cdsList.FieldbyName('TENANT_ID').AsString+' and SALES_ID='+QuotedStr(cdsList.FieldbyName('SALES_ID').AsString);
  Factor.ExecSQL(Sql_Str);
end;

procedure TfrmSalRetuOrderList.PrintBefore(Sender: TObject);
var rs:TZQuery;
    Sql_Str,Info:String;
    i:Integer;
begin
  rs := TZQuery.Create(nil);
  try
    if CurOrder<>nil then
       Sql_Str := 'select PRINT_TIMES,PRINT_USER from SAL_SALESORDER where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SALES_ID='+QuotedStr(CurOrder.oid)
    else
       Sql_Str := 'select PRINT_TIMES,PRINT_USER from SAL_SALESORDER where TENANT_ID='+cdsList.FieldbyName('TENANT_ID').AsString+' and SALES_ID='+QuotedStr(cdsList.FieldbyName('SALES_ID').AsString);
    rs.Close;
    rs.SQL.Text := Sql_Str;
    Factor.Open(rs);
    PrintTimes := rs.FieldByName('PRINT_TIMES').AsInteger;
    if PrintTimes > 0  then
       begin
         Info := '本单据已经打印"'+IntToStr(PrintTimes)+'"次,是否再次打印!';
         i := ShowMsgBox(Pchar(Info),'友情提示...',MB_YESNO+MB_ICONQUESTION);
         if i = 7 then
          Raise Exception.Create('');

       end;
  finally
    rs.Free;
  end;
end;

end.
