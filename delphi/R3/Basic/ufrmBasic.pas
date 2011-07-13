unit ufrmBasic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,DB, Graphics, Controls, Forms,
  Dialogs,ZdbFactory,uGlobal, Menus, ActnList, cxControls, cxSpinEdit, RzSplit,RzTabs,
  cxContainer, cxEdit, cxTextEdit,ExtCtrls, cxMemo,DbGridEh,cxDropDownEdit,ZBase,FR_Class,
  ComCtrls,RzTreeVw, StdCtrls, RzButton, RzPanel, ShellApi, cxCalendar,DBGrids,cxCheckBox,
  cxMaskEdit,cxButtonEdit,zrComboBoxList,ZLogFile;
const
  RowSelectColor=clAqua;
  BtnColor = $00DAD39C;
  bgkColor = clWhite;
  GridHeaderColor = $00FED99D;
type
  TfrmBasic = class(TForm)
    mmMenu: TMainMenu;
    actList: TActionList;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FLock: Boolean;
    FIsFree : Boolean;
    FContainerHanle: THandle;
    FOnFreeForm: TNotifyEvent;
    FPageHandle: THandle;
    procedure SetLock(const Value: Boolean);
    procedure SetContainerHanle(const Value: THandle);
    procedure SetOnFreeForm(const Value: TNotifyEvent);
    procedure DoDatePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    function GetFactor: TdbFactory;
    procedure SetPageHandle(const Value: THandle);
    { Private declarations }
  protected
    procedure SetCaption;virtual;
    procedure LoadfrfDefault;
    procedure WriteCreateLogFile;
    procedure WriteDestroyLogFile;
    procedure BeforeFreeForm;virtual;
    procedure SaveInterfaceToFile;
    procedure LoadInterfaceFromFile;

    procedure LoadFormat;virtual;
    procedure SaveFormat;virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    //权限控制
    function CheckCanExport:boolean;virtual;
    function DoBeforeExport:boolean;virtual;
    //设置Child方式显示时的窗体类型
    procedure SetChildDisplay(MainForm:TForm);
    //设置镶入显示方式
    procedure SetParantDisplay(AParant: TWinControl);
    procedure SetFormSize(Parant:TWinControl);virtual;

    //用主从窗体的方式显示
    function  ShowExecute(AOwner: TForm; Params: string = ''): boolean; overload;virtual;abstract;
    function  ShowExecute(AOwner:TForm;Parant:TWinControl;Params:String=''):Boolean;overload; virtual;
    //回车转TAB方法
    procedure OnEnterPress(CurrentForm: TForm; Key: Char);virtual;
    //主要用于操作权限的自动过滤
    procedure SetActionEnable(Sender:TAction;AEnabled:Boolean);virtual;
    //操作权限复制
    procedure CopyTo(Dest:TfrmBasic); virtual;
    //从数据集中的Field.DisplayLabel设置Grid的Column.Title.Caption值
    //读取表字典库  TableName ;可以多个表，多表用 ，号分隔

    procedure SetDBGridColumn(AGrid:TDbGridEh;Tables:string);virtual;
    //锁标记，
    property Lock:Boolean read FLock write SetLock;

    property Factor:TdbFactory read GetFactor;
    property ContainerHanle:THandle read FContainerHanle write SetContainerHanle;
    property OnFreeForm:TNotifyEvent read FOnFreeForm write SetOnFreeForm;
    property PageHandle:THandle read FPageHandle write SetPageHandle;
  end;
var FormBgk:boolean;
implementation
uses IniFiles,uCtrlUtil;
{$R *.dfm}

procedure TfrmBasic.DoDatePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  //inherited;
  if Error then
  begin
  TcxDateEdit(Sender).Date := Date();
  DisplayValue := date();
  ErrorText := '请输入正确的日期型...';
  //Error := false;
  end;
