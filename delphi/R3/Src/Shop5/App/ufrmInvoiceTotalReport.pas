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
var rs:TZQuery;
    List:TStringList;
    iUAmt,iCAmt:Integer;
    sUStartNo,sUEndNo,sCNo,sBeginNo,sEndNo:String;
begin
  inherited;
  adoReport1.SQL.Text := GetInvoiceBookSql;
  adoReport1.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  adoReport1.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
  adoReport1.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
  if adoReport1.Params.FindParam('SHOP_ID') <> nil then adoReport1.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
  if adoReport1.Params.FindParam('DEPT_ID') <> nil then adoReport1.Params.ParamByName('DEPT_ID').AsString := fndDEPT_ID.AsString;
  if adoReport1.Params.FindParam('CREA_USER') <> nil then adoReport1.Params.ParamByName('CREA_USER').AsString := fndCREA_USER.AsString;
  if adoReport1.Params.FindParam('INVOICE_FLAG') <> nil then adoReport1.Params.ParamByName('INVOICE_FLAG').AsString := TRecord_(fndINVOICE_FLAG.Properties.Items[fndINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString;
  if adoReport1.Params.FindParam('INVH_NO') <> nil then adoReport1.Params.ParamByName('INVH_NO').AsString := Trim(fndINVH_NO.Text);
  Factor.Open(adoReport1);

  if adoReport1.IsEmpty then Exit;
  adoReport1.First;
  while not adoReport1.Eof do
  begin
    iUAmt := 0;
    iCAmt := 0;
    List := TStringList.Create;
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := ' select INVOICE_NO from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID and INVOICE_STATUS=''1'' '+
                     ' and CREA_DATE>=:D1 and CREA_DATE<=:D2 order by INVOICE_NO';
      rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs.Params.ParamByName('INVH_ID').AsString := adoReport1.FieldByName('INVH_ID').AsString;
      rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      Factor.Open(rs);
      rs.First;
      sUStartNo := rs.FieldByName('INVOICE_NO').AsString;
      while not rs.Eof do
      begin
        Inc(iUAmt);
        rs.Next;
      end;
      sUEndNo := rs.FieldByName('INVOICE_NO').AsString;

      rs.Close;
      rs.SQL.Text := ' select INVOICE_NO from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID and INVOICE_STATUS=''2'' '+
                     ' and CREA_DATE>=:D1 and CREA_DATE<=:D2 order by INVOICE_NO';
      rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs.Params.ParamByName('INVH_ID').AsString := adoReport1.FieldByName('INVH_ID').AsString;
      rs.Params.ParamByName('D1').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D1.Date));
      rs.Params.ParamByName('D2').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',P1_D2.Date));
      Factor.Open(rs);
      rs.First;
      while not rs.Eof do
      begin
        Inc(iCAmt);
        if Trim(sCNo)='' then
           sCNo := rs.FieldByName('INVOICE_NO').AsString
        else
           sCNo := sCNo+','+rs.FieldByName('INVOICE_NO').AsString;
        rs.Next;
      end;
      if adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger = 0 then
      begin
         List.Delimiter := '-';
         List.DelimitedText := adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString;
         sBeginNo := List.Strings[0];
         sEndNo := List.Strings[1];
      end
      else
      begin
         List.Delimiter := '-';
         List.DelimitedText := adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString;
         sBeginNo := List.Strings[0];
         sEndNo := List.Strings[1];
      end;
      adoReport1.Edit;
      adoReport1.FieldByName('USING_AMT').AsInteger := iUAmt;
      if iUAmt > 0 then
         adoReport1.FieldByName('USING_INVH_NO').AsString := FnString.FormatStringEx(sUStartNo,8)+'-'+FnString.FormatStringEx(sUEndNo,8);
      adoReport1.FieldByName('CANCEL_AMT').AsInteger := iCAmt;
      adoReport1.FieldByName('CANCEL_INVH_NO').AsString := sCNo;
      if adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger = 0 then
      begin
         adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString := FnString.FormatStringEx(sBeginNo,8)+'-'+FnString.FormatStringEx(sEndNo,8);
         if iUAmt > 0 then
         begin
            adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('THIS_TOTAL_AMT').AsInteger - iUAmt - iCAmt;
            adoReport1.FieldByName('BALANCE_INVH_NO').AsString := FnString.FormatStringEx(IntToStr(StrToInt(sUEndNo)+1),8)+'-'+FnString.FormatStringEx(sEndNo,8);
         end
         else
         begin
            adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('THIS_TOTAL_AMT').AsInteger;
            adoReport1.FieldByName('BALANCE_INVH_NO').AsString := adoReport1.FieldByName('THIS_TOTAL_INVH_NO').AsString;
         end;
      end
      else
      begin
         adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString := FnString.FormatStringEx(sBeginNo,8)+'-'+FnString.FormatStringEx(sEndNo,8);
         if iUAmt > 0 then
         begin
            adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger - iUAmt - iCAmt;
            adoReport1.FieldByName('BALANCE_INVH_NO').AsString := FnString.FormatStringEx(IntToStr(StrToInt(sUEndNo)+1),8)+'-'+FnString.FormatStringEx(sEndNo,8);
         end
         else
         begin
            adoReport1.FieldByName('BALANCE').AsInteger := adoReport1.FieldByName('LAST_TOTAL_AMT').AsInteger;
            adoReport1.FieldByName('BALANCE_INVH_NO').AsString := adoReport1.FieldByName('LAST_TOTAL_INVH_NO').AsString;
         end;
      end;
      adoReport1.Post;
    finally
      rs.Free;
      List.Free;
    end;

    adoReport1.Next;
  end;
