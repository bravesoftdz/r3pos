unit ufrmDbDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup, ObjCommon,
  ufrmDateControl;

type
  TfrmDbDayReport = class(TframeBaseReport)
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
    LblShopName: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    adoReport2: TZQuery;
    adoReport5: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    Label3: TLabel;
    RzGB: TRzGroupBox;
    fndP6_DBIN: TcxRadioButton;
    fndP6_DBOUT: TcxRadioButton;
    Label38: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    P5_DateControl: TfrmDateControl;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
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
    procedure fndP6_DBINClick(Sender: TObject);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh4TitleClick(Column: TColumnEh);
  private
    vBegDate,          //��ѯ��ʼ����
    vEndDate: integer; //��ѯ��������
    RckMaxDate: integer;  //̨���������

    GodsID: string;      //��ǰ˫����ϸ��GODS_IDs
    SortName: string;
    sid1,sid2,sid4,sid5: string;
    srid1,srid2,srid4,srid5: string;
    //1�����������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //2�����ŵ����ۻ��ܱ�
    function GetShopSQL(chk:boolean=true): string;
    //3�����������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //4������Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    //5������Ʒ������ˮ��
    function GetGlideSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
    function GetGodsSortIdx: string; //���Title
    function GetDataRight: string; //���ز鿴����Ȩ��
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property GodsSortIdx: string read GetGodsSortIdx; //ͳ������
    property  DataRight: string read GetDataRight; //���ز鿴����Ȩ��
  end;

const
  ArySumField: Array[0..4] of string=('DBIN_AMT','DBIN_CST','DBOUT_AMT','DBOUT_CST','DBOUT_RTL');

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;

{$R *.dfm}

procedure TfrmDbDayReport.FormCreate(Sender: TObject);
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

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_DateControl.StartDateControl := P3_D1;
  P3_DateControl.EndDateControl := P3_D2;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P4_DateControl.StartDateControl := P4_D1;
  P4_DateControl.EndDateControl := P4_D2;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P5_DateControl.StartDateControl := P5_D1;
  P5_DateControl.EndDateControl := P5_D2;

  SetRzPageActivePage; //���ûRzPage.Acitve
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
    end; }
    
  //2011.04.22 Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['DBIN_PRC','DBIN_CST','DBOUT_PRC','DBOUT_CST']);
    SetNotShowCostPrice(DBGridEh2, ['DBIN_PRC','DBIN_CST','DBOUT_PRC','DBOUT_CST']);
    SetNotShowCostPrice(DBGridEh3, ['DBIN_PRC','DBIN_CST','DBOUT_PRC','DBOUT_CST']);
    SetNotShowCostPrice(DBGridEh4, ['DBIN_PRC','DBIN_CST','DBOUT_PRC','DBOUT_CST']);
    SetNotShowCostPrice(DBGridEh5, ['DB_PRC','DB_CST']);      
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label12.Caption := '�ֿ�Ⱥ��';
      Label21.Caption := '�ֿ�����';

      Label28.Caption := '�ֿ�Ⱥ��';
      LblShopName.Caption := '�����ֿ�';
    end;

  //2011.09.22 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.AMONEY','DBGridEh1.COST_MONEY','DBGridEh1.PROFIT_MONEY',
                              'DBGridEh2.AMONEY','DBGridEh2.COST_MONEY','DBGridEh2.PROFIT_MONEY',
                              'DBGridEh3.AMONEY','DBGridEh3.COST_MONEY','DBGridEh3.PROFIT_MONEY',
                              'DBGridEh4.AMONEY','DBGridEh4.COST_MONEY','DBGridEh4.PROFIT_MONEY',
                              'DBGridEh5.AMONEY','DBGridEh5.COST_PRICE','DBGridEh5.COST_MONEY','DBGridEh5.PROFIT_MONEY']);    
end;

function TfrmDbDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //��������
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);    //ȡ�ս����������:
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and MOVE_DATE>'+InttoStr(RckMaxDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
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
    strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if RckMaxDate < vBegDate then   //--[ȫ����ѯ��ͼ]
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then  //--[ȫ����ѯ̨�ʱ�]
    SQLData :='RCK_GOODS_DAYS'
  else
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;      

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';

  strSql :=
    'select j.* '+
    ',isnull(r.CODE_NAME,''��'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmDbDayReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmDbDayReport.actFindExecute(Sender: TObject);
var strSql: widestring;
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
                          ['DBIN_AMT','DBIN_PRC','DBIN_CST','DBIN_RTL','DBOUT_AMT','DBOUT_PRC','DBOUT_CST','DBOUT_RTL'],
                          ['DBIN_PRC=DBIN_CST/DBIN_AMT','DBOUT_PRC=DBOUT_CST/DBOUT_AMT']);
        dsadoReport4.DataSet:=adoReport4;
      end;
    4: begin //����Ʒ��ˮ��
        if adoReport5.Active then adoReport5.Close;
        if Sender<>nil then self.GodsID:='';        
        strSql := GetGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmDbDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string; //ͳ�Ƶ�λ��������ϵ
  strSql,StrCnd,strWhere,GoodTab,SQLData: widestring;
begin
  StrCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //��������
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);    //ȡ�ս����������:
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and MOVE_DATE>'+InttoStr(RckMaxDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
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
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒָ��:
  if (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;
  
  //��Ʒ����:
  if (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData :='RCK_GOODS_DAYS'
  else  
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  strSql :=    
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result :=  ParseSQL(Factor.iDbType, StrSql);
end;

function TfrmDbDayReport.GetSortSQL(chk:boolean=true): string;
var
  GodsStateIdx: integer; //���ͳ��ָ��Idx
  UnitCalc,JoinCnd,lv,LvField: string;  //��λ�����ϵ
  strSql,strCnd,strWhere,GoodTab,SQLData: widestring;
begin
  lv:='';
  lvField:='';
  result:='';
  strWhere:='';
  if P3_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //��Ʒָ��:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('��ѡ�񱨱�����...');
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //������ҵID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);    //ȡ�ս����������:
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and MOVE_DATE>'+InttoStr(RckMaxDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
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

  //�ŵ�����
  if (fndP3_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
  end;

  //��Ʒ����:
  case GodsStateIdx of
   1:begin
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
      lvField:=Lv+' as LEVEL_ID ';
     end;
   else
     GoodTab:='VIW_GOODSPRICE';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData :='RCK_GOODS_DAYS'
  else
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lvField+',C.RELATION_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
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
          ' sum(nvl(DBIN_AMT,0)) as DBIN_AMT '+
          ',sum(nvl(DBIN_CST,0)) as DBIN_CST '+
          ',case when sum(nvl(DBIN_AMT,0))<>0 then cast(sum(nvl(DBIN_CST,0)) as decimal(18,3))*1.00/cast(sum(nvl(DBIN_AMT,0)) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(nvl(DBIN_RTL,0)) as DBIN_RTL '+
          ',sum(nvl(DBOUT_AMT,0)) as DBOUT_AMT '+
          ',sum(nvl(DBOUT_CST,0)) as DBOUT_CST '+
          ',sum(nvl(DBOUT_RTL,0)) as DBOUT_RTL '+  
          ',case when sum(nvl(DBOUT_AMT,0))<>0 then cast(sum(nvl(DBOUT_CST,0)) as decimal(18,3))*1.00/cast(sum(nvl(DBOUT_AMT,0)) as decimal(18,3)) else 0 end as DBOUT_PRC '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as AA,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID  from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'') '+
          'union all '+
          'select distinct 1 as AA,RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')  ) j '+
          'left outer join ('+strSql+') r '+
          ' on j.RELATION_ID=r.RELATION_ID '+JoinCnd+' '+
          ' group by j.AA,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.AA,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(DBIN_AMT) as DBIN_AMT '+
          ',sum(DBIN_CST) as DBIN_CST '+
          ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(DBIN_RTL) as DBIN_RTL '+
          ',sum(DBOUT_AMT) as DBOUT_AMT '+
          ',sum(DBOUT_CST) as DBOUT_CST '+
          ',sum(DBOUT_RTL) as DBOUT_RTL '+           
          ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))/cast(sum(DBOUT_AMT) as decimal(18,3)) else 0 end as DBOUT_CST '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(DBIN_AMT) as DBIN_AMT '+
          ',sum(DBIN_CST) as DBIN_CST '+
          ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))/cast(sum(DBIN_AMT) as decimal(18,3)) else 0 end as DBIN_PRC '+
          ',sum(DBIN_RTL) as DBIn_RTL '+
          ',sum(DBOUT_AMT) as DBOUT_AMT '+
          ',sum(DBOUT_CST) as DBOUT_CST '+
          ',sum(DBOUT_RTL) as DBOUT_RTL '+           
          ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))/cast(sum(DBOUT_AMT) as decimal(18,3)) else 0 end as DBOUT_PRC '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j '+
          'left outer join '+
          ' (select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+InttoStr(GodsStateIdx)+') r '+
          ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+InttoStr(GodsStateIdx)+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmDbDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc,SORT_ID: string; //ͳ�Ƶ�λ��������ϵ
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+DataRight;
  //�ŵ�����
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;
  //��������
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);    //ȡ�ս����������:
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and MOVE_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and MOVE_DATE>='+InttoStr(vBegDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and MOVE_DATE>'+InttoStr(RckMaxDate)+' and MOVE_DATE<='+InttoStr(vEndDate)+' ';
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

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]  SQLData:='VIW_STOCKDATA'          
    SQLData:='(select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData :='RCK_GOODS_DAYS'
  else  
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+                                                                                          
      ' select TENANT_ID,SHOP_ID,MOVE_DATE as CREA_DATE,GODS_ID,DBIN_AMT,DBIN_CST,DBIN_RTL,DBOUT_AMT,DBOUT_CST,DBOUT_RTL from VIW_MOVEDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ') ';
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
    ' A.TENANT_ID '+
    ','+SORT_ID+' as SORT_ID'+
    ',A.GODS_ID '+
    ',sum(DBIN_AMT*1.00/'+UnitCalc+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',case when sum(DBIN_AMT)<>0 then cast(sum(DBIN_CST) as decimal(18,3))*1.00/cast(sum(DBIN_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBIN_PRC '+
    ',sum(DBIN_RTL) as DBIN_RTL '+
    ',sum(DBOUT_AMT*1.00/'+UnitCalc+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',sum(DBOUT_RTL) as DBOUT_RTL '+
    ',case when sum(DBOUT_AMT)<>0 then cast(sum(DBOUT_CST) as decimal(18,3))*1.00/cast(sum(DBOUT_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as DBOUT_PRC '+
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
        ' order by s.OrderNo,s.SORT_ID,j.GODS_CODE ';
    end;
  end;
  result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmDbDayReport.GetGlideSQL(chk:boolean=true): string;
