unit ufrmStockDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup, ObjCommon;

type
  TfrmStockDayReport = class(TframeBaseReport)
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
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label28: TLabel;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_UNIT_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_ID: TzrComboBoxList;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    Label29: TLabel;
    fndP5_ALL: TcxRadioButton;
    fndP5_InStock: TcxRadioButton;
    fndP5_ReturnStock: TcxRadioButton;
    adoReport2: TZQuery;
    adoReport5: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
  public
    { Public declarations }
    HasChild:boolean;  
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil;

{$R *.dfm}

procedure TfrmStockDayReport.FormCreate(Sender: TObject);
begin
  inherited;     
  TDbGridEhSort.InitForm(self,false);
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

  HasChild := (ShopGlobal.GetZQueryFromName('CA_SHOP_INFO').RecordCount>1);
  rzPage.Pages[0].TabVisible := HasChild;
  rzPage.Pages[1].TabVisible := HasChild;
  if not HasChild then
    rzPage.ActivePageIndex := 2
  else
    rzPage.ActivePageIndex := 0;

  RefreshColumn;
end;

function TfrmStockDayReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //�ŵ�������������|�ŵ�����:
  if (fndP1_SHOP_VALUE.AsString<>'') then
    begin
      case fndP1_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //��Ʒָ��:
  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP1_TYPE_ID.Properties.Items.Objects[fndP1_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP1_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP1_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP1_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP1_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP1_STAT_ID.AsString+''' ';
      end;
     end;
  //��Ʒ����:
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid1+''' ';
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';   

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //��������
  if (vBegDate>0) and (vBegDate=vEndDate) then
    StrCnd:=StrCnd+' and CREA_DATE='+InttoStr(vBegDate)
  else if vBegDate<vEndDate then
    StrCnd:=StrCnd+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';
  //ȡ�ս����������:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData := '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[��ʼ���ڵ� ̨��������� ��ѯ̨�˱�]  Union  [̨���������  �� ��������]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      '(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>'+InttoStr(RckMaxDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';
  end;
 
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',B.REGION_ID '+
    ',sum(STOCK_AMT) as STOCK_AMT '+
    ',case when sum(STOCK_AMT)<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX))/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when (sum(STOCK_MNY)+sum(STOCK_TAX))<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX)-sum(STOCK_AGO))*100/(sum(STOCK_MNY)+sum(STOCK_TAX)) else 0 end as STOCK_RATE '+
    ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,B.REGION_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',isnull(r.CODE_NAME,''��'') as CODE_NAME from ('+strSql+') j left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8 and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID'
    ); 
end;

function TfrmStockDayReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmStockDayReport.actFindExecute(Sender: TObject);
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

