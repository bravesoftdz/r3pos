unit ufrmMktRequOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractToolForm, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, Menus, ActnList, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, Grids, DBGridEh, RzTabs, RzPanel, RzButton,
  cxTextEdit, cxButtonEdit, zrComboBoxList, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, FR_Class;

type
  TfrmMktRequOrderList = class(TframeContractToolForm)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label1: TLabel;
    Label3: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    fndCLIENT_ID: TzrComboBoxList;
    fndGLIDE_NO: TcxTextEdit;
    fndDEPT_ID: TzrComboBoxList;
    btnOk: TRzBitBtn;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    frfMktRequOrderList: TfrReport;
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
    procedure frfMktRequOrderListGetValue(const ParName: String;
      var ParValue: Variant);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function  CheckCanExport: boolean; override;
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
uses ufrmMktRequOrder,uDevFactory,ufrmFastReport,uGlobal,uFnUtil,uShopUtil,uXDictFactory,
  uShopGlobal,uDsUtil, uMsgBox, uframeMDForm;
{$R *.dfm}

{ TfrmMktRequOrderList }

function TfrmMktRequOrderList.CheckCanExport: boolean;
begin
  result := ShopGlobal.GetChkRight('100002176',7);
end;

function TfrmMktRequOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.REQU_DATE>=:D1 and A.REQU_DATE<=:D2';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  //[2012.02.03 xhh修改:可以按树上下级查询]
  if fndDEPT_ID.AsString <> '' then
     w := w +ShopGlobal.GetDeptID('A.DEPT_ID',fndDEPT_ID.AsString);
  if trim(fndGLIDE_NO.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndGLIDE_NO.Text)+'''';

  if id<>'' then
     w := w +' and A.REQU_ID>'''+id+'''';
     
  result := 'select A.TENANT_ID,A.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,A.REQU_ID,A.DEPT_ID,C.DEPT_NAME as DEPT_ID_TEXT,'+
  'A.REQU_TYPE,A.GLIDE_NO,A.REQU_DATE,A.CLIENT_ID,D.CLIENT_NAME as CLIENT_ID_TEXT,A.REQU_USER,E.USER_NAME as REQU_USER_TEXT,'+
  'A.CHK_DATE,A.CHK_USER,G.USER_NAME as CHK_USER_TEXT,A.REQU_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,F.USER_NAME as CREA_USER_TEXT '+
  ' from MKT_REQUORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.REQU_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CREA_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CHK_USER=G.USER_ID '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by REQU_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by REQU_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by REQU_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by REQU_ID limit 600';
  else
    result := 'select * from ('+result+') j order by REQU_ID';
  end;
end;

function TfrmMktRequOrderList.GetFormClass: TFormClass;
begin
  Result := TfrmMktRequOrder;   
end;

procedure TfrmMktRequOrderList.Open(Id: string);
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
    //if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('REQU_ID').AsString;
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

function TfrmMktRequOrderList.PrintSQL(tenantid, id: string): string;
begin
  Result := 'select C.*,D.USER_NAME as CHK_USER_TEXT,E.USER_NAME as CREA_USER_TEXT,F.USER_NAME as REQU_USER_TEXT,'+
            'G.DEPT_NAME as DEPT_ID_TEXT,H.CLIENT_NAME as CLIENT_ID_TEXT,I.KPI_NAME as KPI_ID_TEXT,J.SHOP_NAME as SHOP_ID_TEXT,'+
            'K.CODE_NAME as REQU_TYPE_TEXT from ( '+
            'Select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.REQU_TYPE,A.GLIDE_NO,A.REQU_USER,A.CLIENT_ID,A.CHK_USER,A.REQU_DATE,'+
            'A.REMARK,A.CREA_USER,B.SEQNO,B.PLAN_ID,B.KPI_ID,B.KPI_YEAR,C.KPI_MNY,B.REQU_MNY,B.REMARK as REMARK_DETAIL '+
            ' From MKT_REQUDATA B,MKT_REQUORDER A,MKT_KPI_RESULT C  where A.TENANT_ID = B.TENANT_ID and A.REQU_ID=B.REQU_ID '+
            ' and B.TENANT_ID = C.TENANT_ID and B.PLAN_ID=C.PLAN_ID and A.TENANT_ID = '+tenantid+' and A.REQU_ID = '''+id+''' ) C '+
            ' left join VIW_USERS D on D.TENANT_ID=C.TENANT_ID and D.USER_ID = C.CHK_USER '+
            ' left join VIW_USERS E on E.TENANT_ID=C.TENANT_ID and E.USER_ID = C.CREA_USER '+
            ' left join VIW_USERS F on F.TENANT_ID=C.TENANT_ID and F.USER_ID = C.REQU_USER '+
            ' left join CA_DEPT_INFO G on G.TENANT_ID=C.TENANT_ID and G.DEPT_ID=C.DEPT_ID '+
            ' left join VIW_CUSTOMER H on H.TENANT_ID=C.TENANT_ID and H.CLIENT_ID=C.CLIENT_ID '+
            ' left join MKT_KPI_INDEX I on I.TENANT_ID=C.TENANT_ID and I.KPI_ID=C.KPI_ID '+
            ' left join CA_SHOP_INFO J on J.TENANT_ID=C.TENANT_ID and J.SHOP_ID=C.SHOP_ID '+
            ' left join PUB_PARAMS K on K.CODE_ID=C.REQU_TYPE where K.TYPE_CODE=''REQU_TYPE'' order by C.SEQNO  ';
end;

procedure TfrmMktRequOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',2) then Raise Exception.Create('你没有新增费用申领的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmMktRequOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',4) then Raise Exception.Create('你没有删除费用申领单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('REQU_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"费用申领"打开异常!');

  if TfrmMktRequOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002176',5) then
         Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktRequOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       if ShopGlobal.GetChkRight('100002176',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktRequOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',3) then Raise Exception.Create('你没有修改费用申领单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('REQU_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"费用申领"打开异常!');

  if TfrmMktRequOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002176',5) then
         Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktRequOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;

end;

procedure TfrmMktRequOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       {if ShopGlobal.GetChkRight('100002176',6) then
          begin
            actPrint.OnExecute(nil);
          end;}
       if ShopGlobal.GetChkRight('100002176',2) and (MessageBox(Handle,'是否继续新增费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktRequOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002176',6) then Raise Exception.Create('你没有打印费用申领单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktRequOrderList);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('REQU_ID').AsString),frfMktRequOrderList);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktRequOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002176',6) then Raise Exception.Create('你没有打印费用申领单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktRequOrderList,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('REQU_ID').AsString),frfMktRequOrderList,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktRequOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmMktRequOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('REQU_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmMktRequOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',5) then Raise Exception.Create('你没有审核费用申领单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('REQU_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;

end;

procedure TfrmMktRequOrderList.actPriorExecute(Sender: TObject);
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
          if (CurContract.gid = '') or (CurContract.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurContract.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktRequOrderGetPrior',Params);
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

procedure TfrmMktRequOrderList.actNextExecute(Sender: TObject);
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
             Factor.Open(Temp,'TMktRequOrderGetNext',Params);
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

procedure TfrmMktRequOrderList.frfMktRequOrderListGetValue(
  const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  if ParName='打印人' then ParValue := ShopGlobal.UserName;
end;

procedure TfrmMktRequOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil);
end;

procedure TfrmMktRequOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmMktRequOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO'); 
  InitGridPickList(DBGridEh1);
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
//  fndCLIENT_ID.RangeField := 'FLAG';
//  fndCLIENT_ID.RangeValue := '3';
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  
  D1.Date := date();
  D2.Date := date();

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
      DBGridEh1.Columns[2].Title.Caption := '仓库名称';
    end;
end;

procedure TfrmMktRequOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  if (ShopGlobal.GetChkRight('100002176',2)) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

end.
