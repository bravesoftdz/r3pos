unit ufrmRckMng;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton, ZBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmRckMng = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DataSource1: TDataSource;
    ToolButton2: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    frfIoroOrder: TfrReport;
    PrintDBGridEh1: TPrintDBGridEh;
    Label4: TLabel;
    fndCREA_USER: TzrComboBoxList;
    cdsBrowser: TZQuery;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    ToolButton5: TToolButton;
    Db_CloseDay: TZQuery;
    Ds_CloseDay: TDataSource;
    Db_CloseMonth: TZQuery;
    Ds_CloseMonth: TDataSource;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel10: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel4: TRzLabel;
    Label1: TLabel;
    Label2: TLabel;
    fndCREA_DATE_D1: TcxDateEdit;
    fndCREA_DATE_D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndSTATUS_D: TcxRadioGroup;
    fndCREA_USER_D: TzrComboBoxList;
    fndSHOP_ID_D: TzrComboBoxList;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel11: TRzPanel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    Label3: TLabel;
    Label5: TLabel;
    fndCREA_DATE_M1: TcxDateEdit;
    fndCREA_DATE_M2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    cxRadioGroup1: TcxRadioGroup;
    fndCREA_USER_M: TzrComboBoxList;
    fndSHOP_ID_M: TzrComboBoxList;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    AllSelect: TMenuItem;
    InverseSelect: TMenuItem;
    NotSelect: TMenuItem;
    AllSelect1: TMenuItem;
    InverserSelect1: TMenuItem;
    NotSelect1: TMenuItem;
    AllSelect2: TMenuItem;
    InverserSelect2: TMenuItem;
    NotSelect2: TMenuItem;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure frfIoroOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure actNewExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzPageChange(Sender: TObject);
    procedure AllSelectClick(Sender: TObject);
    procedure InverseSelectClick(Sender: TObject);
    procedure NotSelectClick(Sender: TObject);
    procedure AllSelect1Click(Sender: TObject);
    procedure InverserSelect1Click(Sender: TObject);
    procedure NotSelect1Click(Sender: TObject);
    procedure AllSelect2Click(Sender: TObject);
    procedure NotSelect2Click(Sender: TObject);
    procedure InverserSelect2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    procedure Audit1;
    procedure Audit2;
    procedure Audit3;
    function EncodeSQL(id:string;var w:string):string;
    procedure Open(Id:string);
    procedure OpenD;
    procedure OpenM;
    procedure Cancel;
    procedure CancelD;
    procedure CancelM;
  end;

implementation
uses uGlobal, uFnUtil, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmBatchCloseForDay,
  ufrmBasic, uframeMDForm;
{$R *.dfm}

procedure TfrmRckMng.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmRckMng.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
//  if Column.FieldName = 'SEQ_NO' then
//     Background := clBtnFace;
end;

function TfrmRckMng.EncodeSQL(id: string;var w:string): string;
var strSql,StrWhere:string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');

  if RzPage.TabIndex = 0 then
    begin
      StrWhere := ' and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CLSE_DATE>='+FormatDateTime('YYYYMMDD',P1_D1.Date)+' and CLSE_DATE <='+FormatDateTime('YYYYMMDD',P1_D2.Date);
      if Trim(fndSHOP_ID.Text) <> '' then
        StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndSHOP_ID.AsString);
      if Trim(fndCREA_USER.Text) <> '' then
        StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndCREA_USER.AsString);
      case fndSTATUS.ItemIndex of
        1:StrWhere := StrWhere + ' and CHK_DATE is null';
        2:StrWhere := StrWhere + ' and CHK_DATE is not null ';
      end;

      strSql :=
      'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+
      'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
      'select jc.*,c.SHOP_NAME as SHOP_ID_TEXT from ('+
      'select 0 as FLAG,ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,'+
      'CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP from ACC_CLOSE_FORDAY where COMM not in (''02'',''12'') '+StrWhere+' ) jc '+
      'left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID ) jd '+
      'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
      'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
    end
  else if RzPage.TabIndex = 1 then
    begin
    end
  else if RzPage.TabIndex = 2 then
    begin
    end;

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by CLSE_DATE desc';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') order by CLSE_DATE desc) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') order by CLSE_DATE desc limit 600';
  else
    result := 'select * from ('+strSql+') order by CLSE_DATE desc';
  end;
