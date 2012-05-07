unit ufrmMktPlanOrderList3;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractToolForm, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, Menus, ActnList, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, Grids, DBGridEh, RzTabs, RzPanel, RzButton,
  cxTextEdit, cxButtonEdit, zrComboBoxList, cxControls, cxContainer, DateUtils,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, FR_Class, cxSpinEdit,
  cxRadioGroup;

type
  TfrmMktPlanOrderList3 = class(TframeContractToolForm)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    Label3: TLabel;
    fndCLIENT_ID: TzrComboBoxList;
    fndDEPT_ID: TzrComboBoxList;
    btnOk: TRzBitBtn;
    fndPLAN_USER: TzrComboBoxList;
    Label2: TLabel;
    frfMktPlanOrderList3: TfrReport;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    K1: TcxSpinEdit;
    K2: TcxSpinEdit;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    fndSTATUS: TcxRadioGroup;
    CdsHeader: TZQuery;
    CdsDetail: TZQuery;
    RzLabel1: TRzLabel;
    fndFILES_NO: TcxTextEdit;
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
    procedure frfMktPlanOrderList3GetValue(const ParName: String;
      var ParValue: Variant);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure K1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure K2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure frfMktPlanOrderList3UserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
  private
    { Private declarations }
    IsAddItem:Boolean;
    function  CheckCanExport: boolean; override;
    procedure AddMenuItem;
    procedure DeleteMenuItem;
    procedure SingleContractExtensionClick(Sender:TObject);
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
uses uDsUtil, uFnUtil,uGlobal,uShopUtil,uXDictFactory,ufrmFastReport, ufrmMktPlanOrder3,
     ufrmMain, uShopGlobal, Math;
{$R *.dfm}

