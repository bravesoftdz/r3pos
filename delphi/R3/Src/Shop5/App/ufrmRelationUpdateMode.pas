unit ufrmRelationUpdateMode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zBase, ExtCtrls, RzPanel, RzTabs, DBGrids;

type
  TfrmRelationUpdateMode = class(TfrmBasic)
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    RzPage: TRzPageControl;
    TabUpMode: TRzTabSheet;
    RzPanel2: TRzPanel;
    TabUpResult: TRzTabSheet;
    RzPanel1: TRzPanel;
    edtCHECK_TYPE: TGroupBox;
    RB_ALL: TRadioButton;
    RB_NEW: TRadioButton;
    RB_PRICE: TRadioButton;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    Grid_Relation: TDBGridEh;
    CdsTable: TZQuery;
    Ds: TDataSource;
    LblMsg: TLabel;
    stbPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
  private
    function  DoUpdateRelation: Boolean; //更新对照关系
    procedure SetPageTable(PageIdx: integer); //设置分页
    function  GetUpdateMode: integer;  //返回刷新模式
  public
    class function FrmShow: Integer;
  end;

implementation

uses uGlobal;

{$R *.dfm}

class function TfrmRelationUpdateMode.FrmShow:Integer;
begin
  result:=0;
  with TfrmRelationUpdateMode.Create(Application.MainForm) do
  begin
    try    
      if ShowModal=MROK then
        result:=1;
    finally
      free;
    end;
  end;
end;

function TfrmRelationUpdateMode.GetUpdateMode: integer;
begin
  if RB_ALL.Checked then
    result:=1
  else if RB_NEW.Checked then
    result:=2
  else if RB_PRICE.Checked then
    result:=3;
end;

procedure TfrmRelationUpdateMode.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelationUpdateMode.SetPageTable(PageIdx: integer);
begin
  RzPage.ActivePageIndex:=PageIdx;
  btnOK.Visible:=(PageIdx=0);
  LblMsg.Visible:=(PageIdx=1);
  case PageIdx of
   0:
    begin
      Width:=413;
      Height:=276;
    end;
   1:
    begin
      self.Top:=self.Top-62;
      self.Left:=self.Left-72;
      Width:=530;
      Height:=400;
      btnCancel.Left:=BottonPanel.Width - btnCancel.Width - 30;
      btnCancel.Caption:='关闭(&C)';
      if RB_ALL.Checked then
        LblMsg.Caption:='刷新方式：'+RB_ALL.Caption
      else if RB_NEW.Checked then
        LblMsg.Caption:='刷新方式：'+RB_NEW.Caption
      else if RB_PRICE.Checked then
        LblMsg.Caption:='刷新方式：'+RB_PRICE.Caption;
      LblMsg.Left:=TitlePanel.Width - LblMsg.Width - 30;      
    end;
  end;
end;

procedure TfrmRelationUpdateMode.FormCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  for i:=0 to RzPage.PageCount-1 do
    RzPage.Pages[i].TabVisible:=False;
  self.SetPageTable(0); 
end;

procedure TfrmRelationUpdateMode.btnOKClick(Sender: TObject);
begin
  inherited;
  if (RzPage.ActivePageIndex=0) and (btnOK.Visible) then
  begin
    if DoUpdateRelation then
      self.SetPageTable(1);
  end;
end;

function TfrmRelationUpdateMode.DoUpdateRelation: Boolean;
var
  vParams: TftParamList;
begin
  result:=False;                 
  try
    vParams:=TftParamList.Create(nil);
    vParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParams.ParamByName('UPDATE_MODE').AsInteger:=GetUpdateMode;
    Factor.Open(CdsTable,'TSynchronGood_Relation',vParams);  //==RspServer连接模式时执行
    result:=CdsTable.Active;
  finally
    vParams.Free;
  end;
end;

procedure TfrmRelationUpdateMode.Grid_RelationDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect: TRect;
  GridDs: TDataSet;
begin
  inherited;
  GridDs:=Grid_Relation.DataSource.DataSet;
  if (GridDs=nil) or (not GridDs.Active) then Exit;
  if (Rect.Top = Grid_Relation.CellRect(Grid_Relation.Col, Grid_Relation.Row).Top) and (not
    (gdFocused in State) or not Grid_Relation.Focused) then
  begin
    Grid_Relation.Canvas.Brush.Color := clAqua;
  end;
  if (trim(GridDs.FieldByName('Update_Flag').AsString)='0') and (trim(LowerCase(Column.FieldName))='updatecase') then
  begin
    Grid_Relation.Canvas.Font.Color := clRed;
  end;
  
  Grid_Relation.DefaultDrawColumnCell(Rect, DataCol, Column, State);


  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    Grid_Relation.canvas.FillRect(ARect);
    DrawText(Grid_Relation.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)), length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

end.