end;

procedure TfrmRckMng.Open(Id: string);
var
  rs:TZQuery;
  Str:string;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsBrowser.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsBrowser.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id,Str);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('ROWS_ID').AsString;
    if Id='' then
       begin
         rs.SaveToStream(sm);
         cdsBrowser.LoadFromStream(sm);
         cdsBrowser.IndexFieldNames := 'CLSE_DATE';
       end
    else
       begin
         rs.SaveToStream(sm);
         cdsBrowser.AddFromStream(sm);
       end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsBrowser.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmRckMng.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='����'
  else
    actAudit.Caption:='���';
  if IsEnd or not cdsBrowser.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmRckMng.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if Key=#13 then   actFind.OnExecute(nil);
end;

procedure TfrmRckMng.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmRckMng.InitGrid;
begin
  InitGridPickList(DBGridEh1);
end;

procedure TfrmRckMng.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndCREA_DATE_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  fndCREA_DATE_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndCREA_DATE_M1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  fndCREA_DATE_M2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID_D.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndSHOP_ID_M.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndCREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndSTATUS.ItemIndex := 0;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmRckMng.actFindExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      Open('');
      if not cdsBrowser.IsEmpty then
      begin
        if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='����'
        else
          actAudit.Caption:='���';
        end;
    end
  else if RzPage.TabIndex = 1 then
    begin
      OpenD;
      if not Db_CloseDay.IsEmpty then
      begin
        if Db_CloseDay.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='����'
        else
          actAudit.Caption:='���';
        end;
    end
  else if RzPage.TabIndex = 2 then
    begin
      OpenM;
      if not Db_CloseMonth.IsEmpty then
      begin
        if Db_CloseMonth.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='����'
        else
          actAudit.Caption:='���';
        end;
    end;
end;

