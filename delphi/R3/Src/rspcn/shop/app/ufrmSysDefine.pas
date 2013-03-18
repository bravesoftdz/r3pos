unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzTabs,
  RzBmpBtn, jpeg, RzButton, cxControls, cxContainer, cxEdit, cxTextEdit,
  ComCtrls, RzPrgres, cxMaskEdit, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, msxml,
  cxDropDownEdit, cxCalendar, cxCheckBox, cxMemo, cxSpinEdit, IniFiles;

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
    btnChangeImage: TRzBitBtn;
    RzPanel20: TRzPanel;
    edtSHOP_NAME: TcxTextEdit;
    RzLabel1: TRzLabel;
    RzProgressBar1: TRzProgressBar;
    RzPanel4: TRzPanel;
    edtLICENSE_CODE: TcxTextEdit;
    edtREGION_ID: TzrComboBoxList;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    edtADDRESS: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    edtLINKMAN: TcxTextEdit;
    RzPanel9: TRzPanel;
    btnSaveShopInfo: TRzBitBtn;
    RzPanel10: TRzPanel;
    Photo: TImage;
    cdsTenant: TZQuery;
    cdsShopInfo: TZQuery;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    edtUSING_DATE: TcxDateEdit;
    edtZERO_OUT: TcxCheckBox;
    edtFOOTER: TcxMemo;
    edtTicketPrintComm: TcxComboBox;
    cxNullRow: TcxSpinEdit;
    edtTicketCopy: TcxSpinEdit;
    edtPRINTERWIDTH: TcxComboBox;
    edtTitle: TcxTextEdit;
    edtTICKET_PRINT_NAME: TcxComboBox;
    cxCashBox: TcxComboBox;
    cxCashBoxRate: TcxComboBox;
    RzPanel11: TRzPanel;
    RzPanel12: TRzPanel;
    RzPanel14: TRzPanel;
    RzPanel15: TRzPanel;
    RzPanel16: TRzPanel;
    RzPanel17: TRzPanel;
    RzPanel18: TRzPanel;
    RzPanel19: TRzPanel;
    RzPanel21: TRzPanel;
    RzPanel22: TRzPanel;
    RzPanel23: TRzPanel;
    Bevel1: TBevel;
    RzLabel7: TRzLabel;
    RzLabel2: TRzLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    RzLabel3: TRzLabel;
    RzPanel24: TRzPanel;
    btnSaveSysDefine: TRzBitBtn;
    cdsSysDefine: TZQuery;
    edtPosDight: TcxSpinEdit;
    edtCARRYRULE: TcxComboBox;
    edtPOSCALCDIGHT: TcxComboBox;
    RzPanel25: TRzPanel;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    edtID2: TcxComboBox;
    edtID1: TcxComboBox;
    edtID: TcxComboBox;
    edtFlag: TcxTextEdit;
    edtLEN1: TcxComboBox;
    edtLEN2: TcxComboBox;
    edtDEC2: TcxTextEdit;
    edtDEC1: TcxTextEdit;
    RzLabel4: TRzLabel;
    Bevel4: TBevel;
    RzPanel28: TRzPanel;
    RzPanel29: TRzPanel;
    RzPanel30: TRzPanel;
    RzPanel31: TRzPanel;
    RzPanel32: TRzPanel;
    RzPanel33: TRzPanel;
    btnDefault: TRzBitBtn;
    btnRspSync: TRzBitBtn;
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
    procedure btnRspSyncClick(Sender: TObject);
  private
    FFirstLogin:boolean;
    function  CheckRegister:boolean;
    procedure OpenShopInfo(tenantId:string='';shopId:string='');
    procedure GetShopInfo;
    procedure OpenSysDefine;
    procedure ReadFromObject(PageIndex:integer);
    procedure WriteToObject;
    procedure SaveShopInfo;
    procedure SaveRegisterParams;
    procedure ReadSysDefine;
    procedure ReadBarCodeRule;
    procedure SaveSysDefine;
    procedure SetFirstLogin(const Value: boolean);
  public
    AObj:TRecord_;
    property FirstLogin:boolean read FFirstLogin write SetFirstLogin;
  end;

implementation

uses udllGlobal,udataFactory,uTokenFactory,uRspFactory,udllShopUtil,EncDec,ufrmSyncData,
     uSyncFactory,udllFnUtil,uRspSyncFactory;

{$R *.dfm}

function TfrmSysDefine.CheckRegister: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE = ''TENANT_ID'' and TENANT_ID=0 ';
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
  if FileExists(ExtractFilePath(Application.ExeName)+'built-in\images\Photo.bmp') then
     Photo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\Photo.bmp');

  edtREGION_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_REGION_INFO');

  FirstLogin := not CheckRegister;

  if FirstLogin then
  begin
    RzBmpButton2.Visible := false;
    RzBmpButton3.Visible := false;
    RzBmpButton4.Visible := false;
  end;

  PageControl.ActivePageIndex := 0;
end;

procedure TfrmSysDefine.FormShow(Sender: TObject);
begin
  inherited;
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
var
  Params:TftParamList;
  tmpTenant,tmpShopInfo:TZQuery;
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
{
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

      if FirstLogin then dataFactory.ExecProc('TTenantInitV60',Params);
    finally
      Params.Free;
      tmpTenant.Free;
      tmpShopInfo.Free;
      dataFactory.MoveToDefault;
    end;
  end;
}
  if FirstLogin then
  begin
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsTenant.FieldByName('TENANT_ID').AsInteger;
      dataFactory.ExecProc('TTenantInitV60',Params);
    finally
      Params.Free;
    end;

    SaveRegisterParams;

    btnRspSync.Click;
    RspSyncFactory.copyGoodsSort;

    with TfrmSyncData.Create(self) do
      begin
        try
          hWnd := self.Handle;
          ShowForm;
          BringToFront;
          SyncFactory.SyncBasic;
        finally
          Free;
        end;
      end;

    FirstLogin := false;
    RzBmpButton2.Visible := true;
    RzBmpButton3.Visible := true;
    RzBmpButton4.Visible := true;
    OpenShopInfo(cdsShopInfo.FieldByName('TENANT_ID').AsString,cdsShopInfo.FieldByName('SHOP_ID').AsString);
  end;

  dllGlobal.GetZQueryFromName('CA_TENANT').Close;
  dllGlobal.GetZQueryFromName('CA_SHOP_INFO').Close;

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
  for i:=0 to PageControl.PageCount-1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 2;
end;

procedure TfrmSysDefine.RzBmpButton4Click(Sender: TObject);
var i:integer;
begin
  inherited;
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
     edtZERO_OUT.Checked := false;

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
  edtZERO_OUT.checked := false;

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

procedure TfrmSysDefine.btnRspSyncClick(Sender: TObject);
begin
  inherited;
  with TfrmSyncData.Create(self) do
  begin
    try
      hWnd := self.Handle;
      ShowForm;
      BringToFront;
      RspSyncFactory.SyncAll;
    finally
      Free;
    end;
  end;
end;

procedure TfrmSysDefine.SetFirstLogin(const Value: boolean);
begin
  FFirstLogin := Value;
  if Value then
  begin
    btnRspSync.Visible := false;
    RzProgressBar1.Percent := 0;
  end
  else
  begin
    btnRspSync.Visible := true;
    RzProgressBar1.Percent := 99;
  end;
end;

initialization
  RegisterClass(TfrmSysDefine);
finalization
  UnRegisterClass(TfrmSysDefine);
end.
