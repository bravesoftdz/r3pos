unit ufrmRecvAbleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox, RzChkLst,
  RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh, cxCalendar, cxButtonEdit,
  cxCheckBox, zbase, zrComboBoxList, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cxRadioGroup;

type
  TfrmRecvAbleReport = class(TframeBaseReport)
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
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
    dsadoReport4: TDataSource;
    Label5: TLabel;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    Label10: TLabel;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    Label11: TLabel;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    Label9: TLabel;
    adoReport2: TZQuery;
    adoReport3: TZQuery;
    adoReport4: TZQuery;
    fndP3_SHOP_ID: TzrComboBoxList;
    TabSheet5: TRzTabSheet;
    RzPanel13: TRzPanel;
    Panel6: TPanel;
    RzPanel14: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    Label12: TLabel;
    Label3: TLabel;
    P5_D1: TcxDateEdit;
    P5_D2: TcxDateEdit;
    RzBitBtn3: TRzBitBtn;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    fndP5_SHOP_ID: TzrComboBoxList;
    RzPanel15: TRzPanel;
    DBGridEh5: TDBGridEh;
    RzPanel16: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel10: TRzLabel;
    Label4: TLabel;
    Label6: TLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    RzBitBtn4: TRzBitBtn;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    fndP4_SHOP_ID: TzrComboBoxList;
    RzPanel17: TRzPanel;
    DBGridEh4: TDBGridEh;
    adoReport5: TZQuery;
    dsadoReport5: TDataSource;
    Label7: TLabel;
    fndP5_USER_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
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
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    IsOnDblClick: Boolean;  //是双击DBGridEh标记位

    //按管理收款汇总表
    function GetGroupSQL(chk:boolean=true): string;
    //按门店收款汇总表
    function GetShopSQL(chk:boolean=true): string;
    //按日期分类汇总表
    function GetRecvDaySQL(chk:boolean=true): string;
    //按制单人分类汇总表
    function GetRecvUserSQL(chk:boolean=true): string;
    //应收款流水
    function GetRecvGlideSQL(chk:boolean=true): string;

    function GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string; //返回门店查询条件
    function GetDateCnd(BegDate,EndDate: TcxDateEdit; FieldName: string): string;  //时间条件
    function GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string; //门店所属行政区域|门店类型:
    //初始化DBGrid
    procedure InitGrid;
    function  AddReportReport(TitleList: TStringList; PageNo: string): string; override; //添加Title
    function  GetDataRight: string; //返回查看数据权限
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    property  DataRight: string read GetDataRight; //返回查看数据权限
  end;

implementation
uses uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon,
  ufrmCostCalc;
{$R *.dfm}

procedure TfrmRecvAbleReport.FormCreate(Sender: TObject);
begin
  inherited;
  IsOnDblClick:=False;
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

  SetRzPageActivePage; //设置PzPage.Activepage

  InitGrid;
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

    fndP5_SHOP_ID.Properties.ReadOnly := False;
    fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP5_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,fndP5_SHOP_ID.Style);
    fndP5_SHOP_ID.Properties.ReadOnly := True;
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库群组';
      Label10.Caption := '仓库群组';

      Label11.Caption := '仓库群组';
      Label9.Caption := '仓库名称';

      Label4.Caption := '仓库群组';
      Label6.Caption := '仓库名称';

      Label12.Caption := '仓库群组';
      Label3.Caption := '仓库名称';
    end;
end;

function TfrmRecvAbleReport.GetGroupSQL(chk:boolean=true): string;
var
  strSql: string;
begin
  if P1_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //按根据条件门店汇总:
  strSql:=
     'select B.REGION_ID as REGION_ID'+
     ',sum(ACCT_MNY) as ACCT_MNY '+
     ',sum(RECV_MNY) as RECV_MNY '+
     ',sum(RECK_MNY) as RECK_MNY '+
     ',sum(REVE_MNY) as REVE_MNY '+
     ' from ACC_RECVABLE_INFO A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P1_D1,P1_D2,'ABLE_DATE')+' '+GetDataRight+
     ' '+GetShopGroupCnd(fndP1_SHOP_TYPE,fndP1_SHOP_VALUE,'')+' '+
     ' group by B.REGION_ID ';

  //关联
  strSql:=
    'select jp.*,isnull(r.CODE_NAME,''无'') as CODE_NAME from  ('+strSql+') jp '+
    ' left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''8'' and TENANT_ID=0) r '+
    ' on jp.REGION_ID=r.CODE_ID order by jp.REGION_ID ';

  Result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmRecvAbleReport.GetRowType: integer;
