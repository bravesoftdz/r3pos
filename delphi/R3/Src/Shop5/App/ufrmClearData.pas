unit ufrmClearData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, ExtCtrls, RzButton,
  ComCtrls, RzPanel, cxControls, cxContainer, cxEdit, cxCheckBox, RzPrgres,
  jpeg;

type
  TfrmClearData = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    btnCancel: TRzBitBtn;
    btnDelete: TRzBitBtn;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    IsBackupDataBase: TcxCheckBox;
    IsDelete: TcxCheckBox;
    ProgressBar1: TRzProgressBar;
    procedure IsBackupDataBasePropertiesChange(Sender: TObject);
    procedure IsHavePropertiesChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DeleteData;
    procedure RestoreData;
    function BackupData:Boolean;
    class function DeleteDB:Boolean;
  end;

implementation
uses uDsUtil, uGlobal, uShopGlobal, Math, StrUtils;
{$R *.dfm}

{ TfrmClearData }

function TfrmClearData.BackupData:Boolean;
var SourcePath,ObjectPath:String;
begin
  SourcePath := ExtractFilePath(Application.Name)+'Data\r3.db';
  ObjectPath := ExtractFilePath(Application.Name)+'Data\r3('+FormatDateTime('YYYY-MM-DD',Date())+').bak';
  Result := CopyFile(pchar(SourcePath),pchar(ObjectPath),False);
end;

procedure TfrmClearData.DeleteData;
var F:TextFile;
    Path,Sql_Str,Sql:String;
    VList:TStringList;
    i:Integer;
begin
  Path := ExtractFilePath(Application.ExeName)+'cleardata.txt';
  if not FileExists(Path) then Raise Exception.Create('缺少执行文件!');
  Screen.Cursor := crSQLWait;

  VList := TStringList.Create;
  try
    VList.LoadFromFile(Path);
    VList.Delimiter := ';';
    try
      Global.LocalFactory.BeginTrans();
      for i := 0 to VList.Count - 1 do
        begin
          Sql_Str := VList.Strings[i];
          if Sql_Str <> '' then
            begin
              Sql_Str := AnsiReplaceText(Sql_Str,':TENANT_ID',IntToStr(Global.TENANT_ID));
              Global.LocalFactory.ExecSQL(Sql_Str);
              Global.RemoteFactory.ExecSQL(Sql_Str);
            end;
          ProgressBar1.Percent := (i+1)*100 div VList.Count;
        end;
      Global.LocalFactory.CommitTrans;
    except
      on E:Exception do
        begin
          Global.LocalFactory.RollbackTrans;
          RestoreData;
          Screen.Cursor := crDefault;
          Raise E.Create('清除业务数据出错了,错误:'+E.Message);
        end;
    end;
  finally
    VList.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmClearData.IsBackupDataBasePropertiesChange(Sender: TObject);
begin
  inherited;
  If (IsBackupDataBase.Checked and IsDelete.Checked) then
    btnDelete.Enabled := True
  else
    btnDelete.Enabled := False;
end;

procedure TfrmClearData.IsHavePropertiesChange(Sender: TObject);
begin
  inherited;
  If (IsBackupDataBase.Checked and IsDelete.Checked) then
    btnDelete.Enabled := True
  else
    btnDelete.Enabled := False;
end;

procedure TfrmClearData.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if BackupData then
    begin
      DeleteData;
      ModalResult := mrOk;
    end
  else
    Raise Exception.Create('数据备份失败!');
end;

procedure TfrmClearData.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClearData.RestoreData;
var SourcePath,ObjectPath:String;
begin
  SourcePath := ExtractFilePath(Application.Name)+'Data\r3.db';
  ObjectPath := ExtractFilePath(Application.Name)+'Data\r3('+FormatDateTime('YYYY-MM-DD',Date())+').bak';
  CopyFile(pchar(ObjectPath),pchar(SourcePath),False);
end;

class function TfrmClearData.DeleteDB: Boolean;
begin
  with TfrmClearData.Create(Application) do
    begin
      Result := ShowModal = mrOk;
    end;
end;

end.
