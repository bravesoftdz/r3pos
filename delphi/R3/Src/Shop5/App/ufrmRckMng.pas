unit ufrmRckMng;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton, ZBase, DB, RzTreeVw,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxMaskEdit,
  cxRadioGroup, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, zrMonthEdit;

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
    fndP1_STATUS: TcxRadioGroup;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    Label4: TLabel;
    fndP1_CREA_USER: TzrComboBoxList;
    cdsBrowser: TZQuery;
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
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    RzBitBtn1: TRzBitBtn;
    fndP2_STATUS: TcxRadioGroup;
    fndP2_CREA_USER: TzrComboBoxList;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel11: TRzPanel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    Label3: TLabel;
    RzBitBtn2: TRzBitBtn;
    fndP3_STATUS: TcxRadioGroup;
    fndP3_CREA_USER: TzrComboBoxList;
    P3_M1: TzrMonthEdit;
    P3_M2: TzrMonthEdit;
    Label6: TLabel;
    fndP1_SHOP_ID: TzrComboBoxList;
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
    locked:boolean;
    procedure InitGrid;
    procedure Audit1;
    procedure Audit2;
    procedure Audit3;
    function EncodeSQL:string;
    procedure Open;
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

function TfrmRckMng.EncodeSQL: string;
var strSql,StrWhere:string;
begin
  if RzPage.TabIndex = 0 then
    begin
      if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
      if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');

      StrWhere := ' and CLSE_DATE>='+FormatDateTime('YYYYMMDD',P1_D1.Date)+' and CLSE_DATE <='+FormatDateTime('YYYYMMDD',P1_D2.Date);
      if Trim(fndP1_SHOP_ID.AsString) <> '' then
        StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndP1_SHOP_ID.AsString);
      if Trim(fndP1_CREA_USER.AsString) <> '' then
        StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndP1_CREA_USER.AsString);
      case fndP1_STATUS.ItemIndex of
        1:StrWhere := StrWhere + ' and CHK_DATE is null';
        2:StrWhere := StrWhere + ' and CHK_DATE is not null ';
      end;

      strSql :=
      'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+
      'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
      'select jc.*,c.SHOP_NAME as SHOP_ID_TEXT from ('+
      'select 0 as FLAG,ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,'+
      'CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+StrWhere+' ) jc '+
      'left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID ) jd '+
      'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
      'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID order by jc.CREA_DATE desc';
    end
  else if RzPage.TabIndex = 1 then
    begin
      if fndP2_D1.EditValue = null then Exception.Create('结账日期不能为空!');
      if fndP2_D2.EditValue = null then Exception.Create('结账日期不能为空!');
      StrWhere := ' and CREA_DATE>='+FormatDateTime('YYYYMMDD',P2_D1.Date)+' and CREA_DATE<='+FormatDateTime('YYYYMMDD',P2_D2.Date);
      StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndP2_SHOP_ID.AsString+'0001');
      if fndP2_CREA_USER.AsString <> '' then
        StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndP2_CREA_USER.AsString);
      StrSql :=
      'select jc.*,c.USER_NAME as CHK_USER_TEXT from('+
      'select jb.*,b.USER_NAME as CREA_USER_TEXT from('+
      'select 0 as FLAG,TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,CHK_DATE,CHK_USER,COMM,TIME_STAMP from RCK_DAYS_CLOSE where TENANT_ID='+IntToStr(Global.TENANT_ID)+StrWhere+') jb '+
      ' left outer join VIW_USERS b on b.TENANT_ID=jb.TENANT_ID and b.USER_ID=jb.CREA_USER) jc '+
      ' left outer join VIW_USERS c on c.TENANT_ID=jc.TENANT_ID and c.USER_ID=jc.CHK_USER';
      Db_CloseDay.Close;
      Db_CloseDay.SQL.Text := StrSql;
      Factor.Open(Db_CloseDay);
    end
  else if RzPage.TabIndex = 2 then
    begin
    end;
  result := strSQL;
end;

procedure TfrmRckMng.Open;
begin
  if not Visible then Exit;
  cdsBrowser.Close;
  cdsBrowser.SQL.Text := EncodeSQL;
  Factor.Open(cdsBrowser);
end;

procedure TfrmRckMng.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='弃审'
  else
    actAudit.Caption:='审核';
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
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  InitGridPickList(DBGridEh1);
  rs := Global.GetZQueryFromName('PUB_PAYMENT');
  rs.First;
  while not rs.Eof do
    begin
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'PAY_A'+rs.FieldbyName('CODE_ID').AsString;
      Column.Width := 65;
      Column.Title.Caption := rs.FieldbyName('CODE_NAME').AsString;
      Column.Index := DBGridEh1.Columns.Count -5;
      rs.Next;
    end;
end;

procedure TfrmRckMng.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_M1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-01', date));
  P3_M2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM', date));
  fndP1_SHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndP2_SHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndP3_SHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndP1_CREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndP2_CREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndP3_CREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndP1_STATUS.ItemIndex := 0;
  fndP2_STATUS.ItemIndex := 0;
  fndP3_STATUS.ItemIndex := 0;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmRckMng.actFindExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      Open('');
    end
  else if RzPage.TabIndex = 1 then
    begin
      OpenD;
    end
  else if RzPage.TabIndex = 2 then
    begin
      OpenM;
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
    if cdsBrowser.IsEmpty then Raise Exception.Create('请选择撤消记录.');

    cdsBrowser.First;
    while not cdsBrowser.Eof do
      begin
        if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('已经审核,不能进行撤消操作.');
        rs.Close;
        rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and ROWS_ID='+QuotedStr(cdsBrowser.FieldbyName('ROWS_ID').AsString);
        Factor.Open(rs);
        if (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('数据已经同步,不能撤消!');
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

  //权限
  if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能弃审');
      if cdsBrowser.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
      if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能再审核');
      if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
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
            actAudit.Caption := '弃审';
          Except
            actAudit.Caption := '审核';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('TCloseUnAudit',Params);
            actAudit.Caption := '审核';
          Except
            actAudit.Caption := '弃审';
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

  //权限
  if Db_CloseDay.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(Db_CloseDay.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能弃审');
      if Db_CloseDay.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
      if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(Db_CloseDay.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能再审核');
      if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
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
            actAudit.Caption := '弃审';
          Except
            actAudit.Caption := '审核';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '审核';
          Except
            actAudit.Caption := '弃审';
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

  //权限
  if Db_CloseMonth.FieldByName('CHK_DATE').AsString <> '' then
    begin
      if Copy(Db_CloseMonth.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能弃审');
      if Db_CloseMonth.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
      if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      if Copy(Db_CloseMonth.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能再审核');
      if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
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
            actAudit.Caption := '弃审';
          Except
            actAudit.Caption := '审核';
          end;
        end
      else
        begin
          try
            Msg := Factor.ExecProc('',Params);
            actAudit.Caption := '审核';
          Except
            actAudit.Caption := '弃审';
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
end;

procedure TfrmRckMng.OpenM;
var StrSql,StrWhere:String;
begin
  if fndP3_M1.asString = '' then Exception.Create('结账月份不能为空!');
  if fndP3_M2.asString = '' then Exception.Create('结账月份不能为空!');
  StrWhere := ' and MONTH>='+fndP3_M1.asString+' and MONTH<='+fndP3_M2.asString;
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






