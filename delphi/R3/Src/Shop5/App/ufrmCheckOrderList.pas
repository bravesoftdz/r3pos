{ 14400001	0	盘点单 	1	查询	2	新增	3	修改	4	删除	5	审核	6	打印	7	导出
}

unit ufrmCheckOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ActnList, Menus, ComCtrls,
  ToolWin, StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, RzButton,
  cxRadioGroup, zBase, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, FR_Class;


type
  TOnPrintEvent=procedure(Sender:TObject) of object;
type
  TfrmCheckOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    fndPRINT_DATE: TcxTextEdit;
    Label1: TLabel;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    fndCHECK_EMPL: TzrComboBoxList;
    RzLabel6: TRzLabel;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    frfCheckOrder: TfrReport;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure frfCheckOrderGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frfCheckOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
  private
    oid: string;
    FDoCheckPrint: TOnPrintEvent;
    function  CheckCanExport: boolean; override;
    procedure SetDoCheckPrint(const Value: TOnPrintEvent);
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function PrintSQL(tenantid,shopid,printdate:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    property DoCheckPrint: TOnPrintEvent read FDoCheckPrint write SetDoCheckPrint;
  end;

implementation

uses
  ufrmCheckOrder,uGlobal,uShopUtil,uXDictFactory, uShopGlobal,uDsUtil,ufrmFastReport,uFnUtil,
  ufrmCheckTask, ufrmCheckTablePrint;

 {$R *.dfm}

{ TfrmStockOrderList }

function TfrmCheckOrderList.EncodeSQL(id: string): string;
var str,w,RowNum:string;
begin
  w := 'where TENANT_ID=:TENANT_ID and CREA_DATE>=:BEG_DATE and CREA_DATE<=:END_DATE ';
  if fndCHECK_EMPL.AsString <> '' then
     w := w +' and CREA_USER=:CREA_USER ';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and SHOP_ID=:SHOP_ID ';
  if trim(fndPRINT_DATE.Text) <> '' then
  begin
    case Factor.iDbType of
      0,1,5:
         w := w +' and Cast(PRINT_DATE as varchar(16)) like ''%'+trim(fndPRINT_DATE.Text)+'''';
      3: w := w +' and STR(PRINT_DATE) like ''%'+trim(fndPRINT_DATE.Text)+'''';
      4: w := w +' and to_char(PRINT_DATE) like ''%'+trim(fndPRINT_DATE.Text)+'''';
    end;
  end;

  if fndSTATUS.ItemIndex=1 then
    w := w +' and CHECK_STATUS=2 '
  else if fndSTATUS.ItemIndex=2 then
    w := w +' and CHECK_STATUS=1 ';

  if id<>'' then
    w := w +' and PRINT_DATE>'+id+' ';

  str:='select TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,CHK_USER,CHK_DATE from STO_PRINTORDER '+w+'';
  str:='select jb.*,b.USER_NAME as CREA_USER_TEXT,c.USER_NAME as CHK_USER_TEXT,d.SHOP_NAME as SHOP_ID_TEXT from ('+str+')jb '+
       ' left outer join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.CREA_USER=b.USER_ID '+
       ' left outer join VIW_USERS c on jb.TENANT_ID=c.TENANT_ID and jb.CHK_USER=c.USER_ID '+
       ' left outer join CA_SHOP_INFO d on jb.TENANT_ID=d.TENANT_ID and jb.SHOP_ID=d.SHOP_ID ';
  case Factor.iDbType of
   0,3: result:='select top 600 * from ('+str+') tmp order by PRINT_DATE ';
   1: result:='select * from ('+str+' order by jb.PRINT_DATE) where ROWNUM<=600 order by PRINT_DATE';
   4: result:='select tp.* from ('+str+' order by jb.PRINT_DATE) tp fetch first 600 rows only ';
   5: result:='select * from ('+str+') tmp order by PRINT_DATE limit 600 ';
  end;
end;

function TfrmCheckOrderList.GetFormClass: TFormClass;
begin
  result := TfrmCheckOrder;
end;

procedure TfrmCheckOrderList.Open(Id: string);
var
  rs: TZQuery;
  StrmData: TStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  StrmData:=TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=fndSHOP_ID.AsString;
    if rs.Params.FindParam('CREA_USER')<>nil then rs.ParamByName('CREA_USER').AsString:=Global.UserID;
    if rs.Params.FindParam('BEG_DATE')<>nil then rs.ParamByName('BEG_DATE').AsString:=formatDatetime('YYYY-MM-DD',D1.Date);
    if rs.Params.FindParam('END_DATE')<>nil then rs.ParamByName('END_DATE').AsString:=formatDatetime('YYYY-MM-DD',D2.Date)+' 23:59:59';
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('PRINT_DATE').AsString;
    rs.SaveToStream(StrmData); 
    cdsList.LoadFromStream(StrmData);
    if rs.RecordCount <100 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmCheckOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.Active) and (not Dataset.IsEmpty) and (DataSet.FindField('CHECK_STATUS')<>nil)  then
  begin 
    if trim(DataSet.FieldByName('CHECK_STATUS').AsString)='3' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
  end;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmCheckOrderList.FormCreate(Sender: TObject);
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
  fndCHECK_EMPL.DataSet := Global.GetZQueryFromName('CA_USERS');
  D1.Date := date();
  D2.Date := date();

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;
end;

procedure TfrmCheckOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TfrmCheckOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmCheckOrderList.actPriorExecute(Sender: TObject);
var
  Temp: TZQuery;
  Params: TftParamList;
begin
  inherited;
  if CurOrder <> nil then
  begin
    Params := TftParamList.Create(nil);
    Temp := TZQuery.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString:= CurOrder.cid;
      Params.ParamByName('CREA_USER').asString := Global.UserID;
      if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
        Params.ParamByName('PRINT_DATE').asString :=FormatDatetime('YYYYMMDD', Date()) 
      else
        Params.ParamByName('PRINT_DATE').asString := CurOrder.gid;

      Factor.Open(Temp,'TPrintOrderGetPrior',Params);
      if Temp.Fields[0].asString<>'' then
        CurOrder.Open(Temp.Fields[0].asString);
    finally
      Params.Free;
      Temp.Free;
    end;
  end else
  begin
    cdsList.Prior;
  end;
end;

procedure TfrmCheckOrderList.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
  begin
    Temp := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').asString := CurOrder.cid;
      Params.ParamByName('CREA_USER').asString := Global.UserID;

      if CurOrder.gid = '' then
         Params.ParamByName('PRINT_DATE').asString := FormatDatetime('YYYYMMDD', Date())
      else
         Params.ParamByName('PRINT_DATE').asString := CurOrder.gid;

      Factor.Open(Temp,'TPrintOrderGetNext',Params);
      if Temp.Fields[0].asString<>'' then
        CurOrder.Open(Temp.Fields[0].asString);
    finally
      Params.Free;
      Temp.Free;
    end;
  end else
  begin
    cdsList.Next;
  end;
end;

procedure TfrmCheckOrderList.actEditExecute(Sender: TObject);
begin        
  if not ShopGlobal.GetChkRight('14400001',3) then Raise Exception.Create('你没有盘点录入的权限,请和管理员联系.');
  if (CurOrder=nil) then
  begin
    if cdsList.IsEmpty then Exit;
    OpenForm(cdsList.FieldbyName('PRINT_DATE').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
  end;
  if CurOrder=nil then Raise Exception.Create('"盘点单"打开异常!');

//  if TfrmCheckOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
//    begin
//      if not ShopGlobal.GetChkRight('14400001',5) then
//        Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmCheckOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
//    end;
  inherited;
end;

procedure TfrmCheckOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14400001',4) then Raise Exception.Create('你没有盘点录入的权限,请和管理员联系.');
  if (CurOrder=nil) then
  begin
    if cdsList.IsEmpty then Exit;
    OpenForm(cdsList.FieldbyName('PRINT_DATE').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
  end;
  if CurOrder=nil then Raise Exception.Create('"盘点单"打开异常!');

  if TfrmCheckOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('14400001',5) then
        Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmCheckOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       {if (MessageBox(Handle,'删除当前单据成功,是否继续新增盘点单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
       }
       if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmCheckOrderList.actSaveExecute(Sender: TObject);
var Check_Status: Integer;
begin
  inherited;
  if (CurOrder<>nil) then
  begin
    if not CurOrder.saved then Exit;
    {if MessageBox(Handle,'是否继续新增盘点单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6 then
      CurOrder.NewOrder
    else
      if rzPage.PageCount>2 then CurOrder.Close;
    }
  end;
end;

procedure TfrmCheckOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14400001',5) then Raise Exception.Create('你没有审核盘点的权限,请和管理员联系.');
  if (CurOrder=nil) then
  begin
    if cdsList.IsEmpty then Exit;
    OpenForm(cdsList.FieldbyName('PRINT_DATE').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
  end;
  inherited;
end;

procedure TfrmCheckOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PRINT_DATE').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmCheckOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('14400001',2) then Raise Exception.Create('你没有盘点录入的权限,请和管理员联系.');
  //新判断当天是否有盘点
  if not TfrmCheckTask.StartTask then Exit;
  inherited;
end;

procedure TfrmCheckOrderList.actPrintExecute(Sender: TObject);
//var Aobj: TRecord_;
begin
  if not ShopGlobal.GetChkRight('14400001',6) then Raise Exception.Create('你没有打印盘点单的权限,请和管理员联系.');
  //调用打印报表
  {try
    Aobj:=TRecord_.Create;
    Aobj.ReadFromDataSet(cdsList);
    if Assigned(DoCheckPrint) then
      DoCheckPrint(Aobj);
  finally
    Aobj.Free;
  end;}
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),TfrmCheckOrder(CurOrder).edtSHOP_ID.AsString,CurOrder.gid),frfCheckOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;                     
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString,cdsList.FieldbyName('PRINT_DATE').AsString),frfCheckOrder);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmCheckOrderList.actPreviewExecute(Sender: TObject);
var Aobj: TRecord_;
begin
  if not ShopGlobal.GetChkRight('14400001',6) then Raise Exception.Create('你没有打印盘点单的权限,请和管理员联系.');
  //调用打印报表
  try
    Aobj:=TRecord_.Create;
    Aobj.ReadFromDataSet(cdsList);
    TfrmCheckTablePrint.frmCheckTablePrint(Aobj);
  finally
    Aobj.Free;
  end;
end;

function TfrmCheckOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('14400001',7);
end;

procedure TfrmCheckOrderList.SetDoCheckPrint(const Value: TOnPrintEvent);
begin
  FDoCheckPrint := Value;
end;

procedure TfrmCheckOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmCheckOrderList.frfCheckOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
end;

procedure TfrmCheckOrderList.frfCheckOrderUserFunction(const Name: String;
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

function TfrmCheckOrderList.PrintSQL(tenantid,shopid,printdate: string): string;
begin
  result :=
   'select jj.*,i.SHOP_NAME from ( '+
   'select ji.*,h.UNIT_NAME from ( '+
   'select jh.*,g.COLOR_NAME as PROPERTY_02_TEXT from ( '+
   'select jg.*,f.SIZE_NAME as PROPERTY_01_TEXT from ( '+
   'select je.*,d.USER_NAME as CHK_USER_TEXT from ( '+
   'select jd.*,c.USER_NAME as CREA_USER_TEXT from ( '+
   'select jc.TENANT_ID,jc.SHOP_ID,jc.PRINT_DATE,jc.GODS_ID,jc.PROPERTY_01,jc.PROPERTY_02,jc.BATCH_NO,'+
   'jc.LOCUS_NO,jc.BOM_ID,jc.CREA_USER,jc.CREA_DATE,jc.CHK_USER,jc.CHK_DATE,B.UNIT_ID,'+
   'jc.RCK_AMOUNT*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as RCK_AMOUNT,'+
   'jc.RCK_AMOUNT as RCK_CALC_AMOUNT,'+
   'jc.CHK_AMOUNT*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as AMOUNT,'+
   'jc.CHK_AMOUNT as CALC_AMOUNT,'+
   ' (case when ifnull(jc.RCK_AMOUNT,0)>ifnull(jc.CHK_AMOUNT,0) then ifnull(jc.RCK_AMOUNT,0)-ifnull(jc.CHK_AMOUNT,0) else 0 end)*1.00/case when '+
   'B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as LOSS_AMOUNT,'+
   ' (case when ifnull(jc.CHK_AMOUNT,0)>ifnull(jc.RCK_AMOUNT,0) then ifnull(jc.CHK_AMOUNT,0)-ifnull(jc.RCK_AMOUNT,0) else 0 end)*1.00/case when '+
   'B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as PROFIT_AMOUNT,'+
   'b.GODS_NAME,b.GODS_CODE,b.BARCODE,'+
   'b.NEW_OUTPRICE*case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as NEW_OUTPRICE from ( '+
   'select A.TENANT_ID,A.SHOP_ID,A.PRINT_DATE,A.CHECK_STATUS,A.CHECK_TYPE,A.CREA_USER,A.CREA_DATE,'+
   'A.CHK_USER,A.CHK_DATE,B.GODS_ID,B.BATCH_NO,B.BOM_ID,B.LOCUS_NO,B.PROPERTY_01,B.PROPERTY_02,B.RCK_AMOUNT,B.CHK_AMOUNT '+
   ' from STO_PRINTORDER A,STO_PRINTDATA B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID '+
   ' and A.PRINT_DATE=B.PRINT_DATE and A.TENANT_ID='+tenantid+' and A.SHOP_ID='+QuotedStr(shopid)+' and A.PRINT_DATE='+printdate+'  ) jc '+
   ' inner join VIW_GOODSPRICEEXT b on jc.TENANT_ID=b.TENANT_ID and jc.SHOP_ID=b.SHOP_ID and jc.GODS_ID=b.GODS_ID ) jd '+
   ' left join VIW_USERS c on jd.TENANT_ID=c.TENANT_ID and jd.CREA_USER=c.USER_ID ) je '+
   ' left join VIW_USERS d on je.TENANT_ID=d.TENANT_ID and je.CREA_USER=d.USER_ID ) jg '+
   ' left join VIW_SIZE_INFO f on jg.TENANT_ID=f.TENANT_ID and jg.PROPERTY_01=f.SIZE_ID ) jh '+
   ' left join VIW_COLOR_INFO g on jh.TENANT_ID=g.TENANT_ID and jh.PROPERTY_02=g.COLOR_ID ) ji '+
   ' left join VIW_MEAUNITS h on ji.TENANT_ID=h.TENANT_ID and ji.UNIT_ID=h.UNIT_ID ) jj '+
   ' left join CA_SHOP_INFO i on jj.TENANT_ID=i.TENANT_ID AND JJ.SHOP_ID=I.SHOP_ID ';
end;

end.
