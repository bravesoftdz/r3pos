unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzTabs,
  RzBmpBtn, jpeg, RzButton, cxControls, cxContainer, cxEdit, cxTextEdit,
  ComCtrls, RzPrgres, cxMaskEdit, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, msxml,
  cxDropDownEdit, cxCalendar, cxCheckBox, cxMemo, cxSpinEdit, IniFiles,
  Grids, DBGridEh, RzBckgnd, RzBorder, ObjCommon, cxRadioGroup;

type
  TfrmSysDefine = class(TfrmWebToolForm)
    RzPanel1: TRzPanel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    PageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel1: TRzLabel;
    RzProgressBar1: TRzProgressBar;
    RzPanel10: TRzPanel;
    Photo: TImage;
    cdsTenant: TZQuery;
    cdsShopInfo: TZQuery;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    edtZERO_OUT: TcxCheckBox;
    RzPanel12: TRzPanel;
    Bevel1: TBevel;
    RzLabel7: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    cdsSysDefine: TZQuery;
    RzLabel4: TRzLabel;
    Bevel4: TBevel;
    RzPanel34: TRzPanel;
    DBGridEh1: TDBGridEh;
    cdsUsers: TZQuery;
    DataSource1: TDataSource;
    RzLabel6: TRzLabel;
    Bevel6: TBevel;
    RzLabel5: TRzLabel;
    Bevel5: TBevel;
    RzLabel8: TRzLabel;
    Bevel7: TBevel;
    RzPanel40: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel9: TRzLabel;
    edtBK_SHOP_NAME: TRzPanel;
    RzPanel41: TRzPanel;
    RzLabel10: TRzLabel;
    edtSHOP_NAME: TcxTextEdit;
    edtBK_LICENSE_CODE: TRzPanel;
    RzPanel42: TRzPanel;
    RzLabel11: TRzLabel;
    edtLICENSE_CODE: TcxTextEdit;
    edtBK_LINKMAN: TRzPanel;
    RzPanel43: TRzPanel;
    RzLabel12: TRzLabel;
    edtLINKMAN: TcxTextEdit;
    edtBK_TELEPHONE: TRzPanel;
    RzPanel8: TRzPanel;
    RzLabel13: TRzLabel;
    edtTELEPHONE: TcxTextEdit;
    edtBK_ADDRESS: TRzPanel;
    RzPanel44: TRzPanel;
    RzLabel14: TRzLabel;
    edtADDRESS: TcxTextEdit;
    edtBK_REGION_ID: TRzPanel;
    RzPanel46: TRzPanel;
    RzLabel15: TRzLabel;
    edtREGION_ID: TzrComboBoxList;
    btnSaveShopInfo: TRzBmpButton;
    RzPanel5: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel16: TRzLabel;
    edtUSING_DATE: TcxDateEdit;
    RzPanel11: TRzPanel;
    RzPanel47: TRzPanel;
    RzLabel17: TRzLabel;
    edtPOSCALCDIGHT: TcxComboBox;
    RzPanel26: TRzPanel;
    RzPanel48: TRzPanel;
    RzLabel18: TRzLabel;
    edtPosDight: TcxSpinEdit;
    RzPanel25: TRzPanel;
    RzPanel49: TRzPanel;
    RzLabel19: TRzLabel;
    edtCARRYRULE: TcxComboBox;
    RzPanel27: TRzPanel;
    RzPanel50: TRzPanel;
    RzLabel20: TRzLabel;
    edtFlag: TcxTextEdit;
    RzPanel28: TRzPanel;
    RzPanel51: TRzPanel;
    RzLabel21: TRzLabel;
    edtID: TcxComboBox;
    RzPanel29: TRzPanel;
    RzPanel52: TRzPanel;
    RzLabel22: TRzLabel;
    edtID1: TcxComboBox;
    edtLEN1: TcxComboBox;
    edtDEC1: TcxTextEdit;
    RzPanel30: TRzPanel;
    RzPanel33: TRzPanel;
    RzLabel23: TRzLabel;
    edtID2: TcxComboBox;
    edtLEN2: TcxComboBox;
    edtDEC2: TcxTextEdit;
    RzPanel31: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel24: TRzLabel;
    RzPanel55: TRzPanel;
    RzPanel56: TRzPanel;
    RzLabel26: TRzLabel;
    edtTicketPrintComm: TcxComboBox;
    RzPanel15: TRzPanel;
    RzPanel57: TRzPanel;
    RzLabel27: TRzLabel;
    edtPRINTERWIDTH: TcxComboBox;
    RzPanel17: TRzPanel;
    RzPanel58: TRzPanel;
    RzLabel28: TRzLabel;
    edtTitle: TcxTextEdit;
    RzPanel18: TRzPanel;
    RzPanel59: TRzPanel;
    RzLabel29: TRzLabel;
    edtFOOTER: TcxMemo;
    RzPanel14: TRzPanel;
    RzPanel60: TRzPanel;
    RzLabel30: TRzLabel;
    cxNullRow: TcxSpinEdit;
    RzPanel16: TRzPanel;
    RzPanel21: TRzPanel;
    RzLabel31: TRzLabel;
    edtTicketCopy: TcxSpinEdit;
    RzPanel61: TRzPanel;
    RzPanel62: TRzPanel;
    RzLabel32: TRzLabel;
    edtTICKET_PRINT_NAME: TcxComboBox;
    RzPanel19: TRzPanel;
    RzPanel63: TRzPanel;
    RzLabel33: TRzLabel;
    cxCashBox: TcxComboBox;
    RzPanel22: TRzPanel;
    RzPanel23: TRzPanel;
    RzLabel34: TRzLabel;
    cxCashBoxRate: TcxComboBox;
    btnDefault: TRzBmpButton;
    btnSaveSysDefine: TRzBmpButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    rowToolNav: TRzToolbar;
    Tool_Del: TRzToolButton;
    Tool_Edit: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzPanel35: TRzPanel;
    RzPanel69: TRzPanel;
    RzBackground32: TRzBackground;
    RzLabel40: TRzLabel;
    edtSaveFolder: TcxTextEdit;
    btnBackUp: TRzBmpButton;
    RzPanel70: TRzPanel;
    RzPanel71: TRzPanel;
    RzBackground33: TRzBackground;
    RzLabel41: TRzLabel;
    edtBackUpFile: TcxTextEdit;
    btnRecovery: TRzBmpButton;
    RzLabel42: TRzLabel;
    RzLabel43: TRzLabel;
    RzLabel44: TRzLabel;
    RzLabel45: TRzLabel;
    OpenBackUpDialog: TOpenDialog;
    SaveFolderDialog: TSaveDialog;
    OpenImageDialog: TOpenDialog;
    EditPanel: TRzPanel;
    edtBK_MOBILE: TRzPanel;
    RzPanel67: TRzPanel;
    RzLabel38: TRzLabel;
    edtMOBILE: TcxTextEdit;
    edtBK_ROLE_NAMES: TRzPanel;
    RzPanel68: TRzPanel;
    RzLabel39: TRzLabel;
    edtROLE_NAMES: TcxTextEdit;
    edtBK_ACCOUNT: TRzPanel;
    RzPanel64: TRzPanel;
    RzLabel35: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    edtBK_USER_NAME: TRzPanel;
    RzPanel65: TRzPanel;
    RzLabel36: TRzLabel;
    edtUSER_NAME: TcxTextEdit;
    btnSaveUsers: TRzBmpButton;
    btnNewUsers: TRzBmpButton;
    RzSpacer2: TRzSpacer;
    RzPanel37: TRzPanel;
    RzBackground29: TRzBackground;
    RzLabel37: TRzLabel;
    pnl_changepswd: TRzPanel;
    RzPanel72: TRzPanel;
    RzPanel73: TRzPanel;
    RzLabel46: TRzLabel;
    edtOLD_PSWD: TcxTextEdit;
    RzPanel38: TRzPanel;
    RzPanel74: TRzPanel;
    RzLabel47: TRzLabel;
    edtNEW_PSWD1: TcxTextEdit;
    RzPanel75: TRzPanel;
    RzPanel76: TRzPanel;
    RzLabel48: TRzLabel;
    edtNEW_PSWD2: TcxTextEdit;
    btnChange: TRzBmpButton;
    btnCancel: TRzBmpButton;
    edtBK_INPUT_MODE: TRzPanel;
    RzPanel79: TRzPanel;
    RzLabel49: TRzLabel;
    edtINPUT_MODE: TcxComboBox;
    edtBK_INDUSTRY_TYPE: TRzPanel;
    RzPanel81: TRzPanel;
    RzLabel50: TRzLabel;
    edtINDUSTRY_TYPE: TcxComboBox;
    RzLabel51: TRzLabel;
    Tool_Right: TRzToolButton;
    Tool_Reset: TRzToolButton;
    RzPanel13: TRzPanel;
    RzPanel82: TRzPanel;
    RzLabel52: TRzLabel;
    cxPrintFormat: TcxComboBox;
    cxSavePrint: TcxCheckBox;
    RzLabel53: TRzLabel;
    Bevel8: TBevel;
    RzLabel54: TRzLabel;
    btnRecoveryRemote: TRzBmpButton;
    Recovery_Group: TRzGroupBox;
    Recovery_1: TcxRadioButton;
    Recovery_2: TcxRadioButton;
    Recovery_3: TcxRadioButton;
    RzPanel53: TRzPanel;
    RzPanel54: TRzPanel;
    RzLabel25: TRzLabel;
    lblCaption: TRzLabel;
    edtBK_XSM_PSWD: TRzPanel;
    RzPanel84: TRzPanel;
    RzLabel55: TRzLabel;
    edtBK_XSM_CODE: TRzPanel;
    RzPanel86: TRzPanel;
    RzLabel56: TRzLabel;
    edtXSM_CODE: TcxTextEdit;
    edtXSM_PSWD: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveShopInfoClick(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnSaveSysDefineClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnSyncClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnSaveUsersClick(Sender: TObject);
    procedure btnNewUsersClick(Sender: TObject);
    procedure Tool_EditClick(Sender: TObject);
    procedure Tool_DelClick(Sender: TObject);
    procedure RzLabel40Click(Sender: TObject);
    procedure btnBackUpClick(Sender: TObject);
    procedure RzLabel41Click(Sender: TObject);
    procedure btnRecoveryClick(Sender: TObject);
    procedure RzLabel9Click(Sender: TObject);
    procedure Tool_ResetClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure RzLabel37Click(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure Tool_RightClick(Sender: TObject);
    procedure btnRecoveryRemoteClick(Sender: TObject);
  private
    SyncDataing:boolean;
    FCurUserId:string;
    FCurUserName:string;
    FCurUserPswd:string;
    FCurUserAccount:string;
    FCurUserRoleIds:string;
    FUserState:TDataSetState;
    FFirstLogin:boolean;
    function  CheckRegister:boolean;
    procedure OpenShopInfo(tenantId:string='';shopId:string='');
    procedure InitToken;
    procedure SaveRegisterParams;

    procedure SyncData;
    
    procedure OpenSysDefine;
    procedure ReadSysDefine;
    procedure ReadBarCodeRule;
    procedure SaveSysDefine;

    procedure OpenUsers;
    procedure SaveUsers;
    procedure GrantRights;
    procedure CheckUsersInfo;
    procedure InitCurrentUser;

    procedure ReadFromObject(PageIndex:integer);
    procedure WriteToObject;

    procedure SetFirstLogin(const Value: boolean);
    procedure SetCurUserId(const Value: string);
    procedure SetCurUserName(const Value: string);
    procedure SetCurUserPswd(const Value: string);
    procedure SetCurUserAccount(const Value: string);
    procedure SetCurUserRoleIds(const Value: string);
    procedure SetUserState(const Value: TDataSetState);

    procedure FileRecovery(src:string;AppHandle:HWnd);
    procedure RemoteRecovery(recType:string;AppHandle:HWnd);
    procedure RtcSyncClose;
  public
    AObj:TRecord_;
    procedure GetShopInfo;
    procedure SaveShopInfo(Auto:boolean=false);
    procedure showForm;override;
    function checkCanClose:boolean;override;
    class function  AutoRegister:boolean;
    class procedure SaveRegister;
    class procedure DBFileRecovery(src:string;AppHandle:HWnd);
    class procedure DBRemoteRecovery(recType:string;AppHandle:HWnd);
    property FirstLogin:boolean read FFirstLogin write SetFirstLogin;
    property CurUserId:string read FCurUserId write SetCurUserId;
    property CurUserName:string read FCurUserName write SetCurUserName;
    property CurUserPswd:string read FCurUserPswd write SetCurUserPswd;
    property CurUserAccount:string read FCurUserAccount write SetCurUserAccount;
    property CurUserRoleIds:string read FCurUserRoleIds write SetCurUserRoleIds;
    property UserState:TDataSetState read FUserState write SetUserState;
  end;

implementation

uses udllGlobal,udataFactory,uTokenFactory,uRspFactory,udllShopUtil,EncDec,ufrmSyncData,
     uSyncFactory,uFnUtil,uRspSyncFactory,uRightsFactory,udllDsUtil,ufrmUserRights,
     uDevFactory,ufrmStocksCalc;

{$R *.dfm}

function TfrmSysDefine.CheckRegister: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE = ''TENANT_ID'' and TENANT_ID=0';
    dataFactory.Open(rs);
    result := (rs.Fields[0].AsString <> '');
  finally
    dataFactory.MoveToDefault;
    rs.Free;
  end;
end;

procedure TfrmSysDefine.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  AObj := TRecord_.Create;
  
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;

  edtREGION_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_REGION_INFO');

  FirstLogin := not CheckRegister;

  if FirstLogin then
  begin
    RzBmpButton2.Visible := false;
    RzBmpButton3.Visible := false;
    RzBmpButton4.Visible := false;
  end;

  dbState := dsInsert;

  edtROLE_NAMES.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtROLE_NAMES.Style);
  edtBK_ROLE_NAMES.Color := edtROLE_NAMES.Style.Color;
  edtSaveFolder.Properties.ReadOnly := true;
  edtBackUpFile.Properties.ReadOnly := true;

  SaveFolderDialog.InitialDir := ExtractFilePath(Application.ExeName)+'backup\'+token.tenantId;
  OpenBackUpDialog.InitialDir := ExtractFilePath(Application.ExeName)+'backup\'+token.tenantId;

  if (token.userId <> 'admin') and (token.userId <> 'system') and (token.account <> token.xsmCode) then
     Tool_Reset.Visible := false
  else
     Tool_Reset.Visible := true;
  PageControl.ActivePageIndex := 0;

  if (token.account = 'admin') or (token.account = 'system') then
     begin
       edtXSM_CODE.Properties.ReadOnly := false;
       SetEditStyle(dsInsert, edtXSM_CODE.Style);
       edtBK_XSM_CODE.Color := edtXSM_CODE.Style.Color;
     end
  else
     begin
       edtXSM_CODE.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse, edtXSM_CODE.Style);
       edtBK_XSM_CODE.Color := edtXSM_CODE.Style.Color;
     end;
