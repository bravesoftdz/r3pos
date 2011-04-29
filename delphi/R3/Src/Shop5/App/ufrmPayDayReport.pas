unit ufrmPayDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox, RzChkLst,
  RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh, cxCalendar, cxButtonEdit,
  cxCheckBox, zbase, zrComboBoxList, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cxRadioGroup;

type
  TfrmPayDayReport = class(TframeBaseReport)
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
    TabSheet5: TRzTabSheet;
    RzPanel16: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel10: TRzLabel;
    Label4: TLabel;
    Label6: TLabel;
    P5_D1: TcxDateEdit;
    P5_D2: TcxDateEdit;
    RzBitBtn4: TRzBitBtn;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    fndP5_SHOP_ID: TzrComboBoxList;
    RzPanel17: TRzPanel;
    DBGridEh5: TDBGridEh;
    adoReport5: TZQuery;
    dsadoReport5: TDataSource;
    lblCLIENT_ID: TLabel;
    fndP5_CLIENT_ID: TzrComboBoxList;
    Label7: TLabel;
    fndP5_PayMan: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    IsOnDblClick: Boolean;  //是双击DBGridEh标记位

    //返回基础数据的报表
    function GetRcevBaseData(fndBegDate,fndEndDate: TcxDateEdit): string;
    //按管理付款汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店付款汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按日期分类汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按供应商付款汇总表
    function GetRecvSupplieSQL(chk:boolean=true): string;
    //按付款流水查询
    function GetGuideSQl(chk:boolean=true): string;
    //SQLITE计算逾期天数
    procedure CaclOverDays(Report:TZQuery; BegField,EndField: string);


    //输入查询条件最大值日期，返回台帐表的最大结帐日期
    function GetRckMaxDate(EndDate: integer): Integer;
    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //返回门店查询条件
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string;
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //时间条件
    //初始化DBGrid
    procedure InitGrid;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmPayDayReport.FormCreate(Sender: TObject);
begin
  inherited;
  IsOnDblClick:=False;
  TDbGridEhSort.InitForm(self);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  
  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  fndP5_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  fndP5_PAYMan.DataSet := Global.GetZQueryFromName('CA_USERS');  

  SetRzPageActivePage; //设置PzPage.Activepage

  InitGrid;
  RefreshColumn;

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      fndP3_SHOP_ID.Properties.ReadOnly := False;
      fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP3_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
      fndP3_SHOP_ID.Properties.ReadOnly := True;

      fndP4_SHOP_ID.Properties.ReadOnly := False;
      fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP4_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP4_SHOP_ID.Style);
      fndP4_SHOP_ID.Properties.ReadOnly := True;

      fndP5_SHOP_ID.Properties.ReadOnly := False;
      fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP5_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP5_SHOP_ID.Style);
      fndP5_SHOP_ID.Properties.ReadOnly := True;
    end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label3.Caption := '仓库名称';

      Label4.Caption := '仓库群组';
      Label6.Caption := '仓库名称';
    end;
end;

function TfrmPayDayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,RecvData,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //返回基础表：
  RecvData:=GetRcevBaseData(P1_D1,P1_D2);

  //按根据条件门店汇总:
  strSql:=
     'select B.REGION_ID as REGION_ID'+
     ',sum(ORG_ALL_MNY) as ORG_ALL_MNY '+
     ',sum(NEW_ALL_MNY) as NEW_ALL_MNY '+
     ',sum(ALL_MNY) as ALL_MNY '+
     ',sum(ORG_ADVA_MNY) as ORG_ADVA_MNY '+
     ',sum(NEW_ADVA_MNY) as NEW_ADVA_MNY '+
     ',sum(ADVA_MNY) as ADVA_MNY '+
     ',sum(ORG_PAY_MNY) as ORG_PAY_MNY '+
     ',sum(NEW_PAY_MNY) as NEW_PAY_MNY '+
     ',sum(PAY_MNY) as PAY_MNY '+
     ',sum(ORG_RETURN_MNY) as ORG_RETURN_MNY '+
     ',sum(NEW_RETURN_MNY) as NEW_RETURN_MNY '+
     ',sum(RETURN_MNY) as RETURN_MNY  '+
     ' from ('+RecvData+') A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
     ' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'')+' '+
     ' group by B.REGION_ID ';

  strSql:=
    'select jp.*,isnull(r.CODE_NAME,''无'') as CODE_NAME from  ('+strSql+') jp '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on jp.REGION_ID=r.CODE_ID order by jp.REGION_ID ';   

  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmPayDayReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmPayDayReport.actFindExecute(Sender: TObject);
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
    3: begin //按供应商汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetRecvSupplieSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
    4:
      begin //付款流水
        if adoReport5.Active then adoReport5.Close;
        strSql := GetGuideSQl;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
        //统一计算不在分类型
        //if (adoReport5.Active) and (Factor.iDbType=5) then
        CaclOverDays(adoReport5,'ABLE_DATE','PAY_DATE');
      end;
  end;
