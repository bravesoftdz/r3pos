unit ufrmStorageDayReport;

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
  TfrmStorageDayReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel2: TRzLabel;
    P1_D1: TcxDateEdit;
    btnOk: TRzBitBtn;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel9: TRzPanel;
    RzLabel4: TRzLabel;
    P2_D1: TcxDateEdit;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsadoReport2: TDataSource;
    RzPanel6: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzLabel6: TRzLabel;
    P3_D1: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    dsadoReport3: TDataSource;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    RzLabel8: TRzLabel;
    P4_D1: TcxDateEdit;
    RzBitBtn3: TRzBitBtn;
    RzPanel15: TRzPanel;
    DBGridEh4: TDBGridEh;
    dsadoReport4: TDataSource;
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
    adoReport2: TZQuery;
    adoReport5: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    fndP4_ReckType: TcxComboBox;
    fndP3_ReckType: TcxComboBox;
    fndP2_ReckType: TcxComboBox;
    fndP1_ReckType: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
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
  private
    IsOnDblClick: Boolean;
    BAL_Date: integer;  //��ѯ�������[��ѯ������ڣ���ѯ��ǰ�����һ���ڳ�]

    GodsID: string;      //��ǰ˫����ϸ��GODS_IDs
    SortName: string;
    sid1,sid2,sid4,sid5: string;
    srid1,srid2,srid4,srid5: string;

    procedure CheckCalc(endDate:integer); //��ʼ�·�| �����·�
    //1�����������ۻ��ܱ�
    function GetGroupSQL(chk:boolean=true): string;
    //2�����ŵ����ۻ��ܱ�
    function GetShopSQL(chk:boolean=true): string;
    //3�����������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;
    //4������Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; //���Title
    procedure DoReckTypeOnChange(Sender: TObject); //
  public
    procedure PrintBefore;override;
    function GetRowType:integer;override;
  end;

implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ufrmCostCalc;

{$R *.dfm}

procedure TfrmStorageDayReport.FormCreate(Sender: TObject);
var
  i: integer;
  CmpName: string;
begin
  inherited;
  IsOnDblClick:=False;
  TDbGridEhSort.InitForm(self,false);
  for i:=0 to ComponentCount-1 do
  begin
    CmpName:=trim(LowerCase(TcxComboBox(Components[i]).Name));
    if Components[i] is TcxComboBox then
    begin
      if (Copy(CmpName,1,4)='fndp') and (RightStr(CmpName,9)='_recktype') then
        TcxComboBox(Components[i]).Properties.OnChange:=DoReckTypeOnChange; 
      TcxComboBox(Components[i]).ItemIndex:=0;
    end;
  end;

  SetRzPageActivePage; //����PzPage.Activepage

  RefreshColumn;
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
  end;
  //2011.04.22 Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh2, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh3, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh4, ['BAL_PRC','BAL_CST']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label12.Caption := '�ֿ�Ⱥ��';
      Label21.Caption := '�ֿ�����';
    end;
end;

function TfrmStorageDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,strWhere,GoodTab: string;
begin
  //������ҵID�Ͳ�ѯ����:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

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

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  //��������
  if fndP1_ReckType.ItemIndex=0 then //ֱ�Ӳ�ѯ����:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',REGION_ID'+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,B.REGION_ID,AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //�������
       ',AMONEY as BAL_CST '+     //�����
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //���۽��
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,REGION_ID ';
    Result :=  ParseSQL(Factor.iDbType,
      'select j.* '+
      ',isnull(r.CODE_NAME,''��'') as CODE_NAME from ('+strSql+') j '+
      ' left outer join '+
      ' (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID'
      );
  end else
  if fndP1_ReckType.ItemIndex=1 then
  begin
    if P1_D1.EditValue = null then Raise Exception.Create(' ������ڲ���Ϊ�գ�  '); 
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));
    //����Ƿ����
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and exists(select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where DD.CREA_DATE=DD.CREA_DATE and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';

    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',B.REGION_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,B.REGION_ID';

    strSql :=
      'select j.* '+
      ',isnull(r.CODE_NAME,''��'') as CODE_NAME '+
      ' from ('+strSql+') j '+
      ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO '+
      ' where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID';

    Result := ParseSQL(Factor.iDbType, strSql);
  end;
end;

function TfrmStorageDayReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmStorageDayReport.actFindExecute(Sender: TObject);
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

function TfrmStorageDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,strWhere,GoodTab: string;
begin
  //������ҵID�Ͳ�ѯ����:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

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

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');    
  //��������
  if fndP2_ReckType.ItemIndex=0 then //ֱ�Ӳ�ѯ����:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',SHOP_ID'+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(19,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,B.SHOP_ID,AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //�������
       ',AMONEY as BAL_CST '+     //�����
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //���۽��
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,SHOP_ID ';
    Result :=  ParseSQL(Factor.iDbType,
      'select j.* '+
      ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
      ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
      );
  end else
  if fndP2_ReckType.ItemIndex=1 then
  begin
    if P2_D1.EditValue = null then Raise Exception.Create(' ������ڲ���Ϊ�գ�  ');
    //����Ƿ����
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //�������=+1��ȡ�ڳ�
    CheckCalc(BAL_Date);

    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.SHOP_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when sum(BAL_AMT)<>0 then sum(BAL_CST)*1.00/sum(BAL_AMT*1.00/'+UnitCalc+') else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when sum(BAL_AMT)<>0 then sum(BAL_RTL*1.00)/sum(BAL_AMT*1.00/'+UnitCalc+') else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,A.SHOP_ID';

    strSql :=
      'select j.TENANT_ID'+
      ',j.SHOP_ID '+
      ',j.BAL_AMT '+
      ',j.BAL_PRC '+
      ',j.BAL_OUTPRC '+
      ',j.BAL_RTL '+    
      ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME '+
      ' from ('+strSql+') j '+
      ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO';

    result:=ParseSQL(Factor.iDbType, strSql);
  end;
end;

function TfrmStorageDayReport.GetSortSQL(chk:boolean=true): string;
var
  UnitCalc,JoinCnd: string;
  strSql,strWhere,GoodTab,lv,lv1: string;
begin
  lv:='';
  lv1:='';
  result:='';
  //������ҵID�Ͳ�ѯ����:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

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
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',C.LEVEL_ID';
      lv1 := ',LEVEL_ID';
    end;
  else
    GoodTab:='VIW_GOODSPRICE';
  end;


  //��λ����
  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  //��������
  if fndP3_ReckType.ItemIndex=0 then //ֱ�Ӳ�ѯ����:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',GODS_ID,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6'+lv1+',RELATION_ID '+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
       ',AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+    //�������
       ',AMONEY as BAL_CST '+                 //�����
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //���۽��
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      'group by TENANT_ID,GODS_ID,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6'+lv1+',RELATION_ID';
  end else
  if fndP3_ReckType.ItemIndex=1 then //ֱ�Ӳ�ѯ����:
  begin
    //����Ƿ����
    if P3_D1.EditValue = null then Raise Exception.Create(' ������ڲ���Ϊ�գ�  ');    
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //�������=+1��ȡ�ڳ�
    CheckCalc(BAL_Date);
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',sum(BAL_CST) as BAL_CST '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6'+lv+',C.RELATION_ID';
  end;

  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
      //�������͹���
       case Factor.iDbType of
        4: JoinCnd:=' and r.LEVEL_ID=substr(j.LEVEL_ID,1,length(r.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(nvl(BAL_AMT,0)) as BAL_AMT '+
          ',case when sum(nvl(BAL_AMT,0))<>0 then cast(sum(nvl(BAL_CST,0)) as decimal(18,3))*1.00/cast(sum(nvl(BAL_AMT,0)) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(nvl(BAL_CST,0)) as BAL_CST '+
          ',case when sum(nvl(BAL_AMT,0))<>0 then cast(sum(nvl(BAL_RTL,0)) as decimal(18,3))*1.00/cast(sum(nvl(BAL_AMT,0)) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(nvl(BAL_RTL,0)) as BAL_RTL '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)+1)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select RELATION_ID,SORT_ID,SORT_NAME,LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+            
          'select distinct RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,'''' as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'')) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+' group by j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME order by j.RELATION_ID,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(BAL_AMT) as BAL_AMT '+
          ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_TTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(BAL_CST) as BAL_CST '+
          ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(BAL_RTL) as BAL_RTL '+
          ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(BAL_AMT) as BAL_AMT '+
          ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_TTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(BAL_CST) as BAL_CST '+
          ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(BAL_RTL) as BAL_RTL '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+' '+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmStorageDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc: string;
  strSql,strWhere,GoodTab: string;
begin
  //������ҵID�Ͳ�ѯ����:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';

  //�ŵ�������������|�ŵ�����:
  if (fndP4_SHOP_VALUE.AsString<>'') then
    begin
      case fndP4_SHOP_TYPE.ItemIndex of
      0:strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
      end;
    end;

  //�ŵ�����
  if (fndP4_SHOP_ID.AsString<>'') then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';

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

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  //��������
  if fndP4_ReckType.ItemIndex=0 then //ֱ�Ӳ�ѯ����:
  begin
    strSql :=
      'select '+
      ' TENANT_ID,GODS_ID,CALC_BARCODE,GODS_CODE,GODS_NAME,PROPERTY_01,BATCH_NO,PROPERTY_02,UNIT_ID  '+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,A.GODS_ID,c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME,'+
       ' ''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' as UNIT_ID '+
       ',AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //�������
       ',AMONEY as BAL_CST '+     //�����
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //���۽��
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,GODS_ID,CALC_BARCODE,GODS_CODE,GODS_NAME,PROPERTY_01,BATCH_NO,PROPERTY_02,UNIT_ID ';

    strSql :=
        'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by j.GODS_CODE';

    result:=ParseSQL(Factor.iDbType, strSql);
  end else
  if fndP4_ReckType.ItemIndex=1 then //ֱ�Ӳ�ѯ����:  
  begin
    if P4_D1.EditValue = null then Raise Exception.Create(' ������ڲ���Ϊ�գ�  ');      
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));
    //����Ƿ����
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and exists(select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where DD.CREA_DATE=DD.CREA_DATE and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GODS_ID '+
      ',c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' as UNIT_ID  '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when sum(BAL_AMT)<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,A.GODS_ID,c.BARCODE,c.GODS_CODE,c.GODS_NAME,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' ';

    strSql :=
      'select j.*,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from '+
      ' ('+strSql+') j '+
      ' left outer join '+
      ' (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
      '   on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
      ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
      '  order by j.GODS_CODE ';
     
     result:=ParseSQL(Factor.iDbType, strSql);
  end;
end;

procedure TfrmStorageDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true;
  //���Ʋ�ѯ��������
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text:=fndP1_SORT_ID.Text;

  P1_D1.Date := P2_D1.Date;
  fndP2_ReckType.ItemIndex:=fndP1_ReckType.ItemIndex;
  fndP2_SHOP_TYPE.ItemIndex:=0;  //����Ⱥ��
  fndP2_SHOP_VALUE.KeyValue:=trim(adoReport1.fieldbyName('REGION_ID').AsString);
  fndP2_SHOP_VALUE.Text:=trim(adoReport1.fieldbyName('CODE_NAME').AsString);
  Copy_ParamsValue('TYPE_ID',1,2);  //��Ʒָ��
  fndP2_UNIT_ID.ItemIndex:=fndP1_UNIT_ID.ItemIndex; //��ʾ��λ
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmStorageDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true;
  //��ѯ����
  fndP3_ReckType.ItemIndex:=fndP2_ReckType.ItemIndex;
  P3_D1.Date:=P2_D1.Date;
  Copy_ParamsValue('SHOP_TYPE',2,3); //����Ⱥ��
  fndP3_SHOP_ID.KeyValue:=adoReport2.fieldbyName('SHOP_ID').AsString; //�ŵ�ID
  fndP3_SHOP_ID.Text:=adoReport2.fieldbyName('SHOP_NAME').AsString;   //�ŵ����� 
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex;  //��ʾ��λ

  rzPage.ActivePageIndex := 2;
  actFind.OnExecute(nil);
end;

procedure TfrmStorageDayReport.DBGridEh3DblClick(Sender: TObject);
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

  case CodeID of
   1:  //��Ʒ����[����Ӧ����]
    begin
      sid4:=trim(adoReport3.fieldbyName('LEVEL_ID').AsString);
      srid4:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
      fndP4_SORT_ID.Text:=trim(adoReport3.FieldByName('SORT_NAME').AsString);
    end;
   else
    begin
      fndP4_TYPE_ID.ItemIndex:=-1;
      for i:=0 to fndP4_TYPE_ID.Properties.Items.Count-1 do
      begin
        Aobj:=TRecord_(fndP4_TYPE_ID.Properties.Items.Objects[fndP4_TYPE_ID.ItemIndex]);
        if (Aobj<>nil) and (Aobj.FieldByName('CODE_ID').AsInteger=CodeID) then
        begin
          fndP4_TYPE_ID.ItemIndex:=i;
          case CodeID of
           3: fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SORT_ID').AsString);
           else fndP4_STAT_ID.KeyValue:=trim(adoReport3.fieldbyName('SID').AsString);
          end;
          fndP4_STAT_ID.Text:=trim(adoReport3.fieldbyName('SORT_NAME').AsString);
          break;
        end;
      end;
    end;
  end;

  //��ѯ����
  fndP4_ReckType.ItemIndex:=fndP3_ReckType.ItemIndex;
  P4_D1.Date:=P3_D1.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4);  //����Ⱥ��
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID);  //�ŵ�����
  fndP4_UNIT_ID.ItemIndex:=fndP3_UNIT_ID.ItemIndex;  //��ʾ��λ
  rzPage.ActivePageIndex := 3;
  actFind.OnExecute(nil);
end;

procedure TfrmStorageDayReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;

end;

procedure TfrmStorageDayReport.PrintBefore;
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

procedure TfrmStorageDayReport.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmStorageDayReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 :='';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmStorageDayReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 :='';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmStorageDayReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 :='';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmStorageDayReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if self.SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmStorageDayReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmStorageDayReport.fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh3);
end;

procedure TfrmStorageDayReport.CheckCalc(endDate: integer);
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
    rs.ParamByName('CREA_DATE').AsInteger := endDate;
    Factor.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       TfrmCostCalc.TryCalcDayGods(self);
  finally
    rs.Free;
  end;
end;

function TfrmStorageDayReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  if (FindCmp1<>nil) and (FindCmp1 is TcxDateEdit) and (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp1).EditValue<>null) then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date));
 //�ŵ����ƣ�
 FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_ID');
 if (FindCmp1<>nil) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
   TitleList.Add('�ŵ����ƣ�'+TzrComboBoxList(FindCmp1).Text);
  //����Ⱥ�飺
  FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_TYPE');  
  FindCmp2:=FindComponent('fndP'+PageNo+'_SHOP_VALUE');   
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList)  and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'')  then
    TitleList.add(TcxComboBox(FindCmp1).Text+'��'+TzrComboBoxList(FindCmp2).Text);
  //��Ʒָ�꣺
  FindCmp1:=FindComponent('fndP'+PageNo+'_TYPE_ID');   
  FindCmp2:=FindComponent('fndP'+PageNo+'_STAT_ID');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList) and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'') then
    TitleList.add(TcxComboBox(FindCmp1).Text+'��'+TzrComboBoxList(FindCmp2).Text);
  //��Ʒ����
  FindCmp1:=FindComponent('fndP'+PageNo+'_SORT_ID');
  if (FindCmp1<>nil) and (FindCmp1 is TcxButtonEdit) and (TcxButtonEdit(FindCmp1).Visible) and (TcxButtonEdit(FindCmp1).Text<>'') then
    TitleList.Add('��Ʒ���ࣺ'+TcxButtonEdit(FindCmp1).Text);   
  //������λ
  FindCmp1:=FindComponent('fndP'+PageNo+'_UNIT_ID'); 
  if (FindCmp1<>nil) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex<>-1) then
    TitleList.Add('ͳ�Ƶ�λ��'+TcxComboBox(FindCmp1).Text);
end;

procedure TfrmStorageDayReport.DoReckTypeOnChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //���ؿؼ�Num
  if CmpName<>'' then
  begin
    CmpName:='P'+CmpName+'_D1';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TcxDateEdit) then
    begin
      TcxDateEdit(FindCmp).Visible:=(TcxComboBox(Sender).ItemIndex<>0);
      if (TcxDateEdit(FindCmp).Visible) and (trim(TcxDateEdit(FindCmp).Text)='') then
        TcxDateEdit(FindCmp).Date:=Date();
    end;
  end;
end;

procedure TfrmStorageDayReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmStorageDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmStorageDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmStorageDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then Text := '�ϼ�:'+Text+'��';
end;

end.