var
  JoinChar: string;
  strSql,StrCnd,strWhere,GoodTab: string;
begin
  JoinChar:=GetStrJoin(Factor.iDbType);
  if P5_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //GodsID��Ϊ�գ�
  if trim(GodsID)<>'' then strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

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

  if fndP6_DBIN.Checked then //���뵥 
  begin
    //�·�����:
    if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
      strWhere:=strWhere+' and A.STOCK_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
    else if P5_D1.Date<P5_D2.Date then
      strWhere:=strWhere+' and A.STOCK_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.STOCK_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';
    //�ŵ�����:
    if fndP5_SHOP_ID.AsString<>'' then
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

     strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GLIDE_NO '+
      ',A.STOCK_ID '+
      ',A.GODS_ID '+
      ',A.BATCH_NO '+
      ',A.LOCUS_NO '+
      ',A.UNIT_ID '+
      ',A.STOCK_DATE as MOVE_DATE '+
      ',A.PROPERTY_01 '+
      ',A.PROPERTY_02 '+
      ',A.IS_PRESENT '+
      ',A.CREA_DATE '+
      ',A.CREA_USER '+
      ',A.CLIENT_ID  '+    //�����ŵ�
      ',A.SHOP_ID  '+      //�����ŵ�
      ',A.GUIDE_USER '+     //����Ա
      ',A.AMOUNT as DB_AMT '+      //����
      ',A.APRICE as DB_PRC '+      //����
      ',A.RTL_MONEY as DB_RTL '+   //���۽��
      ',A.COST_MONEY as DB_CST '+  //�ɱ�
      ',B.SHOP_NAME  '+             //�����ŵ�
      ',A.STOCK_DATE as PLAN_DATE '+   //��������
      ',A.GUIDE_USER as SEND_USER '+   //������
      ',C.BARCODE as BARCODE '+
      ',C.GODS_CODE as GODS_CODE '+
      ',C.GODS_NAME as GODS_NAME '+   //������Ʒ��
      'from VIW_MOVEINDATA A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
      ' '+ strWhere + ' ';

  strSql :=
    'select j.* '+
    ',isnull(B.BARCODE,j.BARCODE) as BARCODE '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',c.SHOP_NAME as OUTSHOP_NAME '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',f.USER_NAME as SEND_USER_TEXT '+
    'from ('+strSql+') j '+           //2011.04.02 Add �������������
    'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    'left outer join CA_SHOP_INFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.SHOP_ID '+
    'left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    'left outer join VIW_USERS f on j.TENANT_ID=f.TENANT_ID and j.SEND_USER=f.USER_ID '+
    ' order by j.MOVE_DATE,j.GODS_CODE';
  end else
  if fndP6_DBOUT.Checked then //������
  begin
    //�·�����:
    if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
      strWhere:=strWhere+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
    else if P5_D1.Date<P5_D2.Date then
      strWhere:=strWhere+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' ';

    //�ŵ�����:
    if fndP5_SHOP_ID.AsString<>'' then
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GLIDE_NO '+
      ',A.SALES_ID '+
      ',A.GODS_ID '+
      ',A.BATCH_NO '+
      ',A.LOCUS_NO '+
      ',A.UNIT_ID '+
      ',A.SALES_DATE as MOVE_DATE '+
      ',A.PROPERTY_01 '+
      ',A.PROPERTY_02 '+
      ',A.IS_PRESENT '+
      ',A.CREA_DATE '+
      ',A.CREA_USER '+
      ',A.SHOP_ID '+        //�����ŵ�
      ',A.CLIENT_ID '+      //�����ŵ�
      ',A.GUIDE_USER '+     //����Ա
      ',A.AMOUNT as DB_AMT '+      //����
      ',A.APRICE as DB_PRC '+      //����
      ',A.RTL_MONEY as DB_RTL '+   //���۽��
      ',A.COST_MONEY as DB_CST '+  //�ɱ�
      ',B.SHOP_NAME as OUTSHOP_NAME '+             //�����ŵ�  
      ',A.GUIDE_USER as SEND_USER '+   //������
      ',C.BARCODE as BARCODE '+
      ',C.GODS_CODE as GODS_CODE '+
      ',C.GODS_NAME as GODS_NAME '+   //������Ʒ��  SAL_SALESORDER
      'from VIW_MOVEOUTDATA A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
      ' '+ strWhere + ' ';

   strSql :=
      'select M.* '+
      ',D.STOCK_DATE as PLAN_DATE '+   //��������;
      'from ('+strSql+') M  '+
      'left outer join '+
      ' (select TENANT_ID,STOCK_ID,STOCK_DATE from STK_STOCKORDER where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and STOCK_TYPE=2)D '+
      ' on M.TENANT_ID=D.TENANT_ID and M.SALES_ID=D.STOCK_ID  ';

    strSql :=
      'select j.* '+
      ',isnull(B.BARCODE,j.BARCODE) as BARCODE '+
      ',u.UNIT_NAME as UNIT_NAME '+
      ',c.SHOP_NAME as SHOP_NAME '+
      ',d.USER_NAME as GUIDE_USER_TEXT '+
      ',e.USER_NAME as CREA_USER_TEXT '+
      ',f.USER_NAME as SEND_USER_TEXT '+
      'from ('+strSql+') j '+           //2011.04.02 Add �������������
      'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
      'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
      'left outer join CA_SHOP_INFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.SHOP_ID '+
      'left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
      'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
      'left outer join VIW_USERS f on j.TENANT_ID=f.TENANT_ID and j.SEND_USER=f.USER_ID '+
      ' order by j.MOVE_DATE,j.GODS_CODE';
  end;

  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmDbDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date := P1_D1.Date;
  P2_D2.Date := P1_D2.Date;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  Copy_ParamsValue('TYPE_ID',1,2); //ͳ��ָ��
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex;

  fndP2_SHOP_TYPE.ItemIndex := 0; //����Ⱥ��
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;

  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',2,3); //����Ⱥ��
  Copy_ParamsValue('SHOP_ID',2,3); //�ŵ�����
  fndP3_SHOP_ID.KeyValue:=adoReport2.fieldbyName('SHOP_ID').AsString; //�ŵ�ID
  fndP3_SHOP_ID.Text:=adoReport2.fieldbyName('SHOP_NAME').AsString; //�ŵ�����
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex; //��ʾ��λ

  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.DBGridEh3DblClick(Sender: TObject);
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

  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4);  //����Ⱥ��
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID);  //�ŵ�
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;  //��ʾ��λ

  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmDbDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;  
