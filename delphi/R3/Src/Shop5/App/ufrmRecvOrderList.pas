{  21300001	0	�տ	1	��ѯ	2	����	3	�޸�	4	ɾ��	5	���	6	��ӡ	7	����   }

unit ufrmRecvOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,zBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmRecvOrderList = class(TframeToolForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    DataSource2: TDataSource;
    frfRecvOrder: TfrReport;
    actfrmBatchReck: TAction;
    cdsList: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    RzPanel7: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    Label1: TLabel;
    Label40: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndOrderStatus: TcxRadioGroup;
    fndRECV_USER: TzrComboBoxList;
    fndACCOUNT_ID: TzrComboBoxList;
    fndCLIENT_ID: TzrComboBoxList;
    fndPAYM_ID: TcxComboBox;
    fndSHOP_ID: TzrComboBoxList;
    fndITEM_ID: TzrComboBoxList;
    fndP1_SHOP_ID: TzrComboBoxList; 
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label2: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    CdsRecvList: TZQuery;
    RecvListDs: TDataSource;
    fndP1_CUST_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzPageChange(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure frfRecvOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
    procedure actDeleteExecute(Sender: TObject);
    procedure frfRecvOrderGetValue(const ParName: String; var ParValue: Variant);
    procedure CdsRecvListAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure ChangeButton;
    function  CheckCanExport: boolean; override;
  public
    IsEnd1,IsEnd2: boolean;
    MaxId1,MaxId2:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);

    function FindColumn(FieldName:string):TColumnEh;
    function EncodeSQL1(id:string;var w:string):string;
    function EncodeSQL2(id:string;var w:string):string;
    procedure Open1(Id:string);
    procedure Open2(Id:string);
    function PrintSQL2(tenantid,id:string):string;
  end;

implementation
uses uGlobal, uFnUtil, ufrmEhLibReport, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmRecvOrder,
  ufrmBasic, ObjCommon;
{$R *.dfm}

procedure TfrmRecvOrderList.InitGrid;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  InitGridPickList(DBGridEh2);
  rs := Global.GetZQueryFromName('PUB_PAYMENT');
  Column := FindColumn('PAYM_ID');
  if Column<>nil then
     begin
       rs.First;
       while not rs.Eof do
         begin
           Column.KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
           Column.PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
           rs.Next;
         end;
     end;
end;

procedure TfrmRecvOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);

  D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
  fndRECV_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_PAYMENT'),fndPAYM_ID.Properties.Items,'CODE_NAME');
  fndPAYM_ID.Properties.Items.Insert(0,'ȫ��');
  fndPAYM_ID.ItemIndex := 0; 
  InitGrid;
  //��һ��ҳӦ���˿�:
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,fndSHOP_ID.Style);
    fndSHOP_ID.Properties.ReadOnly := True;

    SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    fndP1_SHOP_ID.Properties.ReadOnly := True;
  end;
  fndP1_CUST_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  RzPage.ActivePageIndex := 0;
  
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label3.Caption := '�ֿ�����';
      Label40.Caption := '�տ�ֿ�';
    end;
  ChangeButton;
end;

procedure TfrmRecvOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  case RzPage.ActivePageIndex of
   0: Open1('');
   1: Open2('');
  end;
end;

