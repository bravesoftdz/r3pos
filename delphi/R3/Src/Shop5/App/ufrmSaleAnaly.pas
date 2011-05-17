unit ufrmSaleAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ActnList, Menus,
  ComCtrls, ToolWin, StdCtrls, RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, cxEdit, 
  RzButton, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, cxControls,
  cxContainer, cxTextEdit, cxMaskEdit, uframeBaseAnaly, TeEngine,
  Series, TeeProcs, Chart, cxMemo, cxRadioGroup,ZBase;

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
    BarSeries2: TBarSeries;
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
    RB_SaleMoney: TcxRadioButton;
    RB_SaleMount: TcxRadioButton;
    Label32: TLabel;
    fndP1_DEPT_ID: TzrComboBoxList;
    Sale_UNIT: TcxComboBox;
    Label4: TLabel;
    AnalyQry1: TZQuery;
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure RzPanel7Resize(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RB_SaleMoneyClick(Sender: TObject);
    procedure Sale_UNITPropertiesChange(Sender: TObject);
  private
    SortName: string; //商品分类名称
    sid1: string;      //商品分类ID
    srid1: string;     //商品供应链关系ID
    function  FormateStr(const InStr, Format: string): string;
    procedure AddFillChat1; //
    //EnSQLCode
    function GetMarketAnalySQL(vType: integer=0): string; //营销分析
  public
    
  end;

var
  frmSaleAnaly: TfrmSaleAnaly;

implementation

uses uGlobal,uFnUtil,uShopUtil, ObjCommon;

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
  case rzPage.ActivePageIndex of
    0:
      begin //按部门汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetMarketAnalySQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
        Factor.Open(adoReport1);
        AddFillChat1;
      end;
  end;
end;

function TfrmSaleAnaly.GetMarketAnalySQL(vType: integer=0): string;
var
  TYPE_ID,SaleCnd,JoinStr: string;  //单位计算关系
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P1_D1.EditValue=null then Raise Exception.Create('开始日期不能为空！');
  if P1_D2.EditValue=null then Raise Exception.Create('截止日期不能为空！');
  SaleCnd:='';
  strWhere:='';

  //企业ID过滤
  SaleCnd:=' where TENANT_ID='+InttoStr(Global.TENANT_ID)+' ';
  //销售日期条件
  if P1_D1.Date=P1_D2.Date then
    SaleCnd:=SaleCnd+' and SALES_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' '
  else if P1_D1.Date<P1_D2.Date then
    SaleCnd:=SaleCnd+' and SALES_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and SALES_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+' ';
  //部门条件
  if fndP1_DEPT_ID.AsString<>'' then
    SaleCnd:=SaleCnd+' and DEPT_ID='''+fndP1_DEPT_ID.AsString+''' ';
  //单据类型:
  if RB_sale.Checked then
    SaleCnd:=SaleCnd+' and SALES_TYPE=4 '
  else if RB_batch.Checked then
    SaleCnd:=SaleCnd+' and SALES_TYPE=1 ';
  //商品名称:
  if trim(fndP1_GODS_ID.AsString)<>'' then
    SaleCnd:=SaleCnd+' and GODS_ID='''+fndP1_GODS_ID.AsString+''' ';

  if RB_hour.Checked then  //按小时间
    TYPE_ID:=ConStr('CREA_DATE','12','2')+' as TYPE_ID,'
  else if RB_week.Checked then //按星期
    TYPE_ID:=GetWeekID('SALES_DATE')+' as TYPE_ID,'; 

  //门店所属行政区域|门店类型:
  if (fndP1_SHOP_VALUE.AsString<>'') then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    case TRecord_(fndP1_TYPE_ID.Properties.Items.Objects[fndP1_TYPE_ID.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      2:strWhere:=strWhere+' and C.SORT_ID2='''+fndP1_STAT_ID.AsString+''' ';
      3:strWhere:=strWhere+' and C.SORT_ID3='''+fndP1_STAT_ID.AsString+''' ';
      4:strWhere:=strWhere+' and C.SORT_ID4='''+fndp1_STAT_ID.AsString+''' ';
      5:strWhere:=strWhere+' and C.SORT_ID5='''+fndP1_STAT_ID.AsString+''' ';
      6:strWhere:=strWhere+' and C.SORT_ID6='''+fndP1_STAT_ID.AsString+''' ';
    end;
  end;

  //商品分类:
  if (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
  begin
    GoodTab:='VIW_GOODSINFO_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid1+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid1+''' ';
    end;
    if trim(sid1)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid1+'%'' ';
  end else
    GoodTab:='VIW_GOODSINFO';

  if vType=0 then //返回查询语句   
  begin
    //销售SQL
    SQLData:='select TENANT_ID,SHOP_ID,'+TYPE_ID+'GODS_ID,CALC_AMOUNT as SALE_AMT,(CALC_MONEY+AGIO_MONEY) as SALE_RTL from VIW_SALESDATA '+SaleCnd;
    strSql :=
      'SELECT A.TYPE_ID,sum(SALE_AMT) as SALE_AMT,sum(SALE_RTL) as SALE_RTL from '+ //销售额
      ' ('+SQLData+')A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TYPE_ID'; 
    Result :=  ParseSQL(Factor.iDbType,strSql);
  end else
  if vType=1 then 
  begin
    JoinStr:=GetStrJoin(Factor.iDbType);
    //返回总单数
    strSql :=
      'select sum(A.SALE_RTL) as SALE_RTL,count(distinct A.SALES_ID) as BILLCOUNT,count(distinct A.SALES_DATE) as DayCOUNT,count(distinct A.GODS_ID) as PXCOUNT,'+
      ' count(distinct cast(A.SALES_DATE as varchar(8))'+JoinStr+'''#'''+JoinStr+'A.GODS_ID) as SALE_DATE_GODS_Count,count(distinct A.SALES_ID'+JoinStr+'''#'''+JoinStr+'A.GODS_ID) as SALE_ID_GODS_COUNT,0 as GODSCOUNT,0 as STORG_COUNT from '+
      ' (select TENANT_ID,SHOP_ID,SALES_ID,SALES_DATE,GODS_ID,(CALC_MONEY+AGIO_MONEY) as SALE_RTL from VIW_SALESDATA '+SaleCnd+')A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere +'  ';
    Result :=  ParseSQL(Factor.iDbType,strSql);
  end else
  if vType=2 then
  begin
    strSql :=
      'select count(distinct A.GODS_ID) as STORGCOUNT from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+ strWhere +'  ';
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
var
  xPoint,InStr,LefStr,MaxStr,TitleStr: string;
  i,CalcCount,MaxLines: integer;
  LStrList,RStrList,StrList: TStringList;
begin
  Chart1.Series[0].Clear;
  AnalyInfo.Clear;
  if adoReport1.IsEmpty then Exit;
  if RB_hour.Checked then
  begin
    for i:=0 to 23 do
    begin
      xPoint:=FormatFloat('00',i);
      if adoReport1.Locate('TYPE_ID',xPoint,[]) then
      begin
        if RB_SaleMount.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[1].asFloat,xPoint+'时')
        else
        begin
          if Sale_UNIT.ItemIndex=0 then CalcCount:=1
          else CalcCount:=10000;
          Chart1.Series[0].Add(adoReport1.Fields[2].asFloat/CalcCount,xPoint+'时');
        end;
      end else
        Chart1.Series[0].Add(0,xPoint+'时');
    end;
  end else
  begin
    for i:=0 to 6 do
    begin
      xPoint:=GetWeekName(i,'星期');
      if adoReport1.Locate('TYPE_ID',inttostr(i),[]) then
      begin   
        if RB_SaleMount.Checked then
          Chart1.Series[0].Add(adoReport1.Fields[1].asFloat,xPoint)
        else
        begin
          if Sale_UNIT.ItemIndex=0 then CalcCount:=1
          else CalcCount:=10000;
          Chart1.Series[0].Add(adoReport1.Fields[2].asFloat/CalcCount,xPoint);
        end;
      end else
        Chart1.Series[0].Add(0,xPoint);
    end;
  end;
  //Add Memo
  try
  //  DayCount:=P1_D2.Date-P1_D1.Date;  //统计总天数
    LStrList:=TStringList.Create;
    RStrList:=TStringList.Create;
    StrList:=TStringList.Create;
    //添加
    LStrList.Clear;
    if RB_hour.Checked then //时段
      LStrList.Add('          时段              销量              销售额              ')
    else
      LStrList.Add('          星期              销量              销售额              ');
                            
    adoReport1.First;
    while not adoReport1.Eof do
    begin
      if RB_hour.Checked then TitleStr:=adoReport1.Fields[0].AsString+'时'
      else TitleStr:=GetWeekName(adoReport1.Fields[0].AsInteger,'星期');

      LStrList.Add('          '+FormateStr(TitleStr,'                  ')
                               +FormateStr(adoReport1.Fields[1].AsString,'                  ')
                               +FormateStr(FloatToStr(adoReport1.Fields[2].AsFloat/CalcCount)+Sale_UNIT.Text,'              '));
      adoReport1.Next;                
    end;

    AnalyQry1.Close;
    AnalyQry1.SQL.Text:=GetMarketAnalySQL(1);
    Factor.Open(AnalyQry1);
    AnalyQry1.Edit;
    AnalyQry1.FieldByName('GODSCOUNT').AsInteger:=GetPUBGodsCount;
    AnalyQry1.FieldByName('STORG_COUNT').AsInteger:=GetStoreGodsCount;
    AnalyQry1.Post;

    RStrList.Clear;
    RStrList.Add('营业情况('+formatDatetime('YYYY-MM-DD',P1_D1.Date)+'至'+formatDatetime('YYYY-MM-DD',P1_D2.Date)+')');
    RStrList.Add('');
    RStrList.Add('营业额:'+formatFloat('#0.00',AnalyQry1.Fields[0].asFloat)+'元');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('日均营业额:'+formatFloat('#0.00',AnalyQry1.Fields[0].asFloat/AnalyQry1.Fields[2].asInteger)+'元')
    else
      RStrList.Add('日均营业额:'+'0元');
    RStrList.Add('--------------------------------');
    RStrList.Add('客单数:'+inttostr(AnalyQry1.Fields[1].asInteger)+'人次');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('日均客单数:'+formatFloat('#0',AnalyQry1.Fields[1].asInteger/AnalyQry1.Fields[2].asInteger)+'人次')
    else
      RStrList.Add('日均客单数:'+'0人次');
    RStrList.Add('--------------------------------');
    RStrList.Add('品项数:'+inttostr(AnalyQry1.Fields[3].asInteger)+'个');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[2].asInteger<>0 then
      RStrList.Add('日均品项数:'+formatFloat('#0',AnalyQry1.Fields[4].asInteger/AnalyQry1.Fields[2].asInteger)+'个')
    else
      RStrList.Add('日均品项数:'+'0人次');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[1].asInteger<>0 then
      RStrList.Add('单客消费:'+formatFloat('#0',AnalyQry1.Fields[0].asInteger/AnalyQry1.Fields[1].asInteger)+'元/人')
    else
      RStrList.Add('单客消费:'+'0元/人');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[1].asInteger<>0 then
      RStrList.Add('单客品项:'+formatFloat('#0',AnalyQry1.Fields[5].asInteger/AnalyQry1.Fields[1].asInteger)+'个/人')
    else
      RStrList.Add('单客品项:'+'0个/人');

    RStrList.Add('--------------------------------');
    RStrList.Add('经营品种数(现):'+formatFloat('#0',AnalyQry1.Fields[6].asInteger)+'种');
    RStrList.Add('--------------------------------');
    RStrList.Add('有效品种数:'+formatFloat('#0',AnalyQry1.Fields[7].asInteger)+'种');
    RStrList.Add('--------------------------------');
    if AnalyQry1.Fields[6].asInteger<>0 then
      RStrList.Add('有效品种率:'+formatFloat('#0.00',AnalyQry1.Fields[7].asInteger*100/AnalyQry1.Fields[6].asInteger)+'%')
    else
      RStrList.Add('有效品种率:'+formatFloat('#0.00',0)+'%');

    AnalyInfo.Lines.CommaText:=RStrList.CommaText;

    if LStrList.Count>RStrList.Count then MaxLines:= LStrList.Count
    else MaxLines:= RStrList.Count;

    //添加AnalyInfo
    StrList.Clear;
    for i:=0 to MaxLines do //循环
    begin
      LefStr:='';
      if i< LStrList.Count then LefStr:=LStrList.Strings[i];
      LefStr:=FormateStr(LefStr,'                                                                                 ');

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
  P1_D2.Date:=fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  Sale_UNIT.ItemIndex:=0;
end;

procedure TfrmSaleAnaly.RB_SaleMoneyClick(Sender: TObject);
begin
  inherited;
  Sale_UNIT.Enabled:=RB_SaleMoney.Checked;
  AddFillChat1;
end;

procedure TfrmSaleAnaly.Sale_UNITPropertiesChange(Sender: TObject);
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

end.
