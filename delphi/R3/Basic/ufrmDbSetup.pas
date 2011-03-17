unit ufrmDbSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, EncDec, RzButton, Registry, IniFiles,
  jpeg,rzPanel, cxSpinEdit, cxTextEdit, cxButtonEdit, cxControls, ZdbFactory,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, Controls, DB,
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
    lblRSPHost: TLabel;
    edtRSPHost: TcxTextEdit;
    lblRSPPort: TLabel;
    edtRSPPort: TcxTextEdit;
    Splitter1: TSplitter;
    lblRSPID: TLabel;
    sedtRSPDBID: TcxSpinEdit;
    edtDbDir: TcxButtonEdit;
    ODialog: TOpenDialog;
    lblAccountName: TLabel;
    Label4: TLabel;
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
    procedure edtRSPPortKeyPress(Sender: TObject; var Key: Char);
    procedure edtRSPdbidKeyPress(Sender: TObject; var Key: Char);
    procedure edtDbDirClick(Sender: TObject);
    procedure cbRSPTypePropertiesChange(Sender: TObject);
  private
    FDBID: Integer;
    IsVisble,IsLoad:Boolean;
    { Private declarations }
    procedure EnableControl;
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
//  Font.Assign(Screen.MenuFont);
  HintL.Caption := '数据库参数配置';
  //cbConnMode.ItemIndex := 0;
end;

procedure TfrmDBSetup.btnOKClick(Sender: TObject);
var
  ConnStr, DbPro: string;
begin
  Case cbConnMOde.ItemIndex of
    0:begin
      if cbDBType.Text = '' then
      begin
      MessageBox(Handle,'请选择一数据库类型！',Pchar(Application.Title), mb_ok+mb_Iconinformation);
      Exit;
      end;
      if edtDBID.Value < 1 then
      begin
      MessageBox(Handle,'请输入不重复的数据库ID号！',Pchar(Application.Title), mb_ok+mb_Iconinformation);
      Exit;
      end;
      try
        DBID := edtDBID.Value;
        TestConnect;
        SaveParams;
        blnSetup := true;
        ModalResult := mrOk;
        Exit;
      except
        MessageBox(Handle,'连接数据库错误，请确认参数是否正确！',Pchar(Application.Title), mb_ok+mb_Iconinformation);
        edtDBName.SetFocus;
      end;
    end;
    1:begin
        if trim(edtRSPHost.Text)='' then
        begin
          MessageBox(Handle,'请输入RSP服务器地址！',Pchar(Application.Title), mb_ok+mb_Iconinformation);
          edtRSPHost.SetFocus;
          Abort;
        end;
        if trim(edtRSPPort.Text)='' then
        begin
          MessageBox(Handle,'请输入RSP服务器端口！',Pchar(Application.Title), mb_ok+mb_Iconinformation);
          edtRSPPort.SetFocus;
          Abort;
        end;
        DBID := edtDBID.Value;
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
  lbDBBaseName.Caption :='数据库名称：';
  edtDatabase.Enabled := true;
  case cbDbType.ItemIndex of
  0:
  begin
    lbDBName.Left :=67;
    edtDbName.Visible := True;
    edtDBDir.Visible := False;
    lbDBName.Caption :='数据库服务器：';
  end;
  1:
  begin
    edtDbName.Visible := True;
    edtDBDir.Visible := False;
    edtDBDir.Clear;
    lbDBName.Left :=85;
    lbDBName.Caption := '服务器SID：';
    lbDBBaseName.Caption :='连接驱动名：';
  end;
  2:
  begin
    lbDBName.Left :=67;
    edtDBDir.Visible := True;
    edtDbName.Visible := False;
    lbDBName.Caption :='数据库服务器：';
    edtDatabase.Enabled := false;
  end;
  3:
  begin
    edtDBDir.Clear;
    edtDbName.Visible := True;
    edtDbDir.Visible := False;
    lbDBName.Left :=67;
    lbDBName.Caption :='DB2数据名称：';
  end;
  else begin
    lbDBName.Left :=67;
    edtDbName.Visible := True;
    //cxBedit.Visible := False;
    edtDBDir.Visible := true;
    lbDBName.Caption :='数据库服务器：';
  end;
  end;
