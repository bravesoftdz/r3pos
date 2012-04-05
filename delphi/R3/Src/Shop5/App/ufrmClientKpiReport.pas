unit ufrmClientKpiReport;

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
  TfrmClientKpiReport = class(TframeBaseReport)
    TabSheet4: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzLabel2: TRzLabel;
    btnDept: TRzBitBtn;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    dsadoReport4: TDataSource;
    dsadoReport5: TDataSource;
    Label7: TLabel;
    fndP1_KPI_ID: TzrComboBoxList;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    adoReport5: TZQuery;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    BtnClient: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel9: TRzPanel;
    BtnKpi: TRzBitBtn;
    RzPanel10: TRzPanel;
    DBGridEh4: TDBGridEh;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    BtnRegion: TRzBitBtn;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    BtnSaleDetail: TRzBitBtn;
    RzPanel21: TRzPanel;
    DBGridEh5: TDBGridEh;
    fndP1_YEAR1: TcxComboBox;
    RzLabel6: TRzLabel;
    fndP1_YEAR2: TcxComboBox;
    Label17: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Label18: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    fndP1_CUST_VALUE: TzrComboBoxList;
    Label44: TLabel;
    fndP1_CLIENT_ID: TzrComboBoxList;
    RzLabel3: TRzLabel;
    Label3: TLabel;
    Label4: TLabel;
    fndP2_CUST_TYPE: TcxComboBox;
    fndP2_YEAR1: TcxComboBox;
    RzLabel7: TRzLabel;
    fndP2_KPI_ID: TzrComboBoxList;
    fndP2_CUST_VALUE: TzrComboBoxList;
    fndP2_YEAR2: TcxComboBox;
    Label5: TLabel;
    Label6: TLabel;
    fndP2_CLIENT_ID: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    RzLabel1: TRzLabel;
    Label8: TLabel;
    Label10: TLabel;
    fndP4_CUST_TYPE: TcxComboBox;
    fndP4_YEAR1: TcxComboBox;
    RzLabel8: TRzLabel;
    fndP4_KPI_ID: TzrComboBoxList;
    fndP4_CUST_VALUE: TzrComboBoxList;
    fndP4_YEAR2: TcxComboBox;
    Label13: TLabel;
    Label14: TLabel;
    fndP4_CLIENT_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    RzLabel4: TRzLabel;
    Label9: TLabel;
    Label11: TLabel;
    fndP3_CUST_TYPE: TcxComboBox;
    fndP3_YEAR1: TcxComboBox;
    RzLabel5: TRzLabel;
    fndP3_KPI_ID: TzrComboBoxList;
    fndP3_CUST_VALUE: TzrComboBoxList;
    fndP3_YEAR2: TcxComboBox;
    Label12: TLabel;
    Label15: TLabel;
    fndP3_CLIENT_ID: TzrComboBoxList;
    fndP3_DEPT_ID: TzrComboBoxList;
    RzLabel9: TRzLabel;
    Label16: TLabel;
    Label19: TLabel;
    fndP5_CUST_TYPE: TcxComboBox;
    fndP5_YEAR1: TcxComboBox;
    RzLabel10: TRzLabel;
    fndP5_KPI_ID: TzrComboBoxList;
    fndP5_CUST_VALUE: TzrComboBoxList;
    fndP5_YEAR2: TcxComboBox;
    Label20: TLabel;
    Label21: TLabel;
    fndP5_CLIENT_ID: TzrComboBoxList;
    fndP5_DEPT_ID: TzrComboBoxList;
    Label22: TLabel;
    fndP5_GUIDE_USER: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    procedure AddYearCBxItemsList(SetCbx: TcxComboBox);
    //���ؿ��˽����:
    function GetKpiResultTab: string;
    //�����ſ��˻��ܱ�
    function GetDeptSQL(chk:boolean=true): string;   //1111
    //�������˻��ܱ�
    function GetGroupSQL(chk:boolean=true): string;  //2222
    //���ͻ����˻��ܱ�
    function GetClientSQL(chk:boolean=true): string; //3333
    //������ָ����ܱ�
    function GetKPISQL(chk:boolean=true): string;    //4444
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

