unit ufrmRelationHandSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zBase, ExtCtrls, RzPanel, RzTabs, DBGrids, cxButtonEdit,
  zrComboBoxList;

const
  //国家烟草供应链ID:1000006
  NT_RELATION_ID=1000006;  

type
  TfrmRelationHandSet = class(TfrmBasic)
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    CdsTable: TZQuery;
    Ds: TDataSource;
    R3_GODS_ID: TzrComboBoxList;
    RzPage: TRzPageControl;
    TabUpResult: TRzTabSheet;
    RzPanel1: TRzPanel;
    Grid_Relation: TDBGridEh;
    Label1: TLabel;
    Edt_RimGods: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    SaveQry: TZQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
    procedure Grid_RelationCellClick(Column: TColumnEh);
    procedure btnOKClick(Sender: TObject);
  private
    FSecond_IDS: string;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure InitParams(vData: OleVariant);
  public
    class function FrmShow(vData: OleVariant): Integer;
  end;

implementation

uses uGlobal, ObjCommon;

{$R *.dfm}

class function TfrmRelationHandSet.FrmShow(VData: OleVariant):Integer;
begin
  result:=0;
  with TfrmRelationHandSet.Create(Application.MainForm) do
  begin
    try
      InitParams(vData);
      if ShowModal=MROK then
        result:=1;
    finally
      free;
    end;
  end;
end;


procedure TfrmRelationHandSet.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
 

function TfrmRelationHandSet.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
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

procedure TfrmRelationHandSet.InitParams(vData: OleVariant);
begin
  Grid_Relation.DataSource:=nil;
  R3_GODS_ID.DataSet:=Global.GetZQueryFromName('PUB_GOODSINFO');
  CdsTable.Close;
  CdsTable.Data:=vData;
  CdsTable.Filtered:=False;
  CdsTable.Filter:=' FLAG=''1'' ';
  CdsTable.Filtered:=true;
  FSecond_IDS:=',';
  CdsTable.First;
  while not CdsTable.Eof do
  begin
    FSecond_IDS:=FSecond_IDS+trim(CdsTable.fieldbyName('SECOND_ID').AsString)+',';
    CdsTable.Next;
  end;
  CdsTable.First;
  Edt_RimGods.Text:='货号：'+CdsTable.fieldbyName('GODS_CODE').AsString+
                    '  名称:'+CdsTable.fieldbyName('GODS_NAME').AsString;  
  Grid_Relation.DataSource:=Ds;
end;

procedure TfrmRelationHandSet.Grid_RelationDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Grid_Relation.Canvas.Font.Style :=[fsBold];
    Grid_Relation.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end else
    Grid_Relation.Canvas.Font.Style :=[];

  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    Grid_Relation.canvas.Brush.Color := clBtnFace;
    Grid_Relation.canvas.FillRect(ARect);
    DrawText(Grid_Relation.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end; 
end;

procedure TfrmRelationHandSet.Grid_RelationCellClick(Column: TColumnEh);
begin
  inherited;
  Edt_RimGods.Text:='货号：'+CdsTable.fieldbyName('GODS_CODE').AsString+
                    '  名称:'+CdsTable.fieldbyName('GODS_NAME').AsString; 
end;

procedure TfrmRelationHandSet.btnOKClick(Sender: TObject);
var
  Str,Cnd: string;
begin
  if R3_GODS_ID.AsString='' then raise Exception.Create('请选择R3的商品');
  //判断当前选入的是否已存在对照关系：
  SaveQry.Close;     //对照针对卷烟行业用，固定供应链:
  SaveQry.SQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+' and GODS_ID='''+R3_GODS_ID.AsString+''' ';
  Factor.Open(SaveQry);

  //保存
  SaveQry.Edit;
  if SaveQry.FieldByName('ROWS_ID').AsString='' then //返回空记录
  begin
    SaveQry.FieldByName('ROWS_ID').AsString:=NewId('');
    SaveQry.FieldByName('GODS_ID').AsString:=R3_GODS_ID.AsString;
    SaveQry.FieldByName('GODS_CODE').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_CODE').AsString;
    SaveQry.FieldByName('GODS_NAME').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_NAME').AsString;
    SaveQry.FieldByName('GODS_SPELL').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_SPELL').AsString;
    SaveQry.FieldByName('COMM').AsString:='00';
    SaveQry.FieldByName('TIME_STAMP').AsInteger:=1; //设置不空，后台在取
  end;
  SaveQry.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  SaveQry.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;
  SaveQry.FieldByName('COMM_ID').AsString:=FSecond_IDS; 
  SaveQry.FieldByName('SECOND_ID').AsString:=CdsTable.fieldbyName('SECOND_ID').AsString;  //Rim的GODS_ID
  SaveQry.FieldByName('SORT_ID2').AsString:=CdsTable.fieldbyName('SORT_ID2').AsString;
  SaveQry.FieldByName('SORT_ID6').AsString:=CdsTable.fieldbyName('SORT_ID6').AsString;
  SaveQry.FieldByName('NEW_INPRICE').AsFloat:=CdsTable.fieldbyName('NEW_INPRICE').AsFloat;
  SaveQry.FieldByName('NEW_OUTPRICE').AsFloat:=CdsTable.fieldbyName('NEW_OUTPRICE').AsFloat;
  SaveQry.Post;
  //提交
  if Factor.UpdateBatch(SaveQry,'THandSetRelation',nil) then
    MessageBox(Application.Handle,pchar('保存成功！'),'友情提示...',MB_OK+MB_ICONQUESTION); 
end;

end.