end;
procedure TfrmBasic.OnEnterPress(CurrentForm: TForm; Key: Char);
begin
  with CurrentForm do
  begin
    if (Key = #13) then
    begin
      if (ActiveControl=nil) or
         not ((ActiveControl.ClassNameIs('TcxCustomInnerMemo')) or
              (ActiveControl is TDbGridEh)
              )
      then
      begin
        SendMessage(handle, WM_NEXTDLGCTL, 0, 0);
        while (ActiveControl.ClassNameIs('TcxCustomInnerMemo')) do
           SendMessage(handle, WM_NEXTDLGCTL, 0, 0);
      end;
    end;
  end;
end;

{ TTfrmBasic }

constructor TfrmBasic.Create(AOwner: TComponent);
var i,c:integer;
begin
  inherited;
  PageHandle := 0;
  ContainerHanle := 0;
//  try
//     LoadInterfaceFromFile;
//  if sysLogFile and Factor.Connected then
//     WriteCreateLogFile;
//  except
//  end;
  if AOwner is TfrmBasic then
     TfrmBasic(AOwner).CopyTo(Self);
  SetCaption;
  LoadfrfDefault;

  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] is TcxDateEdit then
         begin
           TcxDateEdit(Components[i]).Properties.OnValidate := DoDatePropertiesValidate;
           TcxDateEdit(Components[i]).ImeName := '';
           //TcxDateEdit(Components[i]).Properties.DateButtons := [btnToday];
           //TcxDateEdit(Components[i]).Properties.DateOnError := deToday;
         end;
      if Components[i] is TDBGridEh then
         begin
           TDBGridEh(Components[i]).ImeName := '';
           TDBGridEh(Components[i]).OptionsEh := TDBGridEh(Components[i]).OptionsEh + [dghDialogFind];
           TDBGridEh(Components[i]).Options := TDBGridEh(Components[i]).Options - [dgRowSelect];
           TDBGridEh(Components[i]).Options := TDBGridEh(Components[i]).Options + [dgEditing];
           if TDBGridEh(Components[i]).AllowedOperations = [alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh] then
              TDBGridEh(Components[i]).AllowedOperations := [alopUpdateEh, alopAppendEh];
           //if FormBgk then TDBGridEh(Components[i]).FixedColor := GridHeaderColor;
           //for c := 0 to TDBGridEh(Components[i]).Columns.Count -1 do TDBGridEh(Components[i]).Columns[c].Title.Color := GridHeaderColor;
         end;
      if Components[i] is TcxTextEdit then
         begin
           TcxTextEdit(Components[i]).ImeName := '';
         end;
      if Components[i] is TcxMemo then
         begin
           TcxMemo(Components[i]).ImeName := '';
         end;
      if Components[i] is TcxSpinEdit then
         begin
           TcxSpinEdit(Components[i]).ImeName := '';
         end;
      if Components[i] is TcxComboBox then
         begin
           TcxComboBox(Components[i]).ImeName := '';
         end;
      if Components[i] is TcxCheckBox then
         begin
           TcxCheckBox(Components[i]).ImeName := '';
         end;
      if Components[i] is TcxMaskEdit then
         begin
           TcxMaskEdit(Components[i]).ImeName := '';
         end;
      if Components[i].ClassNameIs('TzrComboBoxList') then
         begin
           TzrComboBoxList(Components[i]).ImeName := '';
         end;
      if Components[i].ClassNameIs('TRzBitBtn') then
         begin
           if FormBgk then TRzBitBtn(Components[i]).Color := BtnColor;
         end;
      if Components[i].ClassNameIs('TRzPanel') then
         begin
           //if FormBgk then TRzPanel(Components[i]).Color := bgkColor;
         end;
      if Components[i].ClassNameIs('TRzPanel') then
         begin
           //if FormBgk then TRzPanel(Components[i]).Color := bgkColor;
         end;
      if Components[i].ClassNameIs('TPanel') then
         begin
           //if FormBgk then TPanel(Components[i]).Color := bgkColor;
         end;
    end;
//  if FormBgk then Color := bgkColor;
  LoadFormat;
  TDbGridEhExport.InitForm(self);
  TDbGridEhMark.InitForm(self,false);
