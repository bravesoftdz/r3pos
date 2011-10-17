unit ufrmWelcome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, ComCtrls, RzEdit, RzTabs,
  RzBmpBtn, RzForms, jpeg, ExtCtrls, RzPanel,uWelcome, OleCtrls, ActiveX, SHDocVw;

type
  TfrmWelcome = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    RzFormShape1: TRzFormShape;
    ImgClose: TImage;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzPanel4: TRzPanel;
    ImgLeftLine: TImage;
    ImgRightLine: TImage;
    RzPanel3: TRzPanel;
    ImgButtom: TImage;
    ImgIKnow: TImage;
    RzPanel6: TRzPanel;
    RzPage: TRzPageControl;
    Tab1: TRzTabSheet;
    RzPanel5: TRzPanel;
    ImgDay: TImage;
    Lbl_Day_Title: TLabel;
    Tab2: TRzTabSheet;
    PnlTitleMonth: TRzPanel;
    ImgMonth: TImage;
    Lbl_Month_Title: TLabel;
    Img_left: TRzBmpButton;
    Img_right: TRzBmpButton;
    RzPanel7: TRzPanel;
    DayBrowser: TWebBrowser;
    RzPanel8: TRzPanel;
    MthBrowser: TWebBrowser;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgIKnowClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Img_leftClick(Sender: TObject);
    procedure Img_rightClick(Sender: TObject);
    procedure DayBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure MthBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
  private
    { Private declarations }
    function PutText(Font: TFont; Text: String):string;
    procedure Createparams(Var Params:TCreateParams);override;
    function EncodeScript:string;
    //��������������
    function EncodeDaySaleInfo:string;
    //�����ս�������
    function EncodeDayStockInfo:string;
    //�����տ������
    function EncodeDayStorageInfo:string;
    //������HTML
    function EncodeDayInfo:string;

    //���½������
    function EncodeMthStockInfo:string;
    function EncodeMthSalesInfo:string;
    function EncodeMthStgInfo:string;
    function EncodeMthCustInfo:string;
    function EncodeMthInfo:string;

  public
    { Public declarations }
    procedure AddMonth(SetValue: integer);

    procedure ShowInfo(IEBrowser:TWebBrowser;s:string);
    procedure OpenPage1;
    procedure OpenPage2;
    class procedure Popup;

  end;

var
  Welcome:TWelcome;
  frmWelcome:TfrmWelcome;
implementation
uses uFnUtil, ufrmMain, uMsgBox;
{$R *.dfm}

function DivText(s1,s2:real):real;
begin
  if s2=0 then result := 0 else result := s1 / s2;
end;
function TfrmWelcome.PutText(Font: TFont; Text: String):string;
function GetColor(Color: TColor): String;
var s: String;
begin
  if Color = clNone then
    s := '000000'
  else
    s := IntToHex(ColorToRGB(Color), 6);
  Result := Copy(s, 5, 2) + Copy(s, 3, 2) + Copy(s, 1, 2);
end;
var s: String;
begin
  s := '<FONT STYLE="font-family: ' + Font.Name;
  s := s + '; font-size: ' + IntToStr(Font.Size);
  s := s + 'pt; color: #' + GetColor(Font.Color) + '">';

  if (fsBold in Font.Style) then s := s + '<B>';
  if (fsItalic in Font.Style) then s := S + '<I>';
  if (fsUnderline in Font.Style) then s := s + '<U>';
  if (fsStrikeOut in Font.Style) then s := s + '<STRIKE>';

  Text := StringReplace(Text, '&', '&amp', [rfReplaceAll]);
  Text := StringReplace(Text, '<', '&lt', [rfReplaceAll]);
  Text := StringReplace(Text, '>', '&gt', [rfReplaceAll]);
  Text := StringReplace(Text, '"', '&quot', [rfReplaceAll]);
  Text := StringReplace(Text, ' ', '&nbsp', [rfReplaceAll]);

  if Text <> '' then
    s := s + Text
  else
    s := s + '&nbsp';

  if (fsBold in Font.Style) then s := s + '</B>';
  if (fsItalic in Font.Style) then s := S + '</I>';
  if (fsUnderline in Font.Style) then s := s + '</U>';
  if (fsStrikeOut in Font.Style) then s := s + '</STRIKE>';
  s := s + '</FONT>';

  result := s+ #13#10;
