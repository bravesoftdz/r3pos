unit ufrmSaleAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ActnList, Menus,
  ComCtrls, ToolWin, StdCtrls, RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, cxEdit, 
  RzButton, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxControls,
  cxContainer, cxTextEdit, cxMaskEdit, uframeBaseAnaly, TeEngine,
  Series, TeeProcs, Chart, cxMemo, cxRadioGroup,ZBase, zrMonthEdit,
  cxSpinEdit;

type
  TfrmSaleAnaly = class(TframeBaseAnaly)
    RzLabel2: TRzLabel;
    Label5: TLabel;
    Label7: TLabel;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_SHOP_TYPE: TcxComboBox;
    P1_D1: TcxDateEdit;
    RzLabel3: TRzLabel;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    fndP1_STAT_ID: TzrComboBoxList;
    P1_D2: TcxDateEdit;
    Label6: TLabel;
    Label31: TLabel;
    fndP1_GODS_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    btnOk: TRzBitBtn;
    Pnl_Mm: TRzPanel;
    Pnl_Char: TRzPanel;
    Chart1: TChart;
    BarSeries1: TBarSeries;
    AnalyInfo: TcxMemo;
    RzTool: TRzPanel;
    RzPanel9: TRzPanel;
    RB_hour: TcxRadioButton;
    RB_week: TcxRadioButton;
    Label1: TLabel;
    RzPanel6: TRzPanel;
    RB_all: TcxRadioButton;
    RB_sale: TcxRadioButton;
    RB_batch: TcxRadioButton;
    Label3: TLabel;
    Label2: TLabel;
    Label32: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_Sale_UNIT: TcxComboBox;
    Label4: TLabel;
    AnalyQry1: TZQuery;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    RzPnl2: TRzPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    RzBitBtn1: TRzBitBtn;
    RzPanel10: TRzPanel;
    P2_RB_Money: TcxRadioButton;
    P2_RB_PRF: TcxRadioButton;
    fndP2_DEPT_ID: TzrComboBoxList;
    RzLabel1: TRzLabel;
    P2_D1: TcxDateEdit;
    RzLabel4: TRzLabel;
    P2_D2: TcxDateEdit;
    adoReport2: TZQuery;
    dsadoReport2: TDataSource;
    P2_RB_AMT: TcxRadioButton;
    RzPanel11: TRzPanel;
    Panel2: TPanel;
    RzPnl3: TRzPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    fndP3_TYPE_ID: TcxComboBox;
    fndP3_SHOP_TYPE: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_STAT_ID: TzrComboBoxList;
    fndP3_SORT_ID: TcxButtonEdit;
    RzBitBtn2: TRzBitBtn;
    fndP3_DEPT_ID: TzrComboBoxList;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    adoReport3: TZQuery;
    dsadoReport3: TDataSource;
    Label11: TLabel;
    RzPanel8: TRzPanel;
    RB_SaleMoney: TcxRadioButton;
    RB_SaleMount: TcxRadioButton;
    RB_PRF: TcxRadioButton;
    CB_Color: TCheckBox;
    EdtvType: TcxComboBox;
    PnlSB2: TRzPanel;
    PnlS: TRzPanel;
    PnlSB3: TRzPanel;
    PnlSB: TRzPanel;
    SB2: TScrollBox;
    SB3: TScrollBox;
    Label17: TLabel;
    fndP1UNIT_ID: TcxComboBox;
    Label19: TLabel;
    fndP2UNIT_ID: TcxComboBox;
    Label20: TLabel;
    edtMoneyUnit: TcxComboBox;
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure RzPanel7Resize(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RB_SaleMoneyClick(Sender: TObject);
    procedure fndP1_Sale_UNITPropertiesChange(Sender: TObject);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP3_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure CB_ColorClick(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure P2_RB_MoneyClick(Sender: TObject);
    procedure P2_RB_PRFClick(Sender: TObject);
    procedure P2_RB_AMTClick(Sender: TObject);
  private
    SortName: string;  //��Ʒ��������
    sid1,sid2,sid3: string;        //��Ʒ����ID
    srid1,srid2,srid3: string;     //��Ʒ��Ӧ����ϵID
    function  FormateStr(const InStr, Format: string): string;
    procedure AddFillChat1;
    function  GetMarketAnalySQL(vType: integer=0): string; //Ӫ������
    function  GetProfitAnalySQL(vType: integer=0): string; //ӯ������
    function  GetPotenAnalySQL(vType: integer=0): string;  //Ǳ������
    procedure FreeFrameObj(vType: integer); //�ͷŵ�Frame����
    procedure AddUnitItemList(SetUnitID: TcxComboBox; SetType: integer);
  public
    procedure SingleReportParams(ParameStr: string='');override; //�򵥱�����ò���
    procedure ShowFrameProfitAnaly; //ӯ������
    procedure ShowFramePotenAnaly;  //Ǳ������
  end;

var
  frmSaleAnaly: TfrmSaleAnaly;

implementation

uses                                                   
  uGlobal,uFnUtil,uShopUtil, ObjCommon,ufrmProfitAnaly,ufrmPotenAnaly,
  uShopGlobal;

{$R *.dfm}

procedure TfrmSaleAnaly.fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmSaleAnaly.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmSaleAnaly.RzPanel7Resize(Sender: TObject);
begin
  inherited;
  Pnl_Char.Height:=Round((RzPanel7.Height-RzTool.Height) div 2);
end;

procedure TfrmSaleAnaly.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  if RzPage.ActivePage=TabSheet1 then
  begin //��Ӫ״��
    if adoReport1.Active then adoReport1.Close;
    strSql := GetMarketAnalySQL;
    if strSql='' then Exit;
    adoReport1.SQL.Text:= strSql;
    Factor.Open(adoReport1);
    AddFillChat1;
  end else
  if RzPage.ActivePage=TabSheet2 then
  begin //��Ǳ������
    if adoReport2.Active then adoReport2.Close;
    strSql := GetProfitAnalySQL;
    if strSql='' then Exit;
    adoReport2.SQL.Text:= strSql;
    Factor.Open(adoReport2);
    ShowFrameProfitAnaly;
  end else
  if RzPage.ActivePage=TabSheet3 then
  begin //��ӯ������
    if adoReport3.Active then adoReport3.Close;
    strSql := self.GetPotenAnalySQL;
    if strSql='' then Exit;
    adoReport3.SQL.Text:= strSql;
    Factor.Open(adoReport3);
    ShowFramePotenAnaly;
  end;
end;

function TfrmSaleAnaly.GetMarketAnalySQL(vType: integer=0): string;
var
  TYPE_ID,SaleCnd,JoinStr,SALE_DATE_GODS: string;  //��λ�����ϵ
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P1_D1.EditValue=null then Raise Exception.Create('��ʼ���ڲ���Ϊ�գ�');
  if P1_D2.EditValue=null then Raise Exception.Create('��ֹ���ڲ���Ϊ�գ�');
  SaleCnd:='';
  strWhere:='';

  //��ҵID����
  SaleCnd:=' where TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //������������
  if P1_D1.Date=P1_D2.Date then
    SaleCnd:=SaleCnd+' and SALES_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' '
  else if P1_D1.Date<P1_D2.Date then
    SaleCnd:=SaleCnd+' and SALES_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and SALES_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+' ';
  //��������
  if fndP1_DEPT_ID.AsString<>'' then
    SaleCnd:=SaleCnd+' and DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
  //��������:
  if RB_sale.Checked then
    SaleCnd:=SaleCnd+' and SALES_TYPE=4 '
  else if RB_batch.Checked then
    SaleCnd:=SaleCnd+' and SALES_TYPE=1 ';
  //��Ʒ����:
  if trim(fndP1_GODS_ID.AsString)<>'' then
    SaleCnd:=SaleCnd+' and GODS_ID='''+fndP1_GODS_ID.AsString+''' ';

  if RB_hour.Checked then  //��Сʱ��
    TYPE_ID:=ConStr('CREA_DATE','12','2')+' as TYPE_ID,'
  else if RB_week.Checked then //������
    TYPE_ID:=GetWeekID('SALES_DATE')+' as TYPE_ID,'; 

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
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
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
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  if vType=0 then //���ز�ѯ���   
  begin
    //����SQL
    SQLData:='select TENANT_ID,SHOP_ID,'+TYPE_ID+'GODS_ID,CALC_AMOUNT as SALE_AMT,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,(NOTAX_MONEY-COST_MONEY) as SALE_PRF  from VIW_SALESDATA '+SaleCnd+' '+ShopGlobal.GetDataRight('SHOP_ID',1);
    strSql :=
      'SELECT A.TYPE_ID,sum(SALE_AMT) as SALE_AMT,sum(SALE_RTL) as SALE_RTL,sum(SALE_PRF) as SALE_PRF from '+ //���۶�
      ' ('+SQLData+')A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TYPE_ID'; 
    Result :=  ParseSQL(Factor.iDbType,strSql);
  end else
  if vType=1 then
  begin
    JoinStr:=GetStrJoin(Factor.iDbType);
    case Factor.iDbType of
     0: SALE_DATE_GODS:='convert(varchar(8),A.SALES_DATE) '+JoinStr+' ''#'' '+JoinStr+' A.GODS_ID'; 
     1: SALE_DATE_GODS:='to_char(A.SALES_DATE) '+JoinStr+' ''#'' '+JoinStr+' A.GODS_ID';
     4: SALE_DATE_GODS:='ltrim(rtrim(char(A.SALES_DATE))) '+JoinStr+' ''#'' '+JoinStr+' A.GODS_ID';
     5: SALE_DATE_GODS:='cast(A.SALES_DATE as varchar(8))'+JoinStr+'''#'''+JoinStr+'A.GODS_ID';
     else
        SALE_DATE_GODS:='cast(A.SALES_DATE as varchar(8))'+JoinStr+'''#'''+JoinStr+'A.GODS_ID';
    end;

    //�����ܵ���
    strSql :=
      'select sum(A.SALE_RTL) as SALE_RTL,count(distinct A.SALES_ID) as BILLCOUNT,count(distinct A.SALES_DATE) as DayCOUNT,count(distinct A.GODS_ID) as PXCOUNT,'+
      ' count(distinct '+SALE_DATE_GODS+') as SALE_DATE_GODS_Count,count(distinct A.SALES_ID'+JoinStr+'''#'''+JoinStr+'A.GODS_ID) as SALE_ID_GODS_COUNT,0 as GODSCOUNT,0 as STORG_COUNT from '+
      ' (select TENANT_ID,SHOP_ID,SALES_ID,SALES_DATE,GODS_ID,(CALC_MONEY+AGIO_MONEY) as SALE_RTL from VIW_SALESDATA '+SaleCnd+' '+ShopGlobal.GetDataRight('SHOP_ID',1)+')A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere +'  ';
    Result :=  ParseSQL(Factor.iDbType,strSql);
  end else
  if vType=2 then
  begin
    strSql :=
      'select count(distinct A.GODS_ID) as STORGCOUNT from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
      ' '+strWhere +' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
    Result :=  ParseSQL(Factor.iDbType,strSql);
  end;
end;


procedure TfrmSaleAnaly.AddFillChat1;
 Function GetPUBGodsCount: integer;
 var Rs: TZQuery;
 begin
   Rs:=Global.GetZQueryFromName('PUB_GOODSINFO');
   Rs.Filtered:=False;
   result:=Rs.RecordCount;
 end;
 Function GetStoreGodsCount: Integer;
 var Qry: TZQuery;
 begin
   try
     Qry:=TZQuery.Create(nil);
     Qry.Close;
     Qry.SQL.Text:=GetMarketAnalySQL(2);
     Factor.Open(Qry);
     result:=Qry.Fields[0].AsInteger;
   finally
     Qry.Free;
   end;
 end;
 procedure GetWhileMinMaxValue(const Rs: TZQuery; var vMin,vMax: integer);
 var MaxValue,MinValue: string;
 begin
   vMin:=0;
   vMax:=0;
   try
     Rs.First;
     MaxValue:=trim(Rs.fieldbyName('TYPE_ID').AsString);
     MinValue:=trim(Rs.fieldbyName('TYPE_ID').AsString);
     Rs.Next;
     while not Rs.Eof do
     begin
       if MinValue>trim(Rs.fieldbyName('TYPE_ID').AsString) then
         MinValue:=trim(Rs.fieldbyName('TYPE_ID').AsString);
       if MaxValue<trim(Rs.fieldbyName('TYPE_ID').AsString) then
         MaxValue:=trim(Rs.fieldbyName('TYPE_ID').AsString);
       Rs.Next;
     end;
     vMin:=StrtoInt(MinValue);
     vMax:=StrtoInt(MaxValue);
   finally
     Rs.First;
   end;
 end;
var
  CalcCount: Real;
  i,MaxLines,vMin,vMax: integer;
  xPoint,InStr,LefStr,MaxStr,TitleStr,MnyUnit: string;
  LStrList,RStrList,StrList: TStringList;
begin
  MnyUnit:=trim(fndP1_Sale_UNIT.Text);
  if fndP1_Sale_UNIT.ItemIndex=0 then CalcCount:=1.00 else CalcCount:=10000.00;
  Chart1.Series[0].Clear;
  AnalyInfo.Clear;
  if adoReport1.IsEmpty then Exit;
  GetWhileMinMaxValue(adoReport1,vMin,vMax);
  if RB_hour.Checked then
  begin
    for i:=vMin to vMax do   //ֻ��������ֵ��
    begin
      xPoint:=FormatFloat('00',i);
      if adoReport1.Locate('TYPE_ID',xPoint,[]) then
      begin
        if RB_SaleMount.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[1].asFloat,xPoint+'ʱ')
        else if RB_SaleMoney.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[2].asFloat/CalcCount,xPoint+'ʱ') 
        else
          Chart1.Series[0].Add(adoReport1.Fields[3].asFloat/CalcCount,xPoint+'ʱ');
      end else
        Chart1.Series[0].Add(0,xPoint+'ʱ');
    end;
  end else
  begin
    for i:=vMin to vMax do
    begin
      xPoint:=GetWeekName(i,'����');
      if adoReport1.Locate('TYPE_ID',inttostr(i),[]) then
      begin   
        if RB_SaleMount.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[1].asFloat,xPoint)
        else if RB_SaleMoney.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[2].asFloat/CalcCount,xPoint)
        else
          Chart1.Series[0].Add(adoReport1.Fields[3].asFloat/CalcCount,xPoint);
      end else
        Chart1.Series[0].Add(0,xPoint);
    end;
  end;
  //Add Memo
  try
    //DayCount:=P1_D2.Date-P1_D1.Date;  //ͳ��������
    LStrList:=TStringList.Create;
    RStrList:=TStringList.Create;
    StrList:=TStringList.Create;
    //���
    LStrList.Clear;
    if RB_hour.Checked then   //ʱ��
      LStrList.Add('          ʱ��              ����              ���۶�            ë��              ')
    else
      LStrList.Add('          ����              ����              ���۶�            ë��              ');
                            
    //�������List
    if RB_hour.Checked then
    begin
      for i:=0 to 23 do
      begin
        xPoint:=FormatFloat('00',i);
        if adoReport1.Locate('TYPE_ID',xPoint,[]) then
        begin
          LStrList.Add('          '+FormateStr(xPoint+'ʱ','                  ')
                                   +FormateStr(adoReport1.Fields[1].AsString,'                  ')
                                   +FormateStr(FormatFloat('#0.##',adoReport1.Fields[2].AsFloat/CalcCount)+MnyUnit,'                  ')
                                   +FormateStr(FormatFloat('#0.##',adoReport1.Fields[3].AsFloat/CalcCount)+MnyUnit,'              '));
        end else
        begin
          LStrList.Add('          '+FormateStr(xPoint+'ʱ','                  ')
                                   +FormateStr('0','                  ')
                                   +FormateStr('0'+MnyUnit,'                  ')
                                   +FormateStr('0'+MnyUnit,'              '));
        end;
      end;
    end else
    begin
      for i:=0 to 6 do
      begin
        xPoint:=GetWeekName(i,'����');
        if adoReport1.Locate('TYPE_ID',inttostr(i),[]) then
        begin
          LStrList.Add('          '+FormateStr(xPoint,'                  ')
                                   +FormateStr(adoReport1.Fields[1].AsString,'                  ')
                                   +FormateStr(FormatFloat('#0.##',adoReport1.Fields[2].AsFloat/CalcCount)+MnyUnit,'                  ')
                                   +FormateStr(FormatFloat('#0.##',adoReport1.Fields[3].AsFloat/CalcCount)+MnyUnit,'              '));
        end else
        begin
          LStrList.Add('          '+FormateStr(xPoint,'                  ')
                                   +FormateStr('0','                  ')
                                   +FormateStr('0'+MnyUnit,'                  ')
                                   +FormateStr('0'+MnyUnit,'              '));
        end;
      end;
    end;

    //����Ҳ�
    AnalyQry1.Close;
    AnalyQry1.SQL.Text:=GetMarketAnalySQL(1);
    Factor.Open(AnalyQry1);
    AnalyQry1.Edit;
    AnalyQry1.FieldByName('GODSCOUNT').AsInteger:=GetPUBGodsCount;
    AnalyQry1.FieldByName('STORG_COUNT').AsInteger:=GetStoreGodsCount;
    AnalyQry1.Post;

    RStrList.Clear;
    // RStrList.Add('Ӫҵ���('+formatDatetime('YYYY-MM-DD',P1_D1.Date)+'��'+formatDatetime('YYYY-MM-DD',P1_D2.Date)+')');
    // RStrList.Add('');
    RStrList.Add('Ӫҵ��:'+formatFloat('#0.00',AnalyQry1.Fields[0].asFloat/CalcCount)+MnyUnit);
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('�վ�Ӫҵ��:'+formatFloat('#0.00',AnalyQry1.Fields[0].asFloat/(AnalyQry1.Fields[2].asInteger*CalcCount))+MnyUnit)
    else
      RStrList.Add('�վ�Ӫҵ��:'+'0'+MnyUnit);
    RStrList.Add('--------------------------------');
    RStrList.Add('�͵���:'+inttostr(AnalyQry1.Fields[1].asInteger)+'�˴�');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('�վ��͵���:'+formatFloat('#0',AnalyQry1.Fields[1].asInteger/AnalyQry1.Fields[2].asInteger)+'�˴�')
    else
      RStrList.Add('�վ��͵���:'+'0�˴�');
    RStrList.Add('--------------------------------');
    RStrList.Add('Ʒ����:'+inttostr(AnalyQry1.Fields[3].asInteger)+'��');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('�վ�Ʒ����:'+formatFloat('#0',AnalyQry1.Fields[4].asInteger/AnalyQry1.Fields[2].asInteger)+'��')
    else
      RStrList.Add('�վ�Ʒ����:'+'0�˴�');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[1].asInteger<>0 then
      RStrList.Add('��������:'+formatFloat('#0',AnalyQry1.Fields[0].AsFloat/AnalyQry1.Fields[1].asInteger)+'Ԫ/��')
    else
      RStrList.Add('��������:'+'0Ԫ/��');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[1].asInteger<>0 then
      RStrList.Add('����Ʒ��:'+formatFloat('#0',AnalyQry1.Fields[5].asInteger/AnalyQry1.Fields[1].asInteger)+'��/��')
    else
      RStrList.Add('����Ʒ��:'+'0��/��');

    RStrList.Add('--------------------------------');
    RStrList.Add('��ӪƷ����(��):'+formatFloat('#0',AnalyQry1.Fields[6].asInteger)+'��');
    RStrList.Add('--------------------------------');
    RStrList.Add('��ЧƷ����:'+formatFloat('#0',AnalyQry1.Fields[7].asInteger)+'��');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[6].asInteger<>0 then
      RStrList.Add('��ЧƷ����:'+formatFloat('#0.00',AnalyQry1.Fields[7].asInteger*100/AnalyQry1.Fields[6].asInteger)+'%')
    else
      RStrList.Add('��ЧƷ����:'+formatFloat('#0.00',0)+'%');

    AnalyInfo.Lines.CommaText:=RStrList.CommaText;

    if LStrList.Count>RStrList.Count then MaxLines:= LStrList.Count
    else MaxLines:= RStrList.Count;

    //���AnalyInfo
    StrList.Clear;
    for i:=0 to MaxLines do //ѭ��
    begin
      LefStr:='';
      if i< LStrList.Count then LefStr:=LStrList.Strings[i];
      LefStr:=FormateStr(LefStr,'                                                                                                   ');

      if i< RStrList.Count then
        LefStr:=LefStr+RStrList.Strings[i]
      else
        LefStr:=LefStr;
      StrList.Add(LefStr);
    end;
    AnalyInfo.Clear;
    AnalyInfo.Lines.CommaText:=StrList.CommaText;
  finally
    LStrList.Free;
    RStrList.Free;
    StrList.Free;
  end;
