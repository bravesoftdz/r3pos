{ ������ȷ�ϣ�
  (1)����Ӧ��: ���̲ݹ�˾;
  (2)������һ��ֻ��һ���������ڶ൥�������кϲ�Ϊһ�š�

}


unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, DB, 
  ExtCtrls, RzPanel, DBClient, Grids, DBGridEh, cxButtonEdit, zrComboBoxList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, zBase;

type
  TfrmDownStockOrder = class(TfrmBasic)
    RzPanel1: TRzPanel;
    DataSource1: TDataSource;
    cdsTable: TZQuery;
    DataSet: TZQuery;
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    FParam: TftParamList;
    function GetOrderDate: TDate;
    procedure InitalParams(InParam: TftParamList);
  public
    procedure OpenOrder(ClientID: string);  //��ѯ��������������
    class function DownStockOrder(var vParam: TftParamList; var OutCds: TZQuery):boolean;
    property OrderDate: TDate read GetOrderDate;
  end;


implementation

uses
  uFnUtil, uGlobal, uShopGlobal;  //ufrmCallIntf,

{$R *.dfm}

{ TfrmDownStockOrder }

class function TfrmDownStockOrder.DownStockOrder(var vParam: TftParamList;var OutCds: TZQuery):boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  try
    FrmObj:=TfrmDownStockOrder.Create(nil);
    FrmObj.InitalParams(vParam);
    if FrmObj.ShowModal=MROK then
    begin
      result:=true;
      vParam:=FrmObj.FParam;
      OutCds.Close;
      OutCds.Data:=FrmObj.DataSet.Data;
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
var
  IsTrue: Boolean;
  CurDate: string;
  rs: TZQuery;
begin
  inherited;
  if cdsTable.IsEmpty then Raise Exception.Create('��ѡ����ȷ�Ķ������ڡ���Ӧ��...');
  ShopGlobal.GlobalAtteProc('6004',1,IsTrue);
  if not IsTrue then Raise Exception.Create('��û��Ȩ�޲�������ȷ�ϣ�������ⵥ����');

  CurDate:=FormatDatetime('YYYYMMDD',OrderDate);
  try
    rs:= TZQuery.Create(nil);
    rs.Close;
    // rs.SQL.Text:='select count(*) from STK_STOCKORDER where COMP_ID='''+CompID+''' and CLIENT_ID='''+edtCLIENT_ID.AsString+''' and COMM_ID=''DWN'+CurDate+'''';
    Factor.Open(rs);
    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('ϵͳ���'+formatDatetime('YYYY/MM/DD', OrderDate)+'�Ѿ�����ⲻ����������');
  finally
    rs.Free;
  end;

  //���ڵ�����ϸ
  // if not SysQueryFrom(CurDate,DataSet,CompID) then Raise Exception.Create('�������۵������޷�������...');
  ModalResult:=MROK; //��������
end;

procedure TfrmDownStockOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsTable.RecNo = 1 then AFont.Style := [fsBold];
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmDownStockOrder.OpenOrder(ClientID: string);
var
  s: string;
  rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
 { try
    rs.SQL.Text := 'select top 1 COMP_ID,COMP_NAME from CA_COMPANY where COMP_ID='''+Global.SHOP_ID+''' and INTF_CODE='''+ClientID+'''';
    Factor.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('�˹�Ӧ���ڵ�ǰ�ӿ�������û�ҵ�...');
    CompID:=trim(Rs.FieldbyName('COMP_ID').AsString);
    CompName:=trim(Rs.FieldbyName('COMP_NAME').AsString);
  finally
    rs.Free;
  end;
  }

  cdsTable.Close;
  cdsTable.IndexFieldNames:='';
  //�ӿڵ���Rinȡ����:
  //SysQueryFromHeader(cdsTable,CompID);

  if not cdsTable.IsEmpty then
  begin
    rs := TZQuery.Create(nil);
    cdsTable.DisableControls;
    try
    {  cdsTable.AddIndex('CRT_DATE','CRT_DATE',[ixCaseInsensitive],'CRT_DATE');
      cdsTable.IndexName := 'CRT_DATE';
      cdsTable.First;
     }
      while not cdsTable.Eof do
      begin
        if s<>'' then s := s + ',';
        s := s+'''DWN'+cdsTable.FieldbyName('CRT_DATE').AsString+'''';
        cdsTable.Next;
      end;

     // rs.SQL.Text := 'select COMM_ID from STK_STOCKORDER where COMM_ID in ('+s+') and CLIENT_ID='' '' and COMP_ID='''+CompID+'''';
      Factor.Open(rs);
      cdsTable.First;
      while not cdsTable.Eof do
      begin
        if rs.Locate('COMM_ID','DWN'+cdsTable.FieldbyName('CRT_DATE').AsString,[]) then
          cdsTable.Delete
        else
          cdsTable.Next;
      end;
    finally
      cdsTable.First;
      cdsTable.EnableControls;
      rs.free;
    end;
  end;

  //�ж��Ƿ������: 
  if cdsTable.Active then
  begin
    btnOK.Enabled:=(cdsTable.RecordCount>0);
  end;
end;

procedure TfrmDownStockOrder.InitalParams(InParam: TftParamList);
var
  rs: TZQuery;
begin
  btnOK.Enabled:=(not cdsTable.Active);

  //ѡ��Ӧ�̵����ݼ�
  try
    rs:=TZQuery.Create(nil);
  finally
    rs.Free;
  end;
end;
 

function TfrmDownStockOrder.GetOrderDate: TDate;
begin
  if cdsTable.Active then
    fnTime.fnStrtoDate(cdsTable.fieldbyName('CRT_DATE').AsString);
end;

end.