procedure TfrmClientKpiReport.FormCreate(Sender: TObject);
begin
  //������ڼ̳�֮ǰȡ��
  DoCreateKPIDataSet('1');
  inherited;
  //��ʼ���������
  AddYearCBxItemsList(fndP1_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP1_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP2_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP2_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP3_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP3_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP4_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP4_YEAR2);
  CopyItemsList(fndP1_YEAR1,fndP5_YEAR1);
  CopyItemsList(fndP1_YEAR1,fndP5_YEAR2);

  fndP1_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP2_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP3_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP4_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
  fndP5_CLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');

  TDbGridEhSort.InitForm(self,false);
  SetRzPageActivePage; //����PzPage.Activepage

  RefreshColumn;
 
  //2011.09.21 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.JT_MNY','DBGridEh1.REQU_MNY','DBGridEh1.JY_MNY','DBGridEh1.BOND_MNY',
                              'DBGridEh2.JT_MNY','DBGridEh2.REQU_MNY','DBGridEh2.JY_MNY','DBGridEh2.BOND_MNY',
                              'DBGridEh3.JT_MNY','DBGridEh3.REQU_MNY','DBGridEh3.JY_MNY','DBGridEh3.BOND_MNY',
                              'DBGridEh4.JT_MNY','DBGridEh4.REQU_MNY','DBGridEh4.JY_MNY','DBGridEh4.BOND_MNY',
                              'DBGridEh5.JT_MNY']);
  //�����������
  CalcFooter:=TCalcFooter.Create;                            
end;



function TfrmClientKpiReport.GetDeptSQL(chk: boolean): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if fndP1_YEAR1.ItemIndex=-1 then Raise Exception.Create('������ݲ���Ϊ��...');
  if (fndP1_YEAR1.ItemIndex<>-1)and(fndP1_YEAR2.ItemIndex<>-1)and(fndP1_YEAR1.Text>fndP1_YEAR2.Text) then Raise Exception.Create('��ʼ��ݲ��ܴ��ڽ������...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //�����������
  if (fndP1_YEAR2.ItemIndex<>-1) and (fndP1_YEAR1.Text<fndP1_YEAR2.Text) then //��ѯ��ȶ�
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP1_YEAR1.Text+' and A.KPI_YEAR<='+fndP1_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP1_YEAR1.Text+' ';
  //��������:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP1_DEPT_ID.AsString);
  //����ָ��:
  if fndP1_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP1_KPI_ID.AsString+''' ';
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

  if trim(StrCnd)='' then
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(C.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //��֤���
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.PLAN_TYPE=''1'' '+strWhere+' '+
      ' group by A.TENANT_ID,A.KPI_YEAR,A.DEPT_ID';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID as TENANT_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(C.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
      ' sum(C.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //��֤���
      ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
      ' group by A.TENANT_ID,C.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
      '(JT_MNY - REQU_MNY) as JY_MNY,'+   //������
     ' isnull(DEPT.DEPT_NAME,''��'') as DEPT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join (select DEPT_ID,DEPT_NAME from CA_DEPT_INFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+')DEPT '+
     ' on K.DEPT_ID=DEPT.DEPT_ID '+
     ' order by K.DEPT_ID '
     );
end;

function TfrmClientKpiReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if fndP2_YEAR1.ItemIndex=-1 then Raise Exception.Create('������ݲ���Ϊ��...');
  if (fndP2_YEAR1.ItemIndex<>-1) and (fndP2_YEAR2.ItemIndex<>-1) and (fndP2_YEAR1.Text>fndP2_YEAR2.Text) then Raise Exception.Create('��ʼ��ݲ��ܴ��ڽ������...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //�����������
  if (fndP2_YEAR2.ItemIndex<>-1) and (fndP2_YEAR1.Text<fndP2_YEAR2.Text) then //��ѯ��ȶ�
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP2_YEAR1.Text+' and A.KPI_YEAR<='+fndP2_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP2_YEAR1.Text+' ';
  //��������:
  if trim(fndP2_DEPT_ID.AsString)<>'' then
   strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP2_DEPT_ID.AsString);
  //����ָ��:
  if fndP2_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP2_KPI_ID.AsString+''' ';
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

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' D.REGION_ID as REGION_ID,'+
    ' sum(C.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
    ' sum(C.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
    ' sum(B.BOND_MNY) as BOND_MNY '+  //��֤���
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
    ' group by A.TENANT_ID,A.KPI_YEAR,D.REGION_ID';

  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+                                 
     ' (JT_MNY - REQU_MNY) as JY_MNY,'+   //������
     '  isnull(Area.CODE_NAME,''��'') as CODE_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0)Area '+
     ' on K.REGION_ID=Area.CODE_ID '+
     ' order by K.REGION_ID '
   );