end;

procedure TfrmBasic.SetDBGridColumn(AGrid: TDbGridEh;Tables:string);
var i:Integer;
begin
  if AGrid.DataSource = nil then Exit;
  if AGrid.DataSource.DataSet = nil then Exit;
  for i:=0 to AGrid.Columns.Count -1 do
     begin
       AGrid.Columns[i].Title.Caption := AGrid.Columns[i].Field.DisplayLabel;
     end;
end;
procedure TfrmBasic.SetActionEnable(Sender:TAction;AEnabled:Boolean);
var IsTrue:Boolean;
begin
  IsTrue := True;
  if Sender.Tag>0 then
   begin
    if Self.Tag>0 then
       Global.GlobalAtteProc(Inttostr(Self.Tag),Sender.Tag,IsTrue)
    else
       Global.GlobalAtteProc(Self.ClassName,Sender.Tag,IsTrue);
   end;
  if AEnabled and IsTrue then
     Sender.Enabled := True
  else
     Sender.Enabled := False;
end;

procedure TfrmBasic.SetCaption;
begin
//  if Assigned(Factor) then
//  Caption := Factor.XDict.GetCaption('FORM.'+Name,Caption);
end;

procedure TfrmBasic.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then
     Close
  else
     OnEnterPress(Self,Key);
end;

procedure TfrmBasic.CopyTo(Dest: TfrmBasic);
var i,j:Integer;
begin
  for i:=0 to actList.ActionCount -1 do
    begin
      for j:=0 to Dest.actList.ActionCount -1 do
        begin
          if UpperCase(actList.Actions[i].Name) = UpperCase(Dest.actList.Actions[j].Name) then
            begin
              Dest.actList.Actions[j].Tag := actList.Actions[i].Tag;
              Break;  
            end;
        end;
    end;
end;

destructor TfrmBasic.Destroy;
 procedure ClearItems(Items:TStrings);
  var i:Integer;
  begin
    for i:=0 to Items.Count -1 do
      begin
        if Items.Objects[i]<>nil then
           Dispose(Pointer(Items.Objects[i]));

        Items.Objects[i] := nil;
      end;
    Items.Clear;
  end;
var i,j:Integer;
  c:TClass;
begin
  BeforeFreeForm;
  if Assigned(OnFreeForm) then OnFreeForm(self);
  try
  //SaveFormat;
  for i:=0 to ComponentCount -1 do
    begin
      try
      if Components[i] is TcxCombobox then
         begin
           ClearItems(TcxCombobox(Components[i]).Properties.Items);
         end;

      if Components[i] is TRzTreeView then
         begin
           TRzTreeView(Components[i]).OnChange := nil;
           if TRzTreeView(Components[i]).tag=-1 then break;
           for j:=0 to TRzTreeView(Components[i]).Items.Count-1 do
             begin
               if TRzTreeView(Components[i]).Items[j].Data<>nil then
                  begin
                    if (TRzTreeView(Components[i]).Items[j].Data<>nil) and (TObject(TRzTreeView(Components[i]).Items[j].Data) is TRecord_) then
                       TObject(TRzTreeView(Components[i]).Items[j].Data).Free
                    else
                    if TRzTreeView(Components[i]).Items[j].Data<>nil then
                       Dispose(Pointer(TRzTreeView(Components[i]).Items[j].Data));
                    TRzTreeView(Components[i]).Items[j].Data := nil;
                  end;
             end;
         end;

      if Components[i] is TTreeView then
         begin
           TTreeView(Components[i]).OnChange := nil;
           if TRzTreeView(Components[i]).tag=-1 then break;
           for j:=0 to TTreeView(Components[i]).Items.Count-1 do
             begin
               if TTreeView(Components[i]).Items[j].Data<>nil then
                  begin
                    if (TTreeView(Components[i]).Items[j].Data<>nil) and (TObject(TTreeView(Components[i]).Items[j].Data) is TRecord_) then
                       TObject(TTreeView(Components[i]).Items[j].Data).Free
                    else
                    if TTreeView(Components[i]).Items[j].Data<>nil then
                       Dispose(Pointer(TTreeView(Components[i]).Items[j].Data));
                    TTreeView(Components[i]).Items[j].Data := nil;
                  end;
             end;
         end;

      if Components[i] is TRzCheckTree then
         begin
           TRzCheckTree(Components[i]).OnChange := nil;
           if TRzTreeView(Components[i]).tag=-1 then break;
           for j:=0 to TRzCheckTree(Components[i]).Items.Count-1 do
             begin
               if TRzCheckTree(Components[i]).Items[j].Data<>nil then
                  begin
                    if (TRzCheckTree(Components[i]).Items[j].Data<>nil) and (TObject(TRzCheckTree(Components[i]).Items[j].Data) is TRecord_) then
                       TObject(TRzCheckTree(Components[i]).Items[j].Data).Free
                    else
                    if TRzCheckTree(Components[i]).Items[j].Data<>nil then
                       Dispose(Pointer(TRzCheckTree(Components[i]).Items[j].Data));
                    TRzCheckTree(Components[i]).Items[j].Data := nil;
                  end;
             end;
         end;

      if Components[i] is TDataSet then
         TDataSet(Components[i]).Close;
      except
        //on E:Exception do
        //  LogFile.AddLogFile(0,E.Message);
      end;
    end;