begin
  result :=0;  // DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger;
end;

procedure TfrmRecvAbleReport.actFindExecute(Sender: TObject);
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
        strSql := GetRecvDaySQL;
        if strSql='' then Exit;
        adoReport3.SQL.Text := strSql;
        Factor.Open(adoReport3);
      end;
    3: begin //按商品汇总表
        if adoReport4.Active then adoReport4.Close;
        strSql := GetRecvUserSQL;
        if strSql='' then Exit;
        adoReport4.SQL.Text := strSql;
        Factor.Open(adoReport4);
      end;
    4: begin //按商品汇总表
        if adoReport5.Active then adoReport5.Close;
        strSql := GetRecvGlideSQL;
        if strSql='' then Exit;
        adoReport5.SQL.Text := strSql;
        Factor.Open(adoReport5);
      end;
  end;
end;

function TfrmRecvAbleReport.GetShopSQL(chk:boolean=true): string;
var
  strSql: string;
begin
  if P2_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //按根据条件门店汇总:
  strSql:=
     'select A.TENANT_ID as TENANT_ID,A.SHOP_ID as SHOP_ID'+
     ',sum(ACCT_MNY) as ACCT_MNY '+
     ',sum(RECV_MNY) as RECV_MNY '+
     ',sum(RECK_MNY) as RECK_MNY '+
     ',sum(REVE_MNY) as REVE_MNY '+
     ' from ACC_RECVABLE_INFO A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P2_D1,P2_D2,'ABLE_DATE')+' '+GetDataRight+
     ' '+GetShopGroupCnd(fndP2_SHOP_TYPE,fndP2_SHOP_VALUE,'')+' '+
     ' group by A.TENANT_ID,A.SHOP_ID ';

  //关联
  strSql:=
    'select jp.*,r.SEQ_NO as SHOP_CODE,r.SHOP_NAME as SHOP_NAME '+
    ' from ('+strSql+')jp '+
    ' left outer join CA_SHOP_INFO r '+
    ' on jp.TENANT_ID=r.TENANT_ID and jp.SHOP_ID=r.SHOP_ID order by r.SEQ_NO ';
 
  Result := ParseSQL(Factor.iDbType, strSql);
end;

function TfrmRecvAbleReport.GetRecvDaySQL(chk:boolean=true): string;
var
  strSql, strWhere: string;
begin
  if P3_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  strSql:=
     'select ABLE_DATE as RECV_DATE '+
     ',sum(ACCT_MNY) as ACCT_MNY '+
     ',sum(RECV_MNY) as RECV_MNY '+
     ',sum(RECK_MNY) as RECK_MNY '+
     ',sum(REVE_MNY) as REVE_MNY '+
     ' from ACC_RECVABLE_INFO A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P3_D1,P3_D2,'ABLE_DATE')+' '+GetDataRight+
     ' '+GetShopIDCnd(fndP3_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP3_SHOP_TYPE,fndP3_SHOP_VALUE,'')+' '+
     ' group by ABLE_DATE ';

  Result := ParseSQL(Factor.iDbType,strSql);
end;

