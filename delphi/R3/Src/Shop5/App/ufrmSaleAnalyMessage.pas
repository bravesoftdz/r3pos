unit ufrmSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ufrmBasic, ExtCtrls, ActnList, Menus, RzPanel, RzForms, RzBckgnd,
  StdCtrls, jpeg, RzBmpBtn, RzTabs, cxTextEdit, cxDropDownEdit, cxControls, EncDec,
  cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxMemo, cxCheckBox,IniFiles, zBase,
  ComCtrls, RzTreeVw, uGodsFactory, uTreeUtil, zDataSet, cxCalendar, DB,
  ZAbstractRODataset, ZAbstractDataset, RzLabel, RzButton,uSaleAnalyMessage,
  RzEdit;

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
    procedure SetRTFFont(SetRTF: TRzRichEdit; BegIdx,SetLen: integer);
    function GetRTFLength(SetRTF: TRzRichEdit; LinesIdx: integer): integer;
    procedure ShowSaleInfo; //��ʾ��Ӫ���
  public
    //DoAction:���������ʾ�����۷���������Ҫ���� 
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
    if 1=1 then //(SaleAnaly.DayMsg.YDSale_AMT>0) or (SaleAnaly.MonthMsg.LMSale_AMT>0) //���ڶ���ʾ���ݲ�����
    begin
      with TfrmSaleAnalyMessage.Create(AOwner) do
      begin
        try
          FDoAction:=DoAction;
          FSaleAnaly:=SaleAnaly;
          ShowSaleInfo;
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

procedure TfrmSaleAnalyMessage.ShowSaleInfo;
var
  BegIdx: integer;
  NotSaleFlag: Boolean;
  Msg,vMonth,LTitle,Msg2,Msg3,Msg4: string;
