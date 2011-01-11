unit ufrmShopMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, StdCtrls, jpeg,
  RzBmpBtn, RzLabel, RzBckgnd, Buttons, RzPanel, ufrmBasic, ToolWin,
  RzButton, ZBase, MultInst, ufrmInstall, RzStatus, RzTray, ShellApi, ZdbFactory,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalc, ObjCommon,RzGroupBar,ZDataSet, ImgList, RzTabs;
const
  WM_LOGIN_REQUEST=WM_USER+10;
type
  TfrmShopMain = class(TfrmMain)
    mnuWindow: TMenuItem;
    Panel5: TPanel;
    Image3: TImage;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    fdsfds1: TMenuItem;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel4: TPanel;
    rzLeft: TRzPanel;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N49: TMenuItem;
    N51: TMenuItem;
    N48: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    lblUserInfo: TRzLabel;
    N59: TMenuItem;
    N60: TMenuItem;
    N55: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N78: TMenuItem;
    RzVersionInfo: TRzVersionInfo;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    Timer1: TTimer;
    N83: TMenuItem;
    N84: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N91: TMenuItem;
    N92: TMenuItem;
    N50: TMenuItem;
    N93: TMenuItem;
    N23: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N73: TMenuItem;
    N85: TMenuItem;
    N94: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    N99: TMenuItem;
    N90: TMenuItem;
    N22: TMenuItem;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    Image5: TImage;
    Image6: TImage;
    Panel2: TPanel;
    Panel6: TPanel;
    Image7: TImage;
    Image8: TImage;
    Image4: TImage;
    Label1: TLabel;
    rzToolButton: TPanel;
    Image1: TImage;
    Image10: TImage;
    Panel3: TPanel;
    Image9: TImage;
    Label2: TLabel;
    toolButton: TRzBmpButton;
    Panel7: TPanel;
    Image11: TImage;
    Panel8: TPanel;
    Image12: TImage;
    Image14: TImage;
    Panel10: TPanel;
    Image2: TImage;
    Image13: TImage;
    Panel11: TPanel;
    Label3: TLabel;
    RzBmpButton8: TRzBmpButton;
    RzBmpButton9: TRzBmpButton;
    RzBmpButton10: TRzBmpButton;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    ImageList1: TImageList;
    Panel9: TPanel;
    Image19: TImage;
    RzTab: TRzTabControl;
    RzGroupBar1: TRzGroupBar;
    Image18: TImage;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    lblLogin: TLabel;
    ImageList2: TImageList;
    procedure FormActivate(Sender: TObject);
    procedure fdsfds1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N68Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N90Click(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure RzBmpButton10Click(Sender: TObject);
    procedure RzBmpButton8Click(Sender: TObject);
    procedure RzTabChange(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure RzBmpButton9Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
  private
    { Private declarations }
    FList:TList;
    FLogined: boolean;
    frmInstall:TfrmInstall;
    FLoging: boolean;
    FSystemShutdown: boolean;
    procedure DoActiveForm(Sender:TObject);
    procedure DoFreeForm(Sender:TObject);
    procedure DoActiveChange(Sender:TObject);
    procedure SortToolButton;
    procedure WMQUERYENDSESSION(var msg:Tmessage);Message  WM_QUERYENDSESSION;
    procedure wm_Login(var Message: TMessage); message WM_LOGIN_REQUEST;
    procedure wm_desktop(var Message: TMessage); message WM_DESKTOP_REQUEST;
    procedure SetLogined(const Value: boolean);
    function  CheckVersion:boolean;
    function  UpdateDbVersion:boolean;
    procedure SetLoging(const Value: boolean);
    procedure SetSystemShutdown(const Value: boolean);
    procedure actfrmLockScreenExecute(Sender: TObject);
  public
    { Publicdeclarations }
    procedure LoadMenu;
    procedure LoadFrame;
    procedure InitVersioin;
    function GetDeskFlag:string;
    procedure CheckRegister;
    procedure CheckEnabled;
    procedure DoConnectError(Sender:TObject);
    function Login(Locked:boolean=false):boolean;
    procedure AddFrom(form:TForm);
    procedure RemoveFrom(form:TForm);
    property Logined:boolean read FLogined write SetLogined;
    property Loging:boolean read FLoging write SetLoging;
    property SystemShutdown:boolean read FSystemShutdown write SetSystemShutdown;    
  end;

var
  frmShopMain: TfrmShopMain;

implementation
uses
  uFnUtil,ufrmShopDesk, ufrmDbUpgrade, uShopGlobal, udbUtil, uGlobal, IniFiles, ufrmLogo, ufrmLogin,
  ufrmDesk,ufrmPswModify;
{$R *.dfm}

procedure TfrmShopMain.FormActivate(Sender: TObject);
begin
  inherited;
//  if not systemShutdown and not Application.Terminated then WindowState := wsMaximized;
end;

procedure TfrmShopMain.fdsfds1Click(Sender: TObject);
begin
  inherited;
  self.Cascade;
end;


procedure TfrmShopMain.FormCreate(Sender: TObject);
var F:TextFile;
begin
  inherited;
  SystemShutdown := false;
  Loging :=false;
  frmInstall := TfrmInstall.Create(self);
  FList := TList.Create;
  screen.OnActiveFormChange := DoActiveChange;
  AssignFile(F,ExtractFilePath(ParamStr(0))+'hook.cfg');
  rewrite(f);
  try
    writeln(f,handle);
    writeln(f,WM_DESKTOP_REQUEST);
  finally
    closefile(f);
  end;
  RzVersionInfo.FilePath := ParamStr(0);
  LoadFrame;
end;

procedure TfrmShopMain.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  if frmInstall<>nil then frmInstall.free;
  screen.OnActiveFormChange := nil;
  for i:=0 to FList.Count - 1 do TObject(FList[i]).Free;
  inherited;
  FList.Free;
end;

procedure TfrmShopMain.AddFrom(form: TForm);
var
  button:TrzBmpButton;
begin
  if FList.Count > 5 then Exit;
  button := TrzBmpButton.Create(rzToolButton);
  button.GroupIndex := 1;
  button.Bitmaps.Up.Assign(toolButton.Bitmaps.Up);
  button.Bitmaps.Down.Assign(toolButton.Bitmaps.Down);
  button.Font.Assign(toolButton.Font); 
  button.Caption := form.Caption;
  button.Tag := Integer(Pointer(form));
  button.OnClick := DoActiveForm;
  button.Visible := true;
  button.Parent := rzToolButton;
  FList.Add(button);
  SortToolButton;
  button.Down := true;
  TfrmBasic(Form).OnFreeForm := DoFreeForm;
end;

procedure TfrmShopMain.RemoveFrom(form: TForm);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if integer(FList[i])=integer(pointer(form)) then
         begin
           TObject(FList[i]).Free;
           FList.Delete(i);
           break;
         end;
    end;
  SortToolButton;
end;

procedure TfrmShopMain.DoActiveForm(Sender: TObject);
begin
  TForm(TrzBmpButton(Sender).tag).WindowState := wsMaximized;
  TForm(TrzBmpButton(Sender).tag).BringToFront;
  TrzBmpButton(Sender).Down := true;
end;

procedure TfrmShopMain.SortToolButton;
var
  i:Integer;
  button:TrzBmpButton;
begin
  for i:=0 to FList.Count -1 do
    begin
      button := TrzBmpButton(FList[i]);
      button.Top := 9;
      button.Left := i*(button.Width+1)+rzLeft.Width+150;
    end;
end;

procedure TfrmShopMain.DoActiveChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(screen.ActiveForm)) then
         begin
           TrzBmpButton(FList[i]).Down := true;
           break;
         end;
    end;
end;

procedure TfrmShopMain.DoFreeForm(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TrzBmpButton(FList[i]).tag=integer(pointer(Sender)) then
         begin
           TrzBmpButton(FList[i]).Tag := 0;
           TObject(FList[i]).Free;
           FList.Delete(i);
           break;
         end;
    end;
end;

function TfrmShopMain.CheckVersion:boolean;
var
  F:TIniFile;
  frmLogo:TfrmLogo;
  myComVersion:string;
begin
{  result := false;
  if frmInstall=nil then Exit;
  if ShopGlobal.offline then Exit;
  frmLogo := TfrmLogo.Create(self);
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frame\web.cfg');
  try
    frmLogo.Show;
    frmInstall.SysId := 'okly';
    frmInstall.Path := ExtractFilePath(ParamStr(0));
    frmInstall.Url := F.ReadString('update','url','http://www.okonly.net/update');
    frmInstall.LoadVersionFile;
    if frmInstall.DownLoadControlFile then
       begin
          frmInstall.LoadControlFile;
          if frmInstall.CompareVersion(frmInstall.NewVersion,frmInstall.CurVersion) then
             begin
               myComVersion := Factor.ExecProc('TGetComVersion');
               frmLogo.Close;
               frmInstall.Close;
               if (frmInstall.flag=1) then //服务器
                 begin
                    if (MessageBox(Handle,pchar('软件检测到新版本:'+frmInstall.NewVersion+',是否立即下载?'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then
                       begin
                         Exit;
                       end;
                 end
               else
                 begin
                   if (Factor.LoginParam.ConnMode = 2) then
                      begin
                        if frmInstall.CompareVersion(frmInstall.ComVersion,myComVersion) then
                           begin
                             MessageBox(Handle,pchar('软件检测到新版本:'+frmInstall.NewVersion+'，请把服务器升级到最新版本...'),'友情提示...',MB_OK+MB_ICONINFORMATION);
                             Exit;
                           end
                      end
                   else
                      begin
                        if (frmInstall.ComVersion<>myComVersion) and (MessageBox(Handle,pchar('软件检测到新版本:'+frmInstall.NewVersion+',是否立即下载?'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then
                           begin
                             Exit;
                           end;
                      end;
                  end;
               frmInstall.Show;
               frmInstall.Update;
               ForceDirectories(frmInstall.Path);//目录不存在时自动建目录
               if frmInstall.CompareVersion(frmInstall.NewVersion,frmInstall.CurVersion) then
               begin
                  frmInstall.cxbtnCancel.Caption := '隐藏';
                  frmInstall.cxbtnCancel.Enabled := false;
                  if frmInstall.DownFiles then
                     begin
                       frmInstall.BringToFront;
                       frmInstall.InstallType := 1;
                       frmInstall.btnInstall.OnClick(nil);
                       result := true;
                       Exit;
                     end;
               end;
             end;
       end;
    frmInstall.Close;
  finally
    Sleep(2000);
    frmLogo.free;
    F.free;
  end;  }
end;
function TfrmShopMain.Login(Locked:boolean=false):boolean;
var
  Params:ufrmLogin.TLoginParam;
  lDate:TDate;
  AObj:TRecord_;
begin
  Logined := false;
  Logined := TfrmLogin.doLogin(SysId,Locked,Params,lDate);
  result := Logined;
  if Locked then Exit;
  if Logined then
     begin
       if Params.RemoteConnnect and not ShopGlobal.offline then
          begin
            if CheckVersion then Exit;
          end;
       Loging := false;
       Global.CompanyID := Params.CompanyID;
       Global.CompanyName := Params.CompanyName;
       Global.UserID := Params.UserID;
       Global.UserName := Params.UserName;
       Global.CloseAll;
       Global.SysDate := lDate;

//       if not UpdateDbVersion then
//         begin
//           Application.Terminate;
//           Exit;
//         end;
//       if Params.RemoteConnnect then //连不上远程服务器时，不同步数据
//          TfrmSyncMain.Login(self)
//       else
//          Global.LoadBasic();
//       ShopGlobal.LoadRight;
{       if (Global.CompanyName = '初始登录') and (Global.UserId='admin') then
          begin
            AObj := TRecord_.Create;
            try
              if TfrmCompanyInfo.EditDialog(self,Global.CompanyID,AObj) then
                 Global.CompanyName := AObj.FieldbyName('COMP_NAME').AsString;
            finally
              AObj.Free;
            end;
          end;
       CheckRegister;
       InitVersioin;
       CheckEnabled;
       LoadMenu;
       Factor.ExecProc('TGetXDictInfo');
       MsgFactory.Load;
       Timer1.OnTimer(nil);
       if not Locked and (DevFactory.ReadDefine('AUTORUNPOS','0')='1') and ShopGlobal.GetChkRight('500028')
       then
       begin
          PostMessage(Handle,WM_DESKTOP_REQUEST,500054,0);
          //actfrmPosMainExecute(nil);
       end;    }
     end
  else
     begin
       Logined := false;
       result := Logined;
       Application.Terminate;
     end;
//  Label1.Caption := '使用权:'+ShopGlobal.GetCOMP_NAME;
  lblLogin.Caption := '登录用户:'+Global.UserName+'  登录门店:'+Global.CompanyName;
end;

procedure TfrmShopMain.wm_Login(var Message: TMessage);
var prm:string;
begin
  if Logined then Exit;
  try
    Logined := Login(false);
  finally
    if not Application.Terminated then
    begin
       if not frmShopMain.Visible then
       begin
         frmShopMain.Show;
         frmShopMain.WindowState := wsMaximized;
       end;    
    end;
  end;
end;

procedure TfrmShopMain.SetLogined(const Value: boolean);
var s:string;
begin
  FLogined := Value;
  Timer1.Enabled := Value;
  if ShopGlobal.offline then s := '【脱机使用】' else s := '【联机使用】';
  if Value then
     lblUserInfo.Caption := s+' 欢迎您:'+Global.UserName+' 登录门店：'+Global.CompanyName+''
  else
     lblUserInfo.Caption := '未登录...请先登录系统后才能使用';
end;

procedure TfrmShopMain.miCloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmShopMain.FormShow(Sender: TObject);
begin
  inherited;
  UpdateTimer.Enabled := true;
end;

procedure TfrmShopMain.actfrmLockScreenExecute(Sender: TObject);
begin
  inherited;
  frmShopDesk.HookLocked := true;
  try
    Login(true);
  finally
    frmShopDesk.HookLocked := false;
  end;
end;

procedure TfrmShopMain.CheckEnabled;
var i:integer;
begin
  for i:=0 to actList.ActionCount -1 do
    begin
      if TAction(actList.Actions[i]).Tag > 0 then
      TAction(actList.Actions[i]).Enabled := ShopGlobal.GetChkRight(inttostr(TAction(actList.Actions[i]).tag));
    end;
end;

procedure TfrmShopMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not SystemShutdown and (MessageBox(Handle,'是否退出系统？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6) then
     begin
       CanClose := false;
       //Application.Minimize;
     end;
end;

procedure TfrmShopMain.N68Click(Sender: TObject);
begin
  inherited;
  Application.Restore;
end;

procedure TfrmShopMain.wm_desktop(var Message: TMessage);
var
  i:integer;
begin
  if not Logined then
     begin
       PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,0,0);
       Exit;
     end;
  for i:=0 to actList.ActionCount -1 do
    begin
      if actList.Actions[i].Tag = Message.WParam then
         begin
           actList.Actions[i].OnExecute(nil);
           Exit;
         end;
    end;   
end;

procedure TfrmShopMain.WMQUERYENDSESSION(var msg: Tmessage);
begin
  SystemShutdown := true;
  if frmInstall<>nil then FreeAndNil(frmInstall);
  Factor.DisConnect;
  inherited;
end;

function TfrmShopMain.UpdateDbVersion: boolean;
var
  Factory:TCreateDbFactory;
begin
  result := true;
  Factory := TCreateDbFactory.Create;
  try
    if Factory.CheckVersion(DBVersion) then
       result := TfrmDbUpgrade.DbUpgrade(Factory,uGlobal.Factor);
  finally
    Factory.Free;
  end;
end;

procedure TfrmShopMain.CheckRegister;
begin
//procedure DecodeVersion(sn:string);
//var
//  SID,VER,CpuID:string;
{  UID,CID:integer;
  F:TIniFile;
begin
  if trim(sn)='' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frame\web.cfg');
       try
         CLVersion := F.ReadString('soft','version','OHR');
       finally
         F.free;
       end;
       Exit;
     end;
  if not DecodeSerialNo(sn,SID,VER,UID,CID) then
     Raise Exception.Create('系列号无效');
  CLVersion := VER;
end;
function IsLimit:boolean;
var
  F:TIniFile;
begin
   F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frame\web.cfg');
   try
     ShopGlobal.okline := F.ReadString('soft','limit','')='ok_';
     result := not ShopGlobal.okline;
   finally
     F.free;
   end;
end;
var sn,prm:string;
begin
  try
     if TfrmRegister.CheckRegister(Global.CompanyID,sn,IsLimit) then
        begin
          DecodeVersion(sn);
        end
     else
        begin
          if IsLimit then Application.Terminate
          else
             begin
               ShopGlobal.Limit := 30;
               Application.Title := Application.Title + '   友情提示：剩余体验天数'+inttostr(ShopGlobal.Limit)+'天';
               DecodeVersion(sn);
             end;
        end;
  except
    Application.Terminate;
  end;     }
end;

procedure TfrmShopMain.Timer1Timer(Sender: TObject);
//var P:PMsgInfo;
begin
  inherited;
//  if SystemShutdown then Exit;
//  if not Logined then Exit;
//  if not Visible then Exit;
//  P := MsgFactory.ReadMsg;
//  if P<>nil then MsgFactory.HintMsg(P);
end;

procedure TfrmShopMain.LoadFrame;
var F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frame\web.cfg');
  try
    Caption := F.ReadString('soft','name','好店铺')+' 版本:'+RzVersionInfo.FileVersion;
    Application.Title := F.ReadString('soft','name','好店铺');
    SFVersion := F.ReadString('soft','SFVersion','.NET');
  finally
    F.Free;
  end;
  if FileExists(ExtractFilePath(ParamStr(0))+'frame\logo_lt.jpg') then
    Image4.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'frame\logo_lt.jpg');

//  Label4.Caption := '版本:'+RzVersionInfo.FileVersion;
end;

procedure TfrmShopMain.SetLoging(const Value: boolean);
begin
  FLoging := Value;
end;

procedure TfrmShopMain.SetSystemShutdown(const Value: boolean);
begin
  FSystemShutdown := Value;
end;

procedure TfrmShopMain.InitVersioin;
begin

end;

procedure TfrmShopMain.N90Click(Sender: TObject);
var
  HWndCalculator : HWnd;
begin
  // 查找已存在的计算器窗口
  HWndCalculator :=FindWindow(nil, '计算器');
  if HWndCalculator <> 0 then SendMessage(HWndCalculator, WM_CLOSE, 0, 0);// close the exist Calculator
  ShellExecute(Handle,'open','calc.exe',nil,nil,SW_SHOW);

end;

procedure TfrmShopMain.UpdateTimerTimer(Sender: TObject);
begin
  inherited;
  Label2.Caption := '当前时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
end;

procedure TfrmShopMain.RzBmpButton10Click(Sender: TObject);
begin
  inherited;
  TfrmPswModify.ShowExecute(Global.UserId,Global.UserName);

end;

procedure TfrmShopMain.LoadMenu;
function FindAction(cName:string):TAction;
var i:integer;
begin
  result := nil;
  for i:=0 to actList.ActionCount-1 do
    begin
      if (lowercase(actList.Actions[i].Name)=lowercase(cName)) and TAction(actList.Actions[i]).Enabled then
         begin
           result := TAction(actList.Actions[i]);
           break;
         end;
    end;
end;
var
  rs:TZQuery;
  g:TrzGroup;
  b:TrzGroupItem;
  i,r:integer;
begin
  for i:=RzGroupBar1.GroupCount -1 downto 0 do
    begin
      RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
    end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select MODU_ID,MODU_NAME,ACTION_NAME,len(LEVEL_ID)/3 as LEVEL from CA_MODULE where len(LEVEL_ID)<=6 and COMM not in (''02'',''12'') and MENU_GROUP='''+trim(RzTab.Tabs[RzTab.TabIndex].Caption)+''' order by LEVEL_ID';
    Factor.Open(rs); 
    rs.First;
    while not rs.Eof do
      begin
        if rs.FieldbyName('LEVEL').AsInteger =1 then
           begin
             g := TrzGroup.Create(RzGroupBar1);
             g.Caption := rs.FieldbyName('MODU_NAME').AsString;
             g.CaptionColor := $00E4D2AD;
             g.CaptionHeight := 25;
             g.DividerVisible := true;
             RzGroupBar1.AddGroup(g);
             inc(r);
             if r>3 then g.Close;
           end
        else
           begin
             if FindAction(rs.FieldbyName('ACTION_NAME').AsString)<>nil then
             begin
               b := g.Items.Add;
               b.Caption := rs.FieldbyName('MODU_NAME').AsString;
               b.Action := FindAction(rs.FieldbyName('ACTION_NAME').AsString);
               TAction(b.Action).Caption := rs.FieldbyName('MODU_NAME').AsString;
               b.ImageIndex := 0;
             end;
           end;
        rs.Next;
      end;
    for i:=RzGroupBar1.GroupCount -1 downto 0 do
      begin
        if RzGroupBar1.Groups[i].Items.Count =0 then
           RzGroupBar1.RemoveGroup(RzGroupBar1.Groups[i]);
      end;
  finally
    rs.Free;
  end;
  
end;

procedure TfrmShopMain.RzBmpButton8Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmShopMain.RzTabChange(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 28 then rzLeft.Width := 147;
  LoadMenu;
end;

procedure TfrmShopMain.Image19Click(Sender: TObject);
begin
  inherited;
  if rzLeft.Width = 28 then
     rzLeft.Width := 147
  else
     rzLeft.Width := 28;
  frmDesk.OnResize(nil);
end;

procedure TfrmShopMain.RzBmpButton9Click(Sender: TObject);
var i:integer;
begin
  inherited;
  if FList.Count > 0 then
     begin
       if MessageBox(Handle,'是否关闭当前打开的所有模块？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       for i:= FList.Count -1 downto 0 do
         TForm(TrzBmpButton(FList[i]).tag).free;
     end;
  if FList.Count=0 then
     begin
       Logined := Login(false);
     end;
end;

procedure TfrmShopMain.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  frmDesk.ForeBringtoFront;
  rzLeft.Width := 147;
  frmDesk.OnResize(nil);
end;

procedure TfrmShopMain.DoConnectError(Sender: TObject);
begin

end;

function TfrmShopMain.GetDeskFlag: string;
begin

end;

end.

