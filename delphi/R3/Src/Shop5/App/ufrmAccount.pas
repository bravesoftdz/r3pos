unit ufrmAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ToolWin, ComCtrls, StdCtrls,RzLabel,
  RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzButton,cxControls, cxContainer,
  cxEdit, cxTextEdit, DB, zBase, FR_Class,jpeg, PrnDbgeh, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmAccount = class(TframeToolForm)
    ToolButton1: TToolButton;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    dsBrowser: TDataSource;
    stbPanel: TPanel;
    Label2: TLabel;
    PrintDBGridEh1: TPrintDBGridEh;
    cdsBrowser: TZQuery;
    procedure actNewExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddRecord(AObj:TRecord_);
    procedure IniGrid;
    { Public declarations }
  end;

implementation
uses ufrmAccountInfo, uGlobal,uTreeUtil,uShopGlobal,ufrmFastReport,ufrmEhLibReport;
{$R *.dfm}

procedure TfrmAccount.actNewExecute(Sender: TObject);
begin
  inherited;
  with TfrmAccountInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append;
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmAccount.actFindExecute(Sender: TObject);
begin
  inherited;
  cdsBrowser.Close;
  cdsBrowser.SQL.Text :='select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE '+
  'from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+Global.SHOP_ID;
  Factor.Open(cdsBrowser);
end;

procedure TfrmAccount.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  edtKey.SetFocus;
end;

procedure TfrmAccount.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clHighlight;
  end;
  
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmAccount.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmAccount.AddRecord(AObj: TRecord_);
begin
  if not cdsBrowser.Active  then exit;
  if cdsBrowser.Locate('ACCOUNT_ID',AObj.FieldByName('ACCOUNT_ID').AsString,[]) then
  begin
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end
  else
  begin
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end;
  if cdsBrowser.Locate('ACCOUNT_ID',AObj.FieldByName('ACCOUNT_ID').AsString,[]) then;
end;

procedure TfrmAccount.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmAccount.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  cdsBrowser.Filtered:=False;
  cdsBrowser.Filter:='ACCT_NAME LIKE '+'%'+trim(edtKey.Text)+'%'+' or ACCT_SPELL LIKE '+'%'+trim(edtKey.Text)+'%';
  cdsBrowser.Filtered:=(trim(edtKey.Text)<>'');
end;


procedure TfrmAccount.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) and (cdsBrowser.IsEmpty) then exit;
  with TfrmAccountInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
        //Open(cdsBrowser.FieldByName('COMP_ID').AsString);
        Edit(cdsBrowser.FieldByName('ACCOUNT_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmAccount.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) and (cdsBrowser.IsEmpty) then exit;
  with TfrmAccountInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
        Open(cdsBrowser.FieldByName('ACCOUNT_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmAccount.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmAccount.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='1'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(cdsBrowser.RecordCount)+'��';
end;

procedure TfrmAccount.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(str:string);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
    Temp.Filtered :=false;
    if Temp.Locate('ACCOUNT_ID',str,[]) then
    begin
      Temp.Delete;
      //Temp.UpdateBatch(arAll);
    end;
  end;
var Params:TftParamList;
    i:integer;
begin
  inherited;
  if (not cdsBrowser.Active) and (cdsBrowser.IsEmpty) then exit;
  i:=MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('ACCOUNT_ID').asString:=cdsBrowser.FieldByName('ACCOUNT_ID').AsString;
      Factor.ExecProc('TAccountDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(cdsBrowser.FieldByName('ACCOUNT_ID').AsString);
    cdsBrowser.Delete;
  end;
end;

procedure TfrmAccount.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700040') then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmAccount.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('700040') then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end; 
end;

procedure TfrmAccount.IniGrid;
var Temp: TZQuery;
begin
  Temp := Global.GetZQueryFromName('PUB_PAYMENT');
  DBGridEh1.FieldColumns['PAYM_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['PAYM_ID'].PickList.Clear;
  Temp.First;
  while not Temp.Eof do
    begin
      DBGridEh1.FieldColumns['PAYM_ID'].KeyList.Add(Temp.Fields[0].AsString);
      DBGridEh1.FieldColumns['PAYM_ID'].PickList.Add(Temp.Fields[1].AsString);
      Temp.Next;
    end;
end;

procedure TfrmAccount.FormCreate(Sender: TObject);
begin
  inherited;
  IniGrid;
end;

end.