//  if sysLogFile and Assigned(Factor) and Factor.Connected then
//     WriteDestroyLogFile;
  TDbGridEhExport.FreeForm(self);
  TDbGridEhMark.FreeForm(self);
  except
    //on E:Exception do
    //   LogFile.AddLogFile(0,E.Message);
  end;
  inherited;
end;

procedure TfrmBasic.SetLock(const Value: Boolean);
begin
  FLock := Value;
end;

procedure TfrmBasic.SetChildDisplay(MainForm: TForm);
  procedure SetTools;
    var Tmp:TComponent;
        i:Integer;
    begin
      Tmp := nil;
      for i:= 0 to MainForm.ComponentCount -1 do
        begin
          if (UpperCase(MainForm.Components[i].Name)='RZPANEL') and (MainForm.Components[i] is TrzSizePanel) then
             begin
               Tmp := MainForm.Components[i];
               Break;
             end;
        end;
      if Tmp<>nil then
         begin
           try
            TrzSizePanel(Tmp).CloseHotSpot;
           except
           end;
         end;
    end;
var
  wRect: TRect;
begin
  if Visible then
     begin
      BringToFront;
      Exit;
     end;
  GetWindowRect(MainForm.ClientHandle, wRect);
  if Width > (wRect.Right - wRect.Left-2) then
     SetTools;
  FormStyle := fsMDIChild;
  WindowState := wsMaximized;
  FIsFree := True;
end;

procedure TfrmBasic.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FIsFree then Action := caFree;

end;

procedure TfrmBasic.SetParantDisplay(AParant: TWinControl);
begin
  if Visible then
     begin
       SetFormSize(AParant);
       Exit;
     end;
  BorderStyle := bsNone;
  Parent :=  AParant;
//  Windows.SetParent(Handle,AParant.Handle);
  Visible := True;
  SetBounds(AParant.ClientRect.Left,AParant.ClientRect.Top,AParant.ClientWidth,AParant.ClientHeight);
  BringToFront;
  FIsFree := true;
end;

{function TfrmBasic.ShowExecute(AOwner: TForm; Params: string = ''): boolean;
begin
  SetChildDisplay(AOwner);
end;  }

function TfrmBasic.ShowExecute(AOwner:TForm;Parant:TWinControl;Params:String=''): Boolean;
begin
  SetParantDisplay(Parant);
end; 


procedure TfrmBasic.SetContainerHanle(const Value: THandle);
begin
  FContainerHanle := Value;
end;