end;

function TfrmWelcome.EncodeDaySaleInfo: string;
var
  s:string;
  Font:TFont;
  MsgDayInfo:TMsgDayInfo;
  NotYSFlag,NotTDFlag: Boolean; //����ͽ����Ƿ�����
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmSaleAnaly)">'+PutText(Font,'1.���۸ſ�')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    NotYSFlag:=(MsgDayInfo.YDSale_AMT=0) and (MsgDayInfo.YDSale_MNY=0) and (MsgDayInfo.YDSale_PRF=0);
    NotTDFlag:=(MsgDayInfo.TDSale_AMT=0) and (MsgDayInfo.TDSale_MNY=0) and (MsgDayInfo.TDSale_PRF=0);
    //��ʾ�վ�Ӫ���
    if (NotYSFlag) and (NotTDFlag) then //���졢����û�о�Ӫ
    begin
      result := result + PutText(Font,'    ������ͽ��춼�����ۣ�ף��������¡�����ͣ�');
    end else
    if (NotYSFlag) and (not NotTDFlag) then //����û�о�Ӫ,���쾭Ӫ
    begin
      result := result + PutText(Font,'   ������δ���۾��̣�'+
                    '�����������۾���Ʒ��'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'����'+
                    InttoStr(MsgDayInfo.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'����'+
                    '���'+FormatFloat('#0.00',MsgDayInfo.TDSale_MNY)+'Ԫ��'+
                    'ë��'+FormatFloat('#0.00',MsgDayInfo.TDSale_PRF)+'Ԫ��'+
                    'ë����'+FormatFloat('#0.00',MsgDayInfo.TDSale_PRF_RATE)+'%���������ͣ�')+ #13#10+'<BR>'+ #13#10;
    end else
    if (Not NotYSFlag) and (NotTDFlag) then //���쾭Ӫ,���컹û��Ӫ
    begin
      s := '    ���������۾���Ʒ��'+InttoStr(MsgDayInfo.YDSaleGods_Count)+'����'+
           InttoStr(MsgDayInfo.YDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',MsgDayInfo.YDSale_AMT)+'����'+
           '���'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY)+'Ԫ��'+
           'ë��'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF)+'Ԫ��'+
           'ë����'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF_RATE)+'%';
      if MsgDayInfo.QTSale_AMT<>0 then
         begin
           if MsgDayInfo.QTSale_AMT<MsgDayInfo.YDSale_AMT then
             s := s+
             ',��ǰ��ȣ���������'+FormatFloat('#0.00',MsgDayInfo.YDSale_AMT-MsgDayInfo.QTSale_AMT)+'����'+
             '�������'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY-MsgDayInfo.QTSale_MNY)+'Ԫ��'+
             'ë������'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF-MsgDayInfo.QTSale_PRF)+'Ԫ��'
           else
             s := s+
             ',��ǰ��ȣ������½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_AMT-MsgDayInfo.YDSale_AMT)+'����'+
             '����½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_MNY-MsgDayInfo.YDSale_MNY)+'Ԫ��'+
             'ë���½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_PRF-MsgDayInfo.YDSale_PRF)+'Ԫ��';
         end;
      result := result + PutText(Font,s)+'<BR>'+#13#10;
      s := '    �����컹û�����ۣ�ף��������¡�����ͣ�';
      result := result + PutText(Font,s)+#13#10+'<BR>'+ #13#10;
    end else
    if (not NotYSFlag) and (not NotTDFlag) then //���쾭Ӫ,���컹û��Ӫ
    begin
      s := '    ���������۾���Ʒ��'+InttoStr(MsgDayInfo.YDSaleGods_Count)+'����'+
           InttoStr(MsgDayInfo.YDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',MsgDayInfo.YDSale_AMT)+'����'+
           '���'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY)+'Ԫ��'+
           'ë��'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF)+'Ԫ��'+
           'ë����'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF_RATE)+'%';
      if MsgDayInfo.QTSale_AMT<>0 then
         begin
           if MsgDayInfo.QTSale_AMT<MsgDayInfo.YDSale_AMT then
             s := s+
             ',��ǰ��ȣ���������'+FormatFloat('#0.00',MsgDayInfo.YDSale_AMT-MsgDayInfo.QTSale_AMT)+'����'+
             '�������'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY-MsgDayInfo.QTSale_MNY)+'Ԫ��'+
             'ë������'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF-MsgDayInfo.QTSale_PRF)+'Ԫ��'
           else
             s := s+
             ',��ǰ��ȣ������½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_AMT-MsgDayInfo.YDSale_AMT)+'����'+
             '����½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_MNY-MsgDayInfo.YDSale_MNY)+'Ԫ��'+
             'ë���½�'+FormatFloat('#0.00',MsgDayInfo.QTSale_PRF-MsgDayInfo.YDSale_PRF)+'Ԫ��';
         end;
      result := result + PutText(Font,s)+'<BR>'+#13#10;
      s := '    �����컹û�����ۣ�ף��������¡�����ͣ�';
      result := result + PutText(Font,s)+#13#10+'<BR>'+ #13#10;
      if MsgDayInfo.TDSale_PRF<MsgDayInfo.YDSale_PRF then //С������
      begin
        s:='    �����������۾���Ʒ��'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'����'+
             InttoStr(MsgDayInfo.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'����'+
             '���'+FormatFloat('#0.###',MsgDayInfo.TDSale_MNY)+'Ԫ��'+
             'ë��'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF)+'Ԫ��'+
             'ë����'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF_RATE)+'%��'+
             '�����������������Ļ���һ�����,�ټӰ��ͣ�';
        result := result + PutText(Font,s)+ #13#10;
      end else
      begin
        s:='    ��ϲ�����������۾���Ʒ��'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'����'+
             InttoStr(MsgDayInfo.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'����'+
             '���'+FormatFloat('#0.###',MsgDayInfo.TDSale_MNY)+'Ԫ��'+
             'ë��'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF)+'Ԫ��'+
             'ë����'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF_RATE)+'%�������';
        result := result + PutText(Font,s)+ #13#10;
      end;
    end;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeDayStockInfo: string;
