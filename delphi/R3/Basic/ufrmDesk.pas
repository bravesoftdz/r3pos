
unit ufrmDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, jpeg, StdCtrls, RzBmpBtn,ActnList,Buttons, ImgList,RzButton;
const
  ButtonHeight=100;
  ButtonWidth=100;

type
  THsBmButton=class(TrzBmpButton)
  public
    procedure WMLButtonDblClk( var Msg: TWMLButtonDown ); message wm_LButtonDblClk;
  end;
type
  TfrmDesk = class(TForm)
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    FButtons:TList;
    FDeletes:TList;
    FLocked: Boolean;
    FWaited: Boolean;
    procedure DoEnter(Sender:TObject);
    procedure DoExit(Sender:TObject);
    procedure DoDelete(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    function AddButton(ALeft:Integer=-1;ATop:Integer=-1):THsBmButton;
    function GetButtons(Index: Integer): THsBmButton;
    procedure SetLocked(const Value: Boolean);
    procedure SetWaited(const Value: Boolean);
  protected
    Saved:boolean;
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);virtual;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

    procedure Clear;
    procedure LoadFromFile(FileName:String);
    procedure GetButtonPos(Index:Integer;Var ALeft,ATop:Integer);
    procedure AlignButton;
    procedure SaveToFront;
    procedure ForeBringtoFront;
    procedure CreateButton(Action:TAction);
    procedure DeleteButton(Action:THsBmButton);

    function  FindButton(ActionName:string):THsBmButton;

    function  FindAction(ActionName:string):TContainedAction;
    function  GetActiveButton:THsBmButton;

    property  Buttons[Index:Integer]:THsBmButton Read GetButtons;
    property  Locked:Boolean read FLocked write SetLocked;
    property  Waited:Boolean read FWaited write SetWaited;
  end;

var
  frmDesk: TfrmDesk;

implementation
uses ufrmMain,IniFiles, uGlobal;
{$R *.dfm}

var
  whKeyboard, whMouse: HHook;

{$IFDEF WIN32}

function MouseHookCallBack(Code: integer; Msg: WPARAM;
  MouseHook: LPARAM): LRESULT; stdcall;
{$ELSE}

function MouseHookCallBack(Code: integer; Msg: word;
  MouseHook: longint): longint; export;
{$ENDIF}
begin
  if Code >= 0 then
     begin
       if frmDesk.Waited then
          begin
            result := 1;
            exit;
          end;
       Result := CallNextHookEx(whMouse, Code, Msg, MouseHook);
       if Assigned(frmDesk) then frmDesk.MouseHook(Code, Msg, MouseHook);
       if Assigned(frmDesk) and not frmDesk.Locked then frmDesk.SendToBack;
     end;
end;

{$IFDEF WIN32}

function KeyboardHookCallBack(Code: integer; Msg: WPARAM;
  KeyboardHook: LPARAM): LRESULT; stdcall;
{$ELSE}

function KeyboardHookCallBack(Code: integer; Msg: word;
  KeyboardHook: longint): longint; export;
{$ENDIF}
const LLKHF_ALTDOWN = $20;
begin
  Result := 0;
  if Code>=0 then
     begin
       if frmDesk.Waited then
          begin
            result := 1;
            exit;
          end;
       Result := CallNextHookEx(whKeyboard, Code, Msg, KeyboardHook);
       if Assigned(frmDesk) then frmDesk.KeyboardHook(Code, Msg, KeyboardHook);
     end;
end;

function GetModuleHandleFromInstance: THandle;
var
  s: array[0..512] of char;
begin
  GetModuleFileName(hInstance, s, sizeof(s) - 1);
  Result := GetModuleHandle(s);
end;

{ TfrmDesk }

constructor TfrmDesk.Create(AOwner: TComponent);
begin
  FButtons := TList.Create;
  FDeletes := TList.Create;
  Waited := false;
  inherited;
  frmDesk := Self;
  if Application.MainForm = nil then
     Raise Exception.Create('主程序建立顺序有错，必须先创建主窗体。');
  try
     TfrmMain(Application.MainForm).DeskForm := Self;
  except
    on E:Exception do
     Raise Exception.Create('主窗体必须由frmMain继承下来,错误:'+E.message);
  end;
  //Windows.SetParent(Handle, Application.MainForm.ClientHandle);
  ParentWindow := Application.MainForm.ClientHandle;
  whMouse := SetWindowsHookEx(WH_MOUSE, MouseHookCallBack,
    GetModuleHandleFromInstance,
{$IFDEF WIN32}
    GetCurrentThreadID
{$ELSE}
 GetCurrentTask
{$ENDIF});
 whKeyboard := SetWindowsHookEx(WH_KEYBOARD, KeyboardHookCallBack,
    GetModuleHandleFromInstance,
{$IFDEF WIN32}
  GetCurrentThreadID
{$ELSE}
   GetCurrentTask
{$ENDIF});

end;

destructor TfrmDesk.Destroy;
begin
  Clear;
  FButtons.Free;
  FDeletes.Free;
  UnhookWindowsHookEx(whKeyboard);
  UnhookWindowsHookEx(whMouse);
  inherited;
  if Application.MainForm <> nil then
     begin
       TfrmMain(Application.MainForm).DeskForm := nil;
       frmDesk := nil;
     end;
