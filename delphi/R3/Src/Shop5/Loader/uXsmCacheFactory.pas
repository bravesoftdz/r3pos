unit uXsmCacheFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, msxml, ZLogFile, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, OleCtrls, SHDocVw, uGlobal, ComObj, ComCtrls, IniFiles,
  ToolWin, RzBmpBtn, ExtCtrls, RzBckgnd, RzPanel, Menus, RzButton,
  ActnList, StdCtrls, RzLabel, RzPrgres;

const
  WM_LOADER_REQUEST = WM_USER+10;
    
type
  TXsmCacheFactory = class(TForm)
    IdHTTP1: TIdHTTP;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    WebBrowser1: TWebBrowser;
    RzPanel3: TRzPanel;
    btnCancel: TRzBitBtn;
    Bevel1: TBevel;
    RzProgressBar1: TRzProgressBar;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    labInfo: TRzLabel;
    ActionList1: TActionList;
    actLoad: TAction;
    actStop: TAction;
    actCancel: TAction;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure WebBrowser1DownloadComplete(Sender: TObject);
  private
    { Private declarations }
    StartDateTime:TDateTime;
    Complete:Integer;  // �ж��Ƿ�������
    UrlAddr,xsmrt,code1,code2: String;
    FLoadNum: Integer;
    function createXml(Xml:String):IXMLDOMDocument;
    procedure WM_LOADER(var Message:TMessage); Message WM_LOADER_REQUEST;
    procedure Loader(Url:String);
    procedure LoadVersionXml(Url:String);
    procedure LoadVersionChildXml(Nodes:IXMLDOMNodeList;Str,ParentNodeName:String);
    procedure Load_GWGCorCs_Xml(Url:String);
    procedure Load_GWGCorCs_ChildXml(Nodes:IXMLDOMNodeList;Str,ParentNodeName:String);
    function GetVersionPath:String;
    procedure LoadFiles;
    procedure ReadIni;
  public
    { Public declarations }
    //�ֱ��Ӧ ������ʡ�����м� �Ĺ���㳡������
    GWGC_Ver,CS_Ver,Parent_GWGC_Ver,Parent_CS_Ver,Com_GWGC_Ver,Com_CS_Ver:String;
    //�ж� ����㳡������ ���� �ɹ����
    ChildLoad:Boolean;
    property LoadNum:Integer read FLoadNum;
  end;

var
  XsmCacheFactory: TXsmCacheFactory;

implementation

{$R *.dfm}

{ TXsmCacheFactory }

function TXsmCacheFactory.createXml(Xml: String): IXMLDOMDocument;
var
  ErrXml:string;
  w:integer;
begin
  if Global.debug then LogFile.AddLogFile(0,xml);
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml������,xml='+xml);
            end;
       end
    else begin
      Raise Exception.Create('xml�ַ�������Ϊ��...');
    end;
  except
    on E:Exception do
       begin
         result := nil;
         LogFile.AddLogFile(0,e.Message);
       end;
  end;
end;

procedure TXsmCacheFactory.Loader(Url: String);
begin
  try
    if Url = 'http://gx.xinshangmeng.com/xsm2/resource/sound/11650001/newyear.mp3?v=2011-09-02_00' then Exit;
    labInfo.Caption := Url;
    Complete := 0;
    StartDateTime := Now();
    WebBrowser1.Navigate(Url);
    {while Complete < 6 do  //�ٶȺ���
      Application.ProcessMessages}
    while WebBrowser1.ReadyState < READYSTATE_COMPLETE do
      Application.ProcessMessages;
  except
    Raise;
    Exit;
  end;
  Inc(FLoadNum);
end;

procedure TXsmCacheFactory.Load_GWGCorCs_ChildXml(Nodes: IXMLDOMNodeList; Str,
  ParentNodeName: String);
var Root:IXMLDOMElement;
    ChildUrl:String;
    i:Integer;
begin
  for i := 0 to Nodes.length - 1 do
    begin
      if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
      Root := Nodes.item[i] as IXMLDOMElement;
      ChildUrl := xsmrt+Str+VarToStr(Root.getAttribute('id'));
      Loader(ChildUrl);
    end;
end;

procedure TXsmCacheFactory.Load_GWGCorCs_Xml(Url:String);
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Nodes:IXMLDOMNodeList;
  i,sum:Integer;
  xml,GWGCUrl,MapDir:string;
