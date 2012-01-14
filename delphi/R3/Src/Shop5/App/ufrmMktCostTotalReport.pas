unit ufrmMktCostTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel,uReportFactory, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, RzButton, zBase, cxButtonEdit, zrComboBoxList,
  cxCalendar, zrMonthEdit, ufrmDateControl;

type
  TfrmMktCostTotalReport = class(TframeBaseReport)
    Label3: TLabel;
    rptTemplate: TcxComboBox;
    btnNew: TRzBitBtn;
    btnEdit: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    actTemplate: TAction;
    btnDelete: TRzBitBtn;
    Label13: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_CLIENT_ID: TzrComboBoxList;
    Label14: TLabel;
    fndP1_CUST_VALUE: TzrComboBoxList;
    fndP1_KPI_ID: TzrComboBoxList;
    Label8: TLabel;
    Label10: TLabel;
    fndP1_CUST_TYPE: TcxComboBox;
    Label28: TLabel;
    fndP1_REQU_TYPE: TcxComboBox;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    vBegDate,vEndDate: string;
    REQU_TYPE: integer;
    function  GetCostType: string;  //���ط�������
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    procedure InitalREQ_TYPE;
    function  GetDataRight: string; //��ʼ����������
  public
    { Public declarations }
    Factory: TReportFactory;
    Lock:boolean;
    LCK_Index:integer;
    function  GetCostSQL(chk:boolean=true): string;
    procedure Open(id:string);
    procedure load;
    procedure PrintBefore;override;
    property DataRight: string read GetDataRight;
  end;


implementation

uses
  ufrmDefineReport,ufnUtil,uShopUtil,uCtrlUtil,udsUtil, uGlobal, ObjCommon,
  uShopGlobal, ufrmPrgBar;

{$R *.dfm}

procedure TfrmMktCostTotalReport.btnNewClick(Sender: TObject);
begin
  inherited;
  if TfrmDefineReport.AddReport(self,RF_DATA_SOURCE6,'3','6') then
  begin
    load;
  end;
end;

procedure TfrmMktCostTotalReport.load;
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
    rs.SQL.Text := 'select REPORT_ID,REPORT_NAME from SYS_REPORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_TYPE=''3'' and COMM not in (''02'',''12'') and REPORT_SOURCE=''6'' '+w;
    Factor.Open(rs);
    TdsItems.AddDataSetToItems(rs,rptTemplate.Properties.Items,'REPORT_NAME');
    if rptTemplate.Properties.Items.Count>0 then rptTemplate.ItemIndex := 0;
  finally
    lock := false;
    list.Free;
    rs.Free;
  end;
end;

procedure TfrmMktCostTotalReport.Open(id: string);
begin
  Factory.Open(id,DBGridEh1);
  RefreshColumn;
end;

procedure TfrmMktCostTotalReport.FormCreate(Sender: TObject);
begin
  DoCreateKPIDataSet;
  inherited;
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_CLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  REQU_TYPE:=0;
  //��ʼ�����
  InitalREQ_TYPE;  //��ʼ������List
  TDbGridEhSort.InitForm(self,false);

  Factory := nil;
  load;
  btnNew.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnEdit.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
  btnDelete.Visible := (Global.UserId='system') or (Global.UserId='admin') or (Global.Roles = 'xsm');
end;

procedure TfrmMktCostTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  if Factory<>nil then Factory.Free;
  inherited;
end;

procedure TfrmMktCostTotalReport.actFindExecute(Sender: TObject);
var strSql:string;
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  adoReport1.Close;
  if Factory<>nil then Factory.Free;
  Factory := TReportFactory.Create('6');
  try
    if Factory.DataSet.Active then Factory.DataSet.Close;
    strSql := GetCostSQL;
    if strSql='' then Exit;
    TZQuery(Factory.DataSet).SQL.Text:= strSql;
    frmPrgBar.Show;
    frmPrgBar.Update;
    frmPrgBar.WaitHint := '׼������Դ...';
    frmPrgBar.Precent := 0;

    Factor.Open(TZQuery(Factory.DataSet));
    Open(TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString);
  finally
    frmPrgBar.Close;
  end;
end;

procedure TfrmMktCostTotalReport.btnEditClick(Sender: TObject);
var
  REPORT_ID: string;
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  REPORT_ID:=TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString;
  if TfrmDefineReport.EditReport(self,REPORT_ID,RF_DATA_SOURCE6) then
  begin
    load;
  end;
