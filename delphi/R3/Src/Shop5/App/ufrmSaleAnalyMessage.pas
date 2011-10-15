unit ufrmSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ufrmBasic, ExtCtrls, ActnList, Menus, RzPanel, RzForms, RzBckgnd,
  StdCtrls, jpeg, RzBmpBtn, RzTabs, cxTextEdit, cxDropDownEdit, cxControls,
  EncDec,cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxMemo, cxCheckBox, 
  IniFiles, zBase, ComCtrls, RzTreeVw, uGodsFactory, uTreeUtil, zDataSet,DB,
  cxCalendar,ZAbstractRODataset, ZAbstractDataset, RzLabel, RzButton,
  RzEdit,uSaleAnalyMessage, Buttons;

const
  SpaceStr='   ';  

type
  TfrmSaleAnalyMessage = class(TfrmBasic)
    RzPanel1: TRzPanel;
    CdsUsing: TZQuery;
    RzPanel2: TRzPanel;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    Image1: TImage;
    RzPanel4: TRzPanel;
    ImgLeftLine: TImage;
    ImgRightLine: TImage;
    RzPanel3: TRzPanel;
    ImgButtom: TImage;
    ImgIKnow: TImage;
    Image2: TImage;
    Image3: TImage;
    RzFormShape1: TRzFormShape;
    RzPanel6: TRzPanel;
    RzPage: TRzPageControl;
    Tab1: TRzTabSheet;
    Tab2: TRzTabSheet;
    PnlTitleMonth: TRzPanel;
    ImgClose: TImage;
    DayRTF: TRzRichEdit;
    RzPanel5: TRzPanel;
    MonthRTF: TRzRichEdit;
    ImgMonth: TImage;
    Lbl_Month_Title: TLabel;
    ImgDay: TImage;
    Lbl_Day_Title: TLabel;
    Img_left: TRzBmpButton;
    Img_right: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
    procedure Lbl_LinkSaleAnlyClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgIKnowClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Img_leftClick(Sender: TObject);
    procedure Img_rightClick(Sender: TObject);
    procedure Img_rightMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Img_leftMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Img_rightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Img_leftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    NearMonth: string;  //最近浏览一月
    CurMonth: string;   //当前显示一月
    FDoAction: TAction;
    FSaleAnaly: TSaleAnalyMsg;
    Page1ed,Page2ed:boolean;
    function  HintMonthMsg(SetMonth: integer): string;
    procedure SetMonth(var CurMonth: string; SetValue: integer);
    procedure SetComponentPostion; //控制2个提示内容标题显示位置
    procedure SetRTFFont(SetRTF: TRzRichEdit; BegIdx,SetLen: integer);
    procedure ShowDaysSaleInfo; //显示天天经营提醒
    procedure ShowMonthSaleInfo;   //显示月度经营情况
    procedure OpenPage1;
    procedure OpenPage2(vMonth: string='');
    procedure SetSaleAnaly(const Value: TSaleAnalyMsg);
    procedure ShowMonthTitle;
  public
    //DoAction:传入调用显示：销售分析表，现在要调用
    class function ShowSaleAnalyMsg(AOwner:TForm; DoAction: TAction=nil):boolean;
    property SaleAnaly:TSaleAnalyMsg read FSaleAnaly write SetSaleAnaly;
  end;


implementation
uses uShopGlobal,uGlobal,ufrmLogo,uFnUtil;
{$R *.dfm}

procedure TfrmSaleAnalyMessage.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  NearMonth:='';  //最近浏览一月
  CurMonth:='';   //当前显示一月

  Page1ed := false;
  Page2ed := false;
  SaleAnaly := TSaleAnalyMsg.Create;
  for i := 0 to RzPage.PageCount - 1 do
    begin
      RzPage.Pages[i].TabVisible := False;
    end;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmSaleAnalyMessage.btn_EndClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmSaleAnalyMessage.ShowSaleAnalyMsg(AOwner: TForm; DoAction: TAction): boolean;