procedure TfrmBasic.SetFormSize(Parant: TWinControl);
begin
  SetBounds(Parant.ClientRect.Left,Parant.ClientRect.Top,Parant.ClientWidth,Parant.ClientHeight);
end;

procedure TfrmBasic.LoadfrfDefault;
var i:Integer;
begin
  for i:=0 to Self.ComponentCount -1 do
    begin
      if Components[i] is TfrReport then
         begin
           if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+Components[i].Name+'.frf') then
              TfrReport(Components[i]).LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+Components[i].Name+'.frf');
         end;
    end;
end;

procedure TfrmBasic.WriteCreateLogFile;
begin
  if Global=nil then Exit;
  try
//  if Factor.openFormLog then
//     Factor.ExecSQL('insert into SYS_LOGFILE(CREA_DATE,CREA_TIME,OPER_USER,FORM_NAME,FORM_ACTION,BTN_NAME,BTN_ACTION) values('''+formatDatetime('YYYY-MM-DD',date())+''','''+formatDatetime('HH:NN:SS',now())+''','''+Global.UserName+''','''+Caption+''',''进入'',''创建'',''创建'')');
  except
  end;
end;

procedure TfrmBasic.WriteDestroyLogFile;
begin
  if Global=nil then Exit;
  try
//  if Factor.openFormLog then
//     Factor.ExecSQL('insert into SYS_LOGFILE(CREA_DATE,CREA_TIME,OPER_USER,FORM_NAME,FORM_ACTION,BTN_NAME,BTN_ACTION) values('''+formatDatetime('YYYY-MM-DD',date())+''','''+formatDatetime('HH:NN:SS',now())+''','''+Global.UserName+''','''+Caption+''',''退出'',''释放'',''释放'')');
  except
  end;
end;

procedure TfrmBasic.BeforeFreeForm;
begin

end;

procedure TfrmBasic.SetOnFreeForm(const Value: TNotifyEvent);
begin
  FOnFreeForm := Value;
end;

procedure TfrmBasic.SaveInterfaceToFile;
var i,j:integer;
  F:TIniFile;
begin
  F:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'iface.ini');
  try
  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] is TAction then
         begin
           F.WriteString(ClassName,Components[i].Name,TAction(Components[i]).Caption);
         end;
      if Components[i] is TLabel then
         begin
           F.WriteString(ClassName,Components[i].Name,TLabel(Components[i]).Caption);
         end;
      if (Components[i] is TRzBitBtn) and (TRzBitBtn(Components[i]).Action=nil) then
         begin
           F.WriteString(ClassName,Components[i].Name,TRzBitBtn(Components[i]).Caption);
         end;
      if (Components[i] is TRzButton) and (TRzButton(Components[i]).Action=nil) then
         begin
           F.WriteString(ClassName,Components[i].Name,TRzButton(Components[i]).Caption);
         end;
      if (Components[i] is TMenuItem) and (TMenuItem(Components[i]).Action=nil) then
         begin
           F.WriteString(ClassName,Components[i].Name,TMenuItem(Components[i]).Caption);
         end;
      if (Components[i] is TButton) and (TButton(Components[i]).Action=nil) then
         begin
           F.WriteString(ClassName,Components[i].Name,TButton(Components[i]).Caption);
         end;
      if (Components[i] is TDBGridEh) then
         begin
           for j := 0 to TDBGridEh(Components[i]).Columns.Count-1 do
             begin
               F.WriteString(ClassName,Components[i].Name+'_'+TDBGridEh(Components[i]).Columns[j].FieldName,TDBGridEh(Components[i]).Columns[j].Title.Caption);
             end;
         end;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmBasic.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = VK_F1) then
     SaveInterfaceToFile
  else
  if (Key = VK_F1) then
     ShellExecute(Handle,'open',Pchar(ExtractFilePath(ParamStr(0))+'帮助文档.chm'),nil,nil,SW_MAXIMIZE);
end;