function TfrmRecvAbleReport.GetRecvGlideSQL(chk:boolean=true): string;
var
  strSql,strWhere: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P5_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P5_D1.Date > P5_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');

  //按根据条件门店查询:
  strSql:=
     'select A.TENANT_ID as TENANT_ID'+
     ',ABLE_DATE'+
     ',CLIENT_ID'+
     ',RECV_TYPE'+
     ',ACCT_INFO'+
     ',ACCT_MNY'+
     ',RECV_MNY'+
     ',RECK_MNY'+
     ',REVE_MNY'+
     ',NEAR_DATE'+
     ',CREA_USER'+
     ',B.SHOP_NAME as SHOP_ID_TEXT '+
     ' from ACC_RECVABLE_INFO A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+
     ' '+GetDateCnd(P5_D1,P5_D2,'ABLE_DATE')+' '+GetDataRight+
     ' '+GetShopIDCnd(fndP5_SHOP_ID,'A.SHOP_ID')+
     ' '+GetShopGroupCnd(fndP5_SHOP_TYPE,fndP5_SHOP_VALUE,'')+' ';

  //关联
  strSql:=
    'select jb.*,D.CLIENT_NAME from ('+strSql+') jb '+
    ' left outer join VIW_CUSTOMER D on jb.TENANT_ID=D.TENANT_ID and jb.CLIENT_ID=D.CLIENT_ID '+
    ' order by jb.ABLE_DATE ';
  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmRecvAbleReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P2_D1.Date:=P1_D1.Date;
  P2_D2.Date:=P1_D2.Date;
  fndP2_SHOP_TYPE.ItemIndex:=0;
  fndP2_SHOP_VALUE.KeyValue:=trim(adoReport1.fieldbyName('REGION_ID').AsString);
  fndP2_SHOP_VALUE.Text:=trim(adoReport1.fieldbyName('CODE_NAME').AsString);
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmRecvAbleReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',2,3); //管理群组
  fndP3_SHOP_ID.KeyValue:=trim(adoReport2.fieldbyName('SHOP_ID').AsString);
  fndP3_SHOP_ID.Text:=trim(adoReport2.fieldbyName('SHOP_NAME').AsString);
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmRecvAbleReport.DBGridEh3DblClick(Sender: TObject);
begin
  inherited;
  if adoReport3.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P4_D1.Date:=fnTime.fnStrtoDate(adoReport3.fieldbyName('RECV_DATE').AsString);
  P4_D2.Date:=P4_D1.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4); //管理群组
  Copy_ParamsValue(fndP3_SHOP_ID,fndP4_SHOP_ID); //门店名称
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmRecvAbleReport.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmRecvAbleReport.InitGrid;
  procedure InitGridColums(Rs: TDataSet; Grid: TDBGridEh);
  var
    i: integer;
    ColName: string;
  begin
    for i:=Grid.Columns.Count-1 downto 0 do
    begin
      if trim(Grid.Columns[i].FieldName)='PAY_ALL' then continue;
      if Copy(trim(Grid.Columns[i].FieldName),1,4)='PAY_' then
      begin
        Grid.Columns[i].Width := 55;
        ColName:=Copy(trim(Grid.Columns[i].FieldName),5,1);
        if Rs.Locate('CODE_ID',ColName,[]) then  //定位到修改: Title.Caption
          Grid.Columns[i].Title.Caption:='其中|'+rs.FieldbyName('CODE_NAME').AsString
        else
          Grid.Columns.Delete(i);
      end;
    end;
  end;
var
  rs: TZQuery;
  Column: TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_PAYMENT');
  if not rs.Active then Exit;

  InitGridColums(Rs,DBGridEh1);
  InitGridColums(Rs,DBGridEh2);
  InitGridColums(Rs,DBGridEh3);
  InitGridColums(Rs,DBGridEh4);
end;