begin
      with TfrmSaleAnalyMessage.Create(AOwner) do
      begin
        try
          FDoAction:=DoAction;
          SetComponentPostion; //控制2个提示内容标题显示位置
          RzPage.ActivePageIndex := 0;
          OpenPage1;
          result := (ShowModal=MROK);
        finally
          free;
        end;
      end;
end;

procedure TfrmSaleAnalyMessage.Image2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSaleAnalyMessage.BtnSortClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSaleAnalyMessage.Lbl_LinkSaleAnlyClick(Sender: TObject);
begin
  inherited;
  if FDoAction.Enabled then
  begin
    self.Close;
    FDoAction.Execute;
  end;
end;

procedure TfrmSaleAnalyMessage.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  case rzPage.ActivePageIndex of
  0:OpenPage1;
  1:OpenPage2;
  end;
end;

procedure TfrmSaleAnalyMessage.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 1;
  case rzPage.ActivePageIndex of
  0:OpenPage1;
  1:OpenPage2;
  end;
end;

procedure TfrmSaleAnalyMessage.ShowMonthSaleInfo;
var
  BegIdx,RowNum: integer;
  vMonth,LTitle,Msg1,Msg2,Msg3,Msg4,Msg5,Msg6,Msg7,Msg8,Msg9: string;
begin
  Msg1:='';
  Msg2:='';
  Msg3:='';
  Msg4:='';
  Msg5:='';
  Msg6:='';
  RowNum:=0;
  //显示月经营情况
  vMonth:=FSaleAnaly.CurMonth;
  vMonth:=InttoStr(StrtoInt(Copy(vMonth,5,2)));
  //1、本月进货情况
  Msg1:='烟草公司本月供应的畅销品种'+InttoStr(FSaleAnaly.MonthMsg.TMGods_SX_Count)+'个，'+
        '您目前经营品种'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'个；'+
        '本月烟草公司供应新品'+InttoStr(FSaleAnaly.MonthMsg.TMNEWGODS_COUNT)+'个，'+
        '您目前经营'+InttoStr(FSaleAnaly.MonthMsg.TMNEWSTOR_COUNT)+'个；'+
        '您本月购进卷烟'+FloattoStr(FSaleAnaly.MonthMsg.TMStock_AMT)+'条，'+
        '单条值'+FloattoStr(FSaleAnaly.MonthMsg.TMStock_SINGLE_MNY)+'元。';

  //2、本月销售情况
  Msg2:='您本月销售卷烟'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_AMT)+'条，'+
        '单条值'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY)+'元，'+
        '实现毛利'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF)+'元，毛利率'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF_RATE)+'%。';

  Msg3:='您本月与上月比：销量增长'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE)+'%，'+
        '单条值增长'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY_UP_RATE)+'%，'+
        '毛利增长'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%。';

  Msg4:='您本月销量最大的三个规格分别是：'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_AMT+'；';
  Msg5:='本月毛利额最大的三个规格分别是：'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_PRF+'；';
  Msg6:='与上月销量比，增长最快的规格是：'+FSaleAnaly.MonthMsg.TMGods_MaxGrowRate_AMT+'。';

  //3、当前库存情况
  Msg7:='您当前经营卷烟'+InttoStr(FSaleAnaly.MonthMsg.TMGods_All_Count)+'个，'+
        '库存品种'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'个，'+
        FloattoStr(FSaleAnaly.MonthMsg.TMAllStor_AMT)+'条，'+
        '有'+InttoStr(FSaleAnaly.MonthMsg.TMLowStor_Count)+'个规格低于合理库存，应及时补充货源。';

  //4、您的客户情况
   Msg8:='您目前已建立消费者档案'+InttoStr(FSaleAnaly.MonthMsg.TMCust_Count)+'个，'+
         '高档烟的消费者'+InttoStr(FSaleAnaly.MonthMsg.TMCust_HG_Count)+'名，'+
         '本月新建'+InttoStr(FSaleAnaly.MonthMsg.TMCust_NEW_Count)+'个。';
   Msg9:='这些消费者销售数量'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_AMT)+'条，'+
         '占卷烟总销量的'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_AMT_RATE)+'%，'+
         '消费金额'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_MNY)+'元，'+
         '占卷烟总销售额的'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_MNY_RATE)+'%；'+
         '您的客户常在早上11-12点和下午6-8点买烟，该时段可以加强宣传。';

  //开始写入PRF
  Lbl_Month_Title.Caption:=vMonth+'月份月度经营分析';
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;

  MonthRTF.Clear;
  LTitle:='1、本月进货情况';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg1);
  MonthRTF.Lines.Add('');
 
  LTitle:='2、本月销售情况';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg2);
  MonthRTF.Lines.Add(SpaceStr+Msg3);
  MonthRTF.Lines.Add(SpaceStr+Msg4);
  MonthRTF.Lines.Add(SpaceStr+Msg5);
  MonthRTF.Lines.Add(SpaceStr+Msg6);
  MonthRTF.Lines.Add('');   

  LTitle:='3、当前库存情况';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg7);
  MonthRTF.Lines.Add('');   

  LTitle:='4、您的客户情况';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg8);
  MonthRTF.Lines.Add(SpaceStr+Msg9);