procedure TfrmBasic.LoadInterfaceFromFile;
var i,j:integer;
  F:TIniFile;
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+'iface.ini') then Exit;
  F:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'iface.ini');
  try
  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] is TAction then
         begin
           TAction(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TAction(Components[i]).Caption);
         end;
      if Components[i] is TLabel then
         begin
           TLabel(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TLabel(Components[i]).Caption);
         end;
      if (Components[i] is TRzBitBtn) and (TRzBitBtn(Components[i]).Action=nil) then
         begin
           TRzBitBtn(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TRzBitBtn(Components[i]).Caption);
         end;
      if (Components[i] is TRzButton) and (TRzButton(Components[i]).Action=nil) then
         begin
           TRzButton(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TRzButton(Components[i]).Caption);
         end;
      if (Components[i] is TMenuItem) and (TMenuItem(Components[i]).Action=nil) then
         begin
           TMenuItem(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TMenuItem(Components[i]).Caption);
         end;
      if (Components[i] is TButton) and (TButton(Components[i]).Action=nil) then
         begin
           TButton(Components[i]).Caption := F.ReadString(ClassName,Components[i].Name,TButton(Components[i]).Caption);
         end;
      if (Components[i] is TDBGridEh) then
         begin
           for j := 0 to TDBGridEh(Components[i]).Columns.Count-1 do
             begin
               TDBGridEh(Components[i]).Columns[j].Title.Caption := F.ReadString(ClassName,Components[i].Name+'_'+TDBGridEh(Components[i]).Columns[j].FieldName,TDBGridEh(Components[i]).Columns[j].Title.Caption);
             end;
         end;
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmBasic.LoadFormat;
var
  F:TIniFile;
  i,c:integer;
  DBGridEh:TDBGridEh;
  save:boolean;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sft.'+Global.UserID);
  try
    for c := 0 to ComponentCount -1 do
    begin
      if Components[c] is TDBGridEh then
      begin
        DBGridEh := TDBGridEh(Components[c]);
        if not DBGridEh.Enabled then continue;
        save := DBGridEh.AutoFitColWidths;
        DBGridEh.AutoFitColWidths := false;
        for i:= 0 to DBGridEh.Columns.Count -1 do
        begin
          if DBGridEh.Columns[i].FieldName='' then Continue;
          DBGridEh.Columns[i].Visible := F.ReadBool(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName,DBGridEh.Columns[i].Visible);
          DBGridEh.Columns[i].Width := F.ReadInteger(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName+'_WIDTH',DBGridEh.Columns[i].Width);
          //DBGridEh.Columns[i].Index := F.ReadInteger(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName+'_INDEX',DBGridEh.Columns[i].Index);
        end;
        DBGridEh.AutoFitColWidths := save;
      end;
    end;
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmBasic.SaveFormat;
var
  F:TIniFile;
  i,c:integer;
  DBGridEh:TDBGridEh;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sft.'+Global.UserID);
  try
    for c := 0 to ComponentCount -1 do
    begin
      if Components[c] is TDBGridEh then
      begin
        DBGridEh := TDBGridEh(Components[c]);
        for i:= 0 to DBGridEh.Columns.Count -1 do
          begin
            if DBGridEh.Columns[i].FieldName='' then Continue;
            F.WriteBool(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName,DBGridEh.Columns[i].Visible);
            F.WriteInteger(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName+'_WIDTH',DBGridEh.Columns[i].Width);
            F.WriteInteger(Caption+DBGridEh.Name,DBGridEh.Columns[i].FieldName+'_INDEX',DBGridEh.Columns[i].Index);
          end;
      end;
    end;
  finally
    F.Free;
  end;
end;

function TfrmBasic.CheckCanExport: boolean;
begin
  result := true;
end;

function TfrmBasic.GetFactor: TdbFactory;
begin
  result := uGlobal.Factor;
end;

function TfrmBasic.DoBeforeExport: boolean;
begin

end;

procedure TfrmBasic.SetPageHandle(const Value: THandle);
begin
  FPageHandle := Value;
end;

initialization
  FormBgk := false;
end.

