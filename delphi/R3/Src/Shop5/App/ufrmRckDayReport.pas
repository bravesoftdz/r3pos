unit ufrmRckDayReport;

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
  private
    IsOnDblClick: Boolean;  //��˫��DBGridEh���λ
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

    //�����ѯ�������ֵ���ڣ�����̨�ʱ������������
    function GetRckMaxDate(EndDate: integer): Integer;
    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //�����ŵ��ѯ����
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //ʱ������
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string; //�ŵ�������������|�ŵ�����:
    //��ʼ��DBGrid
    procedure InitGrid;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon,
  ufrmCostCalc;
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

  SetRzPageActivePage; //����PzPage.Activepage

  InitGrid;
  RefreshColumn;
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
     'select B.REGION_ID as REGION_ID,A.SHOP_ID as SHOP_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,'+
     'sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RECVALLDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P1_D1,P1_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'')+' '+
     ' group by B.REGION_ID,A.SHOP_ID ';

  //̨�˱�
  RCKRData:='select SHOP_ID,isnull(TRN_IN_MNY,0)-isnull(TRN_OUT_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' ';
  //����
  strSql:=
    'select j.REGION_ID as REGION_ID,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY,sum(TRN_MNY) as TRN_MNY, sum(BAL_MNY) as TRN_REST_MNY from '+
    '('+ViwSql+') j left outer join ('+RCKRData+')c on j.SHOP_ID=c.SHOP_ID group by j.REGION_ID ';
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
var strSql: string;
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
     ' sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J, sum(RECV_MNY) as RECV_MNY from VIW_RECVALLDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P2_D1,P2_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.SHOP_ID ';

  //̨�˱�
  RCKRData:='select TENANT_ID,SHOP_ID,isnull(TRN_IN_MNY,0)-isnull(TRN_OUT_MNY,0) as TRN_MNY,BAL_MNY from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CREA_DATE='+InttoStr(MaxDate)+' and SHOP_ID<>''#'' ';
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
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RECVALLDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P3_D1,P3_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'')+' '+
     ' group by A.RECV_DATE ';

  //̨�˱�
  RCKRData:='select CREA_DATE,isnull(sum(TRN_IN_MNY),0)-isnull(sum(TRN_OUT_MNY),0) as TRN_MNY,sum(BAL_MNY) as BAL_MNY from RCK_ACCT_DAYS where TENANT_ID='+inttostr(Global.TENANT_ID)+' '+GetDateCnd(P3_D1,P3_D2,'CREA_DATE')+' and SHOP_ID<>''#'' group by CREA_DATE ';
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
  strSql,strWhere,ViwSql,RMNYData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('�տ�������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ��ܴ��ڿ�ʼ����');

  //�����������ŵ��ѯ:
  ViwSql:=
     'select a.TENANT_ID as TENANT_ID,A.CREA_USER as CREA_USER,sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,sum(PAY_F) as PAY_F,'+
     ' sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J,sum(RECV_MNY) as RECV_MNY from VIW_RECVALLDATA A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P4_D1,P4_D2,'RECV_DATE')+
     ' '+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'')+
     ' group by A.TENANT_ID,A.CREA_USER ';

  //����Ա���һ�����Ǯ
  RMNYData:=
    ' select AA.CREA_USER as CREA_USER,isnull(BALANCE,0) as BALANCE from ACC_CLOSE_FORDAY AA, '+
    '(select max(CLSE_DATE) as CLSE_DATE,CREA_USER from ACC_CLOSE_FORDAY where CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+' group by CREA_USER) BB '+
    ' where AA.CREA_USER=BB.CREA_USER and AA.CLSE_DATE=BB.CLSE_DATE and AA.CLSE_DATE<='+FormatDatetime('YYYYMMDD',P4_D2.Date)+' ';
  //����
  strSql:=
    'select jc.*,u.ACCOUNT as ACCOUNT,u.USER_NAME as USER_NAME from'+
    ' (select j.*,BALANCE from ('+ViwSql+')j '+
    '  left outer join ('+RMNYData+')c on j.CREA_USER=c.CREA_USER)jc '+
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
var
  CurDate: string;
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true; //���ñ��λ
  CurDate:=trim(adoReport3.fieldbyName('RECV_DATE').AsString);
  CurDate:=Copy(CurDate,1,4)+'-'+Copy(CurDate,5,2)+'-'+Copy(CurDate,7,2);
  P4_D1.Date:=StrtoDate(CurDate);
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
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('�տ����ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

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
      0: result:=' and '+AName+'REGION_ID='''+TYPE_VALUE.AsString+''' ';
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
    rs.SQL.Text := 'select count(*) from RCK_ACCT_DAYS where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CREA_DATE').AsInteger := EndDate;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
    //  TfrmCostCalc.TryCalcDayAcct(self);
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

end.

