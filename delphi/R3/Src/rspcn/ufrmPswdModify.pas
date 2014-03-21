unit ufrmPswdModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, AppWebUpdater, RzPanel, RzBmpBtn, RzForms, DB,
  StdCtrls, RzLabel, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  ZDataset;

type
  TfrmPswdModify = class(TfrmWebDialog)
    RzPanel72: TRzPanel;
    RzPanel73: TRzPanel;
    RzLabel46: TRzLabel;
    edtOLD_PSWD: TcxTextEdit;
    RzPanel38: TRzPanel;
    RzPanel74: TRzPanel;
    RzLabel47: TRzLabel;
    edtNEW_PSWD1: TcxTextEdit;
    RzPanel75: TRzPanel;
    RzPanel76: TRzPanel;
    RzLabel48: TRzLabel;
    edtNEW_PSWD2: TcxTextEdit;
    btnCancel: TRzBmpButton;
    edtBK_ACCOUNT: TRzPanel;
    RzPanel64: TRzPanel;
    RzLabel35: TRzLabel;
    edtACCOUNT: TcxTextEdit;
    btnChange: TRzBmpButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure edtOLD_PSWDKeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_PSWD1KeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_PSWD2KeyPress(Sender: TObject; var Key: Char);
    procedure edtACCOUNTKeyPress(Sender: TObject; var Key: Char);
  private
    FUSER_ID: string;
    FACCOUNT: string;
    procedure SetEditStyle(dbState:TDataSetState;AStyle:TcxCustomEditStyle);
    procedure SetUSER_ID(const Value: string);
    procedure SetACCOUNT(const Value: string);
  public
    class function ShowExecute(AOwner:TForm;UserId,Acc:string):boolean;
    property USER_ID:string read FUSER_ID write SetUSER_ID;
    property ACCOUNT:string read FACCOUNT write SetACCOUNT;
  end;

implementation

uses uTokenFactory,udataFactory,EncDec;

{$R *.dfm}

function GetCommStr(iDbType:integer;alias:string=''):string;
begin
  case iDbType of
  0:result := 'case when substring('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  3:result := 'case when mid('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  1,5:result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  4:result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  else
    result := '''00''';
  end;
end;

function  GetTimeStamp(iDbType:Integer):string;
begin
  case iDbType of
   0:Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
   1:Result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
   4:result := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
   5:result := 'strftime(''%s'',''now'',''localtime'')-1293840000';
   else Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;

procedure TfrmPswdModify.SetEditStyle(dbState:TDataSetState;AStyle:TcxCustomEditStyle);
begin
  if dbState = dsBrowse then
     begin
       AStyle.BorderStyle := ebsUltraFlat;
       AStyle.Color := clBtnFace;
       AStyle.Edges := [];
       AStyle.hotTrack := false;
       AStyle.ButtonTransParency := ebtHideInactive;
     end
  else
     begin
       AStyle.BorderStyle := ebsUltraFlat;
       AStyle.Color := clWhite;
       AStyle.Edges := [];
       AStyle.hotTrack := false;
       AStyle.ButtonTransParency := ebtInactive;
     end;
end;

procedure TfrmPswdModify.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmPswdModify.ShowExecute(AOwner:TForm;UserId,Acc:string):boolean;
begin
 with TfrmPswdModify.Create(AOwner) do
    begin
      try
        USER_ID := UserId;
        ACCOUNT := Acc;
        result := (ShowModal = MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmPswdModify.SetUSER_ID(const Value: string);
begin
  FUSER_ID := Value;
end;

procedure TfrmPswdModify.FormShow(Sender: TObject);
begin
  inherited;
  edtACCOUNT.Text := ACCOUNT;
  edtACCOUNT.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtACCOUNT.Style);
  edtBK_ACCOUNT.Color := edtACCOUNT.Style.Color;
  if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
end;

procedure TfrmPswdModify.SetACCOUNT(const Value: string);
begin
  FACCOUNT := Value;
