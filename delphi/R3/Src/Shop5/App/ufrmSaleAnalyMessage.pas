unit ufrmSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ufrmBasic, ExtCtrls, ActnList, Menus, RzPanel, RzForms, RzBckgnd,
  StdCtrls, jpeg, RzBmpBtn, RzTabs, cxTextEdit, cxDropDownEdit, cxControls,
  EncDec,cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxMemo, cxCheckBox, 
  IniFiles, zBase, ComCtrls, RzTreeVw, uGodsFactory, uTreeUtil, zDataSet,DB,
  cxCalendar,ZAbstractRODataset, ZAbstractDataset, RzLabel, RzButton,
  uSaleAnalyMessage, RzEdit;

const
  SpaceStr='    ';  

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
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
    procedure Lbl_LinkSaleAnlyClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgIKnowClick(Sender: TObject);
  private
    FDoAction: TAction;
    FSaleAnaly: TSaleAnalyMsg;
    procedure SetComponentPostion; //控制2个提示内容标题显示位置
    procedure SetRTFFont(SetRTF: TRzRichEdit; BegIdx,SetLen: integer);
    function GetRTFLength(SetRTF: TRzRichEdit; LinesIdx: integer): integer;
    procedure ShowDaysSaleInfo; //显示天天经营提醒
    procedure ShowMonthSaleInfo;   //显示月度经营情况
  public
    //DoAction:传入调用显示：销售分析表，现在要调用 
    class function ShowSaleAnalyMsg(AOwner:TForm; DoAction: TAction=nil):boolean;
  end;


implementation
uses uShopGlobal,uGlobal;
{$R *.dfm}

procedure TfrmSaleAnalyMessage.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
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
var
  SaleAnaly: TSaleAnalyMsg;
begin
  try
    SaleAnaly:=TSaleAnalyMsg.Create;
    SaleAnaly.GetSaleDayMsg;
    SaleAnaly.GetSaleMonthMsg;
    if 1=1 then //(SaleAnaly.DayMsg.YDSale_AMT>0) or (SaleAnaly.MonthMsg.LMSale_AMT>0) //现在都显示，暂不控制
    begin
      with TfrmSaleAnalyMessage.Create(AOwner) do
      begin
        try
          FDoAction:=DoAction;
          FSaleAnaly:=SaleAnaly;
          ShowDaysSaleInfo;  //显示天天经营提醒
          ShowMonthSaleInfo; //显示月度经营情况
          SetComponentPostion; //控制2个提示内容标题显示位置
          result := (ShowModal=MROK);
        finally
          free;
        end;
      end;
    end;
  finally
    SaleAnaly.Free;
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
  if RzPage.ActivePage<>Tab1 then
    RzPage.ActivePage:=Tab1;
end;

procedure TfrmSaleAnalyMessage.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  if RzPage.ActivePage<>Tab2 then
    RzPage.ActivePage:=Tab2;
end;

procedure TfrmSaleAnalyMessage.ShowMonthSaleInfo;
 function GetGrowRate(GrowValue: real): string;
 begin
   if GrowValue>=0 then
     result:='增长'+FormatFloat('#0.00',GrowValue)
   else
     result:='下降'+FormatFloat('#0.00',GrowValue); 
 end;
var
  BegIdx,RowNum: integer;
  vMonth,LTitle,Msg1,Msg2,Msg3,Msg4: string;
