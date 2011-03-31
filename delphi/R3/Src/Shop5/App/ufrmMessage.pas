unit ufrmMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, ZBase,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, cxButtonEdit, zrComboBoxList,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  RzButton, Grids, DBGridEh, RzTreeVw, cxCalendar, RzBmpBtn, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmMessage = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel7: TRzPanel;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    stbPanel: TPanel;
    Label1: TLabel;
    Grid: TDBGridEh;
    RzPanel9: TRzPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label12: TLabel;
    btnOk: TRzBitBtn;
    edtSHOP_ID: TzrComboBoxList;
    edtISSUE_USER: TzrComboBoxList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    edtISSUE_DATE: TcxDateEdit;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    cds_Message: TZQuery;
    dsMessage: TDataSource;
    cdsShopList: TZQuery;
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cds_MessageAfterScroll(DataSet: TDataSet);
    procedure GridDblClick(Sender: TObject);
    procedure GridCellClick(Column: TColumnEh);
  private
    { Private declarations }
    MSG_Tpye:String;
  public
    { Public declarations }
    function EnSql:String;
    procedure AddRecord(_Aobj:TRecord_);
    procedure Open;
    procedure OpenCdsShopList;
  end;

implementation
uses uShopUtil, uShopGlobal, uGlobal, uDsUtil, ufrmBasic, ufrmMessageInfo, ufrmPublishMessage,
uframeSelectCompany;
{$R *.dfm}

{ TfrmMessage }

procedure TfrmMessage.AddRecord(_Aobj: TRecord_);
begin
  if not cds_Message.Active  then exit;
  if cds_Message.Locate('MSG_ID',_Aobj.FieldByName('MSG_ID').AsString,[]) then
  begin
     cds_Message.Edit;
     _Aobj.WriteToDataSet(cds_Message,false);
     cds_Message.Post;
  end
  else
  begin
     cds_Message.Append;
     _Aobj.WriteToDataSet(cds_Message,false);
     cds_Message.Post;
  end;
end;

