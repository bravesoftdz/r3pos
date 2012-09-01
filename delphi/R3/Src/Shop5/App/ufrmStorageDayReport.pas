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
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    fndP4_ReckType: TcxComboBox;
    fndP3_ReckType: TcxComboBox;
    fndP2_ReckType: TcxComboBox;
    fndP1_ReckType: TcxComboBox;
    Label4: TLabel;
    fndP4_STOR_AMT: TcxComboBox;
    Label38: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
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
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh4TitleClick(Column: TColumnEh);
  private
    IsOnDblClick: Boolean;
    BAL_Date: integer;  //查询库存日期[查询库存日期，查询当前天的下一天期初]

    GodsID: string;      //当前双击明细的GODS_IDs
    SortName: string;
    sid1,sid2,sid4,sid5: string;
    srid1,srid2,srid4,srid5: string;

    procedure CheckCalc(endDate:integer); //开始月份| 结束月份
    //1、按管理销售汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //2、按门店销售汇总表
    function GetShopSQL(chk:boolean=true): string;
    //3、按分类销售汇总表
    function GetSortSQL(chk:boolean=true): string;
    //4、按商品销售汇总表
    function GetGodsSQL(chk:boolean=true): string;
    function AddReportReport(TitleList: TStringList; PageNo: string): string;override; //添加Title
    procedure DoReckTypeOnChange(Sender: TObject);
    function GetGodsSortIdx: string; //
    function GetDataRight: string; //返回查看数据权限
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  GodsSortIdx: string read GetGodsSortIdx; //统计类型
    property  DataRight: string read GetDataRight; //返回查看数据权限
  end;

const
  ArySumField: Array[0..2] of string=('BAL_AMT','BAL_CST','BAL_RTL');

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
  fndP4_STOR_AMT.ItemIndex := 0;
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

  SetRzPageActivePage; //设置PzPage.Activepage

  RefreshColumn;
  //2011.12.22 重开启[若非总店默认当前门店]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP3_SHOP_ID.Properties.ReadOnly := False;
    fndP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP3_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP3_SHOP_ID.Style);
    //fndP3_SHOP_ID.Properties.ReadOnly := True;

    fndP4_SHOP_ID.Properties.ReadOnly := False;
    fndP4_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP4_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP4_SHOP_ID.Style);
    //fndP4_SHOP_ID.Properties.ReadOnly := True;
  end;

  //2011.04.22 Add 设置查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh2, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh3, ['BAL_PRC','BAL_CST']);
    SetNotShowCostPrice(DBGridEh4, ['BAL_PRC','BAL_CST']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;

  //2011.09.22 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.BAL_CST','DBGridEh1.BAL_RTL',
                              'DBGridEh2.BAL_CST','DBGridEh2.BAL_RTL',
                              'DBGridEh3.BAL_CST','DBGridEh3.BAL_RTL',
                              'DBGridEh4.BAL_CST','DBGridEh4.BAL_RTL']);
  //2012.08.15创建尺码、颜色
  if ShopGlobal.GetVersionFlag=1 then
    CreateGridColForFIG(DBGridEh4,4);
end;