procedure TfrmMktPlanOrderList3.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002400',2) then Raise Exception.Create('你没有新增采购合同的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmMktPlanOrderList3.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002400',4) then Raise Exception.Create('你没有删除采购合同的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PLAN_ID').AsString,cdsList.FieldbyName('CLIENT_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"采购合同"打开异常!');

  if TfrmMktPlanOrder3(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002400',5) then
         Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktPlanOrder3(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入合同的权限!');
    end;
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       if ShopGlobal.GetChkRight('100002400',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增采购合同？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktPlanOrderList3.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002400',3) then Raise Exception.Create('你没有修改采购合同的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PLAN_ID').AsString,cdsList.FieldbyName('CLIENT_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"采购合同"打开异常!');

  if TfrmMktPlanOrder3(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002400',5) then
         Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktPlanOrder3(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入单据的权限!');
    end;
  inherited;

end;

procedure TfrmMktPlanOrderList3.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;       

       if ShopGlobal.GetChkRight('100002400',2) and (MessageBox(Handle,'是否继续新增采购合同？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmMktPlanOrderList3.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002400',6) then Raise Exception.Create('你没有打印采购合同的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktPlanOrderList3);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('PLAN_ID').AsString),frfMktPlanOrderList3);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktPlanOrderList3.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002400',6) then Raise Exception.Create('你没有打印采购合同的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfMktPlanOrderList3,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('PLAN_ID').AsString),frfMktPlanOrderList3,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktPlanOrderList3.Open(Id: string);
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
    rs.Params.ParamByName('K1').AsInteger := K1.Value;
    rs.Params.ParamByName('K2').AsInteger := K2.Value;
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString; 
    if rs.Params.FindParam('PLAN_USER')<>nil then rs.Params.FindParam('PLAN_USER').AsString := fndPLAN_USER.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    //if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('PLAN_ID').AsString;
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

procedure TfrmMktPlanOrderList3.actFindExecute(Sender: TObject);
begin
  inherited;
  if fndSTATUS.ItemIndex = 3 then
     AddMenuItem
  else
     DeleteMenuItem;
  Open('');
end;

procedure TfrmMktPlanOrderList3.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PLAN_ID').AsString,cdsList.FieldbyName('CLIENT_ID').AsString);
     end;
end;

procedure TfrmMktPlanOrderList3.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002400',5) then Raise Exception.Create('你没有审核采购合同的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PLAN_ID').AsString,cdsList.FieldbyName('CLIENT_ID').AsString);
     end;
  inherited;

end;

procedure TfrmMktPlanOrderList3.actPriorExecute(Sender: TObject);
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
          Params.ParamByName('CLIENT_ID').asString := CurContract.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          Params.ParamByName('PLAN_TYPE').AsString := '3';
          if (CurContract.gid = '') or (CurContract.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurContract.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktPlanOrderGetPrior3',Params);
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

procedure TfrmMktPlanOrderList3.actNextExecute(Sender: TObject);
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
          Params.ParamByName('CLIENT_ID').asString := CurContract.cid;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          Params.ParamByName('PLAN_TYPE').AsString := '3';
          if (CurContract.gid = '') then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurContract.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktPlanOrderGetNext3',Params);
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

procedure TfrmMktPlanOrderList3.frfMktPlanOrderList3GetValue(
  const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  if ParName='打印人' then ParValue := ShopGlobal.UserName;
end;

function TfrmMktPlanOrderList3.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and PLAN_TYPE=''3'' and A.KPI_YEAR>=:K1 and A.KPI_YEAR<=:K2 ';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  //[2012.02.03 xhh修改:可以按树上下级查询]
  if fndDEPT_ID.AsString <> '' then
     w := w +ShopGlobal.GetDeptID('A.DEPT_ID',fndDEPT_ID.AsString);
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndPLAN_USER.AsString <> '' then
     w := w + ' and A.PLAN_USER=:PLAN_USER';
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
       1:w := w +' and A.CHK_DATE is null';
       2:w := w +' and A.CHK_DATE is not null';
       3:w := w +' and not Exists (select * from MKT_PLANORDER G where A.TENANT_ID=G.TENANT_ID and A.CLIENT_ID=G.CLIENT_ID and G.PLAN_TYPE=''3'' and G.KPI_YEAR=A.KPI_YEAR+1) and A.END_DATE<'''+FormatDateTime('YYYY-MM-DD',Date)+'''';
       4:w := w +' and Exists (select * from MKT_PLANORDER G where A.TENANT_ID=G.TENANT_ID and A.CLIENT_ID=G.CLIENT_ID and G.PLAN_TYPE=''3'' and G.KPI_YEAR=A.KPI_YEAR+1) ';
       end;
     end;
  if Trim(fndFILES_NO.Text) <> '' then
     w := w +' and A.FILES_NO like ''%'+trim(fndFILES_NO.Text)+'''';

  if id<>'' then
     w := w +' and A.PLAN_ID>'''+id+'''';
  result :=
     'select A.TENANT_ID,A.PLAN_ID,A.GLIDE_NO,A.FILES_NO,A.KPI_YEAR,A.PLAN_DATE,A.BEGIN_DATE,A.END_DATE,A.CLIENT_ID,'+
     'B.CLIENT_NAME as CLIENT_ID_TEXT,A.DEPT_ID,F.DEPT_NAME as DEPT_ID_TEXT,A.PLAN_USER,D.USER_NAME as PLAN_USER_TEXT,'+
     'A.CHK_DATE,A.CHK_USER,C.USER_NAME as CHK_USER_TEXT,A.PLAN_AMT,A.PLAN_MNY,A.BOND_MNY,'+
     'A.BUDG_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,E.USER_NAME as CREA_USER_TEXT '+
     ' from MKT_PLANORDER A left join VIW_CLIENTINFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
     ' left join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.CHK_USER=C.USER_ID '+
     ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.PLAN_USER=D.USER_ID '+
     ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CREA_USER=E.USER_ID '+
     ' left join CA_DEPT_INFO F on A.TENANT_ID=F.TENANT_ID and A.DEPT_ID=F.DEPT_ID '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by PLAN_ID ';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by PLAN_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by PLAN_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by PLAN_ID limit 600';
  else
    result := 'select * from ('+result+') j order by PLAN_ID ';
  end;
end;

function TfrmMktPlanOrderList3.GetFormClass: TFormClass;
begin
  Result := TfrmMktPlanOrder3;
end;

function TfrmMktPlanOrderList3.PrintSQL(tenantid, id: string): string;
begin
  Result := 'select A.GLIDE_NO,A.FILES_NO,A.KPI_YEAR,A.PLAN_DATE,C.SHOP_NAME as SHOP_ID_TEXT,'+
  'H.CLIENT_NAME as CLIENT_ID_TEXT,D.DEPT_NAME as DEPT_ID_TEXT,I.CODE_NAME as PLAN_TYPE_TEXT,'+
  'E.USER_NAME as PLAN_USER_TEXT,A.CHK_DATE,F.USER_NAME as CHK_USER_TEXT,A.PLAN_AMT,A.PLAN_MNY,'+
  'A.BOND_MNY,A.BOND_RET,A.BUDG_MNY,A.REMARK,A.CREA_DATE,G.USER_NAME as CREA_USER_TEXT,'+
  'B.SEQNO,J.KPI_NAME as KPI_ID_TEXT,J.UNIT_NAME,B.AMOUNT,B.AMONEY,B.BOND_MNY,B.BUDG_MNY,B.REMARK as REMARK_DETAIL '+
  ' from MKT_PLANORDER A inner join MKT_PLANDATA B on A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join CA_DEPT_INFO D on A.TENANT_ID=D.TENANT_ID and A.DEPT_ID=D.DEPT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.PLAN_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CHK_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CREA_USER=G.USER_ID '+
  ' left join VIW_CUSTOMER H on A.TENANT_ID=H.TENANT_ID and A.CLIENT_ID=H.CLIENT_ID '+
  ' left join PUB_PARAMS I on A.PLAN_TYPE=I.CODE_ID '+
  ' left join MKT_KPI_INDEX J on B.TENANT_ID=J.TENANT_ID and B.KPI_ID=J.KPI_ID '+
  ' where I.TYPE_CODE=''PLAN_TYPE'' and A.TENANT_ID='+tenantid+' and A.PLAN_ID='''+id+''' order by B.SEQNO ';
  
end;

function TfrmMktPlanOrderList3.CheckCanExport: boolean;
begin
  //result:=ShopGlobal.GetChkRight('100002150',7);
end;

procedure TfrmMktPlanOrderList3.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil)
end;

procedure TfrmMktPlanOrderList3.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmMktPlanOrderList3.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  //进入窗体默认新增加判断是否新增权限: (ShopGlobal.GetChkRight('100002150',2)) and
  if  (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmMktPlanOrderList3.FormCreate(Sender: TObject);
begin
  inherited;
  IsAddItem := False;
  InitGridPickList(DBGridEh1);
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndDEPT_ID.RangeField := 'DEPT_TYPE';
  fndDEPT_ID.RangeValue := '1';
  fndPLAN_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  K1.Value := StrtoInt(formatDatetime('YYYY',date()));
  K2.Value := StrtoInt(formatDatetime('YYYY',date()));
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;

end;

procedure TfrmMktPlanOrderList3.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmMktPlanOrderList3.K1PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if (K1.Value < 2000) or (K1.Value > 2111) then
     Raise Exception.Create('输入年度范围"2000-2111"');
end;

procedure TfrmMktPlanOrderList3.K2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if (K2.Value < 2000) or (K2.Value > 2111) then
     Raise Exception.Create('输入年度范围"2000-2111"');
end;

procedure TfrmMktPlanOrderList3.AddMenuItem;
var P:TPopupMenu;
begin
  P := DBGridEh1.PopupMenu;
  if (P <> nil) and (not IsAddItem) then
  begin
    IsAddItem := True;
    P.Items.Insert(0,NewItem('单笔续签',0,False,True,SingleContractExtensionClick,0,'ContractExtension'));
    //P.Items.Insert(1,NewItem('批量续约',0,False,True,ContractExtensionClick,0,'ContractExtension'));
    P.Items.Insert(1,NewLine);
  end;
end;

procedure TfrmMktPlanOrderList3.DeleteMenuItem;
var P:TPopupMenu;
begin
  P := DBGridEh1.PopupMenu;
  if (P <> nil) and IsAddItem then
  begin
    IsAddItem := False;
    //P.Items.Delete(2);
    P.Items.Delete(1);
    P.Items.Delete(0);
  end;
end;

procedure TfrmMktPlanOrderList3.SingleContractExtensionClick(
  Sender: TObject);
begin
  if not cdsList.Active then Exit;
  if cdsList.IsEmpty then Exit;
  actNewExecute(Sender);
  TfrmMktPlanOrder3(CurContract).SingleContractExtensionFrom(cdsList.FieldByName('PLAN_ID').AsString);
end;

procedure TfrmMktPlanOrderList3.frfMktPlanOrderList3UserFunction(
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