procedure TfrmRecvOrderList.actNewExecute(Sender: TObject);
var
  ABLE_ID: string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21300001',2) then Raise Exception.Create('��û�������տ��Ȩ��,��͹���Ա��ϵ.');
  ABLE_ID:='';
  if (RzPage.ActivePage=TabSheet1) and (CdsRecvList.Active) and (CdsRecvList.RecordCount>0) then
    ABLE_ID:=trim(CdsRecvList.fieldbyName('ABLE_ID').AsString);
  
  with TfrmRecvOrder.Create(self) do
    begin
      try
        Append;
        OnSave := AddRecord;

        //Ӧ�տ�ѡ���һ��ҳ [�տ��ѯ] ʱִ��
        if ABLE_ID<>'' then
        begin
          edtCLIENT_ID.KeyValue:=trim(CdsRecvList.fieldbyName('CLIENT_ID').AsString);
          edtCLIENT_ID.Text:=trim(CdsRecvList.fieldbyName('CUST_ID_TEXT').AsString);
          FillData;
          //��λ��ABLE_ID
          if cdsDetail.Locate('ABLE_ID',ABLE_ID,[]) then
          begin
            if cdsDetail.State<>dsEdit then cdsDetail.Edit;
            cdsDetail.FieldByName('A').AsString:='1';
            cdsDetail.FieldByName('RECV_MNY').AsFloat:=cdsDetail.FieldByName('BALA_MNY').AsFloat;
            cdsDetail.FieldByName('BALA_MNY').AsFloat:=0;
            cdsDetail.Post;
          end; 
        end;
        //Ӧ�տ�ѡ���һ��ҳ [�տ��ѯ] ʱִ��
        
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmRecvOrderList.actEditExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('21300001',3) then Raise Exception.Create('��û���޸��տ��Ȩ��,��͹���Ա��ϵ.');
  if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('�˵��Ѿ����,����ִ���޸Ĳ���.');  
  with TfrmRecvOrder.Create(self) do
    begin
      try
        Edit(cdsList.FieldByName('RECV_ID').AsString);
        OnSave := AddRecord;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmRecvOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
    with TfrmRecvOrder.Create(self) do
      begin
        try
          cid := cdsList.FieldbyName('SHOP_ID').AsString;
          Open(cdsList.FieldByName('RECV_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;
end;

procedure TfrmRecvOrderList.ChangeButton;
begin
  if cdsList.Active and (cdsList.FieldByName('CHK_DATE').AsString = '') then actAudit.Caption := '���' else actAudit.Caption := '����';
//  if rzPage.ActivePageIndex = 0 then
     begin
       actDelete.Enabled := rzPage.ActivePageIndex > 0;
       actEdit.Enabled := rzPage.ActivePageIndex > 0;
       actSave.Enabled := rzPage.ActivePageIndex > 0;
       actCancel.Enabled := false;
       actInfo.Enabled := rzPage.ActivePageIndex > 0;
       actAudit.Enabled := rzPage.ActivePageIndex > 0;
     end;
end;
procedure TfrmRecvOrderList.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
    if cdsList.IsEmpty then Raise Exception.Create('��ѡ�����˵��տ');
   if not ShopGlobal.GetChkRight('21300001',5) then Raise Exception.Create('��û������տ��Ȩ��,��͹���Ա��ϵ.');
    if cdsList.FieldByName('CHK_DATE').AsString<>'' then
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
         if cdsList.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ���۵�ִ������');
         if MessageBox(Handle,'ȷ������ǰ�տ��',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end
    else
       begin
         //if copy(cdsList.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
         if MessageBox(Handle,'ȷ����˵�ǰ�տ��',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    try
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsList.FieldbyName('TENANT_ID').AsInteger;
        Params.ParamByName('SHOP_ID').asString := cdsList.FieldbyName('SHOP_ID').AsString;
        Params.ParamByName('RECV_ID').asString := cdsList.FieldbyName('RECV_ID').AsString;
        Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',date());
        Params.ParamByName('CHK_USER').asString := Global.UserID;
        if cdsList.FieldByName('CHK_DATE').AsString='' then
           Msg := Factor.ExecProc('TRecvOrderAudit',Params)
        else
           Msg := Factor.ExecProc('TRecvOrderUnAudit',Params) ;
      finally
         Params.free;
      end;
      MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
      if cdsList.FieldByName('CHK_DATE').AsString='' then
         begin
            cdsList.Edit;
            cdsList.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',date());
            cdsList.FieldByName('CHK_USER').AsString := Global.UserID;
            cdsList.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
            cdsList.Post;
         end
      else
         begin
            cdsList.Edit;
            cdsList.FieldByName('CHK_DATE').AsString := '';
            cdsList.FieldByName('CHK_USER').AsString := '';
            cdsList.FieldByName('CHK_USER_TEXT').AsString := '';
            cdsList.Post;
         end;
    except
      on E:Exception do
         begin
           Raise Exception.Create(E.Message);
         end;
    end;
end;

procedure TfrmRecvOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open1('');
end;

function TfrmRecvOrderList.EncodeSQL1(id:string;var w:string): string;
var
  strSql,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�տ��ѯ��ʼ���ڲ��ܴ��ڽ�������');
  strWhere := strWhere + ' and A.RECV_TYPE<>''4'' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' ';
  //����ȡ���ݵ�����:
  if trim(id)<>'' then
    strWhere:=strWhere+' A.ABLE_ID > '+QuotedStr(id);
  //�ʿ�����:
  if P1_D1.Date=P1_D2.Date then
    strWhere := strWhere + ' and A.ABLE_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' '
  else
    strWhere := strWhere + ' and A.ABLE_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.ABLE_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+'';
  //�ŵ�����:
  if fndP1_SHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+'''';
  //�ͻ�����:
  if fndP1_CUST_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndP1_CUST_ID.AsString+'''';

  case fndSTATUS.ItemIndex of
   1:strWhere := strWhere + ' and isnull(A.RECK_MNY,0)<>0 ';
   2:strWhere := strWhere + ' and isnull(A.RECK_MNY,0)=0 ';
  end;

  strSql:=
    'select A.ABLE_ID'+
    ',A.SHOP_ID'+
    ',A.CLIENT_ID'+
    ',B.CLIENT_NAME as CUST_ID_TEXT'+
    ',A.ACCT_INFO'+
    ',A.RECV_TYPE '+
    ',A.ACCT_MNY'+
    ',A.RECV_MNY'+
    ',A.REVE_MNY,'+
    'A.RECK_MNY'+
    ',A.ABLE_DATE'+
    ',A.NEAR_DATE'+
    ',C.SHOP_NAME as SHOP_ID_TEXT '+
    ' from ACC_RECVABLE_INFO A,VIW_CUSTOMER B,CA_SHOP_INFO C  '+
    ' where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
    ' '+strWhere+' ';

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by ABLE_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by ABLE_ID) tp fetch first 600  rows only';

  5:result := 'select * from ('+strSql+') j order by ABLE_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by ABLE_ID';
  end;
end;

function TfrmRecvOrderList.EncodeSQL2(id: string; var w: string): string;
var
  strSql,strWhere: string;
begin
  if D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  strWhere := strWhere + ' RECV_FLAG=''0'' and A.TENANT_ID=:TENANT_ID';
  //�ʿ�����
  strWhere := strWhere + ' and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2';
  if fndPAYM_ID.ItemIndex > 0 then
     strWhere := strWhere + ' and A.PAYM_ID='''+TRecord_(fndPAYM_ID.Properties.Items.Objects[fndPAYM_ID.ItemIndex]).FieldbyName('CODE_ID').AsString+'''';
  if fndSHOP_ID.AsString <> '' then
     strWhere := strWhere + ' and A.SHOP_ID='''+fndSHOP_ID.AsString+'''';
  if fndACCOUNT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ACCOUNT_ID='''+fndACCOUNT_ID.AsString+'''';
  if fndITEM_ID.AsString <> '' then
     strWhere := strWhere + ' and A.ITEM_ID='''+fndITEM_ID.AsString+'''';
  if fndRECV_USER.AsString <> '' then
     strWhere := strWhere + ' and A.RECV_USER='''+fndRECV_USER.AsString+'''';
  if fndCLIENT_ID.AsString <> '' then
     strWhere := strWhere + ' and A.CLIENT_ID='''+fndCLIENT_ID.AsString+'''';
  case fndOrderStatus.ItemIndex of
  1:strWhere := strWhere + ' and CHK_DATE is null';
  2:strWhere := strWhere + ' and CHK_DATE is not null';
  end;
  if id<>'' then
     strWhere := strWhere + ' and A.RECV_ID > '+QuotedStr(id);
  strSql :='select A.RECV_ID,A.SHOP_ID,A.TENANT_ID,A.ACCOUNT_ID,A.CLIENT_ID,A.PAYM_ID,A.ITEM_ID,A.GLIDE_NO,A.RECV_DATE,A.RECV_USER,A.REMARK,A.RECV_MNY,A.CHK_DATE,A.CHK_USER,A.CREA_DATE,A.BILL_NO,A.COMM from ACC_RECVORDER A where '+strWhere;
  strSql :='select jc.*,c.ACCT_NAME as ACCOUNT_ID_TEXT from ('+strSql+') jc '+
           'left outer join VIW_ACCOUNT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.ACCOUNT_ID=c.ACCOUNT_ID';
  strSql :='select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+strSql+') jd '+
           'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID';
  strSql :='select je.*,e.USER_NAME as RECV_USER_TEXT  from ('+strSql+') je '+
           'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.RECV_USER=e.USER_ID ';
  strSql :='select jf.*,f.CLIENT_NAME as CLIENT_ID_TEXT  from ('+strSql+') jf '+
           'left outer join VIW_CUSTOMER f on jf.TENANT_ID=f.TENANT_ID and jf.CLIENT_ID=f.CLIENT_ID';
  strSql :='select jg.*,g.CODE_NAME as PAYM_ID_TEXT  from ('+strSql+') jg '+
           'left outer join VIW_PAYMENT g on jg.TENANT_ID=g.TENANT_ID and jg.PAYM_ID=g.CODE_ID';
  strSql :='select jh.*,h.USER_NAME as CHK_USER_TEXT  from ('+strSql+') jh '+
           'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by RECV_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') j order by RECV_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') j order by RECV_ID limit 600';
  else
    result := 'select * from ('+strSql+') j order by RECV_ID';
  end;
end;

procedure TfrmRecvOrderList.Open1(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then CdsRecvList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsRecvList.DisableControls;
  try
    rs.SQL.Text :=ParseSQL(Factor.iDbType, EncodeSQL1(Id,Str));
    Factor.Open(rs);
    rs.SortedFields :='ABLE_ID';
    rs.IndexFieldNames :='ABLE_ID';
    if Id='' then
    begin
      rs.SaveToStream(sm);
      CdsRecvList.LoadFromStream(sm);
      CdsRecvList.SortedFields := 'ABLE_ID';
      CdsRecvList.IndexFieldNames := 'ABLE_ID';
    end else
    begin
      rs.SaveToStream(sm);
      CdsRecvList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd1 := True else IsEnd1 := false;
  finally
    CdsRecvList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmRecvOrderList.Open2(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL2(Id,Str);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
//    rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    Factor.Open(rs);
    rs.Last;
    MaxId2 := rs.FieldbyName('RECV_ID').AsString;
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
    if rs.RecordCount <600 then IsEnd2 := True else IsEnd2 := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmRecvOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ChangeButton;
  if IsEnd2 or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open2(MaxId2);                        
end;

procedure TfrmRecvOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.FillRect(ARect);
      DrawText(DbGridEh2.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmRecvOrderList.RzPageChange(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  ChangeButton;
end;

function TfrmRecvOrderList.PrintSQL2(tenantid,id: string): string;
begin
  result :=
  'select j.* '+
  'from ( '+
  'select ji.*,i.USER_NAME as RECV_USER_TEXT from ('+
  'select jh.*,h.USER_NAME as CHK_USER_TEXT from ('+
  'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
  'select jf.*,f.ACCT_NAME as ACCOUNT_ID_TEXT from ('+
  'select je.*,e.CODE_NAME as ITEM_ID_TEXT from ('+
  'select jd.*,d.CLIENT_NAME as CLIENT_ID_TEXT,d.CLIENT_CODE,d.ADDRESS,d.POSTALCODE,d.LINKMAN,d.TELEPHONE2 as MOVE_TELE from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.SEQNO,A.RECV_MNY,'+
  'b.ACCT_INFO,c.CLIENT_ID,b.ABLE_DATE,C.ITEM_ID,C.ACCOUNT_ID,C.GLIDE_NO,C.RECV_USER,B.RECK_MNY,B.RECV_MNY as ABLE_RECV_MNY,B.ACCT_MNY,C.RECV_MNY as TOTAL_RECV_MNY,C.REMARK,C.RECV_DATE,B.RECV_TYPE,C.CHK_USER '+
  'from ACC_RECVDATA A,ACC_RECVABLE_INFO B,ACC_RECVORDER C where A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=C.TENANT_ID and A.ABLE_ID=B.ABLE_ID and A.RECV_ID=C.RECV_ID and A.TENANT_ID='+tenantid+' and A.RECV_ID='''+id+''' ) jd '+
  'left outer join VIW_CUSTOMER d on jd.TENANT_ID=d.TENANT_ID and jd.CLIENT_ID=d.CLIENT_ID ) je '+
  'left outer join VIW_ITEM_INFO e on je.TENANT_ID=e.TENANT_ID and je.ITEM_ID=e.CODE_ID ) jf '+
  'left outer join VIW_ACCOUNT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.ACCOUNT_ID=f.ACCOUNT_ID ) jg '+
  'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
  'left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.CHK_USER=h.USER_ID ) ji '+
  'left outer join VIW_USERS i on ji.TENANT_ID=i.TENANT_ID and ji.RECV_USER=i.USER_ID ) j order by j.SEQNO' ;
end;

procedure TfrmRecvOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
    if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',6) then Raise Exception.Create('��û�д�ӡ�տ��Ȩ��,��͹���Ա��ϵ.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           PrintReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;

end;

procedure TfrmRecvOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',6) then Raise Exception.Create('��û�д�ӡ�տ��Ȩ��,��͹���Ա��ϵ.');
    with TfrmFastReport.Create(Self) do
      begin
        try
           ShowReport(PrintSQL2(inttostr(Global.TENANT_ID),cdsList.FieldbyName('RECV_ID').AsString),frfRecvOrder);
        finally
           free;
        end;
      end;
end;

procedure TfrmRecvOrderList.frfRecvOrderUserFunction(const Name: String; p1,
  p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

procedure TfrmRecvOrderList.actDeleteExecute(Sender: TObject);
begin
  inherited;
   if cdsList.IsEmpty then Exit;
   if not ShopGlobal.GetChkRight('21300001',4) then Raise Exception.Create('��û��ɾ���տ��Ȩ��,��͹���Ա��ϵ.');
   if cdsList.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('�˵��Ѿ����,����ִ��ɾ������.');   
   if MessageBox(Handle,'ȷ��ɾ����ǰѡ�е��տ��','������ʾ',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
   with TfrmRecvOrder.Create(self) do
      begin
        try
          Open(cdsList.FieldByName('RECV_ID').AsString);
          DeleteOrder;
          cdsList.Delete;
          if cdsList.IsEmpty then cdsDetail.Close;
          MessageBox(Handle,'ɾ���տ�ɹ�...','������ʾ...',MB_OK+MB_ICONINFORMATION);
        finally
          free;
        end;
      end;
end;

procedure TfrmRecvOrderList.AddRecord(AObj: TRecord_);
var
  rs:TZQuery;
begin
  //������List��ҳ��ͬ��ˢ��
  case RzPage.ActivePageIndex of
   0:  
   begin
 
   end;
   1:
   begin
      if cdsList.Locate('RECV_ID',AObj.FieldbyName('RECV_ID').AsString,[]) then
        begin
          cdsList.Edit;
          AObj.WriteToDataSet(cdsList,false);
          cdsList.Post;
        end
      else
        begin
          rs := TZQuery.Create(nil);
          try
            rs.SQL.Text := 'select GLIDE_NO from ACC_RECVORDER where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and RECV_ID='+QuotedStr(AObj.FieldbyName('RECV_ID').AsString);
            Factor.Open(rs);
            AObj.FieldByName('GLIDE_NO').AsString := rs.FieldbyName('GLIDE_NO').AsString;
            cdsList.Append;
            AObj.WriteToDataSet(cdsList,False);
            cdsList.Post;
          finally
            rs.Free;
          end;
        end;
      AObj.WriteToDataSet(cdsList,false);
      cdsList.Post;
    end;
  end;
end;

procedure TfrmRecvOrderList.frfRecvOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='��ҵ����' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='��ҵ���' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

function TfrmRecvOrderList.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if DBGridEh2.Columns[i].FieldName = FieldName then
         begin
           result := DBGridEh2.Columns[i];
           break;
         end;
    end;
end;

function TfrmRecvOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('21300001',7);
end;


procedure TfrmRecvOrderList.CdsRecvListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd1 or not DataSet.Eof then Exit;
  if CdsRecvList.ControlsDisabled then Exit;  
  Open1(MaxId1);
end;

procedure TfrmRecvOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsRecvList.RecNo)),length(Inttostr(CdsRecvList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

end.