end;

function TfrmMktCostTotalReport.GetCostSQL(chk: boolean): string;
var
  BondCnd,RequCnd,vTYPE: string;  //��λ�����ϵ
  strSql,strWhere,BondTab,RequTab: widestring;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create('��ѯ������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('��ѯ������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('��ѯ�Ľ������ڲ���С�ڿ�ʼ����...');
  
   //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+' '+DataRight;
  //��������
  vBegDate:=FormatDatetime('YYYYMMDD',P1_D1.Date);
  vEndDate:=FormatDatetime('YYYYMMDD',P1_D2.Date);
  if vBegDate < vEndDate then
  begin
    RequCnd:=' and A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+' ';
    BondCnd:=' and A.BOND_DATE>='+vBegDate+' and A.BOND_DATE<='+vEndDate+' ';
  end else if vBegDate = vEndDate then
  begin
    RequCnd:=' and A.REQU_DATE='+vBegDate+' ';
    BondCnd:=' and A.BOND_DATE='+vBegDate+' ';
  end;
  //��������:�ͻ����˺���Ա����:
  vTYPE:=GetCostType;
  if fndP1_REQU_TYPE.ItemIndex <>0 then
  begin
    case REQU_TYPE of
     1: RequCnd:=' and A.REQU_TYPE='+vTYPE+' ';
     2: BondCnd:=' and A.BOND_TYPE='+vTYPE+' ';
    end;
  end;
  //����ָ��:(�������������)
  if fndP1_KPI_ID.AsString<>'' then
    RequCnd:=RequCnd+' and C.KPI_ID='''+fndP1_KPI_ID.AsString+''' ';
  
  //��������:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+' and A.DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
  //�ͻ�����:
  if fndP1_CLIENT_ID.AsString<>'' then
    strWhere:=strWhere+' and A.CLIENT_ID='''+fndP1_CLIENT_ID.AsString+''' ';

  //�ͻ�Ⱥ��������������|�ͻ��ȼ�\�ͻ�����:
  if (fndP1_CUST_VALUE.AsString<>'') then
  begin
    case fndP1_CUST_TYPE.ItemIndex of
     0:
       begin
         if FnString.TrimRight(trim(fndP1_CUST_VALUE.AsString),2)='00' then  //��ĩ������
           strWhere:=strWhere+' and D.REGION_ID like '''+GetRegionId(fndP1_CUST_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and D.REGION_ID='''+fndP1_CUST_VALUE.AsString+''' ';
       end;
     1: strWhere:=strWhere+' and D.PRICE_ID='''+fndP1_CUST_VALUE.AsString+''' ';   //�ȼ�
     2: strWhere:=strWhere+' and D.SORT_ID='''+fndP1_CUST_VALUE.AsString+''' ';    //����
     3: strWhere:=strWhere+' and D.FLAG='+fndP1_CUST_VALUE.AsString+' ';           //�ͻ�Ⱥ��
    end;
  end;

  //��������:
  RequTab:=
    'select '+
    ' A.TENANT_ID as TENANT_ID,'+       //1.��ҵID
    ' A.SHOP_ID as SHOP_ID,'+           //2.�ŵ�
    ' A.REQU_DATE as REQU_DATE,'+       //3.��������
    ' A.CLIENT_ID,'+
    ' isnull(D.CLIENT_NAME,''�������ͻ�'')as CLIENT_ID_TEXT,'+  //�ͻ�����
    ' D.CLIENT_CODE as CLIENT_CODE,'+
    ' D.REGION_ID as CREGION_ID,'+      //�ͻ���������
    ' D.REGION_ID as CREGION_ID1,'+     //�ͻ���������
    ' D.REGION_ID as CREGION_ID2,'+     //�ͻ���������
    ' A.DEPT_ID as DEPT_ID,'+           //4.����ID
    ' C.KPI_ID as KPI_ID,'+             //5.����ID
    ' A.REQU_USER as GUIDE_USER,'+      //6.���ID
    ' B.KPI_YEAR as REQU_YEAR,'+        //7.�������
    //' A.REQU_TYPE as REQU_TYPE,'+     //8.��������
    ' (case when (A.REQU_TYPE=''1'') then C.KPI_MNY else 0.00 end)as REQU1_MNY,'+             //9. �г�����:�ܽ��
    ' (case when (A.REQU_TYPE=''2'') then C.KPI_MNY else 0.00 end)as REQU2_MNY,'+             //10.�г�����:�ܽ��
    ' (case when (A.REQU_TYPE=''1'') then C.WDW_MNY else 0.00 end)as REQU1_ALL_SL,'+          //11.�г�����:��������
    ' (case when (A.REQU_TYPE=''2'') then C.WDW_MNY else 0.00 end)as REQU2_ALL_SL,'+          //12.�г�����:��������
    ' (case when (A.REQU_TYPE=''1'') then C.KPI_MNY-C.WDW_MNY else 0.00 end)as REQU1_JY,'+    //13.�г�����:������
    ' (case when (A.REQU_TYPE=''2'') then C.KPI_MNY-C.WDW_MNY else 0.00 end)as REQU2_JY,'+    //14.�г�����:������
    ' (case when (A.REQU_TYPE=''1'') and (A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+') then A.REQU_MNY else 0.00 end) as REQU1_NEW_SL,'+  //15.���ڷ������
    ' (case when (A.REQU_TYPE=''2'') and (A.REQU_DATE>='+vBegDate+' and A.REQU_DATE<='+vEndDate+') then A.REQU_MNY else 0.00 end) as REQU2_NEW_SL '+  //16.���ڼ�����
    ' from MKT_REQUORDER A,MKT_REQUDATA B,MKT_KPI_RESULT C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.REQU_ID=B.REQU_ID and B.TENANT_ID=C.TENANT_ID and B.KPI_ID=C.KPI_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID  '+strWhere+RequCnd+' ';
  //��֤������
  BondTab:=
    'select '+
    ' A.TENANT_ID as TENANT_ID,'+         //1.��ҵID
    ' A.SHOP_ID as SHOP_ID,'+             //2.�ŵ�ID
    ' A.BOND_DATE as REQU_DATE,'+         //2.��������
    ' A.CLIENT_ID,'+
    ' isnull(D.CLIENT_NAME,''�������ͻ�'')as CLIENT_ID_TEXT,'+  //�ͻ�����
    ' D.CLIENT_CODE as CLIENT_CODE,'+
    ' D.REGION_ID as CREGION_ID,'+        //�ͻ���������
    ' D.REGION_ID as CREGION_ID1,'+       //�ͻ���������
    ' D.REGION_ID as CREGION_ID2,'+       //�ͻ���������
    ' A.DEPT_ID as DEPT_ID,'+             //4.����ID
    ' '' '' as KPI_ID,'+                  //5.����ID
    ' A.BOND_USER as GUIDE_USER,'+        //6.���ID
    ' substr(C.CREA_DATE,1,4) as REQU_YEAR,'+  //7.�������
    //' A.BOND_TYPE as REQU_TYPE,'+            //8.��������
    ' (case when (A.BOND_TYPE=''1'') then C.BOND_MNY else 0.00 end)as BOND1_MNY,'+             //9. ��֤��:�ܽ��
    ' (case when (A.BOND_TYPE=''2'') then C.BOND_MNY else 0.00 end)as BOND2_MNY,'+             //10.���汣֤��:�ܽ��
    ' (case when (A.BOND_TYPE=''1'') then C.BOND_RET else 0.00 end)as BOND1_ALL_SL,'+          //11.��֤��:��������
    ' (case when (A.BOND_TYPE=''2'') then C.BOND_RET else 0.00 end)as BOND2_ALL_SL,'+          //12.���汣֤��:��������
    ' (case when (A.BOND_TYPE=''1'') then C.BOND_MNY-C.BOND_RET else 0.00 end)as BOND1_JY,'+    //13. ��֤��:������
    ' (case when (A.BOND_TYPE=''2'') then C.BOND_MNY-C.BOND_RET else 0.00 end)as BOND2_JY,'+    //14. ���汣֤��:������
    ' (case when (A.BOND_TYPE=''1'') and (A.BOND_DATE>='+vBegDate+' and A.BOND_DATE<='+vEndDate+') then A.BOND_MNY else 0.00 end) as BOND1_NEW_SL,'+  //15.���ڷ������
    ' (case when (A.BOND_TYPE=''2'') and (A.BOND_DATE>='+vBegDate+' and A.BOND_DATE<='+vEndDate+') then A.BOND_MNY else 0.00 end) as BOND2_NEW_SL '+  //16.���ڼ�����
    ' from MKT_BONDORDER A,MKT_BONDDATA B,STK_INDENTORDER C,VIW_CUSTOMER D '+
    ' where A.TENANT_ID=B.TENANT_ID and A.BOND_ID=B.BOND_ID and B.TENANT_ID=C.TENANT_ID and B.FROM_ID=C.INDE_ID and '+
    ' A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+strWhere+BondCnd+' ';

  //���SQL
  case REQU_TYPE of
   0: strSql:=RequTab+' union all '+BondTab;
   1: strSql:=RequTab;
   2: strSql:=BondTab;
  end;

  strSql:=
    'select '+
    ' K.*, '+
    ' MKT.KPI_NAME as KPI_ID_TEXT,'+    
    '(case when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''1'') then ''�ϰ���'' '+
         ' when (MKT.KPI_TYPE=''1'') and (OP.KPI_LV=''2'') then ''�°���'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''1'') then ''��һ����'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''2'') then ''�ڶ�����'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''3'') then ''��������'' '+
         ' when (MKT.KPI_TYPE=''2'') and (OP.KPI_LV=''4'') then ''���ļ���'' '+
         ' else '' '' end)as KPI_LV,'+  //��������
    ' SHOP.SHOP_NAME as SHOP_ID_TEXT '+
    ' from ('+strSql+')K '+
    ' left outer join MKT_KPI_INDEX MKT on K.TENANT_ID=MKT.TENANT_ID and K.KPI_ID=MKT.KPI_ID '+
    ' left outer join (select KPI_ID,KPI_LV from MKT_KPI_OPTION where TENANT_ID='+InttoStr(Global.TENANT_ID)+') OP on K.KPI_ID=OP.KPI_ID '+
    ' left outer join CA_SHOP_INFO SHOP on K.TENANT_ID=SHOP.TENANT_ID and K.SHOP_ID=SHOP.SHOP_ID ';
  result:=ParseSQL(Factor.iDbType,strSql);    
end;

procedure TfrmMktCostTotalReport.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if rptTempLate.ItemIndex<0 then Exit;
  if TfrmDefineReport.DeleteReport(self,TRecord_(rptTempLate.Properties.Items.Objects[rptTempLate.ItemIndex]).FieldbyName('REPORT_ID').AsString,RF_DATA_SOURCE4) then
  begin
    load;
  end;
end;

procedure TfrmMktCostTotalReport.PrintBefore;
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

function TfrmMktCostTotalReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+TcxDateEdit(FindCmp1).Text+' �� '+TcxDateEdit(FindCmp2).Text);
    
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmMktCostTotalReport.InitalREQ_TYPE;
var
  AObj: TRecord_;
  Rs: TZQuery;
begin
  try
    fndP1_REQU_TYPE.Properties.Items.Clear;
    Rs:=TZQuery.Create(nil);
    Rs.Close;
    Rs.SQL.Text:='select CODE_ID,CODE_NAME,TYPE_CODE from PUB_PARAMS where TYPE_CODE in (''REQU_TYPE'',''BOND_TYPE'')';
    Factor.Open(Rs);
    Rs.First;
    fndP1_REQU_TYPE.Properties.Items.Add('ȫ��'); 
    while not Rs.Eof do
    begin
      AObj:=TRecord_.Create;
      AObj.ReadFromDataSet(Rs);
      fndP1_REQU_TYPE.Properties.Items.AddObject(trim(AObj.fieldByName('CODE_NAME').AsString),AObj);
      Rs.Next;
    end;
    if fndP1_REQU_TYPE.Properties.Items.Count>0 then  
      fndP1_REQU_TYPE.ItemIndex:=0;
  finally
    Rs.Free;
  end;
end;

function TfrmMktCostTotalReport.GetCostType: string;
var
  vOBj: TRecord_;
begin
  case fndP1_REQU_TYPE.ItemIndex of
   0:
    begin
      REQU_TYPE:=0;
      result:='0';
    end;
   else
    begin
      vOBj:=TRecord_(fndP1_REQU_TYPE.Properties.Items.Objects[fndP1_REQU_TYPE.ItemIndex]);
      if trim(vOBj.FieldByName('TYPE_CODE').AsString)='REQU_TYPE' then
        REQU_TYPE:=1
      else
        REQU_TYPE:=2;
      result:=trim(vOBj.FieldByName('CODE_ID').AsString);
    end;
  end;
end;

function TfrmMktCostTotalReport.GetDataRight: string;
begin
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.