end;

function TfrmPayDayReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,RecvData,strWhere: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //返回基础表：
  RecvData:=GetRcevBaseData(P2_D1,P2_D2);

  //按根据条件门店汇总:
  strSql:=
     'select A.TENANT_ID as TENANT_ID,A.SHOP_ID as SHOP_ID'+
     ',sum(ORG_ALL_MNY) as ORG_ALL_MNY '+
     ',sum(NEW_ALL_MNY) as NEW_ALL_MNY '+
     ',sum(ALL_MNY) as ALL_MNY '+
     ',sum(ORG_ADVA_MNY) as ORG_ADVA_MNY '+
     ',sum(NEW_ADVA_MNY) as NEW_ADVA_MNY '+
     ',sum(ADVA_MNY) as ADVA_MNY '+
     ',sum(ORG_PAY_MNY) as ORG_PAY_MNY '+
     ',sum(NEW_PAY_MNY) as NEW_PAY_MNY '+
     ',sum(PAY_MNY) as PAY_MNY '+
     ',sum(ORG_RETURN_MNY) as ORG_RETURN_MNY '+
     ',sum(NEW_RETURN_MNY) as NEW_RETURN_MNY '+
     ',sum(RETURN_MNY) as RETURN_MNY  '+
     ' from ('+RecvData+') A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
     ' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.SHOP_ID ';

  strSql :=
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';
  Result := ParseSQL(Factor.iDbType,strSql); 
end;

function TfrmPayDayReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,RecvData,strWhere: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //返回基础表：
  RecvData:=GetRcevBaseData(P3_D1,P3_D2);

  //按根据条件门店汇总:
  strSql:=
     'select A.TENANT_ID as TENANT_ID,A.ABLE_DATE as ABLE_DATE '+
     ',sum(ORG_ALL_MNY) as ORG_ALL_MNY '+
     ',sum(NEW_ALL_MNY) as NEW_ALL_MNY '+
     ',sum(ALL_MNY) as ALL_MNY '+
     ',sum(ORG_ADVA_MNY) as ORG_ADVA_MNY '+
     ',sum(NEW_ADVA_MNY) as NEW_ADVA_MNY '+
     ',sum(ADVA_MNY) as ADVA_MNY '+
     ',sum(ORG_PAY_MNY) as ORG_PAY_MNY '+
     ',sum(NEW_PAY_MNY) as NEW_PAY_MNY '+
     ',sum(PAY_MNY) as PAY_MNY '+
     ',sum(ORG_RETURN_MNY) as ORG_RETURN_MNY '+
     ',sum(NEW_RETURN_MNY) as NEW_RETURN_MNY '+
     ',sum(RETURN_MNY) as RETURN_MNY  '+
     ' from ('+RecvData+') A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
     ' '+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.ABLE_DATE ';

  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmPayDayReport.GetRecvSupplieSQL(chk:boolean=true): string;
