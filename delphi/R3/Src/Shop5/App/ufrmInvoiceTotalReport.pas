unit ufrmInvoiceTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel, cxDropDownEdit, cxCalendar, cxMaskEdit, cxButtonEdit, ObjCommon,
  RzButton, zrComboBoxList, cxControls, cxContainer, cxEdit, cxTextEdit;

type
  TfrmInvoiceTotalReport = class(TframeBaseReport)
    labINVH_NO: TRzLabel;
    lab_SHOP_ID: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel13: TRzLabel;
    labIDN_TYPE: TRzLabel;
    fndP1_INVH_NO: TcxTextEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndP1_CREA_USER: TzrComboBoxList;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_INVOICE_FLAG: TcxComboBox;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    Label3: TLabel;
    procedure actFindExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function GetInvoiceBookSql:String;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
  public
    { Public declarations }
    procedure PrintBefore;override;

  end;

implementation
uses ufrmBasic, uShopGlobal, uFnUtil, uShopUtil, uGlobal;

{$R *.dfm}

procedure TfrmInvoiceTotalReport.actFindExecute(Sender: TObject);
var rs,rs1,rs2:TZQuery;
    CancelNo,UsingNo:String;
    CancelNum,UsingNum:Integer;
begin
  inherited;
  adoReport1.Close;
  adoReport1.CreateDataSet;
  rs := TZQuery.Create(nil);
  rs1 := TZQuery.Create(nil);
  rs2 := TZQuery.Create(nil);
  try
    rs.SQL.Text := GetInvoiceBookSql;
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndP1_SHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndP1_DEPT_ID.AsString;
    if rs.Params.FindParam('CREA_USER') <> nil then rs.Params.ParamByName('CREA_USER').AsString := fndP1_CREA_USER.AsString;
    if rs.Params.FindParam('INVOICE_FLAG') <> nil then rs.Params.ParamByName('INVOICE_FLAG').AsString := TRecord_(fndP1_INVOICE_FLAG.Properties.Items[fndP1_INVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString;
    if rs.Params.FindParam('INVH_NO') <> nil then rs.Params.ParamByName('INVH_NO').AsString := Trim(fndP1_INVH_NO.Text);
    Factor.Open(rs);

    rs1.SQL.Text := ParseSQL(Factor.iDbType,' select isnull(INVH_ID,'''') as INVH_ID,count(INVD_ID) as USING_AMT,max(INVOICE_NO) as USING_MAX_INVH_NO,min(INVOICE_NO) as USING_MIN_INVH_NO '+
    ' from SAL_INVOICE_INFO  where TENANT_ID=:TENANT_ID and INVOICE_STATUS=''1'' and CREA_DATE>=:D1 and CREA_DATE<=:D2 group by INVH_ID');
    rs1.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs1.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs1.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    Factor.Open(rs1);

    rs2.SQL.Text := ParseSQL(Factor.iDbType,' select isnull(INVH_ID,'''') as INVH_ID,INVOICE_NO from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and INVOICE_STATUS=''2'' and CREA_DATE>=:D1 and CREA_DATE<=:D2 ');
    rs2.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs2.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
    rs2.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
    Factor.Open(rs2);

    rs.First;
    while not rs.Eof do
    begin
      rs1.Filtered := False;
      rs1.Filter := 'INVH_ID='+QuotedStr(rs.FieldByName('INVH_ID').AsString);
      rs1.Filtered := True;
      rs2.Filtered := False;
      rs2.Filter := 'INVH_ID='+QuotedStr(rs.FieldByName('INVH_ID').AsString);
      rs2.Filtered := True;
      CancelNo := '';
      CancelNum := 0;
      rs2.First;
      while not rs2.Eof do
      begin
        Inc(CancelNum);
        if CancelNo = '' then
           CancelNo := rs2.FieldByName('INVOICE_NO').AsString
        else
           CancelNo := CancelNo+','+rs2.FieldByName('INVOICE_NO').AsString;
        rs2.Next;
      end;

      adoReport1.Append;
      adoReport1.FieldByName('INVH_NO').AsString := rs.FieldByName('INVH_NO').AsString;
      adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger := rs.FieldByName('LAST_TOTAL_AMT').AsInteger;
      if rs.FieldByName('LAST_TOTAL_AMT').AsInteger = 0 then
         adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString := ''
      else
         adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString := FnString.FormatStringEx(rs.FieldByName('LAST_BEGIN_INVH_NO').AsString,8)+'-'+FnString.FormatStringEx(rs.FieldByName('LAST_END_INVH_NO').AsString,8);

      adoReport1.FieldByName('THIS_TOTAL_AMT').AsInteger := rs.FieldByName('THIS_TOTAL_AMT').AsInteger;
      if rs.FieldByName('THIS_TOTAL_AMT').AsInteger = 0 then
         adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString := ''
      else
         adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString := FnString.FormatStringEx(rs.FieldByName('THIS_BEGIN_INVH_NO').AsString,8)+'-'+FnString.FormatStringEx(rs.FieldByName('THIS_END_INVH_NO').AsString,8);

      adoReport1.FieldByName('USING_AMT').AsInteger := rs1.FieldByName('USING_AMT').AsInteger;
      adoReport1.FieldByName('USING_INVH_NO').AsString := FnString.FormatStringEx(rs1.FieldByName('USING_MIN_INVH_NO').AsString,8)+'-'+FnString.FormatStringEx(rs1.FieldByName('USING_MAX_INVH_NO').AsString,8);
      adoReport1.FieldByName('CANCEL_AMT').AsInteger := CancelNum;
      adoReport1.FieldByName('CANCEL_INVH_NO').AsString := CancelNo;
      if rs.FieldByName('LAST_TOTAL_AMT').AsInteger = 0 then
      begin
         adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('THIS_TOTAL_AMT').AsInteger-adoReport1.FieldByName('USING_AMT').AsInteger;
         adoReport1.FieldByName('BALANCE_INVH_NO').AsString := FnString.FormatStringEx(IntToStr(rs1.FieldByName('USING_MAX_INVH_NO').AsInteger+1),8)+'-'+FnString.FormatStringEx(IntToStr(rs.FieldByName('THIS_END_INVH_NO').AsInteger+1),8);
      end
      else
      begin
         adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger-adoReport1.FieldByName('USING_AMT').AsInteger;
         adoReport1.FieldByName('BALANCE_INVH_NO').AsString := FnString.FormatStringEx(IntToStr(rs1.FieldByName('USING_MAX_INVH_NO').AsInteger+1),8)+'-'+FnString.FormatStringEx(IntToStr(rs.FieldByName('LAST_END_INVH_NO').AsInteger+1),8);
      end;
      adoReport1.Post;
      rs.Next;
    end;
    rs1.Filtered := False;
    rs1.Filter := 'INVH_ID=''''';
    rs1.Filtered := True;
    rs2.Filtered := False;
    rs2.Filter := 'INVH_ID=''''';
    rs2.Filtered := True;
    UsingNum := 0;
    UsingNo := '';
    rs1.First;
    while not rs1.Eof do
    begin
      Inc(UsingNum);
      if UsingNo = '' then
         UsingNo := rs1.FieldByName('USING_MAX_INVH_NO').AsString
      else
         UsingNo := UsingNo+','+rs1.FieldByName('USING_MAX_INVH_NO').AsString;
      rs1.Next;
    end;

    CancelNum := 0;
    CancelNo := '';
    rs2.First;
    while not rs2.Eof do
    begin
      Inc(UsingNum);
      if UsingNo = '' then
         UsingNo := rs2.FieldByName('INVOICE_NO').AsString
      else
         UsingNo := UsingNo+','+rs2.FieldByName('INVOICE_NO').AsString;
      rs2.Next;
    end;
    if (UsingNum<>0) or (CancelNum<>0) then
    begin
      adoReport1.Append;
      adoReport1.FieldByName('INVH_NO').AsString := '无';
      adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger := 0;
      adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString := '';
      adoReport1.FieldByName('THIS_TOTAL_AMT').AsInteger := 0;
      adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString := '';
      adoReport1.FieldByName('USING_AMT').AsInteger := UsingNum;
      adoReport1.FieldByName('USING_INVH_NO').AsString := UsingNo;
      adoReport1.FieldByName('CANCEL_AMT').AsInteger := CancelNum;
      adoReport1.FieldByName('CANCEL_INVH_NO').AsString := CancelNo;
      adoReport1.FieldByName('BALANCE').AsInteger := 0;
      adoReport1.FieldByName('BALANCE_INVH_NO').AsString := '';
      adoReport1.Post;
    end;
  finally
    rs.Free;
    rs1.Free;
    rs2.Free;
  end;

end;

function TfrmInvoiceTotalReport.GetInvoiceBookSql: String;
var sSql,sWhere:String;
begin
  if (P1_D1.EditValue = null) or (P1_D2.EditValue = null) then Raise Exception.Create('领用日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('领用的结束日期不能小于开始日期...');
  sWhere := ' and A.TENANT_ID=:TENANT_ID '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+ShopGlobal.GetDataRight('A.SHOP_ID',1);
  if fndP1_SHOP_ID.AsString <> '' then
     sWhere := sWhere + ' and A.SHOP_ID=:SHOP_ID ';
  if fndP1_DEPT_ID.AsString <> '' then
     sWhere := sWhere + ' and A.DEPT_ID=:DEPT_ID ';
  if fndP1_CREA_USER.AsString <> '' then
     sWhere := sWhere + ' and A.CREA_USER=:CREA_USER ';
  if fndP1_INVOICE_FLAG.ItemIndex <> -1 then
     sWhere := sWhere + ' and A.INVOICE_FLAG=:INVOICE_FLAG ';
  if Trim(fndP1_INVH_NO.Text) <> '' then
     sWhere := sWhere + ' and A.INVH_NO like ''%:INVH_NO''';

  sSql := ' select A.INVH_ID,A.INVH_NO,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then 0 else A.TOTAL_AMT-('+
          ' select count(INVD_ID) from SAL_INVOICE_INFO where INVH_ID=A.INVH_ID and TENANT_ID=:TENANT_ID and CREA_DATE<=:D2 ) end as LAST_TOTAL_AMT,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then '''' else B.MIN_INVOICE_NO end as LAST_BEGIN_INVH_NO,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then '''' else A.ENDED_NO end as LAST_END_INVH_NO,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then A.TOTAL_AMT else 0 end as THIS_TOTAL_AMT,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then B.MIN_INVOICE_NO else '''' end as THIS_BEGIN_INVH_NO,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then A.ENDED_NO else '''' end as THIS_END_INVH_NO '+
          ' from SAL_INVOICE_BOOK A,('+
          ' select TENANT_ID,INVH_ID,count(INVD_ID) as THIS_SUM,min(INVOICE_NO) as MIN_INVOICE_NO '+
          ' from SAL_INVOICE_INFO where CREA_DATE>=:D1 and CREA_DATE<=:D2 group by TENANT_ID,INVH_ID '+
          ' ) B where A.TENANT_ID=B.TENANT_ID and A.INVH_ID=B.INVH_ID '+sWhere;
  Result := sSql;
end;

procedure TfrmInvoiceTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  P1_D1.Date := Global.SysDate;
  P1_D2.Date := Global.SysDate;
  fndP1_SHOP_ID.DataSet := ShopGlobal.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_DEPT_ID.DataSet := ShopGlobal.GetZQueryFromName('CA_DEPT_INFO');
  fndP1_CREA_USER.DataSet := ShopGlobal.GetZQueryFromName('CA_USERS');
  AddCbxPickList(fndP1_INVOICE_FLAG);
end;

procedure TfrmInvoiceTotalReport.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(fndP1_INVOICE_FLAG);
  inherited;
end;

procedure TfrmInvoiceTotalReport.PrintBefore;
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

function TfrmInvoiceTotalReport.AddReportReport(TitleList: TStringList;
  PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  FindCmp1:=FindComponent('fndP'+PageNo+'_INVOICE_FLAG');   
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
  begin
    TitleList.add('发票类型：'+TcxComboBox(FindCmp1).Text);
  end;

  FindCmp1:=FindComponent('fndP'+PageNo+'_CREA_USER');
  if (FindCmp1<>nil)and (FindCmp1.Tag<>100) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
  begin
    TitleList.Add('领用人：'+TzrComboBoxList(FindCmp1).Text);
  end;

  inherited AddReportReport(TitleList,PageNo);
end;

end.
