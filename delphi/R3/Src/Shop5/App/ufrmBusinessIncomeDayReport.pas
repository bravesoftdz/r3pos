unit ufrmBusinessIncomeDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel, cxButtonEdit, zrComboBoxList, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, RzButton;

type
  TfrmBusinessIncomeDayReport = class(TframeBaseReport)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Label40: TLabel;
    Label3: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndP1_DEPT_ID: TzrComboBoxList;
    RzBitBtn3: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
    SeqNo:Integer;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
  public
    { Public declarations }
    // 根据定义自动 添加列
    procedure getIndentData;
    procedure getSalesData;
    procedure getIndentMny;
    procedure getRecvMny;
    procedure CreateGridColumn;
    procedure PrintBefore;override;
  end;


implementation
uses ufrmBasic, uShopGlobal, uFnUtil, uShopUtil, uGlobal, zBase, ObjCommon;

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
    Column.Title.Caption := '类型';
    Column.Width := 100;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'SORT_TYPE_TEXT';
    Column.Title.Caption := '名称';
    Column.Width := 100;
    adoReport1.Close;
    adoReport1.FieldDefs.Clear;
    adoReport1.FieldDefs.Add('SEQNO',ftInteger,0,True);
    adoReport1.FieldDefs.Add('SALES_TYPE',ftString,1,True);
    adoReport1.FieldDefs.Add('SALES_TYPE_TEXT',ftString,20,True);
    adoReport1.FieldDefs.Add('SORT_TYPE',ftString,36,True);
    adoReport1.FieldDefs.Add('SORT_TYPE_TEXT',ftString,50,True);
    adoReport1.FieldDefs.Add('CALC_AMOUNT',ftFloat,0,True);
    rs.First;
    while not rs.Eof do
    begin
      // 根据定义动态创建数据集列
      adoReport1.FieldDefs.Add(rs.FieldByName('CODE_ID').AsString,ftFloat,0,True);
      adoReport1.FieldDefs.Add(rs.FieldByName('CODE_ID').AsString+'_AMT',ftFloat,0,True);
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := rs.FieldByName('CODE_ID').AsString+'_AMT';
      Column.Title.Caption := rs.FieldByName('CODE_NAME').AsString+'|销量';
      Column.DisplayFormat := '#0.00';
      Column.Width := 70;
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := rs.FieldByName('CODE_ID').AsString;
      Column.Title.Caption := rs.FieldByName('CODE_NAME').AsString+'|金额';
      Column.DisplayFormat := '#0.00';
      Column.Width := 100;
      rs.Next;
    end;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'CALC_AMOUNT';
    Column.Title.Caption := '合计|销量';
    Column.Width := 70;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'TOTAL_MNY';
    Column.Title.Caption := '合计|金额';
    Column.DisplayFormat := '#0.00';
    Column.Width := 100;
    adoReport1.FieldDefs.Add('TOTAL_MNY',ftFloat,0,True);
    adoReport1.FieldDefs.Add('#',ftFloat,0,True);
    adoReport1.CreateDataSet;
  finally
    DBGridEh1.Columns.EndUpdate;
  end;
  RefreshColumn;
end;

procedure TfrmBusinessIncomeDayReport.FormCreate(Sender: TObject);
begin
  inherited;
  CreateGridColumn;
  P1_D1.Date := FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01',Date));
  P1_D2.Date := FnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD',Date));
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;
  fndP1_DEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
end;

