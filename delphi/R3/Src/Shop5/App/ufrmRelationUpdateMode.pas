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
    PnlMsg: TPanel;
    RB_ViewAll: TRadioButton;
    RB_ViewOld: TRadioButton;
    RB_ViewNot: TRadioButton;
    RB_ViewNew: TRadioButton;
    LblMemo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure RB_ViewAllClick(Sender: TObject);
  private
    FAllcount, //当前返回总记录数
    FNotcount, //未对上
    FNewcount, //新对上
    FOldCount: integer;  //原对上
    function  DoUpdateRelation: Boolean; //更新对照关系
    procedure SetResultMsg;  //设置结果显示
    procedure SetPageTable(PageIdx: integer); //设置分页
    procedure DoFilterResultData;   //过滤数据
    procedure SetUpdateModeResult;  //设置返回结果
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
      self.Top:=self.Top-65;
      self.Left:=self.Left-80;
      Width:=600;
      Height:=460;
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
    begin
      self.SetPageTable(1);
      self.SetUpdateModeResult;
    end;
  end;
end;

function TfrmRelationUpdateMode.DoUpdateRelation: Boolean;
var
  vParams: TftParamList;
begin
  result:=False;
  try
    FAllcount:=0;
    vParams:=TftParamList.Create(nil);
    vParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParams.ParamByName('UPDATE_MODE').AsInteger:=GetUpdateMode;    
    Factor.Open(CdsTable,'TSynchronGood_Relation',vParams);  //==RspServer连接模式时执行
    result:=CdsTable.Active;
    if result then SetResultMsg;  //显示结果说明
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

procedure TfrmRelationUpdateMode.SetUpdateModeResult;
begin
  RB_ViewAll.Checked:=true;
  //设置控件显示
  RB_ViewAll.Visible:=true;
  RB_ViewNot.Visible:=true;
  if RB_ALL.Checked then
  begin
    RB_ViewNew.Visible:=true;
    RB_ViewOld.Visible:=true;
  end else
  if RB_NEW.Checked then
    RB_ViewNew.Visible:=true
  else if RB_PRICE.Checked then
  begin
    RB_ViewOld.Visible:=true;
    RB_ViewOld.Left:=RB_ViewNew.Left;
  end;
end;

procedure TfrmRelationUpdateMode.DoFilterResultData;
var
  FilterCnd: string;
begin
  if not CdsTable.Active then Exit;
  if RB_ViewAll.Checked then
  begin
    FilterCnd:='';
    if trim(CdsTable.Filter)='' then Exit;
  end
  else if RB_ViewNot.Checked then
    FilterCnd:=' Update_Flag=0 '
  else if RB_ViewNew.Checked then
    FilterCnd:=' Update_Flag=2 '
  else if RB_ViewOld.Checked then
    FilterCnd:=' Update_Flag=1 ';
  try
    CdsTable.Filtered:=False;
    CdsTable.Filter:=FilterCnd;
    CdsTable.Filtered:=true;
  except
  end
end;

procedure TfrmRelationUpdateMode.RB_ViewAllClick(Sender: TObject);
begin
  inherited;
  DoFilterResultData;
end;

procedure TfrmRelationUpdateMode.SetResultMsg;
var
  FieldIdx: integer;
begin
  FAllcount:=0;
  FNotcount:=0;
  FNewcount:=0;
  FOldCount:=0;
  if not CdsTable.Active then Exit;

  FAllcount:=CdsTable.RecordCount;  //返回总记录数据
  FieldIdx:=CdsTable.fieldbyName('Update_Flag').Index; 
  try
    CdsTable.DisableControls;
    CdsTable.First;
    while not CdsTable.Eof do
    begin
      case CdsTable.Fields[FieldIdx].AsInteger of
       0: inc(FNotcount);
       1: inc(FOldCount);
       2: inc(FNewcount);
      end;
      CdsTable.Next;
    end;
    if RB_ALL.Checked then
      PnlMsg.Caption:=' 对照结果：总数：'+Inttostr(FAllcount)+'，其中未对上：'+Inttostr(FNotcount)+'，本次对照：'+inttostr(FNewcount)+'，原对照：'+inttostr(FOldCount)+''
    else if RB_NEW.Checked then
      PnlMsg.Caption:=' 对照结果：总数：'+Inttostr(FAllcount)+'，其中未对上：'+Inttostr(FNotcount)+'，本次对照：'+inttostr(FNewcount)+' '
    else if RB_NEW.Checked then
      PnlMsg.Caption:=' 对照结果：总数：'+Inttostr(FAllcount)+'，其中未对上：'+Inttostr(FNotcount)+'，原对照：'+inttostr(FNewcount)+' ';
  finally
    CdsTable.EnableControls;
  end; 
end;

end.