function TfrmStorageDayReport.GetGroupSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,strWhere,GoodTab: string;
begin
  //过滤企业ID和查询日期:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

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
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;
  //商品分类:
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
  //日期条件
  if fndP1_ReckType.ItemIndex=0 then //直接查询库存表:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',REGION_ID'+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,B.REGION_ID,AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //库存数量
       ',AMONEY as BAL_CST '+     //库存金额
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //零售金额
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,REGION_ID ';
    Result :=  ParseSQL(Factor.iDbType,
      'select j.* '+
      ',isnull(r.CODE_NAME,''无'') as CODE_NAME from ('+strSql+') j '+
      ' left outer join '+
      ' (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r on j.REGION_ID=r.CODE_ID order by j.REGION_ID'
      );
  end else
  if fndP1_ReckType.ItemIndex=1 then
  begin
    if P1_D1.EditValue = null then Raise Exception.Create(' 库存日期不能为空！  '); 
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));
    //检测是否计算
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and A.CREA_DATE in (select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where A.TENANT_ID=DD.TENANT_ID and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';

    strSql :=        
      'SELECT '+
      ' A.TENANT_ID '+
      ',B.REGION_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID  and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,B.REGION_ID';

    strSql :=
      'select j.* '+
      ',isnull(r.CODE_NAME,''无'') as CODE_NAME '+
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
    0: begin //按地区汇总表
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGroupSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //按门店汇总表
        if adoReport2.Active then adoReport2.Close;
        strSql := GetShopSQL;
        if strSql='' then Exit;
        adoReport2.SQL.Text := strSql;
        Factor.Open(adoReport2);
      end;
    2: begin //按分类汇总表
        if adoReport3.Active then adoReport3.Close;
        strSql := GetSortSQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
        Do_REPORT_FLAGFooterSum(fndP3_REPORT_FLAG, adoReport3, ArySumField);
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        adoReport4.SortedFields:='';
        strSql := GetGodsSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
        dsadoReport4.DataSet:=nil;
        DoGodsGroupBySort(adoReport4,GodsSortIdx,'SORT_ID','GODS_NAME','ORDER_ID',
                          ['BAL_AMT','BAL_PRC','BAL_CST','BAL_OUTPRC','BAL_RTL'],
                          ['BAL_PRC=BAL_CST/BAL_AMT','BAL_OUTPRC=BAL_RTL/BAL_AMT']);
        dsadoReport4.DataSet:=adoReport4;
      end;
  end;
end;

function TfrmStorageDayReport.GetShopSQL(chk:boolean=true): string;
var
  UnitCalc: string;  //单位计算关系
  strSql,strWhere,GoodTab: string;
begin
  //过滤企业ID和查询日期:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //门店所属行政区域|门店类型:
  if (fndP2_SHOP_VALUE.AsString<>'') then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //商品指标:
  if (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;
  //商品分类:
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
  //日期条件
  if fndP2_ReckType.ItemIndex=0 then //直接查询库存表:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',SHOP_ID'+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when cast(sum(BAL_AMT) as decimal(19,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(19,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,B.SHOP_ID,AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //库存数量
       ',AMONEY as BAL_CST '+     //库存金额
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //零售金额
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,SHOP_ID ';
    Result :=  ParseSQL(Factor.iDbType,
      'select j.* '+
      ',r.SEQ_NO as SHOP_CODE,r.SHOP_NAME from ('+strSql+') j '+
      ' left outer join CA_SHOP_INFO r on j.TENANT_ID=r.TENANT_ID and j.SHOP_ID=r.SHOP_ID order by r.SEQ_NO'
      );
  end else
  if fndP2_ReckType.ItemIndex=1 then
  begin
    if P2_D1.EditValue = null then Raise Exception.Create(' 库存日期不能为空！  ');
    //检测是否计算
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //库存日期=+1天取期初
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and A.CREA_DATE in (select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where A.TENANT_ID=DD.TENANT_ID and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';

    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.SHOP_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+')as decimal(18,3))<>0 then sum(BAL_CST)*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+')as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+')as decimal(18,3))<>0 then sum(BAL_RTL*1.00)/cast(sum(BAL_AMT*1.00/'+UnitCalc+')as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID  and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
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
  GodsStateIdx: integer; //表表统计指标Idx
  UnitCalc,JoinCnd: string;
  strSql,strWhere,GoodTab,lv,lv1,lvField: string;
begin
  lv:='';
  lv1:='';
  lvField:='';
  result:='';
  //商品指标:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('请选择报表类型...');
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //过滤企业ID和查询日期:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //门店所属行政区域|门店类型:
  if (fndP3_SHOP_VALUE.AsString<>'') then
  begin
    case fndP3_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP3_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP3_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP3_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //门店条件
  if (fndP3_SHOP_ID.AsString<>'') then
    begin
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
    end;

  //商品分类:
  case GodsStateIdx of
  1:begin
      GoodTab:='VIW_GOODSPRICE_SORTEXT';
      lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
      lv1 := ',LEVEL_ID';
      lvField:=Lv+'  as LEVEL_ID ';
    end;
  else
    GoodTab:='VIW_GOODSPRICE';
  end;

  //单位换算
  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  //日期条件
  if fndP3_ReckType.ItemIndex=0 then //直接查询库存表:
  begin
    strSql :=
      'select '+
      ' TENANT_ID'+
      ',GODS_ID,SORT_ID'+InttoStr(GodsStateIdx)+lv1+',RELATION_ID '+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lvField+',C.RELATION_ID '+
       ',AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+    //库存数量
       ',AMONEY as BAL_CST '+                 //库存金额
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //零售金额
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      'group by TENANT_ID,GODS_ID,SORT_ID'+InttoStr(GodsStateIdx)+lv1+',RELATION_ID';
  end else
  if fndP3_ReckType.ItemIndex=1 then
  begin
    //检测是否计算
    if P3_D1.EditValue = null then Raise Exception.Create(' 库存日期不能为空！  ');
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //库存日期=+1天取期初
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and A.CREA_DATE in (select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where A.TENANT_ID=DD.TENANT_ID and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ',A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lvField+',C.RELATION_ID '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',sum(BAL_CST) as BAL_CST '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID'+InttoStr(GodsStateIdx)+lv+',C.RELATION_ID';
  end;

  case TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
      //报表类型关联
       case Factor.iDbType of
        4: JoinCnd:=' and j.LEVEL_ID=substr(r.LEVEL_ID,1,length(j.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(nvl(BAL_AMT,0)) as BAL_AMT '+
          ',case when cast(sum(nvl(BAL_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(BAL_CST,0)) as decimal(18,3))*1.00/cast(sum(nvl(BAL_AMT,0)) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(nvl(BAL_CST,0)) as BAL_CST '+
          ',case when cast(sum(nvl(BAL_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(BAL_RTL,0)) as decimal(18,3))*1.00/cast(sum(nvl(BAL_AMT,0)) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(nvl(BAL_RTL,0)) as BAL_RTL '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID')+' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'')) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(BAL_AMT) as BAL_AMT '+
          ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(BAL_CST) as BAL_CST '+
          ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(BAL_RTL) as BAL_RTL '+
          ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''无厂家'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(BAL_AMT) as BAL_AMT '+
          ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
          ',sum(BAL_CST) as BAL_CST '+
          ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
          ',sum(BAL_RTL) as BAL_RTL '+
          ',isnull(r.SORT_ID,''#'') as SID '+
          ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''无'') as SORT_NAME from ('+strSql+') j left outer join ('+
          'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+' '+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').asString+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmStorageDayReport.GetGodsSQL(chk:boolean=true): string;