end;

procedure TfrmPswdModify.btnChangeClick(Sender: TObject);
var
  str,newPswd:string;
  rs:TZQuery;
begin
  inherited;
  dataFactory.MoveToDefault;
  if edtOLD_PSWD.Text = '' then
     begin
       if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
       Raise Exception.Create('«Î ‰»Îæ…√‹¬Î...');
     end;
  if edtNEW_PSWD1.Text = '' then
     begin
       if edtNEW_PSWD1.CanFocus then edtNEW_PSWD1.SetFocus;
       Raise Exception.Create('«Î ‰»Î–¬√‹¬Î...');
     end;
  if edtNEW_PSWD2.Text = '' then
     begin
       if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
       Raise Exception.Create('«Î‘Ÿ ‰»Î“ª¥Œ...');
     end;
  if edtNEW_PSWD1.Text <> edtNEW_PSWD2.Text then
     begin
       if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
       Raise Exception.Create('¡Ω¥Œ√‹¬Î ‰»Î≤ª“ª÷¬...');
     end;

  if (lowercase(ACCOUNT)='admin') then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+token.tenantId+' and DEFINE=''PASSWRD'' ';
         dataFactory.Open(rs);
         if edtOLD_PSWD.Text <> DecStr(rs.Fields[0].AsString,ENC_KEY) then
            begin
              if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
              Raise Exception.Create('æ…√‹¬Î√‹¬Î ‰»Î¥ÌŒÛ...');
            end;
       finally
         rs.Free;
       end;
     end
  else
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select PASS_WRD from CA_USERS where TENANT_ID='+token.tenantId+' and USER_ID='''+USER_ID+''' ';
         dataFactory.Open(rs);
         if edtOLD_PSWD.Text <> DecStr(rs.Fields[0].AsString,ENC_KEY) then
            begin
              if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
              Raise Exception.Create('æ…√‹¬Î√‹¬Î ‰»Î¥ÌŒÛ...');
            end;
       finally
         rs.Free;
       end;
     end;

  newPswd := UpperCase(edtNEW_PSWD1.Text);

  if (lowercase(ACCOUNT)<>'admin') then
    str := 'update CA_USERS set PASS_WRD=''' + EncStr(newPswd,ENC_KEY) + ''',COMM=' + GetCommStr(dataFactory.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and '+
           'USER_ID=''' + USER_ID + ''''
  else
    str := 'update SYS_DEFINE set VALUE=''' + EncStr(newPswd,ENC_KEY) + ''',COMM=' + GetCommStr(dataFactory.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and '+
           'DEFINE=''PASSWRD''';

  dataFactory.ExecSQL(str);
  MessageBox(Handle,'√‹¬Î–ﬁ∏ƒ≥…π¶...','”—«ÈÃ· æ..',MB_OK);
  ModalResult := MROK;
end;

procedure TfrmPswdModify.edtACCOUNTKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
       Key := #0;
     end;
end;

procedure TfrmPswdModify.edtOLD_PSWDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtOLD_PSWD.Text) = '' then
          begin
            if edtOLD_PSWD.CanFocus then edtOLD_PSWD.SetFocus;
          end
       else
          begin
            if edtNEW_PSWD1.CanFocus then edtNEW_PSWD1.SetFocus;
          end;
       Key := #0;
     end;
end;

procedure TfrmPswdModify.edtNEW_PSWD1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtNEW_PSWD1.Text) = '' then
          begin
            if edtNEW_PSWD1.CanFocus then edtNEW_PSWD1.SetFocus;
          end
       else
          begin
            if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
          end;
       Key := #0;
     end;
end;

procedure TfrmPswdModify.edtNEW_PSWD2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtNEW_PSWD2.Text) = '' then
          begin
            if edtNEW_PSWD2.CanFocus then edtNEW_PSWD2.SetFocus;
          end
       else
          begin
            btnChange.Click;
          end;
       Key := #0;
     end;
end;

end.
