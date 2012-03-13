unit ufrmN26Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, OleCtrls, SHDocVw,
  ExtCtrls, xmldom, XMLIntf, msxml, ActiveX, ComObj, ZBase,
  msxmldom, XMLDoc, RzPanel, N26base64, ZDataSet,HTTPApp;

type
  TfrmN26Browser = class(TfrmIEWebForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IEBrowserTitleChange(Sender: TObject;
      const Text: WideString);
  private
    Flogined: boolean;
    FN26Url: string;
    FN26UserName: string;
    FN26PassWord: string;
    FN26Token: string;
    procedure Setlogined(const Value: boolean);
    procedure SetN26Url(const Value: string);
    procedure SetN26PassWord(const Value: string);
    procedure SetN26UserName(const Value: string);
    procedure SetN26Token(const Value: string);
    { Private declarations }
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ReadParam;
    function DoLogin:boolean;
    function EncodeUrl(url:string):string;
    function OpenUrl(url:string):boolean;
    property logined:boolean read Flogined write Setlogined;
    property N26Url:string read FN26Url write SetN26Url;
    property N26UserName:string read FN26UserName write SetN26UserName;
    property N26PassWord:string read FN26PassWord write SetN26PassWord;
    property N26Token:string read FN26Token write SetN26Token;
  end;

implementation
uses EncDec,IniFiles, uGlobal, uN26Factory;
{$R *.dfm}

{ TfrmN26Browser }

function TfrmN26Browser.DoLogin: boolean;
function md5(s:string):string;
begin
  result := HTTPEncode(md5Encode(s));
end;
function base64(s:string):string;
begin
  result := HTTPEncode(Base64EncodeStr(s));
end;
var
  doc:IXMLDomDocument;
  s:string;
begin
  ReadParam;
  logined := false;
  if N26Url<>'' then
  begin
    try
      Open(N26Url+'caLogin.do?username='+base64(N26UserName)+'&password='+base64(N26PassWord));
      while Runed do Application.ProcessMessages;
      if not Assigned(IEBrowser.Document) then Exit;
      doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
      try
         s := IEBrowser.OleObject.Document.XMLDocument.documentElement.XML;
         doc.loadXML(s);
      except
         Raise;
      end;
      if FindNode(doc,'header\pub\recAck',true).text<>'0000' then Raise Exception.Create('请求登录失败,错误:'+FindNode(doc,'header\pub\msg',true).text);
      N26Token := FindNode(doc,'header\pub\token',true).text;
      logined := true;
    except
      on E:Exception do
         begin
           Raise;
         end;
    end;
  end;
  result := logined;
end;

function TfrmN26Browser.OpenUrl(url: string): boolean;
begin
  WindowState := wsMaximized;
  BringToFront;
  if not logined then DoLogin;
  if not logined then Exit;
  Open(url);
end;

procedure TfrmN26Browser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

constructor TfrmN26Browser.Create(AOwner: TComponent);
begin
  inherited;
  FormStyle := fsMDIChild;

end;

procedure TfrmN26Browser.IEBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
//  inherited;

end;

procedure TfrmN26Browser.Setlogined(const Value: boolean);
begin
  Flogined := Value;
end;

procedure TfrmN26Browser.ReadParam;
var
  F:TIniFile;
  List:TStringList;
  Params:TftParamList;
  rs:TZQuery;
  Msg:string;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    N26Url := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if N26Url='' then N26Url := ''
       else
       begin
         List.CommaText := N26Url;
         N26Url := List.Values['rim'];
         if N26Url<>'' then
           begin
             if N26Url[Length(N26Url)]<>'/' then N26Url := N26Url+'/';
           end;
       end;
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
  case N26Factory.Checked of
  0:begin
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
        Msg := Global.RemoteFactory.ExecProc('TRimWsdlService',Params);
        Params.Decode(Params,Msg);
        N26UserName := Params.ParambyName('rimuid').AsString;
        N26PassWord := Params.ParambyName('rimpwd').AsString;
        if N26UserName='' then Raise Exception.Create('后台业务库中，没找到当前登录门店的许可证号.');
      finally
        Params.Free;
      end;
    end;
  else
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select XSM_CODE,XSM_PSWD from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
        rs.ParambyName('TENANT_ID').asInteger := Global.TENANT_ID;
        rs.ParambyName('SHOP_ID').asString := Global.SHOP_ID;
        Factor.Open(rs);
        N26UserName := rs.Fields[0].asString;
        N26PassWord := DecStr(rs.Fields[1].asString,ENC_KEY);
        if N26UserName='' then Raise Exception.Create('后台业务库中，没找到当前登录门店的许可证号.');
      finally
        rs.free;
      end;
    end;
  end;
end;

procedure TfrmN26Browser.SetN26Url(const Value: string);
begin
  FN26Url := Value;
end;

procedure TfrmN26Browser.SetN26PassWord(const Value: string);
begin
  FN26PassWord := Value;
end;

procedure TfrmN26Browser.SetN26UserName(const Value: string);
begin
  FN26UserName := Value;
end;

procedure TfrmN26Browser.SetN26Token(const Value: string);
begin
  FN26Token := Value;
end;

function TfrmN26Browser.EncodeUrl(url: string): string;
begin
  if N26Token<>'' then
  begin
  if pos('?',url)>0 then
     result := N26Url+url+'token='+HTTPEncode(N26Token)
  else
     result := N26Url+url+'?token='+HTTPEncode(N26Token);
  end
  else
  result := url;
end;

function TfrmN26Browser.FindElement(root: IXMLDOMNode;
  s: string): IXMLDOMNode;
var
  i:integer;
begin
  result := root.firstChild;
  while result<>nil do
    begin
      if result.nodeName=s then exit;
      result := result.nextSibling;
    end;
  result := nil;
end;

function TfrmN26Browser.FindNode(doc: IXMLDomDocument; tree: string;
  CheckExists: boolean): IXMLDOMNode;
var
  s:TStringList;
  i:integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '\';
    s.DelimitedText := tree;
    result := doc.documentElement;
    for i:=0 to s.Count -1 do
      begin
        if result <>nil then
           result := FindElement(result,s[i]);
      end;
    if CheckExists and (result = nil) then Raise Exception.Create('在文档中没找到结点'+tree); 
  finally
    s.Free;
  end;
end;

end.