var
  UnitCalc,SORT_ID: string;
  strSql,strWhere,GoodTab: string;
begin
  //过滤企业ID和查询日期:
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' '+DataRight;

  //门店所属行政区域|门店类型:
  if (fndP4_SHOP_VALUE.AsString<>'') then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP4_SHOP_VALUE.AsString),2)='00' then //非末级区域
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP4_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //门店条件
  if (fndP4_SHOP_ID.AsString<>'') then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';

  if fndP4_ReckType.ItemIndex=0 then
  begin
    case fndP4_STOR_AMT.ItemIndex of
     1: StrWhere := StrWhere + ' and round(A.AMOUNT,3)<>0';
     2: StrWhere := StrWhere + ' and round(A.AMOUNT,3)>0';
     3: StrWhere := StrWhere + ' and round(A.AMOUNT,3)=0';
     4: StrWhere := StrWhere + ' and round(A.AMOUNT,3)<0';
    end;
  end else
  begin
    case fndP4_STOR_AMT.ItemIndex of
     1: StrWhere := StrWhere + ' and round(A.BAL_AMT,3)<>0';
     2: StrWhere := StrWhere + ' and round(A.BAL_AMT,3)>0';
     3: StrWhere := StrWhere + ' and round(A.BAL_AMT,3)=0';
     4: StrWhere := StrWhere + ' and round(A.BAL_AMT,3)<0';
    end;
  end;
  
  //商品指标:
  if (fndP4_STAT_ID.AsString <> '') and (fndP4_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP4_TYPE_ID)+'='''+fndP4_STAT_ID.AsString+''' ';
  end;

  //商品分类:
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

  //分组字段
  case StrToInt(GodsSortIdx) of
   0: SORT_ID:='C.RELATION_ID';
   else
      SORT_ID:='case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end';
      //SORT_ID:='isnull(C.SORT_ID'+GodsSortIdx+',''#'')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  //日期条件
  if fndP4_ReckType.ItemIndex=0 then //直接查询库存表:
  begin
    strSql :=
      'select '+
      ' TENANT_ID,SORT_ID,GODS_ID,CALC_BARCODE,GODS_CODE,GODS_NAME,PROPERTY_01,BATCH_NO,PROPERTY_02,UNIT_ID  '+
      ',sum(BAL_AMT) as BAL_AMT'+
      ',sum(BAL_CST) as BAL_CST'+
      ',sum(BAL_RTL) as BAL_RTL'+
      ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_PRC '+
      ',case when cast(sum(BAL_AMT) as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT) as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ' from '+
       '(SELECT '+
       ' A.TENANT_ID,'+SORT_ID+' as SORT_ID,A.GODS_ID,c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME,'+
       ' A.PROPERTY_01,A.BATCH_NO,A.PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' as UNIT_ID '+
       ',AMOUNT*1.00/'+UnitCalc+' as BAL_AMT '+     //库存数量
       ',AMONEY as BAL_CST '+     //库存金额
       ',AMOUNT*C.NEW_OUTPRICE as BAL_RTL '+  //零售金额
       'from STO_STORAGE A,CA_SHOP_INFO B,'+GoodTab+' C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ') tp '+
      ' group by TENANT_ID,SORT_ID,GODS_ID,CALC_BARCODE,GODS_CODE,GODS_NAME,PROPERTY_01,BATCH_NO,PROPERTY_02,UNIT_ID ';

    case StrtoInt(GodsSortIdx) of
     0:
      begin
        strSql :=
          'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
          'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
          'on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
          'left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
          ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE';
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
    result:=ParseSQL(Factor.iDbType, strSql);
  end else
  if fndP4_ReckType.ItemIndex=1 then //查询台账表:
  begin
    if P4_D1.EditValue = null then Raise Exception.Create(' 库存日期不能为空！  ');
    BAL_Date:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));
    //检测是否计算
    CheckCalc(BAL_Date);
    strWhere:=strWhere+' and A.CREA_DATE in (select Max(CREA_DATE) as CREA_DATE from RCK_GOODS_DAYS DD where A.TENANT_ID=DD.TENANT_ID and DD.CREA_DATE<='+InttoStr(BAL_Date)+') ';
    strSql :=
      'SELECT '+
      ' A.TENANT_ID '+
      ','+SORT_ID+' as SORT_ID '+
      ',A.GODS_ID '+
      ',c.BARCODE as CALC_BARCODE,c.GODS_CODE,c.GODS_NAME,''#'' as PROPERTY_01,A.BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' as UNIT_ID  '+
      ',sum(BAL_AMT*1.00/'+UnitCalc+') as BAL_AMT '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(BAL_CST) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_PRC '+
      ',sum(BAL_CST) as BAL_CST '+
      ',case when cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(BAL_RTL) as decimal(18,3))*1.00/cast(sum(BAL_AMT*1.00/'+UnitCalc+') as decimal(18,3)) else 0 end as BAL_OUTPRC '+
      ',sum(BAL_RTL) as BAL_RTL '+
      'from RCK_GOODS_DAYS A,CA_SHOP_INFO B,'+GoodTab+' C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID  and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
      'group by A.TENANT_ID,'+SORT_ID+',A.GODS_ID,c.BARCODE,c.GODS_CODE,c.GODS_NAME,A.BATCH_NO,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'C')+' ';

    case StrtoInt(GodsSortIdx) of
     0:
      begin
        strSql :=
          'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID '+
          ' ,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from '+
          ' ('+strSql+') j '+
          ' left outer join '+
          ' (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
          '   on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
          ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
          '  order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE ';
      end;
     else
      begin
        strSql :=
          'select j.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from '+
          ' ('+strSql+') j '+
          ' left outer join '+
          ' (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
          '   on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
          ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
          ' left outer join '+
          '(select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
          ' on  j.SORT_ID=s.SORT_ID '+
          ' order by s.ORDER_ID,j.GODS_CODE';
      end;
    end;
    result:=ParseSQL(Factor.iDbType, strSql);
  end;
end;

procedure TfrmStorageDayReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true;
  //复制查询条件参数
  sid2 := sid1;
  srid2 := srid1;
  fndP2_SORT_ID.Text:=fndP1_SORT_ID.Text;

  P1_D1.Date := P2_D1.Date;
  fndP2_ReckType.ItemIndex:=fndP1_ReckType.ItemIndex;
  fndP2_SHOP_TYPE.ItemIndex:=0;  //管理群组
  fndP2_SHOP_VALUE.KeyValue:=trim(adoReport1.fieldbyName('REGION_ID').AsString);
  fndP2_SHOP_VALUE.Text:=trim(adoReport1.fieldbyName('CODE_NAME').AsString);
  Copy_ParamsValue('TYPE_ID',1,2);  //商品指标
  fndP2_UNIT_ID.ItemIndex:=fndP1_UNIT_ID.ItemIndex; //显示单位
  rzPage.ActivePageIndex := 1;
  actFind.OnExecute(nil);
end;

procedure TfrmStorageDayReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true;
  //查询日期
  fndP3_ReckType.ItemIndex:=fndP2_ReckType.ItemIndex;
  P3_D1.Date:=P2_D1.Date;
  Copy_ParamsValue('SHOP_TYPE',2,3); //管理群组
  fndP3_SHOP_ID.KeyValue:=adoReport2.fieldbyName('SHOP_ID').AsString; //门店ID
  fndP3_SHOP_ID.Text:=adoReport2.fieldbyName('SHOP_NAME').AsString;   //门店名称 
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex;  //显示单位

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
  //肯定有报表类型:
  CodeID:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case CodeID of
   1,3:
     if trim(adoReport3.FieldByName('SORT_NAME').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
   else
     if trim(adoReport3.FieldByName('SID').AsString)='' then Raise Exception.Create(fndP3_REPORT_FLAG.Text+'名称不能为空！');
  end;

  case CodeID of
   1:  //商品分类[带供应链接]
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

  //查询日期
  fndP4_ReckType.ItemIndex:=fndP3_ReckType.ItemIndex;
  P4_D1.Date:=P3_D1.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4);  //管理群组
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID);  //门店名称
  fndP4_UNIT_ID.ItemIndex:=fndP3_UNIT_ID.ItemIndex;  //显示单位
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
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
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
    IsOnDblClick:=False; //重置标记位
    Exit; //若是双点击[DBGridEh连带查询则不在试算台帐]
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
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  if (FindCmp1<>nil) and (FindCmp1 is TcxDateEdit) and (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp1).EditValue<>null) then
    TitleList.add('日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date));
 //门店名称：
 FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_ID');
 if (FindCmp1<>nil) and (FindCmp1 is TzrComboBoxList) and (TzrComboBoxList(FindCmp1).AsString<>'') and (TzrComboBoxList(FindCmp1).Visible)  then
   TitleList.Add('门店名称：'+TzrComboBoxList(FindCmp1).Text);
  //管理群组：
  FindCmp1:=FindComponent('fndP'+PageNo+'_SHOP_TYPE');  
  FindCmp2:=FindComponent('fndP'+PageNo+'_SHOP_VALUE');   
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList)  and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'')  then
    TitleList.add(TcxComboBox(FindCmp1).Text+'：'+TzrComboBoxList(FindCmp2).Text);
  //商品指标：
  FindCmp1:=FindComponent('fndP'+PageNo+'_TYPE_ID');   
  FindCmp2:=FindComponent('fndP'+PageNo+'_STAT_ID');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxComboBox) and (FindCmp2 is TzrComboBoxList) and (TcxComboBox(FindCmp1).Visible) and
     (TcxComboBox(FindCmp1).ItemIndex<>-1) and (TzrComboBoxList(FindCmp2).Visible) and (TzrComboBoxList(FindCmp2).AsString<>'') then
    TitleList.add(TcxComboBox(FindCmp1).Text+'：'+TzrComboBoxList(FindCmp2).Text);
  //商品分类
  FindCmp1:=FindComponent('fndP'+PageNo+'_SORT_ID');
  if (FindCmp1<>nil) and (FindCmp1 is TcxButtonEdit) and (TcxButtonEdit(FindCmp1).Visible) and (TcxButtonEdit(FindCmp1).Text<>'') then
    TitleList.Add('商品分类：'+TcxButtonEdit(FindCmp1).Text);   
  //计量单位
  FindCmp1:=FindComponent('fndP'+PageNo+'_UNIT_ID'); 
  if (FindCmp1<>nil) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex<>-1) then
    TitleList.Add('统计单位：'+TcxComboBox(FindCmp1).Text);
end;

procedure TfrmStorageDayReport.DoReckTypeOnChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //返回控件Num
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
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmStorageDayReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmStorageDayReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  i: integer;
  FName: string;
begin
  inherited;
  if Column.FieldName = 'SORT_NAME' then Text := '合计:'+Text+'笔'
  else
  begin
    if (SumRecord.Count>0) and (SumRecord.FindField(Column.FieldName)<>nil) then //字段数大于0 自己累计
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

procedure TfrmStorageDayReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
var
  ColName: string;
begin
  if Column.FieldName = 'GODS_NAME' then Text := '合计:'+Text+'笔';
  if AllRecord.Count<=0 then Exit;
  ColName:=trim(UpperCase(Column.FieldName));
  if ColName = 'GODS_NAME' then
    Text := '合计:'+AllRecord.fieldbyName('GODS_NAME').AsString+'笔'
  else
  begin
    if AllRecord.FindField(ColName)<>nil then
    begin
      if Copy(ColName,1,4)='BAL_' then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end;
    end;
  end;
end;

function TfrmStorageDayReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';   
end;

procedure TfrmStorageDayReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

procedure TfrmStorageDayReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  DBGridTitleClick(adoReport4,Column,'ORDER_ID');
end;

function TfrmStorageDayReport.GetDataRight: string;
begin
  //主数据：STO_STORAGE、RCK_GOODS_DAYS
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

