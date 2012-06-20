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
    fndINVH_NO: TcxTextEdit;
    fndSHOP_ID: TzrComboBoxList;
    fndCREA_USER: TzrComboBoxList;
    fndDEPT_ID: TzrComboBoxList;
    fndINVOICE_FLAG: TcxComboBox;
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
  public
    { Public declarations }
    
  end;

implementation
uses ufrmBasic, uShopGlobal, uFnUtil, uShopUtil, uGlobal;

{$R *.dfm}

procedure TfrmInvoiceTotalReport.actFindExecute(Sender: TObject);
var rs,rs1,rs2:TZQuery;
    CancelNo:String;
    CancelNum:Integer;
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
    if rs.Params.FindParam('SHOP_ID') <> nil then rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    if rs.Params.FindParam('DEPT_ID') <> nil then rs.Params.ParamByName('DEPT_ID').AsString := fndDEPT_ID.AsString;
    if rs.Params.FindParam('CREA_USER') <> nil then rs.Params.ParamByName('CREA_USER').AsString := fndCREA_USER.AsString;
    if rs.Params.FindParam('INVOICE_FLAG') <> nil then rs.Params.ParamByName('INVOICE_FLAG').AsString := TRecord_(fndINVOICE_FLAG.Properties.Items[fndINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString;
    if rs.Params.FindParam('INVH_NO') <> nil then rs.Params.ParamByName('INVH_NO').AsString := Trim(fndINVH_NO.Text);
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
    begin
      rs1.Close;
      rs1.SQL.Text := ' select count(INVD_ID) as USING_AMT,max(INVOICE_NO) as USING_MAX_INVH_NO,min(INVOICE_NO) as USING_MIN_INVH_NO from SAL_INVOICE_INFO '+
      ' where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID and INVOICE_STATUS=''1'' and CREA_DATE>=:D1 and CREA_DATE<=:D2 ';
      rs1.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs1.Params.ParamByName('INVH_ID').AsString := rs.FieldByName('INVH_ID').AsString;
      rs1.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs1.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      Factor.Open(rs1);

      rs2.Close;
      rs2.SQL.Text := ' select INVOICE_NO from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID and INVOICE_STATUS=''2'' '+
                     ' and CREA_DATE>=:D1 and CREA_DATE<=:D2 order by INVOICE_NO';
      rs2.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs2.Params.ParamByName('INVH_ID').AsString := rs.FieldByName('INVH_ID').AsString;
      rs2.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs2.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      Factor.Open(rs2);
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
  sWhere := ' and A.TENANT_ID=:TENANT_ID ';
  if fndSHOP_ID.AsString <> '' then
     sWhere := sWhere + ' and A.SHOP_ID=:SHOP_ID ';
  if fndDEPT_ID.AsString <> '' then
     sWhere := sWhere + ' and A.DEPT_ID=:DEPT_ID ';
  if fndCREA_USER.AsString <> '' then
     sWhere := sWhere + ' and A.CREA_USER=:CREA_USER ';
  if fndINVOICE_FLAG.ItemIndex <> -1 then
     sWhere := sWhere + ' and A.INVOICE_FLAG=:INVOICE_FLAG ';
  if Trim(fndINVH_NO.Text) <> '' then
     sWhere := sWhere + ' and A.INVH_NO like ''%:INVH_NO''';

  sSql := ' select A.INVH_ID,A.INVH_NO,'+
          ' case when A.BEGIN_NO=B.MIN_INVOICE_NO then 0 else A.ENDED_NO-B.MIN_INVOICE_NO+1 end as LAST_TOTAL_AMT,'+
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
  fndSHOP_ID.DataSet := ShopGlobal.GetZQueryFromName('CA_SHOP_INFO');
  fndDEPT_ID.DataSet := ShopGlobal.GetZQueryFromName('CA_DEPT_INFO');
  fndCREA_USER.DataSet := ShopGlobal.GetZQueryFromName('CA_USERS');
  AddCbxPickList(fndINVOICE_FLAG);
end;

procedure TfrmInvoiceTotalReport.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(fndINVOICE_FLAG);
  inherited;
end;

end.
