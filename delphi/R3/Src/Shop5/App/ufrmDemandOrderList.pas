{ 12300001	0		1	查询	2	新增	3	修改	4	删除	5	变价	6	增送	7	审核	8	打印  10导出}

unit ufrmDemandOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ActnList, Menus, ComCtrls,
  ToolWin, StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, ObjCommon,
  cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, RzButton,
  cxRadioGroup, ZBase, FR_Class, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmDemandOrderList = class(TframeOrderToolForm)
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnOk: TRzBitBtn;
    RzLabel5: TRzLabel;
    fndDEMA_ID: TcxTextEdit;
    fndSTATUS: TcxRadioGroup;
    actReport: TAction;
    frfDemandOrder: TfrReport;
    actRecv: TAction;
    ToolButton17: TToolButton;
    Label1: TLabel;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    Label3: TLabel;
    fndDEPT_ID: TzrComboBoxList;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure frfDemandOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure frfDemandOrderGetValue(const ParName: String; var ParValue: Variant);
  private
    { Private declarations }
    oid:string;
    FDemandType: String;
    function  CheckCanExport: boolean; override;
    procedure SetDemandType(const Value: String);
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function PrintSQL(tenantid,id:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    property DemandType:String read FDemandType write SetDemandType;
  end;

implementation
uses ufrmDemandOrder,uDevFactory,ufrmFastReport,uGlobal,uFnUtil,uShopUtil,uXDictFactory,ufrmRecvOrder,
  uShopGlobal,uDsUtil, ufrmBasic;
{$R *.dfm}

{ TfrmDemandOrderList }

function TfrmDemandOrderList.EncodeSQL(id: string): string;
var w,w1,w2:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.DEMA_TYPE='+QuotedStr(DemandType)+' and A.DEMA_DATE>=:D1 and A.DEMA_DATE<=:D2 '+ShopGlobal.GetDataRight('A.SHOP_ID',1);

  if fndSHOP_ID.AsString <> '' then
     w := w + ' and A.SHOP_ID=:SHOP_ID';
  //[2012.02.03 xhh修改:可以按树上下级查询]
  if fndDEPT_ID.AsString <> '' then
     w := w + ShopGlobal.GetDeptID('A.DEPT_ID',fndDEPT_ID.AsString);

  if trim(fndDEMA_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndDEMA_ID.Text)+'''';

  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w := w +' and A.CHK_DATE is null';
       2:w := w +' and A.CHK_DATE is not null';
       3:w2 := ' having sum(isnull(B.SHIP_AMOUNT,0)) = 0 ';
       4:w2 := ' having sum(isnull(B.SHIP_AMOUNT,0)) > 0 ';
       end;
     end;
  if id<>'' then
     w := w +' and A.DEMA_ID>'''+id+'''';
  result := 'select A.TENANT_ID,A.SHOP_ID,A.DEMA_ID,A.DEMA_TYPE,A.GLIDE_NO,A.DEMA_DATE,A.CLIENT_ID,A.DEMA_USER,A.DEMA_AMT,A.DEMA_MNY,A.CHK_DATE,A.CHK_USER,'+
  'sum(case when B.CALC_AMOUNT=0 then 0 else B.CALC_AMOUNT/(cast(B.CALC_AMOUNT/(B.AMOUNT*1.0) as decimal(18,3))*1.0) end) as SHIP_AMOUNT,'+
  'A.REMARK,A.CREA_DATE,A.CREA_USER from MKT_DEMANDORDER A left join MKT_DEMANDDATA B on A.TENANT_ID=B.TENANT_ID and A.DEMA_ID=B.DEMA_ID '+w+
  ' group by A.TENANT_ID,A.SHOP_ID,A.DEMA_ID,A.DEMA_TYPE,A.GLIDE_NO,A.DEMA_DATE,A.CLIENT_ID,A.DEMA_USER,A.DEMA_AMT,A.DEMA_MNY,A.CHK_DATE,A.CHK_USER,A.REMARK,A.CREA_DATE,A.CREA_USER '+w2;
  
  result := 'select ja.*,a.USER_NAME as CHK_USER_TEXT  from ('+result+') ja left outer join VIW_USERS a on ja.TENANT_ID=a.TENANT_ID and ja.CHK_USER=a.USER_ID';
  result := 'select jb.*,b.USER_NAME as DEMA_USER_TEXT from ('+result+') jb left outer join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.DEMA_USER=b.USER_ID';
  result := 'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+result+') jc left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by DEMA_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by DEMA_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by DEMA_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by DEMA_ID limit 600';
  else
    result := 'select * from ('+result+') j order by DEMA_ID';
  end;
end;

function TfrmDemandOrderList.GetFormClass: TFormClass;
begin
  result := TfrmDemandOrder;
end;

procedure TfrmDemandOrderList.Open(Id: string);
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
    rs.SQL.Text := ParseSQL(Factor.iDbType,EncodeSQL(Id));
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    //if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('DEMA_ID').AsString;
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

procedure TfrmDemandOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmDemandOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  InitGridPickList(DBGridEh1);
  D1.Date := date();
  D2.Date := date();

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;
end;

procedure TfrmDemandOrderList.actEditExecute(Sender: TObject);
begin
  if DemandType = '1' then
  begin
    if not ShopGlobal.GetChkRight('100002124',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then
  begin
    if not ShopGlobal.GetChkRight('100002132',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('DEMA_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmDemandOrder(CurOrder).DemandType := DemandType;

  if CurOrder=nil then Raise Exception.Create('"'+Caption+'"打开异常!');

  if TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if DemandType = '1' then
      begin
        if not ShopGlobal.GetChkRight('100002124',3) then
          Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
      end;
      if DemandType = '2' then
      begin
        if not ShopGlobal.GetChkRight('100002132',3) then
          Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
      end;
    end;
  inherited;

end;

procedure TfrmDemandOrderList.actDeleteExecute(Sender: TObject);
begin
  if DemandType = '1' then   //补货申请
  begin
    if not ShopGlobal.GetChkRight('100002124',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then  //领用申请
  begin
    if not ShopGlobal.GetChkRight('100002132',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('DEMA_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmDemandOrder(CurOrder).DemandType := DemandType;

  if CurOrder=nil then Raise Exception.Create('"'+Caption+'"打开异常!');

  if TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if DemandType = '1' then
      begin
        if not ShopGlobal.GetChkRight('100002124',4) then
          Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
      end;
      if DemandType = '2' then
      begin
        if not ShopGlobal.GetChkRight('100002132',4) then
          Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmDemandOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
      end;
    end;     
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if (
           ((DemandType = '1') and ShopGlobal.GetChkRight('100002124',2))
           or
           ((DemandType = '2') and ShopGlobal.GetChkRight('100002132',2))
           )
        and (MessageBox(Handle,pchar('删除当前单据成功,是否继续新增'+Caption+'？'),pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmDemandOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;

       //判断新单权限
       if (
          ((DemandType = '1') and ShopGlobal.GetChkRight('100002124',2))
           or
          ((DemandType = '2') and ShopGlobal.GetChkRight('100002132',2))
          )
          and (MessageBox(Handle,pchar('是否继续新增"'+Caption+'"？'),pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmDemandOrderList.actAuditExecute(Sender: TObject);
begin
  if DemandType = '1' then
  begin
    if not ShopGlobal.GetChkRight('100002124',5) then Raise Exception.Create('你没有审核(弃审)'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then
  begin
    if not ShopGlobal.GetChkRight('100002132',5) then Raise Exception.Create('你没有审核(弃审)'+Caption+'的权限,请和管理员联系.');
  end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('DEMA_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmDemandOrder(CurOrder).DemandType := DemandType;     
  inherited;

end;

procedure TfrmDemandOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;  
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('DEMA_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);

     end;
end;

procedure TfrmDemandOrderList.actPriorExecute(Sender: TObject);
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
          //Params.ParamByName('SALES_TYPE').asString := '1';
          if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Params.ParamByName('DEMA_TYPE').asString := DemandType;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TDemandOrderGetPrior',Params);
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

procedure TfrmDemandOrderList.actNextExecute(Sender: TObject);
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
          //Params.ParamByName('SALES_TYPE').asString := '1';
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Params.ParamByName('DEMA_TYPE').asString := DemandType;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TDemandOrderGetNext',Params);
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

procedure TfrmDemandOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

function TfrmDemandOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.* from ( '+
   'select jj.*,l.GODS_NAME,l.GODS_CODE,l.BARCODE from ('+
   'select ji.*,k.UNIT_NAME from ('+
   'select jh.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select jg.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jf.*,h.SHOP_NAME from ( '+
   'select je.*,g.CODE_NAME as DEMAND_NAME from ( '+
   'select jd.*,f.USER_NAME as CHK_USER_TEXT from ( '+
   'select jc.*,e.USER_NAME as CREA_USER_TEXT from ( '+
   'select jb.*,d.USER_NAME as DEMA_USER_TEXT from ( '+
   'select ja.*,c.CLIENT_NAME from ( '+
   'select A.TENANT_ID,A.SHOP_ID,A.DEMA_ID,A.DEMA_TYPE,A.GLIDE_NO,A.DEMA_DATE,A.CLIENT_ID,A.DEMA_USER,'+
   'A.DEMA_AMT,A.DEMA_MNY,A.CHK_DATE,A.CHK_USER,A.REMARK,A.CREA_DATE,A.CREA_USER,B.SEQNO,B.GODS_ID,'+
   'B.PROPERTY_01,B.PROPERTY_02,B.LOCUS_NO,B.BOM_ID,B.BATCH_NO,B.IS_PRESENT,B.UNIT_ID,B.AMOUNT,B.ORG_PRICE,'+
   'B.APRICE,B.AMONEY,B.AGIO_RATE,B.AGIO_MONEY,B.CALC_AMOUNT,B.CALC_MONEY,B.REMARK '+
   ' from MKT_DEMANDDATA B left join MKT_DEMANDORDER A on A.TENANT_ID=B.TENANT_ID '+
   ' and A.DEMA_ID=B.DEMA_ID where A.TENANT_ID='+tenantid+' and A.DEMA_ID='''+id+''' ) ja '+
   ' left outer join VIW_CLIENTINFO c on ja.TENANT_ID=c.TENANT_ID and ja.CLIENT_ID=c.CLIENT_ID ) jb '+
   ' left outer join VIW_USERS d on jb.TENANT_ID=d.TENANT_ID and jb.DEMA_USER=d.USER_ID ) jc '+
   ' left outer join VIW_USERS e on jc.TENANT_ID=e.TENANT_ID and jc.CREA_USER=e.USER_ID ) jd '+
   ' left outer join VIW_USERS f on jd.TENANT_ID=f.TENANT_ID and jd.CHK_USER=f.USER_ID ) je '+
   ' left outer join PUB_PARAMS g on je.DEMA_TYPE=g.CODE_ID where g.TYPE_CODE=''DEMA_TYPE'') jf '+
   ' left outer join CA_SHOP_INFO h on jf.TENANT_ID=h.TENANT_ID and jf.SHOP_ID=h.SHOP_ID ) jg '+
   ' left outer join VIW_SIZE_INFO i on jg.TENANT_ID=i.TENANT_ID and jg.PROPERTY_01=i.SIZE_ID ) jh '+
   ' left outer join VIW_COLOR_INFO j on jh.TENANT_ID=j.TENANT_ID and jh.PROPERTY_02=j.COLOR_ID ) ji '+
   ' left outer join VIW_MEAUNITS k on ji.TENANT_ID=k.TENANT_ID and ji.UNIT_ID=k.UNIT_ID ) jj '+
   ' left outer join VIW_GOODSINFO l on jj.TENANT_ID=l.TENANT_ID and jj.GODS_ID=l.GODS_ID ) j order by SEQNO';
end;

procedure TfrmDemandOrderList.frfDemandOrderUserFunction(const Name: String;
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

procedure TfrmDemandOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if DemandType = '1' then
  begin
    if not ShopGlobal.GetChkRight('100002124',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then
  begin
    if not ShopGlobal.GetChkRight('100002132',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  end;

  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfDemandOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('DEMA_ID').AsString),frfDemandOrder);
           end;
      finally
         free;
      end;
    end;

end;

procedure TfrmDemandOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if DemandType = '1' then
  begin
    //if not ShopGlobal.GetChkRight('100002124',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then
  begin
    if not ShopGlobal.GetChkRight('100002132',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  end;
  
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfDemandOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('DEMA_ID').AsString),frfDemandOrder,nil,true);
           end;
      finally
         free;
       end;
    end;                
end;

procedure TfrmDemandOrderList.actNewExecute(Sender: TObject);
begin
  if DemandType = '1' then
  begin
    //if not ShopGlobal.GetChkRight('100002124',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  end;
  if DemandType = '2' then
  begin
    if not ShopGlobal.GetChkRight('100002132',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  end;
  inherited;
  if CurOrder<>nil then
     TfrmDemandOrder(CurOrder).DemandType := DemandType;
end;

procedure TfrmDemandOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil)
end;

procedure TfrmDemandOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmDemandOrderList.frfDemandOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  //if ParName='打印人' then ParValue := ShopGlobal.UserName;
end;

function TfrmDemandOrderList.CheckCanExport: boolean;
begin
  if DemandType='1' then
    result:=ShopGlobal.GetChkRight('100002124',7)
  else if DemandType='2' then
    result:=ShopGlobal.GetChkRight('100002132',7);

end;

procedure TfrmDemandOrderList.SetDemandType(const Value: String);
var
  rs:TZQuery;
  SetCol: TColumnEh;
begin
  FDemandType := Value;
  if (Value = '1') then
  begin
    fndDEPT_ID.RangeField := 'DEPT_TYPE';
    fndDEPT_ID.RangeValue := '1';
  end;

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_PARAMS where CODE_ID='''+Value+''' and TYPE_CODE=''DEMA_TYPE'' ';
    Factor.Open(rs);
    Caption := rs.Fields[1].AsString+'单';
    lblToolCaption.Caption := '当前位置->'+Caption;
    RzPage.Pages[0].Caption := Caption + '查询';
  finally
    rs.Free;
  end;
  Open('');

end;

end.
