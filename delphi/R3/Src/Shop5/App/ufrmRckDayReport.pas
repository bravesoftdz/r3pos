unit ufrmRckDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants,  Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox, RzChkLst,
  RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh, cxCalendar, cxButtonEdit,
  cxCheckBox, zbase, zrComboBoxList, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cxRadioGroup;

type
  TfrmRckDayReport = class(TframeBaseReport)
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
    Panel7: TPanel;
    RzPanel17: TRzPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label37: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    P5_D1: TcxDateEdit;
    BtnDetail: TRzBitBtn;
    P5_D2: TcxDateEdit;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    fndP5_SHOP_ID: TzrComboBoxList;
    RzGB: TRzGroupBox;
    fndP5_ALL: TcxRadioButton;
    fndP5_SALEORDER: TcxRadioButton;
    fndP5_POSMAIN: TcxRadioButton;
    fndP5_SALRETU: TcxRadioButton;
    fndP5_DEPT_ID: TzrComboBoxList;
    fndP5_CREA_USER: TzrComboBoxList;
    fndP5_SALES_TYPE: TcxComboBox;
    RzPanel18: TRzPanel;
    DBGridEh5: TDBGridEh;
    adoReport5: TZQuery;
    dsadoReport5: TDataSource;
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
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh4DblClick(Sender: TObject);
  private
    IsOnDblClick: Boolean;  //是双击DBGridEh标记位
    SortName: string; //临时变量
    sid5:string;
    srid5:string;
    procedure SetUnitIDList(DBGrid: TDBGridEh; ColName: string);
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
    function GetGlideSQL(chk:boolean=true): string;

    //输入查询条件最大值日期，返回台帐表的最大结帐日期
    function GetRckMaxDate(EndDate: integer): Integer;
    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //返回门店查询条件
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //时间条件
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string; //门店所属行政区域|门店类型:
    //初始化DBGrid
    procedure InitGrid;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    function GetDataRight: string; //返回查看数据权限  
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  DataRight: string read GetDataRight; //返回查看数据权限
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon,
  ufrmCostCalc, uframeToolForm, Math;
{$R *.dfm}

procedure TfrmRckDayReport.FormCreate(Sender: TObject);
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

  SetRzPageActivePage; //设置PzPage.Activepage
  fndP5_CREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');

  //增加单位显示：
  SetUnitIDList(DBGridEh5,'UNIT_ID');

  InitGrid;
  RefreshColumn;

  {2011.08.25 加了DataRight后关闭
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
  end;}

  //Add 设置查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh5, ['COST_MONEY','PROFIT_MONEY','PROFIT_RATE','AVG_PROFIT']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label3.Caption := '仓库名称';

      Label28.Caption := '仓库群组';
      Label17.Caption := '仓库名称';
    end;

  //2011.09.22 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.RECV_MNY','DBGridEh1.PAY_A','DBGridEh1.PAY_B','DBGridEh1.PAY_C','DBGridEh1.PAY_D','DBGridEh1.PAY_E','DBGridEh1.PAY_F','DBGridEh1.PAY_G','DBGridEh1.PAY_J','DBGridEh1.TRN_MNY','DBGridEh1.TRN_REST_MNY',
                              'DBGridEh2.RECV_MNY','DBGridEh2.PAY_A','DBGridEh2.PAY_B','DBGridEh2.PAY_C','DBGridEh2.PAY_D','DBGridEh2.PAY_E','DBGridEh2.PAY_F','DBGridEh2.PAY_G','DBGridEh2.PAY_J','DBGridEh2.TRN_MNY','DBGridEh2.TRN_REST_MNY',
                              'DBGridEh3.RECV_MNY','DBGridEh3.PAY_A','DBGridEh3.PAY_B','DBGridEh3.PAY_C','DBGridEh3.PAY_D','DBGridEh3.PAY_E','DBGridEh3.PAY_F','DBGridEh3.PAY_G','DBGridEh3.PAY_J','DBGridEh3.TRN_MNY','DBGridEh3.TRN_REST_MNY',
                              'DBGridEh4.RECV_MNY','DBGridEh4.PAY_A','DBGridEh4.PAY_B','DBGridEh4.PAY_C','DBGridEh4.PAY_D','DBGridEh4.PAY_E','DBGridEh4.PAY_F','DBGridEh4.PAY_G','DBGridEh4.PAY_J','DBGridEh4.BALANCE',
                              'DBGridEh5.AMONEY','DBGridEh5.NOTAX_MONEY','DBGridEh5.TAX_MONEY','DBGridEh5.AGIO_RATE','DBGridEh5.AGIO_MONEY','DBGridEh5.COST_MONEY','DBGridEh5.PROFIT_MONEY','DBGridEh5.AVG_PROFIT']);
