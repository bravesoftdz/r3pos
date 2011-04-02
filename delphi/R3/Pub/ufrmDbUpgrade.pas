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
          Label1.Caption := '��ǰ���ݿ�汾:'+CreateDbFactroy.DbVersion;
        end
        else
        begin
          Label1.Caption := '��ǰ���ݿ�汾:���ݿ��ʼ��';
          RzBitBtn4.Caption := '��������';
          Label6.Caption := '����������������г���'+#13+#13+'1���������ݿ������۴������ף�'+#13+#13+'2���ر�����ݲ�ʹ�õ���۷�����';
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
           //�������ݿ�
           if fileExists(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak')) and not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak')) then Raise Exception.Create('r3.bak�ļ�����������ռ�ã����������������');
           Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak'),false);
           try
             Factor := LocalFactor;
             if CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
                CreateDbFactroy.Run;
           except
             on E:Exception do
                begin
                   LocalFactor.DisConnect;
                   if not deletefile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.db')) then Raise Exception.Create('r3.db�ļ�����������ռ�ã�������������ָ�');
                   Copyfile(pchar(ExtractFilePath(ParamStr(0))+'data\r3.bak'),pchar(ExtractFilePath(ParamStr(0))+'data\r3.db'),false);
                   LocalFactor.Connect;
                   Raise Exception.Create('����������,����:'+E.Message);
                end;
           end;
         finally
           Factor := sFactor;
         end;
       end;
    if (LocalFactor<>Factor) and CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
       begin
         Raise Exception.Create('�������İ汾���ɣ�����ϵ����Ա������̨����������ʹ�á�'); 
         //CreateDbFactroy.Run;
       end;
  finally
    Screen.Cursor := crDefault;
  end;
  if not CreateDbFactroy.HasError then
     begin
       MessageBox(Handle,'��ϲ�㣬���ݿ������ɹ���',pchar(application.Title),MB_OK+MB_ICONINFORMATION);
       self.ModalResult := MROK;
     end
  else
     begin
       MessageBox(Handle,'�������ݹ����д��ڴ���.����п��ܳ����쳣��',pchar(Application.Title),MB_OK+MB_ICONQUESTION);
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
    Caption := '��ӭʹ��'+ F.ReadString('soft','name','�������R3')+'ϵ�в�Ʒ';
  finally
    F.Free;
  end;
end;

end.
