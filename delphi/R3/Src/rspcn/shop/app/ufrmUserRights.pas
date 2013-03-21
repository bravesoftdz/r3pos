unit ufrmUserRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, StdCtrls, RzTabs,
  ZDataset, DB, ZAbstractRODataset, ZAbstractDataset, ZBase;

type
  TfrmUserRights = class(TfrmWebDialog)
    bgPanel: TRzPanel;
    RzPanel3: TRzPanel;
    RoleDataSource: TDataSource;
    cdsRoleList: TZQuery;
    RzPanel2: TRzPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    RzPanel_ROLE: TRzPanel;
    DbGridEh1: TDBGridEh;
    btnOk: TRzBmpButton;
    btnClose: TRzBmpButton;
    RzPanel10: TRzPanel;
    Photo: TImage;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    USER_ID:string;
    procedure Init(userId,userName,account,roleIds: string);
    procedure SaveRight;
    function  GetROLE_IDS: string;
    function  GetROLE_NAMES: string;
  public
    RE_ROLE_IDS: string;
    RE_ROLE_NAMES: string;
    class function ShowUserRight(userId, userName, account: string; var roleIds, roleNames:string): boolean;
    property ROLE_IDS: string read GetROLE_IDS;
    property ROLE_NAMES: string read GetROLE_NAMES;
  end;

implementation

{$R *.dfm}

uses uTokenFactory,udataFactory,udllGlobal;

function TfrmUserRights.GetROLE_IDS: string;
begin
  result:='';
  if not cdsRoleList.Active then exit;
  if cdsRoleList.State = dsEdit then cdsRoleList.Post; //ÅÐ¶ÏÊÇ·ñ±à¼­×´Ì¬²¢Post
  if (not cdsRoleList.Active) or (cdsRoleList.IsEmpty) then Exit;
  try
    cdsRoleList.DisableControls;
    cdsRoleList.First;
    while not cdsRoleList.Eof do
    begin
      if trim(cdsRoleList.fieldbyName('selflag').AsString)<>'0' then
      begin
        if result<>'' then result:=result+',';
        result:=result+cdsRoleList.fieldbyName('ROLE_ID').AsString;
      end;
      cdsRoleList.Next;
    end;
  finally
    cdsRoleList.EnableControls;
  end;
end;

function TfrmUserRights.GetROLE_NAMES: string;
begin
  result:='';
  if (not cdsRoleList.Active) or (cdsRoleList.IsEmpty) then Exit;
  try
    cdsRoleList.DisableControls;
    cdsRoleList.First;
    while not cdsRoleList.Eof do
    begin
      if trim(cdsRoleList.fieldbyName('selflag').AsString)<>'0' then
      begin
        if result<>'' then result:=result+',';
        result:=result+cdsRoleList.fieldbyName('ROLE_NAME').AsString;
      end;
      cdsRoleList.Next;
    end;
  finally
    cdsRoleList.EnableControls;
  end;
end;

procedure TfrmUserRights.Init(userId, userName, account, roleIds: string);
var Str,Cnd:string;
begin
  USER_ID:=userId;
  Label1.Caption:=userName;
  Label5.Caption:=account;
  Cnd:='select ROLE_ID as ROLE_ID1 from CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and ROLE_ID in ('''+StringReplace(roleIds,',',''',''',[rfReplaceAll])+''')';
  Str:='select (case when B.ROLE_ID1 is null then 0 else 1 end) as selflag,A.* from  '+
       ' (select ROLE_ID,ROLE_NAME,RIGHT_FORDATA,REMARK from CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')) A '+
       ' left join ('+Cnd+')B On A.ROLE_ID=B.ROLE_ID1 order by ROLE_ID ';
  cdsRoleList.Close;
  cdsRoleList.SQL.Text:=str;
  cdsRoleList.Params.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
  dataFactory.Open(cdsRoleList);
end;

procedure TfrmUserRights.SaveRight;
var Params: TftParamList;
begin
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    Params.ParamByName('USER_ID').AsString:=USER_ID;
    if ROLE_IDS <> '' then
      Params.ParamByName('ROLE_IDS').AsString:=ROLE_IDS
    else
      Params.ParamByName('ROLE_IDS').AsString:='#';
    if ROLE_NAMES <> '' then
      Params.ParamByName('ROLE_NAMES').AsString:=ROLE_NAMES
    else
      Params.ParamByName('ROLE_NAMES').AsString:='#';
    RE_ROLE_IDS:=Params.ParamByName('ROLE_IDS').AsString;
    RE_ROLE_NAMES:=Params.ParamByName('ROLE_NAMES').AsString;
    dataFactory.ExecProc('TUserRolesListV60',Params);
  finally
    Params.Free;
  end;
end;

class function TfrmUserRights.ShowUserRight(userId, userName, account: string; var roleIds, roleNames:string): boolean;
var FormObj: TfrmUserRights;
begin
  try
    FormObj := TfrmUserRights.Create(nil);
    FormObj.Init(userId, userName, account, roleIds);
    FormObj.ShowModal;
    if FormObj.ModalResult=MROK then
    begin
      roleIds := FormObj.RE_ROLE_IDS;
      roleNames := FormObj.RE_ROLE_NAMES;
      result := true;
    end;
  finally
    FreeAndNil(FormObj);
  end;
end;

procedure TfrmUserRights.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveRight;
  ModalResult:=MROK;
end;

procedure TfrmUserRights.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUserRights.FormCreate(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp') then
     Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp');
end;

end.
