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
    Label32: TLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    fndP2_DEPT_ID: TzrComboBoxList;
    RzPanel20: TRzPanel;
    DBGridEh2: TDBGridEh;
    P1_DateControl: TfrmDateControl;
    P2_DateControl: TfrmDateControl;
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
    //���ػ�Ա����ϸ�˲�ѯ
    function GetCustCardDetailSQL: string;
    //���ػ�Ա����ϸ�˲�ѯ
    function GetCustCardSumSQL: string;

    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    //����Page��ҳ��ʾ:��IsGroupReport�Ƿ����[�����ŵ�]��
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function  GetDataRight: string;
  public
    procedure SingleReportParams(ParameStr: string='');override; //�򵥱�����ò���
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property DataRight: string read GetDataRight; //���ز鿴����Ȩ��
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

  SetRzPageActivePage; //����PzPage.Activepage
  RefreshColumn;

  //2011.04.22 Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']);
    SetNotShowCostPrice(DBGridEh2, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
  begin
    Label5.Caption := '�ֿ�Ⱥ��';
    Label23.Caption := '�ֿ�Ⱥ��';
  end;


  //2011.09.21 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.SALE_TTL','DBGridEh1.SALE_TAX','DBGridEh1.SALE_MNY','DBGridEh1.SALE_CST','DBGridEh1.SALE_ALLPRF','DBGridEh1.SALE_PRF',
                              'DBGridEh2.SALE_TTL','DBGridEh2.SALE_TAX','DBGridEh2.SALE_MNY','DBGridEh2.SALE_CST','DBGridEh2.SALE_ALLPRF','DBGridEh2.SALE_PRF',
                              'DBGridEh3.SALE_TTL','DBGridEh3.SALE_TAX','DBGridEh3.SALE_MNY','DBGridEh3.SALE_CST','DBGridEh3.SALE_ALLPRF','DBGridEh3.SALE_PRF',
                              'DBGridEh4.SALE_TTL','DBGridEh4.SALE_TAX','DBGridEh4.SALE_MNY','DBGridEh4.SALE_CST','DBGridEh4.SALE_ALLPRF','DBGridEh4.SALE_PRF',
                              'DBGridEh5.SALE_TTL','DBGridEh5.SALE_TAX','DBGridEh5.SALE_MNY','DBGridEh5.SALE_CST','DBGridEh5.SALE_ALLPRF','DBGridEh5.SALE_PRF',
                              'DBGridEh6.AMONEY','DBGridEh6.NOTAX_MONEY','DBGridEh6.TAX_MONEY','DBGridEh6.AGIO_MONEY','DBGridEh6.COST_MONEY','DBGridEh6.PROFIT_MONEY','DBGridEh6.AVG_PROFIT']);
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
    0: begin //��Ա����ϸ�˱���
        if adoReport1.Active then adoReport1.Close;
        strSql := GetCustCardDetailSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //��Ա��ͳ��
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

function TfrmCustCardReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  inherited AddReportReport(TitleList,PageNo);
end;


procedure TfrmCustCardReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CODE_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmCustCardReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmCustCardReport.SetRzPageActivePage(IsGroupReport: Boolean);
var
  i: integer;
  IsVisble: Boolean;
  Rs: TZQuery;
begin
  Rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if Rs<>nil then
  begin
    try
      Rs.Filtered:=false;
      Rs.Filter:='DEPT_TYPE=1';
      Rs.Filtered:=true;
      rzPage.Pages[0].TabVisible:=(Rs.RecordCount>1);  //���Ӫ����ʱ��ʾ
    finally
      Rs.Filtered:=false;
      Rs.Filter:='';
    end;
  end;

  IsVisble:=HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
  rzPage.Pages[1].TabVisible := IsVisble;
  rzPage.Pages[2].TabVisible := IsVisble;
  for i:=0 to rzPage.PageCount-1 do
  begin
    if rzPage.Pages[i].TabVisible then
    begin
      rzPage.ActivePageIndex:=i;
      break;
    end;
  end; 
end;

procedure TfrmCustCardReport.SingleReportParams(ParameStr: string);
begin

end;

function TfrmCustCardReport.GetDataRight: string;
begin
  //�����ݣ�RCK_C_GOODS_DAYS��VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

function TfrmCustCardReport.GetCustCardDetailSQL: string;
begin

end;

function TfrmCustCardReport.GetCustCardSumSQL: string;
begin

end;

end.
