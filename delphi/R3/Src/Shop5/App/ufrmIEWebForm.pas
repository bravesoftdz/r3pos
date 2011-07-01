unit ufrmIEWebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeMDForm, ActnList, Menus, OleCtrls, SHDocVw, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX, ComObj, msxml, ExtCtrls,
  RzPanel, RzTabs, ImgList, ZDataSet;

type
  PIEAction=^TIEAction;
  TIEAction=record
    //0新商盟 1调用Url
    flag:integer;
    url:string;
    Title:string;
    id:string;
  end;

  TfrmIEWebForm = class(TframeMDForm)
    IEBrowser: TWebBrowser;
    RzPanel2: TRzPanel;
    RzPanel1: TRzPanel;
    ImgLst16: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IEBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure IEBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IEBrowserTitleChange(Sender: TObject;
      const Text: WideString);
  private
    { Private declarations }
  protected
    Runed:boolean;
    FhEvent:THandle;
    //读取xml
    function GetXml(Url:string;flag:integer):IXMLDomDocument;

    //新商盟接口
    function GetForLogin(Url:string):string;
  public
    { Public declarations }
    function GetDoLogin(Url:string):string;
    function Open(Url:string):boolean;virtual;

    procedure DoLogin;virtual;
  end;
implementation
uses EncDec,ufrmDesk,uShopGlobal,ufrmLogo,ufrmXsmLogin, uGlobal, ufrmMain;

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
var W:int64;
  _Start:int64;
begin
  result := false;
  if url='' then Exit;
  Runed := true;
  IEBrowser.Navigate(url);
  frmDesk.Waited := true;
  try
    frmLogo.ProgressBar1.Position := 1;
    frmLogo.ProgressBar1.Update;
    _Start := GetTickCount;
    IEBrowser.Navigate(Url);
    while Runed do
      begin
        W := (GetTickCount-_Start);
        frmLogo.BringToFront;
        frmLogo.ProgressBar1.Position := (W div 500);
        frmLogo.ProgressBar1.Update;
        Application.ProcessMessages;
      end;
  finally
    frmDesk.Waited := false;
  end;
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
  ResetEvent(FhEvent);
end;

procedure TfrmIEWebForm.FormDestroy(Sender: TObject);
begin
  if FhEvent<>0 then CloseHandle(FhEvent);
  IEBrowser.Free;
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
function FindAction(id:string):TAction;
var
  i:integer;
begin
  result := nil;
  for i:=0 to frmMain.actList.ActionCount - 1 do
    begin
      if frmMain.actList.Actions[i].Tag = strtoint(id) then
         begin
           result := TAction(frmMain.actList.Actions[i]);
           Exit;
         end;
    end;
end;
var
  act:TAction;
begin
  Runed := false;
  inherited;
  if pos('relogin',lowercase(URL))>0 then close;
  if pos('#=',url)>0 then
  begin
    act := FindAction(copy(url,pos('#=',url)+2,255));
    if act=nil then Raise Exception.Create('没找到对应的模块,id='+url);
    act.OnExecute(act);
  end;
//  SetEvent(FhEvent);

end;

procedure TfrmIEWebForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

procedure TfrmIEWebForm.IEBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
  inherited;
  Caption := Text;
end;
procedure TfrmIEWebForm.DoLogin;
begin

end;

end.