end;
      
procedure TfrmSaleAnalyMessage.ImgCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSaleAnalyMessage.ImgIKnowClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSaleAnalyMessage.SetRTFFont(SetRTF: TRzRichEdit; BegIdx,SetLen: integer);
begin
  SetRTF.SelStart:=BegIdx;
  SetRTF.SelLength:=SetLen;
  SetRTF.SelAttributes.Color:=clNavy;
  SetRTF.SelAttributes.Size:=10;
  SetRTF.SelAttributes.Style:=[fsBold];
end;

procedure TfrmSaleAnalyMessage.SetComponentPostion;
begin
  //设置LblTitle控制位置
  ImgDay.Left:=(RzPanel5.Width-ImgDay.Width) div 2;
  Lbl_Day_Title.Left:=(RzPanel5.Width-Lbl_Day_Title.Width) div 2;
  Lbl_Day_Title.Top:=ImgDay.Top+8;

  ImgMonth.Left:=(PnlTitleMonth.Width-ImgMonth.Width) div 2;
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;

  Img_left.Left:=ImgMonth.Left- Img_left.Width-7;
  Img_left.Top:=ImgMonth.Top+6;
  Img_right.Left:=ImgMonth.Left+ImgMonth.width+8;
  Img_right.Top:=ImgMonth.Top+6; 
end;

procedure TfrmSaleAnalyMessage.ShowDaysSaleInfo;
 function GetStr(InValue: real): string;
 begin
   if InValue>0 then result:='增长' else result:='下降';
 end;
var
  BegIdx,RowNum: integer;
  LTitle: string;
  Msg: string;
  NotYSFlag,NotTDFlag: Boolean; //昨天和今天是否销售
