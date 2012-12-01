unit ufrmLocationInfoList;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,
  RzPanel, Grids, DBGridEh, RzTabs, StdCtrls, RzLabel, cxControls,
  cxContainer, ADODB,cxEdit, cxTextEdit, RzButton, ZBase, DB, DBClient,
  RzTreeVw, FR_Class, jpeg, PrnDbgeh, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmLocationInfoList = class(TframeToolForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    cdsBrowser: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    dsBrowser: TDataSource;
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);

    procedure actExitExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actDeleteExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    

   


  private
    { Private declarations }
    procedure PrintView;
    function CheckCanExport:boolean;override;
  public
    { Public declarations }
     procedure AddRecord(AObj:TRecord_);
  end;



implementation

uses ufrmLocationInfo, uGlobal,uTreeUtil,uShopGlobal,uCtrlUtil,ufrmEhLibReport,
  ufrmBasic;//

{$R *.dfm}
procedure TfrmLocationInfoList.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '��λ����';

  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmLocationInfoList.actFindExecute(Sender: TObject);
var IsHeadShop:String;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',1) then Raise Exception.Create('��û�в�ѯ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if Global.SHOP_ID = IntToStr(Global.TENANT_ID)+'0001' then
    IsHeadShop := ' '
  else
    IsHeadShop := ' and A.SHOP_ID='''+Global.SHOP_ID+''' ';
  if edtKey.Text<>'' then
     IsHeadShop := ' and (LOCATION_ID like ''%'+trim(edtKEY.Text)+'%'' or LOCATION_NAME like ''%'+trim(edtKEY.Text)+'%'' or LOCATION_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  cdsBrowser.Close;
  cdsBrowser.SQL.Text :=
  'Select A.SHOP_ID,LOCATION_ID,B.SHOP_NAME,LOCATION_NAME,LOCATION_SPELL,A.REMARK,0 as SEQ_NO from PUB_LOCATION_INFO A left join CA_SHOP_INFO B ON A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.COMM not in (''02'',''12'') '+IsHeadShop;
  Factor.Open(cdsBrowser);
end;

procedure TfrmLocationInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmLocationInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Self.Caption := '�ֿ⵵������';
      Label1.Caption := '֧�֣�������ƴ���롢�ֿ���룩��ѯ';
      DBGridEh1.Columns[1].Title.Caption := '�ֿ����';
      DBGridEh1.Columns[2].Title.Caption := '�����ŵ�';

      RzPage.Pages[0].Caption := '�ֿ⵵����ѯ';
    end;
end;

procedure TfrmLocationInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;


procedure TfrmLocationInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002524',5) then Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintView;
  PrintDBGridEh1.Print;
end;


procedure TfrmLocationInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002524',5) then
    Raise Exception.Create('��û��Ԥ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintView;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end;
end;

procedure TfrmLocationInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(cdsBrowser.RecordCount)+'��';
end;


procedure TfrmLocationInfoList.AddRecord(AObj: TRecord_);
begin
  if not cdsBrowser.Active  then exit;
  if cdsBrowser.Locate('LOCATION_ID',AObj.FieldByName('LOCATION_ID').AsString,[]) then
  begin
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.CommitUpdates ;
  end
  else
  begin
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.CommitUpdates ;
  end;

end;




procedure TfrmLocationInfoList.actDeleteExecute(Sender: TObject);
 procedure UpdateToGlobal(str:string);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('pub_location_INFO');
    Temp.Filtered :=false;
    if Temp.Locate('location_ID',str,[]) then
    begin
      Temp.Delete;
    end;
  end;
var i:integer;
begin
  inherited;
  if (not cdsBrowser.Active) then Exception.Create('û�����ݣ�');
  if (cdsBrowser.IsEmpty) then Exception.Create('û�����ݣ�');
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('�����治�������߲���!');
  if not ShopGlobal.GetChkRight('100002524',4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  i:=MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    try
      UpdateToGlobal(cdsBrowser.FieldByName('location_ID').AsString);
      cdsBrowser.Delete;
      Factor.UpdateBatch(cdsBrowser,'Tlocation');
    Except
      cdsBrowser.CancelUpdates;
      
      Raise;
    end;
  end;
end;



procedure TfrmLocationInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('�����治�������߲���!');
  if not ShopGlobal.GetChkRight('100002524',2) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  with TfrmLocationInfo.Create(self) do
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

procedure TfrmLocationInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) then raise Exception.Create('û�����ݣ�');
  if (cdsBrowser.IsEmpty) then raise Exception.Create('û�����ݣ�');
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('�����治�������߲���!');
  if not ShopGlobal.GetChkRight('100002524',3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  with TfrmLocationInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
        Edit(cdsBrowser.FieldByName('LOCATION_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmLocationInfoList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then raise exception.create('û��ѡ�м�¼');
  with TfrmLocationInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
        Open(cdsBrowser.FieldByName('LOCATION_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

function TfrmLocationInfoList.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('100002524',6);

end;

end.
