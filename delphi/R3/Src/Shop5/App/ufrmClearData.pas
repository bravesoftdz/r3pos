unit ufrmClearData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, ExtCtrls, RzButton,
  ComCtrls, RzPanel, cxControls, cxContainer, cxEdit, cxCheckBox, RzPrgres,
  jpeg,ZdbFactory;

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
    Label3: TLabel;
    Label4: TLabel;
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
    class function DeleteDB(AOwner:TForm):Boolean;
  end;

implementation
uses uDsUtil, uGlobal,uCaFactory, uShopGlobal, Math, StrUtils, Des;
{$R *.dfm}

{ TfrmClearData }

function TfrmClearData.BackupData:Boolean;
var SourcePath,ObjectPath:String;
begin
  SourcePath := ExtractFilePath(Application.Name)+'Data\r3.db';
  ObjectPath := ExtractFilePath(Application.Name)+'Data\r3.bak';
  Result := CopyFile(pchar(SourcePath),pchar(ObjectPath),False);
end;

procedure TfrmClearData.DeleteData;
procedure DoSQL(sql:string);
begin
  sql := stringreplace(sql,':TENANT_ID',inttostr(Global.TENANT_ID),[rfReplaceAll]);
  Global.LocalFactory.ExecSQL(sql);
  if CaFactory.Audited then Global.RemoteFactory.ExecSQL(sql);
end;
var
  F:TextFile;
  FileName,s:String;
  SQL:TStringList;
  i,CurSize,TotalSize:Integer;
begin
  FileName := ExtractFilePath(Application.ExeName)+'Clear.dat';
  if not FileExists(FileName) then Raise Exception.Create('系统没找到清理脚本，无法执行清理工作!');
  copyfile(pchar(FileName),pchar(FileName+'~'),false);
  des.DecryFile(FileName+'~',DES_KEY);
  SQL := TStringList.Create;
  Assignfile(F,FileName+'~');
  try
    reset(f);
    try
       Global.LocalFactory.BeginTrans();
       TotalSize := FileSize(F)*1024 div 8;
       if TotalSize=0 then TotalSize := 1;
       CurSize := 0;
       while not eof(f) do
       begin
         readln(f,s);
         CurSize := CurSize + length(s);
         s := trim(s);
         if s='' then Continue;
         if copy(s,1,2)='--' then Continue;
         if (s[length(s)]=';') then
            begin
              if (s[length(s)]=';') then
                 begin
                   delete(s,length(s),1);
                   SQL.Add(s);
                 end;
              if (SQL.Count>0) then
                 begin
                   DoSQL(SQL.Text);
                 end;
              SQL.Clear;
            end
         else
            begin
              if copy(s,1,2)<>'--' then
                 SQL.Add(s);
            end;
         ProgressBar1.Percent := CurSize*100 div TotalSize;
       end;
       if (SQL.Count>0) then
          begin
            DoSQL(SQL.Text);
            SQL.Clear;
          end;
       Global.LocalFactory.CommitTrans;
    except
      on E:Exception do
        begin
          Global.LocalFactory.RollbackTrans;
          RestoreData;
          Raise E.Create('清除业务数据出错了,错误:'+E.Message);
        end;
    end;
  finally
    SQL.Free;
    closefile(f);
    deletefile(FileName+'~');
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
var sFactor:TdbFactory;
begin
  inherited;
  sFactor := Factor;
  try
     if CaFactory.Audited and not Global.RemoteFactory.Connected then
     begin
       Global.MoveToRemate;
       try
         Global.Connect;
       except
         Raise Exception.Create('连接远程数据库失败，无法完成数据清理工作。'); 
       end;
     end;
  finally
    uGlobal.Factor := sFactor;
  end;
  if BackupData then
    begin
      DeleteData;
      ModalResult := mrOk;
    end
  else
    Raise Exception.Create('数据备份失败无法完成数据清理，请重进系统后重试!');
end;

procedure TfrmClearData.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClearData.RestoreData;
var SourcePath,ObjectPath:String;
begin
  Global.LocalFactory.DisConnect;
  try
    SourcePath := ExtractFilePath(Application.Name)+'Data\r3.db';
    ObjectPath := ExtractFilePath(Application.Name)+'Data\r3.bak';
    if not CopyFile(pchar(ObjectPath),pchar(SourcePath),False) then Raise Exception.Create('还原数据失败');
  finally
    Global.LocalFactory.Connect;
  end;
end;

class function TfrmClearData.DeleteDB(AOwner:TForm): Boolean;
begin
  with TfrmClearData.Create(AOwner) do
    begin
      try
        Result := (ShowModal = mrOk);
      finally
        Free;
      end;
    end;
end;

end.
