unit ufrmUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzLabel, ComCtrls, ToolWin, DB, DBClient, ZBase, ADODB,
  FR_Class, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmUsers = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    Ds_Users: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    But_Edit: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    ToolButton4: TToolButton;
    actRights: TAction;
    btnOk: TRzBitBtn;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    frfUsers: TfrReport;
    Cds_Users: TZQuery;
    procedure actFindExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure actRightsExecute(Sender: TObject);
    procedure Cds_UsersAfterScroll(DataSet: TDataSet);
    procedure N1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    //IsCompany:Boolean;
    //ccid:string;
    { Private declarations }
  public
    { Public declarations }
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function  PrintSQL:string;    
  end;

var
  frmUsers: TfrmUsers;

implementation
uses ufrmUsersInfo, ufrmBasic, uframeDialogForm, uGlobal, uShopGlobal,uCtrlUtil;//ufrmUserRights,ufrmFastReport,
{$R *.dfm}

procedure TfrmUsers.actFindExecute(Sender: TObject);
var str:string;
begin
  inherited;
  //�������ŵ��û���������ֱӪ�ŵ���û�
  if edtKey.Text<>'' then
     str:=' and ( [USER_NAME] LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+
                  ' or A.USER_SPELL LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+' or A.ACCOUNT LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+')';
  Cds_Users.Close;
  //Cds_Users.SQL.Text:='Select A.USER_ID,A.USER_SPELL,A.DUTY_IDS,A.ACCOUNT,USER_NAME,A.SHOP_ID,C.SHOP_NAME SHOP_NAME,A.SEX,A.MOBILE,A.OFFI_TELE,A.FAMI_TELE,A.EMAIL,A.FAMI_ADDR,'
  //                 +'A.POSTALCODE,A.WORK_DATE,A.DIMI_DATE,A.DUTY_IDS,A.REMARK as REMARK,A.ID_NUMBER,A.QQ From CA_USERS A '+
  //                 ' left outer join CA_SHOP_INFO C on A.SHOP_ID=C.SHOP_ID '
  //                 +' Where A.COMM NOT IN (''02'',''12'') '+str;    //and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+ccid+''' and COMP_TYPE=2 and COMM<>''02'' and COMM<>''12'') or A.COMP_ID='''+ccid+''')'
  Cds_Users.SQL.Text:='Select A.USER_ID,A.ACCOUNT,A.ENCODE,A.USER_NAME,A.USER_SPELL,A.PASS_WRD,A.SHOP_ID,A.DEPT_ID,A.DUTY_IDS,A.DUTY_NAMES,A.ROLE_IDS,A.ROLE_NAMES,A.TENANT_ID,'+
                    'A.SEX,A.MOBILE,A.OFFI_TELE,A.FAMI_TELE,A.EMAIL,A.QQ,A.MSN,A.ID_NUMBER,A.IDN_TYPE,A.FAMI_ADDR,A.POSTALCODE,A.WORK_DATE,A.DIMI_DATE,A.REMARK From CA_USERS A '+
                   ' left outer join CA_SHOP_INFO C on A.SHOP_ID=C.SHOP_ID  '
                  +' Where A.COMM NOT IN (''02'',''12'') '+str;    //and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+ccid+''' and COMP_TYPE=2 and COMM<>''02'' and COMM<>''12'') or A.COMP_ID='''+ccid+''')'

  Factor.Open(Cds_Users);

end;

procedure TfrmUsers.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(Str:string);
  var Tmp:TZQuery;
  begin
    Tmp := Global.GetZQueryFromName('CA_USERS');
    Tmp.Filtered := false;
    if Tmp.Locate('USER_ID',Str,[]) then
    begin
      Tmp.Delete;
      Tmp.CommitUpdates;
    end;
  end;
var i:integer;
    Params:TftParamList;