end;

procedure TfrmSysDefine.GetShopInfo;
var
  Params:TftParamList;
  tenantxml,shopxml:widestring;
  tenantdoc,shopdoc:IXMLDomDocument;
  caTenant,caShopInfo:IXMLDOMNode;
begin
  if not rspFactory.xsmLogin(token.xsmCode,3) then Exit;

  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := rspFactory.tenantId;
    Params.ParamByName('SHOP_ID').AsString := rspFactory.shopId;
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsTenant,'TTenantV60',Params);
      dataFactory.AddBatch(cdsShopInfo,'TShopInfoV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;

  tenantxml := rspFactory.getTenantInfo(rspFactory.tenantId);
  tenantdoc := rspFactory.CreateXML(tenantxml);
  caTenant := rspFactory.FindNode(tenantdoc,'body\caTenant',false);

  if caTenant = nil then Raise Exception.Create('查询企业信息失败...');

  if cdsTenant.IsEmpty then cdsTenant.Append
  else cdsTenant.Edit;

  cdsTenant.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caTenant,'tenantId'));
  cdsTenant.FieldByName('LOGIN_NAME').AsString := rspFactory.GetNodeValue(caTenant,'loginName');
  cdsTenant.FieldByName('TENANT_NAME').AsString := rspFactory.GetNodeValue(caTenant,'tenantName');
  cdsTenant.FieldByName('SHORT_TENANT_NAME').AsString := rspFactory.GetNodeValue(caTenant,'shortTenantName');
  cdsTenant.FieldByName('TENANT_SPELL').AsString := rspFactory.GetNodeValue(caTenant,'tenantSpell');
  cdsTenant.FieldByName('TENANT_TYPE').AsInteger := StrtoInt(rspFactory.GetNodeValue(caTenant,'tenantType'));
  cdsTenant.FieldByName('LICENSE_CODE').AsString := rspFactory.GetNodeValue(caTenant,'licenseCode');
  cdsTenant.FieldByName('LEGAL_REPR').AsString := rspFactory.GetNodeValue(caTenant,'legalRepr');
  cdsTenant.FieldByName('LINKMAN').AsString := rspFactory.GetNodeValue(caTenant,'linkman');
  cdsTenant.FieldByName('TELEPHONE').AsString := rspFactory.GetNodeValue(caTenant,'telephone');
  cdsTenant.FieldByName('FAXES').AsString := rspFactory.GetNodeValue(caTenant,'faxes');
  cdsTenant.FieldByName('HOMEPAGE').AsString := rspFactory.GetNodeValue(caTenant,'homepage');
  cdsTenant.FieldByName('ADDRESS').AsString := rspFactory.GetNodeValue(caTenant,'address');
  cdsTenant.FieldByName('POSTALCODE').AsString := rspFactory.GetNodeValue(caTenant,'postalcode');
  cdsTenant.FieldByName('PASSWRD').AsString := rspFactory.GetNodeValue(caTenant,'passwrd');
  cdsTenant.FieldByName('QQ').AsString := rspFactory.GetNodeValue(caTenant,'qq');
  cdsTenant.FieldByName('MSN').AsString := rspFactory.GetNodeValue(caTenant,'msn');
  cdsTenant.FieldByName('REMARK').AsString := rspFactory.GetNodeValue(caTenant,'remark');
  cdsTenant.FieldByName('REGION_ID').AsString := rspFactory.GetNodeValue(caTenant,'regionId');
  cdsTenant.FieldByName('SRVR_ID').AsString := rspFactory.GetNodeValue(caTenant,'srvrId');
  cdsTenant.FieldByName('PROD_ID').AsString := rspFactory.GetNodeValue(caTenant,'prodId');
  cdsTenant.FieldByName('AUDIT_STATUS').AsString := rspFactory.GetNodeValue(caTenant,'auditStatus');
  cdsTenant.Post;

  if cdsShopInfo.IsEmpty then cdsShopInfo.Append
  else cdsShopInfo.Edit;

  if rspFactory.shopId = '' then Raise Exception.Create('门店信息尚未审核...');

  if Copy(rspFactory.shopId,Length(rspFactory.shopId)-3,Length(rspFactory.shopId)) = '0001' then
  begin
    cdsShopInfo.FieldByName('TENANT_ID').AsInteger := cdsTenant.FieldByName('TENANT_ID').AsInteger;
    cdsShopInfo.FieldByName('SHOP_ID').AsString := rspFactory.shopId;
    cdsShopInfo.FieldByName('SHOP_NAME').AsString := cdsTenant.FieldByName('SHORT_TENANT_NAME').AsString;
    cdsShopInfo.FieldByName('SHOP_SPELL').AsString := cdsTenant.FieldByName('TENANT_SPELL').AsString;
    cdsShopInfo.FieldByName('LICENSE_CODE').AsString := cdsTenant.FieldByName('LICENSE_CODE').AsString;
    cdsShopInfo.FieldByName('LINKMAN').AsString := cdsTenant.FieldByName('LINKMAN').AsString;
    cdsShopInfo.FieldByName('TELEPHONE').AsString := cdsTenant.FieldByName('TELEPHONE').AsString;
    cdsShopInfo.FieldByName('FAXES').AsString := cdsTenant.FieldByName('FAXES').AsString;
    cdsShopInfo.FieldByName('ADDRESS').AsString := cdsTenant.FieldByName('ADDRESS').AsString;
    cdsShopInfo.FieldByName('POSTALCODE').AsString := cdsTenant.FieldByName('POSTALCODE').AsString;
    if cdsShopInfo.FieldByName('SHOP_ID').AsString = rspFactory.shopId then
       cdsShopInfo.FieldByName('XSM_CODE').AsString := token.xsmCode
    else
       cdsShopInfo.FieldByName('XSM_CODE').AsString := rspFactory.GetNodeValue(caShopInfo,'xsmCode');
    cdsShopInfo.FieldByName('XSM_PSWD').AsString := EncStr(token.xsmPWD,ENC_KEY);
    cdsShopInfo.FieldByName('REGION_ID').AsString := cdsTenant.FieldByName('REGION_ID').AsString;
    cdsShopInfo.FieldByName('SHOP_TYPE').AsString := '#';
    cdsShopInfo.FieldByName('SEQ_NO').AsInteger := 1001;
    cdsShopInfo.Post;
  end
  else
  begin
    shopxml := rspFactory.getShopInfo(rspFactory.tenantId,rspFactory.shopId);
    shopdoc := rspFactory.CreateXML(shopxml);
    caShopInfo := rspFactory.FindNode(shopdoc,'body\caShopInfo',false);

    if caShopInfo = nil then Raise Exception.Create('查询门店信息失败...');

    cdsShopInfo.FieldByName('TENANT_ID').AsInteger := StrtoInt(rspFactory.GetNodeValue(caShopInfo,'tenantId'));
    cdsShopInfo.FieldByName('SHOP_ID').AsString := rspFactory.GetNodeValue(caShopInfo,'shopId');
    cdsShopInfo.FieldByName('SHOP_NAME').AsString := rspFactory.GetNodeValue(caShopInfo,'shopName');
    cdsShopInfo.FieldByName('SHOP_SPELL').AsString := rspFactory.GetNodeValue(caShopInfo,'shopSpell');
    cdsShopInfo.FieldByName('LICENSE_CODE').AsString := rspFactory.GetNodeValue(caShopInfo,'licenseCode');
    cdsShopInfo.FieldByName('LINKMAN').AsString := rspFactory.GetNodeValue(caShopInfo,'linkman');
    cdsShopInfo.FieldByName('TELEPHONE').AsString := rspFactory.GetNodeValue(caShopInfo,'telephone');
    cdsShopInfo.FieldByName('FAXES').AsString := rspFactory.GetNodeValue(caShopInfo,'faxes');
    cdsShopInfo.FieldByName('ADDRESS').AsString := rspFactory.GetNodeValue(caShopInfo,'address');
    cdsShopInfo.FieldByName('POSTALCODE').AsString := rspFactory.GetNodeValue(caShopInfo,'postalcode');
    if cdsShopInfo.FieldByName('SHOP_ID').AsString = rspFactory.shopId then
       cdsShopInfo.FieldByName('XSM_CODE').AsString := token.xsmCode
    else
       cdsShopInfo.FieldByName('XSM_CODE').AsString := rspFactory.GetNodeValue(caShopInfo,'xsmCode');
    cdsShopInfo.FieldByName('XSM_PSWD').AsString := EncStr(token.xsmPWD,ENC_KEY);
    cdsShopInfo.FieldByName('REGION_ID').AsString := rspFactory.GetNodeValue(caShopInfo,'regionId');
    cdsShopInfo.FieldByName('SHOP_TYPE').AsString := rspFactory.GetNodeValue(caShopInfo,'shopType');
    cdsShopInfo.FieldByName('SEQ_NO').AsInteger := StrtoInt(rspFactory.GetNodeValue(caShopInfo,'seqNo'));
    cdsShopInfo.Post;
  end;
