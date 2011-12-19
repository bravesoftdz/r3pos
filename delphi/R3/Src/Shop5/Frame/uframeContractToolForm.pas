unit uframeContractToolForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, Grids, DBGridEh, uframeContractForm,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, FR_Class;

type
  TframeContractToolForm = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    actPrior: TAction;
    actNext: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ppmReport: TPopupMenu;
    mnmFormer0: TMenuItem;
    mnmFormer1: TMenuItem;
    mnmFormer2: TMenuItem;
    mnmFormer3: TMenuItem;
    mnmFormer4: TMenuItem;
    mnmFormer5: TMenuItem;
    dsList: TDataSource;
    cdsList: TZQuery;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure ppmReportPopup(Sender: TObject);
    procedure mnmFormer5Click(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure RzPageDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actExitExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    idx:integer;
    Freed:boolean;    //判断是否退出
    function CheckNewOrder:integer;    //检查新单并返回新单的页面索引值
    function CheckNoSaveOrder:integer;     //检查未保存单并返回未保存单的页面索引值
    function GetContractFrom: TframeContractForm;
  protected
    function FindColumn(DbGrid:TDBGridEh;FieldName:String):TColumnEh;
    procedure BtnStatus;virtual;
    procedure Clear;
  public
    { Public declarations }
    procedure WMStatusChange(var Message: TMessage); message WM_STATUS_CHANGE;
    procedure WMExecOrder(var Message: TMessage); message WM_EXEC_ORDER;
    procedure WndProc(var Message: TMessage); override;
        
    procedure Add;
    procedure OpenForm(id:string;cid:string='');
    //必须重装
    function GetFormClass:TFormClass;virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    property CurContract:TframeContractForm Read GetContractFrom;
  end;


implementation
uses uCtrlUtil,IniFiles,ufrmFastReport, uShopUtil, uGlobal, uXDictFactory, uShopGlobal,
  Math, uframeMDForm;
{$R *.dfm}

{ TframeContractToolFrom }

procedure TframeContractToolForm.Add;
var p:Integer;
    form:TframeContractForm;
    page:TRzTabSheet;
begin
  p := CheckNewOrder;
  if p >= 0 then
     begin
       RzPage.ActivePageIndex := p;
       if not CurContract.IsNull then
          begin
            CurContract.cid := Global.SHOP_ID;
            CurContract.NewOrder;
            Inc(idx);
            RzPage.ActivePage.Caption := '新建'+inttostr(idx);
          end
       else
          begin
             CurContract.cid := Global.SHOP_ID;
             CurContract.NewOrder;
            RzPage.ActivePage.Caption := '新建'+inttostr(idx);
          end;
     end
  else
     begin
       if (CurContract <> nil) and ((CurContract.dbState = dsBrowse) or CurContract.IsNull or not CurContract.Modifyed) then
          begin
            CurContract.cid := Global.SHOP_ID;
            CurContract.NewOrder;
            inc(idx);
            rzPage.ActivePage.Caption := '新建'+inttostr(idx);
            Exit;
          end;
       page := TRzTabSheet.Create(RzPage);
       form := TframeContractForm(GetFormClass.Create(Self));
       try
         inc(idx);
         page.Caption := '新建'+inttostr(idx);
         page.PageControl := RzPage;
         page.Data := form;
         page.Align := alClient;
         form.TabSheet := page;
         form.ContainerHanle := page.Handle;
         RzPage.ActivePage := page;
         form.SetParantDisplay(RzPage.ActivePage);
         form.cid := Global.SHOP_ID;
         form.NewOrder;
         RzPage.OnChange(nil);
       except
         page.Data := nil;
         form.TabSheet := nil;
         form.Free;
         page.Free;
         RzPage.ActivePageIndex := 0;
       end;
     end;

end;

function TframeContractToolForm.GetContractFrom: TframeContractForm;
begin
  if not Assigned(RzPage.ActivePage.Data) then
     Result := nil
  else
     Result := TframeContractForm(RzPage.ActivePage.Data);
end;

procedure TframeContractToolForm.actNewExecute(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TframeContractToolForm.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.DeleteOrder;
  end;
end;

procedure TframeContractToolForm.actEditExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.EditOrder;
  end;
end;

procedure TframeContractToolForm.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.SaveOrder;
  end;
end;

procedure TframeContractToolForm.actCancelExecute(Sender: TObject);
begin
  inherited;
  if (CurContract<>nil) then
     begin
       if (CurContract.dbState = dsInsert) and (CurContract.IsNull) then
          begin
            if MessageBox(Handle,'没有输入任何资料,是否想关闭当前单据?','友情提示...',MB_YESNO+MB_ICONQUESTION) = 6 then CurContract.Close;
          end
       else
          begin
            if MessageBox(Handle,'是否取消刚才录入的所有修改？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            CurContract.CancelOrder;
          end;
     end;
end;

procedure TframeContractToolForm.actPrintExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.PrintOrder;
  end;
end;

procedure TframeContractToolForm.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.PreviewOrder;
  end;
end;

procedure TframeContractToolForm.actAuditExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.AuditOrder;
    RzPage.OnChange(nil);
  end;  
end;

procedure TframeContractToolForm.actPriorExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.PriorOrder;
  end;
end;

procedure TframeContractToolForm.actNextExecute(Sender: TObject);
begin
  inherited;
  if (CurContract <> nil) then
  begin
    CurContract.NextOrder;
  end;
end;

procedure TframeContractToolForm.actFindExecute(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
end;

function TframeContractToolForm.FindColumn(DbGrid: TDBGridEh;
  FieldName: String): TColumnEh;
var i:Integer;
begin
  Result := nil;
  for i := 0 to DbGrid.Columns.Count - 1 do
  begin
    if DbGrid.Columns[i].FieldName = FieldName then
    begin
       Result := DbGrid.Columns[i];
       Exit;
    end;
  end;
end;

procedure TframeContractToolForm.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TframeContractToolForm.BtnStatus;
begin
  actSave.Enabled := Assigned(CurContract) and (CurContract.dbstate in [dsInsert,dsEdit]);
  actCancel.Enabled := Assigned(CurContract) and (CurContract.dbstate in [dsInsert,dsEdit]);
  actEdit.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actDelete.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);

  actNew.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actAudit.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actPrior.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actNext.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actPrint.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
  actPreview.Enabled := not Assigned(CurContract) or not (CurContract.dbstate in [dsInsert,dsEdit]);
end;

procedure TframeContractToolForm.Clear;
var i:Integer;
begin
  for i := RzPage.PageCount-1 downto 1 do
  begin
    if RzPage.Pages[i].Data <> nil then
    begin
      TframeContractForm(RzPage.Pages[i].Data).Free;
    end;
  end;
end;

constructor TframeContractToolForm.Create(AOwner: TComponent);
begin
  inherited;
  Freed := True;
  TDbGridEhSort.InitForm(self);
  BtnStatus;
  InitGridPickList(DBGridEh1);
end;

destructor TframeContractToolForm.Destroy;
begin
  Freed := True;
  Clear;
  TDbGridEhSort.FreeForm(self); 
  inherited;
end;

function TframeContractToolForm.CheckNewOrder: integer;
var i:Integer;
    Form:TframeContractForm;
begin
  Result := -1;
  for i := 0 to RzPage.PageCount - 1 do
  begin
    if RzPage.Pages[i].Data <> nil then
    begin
      Form := TframeContractForm(RzPage.Pages[i].Data);
      if (Form.IsNull) or (Form.dbstate = dsBrowse) or (not Form.Modifyed) then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;
end;

function TframeContractToolForm.CheckNoSaveOrder: integer;
var
  i:integer;
  form:TframeContractForm;
begin
  result := -1;
  for i:=0 to rzPage.PageCount - 1 do
    begin
       if rzPage.Pages[i].Data <> nil then
          begin
            form := TframeContractForm(rzPage.Pages[i].Data);
            if not form.isNull and (form.dbState <> dsBrowse) then
               begin
                 result := i;
                 Exit;
               end;
          end;
    end;
end;

procedure TframeContractToolForm.ppmReportPopup(Sender: TObject);
var
  frReport1:TfrReport;
  i:integer;
  F:TIniFile;
begin
  frReport1 := nil;
  for i:=0 to ComponentCount -1 do
    begin
      if Components[i] is TfrReport then
         begin
           frReport1 := TfrReport(Components[i]);
         end;
    end;
  if frReport1=nil then Exit;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
  try
  mnmFormer0.Caption := '默认表样';
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport1.Name+'1.frf') then
     mnmFormer1.Caption := '自定义一(空置)'
  else
     mnmFormer1.Caption := F.ReadString('s1_'+frReport1.Name,'name','自定义一');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport1.Name+'2.frf') then
     mnmFormer2.Caption := '自定义二(空置)'
  else
     mnmFormer2.Caption := F.ReadString('s2_'+frReport1.Name,'name','自定义二');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport1.Name+'3.frf') then
     mnmFormer3.Caption := '自定义三(空置)'
  else
     mnmFormer3.Caption := F.ReadString('s3_'+frReport1.Name,'name','自定义三');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport1.Name+'4.frf') then
     mnmFormer4.Caption := '自定义四(空置)'
  else
     mnmFormer4.Caption := F.ReadString('s4_'+frReport1.Name,'name','自定义四');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport1.Name+'5.frf') then
     mnmFormer5.Caption := '自定义五(空置)'
  else
     mnmFormer5.Caption := F.ReadString('s5_'+frReport1.Name,'name','自定义五');
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TframeContractToolForm.mnmFormer5Click(Sender: TObject);
begin
  inherited;
  if Assigned(actPreview.OnExecute) then
  begin
  GlobalIndex := TMenuItem(Sender).Tag;
  actPreview.OnExecute(actPreview);
  end;