begin
  inherited;
  if (Not Cds_Users.Active) or (Cds_Users.RecordCount = 0) then Exit;
  {if not ShopGlobal.GetChkRight('100019') then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');}
  i:=MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('USER_ID').asString:=Cds_Users.FieldByName('USER_ID').AsString;
      Params.ParamByName('USER_NAME').asString:=Cds_Users.FieldByName('USER_NAME').AsString;
      Factor.ExecProc('TUsersDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(Cds_Users.FieldByName('USER_ID').AsString);
    Cds_Users.Delete;
  end;
end;

procedure TfrmUsers.actNewExecute(Sender: TObject);
begin
  inherited;
  {if not ShopGlobal.GetChkRight('100017') then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');}
  with TfrmUsersInfo.Create(self) do
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

procedure TfrmUsers.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Users.Active) or (Cds_Users.IsEmpty) then exit;
  {if not ShopGlobal.GetChkRight('100018') then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');}
  with TfrmUsersInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(Cds_Users.FieldByName('USER_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmUsers.AddRecord(AObj: TRecord_);
begin
  if not Cds_Users.Active  then exit;
  if Cds_Users.Locate('USER_ID',AObj.FieldByName('USER_ID').AsString,[]) then
  begin
     Cds_Users.Edit;
     AObj.WriteToDataSet(Cds_Users,false);
     Cds_Users.Post;
  end
  else
  begin
     Cds_Users.Append;
     AObj.WriteToDataSet(Cds_Users,false);
     Cds_Users.Post;
  end;
  InitGrid;
  if Cds_Users.Locate('USER_ID',AObj.FieldByName('USER_ID').AsString,[]) then exit;
end;

procedure TfrmUsers.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  inherited;
  {IsCompany:=ShopGlobal.GetIsCompany(Global.UserID);
  ccid:=ShopGlobal.GetCOMP_ID(Global.UserID);
  if (ShopGlobal.GetIsCompany(Global.UserID)) and  (ccid<>Global.CompanyID) then
    ccid:=ccid
  else
    ccid:=Global.CompanyID; }
  InitGrid;
  TDbGridEhSort.InitForm(self);  
end;

procedure TfrmUsers.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not Cds_Users.Active then exit;
  if Cds_Users.IsEmpty then exit;
  with TfrmUsersInfo.Create(self) do
    begin
      try
        Open(Cds_Users.FieldByName('USER_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmUsers.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
begin
  inherited;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_Users.RecNo)),length(Inttostr(Cds_Users.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmUsers.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmUsers.InitGrid;
var tmp:TZQuery;
begin
  DBGridEh1.FieldColumns['SHOP_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Clear;

  tmp := Global.GetZQueryFromName('CA_SHOP_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Add(tmp.Fields[0].asstring);
    DBGridEh1.FieldColumns['SHOP_ID'].PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;
end;

procedure TfrmUsers.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
  edtKey.SetFocus;
end;

procedure TfrmUsers.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     Cds_Users.Next;
  if Key=VK_UP then
     Cds_Users.Prior;
end;

procedure TfrmUsers.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  Cds_Users.Filtered:=False;
  Cds_Users.Filter:=' [USER_NAME] LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+
                  ' or USER_SPELL LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+' or ACCOUNT LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%');
  Cds_Users.Filtered:=(edtKey.Text<>'');
end;

procedure TfrmUsers.actRightsExecute(Sender: TObject);
var str:string;
begin
  {inherited;
  if not Cds_Users.Active then exit;
  if Cds_Users.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('100020') then Raise Exception.Create('��û����Ȩ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  with TfrmUserRights.Create(self) do
  begin
    try
      Open(Cds_Users.FieldByName('USER_ID').AsString,Cds_Users.FieldByName('USER_NAME').AsString,Cds_Users.FieldByName('COMP_ID').AsString,Cds_Users.FieldByName('ACCOUNT').AsString,Cds_Users.FieldByName('DUTY_IDS').AsString);
      ShowModal;
    finally
      free;
    end;
  end;}
end;
procedure TfrmUsers.Cds_UsersAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Users.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Users.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(Cds_Users.RecordCount)+'��';
end;

procedure TfrmUsers.N1Click(Sender: TObject);
begin
  inherited;
  actRightsExecute(nil);
end;

procedure TfrmUsers.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

function TfrmUsers.PrintSQL: string;
var str:string;
begin
  inherited;
  {if edtKey.Text<>'' then
     str:=' and ( [USER_NAME] LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+
                  ' or A.USER_SPELL LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+' or A.ACCOUNT LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+')';
  Result:='Select E.DUTY_NAME as ְ��,A.ACCOUNT as �û��˺�,[USER_NAME] as �û�����,C.COMP_NAME as �����ŵ�,D.CODE_NAME as �Ա�,A.MOBILE as �ƶ��绰,A.OFFI_TELE as �칫�绰,A.FAMI_TELE as ��ͥ�绰,A.EMAIL as ��������'+
  '  From CA_USERS A  left outer join CA_COMPANY C on A.COMP_ID=C.COMP_ID   left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''SEX'')D on A.SEX=D.CODE_ID '+
  '  left outer join CA_DEPTDUTY E on A.DUTY_IDS=E.DUTY_ID ' +
  ' Where  A.COMM NOT IN (''02'',''12'')'+str;}
  // and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+ccid+''' and COMP_TYPE=2 and COMM<>''02'' and COMM<>''12'') or A.COMP_ID='''+ccid+''')'
end;

procedure TfrmUsers.actPrintExecute(Sender: TObject);
begin
  {inherited;
  if not ShopGlobal.GetChkRight('100021') then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  with TfrmFastReport.Create(Self) do
    begin
      try
        if Cds_Users.IsEmpty then Exit;
        PrintReport(PrintSQL,frfUsers);
      finally
        free;
      end;
    end;}
end;

procedure TfrmUsers.actPreviewExecute(Sender: TObject);
begin
  {inherited;
  if not ShopGlobal.GetChkRight('100021') then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
   with TfrmFastReport.Create(Self) do
    begin
      try
        if Cds_Users.IsEmpty then Exit;
        ShowReport(PrintSQL,frfUsers,nil,true);
      finally
        free;
      end;
    end; }
end;

end.