end;

procedure TfrmSaleAnaly.FormCreate(Sender: TObject);
begin
  inherited;
  P1_D1.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_Sale_UNIT.ItemIndex:=0;   
  P2_D1.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P2_D2.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_D1.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));

  //Ĭ�ϵ�һ��ҳ
  if TabSheet2.TabVisible then
    RzPage.ActivePage:=TabSheet2
  else if TabSheet3.TabVisible then
    RzPage.ActivePage:=TabSheet3
  else if TabSheet1.TabVisible then
    RzPage.ActivePage:=TabSheet1;
  EdtvType.ItemIndex:=0;
  edtMoneyUnit.ItemIndex:=0;
  fndP2UNIT_ID.ItemIndex:=0;
  AddUnitItemList(fndP1UNIT_ID, 2);
  AddTongjiUnitList(fndP2UNIT_ID);
end;

procedure TfrmSaleAnaly.RB_SaleMoneyClick(Sender: TObject);
begin
  inherited;
  fndP1_Sale_UNIT.Enabled:=((RB_SaleMoney.Checked) or (RB_PRF.Checked));
  AddFillChat1;
end;

procedure TfrmSaleAnaly.fndP1_Sale_UNITPropertiesChange(Sender: TObject);
begin
  inherited;
  AddFillChat1;
