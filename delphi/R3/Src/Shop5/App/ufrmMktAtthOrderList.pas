unit ufrmMktAtthOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Menus, ActnList, ComCtrls, ToolWin, StdCtrls, RzLabel, jpeg,
  ExtCtrls, Grids, DBGridEh, RzTabs, RzPanel, FR_Class, cxRadioGroup,
  RzButton, cxTextEdit, cxButtonEdit, zrComboBoxList, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmMktAtthOrderList = class(TframeOrderToolForm)
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
    frfMktAtthOrderList: TfrReport;
    ToolButton11: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure frfMktAtthOrderListGetValue(const ParName: String;
      var ParValue: Variant);
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
uses uDevFactory,ufrmFastReport,uGlobal,uFnUtil,uShopUtil,uXDictFactory,
  uShopGlobal,uDsUtil, uMsgBox, uframeMDForm, ObjCommon, ufrmMktAtthOrder;
{$R *.dfm}

{ TfrmMktAtthOrderList }

function TfrmMktAtthOrderList.CheckCanExport: boolean;
begin
  result := ShopGlobal.GetChkRight('100002176',7);
end;

function TfrmMktAtthOrderList.EncodeSQL(id: string): string;
var w,w1,JoinStr:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.REQU_DATE>=:D1 and A.REQU_DATE<=:D2';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  //[2012.02.03 xhh�޸�:���԰������¼���ѯ]
  if fndDEPT_ID.AsString <> '' then
     w := w +ShopGlobal.GetDeptID('A.DEPT_ID',fndDEPT_ID.AsString);
  if trim(fndGLIDE_NO.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndGLIDE_NO.Text)+'''';
  if fndSTATUS.ItemIndex > 0 then
     begin
       case fndSTATUS.ItemIndex of
        1:w := w +' and A.CHK_DATE is null';
        2:w := w +' and A.CHK_DATE is not null';
        3:w := w +' and SAL.ATTH_ID is null';
        4:w := w +' and SAL.ATTH_ID is not null';
       end;
     end;

  if id<>'' then
     w := w +' and A.REQU_ID>'''+id+'''';

  JoinStr:='''REQ'''+GetStrJoin(Factor.iDbType);

  result := 'select A.TENANT_ID,A.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,A.ATTH_ID,A.DEPT_ID,C.DEPT_NAME as DEPT_ID_TEXT,'+
  'A.REQU_TYPE,A.GLIDE_NO,A.REQU_DATE,A.CLIENT_ID,D.CLIENT_NAME as CLIENT_ID_TEXT,A.REQU_USER,E.USER_NAME as REQU_USER_TEXT,'+
  'A.CHK_DATE,A.CHK_USER,G.USER_NAME as CHK_USER_TEXT,A.KPI_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,F.USER_NAME as CREA_USER_TEXT,'+
  ' (case when SAL.ATTH_ID is null then ''δ����''  else ''�Ѻ���'' end) as HEXIAO  '+
  ' from MKT_ATTHORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.REQU_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CREA_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CHK_USER=G.USER_ID '+
  ' left join (select distinct TENANT_ID,ATTH_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and ATTH_ID is not null) SAL on A.TENANT_ID=SAL.TENANT_ID and '+JoinStr+'A.ATTH_ID=SAL.ATTH_ID '+
  w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by ATTH_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by ATTH_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by ATTH_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by ATTH_ID limit 600';
  else
    result := 'select * from ('+result+') j order by ATTH_ID';
  end;
end;

function TfrmMktAtthOrderList.GetFormClass: TFormClass;
begin
  Result := TfrmMktAtthOrder;
end;

procedure TfrmMktAtthOrderList.Open(Id: string);
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
    MaxId := rs.FieldbyName('ATTH_ID').AsString;
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

function TfrmMktAtthOrderList.PrintSQL(tenantid, id: string): string;
begin
  Result := 'select C.*,D.USER_NAME as CHK_USER_TEXT,E.USER_NAME as CREA_USER_TEXT,F.USER_NAME as REQU_USER_TEXT,'+
            'G.DEPT_NAME as DEPT_ID_TEXT,H.CLIENT_NAME as CLIENT_ID_TEXT,I.GODS_NAME,L.UNIT_NAME,'+
            'J.SHOP_NAME as SHOP_ID_TEXT,K.CODE_NAME as REQU_TYPE_TEXT from ( '+
            'Select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.REQU_TYPE,A.GLIDE_NO,A.REQU_USER,A.CLIENT_ID,A.CHK_USER,A.REQU_DATE,B.AMOUNT,'+
            'A.REMARK,A.CREA_USER,B.SEQNO,B.ATTH_ID,B.GODS_ID,B.UNIT_ID,isnull(B.KPI_MNY,0) as KPI_MNY,isnull(B.BUDG_MNY,0) as BUDG_MNY,'+
            'isnull(B.AGIO_MNY,0) as AGIO_MNY,isnull(B.OTHR_MNY,0) as OTHR_MNY,'+
            '(isnull(B.KPI_MNY,0)+isnull(B.BUDG_MNY,0)+isnull(B.AGIO_MNY,0)+isnull(B.OTHR_MNY,0)) as REQU_MNY,B.REMARK as REMARK_DETAIL '+
            ' From MKT_ATTHDATA B,MKT_ATTHORDER A where A.TENANT_ID = B.TENANT_ID and A.ATTH_ID=B.ATTH_ID '+
            ' and A.TENANT_ID = '+tenantid+' and A.ATTH_ID='+QuotedStr(id)+
            ' ) C  left join VIW_USERS D on D.TENANT_ID=C.TENANT_ID and D.USER_ID = C.CHK_USER '+
            ' left join VIW_USERS E on E.TENANT_ID=C.TENANT_ID and E.USER_ID = C.CREA_USER '+
            ' left join VIW_USERS F on F.TENANT_ID=C.TENANT_ID and F.USER_ID = C.REQU_USER '+
            ' left join CA_DEPT_INFO G on G.TENANT_ID=C.TENANT_ID and G.DEPT_ID=C.DEPT_ID '+
            ' left join VIW_CUSTOMER H on H.TENANT_ID=C.TENANT_ID and H.CLIENT_ID=C.CLIENT_ID '+
            ' left join VIW_GOODSINFO I on I.TENANT_ID=C.TENANT_ID and I.GODS_ID=C.GODS_ID '+
            ' left join CA_SHOP_INFO J on J.TENANT_ID=C.TENANT_ID and J.SHOP_ID=C.SHOP_ID '+
            ' left join PUB_PARAMS K on K.CODE_ID=C.REQU_TYPE '+
            ' left join VIW_MEAUNITS L on L.TENANT_ID=C.TENANT_ID and L.UNIT_ID=C.UNIT_ID '+
            ' where K.TYPE_CODE=''REQU_TYPE'' order by C.SEQNO';
  Result := ParseSQL(Factor.iDbType,Result);
end;

procedure TfrmMktAtthOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  if (ShopGlobal.GetChkRight('100002176',2)) and (rzPage.ActivePageIndex = 0) and (rzPage.PageCount=1) then actNew.OnExecute(nil);
end;

procedure TfrmMktAtthOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
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
      Label40.Caption := '�ֿ�����';
      DBGridEh1.Columns[2].Title.Caption := '�ֿ�����';
    end;
end;

procedure TfrmMktAtthOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',2) then Raise Exception.Create('��û���������۸�������Ȩ��,��͹���Ա��ϵ.');
  inherited;
end;

procedure TfrmMktAtthOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',4) then Raise Exception.Create('��û��ɾ�����۸�������Ȩ��,��͹���Ա��ϵ.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('ATTH_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder=nil then Raise Exception.Create('"���۸�����"���쳣!');

  if TfrmMktAtthOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002176',5) then
         Raise Exception.Create('��û��ɾ��"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktAtthOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"¼�뵥�ݵ�Ȩ��!');
    end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('100002176',2) and (MessageBox(Handle,'ɾ����ǰ���ݳɹ�,�Ƿ�����������۸�������',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmMktAtthOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',3) then Raise Exception.Create('��û���޸����۸�������Ȩ��,��͹���Ա��ϵ.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('ATTH_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder=nil then Raise Exception.Create('"���۸�����"���쳣!');

  if TfrmMktAtthOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString <> Global.UserID then
    begin
      if not ShopGlobal.GetChkRight('100002176',5) then
         Raise Exception.Create('��û���޸�"'+TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',TfrmMktAtthOrder(CurOrder).cdsHeader.FieldByName('CREA_USER').AsString)+'"¼�뵥�ݵ�Ȩ��!');
    end;
  inherited;
end;

procedure TfrmMktAtthOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       {if ShopGlobal.GetChkRight('100002176',6) then
          begin
            actPrint.OnExecute(nil);
          end;}
       if ShopGlobal.GetChkRight('100002176',2) and (MessageBox(Handle,'�Ƿ�����������۸�������',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmMktAtthOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002176',6) then Raise Exception.Create('��û�д�ӡ���۸�������Ȩ��,��͹���Ա��ϵ.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('�뱣����ٴ�ӡ...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfMktAtthOrderList);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('ATTH_ID').AsString),frfMktAtthOrderList);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktAtthOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002176',6) then Raise Exception.Create('��û�д�ӡ���۸�������Ȩ��,��͹���Ա��ϵ.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('�뱣����ٴ�ӡ...');
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),frfMktAtthOrderList,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             //BeforePrint := PrintBefore;
             //AfterPrint := PrintAfter;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('ATTH_ID').AsString),frfMktAtthOrderList,nil,true);
           end;
      finally
         free;
      end;
    end;
end;

procedure TfrmMktAtthOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmMktAtthOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('ATTH_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
end;

procedure TfrmMktAtthOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('100002176',5) then Raise Exception.Create('��û��������۸�������Ȩ��,��͹���Ա��ϵ.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('ATTH_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  inherited;
end;

procedure TfrmMktAtthOrderList.actPriorExecute(Sender: TObject);
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
          if (CurOrder.gid = '') or (CurOrder.gid='..����..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktAtthOrderGetPrior',Params);
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

procedure TfrmMktAtthOrderList.actNextExecute(Sender: TObject);
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
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TMktAtthOrderGetNext',Params);
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

procedure TfrmMktAtthOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil)

end;

procedure TfrmMktAtthOrderList.frfMktAtthOrderListGetValue(
  const ParName: String; var ParValue: Variant);
begin
  inherited;
  if ParName='��ҵ����' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='��ҵ���' then ParValue := ShopGlobal.SHORT_TENANT_NAME;
  if ParName='��ӡ��' then ParValue := ShopGlobal.UserName;
end;

end.
