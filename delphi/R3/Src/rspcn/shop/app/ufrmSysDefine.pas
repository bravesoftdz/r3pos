unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzTabs,
  RzBmpBtn, jpeg, RzButton, cxControls, cxContainer, cxEdit, cxTextEdit,
  ComCtrls, RzPrgres, cxMaskEdit, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, msxml,
  cxDropDownEdit, cxCalendar, cxCheckBox, cxMemo, cxSpinEdit, IniFiles,
  Grids, DBGridEh, RzBckgnd, RzBorder, ObjCommon;

type
  TfrmSysDefine = class(TfrmWebToolForm)
    lblCaption: TRzLabel;
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
    RzPanel77: TRzPanel;
    RzPanel41: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel10: TRzLabel;
    edtSHOP_NAME: TcxTextEdit;
    RzPanel20: TRzPanel;
    RzPanel42: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel11: TRzLabel;
    edtLICENSE_CODE: TcxTextEdit;
    RzPanel4: TRzPanel;
    RzPanel43: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel12: TRzLabel;
    edtLINKMAN: TcxTextEdit;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel13: TRzLabel;
    edtTELEPHONE: TcxTextEdit;
    RzPanel6: TRzPanel;
    RzPanel44: TRzPanel;
    RzBackground6: TRzBackground;
    RzLabel14: TRzLabel;
    edtADDRESS: TcxTextEdit;
    RzPanel45: TRzPanel;
    RzPanel46: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel15: TRzLabel;
    edtREGION_ID: TzrComboBoxList;
    btnSaveShopInfo: TRzBmpButton;
    btnSync: TRzBmpButton;
    RzPanel5: TRzPanel;
    RzPanel9: TRzPanel;
    RzBackground8: TRzBackground;
    RzLabel16: TRzLabel;
    edtUSING_DATE: TcxDateEdit;
    RzPanel11: TRzPanel;
    RzPanel47: TRzPanel;
    RzBackground9: TRzBackground;
    RzLabel17: TRzLabel;
    edtPOSCALCDIGHT: TcxComboBox;
    RzPanel26: TRzPanel;
    RzPanel48: TRzPanel;
    RzBackground10: TRzBackground;
    RzLabel18: TRzLabel;
    edtPosDight: TcxSpinEdit;
    RzPanel25: TRzPanel;
    RzPanel49: TRzPanel;
    RzBackground11: TRzBackground;
    RzLabel19: TRzLabel;
    edtCARRYRULE: TcxComboBox;
    RzPanel27: TRzPanel;
    RzPanel50: TRzPanel;
    RzBackground12: TRzBackground;
    RzLabel20: TRzLabel;
    edtFlag: TcxTextEdit;
    RzPanel28: TRzPanel;
    RzPanel51: TRzPanel;
    RzBackground13: TRzBackground;
    RzLabel21: TRzLabel;
    edtID: TcxComboBox;
    RzPanel29: TRzPanel;
    RzPanel52: TRzPanel;
    RzBackground14: TRzBackground;
    RzLabel22: TRzLabel;
    edtID1: TcxComboBox;
    edtLEN1: TcxComboBox;
    edtDEC1: TcxTextEdit;
    RzPanel30: TRzPanel;
    RzPanel33: TRzPanel;
    RzBackground15: TRzBackground;
    RzLabel23: TRzLabel;
    edtID2: TcxComboBox;
    edtLEN2: TcxComboBox;
    edtDEC2: TcxTextEdit;
    RzPanel31: TRzPanel;
    RzPanel32: TRzPanel;
    RzBackground16: TRzBackground;
    RzLabel24: TRzLabel;
    RzPanel53: TRzPanel;
    RzPanel54: TRzPanel;
    RzBackground17: TRzBackground;
    RzLabel25: TRzLabel;
    RzPanel55: TRzPanel;
    RzPanel56: TRzPanel;
    RzBackground18: TRzBackground;
    RzLabel26: TRzLabel;
    edtTicketPrintComm: TcxComboBox;
    RzPanel15: TRzPanel;
    RzPanel57: TRzPanel;
    RzBackground19: TRzBackground;
    RzLabel27: TRzLabel;
    edtPRINTERWIDTH: TcxComboBox;
    RzPanel17: TRzPanel;
    RzPanel58: TRzPanel;
    RzBackground20: TRzBackground;
    RzLabel28: TRzLabel;
    edtTitle: TcxTextEdit;
    RzPanel18: TRzPanel;
    RzPanel59: TRzPanel;
    RzBackground21: TRzBackground;
    RzLabel29: TRzLabel;
    edtFOOTER: TcxMemo;
    RzPanel14: TRzPanel;
    RzPanel60: TRzPanel;
    RzBackground22: TRzBackground;
    RzLabel30: TRzLabel;
    cxNullRow: TcxSpinEdit;
    RzPanel16: TRzPanel;
    RzPanel21: TRzPanel;
    RzBackground23: TRzBackground;
    RzLabel31: TRzLabel;
    edtTicketCopy: TcxSpinEdit;
    RzPanel61: TRzPanel;
    RzPanel62: TRzPanel;
    RzBackground24: TRzBackground;
    RzLabel32: TRzLabel;
    edtTICKET_PRINT_NAME: TcxComboBox;
    RzPanel19: TRzPanel;
    RzPanel63: TRzPanel;
    RzBackground25: TRzBackground;
    RzLabel33: TRzLabel;
    cxCashBox: TcxComboBox;
    RzPanel22: TRzPanel;
    RzPanel23: TRzPanel;
    RzBackground26: TRzBackground;
    RzLabel34: TRzLabel;
    cxCashBoxRate: TcxComboBox;
    btnDefault: TRzBmpButton;
    btnSaveSysDefine: TRzBmpButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
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
    pnl_left_line: TImage;
    pnl_right_line: TImage;
    pnl_top: TRzPanel;
    pnl_top_left: TImage;
    pnl_top_right: TImage;
    pnl_top_line: TImage;
    pnl_bottom: TRzPanel;
    barcode_panel_bottom_line: TImage;
    barcodeb_panel_right_line: TImage;
    barcodeb_panel_left_line: TImage;
    RzPanel66: TRzPanel;
    RzPanel67: TRzPanel;
    RzBackground30: TRzBackground;
    RzLabel38: TRzLabel;
    edtMOBILE: TcxTextEdit;
    RzPanel39: TRzPanel;
    RzPanel68: TRzPanel;
    RzBackground31: TRzBackground;
    RzLabel39: TRzLabel;
    edtROLE_NAMES: TcxTextEdit;
    RzPanel24: TRzPanel;
    RzPanel64: TRzPanel;
    RzBackground27: TRzBackground;
    RzLabel35: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    RzPanel36: TRzPanel;
    RzPanel65: TRzPanel;
    RzBackground28: TRzBackground;
    RzLabel36: TRzLabel;
    edtUSER_NAME: TcxTextEdit;
    btnSaveUsers: TRzBmpButton;
    btnNewUsers: TRzBmpButton;
    RzPanel13: TRzPanel;
    RzBackground34: TRzBackground;
    btnGrantRights: TRzLabel;
    RzSpacer2: TRzSpacer;
    RzToolButton3: TRzToolButton;
    RzPanel37: TRzPanel;
    RzBackground29: TRzBackground;
    RzLabel37: TRzLabel;
    pnl_changepswd: TRzPanel;
    RzPanel72: TRzPanel;
    RzPanel73: TRzPanel;
    RzBackground35: TRzBackground;
    RzLabel46: TRzLabel;
    edtOLD_PSWD: TcxTextEdit;
    RzPanel38: TRzPanel;
    RzPanel74: TRzPanel;
    RzBackground36: TRzBackground;
    RzLabel47: TRzLabel;
    edtNEW_PSWD1: TcxTextEdit;
    RzPanel75: TRzPanel;
    RzPanel76: TRzPanel;
    RzBackground37: TRzBackground;
    RzLabel48: TRzLabel;
    edtNEW_PSWD2: TcxTextEdit;
    btnChange: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzPanel78: TRzPanel;
    RzPanel79: TRzPanel;
    RzBackground38: TRzBackground;
    RzLabel49: TRzLabel;
    edtINPUT_MODE: TcxComboBox;
    RzPanel80: TRzPanel;
    RzPanel81: TRzPanel;
    RzBackground39: TRzBackground;
    RzLabel50: TRzLabel;
    edtINDUSTRY_TYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    procedure btnGrantRightsClick(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure RzLabel40Click(Sender: TObject);
    procedure btnBackUpClick(Sender: TObject);
    procedure RzLabel41Click(Sender: TObject);
    procedure btnRecoveryClick(Sender: TObject);
    procedure RzLabel9Click(Sender: TObject);
    procedure RzToolButton3Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure RzLabel37Click(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
  private
    SyncDataing:boolean;
    FCurUserId:string;
    FCurUserName:string;
    FCurUserPswd:string;
    FCurUserAccount:string;
    FCurUserRoleIds:string;
    FNewUser:boolean;
    FFirstLogin:boolean;
    function  CheckRegister:boolean;
    procedure OpenShopInfo(tenantId:string='';shopId:string='');
    procedure GetShopInfo;
    procedure SaveShopInfo;
    procedure SaveRegisterParams;
    procedure InitTenant;
    procedure SyncData;
    
    procedure OpenSysDefine;
    procedure ReadSysDefine;
    procedure ReadBarCodeRule;
    procedure SaveSysDefine;

    procedure OpenUsers;
    procedure SaveUsers;
    procedure GrantRights;
    procedure CheckUsersInfo;

    procedure ReadFromObject(PageIndex:integer);
    procedure WriteToObject;

    procedure SetFirstLogin(const Value: boolean);
    procedure SetNewUser(const Value: boolean);
    procedure SetCurUserId(const Value: string);
    procedure SetCurUserName(const Value: string);
    procedure SetCurUserPswd(const Value: string);
    procedure SetCurUserAccount(const Value: string);
    procedure SetCurUserRoleIds(const Value: string);
  public
    AObj:TRecord_;
    function checkCanClose:boolean;override;
    property FirstLogin:boolean read FFirstLogin write SetFirstLogin;
    property NewUser:boolean read FNewUser write SetNewUser;
    property CurUserId:string read FCurUserId write SetCurUserId;
    property CurUserName:string read FCurUserName write SetCurUserName;
    property CurUserPswd:string read FCurUserPswd write SetCurUserPswd;
    property CurUserAccount:string read FCurUserAccount write SetCurUserAccount;
    property CurUserRoleIds:string read FCurUserRoleIds write SetCurUserRoleIds;
  end;

implementation

uses udllGlobal,udataFactory,uTokenFactory,uRspFactory,udllShopUtil,EncDec,ufrmSyncData,
     uSyncFactory,udllFnUtil,uRspSyncFactory,uRightsFactory,udllDsUtil,ufrmUserRights,
     uDevFactory;

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
  edtSaveFolder.Properties.ReadOnly := true;
  edtBackUpFile.Properties.ReadOnly := true;
  if (token.userId <> 'admin') and (token.userId <> 'system') and (token.account <> token.xsmCode) then
     RzToolButton3.Visible := false
  else
     RzToolButton3.Visible := true;
  PageControl.ActivePageIndex := 0;
end;

procedure TfrmSysDefine.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp') then
     Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp');

  if FirstLogin then
    GetShopInfo
  else
    OpenShopInfo;

  ReadFromObject(0);
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
begin
  if PageIndex = 0 then
  begin
    AObj.ReadFromDataSet(cdsShopInfo);
    udllShopUtil.ReadFromObject(AObj,self);
    if FirstLogin then
       begin
         edtINPUT_MODE.ItemIndex := 0;
         edtINDUSTRY_TYPE.ItemIndex := 0;
       end
    else
       begin
         edtINPUT_MODE.ItemIndex := strtointdef(dllGlobal.GetParameter('INPUT_MODE'),0);
         edtINDUSTRY_TYPE.ItemIndex := TdsItems.FindItems(edtINDUSTRY_TYPE.Properties.Items,'CODE_ID',dllGlobal.GetParameter('INDUSTRY_TYPE'));
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
  SaveShopInfo;
end;

procedure TfrmSysDefine.SaveShopInfo;
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
  WriteToObject;

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
    SaveRegisterParams;
    SyncData;
    FirstLogin := false;
    RzBmpButton2.Visible := true;
    RzBmpButton3.Visible := true;
    RzBmpButton4.Visible := true;
    OpenShopInfo(cdsShopInfo.FieldByName('TENANT_ID').AsString,cdsShopInfo.FieldByName('SHOP_ID').AsString);
  end;

  Params := TftParamList.Create(nil);
  tmpSysDefine := TZQuery.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.Open(tmpSysDefine, 'TSysDefineV60', Params);
    SetValue(tmpSysDefine,'INPUT_MODE',inttostr(edtINPUT_MODE.ItemIndex));
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
      SetValue(tmpSysDefine,'INPUT_MODE',inttostr(edtINPUT_MODE.ItemIndex));
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

  MessageBox(Handle,'保存成功...','友情提示..',MB_OK);
end;

procedure TfrmSysDefine.SaveRegisterParams;
begin
  dataFactory.MoveToSqlite;
  try
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+cdsTenant.FieldByName('TENANT_ID').AsString+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''TENANT_ID'','''+cdsTenant.FieldByName('TENANT_ID').AsString+''',0,''00'',5497000)');
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+cdsTenant.FieldByName('TENANT_ID').AsString+''' where TENANT_ID='+cdsTenant.FieldByName('TENANT_ID').AsString+' and DEFINE=''TENANT_ID''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+cdsTenant.FieldByName('TENANT_ID').AsString+',''TENANT_ID'','''+cdsTenant.FieldByName('TENANT_ID').AsString+''',0,''00'',5497000)');
  finally
    dataFactory.MoveToDefault;
  end;

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

procedure TfrmSysDefine.RzBmpButton3Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 2 then
  begin
    OpenUsers;
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
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 2;
end;

procedure TfrmSysDefine.RzBmpButton4Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if PageControl.ActivePageIndex <> 3 then
  begin
    edtSaveFolder.Text := ExtractFilePath(Application.ExeName)+'backup\'+'db_'+FormatDateTime('YYYYMMDDHHMMSSZZZ',now())+'.bak'; 
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
     edtUSING_DATE.Date := udllFnUtil.FnTime.fnStrtoDate(cdsSysDefine.FieldByName('VALUE').AsString)
  else
     edtUSING_DATE.Date := udllFnUtil.FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD',now()));

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
    btnSync.Visible := false;
    RzProgressBar1.Percent := 0;
  end
  else
  begin
    btnSaveShopInfo.Caption := '保存';
    btnSync.Visible := true;
    RzProgressBar1.Percent := 99;
  end;
end;

procedure TfrmSysDefine.InitTenant;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := cdsTenant.FieldByName('TENANT_ID').AsInteger;
    dataFactory.ExecProc('TTenantInitV60',Params);
  finally
    Params.Free;
  end;
  RightsFactory.InitialRights;
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

  if NewUser then CurUserId := TSequence.NewId;

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

  NewUser := false;
  OpenUsers;
  if cdsUsers.Locate('USER_ID',CurUserId,[]) then
  begin
    CurUserId := cdsUsers.FieldByName('USER_ID').AsString;
    CurUserName := cdsUsers.FieldByName('USER_NAME').AsString;
    CurUserPswd := cdsUsers.FieldByName('PASS_WRD').AsString;
    CurUserAccount := cdsUsers.FieldByName('ACCOUNT').AsString;
    CurUserRoleIds := cdsUsers.FieldByName('ROLE_IDS').AsString;
  end;
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
  NewUser := true;
  CurUserId := '';
  CurUserName := '';
  CurUserPswd := '';
  CurUserAccount := '';
  CurUserRoleIds := '';
  edtACCOUNT.Text := '';
  edtUSER_NAME.Text := '';
  edtMOBILE.Text := '';
  edtROLE_NAMES.Text := '';
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
  if CurUserId = '' then Exit;
  if not cdsUsers.Locate('USER_ID',CurUserId,[]) then Raise Exception.Create('管理员权限不允许修改...');
  roleIds := CurUserRoleIds;
  if TfrmUserRights.ShowUserRight(CurUserId,
                                  CurUserName,
                                  CurUserAccount,
                                  roleIds,roleNames) then
  begin
    if not (cdsUsers.State in [dsInsert,dsEdit]) then cdsUsers.Edit;
    if roleNames = '' then roleNames := '#';
    cdsUsers.FieldByName('ROLE_IDS').AsString:=roleIds;
    cdsUsers.FieldByName('ROLE_IDS_TEXT').AsString:=roleNames;
    cdsUsers.Post;
    edtROLE_NAMES.Text := roleNames;
  end;
end;

procedure TfrmSysDefine.btnGrantRightsClick(Sender: TObject);
begin
  inherited;
  GrantRights;
end;

procedure TfrmSysDefine.RzToolButton2Click(Sender: TObject);
begin
  inherited;
  NewUser := false;
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

procedure TfrmSysDefine.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,Pchar('确定要删除'+cdsUsers.FieldByName('USER_NAME').AsString+'吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) = 6 then
  begin
    try
      cdsUsers.CommitUpdates;
      cdsUsers.Delete;
      dataFactory.UpdateBatch(cdsUsers,'TUsersV60');
    Except
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

procedure TfrmSysDefine.btnRecoveryClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if trim(edtBackUpFile.Text) = '' then Raise Exception.Create('请选择要恢复的备份文件...');
  try
    if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),pchar(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db'),false) then
       begin
         if CopyFile(pchar(trim(edtBackUpFile.Text)),pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),false) then
            begin
              rs := TZQuery.Create(nil);
              dataFactory.MoveToSqlite;
              try
                rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE = ''TENANT_ID'' and TENANT_ID=0';
                dataFactory.Open(rs);
                MessageBox(Handle,'数据恢复成功...','友情提示..',MB_OK);
                if FileExists(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db') then
                   DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db');
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
         MessageBox(Handle,'数据恢复失败...','友情提示..',MB_OK);
       end;
  except
    if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db'),pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),false) then
       begin
         if FileExists(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db') then
            DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_tmp.db');
       end;
    Raise Exception.Create('数据恢复失败...');
  end;
end;

procedure TfrmSysDefine.RzLabel9Click(Sender: TObject);
var img:string;
begin
  inherited;
  if OpenImageDialog.Execute then
     begin
       img := OpenImageDialog.FileName;
       if CopyFile(pchar(img),pchar(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp'),false) then
          begin
            if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp') then
               Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\man.bmp');
          end;
     end;
end;

procedure TfrmSysDefine.SetCurUserAccount(const Value: string);
begin
  FCurUserAccount := Value;
end;

procedure TfrmSysDefine.SetCurUserId(const Value: string);
begin
  FCurUserId := Value;
  if (FCurUserId = token.userId) and (token.account <> token.xsmCode) and (token.account <> 'system') then
     RzPanel37.Visible := true
  else
     RzPanel37.Visible := false;

  if (CurUserId = '') or (not cdsUsers.Locate('USER_ID',CurUserId,[])) then
     RzPanel13.Visible := false
  else
     RzPanel13.Visible := true;
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

procedure TfrmSysDefine.RzToolButton3Click(Sender: TObject);
var str:string;
begin
  inherited;
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
  pnl_changepswd.Visible := true;
  if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
end;

procedure TfrmSysDefine.btnChangeClick(Sender: TObject);
var str,newPswd:string;
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
  with TfrmSyncData.Create(self) do
  begin
    try
      hWnd := self.Handle;
      ShowForm;
      BringToFront;
      RspSyncFactory.SyncAll;
      RspSyncFactory.copyGoodsSort;
      InitTenant;
      SyncFactory.SyncBasic;
    finally
      Free;
      SyncDataing := false;
    end;
  end;
end;

procedure TfrmSysDefine.SetNewUser(const Value: boolean);
begin
  FNewUser := Value;
end;

function TfrmSysDefine.checkCanClose: boolean;
begin
  if SyncDataing then
     result := false
  else
     result := true;
end;

initialization
  RegisterClass(TfrmSysDefine);
finalization
  UnRegisterClass(TfrmSysDefine);
end.