end;

function TfrmSaleAnaly.FormateStr(const InStr, Format: string): string;
var
  i,vLen: Integer;
begin
  vLen:=Length(Format)-Length(InStr);
  result:=InStr+StringOfChar(' ', vLen);
end;

function TfrmSaleAnaly.GetProfitAnalySQL(vType: integer): string; //ӯ������
var
  TYPE_ID,SaleCnd,JoinStr,UnitID,UnitName: string;  //��λ�����ϵ
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P2_D1.EditValue=null then Raise Exception.Create('��ʼ���ڲ���Ϊ�գ�');
  if P2_D2.EditValue=null then Raise Exception.Create('��ֹ���ڲ���Ϊ�գ�');
  SaleCnd:='';
  strWhere:='';
  if P2_RB_AMT.Checked then //����
  begin
    UnitID:='/'+GetUnitTO_CALC(fndP1UNIT_ID.ItemIndex,'C');
    UnitName:=GetUnitID(fndP1UNIT_ID.ItemIndex,'C');
  end else
  begin
    if fndP1UNIT_ID.ItemIndex=0 then
    begin
      UnitID:='';
      UnitName:='''Ԫ''';
    end else
    begin
      UnitID:='/10000.00';
      UnitName:='''��Ԫ''';
    end;
  end;

  //��ҵID����
  SaleCnd:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //������������
  if P2_D1.Date=P2_D2.Date then
    SaleCnd:=SaleCnd+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P2_D1.Date)+' '
  else if P2_D1.Date<P2_D2.Date then
    SaleCnd:=SaleCnd+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P2_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P2_D2.Date)+' ';
  //��������
  if fndP2_DEPT_ID.AsString<>'' then
    SaleCnd:=SaleCnd+' and A.DEPT_ID='''+fndP2_DEPT_ID.AsString+''' ';
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
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid2+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  if P2_RB_Money.Checked then  //���۶�
    TYPE_ID:='(isnull(CALC_MONEY,0)+isnull(AGIO_MONEY,0))'
  else if P2_RB_PRF.Checked then //ë��
    TYPE_ID:='(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0))'
  else if P2_RB_AMT.Checked then //����
    TYPE_ID:='isnull(CALC_AMOUNT,0)';

  if P2_RB_AMT.Checked then //����
  begin
    strSql :=
      'select tmp.*,unit.UNIT_NAME as UNIT_NAME from '+
      '(SELECT A.TENANT_ID as TENANT_ID,C.RELATION_ID as RELATION_ID,C.GODS_CODE as GODS_CODE,C.GODS_NAME as GODS_NAME,sum('+TYPE_ID+UnitID+')as ANALYSUM,'+UnitName+' as UNIT_ID from '+
      ' VIW_SALESDATA A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+SaleCnd+
      ' '+strWhere +' '+ShopGlobal.GetDataRight('A.SHOP_ID',1)+
      ' group by A.TENANT_ID,C.RELATION_ID,C.GODS_CODE,C.GODS_NAME,'+UnitName+')tmp '+
      ' left outer join VIW_MEAUNITS unit on tmp.TENANT_ID=unit.TENANT_ID and tmp.UNIT_ID=unit.UNIT_ID '+
      'order by RELATION_ID asc,ANALYSUM desc ';
  end else
  begin
    strSql :=
      'select * from '+
      '(SELECT C.RELATION_ID as RELATION_ID,C.GODS_CODE as GODS_CODE,C.GODS_NAME as GODS_NAME,sum('+TYPE_ID+')'+UnitID+' as ANALYSUM,'+UnitName+' as UNIT_NAME from '+
      ' VIW_SALESDATA A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+SaleCnd+
      ' '+strWhere +' '+ShopGlobal.GetDataRight('A.SHOP_ID',1)+
      'group by C.RELATION_ID,C.GODS_CODE,C.GODS_NAME,'+UnitName+')tmp '+
      'order by RELATION_ID asc,ANALYSUM desc ';
  end;
  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmSaleAnaly.GetPotenAnalySQL(vType: integer): string;  //Ǳ������
  function GetSumField(Qry:TZQuery; SumField1,SumField2: string): string;
  var
    Str,SubStr,MaxValue1,MaxValue2: string;
  begin
    result:='';
    Str:=',(case ';
    if Qry.IsEmpty then
    begin
      SubStr:='(case when ('+SumField1+'<0 and '+SumField2+'<0) then 1 when ('+SumField1+'>=0 and '+SumField2+'>=0) then 4 else 2 end)';
      Str:=Str+' when C.RELATION_ID=0 then '+SubStr+' ';
    end else
    begin
      Qry.First;
      while not Qry.Eof do
      begin
        MaxValue1:=FloatToStr(Qry.fieldbyName('SUM1').AsFloat*0.50);
        MaxValue2:=FloatToStr(Qry.fieldbyName('SUM2').AsFloat*0.50);
        SubStr:='(case when ('+SumField1+'<'+MaxValue1+' and '+SumField2+'<'+MaxValue2+') then 1 when ('+SumField1+'>='+MaxValue1+' and '+SumField2+'>='+MaxValue2+') then 4 else 2 end)';
        Str:=Str+' when C.RELATION_ID='+Qry.fieldbyName('RELATION_ID').AsString+' then '+SubStr+'  ';
        Qry.Next;
      end;
    end;
    Str:=Str+' else 2 end) as vType ';
    result:=Str;    
  end;
var
  Qry: TZQuery;
  SaleCnd,JoinStr,OrderBy,UnitID,AmtUnitID,MnyUnitID: string;  //��λ�����ϵ
  FieldStr,MaxSQL,MaxValue1,MaxValue2: string;
  strSql,strWhere,GoodTab,SQLData: string;
begin
  result:='';
  SaleCnd:='';
  strWhere:='';
  if P3_D1.EditValue=null then Raise Exception.Create('��ʼ���ڲ���Ϊ�գ�');
  if P3_D2.EditValue=null then Raise Exception.Create('��ֹ���ڲ���Ϊ�գ�');
  if edtMoneyUnit.ItemIndex=0 then MnyUnitID:='' else  MnyUnitID:='/10000.0';
  AmtUnitID:='('+GetUnitTO_CALC(fndP2UNIT_ID.ItemIndex,'C')+')';
  UnitID:=GetUnitID(fndP2UNIT_ID.ItemIndex,'C');

  //��ҵID����
  SaleCnd:=' and SAL.TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //������������
  if P3_D1.Date=P3_D2.Date then
    SaleCnd:=SaleCnd+' and SAL.SALES_DATE='+FormatDatetime('YYYYMMDD',P3_D1.Date)+' '
  else if P3_D1.Date<P3_D2.Date then
    SaleCnd:=SaleCnd+' and SAL.SALES_DATE>='+FormatDatetime('YYYYMMDD',P3_D1.Date)+' and SAL.SALES_DATE<='+FormatDatetime('YYYYMMDD',P3_D2.Date)+' ';
  //��������
  if fndP3_DEPT_ID.AsString<>'' then
    SaleCnd:=SaleCnd+' and SAL.DEPT_ID='''+fndP3_DEPT_ID.AsString+''' ';
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
      1: strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //��Ʒָ��:
  if (fndP3_STAT_ID.AsString <> '') and (fndP3_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP3_TYPE_ID)+'='''+fndP3_STAT_ID.AsString+''' ';
  end;

  //��Ʒ����:
  if (trim(fndP3_SORT_ID.Text)<>'') and (trim(srid3)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid3+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid3+''' ';
    end;
    if trim(sid3)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid3+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  //����ȡ��Max(�ֶ�)
  case EdtvType.ItemIndex of
   0: FieldStr:=' max(MNY_SUM) as SUM1,max(PRF_SUM) as SUM2 ';   //���۶� ë��
   1: FieldStr:=' max(AMT_SUM) as SUM1,max(PRF_SUM) as SUM2 ';   //���� ��ë��
   2: FieldStr:=' max(AMT_SUM) as SUM1,max(MNY_SUM) as SUM2 ';   //���� �����۶�
  end;
  MaxSQL:=ParseSQL(Factor.iDbType,
    'select RELATION_ID,'+FieldStr+' from '+
    ' (SELECT C.RELATION_ID as RELATION_ID,C.GODS_CODE as GODS_CODE,C.GODS_NAME as GODS_NAME,'+
      'cast(sum(CALC_AMOUNT/(case when '+AmtUnitID+'=0 then 1.00 else '+AmtUnitID+' end)) as decimal(18,3)) as AMT_SUM,'+
      'cast((sum(isnull(CALC_MONEY,0)+isnull(AGIO_MONEY,0))'+MnyUnitID+') as decimal(18,3))as MNY_SUM,'+
      'cast((sum(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0))'+MnyUnitID+') as decimal(18,3))as PRF_SUM '+
    '  from VIW_SALESDATA SAL,CA_SHOP_INFO B,'+GoodTab+' C '+
    '  where SAL.TENANT_ID=B.TENANT_ID and SAL.SHOP_ID=B.SHOP_ID and SAL.TENANT_ID=C.TENANT_ID and SAL.GODS_ID=C.GODS_ID '+SaleCnd+
    ' '+ strWhere + ' '+ShopGlobal.GetDataRight('SAL.SHOP_ID',1)+
    '  group by C.RELATION_ID,C.GODS_CODE,C.GODS_NAME)tmp '+
    ' group by RELATION_ID');
    
  //����ȡ��Max(�ֶ�)
  try
    Qry:=TZQuery.Create(nil);
    Qry.SQL.Text:=MaxSQL;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      case EdtvType.ItemIndex of
       0: //���۶� ë��
        begin
          FieldStr:=GetSumField(Qry, 'sum(MNY_SUM'+MnyUnitID+')', 'sum(PRF_SUM'+MnyUnitID+')');
          OrderBy:='order by RELATION_ID asc,vType asc,PRF_SUM desc,MNY_SUM desc,AMT_SUM desc '
        end;
       1: //������ ë��
        begin
          FieldStr:=GetSumField(Qry, 'sum(AMT_SUM/'+AmtUnitID+')', 'sum(PRF_SUM'+MnyUnitID+')');
          OrderBy:='order by RELATION_ID asc,vType asc,PRF_SUM desc,AMT_SUM desc,MNY_SUM desc'
        end;
       2: //������ ���۶�
        begin
          FieldStr:=GetSumField(Qry, 'sum(AMT_SUM/'+AmtUnitID+')', 'sum(MNY_SUM'+MnyUnitID+')');
          OrderBy:='order by RELATION_ID asc,vType asc,MNY_SUM desc,AMT_SUM desc,PRF_SUM desc ';
        end;
      end;
    end;
  finally
    Qry.Free;
  end;

  //����SQL
  SQLData:=
     'select STO.TENANT_ID,STO.SHOP_ID,STO.GODS_ID,SAL.CALC_AMOUNT as AMT_SUM,'+
     ' (isnull(SAL.CALC_MONEY,0)+isnull(SAL.AGIO_MONEY,0)) as MNY_SUM,'+
     ' (isnull(SAL.NOTAX_MONEY,0)-isnull(SAL.COST_MONEY,0)) as PRF_SUM '+
     ' from STO_STORAGE STO left outer join VIW_SALESDATA SAL '+
     'on STO.TENANT_ID=SAL.TENANT_ID and STO.SHOP_ID=SAL.SHOP_ID and STO.GODS_ID=SAL.GODS_ID '+
     ' where 1=1 '+SaleCnd+' '+ShopGlobal.GetDataRight('STO.SHOP_ID',1)+' '+ShopGlobal.GetDataRight('SAL.SHOP_ID',1);

  strSql :=
    'select tmp.*,unit.UNIT_NAME from '+
    '(SELECT A.TENANT_ID,C.RELATION_ID as RELATION_ID,C.GODS_CODE as GODS_CODE,C.GODS_NAME as GODS_NAME,'+
     'cast(sum(AMT_SUM/(case when '+AmtUnitID+'=0 then 1.00 else '+AmtUnitID+' end)) as decimal(18,3)) as AMT_SUM,'+
     'cast(sum(MNY_SUM)'+MnyUnitID+' as decimal(18,3))as MNY_SUM,'+
     'cast(sum(PRF_SUM)'+MnyUnitID+' as decimal(18,3))as PRF_SUM '+FieldStr+','+UnitID+' as UNIT_ID '+
    ' from ('+SQLData+')A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and '+
    ' A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,C.RELATION_ID,C.GODS_CODE,C.GODS_NAME,'+UnitID+')tmp '+
    ' left outer join VIW_MEAUNITS unit on tmp.TENANT_ID=unit.TENANT_ID and tmp.UNIT_ID=unit.UNIT_ID '+OrderBy;
  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmSaleAnaly.FreeFrameObj(vType: integer);
