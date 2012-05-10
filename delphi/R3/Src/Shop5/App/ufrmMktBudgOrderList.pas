unit ufrmMktBudgOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractToolForm, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, Menus, ActnList, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, Grids, DBGridEh, RzTabs, RzPanel, cxRadioGroup,
  RzButton, cxTextEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, FR_Class;

type
  TfrmMktBudgOrderList = class(TframeContractToolForm)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label40: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    fndCLIENT_ID: TzrComboBoxList;
    fndGLIDE_NO: TcxTextEdit;
    fndDEPT_ID: TzrComboBoxList;
    btnOk: TRzBitBtn;
    fndSHOP_ID: TzrComboBoxList;
    fndSTATUS: TcxRadioGroup;
    frfMktBudgOrder: TfrReport;
    ToolButton15: TToolButton;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure frfMktBudgOrderGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frfMktBudgOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
  private
    { Private declarations }
    function CheckCanExport: boolean; override;
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
uses uDsUtil, uFnUtil,uGlobal,uShopUtil,uXDictFactory,ufrmFastReport, uShopGlobal,
   uMsgBox, ufrmMktBudgOrder;
{$R *.dfm}

procedure TfrmMktBudgOrderList.actNewExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',2) then Raise Exception.Create('你没有新增核销单的权限,请和管理员联系.');
  inherited;
end;

