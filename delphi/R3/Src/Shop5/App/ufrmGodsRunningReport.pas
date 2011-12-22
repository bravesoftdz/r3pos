unit ufrmGodsRunningReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ADODB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList,ObjCommon,
  zrMonthEdit, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxRadioGroup, Buttons, ufrmDateControl;

type
  TfrmGodsRunningReport = class(TframeBaseReport)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnOk: TRzBitBtn;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    fndP1_GODS_ID: TzrComboBoxList;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    fndP1_BarType_ID: TcxComboBox;
    fndP1_BarCode: TcxTextEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    Label8: TLabel;
    fndP1_UNIT_ID: TcxComboBox;
    P1_DateControl: TfrmDateControl;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
  private
    FQryType: integer;
    FReckAmt: Real;  //期初数量
    FReckMny: Real;  //期初金额
    FBalAmt:  Real;  //结存数量
    FSumAmt:  Real;  //本次统计销量
    FSumMny:  Real;  //本次统计销额
    procedure AddBillTypeItems; //添加帐单类型Items

    procedure CreateGrid;
    function  FormatStr(SetValue:Real; Format: string=''): string; //返回格式数量
    procedure CalcStorageInfo;  //累计计算库存
    function  GetGoodStorageORG: Boolean; //返回当前查询期初数量
    function  GetGoodDetailSQL(chk:boolean=true): widestring;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override;
    function  GetQryType: integer; //添加Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  QryType: integer read FQryType;
  end;

implementation

uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, uShopUtil, ufrmSelectGoodSort, ufrmCostCalc;

{$R *.dfm}

procedure TfrmGodsRunningReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  AddBillTypeItems; //添加单据类型
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P1_DateControl.StartDateControl := P1_D1;
  P1_DateControl.EndDateControl := P1_D2;
  fndP1_BarType_ID.ItemIndex:=0;

  SetRzPageActivePage(false); //设置默认分页
  RefreshColumn;
  //2011.12.22 重开启[若非总店默认当前门店]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      fndP1_SHOP_ID.Properties.ReadOnly := False;
      fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP1_SHOP_ID.Text := Global.SHOP_NAME;
      //SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
      //fndP1_SHOP_ID.Properties.ReadOnly := True;
    end; 
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label4.Caption := '仓库名称';
    end;

  //2011.04.22 Add 设置查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['APRICE','AMONEY']);
  end;

  //2011.09.22 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.AMONEY']);
end;

