unit uframeOrderToolForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,FR_Class,
  cxContainer, cxEdit, cxTextEdit, DB, ADODB, DBClient,uframeOrderForm,
  jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;
type
  TframeOrderToolForm = class(TframeToolForm)
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    ToolButton10: TToolButton;
    ToolButton13: TToolButton;
    dsList: TDataSource;
    ToolButton12: TToolButton;
    actPrior: TAction;
    actNext: TAction;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ppmReport: TPopupMenu;
    mnmFormer0: TMenuItem;
    mnmFormer1: TMenuItem;
    mnmFormer2: TMenuItem;
    mnmFormer3: TMenuItem;
    mnmFormer4: TMenuItem;
    mnmFormer5: TMenuItem;
    cdsList: TZQuery;
    procedure actNewExecute(Sender: TObject);
    procedure RzPageDblClick(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure ppmReportPopup(Sender: TObject);
    procedure mnmFormer5Click(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    idx:integer;
    Freed:boolean;
    function CheckNewOrder:integer;
    function CheckNoSaveOrder:integer;
    function GetCurOrder: TframeOrderForm;
  protected
    procedure Clear;
    procedure BtnStatus;virtual;
    function FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
  public
    { Public declarations }
    procedure WMStatusChange(var Message: TMessage); message WM_STATUS_CHANGE;
    procedure WMExecOrder(var Message: TMessage); message WM_EXEC_ORDER;
    procedure WMJoinData(var Message: TMessage); message WM_JOIN_DATA;
    procedure WndProc(var Message: TMessage); override;
    //必须重装
    function GetFormClass:TFormClass;virtual;
    procedure Add;
    procedure OpenForm(id:string;cid:string='');

    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    property CurOrder:TframeOrderForm read GetCurOrder;
  end;

implementation
uses uCtrlUtil,IniFiles,ufrmFastReport, uShopUtil, uGlobal, uXDictFactory, uShopGlobal;
{$R *.dfm}

{ TframeOrderToolForm }

procedure TframeOrderToolForm.Add;
var
  p:integer;
  form:TframeOrderForm;
  Page:TrzTabSheet;
begin
  p := CheckNewOrder;
  if p>=0 then
     begin
       rzPage.ActivePageIndex := p;
       if not CurOrder.IsNull then
          begin
            CurOrder.cid := Global.SHOP_ID;
            CurOrder.NewOrder;
            inc(idx);
            rzPage.ActivePage.Caption := '新建'+inttostr(idx);
          end
       else
          begin
            CurOrder.cid := Global.SHOP_ID;
            CurOrder.NewOrder;
            rzPage.ActivePage.Caption := '新建'+inttostr(idx);
          end;
     end
  else
     begin
       if (CurOrder<>nil) and ((CurOrder.dbState = dsBrowse) or CurOrder.IsNull or not CurOrder.Modifyed) then
          begin
            CurOrder.cid := Global.SHOP_ID;
            CurOrder.NewOrder;
            inc(idx);
            rzPage.ActivePage.Caption := '新建'+inttostr(idx);
            Exit;
          end;
       Page := TrzTabSheet.Create(rzPage);
       form := TframeOrderForm(GetFormClass.Create(self));
       try
         inc(idx);
         Page.Caption := '新建'+inttostr(idx);
         Page.PageControl := rzPage;
         Page.Data := form;
         Page.Align := alClient;
         form.TabSheet := Page;
         form.ContainerHanle := Page.Handle;
         rzPage.ActivePage := Page;
         form.SetParantDisplay(rzPage.ActivePage);
         form.cid := Global.SHOP_ID;
         form.NewOrder;
         RzPage.OnChange(nil);
       except
         Page.Data := nil;
         form.TabSheet := nil;
         form.Free;
         Page.Free;
         rzPage.ActivePageIndex := 0;
       end;
     end;
end;

function TframeOrderToolForm.CheckNewOrder: integer;
var
  i:integer;
  form:TframeOrderForm;
begin
  result := -1;
  for i:=0 to rzPage.PageCount - 1 do
    begin
       if rzPage.Pages[i].Data <> nil then
          begin
            form := TframeOrderForm(rzPage.Pages[i].Data);
            if form.isNull or (form.dbState = dsBrowse) or not form.Modifyed then
               begin
                 result := i;
                 Exit;
               end;
          end;
    end;
end;

procedure TframeOrderToolForm.actNewExecute(Sender: TObject);
begin
  inherited;
  Add;
end;

function TframeOrderToolForm.GetFormClass: TFormClass;
begin
  result := TframeOrderForm;
end;

procedure TframeOrderToolForm.RzPageDblClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePage.Data <> nil then
     begin
       if (TframeOrderForm(rzPage.ActivePage.Data).dbState <> dsBrowse) and TframeOrderForm(rzPage.ActivePage.Data).Modifyed then Raise Exception.Create('当前单据有修改，请保存后再关闭...'); 
       TframeOrderForm(rzPage.ActivePage.Data).Close;
     end;
end;

constructor TframeOrderToolForm.Create(AOwner: TComponent);
begin
  inherited;
  Freed := true;
  TDbGridEhSort.InitForm(self);
  BtnStatus;
  LoadFormRes(self);
  InitGridPickList(DBGridEh1);
end;

destructor TframeOrderToolForm.Destroy;
begin
  Freed := true;
  Clear;
  TDbGridEhSort.FreeForm(self); 
  inherited;
end;

procedure TframeOrderToolForm.Clear;
var i:integer;
begin
  for i:=rzPage.PageCount -1 downto 1 do
    begin
      if rzPage.Pages[i].Data <> nil then
         begin
            TframeOrderForm(rzPage.Pages[i].Data).Free;
         end;
    end;
end;

procedure TframeOrderToolForm.actFindExecute(Sender: TObject);
begin
  inherited;
  rzPage.ActivePageIndex := 0;
end;

procedure TframeOrderToolForm.OpenForm(id: string;cid:string='');
function CheckExists:integer;
var
  i:integer;
begin
  result := -1;
  for i:=0 to rzPage.PageCount -1 do
    begin
      if rzPage.Pages[i].Data = nil then continue;
      if (TframeOrderForm(rzPage.Pages[i].Data).oid = id) and (TframeOrderForm(rzPage.Pages[i].Data).cid=cid) then
         begin
           result := i;
           exit;
         end;
    end;
end;
var
  p:integer;
  form:TframeOrderForm;
  Page:TrzTabSheet;
begin
  p := CheckExists;
  if p>=0 then
     begin
       rzPage.ActivePageIndex := p;
       exit;
     end;
  p := CheckNewOrder;
  if p>=0 then
     begin
       rzPage.ActivePageIndex := p;
       if cid='' then
          TframeOrderForm(rzPage.Pages[p].Data).cid := Global.SHOP_ID
       else
          TframeOrderForm(rzPage.Pages[p].Data).cid := cid;
       TframeOrderForm(rzPage.Pages[p].Data).Open(id);
       RzPage.OnChange(nil);
     end
  else
     begin
       Page := TrzTabSheet.Create(rzPage);
       form := TframeOrderForm(GetFormClass.Create(self));
       try
         inc(idx);
         Page.Caption := '新建'+inttostr(idx);
         Page.PageControl := rzPage;
         Page.Data := form;
         Page.Align := alClient;
         form.TabSheet := Page;
         form.ContainerHanle := Page.Handle;
         rzPage.ActivePage := Page;
         form.SetParantDisplay(rzPage.ActivePage);
         if cid='' then
            form.cid := Global.SHOP_ID
         else
            form.cid := cid;
         form.Open(id);
         RzPage.OnChange(nil);
       except
         Page.Data := nil;
         form.TabSheet := nil;
         form.Free;
         Page.Free;
         rzPage.ActivePageIndex := 0;
       end;
     end;
end;

function TframeOrderToolForm.GetCurOrder: TframeOrderForm;
begin
  if not Assigned(RzPage.ActivePage.Data) then
     result := nil
  else
     result := TframeOrderForm(RzPage.ActivePage.Data);
end;

procedure TframeOrderToolForm.actEditExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.EditOrder;
     end;
end;

procedure TframeOrderToolForm.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.SaveOrder;
     end;

end;

procedure TframeOrderToolForm.actCancelExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if (CurOrder.dbState = dsInsert) and (CurOrder.IsNull) then
          begin
            if MessageBox(Handle,'没有输入任何商品资料,是否想关闭当前单据?','友情提示...',MB_YESNO+MB_ICONQUESTION) = 6 then
               begin
                 if TabSheet1.TabVisible then
                    CurOrder.Close
                 else
                    CurOrder.CancelOrder;
               end;
          end
       else
          begin
            if MessageBox(Handle,'是否取消刚才录入的所有修改？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            CurOrder.CancelOrder;
          end;
     end;

end;

procedure TframeOrderToolForm.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.DeleteOrder;
     end;

end;

procedure TframeOrderToolForm.actAuditExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.AuditOrder;
       RzPage.OnChange(nil);
     end;
end;

procedure TframeOrderToolForm.RzPageChange(Sender: TObject);
begin
  inherited;
  BtnStatus;
  if CurOrder<>nil then
     begin
       if CurOrder.IsAudit then
          actAudit.Caption := '弃审'
       else
          actAudit.Caption := '审核';
       ToolButton1.Enabled := true;
     end
  else
     begin
       actAudit.Caption := '审核';
       ToolButton1.Enabled := false;
       actAudit.Enabled := false;
     end;
end;

procedure TframeOrderToolForm.actPrintExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.PrintOrder;
     end;

end;

procedure TframeOrderToolForm.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.PreviewOrder;
     end;

end;

procedure TframeOrderToolForm.actPriorExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.PriorOrder;
     end;

end;

procedure TframeOrderToolForm.actNextExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       CurOrder.NextOrder;
     end;

end;

procedure TframeOrderToolForm.FormResize(Sender: TObject);
var
  i:integer;
  Form:TForm;
begin
  inherited;
  for i:=0 to rzPage.PageCount -1 do
    begin
      if rzPage.Pages[i].Data <> nil then
         begin
           Form := TframeOrderForm(rzPage.Pages[i].Data);
           Form.SetBounds(rzPage.Pages[i].ClientRect.Left,rzPage.Pages[i].ClientRect.Top,rzPage.Pages[i].ClientWidth,rzPage.Pages[i].ClientHeight);
         end;
    end;
end;

procedure TframeOrderToolForm.BtnStatus;
begin
  actSave.Enabled := Assigned(CurOrder) and (CurOrder.dbState in [dsInsert,dsEdit]);
  actCancel.Enabled := Assigned(CurOrder) and (CurOrder.dbState in [dsInsert,dsEdit]);
  actEdit.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actDelete.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);

  actNew.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actPrior.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actNext.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actAudit.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actPrint.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
  actPreview.Enabled := not Assigned(CurOrder) or not (CurOrder.dbState in [dsInsert,dsEdit]);
end;

procedure TframeOrderToolForm.WMStatusChange(var Message: TMessage);
begin
  BtnStatus;
  RzPage.OnChange(RzPage);
end;

procedure TframeOrderToolForm.WMExecOrder(var Message: TMessage);
begin
  case Message.LParam of
  0: if actSave.Enabled then actSave.OnExecute(actSave);
  1: if actDelete.Enabled then actDelete.OnExecute(actDelete);
  2: if actNew.Enabled then actNew.OnExecute(actNew);
  3: if actPrint.Enabled then actPrint.OnExecute(actPrint);
  4: if actAudit.Enabled then actAudit.OnExecute(actAudit);
  5: if actPrior.Enabled then actPrior.OnExecute(actPrior);
  6: if actNext.Enabled then actNext.OnExecute(actNext);
  7: if actCancel.Enabled then actCancel.OnExecute(actCancel);
  8: if actFind.Enabled then actFind.OnExecute(actFind);
  9: if actInfo.Enabled then actInfo.OnExecute(actInfo);
  10: if actPreview.Enabled then actPreview.OnExecute(actPreview);
  11: if actEdit.Enabled then actEdit.OnExecute(actEdit);
  end;
end;

procedure TframeOrderToolForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
  if (CurOrder<>nil) then CurOrder.OnKeyDown(Sender,Key,Shift);
end;

procedure TframeOrderToolForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if CurOrder<>nil then
     begin
       if CurOrder.IsKeyPress then
          inherited;
     end;

end;

procedure TframeOrderToolForm.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

function TframeOrderToolForm.CheckNoSaveOrder: integer;
var
  i:integer;
  form:TframeOrderForm;
begin
  result := -1;
  for i:=0 to rzPage.PageCount - 1 do
    begin
       if rzPage.Pages[i].Data <> nil then
          begin
            form := TframeOrderForm(rzPage.Pages[i].Data);
            if not form.isNull and (form.dbState <> dsBrowse) then
               begin
                 result := i;
                 Exit;
               end;
          end;
    end;
end;

procedure TframeOrderToolForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var n:integer;
begin
  inherited;
  if Application.Terminated then Exit;
  if not Freed then
  begin
  n := CheckNoSaveOrder;
  if n>=0 then
     begin
       Freed := true;
       CanClose := false;
       rzPage.ActivePageIndex := n;
       MessageBox(Handle,pchar('存在未保存的<'+Caption+'>单据，请选择保存或取消后才能退出？'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
     end;
  end;
end;

procedure TframeOrderToolForm.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    //DBGridEh1.Canvas.Font.Color := clWhite;
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TframeOrderToolForm.ppmReportPopup(Sender: TObject);
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

procedure TframeOrderToolForm.mnmFormer5Click(Sender: TObject);
begin
  inherited;
  if Assigned(actPreview.OnExecute) then
  begin
  GlobalIndex := TMenuItem(Sender).Tag;
  actPreview.OnExecute(actPreview);
  end; 
end;

function TframeOrderToolForm.FindColumn(DBGrid: TDBGridEh;
  FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
    begin
      if DBGrid.Columns[i].FieldName = FieldName then
         begin
           result := DBGrid.Columns[i];
           Exit;
         end;
    end;
end;

procedure TframeOrderToolForm.actExitExecute(Sender: TObject);
begin
  Freed := false;
  inherited;

end;

procedure TframeOrderToolForm.WMJoinData(var Message: TMessage);
var
  id,sid:string;
begin
  if Message.WParam=0 then Raise Exception.Create('传入单号不能为空');
  id := StrPas(Pchar(Message.WParam));
  if Message.LParam=0 then
     sid := StrPas(Pchar(Message.LParam));
  OpenForm(id,sid);
end;

procedure TframeOrderToolForm.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

end.