end;

procedure TframeContractToolForm.RzPageChange(Sender: TObject);
begin
  inherited;
  BtnStatus;
  if CurContract <> nil then
  begin
    if CurContract.IsAudit then
       actAudit.Caption := '弃审'
    else
       actAudit.Caption := '审核';
    ToolButton1.Enabled := True;
  end
  else
  begin
    actAudit.Caption := '审核';
    ToolButton1.Enabled := False;
    actAudit.Enabled := False;
  end;
end;

function TframeContractToolForm.GetFormClass: TFormClass;
begin
  Result := TframeContractForm;
end;

procedure TframeContractToolForm.RzPageDblClick(Sender: TObject);
begin
  inherited;
  if RzPage.ActivePage.Data <> nil then
     begin
       if (TframeContractForm(RzPage.ActivePage.Data).dbState <> dsBrowse) and (TframeContractForm(RzPage.ActivePage.Data).Modifyed) then Raise Exception.Create('当前单据有修改，请保存后再关闭...');
       TframeContractForm(RzPage.ActivePage.Data).Close;
     end;
end;

procedure TframeContractToolForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var n:Integer;
begin
  inherited;
  if Application.Terminated then Exit;
  if not Freed then
  begin
    n := CheckNoSaveOrder;
    if n > 0 then
    begin
      Freed := True;
      CanClose := False;
      RzPage.ActivePageIndex := n;
      MessageBox(Handle,pchar('存在未保存的<'+Caption+'>单据，请选择保存或取消后才能退出？'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    end;
  end;
end;

procedure TframeContractToolForm.actExitExecute(Sender: TObject);
begin
  Freed := False;
  inherited;

end;

procedure TframeContractToolForm.WMExecOrder(var Message: TMessage);
begin
  case Message.LParam of
    0:if actSave.Enabled then actSave.OnExecute(actSave);
    1:if actDelete.Enabled then actDelete.OnExecute(actDelete);
    2:if actNew.Enabled then actNew.OnExecute(actNew);
    3:if actPrint.Enabled then actPrint.OnExecute(actPrint);
    4:if actAudit.Enabled then actAudit.OnExecute(actAudit);
    5:if actPrior.Enabled then actPrior.OnExecute(actPrior);
    6:if actNext.Enabled then actNext.OnExecute(actNext);
    7:if actCancel.Enabled then actCancel.OnExecute(actCancel);
    8:if actFind.Enabled then actFind.OnExecute(actFind);
    9:if actInfo.Enabled then actInfo.OnExecute(actInfo);
    10:if actPreview.Enabled then actPreview.OnExecute(actPreview);
    11:if actEdit.Enabled then actEdit.OnExecute(actEdit);
  end;
end;

procedure TframeContractToolForm.WMStatusChange(var Message: TMessage);
begin
  BtnStatus;
  RzPage.OnChange(RzPage);
end;

procedure TframeContractToolForm.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

procedure TframeContractToolForm.OpenForm(id, cid: string);
  function CheckExists:integer;
    var i:Integer;
  begin
    Result := -1;
    for i := 0 to RzPage.PageCount-1 do
    begin
      if RzPage.Pages[i].Data = nil then Continue;
      if (TframeContractForm(RzPage.Pages[i].Data).oid = id) and (TframeContractForm(RzPage.Pages[i].Data).cid = cid) then
         begin
           Result := i;
           Exit;
         end;
    end;
  end;
var p:Integer;
    form:TframeContractForm;
    page:TRzTabSheet;
begin
  p := CheckExists;
  if p >= 0 then
    begin
      RzPage.ActivePageIndex := p;
      Exit;
    end;
  p := CheckNewOrder;
  if p >= 0 then
    begin
      RzPage.ActivePageIndex := p;
      if cid = '' then
         TframeContractForm(RzPage.Pages[p].Data).cid := Global.SHOP_ID
      else
         TframeContractForm(RzPage.Pages[p].Data).cid := cid;
      TframeContractForm(RzPage.Pages[p].Data).Open(id);
      RzPage.OnChange(nil);
    end
  else
    begin
      page := TRzTabSheet.Create(RzPage);
      form := TframeContractForm(GetFormClass.Create(Self));
      try
        Inc(idx);
        page.Caption := '新建'+inttostr(idx);
        page.PageControl := RzPage;
        page.Data := form;
        page.Align := alClient;
        form.TabSheet := page;
        form.ContainerHanle := page.Handle;
        RzPage.ActivePage := page;
        form.SetParantDisplay(RzPage.ActivePage);
        if cid = '' then
           form.cid := Global.SHOP_ID
        else
           form.cid := cid;
        form.Open(id);
        RzPage.OnChange(nil);
      except
        page.Data := nil;
        form.TabSheet := nil;
        form.Free;
        page.Free;
        RzPage.ActivePageIndex := 0;
      end;
    end;
end;

procedure TframeContractToolForm.FormResize(Sender: TObject);
var
  i:integer;
  Form:TForm;
begin
  inherited;
  for i:=0 to rzPage.PageCount -1 do
    begin
      if rzPage.Pages[i].Data <> nil then
         begin
           Form := TframeContractForm(rzPage.Pages[i].Data);
           Form.SetBounds(rzPage.Pages[i].ClientRect.Left,rzPage.Pages[i].ClientRect.Top,rzPage.Pages[i].ClientWidth,rzPage.Pages[i].ClientHeight);
         end;
    end;
end;

procedure TframeContractToolForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if CurContract <> nil then
     begin
     if CurContract.IsKeyPress then
        inherited;
    end;

end;

procedure TframeContractToolForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_PRIOR) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,5);
     end;
  if (ssCtrl in Shift) and (Key = VK_NEXT) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,6);
     end;
  inherited;
  if (CurContract<>nil) then CurContract.OnKeyDown(Sender,Key,Shift);
end;

procedure TframeContractToolForm.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

end.