end;

function TfrmClientKpiReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmClientKpiReport.actFindExecute(Sender: TObject);
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
    2: begin //��KPI���ܱ�
        if adoReport3.Active then adoReport3.Close;
        strSql := GetClientSQL;

        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //���ͻ����ܱ�
        if adoReport4.Active then adoReport4.Close;
        strSql := GetKPISQL;

        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
    4: begin //����Ʒ���ܱ�
        if adoReport5.Active then adoReport5.Close;
        adoReport5.SortedFields:='';
        strSql := GetGlideSQL;

        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmClientKpiReport.GetCLIENTSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab: string;
begin
  if  fndP3_YEAR1.ItemIndex=-1 then Raise Exception.Create('������ݲ���Ϊ��...');
  if (fndP3_YEAR1.ItemIndex<>-1)and(fndP3_YEAR2.ItemIndex<>-1)and(fndP3_YEAR1.Text>fndP3_YEAR2.Text) then Raise Exception.Create('��ʼ��ݲ��ܴ��ڽ������...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //�����������
  if (fndP3_YEAR2.ItemIndex<>-1) and (fndP3_YEAR1.Text<fndP3_YEAR2.Text) then //��ѯ��ȶ�
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP3_YEAR1.Text+' and A.KPI_YEAR<='+fndP3_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP3_YEAR1.Text+' ';
  //��������:
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP3_DEPT_ID.AsString);
  //����ָ��:
  if fndP3_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP3_KPI_ID.AsString+''' ';
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

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.CLIENT_ID as CLIENT_ID,'+
    ' D.CLIENT_NAME as CLIENT_NAME,'+
    ' sum(C.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
    ' sum(C.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
    ' sum(B.BOND_MNY) as BOND_MNY,'+  //��֤���
    ' sum(C.KPI_MNY - C.WDW_MNY) as JY_MNY  '+   //������
    ' from MKT_PLANORDER A,MKT_PLANDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and '+
    ' A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
    ' group by A.TENANT_ID,A.KPI_YEAR,A.CLIENT_ID,D.CLIENT_NAME ';

  Result :=ParseSQL(Factor.iDbType, strSql);
end;

function TfrmClientKpiReport.GetKPISQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab,KPI_R_TAB: string;
begin
  if  fndP4_YEAR1.ItemIndex=-1 then Raise Exception.Create('������ݲ���Ϊ��...');
  if (fndP4_YEAR1.ItemIndex<>-1)and(fndP4_YEAR2.ItemIndex<>-1)and(fndP4_YEAR1.Text>fndP4_YEAR2.Text) then Raise Exception.Create('��ʼ��ݲ��ܴ��ڽ������...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //�����������
  if (fndP4_YEAR2.ItemIndex<>-1) and (fndP4_YEAR1.Text<fndP4_YEAR2.Text) then //��ѯ��ȶ�
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP4_YEAR1.Text+' and A.KPI_YEAR<='+fndP4_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP4_YEAR1.Text+' ';
  //��������:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);
  //����ָ��:
  if fndP3_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and C.KPI_ID='''+fndP4_KPI_ID.AsString+''' ';
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

  //���˽����:
  KPI_R_TAB:=GetKpiResultTab; // 

  if trim(StrCnd)='' then
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID,'+
      ' R.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when R.KPI_DATA in (''1'',''4'') then (B.AMOUNT/R.CalcValue) else B.AMONEY end) as PLAN_AMT,'+     //�ƻ���
      ' sum(case when R.KPI_DATA in (''1'',''4'') then R.FISH_AMT else R.FISH_MNY end) as KPI_AMT,'+  //�����
      ' sum(R.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
      ' sum(R.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //��֤���
      ' from MKT_PLANORDER A,MKT_PLANDATA B,('+KPI_R_TAB+')R '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and '+
      ' A.TENANT_ID=R.TENANT_ID and B.KPI_ID=R.KPI_ID and '+
      ' A.PLAN_TYPE=''1'' '+strWhere+' '+
      ' group by A.TENANT_ID,R.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end else
  begin
    strSql:=
      'select '+
      ' A.TENANT_ID,'+
      ' R.KPI_ID as KPI_ID,'+
      ' A.KPI_YEAR as KPI_YEAR,'+
      ' A.DEPT_ID as DEPT_ID,'+
      ' sum(case when R.KPI_DATA in (''1'',''4'') then (B.AMOUNT/R.CalcValue) else B.AMONEY end) as PLAN_AMT,'+     //�ƻ���
      ' sum(case when R.KPI_DATA in (''1'',''4'') then R.FISH_AMT else R.FISH_MNY end) as KPI_AMT,'+  //�����
      ' sum(R.KPI_MNY) as JT_MNY,'+     //���˽��(Ԫ)[������]
      ' sum(R.WDW_MNY) as REQU_MNY,'+   //������ȡ����[������]
      ' sum(B.BOND_MNY) as BOND_MNY '+  //��֤���
      ' from MKT_PLANORDER A,MKT_PLANDATA B,('+KPI_R_TAB+')R,VIW_CUSTOMER D '+
      ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and '+
      ' A.TENANT_ID=R.TENANT_ID and B.KPI_ID=R.KPI_ID and  '+
      ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and '+
      ' A.PLAN_TYPE=''1'' '+strWhere+strCnd+' '+
      ' group by A.TENANT_ID,R.KPI_ID,A.KPI_YEAR,A.DEPT_ID';
  end;
  Result :=ParseSQL(Factor.iDbType,
     'select K.*,'+
     ' (case when K.PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //�����
     ' (JT_MNY - REQU_MNY) as JY_MNY,'+   //������
     ' MKT.KPI_NAME as KPI_NAME,'+
     ' MKT.UNIT_NAME as UNIT_NAME '+
     ' from ('+strSql+')K '+
     ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
     ' order by K.KPI_ID '
     );
end;

function TfrmClientKpiReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,strCnd,KpiTab,KPI_R_TAB: string;
begin
  if  fndP5_YEAR1.ItemIndex=-1 then Raise Exception.Create('������ݲ���Ϊ��...');
  if (fndP5_YEAR1.ItemIndex<>-1) and (fndP5_YEAR2.ItemIndex<>-1)and(fndP5_YEAR1.Text>fndP5_YEAR2.Text) then Raise Exception.Create('��ʼ��ݲ��ܴ��ڽ������...');

  //������ҵID������Ȩ��:
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+GetDataRight;

  //�����������
  if (fndP5_YEAR2.ItemIndex<>-1) and (fndP5_YEAR1.Text<fndP5_YEAR2.Text) then //��ѯ��ȶ�
    strWhere:=strWhere+' and (A.KPI_YEAR>='+fndP5_YEAR1.Text+' and A.KPI_YEAR<='+fndP5_YEAR2.Text+')'
  else
    strWhere:=strWhere+' and A.KPI_YEAR='+fndP5_YEAR1.Text+' ';
  //��������:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP5_DEPT_ID.AsString);
  //����ָ��:
  if fndP5_KPI_ID.AsString<>'' then
    strWhere:=strWhere+' and R.KPI_ID='''+fndP5_KPI_ID.AsString+''' ';
  //�ͻ�����:
  if fndP5_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP5_CLIENT_ID.AsString+''' ';
  //����Ա:
  if fndP5_GUIDE_USER.AsString<>'' then
    strWhere:=strWhere+' and A.PLAN_USER='''+fndP5_GUIDE_USER.AsString+''' ';

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

  KPI_R_TAB:=GetKpiResultTab;

  strSql:=
    'select '+
    ' A.TENANT_ID,'+
    ' A.GLIDE_NO as GLIDE_NO,'+
    ' R.KPI_ID as KPI_ID,'+
    ' A.KPI_YEAR as KPI_YEAR,'+
    ' A.DEPT_ID as DEPT_ID,'+
    ' R.KPI_DATE1 as BEGIN_DATE,'+ //���˿�ʼ����
    ' R.KPI_DATE2 as END_DATE,'+
    ' (case when R.KPI_DATA in (''1'',''4'') then B.AMOUNT else B.AMONEY end) as PLAN_AMT,'+     //�ƻ���
    ' (case when R.KPI_DATA in (''1'',''4'') then R.FISH_AMT else R.FISH_MNY end) as KPI_AMT,'+  //�����
    ' R.KPI_MNY as JT_MNY,'+      //���˽��(Ԫ)[������]
    ' R.WDW_MNY as REQU_MNY,'+    //������ȡ����[������]
    ' B.BOND_MNY as BOND_MNY,'+   //��֤���
    ' R.REMARK as REMARK,'+
    ' R.CREA_DATE as CREA_DATE,'+
    ' R.CREA_USER as CREA_USER,'+
    ' D.CLIENT_NAME as CLIENT_NAME '+
    ' from MKT_PLANORDER A,MKT_PLANDATA B,('+KPI_R_TAB+')R,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and '+
    ' B.TENANT_ID=R.TENANT_ID and B.KPI_ID=R.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID and A.PLAN_TYPE=''1'' '+strWhere+strCnd+' ';

  Result :=ParseSQL(Factor.iDbType,
    'select K.*,'+
    '(case when PLAN_AMT<>0 then cast(K.KPI_AMT/(K.PLAN_AMT*1.00) as decimal(18,6)) else 0.00 end)*100.00 as KPI_RATE,'+     //�����
    ' MKT.KPI_NAME as KPI_NAME,'+
    ' MKT.UNIT_NAME as UNIT_NAME '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' order by K.GLIDE_NO '
    );
end;

procedure TfrmClientKpiReport.DBGridEh3DblClick(Sender: TObject);
begin
  if adoReport3.IsEmpty then Exit;
  fndP4_YEAR1.ItemIndex:=fndP3_YEAR1.ItemIndex;    //1.�������
  fndP4_YEAR2.ItemIndex:=fndP3_YEAR2.ItemIndex;
  fndP4_CUST_TYPE.ItemIndex:=fndP3_CUST_TYPE.ItemIndex;   //2.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP3_CUST_VALUE,fndP4_CUST_VALUE);    //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP3_DEPT_ID,fndP4_DEPT_ID);          //3.�ͻ�
  Copy_ParamsValue(fndP3_CLIENT_ID,fndP4_CLIENT_ID);      //4.�ͻ�
  fndP4_CLIENT_ID.KeyValue:=adoReport3.fieldbyName('CLIENT_ID').AsString;  //5.�ͻ�����
  fndP4_CLIENT_ID.Text:=adoReport3.fieldbyName('CLIENT_NAME').AsString;
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmClientKpiReport.PrintBefore;
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

function TfrmClientKpiReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
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


procedure TfrmClientKpiReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmClientKpiReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmClientKpiReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;  
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '�ϼ�:'+Text+'��';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText 
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmClientKpiReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  fndP2_YEAR1.ItemIndex:=fndP1_YEAR1.ItemIndex;     //1.�������
  fndP2_YEAR2.ItemIndex:=fndP1_YEAR2.ItemIndex;
  fndP2_CUST_TYPE.ItemIndex:=fndP1_CUST_TYPE.ItemIndex;  //2.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP1_CUST_VALUE,fndP2_CUST_VALUE);   //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP1_KPI_ID,fndP2_KPI_ID);           //3.����ָ��
  Copy_ParamsValue(fndP1_CLIENT_ID,fndP2_CLIENT_ID);     //4.�ͻ�
  fndP2_DEPT_ID.KeyValue:=adoReport1.fieldbyName('DEPT_ID').AsString; //5.�������� 
  fndP2_DEPT_ID.Text:=adoReport1.fieldbyName('DEPT_NAME').AsString; 
  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  fndP3_YEAR1.ItemIndex:=fndP2_YEAR1.ItemIndex;  //1.�������
  fndP3_YEAR2.ItemIndex:=fndP2_YEAR2.ItemIndex;
  Copy_ParamsValue(fndP2_KPI_ID,fndP3_KPI_ID);   //2.����ָ��
  Copy_ParamsValue(fndP2_CLIENT_ID,fndP3_CLIENT_ID);  //3.�ͻ�
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID);      //4.����
  fndP3_CUST_TYPE.ItemIndex:=0;                       //5.�ͻ�Ⱥ��
  fndP3_CUST_VALUE.KeyValue:=adoReport2.fieldbyName('REGION_ID').AsString;
  fndP3_CUST_VALUE.Text:=adoReport2.fieldbyName('CODE_NAME').AsString;
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  fndP5_YEAR1.ItemIndex:=fndP4_YEAR1.ItemIndex;          //1.�������
  fndP5_YEAR2.ItemIndex:=fndP4_YEAR2.ItemIndex;
  fndP5_CUST_TYPE.ItemIndex:=fndP4_CUST_TYPE.ItemIndex;  //2.�ͻ�Ⱥ������
  Copy_ParamsValue(fndP4_CUST_VALUE,fndP5_CUST_VALUE);   //  �ͻ�Ⱥ��
  Copy_ParamsValue(fndP4_KPI_ID,fndP5_KPI_ID);           //3.����ָ��
  Copy_ParamsValue(fndP4_DEPT_ID,fndP5_DEPT_ID);           //4.����ָ��
  fndP5_KPI_ID.KeyValue:=adoReport4.fieldbyName('KPI_ID').AsString;  //5.����ָ��
  fndP5_KPI_ID.Text:=adoReport4.fieldbyName('KPI_NAME').AsString;
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmClientKpiReport.SetRzPageActivePage(IsGroupReport: Boolean);
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

procedure TfrmClientKpiReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  inherited;
  if Column.FieldName = 'KPI_NAME' then Text := '�ϼ�:'+Text+'��';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

procedure TfrmClientKpiReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  CalcText: string;
  SetCol: TColumnEh;
begin
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
  if (Column.FieldName='PLAN_AMT') or (Column.FieldName='KPI_AMT') or (Column.FieldName='KPI_RATE') then
  begin
    CalcFooter.GridName:=TDBGridEh(Sender).Name;
    if Column.FieldName = 'PLAN_AMT' then
      CalcFooter.FirValue:=Text
    else if Column.FieldName = 'KPI_AMT' then
      CalcFooter.SecValue:=Text;
    CalcText:=CalcFooter.CalcValue(1);
    if Column.FieldName = 'KPI_RATE' then
      Text:=CalcText
    else
    begin
      SetCol:=FindColumn(TDBGridEh(Sender),'KPI_RATE');
      if (SetCol<>nil) and (SetCol.Footer.Value<>CalcText) then
        SetCol.Footer.Value:=CalcText;
    end;
  end;
end;

function TfrmClientKpiReport.GetDataRight: string;
begin
  //�����ݣ�RCK_C_GOODS_DAYS��VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;


procedure TfrmClientKpiReport.AddYearCBxItemsList(SetCbx: TcxComboBox);
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


function TfrmClientKpiReport.GetKpiResultTab: string;
var
  str,UnitCalc: string;
begin
  //���˽����:
  UnitCalc:=
    '(case when K.UNIT_ID=G.SMALL_UNITS then cast(isnull(G.SMALLTO_CALC,1.0)*1.00 as decimal(18,3)) '+
         ' when K.UNIT_ID=G.BIG_UNITS then cast(isnull(G.BIGTO_CALC,1.0)*1.00 as decimal(18,3)) '+
         ' else 1.0 end)';
  Str:=
    'select '+
    ' D.TENANT_ID as TENANT_ID,'+
    ' D.KPI_ID as KPI_ID,'+
    ' C.KPI_DATA as KPI_DATA,'+
    ' C.FISH_AMT as FISH_AMT,'+
    ' C.FISH_MNY as FISH_MNY,'+
    ' C.KPI_MNY as KPI_MNY,'+
    ' D.WDW_MNY as WDW_MNY,'+
    ' (case when C.KPI_CALC=''2'' then '+UnitCalc+' else 1.0 end)as CalcValue, '+  //�ƻ���
    ' D.REMARK as REMARK,'+   //��ע
    ' D.CREA_DATE as CREA_DATE,'+
    ' D.CREA_USER as CREA_USER,'+
    ' C.KPI_DATE1 as KPI_DATE1,'+
    ' C.KPI_DATE2 as KPI_DATE2 '+
    ' from MKT_KPI_RESULT_LIST C,MKT_KPI_RESULT D,MKT_KPI_GOODS K,VIW_GOODSINFO G '+
    ' where C.TENANT_ID=D.TENANT_ID and C.KPI_YEAR=D.KPI_YEAR and C.KPI_ID=D.KPI_ID and C.CLIENT_ID=D.CLIENT_ID and '+
    ' C.TENANT_ID=K.TENANT_ID and C.GODS_ID=K.GODS_ID and '+
    ' C.TENANT_ID=G.TENANT_ID and C.GODS_ID=G.GODS_ID and '+
    ' C.TENANT_ID='+IntToStr(Global.TENANT_ID);
    
  Result :=ParseSQL(Factor.iDbType,Str);
end;

end.
