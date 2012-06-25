unit ufrmCustCardReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zbase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxRadioGroup,
  ufrmDateControl, Buttons;

type
  TfrmCustCardReport = class(TframeBaseReport)
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    btnOk: TRzBitBtn;
    dsadoReport2: TDataSource;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    adoReport2: TZQuery;
    TabSheet2: TRzTabSheet;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    RzPanel19: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    Label23: TLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
    Label3: TLabel;
    fndP1_KEY_TYPE: TcxComboBox;
    fndP1_KEY_VALUE: TcxTextEdit;
    Label6: TLabel;
    Label7: TLabel;
    fndP1_IC_TYPE: TcxComboBox;
    GroupBox1: TGroupBox;
    P1_CB_2: TCheckBox;
    P1_CB_3: TCheckBox;
    P1_CB_4: TCheckBox;
    P1_CB_1: TCheckBox;
    Label8: TLabel;
    fndP1_IC_STATUS: TcxComboBox;
    Label9: TLabel;
    fndP1_SHOP_ID: TzrComboBoxList;
    Label4: TLabel;
    fndP2_SHOP_ID: TzrComboBoxList;
    Label10: TLabel;
    fndP2_IC_TYPE: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    //返回会员卡明细账查询
    function GetCustCardDetailSQL: string;
    //返回会员卡明细账查询
    function GetCustCardSumSQL: string;

    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    //设置Page分页显示:（IsGroupReport是否分组[区域、门店]）
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function  GetDataRight: string;
  public
    procedure SingleReportParams(ParameStr: string='');override; //简单报表调用参数
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property DataRight: string read GetDataRight; //返回查看数据权限
  end;

const
  ArySumField: Array[0..5] of string=('SALE_AMT','SALE_TTL','SALE_TAX','SALE_MNY','SALE_CST','SALE_ALLPRF');
  
implementation

uses
  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmCustCardReport.FormCreate(Sender: TObject);
var
  SetCol: TColumnEh;
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
  fndP1_KEY_TYPE.ItemIndex:=0;

  //设置卡类型
  AddCBxItemsList(fndP1_IC_TYPE,'IC_TYPE',true);
  fndP1_IC_TYPE.ItemIndex:=0;
  //设置卡状态
  AddCBxItemsList(fndP1_IC_STATUS,'IC_STATUS',true);
  fndP1_IC_STATUS.ItemIndex:=0;
  //设置卡类型
  AddCBxItemsList(fndP2_IC_TYPE,'IC_TYPE',true);
  fndP2_IC_TYPE.ItemIndex:=0;


  SetRzPageActivePage; //设置PzPage.Activepage
  RefreshColumn;
 
  if ShopGlobal.GetProdFlag = 'E' then
  begin
    Label5.Caption := '仓库群组';
    Label23.Caption := '仓库群组';
  end; 

  //2011.09.21 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.ID_REG','DBGridEh1.ID_SAL','DBGridEh1.IC_BAL']);
end;

function TfrmCustCardReport.GetRowType: integer;
begin
  result :=0;
  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmCustCardReport.actFindExecute(Sender: TObject);
var
  strSql: string;
begin
  case rzPage.ActivePageIndex of
   0:
     begin //会员卡明细账报表
       if adoReport1.Active then adoReport1.Close;
       strSql := GetCustCardDetailSQL;
       if strSql='' then Exit;
       adoReport1.SQL.Text:= strSql;
       Factor.Open(adoReport1);
     end;
    1:
     begin //会员卡统计
       if adoReport2.Active then adoReport2.Close;
       strSql := GetCustCardSumSQL;
       if strSql='' then Exit;
       adoReport2.SQL.Text:= strSql;
       Factor.Open(adoReport2);
     end;
  end;
end;