end;

function TfrmRckDayReport.GetGroupSQL(chk:boolean=true): string;
var
  EndDate,MaxDate: integer;
  strSql,ViwSql,RCKRData,strWhere: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));
  //测试计算日台账:
  CheckCalc(EndDate);
  //试算之后运行取台帐表中最大值
  MaxDate:=GetRckMaxDate(EndDate);
  //按根据条件门店汇总:
  ViwSql:=
     'select A.TENANT_ID,B.REGION_ID as REGION_ID,A.SHOP_ID as SHOP_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,'+
     'sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P1_D1,P1_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,B.REGION_ID,A.SHOP_ID ';

  //台账表
  RCKRData:=
    'select TENANT_ID,SHOP_ID,isnull(TRN_OUT_MNY,0)-isnull(TRN_IN_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS '+
    ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' '+' '+ShopGlobal.GetDataRight('SHOP_ID',1);

  //关联
  strSql:=
    'select j.REGION_ID as REGION_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY,sum(TRN_MNY) as TRN_MNY, sum(BAL_MNY) as TRN_REST_MNY from '+
    '('+ViwSql+') j '+
    ' left outer join ('+RCKRData+')c on j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID group by j.REGION_ID ';
    
  strSql:=
    'select jp.*,isnull(r.CODE_NAME,''无'') as CODE_NAME from  ('+strSql+') jp '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on jp.REGION_ID=r.CODE_ID order by jp.REGION_ID ';

  Result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmRckDayReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmRckDayReport.actFindExecute(Sender: TObject);
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
    4: begin
        if adoReport5.Active then adoReport5.Close;
        //if Sender<>nil then self.GodsID:='';
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmRckDayReport.GetShopSQL(chk:boolean=true): string;
var
  EndDate,MaxDate: integer;
  strSql,ViwSql,RCKRData,strWhere: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));
  //测试计算日台账:
  CheckCalc(EndDate);
  //试算之后运行取台帐表中最大值
  MaxDate:=GetRckMaxDate(EndDate);
  //按根据条件门店汇总:
  ViwSql:=
     'select A.TENANT_ID,A.SHOP_ID as SHOP_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,'+
     ' sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J, sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P2_D1,P2_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.SHOP_ID ';

  //台账表
  RCKRData:=
    'select TENANT_ID,SHOP_ID,isnull(TRN_OUT_MNY,0)-isnull(TRN_IN_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS '+
    ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' '+' '+ShopGlobal.GetDataRight('SHOP_ID',1);
  //关联
  strSql:=
    'select j.*,TRN_MNY,BAL_MNY as TRN_REST_MNY from ('+ViwSql+') j left outer join ('+RCKRData+')c '+
    ' on j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID ';

  //关联门店
  strSql:=
    'select jp.*,r.SEQ_NO as SHOP_CODE,r.SHOP_NAME as SHOP_NAME '+
    ' from ('+strSql+')jp left outer join CA_SHOP_INFO r '+
    ' on jp.TENANT_ID=r.TENANT_ID and jp.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result := ParseSQL(Factor.iDbType, strSql);    
end;