var
  s:string;
  Font:TFont;
  MsgDayInfo:TMsgDayInfo;
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmStockTotalReport)">'+PutText(Font,'2.�������')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    if MsgDayInfo.SCStock_AMT<>0 then
    s:=
      '    �����ξ��̽���Ʒ��'+InttoStr(MsgDayInfo.TDStockGods_Count)+'����'+
      ''+FormatFloat('#0.##',MsgDayInfo.TDStock_AMT)+'����'+
      '���'+FormatFloat('#0.##',MsgDayInfo.TDStock_MNY)+'Ԫ��'+
      '����ֵ'+ FormatFloat('#0.##',MsgDayInfo.TDStock_MNY/MsgDayInfo.TDStock_AMT)+'Ԫ��'
    else
    s:= '  ����û�н�����¼���뵽���̵�����������ȷ�ϰɡ�';
    if MsgDayInfo.SCStock_AMT>0 then
      begin
          s:= s+
          '���ϴαȣ�'+
          '����������'+FormatFloat('#0.00',(MsgDayInfo.TDStock_AMT-MsgDayInfo.SCStock_AMT)*100/MsgDayInfo.SCStock_AMT)+'%��'+
          '�������'+FormatFloat('#0.00',MsgDayInfo.TDStock_MNY-MsgDayInfo.SCStock_MNY)+'Ԫ��'+
          '����ֵ����'+FormatFloat('#0.00',(MsgDayInfo.TDStock_MNY/MsgDayInfo.TDStock_AMT)-(MsgDayInfo.SCStock_MNY/MsgDayInfo.SCStock_AMT))+'Ԫ��'
      end;
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeDayStorageInfo: string;
var
  s:string;
  Font:TFont;
  MsgDayInfo:TMsgDayInfo;
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmStgTotalReport)">'+PutText(Font,'3.������')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    s:='    ����ǰ��Ӫ����'+InttoStr(MsgDayInfo.TMGods_All_Count)+'����'+
         '���Ʒ��'+InttoStr(MsgDayInfo.TMGods_Count)+'����'+         ''+FloattoStr(MsgDayInfo.TMAllStor_AMT)+'��';    if MsgDayInfo.TMLowStor_Count>0 then      s:=s+'����'+InttoStr(MsgDayInfo.TMLowStor_Count)+'�������ں����棬Ӧ��ʱ�����Դ��'    else      s:=s+'��';    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeDayInfo: string;