var
  i:integer;
  FindCmp: TComponent;
begin
  for i:=0 to 100 do
  begin
    if vType=1 then
    begin
      FindCmp:=FindComponent('frmProfitAnaly'+Inttostr(i));
      if (FindCmp<>nil) and (TWinControl(FindCmp).Parent=SB2) and (FindCmp is TfrmProfitAnaly)  then
      begin
        TfrmProfitAnaly(FindCmp).Free;
      end;

      FindCmp:=FindComponent('frmProfitAnalysplt'+Inttostr(i));
      if (FindCmp<>nil) and (TWinControl(FindCmp).Parent=SB2) and (FindCmp is TSplitter)  then
      begin
        TSplitter(FindCmp).Free;
      end;
    end else
    if vType=2 then
    begin
      FindCmp:=FindComponent('frmPotenAnaly'+Inttostr(i));
      if (FindCmp<>nil) and (TWinControl(FindCmp).Parent=SB3) and (FindCmp is TfrmPotenAnaly)  then
      begin
        TfrmPotenAnaly(FindCmp).Free;
      end;

      FindCmp:=FindComponent('frmPotenAnalysplt'+Inttostr(i));
      if (FindCmp<>nil) and (TWinControl(FindCmp).Parent=SB3) and (FindCmp is TSplitter)  then
      begin
        TSplitter(FindCmp).Free;
      end;
    end;
  end;
