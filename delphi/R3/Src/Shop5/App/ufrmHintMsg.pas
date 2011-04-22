unit ufrmHintMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBHints, ExtCtrls, RzForms, RzPanel, StdCtrls, RzLabel, jpeg ,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RzBckgnd, RzBmpBtn;

type
  TMsgInfo=record
    ID:string;
    Title:string;
    Contents:String;
    SndDate:string;
    Rdd:boolean;
    //0公告 1系统提示
    sFlag:integer;
  end;
  PMsgInfo=^TMsgInfo;
  TMsgFactory=class
  private
    FList:TList;
    FMsgInfo:PMsgInfo;
    FLoaded: Boolean;
    FShowing: Boolean;
    function GetCount: integer;
    function GetMsgInfo(itemindex: integer): PMsgInfo;
    procedure SetLoaded(const Value: Boolean);
    procedure SetShowing(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    function EncodeSQL:String;
    function Load:Boolean;
    procedure Add(MsgInfo:PMsgInfo);
    procedure ShowMsg(MsgInfo:PMsgInfo);
    procedure HintMsg(MsgInfo:PMsgInfo);
    procedure Clear;
    function ReadMsg:PMsgInfo;
    function FindMsg(ID:string):PMsgInfo;
    property MsgInfo[itemindex:integer]:PMsgInfo read GetMsgInfo;
    property Count:integer read GetCount;
    property Info:PMsgInfo read FMsgInfo;
    property Loaded:Boolean read FLoaded write SetLoaded;
    property Showing:Boolean read FShowing write SetShowing;
  end;
  TfrmHintMsg = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzBackground1: TRzBackground;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    Image1: TImage;
    labType: TLabel;
    RzBmpButton3: TRzBmpButton;
    labTitle: TRzURLLabel;
    RzFormShape1: TRzFormShape;
    edtContents: TLabel;
    procedure rzMsgClick(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure labTitleMouseEnter(Sender: TObject);
    procedure labTitleMouseLeave(Sender: TObject);
    procedure edtContentsMouseEnter(Sender: TObject);
    procedure edtContentsMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    MsgInfo:PMsgInfo;
    { Public declarations }
    class procedure ShowInfo(Msg:PMsgInfo);
  end;

var
  MsgFactory:TMsgFactory;
implementation
uses uGlobal,uShopGlobal,ufrmNewsPaperReader;  //ufrmShowMsg
{$R *.dfm}
var
  frmMsg: TfrmHintMsg;

{ TMsgFactory }
procedure TMsgFactory.Add(MsgInfo: PMsgInfo);
begin
  //MsgInfo^.sFlag := 1;
  FList.Add(MsgInfo); 
end;

procedure TMsgFactory.Clear;
var i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      Dispose(FList[i]);
    end;
  FList.Clear;
end;

constructor TMsgFactory.Create;
begin
  inherited;
  FList := TList.Create;
  FMsgInfo := nil;
end;

destructor TMsgFactory.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TMsgFactory.EncodeSQL: String;
var Str_Sql,Str_where:String;
begin
  Str_where := Str_where + ' and a.END_DATE >= '+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
  Str_where := Str_where + ' and b.SHOP_ID=' + QuotedStr(Global.SHOP_ID)+ ' and b.MSG_READ_STATUS=1 ';

  Str_Sql :=
  'select a.MSG_ID,a.MSG_TITLE,a.MSG_CONTENT,a.ISSUE_DATE,a.MSG_CLASS from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+Str_where+' order by a.ISSUE_DATE desc';

  Result := Str_Sql;
end;

function TMsgFactory.FindMsg(ID: string): PMsgInfo;
var i:integer;
begin
  result := nil;
  for i:=0 to FList.Count -1 do
    begin
      if PMsgInfo(FList[i]).ID = ID then
         begin
           result := PMsgInfo(FList[i]);
           Exit;
         end;
    end;
end;

function TMsgFactory.GetCount: integer;
begin
  result := FList.Count; 
end;

function TMsgFactory.GetMsgInfo(itemindex: integer): PMsgInfo;
begin
  result := PMsgInfo(FList[itemindex]);
end;

procedure TMsgFactory.HintMsg(MsgInfo: PMsgInfo);
begin
  TfrmHintMsg.ShowInfo(MsgInfo); 
end;

function TMsgFactory.Load:Boolean;
var Str_where:String;
    rs:TZQuery;
    MsgInfo:PMsgInfo;
begin
  Clear;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := EncodeSQL;
    Factor.Open(rs);
    Loaded := True;
    rs.First;
    while not rs.Eof do
      begin
        new(MsgInfo);
        MsgInfo^.ID := rs.Fields[0].AsString;
        MsgInfo^.Title := rs.Fields[1].AsString;
        MsgInfo^.Contents := rs.Fields[2].AsString;
        MsgInfo^.SndDate := rs.Fields[3].AsString;
        MsgInfo^.Rdd := false;
        MsgInfo^.sFlag := rs.Fields[4].AsInteger;
        FList.Add(MsgInfo);
        rs.Next;
      end;
  finally
    rs.free;
  end;
end;

function TMsgFactory.ReadMsg: PMsgInfo;
var i:integer;
begin
  result := nil;
  if ShowIng then Exit;
  for i:=count - 1 downto 0 do
    begin
      if not MsgInfo[i]^.Rdd then
         begin
           result := MsgInfo[i];
           Exit;
         end;
    end;
end;

procedure TMsgFactory.SetLoaded(const Value: Boolean);
begin
  FLoaded := Value;
end;

procedure TMsgFactory.SetShowing(const Value: Boolean);
begin
  FShowing := Value;
  if frmMsg<>nil then frmMsg.Close;
end;

procedure TMsgFactory.ShowMsg(MsgInfo: PMsgInfo);
begin
  TfrmNewPaperReader.ShowNewsPaper(MsgInfo^.ID);
end;

{ TfrmMsg }

class procedure TfrmHintMsg.ShowInfo(Msg: PMsgInfo);
var Contents_M:WideString;
begin
  if frmMsg=nil then frmMsg := TfrmHintMsg.Create(Application.MainForm);
  if Pointer(frmMsg.MsgInfo)=Pointer(Msg) then
     begin
       if not frmMsg.Visible then
       begin
         frmMsg.Show;
         frmMsg.Visible := true;
         frmMsg.BringToFront;
       end;
       Exit;
     end;
  frmMsg.MsgInfo := Msg;
  //frmMsg.Left := Application.MainForm.Width-frmMsg.Width-13;
  //frmMsg.Top := Application.MainForm.Height-frmMsg.Height-13;
  frmMsg.Left := Screen.WorkAreaWidth-frmMsg.Width-2;
  frmMsg.Top := Screen.WorkAreaHeight-frmMsg.Height-2;
  frmMsg.MsgInfo := Msg;
  frmMsg.labTitle.Caption := Msg^.Title;
  Contents_M := Msg^.Contents;
  if Length(Contents_M) >= 100 then
    begin
      frmMsg.edtContents.Caption := Copy(Contents_M,1,98)+'..';
    end
  else
    begin
      frmMsg.edtContents.Caption := Contents_M;
    end;
  case Msg^.sFlag of                                            
    0:frmMsg.labType.Caption := '最新消息';
    1:frmMsg.labType.Caption := '最新公告';
    2:frmMsg.labType.Caption := '最新政策';
    3:frmMsg.labType.Caption := '最新广告';
    4:frmMsg.labType.Caption := '最新提醒';
  end;
  frmMsg.Show;
  frmMsg.Visible := true;
  frmMsg.BringToFront;
end;

procedure TfrmHintMsg.rzMsgClick(Sender: TObject);
begin
  Close;
  MsgFactory.ShowMsg(MsgInfo);  
end;

procedure TfrmHintMsg.RzBmpButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmHintMsg.labTitleMouseEnter(Sender: TObject);
begin
  labTitle.Font.Color := $00EB7A16;
end;

procedure TfrmHintMsg.labTitleMouseLeave(Sender: TObject);
begin
  labTitle.Font.Color := $007C4E0C;
end;

procedure TfrmHintMsg.edtContentsMouseEnter(Sender: TObject);
begin
  edtContents.Font.Color := $00EB7A16;
end;

procedure TfrmHintMsg.edtContentsMouseLeave(Sender: TObject);
begin
  edtContents.Font.Color := $007C4E0C;
end;

initialization
  frmMsg := nil;
  MsgFactory := TMsgFactory.Create;
finalization
  MsgFactory.free;
end.
