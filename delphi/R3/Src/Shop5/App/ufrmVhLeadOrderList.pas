unit ufrmVhLeadOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractToolForm, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, Menus, ActnList, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, Grids, DBGridEh, RzTabs, RzPanel,
  cxDropDownEdit, RzButton, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, FR_Class;

type
  TfrmVhLeadOrderList = class(TframeContractToolForm)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label3: TLabel;
    Label40: TLabel;
    Label9: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    fndDEPT_ID: TzrComboBoxList;
    btnOk: TRzBitBtn;
    fndSHOP_ID: TzrComboBoxList;
    fndLEAD_USER: TzrComboBoxList;
    frfVhLeadOrder: TfrReport;
    ToolButton15: TToolButton;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
   uMsgBox,ufrmVhLeadOrder, uframeMDForm, uframeContractForm;
{$R *.dfm}

procedure TfrmVhLeadOrderList.actNewExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('12400001',2) then Raise Exception.Create('你没有领用礼券的权限,请和管理员联系.');
  inherited;
end;

procedure TfrmVhLeadOrderList.actDeleteExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',4) then Raise Exception.Create('你没有删除领用礼券单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('VHLEAD_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"领用礼券单档案"打开异常!');

  if (TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString<>'')
  and (TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID) then
    begin
      if not ShopGlobal.GetChkRight('100002297',5) then
        Raise Exception.Create('你没有删除"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入领用礼券单的权限!');
    end;
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       if ShopGlobal.GetChkRight('100002297',2) and (MessageBox(Handle,'删除当前领用礼券单成功,是否继续新增领用礼券单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmVhLeadOrderList.actEditExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100002297',3) then Raise Exception.Create('你没有修改领用礼券单的权限,请和管理员联系.');
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('VHLEAD_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurContract=nil then Raise Exception.Create('"领用礼券单"打开异常!');

  if (TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString<>'')
  and (TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID) then
    begin
      if not ShopGlobal.GetChkRight('100002297',5) then
        Raise Exception.Create('你没有修改"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmVhLeadOrder(CurContract).cdsHeader.FieldByName('CREA_USER').AsString)+'"录入领用礼券单的权限!');
    end;
  inherited;
end;

procedure TfrmVhLeadOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurContract<>nil) then
     begin
       if not CurContract.saved then Exit;
       {if ShopGlobal.GetChkRight('100002297',6) then
          begin       ShopGlobal.GetChkRight('100002297',2) and
            actPrint.OnExecute(nil);
          end;}
       if  (MessageBox(Handle,'是否继续新增领用礼券单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurContract.NewOrder
       else
          if rzPage.PageCount>2 then CurContract.Close;
     end;
end;

procedure TfrmVhLeadOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  Exit;
  //if not ShopGlobal.GetChkRight('100002297',6) then Raise Exception.Create('你没有打印领用礼券单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfVhLeadOrder);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('VHLEAD_ID').AsString),frfVhLeadOrder);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmVhLeadOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  Exit;
  //if not ShopGlobal.GetChkRight('100002297',6) then Raise Exception.Create('你没有打印领用礼券单的权限,请和管理员联系.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurContract<>nil then
           begin
             if CurContract.oid = '' then Exit;
             if CurContract.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurContract.oid),frfVhLeadOrder,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('VHLEAD_ID').AsString),frfVhLeadOrder,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmVhLeadOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmVhLeadOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurContract=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('VHLEAD_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmVhLeadOrderList.actPriorExecute(Sender: TObject);
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
          if (CurContract.oid = '') or (CurContract.gid='..新增..') then
             Params.ParamByName('VHLEAD_ID').asString := '9999999999999999'
          else
             Params.ParamByName('VHLEAD_ID').asString := CurContract.oid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TVhLeadOrderGetPrior',Params);
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

procedure TfrmVhLeadOrderList.actNextExecute(Sender: TObject);
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
          if CurContract.oid = '' then
             Params.ParamByName('VHLEAD_ID').asString := '00000000000000'
          else
             Params.ParamByName('VHLEAD_ID').asString := CurContract.oid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TVhLeadOrderGetNext',Params);
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

procedure TfrmVhLeadOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not cdsList.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmVhLeadOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil);
end;

procedure TfrmVhLeadOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //fndDEPT_ID.RangeField := 'DEPT_TYPE';
  //fndDEPT_ID.RangeValue := '1';
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndLEAD_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  D1.Date := date();
  D2.Date := date();
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '领用仓库';
    end;
end;

function TfrmVhLeadOrderList.CheckCanExport: boolean;
begin
  //result:=ShopGlobal.GetChkRight('100002297',7);
end;

function TfrmVhLeadOrderList.EncodeSQL(id: string): string;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.LEAD_DATE>=:D1 and A.LEAD_DATE<=:D2 ';

  if fndDEPT_ID.AsString <> '' then
     w := w +' and A.DEPT_ID=:DEPT_ID ';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID ';
  if fndLEAD_USER.AsString <> '' then
     w := w + ' and A.LEAD_USER=:LEAD_USER ';

  if id<>'' then
     w := w +' and A.VHLEAD_ID>'''+id+'''';
  result :=
     'select A.TENANT_ID,A.VHLEAD_ID,A.LEAD_DATE,A.SHOP_ID,C.SHOP_NAME as SHOP_ID_TEXT,E.USER_NAME as LEAD_USER_TEXT,'+
     'B.DEPT_NAME as DEPT_ID_TEXT,D.USER_NAME as CREA_USER_TEXT,A.CREA_DATE,A.REMARK '+
     ' from SAL_VHLEADORDER A left join CA_DEPT_INFO B on A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID '+
     ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
     ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
     ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.LEAD_USER=E.USER_ID '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by VHLEAD_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by VHLEAD_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by VHLEAD_ID) tp fetch first 600 rows only';
  5:result := 'select * from ('+result+') j order by VHLEAD_ID limit 600';
  else
    result := 'select * from ('+result+') j order by VHLEAD_ID';
  end;
end;

function TfrmVhLeadOrderList.GetFormClass: TFormClass;
begin
  Result := TfrmVhLeadOrder;
end;

procedure TfrmVhLeadOrderList.Open(Id: string);
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
    if rs.Params.FindParam('LEAD_USER')<>nil then rs.Params.FindParam('LEAD_USER').AsString := fndLEAD_USER.AsString;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('VHLEAD_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsList.LoadFromStream(sm);  
       cdsList.IndexFieldNames := 'VHLEAD_ID';
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

function TfrmVhLeadOrderList.PrintSQL(tenantid, id: string): string;
begin

end;

procedure TfrmVhLeadOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  //进入窗体默认新增加判断是否新增权限:
  //if (ShopGlobal.GetChkRight('100002297',2)) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then
  actNew.OnExecute(nil);
end;

procedure TfrmVhLeadOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
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

end.