end;

procedure TfrmSaleAnaly.ShowFrameProfitAnaly;
  procedure ShowFrameDetail(Relation_ID, RelCount,vNo: integer; var vHeight: integer);
  var
    Spilt: TSplitter; frmAnaly: TfrmProfitAnaly; AnalyType: integer;
  begin
    if Relation_ID<>1000006 then //���Ǿ��̶������ָ���
    begin
      Spilt:=TSplitter.Create(self); 
      Spilt.Name:='frmProfitAnalysplt'+InttoStr(vNo-1);
      Spilt.Parent:=SB2;
      Spilt.Height:=8;
      Spilt.Color:=clwhite;
      Spilt.Align:=alBottom;
      Spilt.Align:=alTop;
    end;
    try
      frmAnaly:=TfrmProfitAnaly.Create(self);
      frmAnaly.Name:='frmProfitAnaly'+InttoStr(vNo);
      frmAnaly.Parent:=SB2;
      frmAnaly.Align:=alBottom;
      frmAnaly.Align:=alTop;
      if P2_RB_Money.Checked then AnalyType:=1
      else if P2_RB_PRF.Checked then AnalyType:=2
      else if P2_RB_AMT.Checked then AnalyType:=3;
      frmAnaly.InitData(AnalyType,Relation_ID,adoReport2.Data);
      if vHeight=0 then vHeight:=frmAnaly.Height;
      if RelCount=1 then //ֻ��һ��
      begin
        frmAnaly.Align:=alClient;
      end else
      begin
        if (Relation_ID=1000006) and (RelCount * (frmAnaly.Height+8)-8>SB2.Height) then //��һ�����вŽ�������
        begin
          SB2.Top:=0;
          SB2.Left:=0;
          SB2.Height:=(frmAnaly.Height+8)* RelCount-2;
        end else
        if (Relation_ID=1000006) and (RelCount * (frmAnaly.Height+8)-8<=SB2.Height) then //��һ�����вŽ�������
        begin
          vHeight:=(SB2.Height-RelCount*8+8) div RelCount-2;
        end;
        frmAnaly.Height:=vHeight;
      end;
    except
      frmAnaly.Free;
    end;
  end;
