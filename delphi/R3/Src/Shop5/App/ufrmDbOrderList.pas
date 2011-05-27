{ 14100001	0	调拨单	1	查询	2	新增	3	修改	4	删除	5	到货确认	6	审核	7	打印	8	导出 }

unit ufrmDbOrderList;

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
  TfrmDbOrderList = class(TframeOrderToolForm)
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    btnOk: TRzBitBtn;
    RzLabel5: TRzLabel;
    fndSALES_ID: TcxTextEdit;
    fndSTATUS: TcxRadioGroup;
    actReport: TAction;
    frfDbOrder: TfrReport;
    Label40: TLabel;
    ToolButton17: TToolButton;
    Label1: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    fndCLIENT_ID: TzrComboBoxList;
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
    procedure frfDbOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure actfrmRecvOrderExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure frfDbOrderGetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    oid:string;
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
uses ufrmDbOrder,uDevFactory,ufrmFastReport,uGlobal,uFnUtil,uShopUtil,uXDictFactory,
  uShopGlobal,uDsUtil;
{$R *.dfm}

{ TfrmStockOrderList }

function TfrmDbOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=2 and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if trim(fndSALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndSALES_ID.Text)+'''';
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w := w +' and A.CHK_DATE is null';
       2:w := w +' and A.CHK_DATE is not null';
       3:w1 := w1 +' where STOCK_USER is null';
       4:w1 := w1 +' where STOCK_USER is not null';
       end;
     end;
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';
  result := 'select A.TENANT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.SALES_TYPE,A.PLAN_DATE,A.REMARK,A.CLIENT_ID,A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,A.SALE_AMT as AMOUNT,A.SALE_MNY as AMONEY '+
            'from SAL_SALESORDER A '+w+' ';
  result := 'select ja.*,a.SHOP_NAME as CLIENT_NAME from ('+result+') ja left outer join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.SHOP_ID';
  result := 'select jc.*,c.SHOP_NAME as SHOP_NAME from ('+result+') jc left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID';
  result := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+result+') jd left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
  result := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+result+') je left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
  result := 'select jf.*,f.GUIDE_USER as STOCK_USER from ('+result+') jf left outer join STK_STOCKORDER f on jf.TENANT_ID=f.TENANT_ID and jf.SALES_ID=f.STOCK_ID and jf.SALES_TYPE=f.STOCK_TYPE ';
  result := 'select jg.*,g.USER_NAME as STOCK_USER_TEXT from ('+result+') jg left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.GUIDE_USER=g.USER_ID '+w1;
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
end;

function TfrmDbOrderList.GetFormClass: TFormClass;
begin
  result := TfrmDbOrder;
end;

procedure TfrmDbOrderList.Open(Id: string);
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

procedure TfrmDbOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmDbOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO'); 
  InitGridPickList(DBGridEh1);
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  D1.Date := date();
  D2.Date := date();
//  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
//    begin
//      SetEditStyle(dsBrowse,fndSHOP_ID.Style);
//      fndSHOP_ID.Properties.ReadOnly := True;
//    end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '调出仓库';
      RzLabel4.Caption := '调入仓库';
    end;
end;

procedure TfrmDbOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  //默认新单前判断是否有权限
  if ShopGlobal.GetChkRight('14100001',2) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmDbOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14100001',3) then Raise Exception.Create('你没有修改调拨单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;

end;

procedure TfrmDbOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14100001',4) then Raise Exception.Create('你没有删除调拨单的权限,请和管理员联系.');
  if (CurOrder=nil) then
  begin
    if cdsList.IsEmpty then Exit;
    OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
  end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('14100001',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增调拨单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmDbOrderList.actSaveExecute(Sender: TObject);
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
          ShopGlobal.GetChkRight('14100001',7)
       then
          begin
            actPrint.OnExecute(nil);
          end;
       if ShopGlobal.GetChkRight('14100001',2) and (MessageBox(Handle,'是否继续新增调拨单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmDbOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14100001',6) then Raise Exception.Create('你没有审核调拨单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;

end;

procedure TfrmDbOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('SALES_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmDbOrderList.actPriorExecute(Sender: TObject);
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
          Params.ParamByName('SALES_TYPE').asString := '2';
          if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TDbOrderGetPrior',Params);
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

procedure TfrmDbOrderList.actNextExecute(Sender: TObject);
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
          Params.ParamByName('SALES_TYPE').asString := '2';
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TDbOrderGetNext',Params);
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

procedure TfrmDbOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

function TfrmDbOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT '+
   'from ('+
   'select jn.*,n.STOCK_USER_TEXT as STOCK_USER_TEXT from ( '+
//   'select jm.*,m.CODE_NAME as SETTLE_CODE_TEXT from ( '+
//   'select jl.*,l.CODE_NAME as SALES_STYLE_TEXT from ( '+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.CODE_NAME as INVOICE_FLAG_TEXT from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
   'select jb.*,b.SHOP_NAME as CLIENT_NAME,b.SEQ_NO as CLIENT_CODE,b.ADDRESS,b.POSTALCODE,b.TELEPHONE as MOVE_TELE,b.FAXES as CLIENT_FAXES from ('+
   'select A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.SALE_AMT,A.SALE_MNY,A.CASH_MNY,A.PAY_ZERO,A.PAY_DIBS,A.PAY_A,A.PAY_B,A.PAY_C,A.PAY_D,'+
   'A.PAY_E,A.PAY_F,A.PAY_G,A.PAY_H,A.PAY_I,A.PAY_J,A.INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_TYPE,A.SALES_STYLE,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,B.CALC_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,'+
   'B.BARTER_INTEGRAL,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from SAL_SALESORDER A,SAL_SALESDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+tenantid+' and A.SALES_ID='''+id+''' ) jb '+
   'left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.SHOP_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INVOICE_FLAG'') e on je.INVOICE_FLAG=e.CODE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and  jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jn  '+
//   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''2'' and TENANT_ID='+tenantid+') l on jl.SALES_STYLE=l.CODE_ID) jm '+
//   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tenantid+') m on jm.SETTLE_CODE=m.CODE_ID) jn '+
   'left outer join (select n1.TENANT_ID,n1.STOCK_ID,n2.USER_NAME as STOCK_USER_TEXT from STK_STOCKORDER n1,VIW_USERS n2 where n1.TENANT_ID=n2.TENANT_ID and n1.GUIDE_USER=n2.USER_ID and n1.TENANT_ID='+tenantid+' and n1.STOCK_ID='''+id+''' and STOCK_TYPE=2 ) n on jn.TENANT_ID=n.TENANT_ID and jn.SALES_ID=n.STOCK_ID '+
   ') j order by SEQNO ';
end;

procedure TfrmDbOrderList.frfDbOrderUserFunction(const Name: String;
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

procedure TfrmDbOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',7) then Raise Exception.Create('你没有打印调拨单的权限,请和管理员联系.');
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
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfDbOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfDbOrder);
           end;
      finally
         free;
      end;
    end;

end;

procedure TfrmDbOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('14100001',7) then Raise Exception.Create('你没有打印调拨单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfDbOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SALES_ID').AsString),frfDbOrder,nil,true);
           end;
      finally
         free;
       end;
    end;                
end;

procedure TfrmDbOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14100001',2) then Raise Exception.Create('你没有新增调拨单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmDbOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
//  if not ShopGlobal.GetChkRight('500029') then
     actInfo.OnExecute(nil)
//  else
//     actEdit.OnExecute(nil);
end;

procedure TfrmDbOrderList.actfrmRecvOrderExecute(Sender: TObject);
var
  rs:TZQuery;
  clid,cpid,oid:string;
begin
  inherited;
{ if not ShopGlobal.GetChkRight('700014') then Raise Exception.Create('你没有收款单新增权限,请和管理员联系.');
  rs := TZQuery.Create(nil);
  try
  if CurOrder<>nil then
     begin
       clid := TfrmSalesOrder(CurOrder).edtCLIENT_ID.AsString;
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
  rs.CommandText
     :='select A.ABLE_ID,A.COMP_ID,A.CUST_ID,A.SALES_ID,B.CUST_NAME as CUST_ID_TEXT,A.ACCT_INFO,A.ABLE_TYPE,A.ACCT_MNY,A.RECV_MNY,A.REVE_MNY,A.RECK_MNY,A.ABLE_DATE,A.NEAR_DATE,C.COMP_NAME as COMP_ID_TEXT '+
     'from RCK_RECVABLE_INFO A,VIW_CUSTOMER B,CA_COMPANY C where A.COMP_ID=C.COMP_ID and A.CUST_ID=B.CUST_ID and A.CUST_ID='''+clid+''' and A.RECK_MNY<>0 order by ABLE_ID';
  Factor.Open(rs);
  if rs.IsEmpty then Raise Exception.Create('当前选中的客户没有欠款...'); 
  with TfrmRecvAbleOrder.Create(self) do
    begin
      try
        Append;
        edtCUST_ID.KeyValue := clid;
        edtCUST_ID.Text := TdsFind.GetNameByID(edtCUST_ID.DataSet,'CUST_ID','CUST_NAME',clid); 
        rs.First;
        while not rs.eof do
          begin
            if rs.FieldbyName('RECK_MNY').AsFloat <> 0 then
               begin
                 cdsDetail.Append;
                 cdsDetail.FieldByName('ABLE_ID').AsString := rs.FieldbyName('ABLE_ID').AsString;
                 cdsDetail.FieldByName('ACCT_INFO').AsString := rs.FieldbyName('ACCT_INFO').AsString;
                 cdsDetail.FieldByName('ABLE_TYPE').AsString := rs.FieldbyName('ABLE_TYPE').AsString;
                 cdsDetail.FieldByName('ACCT_MNY').AsString := rs.FieldbyName('ACCT_MNY').AsString;
                 cdsDetail.FieldByName('RECK_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                 if rs.FieldbyName('SALES_ID').AsString = oid then
                    begin
                      cdsDetail.FieldByName('A').AsString := '1';
                      cdsDetail.FieldByName('PAY_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                      cdsDetail.FieldByName('BALA_MNY').AsString := '0';
                    end
                 else
                    begin
                      cdsDetail.FieldByName('A').AsString := '0';
                      cdsDetail.FieldByName('PAY_MNY').AsString := '0';
                      cdsDetail.FieldByName('BALA_MNY').AsString := rs.FieldbyName('RECK_MNY').AsString;
                    end;
                 cdsDetail.FieldByName('ABLE_DATE').AsString := rs.FieldbyName('ABLE_DATE').AsString;
                 cdsDetail.FieldByName('CUST_ID').AsString := rs.FieldbyName('CUST_ID').AsString;
                 cdsDetail.FieldByName('CUST_ID_TEXT').AsString := rs.FieldbyName('CUST_ID_TEXT').AsString;
                 cdsDetail.FieldByName('COMP_ID').AsString := rs.FieldbyName('COMP_ID').AsString;
                 cdsDetail.FieldByName('COMP_ID_TEXT').AsString := rs.FieldbyName('COMP_ID_TEXT').AsString;
                 cdsDetail.Post;
               end;
            rs.Next;
          end;
        if ShowModal=MROK then
           begin
             if CurOrder<>nil then TfrmSalesOrder(CurOrder).ShowOweInfo;
           end;
      finally
        free;
      end;
    end;
 finally
   rs.Free;
 end;     }
end;

procedure TfrmDbOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmDbOrderList.frfDbOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
end;

end.