function TfrmMessage.EnSql: String;
var Str,Str_where:String;
begin
  if MSG_Tpye <> '' then
    Str_where := ' and MSG_CLASS='+QuotedStr(MSG_Tpye);
  if edtISSUE_DATE.Text <> '' then
    Str_where := Str_where + ' and ISSUE_DATE <= '+FormatDateTime('YYYYMMDD',edtISSUE_DATE.Date);
  if edtSHOP_ID.Text <> '' then
    Str_where := Str_where + ' and SHOP_ID=' + QuotedStr(edtSHOP_ID.AsString);
  if edtISSUE_USER.Text <> '' then
    Str_where := Str_where + ' and ISSUE_USER=' + QuotedStr(edtISSUE_USER.AsString);

  Str :=
  'select jb.*,b.USER_NAME as ISSUE_USER_TEXT,'''' as LOOK from( '+
  'select ja.*,a.SHOP_NAME as SHOP_ID_TEXT from( '+
  'select TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,SHOP_ID,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM from MSC_MESSAGE '+
  ' where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+Str_where+' ) ja '+
  ' left join CA_SHOP_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.SHOP_ID=a.SHOP_ID) jb '+
  ' left join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and b.USER_ID=jb.ISSUE_USER';

  Result := Str;
end;

procedure TfrmMessage.Open;
begin
  cds_Message.Close;
  cds_Message.SQL.Text := EnSql;
  Factor.Open(cds_Message);

end;

procedure TfrmMessage.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '0';
  Open;
end;

procedure TfrmMessage.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '1';
  Open;
end;

procedure TfrmMessage.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '2';
  Open;
end;

procedure TfrmMessage.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '3';
  Open;
end;

procedure TfrmMessage.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '4';
  Open;
end;

procedure TfrmMessage.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmMessageInfo.Create(self) do
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

procedure TfrmMessage.actDeleteExecute(Sender: TObject);
var i:Integer;
begin
  inherited;
  if (Not cds_Message.Active) then Exit;
  if (cds_Message.RecordCount = 0) then Exit;
  if not ShopGlobal.GetChkRight('31500001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  if not cdsShopList.IsEmpty then Raise Exception.Create('此条消息已经发布,不能删除!'); 
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    try
      cds_Message.Delete;
      Factor.UpdateBatch(cds_Message,'TMessage');
    Except
      Raise;
    end;
  end;
end;

procedure TfrmMessage.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cds_Message.Active) then Exit;
  if (cds_Message.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('31500001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  with TfrmMessageInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(cds_Message.FieldByName('MSG_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;


procedure TfrmMessage.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMessage.actPrintExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMessage.actPreviewExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMessage.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not cds_Message.Active then exit;
  if cds_Message.IsEmpty then exit;
  with TfrmMessageInfo.Create(self) do
    begin
      try
        Open(cds_Message.FieldByName('MSG_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmMessage.FormCreate(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '';
  edtISSUE_DATE.Date := Global.SysDate;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtISSUE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
end;

procedure TfrmMessage.FormShow(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHORT_TENANT_NAME;
  edtISSUE_USER.KeyValue := Global.UserID;
  edtISSUE_USER.Text := Global.UserName;
  Open;
end;

procedure TfrmMessage.actFindExecute(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmMessage.actAuditExecute(Sender: TObject);
var i:integer;
    curID: string;
    rs:TRecordList;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('500014') then Raise Exception.Create('只有拥有促销单添加权限才能添加门店,请和管理员联系.');
  if cds_Message.FieldByName('MSG_ID').AsString = '' then Exit;
  OpenCdsShopList;
  rs := TRecordList.Create;
  try
    if TframeSelectCompany.PrcCompList(self,true,rs) then
    begin
      for i:=0 to rs.Count -1 do
      begin
        cdsShopList.Append;
        cdsShopList.FieldByName('MSG_ID').AsString:=cds_Message.FieldbyName('MSG_ID').AsString;
        cdsShopList.FieldByName('SHOP_ID').AsString:=rs.Records[i].fieldbyName('SHOP_ID').AsString; //门号店
        cdsShopList.FieldByName('TENANT_ID').AsInteger:=rs.Records[i].FieldByName('TENANT_ID').AsInteger;
        cdsShopList.Post;
      end;
    end;
    if not cdsShopList.IsEmpty then
      begin
        try
          Factor.UpdateBatch(cdsShopList,'TPublishMessage');
        except
          Raise Exception.Create('信息发布失败!');
        end;
        MessageBox(Handle,pchar('信息发布成功!'),pchar('友情提示..'),MB_OK);
      end;
  finally
    rs.Free;
  end;

end;

procedure TfrmMessage.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if (Rect.Top = Grid.CellRect(Grid.Col, Grid.Row).Top) and (not
    (gdFocused in State) or not Grid.Focused) then
  begin
    Grid.Canvas.Brush.Color := clAqua;
  end;
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      Grid.canvas.FillRect(ARect);
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(cds_Message.RecNo)),length(Inttostr(cds_Message.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if Column.FieldName = 'LOOK' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(Grid.Canvas.Font);
      try
        Grid.canvas.FillRect(ARect);
        Grid.Canvas.Font.Color := clBlue;
        Grid.Canvas.Font.Style := [fsUnderline];
        DrawText(Grid.Canvas.Handle,pchar('查看门店'),length('查看门店'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      finally
        Grid.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
end;

procedure TfrmMessage.OpenCdsShopList;
begin
  cdsShopList.Close;
  cdsShopList.SQL.Text := ' select TENANT_ID,MSG_ID,SHOP_ID,COMM,TIME_STAMP from MSC_MESSAGE_LIST where 1<>1 ';
  Factor.Open(cdsShopList);
end;

procedure TfrmMessage.cds_MessageAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cds_Message.RecNo<=0 then  str:='0'
  else str:=IntToStr(cds_Message.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cds_Message.RecordCount)+'条';
end;

procedure TfrmMessage.GridDblClick(Sender: TObject);
begin
  inherited;
  if Grid.Columns[Grid.SelectedIndex].FieldName<>'LOOK' then
    actInfoExecute(Sender);
end;

procedure TfrmMessage.GridCellClick(Column: TColumnEh);
begin
  inherited;
  if cds_Message.IsEmpty then Exit;

  if Column.FieldName = 'LOOK' then
    TfrmPublishMessage.PrcCompList(Self,cds_Message.FieldbyName('MSG_ID').AsString);


end;

end.
