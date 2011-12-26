unit uframeContractForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, cxDropDownEdit, cxTextEdit, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, Grids, DBGridEh, RzTabs,
  ExtCtrls, StdCtrls, RzPanel, ActnList, Menus, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset;

const
  //状态改变
  WM_STATUS_CHANGE=WM_USER+2;
  //单据操作
  WM_EXEC_ORDER=WM_USER+3;

  WM_INIT_RECORD=WM_USER+4;
  WM_NEXT_RECORD=WM_USER+5;
  WM_PRIOR_RECORD=WM_USER+6;  
    
type
  TframeContractForm = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel4: TRzPanel;
    Shape1: TShape;
    lblCaption: TLabel;
    Image1: TImage;
    lblState: TLabel;
    RzPanel3: TRzPanel;
    DBGridEh1: TDBGridEh;
    stbHint: TRzPanel;
    rzHelp: TRzPanel;
    dsTable: TDataSource;
    cdsDetail: TZQuery;
    cdsHeader: TZQuery;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FdbState: TDataSetState;
    FIsAudit: boolean;
    FModifyed: boolean;
    Foid: string;
    Fcid: String;
    FTabSheet: TrzTabSheet;
    Fgid: string;
    FSaved: boolean;
    procedure SetIsAudit(const Value: boolean);
    procedure SetModifyed(const Value: boolean);
    procedure Setoid(const Value: string);
    function Getcid: string;
    procedure Setcid(const Value: string);
    procedure SetTabSheet(const Value: TrzTabSheet);
    procedure Setgid(const Value: string);
    procedure SetSaved(const Value: boolean);
    procedure WMInitRecord(var Message: TMessage); message WM_INIT_RECORD;
    procedure WMNextRecord(var Message: TMessage); message WM_NEXT_RECORD;
    procedure WMPriorRecord(var Message: TMessage); message WM_PRIOR_RECORD;
    { Private declarations }
  protected
    function GetToolHandle:THandle;
    procedure SetdbState(const Value: TDataSetState);virtual;
    function GetIsNull: boolean;virtual;
  public
    { Public declarations }
    AObj:TRecord_;
    function IsKeyPress:boolean;virtual;
    procedure InitRecord;virtual;
    function  FindColumn(FieldName:string):TColumnEh;

    procedure NewOrder;virtual;
    procedure EditOrder;virtual;
    procedure DeleteOrder;virtual;
    procedure SaveOrder;virtual;
    procedure CancelOrder;virtual;
    procedure AuditOrder;virtual;
    procedure PrintOrder;virtual;
    procedure PreviewOrder;virtual;
    procedure PriorOrder;virtual;
    procedure NextOrder;virtual;
    procedure Open(id:string);virtual;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    //单据状态
    property dbState:TDataSetState read FdbState write SetdbState;
    property IsAudit:boolean read FIsAudit write SetIsAudit;
    property IsNull:boolean read GetIsNull;
    property oid:string read Foid write Setoid;
    property cid:string read Getcid write Setcid;
    property gid:string read Fgid write Setgid;
    property Modifyed:boolean read FModifyed write SetModifyed;
    property Saved:boolean read FSaved write SetSaved;
    property TabSheet:TrzTabSheet read FTabSheet write SetTabSheet;      
  end;

implementation
uses uShopGlobal, uGlobal, uShopUtil;
{$R *.dfm}

{ TframeContractForm }

procedure TframeContractForm.AuditOrder;
begin

end;

procedure TframeContractForm.CancelOrder;
begin

end;

constructor TframeContractForm.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TframeContractForm.DeleteOrder;
begin

end;

destructor TframeContractForm.Destroy;
begin
  Freeform(self);
  if TabSheet<>nil then
     begin
       if TabSheet.PageControl.ActivePageIndex>0 then
          TabSheet.PageControl.ActivePageIndex := TabSheet.PageControl.ActivePageIndex-1;
       Visible := false;
       Parent := nil;
       TabSheet.Free;
     end;
  AObj.Free;
  inherited;
end;

procedure TframeContractForm.EditOrder;
begin

end;

function TframeContractForm.Getcid: string;
begin
  if Fcid = '' then Result := Global.SHOP_ID else Result := Fcid;
end;

function TframeContractForm.GetIsNull: boolean;
begin
  result := cdsDetail.IsEmpty;
end;

function TframeContractForm.IsKeyPress: boolean;
begin
  Result := True;
end;

procedure TframeContractForm.NewOrder;
begin

end;

procedure TframeContractForm.NextOrder;
begin

end;

procedure TframeContractForm.Open(id: string);
begin

end;

procedure TframeContractForm.PreviewOrder;
begin

end;

procedure TframeContractForm.PrintOrder;
begin

