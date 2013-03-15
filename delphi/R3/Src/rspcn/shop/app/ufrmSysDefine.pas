unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzTabs,
  RzBmpBtn, jpeg, RzButton, cxControls, cxContainer, cxEdit, cxTextEdit,
  ComCtrls, RzPrgres, cxMaskEdit, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, msxml;

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
    btnSave: TRzBitBtn;
    RzPanel10: TRzPanel;
    Photo: TImage;
    cdsTenant: TZQuery;
    cdsShopInfo: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FirstLogin:boolean;
    function  CheckRegister:boolean;
    procedure OpenShopInfo(tenantId:string='';shopId:string='');
    procedure GetShopInfo;
    procedure ReadFromObject;
    procedure WriteToObject;
    procedure SaveShopInfo;
    procedure SaveRegisterParams;
  public
    AObj:TRecord_;
  end;

implementation

uses udllGlobal,udataFactory,uTokenFactory,uRspFactory,udllShopUtil,EncDec,ufrmSyncData,
     uSyncFactory;

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

  if FirstLogin then RzProgressBar1.Percent := 0
  else RzProgressBar1.Percent := 99;

  if FirstLogin then
  begin
    RzBmpButton2.Visible := false;
    RzBmpButton3.Visible := false;
    RzBmpButton4.Visible := false;
  end;
end;

procedure TfrmSysDefine.FormShow(Sender: TObject);
begin
  inherited;
  if FirstLogin then
    GetShopInfo
  else
    OpenShopInfo;

  ReadFromObject;
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

procedure TfrmSysDefine.ReadFromObject;
begin
  if PageControl.ActivePageIndex = 0 then
  begin
    AObj.ReadFromDataSet(cdsShopInfo);
    udllShopUtil.ReadFromObject(AObj,self);
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

procedure TfrmSysDefine.btnSaveClick(Sender: TObject);
begin
  inherited;
  if PageControl.ActivePageIndex = 0 then
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

  if FirstLogin then
  begin
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsTenant.FieldByName('TENANT_ID').AsInteger;
      dataFactory.ExecProc('TTenantInitV60',Params);
    finally
      Params.Free;
    end;

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

      dataFactory.ExecProc('TTenantInitV60',Params);
    finally
      Params.Free;
      tmpTenant.Free;
      tmpShopInfo.Free;
      dataFactory.MoveToDefault;
    end;

    SaveRegisterParams;

    token.tenantId := cdsShopInfo.FieldByName('TENANT_ID').AsString;
    token.shopId := cdsShopInfo.FieldByName('SHOP_ID').AsString;

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
  end;

  OpenShopInfo(cdsShopInfo.FieldByName('TENANT_ID').AsString,cdsShopInfo.FieldByName('SHOP_ID').AsString);

  MessageBox(Handle,'保存成功...','友情提示..',MB_OK);

  if FirstLogin then RzBmpButton2.Visible := true;
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
end;

initialization
  RegisterClass(TfrmSysDefine);
finalization
  UnRegisterClass(TfrmSysDefine);
end.
