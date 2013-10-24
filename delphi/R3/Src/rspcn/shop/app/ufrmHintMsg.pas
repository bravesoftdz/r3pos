unit ufrmHintMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBHints, ExtCtrls, RzForms, RzPanel, StdCtrls, RzLabel, jpeg ,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RzBckgnd, RzBmpBtn;

type
  PMsgInfo=^TMsgInfo;
  TMsgInfo=record
    ID:string;
    Title:string;
    Contents:String;
    SndDate:string;
    Rdd:boolean;
    Msg_Class:Integer;
    sFlag:integer;
    SenceId:string;
    Action:string;
  end;

  TMsgFactory=class
  private
    FList:TList;
    FMsgInfo:PMsgInfo;
    FLoaded: Boolean;
    FShowing: Boolean;
    FUnRead: Integer;
    FThreadLock:TRTLCriticalSection;
    FOpened: boolean;
    function  GetCount: integer;
    function  GetMsgInfo(itemindex: integer): PMsgInfo;
    procedure SetLoaded(const Value: Boolean);
    procedure SetShowing(const Value: Boolean);
    procedure SetUnRead(const Value: Integer);
    function  GetMsgRead(Msg: PMsgInfo): boolean;
    procedure SetMsgRead(Msg: PMsgInfo; const Value: boolean);
    procedure SetOpened(const Value: boolean);
    function  ReadMsg:PMsgInfo;
    
    procedure Enter;
    procedure Leave;
    procedure Clear;
  public
    constructor Create;
    destructor  Destroy; override;
    function  EncodeSQL:String;
    function  Load:Boolean;
    procedure Add(MsgInfo:PMsgInfo);
    procedure ShowMsg(MsgInfo:PMsgInfo);
    procedure HintMsg(MsgInfo:PMsgInfo);
    procedure ClearType(C_Type:Integer);
    function  FindMsg(ID:string):PMsgInfo;
    procedure GetUnRead;
    procedure ShowHintMsg;
    property  MsgInfo[itemindex:integer]:PMsgInfo read GetMsgInfo;
    property  Count:integer read GetCount;
    property  Info:PMsgInfo read FMsgInfo;
    property  Loaded:Boolean read FLoaded write SetLoaded;
    property  Showing:Boolean read FShowing write SetShowing;
    property  UnRead:Integer read FUnRead write SetUnRead;
    property  MsgRead[Msg:PMsgInfo]:boolean read GetMsgRead write SetMsgRead;
    property  Opened:boolean read FOpened write SetOpened;
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
    knowCheckBox: TCheckBox;
    procedure rzMsgClick(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure labTitleMouseEnter(Sender: TObject);
    procedure labTitleMouseLeave(Sender: TObject);
    procedure edtContentsMouseEnter(Sender: TObject);
    procedure edtContentsMouseLeave(Sender: TObject);
  public
    MsgInfo:PMsgInfo;
    class procedure ShowInfo(Msg:PMsgInfo);
  end;

var MsgFactory:TMsgFactory;

var frmMsg:TfrmHintMsg;

implementation

uses uTokenFactory,udllGlobal,ZLogFile,udataFactory,ObjCommon,ufrmNewPaperReader;

{$R *.dfm}

procedure TMsgFactory.Add(MsgInfo: PMsgInfo);
begin
  Enter;
  try
    FList.Add(MsgInfo);
  finally
    Leave;
  end;
end;

procedure TMsgFactory.Clear;
var i:integer;
begin
//  Enter;
  try
    for i:=FList.Count -1 downto 0 do
      begin
        Dispose(FList[i]);
      end;
    FList.Clear;
  finally
//    Enter;
  end;
end;

constructor TMsgFactory.Create;
begin
  inherited;
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
  FMsgInfo := nil;
  Opened := false;
end;

destructor TMsgFactory.Destroy;
begin
  Clear;
  FList.Free;
  DeleteCriticalSection(FThreadLock);
  inherited;
end;

function TMsgFactory.EncodeSQL: String;
var Str_Sql,Str_where:String;
begin
  Str_where := ' and a.END_DATE >= '+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
  Str_where := Str_where + ' and b.SHOP_ID=' + QuotedStr(token.shopId)+ ' and b.MSG_READ_STATUS=1 ';
  Str_Sql :=
  ' select a.MSG_ID,a.MSG_TITLE,a.MSG_CONTENT,a.ISSUE_DATE,a.MSG_CLASS,a.MSG_SOURCE from MSC_MESSAGE a left join MSC_MESSAGE_LIST b on a.TENANT_ID=b.TENANT_ID and a.MSG_ID=b.MSG_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+token.tenantId+Str_where+' order by a.ISSUE_DATE desc';
  result := Str_Sql;
end;

function TMsgFactory.FindMsg(ID: string): PMsgInfo;
var i:integer;
begin
  result := nil;
  Enter;
  try
  for i:=0 to FList.Count -1 do
    begin
      if PMsgInfo(FList[i]).ID = ID then
         begin
           result := PMsgInfo(FList[i]);
           Exit;
         end;
    end;
  finally
    Leave;
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
var
  rs:TZQuery;
  MsgInfo:PMsgInfo;
begin
  try
    rs := TZQuery.Create(nil);
    Enter;
    try
      rs.SQL.Text := EncodeSQL;
      dataFactory.Open(rs);
      Clear;
      rs.First;
      while not rs.Eof do
      begin
        new(MsgInfo);
        MsgInfo^.ID := rs.Fields[0].AsString;
        MsgInfo^.Title := rs.Fields[1].AsString;
        MsgInfo^.Contents := rs.Fields[2].AsString;
        MsgInfo^.SndDate := rs.Fields[3].AsString;
        MsgInfo^.Rdd := false;
        MsgInfo^.Msg_Class := StrToIntDef(rs.Fields[4].AsString,0);
        MsgInfo^.sFlag := 0;
        FList.Add(MsgInfo);
        rs.Next;
      end;
    finally
      rs.free;
      Leave;
    end;
    Loaded := true;
  except
    on E:Exception do
       begin
         Loaded := true;
         LogFile.AddLogFile(0,'LoadMsg����:'+E.Message);
       end;
  end;
end;

function TMsgFactory.ReadMsg: PMsgInfo;
var i:integer;
begin
  result := nil;
  if Showing then Exit;
  for i:=count - 1 downto 0 do
    begin
      if not MsgInfo[i]^.Rdd then
         begin
           result := MsgInfo[i];
           Opened := false;
           Exit;
         end;
    end;
end;

procedure TMsgFactory.SetUnRead(const Value: Integer);
begin
  FUnRead := Value;
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
  TfrmNewPaperReader.ShowNewsPaper(MsgInfo^.ID,MsgInfo^.Msg_Class,MsgInfo^.sFlag);
end;

class procedure TfrmHintMsg.ShowInfo(Msg: PMsgInfo);
var Contents_M:WideString;
begin
  if frmMsg=nil then frmMsg := TfrmHintMsg.Create(nil);
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
  case Msg^.Msg_Class of
    0:frmMsg.labType.Caption := '������Ϣ';
    1:frmMsg.labType.Caption := '���¹���';
    2:frmMsg.labType.Caption := '��������';
    3:frmMsg.labType.Caption := '���¹��';
    4:frmMsg.labType.Caption := '��������';
  end;
  frmMsg.knowCheckBox.Checked := false;
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
var ExcSql:String;
begin
  if knowCheckBox.Checked then
    begin
      ExcSql :=
        ' update MSC_MESSAGE_LIST set READ_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS',now()))+',READ_USER='+QuotedStr(token.userId)+',MSG_READ_STATUS=2,MSG_FEEDBACK_STATUS=1,COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' '+
        ' where TENANT_ID='+token.tenantId+' and SHOP_ID='+QuotedStr(token.shopId)+' and MSG_ID='+QuotedStr(MsgInfo.ID);
      try
        if dataFactory.ExecSQL(ExcSql) > 0 then
           MsgFactory.MsgRead[MsgFactory.FindMsg(MsgInfo.ID)] := True;
      except
        on E:Exception do
           Raise Exception.Create('����'+E.Message);
      end;
    end;
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

