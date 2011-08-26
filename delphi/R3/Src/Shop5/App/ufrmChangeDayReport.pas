unit ufrmChangeDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup;

type
  TfrmChangeDayReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
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
    RzPanel16: TRzPanel;
    Panel7: TPanel;
    RzPanel17: TRzPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    P5_D1: TcxDateEdit;
    RzBitBtn4: TRzBitBtn;
    RzPanel18: TRzPanel;
    dsadoReport4: TDataSource;
    P5_D2: TcxDateEdit;
    dsadoReport5: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    fndP3_SHOP_ID: TzrComboBoxList;
    fndP3_REPORT_FLAG: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    DBGridEh5: TDBGridEh;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    RzBitBtn2: TRzBitBtn;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    adoReport5: TZQuery;
    Label38: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);     
    procedure actPriorExecute(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
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
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh4TitleClick(Column: TColumnEh);
  private
    vBegDate,          //��ѯ��ʼ����
    vEndDate: integer; //��ѯ��������
    RckMaxDate: integer;  //̨���������

    GodsID: string;       //˫���DBGridEh�Ĵ��ݱ���
    FCodeId: string;      //������������ID
    FCodeName: string;    //����������������
    SortName: string;     //��Ʒ��������: 
    sid1,sid2,sid4,sid5:string;      //��Ʒ����ID
    srid1,srid2,srid4,srid5:string;  //��Ʒ����REGLATION_ID

    //���������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //���ŵ����ۻ��ܱ�
    function GetShopSQL(chk:boolean=true): string;
    //���������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //����Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    //����Ʒ������ˮ��
    function GetGlideSQL(chk:boolean=true): string;

    procedure SetCodeId(const Value: string); //���õ������ĵ�������ID
    function  GetRCKFields: string;  //����CodeId����̨�˱�Ĳ�ѯ�ֶ�:
    function  GetVIWFields: string;  //����CodeId����Change��ͼ�Ĳ�ѯ�ֶ�:
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override;
    function  GetGodsSortIdx: string; //���Title
    function  GetDataRight: string; //���ز鿴����Ȩ��
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property CodeId:string read FCodeId write SetCodeId;
    property CodeName: string read FCodeName;     //������: ��������
    property RCKFields: string read GetRCKFields;  //����CodeId����̨�˱�Ĳ�ѯ�ֶ�:
    property VIWFields: string read GetVIWFields;  //����CodeId����Change��ͼ�Ĳ�ѯ�ֶ�:
    property GodsSortIdx: string read GetGodsSortIdx;
    property  DataRight: string read GetDataRight; //���ز鿴����Ȩ��
  end;

const
  ArySumField: Array[0..3] of string=('AMOUNT','AMONEY','COST_MONEY','PROFIT_MONEY');

implementation
  uses
    uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;

  {$R *.dfm}

procedure TfrmChangeDayReport.FormCreate(Sender: TObject);
var
  rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
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

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label12.Caption := '�ֿ�Ⱥ��';
      Label21.Caption := '�ֿ�����';

      Label28.Caption := '�ֿ�Ⱥ��';
      Label17.Caption := '�ֿ�����';

      //2011.06.16 15:51 �޸�
      TabSheet2.Caption:='�ֿ�������ܱ�';
      SetCol:=FindColumn(DBGridEh2, 'SHOP_ID');
      if setCol<>nil then
        SetCol.Title.Caption:='�ֿ����';
      SetCol:=FindColumn(DBGridEh2, 'SHOP_NAME');
      if setCol<>nil then
        SetCol.Title.Caption:='�ֿ�����';
      SetCol:=FindColumn(DBGridEh5, 'SHOP_NAME');
      if setCol<>nil then
        SetCol.Title.Caption:='�ֿ�����';
    end;

  SetRzPageActivePage;  //����Ĭ��RzPage
  RefreshColumn;

  //���DeptID
  rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if (rs<>nil) and (rs.Active) and (not rs.IsEmpty) then
    AddDBGridEhColumnItems(DBGridEh5, rs, 'DEPT_ID','DEPT_ID','DEPT_NAME');

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
  
  //2011.04.22 Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh2, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh3, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh4, ['COST_MONEY','PROFIT_MONEY']);
    SetNotShowCostPrice(DBGridEh5, ['COST_PRICE','COST_MONEY','PROFIT_MONEY']);      
  end; 
end;

function TfrmChangeDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  if P1_D1.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //��������
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>'+InttoStr(RckMaxDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //�ŵ�������������|�ŵ�����:
  if (fndP1_SHOP_VALUE.AsString<>'') then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒָ��:
  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;

  //��Ʒ����:
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if RckMaxDate < vBegDate then   //--[ȫ����ѯ��ͼ]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then  //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_GOODS_DAYS'
  else  // union all
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+'  and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;                                  

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');  
  //��ע: MNY: ��ʱ�����Ľ��; RTL: ���۽��; CST: �ɱ���
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID '+
    ',B.REGION_ID as REGION_ID '+
    ',sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+   //����
    ',case when sum(-CHANGE'+CodeId+'_AMT)<>0 then cast(sum(-CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--����
    ',sum(-CHANGE'+CodeId+'_RTL) as AMONEY '+      //--�����۶�
    ',sum(-CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--�����ɱ�
    ',sum(-CHANGE'+CodeId+'_RTL)-sum(-CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //���ë��
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  //������������
  strSql:=
    'select j.* '+
    ',isnull(r.CODE_NAME,''��'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';
  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmChangeDayReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmChangeDayReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //���������ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
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
        Do_REPORT_FLAGFooterSum(fndP3_REPORT_FLAG, adoReport3, ArySumField);
      end;
    3: begin //����Ʒ���ܱ�
        if adoReport4.Active then adoReport4.Close;
        adoReport4.SortedFields:='';
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
        dsadoReport4.DataSet:=nil;
        DoGodsGroupBySort(adoReport4,GodsSortIdx,'SORT_ID','GODS_NAME',
                          ['AMOUNT','APRICE','AMONEY','COST_MONEY','PROFIT_MONEY'],
                          ['APRICE=AMONEY/AMOUNT']);
        dsadoReport4.DataSet:=adoReport4;
      end;
    4: begin //����Ʒ��ˮ��
        if adoReport5.Active then adoReport5.Close;
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
  GodsID:='';  
end;

function TfrmChangeDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,strWhere,StrCnd,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  if P2_D1.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P2_D1.Date>P2_D2.Date  then  Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //��ѯ������:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>'+InttoStr(RckMaxDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //�ŵ�������������|�ŵ�����:
  if (fndP2_SHOP_VALUE.AsString<>'') then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //��Ʒָ��:
  if (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;
  //��Ʒ����:
  if (trim(fndP2_SORT_ID.Text)<>'')  and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid2+' ';
     else
       strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_GOODS_DAYS'
  else //--[��ѯ̨�˱�]  Union  [��ͼ]
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');  
  //��ע: MNY: ��ʱ�����Ľ��; RTL: ���۽��; CST: �ɱ���
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID'+
    ',B.SHOP_ID as SHOP_ID '+
    ',sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //����
    ',case when sum(-CHANGE'+CodeId+'_AMT)<>0 then cast(-sum(CHANGE'+CodeId+'_RTL) as decimal(10,3))*1.00/cast(sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--����
    ',sum(-CHANGE'+CodeId+'_RTL) as AMONEY '+      //--�����۶�
    ',sum(-CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--�����ɱ�
    ',sum(-CHANGE'+CodeId+'_RTL)-sum(-CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //���ë��
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.SHOP_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
    );  
end;

function TfrmChangeDayReport.GetSortSQL(chk:boolean=true): string;
var
  GodsStateIdx: integer; //���ͳ��ָ��Idx
  UnitCalc,JoinCnd,lv,LvField: string;  //��λ�����ϵ
  strSql,strCnd,strWhere,GoodTab,SQLData: string;
begin
  lv:='';
  LvField:='';
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;

  if P3_D1.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P3_D1.Date>P3_D2.Date  then  Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('��ѡ�񱨱�����...'); //��Ʒָ��:
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //������ҵID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;
  //�ŵ�����
  if (fndP3_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
  end;

  //��ѯ������:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>'+InttoStr(RckMaxDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //�ŵ�������������|�ŵ�����:
  if (fndP3_SHOP_VALUE.AsString<>'') then
  begin
    case fndP3_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP3_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP3_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒ����:
  case GodsStateIdx of
  1:begin
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
      LvField:=lv+' as LEVEL_ID ';
    end;
  else
    GoodTab:='VIW_GOODSPRICE';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_GOODS_DAYS'
  else
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');  
  //��ע: MNY: ��ʱ�����Ľ��; RTL: ���۽��; CST: �ɱ���
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+LvField+',C.RELATION_ID '+
    ',sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //����
    ',case when sum(-CHANGE'+CodeId+'_AMT)<>0 then cast(sum(-CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--����
    ',sum(-CHANGE'+CodeId+'_RTL) as AMONEY '+      //--�����۶�
    ',sum(-CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--�����ɱ�
    ',sum(-CHANGE'+CodeId+'_RTL)-sum(-CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //���ë��
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lv+',C.RELATION_ID';

  case GodsStateIdx of
    1:begin
       case Factor.iDbType of
        4: JoinCnd:=' and j.LEVEL_ID=substr(r.LEVEL_ID,1,length(j.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;
       
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(nvl(AMOUNT,0)) as AMOUNT '+      //����
          ',case when sum(nvl(AMOUNT,0))<>0 then sum(nvl(AMONEY,0))/sum(nvl(AMOUNT,0)) else sum(nvl(AMONEY,0)) end as APRICE '+  //--����
          ',sum(nvl(AMONEY,0)) as AMONEY '+      //--�����۶�
          ',sum(nvl(COST_MONEY,0)) as COST_MONEY '+  //--�����ɱ�
          ',sum(nvl(AMONEY,0))-sum(nvl(COST_MONEY,0)) as PROFIT_MONEY '+  //���ë��
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID  '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID  from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'') ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(AMOUNT) as AMOUNT '+      //����
          ',case when sum(AMOUNT)<>0 then sum(AMONEY)/sum(AMOUNT) else sum(AMONEY) end as APRICE '+  //--����
          ',sum(AMONEY) as AMONEY '+      //--�����۶�
          ',sum(COST_MONEY) as COST_MONEY '+  //--�����ɱ�
          ',sum(AMONEY)-sum(COST_MONEY) as PROFIT_MONEY '+  //���ë��
          ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME '+
        ' from ('+strSql+') j left outer join VIW_CLIENTINFO r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(AMOUNT) as AMOUNT '+      //����
          ',case when sum(AMOUNT)<>0 then sum(AMONEY)/sum(AMOUNT) else sum(AMONEY) end as APRICE '+  //--����
          ',sum(AMONEY) as AMONEY '+      //--�����۶�
          ',sum(COST_MONEY) as COST_MONEY '+    //--�����ɱ�
          ',sum(AMONEY)-sum(COST_MONEY) as PROFIT_MONEY '+  //���ë��
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j '+
          ' left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+InttoStr(GodsStateIdx)+') r '+
          ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+InttoStr(GodsStateIdx)+'=r.SORT_ID '+
          ' group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmChangeDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc,SORT_ID: string;  //��λ�����ϵ
  strSql,strWhere,strCnd,ShopCnd,GoodTab,SQLData: string;
begin
  vBegDate:=0;
  vEndDate:=0;
  RckMaxDate:=0;
  ShopCnd:='';
  if P4_D1.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;
  //�ŵ�����
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;

  //��ѯ������:
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and CHANGE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and CHANGE_DATE>='+InttoStr(vBegDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and CHANGE_DATE>'+InttoStr(RckMaxDate)+' and CHANGE_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //�ŵ�������������|�ŵ�����:
  if (fndP4_SHOP_VALUE.AsString<>'') then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP4_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP4_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒָ��:
  if (fndP4_STAT_ID.AsString <> '') and (fndP4_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP4_TYPE_ID)+'='''+fndP4_STAT_ID.AsString+''' ';
  end;
  
  //��Ʒ����:
  if (trim(fndP4_SORT_ID.Text)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid4+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid4+''' ';
    end;
    if trim(sid4)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+')'
  else if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_GOODS_DAYS'
  else //--Union  all 
  begin
    SQLData:=
      '(select '+RCKFields+' from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select '+VIWFields+' from VIW_CHANGEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CHANGE_CODE='''+CodeId+''' '+StrCnd+' '+
      ')';
  end;
  //�����ֶ�
  case StrToInt(GodsSortIdx) of
   0: SORT_ID:='C.RELATION_ID';
   else
      SORT_ID:='C.SORT_ID'+GodsSortIdx+' ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');  
  strSql :=
    'SELECT '+
    ' A.TENANT_ID as TENANT_ID '+
    ','+SORT_ID+' as SORT_ID '+
    ',A.GODS_ID as GODS_ID '+
    ',sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as AMOUNT '+      //����
    ',case when sum(-CHANGE'+CodeId+'_AMT)<>0 then cast(sum(-CHANGE'+CodeId+'_RTL) as decimal(18,3))*1.00/cast(sum(-CHANGE'+CodeId+'_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as APRICE '+  //--����
    ',sum(-CHANGE'+CodeId+'_RTL) as AMONEY '+      //--�����۶�
    ',sum(-CHANGE'+CodeId+'_CST) as COST_MONEY '+  //--�����ɱ�
    ',sum(-CHANGE'+CodeId+'_RTL)-sum(-CHANGE'+CodeId+'_CST) as PROFIT_MONEY '+  //���ë��
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,'+SORT_ID+',A.GODS_ID';

  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  case StrToInt(GodsSortIdx) of
   0:
    begin
      strSql :=
        'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE ';
    end;
   else
    begin
      strSql :=
        'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        '(select SORT_ID,SEQ_NO as OrderNo from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
        ' on j.SORT_ID=s.SORT_ID '+
        ' order by s.OrderNo,s.SORT_ID,j.GODS_CODE';
    end;
  end;
  Result :=  ParseSQL(Factor.iDbType,strSql);
end;

function TfrmChangeDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create(CodeName+'������������Ϊ��');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CHANGE_CODE='''+CodeId+''' '+DataRight;
  //GodsID��Ϊ��(DBGridEh4˫���鿴��ϸ������ʾ)
  if trim(GodsID)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  if fndP5_SHOP_ID.AsString<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

  //�·�����:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
    strWhere:=strWhere+' and A.CHANGE_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
    strWhere:=strWhere+' and A.CHANGE_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.CHANGE_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';

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
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
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
     4: strWhere := strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.CHANGE_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.DEPT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+
    ',A.CHANGE_TYPE '+
    ',-A.AMOUNT as AMOUNT'+               //--����
    ',A.APRICE '+               //--���ۼ�
    ',-A.RTL_MONEY as AMONEY '+  //--���۽��
    ',A.COST_PRICE '+           //--�ɱ���
    ',-A.COST_MONEY as COST_MONEY '+           //--�ɱ����
    ',-(A.RTL_MONEY-A.COST_MONEY) as PROFIT_MONEY '+                   //--���ë��
    ',B.SHOP_NAME '+
    'from VIW_CHANGEDATA A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';

  strSql :=
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by j.CHANGE_DATE,r.GODS_CODE ';

  Result:= ParseSQL(Factor.iDbType, strSql);
end;

procedure TfrmChangeDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date:=P1_D1.Date;
  P2_D2.Date:=P1_D2.Date;
  sid2:=sid1;
  srid2:=srid1;
  fndP2_SORT_ID.Text:=fndP1_SORT_ID.Text;  //����
  Copy_ParamsValue('TYPE_ID',1,2);  //ͳ��ָ��

  fndP2_SHOP_TYPE.ItemIndex:=0;  //����Ⱥ��
  fndP2_SHOP_VALUE.KeyValue:=adoReport1.fieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text:=adoReport1.fieldbyName('CODE_NAME').AsString;
  fndP2_UNIT_ID.ItemIndex:=fndP1_UNIT_ID.ItemIndex;  //��ʾ��λ

  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmChangeDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  fndP3_SHOP_ID.KeyValue:=trim(adoReport2.fieldbyName('SHOP_ID').AsString); //�ŵ�ID
  fndP3_SHOP_ID.Text:=trim(adoReport2.fieldbyName('SHOP_NAME').AsString);   //�ŵ�����
  Copy_ParamsValue('SHOP_TYPE',2,3);  //����Ⱥ��
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex; //��ʾ��λ
  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmChangeDayReport.DBGridEh3DblClick(Sender: TObject);
var
  i,CodeID: integer;
  SortID: string;
  Aobj: TRecord_;
begin
  inherited;
  if adoReport3.IsEmpty then Exit;

  //�϶��б�������:
  CodeID:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   1,3:
     if trim(adoReport3.FieldByName('SORT_NAME').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'���Ʋ���Ϊ�գ�');
   else
     if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'���Ʋ���Ϊ�գ�');
  end;
  
  case CodeID of
   1:  //��Ʒ����[����Ӧ����]
    begin
      sid4:=Copy(trim(adoReport3.fieldbyName('LEVEL_ID').AsString),8,200);
      srid4:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_SORT_ID.Text:=trim(adoReport3.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP4_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP4_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[i]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          case CodeID of
           3: fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
           else
              fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
          end;
          fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
          break;
        end;
      end;
    end;
  end;
  
  P4_D1.Date:=P3_D1.Date;
  P4_D2.Date:=P3_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4);  //����Ⱥ��
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID);  //�ŵ�����
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex; //��ʾ��λ
  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);   
end;

procedure TfrmChangeDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('û����Ʒ��...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  sid5:=sid4;
  srid5:=srid4;
  fndP5_SORT_ID.Text:=fndP4_SORT_ID.Text; //����

  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5);  //����Ⱥ��
  Copy_ParamsValue('TYPE_ID',4,5);    //ͳ��ָ��
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID);  //�ŵ�����
  fndP4_UNIT_ID.ItemIndex:=fndP3_UNIT_ID.ItemIndex; //��ʾ��λ
  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmChangeDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmChangeDayReport.PrintBefore;
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

procedure TfrmChangeDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmChangeDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.actPriorExecute(Sender: TObject);
begin
  if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;

end;

procedure TfrmChangeDayReport.SetCodeId(const Value: string);
var
  i:integer;
  rs:TZQuery;
begin
  FCodeId := Value;
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  if rs.locate('CHANGE_CODE',Value,[]) then
  begin
    FCodeName:=trim(rs.FieldbyName('CHANGE_NAME').asString);
    Caption := '��Ʒ'+rs.FieldbyName('CHANGE_NAME').asString + '����';
    lblToolCaption.Caption := '��Ʒ'+rs.FieldbyName('CHANGE_NAME').asString + '����';
    for i:=0 to RzPage.PageCount-1 do
     RzPage.Pages[i].Caption := StringReplace(RzPage.Pages[i].Caption,'����',rs.FieldbyName('CHANGE_NAME').asString,[rfReplaceAll]);
  end else
    Raise Exception.Create('����ĵ������ʹ���');
end;

procedure TfrmChangeDayReport.fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmChangeDayReport.fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  sid5 := '';
  srid5 := '';
  fndP5_SORT_ID.Text := '';
end;

function TfrmChangeDayReport.GetRCKFields: string;
begin
  //��ע: MNY: ��ʱ�����Ľ��; RTL: ���۽��; CST: �ɱ���
  result:=' TENANT_ID,SHOP_ID,GODS_ID,CREA_DATE,CHANGE'+CodeId+'_AMT,CHANGE'+CodeId+'_RTL,CHANGE'+CodeId+'_CST ';
end;

function TfrmChangeDayReport.GetVIWFields: string;
begin
  result:=' TENANT_ID,SHOP_ID,GODS_ID,CHANGE_DATE as CREA_DATE,PARM'+CodeId+'_AMOUNT as CHANGE'+CodeId+'_AMT,PARM'+CodeId+'_RTL as CHANGE'+CodeId+'_RTL,PARM'+CodeId+'_MONEY as CHANGE'+CodeId+'_CST ';
end;

procedure TfrmChangeDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmChangeDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
  begin
    TitleList.add(CodeName+'���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
  end;
  
  //�̳л���:
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmChangeDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GLIDE_NO' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmChangeDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GODS_NAME' then Text := '�ϼ�:'+Text+'��';
  if AllRecord.Count<=0 then Exit;
  ColName:=trim(UpperCase(Column.FieldName));
  if ColName = 'GODS_NAME' then
    Text := '�ϼ�:'+AllRecord.fieldbyName('GODS_NAME').AsString+'��'
  else
  begin
    if AllRecord.FindField(ColName)<>nil then
    begin
      if (ColName='AMOUNT') or (ColName='APRICE') or (ColName='AMONEY') or (ColName='COST_MONEY') or (ColName='PROFIT_MONEY') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end;
    end;
  end;
end;

procedure TfrmChangeDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  i: integer;
  FName: string;
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '�ϼ�:'+Text+'��'
  else
  begin
    if (SumRecord.Count>0) and (SumRecord.FindField(Column.FieldName)<>nil) then //�ֶ�������0 �Լ��ۼ�
    begin
      for i:=Low(ArySumField) to High(ArySumField) do
      begin
        FName:=trim(ArySumField[i]);
        if UpperCase(Column.FieldName)=UpperCase(FName) then
        begin
          Text:=FormatFloat(Column.DisplayFormat,SumRecord.fieldbyName(FName).AsFloat);
        end;
      end;
    end;
  end;
end;

procedure TfrmChangeDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmChangeDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmChangeDayReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

function TfrmChangeDayReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';  
end;

procedure TfrmChangeDayReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  inherited;
  DBGridTitleClick(adoReport4,Column,'SORT_ID');
end;

function TfrmChangeDayReport.GetDataRight: string;
begin
  //������:RCK_GOODS_DAYS��VIW_CHANGEDATA A
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