var
  i,vHeight,vNo: integer;
  RelID: string;
  ReList: TStringList;
begin
  vNo:=1;
  vHeight:=0;
  //����ǰ�ͷ��ϴδ���
  FreeFrameObj(1);

  //���̷��ڵ�һ����
  try
    ReList:=TStringList.Create;
    adoReport2.First;
    while not adoReport2.Eof do
    begin
      RelID:=trim(adoReport2.fieldbyName('RELATION_ID').AsString);
      if RelID<>'1000006' then
      begin
        if ReList.IndexOf(RelID)=-1 then
          ReList.Add(RelID);
      end;
      adoReport2.Next;
    end;
    //���̹�Ӧ��:
    ShowFrameDetail(1000006, ReList.Count+1,vNo,vHeight);

    //�Ǿ��̹�Ӧ��
    for i:=0 to ReList.Count-1 do
    begin
      RelID:=trim(ReList.Strings[i]);
      if RelID = '1000006' then continue;
      Inc(vNo); //���+1
      ShowFrameDetail(StrtoInt(RelID), ReList.Count+1, vNo,vHeight);
    end;
  finally
    ReList.Free;
  end;
end;

procedure TfrmSaleAnaly.ShowFramePotenAnaly;
  procedure ShowFrameDetail(Relation_ID, RelCount,vNo: integer; var vHeight: integer);
  var
    Spilt: TSplitter; frmPoten: TfrmPotenAnaly; AnalyType: integer;
  begin
    if Relation_ID<>1000006 then //���Ǿ��̶������ָ���
    begin
      Spilt:=TSplitter.Create(self);
      Spilt.Name:='frmPotenAnalysplt'+InttoStr(vNo-1);
      Spilt.Parent:=SB3;
      Spilt.Height:=8;
      Spilt.Color:=clwhite;
      Spilt.Align:=alBottom;
      Spilt.Align:=alTop;
    end;
    try
      frmPoten:=TfrmPotenAnaly.Create(self);
      frmPoten.Name:='frmPotenAnaly'+InttoStr(vNo);
      frmPoten.Parent:=SB3;
      frmPoten.Align:=alBottom;
      frmPoten.Align:=alTop;
      frmPoten.InitData(Relation_ID,adoReport3.Data);
      if vHeight=0 then vHeight:=frmPoten.Height;
      if RelCount=1 then
      begin
        frmPoten.Align:=alClient;
      end else
      begin
        if (Relation_ID=1000006) and (RelCount * (frmPoten.Height+8)-8>SB3.Height) then //���ڵ�һ��ִ�����
        begin
          {SB3.Align:=alNone;
          SB3.Top:=0;
          SB3.Left:=0;
          }
          SB3.Height:=(frmPoten.Height+8)* RelCount-2;
        end else
        if (Relation_ID=1000006) and (RelCount * (frmPoten.Height+8)-8<=SB3.Height) then //���ڵ�һ��ִ�����
        begin
          vHeight:=(SB3.Height-RelCount*8+8) div RelCount-2;
        end;
        //�ڷ�Χ�ڵ��� Fram�߶�
        frmPoten.Height:=vHeight;
      end;
    except
      frmPoten.Free;
    end;
  end;