begin
  try
    xml := IdHTTP1.Get(Url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('��������ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    MapDir := Root.getAttribute('dir');
    Nodes := Root.childNodes;
    sum := Nodes.length;
    RzProgressBar1.Percent := 0;
    for i := 0 to sum - 1 do
      begin
        if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
        if (Nodes.item[i].nodeName = 'background') or (Nodes.item[i].nodeName = 'ItemDefinitions') then
        begin
          if Nodes.item[i].hasChildNodes then
          begin
            Root := Nodes.item[i] as IXMLDOMElement;
            Load_GWGCorCs_ChildXml(Nodes.item[i].childNodes,MapDir,Nodes.item[i].nodeName);
          end else
          begin
            Root := Nodes.item[i] as IXMLDOMElement;
            GWGCUrl := xsmrt+MapDir+VarToStr(Root.getAttribute('file'));
            Loader(GWGCUrl);
          end;
        end;
        RzProgressBar1.Percent := i*100 div sum;
      end;
    ChildLoad := True;
    //if Root.attributes.getNamedItem('Versionfiles')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    //if Root.attributes.getNamedItem('id').text<>'0000' then Raise Exception.Create('��������ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    //result := true;
    RzProgressBar1.Percent := 100;
  except
    ChildLoad := False;
    LogFile.AddLogFile(0,Url);
  end;
end;

procedure TXsmCacheFactory.LoadVersionChildXml(Nodes: IXMLDOMNodeList; Str,
  ParentNodeName: String);
var Root:IXMLDOMElement;
    ChildUrl,AttributeValue:String;
    i:Integer;
begin
  for i := 0 to Nodes.length - 1 do
    begin
      if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
      Root := Nodes.item[i] as IXMLDOMElement;
      AttributeValue := UpperCase(VarToStr(Root.getAttribute('id')));
      if (AttributeValue = UpperCase('CS.XML')) or (AttributeValue = UpperCase('GWGC.XML')) then
      begin
        ChildUrl := xsmrt+Str+'/'+VarToStr(Root.getAttribute('id'))+'?v='+VarToStr(Root.getAttribute('v'));
        if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id'))) = UpperCase('resource/map/GWGC.xml') then
          GWGC_Ver := ChildUrl;
        if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id'))) = UpperCase('resource/map/CS.xml') then
          CS_Ver := ChildUrl;
          
        if (code1 <> '') and (code2 <> '') then
        begin
          if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id')))=UpperCase('resource/map/'+code1+'/GWGC.xml') then
            Parent_GWGC_Ver := ChildUrl;
          if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id')))=UpperCase('resource/map/'+code1+'/CS.xml') then
            Parent_CS_Ver := ChildUrl;
          if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id')))=UpperCase('resource/map/'+code1+'/'+code2+'/GWGC.xml') then
            Com_GWGC_Ver := ChildUrl;
          if UpperCase(Str+'/'+VarToStr(Root.getAttribute('id')))=UpperCase('resource/map/'+code1+'/'+code2+'/CS.xml') then
            Com_CS_Ver := ChildUrl;
        end;
        //Load_GWGCorCs_Xml(ChildUrl);
        Loader(ChildUrl);
      end else
      begin
        ChildUrl := xsmrt+Str+'/'+VarToStr(Root.getAttribute('id'))+'?v='+VarToStr(Root.getAttribute('v'));
        Loader(ChildUrl);
      end;
    end;
end;

procedure TXsmCacheFactory.LoadVersionXml(Url:String);
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Nodes:IXMLDOMNodeList;
  Node:IXMLDOMNode;
  Attr:IXMLDOMAttribute;
  i,sum:Integer;
  xml,Str_url:string;
begin
  try
    xml := IdHTTP1.Get(Url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('��������ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    Nodes := Root.childNodes;
    sum := Nodes.length;
    RzProgressBar1.Percent := 0;
    for i := 0 to sum - 1 do
      begin
        if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
        if Nodes.item[i].nodeName = 'f' then
        begin
          Root := Nodes.item[i] as IXMLDOMElement;
          Str_url := xsmrt+VarToStr(Root.getAttribute('id')+'?v='+VarToStr(Root.getAttribute('v')));
          Loader(Str_url);
        end;
        if Nodes.item[i].hasChildNodes then
        begin
          Root := Nodes.item[i] as IXMLDOMElement;
          LoadVersionChildXml(Nodes.item[i].childNodes,VarToStr(Root.getAttribute('id')),Nodes.item[i].nodeName);
        end;
        RzProgressBar1.Percent := (i*100 div sum);
      end;
    //if Root.attributes.getNamedItem('Versionfiles')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    //if Root.attributes.getNamedItem('id').text<>'0000' then Raise Exception.Create('��������ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    //result := true;
    RzProgressBar1.Percent := 100;
  except
    LogFile.AddLogFile(0,Url);
  end;
end;

procedure TXsmCacheFactory.FormCreate(Sender: TObject);
begin
  FLoadNum := 0;
end;

procedure TXsmCacheFactory.actCancelExecute(Sender: TObject);
begin
  if btnCancel.Tag = 0 then actStopExecute(Sender);
  Close;
end;

procedure TXsmCacheFactory.actStopExecute(Sender: TObject);
begin
  WebBrowser1.Stop;
  RzLabel3.Caption := '�Ѿ�ֹͣ����ͼƬ';
end;

procedure TXsmCacheFactory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  actStopExecute(Sender);
  Close;
end;

procedure TXsmCacheFactory.WM_LOADER(var Message: TMessage);
begin
  ReadIni;
  RzLabel3.Caption := '�������ļ�����м���ͼƬ�����Ե�...';
  RzLabel1.Visible := True;
  LoadFiles;
end;

procedure TXsmCacheFactory.FormShow(Sender: TObject);
begin
  labInfo.Caption := '';
  RzLabel1.Visible := False;
end;

procedure TXsmCacheFactory.Timer1Timer(Sender: TObject);
var Time_D:Double;
begin
  {Time_D := Now()-StartDateTime;
  if Time_D > 30 then
    begin
      WebBrowser1.Stop;
      Complete := 6;
    end; }
end;

procedure TXsmCacheFactory.ReadIni;
var F: TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  try
    xsmrt := F.ReadString('xsm','xsmrt','');
    code1 := F.ReadString('xsm','code1','');
    code2 := F.ReadString('xsm','code2','');
  finally
    try
      F.Free;
    except
    end;
  end;
end;

function TXsmCacheFactory.GetVersionPath: String;
begin
  if code1 = '11000001' then
    begin
      Result := 'resouce/version/' + code2 + '/VersionFiles.xml';
    end
  else
    begin
      Result := 'resouce/version/' + code1 + '/' + code2 + '/VersionFiles.xml';
    end;
end;

procedure TXsmCacheFactory.LoadFiles;
var Load_String:String;
    i:Integer;
begin
  if xsmrt <> '' then
  begin
    Load_String := xsmrt+'VersionFiles.xml?v='+IntToStr(gettickcount);
    RzLabel1.Caption := '���ڼ�����"VersionFiles.xml"�ļ�...';
    LoadVersionXml(Load_String);

    Load_String := GetVersionPath;
    RzLabel1.Caption := '���ڼ��ص���"VersionFiles.xml"�ļ�...';
    LoadVersionXml(Load_String);

    RzLabel1.Caption := '���ڼ���"GWGC.xml"�ļ�...';
    for i := 0 to 2 do
    begin
      case i of
        0:begin
          if Com_GWGC_Ver <> '' then
          begin
            Load_GWGCorCs_Xml(Com_GWGC_Ver);
            Break;
          end;
        end;
        1:begin
          if Parent_GWGC_Ver <> '' then
          begin
            Load_GWGCorCs_Xml(Parent_GWGC_Ver);
            Break;
          end;
        end;
        2:begin
          if GWGC_Ver <> '' then
            Load_GWGCorCs_Xml(GWGC_Ver);
        end;
      end;
    end;

    RzLabel1.Caption := '���ڼ���"CS.xml"�ļ�...';
    for i := 0 to 2 do
    begin
      case i of
        0:begin
          if Com_GWGC_Ver <> '' then
          begin
            Load_GWGCorCs_Xml(Com_GWGC_Ver);
            Break;
          end;
        end;
        1:begin
          if Parent_GWGC_Ver <> '' then
          begin
            Load_GWGCorCs_Xml(Parent_GWGC_Ver);
            Break;
          end;
        end;
        2:begin
          if GWGC_Ver <> '' then
            Load_GWGCorCs_Xml(GWGC_Ver);
        end;
      end;
    end;
    RzLabel3.Caption := '�ļ������Ѿ����!';
    btnCancel.Caption := '���';
    btnCancel.Tag := 1;
  end
  else
    Close;
end;

procedure TXsmCacheFactory.WebBrowser1DownloadComplete(Sender: TObject);
begin
  Complete := 6;
end;

end.