procedure TfrmCustCardReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmCustCardReport.PrintBefore;
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
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmCustCardReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  TypeName: string;
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
  begin
    case RzPage.ActivePageIndex of
     0: TitleList.add('查询日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
     1: TitleList.add('统计日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));
    end;
  end;
  
  //查询卡类型
  FindCmp1:=FindComponent('fndP'+PageNo+'_IC_TYPE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
  begin
    TitleList.add('卡 类 型：'+TcxComboBox(FindCmp1).Text);
  end;
  //其他条件
  if RzPage.ActivePageIndex=0 then
  begin
    FindCmp1:=FindComponent('fndP'+PageNo+'_IC_STATUS');
    if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
    begin
      TitleList.add('卡 状 态：'+TcxComboBox(FindCmp1).Text);
    end;
    TypeName:='';
    if P1_CB_1.Checked then TypeName:='充值';
    if P1_CB_2.Checked then
    begin
      if TypeName='' then TypeName:='退款' else TypeName:=TypeName+'\充值';
    end;
    if P1_CB_3.Checked then
    begin
      if TypeName='' then TypeName:='消费' else TypeName:=TypeName+'\消费';
    end;
    if P1_CB_4.Checked then
    begin
      if TypeName='' then TypeName:='支付' else TypeName:=TypeName+'\支付';
    end;
    TitleList.add('查询类型：'+TypeName);
    if fndP1_KEY_VALUE.Text<>'' then
      TitleList.add('查询['+fndP1_KEY_TYPE.Text+']=('+fndP1_KEY_VALUE.Text+')');
  end;  

  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmCustCardReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'IC_CARD_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmCustCardReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'IC_DATE' then Text := '合计:'+Text+'笔';
end;

procedure TfrmCustCardReport.SetRzPageActivePage(IsGroupReport: Boolean);
begin
  //
end;

procedure TfrmCustCardReport.SingleReportParams(ParameStr: string);
begin

end;

function TfrmCustCardReport.GetDataRight: string;
begin
  //主数据：RCK_C_GOODS_DAYS、VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('B.SHOP_ID',1);
end;

function TfrmCustCardReport.GetCustCardDetailSQL: string;
var
  CardSumTab: string;
  CardCnd,LikeCnd,DateCnd: string;
  CzStr: string;
  TkStr: string;
  SaleStr: string;
  PayStr: string;
  ViwTab: string;
  i: integer;
begin
  i:=0;
  if P1_D1.EditValue = null then Raise Exception.Create('开始日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('开始日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  if (not P1_CB_1.Checked) and (not P1_CB_2.Checked) and (not P1_CB_3.Checked) and (not P1_CB_4.Checked) then
    Raise Exception.Create(' 请选择查询类型... '); 
  //卡汇总的Viw
  if trim(fndP1_SHOP_ID.AsString)<>'' then
  begin
    CardSumTab:=
      'select '+
        'CLIENT_ID,'+
        'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
        'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
      ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' group by CLIENT_ID ';
  end else
  begin
    CardSumTab:=
      'select '+
        'CLIENT_ID,'+
        'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
        'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
      ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' group by CLIENT_ID ';
  end;
  
  LikeCnd:='';
  CardCnd:=' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+GetDataRight;
  //门店群组
  if trim(fndP1_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP1_SHOP_TYPE.ItemIndex of
     0:
      begin
        if FnString.TrimRight(trim(fndP1_SHOP_VALUE.AsString),2)='00' then //非末级区域
          CardCnd:=CardCnd+' and B.REGION_ID like '''+GetRegionId(fndP1_SHOP_VALUE.AsString)+'%'' '
        else
          CardCnd:=CardCnd+' and B.REGION_ID='''+fndP1_SHOP_VALUE.AsString+''' ';
      end;
     1: CardCnd:=CardCnd+' and B.SHOP_TYPE='''+fndP1_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //门店条件
  if trim(fndP1_SHOP_ID.AsString)<>'' then
    CardCnd:=CardCnd+' and B.SHOP_ID='''+trim(fndP1_SHOP_ID.AsString)+''' ';
  //卡类型
  if fndP1_IC_TYPE.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_TYPE='''+TRecord_(fndP1_IC_TYPE.Properties.Items.Objects[fndP1_IC_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';
  //卡状态
  if fndP1_IC_STATUS.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_STATUS='''+TRecord_(fndP1_IC_STATUS.Properties.Items.Objects[fndP1_IC_STATUS.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';
  if trim(fndP1_KEY_VALUE.Text)<>'' then
  begin
    LikeCnd:='''%'+fndP1_KEY_VALUE.Text+'%'' ';
    case fndP1_KEY_TYPE.ItemIndex of
      0:  //全部:会员卡号，客户编码，客户名称，证件号，手机号，办公电话，家庭电话
       begin
         LikeCnd:=' and ((C.IC_CARDNO like '+LikeCnd+') or (A.CUST_CODE like '+LikeCnd+') or (A.CUST_NAME like '+LikeCnd+') or (C.CUST_SPELL like '+LikeCnd+') or '+
                       ' (C.ID_NUMBER like '+LikeCnd+') or (A.MOVE_TELE like '+LikeCnd+') or (A.OFFI_TELE like '+LikeCnd+') or (A.FAMI_TELE like '+LikeCnd+')) ';
       end;
      1: LikeCnd:=' and (C.IC_CARDNO like '+LikeCnd+')'; //会员卡号
      2: LikeCnd:=' and (C.CUST_CODE like '+LikeCnd+')'; //客户编码
      3: LikeCnd:=' and (C.CUST_NAME like '+LikeCnd+')'; //客户名称
      4: LikeCnd:=' and (C.CUST_SPELL like '+LikeCnd+')'; //客户拼音码
      5: LikeCnd:=' and (C.ID_NUMBER like '+LikeCnd+')'; //证件号
      6: LikeCnd:=' and (C.MOVE_TELE like '+LikeCnd+')'; //手机号
      7: LikeCnd:=' and (C.OFFI_TELE like '+LikeCnd+')'; //办公电话
      8: LikeCnd:=' and (C.FAMI_TELE like '+LikeCnd+')'; //家庭电话
    end;
  end;
  CardCnd:=CardCnd+' '+LikeCnd;

  if P1_CB_1.Checked then //充值条件
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    CzStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //续费总额
       ',E.IC_SAL as IC_SAL'+   //消费总额
       ',C.BALANCE as IC_BAL'+  //可用余额
       ',C.IC_STATUS as IC_STATUS'+   //IC卡状态
       ',C.IC_TYPE as IC_TYPE'+       //IC卡类型
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //总积分
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //使用积分
       ',C.INTEGRAL as IC_INTEGRAL'+     //可用积分
       ',''1'' as CX_TYPE'+    //查询类型
       ','' '' as BILL_NUM'+     //单据号
       ',D.GLIDE_MNY as IC_MONEY'+     //单据金额
       ',D.GLIDE_INFO as IC_INFO'+    //摘要(备注)
       ',A.OFFI_TELE as OFFI_TELE'+   //联系电话
       ',A.MOVE_TELE as MOVE_TELE'+   //手机
       ',D.CREA_USER as CREA_USER'+   //单据操作员
       ',B.SHOP_NAME as SHOP_NAME  '+ //所属门店
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''1'' and D.GLIDE_MNY>=0 '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_2.Checked then //退款条件
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    TkStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //续费总额
       ',E.IC_SAL as IC_SAL'+   //消费总额
       ',C.BALANCE as IC_BAL'+  //可用余额
       ',C.IC_STATUS as IC_STATUS'+   //IC卡状态
       ',C.IC_TYPE as IC_TYPE'+       //IC卡类型
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //总积分
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //使用积分
       ',C.INTEGRAL as IC_INTEGRAL'+     //可用积分
       ',''2'' as CX_TYPE'+    //查询类型
       ','' '' as BILL_NUM'+     //单据号
       ',D.GLIDE_MNY as IC_MONEY'+     //单据金额
       ',D.GLIDE_INFO as IC_INFO'+    //摘要(备注)
       ',A.OFFI_TELE as OFFI_TELE'+   //联系电话
       ',A.MOVE_TELE as MOVE_TELE'+   //手机
       ',D.CREA_USER as CREA_USER'+   //单据操作员
       ',B.SHOP_NAME as SHOP_NAME  '+ //所属门店
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''1'' and D.GLIDE_MNY<0 '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_3.Checked then //消费条件
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.SALES_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.SALES_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.SALES_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    SaleStr:=
      'select '+
       ' D.SALES_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //续费总额
       ',E.IC_SAL as IC_SAL'+   //消费总额
       ',C.BALANCE as IC_BAL'+  //可用余额
       ',C.IC_STATUS as IC_STATUS'+   //IC卡状态
       ',C.IC_TYPE as IC_TYPE'+       //IC卡类型
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //总积分
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //使用积分
       ',C.INTEGRAL as IC_INTEGRAL'+     //可用积分
       ',''3'' as CX_TYPE'+    //查询类型
       ',D.GLIDE_NO as BILL_NUM'+     //单据号
       ',D.SALE_MNY as IC_MONEY'+     //单据金额
       ','' '' as IC_INFO '+          //摘要
       ',A.OFFI_TELE as OFFI_TELE'+   //联系电话
       ',A.MOVE_TELE as MOVE_TELE'+   //手机
       ',D.CREA_USER as CREA_USER'+   //单据操作员
       ',B.SHOP_NAME as SHOP_NAME  '+ //所属门店
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_SALESORDER D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.SALES_TYPE in (''1'',''3'',''4'') '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if P1_CB_4.Checked then //退款条件
  begin
    if P1_D1.Date = P1_D2.Date then
      DateCnd:=' and D.CREA_DATE='+FormatDatetime('YYYYMMDD',P1_D1.Date)
    else
      DateCnd:=' and (D.CREA_DATE>='+FormatDatetime('YYYYMMDD',P1_D1.Date)+' and D.CREA_DATE<='+FormatDatetime('YYYYMMDD',P1_D2.Date)+')';

    PayStr:=
      'select '+
       ' D.CREA_DATE as IC_DATE'+
       ',C.IC_CARDNO as IC_CARDNO'+
       ',A.CUST_NAME as CUST_NAME'+
       ',E.IC_REG as IC_REG'+   //续费总额
       ',E.IC_SAL as IC_SAL'+   //消费总额
       ',C.BALANCE as IC_BAL'+  //可用余额
       ',C.IC_STATUS as IC_STATUS'+   //IC卡状态
       ',C.IC_TYPE as IC_TYPE'+       //IC卡类型
       ',C.ACCU_INTEGRAL as ACCU_INTEGRAL'+  //总积分
       ',C.RULE_INTEGRAL as RULE_INTEGRAL'+  //使用积分
       ',C.INTEGRAL as IC_INTEGRAL'+     //可用积分
       ',''4'' as CX_TYPE'+    //查询类型
       ','' '' as BILL_NUM'+     //单据号
       ',D.GLIDE_MNY as IC_MONEY'+     //单据金额
       ',D.GLIDE_INFO as IC_INFO'+    //摘要(备注)
       ',A.OFFI_TELE as OFFI_TELE'+   //联系电话
       ',A.MOVE_TELE as MOVE_TELE'+   //手机
       ',D.CREA_USER as CREA_USER'+   //单据操作员
       ',B.SHOP_NAME as SHOP_NAME  '+ //所属门店
      ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,SAL_IC_GLIDE D,('+CardSumTab+')E '+
      ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
        ' and A.TENANT_ID=D.TENANT_ID and A.CUST_ID=D.CLIENT_ID and A.CUST_ID=E.CLIENT_ID '+
        ' and D.IC_GLIDE_TYPE=''2'' '+CardCnd+' '+DateCnd;
    i:=i+1;
  end;
  if i>1 then
  begin
    ViwTab:='';
    if (P1_CB_1.Checked) and (trim(CzStr)<>'') then
      ViwTab:=CzStr;
    if (P1_CB_2.Checked) and (trim(TkStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=TkStr
      else
        ViwTab:=ViwTab + ' union all '+ TkStr;
    end;
    if (P1_CB_3.Checked) and (trim(SaleStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=SaleStr
      else
        ViwTab:=ViwTab + ' union all '+ SaleStr;
    end;
    if (P1_CB_4.Checked) and (trim(PayStr)<>'') then
    begin
      if trim(ViwTab)='' then
        ViwTab:=PayStr
      else
        ViwTab:=ViwTab + ' union all '+ PayStr;
    end;   
    result:='select * from ('+ViwTab+')tp order by IC_CARDNO';
  end else
  begin
    if P1_CB_1.Checked then
      result:=CzStr+' order by C.IC_CARDNO'
    else if P1_CB_2.Checked then
      result:=TkStr+' order by C.IC_CARDNO'
    else if P1_CB_3.Checked then
      result:=SaleStr+' order by C.IC_CARDNO'
    else if P1_CB_4.Checked then
      result:=PayStr+' order by C.IC_CARDNO';
  end;
  result:=ParseSQL(Factor.iDbType,result);
end;

function TfrmCustCardReport.GetCustCardSumSQL: string;
var
  DateCnd: string;    
  SumTab: string;
  CardCnd: string;
  CardSumTab: string;
begin
  DateCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('开始日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('开始日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能小于开始日期...');
  //卡条件
  CardCnd:=' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+GetDataRight;

  //门店条件
  if trim(fndP2_SHOP_ID.AsString)<>'' then
    DateCnd:=' and SHOP_ID='''+trim(fndP2_SHOP_ID.AsString)+''' ';
  
  if P1_D1.Date = P1_D2.Date then   
  begin
    CardCnd:=CardCnd+' and C.CREA_DATE='''+FormatDatetime('YYYY-MM-DD',P2_D1.Date)+''' ';
    DateCnd:=DateCnd+' and CREA_DATE='+FormatDatetime('YYYYMMDD',P2_D1.Date);
  end else
  begin
    CardCnd:=CardCnd+' and (C.CREA_DATE>='''+FormatDatetime('YYYY-MM-DD',P2_D1.Date)+''' and CREA_DATE<='''+FormatDatetime('YYYY-MM-DD',P2_D2.Date)+''')';
    DateCnd:=DateCnd+' and (CREA_DATE>='+FormatDatetime('YYYYMMDD',P2_D1.Date)+' and CREA_DATE<='+FormatDatetime('YYYYMMDD',P2_D2.Date)+')';
  end;

  //卡汇总的Viw
  CardSumTab:=
    'select CLIENT_ID,'+
      'sum(case when IC_GLIDE_TYPE=''1'' then GLIDE_MNY else 0 end) as IC_REG,'+
      'sum(isnull(PAY_A,0)+isnull(PAY_B,0)+isnull(PAY_C,0)+isnull(PAY_D,0)+isnull(PAY_E,0)+isnull(PAY_F,0)+isnull(PAY_G,0)+isnull(PAY_H,0)+isnull(PAY_I,0)+isnull(PAY_J,0))as IC_SHISHOU,'+
      'sum(case when IC_GLIDE_TYPE=''2'' then GLIDE_MNY else 0 end) as IC_SAL '+
    ' from SAL_IC_GLIDE where TENANT_ID='+IntToStr(Global.TENANT_ID)+DateCnd+' group by CLIENT_ID ';
  CardSumTab:=ParseSQL(Factor.iDbType,CardSumTab);

  //门店群组
  if trim(fndP2_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP2_SHOP_TYPE.ItemIndex of
     0:
      begin
        if FnString.TrimRight(trim(fndP2_SHOP_VALUE.AsString),2)='00' then //非末级区域
          CardCnd:=CardCnd+' and B.REGION_ID like '''+GetRegionId(fndP2_SHOP_VALUE.AsString)+'%'' '
        else
          CardCnd:=CardCnd+' and B.REGION_ID='''+fndP2_SHOP_VALUE.AsString+''' ';
      end;
     1: CardCnd:=CardCnd+' and B.SHOP_TYPE='''+fndP2_SHOP_VALUE.AsString+''' ';
    end;
  end;
  //门店条件
  if trim(fndP2_SHOP_ID.AsString)<>'' then
    CardCnd:=CardCnd+' and B.SHOP_ID='''+trim(fndP2_SHOP_ID.AsString)+''' ';
  //卡类型
  if fndP1_IC_TYPE.ItemIndex>0 then
    CardCnd:=CardCnd+' and C.IC_TYPE='''+TRecord_(fndP1_IC_TYPE.Properties.Items.Objects[fndP1_IC_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //组SQL:
  SumTab:=
    'select C.TENANT_ID,C.IC_TYPE as IC_TYPE '+    //卡类型
     ',C.UNION_ID as UNION_ID '+       //商盟编号<不是商盟卡时，为#>
     ',count(*) as IC_CARD_AMT '+      //开卡数量
     ',sum(E.IC_REG) as IC_IN_MNY '+   //存入金额
     ',sum(E.IC_SHISHOU) as IC_SHI_MNY '+  //实收金额
     ',sum(E.IC_REG-E.IC_SHISHOU) as IC_AGO_MNY '+   //优惠金额
     ',sum(E.IC_SAL) as IC_SAL_MNY '+   //消费金额
    ' from PUB_CUSTOMER A,PUB_IC_INFO C,CA_SHOP_INFO B,('+CardSumTab+')E '+
    ' where A.TENANT_ID=C.TENANT_ID and A.CUST_ID=C.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and '+
    ' C.CLIENT_ID=E.CLIENT_ID '+CardCnd+
    ' group by C.TENANT_ID,C.IC_TYPE,C.UNION_ID ';
  //关联查询
  SumTab:=
    'select (case when tp.UNION_ID<>''#'' then UN.UNION_NAME else CT.CODE_NAME end) as IC_CARD_NAME,'+
    ' tp.* from ('+SumTab+')tp '+
    ' left outer join PUB_UNION_INFO UN on tp.TENANT_ID=UN.TENANT_ID and tp.UNION_ID=UN.UNION_ID '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''IC_TYPE'')CT on tp.IC_TYPE=CT.CODE_ID '+
    ' order by tp.IC_TYPE,UN.UNION_NAME';

  result:=ParseSQL(Factor.iDbType,SumTab);
end;

end.