function TfrmGodsRunningReport.GetGoodDetailSQL(chk:boolean=true): widestring;
var
  mx,UnitCalc: string; 
  strSql,strWhere,CLIENT_Tab,ORG_Tab: widestring;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D2.EditValue = null then Raise Exception.Create(' 日期条件不能为空！ ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  查询开始日期不能大于结束日期条件不能为空！ ');
  if trim(fndP1_GODS_ID.AsString)='' then Raise Exception.Create('  请选择要查询商品！  ');

  //过滤企业ID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1)+
            ' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',P1_D1.Date)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',P1_D2.Date)+' ';
  //门店条件:
  if fndP1_SHOP_ID.AsString <>'' then strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
  //商品名称
  if fndP1_GODS_ID.AsString <>'' then strWhere:=strWhere+' and A.GODS_ID='''+fndP1_GODS_ID.AsString+''' ';

  //条形码（ 物流跟踪号|批号）:
  FQryType:=GetQryType; {0:条码头查询; 1:期初数量、结存数量}
  if trim(fndP1_BarCode.Text)<>'' then //条码不为空时
  begin
    case fndP1_BarType_ID.ItemIndex of
     0: begin
          strWhere:=strWhere+' and (Exists(select * from STK_LOCUS_FORSTCK where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and STOCK_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''') ';
          strWhere:=strWhere+' or Exists(select * from SAL_LOCUS_FORSALE where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and SALES_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''') ';
          strWhere:=strWhere+' or Exists(select * from STO_LOCUS_FORCHAG where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and CHANGE_ID=A.ORDER_ID and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''')) ';
        end;
     1: strWhere:=strWhere+' and BATCH_NO='''+trim(fndP1_BarCode.Text)+''' '
    end;
  end else
  begin //读取台账的期初数量:
    if not GetGoodStorageORG then Raise Exception.Create('  读取期初错误！  ');
  end;

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

  //供应商+客户+企业资料
  case Factor.iDbType of
   0,1,5:
      CLIENT_Tab:=' select TENANT_ID,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   3: CLIENT_Tab:=' select TENANT_ID,str(TENANT_ID) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   4: CLIENT_Tab:=' select TENANT_ID,ltrim(rtrim(char(TENANT_ID)))as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
  end;
  CLIENT_Tab:=
     ' select TENANT_ID,CLIENT_ID,CLIENT_NAME from PUB_CLIENTINFO '+  //供应商表
     ' union all select TENANT_ID,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME from PUB_CUSTOMER '+  //客户表
     ' union all '+CLIENT_Tab+' ';  //企业表

  //统计单位
  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  UnitCalc:='case when '+UnitCalc+'=0 then 1.0 else cast('+UnitCalc+' as decimal(18,3)) end ';
  
  strSql :=
    ' select A.TENANT_ID'+
     ',A.SHOP_ID'+
     ',A.ORDER_ID'+
     ',B.SHOP_NAME'+
     ',A.CREA_DATE'+
     ',GLIDE_NO'+
     ',ORDER_TYPE'+
     ',A.GODS_ID'+
     ',C.GODS_CODE as GODS_CODE'+
     ',C.GODS_NAME as GODS_NAME'+
     ',C.BARCODE '+
     ',A.CLIENT_ID'+
     ',A.CREA_USER'+
     ',A.UNIT_ID'+
     ',A.PROPERTY_01'+
     ',A.PROPERTY_02'+
     ',BATCH_NO'+
     ',LOCUS_NO'+
     ',STOCK_AMT as ORG_AMT'+                                                                     ///'+UnitCalc+'
     ',STOCK_AMT as BAL_AMT'+
     ',cast(case when ORDER_TYPE in (11,13) then STOCK_AMT*1.0 when ORDER_TYPE=12 then DBIN_AMT*1.0 else 0 end as decimal(18,3))/'+UnitCalc+' as IN_AMT'+
     ',cast(case when ORDER_TYPE in (21,23,24) then SALE_AMT*1.0 when ORDER_TYPE=22 then DBOUT_AMT*1.0 '+
               ' when ORDER_TYPE in (31,32) then -(CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT) else 0 end as decimal(18,3))/'+UnitCalc+' as OUT_AMT '+
     ',cast(case when ORDER_TYPE=11 then STOCK_RTL when ORDER_TYPE=12 then DBIN_RTL when ORDER_TYPE=13 then STKRT_MNY '+
           ' when ORDER_TYPE in (21,24) then SALE_RTL when ORDER_TYPE=22 then DBOUT_CST  when ORDER_TYPE=23 then SALRT_MNY '+
           ' when ORDER_TYPE > 30 then -(CHANGE1_CST+CHANGE2_CST+CHANGE3_CST+CHANGE4_CST+CHANGE5_CST) '+
           ' else 0 end as decimal(18,3)) as AMONEY '+
     ' from VIW_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSINFO C '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
     ' '+ strWhere + '  ';

  case QryType of
   0:  //保留原来查询
    begin
      //关联商品表：
      strSql :=
        'select '+
        'isnull(i.BARCODE,j.BARCODE) as BARCODE'+
        ',j.*'+
        ',(case when ORDER_TYPE in (11,12,13) then (case when IN_AMT<>0 then AMONEY*1.0/IN_AMT else AMONEY end) else (case when OUT_AMT<>0 then AMONEY*1.0/OUT_AMT else AMONEY end) end) as APRICE'+
        ',h.CLIENT_NAME as CLIENT_NAME'+
        ',e.USER_NAME as CREA_USER_TXT from '+
        ' ('+strSql+') j '+
        ' left outer join ('+CLIENT_Tab+') h on j.CLIENT_ID=h.CLIENT_ID '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) i '+
        '  on j.TENANT_ID=i.TENANT_ID and j.GODS_ID=i.GODS_ID and j.PROPERTY_01=i.PROPERTY_01 and j.PROPERTY_02=i.PROPERTY_02 and j.UNIT_ID=i.UNIT_ID '+
        ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
        ' order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';
    end;
   1: //有期初和期末查询
    begin
      strSql :=
        'select j.*'+
        ',(case when ORDER_TYPE in (11,12,13) then (case when IN_AMT<>0 then AMONEY*1.0/IN_AMT else AMONEY end) else (case when OUT_AMT<>0 then AMONEY*1.0/OUT_AMT else AMONEY end) end) as APRICE'+
        ',h.CLIENT_NAME as CLIENT_NAME'+
        ',e.USER_NAME as CREA_USER_TXT from '+
        ' ('+strSql+') j '+
        ' left outer join ('+CLIENT_Tab+') h on j.CLIENT_ID=h.CLIENT_ID '+
        ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
        ' order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';
    end;
  end;

  Result:= ParseSQL(Factor.iDbType, strSql);
end;

function TfrmGodsRunningReport.GetRowType: integer;
begin
  result := 0;
end;

procedure TfrmGodsRunningReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
    0:begin //商品出入库流水
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGoodDetailSQL;
        if strSql='' then Exit;
        CreateGrid;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
        if QryType=1 then
          CalcStorageInfo;
      end;
    1: begin //按门店汇总表
 
      end;
    2: begin //按分类汇总表

      end;
    3: begin //按商品汇总表

      end;
  end;
end;

procedure TfrmGodsRunningReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
{  if adoReport1.IsEmpty then Exit;
  P2_D1.asString := P1_D1.asString;
  P2_D2.asString := P1_D2.asString;
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
  actFind.OnExecute(nil); }
end;

procedure TfrmGodsRunningReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;   
end;

procedure TfrmGodsRunningReport.PrintBefore;
var
  ReStr: string;
  Title: TStringList;
begin
  inherited;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption+#13+#13+trim(fndP1_GODS_ID.Text);
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
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

procedure TfrmGodsRunningReport.actPriorExecute(Sender: TObject);
begin
  Exit;
  inherited;
  
end;

function TfrmGodsRunningReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //1、日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  //继承基类
  inherited AddReportReport(TitleList,PageNo);
end;
                              
procedure TfrmGodsRunningReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'ORDER_TYPE' then Text :='期末结存'; //'合计:'+Text+'笔';
  if Column.FieldName = 'ORG_AMT' then Text :=FormatStr(FReckAmt,'#0.###');
  if Column.FieldName = 'BAL_AMT' then Text :=FormatStr(FBalAmt,'#0.###');
  if Column.FieldName = 'APRICE' then
  begin
    if FSumAmt<>0 then Text :=FormatStr(FSumMny/FSumAmt,'#0.00#') else Text :=FormatStr(FSumMny,'#0.00#');
  end;
end;

procedure TfrmGodsRunningReport.AddBillTypeItems;
  procedure AddSingeItems(SetCol: TColumnEh; KeyValue,PickValue: string);
  begin
    SetCol.KeyList.Add(KeyValue);
    SetCol.PickList.Add(PickValue);
  end;
var
  rs: TZQuery;
  CurName: string;
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(DBGridEh1,'ORDER_TYPE');
  if SetCol=nil then Exit;
  SetCol.KeyList.Clear;
  SetCol.PickList.Clear;
  AddSingeItems(SetCol,'00','期  初');
  //入库单据:
  AddSingeItems(SetCol,'11','入库单');
  AddSingeItems(SetCol,'12','调入单');
  AddSingeItems(SetCol,'13','退货单');
  //销售单据:
  AddSingeItems(SetCol,'21','销售单');
  AddSingeItems(SetCol,'22','调出单');
  AddSingeItems(SetCol,'23','退货单');
  AddSingeItems(SetCol,'24','零售单');
  //调整单据:
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  if (rs<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add('3'+trim(rs.fieldbyName('CHANGE_CODE').AsString));
      CurName:=trim(rs.fieldbyName('CHANGE_NAME').AsString);
      if not (pos('单',CurName)>0) then CurName:=CurName+'单'; 
      SetCol.PickList.Add(CurName);
      rs.Next;
    end;
  end;
end;                                                      

function TfrmGodsRunningReport.GetGoodStorageORG: Boolean;
var
  rs:TZQuery;
  UnitCalc: string; 
  Str,GodsID,MaxReckDate,BegDate,Shop_Cnd: string;
begin
  result:=False;
  FReckAmt:=0;
  FReckMny:=0;
  FBalAmt:=0;
  FSumAmt:=0;
  FSumMny:=0;

  MaxReckDate:='';
  GodsID:=trim(fndP1_GODS_ID.AsString);
  BegDate:=FormatDatetime('YYYYMMDD',P1_D1.Date-1); //查询最大日期
  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'D');
  if trim(fndP1_SHOP_ID.AsString)<>'' then
    Shop_Cnd:=' and SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
  rs := TZQuery.Create(nil);
  try
    Str:='select Max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+Shop_Cnd;
    rs.Close;
    rs.SQL.Text := ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);

    if MaxReckDate='' then //未结账全部走视图:
    begin
      Str:=
        'select sum(cast(case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                        ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                        ' when ORDER_TYPE=12 then DBIN_AMT '+
                        ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                        ' else (CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*1.0 end as decimal(18,3))*1.0/'+UnitCalc+')as BAL_AMT,'+
               ' sum(cast(case when ORDER_TYPE in (21,22,23,24) then -CALC_MONEY else CALC_MONEY end as decimal(18,3))) as BAL_RTL '+
         'from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
         ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+Shop_Cnd+' '+
         ' and A.CREA_DATE<='+BegDate+' and A.GODS_ID='''+GodsID+''' ';
    end else
    begin
      if MaxReckDate>=BegDate then  //已结账，全部走台账表
      begin
        Str:='select A.BAL_AMT*1.0/'+UnitCalc+' as BAL_AMT,A.BAL_RTL as BAL_RTL from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
             ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' and A.GODS_ID='''+GodsID+''' '+
             ' and A.CREA_DATE='+BegDate+' '+Shop_Cnd;
      end else //走两部分联合[union]
      begin
        Str:=
           'select sum(BAL_AMT) as BAL_AMT,sum(BAL_RTL) as BAL_RTL from '+
           '(select (A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT,A.BAL_RTL as BAL_RTL '+
           ' from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
           ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
           ' '+Shop_Cnd+' and A.GODS_ID='''+GodsID+''' and A.CREA_DATE='+MaxReckDate+' '+
           '  union all  '+
           ' select sum((case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                            ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                            ' when ORDER_TYPE=12 then DBIN_AMT '+
                            ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                            ' else CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)*1.0/'+UnitCalc+')as BAL_AMT,'+
                 ' sum(case when ORDER_TYPE in (21,22,23,24) then -CALC_MONEY else CALC_MONEY end) as BAL_RTL '+
           ' from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
           ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+Shop_Cnd+' and '+
           ' A.CREA_DATE>'+MaxReckDate+' and A.CREA_DATE<='+BegDate+' and A.GODS_ID='''+GodsID+''')tmp';
      end;
    end;
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if Rs.Active then
    begin
      if Rs.RecordCount=1 then
      begin
        FReckAmt:=rs.fieldbyName('BAL_AMT').AsFloat;
        FReckMny:=rs.fieldbyName('BAL_RTL').AsFloat;
        result:=true;
      end else
      if Rs.RecordCount=0 then
      begin
        FReckAmt:=0;
        FReckMny:=0;
        result:=true;
      end;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmGodsRunningReport.CreateGrid;
var
  ColIdx: integer;
  Column: TColumnEh;
begin
  Column:=FindColumn(DBGridEh1,'ORG_AMT');
  if Column<>nil then Column.Free;
  Column:=FindColumn(DBGridEh1,'BAL_AMT');
  if Column<>nil then Column.Free;

  if QryType=1 then
  begin
    DBGridEh1.Columns.BeginUpdate;
    try
      Column:=FindColumn(DBGridEh1,'IN_AMT');
      ColIdx:=Column.Index;
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'ORG_AMT';
      Column.Title.Caption :='期初数量';
      Column.Width := 70;
      if ColIdx+1<=DBGridEh1.Columns.Count then
        Column.Index := ColIdx;
      Column.Alignment:=taRightJustify;
      Column.DisplayFormat:='#0.###';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.###';
      Column.Footer.Alignment:=taRightJustify;

      Column:=FindColumn(DBGridEh1,'OUT_AMT');
      ColIdx:=Column.Index;
      Column := DBGridEh1.Columns.Add;
      Column.FieldName := 'BAL_AMT';
      Column.Title.Caption :='结存数量';
      Column.Width := 70;
      if ColIdx+1<=DBGridEh1.Columns.Count then
        Column.Index := ColIdx+1;
      Column.Alignment:=taRightJustify;
      Column.DisplayFormat:='#0.###';
      Column.Footer.ValueType:=fvtSum;
      Column.Footer.DisplayFormat:='#0.###';
      Column.Footer.Alignment:=taRightJustify;
    finally
       DBGridEh1.Columns.EndUpdate;
    end;
  end;
end;

procedure TfrmGodsRunningReport.CalcStorageInfo;
begin
  try
    FBalAmt:=FReckAmt;   
    adoReport1.DisableControls;
    if adoReport1.Active then
    begin
      adoReport1.First;
      while not adoReport1.Eof do
      begin
        FSumAmt:=FSumAmt+adoReport1.FieldByName('IN_AMT').AsFloat+adoReport1.FieldByName('OUT_AMT').AsFloat;
        FSumMny:=FSumMny+adoReport1.FieldByName('AMONEY').AsFloat;
        adoReport1.Edit;
        if adoReport1.RecNo=1 then //计算期初单价
        begin
          adoReport1.FieldByName('ORG_AMT').AsFloat:=FReckAmt; //本条期初数量
          //adoReport1.FieldByName('AMONEY').AsFloat:=FReckMny;
          //if FReckAmt<>0 then adoReport1.FieldByName('APRICE').AsFloat:=FReckMny/FReckAmt;
        end else
        begin
          adoReport1.FieldByName('ORG_AMT').AsFloat:=FBalAmt; //本条期初数量
        end;
        FBalAmt:=FBalAmt+adoReport1.fieldbyName('IN_AMT').AsFloat-adoReport1.fieldbyName('OUT_AMT').AsFloat;
        adoReport1.FieldByName('BAL_AMT').AsFloat:=FBalAmt;  //本条期末数量
        adoReport1.Post;
        adoReport1.Next;
      end;
    end;
    adoReport1.First;
  finally
    adoReport1.EnableControls;
  end;
end;

function TfrmGodsRunningReport.GetQryType: integer;
begin
  if (fndP1_BarType_ID.ItemIndex>-1) and (trim(fndP1_BarCode.Text)<>'') then
    result:=0
  else
    result:=1;
end;

function TfrmGodsRunningReport.FormatStr(SetValue: Real; Format: string): string;
var
  ReValue: Real;
begin
  Revalue:=Round(SetValue*1000);
  Revalue:=Revalue*0.001;
  if Format<>'' then 
    result:=FormatFloat(Format,Revalue)
  else
    result:=FloatToStr(Revalue);
end;

end.

