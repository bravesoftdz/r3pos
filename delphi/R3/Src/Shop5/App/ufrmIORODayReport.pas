unit ufrmIORODayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox, RzChkLst,
  RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh, cxCalendar, cxButtonEdit,
  cxCheckBox, zbase, zrComboBoxList, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, cxRadioGroup;
                                
type
  TfrmIORODayReport = class(TframeBaseReport)
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
    DBGridEh4: TDBGridEh;
    fndP4_PAYM_ID: TzrComboBoxList;
    Label4: TLabel;
    fndP4_ACCOUNT_ID: TzrComboBoxList;
    Label6: TLabel;
    Label7: TLabel;
    fndP4_USER_ID: TzrComboBoxList;
    Label8: TLabel;
    fndP3_SortType: TcxComboBox;
    LblSortName: TLabel;
    fndP3_SORT_NAME: TzrComboBoxList;
    Label13: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    Label14: TLabel;
    fndP4_ITEM_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    procedure fndP3_SortTypePropertiesChange(Sender: TObject);
  private
    PUB_CLient: TZQuery;
    IsOnDblClick: Boolean;  //是双击DBGridEh标记位
    //计算日台账:
    procedure CheckCalc(EndDate: integer); //开始月份| 结束月份
    //按管理收款汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店收款汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按日期分类汇总表
    function GetSortSQL(chk:boolean=true): string;
    //按商品收款汇总表
    function GetGodsSQL(chk:boolean=true): string;

    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //返回门店查询条件
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //时间条件
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string; //门店所属行政区域|门店类型:

    //设置往来客户
    procedure SetFndP4_ClientID_DataSet;
    //初始化DBGrid
    procedure InitGrid;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon,
  ufrmCostCalc;
{$R *.dfm}

procedure TfrmIORODayReport.FormCreate(Sender: TObject);
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

  SetRzPageActivePage; //设置PzPage.Activepage

  //设置供应商+客户: DataSet
  PUB_CLient:=TZQuery.Create(self);
  fndP4_CLIENT_ID.DataSet:=PUB_CLient;
  SetFndP4_ClientID_DataSet; //取数据

  //设置关联的数据集:  
  fndP4_ITEM_ID.DataSet:= Global.GeTZQueryFromName('ACC_ITEM_INFO');
  fndP4_ACCOUNT_ID.DataSet := Global.GeTZQueryFromName('ACC_ACCOUNT_INFO');
  fndP4_PAYM_ID.DataSet := Global.GetZQueryFromName('PUB_PAYMENT');
  fndP4_USER_ID.DataSet:= Global.GeTZQueryFromName('CA_USERS');
  fndP3_SortType.ItemIndex:=0;

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
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label3.Caption := '仓库名称';
    end;

end;

function TfrmIORODayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql, strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //过滤日期
  strWhere:=strWhere+' '+GetDateCnd(P1_D1,P1_D2,'IORO_DATE');
  //门店群主及时门店名称条件
  strWhere:=strWhere+' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'');
  
  //按行政区域汇总:
  strSql:=
    'select B.REGION_ID as REGION_ID,sum(IN_MONEY) as IN_MONEY,sum(OUT_MONEY) as OUT_MONEY '+
    'from VIW_IORODATA A,CA_SHOP_INFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+strWhere+
    ' group by B.REGION_ID ';

  strSql:=
    'select jp.*,isnull(r.CODE_NAME,''无'') as CODE_NAME from  ('+strSql+') jp '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on jp.REGION_ID=r.CODE_ID order by jp.REGION_ID ';      

  Result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmIORODayReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmIORODayReport.actFindExecute(Sender: TObject);
var
  strSql: string;
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

function TfrmIORODayReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,strWhere: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //过滤日期
  strWhere:=strWhere+' '+GetDateCnd(P2_D1,P2_D2,'IORO_DATE');
  //门店群主及时门店名称条件
  strWhere:=strWhere+' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'');

  //按根据条件门店汇总:
  strSql:=
    'select A.SHOP_ID as SHOP_ID,B.SEQ_NO as SHOP_CODE,B.SHOP_NAME as SHOP_NAME,sum(IN_MONEY) as IN_MONEY,sum(OUT_MONEY) as OUT_MONEY '+
    'from VIW_IORODATA A,CA_SHOP_INFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+strWhere+
    ' group by B.SEQ_NO,B.SHOP_NAME,A.SHOP_ID ';

  Result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmIORODayReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,ViwSql,RCKRData,strWhere: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');
  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';

  //过滤日期
  strWhere:=strWhere+' '+GetDateCnd(P3_D1,P3_D2,'A.IORO_DATE');

  //门店群主及时门店名称条件
  strWhere:=strWhere+' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'');

  //账户|科目条件:
  case fndP3_SortType.ItemIndex of   
   0: if trim(fndP3_SORT_NAME.AsString)<>'' then strWhere:=strWhere+' and A.ACCOUNT_ID='''+trim(fndP3_SORT_NAME.AsString)+''' '; //账户条件 
   1: if trim(fndP3_SORT_NAME.AsString)<>'' then strWhere:=strWhere+' and A.ITEM_ID='''+trim(fndP3_SORT_NAME.AsString)+''' ';    //科目条件
  end;

  case fndP3_SortType.ItemIndex of
   0:  //按收支科目:
    begin
      strSql:=
        'select jb.ITEM_ID as SORT_ID,C.CODE_NAME as SORT_NAME,sum(IN_MONEY) as IN_MONEY,sum(OUT_MONEY) as OUT_MONEY from '+
        '(select A.TENANT_ID as TENANT_ID,ITEM_ID,IN_MONEY,OUT_MONEY '+
        ' from VIW_IORODATA A,CA_SHOP_INFO B '+
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+strWhere+')jb '+
        ' left outer join VIW_ITEM_INFO C on jb.TENANT_ID=C.TENANT_ID and jb.ITEM_ID=C.CODE_ID '+
        ' group by C.CODE_NAME,jb.ITEM_ID ';
    end;
   1:  //按账户名称:
    begin
      strSql:=
        'select jb.ACCOUNT_ID as SORT_ID,C.ACCT_NAME as SORT_NAME,sum(IN_MONEY) as IN_MONEY,sum(OUT_MONEY) as OUT_MONEY from '+
        '(select A.TENANT_ID as TENANT_ID,A.SHOP_ID as SHOP_ID,A.ACCOUNT_ID as ACCOUNT_ID,IN_MONEY,OUT_MONEY '+
        ' from VIW_IORODATA A,CA_SHOP_INFO B '+
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+strWhere+')jb '+
        ' left outer join VIW_ACCOUNT_INFO C on jb.TENANT_ID=C.TENANT_ID and jb.SHOP_ID=C.SHOP_ID and jb.ACCOUNT_ID=C.ACCOUNT_ID '+   
        ' group by C.ACCT_NAME,jb.ACCOUNT_ID ';
    end;
  end;
  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmIORODayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,CLIENT_Tab: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //过滤日期
  strWhere:=strWhere+' '+GetDateCnd(P4_D1,P4_D2,'A.IORO_DATE');
  //门店群主及时门店名称条件
  strWhere:=strWhere+' '+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'');

  //往来客户:
  if trim(fndP4_CLIENT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+trim(fndP4_CLIENT_ID.AsString)+''' ';

  //帐户名称:
  if trim(self.fndP4_ACCOUNT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.ACCOUNT_ID='''+trim(fndP4_ACCOUNT_ID.AsString)+''' ';

  //收支科目:
  if trim(self.fndP4_ITEM_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.ITEM_ID='''+trim(fndP4_ITEM_ID.AsString)+''' ';

  //收支方式:
  if trim(fndP4_PAYM_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.PAYM_ID='''+trim(fndP4_PAYM_ID.AsString)+''' ';

  //经手人:
  if trim(fndP4_USER_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.IROR_USER='''+trim(fndP4_USER_ID.AsString)+''' ';

  //供应商+客户+企业资料
  case Factor.iDbType of
   0,1,5:
      CLIENT_Tab:='select TENANT_ID,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   4: CLIENT_Tab:='select TENANT_ID,trim(char(TENANT_ID))as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
  end;
  CLIENT_Tab:=
     ' select TENANT_ID,CLIENT_ID,CLIENT_NAME from PUB_CLIENTINFO '+  //供应商表
     ' union all select TENANT_ID,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME from PUB_CUSTOMER '+  //客户表
     ' union all '+CLIENT_Tab+' ';  //企业表

  //关联门店
  strSql:=
    'select A.*,B.SHOP_NAME as SHOP_NAME from VIW_IORODATA A,CA_SHOP_INFO B  '+
    'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+strWhere;

  //关联往来客户[CLIENT_ID]
  strSql:=
    'select jc.*,c.CLIENT_NAME as CLIENT_ID_TEXT from ('+strSql+')jc '+
    ' left outer join ('+CLIENT_Tab+') c on jc.TENANT_ID=c.TENANT_ID and jc.CLIENT_ID=C.CLIENT_ID ';

  //关联收支科目
  strSql:=
    'select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+strSql+')jd '+
    ' left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID ';

  //关联账户名称[ACCOUNT_ID]
  strSql:=
    'select je.*,e.ACCT_NAME as ACCOUNT_ID_TEXT from ('+strSql+')je '+
    ' left outer join ACC_ACCOUNT_INFO e on je.TENANT_ID=e.TENANT_ID and je.ACCOUNT_ID=e.ACCOUNT_ID ';

  //关联支付方式[PAYM_ID]
  strSql:=
    'select jf.*,f.CODE_NAME as PAYM_ID_TEXT from ('+strSql+')jf '+
    ' left outer join VIW_PAYMENT f on jf.TENANT_ID=f.TENANT_ID and jf.PAYM_ID=f.CODE_ID ';

  //关联相关人员[IORO_USER、CHK_USER、CREA_USER]
  strSql:=
    'select jg.*'+
    ',g.USER_NAME as IORO_USER_TEXT '+
    ',h.USER_NAME as CHK_USER_TEXT '+
    ',i.USER_NAME as CREA_USER_TEXT '+
    ' from ('+strSql+')jg '+
    ' left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.IORO_USER=g.USER_ID '+
    ' left outer join VIW_USERS h on jg.TENANT_ID=h.TENANT_ID and jg.CHK_USER=h.USER_ID '+
    ' left outer join VIW_USERS i on jg.TENANT_ID=i.TENANT_ID and jg.CREA_USER=i.USER_ID ';

  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmIORODayReport.DBGridEh1DblClick(Sender: TObject);
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

procedure TfrmIORODayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',2,3); //门店群组
  fndP3_SHOP_ID.KeyValue:=trim(adoReport2.fieldbyName('SHOP_ID').AsString);
  fndP3_SHOP_ID.Text:=trim(adoReport2.fieldbyName('SHOP_NAME').AsString);
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmIORODayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P4_D1.Date:=P3_D1.Date;
  P4_D2.Date:=P3_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4); //门店群组
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID); //门店群组

  case fndP3_SortType.ItemIndex of
   0:
    begin
      fndP4_ITEM_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_ITEM_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
    end;
   1:
    begin
      fndP4_ACCOUNT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_ACCOUNT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
    end;
  end;
  
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmIORODayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmIORODayReport.InitGrid;
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

procedure TfrmIORODayReport.PrintBefore;
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

function TfrmIORODayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('收款日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


function TfrmIORODayReport.GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string;
begin
  result:='';
  if ShopID.AsString<>'' then
    result:=' and '+FieldName+'='''+ShopID.AsString+''' ';
end;

function TfrmIORODayReport.GetDateCnd(BegDate, EndDate: TcxDateEdit; FieldName: string): string;
begin
  result:='';
  if BegDate.Date=EndDate.Date then
    result:=' and ('+FieldName+'='+FormatDatetime('YYYYMMDD',BegDate.Date)+')'
  else
    result:=' and ('+FieldName+'>='+FormatDatetime('YYYYMMDD',BegDate.Date)+' and '+FieldName+'<='+FormatDatetime('YYYYMMDD',EndDate.Date)+')';
end;



function TfrmIORODayReport.GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string;
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

procedure TfrmIORODayReport.CheckCalc(EndDate: integer);
var
  rs:TZQuery;
begin
  if IsOnDblClick then
  begin
    IsOnDblClick:=False; //重置标记位
    Exit; //若是双点击[DBGridEh连带查询则不在试算台帐]
  end;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := EndDate;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
      TfrmCostCalc.TryCalcDayAcct(self);
  finally
    rs.Free;
  end;
end;

procedure TfrmIORODayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmIORODayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmIORODayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔';   
end;

procedure TfrmIORODayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'IORO_DATE' then Text := '合计:'+Text+'笔';   
end;

{ 收支科目 | 账户名称 }
procedure TfrmIORODayReport.fndP3_SortTypePropertiesChange(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  case fndP3_SortType.ItemIndex of
   0:
    begin
      LblSortName.Caption:=fndP3_SortType.Properties.Items.Strings[1];
      fndP3_SORT_NAME.KeyField:='ACCOUNT_ID';
      fndP3_SORT_NAME.ListField:='ACCT_NAME';
      fndP3_SORT_NAME.FilterFields:='ACCOUNT_ID;ACCT_NAME;ACCT_SPELL';
      //分页Title
      TabSheet3.Caption:='科目收支汇总表';
    end;
   1:
    begin
      LblSortName.Caption:=fndP3_SortType.Properties.Items.Strings[0];
      fndP3_SORT_NAME.KeyField:='CODE_ID';
      fndP3_SORT_NAME.ListField:='CODE_NAME';
      fndP3_SORT_NAME.FilterFields:='CODE_NAME;CODE_ID;CODE_SPELL';
      //分页Title
      TabSheet3.Caption:='账户收支汇总表';
    end;
  end;
  fndP3_SORT_NAME.Columns[0].FieldName:=fndP3_SORT_NAME.ListField;
  if fndP3_SORT_NAME.Columns.Count>1 then
    fndP3_SORT_NAME.Columns[1].FieldName:=fndP3_SORT_NAME.KeyField;
  case fndP3_SortType.ItemIndex of
   0: fndP3_SORT_NAME.DataSet:=Global.GeTZQueryFromName('ACC_ACCOUNT_INFO');
   1: fndP3_SORT_NAME.DataSet:=Global.GeTZQueryFromName('ACC_ITEM_INFO');
  end;
  SetCol:=FindColumn(DBGridEh3, 'SORT_NAME');
  if SetCol<>nil then
  begin
    SetCol.Title.Caption:=trim(fndP3_SortType.Text);
  end;
end;

procedure TfrmIORODayReport.SetFndP4_ClientID_DataSet;
var
  Sql: string;
begin
  //供应商+客户+企业资料
  case Factor.iDbType of
   0,1,5:
      Sql:=' select TENANT_ID,LOGIN_NAME as CLIENT_CODE,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME,LICENSE_CODE,TENANT_SPELL as CLIENT_SPELL,TELEPHONE from CA_TENANT ';
   4: Sql:=' select TENANT_ID,LOGIN_NAME as CLIENT_CODE,ltrim(rtrim(char(TENANT_ID))) as CLIENT_ID,TENANT_NAME as CLIENT_NAME,LICENSE_CODE,TENANT_SPELL as CLIENT_SPELL,TELEPHONE from CA_TENANT ';
  end;
  Sql:=
    ' select TENANT_ID,CLIENT_CODE,CLIENT_ID,CLIENT_NAME,LICENSE_CODE,CLIENT_SPELL,TELEPHONE2 as TELEPHONE from PUB_CLIENTINFO '+  //供应商表
    ' union all select TENANT_ID,CUST_CODE as CLIENT_CODE,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME,''  '' as LICENSE_CODE,CUST_SPELL as CLIENT_SPELL,MOVE_TELE as TELEPHONE from PUB_CUSTOMER '+  //客户表
    ' union all '+Sql+' ';  //企业表
  //打开数据集
  PUB_CLient.Close;
  PUB_CLient.SQL.Text:=Sql;
  Factor.Open(PUB_CLient);
end;

end.

