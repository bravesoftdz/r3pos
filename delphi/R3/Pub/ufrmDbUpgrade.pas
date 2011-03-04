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
    RzMemo1: TRzMemo;
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

 RzMemo1.Lines.Add(Title+ ' '+ SQL);
end;

class function TfrmDbUpgrade.DbUpgrade(Factory: TCreateDbFactory;_LocalFactor:TdbFactory=nil): Boolean;
begin
  with TfrmDbUpgrade.Create(Application) do
    begin
      try
        LocalFactor := _LocalFactor;
        CreateDbFactroy := Factory;
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
  //����Ƿ񱾻�
  
  //end
  RzBitBtn4.Enabled := false;
  Screen.Cursor := crSQLWait;
  try
    CreateDbFactroy.Load(ExtractFilePath(ParamStr(0))+'dbFile.dat');
    if (LocalFactor<>nil) and (LocalFactor<>Factor) then
       begin
         sFactor := Factor;
         try
           Factor := LocalFactor;
           if CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
              CreateDbFactroy.Run;
         finally
           Factor := sFactor;
         end;
       end;
    if CreateDbFactroy.CheckVersion(CreateDbFactroy.PrgVersion) then
       CreateDbFactroy.Run;
    ForceDirectories(ExtractFilePath(ParamStr(0))+'log');
    fname := 'dbUpdate'+formatDatetime('YYYYMMDD_HHNN',now())+'.txt';
    RzMemo1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'log\'+fname);
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
       if MessageBox(Handle,'�������̴��ڴ���.�Ƿ�鿴������־��',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
          ShellExecute(handle,'open',pchar(ExtractFilePath(ParamStr(0))+'log\'+fname),nil,nil,SW_SHOWNORMAL);
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
    Caption := '��ӭʹ��'+ F.ReadString('soft','name','�õ���')+'ϵ�в�Ʒ';
  finally
    F.Free;
  end;
end;

end.
