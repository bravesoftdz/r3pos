unit ufrmJxcTotalReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList,ObjCommon,
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
    fndP2_SHOP_VALUE: TzrComboBoxList;
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
    fndP3_REPORT_FLAG: TcxComboBox;
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
    fndP2_SHOP_TYPE: TcxComboBox;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label11: TLabel;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label3: TLabel;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    Label38: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
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
    procedure DBGridEh4TitleClick(Column: TColumnEh);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    IsOnDblClick: Boolean;  //��˫��DBGridEh���λ  
    sid1,sid2,sid4:string;
    srid1,srid2,srid4:string;

    function GetMaxMonth(E:integer):string;
    procedure CheckCalc(b, e:integer); //��ʼ�·�| �����·�

     //���������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): widestring;
    //���ŵ����ۻ��ܱ�
    function GetShopSQL(chk:boolean=true): string;
    //���������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //����Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override;
    function GetGodsSortIdx: string; //���Title
    function GetDataRight: string; //���ز鿴����Ȩ��    
  public
    procedure CreateGrid;
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  GodsSortIdx: string read GetGodsSortIdx; //ͳ������
    property  DataRight: string read GetDataRight; //���ز鿴����Ȩ��
  end;

const
 ArySumField: Array[0..20] of string=('ORG_AMT','ORG_CST','ORG_RTL','STOCK_AMT','STOCK_TTL','STOCK_MNY','STOCK_TAX','SALE_AMT','SALE_TTL','SALE_MNY',
                                      'SALE_TAX','SALE_CST','SALE_PRF','SALE_RATE','DBIN_AMT','DBIN_CST','DBOUT_AMT','DBOUT_CST','BAL_AMT','BAL_CST','BAL_RTL');
  
implementation

uses
  uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, ufrmSelectGoodSort, ufrmCostCalc, uShopUtil;

{$R *.dfm}

procedure TfrmJxcTotalReport.FormCreate(Sender: TObject);
begin
  inherited;
  IsOnDblClick:=False;
  TDbGridEhSort.InitForm(self,false);

  //��ʼ��Items��������:
  //P1:����������ͳ��:
  P1_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P1_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���

  //P2:�ŵ������ͳ��
  P2_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P2_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���

  //P3:���������ͳ��
  P3_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P3_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  fndP3_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO'); 

  //P4:��Ʒ������ͳ��
  P4_D1.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  P4_D2.asString := FormatDateTime('YYYYMM', date); //Ĭ�ϵ���
  fndP4_SHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');

  SetRzPageActivePage; //����Ĭ�Ϸ�ҳ
  //2011.04.22 Add �жϳɱ���Ȩ��:
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_MNY','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh2, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_MNY','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh3, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_MNY','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
    SetNotShowCostPrice(DBGridEh4, ['ORG_CST','STOCK_TTL','STOCK_TAX','STOCK_MNY','SALE_CST','SALE_MNY','SALE_PRF','SALE_RATE','DBIN_CST','DBOUT_CST','BAL_CST']);
  end;
  CreateGrid;
  RefreshColumn;

  //2011.12.22 �ؿ���[�����ܵ�Ĭ�ϵ�ǰ�ŵ�]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP3_SHOP_ID.Properties.ReadOnly := False;
    fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP3_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
    //fndP3_SHOP_ID.Properties.ReadOnly := True;

    fndP4_SORT_ID.Properties.ReadOnly := False;
    fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP4_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP4_TYPE_ID.Style);
    //fndP4_SHOP_ID.Properties.ReadOnly := True;
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label3.Caption := '�ֿ�Ⱥ��';
      Label21.Caption := '�ֿ�����';
    end;
  SetGridColumnDisplayFormat(['DBGridEh1.ORG_CST','DBGridEh1.ORG_RTL','DBGridEh1.STOCK_TTL','DBGridEh1.STOCK_MNY','DBGridEh1.STOCK_TAX','DBGridEh1.SALE_TTL','DBGridEh1.SALE_MNY',
                              'DBGridEh1.SALE_TAX','DBGridEh1.SALE_CST','DBGridEh1.SALE_PRF','DBGridEh1.DBIN_CST','DBGridEh1.DBOUT_CST','DBGridEh1.BAL_CST','DBGridEh1.BAL_RTL',
                              'DBGridEh2.ORG_CST','DBGridEh2.ORG_RTL','DBGridEh2.STOCK_TTL','DBGridEh2.STOCK_MNY','DBGridEh2.STOCK_TAX','DBGridEh2.SALE_TTL','DBGridEh2.SALE_MNY',
                              'DBGridEh2.SALE_TAX','DBGridEh2.SALE_CST','DBGridEh2.SALE_PRF','DBGridEh2.DBIN_CST','DBGridEh2.DBOUT_CST','DBGridEh2.BAL_CST','DBGridEh2.BAL_RTL',
                              'DBGridEh3.ORG_CST','DBGridEh3.ORG_RTL','DBGridEh3.STOCK_TTL','DBGridEh3.STOCK_MNY','DBGridEh3.STOCK_TAX','DBGridEh3.SALE_TTL','DBGridEh3.SALE_MNY',
                              'DBGridEh3.SALE_TAX','DBGridEh3.SALE_CST','DBGridEh3.SALE_PRF','DBGridEh3.DBIN_CST','DBGridEh3.DBOUT_CST','DBGridEh3.BAL_CST','DBGridEh3.BAL_RTL',
                              'DBGridEh4.ORG_CST','DBGridEh4.ORG_RTL','DBGridEh4.STOCK_TTL','DBGridEh4.STOCK_MNY','DBGridEh4.STOCK_TAX','DBGridEh4.SALE_TTL','DBGridEh4.SALE_MNY',
                              'DBGridEh4.SALE_TAX','DBGridEh4.SALE_CST','DBGridEh4.SALE_PRF','DBGridEh4.DBIN_CST','DBGridEh4.DBOUT_CST','DBGridEh4.BAL_CST','DBGridEh4.BAL_RTL']);