end;

procedure TfrmDesk.Clear;
var i:Integer;
begin
  for i:= 0 to FButtons.Count -1 do
    TObject(FButtons[i]).Free;
  FButtons.Clear;
  for i:= 0 to FDeletes.Count -1 do
    TObject(FDeletes[i]).Free;
  FDeletes.Clear;
end;


function TfrmDesk.AddButton(ALeft:Integer=-1;ATop:Integer=-1):THsBmButton;
var Button:THsBmButton;
    Bmp:TBitmap;
    vLeft,vTop:Integer;
begin
{  Button := THsBmButton.Create(Self);
  FButtons.Add(Button);
  Result := Button;
  Button.Parent := Self;
  //Windows.SetParent(Button.Handle,ClientHandle);
  if (ALeft=-1) or (ATop=-1) then
     GetButtonPos(FButtons.Count-1,vLeft,vTop)
  else
     begin
       vLeft := ALeft;
       vTop  := ATop;
     end;
  Button.Left := vLeft;
  Button.Top := vTop;
  Button.Width := ButtonWidth;
  Button.Height := ButtonHeight;
  Button.Caption := '未命令';
  Button.Layout := blGlyphTop;
  Button.ButtonSize := bszNeither;
  Button.DragCursor := crDefault;
  Button.OnDragOver := FormDragOver;
  Button.Cursor := crHandPoint;
  Button.OnEnter := DoEnter;
  Button.OnExit := DoExit;
  Button.OnKeyDown := DoDelete;

  Bmp := TBitmap.Create;
  try
    Bmp.Width := 60;
    Bmp.Height := 60;

//    Img32.GetBitmap(0,Bmp);
//    Button.Bitmaps.Up.Assign(Bmp);
//    Fou32.GetBitmap(0,Bmp);
//    Button.Bitmaps.Hot.Assign(Bmp);
//    Button.Bitmaps.TransparentColor := clRed;
  finally
    Bmp.Free;
  end;         }
end;

procedure TfrmDesk.LoadFromFile(FileName: String);
var F:TIniFile;
    Section:TStringList;
    vLeft,vTop,i,ImgIndex:Integer;
    Button:THsBmButton;
    Bmp:TBitmap;
    Action:TContainedAction;
begin
{  if FButtons.Count >0 then Exit;
  if not DirectoryExists(ExtractFilePath(FileName)) then
     CreateDir(ExtractFilePath(FileName));
  F := TIniFile.Create(FileName);
  Section := TStringList.Create;
  Self.DisableAlign;
  try
    F.ReadSections(Section);
    for i:=0 to Section.Count -1 do
      begin
        //vLeft := F.ReadInteger(Section[i],'Left',-1);
        //vTop  := F.ReadInteger(Section[i],'Left',-1);
        ImgIndex := F.ReadInteger(Section[i],'ImgIndex',0);
        Button := AddButton(-1,-1);
        //Button.UpdateControlState;
        //Button.SetFocus;
        Action := FindAction(Section[i]);
        if Action=nil then Continue;
        Button.Caption := TAction(Action).Caption;
        Button.OnDblClick := TAction(Action).OnExecute;
        Button.OnDblClick := TAction(Action).OnExecute;
        Button.Name := TAction(Action).Name;

        if ImgIndex<>0 then
          begin
              Bmp := TBitmap.Create;
              try
                Bmp.Width := 60;
                Bmp.Height := 60;

                Img32.GetBitmap(0,Bmp);
                Button.Bitmaps.Up.Assign(Bmp);
                Fou32.GetBitmap(0,Bmp);
                Button.Bitmaps.Hot.Assign(Bmp);
                Button.Bitmaps.TransparentColor := clRed;
              finally
                Bmp.Free;
              end;
          end;
      end;
  finally
    Section.Free;
    F.Free;
    Self.EnableAlign;
  end;   }
end;

function TfrmDesk.FindAction(ActionName: string): TContainedAction;
var i:Integer;
  frmMain :TfrmMain;
begin
  Result := nil;
  if Application.MainForm = nil then Exit;
  frmMain := TfrmMain(Application.MainForm);
  with frmMain do
    begin
       for i:=0 to actList.ActionCount -1 do
         begin
          if uppercase(actList.Actions[i].Name) = uppercase(ActionName) then
             begin
               Result := actList.Actions[i];
               Exit;
             end; 
         end;
    end;
end;

procedure TfrmDesk.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
{  if (Source is THsBmButton) and (Sender Is TfrmDesk) then
     begin
       if THsBmButton(Source).Left <> X then
       THsBmButton(Source).Left := X;
       if THsBmButton(Source).Top <> Y then
       THsBmButton(Source).Top := Y;
       Accept := True;
     end;     }
end;

procedure TfrmDesk.GetButtonPos(Index: Integer; var ALeft, ATop: Integer);
var Rect:TRect;
    Row,Col,TotalRow:Integer;
