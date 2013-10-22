unit ufrmNewPaperReader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, RzBckgnd, ComCtrls, Grids, DBGridEh, RzTabs, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ActnList, Menus;

type
  TfrmNewPaperReader = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel6: TRzPanel;
    RzPage: TRzPageControl;
    TabTittle: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    TabContents: TRzTabSheet;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    labTitle: TLabel;
    btnReturn: TRzBmpButton;
    RzPanel11: TRzPanel;
    RzPanel12: TRzPanel;
    labPublishDate: TLabel;
    edtContents: TRichEdit;
    RzPanel9: TRzPanel;
    btn_Message0: TRzBmpButton;
    btn_Message1: TRzBmpButton;
    btn_Message2: TRzBmpButton;
    btn_Message3: TRzBmpButton;
    btn_Message4: TRzBmpButton;
    RzPanel10: TRzPanel;
    Image4: TImage;
    Image5: TImage;
    RzPanel7: TRzPanel;
    RzBackground1: TRzBackground;
    Image6: TImage;
    RzPanel8: TRzPanel;
    btn_Close: TRzBmpButton;
    RzPanel13: TRzPanel;
    actList: TActionList;
    DsNewsPaper: TDataSource;
    CdsNewsPaper: TZQuery;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btn_Message0Click(Sender: TObject);
    procedure btn_Message1Click(Sender: TObject);
    procedure btn_Message2Click(Sender: TObject);
    procedure btn_Message3Click(Sender: TObject);
    procedure btn_Message4Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnReturnClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    ID:String;
    MSG_Tpye:integer;
    sFlag:integer;
    MSGArr:array[0..4] of integer;
    btnCaptionSign:Boolean;
    btnCapArr:array[0..4] of String;
    procedure InitMSGArr;
    procedure SetRecordNum;
  public
    procedure Open;
    function  EncodeSql:String;
    procedure GetInfomation(MSG_ID:String);
    class function ShowNewsPaper(Title_ID:String;Msg_Class:integer=0;Flag:integer=0):Boolean;
  end;

implementation

uses ufrmHintMsg,udataFactory,uTokenFactory,ObjCommon;

{$R *.dfm}

class function TfrmNewPaperReader.ShowNewsPaper(Title_ID: String;Msg_Class:integer;Flag:integer): Boolean;
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
var i:integer;
begin
  inherited;
  for i := 0 to RzPage.PageCount - 1 do
      RzPage.Pages[i].TabVisible := False;
  RzPage.ActivePageIndex := 0;
  btnCaptionSign := true;
  MsgFactory.Showing := true;
end;

procedure TfrmNewPaperReader.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if CdsNewsPaper.IsEmpty then Exit;
  if CdsNewsPaper.FieldByName('sFlag').AsInteger = 0 then
     begin
       RzPage.ActivePageIndex := 1;
       GetInfomation(CdsNewsPaper.FieldbyName('MSG_ID').AsString);
     end;
end;

function TfrmNewPaperReader.EncodeSql: String;
var Str,Str_where,StrJoin:String;
begin
  case dataFactory.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
    Str_where := ' and a.END_DATE >= '+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
    Str_where := Str_where + ' and b.SHOP_ID=' + QuotedStr(token.shopId);

  Str :=
  ' select a.MSG_ID,''·'''+StrJoin+'a.MSG_TITLE as MSG_TITLE,a.MSG_SOURCE,a.ISSUE_DATE,b.MSG_READ_STATUS,a.MSG_CLASS,0 as sFlag '+
  ' from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+token.tenantId+Str_where+' order by a.ISSUE_DATE desc,b.MSG_READ_STATUS ';

  result := Str;
end;

procedure TfrmNewPaperReader.Open;
begin
  CdsNewsPaper.Close;
  CdsNewsPaper.SQL.Text := EncodeSql;
  dataFactory.Open(CdsNewsPaper);
  InitMSGArr;
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
  CdsNewsPaper.First;
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
  CdsNewsPaper.First;
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
  CdsNewsPaper.First;
end;

procedure TfrmNewPaperReader.btn_Message3Click(Sender: TObject);
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
  CdsNewsPaper.First;
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
  CdsNewsPaper.First;
  MsgFactory.ClearType(4);
end;

procedure TfrmNewPaperReader.GetInfomation(MSG_ID: String);
var
  rs:TZQuery;
  Date_Str:String;
  ExcSql:String;
begin
  rs := TZQuery.Create(nil);
  try
    ID := MSG_ID;
    rs.Close;
    rs.SQL.Text := 'select MSG_TITLE,MSG_CONTENT,ISSUE_DATE,MSG_CLASS from MSC_MESSAGE where TENANT_ID='+token.tenantId+' and MSG_ID='+QuotedStr(ID);
    dataFactory.Open(rs);
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

  ExcSql :=
    ' update MSC_MESSAGE_LIST set READ_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS',now()))+',READ_USER='+QuotedStr(token.userId)+',MSG_READ_STATUS=2,MSG_FEEDBACK_STATUS=1,COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' '+
    ' where TENANT_ID='+token.tenantId+' and SHOP_ID='+QuotedStr(token.shopId)+' and MSG_ID='+QuotedStr(MSG_ID);

  if dataFactory.ExecSQL(ExcSql) = 0 then Raise Exception.Create('操作失败!');

  MsgFactory.MsgRead[MsgFactory.FindMsg(MSG_ID)] := True;

  if (not CdsNewsPaper.IsEmpty) and CdsNewsPaper.Locate('MSG_ID',MSG_ID,[]) then
    begin
      CdsNewsPaper.Edit;
      CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger := 2;
      CdsNewsPaper.Post;
    end;
end;

procedure TfrmNewPaperReader.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if CdsNewsPaper.IsEmpty then
     begin
       if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not (gdFocused in State) or not DBGridEh1.Focused) then
       begin
         DBGridEh1.Canvas.Brush.Color := clWindow;
       end;
       DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
     end
  else
     begin
       if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not (gdFocused in State) or not DBGridEh1.Focused) then
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

procedure TfrmNewPaperReader.SetRecordNum;
begin
  if btnCaptionSign then
     begin
       btnCaptionSign := false;
       btnCapArr[0] := btn_Message0.Caption;
       btnCapArr[1] := btn_Message1.Caption;
       btnCapArr[2] := btn_Message2.Caption;
       btnCapArr[3] := btn_Message3.Caption;
       btnCapArr[4] := btn_Message4.Caption;
     end;

  if MSGArr[0] <> 0 then
     btn_Message0.Caption := btnCapArr[0]+'('+IntToStr(MSGArr[0])+')'
  else
     btn_Message0.Caption := btnCapArr[0];

  if MSGArr[1] <> 0 then
     btn_Message1.Caption := btnCapArr[1]+'('+IntToStr(MSGArr[1])+')'
  else
     btn_Message1.Caption := btnCapArr[1];

  if MSGArr[2] <> 0 then
     btn_Message2.Caption := btnCapArr[2]+'('+IntToStr(MSGArr[2])+')'
  else
     btn_Message2.Caption := btnCapArr[2];

  if MSGArr[3] <> 0 then
     btn_Message3.Caption := btnCapArr[3]+'('+IntToStr(MSGArr[3])+')'
  else
     btn_Message3.Caption := btnCapArr[3];

  if MSGArr[4] <> 0 then
     btn_Message4.Caption := btnCapArr[4]+'('+IntToStr(MSGArr[4])+')'
  else
     btn_Message4.Caption := btnCapArr[4];
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
  DBGridEh1.Color := clWindow;
  Open;
  SetRecordNum;
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