end;

function TfrmJxcTotalReport.GetGroupSQL(chk:boolean=true): widestring;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //�·�����:
  if (P1_D1.asString<>'') and (P1_D1.asString=P1_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P1_D1.asString
  else if P1_D1.asString<P1_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P1_D1.asString+' and A.MONTH<='+P1_D2.asString+' '
  else
     Raise Exception.Create('�����½᲻��С�ڿ�ʼ�·�...');

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
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then   //and (trim(sid1)<>'') 
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if  trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //����Ƿ����
  CheckCalc(strtoInt(P1_D1.asString),StrtoInt(P1_D2.asString));
  mx := GetMaxMonth(StrtoInt(P1_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P1_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    ' group by A.TENANT_ID,B.REGION_ID';

  strSql :=
    'select j.* '+
    ',isnull(r.CODE_NAME,''��'') as CODE_NAME from ('+strSql+') j '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmJxcTotalReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmJxcTotalReport.actFindExecute(Sender: TObject);
var
  strSql: string;
  strList: TStringList;
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
        {
        try
          strList:=TStringList.Create;
          strList.Add(strSql);
          strList.SaveToFile('c:\SQL.txt');
        finally
          strList.Free;
        end;
        }
        Factor.Open(adoReport4);
        dsadoReport4.DataSet:=nil;
        DoGodsGroupBySort(adoReport4,GodsSortIdx,'SORT_ID','GODS_NAME','ORDER_ID',
                          ['ORG_AMT','ORG_CST','ORG_RTL','STOCK_AMT','STOCK_TTL','STOCK_MNY','STOCK_TAX','SALE_AMT','SALE_TTL','SALE_MNY',
                           'SALE_TAX','SALE_CST','SALE_PRF','SALE_RATE','DBIN_AMT','DBIN_CST','DBOUT_AMT','DBOUT_CST','BAL_AMT','BAL_CST','BAL_RTL'],
                          ['SALE_RATE=SALE_PRF/SALE_MNY*100.0']);
        dsadoReport4.DataSet:=adoReport4;
      end;
  end;
end;

function TfrmJxcTotalReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,strWhere,GoodTab:widestring;
  mx:string;
begin
  result:='';
  if P2_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //�·�����:
  if (P2_D1.asString<>'') and (P2_D1.asString=P2_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P2_D1.asString
  else if P2_D1.asString<P2_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P2_D1.asString+' and A.MONTH<='+P2_D2.asString+' '
  else
     Raise Exception.Create('�����½᲻��С�ڿ�ʼ�·�...');

  //�ŵ�������������|�ŵ�����:
  if (fndP2_SHOP_VALUE.AsString<>'') then
    begin
      case fndP2_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
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
    case Factor.iDbType of
     4: strWhere := strWhere+' and C.RELATION_ID='+srid2+' ';
     else
        strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //����Ƿ����
  CheckCalc(strtoInt(P2_D1.asString),StrtoInt(P2_D2.asString));
  mx := GetMaxMonth(StrtoInt(P2_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P2_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_MNY) as decimal(18,3))*100 else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';

  strSql :=
    'select j.* '+
    ' ,r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
    ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

function TfrmJxcTotalReport.GetSortSQL(chk:boolean=true): string;
var
  GodsStateIdx: integer; //���ͳ��ָ��Idx
  JoinCnd,mx,lv,LvField:string;
  strSql,strWhere,GoodTab:widestring;
begin
  Lv:='';
  LvField:='';
  result:='';
  if P3_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  //��Ʒָ��:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('��ѡ�񱨱�����...');
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  
  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;
  
  //�·�����:
  if (P3_D1.asString<>'') and (P3_D1.asString=P3_D2.asString) then
     strWhere:=strWhere+' and A.MONTH='+P3_D1.asString
  else if P3_D1.asString<P3_D2.asString then
     strWhere:=strWhere+' and A.MONTH>='+P3_D1.asString+' and A.MONTH<='+P3_D2.asString+' '
  else
     Raise Exception.Create('�����½᲻��С�ڿ�ʼ�·�...');

  //�ŵ�������������|�ŵ�����:
  if (fndP3_SHOP_VALUE.AsString<>'') then
    begin
      case fndP3_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
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
       LvField:=lv+' as LEVEL_ID';
     end;
   else
     GoodTab:='VIW_GOODSPRICE';
  end;
  //����Ƿ����
  CheckCalc(strtoInt(P3_D1.asString),StrtoInt(P3_D2.asString));
  mx := GetMaxMonth(StrtoInt(P3_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+inttoStr(GodsStateIdx)+LvField+',C.RELATION_ID '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P3_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',isnull(sum(STOCK_MNY),0)+isnull(sum(STOCK_TAX),0) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-sum(CHANGE1_CST)+sum(ADJ_CST) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID'+inttoStr(GodsStateIdx)+lv+',C.RELATION_ID';

  case GodsStateIdx of
    1:begin
       case Factor.iDbType of
        4: JoinCnd:=' and j.LEVEL_ID=substr(r.LEVEL_ID,1,length(j.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;

       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          'sum(nvl(ORG_AMT,0)) as ORG_AMT '+
          ',sum(nvl(ORG_RTL,0)) as ORG_RTL '+
          ',sum(nvl(ORG_CST,0)) as ORG_CST '+
          ',sum(nvl(STOCK_AMT,0)) as STOCK_AMT '+
          ',sum(nvl(STOCK_MNY,0)) as STOCK_MNY '+
          ',sum(nvl(STOCK_TAX,0)) as STOCK_TAX '+
          ',sum(nvl(STOCK_RTL,0)) as STOCK_RTL '+
          ',sum(nvl(STOCK_TTL,0)) as STOCK_TTL '+
          ',sum(nvl(SALE_AMT,0)) as SALE_AMT '+
          ',sum(nvl(SALE_RTL,0)) as SALE_RTL '+
          ',sum(nvl(SALE_MNY,0)) as SALE_MNY '+
          ',sum(nvl(SALE_TAX,0)) as SALE_TAX '+
          ',sum(nvl(SALE_TTL,0)) as SALE_TTL '+
          ',sum(nvl(SALE_CST,0)) as SALE_CST '+
          ',sum(nvl(SALE_PRF,0)) as SALE_PRF '+
          ',case when sum(nvl(SALE_MNY,0))<>0 then cast(sum(nvl(SALE_PRF,0)) as decimal(18,3))*100.00/cast(sum(nvl(SALE_MNY,0)) as decimal(18,3)) else 0 end SALE_RATE '+
          ',sum(nvl(DBIN_AMT,0)) as DBIN_AMT '+
          ',sum(nvl(DBIN_CST,0)) as DBIN_CST '+
          ',sum(nvl(DBOUT_AMT,0)) as DBOUT_AMT '+
          ',sum(nvl(DBOUT_CST,0)) as DBOUT_CST '+
          ',sum(nvl(CHANGE1_AMT,0)) as CHANGE1_AMT '+
          ',sum(nvl(CHANGE1_CST,0)) as CHANGE1_CST '+
          ',sum(nvl(CHANGE2_AMT,0)) as CHANGE2_AMT '+
          ',sum(nvl(CHANGE2_CST,0)) as CHANGE2_CST '+
          ',sum(nvl(CHANGE3_AMT,0)) as CHANGE3_AMT '+
          ',sum(nvl(CHANGE3_CST,0)) as CHANGE3_CST '+
          ',sum(nvl(CHANGE4_AMT,0)) as CHANGE4_AMT '+
          ',sum(nvl(CHANGE4_CST,0)) as CHANGE4_CST '+
          ',sum(nvl(CHANGE5_AMT,0)) as CHANGE5_AMT '+
          ',sum(nvl(CHANGE5_CST,0)) as CHANGE5_CST '+
          ',sum(nvl(BAL_AMT,0)) as BAL_AMT '+
          ',sum(nvl(BAL_MNY,0)) as BAL_MNY '+
          ',sum(nvl(BAL_RTL,0)) as BAL_RTL '+
          ',sum(nvl(BAL_CST,0)) as BAL_CST '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'') '+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
        'sum(ORG_AMT) as ORG_AMT '+
        ',sum(ORG_RTL) as ORG_RTL '+
        ',sum(ORG_CST) as ORG_CST '+
        ',sum(STOCK_AMT) as STOCK_AMT '+
        ',sum(STOCK_MNY) as STOCK_MNY '+
        ',sum(STOCK_TAX) as STOCK_TAX '+
        ',sum(STOCK_RTL) as STOCK_RTL '+
        ',sum(STOCK_TTL) as STOCK_TTL '+
        ',sum(SALE_AMT) as SALE_AMT '+
        ',sum(SALE_RTL) as SALE_RTL '+
        ',sum(SALE_MNY) as SALE_MNY '+
        ',sum(SALE_TAX) as SALE_TAX '+
        ',sum(SALE_TTL) as SALE_TTL '+
        ',sum(SALE_CST) as SALE_CST '+
        ',sum(SALE_PRF) as SALE_PRF '+
        ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_MNY)as decimal(18,3))*100.00 else 0 end SALE_RATE '+
        ',sum(DBIN_AMT) as DBIN_AMT '+
        ',sum(DBIN_CST) as DBIN_CST '+
        ',sum(DBOUT_AMT) as DBOUT_AMT '+
        ',sum(DBOUT_CST) as DBOUT_CST '+
        ',sum(CHANGE1_AMT) as CHANGE1_AMT '+
        ',sum(CHANGE1_CST) as CHANGE1_CST '+
        ',sum(CHANGE2_AMT) as CHANGE2_AMT '+
        ',sum(CHANGE2_CST) as CHANGE2_CST '+
        ',sum(CHANGE3_AMT) as CHANGE3_AMT '+
        ',sum(CHANGE3_CST) as CHANGE3_CST '+
        ',sum(CHANGE4_AMT) as CHANGE4_AMT '+
        ',sum(CHANGE4_CST) as CHANGE4_CST '+
        ',sum(CHANGE5_AMT) as CHANGE5_AMT '+
        ',sum(CHANGE5_CST) as CHANGE5_CST '+
        ',sum(BAL_AMT) as BAL_AMT '+
        ',sum(BAL_MNY) as BAL_MNY '+
        ',sum(BAL_RTL) as BAL_RTL '+
        ',sum(BAL_CST) as BAL_CST '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME '+
        ' from ('+strSql+') j left outer join VIW_CLIENTINFO r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
        'sum(ORG_AMT) as ORG_AMT '+
        ',sum(ORG_RTL) as ORG_RTL '+
        ',sum(ORG_CST) as ORG_CST '+
        ',sum(STOCK_AMT) as STOCK_AMT '+
        ',sum(STOCK_MNY) as STOCK_MNY '+
        ',sum(STOCK_TAX) as STOCK_TAX '+
        ',sum(STOCK_RTL) as STOCK_RTL '+
        ',sum(STOCK_TTL) as STOCK_TTL '+
        ',sum(SALE_AMT) as SALE_AMT '+
        ',sum(SALE_RTL) as SALE_RTL '+
        ',sum(SALE_MNY) as SALE_MNY '+
        ',sum(SALE_TAX) as SALE_TAX '+
        ',sum(SALE_TTL) as SALE_TTL '+
        ',sum(SALE_CST) as SALE_CST '+
        ',sum(SALE_PRF) as SALE_PRF '+
        ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.00/cast(sum(SALE_MNY) as decimal(18,3))*100.00 else 0 end SALE_RATE '+
        ',sum(DBIN_AMT) as DBIN_AMT '+
        ',sum(DBIN_CST) as DBIN_CST '+
        ',sum(DBOUT_AMT) as DBOUT_AMT '+
        ',sum(DBOUT_CST) as DBOUT_CST '+
        ',sum(CHANGE1_AMT) as CHANGE1_AMT '+
        ',sum(CHANGE1_CST) as CHANGE1_CST '+
        ',sum(CHANGE2_AMT) as CHANGE2_AMT '+
        ',sum(CHANGE2_CST) as CHANGE2_CST '+
        ',sum(CHANGE3_AMT) as CHANGE3_AMT '+
        ',sum(CHANGE3_CST) as CHANGE3_CST '+
        ',sum(CHANGE4_AMT) as CHANGE4_AMT '+
        ',sum(CHANGE4_CST) as CHANGE4_CST '+
        ',sum(CHANGE5_AMT) as CHANGE5_AMT '+
        ',sum(CHANGE5_CST) as CHANGE5_CST '+
        ',sum(BAL_AMT) as BAL_AMT '+
        ',sum(BAL_MNY) as BAL_MNY '+
        ',sum(BAL_RTL) as BAL_RTL '+
        ',sum(BAL_CST) as BAL_CST '+
        ',isnull(r.SORT_ID,''#'') as SID '+
        ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j '+
        ' left outer join (select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+InttoStr(GodsStateIdx)+') r '+
        ' on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+InttoStr(GodsStateIdx)+'=r.SORT_ID '+
        ' group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmJxcTotalReport.GetGodsSQL(chk:boolean=true): string;
var
  mx,SORT_ID:string;
  strSql,strWhere,GoodTab:widestring;
begin
  result:='';
  if P4_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //�·�����:
  if (P4_D1.asString<>'') and (P4_D1.asString=P4_D2.asString) then
    strWhere:=strWhere+' and A.MONTH='+P4_D1.asString
  else if P4_D1.asString<P4_D2.asString then
    strWhere:=strWhere+' and A.MONTH>='+P4_D1.asString+' and A.MONTH<='+P4_D2.asString+' '
  else
    Raise Exception.Create('�����½᲻��С�ڿ�ʼ�·�...');

  //�ŵ�������������|�ŵ�����:
  if (fndP4_SHOP_VALUE.AsString<>'') then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
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
    
  //�ŵ�����
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;

  //�����ֶ�
  case StrToInt(GodsSortIdx) of
   0: SORT_ID:='C.RELATION_ID';
   else
      SORT_ID:='case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end';
      //SORT_ID:='isnull(C.SORT_ID'+GodsSortIdx+',''#'')';
  end;

  //����Ƿ����
  CheckCalc(strtoInt(P4_D1.asString),StrtoInt(P4_D2.asString));
  mx := GetMaxMonth(StrtoInt(P4_D2.asString));
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ','+SORT_ID+' as SORT_ID '+
    ',A.GODS_ID '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as ORG_AMT '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_RTL else 0 end) as ORG_RTL '+
    ',sum(case when A.MONTH='+P4_D1.asString+' then ORG_CST else 0 end) as ORG_CST '+
    ',sum(STOCK_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as STOCK_AMT '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(SALE_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as SALE_AMT '+
    ',sum(SALE_RTL) as SALE_RTL '+
    ',sum(SALE_MNY) as SALE_MNY '+
    ',sum(SALE_TAX) as SALE_TAX '+
    ',isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as SALE_TTL '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_PRF) as SALE_PRF '+
    ',case when sum(SALE_MNY)<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end SALE_RATE '+
    ',sum(DBIN_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBIN_AMT '+
    ',sum(DBIN_CST) as DBIN_CST '+
    ',sum(DBOUT_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as DBOUT_AMT '+
    ',sum(DBOUT_CST) as DBOUT_CST '+
    ',-sum(CHANGE1_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE1_AMT '+
    ',-isnull(sum(CHANGE1_CST),0)+isnull(sum(ADJ_CST),0) as CHANGE1_CST '+
    ',-sum(CHANGE2_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE2_AMT '+
    ',-sum(CHANGE2_CST) as CHANGE2_CST '+
    ',-sum(CHANGE3_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE3_AMT '+
    ',-sum(CHANGE3_CST) as CHANGE3_CST '+
    ',-sum(CHANGE4_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE4_AMT '+
    ',-sum(CHANGE4_CST) as CHANGE4_CST '+
    ',-sum(CHANGE5_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+') as CHANGE5_AMT '+
    ',-sum(CHANGE5_CST) as CHANGE5_CST '+
    ',sum(case when A.MONTH='+mx+' then BAL_AMT*1.00/'+GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C')+' else 0 end) as BAL_AMT '+
    ',sum(case when A.MONTH='+mx+' then BAL_MNY else 0 end) as BAL_MNY '+
    ',sum(case when A.MONTH='+mx+' then BAL_RTL else 0 end) as BAL_RTL '+
    ',sum(case when A.MONTH='+mx+' then BAL_CST else 0 end) as BAL_CST '+
    'from RCK_GOODS_MONTH A,CA_SHOP_INFO B,'+GoodTab+' C '+
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
        'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE ';     
    end;
   else
    begin
      strSql :=
        'select j.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        '(select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
        ' on  j.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,j.GODS_CODE';
    end;
  end;
  Result :=  ParseSQL(Factor.iDbType, strSql);
end;

procedure TfrmJxcTotalReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true;
  P2_D1.asString := P1_D1.asString;
  P2_D2.asString := P1_D2.asString;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  Copy_ParamsValue('TYPE_ID',1,2);  //��Ʒָ��
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex; //��ʾ��λ
  fndP2_SHOP_TYPE.ItemIndex := 0;
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmJxcTotalReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true;  
  P3_D1.asString := P2_D1.asString;
  P3_D2.asString := P2_D2.asString;
  Copy_ParamsValue('SHOP_TYPE',2,3); //����Ⱥ��
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex; //��ʾ��λ
  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('SHOP_ID').AsString;
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('SHOP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil); 
end;

procedure TfrmJxcTotalReport.DBGridEh3DblClick(Sender: TObject);
var
  i,CodeID: integer;
  SortID: string;
  Aobj: TRecord_;
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true;
  //�϶��б�������:
  CodeID:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   1,3:
     if trim(adoReport3.FieldByName('SORT_NAME').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'���Ʋ���Ϊ�գ�');
   else
     if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'���Ʋ���Ϊ�գ�');
  end;

  sid4:='';
  srid4:='';
  fndP4_SORT_ID.Text:='';
  fndP4_TYPE_ID.ItemIndex:=-1;
  fndP4_STAT_ID.KeyValue:='';
  fndP4_STAT_ID.Text:='';

  case CodeID of
   1:  //��Ʒ����[����Ӧ����]
    begin
      sid4:=Copy(trim(adoReport3.fieldbyName('LEVEL_ID').AsString),8,100);
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

  P4_D1.asString := P3_D1.asString;
  P4_D2.asString := P3_D2.asString;
  Copy_ParamsValue('SHOP_TYPE',3,4); //����Ⱥ��
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID); //�ŵ�����
  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex; //��ʾ��λ

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

