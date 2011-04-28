{ 到货物确认：
  (1)、供应商: 是烟草公司;
  (2)、订单一天只有一单，若存在多单情况则进行合并为一张。

}


unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, DB, 
  ExtCtrls, RzPanel, DBClient, Grids, DBGridEh, cxButtonEdit, zrComboBoxList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, zBase, DBGrids, Buttons;

type
  TfrmDownStockOrder = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Ds: TDataSource;
    cdsTable: TZQuery;
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    CdsStockData: TZQuery;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    function FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh; 
    function GetOrderDate: TDate;
    function GetINDE_ID: string;
  public
    FAobj: TRecord_;
    FReData: OleVariant; //返回数据包
    procedure OpenIndeOrderList;  //查询订单主表数据
    procedure DoCopyIndeOrderData;    //将选中的订单明细处理到中间表
    class function DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
    property OrderDate: TDate read GetOrderDate;
  end;


implementation

uses
  uFnUtil, uGlobal, uShopGlobal;  //ufrmCallIntf,

{$R *.dfm}

{ TfrmDownStockOrder }

class function TfrmDownStockOrder.DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  try
    FrmObj:=TfrmDownStockOrder.Create(nil);
    FrmObj.FAobj:=Aobj;
    FrmObj.OpenIndeOrderList;  //查询订单的主表数据
    if FrmObj.ShowModal=MROK then
    begin
      vData:=FrmObj.FReData;
      result:=true;
    end;
  finally
    FrmObj.Free;
  end;
end;

procedure TfrmDownStockOrder.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDownStockOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('11200001',2) then Raise Exception.Create('你没有权限操作到货确认（生成入库单！）');
  if cdsTable.IsEmpty then Raise Exception.Create(' 没有订单！ ');
  if trim(CdsTable.fieldbyName('INDE_ID').AsString)<>'' then
  begin
    self.DoCopyIndeOrderData;  //复制明细数据
    FAobj.ReadFromDataSet(cdsTable);  //读取返回值
    ModalResult:=MROK; //正常返回
  end;
end;

procedure TfrmDownStockOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsTable.RecNo = 1 then AFont.Style := [fsBold];
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DBGridEh1.canvas.Brush.Color := $0000F2F2;
    DBGridEh1.canvas.FillRect(ARect);
    DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

function TfrmDownStockOrder.GetOrderDate: TDate;
begin
  if cdsTable.Active then
    fnTime.fnStrtoDate(cdsTable.fieldbyName('CRT_DATE').AsString);
end;

function TfrmDownStockOrder.GetINDE_ID: string;
begin
  if cdsTable.Active then
    result:=trim(CdsTable.fieldbyName('INDE_ID').AsString);
end;

procedure TfrmDownStockOrder.OpenIndeOrderList;
var
  UseDate: string; //启用日期
  Rs: TZQuery;
  vParam: TftParamList;
begin
  try
    //启用日期  
    Rs:=Global.GetZQueryFromName('SYS_DEFINE');
    if (Rs<>nil) and (Rs.Active) then
    begin
      if Rs.Locate('DEFINE','USING_DATE', []) then
      begin
        UseDate:=trim(Rs.fieldbyName('VALUE').AsString);
        UseDate:=FormatDateTime('YYYYMMDD', fnTime.fnStrtoDate(UseDate));
      end else
        UseDate:='';
    end;

    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=1;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParam.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;
    vParam.ParamByName('USING_DATE').AsString:=UseDate;
    Global.RemoteFactory.Open(CdsTable,'TDownOrder',vParam);  //==RspServer连接模式时执行
  finally
    vParam.Free;
  end;
end;

procedure TfrmDownStockOrder.DoCopyIndeOrderData;
 function GetNum(Idx: integer): string;
 begin
   if Idx<10 then
     result:='    '+inttoStr(Idx)+' '
   else
     result:='    '+inttoStr(Idx);
 end;
var
  i: integer;
  Msg,Str: String;
  vParam: TftParamList;
begin
  i:=0;
  try
    CdsStockData.Close;
    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=2;
    vParam.ParamByName('INDE_ID').AsString:=GetINDE_ID;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Global.RemoteFactory.Open(CdsStockData,'TDownIndeData',vParam);  //==RspServer连接模式时执行
    if (CdsStockData.Active) and (CdsStockData.RecordCount>0) then
    begin
      Msg:='';
      CdsStockData.First;
      while not CdsStockData.Eof do
      begin
        if trim(CdsStockData.FieldByName('GODS_ID').AsString)='' then
          Inc(i);
        CdsStockData.Next; 
      end;
      if i>0 then
      begin
        Str:='系统检测到当前下载的订单,存在'+inttoStr(i)+'个商品没有对照关系！';
        Raise Exception.Create(Str);
      end;
      FReData:=CdsStockData.Data;
    end;
  finally
    vParam.Free;
  end;
end;
 

function TfrmDownStockOrder.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
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

procedure TfrmDownStockOrder.FormCreate(Sender: TObject);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
  Rs:=Global.GetZQueryFromName('CA_TENANT'); 
  SetCol:=FindColumn(DBGridEh1,'TENANT_ID');
  if (SetCol<>nil) and (Rs.Active) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(trim(Rs.FieldByName('TENANT_ID').AsString));
      SetCol.PickList.Add(trim(Rs.FieldByName('TENANT_NAME').AsString));  
      Rs.Next;
    end;
  end;
end;

end.
