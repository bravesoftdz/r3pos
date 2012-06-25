unit ufrmCustCardReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup,
  ufrmDateControl, Buttons;

type
  TfrmCustCardReport = class(TframeBaseReport)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    dsadoReport2: TDataSource;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    adoReport2: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    Label23: TLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    Label3: TLabel;
    fndP1_KEY_TYPE: TcxComboBox;
    fndP1_KEY_VALUE: TcxTextEdit;
    Label6: TLabel;
    Label7: TLabel;
    fndP1_IC_TYPE: TcxComboBox;
    GroupBox1: TGroupBox;
    P1_CB_2: TCheckBox;
    P1_CB_3: TCheckBox;
    P1_CB_4: TCheckBox;
    P1_CB_1: TCheckBox;
    Label8: TLabel;
    fndP1_IC_STATUS: TcxComboBox;
    Label9: TLabel;
    fndP1_SHOP_ID: TzrComboBoxList;
    Label4: TLabel;
    fndP2_SHOP_ID: TzrComboBoxList;
    Label10: TLabel;
    fndP2_IC_TYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    //���ػ�Ա����ϸ�˲�ѯ
    function GetCustCardDetailSQL: string;
    //���ػ�Ա����ϸ�˲�ѯ
    function GetCustCardSumSQL: string;

    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    //����Page��ҳ��ʾ:��IsGroupReport�Ƿ����[�����ŵ�]��
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function  GetDataRight: string;
  public
    procedure SingleReportParams(ParameStr: string='');override; //�򵥱�����ò���
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property DataRight: string read GetDataRight; //���ز鿴����Ȩ��
  end;

const
  ArySumField: Array[0..5] of string=('SALE_AMT','SALE_TTL','SALE_TAX','SALE_MNY','SALE_CST','SALE_ALLPRF');
  
implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmCustCardReport.FormCreate(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_DateControl.StartDateControl := P1_D1;
  P1_DateControl.EndDateControl := P1_D2;

  P2_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P2_DateControl.StartDateControl := P2_D1;
  P2_DateControl.EndDateControl := P2_D2;
  fndP1_KEY_TYPE.ItemIndex:=0;

  //���ÿ�����
  AddCBxItemsList(fndP1_IC_TYPE,'IC_TYPE',true);
  fndP1_IC_TYPE.ItemIndex:=0;
  //���ÿ�״̬
  AddCBxItemsList(fndP1_IC_STATUS,'IC_STATUS',true);
  fndP1_IC_STATUS.ItemIndex:=0;
  //���ÿ�����
  AddCBxItemsList(fndP2_IC_TYPE,'IC_TYPE',true);
  fndP2_IC_TYPE.ItemIndex:=0;


  SetRzPageActivePage; //����PzPage.Activepage
  RefreshColumn;
 
  if ShopGlobal.GetProdFlag = 'E' then
  begin
    Label5.Caption := '�ֿ�Ⱥ��';
    Label23.Caption := '�ֿ�Ⱥ��';
  end; 

  //2011.09.21 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.ID_REG','DBGridEh1.ID_SAL','DBGridEh1.IC_BAL']);
end;

function TfrmCustCardReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmCustCardReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
   0:
     begin //��Ա����ϸ�˱���
       if adoReport1.Active then adoReport1.Close;
       strSql := GetCustCardDetailSQL;
       if strSql='' then Exit;
       adoReport1.SQL.Text:= strSql;
       Factor.Open(adoReport1);
     end;
    1:
     begin //��Ա��ͳ��
       if adoReport2.Active then adoReport2.Close;
       strSql := GetCustCardSumSQL;
       if strSql='' then Exit;
       adoReport2.SQL.Text:= strSql;
       Factor.Open(adoReport2);
     end;
  end;
end;

procedure TfrmCustCardReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmCustCardReport.PrintBefore;
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
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmCustCardReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  TypeName: string;
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
  begin
    case RzPage.ActivePageIndex of
     0: TitleList.add('��ѯ���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
     1: TitleList.add('ͳ�����ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
    end;
  end;
  
  //��ѯ������
  FindCmp1:=FindComponent('fndP'+PageNo+'_IC_TYPE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
  begin
    TitleList.add('�� �� �ͣ�'+TcxComboBox(FindCmp1).Text);
  end;
  //��������
  if RzPage.ActivePageIndex=0 then
  begin
    FindCmp1:=FindComponent('fndP'+PageNo+'_IC_STATUS');
    if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
    begin
      TitleList.add('�� ״ ̬��'+TcxComboBox(FindCmp1).Text);
    end;
    TypeName:='';
    if P1_CB_1.Checked then TypeName:='��ֵ';
    if P1_CB_2.Checked then
    begin
      if TypeName='' then TypeName:='�˿�' else TypeName:=TypeName+'\��ֵ';
    end;
    if P1_CB_3.Checked then
    begin
      if TypeName='' then TypeName:='����' else TypeName:=TypeName+'\����';
    end;
    if P1_CB_4.Checked then
    begin
      if TypeName='' then TypeName:='֧��' else TypeName:=TypeName+'\֧��';
    end;
    TitleList.add('��ѯ���ͣ�'+TypeName);
    if fndP1_KEY_VALUE.Text<>'' then
      TitleList.add('��ѯ['+fndP1_KEY_TYPE.Text+']=('+fndP1_KEY_VALUE.Text+')');
  end;  

  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmCustCardReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'IC_CARD_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmCustCardReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'IC_DATE' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmCustCardReport.SetRzPageActivePage(IsGroupReport: Boolean);
begin
  //
end;

procedure TfrmCustCardReport.SingleReportParams(ParameStr: string);
begin

end;

function TfrmCustCardReport.GetDataRight: string;
begin
  //�����ݣ�RCK_C_GOODS_DAYS��VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('B.SHOP_ID',1);
end;

function TfrmCustCardReport.GetCustCardDetailSQL: string;
var
  CardSumTab: string;
  CardCnd,LikeCnd,DateCnd: string;
  CzStr: string;
  TkStr: string;
  SaleStr: string;
  PayStr: string;
  ViwTab: string;
  i: integer;
begin
  i:=0;
  if P1_D1.EditValue = null then Raise Exception.Create('��ʼ������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('��ʼ������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  if (not P1_CB_1.Checked) and (not P1_CB_2.Checked) and (not P1_CB_3.Checked) and (not P1_CB_4.Checked) then
    Raise Exception.Create(' ��ѡ���ѯ����... '); 
  //�����ܵ�Viw
  if trim(fndP1_SHOP_ID.AsString)<>'' then
  begin
    CardSumTab:=
      'select '+
        'CLIENT_ID,'+
        'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
        'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
      ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' group by CLIENT_ID ';
  end else
  begin
    CardSumTab:=
      'select '+
        'CLIENT_ID,'+
        'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
        'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
      ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' group by CLIENT_ID ';
  end;
  
  LikeCnd:='';
  CardCnd:=' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+GetDataRight;
  //�ŵ�Ⱥ��
  if trim(fndP1_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
     0:
      begin
        if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //��ĩ������
          CardCnd:=CardCnd+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
        else
          CardCnd:=CardCnd+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
     1: CardCnd:=CardCnd+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //�ŵ�����
  if trim(fndP1_SHOP_ID.AsString)<>'' then
    CardCnd:=CardCnd+' and B.SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
  //������
  if fndP1_IC_TYPE.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_TYPE='''+TRecord_(fndP1_IC_TYPE.Properties.Items.Objects[fndP1_IC_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';
  //��״̬
  if fndP1_IC_STATUS.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_STATUS='''+TRecord_(fndP1_IC_STATUS.Properties.Items.Objects[fndP1_IC_STATUS.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';
  if trim(fndP1_KEY_VALUE.Text)<>'' then
  begin
    LikeCnd:='''%'+fndP1_KEY_VALUE.Text+'%'' ';
    case fndP1_KEY_TYPE.ItemIndex of
      0:  //ȫ��:��Ա���ţ��ͻ����룬�ͻ����ƣ�֤���ţ��ֻ��ţ��칫�绰����ͥ�绰
       begin
         LikeCnd:=' and ((C.IC_CARDNO like '+LikeCnd+') or (A.CUST_CODE like '+LikeCnd+') or (A.CUST_NAME like '+LikeCnd+') or (C.CUST_SPELL like '+LikeCnd+') or '+
                       ' (C.ID_NUMBER like '+LikeCnd+') or (A.MOVE_TELE like '+LikeCnd+') or (A.OFFI_TELE like '+LikeCnd+') or (A.FAMI_TELE like '+LikeCnd+')) ';
       end;
      1: LikeCnd:=' and (C.IC_CARDNO like '+LikeCnd+')'; //��Ա����
      2: LikeCnd:=' and (C.CUST_CODE like '+LikeCnd+')'; //�ͻ�����
      3: LikeCnd:=' and (C.CUST_NAME like '+LikeCnd+')'; //�ͻ�����
      4: LikeCnd:=' and (C.CUST_SPELL like '+LikeCnd+')'; //�ͻ�ƴ����
      5: LikeCnd:=' and (C.ID_NUMBER like '+LikeCnd+')'; //֤����
      6: LikeCnd:=' and (C.MOVE_TELE like '+LikeCnd+')'; //�ֻ���
      7: LikeCnd:=' and (C.OFFI_TELE like '+LikeCnd+')'; //�칫�绰
      8: LikeCnd:=' and (C.FAMI_TELE like '+LikeCnd+')'; //��ͥ�绰
    end;
  end;
  CardCnd:=CardCnd+' '+LikeCnd;

  if P1_CB_1.Checked then //��ֵ����
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    CzStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //�����ܶ�
       ',E.IC_SAL as IC_SAL'+   //�����ܶ�
       ',C.BALANCE as IC_BAL'+  //�������
       ',C.IC_STATUS as IC_STATUS'+   //IC��״̬
       ',C.IC_TYPE as IC_TYPE'+       //IC������
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //�ܻ���
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //ʹ�û���
       ',C.INTEGRAL as IC_INTEGRAL'+     //���û���
       ',''1'' as CX_TYPE'+    //��ѯ����
       ','' '' as BILL_NUM'+     //���ݺ�
       ',D.GLIDE_MNY as IC_MONEY'+     //���ݽ��
       ',D.GLIDE_INFO as IC_INFO'+    //ժҪ(��ע)
       ',A.OFFI_TELE as OFFI_TELE'+   //��ϵ�绰
       ',A.MOVE_TELE as MOVE_TELE'+   //�ֻ�
       ',D.CREA_USER as CREA_USER'+   //���ݲ���Ա
       ',B.SHOP_NAME as SHOP_NAME  '+ //�����ŵ�
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''1'' and D.GLIDE_MNY>=0 '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_2.Checked then //�˿�����
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    TkStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //�����ܶ�
       ',E.IC_SAL as IC_SAL'+   //�����ܶ�
       ',C.BALANCE as IC_BAL'+  //�������
       ',C.IC_STATUS as IC_STATUS'+   //IC��״̬
       ',C.IC_TYPE as IC_TYPE'+       //IC������
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //�ܻ���
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //ʹ�û���
       ',C.INTEGRAL as IC_INTEGRAL'+     //���û���
       ',''2'' as CX_TYPE'+    //��ѯ����
       ','' '' as BILL_NUM'+     //���ݺ�
       ',D.GLIDE_MNY as IC_MONEY'+     //���ݽ��
       ',D.GLIDE_INFO as IC_INFO'+    //ժҪ(��ע)
       ',A.OFFI_TELE as OFFI_TELE'+   //��ϵ�绰
       ',A.MOVE_TELE as MOVE_TELE'+   //�ֻ�
       ',D.CREA_USER as CREA_USER'+   //���ݲ���Ա
       ',B.SHOP_NAME as SHOP_NAME  '+ //�����ŵ�
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''1'' and D.GLIDE_MNY<0 '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_3.Checked then //��������
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.SALES_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.SALES_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.SALES_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    SaleStr:=
      'select '+
       ' D.SALES_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //�����ܶ�
       ',E.IC_SAL as IC_SAL'+   //�����ܶ�
       ',C.BALANCE as IC_BAL'+  //�������
       ',C.IC_STATUS as IC_STATUS'+   //IC��״̬
       ',C.IC_TYPE as IC_TYPE'+       //IC������
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //�ܻ���
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //ʹ�û���
       ',C.INTEGRAL as IC_INTEGRAL'+     //���û���
       ',''3'' as CX_TYPE'+    //��ѯ����
       ',D.GLIDE_NO as BILL_NUM'+     //���ݺ�
       ',D.SALE_MNY as IC_MONEY'+     //���ݽ��
       ','' '' as IC_INFO '+          //ժҪ
       ',A.OFFI_TELE as OFFI_TELE'+   //��ϵ�绰
       ',A.MOVE_TELE as MOVE_TELE'+   //�ֻ�
       ',D.CREA_USER as CREA_USER'+   //���ݲ���Ա
       ',B.SHOP_NAME as SHOP_NAME  '+ //�����ŵ�
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_SALESORDER D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.SALES_TYPE in (''1'',''3'',''4'') '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_4.Checked then //�˿�����
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    PayStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //�����ܶ�
       ',E.IC_SAL as IC_SAL'+   //�����ܶ�
       ',C.BALANCE as IC_BAL'+  //�������
       ',C.IC_STATUS as IC_STATUS'+   //IC��״̬
       ',C.IC_TYPE as IC_TYPE'+       //IC������
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //�ܻ���
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //ʹ�û���
       ',C.INTEGRAL as IC_INTEGRAL'+     //���û���
       ',''4'' as CX_TYPE'+    //��ѯ����
       ','' '' as BILL_NUM'+     //���ݺ�
       ',D.GLIDE_MNY as IC_MONEY'+     //���ݽ��
       ',D.GLIDE_INFO as IC_INFO'+    //ժҪ(��ע)
       ',A.OFFI_TELE as OFFI_TELE'+   //��ϵ�绰
       ',A.MOVE_TELE as MOVE_TELE'+   //�ֻ�
       ',D.CREA_USER as CREA_USER'+   //���ݲ���Ա
       ',B.SHOP_NAME as SHOP_NAME  '+ //�����ŵ�
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''2'' '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if i>1 then
  begin
    ViwTab:='';
    if (P1_CB_1.Checked) and (trim(CzStr)<>'') then
      ViwTab:=CzStr;
    if (P1_CB_2.Checked) and (trim(TkStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=TkStr
      else
        ViwTab:=ViwTab + ' union all '+ TkStr;
    end;
    if (P1_CB_3.Checked) and (trim(SaleStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=SaleStr
      else
        ViwTab:=ViwTab + ' union all '+ SaleStr;
    end;
    if (P1_CB_4.Checked) and (trim(PayStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=PayStr
      else
        ViwTab:=ViwTab + ' union all '+ PayStr;
    end;   
    result:='select * from ('+ViwTab+')tp order by IC_CARDNO';
  end else
  begin
    if P1_CB_1.Checked then
      result:=CzStr+' order by C.IC_CARDNO'
    else if P1_CB_2.Checked then
      result:=TkStr+' order by C.IC_CARDNO'
    else if P1_CB_3.Checked then
      result:=SaleStr+' order by C.IC_CARDNO'
    else if P1_CB_4.Checked then
      result:=PayStr+' order by C.IC_CARDNO';
  end;
  result:=ParseSQL(Factor.iDbType,result);
end;

function TfrmCustCardReport.GetCustCardSumSQL: string;
var
  DateCnd: string;    
  SumTab: string;
  CardCnd: string;
  CardSumTab: string;
begin
  DateCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('��ʼ������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('��ʼ������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������
  CardCnd:=' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+GetDataRight;

  //�ŵ�����
  if trim(fndP2_SHOP_ID.AsString)<>'' then
    DateCnd:=' and SHOP_ID='''+trim(fndP2_SHOP_ID.AsString)+''' ';
  
  if P1_D1.Date = P1_D2.Date then   
  begin
    CardCnd:=CardCnd+' and C.CREA_DATE='''+FormatDatetime('YYYY-MM-DD',P2_D1.Date)+''' ';
    DateCnd:=DateCnd+' and CREA_DATE='+FormatDatetime('YYYYMMDD',P2_D1.Date);
  end else
  begin
    CardCnd:=CardCnd+' and (C.CREA_DATE>='''+FormatDatetime('YYYY-MM-DD',P2_D1.Date)+''' and CREA_DATE<='''+FormatDatetime('YYYY-MM-DD',P2_D2.Date)+''')';
    DateCnd:=DateCnd+' and (CREA_DATE>='+FormatDatetime('YYYYMMDD',P2_D1.Date)+' and CREA_DATE<='+FormatDatetime('YYYYMMDD',P2_D2.Date)+')';
  end;

  //�����ܵ�Viw
  CardSumTab:=
    'select CLIENT_ID,'+
      'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
      'sum(isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_D,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0))as IC_SHISHOU,'+
      'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
    ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+DateCnd+' group by CLIENT_ID ';
  CardSumTab:=ParseSQL(Factor.iDbType,CardSumTab);

  //�ŵ�Ⱥ��
  if trim(fndP2_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
     0:
      begin
        if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //��ĩ������
          CardCnd:=CardCnd+' and B.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
        else
          CardCnd:=CardCnd+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
      end;
     1: CardCnd:=CardCnd+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //�ŵ�����
  if trim(fndP2_SHOP_ID.AsString)<>'' then
    CardCnd:=CardCnd+' and B.SHOP_ID='''+trim(fndP2_SHOP_ID.AsString)+''' ';
  //������
  if fndP1_IC_TYPE.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_TYPE='''+TRecord_(fndP1_IC_TYPE.Properties.Items.Objects[fndP1_IC_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //��SQL:
  SumTab:=
    'select C.TENANT_ID,C.IC_TYPE as IC_TYPE '+    //������
     ',C.UNION_ID as UNION_ID '+       //���˱��<�������˿�ʱ��Ϊ#>
     ',count(*) as IC_CARD_AMT '+      //��������
     ',sum(E.IC_REG) as IC_IN_MNY '+   //������
     ',sum(E.IC_SHISHOU) as IC_SHI_MNY '+  //ʵ�ս��
     ',sum(E.IC_REG-E.IC_SHISHOU) as IC_AGO_MNY '+   //�Żݽ��
     ',sum(E.IC_SAL) as IC_SAL_MNY '+   //���ѽ��
    ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,('+CardSumTab+')E '+
    ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and '+
    ' C.CLIENT_ID=E.CLIENT_ID '+CardCnd+
    ' group by C.TENANT_ID,C.IC_TYPE,C.UNION_ID ';
  //������ѯ
  SumTab:=
    'select (case when tp.UNION_ID<>''#'' then UN.UNION_NAME else CT.CODE_NAME end) as IC_CARD_NAME,'+
    ' tp.* from ('+SumTab+')tp '+
    ' left outer join PUB_UNION_INFO UN on tp.TENANT_ID=UN.TENANT_ID and tp.UNION_ID=UN.UNION_ID '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''IC_TYPE'')CT on tp.IC_TYPE=CT.CODE_ID '+
    ' order by tp.IC_TYPE,UN.UNION_NAME';

  result:=ParseSQL(Factor.iDbType,SumTab);
end;

end.