begin
  Msg1:='';
  Msg2:='';
  Msg3:='';
  Msg4:='';
  RowNum:=0;
  //显示月经营情况
  vMonth:=FSaleAnaly.MonthMsg.Month;
  vMonth:=InttoStr(StrtoInt(Copy(vMonth,5,2)));
  //1、经营概况:
  Msg1:='1、您'+vMonth+'月经营品种'+InttoStr(FSaleAnaly.MonthMsg.TMGods_AMT)+'个,'+
       '销售数量'+FormatFloat('#0.###',FSaleAnaly.MonthMsg.TMSale_AMT)+'条,'+
       '销售金额'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_MNY)+'元,'+
       '单条值'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY)+'元,'+
       '毛利'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_PRF)+'元,'+
       '毛利率'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_PRF_RATE)+'%,'+
       '存销比为'+FormatFloat('#0.00#',FSaleAnaly.MonthMsg.TMSH_RATIO)+','+
       '拥有固定消费者'+InttoStr(FSaleAnaly.MonthMsg.TMCust_AMT)+'个,'+
       '这些消费者消费金额'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMCust_MNY)+'元,'+
       '占所有卷烟消费的'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMCust_RATE)+'%。';

  //2、环比结果:
  Msg2:='2、您当月与上月比：销量'+GetGrowRate(FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE)+'%,'+
                         '单条值'+GetGrowRate(FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY_UP_RATE)+'%,'+
                         '毛利环比'+GetGrowRate(FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%。';

  //3、存在问题
  Msg3:='3、您当月与同期比：销量'+GetGrowRate(FSaleAnaly.MonthMsg.LYTMSale_AMT_UP_RATE)+'%,'+
                         '单条值'+GetGrowRate(FSaleAnaly.MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE)+'%,'+
                         '毛利环比'+GetGrowRate(FSaleAnaly.MonthMsg.LYTMSale_PRF_UP_RATE)+'%。';

  //4、对比结果显示：
  Msg4:='4、您当月销量最大的三个规格分别是:'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_AMT+','+
           '当月毛利额最大的三个规格分别是:'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_PRF+','+
     '环比上月销量增长最快的三个规格分别是:'+FSaleAnaly.MonthMsg.TMGods_MaxGrowRate_AMT+','+
           '本月动销不理想的三个规格分别是:'+FSaleAnaly.MonthMsg.TMGods_MinGrowRate_AMT+'';
  if FSaleAnaly.MonthMsg.TMSH_RATIO < 0.6 then Msg4:=Msg4+'存销比扁低。'
  else if FSaleAnaly.MonthMsg.TMSH_RATIO>1.5 then Msg4:=Msg4+'存销比扁大。';
  if trim(Msg4)='' then Msg4:='无';

  //开始写入PRF
  Lbl_Month_Title.Caption:=vMonth+'月份月度经营分析';
  LTitle:='一、经营概况';
  //MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg1);
  //MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(SpaceStr+Msg2);
  //MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(SpaceStr+Msg3);
  //MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(SpaceStr+Msg4);

  LTitle:='二、提升建议';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);

  {条件1（一）、销量同比、环比下降。
   建议: 1、了解销量下降的原因，及时与客户经理联系。（如周边是否有假、非、私烟销售，熟悉的消费者是否减少了购买次数或停止了购买，销售的品种是否有断档缺货现象等）
         2、了解消费需求，提升服务质量，加强有效货源购进，刺激消费增长。}
  if (FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE<0) and (FSaleAnaly.MonthMsg.LYTMSale_AMT_UP_RATE<0) then
  begin
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、了解销量下降的原因，及时与客户经理联系。（如周边是否有假、非、私烟销售，熟悉的消费者是否减少了购买次数或停止了购买，销售的品种是否有断档缺货现象等）');
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、了解消费需求，提升服务质量，加强有效货源购进，刺激消费增长。');
  end;

  {条件2（二）、单条值(毛利、毛利率)同比或环比下降。
     建议: 1、提高推荐名优骨干品牌的意识，加深对品牌知识特点、卖点、亮点的掌握，积极向消费者推荐。
           2、询问客户经理或者通过终端信息平台了解近期的促销活动，积极参与，提高销售结构。
           3、加强信息平台的使用，常进入"我的社区"了解社区其他互助小组成员反馈的情况，或者发贴征求组员的意见和建议，改进经营状况。
           4、如果您有条件，可联合烟草公司组织开展消费体验活动 }
  if ((FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY_UP_RATE<0) and //环比单条值
      (FSaleAnaly.MonthMsg.TMSale_PRF<FSaleAnaly.MonthMsg.LMSale_PRF) and //环比毛利下降
      (FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE<0)) or   //环比毛利率
     ((FSaleAnaly.MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE<0) or
      (FSaleAnaly.MonthMsg.LYTMSale_PRF<FSaleAnaly.MonthMsg.LMSale_PRF) or //环比毛利下降
      (FSaleAnaly.MonthMsg.LYTMSale_PRF_UP_RATE<0)) then  //环比毛利率
  begin
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、提高推荐名优骨干品牌的意识，加深对品牌知识特点、卖点、亮点的掌握，积极向消费者推荐。');
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、询问客户经理或者通过终端信息平台了解近期的促销活动，积极参与，提高销售结构。');
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、加强信息平台的使用，常进入"我的社区"了解社区其他互助小组成员反馈的情况，或者发贴征求组员的意见和建议，改进经营状况。');
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、如果您有条件，可联合烟草公司组织开展消费体验活动。');
  end;

  {条件3（三）、存销比偏小。 建议: 1、加大购进量，备足货源，优化库存，满足消费需求。}
  if FSaleAnaly.MonthMsg.TMSH_RATIO<0.60 then
  begin
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、加大购进量，备足货源，优化库存，满足消费需求。');
  end;

  {条件4（四）、存销比偏大。 建议: 1、积极主动加强宣传推荐，提高卷烟动销。2、如果有滞销品种，可联系烟草公司开展相应的促销活动，加快销售。}
  if FSaleAnaly.MonthMsg.TMSH_RATIO>1.5 then
  begin
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、积极主动加强宣传推荐，提高卷烟动销。2、如果有滞销品种，可联系烟草公司开展相应的促销活动，加快销售。');
  end;

  {条件5 (五）、销量、结构同比、环比增长、库存合理
      1、您做得很好，您是本月的销售能手。
      2、希望您能将销售经验和成功做法发到信息平台供大家参考。}
  if ((FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE>0) and (FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE>0) and (FSaleAnaly.MonthMsg.LYTMSale_AMT_UP_RATE>0) and (FSaleAnaly.MonthMsg.LYTMSale_PRF_UP_RATE>0)) and
     ((FSaleAnaly.MonthMsg.TMSH_RATIO>=0.60) and (FSaleAnaly.MonthMsg.TMSH_RATIO<=1.50)) then
  begin
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、您做得很好，您是本月的销售能手。');
    Inc(RowNum);
    MonthRTF.Lines.Add(SpaceStr+InttoStr(RowNum)+'、希望您能将销售经验和成功做法发到信息平台供大家参考。');
  end;
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

function TfrmSaleAnalyMessage.GetRTFLength(SetRTF: TRzRichEdit; LinesIdx: integer): integer;
var
  i,vLen: integer;
begin
  result:=0;
  vLen:=0;
  for i:=0 to LinesIdx-1 do
  begin
    vLen:=vLen+length(SetRTF.Lines.Strings[i]);
  end;
  result:=vLen;
end;


 {LTitle:='二、经营优势';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg2);

  LTitle:='三、存在问题';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg3);}

  {
  if FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE<0 then //销量下降
  begin
    MonthRTF.Lines.Add(SpaceStr+'针对您存在的问题,建议如下:');
    MonthRTF.Lines.Add(SpaceStr+'  1.分析销量下降原因');
    MonthRTF.Lines.Add(SpaceStr+'  2.适度引导消费');
    MonthRTF.Lines.Add(SpaceStr+'  3.关注库存情况');
    MonthRTF.Lines.Add(SpaceStr+'  4.最后祝您生意兴隆,欢迎您经常跟客户经理联系。');
  end else
  begin
    MonthRTF.Lines.Add(SpaceStr+'针对您存在的问题,建议如下:');
    MonthRTF.Lines.Add(SpaceStr+'  1.适度引导消费');
    MonthRTF.Lines.Add(SpaceStr+'  2.关注库存情况');
    MonthRTF.Lines.Add(SpaceStr+'  3.最后祝您生意兴隆,欢迎您经常跟客户经理联系。');
  end;}

