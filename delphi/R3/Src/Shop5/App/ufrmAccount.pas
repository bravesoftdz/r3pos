{  21100001	0	�����˻�  1	��ѯ	2	����	3	�޸�	4	ɾ��	5	��ӡ	6	����  }
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
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function  CheckCanExport: boolean; override;
  public
    procedure AddRecord(AObj:TRecord_);
    procedure IniGrid;
    { Public declarations }
  end;

implementation
uses ufrmAccountInfo, uGlobal,uTreeUtil,uShopGlobal,ufrmFastReport,ufrmEhLibReport,
  ufrmBasic;
{$R *.dfm}

procedure TfrmAccount.actNewExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then Exit;
  if not ShopGlobal.GetChkRight('21100001',2) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
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
var IsHeadShop:String;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',1) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if Global.SHOP_ID = IntToStr(Global.TENANT_ID)+'0001' then
    IsHeadShop := ''
  else
    IsHeadShop := ' and SHOP_ID='+Global.SHOP_ID;
  if edtKey.Text<>'' then
     IsHeadShop := ' and (ACCT_NAME like ''%'+trim(edtKEY.Text)+'%'' or ACCT_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  cdsBrowser.Close;
  cdsBrowser.SQL.Text :=
  'select ja.*,'+
  'case ja.PAYM_ID '+
  'when ''A'' then ja.ACCT_NAME+''<''+a.SHOP_NAME+''>'' '+
  'else  ja.ACCT_NAME '+
  'end as ACCT_NAME_TEXT from '+
  '(select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE '+
  'from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+IsHeadShop+
  ' ) ja left outer join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.SHOP_ID=a.SHOP_ID';

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
    DBGridEh1.Canvas.Brush.Color := clAqua;
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
     cdsBrowser.FieldByName('ACCT_NAME_TEXT').AsString := cdsBrowser.FieldbyName('ACCT_NAME').AsString;
     cdsBrowser.Post;
  end
  else
  begin
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.FieldByName('ACCT_NAME_TEXT').AsString := cdsBrowser.FieldbyName('ACCT_NAME').AsString;
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

procedure TfrmAccount.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) and (cdsBrowser.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('21100001',3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if cdsBrowser.FieldByName('PAYM_ID').AsString = 'A' then Raise Exception.Create('�ֽ��˻������޸�!');
  with TfrmAccountInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
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
        //Ҫ���Ȩ��
        Open(cdsBrowser.FieldByName('ACCOUNT_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
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
      Temp.Delete;
  end;
begin
  inherited;
  if (not cdsBrowser.Active) and (cdsBrowser.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('21100001',4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if cdsBrowser.FieldByName('PAYM_ID').AsString = 'A' then Raise Exception.Create('�ֽ��˻�������ɾ��');
  {if (cdsBrowser.FieldByName('IN_MNY').AsString > 0) or (cdsBrowser.FieldByName('OUT_MNY').AsString > 0) then
    MessageBox(Handle,pchar('��������б䶯,��ȷ���Ƿ�Ҫɾ��!'),pchar(Caption),MB_OKCANCEL+MB_ICONQUESTION);}

  if MessageBox(Handle,Pchar('ȷ��Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1)=6 then
  begin
    try
      cdsBrowser.CommitUpdates;
      UpdateToGlobal(cdsBrowser.FieldByName('ACCOUNT_ID').AsString);
      cdsBrowser.Delete;
      Factor.UpdateBatch(cdsBrowser,'TAccount');
    Except
      cdsBrowser.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmAccount.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',5) then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmAccount.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',5) then
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

function TfrmAccount.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('21100001',6);  //�����Ƿ񵼳�Grid
end;

end.
