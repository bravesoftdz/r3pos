unit ufrmRecvDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

type
  TfrmRecvDayReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel9: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    RzBitBtn3: TRzBitBtn;
    RzPanel15: TRzPanel;
    DBGridEh4: TDBGridEh;
    dsadoReport4: TDataSource;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label10: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label11: TLabel;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label12: TLabel;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    Label9: TLabel;
    Label3: TLabel;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP3_SHOP_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private    
    //按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
  public
    HasChild: boolean;   
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;
{$R *.dfm}

procedure TfrmRecvDayReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  HasChild := (ShopGlobal.GetZQueryFromName('CA_SHOP_INFO').RecordCount>1);
  rzPage.Pages[0].TabVisible := HasChild;
  rzPage.Pages[1].TabVisible := HasChild;
    
  RefreshColumn;
end;

function TfrmRecvDayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');  
  
  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=' ';

        end;
    3: begin //Access

      end;
  end;
 
  Result := strSql;
end;

function TfrmRecvDayReport.GetRowType: integer;
begin
  result := DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmRecvDayReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //按地区汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按门店汇总表
        if adoReport2.Active then adoReport2.Close;
        strSql := GetShopSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按分类汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
  end;
end;

function TfrmRecvDayReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :='';
       end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmRecvDayReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=' ';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmRecvDayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs:TADODataSet;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :='';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

procedure TfrmRecvDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  DoAssignParamsValue(w1,RzPanel9);
end;

procedure TfrmRecvDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  DoAssignParamsValue(RzPanel9,RzPanel11);
end;

procedure TfrmRecvDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  DoAssignParamsValue(RzPanel11, RzPanel14);
end;

procedure TfrmRecvDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmRecvDayReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;
  {
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P1_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P1_D2.Date);
      if fndP1_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP1_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP1_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP1_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP1_SORT_ID.Text;
           inc(c);
         end;
      if fndP1_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP1_TYPE_ID.Text+'：'+fndP1_STAT_ID.Text;
           inc(c);
         end;
      if fndP1_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP1_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP1_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP1_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  1:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P2_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P2_D2.Date);
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '地区名称：'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP2_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP2_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP2_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP2_SORT_ID.Text;
           inc(c);
         end;
      if fndP2_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP2_TYPE_ID.Text+'：'+fndP2_STAT_ID.Text;
           inc(c);
         end;
      if fndP2_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP2_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP2_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP2_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  2:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P3_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P3_D2.Date);
      if fndP3_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP3_COMP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP3_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP3_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP3_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示级别：'+fndP3_SORT_ID.Text;
           inc(c);
         end;
      if fndP3_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP3_TYPE_ID.Text+'：'+fndP3_STAT_ID.Text;
           inc(c);
         end;
      if fndP3_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP3_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP3_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP3_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  3:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P4_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P4_D2.Date);
      if fndP4_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店名称：'+fndP4_COMP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP4_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP4_CUST_ID.Text;
           inc(c);
         end;
      if trim(fndP4_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '商品分类：'+fndP4_SORT_ID.Text;
           inc(c);
         end;
      if fndP4_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP4_TYPE_ID.Text+'：'+fndP4_STAT_ID.Text;
           inc(c);
         end;
      if fndP4_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP4_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP4_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP4_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  4:begin
      c := 0;
      inc(c);
      s := '日期：'+formatDatetime('YYYY-MM-DD',P5_D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',P5_D2.Date);
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '门店类型：'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '会员名称：'+fndP5_CUST_ID.Text;
           inc(c);
         end;
      if fndP5_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '票据类型：'+fndP5_INVOICE_FLAG.Text;
           inc(c);
         end;
      if fndP5_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '显示单位：'+fndP5_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
      if fndP5_GODS_ID.asString<>'' then
         PrintDBGridEh1.Title.Text := '商品名称：'+ fndP5_GODS_ID.Text;
    end;
  end;
  }
end;

end.

