unit ufrmNewsPaperReader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ImgList, ExtCtrls, RzPanel, ActnList, Menus, RzBckgnd,
  RzBmpBtn, RzTabs, Grids, DBGridEh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, ComCtrls,ObjCommon;

type
  TfrmNewPaperReader = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzBackground1: TRzBackground;
    Image1: TImage;
    RzPanel7: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    btn_Message0: TRzBmpButton;
    btn_Message1: TRzBmpButton;
    btn_Message2: TRzBmpButton;
    btn_Message3: TRzBmpButton;
    btn_Message4: TRzBmpButton;
    Image2: TImage;
    Image3: TImage;
    btn_Close: TRzBmpButton;
    RzPage: TRzPageControl;
    TabTittle: TRzTabSheet;
    TabContents: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    DsNewsPaper: TDataSource;
    CdsNewsPaper: TZQuery;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    labTitle: TLabel;
    RzPanel11: TRzPanel;
    RzPanel12: TRzPanel;
    edtContents: TRichEdit;
    btnRead: TRzBmpButton;
    labPublishDate: TLabel;
    btnReturn: TRzBmpButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btn_Message1Click(Sender: TObject);
    procedure btn_Message2Click(Sender: TObject);
    procedure btn_Message3Click(Sender: TObject);
    procedure btn_Message4Click(Sender: TObject);
    procedure btn_Message0Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnReturnClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
    ID:String;
    MSG_Tpye:Integer;
    sFlag:Integer;
    MSGArr:array[0..4] of Integer;
    procedure InitMSGArr;
    procedure SetRecordNum;
  public
    { Public declarations }
    function DoActionExecute(s:string; Flag:Integer):boolean;
    procedure Open;
    procedure LoadPic32;
    function EncodeSql:String;
    procedure GetInfomation(MSG_ID:String);
    class function ShowNewsPaper(Title_ID:String;Msg_Class:Integer=0;Flag:Integer=0):Boolean;
  end;


implementation
uses uShopUtil, ufrmMain, uShopGlobal, uGlobal, uDsUtil, uFnUtil, uRcFactory, uPrainpowerJudge, ufrmHintMsg, ufrmQuestionnaire,
     ufrmStkIndentOrderList, ufrmStockOrderList, ufrmStkRetuOrderList, ufrmSalIndentOrderList, ufrmSalesOrderList,
     ufrmSalRetuOrderList, ufrmDbOrderList, ufrmCustomer, ufrmPayOrderList, ufrmRecvOrderList, ufrmInLocusOrderList, ufrmOutLocusOrderList;
{$R *.dfm}

{ TfrmNewPaperReader }

class function TfrmNewPaperReader.ShowNewsPaper(Title_ID: String;Msg_Class:Integer;Flag:Integer): Boolean;
begin
  with TfrmNewPaperReader.Create(Application.MainForm) do
    begin
      try
        ID := Title_ID;
        MSG_Tpye := Msg_Class;
        sFlag := Flag;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmNewPaperReader.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmNewPaperReader.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i := 0 to RzPage.PageCount - 1 do
    RzPage.Pages[i].TabVisible := False;
  RzPage.ActivePageIndex := 0;
  LoadPic32;
  Open;
  SetRecordNum;
  MsgFactory.Showing := true;
end;

procedure TfrmNewPaperReader.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if CdsNewsPaper.IsEmpty then Exit;
  if CdsNewsPaper.FieldByName('sFlag').AsInteger = 0 then
    begin
      RzPage.ActivePageIndex := 1;
      if CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger = 2 then
        btnRead.Visible := False
      else
        btnRead.Visible := True;
      GetInfomation(CdsNewsPaper.FieldbyName('MSG_ID').AsString);
    end
  else if CdsNewsPaper.FieldByName('sFlag').AsInteger in [1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28] then
    begin
      if DoActionExecute(CdsNewsPaper.FieldByName('MSG_ID').AsString,CdsNewsPaper.FieldByName('sFlag').AsInteger) then
         Close;
    end
  else if CdsNewsPaper.FieldByName('sFlag').AsInteger = 8 then
    begin
      try
        Self.Visible := False;
        TfrmQuestionnaire.AnswerQustion(nil,CdsNewsPaper.FieldByName('MSG_ID').AsString);
        MsgFactory.MsgRead[MsgFactory.FindMsg(CdsNewsPaper.FieldByName('MSG_ID').AsString)] := True;
      finally
        Close;
      end;
    end;
