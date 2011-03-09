unit ufrmDbSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, EncDec, RzButton, Registry, IniFiles,
  jpeg,rzPanel, cxSpinEdit, cxTextEdit, cxButtonEdit, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, Controls, DB, ADODB,
  ZConnection, Mask;

type
  TfrmDBSetup = class(TForm)
    BottonPanel: TPanel;
    Bevel1: TBevel;
    HsInfoPanel: TPanel;
    CoTitle0: TLabel;
    TitlePanel: TPanel;
    imgStepIcon: TImage;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    rzGroupBox: TRzGroupBox;
    lblConnMode: TLabel;
    cbConnMode: TcxComboBox;
    NbMode: TNotebook;
    lblDbType: TLabel;
    lbDBName: TLabel;
    lbDBBaseName: TLabel;
    lblUser: TLabel;
    lblUserPW: TLabel;
    cbDbType: TcxComboBox;
    edtDbName: TcxTextEdit;
    edtDatabase: TcxTextEdit;
    edtUser: TcxTextEdit;
    edtUserPw: TcxTextEdit;
    lblADOHost: TLabel;
    edtADOHost: TcxTextEdit;
    lblADOPort: TLabel;
    edtADOPort: TcxTextEdit;
    Splitter1: TSplitter;
    lblADOID: TLabel;
    sedtADODBID: TcxSpinEdit;
    lblADOType: TLabel;
    cbAdoType: TcxComboBox;
    edtDbDir: TcxButtonEdit;
    ODialog: TOpenDialog;
    lblAccountName: TLabel;
    Label4: TLabel;
    Conn: TZConnection;
    edtDBID: TcxSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtDbNameChange(Sender: TObject);
    procedure cbDbTypeChange(Sender: TObject);
    procedure trvDwdmGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbConnModePropertiesChange(Sender: TObject);
    procedure edtADOPortKeyPress(Sender: TObject; var Key: Char);
    procedure edtAdodbidKeyPress(Sender: TObject; var Key: Char);
    procedure edtDbDirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbAdoTypePropertiesChange(Sender: TObject);
  private
    FDBID: Integer;
    { Private declarations }
    procedure SetIniParams(Section,Key,Value:String);
    function GetIniParams(Section,Key:String):String;
    function GetConnStr:string;
    procedure SaveParams;
    procedure LoadParams;
    procedure TestConnect;
    procedure SetDBID(const Value: Integer);
  public
    property DBID:Integer read FDBID write SetDBID;
    class function EditDialog(Owner:TForm;Pdbid:Integer):Boolean;
    class function DeleteFun(Pdbid:Integer):Boolean;
    class function ShowDialog(Owner:TForm;Pdbid:Integer):Boolean;
  end;

implementation
var
  blnSetup: boolean;

{0	Sql Server   1	Oracle   2   SQLite-3   3  DB2   }
  {$R *.DFM}

procedure TfrmDBSetup.FormCreate(Sender: TObject);
begin
    Font.Assign(Screen.MenuFont);
    HintL.Caption := '数据库参数配置';
end;

procedure TfrmDBSetup.btnOKClick(Sender: TObject);
var
  ConnStr, DbPro: string;
begin
  Case cbConnMOde.ItemIndex of
    0:begin
      if cbDBType.Text = '' then
      begin
      Application.MessageBox('请选择一数据库类型！',Pchar(Application.Title), mb_IconError);
      Exit;
      end;
      if edtDBID.Text = '' then
      begin
      Application.MessageBox('请输入帐套名称为不重复的标识名！',Pchar(Application.Title), mb_IconError);
      Exit;
      end;
      try
        //TestConnect;
        SaveParams;
        blnSetup := true;
        ModalResult := mrOk;
        Exit;
      except
        Application.MessageBox('连接数据库错误，请确认参数是否正确！',Pchar(Application.Title),
          mb_IconError);
        edtDBName.SetFocus;
      end;
    end;
    1:begin
        if trim(edtADOHost.Text)='' then
        begin
          Application.MessageBox('请输入ADO服务器地址！',Pchar(Application.Title), mb_IconError);
          edtADOHost.SetFocus;
          Abort;
        end;
        if trim(edtADOPort.Text)='' then
        begin
          Application.MessageBox('请输入ADO服务器端口！',Pchar(Application.Title), mb_IconError);
          edtADOPort.SetFocus;
          Abort;
        end;
        SaveParams;
        blnSetup := true;
        ModalResult := mrOk;
        Exit;
      end;
  end;
end;

procedure TfrmDBSetup.edtDbNameChange(Sender: TObject);
begin
  TWinControl(Sender).Tag := 1;
end;