end;

procedure TfrmSysDefine.OpenShopInfo(tenantId:string='';shopId:string='');
var
  Params:TftParamList;
  tid,sid:string;
begin
  if tenantId = '' then tid := token.tenantId
  else tid := tenantId;
  if shopId = '' then sid := token.shopId
  else sid := shopId;

  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tid);
    Params.ParamByName('SHOP_ID').AsString := sid;
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsTenant,'TTenantV60',Params);
      dataFactory.AddBatch(cdsShopInfo,'TShopInfoV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmSysDefine.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmSysDefine.ReadFromObject(PageIndex:integer);
var i:integer;
begin
  if PageIndex = 0 then
  begin
    AObj.ReadFromDataSet(cdsShopInfo);
    udllShopUtil.ReadFromObject(AObj,self);
    edtXSM_PSWD.Text := DecStr(AObj.FieldByName('XSM_PSWD').AsString,ENC_KEY);
    if FirstLogin then
       begin
         edtINPUT_MODE.ItemIndex := 0;
         edtINDUSTRY_TYPE.ItemIndex := 0;
       end
    else
       begin
         edtINPUT_MODE.ItemIndex := strtointdef(dllGlobal.GetParameter('INPUT_MODE'),0);
         i := TdsItems.FindItems(edtINDUSTRY_TYPE.Properties.Items,'CODE_ID',dllGlobal.GetParameter('INDUSTRY_TYPE'));
         if i < 0 then i := 0;
         edtINDUSTRY_TYPE.ItemIndex := i;
       end;
  end;
  if PageIndex = 1 then
  begin
    ReadSysDefine;
  end;
end;

procedure TfrmSysDefine.WriteToObject;
begin
  if PageControl.ActivePageIndex = 0 then
  begin
    udllShopUtil.WriteToObject(AObj,self);
    AObj.FieldByName('XSM_PSWD').AsString:=EncStr(edtXSM_PSWD.Text,ENC_KEY);
    AObj.WriteToDataSet(cdsShopInfo);
    if cdsShopInfo.FieldByName('SHOP_ID').AsString = cdsShopInfo.FieldByName('TENANT_ID').AsString + '0001' then
    begin
      cdsTenant.Edit;
      cdsTenant.FieldByName('SHORT_TENANT_NAME').AsString := cdsShopInfo.FieldByName('SHOP_NAME').AsString;
      cdsTenant.FieldByName('LICENSE_CODE').AsString := cdsShopInfo.FieldByName('LICENSE_CODE').AsString;
      cdsTenant.FieldByName('REGION_ID').AsString := cdsShopInfo.FieldByName('REGION_ID').AsString;
      cdsTenant.FieldByName('LINKMAN').AsString := cdsShopInfo.FieldByName('LINKMAN').AsString;
      cdsTenant.FieldByName('TELEPHONE').AsString := cdsShopInfo.FieldByName('TELEPHONE').AsString;
      cdsTenant.FieldByName('ADDRESS').AsString := cdsShopInfo.FieldByName('ADDRESS').AsString;
      cdsTenant.Post;
    end;
  end;
end;

procedure TfrmSysDefine.btnSaveShopInfoClick(Sender: TObject);
begin
  inherited;
  WriteToObject;
  SaveShopInfo;
  MessageBox(Handle,'保存成功...','友情提示..',MB_OK);
end;

procedure TfrmSysDefine.SaveShopInfo(Auto:boolean=false);
  procedure SetValue(rs:TZQuery;name,value: string);
  begin
    if rs.Locate('DEFINE', name, []) then
      rs.Edit
    else
      rs.Append;
    rs.FieldByName('DEFINE').AsString := name;
    rs.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.FieldByName('VALUE').AsString := value;
    rs.FieldByName('VALUE_TYPE').AsString := '0';
    rs.Post;
  end;
var
  Params:TftParamList;
  tmpSysDefine,tmpTenant,tmpShopInfo:TZQuery;
  tmpObj:TRecord_;
begin
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsTenant,'TTenantV60',nil);
    dataFactory.AddBatch(cdsShopInfo,'TShopInfoV60',nil);
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    Raise;
  end;

  if FirstLogin or (dataFactory.iDbType <> 5) then
  begin
    tmpTenant := TZQuery.Create(nil);
    tmpShopInfo := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    if dataFactory.iDbType = 5 then
      dataFactory.MoveToRemote
    else
      dataFactory.MoveToSqlite;
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsTenant.FieldByName('TENANT_ID').AsInteger;
      Params.ParamByName('SHOP_ID').AsString := cdsShopInfo.FieldByName('SHOP_ID').AsString;

      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpTenant,'TTenantV60',Params);
        dataFactory.AddBatch(tmpShopInfo,'TShopInfoV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;

      tmpObj := TRecord_.Create;
      try
        if tmpTenant.IsEmpty then tmpTenant.Append
        else tmpTenant.Edit;
        tmpObj.ReadFromDataSet(cdsTenant);
        tmpObj.WriteToDataSet(tmpTenant);
      finally
        tmpObj.Free;
      end;

      tmpObj := TRecord_.Create;
      try
        if tmpShopInfo.IsEmpty then tmpShopInfo.Append
        else tmpShopInfo.Edit;
        tmpObj.ReadFromDataSet(cdsShopInfo);
        tmpObj.WriteToDataSet(tmpShopInfo);
      finally
        tmpObj.Free;
      end;

      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpTenant,'TTenantV60',nil);
        dataFactory.AddBatch(tmpShopInfo,'TShopInfoV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      Params.Free;
      tmpTenant.Free;
      tmpShopInfo.Free;
      dataFactory.MoveToDefault;
    end;
  end;

  if FirstLogin then
  begin
    InitToken;
    FirstLogin := false;
    if not Auto then
       begin
         SyncData;
         SaveRegisterParams;
         RzBmpButton2.Visible := true;
         RzBmpButton3.Visible := true;
         RzBmpButton4.Visible := true;
         OpenShopInfo(cdsShopInfo.FieldByName('TENANT_ID').AsString,cdsShopInfo.FieldByName('SHOP_ID').AsString);
       end;
  end;

  Params := TftParamList.Create(nil);
  tmpSysDefine := TZQuery.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.Open(tmpSysDefine, 'TSysDefineV60', Params);
    if edtINPUT_MODE.ItemIndex >= 0 then
       SetValue(tmpSysDefine,'INPUT_MODE',inttostr(edtINPUT_MODE.ItemIndex));
    if edtINDUSTRY_TYPE.ItemIndex >= 0 then
       SetValue(tmpSysDefine,'INDUSTRY_TYPE',TRecord_(edtINDUSTRY_TYPE.Properties.Items.Objects[edtINDUSTRY_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString);
    dataFactory.UpdateBatch(tmpSysDefine, 'TSysDefineV60')
  finally
    Params.Free;
    tmpSysDefine.Free;
  end;

  if dataFactory.iDbType <> 5 then
  begin
    Params := TftParamList.Create(nil);
    tmpSysDefine := TZQuery.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      dataFactory.Open(tmpSysDefine, 'TSysDefineV60', Params);
      if edtINPUT_MODE.ItemIndex >= 0 then
         SetValue(tmpSysDefine,'INPUT_MODE',inttostr(edtINPUT_MODE.ItemIndex));
      if edtINDUSTRY_TYPE.ItemIndex >= 0 then
         SetValue(tmpSysDefine,'INDUSTRY_TYPE',TRecord_(edtINDUSTRY_TYPE.Properties.Items.Objects[edtINDUSTRY_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString);
      dataFactory.UpdateBatch(tmpSysDefine, 'TSysDefineV60')
    finally
      dataFactory.MoveToDefault;
      tmpSysDefine.Free;
      Params.Free;
    end;
  end;

  dllGlobal.GetZQueryFromName('CA_TENANT').Close;
  dllGlobal.GetZQueryFromName('CA_SHOP_INFO').Close;
  dllGlobal.GetZQueryFromName('SYS_DEFINE').Close;
end;

procedure TfrmSysDefine.InitToken;
var LDate:TDatetime;
begin
  token.userId := cdsShopInfo.FieldbyName('SHOP_ID').AsString;
  token.account := token.xsmCode;
  token.tenantId := cdsTenant.FieldbyName('TENANT_ID').AsString;
  token.tenantName := cdsTenant.FieldbyName('TENANT_NAME').AsString;
  token.shopId := cdsShopInfo.FieldbyName('SHOP_ID').AsString;
  token.shopName := cdsShopInfo.FieldbyName('SHOP_NAME').AsString;
  token.username := cdsShopInfo.FieldbyName('LINKMAN').AsString;
  token.address := cdsShopInfo.FieldbyName('ADDRESS').AsString;
  token.xsmCode := cdsShopInfo.FieldbyName('XSM_CODE').AsString;
  token.xsmPWD := cdsShopInfo.FieldbyName('XSM_PSWD').AsString;
  token.licenseCode := cdsShopInfo.FieldbyName('LICENSE_CODE').AsString;
  token.legal := cdsShopInfo.FieldbyName('LINKMAN').AsString;
  token.mobile := cdsShopInfo.FieldbyName('TELEPHONE').AsString;
  token.Logined := true;
  token.online := true;

  LDate := trunc(rspFactory.timestamp/86400.0+40542.0)+2;
  token.lDate := strtoint(FormatDatetime('YYYYMMDD',LDate));
  dataFactory.MoveToSqlite;
  try
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+FormatDatetime('YYYYMMDD',LDate)+''' where TENANT_ID=0 and DEFINE=''NEAR_LOGIN_DATE''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''NEAR_LOGIN_DATE'','''+FormatDatetime('YYYYMMDD',LDate)+''',0,''00'',5497000)');
  finally
    dataFactory.MoveToDefault;
  end;
end;

procedure TfrmSysDefine.SaveRegisterParams;
begin
  dataFactory.MoveToSqlite;
  try
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+token.tenantId+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''TENANT_ID'','''+token.tenantId+''',0,''00'',5497000)');
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+token.tenantId+''' where TENANT_ID='+token.tenantId+' and DEFINE=''TENANT_ID''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+token.tenantId+',''TENANT_ID'','''+token.tenantId+''',0,''00'',5497000)');
  finally
    dataFactory.MoveToDefault;
  end;
end;

procedure TfrmSysDefine.RzBmpButton1Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 0 then
  begin
    if FirstLogin then
      GetShopInfo
    else
      OpenShopInfo;
    ReadFromObject(0);
  end;
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 0;
end;

procedure TfrmSysDefine.RzBmpButton2Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 1 then
  begin
    OpenSysDefine;
    ReadFromObject(1);
  end;
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 1;
end;

procedure TfrmSysDefine.InitCurrentUser;
begin
  UserState := dsBrowse;
  edtACCOUNT.Text := token.account;
  edtUSER_NAME.Text := token.username;
  edtMOBILE.Text := token.mobile;
  cdsUsers.DisableControls;
  try
    CurUserId := token.userId;
    CurUserName := token.username;
    CurUserAccount := token.account;
    if cdsUsers.Locate('USER_ID',token.userId,[]) then
       begin
         edtROLE_NAMES.Text := cdsUsers.FieldByName('ROLE_IDS_TEXT').AsString;
         CurUserPswd := cdsUsers.FieldByName('PASS_WRD').AsString;
         CurUserRoleIds := cdsUsers.FieldByName('ROLE_IDS').AsString;
       end
    else
       begin
         edtROLE_NAMES.Text := '管理员';
         CurUserPswd := '';
         CurUserRoleIds := '';
       end;
  finally
    cdsUsers.EnableControls;
  end;
end;

procedure TfrmSysDefine.RzBmpButton3Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 2 then
  begin
    pnl_changepswd.Visible := false;
    OpenUsers;
    InitCurrentUser;
  end;
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 2;
end;

procedure TfrmSysDefine.RzBmpButton4Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 3 then
  begin
    edtSaveFolder.Text := ExtractFilePath(Application.ExeName)+'backup\'+token.tenantId+'\db_'+FormatDateTime('YYYYMMDDHHMMSSZZZ',now())+'.bak'; 
  end;
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 3;
end;

procedure TfrmSysDefine.SaveSysDefine;
  procedure SetValue(rs:TZQuery;name,value: string);
  begin
    if rs.Locate('DEFINE', name, []) then
      rs.Edit
    else
      rs.Append;
    rs.FieldByName('DEFINE').AsString := name;
    rs.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.FieldByName('VALUE').AsString := value;
    rs.FieldByName('VALUE_TYPE').AsString := '0';
    rs.Post;
  end;
var
  F:TIniFile;
  Params:TftParamList;
  tmpSysDefine:TZQuery;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'dev.fty');
  try
    F.WriteString('SYS_DEFINE','PRINTNULL',cxNullRow.Value);
    F.WriteString('SYS_DEFINE','TICKETCOPY',edtTicketCopy.Value);
    F.WriteString('SYS_DEFINE','PRINTERCOMM',Inttostr(edtTicketPrintComm.ItemIndex));
    F.WriteString('SYS_DEFINE','TICKET_PRINT_NAME',Inttostr(edtTICKET_PRINT_NAME.ItemIndex));
    F.WriteString('SYS_DEFINE','FOOTER',EncStr(edtFOOTER.Text,ENC_KEY));
    F.WriteString('SYS_DEFINE','TITLE',EncStr(edtTitle.Text,ENC_KEY));
    if edtPRINTERWIDTH.ItemIndex = 1 then
       F.WriteString('SYS_DEFINE','PRINTERWIDTH','38')
    else
       F.WriteString('SYS_DEFINE','PRINTERWIDTH','33');
    if cxSavePrint.Checked then
       F.WriteString('SYS_DEFINE','SAVEPRINT','1')
    else
       F.WriteString('SYS_DEFINE','SAVEPRINT','0');
    F.WriteString('SYS_DEFINE','PRINTFORMAT',Inttostr(cxPrintFormat.ItemIndex));
    F.WriteString('SYS_DEFINE','CASHBOX',Inttostr(cxCashBox.ItemIndex));
    F.WriteString('SYS_DEFINE','CASHBOXRATE',cxCashBoxRate.Text);
  finally
    try
      F.Free;
    except
    end;
  end;

  SetValue(cdsSysDefine,'BUIK_FLAG',trim(edtFlag.Text));
  SetValue(cdsSysDefine,'BUIK_ID',inttostr(edtID.ItemIndex));
  SetValue(cdsSysDefine,'BUIK_ID1',inttostr(edtID1.ItemIndex));
  SetValue(cdsSysDefine,'BUIK_ID2',inttostr(edtID2.ItemIndex));
  SetValue(cdsSysDefine,'BUIK_LEN1',inttostr(edtLEN1.ItemIndex));
  SetValue(cdsSysDefine,'BUIK_LEN2',inttostr(edtLEN2.ItemIndex));
  SetValue(cdsSysDefine,'BUIK_DEC1',trim(edtDEC1.Text));
  SetValue(cdsSysDefine,'BUIK_DEC2',trim(edtDEC2.Text));
  SetValue(cdsSysDefine,'USING_DATE', FormatDateTime('YYYY-MM-DD', edtUSING_DATE.Date));
  SetValue(cdsSysDefine,'POSDIGHT', inttostr(edtPosDight.value));
  SetValue(cdsSysDefine,'POSCALCDIGHT', inttostr(edtPosCalcDight.ItemIndex-2));
  if edtCARRYRULE.ItemIndex = -1 then
     SetValue(cdsSysDefine,'CARRYRULE', inttostr(0))
  else
     SetValue(cdsSysDefine,'CARRYRULE', inttostr(edtCARRYRULE.ItemIndex));
  if edtZERO_OUT.Checked then
     SetValue(cdsSysDefine,'ZERO_OUT', '1')
  else
     SetValue(cdsSysDefine,'ZERO_OUT', '0');

  try
    if not dataFactory.UpdateBatch(cdsSysDefine, 'TSysDefineV60') then
       cdsSysDefine.CancelUpdates;
  except
    on E:Exception do
    begin
      cdsSysDefine.CancelUpdates;
      Raise Exception.Create('保存失败' + E.Message);
    end;
  end;

  //保存本地
  if dataFactory.iDbType <> 5 then
  begin
    dataFactory.MoveToSqlite;
    Params := TftParamList.Create(nil);
    tmpSysDefine := TZQuery.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      dataFactory.Open(tmpSysDefine, 'TSysDefineV60', Params);

      SetValue(tmpSysDefine,'BUIK_FLAG',trim(edtFlag.Text));
      SetValue(tmpSysDefine,'BUIK_ID',inttostr(edtID.ItemIndex));
      SetValue(tmpSysDefine,'BUIK_ID1',inttostr(edtID1.ItemIndex));
      SetValue(tmpSysDefine,'BUIK_ID2',inttostr(edtID2.ItemIndex));
      SetValue(tmpSysDefine,'BUIK_LEN1',inttostr(edtLEN1.ItemIndex));
      SetValue(tmpSysDefine,'BUIK_LEN2',inttostr(edtLEN2.ItemIndex));
      SetValue(tmpSysDefine,'BUIK_DEC1',trim(edtDEC1.Text));
      SetValue(tmpSysDefine,'BUIK_DEC2',trim(edtDEC2.Text));
      SetValue(tmpSysDefine,'USING_DATE', FormatDateTime('YYYY-MM-DD', edtUSING_DATE.Date));
      SetValue(tmpSysDefine,'POSDIGHT', inttostr(edtPosDight.value));
      SetValue(tmpSysDefine,'POSCALCDIGHT', inttostr(edtPosCalcDight.ItemIndex-2));
      if edtCARRYRULE.ItemIndex = -1 then
         SetValue(tmpSysDefine,'CARRYRULE', inttostr(0))
      else
         SetValue(tmpSysDefine,'CARRYRULE', inttostr(edtCARRYRULE.ItemIndex));
      if edtZERO_OUT.Checked then
         SetValue(tmpSysDefine,'ZERO_OUT', '1')
      else
         SetValue(tmpSysDefine,'ZERO_OUT', '0');

      try
        if not dataFactory.UpdateBatch(tmpSysDefine, 'TSysDefineV60') then
          tmpSysDefine.CancelUpdates;
      except
        on E:Exception do
        begin
          tmpSysDefine.CancelUpdates;
          Raise Exception.Create('保存失败' + E.Message);
        end;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpSysDefine.Free;
    end;
  end;

  dllGlobal.GetZQueryFromName('SYS_DEFINE').Close;
  DevFactory.InitComm;

  MessageBox(Handle,'保存成功...','友情提示..',MB_OK);
end;

procedure TfrmSysDefine.OpenSysDefine;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.Open(cdsSysDefine, 'TSysDefineV60', Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmSysDefine.btnSaveSysDefineClick(Sender: TObject);
begin
  inherited;
  SaveSysDefine;
end;

procedure TfrmSysDefine.ReadSysDefine;
var F:TIniFile;
begin
  ReadBarCodeRule;

  if cdsSysDefine.Locate('DEFINE','USING_DATE',[]) then
     edtUSING_DATE.Date := FnTime.fnStrtoDate(cdsSysDefine.FieldByName('VALUE').AsString)
  else
     edtUSING_DATE.Date := FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD',now()));

  if cdsSysDefine.Locate('DEFINE','ZERO_OUT',[]) then
  begin
    if cdsSysDefine.FieldByName('VALUE').AsString = '1' then
       edtZERO_OUT.Checked := true
    else
       edtZERO_OUT.Checked := false;
  end
  else
    edtZERO_OUT.Checked := true;

  if cdsSysDefine.Locate('DEFINE','CARRYRULE',[]) then
     edtCARRYRULE.ItemIndex := StrtoIntDef(cdsSysDefine.FieldByName('VALUE').AsString,0)
  else
     edtCARRYRULE.ItemIndex := 0;

  if cdsSysDefine.Locate('DEFINE','POSDIGHT',[]) then
     edtPosDight.Value := StrtoIntDef(cdsSysDefine.FieldByName('VALUE').AsString,2)
  else
     edtPosDight.Value := 2;

  if cdsSysDefine.Locate('DEFINE','POSCALCDIGHT',[]) then
     edtPosCalcDight.ItemIndex := StrtoIntDef(cdsSysDefine.FieldByName('VALUE').AsString,0) + 2
  else
     edtPosCalcDight.ItemIndex := 0;

  //设备参数
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'dev.fty');
  try
    cxNullRow.Value := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTNULL','0'),0);
    edtTicketCopy.Value := StrtoIntDef(F.ReadString('SYS_DEFINE','TICKETCOPY','1'),1);
    edtTicketPrintComm.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTERCOMM','0'),0);
    edtTICKET_PRINT_NAME.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','TICKET_PRINT_NAME','0'),0);
    edtFOOTER.Text := DecStr(F.ReadString('SYS_DEFINE','FOOTER',EncStr('敬请保留小票,以作售后依据',ENC_KEY)),ENC_KEY);
    edtTITLE.Text := DecStr(F.ReadString('SYS_DEFINE','TITLE',EncStr('[企业简称]',ENC_KEY)),ENC_KEY);
    if F.ReadString('SYS_DEFINE','PRINTERWIDTH','33')='38' then
       edtPRINTERWIDTH.ItemIndex := 1
    else
       edtPRINTERWIDTH.ItemIndex := 0;
    cxSavePrint.Checked := F.ReadString('SYS_DEFINE','SAVEPRINT','0')='1';
    cxPrintFormat.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTFORMAT','0'),0);
    cxCashBox.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','CASHBOX','0'),0);
    cxCashBoxRate.ItemIndex := cxCashBoxRate.Properties.Items.IndexOf(F.ReadString('SYS_DEFINE','CASHBOXRATE','0'));
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmSysDefine.ReadBarCodeRule;
begin
  if cdsSysDefine.Locate('DEFINE','BUIK_FLAG',[]) then
     edtFlag.Text := cdsSysDefine.FieldbyName('VALUE').AsString
  else
     edtFlag.Text := '2';
  if cdsSysDefine.Locate('DEFINE','BUIK_ID',[]) then
     edtID.ItemIndex := StrtoIntDef(cdsSysDefine.FieldbyName('VALUE').AsString,5)
  else
     edtID.ItemIndex := 5;
  if cdsSysDefine.Locate('DEFINE','BUIK_ID1',[]) then
     edtID1.ItemIndex := StrtoIntDef(cdsSysDefine.FieldbyName('VALUE').AsString,2)
  else
     edtID1.ItemIndex := 2;
  if cdsSysDefine.Locate('DEFINE','BUIK_ID2',[]) then
     edtID2.ItemIndex := StrtoIntDef(cdsSysDefine.FieldbyName('VALUE').AsString,0)
  else
     edtID2.ItemIndex := 0;
  if cdsSysDefine.Locate('DEFINE','BUIK_LEN1',[]) then
     edtLEN1.ItemIndex := StrtoIntDef(cdsSysDefine.FieldbyName('VALUE').AsString,4)
  else
     edtLEN1.ItemIndex := 4;
  if cdsSysDefine.Locate('DEFINE','BUIK_LEN2',[]) then
     edtLEN2.ItemIndex := StrtoIntDef(cdsSysDefine.FieldbyName('VALUE').AsString,-1)
  else
     edtLEN2.ItemIndex := -1;
  if cdsSysDefine.Locate('DEFINE','BUIK_DEC1',[]) then
     edtDEC1.Text := cdsSysDefine.FieldbyName('VALUE').AsString
  else
     edtDEC1.Text := '2';
  if cdsSysDefine.Locate('DEFINE','BUIK_DEC2',[]) then
     edtDEC2.Text := cdsSysDefine.FieldbyName('VALUE').AsString
  else
     edtDEC2.Text := '2';
end;

procedure TfrmSysDefine.btnDefaultClick(Sender: TObject);
begin
  inherited;
  edtZERO_OUT.checked := true;

  edtPosDight.Value :='2';
  edtPOSCALCDIGHT.ItemIndex := 0;
  edtCARRYRULE.ItemIndex := 0;

  edtFlag.Text := '2';
  edtID.ItemIndex := 5;
  edtID1.ItemIndex := 2;
  edtID2.ItemIndex := 0;
  edtLEN1.ItemIndex := 4;
  edtLEN2.ItemIndex := -1;
  edtDEC1.Text := '2';
  edtDEC2.Text := '2';

  cxNullRow.Value := '0';
  edtTicketCopy.Value := '1';
  edtPRINTERWIDTH.ItemIndex := 0;
  edtTicketPrintComm.ItemIndex := 0;
  edtTICKET_PRINT_NAME.ItemIndex := 0;
  edtTITLE.Text := '[企业简称]';
  edtFOOTER.Text := '敬请保留小票,以作售后依据';
  cxSavePrint.checked := false;
  cxPrintFormat.ItemIndex := 0;

  cxCashBox.ItemIndex := 0;
  cxCashBoxRate.ItemIndex := -1;
end;

procedure TfrmSysDefine.btnSyncClick(Sender: TObject);
begin
  inherited;
  SyncData;
end;

procedure TfrmSysDefine.SetFirstLogin(const Value: boolean);
begin
  FFirstLogin := Value;
  if Value then
  begin
    btnSaveShopInfo.Caption := '开通';
    RzProgressBar1.Percent := 0;
  end
  else
  begin
    btnSaveShopInfo.Caption := '保存';
    RzProgressBar1.Percent := 99;
  end;
end;

procedure TfrmSysDefine.OpenUsers;
begin
  cdsUsers.Close;
  cdsUsers.SQL.Text :=
    'select a.USER_ID,a.TENANT_ID,a.SHOP_ID,b.SHOP_NAME as SHOP_ID_TEXT,a.ACCOUNT,a.USER_NAME,a.PASS_WRD,a.ROLE_IDS,a.ROLE_NAMES as ROLE_IDS_TEXT,a.MOBILE '+
    'from   CA_USERS a '+
    '       left join CA_SHOP_INFO b on a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID '+
    'where  a.COMM not in (''02'',''12'') '+
    '       and a.TENANT_ID='+token.tenantId+' '+
    'order by a.USER_ID';
  dataFactory.Open(cdsUsers);
end;

procedure TfrmSysDefine.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
  rowToolNav.Visible := not cdsUsers.IsEmpty;
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       DBGridEh1.Canvas.Brush.Color := clWhite;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsUsers.RecNo)),length(Inttostr(cdsUsers.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmSysDefine.SaveUsers;
var
  tmpUsers:TZQuery;
  Params:TftParamList;
begin
  CheckUsersInfo;

  if UserState = dsInsert then CurUserId := TSequence.NewId;

  tmpUsers := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('USER_ID').AsString := CurUserId;
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.Open(tmpUsers,'TUsersV60',Params);

    if tmpUsers.IsEmpty then
       begin
         tmpUsers.Append;
         tmpUsers.FieldByName('USER_ID').AsString := CurUserId;
         tmpUsers.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
         tmpUsers.FieldByName('ROLE_IDS').AsString := '#';
         tmpUsers.FieldByName('ROLE_IDS_TEXT').AsString := '#';
         tmpUsers.FieldByName('DUTY_IDS').AsString := token.tenantId + '001';
         tmpUsers.FieldByName('DUTY_IDS_TEXT').AsString := '老板';
         tmpUsers.FieldByName('PASS_WRD').AsString := EncStr('1234',ENC_KEY);
         tmpUsers.FieldByName('DEPT_ID').AsString := token.tenantId + '001';
         tmpUsers.FieldByName('SEX').AsString := '0';
         tmpUsers.FieldByName('DEGREES').AsString := '3';
         tmpUsers.FieldByName('IDN_TYPE').AsString := '1';
       end
    else tmpUsers.Edit;

    tmpUsers.FieldByName('ACCOUNT').AsString := trim(edtACCOUNT.Text);
    tmpUsers.FieldByName('USER_NAME').AsString := trim(edtUSER_NAME.Text);
    tmpUsers.FieldByName('USER_SPELL').AsString := fnString.GetWordSpell(tmpUsers.FieldByName('USER_NAME').AsString,3);
    tmpUsers.FieldByName('SHOP_ID').AsString := token.shopId;
    tmpUsers.FieldByName('MOBILE').AsString := trim(edtMOBILE.Text);
    tmpUsers.Post;

    dataFactory.UpdateBatch(tmpUsers,'TUsersV60');
  finally
    tmpUsers.Free;
    Params.Free;
  end;

  // 本地保存
  if dataFactory.iDbType <> 5 then
  begin
    dataFactory.MoveToSqlite;
    tmpUsers := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('USER_ID').AsString := CurUserId;
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      dataFactory.Open(tmpUsers,'TUsersV60',Params);

      if tmpUsers.IsEmpty then
         begin
           tmpUsers.Append;
           tmpUsers.FieldByName('USER_ID').AsString := CurUserId;
           tmpUsers.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
           tmpUsers.FieldByName('ROLE_IDS').AsString := '#';
           tmpUsers.FieldByName('ROLE_IDS_TEXT').AsString := '#';
           tmpUsers.FieldByName('DUTY_IDS').AsString := token.tenantId + '001';
           tmpUsers.FieldByName('DUTY_IDS_TEXT').AsString := '老板';
           tmpUsers.FieldByName('PASS_WRD').AsString := EncStr('1234',ENC_KEY);
           tmpUsers.FieldByName('DEPT_ID').AsString := token.tenantId + '001';
           tmpUsers.FieldByName('SEX').AsString := '0';
           tmpUsers.FieldByName('DEGRESS').AsString := '3';
           tmpUsers.FieldByName('IDN_TYPE').AsString := '1';
         end
      else tmpUsers.Edit;

      tmpUsers.FieldByName('ACCOUNT').AsString := trim(edtACCOUNT.Text);
      tmpUsers.FieldByName('USER_NAME').AsString := trim(edtUSER_NAME.Text);
      tmpUsers.FieldByName('USER_SPELL').AsString := fnString.GetWordSpell(tmpUsers.FieldByName('USER_NAME').AsString,3);
      tmpUsers.FieldByName('SHOP_ID').AsString := token.shopId;
      tmpUsers.FieldByName('MOBILE').AsString := trim(edtMOBILE.Text);
      tmpUsers.Post;

      dataFactory.UpdateBatch(tmpUsers,'TUsersV60');
    finally
      tmpUsers.Free;
      Params.Free;
      dataFactory.MoveToDefault;
    end;
  end;

  if CurUserId = token.userId then
     begin
       token.account := trim(edtACCOUNT.Text);
       token.username := trim(edtUSER_NAME.Text);
       token.mobile := trim(edtMOBILE.Text);
     end;
  OpenUsers;
  InitCurrentUser;
  dllGlobal.GetZQueryFromName('CA_USERS').Close;
  MessageBox(Handle,'保存成功...','友情提示..',MB_OK);
end;

procedure TfrmSysDefine.btnSaveUsersClick(Sender: TObject);
begin
  inherited;
  SaveUsers;
end;

procedure TfrmSysDefine.btnNewUsersClick(Sender: TObject);
begin
  inherited;
  if (FUserState = dsInsert) or (FUserState = dsEdit) then
     begin
       InitCurrentUser;
     end
  else
     begin
       UserState := dsInsert;
       CurUserId := '';
       CurUserName := '';
       CurUserPswd := '';
       CurUserAccount := '';
       CurUserRoleIds := '';
       edtACCOUNT.Text := '';
       edtUSER_NAME.Text := '';
       edtMOBILE.Text := '';
       edtROLE_NAMES.Text := '';
       if edtACCOUNT.CanFocus then edtACCOUNT.SetFocus;
     end;
end;

procedure TfrmSysDefine.CheckUsersInfo;
begin
  if trim(edtACCOUNT.Text) = '' then
     begin
       if edtACCOUNT.CanFocus then edtACCOUNT.SetFocus;
       Raise Exception.Create('用户账号不允许为空！');
     end;
  if trim(edtUSER_NAME.Text) = '' then
     begin
       if edtUSER_NAME.CanFocus then edtUSER_NAME.SetFocus;
       Raise Exception.Create('用户姓名不允许为空！');
     end;
end;

procedure TfrmSysDefine.GrantRights;
var roleIds,roleNames:string;
begin
  if cdsUsers.FieldByName('USER_ID').AsString = '' then Exit;
  roleIds := cdsUsers.FieldByName('ROLE_IDS').AsString;
  if TfrmUserRights.ShowUserRight(cdsUsers.FieldByName('USER_ID').AsString,
                                  cdsUsers.FieldByName('USER_NAME').AsString,
                                  cdsUsers.FieldByName('ACCOUNT').AsString,
                                  roleIds,roleNames) then
  begin
    if not (cdsUsers.State in [dsInsert,dsEdit]) then cdsUsers.Edit;
    if roleNames = '' then roleNames := '#';
    cdsUsers.FieldByName('ROLE_IDS').AsString:=roleIds;
    cdsUsers.FieldByName('ROLE_IDS_TEXT').AsString:=roleNames;
    cdsUsers.Post;
    if CurUserId = cdsUsers.FieldByName('USER_ID').AsString then
       edtROLE_NAMES.Text := roleNames;
  end;
end;

procedure TfrmSysDefine.Tool_EditClick(Sender: TObject);
begin
  inherited;
  if cdsUsers.IsEmpty then Exit;
  UserState := dsEdit;
  CurUserId := cdsUsers.FieldByName('USER_ID').AsString;
  CurUserName := cdsUsers.FieldByName('USER_NAME').AsString;
  CurUserPswd := cdsUsers.FieldByName('PASS_WRD').AsString;
  CurUserAccount := cdsUsers.FieldByName('ACCOUNT').AsString;
  CurUserRoleIds := cdsUsers.FieldByName('ROLE_IDS_TEXT').AsString;
  edtACCOUNT.Text := cdsUsers.FieldByName('ACCOUNT').AsString;
  edtUSER_NAME.Text := cdsUsers.FieldByName('USER_NAME').AsString;
  edtMOBILE.Text := cdsUsers.FieldByName('MOBILE').AsString;
  edtROLE_NAMES.Text := cdsUsers.FieldByName('ROLE_IDS_TEXT').AsString;
end;

procedure TfrmSysDefine.Tool_DelClick(Sender: TObject);
begin
  inherited;
  if cdsUsers.IsEmpty then Exit;
  if MessageBox(Handle,Pchar('确定要删除'+cdsUsers.FieldByName('USER_NAME').AsString+'吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) = 6 then
  begin
    try
      cdsUsers.CommitUpdates;
      cdsUsers.Delete;
      dataFactory.UpdateBatch(cdsUsers,'TUsersV60');
    except
      cdsUsers.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmSysDefine.RzLabel40Click(Sender: TObject);
begin
  inherited;
  SaveFolderDialog.FileName := 'db_'+FormatDateTime('YYYYMMDDHHMMSSZZZ',now())+'.bak';
  if SaveFolderDialog.Execute then
     begin
       edtSaveFolder.Text := SaveFolderDialog.FileName;
     end;
end;

procedure TfrmSysDefine.btnBackUpClick(Sender: TObject);
begin
  inherited;
  if trim(edtSaveFolder.Text) = '' then Raise Exception.Create('请选择数据存储位置...');
  ForceDirectories(ExtractFileDir(trim(edtSaveFolder.Text))); 
  if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),pchar(trim(edtSaveFolder.Text)),false) then
     MessageBox(Handle,'数据备份成功...','友情提示..',MB_OK)
  else MessageBox(Handle,'数据备份失败...','友情提示..',MB_OK);
end;

procedure TfrmSysDefine.RzLabel41Click(Sender: TObject);
begin
  inherited;
  if OpenBackUpDialog.Execute then
     begin
       edtBackUpFile.Text := OpenBackUpDialog.FileName;
     end;
end;

procedure TfrmSysDefine.FileRecovery(src:string;AppHandle:HWnd);
var rs:TZQuery;
begin
  if not SyncFactory.CheckValidDBFile(src) then Raise Exception.Create('所恢复的文件不是有效数据文件，无法进行文件恢复...');
  try
    if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),pchar(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6'),false) then
       begin
         if CopyFile(pchar(src),pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),false) then
            begin
              dataFactory.sqlite.Connect;
              rs := TZQuery.Create(nil);
              dataFactory.MoveToSqlite;
              try
                rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE = ''TENANT_ID'' and TENANT_ID=0';
                dataFactory.Open(rs);
                SyncFactory.RecoverySync(AppHandle);
                MessageBox(AppHandle,'数据恢复成功...','友情提示..',MB_OK);
                RtcSyncClose;
                if FileExists(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6') then
                   DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6');
              finally
                dataFactory.MoveToDefault;
                rs.Free;
              end;
            end
         else
            begin
              Raise Exception.Create('数据恢复失败...');
            end;
       end
    else
       begin
         MessageBox(AppHandle,'数据恢复失败，原因：文件备份发生错误...','友情提示..',MB_OK);
       end;
  except
    on E:Exception do
       begin
         if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6'),pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),false) then
         begin
           dataFactory.sqlite.Connect;
           if FileExists(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6') then
              DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6');
         end;
         Raise Exception.Create('数据恢复失败，原因：'+E.Message);
       end;
  end;
end;

procedure TfrmSysDefine.btnRecoveryClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if trim(edtBackUpFile.Text) = '' then Raise Exception.Create('请选择要恢复的备份文件...');
  FileRecovery(trim(edtBackUpFile.Text),self.Handle);
end;

procedure TfrmSysDefine.RzLabel9Click(Sender: TObject);
var img:string;
begin
  inherited;
  if OpenImageDialog.Execute then
     begin
       img := OpenImageDialog.FileName;
       if CopyFile(pchar(img),pchar(ExtractFilePath(Application.ExeName)+'built-in\images\user.png'),false) then
          begin
            if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\user.png') then
               Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\user.png');
          end;
     end;
end;

procedure TfrmSysDefine.SetCurUserAccount(const Value: string);
begin
  FCurUserAccount := Value;
  if (FCurUserId <> 'admin') and (FCurUserId <> 'system') and (FCurUserAccount <> token.xsmCode) then
     begin
       edtACCOUNT.Properties.ReadOnly := false;
       edtUSER_NAME.Properties.ReadOnly := false;
       edtMOBILE.Properties.ReadOnly := false;
       SetEditStyle(dsInsert,edtACCOUNT.Style);
       SetEditStyle(dsInsert,edtUSER_NAME.Style);
       SetEditStyle(dsInsert,edtMOBILE.Style);
       edtBK_ACCOUNT.Color := edtACCOUNT.Style.Color;
       edtBK_USER_NAME.Color := edtUSER_NAME.Style.Color;
       edtBK_MOBILE.Color := edtMOBILE.Style.Color;
       btnSaveUsers.Visible := true
     end
  else
     begin
       edtACCOUNT.Properties.ReadOnly := true;
       edtUSER_NAME.Properties.ReadOnly := true;
       edtMOBILE.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse,edtACCOUNT.Style);
       SetEditStyle(dsBrowse,edtUSER_NAME.Style);
       SetEditStyle(dsBrowse,edtMOBILE.Style);
       edtBK_ACCOUNT.Color := edtACCOUNT.Style.Color;
       edtBK_USER_NAME.Color := edtUSER_NAME.Style.Color;
       edtBK_MOBILE.Color := edtMOBILE.Style.Color;
       btnSaveUsers.Visible := false;
     end;
end;

procedure TfrmSysDefine.SetCurUserId(const Value: string);
begin
  FCurUserId := Value;
  if (FCurUserId = token.userId) and (token.account <> token.xsmCode) and (token.account <> 'system') then
     RzPanel37.Visible := true
  else
     RzPanel37.Visible := false;

  if (FCurUserId <> 'admin') and (FCurUserId <> 'system') and (FCurUserAccount <> token.xsmCode) then
     begin
       edtACCOUNT.Properties.ReadOnly := false;
       edtUSER_NAME.Properties.ReadOnly := false;
       edtMOBILE.Properties.ReadOnly := false;
       SetEditStyle(dsInsert,edtACCOUNT.Style);
       SetEditStyle(dsInsert,edtUSER_NAME.Style);
       SetEditStyle(dsInsert,edtMOBILE.Style);
       edtBK_ACCOUNT.Color := edtACCOUNT.Style.Color;
       edtBK_USER_NAME.Color := edtUSER_NAME.Style.Color;
       edtBK_MOBILE.Color := edtMOBILE.Style.Color;
       btnSaveUsers.Visible := true
     end
  else
     begin
       edtACCOUNT.Properties.ReadOnly := true;
       edtUSER_NAME.Properties.ReadOnly := true;
       edtMOBILE.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse,edtACCOUNT.Style);
       SetEditStyle(dsBrowse,edtUSER_NAME.Style);
       SetEditStyle(dsBrowse,edtMOBILE.Style);
       edtBK_ACCOUNT.Color := edtACCOUNT.Style.Color;
       edtBK_USER_NAME.Color := edtUSER_NAME.Style.Color;
       edtBK_MOBILE.Color := edtMOBILE.Style.Color;
       btnSaveUsers.Visible := false;
     end;
end;

procedure TfrmSysDefine.SetCurUserName(const Value: string);
begin
  FCurUserName := Value;
end;

procedure TfrmSysDefine.SetCurUserPswd(const Value: string);
begin
  FCurUserPswd := Value;
end;

procedure TfrmSysDefine.SetCurUserRoleIds(const Value: string);
begin
  FCurUserRoleIds := Value;
end;

procedure TfrmSysDefine.SetUserState(const Value: TDataSetState);
begin
  FUserState := Value;
  if (FUserState = dsInsert) or (FUserState = dsEdit) then
     btnNewUsers.Caption := '取消'
  else
     btnNewUsers.Caption := '新增';
end;

procedure TfrmSysDefine.Tool_ResetClick(Sender: TObject);
var str:string;
begin
  inherited;
  if cdsUsers.IsEmpty then Exit;
  if MessageBox(Handle,Pchar('确定要重置'+cdsUsers.FieldByName('USER_NAME').AsString+'的密码为1234吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) = 6 then
  begin
    str := 'update CA_USERS set PASS_WRD='''+EncStr('1234',ENC_KEY)+''',COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where USER_ID='''+cdsUsers.FieldbyName('USER_ID').AsString+''' and TENANT_ID='+token.tenantId;
    if dataFactory.ExecSQL(str) > 0 then
      MessageBox(handle,Pchar('提示:密码重置成功...'),Pchar(Caption),MB_OK)
    else
      MessageBox(handle,Pchar('提示:密码重置失败...'),Pchar(Caption),MB_OK);
  end;
end;

procedure TfrmSysDefine.btnCancelClick(Sender: TObject);
begin
  inherited;
  pnl_changepswd.Visible := false;
end;

procedure TfrmSysDefine.RzLabel37Click(Sender: TObject);
begin
  inherited;
  edtOLD_PSWD.Text := '';
  edtNEW_PSWD1.Text := '';
  edtNEW_PSWD2.Text := '';
  pnl_changepswd.Visible := true;
  if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
end;

procedure TfrmSysDefine.btnChangeClick(Sender: TObject);
var
  str,newPswd:string;
  rs:TZQuery;
begin
  inherited;
  if edtOLD_PSWD.Text = '' then
  begin
    if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
    Raise Exception.Create('请输入旧密码...');
  end;
  if edtNEW_PSWD1.Text = '' then
  begin
    if edtNEW_PSWD1.CanFocus then edtNEW_PSWD1.SetFocus;
    Raise Exception.Create('请输入新密码...');
  end;
  if edtNEW_PSWD2.Text = '' then
  begin
    if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
    Raise Exception.Create('请再输入一次...');
  end;
  if edtNEW_PSWD1.Text <> edtNEW_PSWD2.Text then
  begin
    if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
    Raise Exception.Create('两次密码输入不一致...');
  end;
  if (lowercase(CurUserId)='admin') then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+token.tenantId+' and DEFINE=''PASSWRD'' ';
      dataFactory.Open(rs);
      CurUserPswd := rs.Fields[0].AsString;
    finally
      rs.Free;
    end;
  end;
  if edtOLD_PSWD.Text <> DecStr(CurUserPswd,ENC_KEY) then
  begin
    if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
    Raise Exception.Create('旧密码密码输入错误...');
  end;

  newPswd := UpperCase(edtNEW_PSWD1.Text);
  if (lowercase(CurUserId)<>'admin') then
    str := 'update CA_USERS set PASS_WRD=''' + EncStr(newPswd,ENC_KEY) + ''',COMM=' + GetCommStr(dataFactory.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and '+
           'USER_ID=''' + token.userId + ''''
  else
    str := 'update SYS_DEFINE set VALUE=''' + EncStr(newPswd,ENC_KEY) + ''',COMM=' + GetCommStr(dataFactory.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and '+
           'DEFINE=''PASSWRD''';
  try
    if dataFactory.ExecSQL(str) <> 1 then Raise Exception.Create('无法修改'+CurUserName+'账户的密码');
    MessageBox(Handle,'密码修改成功...','友情提示..',MB_OK);
    pnl_changepswd.Visible := false;
  except           
    Raise Exception.Create('修改失败...');
  end;
end;

procedure TfrmSysDefine.SyncData;
begin
  SyncDataing := true;
  try
    SyncFactory.RegisterSync(self.Handle);
  finally
    SyncDataing := false;
  end;
end;

function TfrmSysDefine.checkCanClose: boolean;
begin
  if SyncDataing then
     result := false
  else
     result := true;
end;

procedure TfrmSysDefine.showForm;
begin
  inherited;
  if dllGlobal.GetSFVersion <> '.LCL' then
     RzBmpButton4.Visible := false;

  if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\user.png') then
     Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\user.png');

  if FirstLogin then
    GetShopInfo
  else
    OpenShopInfo;

  ReadFromObject(0);
end;

class function TfrmSysDefine.AutoRegister: boolean;
begin
  result := false;
  if token.tenantId <> '' then
     begin
       result := true;
       Exit;
     end;
  with TfrmSysDefine.Create(nil) do
  begin
    try
      try
        GetShopInfo;
      except
        MessageBox(Handle,pchar('尚未开通门店管理功能，请联系客户经理...'+dllGlobal.GetServiceInfo),'友情提示..',MB_OK);
        Exit;
      end;
      SaveShopInfo(true);
      result := true;
    finally
      Free;
    end;
  end;
end;

class procedure TfrmSysDefine.SaveRegister;
begin
  with TfrmSysDefine.Create(nil) do
  begin
    try
      SaveRegisterParams;
    finally
      Free;
    end;
  end;
end;

procedure TfrmSysDefine.Tool_RightClick(Sender: TObject);
begin
  inherited;
  GrantRights;
end;

procedure TfrmSysDefine.btnRecoveryRemoteClick(Sender: TObject);
var recType:string;
begin
  inherited;
  if Recovery_1.Checked then
     begin
       recType := '1';
     end
  else if Recovery_2.Checked then
     begin
       recType := '2';
     end
  else if Recovery_3.Checked then
     begin
       recType := '3';
     end;
  RemoteRecovery(recType,self.Handle);
end;

procedure TfrmSysDefine.RemoteRecovery(recType:string;AppHandle:HWnd);
var
  rs:TZQuery;
  str,BeginDate,MaxDate:string;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select 1 from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create('本地存在业务数据，无法进行数据恢复...');
  finally
    rs.Free;
  end;

  if recType = '1' then
     begin
       BeginDate := FormatDateTime('YYYYMM',IncMonth(now(),-1));
     end
  else if recType = '2' then
     begin
       BeginDate := FormatDateTime('YYYYMM',IncMonth(now(),-2));
     end
  else
     begin
       BeginDate := FormatDateTime('YYYYMM',IncMonth(now(),-3));
     end;
  BeginDate := BeginDate + '01';

  try
    // 同步数据
    SyncFactory.RecoverySync(AppHandle,BeginDate);

    // 试算台账、矫正库存
    TfrmStocksCalc.Calc(Application.MainForm);

    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select max(BILL_DATE) from '+
                     '('+
                     '  select max(STOCK_DATE)  BILL_DATE from STK_STOCKORDER  where TENANT_ID='+token.tenantId+' and STOCK_DATE >='+BeginDate+' '+
                     '  union all '+
                     '  select max(SALES_DATE)  BILL_DATE from SAL_SALESORDER  where TENANT_ID='+token.tenantId+' and SALES_DATE >='+BeginDate+' '+
                     '  union all '+
                     '  select max(CHANGE_DATE) BILL_DATE from STO_CHANGEORDER where TENANT_ID='+token.tenantId+' and CHANGE_DATE>='+BeginDate+' '+
                     ') T';
      dataFactory.Open(rs);
      if rs.IsEmpty then
         MaxDate := FormatDateTime('YYYYMMDD',now())
      else
         begin
           if trim(rs.Fields[0].AsString) = '' then
              MaxDate := FormatDateTime('YYYYMMDD',now())
           else
              MaxDate := rs.Fields[0].AsString;
         end;
    finally
      rs.Free;
    end;

    str :=
       'select TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
       'sum(case when BILL_DATE<='+BeginDate+' and BILL_TYPE in (0,1) then BAL_AMOUNT when BILL_DATE<'+BeginDate+' then IN_AMOUNT-OUT_AMOUNT else 0 end) as BEG_AMOUNT,'+
       'sum(case when BILL_DATE<='+BeginDate+' and BILL_TYPE in (0,1) then BAL_MONEY  when BILL_DATE<'+BeginDate+' then IN_MONEY-OUT_MONEY else 0 end) as BEG_MONEY,'+
       'sum(case when BILL_DATE>='+BeginDate+' then IN_AMOUNT else 0 end) as IN_AMOUNT,'+
       'sum(case when BILL_DATE>='+BeginDate+' then IN_MONEY else 0 end) as IN_MONEY,'+
       'sum(case when BILL_DATE>='+BeginDate+' then OUT_AMOUNT else 0 end) as OUT_AMOUNT,'+
       'sum(case when BILL_DATE>='+BeginDate+' then OUT_MONEY else 0 end) as OUT_MONEY '+
       'from RCK_STOCKS_DATA where TENANT_ID='+token.tenantId+' and BILL_DATE>='+BeginDate+' and BILL_DATE<='+MaxDate;
    str := str + ' and SHOP_ID='''+token.shopId+'''';
    str := str + ' group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO';
    str :=
      ParseSQL(dataFactory.iDbType,
      ' select j.TENANT_ID,j.SHOP_ID,j.GODS_ID,j.BATCH_NO,''#'' PROPERTY_01,''#'' PROPERTY_02,'+
      '        j.BEG_MONEY+j.IN_MONEY-j.OUT_MONEY as BAL_MONEY,'+
      '        j.BEG_AMOUNT+j.IN_AMOUNT-j.OUT_AMOUNT as BAL_AMOUNT,'+
      '        case '+
      '          when j.BEG_AMOUNT+j.IN_AMOUNT-j.OUT_AMOUNT = 0 then 0'+
      '          else cast((j.BEG_MONEY+j.IN_MONEY-j.OUT_MONEY) / (j.BEG_AMOUNT+j.IN_AMOUNT-j.OUT_AMOUNT) as decimal(18,6)) '+
      '        end COST_PRICE, '+
      '        ''00'','+GetTimeStamp(dataFactory.iDbType)+
      ' from   ('+str+') j ');

    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := str;
      dataFactory.Open(rs);
      rs.First;
      dataFactory.BeginTrans;
      try
        dataFactory.ExecSQL('delete from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+'''');
        while not rs.Eof do
          begin
            str := ' insert into STO_STORAGE '+
                   ' (ROWS_ID,TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,AMONEY,AMOUNT,COST_PRICE,COMM,TIME_STAMP) '+
                   ' values '+
                   ' ('+
                   ' '''+TSequence.NewId+''','+rs.FieldByName('TENANT_ID').AsString+','''+rs.FieldByName('SHOP_ID').AsString+''','''+
                     rs.FieldByName('GODS_ID').AsString+''','''+rs.FieldByName('BATCH_NO').AsString+''',''#'',''#'','+
                     rs.FieldByName('BAL_MONEY').AsString+','+rs.FieldByName('BAL_AMOUNT').AsString+','+rs.FieldByName('COST_PRICE').AsString+
                     ',''00'','+GetTimeStamp(dataFactory.iDbType)+
                   ' )';
            dataFactory.ExecSQL(str);
            rs.Next;
          end;
        dataFactory.CommitTrans;
      except
        dataFactory.RollbackTrans;
        Raise;
      end;
    finally
      rs.Free;
    end;
  except
    dataFactory.ExecSQL('delete from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+'''');
    Raise;
  end;

  //关账
  SyncFactory.RecoveryClose(BeginDate);

  RtcSyncClose;
end;

procedure TfrmSysDefine.RtcSyncClose;
var
  rs:TZQuery;
  timeStamp:string;
begin
  dataFactory.MoveToSqlite;
  try
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select max(TIME_STAMP) TIME_STAMP from SYS_SYNC_CTRL';
      dataFactory.Open(rs);
      timeStamp := rs.Fields[0].AsString;
    finally
      rs.Free;
    end;
    dataFactory.BeginTrans;
    try
      dataFactory.ExecSQL('delete from SYS_SYNC_CTRL where TENANT_ID='+token.tenantId+' and SHOP_ID = '''+token.shopId+''' and TABLE_NAME in (''RTC_STK_STOCKORDER'',''RTC_SAL_SALESORDER'',''RTC_PUB_CUSTOMER'') ');
      dataFactory.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+token.tenantId+','''+token.shopId+''',''RTC_STK_STOCKORDER'','+timeStamp+') ');
      dataFactory.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+token.tenantId+','''+token.shopId+''',''RTC_SAL_SALESORDER'','+timeStamp+') ');
      dataFactory.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+token.tenantId+','''+token.shopId+''',''RTC_PUB_CUSTOMER'','+timeStamp+') ');
      dataFactory.CommitTrans;
    except
      dataFactory.RollbackTrans;
      Raise;
    end;
  finally
    dataFactory.MoveToDefault;
  end;
end;

class procedure TfrmSysDefine.DBFileRecovery(src:string;AppHandle:HWnd);
begin
  with TfrmSysDefine.Create(nil) do
  begin
    try
      FileRecovery(src,AppHandle);
    finally
      Free;
    end;
  end;
end;

class procedure TfrmSysDefine.DBRemoteRecovery(recType:string;AppHandle:HWnd);
begin
  with TfrmSysDefine.Create(nil) do
  begin
    try
      RemoteRecovery(recType,AppHandle);
    finally
      Free;
    end;
  end;
end;

initialization
  RegisterClass(TfrmSysDefine);
finalization
  UnRegisterClass(TfrmSysDefine);
end.
