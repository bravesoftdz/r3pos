unit ufrmShopInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,
  RzPanel, Grids, DBGridEh, RzTabs, StdCtrls, RzLabel, cxControls,
  cxContainer, ADODB,cxEdit, cxTextEdit, RzButton, ZBase, DB, DBClient,
  RzTreeVw, FR_Class, jpeg, PrnDbgeh, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmShopInfoList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    dsBrowser: TDataSource;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    cdsBrowser: TZQuery;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actEditExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    locked:Boolean;
    function CheckCanExport:Boolean;
  public
    { Public declarations }
    function FindColumn(FieldName:String):TColumnEh;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function  PrintSQL:string;
  end;

implementation
uses ufrmShopInfo, uGlobal,uTreeUtil,uShopGlobal,uCtrlUtil,ufrmEhLibReport,ufrmShopMain,
  ufrmBasic;//
{$R *.dfm}

procedure TfrmShopInfoList.AddRecord(AObj: TRecord_);
begin
  if not cdsBrowser.Active  then exit;
  if cdsBrowser.Locate('SHOP_ID',AObj.FieldByName('SHOP_ID').AsString,[]) then
  begin
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.CommitUpdates;
  end
  else
  begin
     //SHOP_ID:=AObj.FieldByName('SHOP_ID').AsString;
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.CommitUpdates;
  end;

end;

procedure TfrmShopInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',2) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  with TfrmShopInfo.Create(self) do
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

procedure TfrmShopInfoList.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(str:string);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('CA_SHOP_INFO');
    Temp.Filtered :=false;
    if Temp.Locate('SHOP_ID',str,[]) then
    begin
      Temp.Delete;
      //Temp.UpdateBatch(arAll);
    end;
  end;
var i:integer;
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('31100001',4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  i:=MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    if cdsBrowser.FieldbyName('SHOP_ID').AsString = Global.SHOP_ID then Raise Exception.Create('����ɾ��ǰ��¼���ŵ�����');
    try
      cdsBrowser.Delete;
      Factor.UpdateBatch(cdsBrowser,'TShop');
      UpdateToGlobal(cdsBrowser.FieldByName('SHOP_ID').AsString);
    Except
      cdsBrowser.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmShopInfoList.actFindExecute(Sender: TObject);
var str:String;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',1) then Raise Exception.Create('��û�в�ѯ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');  
  if edtKey.Text<>'' then
     str:= ' and (SHOP_ID like ''%'+trim(edtKEY.Text)+'%'' or SHOP_NAME like ''%'+trim(edtKEY.Text)+'%'' or SHOP_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  cdsBrowser.Close;
  cdsBrowser.SQL.Text:='select SHOP_ID,LICENSE_CODE,SHOP_NAME,SHOP_SPELL,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REGION_ID,SHOP_TYPE'+
  ',REMARK,SEQ_NO from CA_SHOP_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and COMM not in (''02'',''12'') '+str+' order by SEQ_NO';
  Factor.Open(cdsBrowser);
end;

procedure TfrmShopInfoList.InitGrid;
var rs,temp:TZQuery;
  Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_REGION_INFO');
  Column := FindColumn('REGION_ID');
  if Column <> nil then
    begin
      rs.First;
      while not rs.Eof do
        begin
          Column.KeyList.Add(rs.Fields[0].AsString);
          Column.PickList.Add(rs.Fields[1].AsString);
          rs.Next;
        end;
    end;
    try
      temp := TZQuery.Create(nil);
      temp.Close;
      temp.SQL.Text := 'select * from(select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where CODE_TYPE=''12'' '+
                       'union all '+
                       'select ''#'' as CODE_ID,''��'' as CODE_NAME,''W'' as CODE_SPELL) A';
      Factor.Open(temp);
      Column := FindColumn('SHOP_TYPE');
      if Column <> nil then
        begin
          temp.First;
          while not temp.Eof do
            begin
              Column.KeyList.Add(temp.Fields[0].AsString);
              Column.PickList.Add(temp.Fields[1].AsString );
              temp.Next;
            end;
        end;
    finally
      temp.Free;
    end;
end;

procedure TfrmShopInfoList.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmShopInfoList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  with TfrmShopInfo.Create(self) do
    begin
      try
        //OnSave := AddRecord;
        //Ҫ���Ȩ��
        Open(cdsBrowser.FieldByName('SHOP_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmShopInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmShopInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmShopInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  with TfrmShopInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //Ҫ���Ȩ��
        Edit(cdsBrowser.FieldByName('SHOP_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmShopInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmShopInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  TDbGridEhSort.InitForm(self);    
end;

procedure TfrmShopInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='1'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(cdsBrowser.RecordCount)+'��';
end;

procedure TfrmShopInfoList.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then actEditExecute(nil);
end;

procedure TfrmShopInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',5) then
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

function TfrmShopInfoList.PrintSQL: string;
var str:String;
begin

  // ���´�SQL��Ҫ�������
  if edtKey.Text<>'' then
     str:= ' and (A.SHOP_ID like ''%'+trim(edtKEY.Text)+'%'' or A.SHOP_NAME like ''%'+trim(edtKEY.Text)+'%'' or A.SHOP_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  Result:='Select SHOP_ID,SHOP_NAME,SHOP_SPELL,LICENSE_CODE,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,'+
  'REGION_ID,SHOP_TYPE,SEQ_NO From CA_SHOP_INFO where TENANT_ID=1000001 and COMM not in (''12'',''02'') '+str+' order by SEQ_NO';
end;

procedure TfrmShopInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31100001',5) then Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;  
end;

function TfrmShopInfoList.FindColumn(FieldName: String): TColumnEh;
var i: Integer;
begin
  Result := nil;
  for i:= 0 to DBGridEh1.Columns.Count - 1 do
    begin
      if DBGridEh1.Columns[i].FieldName = FieldName then
        begin
          Result := DBGridEh1.Columns[i];
          Break;
        end;
    end;
end;

procedure TfrmShopInfoList.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(Self);
end;

function TfrmShopInfoList.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('31500001',6);
end;

end.