procedure TfrmDBSetup.cbDbTypeChange(Sender: TObject);
begin
  //cxBEdit.Visible := False;
  //cxBEdit.Clear;
  lbDBBaseName.Caption :='数据库名称：';
  if Uppercase(cbDBType.Text)='ORACLE' then
  begin
    edtDbName.Visible := True;
    edtDBDir.Visible := False;
    edtDBDir.Clear;
    lbDBName.Left :=85;
    lbDBName.Caption := '服务器SID：';
    lbDBBaseName.Caption :='连接驱动名：';
  end
  else
  if  Uppercase(cbDBType.Text)= UpperCase('Ms SQL Server') then
  begin
    lbDBName.Left :=67;
    edtDbName.Visible := True;
    edtDBDir.Visible := False;
    lbDBName.Caption :='数据库服务器：';
  end
  else
  if  Uppercase(cbDBType.Text)= UpperCase('SQLite-3') then
  begin
    lbDBName.Left :=67;
    edtDBDir.Visible := True;
    edtDbName.Visible := False;
    lbDBName.Caption :='数据库服务器：';
  end
  else
  if  Uppercase(cbDBType.Text)= 'DB2' then
  begin
    edtDBDir.Clear;
    edtDbName.Visible := True;
    edtDbDir.Visible := False;
    lbDBName.Left :=67;
    lbDBName.Caption :='DB2数据名称：';
  end
  else begin
    lbDBName.Left :=67;
    edtDbName.Visible := True;
    //cxBedit.Visible := False;
    edtDBDir.Visible := true;
    lbDBName.Caption :='数据库服务器：';
  end;
  LoadParams;
end;

procedure TfrmDBSetup.trvDwdmGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TfrmDBSetup.btnCancelClick(Sender: TObject);
begin
  blnSetup := False;
end;

procedure TfrmDBSetup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return  then  perform(CM_DialogKey,VK_TAB,0);
end;

procedure TfrmDBSetup.cbConnModePropertiesChange(Sender: TObject);
begin
  NbMode.PageIndex := cbConnMode.ItemIndex;
  case NbMOde.PageIndex of
  0:
    begin
      cbDbType.ItemIndex := 0;
      cbDBType.SetFocus;
    end;
  1:begin
      cbADOType.ItemIndex := 1;
      edtADOHost.SetFocus;
    end;
  end;
  
end;