var
  strSql,RecvData,strWhere: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('付款日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //返回基础表：
  RecvData:=GetRcevBaseData(P4_D1,P4_D2);

  //按根据条件门店汇总:
  strSql:=
     'select A.TENANT_ID as TENANT_ID,A.CLIENT_ID as CLIENT_ID '+
     ',sum(ORG_ALL_MNY) as ORG_ALL_MNY '+
     ',sum(NEW_ALL_MNY) as NEW_ALL_MNY '+
     ',sum(ALL_MNY) as ALL_MNY '+
     ',sum(ORG_ADVA_MNY) as ORG_ADVA_MNY '+
     ',sum(NEW_ADVA_MNY) as NEW_ADVA_MNY '+
     ',sum(ADVA_MNY) as ADVA_MNY '+
     ',sum(ORG_PAY_MNY) as ORG_PAY_MNY '+
     ',sum(NEW_PAY_MNY) as NEW_PAY_MNY '+
     ',sum(PAY_MNY) as PAY_MNY '+
     ',sum(ORG_RETURN_MNY) as ORG_RETURN_MNY '+
     ',sum(NEW_RETURN_MNY) as NEW_RETURN_MNY '+
     ',sum(RETURN_MNY) as RETURN_MNY  '+
     ' from ('+RecvData+') A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.CLIENT_ID ';

  //关联操作员:
  strSql :=
    ' select j.*,r.CLIENT_CODE,r.CLIENT_NAME from ('+strSql+') j '+
    ' left outer join VIW_CLIENTINFO r on '+
    ' j.TENANT_ID=r.TENANT_ID and j.CLIENT_ID=r.CLIENT_ID order by r.ACCOUNT ';  

  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmPayDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P2_D1.Date:=P1_D1.Date;
  P2_D2.Date:=P1_D2.Date;
  fndP2_SHOP_TYPE.ItemIndex:=0;
  fndP2_SHOP_VALUE.KeyValue:=trim(adoReport1.fieldbyName('REGION_ID').AsString);
  fndP2_SHOP_VALUE.Text:=trim(adoReport1.fieldbyName('CODE_NAME').AsString);
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmPayDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  fndP3_SHOP_TYPE.ItemIndex:=fndP2_SHOP_TYPE.ItemIndex;
  fndP3_SHOP_VALUE.KeyValue:=fndP2_SHOP_VALUE.KeyValue;
  fndP3_SHOP_VALUE.Text:=fndP2_SHOP_VALUE.Text;
  fndP3_SHOP_ID.KeyValue:=trim(adoReport2.fieldbyName('SHOP_ID').AsString);
  fndP3_SHOP_ID.Text:=trim(adoReport2.fieldbyName('SHOP_NAME').AsString);
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmPayDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P4_D1.Date:=FnTime.fnStrtoDate(adoReport3.fieldbyName('ABLE_DATE').AsString);
  P4_D2.Date:=P4_D1.Date;
  fndP4_SHOP_TYPE.ItemIndex:=fndP3_SHOP_TYPE.ItemIndex;
  fndP4_SHOP_VALUE.KeyValue:=fndP3_SHOP_VALUE.KeyValue;
  fndP4_SHOP_VALUE.Text:=fndP3_SHOP_VALUE.Text;
  fndP4_SHOP_ID.KeyValue:=fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text:=fndP3_SHOP_ID.Text;
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmPayDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmPayDayReport.InitGrid;
  procedure InitGridColums(Rs: TDataSet; Grid: TDBGridEh);
  var
    i: integer;
    ColName: string;
  begin
    for i:=Grid.Columns.Count-1 downto 0 do
    begin
      if trim(Grid.Columns[i].FieldName)='PAY_ALL' then continue;
      if Copy(trim(Grid.Columns[i].FieldName),1,4)='PAY_' then
      begin
        Grid.Columns[i].Width := 55;
        ColName:=Copy(trim(Grid.Columns[i].FieldName),5,1);
        if Rs.Locate('CODE_ID',ColName,[]) then  //定位到修改: Title.Caption
          Grid.Columns[i].Title.Caption:='其中|'+rs.FieldbyName('CODE_NAME').AsString
        else
          Grid.Columns.Delete(i);
      end;
    end;
  end;
var
  rs: TZQuery;
  Column: TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_PAYMENT');
  if not rs.Active then Exit;

  InitGridColums(Rs,DBGridEh1);
  InitGridColums(Rs,DBGridEh2);
  InitGridColums(Rs,DBGridEh3);
  InitGridColums(Rs,DBGridEh4);
end;

procedure TfrmPayDayReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  try
    Title:=TStringList.Create;
    case rzPage.ActivePageIndex of
     0: AddReportReport(Title,'1');
     1: AddReportReport(Title,'2');
     2: AddReportReport(Title,'3');
     3: AddReportReport(Title,'4');
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmPayDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('付款日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


function TfrmPayDayReport.GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string;
begin
  result:='';
  if ShopID.AsString<>'' then
    result:=' and '+FieldName+'='''+ShopID.AsString+''' ';
end;

function TfrmPayDayReport.GetDateCnd(BegDate, EndDate: TcxDateEdit; FieldName: string): string;
begin
  result:='';
  if BegDate.Date=EndDate.Date then
    result:=' and ('+FieldName+'='+FormatDatetime('YYYYMMDD',BegDate.Date)+')'
  else
    result:=' and ('+FieldName+'>='+FormatDatetime('YYYYMMDD',BegDate.Date)+' and '+FieldName+'<='+FormatDatetime('YYYYMMDD',EndDate.Date)+')';
end;

function TfrmPayDayReport.GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string;
var
  AName: string;
begin
  result:='';
  AName:='';
  if trim(AliasName)<>'' then AName:=trim(AliasName)+'.';
  if TYPE_VALUE.AsString<>'' then
  begin
    case SHOP_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(TYPE_VALUE.AsString),2)='00' then //非末级区域
           result:=' and '+AName+'REGION_ID like '''+GetRegionId(TYPE_VALUE.AsString)+'%'' '
         else
           result:=' and '+AName+'REGION_ID='''+TYPE_VALUE.AsString+''' ';
       end;
     1: result:=' and '+AName+'SHOP_TYPE='''+TYPE_VALUE.AsString+''' ';
    end;
  end;
end;  

function TfrmPayDayReport.GetRckMaxDate(EndDate: integer): integer;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) as CREA_DATE from RCK_ACCT_DAYS where TENANT_ID=:TENANT_ID and CREA_DATE<=:CREA_DATE ';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := EndDate;
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
      result := EndDate
    else
      result := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

{ '4': 应付款; '5': 应退款; '6':预付款 }

function TfrmPayDayReport.GetRcevBaseData(fndBegDate, fndEndDate: TcxDateEdit): string;
var
  vBegDate,vEndDate,Str: string; //开始日期|结束日期
begin
  if fndBegDate.Date=fndEndDate.Date then
  begin
    vBegDate:=FormatDatetime('YYYYMMDD',fndBegDate.Date);
    Str:='select TENANT_ID,SHOP_ID,ABLE_DATE,CLIENT_ID '+
       ',(case when ABLE_DATE<>'+vBegDate+' then PAY_MNY else 0 end) as ORG_ALL_MNY '+   //付款合计:往日
       ',(case when ABLE_DATE='+vBegDate+'  then PAY_MNY else 0 end) as NEW_ALL_MNY '+   //付款合计:本期
       ', PAY_MNY as ALL_MNY '+                                                         //付款小计
       ',(case when (ABLE_TYPE=''6'') and (ABLE_DATE<>'+vBegDate+') then PAY_MNY else 0 end) as ORG_ADVA_MNY '+   //预付款往日
       ',(case when (ABLE_TYPE=''6'') and (ABLE_DATE='+vBegDate+')  then PAY_MNY else 0 end) as NEW_ADVA_MNY '+   //预付款本期
       ',(case when  ABLE_TYPE=''6'' then PAY_MNY else 0 end) as ADVA_MNY '+                                     //预付款小计
       ',(case when (ABLE_TYPE=''4'') and (ABLE_DATE<>'+vBegDate+') then PAY_MNY else 0 end) as ORG_PAY_MNY '+   //应付往日
       ',(case when (ABLE_TYPE=''4'') and (ABLE_DATE='+vBegDate+')  then PAY_MNY else 0 end) as NEW_PAY_MNY '+   //应付本期
       ',(case when  ABLE_TYPE=''4'' then PAY_MNY else 0 end) as PAY_MNY '+                                     //应付小计
       ',(case when (ABLE_TYPE=''5'') and (ABLE_DATE<>'+vBegDate+') then PAY_MNY else 0 end) as ORG_RETURN_MNY '+ //应退往日
       ',(case when (ABLE_TYPE=''5'') and (ABLE_DATE='+vBegDate+')  then PAY_MNY else 0 end) as NEW_RETURN_MNY '+ //应退本日
       ',(case when  ABLE_TYPE=''5'' then PAY_MNY else 0 end) as RETURN_MNY '+                                   //应退小计
       ' from VIW_PAYABLEDATA where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and ABLE_DATE='+vBegDate;
  end else
  if fndBegDate.Date<fndEndDate.Date then
  begin
    vBegDate:=FormatDatetime('YYYYMMDD',fndBegDate.Date);
    vEndDate:=FormatDatetime('YYYYMMDD',fndEndDate.Date);
    Str:='select TENANT_ID,SHOP_ID,ABLE_DATE,CLIENT_ID '+
      ',(case when (ABLE_DATE<'+vBegDate+' or ABLE_DATE>'+vEndDate+') then PAY_MNY else 0 end) as ORG_ALL_MNY '+   //付款合计:往日
      ',(case when (ABLE_DATE>='+vBegDate+') and (ABLE_DATE<='+vEndDate+') then PAY_MNY else 0 end) as NEW_ALL_MNY '+   //付款合计:本期
      ', PAY_MNY as ALL_MNY '+                                                         //付款小计
      ',(case when (ABLE_TYPE=''6'') and (ABLE_DATE<'+vBegDate+' or ABLE_DATE>'+vEndDate+') then PAY_MNY else 0 end) as ORG_ADVA_MNY '+   //预付款往日
      ',(case when (ABLE_TYPE=''6'') and (ABLE_DATE>='+vBegDate+') and (ABLE_DATE<='+vEndDate+')  then PAY_MNY else 0 end) as NEW_ADVA_MNY '+   //预付款本期
      ',(case when  ABLE_TYPE=''6'' then PAY_MNY else 0 end) as ADVA_MNY '+                                     //预付款小计
      ',(case when (ABLE_TYPE=''4'') and (ABLE_DATE<'+vBegDate+' or ABLE_DATE>'+vEndDate+') then PAY_MNY else 0 end) as ORG_PAY_MNY '+   //付款往日
      ',(case when (ABLE_TYPE=''4'') and (ABLE_DATE>='+vBegDate+') and (ABLE_DATE<='+vEndDate+')  then PAY_MNY else 0 end) as NEW_PAY_MNY '+   //付款本期
      ',(case when  ABLE_TYPE=''4'' then PAY_MNY else 0 end) as PAY_MNY '+                                     //付款小计
      ',(case when (ABLE_TYPE=''5'') and (ABLE_DATE<'+vBegDate+' or ABLE_DATE>'+vEndDate+') then PAY_MNY else 0 end) as ORG_RETURN_MNY '+ //退款往日
      ',(case when (ABLE_TYPE=''5'') and (ABLE_DATE>='+vBegDate+') and (ABLE_DATE<='+vEndDate+') then PAY_MNY else 0 end) as NEW_RETURN_MNY '+ //退款本日
      ',(case when  ABLE_TYPE=''5'' then PAY_MNY else 0 end) as RETURN_MNY '+                                   //退款小计
      ' from VIW_PAYABLEDATA where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and ABLE_DATE>='+vBegDate+' and ABLE_DATE<='+vEndDate+' ';
  end;
  result:=str;
end;

function TfrmPayDayReport.GetGuideSQl(chk: boolean): string;
var
  strSql,strWhere: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create(' 付款开始日期条件不能为空！');
  if P5_D2.EditValue = null then Raise Exception.Create(' 付款结束日期条件不能为空！');
  if P5_D1.Date>P5_D2.Date then Raise Exception.Create(' 付款开始日期不能大于结束日期！ ');
  // if round(PP5_D2.date-P5_D1.Date)>62 then Raise Exception.Create(' 您查询的时间段太长了，软件只能查询两个月内的流水单据 ');
  strWhere:='';

  //付款查询条件
  strWhere:=GetDateCnd(P5_D1, P5_D2, 'ABLE_DATE');
  //门店管理群组
  strWhere:=strWhere+GetShopGroupCnd(fndP5_SHOP_TYPE,fndP5_SHOP_VALUE,'');
  //门店名称查询条件
  strWhere:=strWhere+GetShopIDCnd(fndP5_SHOP_ID,'A.SHOP_ID');
  //供应商查询条件
  if fndP5_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP5_CLIENT_ID.AsString+''' ';
  //收款人查询条件
  if fndP5_PayMan.AsString<>'' then
    strWhere:=strWhere+' and A.PAY_USER='''+fndP5_PayMan.AsString+''' ';

  //关联语句
  strSql:=
    'select je.*,r.USER_NAME as USER_NAME,0 as OVERDAYS from '+
    '(select jd.*,E.ACCT_NAME as ACC_NAME from '+
    '(select j.*,D.CLIENT_NAME as CUST_NAME from  '+
    ' (select A.*,B.SHOP_NAME from VIW_PAYABLEDATA A,CA_SHOP_INFO B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+strWhere+') j '+
    '  left outer join VIW_CLIENTINFO D on j.TENANT_ID=D.TENANT_ID and j.CLIENT_ID=D.CLIENT_ID)jd '+
    '  left outer join ACC_ACCOUNT_INFO E on jd.ACCOUNT_ID=E.ACCOUNT_ID)je '+
    '  left outer join viw_users r on je.TENANT_ID=r.TENANT_ID and je.PAY_USER=r.USER_ID order by je.PAY_USER ';

  Result := ParseSQL(Factor.iDbType,strSql);
end;


procedure TfrmPayDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  if adoReport4.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  fndP5_SHOP_TYPE.ItemIndex:=fndP4_SHOP_TYPE.ItemIndex;
  fndP5_SHOP_VALUE.KeyValue:=fndP4_SHOP_VALUE.KeyValue;
  fndP5_SHOP_VALUE.Text:=fndP4_SHOP_VALUE.Text;
  fndP5_SHOP_ID.KeyValue:=fndP4_SHOP_ID.KeyValue;
  fndP5_SHOP_ID.Text:=fndP4_SHOP_ID.Text;
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmPayDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmPayDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmPayDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'ABLE_DATE' then Text := '合计:'+Text+'笔';
end;

procedure TfrmPayDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
end;
      
procedure TfrmPayDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GLIDE_NO' then Text := '合计:'+Text+'笔';
end;

procedure TfrmPayDayReport.CaclOverDays(Report: TZQuery; BegField, EndField: string);
var
  OverDays: Extended;
  IdxBeg,IdxEnd,IdxDay: integer;
begin
  if not Report.Active then Exit;
  IdxBeg:=RePort.fieldbyName(BegField).Index;
  IdxEnd:=RePort.fieldbyName(EndField).Index;
  IdxDay:=RePort.fieldbyName('OVERDAYS').Index;
  Report.First;
  while not Report.Eof do
  begin
    OverDays:=FnTime.fnStrtoDate(Report.Fields[IdxEnd].AsString)-FnTime.fnStrtoDate(Report.Fields[IdxBeg].AsString);
    if OverDays<0 then OverDays:=0;
    Report.Edit;
    Report.Fields[IdxDay].AsFloat:=OverDays;
    Report.Post;
    Report.Next;
  end;
end;

end.