var
  i,vHeight,vNo: integer;
  RelID: string;
  ReList: TStringList;
begin
  vNo:=1;
  vHeight:=0;
  //����ǰ�ͷ��ϴδ���
  FreeFrameObj(2);

  //���̷��ڵ�һ����
  try
    ReList:=TStringList.Create;
    adoReport3.First;
    while not adoReport3.Eof do
    begin
      RelID:=trim(adoReport3.fieldbyName('RELATION_ID').AsString);
      if RelID<>'1000006' then
      begin
        if ReList.IndexOf(RelID)=-1 then
          ReList.Add(RelID);
      end;
      adoReport3.Next;
    end;
    //���̹�Ӧ��:
    ShowFrameDetail(1000006,ReList.Count+1,vNo,vHeight);
    
    //�Ǿ��̹�Ӧ��
    for i:=0 to ReList.Count-1 do
    begin
      RelID:=trim(ReList.Strings[i]);
      if RelID = '1000006' then continue;
      Inc(vNo); //���+1
      ShowFrameDetail(StrtoInt(RelID),ReList.Count+1,vNo,vHeight);
    end;
  finally
    ReList.Free;
  end;
end;    

procedure TfrmSaleAnaly.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmSaleAnaly.fndP3_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid3 := '';
  srid3 := '';
  fndP3_SORT_ID.Text := '';