begin
  result := '';
  result := result+'<html>'+#13+#10;
  result := result+'<head>'+#13+#10;
  result := result+'<title>ÿ�վ�Ӫ����</title>'+#13+#10;
  result := result+'</head>'+#13+#10;
  result := result+'<style type="text/css">'+#13+#10;
  result := result+'<!--   '+#13+#10;
  result := result+'* {margin:0;padding:0; border:0;}'+#13+#10;
  result := result+'a:link { text-decoration: none; }'+#13+#10;
  result := result+'a:visited { text-decoration: none; } '+#13+#10;
  result := result+'a:hover { text-decoration: none; } '+#13+#10;
  result := result+'a:active { text-decoration: none; } '+#13+#10;
  result := result+'  -->'+#13+#10;
  result := result+'</style>'+#13+#10;
  result := result+EncodeScript;
  result := result+'<body border="0" scroll="no" bgcolor="#EDF6FD" oncontextmenu ="return false">'+#13+#10;
  result := result+EncodeDaySaleInfo;
  result := result+'<BR><BR>'+EncodeDayStockInfo;
  result := result+'<BR><BR>'+EncodeDayStorageInfo;
  result := result+'</body>'+#13+#10;
  result := result+'</html>';
end;

procedure TfrmWelcome.Createparams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      WndParent:= Application.MainForm.Handle;
    end;  
end;

class procedure TfrmWelcome.Popup;
begin
  if frmWelcome=nil then
     begin
       frmWelcome := TfrmWelcome.Create(Application.MainForm);
       frmWelcome.Show;
     end
  else
     begin
       frmWelcome.WindowState := wsNormal;
       frmWelcome.Show;
       frmWelcome.bringtoFront;
     end;
  frmWelcome.OpenPage1;
end;

procedure TfrmWelcome.ShowInfo(IEBrowser: TWebBrowser; s: string);
var Stream_Str:TStringStream;
    _Start:Int64;
begin
  Stream_Str := TStringStream.Create(s);
  try
    _Start := GetTickCount;
    IEBrowser.Navigate('about:blank');
    while IEBrowser.ReadyState <> READYSTATE_COMPLETE do
      begin
        if (GetTickCount - _Start) > 10000 then break;
        Application.ProcessMessages;
      end;
    if IEBrowser.Document=nil then Raise Exception.Create('��IE���ʧ����...'); 
    Stream_Str.Position := 0;
    (IEBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(Stream_Str));
  finally
    Stream_Str.Free;
  end;
end;

procedure TfrmWelcome.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmWelcome.FormDestroy(Sender: TObject);
begin
  inherited;
  frmWelcome := nil;
end;

procedure TfrmWelcome.ImgCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmWelcome.ImgIKnowClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmWelcome.OpenPage1;
begin
  RzPage.ActivePageIndex := 0;
  ShowInfo(DayBrowser,EncodeDayInfo);
end;

procedure TfrmWelcome.OpenPage2;
begin
  RzPage.ActivePageIndex := 1;
  ShowInfo(MthBrowser,EncodeMthInfo);
  Lbl_Month_Title.Caption := copy(Welcome.Month,1,4)+'��'+copy(Welcome.Month,5,2)+'�·ݾ�Ӫ����';
end;

procedure TfrmWelcome.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  OpenPage1;
end;

procedure TfrmWelcome.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  OpenPage2;
end;

function TfrmWelcome.EncodeMthInfo: string;
begin
  result := '';
  result := result+'<html>'+#13+#10;
  result := result+'<head>'+#13+#10;
  result := result+'<title>ÿ�վ�Ӫ����</title>'+#13+#10;
  result := result+'</head>'+#13+#10;
  result := result+'<style type="text/css">'+#13+#10;
  result := result+'<!--   '+#13+#10;
  result := result+'* {margin:0;padding:0; border:0;}'+#13+#10;
  result := result+'a:link { text-decoration: none; }'+#13+#10;
  result := result+'a:visited { text-decoration: none; } '+#13+#10;
  result := result+'a:hover { text-decoration: none; } '+#13+#10;
  result := result+'a:active { text-decoration: none; } '+#13+#10;
  result := result+'  -->'+#13+#10;
  result := result+'</style>'+#13+#10;
  result := result+EncodeScript;
  result := result+'<body border="0" scroll="no" bgcolor="#EDF6FD" oncontextmenu ="return false">'+#13+#10;
  result := result+EncodeMthStockInfo;
  result := result+'<BR><BR>'+EncodeMthSalesInfo;
  result := result+'<BR><BR>'+EncodeMthStgInfo;
  result := result+'<BR><BR>'+EncodeMthCustInfo;
  result := result+'</body>'+#13+#10;
  result := result+'</html>';
