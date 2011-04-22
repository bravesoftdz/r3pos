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
    //MSG_Tpye:Integer;
    sFlag:Integer;
    MSGArr:array[0..4] of Integer;
    procedure InitMSGArr;
    procedure SetRecordNum;
  public
    { Public declarations }
    function DoActionExecute(s:string):boolean;
    procedure Open;
    function EncodeSql:String;
    procedure GetInfomation(MSG_ID:String);
    class function ShowNewsPaper(Title_ID:String;Msg_Class:Integer=0;Flag:Integer=0):Boolean;
  end;


implementation
uses uShopUtil, ufrmMain, uShopGlobal, uGlobal, uDsUtil, uPrainpowerJudge, ufrmHintMsg;
{$R *.dfm}

{ TfrmNewPaperReader }

class function TfrmNewPaperReader.ShowNewsPaper(Title_ID: String;Msg_Class:Integer;Flag:Integer): Boolean;
begin
  with TfrmNewPaperReader.Create(Application.MainForm) do
    begin
      try
        ID := Title_ID;
        //MSG_Tpye := Msg_Class;
        sFlag := Flag;
        Open;
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
  Open;
  SetRecordNum;
  ID := '';
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
  else if CdsNewsPaper.FieldByName('sFlag').AsInteger in [1,2,3,4,5,6,7] then
    begin
      if DoActionExecute(CdsNewsPaper.FieldByName('MSG_ID').AsString) then
        Close;
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
  if not PrainpowerJudge.List.Active then PrainpowerJudge.Load;
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
        else
           CdsNewsPaper.FieldByName('MSG_TITLE').AsString := '·您有('+PrainpowerJudge.List.FieldByName('SUM_ORDER').AsString+')张"'+ PrainpowerJudge.List.FieldByName('MSG_TITLE').AsString+'"没有审核';
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
end;

procedure TfrmNewPaperReader.GetInfomation(MSG_ID: String);
var rs:TZQuery;
    Date_Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
       'select MSG_TITLE,MSG_CONTENT,ISSUE_DATE from MSC_MESSAGE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and MSG_ID='+QuotedStr(MSG_ID);
    Factor.Open(rs);
    labTitle.Caption := rs.FieldbyName('MSG_TITLE').AsString;
    edtContents.Lines.Text := rs.FieldbyName('MSG_CONTENT').AsString;
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
  if not (gdSelected in State ) then
    begin
      if CdsNewsPaper.RecNo mod 2 = 0 then
        DBGridEh1.Canvas.Brush.Color := $00FDF6EB;
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
        DrawText(DBGridEh1.Canvas.Handle,pchar('详情'),length('详情'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      finally
        DBGridEh1.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
      
end;

procedure TfrmNewPaperReader.btnReturnClick(Sender: TObject);
begin
  inherited;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
end;

procedure TfrmNewPaperReader.btnReadClick(Sender: TObject);
var ExcSql:String;
begin
  inherited;
  ExcSql :=
  'update MSC_MESSAGE_LIST set READ_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS',Now))+',READ_USER='+QuotedStr(Global.UserID)+',MSG_READ_STATUS=2,MSG_FEEDBACK_STATUS=1,COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' '+
  ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and MSG_ID='+QuotedStr(CdsNewsPaper.FieldbyName('MSG_ID').AsString);
  if Factor.ExecSQL(ExcSql) = 0 then
    Raise Exception.Create('操作失败!');
  CdsNewsPaper.Edit;
  CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger := 2;
  CdsNewsPaper.Post;
  MSGArr[CdsNewsPaper.FieldByName('MSG_CLASS').AsInteger] := MSGArr[CdsNewsPaper.FieldByName('MSG_CLASS').AsInteger]-1;
  RzPage.ActivePageIndex := 0;
  SetRecordNum;
  MsgFactory.FindMsg(ID).Rdd := True;
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
  end;

end;

function TfrmNewPaperReader.DoActionExecute(s: string): boolean;
var
  i:integer;
begin
  result := false;
  for i:=0 to frmMain.actList.ActionCount-1 do
    begin
      if lowercase(frmMain.actList.Actions[i].Name) = lowercase(s) then
         begin
           if not TAction(frmMain.actList.Actions[i]).Enabled then Raise Exception.Create('没有此单据!'); 
           TAction(frmMain.actList.Actions[i]).OnExecute(nil);
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

end.