procedure TfrmSaleAnalyMessage.SetComponentPostion;
begin
  //设置LblTitle控制位置
  ImgDay.Left:=(RzPanel5.Width-ImgDay.Width) div 2;
  Lbl_Day_Title.Left:=(RzPanel5.Width-Lbl_Day_Title.Width) div 2;
  Lbl_Day_Title.Top:=ImgDay.Top+8;

  ImgMonth.Left:=(PnlTitleMonth.Width-ImgMonth.Width) div 2;
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;
end;

procedure TfrmSaleAnalyMessage.ShowDaysSaleInfo;
var
  Msg: string;
  NotSaleFlag: Boolean;
begin
  Msg:='';
  DayRTF.Lines.Clear;
  DayRTF.Lines.Add(' '); 
  NotSaleFlag:=False;
  //显示日经营情况
  if (FSaleAnaly.DayMsg.YDSale_AMT=0) and (FSaleAnaly.DayMsg.YDSale_MNY=0) then
  begin
    DayRTF.Lines.Add(SpaceStr+'您昨天没有销售卷烟。');
    NotSaleFlag:=true;
  end else
  begin
    Msg:='您昨天销售卷烟 '+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'条,'+
         '金额 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'元,'+
         '毛利 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'元,'+
         '毛利率 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%。';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end;

  DayRTF.Lines.Add('');
  if (FSaleAnaly.DayMsg.TDSale_AMT=0) and (FSaleAnaly.DayMsg.TDSale_MNY=0) then
  begin
    //Lbl_Today_Info.Caption:='今天您还没有销售卷烟。';
    DayRTF.Lines.Add('    今天您还没有销售卷烟。');
  end else
  begin
    Msg:='卷烟 '+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'条,'+
         '金额 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_MNY)+'元,'+
         '毛利 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF)+'元,'+
         '毛利率 '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%';
    if NotSaleFlag then
    begin
      Msg:='今天您销售'+Msg+'。';
    end else
    begin
      if FSaleAnaly.DayMsg.YDSale_PRF=FSaleAnaly.DayMsg.TDSale_PRF then //毛利相等
        Msg:='今天您销售'+Msg+','+#13+SpaceStr+'与昨天持平,加油！'
      else if FSaleAnaly.DayMsg.YDSale_PRF>FSaleAnaly.DayMsg.TDSale_PRF then //毛利小于昨天
        Msg:='今天您销售'+Msg+','+#13+SpaceStr+'今天的销售离昨天还有一定距离,加油！'
      else
        Msg:='恭喜您,今天售已经超过昨天,'+#13+SpaceStr+'销售'+Msg+'！';
    end;
    //Lbl_Today_Info.Caption:=Msg;
    DayRTF.Lines.Add(SpaceStr+Msg);
  end;
end;

end.
