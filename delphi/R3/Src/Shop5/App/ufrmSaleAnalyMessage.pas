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
    NearMonth: string;  //������һ��
    CurMonth: string;   //��ǰ��ʾһ��
    FDoAction: TAction;
    FSaleAnaly: TSaleAnalyMsg;
    Page1ed,Page2ed:boolean;
    function  HintMonthMsg(SetMonth: integer): string;
    procedure SetMonth(var CurMonth: string; SetValue: integer);
    procedure SetComponentPostion; //����2����ʾ���ݱ�����ʾλ��
    procedure SetRTFFont(SetRTF: TRzRichEdit; BegIdx,SetLen: integer);
    procedure ShowDaysSaleInfo; //��ʾ���쾭Ӫ����
    procedure ShowMonthSaleInfo;   //��ʾ�¶Ⱦ�Ӫ���
    procedure OpenPage1;
    procedure OpenPage2(vMonth: string='');
    procedure SetSaleAnaly(const Value: TSaleAnalyMsg);
    procedure ShowMonthTitle;
  public
    //DoAction:���������ʾ�����۷���������Ҫ����
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
  NearMonth:='';  //������һ��
  CurMonth:='';   //��ǰ��ʾһ��

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
          SetComponentPostion; //����2����ʾ���ݱ�����ʾλ��
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
  //��ʾ�¾�Ӫ���
  vMonth:=FSaleAnaly.CurMonth;
  vMonth:=InttoStr(StrtoInt(Copy(vMonth,5,2)));
  //1�����½������
  Msg1:='�̲ݹ�˾���¹�Ӧ�ĳ���Ʒ��'+InttoStr(FSaleAnaly.MonthMsg.TMGods_SX_Count)+'����'+
        '��Ŀǰ��ӪƷ��'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'����'+
        '�����̲ݹ�˾��Ӧ��Ʒ'+InttoStr(FSaleAnaly.MonthMsg.TMNEWGODS_COUNT)+'����'+
        '��Ŀǰ��Ӫ'+InttoStr(FSaleAnaly.MonthMsg.TMNEWSTOR_COUNT)+'����'+
        '�����¹�������'+FloattoStr(FSaleAnaly.MonthMsg.TMStock_AMT)+'����'+
        '����ֵ'+FloattoStr(FSaleAnaly.MonthMsg.TMStock_SINGLE_MNY)+'Ԫ��';

  //2�������������
  Msg2:='���������۾���'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_AMT)+'����'+
        '����ֵ'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY)+'Ԫ��'+
        'ʵ��ë��'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF)+'Ԫ��ë����'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF_RATE)+'%��';

  Msg3:='�����������±ȣ���������'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_AMT_UP_RATE)+'%��'+
        '����ֵ����'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_SINGLE_MNY_UP_RATE)+'%��'+
        'ë������'+FloattoStr(FSaleAnaly.MonthMsg.TMSale_PRF_UP_RATE)+'%��';

  Msg4:='���������������������ֱ��ǣ�'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_AMT+'��';
  Msg5:='����ë���������������ֱ��ǣ�'+FSaleAnaly.MonthMsg.TMGods_MaxGrow_PRF+'��';
  Msg6:='�����������ȣ��������Ĺ���ǣ�'+FSaleAnaly.MonthMsg.TMGods_MaxGrowRate_AMT+'��';

  //3����ǰ������
  Msg7:='����ǰ��Ӫ����'+InttoStr(FSaleAnaly.MonthMsg.TMGods_All_Count)+'����'+
        '���Ʒ��'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'����'+
        FloattoStr(FSaleAnaly.MonthMsg.TMAllStor_AMT)+'����'+
        '��'+InttoStr(FSaleAnaly.MonthMsg.TMLowStor_Count)+'�������ں����棬Ӧ��ʱ�����Դ��';

  //4�����Ŀͻ����
   Msg8:='��Ŀǰ�ѽ��������ߵ���'+InttoStr(FSaleAnaly.MonthMsg.TMCust_Count)+'����'+
         '�ߵ��̵�������'+InttoStr(FSaleAnaly.MonthMsg.TMCust_HG_Count)+'����'+
         '�����½�'+InttoStr(FSaleAnaly.MonthMsg.TMCust_NEW_Count)+'����';
   Msg9:='��Щ��������������'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_AMT)+'����'+
         'ռ������������'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_AMT_RATE)+'%��'+
         '���ѽ��'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_MNY)+'Ԫ��'+
         'ռ���������۶��'+FloattoStr(FSaleAnaly.MonthMsg.TMCust_MNY_RATE)+'%��'+
         '���Ŀͻ���������11-12�������6-8�����̣���ʱ�ο��Լ�ǿ������';

  //��ʼд��PRF
  Lbl_Month_Title.Caption:=vMonth+'�·��¶Ⱦ�Ӫ����';
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;

  MonthRTF.Clear;
  LTitle:='1�����½������';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg1);
  MonthRTF.Lines.Add('');
 
  LTitle:='2�������������';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg2);
  MonthRTF.Lines.Add(SpaceStr+Msg3);
  MonthRTF.Lines.Add(SpaceStr+Msg4);
  MonthRTF.Lines.Add(SpaceStr+Msg5);
  MonthRTF.Lines.Add(SpaceStr+Msg6);
  MonthRTF.Lines.Add('');   

  LTitle:='3����ǰ������';
  MonthRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,MonthRTF.Text)-1;
  SetRTFFont(MonthRTF, BegIdx,Length(LTitle)+2);
  MonthRTF.Lines.Add(SpaceStr+Msg7);
  MonthRTF.Lines.Add('');   

  LTitle:='4�����Ŀͻ����';
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
  //����LblTitle����λ��
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
   if InValue>0 then result:='����' else result:='�½�';
 end;
