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
    procedure actNewExecute(Sender: TObject);
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
    procedure Db_CloseDayAfterScroll(DataSet: TDataSet);
    procedure Db_CloseMonthAfterScroll(DataSet: TDataSet);
    procedure actPrintExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    locked:boolean;
    VPay:TStringList;
    { Public declarations }
    procedure CheckCalc(b, e:integer); //开始月份| 结束月份
    procedure InitGrid;
    procedure Audit1;
    procedure Audit2;
    procedure Audit3;
    function EncodeSQL:string;
    procedure Open;
    procedure Cancel;
    procedure CancelD;
    procedure CancelM;
  end;

implementation
uses uGlobal, uFnUtil, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil, ufrmBatchCloseForDay,
  ufrmBasic, uframeMDForm, ufrmShopMain, ObjCommon, ufrmCostCalc, ufrmTicketPrint;
{$R *.dfm}

procedure TfrmRckMng.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  s:string;
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
  if cdsBrowser.FieldByName('flag').AsInteger = 2 then
  begin
  if Column.FieldName = 'CLSE_DATE' then
    begin
      ARect := Rect;
      s := '';
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'TOTAL_MNY' then
    begin
      ARect := Rect;
      s := '销售金额';
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'PAY_A' then
    begin
      ARect := Rect;
      s := VPay.Values['A'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'ORG_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['B'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'PUSH_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['C'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'RECV_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['D'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'PAY_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['E'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'OTH_IN_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['F'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'OTH_OUT_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['G'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'TRN_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['H'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'BAL_MNY' then
    begin
      ARect := Rect;
      s := VPay.Values['I'];
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  end;
end;

procedure TfrmRckMng.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsBrowser.FieldByName('flag').AsInteger=1 then
     Background := clBtnFace;
  if cdsBrowser.FieldByName('flag').AsInteger=2 then
     Background := $00EAF7F7;
  if Column.FieldName='PAY_A' then
     AFont.Color := clRed;
end;

function TfrmRckMng.EncodeSQL: string;
var
  strSql,StrWhere:string;
begin
  if RzPage.TabIndex = 0 then
    begin
      if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
      if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');

      StrWhere := ' and CLSE_DATE>='+FormatDateTime('YYYYMMDD',P1_D1.Date)+' and CLSE_DATE <='+FormatDateTime('YYYYMMDD',P1_D2.Date);
      if Trim(fndP1_SHOP_ID.AsString) <> '' then
        StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(fndP1_SHOP_ID.AsString);
      case fndP1_STATUS.ItemIndex of
        1:StrWhere := StrWhere + ' and CHK_DATE is null';
        2:StrWhere := StrWhere + ' and CHK_DATE is not null ';
      end;
      //检测是否计算
      //if not locked then
      //CheckCalc(strtoint(formatDatetime('YYYYMMDD',P1_D1.Date)),strtoint(formatDatetime('YYYYMMDD',P1_D2.Date)));

      strSql :=
      'select jc.*,c.SHOP_NAME as SHOP_ID_TEXT from ('+
      'select 1 as FLAG,TENANT_ID,SHOP_ID,CLSE_DATE,'+
      'sum(CLSE_MNY) as CLSE_MNY,'+
      'sum(PAY_A) as PAY_A,'+
      'sum(PAY_B) as PAY_B,'+
      'sum(PAY_C) as PAY_C,'+
      'sum(PAY_D) as PAY_D,'+
      'sum(PAY_E) as PAY_E,'+
      'sum(PAY_F) as PAY_F,'+
      'sum(PAY_G) as PAY_G,'+
      'sum(PAY_H) as PAY_H,'+
      'sum(PAY_I) as PAY_I,'+
      'sum(PAY_J) as PAY_J,'+
      'min(CHK_DATE) as CHK_DATE,min(CHK_USER) as CHK_USER,max(CREA_DATE) as CREA_DATE,'''' as CREA_USER,0 as TIME_STAMP '+
      'from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+StrWhere+' group by TENANT_ID,SHOP_ID,CLSE_DATE) jc '+
      'left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID';
      strSql := strSql + ' union all '+
      'select jc.*,'''' as SHOP_ID_TEXT from ('+
      'select 3 as FLAG,TENANT_ID,SHOP_ID,CLSE_DATE,'+
      'sum(CLSE_MNY) as CLSE_MNY,'+
      'sum(PAY_A) as PAY_A,'+
      'sum(PAY_B) as PAY_B,'+
      'sum(PAY_C) as PAY_C,'+
      'sum(PAY_D) as PAY_D,'+
      'sum(PAY_E) as PAY_E,'+
      'sum(PAY_F) as PAY_F,'+
      'sum(PAY_G) as PAY_G,'+
      'sum(PAY_H) as PAY_H,'+
      'sum(PAY_I) as PAY_I,'+
      'sum(PAY_J) as PAY_J,'+
      'min(CHK_DATE) as CHK_DATE,min(CHK_USER) as CHK_USER,max(CREA_DATE) as CREA_DATE,CREA_USER,0 as TIME_STAMP '+
      'from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+StrWhere+' group by TENANT_ID,SHOP_ID,CLSE_DATE,CREA_USER) jc ';

      result :=
      'select je.*,case when flag=1 then '''' else e.USER_NAME end as CREA_USER_TEXT from ('+
      'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+StrSql+') jd '+
      'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
      'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID order by je.CLSE_DATE,je.SHOP_ID,flag';
    end
  else if RzPage.TabIndex = 2 then
    begin
      if P2_D1.EditValue = null then Exception.Create('结账日期不能为空!');
      if P2_D2.EditValue = null then Exception.Create('结账日期不能为空!');
      StrWhere := ' and CREA_DATE>='+FormatDateTime('YYYYMMDD',P2_D1.Date)+' and CREA_DATE<='+FormatDateTime('YYYYMMDD',P2_D2.Date);
      StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(inttostr(Global.TENANT_ID)+'0001');
      if fndP2_CREA_USER.AsString <> '' then
        StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndP2_CREA_USER.AsString);
      case fndP2_STATUS.ItemIndex of
        1:StrWhere := StrWhere + ' and CHK_DATE is null';
        2:StrWhere := StrWhere + ' and CHK_DATE is not null ';
      end;
      StrSql :=
      'select jc.*,c.USER_NAME as CHK_USER_TEXT from('+
      'select jb.*,b.USER_NAME as CREA_USER_TEXT from('+
      'select 0 as FLAG,TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,CHK_DATE,CHK_USER,COMM,TIME_STAMP from RCK_DAYS_CLOSE where TENANT_ID='+IntToStr(Global.TENANT_ID)+StrWhere+') jb '+
      ' left outer join VIW_USERS b on b.TENANT_ID=jb.TENANT_ID and b.USER_ID=jb.CREA_USER) jc '+
      ' left outer join VIW_USERS c on c.TENANT_ID=jc.TENANT_ID and c.USER_ID=jc.CHK_USER order by CREA_DATE desc';
      result := StrSql;
    end
  else if RzPage.TabIndex = 1 then
    begin
      if P3_M1.asString = '' then Exception.Create('结账月份不能为空!');
      if P3_M2.asString = '' then Exception.Create('结账月份不能为空!');
      StrWhere := ' and MONTH>='+P3_M1.asString+' and MONTH<='+P3_M2.asString;
      StrWhere := StrWhere + ' and SHOP_ID='+QuotedStr(inttostr(Global.TENANT_ID)+'0001');
      if fndP3_CREA_USER.AsString <> '' then
        StrWhere := StrWhere + ' and CREA_USER='+QuotedStr(fndP3_CREA_USER.AsString);
      case fndP3_STATUS.ItemIndex of
        1:StrWhere := StrWhere + ' and CHK_DATE is null';
        2:StrWhere := StrWhere + ' and CHK_DATE is not null ';
      end;
      StrSql :=
      'select jc.*,c.USER_NAME as CHK_USER_TEXT from('+
      'select jb.*,b.USER_NAME as CREA_USER_TEXT from('+
      'select ja.*,a.SHOP_NAME as SHOP_ID_TEXT from('+
      'select 0 as FLAG,TENANT_ID,SHOP_ID,MONTH,CREA_USER,BEGIN_DATE,END_DATE,CHK_DATE,CHK_USER,COMM,TIME_STAMP from RCK_MONTH_CLOSE where TENANT_ID='+IntToStr(Global.TENANT_ID)+StrWhere+') ja'+
      ' left outer join CA_SHOP_INFO a on a.TENANT_ID=ja.TENANT_ID and a.SHOP_ID=ja.SHOP_ID where a.COMM not in (''12'',''02'')) jb'+
      ' left outer join VIW_USERS b on b.TENANT_ID=jb.TENANT_ID and b.USER_ID=jb.CREA_USER) jc'+
      ' left outer join VIW_USERS c on c.TENANT_ID=jc.TENANT_ID and c.USER_ID=jc.CHK_USER order by MONTH desc';
      result := StrSql;
    end;
end;

procedure TfrmRckMng.Open;
begin
  if not Visible then Exit;
  case rzPage.ActivePageIndex of
  0:begin
      cdsBrowser.Close;
      cdsBrowser.SQL.Text := EncodeSQL;
      Factor.Open(cdsBrowser);
    end;
  2:begin
      Db_CloseDay.Close;
      Db_CloseDay.SQL.Text := EncodeSQL;
      Factor.Open(Db_CloseDay);
    end;
  1:begin
      Db_CloseMonth.Close;
      Db_CloseMonth.SQL.Text := EncodeSQL;
      Factor.Open(Db_CloseMonth);
    end;
  end;
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
  Open;
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
      VPay.Add(rs.FieldbyName('CODE_ID').AsString+'='+rs.FieldbyName('CODE_NAME').AsString);
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'PAY_'+rs.FieldbyName('CODE_ID').AsString;
      Column.Title.Caption := '收款方式|'+rs.FieldbyName('CODE_NAME').AsString;
      Column.Index := DBGridEh1.Columns.Count - 4;
      Column.Width := 60;
      rs.Next;
    end;
end;

procedure TfrmRckMng.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  VPay := TStringList.Create;
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_M1.asString := FormatDateTime('YYYY01', date);
  P3_M2.asString := FormatDateTime('YYYYMM', date);
  fndP1_SHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
//  fndP1_CREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
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
  Open;
end;

procedure TfrmRckMng.actNewExecute(Sender: TObject);
begin
  inherited;
  if RzPage.TabIndex = 0 then
    begin
      if TfrmBatchCloseForDay.EditDialog(Self) then
        Open;
    end
  else if RzPage.TabIndex = 2 then
    begin
      if not frmShopMain.actfrmDaysClose.Enabled then Raise Exception.Create('你没有日结账权限，不能完成操作此功能.');
      frmShopMain.actfrmDaysClose.OnExecute(nil);
      Open;
    end
  else if RzPage.TabIndex = 1 then
    begin
      if not frmShopMain.actfrmMonthClose.Enabled then Raise Exception.Create('你没有月结账权限，不能完成操作此功能.');
      frmShopMain.actfrmMonthClose.OnExecute(nil);
      Open;
    end;
end;

procedure TfrmRckMng.Cancel;
var rs: TZQuery;
begin
  inherited;
  if not ShopGlobal.GetChkRight('13200001',3) then  Raise Exception.Create('您没有撤消权限,请联系管理员!');
  if cdsBrowser.FieldbyName('FLAG').asString<>'3' then Raise Exception.Create('请选择要撤消的收银员!');
  rs := TZQuery.Create(nil);
  try
    cdsBrowser.CommitUpdates;
    if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then Raise Exception.Create('已经审核,不能进行撤消操作.');
    if MessageBox(Handle,'是否撤消当前选择的结账记录？ ','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    rs.Close;
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_CLOSE_FORDAY where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and ROWS_ID='+QuotedStr(cdsBrowser.FieldbyName('ROWS_ID').AsString);
    Factor.Open(rs);
    if (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('数据已经同步,不能撤消!');
    cdsBrowser.Delete;
    try
      Factor.UpdateBatch(cdsBrowser,'TCloseForDay');
    except
      cdsBrowser.CancelUpdates;
      Raise;
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
  else if RzPage.TabIndex = 2 then
    begin
      CancelD;
    end
  else if RzPage.TabIndex = 1 then
    begin
      CancelM;
    end;

end;

procedure TfrmRckMng.Audit1;
var Msg:String;
    Params:TftParamList;
begin
  inherited;
  if cdsBrowser.IsEmpty then  Exit;
  if not ShopGlobal.GetChkRight('13200001',4) then  Raise Exception.Create('您没有审核权限,请联系管理员!');
  //权限
  if cdsBrowser.FieldByName('CHK_DATE').AsString <> '' then
    begin
// 审核只是管理动作，不需检测上报
//      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能弃审');
      if cdsBrowser.FieldByName('CHK_USER').AsString <> Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
      if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
// 审核只是管理动作，不需检测上报
//      if Copy(cdsBrowser.FieldbyName('COMM').AsString,1,1)='1' then Raise Exception.Create('已经同步的数据不能再审核');
      if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION) <> 6 then Exit;
    end;

  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date);
      Params.ParamByName('CHK_USER').AsString := Global.UserID;
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString := cdsBrowser.FieldbyName('SHOP_ID').AsString;
      Params.ParamByName('CLSE_DATE').AsInteger := cdsBrowser.FieldbyName('CLSE_DATE').AsInteger;
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
    locked := true;
    try
      Open;
    finally
      locked := false;
    end;
{    if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
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
      end;  }
  except
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
  if not ShopGlobal.GetChkRight('22100001',3) then  Raise Exception.Create('您没有审核权限,请联系管理员!');
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
      if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
        begin
          try
            Factor.ExecSQL('update RCK_DAYS_CLOSE set CHK_DATE='''+FormatDateTime('YYYY-MM-DD',Date)+''',CHK_USER='''+Global.UserID+''',COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='''+inttostr(Global.TENANT_ID)+''' and CREA_DATE='+Db_CloseDay.FieldbyName('CREA_DATE').AsString);
            actAudit.Caption := '弃审';
          Except
            actAudit.Caption := '审核';
          end;
        end
      else
        begin
          try
            Factor.ExecSQL('update RCK_DAYS_CLOSE set CHK_DATE=null,CHK_USER=null,COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='''+inttostr(Global.TENANT_ID)+''' and CREA_DATE='+Db_CloseDay.FieldbyName('CREA_DATE').AsString);
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
  if not ShopGlobal.GetChkRight('22200001',3) then  Raise Exception.Create('您没有审核权限,请联系管理员!');
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
      if cdsBrowser.FieldByName('CHK_DATE').AsString = '' then
        begin
          try
            Factor.ExecSQL('update RCK_MONTH_CLOSE set CHK_DATE='''+formatDatetime('YYYY-MM-DD',date())+''',CHK_USER='''+Global.UserID+''',COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='''+inttostr(Global.TENANT_ID)+''' and MONTH='+Db_CloseMonth.FieldbyName('MONTH').AsString);
            actAudit.Caption := '弃审';
          Except
            actAudit.Caption := '审核';
          end;
        end
      else
        begin
          try
            Factor.ExecSQL('update RCK_MONTH_CLOSE set CHK_DATE=null,CHK_USER=null,COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='''+inttostr(Global.TENANT_ID)+''' and MONTH='+Db_CloseMonth.FieldbyName('MONTH').AsString);
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
  else if RzPage.TabIndex = 2 then
    begin
      Audit2;
    end
  else if RzPage.TabIndex = 1 then
    begin
      Audit3;
    end;
end;

procedure TfrmRckMng.CancelD;
var
  rs:TZQuery;
  d,r:integer;
begin
  if not ShopGlobal.GetChkRight('22100001',2) then  Raise Exception.Create('您没有撤消权限,请联系管理员!');
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    if rs.Fields[0].AsString = '' then Raise Exception.Create('没有找到结账记录不能完成结账操作...');
    if MessageBox(Handle,pchar('是否撤消'+formatFloat('0000-00-00',rs.Fields[0].AsInteger)+'号的日结账操作？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    d := rs.Fields[0].AsInteger;
    rs.Close;
    rs.SQL.Text := 'select COMM,CHK_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := d;
    Factor.Open(rs);
    if rs.Fields[1].AsString <> '' then Raise Exception.Create(formatFloat('0000-00-00',d)+'号的结账记录已经审核不能撤消。');
    if copy(rs.Fields[0].AsString,1,1)='1' then Raise Exception.Create(formatFloat('0000-00-00',d)+'号的结账记录已经上报不能撤消。');
    r := Factor.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+inttostr(d)+'');
    MessageBox(Handle,'撤消结账记录成完','友情提示',MB_OK+MB_ICONINFORMATION);
    Open;
  finally
    rs.Free;
  end;
end;

procedure TfrmRckMng.CancelM;
var
  rs:TZQuery;
  d,r,b,e:integer;
begin
  if not ShopGlobal.GetChkRight('22200001',2) then  Raise Exception.Create('您没有撤消权限,请联系管理员!');
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(MONTH) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    if rs.Fields[0].AsString = '' then Raise Exception.Create('没有找到结账记录不能完成结账操作...');
    if MessageBox(Handle,pchar('是否撤消'+formatFloat('0000-00',rs.Fields[0].AsInteger)+'月的月结账操作？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    d := rs.Fields[0].AsInteger;
    rs.Close;
    rs.SQL.Text := 'select COMM,CHK_DATE,BEGIN_DATE,END_DATE from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH=:MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('MONTH').AsInteger := d;
    Factor.Open(rs);
    if rs.Fields[1].AsString <> '' then Raise Exception.Create(formatFloat('0000-00',d)+'月的结账记录已经审核不能撤消。');
    if copy(rs.Fields[0].AsString,1,1)='1' then Raise Exception.Create(formatFloat('0000-00',d)+'月的结账记录已经上报不能撤消。');
    b := StrtoInt(formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.Fields[2].asString)) );
    e := StrtoInt(formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.Fields[3].asString)) );
    Factor.BeginTrans;
    try
      r := Factor.ExecSQL('delete from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MONTH>='+inttostr(d)+'');
      r := Factor.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE>='+inttostr(b)+' and CREA_DATE<='+inttostr(e)+'');
      Factor.CommitTrans;
    except
      Factor.RollbackTrans;
      Raise;
    end;
    MessageBox(Handle,'撤消结账记录成完','友情提示',MB_OK+MB_ICONINFORMATION); 
    Open;
  finally
    rs.Free;
  end;
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
  case RzPage.ActivePageIndex of
    0:begin
      if cdsBrowser.IsEmpty then
        actAudit.Caption:='审核'
      else
        if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='弃审'
        else
          actAudit.Caption:='审核';
      ToolButton3.Enabled := True;
    end;
    1:begin
      if Db_CloseDay.IsEmpty then
        actAudit.Caption:='审核'
      else
        if Db_CloseDay.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='弃审'
        else
          actAudit.Caption:='审核';
      ToolButton3.Enabled := False;
    end;
    2:begin
      if Db_CloseMonth.IsEmpty then
        actAudit.Caption:='审核'
      else
        if Db_CloseMonth.FieldByName('CHK_USER_TEXT').AsString<>'' then
          actAudit.Caption:='弃审'
        else
          actAudit.Caption:='审核';
      ToolButton3.Enabled := False;          
    end;
  end;
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

procedure TfrmRckMng.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       TfrmCostCalc.StartCalc(self);
  finally
    rs.Free;
  end;
end;

procedure TfrmRckMng.Db_CloseDayAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Db_CloseDay.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='弃审'
  else
    actAudit.Caption:='审核';
end;

procedure TfrmRckMng.Db_CloseMonthAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Db_CloseMonth.FieldByName('CHK_USER_TEXT').AsString<>'' then
    actAudit.Caption:='弃审'
  else
    actAudit.Caption:='审核';
end;

procedure TfrmRckMng.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then Exit;
  if cdsBrowser.IsEmpty then Exit;

  if not ShopGlobal.GetChkRight('13200001',5) then  Raise Exception.Create('您没有打印权限,请联系管理员!');
  if cdsBrowser.FieldByName('FLAG').AsInteger = 1 then
    begin
      if MessageBox(Handle,Pchar('是否打印小票!'),Pchar(Caption),MB_YESNO+MB_ICONQUESTION)=6 then
         TfrmTicketPrint.ShowTicketPrint(Self,2,cdsBrowser.FieldbyName('CLSE_DATE').AsString);
    end
  else if cdsBrowser.FieldByName('FLAG').AsInteger = 3 then
    begin
      if MessageBox(Handle,Pchar('是否打印小票!'),Pchar(Caption),MB_YESNO+MB_ICONQUESTION)=6 then
         TfrmTicketPrint.ShowTicketPrint(Self,1,cdsBrowser.FieldbyName('CLSE_DATE').AsString);
    end;

end;

procedure TfrmRckMng.FormDestroy(Sender: TObject);
begin
  VPay.Free;
  inherited;

end;

end.






