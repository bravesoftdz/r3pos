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
    IsOnDblClick: Boolean;  //��˫��DBGridEh���λ
    SortName: string; //��ʱ����
    sid5:string;
    srid5:string;
    procedure SetUnitIDList(DBGrid: TDBGridEh; ColName: string);
    //������̨��:
    procedure CheckCalc(EndDate: integer); //��ʼ�·�| �����·�
    //�������տ���ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //���ŵ��տ���ܱ�
    function GetShopSQL(chk:boolean=true): string;
    //�����ڷ�����ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //����Ʒ�տ���ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    function GetGlideSQL(chk:boolean=true): string;

    //�����ѯ�������ֵ���ڣ�����̨�ʱ������������
    function GetRckMaxDate(EndDate: integer): Integer;
    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //�����ŵ��ѯ����
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //ʱ������
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string; //�ŵ�������������|�ŵ�����:
    //��ʼ��DBGrid
    procedure InitGrid;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    function GetDataRight: string; //���ز鿴����Ȩ��  
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  DataRight: string read GetDataRight; //���ز鿴����Ȩ��
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

  SetRzPageActivePage; //����PzPage.Activepage
  fndP5_CREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');

  //���ӵ�λ��ʾ��
  SetUnitIDList(DBGridEh5,'UNIT_ID');

  InitGrid;
  RefreshColumn;

  {2011.08.25 ����DataRight��ر�
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

  //Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh5, ['COST_MONEY','PROFIT_MONEY','PROFIT_RATE','AVG_PROFIT']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label12.Caption := '�ֿ�Ⱥ��';
      Label3.Caption := '�ֿ�����';

      Label28.Caption := '�ֿ�Ⱥ��';
      Label17.Caption := '�ֿ�����';
    end;

  //2011.09.22 Add ǧ��λ��
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
  if P1_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ��ܴ��ڿ�ʼ����');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));
  //���Լ�����̨��:
  CheckCalc(EndDate);
  //����֮������ȡ̨�ʱ������ֵ
  MaxDate:=GetRckMaxDate(EndDate);
  //�����������ŵ����:
  ViwSql:=
     'select A.TENANT_ID,B.REGION_ID as REGION_ID,A.SHOP_ID as SHOP_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,'+
     'sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P1_D1,P1_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,B.REGION_ID,A.SHOP_ID ';

  //̨�˱�
  RCKRData:=
    'select TENANT_ID,SHOP_ID,isnull(TRN_OUT_MNY,0)-isnull(TRN_IN_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS '+
    ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' '+' '+ShopGlobal.GetDataRight('SHOP_ID',1);

  //����
  strSql:=
    'select j.REGION_ID as REGION_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY,sum(TRN_MNY) as TRN_MNY, sum(BAL_MNY) as TRN_REST_MNY from '+
    '('+ViwSql+') j '+
    ' left outer join ('+RCKRData+')c on j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID group by j.REGION_ID ';
    
  strSql:=
    'select jp.*,isnull(r.CODE_NAME,''��'') as CODE_NAME from  ('+strSql+') jp '+
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
    0: begin //���������ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���ŵ���ܱ�
        if adoReport2.Active then adoReport2.Close;
        strSql := GetShopSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //��������ܱ�
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //����Ʒ���ܱ�
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
  if P2_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('�������ڲ��ܴ��ڿ�ʼ����');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));
  //���Լ�����̨��:
  CheckCalc(EndDate);
  //����֮������ȡ̨�ʱ������ֵ
  MaxDate:=GetRckMaxDate(EndDate);
  //�����������ŵ����:
  ViwSql:=
     'select A.TENANT_ID,A.SHOP_ID as SHOP_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,'+
     ' sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J, sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P2_D1,P2_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.SHOP_ID ';

  //̨�˱�
  RCKRData:=
    'select TENANT_ID,SHOP_ID,isnull(TRN_OUT_MNY,0)-isnull(TRN_IN_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS '+
    ' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' '+' '+ShopGlobal.GetDataRight('SHOP_ID',1);
  //����
  strSql:=
    'select j.*,TRN_MNY,BAL_MNY as TRN_REST_MNY from ('+ViwSql+') j left outer join ('+RCKRData+')c '+
    ' on j.TENANT_ID=c.TENANT_ID and j.SHOP_ID=c.SHOP_ID ';

  //�����ŵ�
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
  if P3_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('�������ڲ��ܴ��ڿ�ʼ����');
  EndDate:=strtoInt(FormatDatetime('YYYYMMDD',P1_D2.Date));

  //���Լ�����̨��:
  CheckCalc(EndDate);
  //�����������ŵ��ѯ:
  ViwSql:=
     'select A.RECV_DATE as RECV_DATE,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P3_D1,P3_D2,'RECV_DATE')+
     ' '+GetShopIDCnd(fndP3_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'')+' '+
     ' group by A.RECV_DATE ';

  //̨�˱�
  RCKRData:=
    'select CREA_DATE,isnull(sum(TRN_OUT_MNY),0)-isnull(sum(TRN_IN_MNY),0) as TRN_MNY,sum(BAL_MNY) as BAL_MNY '+
    ' from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('SHOP_ID',1)+
    ' '+GetDateCnd(P3_D1,P3_D2,'CREA_DATE')+' and SHOP_ID<>''#'' group by CREA_DATE ';

  //����
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
  if P4_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ��ܴ��ڿ�ʼ����');

  //�����������ŵ��ѯ:
  ViwSql:=
     'select a.TENANT_ID as TENANT_ID,A.CREA_USER as CREA_USER,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RCKDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight+
     ' '+GetDateCnd(P4_D1,P4_D2,'RECV_DATE')+
     ' '+GetShopIDCnd(fndP4_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'')+
     ' group by A.TENANT_ID,A.CREA_USER ';

  //����Ա���һ�����Ǯ
  RMNYData:=
    'select AA.TENANT_ID,AA.CREA_USER as CREA_USER,max(isnull(BALANCE,0)) as BALANCE from ACC_CLOSE_FORDAY AA, '+
    ' (select max(CLSE_DATE) as CLSE_DATE,TENANT_ID,CREA_USER from ACC_CLOSE_FORDAY where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+' group by TENANT_ID,CREA_USER) BB '+
    ' where AA.TENANT_ID=BB.TENANT_ID and AA.CREA_USER=BB.CREA_USER and AA.CLSE_DATE=BB.CLSE_DATE and '+
    ' AA.TENANT_ID='+inttostr(Global.TENANT_ID)+' and AA.CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+
    ' '+ShopGlobal.GetDataRight('AA.SHOP_ID',1)+
    ' group by AA.TENANT_ID,AA.CREA_USER';
  //����
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
  IsOnDblClick:=true; //���ñ��λ
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
  IsOnDblClick:=true; //���ñ��λ
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
  IsOnDblClick:=true; //���ñ��λ
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
        if Rs.Locate('CODE_ID',ColName,[]) then  //��λ���޸�: Title.Caption
          Grid.Columns[i].Title.Caption:='����|'+rs.FieldbyName('CODE_NAME').AsString
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
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
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
      //����
      FindCmp1:=FindComponent('P'+PageNo+'_D1');
      FindCmp2:=FindComponent('P'+PageNo+'_D2');
      if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
         (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
        TitleList.add('�տ����ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
    end;
   4:
    begin
      //����
      FindCmp1:=FindComponent('P'+PageNo+'_D1');
      FindCmp2:=FindComponent('P'+PageNo+'_D2');
      if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
         (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
        TitleList.add('�������ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
      if trim(fndP5_CREA_USER.Text)<>'' then
        TitleList.add('����Ա��'+trim(fndP5_CREA_USER.Text));
      {if fndP5_POSMAIN.Checked then
        TitleList.add('�������ͣ�'+trim(fndP5_POSMAIN.Caption))
      else if fndP5_SALEORDER.Checked then
        TitleList.add('�������ͣ�'+trim(fndP5_SALEORDER.Caption))
      else if fndP5_SALRETU.Checked then
        TitleList.add('�������ͣ�'+trim(fndP5_SALRETU.Caption));}
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
         if FnString.TrimRight(trim(TYPE_VALUE.AsString),2)='00' then //��ĩ������
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
    IsOnDblClick:=False; //���ñ��λ
    Exit; //����˫���[DBGridEh������ѯ��������̨��]
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
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmRckDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmRckDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'RECV_DATE' then Text := '�ϼ�:'+Text+'��';   
end;

procedure TfrmRckDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'USER_NAME' then Text := '�ϼ�:'+Text+'��';   
end;

function TfrmRckDayReport.GetGlideSQL(chk: boolean): string;
var
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //��������:
  if fndP5_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP5_SALES_TYPE.Properties.Items.Objects[fndP5_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //�ŵ�����:
  if fndP5_SHOP_ID.AsString<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

  //GodsID��Ϊ�գ�
  //if trim(GodsID)<>'' then
  //  strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  //�·�����:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' '
  else
    Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //�ŵ�������������|�ŵ�����:
  if (fndP5_SHOP_VALUE.AsString<>'') then
    begin
      case fndP5_SHOP_TYPE.ItemIndex of
        0:
         begin
           if FnString.TrimRight(trim(fndP5_SHOP_VALUE.AsString),2)='00' then //��ĩ������
             strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP5_SHOP_VALUE.AsString)+'%'' '
           else
             strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
         end;
        1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
      end;
    end;

  //��Ʒָ��:
  if (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP5_TYPE_ID)+'='''+fndP5_STAT_ID.AsString+''' ';
  end;
  //��Ʒ����:
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

  //2011.05.11 Add ��������:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP5_DEPT_ID.AsString+''' ';

  //����Ա
  if Trim(fndP5_CREA_USER.Text) <> '' then
    strWhere := strWhere + ' and A.CREA_USER='''+fndP5_CREA_USER.AsString+''' ';

  if fndP5_SALEORDER.Checked then //���۵�:1
    strWhere := strWhere+' and SALES_TYPE=1 '
  else if fndP5_POSMAIN.Checked then //���۵�:4
    strWhere := strWhere+' and SALES_TYPE=4 '
  else if fndP5_SALRETU.Checked then //�����˻�:3
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
    ',A.ORG_PRICE as APRICE '+   //����ʱ��ɱ���
    ',A.CALC_MONEY as AMONEY '+ 
    ',A.NOTAX_MONEY '+  //����˰
    ',A.TAX_MONEY '+    //˰��
    ',A.AGIO_MONEY '+   //�ۿ۽��
    ',A.AGIO_RATE '+    //�ۿ��ʣ������ʣ�
    ',A.COST_MONEY '+   //���۳ɱ�
    ',A.NOTAX_MONEY-A.COST_MONEY as PROFIT_MONEY'+  //ë�� = ����˰���-���۳ɱ�
    ',(case when A.NOTAX_MONEY<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/cast(A.NOTAX_MONEY as decimal(18,3)) else 0 end) as PROFIT_RATE '+  //����˰���-���۳ɱ�
    ',(case when A.NOTAX_MONEY*A.AMOUNT<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/A.AMOUNT else 0 end) as AVG_PROFIT'+    //--��λë��
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
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
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
  Copy_ParamsValue('SHOP_TYPE',4,5); //����Ⱥ��
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID);  //�ŵ�����
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

