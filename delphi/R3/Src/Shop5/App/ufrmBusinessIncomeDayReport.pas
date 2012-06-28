unit ufrmBusinessIncomeDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel;

type
  TfrmBusinessIncomeDayReport = class(TframeBaseReport)
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
  private
    FSumRecord: TRecord_;
    { Private declarations }
    SeqNo:Integer;
  public
    { Public declarations }
    // 根据定义自动 添加列
    procedure CreateGridColumn;
    
    function GetSql:String;
  end;


implementation
uses ufrmBasic, uShopGlobal, uFnUtil, uShopUtil, uGlobal,zbase;

{$R *.dfm}

{ TfrmBusinessIncomeDayReport }

procedure TfrmBusinessIncomeDayReport.CreateGridColumn;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_SALE_STYLE');
  if rs.IsEmpty then Exit;
  DBGridEh1.Columns.Clear;
  DBGridEh1.Columns.BeginUpdate;
  try
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'SEQNO';
    Column.Title.Caption := '序号';
    Column.Width := 30;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'SALES_TYPE_TEXT';
    Column.Title.Caption := '销售类型';
    Column.Width := 100;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'SORT_TYPE_TEXT';
    Column.Title.Caption := '商品类别';
    Column.Width := 100;
    adoReport1.Close;
    adoReport1.FieldDefs.Add('SEQNO',ftInteger,0,True);
    adoReport1.FieldDefs.Add('SALES_TYPE',ftString,1,True);
    adoReport1.FieldDefs.Add('SALES_TYPE_TEXT',ftString,20,True);
    adoReport1.FieldDefs.Add('SORT_TYPE',ftString,36,True);
    adoReport1.FieldDefs.Add('SORT_TYPE_TEXT',ftString,20,True);
    rs.First;
    while not rs.Eof do
    begin
      // 根据定义动态创建数据集列
      adoReport1.FieldDefs.Add(rs.FieldByName('CODE_ID').AsString,ftFloat,0,True);
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := rs.FieldByName('CODE_ID').AsString;
      Column.Title.Caption := rs.FieldByName('CODE_NAME').AsString;
      Column.DisplayFormat := '#0.00';
      Column.Width := 100;
      rs.Next;
    end;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'TOTAL_MNY';
    Column.Title.Caption := '合计';
    Column.DisplayFormat := '#0.00';
    Column.Width := 100;
    adoReport1.FieldDefs.Add('TOTAL_MNY',ftFloat,0,True);
    adoReport1.CreateDataSet;
  finally
    DBGridEh1.Columns.EndUpdate;
  end;
end;

procedure TfrmBusinessIncomeDayReport.FormCreate(Sender: TObject);
begin
  inherited;
  FSumRecord:=TRecord_; 
  CreateGridColumn;
end;

function TfrmBusinessIncomeDayReport.GetSql: String;
var Str:String;
begin
  Str := ' select * from VIW_SALESDATA ';
end;

procedure TfrmBusinessIncomeDayReport.actFindExecute(Sender: TObject);
var rs,rs1,rs5:TZQuery;
begin
  //inherited;
  SeqNo := 1;
  rs := TZQuery.Create(nil);
  rs1 := TZQuery.Create(nil);
  rs5 := TZQuery.Create(nil);
  try
    rs.SQL.Text := ' select B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALESDATA A left join VIW_GOODSINFO_SORTEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=''1'' group by B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE order by B.SORT_ID1 ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);

    rs1.SQL.Text := ' select B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALINDENTDATA A left join VIW_GOODSINFO_SORTEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    ' where A.TENANT_ID=:TENANT_ID group by B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE order by B.SORT_ID1';
    rs1.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs1);
    rs5.Close;
    rs5.FieldDefs.Add('ID',ftString,36,True);
    rs5.FieldDefs.Add('SUM',ftInteger,0,True);
    rs5.CreateDataSet;
    rs1.First;
    while not rs1.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['1',rs1.FieldByName('SORT_ID1').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString).AsFloat := rs1.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs1.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '1';
         adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '销售订单';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs.FieldByName('SORT_ID1').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs1.FieldByName('SORT_NAME').AsString;
         if adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString).AsFloat := rs1.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs1.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;
         Inc(SeqNo);
      end;
      
      rs1.Next;
    end;

    rs.First;
    while not rs.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['2',rs.FieldByName('SORT_ID1').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString).AsFloat := rs.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '2';
         adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '销售单';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs.FieldByName('SORT_ID1').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs1.FieldByName('SORT_NAME').AsString;
         if adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString).AsFloat := rs.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;
         Inc(SeqNo);
      end;
      rs.Next;
    end;
  finally
    rs.Free;
    rs1.Free;
  end;
end;

end.