end;

procedure TfrmDbDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('��ѡ���ѯ��ˮ�ʵ���Ʒ...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  if adoReport4.FieldByName('DBIN_AMT').AsFloat>0 then //����
    fndP6_DBIN.Checked:=true
  else
    fndP6_DBOUT.Checked:=true;

  sid5 := sid4;
  srid5 := srid4;
  fndP5_SORT_ID.Text:=fndP4_SORT_ID.Text; //����

  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5); //����Ⱥ��
  Copy_ParamsValue('TYPE_ID',4,5);   //��Ʒָ��
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID); //�����ŵ�
  
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmDbDayReport.PrintBefore;
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

procedure TfrmDbDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 :='';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 :='';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 :='';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmDbDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmDbDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  //�̳л���:
  inherited AddReportReport(TitleList,PageNo);
end;

procedure TfrmDbDayReport.fndP5_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 :='';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmDbDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmDbDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmDbDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
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

procedure TfrmDbDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GODS_NAME' then Text := '�ϼ�:'+Text+'��';
  if SumRecord.Count<=0 then Exit;
  ColName:=trim(UpperCase(Column.FieldName));
  if ColName = 'GODS_NAME' then
    Text := '�ϼ�:'+AllRecord.fieldbyName('GODS_NAME').AsString+'��'
  else
  begin
    if AllRecord.FindField(ColName)<>nil then
    begin
      if (ColName='DBIN_AMT') or (ColName='DBIN_PRC') or (ColName='DBIN_CST') or (ColName='DBIN_RTL') or
         (ColName='DBOUT_AMT') or (ColName='DBOUT_PRC') or (ColName='DBOUT_CST') or (ColName='DBOUT_RTL') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end;
    end;
  end;
end;

procedure TfrmDbDayReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'MOVE_DATE' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmDbDayReport.fndP6_DBINClick(Sender: TObject);
begin
  inherited;
  if ShopGlobal.GetProdFlag = 'E' then
  begin
    if fndP6_DBIN.Checked then
      LblShopName.Caption:='����ֿ�'
    else if fndP6_DBOUT.Checked then
      LblShopName.Caption:='�����ֿ�';
  end else
  begin
    if fndP6_DBIN.Checked then
      LblShopName.Caption:='�����ŵ�'
    else if fndP6_DBOUT.Checked then
      LblShopName.Caption:='�����ŵ�';
  end;
end;

function TfrmDbDayReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';
end;

procedure TfrmDbDayReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

procedure TfrmDbDayReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  inherited;
  DBGridTitleClick(adoReport4,Column,'SORT_ID');
end;

function TfrmDbDayReport.GetDataRight: string;
begin
  //������: RCK_GOODS_DAYS��VIW_MOVEDATA A
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