procedure TfrmRecvAbleReport.PrintBefore;
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
    end;
    ReStr:=FormatReportHead(Title,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
  finally
    Title.Free;
  end;
end;

function TfrmRecvAbleReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //日期
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('收款日期：'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' 至 '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


function TfrmRecvAbleReport.GetShopIDCnd(ShopID: TzrComboBoxList; FieldName: string): string;
begin
  result:='';
  if ShopID.AsString<>'' then
    result:=' and '+FieldName+'='''+ShopID.AsString+''' ';
end;

function TfrmRecvAbleReport.GetDateCnd(BegDate, EndDate: TcxDateEdit; FieldName: string): string;
begin
  result:='';
  if BegDate.Date=EndDate.Date then
    result:=' and ('+FieldName+'='+FormatDatetime('YYYYMMDD',BegDate.Date)+')'
  else
    result:=' and ('+FieldName+'>='+FormatDatetime('YYYYMMDD',BegDate.Date)+' and '+FieldName+'<='+FormatDatetime('YYYYMMDD',EndDate.Date)+')';
end;



function TfrmRecvAbleReport.GetShopGroupCnd(SHOP_TYPE: TcxComboBox; TYPE_VALUE: TzrComboBoxList; AliasName: string): string;
var
  AName: string;
begin
  result:='';
  AName:='';
  if trim(AliasName)<>'' then AName:=trim(AliasName)+'.';
  if TYPE_VALUE.AsString<>'' then
  begin
    case SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(TYPE_VALUE.AsString),2)='00' then //非末级区域
           result:=' and '+AName+'REGION_ID like '''+GetRegionId(TYPE_VALUE.AsString)+'%'' '
         else
           result:=' and '+AName+'REGION_ID='''+TYPE_VALUE.AsString+''' ';
       end;
      1: result:=' and '+AName+'SHOP_TYPE='''+TYPE_VALUE.AsString+''' ';
    end;
  end;
end;

function TfrmRecvAbleReport.GetRecvUserSQL(chk: boolean): string;
var
  strSql, strWhere: string;
begin
  if P4_D1.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D2.EditValue = null then Raise Exception.Create('收款日期条件不能为空');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('结束日期不能大于开始日期');
  //过滤企业ID:
  strWhere:=' and A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' '+GetDataRight;

  //门店名称:
  strWhere:=strWhere+GetShopIDCnd(fndP4_SHOP_ID,'A.SHOP_ID');

  //查询时间条件
  strWhere:=strWhere+GetDateCnd(P4_D1,P4_D2,'ABLE_DATE');

  //门店管理群组
  strWhere:=strWhere+GetShopGroupCnd(fndP4_SHOP_TYPE,fndP4_SHOP_VALUE,'');

  strSql:=
     'select A.TENANT_ID as TENANT_ID '+
     ',A.CREA_USER as CREA_USER '+   //制单人
     ',sum(ACCT_MNY) as ACCT_MNY '+  //账款金额
     ',sum(RECV_MNY) as RECV_MNY '+  //已结算金额
     ',sum(RECK_MNY) as RECK_MNY '+  //未结算金额
     ',sum(REVE_MNY) as REVE_MNY '+  //冲账金额
     ' from ACC_RECVABLE_INFO A,CA_SHOP_INFO B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
     ' '+strWhere+
     ' group by A.TENANT_ID,A.CREA_USER ';

  //关联操作员:
  strSql :=
    ' select j.*,r.ACCOUNT as ACCOUNT,r.USER_NAME  as USER_NAME from ('+strSql+') j '+
    ' left outer join viw_users r on '+
    ' j.TENANT_ID=r.TENANT_ID and j.CREA_USER=r.USER_ID order by r.ACCOUNT ';  

  Result := ParseSQL(Factor.iDbType,strSql);
end;

procedure TfrmRecvAbleReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.IsEmpty then Exit;
  IsOnDblClick:=true; //设置标记位
  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',4,5); //管理群组
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID); //管理群组
  if RzPage.ActivePageIndex+1<=RzPage.PageCount then
  begin
    RzPage.ActivePageIndex:=RzPage.ActivePageIndex+1;
    actFind.OnExecute(nil);
  end;
end;

procedure TfrmRecvAbleReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'SHOP_NAME' then Text := '合计:'+Text+'笔'; 
end;

procedure TfrmRecvAbleReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'RECV_DATE' then Text := '合计:'+Text+'笔'; 
end;

procedure TfrmRecvAbleReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'USER_NAME' then Text := '合计:'+Text+'笔'; 
end;

procedure TfrmRecvAbleReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '合计:'+Text+'笔'; 
end;

procedure TfrmRecvAbleReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '合计:'+Text+'笔';  
end;

function TfrmRecvAbleReport.GetDataRight: string;
begin
  //ACC_RECVABLE_INFO A
  result:=' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.