begin
  Msg2:='';
  Msg3:='';
  Msg4:='';
  DayRTF.Lines.Clear;
  DayRTF.Lines.Add(' '); 
  NotSaleFlag:=False;
  //��ʾ�վ�Ӫ���
  if (FSaleAnaly.DayMsg.YDSale_AMT=0) and (FSaleAnaly.DayMsg.YDSale_MNY=0) then
  begin
    DayRTF.Lines.Add(SpaceStr+'������û�����۾��̡�');
    NotSaleFlag:=true;
  end else
  begin
    Msg:='���������۾��� '+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'��,'+
         '��� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'Ԫ,'+
         'ë�� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'Ԫ,'+
         'ë���� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%��';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end;

  DayRTF.Lines.Add('');
  if (FSaleAnaly.DayMsg.TDSale_AMT=0) and (FSaleAnaly.DayMsg.TDSale_MNY=0) then
  begin
    //Lbl_Today_Info.Caption:='��������û�����۾��̡�';
    DayRTF.Lines.Add('    ��������û�����۾��̡�');
  end else
  begin
    Msg:='���� '+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'��,'+
         '��� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_MNY)+'Ԫ,'+
         'ë�� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF)+'Ԫ,'+
         'ë���� '+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%';
    if NotSaleFlag then
    begin
      Msg:='����������'+Msg+'��';
    end else
    begin
      if FSaleAnaly.DayMsg.YDSale_PRF=FSaleAnaly.DayMsg.TDSale_PRF then //ë�����
        Msg:='����������'+Msg+','+#13+SpaceStr+'�������ƽ,���ͣ�'
      else if FSaleAnaly.DayMsg.YDSale_PRF>FSaleAnaly.DayMsg.TDSale_PRF then //ë��С������
        Msg:='����������'+Msg+','+#13+SpaceStr+'��������������컹��һ������,���ͣ�'
      else
        Msg:='��ϲ��,�������Ѿ���������,'+#13+SpaceStr+'����'+Msg+'��';
    end;
    //Lbl_Today_Info.Caption:=Msg;
    DayRTF.Lines.Add(SpaceStr+Msg);
  end;

  //��ʵ�¾�Ӫ���
  vMonth:=FSaleAnaly.MonthMsg.Month;
  vMonth:=InttoStr(StrtoInt(Copy(vMonth,5,2)));
  //��Ӫ�ſ�:
  Msg:='��'+vMonth+'�¾�ӪƷ��'+InttoStr(FSaleAnaly.MonthMsg.TMGods_AMT)+'��,'+
       '��������'+FormatFloat('#0.###',FSaleAnaly.MonthMsg.TMSale_AMT)+'��,'+
       '���۽��'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_MNY)+'Ԫ,'+
       'ë��'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_PRF)+'Ԫ,'+
       'ë����'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_PRF_RATE)+'%,'+
       '������Ϊ'+FormatFloat('#0.00#',FSaleAnaly.MonthMsg.TMSH_RATIO)+','+
       'ӵ�й̶�������'+InttoStr(FSaleAnaly.MonthMsg.TMCust_AMT)+'��,'+
       '��Щ���������ѽ��'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMCust_MNY)+'Ԫ,'+
       'ռ���о������ѵ�'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMCust_RATE)+'%��';
  //��Ӫ����:
  Msg2:=
    '��'+vMonth+'�»���������������'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE)+'%,'+
    'ë��������������'+FormatFloat('#0.00',FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%,'+
    'ë���������������ֱ���:'+FSaleAnaly.MonthMsg.TMGods_MaxPRF+',���������������������������'+
    '�ֱ���:'+FSaleAnaly.MonthMsg.TMGods_MaxAMT+'��';
    // ˵��:����������½��������ھ�Ӫ���Ƶ������֡�';

  //��������
  if FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE<0 then
    Msg3:='��'+vMonth+'�»������������½�'+FormatFloat('#0.00',-FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE)+'%';
  if FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE<0 then
  begin
    if Msg3<>'' then
      Msg3:=Msg3+',ë�����������½�'+FormatFloat('#0.00',-FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%,'
    else
      Msg3:='��'+vMonth+'�»�������ë�����������½�'+FormatFloat('#0.00',-FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%,'
  end;
  if Msg3<>'' then
    Msg3:=Msg3+'���¶�����������������Ϊ:'+FSaleAnaly.MonthMsg.TMGods_MinAMT;

  if Msg3<>'' then Msg3:=Msg3+',';
  if FSaleAnaly.MonthMsg.TMSH_RATIO < 0.6 then
    Msg3:=Msg3+'�����ȱ�͡�'
  else if FSaleAnaly.MonthMsg.TMSH_RATIO>1.5 then
    Msg3:=Msg3+'�����ȱ��';

  if Msg3='' then Msg3:='��';  

  //��ʼд��PRF
  Lbl_Month_Title.Caption:=vMonth+'�·��¶Ⱦ�Ӫ����';
  LTitle:='һ����Ӫ�ſ�';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg);


  LTitle:='������Ӫ����';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg2);

  LTitle:='������������';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg3);

  //�Ľ�����
  LTitle:='�ġ��Ľ�����';
  MonthRTF.Lines.Add('');
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  if FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE<0 then //�����½�
  begin
    MonthRTF.Lines.Add(SpaceStr+'��������ڵ�����,��������:');
    MonthRTF.Lines.Add(SpaceStr+'  1.���������½�ԭ��');
    MonthRTF.Lines.Add(SpaceStr+'  2.�ʶ���������');
    MonthRTF.Lines.Add(SpaceStr+'  3.��ע������');
    MonthRTF.Lines.Add(SpaceStr+'  4.���ף��������¡,��ӭ���������ͻ�������ϵ��');
  end else
  begin
    MonthRTF.Lines.Add(SpaceStr+'��������ڵ�����,��������:');
    MonthRTF.Lines.Add(SpaceStr+'  1.�ʶ���������');
    MonthRTF.Lines.Add(SpaceStr+'  2.��ע������');
    MonthRTF.Lines.Add(SpaceStr+'  3.���ף��������¡,��ӭ���������ͻ�������ϵ��');
  end;

  //����LblTitle����λ��
  ImgDay.Left:=(RzPanel5.Width-ImgDay.Width) div 2;
  Lbl_Day_Title.Left:=(RzPanel5.Width-Lbl_Day_Title.Width) div 2;
  Lbl_Day_Title.Top:=ImgDay.Top+8;

  ImgMonth.Left:=(PnlTitleMonth.Width-ImgMonth.Width) div 2;
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;
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

end.