procedure TfrmMktBudgOrderList.actDeleteExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',4) then Raise Exception.Create('你没有删除核销单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('BUDG_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"核销单"打开异常!');

  if (TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString<>'')
  and (TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID) then
    begin
      if not ShopGlobal.GetChkRight('100002297',5) then
        Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       if ShopGlobal.GetChkRight('100002297',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增核销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktBudgOrderList.actEditExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',3) then Raise Exception.Create('你没有修改核销单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('BUDG_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"核销单"打开异常!');

  if (TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString<>'')
  and (TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID) then
    begin
      if not ShopGlobal.GetChkRight('100002297',5) then
        Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktBudgOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;

end;

procedure TfrmMktBudgOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       {if ShopGlobal.GetChkRight('100002297',6) then
          begin
            actPrint.OnExecute(nil);
          end;}
       if ShopGlobal.GetChkRight('100002297',2) and (MessageBox(Handle,'是否继续新增核销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktBudgOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002297',6) then Raise Exception.Create('你没有打印核销单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktBudgOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('BUDG_ID').AsString),frfMktBudgOrder);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktBudgOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100002297',6) then Raise Exception.Create('你没有打印核销单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktBudgOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('BUDG_ID').AsString),frfMktBudgOrder,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktBudgOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmMktBudgOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('BUDG_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmMktBudgOrderList.actAuditExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',5) then Raise Exception.Create('你没有审核核销单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('BUDG_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;
end;

procedure TfrmMktBudgOrderList.actPriorExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurContract <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('SHOP_ID').asString := CurContract.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          Params.ParamByName('STOCK_TYPE').asString := '1';
          if (CurContract.gid = '') or (CurContract.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurContract.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktBudgOrderGetPrior',Params);
             if Temp.Fields[0].asString<>'' then
                CurContract.Open(Temp.Fields[0].asString);
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

procedure TfrmMktBudgOrderList.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurContract <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('SHOP_ID').asString := CurContract.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          if CurContract.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurContract.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktBudgOrderGetNext',Params);
             if Temp.Fields[0].asString<>'' then
                CurContract.Open(Temp.Fields[0].asString);
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

procedure TfrmMktBudgOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil);
end;

function TfrmMktBudgOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.BUDG_DATE>=:D1 and A.BUDG_DATE<=:D2 ';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if fndDEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
     
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w := w +' and A.CHK_DATE is null';
       2:w := w +' and A.CHK_DATE is not null';
       end;
     end;
  if Trim(fndGLIDE_NO.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndGLIDE_NO.Text)+'''';

  if id<>'' then
     w := w +' and A.BUDG_ID>'''+id+'''';
  result :=
     'select A.TENANT_ID,A.GLIDE_NO,A.BUDG_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.SHOP_ID,D.SHOP_NAME as SHOP_ID_TEXT,F.USER_NAME as BUDG_USER_TEXT,'+
     'C.DEPT_NAME as DEPT_ID_TEXT,A.BUDG_DATE,E.USER_NAME as CREA_USER_TEXT,A.CREA_DATE,A.BUDG_VRF,A.REMARK '+
     ' from MKT_BUDGORDER A left join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
     ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
     ' left join CA_SHOP_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID '+
     ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CREA_USER=E.USER_ID '+
     ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.BUDG_USER=F.USER_ID '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by BUDG_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by BUDG_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by BUDG_ID) tp fetch first 600 rows only';
  5:result := 'select * from ('+result+') j order by BUDG_ID limit 600';
  else
    result := 'select * from ('+result+') j order by BUDG_ID';
  end;
end;

function TfrmMktBudgOrderList.GetFormClass: TFormClass;
begin
  Result := TfrmMktBudgOrder;
end;

procedure TfrmMktBudgOrderList.Open(Id: string);
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
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));;
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    //if rs.Params.FindParam('PLAN_USER')<>nil then rs.Params.FindParam('PLAN_USER').AsString := fndPLAN_USER.AsString;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('BUDG_ID').AsString;
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

function TfrmMktBudgOrderList.PrintSQL(tenantid, id: string): string;
begin
  Result :=
  'select A.GLIDE_NO,G.CLIENT_NAME as CLIENT_ID_TEXT,C.SHOP_NAME as SHOP_ID_TEXT,DEPT_NAME as DEPT_ID_TEXT,A.BUDG_DATE,'+
  'E.USER_NAME as BUDG_USER_TEXT,A.CHK_DATE,F.USER_NAME as CHK_USER_TEXT,A.BUDG_VRF,A.REMARK,H.GLIDE_NO as REQU_ID_TEXT,K.USER_NAME as CREA_USER_TEXT,'+
  'A.CREA_DATE,B.SEQNO,I.ACTIVE_NAME as ACTIVE_ID_TEXT,J.KPI_NAME as KPI_ID_TEXT,B.BUDG_VRF as DETAIL_BUDG_VRF,B.REMARK as DETAIL_REMARK '+
  ' from MKT_BUDGORDER A inner join MKT_BUDGDATA B on A.TENANT_ID=B.TENANT_ID and A.BUDG_ID=B.BUDG_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join CA_DEPT_INFO D on A.TENANT_ID=D.TENANT_ID and A.DEPT_ID=D.DEPT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.BUDG_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CHK_USER=F.USER_ID '+
  ' left join VIW_USERS K on A.TENANT_ID=K.TENANT_ID and A.CREA_USER=K.USER_ID '+
  ' left join VIW_CUSTOMER G on A.TENANT_ID=G.TENANT_ID and A.CLIENT_ID=G.CLIENT_ID '+
  ' left join MKT_REQUORDER H on A.TENANT_ID=H.TENANT_ID and A.REQU_ID=H.REQU_ID '+
  ' left join MKT_ACTIVE_INFO I on B.TENANT_ID=I.TENANT_ID and B.ACTIVE_ID=I.ACTIVE_ID '+
  ' left join MKT_KPI_INDEX J on B.TENANT_ID=J.TENANT_ID and B.KPI_ID=J.KPI_ID '+
  ' where A.TENANT_ID='+tenantid+' and A.BUDG_ID='''+id+''' order by B.SEQNO ';
end;

function TfrmMktBudgOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('100002297',7);
end;

procedure TfrmMktBudgOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  D1.Date := date();
  D2.Date := date();
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;
end;

procedure TfrmMktBudgOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  //进入窗体默认新增加判断是否新增权限:
  //if (ShopGlobal.GetChkRight('100002297',2)) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then
  actNew.OnExecute(nil);
end;

procedure TfrmMktBudgOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmMktBudgOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmMktBudgOrderList.frfMktBudgOrderGetValue(
  const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  if ParName='打印人' then ParValue := ShopGlobal.UserName;
end;

procedure TfrmMktBudgOrderList.frfMktBudgOrderUserFunction(
  const Name: String; p1, p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

end.