procedure TfrmJxcTotalReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmJxcTotalReport.fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.fndP4_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmJxcTotalReport.actPriorExecute(Sender: TObject);
begin
  if not HasChild and (rzPage.ActivePageIndex = 2) then Exit;
  inherited;
  
end;

procedure TfrmJxcTotalReport.CreateGrid;
var
  rs: TZQuery;
  Column: TColumnEh;
  CostPriceRight: Boolean;  //�鿴�ɱ���Ȩ��
begin
  DBGridEh1.Columns.BeginUpdate;
  DBGridEh2.Columns.BeginUpdate;
  DBGridEh3.Columns.BeginUpdate;
  DBGridEh4.Columns.BeginUpdate;    
  try
    CostPriceRight:=ShopGlobal.GetChkRight('14500001',2);
    rs := Global.GetZQueryFromName('STO_CHANGECODE');
    rs.First;
    while not rs.Eof do
    begin
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
      Column.Title.Caption := rs.Fields[1].AsString+'|����';
      Column.Width := 61;
      Column.Index := DBGridEh1.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';

      if CostPriceRight then  //�ж�ֻ�в鿴�ɱ��ſ��Դ�����
      begin
        Column := DBGridEh1.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh1.Columns.Count -4;
        Column.DisplayFormat:='#0.00';
        Column.Footer.ValueType:=fvtSum;
        Column.Footer.DisplayFormat:='#0.00';
      end;

      Column := DBGridEh2.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
      Column.Title.Caption := rs.Fields[1].AsString+'|����';
      Column.Width := 61;
      Column.Index := DBGridEh2.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';        

      if CostPriceRight then  //�ж�ֻ�в鿴�ɱ��ſ��Դ�����
      begin        
        Column := DBGridEh2.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh2.Columns.Count -4;
        Column.DisplayFormat:='#0.00';
        Column.Footer.ValueType:=fvtSum;
        Column.Footer.DisplayFormat:='#0.00';
      end;

      Column := DBGridEh3.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
      Column.Title.Caption := rs.Fields[1].AsString+'|����';
      Column.Width := 61;
      Column.Index := DBGridEh3.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';

      if CostPriceRight then  //�ж�ֻ�в鿴�ɱ��ſ��Դ�����
      begin
        Column := DBGridEh3.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh3.Columns.Count -4;
        Column.DisplayFormat:='#0.00';
        Column.Footer.ValueType:=fvtSum;
        Column.Footer.DisplayFormat:='#0.00';
      end;
        
      Column := DBGridEh4.Columns.Add;
      Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_AMT';
      Column.Title.Caption := rs.Fields[1].AsString+'|����';
      Column.Width := 61;
      Column.Index := DBGridEh4.Columns.Count -4;
      Column.DisplayFormat:='#0.00';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.00';

      if CostPriceRight then  //�ж�ֻ�в鿴�ɱ��ſ��Դ�����
      begin
        Column := DBGridEh4.Columns.Add;
        Column.FieldName := 'CHANGE'+rs.Fields[0].AsString+'_CST';
        Column.Title.Caption := rs.Fields[1].AsString+'|���';
        Column.Width := 74;
        Column.Index := DBGridEh4.Columns.Count -4;
        Column.DisplayFormat:='#0.00';
        Column.Footer.ValueType:=fvtSum;
        Column.Footer.DisplayFormat:='#0.00';
      end;
      rs.Next;
    end;
  finally
    DBGridEh1.Columns.EndUpdate;
    DBGridEh2.Columns.EndUpdate;
    DBGridEh3.Columns.EndUpdate;
    DBGridEh4.Columns.EndUpdate;
  end;