var
  BegIdx,RowNum: integer;
  LTitle: string;
  Msg: string;
  NotYSFlag,NotTDFlag: Boolean; //����ͽ����Ƿ�����
begin
  ShowMonthTitle;

  Msg:='';  DayRTF.Lines.Clear;
  DayRTF.Lines.Add(' '); 
  NotYSFlag:=(FSaleAnaly.DayMsg.YDSale_AMT=0) and (FSaleAnaly.DayMsg.YDSale_MNY=0) and (FSaleAnaly.DayMsg.YDSale_PRF=0);
  NotTDFlag:=(FSaleAnaly.DayMsg.TDSale_AMT=0) and (FSaleAnaly.DayMsg.TDSale_MNY=0) and (FSaleAnaly.DayMsg.TDSale_PRF=0);

  //1�����۸���
  DayRTF.Clear;
  LTitle:='1�����۸���';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);

  //��ʾ�վ�Ӫ���
  if (NotYSFlag) and (NotTDFlag) then //���졢����û�о�Ӫ
  begin
    DayRTF.Lines.Add(SpaceStr+'������ͽ��춼�����ۣ�ף��������¡�����ͣ�');
  end else
  if (NotYSFlag) and (not NotTDFlag) then //����û�о�Ӫ,���쾭Ӫ
  begin
    Msg:=SpaceStr+'������δ���۾��̣�'+
                  '�����������۾���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'����'+
                  InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'����'+
                  '���'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_MNY)+'Ԫ��'+
                  'ë��'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF)+'Ԫ��'+
                  'ë����'+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%���������ͣ�';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end else
  if (Not NotYSFlag) and (NotTDFlag) then //���쾭Ӫ,���컹û��Ӫ
  begin   
    Msg:='���������۾���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.YDSaleGods_Count)+'����'+
         InttoStr(FSaleAnaly.DayMsg.YDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'����'+
         '���'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'Ԫ��'+
         'ë��'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'Ԫ��'+
         'ë����'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%��'+
         '��ǰ��ȣ�����'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+'����'+
         '���'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+'Ԫ��'+
         'ë��'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+'Ԫ��'+
         '�����컹û�����ۣ�ף��������¡�����ͣ�';
    DayRTF.Lines.Add(SpaceStr+Msg);
  end else
  if (not NotYSFlag) and (not NotTDFlag) then //���쾭Ӫ,���컹û��Ӫ
  begin
    Msg:='���������۾���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.YDSaleGods_Count)+'����'+
         InttoStr(FSaleAnaly.DayMsg.YDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',FSaleAnaly.DayMsg.YDSale_AMT)+'����'+
         '���'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_MNY)+'Ԫ��'+
         'ë��'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF)+'Ԫ��'+
         'ë����'+FormatFloat('#0.00',FSaleAnaly.DayMsg.YDSale_PRF_RATE)+'%'+
         '��ǰ��ȣ�����'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_AMT_Grow)+'����'+
         '���'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_MNY_Grow)+'Ԫ��'+
         'ë��'+GetStr(FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDSale_BY_PRF_Grow)+'Ԫ��';
    DayRTF.Lines.Add(SpaceStr+Msg);
    DayRTF.Lines.Add(' ');
    if FSaleAnaly.DayMsg.TDSale_PRF<FSaleAnaly.DayMsg.YDSale_PRF then //С������
    begin
      Msg:='�����������۾���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'����'+
           InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'����'+
           '���'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_MNY)+'Ԫ��'+
           'ë��'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF)+'Ԫ��'+
           'ë����'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%��'+
           '�����������������Ļ���һ�����,�ټӰ��ͣ�';
      DayRTF.Lines.Add(SpaceStr+Msg);
    end else
    begin
      Msg:='��ϲ�����������۾���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.TDSaleGods_Count)+'����'+
           InttoStr(FSaleAnaly.DayMsg.TDSaleBill_Count)+'�ʣ�'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_AMT)+'����'+
           '���'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_MNY)+'Ԫ��'+
           'ë��'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF)+'Ԫ��'+
           'ë����'+FormatFloat('#0.###',FSaleAnaly.DayMsg.TDSale_PRF_RATE)+'%�������';
      DayRTF.Lines.Add(SpaceStr+Msg);
    end;
  end;
  DayRTF.Lines.Add('');

  //2�����������
  LTitle:='2���������';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);
  Msg:=
    '�����ξ��̽���Ʒ��'+InttoStr(FSaleAnaly.DayMsg.TDStock_GODS_Count)+'����'+
    ''+FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_AMT)+'����'+
    '���'+FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_MNY)+'Ԫ��'+
    '����ֵ'+    FormatFloat('#0.##',FSaleAnaly.DayMsg.TDStock_Single_MNY)+'Ԫ��'+
    '���ϴαȣ�'+
    '������'+GetStr(FSaleAnaly.DayMsg.TDStock_AMT_RATE)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_AMT_RATE)+'%��'+
    '���'+GetStr(FSaleAnaly.DayMsg.TDStock_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_MNY_Grow)+'Ԫ��'+
    '����ֵ'+GetStr(FSaleAnaly.DayMsg.TDStock_Single_MNY_Grow)+FormatFloat('#0.00',FSaleAnaly.DayMsg.TDStock_Single_MNY_Grow)+'Ԫ��';
  DayRTF.Lines.Add(SpaceStr+Msg);
  DayRTF.Lines.Add(' ');

  //3����������
  LTitle:='3��������';
  DayRTF.Lines.Add(LTitle);
  BegIdx:=Pos(LTitle,DayRTF.Text)-1;
  SetRTFFont(DayRTF, BegIdx,Length(LTitle)+2);             

  Msg:='����ǰ��Ӫ����'+InttoStr(FSaleAnaly.MonthMsg.TMGods_All_Count)+'����'+
       '���Ʒ��'+InttoStr(FSaleAnaly.MonthMsg.TMGods_Count)+'����'+       ''+FloattoStr(FSaleAnaly.MonthMsg.TMAllStor_AMT)+'��';  if FSaleAnaly.MonthMsg.TMLowStor_Count>0 then    Msg:=Msg+'����'+InttoStr(FSaleAnaly.MonthMsg.TMLowStor_Count)+'�������ں����棬Ӧ��ʱ�����Դ��'  else    Msg:=Msg+'��';        DayRTF.Lines.Add(SpaceStr+Msg);  
