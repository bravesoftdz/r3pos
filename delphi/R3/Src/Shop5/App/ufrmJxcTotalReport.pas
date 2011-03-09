unit ufrmJxcTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList,
  zrMonthEdit, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmJxcTotalReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    Label6: TLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnOk: TRzBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel9: TRzPanel;
    Label10: TLabel;
    Label13: TLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label14: TLabel;
    Label15: TLabel;
    fndP2_GROUP_LIST: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    Label9: TLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    Label19: TLabel;
    Label20: TLabel;
    fndP3_SHOP_ID: TzrComboBoxList;
    RzBitBtn2: TRzBitBtn;
    fndP3_TYPE_ID: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    Label21: TLabel;
    Label24: TLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    Label25: TLabel;
    Label26: TLabel;
    RzBitBtn3: TRzBitBtn;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    RzPanel15: TRzPanel;
    DBGridEh4: TDBGridEh;
    fndP4_SHOP_ID: TzrComboBoxList;
    dsadoReport4: TDataSource;
    P1_D1: TzrMonthEdit;
    P1_D2: TzrMonthEdit;
    P2_D2: TzrMonthEdit;
    P2_D1: TzrMonthEdit;
    P3_D2: TzrMonthEdit;
    P3_D1: TzrMonthEdit;
    P4_D2: TzrMonthEdit;
    P4_D1: TzrMonthEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    fndP2_GROUP_ID: TcxComboBox;
    Label5: TLabel;
    fndP1_GROUP_ID: TcxComboBox;
    fndP1_GROUP_LIST: TzrComboBoxList;
    Label11: TLabel;
    fndP3_GROUP_LIST: TzrComboBoxList;
    fndP3_GROUP_ID: TcxComboBox;
    Label3: TLabel;
    fndP4_GROUP_LIST: TzrComboBoxList;
    fndP4_GROUP_ID: TcxComboBox;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP2_TYPE_IDPropertiesChange(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure actPriorExecute(Sender: TObject);
    procedure fndP4_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP4_GROUP_IDPropertiesChange(Sender: TObject);
    procedure fndP2_GROUP_IDPropertiesChange(Sender: TObject);
    procedure fndP1_GROUP_IDPropertiesChange(Sender: TObject);
    procedure fndP3_GROUP_IDPropertiesChange(Sender: TObject);
  private
    sid1,sid2,sid4:string;
    srid1,srid2,srid4:string;
    groupid1,groupid2,groupid3,groupid4: string;  //����Ⱥ��ID
    procedure CheckCalc(b, e:integer); //��ʼ�·�| �����·�
     //���������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //���ŵ����ۻ��ܱ�
    function GetCompanySQL(chk:boolean=true): string;
    //���������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //����Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    //����Ʒ��ˮ�ʻ��ܱ�
    function GetGlideSQL(chk: boolean=true): string;
    
    //���봰���ǳ�ʼ����Ӧ����Items����
    procedure InitialParams;
    function  GetUnitIDIdx: integer; //���ص�ǰ����ͳ�Ƶ�λ
  public
    { Public declarations }
    HasChild:boolean;
    procedure CreateGrid;
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  UnitIDIdx: integer read GetUnitIDIdx; //��ǰͳ�Ƽ�����ʽ    
  end;

implementation
uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, ufrmSelectGoodSort, ufrmCostCalc;
{$R *.dfm}

procedure TfrmJxcTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);

  //��ʼ��Items��������:
  self.InitialParams;

  {
  HasChild := (ShopGlobal.GetADODataSetFromName('CA_COMPANY').RecordCount>1);
  rzPage.Pages[0].TabVisible := HasChild;
  rzPage.Pages[1].TabVisible := HasChild;
  if not HasChild then
    rzPage.ActivePageIndex := 2
  else
    rzPage.ActivePageIndex := 0;
  }
  CreateGrid;
  RefreshColumn;
end;

function TfrmJxcTotalReport.GetGroupSQL(chk:boolean=true): string;
var
  rs: TZQuery;
  strSql,strWhere,GoodTab,
  CalcFields,UnitField: string;
