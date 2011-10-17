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
    //生成日销售提醒
    function EncodeDaySaleInfo:string;
    //生成日进货提醒
    function EncodeDayStockInfo:string;
    //生成日库存提醒
    function EncodeDayStorageInfo:string;
    //生成日HTML
    function EncodeDayInfo:string;

    //本月进货情况
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
  NotYSFlag,NotTDFlag: Boolean; //昨天和今天是否销售
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmSaleAnaly)">'+PutText(Font,'1.销售概况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    NotYSFlag:=(MsgDayInfo.YDSale_AMT=0) and (MsgDayInfo.YDSale_MNY=0) and (MsgDayInfo.YDSale_PRF=0);
    NotTDFlag:=(MsgDayInfo.TDSale_AMT=0) and (MsgDayInfo.TDSale_MNY=0) and (MsgDayInfo.TDSale_PRF=0);
    //显示日经营情况
    if (NotYSFlag) and (NotTDFlag) then //昨天、今天没有经营
    begin
      result := result + PutText(Font,'    您昨天和今天都无销售，祝您生意兴隆，加油！');
    end else
    if (NotYSFlag) and (not NotTDFlag) then //昨天没有经营,今天经营
    begin
      result := result + PutText(Font,'   昨天您未销售卷烟，'+
                    '今天您的销售卷烟品种'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'个，'+
                    InttoStr(MsgDayInfo.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'条，'+
                    '金额'+FormatFloat('#0.00',MsgDayInfo.TDSale_MNY)+'元，'+
                    '毛利'+FormatFloat('#0.00',MsgDayInfo.TDSale_PRF)+'元，'+
                    '毛利率'+FormatFloat('#0.00',MsgDayInfo.TDSale_PRF_RATE)+'%，继续加油！')+ #13#10+'<BR>'+ #13#10;
    end else
    if (Not NotYSFlag) and (NotTDFlag) then //昨天经营,今天还没经营
    begin
      s := '    昨天您销售卷烟品种'+InttoStr(MsgDayInfo.YDSaleGods_Count)+'个，'+
           InttoStr(MsgDayInfo.YDSaleBill_Count)+'笔，'+FormatFloat('#0.###',MsgDayInfo.YDSale_AMT)+'条，'+
           '金额'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY)+'元，'+
           '毛利'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF)+'元，'+
           '毛利率'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF_RATE)+'%';
      if MsgDayInfo.QTSale_AMT<>0 then
         begin
           if MsgDayInfo.QTSale_AMT<MsgDayInfo.YDSale_AMT then
             s := s+
             ',与前天比，销量增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_AMT-MsgDayInfo.QTSale_AMT)+'条，'+
             '金额增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY-MsgDayInfo.QTSale_MNY)+'元，'+
             '毛利增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF-MsgDayInfo.QTSale_PRF)+'元。'
           else
             s := s+
             ',与前天比，销量下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_AMT-MsgDayInfo.YDSale_AMT)+'条，'+
             '金额下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_MNY-MsgDayInfo.YDSale_MNY)+'元，'+
             '毛利下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_PRF-MsgDayInfo.YDSale_PRF)+'元。';
         end;
      result := result + PutText(Font,s)+'<BR>'+#13#10;
      s := '    您今天还没有销售，祝您生意兴隆，加油！';
      result := result + PutText(Font,s)+#13#10+'<BR>'+ #13#10;
    end else
    if (not NotYSFlag) and (not NotTDFlag) then //昨天经营,今天还没经营
    begin
      s := '    昨天您销售卷烟品种'+InttoStr(MsgDayInfo.YDSaleGods_Count)+'个，'+
           InttoStr(MsgDayInfo.YDSaleBill_Count)+'笔，'+FormatFloat('#0.###',MsgDayInfo.YDSale_AMT)+'条，'+
           '金额'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY)+'元，'+
           '毛利'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF)+'元，'+
           '毛利率'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF_RATE)+'%';
      if MsgDayInfo.QTSale_AMT<>0 then
         begin
           if MsgDayInfo.QTSale_AMT<MsgDayInfo.YDSale_AMT then
             s := s+
             ',与前天比，销量增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_AMT-MsgDayInfo.QTSale_AMT)+'条，'+
             '金额增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_MNY-MsgDayInfo.QTSale_MNY)+'元，'+
             '毛利增长'+FormatFloat('#0.00',MsgDayInfo.YDSale_PRF-MsgDayInfo.QTSale_PRF)+'元。'
           else
             s := s+
             ',与前天比，销量下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_AMT-MsgDayInfo.YDSale_AMT)+'条，'+
             '金额下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_MNY-MsgDayInfo.YDSale_MNY)+'元，'+
             '毛利下降'+FormatFloat('#0.00',MsgDayInfo.QTSale_PRF-MsgDayInfo.YDSale_PRF)+'元。';
         end;
      result := result + PutText(Font,s)+'<BR>'+#13#10;
      s := '    您今天还没有销售，祝您生意兴隆，加油！';
      result := result + PutText(Font,s)+#13#10+'<BR>'+ #13#10;
      if MsgDayInfo.TDSale_PRF<MsgDayInfo.YDSale_PRF then //小于昨天
      begin
        s:='    今天您的销售卷烟品种'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'个，'+
             InttoStr(MsgDayInfo.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'条，'+
             '金额'+FormatFloat('#0.###',MsgDayInfo.TDSale_MNY)+'元，'+
             '毛利'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF)+'元，'+
             '毛利率'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF_RATE)+'%，'+
             '您今天的销售离昨天的还有一定差距,再加把油！';
        result := result + PutText(Font,s)+ #13#10;
      end else
      begin
        s:='    恭喜您，今天销售卷烟品种'+InttoStr(MsgDayInfo.TDSaleGods_Count)+'个，'+
             InttoStr(MsgDayInfo.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',MsgDayInfo.TDSale_AMT)+'条，'+
             '金额'+FormatFloat('#0.###',MsgDayInfo.TDSale_MNY)+'元，'+
             '毛利'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF)+'元，'+
             '毛利率'+FormatFloat('#0.###',MsgDayInfo.TDSale_PRF_RATE)+'%，真棒！';
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
    result := '<a href="dsk=(action=actfrmStockTotalReport)">'+PutText(Font,'2.进货情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    if MsgDayInfo.SCStock_AMT<>0 then
    s:=
      '    您本次卷烟进货品种'+InttoStr(MsgDayInfo.TDStockGods_Count)+'个，'+
      ''+FormatFloat('#0.##',MsgDayInfo.TDStock_AMT)+'条，'+
      '金额'+FormatFloat('#0.##',MsgDayInfo.TDStock_MNY)+'元，'+
      '单条值'+ FormatFloat('#0.##',MsgDayInfo.TDStock_MNY/MsgDayInfo.TDStock_AMT)+'元。'
    else
    s:= '  您还没有进货记录，请到卷烟到货里做到货确认吧。';
    if MsgDayInfo.SCStock_AMT>0 then
      begin
          s:= s+
          '与上次比，'+
          '进货量增长'+FormatFloat('#0.00',(MsgDayInfo.TDStock_AMT-MsgDayInfo.SCStock_AMT)*100/MsgDayInfo.SCStock_AMT)+'%，'+
          '金额增长'+FormatFloat('#0.00',MsgDayInfo.TDStock_MNY-MsgDayInfo.SCStock_MNY)+'元，'+
          '单条值增长'+FormatFloat('#0.00',(MsgDayInfo.TDStock_MNY/MsgDayInfo.TDStock_AMT)-(MsgDayInfo.SCStock_MNY/MsgDayInfo.SCStock_AMT))+'元。'
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
    result := '<a href="dsk=(action=actfrmStgTotalReport)">'+PutText(Font,'3.库存情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    s:='    您当前经营卷烟'+InttoStr(MsgDayInfo.TMGods_All_Count)+'个，'+
         '库存品种'+InttoStr(MsgDayInfo.TMGods_Count)+'个，'+         ''+FloattoStr(MsgDayInfo.TMAllStor_AMT)+'条';    if MsgDayInfo.TMLowStor_Count>0 then      s:=s+'，有'+InttoStr(MsgDayInfo.TMLowStor_Count)+'个规格低于合理库存，应及时补充货源。'    else      s:=s+'。';    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
  finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeDayInfo: string;
begin
  result := '';
  result := result+'<html>'+#13+#10;
  result := result+'<head>'+#13+#10;
  result := result+'<title>每日经营提醒</title>'+#13+#10;
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
    if IEBrowser.Document=nil then Raise Exception.Create('打开IE插件失败了...'); 
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
  Lbl_Month_Title.Caption := copy(Welcome.Month,1,4)+'年'+copy(Welcome.Month,5,2)+'月份经营提醒';
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
  result := result+'<title>每日经营提醒</title>'+#13+#10;
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
    result := '<a href="dsk=(action=actfrmStockTotalReport)">'+PutText(Font,'1.本月进货情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];

    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    MsgMonthInfo := Welcome.EncodeMsgMthInfo;

    //1、本月进货情况
    s:='    烟草公司本月供应的畅销品种'+InttoStr(MsgDayInfo.TMGods_SX_Count)+'个，'+
          '您目前经营品种'+InttoStr(MsgDayInfo.TMGods_All_Count)+'个；'+
          '本月烟草公司供应新品'+InttoStr(MsgDayInfo.TMGods_NEW_Count)+'个，'+
          '您目前经营'+InttoStr(MsgDayInfo.TMGods_Count)+'个；'+
          '您本月购进卷烟'+formatFloat('#0.0#',MsgMonthInfo.TMStock_AMT)+'条，'+
          '单条值'+formatFloat('#0.00',DivText(MsgMonthInfo.TMStock_MNY,MsgMonthInfo.TMStock_AMT))+'元。';

    result := result + PutText(Font,s)+ #13#10;      finally
    Font.Free;
  end;
end;

function TfrmWelcome.EncodeMthSalesInfo: string;
var
  s:string;
  Font:TFont;
  MsgMthInfo:TMsgMonthInfo;
  NotYSFlag,NotTDFlag: Boolean; //昨天和今天是否销售
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmSaleAnaly)">'+PutText(Font,'1.本月销售情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgMthInfo := Welcome.EncodeMsgMthInfo;
    
    //2、本月销售情况
    s:='    您本月销售卷烟'+formatFloat('#0.0#',MsgMthInfo.TMSale_AMT)+'条，'+
          '单条值'+formatFloat('#0.00',MsgMthInfo.TMSale_SINGLE_MNY)+'元，'+
          '实现毛利'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF)+'元，毛利率'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF_RATE)+'%。';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    
    s:='    您本月与上月比：销量增长'+formatFloat('#0.00',MsgMthInfo.TMSale_AMT_UP_RATE)+'%，'+
          '单条值增长'+formatFloat('#0.00',MsgMthInfo.TMSale_SINGLE_MNY_UP_RATE)+'%，'+
          '毛利增长'+formatFloat('#0.00',MsgMthInfo.TMSale_PRF_UP_RATE)+'%。';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;

    s:='    您本月销量最大的五个规格分别是：'+MsgMthInfo.TMGods_MaxGrow_AMT+'；本月毛利额最大的五个规格分别是：'+MsgMthInfo.TMGods_MaxGrow_PRF+'；';    s:='本月毛利额最大的三个规格分别是：'+MsgMthInfo.TMGods_MaxGrow_PRF+'；';
    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    s:='    上月毛利额最大的五个规格分别是：'+MsgMthInfo.LMGods_SY_MaxGrow_PRF+'；与上月销量比，增长最快的规格是：'+MsgMthInfo.TMGods_MaxGrowRate_AMT+'。';
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
  NotYSFlag,NotTDFlag: Boolean; //昨天和今天是否销售