end;

procedure TframeContractForm.PriorOrder;
begin

end;

procedure TframeContractForm.SaveOrder;
begin

end;

procedure TframeContractForm.Setcid(const Value: string);
begin
  Fcid := Value;  
end;

procedure TframeContractForm.SetdbState(const Value: TDataSetState);
begin
  if Value <> dsBrowse then InitRecord;
  FdbState := Value;
  case Value of
  dsBrowse:lblState.Caption := '状态:浏览';
  dsEdit:lblState.Caption := '状态:修改';
  dsInsert:lblState.Caption := '状态:新增';
  end;
  SetFormEditStatus(self,Value);
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  {Column := FindColumn('GODS_CODE');
  if Column<>nil then Column.ReadOnly := true;}
  if Assigned(TabSheet) then
  begin
    PostMessage(GetToolHandle,WM_STATUS_CHANGE,0,0);
  end;
end;

procedure TframeContractForm.Setgid(const Value: string);
begin
  Fgid := Value;
  lblCaption.Caption := '单号:'+Value;  
end;

procedure TframeContractForm.SetIsAudit(const Value: boolean);
begin
  FIsAudit := Value;
  if Value then
     begin
        Image1.Visible := True;
     end
  else
     begin
        Image1.Visible := False;
     end;
  PostMessage(GetToolHandle,WM_STATUS_CHANGE,0,0);  
end;

procedure TframeContractForm.SetModifyed(const Value: boolean);
begin
  FModifyed := Value;
end;

procedure TframeContractForm.Setoid(const Value: string);
begin
  Foid := Value;
end;

procedure TframeContractForm.SetSaved(const Value: boolean);
begin
  FSaved := Value;
end;

procedure TframeContractForm.SetTabSheet(const Value: TrzTabSheet);
begin
  FTabSheet := Value;
end;

procedure TframeContractForm.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if ((gdSelected in State) or (gdFocused in State)) then
    begin
      ARect := Rect;
      DBGridEh1.Canvas.Pen.Color := clRed;
      DBGridEh1.Canvas.Pen.Width := 1;
      DBGridEh1.Canvas.Brush.Style := bsClear;
      DbGridEh1.canvas.Rectangle(ARect);
      stbHint.Caption := Column.Title.Hint;
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TframeContractForm.InitRecord;
begin

end;

procedure TframeContractForm.WMInitRecord(var Message: TMessage);
begin
  InitRecord;
end;

procedure TframeContractForm.WMNextRecord(var Message: TMessage);
begin
  if cdsDetail.Active then
    begin
      cdsDetail.Next;
      if cdsDetail.Eof then
         PostMessage(Handle,WM_INIT_RECORD,0,0);
    end;
end;

procedure TframeContractForm.WMPriorRecord(var Message: TMessage);
begin
  if cdsDetail.Active then cdsDetail.Prior;
end;

function TframeContractForm.GetToolHandle: THandle;
var w:TWinControl;
begin
  result := 0;
  if Assigned(TabSheet) then
  begin
  w := TabSheet.Parent;
  while w<>nil do
    begin
      if w is TForm then
         begin
           result := w.Handle;
           Exit;
         end;
      w := w.Parent;
    end;
  end;
end;

function TframeContractForm.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;

procedure TframeContractForm.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
begin
  inherited;
  Cell := DBGridEh1.MouseCoord(X,Y);
  if Cell.Y > DBGridEh1.VisibleRowCount -2 then
     InitRecord;
end;

procedure TframeContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and (Key in [ord('D'),ord('d')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,1);
       end;
     end;
  if (ssCtrl in Shift) and (Key in [ord('I'),ord('i')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,2);
       end;
     end;
  if (ssCtrl in Shift) and (Key in [ord('S'),ord('s')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,0);
       end;
     end;
  if (ssCtrl in Shift) and (Key in [ord('Z'),ord('z')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,7);
       end;
     end;
  if (ssCtrl in Shift) and (Key = VK_END) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,4);
       end;
     end;
  if (ssCtrl in Shift) and (Key = VK_PRIOR) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,5);
       end;
     end;
  if (ssCtrl in Shift) and (Key = VK_NEXT) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,6);
       end;
     end;
  if (ssCtrl in Shift) and (Key = VK_F5) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,8);
       end;
     end;
  if (ssCtrl in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,3);
       end;
     end;
  if (ssCtrl in Shift) and (ssShift in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,10);
       end;
     end;
  if (ssCtrl in Shift) and (Key in [ord('E'),ord('e')]) then
     begin
       if Assigned(TabSheet) then
       begin
         PostMessage(GetToolHandle,WM_EXEC_ORDER,0,11);
       end;
     end;
end;

end.