end;

procedure TfrmJxcTotalReport.CheckCalc(b, e: integer);
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
    rs.SQL.Text := 'select count(*) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and MONTH>=:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
      TfrmCostCalc.TryCalcMthGods(self);
  finally
    rs.Free;
  end;
end;

function TfrmJxcTotalReport.GetMaxMonth(E:integer): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(MONTH) from RCK_GOODS_MONTH where TENANT_ID=:TENANT_ID and MONTH<=:END_MONTH';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('END_MONTH').AsInteger := e;
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
       result := inttostr(e)
    else
       result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;

procedure TfrmJxcTotalReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

function TfrmJxcTotalReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //1���·�
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TzrMonthEdit) and (FindCmp2 is TzrMonthEdit) and
     (TzrMonthEdit(FindCmp1).Visible) and (TzrMonthEdit(FindCmp2).Visible)  then
    TitleList.add('�·ݣ�'+TzrMonthEdit(FindCmp1).asString+' �� '+TzrMonthEdit(FindCmp2).asString);

  //�̳л���
  inherited AddReportReport(TitleList,PageNo);
end;
                              
procedure TfrmJxcTotalReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmJxcTotalReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmJxcTotalReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
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

procedure TfrmJxcTotalReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
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
      if (Copy(ColName,1,4)='ORG_') or (Copy(ColName,1,6)='STOCK_') or
         (Copy(ColName,1,5)='SALE_') or (Copy(ColName,1,5)='DBIN_') or
         (Copy(ColName,1,6)='DBOUT_') or (Copy(ColName,1,4)='BAL_') then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end
    end;
  end;
end;

function TfrmJxcTotalReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';   
end;

procedure TfrmJxcTotalReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  //inherited;
  DBGridTitleClick(adoReport4,Column,'ORDER_ID');
end;

procedure TfrmJxcTotalReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

function TfrmJxcTotalReport.GetDataRight: string;
begin
  //�����ݣ�RCK_GOODS_MONTH A
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