function TfrmRckDayReport.GetSortSQL(chk:boolean=true): string;
var
  EndDate,MaxDate: integer;
  strSql,ViwSql,RCKRData,strWhere: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));

  //测试计算日台账:
  CheckCalc(EndDate);
  //按根据条件门店查询:
  ViwSql:=
     'select A.RECV_DATE as RECV_DATE,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P3_D1,P3_D2,'RECV_DATE')+
     ' '+GetShopIDCnd(fndP3_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'')+' '+
     ' group by A.RECV_DATE ';

  //台账表
  RCKRData:=
    'select CREA_DATE,isnull(sum(TRN_OUT_MNY),0)-isnull(sum(TRN_IN_MNY),0) as TRN_MNY,sum(BAL_MNY) as BAL_MNY '+
    ' from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('SHOP_ID',1)+
    ' '+GetDateCnd(P3_D1,P3_D2,'CREA_DATE')+' and SHOP_ID<>''#'' group by CREA_DATE ';

  //关联
  strSql:=
    'select j.*,TRN_MNY,BAL_MNY as TRN_REST_MNY '+
    ' from ('+ViwSql+')j '+
    ' left outer join ('+RCKRData+')c '+
    ' on j.RECV_DATE=c.CREA_DATE order by j.RECV_DATE ';
    
  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmRckDayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,ViwSql,RMNYData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //按根据条件门店查询:
  ViwSql:=
     'select a.TENANT_ID as TENANT_ID,A.CREA_USER as CREA_USER,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P4_D1,P4_D2,'RECV_DATE')+
     ' '+GetShopIDCnd(fndP4_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'')+
     ' group by A.TENANT_ID,A.CREA_USER ';

  //收银员最后一天的零钱
  RMNYData:=
    'select AA.TENANT_ID,AA.CREA_USER as CREA_USER,max(isnull(BALANCE,0)) as BALANCE from ACC_CLOSE_FORDAY AA, '+
    ' (select max(CLSE_DATE) as CLSE_DATE,TENANT_ID,CREA_USER from ACC_CLOSE_FORDAY where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+' group by TENANT_ID,CREA_USER) BB '+
    ' where AA.TENANT_ID=BB.TENANT_ID and AA.CREA_USER=BB.CREA_USER and AA.CLSE_DATE=BB.CLSE_DATE and '+
    ' AA.TENANT_ID='+inttostr(Global.TENANT_ID)+' and AA.CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+
    ' '+ShopGlobal.GetDataRight('AA.SHOP_ID',1)+
    ' group by AA.TENANT_ID,AA.CREA_USER';
  //关联
  strSql:=
    'select jc.*,u.ACCOUNT as ACCOUNT,u.USER_NAME as USER_NAME from'+
    ' (select j.*,BALANCE from ('+ViwSql+')j '+
    '  left outer join ('+RMNYData+') c on j.TENANT_ID=c.TENANT_ID and j.CREA_USER=c.CREA_USER)jc '+
    ' left outer join VIW_Users u on jc.TENANT_ID=u.TENANT_ID and jc.CREA_USER=u.USER_ID '+
    ' order by jc.CREA_USER '; 
  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmRckDayReport.DBGridEh1DblClick(Sender: TObject);
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

procedure TfrmRckDayReport.DBGridEh2DblClick(Sender: TObject);
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

procedure TfrmRckDayReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P4_D1.Date:=FnTime.fnStrtoDate(adoReport3.fieldbyName('RECV_DATE').AsString); 
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

procedure TfrmRckDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmRckDayReport.InitGrid;
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