end;

procedure TfrmWelcome.FormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  for i := 0 to RzPage.PageCount - 1 do
  begin
    RzPage.Pages[i].TabVisible := False;
  end;
  ImgClose.left := width-ImgClose.width-4;
end;

function TfrmWelcome.EncodeMthStockInfo: string;
var
  s:string;
  Font:TFont;
  MsgDayInfo:TMsgDayInfo;
  MsgMonthInfo:TMsgMonthInfo;
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmStockTotalReport)">'+PutText(Font,'1.���½������')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];

    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    MsgMonthInfo := Welcome.EncodeMsgMthInfo;

    //1�����½������
    s:='    �̲ݹ�˾���¹�Ӧ�ĳ���Ʒ��'+InttoStr(MsgDayInfo.TMGods_SX_Count)+'����'+
          '��Ŀǰ��ӪƷ��'+InttoStr(MsgDayInfo.TMGods_All_Count)+'����'+
          '�����̲ݹ�˾��Ӧ��Ʒ'+InttoStr(MsgDayInfo.TMGods_NEW_Count)+'����'+
          '��Ŀǰ��Ӫ'+InttoStr(MsgDayInfo.TMGods_Count)+'����'+
          '�����¹�������'+formatFloat('#0.0#',MsgMonthInfo.TMStock_AMT)+'����'+
          '����ֵ'+formatFloat('#0.00',DivText(MsgMonthInfo.TMStock_MNY,MsgMonthInfo.TMStock_AMT))+'Ԫ��';

    result := result + PutText(Font,s)+ #13#10;      finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeMthSalesInfo: string;
var
  s:string;
  Font:TFont;
  MsgMthInfo:TMsgMonthInfo;
  NotYSFlag,NotTDFlag: Boolean; //����ͽ����Ƿ�����
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmSaleAnaly)">'+PutText(Font,'1.�����������')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgMthInfo := Welcome.EncodeMsgMthInfo;
    
    //2�������������
    s:='    ���������۾���'+formatFloat('#0.0#',MsgMthInfo.TMSale_AMT)+'����'+
          '����ֵ'+formatFloat('#0.00',MsgMthInfo.TMSale_SINGLE_MNY)+'Ԫ��'+
          'ʵ��ë��'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF)+'Ԫ��ë����'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF_RATE)+'%��';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    
    s:='    �����������±ȣ���������'+formatFloat('#0.00',MsgMthInfo.TMSale_AMT_UP_RATE)+'%��'+
          '����ֵ����'+formatFloat('#0.00',MsgMthInfo.TMSale_SINGLE_MNY_UP_RATE)+'%��'+
          'ë������'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF_UP_RATE)+'%��';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;

    s:='    ��������������������ֱ��ǣ�'+MsgMthInfo.TMGods_MaxGrow_AMT+'������ë��������������ֱ��ǣ�'+MsgMthInfo.TMGods_MaxGrow_PRF+'��';    s:='����ë���������������ֱ��ǣ�'+MsgMthInfo.TMGods_MaxGrow_PRF+'��';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    s:='    ����ë��������������ֱ��ǣ�'+MsgMthInfo.LMGods_SY_MaxGrow_PRF+'�������������ȣ��������Ĺ���ǣ�'+MsgMthInfo.TMGods_MaxGrowRate_AMT+'��';
    result := result + PutText(Font,s)+ #13#10;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeMthStgInfo: string;
var
  s:string;
  Font:TFont;
  MsgDayInfo:TMsgDayInfo;
  NotYSFlag,NotTDFlag: Boolean; //����ͽ����Ƿ�����
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmStgTotalReport)">'+PutText(Font,'3.��ǰ������')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    s:='    ����ǰ��Ӫ����'+InttoStr(MsgDayInfo.TMGods_All_Count)+'����'+
         '���Ʒ��'+InttoStr(MsgDayInfo.TMGods_Count)+'����'+         ''+FloattoStr(MsgDayInfo.TMAllStor_AMT)+'��';    if MsgDayInfo.TMLowStor_Count>0 then      s:=s+'����'+InttoStr(MsgDayInfo.TMLowStor_Count)+'�������ں����棬Ӧ��ʱ�����Դ��'    else      s:=s+'��';    result := result + PutText(Font,s)+ #13#10;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeMthCustInfo: string;