procedure TfrmBusinessIncomeDayReport.actFindExecute(Sender: TObject);
begin
  //inherited;
  if P1_D1.EditValue = null then Raise Exception.Create(' 业务日期不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create(' 业务日期不能为空！ ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  开始日期不能大于结束日期条件不能为空！ ');
  adoReport1.Close;
  adoReport1.CreateDataSet;
  getIndentData;
  getSalesData;
  getIndentMny;
  getRecvMny;
end;

function TfrmBusinessIncomeDayReport.AddReportReport(
  TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmBusinessIncomeDayReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  try
    Title:=TStringList.Create;
    AddReportReport(Title,'1');

    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.getIndentData;
var
  rs,sort:TZQuery;
  Swhr,sid,stl:string;
begin
  sort := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs := TZQuery.Create(nil);
  try
    Swhr := ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and A.SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and A.DEPT_ID=:DEPT_ID ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,' select B.SORT_ID1,A.SALES_STYLE,sum(A.CALC_AMOUNT) as CALC_AMOUNT,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALINDENTDATA A left join PUB_GOODSINFO B on A.GODS_ID=B.GODS_ID '+
    ' where A.TENANT_ID=:TENANT_ID and A.INDE_DATE>=:D1 and A.INDE_DATE<=:D2 '+Swhr+
    ' group by B.SORT_ID1,A.SALES_STYLE ');
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    SumRecord.Clear;
    SumRecord.ReadField(adoReport1);
    rs.First;
    while not rs.Eof do
    begin
      if sort.Locate('SORT_ID',rs.FieldbyName('SORT_ID1').AsString,[]) then
         begin
           sid := copy(sort.FieldbyName('LEVEL_ID').AsString,1,4);
           if sort.Locate('LEVEL_ID',copy(sid,1,4),[]) then
              sid := sort.FieldbyName('SORT_ID').AsString
           else
              sid := '#';
         end
      else
         sid := '#';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['1',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.FieldByName('CALC_AMOUNT').AsFloat := adoReport1.FieldByName('CALC_AMOUNT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '1';
         if rs.RecNo = 1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '订货';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         if sid<>'#' then
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := sort.FieldByName('SORT_NAME').AsString
         else
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '其他';
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.FindField(stl+'_AMT').AsFloat := adoReport1.FindField(stl+'_AMT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('CALC_AMOUNT').AsFloat := rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.Post;
      end;
      SumRecord.FieldByName('CALC_AMOUNT').AsFloat:=SumRecord.FieldByName('CALC_AMOUNT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
      SumRecord.FieldByName(stl).AsFloat:=SumRecord.FieldByName(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
      SumRecord.FieldByName(stl+'_AMT').AsFloat:=SumRecord.FieldByName(stl+'_AMT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
      rs.Next;
    end;
    if not rs.IsEmpty then
    begin
      adoReport1.Append;
      SumRecord.WriteToDataSet(adoReport1);
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
      adoReport1.Post;
    end;

  finally
    rs.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.getSalesData;
var
  rs,sort:TZQuery;
  Swhr,sid,stl:string;
begin
  sort := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs := TZQuery.Create(nil);
  try
    Swhr := ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and A.SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and A.DEPT_ID=:DEPT_ID ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,' select B.SORT_ID1,A.SALES_STYLE,sum(A.CALC_AMOUNT) as CALC_AMOUNT,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALESDATA A left join PUB_GOODSINFO B on A.GODS_ID=B.GODS_ID '+
    ' where A.TENANT_ID=:TENANT_ID and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2 '+Swhr+
    ' group by B.SORT_ID1,A.SALES_STYLE ');
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    SumRecord.Clear;
    SumRecord.ReadField(adoReport1);
    rs.First;
    while not rs.Eof do
    begin
      if sort.Locate('SORT_ID',rs.FieldbyName('SORT_ID1').AsString,[]) then
         begin
           sid := copy(sort.FieldbyName('LEVEL_ID').AsString,1,4);
           if sort.Locate('LEVEL_ID',copy(sid,1,4),[]) then
              sid := sort.FieldbyName('SORT_ID').AsString
           else
              sid := '#';
         end
      else
         sid := '#';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['2',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.FindField(stl+'_AMT').AsFloat := adoReport1.FindField(stl+'_AMT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('CALC_AMOUNT').AsFloat := adoReport1.FieldByName('CALC_AMOUNT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '2';
         if rs.RecNo = 1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '销售';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         if sid<>'#' then
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := sort.FieldByName('SORT_NAME').AsString
         else
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '其他';
         adoReport1.FindField(stl+'_AMT').AsFloat := adoReport1.FindField(stl+'_AMT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.FieldByName('CALC_AMOUNT').AsFloat := rs.FieldByName('CALC_AMOUNT').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
         adoReport1.Post;
      end;
      SumRecord.FieldByName('CALC_AMOUNT').AsFloat:=SumRecord.FieldByName('CALC_AMOUNT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
      SumRecord.FieldByName(stl+'_AMT').AsFloat:=SumRecord.FieldByName(stl+'_AMT').AsFloat+rs.FieldByName('CALC_AMOUNT').AsFloat;
      SumRecord.FieldByName(stl).AsFloat:=SumRecord.FieldByName(stl).AsFloat+rs.FieldByName('CALC_MONEY').AsFloat;
      rs.Next;
    end;
    if not rs.IsEmpty then
    begin
      adoReport1.Append;
      SumRecord.WriteToDataSet(adoReport1);
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
      adoReport1.Post;
    end;

  finally
    rs.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.getIndentMny;
var
  rs:TZQuery;
  Swhr,sid,stl:string;
begin
  rs := TZQuery.Create(nil);
  try
    Swhr := ShopGlobal.GetDataRight('D.DEPT_ID',2)+ShopGlobal.GetDataRight('D.SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and D.SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and D.DEPT_ID=:DEPT_ID ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,'select isnull(A.SALES_STYLE,''#'') as SALES_STYLE,sum(isnull(C.RECV_MNY,0)) as ADVA_MNY '+
    ' from SAL_INDENTORDER A,ACC_RECVABLE_INFO B,ACC_RECVDATA C,ACC_RECVORDER D '+
    ' where A.TENANT_ID=D.TENANT_ID and B.TENANT_ID=D.TENANT_ID and C.TENANT_ID=D.TENANT_ID '+
    ' and A.INDE_ID=B.SALES_ID and B.ABLE_ID=C.ABLE_ID and C.RECV_ID=D.RECV_ID '+
    ' and A.TENANT_ID=:TENANT_ID and D.RECV_DATE>=:D1 and D.RECV_DATE<=:D2 '+Swhr+' group by A.SALES_STYLE');
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    adoReport1.Append;
    adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
    adoReport1.FieldByName('SALES_TYPE').AsString := '3';
    adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '预缴款';
    adoReport1.FieldByName('SORT_TYPE').AsString := '#1';
    adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '存入';
    adoReport1.Post;
    rs.First;
    while not rs.Eof do
    begin
      sid := '#1';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '存入';
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end;
      rs.Next;
    end;


    Swhr := ShopGlobal.GetDataRight('DEPT_ID',2)+ShopGlobal.GetDataRight('SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and DEPT_ID=:DEPT_ID ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,'select isnull(SALES_STYLE,''#'') as SALES_STYLE,sum(isnull(ADVA_MNY,0)) as ADVA_MNY '+
    ' from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2 '+Swhr+' group by SALES_STYLE ');
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    adoReport1.Append;
    adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
    adoReport1.FieldByName('SALES_TYPE').AsString := '3';
    adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '';
    adoReport1.FieldByName('SORT_TYPE').AsString := '#2';
    adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '支出';
    adoReport1.Post;
    rs.First;
    while not rs.Eof do
    begin
      sid := '#2';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '支出';
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end;
      rs.Next;
    end;

    Swhr := ShopGlobal.GetDataRight('DEPT_ID',2)+ShopGlobal.GetDataRight('SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and DEPT_ID=:DEPT_ID ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,
    ' select SALES_STYLE,sum(ADVA_MNY) AS ADVA_MNY from ('+
    ' select isnull(A.SALES_STYLE,''#'') as SALES_STYLE,-sum(isnull(C.RECV_MNY,0)) as ADVA_MNY '+
    ' from SAL_INDENTORDER A,ACC_RECVABLE_INFO B,ACC_RECVDATA C,ACC_RECVORDER D '+
    ' where A.TENANT_ID=D.TENANT_ID and B.TENANT_ID=D.TENANT_ID and C.TENANT_ID=D.TENANT_ID '+
    ' and A.INDE_ID=B.SALES_ID and B.ABLE_ID=C.ABLE_ID and C.RECV_ID=D.RECV_ID '+
    ' and A.TENANT_ID=:TENANT_ID and D.RECV_DATE<=:D2 '+Swhr+' group by A.SALES_STYLE '+
    ' union all '+
    ' select isnull(SALES_STYLE,''#'') as SALES_STYLE,sum(isnull(ADVA_MNY,0)) as ADVA_MNY '+
    ' from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_DATE<=:D2 '+Swhr+' group by SALES_STYLE '+
    ' ) j group by SALES_STYLE'
    );
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    adoReport1.Append;
    adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
    adoReport1.FieldByName('SALES_TYPE').AsString := '3';
    adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '';
    adoReport1.FieldByName('SORT_TYPE').AsString := '#3';
    adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '结余';
    adoReport1.Post;
    rs.First;
    while not rs.Eof do
    begin
      sid := '#3';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '结余';
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('ADVA_MNY').AsFloat;
         adoReport1.Post;
      end;
      rs.Next;
    end;

  finally
    rs.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.getRecvMny;
var
  rs,acct:TZQuery;
  Swhr,sid,stl:string;
begin
  acct := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  rs := TZQuery.Create(nil);
  try
    Swhr := ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
    if fndP1_SHOP_ID.AsString <> '' then
       Swhr := ' and A.SHOP_ID=:SHOP_ID ';
    if fndP1_DEPT_ID.AsString <> '' then
       Swhr := Swhr + ' and A.DEPT_ID=:DEPT_ID ';
      rs.SQL.Text := ParseSQL(Factor.iDbType,
      'select A.ACCOUNT_ID,D.SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY '+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join SAL_SALESORDER D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''0'' and B.RECV_TYPE in (''1'',''2'') and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,D.SALES_STYLE '  +
      ' union all '+
      'select A.ACCOUNT_ID,D.SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY'+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join SAL_INDENTORDER D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.INDE_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''0'' and B.RECV_TYPE in (''3'') and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,D.SALES_STYLE '+
      ' union all '+
      'select A.ACCOUNT_ID,case when B.RECV_TYPE=''4'' then ''6BD82B9E-3678-4F33-89ED-B8C26B6589BD'' else ''#'' end as SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY'+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' where A.TENANT_ID=:TENANT_ID and B.RECV_TYPE in (''4'',''5'',''6'') and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,case when B.RECV_TYPE=''4'' then ''6BD82B9E-3678-4F33-89ED-B8C26B6589BD'' else ''#'' end '
      );
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    Factor.Open(rs);

    SumRecord.Clear;
    SumRecord.ReadField(adoReport1);
    rs.First;
    while not rs.Eof do
    begin
      if acct.Locate('ACCOUNT_ID',rs.FieldbyName('ACCOUNT_ID').AsString,[]) then
         begin
         sid := rs.FieldbyName('ACCOUNT_ID').AsString;
         end
      else
      if copy(rs.FieldbyName('ACCOUNT_ID').AsString,14,22)='0000000000000000000000' then
         sid := '0000000000000000000000'
      else
         sid := '#';
      stl := rs.FieldByName('SALES_STYLE').AsString;
      if (stl='') or (adoReport1.FindField(stl)=nil) then stl := '#';
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['4',sid]),[]) then
      begin
         adoReport1.Edit;
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('RECV_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('RECV_MNY').AsFloat;
         adoReport1.Post;
      end
      else
      begin
         adoReport1.Append;
         adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
         adoReport1.FieldByName('SALES_TYPE').AsString := '4';
         if rs.RecNo = 1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '实收款';
         adoReport1.FieldByName('SORT_TYPE').AsString := sid;
         if sid<>'#' then
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := acct.FieldByName('ACCT_NAME').AsString
         else
         if sid='0000000000000000000000' then
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '现金'
         else
            adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '其他';
         adoReport1.FindField(stl).AsFloat := adoReport1.FindField(stl).AsFloat+rs.FieldByName('RECV_MNY').AsFloat;
         adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs.FieldByName('RECV_MNY').AsFloat;
         adoReport1.Post;
      end;
      SumRecord.FieldByName(stl).AsFloat:=SumRecord.FieldByName(stl).AsFloat+rs.FieldByName('RECV_MNY').AsFloat;
      rs.Next;
    end;
    if not rs.IsEmpty then
    begin
      adoReport1.Append;
      SumRecord.WriteToDataSet(adoReport1);
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      adoReport1.FieldByName('SEQNO').AsInteger := adoReport1.RecordCount;
      adoReport1.Post;
    end;

  finally
    rs.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.DBGridEh1GetCellParams(
  Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := Column.Grid.FixedColor
  else
  if adoReport1.FieldByName('SALES_TYPE').AsString = '9' then
     Background := $00A5A5A5;

end;

end.