//  LoadParams;
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
var Pro:String;
begin
  NbMode.PageIndex := cbConnMode.ItemIndex;
  case NbMOde.PageIndex of
  0:
    begin
      if IsLoad then
        begin
          Pro := GetIniParams('db'+IntToStr(DBID),'provider');
          if Pro = 'mssql' then
            cbDbType.ItemIndex := 0
          else if Pro = 'oracle-9i' then
            cbDbType.ItemIndex := 1
          else if Pro = 'sqlite-3' then
            cbDbType.ItemIndex := 2
          else if Pro = 'RSP' then
            cbDbType.ItemIndex := 3;
        end
      else
        cbDbType.ItemIndex := 0;

      //cbDBType.SetFocus;
    end;
  end;
  
end;

procedure TfrmDBSetup.edtRSPPortKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key  in ['0'..'9',#8]) then
     key :=#0;
end;

procedure TfrmDBSetup.edtRSPdbidKeyPress(Sender: TObject; var Key: Char);
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
  vList:TStringList;
begin
  try
    if cbConnMode.ItemIndex = 0 then
      begin
        case cbDbType.ItemIndex of
          0:begin
            if Trim(edtDbName.Text) = '' then Raise Exception.Create('');
            if Trim(edtDatabase.Text) = '' then Raise Exception.Create('');
            if Trim(edtUser.Text) = '' then Raise Exception.Create('');
            if Trim(edtUserPw.Text) = '' then Raise Exception.Create('');
            ConnStr := 'provider=mssql';
            ConnStr := ConnStr + ';hostname=' + Trim(edtDbName.Text);
            ConnStr := ConnStr + ';databasename=' + Trim(edtDatabase.Text);
            ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
            ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
           end;
          1:begin
            ConnStr := 'provider=oracle-9i';
            ConnStr := ConnStr + ';hostname=' + Trim(edtDbName.Text);
            ConnStr := ConnStr + ';databasename=' + Trim(edtDatabase.Text);
            ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
            ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
           end;
          2:begin
            ConnStr := 'provider=sqlite-3';
            ConnStr := ConnStr + ';databasename=' + Trim(edtDbDir.Text);
            if Trim(edtUser.Text) <> '' then ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
            if Trim(edtUserPw.Text) <> '' then ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
           end;
          3:begin
            ConnStr := 'provider=ado';
            ConnStr := ConnStr + ';"databasename=Provider=IBMDADB2;Persist Security Info=True;Data Source='+Trim(edtDatabase.Text)+';Location='+Trim(edtDbName.Text)+'"';
            ConnStr := ConnStr + ';uid=' + Trim(edtUser.Text);
            ConnStr := ConnStr + ';password=' + Trim(edtUserPw.Text);
           end;
        end;
      end
    else
      begin
        ConnStr := 'connmode='+IntToStr(cbConnMode.ItemIndex+1);
        ConnStr := ConnStr + ';hostname=' + Trim(edtRSPHost.Text);
        ConnStr := ConnStr + ';port=' + Trim(edtRSPPort.Text);
        ConnStr := ConnStr + ';dbid=' + IntToStr(DBID);
      end;
    Result := ConnStr;
  finally

  end;
end;

procedure TfrmDBSetup.TestConnect;
var Conn:TdbFactory;
    ConString:String;
begin
  try
    ConString := GetConnStr;
    Conn := TdbFactory.Create;
    Conn.ConnMode := cbConnMode.ItemIndex + 1;
    Conn.Initialize(ConString);
    if not Conn.Connect then
      Raise Exception.Create('测试连接未通过,请检查各连接参数是否正确!');
  finally
    Conn.Free;
  end;
end;

procedure TfrmDBSetup.LoadParams;
var Pro:String;
begin
  cbConnMode.ItemIndex := 0;
  cbConnMode.Enabled := false;
  //cbConnMode.ItemIndex :=StrtoIntDef(GetIniParams('db','connmode'),1)-1;
  if cbConnMode.ItemIndex = 0 then
    begin
      Pro := GetIniParams('db'+IntToStr(DBID),'provider');
      if Pro='mssql' then cbDbType.ItemIndex := 0;
      if Pro='oracle' then cbDbType.ItemIndex := 1;
      if Pro='sqlite' then cbDbType.ItemIndex := 2;
      if Pro='db2' then cbDbType.ItemIndex := 3;
      if cbDbType.ItemIndex = 0 then
        begin
          edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
          edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
          edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
          edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
        end
      else if cbDbType.ItemIndex = 1 then
        begin
          edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
          edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
          edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
          edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
        end
      else if cbDbType.ItemIndex = 2 then
        begin
          edtDbDir.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
          edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
          edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
          edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
        end
      else if cbDbType.ItemIndex = 3 then
        begin
          edtDbName.Text := GetIniParams('db'+IntToStr(DBID),'hostname');
          edtDatabase.Text := GetIniParams('db'+IntToStr(DBID),'databasename');
          edtUser.Text := GetIniParams('db'+IntToStr(DBID),'uid');
          edtUserPw.Text := DecStr(GetIniParams('db'+IntToStr(DBID),'password'),ENC_KEY);
        end;
    end;

  if cbConnMode.ItemIndex = 1 then
  begin
    //cbConnMode.Text := 'RSPServer模式';
    //cbRSPType.Text := 'RSP Server';
    edtRSPHost.Text := GetIniParams('db','hostname');
    edtRSPPort.Text := GetIniParams('db','port');
    sedtRSPDBID.Value := GetIniParams('db','dbid');
  end;

  if IsVisble then EnableControl;

end;


procedure TfrmDBSetup.SaveParams;
var Pro:String;
begin
  SetIniParams('db','connmode',IntToStr(cbConnMode.ItemIndex+1));
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
        1: Pro := 'oracle';
        2: Pro := 'sqlite';
        3: Pro := 'db2';
      end;
      SetIniParams('db'+IntToStr(DBID),'provider',Pro);
      SetIniParams('db'+IntToStr(DBID),'dbid',IntToStr(edtDBID.Value));

      SetIniParams('db'+IntToStr(DBID),'connstr',GetConnStr);
    end;
    1:Begin
      SetIniParams('db','hostname',Trim(edtRSPHost.Text));
      SetIniParams('db','port',Trim(edtRSPPort.Text));
      SetIniParams('db','dbid',IntToStr(edtDBID.Value));

      SetIniParams('db','connstr',GetConnStr);
    end;
  end;
end;

procedure TfrmDBSetup.cbRSPTypePropertiesChange(Sender: TObject);
begin
  LoadParams;
end;

procedure TfrmDBSetup.SetDBID(const Value: Integer);
begin
  FDBID := Value;
  edtDBID.Text := IntToStr(Value);
  edtDBID.Enabled := (Value=0);
  sedtRSPDBID.Text := IntToStr(Value);
  sedtRSPDBID.Enabled := False;
end;


class function TfrmDBSetup.EditDialog(Owner: TForm;
  Pdbid: Integer): Boolean;
begin
  with TfrmDBSetup.Create(Owner) do
    begin
      try
        DBID := Pdbid;
        IsVisble := False;
        LoadParams;
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
        IsVisble := True;
        LoadParams;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmDBSetup.EnableControl;
var i: Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
    begin
      if Components[i] is TcxComboBox then
        TcxComboBox(Components[i]).Enabled := False
      else if Components[i] is TcxTextEdit then
        TcxTextEdit(Components[i]).Enabled := False
      else if Components[i] is TcxButtonEdit then
        TcxButtonEdit(Components[i]).Enabled := False;
    end;
end;

end.