begin
  result:='';
  strWhere:='';
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  //�·�����:
  strWhere:=GetCxDate('and', 'MONTH', P1_D1, P1_D2);
  //�ŵ�Ⱥ��:
  strWhere:=strWhere+GetShopGroupCnd(fndP1_GROUP_ID,fndP1_GROUP_LIST.AsString,'RCK_GOODS_MONTH','and');
  //��Ʒָ��:
  strWhere:=strWhere+GetGoodSortTypeCnd(fndP1_TYPE_ID,fndP1_STAT_ID.AsString,'RCK_GOODS_MONTH','and');
  //��Ʒ����:
  if (trim(sid1)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and ('+GetLikeCnd(Factor.iDbType,'B.LEVEL_ID',sid1,'','R',false)+' and B.RELATION_ID='''+srid1+''')';
  end else
    GoodTab:='VIW_GOODSINFO'; 

  if chk then
     CheckCalc(strtoInt(P1_D1.asString),StrtoInt(P1_D2.asString));

  //��ǰͳ�Ƶ�λ:
  UnitField:=GetUnitID(UnitIDIdx,'B');
  CalcFields:='('+GetUnitTO_CALC(UnitIDIdx,'B')+')'; //[ͳ�Ƶ�λIndex,��ѯ�����,�ֶα���]

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
         'select REGION_ID '+ //�ŵ��������

         'from RCK_GOODS_MONTH A,'+GoodTab+' B,CA_COMPANY C ' +

      end;
    3: begin //Access

      end;
  end;
  Result := strSql;
end;

function TfrmJxcTotalReport.GetRowType: integer;
begin
  result := DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmJxcTotalReport.actFindExecute(Sender: TObject);
var
  strSql: string;
  rs:TADODataSet;
begin
  case rzPage.ActivePageIndex of
    0:begin //���������ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���ŵ���ܱ�
        if adoReport2.Active then adoReport2.Close;
        strSql := GetCompanySQL;
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

procedure TfrmJxcTotalReport.fndP1_TYPE_IDPropertiesChange(Sender: TObject);
begin
  AddGoodSortTypeItemsList(Sender,fndP1_GROUP_LIST);
end;

function TfrmJxcTotalReport.GetCompanySQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs: TZQuery;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  rs := Global.GetZQueryFromName('CA_COMPANY');

  //if not rs.Locate('COMP_ID',Global.CompanyID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');

  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //��������
  {
  if fndP2_GROUP_ID.AsString <> '' then
  strWhere := strWhere + ' and isnull(C.GROUP_NAME,''#'') in (select CODE_ID from PUB_CODE_INFO where CODE_TYPE=8 and CODE_ID like '+QuotedStr(fndP2_GROUP_ID.AsString + '%')+')';

  //�ŵ�����
  case fndP2_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+Global.CompanyID+''' and COMP_TYPE=2) or COMP_ID='''+Global.CompanyID+''')';
  end;

  if chk then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select C.* from CA_COMPANY C where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',fnTime.fnStrtoDate(P2_D2.asString+'01')))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER where PRINT_ID<=' + QuotedStr(P5_D2.asString+'31')+') b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where substring(PRINT_DATE,1,7)<>'+QuotedStr(formatDatetime('YYYY-MM',fnTime.fnStrtoDate(P2_D2.asString+'01')))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  
  //�·�����
  strWhere := strWhere + ' and A.PRINT_DATE>=' + QuotedStr(P2_D1.asString+'-01')+ ' and A.PRINT_DATE<=' + QuotedStr(P2_D2.asString+'-31');
  //��Ʒ����
  if trim(fndP2_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid2 + '%')+')';
  //��Ʒָ��
  if (fndP2_TYPE_ID.ItemIndex = 0) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP2_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP2_TYPE_ID.ItemIndex = 1) and (fndP2_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP2_STAT_ID.AsString);
  //�����Ʒ
  if not fndP2_SHOW.Checked then
     strWhere := strWhere + ' and B.GODS_TYPE <> 2';

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select C.COMP_ID' +
          ',sum(case when substring(PRINT_ID,1,6)='''+P2_D1.asString+''' then ORG_AMOUNT else 0 end/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as ORG_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P2_D1.asString+''' then ORG_AMONEY else 0 end) as ORG_AMONEY ' + //--�ڳ����

          ',sum(IN_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as IN_AMOUNT ' + //--��������
          ',sum(IN_AMONEY) as IN_AMONEY ' + //--�������
          ',sum(IN_TAX) as IN_TAX ' + //--����˰��
          ',sum(IN_NOTAX) as IN_NOTAX ' + //--��������˰

          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as SAL_AMOUNT ' + //--��������
          ',sum(SAL_AMONEY) as SAL_AMONEY ' + //--���۽��
          ',sum(SAL_TAX) as SAL_TAX ' + //--����˰��
          ',sum(SAL_NOTAX) as SAL_NOTAX ' + //--���۲���˰
          ',sum(SAL_COST) as SAL_COST ' + //--���۳ɱ�
          ',sum(SAL_PROFIT) as SAL_PROFIT ' + //--����ë��

          ',sum(COMB_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as COMB_AMOUNT ' + //--��ж����
          ',sum(COMB_AMONEY) as COMB_AMONEY ' + //--��ж���

          ',sum(MOVEIN_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEIN_AMOUNT ' + //--��������
          ',sum(MOVEIN_AMONEY) as MOVEIN_AMONEY ' + //--������

          ',sum(MOVEOUT_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEOUT_AMOUNT ' + //--��������
          ',sum(MOVEOUT_AMONEY) as MOVEOUT_AMONEY ' + //--�������

          ',sum(PARM1_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM1_AMOUNT ' + //--PARM1����
          ',sum(PARM1_AMONEY) as PARM1_AMONEY ' + //--PARM1���

          ',sum(PARM2_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM2_AMOUNT ' + //--PARM2����
          ',sum(PARM2_AMONEY) as PARM2_AMONEY ' + //--PARM2���

          ',sum(PARM3_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM3_AMOUNT ' + //--PARM3����
          ',sum(PARM3_AMONEY) as PARM3_AMONEY ' + //--PARM3���

          ',sum(PARM4_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM4_AMOUNT ' + //--PARM4����
          ',sum(PARM4_AMONEY) as PARM4_AMONEY ' + //--PARM4���

          ',sum(PARM5_AMOUNT/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM5_AMOUNT ' + //--PARM5����
          ',sum(PARM5_AMONEY) as PARM5_AMONEY ' + //--PARM5���

          ',sum(case when substring(PRINT_ID,1,6)='''+P2_D2.asString+''' then RCK_AMOUNT else 0 end/case ' + InttoStr(fndP2_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as RCK_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P2_D2.asString+''' then RCK_AMONEY else 0 end) as RCK_AMONEY ' + //--�ڳ����

          ',grouping(C.COMP_ID) as grp0 '+  //�б�ʶ
          'from VIW_PRINTDATA A,VIW_GOODSINFO B,CA_COMPANY C ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +
          ' group by C.COMP_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(SAL_NOTAX,0)=0 then null else SAL_PROFIT/SAL_NOTAX*100 end as PROFIT_RATE,'+ //ë����
          'case when J.grp0<>1 then IsNull(G.COMP_NAME,''δ����'') else ''��   ��'' end as COMP_NAME from ('+strSQL+') j '+
          'left outer join CA_COMPANY g on j.COMP_ID=g.COMP_ID order by j.grp0 desc,g.SEQ_NO';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;

  }  