begin
  ShowMonthTitle;

  Msg:='';  DayRTF.Lines.Clear;
  DayRTF.Lines.Add(' '); 
  NotYSFlag:=(FSaleAnaly.DayMsg.YDSale_AMT=0) and (FSaleAnaly.DayMsg.YDSale_MNY=0) and (FSaleAnaly.DayMsg.YDSale_PRF=0);
  NotTDFlag:=(FSaleAnaly.DayMsg.TDSale_AMT=0) and (FSaleAnaly.DayMsg.TDSale_MNY=0) and (FSaleAnaly.DayMsg.TDSale_PRF=0);

  //1、销售概述
  DayRTF.Clear;
  LTitle:='1、销售概述';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);

  //显示日经营情况
  if (NotYSFlag) and (NotTDFlag) then //昨天、今天没有经营
  begin
    DayRTF.Lines.Add(SpaceStr+'您昨天和今天都无销售，祝您生意兴隆，加油！');
  end else
  if (NotYSFlag) and (not NotTDFlag) then //昨天没有经营,今天经营
  begin
    Msg:=SpaceStr+'昨天您未销售卷烟，'+
                  '今天您的销售卷烟品种'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'个，'+
                  InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'条，'+
                  '金额'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_MNY)+'元，'+
                  '毛利'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF)+'元，'+
                  '毛利率'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%，继续加油！';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end else
  if (Not NotYSFlag) and (NotTDFlag) then //昨天经营,今天还没经营
  begin   
    Msg:='昨天您销售卷烟品种'+InttoStr(FSaleAnaly.DayMsg.YDSaleGods_Count)+'个，'+
         InttoStr(FSaleAnaly.DayMsg.YDSaleBill_Count)+'笔，'+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'条，'+
         '金额'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'元，'+
         '毛利'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'元，'+
         '毛利率'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%，'+
         '与前天比，销量'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+'条，'+
         '金额'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+'元，'+
         '毛利'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+'元。'+
         '您今天还没有销售，祝您生意兴隆，加油！';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end else
  if (not NotYSFlag) and (not NotTDFlag) then //昨天经营,今天还没经营
  begin
    Msg:='昨天您销售卷烟品种'+InttoStr(FSaleAnaly.DayMsg.YDSaleGods_Count)+'个，'+
         InttoStr(FSaleAnaly.DayMsg.YDSaleBill_Count)+'笔，'+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'条，'+
         '金额'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'元，'+
         '毛利'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'元，'+
         '毛利率'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%'+
         '与前天比，销量'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+'条，'+
         '金额'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+'元，'+
         '毛利'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+'元。';
    DayRTF.Lines.Add(SpaceStr+Msg);
    DayRTF.Lines.Add(' ');
    if FSaleAnaly.DayMsg.TDSale_PRF<FSaleAnaly.DayMsg.YDSale_PRF then //小于昨天
    begin
      Msg:='今天您的销售卷烟品种'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'个，'+
           InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'条，'+
           '金额'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_MNY)+'元，'+
           '毛利'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF)+'元，'+
           '毛利率'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%，'+
           '您今天的销售离昨天的还有一定差距,再加把油！';
      DayRTF.Lines.Add(SpaceStr+Msg);
    end else
    begin
      Msg:='恭喜您，今天销售卷烟品种'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'个，'+
           InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'笔，'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'条，'+
           '金额'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_MNY)+'元，'+
           '毛利'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF)+'元，'+
           '毛利率'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%，真棒！';
      DayRTF.Lines.Add(SpaceStr+Msg);
    end;
  end;
  DayRTF.Lines.Add('');

  //2、进货情况：
  LTitle:='2、进货情况';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);
  Msg:=
    '您本次卷烟进货品种'+InttoStr(FSaleAnaly.DayMsg.TDStock_GODS_Count)+'个，'+
    ''+FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_AMT)+'条，'+
    '金额'+FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_MNY)+'元，'+
    '单条值'+    FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_Single_MNY)+'元。'+
    '与上次比，'+
    '进货量'+GetStr(FSaleAnaly.DayMsg.TDStock_AMT_RATE)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_AMT_RATE)+'%，'+
    '金额'+GetStr(FSaleAnaly.DayMsg.TDStock_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_MNY_Grow)+'元，'+
    '单条值'+GetStr(FSaleAnaly.DayMsg.TDStock_Single_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_Single_MNY_Grow)+'元。';
  DayRTF.Lines.Add(SpaceStr+Msg);
  DayRTF.Lines.Add(' ');

  //3、库存情况；
  LTitle:='3、库存情况';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);             

  Msg:='您当前经营卷烟'+InttoStr(FSaleAnaly.MonthMsg.TMGods_All_Count)+'个，'+
       '库存品种'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'个，'+       ''+FloattoStr(FSaleAnaly.MonthMsg.TMAllStor_AMT)+'条';  if FSaleAnaly.MonthMsg.TMLowStor_Count>0 then    Msg:=Msg+'，有'+InttoStr(FSaleAnaly.MonthMsg.TMLowStor_Count)+'个规格低于合理库存，应及时补充货源。'  else    Msg:=Msg+'。';        DayRTF.Lines.Add(SpaceStr+Msg);  