procedure TMsgFactory.GetUnRead;
var i:Integer;
begin
  UnRead := 0;
  Enter;
  try
    for i := 0 to FList.Count - 1 do
    begin
      if not PMsgInfo(FList[i]).Rdd then
         UnRead := UnRead + 1;
    end;
  finally
    Leave;
  end;
end;

function TMsgFactory.GetMsgRead(Msg: PMsgInfo): boolean;
begin
  result := Msg.Rdd;
end;

procedure TMsgFactory.SetMsgRead(Msg: PMsgInfo; const Value: boolean);
begin
  if Msg <> nil then
     begin
       Msg.Rdd := Value;
       GetUnRead;
     end;
end;

procedure TMsgFactory.ClearType(C_Type: Integer);
var i:integer;
begin
  Enter;
  try
    for i:=FList.Count -1 downto 0 do
    begin
      if PMsgInfo(FList[i]).Msg_Class = C_Type then
         begin
           Dispose(FList[i]);
           FList.Delete(i);
         end;
    end;
  finally
    Leave;
  end;
  GetUnRead;
end;

procedure TMsgFactory.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TMsgFactory.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TMsgFactory.SetOpened(const Value: boolean);
begin
  FOpened := Value;
end;

procedure TMsgFactory.ShowHintMsg;
var P:PMsgInfo;
begin
  Enter;
  try
    P := MsgFactory.ReadMsg;
    if P <> nil then MsgFactory.HintMsg(P);
  finally
    Leave;
  end;
end;

initialization
  frmMsg := nil;
  MsgFactory := TMsgFactory.Create;
finalization
  if Assigned(frmMsg) then FreeAndNil(frmMsg);
  if Assigned(MsgFactory) then FreeAndNil(MsgFactory);
end.
