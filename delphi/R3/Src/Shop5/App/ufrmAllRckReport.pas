unit ufrmAllRckReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar, zrMonthEdit, ufrmDateControl,uframeOrderForm, FR_Class;

type
  TfrmAllRckReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    LblUnit: TLabel;
    fndP1_UNIT_ID: TcxComboBox;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    actTemplate: TAction;
    btnDelete: TRzBitBtn;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    P1_DateControl: TfrmDateControl;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure rptTemplatePropertiesChange(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure rzShowColumnsChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure actColumnVisibleExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    PrintTimes:Integer;
    idx: integer;
    FrptIndex: integer;  //��������
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    function  GetMaxDate(E:integer):string;
    function  GetrptType: integer;
    procedure CheckCalc(b, e:integer); //��ʼ�·�| �����·�
    //����ϸ����
    procedure OpenDetailForm(id:string; cid:string='');
    function  GetCurOrder: TframeOrderForm;
    function  GetFormClass: TFormClass;
    procedure Clear;
    procedure InitColumnEhPickList(Column: TColumnEh);
    function  GetBillType: integer;
    procedure LoadFormat; override;
    procedure SaveFormat; override;
    procedure RefreshColumn; override;
  public
    Factory: TReportFactory;
    Lock:boolean;
    //����Ʒ���ۻ��ܱ�
    function  GetGodsSQL(chk:boolean=true): string;   //5555
    function  GetSQL: string;
    procedure CreateGridColumn; //����������
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
    property  rptType: integer read GetrptType;
    property  BillType: integer Read GetBillType;
    property CurOrder:TframeOrderForm read GetCurOrder;    
  end;


implementation

uses
  ufrmDefineReport,ufnUtil,uShopUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar, ufrmCostCalc,ufrmStockOrder,ufrmSalesOrder,
  ufrmFastReport,uMsgBox;

{$R *.dfm}

procedure TfrmAllRckReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE4,'3','4') then
     begin
       load;
     end;
end;

procedure TfrmAllRckReport.load;
var
  rs:TZQuery;
  list:TStringList;
  w:string;
  i:integer;