procedure TfrmRckMng.frfIoroOrderUserFunction(const Name: String; p1,
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

procedure TfrmRckMng.actNewExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      if TfrmBatchCloseForDay.EditDialog(Self) then
        Open('');
    end
  else if RzPage.TabIndex = 1 then
    begin
    end
  else if RzPage.TabIndex = 2 then
    begin
    end;
end;

procedure TfrmRckMng.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmRckMng.Cancel;
var rs: TZQuery;
begin
  inherited;
  rs := TZQuery.Create(nil);
  try
    cdsBrowser.CommitUpdates;
    cdsBrowser.Filtered := False;
    cdsBrowser.Filter := ' FLAG=1 ';
    cdsBrowser.Filtered := True;
    if cdsBrowser.IsEmpty then Raise Exception.Create('��ѡ������¼.');

    cdsBrowser.First;
    while not cdsBrowser.Eof do
      begin
        if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('�Ѿ����,���ܽ��г�������.');
        rs.Close;
        rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and ROWS_ID='+QuotedStr(cdsBrowser.FieldbyName('ROWS_ID').AsString);
        Factor.Open(rs);
        if (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('�����Ѿ�ͬ��,���ܳ���!');
        if cdsBrowser.FieldByName('FLAG').AsString = '1' then
          cdsBrowser.Delete
        else
          cdsBrowser.Next;
      end;
    try
      Factor.UpdateBatch(cdsBrowser,'TCloseForDay');
    Except
      cdsBrowser.CancelUpdates;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmRckMng.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      if cdsBrowser.IsEmpty and (not cdsBrowser.Active) then Exit;
      Cancel;
    end
  else if RzPage.TabIndex = 1 then
    begin
      if Db_CloseDay.IsEmpty and (not Db_CloseDay.Active) then Exit;
      CancelD;
    end
  else if RzPage.TabIndex = 2 then
    begin
      if Db_CloseMonth.IsEmpty and (not Db_CloseMonth.Active) then Exit;
      CancelM;
    end;

end;

procedure TfrmRckMng.Audit1;
var Msg:String;
    Params:TftParamList;
begin
  inherited;
  if cdsBrowser.IsEmpty then  Exit;

  //Ȩ��
  if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
      if cdsBrowser.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ����ִ������');
      if MessageBox(Handle,'ȷ������ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
      if MessageBox(Handle,'ȷ����˵�ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
    end;

  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
      Params.ParamByName('CHK_USER').AsString := Global.UserID;
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('ROWS_ID').AsString := cdsBrowser.FieldbyName('ROWS_ID').AsString;
      if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
        begin
          try
            Msg := Factor.ExecProc('TCloseAudit',Params);
            actAudit.Caption := '����';
          Except
            actAudit.Caption := '���';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('TCloseUnAudit',Params);
            actAudit.Caption := '���';
          Except
            actAudit.Caption := '����';
          end;
        end;
    finally
      Params.Free;
    end;
    MessageBox(Handle,pchar(Msg),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION);
    if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
        cdsBrowser.FieldByName('CHK_USER').AsString := Global.UserID;
        cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
        cdsBrowser.Post;
      end
    else
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('CHK_DATE').AsString := '';
        cdsBrowser.FieldByName('CHK_USER').AsString := '';
        cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := '';
        cdsBrowser.Post;
      end;
  Except
    on E:Exception do
      begin
        Raise Exception.Create(E.Message);
      end;
  end;
end;

procedure TfrmRckMng.Audit2;
var Msg:String;
    Params:TftParamList;
begin
  inherited;
  if Db_CloseDay.IsEmpty then  Exit;

  //Ȩ��
  if Db_CloseDay.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(Db_CloseDay.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
      if Db_CloseDay.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ����ִ������');
      if MessageBox(Handle,'ȷ������ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(Db_CloseDay.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
      if MessageBox(Handle,'ȷ����˵�ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
    end;

  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
      Params.ParamByName('CHK_USER').AsString := Global.UserID;
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('CREA_DATE').AsString := Db_CloseDay.FieldbyName('CREA_DATE').AsString;
      Params.ParamByName('SHOP_ID').AsString := Db_CloseDay.FieldbyName('SHOP_ID').AsString;
      if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '����';
          Except
            actAudit.Caption := '���';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '���';
          Except
            actAudit.Caption := '����';
          end;
        end;
    finally
      Params.Free;
    end;
    MessageBox(Handle,pchar(Msg),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION);
    if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
        cdsBrowser.FieldByName('CHK_USER').AsString := Global.UserID;
        cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
        cdsBrowser.Post;
      end
    else
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('CHK_DATE').AsString := '';
        cdsBrowser.FieldByName('CHK_USER').AsString := '';
        cdsBrowser.FieldByName('CHK_USER_TEXT').AsString := '';
        cdsBrowser.Post;
      end;
  Except
    on E:Exception do
      begin
        Raise Exception.Create(E.Message);
      end;
  end;
end;

procedure TfrmRckMng.Audit3;
var Msg:String;
    Params:TftParamList;
begin
  inherited;
  if Db_CloseMonth.IsEmpty then  Exit;

  //Ȩ��
  if Db_CloseMonth.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(Db_CloseMonth.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
      if Db_CloseMonth.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ����ִ������');
      if MessageBox(Handle,'ȷ������ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(Db_CloseMonth.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
      if MessageBox(Handle,'ȷ����˵�ǰ���ݣ�',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
    end;

  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
      Params.ParamByName('CHK_USER').AsString := Global.UserID;
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString := Db_CloseMonth.FieldbyName('SHOP_ID').AsString;
      Params.ParamByName('CREA_DATE').AsString := Db_CloseMonth.FieldbyName('CREA_DATE').AsString;
      if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '����';
          Except
            actAudit.Caption := '���';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '���';
          Except
            actAudit.Caption := '����';
          end;
        end;
    finally
      Params.Free;
    end;
    MessageBox(Handle,pchar(Msg),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION);
    if Db_CloseMonth.FieldByName('CHK_DATE').AsString = '' then
      begin
        Db_CloseMonth.Edit;
        Db_CloseMonth.FieldByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
        Db_CloseMonth.FieldByName('CHK_USER').AsString := Global.UserID;
        Db_CloseMonth.FieldByName('CHK_USER_TEXT').AsString := Global.UserName;
        Db_CloseMonth.Post;
      end
    else
      begin
        Db_CloseMonth.Edit;
        Db_CloseMonth.FieldByName('CHK_DATE').AsString := '';
        Db_CloseMonth.FieldByName('CHK_USER').AsString := '';
        Db_CloseMonth.FieldByName('CHK_USER_TEXT').AsString := '';
        Db_CloseMonth.Post;
      end;
  Except
    on E:Exception do
      begin
        Raise Exception.Create(E.Message);
      end;
  end;
end;

procedure TfrmRckMng.actAuditExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      Audit1;
    end
  else if RzPage.TabIndex = 1 then
    begin
      Audit2;
    end
  else if RzPage.TabIndex = 2 then
    begin
      Audit3;
    end;
end;

procedure TfrmRckMng.CancelD;
begin

end;

procedure TfrmRckMng.CancelM;
begin

end;

procedure TfrmRckMng.OpenD;
var StrSql,StrWhere:String;
begin
  if fndCREA_DATE_D1.EditValue = null then Exception.Create('�������ڲ���Ϊ��!');
  if fndCREA_DATE_D2.EditValue = null then Exception.Create('�������ڲ���Ϊ��!');
  StrWhere := ' and CREA_DATE>='+FormatDateTime('YYYYMMDD',fndCREA_DATE_D1.Date)+' and CREA_DATE<='+FormatDateTime('YYYYMMDD',fndCREA_DATE_D2.Date);
  if fndSHOP_ID_D.AsString <> '' then
    StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndSHOP_ID_D.AsString);
  if fndCREA_USER_D.AsString <> '' then
    StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndCREA_USER_D.AsString);
  StrSql :=
  'select jc.*,c.USER_NAME as CHK_USER_TEXT from('+
  'select jb.*,b.USER_NAME as CREA_USER_TEXT from('+
  'select ja.*,a.SHOP_NAME as SHOP_ID_TEXT from('+
  'select 0 as FLAG,TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,CHK_DATE,CHK_USER,COMM,TIME_STAMP from RCK_DAYS_CLOSE where TENANT_ID='+IntToStr(Global.TENANT_ID)+StrWhere+') ja'+
  ' left outer join CA_SHOP_INFO a on a.TENANT_ID=ja.TENANT_ID and a.SHOP_ID=ja.SHOP_ID where a.COMM not in (''12'',''02'')) jb'+
  ' left outer join VIW_USERS b on b.TENANT_ID=jb.TENANT_ID and b.USER_ID=jb.CREA_USER) jc'+
  ' left outer join VIW_USERS c on c.TENANT_ID=jc.TENANT_ID and c.USER_ID=jc.CHK_USER';
  Db_CloseDay.Close;
  Db_CloseDay.SQL.Text := StrSql;
  Factor.Open(Db_CloseDay);
end;

procedure TfrmRckMng.OpenM;
var StrSql,StrWhere:String;
begin
  if fndCREA_DATE_M1.EditValue = null then Exception.Create('�������ڲ���Ϊ��!');
  if fndCREA_DATE_M2.EditValue = null then Exception.Create('�������ڲ���Ϊ��!');
  StrWhere := ' and MONTH>='+FormatDateTime('YYYYMMDD',fndCREA_DATE_D1.Date)+' and MONTH<='+FormatDateTime('YYYYMMDD',fndCREA_DATE_D2.Date);
  if fndSHOP_ID_M.AsString <> '' then
    StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndSHOP_ID_D.AsString);
  if fndCREA_USER_M.AsString <> '' then
    StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndCREA_USER_D.AsString);
  StrSql :=
  'select jc.*,c.USER_NAME as CHK_USER_TEXT from('+
  'select jb.*,b.USER_NAME as CREA_USER_TEXT from('+
  'select ja.*,a.SHOP_NAME as SHOP_ID_TEXT from('+
  'select 0 as FLAG,TENANT_ID,SHOP_ID,MONTH,CREA_USER,BEGIN_DATE,END_DATE,CHK_DATE,CHK_USER,COMM,TIME_STAMP from RCK_MONTH_CLOSE where TENANT_ID='+IntToStr(Global.TENANT_ID)+StrWhere+') ja'+
  ' left outer join CA_SHOP_INFO a on a.TENANT_ID=ja.TENANT_ID and a.SHOP_ID=ja.SHOP_ID where a.COMM not in (''12'',''02'')) jb'+
  ' left outer join VIW_USERS b on b.TENANT_ID=jb.TENANT_ID and b.USER_ID=jb.CREA_USER) jc'+
  ' left outer join VIW_USERS c on c.TENANT_ID=jc.TENANT_ID and c.USER_ID=jc.CHK_USER';
  Db_CloseMonth.Close;
  Db_CloseMonth.SQL.Text := StrSql;
  Factor.Open(Db_CloseMonth);
end;

procedure TfrmRckMng.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DbGridEh2.CellRect(DbGridEh2.Col, DbGridEh2.Row).Top) and (not
    (gdFocused in State) or not DbGridEh2.Focused) then
  begin
    DbGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DbGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh2.canvas.FillRect(ARect);
      DrawText(DbGridEh2.Canvas.Handle,pchar(Inttostr(Db_CloseDay.RecNo)),length(Inttostr(Db_CloseDay.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmRckMng.DBGridEh3DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh3.CellRect(DBGridEh3.Col, DBGridEh3.Row).Top) and (not
    (gdFocused in State) or not DBGridEh3.Focused) then
  begin
    DBGridEh3.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh3.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh3.canvas.FillRect(ARect);
      DrawText(DBGridEh3.Canvas.Handle,pchar(Inttostr(Db_CloseMonth.RecNo)),length(Inttostr(Db_CloseMonth.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmRckMng.RzPageChange(Sender: TObject);
begin
  inherited;
  //actFindExecute(Sender);
end;

procedure TfrmRckMng.AllSelectClick(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) and cdsBrowser.IsEmpty then Exit;
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('FLAG').AsString := '1';
        cdsBrowser.Post;
        cdsBrowser.Next;
      end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmRckMng.InverseSelectClick(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or cdsBrowser.IsEmpty then Exit;
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
      begin
        if cdsBrowser.FieldByName('FLAG').AsString = '0' then
          begin
            cdsBrowser.Edit;
            cdsBrowser.FieldByName('FLAG').AsString := '1';
            cdsBrowser.Post;
          end
        else
          begin
            cdsBrowser.Edit;
            cdsBrowser.FieldByName('FLAG').AsString := '0';
            cdsBrowser.Post;
          end;
        cdsBrowser.Next;
      end;

  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmRckMng.NotSelectClick(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty or (not cdsBrowser.Active) then Exit;
  cdsBrowser.DisableControls ;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('FLAG').AsString := '0';
        cdsBrowser.Post;
        cdsBrowser.Next;
      end;

  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmRckMng.AllSelect1Click(Sender: TObject);
begin
  inherited;
  if (not Db_CloseDay.Active) and Db_CloseDay.IsEmpty then Exit;
  Db_CloseDay.DisableControls;
  try
    Db_CloseDay.First;
    while not Db_CloseDay.Eof do
      begin
        Db_CloseDay.Edit;
        Db_CloseDay.FieldByName('FLAG').AsString := '1';
        Db_CloseDay.Post;
        Db_CloseDay.Next;
      end;
  finally
    Db_CloseDay.First;
    Db_CloseDay.EnableControls;
  end;
end;

procedure TfrmRckMng.InverserSelect1Click(Sender: TObject);
begin
  inherited;
  if (not Db_CloseDay.Active) or Db_CloseDay.IsEmpty then Exit;
  Db_CloseDay.DisableControls;
  try
    Db_CloseDay.First;
    while not Db_CloseDay.Eof do
      begin
        if Db_CloseDay.FieldByName('FLAG').AsString = '0' then
          begin
            Db_CloseDay.Edit;
            Db_CloseDay.FieldByName('FLAG').AsString := '1';
            Db_CloseDay.Post;
          end
        else
          begin
            Db_CloseDay.Edit;
            Db_CloseDay.FieldByName('FLAG').AsString := '0';
            Db_CloseDay.Post;
          end;
        Db_CloseDay.Next;
      end;

  finally
    Db_CloseDay.First;
    Db_CloseDay.EnableControls;
  end;
end;

procedure TfrmRckMng.NotSelect1Click(Sender: TObject);
begin
  inherited;
  if (not Db_CloseDay.Active) and Db_CloseDay.IsEmpty then Exit;
  Db_CloseDay.DisableControls;
  try
    Db_CloseDay.First;
    while not Db_CloseDay.Eof do
      begin
        Db_CloseDay.Edit;
        Db_CloseDay.FieldByName('FLAG').AsString := '0';
        Db_CloseDay.Post;
        Db_CloseDay.Next;
      end;
  finally
    Db_CloseDay.First;
    Db_CloseDay.EnableControls;
  end;
end;

procedure TfrmRckMng.AllSelect2Click(Sender: TObject);
begin
  inherited;
 if (not Db_CloseMonth.Active) and Db_CloseMonth.IsEmpty then Exit;
  Db_CloseMonth.DisableControls;
  try
    Db_CloseMonth.First;
    while not Db_CloseMonth.Eof do
      begin
        Db_CloseMonth.Edit;
        Db_CloseMonth.FieldByName('FLAG').AsString := '1';
        Db_CloseMonth.Post;
        Db_CloseMonth.Next;
      end;
  finally
    Db_CloseMonth.First;
    Db_CloseMonth.EnableControls;
  end;
end;

procedure TfrmRckMng.NotSelect2Click(Sender: TObject);
begin
  inherited;
 if (not Db_CloseMonth.Active) and Db_CloseMonth.IsEmpty then Exit;
  Db_CloseMonth.DisableControls;
  try
    Db_CloseMonth.First;
    while not Db_CloseMonth.Eof do
      begin
        Db_CloseMonth.Edit;
        Db_CloseMonth.FieldByName('FLAG').AsString := '0';
        Db_CloseMonth.Post;
        Db_CloseMonth.Next;
      end;
  finally
    Db_CloseMonth.First;
    Db_CloseMonth.EnableControls;
  end;
end;

procedure TfrmRckMng.InverserSelect2Click(Sender: TObject);
begin
  inherited;
  if (not Db_CloseMonth.Active) or Db_CloseMonth.IsEmpty then Exit;
  Db_CloseMonth.DisableControls;
  try
    Db_CloseMonth.First;
    while not Db_CloseMonth.Eof do
      begin
        if Db_CloseMonth.FieldByName('FLAG').AsString = '0' then
          begin
            Db_CloseMonth.Edit;
            Db_CloseMonth.FieldByName('FLAG').AsString := '1';
            Db_CloseMonth.Post;
          end
        else
          begin
            Db_CloseMonth.Edit;
            Db_CloseMonth.FieldByName('FLAG').AsString := '0';
            Db_CloseMonth.Post;
          end;
        Db_CloseMonth.Next;
      end;

  finally
    Db_CloseMonth.First;
    Db_CloseMonth.EnableControls;
  end;
end;

end.






