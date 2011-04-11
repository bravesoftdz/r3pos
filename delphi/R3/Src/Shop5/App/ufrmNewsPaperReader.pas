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
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ID:String;
    MSG_Tpye:String;
    procedure InitMSGArr;
    procedure SetRecordNum;
  public
    { Public declarations }
    procedure Open;
    function EncodeSql:String;
    procedure GetInfomation(MSG_ID:String);
    class function ShowNewsPaper(Title_ID:String):Boolean;
  end;

var MSGArr:array[0..4] of Integer = (0,0,0,0,0);

implementation
uses uShopUtil, uShopGlobal, uGlobal, uDsUtil, ufrmHintMsg;
{$R *.dfm}

{ TfrmNewPaperReader }

class function TfrmNewPaperReader.ShowNewsPaper(Title_ID: String): Boolean;
begin
  with TfrmNewPaperReader.Create(Application.MainForm) do
    begin
      try
        ID := Title_ID;
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
  MSG_Tpye := '';
  InitMSGArr;
  SetRecordNum;
  ID := '';
end;

procedure TfrmNewPaperReader.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 1;
  if CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger = 2 then
    btnRead.Visible := False
  else
    btnRead.Visible := True;
  GetInfomation(CdsNewsPaper.FieldbyName('MSG_ID').AsString);
end;

function TfrmNewPaperReader.EncodeSql: String;
var Str,Str_where,StrJoin:String;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;

  if MSG_Tpye <> '' then
    Str_where := ' and a.MSG_CLASS='+QuotedStr(MSG_Tpye);
    Str_where := Str_where + ' and a.END_DATE >= '+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
    Str_where := Str_where + ' and b.SHOP_ID=' + QuotedStr(Global.SHOP_ID);

  Str :=
  'select a.TENANT_ID,a.MSG_ID,''·'''+StrJoin+'a.MSG_TITLE as MSG_TITLE,a.MSG_SOURCE,a.ISSUE_DATE,a.MSG_CLASS,b.READ_DATE,b.READ_USER,b.MSG_FEEDBACK_STATUS,b.MSG_READ_STATUS '+
  ' from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+Str_where+' order by a.ISSUE_DATE desc,b.MSG_READ_STATUS ';

  Result := Str;
end;

procedure TfrmNewPaperReader.Open;
begin
  CdsNewsPaper.Close;
  CdsNewsPaper.SQL.Text := EncodeSql;
  Factor.Open(CdsNewsPaper);
end;

procedure TfrmNewPaperReader.btn_Message1Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '1';
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clRed;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  Open;
end;

procedure TfrmNewPaperReader.btn_Message2Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '2';
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clRed;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  Open;
end;

procedure TfrmNewPaperReader.btn_Message3Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '3';
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clRed;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  Open;
end;

procedure TfrmNewPaperReader.btn_Message4Click(Sender: TObject);
begin
  inherited;
  MSG_Tpye := '4';
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clRed;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  Open;
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
  MSG_Tpye := '0';
  btn_Message0.Font.Color := clRed;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  Open;
end;

procedure TfrmNewPaperReader.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
begin
  inherited;

  if not (gdSelected in State ) then
    begin
      if CdsNewsPaper.RecNo mod 2 = 0 then
        DBGridEh1.Canvas.Brush.Color := $00FDF6EB;
    end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

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
  'update MSC_MESSAGE_LIST set READ_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS',Now))+',READ_USER='+QuotedStr(Global.UserID)+',MSG_READ_STATUS=2,MSG_FEEDBACK_STATUS=2,COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' '+
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
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := ' select a.MSG_CLASS,count(a.MSG_ID) as Sum_Type '+
    'from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
    'where a.COMM not in (''12'',''02'') and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and a.END_DATE >= '+ QuotedStr(FormatDateTime('YYYY-MM-DD',Date())) +
    ' and b.SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and b.MSG_READ_STATUS<>2 group by a.MSG_CLASS ';
    Factor.Open(rs);

    if not rs.IsEmpty then
      begin
        rs.First;
        while not rs.Eof do
          begin
            case rs.FieldByName('MSG_CLASS').AsInteger of
              0:begin
                if rs.FieldByName('Sum_Type').AsInteger <> 0 then
                   MSGArr[0] := rs.FieldByName('Sum_Type').AsInteger;
                end;
              1: begin
                if rs.FieldByName('Sum_Type').AsInteger <> 0 then
                   MSGArr[1] := rs.FieldByName('Sum_Type').AsInteger;
                end;
              2:begin
                if rs.FieldByName('Sum_Type').AsInteger <> 0 then
                   MSGArr[2] := rs.FieldByName('Sum_Type').AsInteger;
                end;
              3:begin
                if rs.FieldByName('Sum_Type').AsInteger <> 0 then
                   MSGArr[3] := rs.FieldByName('Sum_Type').AsInteger;
                end;
              4:begin
                if rs.FieldByName('Sum_Type').AsInteger <> 0 then
                   MSGArr[4] := rs.FieldByName('Sum_Type').AsInteger;
                end;
            end;
            rs.Next;
          end;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmNewPaperReader.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if CdsNewsPaper.IsEmpty then Exit;

  if Column.FieldName = 'MSG_TITLE' then
    begin
      RzPage.ActivePageIndex := 1;
      if CdsNewsPaper.FieldByName('MSG_READ_STATUS').AsInteger = 2 then
        btnRead.Visible := False
      else
        btnRead.Visible := True;
      ID := CdsNewsPaper.FieldbyName('MSG_ID').AsString;
      GetInfomation(ID);
    end;
end;

procedure TfrmNewPaperReader.FormShow(Sender: TObject);
begin
  inherited;
  if ID <> '' then
    begin
      RzPage.ActivePageIndex := 1;
      GetInfomation(ID);
    end
  else
    begin
      RzPage.ActivePageIndex := 0;
    end;
end;

end.
