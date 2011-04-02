unit ufrmDbUpgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzLine, StdCtrls, ExtCtrls, RzPanel,udbUtil, RzEdit,
  RzPrgres, RzBckgnd,ZdbFactory;

type
  TfrmDbUpgrade = class(TForm)
    RzPanel1: TRzPanel;
    Image1: TImage;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RzBitBtn4: TRzBitBtn;
    Label2: TLabel;
    RzProgressBar1: TRzProgressBar;
    lblState: TLabel;
    RzBackground1: TRzBackground;
    Bevel2: TBevel;
    Label3: TLabel;
    RzBitBtn1: TRzBitBtn;
    procedure RzBitBtn4Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LocalFactor:TdbFactory;
    CreateDbFactroy:TCreateDbFactory;
    procedure CallBack(Title:string;SQL:string;Percent:Integer);
    class function DbUpgrade(Factory:TCreateDbFactory;_LocalFactor:TdbFactory=nil):Boolean;
  end;

implementation
uses ShellApi,uFnUtil,uGlobal,IniFiles;
{$R *.dfm}

{ TfrmDbUpgrade }

procedure TfrmDbUpgrade.CallBack(Title, SQL: string; Percent: Integer);
begin
 lblState.Caption := Title+ ' '+ SQL;
 lblState.Update;
 RzProgressBar1.Percent := Percent;

// RzMemo1.Lines.Add(Title+ ' '+ SQL);
end;

class function TfrmDbUpgrade.DbUpgrade(Factory: TCreateDbFactory;_LocalFactor:TdbFactory=nil): Boolean;
begin
  with TfrmDbUpgrade.Create(Application) do
    begin
      try
        LocalFactor := _LocalFactor;
        CreateDbFactroy := Factory;
        CreateDbFactroy.CaptureError := not FindCmdLineSwitch('DEBUG',['-','+'],false);
        CreateDbFactroy.onCreateDbCallBack := CallBack;
        if CreateDbFactroy.DbVersion<>'' then
        begin
          Label1.Caption := '当前数据库版本:'+CreateDbFactroy.DbVersion;
        end
        else
        begin
          Label1.Caption := '当前数据库版本:数据库初始化';
          RzBitBtn4.Caption := '创建账套';
          Label6.Caption := '后软件才能正常运行程序。'+#13+#13+'1、创建数据库请点击［创建账套］'+#13+#13+'2、关闭软件暂不使用点击［放弃］';
        end;
        Label2.Caption := CreateDbFactroy.PrgVersion;

        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmDbUpgrade.RzBitBtn4Click(Sender: TObject);
var
  fname:string;
  sFactor:TdbFactory;
begin
  RzBitBtn4.Enabled := false;
  Screen.Cursor := crSQLWait;
  try
    CreateDbFactroy.Load(ExtractFilePath(ParamStr(0))+'dbFile.dat');
    if (LocalFactor<>nil) then
       begin
         sFactor := Factor;
         try
           //备份数据库
           if fileExists(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak')) and not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak')) then Raise Exception.Create('r3.bak文件被其他程序占用，不能完成升级备份');
           Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak'),false);
           try
             Factor := LocalFactor;
             if CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
                CreateDbFactroy.Run;
           except
             on E:Exception do
                begin
                   LocalFactor.DisConnect;
                   if not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db')) then Raise Exception.Create('r3.db文件被其他程序占用，不能完成升级恢复');
                   Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak'),pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),false);
                   LocalFactor.Connect;
                   Raise Exception.Create('升级出错了,错误:'+E.Message);
                end;
           end;
         finally
           Factor := sFactor;
         end;
       end;
    if (LocalFactor<>Factor) and CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
       begin
         Raise Exception.Create('服务器的版本过旧，请联系管理员升级后台服务器，再使用。'); 
         //CreateDbFactroy.Run;
       end;
  finally
    Screen.Cursor := crDefault;
  end;
  if not CreateDbFactroy.HasError then
     begin
       MessageBox(Handle,'恭喜你，数据库升级成功了',pchar(application.Title),MB_OK+MB_ICONINFORMATION);
       self.ModalResult := MROK;
     end
  else
     begin
       MessageBox(Handle,'升级数据过程中存在错误.软件有可能出现异常？',pchar(Application.Title),MB_OK+MB_ICONQUESTION);
     end;
end;

procedure TfrmDbUpgrade.RzBitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDbUpgrade.FormCreate(Sender: TObject);
var F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    Caption := '欢迎使用'+ F.ReadString('soft','name','云盟软件R3')+'系列产品';
  finally
    F.Free;
  end;
end;

end.