end;

procedure TfrmSaleAnalyMessage.OpenPage1;
begin
  if Page1ed then Exit;
  frmLogo.Show;
  try
    SaleAnaly.GetSaleDayMsg;
    ShowDaysSaleInfo;  //显示天天经营提醒
    Page1ed := true;
  finally
    frmLogo.Close;
  end;
end;

procedure TfrmSaleAnalyMessage.ShowMonthTitle;
var
  vMonth: string;
begin
  vMonth:=InttoStr(StrtoInt(Copy(SaleAnaly.CurMonth,5,2)));
  Lbl_Month_Title.Caption:=trim(vMonth)+'月份月度经营分析';
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;
end;


procedure TfrmSaleAnalyMessage.OpenPage2(vMonth: string);
begin
  if (CurMonth<>'') and (trim(CurMonth)=trim(NearMonth)) then Exit;
  //外面传入设置月份
  if vMonth<>'' then
  begin
    FSaleAnaly.CurMonth:=vMonth;
    ShowMonthTitle;
  end else
  begin
    CurMonth:=FSaleAnaly.CurMonth;
    NearMonth:=FSaleAnaly.CurMonth;
  end;
  
  frmLogo.Show;
  frmLogo.Update;
  frmLogo.ShowTitle:= '正在计算月度经营情况...';
  try
    SaleAnaly.GetSaleMonthMsg;    ShowMonthSaleInfo;  finally
    frmLogo.Close;
  end;
end;

procedure TfrmSaleAnalyMessage.SetSaleAnaly(const Value: TSaleAnalyMsg);
begin
  FSaleAnaly := Value;
end;

procedure TfrmSaleAnalyMessage.FormDestroy(Sender: TObject);
begin
  SaleAnaly.Free;
  inherited;    
end;

procedure TfrmSaleAnalyMessage.SetMonth(var CurMonth: string; SetValue: integer);
var
  CurDate: TDate;
begin
  CurDate:=FnTime.fnStrtoDate(CurMonth+'01'); //将月份转成时间
  CurDate:=IncMonth(CurDate,SetValue);  //月份加减
  CurMonth:=FormatDatetime('YYYYMM',CurDate);
end;

procedure TfrmSaleAnalyMessage.Img_leftClick(Sender: TObject);
begin
  inherited;
  SetMonth(CurMonth,-1);
  if (CurMonth<>'') and (NearMonth<>CurMonth) then
  begin
    OpenPage2(CurMonth); //显示月度经营情况
    NearMonth:=CurMonth;
  end;
end;

procedure TfrmSaleAnalyMessage.Img_rightClick(Sender: TObject);
begin
  SetMonth(CurMonth,1);
  if (CurMonth<>'') and (NearMonth<>CurMonth) then
  begin
    OpenPage2(CurMonth); //显示月度经营情况
    NearMonth:=CurMonth;
  end;
end;

function TfrmSaleAnalyMessage.HintMonthMsg(SetMonth: integer): string;
var
  vMonth: string;
  CurDate: TDate;
begin
  CurDate:=FnTime.fnStrtoDate(CurMonth+'01'); //将月份转成时间
  CurDate:=IncMonth(CurDate,SetMonth);  //月份加减
  vMonth:=FormatDatetime('YYYYMM',CurDate);
  vMonth:=Inttostr(StrtoInt(Copy(vMonth,5,2)));
  result:=vMonth+'月份';    
end;

procedure TfrmSaleAnalyMessage.Img_rightMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Img_right.Hint:=HintMonthMsg(1); 
end;

procedure TfrmSaleAnalyMessage.Img_leftMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Img_Left.Hint:=HintMonthMsg(-1); 
end;

procedure TfrmSaleAnalyMessage.Img_rightMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Img_right.Hint:=HintMonthMsg(1); 
end;

procedure TfrmSaleAnalyMessage.Img_leftMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Img_left.Hint:=HintMonthMsg(-1); 
end;

end.


