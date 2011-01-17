unit ufrmRoleInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ExtCtrls, ComCtrls, RzTreeVw, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, ActnList, Menus, ToolWin,
  StdCtrls, RzLabel, RzTabs, RzPanel, DB, ADODB, zBase, RzButton,
  jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset, PrnDbgeh;

type
  TfrmRoleInfoList = class(TframeToolForm)
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    DataSource1: TDataSource;
    ToolButton11: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    actRIGHTS: TAction;
    PopupMenu2: TPopupMenu;
    N2: TMenuItem;
    actRIGHTS1: TAction;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    cdsBrowser: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure actFindExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure actRIGHTSExecute(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    { Private declarations }
  public
    locked, IsCompany : boolean;
    procedure AddRecord(AObj:TRecord_);
    { Public declarations }
  end;

 

implementation

uses uGlobal,uTreeUtil,uShopGlobal,ufrmRoleInfo,ufrmEhLibReport;

{$R *.dfm}

procedure TfrmRoleInfoList.actFindExecute(Sender: TObject);
var
  str:String;
begin
  inherited;  
  if edtKey.Text<>'' then
     str:=' and (ROLE_ID like ''%'+trim(edtKEY.Text)+'%'' or ROLE_NAME like ''%'+trim(edtKEY.Text)+'%'' or ROLE_SPELL like ''%'+trim(edtKEY.Text)+'%'') ';
  str:='Select ROLE_ID,ROLE_NAME,ROLE_SPELL,TENANT_ID,REMARK  '+
                       ' From CA_ROLE_INFO where COMM not in (''02'',''12'') '+str+' order by ROLE_ID ';
  cdsBrowser.Close;
  cdsBrowser.Filter:='';
  cdsBrowser.SQL.Text:=str;
  Factor.Open(cdsBrowser);
end;

procedure TfrmRoleInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmRoleInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  //if not IsCompany then  raise Exception.Create('不是总店，不能新增职务!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增职务的权限,请和管理员联系.');
  with TfrmRoleInfo.Create(self) do
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

procedure TfrmRoleInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmRoleInfo.Create(self) do
  begin
    try
     OnSave := AddRecord;
     //要检查权限
     if not IsCompany then
       Open(cdsBrowser.FieldByName('ROLE_ID').AsString)
     else
       Edit(cdsBrowser.FieldByName('ROLE_ID').AsString);
     ShowModal;
    finally
     free;
    end;
  end;
end;

procedure TfrmRoleInfoList.actDeleteExecute(Sender: TObject);
procedure UpdateToGlobal(str:string);
var Temp:TZQuery;
begin
  Temp := Global.GetZQueryFromName('CA_ROLE_INFO');
  Temp.Filtered :=false;
  if Temp.Locate('ROLE_ID',str,[]) then
  begin
    Temp.Delete;
    Temp.CommitUpdates;
  end;
end;
var Params:TftParamList;
    i:integer;
    rzNode:TTreeNode;
    tmp:TADODataSet;
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  //if not IsCompany then raise Exception.Create('不是总店，不能删除职务!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      //Params.ParamByName('DUTY_ID',True).asString:=cdsBrowser.FieldByName('DUTY_ID').AsString;
      //Params.ParamByName('DUTY_NAME',True).asString:=cdsBrowser.FieldByName('DUTY_NAME').AsString;
      Params.ParamByName('ROLE_ID').asString:=cdsBrowser.FieldByName('ROLE_ID').AsString;
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Factor.ExecProc('TRoleInfoDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(cdsBrowser.FieldByName('ROLE_ID').AsString);
    cdsBrowser.Delete;
  end;
end;

procedure TfrmRoleInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmRoleInfoList.edtKeyPropertiesChange(Sender: TObject);
var
  FilterCnd: string;
begin
  inherited;
  Locked:=True;
  try
    FilterCnd:=' ROLE_ID like ''%'+trim(edtKEY.Text)+'%'' or ROLE_NAME like ''%'+trim(edtKEY.Text)+
               '%'' or ROLE_SPELL like ''%'+trim(edtKEY.Text)+'%'' ';
    cdsBrowser.Filtered := false;
    cdsBrowser.Filter :=FilterCnd;
    cdsBrowser.Filtered :=(trim(edtKEY.Text)<>'');
  finally
    locked:=False;
  end;
end;

procedure TfrmRoleInfoList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  actFindExecute(nil);
end;

procedure TfrmRoleInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  if locked then exit;
  locked := true;
  try
   if edtKey.Text<>'' then edtKey.Text:='';
  finally
    locked := false;
  end;
end;

procedure TfrmRoleInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmRoleInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmRoleInfoList.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmRoleInfoList.actInfoExecute(Sender: TObject);
begin
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmRoleInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      //要检查权限
      Open(cdsBrowser.FieldByName('ROLE_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmRoleInfoList.AddRecord(AObj: TRecord_);
var
  str,ROLE_ID:string;
begin
  if not cdsBrowser.Active  then exit;
  if cdsBrowser.Locate('ROLE_ID',AObj.FieldByName('ROLE_ID').AsString,[]) then
  begin
     ROLE_ID:=cdsBrowser.FieldByName('ROLE_ID').AsString;
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end else
  begin
     ROLE_ID:=AObj.FieldByName('ROLE_ID').AsString;
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end;
  if cdsBrowser.Locate('ROLE_ID',ROLE_ID,[]) then ;
end;

procedure TfrmRoleInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  //判断是否为公司总店
  //ShopGlobal.GetIsCompany(Global.UserID);
  IsCompany:=true; //
end;

procedure TfrmRoleInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmRoleInfoList.actRIGHTSExecute(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  if not IsCompany then  Raise Exception.Create('不是总店,你没有授权'+Caption+'的权限.');
  if not ShopGlobal.GetChkRight('100013') then Raise Exception.Create('你没有授权'+Caption+'的权限,请和管理员联系.');

 {with TfrmDutyRights.Create(self) do
  begin
    try
      Open(cdsBrowser.FieldByName('DUTY_ID').AsString,cdsBrowser.FieldByName('DUTY_NAME').AsString,cdsBrowser.FieldByName('REMARK').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
  }
end;

procedure TfrmRoleInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cdsBrowser.RecordCount)+'条';
end;

procedure TfrmRoleInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100014') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');

  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmRoleInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
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

end.
