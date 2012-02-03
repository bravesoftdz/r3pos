unit ufrmOrderHandSet;
                                                                                          
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, RzLabel, Grids, DBGridEh, RzButton, DB,ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxButtonEdit, zrComboBoxList;

type
  TfrmOrderHandSet = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnOK: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsList: TDataSource;
    cdsList: TZQuery;
    LblMsg: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    Fflag: integer;
    FOrderID: string;
    ReRun: Boolean;  //运行回返值
    procedure Setflag(const Value: integer);
    function  FindColumn(Grid: TDBGridEh; FieldName:string):TColumnEh;
    procedure SetOrderID(const Value: string);
    function  DoOrderEnd(BILL_ID: string): Boolean;
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    class function FindDialog(AOwner:TForm; oFlag:integer; InOrderID:string): Boolean;
    property flag:integer read Fflag write Setflag;
    property OrderID: string read FOrderID write SetOrderID;
  end;

implementation

uses uGlobal, uShopUtil, uShopGlobal;

{$R *.dfm}

{ TfrmPosMainList }

function TfrmOrderHandSet.EncodeSQL(id: string): string;
var Str,w:string;
begin
  w:=' where A.TENANT_ID=:TENANT_ID and A.FROM_ID=:FROM_ID ';
  case flag of
   1: //入库单
    begin
      w:=w+ShopGlobal.GetDataRight('A.SHOP_ID',1);
      Str:=
        'select A.TENANT_ID as TENANT_ID,A.STOCK_ID as BILL_ID,A.GLIDE_NO as GLIDE_NO,A.STOCK_DATE as BILL_DATE,A.CLIENT_ID as CLIENT_ID,A.ADVA_MNY as ADVA_MNY,B.SHOP_NAME as SHOP_NAME '+
        ' from STK_STOCKORDER A '+
        ' left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w;
      result:=
        'select ja.*,a.CLIENT_NAME as CLIENT_NAME from ('+Str+') ja '+
        ' left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID '+
        ' order by ja.BILL_DATE,ja.GLIDE_NO';
    end;
   2: //销售单
    begin
      w:=w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2);
      Str:=
       'select A.TENANT_ID as TENANT_ID,A.SALES_ID as BILL_ID,A.GLIDE_NO as GLIDE_NO,A.SALES_DATE as BILL_DATE,A.CLIENT_ID as CLIENT_ID,A.ADVA_MNY as ADVA_MNY,B.SHOP_NAME as SHOP_NAME '+
       ' from SAL_SALESORDER A '+
       ' left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w;
      result:=
       'select ja.*,a.CLIENT_NAME as CLIENT_NAME from ('+Str+') ja '+
       ' left join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID '+
       ' order by ja.BILL_DATE,ja.GLIDE_NO';
    end;
  end;
end;

procedure TfrmOrderHandSet.Open(Id:string);
begin
  cdsList.close;
  try
    cdsList.SQL.Text := EncodeSQL(Id);
    cdsList.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if cdsList.Params.FindParam('FROM_ID')<>nil then cdsList.Params.FindParam('FROM_ID').AsString := OrderID;
    Factor.Open(cdsList);
  except
  end;
end;

procedure TfrmOrderHandSet.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmOrderHandSet.btnOKClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then
     begin
       Raise Exception.Create('没有选中你要查询的单据...');
     end;
  self.ModalResult := MROK;
end;

class function TfrmOrderHandSet.FindDialog(AOwner: TForm; oFlag:integer; InOrderID:string): Boolean;
var
  Msg,BillID: string;
begin
  result:=False;
  BillID:='';
  with TfrmOrderHandSet.Create(AOwner) do
  begin
    if oFlag=1 then
      Msg:=' 没找不到对应的入库单... '
    else if oFlag=2 then
      Msg:=' 没找不到对应的销售出货单... ';
    try
      flag := oFlag;
      OrderID := InOrderID;
      Open('');
      //选择对应单据ID
      case cdsList.RecordCount of
       0: raise Exception.Create(Pchar(Msg));
       1:
         begin
           BillID:=trim(cdsList.fieldByName('BILL_ID').AsString);
           if MessageBox(Handle,Pchar('   真的要手工结案吗？   '),pchar('提示...'),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
           if BillID='' then raise Exception.Create(Pchar(Msg));
           result:=DoOrderEnd(BillID);
         end;
       else
        begin
          cdsList.Last; //移动到最后一条
          if ShowModal=MROK then
          begin
            BillID:=trim(cdsList.fieldByName('BILL_ID').AsString);
            if BillID='' then raise Exception.Create(Pchar(Msg));
            result:=DoOrderEnd(BillID);
          end;
        end;
      end;
    finally
      free;
    end;
  end;
end;

procedure TfrmOrderHandSet.Setflag(const Value: integer);
var
  SetCol: TColumnEh;
begin
  Fflag := Value;
  case flag of
   1:
    begin
      Caption:='采购订单结案';
      TabSheet1.Caption:='采购订单列表';
      SetCol:=FindColumn(DBGridEh1,'CLIENT_NAME');
      if SetCol<>nil then SetCol.Title.Caption:='供应商名称';
    end;
  2:
    begin
      Caption:='销售订单结案';
      TabSheet1.Caption:='销售订单列表';
      SetCol:=FindColumn(DBGridEh1,'CLIENT_NAME');
      if SetCol<>nil then SetCol.Title.Caption:='客户名称';
    end;
  end;
  if ShopGlobal.GetProdFlag = 'E' then
  begin
    SetCol:=FindColumn(DBGridEh1,'SHOP_NAME');
    if SetCol<>nil then SetCol.Title.Caption:='所属仓库';
  end;
end;

procedure TfrmOrderHandSet.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //选中颜色状态
    Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmOrderHandSet.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  btnOKClick(nil);
end;

function TfrmOrderHandSet.FindColumn(Grid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to Grid.Columns.Count -1 do
  begin
    if UpperCase(Grid.Columns[i].FieldName)=UpperCase(FieldName) then
    begin
      Result:=Grid.Columns[i];
      Exit;
    end;
  end;
end;

procedure TfrmOrderHandSet.SetOrderID(const Value: string);
begin
  FOrderID := Value;
end;

function TfrmOrderHandSet.DoOrderEnd(BILL_ID: string): Boolean;
var
  Params: TftParamList;
begin
  result:=False;
  try
    Params:=TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Params.ParamByName('FROM_ID').AsString:=OrderID;
    Params.ParamByName('BILL_ID').AsString:=BILL_ID;
    try                 
      case Fflag of
       1: Factor.ExecProc('TStkIndentOrderHandClosed',Params);
       2: Factor.ExecProc('TSalIndentOrderHandClosed',Params);
      end;
      result:=true;
    except
    end;
  finally
    Params.Free;
  end;
end;

end.
