unit ufrmIEWebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeMDForm, ActnList, Menus, OleCtrls, SHDocVw, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX, ComObj, msxml, ExtCtrls,
  RzPanel;

type
  TfrmIEWebForm = class(TframeMDForm)
    IEBrowser: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IEBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure IEBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FhEvent:THandle;
    Runed:boolean;
  protected
    //读取xml
    function GetXml(Url:string;flag:integer):IXMLDomDocument;

    //新商盟接口
    function GetForLogin(Url:string):string;
  public
    { Public declarations }
    function GetDoLogin(Url:string):string;
    function Open(Url:string):boolean;
  end;
var
  xsm_url:string;
  xsm_username:string;
  xsm_password:string;
implementation
uses EncDec,uShopGlobal,ufrmXsmLogin;

{$R *.dfm}

{ TfrmIEWebForm }

function TfrmIEWebForm.GetDoLogin(Url: string): string;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  challenge:string;
begin
  if xsm_url<>'' then
  begin
    try
      challenge := GetForLogin(Url);
      doc := GetXml(Url+'st/users/dologin?j_username='+xsm_username+'&j_password='+md5(md5(xsm_password)+challenge),1);
      if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
      Root :=  doc.DocumentElement;
      if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
      if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
      if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求登录失败,错误:'+Root.attributes.getNamedItem('msg').text);
      result := Url+'xsm2/xsm.html';
    except
      on E:Exception do
         begin
           MessageBox(Handle,Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
           if TfrmXsmLogin.XsmLogin then
              result := GetDoLogin(xsm_url)
           else
              result := '';
         end;
    end;
  end
  else
  begin
    if TfrmXsmLogin.XsmLogin then
       result := GetDoLogin(xsm_url) else result := '';
  end;
end;

function TfrmIEWebForm.GetForLogin(Url:string): string;
var
  doc:IXMLDomDocument;
  Root:IXMLDOMElement;
begin
  doc := GetXml(Url+'st/users/forlogin',0);
  if not Assigned(doc) then Raise Exception.Create('请求校验码失败...');
  Root := doc.documentElement;
  if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
  if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
  if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求校验码失败,错误:'+Root.attributes.getNamedItem('msg').text);
  result := Root.childNodes[0].text;
end;

function TfrmIEWebForm.GetXml(Url:string;flag:integer): IXMLDomDocument;
var
  doc:IXMLDomDocument;
  s:string;
begin
  result := nil;
  try
    Runed := true;
    Open(Url);
    while Runed do Application.ProcessMessages;
    if not Assigned(IEBrowser.Document) then Exit;
    doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
    try
       s := IEBrowser.OleObject.Document.XMLDocument.documentElement.XML;
       doc.loadXML(s);
    except
       s := IEBrowser.OleObject.document.documentelement.innerText;
       if pos('code="0000"',s)>0 then
       begin
         if flag=0 then raise;
         s := '<?xml version="1.0" encoding="utf-8" standalone="no" ?> <xsm code="0000" msg="取得登录成功" trans_time="20110304092045"> <challenge></challenge></xsm>';
         doc.loadXML(s);
       end;
    end;
    result := doc;
  except
    Raise Exception.Create('无法打开网页请求');
  end;
end;

function TfrmIEWebForm.Open(Url: string):boolean;
begin
  result := false;
  if url='' then Exit;
  IEBrowser.Navigate(url);
  result := true;
end;

procedure TfrmIEWebForm.FormCreate(Sender: TObject);
begin
  inherited;
  FhEvent := CreateEvent(nil, True, False, nil);
  xsm_url := ShopGlobal.GetParameter('XSM_URL');
  if xsm_url='' then xsm_url := '';
  xsm_username := ShopGlobal.GetParameter('XSM_USERNAME');
  if xsm_username='' then xsm_username := '';
  xsm_password := DecStr(ShopGlobal.GetParameter('XSM_PASSWORD'),ENC_KEY);
  if xsm_password='' then xsm_password := '';
end;

procedure TfrmIEWebForm.FormDestroy(Sender: TObject);
begin
  if FhEvent<>0 then CloseHandle(FhEvent);
  inherited;

end;

procedure TfrmIEWebForm.IEBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
///  SetEvent(FhEvent);
  Runed := false;
end;

procedure TfrmIEWebForm.IEBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  Runed := false;
  if pos('relogin',lowercase(URL))>0 then close;
//  SetEvent(FhEvent);

end;

procedure TfrmIEWebForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

end.