var
  s:string;
  Font:TFont;
  MsgMthInfo:TMsgMonthInfo;
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmClientSaleReport)">'+PutText(Font,'4.���Ŀͻ����')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgMthInfo := Welcome.EncodeMsgMthInfo;
  //4�����Ŀͻ����
   s:='    ��Ŀǰ�ѽ��������ߵ���'+InttoStr(MsgMthInfo.TMCust_Count)+'����'+
         '�����½�'+InttoStr(MsgMthInfo.TMCust_NEW_Count)+'����';
         '�ߵ��̵�������'+InttoStr(MsgMthInfo.TMCust_HG_Count)+'����'+

    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    
   s:='    ��Щ��������������'+formatFloat('#0.0#',MsgMthInfo.TMCust_AMT)+'����'+
         'ռ������������'+formatFloat('#0.00',MsgMthInfo.TMCust_AMT_RATE)+'%��'+
         '���ѽ��'+formatFloat('#0.00',MsgMthInfo.TMCust_MNY)+'Ԫ��'+
         'ռ���������۶��'+formatFloat('#0.00',MsgMthInfo.TMCust_MNY_RATE)+'%��'+
         '���Ŀͻ�����'+MsgMthInfo.TMCust_MAX_TIME+'���̣���ʱ�ο��Լ�ǿ������';

    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
  finally
    Font.Free;
  end;
end;

procedure TfrmWelcome.AddMonth(SetValue: integer);
var
  CurDate: TDate;
begin
  CurDate:=FnTime.fnStrtoDate(Welcome.Month+'01'); //���·�ת��ʱ��
  CurDate:= IncMonth(CurDate,SetValue);  //�·ݼӼ�
  Welcome.Month :=FormatDatetime('YYYYMM',CurDate);
  OpenPage2;
end;

procedure TfrmWelcome.Img_leftClick(Sender: TObject);
begin
  inherited;
  AddMonth(-1);
end;

procedure TfrmWelcome.Img_rightClick(Sender: TObject);
begin
  inherited;
  AddMonth(1);
end;

procedure TfrmWelcome.DayBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  s:string;
  w:integer;
  vList:TStringList;
  Action:TAction;
begin
  inherited;
  Cancel := false;
  s := url;
  w := pos('dsk=',s);
  if w=0 then Exit;
  delete(s,1,w+4);
  if (s<>'') and (s[length(s)]=')') then delete(s,length(s),1);
  Cancel := true;
  vList := TStringList.Create;
  try
    vList.CommaText := s;
    Action := frmMain.FindAction(vList.Values['action']);
    if Assigned(Action) and Action.Enabled then
       begin
         Action.OnExecute(Action);
         Close;
       end
    else ShowMsgBox('��û�в�����ģ���Ȩ��...','������ʾ...',MB_OK+MB_ICONINFORMATION);
  finally
     vList.Free;
  end;
end;

procedure TfrmWelcome.MthBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  s:string;
  w:integer;
  vList:TStringList;
  Action:TAction;
begin
  inherited;
  Cancel := false;
  s := url;
  w := pos('dsk=',s);
  if w=0 then Exit;
  delete(s,1,w+4);
  if (s<>'') and (s[length(s)]=')') then delete(s,length(s),1);
  Cancel := true;
  vList := TStringList.Create;
  try
    vList.CommaText := s;
    Action := frmMain.FindAction(vList.Values['action']);
    if Assigned(Action) and Action.Enabled then
       begin
         Action.OnExecute(Action);
         Close;
       end
    else ShowMsgBox('��û�в�����ģ���Ȩ��...','������ʾ...',MB_OK+MB_ICONINFORMATION);
  finally
     vList.Free;
  end;
end;

function TfrmWelcome.EncodeScript: string;
begin
result := '';
end;

initialization
  Welcome := TWelcome.Create;
  frmWelcome := nil;
finalization
  Welcome.Free;
end.
