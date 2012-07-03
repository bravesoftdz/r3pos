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
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    SeqNo:Integer;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
  public
    { Public declarations }
    // 根据定义自动 添加列
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
    Column.FieldName := '#';
    Column.Title.Caption := '其它';
    Column.DisplayFormat := '#0.00';
    Column.Width := 100;
    Column := DBGridEh1.Columns.Add;
    Column.FieldName := 'TOTAL_MNY';
    Column.Title.Caption := '合计';
    Column.DisplayFormat := '#0.00';
    Column.Width := 100;
    adoReport1.FieldDefs.Add('TOTAL_MNY',ftFloat,0,True);
    adoReport1.FieldDefs.Add('#',ftFloat,0,True);
    adoReport1.CreateDataSet;
  finally
    DBGridEh1.Columns.EndUpdate;
  end;
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
var rs,rs1,rs2,rs3,rs4,rs5,rs6,rs7:TZQuery;
    i,J:Integer;
    Swhr:String;
begin
  //inherited;
  if P1_D1.EditValue = null then Raise Exception.Create(' 业务日期不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create(' 业务日期不能为空！ ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  开始日期不能大于结束日期条件不能为空！ ');
  adoReport1.Close;
  adoReport1.CreateDataSet;
  self.SumRecord.Clear;
  J := 0;
  rs := TZQuery.Create(nil);
  rs1 := TZQuery.Create(nil);
  rs2 := TZQuery.Create(nil);
  rs3 := TZQuery.Create(nil);
  rs4 := TZQuery.Create(nil);
  rs5 := TZQuery.Create(nil);
  rs6 := TZQuery.Create(nil);
  rs7 := TZQuery.Create(nil);
  try
    try
      Swhr := ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      if fndP1_DEPT_ID.AsString <> '' then
         Swhr := Swhr + ' and A.DEPT_ID=:DEPT_ID ';
      rs.SQL.Text := ParseSQL(Factor.iDbType,' select B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE,sum(A.CALC_MONEY) as CALC_MONEY '+
      ' from VIW_SALESDATA A left join VIW_GOODSINFO_SORTEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.SALES_TYPE=''1'' and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2 '+Swhr+
      ' group by B.SORT_ID1,B.SORT_NAME,SUBSTRING(B.LEVEL_ID,1,4),A.SALES_STYLE ');
      rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
      Factor.Open(rs);

      Swhr := ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      if fndP1_DEPT_ID.AsString <> '' then
         Swhr := Swhr + ' and A.DEPT_ID=:DEPT_ID ';
      rs1.SQL.Text := ParseSQL(Factor.iDbType,' select B.SORT_ID1,B.SORT_NAME,A.SALES_STYLE,sum(A.CALC_MONEY) as CALC_MONEY '+
      ' from VIW_SALINDENTDATA A left join VIW_GOODSINFO_SORTEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.INDE_DATE>=:D1 and A.INDE_DATE<=:D2 '+Swhr+
      ' group by B.SORT_ID1,B.SORT_NAME,SUBSTRING(B.LEVEL_ID,1,4),A.SALES_STYLE ');
      rs1.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs1.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs1.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs1.Params.FindParam('SHOP_ID') <> nil then rs1.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      if rs1.Params.FindParam('DEPT_ID') <> nil then rs1.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
      Factor.Open(rs1);
      // 实收金额  销售方式 销售(退货)单
      Swhr := ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      rs2.SQL.Text := ParseSQL(Factor.iDbType,'select A.ACCOUNT_ID,E.ACCT_NAME,D.SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY'+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join SAL_SALESORDER D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID '+
      ' left join ACC_ACCOUNT_INFO E on A.TENANT_ID=E.TENANT_ID and A.ACCOUNT_ID=E.ACCOUNT_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''0'' and B.RECV_TYPE in (''1'',''2'') and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,E.ACCT_NAME,D.SALES_STYLE');
      rs2.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs2.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs2.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs2.Params.FindParam('SHOP_ID') <> nil then rs2.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      Factor.Open(rs2);
      // 实收金额  销售订单
      Swhr := ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      rs3.SQL.Text := ParseSQL(Factor.iDbType,'select A.ACCOUNT_ID,E.ACCT_NAME,D.SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY '+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join SAL_INDENTORDER D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.INDE_ID '+
      ' left join ACC_ACCOUNT_INFO E on A.TENANT_ID=E.TENANT_ID and A.ACCOUNT_ID=E.ACCOUNT_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''0'' and B.RECV_TYPE = ''3'' and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,E.ACCT_NAME,D.SALES_STYLE');
      rs3.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs3.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs3.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs3.Params.FindParam('SHOP_ID') <> nil then rs3.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      Factor.Open(rs3);
      // 实收金额  门店销售
      Swhr := ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      rs4.SQL.Text := ParseSQL(Factor.iDbType,'select A.PAYM_ID,D.CODE_NAME,''6BD82B9E-3678-4F33-89ED-B8C26B6589BD'' as SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY '+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join PUB_CODE_INFO D on A.PAYM_ID=D.CODE_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''1'' and B.RECV_TYPE = ''4'' and D.CODE_TYPE=''1'' and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.PAYM_ID,D.CODE_NAME');
      rs4.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs4.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs4.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs4.Params.FindParam('SHOP_ID') <> nil then rs4.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      Factor.Open(rs4);
      // 实收金额  其它类别
      Swhr := ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and A.SHOP_ID=:SHOP_ID ';
      rs5.SQL.Text := ParseSQL(Factor.iDbType,'select A.ACCOUNT_ID,E.ACCT_NAME,isnull(D.SALES_STYLE,''#'') as SALES_STYLE,sum(B.RECV_MNY) as RECV_MNY'+
      ' from ACC_RECVORDER A inner join ACC_RECVDATA B on A.TENANT_ID=B.TENANT_ID and A.RECV_ID=B.RECV_ID '+
      ' left join ACC_RECVABLE_INFO C on B.TENANT_ID=C.TENANT_ID and B.ABLE_ID=C.ABLE_ID '+
      ' left join SAL_SALESORDER D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID '+
      ' left join ACC_ACCOUNT_INFO E on A.TENANT_ID=E.TENANT_ID and A.ACCOUNT_ID=E.ACCOUNT_ID '+
      ' where A.TENANT_ID=:TENANT_ID and A.RECV_FLAG=''0'' and B.RECV_TYPE in (''5'',''6'') and A.RECV_DATE>=:D1 and A.RECV_DATE<=:D2 '+Swhr+
      ' group by A.ACCOUNT_ID,E.ACCT_NAME,D.SALES_STYLE');
      rs5.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs5.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs5.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs5.Params.FindParam('SHOP_ID') <> nil then rs5.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      Factor.Open(rs5);

      //  存入
      Swhr := ShopGlobal.GetDataRight('DEPT_ID',2)+ShopGlobal.GetDataRight('SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and SHOP_ID=:SHOP_ID ';
      if fndP1_DEPT_ID.AsString <> '' then
         Swhr := Swhr + ' and DEPT_ID=:DEPT_ID ';
      rs6.SQL.Text := ParseSQL(Factor.iDbType,'select isnull(SALES_STYLE,''#'') as SALES_STYLE,sum(isnull(ADVA_MNY,0)) as ADVA_MNY '+
      ' from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_DATE>=:D1 and INDE_DATE<=:D2 '+Swhr+' group by SALES_STYLE');
      rs6.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs6.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs6.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs6.Params.FindParam('SHOP_ID') <> nil then rs6.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      if rs6.Params.FindParam('DEPT_ID') <> nil then rs6.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
      Factor.Open(rs6);

      // 支出
      Swhr := ShopGlobal.GetDataRight('DEPT_ID',2)+ShopGlobal.GetDataRight('SHOP_ID',1);
      if fndP1_SHOP_ID.AsString <> '' then
         Swhr := ' and SHOP_ID=:SHOP_ID ';
      if fndP1_DEPT_ID.AsString <> '' then
         Swhr := Swhr + ' and DEPT_ID=:DEPT_ID ';
      rs7.SQL.Text := ParseSQL(Factor.iDbType,'select isnull(SALES_STYLE,''#'') as SALES_STYLE,sum(isnull(ADVA_MNY,0)) as ADVA_MNY '+
      ' from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2 '+Swhr+' group by SALES_STYLE ');
      rs7.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs7.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs7.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      if rs7.Params.FindParam('SHOP_ID') <> nil then rs7.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
      if rs7.Params.FindParam('DEPT_ID') <> nil then rs7.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
      Factor.Open(rs7);

    except
      Raise Exception.Create('');
    end;
    SumRecord.ReadFromDataSet(adoReport1);
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
         if rs1.RecNo = 1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '订货';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs1.FieldByName('SORT_ID1').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs1.FieldByName('SORT_NAME').AsString;
         if adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs1.FieldByName('SALES_STYLE').AsString).AsFloat := rs1.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs1.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs1.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs1.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs1.FieldByName('CALC_MONEY').AsFloat;
      rs1.Next;
    end;
    if not rs1.IsEmpty then
    begin
      adoReport1.Append;
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      for i:=0 to SumRecord.Count-1 do
      begin
        if Length(SumRecord.Fields[i].FieldName)=36 then
        begin
           adoReport1.FindField(SumRecord.Fields[i].FieldName).AsFloat := SumRecord.Fields[i].AsFloat;
           adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat + SumRecord.Fields[i].AsFloat;
        end;
      end;
      adoReport1.Post;
    end;

    for i:=0 to SumRecord.Count-1 do
      SumRecord.Fields[i].NewValue := null;
      
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
         if rs.RecNo = 1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '销售';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs.FieldByName('SORT_ID1').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs.FieldByName('SORT_NAME').AsString;
         if adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs.FieldByName('SALES_STYLE').AsString).AsFloat := rs.FieldByName('CALC_MONEY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs.FieldByName('CALC_MONEY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs.FieldByName('CALC_MONEY').AsFloat;
      rs.Next;
    end;
    if not rs.IsEmpty then
    begin
      adoReport1.Append;
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      for i:=0 to SumRecord.Count-1 do
      begin
        if Length(SumRecord.Fields[i].FieldName)=36 then
        begin
           adoReport1.FindField(SumRecord.Fields[i].FieldName).AsFloat := SumRecord.Fields[i].AsFloat;
           adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat + SumRecord.Fields[i].AsFloat;
        end;
      end;
      adoReport1.Post;
    end;


    for i:=0 to SumRecord.Count-1 do
      SumRecord.Fields[i].NewValue := null;

    rs2.First;
    while not rs2.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',rs2.FieldByName('ACCT_NAME').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs2.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs2.FieldByName('SALES_STYLE').AsString).AsFloat := rs2.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs2.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         Inc(J);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '实收款';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs2.FieldByName('ACCOUNT_ID').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs2.FieldByName('ACCT_NAME').AsString;
         if adoReport1.FindField(rs2.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs2.FieldByName('SALES_STYLE').AsString).AsFloat := rs2.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs2.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs2.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs2.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs2.FieldByName('RECV_MNY').AsFloat;
      rs2.Next;
    end;

    rs3.First;
    while not rs3.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',rs3.FieldByName('ACCT_NAME').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs3.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs3.FieldByName('SALES_STYLE').AsString).AsFloat := rs3.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs3.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         inc(J);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '实收款';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs3.FieldByName('ACCOUNT_ID').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs3.FieldByName('ACCT_NAME').AsString;
         if adoReport1.FindField(rs3.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs3.FieldByName('SALES_STYLE').AsString).AsFloat := rs3.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs3.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs3.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs3.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs3.FieldByName('RECV_MNY').AsFloat;
      rs3.Next;
    end;

    rs4.First;
    while not rs4.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',rs4.FieldByName('CODE_NAME').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs4.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs4.FieldByName('SALES_STYLE').AsString).AsFloat := rs4.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs4.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         Inc(J);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '实收款';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs4.FieldByName('PAYM_ID').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs4.FieldByName('CODE_NAME').AsString;
         if adoReport1.FindField(rs4.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs4.FieldByName('SALES_STYLE').AsString).AsFloat := rs4.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs4.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs4.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs3.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs4.FieldByName('RECV_MNY').AsFloat;
      rs4.Next;
    end;

    rs5.First;
    while not rs5.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['3',rs5.FieldByName('ACCT_NAME').AsString]),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs5.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs5.FieldByName('SALES_STYLE').AsString).AsFloat := rs5.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs5.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         Inc(J);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '3';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '实收款';
         adoReport1.FieldByName('SORT_TYPE').AsString := rs5.FieldByName('ACCOUNT_ID').AsString;
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := rs5.FieldByName('ACCT_NAME').AsString;
         if adoReport1.FindField(rs5.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs5.FieldByName('SALES_STYLE').AsString).AsFloat := rs5.FieldByName('RECV_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs5.FieldByName('RECV_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs5.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs5.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs5.FieldByName('RECV_MNY').AsFloat;
      rs5.Next;
    end;
    if (not rs2.IsEmpty) or (not rs3.IsEmpty) or (not rs4.IsEmpty) or (not rs5.IsEmpty) then
    begin
      adoReport1.Append;
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '合计:';
      for i:=0 to SumRecord.Count-1 do
      begin
        if Length(SumRecord.Fields[i].FieldName)=36 then
        begin
           adoReport1.FindField(SumRecord.Fields[i].FieldName).AsFloat := SumRecord.Fields[i].AsFloat;
           adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat + SumRecord.Fields[i].AsFloat;
        end;
      end;
      adoReport1.Post;
    end;

    for i:=0 to SumRecord.Count-1 do
      SumRecord.Fields[i].NewValue := null;
    J := 0;
    rs6.First;
    while not rs6.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['4','1']),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs6.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs6.FieldByName('SALES_STYLE').AsString).AsFloat := rs6.FieldByName('ADVA_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs6.FieldByName('ADVA_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         Inc(J);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '4';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '预缴款';
         adoReport1.FieldByName('SORT_TYPE').AsString := '1';
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '存入';
         if adoReport1.FindField(rs6.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs6.FieldByName('SALES_STYLE').AsString).AsFloat := rs6.FieldByName('ADVA_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs6.FieldByName('ADVA_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs6.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs6.FieldByName('SALES_STYLE').AsString).AsFloat+
                                                                              rs6.FieldByName('ADVA_MNY').AsFloat;
      rs6.Next;
    end;

    rs7.First;
    while not rs7.Eof do
    begin
      if adoReport1.Locate('SALES_TYPE;SORT_TYPE',VarArrayOf(['4','2']),[]) then
      begin
         adoReport1.Edit;
         if adoReport1.FindField(rs7.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs7.FieldByName('SALES_STYLE').AsString).AsFloat := rs7.FieldByName('ADVA_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat+rs7.FieldByName('ADVA_MNY').AsFloat;
         end;
         adoReport1.Post;
      end
      else
      begin
         Inc(j);
         adoReport1.Append;
         //adoReport1.FieldByName('SEQNO').AsInteger := SeqNo;
         adoReport1.FieldByName('SALES_TYPE').AsString := '4';
         if j=1 then
            adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '预缴款';
         adoReport1.FieldByName('SORT_TYPE').AsString := '2';
         adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '支出';
         if adoReport1.FindField(rs7.FieldByName('SALES_STYLE').AsString) <> nil then
         begin
            adoReport1.FindField(rs7.FieldByName('SALES_STYLE').AsString).AsFloat := rs7.FieldByName('ADVA_MNY').AsFloat;
            adoReport1.FieldByName('TOTAL_MNY').AsFloat := rs7.FieldByName('ADVA_MNY').AsFloat;
         end;
         adoReport1.Post;

      end;
      SumRecord.FieldByName(rs7.FieldByName('SALES_STYLE').AsString).AsFloat:=SumRecord.FieldByName(rs7.FieldByName('SALES_STYLE').AsString).AsFloat-
                                                                              rs7.FieldByName('ADVA_MNY').AsFloat;
      rs7.Next;
    end;
    if (not rs6.IsEmpty) or (not rs7.IsEmpty) then
    begin
      adoReport1.Append;
      adoReport1.FieldByName('SALES_TYPE').AsString := '9';
      //adoReport1.FieldByName('SALES_TYPE_TEXT').AsString := '预缴款';
      adoReport1.FieldByName('SORT_TYPE_TEXT').AsString := '结余';
      for i:=0 to SumRecord.Count-1 do
      begin
        if Length(SumRecord.Fields[i].FieldName)=36 then
        begin
           adoReport1.FindField(SumRecord.Fields[i].FieldName).AsFloat := SumRecord.Fields[i].AsFloat;
           adoReport1.FieldByName('TOTAL_MNY').AsFloat := adoReport1.FieldByName('TOTAL_MNY').AsFloat + SumRecord.Fields[i].AsFloat;
        end;
      end;
      adoReport1.Post;
    end;
  finally
    rs.Free;
    rs1.Free;
    rs2.Free;
    rs3.Free;
    rs4.Free;
    rs5.Free;
    rs6.Free;
    rs7.Free;
  end;
end;

procedure TfrmBusinessIncomeDayReport.DBGridEh1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if adoReport1.FieldByName('SALES_TYPE').AsString = '9' then
     DBGridEh1.Canvas.Brush.Color := clAqua;
  DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  inherited;
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

end.
