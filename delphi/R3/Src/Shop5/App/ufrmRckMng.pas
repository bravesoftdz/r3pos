unit ufrmRckMng;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, RzButton,ZBase, DB, RzTreeVw,
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

  private
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    pid:string;
    locked:boolean;
    procedure InitGrid;
    function EncodeSQL(id:string;var w:string):string;
    procedure Open(Id:string);
  end;

implementation
uses uGlobal, uFnUtil, ufrmFastReport, uDsUtil, uShopUtil, uShopGlobal, uCtrlUtil;
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
var strSql:string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('日期条件不能为空');

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+strSql+') jp order by IORO_ID';
  4:result :=
       'select * from ('+
       'select * from ('+strSql+') order by IORO_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+strSql+') order by IORO_ID limit 600';
  else
    result := 'select * from ('+strSql+') order by IORO_ID';
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
    MaxId := rs.FieldbyName('IORO_ID').AsString;
    if Id='' then
       begin
         rs.SaveToStream(sm);
         cdsBrowser.LoadFromStream(sm);
         cdsBrowser.IndexFieldNames := 'GLIDE_NO';
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
  if IsEnd or not DataSet.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);
  if cdsBrowSer.FieldByName('CHK_USER_TEXT').AsString<>'' then
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
begin
  InitGridPickList(DBGridEh1);
end;

procedure TfrmRckMng.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndSHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  fndCREA_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  fndSTATUS.ItemIndex := 0;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmRckMng.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
  if not cdsBrowser.IsEmpty then
  begin
    if cdsBrowser.FieldByName('CHK_USER_TEXT').AsString<>'' then
      actAudit.Caption:='弃审'
    else
      actAudit.Caption:='审核';
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

end.