procedure TfrmDBSetup.edtADOPortKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key  in ['0'..'9',#8]) then
     key :=#0;
end;

procedure TfrmDBSetup.edtAdodbidKeyPress(Sender: TObject; var Key: Char);
begin
  if  not (key in ['0'..'9',#8]) then
    key := #0;

end;

procedure TfrmDBSetup.edtDbDirClick(Sender: TObject);
begin
  if ODialog.Execute then
    edtDbDir.Text := ODialog.FileName ;
end;

procedure TfrmDBSetup.SetIniParams(Section, Key, Value: String);
var F:TIniFile;
    Path:String;
begin
  Path := ExtractFilePath(Application.ExeName)+'db.cfg';
  try
    F := TIniFile.Create(Path);
    F.WriteString(Section,Key,Value);
  finally
    F.Free;
  end;
end;

function TfrmDBSetup.GetIniParams(Section, Key: String): String;
var F: TIniFile;
    Path:String;
begin
  Path := ExtractFilePath(Application.ExeName)+'db.cfg';
  try
    F := TIniFile.Create(Path);
    Result := F.ReadString(Section,Key,'');
  finally
    F.Free;
  end;

end;

function TfrmDBSetup.GetConnStr: string;
var ConnStr:String;
begin
  try
    if cbConnMode.ItemIndex = 0 then
      begin
        ConnStr := 'provider='+Trim(cbDbType.Text)+';';
        if cbDbType.ItemIndex = 2 then
          ConnStr := ConnStr + 'hostname=' + Trim(edtDbDir.Text)+';'
        else
          ConnStr := ConnStr + 'hostname=' + Trim(edtDbName.Text)+';';

        ConnStr := ConnStr + 'databasename=' + Trim(edtDatabase.Text)+';';
        ConnStr := ConnStr + 'uid=' + Trim(edtUser.Text)+';';
        ConnStr := ConnStr + 'password=' + Trim(edtUserPw.Text);
      end
    else
      begin
        ConnStr := 'connmode='+IntToStr(cbAdoType.ItemIndex)+';';
        ConnStr := ConnStr + 'hostname=' + Trim(edtADOHost.Text) +';';
        ConnStr := ConnStr + 'port=' + Trim(edtADOPort.Text) + ';';
        ConnStr := ConnStr + 'dbid=' + IntToStr(DBID);
      end;
    Result := ConnStr;
  finally

  end;
end;

procedure TfrmDBSetup.TestConnect;
begin
  with Conn do
    begin
      try
        if cbConnMode.ItemIndex = 0 then
          begin
            User := Trim(edtUser.Text);
            Password := Trim(edtUserPw.Text);
            Protocol := Trim(cbDbType.Text);
            HostName := Trim(edtDbName.Text);
            if cbDbType.ItemIndex = 2 then
              HostName := Trim(edtDbDir.Text);

            Connect;
          end
        else
          begin
            Port := StrToInt(edtADOPort.Text);
          end;
      except
        Raise;
      end;
    end;
end;

procedure TfrmDBSetup.LoadParams;
var Val:String;
begin
  if cbConnMode.ItemIndex = 0 then
    begin
      if cbDbType.ItemIndex = 2 then
        edtDbDir.Text := GetIniParams('db'+IntToStr(DBID),'hostname')
      else
        edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');

      edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
      edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
      edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
      cbDbType.Text := GetIniParams('db'+IntToStr(DBID),'provider');
      //edtDBID.Text := GetIniParams('db'+IntToStr(DBID),'dbid');
    end
  else
    begin
      if GetIniParams('db','connmode') = IntToStr(cbAdoType.ItemIndex+1) then
        begin
          edtADOHost.Text := GetIniParams('db','hostname');
          edtADOPort.Text := GetIniParams('db','port');
          //sedtADODBID.Text := GetIniParams('db','dbid');
        end
      else
        begin
          edtADOHost.Text := '';
          edtADOPort.Text := '';
          //sedtADODBID.Text := '';
        end;
    end;
end;

procedure TfrmDBSetup.SaveParams;
var Pro:String;
begin
  case cbConnMode.ItemIndex of
    0:begin
      if cbDbType.ItemIndex = 2 then
        SetIniParams('db'+IntToStr(DBID),'hostname',Trim(edtDbDir.Text))
      else
        SetIniParams('db'+IntToStr(DBID),'hostname',Trim(edtDbName.Text));

      SetIniParams('db'+IntToStr(DBID),'databasename',Trim(edtDatabase.Text));
      SetIniParams('db'+IntToStr(DBID),'uid',Trim(edtUser.Text));
      SetIniParams('db'+IntToStr(DBID),'password',EncStr(Trim(edtUserPw.Text),ENC_KEY));
      case cbDbType.ItemIndex of
        0: Pro := 'mssql';
        1: Pro := 'oracle-9i';
        2: Pro := 'sqlite-3';
        3: Pro := 'ado';
      end;
      SetIniParams('db'+IntToStr(DBID),'provider',Pro);
      SetIniParams('db'+IntToStr(DBID),'dbid',IntToStr(DBID));

      SetIniParams('db'+IntToStr(DBID),'connstr',GetConnStr);
    end;
    1:Begin
      if cbAdoType.ItemIndex = 0 then
        SetIniParams('db','connmode','1')
      else
        SetIniParams('db','connmode','2');
      SetIniParams('db','hostname',Trim(edtADOHost.Text));
      SetIniParams('db','port',Trim(edtADOPort.Text));
      SetIniParams('db','dbid',IntToStr(DBID));

      SetIniParams('db','connstr',GetConnStr);
    end;
  end;
end;

procedure TfrmDBSetup.FormShow(Sender: TObject);
begin
  cbConnMode.ItemIndex := 0;
  cbDbType.ItemIndex := 0;
  LoadParams;
end;

procedure TfrmDBSetup.cbAdoTypePropertiesChange(Sender: TObject);
begin
  LoadParams;
end;

procedure TfrmDBSetup.SetDBID(const Value: Integer);
begin
  FDBID := Value;
  sedtADODBID.Text := IntToStr(DBID);
  sedtADODBID.Enabled := False;
end;


class function TfrmDBSetup.EditDialog(Owner: TForm;
  Pdbid: Integer): Boolean;
begin
  with TfrmDBSetup.Create(Owner) do
    begin
      try
        DBID := Pdbid;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

class function TfrmDBSetup.DeleteFun(Pdbid: Integer): Boolean;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'db.cfg');
  try
    if not F.SectionExists('db'+IntToStr(Pdbid)) then
      Raise Exception.Create('数据库编号'+IntToStr(Pdbid)+'不存在!');
    F.EraseSection('db'+IntToStr(Pdbid));
  finally
    F.Free;
  end;
end;

class function TfrmDBSetup.ShowDialog(Owner: TForm;
  Pdbid: Integer): Boolean;
begin
  with TfrmDBSetup.Create(Owner) do
    begin
      try
        DBID := Pdbid;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.