function TfrmStockDayReport.GetShopSQL(chk:boolean=true): string;
var
  strSql,StrCnd,strWhere,GoodTab,SQLData: widestring;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

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
      case TRecord_(fndP2_TYPE_ID.Properties.Items.Objects[fndP2_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP2_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP2_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP2_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP2_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP2_STAT_ID.AsString+''' ';
      end;
     end;
  //��Ʒ����:
  if (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid2+''' ';
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //��������
  if (vBegDate>0) and (vBegDate=vEndDate) then
    StrCnd:=StrCnd+' and CREA_DATE='+InttoStr(vBegDate)
  else if vBegDate<vEndDate then
    StrCnd:=StrCnd+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' '; 
  //ȡ�ս����������:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData := '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[��ʼ���ڵ� ̨��������� ��ѯ̨�˱�]  Union  [̨���������  �� ��������]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      '(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>'+InttoStr(RckMaxDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';
  end;

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.SHOP_ID '+
    ',sum(STOCK_AMT) as STOCK_AMT '+
    ',case when sum(STOCK_AMT)<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX))/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when (sum(STOCK_MNY)+sum(STOCK_TAX))<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX)-sum(STOCK_AGO))*100/(sum(STOCK_MNY)+sum(STOCK_TAX)) else 0 end as STOCK_RATE '+
    ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.SHOP_ID';
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
    );

end;

function TfrmStockDayReport.GetSortSQL(chk:boolean=true): string;
var
  strSql,strCnd,strWhere,GoodTab,SQLData,lv: widestring;
begin
  result:='';
  strWhere:='';
  if P3_D1.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('������������Ϊ��');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

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

  //��Ʒָ��:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('��ѡ�񱨱�����...');
  //��Ʒ����:
  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:begin
      GoodTab:='VIW_GOODSINFO_SORTEXT';
      lv := ',C.LEVEL_ID';
    end;
  else
    GoodTab:='VIW_GOODSINFO';
  end;

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //��������
  if (vBegDate>0) and (vBegDate=vEndDate) then
    StrCnd:=StrCnd+' and CREA_DATE='+InttoStr(vBegDate)
  else if vBegDate<vEndDate then
    StrCnd:=StrCnd+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' '; 
  //ȡ�ս����������:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate,trim(fndP3_SHOP_ID.AsString));
  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData := '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[��ʼ���ڵ� ̨��������� ��ѯ̨�˱�]  Union  [̨���������  �� ��������]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      '(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>'+InttoStr(RckMaxDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';
  end;

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
    ',sum(STOCK_AMT) as STOCK_AMT '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when (sum(STOCK_MNY)+sum(STOCK_TAX))<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX)-sum(STOCK_AGO))*100/(sum(STOCK_MNY)+sum(STOCK_TAX)) else 0 end as STOCK_RATE '+
    ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID';

  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(STOCK_AMT) as STOCK_AMT '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_TTL)/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
          ',sum(STOCK_TTL) as STOCK_TTL '+
          ',sum(STOCK_MNY) as STOCK_MNY '+
          ',sum(STOCK_TAX) as STOCK_TAX '+
          ',sum(STOCK_RTL) as STOCK_RTL '+
          ',case when sum(STOCK_TTL)<>0 then (sum(STOCK_TTL)-sum(STOCK_AGO))*100/sum(STOCK_TTL) else 0 end as STOCK_RATE '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
          ',sum(STOCK_AGO) as STOCK_AGO '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 '+
          'union all '+
          'select distinct RELATION_ID,cast(RELATION_ID as varchar) as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID and r.LEVEL_ID like j.LEVEL_ID'+GetStrJoin(Factor.iDbType)+'''%'' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(STOCK_AMT) as STOCK_AMT '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_TTL)/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
          ',sum(STOCK_TTL) as STOCK_TTL '+
          ',sum(STOCK_MNY) as STOCK_MNY '+
          ',sum(STOCK_TAX) as STOCK_TAX '+
          ',sum(STOCK_RTL) as STOCK_RTL '+
          ',case when sum(STOCK_TTL)<>0 then (sum(STOCK_TTL)-sum(STOCK_AGO))*100/sum(STOCK_TTL) else 0 end as STOCK_RATE '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
          ',sum(STOCK_AGO) as STOCK_AGO '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(STOCK_AMT) as STOCK_AMT '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_TTL)/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
          ',sum(STOCK_TTL) as STOCK_TTL '+
          ',sum(STOCK_MNY) as STOCK_MNY '+
          ',sum(STOCK_TAX) as STOCK_TAX '+
          ',sum(STOCK_RTL) as STOCK_RTL '+
          ',case when sum(STOCK_TTL)<>0 then (sum(STOCK_TTL)-sum(STOCK_AGO))*100/sum(STOCK_TTL) else 0 end as STOCK_RATE '+
          ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
          ',sum(STOCK_AGO) as STOCK_AGO '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='''+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+''''+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmStockDayReport.GetGodsSQL(chk:boolean=true): string;
var
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

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
      case TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[fndP4_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP4_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP4_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP4_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP4_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP4_STAT_ID.AsString+''' ';
      end;
     end;
  //��Ʒ����:
  if (trim(fndP4_SORT_ID.Text)<>'') and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid4+''' ';
    if trim(sid4)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //��������
  if (vBegDate>0) and (vBegDate=vEndDate) then
    StrCnd:=StrCnd+' and CREA_DATE='+InttoStr(vBegDate)
  else if vBegDate<vEndDate then
    StrCnd:=StrCnd+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' '; 
  //ȡ�ս����������:
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate,trim(fndP4_SHOP_ID.AsString));
  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
    SQLData:='(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else if RckMaxDate > vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData := '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  else //--[��ʼ���ڵ� ̨��������� ��ѯ̨�˱�]  Union  [̨���������  �� ��������]
  begin
    SQLData:=
      '(select TENANT_ID,SHOP_ID,GODS_ID,STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO from RCK_GOODS_DAYS TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      '(select TENANT_ID,SHOP_ID,GODS_ID,CALC_AMOUNT as STOCK_AMT,NOTAX_MONEY as STOCK_MNY,TAX_MONEY as STOCK_TAX,CALC_MONEY+AGIO_MONEY as STOCK_RTL,AGIO_MONEY as STOCK_AGO from VIW_STOCKDATA TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>'+InttoStr(RckMaxDate)+' and CREA_DATE<='+InttoStr(vEndDate)+' ';
  end;

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID '+
    ',sum(STOCK_AMT) as STOCK_AMT '+
    ',case when sum(STOCK_AMT)<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX))/sum(STOCK_AMT) else 0 end as STOCK_PRC '+
    ',sum(STOCK_MNY)+sum(STOCK_TAX) as STOCK_TTL '+
    ',sum(STOCK_MNY) as STOCK_MNY '+
    ',sum(STOCK_TAX) as STOCK_TAX '+
    ',sum(STOCK_RTL) as STOCK_RTL '+
    ',case when (sum(STOCK_MNY)+sum(STOCK_TAX))<>0 then (sum(STOCK_MNY)+sum(STOCK_TAX)-sum(STOCK_AGO))*100/(sum(STOCK_MNY)+sum(STOCK_TAX)) else 0 end as STOCK_RATE '+
    ',case when sum(STOCK_AMT)<>0 then sum(STOCK_AGO)/sum(STOCK_AMT) else 0 end as AVG_AGIO '+
    ',sum(STOCK_AGO) as STOCK_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID';
    
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '
    );
  result := 'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+result+') j '+
            'left outer join VIW_BARCODE b '+
            'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
            'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID ';
  result := result +  ' order by j.GODS_CODE';
end;

function TfrmStockDayReport.GetGlideSQL(chk:boolean=true): string;
var
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+'';

  //GodsID��Ϊ�գ�
  if trim(GodsID)<>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';

  //�·�����:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.STOCK_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.STOCK_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.STOCK_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' '
  else


  //�ŵ�������������|�ŵ�����:
  if (fndP5_SHOP_VALUE.AsString<>'') then
    begin
      case fndP5_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
      end;
    end;
  //��Ʒָ��:
  if (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
     begin
      case TRecord_(fndP5_TYPE_ID.Properties.Items.Objects[fndP5_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP5_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP5_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndP5_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP5_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP5_STAT_ID.AsString+''' ';
      end;
     end;
  //��Ʒ����:
  if (trim(fndP5_SORT_ID.Text)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    strWhere := strWhere+' and C.RELATION_ID='''+srid5+''' ';
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  SQLData := 'VIW_STOCKDATA';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.STOCK_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.CLIENT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.SHOP_ID '+
    ',A.GUIDE_USER '+
    ',A.STOCK_TYPE '+
    ',A.AMOUNT '+
    ',A.APRICE '+
    ',A.CALC_MONEY '+
    ',A.NOTAX_MONEY '+
    ',A.TAX_MONEY '+
    ',A.AGIO_MONEY '+
    ',A.AGIO_RATE '+
    ',A.CALC_MONEY+A.AGIO_MONEY as RTL_MONEY '+
    ',B.SHOP_NAME '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';
    
  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',c.CLIENT_NAME as CLIENT_NAME '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j left outer join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    'left outer join VIW_BARCODE b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    'left outer join VIW_CLIENTINFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    'left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    'left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '
    );
  result := result +  ' order by j.STOCK_DATE,r.GODS_CODE';
end;

procedure TfrmStockDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  P2_D1.Date := P1_D1.Date;
  P2_D2.Date := P1_D2.Date;
  fndP2_SORT_ID.Text := fndP1_SORT_ID.Text;
  sid2 := sid1;
  srid2 := srid1;
  fndP2_TYPE_ID.ItemIndex := fndP1_TYPE_ID.ItemIndex;
  fndP2_STAT_ID.KeyValue := fndP1_STAT_ID.KeyValue;
  fndP2_STAT_ID.Text := fndP1_STAT_ID.Text;
  fndP2_UNIT_ID.ItemIndex := fndP1_UNIT_ID.ItemIndex;
  fndP2_SHOP_TYPE.ItemIndex := 0;
  fndP2_SHOP_VALUE.KeyValue := adoReport1.FieldbyName('REGION_ID').AsString;
  fndP2_SHOP_VALUE.Text := adoReport1.FieldbyName('CODE_NAME').AsString;
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  P3_D1.Date := P2_D1.Date;
  P3_D2.Date := P2_D2.Date;
  fndP3_UNIT_ID.ItemIndex := fndP2_UNIT_ID.ItemIndex;

  fndP3_SHOP_TYPE.ItemIndex := fndP2_SHOP_TYPE.ItemIndex;
  fndP3_SHOP_VALUE.KeyValue := fndP2_SHOP_VALUE.KeyValue;
  fndP3_SHOP_VALUE.Text := fndP2_SHOP_VALUE.Text;

  fndP3_SHOP_ID.KeyValue := adoReport2.FieldbyName('SHOP_ID').AsString;
  fndP3_SHOP_ID.Text := adoReport2.FieldbyName('SHOP_NAME').AsString;
  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.DBGridEh3DblClick(Sender: TObject);
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
   3: if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create('�������Ʋ���Ϊ�գ�');
   else
      if trim(adoReport3.FieldByName('SORT_ID').AsString)='' then Raise Exception.Create('�������Ʋ���Ϊ�գ�');
  end;
  
  case CodeID of
   1:  //��Ʒ����[����Ӧ����]
    begin
      sid2:=trim(adoReport3.fieldbyName('LEVEL_ID').AsString);
      srid2:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_SORT_ID.Text:=trim(adoReport3.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP4_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP4_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          break;
        end;
      end;
      if fndP4_TYPE_ID.ItemIndex<>-1 then
      begin
        if CodeID=3 then fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString)
        else fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
        fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
      end;
    end;
  end;

  P4_D1.Date := P3_D1.Date;
  P4_D2.Date := P3_D2.Date;

  fndP4_SHOP_TYPE.ItemIndex := fndP3_SHOP_TYPE.ItemIndex;
  fndP4_SHOP_VALUE.KeyValue := fndP3_SHOP_VALUE.KeyValue;
  fndP4_SHOP_VALUE.Text := fndP3_SHOP_VALUE.Text;

  fndP4_UNIT_ID.ItemIndex := fndP3_UNIT_ID.ItemIndex;
  fndP4_SHOP_ID.KeyValue := fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text := fndP3_SHOP_ID.Text;
  
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmStockDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmStockDayReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('��ѡ���ѯ��ˮ�ʵ���Ʒ...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  sid5:=sid4;
  srid5:=srid4;
  DoAssignParamsValue(RzPanel14, RzPanel17);
end;

procedure TfrmStockDayReport.PrintBefore;
var
  s:string;
  c:integer;
begin
  inherited;
{
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  case rzPage.ActivePageIndex of
  0:begin
      c := 0;
      inc(c);
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P1_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P1_D2.Date);
      if fndP1_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP1_GROUP_ID.Text+'('+fndP1_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP1_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP1_CUST_ID.Text;
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
      if fndP1_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP1_INVOICE_FLAG.Text;
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
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P2_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P2_D2.Date);
      if fndP2_GROUP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�������ƣ�'+fndP2_GROUP_ID.Text+'('+fndP2_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP2_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP2_CUST_ID.Text;
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
      if fndP2_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP2_INVOICE_FLAG.Text;
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
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P3_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P3_D2.Date);
      if fndP3_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP3_COMP_ID.Text+'('+fndP3_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP3_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP3_CUST_ID.Text;
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
      if fndP3_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP3_INVOICE_FLAG.Text;
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
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P4_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P4_D2.Date);
      if fndP4_COMP_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ƣ�'+fndP4_COMP_ID.Text+'('+fndP4_COMP_TYPE.Text+')';
           inc(c);
         end;
      if fndP4_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP4_CUST_ID.Text;
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
      if fndP4_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP4_INVOICE_FLAG.Text;
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
      s := '���ڣ�'+formatDatetime('YYYY-MM-DD',P5_D1.Date)+' �� '+formatDatetime('YYYY-MM-DD',P5_D2.Date);
      if fndP5_COMP_TYPE.ItemIndex>=0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '�ŵ����ͣ�'+fndP5_COMP_TYPE.Text;
           inc(c);
         end;
      if fndP5_CUST_ID.AsString <> '' then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + '��Ա���ƣ�'+fndP5_CUST_ID.Text;
           inc(c);
         end;
      if fndP5_INVOICE_FLAG.ItemIndex >= 0 then
         begin
           if c mod 2= 1 then s := s + '    ' else s := s + #13;
           s := s + 'Ʊ�����ͣ�'+fndP5_INVOICE_FLAG.Text;
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

procedure TfrmStockDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 :='';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 :='';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 :='';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmStockDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmStockDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

procedure TfrmStockDayReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  DBGridDrawColumn(Sender,Rect,DataCol,Column,State,'GLIDE_NO');
end;

end.

