unit ufrmMktGodsReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup,
  ufrmDateControl, Buttons, DBGrids;
  
type
  TfrmMktGodsReport = class(TframeBaseReport)
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel2: TRzLabel;
    btnOk: TRzBitBtn;
    dsadoReport2: TDataSource;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    dsadoReport4: TDataSource;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    BtnKpi: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    BtnDept: TRzBitBtn;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    BtnSaleSum: TRzBitBtn;
    RzPanel21: TRzPanel;
    DBGridEh4: TDBGridEh;
    RzLabel6: TRzLabel;
    Label17: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label18: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    fndP1_CUST_VALUE: TzrComboBoxList;
    Label44: TLabel;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Label4: TLabel;
    fndP2_CUST_TYPE: TcxComboBox;
    fndP2_CUST_VALUE: TzrComboBoxList;
    Label5: TLabel;
    Label6: TLabel;
    fndP2_CLIENT_ID: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    Label11: TLabel;
    fndP3_CUST_TYPE: TcxComboBox;
    fndP3_CUST_VALUE: TzrComboBoxList;
    Label12: TLabel;
    Label15: TLabel;
    fndP3_CLIENT_ID: TzrComboBoxList;
    fndP3_DEPT_ID: TzrComboBoxList;
    Label19: TLabel;
    fndP4_CUST_TYPE: TcxComboBox;
    fndP4_CUST_VALUE: TzrComboBoxList;
    Label20: TLabel;
    Label21: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    Label22: TLabel;
    fndP4_GUIDE_USER: TzrComboBoxList;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    P3_D2: TcxDateEdit;
    RzLabel4: TRzLabel;
    P3_D1: TcxDateEdit;
    RzLabel5: TRzLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    Label33: TLabel;
    fndP1_GODS_ID: TzrComboBoxList;
    Label3: TLabel;
    fndP2_GODS_ID: TzrComboBoxList;
    Label7: TLabel;
    fndP3_GODS_ID: TzrComboBoxList;
    Label9: TLabel;
    fndP4_GODS_ID: TzrComboBoxList;
    TabSheet5: TRzTabSheet;
    RzPanel6: TRzPanel;
    Panel7: TPanel;
    RzPanel9: TRzPanel;
    Label8: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    RzLabel1: TRzLabel;
    RzLabel8: TRzLabel;
    Label16: TLabel;
    BtnSaleDetail: TRzBitBtn;
    fndP5_CUST_TYPE: TcxComboBox;
    fndP5_CUST_VALUE: TzrComboBoxList;
    fndP5_CLIENT_ID: TzrComboBoxList;
    fndP5_DEPT_ID: TzrComboBoxList;
    fndP5_GUIDE_USER: TzrComboBoxList;
    P5_D1: TcxDateEdit;
    P5_D2: TcxDateEdit;
    P5_DateControl: TfrmDateControl;
    fndP5_GODS_ID: TzrComboBoxList;
    RzPanel10: TRzPanel;
    DBGridEh5: TDBGridEh;
    adoReport5: TZQuery;
    dsadoReport5: TDataSource;
    Label23: TLabel;
    fndP1_UNIT_ID: TcxComboBox;
    Label24: TLabel;
    fndP2_UNIT_ID: TcxComboBox;
    Label25: TLabel;
    fndP3_UNIT_ID: TcxComboBox;
    Label26: TLabel;
    fndP4_UNIT_ID: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
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
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
  private
    AObj: TRecord_;
    vBegDate,vEndDate: string;
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    //�����ſ��˻��ܱ�
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //�������˻��ܱ�
    function GetGroupSQL(chk:boolean=true): string;  //2222
    //���ͻ����˻��ܱ�
    function GetClientSQL(chk:boolean=true): string;  //3333
    //����Ʒ����:
    function GetGodsSQL(chk:boolean=true): string;    //4444
    //���ͻ�������ϸ��ˮ��
    function GetGlideSQL(chk:boolean=true): string;   //5555
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    //����Page��ҳ��ʾ:��IsGroupReport�Ƿ����[�����ŵ�]��
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function GetDataRight: string;
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property DataRight: string read GetDataRight; //���ز鿴����Ȩ��
  end;

  
implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmMktGodsReport.FormCreate(Sender: TObject);
begin
  //������ڼ̳�֮ǰȡ��
  DoCreateKPIDataSet('1');
  inherited;
  //��ʼ���������
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_DateControl.StartDateControl:=P1_D1;
  P1_DateControl.EndDateControl:=P1_D2;

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_DateControl.StartDateControl:=P2_D1;
  P2_DateControl.EndDateControl:=P2_D2;

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_DateControl.StartDateControl:=P3_D1;
  P3_DateControl.EndDateControl:=P3_D2;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P4_DateControl.StartDateControl:=P4_D1;
  P4_DateControl.EndDateControl:=P4_D2;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P5_DateControl.StartDateControl:=P5_D1;
  P5_DateControl.EndDateControl:=P5_D2;

  fndP1_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP2_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP3_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP4_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP5_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');

  TDbGridEhSort.InitForm(self,false);
  SetRzPageActivePage; //����PzPage.Activepage

  RefreshColumn;
 
  //2011.09.21 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.KPI_MNY','DBGridEh1.BUDG_MNY','DBGridEh1.AGIO_MNY','DBGridEh1.OTHR_MNY',
                              'DBGridEh2.KPI_MNY','DBGridEh2.BUDG_MNY','DBGridEh2.AGIO_MNY','DBGridEh2.OTHR_MNY',
                              'DBGridEh3.KPI_MNY','DBGridEh3.BUDG_MNY','DBGridEh3.AGIO_MNY','DBGridEh3.OTHR_MNY',
                              'DBGridEh4.KPI_MNY','DBGridEh4.BUDG_MNY','DBGridEh4.AGIO_MNY','DBGridEh4.OTHR_MNY',
                              'DBGridEh5.KPI_MNY','DBGridEh5.BUDG_MNY','DBGridEh5.AGIO_MNY','DBGridEh5.OTHR_MNY']);

end;

function TfrmMktGodsReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd,KpiTab,UnitCalc: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('����Ľ������ڲ���С�ڿ�ʼ����...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //����
  vBegDate:=FormatDatetime('YYYYMMDD',P1_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P1_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';

  //��������:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP1_DEPT_ID.AsString);
  //��Ʒ����:
  if fndP1_GODS_ID.AsString<>'' then
    strWhere:=strWhere+' and B.GODS_ID='''+fndP1_GODS_ID.AsString+''' ';
  //�ͻ�����:
  if fndP1_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  strCnd:='';
  if (fndP1_CUST_VALUE.AsString<>'') then
  begin
    case fndP1_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP1_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP1_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP1_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP1_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strCnd:=' and D.SORT_ID='''+fndP1_CUST_VALUE.AsString+''' ';    //����
     3: strCnd:=' and D.FLAG='+fndP1_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end; 
  //��λ����ϵ��
  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
    
  if trim(StrCnd)='' then
  begin
    strSql:=
      'select '+
      ' A.DEPT_ID as DEPT_ID,'+
      ' (B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
      ' B.KPI_MNY as KPI_MNY,'+     //�������
      ' B.BUDG_MNY as BUDG_MNY,'+   //�г�����
      ' B.AGIO_MNY as AGIO_MNY,'+   //�۸�֧��
      ' B.OTHR_MNY as OTHR_MNY '+   //�������
      ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
           '  B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID '+strWhere+' ';
  end else
  begin
    strSql:=
      'select '+
      ' A.DEPT_ID as DEPT_ID,'+
      ' (B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
      ' B.KPI_MNY as KPI_MNY,'+     //�������
      ' B.BUDG_MNY as BUDG_MNY,'+   //�г�����
      ' B.AGIO_MNY as AGIO_MNY,'+   //�۸�֧��
      ' B.OTHR_MNY as OTHR_MNY '+   //�������
      ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
      ' B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';
  end;
  
  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.DEPT_ID as DEPT_ID,'+
     ' DEPT.DEPT_NAME as DEPT_NAME,'+
     ' sum(CALC_AMOUNT) as CALC_AMOUNT,'+
     ' sum(KPI_MNY) as KPI_MNY,'+
     ' sum(BUDG_MNY) as BUDG_MNY,'+
     ' sum(AGIO_MNY) as AGIO_MNY,'+
     ' sum(OTHR_MNY) as OTHR_MNY '+
     ' from ('+strSql+')K '+
     ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+')DEPT '+
     ' on K.DEPT_ID=DEPT.DEPT_ID '+
     ' Group by K.DEPT_ID,DEPT.DEPT_NAME '
     );
end;

function TfrmMktGodsReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab,UnitCalc: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('����Ľ������ڲ���С�ڿ�ʼ����...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //��������
  vBegDate:=FormatDatetime('YYYYMMDD',P2_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P2_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
   //��������:
  if trim(fndP2_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP2_DEPT_ID.AsString);
  //��Ʒ����:
  if fndP2_GODS_ID.AsString<>'' then
    strWhere:=strWhere+' and C.GODS_ID='''+fndP2_GODS_ID.AsString+''' ';
  //�ͻ�����:
  if fndP2_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP2_CLIENT_ID.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  strCnd:='';
  if (fndP2_CUST_VALUE.AsString<>'') then
  begin
    case fndP2_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP2_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP2_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP2_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP2_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strCnd:=' and D.SORT_ID='''+fndP2_CUST_VALUE.AsString+''' ';    //����
     3: strCnd:=' and D.FLAG='+fndP2_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end;
  //��λ����ϵ��
  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');

  strSql:=
    'select '+
    ' D.REGION_ID as REGION_ID,'+
    ' (B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
    ' B.KPI_MNY as KPI_MNY,'+     //�������
    ' B.BUDG_MNY as BUDG_MNY,'+   //�г�����
    ' B.AGIO_MNY as AGIO_MNY,'+   //�۸�֧��
    ' B.OTHR_MNY as OTHR_MNY '+   //�������
    ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
          ' B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and '+
          ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
     'select '+
     ' K.REGION_ID as REGION_ID,'+
     ' isnull(Area.CODE_NAME,''��'') as CODE_NAME,'+
     ' sum(CALC_AMOUNT) as CALC_AMOUNT,'+
     ' sum(KPI_MNY) as KPI_MNY,'+
     ' sum(BUDG_MNY) as BUDG_MNY,'+
     ' sum(AGIO_MNY) as AGIO_MNY,'+
     ' sum(OTHR_MNY) as OTHR_MNY '+
     ' from ('+strSql+')K '+
     ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0)Area '+
     ' on K.REGION_ID=Area.CODE_ID '+
     ' Group by K.REGION_ID,Area.CODE_NAME '
     ); 
     
end;

function TfrmMktGodsReport.GetRowType: integer;
begin
  result :=0;
end;

procedure TfrmMktGodsReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //�����Ż��ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetDeptSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���������ܱ�
        if adoReport2.Active then adoReport2.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text:= strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //���ͻ����ܱ�
        if adoReport3.Active then adoReport3.Close;
        strSql := GetClientSQL;

        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3:
     begin //����Ʒ���ܱ�
        if adoReport4.Active then adoReport4.Close;
        adoReport4.SortedFields:='';
        strSql := GetGodsSQL;

        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
    4:
     begin //����Ʒ���ܱ�
        if adoReport5.Active then adoReport5.Close;
        adoReport5.SortedFields:='';
        strSql := GetGlideSQL;

        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

procedure TfrmMktGodsReport.fndP1_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  fndP1_GODS_ID.KeyValue := null;
  fndP1_GODS_ID.Text := '';
end;

function TfrmMktGodsReport.GetCLIENTSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab,UnitCalc: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('����Ľ������ڲ���С�ڿ�ʼ����...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //��������
  vBegDate:=FormatDatetime('YYYYMMDD',P3_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P3_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
  //��������:
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP3_DEPT_ID.AsString);
  //��Ʒ����:
  if fndP3_GODS_ID.AsString<>'' then
    strWhere:=strWhere+' and C.GODS_ID='''+fndP3_GODS_ID.AsString+''' ';
  //�ͻ�����:
  if fndP3_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP3_CLIENT_ID.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  strCnd:='';
  if (fndP3_CUST_VALUE.AsString<>'') then
  begin
    case fndP3_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP3_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP3_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP3_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP3_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strCnd:=' and D.SORT_ID='''+fndP3_CUST_VALUE.AsString+''' ';    //����
     3: strCnd:=' and D.FLAG='+fndP3_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end;
  //��λ����ϵ��
  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');  

  strSql:=
    'select '+
    ' A.CLIENT_ID as CLIENT_ID,'+
    ' D.CLIENT_NAME as CLIENT_NAME,'+
    ' sum(B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
    ' sum(B.KPI_MNY) as KPI_MNY,'+     //�������
    ' sum(B.BUDG_MNY) as BUDG_MNY,'+   //�г�����
    ' sum(B.AGIO_MNY) as AGIO_MNY,'+   //�۸�֧��
    ' sum(B.OTHR_MNY) as OTHR_MNY '+   //�������
    ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
          ' B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and '+
          ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' '+
    ' Group by A.CLIENT_ID,D.CLIENT_NAME ';

  Result :=ParseSQL(Factor.iDbType,strSql);
end;

function TfrmMktGodsReport.GetGodsSQL(chk:boolean=true): string;    //4444
var
  strSql,strWhere,strCnd,KpiTab,UnitCalc,UnitID: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('����Ľ������ڲ���С�ڿ�ʼ����...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //��������
  vBegDate:=FormatDatetime('YYYYMMDD',P4_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P4_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
  //��������:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);
  //��Ʒ����:
  if fndP4_GODS_ID.AsString<>'' then
    strWhere:=strWhere+' and C.GODS_ID='''+fndP4_GODS_ID.AsString+''' ';
  //�ͻ�����:
  if fndP4_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP4_CLIENT_ID.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  strCnd:='';
  if (fndP4_CUST_VALUE.AsString<>'') then
  begin
    case fndP4_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP4_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP4_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP4_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP4_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strCnd:=' and D.SORT_ID='''+fndP4_CUST_VALUE.AsString+''' ';    //����
     3: strCnd:=' and D.FLAG='+fndP4_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end;
  //��λ����ϵ��
  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C'); 
  UnitID:=GetUnitID(fndP4_UNIT_ID.ItemIndex,'C');

  if strCnd='' then
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+      
      ' B.GODS_ID as GODS_ID,'+
      ' C.GODS_NAME as GODS_NAME,'+
      ' C.BARCODE as BARCODE,'+
      ' C.GODS_CODE as GODS_CODE,'+
      ' '+UnitID+' as UNIT_ID,'+
      ' (B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
      ' B.KPI_MNY as KPI_MNY,'+     //�������
      ' B.BUDG_MNY as BUDG_MNY,'+   //�г�����
      ' B.AGIO_MNY as AGIO_MNY,'+   //�۸�֧��
      ' B.OTHR_MNY as OTHR_MNY '+   //�������
      ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
            ' B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID '+strWhere+strCnd+' ';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' B.GODS_ID as GODS_ID,'+
      ' C.GODS_NAME as GODS_NAME,'+
      ' C.BARCODE as BARCODE,'+
      ' C.GODS_CODE as GODS_CODE,'+
      ' '+UnitID+' as UNIT_ID,'+
      ' (B.CALC_AMOUNT/'+UnitCalc+') as CALC_AMOUNT,'+  //��������
      ' B.KPI_MNY as KPI_MNY,'+     //�������
      ' B.BUDG_MNY as BUDG_MNY,'+   //�г�����
      ' B.AGIO_MNY as AGIO_MNY,'+   //�۸�֧��
      ' B.OTHR_MNY as OTHR_MNY '+   //�������
      ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_GOODSINFO C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
            ' B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and '+ 
            ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+strCnd+' ';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select j.*,u.UNIT_NAME as UNIT_NAME  from '+
     '(select '+
     ' K.TENANT_ID as TENANT_ID,'+
     ' K.GODS_ID as GODS_ID,'+
     ' K.GODS_NAME as GODS_NAME,'+
     ' K.BARCODE as BARCODE,'+
     ' K.GODS_CODE as GODS_CODE,'+
     ' K.UNIT_ID as UNIT_ID,'+     
     ' sum(CALC_AMOUNT) as CALC_AMOUNT,'+
     ' sum(KPI_MNY) as KPI_MNY,'+
     ' sum(BUDG_MNY) as BUDG_MNY,'+
     ' sum(AGIO_MNY) as AGIO_MNY,'+
     ' sum(OTHR_MNY) as OTHR_MNY '+
     ' from ('+strSql+')K '+
     ' Group by K.TENANT_ID,K.GODS_ID,K.GODS_NAME) j '+
     ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '
     );
end;

function TfrmMktGodsReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab,UnitCalc: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('����Ľ������ڲ���С�ڿ�ʼ����...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;
  //��������
  vBegDate:=FormatDatetime('YYYYMMDD',P5_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P5_D2.Date);
  if vBegDate < vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' '
  else if vBegDate = vEndDate then
    strWhere:=strWhere+' and A.REQU_DATE='+vBegDate+' ';
  //��������:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP5_DEPT_ID.AsString);
  //��Ʒ����:
  if fndP5_GODS_ID.AsString<>'' then
    strWhere:=strWhere+' and B.GODS_ID='''+fndP5_GODS_ID.AsString+''' ';
  //�ͻ�����:
  if fndP5_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP5_CLIENT_ID.AsString+''' ';

  //���
  if fndP5_GUIDE_USER.AsString <> '' then
    strWhere:=strWhere+' and A.REQU_USER='''+fndP5_GUIDE_USER.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  strCnd:='';
  if (fndP5_CUST_VALUE.AsString<>'') then
  begin
    case fndP5_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP5_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strCnd:=' and D.REGION_ID like '''+GetRegionId(fndP5_CUST_VALUE.AsString)+'%'' '
         else
           strCnd:=' and D.REGION_ID='''+fndP5_CUST_VALUE.AsString+''' ';
       end;
     1: strCnd:=' and D.PRICE_ID='''+fndP5_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strCnd:=' and D.SORT_ID='''+fndP5_CUST_VALUE.AsString+''' ';    //����
     3: strCnd:=' and D.FLAG='+fndP5_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end;

  strSql:=
    'select '+
    ' A.TENANT_ID as TENANT_ID,'+
    ' A.GLIDE_NO as GLIDE_NO,'+        //���쵥��
    ' A.REQU_DATE as REQU_DATE,'+      //��������
    ' D.CLIENT_NAME as CLIENT_NAME,'+  //�ͻ�����
    ' A.DEPT_ID as DEPT_ID,'+          //����ID
    ' B.GODS_ID as GODS_ID,'+          //��ƷID
    ' B.UNIT_ID as UNIT_ID,'+          //��Ʒ��λ
    ' B.AMOUNT as AMOUNT,'+            //��������
    ' B.KPI_MNY as KPI_MNY,'+          //�������
    ' B.BUDG_MNY as BUDG_MNY,'+        //�г�����
    ' B.AGIO_MNY as AGIO_MNY,'+        //�۸�֧��
    ' B.OTHR_MNY as OTHR_MNY,'+        //�������
    ' B.REMARK as REMARK,'+            //ժҪ
    ' A.REQU_USER as REQU_USER,'+      //���ID
    ' A.CREA_DATE as CREA_DATE,'+      //��������
    ' A.CREA_USER as CREA_USER,'+      //������
    ' A.CHK_DATE as CHK_DATE,'+        //�������
    ' A.CHK_USER as CHK_USER '+        //�����
    ' from MKT_REQUORDER A,MKT_REQUSHARE B,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID  '+strWhere+strCnd+' ';
 
  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    ' G.GODS_NAME as GODS_NAME,'+
    ' G.GODS_CODE as GODS_CODE,'+
    ' G.BARCODE as BARCODE,'+
    ' U.UNIT_NAME as UNIT_NAME,'+
    ' DEPT.DEPT_NAME as DEPT_NAME,'+
    ' D.USER_NAME as REQU_USER_TEXT,'+
    ' E.USER_NAME as CREA_USER_TEXT,'+
    ' F.USER_NAME as CHK_USER_TEXT '+
    ' from ('+strSql+')K '+
    ' left outer join VIW_GOODSINFO G on K.TENANT_ID=G.TENANT_ID and K.GODS_ID=G.GODS_ID '+
    ' left outer join VIW_MEAUNITS U on K.UNIT_ID=U.UNIT_ID '+
    ' left outer join CA_DEPT_INFO DEPT on K.TENANT_ID=DEPT.TENANT_ID and K.DEPT_ID=DEPT.DEPT_ID '+
    ' left outer join VIW_USERS D on K.TENANT_ID=D.TENANT_ID and K.REQU_USER=D.USER_ID '+
    ' left outer join VIW_USERS E on K.TENANT_ID=E.TENANT_ID and K.CREA_USER=E.USER_ID '+
    ' left outer join VIW_USERS F on K.TENANT_ID=F.TENANT_ID and K.CHK_USER=F.USER_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmMktGodsReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmMktGodsReport.PrintBefore;
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
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmMktGodsReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmMktGodsReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmMktGodsReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmMktGodsReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmMktGodsReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date:=P1_D1.Date;  //1.��������
  P2_D2.Date:=P1_D2.Date;
  fndP2_CUST_TYPE.ItemIndex:=fndP1_CUST_TYPE.ItemIndex;  //3.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP1_CUST_VALUE,fndP2_CUST_VALUE);   //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP1_GODS_ID,fndP2_GODS_ID);         //4.��ƷID
  Copy_ParamsValue(fndP1_CLIENT_ID,fndP2_CLIENT_ID);     //5.�ͻ�
  fndP2_DEPT_ID.KeyValue:=adoReport1.fieldbyName('DEPT_ID').AsString; //6.��������
  fndP2_DEPT_ID.Text:=adoReport1.fieldbyName('DEPT_NAME').AsString;
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmMktGodsReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date:=P2_D1.Date;  //1.����
  P3_D2.Date:=P2_D2.Date;
  Copy_ParamsValue(fndP2_GODS_ID,fndP3_GODS_ID);          //3.����ָ��
  Copy_ParamsValue(fndP2_CLIENT_ID,fndP3_CLIENT_ID);    //4.�ͻ�
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID);        //5.����
  fndP3_CUST_TYPE.ItemIndex:=0;                         //6.�ͻ�Ⱥ��
  fndP3_CUST_VALUE.KeyValue:=adoReport2.fieldbyName('REGION_ID').AsString;
  fndP3_CUST_VALUE.Text:=adoReport2.fieldbyName('CODE_NAME').AsString;
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmMktGodsReport.SetRzPageActivePage(IsGroupReport: Boolean);
var
  i: integer;
  IsVisble: Boolean;
  Rs: TZQuery;
begin
  Rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if Rs<>nil then
  begin
    try
      Rs.Filtered:=false;
      Rs.Filter:='DEPT_TYPE=1';
      Rs.Filtered:=true;
      rzPage.Pages[0].TabVisible:=(Rs.RecordCount>1);  //���Ӫ����ʱ��ʾ
    finally
      Rs.Filtered:=false;
      Rs.Filter:='';
    end;
  end;

  IsVisble:=HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
  rzPage.Pages[1].TabVisible := IsVisble;
  rzPage.Pages[2].TabVisible := IsVisble;
  for i:=0 to rzPage.PageCount-1 do
  begin
    if rzPage.Pages[i].TabVisible then
    begin
      rzPage.ActivePageIndex:=i;
      break;
    end;
  end; 
end;

procedure TfrmMktGodsReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmMktGodsReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GLIDE_NO' then Text := '�ϼ�:'+Text+'��';
end;

function TfrmMktGodsReport.GetDataRight: string;
begin
  //�����ݣ�RCK_C_GOODS_DAYS��VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;


procedure TfrmMktGodsReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
var
  Str,CurYear: string;
  Rs: TZQuery;
begin
  ClearCbxPickList(SetCbx);
  CurYear:=FormatDatetime('YYYY',Date());
  Rs:=TZQuery.Create(nil);
  try
    Rs.SQL.Text:='select distinct KPI_YEAR from MKT_PLANORDER order by KPI_YEAR Desc';
    Factor.Open(Rs);
    if Rs.Active then
    begin
      if not Rs.Locate('KPI_YEAR',CurYear,[]) then
        SetCbx.Properties.Items.Add(CurYear);
      Rs.First;
      while Not Rs.Eof do
      begin
        SetCbx.Properties.Items.Add(Rs.FieldByName('KPI_YEAR').AsString);
        Rs.Next;
      end;
    end;
    if SetCbx.Properties.Items.Count>0 then SetCbx.ItemIndex:=0;
  finally
    Rs.Free;
  end;
end;

procedure TfrmMktGodsReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  P4_D1.Date:=P3_D1.Date;  //1.����
  P4_D2.Date:=P3_D2.Date;
  fndP4_CUST_TYPE.ItemIndex:=fndP3_CUST_TYPE.ItemIndex;  //3.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP3_CUST_VALUE,fndP4_CUST_VALUE);   //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP3_GODS_ID,fndP4_GODS_ID);     //4.�ͻ�
  Copy_ParamsValue(fndP3_DEPT_ID,fndP4_DEPT_ID);         //5.����
  fndP4_CLIENT_ID.KeyValue:=adoReport3.fieldbyName('CLIENT_ID').AsString; //6.����ָ��
  fndP4_CLIENT_ID.Text:=adoReport3.fieldbyName('CLIENT_NAME').AsString;
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmMktGodsReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  P5_D1.Date:=P4_D1.Date;  //1.����
  P5_D2.Date:=P4_D2.Date;
  fndP5_CUST_TYPE.ItemIndex:=fndP4_CUST_TYPE.ItemIndex;  //3.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP4_CUST_VALUE,fndP3_CUST_VALUE);   //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP4_GODS_ID,fndP3_GODS_ID);     //4.�ͻ�
  Copy_ParamsValue(fndP4_DEPT_ID,fndP3_DEPT_ID);         //5.����
  fndP5_GODS_ID.KeyValue:=adoReport4.fieldbyName('GODS_ID').AsString; //6.����ָ��
  fndP5_GODS_ID.Text:=adoReport4.fieldbyName('GODS_NAME').AsString;
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

end.