end;

function TfrmNewPaperReader.EncodeSql: String;
var Str,Str_where,StrJoin:String;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
    Str_where := ' and a.END_DATE >= '+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
    Str_where := Str_where + ' and b.SHOP_ID=' + QuotedStr(Global.SHOP_ID);

  Str :=
  'select a.MSG_ID,''·'''+StrJoin+'a.MSG_TITLE as MSG_TITLE,a.MSG_SOURCE,a.ISSUE_DATE,b.MSG_READ_STATUS,a.MSG_CLASS,0 as sFlag '+
  ' from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+Str_where+' order by a.ISSUE_DATE desc,b.MSG_READ_STATUS ';

  Result := Str;
end;

procedure TfrmNewPaperReader.Open;
begin
  CdsNewsPaper.Close;
  CdsNewsPaper.SQL.Text := EncodeSql;
  Factor.Open(CdsNewsPaper);
 // if not PrainpowerJudge.List.Active then
  PrainpowerJudge.Load(1);
  PrainpowerJudge.List.first;
  while not PrainpowerJudge.List.eof do
     begin
        if PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger = 0 then
          begin
            PrainpowerJudge.List.Next;
            Continue;
          end;
        CdsNewsPaper.Append;     
        CdsNewsPaper.FieldByName('MSG_ID').AsString := PrainpowerJudge.List.FieldByName('ID').AsString;
        if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=8 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·<待答>'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=9 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')位客户近期过生日！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=10 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')位客户近期要续会！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=11 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+IntToStr(PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger div 100000)+')单待发货、('+
           IntToStr(PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger mod 100000)+')单发货中'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=12 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+IntToStr(PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger div 100000)+')单待入库、('+
           IntToStr(PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger mod 100000)+')单入库中'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=13 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码发货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=14 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码发货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=15 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码发货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=16 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码发货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=17 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码收货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=18 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 待扫码收货！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=19 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+IntToStr(PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger mod 1000)+')张 预收、('+IntToStr(PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger div 1000000)+
                             ')张 应收、('+IntToStr((PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger div 1000) mod 1000)+')张 应退款单！'
        else if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=20 then
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+IntToStr(PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger div 1000000)+')张 预付、('+IntToStr((PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger div 1000) mod 1000)+
                             ')张 应付、('+IntToStr(PrainpowerJudge.List.FieldbyName('SUM_ORDER').AsInteger mod 1000)+')张 应退款单！'
        else
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有 ('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张 "'+ PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'" 没有审核';
        if PrainpowerJudge.List.FieldByName('sFlag').AsInteger=8 then
          begin
           CdsNewsPaper.FieldByName('MSG_SOURCE').AsString := '问卷调查';
           CdsNewsPaper.FieldByName('MSG_CLASS').AsString := '1';
          end
        else
          begin
           CdsNewsPaper.FieldByName('MSG_SOURCE').AsString := '智能提醒';
           CdsNewsPaper.FieldByName('MSG_CLASS').AsString := '4';
          end;
        CdsNewsPaper.FieldByName('ISSUE_DATE').AsString := formatDatetime('YYYYMMDD',date());
        CdsNewsPaper.FieldByName('sFlag').AsInteger := PrainpowerJudge.List.FieldByName('sFlag').AsInteger;
        CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger := 1;

        CdsNewsPaper.Post;
        PrainpowerJudge.List.Next;
     end;
  InitMSGArr;
end;

procedure TfrmNewPaperReader.btn_Message1Click(Sender: TObject);
begin
  inherited;
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clRed;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNewsPaper.Filtered := False;
  CdsNewsPaper.Filter := ' MSG_CLASS=''1'' ';
  CdsNewsPaper.Filtered := True;
end;

procedure TfrmNewPaperReader.btn_Message2Click(Sender: TObject);
begin
  inherited;
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clRed;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNewsPaper.Filtered := False;
  CdsNewsPaper.Filter := ' MSG_CLASS=''2'' ';
  CdsNewsPaper.Filtered := True;
end;

procedure TfrmNewPaperReader.btn_Message3Click(Sender: TObject);
var rs:TZQuery;
    Str_Sql:String;
begin
  inherited;
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clRed;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNewsPaper.Filtered := False;
  CdsNewsPaper.Filter := ' MSG_CLASS=''3'' ';
  CdsNewsPaper.Filtered := True;
end;

procedure TfrmNewPaperReader.btn_Message4Click(Sender: TObject);
begin
  inherited;
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clRed;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNewsPaper.Filtered := False;
  CdsNewsPaper.Filter := ' MSG_CLASS=''4'' ';
  CdsNewsPaper.Filtered := True;
  MsgFactory.ClearType(4);
end;

procedure TfrmNewPaperReader.GetInfomation(MSG_ID: String);
var rs:TZQuery;
    Date_Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    ID := MSG_ID;
    rs.Close;
    rs.SQL.Text :=
    'select MSG_TITLE,MSG_CONTENT,ISSUE_DATE,MSG_CLASS from MSC_MESSAGE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MSG_ID='+QuotedStr(ID);
    Factor.Open(rs);
    labTitle.Caption := rs.FieldbyName('MSG_TITLE').AsString;
    edtContents.Lines.Text := rs.FieldbyName('MSG_CONTENT').AsString;
    MSG_Tpye := rs.FieldbyName('MSG_CLASS').AsInteger;
    Date_Str := rs.FieldbyName('ISSUE_DATE').AsString;
    if trim(Date_Str) <> '' then
      begin
        Date_Str := '发布日期:'+copy(Date_Str,1,4)+'-'+copy(Date_Str,5,2)+'-'+copy(Date_Str,7,2)+'    ';
      end;
    labPublishDate.Caption := Date_Str;
  finally
    rs.Free;
  end;
end;

procedure TfrmNewPaperReader.btn_Message0Click(Sender: TObject);
begin
  inherited;
  btn_Message0.Font.Color := clRed;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNewsPaper.Filtered := False;
  CdsNewsPaper.Filter := ' MSG_CLASS=''0'' ';
  CdsNewsPaper.Filtered := True;
end;

procedure TfrmNewPaperReader.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if CdsNewsPaper.IsEmpty then Exit;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'MSG_INFO' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(DBGridEh1.Canvas.Font);
      try
        DBGridEh1.canvas.FillRect(ARect);
        DBGridEh1.Canvas.Font.Color := clBlue;
        DBGridEh1.Canvas.Font.Style := [fsUnderline];
        DrawText(DBGridEh1.Canvas.Handle,pchar('详情'),length('详情'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER);
      finally
        DBGridEh1.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
      
end;

procedure TfrmNewPaperReader.btnReturnClick(Sender: TObject);
begin
  inherited;
  case MSG_Tpye of
    0:btn_Message0Click(Sender);
    1:btn_Message1Click(Sender);
    2:btn_Message2Click(Sender);
    3:btn_Message3Click(Sender);
    4:btn_Message4Click(Sender);
  end;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
end;

procedure TfrmNewPaperReader.btnReadClick(Sender: TObject);
var ExcSql:String;
begin
  inherited;
  ExcSql :=
  'update MSC_MESSAGE_LIST set READ_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS',Now))+',READ_USER='+QuotedStr(Global.UserID)+',MSG_READ_STATUS=2,MSG_FEEDBACK_STATUS=1,COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' '+
  ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and MSG_ID='+QuotedStr(ID);
  if Factor.ExecSQL(ExcSql) = 0 then
    Raise Exception.Create('操作失败!');
  CdsNewsPaper.Edit;
  CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger := 2;
  CdsNewsPaper.Post;
  MSGArr[CdsNewsPaper.FieldByName('MSG_CLASS').AsInteger] := MSGArr[CdsNewsPaper.FieldByName('MSG_CLASS').AsInteger]-1;
  if MsgFactory.FindMsg(ID) <> nil then
    MsgFactory.MsgRead[MsgFactory.FindMsg(ID)] := True;
  RzPage.ActivePageIndex := 0;
  SetRecordNum;
end;

procedure TfrmNewPaperReader.SetRecordNum;
begin
  if MSGArr[0] <> 0 then
     btn_Message0.Caption := '    消息 ('+IntToStr(MSGArr[0])+')'
  else
     btn_Message0.Caption := '消息';

  if MSGArr[1] <> 0 then
     btn_Message1.Caption := '    公告 ('+IntToStr(MSGArr[1])+')'
  else
     btn_Message1.Caption := '公告';

  if MSGArr[2] <> 0 then
     btn_Message2.Caption := '    政策 ('+IntToStr(MSGArr[2])+')'
  else
     btn_Message2.Caption := '政策';

  if MSGArr[3] <> 0 then
     btn_Message3.Caption := '    广告 ('+IntToStr(MSGArr[3])+')'
  else
     btn_Message3.Caption := '广告';

  if MSGArr[4] <> 0 then
     btn_Message4.Caption := '    提醒 ('+IntToStr(MSGArr[4])+')'
  else
     btn_Message4.Caption := '提醒';
end;

procedure TfrmNewPaperReader.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if DBGridEh1.DataSource.DataSet.FieldByName('MSG_READ_STATUS').AsString <> '2' then
    begin
      AFont.Style := [fsBold];
    end;

end;

procedure TfrmNewPaperReader.InitMSGArr;
begin
  if not CdsNewsPaper.IsEmpty then
    begin
      CdsNewsPaper.First;
      while not CdsNewsPaper.Eof do
        begin
          case CdsNewsPaper.FieldByName('MSG_CLASS').AsInteger of
            0:inc(MSGArr[0]);
            1:inc(MSGArr[1]);
            2:inc(MSGArr[2]);
            3:inc(MSGArr[3]);
            4:inc(MSGArr[4]);
          end;
          CdsNewsPaper.Next;
        end;
    end;
end;

procedure TfrmNewPaperReader.FormShow(Sender: TObject);
begin
  inherited;
  case sFlag of
    0:begin
      if ID <> '' then
        begin
          RzPage.ActivePageIndex := 1;
          GetInfomation(ID);
        end
      else
        begin
          RzPage.ActivePageIndex := 0;
          btn_Message0Click(Sender);
        end;
    end;
    1..7:begin
      btn_Message4Click(Sender);
    end;
    8:begin
      btn_Message1Click(Sender);
    end;
    9..28:begin
      btn_Message4Click(Sender);
    end;
  end;

end;

function TfrmNewPaperReader.DoActionExecute(s: string; Flag:Integer): boolean;
var
  i:integer;
  Form:TfrmBasic;
  rs:TZQuery;
begin
  result := false;
  for i:=0 to frmMain.actList.ActionCount-1 do
    begin
      if lowercase(frmMain.actList.Actions[i].Name) = lowercase(s) then
         begin
           if not TAction(frmMain.actList.Actions[i]).Enabled then Raise Exception.Create('没有此单据!');
           TAction(frmMain.actList.Actions[i]).OnExecute(nil);
           case Flag of
             1:begin
               if PrainpowerJudge.List.Locate('sFlag',1,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmStkIndentOrderList);
                   TfrmStkIndentOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmStkIndentOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmStkIndentOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmStkIndentOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmStkIndentOrderList(Form).actFindExecute(nil);
                 end;
             end;
             2:begin
               if PrainpowerJudge.List.Locate('sFlag',2,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmStockOrderList);
                   TfrmStockOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmStockOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmStockOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmStockOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmStockOrderList(Form).actFindExecute(nil);
                 end;
             end;
             3:begin
               if PrainpowerJudge.List.Locate('sFlag',3,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmStkRetuOrderList);
                   TfrmStkRetuOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmStkRetuOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmStkRetuOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmStkRetuOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmStkRetuOrderList(Form).actFindExecute(nil);
                 end;
             end;
             4:begin
               if PrainpowerJudge.List.Locate('sFlag',4,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmSalIndentOrderList);
                   TfrmSalIndentOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmSalIndentOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmSalIndentOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmSalIndentOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmSalIndentOrderList(Form).actFindExecute(nil);
                 end;
             end;
             5:begin
               if PrainpowerJudge.List.Locate('sFlag',5,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmSalesOrderList);
                   TfrmSalesOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmSalesOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmSalesOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmSalesOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmSalesOrderList(Form).actFindExecute(nil);
                 end;
             end;
             6:begin
               if PrainpowerJudge.List.Locate('sFlag',6,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmSalRetuOrderList);
                   TfrmSalRetuOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmSalRetuOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmSalRetuOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmSalRetuOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmSalRetuOrderList(Form).actFindExecute(nil);
                 end;
             end;
             7:begin
               if PrainpowerJudge.List.Locate('sFlag',7,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmDbOrderList);
                   TfrmDbOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmDbOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmDbOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmDbOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmDbOrderList(Form).actFindExecute(nil);
                 end;
             end;
             9:begin
               if PrainpowerJudge.List.Locate('sFlag',9,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmCustomer);
                   TfrmCustomer(Form).edtDate1.Date := Date();
                   TfrmCustomer(Form).edtDate2.Date := Date()+PrainpowerJudge.List.FieldByName('MIN_DATE').AsInteger;

                   TfrmCustomer(Form).cmbSHOP_ID.KeyValue := '';
                   TfrmCustomer(Form).cmbSHOP_ID.Text := '';

                   TfrmCustomer(Form).actFindExecute(nil);
                 end;
             end;
             10:begin
               if PrainpowerJudge.List.Locate('sFlag',10,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmCustomer);
                   TfrmCustomer(Form).edtDate3.Date := Date();
                   TfrmCustomer(Form).edtDate4.Date := Date()+PrainpowerJudge.List.FieldByName('MIN_DATE').AsInteger;

                   TfrmCustomer(Form).cmbSHOP_ID.KeyValue := '';
                   TfrmCustomer(Form).cmbSHOP_ID.Text := '';

                   TfrmCustomer(Form).actFindExecute(nil);
                 end;
             end;
             11:begin
               if PrainpowerJudge.List.Locate('sFlag',11,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmSalIndentOrderList);
                   if Assigned(Form) then
                     begin
                       if (PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger div 100000) > 0 then
                        TfrmSalIndentOrderList(Form).fndSTATUS.ItemIndex := 3
                       else
                        TfrmSalIndentOrderList(Form).fndSTATUS.ItemIndex := 4;
                       TfrmSalIndentOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                       TfrmSalIndentOrderList(Form).fndSHOP_ID.KeyValue := '';
                       TfrmSalIndentOrderList(Form).fndSHOP_ID.Text := '';

                       TfrmSalIndentOrderList(Form).actFindExecute(nil);
                     end;
                 end;
             end;
             12:begin
               if PrainpowerJudge.List.Locate('sFlag',12,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmStkIndentOrderList);
                   if (PrainpowerJudge.List.FieldByName('SUM_ORDER').AsInteger div 100000) > 0 then
                    TfrmStkIndentOrderList(Form).fndSTATUS.ItemIndex := 3
                   else
                    TfrmStkIndentOrderList(Form).fndSTATUS.ItemIndex := 4;
                   TfrmStkIndentOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);

                   TfrmStkIndentOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmStkIndentOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmStkIndentOrderList(Form).actFindExecute(nil);
                 end;
             end;
             13:begin
               if PrainpowerJudge.List.Locate('sFlag',13,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmOutLocusOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmOutLocusOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             14:begin
               if PrainpowerJudge.List.Locate('sFlag',14,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmOutLocusOrderList(Form).fndP2_STATUS.ItemIndex := 1;
                   TfrmOutLocusOrderList(Form).fndP2_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP2_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP2_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP2_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             15:begin
               if PrainpowerJudge.List.Locate('sFlag',15,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 2;
                   TfrmOutLocusOrderList(Form).fndP3_STATUS.ItemIndex := 1;
                   TfrmOutLocusOrderList(Form).fndP3_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP3_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP3_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP3_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             16:begin
               if PrainpowerJudge.List.Locate('sFlag',16,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 3;
                   TfrmOutLocusOrderList(Form).fndP4_STATUS.ItemIndex := 1;
                   TfrmOutLocusOrderList(Form).fndP4_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP4_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP4_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP4_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             17:begin
               if PrainpowerJudge.List.Locate('sFlag',17,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmInLocusOrderList);
                   TfrmInLocusOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmInLocusOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmInLocusOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmInLocusOrderList(Form).D2.Date := Date();

                   TfrmInLocusOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmInLocusOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmInLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             18:begin
               if PrainpowerJudge.List.Locate('sFlag',18,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmInLocusOrderList);
                   TfrmInLocusOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmInLocusOrderList(Form).fndP2_STATUS.ItemIndex := 1;
                   TfrmInLocusOrderList(Form).fndP2_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmInLocusOrderList(Form).fndP2_D2.Date := Date();

                   TfrmInLocusOrderList(Form).fndP2_SHOP_ID.KeyValue := '';
                   TfrmInLocusOrderList(Form).fndP2_SHOP_ID.Text := '';

                   TfrmInLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             19:begin
               if PrainpowerJudge.List.Locate('sFlag',19,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmRecvOrderList);
                   TfrmRecvOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmRecvOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmRecvOrderList(Form).P1_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmRecvOrderList(Form).P1_D2.Date := Date();

                   TfrmRecvOrderList(Form).fndP1_SHOP_ID.KeyValue := '';
                   TfrmRecvOrderList(Form).fndP1_SHOP_ID.Text := '';

                   TfrmRecvOrderList(Form).actFindExecute(nil);
                 end;
             end;
             20:begin
               if PrainpowerJudge.List.Locate('sFlag',20,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmPayOrderList);
                   TfrmPayOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmPayOrderList(Form).fndSTATUS.ItemIndex := 1;
                   TfrmPayOrderList(Form).P1_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmPayOrderList(Form).P1_D2.Date := Date();

                   TfrmPayOrderList(Form).fndP1_SHOP_ID.KeyValue := '';
                   TfrmPayOrderList(Form).fndP1_SHOP_ID.Text := '';

                   TfrmPayOrderList(Form).actFindExecute(nil);
                 end;
             end;
             21:begin
               if PrainpowerJudge.List.Locate('sFlag',21,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmRecvOrderList);
                   TfrmRecvOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmRecvOrderList(Form).fndOrderStatus.ItemIndex := 1;
                   TfrmRecvOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmRecvOrderList(Form).D2.Date := Date();

                   TfrmRecvOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmRecvOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmRecvOrderList(Form).actFindExecute(nil);
                 end;
             end;
             22:begin
               if PrainpowerJudge.List.Locate('sFlag',22,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmPayOrderList);
                   TfrmPayOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmPayOrderList(Form).fndOrderStatus.ItemIndex := 1;
                   TfrmPayOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmPayOrderList(Form).D2.Date := Date();

                   TfrmPayOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmPayOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmPayOrderList(Form).actFindExecute(nil);
                 end;
             end;
             23:begin
               if PrainpowerJudge.List.Locate('sFlag',23,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmOutLocusOrderList(Form).fndSTATUS.ItemIndex := 3;
                   TfrmOutLocusOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             24:begin
               if PrainpowerJudge.List.Locate('sFlag',24,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmOutLocusOrderList(Form).fndP2_STATUS.ItemIndex := 3;
                   TfrmOutLocusOrderList(Form).fndP2_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP2_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP2_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP2_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             25:begin
               if PrainpowerJudge.List.Locate('sFlag',25,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 2;
                   TfrmOutLocusOrderList(Form).fndP3_STATUS.ItemIndex := 3;
                   TfrmOutLocusOrderList(Form).fndP3_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP3_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP3_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP3_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             26:begin
               if PrainpowerJudge.List.Locate('sFlag',26,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmOutLocusOrderList);
                   TfrmOutLocusOrderList(Form).RzPage.ActivePageIndex := 3;
                   TfrmOutLocusOrderList(Form).fndP4_STATUS.ItemIndex := 3;
                   TfrmOutLocusOrderList(Form).fndP4_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmOutLocusOrderList(Form).fndP4_D2.Date := Date();

                   TfrmOutLocusOrderList(Form).fndP4_SHOP_ID.KeyValue := '';
                   TfrmOutLocusOrderList(Form).fndP4_SHOP_ID.Text := '';

                   TfrmOutLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             27:begin
               if PrainpowerJudge.List.Locate('sFlag',27,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmInLocusOrderList);
                   TfrmInLocusOrderList(Form).RzPage.ActivePageIndex := 0;
                   TfrmInLocusOrderList(Form).fndSTATUS.ItemIndex := 3;
                   TfrmInLocusOrderList(Form).D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmInLocusOrderList(Form).D2.Date := Date();

                   TfrmInLocusOrderList(Form).fndSHOP_ID.KeyValue := '';
                   TfrmInLocusOrderList(Form).fndSHOP_ID.Text := '';

                   TfrmInLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
             28:begin
               if PrainpowerJudge.List.Locate('sFlag',28,[]) then
                 begin
                   Form := frmMain.FindChildForm(TfrmInLocusOrderList);
                   TfrmInLocusOrderList(Form).RzPage.ActivePageIndex := 1;
                   TfrmInLocusOrderList(Form).fndP2_STATUS.ItemIndex := 3;
                   TfrmInLocusOrderList(Form).fndP2_D1.Date := FnTime.fnStrtoDate(PrainpowerJudge.List.FieldByName('MIN_DATE').AsString);
                   TfrmInLocusOrderList(Form).fndP2_D2.Date := Date();

                   TfrmInLocusOrderList(Form).fndP2_SHOP_ID.KeyValue := '';
                   TfrmInLocusOrderList(Form).fndP2_SHOP_ID.Text := '';

                   TfrmInLocusOrderList(Form).actFindExecute(nil);
                 end;
             end;
           end;

           result := true;
           Exit;
         end;
    end;
end;

procedure TfrmNewPaperReader.FormDestroy(Sender: TObject);
begin
  MsgFactory.Showing := false;
  inherited;

end;

procedure TfrmNewPaperReader.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if CdsNewsPaper.IsEmpty then Exit;

  if Column.FieldName = 'MSG_INFO' then
    DBGridEh1DblClick(nil);
end;

procedure TfrmNewPaperReader.LoadPic32;
var
  sflag:String;
begin
  sflag := 's'+rcFactory.GetResString(1)+'_';
  //Top
  Image1.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Top');
  //Mid
  Image2.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid2');
  Image3.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid3');
  btn_Message0.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message0.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message0.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message1.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message1.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message1.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message2.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message2.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message2.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message3.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message3.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message3.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message4.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Up');
  btn_Message4.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Down');
  btn_Message4.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Hot');
  btnReturn.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Return');
  btnRead.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Read');
  //Bottom
  btn_Close.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Up');
  btn_Close.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Hot');
end;

end.