procedure TfrmRckDayReport.PrintBefore;
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
     4: AddReportReport(Title,'5');
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmRckDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
 case RzPage.ActivePageIndex of
   0,1,2,3:
    begin
      //日期
      FindCmp1:=FindComponent('P'+PageNo+'_D1');
      FindCmp2:=FindComponent('P'+PageNo+'_D2');
      if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
         (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
        TitleList.add('收款日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
    end;
   4:
    begin
      //日期
      FindCmp1:=FindComponent('P'+PageNo+'_D1');
      FindCmp2:=FindComponent('P'+PageNo+'_D2');
      if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
         (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
        TitleList.add('销售日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
      if trim(fndP5_CREA_USER.Text)<>'' then
        TitleList.add('收银员：'+trim(fndP5_CREA_USER.Text));
      {if fndP5_POSMAIN.Checked then
        TitleList.add('单据类型：'+trim(fndP5_POSMAIN.Caption))
      else if fndP5_SALEORDER.Checked then
        TitleList.add('单据类型：'+trim(fndP5_SALEORDER.Caption))
      else if fndP5_SALRETU.Checked then
        TitleList.add('单据类型：'+trim(fndP5_SALRETU.Caption));}
    end;
  end;
  inherited AddReportReport(TitleList,PageNo);
end;


function TfrmRckDayReport.GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string;
begin
  result:='';
  if ShopID.AsString<>'' then
    result:=' and '+FieldName+'='''+ShopID.AsString+''' ';
end;

function TfrmRckDayReport.GetDateCnd(BegDate, EndDate: TcxDateEdit; FieldName: string): string;
begin
  result:='';
  if BegDate.Date=EndDate.Date then
    result:=' and ('+FieldName+'='+FormatDatetime('YYYYMMDD',BegDate.Date)+')'
  else
    result:=' and ('+FieldName+'>='+FormatDatetime('YYYYMMDD',BegDate.Date)+' and '+FieldName+'<='+FormatDatetime('YYYYMMDD',EndDate.Date)+')';
end;



function TfrmRckDayReport.GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string;
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


function TfrmRckDayReport.GetRckMaxDate(EndDate: integer): integer;
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

procedure TfrmRckDayReport.CheckCalc(EndDate: integer);
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

procedure TfrmRckDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmRckDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmRckDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'RECV_DATE' then Text := '合计:'+Text+'笔';   
end;

procedure TfrmRckDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'USER_NAME' then Text := '合计:'+Text+'笔';   
end;

function TfrmRckDayReport.GetGlideSQL(chk: boolean): string;
var
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('销售日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('销售日期条件不能为空');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //销售类型:
  if fndP5_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP5_SALES_TYPE.Properties.Items.Objects[fndP5_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //门店条件:
  if fndP5_SHOP_ID.AsString<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

  //GodsID不为空：
  //if trim(GodsID)<>'' then
  //  strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  //月份日期:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' '
  else
    Raise Exception.Create('结束日期不能小于开始日期...');

  //门店所属行政区域|门店类型:
  if (fndP5_SHOP_VALUE.AsString<>'') then
    begin
      case fndP5_SHOP_TYPE.ItemIndex of
        0:
         begin
           if FnString.TrimRight(trim(fndP5_SHOP_VALUE.AsString),2)='00' then //非末级区域
             strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP5_SHOP_VALUE.AsString)+'%'' '
           else
             strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
         end;
        1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
      end;
    end;

  //商品指标:
  if (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP5_TYPE_ID)+'='''+fndP5_STAT_ID.AsString+''' ';
  end;
  //商品分类:
  if (trim(fndP5_SORT_ID.Text)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add 部门名称:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP5_DEPT_ID.AsString+''' ';

  //收银员
  if Trim(fndP5_CREA_USER.Text) <> '' then
    strWhere := strWhere + ' and A.CREA_USER='''+fndP5_CREA_USER.AsString+''' ';

  if fndP5_SALEORDER.Checked then //销售单:1
    strWhere := strWhere+' and SALES_TYPE=1 '
  else if fndP5_POSMAIN.Checked then //零售单:4
    strWhere := strWhere+' and SALES_TYPE=4 '
  else if fndP5_SALRETU.Checked then //销售退货:3
    strWhere := strWhere+' and SALES_TYPE=3 ';

  SQLData := 'VIW_SALESDATA';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.SALES_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.CLIENT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+
    ',A.GUIDE_USER '+
    ',A.SALES_TYPE '+
    ',A.AMOUNT '+
    ',A.ORG_PRICE as APRICE '+   //销售时间成本价
    ',A.CALC_MONEY as AMONEY '+ 
    ',A.NOTAX_MONEY '+  //不含税
    ',A.TAX_MONEY '+    //税项
    ',A.AGIO_MONEY '+   //折扣金额
    ',A.AGIO_RATE '+    //折扣率（让利率）
    ',A.COST_MONEY '+   //销售成本
    ',A.NOTAX_MONEY-A.COST_MONEY as PROFIT_MONEY'+  //毛利 = 不含税金额-销售成本
    ',(case when A.NOTAX_MONEY<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/cast(A.NOTAX_MONEY as decimal(18,3)) else 0 end) as PROFIT_RATE '+  //不含税金额-销售成本
    ',(case when A.NOTAX_MONEY*A.AMOUNT<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/A.AMOUNT else 0 end) as AVG_PROFIT'+    //--单位毛利
    ',B.SHOP_NAME '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';

  Result := ParseSQL(Factor.iDbType,
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',c.CLIENT_NAME as CLIENT_NAME '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    ' inner join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_CUSTOMER c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    ' left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '
    );
  result := result +  ' order by j.SALES_DATE,r.GODS_CODE';
end;

procedure TfrmRckDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmRckDayReport.fndP5_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 := '';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmRckDayReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmRckDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  P5_D1.Date := P4_D1.Date;
  P5_D2.Date := P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5); //管理群组
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID);  //门店名称
  fndP5_CREA_USER.KeyValue := adoReport4.FieldByName('CREA_USER').AsString;
  fndP5_CREA_USER.Text := adoReport4.FieldByName('USER_NAME').AsString;
  RzPage.ActivePageIndex := 4;
  actFindExecute(nil);
end;

procedure TfrmRckDayReport.SetUnitIDList(DBGrid: TDBGridEh;
  ColName: string);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(DBGrid,ColName); 
  if (Rs<>nil) and (Rs.Active) and (SetCol<>nil) then
  begin
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(Rs.fieldByName('UNIT_ID').AsString);
      SetCol.PickList.Add(Rs.fieldByName('UNIT_NAME').AsString);
      Rs.Next;
    end;
  end;
end;

function TfrmRckDayReport.GetDataRight: string;
begin
  //VIW_RCKDATA  A 
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