end;

procedure TfrmSaleAnaly.CB_ColorClick(Sender: TObject);
begin
  inherited;
  BarSeries1.ColorEachPoint:=CB_Color.Checked;
end;

procedure TfrmSaleAnaly.actPrintExecute(Sender: TObject);
begin
  inherited;
  //��ӡ
  
end;

procedure TfrmSaleAnaly.actPreviewExecute(Sender: TObject);
begin
  inherited;
  //��ӡԤ��

  
end;

procedure TfrmSaleAnaly.SingleReportParams(ParameStr: string);
begin
  inherited;
  TabSheet1.PageIndex:=2;
  RzPage.ActivePage:=TabSheet2;
end;

procedure TfrmSaleAnaly.AddUnitItemList(SetUnitID: TcxComboBox; SetType: integer);
begin
  if SetType=1 then //������λ
  begin
    AddTongjiUnitList(SetUnitID);
  end else
  if SetType=2 then //��λ
  begin
    SetUnitID.Properties.Items.Clear;
    SetUnitID.Properties.Items.Add('Ԫ');
    SetUnitID.Properties.Items.Add('��Ԫ');
  end;
  SetUnitID.ItemIndex:=0;
end;

procedure TfrmSaleAnaly.P2_RB_MoneyClick(Sender: TObject);
begin
  inherited;
  AddUnitItemList(fndP1UNIT_ID, 2);
end;

procedure TfrmSaleAnaly.P2_RB_PRFClick(Sender: TObject);
begin
  inherited;
  AddUnitItemList(fndP1UNIT_ID, 2);
end;

procedure TfrmSaleAnaly.P2_RB_AMTClick(Sender: TObject);
begin
  inherited;
  AddUnitItemList(fndP1UNIT_ID, 1);
end;

end.