begin
  Rect := GetClientRect;
  TotalRow := (ClientHeight-20) DIV ButtonHeight;

  Row := (Index mod TotalRow);
  Col := (Index div TotalRow);

  ALeft := (Col)*ButtonWidth + 20;
  ATop  := (Row)*ButtonHeight+ 20;
end;

procedure TfrmDesk.CreateButton(Action: TAction);
var F:TIniFile;
    Bmp:TBitmap;
    Button:THsBmButton;
    ImgIndex:Integer;
begin
{  if FindButton(Action.Name)<>nil then Raise Exception.Create(Action.Caption+'的快捷方式已经存在。');
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Setings\'+Global.UserID+'.dsk');
  try
        Button := AddButton(-1,-1);
        Button.Caption := Action.Caption;
        Button.OnDblClick := Action.OnExecute;
        Button.OnDblClick := Action.OnExecute;
        Button.Name := Action.Name;
        ImgIndex := 0;
        if ImgIndex<>0 then
          begin
              Bmp := TBitmap.Create;
              try
                Bmp.Width := 60;
                Bmp.Height := 60;

                Img32.GetBitmap(0,Bmp);
                Button.Bitmaps.Up.Assign(Bmp);
                Fou32.GetBitmap(0,Bmp);
                Button.Bitmaps.Hot.Assign(Bmp);
                Button.Bitmaps.TransparentColor := clRed;
              finally
                Bmp.Free;
              end;
          end;
        F.WriteInteger(Action.Name,'ImgIndex',0); 
  finally
     F.Free;
  end;      }
end;

procedure TfrmDesk.DoEnter(Sender: TObject);
begin
  THsBmButton(Sender).Color := clBlue;
end;

procedure TfrmDesk.DoExit(Sender: TObject);
begin
  THsBmButton(Sender).Color := clBtnFace;
end;

procedure TfrmDesk.DoDelete(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // if Key=46 then
 //    DeleteButton(THsBmButton(Sender));
end;

procedure TfrmDesk.DeleteButton(Action: THsBmButton);
var i:Integer;
    F:TIniFile;
begin
  Self.DisableAlign;
  try
    F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Setings\'+Global.UserID+'.dsk');
    try
       F.EraseSection(Action.Name);
    finally
       F.Free;
    end;
    i := FButtons.IndexOf(Action);
    if i<0 then Exit;
    FButtons.Delete(i);
    Action.OnEnter := nil;
    Action.OnExit := nil;
    Action.OnKeyDown := nil;
    FDeletes.Add(Action);
    Action.Name := 'Button'+ Inttostr(FDeletes.Count);
    Action.Parent := nil;
    Action.Visible := False;
    //RemoveControl(Action);
    //Action.Free;
  finally
    Self.EnableAlign;
  end;
  AlignButton;
end;

function TfrmDesk.FindButton(ActionName: string): THsBmButton;
var i:Integer;
begin
  Result := nil;
  for i:=0 to FButtons.Count -1 do
    begin
      if UpperCase(THsBmButton(FButtons[i]).Name) = UpperCase(ActionName) then
         begin
           Result := THsBmButton(FButtons[i]);
           Exit;
         end;
    end;
end;

function TfrmDesk.GetActiveButton: THsBmButton;
var i:Integer;
begin
  Result := nil;
  for i:=0 to FButtons.Count -1 do
    begin
      if THsBmButton(FButtons[i]).Focused then
        begin
          Result := THsBmButton(FButtons[i]);
          Exit;
        end;
    end;
end;

procedure TfrmDesk.AlignButton;
var i:Integer;
  vTop,vLeft:Integer;
begin
  for i:=0 to FButtons.Count -1 do
    begin
       GetButtonPos(i,vLeft,vTop);
       Buttons[i].Top := vTop;
       Buttons[i].Left := vLeft;
    end;
end;

function TfrmDesk.GetButtons(Index: Integer): THsBmButton;
begin
  Result := THsBmButton(FButtons[Index]);
end;

procedure TfrmDesk.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
end;

procedure TfrmDesk.MouseHook(Code: integer; Msg: word; MouseHook: Integer);
begin

end;

procedure TfrmDesk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin

end;

procedure TfrmDesk.ForeBringtoFront;
begin
  Locked := true;
  BringToFront;
end;

procedure TfrmDesk.SaveToFront;
begin
  if Locked then Saved := true else Saved := false;
  SendToBack;
end;

procedure TfrmDesk.SetWaited(const Value: Boolean);
begin
  FWaited := Value;
end;

{ THsBmButton }

procedure THsBmButton.WMLButtonDblClk(var Msg: TWMLButtonDown);
begin
  if Assigned(OnDblClick) then
     OnDblClick(Self);
end;

procedure TfrmDesk.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Button:THsBmButton;
begin
  if Key=46 then
     begin
       Button := GetActiveButton;
       if Button<>nil then
       DeleteButton(Button);
     end;
end;

procedure TfrmDesk.FormResize(Sender: TObject);
begin
  AlignButton;
end;

procedure TfrmDesk.FormDeactivate(Sender: TObject);
begin
  if not Saved then Locked := false;
  Saved := false;
end;

initialization
  frmDesk := nil;
end.