begin
  rs := TZQuery.Create(nil);
  list := TStringList.Create;
  lock := true;
  try
    w := '';
    if not ((Global.UserID = 'admin') or (Global.UserID = 'system') or (Global.Roles = 'xsm')) then
    begin
    list.CommaText := Global.Roles;
    for i:=0 to list.Count - 1 do
      begin
        if w<>'' then w := w + ' or ';
        w:=w+''','''+GetStrJoin(Factor.iDbType)+' ROLES '+GetStrJoin(Factor.iDbType)+''','' like ''%,'+list[i]+',%'' ';
      end;
    if w <> '' then w := ' and ('+w+')';
    end;
    rs.Close;
    rs.SQL.Text := 'select REPORT_ID,''ȫ����Ʒ̨��'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''������Ʒ̨��'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''�Ǿ�����Ʒ̨��'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''����̨��'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' '
                 + 'union all select REPORT_ID,''����̨��'' as REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''4'' and REPORT_ID=''5EC475CD-4B87-439E-87ED-1F4E3E2470D9'' '+w+ ' ';
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmAllRckReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmAllRckReport.FormCreate(Sender: TObject);
begin
  FrptIndex:=-1;
  //Ĭ�ϴ�����
  CreateGridColumn;
  inherited;
  idx:=0;
  TDbGridEhSort.InitForm(self,false);
  P1_D1.date := date; //Ĭ�ϵ���
  P1_D2.date := date; //Ĭ�ϵ���
  P1_DateControl.StartDateControl := P1_D1;
  P1_DateControl.EndDateControl := P1_D2;

  Factory := nil;
  // load;
  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  //btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  //btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  //btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  if rptTemplate.Properties.Items.Count>0 then
    rptTemplate.ItemIndex:=0;
end;

procedure TfrmAllRckReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  if Factory<>nil then Factory.Free;
  Clear; //�����ҳ
  inherited;
end;

procedure TfrmAllRckReport.actFindExecute(Sender: TObject);
var
  strSql:string;
begin
  if rptTempLate.ItemIndex<0 then Exit;
  if adoReport1.Active then
  begin
    //ɾ��ǰ�ȱ����ϴ�
    self.SaveFormat;
    adoReport1.Close;
  end;
  adoReport1.SortedFields:='';
  if P1_D1.EditValue = null then Raise Exception.Create('  ��ʼ������������Ϊ�գ� ');
  if P1_D2.EditValue = null then Raise Exception.Create('  ����������������Ϊ�գ� ');
  if P1_D1.Date>P1_D2.Date then  Raise Exception.Create('  �������ڲ���С�ڿ�ʼ����...');
  if rptTemplate.ItemIndex=-1 then Raise Exception.Create('     ��ѡ��̨�˷��࣡    ');
  CreateGridColumn; //������
  strSql := self.GetSQL;
  if strSql='' then Exit;
  adoReport1.SQL.Text := strSql;
  Factor.Open(adoReport1);
  if rptType<3 then
  begin
    dsadoReport1.DataSet:=nil;
    DoGodsGroupBySort(adoReport1,'2','SORT_ID','GODS_ID_TEXT','ORDER_ID',
                      ['ORG_AMT','STOCK_AMT','STOCK_TTL','SALE_AMT','SALE_TTL','SALE_PRF','SALE_RATE','BAL_AMT'],
                      ['SALE_RATE=SALE_PRF/SALE_MNY*100.0']);
    dsadoReport1.DataSet:=adoReport1;
  end;
  {if Factory<>nil then Factory.Free;
  Factory := TReportFactory.Create('4');
  try
    if Factory.DataSet.Active then Factory.DataSet.Close;
    strSql := GetGodsSQL;
    if strSql='' then Exit;
    TZQuery(Factory.DataSet).SQL.Text:= strSql;
    {frmPrgBar.Show;
    frmPrgBar.Update;
    frmPrgBar.WaitHint := '׼������Դ...';
    frmPrgBar.Precent := 0;
    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;}
end;

procedure TfrmAllRckReport.btnEditClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.EditReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

function TfrmAllRckReport.GetGodsSQL(chk: boolean): string;
var
  mx, UnitCalc: string;  //��λ�����ϵ
  strSql,strWhere,strWhere_y,strWhere_m,GoodTab: widestring;
  Day:integer;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D1.Date>P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);

  Day := round(P1_D2.Date - P1_D1.Date) + 1;

  //������λ����:
  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  //����Ƿ����
  CheckCalc(strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date)),strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
  
  mx := GetMaxDate(StrtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));

  //����:
  if (P1_D1.EditValue<>null) and (FormatDatetime('YYYYMMDD',P1_D1.Date)=FormatDatetime('YYYYMMDD',P1_D2.Date)) then
    strWhere:=strWhere+' and A.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
  else if P1_D1.Date<P1_D2.Date then
    strWhere:=strWhere+' and A.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+' ';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_AMT*1.00/'+UnitCalc+' else 0 end) as ORG_AMT '+ //�ڳ�����
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_MNY else 0 end) as ORG_MNY '+   //������<����ʱ����>
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_RTL else 0 end) as ORG_RTL '+   //�����۶�<�����ۼ�>
    ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_CST else 0 end) as ORG_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>

    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as STOCK_AMT '+   //��������
    ',sum(STOCK_MNY) as STOCK_MNY '+   //�������<ĩ˰>
    ',sum(STOCK_TAX) as STOCK_TAX '+   //����˰��
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+  //�������


    ',0 as YEAR_STOCK_AMT '+   //��������
    ',0 as YEAR_STOCK_MNY '+   //�������<ĩ˰>
    ',0 as YEAR_STOCK_TAX '+   //����˰��
    ',0 as YEAR_STOCK_TTL '+   //�������


    ',0 as PRIOR_STOCK_AMT '+   //��������
    ',0 as PRIOR_STOCK_MNY '+   //�������<ĩ˰>
    ',0 as PRIOR_STOCK_TAX '+   //����˰��
    ',0 as PRIOR_STOCK_TTL '+  //�������

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as SALE_AMT '+   //��������
    ',sum(SALE_MNY) as SALE_MNY '+   //���۽��<ĩ˰>
    ',sum(SALE_TAX) as SALE_TAX '+   //����˰��
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+  //���۽��
    ',sum(SALE_CST) as SALE_CST '+   //���۳ɱ�
    ',sum(SALE_PRF) as SALE_PRF '+   //����ë��

    ',0 as PRIOR_YEAR_AMT '+   //ȥ��ͬ����������
    ',0 as PRIOR_YEAR_MNY '+   //ȥ��ͬ�����۽��<ĩ˰>
    ',0 as PRIOR_YEAR_TAX '+   //ȥ��ͬ������˰��
    ',0 as PRIOR_YEAR_TTL '+   //ȥ��ͬ�����۽��
    ',0 as PRIOR_YEAR_CST '+   //ȥ��ͬ�����۳ɱ�
    ',0 as PRIOR_YEAR_PRF '+   //ȥ��ͬ������ë��

    ',0 as PRIOR_MONTH_AMT '+   //������������
    ',0 as PRIOR_MONTH_MNY '+   //�������۽��<ĩ˰>
    ',0 as PRIOR_MONTH_TAX '+   //��������˰��
    ',0 as PRIOR_MONTH_TTL '+   //�������۽��
    ',0 as PRIOR_MONTH_CST '+   //�������۳ɱ�
    ',0 as PRIOR_MONTH_PRF '+   //��������ë��

    ',sum(case when A.CREA_DATE='+mx+' then BAL_AMT*1.00/'+UnitCalc+' else 0 end) as BAL_AMT '+ //�������
    ',sum(case when A.CREA_DATE='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+   //������<����ʱ����>
    ',sum(case when A.CREA_DATE='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+   //�����۶�<�����ۼ�>
    ',sum(case when A.CREA_DATE='+mx+' then BAL_CST else 0 end) as BAL_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>
    ','+inttostr(Day)+' as DAYS_AMT '+  //��������
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql := strSql + ' union all '+
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+

    ',0 as ORG_AMT '+ //�ڳ�����
    ',0 as ORG_MNY '+   //������<����ʱ����>
    ',0 as ORG_RTL '+   //�����۶�<�����ۼ�>
    ',0 as ORG_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>

    ',0 as STOCK_AMT '+   //��������
    ',0 as STOCK_MNY '+   //�������<ĩ˰>
    ',0 as STOCK_TAX '+   //����˰��
    ',0 as STOCK_TTL '+  //�������


    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as YEAR_STOCK_AMT '+   //��������
    ',sum(STOCK_MNY) as YEAR_STOCK_MNY '+   //�������<ĩ˰>
    ',sum(STOCK_TAX) as YEAR_STOCK_TAX '+   //����˰��
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as YEAR_STOCK_TTL '+  //�������


    ',0 as PRIOR_STOCK_AMT '+   //��������
    ',0 as PRIOR_STOCK_MNY '+   //�������<ĩ˰>
    ',0 as PRIOR_STOCK_TAX '+   //����˰��
    ',0 as PRIOR_STOCK_TTL '+  //�������

    ',0 as SALE_AMT '+   //��������
    ',0 as SALE_MNY '+   //���۽��<ĩ˰>
    ',0 as SALE_TAX '+   //����˰��
    ',0 as SALE_TTL '+  //���۽��
    ',0 as SALE_CST '+   //���۳ɱ�
    ',0 as SALE_PRF '+   //����ë��

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as PRIOR_YEAR_AMT '+   //ȥ��ͬ����������
    ',sum(SALE_MNY) as PRIOR_YEAR_MNY '+   //ȥ��ͬ�����۽��<ĩ˰>
    ',sum(SALE_TAX) as PRIOR_YEAR_TAX '+   //ȥ��ͬ������˰��
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as PRIOR_YEAR_TTL '+  //ȥ��ͬ�����۽��
    ',sum(SALE_CST) as PRIOR_YEAR_CST '+   //ȥ��ͬ�����۳ɱ�
    ',sum(SALE_PRF) as PRIOR_YEAR_PRF '+   //ȥ��ͬ������ë��

    ',0 as PRIOR_MONTH_AMT '+   //������������
    ',0 as PRIOR_MONTH_MNY '+   //�������۽��<ĩ˰>
    ',0 as PRIOR_MONTH_TAX '+   //��������˰��
    ',0 as PRIOR_MONTH_TTL '+  //�������۽��
    ',0 as PRIOR_MONTH_CST '+   //�������۳ɱ�
    ',0 as PRIOR_MONTH_PRF '+   //��������ë��

    ',0 as BAL_AMT '+ //�������
    ',0 as BAL_MNY '+   //������<����ʱ����>
    ',0 as BAL_RTL '+   //�����۶�<�����ۼ�>
    ',0 as BAL_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>
    ','+inttostr(Day)+' as DAYS_AMT '+  //��������
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere_y + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql := strSql + ' union all '+
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
    ',C.NEW_INPRICE*'+UnitCalc+' as NEW_INPRICE,C.NEW_OUTPRICE*'+UnitCalc+' as NEW_OUTPRICE '+

    ',0 as ORG_AMT '+ //�ڳ�����
    ',0 as ORG_MNY '+   //������<����ʱ����>
    ',0 as ORG_RTL '+   //�����۶�<�����ۼ�>
    ',0 as ORG_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>

    ',0 as STOCK_AMT '+   //��������
    ',0 as STOCK_MNY '+   //�������<ĩ˰>
    ',0 as STOCK_TAX '+   //����˰��
    ',0 as STOCK_TTL '+  //�������


    ',0 as YEAR_STOCK_AMT '+   //��������
    ',0 as YEAR_STOCK_MNY '+   //�������<ĩ˰>
    ',0 as YEAR_STOCK_TAX '+   //����˰��
    ',0 as YEAR_STOCK_TTL '+  //�������


    ',sum(STOCK_AMT*1.00/'+UnitCalc+') as PRIOR_STOCK_AMT '+   //��������
    ',sum(STOCK_MNY) as PRIOR_STOCK_MNY '+   //�������<ĩ˰>
    ',sum(STOCK_TAX) as PRIOR_STOCK_TAX '+   //����˰��
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as PRIOR_STOCK_TTL '+  //�������

    ',0 as SALE_AMT '+   //��������
    ',0 as SALE_MNY '+   //���۽��<ĩ˰>
    ',0 as SALE_TAX '+   //����˰��
    ',0 as SALE_TTL '+  //���۽��
    ',0 as SALE_CST '+   //���۳ɱ�
    ',0 as SALE_PRF '+   //����ë��

    ',0 as PRIOR_YEAR_AMT '+   //ȥ��ͬ����������
    ',0 as PRIOR_YEAR_MNY '+   //ȥ��ͬ�����۽��<ĩ˰>
    ',0 as PRIOR_YEAR_TAX '+   //ȥ��ͬ������˰��
    ',0 as PRIOR_YEAR_TTL '+  //ȥ��ͬ�����۽��
    ',0 as PRIOR_YEAR_CST '+   //ȥ��ͬ�����۳ɱ�
    ',0 as PRIOR_YEAR_PRF '+   //ȥ��ͬ������ë��

    ',sum(SALE_AMT*1.00/'+UnitCalc+') as PRIOR_MONTH_AMT '+   //������������
    ',sum(SALE_MNY) as PRIOR_MONTH_MNY '+   //�������۽��<ĩ˰>
    ',sum(SALE_TAX) as PRIOR_MONTH_TAX '+   //��������˰��
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as PRIOR_MONTH_TTL '+  //�������۽��
    ',sum(SALE_CST) as PRIOR_MONTH_CST '+   //�������۳ɱ�
    ',sum(SALE_PRF) as PRIOR_MONTH_PRF '+   //��������ë��

    ',0 as BAL_AMT '+ //�������
    ',0 as BAL_MNY '+   //������<����ʱ����>
    ',0 as BAL_RTL '+   //�����۶�<�����ۼ�>
    ',0 as BAL_CST '+   //���ɱ�<�ƶ���Ȩ�ɱ�>
    ','+inttostr(Day)+' as DAYS_AMT '+  //��������
    'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+                 
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere_m + ' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE ';

  strSql :=
    'select j.*,'+
    'r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME as GODS_ID_TEXT,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'r')+' as UNIT_ID,'+
    'r.SORT_ID1,r.RELATION_ID as SORT_ID24,r.SORT_ID1 as SORT_ID21,r.SORT_ID1 as SORT_ID22,r.SORT_ID1 as SORT_ID23,r.SORT_ID2,r.SORT_ID3,r.SORT_ID4,r.SORT_ID5,r.SORT_ID6,r.SORT_ID7,r.SORT_ID8,r.SORT_ID9,r.SORT_ID10,'+
    'r.SORT_ID11,r.SORT_ID12,r.SORT_ID13,r.SORT_ID14,r.SORT_ID15,r.SORT_ID16,r.SORT_ID17,r.SORT_ID18,r.SORT_ID19,r.SORT_ID20 '+
    ' from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  strSql :=
    'select ja.*,isnull(b.BARCODE,ja.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') ja '+
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    'on ja.TENANT_ID=b.TENANT_ID and ja.GODS_ID=b.GODS_ID and ja.BATCH_NO=b.BATCH_NO and ja.PROPERTY_01=b.PROPERTY_01 and ja.PROPERTY_02=b.PROPERTY_02 and ja.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on ja.TENANT_ID=u.TENANT_ID and ja.UNIT_ID=u.UNIT_ID '+
    ' order by ja.GODS_CODE ';

  result:=ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmAllRckReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

procedure TfrmAllRckReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rptTemplate.Text;
  try
    Title:=TStringList.Create;
    AddReportReport(Title,'1');
    ReStr:=FormatReportHead(Title,1);
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmAllRckReport.AddReportReport(TitleList: TStringList;
  PageNo: string): string;
var
  rptTitle: string;
begin
  //����:
  rptTitle:='  ���ڣ�'+P1_D1.Text+' �� '+P1_D2.Text;
  //̨������:
  rptTitle:=rptTitle+'       ̨������:'+rptTemplate.Text;
  //��ʾ��λ:
  if fndP1_UNIT_ID.Visible then
    rptTitle:=rptTitle+'       ��ʾ��λ:'+fndP1_UNIT_ID.Text;
  TitleList.Add(rptTitle);
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmAllRckReport.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
      TfrmCostCalc.TryCalcMthGods(self);
  finally
    rs.Free;
  end;
end;

function TfrmAllRckReport.GetMaxDate(E: integer): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_GOODS_DAYS where TENANT_ID=:TENANT_ID and CREA_DATE<=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
       result := inttostr(e)
    else
       result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmAllRckReport.CreateGridColumn;
var
  vType: integer;
  Column: TColumnEh;
begin
  //�ж��Ƿ���Ҫ���´������
  if FrptIndex<>-1 then
  begin
    FrptIndex:=rptType;
    if (rptType<3) and (FrptIndex<3) then Exit;
    if (rptType>2) and (FrptIndex=rptType) then Exit;
  end;
  //ɾ����ϸ����
  Clear;  
  //����ؼ���
  DBGridEh1.Columns.Clear;
  DBGridEh1.Columns.BeginUpdate;
  try
    case rptType of
     0,1,2: //��������̨��:
      begin
        //��Ʒ����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GODS_ID_TEXT';
        Column.Title.Caption:='��Ʒ����';
        Column.Width :=130;        
        //��Ʒ����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GODS_CODE';
        Column.Title.Caption:='����';
        Column.Width :=80;
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'BARCODE';
        Column.Title.Caption:='����';
        Column.Width :=90;
        //��λ
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'UNIT_NAME';
        Column.Title.Caption:='��λ';
        Column.Width :=40;        
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'NEW_INPRICE';
        Column.Title.Caption:='����';
        Column.DisplayFormat:='#0.00#';
        Column.Width :=66;
        //�ۼ�
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'NEW_OUTPRICE';
        Column.Title.Caption:='�ۼ�';
        Column.DisplayFormat:='#0.00#';
        Column.Width :=66;
        //�ڳ�
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'ORG_AMT';
        Column.Title.Caption:='�ڳ�';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_AMT';
        Column.Title.Caption:='����|����';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_TTL';
        Column.Title.Caption:='����|���';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=75;
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_AMT';
        Column.Title.Caption:='����|����';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_TTL';
        Column.Title.Caption:='����|���';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=75;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_PRF';
        Column.Title.Caption:='����|ë��';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=72;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALE_RATE';
        Column.Title.Caption:='����|ë����';
        Column.DisplayFormat:='#0.00%';
        Column.Footer.DisplayFormat:='#0.00%';
        Column.Width :=66;
        //���
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'BAL_AMT';
        Column.Title.Caption:='���';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=75;
        vType:=1;
      end;
     3: //������̨��:
      begin
        //���
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEQNO';
        Column.Title.Caption := '���';
        Column.Width :=30;
        //��������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_TYPE';
        Column.Title.Caption := '��������';
        Column.Width :=56;
        Column.KeyList.Add('1');
        Column.PickList.Add('��ⵥ');
        Column.KeyList.Add('3');
        Column.PickList.Add('�˻���');
        //��ˮ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GLIDE_NO';
        Column.Title.Caption := '��ˮ��';
        Column.Footer.ValueType:=fvtCount;
        Column.Width :=94;
        //��������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'STOCK_DATE';
        Column.DisplayFormat := '0000-00-00';
        Column.Title.Caption := '��ˮ��';
        Column.Width :=68;
        //��Ӧ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '��Ӧ��';
        Column.Width :=160;
        //�ŵ�����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SHOP_ID_TEXT';
        Column.Title.Caption := '�ŵ�����';
        Column.Width :=120;
        //���Ա
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GUIDE_USER_TEXT';
        Column.Title.Caption := '���Ա';
        Column.Width :=53;
        //Ʊ������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'INVOICE_FLAG';
        Column.Title.Caption := '���Ա';
        Column.Width :=54;
        InitColumnEhPickList(Column);
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMOUNT';
        Column.Title.Caption := '����';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=54;
        //�ϼƽ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMONEY';
        Column.Title.Caption := '�ϼƽ��';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=58;
        //�ѽ���
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PAYM_MNY';
        Column.Title.Caption := '�ѽ���';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=56;
        //δ����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECK_MNY';
        Column.Title.Caption := 'δ����';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=58;
        //��ע
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'REMARK';
        Column.Title.Caption := '��ע';
        Column.Width :=142;
        //�Ƶ�Ա
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_USER_TEXT';
        Column.Title.Caption := '�Ƶ�Ա';
        Column.Width :=62;
        //¼��ʱ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_DATE';
        Column.Title.Caption := '¼��ʱ��';
        Column.Width :=130;
        vType:=2;
      end;
     4: //������̨��:
      begin
        //���
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEQNO';
        Column.Title.Caption := '���';
        Column.Width :=30;
        //��������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALES_TYPE';
        Column.Title.Caption := '��������';
        Column.Width :=56;
        Column.KeyList.Add('1');
        Column.PickList.Add('���۵�');
        Column.KeyList.Add('3');
        Column.PickList.Add('�˻���');
        Column.KeyList.Add('4');
        Column.PickList.Add('���۵�');
        //��ˮ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GLIDE_NO';
        Column.Title.Caption := '��ˮ��';
        Column.Footer.ValueType:=fvtCount;
        Column.Width :=94;
        //��������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SALES_DATE';
        Column.DisplayFormat := '0000-00-00';
        Column.Title.Caption := '��������';
        Column.Width :=68;
        //�ͻ�����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '�ͻ�����';
        Column.Width :=150;
        //�ŵ�����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SHOP_ID_TEXT';
        Column.Title.Caption := '�ŵ�����';
        Column.Width :=120;
        //����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMOUNT';
        Column.Title.Caption := '����';
        Column.DisplayFormat:='#0.###';
        Column.Footer.DisplayFormat:='#0.###';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=56;
        //�ϼƽ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'AMONEY';
        Column.Title.Caption := '�ϼƽ��';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;
        Column.Width :=62;
        //ʵ�ս��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECV_MNY';
        Column.Title.Caption := 'ʵ�ս��';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=60;
        //Ƿ�ս��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'RECK_MNY';
        Column.Title.Caption := 'Ƿ�ս��';
        Column.DisplayFormat:='#0.00#';
        Column.Footer.DisplayFormat:='#0.00#';
        Column.Footer.ValueType:=fvtSum;        
        Column.Width :=60;
        //����Ա
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'GUIDE_USER_TEXT';
        Column.Title.Caption := '����Ա';
        Column.Width :=50;
        //Ʊ������
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'INVOICE_FLAG';
        Column.Title.Caption := 'Ʊ������';
        Column.Width :=54;
        InitColumnEhPickList(Column);
        //�Ƶ�Ա
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_USER_TEXT';
        Column.Title.Caption := '�Ƶ�Ա';
        Column.Width :=60;
        //¼��ʱ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CREA_DATE';
        Column.Title.Caption := '¼��ʱ��';
        Column.Width :=120;
        //��ע
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'REMARK';
        Column.Title.Caption := '��ע';
        Column.Width :=100;
        //�ͻ�����
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PLAN_DATE';
        Column.Title.Caption := '�ͻ�����';
        Column.Width :=62;
        //��ϵ��
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'LINKMAN';
        Column.Title.Caption := '��ϵ��';
        Column.Width :=54;
        //�ͻ���ַ
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'SEND_ADDR';
        Column.Title.Caption := '�ͻ���ַ';
        Column.Width :=142;
        vType:=3;        
      end;
    end;
    //ˢ�¿�����:
    LoadGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
    //ˢ����
    if rzShowColumns.Visible then RefreshColumn;
  finally
    DBGridEh1.Columns.EndUpdate;
  end;
end;

function TfrmAllRckReport.GetrptType: integer;
begin
  result:=0;
  if rptTemplate.ItemIndex<>-1 then
    result:=rptTemplate.ItemIndex;
end;

function TfrmAllRckReport.GetSQL: string;
var
  w,w1:string;
  strWhere,UnitCalc,mx,strSql,BarTab: string;
  BegDate,EndDate: string;
begin
  BegDate:=Formatdatetime('YYYYMMDD',P1_D1.Date);
  EndDate:=Formatdatetime('YYYYMMDD',P1_D2.Date);
  case rptType of
   0, //ȫ����Ʒ̨��
   1, //��������Ʒ̨��
   2: //��������Ʒ̨��
    begin
      //����Ƿ����:
      CheckCalc(strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date)),strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
      //ȡ��̨���������������:
      mx := GetMaxDate(StrtoInt(formatDatetime('YYYYMMDD',P1_D2.Date)));
      //������λ����:
      UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
      //������ҵID:
      strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
      if rptType=1 then
        strWhere:=strWhere+' and C.RELATION_ID=1000006 '
      else if rptType=2 then
        strWhere:=strWhere+' and C.RELATION_ID<>1000006 ';
      //����:
      if (P1_D1.EditValue<>null) and (formatDatetime('YYYYMMDD',P1_D1.Date)=formatDatetime('YYYYMMDD',P1_D2.Date)) then
        strWhere:=strWhere+' and A.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
      else if P1_D1.Date<P1_D2.Date then
        strWhere:=strWhere+' and A.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+' ';
      strSql :=
        'SELECT '+
        ' A.TENANT_ID '+
        ',A.GODS_ID,A.SHOP_ID,B.SHOP_NAME,isnull(B.SHOP_TYPE,''#'') as SHOP_TYPE '+
        ',(C.NEW_INPRICE*'+UnitCalc+') as NEW_INPRICE,(C.NEW_OUTPRICE*'+UnitCalc+') as NEW_OUTPRICE '+
        ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_AMT*1.00/'+UnitCalc+' else 0 end) as ORG_AMT '+ //�ڳ�����
        ',sum(case when A.CREA_DATE='+formatDatetime('YYYYMMDD',P1_D1.Date)+' then ORG_MNY else 0 end) as ORG_MNY '+   //������<����ʱ����>

        ',sum(STOCK_AMT*1.00/'+UnitCalc+') as STOCK_AMT '+   //��������
        ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+   //�������<ĩ˰>

        ',sum(SALE_AMT*1.00/'+UnitCalc+') as SALE_AMT '+   //��������
        ',sum(SALE_MNY) as SALE_MNY '+    //���۽��<ĩ˰>
        ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+  //���۽��
        ',sum(SALE_PRF) as SALE_PRF '+    //����ë��

        ',sum(case when A.CREA_DATE='+mx+' then BAL_AMT*1.00/'+UnitCalc+' else 0 end) as BAL_AMT '+ //�������
        ',sum(case when A.CREA_DATE='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+   //������<����ʱ����>
        ' from RCK_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSPRICE C '+
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere+' '+
        ' group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,B.SHOP_NAME,B.SHOP_TYPE,(C.NEW_INPRICE*'+UnitCalc+'),(C.NEW_OUTPRICE*'+UnitCalc+')';
      strSql :=
        'select j.* '+
        ' ,(case when SALE_MNY<>0 then (SALE_PRF*100.00/SALE_MNY) else 0.00 end) as SALE_RATE '+    //����ë����
        ' ,r.BARCODE as CALC_BARCODE '+
        ' ,r.GODS_CODE '+
        ' ,r.GODS_NAME as GODS_ID_TEXT'+
        ' ,''#'' as PROPERTY_01 '+
        ' ,''#'' as BATCH_NO '+
        ' ,''#'' as PROPERTY_02 '+
        ' ,'+GetUnitID(fndP1_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
        ' ,isnull(r.SORT_ID2,''#'') as SORT_ID '+
        ' from ('+strSql+') j '+
        ' inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';
      strSql :=
        'select ja.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,ja.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME '+
        ' from ('+strSql+') ja '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on ja.TENANT_ID=b.TENANT_ID and ja.GODS_ID=b.GODS_ID and ja.BATCH_NO=b.BATCH_NO and ja.PROPERTY_01=b.PROPERTY_01 and '+
           ' ja.PROPERTY_02=b.PROPERTY_02 and ja.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on ja.TENANT_ID=u.TENANT_ID and ja.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        ' (select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE=2 and COMM not in (''02'',''12'')) s '+
        ' on ja.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,ja.GODS_CODE';
      result:=ParseSQL(Factor.iDbType,strSql);
    end;
   3: //����̨��
    begin
      if BegDate=EndDate then
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.STOCK_TYPE=1 and A.STOCK_DATE>='+BegDate+' ' 
      else
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.STOCK_DATE>='+BegDate+' and A.STOCK_DATE<='+EndDate+' and A.STOCK_TYPE=1';
      w := ' select A.TENANT_ID,A.STOCK_TYPE,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CREA_DATE,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,A.GUIDE_USER,A.CREA_USER,A.SHOP_ID,'+
           ' A.STOCK_AMT as AMOUNT,A.STOCK_MNY as AMONEY,''4'' as ABLE_TYPE,case when LOCUS_STATUS = ''3'' then 3 else 1 end as LOCUS_STATUS_NAME '+
           ' from STK_STOCKORDER A '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
      w := ' select ja.*,a.CLIENT_NAME from ('+w+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
      w := 'select jc.*,c.PAYM_MNY,c.RECK_MNY from ('+w+') jc '+
           ' left join ACC_PAYABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.STOCK_ID=c.STOCK_ID and jc.ABLE_TYPE=c.ABLE_TYPE';
      w := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+w+') jd '+
           ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
      w := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+w+') je '+
           ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID';
      result :=
           'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+w+') jf '+
           ' left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ';
    end;
   4: //����̨��
    begin
      if BegDate=EndDate then
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SALES_TYPE in (1,4) and A.SALES_DATE='+BegDate+' '
      else
        w := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SALES_TYPE in (1,4) and A.SALES_DATE>='+BegDate+' and A.SALES_DATE<='+EndDate+' ';
        
      w := ' select A.TENANT_ID,A.SALES_TYPE,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.SEND_ADDR,A.REMARK,A.INVOICE_FLAG,A.CLIENT_ID,'+
           ' A.CREA_USER,A.SHOP_ID,A.GUIDE_USER,A.CREA_DATE,A.SALE_AMT as AMOUNT,A.SALE_MNY as AMONEY,''1'' as RECV_TYPE, '+
           ' case when LOCUS_STATUS = ''3'' then 3 else 1 end as LOCUS_STATUS_NAME from SAL_SALESORDER A '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';
      w := 'select ja.*,a.CLIENT_NAME from ('+w+') ja '+
           ' left outer join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
      w := 'select jc.*,(case when jc.SALES_TYPE=4 then jc.AMONEY else c.RECV_MNY end)as RECV_MNY,c.RECK_MNY from ('+w+') jc '+
           ' left outer join ACC_RECVABLE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SALES_ID=c.SALES_ID and jc.RECV_TYPE=c.RECV_TYPE';
      w := 'select jd.*,d.USER_NAME as GUIDE_USER_TEXT from ('+w+') jd '+
           ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.GUIDE_USER=d.USER_ID';
      w := 'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+w+') je '+
           ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID ';
      result :=
           'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+w+') jf '+
           ' left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ';
    end;
  end;
end;

procedure TfrmAllRckReport.rptTemplatePropertiesChange(Sender: TObject);
begin
  //���Ƶ�λ�Ƿ���ʾ������:
  fndP1_UNIT_ID.Visible:=(rptType<3);
  LblUnit.Visible:=(rptType<3);
end;

procedure TfrmAllRckReport.DBGridEh1DblClick(Sender: TObject);
var
  BillID: string;
begin
  if CurOrder=nil then
  begin
    BillID:='';
    if adoReport1.IsEmpty then Exit;
    if adoReport1.FindField('STOCK_ID')<>nil then
      BillID:=trim(adoReport1.FieldByName('STOCK_ID').AsString)
    else if adoReport1.FindField('SALES_ID')<>nil then
      BillID:=trim(adoReport1.FieldByName('SALES_ID').AsString);  
    if BillID='' then Exit;
    OpenDetailForm(BillID, adoReport1.FieldbyName('SHOP_ID').AsString);
  end;
end;

procedure TfrmAllRckReport.OpenDetailForm(id, cid: string);
function CheckExists:integer;
var
  i:integer;
  FrmObj: TframeOrderForm;
begin
  result := -1;
  for i:=0 to rzPage.PageCount -1 do
    begin
      if rzPage.Pages[i].Data = nil then continue;
      FrmObj:=TframeOrderForm(rzPage.Pages[i].Data);
      if (FrmObj.oid = id) and (FrmObj.cid=cid) then
      begin
        result := i;
        exit;
      end;
      //����ˢ������
      if cid='' then
        FrmObj.cid := Global.SHOP_ID
      else
        FrmObj.cid := cid;
      FrmObj.Open(id);
      result:=i;
    end;
end;
var
  p:integer;
  form: TframeOrderForm;
  Page: TrzTabSheet;
begin
  p := CheckExists;
  if p>=0 then
  begin
    rzPage.ActivePageIndex := p;
    exit;
  end;
  //�´�������
   Page := TrzTabSheet.Create(rzPage);
   form := TframeOrderForm(GetFormClass.Create(self));
   try
     inc(idx);
     Page.Caption := '�½�'+inttostr(idx);
     Page.PageControl := rzPage;
     Page.Data := form;
     Page.Align := alClient;
     form.TabSheet := Page;
     form.ContainerHanle := Page.Handle;
     rzPage.ActivePage := Page;
     form.SetParantDisplay(rzPage.ActivePage);
     if cid='' then
        form.cid := Global.SHOP_ID
     else
        form.cid := cid;
     form.Open(id);
     RzPage.OnChange(nil);
   except
     Page.Data := nil;
     form.TabSheet := nil;
     form.Free;
     Page.Free;
     rzPage.ActivePageIndex := 0;
   end;
end;

function TfrmAllRckReport.GetCurOrder: TframeOrderForm;
begin
  if not Assigned(RzPage.ActivePage.Data) then
     result := nil
  else
     result := TframeOrderForm(RzPage.ActivePage.Data);
end;

function TfrmAllRckReport.GetFormClass: TFormClass;
begin
  if adoReport1.Active then
  begin
    if adoReport1.FindField('STOCK_ID')<>nil then
      result:=TfrmStockOrder
    else if adoReport1.FindField('SALES_ID')<>nil then
      result:=TfrmSalesOrder;
  end;
end;

procedure TfrmAllRckReport.Clear;
var
  i:integer;
begin
  for i:=rzPage.PageCount -1 downto 1 do
  begin
    if rzPage.Pages[i].Data <> nil then
      TframeOrderForm(rzPage.Pages[i].Data).Free;
  end;
end;

procedure TfrmAllRckReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
  GridDs: TDataSet;
begin
  ColName:=trim(UpperCase(Column.FieldName));
  GridDs:=TDataSet(DBGridEh1.DataSource.DataSet);
  if (GridDs.FindField('ORG_AMT')<>nil) and (GridDs.FindField('BAL_AMT')<>nil) and (AllRecord.Count>0) then
  begin
    if ColName='GODS_ID_TEXT' then
      Text := '�ϼ�:'+AllRecord.fieldbyName('GODS_ID_TEXT').AsString+'��';
    if AllRecord.FindField(ColName)<>nil then
    begin
      if (Copy(ColName,1,4)='ORG_') or (Copy(ColName,1,6)='STOCK_') or (Copy(ColName,1,5)='SALE_') or (Copy(ColName,1,4)='BAL_') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end
    end;    
  end else
  begin
    if ColName='GLIDE_NO' then 
      Text := '�ϼ�:'+Text+'��';
  end;
end;

procedure TfrmAllRckReport.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if (adoReport1.Active) and (adoReport1.FindField('ORG_AMT')<>nil) and (adoReport1.FindField('BAL_AMT')<>nil) then
    DBGridTitleClick(adoReport1,Column,'ORDER_ID')
  else
    DBGridTitleClick(adoReport1,Column);
end;

procedure TfrmAllRckReport.InitColumnEhPickList(Column: TColumnEh);
var
  rs: TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_PARAMS');
  rs.Filtered := false;
  rs.Filter := 'TYPE_CODE='''+Column.FieldName+'''';
  rs.Filtered := true;
  if rs.IsEmpty then Exit;
  try
    Column.KeyList.Clear;
    Column.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
      rs.Next;
    end;
  finally
    rs.Filtered := false;
    rs.Filter := '';
  end;
end;

function TfrmAllRckReport.GetBillType: integer;
begin
  result:=1;
  if adoReport1.IsEmpty then Exit;
  if (adoReport1.FindField('ORG_AMT')<>nil) and (adoReport1.FindField('BAL_AMT')<>nil) then
    result:=1
  else if adoReport1.FindField('STOCK_ID')<>nil then
    result:=2
  else if adoReport1.FindField('SALES_ID')<>nil then
    result:=3;
end;

procedure TfrmAllRckReport.rzShowColumnsChange(Sender: TObject;
  Index: Integer; NewState: TCheckBoxState);
begin
  if rzShowColumns.Tag = 1 then Exit;
  try
    if rzShowColumns.Items[Index]='' then Exit;
    TColumnEh(rzShowColumns.Items.Objects[Index]).Visible := (NewState = cbChecked);
    SaveFormat;
  except
  end;
end;

procedure TfrmAllRckReport.LoadFormat;
var
  vType: integer;
begin
  vType:=BillType;
  if vType=-1 then Exit;
  LoadGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
end;

procedure TfrmAllRckReport.SaveFormat;
var
  vType: integer;
begin
  vType:=BillType;
  if vType=-1 then Exit;
  SaveGridColumnFormat(DBGridEh1,Caption+DBGridEh1.Name+'_'+IntToStr(vType));
end;

procedure TfrmAllRckReport.actColumnVisibleExecute(Sender: TObject);
begin
  if not rzShowColumns.Visible then RefreshColumn;
  inherited;
end;

procedure TfrmAllRckReport.RefreshColumn;
var i,n:Integer;
begin
  inherited;
  if DBGridEh=nil then Exit;
  rzShowColumns.Tag := 1;
  try
  rzShowColumns.Items.Clear;
  for i:=0 to DBGridEh.Columns.Count -1 do
    begin
      n := rzShowColumns.Items.AddObject(DBGridEh.Columns[i].Title.Caption,DBGridEh.Columns[i]);
      if DBGridEh.Columns[i].Visible then
         rzShowColumns.ItemState[n] := cbChecked
      else
         rzShowColumns.ItemState[n] := cbUnchecked;
      rzShowColumns.ItemEnabled[n] := (i>DBGridEh.FrozenCols-1);
    end;
  finally
    rzShowColumns.Tag := 0;
  end;
end;

procedure TfrmAllRckReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

end.