end;

procedure TfrmSaleAnalyMessage.OpenPage1;
begin
  if Page1ed then Exit;
  frmLogo.Show;
  try
    SaleAnaly.GetSaleDayMsg;
    ShowDaysSaleInfo;  //��ʾ���쾭Ӫ����
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
  Lbl_Month_Title.Caption:=trim(vMonth)+'�·��¶Ⱦ�Ӫ����';
  Lbl_Month_Title.Left:=(PnlTitleMonth.Width-Lbl_Month_Title.Width) div 2;
  Lbl_Month_Title.Top:=ImgMonth.Top+8;
end;


procedure TfrmSaleAnalyMessage.OpenPage2(vMonth: string);
begin
  if (CurMonth<>'') and (trim(CurMonth)=trim(NearMonth)) then Exit;
  //���洫�������·�
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
  frmLogo.ShowTitle:= '���ڼ����¶Ⱦ�Ӫ���...';
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
  CurDate:=FnTime.fnStrtoDate(CurMonth+'01'); //���·�ת��ʱ��
  CurDate:=IncMonth(CurDate,SetValue);  //�·ݼӼ�
  CurMonth:=FormatDatetime('YYYYMM',CurDate);
end;

procedure TfrmSaleAnalyMessage.Img_leftClick(Sender: TObject);
begin
  inherited;
  SetMonth(CurMonth,-1);
  if (CurMonth<>'') and (NearMonth<>CurMonth) then
  begin
    OpenPage2(CurMonth); //��ʾ�¶Ⱦ�Ӫ���
    NearMonth:=CurMonth;
  end;
end;

procedure TfrmSaleAnalyMessage.Img_rightClick(Sender: TObject);
begin
  SetMonth(CurMonth,1);
  if (CurMonth<>'') and (NearMonth<>CurMonth) then
  begin
    OpenPage2(CurMonth); //��ʾ�¶Ⱦ�Ӫ���
    NearMonth:=CurMonth;
  end;
end;

function TfrmSaleAnalyMessage.HintMonthMsg(SetMonth: integer): string;
var
  vMonth: string;
  CurDate: TDate;
begin
  CurDate:=FnTime.fnStrtoDate(CurMonth+'01'); //���·�ת��ʱ��
  CurDate:=IncMonth(CurDate,SetMonth);  //�·ݼӼ�
  vMonth:=FormatDatetime('YYYYMM',CurDate);
  vMonth:=Inttostr(StrtoInt(Copy(vMonth,5,2)));
  result:=vMonth+'�·�';    
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