end;

procedure TfrmJxcTotalReport.fndP2_TYPE_IDPropertiesChange(Sender: TObject);
begin
  AddGoodSortTypeItemsList(Sender,fndP2_GROUP_LIST);
end;

function TfrmJxcTotalReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs: TZQuery;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  rs := Global.GetZQueryFromName('CA_COMPANY');
  if fndP3_SHOP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.SHOP_ID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP3_SHOP_ID.AsString,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //�ŵ�����
{  case fndP3_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID='''+fndP3_SHOP_ID.AsString+'''';
  1:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+fndP3_SHOP_ID.AsString+''' and COMP_TYPE=2) or COMP_ID='''+fndP3_SHOP_ID.AsString+''')';
  end;

  if chk then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select C.* from CA_COMPANY C where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',fnTime.fnStrtoDate(P3_D2.asString+'01')))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER where PRINT_ID<=' + QuotedStr(P5_D2.asString+'31')+') b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where substring(PRINT_DATE,1,7)<>'+QuotedStr(formatDatetime('YYYY-MM',fnTime.fnStrtoDate(P3_D2.asString+'01')))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //�·�����
  strWhere := strWhere + ' and A.PRINT_DATE>=' + QuotedStr(P3_D1.asString+'-01')+ ' and A.PRINT_DATE<=' + QuotedStr(P3_D2.asString+'-31');
  //��Ʒ���༶��
  strSQL := 'select SORT_ID,LEVEL_ID from PUB_GOODSSORT where SORT_TYPE<='+inttostr(fndP3_SORT_ID.ItemIndex+1)+
            ' union all '+
            'select null as SORT_ID,'''' as LEVEL_ID ';
  //��Ʒָ��
  if (fndP3_TYPE_ID.ItemIndex = 0) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP3_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP3_TYPE_ID.ItemIndex = 1) and (fndP3_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP3_STAT_ID.AsString);
  //�����Ʒ
  if not fndP3_SHOW.Checked then
     strWhere := strWhere + ' and B.GODS_TYPE <> 2';

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select s.SORT_ID,case when isnull(s.SORT_ID,'''')='''' then 1 else 0 end as grp0,sum(ORG_AMOUNT) as ORG_AMOUNT,sum(ORG_AMONEY) as ORG_AMONEY,'+
          'sum(IN_AMOUNT) as IN_AMOUNT,sum(IN_AMONEY) as IN_AMONEY,sum(IN_NOTAX) as IN_NOTAX,sum(IN_TAX) as IN_TAX,'+
          'sum(SAL_AMOUNT) as SAL_AMOUNT,sum(SAL_AMONEY) as SAL_AMONEY,sum(SAL_NOTAX) as SAL_NOTAX,sum(SAL_TAX) as SAL_TAX,sum(SAL_COST) as SAL_COST,sum(SAL_PROFIT) as SAL_PROFIT,'+
          'sum(MOVEIN_AMOUNT) as MOVEIN_AMOUNT,sum(MOVEIN_AMONEY) as MOVEIN_AMONEY,sum(MOVEOUT_AMOUNT) as MOVEOUT_AMOUNT,sum(MOVEOUT_AMONEY) as MOVEOUT_AMONEY,'+
          'sum(COMB_AMOUNT) as COMB_AMOUNT,sum(COMB_AMONEY) as COMB_AMONEY,'+
          'sum(PARM1_AMOUNT) as PARM1_AMOUNT,sum(PARM1_AMONEY) as PARM1_AMONEY,'+
          'sum(PARM2_AMOUNT) as PARM2_AMOUNT,sum(PARM2_AMONEY) as PARM2_AMONEY,'+
          'sum(PARM3_AMOUNT) as PARM3_AMOUNT,sum(PARM3_AMONEY) as PARM3_AMONEY,'+
          'sum(PARM4_AMOUNT) as PARM4_AMOUNT,sum(PARM4_AMONEY) as PARM4_AMONEY,'+
          'sum(PARM5_AMOUNT) as PARM5_AMOUNT,sum(PARM5_AMONEY) as PARM5_AMONEY '+
          'from ('+strSQL+') s left outer join ('+
          'select D.LEVEL_ID' +
          ',sum(case when substring(PRINT_ID,1,6)='''+P3_D1.asString+''' then ORG_AMOUNT else 0 end/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as ORG_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P3_D1.asString+''' then ORG_AMONEY else 0 end) as ORG_AMONEY ' + //--�ڳ����

          ',sum(IN_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as IN_AMOUNT ' + //--��������
          ',sum(IN_AMONEY) as IN_AMONEY ' + //--�������
          ',sum(IN_TAX) as IN_TAX ' + //--����˰��
          ',sum(IN_NOTAX) as IN_NOTAX ' + //--��������˰

          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as SAL_AMOUNT ' + //--��������
          ',sum(SAL_AMONEY) as SAL_AMONEY ' + //--���۽��
          ',sum(SAL_TAX) as SAL_TAX ' + //--����˰��
          ',sum(SAL_NOTAX) as SAL_NOTAX ' + //--���۲���˰
          ',sum(SAL_COST) as SAL_COST ' + //--���۳ɱ�
          ',sum(SAL_PROFIT) as SAL_PROFIT ' + //--����ë��

          ',sum(COMB_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as COMB_AMOUNT ' + //--��ж����
          ',sum(COMB_AMONEY) as COMB_AMONEY ' + //--��ж���

          ',sum(MOVEIN_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEIN_AMOUNT ' + //--��������
          ',sum(MOVEIN_AMONEY) as MOVEIN_AMONEY ' + //--������

          ',sum(MOVEOUT_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEOUT_AMOUNT ' + //--��������
          ',sum(MOVEOUT_AMONEY) as MOVEOUT_AMONEY ' + //--�������

          ',sum(PARM1_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM1_AMOUNT ' + //--PARM1����
          ',sum(PARM1_AMONEY) as PARM1_AMONEY ' + //--PARM1���

          ',sum(PARM2_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM2_AMOUNT ' + //--PARM2����
          ',sum(PARM2_AMONEY) as PARM2_AMONEY ' + //--PARM2���

          ',sum(PARM3_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM3_AMOUNT ' + //--PARM3����
          ',sum(PARM3_AMONEY) as PARM3_AMONEY ' + //--PARM3���

          ',sum(PARM4_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM4_AMOUNT ' + //--PARM4����
          ',sum(PARM4_AMONEY) as PARM4_AMONEY ' + //--PARM4���

          ',sum(PARM5_AMOUNT/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM5_AMOUNT ' + //--PARM5����
          ',sum(PARM5_AMONEY) as PARM5_AMONEY ' + //--PARM5���

          ',sum(case when substring(PRINT_ID,1,6)='''+P3_D2.asString+''' then RCK_AMOUNT else 0 end/case ' + InttoStr(fndP3_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as RCK_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P3_D2.asString+''' then RCK_AMONEY else 0 end) as RCK_AMONEY ' + //--�ڳ����

          'from VIW_PRINTDATA A,VIW_GOODSINFO B,CA_COMPANY C,PUB_GOODSSORT D ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.SORT_ID=D.SORT_ID and B.COMP_ID='''+Global.CompanyId+'''  ' + StrWhere +' group by D.LEVEL_ID) js on s.LEVEL_ID=substring(js.LEVEL_ID,1,len(s.LEVEL_ID)) '+
          ' group by s.SORT_ID';
        strSql :=
          'select j.*,'+
          'case when IsNull(SAL_NOTAX,0)=0 then null else SAL_PROFIT/SAL_NOTAX*100 end as PROFIT_RATE,'+ //ë����
          'case when J.grp0<>1 then space((g.SORT_TYPE-1)*2)+IsNull(G.SORT_NAME,''δ����'') else ''��   ��'' end as SORT_NAME,g.LEVEL_ID from ('+strSQL+') j '+
          'left outer join PUB_GOODSSORT g on j.SORT_ID=g.SORT_ID order by j.grp0 desc,g.LEVEL_ID';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;

  }

end;

function TfrmJxcTotalReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,strWhere,lvid: string;
  rs: TZQuery;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  rs := Global.GetZQueryFromName('CA_COMPANY');
  if fndP4_SHOP_ID.AsString='' then
     begin
        if not rs.Locate('COMP_ID',Global.SHOP_ID,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end
  else
     begin
        if not rs.Locate('COMP_ID',fndP4_SHOP_ID.AsString,[]) then Raise Exception.Create('�ŵ�����û�ҵ�...');
     end;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  strWhere := ' and C.COMP_ID in (select COMP_ID from VIW_COMPRIGHT where USER_ID='''+Global.UserId+''') and C.LEVEL_ID like '+QuotedStr(lvid + '%');
  //�ŵ�����
{
  case fndP4_COMP_TYPE.ItemIndex of
  0:strWhere := strWhere + ' and C.COMP_ID='''+fndP4_SHOP_ID.AsString+'''';
  1:strWhere := strWhere + ' and C.COMP_ID in (select COMP_ID from CA_COMPANY where (UPCOMP_ID='''+fndP4_SHOP_ID.AsString+''' and COMP_TYPE=2) or COMP_ID='''+fndP4_SHOP_ID.AsString+''')';
  end;
  if chk then
  begin
    rs := TADODataSet.Create(nil);
    try
      rs.CommandText :=
         'select * from ('+
         'select j.COMP_ID,COMP_NAME,isnull(max(PRINT_DATE),''δ����'') as PRINT_DATE from (select C.* from CA_COMPANY C where COMP_ID in (select COMP_ID from SYS_DEFINE where DEFINE=''USING_DATE'' and VALUE<='+QuotedStr(formatDatetime('YYYY-MM-31',fnTime.fnStrtoDate(P4_D2.asString+'01')))+') '+strWhere+ ') j '+
         'left outer join (select * from STO_PRINTORDER where PRINT_ID<=' + QuotedStr(P5_D2.asString+'31')+') b '+
         'on j.COMP_ID=b.COMP_ID group by j.COMP_ID,COMP_NAME) j where substring(PRINT_DATE,1,7)<>'+QuotedStr(formatDatetime('YYYY-MM',fnTime.fnStrtoDate(P4_D2.asString+'01')))+' or PRINT_DATE=''δ����''';
      Factor.Open(rs);
      if not TfrmShowReckInfo.ShowReck(self,rs) then Exit;
    finally
      rs.Free;
    end;
  end;
  //�·�����
  strWhere := strWhere + ' and A.PRINT_DATE>=' + QuotedStr(P4_D1.asString+'-01')+ ' and A.PRINT_DATE<=' + QuotedStr(P4_D2.asString+'-31');
  //��Ʒ����
  if trim(fndP4_SORT_ID.Text)<>'' then
     strWhere := strWhere + ' and B.SORT_ID in (select SORT_ID from PUB_GOODSSORT where LEVEL_ID like '+QuotedStr(sid4 + '%')+')';
  //��Ʒָ��
  if (fndP4_TYPE_ID.ItemIndex = 0) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.PROVIDE = '+QuotedStr(fndP4_STAT_ID.AsString);
  //��Ʒָ��
  if (fndP4_TYPE_ID.ItemIndex = 1) and (fndP4_STAT_ID.AsString<>'') then
     strWhere := strWhere + ' and B.BRAND = '+QuotedStr(fndP4_STAT_ID.AsString);
  //�����Ʒ
  if not fndP4_SHOW.Checked then
     strWhere := strWhere + ' and B.GODS_TYPE <> 2';

  case Factor.iDbType of
    0: begin //SqlServer
        strSql :=
          'select A.GODS_ID' +
          ',sum(case when substring(PRINT_ID,1,6)='''+P4_D1.asString+''' then ORG_AMOUNT else 0 end/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as ORG_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P4_D1.asString+''' then ORG_AMONEY else 0 end) as ORG_AMONEY ' + //--�ڳ����

          ',sum(IN_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as IN_AMOUNT ' + //--��������
          ',sum(IN_AMONEY) as IN_AMONEY ' + //--�������
          ',sum(IN_TAX) as IN_TAX ' + //--����˰��
          ',sum(IN_NOTAX) as IN_NOTAX ' + //--��������˰

          ',sum(SAL_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as SAL_AMOUNT ' + //--��������
          ',sum(SAL_AMONEY) as SAL_AMONEY ' + //--���۽��
          ',sum(SAL_TAX) as SAL_TAX ' + //--����˰��
          ',sum(SAL_NOTAX) as SAL_NOTAX ' + //--���۲���˰
          ',sum(SAL_COST) as SAL_COST ' + //--���۳ɱ�
          ',sum(SAL_PROFIT) as SAL_PROFIT ' + //--����ë��

          ',sum(COMB_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as COMB_AMOUNT ' + //--��ж����
          ',sum(COMB_AMONEY) as COMB_AMONEY ' + //--��ж���

          ',sum(MOVEIN_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEIN_AMOUNT ' + //--��������
          ',sum(MOVEIN_AMONEY) as MOVEIN_AMONEY ' + //--������

          ',sum(MOVEOUT_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as MOVEOUT_AMOUNT ' + //--��������
          ',sum(MOVEOUT_AMONEY) as MOVEOUT_AMONEY ' + //--�������

          ',sum(PARM1_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM1_AMOUNT ' + //--PARM1����
          ',sum(PARM1_AMONEY) as PARM1_AMONEY ' + //--PARM1���

          ',sum(PARM2_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM2_AMOUNT ' + //--PARM2����
          ',sum(PARM2_AMONEY) as PARM2_AMONEY ' + //--PARM2���

          ',sum(PARM3_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM3_AMOUNT ' + //--PARM3����
          ',sum(PARM3_AMONEY) as PARM3_AMONEY ' + //--PARM3���

          ',sum(PARM4_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM4_AMOUNT ' + //--PARM4����
          ',sum(PARM4_AMONEY) as PARM4_AMONEY ' + //--PARM4���

          ',sum(PARM5_AMOUNT/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as PARM5_AMOUNT ' + //--PARM5����
          ',sum(PARM5_AMONEY) as PARM5_AMONEY ' + //--PARM5���

          ',sum(case when substring(PRINT_ID,1,6)='''+P4_D2.asString+''' then RCK_AMOUNT else 0 end/case ' + InttoStr(fndP4_UNIT_ID.ItemIndex) + ' when 0 then 1.0 when 1 then case when IsNull(B.SMALLTO_CALC,0)=0 then 1.0 else IsNull(B.SMALLTO_CALC,0) end ' +
          'when 2 then case when IsNull(B.BIGTO_CALC,0)=0 then 1.0 else IsNull(B.BIGTO_CALC,0) end else 1.0 end) as RCK_AMOUNT ' + //--�ڳ�����
          ',sum(case when substring(PRINT_ID,1,6)='''+P4_D2.asString+''' then RCK_AMONEY else 0 end) as RCK_AMONEY ' + //--�ڳ����

          ',grouping(A.GODS_ID) as grp0 '+  //�б�ʶ
          'from VIW_PRINTDATA A,VIW_GOODSINFO B,CA_COMPANY C ' +
          'where A.GODS_ID=B.GODS_ID and A.COMP_ID=C.COMP_ID and B.COMP_ID='''+Global.CompanyId+''' ' + StrWhere +
          ' group by A.GODS_ID with rollup';
        strSql :=
          'select j.*,'+
          'case when IsNull(SAL_NOTAX,0)=0 then null else SAL_PROFIT/SAL_NOTAX*100 end as PROFIT_RATE,'+ //ë����
          'case when J.grp0<>1 then IsNull(G.GODS_NAME,''δ����'') else ''��   ��'' end as GODS_NAME,G.GODS_CODE from ('+strSQL+') j '+
          'left outer join (select GODS_ID,GODS_NAME,GODS_CODE from VIW_GOODSINFO where COMP_ID='''+Global.CompanyId+''') g on j.GODS_ID=g.GODS_ID order by j.grp0 desc,g.GODS_CODE';
      end;
    3: begin //Access

      end;
  end;
  Result := strSql;

  }
end;

function TfrmJxcTotalReport.GetGlideSQL(chk:boolean=true): string;
begin

end;

procedure TfrmJxcTotalReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.asString := P1_D1.asString;
  P2_D2.asString := P1_D2.asString;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  sid2 := sid1;
  fndP2_TYPE_ID.ItemIndex := fndP1_TYPE_ID.ItemIndex;
  fndP2_STAT_ID.KeyValue := fndP1_STAT_ID.KeyValue;
  fndP2_STAT_ID.Text := fndP1_STAT_ID.Text;
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex;
  if adoReport1.FieldbyName('grp0').AsInteger = 1 then
  fndP2_GROUP_ID.Text := '' else
  fndP2_GROUP_ID.Text := adoReport1.FieldbyName('GROUP_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmJxcTotalReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.asString := P2_D1.asString;
  P3_D2.asString := P2_D2.asString;
  fndP3_TYPE_ID.ItemIndex := 0;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;
 
  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('COMP_ID').AsString;
  if adoReport2.FieldbyName('grp0').AsInteger = 1 then
  fndP3_SHOP_ID.Text := '' else
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('COMP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);

end;

procedure TfrmJxcTotalReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  P4_D1.asString := P3_D1.asString;
  P4_D2.asString := P3_D2.asString;
  fndP4_TYPE_ID.ItemIndex := fndP3_TYPE_ID.ItemIndex;
  fndP4_STAT_ID.Text := fndP4_STAT_ID.Text;
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_SHOP_ID.KeyValue := fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text := fndP3_SHOP_ID.Text;
  sid4 := adoReport3.FieldbyName('LEVEL_ID').AsString;
  if adoReport3.FieldbyName('grp0').AsInteger = 1 then
  fndP4_SORT_ID.Text := '' else
  fndP4_SORT_ID.Text := adoReport3.FieldbyName('SORT_NAME').AsString;
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);

end;

procedure TfrmJxcTotalReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmJxcTotalReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;

{  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '�·ݣ�'+P1_D1.asString+' �� '+P1_D2.asString;
      if fndP1_GROUP_ID <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP1_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '���ѡ�����ʾ�����������Ʒ';
           inc(c);
         end;
      if trim(fndP1_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP1_SORT_ID.Text;
           inc(c);
         end;
      if fndP1_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP1_TYPE_ID.Text+'��'+fndP1_STAT_ID.Text;
           inc(c);
         end;
      if fndP1_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP1_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  1:begin
      c := 0;
      inc(c);
      s := '�·ݣ�'+P2_D1.asString+' �� '+P2_D2.asString;
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP2_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '���ѡ�����ʾ�����������Ʒ';
           inc(c);
         end;
      if trim(fndP2_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP2_SORT_ID.Text;
           inc(c);
         end;
      if fndP2_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP2_TYPE_ID.Text+'��'+fndP2_STAT_ID.Text;
           inc(c);
         end;
      if fndP2_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP2_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  2:begin
      c := 0;
      inc(c);
      s := '�·ݣ�'+P3_D1.asString+' �� '+P3_D2.asString;
      if fndP3_SHOP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP3_SHOP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP3_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '���ѡ�����ʾ�����������Ʒ';
           inc(c);
         end;
      if trim(fndP3_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ����'+fndP3_SORT_ID.Text;
           inc(c);
         end;
      if fndP3_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP3_TYPE_ID.Text+'��'+fndP3_STAT_ID.Text;
           inc(c);
         end;
      if fndP3_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP3_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  3:begin
      c := 0;
      inc(c);
      s := '�·ݣ�'+P4_D1.asString+' �� '+P4_D2.asString;
      if fndP4_SHOP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP4_SHOP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if not fndP4_SHOW.Checked then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '���ѡ�����ʾ�����������Ʒ';
           inc(c);
         end;
      if trim(fndP4_SORT_ID.Text) <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ʒ���ࣺ'+fndP4_SORT_ID.Text;
           inc(c);
         end;
      if fndP4_STAT_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + fndP4_TYPE_ID.Text+'��'+fndP4_STAT_ID.Text;
           inc(c);
         end;
      if fndP4_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP4_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
    end;
  4:begin
      c := 0;
      inc(c);
      s := '�·ݣ�'+P5_D1.asString+' �� '+P5_D2.asString;
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ͣ�'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_UNIT_ID.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��ʾ��λ��'+fndP5_UNIT_ID.Text;
           inc(c);
         end;
      PrintDBGridEh1.BeforeGridText.Text := s;
      if fndP5_GODS_ID.asString<>'' then
         PrintDBGridEh1.Title.Text := '��Ʒ���ƣ�'+ fndP5_GODS_ID.Text;
    end;
  end;
  }
end;

procedure TfrmJxcTotalReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fndP1_SORT_ID.Text:=SelectGoodSortType(sid1,srid1);
end;

procedure TfrmJxcTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fndP2_SORT_ID.Text:=SelectGoodSortType(sid2,srid2);
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fndP4_SORT_ID.Text:=SelectGoodSortType(sid4,srid4);
end;

procedure TfrmJxcTotalReport.actPriorExecute(Sender: TObject);
begin
  //if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;

end;

procedure TfrmJxcTotalReport.CreateGrid;
var
  Column:TColumnEh;
  rs:TADODataSet;
begin
{ rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select CHANGE_CODE,CHANGE_NAME from STO_CHANGECODE order by CHANGE_CODE';
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMOUNT';
        Column.Title.Caption := rs.Fields[1].AsString+'|����';
        Column.Width := 61;
        Column.Index := DBGridEh1.Columns.Count -3;
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMONEY';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh1.Columns.Count -3;

        Column := DBGridEh2.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMOUNT';
        Column.Title.Caption := rs.Fields[1].AsString+'|����';
        Column.Width := 61;
        Column.Index := DBGridEh2.Columns.Count -3;
        Column := DBGridEh2.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMONEY';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh2.Columns.Count -3;

        Column := DBGridEh3.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMOUNT';
        Column.Title.Caption := rs.Fields[1].AsString+'|����';
        Column.Width := 61;
        Column.Index := DBGridEh3.Columns.Count -3;
        Column := DBGridEh3.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMONEY';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh3.Columns.Count -3;

        Column := DBGridEh4.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMOUNT';
        Column.Title.Caption := rs.Fields[1].AsString+'|����';
        Column.Width := 61;
        Column.Index := DBGridEh4.Columns.Count -3;
        Column := DBGridEh4.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMONEY';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh4.Columns.Count -3;

        Column := DBGridEh5.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMOUNT';
        Column.Title.Caption := rs.Fields[1].AsString+'|����';
        Column.Width := 61;
        Column.Index := DBGridEh5.Columns.Count -3;
        Column := DBGridEh5.Columns.Add;
        Column.FieldName := 'PARM'+rs.Fields[0].AsString+'_AMONEY';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh5.Columns.Count -3;
        rs.Next;
      end;
  finally
    rs.Free;
  end;
}
end;

procedure TfrmJxcTotalReport.fndP4_TYPE_IDPropertiesChange(Sender: TObject);
begin
  AddGoodSortTypeItemsList(Sender, fndP4_STAT_ID);  
end;

procedure TfrmJxcTotalReport.CheckCalc(b, e: integer);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH>:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       TfrmCostCalc.StartCalc(self);
  finally
    rs.Free;
  end;
end;

procedure TfrmJxcTotalReport.InitialParams;
begin
  //P1:����������ͳ��:
  P1_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P1_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  //����ŵ����Ⱥ����Ĭ��List:
  AddShopGroupItems(fndP1_GROUP_ID,'11');
  AddShopGroupItemsList(fndP1_GROUP_LIST,8);
  fndP1_GROUP_ID.ItemIndex:=0;
  //�����Ʒָ�꼰Ĭ��List:
  AddGoodSortTypeItems(fndP1_TYPE_ID);
  AddGoodSortTypeItemsList(fndP1_STAT_ID,2);
  fndP1_TYPE_ID.ItemIndex := 0;
  //���ͳ�Ƶ�λ
  AddTongjiUnitList(fndP1_UNIT_ID);
  fndP1_UNIT_ID.ItemIndex:=0;

  //P2:�ŵ������ͳ��
  P2_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P2_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  //����ŵ����Ⱥ����Ĭ��List:
  AddShopGroupItems(fndP2_GROUP_ID,'11');
  AddShopGroupItemsList(fndP2_GROUP_LIST,8);
  fndP2_GROUP_ID.ItemIndex:=0;
  //�����Ʒָ�꼰Ĭ��List:
  AddGoodSortTypeItems(fndP2_TYPE_ID);
  AddGoodSortTypeItemsList(fndP2_STAT_ID,2);
  fndP2_TYPE_ID.ItemIndex := 0;
  //���ͳ�Ƶ�λ
  AddTongjiUnitList(fndP2_UNIT_ID);
  fndP2_UNIT_ID.ItemIndex:=0;

  //P3:���������ͳ��
  P3_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P3_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  //����ŵ����Ⱥ����Ĭ��List:
  AddShopGroupItems(fndP3_GROUP_ID,'11');
  AddShopGroupItemsList(fndP3_GROUP_LIST,8);
  fndP3_GROUP_ID.ItemIndex:=0;
  fndP3_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO'); 
  //���ͳ�Ƶ�λ
  AddTongjiUnitList(fndP3_UNIT_ID);
  fndP3_UNIT_ID.ItemIndex:=0;

  //P4:��Ʒ������ͳ��
  P4_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P4_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  //����ŵ����Ⱥ����Ĭ��List:
  AddShopGroupItems(fndP4_GROUP_ID,'11');
  AddShopGroupItemsList(fndP4_GROUP_LIST,8);
  fndP4_GROUP_ID.ItemIndex:=0;
  //�����Ʒָ�꼰Ĭ��List:
  AddGoodSortTypeItems(fndP4_TYPE_ID);
  AddGoodSortTypeItemsList(fndP4_STAT_ID,2);
  fndP4_TYPE_ID.ItemIndex := 0;
  fndP4_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
  //���ͳ�Ƶ�λ
  AddTongjiUnitList(fndP4_UNIT_ID);
  fndP4_UNIT_ID.ItemIndex:=0;      
end;

function TfrmJxcTotalReport.GetUnitIDIdx: integer;
begin
  result:=0;
  if (RzPage.ActivePage=TabSheet1) and (fndP1_UNIT_ID.ItemIndex<>-1) then       //����������ͳ�Ʊ�
    result:=fndP1_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet2) and (fndP2_UNIT_ID.ItemIndex<>-1) then  //�ŵ������ͳ�Ʊ�
    result:=fndP2_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet3) and (fndP3_UNIT_ID.ItemIndex<>-1) then  //���������ͳ�Ʊ�
    result:=fndP3_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet4) and (fndP4_UNIT_ID.ItemIndex<>-1) then  //��Ʒ������ͳ�Ʊ�
    result:=fndP4_UNIT_ID.ItemIndex
end;

procedure TfrmJxcTotalReport.fndP4_GROUP_IDPropertiesChange(Sender: TObject);
begin
  AddShopGroupItemsList(Sender,fndP4_GROUP_LIST);
end;

procedure TfrmJxcTotalReport.fndP2_GROUP_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  AddShopGroupItemsList(Sender,fndP2_GROUP_LIST);
end;

procedure TfrmJxcTotalReport.fndP1_GROUP_IDPropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddShopGroupItemsList(Sender,fndP1_GROUP_LIST);
end;

procedure TfrmJxcTotalReport.fndP3_GROUP_IDPropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddShopGroupItemsList(Sender,fndP3_GROUP_LIST);
end;

end.

