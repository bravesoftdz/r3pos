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
    RzTab: TRzTabControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IEBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure IEBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IEBrowserTitleChange(Sender: TObject;
      const Text: WideString);
    procedure RzTabChange(Sender: TObject);
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

    procedure LoadMenu(id:string);
    procedure AddPage(Act:PIEAction);
    procedure Clear;
    procedure DoAction(Act:PIEAction);virtual;
  end;
var
  xsm_url:string;
  xsm_username:string;
  xsm_password:string;
implementation
uses EncDec,uShopGlobal,ufrmXsmLogin,udmR3Icon, uGlobal;

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

procedure TfrmIEWebForm.IEBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
  inherited;
  Caption := Text;
end;

procedure TfrmIEWebForm.AddPage(Act:PIEAction);
var
  tb:TRzTabCollectionItem;
  bmp:TBitmap;
begin
  RzTab.Tabs.BeginUpdate;
  try
    tb := RzTab.Tabs.Add;
    tb.Caption := Act.Title;
    tb.Data := Act;
    tb.ImageIndex := ImgLst16.Count;
    bmp := dmR3Icon.GetResBitbmp('bmp16_'+Act^.id);
    try
      ImgLst16.AddMasked(bmp,clWhite);
    finally
      bmp.Free;
    end;
  finally
    RzTab.Tabs.EndUpdate;
  end;
end;

procedure TfrmIEWebForm.Clear;
var
  i:integer;
begin
  ImgLst16.Clear;
  for i:=0 to rzTab.Tabs.Count -1 do
    begin
      dispose(PIEAction(rzTab.Tabs[i].Data));
    end;
  rzTab.Tabs.Clear;
end;

procedure TfrmIEWebForm.DoAction(Act: PIEAction);
begin

end;

procedure TfrmIEWebForm.RzTabChange(Sender: TObject);
begin
  inherited;
  DoAction(PIEAction(TRzTabCollectionItem(Sender).Data));
end;

procedure TfrmIEWebForm.LoadMenu(id: string);
var
  rs:TZQuery;
  lvid:string;
  Act:PIEAction;
begin
  rs := Global.GetZQueryFromName('CA_MODULE');
  if rs.Locate('MODU_ID',id,[]) then
     lvid := rs.FieldbyName('LEVEL_ID').AsString
  else
     lvid := '';
  RzTab.Visible := true;
  Clear;
  rs.First;
  while not rs.Eof do
     begin
       if (copy(rs.FieldByName('LEVEL_ID').AsString,1,length(lvid))=lvid) and
          (length(rs.FieldByName('LEVEL_ID').AsString)=length(lvid)+4) and
          ShopGlobal.GetChkRight(rs.FieldbyName('MODU_ID').AsString,1)
       then
          begin
            new(Act);
            Act^.flag := 0;
            Act^.id := rs.FieldbyName('MODU_ID').AsString;
            Act^.Title := rs.FieldbyName('MODU_NAME').AsString;
            AddPage(Act);
          end;
       rs.Next;
     end;
  if RzTab.Tabs.Count > 0 then RzTab.TabIndex := 0;
end;

end.