begin
  Font := TFont.Create;
  try
    Font.Assign(self.Font);
    Font.Style := [fsBold];
    result := '<a href="dsk=(action=actfrmStgTotalReport)">'+PutText(Font,'3.当前库存情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgDayInfo := Welcome.EncodeMsgDayInfo;
    s:='    您当前经营卷烟'+InttoStr(MsgDayInfo.TMGods_All_Count)+'个，'+
         '库存品种'+InttoStr(MsgDayInfo.TMGods_Count)+'个，'+         ''+FloattoStr(MsgDayInfo.TMAllStor_AMT)+'条';    if MsgDayInfo.TMLowStor_Count>0 then      s:=s+'，有'+InttoStr(MsgDayInfo.TMLowStor_Count)+'个规格低于合理库存，应及时补充货源。'    else      s:=s+'。';    result := result + PutText(Font,s)+ #13#10;
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
    result := '<a href="dsk=(action=actfrmClientSaleReport)">'+PutText(Font,'4.您的客户情况')+'</a>'+ #13#10+'<BR><BR>'+ #13#10;
    Font.Style := [];
    MsgMthInfo := Welcome.EncodeMsgMthInfo;
  //4、您的客户情况
   s:='    您目前已建立消费者档案'+InttoStr(MsgMthInfo.TMCust_Count)+'个，'+
         '本月新建'+InttoStr(MsgMthInfo.TMCust_NEW_Count)+'个，';
         '高档烟的消费者'+InttoStr(MsgMthInfo.TMCust_HG_Count)+'名。'+

    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
    
   s:='    这些消费者销售数量'+formatFloat('#0.0#',MsgMthInfo.TMCust_AMT)+'条，'+
         '占卷烟总销量的'+formatFloat('#0.00',MsgMthInfo.TMCust_AMT_RATE)+'%，'+
         '消费金额'+formatFloat('#0.00',MsgMthInfo.TMCust_MNY)+'元，'+
         '占卷烟总销售额的'+formatFloat('#0.00',MsgMthInfo.TMCust_MNY_RATE)+'%；'+
         '您的客户常在'+MsgMthInfo.TMCust_MAX_TIME+'买烟，该时段可以加强宣传。';

    result := result + PutText(Font,s)+ #13#10+'<BR>'+ #13#10;
  finally
    Font.Free;
  end;
end;

procedure TfrmWelcome.AddMonth(SetValue: integer);
var
  CurDate: TDate;
begin
  CurDate:=FnTime.fnStrtoDate(Welcome.Month+'01'); //将月份转成时间
  CurDate:= IncMonth(CurDate,SetValue);  //月份加减
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
    else ShowMsgBox('你没有操作此模块的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
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
    else ShowMsgBox('你没有操作此模块的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
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