end;

function TfrmInvoiceTotalReport.GetInvoiceBookSql: String;
var sSql,sWhere,sJoin:String;
begin
  if (P1_D1.EditValue = null) or (P1_D2.EditValue = null) then Raise Exception.Create('领用日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('领用的结束日期不能小于开始日期...');
  sWhere := ' where TENANT_ID=:TENANT_ID ';
  if fndSHOP_ID.AsString <> '' then
     sWhere := sWhere + ' and SHOP_ID=:SHOP_ID ';
  if fndDEPT_ID.AsString <> '' then
     sWhere := sWhere + ' and DEPT_ID=:DEPT_ID ';
  if fndCREA_USER.AsString <> '' then
     sWhere := sWhere + ' and CREA_USER=:CREA_USER ';
  if fndINVOICE_FLAG.ItemIndex <> -1 then
     sWhere := sWhere + ' and INVOICE_FLAG=:INVOICE_FLAG ';
  if Trim(fndINVH_NO.Text) <> '' then
     sWhere := sWhere + ' and INVH_NO like ''%:INVH_NO''';
  sJoin := GetStrJoin(Factor.iDbType);
  sSql := ' select INVH_ID,INVH_NO,case when CREA_DATE<:D1 then TOTAL_AMT else 0 end as LAST_TOTAL_AMT,'+
          ' case when CREA_DATE<:D1 then BEGIN_NO'+sJoin+'''-'''+sJoin+'ENDED_NO else '''' end as LAST_TOTAL_INVH_NO, '+
          ' case when (CREA_DATE>=:D1 and CREA_DATE<=:D2) then TOTAL_AMT else 0 end as THIS_TOTAL_AMT,'+
          ' case when (CREA_DATE>=:D1 and CREA_DATE<=:D2) then BEGIN_NO'+sJoin+'''-'''+sJoin+'ENDED_NO else '''' end as THIS_TOTAL_INVH_NO,'+
          ' case when CREA_DATE<:D1 then 0 '+
          '      when (CREA_DATE>=:D1 and CREA_DATE<=:D2) then USING_AMT '+
          '      else 0 end as USING_AMT,'''' as USING_INVH_NO,'+
          ' case when CREA_DATE<:D1 then 0 '+
          '      when (CREA_DATE>=:D1 and CREA_DATE<=:D2) then CANCEL_AMT '+
          '      else 0 end as CANCEL_AMT,'''' as CANCEL_INVH_NO,'+
          ' case when CREA_DATE<:D1 then 0 '+
          '      when (CREA_DATE>=:D1 and CREA_DATE<=:D2) then BALANCE '+
          '      else 0 end as BALANCE,'''' as BALANCE_INVH_NO '+
          ' from SAL_INVOICE_BOOK '+sWhere;
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
